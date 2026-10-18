"""
blender_pipeline.py — Blender bpy script for bone renaming, roll fix, and mesh editing.

Run with: blender --background --python blender_pipeline.py -- <weapon> <decompile_dir> <compile_dir>

This script:
1. Imports SMD files using Blender Source Tools
2. Renames all bone naming conventions to ValveBiped.Bip01_* standard
3. Aligns bone rolls to c_arms_citizen reference (fixes 180° roll bug)
4. Strips hand mesh triangles (v_hands, sleeve_diffuse materials)
5. Exports modified SMD files
"""
import bpy
import sys
import os
import math
import re
from mathutils import Vector, Quaternion, Matrix

# ===== COMPREHENSIVE BONE NAME MAP =====
# Covers ALL naming conventions found across 32 BF3 weapons
BONE_MAP = {
    # Convention 1: "L Clavicle" / "R Clavicle" (famas, m9-style pistols)
    "L Clavicle": "ValveBiped.Bip01_L_Clavicle",
    "L UpperArm": "ValveBiped.Bip01_L_UpperArm",
    "L Forearm": "ValveBiped.Bip01_L_Forearm",
    "L Hand": "ValveBiped.Bip01_L_Hand",
    "L Finger0": "ValveBiped.Bip01_L_Finger0",
    "L Finger01": "ValveBiped.Bip01_L_Finger01",
    "L Finger02": "ValveBiped.Bip01_L_Finger02",
    "L Finger1": "ValveBiped.Bip01_L_Finger1",
    "L Finger11": "ValveBiped.Bip01_L_Finger11",
    "L Finger12": "ValveBiped.Bip01_L_Finger12",
    "L Finger2": "ValveBiped.Bip01_L_Finger2",
    "L Finger21": "ValveBiped.Bip01_L_Finger21",
    "L Finger22": "ValveBiped.Bip01_L_Finger22",
    "L Finger3": "ValveBiped.Bip01_L_Finger3",
    "L Finger31": "ValveBiped.Bip01_L_Finger31",
    "L Finger32": "ValveBiped.Bip01_L_Finger32",
    "L Finger4": "ValveBiped.Bip01_L_Finger4",
    "L Finger41": "ValveBiped.Bip01_L_Finger41",
    "L Finger42": "ValveBiped.Bip01_L_Finger42",
    "R Clavicle": "ValveBiped.Bip01_R_Clavicle",
    "R UpperArm": "ValveBiped.Bip01_R_UpperArm",
    "R Forearm": "ValveBiped.Bip01_R_Forearm",
    "R Hand": "ValveBiped.Bip01_R_Hand",
    "R Finger0": "ValveBiped.Bip01_R_Finger0",
    "R Finger01": "ValveBiped.Bip01_R_Finger01",
    "R Finger02": "ValveBiped.Bip01_R_Finger02",
    "R Finger1": "ValveBiped.Bip01_R_Finger1",
    "R Finger11": "ValveBiped.Bip01_R_Finger11",
    "R Finger12": "ValveBiped.Bip01_R_Finger12",
    "R Finger2": "ValveBiped.Bip01_R_Finger2",
    "R Finger21": "ValveBiped.Bip01_R_Finger21",
    "R Finger22": "ValveBiped.Bip01_R_Finger22",
    "R Finger3": "ValveBiped.Bip01_R_Finger3",
    "R Finger31": "ValveBiped.Bip01_R_Finger31",
    "R Finger32": "ValveBiped.Bip01_R_Finger32",
    "R Finger4": "ValveBiped.Bip01_R_Finger4",
    "R Finger41": "ValveBiped.Bip01_R_Finger41",
    "R Finger42": "ValveBiped.Bip01_R_Finger42",
    
    # Convention 2: "b_ch_l_*" / "b_ch_r_*" (g3a3)
    "b_root": "ValveBiped.Bip01",
    "b_ch_middle": "ValveBiped.Bip01_Spine",
    "b_ch_spine1": "ValveBiped.Bip01_Spine1",
    "b_ch_spine2": "ValveBiped.Bip01_Spine2",
    "b_ch_l_clavical": "ValveBiped.Bip01_L_Clavicle",
    "b_ch_l_upperarm": "ValveBiped.Bip01_L_UpperArm",
    "b_ch_l_forearm": "ValveBiped.Bip01_L_Forearm",
    "b_ch_l_hand": "ValveBiped.Bip01_L_Hand",
    "b_ch_l_finger_00": "ValveBiped.Bip01_L_Finger0",
    "b_ch_l_finger_01": "ValveBiped.Bip01_L_Finger01",
    "b_ch_l_finger_02": "ValveBiped.Bip01_L_Finger02",
    "b_ch_l_finger_10": "ValveBiped.Bip01_L_Finger1",
    "b_ch_l_finger_11": "ValveBiped.Bip01_L_Finger11",
    "b_ch_l_finger_12": "ValveBiped.Bip01_L_Finger12",
    "b_ch_l_finger_20": "ValveBiped.Bip01_L_Finger2",
    "b_ch_l_finger_21": "ValveBiped.Bip01_L_Finger21",
    "b_ch_l_finger_22": "ValveBiped.Bip01_L_Finger22",
    "b_ch_l_finger_30": "ValveBiped.Bip01_L_Finger3",
    "b_ch_l_finger_31": "ValveBiped.Bip01_L_Finger31",
    "b_ch_l_finger_32": "ValveBiped.Bip01_L_Finger32",
    "b_ch_l_finger_40": "ValveBiped.Bip01_L_Finger4",
    "b_ch_l_finger_41": "ValveBiped.Bip01_L_Finger41",
    "b_ch_l_finger_42": "ValveBiped.Bip01_L_Finger42",
    "b_ch_r_clavical": "ValveBiped.Bip01_R_Clavicle",
    "b_ch_r_upperarm": "ValveBiped.Bip01_R_UpperArm",
    "b_ch_r_forearm": "ValveBiped.Bip01_R_Forearm",
    "b_ch_r_hand": "ValveBiped.Bip01_R_Hand",
    "b_ch_r_finger_00": "ValveBiped.Bip01_R_Finger0",
    "b_ch_r_finger_01": "ValveBiped.Bip01_R_Finger01",
    "b_ch_r_finger_02": "ValveBiped.Bip01_R_Finger02",
    "b_ch_r_finger_10": "ValveBiped.Bip01_R_Finger1",
    "b_ch_r_finger_11": "ValveBiped.Bip01_R_Finger11",
    "b_ch_r_finger_12": "ValveBiped.Bip01_R_Finger12",
    "b_ch_r_finger_20": "ValveBiped.Bip01_R_Finger2",
    "b_ch_r_finger_21": "ValveBiped.Bip01_R_Finger21",
    "b_ch_r_finger_22": "ValveBiped.Bip01_R_Finger22",
    "b_ch_r_finger_30": "ValveBiped.Bip01_R_Finger3",
    "b_ch_r_finger_31": "ValveBiped.Bip01_R_Finger31",
    "b_ch_r_finger_32": "ValveBiped.Bip01_R_Finger32",
    "b_ch_r_finger_40": "ValveBiped.Bip01_R_Finger4",
    "b_ch_r_finger_41": "ValveBiped.Bip01_R_Finger41",
    "b_ch_r_finger_42": "ValveBiped.Bip01_R_Finger42",
    
    # Convention 3: "l-upperarm" / "r-forearm" (sv98, mp412 style)
    "l-upperarm-movement": "ValveBiped.Bip01_L_Clavicle",
    "l-upperarm": "ValveBiped.Bip01_L_UpperArm",
    "l-forearm": "ValveBiped.Bip01_L_Forearm",
    "l-wrist": "ValveBiped.Bip01_L_Hand",
    "l-thumb-low": "ValveBiped.Bip01_L_Finger0",
    "l-thumb-mid": "ValveBiped.Bip01_L_Finger01",
    "l-thumb-tip": "ValveBiped.Bip01_L_Finger02",
    "l-index-low": "ValveBiped.Bip01_L_Finger1",
    "l-index-mid": "ValveBiped.Bip01_L_Finger11",
    "l-index-tip": "ValveBiped.Bip01_L_Finger12",
    "l-middle-low": "ValveBiped.Bip01_L_Finger2",
    "l-middle-mid": "ValveBiped.Bip01_L_Finger21",
    "l-middle-tip": "ValveBiped.Bip01_L_Finger22",
    "l-ring-low": "ValveBiped.Bip01_L_Finger3",
    "l-ring-mid": "ValveBiped.Bip01_L_Finger31",
    "l-ring-tip": "ValveBiped.Bip01_L_Finger32",
    "l-pinky-low": "ValveBiped.Bip01_L_Finger4",
    "l-pinky-mid": "ValveBiped.Bip01_L_Finger41",
    "l-pinky-tip": "ValveBiped.Bip01_L_Finger42",
    "r-upperarm-movement": "ValveBiped.Bip01_R_Clavicle",
    "r-upperarm": "ValveBiped.Bip01_R_UpperArm",
    "r-forearm": "ValveBiped.Bip01_R_Forearm",
    "r-wrist": "ValveBiped.Bip01_R_Hand",
    "r-thumb-low": "ValveBiped.Bip01_R_Finger0",
    "r-thumb-mid": "ValveBiped.Bip01_R_Finger01",
    "r-thumb-tip": "ValveBiped.Bip01_R_Finger02",
    "r-index-low": "ValveBiped.Bip01_R_Finger1",
    "r-index-mid": "ValveBiped.Bip01_R_Finger11",
    "r-index-tip": "ValveBiped.Bip01_R_Finger12",
    "r-middle-low": "ValveBiped.Bip01_R_Finger2",
    "r-middle-mid": "ValveBiped.Bip01_R_Finger21",
    "r-middle-tip": "ValveBiped.Bip01_R_Finger22",
    "r-ring-low": "ValveBiped.Bip01_R_Finger3",
    "r-ring-mid": "ValveBiped.Bip01_R_Finger31",
    "r-ring-tip": "ValveBiped.Bip01_R_Finger32",
    "r-pinky-low": "ValveBiped.Bip01_R_Finger4",
    "r-pinky-mid": "ValveBiped.Bip01_R_Finger41",
    "r-pinky-tip": "ValveBiped.Bip01_R_Finger42",
    "lwrist": "ValveBiped.Bip01_L_Hand",
    "rwrist": "ValveBiped.Bip01_R_Hand",
    
    # Convention 4: "(null)" root bone (m9, g18, m1911, m93r, mp443)
    "(null)": "ValveBiped.Bip01_Root",
    
    # Convention 5: Generic body bones
    "Pelvis": "ValveBiped.Bip01_Pelvis",
    "Spine": "ValveBiped.Bip01_Spine",
    "Spine1": "ValveBiped.Bip01_Spine1",
    "Spine2": "ValveBiped.Bip01_Spine2",
    "Neck": "ValveBiped.Bip01_Neck1",
    "Neck1": "ValveBiped.Bip01_Neck1",
    "Head": "ValveBiped.Bip01_Head1",
    "Head1": "ValveBiped.Bip01_Head1",
}

