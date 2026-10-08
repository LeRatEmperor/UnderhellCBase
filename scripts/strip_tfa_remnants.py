#!/usr/bin/env python3
"""
Strip TFA remnants from all kate_ weapons and templates.

1. Remove RangeFalloffLUT — dead TFA data, Underhell base doesn't read it
2. Clean up TFA reference comments
3. Keep sound names "TFA_CODWW2_*" — they're GMod sound scripts (defined via
   sound.Add in nz_codww2_sounds.lua, NOT TFA API)
4. Keep attachment IDs "tfa_codww2_*" — they're CUH attachment data files
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

ALL_FILES = [
    'kate_1911.lua', 'kate_mp40.lua', 'kate_stg44.lua',
    'kate_pg1935.lua', 'kate_kar98k.lua', 'kate_model1897.lua',
    'kate_m1879.lua',
    'template_semi.lua', 'template_auto.lua', 'template_selective.lua',
    'template_burst.lua', 'template_bolt.lua', 'template_shotgun.lua',
    'template_revolver_sg.lua',
]


def strip_tfa_remnants(filepath):
    with open(filepath) as f:
        content = f.read()

    changes = []

    # 1. Remove RangeFalloffLUT blocks (TFA-specific, dead data in Underhell)
    # Pattern: -- Range falloff (from TFA Primary.RangeFalloffLUT)\nSWEP.Primary.RangeFalloffLUT = { ... }
    range_pattern = re.compile(
        r'-- Range falloff \(from TFA Primary\.RangeFalloffLUT\)\nSWEP\.Primary\.RangeFalloffLUT\s*=\s*\{.*?\}\n',
        re.DOTALL
    )
    if range_pattern.search(content):
        content = range_pattern.sub('', content)
        changes.append('removed RangeFalloffLUT')

    # Also remove any standalone RangeFalloffLUT references
    range_pattern2 = re.compile(
        r'SWEP\.Primary\.RangeFalloffLUT\s*=\s*\{.*?\}\n',
        re.DOTALL
    )
    if range_pattern2.search(content):
        content = range_pattern2.sub('', content)
        if 'removed RangeFalloffLUT' not in changes:
            changes.append('removed RangeFalloffLUT')

    # 2. Clean up TFA reference comments
    content = content.replace('-- TFA: DisableChambering = true', '')
    content = content.replace('-- from TFA BurstFireCount', '-- rounds per burst')
    content = content.replace('-- from TFA EventTable', '')
    content = content.replace('-- from TFA', '')
    content = content.replace('-- NOTE: lua-type events (EventShell calls) are NOT ported — CUH AnimSounds only supports sound events.', '')
    content = content.replace('-- NOTE: lua-type events (AttachGrenade / DetachGrenade calls) are NOT ported — CUH AnimSounds only supports sound events.', '')
    content = content.replace('-- SequenceLengthOverride[ACT_VM_PULLBACK_HIGH]', '-- bolt/pump cycle time')

    # Clean up empty comment lines left behind
    content = re.sub(r'\n-- \n', '\n', content)
    content = re.sub(r'\n\n\n+', '\n\n', content)

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Stripping TFA remnants from all weapons + templates ===\n")
    for filename in ALL_FILES:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = strip_tfa_remnants(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no TFA remnants found")


if __name__ == '__main__':
    main()
