#!/usr/bin/env python3
"""
convert_bf3_to_c_hands.py — Properly convert BF3 weapons to use GMod c_hands.

This is the CORRECT pipeline based on deep research (see docs/C_HANDS_COMPLETE_GUIDE.md).

The problem with previous attempts:
- Option A (keep BF3 positions, change rotations): BROKEN
  - Position and rotation are INCONSISTENT (bone points in wrong direction)
  - c_arms renders at wrong location (fly away)
- Option B (change positions AND rotations): BROKEN
  - Animations break because keyframes are relative to old bind pose
  - c_arms snaps to new position when animation ends (fly away)

The CORRECT pipeline:
1. Decompile BF3 weapon
2. Rename BF3 bones to ValveBiped.Bip01_* (already done in m416 case)
3. Replace hand bone POSITIONS AND ROTATIONS with c_arms_citizen's values
4. Re-bake animation keyframes to maintain the same world-space motion
5. Add Spine4 as root bone (parent of Clavicles)
6. Add $bonemerge for all hand bones
7. Strip v_hands/sleeve_diffuse mesh from SMDs
8. Clean QC (remove v_hands material refs, hands cdmaterials, hands bodygroup)
9. Compile with studiomdl

The re-baking process (step 4):
- For each animation SMD, for each keyframe, for each hand bone:
  - old_bind_pos = BF3's $definebone position
  - old_bind_rot = BF3's $definebone rotation
  - new_bind_pos = c_arms_citizen's position
  - new_bind_rot = c_arms_citizen's rotation
  - keyframe_pos = SMD's keyframe position
  - keyframe_rot = SMD's keyframe rotation
  - new_keyframe_pos = new_bind_pos + (keyframe_pos - old_bind_pos)
  - new_keyframe_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot
- Write the new keyframe values back to the SMD

Note: SMD uses RADIANS for rotations in the skeleton section.
$definebone uses DEGREES.
"""
import os
import re
import math
import shutil
from pathlib import Path
from collections import OrderedDict
import numpy as np
from scipy.spatial.transform import Rotation as R

# Import the BONE_MAP from full_pipeline (handles all BF3 bone naming conventions)
import sys
sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import BONE_MAP, build_bone_map

# ============================================================================
# CONFIGURATION
# ============================================================================
DECOMPILE_DIR = Path("/home/z/my-project/decompile")
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_REFERENCE = Path("/tmp/c_arms_extract/citizen/c_arms_citizen.qc")
C_ARMS_SMD = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")

# ============================================================================
# PARSE c_arms_citizen.smd to get the canonical bone definitions
# ============================================================================
def parse_c_arms_smd(smd_path):
    """Parse c_arms_citizen.smd and return:
        bone_defs: { bone_name: (parent_name, px, py, pz, rx, ry, rz) }
                    (positions in source units, rotations in RADIANS, as stored in SMD)
    """
    bone_ids = OrderedDict()  # id -> name
    bone_parents = {}  # id -> parent_id
    bone_defs = OrderedDict()  # name -> (parent_name, px, py, pz, rx, ry, rz)

    with open(smd_path, 'r', errors='ignore') as f:
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
                px, py, pz = float(m.group(2)), float(m.group(3)), float(m.group(4))
                rx, ry, rz = float(m.group(5)), float(m.group(6)), float(m.group(7))
                name = bone_ids.get(bid, f"unknown_{bid}")
                pid = bone_parents.get(bid, -1)
                parent_name = bone_ids.get(pid, "") if pid >= 0 else ""
                bone_defs[name] = (parent_name, px, py, pz, rx, ry, rz)

    return bone_defs


def parse_c_arms_qc(qc_path):
    """Parse c_arms_citizen.qc to get the canonical $definebone values (in degrees).
    Returns: { bone_name: (parent_name, px, py, pz, rx_deg, ry_deg, rz_deg) }
    """
    bone_defs = OrderedDict()
    with open(qc_path, 'r', errors='ignore') as f:
        for line in f:
            m = re.match(
                r'^\$definebone\s+"([^"]+)"\s+"([^"]*)"\s+'
                r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)',
                line.strip()
            )
            if m:
                name = m.group(1)
                parent = m.group(2)
                px, py, pz = float(m.group(3)), float(m.group(4)), float(m.group(5))
                rx, ry, rz = float(m.group(6)), float(m.group(7)), float(m.group(8))
                bone_defs[name] = (parent, px, py, pz, rx, ry, rz)
    return bone_defs


