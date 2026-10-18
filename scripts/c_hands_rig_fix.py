#!/usr/bin/env python3
"""
c_hands_rig_fix.py — Blender headless script to rename BF3 bones to ValveBiped
names and set bone roll to 0.0 for hand bones.

Phase 1: Blender bone remapping (rename + roll = 0.0)
Phase 2: QC modification (update reference, add $include c_arms_definebones.qci)
"""
# import bpy  # Only available in Blender
import math
# import mathutils  # Only available in Blender
import os
import re
import sys
import shutil

sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map

DECOMPILE_DIR = "/home/z/my-project/decompile"
COMPILE_DIR = "/home/z/my-project/compile"
QCI_SOURCE = "/tmp/c_arms_extract/medkit/c_arms_definebones.qci"

# ============================================================================
# SMD PARSER
# ============================================================================
def parse_smd(smd_path):
    """Parse an SMD file. Returns dict with nodes, skeleton, triangles."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    
    result = {
        'nodes': [],      # [(id, name, parent_id)]
        'skeleton': [],   # [(time, [(bone_id, px, py, pz, rx, ry, rz)])]
        'triangles': []  # [(material, [(bone_id, x, y, z, nx, ny, nz, u, v, weights)])]
    }
    
    # Parse nodes
    nodes_match = re.search(r'^nodes\n(.*?)^end\n', content, re.MULTILINE | re.DOTALL)
    if nodes_match:
        for line in nodes_match.group(1).split('\n'):
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', line)
            if m:
                result['nodes'].append((int(m.group(1)), m.group(2), int(m.group(3))))
    
    # Parse skeleton
    skel_match = re.search(r'^skeleton\n(.*?)^end\n', content, re.MULTILINE | re.DOTALL)
    if skel_match:
        current_time = None
        current_bones = []
        for line in skel_match.group(1).split('\n'):
            line = line.strip()
            if line.startswith('time'):
                if current_time is not None:
                    result['skeleton'].append((current_time, current_bones))
                current_time = int(line.split()[1])
                current_bones = []
            elif line:
                parts = line.split()
                if len(parts) >= 7:
                    bid = int(parts[0])
                    px, py, pz = float(parts[1]), float(parts[2]), float(parts[3])
                    rx, ry, rz = float(parts[4]), float(parts[5]), float(parts[6])
                    weights = []
                    if len(parts) > 7:
                        try:
                            num_links = int(parts[7])
                            for j in range(num_links):
                                wb = int(parts[8 + j*2])
                                wv = float(parts[9 + j*2])
                                weights.append((wb, wv))
                        except (ValueError, IndexError):
                            weights = [(bid, 1.0)]
                    else:
                        weights = [(bid, 1.0)]
                    current_bones.append((bid, px, py, pz, rx, ry, rz, weights))
        if current_time is not None:
            result['skeleton'].append((current_time, current_bones))
    
    # Parse triangles
    tri_match = re.search(r'^triangles\n(.*?)^end\n', content, re.MULTILINE | re.DOTALL)
    if tri_match:
        current_mat = None
        current_verts = []
        for line in tri_match.group(1).split('\n'):
            line_stripped = line.strip()
            parts = line_stripped.split()
            
            # Check if vertex line (starts with number, has >= 9 fields)
            is_vertex = False
            if parts:
                try:
                    int(parts[0])
                    if len(parts) >= 9:
                        is_vertex = True
                except ValueError:
                    pass
            
            if not is_vertex and line_stripped:
                # Material name line
                if current_mat is not None and len(current_verts) == 3:
                    result['triangles'].append((current_mat, current_verts))
                current_mat = line_stripped
                current_verts = []
            elif is_vertex:
                bone_id = int(parts[0])
                x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                nx, ny, nz = float(parts[4]), float(parts[5]), float(parts[6])
                u, v = float(parts[7]), float(parts[8])
                weights = []
                if len(parts) > 9:
                    try:
                        num_links = int(parts[9])
                        for j in range(num_links):
                            wb = int(parts[10 + j*2])
                            wv = float(parts[11 + j*2])
                            weights.append((wb, wv))
                    except (ValueError, IndexError):
                        weights = [(bone_id, 1.0)]
                else:
                    weights = [(bone_id, 1.0)]
                current_verts.append((bone_id, x, y, z, nx, ny, nz, u, v, weights))
                
                if len(current_verts) == 3:
                    result['triangles'].append((current_mat, current_verts))
                    current_mat = None
                    current_verts = []
    
    return result


def is_hand_bone(name):
    """Check if a bone is a hand bone that should get roll = 0.0."""
    return bool(re.match(r'^ValveBiped\.Bip01_[LR]_(Clavicle|UpperArm|Forearm|Hand|Finger\d{1,2})$', name))


def is_bf3_procedural(name):
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE)
                or re.match(r'^[lr]-(upperarm|forearm|wrist)$', name, re.IGNORECASE)
                or re.match(r'^[lr]wrist$', name, re.IGNORECASE)
                or re.match(r'^[lr]-rist$', name, re.IGNORECASE))


# ============================================================================
# SMD WRITER (with bone renaming and roll = 0.0)
# ============================================================================
def write_smd(smd_path, parsed, bone_map, apply_roll_fix=False):
    """Write an SMD file with renamed bones and optionally roll = 0.0.
    
    apply_roll_fix: If True, set rx=ry=rz=0 for hand bones at time 0.
                    This simulates Blender's roll = 0.0 by resetting the
                    bone's local rotation to identity.
    """
    # Build bone ID to new name mapping
    id_to_new_name = {}
    for bid, name, pid in parsed['nodes']:
        new_name = bone_map.get(name, name)
        if is_bf3_procedural(name):
            new_name = None  # Remove this bone
        id_to_new_name[bid] = new_name
    
    # Build new bone ID mapping (remove procedural bones)
    old_to_new_id = {}
    new_id = 0
    for bid, name, pid in parsed['nodes']:
        if id_to_new_name[bid] is not None:
            old_to_new_id[bid] = new_id
            new_id += 1
    
    # Build new parent mapping
    new_parent_map = {}
    for bid, name, pid in parsed['nodes']:
        if bid in old_to_new_id and id_to_new_name[bid] is not None:
            if pid >= 0 and pid in old_to_new_id:
                new_parent_map[old_to_new_id[bid]] = old_to_new_id[pid]
            else:
                new_parent_map[old_to_new_id[bid]] = -1
    
    lines = ["version 1\n"]
    
    # Write nodes section
    lines.append("nodes\n")
    for bid, name, pid in parsed['nodes']:
        new_name = id_to_new_name[bid]
        if new_name is None:
            continue
        new_bid = old_to_new_id[bid]
        new_pid = new_parent_map.get(new_bid, -1)
        lines.append(f'  {new_bid} "{new_name}" {new_pid}\n')
    lines.append("end\n")
    
    # Write skeleton section
    lines.append("skeleton\n")
    for time_val, bones in parsed['skeleton']:
        lines.append(f"time {time_val}\n")
        for bone_entry in bones:
            bid = bone_entry[0]
            if bid not in old_to_new_id:
                continue
            new_bid = old_to_new_id[bid]
            px, py, pz = bone_entry[1], bone_entry[2], bone_entry[3]
            rx, ry, rz = bone_entry[4], bone_entry[5], bone_entry[6]
            
            # Get the new bone name
            new_name = id_to_new_name[bid]
            
            # Apply roll fix: set rotation to 0 for hand bones at time 0
            if apply_roll_fix and time_val == 0 and new_name and is_hand_bone(new_name):
                rx, ry, rz = 0.0, 0.0, 0.0
            
            lines.append(f"  {new_bid} {px:.6f} {py:.6f} {pz:.6f} {rx:.6f} {ry:.6f} {rz:.6f}\n")
    lines.append("end\n")
    
    # Write triangles section (with renamed bone IDs)
    lines.append("triangles\n")
    for mat, verts in parsed['triangles']:
        lines.append(f"{mat}\n")
        for vert in verts:
            old_bone_id = vert[0]
            if old_bone_id not in old_to_new_id:
                continue
            new_bone_id = old_to_new_id[old_bone_id]
            x, y, z = vert[1], vert[2], vert[3]
            nx, ny, nz = vert[4], vert[5], vert[6]
            u, v = vert[7], vert[8]
            weights = vert[9]
            
            # Remap bone weights
            new_weights = []
            for wb, wv in weights:
                if wb in old_to_new_id:
                    new_weights.append((old_to_new_id[wb], wv))
            
            if not new_weights:
                new_weights = [(new_bone_id, 1.0)]
            
            num_links = len(new_weights)
            weight_str = f" {num_links}"
            for wb, wv in new_weights:
                weight_str += f" {wb} {wv:.6f}"
            
            lines.append(f"  {new_bone_id} {x:.6f} {y:.6f} {z:.6f} {nx:.6f} {ny:.6f} {nz:.6f} {u:.6f} {v:.6f}{weight_str}\n")
    lines.append("end\n")
    
    with open(smd_path, 'w') as f:
        f.writelines(lines)


# ============================================================================
# QC MODIFIER
# ============================================================================
def modify_qc(qc_path, weapon):
    """Modify QC file:
    1. Change $modelname to c_<weapon>.mdl
    2. Add $include c_arms_definebones.qci before $sequence
    3. Remove v_hands/sleeve_diffuse from texturegroup
    4. Remove hands/ from cdmaterials
    5. Remove hands bodygroup
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()
    
    # Change modelname
    content = re.sub(r'\$modelname\s+"[^"]*"',
                     f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
    
    # Remove v_hands/sleeve_diffuse from texturegroup
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)
    
    # Remove hands/ cdmaterials
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    
    # Remove hands bodygroup
    content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                     '// REMOVED: hands bodygroup', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Remove $sectionframes
    content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
    
    # Add $include c_arms_definebones.qci before the first $sequence
    if '$include "c_arms_definebones.qci"' not in content:
        content = re.sub(r'(\$sequence)',
                         '$include "c_arms_definebones.qci"\n\n\\1', content, count=1, flags=re.IGNORECASE)
    
    with open(qc_path, 'w') as f:
        f.write(content)


