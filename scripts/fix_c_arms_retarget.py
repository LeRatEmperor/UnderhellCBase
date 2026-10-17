#!/usr/bin/env python3
"""
fix_c_arms_retarget.py — Retargets BF3 weapon models to use the standard
GMod c_arms_citizen skeleton instead of BF3's hand bone orientations.

For each weapon:
1. Parse the c_arms_citizen.smd reference to get the standard bone definitions
2. Replace the BF3 hand bone definitions (in QC $definebone lines + SMD skeleton sections)
   with the c_arms_citizen values
3. Add the Spine4 root bone (c_arms_citizen has Clavicles as children of Spine4)
4. Strip hand bone keyframes from animation SMDs (so bonemerge takes full control)
5. Clean up QC: remove v_hands/sleeve_diffuse from $texturegroup, remove hands/ from $cdmaterials
6. Write new SMD files + updated QC

The weapon mesh is weighted to bone 52 (Weapon), which is unchanged, so the weapon
mesh stays in the same world position. Only the hand bones (used for bonemerge)
get the new orientations.
"""
import os
import re
import math
import shutil
from pathlib import Path
from collections import OrderedDict

# ============================================================================
# CONFIGURATION
# ============================================================================
COMPILE_DIR = Path("/home/z/my-project/compile")
C_ARMS_REFERENCE = Path("/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd")

