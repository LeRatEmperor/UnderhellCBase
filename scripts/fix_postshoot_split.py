#!/usr/bin/env python3
"""
Fix the broken PostShoot function in all 12 sniper weapons.

The previous script (fix_optics_and_rechamber.py) inserted the
CanPrimaryAttack override INSIDE the PostShoot function, splitting it
in half and causing:
  attempt to index global 'SWEP' (a nil value)

This script:
  1. Finds the CanPrimaryAttack override block (the broken insertion)
  2. Removes it from its current (wrong) position
  3. Re-inserts it AFTER the PostShoot function's closing `end`
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]

# The CanPrimaryAttack override block that was inserted incorrectly
CAN_PRIMARY_ATTACK_BLOCK = """
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


def fix_weapon(filepath):
    """Remove the misplaced CanPrimaryAttack block and re-insert after PostShoot."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Step 1: Remove the CanPrimaryAttack block from wherever it is
    if CAN_PRIMARY_ATTACK_BLOCK not in src:
        return False  # not found, might already be fixed or different format

    src = src.replace(CAN_PRIMARY_ATTACK_BLOCK, "", 1)

    # Step 2: Find the end of the PostShoot function and insert after it
    # The PostShoot function ends with a timer.Simple block and `end`
    # Pattern: timer.Simple(...) ... end) ... end
    # We need to find the closing `end` of function SWEP:PostShoot()

    # Find "function SWEP:PostShoot()" 
    postshoot_match = re.search(r'function SWEP:PostShoot\(\)', src)
    if not postshoot_match:
        # No PostShoot — insert before the ATTACK section or at a safe point
        # Try to find "function SWEP:PrimaryAttack()" or "-- ATTACK"
        attack_match = re.search(r'(-- =+\n-- ATTACK)', src)
        if attack_match:
            src = src[:attack_match.start()] + CAN_PRIMARY_ATTACK_BLOCK.strip() + "\n\n" + src[attack_match.start():]
        else:
            return False
    else:
        # Find the matching `end` for the PostShoot function
        # The function body contains timer.Simple with nested ends.
        # We need to find the `end` that closes function SWEP:PostShoot()
        start = postshoot_match.end()
        # Count function/if/for/do depth to find matching end
        depth = 1  # we're inside the function
        i = start
        lines = src[start:].split('\n')
        line_offset = 0
        for line_num, line in enumerate(lines):
            stripped = line.strip()
            # Count opening keywords
            for m in re.finditer(r'\bfunction\b|\bif\b.*\bthen\b|\bfor\b.*\bdo\b|\bwhile\b.*\bdo\b|\bdo\b\s*$', stripped):
                depth += 1
            # Count closing 'end'
            if stripped == 'end' or stripped.startswith('end)') or stripped == 'end' or re.match(r'^end\b', stripped):
                depth -= 1
                if depth == 0:
                    # Found the matching end — insert after this line
                    insert_pos = start + sum(len(l) + 1 for l in lines[:line_num+1]) - 1
                    src = src[:insert_pos] + "\n" + CAN_PRIMARY_ATTACK_BLOCK.strip() + src[insert_pos:]
                    break
        else:
            return False

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print(f"Fixing {len(SNIPER_WEAPONS)} sniper weapons...")
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
            print(f"  SKIP: {weapon_name}.lua (block not found or already fixed)")
    print(f"\nDone. Fixed {n}/{len(SNIPER_WEAPONS)} weapons.")


if __name__ == "__main__":
    main()
