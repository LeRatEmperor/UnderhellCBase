# Underhell Custom Weapon Base — Comprehensive Handoff Guide

**Date:** 2026-10-21
**Purpose:** Pass this project to a new on-PC coding agent. This document is exhaustive but intentionally **general** — it explains how the system works, what the conventions are, what's broken, and what to avoid. It is NOT a step-by-step tutorial.

---

## 0. TL;DR for the new agent

- **Three-layer SWEP base** with attachment customization, forked from the Underhell base
- **Base chain:** `weapon_base` → `weapon_custom_uh_base` → `weapon_custom_uh_base_gun` → `weapon_cuh_base_gun` → per-weapon SWEPs
- **Two parallel attachment systems exist:** the older `CustomUH` (used by xm4/m8a1/bo7_1911) and the newer `cuh_attachments` (used by bf3_m416). Both work but use different loader folders
- **TFA base is installed alongside this addon** (BF3 pack depends on it). All CUH-specific fields/methods MUST be prefixed to avoid collisions
- **The previous agent's base edits broke things repeatedly.** Touching the parent base files (`weapon_custom_uh_base.lua`, `weapon_custom_uh_base_gun.lua`) is high-risk. Prefer editing the CUH layer (`weapon_cuh_base_gun.lua`) or the per-weapon SWEP file
- **Current state:** m416 ported, attachments ported, idle system + IronFireProcedural toggle added in CUH layer. Silencer + laser still broken. See "Known broken stuff" below

---

## 1. Repository layout

### 1.1 The addon (what gets installed in GMod)

```
download/custom_uh_base/         ← the actual GMod addon
├── lua/
│   ├── autorun/                  ← 6 loader/UI files (loaded automatically by GMod)
│   │   ├── sh_cuh_attachments.lua       ← CustomUH registry + networking + save/load
│   │   ├── sh_custom_uh_attachments.lua ← older CustomUH loader
│   │   ├── sh_customuh.lua              ← core CustomUH module
│   │   ├── cl_cuh_ui.lua                ← customization menu (open with C)
│   │   ├── cuh_extra_recoil.lua         ← recoil modifier
│   │   └── bo7_1911_sound.lua           ← sound.Add calls for the 1911
│   ├── weapons/                 ← 10 weapon Lua files (the base chain + ports)
│   │   ├── weapon_custom_uh_base.lua       ← root base (viewmodel, deploy, HUD, calcview)
│   │   ├── weapon_custom_uh_base_gun.lua  ← gun base (fire, reload, recoil, muzzle)
│   │   ├── weapon_custom_uh_base_melee.lua ← melee base
│   │   ├── weapon_custom_uh_base_shotty.lua ← shotgun base
│   │   ├── weapon_cuh_base_gun.lua        ← CUH customization layer (ATTACHMENTS LIVE HERE)
│   │   ├── weapon_m8a1_scotia.lua         ← M8A1 (uses CustomUH system)
│   │   ├── weapon_xm4_bo6.lua             ← XM4 (uses CustomUH system)
│   │   ├── weapon_bo7_1911.lua            ← BO7 1911 pistol
│   │   ├── weapon_dcm_1911.lua            ← DCM 1911 pistol
│   │   └── weapon_cuh_bf3_m416.lua        ← BF3 M416 (uses cuh_attachments system)
│   ├── cuh_attachments/          ← 74 attachment files (newer system, bf3_* + bo7_* + xm4_*)
│   │   ├── bf3_acog.lua  bf3_eotech.lua  bf3_grip.lua  bf3_kobra.lua
│   │   ├── bf3_laser.lua  bf3_muzzle.lua  bf3_reflex.lua  bf3_scope.lua
│   │   ├── bf3_suppressor.lua
│   │   ├── xm4_*.lua  (XM4 attachments: barrels, stocks, mags, sights, grips)
│   │   └── bo7_1911_*.lua  (1911 attachments: barrels, mags, muzzles, grips, triggers)
│   ├── customuh_attachments/     ← 20 attachment files (older CustomUH system, xm8_*)
│   └── customuh/                 ← 8 CustomUH module files (sh_velements, sh_bodygroups, etc.)
├── tools/                        ← developer tools (NOT loaded by GMod)
├── docs/                         ← this folder
└── README.md                     ← existing readme
```

### 1.2 External repos (reference + source mods)

```
repos/
├── tfa_base_src/                ← TFA base source (github.com/LeRatEmperor/tfa_base_2840031720)
├── tfa_base_docs/               ← TFA documentation (templates only, no implementation)
├── tfa_bf3/                      ← BF3 weapons pack (TFA-based, the source we're porting FROM)
├── tfa_nmrih/                    ← TFA NMRIH weapons (reference for porting patterns)
├── BO4-NZ-Sweps/                 ← BO4 weapons (TFA-based, reference)
├── m8a1_tfa/                     ← original M8A1 (TFA-based, pre-port)
├── bo4_tfa/                      ← BO4 TFA reference
├── mcv_full/                     ← Military Conflict Vietnam (MCV) base — different architecture
├── tfa_wwii_original/            ← TFA WWII original
├── cuh_port_recovery/            ← working copy of the BF3 port (m416 + 9 attachments)
└── mcv/                          ← MCV partial clone
```

### 1.3 External weapon packs (NOT in the addon, but use the CUH base)

```
wwiiunderhell_kate/               ← 97 WWII weapons ported from TFA to CUH
├── lua/weapons/kate_*.lua       ← kate_1911, kate_stg44, kate_kar98k, etc.
└── lua/cuh_attachments/          ← kate's own attachments (tfa_codww2_supp_pistol, etc.)

cod_ghosts_underhellsweps/       ← 25 COD Ghosts weapons ported from TFA to CUH
└── lua/weapons/ghosts_*.lua     ← ghosts_fp6, ghosts_ak12, ghosts_l115, etc.
```

These are separate addons that depend on `custom_uh_base` being installed. They inherit from `weapon_cuh_base_gun`. **Any change to the CUH base affects all of them.**

---

## 2. The base chain — what each layer does

### 2.1 `weapon_custom_uh_base` (root base, 1172 lines)

