#!/usr/bin/env python3
"""
Fix RT scope system:

1. Add scope attachment slot [1] to Kar98k, Arisaka, Enfield, Mosin, Springfield
2. Fix Arisaka scope VElement (add scope_default pointing to arisaka scope model)
3. Rewrite all 7 scope attachments with correct RT implementation:
   - CreateMaterial for unique RT lens
   - Override scope VElement's material field
   - Set ScopeTexture = created material
   - Initialize RenderTarget
   - Set ScopeFov, ZoomFov, Sensitivity
   - Do NOT set Use2DScope (no 2D overlay)
   - Add IronSightsPos/Ang override in WeaponTable
4. Fix the generic scope attachment (tfa_codww2_scope.lua) to be a proper
   weapon-agnostic scope that works with the CreateMaterial approach
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"
ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

# Weapons that need slot [1] added
SNIPERS_NEEDING_SLOT = {
    'kate_kar98k.lua': {
        'scope_att': 'tfa_codww2_kar98k_scope',
        'scope_velement': 'scope_default',
    },
    'kate_arisaka.lua': {
        'scope_att': 'tfa_codww2_arisaka_scope',
        'scope_velement': 'scope_acog',  # Arisaka only has scope_acog, not scope_default
    },
    'kate_enfield.lua': {
        'scope_att': 'tfa_codww2_enfield_scope',
        'scope_velement': 'scope_default',
    },
    'kate_mosin.lua': {
        'scope_att': 'tfa_codww2_mosin_scope',
        'scope_velement': 'scope_default',
    },
    'kate_springfield.lua': {
        'scope_att': 'tfa_codww2_springfield_scope',
        'scope_velement': 'scope_default',
    },
}

# Arisaka needs a scope_default VElement added
ARISAKA_SCOPE_MODEL = "models/weapons/tfa_codww2/arisaka/c_arisaka_scope.mdl"
ARISAKA_WSCOPE_MODEL = "models/weapons/tfa_codww2/arisaka/w_arisaka_scope.mdl"


def add_scope_slot(filepath, scope_att, scope_velement):
    """Add slot [1] for scope attachment to a sniper weapon."""
    with open(filepath) as f:
        content = f.read()

    # Check if slot [1] already exists
    if re.search(r'\[1\]\s*=\s*\{.*name.*atts', content):
        return False  # already has slot [1]

    # Add slot [1] before the existing [2] slot
    new_slot = f'''    [1] = {{ name = "Optic", atts = {{ "{scope_att}", "tfa_codww2_4x" }}, default = 0 }},
'''
    
    # Insert before [2] = {
    content = re.sub(
        r'(\[2\]\s*=\s*\{)',
        new_slot + r'\1',
        content,
        count=1
    )

    with open(filepath, 'w') as f:
        f.write(content)
    return True


def add_scope_default_velement(filepath, scope_model, wscope_model):
    """Add scope_default VElement to a weapon that's missing it."""
    with open(filepath) as f:
        content = f.read()

    # Check if scope_default already exists in ViewModelElements
    if '"scope_default"' in content.split('SWEP.ViewModelElements')[1].split('SWEP.WorldModelElements')[0]:
        return False  # already has it

    # Add scope_default before scope_acog in ViewModelElements
    new_velement = f'''    ["scope_default"] = {{
        type = "Model", model = "{scope_model}",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {{}}, bonemerge = true,
        active = false, _defaultActive = false,
    }},
'''

    # Insert before ["scope_acog"] in ViewModelElements
    content = content.replace(
        '    ["scope_acog"] = {',
        new_velement + '    ["scope_acog"] = {',
        1
    )

    # Also add to WorldModelElements
    new_welement = f'''    ["scope_default"] = {{
        type = "Model", model = "{wscope_model}",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {{}}, bonemerge = true,
        active = false, _defaultActive = false,
    }},
'''

    # Find WorldModelElements and insert before scope_acog there too
    # Split at WorldModelElements
    parts = content.split('SWEP.WorldModelElements')
    if len(parts) > 1:
        wm_section = parts[1]
        if '"scope_acog"' in wm_section and '"scope_default"' not in wm_section[:wm_section.find('}')]:
            wm_section = wm_section.replace(
                '    ["scope_acog"] = {',
                new_welement + '    ["scope_acog"] = {',
                1
            )
            content = parts[0] + 'SWEP.WorldModelElements' + wm_section

    with open(filepath, 'w') as f:
        f.write(content)
    return True


