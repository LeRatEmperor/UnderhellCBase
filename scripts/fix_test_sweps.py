#!/usr/bin/env python3
"""
Apply fixes to all 7 kate_ WWII test weapons:
1. Add SWEP.AnimatedSprint = true
2. Reduce PumpDelay to 0.4 on all rechambering weapons (bolt + shotgun)
3. Combat Shotgun (model1897): set Primary.ReloadTime = 0.7
4. Reichsrevolver (m1879): set Primary.ReloadTime = 0.4
5. Fix shotgun reload sound/animation key mismatch
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# All 7 kate weapons
ALL_WEAPONS = [
    'kate_1911.lua',
    'kate_mp40.lua',
    'kate_stg44.lua',
    'kate_pg1935.lua',
    'kate_kar98k.lua',
    'kate_model1897.lua',
    'kate_m1879.lua',
]

# Weapons with rechamber (PumpDelay)
RECHAMBER_WEAPONS = [
    'kate_kar98k.lua',      # bolt-action
    'kate_model1897.lua',   # pump shotgun
]


def fix_weapon(filepath, filename):
    with open(filepath) as f:
        content = f.read()

    changes = []

    # 1. Add SWEP.AnimatedSprint = true (if not already present)
    if 'SWEP.AnimatedSprint' not in content:
        # Add after SWEP.Chambering line (or after ReloadSpeed)
        content = re.sub(
            r'(SWEP\.Chambering\s*=\s*\w+)',
            r'\1\nSWEP.AnimatedSprint = true',
            content,
            count=1
        )
        changes.append('added AnimatedSprint=true')

    # 2. Reduce PumpDelay to 0.4 on rechambering weapons
    if filename in RECHAMBER_WEAPONS:
        # Replace PumpDelay = <anything> with PumpDelay = 0.4
        content = re.sub(
            r'SWEP\.PumpDelay\s*=\s*[\d\.]+',
            'SWEP.PumpDelay = 0.4',
            content
        )
        # Also replace inline "self.PumpDelay or X" with 0.4
        content = re.sub(
            r'local pumpDelay = self\.PumpDelay or [\d\.]+',
            'local pumpDelay = self.PumpDelay or 0.4',
            content
        )
        changes.append('PumpDelay=0.4')

    # 3. Combat Shotgun: Primary.ReloadTime = 0.7
    if filename == 'kate_model1897.lua':
        content = re.sub(
            r'SWEP\.Primary\.ReloadTime\s*=\s*[\d\.]+',
            'SWEP.Primary.ReloadTime = 0.7',
            content
        )
        changes.append('ReloadTime=0.7')

    # 4. Reichsrevolver: Primary.ReloadTime = 0.4
    if filename == 'kate_m1879.lua':
        content = re.sub(
            r'SWEP\.Primary\.ReloadTime\s*=\s*[\d\.]+',
            'SWEP.Primary.ReloadTime = 0.4',
            content
        )
        changes.append('ReloadTime=0.4')

    # 5. Fix shotgun reload sound/animation key mismatch
    # The Animations table uses: start_reload, reload_loop, after_reload
    # The AnimSounds should also use: start_reload, reload_loop, after_reload
    # But the TFA EventTable used ACT_SHOTGUN_RELOAD_START/FINISH which were
    # mapped to shotgun_reload_start/shotgun_reload_finish.
    # Fix: rename AnimSounds keys from shotgun_reload_start → start_reload,
    # shotgun_reload_finish → after_reload
    if filename in ('kate_model1897.lua', 'kate_m1879.lua'):
        # Rename AnimSounds keys
        content = content.replace(
            '["shotgun_reload_start"]',
            '["start_reload"]'
        )
        content = content.replace(
            '["shotgun_reload_finish"]',
            '["after_reload"]'
        )
        changes.append('fixed shotgun sound keys')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Applying fixes to all 7 kate_ weapons ===\n")
    for filename in ALL_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = fix_weapon(filepath, filename)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
