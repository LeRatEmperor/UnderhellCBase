#!/usr/bin/env python3
"""
hybrid_c_hands.py — The CORRECT approach to c_hands for BF3 weapons.

This implements the Ghosts-style HYBRID bone system:
1. Keep ALL existing BF3 bones as-is (they're the animation bones)
2. RENAME existing ValveBiped hand bones to "anim_*" (to avoid name conflicts)
3. ADD NEW ValveBiped.Bip01_* bones as children of the renamed anim_* bones
4. The new bones have local transforms that produce c_arms_citizen's bind pose
5. Add $bonemerge for the new ValveBiped bones
6. c_arms bonemerges onto the new bones (which have correct c_arms_citizen transforms)

The math:
For each hand bone:
  - BF3 bone world transform at bind pose = BF3_world
  - c_arms_citizen world transform = c_arms_world
  - New bone local transform = inverse(BF3_world) * c_arms_world
  - At bind pose: new_bone_world = BF3_world * local = c_arms_world ✓
  - During animation: new_bone_world = animated_BF3_world * local
    = (delta * BF3_world) * inverse(BF3_world) * c_arms_world = delta * c_arms_world ✓

This means:
- c_arms renders at c_arms_citizen's bind pose (correct finger rotations)
- c_arms follows the BF3 animation (correct animation)
- No need to re-bake animations
- No fly-away (bind pose is consistent)
- Works for ALL weapons regardless of bone naming convention
"""
import os
import re
import math
import shutil
import sys
from pathlib import Path
from collections import OrderedDict
import numpy as np
from scipy.spatial.transform import Rotation as R

sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map

DECOMPILE_DIR = Path("/home/z/my-project/decompile")
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_SMD = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")
C_ARMS_QC = Path("/tmp/c_arms_extract/citizen/c_arms_citizen.qc")

HAND_MATERIALS = {"v_hands", "sleeve_diffuse", "sleeve_diff", "t_phoenix"}

# The 38 hand bones that c_arms needs (with their c_arms_citizen hierarchy)
HAND_BONE_HIERARCHY = [
    # (bone_name, parent_name)
    ("ValveBiped.Bip01_Spine4", ""),
    ("ValveBiped.Bip01_L_Clavicle", "ValveBiped.Bip01_Spine4"),
    ("ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Clavicle"),
    ("ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_UpperArm"),
    ("ValveBiped.Bip01_L_Hand", "ValveBiped.Bip01_L_Forearm"),
    ("ValveBiped.Bip01_L_Finger0", "ValveBiped.Bip01_L_Hand"),
    ("ValveBiped.Bip01_L_Finger01", "ValveBiped.Bip01_L_Finger0"),
    ("ValveBiped.Bip01_L_Finger02", "ValveBiped.Bip01_L_Finger01"),
    ("ValveBiped.Bip01_L_Finger1", "ValveBiped.Bip01_L_Hand"),
    ("ValveBiped.Bip01_L_Finger11", "ValveBiped.Bip01_L_Finger1"),
    ("ValveBiped.Bip01_L_Finger12", "ValveBiped.Bip01_L_Finger11"),
    ("ValveBiped.Bip01_L_Finger2", "ValveBiped.Bip01_L_Hand"),
    ("ValveBiped.Bip01_L_Finger21", "ValveBiped.Bip01_L_Finger2"),
    ("ValveBiped.Bip01_L_Finger22", "ValveBiped.Bip01_L_Finger21"),
    ("ValveBiped.Bip01_L_Finger3", "ValveBiped.Bip01_L_Hand"),
    ("ValveBiped.Bip01_L_Finger31", "ValveBiped.Bip01_L_Finger3"),
    ("ValveBiped.Bip01_L_Finger32", "ValveBiped.Bip01_L_Finger31"),
    ("ValveBiped.Bip01_L_Finger4", "ValveBiped.Bip01_L_Hand"),
    ("ValveBiped.Bip01_L_Finger41", "ValveBiped.Bip01_L_Finger4"),
    ("ValveBiped.Bip01_L_Finger42", "ValveBiped.Bip01_L_Finger41"),
    ("ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_Spine4"),
    ("ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_R_Clavicle"),
    ("ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_UpperArm"),
    ("ValveBiped.Bip01_R_Hand", "ValveBiped.Bip01_R_Forearm"),
    ("ValveBiped.Bip01_R_Finger0", "ValveBiped.Bip01_R_Hand"),
    ("ValveBiped.Bip01_R_Finger01", "ValveBiped.Bip01_R_Finger0"),
    ("ValveBiped.Bip01_R_Finger02", "ValveBiped.Bip01_R_Finger01"),
    ("ValveBiped.Bip01_R_Finger1", "ValveBiped.Bip01_R_Hand"),
    ("ValveBiped.Bip01_R_Finger11", "ValveBiped.Bip01_R_Finger1"),
    ("ValveBiped.Bip01_R_Finger12", "ValveBiped.Bip01_R_Finger11"),
    ("ValveBiped.Bip01_R_Finger2", "ValveBiped.Bip01_R_Hand"),
    ("ValveBiped.Bip01_R_Finger21", "ValveBiped.Bip01_R_Finger2"),
    ("ValveBiped.Bip01_R_Finger22", "ValveBiped.Bip01_R_Finger21"),
    ("ValveBiped.Bip01_R_Finger3", "ValveBiped.Bip01_R_Hand"),
    ("ValveBiped.Bip01_R_Finger31", "ValveBiped.Bip01_R_Finger3"),
    ("ValveBiped.Bip01_R_Finger32", "ValveBiped.Bip01_R_Finger31"),
    ("ValveBiped.Bip01_R_Finger4", "ValveBiped.Bip01_R_Hand"),
    ("ValveBiped.Bip01_R_Finger41", "ValveBiped.Bip01_R_Finger4"),
    ("ValveBiped.Bip01_R_Finger42", "ValveBiped.Bip01_R_Finger41"),
]