The Underhell root base. Handles:
- Viewmodel position/angle transforms (`GetViewModelPosition` → calls `Inspect`, `Grenade`, `Sway`, `Movement`, `Sights`, `Alternative`)
- Deploy / Holster lifecycle (sets `DeployTime`, `FirstDrawPlaying`, gives ammo on first deploy)
- HandleBones (manipulates left-arm bones for grenade hold; sets bodygroup 1 based on `GetNWBool("Silenced")`)
- HandleHands (skin swapping for hand models)
- HandleRunning (sprint state machine — plays `ACT_VM_IDLE_TO_LOWERED` / `ACT_VM_LOWERED_TO_IDLE`)
- Think (calls HandleBones + HandleHands + HandleRunning every frame)
- CalcView (view bob + FOV zoom via `SWEP.ZoomFov`)
- PreDrawViewModel / PostDrawViewModel (blur, VElements, VM3D2D)
- HUDShouldDraw / DrawWeaponSelection / DrawHUD
- Animation helpers: `EasySendWeaponAnim`, `SendSequence`, `SendAnim`, `SendWeaponAnim`, `LookupSequence`
- ClearAnimSounds (resets the AnimSounds timeline state)

**Key SWEP fields (root base):**
- `SWEP.IronSightsPos`, `SWEP.IronSightsAng` — ironsight position/angle
- `SWEP.IronSightsDipPos`, `SWEP.IronSightsDipAng`, `SWEP.IronSightsDipScale` — curved ADS transition
- `SWEP.IronsightSpeed`, `SWEP.IronsightEaseIn`, `SWEP.IronsightLateralSpeed`, `SWEP.IronsightForwardSpeed`
- `SWEP.ZoomFov`, `SWEP.ZoomSpeedIn`, `SWEP.ZoomSpeedOut`
- `SWEP.AnimatedSprint` — when true, fades viewmodel bob during sprint
- `SWEP.AlternativePos`, `SWEP.AlternativeAng` — rest-pose offset
- `SWEP.LoweredPos`, `SWEP.LoweredAng` — sprint/low-pos offset
- `SWEP.RunSightsPos`, `SWEP.RunSightsAng` — sprint position offset (used by xm4 procedural sprint)
- `SWEP.Inspection` — inspect animation stages (table of `{pos, ang}`)
- `SWEP.LeftBones` — table of bone names + angles for left-arm manipulation
- `SWEP.HideMaterials` — materials to hide via sub-material during ADS
- `SWEP.VM3D2D` — 2D surfaces drawn on viewmodel bones
- `SWEP.ViewModelBoneMods` — per-bone scale/pos/angle overrides
- `SWEP.Animations` — table mapping keys ("idle", "shoot", "reload", etc.) to sequence names or ACT_* enums
- `SWEP.AnimSounds` — table of sound timelines per animation key
- `SWEP.Use2DScope`, `SWEP.ScopeTexture`, `SWEP.ScopeFov` — 2D scope rendering
- `SWEP.AnimatedFirstDraw` — plays a special first-deploy animation
- `SWEP.PreCock` — plays a pump/cock sound mid-deploy

**Standard GMod SWEP methods (overridden):** `Initialize`, `Deploy`, `Holster`, `Think`, `CalcView`, `PreDrawViewModel`, `PostDrawViewModel`, `HUDShouldDraw`, `DrawWeaponSelection`

### 2.2 `weapon_custom_uh_base_gun` (gun base, 1124 lines)

Inherits from `weapon_custom_uh_base`. Adds:
- `PrimaryAttack` — the core fire routine: firemode lookup, ShootBullets, recoil, muzzle flash, shell eject, shoot animation, sound, SetNextPrimaryFire
- `SecondaryAttack` — firemode switch (RMB) or zoom (RMB) depending on IN_USE modifier
- `Reload` — reload state machine with AnimSounds + ReloadTable fallback
- `_FinishReload` — ammo refill (handles Chambering logic)
- `ShootBullets` — bullet trace with penetration recursion
- `ShootGrenade` — projectile spawn for grenade launchers
- `DoMuzzleFlash` — particle or effect-based muzzle flash + dynamic light
- `CreateSmoke`, `CreateShell` — delayed effect spawning
- `GetShootSound` — returns `SilSound` if `GetNWBool("Silenced")`, else `Primary.Sound`
- `ShootAnimation` — returns `ACT_VM_PRIMARYATTACK` (override per weapon)
- `SetupAnimSounds`, `ProcessAnimSounds` — timeline-based sound playback during animations
- `FireAnimationEvent` — QC event handler (plays sounds from model $animation events)
- `CanPrimaryAttack` — checks firemode, deploy time, running, reloading, clip empty
- `AdjustMouseSensitivity` — scope sensitivity scaling

**Key SWEP fields (gun base):**
- `SWEP.Primary.Sound`, `SWEP.Primary.SilSound` — fire sounds
- `SWEP.Primary.ClipSize`, `SWEP.Primary.DefaultClip`, `SWEP.Primary.Ammo`, `SWEP.Primary.Automatic`
- `SWEP.Primary.MinDamage`, `SWEP.Primary.MaxDamage` — random damage range
- `SWEP.Primary.Spread`, `SWEP.Primary.IronAccuracy` — hip + ADS spread
- `SWEP.Primary.Delay` — fire delay in seconds (60/RPM)
- `SWEP.Primary.KickUp`, `SWEP.Primary.KickDown`, `SWEP.Primary.KickHorizontal`
- `SWEP.Primary.MinRecoil`, `SWEP.Primary.MaxRecoil` — random recoil range
- `SWEP.Primary.NumberofShots`, `SWEP.Primary.Force`, `SWEP.Primary.TakeAmmo`
- `SWEP.Secondary.IronFOV` — ADS FOV
- `SWEP.Secondary.IronFOV_Scope`, `_ACOG`, `_Collimator` — per-optic FOVs
- `SWEP.Penetration` — penetration depth in units (NUMBER, not bool)
- `SWEP.Chambering` — bool, allows +1 round in chamber
- `SWEP.Silenced` — bool, captured by stat cache
- `SWEP.HasSilencer` — bool, enables the parent base's silencer bodygroup override (line 642/671)
- `SWEP.Shotgun` — bool, marks shotgun (affects shell eject sound)
- `SWEP.ReloadSpeed` — multiplier for reload animation playback rate
- `SWEP.UseQCReloadEvents` — bool, enables FireAnimationEvent QC sound routing
- `SWEP.UseReloadTable` — bool, use ReloadTable for reload sounds (vs AnimSounds)
- `SWEP.ReloadTable` — table of `{delay, sound, level, pitch}` entries for reload sounds
- `SWEP.FireModes` — table of firemode definitions (each has `name`, `shoot`, `equip`, `holster`)
- `SWEP.MuzzleFlashType` — "default" or "particle"
- `SWEP.MuzzleFlashParticle`, `SWEP.MuzzleFlashLightColor`, `SWEP.MuzzleFlashLightSize`
- `SWEP.NoShell`, `SWEP.Shell`, `SWEP.ShellHeat`, `SWEP.ShellDelay`
- `SWEP.MeleeDamage`, `SWEP.MeleeRange`, `SWEP.MeleeDelay`, `SWEP.MeleeForce`, `SWEP.MeleeHitDelay`, `SWEP.MeleeViewPunch`, `SWEP.MeleeSound`, `SWEP.MeleeHitSound`, `SWEP.MeleeInterruptReload`
- `SWEP.ZoomFov`, `SWEP.ZoomSpeedIn`, `SWEP.ZoomSpeedOut`

