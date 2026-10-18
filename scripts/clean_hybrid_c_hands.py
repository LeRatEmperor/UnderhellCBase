#!/usr/bin/env python3
"""
clean_hybrid_c_hands.py — Clean implementation based on Ghosts weapon specification.

Key insights from Ghosts weapons (verified working c_hands):
1. Weapon mesh weighted ONLY to weapon bones (no hand mesh in weapon model)
2. 36 ValveBiped bones added as children of animation bones (NOT chained to each other)
3. NO Spine4, NO Clavicle — only UpperArm/Forearm/Hand/Fingers
4. NO $definebone for ValveBiped bones (let SMD source define them)
5. $bonemerge for all 36 ValveBiped bones
6. Large local rotations (~±180°) for axis conversion

Implementation:
1. Rename BF3 bones to ValveBiped convention (using BONE_MAP)
2. Rename existing ValveBiped hand bones to "anim_*" (avoid name conflicts)
3. Remove BF3 procedural bones (l_thumb_tip etc.)
4. Remove non-essential bones (ForeTwist, IK helpers) to stay under 128 limit
5. Add 36 NEW ValveBiped bones as children of anim_* bones
   - Each ValveBiped bone's local transform = inverse(anim_world) * c_arms_world
   - This makes the ValveBiped bone's world transform = c_arms_citizen's world transform
6. Strip v_hands mesh from SMDs
7. Clean QC (remove v_hands materials, hands bodygroup)
8. Add $bonemerge for 36 ValveBiped bones
9. NO $definebone for ValveBiped bones (let SMD define them)
"""
import os, re, math, shutil, sys
from pathlib import Path
from collections import OrderedDict
import numpy as np

sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map

DECOMPILE_DIR = Path("/home/z/my-project/decompile")
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_SMD = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")

HAND_MATERIALS = {"v_hands", "sleeve_diffuse", "sleeve_diff", "t_phoenix"}

