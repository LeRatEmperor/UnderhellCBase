#!/usr/bin/env python3
"""
Patch all 8 RT scope attachment files to:
1. Override DrawVElements per-instance to skip drawing during RT pass
2. Fix the 4x ACOG ironsight function (remove _7X check)
3. Add a cuh_ironsight_dump console command in the autorun file

ISSUE 2 FIX (Viewmodel Clipping):
  DrawVElements is called during render.RenderView (via PostDrawViewModel
  hook), drawing VElements into the RT. SetNoDraw doesn't help because
  DrawModel() is called explicitly. Fix: override DrawVElements on the
  weapon INSTANCE (not the base file) to check _rtScopeSuppressVElem.

ISSUE 4 FIX (Ironsight Alignment):
  The 4x ACOG checks wep.IronSightsPos_7X FIRST, which returns the 7x
  scope position instead of the ACOG position. Fix: remove the _7X
  check from the 4x ACOG attachment.
"""

import os
import re

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

# Files that need the DrawVElements override added
SCOPE_FILES = [
    "tfa_codww2_mosin_scope.lua",
    "tfa_codww2_arisaka_scope.lua",
    "tfa_codww2_springfield_scope.lua",
    "tfa_codww2_kar98k_scope.lua",
    "tfa_codww2_enfield_scope.lua",
    "tfa_codww2_scope.lua",
    "tfa_codww2_4x.lua",
    "tfa_codww2_lens_sight.lua",
]


def patch_draw_velements(filepath):
    """Add DrawVElements override to the Attach function."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    if '_rtScopePrevDrawVE' in src:
        return False  # already patched

    # Find the line "if not wep._rtScopeHooked then" and insert BEFORE it
    marker = '        if not wep._rtScopeHooked then'
    if marker not in src:
        print(f"  ERROR: marker not found in {os.path.basename(filepath)}")
        return False

    override_code = """        -- CRITICAL: Override DrawVElements per-instance to skip drawing
        -- during the RT render pass. The base's DrawVElements is called
        -- during render.RenderView (via PostDrawViewModel), which draws
        -- VElements (long barrels, suppressors, front sights) into the RT.
        -- SetNoDraw doesn't help because DrawModel() is called explicitly.
        -- This per-instance override checks the _rtScopeSuppressVElem flag
        -- set by the RenderScene hook in cuh_rt_scope_render.lua.
        wep._rtScopePrevDrawVE = wep.DrawVElements
        wep.DrawVElements = function(self, vm)
            if self._rtScopeSuppressVElem then return end
            if self._rtScopePrevDrawVE then
                self._rtScopePrevDrawVE(self, vm)
            end
        end

"""
    src = src.replace(marker, override_code + marker, 1)

    # Also add cleanup in Detach: restore DrawVElements
    detach_marker = "        wep._rtScopeHooked = nil"
    if detach_marker in src:
        restore_code = """        wep._rtScopeHooked = nil
        -- Restore original DrawVElements
        if wep._rtScopePrevDrawVE then
            wep.DrawVElements = wep._rtScopePrevDrawVE
            wep._rtScopePrevDrawVE = nil
        end"""
        src = src.replace(detach_marker, restore_code, 1)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def fix_acog_ironsight(filepath):
    """Fix the 4x ACOG ironsight function to not check _7X first."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    old = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,'
    new = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_ACOG or val end,'
    old2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,'
    new2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_ACOG or val end,'

    if old not in src:
        return False

    src = src.replace(old, new, 1)
    src = src.replace(old2, new2, 1)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def fix_lens_ironsight(filepath):
    """Ensure lens sight uses _Lens suffix, not _7X."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    # The lens sight should already have the correct function
    # but let's verify
    if 'IronSightsPos_Lens' in src:
        return False  # already correct

    old = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,'
    new = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Lens or val end,'
    old2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,'
    new2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Lens or val end,'

    if old not in src:
        return False

    src = src.replace(old, new, 1)
    src = src.replace(old2, new2, 1)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def fix_7x_ironsight(filepath):
    """The 7x scope attachments should use _7X suffix only (not _ACOG fallback)."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    old = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,'
    new = '["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or val end,'
    old2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,'
    new2 = '["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or val end,'

    if old not in src:
        return False

    src = src.replace(old, new, 1)
    src = src.replace(old2, new2, 1)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)
    return True


def main():
    print("=== Patching DrawVElements override ===")
    for fname in SCOPE_FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        if patch_draw_velements(path):
            print(f"  PATCHED: {fname}")
        else:
            print(f"  SKIP: {fname}")

    print("\n=== Fixing 4x ACOG ironsight function ===")
    path = os.path.join(ATTACHMENTS_DIR, "tfa_codww2_4x.lua")
    if fix_acog_ironsight(path):
        print(f"  FIXED: tfa_codww2_4x.lua (removed _7X check)")
    else:
        print(f"  SKIP: tfa_codww2_4x.lua")

    print("\n=== Fixing lens sight ironsight function ===")
    path = os.path.join(ATTACHMENTS_DIR, "tfa_codww2_lens_sight.lua")
    if fix_lens_ironsight(path):
        print(f"  FIXED: tfa_codww2_lens_sight.lua")
    else:
        print(f"  SKIP: tfa_codww2_lens_sight.lua (already correct)")

    print("\n=== Fixing 7x scope ironsight functions ===")
    # The 7x scope attachments (mosin, arisaka, springfield, kar98k, enfield, scope)
    # should use _7X only, not _ACOG fallback
    for fname in ["tfa_codww2_mosin_scope.lua", "tfa_codww2_arisaka_scope.lua",
                   "tfa_codww2_springfield_scope.lua", "tfa_codww2_kar98k_scope.lua",
                   "tfa_codww2_enfield_scope.lua", "tfa_codww2_scope.lua"]:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if fix_7x_ironsight(path):
            print(f"  FIXED: {fname} (using _7X only)")
        else:
            print(f"  SKIP: {fname}")


if __name__ == "__main__":
    main()
