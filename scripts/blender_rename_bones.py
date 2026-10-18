#!/usr/bin/env python3
"""
rename_bones_and_add_qci.py — Rename BF3 bones to ValveBiped names and add 
$include "c_arms_definebones.qci" to QC files.

This is a text-processing script (no Blender needed for the renaming itself).
Blender is used separately for visual verification.
"""
import os
import re
import sys
import shutil
from pathlib import Path

# Import the BONE_MAP from full_pipeline
sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map

DECOMPILE_DIR = "/home/z/my-project/decompile"
COMPILE_DIR = "/home/z/my-project/compile"


def get_all_bone_names(weapon_dir):
    """Get all unique bone names from all SMDs in a weapon's decompile folder."""
    bone_names = set()
    for root, dirs, files in os.walk(weapon_dir):
        for f in files:
            if f.endswith('.smd'):
                path = os.path.join(root, f)
                with open(path, 'r', errors='ignore') as fh:
                    in_nodes = False
                    for line in fh:
                        s = line.strip()
                        if s == 'nodes':
                            in_nodes = True
                            continue
                        if s == 'end' and in_nodes:
                            in_nodes = False
                            break
                        if in_nodes:
                            m = re.match(r'^\s*\d+\s+"([^"]+)"', s)
                            if m:
                                bone_names.add(m.group(1))
    return bone_names


def is_bf3_procedural(name):
    """Check if a bone is a BF3 procedural bone that should be removed."""
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE)
                or re.match(r'^[lr]-(upperarm|forearm|wrist)$', name, re.IGNORECASE)
                or re.match(r'^[lr]wrist$', name, re.IGNORECASE)
                or re.match(r'^[lr]-rist$', name, re.IGNORECASE))