# The ValveBiped bones we need (matching Ghosts pattern + Wrist/Ulna for c_arms mesh)
# Each entry: (valvebiped_name, anim_parent_name)
# The anim_parent is the BF3 bone (after renaming) that the ValveBiped bone will be a child of
VALVEBIPED_BONES = [
    # Left arm (3 bones)
    ("ValveBiped.Bip01_L_UpperArm", "anim_ValveBiped.Bip01_L_UpperArm"),
    ("ValveBiped.Bip01_L_Forearm", "anim_ValveBiped.Bip01_L_Forearm"),
    ("ValveBiped.Bip01_L_Hand", "anim_ValveBiped.Bip01_L_Hand"),
    # Left Wrist and Ulna (children of Forearm — needed because c_arms mesh is weighted to them)
    ("ValveBiped.Bip01_L_Wrist", "anim_ValveBiped.Bip01_L_Forearm"),
    ("ValveBiped.Bip01_L_Ulna", "anim_ValveBiped.Bip01_L_Forearm"),
    # Left fingers (15 bones: 5 fingers × 3 segments)
    ("ValveBiped.Bip01_L_Finger0", "anim_ValveBiped.Bip01_L_Finger0"),
    ("ValveBiped.Bip01_L_Finger01", "anim_ValveBiped.Bip01_L_Finger01"),
    ("ValveBiped.Bip01_L_Finger02", "anim_ValveBiped.Bip01_L_Finger02"),
    ("ValveBiped.Bip01_L_Finger1", "anim_ValveBiped.Bip01_L_Finger1"),
    ("ValveBiped.Bip01_L_Finger11", "anim_ValveBiped.Bip01_L_Finger11"),
    ("ValveBiped.Bip01_L_Finger12", "anim_ValveBiped.Bip01_L_Finger12"),
    ("ValveBiped.Bip01_L_Finger2", "anim_ValveBiped.Bip01_L_Finger2"),
    ("ValveBiped.Bip01_L_Finger21", "anim_ValveBiped.Bip01_L_Finger21"),
    ("ValveBiped.Bip01_L_Finger22", "anim_ValveBiped.Bip01_L_Finger22"),
    ("ValveBiped.Bip01_L_Finger3", "anim_ValveBiped.Bip01_L_Finger3"),
    ("ValveBiped.Bip01_L_Finger31", "anim_ValveBiped.Bip01_L_Finger31"),
    ("ValveBiped.Bip01_L_Finger32", "anim_ValveBiped.Bip01_L_Finger32"),
    ("ValveBiped.Bip01_L_Finger4", "anim_ValveBiped.Bip01_L_Finger4"),
    ("ValveBiped.Bip01_L_Finger41", "anim_ValveBiped.Bip01_L_Finger41"),
    ("ValveBiped.Bip01_L_Finger42", "anim_ValveBiped.Bip01_L_Finger42"),
    # Right arm (3 bones)
    ("ValveBiped.Bip01_R_UpperArm", "anim_ValveBiped.Bip01_R_UpperArm"),
    ("ValveBiped.Bip01_R_Forearm", "anim_ValveBiped.Bip01_R_Forearm"),
    ("ValveBiped.Bip01_R_Hand", "anim_ValveBiped.Bip01_R_Hand"),
    # Right Wrist and Ulna (children of Forearm)
    ("ValveBiped.Bip01_R_Wrist", "anim_ValveBiped.Bip01_R_Forearm"),
    ("ValveBiped.Bip01_R_Ulna", "anim_ValveBiped.Bip01_R_Forearm"),
    # Right fingers (15 bones)
    ("ValveBiped.Bip01_R_Finger0", "anim_ValveBiped.Bip01_R_Finger0"),
    ("ValveBiped.Bip01_R_Finger01", "anim_ValveBiped.Bip01_R_Finger01"),
    ("ValveBiped.Bip01_R_Finger02", "anim_ValveBiped.Bip01_R_Finger02"),
    ("ValveBiped.Bip01_R_Finger1", "anim_ValveBiped.Bip01_R_Finger1"),
    ("ValveBiped.Bip01_R_Finger11", "anim_ValveBiped.Bip01_R_Finger11"),
    ("ValveBiped.Bip01_R_Finger12", "anim_ValveBiped.Bip01_R_Finger12"),
    ("ValveBiped.Bip01_R_Finger2", "anim_ValveBiped.Bip01_R_Finger2"),
    ("ValveBiped.Bip01_R_Finger21", "anim_ValveBiped.Bip01_R_Finger21"),
    ("ValveBiped.Bip01_R_Finger22", "anim_ValveBiped.Bip01_R_Finger22"),
    ("ValveBiped.Bip01_R_Finger3", "anim_ValveBiped.Bip01_R_Finger3"),
    ("ValveBiped.Bip01_R_Finger31", "anim_ValveBiped.Bip01_R_Finger31"),
    ("ValveBiped.Bip01_R_Finger32", "anim_ValveBiped.Bip01_R_Finger32"),
    ("ValveBiped.Bip01_R_Finger4", "anim_ValveBiped.Bip01_R_Finger4"),
    ("ValveBiped.Bip01_R_Finger41", "anim_ValveBiped.Bip01_R_Finger41"),
    ("ValveBiped.Bip01_R_Finger42", "anim_ValveBiped.Bip01_R_Finger42"),
]

# Bones to remove (procedural + non-essential to stay under 128 limit)
def is_bf3_procedural(name):
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE)
                or re.match(r'^[lr]-(upperarm|forearm|wrist)$', name, re.IGNORECASE)
                or re.match(r'^[lr]wrist$', name, re.IGNORECASE)
                or re.match(r'^[lr]-rist$', name, re.IGNORECASE))

