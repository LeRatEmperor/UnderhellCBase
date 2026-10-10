#!/usr/bin/env python3
"""
Fix the missing "!" prefix in SetSubMaterial calls across all 7 RT scope
attachment files.

BUG: CreateMaterial names MUST be prefixed with "!" when used with
SetSubMaterial. Without "!", GMod looks for a .vmt file on disk
(which doesn't exist for CreateMaterial materials) and the override
silently fails.

This was the root cause of the RT scope not appearing — the
SetSubMaterial call was always silently failing because the "!" prefix
was missing.
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

# The buggy line (in RenderOverride)
OLD = 'self:SetSubMaterial(w._rtScopeSubMatIndex or 0, w._rtScopeMatName)'
NEW = 'self:SetSubMaterial(w._rtScopeSubMatIndex or 0, "!" .. w._rtScopeMatName)'


def main():
    print(f"Patching '!' prefix in {len(FILES)} files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()

        if OLD not in src:
            if '"!" .. w._rtScopeMatName' in src:
                print(f"  SKIP (already fixed): {fname}")
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
