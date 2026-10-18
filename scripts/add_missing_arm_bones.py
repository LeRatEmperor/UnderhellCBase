#!/usr/bin/env python3
"""
add_missing_arm_bones.py — Add missing L/R Clavicle, UpperArm, Forearm bones.

Some BF3 weapons (sv98, mp412) are missing the L_Clavicle/L_UpperArm/L_Forearm
and R_Clavicle/R_UpperArm/R_Forearm bone chains. They only have L_Hand and R_Hand.

This script adds the missing bones using c_arms_citizen reference positions/rotations.
"""
import os
import re
import sys
from pathlib import Path

COMPILE_DIR = Path("/home/z/my-project/compile")

# c_arms_citizen reference bone data (position, rotation) in LOCAL coordinates
C_ARMS_BONES = {
    "ValveBiped.Bip01_Spine4": {
        "pos": (0.000006, 3.336140, 58.352139),
        "rot": (-1.570799, -1.391900, -1.570795),
        "parent": None,
    },
    "ValveBiped.Bip01_L_Clavicle": {
        "pos": (2.033348, 1.000767, 1.937660),
        "rot": (1.596637, -1.286515, 2.942962),
        "parent": "ValveBiped.Bip01_Spine4",
    },
    "ValveBiped.Bip01_L_UpperArm": {
        "pos": (6.028141, 0.000000, 0.000000),
        "rot": (-1.579613, 0.047802, -0.585173),
        "parent": "ValveBiped.Bip01_L_Clavicle",
    },
    "ValveBiped.Bip01_L_Forearm": {
        "pos": (11.692558, -0.000000, 0.000000),
        "rot": (0.000000, 0.000000, -0.060372),
        "parent": "ValveBiped.Bip01_L_UpperArm",
    },
    "ValveBiped.Bip01_R_Clavicle": {
        "pos": (2.033360, 1.000772, -1.937610),
        "rot": (-1.668475, 1.286518, 2.942953),
        "parent": "ValveBiped.Bip01_Spine4",
    },
    "ValveBiped.Bip01_R_UpperArm": {
        "pos": (6.028143, 0.000004, 0.000000),
        "rot": (1.639479, -0.008065, -0.586846),
        "parent": "ValveBiped.Bip01_R_Clavicle",
    },
    "ValveBiped.Bip01_R_Forearm": {
        "pos": (11.692549, -0.000000, 0.000004),
        "rot": (0.000000, 0.000000, -0.060372),
        "parent": "ValveBiped.Bip01_R_UpperArm",
    },
}

WEAPONS_NEEDING_BONES = ["sv98", "mp412"]


