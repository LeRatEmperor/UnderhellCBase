#!/usr/bin/env python3
"""
revert_and_clean_qc.py — Reverts the c_arms_retarget changes by re-running the
original full_pipeline.py convert phase (which preserves BF3 bone positions,
keeps animation keyframes, no Spine4 addition). Then applies ONLY the QC cleanup:
- Remove "v_hands" and "sleeve_diffuse" from $texturegroup skinfamilies
- Remove "models\weapons\v_models\hands\" from $cdmaterials

This is the minimal fix that addresses "old c_hands still render" (the texture
references) without breaking the c_arms mesh position or animations.
"""
import os
import sys
import shutil
import re
import subprocess
from pathlib import Path

# Add the scripts dir so we can use full_pipeline's convert_weapon function
sys.path.insert(0, '/home/z/my-project/scripts')

# Import the conversion functions from full_pipeline
from full_pipeline import convert_weapon, BONE_MAP, COMPILE_DIR, DECOMPILE_DIR

# ============================================================================
# QC CLEANUP + BONEMERGE (the only post-conversion changes we want)
# ============================================================================
# Standard hand bones that need $bonemerge so GMod's c_arms can attach.
# This includes ALL hand bones from the ValveBiped skeleton.
HAND_BONES_FOR_BONEMERGE = [
    "ValveBiped.Bip01_L_Clavicle",
    "ValveBiped.Bip01_L_UpperArm",
    "ValveBiped.Bip01_L_Forearm",
    "ValveBiped.Bip01_L_Hand",
    "ValveBiped.Bip01_L_Finger0",
    "ValveBiped.Bip01_L_Finger01",
    "ValveBiped.Bip01_L_Finger02",
    "ValveBiped.Bip01_L_Finger1",
    "ValveBiped.Bip01_L_Finger11",
    "ValveBiped.Bip01_L_Finger12",
    "ValveBiped.Bip01_L_Finger2",
    "ValveBiped.Bip01_L_Finger21",
    "ValveBiped.Bip01_L_Finger22",
    "ValveBiped.Bip01_L_Finger3",
    "ValveBiped.Bip01_L_Finger31",
    "ValveBiped.Bip01_L_Finger32",
    "ValveBiped.Bip01_L_Finger4",
    "ValveBiped.Bip01_L_Finger41",
    "ValveBiped.Bip01_L_Finger42",
    "ValveBiped.Bip01_R_Clavicle",
    "ValveBiped.Bip01_R_UpperArm",
    "ValveBiped.Bip01_R_Forearm",
    "ValveBiped.Bip01_R_Hand",
    "ValveBiped.Bip01_R_Finger0",
    "ValveBiped.Bip01_R_Finger01",
    "ValveBiped.Bip01_R_Finger02",
    "ValveBiped.Bip01_R_Finger1",
    "ValveBiped.Bip01_R_Finger11",
    "ValveBiped.Bip01_R_Finger12",
    "ValveBiped.Bip01_R_Finger2",
    "ValveBiped.Bip01_R_Finger21",
    "ValveBiped.Bip01_R_Finger22",
    "ValveBiped.Bip01_R_Finger3",
    "ValveBiped.Bip01_R_Finger31",
    "ValveBiped.Bip01_R_Finger32",
    "ValveBiped.Bip01_R_Finger4",
    "ValveBiped.Bip01_R_Finger41",
    "ValveBiped.Bip01_R_Finger42",
]

# Build bonemerge block as text
BONEMERGE_BLOCK = '\n' + '\n'.join(f'$BoneMerge "{b}"' for b in HAND_BONES_FOR_BONEMERGE) + '\n'


def clean_qc(qc_path):
    """Apply ONLY the QC cleanup:
    - Remove v_hands and sleeve_diffuse from $texturegroup skinfamilies
    - Remove hands/ folder from $cdmaterials
    - Ensure $bonemerge is present for ALL hand bones (not just weapons that had hands bodygroup)
    This removes the references to the old baked-in hand textures AND ensures c_arms can attach.
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()
    original = content

    # Remove v_hands/sleeve_diffuse entries from $texturegroup (with leading whitespace)
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)

    # Remove the hands/ cdmaterials entry (both forward-slash and backslash variants)
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)

    # Ensure $bonemerge is present for ALL hand bones
    # (full_pipeline.py only adds it for weapons that had a hands bodygroup — but weapons
    # without a hands bodygroup still need it so c_arms can attach)
    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_L_Clavicle"', content, re.IGNORECASE):
        # Find last $definebone line and insert bonemerge block after it
        lines = content.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, BONEMERGE_BLOCK)
            content = '\n'.join(lines)

    if content != original:
        with open(qc_path, 'w') as f:
            f.write(content)
        return True
    return False


# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("revert_and_clean_qc.py")
    print("Reverts c_arms_retarget by re-running full_pipeline convert phase,")
    print("then applies ONLY the QC cleanup (no bone changes, no anim stripping).")
    print("=" * 70)

    # Get list of weapons
    weapons = sorted([d.name for d in Path(DECOMPILE_DIR).iterdir()
                      if d.is_dir() and not d.name.startswith('.')])
    print(f"\nFound {len(weapons)} weapons in decompile folder")

    # Skip the scotia_c_arms_ref and m416_compiled_back folders (these aren't weapons)
    skip_dirs = {'scotia_c_arms_ref', 'm416_compiled_back', 'm416_fixed_check'}
    weapons = [w for w in weapons if w not in skip_dirs]
    print(f"Processing {len(weapons)} weapons")

    success = 0
    failed_list = []
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i:2d}/{len(weapons)}] {weapon}")

        # Delete the existing source folder so we get a fresh conversion
        src_dir = Path(COMPILE_DIR) / weapon / "source"
        if src_dir.exists():
            shutil.rmtree(src_dir)

        # Re-run the original convert phase (preserves BF3 bone positions, anims, no Spine4)
        try:
            if convert_weapon(weapon, BONE_MAP):
                # Now apply the QC cleanup
                qc_path = src_dir / f"{weapon}.qc"
                if qc_path.exists():
                    if clean_qc(qc_path):
                        print(f"  OK: converted + QC cleaned (v_hands/sleeve_diffuse/hands cdmaterials removed)")
                    else:
                        print(f"  OK: converted (QC had nothing to clean)")
                    success += 1
                else:
                    print(f"  WARN: converted but QC file not found at {qc_path}")
                    failed_list.append(weapon)
            else:
                print(f"  FAIL: convert_weapon returned False")
                failed_list.append(weapon)
        except Exception as e:
            print(f"  FAIL: {e}")
            failed_list.append(weapon)

    print()
    print("=" * 70)
    print(f"SUCCESS: {success}/{len(weapons)}")
    if failed_list:
        print(f"FAILED:  {len(failed_list)} -> {', '.join(failed_list)}")
    print("=" * 70)


if __name__ == "__main__":
    main()
