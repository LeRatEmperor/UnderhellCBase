#!/usr/bin/env python3
"""
Fix 4 attachment issues:
1. Convert TFA nested Animations {type=1, value="seq"} to flat string "seq"
2. Fix RT scopes — scope attachments set ScopeTexture + Use2DScope + IronSightsPos
3. Remove grenade launcher attachments from all weapons
4. Fix silencer — Attach/Detach toggle Silenced NW bool
"""
import os
import re
import glob

ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"
WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# ============================================================
# FIX 1: Convert TFA nested Animations to flat strings
# ============================================================
def fix_nested_animations(filepath):
    with open(filepath) as f:
        content = f.read()
    
    # Pattern: ["key"] = { ["type"] = 1, ["value"] = "seq_name", }
    # Replace with: ["key"] = "seq_name",
    pattern = re.compile(
        r'\["(\w+)"\]\s*=\s*\{\s*\["type"\]\s*=\s*\d+\s*,\s*\["value"\]\s*=\s*"([^"]+)"\s*,?\s*\}',
        re.DOTALL
    )
    
    new_content = pattern.sub(r'["\1"] = "\2"', content)
    
    if new_content != content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        return True
    return False


# ============================================================
# FIX 2: Fix RT scope attachments
# ============================================================
SCOPE_ATTACHMENTS = {
    'tfa_codww2_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
    'tfa_codww2_4x.lua': {
        'velement': 'scope_acog',
        'scope_fov': 15,
        'zoom_fov': 25,
        'iron_sight_time_mult': 1.15,
    },
    'tfa_codww2_arisaka_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
    'tfa_codww2_enfield_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
    'tfa_codww2_kar98k_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
    'tfa_codww2_mosin_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
    'tfa_codww2_springfield_scope.lua': {
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
        'iron_sight_time_mult': 1.25,
    },
}


def fix_scope_attachment(filepath, config):
    """Rewrite scope attachment to properly configure RT scope."""
    velem = config['velement']
    scope_fov = config['scope_fov']
    zoom_fov = config['zoom_fov']
    ist_mult = config['iron_sight_time_mult']
    
    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "7x Scope"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {{
    Color(255, 255, 255), "7x Zoom",
    Color(255, 100, 100), "+25% Zoom time",
    Color(255, 100, 100), "-5% ADS Movespeed",
}}

