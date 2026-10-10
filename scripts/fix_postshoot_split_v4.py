#!/usr/bin/env python3
"""
Fix v4: Simple, reliable PostShoot fix.

Instead of trying to track depth, just:
1. Remove the CanPrimaryAttack block from wherever it is
2. Re-insert it at a known-good location: right before the ATTACK section
   or before the next function definition after PostShoot

This avoids the depth-tracking bugs entirely.
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]

# Match the CanPrimaryAttack block (flexible whitespace)
CAN_PRIMARY_ATTACK_REGEX = re.compile(
    r'\n\s*-- =+\n'
    r'\s*-- RECHAMBER GUARD.*?\n'
    r'\s*-- =+\n'
    r'(?:--[^\n]*\n)*'
    r'\s*function SWEP:CanPrimaryAttack\(\)\n'
    r'.*?'
    r'\s*return true\n'
    r'\s*end\n',
    re.DOTALL
)

NEW_BLOCK = """
-- ============================================================
-- RECHAMBER GUARD (CanPrimaryAttack override)
-- ============================================================
function SWEP:CanPrimaryAttack()
    if self:GetNWInt("FireMode") == 0 then return false end
    if self:GetNWFloat("DeployTime") > CurTime() then return false end
    if self:GetUHBool("Running") then return false end
    if self:GetUHBool("Reloading") then return false end
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


def fix_weapon(filepath):
    """Remove the misplaced CanPrimaryAttack block and re-insert before ATTACK section."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Step 1: Remove the CanPrimaryAttack block
    match = CAN_PRIMARY_ATTACK_REGEX.search(src)
    if not match:
        return False

    src = src[:match.start()] + src[match.end():]

    # Step 2: Find a safe insertion point
    # Look for the ATTACK section header, or the PrimaryAttack function
    insert_patterns = [
        r'\n-- =+\n-- ATTACK',
        r'\nfunction SWEP:PrimaryAttack\(\)',
        r'\n-- =+\n-- SMART MUZZLE',
        r'\nfunction SWEP:GetDisplay\(\)',
        r'\nfunction SWEP:GetMuzzle\(\)',
    ]

    insert_pos = None
    for pattern in insert_patterns:
        m = re.search(pattern, src)
        if m:
            insert_pos = m.start()
            break

    if insert_pos is None:
        # Fallback: insert before the first 'function SWEP:' after PostShoot
        postshoot_end = src.find('function SWEP:PostShoot()')
        if postshoot_end != -1:
            # Find the next function after PostShoot
            next_func = src.find('\nfunction SWEP:', postshoot_end + 10)
            if next_func != -1:
                insert_pos = next_func
            else:
                return False
        else:
            return False

    src = src[:insert_pos] + NEW_BLOCK + src[insert_pos:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print(f"Fixing {len(SNIPER_WEAPONS)} sniper weapons (v4)...")
    n = 0
    for weapon_name in SNIPER_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if fix_weapon(filepath):
            print(f"  FIXED: {weapon_name}.lua")
            n += 1
        else:
            print(f"  SKIP: {weapon_name}.lua")
    print(f"\nDone. Fixed {n}/{len(SNIPER_WEAPONS)} weapons.")


if __name__ == "__main__":
    main()