def is_hand_bone(name):
    for bone_name, _ in HAND_BONE_HIERARCHY:
        if name == bone_name:
            return True
    return False


def is_bf3_procedural_bone(name):
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE)
                or re.match(r'^[lr]-(upperarm|forearm|wrist)$', name, re.IGNORECASE)
                or re.match(r'^[lr]wrist$', name, re.IGNORECASE)
                or re.match(r'^[lr]-rist$', name, re.IGNORECASE))


def is_non_essential_bone(name):
    """Check if a bone is non-essential and can be removed to save bone count.
    ForeTwist bones are not needed for c_arms bonemerge.
    IK helper bones are not needed.
    """
    # ForeTwist bones (not in c_arms_citizen, not needed for bonemerge)
    if re.match(r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$', name, re.IGNORECASE):
        return True
    # IK helper bones
    if re.match(r'^ik_hand', name, re.IGNORECASE):
        return True
    # b_wpn_* bones (weapon-internal helper bones)
    if re.match(r'^b_wpn_', name, re.IGNORECASE):
        return True
    return False


def rename_bones_in_text(content, bone_map):
    for old, new in sorted(bone_map.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        if is_bf3_procedural_bone(old):
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content


# Matrix operations using numpy
def euler_to_matrix(rx, ry, rz):
    """Convert RadianEuler (rx, ry, rz) to 4x4 matrix.
    SMD uses RadianEuler, which studiomdl converts to QAngle as (y, z, x).
    """
    # studiomdl's AngleMatrix(RadianEuler) does:
    # QAngle quakeEuler(RAD2DEG(angles.y), RAD2DEG(angles.z), RAD2DEG(angles.x));
    # So RadianEuler(rx, ry, rz) -> QAngle(ry, rz, rx)
    # QAngle is (pitch, yaw, roll) = (ry, rz, rx)
    pitch, yaw, roll = ry, rz, rx
    cp, sp = math.cos(pitch), math.sin(pitch)
    cy, sy = math.cos(yaw), math.sin(yaw)
    cr, sr = math.cos(roll), math.sin(roll)
    
    # Source engine AngleMatrix builds: Ry * Rp * Rr (yaw * pitch * roll)
    # Actually, looking at the code more carefully:
    # sr = sin(roll), sp = sin(pitch), sy = sin(yaw)
    # The matrix is built as:
    m = np.eye(4)
    m[0,0] = cp * cy
    m[0,1] = sr * sp * cy - cr * sy
    m[0,2] = cr * sp * cy + sr * sy
    m[1,0] = cp * sy
    m[1,1] = sr * sp * sy + cr * cy
    m[1,2] = cr * sp * sy - sr * cy
    m[2,0] = -sp
    m[2,1] = sr * cp
    m[2,2] = cr * cp
    return m


def matrix_to_euler(m):
    """Convert 4x4 matrix back to RadianEuler (rx, ry, rz).
    Inverse of euler_to_matrix.
    """
    # Extract pitch, yaw, roll from the matrix
    sp = -m[2, 0]
    if abs(sp) > 0.99999:
        # Gimbal lock
        pitch = math.asin(max(-1.0, min(1.0, sp)))
        yaw = math.atan2(-m[0, 1], m[1, 1])
        roll = 0
    else:
        pitch = math.asin(sp)
        yaw = math.atan2(m[1, 0], m[0, 0])
        roll = math.atan2(m[2, 1], m[2, 2])
    
    # Convert QAngle(pitch, yaw, roll) back to RadianEuler(rx, ry, rz)
    # QAngle(ry, rz, rx) = (pitch, yaw, roll)
    # So: ry = pitch, rz = yaw, rx = roll
    return roll, pitch, yaw  # (rx, ry, rz) in RadianEuler


def build_local_matrix(pos, rot):
    """Build a 4x4 local transform matrix from position and rotation (RadianEuler)."""
    m = euler_to_matrix(*rot)
    m[0, 3] = pos[0]
    m[1, 3] = pos[1]
    m[2, 3] = pos[2]
    return m


def matrix_inverse(m):
    """Invert a 4x4 matrix."""
    return np.linalg.inv(m)


def matrix_multiply(a, b):
    """Multiply two 4x4 matrices."""
    return np.matmul(a, b)


def parse_smd_bones(smd_path):
    """Parse an SMD file and return:
    - bone_id_to_name: {id: name}
    - bone_parents: {id: parent_id}
    - bind_pose: {name: (px, py, pz, rx, ry, rz)} at time 0
    """
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    bone_id_to_name = {}
    bone_parents = {}
    
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
                bone_id_to_name[bid] = name
                bone_parents[bid] = pid
    
    # Parse skeleton section (time 0 only)
    bind_pose = {}
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
                if name:
                    bind_pose[name] = (px, py, pz, rx, ry, rz)
    
    return bone_id_to_name, bone_parents, bind_pose


def compute_world_transforms(bone_id_to_name, bone_parents, bind_pose):
    """Compute world-space transforms for all bones."""
    world_transforms = {}
    
    def get_world(name):
        if name in world_transforms:
            return world_transforms[name]
        
        # Find the bone ID
        bid = None
        for id, n in bone_id_to_name.items():
            if n == name:
                bid = id
                break
        if bid is None:
            return np.eye(4)
        
        parent_id = bone_parents.get(bid, -1)
        parent_name = bone_id_to_name.get(parent_id, '') if parent_id >= 0 else ''
        
        local = build_local_matrix(
            (bind_pose[name][0], bind_pose[name][1], bind_pose[name][2]),
            (bind_pose[name][3], bind_pose[name][4], bind_pose[name][5])
        )
        
        if parent_name and parent_name in bind_pose:
            parent_world = get_world(parent_name)
            world = matrix_multiply(parent_world, local)
        else:
            world = local
        
        world_transforms[name] = world
        return world
    
    for name in bind_pose:
        get_world(name)
    
    return world_transforms


def parse_c_arms_reference():
    """Parse c_arms_citizen.smd to get the reference bone transforms."""
    bone_id_to_name, bone_parents, bind_pose = parse_smd_bones(C_ARMS_SMD)
    world_transforms = compute_world_transforms(bone_id_to_name, bone_parents, bind_pose)
    return bind_pose, world_transforms


def remove_bf3_procedural_bones_from_smd(smd_path):
    """Remove BF3 procedural bones from an SMD's nodes and skeleton sections."""
    with open(smd_path, 'r', errors='ignore') as f:
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
    
    bones_to_remove = set()
    for bid, name in bone_id_to_name.items():
        if is_bf3_procedural_bone(name) or is_non_essential_bone(name):
            bones_to_remove.add(bid)
    
    if not bones_to_remove:
        return 0
    
    new_lines = []
    in_nodes = False
    in_skeleton = False
    changes = 0
    
    for line in lines:
        s = line.strip()
        
        if s == 'nodes':
            in_nodes = True
            new_lines.append(line)
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            new_lines.append(line)
            continue
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                if bid in bones_to_remove:
                    changes += 1
                    continue
            new_lines.append(line)
            continue
        
        if s == 'skeleton':
            in_skeleton = True
            new_lines.append(line)
            continue
        if s == 'end' and in_skeleton:
            in_skeleton = False
            new_lines.append(line)
            continue
        if in_skeleton:
            m = re.match(r'^(\s*)(\d+)\s+', s)
            if m:
                bid = int(m.group(2))
                if bid in bones_to_remove:
                    changes += 1
                    continue
        new_lines.append(line)
    
    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


def strip_hand_triangles_from_smd(smd_path):
    """Strip v_hands/sleeve_diffuse triangle blocks from an SMD file."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    
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
    triangles_stripped = 0
    
    lines = triangles_section.split('\n')
    for line in lines:
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
    
    if current_material is not None and current_vertices:
        if current_material.lower() not in HAND_MATERIALS:
            new_triangles.append(current_material)
            new_triangles.extend(current_vertices)
        else:
            triangles_stripped += 1
    
    new_triangles_str = '\n'.join(new_triangles)
    if new_triangles_str:
        new_triangles_str += '\n'
    
    if triangles_stripped > 0:
        new_content = content[:triangles_start] + new_triangles_str + content[triangles_end:]
        with open(smd_path, 'w') as f:
            f.write(new_content)
    return triangles_stripped


def convert_weapon(weapon, c_arms_bind_pose, c_arms_world):
    """Convert a weapon using the hybrid approach."""
    src_dir = DECOMPILE_DIR / weapon
    dst_dir = COMPILE_DIR / weapon / "source"
    
    if not src_dir.exists():
        print(f"  SKIP {weapon}: no decompile folder")
        return False
    
    if dst_dir.exists():
        shutil.rmtree(dst_dir)
    dst_dir.mkdir(parents=True)
    
    for item in src_dir.iterdir():
        if item.is_dir():
            shutil.copytree(item, dst_dir / item.name)
        else:
            shutil.copy2(item, dst_dir)
    
    qc_path = dst_dir / f"{weapon}.qc"
    if not qc_path.exists():
        print(f"  SKIP {weapon}: no QC file")
        return False
    
    print(f"\n  {weapon}:")
    
    # Step 1: Rename BF3 bones to ValveBiped names
    bone_map = build_bone_map()
    
    # Add weapon-specific finger mappings
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
                    if f.endswith(".qc"):
                        content = re.sub(r'\$modelname\s+"[^"]*"',
                                        f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
                        content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
                    with open(src_path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    print(f"    WARN: {f}: {e}")
    
    print(f"    Bones renamed")
    
    # Step 1b: Remove BF3 procedural bones from all SMDs (to stay under 128 bone limit)
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                remove_bf3_procedural_bones_from_smd(os.path.join(root, f))
    anims_dir = dst_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in anims_dir.glob("*.smd"):
            remove_bf3_procedural_bones_from_smd(smd)
    print(f"    BF3 procedural bones removed")
    
    # Step 2: Parse the weapon's bind pose to compute world transforms
    # Use the first SMD that has hand bones
    ref_smd = None
    for smd_name in ['default.smd', 'hands.smd', f'{weapon}.smd']:
        candidate = dst_dir / smd_name
        if candidate.exists():
            ref_smd = candidate
            break
    if not ref_smd:
        for smd in dst_dir.glob("*.smd"):
            ref_smd = smd
            break
    
    if not ref_smd:
        print(f"    ERROR: no reference SMD found")
        return False
    
    bone_id_to_name, bone_parents, weapon_bind_pose = parse_smd_bones(ref_smd)
    weapon_world = compute_world_transforms(bone_id_to_name, bone_parents, weapon_bind_pose)
    
    print(f"    Parsed bind pose from {ref_smd.name}: {len(weapon_bind_pose)} bones")
    
    # Step 3: Compute the local transforms for new ValveBiped bones
    # For each hand bone, the new bone is a child of the corresponding BF3 bone (renamed to anim_*)
    # But since we DON'T rename the BF3 bones, we need to handle this differently.
    #
    # Actually, the BF3 bones ARE named ValveBiped.Bip01_* (after renaming).
    # We can't add NEW bones with the same name.
    # So we need to RENAME the existing bones to something else first.
    
    # Step 3a: Rename existing ValveBiped hand bones to "anim_*"
    anim_rename_map = {}
    for name in weapon_bind_pose:
        if is_hand_bone(name):
            anim_rename_map[name] = f"anim_{name}"
    
    # Apply the anim_ renaming to all SMD and QC files
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            src_path = os.path.join(root, f)
            if f.endswith((".smd", ".qc", ".qci")):
                try:
                    with open(src_path, "r", errors="ignore") as fh:
                        content = fh.read()
                    for old, new in sorted(anim_rename_map.items(), key=lambda x: len(x[0]), reverse=True):
                        content = content.replace(f'"{old}"', f'"{new}"')
                    with open(src_path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    print(f"    WARN: {f}: {e}")
    
    print(f"    Renamed {len(anim_rename_map)} hand bones to anim_*")
    
    # Step 3b: Compute new bone local transforms
    # new_bone_local = inverse(anim_bone_world) * c_arms_bone_world
    # Note: weapon_world still has ValveBiped names (computed before the anim_ renaming)
    new_bone_locals = {}
    for bone_name, parent_name in HAND_BONE_HIERARCHY:
        if bone_name not in c_arms_world:
            continue
        
        # The weapon's bone is named ValveBiped.Bip01_L_Clavicle (before anim_ renaming)
        # After anim_ renaming in the SMD files, it becomes anim_ValveBiped.Bip01_L_Clavicle
        # But weapon_world still uses the original ValveBiped name
        if bone_name in weapon_world:
            anim_world = weapon_world[bone_name]
        else:
            # The weapon doesn't have this bone - use identity for Spine4
            if bone_name == "ValveBiped.Bip01_Spine4":
                # Spine4: root bone at origin with c_arms_citizen's rotation
                c_arms_rot = (c_arms_bind_pose[bone_name][3], c_arms_bind_pose[bone_name][4], c_arms_bind_pose[bone_name][5])
                m = euler_to_matrix(*c_arms_rot)
                m[0, 3] = 0
                m[1, 3] = 0
                m[2, 3] = 0
                new_bone_locals[bone_name] = m
            continue
        
        c_arms_world_mat = c_arms_world[bone_name]
        
        # new_bone_local = inverse(anim_world) * c_arms_world
        local = matrix_multiply(matrix_inverse(anim_world), c_arms_world_mat)
        new_bone_locals[bone_name] = local
    
    print(f"    Computed {len(new_bone_locals)} new bone local transforms")
    
    # Step 3c: Convert local transforms back to (pos, rot) for SMD format
    new_bone_data = {}
    for bone_name, local_mat in new_bone_locals.items():
        px = local_mat[0, 3]
        py = local_mat[1, 3]
        pz = local_mat[2, 3]
        rx, ry, rz = matrix_to_euler(local_mat)
        new_bone_data[bone_name] = (px, py, pz, rx, ry, rz)
    
    # Step 4: Add new ValveBiped bones to all SMD files
    # For each SMD, we need to:
    # 1. Add new bones to the nodes section
    # 2. Add new bone entries to the skeleton section (at each time frame)
    # The new bones are children of the anim_* bones (or Spine4 is a root)
    
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                smd_path = os.path.join(root, f)
                add_new_bones_to_smd(smd_path, new_bone_data, weapon_world)
    
    anims_dir = dst_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in anims_dir.glob("*.smd"):
            add_new_bones_to_smd(smd, new_bone_data, weapon_world)
    
    print(f"    Added new ValveBiped bones to SMDs")
    
    # Step 5: Update QC
    # - Add $definebone for new ValveBiped bones (as children of anim_* bones)
    # - Add $bonemerge for new ValveBiped bones
    # - Remove v_hands/sleeve_diffuse from $texturegroup
    # - Remove hands/ from $cdmaterials
    # - Remove hands bodygroup
    update_qc_hybrid(qc_path, new_bone_data)
    print(f"    QC updated")
    
    # Step 6: Strip v_hands mesh from all SMDs
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                strip_hand_triangles_from_smd(os.path.join(root, f))
    print(f"    v_hands mesh stripped")
    
    return True


def add_new_bones_to_smd(smd_path, new_bone_data, weapon_world):
    """Add new ValveBiped bones to an SMD file's nodes and skeleton sections."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    # Parse existing nodes to find bone IDs
    bone_id_to_name = {}
    bone_name_to_id = {}
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
                bone_name_to_id[name] = bid
    
    # Find max bone ID
    max_bone_id = max(bone_id_to_name.keys()) if bone_id_to_name else 0
    next_bone_id = max_bone_id + 1
    
    # Assign bone IDs for new bones
    new_bone_ids = {}
    for bone_name, _ in HAND_BONE_HIERARCHY:
        if bone_name in new_bone_data:
            new_bone_ids[bone_name] = next_bone_id
            next_bone_id += 1
    
    if not new_bone_ids:
        return 0
    
    # Process the file
    new_lines = []
    in_nodes = False
    in_skeleton = False
    nodes_added = False
    changes = 0
    
    for line in lines:
        s = line.strip()
        
        # Handle nodes section - add new bones before 'end'
        if s == 'nodes':
            in_nodes = True
            new_lines.append(line)
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            if not nodes_added:
                for bone_name, parent_name in HAND_BONE_HIERARCHY:
                    if bone_name in new_bone_ids:
                        bid = new_bone_ids[bone_name]
                        if parent_name and parent_name in new_bone_ids:
                            pid = new_bone_ids[parent_name]
                        elif bone_name == "ValveBiped.Bip01_Spine4":
                            pid = -1  # Spine4 is root
                        else:
                            # Parent is an anim_* bone
                            anim_parent = f"anim_{parent_name}"
                            pid = bone_name_to_id.get(anim_parent, -1)
                        new_lines.append(f'  {bid} "{bone_name}" {pid}\n')
                        changes += 1
                nodes_added = True
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
        
        # In skeleton section - after each "time X" line, add new bone entries
        if s.startswith('time'):
            new_lines.append(line)
            # Add new bone entries for this frame
            for bone_name, parent_name in HAND_BONE_HIERARCHY:
                if bone_name in new_bone_ids and bone_name in new_bone_data:
                    bid = new_bone_ids[bone_name]
                    px, py, pz, rx, ry, rz = new_bone_data[bone_name]
                    new_lines.append(f'  {bid} {px:.6f} {py:.6f} {pz:.6f} {rx:.6f} {ry:.6f} {rz:.6f}\n')
                    changes += 1
            continue
        
        new_lines.append(line)
    
    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


def update_qc_hybrid(qc_path, new_bone_data):
    """Update QC for hybrid approach."""
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()
    
    original = content
    
    # Remove BF3 procedural bone AND non-essential bone $definebone lines (to stay under 128 bone limit)
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'^\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
        if m:
            bone_name = m.group(1)
            if is_bf3_procedural_bone(bone_name):
                continue  # Skip this bone
            if is_non_essential_bone(bone_name):
                continue  # Skip this bone
        new_lines.append(line)
    content = '\n'.join(new_lines)
    
    # Remove $attachment lines that reference removed (non-essential) bones
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'^\$attachment\s+"[^"]*"\s+"([^"]+)"', line, re.IGNORECASE)
        if m:
            attach_bone = m.group(1)
            if is_non_essential_bone(attach_bone) or is_bf3_procedural_bone(attach_bone):
                continue  # Skip this attachment
        new_lines.append(line)
    content = '\n'.join(new_lines)

    # Remove v_hands/sleeve_diffuse from $texturegroup
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)
    
    # Remove hands/ cdmaterials
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    
    # Remove hands bodygroup
    content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                     '// REMOVED: hands bodygroup (c_hands provides arm mesh)',
                     content, flags=re.IGNORECASE | re.DOTALL)
    
    # Add $definebone for new ValveBiped bones
    definebone_lines = []
    for bone_name, parent_name in HAND_BONE_HIERARCHY:
        if bone_name in new_bone_data:
            px, py, pz, rx, ry, rz = new_bone_data[bone_name]
            # Convert radians to degrees for QC
            rx_deg = math.degrees(rx)
            ry_deg = math.degrees(ry)
            rz_deg = math.degrees(rz)
            
            if bone_name == "ValveBiped.Bip01_Spine4":
                qc_parent = ""
            elif parent_name in new_bone_data:
                qc_parent = parent_name
            else:
                qc_parent = f"anim_{parent_name}"
            
            definebone_lines.append(
                f'$definebone "{bone_name}" "{qc_parent}" '
                f'{px:.6f} {py:.6f} {pz:.6f} '
                f'{rx_deg:.6f} {ry_deg:.6f} {rz_deg:.6f} '
                f'0 0 0 0 0 0'
            )
    
    # Add $bonemerge for new ValveBiped bones
    bonemerge_lines = []
    for bone_name, _ in HAND_BONE_HIERARCHY:
        if bone_name in new_bone_data:
            bonemerge_lines.append(f'$BoneMerge "{bone_name}"')
    
    # Insert after the last $definebone line
    if definebone_lines or bonemerge_lines:
        insert_block = '\n' + '\n'.join(definebone_lines) + '\n' + '\n'.join(bonemerge_lines) + '\n'
        lines = content.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, insert_block)
            content = '\n'.join(lines)
        else:
            content += insert_block
    
    if content != original:
        with open(qc_path, 'w') as f:
            f.write(content)
    return True


