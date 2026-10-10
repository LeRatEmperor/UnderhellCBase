#!/usr/bin/env python3
"""
Add a defensive recursion guard to all 7 RT-scope attachment files.

We already patched the main bug (capture prevThink as local upvalue + gate
with _rtScopeHooked).  This script adds one more defensive layer:

    if prevThink and prevThink ~= w.CustomThink then
        prevThink(w, ct)
    end

The `prevThink ~= w.CustomThink` check guarantees we NEVER call ourselves,
which makes the code bulletproof against any stale state from a previous
Lua refresh / mid-game reload.

Also adds a re-entry guard (`_rtScopeInThink`) so that even if some other
code path somehow re-enters our closure, we exit immediately.
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

OLD_INNER = """            wep.CustomThink = function(w, ct)
                -- Run previous CustomThink via the LOCAL upvalue
                if prevThink then prevThink(w, ct) end

                if not w._rtScopeMatName then return end"""

NEW_INNER = """            wep.CustomThink = function(w, ct)
                -- Re-entry guard: if we're already inside this closure
                -- (e.g. due to stale state from a previous Lua refresh),
                -- bail out immediately to prevent any recursion.
                if w._rtScopeInThink then return end
                w._rtScopeInThink = true

                -- Run previous CustomThink via the LOCAL upvalue.
                -- NEVER call ourselves (recursion guard): if prevThink
                -- happens to be the same function as w.CustomThink,
                -- skip the call.
                if prevThink and prevThink ~= w.CustomThink then
                    prevThink(w, ct)
                end

                if not w._rtScopeMatName then
                    w._rtScopeInThink = nil
                    return
                end"""

# We also need to clear the re-entry guard at every return point in the
# closure body.  Let me patch the existing returns.
OLD_RETURNS = [
    ("                if not w.ViewModelElements then return end",
     "                if not w.ViewModelElements then w._rtScopeInThink = nil return end"),
    ("                local elem = w.ViewModelElements[w._rtScopeVElement]\n                if not elem or not IsValid(elem._csModel) then return end",
     "                local elem = w.ViewModelElements[w._rtScopeVElement]\n                if not elem or not IsValid(elem._csModel) then w._rtScopeInThink = nil return end"),
]

# And clear it at the end of the closure (after SetSubMaterial).
OLD_END = """                -- Apply the sub-material override EVERY FRAME
                csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
            end"""

NEW_END = """                -- Apply the sub-material override EVERY FRAME
                csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
                w._rtScopeInThink = nil
            end"""


def patch_file(path: str) -> bool:
    with open(path, "r", encoding="utf-8") as f:
        src = f.read()

    if "_rtScopeInThink" in src:
        print(f"  SKIP (already has re-entry guard): {os.path.basename(path)}")
        return False

    if OLD_INNER not in src:
        print(f"  ERROR: inner block not found in {os.path.basename(path)}")
        return False

    src = src.replace(OLD_INNER, NEW_INNER, 1)

    for old, new in OLD_RETURNS:
        if old not in src:
            print(f"  WARN: return pattern not found in {os.path.basename(path)}: {old[:60]}...")
        else:
            src = src.replace(old, new, 1)

    if OLD_END not in src:
        print(f"  ERROR: closure end not found in {os.path.basename(path)}")
        return False
    src = src.replace(OLD_END, NEW_END, 1)

    with open(path, "w", encoding="utf-8") as f:
        f.write(src)
    print(f"  PATCHED: {os.path.basename(path)}")
    return True


def main():
    print(f"Adding re-entry guard to {len(FILES)} files...")
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
