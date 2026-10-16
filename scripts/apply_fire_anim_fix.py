#!/usr/bin/env python3
"""
apply_fire_anim_fix.py

Applies the following changes to all 25 ghost weapon files:

1. In SWEP.Animations table, REMOVE the entries:
     ["shoot"]        = "fire",
     ["iron_fire"]    = "fire_ads",
   (these prevent the base-class fallback ACT from being used)

2. Replace the ShootAnimation() override so it returns:
     - ACT_VM_PRIMARYATTACK     for hipfire
     - ACT_VM_PRIMARYATTACK_1   for ironsights / ADS

This makes the weapons use the model's primary-attack activity
instead of the literal "fire" sequence name, which on these models
maps to a different (incorrect) sequence.

Idempotent: running twice is safe — the script detects the new
ShootAnimation body and skips it.
"""

import os
import re
import sys

WEAPONS_DIR = "/home/z/my-project/cod_ghosts_underhellsweps/lua/weapons"

# Old ShootAnimation body (matches all 25 weapons identically)
OLD_SHOOT_ANIM = """function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end"""

# New ShootAnimation body — returns ACT numbers, lets the base class
# fall through to the activity-based sequence selection.
NEW_SHOOT_ANIM = """function SWEP:ShootAnimation()
    -- Use the model's primary-attack ACT directly (rather than the
    -- "fire" sequence name). ACT_VM_PRIMARYATTACK_1 is the ADS variant
    -- that the model maps to the aimed-fire sequence.
    if self:GetUHBool("Zooming") then
        return ACT_VM_PRIMARYATTACK_1
    end
    return ACT_VM_PRIMARYATTACK
end"""

# Lines to remove from the Animations table
LINES_TO_REMOVE = [
    '    ["shoot"]        = "fire",\n',
    '    ["iron_fire"]    = "fire_ads",\n',
]


def apply_to_file(filepath: str) -> str:
    """Apply changes to a single file. Returns a status string."""
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    original = content
    changes = []

    # 1. Remove the unwanted Animations entries
    for line in LINES_TO_REMOVE:
        if line in content:
            content = content.replace(line, "")
            changes.append(f"removed: {line.strip()}")

    # 2. Replace ShootAnimation body (if not already replaced)
    if OLD_SHOOT_ANIM in content:
        content = content.replace(OLD_SHOOT_ANIM, NEW_SHOOT_ANIM)
        changes.append("replaced ShootAnimation body")
    elif "ACT_VM_PRIMARYATTACK_1" in content:
        # Already updated
        pass
    else:
        print(f"  WARNING: ShootAnimation body not found in {os.path.basename(filepath)}", file=sys.stderr)

    if content == original:
        return "no changes (already up to date)"

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)

    return ", ".join(changes)


def main():
    if not os.path.isdir(WEAPONS_DIR):
        print(f"ERROR: weapons dir not found: {WEAPONS_DIR}", file=sys.stderr)
        sys.exit(1)

    files = sorted(
        os.path.join(WEAPONS_DIR, f)
        for f in os.listdir(WEAPONS_DIR)
        if f.startswith("ghosts_") and f.endswith(".lua")
    )

    if not files:
        print("ERROR: no ghosts_*.lua files found", file=sys.stderr)
        sys.exit(1)

    print(f"Processing {len(files)} weapon files...\n")
    for fp in files:
        status = apply_to_file(fp)
        print(f"  {os.path.basename(fp):<35s}  {status}")

    print("\nDone.")


if __name__ == "__main__":
    main()
