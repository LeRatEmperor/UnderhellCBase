#!/usr/bin/env python3
"""
align_bone_rolls.py — Align bone rotations to c_arms_citizen reference.

This fixes the "roll bug" where c_hands mesh appears twisted/inverted because
the weapon's bone rotations don't match the c_arms_citizen reference rotations.

The approach:
1. Parse c_arms_citizen.smd to get reference bone rotations (bind pose)
2. For each weapon SMD:
   - Replace hand bone rotations with c_arms_citizen's reference rotations
   - Keep bone positions unchanged (so weapon mesh stays in place)
   - Re-bake animation keyframes to preserve world-space motion

For animations, the re-baking formula is:
   new_keyframe_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot

This preserves the world-space orientation at each keyframe while changing
the local bone rotation to match c_arms_citizen.
"""
import math
import os
import re
import sys
from pathlib import Path

# Reference c_arms_citizen SMD
C_ARMS_SMD = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")
COMPILE_DIR = Path("/home/z/my-project/compile")

# Bones to align (all hand-related bones from c_arms_citizen)
ALIGN_BONES = [
    "ValveBiped.Bip01_Spine4",
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
    "ValveBiped.Bip01_L_Wrist", "ValveBiped.Bip01_L_Ulna",
    "ValveBiped.Bip01_R_Wrist", "ValveBiped.Bip01_R_Ulna",
    "ValveBiped.Bip01_Neck1", "ValveBiped.Bip01_Head1",
]


# ===== Quaternion math helpers =====
def euler_to_quat(rx, ry, rz):
    """Convert Euler angles (radians, XYZ order) to quaternion (x, y, z, w)."""
    cx, sx = math.cos(rx/2), math.sin(rx/2)
    cy, sy = math.cos(ry/2), math.sin(ry/2)
    cz, sz = math.cos(rz/2), math.sin(rz/2)
    # Source engine uses XYZ Euler order
    x = sx*cy*cz - cx*sy*sz
    y = cx*sy*cz + sx*cy*sz
    z = cx*cy*sz - sx*sy*cz
    w = cx*cy*cz + sx*sy*sz
    return (x, y, z, w)


def quat_to_euler(x, y, z, w):
    """Convert quaternion to Euler angles (radians, XYZ order)."""
    # Source engine uses XYZ Euler order
    # pitch (X)
    sin_x = 2 * (w*x + y*z)
    cos_x = 1 - 2 * (x*x + y*y)
    rx = math.atan2(sin_x, cos_x)
    # yaw (Y)
    sin_y = 2 * (w*y - z*x)
    if abs(sin_y) >= 1:
        ry = math.copysign(math.pi/2, sin_y)
    else:
        ry = math.asin(sin_y)
    # roll (Z)
    sin_z = 2 * (w*z + x*y)
    cos_z = 1 - 2 * (y*y + z*z)
    rz = math.atan2(sin_z, cos_z)
    return (rx, ry, rz)


def quat_multiply(a, b):
    """Multiply two quaternions a * b."""
    ax, ay, az, aw = a
    bx, by, bz, bw = b
    return (
        aw*bx + ax*bw + ay*bz - az*by,
        aw*by - ax*bz + ay*bw + az*bx,
        aw*bz + ax*by - ay*bx + az*bw,
        aw*bw - ax*bx - ay*by - az*bz,
    )


def quat_conjugate(q):
    """Conjugate of quaternion (inverse for unit quaternions)."""
    return (-q[0], -q[1], -q[2], q[3])


def quat_inverse(q):
    """Inverse of a quaternion (for unit quaternions, same as conjugate)."""
    return quat_conjugate(q)


# ===== SMD parsing helpers =====
def parse_smd_nodes(content):
    """Parse the 'nodes' section of an SMD. Returns {bone_id: bone_name}."""
    nodes = {}
    in_nodes = False
    for line in content.split('\n'):
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            continue
        if in_nodes and s == 'end':
            break
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m:
                nodes[int(m.group(1))] = m.group(2)
    return nodes


def parse_smd_skeleton(content):
    """Parse the 'skeleton' section. Returns {time: {bone_id: (x,y,z,rx,ry,rz)}}."""
    skeleton = {}
    in_skel = False
    current_time = None
    for line in content.split('\n'):
        s = line.strip()
        if s == 'skeleton':
            in_skel = True
            continue
        if in_skel and s == 'end':
            break
        if in_skel:
            if s.startswith('time'):
                current_time = int(s.split()[1])
                skeleton[current_time] = {}
                continue
            parts = s.split()
            if len(parts) >= 7 and current_time is not None:
                try:
                    bone_id = int(parts[0])
                    x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                    rx, ry, rz = float(parts[4]), float(parts[5]), float(parts[6])
                    skeleton[current_time][bone_id] = (x, y, z, rx, ry, rz)
                except (ValueError, IndexError):
                    pass
    return skeleton


def parse_c_arms_reference():
    """Parse c_arms_citizen.smd to get reference bone rotations at time 0."""
    with open(C_ARMS_SMD) as f:
        content = f.read()
    nodes = parse_smd_nodes(content)
    skeleton = parse_smd_skeleton(content)
    
    # Get time 0 (bind pose)
    bind_pose = skeleton.get(0, {})
    
    # Map bone_name -> (pos, rot)
    ref = {}
    for bone_id, data in bind_pose.items():
        bone_name = nodes.get(bone_id)
        if bone_name:
            ref[bone_name] = {
                'pos': (data[0], data[1], data[2]),
                'rot': (data[3], data[4], data[5]),
            }
    return ref


