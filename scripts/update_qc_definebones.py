#!/usr/bin/env python3
"""
update_qc_definebones.py — Update $definebone lines in QC to match SMD bind pose.

After align_bone_rolls.py changes the bone rotations in SMD files, the QC's $definebone
lines need to be updated to match. Otherwise studiomdl uses the old rotations from QC.
"""
import re
import os
import sys
from pathlib import Path

COMPILE_DIR = Path("/home/z/my-project/compile")

# Bones whose $definebone should match the c_arms_citizen reference
ARM_BONES = [
    "ValveBiped.Bip01_Spine4",
    "ValveBiped.Bip01_L_Clavicle", "ValveBiped.Bip01_L_UpperArm",
    "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand",
    "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_UpperArm",
    "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand",
    "ValveBiped.Bip01_L_Finger0", "ValveBiped.Bip01_L_Finger01", "ValveBiped.Bip01_L_Finger02",
    "ValveBiped.Bip01_L_Finger1", "ValveBiped.Bip01_L_Finger11", "ValveBiped.Bip01_L_Finger12",
    "ValveBiped.Bip01_L_Finger2", "ValveBiped.Bip01_L_Finger21", "ValveBiped.Bip01_L_Finger22",
    "ValveBiped.Bip01_L_Finger3", "ValveBiped.Bip01_L_Finger31", "ValveBiped.Bip01_L_Finger32",
    "ValveBiped.Bip01_L_Finger4", "ValveBiped.Bip01_L_Finger41", "ValveBiped.Bip01_L_Finger42",
    "ValveBiped.Bip01_R_Finger0", "ValveBiped.Bip01_R_Finger01", "ValveBiped.Bip01_R_Finger02",
    "ValveBiped.Bip01_R_Finger1", "ValveBiped.Bip01_R_Finger11", "ValveBiped.Bip01_R_Finger12",
    "ValveBiped.Bip01_R_Finger2", "ValveBiped.Bip01_R_Finger21", "ValveBiped.Bip01_R_Finger22",
    "ValveBiped.Bip01_R_Finger3", "ValveBiped.Bip01_R_Finger31", "ValveBiped.Bip01_R_Finger32",
    "ValveBiped.Bip01_R_Finger4", "ValveBiped.Bip01_R_Finger41", "ValveBiped.Bip01_R_Finger42",
]


def parse_smd_bind_pose(smd_path):
    """Parse SMD to get bone rotations at time 0 (bind pose)."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    nodes = {}
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
                nodes[int(m.group(1))] = m.group(2)
    
    # Parse skeleton time 0
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
                    name = nodes.get(bid, "")
                    x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                    rx, ry, rz = float(parts[4]), float(parts[5]), float(parts[6])
                    bind_pose[name] = (x, y, z, rx, ry, rz)
                except:
                    pass
    return bind_pose


def update_qc(weapon):
    """Update $definebone lines in QC to match SMD bind pose."""
    src_dir = COMPILE_DIR / weapon / "source"
    qc_path = src_dir / f"{weapon}.qc"
    if not qc_path.exists():
        return False
    
    # Find the first SMD referenced in QC
    with open(qc_path) as f:
        qc = f.read()
    
    # Get bind pose from the first SMD (reference SMD)
    m = re.search(r'studio\s+"([^"]+)"', qc)
    if not m:
        return False
    smd_path = src_dir / m.group(1)
    if not smd_path.exists():
        return False
    
    bind_pose = parse_smd_bind_pose(smd_path)
    
    # Update $definebone lines for arm bones
    changed = False
    for bone_name in ARM_BONES:
        if bone_name not in bind_pose:
            continue
        pos_rot = bind_pose[bone_name]
        # Match existing $definebone line and replace position/rotation
        # $definebone "bone_name" "parent" x y z rx ry rz 0 0 0 0 0 0
        pattern = re.compile(
            r'(\$definebone\s+"' + re.escape(bone_name) + r'"\s+"[^"]*"\s+)'
            r'[-\d.]+\s+[-\d.]+\s+[-\d.]+\s+[-\d.]+\s+[-\d.]+\s+[-\d.]+'
        )
        replacement = f'{pattern.group(1) if False else "\\1"}{pos_rot[0]:.6f} {pos_rot[1]:.6f} {pos_rot[2]:.6f} {pos_rot[3]:.6f} {pos_rot[4]:.6f} {pos_rot[5]:.6f}'
        new_qc, n = pattern.subn(
            lambda m: m.group(1) + f'{pos_rot[0]:.6f} {pos_rot[1]:.6f} {pos_rot[2]:.6f} {pos_rot[3]:.6f} {pos_rot[4]:.6f} {pos_rot[5]:.6f}',
            qc
        )
        if n > 0:
            qc = new_qc
            changed = True
    
    if changed:
        with open(qc_path, 'w') as f:
            f.write(qc)
    return changed


def main():
    print("Updating $definebone in QC files to match SMD bind pose...")
    weapons = sorted([d.name for d in COMPILE_DIR.iterdir()
                      if d.is_dir() and d.name != "Battlefield3"])
    
    for weapon in weapons:
        changed = update_qc(weapon)
        if changed:
            print(f"  Updated {weapon}")


if __name__ == "__main__":
    main()
