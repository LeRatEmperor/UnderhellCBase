#!/usr/bin/env python3
"""
simple_c_hands.py — Minimal c_hands conversion for BF3 weapons.

This is the SIMPLEST approach that produces STABLE c_hands:
1. Rename BF3 bones to ValveBiped.Bip01_* (so bonemerge can find them)
2. REMOVE BF3 procedural bones (l_thumb_tip etc.) to avoid duplicate names
3. Add $bonemerge for all hand bones (so c_arms can attach)
4. Strip v_hands/sleeve_diffuse mesh triangles (so old hand mesh doesn't render)
5. Clean QC (remove v_hands material refs, hands cdmaterials, hands bodygroup)
6. DO NOT change bone positions or rotations
7. DO NOT add Spine4 or reparent Clavicles
8. DO NOT re-bake animations

The c_arms will bonemerge onto the BF3 bones (which have BF3-specific rotations).
The fingers will look wrong (twisted), but the c_arms will be STABLE:
- No "fly away" after animations (bind pose unchanged)
- No "missing c_hands" (bonemerge configured)
- No "old hand mesh" (v_hands stripped)
- Animations work correctly (no re-baking)

The finger rotation issue requires the Ghosts-style hybrid approach,
which is more complex and will be addressed separately.
"""
import os
import re
import shutil
import sys
from pathlib import Path

# Import the BONE_MAP from full_pipeline
sys.path.insert(0, '/home/z/my-project/scripts')
from full_pipeline import build_bone_map, BONE_MAP

DECOMPILE_DIR = Path("/home/z/my-project/decompile")
COMPILE_DIR = Path("/home/z/my-project/compile")

# All 38 hand bones that need $bonemerge
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

# BF3 procedural bone patterns to REMOVE (not rename)
BF3_PROCEDURAL_PATTERNS = [
    r'^[lr]_thumb_(tip|mid|low)$',
    r'^[lr]_index_(tip|mid|low)$',
    r'^[lr]_middle_(tip|mid|low)$',
    r'^[lr]_ring_(tip|mid|low)$',
    r'^[lr]_pinky_(tip|mid|low)$',
    r'^[lr]_wrist$',
    r'^[lr]_armtwist_\d$',
    r'^[lr]_upperarm$',
    r'^[lr]-upperarm$',
    r'^[lr]-forearm$',
    r'^[lr]_upperarm$',
    r'^[lr]_wrist$',
    r'^[lr]-wrist$',
]

HAND_MATERIALS = {"v_hands", "sleeve_diffuse", "sleeve_diff", "t_phoenix"}


def is_bf3_procedural_bone(name):
    """Check if a bone is a BF3 procedural bone that should be REMOVED (not renamed)."""
    for pat in BF3_PROCEDURAL_PATTERNS:
        if re.match(pat, name, re.IGNORECASE):
            return True
    return False