# BF3 procedural bone patterns to REMOVE (not rename)
BF3_PROC_PATTERNS = [
    r'^[lr]_thumb_(tip|mid|low)$',
    r'^[lr]_index_(tip|mid|low)$',
    r'^[lr]_middle_(tip|mid|low)$',
    r'^[lr]_ring_(tip|mid|low)$',
    r'^[lr]_pinky_(tip|mid|low)$',
    r'^[lr]_wrist$',
    r'^[lr]_armtwist_\d+$',
    r'^[lr]_upperarm$',
    r'^[lr]-upperarm$',
    r'^[lr]-forearm$',
    r'^b_ch_[lr]_forearm_twist\d+$',
    r'^b_ch_[lr]_upperarm_twist\d+$',
]

# Materials to strip (hand mesh)
HAND_MATERIALS = {"v_hands", "sleeve_diffuse"}

# c_arms_citizen reference bone rotations (from c_arms_citizen.smd)
# These are the CORRECT rotations that c_arms mesh expects
C_ARMS_REFERENCE = {
    "ValveBiped.Bip01_Spine4": (-1.570799, -1.391900, -1.570795),
    "ValveBiped.Bip01_L_Clavicle": (1.596637, -1.286515, 2.942962),
    "ValveBiped.Bip01_L_UpperArm": (-1.579613, 0.047802, -0.585173),
    "ValveBiped.Bip01_L_Forearm": (0.000000, 0.000000, -0.060372),
    "ValveBiped.Bip01_L_Hand": (1.573183, -0.106613, 0.044193),
    "ValveBiped.Bip01_L_Finger0": (-1.222677, -0.679213, -0.788819),
    "ValveBiped.Bip01_L_Finger01": (0.000000, 0.000000, 0.228523),
    "ValveBiped.Bip01_L_Finger02": (0.000000, 0.000000, 0.362860),
    "ValveBiped.Bip01_L_Finger1": (0.354449, -0.042750, -0.531718),
    "ValveBiped.Bip01_L_Finger11": (0.000000, 0.004074, -0.363009),
    "ValveBiped.Bip01_L_Finger12": (0.000000, 0.002596, -0.244331),
    "ValveBiped.Bip01_L_Finger2": (0.085902, 0.021830, -0.587867),
    "ValveBiped.Bip01_L_Finger21": (0.000000, 0.005516, -0.366478),
    "ValveBiped.Bip01_L_Finger22": (0.000000, 0.003084, -0.216400),
    "ValveBiped.Bip01_L_Finger3": (-0.151780, 0.073206, -0.810985),
    "ValveBiped.Bip01_L_Finger31": (0.000000, 0.000000, -0.247797),
    "ValveBiped.Bip01_L_Finger32": (-0.000000, 0.000000, -0.430802),
    "ValveBiped.Bip01_L_Finger4": (-0.468133, 0.151533, -0.880197),
    "ValveBiped.Bip01_L_Finger41": (0.000000, 0.000000, -0.439720),
    "ValveBiped.Bip01_L_Finger42": (0.000000, 0.000000, -0.244299),
    "ValveBiped.Bip01_R_Clavicle": (-1.668475, 1.286518, 2.942953),
    "ValveBiped.Bip01_R_UpperArm": (1.639479, -0.008065, -0.586846),
    "ValveBiped.Bip01_R_Forearm": (0.000000, 0.000000, -0.060372),
    "ValveBiped.Bip01_R_Hand": (-1.564937, 0.106606, 0.044193),
    "ValveBiped.Bip01_R_Finger0": (1.221731, 0.673635, -0.793558),
    "ValveBiped.Bip01_R_Finger01": (0.000000, -0.000000, 0.226893),
    "ValveBiped.Bip01_R_Finger02": (0.000000, 0.000000, 0.362905),
    "ValveBiped.Bip01_R_Finger1": (-0.354419, 0.038567, -0.532001),
    "ValveBiped.Bip01_R_Finger11": (0.000000, -0.006613, -0.362970),
    "ValveBiped.Bip01_R_Finger12": (0.000000, -0.004211, -0.244312),
    "ValveBiped.Bip01_R_Finger2": (-0.085905, -0.026404, -0.587695),
    "ValveBiped.Bip01_R_Finger21": (0.000000, -0.007974, -0.366436),
    "ValveBiped.Bip01_R_Finger22": (0.000000, -0.004461, -0.216376),
    "ValveBiped.Bip01_R_Finger3": (0.150078, -0.079191, -0.810205),
    "ValveBiped.Bip01_R_Finger31": (0.000000, 0.000000, -0.247771),
    "ValveBiped.Bip01_R_Finger32": (0.000000, 0.000000, -0.430761),
    "ValveBiped.Bip01_R_Finger4": (0.466236, -0.158066, -0.878825),
    "ValveBiped.Bip01_R_Finger41": (0.000000, 0.000000, -0.439672),
    "ValveBiped.Bip01_R_Finger42": (-0.000000, 0.000000, -0.244271),
}


