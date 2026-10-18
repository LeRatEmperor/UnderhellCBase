# c_hands Complete Guide — Porting Non-Source Weapons (BF3) to Garry's Mod

> **Single source of truth** for setting up `c_hands` (viewmodel hands) when porting weapons
> from non-Source games (Battlefield 3, Call of Duty, etc.) to Garry's Mod.
>
> **Audience:** porting engineers working on the BF3 → GMod weapon pack.
> **Status:** Compiled from Facepunch wiki, Valve developer wiki, robotboy655/gmod-animations
> reference SMDs, and three failed+reverted attempts on the actual BF3 pack.

---

## Table of Contents

1. [What c_hands Actually ARE in GMod](#1-what-c_hands-actually-are-in-gmod)
2. [The c_arms_citizen.smd Reference Skeleton](#2-the-c_arms_citizensmd-reference-skeleton)
3. [The $bonemerge QC Command](#3-the-bonemerge-qc-command)
4. [The $definebone QC Command](#4-the-definebone-qc-command)
5. [c_arms_citizen Hierarchy vs Other-Game Skeletons](#5-c_arms_citizen-hierarchy-vs-other-game-skeletons)
6. [The "c_arms Flying Away" Issue](#6-the-c_arms-flying-away-issue)
7. [How to Properly Convert a Non-Source Weapon to c_hands](#7-how-to-properly-convert-a-non-source-weapon-to-c_hands)
8. [Reference Examples From GitHub](#8-reference-examples-from-github)
9. [Common Pitfalls](#9-common-pitfalls)
10. [Correct Pipeline for BF3 Weapons Specifically](#10-correct-pipeline-for-bf3-weapons-specifically)
11. [Appendix A: Full Bone-Name Mapping Table (BF3 → ValveBiped)](#appendix-a-full-bone-name-mapping-table-bf3--valvebiped)
12. [Appendix B: Full c_arms_definebones.qci Reference](#appendix-b-full-c_arms_definebonesqci-reference)
13. [Appendix C: Diagnostic Checklist](#appendix-c-diagnostic-checklist)

---

## 1. What c_hands Actually ARE in GMod

### 1.1 The c_arms entity — a SEPARATE entity that bonemerges to the viewmodel

c_hands is **not** a feature of the viewmodel itself. It is a runtime-attached
**separate entity** of class `c_arms` that gets created by the engine when:

1. The player spawns (gamemode calls `ply:SetupHands()` in `GM:PlayerSpawn`)
2. The player's current weapon has `SWEP.UseHands = true`
3. The weapon's viewmodel path starts with `models/weapons/c_*.mdl` (the `c_`
   prefix is the convention for "c_model" — a model that uses the c_hands system)

The c_arms entity is **parented to the viewmodel** and its bones are **bonemerged**
to the viewmodel's bones. The c_arms entity itself renders the hand mesh (sleeves,
skin) — that mesh is weighted to a ValveBiped hand skeleton that **matches the
viewmodel's hand skeleton bone-for-bone**.

When the viewmodel animates, its hand bones move. The bonemerge propagates those
transforms to the c_arms entity's matching bones, and the hand mesh deforms
correctly because the bone hierarchy is identical.

### 1.2 The relationship between SWEP.UseHands, the viewmodel, and the c_arms entity

```
┌─────────────────────────────────────────────────────────────────┐
│  Player (serverside)                                            │
│    └── ply:SetupHands() called in GM:PlayerSpawn                │
│          ↓                                                       │
│        creates c_arms entity (serverside + clientside)           │
│        ent:SetParent(ply:GetViewModel())                         │
│        ent:SetModel(player_manager hands model — usually         │
│            "models/weapons/c_arms_citizen.mdl")                 │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  Viewmodel (clientside)                                         │
│    SWEP.ViewModel = "models/weapons/c_<name>.mdl"               │
│    SWEP.UseHands = true                                         │
│                                                                 │
│    The c_<name>.mdl MUST contain the ValveBiped hand bones      │
│    (Clavicle, UpperArm, Forearm, Hand, Fingers) with $bonemerge │
│    flags on each one.                                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓ bonemerge by name match
┌─────────────────────────────────────────────────────────────────┐
│  c_arms entity (clientside, parented to viewmodel)              │
│    Model: c_arms_citizen.mdl                                    │
│    Contains the hand/sleeve MESH, weighted to its own           │
│    ValveBiped hand bones.                                       │
│                                                                 │
│    On render:                                                   │
│      for each bone name in c_arms:                              │
│        if viewmodel has a bone with the same name:              │
│          copy viewmodel's bone transform → c_arms's bone        │
│          transform                                               │
│      render the c_arms mesh using the OVERWRITTEN transforms    │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 Required Lua glue (from Facepunch wiki — `Using_Viewmodel_Hands`)

The SWEP needs:
```lua
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_<name>.mdl"  -- MUST be a c_ model
```

The gamemode needs (sandbox already has this; custom gamemodes must add it):
```lua
function GM:PlayerSpawn(ply)
    -- your spawn code...
    ply:SetupHands()  -- creates the c_arms entity and calls GM:PlayerSetHandsModel
end

function GM:PlayerSetHandsModel(ply, ent)
    local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
    local info = player_manager.TranslatePlayerHands(simplemodel)
    if info then
        ent:SetModel(info.model)
        ent:SetSkin(info.skin)
        ent:SetBodyGroups(info.body)
    end
end

-- Clientside (optional if you haven't overridden PostDrawViewModel):
function GM:PostDrawViewModel(vm, ply, weapon)
    if weapon.UseHands or not weapon:IsScripted() then
        local hands = LocalPlayer():GetHands()
        if IsValid(hands) then
            hands:DrawModel()
        end
    end
end
```

### 1.4 Key Takeaways

| Myth | Reality |
|------|---------|
| "c_hands is part of the viewmodel" | c_hands is a **separate entity** that bonemerges to the viewmodel's bones |
| "Include hand mesh in the weapon SMD" | **NEVER** do this — the wiki explicitly says "the arms mesh should never be in the weapon model itself; that defeats the entire purpose of the system" |
| "Just add $bonemerge lines" | You also need `$definebone` lines (or include `c_arms_definebones.qci`) **or StudioMDL will optimise away the hand bones** since they have no mesh attached |
| "Bone names don't matter" | They **must** match c_arms_citizen's bone names exactly (ValveBiped.Bip01_*) |
| "Bone positions don't matter" | They DO matter — bonemerge uses bone transforms, and the c_arms mesh was modeled assuming the c_arms_citizen reference pose |

---

## 2. The c_arms_citizen.smd Reference Skeleton

Source: `/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd`
(reference extracted from robotboy655/gmod-animations repo — official GMod animation source).

### 2.1 Full Bone Hierarchy (46 bones total)

```
c_arms_citizen_mesh_hands (root mesh bone, id 0)
└── ValveBiped.Bip01_Spine4 (id 1)         [ROOT OF THE BIPED IN c_arms CONTEXT]
    ├── ValveBiped.Bip01_R_Clavicle (2)
    │   └── ValveBiped.Bip01_R_UpperArm (3)
    │       └── ValveBiped.Bip01_R_Forearm (4)
    │           ├── ValveBiped.Bip01_R_Wrist (5)    [procedural helper]
    │           ├── ValveBiped.Bip01_R_Ulna  (6)    [procedural helper]
    │           └── ValveBiped.Bip01_R_Hand (7)
    │               ├── ValveBiped.Bip01_R_Finger0  (8)  [thumb]
    │               │   └── ValveBiped.Bip01_R_Finger01 (9)
    │               │       └── ValveBiped.Bip01_R_Finger02 (10)
    │               ├── ValveBiped.Bip01_R_Finger1  (11) [index]
    │               │   └── ValveBiped.Bip01_R_Finger11 (12)
    │               │       └── ValveBiped.Bip01_R_Finger12 (13)
    │               ├── ValveBiped.Bip01_R_Finger2  (14) [middle]
    │               │   └── ValveBiped.Bip01_R_Finger21 (15)
    │               │       └── ValveBiped.Bip01_R_Finger22 (16)
    │               ├── ValveBiped.Bip01_R_Finger3  (17) [ring]
    │               │   └── ValveBiped.Bip01_R_Finger31 (18)
    │               │       └── ValveBiped.Bip01_R_Finger32 (19)
    │               └── ValveBiped.Bip01_R_Finger4  (20) [pinky]
    │                   └── ValveBiped.Bip01_R_Finger41 (21)
    │                       └── ValveBiped.Bip01_R_Finger42 (22)
    ├── ValveBiped.Bip01_L_Clavicle (23)
    │   └── ValveBiped.Bip01_L_UpperArm (24)
    │       └── ValveBiped.Bip01_L_Forearm (25)
    │           ├── ValveBiped.Bip01_L_Wrist (26)    [procedural helper]
    │           ├── ValveBiped.Bip01_L_Ulna  (27)    [procedural helper]
    │           └── ValveBiped.Bip01_L_Hand (28)
    │               ├── ValveBiped.Bip01_L_Finger0  (29)  [thumb]
    │               │   └── ValveBiped.Bip01_L_Finger01 (30)
    │               │       └── ValveBiped.Bip01_L_Finger02 (31)
    │               ├── ValveBiped.Bip01_L_Finger1  (32) [index]
    │               │   └── ValveBiped.Bip01_L_Finger11 (33)
    │               │       └── ValveBiped.Bip01_L_Finger12 (34)
    │               ├── ValveBiped.Bip01_L_Finger2  (35) [middle]
    │               │   └── ValveBiped.Bip01_L_Finger21 (36)
    │               │       └── ValveBiped.Bip01_L_Finger22 (37)
    │               ├── ValveBiped.Bip01_L_Finger3  (38) [ring]
    │               │   └── ValveBiped.Bip01_L_Finger31 (39)
    │               │       └── ValveBiped.Bip01_L_Finger32 (40)
    │               └── ValveBiped.Bip01_L_Finger4  (41) [pinky]
    │                   └── ValveBiped.Bip01_L_Finger41 (42)
    │                       └── ValveBiped.Bip01_L_Finger42 (43)
    └── ValveBiped.Bip01_Neck1 (44)   [optional — present but not needed for hands]
        └── ValveBiped.Bip01_Head1 (45)
```

**Note:** For pure c_hands viewmodel use, only the **38 bones** that are bonemerged
are actually required:
- Spine4 (root)
- L+R: Clavicle, UpperArm, Forearm, Hand (4×2 = 8)
- L+R: Finger0, Finger01, Finger02 (thumb, 3×2 = 6)
- L+R: Finger1, Finger11, Finger12 (index, 3×2 = 6)
- L+R: Finger2, Finger21, Finger22 (middle, 3×2 = 6)
- L+R: Finger3, Finger31, Finger32 (ring, 3×2 = 6)
- L+R: Finger4, Finger41, Finger42 (pinky, 3×2 = 6)

Total: 1 + 8 + 30 = 39 bones (Spine4 + the 38 merged bones).
Neck1, Head1, Wrist, Ulna are *optional* (Wrist/Ulna are used by the procedural
bones VRD file for arm-twist corrections).

### 2.2 Standard Bone Positions and Rotations (Bind Pose — from `c_arms_citizen.smd`)

The SMD stores positions in Source units and rotations in **radians**.
Positions are relative to each bone's parent.

| Bone | Parent | Pos (x, y, z) | Rot (rx, ry, rz) in radians |
|------|--------|----------------|------------------------------|
| Spine4 | (root) | (0.000006, 3.336140, 58.352139) | (-1.570799, -1.391900, -1.570795) |
| R_Clavicle | Spine4 | (2.033360, 1.000772, -1.937610) | (-1.668475, 1.286518, 2.942953) |
| R_UpperArm | R_Clavicle | (6.028143, 0.000004, 0.000000) | (1.639479, -0.008065, -0.586846) |
| R_Forearm | R_UpperArm | (11.692549, 0.000000, 0.000004) | (0.000000, 0.000000, -0.060372) |
| R_Wrist | R_Forearm | (11.481703, 0.000000, -0.000004) | (0.000150, 0.000000, 0.000000) |
| R_Ulna | R_Forearm | (5.740854, 0.000000, -0.000004) | (0.000081, 0.000000, 0.000000) |
| R_Hand | R_Forearm | (11.481703, 0.000000, -0.000004) | (-1.564937, 0.106606, 0.044193) |
| R_Finger0 (thumb) | R_Hand | (0.806017, -0.359833, -1.318334) | (1.221731, 0.673635, -0.793558) |
| R_Finger01 | R_Finger0 | (1.789783, 0.000000, 0.000000) | (0.000000, -0.000000, 0.226893) |
| R_Finger02 | R_Finger01 | (1.207001, 0.000002, -0.000002) | (0.000000, 0.000000, 0.362905) |
| R_Finger1 (index) | R_Hand | (3.859829, -0.148937, -1.331282) | (-0.354419, 0.038567, -0.532001) |
| R_Finger11 | R_Finger1 | (1.719431, -0.000008, 0.000000) | (0.000000, -0.006613, -0.362970) |
| R_Finger12 | R_Finger11 | (1.099663, 0.000000, 0.000000) | (0.000000, -0.004211, -0.244312) |
| R_Finger2 (middle) | R_Hand | (3.883656, -0.050331, -0.431043) | (-0.085905, -0.026404, -0.587695) |
| R_Finger21 | R_Finger2 | (1.719574, -0.000008, 0.000000) | (0.000000, -0.007974, -0.366436) |
| R_Finger22 | R_Finger21 | (1.209179, 0.000000, -0.000000) | (0.000000, -0.004461, -0.216376) |
| R_Finger3 (ring) | R_Hand | (3.942293, 0.050327, 0.431043) | (0.150078, -0.079191, -0.810205) |
| R_Finger31 | R_Finger3 | (1.539097, 0.000004, -0.000001) | (0.000000, 0.000000, -0.247771) |
| R_Finger32 | R_Finger31 | (1.196323, 0.000000, 0.000000) | (0.000000, 0.000000, -0.430761) |
| R_Finger4 (pinky) | R_Hand | (3.859674, -0.132568, 1.193107) | (0.466236, -0.158066, -0.878825) |
| R_Finger41 | R_Finger4 | (1.312565, -0.000004, 0.000001) | (0.000000, 0.000000, -0.439672) |
| R_Finger42 | R_Finger41 | (0.729370, 0.000004, -0.000001) | (-0.000000, 0.000000, -0.244271) |
| L_Clavicle | Spine4 | (2.033348, 1.000767, 1.937660) | (1.596637, -1.286515, 2.942962) |
| L_UpperArm | L_Clavicle | (6.028141, 0.000000, 0.000000) | (-1.579613, 0.047802, -0.585173) |
| L_Forearm | L_UpperArm | (11.692558, 0.000000, 0.000000) | (0.000000, 0.000000, -0.060372) |
| L_Wrist | L_Forearm | (11.481697, 0.000000, 0.000000) | (-0.075223, 0.000000, 0.000000) |
| L_Ulna | L_Forearm | (5.740852, 0.000000, -0.000004) | (0.000688, 0.000000, 0.000000) |
| L_Hand | L_Forearm | (11.481672, 0.000000, -0.000038) | (1.573183, -0.106613, 0.044193) |
| L_Finger0 (thumb) | L_Hand | (0.806047, -0.348923, 1.321258) | (-1.222677, -0.679213, -0.788819) |
| L_Finger01 | L_Finger0 | (1.789783, -0.000001, 0.000000) | (0.000000, 0.000000, 0.228523) |
| L_Finger02 | L_Finger01 | (1.207001, 0.000001, 0.000000) | (0.000000, 0.000000, 0.362860) |
| L_Finger1 (index) | L_Hand | (3.859858, -0.137947, 1.332466) | (0.354449, -0.042750, -0.531718) |
| L_Finger11 | L_Finger1 | (1.719429, 0.000000, 0.000001) | (0.000000, 0.004074, -0.363009) |
| L_Finger12 | L_Finger11 | (1.099663, 0.000002, 0.000000) | (0.000000, 0.002596, -0.244331) |
| L_Finger2 (middle) | L_Hand | (3.883686, -0.046768, 0.431443) | (0.085902, 0.021830, -0.587867) |
| L_Finger21 | L_Finger2 | (1.719576, 0.000000, 0.000000) | (0.000000, 0.005516, -0.366478) |
| L_Finger22 | L_Finger21 | (1.209183, -0.000004, -0.000000) | (0.000000, 0.003084, -0.216400) |
| L_Finger3 (ring) | L_Hand | (3.942322, 0.046772, -0.431443) | (-0.151780, 0.073206, -0.810985) |
| L_Finger31 | L_Finger3 | (1.539089, 0.000002, 0.000000) | (0.000000, 0.000000, -0.247797) |
| L_Finger32 | L_Finger31 | (1.196323, 0.000000, -0.000000) | (-0.000000, 0.000000, -0.430802) |
| L_Finger4 (pinky) | L_Hand | (3.859701, -0.142406, -1.191974) | (-0.468133, 0.151533, -0.880197) |
| L_Finger41 | L_Finger4 | (1.312565, -0.000002, 0.000000) | (0.000000, 0.000000, -0.439720) |
| L_Finger42 | L_Finger41 | (0.729362, 0.000003, 0.000001) | (0.000000, 0.000000, -0.244299) |
| Neck1 | Spine4 | (3.307270, 0.000000, 0.000000) | (3.141590, 0.000000, 0.400478) |
| Head1 | Neck1 | (3.593712, 0.000000, 0.000000) | (0.000000, -0.000001, 0.406587) |

**Critical observation:** Spine4's world position is `(0, 3.34, 58.35)` — i.e.,
**58 Source units in front of (and 3 above) the model origin**. This is the c_arms
camera-relative origin, and it is NOT at `(0,0,0)`. The viewmodel uses `$origin`
to shift the model into view; c_arms does not, because it inherits the viewmodel's
position through bonemerge.

### 2.3 Which Bones MUST Be Present for Bonemerge to Work

The **minimum required bones** on the weapon viewmodel are the 38 bonemerged
bones. Without any one of them, the corresponding c_arms mesh region will
render at the c_arms model's bind pose (usually floating in space) instead of
following the weapon.

The c_arms_citizen.qc bonemerge list (canonical order, 38 bones):

```
$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
```

(40 lines counting Neck1 + Head1 which are optional but harmless.)

---

## 3. The $bonemerge QC Command

### 3.1 What it does

`$bonemerge "BoneName"` is a QC command available in all Source games. It sets
a flag on the named bone that tells the engine: "this bone will be used for
bone merges at runtime — do not strip it, and be ready to copy transforms
into it from another entity."

Quote from Valve Developer Community wiki (`QC_Commands` page):
> `$bonemerge (name)` — Serves as a hint to the game code that the named bone
> will be used for bone merges (see Attachments) during the game.

### 3.2 What it does NOT do

`$bonemerge` does NOT:
- Make the bone exist (that's what `$definebone` is for)
- Copy transforms by itself (the engine does that when the c_arms entity is
  parented and bonemerged to the viewmodel)
- Hide the bone's mesh
- Change the bone's bind pose
- Match bones between two different hierarchies

If the weapon model has a bone named `ValveBiped.Bip01_R_Hand` with `$bonemerge`
flag, AND the c_arms model has a bone named `ValveBiped.Bip01_R_Hand`, the
engine's bonemerge code copies the viewmodel's `R_Hand` transform into the
c_arms's `R_Hand` transform at render time. The c_arms mesh, weighted to
`R_Hand`, then renders at the viewmodel's hand position.

### 3.3 Common misconceptions

| Misconception | Truth |
|---------------|-------|
| "Adding $bonemerge makes c_hands appear" | No — it only flags bones for runtime merging. You also need matching bones defined, and the c_arms entity must be parented (handled automatically by `SWEP.UseHands = true`). |
| "$bonemerge works without bone name match" | No — bonemerge matches by **exact bone name string**. `R_Hand` will not merge to `ValveBiped.Bip01_R_Hand`. |
| "$bonemerge on a bone that doesn't exist in c_arms still does something" | No — it's a no-op for that bone. |
| "$bonemerge hides the original weapon's bones" | No — it has no effect on the weapon's own mesh rendering. It just sets a flag. |
| "Bone order in QC matters for $bonemerge" | Slightly — bonemerge matches by name, but studiomdl's `--definebones` mode generates `$definebone` lines in dependency order. Best practice: keep bones in parent→child dependency order. |

### 3.4 How GMod uses $bonemerge to attach c_arms

1. Server creates c_arms entity in `ply:SetupHands()` (called from `GM:PlayerSpawn`)
2. Server sets the c_arms's model (usually `c_arms_citizen.mdl`)
3. Server parents c_arms to the player's viewmodel (`c_arms:SetParent(ply:GetViewModel())`)
4. Client sees the parented c_arms and runs bonemerge during render:
   - For each bone `B` in c_arms where `B` has the bonemerge flag set in the
     c_arms's QC (set by the engine for any bone that exists in both models):
     - Find the bone named `B` in the viewmodel
     - If found, copy the viewmodel's bone transform into c_arms's bone transform
     - If not found, the c_arms's bone transform stays at its bind pose

The `$bonemerge` lines in the **viewmodel's** QC are a hint to studiomdl that
those bones should not be optimised away (because nothing in the weapon mesh
references them). The `$bonemerge` lines in the c_arms's QC mark which bones
should be considered "merge targets".

In practice you put `$bonemerge` in BOTH the viewmodel QC and (implicitly via
`$definebone` in c_arms_definebones.qci) — the c_arms_citizen.mdl already has
them baked in.

---

## 4. The $definebone QC Command

### 4.1 Format

From Valve Developer Community wiki:

```
$definebone  (name) (parent) (X) (Y) (Z) (xr) (yr) (zr)  (fixup X) (fixup Y) (fixup Z)  (fixup X Rotation) (fixup Y Rotation) (fixup Z Rotation)  [(phys X) (phys Y) (phys Z) (phys Xr) (phys Yr) (phys Zr)]
```

That is:
- **name** — bone name (string)
- **parent** — parent bone name (empty string for root)
- **X Y Z** — position offset from parent (in Source units)
- **xr yr zr** — rotation offset from parent (in **degrees**, Euler, applied in
  studiomdl's preferred order)
- **fixup X Y Z** — fixup position offset (usually 0,0,0)
- **fixup Xr Yr Zr** — fixup rotation (in **degrees**, applied AFTER the bone's
  own rotation to align the bone's X axis with the IK chain's required axis)
- **phys X Y Z + phys Xr Yr Zr** — OPTIONAL third set of 6 values (the
  "pprealign" / physical-bone prealign values, used by ragdolls)

The wiki summary:
> `$definebone` is a QC command available in all Source games. It defines a bone
> outside of any .smd source. This is useful when building animation-only mdl's
> that would otherwise optimize out all the bones since none of them are connected
> to any geometry or attachment points.

### 4.2 Why the "fixup" values (the last 6 numbers) matter

The fixup values (often called the "prealign" or "zprealign" block) are used by
the IK solver. From the Valve wiki:

> The (fixup) fields specify how the IK solver has rotated any of the bones to
> match the single X axis as the long axis requirement for all bones in an IK
> chain. All the source animations are resolved to match this new orientation.

In practice:
- For bones that ARE part of an IK chain (UpperArm, Forearm, Hand) and have been
  through studiomdl's IK pass, the fixup values are non-zero
- For bones that ARE NOT in an IK chain, the fixup values are zero (or extremely
  small floating-point noise from the SMD export)

For our c_hands use case, we **DO NOT** need IK on the weapon model. The c_arms
entity itself has IK (defined in c_arms_citizen.qc via `$ikchain rhand` /
`$ikchain lhand`), but the weapon viewmodel does not need it.

### 4.3 Why some bones have 6 trailing zeros vs 12 vs 18

| Trailing value count | What it means | When you see this |
|----------------------|---------------|--------------------|
| **6 zeros** | (X Y Z xr yr zr) only — no fixup block at all | Old-school QCs exported without `--definebones`, or bones added by hand without IK fixup |
| **12 zeros** | (X Y Z xr yr zr) + (fixup X Y Z xr yr zr) — bone has fixup block but no IK adjustments | Most bones in modern QCs; the fixup block is present but all-zero because no IK fixup was applied |
| **18 zeros** | Full format including physical-bone (ragdoll) prealign | Ragdoll QCs that have a separate physics bone collision model |

Looking at `c_arms_definebones.qci`, all bones have **12 trailing values** (the
basic 6 + the fixup 6). Most of those fixup values are 0.000000 but some have
tiny non-zero values like `0.000001` or `-0.000007` — these are residual IK
fixup noise.

### 4.4 Why $definebone matters for c_hands

The weapon viewmodel typically:
- Has a `Weapon` bone (or similar) that the weapon mesh is weighted to
- Has the ValveBiped hand bones (Clavicle, UpperArm, etc.) **with no mesh
  attached to them**

Without `$definebone` lines for the hand bones, **studiomdl will optimise them
away** during compilation because no mesh references them. The result: the
compiled .mdl has no R_Hand bone, the c_arms entity's bonemerge finds no match,
and **the hands render at the c_arms's bind pose floating in space** (or at
the model origin, or not at all — depending on engine version).

The Facepunch wiki explicitly says:
> Remember to include `c_arms_definebones.qci` from the medkit example, as
> otherwise StudioMDL will optimise away the arm bones that you've included
> and then it won't work.

### 4.5 Generating $definebone lines with studiomdl

You can ask studiomdl to auto-generate the `$definebone` lines for you:

```bash
studiomdl -definebones <your_model.qc>
```

This reads the QC's `$modelname` and the reference SMD's skeleton, then dumps
the `$definebone` lines for every bone with the correct positions, rotations,
and fixup values. Crowbar has a UI for this (see the `$definebone` wiki page).

For our BF3 work, the **canonical reference** is `c_arms_definebones.qci`
(extracted to `/tmp/c_arms_extract/medkit/c_arms_definebones.qci` and archived
in the gmod-animations repo). The same file is reproduced in Appendix B of
this document.

---

## 5. c_arms_citizen Hierarchy vs Other-Game Skeletons

### 5.1 c_arms_citizen's hierarchy (parent chain)

```
Spine4 (ROOT — no parent)
  └── L_Clavicle
       └── L_UpperArm
            └── L_Forearm
                 └── L_Hand
                      └── L_Finger0/1/2/3/4
                           └── ...
  └── R_Clavicle
       └── R_UpperArm
            └── R_Forearm
                 └── R_Hand
                      └── R_Finger0/1/2/3/4
                           └── ...
  └── Neck1 (optional)
       └── Head1 (optional)
```

The crucial fact: **Spine4 is the root** of the c_arms hand hierarchy. Clavicle
is **a child** of Spine4.

### 5.2 BF3's hierarchy (typical)

Based on the BF3 viewmodel SMDs we've already decompiled (see worklog
entries `c-arms-retarget`, `revert-c-arms-retarget`, `c-hands-final-fix`):

```
NO Spine4 — BF3 doesn't have one

L Clavicle (ROOT — top of the BF3 hand hierarchy)
  └── L UpperArm
       └── L Forearm
            └── L Hand
                 └── L Finger0/1/2/3/4 (BF3 uses "L Finger0", "L Finger01" etc
                      with SPACES, not "ValveBiped.Bip01_L_Finger0")
            └── L ForeTwist1 (BF3 procedural)
       └── L ArmTwist1 (BF3 procedural)
  ... plus procedural helper bones:
  L Thumb_Tip, L Index_Mid, L Index_Tip, etc. (BF3 procedural)
  R ArmTwist_1, R ArmTwist_2 (BF3 procedural)
  R Thumb_Tip, R Index_Tip, etc. (BF3 procedural)

(And a parallel right side, R Clavicle is also a root.)
```

Key differences:

| Aspect | c_arms_citizen | BF3 |
|--------|----------------|-----|
| Root bone of hand hierarchy | `ValveBiped.Bip01_Spine4` | `L Clavicle` / `R Clavicle` (each is its own root) |
| Bone name prefix | `ValveBiped.Bip01_` | None (just `L ` / `R `) |
| Bone name format | `ValveBiped.Bip01_L_Finger0` | `L Finger0` |
| Spaces in bone names | No | **YES** (`L Finger0` has a space) |
| Procedural helper bones | `L_Wrist`, `L_Ulna` (for VRD twist) | `l_thumb_tip`, `l_index_mid`, `l_armtwist_1`, etc. |
| Spine4 exists? | Yes | **No** — BF3 has no Spine4 concept |
| World position of Clavicle | ~2 units from Spine4 | ~9-10 units from origin (depends on weapon) |

### 5.3 Why this matters

When GMod's c_arms entity bonemerges to the weapon's bones, it matches by
**bone name**. So:

1. `ValveBiped.Bip01_R_Hand` (in c_arms) matches against `ValveBiped.Bip01_R_Hand`
   (in the weapon viewmodel)
2. If the weapon's bone is named `R Hand` (with space), **NO MATCH** — c_arms
   falls back to its own bind pose for that bone

So before doing anything else, the BF3 bone names MUST be renamed:

| BF3 bone name | ValveBiped bone name |
|---------------|----------------------|
| `L Clavicle` | `ValveBiped.Bip01_L_Clavicle` |
| `L UpperArm` | `ValveBiped.Bip01_L_UpperArm` |
| `L Forearm` | `ValveBiped.Bip01_L_Forearm` |
| `L Hand` | `ValveBiped.Bip01_L_Hand` |
| `L Finger0` | `ValveBiped.Bip01_L_Finger0` (thumb) |
| `L Finger01` | `ValveBiped.Bip01_L_Finger01` |
| `L Finger02` | `ValveBiped.Bip01_L_Finger02` |
| `L Finger1` | `ValveBiped.Bip01_L_Finger1` (index) |
| `L Finger11` | `ValveBiped.Bip01_L_Finger11` |
| `L Finger12` | `ValveBiped.Bip01_L_Finger12` |
| `L Finger2` | `ValveBiped.Bip01_L_Finger2` (middle) |
| `L Finger21` | `ValveBiped.Bip01_L_Finger21` |
| `L Finger22` | `ValveBiped.Bip01_L_Finger22` |
| `L Finger3` | `ValveBiped.Bip01_L_Finger3` (ring) |
| `L Finger31` | `ValveBiped.Bip01_L_Finger31` |
| `L Finger32` | `ValveBiped.Bip01_L_Finger32` |
| `L Finger4` | `ValveBiped.Bip01_L_Finger4` (pinky) |
| `L Finger41` | `ValveBiped.Bip01_L_Finger41` |
| `L Finger42` | `ValveBiped.Bip01_L_Finger42` |

(Same pattern for `R` bones.)

### 5.4 What happens when hierarchies don't match (bonemerge fails silently)

If you rename the bones correctly but the hierarchy differs:

```
c_arms:    Spine4 → Clavicle → UpperArm → Forearm → Hand → Fingers
BF3:              Clavicle → UpperArm → Forearm → Hand → Fingers   (no Spine4)
```

Then bonemerge still works **per-bone**, but:

- **Position offsets differ**: Spine4 has world pos `(0, 3.34, 58.35)`. In c_arms,
  Clavicle is positioned **relative** to Spine4 at `(2.03, 1.00, -1.94)`.
  If the weapon has Clavicle as a **root** (no parent), the bonemerge will copy
  c_arms's Clavicle world transform into the weapon's Clavicle, but the weapon's
  Clavicle world position is `(9.98, -8.83, -3.49)` (BF3) — not `(2.03, 1.00, -1.94)`.
  The c_arms mesh then renders at the BF3 weapon's Clavicle position, which is
  roughly correct (because the weapon's Clavicle IS where the shoulder should be).

- **Rotations differ**: Spine4 has rotation `(-90°, -90°, -90°)` (roughly, the
  Spine4 is rotated 90° around X and Y to orient the body facing forward). The
  Clavicle inherits this rotation, then adds its own. If BF3's Clavicle is the
  root with rotation `(0, 0, 0)`, the bones downstream will be at different
  orientations than c_arms_citizen expects.

**Symptom of hierarchy mismatch:** c_arms renders in roughly the right place
(at the weapon's shoulder area), but the fingers are twisted 90°, the thumb
is on the wrong side, or the hand is rotated wrong.

This is **exactly** the symptom we saw in the BF3 port: "fingers (except thumb)
have wrong rotations". The thumb has a different bind rotation in BF3 vs
c_arms_citizen; the index/middle/ring/pinky have similar-but-not-identical
bind rotations.

### 5.5 The hierarchy-mismatch fix

There are two ways to fix this:

**Option A: Match c_arms_citizen's bind pose exactly** (RECOMMENDED for new ports)
- Add Spine4 as the root bone, with c_arms_citizen's exact position/rotation
- Parent Clavicle to Spine4
- Use c_arms_citizen's positions AND rotations for every hand bone
- Animation keyframes are stored as deltas relative to the rest pose, so the
  animations should still play (with some retargeting artifacts)
- Risk: animation deltas may not look right if the bind pose is significantly
  different from the original

**Option B: Keep BF3 positions, replace ONLY rotations** (the path we tried
in commit `bc869425`)
- Keep BF3's bone positions (so weapon mesh renders at correct world position)
- Replace ONLY the bone rotations with c_arms_citizen's values
- Animations keep working because their stored values are absolute (SMD format)
- BUT: there's a subtle problem — when an animation has a keyframe that says
  "bone R_Hand is at rotation X", and the bind pose says "R_Hand's bind rotation
  is Y", then the engine applies X **as an absolute rotation**, not a delta.
  So if your bind rotation changes from BF3 to c_arms_citizen, the animation
  keyframes also need to be re-baked or they'll look wrong.

**Option C: Keep BF3 positions AND rotations** (what `revert_and_clean_qc.py`
did in commit `70e465d6`)
- This is the "least invasive" approach
- Result: c_arms renders correctly attached, but with deformed fingers due to
  bind pose mismatch
- This is the current state of the BF3 pack as of `bc869425`

The CORRECT approach is a hybrid:

**Option D (recommended): Retarget the animations to the c_arms_citizen bind pose**
- Replace ALL hand bone positions AND rotations with c_arms_citizen's values
  in the reference SMD and the QC `$definebone` lines
- Re-bake the animation SMDs to use the new bind pose: for each animation
  keyframe, apply the inverse of the old bind pose transform, then the new
  bind pose transform, so the visual animation looks the same but the stored
  values are now relative to the new bind pose
- This is the proper "animation retargeting" approach used by professional
  pipeline tools like Blender's Rigify retargeting or MotionBuilder

For a 32-weapon batch port, Option D is the right answer but requires
significant tooling. Option C is acceptable as a v1 and Option B is
the current approach.

---

## 6. The "c_arms Flying Away" Issue

### 6.1 Symptom

After a reload or shoot animation ends, the c_hands suddenly snap to a
position far from the weapon (often 58 units in front of the camera, or
disappearing entirely). Sometimes the hands appear at world origin `(0,0,0)`.

### 6.2 Common causes (in order of likelihood for BF3 ports)

#### Cause 1: $definebone position set to c_arms_citizen's WORLD position

**This was the bug in commit `aeec835a` (the `fix_c_arms_retarget.py` script).**

The script copied Spine4's `c_arms_citizen.smd` skeleton-section position
`(0.000006, 3.336140, 58.352139)` into the weapon's `$definebone` line:

```
$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -90.0 -79.7 -90.0 0 0 0 0 0 0
```

But that `(0, 3.34, 58.35)` is Spine4's WORLD position in the c_arms_citizen.smd
reference (where the camera is at origin and Spine4 is 58 units in front).
When the weapon's Spine4 is at `(0, 3.34, 58.35)` instead of `(0, 0, 0)`, the
**weapon's mesh** renders 58 units in front of the camera, and the c_arms
mesh (bonemerged to those bones) renders in the same wrong place.

**Fix:** Use `$origin 0 0 58` in the QC instead of putting 58 into the
Spine4 bone position. Or, keep the BF3 Spine4 (if it exists) at BF3's
original position. The `$origin` QC command shifts the entire model so the
viewmodel camera aligns with the weapon's grip.

#### Cause 2: Animation keyframes stripped for hand bones

**This was also part of the bug in commit `aeec835a`.**

The script stripped all hand-bone keyframes from animation SMDs (intending
to let bonemerge "take over"). The result: when the reload animation plays,
the hand bones have **no keyframes** — they stay at the bind pose. The c_arms
mesh then renders at the bind pose, which (if you also did Cause 1) is 58
units in front of the camera.

**Fix:** DO NOT strip hand-bone keyframes from animation SMDs. The animation
needs to drive the hand bones, and bonemerge will follow them.

#### Cause 3: Spine4 added as a new root bone, breaking the hierarchy

When you add Spine4 as a parent of Clavicle but the Clavicle was previously
a root, you change the world position of every downstream bone. The animation
keyframes (which were authored relative to Clavicle-as-root) now apply to
Clavicle-as-child-of-Spine4, which produces wrong world positions.

**Fix:** If you add Spine4, also re-bake the animations to account for the
new parent transform.

#### Cause 4: c_arms entity not parented (engine bug)

Rare. If `SWEP.UseHands = true` is set on the server but not networked to
the client, the client's c_arms entity exists but isn't parented to the
viewmodel. The c_arms renders at world origin.

**Fix:** Verify `SWEP.UseHands = true` is set in the shared (or both server
and client) file. Check `LocalPlayer():GetHands():GetParent() == LocalPlayer():GetViewModel()`
in console.

#### Cause 5: studiomdl optimised away the hand bones (no $definebone)

If you don't include `c_arms_definebones.qci` or have explicit `$definebone`
lines for the hand bones, studiomdl will strip them (because no mesh is
weighted to them). The compiled .mdl has no R_Hand bone, bonemerge fails,
and c_arms renders at its own bind pose (in world space, far from the weapon).

**Fix:** Add `$include c_arms_definebones.qci` to your weapon QC, OR include
all 38 `$definebone` lines explicitly.

#### Cause 6: $sequence references bones that don't exist

If your QC has `$sequence idle "anim.smd"` and the SMD references bone ID 47
but the QC's `$definebone` list only goes up to bone 46, studiomdl will
create a phantom bone, and animations using that bone will glitch.

**Fix:** Use `studiomdl -definebones your.qc` to auto-generate the
`$definebone` list from the reference SMD.

### 6.3 The "snap back" / "fly away" effect specifically after animation ends

SMD animations are typically authored with the first frame being the bind pose
and subsequent frames being the animation. When the animation ends and loops
back (or transitions to idle), the bones snap back to the bind pose.

If the bind pose has been changed (Cause 1, 3, or 6 above) but the animation
keyframes haven't been re-baked, the snap is visible: the bones jump from the
animation's last-frame position back to the (wrong) bind pose.

**The fix in all cases:** ensure the bind pose in the QC's `$definebone` lines
matches the rest pose (time 0) in the reference SMD's skeleton section. If
they don't match, the engine interpolates between them and you see the snap.

---

## 7. How to Properly Convert a Non-Source Weapon to c_hands

### 7.1 The correct workflow

```
[ Decompile the original game's .mdl to .qc + .smd files ]
   ↓
[ Rename bones to ValveBiped.Bip01_* names ]
   ↓
[ Strip the baked-in hand mesh from the weapon SMD ]
   ↓
[ Add c_arms_definebones.qci $include to the QC ]
   ↓
[ Add $bonemerge lines for all 38 hand bones ]
   ↓
[ Ensure Spine4 exists as the root of the hand hierarchy ]
   ↓
[ Replace hand bone positions AND rotations with c_arms_citizen's values ]
   ↓
[ Re-bake animation SMDs to use the new bind pose (CRITICAL) ]
   ↓
[ Add $ikchain rhand / $ikchain lhand if you want IK ]
   ↓
[ Set SWEP.ViewModel = "models/weapons/c_<name>.mdl" ]
   ↓
[ Set SWEP.UseHands = true ]
   ↓
[ Compile with studiomdl, test in-game ]
```

### 7.2 Whether to keep original bone positions or replace with c_arms_citizen's

**Keep original (BF3) bone positions** if:
- You can tolerate finger rotation mismatches (Option C above)
- You want to ship fast and iterate
- You don't have animation retargeting tooling

**Replace with c_arms_citizen's positions** if:
- You want the c_arms mesh to render perfectly aligned with the weapon grip
- You have the time to re-bake animations
- You want to support multiple c_arms skins (citizen, combine, etc.) — they all
  use the same bind pose, so getting it right once benefits all of them

### 7.3 Whether to strip hand-bone keyframes from animation SMDs

**NEVER strip hand-bone keyframes.**

The hand bones need to be animated by the weapon's animations (the reload
animation moves the hand to the magazine, the shoot animation moves the
hand to the charging handle, etc.). If you strip the keyframes, the bones
stay at bind pose and the c_arms mesh doesn't follow the weapon's grip
during animations.

### 7.4 Whether to add Spine4 as a new root bone

**Yes, if the original game doesn't have a Spine4 equivalent.**

c_arms_citizen has Spine4 as the root of the hand hierarchy. If your weapon
has Clavicle as a root (BF3 style), you have a hierarchy mismatch.

The proper fix:
1. Add Spine4 as a new root bone at position `(0, 0, 0)` (NOT c_arms_citizen's
   world position `(0, 3.34, 58.35)` — that's relative to the c_arms camera,
   which is wrong for a weapon viewmodel)
2. Reparent Clavicle (and Neck1, Head1 if present) to Spine4
3. Adjust Clavicle's position to be relative to Spine4 (which is now at origin,
   so Clavicle's position is its world position)
4. Re-bake all animation SMDs to account for the new parent transform

The simpler fix (Option C in section 5.5): skip the Spine4 addition and
accept that c_arms renders at BF3's Clavicle world position. This works as
long as the BF3 Clavicle world position is close to where the shoulder should
be in viewmodel space.

### 7.5 Whether to strip the original hand mesh from the weapon SMD

**YES, ALWAYS.**

The wiki explicitly says:
> The arms mesh should never be in the weapon model itself; that defeats the
> entire purpose of the system!

If the weapon SMD has triangles weighted to the hand bones (BF3's "hands"
bodygroup, or worse, hand mesh baked into the main weapon mesh), you must
strip those triangles. Otherwise you'll see:
1. The old baked-in hand mesh rendering (with broken/missing textures because
   you removed the `v_hands`/`sleeve_diffuse` materials)
2. The new c_arms mesh rendering on top of it (z-fighting, doubled hands)

For the BF3 pack, the `strip_v_hands_mesh.py` script handles this — it
parses each SMD, finds triangles whose material is `v_hands` or
`sleeve_diffuse`, and removes them. 244,625 hand triangles were stripped
across all 32 weapons.

---

## 8. Reference Examples From GitHub

### 8.1 robotboy655/gmod-animations (the canonical reference)

Cloned to: `/home/z/my-project/repos/gmod-animations/`

Files of interest:
- `c_arms_citizen.smd` — the c_arms_citizen reference SMD (46 bones, bind pose
  with positions in Source units and rotations in radians)
- `c_arms_citizen.7z` — contains `c_arms_citizen.qc`, `c_arms_citizen.smd`,
  `c_arms_citizen_glove.smd`, `c_arms_citizen_hands.smd`, `c_arms_vrd.vrd`
- `c_medkit.7z` — contains the medkit example weapon QC, including the
  critical `c_arms_definebones.qci` file
- `README.md` — brief readme

The `c_arms_citizen.qc` (extracted to `/tmp/c_arms_extract/citizen/c_arms_citizen.qc`)
shows the proper structure of the c_arms model itself:
```qc
$modelname weapons/c_arms_citizen.mdl
$cdmaterials "models\weapons\c_arms_citizen\"
$ambientboost
$body arms c_arms_citizen.smd
$sequence idle c_arms_citizen.smd fps 30
$proceduralbones "c_arms_vrd.vrd"
$includemodel weapons/c_arms_animations.mdl
$bodygroup glove {
    studio c_arms_citizen_hands.smd
    studio c_arms_citizen_glove.smd
}
$texturegroup "skinfamilies"
{
    { "c_arms_citizen_sleeves" "c_arms_citizen_hands" }
    { "c_arms_citizen_sleeves" "c_arms_citizen_hands_black" }
    { "c_arms_citizen_infected_sleeves" "c_arms_citizen_infected_hands" }
}
// DEFINEBONES
$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000000
... (38 more $definebone lines for every hand bone)
```

### 8.2 The c_medkit example weapon (the canonical "how to use c_arms" reference)

Extracted to `/tmp/c_arms_extract/medkit/`. The `c_medkit.qc`:
```qc
$modelname weapons/c_medkit.mdl
$include c_arms_definebones.qci    // CRITICAL — prevents studiomdl optimising away bones
$body studio "c_medkit.smd"
$cdmaterials models/items/
$origin 0 0 66                    // shifts the model so viewmodel camera aligns with weapon grip

// IK chains (optional — for hand-sticking-to-weapon animations)
$ikchain rhand "ValveBiped.Bip01_R_Hand" Z 0 knee 0.707 0.707 0
$ikchain lhand "ValveBiped.Bip01_L_Hand" Z 0 knee 0.707 0.707 0

// Additive idle layer (uses IK to keep left hand on medkit)
$animation a_idle_layer "anim_idle_layer" subtract a_idle_layer 0 ikrule lhand touch "medkit_bone" usesource fixuploop 0 120
$sequence anim_idle_layer a_idle_layer delta loop fps 30 hidden autoplay realtime

// Sequences (with IK rule to stick left hand to medkit_bone)
$sequence anim_ref  "c_medkit" fps 01 loop
$sequence anim_draw "anim_draw" fps 30 activity ACT_VM_DRAW 1 ikrule lhand touch "medkit_bone" usesource
$sequence anim_idle "anim_draw" fps 01 frames 35 35 loop ACT_VM_IDLE 1 ikrule lhand touch "medkit_bone" usesource
$sequence anim_fire "anim_fire" fps 30 ACT_VM_PRIMARYATTACK 1 ikrule lhand touch "medkit_bone" usesource
$sequence anim_holster "anim_holster" fps 30 loop ACT_VM_HOLSTER 1 ikrule lhand touch "medkit_bone" usesource
```

The `c_arms_definebones.qci` (also in Appendix B):
- 38 `$definebone` lines for every hand bone, with positions in Source units
  and rotations in **degrees** (not radians — `$definebone` uses degrees,
  SMD skeleton sections use radians)
- 38 `$bonemerge` lines for every hand bone

### 8.3 LeRatEmperor/ghosts_wavy_s_nzombies_weapons (COD Ghosts port — has working c_hands)

Cloned to: `/home/z/my-project/repos/ghosts_weapons/`

Key finding from `c-hands-final-fix` worklog entry:
> Decompiled c_m27_lmg.mdl (Ghosts weapon) — discovered Ghosts uses a HYBRID bone system:
> - j_* bones (j_shoulder_le, j_wrist_le, j_thumb_le_0, etc.) which the weapon mesh is weighted to
> - ValveBiped.Bip01_* bones as CHILDREN of the j_* bones, with c_arms_citizen-compatible ROTATIONS
> - Bonemerge on both j_* and ValveBiped bones
> - Animations animate the j_* bones, which moves the ValveBiped bones (which c_arms attaches to)

This is a more sophisticated approach than the BF3 port: keep the original
game bones (so weapon mesh and animations work), but ADD ValveBiped bones
as children with c_arms_citizen-compatible rotations. The c_arms bonemerges
to the ValveBiped bones, which follow the j_* bones through the parent chain.

### 8.4 TFA Base (has c_hands support hooks)

Cloned to: `/home/z/my-project/repos/tfa_base/`

TFA Base handles c_hands through the standard SWEP.UseHands mechanism. The
relevant code is in `lua/tfa/documentation/tfa_base_template.lua` (search
for `UseHands`). TFA doesn't do anything special — it relies on the engine
to parent and bonemerge the c_arms entity.

---

## 9. Common Pitfalls

### 9.1 Stripping animation keyframes for hand bones

**Symptom:** c_hands don't animate during reload/draw/fire.

**Cause:** A script (like `fix_c_arms_retarget.py` did in commit `aeec835a`)
removed all hand-bone keyframes from animation SMDs.

**Fix:** Restore the original animation SMDs. The hand bones MUST be animated
by the weapon's animations — that's how the c_arms mesh follows the weapon.

### 9.2 Changing bone positions to c_arms_citizen's world positions

**Symptom:** c_hands appear in front of the camera (typically 58 units away,
at world position `(0, 3.34, 58.35)`), not at the weapon's grip.

**Cause:** `c_arms_citizen.smd`'s Spine4 bone is at world position `(0, 3.34,
58.35)`. If you copy this directly into your weapon's `$definebone` line, the
weapon's Spine4 (and every bone downstream) is positioned 58 units in front
of the camera.

**Fix:** Use `$origin 0 0 58` in the QC instead of putting 58 in the Spine4
position. The `$origin` command shifts the entire model so the viewmodel
camera aligns with the weapon grip; the bones themselves stay at their
"natural" positions (which should be near origin for a weapon viewmodel).

### 9.3 Adding Spine4 as a root bone when it doesn't exist in the original

**Symptom:** Animations break, bones render in wrong positions.

**Cause:** Adding Spine4 changes the parent chain. Animation keyframes were
authored relative to Clavicle-as-root; now they're applied relative to
Clavicle-as-child-of-Spine4, producing different world positions.

**Fix:** If you add Spine4, also re-bake all animation SMDs by applying the
inverse of the new parent transform to every keyframe. This is non-trivial
and requires retargeting tooling.

### 9.4 Baking hand mesh into the main weapon mesh SMD

**Symptom:** Old baked-in hand mesh renders with missing textures (because
the `v_hands` material was removed but the mesh geometry is still in the SMD).

**Cause:** 9 of the 32 BF3 weapons (g18, m1911, m249, m82a3, m9, m93r, mp412,
mp443, sv98) have their hand mesh baked directly into the main weapon mesh
SMD, not in a separate bodygroup. The hands bodygroup removal didn't catch
these.

**Fix:** Use a script like `strip_v_hands_mesh.py` to scan every SMD, find
triangle blocks whose material name is `v_hands` or `sleeve_diffuse`, and
remove those triangles entirely.

### 9.5 Forgetting $include c_arms_definebones.qci (or equivalent $definebone lines)

**Symptom:** c_hands don't render at all, or render at the model origin.

**Cause:** Without explicit `$definebone` lines, studiomdl optimises away the
hand bones (because no mesh is weighted to them). The compiled .mdl has no
R_Hand bone, bonemerge finds no match, c_arms falls back to its bind pose.

**Fix:** Add `$include "c_arms_definebones.qci"` to the QC. The file is in
the gmod-animations repo's `c_medkit.7z` archive (also extracted to
`/tmp/c_arms_extract/medkit/c_arms_definebones.qci` and reproduced in
Appendix B).

### 9.6 Setting SWEP.ViewModel to a v_ model (instead of c_)

**Symptom:** c_hands don't render at all.

**Cause:** The c_arms entity only attaches to viewmodels whose path starts
with `models/weapons/c_*.mdl` (the `c_` prefix). If you set
`SWEP.ViewModel = "models/weapons/v_pistol.mdl"`, the engine treats it as
a legacy v_model and doesn't parent c_arms.

**Fix:** Always name your compiled viewmodel `c_<name>.mdl`. Use
`$modelname "weapons/c_<name>.mdl"` in the QC.

### 9.7 Setting SWEP.UseHands = false (or not setting it)

**Symptom:** c_hands don't render at all.

**Cause:** Without `SWEP.UseHands = true`, the engine doesn't create the
c_arms entity for that weapon.

**Fix:** Set `SWEP.UseHands = true` in the weapon's shared.lua.

### 9.8 Custom gamemode missing ply:SetupHands() in GM:PlayerSpawn

**Symptom:** c_hands don't render at all (in a custom gamemode).

**Cause:** The c_arms entity is created by `ply:SetupHands()` which is
normally called from `GM:PlayerSpawn`. Sandbox calls it; custom gamemodes
might not.

**Fix:** Add `ply:SetupHands()` at the end of your `GM:PlayerSpawn`.

### 9.9 Custom gamemode missing GM:PostDrawViewModel hooks

**Symptom:** c_hands don't render at all (in a custom gamemode).

**Cause:** The c_arms entity is drawn by `GM:PostDrawViewModel` which calls
`LocalPlayer():GetHands():DrawModel()`. Sandbox has this; custom gamemodes
might not.

**Fix:** Add the `GM:PostDrawViewModel` hook (see section 1.3).

### 9.10 Wrong bone name (extra space, missing dot, etc.)

**Symptom:** Some fingers work, others don't. Or all of one side works,
the other side doesn't.

**Cause:** Bonemerge matches by EXACT bone name string. `ValveBiped.Bip01_R_Hand`
will not match `R Hand` (BF3-style with space) or `ValveBiped_Bip01_R_Hand`
(underscore instead of dot) or `ValveBiped.Bip01_R_hand` (lowercase h).

**Fix:** Rename ALL bones to the exact ValveBiped.Bip01_* names. Verify by
dumping the bone list with `Entity:GetBoneName(i)` for i=0..GetBoneCount()-1
in-game.

---

## 10. Correct Pipeline for BF3 Weapons Specifically

### 10.1 BF3 bone name conventions

BF3 viewmodels use bone names like:
- `L Clavicle`, `R Clavicle` (with space)
- `L UpperArm`, `R UpperArm`
- `L Forearm`, `R Forearm`
- `L Hand`, `R Hand`
- `L Finger0` (thumb), `L Finger01`, `L Finger02`
- `L Finger1` (index), `L Finger11`, `L Finger12`
- `L Finger2` (middle), `L Finger21`, `L Finger22`
- `L Finger3` (ring), `L Finger31`, `L Finger32`
- `L Finger4` (pinky), `L Finger41`, `L Finger42`
- BF3 procedural: `l_thumb_tip`, `l_thumb_mid`, `l_thumb_low`,
  `l_index_tip`, `l_index_mid`, `l_index_low`, etc.
- BF3 procedural twists: `l_armtwist_1`, `r_armtwist_1`, etc.

### 10.2 What needs to be renamed vs kept

**Rename to ValveBiped.Bip01_*:**
- All 38 hand bones (Clavicle through Finger42, both sides)
- Spine4 must be ADDED if not present

**Keep as BF3 names (do NOT rename):**
- The `Weapon` bone (or whatever the weapon mesh is weighted to)
- Attachment bones like `muzzle`, `ejection_port`, `shell_origin`
- Any other non-hand bones

**Remove entirely (delete from nodes + skeleton + animations):**
- BF3 procedural bones: `l_thumb_tip`, `l_thumb_mid`, `l_thumb_low`,
  `l_index_tip`, etc. (c_arms has its own Wrist/Ulna procedural bones)
- `l_armtwist_1` through `l_armtwist_6` (BF3 arm twist helpers —
  c_arms uses the VRD file for arm twists)
- `l_wrist`, `r_wrist` (BF3 wrist helper — c_arms has ValveBiped.Bip01_R_Wrist)

### 10.3 Whether to remove the BF3 procedural bones

**Yes, remove them.**

The BF3 procedural bones (`l_thumb_tip`, `l_index_mid`, etc.) are not part of
the c_arms_citizen skeleton. Keeping them:
- Wastes bone count (max 128 bones per model in Source)
- Causes confusion during animation retargeting
- Can confuse Source's IK solver

Just delete them from the `nodes` section, the `skeleton` section, and any
animation keyframes that reference them.

### 10.4 How to handle the baked-in hand mesh

**Strip it from every SMD file.**

For each .smd in the weapon's source folder:
1. Parse the `triangles` section
2. For each triangle block (material name + 3 vertex lines):
   - If the material name is `v_hands`, `sleeve_diffuse`, `sleeve_diff`, or
     `t_phoenix` (BF3's hand textures), delete that triangle block
3. Write the cleaned SMD back

Also clean the QC:
- Remove `v_hands` and `sleeve_diffuse` from `$texturegroup`
- Remove `$cdmaterials "models\weapons\v_models\hands\"`
- Remove any bodygroup that was just for the hand mesh

### 10.5 Step-by-step pipeline (the recommended approach)

This is the pipeline that should have been followed for the BF3 pack. It
combines learnings from all three failed attempts.

#### Step 1: Decompile

Use Crowbar to decompile each `c_<weapon>.mdl` to:
- `<weapon>.qc`
- `<weapon>_reference.smd` (mesh + bind pose)
- `<weapon>_anims/*.smd` (one SMD per animation)
- `<weapon>_phys.smd` (physics, if any)

#### Step 2: Rename bones in EVERY SMD and the QC

For each .smd file and the .qc file:
- Replace `"L Clavicle"` → `"ValveBiped.Bip01_L_Clavicle"`
- Replace `"L UpperArm"` → `"ValveBiped.Bip01_L_UpperArm"`
- ... (see Appendix A for the full mapping table)
- Same for R_* bones

Use a script that handles:
- Bone names in the `nodes` section of SMDs (format: `<id> "<name>" <parent_id>`)
- Bone names in `$definebone` lines in the QC (format: `$definebone "<name>" "<parent>"...`)
- Bone names in `$bonemerge` lines in the QC

#### Step 3: Remove BF3 procedural bones

For each .smd file and the .qc file:
- Delete the `nodes` entry for any bone matching `^[lr]_(thumb|index|middle|ring|pinky)_(tip|mid|low)$`
- Delete the `nodes` entry for any bone matching `^[lr]_(armtwist_\d|wrist|upperarm)$`
- Delete the corresponding `skeleton` lines (in every time block, including
  animation keyframes) for those bone IDs
- Delete the corresponding `$definebone` lines in the QC

#### Step 4: Add Spine4 as the root bone

If Spine4 doesn't exist in the BF3 skeleton (it doesn't), add it:
- In the `nodes` section of every SMD: add `0 "ValveBiped.Bip01_Spine4" -1`
  (renumber the existing root bone from -1 to 0 — i.e., reparent Clavicle to Spine4)
- In the `skeleton` section time 0: add `0 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000`
  (Spine4 at origin, no rotation — NOT c_arms_citizen's world position!)
- In the QC: add `$definebone "ValveBiped.Bip01_Spine4" "" 0 0 0 0 0 0 0 0 0 0 0 0`

Then reparent L_Clavicle and R_Clavicle (and Neck1 if present) to Spine4
in both the SMD `nodes` section and the QC `$definebone` lines.

#### Step 5: Replace hand bone positions AND rotations with c_arms_citizen's values

In the QC's `$definebone` lines AND the reference SMD's `skeleton` section
(time 0 only — don't touch animation keyframes), replace each hand bone's
position and rotation with the c_arms_citizen reference values from section 2.2.

**Important unit conversion:**
- c_arms_citizen.smd uses **radians** for rotations
- $definebone lines use **degrees** for rotations
- Convert: `degrees = radians * 180 / pi`

Example for Spine4:
- c_arms_citizen.smd says: `1 0.000006 3.336140 58.352139 -1.570799 -1.391900 -1.570795`
- That's position `(0.000006, 3.336140, 58.352139)` and rotation `(-1.570799, -1.391900, -1.570795)` rad
- But we want Spine4 at the weapon origin, NOT at the c_arms camera position
- So the weapon's Spine4 `$definebone` should be: `$definebone "ValveBiped.Bip01_Spine4" "" 0 0 0 0 0 0 0 0 0 0 0 0`
- Then use `$origin 0 0 58` (or whatever offset) in the QC to shift the whole
  model into view

For the OTHER hand bones (Clavicle, UpperArm, etc.), use c_arms_citizen's
**relative** positions and rotations (relative to the parent bone) as listed
in section 2.2. These are the same in c_arms_citizen because Spine4 is at
the model origin there too (the `(0, 3.34, 58.35)` is the WORLD position
after the c_arms_citizen's `$origin` shifts it; in the SMD file itself,
Spine4 is at world origin).

Wait — let me re-check that. Looking at `c_arms_citizen.smd`:
```
1 0.000006 3.336140 58.352139 -1.570799 -1.391900 -1.570795
```
Spine4 (bone id 1) has position `(0.000006, 3.336140, 58.352139)` and rotation
`(-1.570799, -1.391900, -1.570795)`. Spine4 is a ROOT bone (parent -1), so
this is its world position.

So Spine4's world position in the c_arms_citizen.smd is `(0, 3.34, 58.35)`.
This is because c_arms_citizen is a standalone model (no `$origin` shift).

For a weapon viewmodel, we want Spine4 at the model origin (so the weapon
mesh + hand bones are all positioned correctly relative to the viewmodel
camera). So:
- Set Spine4 to `(0, 0, 0)` with rotation `(0, 0, 0)` in the weapon QC
- Use `$origin 0 0 <offset>` to shift the entire model into view if needed

For the OTHER hand bones, their positions/rotations in c_arms_citizen.smd
are **relative to their parent** (because they're not root bones). So you
can copy them directly:
- L_Clavicle: parent Spine4, position `(2.03, 1.00, 1.94)`, rotation `(-73.71, 168.62, 91.48)` deg
- L_UpperArm: parent L_Clavicle, position `(6.03, 0, 0)`, rotation `(2.74, -33.53, -90.51)` deg
- ... etc.

These are the values from `c_arms_definebones.qci` (Appendix B).

#### Step 6: Add $bonemerge and $include c_arms_definebones.qci to the QC

After the `$definebone` lines, add:
```
$include "c_arms_definebones.qci"
```
(This both defines the bones AND adds bonemerge — see Appendix B.)

OR, if you've already added the `$definebone` lines manually (Step 5), just
add the `$bonemerge` lines (38 lines for the hand bones, see section 2.3).

#### Step 7: Re-bake animation SMDs to use the new bind pose

**THIS IS THE CRITICAL STEP THAT THE PREVIOUS ATTEMPTS SKIPPED.**

When you change a bone's bind pose (position/rotation), the animation
keyframes need to be re-baked. Otherwise the animations will look wrong
because the keyframes were authored relative to the old bind pose.

The re-baking process:
1. For each animation SMD, for each keyframe, for each hand bone:
   - Get the old bind pose transform (position + rotation)
   - Get the new bind pose transform (from c_arms_citizen reference)
   - Compute the relative transform: `delta = inverse(old_bind) * keyframe`
   - Apply to new bind: `new_keyframe = new_bind * delta`
2. Write the new keyframe values back to the SMD

This is non-trivial math (matrix decomposition, quaternion interpolation).
Use Blender's Python API or a custom Python script with `numpy`.

**ALTERNATIVE:** If you don't re-bake, you have two options:
- (A) Accept that the c_arms mesh will be slightly deformed during animations
  (the c_arms mesh follows the bones, but the bones don't quite match the
  animations' intended pose)
- (B) Keep the BF3 bind pose for the hand bones (Option C in section 5.5),
  accepting that the c_arms mesh will be deformed in the bind pose but
  animations will play correctly

The current BF3 pack uses option (B). Option (A) would require re-baking.

#### Step 8: Strip hand mesh from SMDs

Run a script like `strip_v_hands_mesh.py` to remove all `v_hands` and
`sleeve_diffuse` triangle blocks from every SMD.

#### Step 9: Clean the QC

- Remove `v_hands` and `sleeve_diffuse` from `$texturegroup`
- Remove `$cdmaterials "models\weapons\v_models\hands\"`
- Remove any bodygroup that was just for the hand mesh

#### Step 10: Compile

```bash
studiomdl <weapon>.qc
```

Verify:
- The compiled .mdl is at `models/weapons/c_<name>.mdl`
- The .mdl has 38+ bones (use `mdlinfo` or Crowbar to inspect)
- No `v_hands` or `sleeve_diffuse` material references in the .mdl

#### Step 11: Lua side

```lua
-- In shared.lua (or whatever your weapon's main file is):
SWEP.ViewModel = "models/weapons/c_<name>.mdl"
SWEP.UseHands = true
```

#### Step 12: Test in-game

Spawn the weapon, switch to it, look at the c_hands:
- Are they rendering at all? (If not, check Step 6 — $bonemerge + $definebone)
- Are they rendering at the right position? (If not, check Step 5 — bone positions)
- Are they deformed in the bind pose? (If yes, check Step 5 — bone rotations)
- Do they animate during reload/draw/fire? (If not, check Step 7 — animation retargeting)
- Are there old hand mesh triangles overlapping the c_hands? (If yes, check Step 8 — strip hand mesh)

---

## Appendix A: Full Bone-Name Mapping Table (BF3 → ValveBiped)

### A.1 Bone names — direct renames

| BF3 bone name | ValveBiped bone name |
|---------------|----------------------|
| `L Clavicle` | `ValveBiped.Bip01_L_Clavicle` |
| `L UpperArm` | `ValveBiped.Bip01_L_UpperArm` |
| `L Forearm` | `ValveBiped.Bip01_L_Forearm` |
| `L Hand` | `ValveBiped.Bip01_L_Hand` |
| `L Finger0` | `ValveBiped.Bip01_L_Finger0` (thumb) |
| `L Finger01` | `ValveBiped.Bip01_L_Finger01` |
| `L Finger02` | `ValveBiped.Bip01_L_Finger02` |
| `L Finger1` | `ValveBiped.Bip01_L_Finger1` (index) |
| `L Finger11` | `ValveBiped.Bip01_L_Finger11` |
| `L Finger12` | `ValveBiped.Bip01_L_Finger12` |
| `L Finger2` | `ValveBiped.Bip01_L_Finger2` (middle) |
| `L Finger21` | `ValveBiped.Bip01_L_Finger21` |
| `L Finger22` | `ValveBiped.Bip01_L_Finger22` |
| `L Finger3` | `ValveBiped.Bip01_L_Finger3` (ring) |
| `L Finger31` | `ValveBiped.Bip01_L_Finger31` |
| `L Finger32` | `ValveBiped.Bip01_L_Finger32` |
| `L Finger4` | `ValveBiped.Bip01_L_Finger4` (pinky) |
| `L Finger41` | `ValveBiped.Bip01_L_Finger41` |
| `L Finger42` | `ValveBiped.Bip01_L_Finger42` |
| `R Clavicle` | `ValveBiped.Bip01_R_Clavicle` |
| `R UpperArm` | `ValveBiped.Bip01_R_UpperArm` |
| `R Forearm` | `ValveBiped.Bip01_R_Forearm` |
| `R Hand` | `ValveBiped.Bip01_R_Hand` |
| `R Finger0` | `ValveBiped.Bip01_R_Finger0` |
| `R Finger01` | `ValveBiped.Bip01_R_Finger01` |
| `R Finger02` | `ValveBiped.Bip01_R_Finger02` |
| `R Finger1` | `ValveBiped.Bip01_R_Finger1` |
| `R Finger11` | `ValveBiped.Bip01_R_Finger11` |
| `R Finger12` | `ValveBiped.Bip01_R_Finger12` |
| `R Finger2` | `ValveBiped.Bip01_R_Finger2` |
| `R Finger21` | `ValveBiped.Bip01_R_Finger21` |
| `R Finger22` | `ValveBiped.Bip01_R_Finger22` |
| `R Finger3` | `ValveBiped.Bip01_R_Finger3` |
| `R Finger31` | `ValveBiped.Bip01_R_Finger31` |
| `R Finger32` | `ValveBiped.Bip01_R_Finger32` |
| `R Finger4` | `ValveBiped.Bip01_R_Finger4` |
| `R Finger41` | `ValveBiped.Bip01_R_Finger41` |
| `R Finger42` | `ValveBiped.Bip01_R_Finger42` |

### A.2 Bones to ADD (don't exist in BF3)

| New bone name | Parent | Position | Rotation (deg) | Purpose |
|---------------|--------|----------|-----------------|---------|
| `ValveBiped.Bip01_Spine4` | (root) | `(0, 0, 0)` | `(0, 0, 0)` | Root of hand hierarchy |
| `ValveBiped.Bip01_L_Wrist` | `L_Forearm` | `(11.482, 0, 0)` | `(0, 0, 0)` | Procedural VRD bone (optional) |
| `ValveBiped.Bip01_R_Wrist` | `R_Forearm` | `(11.482, 0, 0)` | `(0, 0, 0)` | Procedural VRD bone (optional) |
| `ValveBiped.Bip01_L_Ulna` | `L_Forearm` | `(5.741, 0, 0)` | `(0, 0, 0)` | Procedural VRD bone (optional) |
| `ValveBiped.Bip01_R_Ulna` | `R_Forearm` | `(5.741, 0, 0)` | `(0, 0, 0)` | Procedural VRD bone (optional) |

### A.3 Bones to REMOVE (BF3 procedural, not in c_arms_citizen)

| BF3 bone name pattern | Action |
|-----------------------|--------|
| `l_thumb_tip`, `l_thumb_mid`, `l_thumb_low` | DELETE |
| `l_index_tip`, `l_index_mid`, `l_index_low` | DELETE |
| `l_middle_tip`, `l_middle_mid`, `l_middle_low` | DELETE |
| `l_ring_tip`, `l_ring_mid`, `l_ring_low` | DELETE |
| `l_pinky_tip`, `l_pinky_mid`, `l_pinky_low` | DELETE |
| `r_thumb_tip`, `r_thumb_mid`, `r_thumb_low` | DELETE |
| `r_index_tip`, `r_index_mid`, `r_index_low` | DELETE |
| `r_middle_tip`, `r_middle_mid`, `r_middle_low` | DELETE |
| `r_ring_tip`, `r_ring_mid`, `r_ring_low` | DELETE |
| `r_pinky_tip`, `r_pinky_mid`, `r_pinky_low` | DELETE |
| `l_armtwist_1` through `l_armtwist_6` | DELETE |
| `r_armtwist_1` through `r_armtwist_6` | DELETE |
| `l_wrist`, `r_wrist` | DELETE (replaced by ValveBiped.Bip01_[LR]_Wrist) |
| `l_upperarm`, `r_upperarm` | DELETE |

### A.4 Materials to strip from SMDs and QCs

| Material name | Where found | Action |
|---------------|-------------|--------|
| `v_hands` | BF3 hand mesh (bodygroup or baked into weapon mesh) | Strip triangles + remove from $texturegroup + remove $cdmaterials |
| `sleeve_diffuse` | BF3 sleeve mesh | Strip triangles + remove from $texturegroup + remove $cdmaterials |
| `sleeve_diff` | BF3 sleeve mesh (alt name) | Strip triangles + remove from $texturegroup |
| `t_phoenix` | BF3 character hand texture | Strip triangles + remove from $texturegroup |

### A.5 Bone definitions reference (c_arms_citizen values, in degrees for $definebone)

These are the values to use in your weapon's `$definebone` lines. They are
the c_arms_citizen.smd values converted from radians to degrees.

```
$definebone "ValveBiped.Bip01_Spine4" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033348 1.000767 1.937660 -73.711880 168.619300 91.480563 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028144 0 0 2.738853 -33.527937 -90.505158 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692554 0 0 0 -3.459062 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481676 0 0 -6.108482 2.532071 90.136744 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859704 -0.142403 -1.191974 8.682203 -50.431563 -26.822049 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312561 0 0 0 -25.194099 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729366 0 0 0 -13.997301 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942327 0.046768 -0.431443 4.194394 -46.466010 -8.696352 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539093 0 0 0 -14.197715 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196323 0 0 0 -24.683134 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883689 -0.046768 0.431443 1.250766 -33.682286 4.921822 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719578 0 0 0.316047 -20.997629 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209183 0 0 0.176703 -12.398794 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859860 -0.137947 1.332466 -2.449396 -30.465192 20.308432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0 0 0.233428 -20.798876 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099670 0 0 0.148745 -13.999131 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806048 -0.348923 1.321258 -38.916041 -45.195987 -70.054232 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789783 0 0 0 13.093406 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.206999 0 0 0 20.790348 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033356 1.000772 -1.937610 73.712051 168.618794 -95.596517 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028142 0 0 -0.462090 -33.623802 93.935244 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692551 0 0 0 -3.459061 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481699 0 0 6.108067 2.532072 -89.664286 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859674 -0.132568 1.193108 -9.056515 -50.352978 26.713357 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312561 0 0 0 -25.191357 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729366 0 0 0 -13.995702 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942293 0.050327 0.431043 -4.537310 -46.421337 8.598839 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539097 0 0 0 -14.196230 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196323 0 0 0 -24.680781 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883656 -0.050331 -0.431043 -1.512838 -33.672457 -4.921995 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719580 0 0 -0.456876 -20.995242 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209183 0 0 -0.255597 -12.397431 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859829 -0.148941 -1.331282 2.209728 -30.481420 -20.306714 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719427 0 0 -0.378897 -20.796652 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099663 0 0 -0.241274 -13.998049 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806015 -0.359837 -1.318334 38.596443 -45.467528 69.981641 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789783 0 0 0 13.095237 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.207001 0 0 0 20.792925 0 0 0 0 0 0 0
```

(All values rounded to 6 decimal places. The fixup block — the trailing 6
zeros — is included for studiomdl compatibility. Note that the c_arms_definebones.qci
reference has tiny non-zero values in the fixup block; using zeros is acceptable
for weapons without their own IK chains.)

---

## Appendix B: Full c_arms_definebones.qci Reference

This is the file from the medkit example, included verbatim. Place a copy at
`models/weapons/c_arms_definebones.qci` (or wherever your QC's `$include`
points) and add `$include "c_arms_definebones.qci"` to your weapon QC.

```
$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033349 1.000767 1.937660 -73.711860 168.619273 91.480543 0.000000 0.000000 0.000000 -0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 2.738853 -33.527944 -90.505158 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692556 0.000001 0.000003 -0.000003 -3.459061 -0.000001 0.000000 0.000000 0.000000 -0.000003 -0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481674 0.000001 -0.000032 -6.108477 2.532073 90.136744 0.000000 0.000000 0.000000 0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859707 -0.142403 -1.191975 8.682203 -50.431563 -26.822042 0.000002 0.000000 0.000000 -0.000001 0.000007 0.000003
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312557 0.000000 0.000002 -0.000001 -25.194099 0.000003 0.000001 0.000000 0.000000 -0.000001 0.000000 0.000003
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729364 -0.000002 -0.000001 -0.000002 -13.997301 0.000005 -0.000001 0.000000 0.000000 -0.000002 -0.000002 0.000005
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942333 0.046767 -0.431443 4.194397 -46.466010 -8.696352 0.000000 0.000000 0.000000 0.000001 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539097 0.000000 0.000000 0.000000 -14.197715 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196325 -0.000002 -0.000001 0.000000 -24.683134 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883694 -0.046766 0.431443 1.250768 -33.682286 4.921822 0.000000 -0.000002 0.000000 0.000002 0.000013 0.000002
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719572 -0.000004 -0.000001 0.316047 -20.997629 0.000001 0.000000 0.000000 0.000000 0.000004 0.000013 0.000001
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209173 -0.000002 -0.000000 0.176703 -12.398796 0.000000 0.000000 0.000004 0.000000 0.000003 0.000010 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859863 -0.137946 1.332466 -2.449394 -30.465192 20.308434 0.000000 0.000000 0.000000 0.000004 0.000011 0.000002
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000002 -0.000002 0.233428 -20.798876 0.000000 -0.000002 0.000002 0.000000 0.000005 0.000009 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000000 0.000000 0.148745 -13.999132 -0.000002 0.000000 -0.000002 0.000000 0.000004 0.000005 -0.000002
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806053 -0.348924 1.321258 -38.916041 -45.195987 -70.054232 0.000000 0.000000 0.000002 -0.000011 -0.000000 0.000002
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789782 -0.000002 0.000002 -0.000009 13.093406 0.000000 0.000000 0.000000 0.000000 -0.000009 0.000003 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207006 0.000000 0.000000 -0.000009 20.790348 -0.000003 0.000000 0.000000 0.000000 -0.000009 0.000004 -0.000003
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033356 1.000772 -1.937610 73.712038 168.618781 -95.596497 0.000000 0.000000 0.000000 0.000000 0.000000 0.000002
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000000 -0.000000 -0.462090 -33.623802 93.935244 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692554 0.000001 0.000004 -0.000003 -3.459062 -0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481697 0.000001 0.000003 6.108071 2.532072 -89.664286 0.000000 0.000000 0.000000 0.000001 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859676 -0.132571 1.193109 -9.056514 -50.352978 26.713357 0.000000 0.000002 0.000000 -0.000003 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312559 -0.000002 0.000001 -0.000003 -25.191357 0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000009 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729364 0.000000 -0.000001 -0.000002 -13.995702 0.000002 0.000000 0.000000 -0.000001 -0.000002 -0.000005 0.000002
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942303 0.050328 0.431044 -4.537309 -46.421337 8.598836 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000002
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539099 -0.000002 0.000000 -0.000001 -14.196238 0.000000 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196321 0.000004 -0.000000 -0.000000 -24.680792 0.000001 0.000000 0.000000 0.000000 -0.000000 -0.000003 0.000001
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883659 -0.050324 -0.431042 -1.512837 -33.672457 -4.921995 0.000000 0.000000 0.000000 0.000001 -0.000012 -0.000001
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719578 0.000002 -0.000000 -0.456875 -20.995249 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000010 -0.000001
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209183 0.000002 -0.000000 -0.255595 -12.397439 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000007 -0.000001
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859837 -0.148935 -1.331282 2.209727 -30.481417 -20.306713 0.000000 0.000000 0.000000 0.000003 -0.000003 0.000003
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719425 0.000000 0.000000 -0.378893 -20.796658 0.000002 0.000002 0.000000 0.000000 0.000004 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099665 0.000002 0.000000 -0.241269 -13.998056 -0.000002 0.000001 0.000002 0.000000 0.000003 -0.000007 -0.000002
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806021 -0.359836 -1.318334 38.596443 -45.467528 69.981641 0.000000 0.000000 0.000000 -0.000003 -0.000004 0.000005
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789782 0.000000 -0.000004 -0.000004 13.095237 0.000003 -0.000002 0.000000 0.000000 -0.000004 -0.000002 0.000003
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.206999 0.000001 0.000002 -0.000003 20.792925 0.000002 0.000000 0.000000 0.000000 -0.000003 -0.000000 0.000002

$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
```

**IMPORTANT:** This QCI's `$definebone` lines use c_arms_citizen's CAMERA-RELATIVE
positions (Spine4 at world `(0, 3.34, 58.35)`). If you `$include` this file
directly in your weapon QC, Spine4 will be at world `(0, 3.34, 58.35)` — i.e.
58 units in front of the camera. THIS IS WHY commit `aeec835a` broke c_hands.

**The correct way to use c_arms_definebones.qci:**
- For c_arms_citizen itself (a standalone hand model), `$include` it directly
  and use `$origin 0 0 0`
- For a weapon viewmodel, DO NOT `$include` c_arms_definebones.qci directly.
  Instead, write your own `$definebone` lines with Spine4 at `(0, 0, 0)` and
  the rest of the hand bones using c_arms_citizen's RELATIVE positions (which
  are the same as their c_arms_citizen.smd values, since Spine4 is the parent
  of Clavicle and Spine4 is at origin in the weapon QC).

Use the values from Appendix A.5 instead of `$include c_arms_definebones.qci`.

The `$bonemerge` lines can still be copied directly (they're just bone names,
no positions).

---

## Appendix C: Diagnostic Checklist

Use this checklist when c_hands aren't working. Go through each item in order.

### C.1 Quick checks (no recompile needed)

- [ ] `SWEP.UseHands = true` is set in the weapon's shared file
- [ ] `SWEP.ViewModel = "models/weapons/c_<name>.mdl"` (starts with `c_`)
- [ ] The compiled .mdl is at `models/weapons/c_<name>.mdl` (not `v_`)
- [ ] Player model has a hands entry (`player_manager.TranslatePlayerHands`
     returns a valid model — sandbox default does this)
- [ ] Run `print(LocalPlayer():GetHands())` in console — should not be `NULL`
- [ ] Run `print(LocalPlayer():GetHands():GetModel())` — should be
     `models/weapons/c_arms_citizen.mdl` or similar
- [ ] Run `print(LocalPlayer():GetHands():GetParent())` — should be
     `[Weapon]` (the viewmodel entity)

### C.2 Inspection of the compiled .mdl

Use Crowbar or `mdlinfo` to inspect the .mdl:

- [ ] Model name is `weapons/c_<name>.mdl`
- [ ] Bone list contains all 38 ValveBiped hand bones (Spine4, Clavicle,
     UpperArm, Forearm, Hand, all 15 Finger×3 bones for L+R)
- [ ] No BF3 procedural bones remain (no `l_thumb_tip`, `l_index_mid`, etc.)
- [ ] No `l_armtwist_*` or `r_armtwist_*` bones remain
- [ ] All hand bones have the `$bonemerge` flag set (Crowbar shows this)
- [ ] No `v_hands`, `sleeve_diffuse`, `sleeve_diff`, or `t_phoenix` materials
     referenced in the .mdl's material list
- [ ] No bodygroup named "hands" or that contains hand mesh

### C.3 Inspection of the QC file

- [ ] `$modelname "weapons/c_<name>.mdl"` (starts with `c_`)
- [ ] `$definebone "ValveBiped.Bip01_Spine4" "" 0 0 0 0 0 0 ...` (Spine4 at
     ORIGIN, not at `(0, 3.34, 58.35)` — that's the c_arms_citizen camera-
     relative position, NOT the weapon position)
- [ ] `$definebone` lines exist for all 38 hand bones with c_arms_citizen's
     RELATIVE positions (relative to the parent bone, not absolute)
- [ ] `$bonemerge` lines for all 38 hand bones
- [ ] No `v_hands` or `sleeve_diffuse` in `$texturegroup`
- [ ] No `$cdmaterials "models\weapons\v_models\hands\"`
- [ ] `$origin 0 0 <z>` is set if the weapon mesh needs to be shifted into view

### C.4 Inspection of the reference SMD (bind pose)

- [ ] `nodes` section lists Spine4 with parent -1 (root)
- [ ] `nodes` section lists L_Clavicle and R_Clavicle with parent = Spine4's id
- [ ] `nodes` section lists all 38 hand bones with correct parent ids
- [ ] `skeleton` section time 0 has Spine4 at `(0, 0, 0)` with `(0, 0, 0)` rotation
- [ ] `skeleton` section time 0 has Clavicle at `(2.03, 1.00, ±1.94)` with
     c_arms_citizen's rotation
- [ ] `skeleton` section time 0 has all hand bones at c_arms_citizen's
     RELATIVE positions and rotations
- [ ] No BF3 procedural bones in the `nodes` section
- [ ] No `v_hands` or `sleeve_diffuse` material triangle blocks in the
     `triangles` section

### C.5 Inspection of animation SMDs

- [ ] `nodes` section matches the reference SMD's `nodes` section (same bones)
- [ ] `skeleton` section has multiple `time N` blocks (animations)
- [ ] Hand bones have keyframes in the animation (they're NOT stripped)
- [ ] No BF3 procedural bones in the `nodes` or `skeleton` sections

### C.6 Symptom → cause → fix table

| Symptom | Most likely cause | Fix |
|---------|-------------------|-----|
| No c_hands at all | `SWEP.UseHands` not set, or `.mdl` not in `c_*` path | Set `SWEP.UseHands = true`, ensure `$modelname` starts with `c_` |
| c_hands at world origin | studiomdl stripped hand bones (no `$definebone`) | Add `$definebone` lines or `$include c_arms_definebones.qci` |
| c_hands 58 units in front of camera | Spine4 `$definebone` set to c_arms_citizen's world position | Reset Spine4 to `(0,0,0)`, use `$origin` instead |
| c_hands deformed (fingers twisted) | Bind pose rotations don't match c_arms_citizen | Replace hand bone rotations with c_arms_citizen's values |
| c_hands don't animate during reload | Animation keyframes were stripped | Restore original animation SMDs |
| c_hands snap to wrong position after anim ends | Bind pose doesn't match animation's last-frame pose | Re-bake animations to new bind pose |
| Old hand mesh rendering with missing textures | Baked-in hand mesh in SMD not stripped | Run strip_v_hands_mesh.py |
| Only some fingers render | Some bones have wrong names (didn't get renamed) | Verify all bone names match `ValveBiped.Bip01_*` exactly |
| c_hands appear on hip instead of weapon | Player model has no hands entry | Use sandbox default or call `player_manager.AddValidHands` |
| c_hands work in singleplayer, break in multiplayer | `SWEP.UseHands` set server-side only | Set it in shared file (loaded both realms) |

### C.7 Quick debug console commands

Run these in the GMod console to diagnose:

```
-- Check if c_arms entity exists:
lua_run PrintTable(LocalPlayer():GetHands())

-- Check c_arms model:
lua_run print(LocalPlayer():GetHands():GetModel())

-- Check parent:
lua_run print(LocalPlayer():GetHands():GetParent())

-- Check viewmodel:
lua_run print(LocalPlayer():GetViewModel())

-- Check weapon's UseHands flag:
lua_run print(LocalPlayer():GetActiveWeapon().UseHands)

-- List all bones in the viewmodel:
lua_run local vm = LocalPlayer():GetViewModel() for i=0, vm:GetBoneCount()-1 do print(i, vm:GetBoneName(i)) end

-- List all bones in c_arms:
lua_run local hands = LocalPlayer():GetHands() for i=0, hands:GetBoneCount()-1 do print(i, hands:GetBoneName(i)) end
```

### C.8 Reference files (in this project)

| File | Purpose |
|------|---------|
| `/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd` | Canonical c_arms reference SMD (46 bones, bind pose) |
| `/home/z/my-project/repos/gmod-animations/c_arms_citizen.7z` | Contains `c_arms_citizen.qc`, `c_arms_vrd.vrd`, `c_arms_citizen_hands.smd`, etc. |
| `/home/z/my-project/repos/gmod-animations/c_medkit.7z` | Contains `c_medkit.qc` (weapon example), `c_arms_definebones.qci`, animation SMDs |
| `/tmp/c_arms_extract/citizen/c_arms_citizen.qc` | Extracted c_arms_citizen QC (with full `$definebone` + `$bonemerge` + `$proceduralbones` + `$ikchain`) |
| `/tmp/c_arms_extract/medkit/c_medkit.qc` | Extracted medkit weapon QC (reference for weapon setup) |
| `/tmp/c_arms_extract/medkit/c_arms_definebones.qci` | Extracted c_arms_definebones.qci (use this for weapon QCs but customize Spine4 position!) |
| `/tmp/c_arms_extract/citizen/c_arms_vrd.vrd` | Procedural bones file for c_arms (wrist/ulna/elbow twists) |
| `/home/z/my-project/scripts/fix_hand_bone_rotations.py` | Script that replaces ONLY bone rotations (current approach) |
| `/home/z/my-project/scripts/fix_c_arms_retarget.py` | Script that replaced positions AND rotations (BROKEN — caused "fly away") |
| `/home/z/my-project/scripts/revert_and_clean_qc.py` | Script that reverts to BF3 original + adds bonemerge |
| `/home/z/my-project/scripts/strip_v_hands_mesh.py` | Script that strips v_hands/sleeve_diffuse triangles from SMDs |
| `/home/z/my-project/scripts/recompile_all.py` | Script that compiles all 32 weapons with studiomdl |
| `/home/z/my-project/scripts/blender_verify_c_arms.py` | Script that verifies c_arms setup via Blender + SourceIO |

---

## Document History

- **v1.0** — Initial version. Compiled from Facepunch wiki (Using_Viewmodel_Hands,
  ValveBiped_Bones), Valve developer wiki ($definebone, $bonemerge, QC_Commands),
  robotboy655/gmod-animations repo (c_arms_citizen.smd, c_arms_definebones.qci,
  c_medkit.qc), and learnings from three failed+reverted c_hands conversion
  attempts on the BF3 weapon pack (commits `aeec835a`, `70e465d6`, `bc869425`).

## Sources

1. Facepunch wiki — Using Viewmodel Hands: <https://wiki.facepunch.com/gmod/Using_Viewmodel_Hands>
2. Facepunch wiki — ValveBiped Bones: <https://wiki.facepunch.com/gmod/ValveBiped_Bones>
3. Valve Developer Community — $bonemerge: <https://developer.valvesoftware.com/wiki/$bonemerge>
4. Valve Developer Community — $definebone: <https://developer.valvesoftware.com/wiki/$definebone>
5. Valve Developer Community — QC Commands: <https://developer.valvesoftware.com/wiki/QC_Commands>
6. robotboy655/gmod-animations: <https://github.com/robotboy655/gmod-animations>
7. LeRatEmperor/ghosts_wavy_s_nzombies_weapons_3802517048: <https://github.com/LeRatEmperor/ghosts_wavy_s_nzombies_weapons_3802517048>
8. Project worklog — `/home/z/my-project/worklog.md` entries:
   - `c-arms-retarget` (commit `aeec835a`)
   - `revert-c-arms-retarget` (commit `70e465d6`)
   - `c-hands-final-fix` (commit `bc869425`)
