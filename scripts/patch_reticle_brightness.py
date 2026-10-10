#!/usr/bin/env python3
"""
Patch all 8 RT scope attachment files to add brightness settings to the
Unlittwotexture material so the reticle overlay is fully visible.

The Unlittwotexture shader may render $texture2 darkly. Adding:
  $selfillum "1"           — makes the texture glow (full brightness)
  $selfillumtint "[1 1 1]" — white tint (full color)
  $color2 "[1 1 1]"        — full color modulation
ensures the reticle overlay is always bright and visible.
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

OLD = """        local mat = CreateMaterial(matName, "Unlittwotexture", {
            ["$basetexture"] = "gmod/scope",
            ["$texture2"] = reticlePath,
            ["$model"] = "1",
        })"""

NEW = """        local mat = CreateMaterial(matName, "Unlittwotexture", {
            ["$basetexture"] = "gmod/scope",
            ["$texture2"] = reticlePath,
            ["$model"] = "1",
            -- Make the reticle overlay fully bright and visible.
            -- $selfillum makes the texture glow at full brightness
            -- regardless of scene lighting.
            ["$selfillum"] = "1",
            ["$selfillumtint"] = "[1 1 1]",
            ["$color2"] = "[1 1 1]",
        })"""


def main():
    print(f"Patching {len(FILES)} scope attachment files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()

        if "$selfillum" in src:
            print(f"  SKIP (already patched): {fname}")
            continue

        if OLD not in src:
            print(f"  ERROR: pattern not found in {fname}")
            continue

        src = src.replace(OLD, NEW, 1)
        with open(path, "w", encoding="utf-8") as f:
            f.write(src)
        print(f"  PATCHED: {fname}")
        n += 1
    print(f"\nDone. Patched {n}/{len(FILES)} files.")


if __name__ == "__main__":
    main()
