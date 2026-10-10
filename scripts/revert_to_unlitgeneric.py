#!/usr/bin/env python3
"""
Revert CreateMaterial from Unlittwotexture back to UnlitGeneric.

ROOT CAUSE:
  The Unlittwotexture shader MULTIPLIES $basetexture × $texture2.
  Where the overlay texture is black (non-reticle areas), the RT
  becomes black (RT × 0 = 0). This darkens the ENTIRE scope view.

  $selfillum only affects $texture2, not the combined result.
  So the RT 3D scene is barely visible.

FIX:
  Revert to UnlitGeneric (which was bright — the RT 3D scene was
  clearly visible). The reticle will be composited onto the RT
  in the RenderScene hook using:
    1. render.SetRenderTarget (re-set RT after RenderView resets it)
    2. render.ClearDepth (clear depth buffer so draws appear)
    3. render.SetMaterial + render.DrawScreenQuadEx (draw reticle)
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

OLD = """        -- Use Unlittwotexture shader: $basetexture gets the RT (3D scene),
        -- $texture2 gets the reticle texture (static, always visible on top).
        -- This is how the RPG-7 and Scout sniper keep the reticle visible.
        local reticlePath = wep.ScopeReticle or "gmod/scope"
        local mat = CreateMaterial(matName, "Unlittwotexture", {
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

NEW = """        -- Use UnlitGeneric shader (bright RT, no darkening).
        -- The reticle is composited onto the RT in the RenderScene hook
        -- via render.SetRenderTarget + render.DrawScreenQuadEx.
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })"""


def main():
    print(f"Reverting {len(FILES)} files to UnlitGeneric...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()

        if "UnlitGeneric" in src and "Unlittwotexture" not in src:
            print(f"  SKIP (already UnlitGeneric): {fname}")
            continue

        if OLD not in src:
            print(f"  ERROR: pattern not found in {fname}")
            continue

        src = src.replace(OLD, NEW, 1)
        with open(path, "w", encoding="utf-8") as f:
            f.write(src)
        print(f"  REVERTED: {fname}")
        n += 1
    print(f"\nDone. Reverted {n}/{len(FILES)} files.")


if __name__ == "__main__":
    main()