def is_non_essential(name):
    if re.match(r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$', name, re.IGNORECASE): return True
    if re.match(r'^anim_ValveBiped\.Bip01_[LR]_ForeTwist\d?$', name, re.IGNORECASE): return True
    if re.match(r'^ik_hand', name, re.IGNORECASE): return True
    if re.match(r'^b_wpn_', name, re.IGNORECASE): return True
    return False

def is_hand_bone_to_rename(name):
    """Check if this is a ValveBiped hand bone that should be renamed to anim_*"""
    for vb_name, _ in VALVEBIPED_BONES:
        if name == vb_name:
            return True
    return False

# ============================================================================
# MATRIX MATH
# ============================================================================
def euler_to_matrix(rx, ry, rz):
    """RadianEuler(x,y,z) -> 4x4 matrix (matching studiomdl's AngleMatrix)"""
    pitch, yaw, roll = ry, rz, rx  # RadianEuler(x,y,z) -> QAngle(y,z,x)
    cp, sp = math.cos(pitch), math.sin(pitch)
    cy, sy = math.cos(yaw), math.sin(yaw)
    cr, sr = math.cos(roll), math.sin(roll)
    m = np.eye(4)
    m[0,0] = cp*cy; m[0,1] = sr*sp*cy-cr*sy; m[0,2] = cr*sp*cy+sr*sy
    m[1,0] = cp*sy; m[1,1] = sr*sp*sy+cr*cy; m[1,2] = cr*sp*sy-sr*cy
    m[2,0] = -sp;   m[2,1] = sr*cp;            m[2,2] = cr*cp
    return m

def matrix_to_euler(m):
    """4x4 matrix -> RadianEuler(x,y,z)"""
    sp = -m[2,0]
    if abs(sp) > 0.99999:
        pitch = math.asin(max(-1, min(1, sp)))
        yaw = math.atan2(-m[0,1], m[1,1])
        roll = 0
    else:
        pitch = math.asin(sp)
        yaw = math.atan2(m[1,0], m[0,0])
        roll = math.atan2(m[2,1], m[2,2])
    return roll, pitch, yaw  # (rx, ry, rz) in RadianEuler

# ============================================================================
# SMD PARSING
# ============================================================================
def parse_smd(smd_path):
    """Parse SMD file. Returns (bone_id_to_name, bone_parents, bind_pose)."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    bone_id_to_name = {}
    bone_parents = {}
    
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if s == 'end' and in_nodes: in_nodes = False; break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid, name, pid = int(m.group(1)), m.group(2), int(m.group(3))
                bone_id_to_name[bid] = name
                bone_parents[bid] = pid
    
    bind_pose = {}
    in_skeleton = False
    in_time_0 = False
    for line in lines:
        s = line.strip()
        if s == 'skeleton': in_skeleton = True; continue
        if s == 'end' and in_skeleton: break
        if not in_skeleton: continue
        if s.startswith('time'):
            in_time_0 = (s == 'time 0'); continue
        if in_time_0:
            m = re.match(r'^\s*(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
            if m:
                bid = int(m.group(1))
                bind_pose[bid] = tuple(float(m.group(i)) for i in range(2, 8))
    
    return bone_id_to_name, bone_parents, bind_pose

def compute_world_transforms(bone_id_to_name, bone_parents, bind_pose):
    """Compute world-space transforms for all bones."""
    world = {}
    def get_world(bid):
        if bid in world: return world[bid]
        if bid not in bind_pose: return np.eye(4)
        px, py, pz, rx, ry, rz = bind_pose[bid]
        local = euler_to_matrix(rx, ry, rz)
        local[0,3], local[1,3], local[2,3] = px, py, pz
        pid = bone_parents.get(bid, -1)
        if pid >= 0 and pid in bind_pose:
            w = get_world(pid)
            result = np.matmul(w, local)
        else:
            result = local
        world[bid] = result
        return result
    
    for bid in bind_pose:
        get_world(bid)
    return world

# ============================================================================
# SMD MODIFICATION
# ============================================================================
def remove_bones_from_smd(smd_path, bones_to_remove):
    """Remove specified bones (by name) from an SMD's nodes and skeleton sections."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    bone_id_to_name = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if s == 'end' and in_nodes: in_nodes = False; break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bone_id_to_name[int(m.group(1))] = m.group(2)
    
    ids_to_remove = {bid for bid, name in bone_id_to_name.items() if name in bones_to_remove}
    if not ids_to_remove:
        return 0
    
    new_lines = []
    in_nodes = False
    in_skeleton = False
    changes = 0
    
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; new_lines.append(line); continue
        if s == 'end' and in_nodes: in_nodes = False; new_lines.append(line); continue
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m and int(m.group(1)) in ids_to_remove:
                changes += 1; continue
            new_lines.append(line); continue
        
        if s == 'skeleton': in_skeleton = True; new_lines.append(line); continue
        if s == 'end' and in_skeleton: in_skeleton = False; new_lines.append(line); continue
        if in_skeleton:
            m = re.match(r'^(\s*)(\d+)\s+', s)
            if m and int(m.group(2)) in ids_to_remove:
                changes += 1; continue
        new_lines.append(line)
    
    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes

def rename_bones_in_smd(smd_path, rename_map):
    """Rename bones in an SMD file."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    for old, new in sorted(rename_map.items(), key=lambda x: len(x[0]), reverse=True):
        if old and old != "(null)":
            content = content.replace(f'"{old}"', f'"{new}"')
    with open(smd_path, 'w') as f:
        f.write(content)

def add_valvebiped_bones_to_smd(smd_path, new_bone_data, anim_bone_names):
    """Add new ValveBiped bones to an SMD file's nodes and skeleton sections."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    bone_name_to_id = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if s == 'end' and in_nodes: in_nodes = False; break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bone_name_to_id[m.group(2)] = int(m.group(1))
    
    max_id = max(bone_name_to_id.values()) if bone_name_to_id else 0
    next_id = max_id + 1
    
    new_bone_ids = {}
    for vb_name, anim_parent in VALVEBIPED_BONES:
        if vb_name in new_bone_data and anim_parent in bone_name_to_id:
            new_bone_ids[vb_name] = next_id
            next_id += 1
    
    if not new_bone_ids:
        return 0
    
    new_lines = []
    in_nodes = False
    in_skeleton = False
    nodes_added = False
    changes = 0
    
    for line in lines:
        s = line.strip()
        
        if s == 'nodes':
            in_nodes = True; new_lines.append(line); continue
        if s == 'end' and in_nodes:
            in_nodes = False
            if not nodes_added:
                for vb_name, anim_parent in VALVEBIPED_BONES:
                    if vb_name in new_bone_ids:
                        bid = new_bone_ids[vb_name]
                        pid = bone_name_to_id.get(anim_parent, -1)
                        new_lines.append(f'  {bid} "{vb_name}" {pid}\n')
                        changes += 1
                nodes_added = True
            new_lines.append(line); continue
        
        if s == 'skeleton':
            in_skeleton = True; new_lines.append(line); continue
        if s == 'end' and in_skeleton:
            in_skeleton = False; new_lines.append(line); continue
        if not in_skeleton:
            new_lines.append(line); continue
        
        if s.startswith('time'):
            new_lines.append(line)
            for vb_name, _ in VALVEBIPED_BONES:
                if vb_name in new_bone_ids and vb_name in new_bone_data:
                    bid = new_bone_ids[vb_name]
                    px, py, pz, rx, ry, rz = new_bone_data[vb_name]
                    new_lines.append(f'  {bid} {px:.6f} {py:.6f} {pz:.6f} {rx:.6f} {ry:.6f} {rz:.6f}\n')
                    changes += 1
            continue
        
        new_lines.append(line)
    
    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes

def strip_v_hands_mesh(smd_path):
    """Strip v_hands/sleeve_diffuse triangle blocks from an SMD file."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    
    tri_match = re.search(r'^triangles\s*\n', content, re.MULTILINE)
    if not tri_match: return 0
    tri_start = tri_match.end()
    end_match = re.search(r'^end\s*$', content[tri_start:], re.MULTILINE)
    if not end_match: return 0
    tri_end = tri_start + end_match.start()
    tri_section = content[tri_start:tri_end]
    
    new_tris = []
    cur_mat = None
    cur_verts = []
    stripped = 0
    
    for line in tri_section.split('\n'):
        s = line.strip()
        is_vert = bool(re.match(r'^\s+\d+\s+', line))
        
        if not is_vert and s:
            if cur_mat is not None and cur_verts:
                if cur_mat.lower() not in HAND_MATERIALS:
                    new_tris.append(cur_mat)
                    new_tris.extend(cur_verts)
                else:
                    stripped += 1
            cur_mat = s
            cur_verts = []
        elif is_vert:
            cur_verts.append(line)
        elif not s:
            if cur_mat is not None and cur_verts:
                if cur_mat.lower() not in HAND_MATERIALS:
                    new_tris.append(cur_mat)
                    new_tris.extend(cur_verts)
                else:
                    stripped += 1
            cur_mat = None
            cur_verts = []
    
    if cur_mat is not None and cur_verts:
        if cur_mat.lower() not in HAND_MATERIALS:
            new_tris.append(cur_mat)
            new_tris.extend(cur_verts)
        else:
            stripped += 1
    
    new_str = '\n'.join(new_tris)
    if new_str: new_str += '\n'
    
    if stripped > 0:
        with open(smd_path, 'w') as f:
            f.write(content[:tri_start] + new_str + content[tri_end:])
    return stripped

# ============================================================================
# QC MODIFICATION
# ============================================================================
def update_qc(qc_path):
    """Update QC: remove hand materials, remove procedural/non-essential $definebone,
    add $bonemerge for ValveBiped bones. NO $definebone for ValveBiped bones."""
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()
    
    original = content
    
    # Remove v_hands/sleeve_diffuse from texturegroup
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)
    
    # Remove hands cdmaterials
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n', '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n', '', content, flags=re.IGNORECASE)
    
    # Remove hands bodygroup
    content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                     '// REMOVED: hands bodygroup', content, flags=re.IGNORECASE | re.DOTALL)
    
    # Remove $definebone for procedural and non-essential bones
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'^\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
        if m:
            name = m.group(1)
            if is_bf3_procedural(name) or is_non_essential(name):
                continue
        new_lines.append(line)
    content = '\n'.join(new_lines)
    
    # Remove $attachment lines referencing removed bones
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'^\$attachment\s+"[^"]*"\s+"([^"]+)"', line, re.IGNORECASE)
        if m:
            bone = m.group(1)
            if is_bf3_procedural(bone) or is_non_essential(bone):
                continue
        new_lines.append(line)
    content = '\n'.join(new_lines)
    
    # Add $bonemerge for all 36 ValveBiped bones (NO $definebone — let SMD define them)
    bonemerge_lines = [f'$BoneMerge "{vb_name}"' for vb_name, _ in VALVEBIPED_BONES]
    
    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_L_UpperArm"', content, re.IGNORECASE):
        insert_block = '\n' + '\n'.join(bonemerge_lines) + '\n'
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

# ============================================================================
# MAIN CONVERSION
# ============================================================================
def convert_weapon(weapon, c_arms_world):
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
    
    # Step 1: Rename BF3 bones to ValveBiped convention
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
            weapon_bone_map[root_name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}"
            for bid, (name, parent) in bone_hierarchy.items():
                if parent == root_bid:
                    weapon_bone_map[name] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}1"
                    for bid2, (name2, parent2) in bone_hierarchy.items():
                        if parent2 == bid:
                            weapon_bone_map[name2] = f"ValveBiped.Bip01_{vb_side}_Finger{finger_idx}2"
    
    # Apply bone renaming (skip procedural bones)
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            path = os.path.join(root, f)
            if f.endswith((".smd", ".qc", ".qci")):
                try:
                    with open(path, "r", errors="ignore") as fh:
                        content = fh.read()
                    for old, new in sorted(weapon_bone_map.items(), key=lambda x: len(x[0]), reverse=True):
                        if not old or old == "(null)" or is_bf3_procedural(old):
                            continue
                        content = content.replace(f'"{old}"', f'"{new}"')
                    if f.endswith(".qc"):
                        content = re.sub(r'\$modelname\s+"[^"]*"',
                                        f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
                        content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
                    with open(path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    print(f"    WARN: {f}: {e}")
    print(f"    Bones renamed")
    
    # Step 2: Remove BF3 procedural + non-essential bones from all SMDs
    bones_to_remove = set()
    # Collect all bone names that are procedural or non-essential
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                path = os.path.join(root, f)
                with open(path, 'r', errors='ignore') as fh:
                    for line in fh:
                        m = re.match(r'^\s*\d+\s+"([^"]+)"', line)
                        if m:
                            name = m.group(1)
                            if is_bf3_procedural(name) or is_non_essential(name):
                                bones_to_remove.add(name)
    
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                remove_bones_from_smd(os.path.join(root, f), bones_to_remove)
    print(f"    Removed {len(bones_to_remove)} procedural/non-essential bones")
    
    # Step 3: Rename existing ValveBiped hand bones to anim_*
    anim_rename = {}
    for vb_name, _ in VALVEBIPED_BONES:
        anim_rename[vb_name] = f"anim_{vb_name}"
    
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith((".smd", ".qc", ".qci")):
                path = os.path.join(root, f)
                with open(path, "r", errors="ignore") as fh:
                    content = fh.read()
                for old, new in sorted(anim_rename.items(), key=lambda x: len(x[0]), reverse=True):
                    content = content.replace(f'"{old}"', f'"{new}"')
                with open(path, "w") as fh:
                    fh.write(content)
    print(f"    Renamed {len(anim_rename)} hand bones to anim_*")
    
    # Step 4: Parse bind pose and compute world transforms for anim_* bones
    ref_smd = None
    for name in ['default.smd', 'hands.smd', f'{weapon}.smd']:
        candidate = dst_dir / name
        if candidate.exists():
            ref_smd = candidate; break
    if not ref_smd:
        for smd in dst_dir.glob("*.smd"):
            ref_smd = smd; break
    
    if not ref_smd:
        print(f"    ERROR: no reference SMD"); return False
    
    bone_id_to_name, bone_parents, bind_pose = parse_smd(ref_smd)
    weapon_world = compute_world_transforms(bone_id_to_name, bone_parents, bind_pose)
    
    # Build name -> world transform map
    weapon_world_by_name = {}
    for bid, name in bone_id_to_name.items():
        if bid in weapon_world:
            weapon_world_by_name[name] = weapon_world[bid]
    
    print(f"    Parsed bind pose: {len(bind_pose)} bones")
    
    # Step 5: Compute local transforms for new ValveBiped bones
    # KEY INSIGHT from Ghosts weapons:
    # The ValveBiped bones should be at the SAME WORLD POSITION as their anim_* parents
    # (so the c_arms mesh renders near the weapon, not 40 units away)
    # But they should have c_arms_citizen's ROTATION (so fingers are oriented correctly)
    #
    # local = inverse(anim_world) * (c_arms_rotation + anim_position)
    # This means: keep the anim bone's position, but use c_arms_citizen's rotation
    new_bone_data = {}
    for vb_name, anim_parent in VALVEBIPED_BONES:
        if anim_parent not in weapon_world_by_name:
            continue
        if vb_name not in c_arms_world:
            continue
        
        anim_world = weapon_world_by_name[anim_parent]
        c_arms_mat = c_arms_world[vb_name]
        
        # Build a matrix that uses anim_world's POSITION but c_arms_mat's ROTATION
        # Extract rotation from c_arms_mat
        c_arms_rot = c_arms_mat.copy()
        c_arms_rot[0,3] = anim_world[0,3]  # Use anim bone's position
        c_arms_rot[1,3] = anim_world[1,3]
        c_arms_rot[2,3] = anim_world[2,3]
        
        # local = inverse(anim_world) * combined
        local = np.matmul(np.linalg.inv(anim_world), c_arms_rot)
        
        px, py, pz = local[0,3], local[1,3], local[2,3]
        rx, ry, rz = matrix_to_euler(local)
        new_bone_data[vb_name] = (px, py, pz, rx, ry, rz)
    
    print(f"    Computed {len(new_bone_data)} new ValveBiped bone transforms")
    
    # Step 6: Add new ValveBiped bones to all SMDs
    anim_bone_names = set(anim_rename.values())
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                add_valvebiped_bones_to_smd(os.path.join(root, f), new_bone_data, anim_bone_names)
    print(f"    Added ValveBiped bones to SMDs")
    
    # Step 7: Strip v_hands mesh
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                strip_v_hands_mesh(os.path.join(root, f))
    print(f"    Stripped v_hands mesh")
    
    # Step 8: Update QC
    update_qc(qc_path)
    print(f"    QC updated")
    
    return True

# ============================================================================
# MAIN
# ============================================================================
def main():
    print("=" * 70)
    print("clean_hybrid_c_hands.py — Ghosts-style hybrid (clean implementation)")
    print("=" * 70)
    
    # Parse c_arms_citizen reference
    print("\nParsing c_arms_citizen.smd...")
    ca_bone_id_to_name, ca_bone_parents, ca_bind_pose = parse_smd(C_ARMS_SMD)
    ca_world_by_id = compute_world_transforms(ca_bone_id_to_name, ca_bone_parents, ca_bind_pose)
    # Convert to name-keyed dict
    c_arms_world = {}
    for bid, name in ca_bone_id_to_name.items():
        if bid in ca_world_by_id:
            c_arms_world[name] = ca_world_by_id[bid]
    print(f"  Found {len(ca_bind_pose)} bones, {len(c_arms_world)} world transforms by name")
    
    # Get weapons
    weapons = sorted([d.name for d in DECOMPILE_DIR.iterdir()
                      if d.is_dir() and not d.name.startswith('.')
                      and d.name not in {'ghosts_m27_lmg', 'ghosts_ak12', 'm416_prev_compiled',
                                          'm416_check_bonemerge', 'm416_verify', 'scotia_c_arms_ref',
                                          'test_minimal_check', 'm416_check', '870mcs_check',
                                          'check_m416', 'check_870mcs', 'check_famas', 'check_g36c',
                                          'check_g3a3', 'check_l85a2', 'check_scarh', 'check_sv98',
                                          'check_mp412', 'check_m9', 'check_acwr'}])
    print(f"\nFound {len(weapons)} weapons")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        try:
            if convert_weapon(weapon, c_arms_world):
                success += 1
        except Exception as e:
            print(f"  FAIL: {e}")
            import traceback
            traceback.print_exc()
    
    print(f"\n{'='*70}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'='*70}")

if __name__ == "__main__":
    main()