def rename_bones_in_text(content, bone_map):
    """Rename bones in text content. SKIP BF3 procedural bones (they'll be removed later)."""
    for old, new in sorted(bone_map.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        # Skip BF3 procedural bones - they should be removed, not renamed
        if is_bf3_procedural_bone(old):
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content


def remove_bf3_procedural_bones_from_smd(smd_path):
    """Remove BF3 procedural bones from an SMD's nodes and skeleton sections."""
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # Parse the nodes section to find BF3 procedural bone IDs
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

    # Find bone IDs to remove (BF3 procedural bones)
    bones_to_remove = set()
    for bid, name in bone_id_to_name.items():
        if is_bf3_procedural_bone(name):
            bones_to_remove.add(bid)

    if not bones_to_remove:
        return 0

    # Process the file - remove nodes and skeleton entries for these bones
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
                    continue  # Skip this bone
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
            # Check if this is a bone entry for a removed bone
            m = re.match(r'^(\s*)(\d+)\s+', s)
            if m:
                bid = int(m.group(2))
                if bid in bones_to_remove:
                    changes += 1
                    continue  # Skip this bone entry
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


def update_qc(qc_path):
    """Update the QC file:
    - Remove v_hands/sleeve_diffuse from $texturegroup
    - Remove hands/ from $cdmaterials
    - Remove hands bodygroup
    - Remove $definebone lines for BF3 procedural bones
    - Add $bonemerge for all hand bones
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content

    # 1. Remove v_hands/sleeve_diffuse from $texturegroup
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)

    # 2. Remove hands/ cdmaterials
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)

    # 3. Remove hands bodygroup
    content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                     '// REMOVED: hands bodygroup (c_hands provides arm mesh)',
                     content, flags=re.IGNORECASE | re.DOTALL)

    # 4. Remove $definebone lines for BF3 procedural bones
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        m = re.match(r'^\$definebone\s+"([^"]+)"', line, re.IGNORECASE)
        if m:
            bone_name = m.group(1)
            if is_bf3_procedural_bone(bone_name):
                continue  # Skip this bone
        new_lines.append(line)
    content = '\n'.join(new_lines)

    # 5. Add $bonemerge for all hand bones (if not already present)
    if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_L_Clavicle"', content, re.IGNORECASE):
        bonemerge_block = '\n' + '\n'.join(f'$BoneMerge "{b}"' for b in BONEMERGE_BONES) + '\n'
        # Insert after the last $definebone line
        lines = content.split('\n')
        last_db = -1
        for i, line in enumerate(lines):
            if '$definebone' in line.lower():
                last_db = i
        if last_db >= 0:
            lines.insert(last_db + 1, bonemerge_block)
            content = '\n'.join(lines)
        else:
            # No $definebone lines, insert after $body or $bodygroup section
            content += bonemerge_block

    if content != original:
        with open(qc_path, 'w') as f:
            f.write(content)
        return True
    return False


def convert_weapon(weapon):
    """Convert a single BF3 weapon - minimal approach."""
    src_dir = DECOMPILE_DIR / weapon
    dst_dir = COMPILE_DIR / weapon / "source"

    if not src_dir.exists():
        print(f"  SKIP {weapon}: no decompile folder")
        return False

    # Create destination
    if dst_dir.exists():
        shutil.rmtree(dst_dir)
    dst_dir.mkdir(parents=True)

    # Copy all files
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

    # Step 1: Rename bones (skip BF3 procedural bones)
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
                    print(f"    WARN: failed to rename bones in {f}: {e}")

    print(f"    Bones renamed")

    # Step 2: Remove BF3 procedural bones from SMDs
    for smd in dst_dir.glob("*.smd"):
        remove_bf3_procedural_bones_from_smd(smd)
    anims_dir = dst_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in anims_dir.glob("*.smd"):
            remove_bf3_procedural_bones_from_smd(smd)
    print(f"    BF3 procedural bones removed")

    # Step 3: Update QC (bonemerge, strip materials, remove hands bodygroup)
    update_qc(qc_path)
    print(f"    QC updated (bonemerge + material cleanup)")

    # Step 4: Strip v_hands mesh from all SMDs
    for smd in dst_dir.glob("*.smd"):
        stripped = strip_hand_triangles_from_smd(smd)
    if anims_dir.exists():
        for smd in anims_dir.glob("*.smd"):
            strip_hand_triangles_from_smd(smd)
    print(f"    v_hands mesh stripped")

    return True


def main():
    print("=" * 70)
    print("simple_c_hands.py — Minimal c_hands conversion")
    print("Keeps BF3 bones as-is, adds bonemerge, strips v_hands mesh")
    print("=" * 70)

    weapons = sorted([d.name for d in DECOMPILE_DIR.iterdir()
                      if d.is_dir() and not d.name.startswith('.')
                      and d.name not in {'ghosts_m27_lmg', 'm416_prev_compiled', 'm416_check_bonemerge',
                                          'm416_verify', 'scotia_c_arms_ref', 'test_minimal_check'}])
    print(f"\nFound {len(weapons)} weapons")

    success = 0
    for i, weapon in enumerate(weapons, 1):
        print(f"\n[{i}/{len(weapons)}] {weapon}")
        try:
            if convert_weapon(weapon):
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