# ============================================================================
# HAND BONE PATTERNS
# ============================================================================
HAND_BONE_PATTERNS = [
    r'^ValveBiped\.Bip01_[LR]_Clavicle$',
    r'^ValveBiped\.Bip01_[LR]_UpperArm$',
    r'^ValveBiped\.Bip01_[LR]_Forearm$',
    r'^ValveBiped\.Bip01_[LR]_Hand$',
    r'^ValveBiped\.Bip01_[LR]_Finger\d{1,2}$',
    r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$',
    r'^ValveBiped\.Bip01_[LR]_Wrist$',
    r'^ValveBiped\.Bip01_[LR]_Ulna$',
]

def is_hand_bone(name):
    for pat in HAND_BONE_PATTERNS:
        if re.match(pat, name, re.IGNORECASE):
            return True
    return False


def is_bf3_procedural_bone(name):
    """BF3 procedural bones to remove entirely."""
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE))


def rad_to_deg(r):
    return r * 180.0 / math.pi


def deg_to_rad(d):
    return d * math.pi / 180.0


# ============================================================================
# QUATERNION MATH (for rotation re-baking)
# ============================================================================
def euler_xyz_to_quat(rx, ry, rz):
    """Convert XYZ Euler angles (radians) to quaternion (xyzw)."""
    rot = R.from_euler('xyz', [rx, ry, rz])
    return rot.as_quat()  # returns [x, y, z, w]


def quat_to_euler_xyz(q):
    """Convert quaternion (xyzw) to XYZ Euler angles (radians)."""
    rot = R.from_quat(q)
    return rot.as_euler('xyz')


def quat_inverse(q):
    """Inverse of a quaternion (xyzw)."""
    rot = R.from_quat(q)
    return rot.inv().as_quat()


def quat_multiply(q1, q2):
    """Multiply two quaternions (xyzw)."""
    rot1 = R.from_quat(q1)
    rot2 = R.from_quat(q2)
    return (rot1 * rot2).as_quat()