# ============================================================================
# PARSE THE c_arms_citizen.smd REFERENCE
# ============================================================================
def parse_c_arms_reference(ref_path):
    """Parse c_arms_citizen.smd and return:
        bone_defs: { bone_name: (parent_name, px, py, pz, rx, ry, rz) }
                    (positions/rotations in RADIANS, as stored in SMD)
        bone_ids: { bone_id: bone_name }
    """
    bone_ids = OrderedDict()  # id -> name
    bone_parents = {}  # id -> parent_id (or -1)
    bone_defs = OrderedDict()  # name -> (parent_name, px, py, pz, rx, ry, rz)

    with open(ref_path, 'r', errors='ignore') as f:
        lines = f.readlines()

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
                bone_ids[bid] = name
                bone_parents[bid] = pid

    # Parse skeleton section (time 0 only — that's the rest pose)
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
            m = re.match(r'^\s*(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
            if m:
                bid = int(m.group(1))
                px, py, pz = float(m.group(2)), float(m.group(3)), float(m.group(4))
                rx, ry, rz = float(m.group(5)), float(m.group(6)), float(m.group(7))
                name = bone_ids.get(bid, f"unknown_{bid}")
                pid = bone_parents.get(bid, -1)
                parent_name = bone_ids.get(pid, "") if pid >= 0 else ""
                bone_defs[name] = (parent_name, px, py, pz, rx, ry, rz)

    return bone_defs, bone_ids


# ============================================================================
# IDENTIFY HAND BONES (the ones to replace with c_arms_citizen values)
# ============================================================================
# These bone name patterns cover all hand bones used by GMod's c_arms system.
HAND_BONE_PATTERNS = [
    r'^ValveBiped\.Bip01_[LR]_Clavicle$',
    r'^ValveBiped\.Bip01_[LR]_UpperArm$',
    r'^ValveBiped\.Bip01_[LR]_Forearm$',
    r'^ValveBiped\.Bip01_[LR]_Hand$',
    r'^ValveBiped\.Bip01_[LR]_Finger\d{1,2}$',  # Finger0, Finger01, Finger02, Finger1, Finger11, Finger12, etc.
    r'^ValveBiped\.Bip01_[LR]_ForeTwist\d?$',  # ForeTwist, ForeTwist1-6
    r'^ValveBiped\.Bip01_Spine4$',  # the root bone for clavicles
    r'^ValveBiped\.Bip01_[LR]_Wrist$',
    r'^ValveBiped\.Bip01_[LR]_Ulna$',
    # BF3 procedural bones (l_thumb_tip etc) — these need to be stripped entirely
    r'^[lr]_thumb_(tip|mid|low)$',
    r'^[lr]_index_(tip|mid|low)$',
    r'^[lr]_middle_(tip|mid|low)$',
    r'^[lr]_ring_(tip|mid|low)$',
    r'^[lr]_pinky_(tip|mid|low)$',
    r'^[lr]_wrist$',
    r'^[lr]_armtwist_\d$',
    r'^[lr]_upperarm$',
]

def is_hand_bone(name):
    """Check if a bone is a hand bone (should be replaced/removed)."""
    for pat in HAND_BONE_PATTERNS:
        if re.match(pat, name, re.IGNORECASE):
            return True
    return False


def is_bf3_procedural_bone(name):
    """Check if a bone is a BF3 procedural bone (l_thumb_tip, r_armtwist_1, etc).
    These should be removed entirely — they don't exist in the c_arms_citizen skeleton.
    """
    return bool(re.match(r'^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$', name, re.IGNORECASE)
                or re.match(r'^[lr]_(wrist|armtwist_\d|upperarm)$', name, re.IGNORECASE))


# ============================================================================
# CONVERT ROTATIONS: RADIANS <-> DEGREES (for $definebone lines)
# ============================================================================
def rad_to_deg(r):
    return r * 180.0 / math.pi


def deg_to_rad(d):
    return d * math.pi / 180.0


# ============================================================================
# UPDATE THE QC FILE
# ============================================================================
def update_qc(qc_path, c_arms_bones, weapon_bones_in_smd):
    """Update the QC file:
    - Replace $definebone lines for hand bones with c_arms_citizen values
    - Remove BF3 procedural bone definitions
    - Add Spine4 if not present (root bone for Clavicles)
    - Remove v_hands/sleeve_diffuse from $texturegroup
    - Remove hands/ folder from $cdmaterials
    - Ensure $bonemerge for all hand bones
    """
    with open(qc_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content

    # ---- 1. Replace $definebone lines for hand bones ----
    # Find all $definebone lines and process them
    new_lines = []
    seen_bones = set()
    inserted_spine4 = False
    last_definebone_idx = -1

    lines = content.split('\n')
    for i, line in enumerate(lines):
        m = re.match(r'^\$definebone\s+"([^"]+)"\s+"([^"]*)"\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', line, re.IGNORECASE)
        if m:
            bone_name = m.group(1)
            parent_name = m.group(2)
            seen_bones.add(bone_name)
            last_definebone_idx = len(new_lines)

            if is_bf3_procedural_bone(bone_name):
                # Skip — BF3 procedural bone, doesn't exist in c_arms
                continue

            if bone_name in c_arms_bones and is_hand_bone(bone_name):
                # Replace with c_arms_citizen value
                parent, px, py, pz, rx, ry, rz = c_arms_bones[bone_name]
                # $definebone uses DEGREES for rotations
                # Format: name parent pos.x pos.y pos.z angles.x angles.y angles.z [realign pos+angles (6 floats, optional)]
                # We use 6 zeros for the realign block (matches the BF3 original format)
                new_line = (f'$definebone "{bone_name}" "{parent}" '
                            f'{px:.6f} {py:.6f} {pz:.6f} '
                            f'{rad_to_deg(rx):.6f} {rad_to_deg(ry):.6f} {rad_to_deg(rz):.6f} '
                            f'0 0 0 0 0 0')
                new_lines.append(new_line)
            else:
                # Keep the original line (weapon bones, attachments, etc.)
                new_lines.append(line)
        else:
            new_lines.append(line)

    content = '\n'.join(new_lines)

    # ---- 2. Add Spine4 if not present (root for Clavicles) ----
    if 'ValveBiped.Bip01_Spine4' not in seen_bones and 'ValveBiped.Bip01_Spine4' in c_arms_bones:
        # Insert after the last $definebone line
        parent, px, py, pz, rx, ry, rz = c_arms_bones['ValveBiped.Bip01_Spine4']
        spine4_def = (f'$definebone "ValveBiped.Bip01_Spine4" "" '
                      f'{px:.6f} {py:.6f} {pz:.6f} '
                      f'{rad_to_deg(rx):.6f} {rad_to_deg(ry):.6f} {rad_to_deg(rz):.6f} '
                      f'0 0 0 0 0 0')
        # Find the first $definebone line and insert before it
        lines = content.split('\n')
        for i, line in enumerate(lines):
            if line.startswith('$definebone'):
                lines.insert(i, spine4_def)
                break
        content = '\n'.join(lines)

    # ---- 3. Remove v_hands/sleeve_diffuse from $texturegroup ----
    content = re.sub(r'^[ \t]+"v_hands"[ \t]*\n', '', content, flags=re.MULTILINE)
    content = re.sub(r'^[ \t]+"sleeve_diffuse"[ \t]*\n', '', content, flags=re.MULTILINE)

    # ---- 4. Remove hands/ folder from $cdmaterials ----
    content = re.sub(r'\$cdmaterials[ \t]+"models\\weapons\\v_models\\hands\\"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)
    content = re.sub(r'\$cdmaterials[ \t]+"models/weapons/v_models/hands/"[ \t]*\n',
                     '', content, flags=re.IGNORECASE)

    # ---- 5. Ensure $bonemerge for all hand bones ----
    # (the existing QC already has these, but add Spine4 if missing)
    if 'ValveBiped.Bip01_Spine4' in c_arms_bones:
        if not re.search(r'\$bonemerge\s+"ValveBiped\.Bip01_Spine4"', content, re.IGNORECASE):
            # Insert after the first $bonemerge line
            content = re.sub(
                r'(\$BoneMerge\s+"ValveBiped\.Bip01_L_Clavicle")',
                f'$BoneMerge "ValveBiped.Bip01_Spine4"\n\\1',
                content, count=1, flags=re.IGNORECASE
            )

    if content != original:
        with open(qc_path, 'w') as f:
            f.write(content)
        return True
    return False


# ============================================================================
# UPDATE A SMD FILE: replace hand bone definitions in skeleton + nodes sections
# ============================================================================
def update_smd(smd_path, c_arms_bones, is_anim=False):
    """Update an SMD file:
    - Replace hand bone positions/rotations in the skeleton section with c_arms_citizen values
    - Remove BF3 procedural bones (l_thumb_tip, r_armtwist_*, etc.)
    - For animation SMDs: strip keyframes for hand bones (so bonemerge overrides)
    """
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()

    # First, parse the nodes section to find the bone IDs and names
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
            continue
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                bone_id_to_name[bid] = name
                bone_name_to_id[name] = bid

    # Identify which bone IDs are hand bones (to be stripped from anims)
    hand_bone_ids = set()
    bf3_procedural_ids = set()
    for bid, name in bone_id_to_name.items():
        if is_hand_bone(name):
            hand_bone_ids.add(bid)
        if is_bf3_procedural_bone(name):
            bf3_procedural_ids.add(bid)

    # Now process the file
    new_lines = []
    in_skeleton = False
    in_triangles = False
    changes = 0
    nodes_to_remove = set()

    # Identify BF3 procedural bones to remove from nodes section entirely
    for bid, name in bone_id_to_name.items():
        if is_bf3_procedural_bone(name):
            nodes_to_remove.add(bid)

    for line in lines:
        s = line.strip()

        # Skip nodes section entries for BF3 procedural bones
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
                if bid in nodes_to_remove:
                    changes += 1
                    continue  # skip this bone
        new_lines.append(line)

    # Re-parse the file (after node removal)
    lines = new_lines
    new_lines = []

    # Now process the skeleton section
    in_skeleton = False
    in_time_block = False
    for line in lines:
        s = line.strip()

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

        # In skeleton section
        if s.startswith('time'):
            new_lines.append(line)
            continue

        # Bone entry line: <id> <px> <py> <pz> <rx> <ry> <rz>
        m = re.match(r'^\s*(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                     r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
        if m:
            bid = int(m.group(1))
            name = bone_id_to_name.get(bid, '')

            # Skip BF3 procedural bones entirely (they were also removed from nodes)
            if bid in nodes_to_remove:
                changes += 1
                continue

            # If this is an animation SMD, strip hand bone keyframes (bonemerge will handle them)
            if is_anim and bid in hand_bone_ids:
                changes += 1
                continue

            # If this is a reference SMD, replace hand bone positions/rotations with c_arms values
            if not is_anim and name in c_arms_bones and is_hand_bone(name):
                parent, px, py, pz, rx, ry, rz = c_arms_bones[name]
                # SMD skeleton uses RADIANS (same as c_arms_citizen.smd)
                new_line = (f'\t{bid} {px:.6f} {py:.6f} {pz:.6f} '
                            f'{rx:.6f} {ry:.6f} {rz:.6f}\n')
                new_lines.append(new_line)
                changes += 1
                continue

        new_lines.append(line)

    if changes > 0:
        with open(smd_path, 'w') as f:
            f.writelines(new_lines)
        return changes
    return 0


# ============================================================================
# MAIN PROCESSING
# ============================================================================
def fix_weapon(weapon_dir, c_arms_bones):
    weapon = weapon_dir.name
    src_dir = weapon_dir / "source"

    if not src_dir.exists():
        print(f"  SKIP {weapon}: no source dir")
        return False

    qc = src_dir / f"{weapon}.qc"
    if not qc.exists():
        print(f"  SKIP {weapon}: no QC file")
        return False

    print(f"\nProcessing {weapon}...")

    # 1. Update the QC
    if update_qc(qc, c_arms_bones, set()):
        print(f"  Updated QC (replaced hand bone defs, cleaned texturegroup/cdmaterials)")

    # 2. Update reference SMDs (bodygroup meshes)
    for smd in sorted(src_dir.glob("*.smd")):
        changes = update_smd(smd, c_arms_bones, is_anim=False)
        if changes:
            print(f"  {smd.name}: {changes} hand bone entries replaced/removed")

    # 3. Update animation SMDs (strip hand bone keyframes)
    anims_dir = src_dir / f"{weapon}_anims"
    if anims_dir.exists():
        for smd in sorted(anims_dir.glob("*.smd")):
            changes = update_smd(smd, c_arms_bones, is_anim=True)
            if changes:
                print(f"  {smd.parent.name}/{smd.name}: stripped {changes} hand bone keyframes")

    return True


def main():
    print("=" * 70)
    print("fix_c_arms_retarget.py — Retarget BF3 weapons to c_arms_citizen skeleton")
    print("=" * 70)

    if not C_ARMS_REFERENCE.exists():
        print(f"ERROR: c_arms_citizen.smd reference not found at {C_ARMS_REFERENCE}")
        return

    print(f"\nParsing c_arms_citizen.smd reference...")
    c_arms_bones, c_arms_ids = parse_c_arms_reference(C_ARMS_REFERENCE)
    print(f"  Found {len(c_arms_bones)} bones in c_arms_citizen:")
    for name, (parent, px, py, pz, rx, ry, rz) in list(c_arms_bones.items())[:5]:
        print(f"    {name} (parent: {parent or 'ROOT'})")
    print(f"    ... and {len(c_arms_bones) - 5} more")

    # Process each weapon
    for weapon_dir in sorted(COMPILE_DIR.iterdir()):
        if not weapon_dir.is_dir():
            continue
        if weapon_dir.name == "Battlefield3":
            continue
        fix_weapon(weapon_dir, c_arms_bones)

    print("\n" + "=" * 70)
    print("Done! Next step: recompile all weapons with studiomdl")
    print("=" * 70)


if __name__ == "__main__":
    main()
