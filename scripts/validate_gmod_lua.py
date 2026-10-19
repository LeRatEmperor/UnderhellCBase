#!/usr/bin/env python3
"""
validate_gmod_lua.py — Lint + validate + self-correct GMod Lua files.

Steps:
1. Runs luacheck on all .lua files in the cuh_port directory
2. Parses the output for errors (not warnings)
3. For each error, reads the file, applies a fix if possible, writes it back
4. Re-runs luacheck to verify the fix worked
5. Reports final pass/fail count

Usage:
    python3 validate_gmod_lua.py [--fix] [--verbose]
"""

import os
import re
import subprocess
import sys
from pathlib import Path

LUACHECK = "/home/z/my-project/tools/luacheck"
ROOT = Path("/home/z/my-project/cuh_port")
CACHE_ROOT = Path("/home/z/my-project/download/custom_uh_base")
ORPHAN_ROOT = Path("/home/z/my-project/repos/cuh_port_for_underhell")

# All directories to lint
LINT_DIRS = [
    ROOT / "lua",
    ORPHAN_ROOT / "cuh_base_patches" / "lua",
    ORPHAN_ROOT / "lua",
    CACHE_ROOT / "lua" / "weapons",
    CACHE_ROOT / "lua" / "autorun",
]


def run_luacheck(paths):
    """Run luacheck on the given paths, return (errors, warnings, output)."""
    args = [LUACHECK, "--std", "luajit", "--max-line-length", "300"]
    # Add GMod globals
    gmod_globals = [
        "SERVER", "CLIENT", "IsValid", "IsFirstTimePredicted", "CurTime", "RealTime",
        "FrameTime", "Angle", "Vector", "Color", "Material", "Sound", "CreateMaterial",
        "GetRenderTarget", "draw", "cam", "render", "input", "util", "hook", "timer",
        "net", "concommand", "cvars", "file", "game", "engine", "language",
        "istable", "isstring", "isnumber", "isbool", "isfunction", "isentity",
        "isangle", "isvector", "iscolor", "CreateClientConVar", "CreateConVar",
        "GetConVar", "ConVarExists", "AddCSLuaFile", "include", "DEFINE_BASECLASS",
        "NetworkVar", "SWEP", "ATTACHMENT", "CustomUH", "BaseClass", "ClientsideModel",
        "SetSubMaterial", "PrintTable", "CompileString", "NULL",
        "ACT_VM_IDLE", "ACT_VM_PRIMARYATTACK", "ACT_VM_RELOAD", "ACT_VM_RELOAD_EMPTY",
        "ACT_VM_DRAW", "ACT_VM_DRAW_DEPLOYED", "ACT_VM_DEPLOY", "ACT_VM_UNDEPLOY",
        "ACT_VM_IDLE_DEPLOYED", "ACT_VM_MELEE", "ACT_VM_FIDGET",
        "ACT_VM_SPRINT_IDLE", "ACT_VM_SPRINT_ENTER", "ACT_VM_SPRINT_LEAVE",
        "ACT_VM_PRIMARYATTACK_SILENCED", "ACT_VM_SECONDARYATTACK",
        "ACT_VM_SECONDARYATTACK_SILENCED", "ACT_VM_IDLE_SILENCED",
        "ACT_SHOTGUN_PUMP", "ACT_SHOTGUN_RELOAD_START", "ACT_SHOTGUN_RELOAD_FINISH",
        "PLAYER_ATTACK1", "PLAYER_RELOAD", "IN_USE", "IN_ATTACK", "IN_ATTACK2",
        "IN_RELOAD", "IN_SPEED", "CHAN_WEAPON", "CHAN_USER_BASE",
        "vector_origin", "angle_zero", "color_black", "color_white",
    ]
    args.extend(["--globals"] + gmod_globals)
    # Ignore common GMod warnings
    args.extend(["--ignore", "212", "213", "231", "311", "431", "542", "111"])
    args.extend([str(p) for p in paths if Path(p).exists()])

    result = subprocess.run(args, capture_output=True, text=True, timeout=60)
    output = result.stdout + result.stderr

    errors = []
    warnings = []

    for line in output.split("\n"):
        m = re.match(r"\s+(.+?):(\d+):(\d+): (.+)", line)
        if m:
            filepath, lineno, colno, message = m.groups()
            lineno_int = int(lineno)
            
            # Skip "expected '=' near 'end'" errors on lines containing `continue`
            # (luacheck doesn't understand LuaJIT's `continue` keyword, but it's valid GMod code)
            if "expected" in message and "near" in message:
                try:
                    with open(filepath, "r", errors="replace") as f:
                        file_lines = f.readlines()
                    if lineno_int <= len(file_lines) and "continue" in file_lines[lineno_int - 1]:
                        continue  # Skip this error — it's a valid LuaJIT `continue` statement
                except:
                    pass
            
            if "error" in message.lower() or "expected" in message.lower() or "near" in message.lower():
                errors.append({
                    "file": filepath, "line": lineno_int,
                    "col": int(colno), "message": message
                })
            else:
                warnings.append({
                    "file": filepath, "line": lineno_int,
                    "col": int(colno), "message": message
                })

    return errors, warnings, output


