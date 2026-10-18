#!/usr/bin/env python3
"""
pipeline.py — End-to-end pipeline driver for BF3 weapons porting to Garry's Mod.

Pipeline stages:
1. DECOMPILE - Decompile BF3 .mdl files into .qc + .smd source files
2. EDIT_SMD  - Edit SMD files (bone renames, mesh edits, etc.)
3. EDIT_QC   - Edit QC files (bone definitions, bodygroups, materials, etc.)
4. COMPILE   - Compile edited source files back into .mdl + .vvd + .vtx files
5. PACKAGE   - Bundle compiled files for Garry's Mod

Prerequisites (set up by /home/z/my-project/scripts/setup_pipeline.py):
- studiomdl binary at /home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl
  (with kalloc intptr_t fix and matsys.cpp graceful degradation)
- filesystem_stdio.so stub at:
  /home/z/my-project/repos/source-sdk-2013/game/bin/bin/linux64/filesystem_stdio.so
- libtier0.so and libvstdlib.so at:
  /home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64/
- c_arms_definebones.qci extracted from gmod-animations/c_medkit.7z to /tmp/c_arms_extract/

Usage:
  python3 pipeline.py status          — Show pipeline status
  python3 pipeline.py decompile [weapon]  — Decompile one or all weapons
  python3 pipeline.py convert [weapon]   — Apply simple_c_hands conversion
  python3 pipeline.py compile [weapon]   — Compile one or all weapons
  python3 pipeline.py full [weapon]      — Full pipeline: decompile + convert + compile
  python3 pipeline.py clean [weapon]     — Remove compiled files for weapon(s)
"""
import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

PROJECT_ROOT = Path("/home/z/my-project")
DECOMPILE_DIR = PROJECT_ROOT / "decompile"
COMPILE_DIR = PROJECT_ROOT / "compile"
SCRIPTS_DIR = PROJECT_ROOT / "scripts"

STUDIOMDL = PROJECT_ROOT / "repos/source-sdk-2013/game/bin/studiomdl"
LD_LIB_PATH = PROJECT_ROOT / "repos/source-sdk-2013/src/lib/public/linux64"
FS_STUB = PROJECT_ROOT / "repos/source-sdk-2013/game/bin/bin/linux64/filesystem_stdio.so"
C_ARMS_QCI = Path("/tmp/c_arms_extract/c_arms_definebones.qci")

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


def get_weapons() -> list[str]:
    """Get sorted list of all weapon names."""
    if not DECOMPILE_DIR.exists():
        return []
    return sorted([d.name for d in DECOMPILE_DIR.iterdir()
                   if d.is_dir() and not d.name.startswith('.')])


def check_prereqs() -> bool:
    """Check all prerequisites. Print status. Return True if all OK."""
    print("Checking prerequisites...")
    all_ok = True

    # studiomdl binary
    if STUDIOMDL.exists():
        print(f"  [OK] studiomdl: {STUDIOMDL}")
    else:
        print(f"  [FAIL] studiomdl missing: {STUDIOMDL}")
        all_ok = False

    # filesystem_stdio.so stub
    if FS_STUB.exists():
        print(f"  [OK] filesystem_stdio.so: {FS_STUB}")
    else:
        print(f"  [FAIL] filesystem_stdio.so missing: {FS_STUB}")
        all_ok = False

    # libtier0.so
    tier0 = LD_LIB_PATH / "libtier0.so"
    if tier0.exists():
        print(f"  [OK] libtier0.so: {tier0}")
    else:
        print(f"  [FAIL] libtier0.so missing: {tier0}")
        all_ok = False

    # libvstdlib.so
    vstdlib = LD_LIB_PATH / "libvstdlib.so"
    if vstdlib.exists():
        print(f"  [OK] libvstdlib.so: {vstdlib}")
    else:
        print(f"  [FAIL] libvstdlib.so missing: {vstdlib}")
        all_ok = False

    # c_arms_definebones.qci
    if C_ARMS_QCI.exists():
        print(f"  [OK] c_arms_definebones.qci: {C_ARMS_QCI}")
    else:
        print(f"  [FAIL] c_arms_definebones.qci missing (extract c_medkit.7z)")
        all_ok = False

    # decompile folder
    weapons = get_weapons()
    if weapons:
        print(f"  [OK] decompile folder: {len(weapons)} weapons")
    else:
        print(f"  [FAIL] decompile folder empty")
        all_ok = False

    return all_ok