# ============================================================
# RT SCOPE ATTACHMENT TEMPLATE
# ============================================================
def write_scope_attachment(filepath, name, velement, scope_fov, zoom_fov):
    """Write a proper RT scope attachment using CreateMaterial."""
    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{name}"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {{
    Color(255, 255, 255), "{name}",
    Color(255, 100, 100), "+25% Zoom time",
}}

ATTACHMENT.WeaponTable = {{
    ["VElements"] = {{
        ["{velement}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velement}"] = {{ ["active"] = true }},
    }},
    ["ScopeFov"] = {scope_fov},
    ["ZoomFov"] = {zoom_fov},
    ["Sensitivity"] = 0.2,
}}

function ATTACHMENT:Attach(wep)
    -- Create a unique RT material for this weapon instance.
    -- The RenderScene hook will assign the RenderTarget to this material's
    -- $basetexture, and the scope VElement's lens mesh will display the RT view.
    if CLIENT then
        local matName = "kate_scope_rt_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {{
            ["$basetexture"] = "vgui/scope_lens",
            ["$model"] = "1",
            ["$translucent"] = "1",
        }})
        wep.ScopeTexture = mat

        -- Override the scope VElement's material so the lens mesh uses our RT material.
        -- The VElement's DrawVElements calls model:SetMaterial() every frame.
        if wep.ViewModelElements and wep.ViewModelElements["{velement}"] then
            wep.ViewModelElements["{velement}"]._original_material = wep.ViewModelElements["{velement}"].material
            wep.ViewModelElements["{velement}"].material = matName
        end

        -- Initialize the RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = {{ 256, 512, 768, 1080 }}
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- Re-init VElements so the material override takes effect
        if wep.CleanupVElements then wep:CleanupVElements() end
        if wep.InitVElements then wep:InitVElements() end
    end

    -- Configure scope parameters
    wep.ScopeFov = {scope_fov}
    wep.ZoomFov = {zoom_fov}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false  -- NO 2D overlay — pure RT on the lens
end

function ATTACHMENT:Detach(wep)
    -- Disable RT scope
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false

    -- Restore the scope VElement's original material
    if wep.ViewModelElements and wep.ViewModelElements["{velement}"] then
        if wep.ViewModelElements["{velement}"]._original_material ~= nil then
            wep.ViewModelElements["{velement}"].material = wep.ViewModelElements["{velement}"]._original_material
            wep.ViewModelElements["{velement}"]._original_material = nil
        end
    end

    -- Re-init VElements to restore original material
    if CLIENT then
        if wep.CleanupVElements then wep:CleanupVElements() end
        if wep.InitVElements then wep:InitVElements() end
    end
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


def main():
    print("=== FIX 1: Add scope slot [1] to snipers ===\n")
    for filename, config in SNIPERS_NEEDING_SLOT.items():
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        if add_scope_slot(filepath, config['scope_att'], config['scope_velement']):
            print(f"  {filename}: added slot [1] with {config['scope_att']}")
        else:
            print(f"  {filename}: already has slot [1]")

    print("\n=== FIX 2: Add scope_default VElement to Arisaka ===\n")
    arisaka_path = os.path.join(WEAPONS_DIR, 'kate_arisaka.lua')
    if add_scope_default_velement(arisaka_path, ARISAKA_SCOPE_MODEL, ARISAKA_WSCOPE_MODEL):
        print("  kate_arisaka.lua: added scope_default VElement")
    else:
        print("  kate_arisaka.lua: scope_default already exists or not needed")

    print("\n=== FIX 3: Rewrite scope attachments with true RT system ===\n")
    
    scopes = [
        ('tfa_codww2_kar98k_scope.lua', 'Kar98k Scope', 'scope_default', 7, 15),
        ('tfa_codww2_arisaka_scope.lua', 'Arisaka Scope', 'scope_default', 7, 15),
        ('tfa_codww2_enfield_scope.lua', 'Enfield Scope', 'scope_default', 7, 15),
        ('tfa_codww2_mosin_scope.lua', 'Mosin Scope', 'scope_default', 7, 15),
        ('tfa_codww2_springfield_scope.lua', 'Springfield Scope', 'scope_default', 7, 15),
        ('tfa_codww2_scope.lua', '7x Scope', 'scope_default', 7, 15),
        ('tfa_codww2_4x.lua', '4x ACOG', 'scope_acog', 15, 25),
    ]
    
    for fname, name, velem, sf, zf in scopes:
        filepath = os.path.join(ATT_DIR, fname)
        write_scope_attachment(filepath, name, velem, sf, zf)
        print(f"  {fname}: RT scope (CreateMaterial + VElement material override)")


if __name__ == '__main__':
    main()
