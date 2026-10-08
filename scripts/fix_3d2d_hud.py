#!/usr/bin/env python3
"""
Fix the 3D2D HUD ammo counter attachment.

The parent base's DrawHUD uses:
    local att = vm:GetAttachment(self:GetDisplay())
GetDisplay() returns 1 (hardcoded), which maps to __illumPosition on j_gun
(the grip) — causing the ammo counter to appear at the bottom of the grip.

Fix: override GetDisplay() in each kate weapon to return the index of
the "1" attachment (tag_silencer, near the muzzle/sights).

This is a per-SWEP override — no base file changes.
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

ALL_WEAPONS = [
    'kate_1911.lua', 'kate_mp40.lua', 'kate_stg44.lua',
    'kate_pg1935.lua', 'kate_kar98k.lua', 'kate_model1897.lua',
    'kate_m1879.lua',
]

GET_DISPLAY_OVERRIDE = '''function SWEP:GetDisplay()
    -- Override: return the index of attachment "1" (tag_silencer)
    -- so the 3D2D ammo counter appears near the muzzle/sights,
    -- not at __illumPosition on j_gun (the grip).
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("1")
        if att > 0 then return att end
    end
    return 1
end

'''


def fix_weapon(filepath):
    with open(filepath) as f:
        content = f.read()

    # Check if GetDisplay override already exists
    if 'function SWEP:GetDisplay()' in content:
        # Replace existing override
        content = re.sub(
            r'function SWEP:GetDisplay\(\).*?\nend\n',
            GET_DISPLAY_OVERRIDE.rstrip() + '\n',
            content,
            count=1,
            flags=re.DOTALL
        )
    else:
        # Add before GetMuzzle or GetShellEject
        content = re.sub(
            r'(function SWEP:GetMuzzle)',
            GET_DISPLAY_OVERRIDE + r'\1',
            content,
            count=1
        )

    with open(filepath, 'w') as f:
        f.write(content)


def main():
    print("=== Adding GetDisplay override to kate weapons ===\n")
    for filename in ALL_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        fix_weapon(filepath)
        print(f"  {filename}: added GetDisplay override")


if __name__ == '__main__':
    main()
