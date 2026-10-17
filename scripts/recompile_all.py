#!/usr/bin/env python3
"""Recompile all 32 BF3 weapons with studiomdl, with progress reporting.
Note: studiomdl often segfaults at exit (after writing files successfully), so we check for output file existence."""
import os, subprocess, sys, time, shutil
from pathlib import Path

COMPILE_DIR = Path("/home/z/my-project/compile")
STUDIOMDL = "/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl"
LD_LIB_PATH = "/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64"

env = os.environ.copy()
env["LD_LIBRARY_PATH"] = LD_LIB_PATH

weapons = sorted([d.name for d in COMPILE_DIR.iterdir() if d.is_dir() and d.name != "Battlefield3"])
print(f"Found {len(weapons)} weapons to compile")
print("=" * 60)

success = 0
failed = 0
failed_list = []

for i, weapon in enumerate(weapons, 1):
    src_dir = COMPILE_DIR / weapon / "source"
    qc = src_dir / f"{weapon}.qc"
    compiled_dir = COMPILE_DIR / weapon / "compiled"
    expected_mdl = src_dir / "models" / "weapons" / f"c_{weapon}.mdl"
    
    if not qc.exists():
        print(f"[{i:2d}/{len(weapons)}] SKIP {weapon}: no QC")
        continue
    
    print(f"[{i:2d}/{len(weapons)}] Compiling {weapon}...", end=" ", flush=True)
    
    t0 = time.time()
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
        print(f"TIMEOUT (120s)")
        failed += 1
        failed_list.append(weapon)
        continue
    elapsed = time.time() - t0
    
    # Check for actual errors in output AND verify the mdl file was produced
    has_error = "ERROR: Aborted" in output or "ERROR:" in output
    mdl_exists = expected_mdl.exists()
    
    if mdl_exists and not has_error:
        # Copy compiled files
        models_dir = src_dir / "models" / "weapons"
        copied = 0
        if models_dir.exists():
            compiled_dir.mkdir(parents=True, exist_ok=True)
            for f in models_dir.glob(f"c_{weapon}.*"):
                shutil.copy2(f, compiled_dir / f.name)
                copied += 1
        print(f"OK ({elapsed:.1f}s, {copied} files)")
        success += 1
    else:
        errors = [l for l in output.split('\n') if 'ERROR' in l.upper()][:3]
        print(f"FAIL ({elapsed:.1f}s, mdl={'yes' if mdl_exists else 'no'})")
        for e in errors:
            print(f"       {e.strip()}")
        failed += 1
        failed_list.append(weapon)

print()
print("=" * 60)
print(f"SUCCESS: {success}/{len(weapons)}")
print(f"FAILED:  {failed}/{len(weapons)}")
if failed_list:
    print(f"Failed weapons: {', '.join(failed_list)}")
