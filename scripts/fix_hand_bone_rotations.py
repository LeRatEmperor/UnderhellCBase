#!/usr/bin/env python3
"""
fix_hand_bone_rotations.py — Fix the c_hands orientation issue.

PROBLEM:
- BF3 weapons have ValveBiped.Bip01_* hand bones with BF3-specific ROTATIONS
- When c_arms is bonemerged onto these bones, c_arms's fingers/hand inherit the BF3 rotations
- Result: c_hands appear with wrong finger orientations, thumb OK but other fingers twisted

INSPIRATION (from COD Ghosts weapons):
- Ghosts weapons have ValveBiped.Bip01_* bones with rotations that match c_arms_citizen's bind pose
- So when c_arms bonemerges onto them, it renders correctly

FIX:
- For each ValveBiped.Bip01_* hand bone (Clavicle, UpperArm, Forearm, Hand, all Fingers, ForeTwists):
  * KEEP the position (so the bone stays in the same world location)
  * REPLACE the rotation with c_arms_citizen's rotation value (so c_arms renders correctly)
- DO NOT change positions (that was the bug in the previous c_arms_retarget attempt)
- DO NOT strip animation keyframes (animations need to keep working)
- DO NOT add Spine4 or change bone hierarchy

This is the MINIMAL change that fixes the finger orientation without breaking anything else.
"""
import os
import re
import math
from pathlib import Path
from collections import OrderedDict

# ============================================================================
# CONFIGURATION
# ============================================================================
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_REFERENCE = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")

