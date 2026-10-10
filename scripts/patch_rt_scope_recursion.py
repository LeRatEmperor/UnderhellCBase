#!/usr/bin/env python3
"""
Patch the RT-scope stack overflow bug in 7 attachment files.

ROOT CAUSE
----------
The buggy block stores the previous CustomThink in
`wep._rtScopePrevThink` and the new closure calls
`w._rtScopePrevThink(w, ct)` at *call time* (via the weapon table
field).  When Attach() runs a second time without a Detach() in
between (which happens routinely, because ApplyAttachments re-runs on
every attachment change / weapon switch / SWEP:Initialize), the chain
becomes self-referential:

    1st Attach:  _rtScopePrevThink = nil,  CustomThink = closure1
    2nd Attach:  _rtScopePrevThink = closure1, CustomThink = closure2
    Think tick:  closure2 calls w._rtScopePrevThink -> closure1
                 closure1 calls w._rtScopePrevThink -> closure1 (still!)
                 -> infinite recursion -> stack overflow

FIX
---
1. Capture prevThink as a LOCAL upvalue so each closure remembers its
   own predecessor and never re-reads the weapon-table field.
2. Gate the hook with a `wep._rtScopeHooked` flag so a second Attach()
   without a Detach() does not re-hook (idempotent).
3. Detach() resets the flag so a future Attach() can re-hook cleanly.
"""

import os
import sys

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

# ---------------------------------------------------------------------------
# The OLD (buggy) Attach-block portion we want to replace.
# Spans from "wep._rtScopePrevThink = wep.CustomThink" up to the closing "end"
# of the CustomThink assignment.  We match it exactly.
# ---------------------------------------------------------------------------
OLD_BLOCK = """        wep._rtScopePrevThink = wep.CustomThink
        wep.CustomThink = function(w, ct)
            -- Run any previous CustomThink
            if w._rtScopePrevThink then w._rtScopePrevThink(w, ct) end

            if not w._rtScopeMatName then return end
            if not w.ViewModelElements then return end
            local elem = w.ViewModelElements[w._rtScopeVElement]
            if not elem or not IsValid(elem._csModel) then return end
            local csModel = elem._csModel

            -- Find the lens sub-material index (only once, then cache it)
            if not w._rtScopeSubMatIndex then
                local mats = csModel:GetMaterials()
                if mats then
                    for i = 1, #mats do
                        local mn = string.lower(tostring(mats[i]))
                        if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                            w._rtScopeSubMatIndex = i - 1  -- 0-based
                            break
                        end
                    end
                end
                -- If not found by name, try index 0 (first material is often the lens)
                if not w._rtScopeSubMatIndex then
                    w._rtScopeSubMatIndex = 0
                end
            end

            -- Apply the sub-material override EVERY FRAME
            csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
        end
"""

NEW_BLOCK = """        -- CRITICAL: only hook CustomThink ONCE per weapon.
        -- The OLD code re-saved prev think into wep._rtScopePrevThink every
        -- Attach() call, but the closure body read w._rtScopePrevThink at
        -- *call time*. After a second Attach() (which happens routinely —
        -- ApplyAttachments re-runs on every attachment change, weapon switch,
        -- SWEP:Initialize), the field pointed back at our own closure →
        -- infinite recursion → stack overflow.
        -- Fix: capture prevThink as a LOCAL upvalue, and gate with _rtScopeHooked.
        if not wep._rtScopeHooked then
            wep._rtScopeHooked = true
            local prevThink = wep.CustomThink
            wep._rtScopePrevThink = prevThink

            wep.CustomThink = function(w, ct)
                -- Run previous CustomThink via the LOCAL upvalue
                if prevThink then prevThink(w, ct) end

                if not w._rtScopeMatName then return end
                if not w.ViewModelElements then return end
                local elem = w.ViewModelElements[w._rtScopeVElement]
                if not elem or not IsValid(elem._csModel) then return end
                local csModel = elem._csModel

                -- Find the lens sub-material index (only once, then cache it)
                if not w._rtScopeSubMatIndex then
                    local mats = csModel:GetMaterials()
                    if mats then
                        for i = 1, #mats do
                            local mn = string.lower(tostring(mats[i]))
                            if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                                w._rtScopeSubMatIndex = i - 1  -- 0-based
                                break
                            end
                        end
                    end
                    -- If not found by name, try index 0 (first material is often the lens)
                    if not w._rtScopeSubMatIndex then
                        w._rtScopeSubMatIndex = 0
                    end
                end

                -- Apply the sub-material override EVERY FRAME
                csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
            end
        end
"""

# ---------------------------------------------------------------------------
# In Detach() we also need to clear the _rtScopeHooked flag so a future
# Attach() can re-hook cleanly.
# ---------------------------------------------------------------------------
OLD_DETACH_TAIL = """        wep._rtScopeMatName = nil
        wep._rtScopeVElement = nil
        wep._rtScopeSubMatIndex = nil
    end
end"""

NEW_DETACH_TAIL = """        wep._rtScopeMatName = nil
        wep._rtScopeVElement = nil
        wep._rtScopeSubMatIndex = nil
        wep._rtScopeHooked = nil  -- allow a future Attach() to re-hook
    end
end"""


def patch_file(path: str) -> bool:
    with open(path, "r", encoding="utf-8") as f:
        src = f.read()

    if "_rtScopeHooked" in src:
        print(f"  SKIP (already patched): {os.path.basename(path)}")
        return False

    if OLD_BLOCK not in src:
        print(f"  ERROR: buggy Attach block not found in {os.path.basename(path)}")
        return False

    if OLD_DETACH_TAIL not in src:
        print(f"  ERROR: Detach tail not found in {os.path.basename(path)}")
        return False

    src = src.replace(OLD_BLOCK, NEW_BLOCK, 1)
    src = src.replace(OLD_DETACH_TAIL, NEW_DETACH_TAIL, 1)

    with open(path, "w", encoding="utf-8") as f:
        f.write(src)
    print(f"  PATCHED: {os.path.basename(path)}")
    return True


def main():
    print(f"Patching RT-scope stack overflow in {len(FILES)} files...")
    n = 0
    for fname in FILES:
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        if patch_file(path):
            n += 1
    print(f"\nDone. Patched {n}/{len(FILES)} files.")


if __name__ == "__main__":
    main()