# ============================================================================
# MAIN PROCESSING
# ============================================================================
def process_weapon(weapon):
    src_dir = os.path.join(DECOMPILE_DIR, weapon)
    dst_dir = os.path.join(COMPILE_DIR, weapon, "source")
    
    if not os.path.isdir(src_dir):
        return False
    
    # Create destination
    if os.path.exists(dst_dir):
        shutil.rmtree(dst_dir)
    os.makedirs(dst_dir, exist_ok=True)
    
    # Copy all files
    for item in os.listdir(src_dir):
        src_path = os.path.join(src_dir, item)
        dst_path = os.path.join(dst_dir, item)
        if os.path.isdir(src_path):
            shutil.copytree(src_path, dst_path)
        else:
            shutil.copy2(src_path, dst_path)
    
    qc_path = os.path.join(dst_dir, f"{weapon}.qc")
    if not os.path.exists(qc_path):
        return False
    
    # Build bone map for this weapon
    bone_map = build_bone_map()
    
    # Add weapon-specific finger mappings
    bone_hierarchy = {}
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith('.smd'):
                with open(os.path.join(root, f), 'r', errors='ignore') as fh:
                    c = fh.read()
                for m in re.finditer(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', c, re.MULTILINE):
                    bone_hierarchy[int(m.group(1))] = (m.group(2), int(m.group(3)))
    
    for side_prefix, vb_side in [("Left", "L"), ("Right", "R")]:
        hand_name = f"{side_prefix}_Hand"
        if hand_name not in [b[0] for b in bone_hierarchy.values()]:
            continue
        hand_id = None
        for bid, (name, parent) in bone_hierarchy.items():
            if name == hand_name:
                hand_id = bid; break
        if hand_id is None: continue
        finger_roots = []
        for bid, (name, parent) in sorted(bone_hierarchy.items()):
            if parent == hand_id and re.match(rf'^{side_prefix}\d+$', name):
                finger_roots.append((bid, name))
        def extract_num(n):
            m = re.search(r'(\d+)$', n)
            return int(m.group(1)) if m else 0
        finger_roots.sort(key=lambda x: extract_num(x[1]))
        for finger_idx, (root_bid, root_name) in enumerate(finger_roots[:5]):
            bone_map[root_name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}"
            for bid, (name, parent) in bone_hierarchy.items():
                if parent == root_bid:
                    bone_map[name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}1"
                    for bid2, (name2, parent2) in bone_hierarchy.items():
                        if parent2 == bid:
                            bone_map[name2] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}2"
    
    # Process all SMD files
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith('.smd'):
                smd_path = os.path.join(root, f)
                parsed = parse_smd(smd_path)
                
                # Reference SMDs (not in _anims folder) get roll fix
                is_anim = '_anims' in root or '_anims' in smd_path
                apply_roll = not is_anim
                
                write_smd(smd_path, parsed, bone_map, apply_roll_fix=apply_roll)
    
    # Copy c_arms_definebones.qci (remove $illumposition to avoid conflict)
    if os.path.exists(QCI_SOURCE):
        shutil.copy2(QCI_SOURCE, os.path.join(dst_dir, "c_arms_definebones.qci"))
        qci_path = os.path.join(dst_dir, "c_arms_definebones.qci")
        with open(qci_path, 'r') as qf:
            qci = qf.read()
        qci = re.sub(r'^\$illumposition[^\n]*\n', '', qci, flags=re.MULTILINE)
        with open(qci_path, 'w') as qf:
            qf.write(qci)
    
    # Modify QC
    modify_qc(qc_path, weapon)
    
    return True


# ============================================================================
# ENTRY POINT
# ============================================================================
if __name__ == "__main__":
    # When run in Blender, use bpy module; when run directly, just do text processing
    try:
        import bpy
        IN_BLENDER = True
    except ImportError:
        IN_BLENDER = False
    
    weapons = sorted([d for d in os.listdir(DECOMPILE_DIR)
                      if os.path.isdir(os.path.join(DECOMPILE_DIR, d))])
    
    print(f"{'='*60}")
    print(f"Processing {len(weapons)} weapons")
    print(f"{'='*60}")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        if process_weapon(weapon):
            print(f"  OK")
            success += 1
        else:
            print(f"  FAIL")
    
    print(f"\n{'='*60}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'='*60}")
