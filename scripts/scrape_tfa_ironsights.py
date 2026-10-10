#!/usr/bin/env python3
"""
Scrape IronSightsPos_ACOG, IronSightsPos_LENS, IronSightsPos_NYDAR (and Ang)
from the TFA source files and apply them to the Kate weapon files.

Source: /home/z/my-project/source_repos/tfa_codww2_source/lua/weapons/nz_kate_codww2_*.lua
Target: /home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_*.lua

Mapping: nz_kate_codww2_<name>.lua  ->  kate_<name>.lua

This script:
1. For each TFA source weapon, extracts all IronSightsPos_* and IronSightsAng_* lines
2. Finds the matching Kate weapon file
3. Removes any existing computed IronSightsPos_* lines (from previous bad script)
4. Inserts the TFA source data right after the SWEP.IronSightsAng line
"""

import os
import re
import glob

SOURCE_DIR = "/home/z/my-project/source_repos/tfa_codww2_source/lua/weapons"
TARGET_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Suffixes to scrape
SUFFIXES = ["ACOG", "LENS", "NYDAR", "GL"]


def extract_ironsight_data(source_path):
    """Extract all IronSightsPos_* and IronSightsAng_* lines from a TFA source file."""
    with open(source_path, 'r', encoding='utf-8') as f:
        src = f.read()

    data = {}
    for suffix in SUFFIXES:
        pos_match = re.search(
            r'^(SWEP\.IronSightsPos_' + suffix + r'\s*=\s*Vector\([^)]+\))',
            src, re.MULTILINE
        )
        ang_match = re.search(
            r'^(SWEP\.IronSightsAng_' + suffix + r'\s*=\s*Vector\([^)]+\))',
            src, re.MULTILINE
        )
        if pos_match:
            data['IronSightsPos_' + suffix] = pos_match.group(1)
        if ang_match:
            data['IronSightsAng_' + suffix] = ang_match.group(1)

    return data


def apply_ironsight_data(target_path, data):
    """Insert TFA source ironsight data into a Kate weapon file."""
    with open(target_path, 'r', encoding='utf-8') as f:
        src = f.read()

    # First, remove any existing computed IronSightsPos_* lines
    # (from the previous add_ironsight_overrides.py script)
    for suffix in SUFFIXES:
        # Remove computed blocks (with the "computed default" comment)
        pattern = r'\n-- [^\n]*ironsight position \(computed default[^\n]*\)\nSWEP\.IronSightsPos_' + suffix + r'\s*=\s*Vector\([^)]+\)\nSWEP\.IronSightsAng_' + suffix + r'\s*=\s*Vector\([^)]+\)'
        src = re.sub(pattern, '', src)
        # Also remove any existing TFA source blocks (to avoid duplicates)
        pattern2 = r'\n-- [^\n]*ironsight position \(from TFA source[^\n]*\)\nSWEP\.IronSightsPos_' + suffix + r'\s*=\s*Vector\([^)]+\)\nSWEP\.IronSightsAng_' + suffix + r'\s*=\s*Vector\([^)]+\)'
        src = re.sub(pattern2, '', src)
        # Remove bare lines (no comment)
        pattern3 = r'\nSWEP\.IronSightsPos_' + suffix + r'\s*=\s*Vector\([^)]+\)\nSWEP\.IronSightsAng_' + suffix + r'\s*=\s*Vector\([^)]+\)'
        src = re.sub(pattern3, '', src)

    # Find the insertion point: after the SWEP.IronSightsAng line
    # (not IronSightsAng_*, just the base IronSightsAng)
    insert_match = re.search(
        r'^(SWEP\.IronSightsAng\s*=\s*Vector\([^)]+\))',
        src, re.MULTILINE
    )
    if not insert_match:
        return False, "IronSightsAng not found"

    insert_pos = insert_match.end()

    # Build the insertion text
    lines = []
    for suffix in SUFFIXES:
        pos_key = 'IronSightsPos_' + suffix
        ang_key = 'IronSightsAng_' + suffix
        if pos_key in data and ang_key in data:
            lines.append(f"\n-- {suffix} ironsight position (from TFA source)")
            lines.append(data[pos_key])
            lines.append(data[ang_key])

    if not lines:
        return False, "no data to insert"

    insertion_text = "\n".join(lines)
    new_src = src[:insert_pos] + insertion_text + src[insert_pos:]

    with open(target_path, 'w', encoding='utf-8') as f:
        f.write(new_src)

    return True, ", ".join([s for s in SUFFIXES if 'IronSightsPos_' + s in data])


def main():
    # Build source -> target mapping
    source_files = glob.glob(os.path.join(SOURCE_DIR, "nz_kate_codww2_*.lua"))

    print(f"Found {len(source_files)} TFA source weapon files")
    print(f"Scraping IronSightsPos data and applying to Kate weapons...\n")

    stats = {"applied": 0, "no_target": 0, "no_data": 0, "no_ang": 0}

    for source_path in sorted(source_files):
        source_fname = os.path.basename(source_path)
        # nz_kate_codww2_<name>.lua -> kate_<name>.lua
        name = source_fname.replace("nz_kate_codww2_", "").replace(".lua", "")
        target_fname = f"kate_{name}.lua"
        target_path = os.path.join(TARGET_DIR, target_fname)

        if not os.path.exists(target_path):
            # Try without _upgraded suffix
            if name.endswith("_upgraded"):
                target_path = os.path.join(TARGET_DIR, f"kate_{name.replace('_upgraded', '')}.lua")
                if not os.path.exists(target_path):
                    stats["no_target"] += 1
                    continue
            else:
                stats["no_target"] += 1
                continue

        # Extract data from source
        data = extract_ironsight_data(source_path)
        if not data:
            stats["no_data"] += 1
            continue

        # Apply to target
        success, msg = apply_ironsight_data(target_path, data)
        if success:
            stats["applied"] += 1
            print(f"  {target_fname}: added {msg}")
        else:
            if "not found" in msg:
                stats["no_ang"] += 1
            else:
                stats["no_data"] += 1

    print(f"\n=== Summary ===")
    print(f"  Applied:    {stats['applied']}")
    print(f"  No target:  {stats['no_target']}")
    print(f"  No data:    {stats['no_data']}")
    print(f"  No IronSightsAng: {stats['no_ang']}")


if __name__ == "__main__":
    main()
