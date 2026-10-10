#!/usr/bin/env python3
"""
Fix sensitivity persistence by purging the stat cache entry in Detach.

ROOT CAUSE:
  Sensitivity is NOT in the topLevel stat cache list in InitStatCache.
  So _statOrigins["Sensitivity"] is never set. When RestoreStat is
  called, it does nothing (origin is nil). The stale value (0.2)
  persists in _statCache and gets re-applied by FlushStats.

  Even though Detach sets wep.Sensitivity = nil, FlushStats later
  re-applies the cached value: self.Sensitivity = 0.2.

FIX:
  In Detach, also purge the stat cache entries:
    wep._statCache["Sensitivity"] = nil
    wep._statOrigins["Sensitivity"] = nil
  This ensures FlushStats won't re-apply the stale value.

  Also set wep.Sensitivity = nil explicitly (belt and suspenders).
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

# Old Detach pattern (after removing the manual Sensitivity = nil)
# We need to find a unique anchor in each Detach function to insert after
# The common line is: wep.Use2DScope = false
OLD = """    wep.Use2DScope = false

    if CLIENT then
        -- Remove RenderOverride and restore sub-material"""

NEW = """    wep.Use2DScope = false

    -- CRITICAL: Purge Sensitivity from the stat cache.
    -- Sensitivity is NOT in the topLevel stat cache list, so
    -- RestoreStat can't restore its original value. The stale 0.2
    -- value persists in _statCache and gets re-applied by FlushStats.
    -- We must manually purge it here.
    if wep._statCache then
        wep._statCache["Sensitivity"] = nil
    end
    if wep._statOrigins then
        wep._statOrigins["Sensitivity"] = nil
    end
    wep.Sensitivity = nil

    if CLIENT then
        -- Remove RenderOverride and restore sub-material"""


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

        if "_statCache" in src:
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
