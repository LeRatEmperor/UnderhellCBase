#!/usr/bin/env python3
"""
Set SWEP.Primary.Delay to 1.0 on all 12 sniper weapons.

The current Primary.Delay (0.24) is too short for bolt-action snipers.
The shotgun uses 1.0 which is long enough to encapsulate both the
shooting animation and the rechamber animation.

Setting it to 1.0 ensures the fire delay covers the full bolt cycle.
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

SNIPER_WEAPONS = [
    "kate_mosin", "kate_arisaka", "kate_springfield", "kate_kar98k",
    "kate_enfield", "kate_delisle", "kate_kbsp1938", "kate_mas36",
    "kate_ptrs41", "kate_winchester94", "kate_sdk", "kate_wz35",
]


def fix_weapon(filepath):
    """Set SWEP.Primary.Delay to 1.0."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Match: SWEP.Primary.Delay = <number> (with optional comment)
    pattern = r'(SWEP\.Primary\.Delay\s*=\s*)([\d.]+)(.*)'
    
    match = re.search(pattern, src)
    if not match:
        return False

    old_line = match.group(0)
    new_line = match.group(1) + "1.0" + match.group(3)
    
    src = src.replace(old_line, new_line, 1)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print(f"Setting Primary.Delay = 1.0 on {len(SNIPER_WEAPONS)} snipers...")
    n = 0
    for weapon_name in SNIPER_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if fix_weapon(filepath):
            print(f"  {weapon_name}.lua: Primary.Delay -> 1.0")
            n += 1
        else:
            print(f"  SKIP: {weapon_name}.lua (Primary.Delay not found)")
    print(f"\nDone. Fixed {n}/{len(SNIPER_WEAPONS)} weapons.")


if __name__ == "__main__":
    main()
