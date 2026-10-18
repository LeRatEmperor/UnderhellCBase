#!/usr/bin/env python3
"""Fix bone name mismatches in failing weapon compilations.

Issues fixed:
1. "(null)" root bone name (in m9, g18, m1911, m93r, mp443) - rename to "ValveBiped.Bip01_Root"
2. "b_root" bone name (in g3a3) - rename to "ValveBiped.Bip01"
3. Outdated "L Clavicle" etc. in QC files (in famas) - re-apply BONE_MAP
"""
import os
import re
import sys
from pathlib import Path

sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map, BONE_MAP

COMPILE_DIR = Path("/home/z/my-project/compile")

# Weapons that need fixing
FAILING_WEAPONS = ["famas", "g18", "g3a3", "m1911", "m9", "m93r", "mp443"]


def fix_null_bones(content: str) -> str:
    """Rename '(null)' bone name to 'ValveBiped.Bip01_Root'."""
    return content.replace('"(null)"', '"ValveBiped.Bip01_Root"')


def fix_b_root_bones(content: str) -> str:
    """Rename 'b_root' to 'ValveBiped.Bip01' (g3a3-specific)."""
    return content.replace('"b_root"', '"ValveBiped.Bip01"')


def reapply_bone_map(content: str) -> str:
    """Re-apply the BONE_MAP rename to content (for famas where QC wasn't renamed)."""
    for old, new in sorted(BONE_MAP.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content


def fix_weapon(weapon: str) -> bool:
    """Fix bone name issues for a single weapon. Returns True if changes were made."""
    src_dir = COMPILE_DIR / weapon / "source"
    if not src_dir.exists():
        return False

    changed = False
    for root, dirs, files in os.walk(src_dir):
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

            # Always re-apply BONE_MAP (handles famas case where QC wasn't renamed)
            content = reapply_bone_map(content)

            # Fix "(null)" bone name (g18, m1911, m9, m93r, mp443)
            if '"(null)"' in content:
                content = fix_null_bones(content)

            # Fix "b_root" bone name (g3a3)
            if '"b_root"' in content:
                content = fix_b_root_bones(content)

            if content != original:
                with open(path, 'w') as fh:
                    fh.write(content)
                changed = True

    return changed


def main():
    print("Fixing bone name issues in failing weapons...")
    for weapon in FAILING_WEAPONS:
        changed = fix_weapon(weapon)
        if changed:
            print(f"  FIXED {weapon}")
        else:
            print(f"  (no changes) {weapon}")


if __name__ == "__main__":
    main()
