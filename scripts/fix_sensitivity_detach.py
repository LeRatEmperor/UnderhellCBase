#!/usr/bin/env python3
"""
Remove the manual 'wep.Sensitivity = nil' from all scope attachment
Detach functions. The stat cache (RestoreStat) handles restoring the
original value. The manual nil assignment was conflicting with the
stat cache, causing the sensitivity to persist.

Also remove the 'wep.Sensitivity = 0.2' from Attach functions —
the WeaponTable already sets it via SetStat, so the manual assignment
is redundant and may bypass the stat cache.
"""

import os

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

FILES = [
    "tfa_codww2_mosin_scope.lua",
    "tfa_codww2_arisaka_scope.lua",
    "tfa_codww2_springfield_scope.lua",
    "tfa_codww2_kar98k_scope.lua",
    "tfa_codww2_enfield_scope.lua",
    "tfa_codww2_scope.lua",
    "tfa_codww2_4x.lua",
    "tfa_codww2_lens_sight.lua",
]


def patch_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = os.path.basename(filepath)
    changed = False

    # Remove 'wep.Sensitivity = 0.2' from Attach (WeaponTable handles it)
    if '    wep.Sensitivity = 0.2\n' in src:
        src = src.replace('    wep.Sensitivity = 0.2\n', '')
        changed = True

    # Remove 'wep.Sensitivity = 0.5' from Attach (lens sight)
    if '    wep.Sensitivity = 0.5\n' in src:
        src = src.replace('    wep.Sensitivity = 0.5\n', '')
        changed = True

    # Remove 'wep.Sensitivity = nil' from Detach (stat cache handles it)
    if '    wep.Sensitivity = nil\n' in src:
        src = src.replace('    wep.Sensitivity = nil\n', '')
        changed = True

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(src)
    return changed


def main():
    print(f"Patching {len(FILES)} scope attachment files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        if patch_file(path):
            print(f"  PATCHED: {fname}")
            n += 1
        else:
            print(f"  SKIP: {fname}")
    print(f"\nDone. Patched {n}/{len(FILES)} files.")


if __name__ == "__main__":
    main()