def add_missing_bones_to_smd(smd_path):
    """Add missing arm bones to an SMD file by editing it line-by-line."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    # Parse nodes section to find existing bones
    nodes = {}  # bone_id -> (name, parent_id)
    name_to_id = {}
    in_nodes = False
    nodes_start = -1
    nodes_end = -1
    skel_start = -1
    skel_end = -1
    
    for i, line in enumerate(lines):
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            nodes_start = i
            continue
        if in_nodes and s == 'end':
            in_nodes = False
            nodes_end = i
            continue
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                parent = int(m.group(3))
                nodes[bid] = (name, parent)
                name_to_id[name] = bid
        if s == 'skeleton':
            skel_start = i
    
    # Check which arm bones are missing
    missing_bones = []
    for bone_name in ["ValveBiped.Bip01_Spine4", "ValveBiped.Bip01_L_Clavicle",
                      "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm",
                      "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_UpperArm",
                      "ValveBiped.Bip01_R_Forearm"]:
        if bone_name not in name_to_id:
            missing_bones.append(bone_name)
    
    if not missing_bones:
        return False
    
    # Find max bone ID
    max_id = max(nodes.keys()) if nodes else -1
    
    # Assign new IDs
    new_bone_ids = {}
    for bone_name in missing_bones:
        max_id += 1
        new_bone_ids[bone_name] = max_id
        name_to_id[bone_name] = max_id
    
    # Insert new bone lines into nodes section (before 'end')
    new_node_lines = []
    for bone_name in missing_bones:
        ref = C_ARMS_BONES[bone_name]
        parent_name = ref["parent"]
        if parent_name:
            parent_id = name_to_id.get(parent_name, -1)
        else:
            parent_id = -1
        bid = new_bone_ids[bone_name]
        new_node_lines.append(f'  {bid} "{bone_name}" {parent_id}\n')
        nodes[bid] = (bone_name, parent_id)
    
    # Insert before the 'end' line of nodes section
    lines[nodes_end:nodes_end] = new_node_lines
    
    # Now add the new bones to each time frame in the skeleton section
    # Re-find skeleton start (it shifted)
    skel_start = -1
    for i, line in enumerate(lines):
        if line.strip() == 'skeleton':
            skel_start = i
            break
    
    if skel_start < 0:
        # No skeleton section, just write the nodes
        with open(smd_path, 'w') as f:
            f.writelines(lines)
        return True
    
    # Find all 'time X' lines and insert new bone data after each time's existing bones
    # We need to insert before the next 'time' or 'end' line
    insertions = []  # list of (line_index, lines_to_insert)
    
    i = skel_start + 1
    while i < len(lines):
        s = lines[i].strip()
        if s == 'end':
            break
        if s.startswith('time'):
            # Find the next 'time' or 'end' line
            j = i + 1
            while j < len(lines):
                sj = lines[j].strip()
                if sj.startswith('time') or sj == 'end':
                    break
                j += 1
            # Insert new bone lines before j
            new_bone_lines = []
            for bone_name in missing_bones:
                bid = new_bone_ids[bone_name]
                ref = C_ARMS_BONES[bone_name]
                pos = ref["pos"]
                rot = ref["rot"]
                new_bone_lines.append(f'  {bid} {pos[0]:.6f} {pos[1]:.6f} {pos[2]:.6f} {rot[0]:.6f} {rot[1]:.6f} {rot[2]:.6f}\n')
            insertions.append((j, new_bone_lines))
            i = j
        else:
            i += 1
    
    # Apply insertions in reverse order to preserve indices
    for idx, new_lines in reversed(insertions):
        lines[idx:idx] = new_lines
    
    with open(smd_path, 'w') as f:
        f.writelines(lines)
    return True


def update_qc(weapon):
    """Add $definebone for missing arm bones in the QC file."""
    qc_path = COMPILE_DIR / weapon / "source" / f"{weapon}.qc"
    if not qc_path.exists():
        return
    
    with open(qc_path) as f:
        qc = f.read()
    
    # Add $definebone for missing bones
    added = False
    for bone_name in ["ValveBiped.Bip01_Spine4", "ValveBiped.Bip01_L_Clavicle",
                      "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm",
                      "ValveBiped.Bip01_R_Clavicle", "ValveBiped.Bip01_R_UpperArm",
                      "ValveBiped.Bip01_R_Forearm"]:
        if f'$definebone "{bone_name}"' not in qc:
            ref = C_ARMS_BONES[bone_name]
            parent = ref["parent"] or ""
            pos = ref["pos"]
            rot = ref["rot"]
            definebone = f'$definebone "{bone_name}" "{parent}" {pos[0]:.6f} {pos[1]:.6f} {pos[2]:.6f} {rot[0]:.6f} {rot[1]:.6f} {rot[2]:.6f} 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000\n'
            # Insert before first $sequence
            seq_match = re.search(r'\$sequence', qc, re.IGNORECASE)
            if seq_match:
                pos_idx = seq_match.start()
                qc = qc[:pos_idx] + definebone + qc[pos_idx:]
                added = True
    
    if added:
        with open(qc_path, 'w') as f:
            f.write(qc)


def process_weapon(weapon):
    """Process all SMD files for a weapon."""
    src_dir = COMPILE_DIR / weapon / "source"
    if not src_dir.exists():
        return False, "no source dir"
    
    changed = 0
    for smd_file in list(src_dir.glob("*.smd")):
        if add_missing_bones_to_smd(smd_file):
            changed += 1
    
    anims_dir = src_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd_file in anims_dir.glob("*.smd"):
            if add_missing_bones_to_smd(smd_file):
                changed += 1
    
    update_qc(weapon)
    
    return True, f"updated {changed} SMD files + QC"


def main():
    print("Adding missing arm bones to sv98 and mp412...")
    for weapon in WEAPONS_NEEDING_BONES:
        ok, msg = process_weapon(weapon)
        print(f"  {weapon}: {msg}")


if __name__ == "__main__":
    main()