def main():
    print("=" * 70)
    print("hybrid_c_hands.py — Ghosts-style hybrid bone approach")
    print("=" * 70)
    
    # Parse c_arms_citizen reference
    print("\nParsing c_arms_citizen.smd reference...")
    c_arms_bind_pose, c_arms_world = parse_c_arms_reference()
    print(f"  Found {len(c_arms_bind_pose)} bones, {len(c_arms_world)} world transforms")
    
    # Get list of weapons
    weapons = sorted([d.name for d in DECOMPILE_DIR.iterdir()
                      if d.is_dir() and not d.name.startswith('.')
                      and d.name not in {'ghosts_m27_lmg', 'm416_prev_compiled', 'm416_check_bonemerge',
                                          'm416_verify', 'scotia_c_arms_ref', 'test_minimal_check',
                                          'm416_check', '870mcs_check', 'check_m416', 'check_870mcs',
                                          'check_famas', 'check_g36c', 'check_g3a3', 'check_l85a2',
                                          'check_scarh', 'check_sv98', 'check_mp412', 'check_m9', 'check_acwr'}])
    print(f"\nFound {len(weapons)} weapons")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        try:
            if convert_weapon(weapon, c_arms_bind_pose, c_arms_world):
                success += 1
        except Exception as e:
            print(f"  FAIL: {e}")
            import traceback
            traceback.print_exc()
    
    print(f"\n{'=' * 70}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'=' * 70}")


if __name__ == "__main__":
    main()
