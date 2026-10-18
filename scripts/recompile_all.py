#!/usr/bin/env python3
"""
recompile_all.py — Compile all 32 BF3 weapons using the now-fixed studiomdl.

Prerequisites (must be done before running this):
1. studiomdl rebuilt with kalloc intptr_t fix (in source-sdk-2013/src/utils/studiomdl/studiomdl.cpp)
2. studiomdl rebuilt with matsys.cpp graceful-degradation fix (no MdlError on missing materialsystem.so)
3. filesystem_stdio.so stub compiled and placed at:
   - /home/z/my-project/repos/source-sdk-2013/game/bin/bin/linux64/filesystem_stdio.so
   - /home/z/my-project/repos/source-sdk-2013/game/bin/filesystem_stdio.so
4. c_arms_definebones.qci copied to each compile/<weapon>/source/ folder
5. gameinfo.txt in each compile/<weapon>/source/ folder with FileSystem/SearchPaths sections
"""
import os
import subprocess
import sys
import time
import shutil
from pathlib import Path

COMPILE_DIR = Path("/home/z/my-project/compile")
STUDIOMDL = "/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl"
LD_LIB_PATH = "/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64"

# Path to the canonical c_arms_definebones.qci (extracted from gmod-animations/c_medkit.7z)
C_ARMS_QCI = Path("/tmp/c_arms_extract/c_arms_definebones.qci")

# Proper gameinfo.txt that satisfies studiomdl's parser
GAMEINFO_TEMPLATE = '''"GameInfo"
{{
\tgame "{name}"
\tFileSystem
\t{{
\t\tSearchPaths
\t\t{{
\t\t\tGame\t\t.
\t\t}}
\t}}
}}
'''


def ensure_prerequisites(weapon_dir: Path):
    """Ensure c_arms_definebones.qci and gameinfo.txt are in the source dir, and bone names are fixed."""
    src_dir = weapon_dir / "source"
    if not src_dir.exists():
        return False, "no source dir"

    qci = src_dir / "c_arms_definebones.qci"
    if not qci.exists():
        if C_ARMS_QCI.exists():
            shutil.copy2(C_ARMS_QCI, qci)
        else:
            return False, "no c_arms_definebones.qci source"

    gameinfo = src_dir / "gameinfo.txt"
    if not gameinfo.exists():
        gameinfo.write_text(GAMEINFO_TEMPLATE.format(name=weapon_dir.name))
    else:
        content = gameinfo.read_text()
        if "FileSystem" not in content or "SearchPaths" not in content:
            gameinfo.write_text(GAMEINFO_TEMPLATE.format(name=weapon_dir.name))

    # Apply bone name fixes (idempotent)
    apply_bone_name_fixes(src_dir)

    return True, ""


def apply_bone_name_fixes(src_dir: Path):
    """Fix bone name issues in SMD/QC files (idempotent)."""
    sys.path.insert(0, '/home/z/my-project/scripts')
    try:
        from full_pipeline import build_bone_map, BONE_MAP
    except ImportError:
        return

    for root, _, files in os.walk(src_dir):
        for f in files:
            if not f.endswith((".smd", ".qc", ".qci")):
                continue
            path = os.path.join(root, f)
            try:
                with open(path, 'r', errors='ignore') as fh:
                    original = fh.read()
            except Exception:
                continue

            content = original

            # Re-apply BONE_MAP (handles QC files where bones weren't renamed)
            for old, new in sorted(BONE_MAP.items(), key=lambda x: len(x[0]), reverse=True):
                if not old or old == "(null)":
                    continue
                content = content.replace(f'"{old}"', f'"{new}"')

            # Fix "(null)" bone name (m9-style: g18, m1911, m9, m93r, mp443)
            if '"(null)"' in content:
                content = content.replace('"(null)"', '"ValveBiped.Bip01_Root"')

            # Fix "b_root" bone name (g3a3)
            if '"b_root"' in content:
                content = content.replace('"b_root"', '"ValveBiped.Bip01"')

            if content != original:
                with open(path, 'w') as fh:
                    fh.write(content)


