#!/usr/bin/env python3
"""
Remove the computed IronSightsPos_ACOG and IronSightsPos_Lens values from
weapons that received them via add_ironsight_overrides.py.

REASON:
  The computed deltas (dX=+0.8, dZ=-0.7) were based on the average of
  8 SNIPER weapons where the scope sits LOW (close to the barrel).
  For non-sniper weapons (rifles, LMGs, SMGs), the ACOG sits HIGH
  (above the barrel), so the eye needs to move in the OPPOSITE direction.
  The computed values are therefore WRONG for most weapons.

  The TFA source for non-sniper weapons does NOT define IronSightsPos_ACOG.
  TFA's attachment system falls back to the default IronSightsPos when
  no override exists. This is closer to correct than our computed values.

  The 8 sniper weapons with real TFA source data are NOT touched
  (they have a comment "from TFA source" instead of "computed default").

FIX:
  - Remove all "computed default" IronSightsPos_ACOG / IronSightsAng_ACOG
  - Remove all "computed default" IronSightsPos_Lens / IronSightsAng_Lens
  - The ACOG and Lens attachments will fall back to val (the default
    IronSightsPos), which is closer to correct
  - The user can manually add IronSightsPos_ACOG to specific weapons
    that need adjustment, or use the cuh_adjust_acog console command
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"


def remove_computed_ironsights(filepath):
    """Remove computed IronSightsPos_ACOG/Lens blocks (keep TFA source ones)."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = os.path.basename(filepath)
    changed = False

    # Remove ACOG computed block:
    # -- 4x ACOG ironsight position (computed default: IronSightsPos + delta)
    # SWEP.IronSightsPos_ACOG = Vector(...)
    # SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)
    acog_pattern = r'\n-- 4x ACOG ironsight position \(computed default: IronSightsPos \+ delta\)\nSWEP\.IronSightsPos_ACOG = Vector\([^)]+\)\nSWEP\.IronSightsAng_ACOG = Vector\([^)]+\)'
    if re.search(acog_pattern, src):
        src = re.sub(acog_pattern, '', src)
        changed = True

    # Remove Lens computed block:
    # -- Lens sight ironsight position (computed default: IronSightsPos + delta)
    # SWEP.IronSightsPos_Lens = Vector(...)
    # SWEP.IronSightsAng_Lens = Vector(0, 0, 0)
    lens_pattern = r'\n-- Lens sight ironsight position \(computed default: IronSightsPos \+ delta\)\nSWEP\.IronSightsPos_Lens = Vector\([^)]+\)\nSWEP\.IronSightsAng_Lens = Vector\([^)]+\)'
    if re.search(lens_pattern, src):
        src = re.sub(lens_pattern, '', src)
        changed = True

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(src)

    return changed


def main():
    weapons = glob.glob(os.path.join(WEAPONS_DIR, "kate_*.lua"))
    print(f"Processing {len(weapons)} weapon files...")

    acog_removed = 0
    lens_removed = 0

    for wpn in sorted(weapons):
        fname = os.path.basename(wpn)
        with open(wpn, 'r', encoding='utf-8') as f:
            src_before = f.read()

        had_acog_computed = "computed default: IronSightsPos + delta" in src_before and "IronSightsPos_ACOG" in src_before
        had_lens_computed = "computed default: IronSightsPos + delta" in src_before and "IronSightsPos_Lens" in src_before

        if remove_computed_ironsights(wpn):
            with open(wpn, 'r', encoding='utf-8') as f:
                src_after = f.read()

            parts = []
            if had_acog_computed and "IronSightsPos_ACOG" not in src_after:
                acog_removed += 1
                parts.append("ACOG")
            if had_lens_computed and "IronSightsPos_Lens" not in src_after:
                lens_removed += 1
                parts.append("Lens")

            if parts:
                print(f"  {fname}: removed computed {' + '.join(parts)}")

    print(f"\nDone. Removed computed ACOG from {acog_removed} weapons, Lens from {lens_removed} weapons.")
    print("The 8 sniper weapons with TFA source data are NOT touched.")


if __name__ == "__main__":
    main()