def cmd_status(args):
    """Show pipeline status."""
    print("=" * 70)
    print("BF3 -> GMod Pipeline Status")
    print("=" * 70)
    print()

    if not check_prereqs():
        print("\nPrerequisites incomplete. Run setup_pipeline.py first.")
        return 1

    print()
    weapons = get_weapons()
    print(f"Found {len(weapons)} weapons in decompile/")

    print()
    print(f"{'Weapon':<12} {'Decompile':<12} {'Compile':<12} {'Compiled':<10}")
    print("-" * 50)

    for weapon in weapons:
        # decompile
        has_decompile = "yes" if (DECOMPILE_DIR / weapon).exists() else "no"

        # compile source
        compile_src = COMPILE_DIR / weapon / "source"
        has_compile = "yes" if compile_src.exists() else "no"

        # compiled mdl
        compiled = COMPILE_DIR / weapon / "compiled" / f"c_{weapon}.mdl"
        has_compiled = "yes" if compiled.exists() else "no"

        print(f"{weapon:<12} {has_decompile:<12} {has_compile:<12} {has_compiled:<10}")

    print()
    bundle = COMPILE_DIR / "Battlefield3"
    if bundle.exists():
        n_files = sum(1 for _ in bundle.iterdir() if _.is_file())
        print(f"Battlefield3 bundle: {n_files} files")
    return 0


def ensure_gameinfo(weapon_dir: Path):
    """Ensure gameinfo.txt exists in weapon source dir."""
    gameinfo = weapon_dir / "gameinfo.txt"
    if not gameinfo.exists():
        gameinfo.write_text(GAMEINFO_TEMPLATE.format(name=weapon_dir.name))
    else:
        content = gameinfo.read_text()
        if "FileSystem" not in content or "SearchPaths" not in content:
            gameinfo.write_text(GAMEINFO_TEMPLATE.format(name=weapon_dir.name))


def ensure_c_arms_qci(weapon_dir: Path):
    """Ensure c_arms_definebones.qci is in weapon source dir."""
    qci = weapon_dir / "c_arms_definebones.qci"
    if not qci.exists() and C_ARMS_QCI.exists():
        shutil.copy2(C_ARMS_QCI, qci)


