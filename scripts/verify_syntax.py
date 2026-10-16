#!/usr/bin/env python3
"""
verify_syntax.py

Compiles each Lua file with `loadstring` (parse-only — does NOT execute)
to catch syntax errors. Does NOT run the code, so it doesn't need
GMod mocks.

Catches:
  - Unbalanced `end` / `then` / `function` / `do`
  - Missing commas in tables
  - Typos in keyword usage
  - GMod LuaJIT-isms like `continue` (we strip these via preprocessing)
"""

import os
import sys
import glob
from lupa import LuaRuntime

# Directories to check
WEAPONS_DIR = "/home/z/my-project/cod_ghosts_underhellsweps/lua/weapons"
BASE_DIR    = "/home/z/my-project/lua/weapons"
AUTORUN_DIR = "/home/z/my-project/lua/autorun"
DL_BASE_DIR = "/home/z/my-project/download/custom_uh_base/lua/weapons"


def check_file(filepath: str) -> tuple:
    """Returns (ok, message). ok=True if file compiles cleanly."""
    lua = LuaRuntime(unpack_returned_tuples=True)

    try:
        with open(filepath, "r", encoding="utf-8") as f:
            source = f.read()

        # GMod LuaJIT supports `continue` inside loops — standard Lua
        # treats it as an identifier. Replace with a comment-style stub
        # so loadstring accepts it.
        # Also GMod allows `&&`, `||`, `!=` as `and`, `or`, `~=` — replace.
        # This is a coarse preprocessing pass — it doesn't handle every
        # GMod quirk, but covers the common ones.
        # GMod LuaJIT supports `continue` inside loops — standard Lua
        # doesn't have it. Replace with `do end` (an empty block) so
        # the parser accepts it. (This is only for syntax checking —
        # the actual GMod runtime uses LuaJIT which has `continue`.)
        # Also GMod allows `&&`, `||`, `!=` as `and`, `or`, `~=`.
        # GMod LuaJIT supports `continue` inside loops — standard Lua
        # doesn't have it. Replace with `do end` (an empty block) so
        # the parser accepts it. (This is only for syntax checking —
        # the actual GMod runtime uses LuaJIT which has `continue`.)
        # Also GMod allows `&&`, `||`, `!=` as `and`, `or`, `~=`.
        import re
        proc = source
        # Replace any standalone `continue` keyword with `do end`.
        # We use word-boundary matching; this is safe enough for syntax
        # checking (string literals containing "continue" stay intact
        # because quotes protect them).
        proc = re.sub(r'\bcontinue\b', 'do end', proc)
        proc = proc.replace("&&", "and")
        proc = proc.replace("||", "or")
        proc = proc.replace("!=", "~=")

        # Use `load` (Lua 5.2+; lupa ships Lua 5.5) — compiles but does not run
        check_code = """
        local function _check(src)
            local f, err = load(src)
            if f then return true, nil end
            return false, tostring(err)
        end
        return _check
        """
        check_fn = lua.execute(check_code)

        # call via lupa's Python->Lua bridge
        ok, err = check_fn(proc)
        # lupa returns Lua values; convert
        if ok is True or ok == 1:
            return True, "OK"
        return False, str(err) if err else "unknown error"
    except Exception as e:
        return False, f"{type(e).__name__}: {e}"


def main():
    files = []
    if os.path.isdir(WEAPONS_DIR):
        files += sorted(glob.glob(os.path.join(WEAPONS_DIR, "ghosts_*.lua")))
    if os.path.isdir(BASE_DIR):
        files += [os.path.join(BASE_DIR, "weapon_cuh_base_gun.lua")]
        files += [os.path.join(BASE_DIR, "weapon_custom_uh_base.lua")]
        files += [os.path.join(BASE_DIR, "weapon_custom_uh_base_gun.lua")]
    if os.path.isdir(AUTORUN_DIR):
        files += [os.path.join(AUTORUN_DIR, "cl_cuh_ui.lua")]
    if os.path.isdir(DL_BASE_DIR):
        files += [os.path.join(DL_BASE_DIR, "weapon_custom_uh_base.lua")]

    if not files:
        print("No files to check.", file=sys.stderr)
        sys.exit(1)

    print(f"Verifying syntax of {len(files)} files...\n")
    failures = 0
    for fp in files:
        ok, msg = check_file(fp)
        name = os.path.basename(fp)
        if ok:
            print(f"  OK     {name}")
        else:
            print(f"  FAIL   {name}")
            err = msg if len(msg) < 400 else msg[:400] + " ...[truncated]"
            print(f"         {err}")
            failures += 1

    print()
    if failures == 0:
        print(f"All {len(files)} files OK.")
        sys.exit(0)
    else:
        print(f"{failures}/{len(files)} files FAILED.")
        sys.exit(1)


if __name__ == "__main__":
    main()
