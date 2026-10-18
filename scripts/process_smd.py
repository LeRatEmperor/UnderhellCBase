#!/usr/bin/env python3
"""
process_smd.py — Edit SMD files for c_hands conversion.
Equivalent to Blender editing: bone renaming, hand mesh removal, roll fix.
"""
import math, os, re, sys, shutil
from pathlib import Path

DECOMPILE_DIR = Path("/home/z/my-project/decompile")
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_QCI = Path("/tmp/c_arms_extract/c_arms_definebones.qci")
C_ARMS_SMD = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")

# Bones that c_arms needs (for $bonemerge)
BONEMERGE_BONES = [
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
]

# Materials to strip (hand mesh materials)
HAND_MATERIALS = {"v_hands", "sleeve_diffuse"}

# BF3 procedural bone patterns to remove
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
]

def is_bf3_procedural(name):
    return any(re.match(pat, name, re.IGNORECASE) for pat in BF3_PROC_PATTERNS)

def parse_c_arms_reference():
    """Parse c_arms_citizen.smd for reference bone rotations."""
    with open(C_ARMS_SMD) as f:
        content = f.read()
    
    nodes = {}
    in_nodes = False
    for line in content.split('\n'):
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if in_nodes and s == 'end': break
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m: nodes[int(m.group(1))] = m.group(2)
    
    ref = {}
    in_skel = False; in_time0 = False
    for line in content.split('\n'):
        s = line.strip()
        if s == 'skeleton': in_skel = True; continue
        if in_skel and s.startswith('time'):
            in_time0 = (s == 'time 0')
            if not in_time0: break
            continue
        if in_time0:
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bid = int(parts[0])
                    name = nodes.get(bid, "")
                    if name:
                        ref[name] = (float(parts[4]), float(parts[5]), float(parts[6]))
                except: pass
    return ref

# Quaternion math for roll fix
def euler_to_quat(rx, ry, rz):
    cx, sx = math.cos(rx/2), math.sin(rx/2)
    cy, sy = math.cos(ry/2), math.sin(ry/2)
    cz, sz = math.cos(rz/2), math.sin(rz/2)
    return (sx*cy*cz - cx*sy*sz, cx*sy*cz + sx*cy*sz, cx*cy*sz - sx*sy*cz, cx*cy*cz + sx*sy*sz)

def quat_to_euler(x, y, z, w):
    sin_x = 2*(w*x + y*z); cos_x = 1 - 2*(x*x + y*y)
    rx = math.atan2(sin_x, cos_x)
    sin_y = 2*(w*y - z*x)
    ry = math.asin(max(-1, min(1, sin_y)))
    sin_z = 2*(w*z + x*y); cos_z = 1 - 2*(y*y + z*z)
    rz = math.atan2(sin_z, cos_z)
    return (rx, ry, rz)

def quat_mul(a, b):
    return (a[3]*b[0]+a[0]*b[3]+a[1]*b[2]-a[2]*b[1],
            a[3]*b[1]-a[0]*b[2]+a[1]*b[3]+a[2]*b[0],
            a[3]*b[2]+a[0]*b[1]-a[1]*b[0]+a[2]*b[3],
            a[3]*b[3]-a[0]*b[0]-a[1]*b[1]-a[2]*b[2])

def quat_inv(q):
    return (-q[0], -q[1], -q[2], q[3])

def strip_hand_triangles(content):
    """Remove triangles that use hand mesh materials."""
    lines = content.split('\n')
    new_lines = []
    in_triangles = False
    skip_current = False
    tri_count = 0
    stripped = 0
    
    for line in lines:
        s = line.strip()
        if s == 'triangles':
            in_triangles = True
            new_lines.append(line)
            continue
        if in_triangles and s == 'end':
            in_triangles = False
            new_lines.append(line)
            continue
        
        if in_triangles:
            # Triangle material line (first line of a triangle block)
            if not skip_current and not s.startswith('//') and len(s) > 0:
                # Check if this is a material name
                mat_name = s.split()[0] if s.split() else ""
                if mat_name.lower() in HAND_MATERIALS:
                    skip_current = True
                    stripped += 1
                    continue
            
            if skip_current:
                # Skip vertex lines (3 per triangle)
                if s and (s[0].isdigit() or s.startswith('-')):
                    tri_count += 1
                    if tri_count >= 3:
                        skip_current = False
                        tri_count = 0
                    continue
                elif s == '':
                    continue
                else:
                    # This is the start of a new triangle
                    skip_current = False
                    tri_count = 0
                    mat_name = s.split()[0] if s.split() else ""
                    if mat_name.lower() in HAND_MATERIALS:
                        skip_current = True
                        stripped += 1
                        continue
            
            new_lines.append(line)
        else:
            new_lines.append(line)
    
    return '\n'.join(new_lines), stripped