### 2.3 `weapon_custom_uh_base_shotty` (shotgun base, 230 lines)

Inherits from `weapon_custom_uh_base_gun`. Adds shell-by-shell reload:
- `ReloadShotgun(ct)` — start/loop/finish state machine
- Overrides `Reload`, `PostShoot`, `PreReload`, `PostReload`

### 2.4 `weapon_custom_uh_base_melee` (melee base, 256 lines)

Inherits from `weapon_custom_uh_base`. Full melee weapon (no gun fire):
- `PrimaryAttack` — swing + hit trace
- `SecondaryAttack` — alt swing
- `GetSwingAnim` — returns the swing animation key
- `PreSwing`, `PostHit` — hooks for weapons to customize

### 2.5 `weapon_cuh_base_gun` (CUH layer, 1464 lines)

**This is where the attachment system lives.** Inherits from `weapon_custom_uh_base_gun`. Adds:

**Stat cache system:**
- `InitStatCache()` — snapshots all `SWEP.Primary.*`, `SWEP.Secondary.*`, `SWEP.IronSightsPos`, etc. into `self._statOrigins`
- `GetStat(path)`, `SetStat(path, value)`, `RestoreStat(path)` — read/write/revert
- `FlushStats()` — restore ALL stats from origin (called at start of ApplyAttachments)

**VElement / WElement system:**
- `InitVElements()` — creates `ClientsideModel` for each active VElement
- `DrawVElements(vm)` — draws active VElements, applies bodygroups via `ApplyBodygroupsVM`
- `CleanupVElements()` — destroys all `_csModel` entities (forces rebuild)
- Mirror functions for WElements (world model)

**Bodygroup system:**
- `SWEP.Bodygroups_V` / `SWEP.Bodygroups_W` — tables of `{[bg_index] = value}`
- `ApplyBodygroupsVM(vm)` — sets every bodygroup in `Bodygroups_V` on the viewmodel
- `ApplyBodygroupsWM(wm)` — same for worldmodel
- `ResetBodygroups()` — restores to default snapshot
- `SetSightBodygroup(value)`, `SetMagBodygroup(value)` — convenience methods for sight/mag bodygroups
- `SWEP.SightBGs`, `SWEP.MagBGs` — tables with `main`, `regular`, `empty` keys for per-state bodygroups

**Attachment pipeline (`ApplyAttachments`):**
1. Call `InitStatCache()` if not already done
2. Call `Detach` on previously-equipped attachments (via `_prevSelections`)
3. `FlushStats()` — restore all stats to origin
4. `ResetBodygroups()` — restore bodygroups to default
5. Reset VElements to default active state
6. Reset Animations table to default snapshot
7. For each equipped attachment:
   - Call `att:Attach(self)` if defined
   - Apply `att.WeaponTable` entries:
     - `Primary.*` / `Secondary.*` — stat transforms (functions called with current value, result stored)
     - `Bodygroups_V` / `Bodygroups_W` — merge into self.Bodygroups_V/W
     - `VElements` / `WElements` — merge per-key (active flag, model, etc.)
     - `Animations` — merge per-key (sequence name overrides)
     - `AnimSounds` — merge per-key
8. `CleanupVElements()` + `InitVElements()` — rebuild ClientsideModels with new model paths

**SetAttachment pipeline:**
- Captures `_prevSelections[slot]` before changing `.sel`
- Calls `ApplyAttachments()`
- Networks to server via `CUH2_AttSelect` (client → server)
- Server saves + broadcasts `CUH2_AttSync` (server → all clients)

**Animation system (added by previous agent — CUH-prefixed to avoid TFA conflict):**
- `SWEP.CUH_IdleMode` — 1=enabled (default), 0=disabled
- `SWEP.CUH_IdleSmooth` — 0.05s early blend before anim end
- `SWEP:CUH_ChooseIdleAnim()` — plays "idle" when: not reloading, not running, not zooming, not melee, deploy finished, `vm:GetCycle() >= 1`. Uses `_cuhNextIdle` timer to avoid every-frame calls
- `SWEP:HandleIronsightsAnimations()` — plays iron_in/iron_out/iron_idle based on Zooming bool. This is a DEFAULT implementation; weapons with their own override (xm4, m8a1, kate) use theirs
- `SWEP.CUH_IronFireProcedural` — when true AND zooming, `EasySendWeaponAnim` skips shoot anims (the viewmodel stays in iron_idle, viewpunch handles feedback). For BF3-style weapons without ADS shoot anims
- `SWEP:EasySendWeaponAnim()` override — intercepts shoot calls when `CUH_IronFireProcedural` is on
- `SWEP:Think()` — calls `BaseClass.Think` only (does NOT call idle/ironsights handlers — each weapon calls those from its own Think)
- `SWEP:Holster()` — clears `_cuhNextIdle` + `wasZooming`, calls `BaseClass.Holster`

**Melee system (in CUH layer, used by all CUH weapons):**
- `SWEP:MeleeAttack()` — plays melee anim, schedules hit trace via `_meleeHitTime`
- `SWEP:DoMeleeTrace()` — TraceHull, applies damage, plays hit sound
- `SWEP:EndMelee()` — clears melee state

**TFA compatibility stub:**
- `SWEP:GetActivityEnabled()` — returns false (TFA calls this; we don't use TFA's activity system)

### 2.6 Per-weapon SWEPs