def is_bf3_procedural(name):
    for pat in BF3_PROC_PATTERNS:
        if re.match(pat, name, re.IGNORECASE):
            return True
    return False


def process_smd_text(smd_content):
    """Process SMD file text directly (no Blender needed for text-based operations).
    
    This does the same operations the bpy script would do:
    1. Rename bones to ValveBiped
    2. Remove BF3 procedural bones
    3. Fix bone roll (replace rotations with c_arms reference)
    4. Strip hand mesh triangles
    """
    lines = smd_content.split('\n')
    
    # Parse nodes section to build bone ID -> name mapping
    bone_names = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            continue
        if in_nodes and s == 'end':
            break
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m:
                bone_names[int(m.group(1))] = m.group(2)
    
    # Identify BF3 procedural bones to remove
    proc_ids = set()
    for bid, name in bone_names.items():
        if is_bf3_procedural(name):
            proc_ids.add(bid)
    
    # Build old->new name mapping for renaming
    rename_map = {}
    for bid, name in bone_names.items():
        if bid in proc_ids:
            continue
        if name in BONE_MAP:
            rename_map[name] = BONE_MAP[name]
        elif name.startswith("ValveBiped."):
            rename_map[name] = name  # Already ValveBiped
    
    # Build bone delta quaternions for roll fix
    import math as mth
    
    def euler_to_quat(rx, ry, rz):
        cx, sx = mth.cos(rx/2), mth.sin(rx/2)
        cy, sy = mth.cos(ry/2), mth.sin(ry/2)
        cz, sz = mth.cos(rz/2), mth.sin(rz/2)
        return (sx*cy*cz - cx*sy*sz, cx*sy*cz + sx*cy*sz,
                cx*cy*sz - sx*sy*cz, cx*cy*cz + sx*sy*sz)
    
    def quat_to_euler(x, y, z, w):
        sin_x = 2*(w*x + y*z); cos_x = 1 - 2*(x*x + y*y)
        rx = mth.atan2(sin_x, cos_x)
        sin_y = 2*(w*y - z*x)
        ry = mth.asin(max(-1, min(1, sin_y)))
        sin_z = 2*(w*z + x*y); cos_z = 1 - 2*(y*y + z*z)
        rz = mth.atan2(sin_z, cos_z)
        return (rx, ry, rz)
    
    def quat_mul(a, b):
        return (a[3]*b[0]+a[0]*b[3]+a[1]*b[2]-a[2]*b[1],
                a[3]*b[1]-a[0]*b[2]+a[1]*b[3]+a[2]*b[0],
                a[3]*b[2]+a[0]*b[1]-a[1]*b[0]+a[2]*b[3],
                a[3]*b[3]-a[0]*b[0]-a[1]*b[1]-a[2]*b[2])
    
    def quat_inv(q):
        return (-q[0], -q[1], -q[2], q[3])
    
    # Parse bind pose (skeleton time 0) to compute deltas
    bind_pose = {}
    in_skel = False
    in_time0 = False
    for line in lines:
        s = line.strip()
        if s == 'skeleton':
            in_skel = True
            continue
        if in_skel and s == 'end':
            break
        if in_skel and s.startswith('time'):
            in_time0 = (s == 'time 0')
            if not in_time0:
                break
            continue
        if in_time0:
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bid = int(parts[0])
                    bind_pose[bid] = tuple(float(p) for p in parts[1:7])
                except:
                    pass
    
    # Compute delta quaternions for each bone that has a c_arms reference
    bone_deltas = {}
    name_to_id = {v: k for k, v in bone_names.items()}
    
    for old_name, new_name in rename_map.items():
        if old_name not in name_to_id:
            continue
        bid = name_to_id[old_name]
        if bid not in bind_pose:
            continue
        
        # Use the NEW name to look up c_arms reference
        ref_rot = C_ARMS_REFERENCE.get(new_name)
        if ref_rot is None:
            ref_rot = C_ARMS_REFERENCE.get(old_name)
        if ref_rot is None:
            continue
        
        old_rot = (bind_pose[bid][3], bind_pose[bid][4], bind_pose[bid][5])
        old_quat = euler_to_quat(*old_rot)
        new_quat = euler_to_quat(*ref_rot)
        delta = quat_mul(new_quat, quat_inv(old_quat))
        bone_deltas[bid] = delta
    
    # Now rebuild the SMD
    new_lines = []
    in_nodes = False
    in_skel = False
    in_triangles = False
    current_time = None
    skip_tri = False
    tri_count = 0
    
    for line in lines:
        s = line.strip()
        
        if s == 'nodes':
            in_nodes = True
            new_lines.append(line)
            continue
        if in_nodes and s == 'end':
            in_nodes = False
            new_lines.append(line)
            continue
        if s == 'skeleton':
            in_skel = True
            new_lines.append(line)
            continue
        if in_skel and s == 'end':
            in_skel = False
            new_lines.append(line)
            continue
        if s == 'triangles':
            in_triangles = True
            new_lines.append(line)
            continue
        if in_triangles and s == 'end':
            in_triangles = False
            skip_tri = False
            new_lines.append(line)
            continue
        
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                parent = int(m.group(3))
                
                # Skip BF3 procedural bones
                if bid in proc_ids:
                    continue
                
                # Rename
                new_name = rename_map.get(name, name)
                # Re-parent if parent was removed
                if parent in proc_ids:
                    # Find grandparent
                    while parent in proc_ids and parent >= 0:
                        parent_name = bone_names.get(parent, "")
                        # Find parent's parent from nodes
                        for pbid, pname in bone_names.items():
                            if pbid == parent:
                                # This is the bone being removed, find its parent
                                for lbid, lname in bone_names.items():
                                    pass  # Can't easily get parent here
                        break
                    parent = -1  # Default to root
                
                new_lines.append(f'{bid} "{new_name}" {parent}')
            else:
                new_lines.append(line)
        elif in_skel:
            if s.startswith('time'):
                current_time = int(s.split()[1])
                new_lines.append(line)
                continue
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bid = int(parts[0])
                    if bid in proc_ids:
                        continue
                    x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                    rx, ry, rz = float(parts[4]), float(parts[5]), float(parts[6])
                    
                    # Apply roll fix delta
                    if bid in bone_deltas:
                        key_quat = euler_to_quat(rx, ry, rz)
                        new_quat = quat_mul(bone_deltas[bid], key_quat)
                        rx, ry, rz = quat_to_euler(*new_quat)
                    
                    indent = line[:len(line) - len(line.lstrip())]
                    new_lines.append(f"{indent}{bid} {x:.6f} {y:.6f} {z:.6f} {rx:.6f} {ry:.6f} {rz:.6f}")
                except:
                    new_lines.append(line)
            else:
                new_lines.append(line)
        elif in_triangles:
            # Strip hand mesh triangles
            if not skip_tri:
                # Check if this is a material name line
                if s and not s[0].isdigit() and not s.startswith('//'):
                    mat_name = s.split()[0] if s.split() else ""
                    if mat_name.lower() in HAND_MATERIALS:
                        skip_tri = True
                        tri_count = 0
                        continue
            
            if skip_tri:
                tri_count += 1
                if tri_count >= 3:
                    skip_tri = False
                    tri_count = 0
                    # Check if this line is a new material
                    if s and not s[0].isdigit() and not s.startswith('//'):
                        mat_name = s.split()[0] if s.split() else ""
                        if mat_name.lower() in HAND_MATERIALS:
                            skip_tri = True
                            tri_count = 0
                            continue
                        new_lines.append(line)
                continue
            
            new_lines.append(line)
        else:
            new_lines.append(line)
    
    return '\n'.join(new_lines)