def remove_bf3_procedural_bones(content):
    """Remove BF3 procedural bones from nodes and skeleton sections."""
    lines = content.split('\n')
    new_lines = []
    
    # First pass: find BF3 procedural bone IDs
    proc_bone_ids = set()
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if in_nodes and s == 'end': in_nodes = False; continue
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m and is_bf3_procedural(m.group(2)):
                proc_bone_ids.add(int(m.group(1)))
    
    # Second pass: filter out those bones
    in_nodes = False
    in_skel = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; new_lines.append(line); continue
        if in_nodes and s == 'end': in_nodes = False; new_lines.append(line); continue
        if s == 'skeleton': in_skel = True; new_lines.append(line); continue
        if in_skel and s == 'end': in_skel = False; new_lines.append(line); continue
        
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m and int(m.group(1)) in proc_bone_ids:
                continue  # Skip this bone
        elif in_skel:
            parts = s.split()
            if len(parts) >= 1:
                try:
                    bid = int(parts[0])
                    if bid in proc_bone_ids:
                        continue  # Skip this bone's skeleton data
                except: pass
        
        new_lines.append(line)
    
    return '\n'.join(new_lines)

def fix_bone_rolls(content, ref_bones):
    """Replace hand bone rotations with c_arms_citizen reference values."""
    lines = content.split('\n')
    
    # Parse nodes to get bone name -> id mapping
    nodes = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes': in_nodes = True; continue
        if in_nodes and s == 'end': break
        if in_nodes:
            m = re.match(r'(\d+)\s+"([^"]+)"\s+(-?\d+)', s)
            if m: nodes[int(m.group(1))] = m.group(2)
    
    name_to_id = {name: bid for bid, name in nodes.items()}
    
    # Compute delta quaternions for each hand bone
    bone_deltas = {}
    # Get bind pose from skeleton time 0
    bind_pose = {}
    in_skel = False; in_time0 = False
    for line in lines:
        s = line.strip()
        if s == 'skeleton': in_skel = True; continue
        if in_skel and s.startswith('time'):
            in_time0 = (s == 'time 0')
            if not in_time0: break
            continue
        if in_time0:
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bid = int(parts[0])
                    bind_pose[bid] = tuple(float(p) for p in parts[1:7])
                except: pass
    
    for bone_name, ref_rot in ref_bones.items():
        if bone_name not in name_to_id: continue
        bid = name_to_id[bone_name]
        if bid not in bind_pose: continue
        
        old_rot = (bind_pose[bid][3], bind_pose[bid][4], bind_pose[bid][5])
        old_quat = euler_to_quat(*old_rot)
        new_quat = euler_to_quat(*ref_rot)
        delta = quat_mul(new_quat, quat_inv(old_quat))
        bone_deltas[bone_name] = delta
    
    # Apply delta to all keyframes
    new_lines = []
    in_skel = False
    current_time = None
    for line in lines:
        s = line.strip()
        if s == 'skeleton': in_skel = True; new_lines.append(line); continue
        if in_skel and s == 'end': in_skel = False; new_lines.append(line); continue
        
        if in_skel:
            if s.startswith('time'):
                current_time = int(s.split()[1])
                new_lines.append(line)
                continue
            parts = s.split()
            if len(parts) >= 7:
                try:
                    bid = int(parts[0])
                    bone_name = nodes.get(bid, "")
                    if bone_name in bone_deltas:
                        x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
                        rx, ry, rz = float(parts[4]), float(parts[5]), float(parts[6])
                        key_quat = euler_to_quat(rx, ry, rz)
                        new_quat = quat_mul(bone_deltas[bone_name], key_quat)
                        nrx, nry, nrz = quat_to_euler(*new_quat)
                        indent = line[:len(line) - len(line.lstrip())]
                        new_lines.append(f"{indent}{bid} {x:.6f} {y:.6f} {z:.6f} {nrx:.6f} {nry:.6f} {nrz:.6f}")
                        continue
                except: pass
        new_lines.append(line)
    
    return '\n'.join(new_lines)