Each weapon file inherits from `weapon_cuh_base_gun` and defines:
- Stats (`Primary.*`, `Secondary.*`, `IronSights*`, etc.)
- `ViewModelElements` / `WorldModelElements` tables
- `Bodygroups_V` / `Bodygroups_W` defaults
- `Attachments` table (slot → atts list)
- `Animations` table (key → sequence name)
- `AnimSounds` table (key → timeline of sounds)
- Method overrides as needed (`Think`, `PrimaryAttack`, `Deploy`, `Holster`, `HandleRunning`, `GetViewModelPosition`, etc.)

**Existing weapons in the addon:**
- `weapon_m8a1_scotia.lua` (563 lines) — uses older CustomUH system
- `weapon_xm4_bo6.lua` (528 lines) — uses older CustomUH system
- `weapon_bo7_1911.lua` (616 lines) — BO7 1911 pistol
- `weapon_dcm_1911.lua` (575 lines) — DCM 1911 pistol
- `weapon_cuh_bf3_m416.lua` (421 lines) — BF3 M416 (pilot port)

---

## 3. The two attachment systems

### 3.1 Older system: `CustomUH` (used by xm4, m8a1, bo7_1911)

- Attachments live in `lua/customuh_attachments/` (20 files, all `xm8_*.lua`)
- Loaded by `lua/autorun/sh_customuh.lua` + `lua/autorun/sh_custom_uh_attachments.lua`
- Uses a separate registry: `CustomUH.Attachments[id]`
- Different SWEP field layout (slightly older convention)

### 3.2 Newer system: `cuh_attachments` (used by bf3_m416)

- Attachments live in `lua/cuh_attachments/` (74 files: `bf3_*`, `xm4_*`, `bo7_1911_*`)
- Loaded by `lua/autorun/sh_cuh_attachments.lua`
- Uses the same `CustomUH.Attachments[id]` registry (the two systems converged)
- Newer convention, recommended for new ports

### 3.3 Attachment file format

Every attachment file follows this pattern:

```lua
if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Suppressor"
ATTACHMENT.Icon = "bf3/suppressor.png"      -- materials/ path
ATTACHMENT.ShortName = "SUPP"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Silenced fire",
    Color(100, 255, 100), "-10% spread",
}

-- Optional: model path for bonemerge (Kate pattern). BF3 uses bodygroups instead.
ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    -- Bodygroup swaps (BF3 pattern)
    ["Bodygroups_V"] = { [1] = 2 },   -- set viewmodel bodygroup 1 to value 2
    ["Bodygroups_W"] = { [1] = 2 },   -- same for worldmodel

    -- VElement activation (Kate pattern — separate bonemerged model)
    ["VElements"] = {
        ["suppressor"] = { ["active"] = true },
    },

    -- Stat transforms (functions called with current value, return new value)
    ["Primary"] = {
        ["Spread"]        = function(wep, stat) return stat * 0.9 end,
        ["IronAccuracy"]  = function(wep, stat) return stat * 0.9 end,
        -- Fire sound swap (Kate pattern — avoids SetNWBool("Silenced"))
        ["Sound"]         = function(wep, val) return wep.Primary.SilSound end,
    },

    -- IronSights position override (per-optic)
    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_Reflex or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_Reflex or val end,

    -- IronFOV override
    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Collimator or val * 0.95 end,
    },

    -- Animation overrides (per-key, merged into SWEP.Animations)
    ["Animations"] = {
        ["idle"]         = "foregrip_idle",
        ["shoot"]        = "foregrip_fire",
        ["reload"]       = "foregrip_reload",
        ["reload_empty"] = "foregrip_reload_empty",
    },

    -- AnimSounds overrides (per-key, merged into SWEP.AnimSounds)
    ["AnimSounds"] = {
        ["reload"] = { { time = 0.5, sound = "bf3/reload/mag_out.wav" } },
    },

    -- Muzzle flash effect override
    ["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced",

    -- Flag for DoMuzzleFlash to suppress flash (Kate pattern)
    ["SuppressedFlash"] = true,
}

-- Optional Attach/Detach hooks (called by ApplyAttachments)
function ATTACHMENT:Attach(wep)
    -- Side effects that can't be expressed in WeaponTable
    -- e.g. wep.SuppressedFlash = true
end

function ATTACHMENT:Detach(wep)
    -- Reverse side effects
end
```

### 3.4 The `Attachments` table on each weapon

```lua
SWEP.Attachments = {
    [1] = { name = "Optic",  atts = { "bf3_reflex", "bf3_kobra", "bf3_eotech", "bf3_acog" }, default = 0 },
    [2] = { name = "Muzzle", atts = { "bf3_muzzle", "bf3_suppressor" }, default = 0 },
    [3] = { name = "Laser",  atts = { "bf3_laser" }, default = 0 },
    [4] = { name = "Grip",   atts = { "bf3_grip" }, default = 0 },
}
```

- `name` — slot label (shown in the UI)
- `atts` — list of attachment IDs (filenames without `.lua`)
- `default` — index to auto-apply when no selection (0 = none)
- `forceDefault` (optional) — prevent selecting "None"
- `.sel` — currently selected index (set at runtime, persisted to save file)

---

## 4. Networking

### 4.1 Net messages

| Message | Direction | Purpose |
|---------|-----------|---------|
| `CUH2_AttSelect` | client → server | "Player clicked attachment X in slot Y" |
| `CUH2_AttSync` | server → all clients | "Sync this attachment selection to everyone" |
| `CUH2_AttLoad` | server → specific client | "Load saved attachments on weapon switch" |
| `CUH2_AttList` | server → specific client | "Send the full attachment registry to a new player" |

### 4.2 Save/load

- Saves per-player per-weapon-class attachment selections
- Path: `data/cuh_saves/<steamid64>.json`
- Format: `{ ["weapon_class"] = { ["1"] = 2, ["2"] = 0, ... } }`
- Loaded on `PlayerSwitchWeapon` hook (deferred via `timer.Simple(0, ...)`)
- Saved on `SetAttachment` (server), `PlayerDeath`, `PlayerDisconnected`

### 4.3 Hooks

| Hook | Purpose |
|------|---------|
| `PlayerInitialSpawn` | Send attachment registry to new players |
| `PlayerSwitchWeapon` | Load saved attachments on weapon switch |
| `PlayerDeath` | Save all attachments |
| `PlayerDisconnected` | Save all attachments |
| `Think` (CUH2_Register) | Register weapons that have `SetAttachment` method |

---

## 5. The viewmodel system

### 5.1 VElements (viewmodel attachment models)