# ============================================================================
# PARSE THE c_arms_citizen.smd REFERENCE
# ============================================================================
def parse_c_arms_reference(ref_path):
    """Parse c_arms_citizen.smd and return:
        bone_rotations: { bone_name: (rx_rad, ry_rad, rz_rad) }
    """
    bone_ids = OrderedDict()  # id -> name
    bone_parents = {}  # id -> parent_id
    bone_rotations = {}  # name -> (rx, ry, rz) in radians

    with open(ref_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # Parse nodes section
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                pid = int(m.group(3))
                bone_ids[bid] = name
                bone_parents[bid] = pid

    # Parse skeleton section (time 0 only — that's the rest pose)
    in_skeleton = False
    in_time_0 = False
    for line in lines:
        s = line.strip()
        if s == 'skeleton':
            in_skeleton = True
            continue
        if s == 'end' and in_skeleton:
            break
        if not in_skeleton:
            continue
        if s.startswith('time'):
            in_time_0 = (s == 'time 0')
            continue
        if in_time_0:
            m = re.match(r'^\s*(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                         r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
            if m:
                bid = int(m.group(1))
                rx = float(m.group(5))
                ry = float(m.group(6))
                rz = float(m.group(7))
                name = bone_ids.get(bid, f"unknown_{bid}")
                bone_rotations[name] = (rx, ry, rz)

    return bone_rotations


# ============================================================================
# IDENTIFY HAND BONES (the ones whose rotations should be replaced)
# ============================================================================
HAND_BONE_PATTERNS = [
    r'^ValveBiped\.Bip01_[LR]_Clavicle$',
    r'^ValveBiped\.Bip01_[LR]_UpperArm$',
    r'^ValveBiped\.Bip01_[LR]_Forearm$',
    r'^ValveBiped\.Bip01_[LR]_Hand$',
    r'^ValveBiped\.Bip01_[LR]_Finger\d{1,2}$',  # Finger0, Finger01, Finger02, Finger1, Finger11, Finger12, etc.
    r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$',  # ForeTwist, ForeTwist1-6
]

def is_hand_bone(name):
    """Check if a bone is a hand bone (should have rotation replaced)."""
    for pat in HAND_BONE_PATTERNS:
        if re.match(pat, name, re.IGNORECASE):
            return True
    return False


def rad_to_deg(r):
    return r * 180.0 / math.pi


# ============================================================================
# UPDATE THE QC FILE — Replace hand bone ROTATIONS (keep positions)
# ============================================================================
def update_qc(qc_path, c_arms_rotations):
    """For each $definebone line in the QC, if the bone is a hand bone AND it exists
    in c_arms_rotations, REPLACE the rotation values (rx, ry, rz in degrees) with
    c_arms_citizen's values. KEEP the position values.
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content
    changes = 0

    # Process each $definebone line
    def replace_definebone(match):
        nonlocal changes
        line = match.group(0)
        m = re.match(
            r'^\$definebone\s+"([^"]+)"\s+"([^"]*)"\s+'
            r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
            r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)',
            line, re.IGNORECASE
        )
        if not m:
            return line

        bone_name = m.group(1)
        parent_name = m.group(2)
        px, py, pz = float(m.group(3)), float(m.group(4)), float(m.group(5))
        rx_deg, ry_deg, rz_deg = float(m.group(6)), float(m.group(7)), float(m.group(8))

        # If this is a hand bone AND it exists in c_arms_citizen, replace rotation
        if is_hand_bone(bone_name) and bone_name in c_arms_rotations:
            new_rx_rad, new_ry_rad, new_rz_rad = c_arms_rotations[bone_name]
            new_rx_deg = rad_to_deg(new_rx_rad)
            new_ry_deg = rad_to_deg(new_ry_rad)
            new_rz_deg = rad_to_deg(new_rz_rad)
            changes += 1
            # Build new line, keeping the same format
            new_line = (f'$definebone "{bone_name}" "{parent_name}" '
                        f'{px:.6f} {py:.6f} {pz:.6f} '
                        f'{new_rx_deg:.6f} {new_ry_deg:.6f} {new_rz_deg:.6f} '
                        f'0 0 0 0 0 0')
            return new_line

        return line

    content = re.sub(r'^\$definebone\s+"[^"]+"\s+"[^"]*"\s+'
                     r'(-?\d+\.?\d*\s+){5}(-?\d+\.?\d*)'
                     r'(\s+-?\d+\.?\d*){6}',
                     replace_definebone, content, flags=re.MULTILINE)

    if changes > 0:
        with open(qc_path, 'w') as f:
            f.write(content)
    return changes


# ============================================================================
# UPDATE SMD FILES — Replace hand bone ROTATIONS in skeleton section
# ============================================================================
def update_smd(smd_path, c_arms_rotations):
    """For each hand bone entry in the SMD's skeleton section, replace the rotation
    with c_arms_citizen's value (keep position). DO NOT touch animation keyframes —
    only the rest pose (time 0).
    """
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # First, parse the nodes section to find the bone IDs and names
    bone_id_to_name = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            continue
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                bone_id_to_name[bid] = name

    # Process the skeleton section — only update time 0 (rest pose)
    new_lines = []
    in_skeleton = False
    in_time_0 = False
    changes = 0

    for line in lines:
        s = line.strip()

        if s == 'skeleton':
            in_skeleton = True
            new_lines.append(line)
            continue
        if s == 'end' and in_skeleton:
            in_skeleton = False
            new_lines.append(line)
            continue
        if not in_skeleton:
            new_lines.append(line)
            continue

        # In skeleton section
        if s.startswith('time'):
            in_time_0 = (s == 'time 0')
            new_lines.append(line)
            continue

        # Only modify time 0 (rest pose). Leave animation keyframes (time > 0) UNCHANGED.
        if not in_time_0:
            new_lines.append(line)
            continue

        # Bone entry line in time 0: <id> <px> <py> <pz> <rx> <ry> <rz>
        m = re.match(r'^(\s*)(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
        if m:
            indent = m.group(1)
            bid = int(m.group(2))
            px, py, pz = float(m.group(3)), float(m.group(4)), float(m.group(5))
            rx, ry, rz = float(m.group(6)), float(m.group(7)), float(m.group(8))
            name = bone_id_to_name.get(bid, '')

            # If this is a hand bone AND it exists in c_arms_citizen, replace rotation
            if is_hand_bone(name) and name in c_arms_rotations:
                new_rx, new_ry, new_rz = c_arms_rotations[name]
                new_line = f'{indent}{bid} {px:.6f} {py:.6f} {pz:.6f} {new_rx:.6f} {new_ry:.6f} {new_rz:.6f}\n'
                new_lines.append(new_line)
                changes += 1
                continue

        new_lines.append(line)

    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


# ============================================================================
# MAIN
# ============================================================================
def fix_weapon(weapon_dir, c_arms_rotations):
    weapon = weapon_dir.name
    src_dir = weapon_dir / "source"

    if not src_dir.exists():
        print(f"  SKIP {weapon}: no source dir")
        return False

    qc = src_dir / f"{weapon}.qc"
    if not qc.exists():
        print(f"  SKIP {weapon}: no QC file")
        return False

    print(f"\nProcessing {weapon}...")

    # 1. Update the QC — replace hand bone rotations only
    qc_changes = update_qc(qc, c_arms_rotations)
    if qc_changes:
        print(f"  QC: {qc_changes} hand bone rotations replaced")

    # 2. Update all reference SMDs (bodygroup meshes) — replace hand bone rotations in rest pose only
    smd_changes_total = 0
    for smd in sorted(src_dir.glob("*.smd")):
        smd_changes = update_smd(smd, c_arms_rotations)
        if smd_changes:
            print(f"  {smd.name}: {smd_changes} hand bone rotations updated in rest pose")
            smd_changes_total += smd_changes

    # 3. Update all animation SMDs — replace hand bone rotations in rest pose only (time 0)
    # Note: we DO NOT touch animation keyframes (time > 0), only the rest pose
    anims_dir = src_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in sorted(anims_dir.glob("*.smd")):
            smd_changes = update_smd(smd, c_arms_rotations)
            if smd_changes:
                print(f"  {smd.parent.name}/{smd.name}: {smd_changes} hand bone rotations updated in rest pose")
                smd_changes_total += smd_changes

    return True


def main():
    print("=" * 70)
    print("fix_hand_bone_rotations.py")
    print("Replace ONLY the ROTATIONS of hand bones with c_arms_citizen's values.")
    print("Keep positions, animation keyframes, and bone hierarchy UNCHANGED.")
    print("=" * 70)

    if not C_ARMS_REFERENCE.exists():
        print(f"ERROR: c_arms_citizen.smd reference not found at {C_ARMS_REFERENCE}")
        return

    print(f"\nParsing c_arms_citizen.smd reference...")
    c_arms_rotations = parse_c_arms_reference(C_ARMS_REFERENCE)
    print(f"  Found {len(c_arms_rotations)} bones with rotation data")
    print(f"  Sample bones:")
    for name, (rx, ry, rz) in list(c_arms_rotations.items())[:5]:
        print(f"    {name}: rot=({rx:.3f}, {ry:.3f}, {rz:.3f}) rad = ({rad_to_deg(rx):.1f}, {rad_to_deg(ry):.1f}, {rad_to_deg(rz):.1f}) deg")

    # Process each weapon
    for weapon_dir in sorted(COMPILE_DIR.iterdir()):
        if not weapon_dir.is_dir():
            continue
        if weapon_dir.name == "Battlefield3":
            continue
        fix_weapon(weapon_dir, c_arms_rotations)

    print("\n" + "=" * 70)
    print("Done! Next step: recompile all weapons with studiomdl")
    print("=" * 70)


if __name__ == "__main__":
    main()