# ============================================================================
# RE-BAKE ANIMATION KEYFRAMES
# ============================================================================
def rebake_animation_smd(smd_path, old_bind_rad, new_bind_rad, hand_bone_names):
    """Re-bake an animation SMD's keyframes from old bind pose to new bind pose.

    Args:
        smd_path: Path to the SMD file
        old_bind_rad: { bone_name: (px, py, pz, rx, ry, rz) in RADIANS } (BF3's bind pose)
        new_bind_rad: { bone_name: (px, py, pz, rx, ry, rz) in RADIANS } (c_arms_citizen's bind pose)
        hand_bone_names: set of bone names that need re-baking

    For each keyframe of each hand bone:
        new_pos = new_bind_pos + (keyframe_pos - old_bind_pos)
        new_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot
    """
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # Parse the nodes section to map bone IDs to names
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

    # Process the skeleton section
    new_lines = []
    in_skeleton = False
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
            new_lines.append(line)
            continue

        # Bone entry line: <id> <px> <py> <pz> <rx> <ry> <rz>
        m = re.match(r'^(\s*)(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
        if m:
            indent = m.group(1)
            bid = int(m.group(2))
            kf_px = float(m.group(3))
            kf_py = float(m.group(4))
            kf_pz = float(m.group(5))
            kf_rx = float(m.group(6))
            kf_ry = float(m.group(7))
            kf_rz = float(m.group(8))
            name = bone_id_to_name.get(bid, '')

            # Only re-bake hand bones
            if name in hand_bone_names and name in old_bind_rad and name in new_bind_rad:
                old_px, old_py, old_pz, old_rx, old_ry, old_rz = old_bind_rad[name]
                new_px, new_py, new_pz, new_rx, new_ry, new_rz = new_bind_rad[name]

                # Re-bake position: new_pos = new_bind_pos + (keyframe_pos - old_bind_pos)
                new_kf_px = new_px + (kf_px - old_px)
                new_kf_py = new_py + (kf_py - old_py)
                new_kf_pz = new_pz + (kf_pz - old_pz)

                # Re-bake rotation: new_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot
                old_bind_quat = euler_xyz_to_quat(old_rx, old_ry, old_rz)
                new_bind_quat = euler_xyz_to_quat(new_rx, new_ry, new_rz)
                kf_quat = euler_xyz_to_quat(kf_rx, kf_ry, kf_rz)

                new_kf_quat = quat_multiply(new_bind_quat, quat_multiply(quat_inverse(old_bind_quat), kf_quat))
                new_kf_rx, new_kf_ry, new_kf_rz = quat_to_euler_xyz(new_kf_quat)

                new_line = f'{indent}{bid} {new_kf_px:.6f} {new_kf_py:.6f} {new_kf_pz:.6f} {new_kf_rx:.6f} {new_kf_ry:.6f} {new_kf_rz:.6f}\n'
                new_lines.append(new_line)
                changes += 1
                continue

        new_lines.append(line)

    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


# ============================================================================
# UPDATE QC FILE: Replace hand bone definitions with c_arms_citizen's values
# ============================================================================
def update_qc(qc_path, c_arms_qc_defs):
    """Update the QC file:
    - REMOVE $definebone lines for hand bones (let SMD source define them)
    - ADD $definebone for Spine4 (at origin, so it exists even if not in SMD)
    - ADD $bonemerge for all hand bones (including Spine4)
    - Remove v_hands/sleeve_diffuse from $texturegroup
    - Remove hands/ from $cdmaterials
    - Remove hands bodygroup

    IMPORTANT: Do NOT use $definebone for hand bones (L_Clavicle, L_UpperArm, etc.)
    because studiomdl's g_bOverridePreDefinedBones=true causes the SMD source values
    to be used anyway, but the "rebuild local pose" code then computes wrong values
    when both $definebone and SMD source are present.
    Instead, let the SMD source define the hand bone positions/rotations.
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content

    # 1. REMOVE $definebone lines for hand bones (let SMD source define them)
    # Keep $definebone for Spine4 and non-hand bones
    def should_remove_definebone(line):
        m = re.match(
            r'^\$definebone\s+"([^"]+)"\s+"([^"]*)"\s+',
            line, re.IGNORECASE
        )
        if not m:
            return False
        bone_name = m.group(1)
        # Remove hand bone definebones (but KEEP Spine4)
        if bone_name == 'ValveBiped.Bip01_Spine4':
            return False
        if is_hand_bone(bone_name):
            return True
        # Remove BF3 procedural bones
        if is_bf3_procedural_bone(bone_name):
            return True
        return False

    lines = content.split('\n')
    new_lines = [line for line in lines if not should_remove_definebone(line)]
    content = '\n'.join(new_lines)

    # 2. Add Spine4 $definebone if not present (at origin)
    if not re.search(r'\$definebone\s+"ValveBiped\.Bip01_Spine4"', content, re.IGNORECASE):
        if 'ValveBiped.Bip01_Spine4' in c_arms_qc_defs:
            _, _, _, _, rx_deg, ry_deg, rz_deg = c_arms_qc_defs['ValveBiped.Bip01_Spine4']
            spine4_def = (f'$definebone "ValveBiped.Bip01_Spine4" "" '
                          f'0.000000 0.000000 0.000000 '
                          f'{rx_deg:.6f} {ry_deg:.6f} {rz_deg:.6f} '
                          f'0 0 0 0 0 0')
            content = re.sub(
                r'(\$definebone)',
                f'{spine4_def}\n\\1',
                content,
                count=1
            )

    # 3. Add $bonemerge for all hand bones (including Spine4)
    bonemerge_bones = ['ValveBiped.Bip01_Spine4']
    for name in c_arms_qc_defs:
        if is_hand_bone(name):
            bonemerge_bones.append(name)

    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_Spine4"', content, re.IGNORECASE):
        bonemerge_block = '\n' + '\n'.join(f'$BoneMerge "{b}"' for b in bonemerge_bones) + '\n'
        lines = content.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, bonemerge_block)
            content = '\n'.join(lines)

    # 4. Remove v_hands/sleeve_diffuse from $texturegroup
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)

    # 5. Remove hands/ cdmaterials
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)

    # 6. Remove hands bodygroup if present
    content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                     '// REMOVED: hands bodygroup (c_hands provides arm mesh)',
                     content, flags=re.IGNORECASE | re.DOTALL)

    if content != original:
        with open(qc_path, 'w') as f:
            f.write(content)
        return True
    return False


# ============================================================================
# UPDATE SMD FILES: Replace hand bone rest pose + re-bake animations
# ============================================================================
def update_smd(smd_path, c_arms_smd_defs, old_bind_rad, new_bind_rad, hand_bone_names, is_anim=False):
    """Update an SMD file:
    - Add Spine4 as a new root bone (at the end of the bone list)
    - Reparent L_Clavicle and R_Clavicle to Spine4
    - Replace hand bone rest pose (time 0) with c_arms_citizen's values
    - For animation SMDs: re-bake all keyframes to maintain world-space motion
    - Remove BF3 procedural bones from nodes section
    """
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # Parse the nodes section to map bone IDs to names
    bone_id_to_name = {}
    bone_name_to_id = {}
    in_nodes = False
    nodes_lines = []  # (line_index, bid, name, parent_id)
    for i, line in enumerate(lines):
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            nodes_lines.append((i, None, None, None))
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            nodes_lines.append((i, None, None, None))
            break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                pid = int(m.group(3))
                bone_id_to_name[bid] = name
                bone_name_to_id[name] = bid
                nodes_lines.append((i, bid, name, pid))
            else:
                nodes_lines.append((i, None, None, None))

    # Identify BF3 procedural bones to remove
    bones_to_remove = set()
    for bid, name in bone_id_to_name.items():
        if is_bf3_procedural_bone(name):
            bones_to_remove.add(bid)

    # Determine the new bone ID for Spine4 (max existing ID + 1)
    max_bone_id = max(bone_id_to_name.keys()) if bone_id_to_name else 0
    spine4_id = max_bone_id + 1

    # Identify L_Clavicle and R_Clavicle bone IDs (to reparent to Spine4)
    clavicle_ids = set()
    for bid, name in bone_id_to_name.items():
        if name in ('ValveBiped.Bip01_L_Clavicle', 'ValveBiped.Bip01_R_Clavicle'):
            clavicle_ids.add(bid)

    # Process the file
    new_lines = []
    in_skeleton = False
    in_nodes_section = False
    nodes_added_spine4 = False
    skeleton_added_spine4_pose = False
    changes = 0

    for i, line in enumerate(lines):
        s = line.strip()

        # Handle nodes section
        if s == 'nodes':
            in_nodes_section = True
            new_lines.append(line)
            continue
        if s == 'end' and in_nodes_section:
            in_nodes_section = False
            # Add Spine4 as the last bone before 'end'
            if not nodes_added_spine4:
                spine4_node_line = f'  {spine4_id} "ValveBiped.Bip01_Spine4" -1\n'
                new_lines.append(spine4_node_line)
                nodes_added_spine4 = True
                changes += 1
            new_lines.append(line)
            continue
        if in_nodes_section:
            # Use the ORIGINAL line (not stripped) for regex to preserve indentation
            m = re.match(r'^(\s*)(\d+)\s+"([^"]+)"\s+(-?\d+)\s*$', line)
            if m:
                indent = m.group(1)
                bid = int(m.group(2))
                name = m.group(3)
                pid = int(m.group(4))

                # Skip BF3 procedural bones
                if bid in bones_to_remove:
                    changes += 1
                    continue

                # Reparent L_Clavicle and R_Clavicle to Spine4
                if bid in clavicle_ids and pid == -1:
                    new_line = f'{indent}{bid} "{name}" {spine4_id}\n'
                    new_lines.append(new_line)
                    changes += 1
                    continue

            new_lines.append(line)
            continue

        # Handle skeleton section
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
            # Before the first 'time 0', add Spine4's rest pose
            if not skeleton_added_spine4_pose and s == 'time 0':
                new_lines.append(line)
                # Add Spine4's rest pose
                if 'ValveBiped.Bip01_Spine4' in new_bind_rad:
                    spx, spy, spz, srx, sry, srz = new_bind_rad['ValveBiped.Bip01_Spine4']
                    spine4_pose = f'  {spine4_id} {spx:.6f} {spy:.6f} {spz:.6f} {srx:.6f} {sry:.6f} {srz:.6f}\n'
                    new_lines.append(spine4_pose)
                    skeleton_added_spine4_pose = True
                    changes += 1
                continue
            new_lines.append(line)
            continue

        # Bone entry line - use ORIGINAL line to preserve indentation
        m = re.match(r'^(\s*)(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s*$', line)
        if m:
            indent = m.group(1)
            bid = int(m.group(2))
            name = bone_id_to_name.get(bid, '')

            # Skip BF3 procedural bones entirely
            if bid in bones_to_remove:
                changes += 1
                continue

            kf_px = float(m.group(3))
            kf_py = float(m.group(4))
            kf_pz = float(m.group(5))
            kf_rx = float(m.group(6))
            kf_ry = float(m.group(7))
            kf_rz = float(m.group(8))

            # If this is a hand bone, re-bake it
            if name in hand_bone_names and name in old_bind_rad and name in new_bind_rad:
                old_px, old_py, old_pz, old_rx, old_ry, old_rz = old_bind_rad[name]
                new_px, new_py, new_pz, new_rx, new_ry, new_rz = new_bind_rad[name]

                # Re-bake position: new_pos = new_bind_pos + (keyframe_pos - old_bind_pos)
                new_kf_px = new_px + (kf_px - old_px)
                new_kf_py = new_py + (kf_py - old_py)
                new_kf_pz = new_pz + (kf_pz - old_pz)

                # Re-bake rotation: new_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot
                old_bind_quat = euler_xyz_to_quat(old_rx, old_ry, old_rz)
                new_bind_quat = euler_xyz_to_quat(new_rx, new_ry, new_rz)
                kf_quat = euler_xyz_to_quat(kf_rx, kf_ry, kf_rz)

                new_kf_quat = quat_multiply(new_bind_quat, quat_multiply(quat_inverse(old_bind_quat), kf_quat))
                new_kf_rx, new_kf_ry, new_kf_rz = quat_to_euler_xyz(new_kf_quat)

                new_line = f'{indent}{bid} {new_kf_px:.6f} {new_kf_py:.6f} {new_kf_pz:.6f} {new_kf_rx:.6f} {new_kf_ry:.6f} {new_kf_rz:.6f}\n'
                new_lines.append(new_line)
                changes += 1
                continue

        new_lines.append(line)

    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


# ============================================================================
# STRIP v_hands MESH FROM SMDs
# ============================================================================
HAND_MATERIALS = {"v_hands", "sleeve_diffuse", "sleeve_diff", "t_phoenix"}


def strip_hand_triangles_from_smd(smd_path):
    """Strip v_hands/sleeve_diffuse triangle blocks from an SMD file."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content
    triangles_stripped = 0

    triangles_match = re.search(r'^triangles\s*\n', content, re.MULTILINE)
    if not triangles_match:
        return 0

    triangles_start = triangles_match.end()
    end_match = re.search(r'^end\s*$', content[triangles_start:], re.MULTILINE)
    if not end_match:
        return 0

    triangles_end = triangles_start + end_match.start()
    triangles_section = content[triangles_start:triangles_end]

    new_triangles = []
    current_material = None
    current_vertices = []

    lines = triangles_section.split('\n')
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        is_vertex = bool(re.match(r'^\s+\d+\s+', line))

        if not is_vertex and stripped:
            if current_material is not None and current_vertices:
                if current_material.lower() not in HAND_MATERIALS:
                    new_triangles.append(current_material)
                    new_triangles.extend(current_vertices)
                else:
                    triangles_stripped += 1
            current_material = stripped
            current_vertices = []
        elif is_vertex:
            current_vertices.append(line)
        elif not stripped:
            if current_material is not None and current_vertices:
                if current_material.lower() not in HAND_MATERIALS:
                    new_triangles.append(current_material)
                    new_triangles.extend(current_vertices)
                else:
                    triangles_stripped += 1
                current_material = None
                current_vertices = []
        i += 1

    if current_material is not None and current_vertices:
        if current_material.lower() not in HAND_MATERIALS:
            new_triangles.append(current_material)
            new_triangles.extend(current_vertices)
        else:
            triangles_stripped += 1

    new_triangles_str = '\n'.join(new_triangles)
    if new_triangles_str:
        new_triangles_str += '\n'

    new_content = (
        content[:triangles_start] +
        new_triangles_str +
        content[triangles_end:]
    )

    if triangles_stripped > 0:
        with open(smd_path, 'w') as f:
            f.write(new_content)
    return triangles_stripped


# ============================================================================
# MAIN PROCESSING
# ============================================================================
def rename_bones_in_text(content, bone_map):
    """Rename bones in text content (SMD or QC) using the bone_map.
    Matches bone names in quotes: "OldName" -> "NewName"
    Sorts by length descending so longer names are matched first (e.g. "L Finger01" before "L Finger0").
    """
    for old, new in sorted(bone_map.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content


def convert_weapon(weapon, c_arms_qc_defs, c_arms_smd_defs):
    """Convert a single BF3 weapon to use c_hands."""
    src_dir = DECOMPILE_DIR / weapon
    dst_dir = COMPILE_DIR / weapon / "source"

    if not src_dir.exists():
        print(f"  SKIP {weapon}: no decompile folder")
        return False

    # Create destination
    if dst_dir.exists():
        shutil.rmtree(dst_dir)
    dst_dir.mkdir(parents=True)

    # Copy all files from decompile to compile/source
    for item in src_dir.iterdir():
        if item.is_dir():
            shutil.copytree(item, dst_dir / item.name)
        else:
            shutil.copy2(item, dst_dir)

    qc_path = dst_dir / f"{weapon}.qc"
    if not qc_path.exists():
        print(f"  SKIP {weapon}: no QC file")
        return False

    print(f"\nProcessing {weapon}...")

    # Step 0: Rename bones from BF3 conventions to ValveBiped.Bip01_*
    # This handles "L Clavicle", "Bip01 L Clavicle", "b_ch_l_clavical", "l-upperarm", etc.
    bone_map = build_bone_map()

    # Add weapon-specific finger mappings (BF3 uses numbered bones like "Left1", "Right1" etc.)
    # Parse the SMD bones to find numbered finger bones
    bone_hierarchy = {}
    for smd in dst_dir.glob("*.smd"):
        try:
            with open(smd, "r", errors="ignore") as fh:
                content = fh.read()
            for m in re.finditer(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', content, re.MULTILINE):
                bone_hierarchy[int(m.group(1))] = (m.group(2), int(m.group(3)))
        except Exception:
            pass

    weapon_bone_map = dict(bone_map)
    # Add numbered finger mapping (Left1-15, Right1-15)
    for side_prefix, vb_side in [("Left", "L"), ("Right", "R")]:
        hand_name = f"{side_prefix}_Hand"
        if hand_name not in [b[0] for b in bone_hierarchy.values()]:
            continue
        hand_id = None
        for bid, (name, parent) in bone_hierarchy.items():
            if name == hand_name:
                hand_id = bid
                break
        if hand_id is None:
            continue
        finger_roots = []
        for bid, (name, parent) in sorted(bone_hierarchy.items()):
            if parent == hand_id and re.match(rf'^{side_prefix}\d+$', name):
                finger_roots.append((bid, name))
        def extract_num(n):
            m = re.search(r'(\d+)$', n)
            return int(m.group(1)) if m else 0
        finger_roots.sort(key=lambda x: extract_num(x[1]))
        for finger_idx, (root_bid, root_name) in enumerate(finger_roots[:5]):
            weapon_bone_map[root_name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}"
            for bid, (name, parent) in bone_hierarchy.items():
                if parent == root_bid:
                    weapon_bone_map[name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}1"
                    for bid2, (name2, parent2) in bone_hierarchy.items():
                        if parent2 == bid:
                            weapon_bone_map[name2] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}2"

    # Apply bone renaming to all SMD and QC files
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            src_path = os.path.join(root, f)
            if f.endswith((".smd", ".qc", ".qci")):
                try:
                    with open(src_path, "r", errors="ignore") as fh:
                        content = fh.read()
                    content = rename_bones_in_text(content, weapon_bone_map)
                    # Also rename modelname to c_<weapon>
                    if f.endswith(".qc"):
                        content = re.sub(r'\$modelname\s+"[^"]*"',
                                        f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
                        # Remove $sectionframes (unsupported by SDK 2013)
                        content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
                    with open(src_path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    print(f"  WARN: failed to rename bones in {f}: {e}")

    print(f"  Bone renaming complete")

    # Step 1: Parse the current BF3 bind pose (in radians, from the reference SMD)
    # Use the first reference SMD (default.smd or hands.smd) to get the old bind pose
    old_bind_rad = {}
    for smd_name in ['default.smd', 'hands.smd', f'{weapon}.smd']:
        ref_smd = dst_dir / smd_name
        if ref_smd.exists():
            with open(ref_smd, 'r', errors='ignore') as f:
                lines = f.readlines()
            bone_id_to_name = {}
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
                        bone_id_to_name[bid] = name

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
                        px, py, pz = float(m.group(2)), float(m.group(3)), float(m.group(4))
                        rx, ry, rz = float(m.group(5)), float(m.group(6)), float(m.group(7))
                        name = bone_id_to_name.get(bid, '')
                        if name and is_hand_bone(name):
                            old_bind_rad[name] = (px, py, pz, rx, ry, rz)
            break

    # Step 2: Build new_bind_rad from c_arms_citizen.smd (radians)
    # For Spine4, use (0, 0, 0) position (not c_arms_citizen's world position of 0, 3.34, 58.35)
    # because the weapon's Spine4 should be at the weapon origin, not the c_arms camera position
    new_bind_rad = {}
    for name, (parent, px, py, pz, rx, ry, rz) in c_arms_smd_defs.items():
        if is_hand_bone(name):
            new_bind_rad[name] = (px, py, pz, rx, ry, rz)
        elif name == 'ValveBiped.Bip01_Spine4':
            # Spine4: use (0, 0, 0) position but keep c_arms_citizen's rotation
            new_bind_rad[name] = (0.0, 0.0, 0.0, rx, ry, rz)

    hand_bone_names = set(new_bind_rad.keys()) & set(old_bind_rad.keys())
    print(f"  Found {len(hand_bone_names)} hand bones to re-bake")

    # Step 3: Update QC - replace $definebone, add Spine4, add $bonemerge, clean materials
    qc_changes = update_qc(qc_path, c_arms_qc_defs)
    print(f"  QC: {qc_changes} bone definitions updated")

    # Step 4: Update all reference SMDs (bodygroup meshes) - replace rest pose + re-bake
    for smd in sorted(dst_dir.glob("*.smd")):
        changes = update_smd(smd, c_arms_smd_defs, old_bind_rad, new_bind_rad, hand_bone_names, is_anim=False)
        if changes:
            print(f"  {smd.name}: {changes} bone entries updated")

    # Step 5: Update all animation SMDs - re-bake keyframes
    anims_dir = dst_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in sorted(anims_dir.glob("*.smd")):
            changes = update_smd(smd, c_arms_smd_defs, old_bind_rad, new_bind_rad, hand_bone_names, is_anim=True)
            if changes:
                print(f"  {smd.parent.name}/{smd.name}: {changes} keyframes re-baked")

    # Step 6: Strip v_hands mesh from all SMDs
    for smd in sorted(list(dst_dir.glob("*.smd")) + list(anims_dir.glob("*.smd")) if anims_dir.exists() else list(dst_dir.glob("*.smd"))):
        stripped = strip_hand_triangles_from_smd(smd)
        if stripped:
            print(f"  {smd.name}: stripped {stripped} hand triangles")

    return True


def main():
    print("=" * 70)
    print("convert_bf3_to_c_hands.py")
    print("Properly convert BF3 weapons to use GMod c_hands")
    print("=" * 70)

    if not C_ARMS_REFERENCE.exists():
        print(f"ERROR: c_arms_citizen.qc reference not found at {C_ARMS_REFERENCE}")
        return

    print(f"\nParsing c_arms_citizen.qc reference (degrees)...")
    c_arms_qc_defs = parse_c_arms_qc(C_ARMS_REFERENCE)
    print(f"  Found {len(c_arms_qc_defs)} bone definitions")

    print(f"\nParsing c_arms_citizen.smd reference (radians)...")
    c_arms_smd_defs = parse_c_arms_smd(C_ARMS_SMD)
    print(f"  Found {len(c_arms_smd_defs)} bone definitions")

    # Get list of weapons
    weapons = sorted([d.name for d in DECOMPILE_DIR.iterdir()
                      if d.is_dir() and not d.name.startswith('.')
                      and d.name not in {'ghosts_m27_lmg', 'm416_prev_compiled', 'm416_check_bonemerge', 'scotia_c_arms_ref'}])
    print(f"\nFound {len(weapons)} weapons to convert")

    success = 0
    failed_list = []

    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        try:
            if convert_weapon(weapon, c_arms_qc_defs, c_arms_smd_defs):
                success += 1
            else:
                failed_list.append(weapon)
        except Exception as e:
            print(f"  FAIL: {e}")
            import traceback
            traceback.print_exc()
            failed_list.append(weapon)

    print()
    print("=" * 70)
    print(f"SUCCESS: {success}/{len(weapons)}")
    if failed_list:
        print(f"FAILED:  {len(failed_list)} -> {', '.join(failed_list)}")
    print("=" * 70)


if __name__ == "__main__":
    main()