```lua
SWEP.ViewModelElements = {
    ["barrel"] = {
        type = "Model",                          -- must be "Model"
        model = "models/weapons/parts/barrel_default.mdl",
        bone = "ValveBiped.Bip01_R_Hand",        -- bone to attach to (case-sensitive!)
        pos = Vector(0, 0, 0),                   -- position offset
        ang = Angle(0, 0, 0),                    -- angle offset (NOT "angle" — must be "ang")
        size = Vector(1, 1, 1),                  -- scale (NOT "scale" — must be "size")
        material = "",                           -- material override
        skin = 0,                                -- skin index
        bodygroup = {},                          -- bodygroup overrides for the VElement's csModel
        surpresslightning = false,
        bonemerge = true,                        -- if true, EF_BONEMERGE the csModel to the VM
        active = true,                           -- if false, not drawn
        _defaultActive = true,                   -- snapshot of default active state (set by InitVElements)
        _csModel = nil,                          -- the ClientsideModel entity (created by InitVElements)
    },
}
```

**Critical gotchas:**
- Field is `ang` NOT `angle`, `size` NOT `scale` (CUH convention, different from TFA)
- Bone name is case-sensitive (`"Weapon"` ≠ `"weapon"`)
- `bonemerge = true` requires the csModel to have matching bones (use for attachment parts that bonemerge onto the weapon)
- `_csModel` is created by `InitVElements` and destroyed by `CleanupVElements`
- `DrawVElements` calls `model:SetModel(elem.model)` EVERY FRAME so attachment swaps take effect immediately

### 5.2 WElements (worldmodel attachment models)

Same structure as VElements, applied to the world model. Drawn in `DrawWorldModel`.

### 5.3 Bodygroups

For weapons that use bodygroups instead of separate models (BF3 pattern):

```lua
SWEP.Bodygroups_V = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }  -- defaults
SWEP.Bodygroups_W = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
```

- Key = bodygroup index (0-based)
- Value = submodel index (0-based)
- `ApplyBodygroupsVM(vm)` sets every bodygroup in `Bodygroups_V` on the viewmodel, called every frame from `DrawVElements`
- Attachments override these via `att.WeaponTable.Bodygroups_V = { [1] = 2 }`
- `ResetBodygroups()` restores to the default snapshot (called at start of ApplyAttachments)

### 5.4 Animation system

```lua
SWEP.Animations = {
    ["idle"]         = "base_idle",        -- sequence name (string)
    ["shoot"]        = "base_fire",
    ["shoot_sil"]    = "base_fire",        -- silenced variant (same anim for BF3)
    ["reload"]       = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["draw"]         = "base_draw",
    ["first_draw"]   = "base_draw",
    ["iron_in"]      = "base_idle",        -- ADS enter (BF3 has no ADS anims, reuse idle)
    ["iron_idle"]    = "base_idle",
    ["iron_out"]     = "base_idle",
    ["sprint_in"]    = "base_idle",        -- sprint enter (BF3 uses procedural sprint, not anims)
    ["sprint_idle"]  = "base_idle",
    ["sprint_out"]   = "base_idle",
    ["melee"]        = "melee_swing",
    ["inspect"]      = "inspect_anim",
}
```

- Keys are looked up via `EasySendWeaponAnim(key, fallback_ACT)`
- Values can be strings (sequence names) or numbers (ACT_* enums)
- Silenced variants use `_sil` suffix (e.g. `shoot_sil`, `reload_sil`)
- Empty-clip variants use `_empty` suffix
- ADS variants use `iron_` prefix

**Animation priority (implicit, lowest-first):**
1. Idle (`CUH_ChooseIdleAnim`) — only when `vm:GetCycle() >= 1` and no other state active
2. Ironsight transitions (`HandleIronsightsAnimations`) — when Zooming bool changes
3. Sprint transitions — handled per-weapon (xm4 uses procedural, others use anims)
4. Shoot / Reload / Draw / Melee — explicit calls from PrimaryAttack/Reload/Deploy/MeleeAttack

### 5.5 AnimSounds

Timeline-based sound playback during animations:

```lua
SWEP.AnimSounds = {
    ["reload"] = {
        { time = 0.5, sound = "bf3/reload/mag_out.wav" },
        { time = 1.2, sound = "bf3/reload/mag_in.wav" },
        { time = 1.8, sound = "bf3/reload/charge.wav" },
    },
    ["reload_empty"] = {
        -- longer timeline for empty reload
    },
}
```

- `time` is in seconds from animation start
- `sound` can be a string or table of strings (random pick)
- `SetupAnimSounds(key, variant)` starts the timeline
- `ProcessAnimSounds()` advances the timeline each Think
- Playback rate scales with `vm:GetPlaybackRate()` (for ReloadSpeed)
- `ClearAnimSounds()` stops the timeline (called on Holster, _FinishReload, melee end)

---

## 6. The silencer problem (and why it's hard)

### 6.1 The built-in Underhell silencer system (BROKEN on CUH)

The parent base (`weapon_custom_uh_base.lua`) has a silencer system based on `GetNWBool("Silenced")`:
- `HandleBones` (line 717-733) sets `vm:SetBodygroup(1, 0 or 1)` every frame based on this bool
- `HandleRunning` (line 647, 671) also sets bodygroup 1
- `GetShootSound` (line 280) returns `SilSound` if true
- The animation system appends `_sil` to lookup keys

**Why it breaks on CUH:**
1. The bodygroup override to `0 or 1` clobbers any attachment-set bodygroup (BF3 suppressor uses value `2`)
2. The `_sil` animation suffix fails on BF3 models (they have no `base_fire_sil` sequence)
3. The NW bool is server-authoritative; on listen servers it propagates with delay
4. `HandleBones` runs every frame from Think, BEFORE `ApplyBodygroupsVM` in PostDrawViewModel — but the override happens anyway

### 6.2 The Kate pattern (working reference)

Kate weapons (`wwiiunderhell_kate/lua/cuh_attachments/tfa_codww2_supp_pistol.lua`) use a different approach:
- **No `SetNWBool("Silenced")`** — never sets the bool
- **VElement with bonemerge** — separate suppressor .mdl that bonemerges onto `tag_silencer` bone
- **Stat cache sound swap** — `["Primary"]["Sound"] = function(wep, val) return wep.Primary.SilSound end`
- **`SuppressedFlash` flag** — `DoMuzzleFlash` checks this (not the NW bool) to skip flash

