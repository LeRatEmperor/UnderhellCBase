#!/usr/bin/env python3
"""
Patch the CreateMaterial default basetexture in all 7 RT scope attachment
files from "vgui/scope_lens" (which does not exist in standard GMod,
causing the pink/black missing texture) to "gmod/scope" (the standard
GMod crossbow scope texture, which definitely exists).

The RenderScene hook in cuh_rt_scope_render.lua overrides this basetexture
every frame (to the RT when zooming, to gmod/scope when not zooming),
so the default only matters for the first frame after Attach().  But
fixing it prevents the one-frame missing-texture flash.
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
]

OLD = '["$basetexture"] = "vgui/scope_lens"'
NEW = '["$basetexture"] = "gmod/scope"'


def main():
    print(f"Patching CreateMaterial default basetexture in {len(FILES)} files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()
        if OLD not in src:
            if "gmod/scope" in src:
                print(f"  SKIP (already patched): {fname}")
                continue
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
