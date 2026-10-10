#!/usr/bin/env python3
"""
Revert all 8 RT scope attachment files back to Unlittwotexture shader.

The Unlittwotexture approach was the ONLY one where the reticle actually
appeared on the scope lens. The RT compositing approaches (cam.Start2D,
surface.DrawTexturedRect, render.DrawScreenQuadEx) never worked — the
reticle draws never appeared on the RT.

The Unlittwotexture approach:
  $basetexture → set to RT at runtime (the 3D scene)
  $texture2    → the reticle texture (static, always visible on top)

The issue was that the reticle was too DARK. This is likely a VTF
texture format issue (the user converted PNGs to VTFs manually).
The user will investigate the VTF setup.

This script reverts from UnlitGeneric back to Unlittwotexture.
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

OLD = """        -- Use UnlitGeneric shader (bright RT, no darkening).
        -- The reticle is composited onto the RT in the RenderScene hook
        -- via render.SetRenderTarget + render.DrawScreenQuadEx.
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })"""

NEW = """        -- Use Unlittwotexture shader: $basetexture gets the RT (3D scene),
        -- $texture2 gets the reticle texture (static, always visible on top).
        -- This is the ONLY approach where the reticle actually appeared.
        -- The brightness/darkness issue is likely a VTF texture format problem.
        local reticlePath = wep.ScopeReticle or "gmod/scope"
        local mat = CreateMaterial(matName, "Unlittwotexture", {
            ["$basetexture"] = "gmod/scope",
            ["$texture2"] = reticlePath,
            ["$model"] = "1",
            ["$selfillum"] = "1",
            ["$selfillumtint"] = "[1 1 1]",
            ["$color2"] = "[1 1 1]",
        })"""


def main():
    print(f"Reverting {len(FILES)} files to Unlittwotexture...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()

        if "Unlittwotexture" in src:
            print(f"  SKIP (already Unlittwotexture): {fname}")
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