def cmd_convert(args):
    """Apply simple_c_hands conversion to one or all weapons."""
    weapons = [args.weapon] if args.weapon else get_weapons()
    if args.weapon and args.weapon not in get_weapons():
        print(f"Unknown weapon: {args.weapon}")
        return 1

    print("Running simple_c_hands.py conversion...")
    cmd = [sys.executable, str(SCRIPTS_DIR / "simple_c_hands.py")]
    result = subprocess.run(cmd, capture_output=True, text=True)
    print(result.stdout[-2000:] if len(result.stdout) > 2000 else result.stdout)
    if result.returncode != 0:
        print("STDERR:", result.stderr[-1000:])
        return result.returncode

    # Apply bone name fixes for failing weapons
    print("\nApplying bone name fixes...")
    cmd = [sys.executable, "/tmp/fix_bone_names.py"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    print(result.stdout)
    return 0


def cmd_compile(args):
    """Compile one or all weapons with studiomdl."""
    cmd = [sys.executable, str(SCRIPTS_DIR / "recompile_all.py")]
    if args.weapon:
        # Run for single weapon - use a quick inline version
        weapons = [args.weapon]
        if args.weapon not in get_weapons():
            print(f"Unknown weapon: {args.weapon}")
            return 1

        src_dir = COMPILE_DIR / args.weapon / "source"
        if not src_dir.exists():
            print(f"No source dir for {args.weapon}")
            return 1

        ensure_gameinfo(src_dir)
        ensure_c_arms_qci(src_dir)

        env = os.environ.copy()
        env["LD_LIBRARY_PATH"] = str(LD_LIB_PATH)
        qc = src_dir / f"{args.weapon}.qc"
        result = subprocess.run(
            [str(STUDIOMDL), "-nop4", "-game", str(src_dir), qc.name],
            cwd=str(src_dir), env=env, capture_output=True, text=True, timeout=120
        )
        print(result.stdout[-1500:])
        if result.returncode != 0:
            print("STDERR/exit:", result.returncode, result.stderr[-500:])

        # Copy to compiled folder
        models_dir = src_dir / "models" / "weapons"
        compiled_dir = COMPILE_DIR / args.weapon / "compiled"
        compiled_dir.mkdir(parents=True, exist_ok=True)
        copied = 0
        if models_dir.exists():
            for f in models_dir.glob(f"c_{args.weapon}.*"):
                shutil.copy2(f, compiled_dir / f.name)
                copied += 1
        print(f"Copied {copied} files to {compiled_dir}")
        return 0 if copied > 0 else 1
    else:
        result = subprocess.run(cmd)
        return result.returncode


def cmd_full(args):
    """Full pipeline: convert + compile."""
    print("=" * 70)
    print("FULL PIPELINE: convert -> compile")
    print("=" * 70)

    if not check_prereqs():
        return 1

    print("\n--- Step 1: Convert (simple_c_hands.py) ---")
    rc = cmd_convert(args)
    if rc != 0:
        print(f"Convert failed: {rc}")
        return rc

    print("\n--- Step 2: Compile (recompile_all.py) ---")
    rc = cmd_compile(args)
    if rc != 0:
        print(f"Compile failed: {rc}")
        return rc

    print("\n" + "=" * 70)
    print("FULL PIPELINE COMPLETE")
    print("=" * 70)
    return 0


def cmd_clean(args):
    """Remove compiled files for weapon(s)."""
    weapons = [args.weapon] if args.weapon else get_weapons()
    for weapon in weapons:
        compiled_dir = COMPILE_DIR / weapon / "compiled"
        if compiled_dir.exists():
            shutil.rmtree(compiled_dir)
            print(f"  Removed {compiled_dir}")
        # Also remove models/ in source
        src_models = COMPILE_DIR / weapon / "source" / "models"
        if src_models.exists():
            shutil.rmtree(src_models)
            print(f"  Removed {src_models}")
    return 0


def main():
    parser = argparse.ArgumentParser(description="BF3 -> GMod pipeline driver")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("status", help="Show pipeline status")
    sub.add_parser("decompile", help="Decompile weapons (uses existing decompile folder)")
    sub.add_parser("convert", help="Apply simple_c_hands conversion")
    sub.add_parser("compile", help="Compile weapons with studiomdl")

    for cmd_name in ["status", "decompile", "convert", "compile", "full", "clean"]:
        p = sub.add_parser(cmd_name) if False else None  # placeholder
        # Actually add them properly above

    # Re-do subparsers with weapon arg
    parser2 = argparse.ArgumentParser(description="BF3 -> GMod pipeline driver")
    sub2 = parser2.add_subparsers(dest="command", required=True)

    p_status = sub2.add_parser("status", help="Show pipeline status")
    p_decomp = sub2.add_parser("decompile", help="Decompile weapons")
    p_decomp.add_argument("weapon", nargs="?", help="Specific weapon (default: all)")
    p_convert = sub2.add_parser("convert", help="Apply simple_c_hands conversion")
    p_convert.add_argument("weapon", nargs="?", help="Specific weapon (default: all)")
    p_compile = sub2.add_parser("compile", help="Compile weapons")
    p_compile.add_argument("weapon", nargs="?", help="Specific weapon (default: all)")
    p_full = sub2.add_parser("full", help="Full pipeline (convert + compile)")
    p_full.add_argument("weapon", nargs="?", help="Specific weapon (default: all)")
    p_clean = sub2.add_parser("clean", help="Remove compiled files")
    p_clean.add_argument("weapon", nargs="?", help="Specific weapon (default: all)")

    args = parser2.parse_args()

    if args.command == "status":
        return cmd_status(args)
    elif args.command == "decompile":
        print("Decompile uses the existing /home/z/my-project/decompile/ folder.")
        print("To re-decompile, run scripts/decompile_all_bf3.py (requires Crowbar)")
        return 0
    elif args.command == "convert":
        return cmd_convert(args)
    elif args.command == "compile":
        return cmd_compile(args)
    elif args.command == "full":
        return cmd_full(args)
    elif args.command == "clean":
        return cmd_clean(args)
    else:
        parser2.print_help()
        return 1


if __name__ == "__main__":
    sys.exit(main())