def process_smd(smd_path, ref_bones, weapon_bind_pose):
    """Process an SMD file: replace bone rotations with c_arms reference.
    
    For reference SMDs (time 0 = bind pose):
      - Replace hand bone rotations with c_arms_citizen reference
      - Keep positions unchanged
    
    For animation SMDs (multiple time frames):
      - Re-bake keyframes using: new_rot = new_bind * inv(old_bind) * keyframe_rot
    """
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    
    nodes = parse_smd_nodes(content)
    skeleton = parse_smd_skeleton(content)
    
    # Build name -> id mapping
    name_to_id = {name: bid for bid, name in nodes.items()}
    
    # For each bone that has a reference rotation, compute the quaternion
    # of old_bind, new_bind (reference), and the delta
    # delta = new_bind * inv(old_bind)
    
    # old_bind = weapon's bind pose rotation (from time 0)
    # new_bind = c_arms reference rotation
    bind_time = skeleton.get(0, {})
    
    bone_deltas = {}  # bone_name -> delta quaternion
    
    for bone_name in ALIGN_BONES:
        if bone_name not in name_to_id:
            continue
        bone_id = name_to_id[bone_name]
        
        # Get old bind rotation from weapon
        if bone_id not in bind_time:
            continue
        old_data = bind_time[bone_id]
        old_rot = (old_data[3], old_data[4], old_data[5])
        old_quat = euler_to_quat(*old_rot)
        
        # Get new bind rotation from c_arms reference
        if bone_name not in ref_bones:
            continue
        new_rot = ref_bones[bone_name]['rot']
        new_quat = euler_to_quat(*new_rot)
        
        # Compute delta = new_bind * inv(old_bind)
        delta = quat_multiply(new_quat, quat_inverse(old_quat))
        bone_deltas[bone_name] = delta
    
    # Now process each keyframe
    new_skeleton = {}
    for time, bones in skeleton.items():
        new_skeleton[time] = {}
        for bone_id, data in bones.items():
            bone_name = nodes.get(bone_id, "")
            x, y, z = data[0], data[1], data[2]
            rx, ry, rz = data[3], data[4], data[5]
            
            if bone_name in bone_deltas:
                # Apply delta to this keyframe's rotation
                key_quat = euler_to_quat(rx, ry, rz)
                new_quat = quat_multiply(bone_deltas[bone_name], key_quat)
                nrx, nry, nrz = quat_to_euler(*new_quat)
                new_skeleton[time][bone_id] = (x, y, z, nrx, nry, nrz)
            else:
                # Keep as-is for non-hand bones
                new_skeleton[time][bone_id] = data
    
    # Rebuild the SMD
    lines = []
    in_section = None
    current_time = None
    for line in content.split('\n'):
        s = line.strip()
        if s == 'nodes':
            in_section = 'nodes'
            lines.append(line)
            continue
        elif s == 'skeleton':
            in_section = 'skeleton'
            lines.append(line)
            continue
        elif s == 'triangles':
            in_section = 'triangles'
            lines.append(line)
            continue
        elif s == 'end':
            in_section = None
            lines.append(line)
            continue
        
        if in_section == 'skeleton':
            if s.startswith('time'):
                current_time = int(s.split()[1])
                lines.append(line)
                continue
            # This is a bone data line
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bone_id = int(parts[0])
                    if current_time in new_skeleton and bone_id in new_skeleton[current_time]:
                        d = new_skeleton[current_time][bone_id]
                        # Preserve original indentation
                        indent = line[:len(line) - len(line.lstrip())]
                        lines.append(f"{indent}{bone_id} {d[0]:.6f} {d[1]:.6f} {d[2]:.6f} {d[3]:.6f} {d[4]:.6f} {d[5]:.6f}")
                        continue
                except (ValueError, IndexError):
                    pass
            lines.append(line)
        else:
            lines.append(line)
    
    new_content = '\n'.join(lines)
    if new_content != content:
        with open(smd_path, 'w') as f:
            f.write(new_content)
        return True
    return False


def process_weapon(weapon, ref_bones):
    """Process all SMD files for a weapon."""
    src_dir = COMPILE_DIR / weapon / "source"
    if not src_dir.exists():
        return False, "no source dir"
    
    changed = 0
    for smd_file in list(src_dir.glob("*.smd")):
        if process_smd(smd_file, ref_bones, None):
            changed += 1
    
    # Also process animation SMDs
    anims_dir = src_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd_file in anims_dir.glob("*.smd"):
            if process_smd(smd_file, ref_bones, None):
                changed += 1
    
    return True, f"updated {changed} SMD files"


def main():
    print("=" * 70)
    print("align_bone_rolls.py — Align bone rotations to c_arms_citizen reference")
    print("=" * 70)
    
    if not C_ARMS_SMD.exists():
        print(f"ERROR: c_arms_citizen.smd not found at {C_ARMS_SMD}")
        return 1
    
    print(f"\nParsing c_arms_citizen.smd reference...")
    ref_bones = parse_c_arms_reference()
    print(f"  Loaded {len(ref_bones)} reference bones")
    
    weapons = sorted([d.name for d in COMPILE_DIR.iterdir()
                      if d.is_dir() and d.name != "Battlefield3"])
    print(f"\nProcessing {len(weapons)} weapons...")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        ok, msg = process_weapon(weapon, ref_bones)
        status = "OK  " if ok else "FAIL"
        print(f"  [{i:2d}/{len(weapons)}] {status} {weapon}: {msg}")
        if ok:
            success += 1
    
    print(f"\n{'='*70}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'='*70}")
    return 0 if success == len(weapons) else 1


if __name__ == "__main__":
    sys.exit(main())