**Why it doesn't directly apply to BF3:**
- BF3 weapons use bodygroups for the suppressor mesh (not a separate .mdl)
- BF3 weapons don't have a `tag_silencer` bone
- The suppressor mesh is baked into the weapon .mdl at bodygroup 1 value 2

### 6.3 The BF3 silencer fix (what's been attempted)

The `bf3_suppressor.lua` attachment uses:
- `Bodygroups_V = { [1] = 2 }` — sets bodygroup 1 to value 2 (the suppressor mesh)
- `Primary.Sound = function(wep, val) return wep.Primary.SilSound end` — stat cache sound swap
- Does NOT call `SetNWBool("Silenced")`

**Why it's still broken:**
- `HandleBones` in the parent base STILL overrides bodygroup 1 to `0` every frame (because `GetNWBool("Silenced")` is false, it sets to 0)
- The stat cache sound swap may not be working — `InitStatCache` may not capture `Primary.Sound` correctly, or `RestoreStat` may not revert it
- The suppressor mesh never appears because bodygroup 1 keeps getting reset to 0

**To fix this properly WITHOUT touching the parent base:**
- Add `SWEP.CUH_SkipSilencerBodygroup = true` field (opt-out from parent's bodygroup override)
- In the CUH layer's `HandleBones` override (NOT the parent's), check this field and skip the bodygroup-1 override if set
- OR: override `HandleBones` entirely in the m416 SWEP file
- Verify `InitStatCache` properly captures `Primary.Sound` and `Primary.SilSound` as separate snapshots

---

## 7. Known broken stuff (as of handoff)

### 7.1 Silencer (model + sound) — STILL BROKEN

- Suppressor mesh doesn't appear (bodygroup 1 reset to 0 by parent's HandleBones)
- Silenced sound may not play (stat cache swap may not work)
- Sound doesn't revert on detach (RestoreStat may not handle `Primary.Sound`)

### 7.2 Laser attachment — PARTIALLY BROKEN

- The `models/tfa/lbeam.mdl` model is shipped with TFA BASE, not BF3 — it's missing if user only has BF3 installed
- The `laser` VElement in the m416 silently fails to load (no error, just no visible laser beam)
- The bodygroup part (`bg3 = 1`) SHOULD work — verify this

### 7.3 The idle system — RECENTLY ADDED, UNTESTED

- `CUH_ChooseIdleAnim()` added to the CUH layer
- Gates on: not reloading, not running, not zooming, not melee, deploy finished, `vm:GetCycle() >= 1`
- Uses `_cuhNextIdle` timer
- **May conflict with existing weapons** that have their own `HandleIdle` method (kate, xm4, m8a1)
- The CUH `Think` does NOT call `CUH_ChooseIdleAnim` — each weapon must call it from its own Think (m416 does)

### 7.4 The IronFireProcedural toggle — RECENTLY ADDED, UNTESTED

- `SWEP.CUH_IronFireProcedural = false` (default off)
- When true AND zooming, `EasySendWeaponAnim` skips shoot anims
- Set to `true` on the m416
- **May break existing weapons** if they relied on shoot anims playing during ADS — verify none of the existing CUH weapons set this flag (they shouldn't, it's new)

### 7.5 The m416 sprint fix — RECENTLY ADDED, UNTESTED

- m416 overrides `HandleRunning` to NOT play anims (just sets bools + HoldType)
- m416 overrides `GetViewModelPosition` to apply `RunSightsPos/Ang` as procedural sprint
- **The previous agent's attempt to fix sprinting in the BASE broke smooth transitions** — this per-weapon approach should be safer but is untested

---

## 8. Critical conventions (DO NOT VIOLATE)

### 8.1 TFA coexistence

TFA base IS installed (BF3 pack depends on it). **All CUH-specific fields/methods MUST be `CUH_`-prefixed** to avoid collisions:

