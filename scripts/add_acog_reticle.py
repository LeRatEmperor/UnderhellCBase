#!/usr/bin/env python3
"""
Add ScopeReticle to all weapons with 4x ACOG that don't have it.

These non-sniper weapons (rifles, SMGs, LMGs) use the 4x ACOG but
don't have ScopeReticle set. The 4x ACOG falls back to 'gmod/scope'
which doesn't show the reticle properly.

Set ScopeReticle to 'scopes/scope_overlay_mp' (the multiplayer scope
overlay) for all non-sniper weapons with the 4x ACOG.
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

RETICLE_PATH = "scopes/scope_overlay_mp"


def add_scope_reticle(filepath):
    """Add SWEP.ScopeReticle if not present."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    if 'SWEP.ScopeReticle' in src:
        return False

    # Add after IronSightsAng line
    match = re.search(
        r'^(SWEP\.IronSightsAng\s*=\s*Vector\([^)]+\))',
        src, re.MULTILINE
    )
    if not match:
        return False

    insert_pos = match.end()
    reticle_line = f'\n-- Reticle texture for 4x ACOG RT scope\nSWEP.ScopeReticle = "{RETICLE_PATH}"\n'
    src = src[:insert_pos] + reticle_line + src[insert_pos:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    # Find all weapons with tfa_codww2_4x but no ScopeReticle
    weapons = glob.glob(os.path.join(WEAPONS_DIR, "kate_*.lua"))
    print(f"Scanning {len(weapons)} weapons for 4x ACOG without ScopeReticle...")

    n = 0
    for wpn in sorted(weapons):
        with open(wpn, 'r', encoding='utf-8') as f:
            src = f.read()

        if 'tfa_codww2_4x' not in src:
            continue
        if 'SWEP.ScopeReticle' in src:
            continue

        fname = os.path.basename(wpn)
        if add_scope_reticle(wpn):
            print(f"  {fname}: ScopeReticle = {RETICLE_PATH}")
            n += 1

    print(f"\nDone. Added ScopeReticle to {n} weapons.")


if __name__ == "__main__":
    main()