def compile_weapon(weapon: str) -> tuple[bool, str]:
    """Compile a single weapon. Returns (success, message)."""
    src_dir = COMPILE_DIR / weapon / "source"
    qc = src_dir / f"{weapon}.qc"
    expected_mdl = src_dir / "models" / "weapons" / f"c_{weapon}.mdl"

    if not qc.exists():
        return False, "no QC file"

    ok, msg = ensure_prerequisites(COMPILE_DIR / weapon)
    if not ok:
        return False, msg

    env = os.environ.copy()
    env["LD_LIBRARY_PATH"] = LD_LIB_PATH

    try:
        result = subprocess.run(
            [STUDIOMDL, "-nop4", "-game", str(src_dir), qc.name],
            cwd=str(src_dir),
            env=env,
            capture_output=True,
            text=True,
            timeout=120,
        )
        output = result.stdout + result.stderr
    except subprocess.TimeoutExpired:
        return False, "TIMEOUT (120s)"
    except Exception as e:
        return False, f"exception: {e}"

    # studiomdl often segfaults at exit (after writing files successfully), so we check for output file existence
    has_error = "ERROR: Aborted" in output or "ERROR:" in output
    mdl_exists = expected_mdl.exists()

    if mdl_exists and not has_error:
        # Copy compiled files to the weapon's compiled/ folder
        models_dir = src_dir / "models" / "weapons"
        compiled_dir = COMPILE_DIR / weapon / "compiled"
        compiled_dir.mkdir(parents=True, exist_ok=True)
        copied = 0
        if models_dir.exists():
            for f in models_dir.glob(f"c_{weapon}.*"):
                shutil.copy2(f, compiled_dir / f.name)
                copied += 1
        return True, f"OK ({copied} files)"

    # Extract first error
    errors = [l for l in output.split('\n') if 'ERROR' in l.upper()][:3]
    err_msg = "; ".join(e.strip() for e in errors) if errors else f"no mdl produced (exit={result.returncode})"
    return False, err_msg


def main():
    print("=" * 70)
    print("recompile_all.py — Compile all 32 BF3 weapons with studiomdl")
    print("=" * 70)

    weapons = sorted([d.name for d in COMPILE_DIR.iterdir()
                      if d.is_dir() and d.name != "Battlefield3"])
    print(f"Found {len(weapons)} weapons to compile")
    print()

    success = 0
    failed = 0
    failed_list = []
    t_start = time.time()

    for i, weapon in enumerate(weapons, 1):
        t0 = time.time()
        ok, msg = compile_weapon(weapon)
        elapsed = time.time() - t0
        status = "OK  " if ok else "FAIL"
        print(f"[{i:2d}/{len(weapons)}] {status} {weapon:10s} ({elapsed:5.1f}s) — {msg}")
        if ok:
            success += 1
        else:
            failed += 1
            failed_list.append(weapon)

    total_time = time.time() - t_start
    print()
    print("=" * 70)
    print(f"SUCCESS: {success}/{len(weapons)}    FAILED: {failed}/{len(weapons)}    TIME: {total_time:.1f}s")
    if failed_list:
        print(f"Failed weapons: {', '.join(failed_list)}")
    print("=" * 70)

    # Refresh the Battlefield3 bundle
    bundle_dir = COMPILE_DIR / "Battlefield3"
    bundle_dir.mkdir(parents=True, exist_ok=True)
    bundled = 0
    for weapon in weapons:
        compiled_dir = COMPILE_DIR / weapon / "compiled"
        if compiled_dir.exists():
            for f in compiled_dir.glob(f"c_{weapon}.*"):
                shutil.copy2(f, bundle_dir / f.name)
                bundled += 1
    print(f"Refreshed compile/Battlefield3/ bundle with {bundled} files")

    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