ATTACHMENT.WeaponTable = {{
    ["VElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["ScopeFov"] = {scope_fov},
    ["ZoomFov"] = {zoom_fov},
    ["IronSightTime"] = function(wep, val) return val * {ist_mult} end,
    ["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}}

function ATTACHMENT:Attach(wep)
    -- Enable RT scope rendering
    wep.ScopeFov = {scope_fov}
    wep.ZoomFov = {zoom_fov}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = true
    -- Set scope texture if not already set
    if not wep.ScopeTexture then
        wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    end
    -- Initialize RT if not already done
    if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = {{ 256, 512, 768, 1080 }}
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        wep.RT_Size = quality[num] * scale
        wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
    end
end

function ATTACHMENT:Detach(wep)
    -- Disable RT scope
    wep.ScopeDisabled = true
    wep.Use2DScope = false
    wep.Sensitivity = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


def fix_4x_scope(filepath):
    """Fix the 4x ACOG scope."""
    content = '''if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "4x Scope"
ATTACHMENT.ShortName = "ACOG"
ATTACHMENT.Icon = "entities/tfa_codww2_4x.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "4x Zoom",
    Color(255, 100, 100), "+15% Zoom time",
}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["scope_acog"] = { ["active"] = true },
    },
    ["WElements"] = {
        ["scope_acog"] = { ["active"] = true },
    },
    ["ScopeFov"] = 15,
    ["ZoomFov"] = 25,
    ["IronSightTime"] = function(wep, val) return val * 1.15 end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 15
    wep.ZoomFov = 25
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.3
    wep.Use2DScope = true
    if not wep.ScopeTexture then
        wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    end
    if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = { 256, 512, 768, 1080 }
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        wep.RT_Size = quality[num] * scale
        wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
    end
end

function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.Use2DScope = false
    wep.Sensitivity = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


# ============================================================
# FIX 3: Remove grenade launcher attachments from weapons
# ============================================================
GL_ATTS = ['tfa_codww2_rifle_grenade', 'tfa_codww2_rifle_grenade_ger']

def remove_grenade_launcher(filepath):
    """Remove grenade launcher attachment references from weapon files."""
    with open(filepath) as f:
        content = f.read()
    
    changes = []
    
    # Remove the attachment IDs from atts lists
    for gl in GL_ATTS:
        # Pattern: "tfa_codww2_rifle_grenade" or "tfa_codww2_rifle_grenade_ger"
        # in atts = { ... "tfa_codww2_rifle_grenade", ... }
        # Remove the entry
        content = re.sub(
            r'"tfa_codww2_rifle_grenade_ger"\s*,?\s*',
            '',
            content
        )
        content = re.sub(
            r'"tfa_codww2_rifle_grenade"\s*,?\s*',
            '',
            content
        )
    
    # Clean up empty slots (slots with no atts left)
    # Pattern: [N] = { name = "Slot N", atts = {  }, default = 0 },
    content = re.sub(
        r'\[\d+\]\s*=\s*\{\s*name\s*=\s*"[^"]*"\s*,\s*atts\s*=\s*\{\s*\}\s*,\s*default\s*=\s*0\s*\}\s*,?\n',
        '',
        content
    )
    
    # Clean up trailing commas in atts lists
    content = re.sub(r',\s*,\s*', ', ', content)
    content = re.sub(r'\{\s*,', '{', content)
    content = re.sub(r',\s*\}', ' }', content)
    
    with open(filepath, 'w') as f:
        f.write(content)
    
    return True


# ============================================================
# FIX 4: Fix silencer attachments
# ============================================================
def fix_silencer_attachment(filepath, is_pistol=False):
    """Fix silencer attachment to toggle Silenced NW bool."""
    name = "Pistol Suppressor" if is_pistol else "Suppressor"
    icon = "entities/tfa_codww2_supp_pistol.png" if is_pistol else "entities/tfa_codww2_supp.png"
    short = "P-SUPP" if is_pistol else "SUPP"
    velem = "suppressor"
    
    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{name}"
ATTACHMENT.ShortName = "{short}"
ATTACHMENT.Icon = "{icon}"
ATTACHMENT.Description = {{
    Color(100, 255, 100), "Reduced Sound",
    Color(100, 255, 100), "Stealth Fire",
    Color(255, 100, 100), "No Muzzle Flash",
}}

ATTACHMENT.WeaponTable = {{
    ["VElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
}}

function ATTACHMENT:Attach(wep)
    -- Enable the Underhell native silencer system
    wep.HasSilencer = true
    wep:SetNWBool("Silenced", true)
end

function ATTACHMENT:Detach(wep)
    wep:SetNWBool("Silenced", false)
    wep.HasSilencer = false
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


# ============================================================
# MAIN
# ============================================================
def main():
    print("=== FIX 1: Convert TFA nested Animations to flat strings ===\n")
    for filepath in sorted(glob.glob(f"{ATT_DIR}/*.lua")):
        if fix_nested_animations(filepath):
            print(f"  {os.path.basename(filepath)}: converted nested Animations")
    
    print("\n=== FIX 2: Fix RT scope attachments ===\n")
    for filename, config in SCOPE_ATTACHMENTS.items():
        filepath = os.path.join(ATT_DIR, filename)
        if os.path.exists(filepath):
            fix_scope_attachment(filepath, config)
            print(f"  {filename}: fixed RT scope")
    # Fix 4x separately
    fix_4x_scope(os.path.join(ATT_DIR, 'tfa_codww2_4x.lua'))
    print(f"  tfa_codww2_4x.lua: fixed RT scope (4x ACOG)")
    
    print("\n=== FIX 3: Remove grenade launcher attachments ===\n")
    # Remove GL attachment files
    for gl in ['tfa_codww2_rifle_grenade.lua', 'tfa_codww2_rifle_grenade_ger.lua']:
        filepath = os.path.join(ATT_DIR, gl)
        if os.path.exists(filepath):
            os.remove(filepath)
            print(f"  Removed: {gl}")
    # Remove GL references from weapons
    for filepath in sorted(glob.glob(f"{WEAPONS_DIR}/kate_*.lua")):
        with open(filepath) as f:
            content = f.read()
        if 'rifle_grenade' in content:
            remove_grenade_launcher(filepath)
            print(f"  {os.path.basename(filepath)}: removed GL references")
    
    print("\n=== FIX 4: Fix silencer attachments ===\n")
    fix_silencer_attachment(os.path.join(ATT_DIR, 'tfa_codww2_supp.lua'), is_pistol=False)
    print("  tfa_codww2_supp.lua: fixed silencer (toggles Silenced NW bool)")
    fix_silencer_attachment(os.path.join(ATT_DIR, 'tfa_codww2_supp_pistol.lua'), is_pistol=True)
    print("  tfa_codww2_supp_pistol.lua: fixed silencer (toggles Silenced NW bool)")


if __name__ == '__main__':
    main()
