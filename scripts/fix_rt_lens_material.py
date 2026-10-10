#!/usr/bin/env python3
"""
Fix RT scope attachments: use the actual scope lens material path
instead of CreateMaterial.

The scope lens VMT files are at:
  models/weapons/tfa_codww2/<weapon>/mtl_generic_optic_ads_lens

These are the materials used by the scope model's lens mesh.
When ScopeTexture is set to Material(path), the RenderScene hook
replaces $basetexture with the RenderTarget, and the lens displays
the RT view.
"""
import os

ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

# Weapon-specific scope attachments → lens material path
SCOPE_ATTACEMENTS = {
    'tfa_codww2_kar98k_scope.lua': {
        'name': 'Kar98k Scope',
        'lens_material': 'models/weapons/tfa_codww2/kar98k/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_arisaka_scope.lua': {
        'name': 'Arisaka Scope',
        'lens_material': 'models/weapons/tfa_codww2/arisaka/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_enfield_scope.lua': {
        'name': 'Enfield Scope',
        'lens_material': 'models/weapons/tfa_codww2/enfield/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_mosin_scope.lua': {
        'name': 'Mosin Scope',
        'lens_material': 'models/weapons/tfa_codww2/mosin/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_springfield_scope.lua': {
        'name': 'Springfield Scope',
        'lens_material': 'models/weapons/tfa_codww2/springfield/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_scope.lua': {
        'name': '7x Scope',
        'lens_material': 'models/weapons/tfa_codww2/kar98k/mtl_generic_optic_ads_lens',
        'velement': 'scope_default',
        'scope_fov': 7,
        'zoom_fov': 15,
    },
    'tfa_codww2_4x.lua': {
        'name': '4x ACOG',
        'lens_material': 'models/weapons/tfa_codww2/kar98k/mtl_generic_optic_ads_lens',
        'velement': 'scope_acog',
        'scope_fov': 15,
        'zoom_fov': 25,
    },
}


def write_scope_attachment(filepath, config):
    """Write a scope attachment using the actual lens material path."""
    name = config['name']
    lens = config['lens_material']
    velem = config['velement']
    sf = config['scope_fov']
    zf = config['zoom_fov']

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
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["ScopeFov"] = {sf},
    ["ZoomFov"] = {zf},
    ["Sensitivity"] = 0.2,
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}}

function ATTACHMENT:Attach(wep)
    -- Set ScopeTexture to the actual scope lens material used by the
    -- scope model's lens mesh. The RenderScene hook will replace this
    -- material's $basetexture with the RenderTarget, so the lens
    -- displays the 3D RT view.
    wep.ScopeTexture = Material("{lens}")
    wep.ScopeFov = {sf}
    wep.ZoomFov = {zf}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    -- Initialize RenderTarget if not already done
    if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = {{ 256, 512, 768, 1080 }}
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        wep.RT_Size = quality[num] * scale
        wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
    end
end

function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


def main():
    print("=== Fixing RT scope attachments with correct lens material paths ===\n")
    for filename, config in SCOPE_ATTACEMENTS.items():
        filepath = os.path.join(ATT_DIR, filename)
        write_scope_attachment(filepath, config)
        print(f"  {filename}: ScopeTexture = Material('{config['lens_material']}')")


if __name__ == '__main__':
    main()