def is_non_essential_bone(name):
    """Check if a bone is non-essential (ForeTwist, IK helpers) and can be removed."""
    if re.match(r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$', name, re.IGNORECASE): return True
    if re.match(r'^ik_hand', name, re.IGNORECASE): return True
    if re.match(r'^b_wpn_', name, re.IGNORECASE): return True
    return False


def remove_procedural_bones_from_smd(smd_path):
    """Remove BF3 procedural and non-essential bones from an SMD's nodes and skeleton sections."""
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
    
    bones_to_remove = set()
    for bid, name in bone_id_to_name.items():
        if is_bf3_procedural(name) or is_non_essential_bone(name):
            bones_to_remove.add(bid)
    
    if not bones_to_remove:
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
            if m and int(m.group(1)) in bones_to_remove:
                changes += 1; continue
            new_lines.append(line); continue
        
        if s == 'skeleton': in_skeleton = True; new_lines.append(line); continue
        if s == 'end' and in_skeleton: in_skeleton = False; new_lines.append(line); continue
        if in_skeleton:
            m = re.match(r'^(\s*)(\d+)\s+', s)
            if m and int(m.group(2)) in bones_to_remove:
                changes += 1; continue
        new_lines.append(line)
    
    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
    return changes


def build_weapon_bone_map(weapon_dir):
    """Build a complete bone name mapping for a weapon."""
    bone_map = build_bone_map()
    
    # Add weapon-specific finger mappings (Left1-15, Right1-15)
    bone_hierarchy = {}
    for root, dirs, files in os.walk(weapon_dir):
        for f in files:
            if f.endswith('.smd'):
                path = os.path.join(root, f)
                with open(path, 'r', errors='ignore') as fh:
                    content = fh.read()
                for m in re.finditer(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', content, re.MULTILINE):
                    bone_hierarchy[int(m.group(1))] = (m.group(2), int(m.group(3)))
    
    weapon_bone_map = dict(bone_map)
    
    # Add additional bone name variants
    for sl, side in [("l", "L"), ("r", "R")]:
        # l-upperarm-movement -> don't rename (it's a helper bone)
        # lwrist -> ValveBiped.Bip01_L_Hand
        weapon_bone_map[f"{sl}wrist"] = f"ValveBiped.Bip01_{side}_Hand"
        weapon_bone_map[f"{sl}-rist"] = f"ValveBiped.Bip01_{side}_Hand"
        weapon_bone_map[f"{sl}-forearm-twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        weapon_bone_map[f"{sl}_forearm_twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
    
    # Add numbered finger mappings (Left1-15, Right1-15)
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
    
    return weapon_bone_map


def rename_bones_in_text(content, bone_map):
    """Rename bones in text content. Skip BF3 procedural bones."""
    for old, new in sorted(bone_map.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        if is_bf3_procedural(old):
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content


def process_weapon(weapon):
    """Process a single weapon: rename bones in all SMD/QC files."""
    src_dir = os.path.join(DECOMPILE_DIR, weapon)
    dst_dir = os.path.join(COMPILE_DIR, weapon, "source")
    
    if not os.path.isdir(src_dir):
        print(f"  SKIP {weapon}: no decompile folder")
        return False
    
    # Create destination
    if os.path.exists(dst_dir):
        import shutil
        shutil.rmtree(dst_dir)
    os.makedirs(dst_dir, exist_ok=True)
    
    # Copy all files
    import shutil
    for item in os.listdir(src_dir):
        src_path = os.path.join(src_dir, item)
        dst_path = os.path.join(dst_dir, item)
        if os.path.isdir(src_path):
            shutil.copytree(src_path, dst_path)
        else:
            shutil.copy2(src_path, dst_path)
    
    qc_path = os.path.join(dst_dir, f"{weapon}.qc")
    if not os.path.exists(qc_path):
        print(f"  SKIP {weapon}: no QC file")
        return False
    
    print(f"\n  {weapon}:")
    
    # Build bone map
    bone_map = build_weapon_bone_map(src_dir)
    
    # Get all bone names to see what we're working with
    all_bones = get_all_bone_names(src_dir)
    hand_bones = [b for b in all_bones if not is_bf3_procedural(b) and 
                  ('Clavicle' in b or 'UpperArm' in b or 'Forearm' in b or 'Hand' in b or 
                   'Finger' in b or 'wrist' in b.lower() or 'upperarm' in b.lower() or
                   'forearm' in b.lower() or 'hand' in b.lower())]
    
    # Apply bone renaming to all SMD and QC files
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            path = os.path.join(root, f)
            if f.endswith((".smd", ".qc", ".qci")):
                try:
                    with open(path, "r", errors="ignore") as fh:
                        content = fh.read()
                    content = rename_bones_in_text(content, bone_map)
                    if f.endswith(".qc"):
                        # Rename model to c_<weapon>
                        content = re.sub(r'\$modelname\s+"[^"]*"',
                                        f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
                        # Remove $sectionframes
                        content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
                        # Add $include "c_arms_definebones.qci" after $bodygroup section
                        # Insert before $definebone lines (or before $sequence)
                        if '$include "c_arms_definebones.qci"' not in content:
                            # Find a good insertion point (after $surfaceprop or $cdmaterials)
                            insert_after = '$surfaceprop'
                            match = re.search(r'(\$surfaceprop[^\n]*\n)', content, re.IGNORECASE)
                            if match:
                                content = content[:match.end()] + '\n$include "c_arms_definebones.qci"\n' + content[match.end():]
                            else:
                                # Insert before $definebone or $sequence
                                match = re.search(r'(\$definebone|\$sequence)', content, re.IGNORECASE)
                                if match:
                                    content = content[:match.start()] + '$include "c_arms_definebones.qci"\n\n' + content[match.start():]
                                else:
                                    content += '\n$include "c_arms_definebones.qci"\n'
                        
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
                                         '// REMOVED: hands bodygroup (c_hands provides arm mesh)',
                                         content, flags=re.IGNORECASE | re.DOTALL)
                    
                    with open(path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    print(f"    WARN: {f}: {e}")
    
    # Read the QCI bone list to know which $definebone lines to REMOVE from the QC
    qci_bones = set()
    qci_path = "/tmp/c_arms_extract/medkit/c_arms_definebones.qci"
    with open(qci_path, 'r') as f:
        for line in f:
            m = re.match(r'^\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
            if m:
                qci_bones.add(m.group(1))
    
    # Copy c_arms_definebones.qci to the source folder
    qci_dst = os.path.join(dst_dir, "c_arms_definebones.qci")
    shutil.copy2(qci_path, qci_dst)
    # Remove $illumposition from QCI (conflicts with QC)
    with open(qci_dst, "r") as qf:
        qci_content = qf.read()
    qci_content = re.sub(r"^\$illumposition[^\n]*\n", "", qci_content, flags=re.MULTILINE)
    with open(qci_dst, "w") as qf:
        qf.write(qci_content)
    
    # Remove $definebone lines from QC that are also in the QCI (avoid duplicates)
    # Also remove BF3 procedural bone $definebone lines
    # Also remove non-essential bones (ForeTwist) if over 128 limit
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".qc"):
                path = os.path.join(root, f)
                with open(path, 'r', errors='ignore') as fh:
                    content = fh.read()
                
                # Remove $definebone lines for bones that are in the QCI
                lines = content.split('\n')
                new_lines = []
                for line in lines:
                    m = re.match(r'^\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
                    if m:
                        bone_name = m.group(1)
                        # Remove if it's in the QCI (avoid duplicates)
                        if bone_name in qci_bones:
                            continue
                        # Remove BF3 procedural bones
                        if is_bf3_procedural(bone_name):
                            continue
                        # Remove ForeTwist bones (not in c_arms, save bone count)
                        if re.match(r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$', bone_name, re.IGNORECASE):
                            continue
                    new_lines.append(line)
                content = '\n'.join(new_lines)
                
                # Remove $attachment lines referencing removed bones
                lines = content.split('\n')
                new_lines = []
                removed_bone_names = qci_bones | {b for b in all_bones if is_bf3_procedural(b)}
                for line in lines:
                    m = re.match(r'^\$attachment\s+"[^"]*"\s+"([^"]+)"', line, re.IGNORECASE)
                    if m:
                        bone = m.group(1)
                        if bone in removed_bone_names or is_bf3_procedural(bone):
                            continue
                    new_lines.append(line)
                content = '\n'.join(new_lines)
                
                with open(path, 'w') as fh:
                    fh.write(content)
    
    # Strip v_hands mesh from all SMDs AND remove procedural/ForeTwist bones from SMDs
    for root, dirs, files in os.walk(dst_dir):
        for f in files:
            if f.endswith(".smd"):
                smd_path = os.path.join(root, f)
                # Remove procedural bones from SMD
                remove_procedural_bones_from_smd(smd_path)
                # Strip v_hands mesh
                strip_v_hands_from_smd(smd_path)
    
    print(f"    Bones renamed + $include c_arms_definebones.qci added + v_hands stripped")
    return True


def strip_v_hands_from_smd(smd_path):
    """Strip v_hands/sleeve_diffuse triangle blocks from an SMD file."""
    HAND_MATERIALS = {"v_hands", "sleeve_diffuse", "sleeve_diff", "t_phoenix"}
    
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    
    tri_match = re.search(r'^triangles\s*\n', content, re.MULTILINE)
    if not tri_match:
        return 0
    tri_start = tri_match.end()
    end_match = re.search(r'^end\s*$', content[tri_start:], re.MULTILINE)
    if not end_match:
        return 0
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
    if new_str:
        new_str += '\n'
    
    if stripped > 0:
        with open(smd_path, 'w') as f:
            f.write(content[:tri_start] + new_str + content[tri_end:])
    return stripped


def main():
    argv = sys.argv
    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []
    
    # If a weapon name is passed, only process that weapon
    if argv:
        weapons = argv
    else:
        weapons = sorted([d for d in os.listdir(DECOMPILE_DIR) 
                          if os.path.isdir(os.path.join(DECOMPILE_DIR, d))])
    
    print(f"{'='*60}")
    print(f"Processing {len(weapons)} weapons")
    print(f"{'='*60}")
    
    success = 0
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        if process_weapon(weapon):
            success += 1
    
    print(f"\n{'='*60}")
    print(f"SUCCESS: {success}/{len(weapons)}")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()
