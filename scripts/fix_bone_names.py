#!/usr/bin/env python3
"""Fix bone name issues in failing weapons."""
import re, os, sys
sys.path.insert(0, '/home/z/my-project/scripts')

COMPILE_DIR = "/home/z/my-project/compile"
FAILING_WEAPONS = ["famas", "g18", "g3a3", "m1911", "m9", "m93r", "mp443"]

# BONE_MAP from full_pipeline
BONE_MAP = {
    "L Clavicle": "ValveBiped.Bip01_L_Clavicle", "L UpperArm": "ValveBiped.Bip01_L_UpperArm",
    "L Forearm": "ValveBiped.Bip01_L_Forearm", "L Hand": "ValveBiped.Bip01_L_Hand",
    "L Finger0": "ValveBiped.Bip01_L_Finger0", "L Finger01": "ValveBiped.Bip01_L_Finger01",
    "L Finger02": "ValveBiped.Bip01_L_Finger02", "L Finger1": "ValveBiped.Bip01_L_Finger1",
    "L Finger11": "ValveBiped.Bip01_L_Finger11", "L Finger12": "ValveBiped.Bip01_L_Finger12",
    "L Finger2": "ValveBiped.Bip01_L_Finger2", "L Finger21": "ValveBiped.Bip01_L_Finger21",
    "L Finger22": "ValveBiped.Bip01_L_Finger22", "L Finger3": "ValveBiped.Bip01_L_Finger3",
    "L Finger31": "ValveBiped.Bip01_L_Finger31", "L Finger32": "ValveBiped.Bip01_L_Finger32",
    "L Finger4": "ValveBiped.Bip01_L_Finger4", "L Finger41": "ValveBiped.Bip01_L_Finger41",
    "L Finger42": "ValveBiped.Bip01_L_Finger42",
    "R Clavicle": "ValveBiped.Bip01_R_Clavicle", "R UpperArm": "ValveBiped.Bip01_R_UpperArm",
    "R Forearm": "ValveBiped.Bip01_R_Forearm", "R Hand": "ValveBiped.Bip01_R_Hand",
    "R Finger0": "ValveBiped.Bip01_R_Finger0", "R Finger01": "ValveBiped.Bip01_R_Finger01",
    "R Finger02": "ValveBiped.Bip01_R_Finger02", "R Finger1": "ValveBiped.Bip01_R_Finger1",
    "R Finger11": "ValveBiped.Bip01_R_Finger11", "R Finger12": "ValveBiped.Bip01_R_Finger12",
    "R Finger2": "ValveBiped.Bip01_R_Finger2", "R Finger21": "ValveBiped.Bip01_R_Finger21",
    "R Finger22": "ValveBiped.Bip01_R_Finger22", "R Finger3": "ValveBiped.Bip01_R_Finger3",
    "R Finger31": "ValveBiped.Bip01_R_Finger31", "R Finger32": "ValveBiped.Bip01_R_Finger32",
    "R Finger4": "ValveBiped.Bip01_R_Finger4", "R Finger41": "ValveBiped.Bip01_R_Finger41",
    "R Finger42": "ValveBiped.Bip01_R_Finger42",
}

for weapon in FAILING_WEAPONS:
    src_dir = os.path.join(COMPILE_DIR, weapon, "source")
    if not os.path.exists(src_dir): continue
    for root, dirs, files in os.walk(src_dir):
        for f in files:
            if not f.endswith((".smd", ".qc", ".qci")): continue
            path = os.path.join(root, f)
            with open(path, 'r', errors='ignore') as fh:
                original = fh.read()
            content = original
            for old, new in sorted(BONE_MAP.items(), key=lambda x: len(x[0]), reverse=True):
                content = content.replace(f'"{old}"', f'"{new}"')
            content = content.replace('"(null)"', '"ValveBiped.Bip01_Root"')
            content = content.replace('"b_root"', '"ValveBiped.Bip01"')
            if content != original:
                with open(path, 'w') as fh:
                    fh.write(content)
                print(f"  FIXED {weapon}/{f}")