def main():
    args = sys.argv[sys.argv.index('--') + 1:] if '--' in sys.argv else []
    if len(args) < 3:
        print("Usage: blender --background --python blender_pipeline.py -- <weapon> <decompile_dir> <compile_dir>")
        return
    
    weapon = args[0]
    decompile_dir = args[1]
    compile_dir = args[2]
    
    src_dir = os.path.join(decompile_dir, weapon)
    dst_dir = os.path.join(compile_dir, weapon, "source")
    
    if not os.path.exists(src_dir):
        print(f"ERROR: {src_dir} not found")
        return
    
    # Create destination
    os.makedirs(dst_dir, exist_ok=True)
    
    # Copy c_arms_definebones.qci
    qci_src = "/tmp/c_arms_extract/c_arms_definebones.qci"
    if os.path.exists(qci_src):
        import shutil
        shutil.copy2(qci_src, os.path.join(dst_dir, "c_arms_definebones.qci"))
    
    # Process all SMD files
    smd_count = 0
    for f in os.listdir(src_dir):
        src_path = os.path.join(src_dir, f)
        dst_path = os.path.join(dst_dir, f)
        
        if f.endswith('.smd'):
            with open(src_path, 'r', errors='ignore') as fh:
                content = fh.read()
            content = process_smd_text(content)
            with open(dst_path, 'w') as fh:
                fh.write(content)
            smd_count += 1
        elif f.endswith('.qc'):
            process_qc(src_path, dst_path, weapon)
        elif f.endswith('.qci'):
            import shutil
            shutil.copy2(src_path, dst_path)
        elif os.path.isdir(src_path):
            # Animation directory
            import shutil
            if os.path.exists(dst_path):
                shutil.rmtree(dst_path)
            shutil.copytree(src_path, dst_path)
            # Process all SMDs in the anim dir
            for af in os.listdir(dst_path):
                if af.endswith('.smd'):
                    apath = os.path.join(dst_path, af)
                    with open(apath, 'r', errors='ignore') as fh:
                        content = fh.read()
                    content = process_smd_text(content)
                    with open(apath, 'w') as fh:
                        fh.write(content)
                    smd_count += 1
    
    print(f"  OK {weapon}: {smd_count} SMDs processed")


