#!/usr/bin/env python3
"""
Add IronSightsPos_ACOG / IronSightsAng_ACOG to all weapons that have the
4x ACOG attachment but lack the ironsight override data.

Also adds IronSightsPos_Lens / IronSightsAng_Lens for the lens sight.

PATTERN (derived from the 8 sniper weapons that have TFA source data):
  ACOG delta from default IronSightsPos:
    dX ≈ +0.8 (move eye forward — closer to weapon)
    dY ≈ 0    (keep same Y — forward/back varies per weapon)
    dZ ≈ -0.7 (move eye down — ACOG sits lower than ironsights)

  Lens Sight delta from default IronSightsPos:
    The lens sight is a low-mount reflex sight, similar to the ACOG
    but slightly higher. We use a smaller downward offset.
    dX ≈ +0.5, dY ≈ 0, dZ ≈ -0.4

These are APPROXIMATE defaults. The 8 sniper weapons have exact TFA
source data and are NOT touched. Only weapons WITHOUT the data get
the computed default.
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Delta constants (computed from average of 8 sniper weapons)
ACOG_DX = 0.8
ACOG_DY = 0.0
ACOG_DZ = -0.7

LENS_DX = 0.5
LENS_DY = 0.0
LENS_DZ = -0.4


def parse_vector(s):
    """Parse 'Vector(-3.5, -4.5, 1.15)' -> (-3.5, -4.5, 1.15)"""
    m = re.match(r'\s*Vector\s*\(\s*(-?[\d.]+)\s*,\s*(-?[\d.]+)\s*,\s*(-?[\d.]+)\s*\)', s)
    if m:
        return (float(m.group(1)), float(m.group(2)), float(m.group(3)))
    return None


def format_vector(x, y, z):
    """Format vector with proper precision"""
    def fmt(v):
        # Round to 3 decimal places, strip trailing zeros
        s = f"{v:.3f}"
        if '.' in s:
            s = s.rstrip('0').rstrip('.')
        return s
    return f"Vector({fmt(x)}, {fmt(y)}, {fmt(z)})"


def process_weapon(filepath):
    """Add ACOG and Lens ironsight data to a weapon file if missing."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = os.path.basename(filepath)
    changed = False

    # Check if this weapon supports 4x ACOG
    has_4x = 'tfa_codww2_4x' in src
    # Check if this weapon supports lens_sight
    has_lens = 'tfa_codww2_lens_sight' in src

    if not has_4x and not has_lens:
        return False

    # Find the default IronSightsPos
    m = re.search(r'^(SWEP\.IronSightsPos\s*=\s*)(Vector\s*\([^)]+\))', src, re.MULTILINE)
    if not m:
        return False

    default_pos = parse_vector(m.group(2))
    if not default_pos:
        return False

    # Find where to insert (after IronSightsAng line, or after IronSightsPos)
    ang_match = re.search(r'^(SWEP\.IronSightsAng\s*=\s*Vector\s*\([^)]+\))', src, re.MULTILINE)
    if ang_match:
        insert_after = ang_match
        insert_pos = ang_match.end()
    else:
        insert_after = m
        insert_pos = m.end()

    # Check if ACOG data already exists
    has_acog_data = 'IronSightsPos_ACOG' in src
    has_lens_data = 'IronSightsPos_Lens' in src

    insertions = []

    if has_4x and not has_acog_data:
        # Compute ACOG position
        acog_pos = (
            default_pos[0] + ACOG_DX,
            default_pos[1] + ACOG_DY,
            default_pos[2] + ACOG_DZ,
        )
        insertions.append(
            f"\n-- 4x ACOG ironsight position (computed default: IronSightsPos + delta)\n"
            f"SWEP.IronSightsPos_ACOG = {format_vector(*acog_pos)}\n"
            f"SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)"
        )
        changed = True

    if has_lens and not has_lens_data:
        # Compute Lens position
        lens_pos = (
            default_pos[0] + LENS_DX,
            default_pos[1] + LENS_DY,
            default_pos[2] + LENS_DZ,
        )
        insertions.append(
            f"\n-- Lens sight ironsight position (computed default: IronSightsPos + delta)\n"
            f"SWEP.IronSightsPos_Lens = {format_vector(*lens_pos)}\n"
            f"SWEP.IronSightsAng_Lens = Vector(0, 0, 0)"
        )
        changed = True

    if not changed:
        return False

    # Insert after the IronSightsAng line
    insertion_text = "".join(insertions)
    new_src = src[:insert_pos] + insertion_text + src[insert_pos:]

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_src)

    return True


def main():
    weapons = glob.glob(os.path.join(WEAPONS_DIR, "kate_*.lua"))
    print(f"Processing {len(weapons)} weapon files...")

    acog_added = 0
    lens_added = 0

    for wpn in sorted(weapons):
        fname = os.path.basename(wpn)
        with open(wpn, 'r', encoding='utf-8') as f:
            src = f.read()

        had_acog = 'IronSightsPos_ACOG' in src
        had_lens = 'IronSightsPos_Lens' in src

        if process_weapon(wpn):
            with open(wpn, 'r', encoding='utf-8') as f:
                new_src = f.read()
            now_acog = 'IronSightsPos_ACOG' in new_src
            now_lens = 'IronSightsPos_Lens' in new_src

            parts = []
            if now_acog and not had_acog:
                acog_added += 1
                parts.append("ACOG")
            if now_lens and not had_lens:
                lens_added += 1
                parts.append("Lens")

            if parts:
                print(f"  {fname}: added {' + '.join(parts)}")

    print(f"\nDone. Added ACOG data to {acog_added} weapons, Lens data to {lens_added} weapons.")


if __name__ == "__main__":
    main()
