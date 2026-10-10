#!/usr/bin/env python3
"""
Add ScopeReticle field to each scoped weapon, pointing to the weapon's
scope_c.vtf reticle texture. This texture is composited onto the RT
by the RenderScene hook to create the baked-in reticle effect.

Also rewrite the RT compositing in cuh_rt_scope_render.lua to use
render.SetMaterial + render.DrawScreenQuadEx instead of surface.*
(the render library approach is more reliable inside PushRenderTarget).
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Map of Kate weapon names to TFA weapon folder names (for scope_c path)
SCOPE_RETICLE_MAP = {
    "kate_arisaka":     "arisaka",
    "kate_delisle":     "delisle",
    "kate_enfield":     "enfield",
    "kate_kar98k":      "kar98k",
    "kate_kbsp1938":    "kbsp1938",
    "kate_mas36":       "mas36",
    "kate_mosin":       "mosin",
    "kate_ptrs41":      "ptrs",
    "kate_springfield": "springfield",
    "kate_winchester94": "winchester94",
}


def add_scope_reticle(filepath, tfa_folder):
    """Add SWEP.ScopeReticle field to a weapon file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # Skip if already has ScopeReticle
    if 'SWEP.ScopeReticle' in src:
        # Update existing value
        src = re.sub(
            r'SWEP\.ScopeReticle\s*=\s*"[^"]*"',
            f'SWEP.ScopeReticle = "models/weapons/tfa_codww2/{tfa_folder}/scope_c"',
            src
        )
    else:
        # Add after the ScopeFov line, or after IronSightsAng
        reticle_line = f'\n-- Reticle texture for RT scope (from TFA source scope_c.vtf)\nSWEP.ScopeReticle = "models/weapons/tfa_codww2/{tfa_folder}/scope_c"\n'

        # Find insertion point: after IronSightsAng line
        insert_match = re.search(
            r'^(SWEP\.IronSightsAng\s*=\s*Vector\([^)]+\))',
            src, re.MULTILINE
        )
        if insert_match:
            insert_pos = insert_match.end()
            src = src[:insert_pos] + reticle_line + src[insert_pos:]
        else:
            print(f"  WARN: IronSightsAng not found in {os.path.basename(filepath)}")
            return False

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print("Adding ScopeReticle field to scoped weapons...")
    n = 0
    for kate_name, tfa_folder in SCOPE_RETICLE_MAP.items():
        filepath = os.path.join(WEAPONS_DIR, kate_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {kate_name}.lua")
            continue
        if add_scope_reticle(filepath, tfa_folder):
            print(f"  ADDED: {kate_name}.lua -> tfa_codww2/{tfa_folder}/scope_c")
            n += 1
    print(f"\nDone. Added ScopeReticle to {n} weapons.")


if __name__ == "__main__":
    main()