def update_qc(qc_path, weapon):
    """Update QC file: add $include, $bonemerge, fix $modelname, remove hands bodygroup."""
    with open(qc_path) as f:
        qc = f.read()
    
    # Change $modelname to c_<weapon>.mdl
    qc = re.sub(r'\$modelname\s+"[^"]*"', f'$modelname "weapons/c_{weapon}.mdl"', qc, flags=re.IGNORECASE)
    
    # Remove hands bodygroup
    qc = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}', '// REMOVED: hands bodygroup', qc, flags=re.IGNORECASE | re.DOTALL)
    
    # Remove v_hands/sleeve_diffuse from $texturegroup
    qc = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', qc, flags=re.MULTILINE)
    qc = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', qc, flags=re.MULTILINE)
    
    # Remove hands/ cdmaterials
    qc = re.sub(r'\$cdmaterials\s+"models\\weapons\\v_models\\hands\\"', '', qc, flags=re.IGNORECASE)
    qc = re.sub(r'\$cdmaterials\s+"models/weapons/v_models/hands/"', '', qc, flags=re.IGNORECASE)
    
    # Remove $sectionframes
    qc = re.sub(r'\$sectionframes[^\n]*\n', '', qc, flags=re.IGNORECASE)
    
    # Add $include c_arms_definebones.qci before first $sequence
    if '$include "c_arms_definebones.qci"' not in qc:
        include_line = '$include "c_arms_definebones.qci"\n\n'
        seq_match = re.search(r'\$sequence', qc, re.IGNORECASE)
        if seq_match:
            qc = qc[:seq_match.start()] + include_line + qc[seq_match.start():]
    
    # Add $bonemerge for c_arms bones (after last $definebone)
    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_L_Clavicle"', qc, re.IGNORECASE):
        bonemerge_block = '\n' + '\n'.join(f'$BoneMerge "{b}"' for b in BONEMERGE_BONES) + '\n'
        lines = qc.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, bonemerge_block)
            qc = '\n'.join(lines)
    
    with open(qc_path, 'w') as f:
        f.write(qc)

def process_weapon(weapon, ref_bones):
    """Process a single weapon: copy, edit SMDs, update QC."""
    src_dir = DECOMPILE_DIR / weapon
    dst_dir = COMPILE_DIR / weapon / "source"
    
    if not src_dir.exists():
        return False, "no decompile dir"
    
    # Copy all files
    if dst_dir.exists():
        shutil.rmtree(dst_dir)
    shutil.copytree(src_dir, dst_dir)
    
    # Copy c_arms_definebones.qci
    if C_ARMS_QCI.exists():
        shutil.copy2(C_ARMS_QCI, dst_dir / "c_arms_definebones.qci")
    
    # Process all SMD files
    smd_count = 0
    for smd_file in list(dst_dir.glob("*.smd")):
        with open(smd_file, 'r', errors='ignore') as f:
            content = f.read()
        
        # 1. Remove BF3 procedural bones
        content = remove_bf3_procedural_bones(content)
        
        # 2. Strip hand mesh triangles
        content, stripped = strip_hand_triangles(content)
        
        # 3. Fix bone rolls (align to c_arms_citizen reference)
        content = fix_bone_rolls(content, ref_bones)
        
        with open(smd_file, 'w') as f:
            f.write(content)
        smd_count += 1
    
    # Process animation SMDs
    anims_dir = dst_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd_file in anims_dir.glob("*.smd"):
            with open(smd_file, 'r', errors='ignore') as f:
                content = f.read()
            content = remove_bf3_procedural_bones(content)
            content, _ = strip_hand_triangles(content)
            content = fix_bone_rolls(content, ref_bones)
            with open(smd_file, 'w') as f:
                f.write(content)
    
    # Update QC
    qc_path = dst_dir / f"{weapon}.qc"
    if qc_path.exists():
        update_qc(qc_path, weapon)
    
    return True, f"{smd_count} SMDs processed"

def main():
    print("=" * 70)
    print("Step 4: Mesh & Skeleton Editing (SMD processing)")
    print("=" * 70)
    
    ref_bones = parse_c_arms_reference()
    print(f"Loaded {len(ref_bones)} reference bone rotations from c_arms_citizen.smd")
    
    weapons = sorted([d.name for d in DECOMPILE_DIR.iterdir() if d.is_dir() and not d.name.startswith('.')])
    print(f"Processing {len(weapons)} weapons...\n")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        ok, msg = process_weapon(weapon, ref_bones)
        status = "OK  " if ok else "FAIL"
        print(f"  [{i:2d}/{len(weapons)}] {status} {weapon}: {msg}")
        if ok: success += 1
    
    print(f"\n{'='*70}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'='*70}")

if __name__ == "__main__":
    main()
