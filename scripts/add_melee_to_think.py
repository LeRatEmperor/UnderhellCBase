#!/usr/bin/env python3
"""
Add melee state machine to kate weapons' Think, matching the M8A1/XM4 pattern.
The CUH base no longer has a Think override — each weapon must include the
melee timing checks in its own Think (like M8A1 and XM4 do).
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

ALL_WEAPONS = [
    'kate_1911.lua',
    'kate_mp40.lua',
    'kate_stg44.lua',
    'kate_pg1935.lua',
    'kate_kar98k.lua',
    'kate_model1897.lua',
    'kate_m1879.lua',
]

# The melee state machine code to insert into Think
MELEE_THINK_CODE = """
    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end
"""


def fix_weapon_think(filepath):
    with open(filepath) as f:
        content = f.read()

    # Check if melee state machine is already in Think
    if '_meleeHitDone' in content and 'DoMeleeTrace' in content and 'ct >= self._meleeHitTime' in content:
        # Already has it (burst weapons have their own Think with burst logic)
        # Check if it also has the melee checks
        if 'self._meleeActive and not self._meleeHitDone' in content:
            return 'already has melee state machine'

    # Find the Think function
    # Pattern: function SWEP:Think()\n ... \n end
    think_match = re.search(r'(function SWEP:Think\(\)\s*\n)(.*?)(\nend\n)', content, re.DOTALL)
    if not think_match:
        return 'no Think function found'

    think_body = think_match.group(2)

    # Check if melee state machine is already there
    if '_meleeActive and not self._meleeHitDone' in think_body:
        return 'already has melee in Think'

    # Insert the melee state machine at the BEGINNING of Think body
    # (before BaseClass.Think, matching M8A1/XM4 pattern)
    # But we need `local ct = CurTime()` before the melee checks.
    # Check if ct is already declared in Think
    if 'local ct = CurTime()' not in think_body and 'local ct = CurTime()' not in think_match.group(1):
        # Add ct declaration
        new_think_body = '    local ct = CurTime()\n' + MELEE_THINK_CODE + think_body
    else:
        # ct is already declared — just add the melee checks after it
        new_think_body = think_body.replace(
            'local ct = CurTime()',
            'local ct = CurTime()\n' + MELEE_THINK_CODE,
            1
        )

    # Replace the Think body
    content = content[:think_match.start(2)] + new_think_body + content[think_match.end(2):]

    with open(filepath, 'w') as f:
        f.write(content)
    return 'added melee state machine to Think'


def main():
    print("=== Adding melee state machine to kate weapons' Think ===\n")
    for filename in ALL_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        result = fix_weapon_think(filepath)
        print(f"  {filename}: {result}")


if __name__ == '__main__':
    main()
