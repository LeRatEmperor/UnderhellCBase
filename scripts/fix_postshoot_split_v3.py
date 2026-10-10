#!/usr/bin/env python3
"""
Fix v3: More reliable PostShoot function boundary detection.

The problem: timer.Simple(pumpDelay, function() ... end) contains 'function'
and 'end' keywords that confuse depth counting.

The fix: Parse line by line, tracking 'function'/'if'/'for'/'while'/'do'
as +1 depth, and 'end' as -1 depth. When depth returns to 0, that's the
end of the PostShoot function.

Also need to handle 'end)' (end with closing paren) as a single 'end'.
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]

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


def find_function_end(src, func_start):
    """Find the end of the function that starts at func_start.
    
    Returns the position of the 'end' keyword that closes the function,
    or -1 if not found.
    
    Uses proper depth tracking:
      +1 for: function, if...then, for...do, while...do, do (at end of line)
      -1 for: end, end)
    """
    # Start from the 'function' keyword
    i = func_start
    depth = 0
    
    while i < len(src):
        # Find the next keyword
        remaining = src[i:]
        
        # Look for opening keywords
        func_m = re.search(r'\bfunction\b', remaining)
        if_m = re.search(r'\bif\b.*?\bthen\b', remaining)
        for_m = re.search(r'\bfor\b.*?\bdo\b', remaining)
        while_m = re.search(r'\bwhile\b.*?\bdo\b', remaining)
        do_m = re.search(r'\bdo\b\s*$', remaining, re.MULTILINE)
        end_m = re.search(r'\bend\b', remaining)
        
        # Find the earliest match
        matches = []
        if func_m: matches.append(('func', func_m.start()))
        if if_m: matches.append(('if', if_m.start()))
        if for_m: matches.append(('for', for_m.start()))
        if while_m: matches.append(('while', while_m.start()))
        if do_m: matches.append(('do', do_m.start()))
        if end_m: matches.append(('end', end_m.start()))
        
        if not matches:
            break
        
        # Get the earliest
        matches.sort(key=lambda x: x[1])
        match_type, match_pos = matches[0]
        
        if match_type == 'end':
            depth -= 1
            if depth == 0:
                # Found the closing end of the function
                return i + match_pos + len('end')
        else:
            # Opening keyword
            if match_type == 'func':
                depth += 1
            elif match_type == 'if':
                depth += 1
            elif match_type == 'for':
                depth += 1
            elif match_type == 'while':
                depth += 1
            elif match_type == 'do':
                depth += 1
        
        # Move past this match
        i = i + match_pos + 1
    
    return -1


def fix_weapon(filepath):
    """Remove the misplaced CanPrimaryAttack block and re-insert after PostShoot."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Step 1: Find and remove the CanPrimaryAttack block
    match = CAN_PRIMARY_ATTACK_REGEX.search(src)
    if not match:
        return False

    src = src[:match.start()] + src[match.end():]

    # Step 2: Find the PostShoot function
    func_start = src.find('function SWEP:PostShoot()')
    if func_start == -1:
        return False

    # Find the 'function' keyword position (not the whole match)
    func_kw_pos = src.find('function', func_start)
    
    # Find the end of the function
    func_end = find_function_end(src, func_kw_pos)
    if func_end == -1:
        return False

    # Insert the CanPrimaryAttack block after the function's closing 'end'
    src = src[:func_end] + "\n" + NEW_BLOCK + src[func_end:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print(f"Fixing {len(SNIPER_WEAPONS)} sniper weapons (v3)...")
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
