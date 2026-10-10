#!/usr/bin/env python3
"""
Fix the DrawVElements stack overflow bug in all 8 RT scope attachment files.

SAME BUG as the CustomThink recursion from earlier:
  - wep._rtScopePrevDrawVE is read at CALL TIME (via the weapon table field)
  - When Attach() runs a second time (which happens routinely — ApplyAttachments
    re-runs on every attachment change, weapon switch, SWEP:Initialize),
    wep._rtScopePrevDrawVE points to our own closure → infinite recursion

FIX (same pattern that worked for CustomThink):
  1. Capture prevDrawVE as a LOCAL upvalue (not a weapon table field)
  2. Gate with _rtScopeDrawVEHooked flag (idempotent — only hook once)
  3. Detach() clears the flag so a future Attach() can re-hook
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

OLD = """        wep._rtScopePrevDrawVE = wep.DrawVElements
        wep.DrawVElements = function(self, vm)
            if self._rtScopeSuppressVElem then return end
            if self._rtScopePrevDrawVE then
                self._rtScopePrevDrawVE(self, vm)
            end
        end
"""

NEW = """        -- CRITICAL: capture prevDrawVE as a LOCAL upvalue (NOT a weapon
        -- table field). Reading self._rtScopePrevDrawVE at call time causes
        -- infinite recursion when Attach() runs a second time (the field
        -- then points to our own closure). Same bug pattern as CustomThink.
        -- Gate with _rtScopeDrawVEHooked so we only hook once per weapon.
        if not wep._rtScopeDrawVEHooked then
            wep._rtScopeDrawVEHooked = true
            local prevDrawVE = wep.DrawVElements
            wep._rtScopePrevDrawVE = prevDrawVE

            wep.DrawVElements = function(self, vm)
                if self._rtScopeSuppressVElem then return end
                -- Call previous DrawVElements via the LOCAL upvalue.
                -- NEVER call ourselves (recursion guard).
                if prevDrawVE and prevDrawVE ~= self.DrawVElements then
                    prevDrawVE(self, vm)
                end
            end
        end
"""

# Also fix Detach to clear the new flag
OLD_DETACH = """        wep._rtScopeHooked = nil
        -- Restore original DrawVElements
        if wep._rtScopePrevDrawVE then
            wep.DrawVElements = wep._rtScopePrevDrawVE
            wep._rtScopePrevDrawVE = nil
        end"""

NEW_DETACH = """        wep._rtScopeHooked = nil
        wep._rtScopeDrawVEHooked = nil
        -- Restore original DrawVElements
        if wep._rtScopePrevDrawVE then
            wep.DrawVElements = wep._rtScopePrevDrawVE
            wep._rtScopePrevDrawVE = nil
        end"""


def main():
    print(f"Fixing DrawVElements recursion in {len(FILES)} files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        with open(path, "r", encoding="utf-8") as f:
            src = f.read()

        if "_rtScopeDrawVEHooked" in src:
            print(f"  SKIP (already fixed): {fname}")
            continue

        if OLD not in src:
            print(f"  ERROR: old block not found in {fname}")
            continue

        src = src.replace(OLD, NEW, 1)

        if OLD_DETACH in src:
            src = src.replace(OLD_DETACH, NEW_DETACH, 1)
        else:
            print(f"  WARN: detach block not found in {fname}")

        with open(path, "w", encoding="utf-8") as f:
            f.write(src)
        print(f"  FIXED: {fname}")
        n += 1
    print(f"\nDone. Fixed {n}/{len(FILES)} files.")


if __name__ == "__main__":
    main()