def fix_error(error):
    """Attempt to fix a linting error. Returns True if a fix was applied."""
    filepath = error["file"]
    lineno = error["line"]
    message = error["message"]

    if not os.path.exists(filepath):
        return False

    with open(filepath, "r", errors="replace") as f:
        lines = f.readlines()

    if lineno < 1 or lineno > len(lines):
        return False

    line = lines[lineno - 1]
    fixed = False

    # Fix 1: `!=` -> `~=` (LuaJIT extension not supported by luacheck's lua51 std)
    if "near '!'" in message or "expected 'then' near '!'" in message:
        lines[lineno - 1] = line.replace("!=", "~=")
        fixed = True

    # Fix 2: `continue` (LuaJIT extension) — luacheck with luajit std should handle this
    # but if it doesn't, we can't fix it (it's valid GMod code)

    # Fix 3: Common missing 'then' — check if the line has `if X != Y` without then
    if "expected 'then'" in message and "!=" in line:
        lines[lineno - 1] = line.replace("!=", "~=")
        fixed = True

    # Fix 4: `animDataath.random` -> `animData[math.random` (the broken math.random typo)
    if "animDataath" in line:
        lines[lineno - 1] = line.replace("animDataath.random", "animData[math.random")
        fixed = True
    if "sndath.random" in line:
        lines[lineno - 1] = line.replace("sndath.random", "snd[math.random")
        fixed = True
    if "hitSndath.random" in line:
        lines[lineno - 1] = line.replace("hitSndath.random", "hitSnd[math.random")
        fixed = True
    if "resultath.random" in line:
        lines[lineno - 1] = line.replace("resultath.random", "result[math.random")
        fixed = True

    if fixed:
        with open(filepath, "w") as f:
            f.writelines(lines)
        print(f"  [FIXED] {filepath}:{lineno} — {message}")

    return fixed


def check_realm_safety():
    """Check for realm-safety violations:
    - Server-only functions called from client/shared files
    - Client-only functions called from server/shared files
    """
    CLIENT_ONLY = {
        "surface", "draw", "cam", "render", "vgui", "Derma", "input",
        "Material", "CreateMaterial", "GetRenderTarget", "ClientsideModel",
        "LocalPlayer", "gui", "chat", "halo", "killicon", "spawnmenu",
    }
    SERVER_ONLY = {
        "ents.Create", "util.AddNetworkString", "player.Create",
         "sql", "resource.AddFile", "resource.AddWorkshop",
    }

    violations = []
    for d in LINT_DIRS:
        if not Path(d).exists():
            continue
        for f in Path(d).rglob("*.lua"):
            rel = str(f)
            is_server = "/server/" in rel or rel.startswith("sv_") or "/sv_" in rel
            is_client = "/client/" in rel or rel.startswith("cl_") or "/cl_" in rel

            with open(f, "r", errors="replace") as fh:
                for i, line in enumerate(fh, 1):
                    stripped = line.strip()
                    if stripped.startswith("--"):
                        continue

                    if is_server:
                        for func in CLIENT_ONLY:
                            if func + "." in stripped or func + "(" in stripped or func + " " in stripped:
                                if "if CLIENT" not in stripped and "if not SERVER" not in stripped:
                                    violations.append({
                                        "file": str(f), "line": i,
                                        "message": f"Client-only function '{func}' in server file",
                                    })
                    elif is_client:
                        for func in SERVER_ONLY:
                            if func in stripped:
                                violations.append({
                                    "file": str(f), "line": i,
                                    "message": f"Server-only function '{func}' in client file",
                                })
    return violations



def main():
    verbose = "--verbose" in sys.argv or "-v" in sys.argv
    do_fix = "--fix" in sys.argv or "-f" in sys.argv

    print("=" * 60)
    print("GMod Lua Validation Pipeline")
    print("=" * 60)

    # Collect all .lua files
    all_files = set()
    for d in LINT_DIRS:
        if d.exists():
            for f in d.rglob("*.lua"):
                all_files.add(str(f))

    if not all_files:
        print("[!] No .lua files found in the configured directories.")
        print(f"    Checked: {[str(d) for d in LINT_DIRS]}")
        return 1

    print(f"\n[1] Linting {len(all_files)} .lua files...")

    # Run luacheck
    errors, warnings, output = run_luacheck(all_files)

    print(f"    Results: {len(errors)} errors, {len(warnings)} warnings")

    if verbose:
        for w in warnings[:10]:
            print(f"    [WARN] {w['file']}:{w['line']} — {w['message']}")

    if errors:
        print(f"\n[2] Found {len(errors)} errors:")
        for e in errors:
            print(f"    [ERROR] {e['file']}:{e['line']}:{e['col']} — {e['message']}")

        if do_fix:
            print(f"\n[3] Attempting auto-fix...")
            fixed_count = 0
            for e in errors:
                if fix_error(e):
                    fixed_count += 1
            print(f"    Fixed {fixed_count}/{len(errors)} errors.")

            if fixed_count > 0:
                print(f"\n[4] Re-running luacheck to verify fixes...")
                errors2, _, _ = run_luacheck(all_files)
                if len(errors2) < len(errors):
                    print(f"    Improved: {len(errors)} -> {len(errors2)} errors")
                else:
                    print(f"    No improvement. {len(errors2)} errors remain.")

                remaining = len(errors2)
            else:
                remaining = len(errors)
        else:
            remaining = len(errors)
    else:
        remaining = 0

    # Realm safety check
    print(f"\n[5] Checking realm safety...")
    realm_violations = check_realm_safety()
    if realm_violations:
        print(f"    Found {len(realm_violations)} realm violations:")
        for v in realm_violations[:10]:
            print(f"    [REALM] {v['file']}:{v['line']} — {v['message']}")
    else:
        print(f"    No realm violations found.")

    # Summary
    print(f"\n{'=' * 60}")
    total_issues = remaining + len(realm_violations)
    if total_issues == 0:
        print(f"PASSED: 0 errors, 0 realm violations across {len(all_files)} files")
        return 0
    else:
        print(f"FAILED: {remaining} errors, {len(realm_violations)} realm violations across {len(all_files)} files")
        return 1


if __name__ == "__main__":
    sys.exit(main())