| DO | DON'T |
|----|-------|
| `SWEP.CUH_IdleMode` | `SWEP.Idle_Mode` (TFA defines this) |
| `SWEP.CUH_IdleSmooth` | `SWEP.Idle_Smooth` (TFA defines this) |
| `SWEP.CUH_IronFireProcedural` | `SWEP.IronSightsShoot` (could conflict) |
| `SWEP:CUH_ChooseIdleAnim()` | `SWEP:ChooseIdleAnim()` (TFA defines this) |
| `SWEP:HandleIronsightsAnimations()` | (OK — TFA doesn't define this) |
| `SWEP:Think()` / `Holster()` / `EasySendWeaponAnim()` | (OK — standard GMod methods, must keep these names) |

TFA fields to NEVER use (TFA base defines these):
- `SWEP.Idle_Mode`, `SWEP.Idle_Smooth`
- `SWEP.Sights_Mode`, `SWEP.Sprint_Mode`, `SWEP.Walk_Mode`, `SWEP.Customize_Mode`
- `SWEP.BlowbackEnabled`, `SWEP.BlowbackVector`, `SWEP.Blowback_Only_Iron`, `SWEP.BlowbackAllowAnimation`, `SWEP.BlowbackBoneMods`, `SWEP.BlowbackCurrent`, `SWEP.BlowbackCurrentRoot`
- `SWEP.IronAnimation`, `SWEP.SprintAnimation`, `SWEP.WalkAnimation`, `SWEP.CustomizeAnimation`
- `SWEP.MuzzleAttachment`, `SWEP.ShellAttachment` (use `SWEP.MuzzleAttachment = "1"` only if you mean the TFA convention)
- `SWEP.LuaShellEject`, `SWEP.LuaShellEjectDelay`, `SWEP.LuaShellEffect`, `SWEP.LuaShellModel`
- `SWEP.SequenceLengthOverride`, `SWEP.SequenceTimeOverride`, `SWEP.SequenceRateOverride`, `SWEP.StatusLengthOverride`
- `SWEP.BoltAction`, `SWEP.Scoped`, `SWEP.ScopeOverlayThreshold`, `SWEP.BoltTimerOffset`, `SWEP.ScopeScale`, `SWEP.ReticleScale`
- `SWEP.SpreadMultiplierMax`, `SWEP.SpreadIncrement`, `SWEP.SpreadRecovery`, `SWEP.SpreadRecoveryDelay`
- `SWEP.Primary.RPM`, `SWEP.Primary.RPM_Semi`, `SWEP.Primary.RPM_Burst`, `SWEP.Primary.KickUp`, `SWEP.Primary.KickDown`, `SWEP.Primary.KickRight`, `SWEP.Primary.StaticRecoilFactor`, `SWEP.Primary.AmmoConsumption`, `SWEP.Primary.DamageTypeHandled`, `SWEP.Primary.PenetrationMultiplier`, `SWEP.Primary.DryFireDelay`, `SWEP.Primary.DisplaySpread`
- `SWEP.Primary.ClipSize` (TFA and CUH both use this — it's standard GMod, OK to use)
- `SWEP.ProceduralHolsterEnabled`, `SWEP.ProceduralHolsterTime`, `SWEP.ProceduralHolsterPosition`, `SWEP.ProceduralHolsterAngle`
- `SWEP.ProceduralSight`, `SWEP.ProceduralReloadTime`, `SWEP.IsProceduralReloadBased`
- `SWEP.FireSoundAffectedByClipSize`, `SWEP.RegularMoveSpeedMultiplier`, `SWEP.IronSightsMoveSpeed`
- `SWEP.LoopedReload`, `SWEP.LoopedReloadInsertAmount`, `SWEP.LoopedReloadInsertTime`
- `SWEP.ShotgunEmptyAnim`, `SWEP.ShotgunEmptyAnim_Shell`, `SWEP.ShotgunStartAnimShell`
- `SWEP.CanJam`, `SWEP.JamChance`, `SWEP.JamFactor`
- `SWEP.IsTFAWeapon` (TFA's marker — use `SWEP.IsCUHWeapon` instead)

### 8.2 Base editing is HIGH RISK

**The previous agent broke the base repeatedly by editing the parent base files.** Every fix to `weapon_custom_uh_base.lua` or `weapon_custom_uh_base_gun.lua` had side effects on other CUH weapons (kate, xm4, m8a1, ghosts, 1911s).

**Preferred approach:**
1. First try to fix it in the per-weapon SWEP file (safest)
2. If that's not possible, add it to the CUH layer (`weapon_cuh_base_gun.lua`) with a CUH-prefixed field name
3. ONLY edit the parent base if there's no other way, AND gate the change behind a new opt-in/opt-out field so existing weapons are unaffected

### 8.3 Field naming

- Standard GMod SWEP fields: `Base`, `PrintName`, `Category`, `ViewModel`, `WorldModel`, `Slot`, `HoldType`, `Primary.*`, `Secondary.*` — use these freely
- CUH-specific fields: prefix with `CUH_` (e.g. `CUH_IdleMode`, `CUH_IronFireProcedural`)
- Internal state fields: prefix with `_cuh` (e.g. `_cuhNextIdle`, `_cuhSprintFactor`)
- TFA-derived concepts that we've adapted: keep the concept name but CUH-prefix the field (e.g. Kate's `SuppressedFlash` is OK because TFA doesn't use that name)

### 8.4 Method naming

- Standard GMod methods (`Think`, `Holster`, `Deploy`, `PrimaryAttack`, `SecondaryAttack`, `Reload`, `Initialize`, `DrawHUD`, `CalcView`, `PreDrawViewModel`, `PostDrawViewModel`): override freely
- Underhell base methods (`HandleRunning`, `HandleBones`, `HandleHands`, `EasySendWeaponAnim`, `SendWeaponAnim`): override carefully — call `BaseClass.Method(self, ...)` to preserve parent behavior
- CUH-specific methods: prefix with `CUH_` to avoid any future TFA collision

### 8.5 Testing

There's no automated test runner that works on the actual GMod environment. The previous agent built:
- A Lua simulator (`tools/simulator/cuh_sim_driver.py`) using `lupa` that exercises `ApplyAttachments` — catches logic bugs but NOT visual/animation bugs
- A `lupa`-based syntax checker (compile via `load()`) — catches parse errors
- Manual in-game testing is the only way to verify visual behavior

---

## 9. How to port a new weapon (general recipe)

### 9.1 From TFA

1. Read the TFA SWEP file (e.g. `repos/tfa_bf3/lua/weapons/bf3_m416.lua`)
2. Read the TFA attachment files (e.g. `repos/tfa_bf3/lua/tfa/att/bf3_suppressor.lua`)
3. Map TFA fields to CUH fields (see field mapping in the existing port files)
4. Decompile the .mdl files to find bodygroup structure (use `scripts/extract_bodygroups.py`)
5. Create the weapon file in `lua/weapons/weapon_cuh_<pack>_<weapon>.lua`
6. Create attachment files in `lua/cuh_attachments/<pack>_*.lua`
7. Test in-game

### 9.2 Field mapping (TFA → CUH)

| TFA field | CUH field | Notes |
|-----------|-----------|-------|
| `SWEP.Primary.Sound` | `SWEP.Primary.Sound` | direct |
| `SWEP.Primary.SilencedSound` | `SWEP.Primary.SilSound` | renamed |
| `SWEP.Primary.RPM` | `SWEP.Primary.Delay = 60 / RPM` | inverted |
| `SWEP.Primary.Damage` | `SWEP.Primary.MinDamage` + `MaxDamage` | split for in/out damage |
| `SWEP.Primary.NumShots` | `SWEP.Primary.NumberofShots` | renamed |
| `SWEP.Primary.Spread` | `SWEP.Primary.Spread` | direct |
| `SWEP.Primary.IronAccuracy` | `SWEP.Primary.IronAccuracy` | direct |
| `SWEP.Primary.KickUp` | `SWEP.Primary.KickUp` | direct |
| `SWEP.Primary.KickHorizontal` | `SWEP.Primary.KickHorizontal` | direct |
| (new) | `SWEP.Primary.KickDown` | derived: `KickUp * 0.8` |
| (new) | `SWEP.Primary.MinRecoil` / `MaxRecoil` | derived: `KickUp * 0.7` / `KickUp * 1.3` |
| `SWEP.SightsPos` | `SWEP.IronSightsPos` | renamed |
| `SWEP.SightsAng` | `SWEP.IronSightsAng` | renamed |
| `SWEP.RunSightsPos` / `RunSightsAng` | (same names) | direct |
| `SWEP.Secondary.IronFOV` | (same) | direct |
| `SWEP.VElements` | `SWEP.ViewModelElements` | renamed |
| `SWEP.WElements` | `SWEP.WorldModelElements` | renamed |
| `SWEP.FireModes` (TFA list of strings) | `SWEP.FireModes` (CUH list of tables) | restructured |
| `SWEP.UseHands` | (same) | direct |
| `SWEP.Penetration` (bool) | `SWEP.Penetration` (number) | `true` → `2` |
| `SWEP.LuaShellEject` / `LuaShellEffect` / `LuaShellScale` | `SWEP.NoShell` (inverted), `SWEP.Shell`, `SWEP.ShellHeat` | restructured |
| `SWEP.Attachments` (TFA format) | `SWEP.Attachments` (CUH format) | restructured |

### 9.3 Attachment mapping

| TFA pattern | CUH pattern |
|-------------|-------------|
| `Bodygroups_V = { [1] = 2 }` | (same) — works directly |
| `VElements = { ["suppressor"] = { active = true } }` | (same) — works directly |
| `Primary.Sound = function(wep, val) return wep.Primary.SilSound end` | (same) — works directly |
| `Silenced = true` (TFA field) | DO NOT USE — set `SuppressedFlash = true` instead (Kate pattern) |
| `wep:SetSilenced(true)` | DO NOT CALL — breaks the parent base's bodygroup override |
| `MuzzleFlashEffect = "..."` | (same) — but `DoMuzzleFlash` must honor `SuppressedFlash` |

---

## 10. The previous agent's history (lessons learned)

The previous agent (working remotely) made several attempts that broke things. Key lessons:

1. **Don't add idle refresh to `ApplyAttachments`** — it overwrites draw animations on every CUH weapon (kate, xm4, m8a1, ghosts). Removed in commit `4d97a0d7`.

2. **Don't edit the parent base's `HandleRunning`** — it broke smooth sprint transitions on all CUH weapons. The fix should be per-weapon (override `HandleRunning` in the SWEP file).

3. **Don't use `SetNWBool("Silenced")`** — it triggers the parent base's broken silencer bodygroup override. Use the Kate pattern (stat cache + `SuppressedFlash`).

4. **Don't use TFA field names** — they collide. Always prefix with `CUH_`.

5. **Don't trust the simulator for visual bugs** — it catches logic bugs but not animation/bodygroup rendering issues. Manual in-game testing is required.

6. **The bodygroup decompiler (`scripts/decompile_mdl.py`) was wrong** — it used the wrong header offset for `numbodyparts` (220 vs 232) and the wrong struct layout for `mstudiomodel_t`. Use `scripts/extract_bodygroups.py` instead (the corrected version).

7. **The CUH `Think` should NOT call `HandleIronsightsAnimations` or `CUH_ChooseIdleAnim`** — each weapon calls those from its own Think. Otherwise they run twice for weapons that have their own handlers (xm4, kate, m8a1).

8. **GMod's `LuaJIT` has `continue` as a keyword** — the lupa-based syntax checker needs `continue` replaced with `do end` to compile. The actual GMod runtime supports `continue` natively.

---

## 11. Useful scripts (in `/home/z/my-project/scripts/`)

| Script | Purpose |
|--------|---------|
| `extract_bodygroups.py` | Parse v48 MDL files and extract bodygroup + submodel names (CORRECTED version) |
| `decompile_mdl.py` | Older MDL decompiler (HAS BUGS — use `extract_bodygroups.py` instead) |
| `cuh_sim_driver.py` | lupa-based simulator that exercises ApplyAttachments |
| `cuh_sim_harness.lua` | Lua test harness for the simulator |
| `cuh_preprocess.py` | Converts GMod LuaJIT-isms to plain Lua 5.4 for the simulator |
| `validate_gmod_lua.py` | Syntax checker (wrapper around lupa) |

---

## 12. Where to look for examples

### 12.1 Working CUH weapons (reference for new ports)

- `lua/weapons/weapon_xm4_bo6.lua` — procedural sprint + ironsights animations
- `lua/weapons/weapon_m8a1_scotia.lua` — full attachment system with model swaps
- `lua/weapons/weapon_bo7_1911.lua` — pistol with attachments
- `lua/weapons/weapon_cuh_bf3_m416.lua` — BF3 port (bodygroup-based attachments, procedural sprint)

### 12.2 Working silencer reference

- `wwiiunderhell_kate/lua/cuh_attachments/tfa_codww2_supp_pistol.lua` — the Kate pattern (VElement + stat cache + SuppressedFlash)

### 12.3 Working attachment examples

- `lua/cuh_attachments/bf3_*.lua` — BF3 attachments (bodygroup-based)
- `lua/cuh_attachments/xm4_*.lua` — XM4 attachments (model-swap-based)
- `lua/cuh_attachments/bo7_1911_*.lua` — 1911 attachments (model-swap-based)

### 12.4 TFA base source (for understanding TFA's approach)

- `repos/tfa_base_src/lua/weapons/tfa_gun_base/shared.lua` — main TFA gun base
- `repos/tfa_base_src/lua/weapons/tfa_gun_base/common/anims.lua` — TFA animation system (ChooseIdleAnim, ChooseShootAnim, etc.)
- `repos/tfa_base_src/lua/tfa/enums/statusnew.lua` — TFA status enums

---

## 13. Final notes for the new agent

1. **Start by reading the existing working weapons** (xm4, m8a1, kate_1911) to understand the patterns before touching anything.

2. **The base files (`weapon_custom_uh_base.lua`, `weapon_custom_uh_base_gun.lua`) are the user's reverted versions** — they work for existing weapons. Don't edit them unless absolutely necessary.

3. **The CUH layer (`weapon_cuh_base_gun.lua`) is where new features should go** — it's the customization layer that doesn't affect non-CUH weapons.

4. **Test changes in-game** — the simulator only catches logic bugs, not visual/animation issues.

5. **The user values stability over features** — a working base with fewer features is better than a broken base with more features. Don't push changes that haven't been tested.

6. **Explain every change after pushing** — the user wants to catch approaches that don't work (like the built-in Underhell silencer system, which is broken on the custom base).

7. **The m416 is the pilot port** — once it's fully working (silencer + laser fixed), the same pattern can be applied to the other 16 BF3 weapons that have attachments.

8. **The user's timezone is Pacific/Honolulu** — interpret relative dates/times accordingly.

9. **All files must live under `/home/z/my-project/`** — never write outside this base path.

10. **The worklog at `/home/z/my-project/worklog.md` has the full history** — read it to understand what's been tried and what failed.

Good luck. The system is complex but the patterns are consistent once you understand them.
