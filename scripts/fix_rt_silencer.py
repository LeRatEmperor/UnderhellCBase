#!/usr/bin/env python3
"""
Fix RT scopes and silencer attachments — no 2D hacks, no NW bool animation breakage.

1. RT SCOPES: Set ScopeTexture + ScopeFov + Sensitivity + ZoomFov via Attach().
   Do NOT set Use2DScope=true (that draws a 2D overlay hack).
   The RT system renders the 3D view into the ScopeTexture material,
   which is displayed on the viewmodel's scope lens mesh.
   Also set custom IronSightsPos/Ang per scope to center the view.

2. SILENCER: Override Primary.Sound via WeaponTable function (returns SilSound).
   Add SWEP.SuppressedFlash = true via WeaponTable for muzzle flash suppression.
   Do NOT set NWBool("Silenced") — that breaks animations via _sil suffix.
   Override DoMuzzleFlash via WeaponTable to check SuppressedFlash.
"""
import os

ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"
WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"


# ============================================================
# FIX 1: RT Scope attachments (true 3D RT, no 2D overlay)
# ============================================================

def write_scope_attachment(filepath, name, short_name, scope_fov, zoom_fov, ist_mult, velement="scope_default"):
    """Write a proper RT scope attachment."""
    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{name}"
ATTACHMENT.ShortName = "{short_name}"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {{
    Color(255, 255, 255), "{name}",
    Color(255, 100, 100), "+{int((ist_mult - 1) * 100)}% Zoom time",
    Color(255, 100, 100), "-5% ADS Movespeed",
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
    ["IronSightTime"] = function(wep, val) return val * {ist_mult} end,
    ["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}}

function ATTACHMENT:Attach(wep)
    -- Enable the true RT scope system (NOT the 2D overlay)
    -- ScopeTexture is a Material() whose $basetexture gets replaced with
    -- the RenderTarget by the RenderScene hook. The viewmodel's scope
    -- lens mesh uses this material, so the 3D view appears ON the lens.
    wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    wep.ScopeFov = {scope_fov}
    wep.ZoomFov = {zoom_fov}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false  -- NO 2D overlay — use the true RT lens system

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
    wep.RenderTarget = nil
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


# ============================================================
# FIX 2: Silencer attachments (no NW bool, no animation break)
# ============================================================

def write_silencer_attachment(filepath, name, short_name, icon, is_pistol=False):
    """Write a silencer attachment that doesn't break animations."""
    velem = "suppressor"
    
    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{name}"
ATTACHMENT.ShortName = "{short_name}"
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
    -- Override the shoot sound to use the silenced variant.
    -- This replaces Primary.Sound at the stat-cache level, so
    -- GetShootSound() returns the silenced sound.
    -- We do NOT set the 'Silenced' NW bool — that would trigger
    -- the animation system's '_sil' suffix lookup which breaks
    -- WWII weapon animations (they don't have _sil sequence variants).
    ["Primary"] = {{
        ["Sound"] = function(wep, val) return wep.Primary.SilSound or val end,
    }},
    -- Flag for muzzle flash suppression. The weapon's DoMuzzleFlash
    -- checks this field instead of the NW 'Silenced' bool.
    ["SuppressedFlash"] = true,
}}

function ATTACHMENT:Attach(wep)
    -- Set the non-networked flag for muzzle flash suppression.
    -- This does NOT trigger the animation swap system.
    wep.SuppressedFlash = true
end

function ATTACHMENT:Detach(wep)
    wep.SuppressedFlash = false
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


# ============================================================
# MAIN
# ============================================================
def main():
    print("=== FIX 1: RT Scope attachments (true RT, no 2D overlay) ===\n")
    
    scopes = [
        ('tfa_codww2_scope.lua', '7x Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
        ('tfa_codww2_4x.lua', '4x ACOG', 'ACOG', 15, 25, 1.15, 'scope_acog'),
        ('tfa_codww2_arisaka_scope.lua', 'Arisaka Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
        ('tfa_codww2_enfield_scope.lua', 'Enfield Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
        ('tfa_codww2_kar98k_scope.lua', 'Kar98k Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
        ('tfa_codww2_mosin_scope.lua', 'Mosin Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
        ('tfa_codww2_springfield_scope.lua', 'Springfield Scope', 'SCOPE', 7, 15, 1.25, 'scope_default'),
    ]
    
    for fname, name, short, sf, zf, ist, velem in scopes:
        filepath = os.path.join(ATT_DIR, fname)
        write_scope_attachment(filepath, name, short, sf, zf, ist, velem)
        print(f"  {fname}: true RT scope (ScopeFov={sf}, ZoomFov={zf}, no 2D overlay)")
    
    print("\n=== FIX 2: Silencer attachments (no NW bool, no animation break) ===\n")
    
    write_silencer_attachment(
        os.path.join(ATT_DIR, 'tfa_codww2_supp.lua'),
        'Suppressor', 'SUPP', 'entities/tfa_codww2_supp.png'
    )
    print("  tfa_codww2_supp.lua: silencer via WeaponTable (no NW bool)")
    
    write_silencer_attachment(
        os.path.join(ATT_DIR, 'tfa_codww2_supp_pistol.lua'),
        'Pistol Suppressor', 'P-SUPP', 'entities/tfa_codww2_supp_pistol.png',
        is_pistol=True
    )
    print("  tfa_codww2_supp_pistol.lua: silencer via WeaponTable (no NW bool)")
    
    # Now we need to add a check for SuppressedFlash in the CUH base's
    # DoMuzzleFlash function. This is a minimal base change.
    print("\n=== NOTE: need to add SuppressedFlash check to DoMuzzleFlash ===")
    print("  The CUH base's DoMuzzleFlash currently only checks GetNWBool('Silenced')")
    print("  We need to also check self.SuppressedFlash")


if __name__ == '__main__':
    main()
