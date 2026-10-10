#!/usr/bin/env python3
"""
Patch all 7 remaining RT scope attachment files to set the reticle texture
on the scope model's non-lens material index.
"""

import os

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

FILES = [
    "tfa_codww2_arisaka_scope.lua",
    "tfa_codww2_springfield_scope.lua",
    "tfa_codww2_kar98k_scope.lua",
    "tfa_codww2_enfield_scope.lua",
    "tfa_codww2_scope.lua",
    "tfa_codww2_4x.lua",
    "tfa_codww2_lens_sight.lua",
]

OLD = """                    csModel.RenderOverride = function(self)
                        -- Set the sub-material RIGHT BEFORE drawing
                        if w._rtScopeMatName then
                            self:SetSubMaterial(w._rtScopeSubMatIndex or 0, "!" .. w._rtScopeMatName)
                        end

                        -- Temporarily remove RenderOverride so DrawModel
                        -- does the actual rendering (not recursion)
                        local savedOverride = self.RenderOverride
                        self.RenderOverride = nil
                        self:DrawModel()
                        self.RenderOverride = savedOverride
                    end"""

NEW = """                    -- Set TWO sub-materials: lens (RT) + reticle (scope_c texture)
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

                    csModel.RenderOverride = function(self)
                        -- Set the RT on the lens material
                        if w._rtScopeMatName then
                            self:SetSubMaterial(w._rtScopeSubMatIndex or 0, "!" .. w._rtScopeMatName)
                        end

                        -- Set the reticle texture on the OTHER material index
                        if w.ScopeReticle then
                            self:SetSubMaterial(w._rtScopeReticleIdx or 0, w.ScopeReticle)
                        end

                        -- Temporarily remove RenderOverride so DrawModel
                        -- does the actual rendering (not recursion)
                        local savedOverride = self.RenderOverride
                        self.RenderOverride = nil
                        self:DrawModel()
                        self.RenderOverride = savedOverride
                    end"""


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

        if "_rtScopeReticleIdx" in src:
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