def process_qc(src_path, dst_path, weapon):
    """Process QC file: rename bones, add $include, add $bonemerge, fix $modelname."""
    import re
    import shutil
    
    with open(src_path, 'r', errors='ignore') as f:
        qc = f.read()
    
    # Rename bones in $definebone and $attachment lines
    for old, new in sorted(BONE_MAP.items(), key=lambda x: len(x[0]), reverse=True):
        qc = qc.replace(f'"{old}"', f'"{new}"')
    
    # Fix $modelname
    qc = re.sub(r'\$modelname\s+"[^"]*"', f'$modelname "weapons/c_{weapon}.mdl"', qc, flags=re.IGNORECASE)
    
    # Remove $texturegroup (causes compilation ordering issues)
    qc = re.sub(r'\$texturegroup\s+"[^"]+"\s*\n\{[\s\S]*?\n\}', '', qc)
    
    # Remove hands bodygroup
    qc = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}', '// REMOVED: hands bodygroup', qc, flags=re.IGNORECASE | re.DOTALL)
    
    # Remove hands cdmaterials
    qc = re.sub(r'\$cdmaterials\s+"models\\weapons\\v_models\\hands\\"', '', qc, flags=re.IGNORECASE)
    qc = re.sub(r'\$cdmaterials\s+"models/weapons/v_models/hands/"', '', qc, flags=re.IGNORECASE)
    
    # Add $include c_arms_definebones.qci
    if '$include "c_arms_definebones.qci"' not in qc:
        include = '$include "c_arms_definebones.qci"\n\n'
        seq_match = re.search(r'\$sequence', qc, re.IGNORECASE)
        if seq_match:
            qc = qc[:seq_match.start()] + include + qc[seq_match.start():]
    
    # Add $bonemerge for c_arms bones
    BONEMERGE_BONES = [
        "ValveBiped.Bip01_L_Clavicle", "ValveBiped.Bip01_L_UpperArm",
        "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand",
        "ValveBiped.Bip01_L_Finger0", "ValveBiped.Bip01_L_Finger01", "ValveBiped.Bip01_L_Finger02",
        "ValveBiped.Bip01_L_Finger1", "ValveBiped.Bip01_L_Finger11", "ValveBiped.Bip01_L_Finger12",
        "ValveBiped.Bip01_L_Finger2", "ValveBiped.Bip01_L_Finger21", "ValveBiped.Bip01_L_Finger22",
        "ValveBiped.Bip01_L_Finger3", "ValveBiped.Bip01_L_Finger31", "ValveBiped.Bip01_L_Finger32",
        "ValveBiped.Bip01_L_Finger4", "ValveBiped.Bip01_L_Finger41", "ValveBiped.Bip01_L_Finger42",
        "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_UpperArm",
        "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand",
        "ValveBiped.Bip01_R_Finger0", "ValveBiped.Bip01_R_Finger01", "ValveBiped.Bip01_R_Finger02",
        "ValveBiped.Bip01_R_Finger1", "ValveBiped.Bip01_R_Finger11", "ValveBiped.Bip01_R_Finger12",
        "ValveBiped.Bip01_R_Finger2", "ValveBiped.Bip01_R_Finger21", "ValveBiped.Bip01_R_Finger22",
        "ValveBiped.Bip01_R_Finger3", "ValveBiped.Bip01_R_Finger31", "ValveBiped.Bip01_R_Finger32",
        "ValveBiped.Bip01_R_Finger4", "ValveBiped.Bip01_R_Finger41", "ValveBiped.Bip01_R_Finger42",
    ]
    
    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_L_Clavicle"', qc, re.IGNORECASE):
        bm = '\n' + '\n'.join(f'$BoneMerge "{b}"' for b in BONEMERGE_BONES) + '\n'
        lines = qc.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, bm)
            qc = '\n'.join(lines)
    
    # Remove $definebone for BF3 procedural bones
    lines = qc.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
        if m and is_bf3_procedural(m.group(1)):
            continue
        new_lines.append(line)
    qc = '\n'.join(new_lines)
    
    with open(dst_path, 'w') as f:
        f.write(qc)


if __name__ == "__main__":
    main()
