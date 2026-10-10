#!/usr/bin/env python3
"""
Patch all 8 RT scope attachment files to use the Unlittwotexture shader.

INSIGHT:
  The reticle is NOT a separate sub-material on the scope model. It's a
  SECOND TEXTURE CHANNEL on the SAME material. The Unlittwotexture shader
  supports two textures:
    $basetexture  — set to the RT at runtime (the 3D scene)
    $texture2     — the reticle texture (static, always visible on top)

  This is how the RPG-7 does it:
    CreateMaterial("UH_RPG-7_Scope_8", "Unlittwotexture", {
        ["$texture2"] = "vgui/scope_lens_g36k",
        ["$model"] = "1"
    })

  The RT replaces $basetexture (via SetTexture in the RenderScene hook),
  but $texture2 (the reticle) remains static, always visible on top.

CHANGES:
  1. Change CreateMaterial from "UnlitGeneric" to "Unlittwotexture"
  2. Add ["$texture2"] = wep.ScopeReticle or "gmod/scope"
  3. Remove the reticle sub-material logic from RenderOverride
     (it's no longer needed — the reticle is on $texture2)
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

# Old CreateMaterial block (UnlitGeneric)
OLD_CREATEMAT = """        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })"""

# New CreateMaterial block (Unlittwotexture with reticle on $texture2)
NEW_CREATEMAT = """        -- Use Unlittwotexture shader: $basetexture gets the RT (3D scene),
        -- $texture2 gets the reticle texture (static, always visible on top).
        -- This is how the RPG-7 and Scout sniper keep the reticle visible.
        local reticlePath = wep.ScopeReticle or "gmod/scope"
        local mat = CreateMaterial(matName, "Unlittwotexture", {
            ["$basetexture"] = "gmod/scope",
            ["$texture2"] = reticlePath,
            ["$model"] = "1",
        })"""


def patch_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = os.path.basename(filepath)
    changed = False

    # 1. Replace CreateMaterial block
    if OLD_CREATEMAT in src:
        src = src.replace(OLD_CREATEMAT, NEW_CREATEMAT, 1)
        changed = True
    elif 'Unlittwotexture' in src:
        print(f"  SKIP (already has Unlittwotexture): {fname}")
        return False

    # 2. Remove the reticle sub-material logic from RenderOverride
    # The reticle is now on $texture2, so we don't need to set it as a
    # separate sub-material. Simplify the RenderOverride to only set the lens.
    
    # Find and remove the reticleIdx block
    old_reticle_block = """                    -- Set TWO sub-materials: lens (RT) + reticle (scope_c texture)
                    -- The reticle renders ABOVE the RT lens on the scope model
                    local reticleIdx = nil
                    if mats and #mats > 0 then
                        for i = 1, #mats do
                            if (i - 1) ~= lensIdx then
                                reticleIdx = i - 1
                                break
                            end
                        end
                    end
                    if not reticleIdx then reticleIdx = 0 end
                    w._rtScopeReticleIdx = reticleIdx

"""
    if old_reticle_block in src:
        src = src.replace(old_reticle_block, "", 1)

    # Also handle the lens_sight variant
    old_reticle_block2 = """                    -- Set TWO sub-materials: lens (RT) + reticle (scope_c texture)
                    local reticleIdx = nil
                    if mats and #mats > 0 then
                        for i = 1, #mats do
                            if (i - 1) ~= lensIdx then
                                reticleIdx = i - 1
                                break
                            end
                        end
                    end
                    if not reticleIdx then reticleIdx = 0 end
                    w._rtScopeReticleIdx = reticleIdx

"""
    if old_reticle_block2 in src:
        src = src.replace(old_reticle_block2, "", 1)

    # Remove the reticle SetSubMaterial call in RenderOverride
    old_reticle_setmat = """                        -- Set the reticle texture on the OTHER material index
                        if w.ScopeReticle then
                            self:SetSubMaterial(w._rtScopeReticleIdx or 0, w.ScopeReticle)
                        end
"""
    if old_reticle_setmat in src:
        src = src.replace(old_reticle_setmat, "", 1)

    # Also handle lens_sight variant (no comment)
    old_reticle_setmat2 = """                        if w.ScopeReticle then
                            self:SetSubMaterial(w._rtScopeReticleIdx or 0, w.ScopeReticle)
                        end
"""
    if old_reticle_setmat2 in src:
        src = src.replace(old_reticle_setmat2, "", 1)

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
