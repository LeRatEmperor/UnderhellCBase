#!/usr/bin/env python3
"""
Fix the broken PostShoot function in all 12 sniper weapons using regex.

The previous script inserted the CanPrimaryAttack override right after
'function SWEP:PostShoot()' was declared, splitting the function body.

This script:
  1. Uses regex to find the CanPrimaryAttack block (with flexible whitespace)
  2. Removes it from inside PostShoot
  3. Re-inserts it after the PostShoot function's closing `end`
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]

# The CanPrimaryAttack block as a regex (with flexible whitespace)
CAN_PRIMARY_ATTACK_REGEX = re.compile(
    r'\n\s*-- =+\n'
    r'\s*-- RECHAMBER GUARD.*?\n'
    r'\s*-- =+\n'
    r'\s*-- Prevents.*?\n'
    r'\s*-- The base.*?\n'
    r'\s*-- players.*?\n'
    r'\s*-- This override.*?\n'
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
    """Remove the misplaced CanPrimaryAttack block and re-insert after PostShoot."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Step 1: Find and remove the CanPrimaryAttack block
    match = CAN_PRIMARY_ATTACK_REGEX.search(src)
    if not match:
        return False

    block_text = match.group(0)
    src = src[:match.start()] + src[match.end():]

    # Step 2: Find the end of the PostShoot function
    # Look for 'function SWEP:PostShoot()' then find its matching 'end'
    postshoot_start = src.find('function SWEP:PostShoot()')
    if postshoot_start == -1:
        return False

    # Find the matching 'end' by counting depth
    # Start after the function declaration line
    lines = src[postshoot_start:].split('\n')
    depth = 1  # inside the function
    insert_after_line = -1

    for i, line in enumerate(lines[1:], 1):  # skip the function declaration
        stripped = line.strip()

        # Count opening keywords
        opens = len(re.findall(r'\bfunction\b', stripped))
        opens += len(re.findall(r'\bif\b.*\bthen\b', stripped))
        opens += len(re.findall(r'\bfor\b.*\bdo\b', stripped))
        opens += len(re.findall(r'\bwhile\b.*\bdo\b', stripped))
        opens += len(re.findall(r'\bdo\b\s*$', stripped))

        depth += opens

        # Count closing 'end'
        ends = len(re.findall(r'\bend\b', stripped))
        depth -= ends

        if depth <= 0:
            insert_after_line = i
            break

    if insert_after_line == -1:
        return False

    # Calculate the absolute position in the source
    abs_pos = postshoot_start
    for i in range(insert_after_line + 1):
        abs_pos += len(lines[i]) + 1  # +1 for newline

    # Insert the block after the PostShoot function
    src = src[:abs_pos] + NEW_BLOCK + "\n" + src[abs_pos:]

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
            print(f"  SKIP: {weapon_name}.lua (no misplaced block found)")
    print(f"\nDone. Fixed {n}/{len(SNIPER_WEAPONS)} weapons.")


if __name__ == "__main__":
    main()
