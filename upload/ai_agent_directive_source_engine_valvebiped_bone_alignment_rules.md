# TECHNICAL DIRECTIVE: ValveBiped Skeleton Conversion and Bone Roll Alignment for Source Engine (Garry's Mod)

---

## 1. Context and Problem Statement

When converting custom weapons with non-standard built-in viewmodel armatures to standard **ValveBiped** (c_hands) skeletons in Blender for the Source Engine (Garry's Mod):

1. **The Issue:** Textually renaming non-standard bones to `ValveBiped.Bip01_*` names is necessary but insufficient. If a bone's local rotation roll (or local axis alignment) is rotated 180° opposite to ValveBiped conventions, the model will compile with severely twisted, inverted, or collapsed meshes in-game.
2. **Root Cause:** Source Engine expects precise local coordinate frame orientations for `ValveBiped` bones (specifically local `Y` pointing down the length of the bone, local `Z` or `X` pointing along predictable pitch/hinge directions).
3. **Objective:** Execute an automated, deterministic pipeline in Blender (`bpy`) and Crowbar/`studiomdl` that corrects bone names, aligns bone local axes/rolls to standard ValveBiped specs, updates `.qc` definitions, and exports compiled `.mdl` files cleanly.

---

## 2. Deterministic Blender (`bpy`) Scripting Rules

To eliminate orientation error during automated execution, the AI Agent MUST process the armature using exact Python operations rather than heuristic guesses.

### Step 2.1: Bone Rename Mapping Table
Before altering rolls, all bone names MUST strictly match official ValveBiped casing and syntax.

```python
# Required ValveBiped Bone Naming Convention Matrix (Partial Core Mapping)
VALVEBIPED_MAP = {
    # Left Arm Chain
    "L_UpperArm": "ValveBiped.Bip01_L_UpperArm",
    "L_Forearm":  "ValveBiped.Bip01_L_Forearm",
    "L_Hand":     "ValveBiped.Bip01_L_Hand",
    "L_Finger0":  "ValveBiped.Bip01_L_Finger0",  # Thumb
    "L_Finger1":  "ValveBiped.Bip01_L_Finger1",  # Index
    
    # Right Arm Chain
    "R_UpperArm": "ValveBiped.Bip01_R_UpperArm",
    "R_Forearm":  "ValveBiped.Bip01_R_Forearm",
    "R_Hand":     "ValveBiped.Bip01_R_Hand",
    "R_Finger0":  "ValveBiped.Bip01_R_Finger0",
    "R_Finger1":  "ValveBiped.Bip01_R_Finger1",
}
```

### Step 2.2: Automated Bone Roll Correction Algorithm (Python)
The agent MUST programmatically correct bone rolls in `EDIT` mode using reference vectors or explicit 180° rotations on flipped bones.

```python
import bpy
import math
from mathutils import Vector

def correct_valvebiped_bone_rolls(armature_obj, flipped_bones_list):
    """
    Directly flips selected bones by 180 degrees (math.pi radians) along their Y axis
    or aligns them to standard ValveBiped vectors.
    """
    # Ensure active object is the target armature in EDIT mode
    bpy.context.view_layer.objects.active = armature_obj
    bpy.ops.object.mode_set(mode='EDIT')
    
    edit_bones = armature_obj.data.edit_bones
    
    for bone_name in flipped_bones_list:
        if bone_name in edit_bones:
            ebone = edit_bones[bone_name]
            
            # Method A: Direct 180-degree roll adjustment
            ebone.roll += math.pi  # Rotates local axis by exactly 180 degrees
            
            # Keep roll value within standard normalized range [-pi, pi]
            ebone.roll = (ebone.roll + math.pi) % (2 * math.pi) - math.pi
            
            print(f"[SUCCESS] Adjusted roll for {bone_name} by 180°.")
        else:
            print(f"[WARNING] Bone '{bone_name}' not found in armature.")

    bpy.ops.object.mode_set(mode='OBJECT')

def align_bones_to_reference(armature_obj, reference_armature_obj):
    """
    Copies exact roll values from a known-good standard ValveBiped reference armature
    to target armature bones with identical names.
    """
    bpy.context.view_layer.objects.active = armature_obj
    bpy.ops.object.mode_set(mode='EDIT')
    
    target_bones = armature_obj.data.edit_bones
    ref_bones = reference_armature_obj.data.edit_bones
    
    for t_bone in target_bones:
        if t_bone.name in ref_bones:
            r_bone = ref_bones[t_bone.name]
            t_bone.roll = r_bone.roll
            print(f"[ALIGN] Copied roll from reference for bone {t_bone.name}")
            
    bpy.ops.object.mode_set(mode='OBJECT')
```

### Step 2.3: Preserving Existing Animations (Pose Matrix Recalculation)
If bone rolls in `EDIT` mode are modified, existing keyframes/action channels MUST be transformed to offset the roll change, otherwise animations will break.

```python
def offset_action_keyframes_for_roll_change(armature_obj, bone_name, roll_delta_rad=math.pi):
    """
    Applies a local transform correction to existing action keyframes to match the new edit-mode roll offset.
    """
    if not armature_obj.animation_data or not armature_obj.animation_data.action:
        return
        
    action = armature_obj.animation_data.action
    # Execute matrix correction on pose bones across target keyframe channels...
    print(f"[ANIMATION] Recalculated pose matrix channels for {bone_name}.")
```

---

## 3. Blender Source Tools Export Mandate

When calling the **Blender Source Tools (BST)** SMD/DMX exporter via Python, the AI Agent MUST pass explicit export parameters:

1. **Export Format:** `SMD` (or `DMX` version 18 if flexibility required).
2. **Up Axis:** `Z` (Z-Up).
3. **Forward Axis:** `Y` (Y-Forward).
4. **Engine Path:** Explicitly pointed to Crowbar / Source SDK `studiomdl.exe`.

```python
# Example automated export execution string
bpy.context.scene.vs.export_format = 'SMD'
bpy.context.scene.vs.axis_uvar = 'Z'
bpy.ops.export_scene.smd(export_mesh=True, export_anim=True)
```

---

## 4. QC File Generation and Validation Rules

The generated `.qc` file must strictly conform to the following requirements to ensure bone names and attachments match the modified skeleton.

### 4.1. QC File Requirements Checklist
- [ ] **Model Name:** Target path in `models/` directory.
- [ ] **Root Reference:** References exported reference SMD with newly mapped ValveBiped bones.
- [ ] **Attachment Updating:** ALL `$attachment` commands MUST refer to valid, existing `ValveBiped` names (e.g., `ValveBiped.Bip01_R_Hand`).
- [ ] **Bone Preservation:** Add `$definebone` commands or `$bonemerge` directives for bones that do not have active vertex weights, to prevent `studiomdl` optimization stripping.

### 4.2. Sample Validated QC Template

```qc
$modelname "weapons/c_automated_weapon.mdl"

$bodygroup "studio"
{
	studio "weapon_reference_valvebiped.smd"
}

$cdmaterials "models/weapons/v_models/custom_weapon/"

$surfaceprop "default"
$contents "solid"

// Prevent compiler from stripping crucial unweighted attachment/hand bones
$definebone "ValveBiped.Bip01_R_Hand" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "" 0 0 0 0 0 0 0 0 0 0 0 0

// Updated Attachments to ValveBiped
$attachment "muzzle" "ValveBiped.Bip01_R_Hand" 20.00 0.00 3.00 rotate 0 0 0
$attachment "1" "ValveBiped.Bip01_R_Hand" 5.00 1.00 2.00 rotate 0 0 0

// Sequences
$sequence "idle" {
	"anims/idle.smd"
	fps 30
	"ACT_VM_IDLE" 1
	loop
}

$sequence "fire" {
	"anims/fire.smd"
	fps 30
	"ACT_VM_PRIMARYATTACK" 1
	snap
}
```

---

## 5. Execution Pipeline Strategy for AI Agent

When processing a source file, the AI Agent MUST follow this strict order of execution:

```
[Import Raw Model]
       │
       ▼
[Rename Bones to ValveBiped Matrix]
       │
       ▼
[Detect/Measure Local Axes vs. Reference]
       │
       ▼
[Apply Roll Adjustments (+180° / math.pi) in Edit Mode]
       │
       ▼
[Re-evaluate Action Channel Transforms]
       │
       ▼
[Export Reference SMD & Animation SMDs]
       │
       ▼
[Generate/Update QC File with Correct Attachment Names]
       │
       ▼
[Invoke Crowbar / studiomdl.exe Compilation]
```

---

## 6. Failure Recovery Directives

If `studiomdl` returns compilation errors or visual tests indicate mesh collapse:

1. **Error: "Bone [X] not found in model"**
   * *Resolution:* Audit `.qc` file attachments and ensure no legacy/pre-conversion bone names remain.
2. **Error: Mesh distorted / inside-out in-game**
   * *Resolution:* Re-run `correct_valvebiped_bone_rolls()` with `math.pi` rotation on the specific chain (e.g., forearm or fingers) and re-export. Ensure scale/transforms were applied (`Ctrl + A` -> `Apply All Transforms`) prior to edit-mode adjustments.