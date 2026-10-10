#!/usr/bin/env python3
"""
Fix: cache Sensitivity origin so RestoreStat can restore it.

ROOT CAUSE (found by auditing the base):
  Detach() is NEVER CALLED by the base! ApplyAttachments does:
    Step 1: RestoreStat for all cached paths
    Step 5: Attach for equipped attachments (Detach is NOT called)

  Sensitivity is NOT in the topLevel stat cache list, so
  _statOrigins["Sensitivity"] is never set. RestoreStat("Sensitivity")
  does nothing (origin is nil). The stale 0.2 persists on self.Sensitivity.

  Our Detach purge code never runs because Detach is never called!

FIX:
  Add a hook that caches Sensitivity's origin value ONCE per weapon,
  before any attachments are applied. This way RestoreStat can restore
  the original (nil) value when the scope is deselected.

  The hook runs on PlayerWeaponDeployed (or Think as fallback) and:
  1. Checks if _statOrigins exists (InitStatCache has run)
  2. If _statOrigins["Sensitivity"] is not set, caches the current value
  3. This must happen BEFORE any attachment sets Sensitivity

  Also: override ApplyAttachments per-instance to purge Sensitivity
  from the stat cache when no scope attachment is equipped.
"""

import os

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"
AUTORUN_FILE = "/home/z/my-project/wwiiunderhell_kate/lua/autorun/cuh_rt_scope_render.lua"

# The code to add to the autorun file
CACHE_ORIGIN_CODE = """

-- ============================================================
-- Fix: Cache Sensitivity origin so RestoreStat can restore it
-- ============================================================
-- Sensitivity is NOT in the topLevel stat cache list, so
-- _statOrigins["Sensitivity"] is never set by InitStatCache.
-- When a scope attachment sets Sensitivity via SetStat, the origin
-- is lost. RestoreStat can't restore it, so the stale value persists.
--
-- This hook caches the origin ONCE per weapon, before any attachment
-- is applied. This way RestoreStat can restore the original (nil) value.
hook.Add("Think", "CUH_CacheSensitivityOrigin", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end
    if not wep.IsCUHWeapon then return end

    -- Wait for InitStatCache to run (creates _statOrigins)
    if not wep._statOrigins then return end

    -- Only cache once per weapon
    if wep._cuhSensOriginCached then return end

    -- Check if any scope attachment is currently equipped.
    -- If so, DON'T cache — the scope's 0.2 is not the origin.
    -- We need to cache the ORIGINAL value (before any scope).
    -- If Sensitivity is already set (scope equipped), we can't
    -- know the original — skip and try again when the weapon
    -- is freshly deployed.
    if wep.Sensitivity ~= nil then
        -- A scope is already equipped. We can't cache the origin.
        -- Mark as cached anyway to stop checking (we'll handle this
        -- via the ApplyAttachments override below).
        wep._cuhSensOriginCached = true
        return
    end

    -- Cache the origin (nil = no scope, normal sensitivity)
    wep._statOrigins["Sensitivity"] = wep.Sensitivity  -- nil
    wep._cuhSensOriginCached = true
end)

-- ============================================================
-- Fix: Purge Sensitivity after ApplyAttachments when no scope equipped
-- ============================================================
-- Since Detach is never called, we need to clear Sensitivity ourselves
-- when no scope attachment is equipped. Override ApplyAttachments
-- per-instance to add a post-apply cleanup step.
hook.Add("Think", "CUH_PatchApplyAttachments", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end
    if not wep.IsCUHWeapon then return end
    if not wep.ApplyAttachments then return end

    -- Only patch once per weapon
    if wep._cuhApplyPatched then return end
    wep._cuhApplyPatched = true

    local origApply = wep.ApplyAttachments
    wep.ApplyAttachments = function(self)
        -- Call the original ApplyAttachments
        origApply(self)

        -- Post-apply: check if any scope attachment is equipped
        -- by checking if ScopeTexture is set (scope attachments
        -- set ScopeTexture in their Attach function)
        if not self.ScopeTexture then
            -- No scope equipped — purge Sensitivity from cache + field
            if self._statCache then
                self._statCache["Sensitivity"] = nil
            end
            if self._statOrigins then
                self._statOrigins["Sensitivity"] = nil
            end
            self.Sensitivity = nil
        end
    end
end)
"""


def add_to_autorun():
    """Add the cache origin code to the autorun file."""
    with open(AUTORUN_FILE, 'r', encoding='utf-8') as f:
        src = f.read()

    if "CUH_CacheSensitivityOrigin" in src:
        print("  SKIP: autorun already patched")
        return False

    # Insert before the cuh_ironsight_dump command
    marker = "-- ============================================================\n-- Console command: cuh_ironsight_dump"
    if marker not in src:
        print("  ERROR: marker not found in autorun")
        return False

    src = src.replace(marker, CACHE_ORIGIN_CODE.strip() + "\n\n" + marker, 1)

    with open(AUTORUN_FILE, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def remove_detach_purge():
    """Remove the now-useless purge code from Detach functions."""
    FILES = [
        "tfa_codww2_mosin_scope.lua", "tfa_codww2_arisaka_scope.lua",
        "tfa_codww2_springfield_scope.lua", "tfa_codww2_kar98k_scope.lua",
        "tfa_codww2_enfield_scope.lua", "tfa_codww2_scope.lua",
        "tfa_codww2_4x.lua", "tfa_codww2_lens_sight.lua",
    ]

    purge_block = """    -- CRITICAL: Purge Sensitivity from the stat cache.
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

"""

    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            continue
        with open(path, 'r', encoding='utf-8') as f:
            src = f.read()
        if purge_block in src:
            src = src.replace(purge_block, "", 1)
            with open(path, 'w', encoding='utf-8') as f:
                f.write(src)
            print(f"  CLEANED: {fname}")


def main():
    print("=== Adding cache origin + ApplyAttachments override to autorun ===")
    if add_to_autorun():
        print("  PATCHED: cuh_rt_scope_render.lua")

    print("\n=== Removing useless Detach purge code ===")
    remove_detach_purge()


if __name__ == "__main__":
    main()
