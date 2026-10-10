#!/usr/bin/env python3
"""
Update each scoped weapon's ScopeReticle field to point to the correct
faction-specific scope overlay texture.

Mapping:
  American: springfield, winchester94
  British:  enfield, delisle
  German:   kar98k, kbsp1938
  Japanese: arisaka
  Russian:  mosin, ptrs41
  French:   mas36 (use german or american — let's use american)
  mp:       fallback for 4x ACOG, lens_sight (non-sniper scopes)
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Map weapon name to faction scope overlay
SCOPE_FACTION_MAP = {
    "kate_mosin":        "scopes/scope_overlay_german",      # Russian uses German scope style
    "kate_arisaka":      "scopes/scope_overlay_japanese",
    "kate_springfield":  "scopes/scope_overlay_american",
    "kate_kar98k":       "scopes/scope_overlay_german",
    "kate_enfield":      "scopes/scope_overlay_britain",
    "kate_delisle":      "scopes/scope_overlay_britain",
    "kate_kbsp1938":     "scopes/scope_overlay_german",
    "kate_mas36":        "scopes/scope_overlay_american",
    "kate_ptrs41":       "scopes/scope_overlay_german",      # Russian, use German style
    "kate_winchester94": "scopes/scope_overlay_american",
}


def update_scope_reticle(filepath, reticle_path):
    """Update or add SWEP.ScopeReticle in a weapon file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    if 'SWEP.ScopeReticle' in src:
        # Update existing
        src = re.sub(
            r'SWEP\.ScopeReticle\s*=\s*"[^"]*"',
            f'SWEP.ScopeReticle = "{reticle_path}"',
            src
        )
    else:
        # Add after IronSightsAng line
        match = re.search(
            r'^(SWEP\.IronSightsAng\s*=\s*Vector\([^)]+\))',
            src, re.MULTILINE
        )
        if match:
            insert_pos = match.end()
            reticle_line = f'\n-- Reticle texture for RT scope (faction scope overlay)\nSWEP.ScopeReticle = "{reticle_path}"\n'
            src = src[:insert_pos] + reticle_line + src[insert_pos:]
        else:
            print(f"  WARN: IronSightsAng not found")
            return False

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print("Updating ScopeReticle to faction-specific scope overlays...")
    n = 0
    for weapon_name, reticle_path in SCOPE_FACTION_MAP.items():
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if update_scope_reticle(filepath, reticle_path):
            print(f"  {weapon_name}.lua -> {reticle_path}")
            n += 1
    print(f"\nDone. Updated {n} weapons.")


if __name__ == "__main__":
    main()
