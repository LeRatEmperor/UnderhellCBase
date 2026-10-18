#!/usr/bin/env python3
"""
full_pipeline.py — Runs the complete BF3 c_hands pipeline:
  1. Decompile all 32 weapons with Crowbar
  2. Convert to c_hands (bone rename + hands bodygroup removal + bonemerge)
  3. Compile all 32 weapons with studiomdl

This version applies ONLY the bonemerge fix — does NOT strip hand triangles
or add $upaxis Y (those broke the rendering).
"""

import os, sys, shutil, subprocess, re, time

BF3_MODELS = "/home/z/my-project/repos/bf3_weapons/models/bf3/weapons"
DECOMPILE_DIR = "/home/z/my-project/decompile"
COMPILE_DIR = "/home/z/my-project/compile"
STUDIOMDL = "/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl"
LD_LIB_PATH = "/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64"
PYTHON = "/home/z/.venv/bin/python3"
ENV = {
    "DOTNET_ROOT": "/home/z/my-project/tools/dotnet",
    "PYTHONNET_RUNTIME": "coreclr",
    "PATH": "/home/z/my-project/tools/dotnet:" + os.environ.get("PATH", ""),
}

# ============================================================
# BONE MAPPING
# ============================================================
def build_bone_map():
    bm = {}
    short_base = {
        "L Clavicle": "ValveBiped.Bip01_L_Clavicle", "L UpperArm": "ValveBiped.Bip01_L_UpperArm",
        "L Forearm": "ValveBiped.Bip01_L_Forearm", "L Hand": "ValveBiped.Bip01_L_Hand",
        "R Clavicle": "ValveBiped.Bip01_R_Clavicle", "R UpperArm": "ValveBiped.Bip01_R_UpperArm",
        "R Forearm": "ValveBiped.Bip01_R_Forearm", "R Hand": "ValveBiped.Bip01_R_Hand",
        "Pelvis": "ValveBiped.Bip01_Pelvis", "Spine": "ValveBiped.Bip01_Spine",
        "Spine1": "ValveBiped.Bip01_Spine1", "Spine2": "ValveBiped.Bip01_Spine2",
        "Spine4": "ValveBiped.Bip01_Spine4", "Neck": "ValveBiped.Bip01_Neck1",
        "Neck1": "ValveBiped.Bip01_Neck1", "Head1": "ValveBiped.Bip01_Head1",
    }
    for side in ["L", "R"]:
        for finger in range(5):
            for seg in range(3):
                if seg == 0:
                    short_base[f"{side} Finger{finger}"] = f"ValveBiped.Bip01_{side}_Finger{finger}"
                else:
                    short_base[f"{side} Finger{finger}{seg}"] = f"ValveBiped.Bip01_{side}_Finger{finger}{seg}"
        short_base[f"{side} ForeTwist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        for i in range(1, 8):
            short_base[f"{side} ForeTwist{i}"] = f"ValveBiped.Bip01_{side}_ForeTwist{i}"
    bm.update(short_base)
    for short, vb in short_base.items():
        bm[f"Bip01 {short}"] = vb
    bm["Bip01"] = "ValveBiped.Bip01"
    bm["Bip01 Pelvis"] = "ValveBiped.Bip01_Pelvis"
    bm["Bip01 Spine"] = "ValveBiped.Bip01_Spine"
    bm["Bip01 Spine1"] = "ValveBiped.Bip01_Spine1"
    bm["Bip01 Neck"] = "ValveBiped.Bip01_Neck1"
    # b_ch_* style
    b_ch = {"b_ch_l_clavical": "ValveBiped.Bip01_L_Clavicle", "b_ch_l_upperarm": "ValveBiped.Bip01_L_UpperArm",
            "b_ch_l_forearm": "ValveBiped.Bip01_L_Forearm", "b_ch_l_hand": "ValveBiped.Bip01_L_Hand",
            "b_ch_r_clavical": "ValveBiped.Bip01_R_Clavicle", "b_ch_r_upperarm": "ValveBiped.Bip01_R_UpperArm",
            "b_ch_r_forearm": "ValveBiped.Bip01_R_Forearm", "b_ch_r_hand": "ValveBiped.Bip01_R_Hand",
            "b_ch_spine1": "ValveBiped.Bip01_Spine1", "b_ch_spine2": "ValveBiped.Bip01_Spine2", "b_root": "ValveBiped.Bip01"}
    for sl, side in [("l", "L"), ("r", "R")]:
        for finger in range(5):
            for segment in range(3):
                bf3 = f"b_ch_{sl}_finger_{finger}{segment}"
                vb = f"ValveBiped.Bip01_{side}_Finger{finger}" + (str(segment) if segment > 0 else "")
                b_ch[bf3] = vb
        for i in range(1, 8):
            b_ch[f"b_ch_{sl}_forearm_twist{i}"] = f"ValveBiped.Bip01_{side}_ForeTwist{i}"
    bm.update(b_ch)
    # l-/r- style
    fwords = {"thumb": 0, "index": 1, "middle": 2, "ring": 3, "pinky": 4}
    swords = {"low": "", "mid": "1", "tip": "2"}
    for sl, side in [("l", "L"), ("r", "R")]:
        bm[f"{sl}-upperarm"] = f"ValveBiped.Bip01_{side}_UpperArm"
        bm[f"{sl}-forearm"] = f"ValveBiped.Bip01_{side}_Forearm"
        bm[f"{sl}_upperarm"] = f"ValveBiped.Bip01_{side}_UpperArm"
        bm[f"{sl}_wrist"] = f"ValveBiped.Bip01_{side}_Hand"
        # Additional variants for weapons like sv98/mp412 that use no separator
        bm[f"{sl}wrist"] = f"ValveBiped.Bip01_{side}_Hand"
        bm[f"{sl}-rist"] = f"ValveBiped.Bip01_{side}_Hand"  # typo in sv98: "r-rist"
        bm[f"{sl}-forearm-twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        bm[f"{sl}_forearm_twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        for fn, fnum in fwords.items():
            for sn, sseg in swords.items():
                bm[f"{sl}-{fn}-{sn}"] = f"ValveBiped.Bip01_{side}_Finger{fnum}{sseg}"
                bm[f"{sl}_{fn}_{sn}"] = f"ValveBiped.Bip01_{side}_Finger{fnum}{sseg}"
    bm["Left_U_Arm"] = "ValveBiped.Bip01_L_UpperArm"
    bm["Left_L_Arm"] = "ValveBiped.Bip01_L_Forearm"
    bm["Left_Hand"] = "ValveBiped.Bip01_L_Hand"
    bm["Right_U_Arm"] = "ValveBiped.Bip01_R_UpperArm"
    bm["Right_L_Arm"] = "ValveBiped.Bip01_R_Forearm"
    bm["Right_Hand"] = "ValveBiped.Bip01_R_Hand"
    return bm

BONE_MAP = build_bone_map()

BONEMERGE_LINES = """
$BoneMerge "ValveBiped.Bip01_L_Clavicle"
$BoneMerge "ValveBiped.Bip01_L_UpperArm"
$BoneMerge "ValveBiped.Bip01_L_Forearm"
$BoneMerge "ValveBiped.Bip01_L_Hand"
$BoneMerge "ValveBiped.Bip01_L_Finger0"
$BoneMerge "ValveBiped.Bip01_L_Finger01"
$BoneMerge "ValveBiped.Bip01_L_Finger02"
$BoneMerge "ValveBiped.Bip01_L_Finger1"
$BoneMerge "ValveBiped.Bip01_L_Finger11"
$BoneMerge "ValveBiped.Bip01_L_Finger12"
$BoneMerge "ValveBiped.Bip01_L_Finger2"
$BoneMerge "ValveBiped.Bip01_L_Finger21"
$BoneMerge "ValveBiped.Bip01_L_Finger22"
$BoneMerge "ValveBiped.Bip01_L_Finger3"
$BoneMerge "ValveBiped.Bip01_L_Finger31"
$BoneMerge "ValveBiped.Bip01_L_Finger32"
$BoneMerge "ValveBiped.Bip01_L_Finger4"
$BoneMerge "ValveBiped.Bip01_L_Finger41"
$BoneMerge "ValveBiped.Bip01_L_Finger42"
$BoneMerge "ValveBiped.Bip01_R_Clavicle"
$BoneMerge "ValveBiped.Bip01_R_UpperArm"
$BoneMerge "ValveBiped.Bip01_R_Forearm"
$BoneMerge "ValveBiped.Bip01_R_Hand"
$BoneMerge "ValveBiped.Bip01_R_Finger0"
$BoneMerge "ValveBiped.Bip01_R_Finger01"
$BoneMerge "ValveBiped.Bip01_R_Finger02"
$BoneMerge "ValveBiped.Bip01_R_Finger1"
$BoneMerge "ValveBiped.Bip01_R_Finger11"
$BoneMerge "ValveBiped.Bip01_R_Finger12"
$BoneMerge "ValveBiped.Bip01_R_Finger2"
$BoneMerge "ValveBiped.Bip01_R_Finger21"
$BoneMerge "ValveBiped.Bip01_R_Finger22"
$BoneMerge "ValveBiped.Bip01_R_Finger3"
$BoneMerge "ValveBiped.Bip01_R_Finger31"
$BoneMerge "ValveBiped.Bip01_R_Finger32"
$BoneMerge "ValveBiped.Bip01_R_Finger4"
$BoneMerge "ValveBiped.Bip01_R_Finger41"
$BoneMerge "ValveBiped.Bip01_R_Finger42"
"""

# ============================================================
# PHASE 1: DECOMPILE
# ============================================================
def decompile_all():
    models = sorted([f for f in os.listdir(BF3_MODELS) if f.endswith(".mdl") and not f.startswith("w_")])
    print(f"Phase 1: Decompiling {len(models)} weapons...")
    success = 0
    for mdl in models:
        weapon = os.path.splitext(mdl)[0]
        out_dir = os.path.join(DECOMPILE_DIR, weapon)
        if os.path.isdir(out_dir) and any(f.endswith(".smd") for f in os.listdir(out_dir)):
            success += 1
            continue
        result = subprocess.run([PYTHON, "/home/z/my-project/scripts/test_crowbar_decompile.py",
                                os.path.join(BF3_MODELS, mdl), weapon],
                               capture_output=True, text=True, timeout=120, env={**os.environ, **ENV})
        if result.returncode == 0:
            success += 1
            print(f"  OK {weapon}")
        else:
            print(f"  FAIL {weapon}")
    print(f"  {success}/{len(models)} decompiled\n")

# ============================================================
# PHASE 2: CONVERT
# ============================================================
def rename_bones_in_text(content, bone_map):
    for old, new in sorted(bone_map.items(), key=lambda x: len(x[0]), reverse=True):
        if not old or old == "(null)":
            continue
        content = content.replace(f'"{old}"', f'"{new}"')
    return content

def convert_weapon(weapon, bone_map):
    src_dir = os.path.join(DECOMPILE_DIR, weapon)
    dst_dir = os.path.join(COMPILE_DIR, weapon, "source")
    if not os.path.isdir(src_dir):
        return False
    os.makedirs(dst_dir, exist_ok=True)
    
    # Parse SMD bones for numbered finger mapping
    bone_hierarchy = {}
    for root, dirs, files in os.walk(src_dir):
        for f in files:
            if f.endswith(".smd"):
                try:
                    with open(os.path.join(root, f), "r", errors="ignore") as fh:
                        content = fh.read()
                    for m in re.finditer(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)', content, re.MULTILINE):
                        bone_hierarchy[int(m.group(1))] = (m.group(2), int(m.group(3)))
                except: pass
    
    weapon_bone_map = dict(bone_map)
    # Add numbered finger mapping (Left1-15, Right1-15, Bone06-24)
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
    
    had_hands_bodygroup = False
    
    for root, dirs, files in os.walk(src_dir):
        for f in files:
            src_path = os.path.join(root, f)
            rel_path = os.path.relpath(src_path, src_dir)
            dst_path = os.path.join(dst_dir, rel_path)
            os.makedirs(os.path.dirname(dst_path), exist_ok=True)
            
            if f.endswith((".smd", ".qc", ".qci")):
                try:
                    with open(src_path, "r", errors="ignore") as fh:
                        content = fh.read()
                    if f.endswith(".qc"):
                        # Rename bones
                        content = rename_bones_in_text(content, weapon_bone_map)
                        # Remove hands bodygroup
                        if re.search(r'\$bodygroup\s+"hands"', content, re.IGNORECASE):
                            content = re.sub(r'\$bodygroup\s+"hands"\s*\n\{[^}]*\}',
                                '// REMOVED: hands bodygroup (c_hands provides arm mesh)',
                                content, flags=re.IGNORECASE | re.DOTALL)
                            had_hands_bodygroup = True
                        # Rename modelname
                        content = re.sub(r'\$modelname\s+"[^"]*"',
                            f'$modelname "weapons/c_{weapon}.mdl"', content, flags=re.IGNORECASE)
                        # Add $bonemerge ONLY for weapons that had hands bodygroup removed
                        if had_hands_bodygroup and "$bonemerge" not in content.lower():
                            # Find last $definebone line
                            lines = content.split("\n")
                            last_db = -1
                            for i, line in enumerate(lines):
                                if "$definebone" in line.lower():
                                    last_db = i
                            if last_db >= 0:
                                lines.insert(last_db + 1, BONEMERGE_LINES)
                            content = "\n".join(lines)
                        # Remove $sectionframes (unsupported by SDK 2013)
                        content = re.sub(r'\$sectionframes[^\n]*\n', '', content, flags=re.IGNORECASE)
                    else:
                        content = rename_bones_in_text(content, weapon_bone_map)
                    with open(dst_path, "w") as fh:
                        fh.write(content)
                except Exception as e:
                    shutil.copy2(src_path, dst_path)
            else:
                shutil.copy2(src_path, dst_path)
    return True

def convert_all():
    weapons = sorted([d for d in os.listdir(DECOMPILE_DIR) if os.path.isdir(os.path.join(DECOMPILE_DIR, d))])
    print(f"Phase 2: Converting {len(weapons)} weapons...")
    success = 0
    for weapon in weapons:
        if convert_weapon(weapon, BONE_MAP):
            success += 1
    print(f"  {success}/{len(weapons)} converted\n")

# ============================================================
# PHASE 3: COMPILE
# ============================================================
def compile_weapon(weapon):
    src_dir = os.path.join(COMPILE_DIR, weapon, "source")
    qc_files = [f for f in os.listdir(src_dir) if f.endswith(".qc")]
    if not qc_files:
        return False, "no QC"
    qc_file = qc_files[0]
    os.makedirs(os.path.join(src_dir, "models"), exist_ok=True)
    
    env = os.environ.copy()
    env["LD_LIBRARY_PATH"] = LD_LIB_PATH
    result = subprocess.run([STUDIOMDL, qc_file], capture_output=True, text=True,
                           cwd=src_dir, env=env, timeout=120)
    
    models_dir = os.path.join(src_dir, "models")
    compiled = []
    for root, dirs, files in os.walk(models_dir):
        for f in files:
            path = os.path.join(root, f)
            if os.path.getsize(path) > 0:
                compiled.append(f)
    
    if compiled:
        compiled_dir = os.path.join(COMPILE_DIR, weapon, "compiled")
        os.makedirs(compiled_dir, exist_ok=True)
        for root, dirs, files in os.walk(models_dir):
            for f in files:
                src = os.path.join(root, f)
                if os.path.getsize(src) > 0:
                    shutil.copy2(src, os.path.join(compiled_dir, f))
        return True, f"{len(compiled)} files"
    return False, "no output"

def compile_all():
    weapons = sorted([d for d in os.listdir(COMPILE_DIR) if os.path.isdir(os.path.join(COMPILE_DIR, d, "source"))])
    print(f"Phase 3: Compiling {len(weapons)} weapons...")
    success = 0
    for i, weapon in enumerate(weapons):
        try:
            ok, msg = compile_weapon(weapon)
            status = "OK" if ok else "FAIL"
            print(f"  [{i+1}/{len(weapons)}] {status} {weapon}: {msg}")
            if ok:
                success += 1
        except Exception as e:
            print(f"  [{i+1}/{len(weapons)}] ERROR {weapon}: {e}")
    print(f"\n  {success}/{len(weapons)} compiled\n")

# ============================================================
# MAIN
# ============================================================
if __name__ == "__main__":
    os.makedirs(DECOMPILE_DIR, exist_ok=True)
    os.makedirs(COMPILE_DIR, exist_ok=True)
    
    # Need the decompile script
    if not os.path.exists("/home/z/my-project/scripts/test_crowbar_decompile.py"):
        print("ERROR: test_crowbar_decompile.py not found!")
        sys.exit(1)
    
    decompile_all()
    convert_all()
    compile_all()
    
    print("=== Complete ===")
