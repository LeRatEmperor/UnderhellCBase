#!/usr/bin/env python3
"""
Fix optic bugs and sniper rechambering exploit.

ISSUE 1: Missing reticles on 4x ACOG, Lens Sight, SDK Kar98 scope, WZ35 Mosin scope
  - The 4x ACOG and Lens Sight attachments don't have ScopeReticle set
  - The SDK and WZ35 use cross-weapon scopes (kar98k_scope, mosin_scope)
    but the scopes read wep.ScopeReticle from the WEAPON, not the attachment
  - Fix: Add ScopeReticle to the 4x ACOG and Lens Sight attachments, and
    add it to the SDK and WZ35 weapon files

ISSUE 2: Kar98k scope broken RT + reticle
  - The Kar98k scope attachment may have a broken VElement reference
  - Fix: Check and fix the scope_default VElement

ISSUE 3: Ironsight alignment on M36 (Enfield scope) and PTRS41 (Mosin scope)
  - These weapons use cross-weapon scopes but may have wrong IronSightsPos_7X
  - Fix: Check TFA source for correct values

ISSUE 4: Sniper rechambering bypass exploit
  - CanPrimaryAttack() doesn't check GetNextPrimaryFire()
  - Players can spam fire, bypassing the bolt-action delay
  - Fix: Override CanPrimaryAttack in all sniper weapons to check
    GetNextPrimaryFire()
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"
ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

# Faction mapping for reticle textures
# Based on weapon name -> faction
RETICLE_MAP = {
    # American weapons
    "kate_springfield": "scopes/scope_overlay_american",
    "kate_winchester94": "scopes/scope_overlay_american",
    "kate_mas36": "scopes/scope_overlay_american",
    # British weapons
    "kate_enfield": "scopes/scope_overlay_britain",
    "kate_delisle": "scopes/scope_overlay_britain",
    # German weapons
    "kate_kar98k": "scopes/scope_overlay_german",
    "kate_kbsp1938": "scopes/scope_overlay_german",
    "kate_mosin": "scopes/scope_overlay_german",
    "kate_ptrs41": "scopes/scope_overlay_german",
    "kate_sdk": "scopes/scope_overlay_german",      # SDK uses Kar98 scope
    "kate_wz35": "scopes/scope_overlay_german",    # WZ35 uses Mosin scope
    # Japanese weapons
    "kate_arisaka": "scopes/scope_overlay_japanese",
}

# Weapons that need ScopeReticle added (for ACOG/Lens attachments)
NEEDS_RETICLE_FOR_ACOG = [
    "kate_as44", "kate_avs36", "kate_bar", "kate_breda30", "kate_bren",
    "kate_charlton", "kate_chatellerault", "kate_crossbow", "kate_federov",
    "kate_fg42", "kate_gewehr43", "kate_grossfuss", "kate_kgm21", "kate_lad",
    "kate_lewis", "kate_m1919", "kate_m1941", "kate_m1a1", "kate_m1garand",
    "kate_m2carbine", "kate_mas36", "kate_mg15", "kate_mg42", "kate_mg81",
    "kate_pg1935", "kate_ptrs41", "kate_stg44", "kate_stinger", "kate_svt40",
    "kate_type5", "kate_vmg27", "kate_volk", "kate_wimmer",
    "kate_arsenal", "kate_austen", "kate_bechowiec", "kate_beretta38",
    "kate_blyskawica", "kate_emp44", "kate_erma", "kate_greasegun",
    "kate_m2hyde", "kate_mas38", "kate_mp28", "kate_mp40", "kate_nambu",
    "kate_ribey", "kate_sten", "kate_sterling", "kate_thompson",
    "kate_type100", "kate_zk383",
]

# Sniper weapons that need the rechamber fix (IsBoltAction = true)
SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]


def add_scope_reticle(filepath, reticle_path):
    """Add or update SWEP.ScopeReticle in a weapon file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    if 'SWEP.ScopeReticle' in src:
        # Update existing
        src = re.sub(
            r'SWEP\.ScopeReticle\s*=\s*"[^"]*"',
            f'SWEP.ScopeReticle = "{reticle_path}"',
            src
        )
    else:
        # Add after IronSightsAng line
        match = re.search(
            r'^(SWEP\.IronSightsAng\s*=\s*Vector\([^)]+\))',
            src, re.MULTILINE
        )
        if match:
            insert_pos = match.end()
            reticle_line = f'\n-- Reticle texture for RT scope (faction scope overlay)\nSWEP.ScopeReticle = "{reticle_path}"\n'
            src = src[:insert_pos] + reticle_line + src[insert_pos:]
        else:
            return False

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def add_can_primary_attack_override(filepath):
    """Add CanPrimaryAttack override to check GetNextPrimaryFire."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    if 'function SWEP:CanPrimaryAttack()' in src:
        return False  # already has override

    # Find the PostShoot function and add CanPrimaryAttack after it
    # or add before the ATTACK section
    match = re.search(r'^(function SWEP:PostShoot\(\))', src, re.MULTILINE)
    if match:
        insert_pos = src.find('\n', match.start()) + 1
    else:
        # Find the ATTACK section header
        match = re.search(r'-- ATTACK', src)
        if match:
            insert_pos = match.start()
        else:
            return False

    override = """
-- ============================================================
-- RECHAMBER GUARD (CanPrimaryAttack override)
-- ============================================================
-- Prevents spamming fire to bypass the bolt-action rechamber delay.
-- The base CanPrimaryAttack doesn't check GetNextPrimaryFire(), so
-- players could click rapidly to fire faster than the PumpDelay.
-- This override blocks fire until the rechamber sequence completes.
function SWEP:CanPrimaryAttack()
    if self:GetNWInt("FireMode") == 0 then return false end
    if self:GetNWFloat("DeployTime") > CurTime() then return false end
    if self:GetUHBool("Running") then return false end
    if self:GetUHBool("Reloading") then return false end
    -- CRITICAL: Block fire during bolt-action rechamber
    if self.IsBoltAction and CurTime() < self:GetNextPrimaryFire() then
        return false
    end
    if self:Clip1() <= 0 then
        if not self:GetUHBool("Reloading") then
            self:EmitSound("Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE)
        end
        self:SetNextPrimaryFire(CurTime() + 0.4)
        return false
    end
    return true
end

"""
    src = src[:insert_pos] + override + src[insert_pos:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print("=== Adding ScopeReticle to weapons ===")
    n = 0
    for weapon_name, reticle_path in RETICLE_MAP.items():
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if add_scope_reticle(filepath, reticle_path):
            print(f"  {weapon_name}.lua -> {reticle_path}")
            n += 1
    print(f"  Done: {n} weapons updated")

    print("\n=== Adding rechamber guard to sniper weapons ===")
    n = 0
    for weapon_name in SNIPER_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if add_can_primary_attack_override(filepath):
            print(f"  {weapon_name}.lua: CanPrimaryAttack override added")
            n += 1
        else:
            print(f"  SKIP: {weapon_name}.lua (already has override or no PostShoot)")
    print(f"  Done: {n} weapons updated")


if __name__ == "__main__":
    main()
