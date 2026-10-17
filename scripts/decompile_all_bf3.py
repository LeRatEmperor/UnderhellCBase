#!/usr/bin/env python3
"""decompile_all_bf3.py — Decompile all 32 BF3 weapons from the fresh SWEPs repo."""
import os
import subprocess
import sys
from pathlib import Path

BF3_MODELS = "/home/z/my-project/repos/bf3_sweps_fresh/models/bf3/weapons"
DECOMPILE_DIR = "/home/z/my-project/decompile"
PYTHON = "/home/z/.venv/bin/python3"
ENV = {
    "DOTNET_ROOT": "/home/z/my-project/tools/dotnet",
    "PYTHONNET_RUNTIME": "coreclr",
    "PATH": "/home/z/my-project/tools/dotnet:" + os.environ.get("PATH", ""),
}

# Get list of viewmodel MDLs (not world models - they start with w_)
models_dir = Path(BF3_MODELS)
models = sorted([f.name for f in models_dir.iterdir()
                  if f.suffix == '.mdl' and not f.name.startswith('w_') and not f.name.startswith('c_')])
print(f"Found {len(models)} viewmodel MDLs:")
for m in models:
    print(f"  {m}")
print()

# Clear the decompile folder
print("Clearing decompile folder...")
for item in Path(DECOMPILE_DIR).iterdir():
    if item.is_dir():
        import shutil
        shutil.rmtree(item)
    else:
        item.unlink()
print("Done")
print()

# Decompile each weapon
print(f"Decompiling {len(models)} weapons...")
success = 0
failed = []
for mdl in models:
    weapon = Path(mdl).stem
    mdl_path = os.path.join(BF3_MODELS, mdl)
    print(f"  {weapon}...", end=" ", flush=True)
    try:
        result = subprocess.run(
            [PYTHON, "/home/z/my-project/scripts/test_crowbar_decompile.py", mdl_path, weapon],
            capture_output=True, text=True, timeout=120, env={**os.environ, **ENV}
        )
        if result.returncode == 0:
            print("OK")
            success += 1
        else:
            print(f"FAIL: {result.stderr[:100]}")
            failed.append(weapon)
    except subprocess.TimeoutExpired:
        print("TIMEOUT")
        failed.append(weapon)
    except Exception as e:
        print(f"ERROR: {e}")
        failed.append(weapon)

print()
print("=" * 60)
print(f"SUCCESS: {success}/{len(models)}")
if failed:
    print(f"FAILED: {len(failed)} -> {', '.join(failed)}")
print("=" * 60)
