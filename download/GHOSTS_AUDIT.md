# Ghosts Weapons Port Audit — TFA to Underhell Custom Base

## Full Audit for Porting Call of Duty Ghosts SWEPs

---

## 1. Project Overview

**Source repo:** https://github.com/LeRatEmperor/ghosts_wavy_s_nzombies_weapons_3802517048
**Local source:** `/home/z/my-project/source_repos/ghosts_weapons/`
**Target addon:** New addon (TBD — likely `ghosts_underhell/` or similar)

### Weapons to Port: 25 (33 total — 8 skipped)

**Skipped:** .44 magnum, mp-443, p226, pdw, bizon, cbj-ms, k7, vector crb

### Weapon Inventory by Category

| Category | Weapons | Count |
|----------|---------|-------|
| Assault Rifles | ak12, fad, honeybadger, ia2, maverick, mk14, msbs, remington, sa805, sc2010 | 10 |
| LMGs | ameli, chainsaw, lsat, m27_lmg, minigun | 5 |
| Shotguns | bulldog, fp6, mts225, tac12, usr | 5 |
| Snipers | l115, svu, usr* | 2-3 |
| Pistols | m9a1 | 1 |
| Launchers | panzerfaust | 1 |
| **Total** | | **25** |

*USR is categorized as a sniper but functions as a pump-action shotgun*

### Base Class Decision
- **All weapons:** `weapon_custom_uh_base_gun` (NO CUH base — no customization needed)
- **No melee bashing** — these weapons don't have it
- **Preserve:** Camera animations, sprint animations, inspect, PaP

---

## 2. TFA Ghosts Weapon Structure

### 2.1 Standard Weapon Fields

Every TFA Ghosts weapon has:

```lua
SWEP.Base = "tfa_gun_base"
SWEP.Category = "nZR: GHOSTS"
SWEP.SubCategory = "..."  -- category for spawnmenu
SWEP.Spawnable = true
SWEP.UseHands = true
SWEP.Slot = N  -- weapon slot
SWEP.PrintName = "..."
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false  -- hide crosshair in ironsights

-- Model
SWEP.ViewModel = "models/weapons/iw6/..."
SWEP.ViewModelFOV = 70
SWEP.WorldModel = "models/weapons/iw6/.../world/w_..."
SWEP.HoldType = "ar2"  -- or "crossbow", "rpg", "revolver", etc.
SWEP.VMPos = Vector(0,0,0.5)  -- viewmodel position offset
SWEP.VMAng = Vector(0,0,0)

-- World model offset (procedural positioning)
SWEP.Offset = {
    Pos = { Up = -5, Right = 1, Forward = 8 },
    Ang = { Up = 180, Right = 180, Forward = 8 },
    Scale = 1.1
}

-- Gun stats
SWEP.Primary.Sound = "Weapons_Ghosts_*.Fire"
SWEP.Primary.Ammo = "ar2"  -- or "buckshot", "SniperPenetratedRound", "RPG_Round", etc.
SWEP.Primary.Automatic = true/false
SWEP.Primary.RPM = 689  -- fire rate (rounds per minute)
SWEP.Primary.Damage = 90  -- single damage value
SWEP.Primary.NumShots = 1  -- pellets for shotguns
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 8
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = true
SWEP.Primary.PenetrationPower = 0

-- Spread
SWEP.Primary.Spread = 0.03
SWEP.Primary.IronAccuracy = 0.005
SWEP.IronRecoilMultiplier = 0.75

-- Recoil (TFA-specific ViewModelPunch system)
SWEP.ViewModelPunchPitchMultiplier = 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09
SWEP.ViewModelPunch_MaxVertialOffset = 2.0
SWEP.ViewModelPunch_VertialMultiplier = 0.5
SWEP.ViewModelPunchYawMultiplier = 0.6
SWEP.ChangeStateRecoilMultiplier = 1.3
SWEP.CrouchRecoilMultiplier = 0.65
SWEP.JumpRecoilMultiplier = 1.3

-- Ironsights
SWEP.IronBobMult = 0.065
SWEP.data = { ironsights = 1 }
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(...)
SWEP.IronSightsAng = Vector(...)
SWEP.IronSightTime = 0.3

-- Inspect
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)

-- Movement
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8

-- Shells
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "RifleShellEject"  -- or "ShotgunShellEject"
SWEP.LuaShellEjectDelay = 0
```

### 2.2 TFA-Specific Systems to Port

#### A. SprintAnimation Table
Every weapon has a `SprintAnimation` table with in/loop/out sequences:
```lua
SWEP.SprintAnimation = {
    ["in"] = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_in", transition = true },
    ["loop"] = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_loop", is_idle = true },
    ["out"] = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_out", transition = true },
}
```
**Port to:** `SWEP.AnimatedSprint = true` + `SWEP.Animations` with `sprint_in`, `sprint_out`, `sprint_idle` keys.

#### B. EventTable (Sound Events)
TFA uses ACT-based event tables with frame timing:
```lua
SWEP.EventTable = {
    [ACT_VM_DRAW] = {
        { time = 3/30, type = "sound", value = Sound("Weapons_Ghosts_LARGE.Generic") },
    },
    [ACT_VM_RELOAD] = {
        { time = 3/30, type = "sound", value = Sound("...Lift") },
        { time = 32/30, type = "sound", value = Sound("...Clipout") },
        { time = 55/30, type = "sound", value = Sound("...Clipin") },
    },
}
```
**Port to:** `SWEP.AnimSounds` with key-based timing (seconds).

#### C. StatusLengthOverride / SequenceRateOverride
TFA timing overrides for reload/draw/holster animations:
```lua
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 55 / 30,
    [ACT_VM_RELOAD_EMPTY] = 55 / 30,
}
SWEP.SequenceRateOverride = {
    [ACT_VM_DRAW] = 1,
    [ACT_VM_HOLSTER] = 1.2,
}
```
**Port to:** These set the animation duration. In Underhell, the reload system uses `vm:SequenceDuration()` directly. We may need to set `SWEP.ReloadTimes` or override the reload timing.

#### D. Camera Attachment System
Many weapons have camera attachment data:
```lua
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
```
And some have `SWEP.TPIKPos` (Third Person IK Position).
**Port to:** `SWEP.CameraAttachment = "Camera"` + `SWEP.CameraOffset = Angle(0, 0, 0)` in the Underhell system.

#### E. ViewModelBoneMods
Some weapons (ak12, ameli, lsat, minigun, tac12) have bone modifications:
```lua
SWEP.ViewModelBoneMods = {
    ["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1,1,1), pos = Vector(0,0,0), angle = Angle(0,0,90) }
}
```
**Port to:** Direct copy — the Underhell base supports `SWEP.ViewModelBoneMods`.

#### F. Pack-a-Punch System
Every weapon has NZ Pack-a-Punch:
```lua
SWEP.NZPaPName = "..."
SWEP.NZHeadShotMultiplier = 2.5
SWEP.Primary.MaxAmmo = SWEP.Primary.DefaultClip
function SWEP:NZMaxAmmo() ... end
SWEP.Ispackapunched = false
function SWEP:OnPaP() ... end
function SWEP:PreDrawViewModel(vm) ... end  -- applies PaP camo
```
**Port decision:** Keep PaP system as-is (it's NZ-specific, doesn't conflict with Underhell).

#### G. TFA Sound System
Sounds are defined via `TFA.AddFireSound` and `TFA.AddWeaponSound` in `lua/tfa/external/wavy_tfa_ghosts_sounds.lua` (125 lines).
**Port to:** Convert to `sound.Add()` calls in an autorun file (same pattern as WWII sounds).

#### H. Offset (World Model Positioning)
TFA uses a nested table format:
```lua
SWEP.Offset = {
    Pos = { Up = -5, Right = 1, Forward = 8 },
    Ang = { Up = 180, Right = 180, Forward = 8 },
    Scale = 1.1
}
```
**Port to:** `SWEP.WorldModelOffset = Vector(8, 1, -5)` (Forward, Right, Up) + `SWEP.WorldModelAngle = Angle(8, 180, 180)` (Forward, Up, Right).

---

## 3. Special Weapon Systems

### 3.1 FP6 Shotgun — Multi-Stage Reload (CRITICAL)

The FP6 has a unique reload system that plays different animations based on how many shells remain:

| Shells Remaining | Animation Key | ACT | Description |
|-----------------|---------------|-----|-------------|
| 4 (1 missing) | reload_1 | ACT_VM_RELOAD | Single shell reload |
| 3 (2 missing) | reload_2 | ACT_RELOAD_LOW | Two shell reload |
| 2 (3 missing) | reload_3 | ACT_VM_RELOAD2 | Three shell reload |
| 1 (4 missing) | reload_4 | ACT_VM_RELOAD_SILENCED | Four shell reload |
| 0 (empty) | reload | ACT_VM_RELOAD_EMPTY | Full 5 shell reload |

The `ChooseReloadAnim()` function selects the animation based on `Clip1()`:
```lua
function SWEP:ChooseReloadAnim()
    local clip = self:Clip1()
    local Reload_Table = {
        [4] = { act = ACT_VM_RELOAD, seq = "reload_1" },
        [3] = { act = ACT_RELOAD_LOW, seq = "reload_2" },
        [2] = { act = ACT_VM_RELOAD2, seq = "reload_3" },
        [1] = { act = ACT_VM_RELOAD_SILENCED, seq = "reload_4" },
        [0] = { act = ACT_VM_RELOAD_EMPTY, seq = "reload" },
    }
    -- PaP version has different clip sizes (10 rounds)
    -- ... selects animation, plays it
end
```

The EventTable also has lua callbacks that remove ammo from reserve and set Clip1 at specific animation frames (when shells are inserted).

**Port plan:**
1. Override `SWEP:Reload()` to call the custom reload logic
2. Use `EasySendWeaponAnim` to play the selected animation
3. Use the AnimSounds system with `type = "lua"` callbacks for ammo management
4. The Underhell AnimSounds system doesn't support lua callbacks — need to use timers or a custom system
5. Preserve PaP table (different clip sizes)

### 3.2 L115 Sniper — Custom Scope View

The L115 has a custom `Think2` that modifies the camera position when aiming:
```lua
function SWEP:Think2(...)
    if self.IronSightsProgress > .01 then
        spos = Lerp(self.IronSightsProgress * .85, spos, pos)
        sang = Lerp(self.IronSightsProgress * .85, sang, ang)
    end
    if self:GetIronSightsProgress() >= 0.9 then
        -- scope behavior
    end
end
```
This is a TFA-specific scope system. **Port plan:** Use the Underhell `ZoomFov` system instead — set `SWEP.ZoomFov` and `SWEP.Sensitivity` for scope zoom. The L115 doesn't use RT scopes, just FOV zoom.

### 3.3 Projectile Weapons (3 weapons)

| Weapon | Projectile Entity | Velocity | Notes |
|--------|------------------|----------|-------|
| Chainsaw | `nz_wpn_grenade` (secondary) | 2000 | Grenade launcher (M1 + E?) |
| M9A1 | `mustangsally_proj` (PaP only) | 6000 | PaP transforms into launcher |
| Panzerfaust | `nz_wpn_missile` (primary) | 3000 | Rocket launcher with model override |

**Port plan:** Use `ents.Create` + `SetVelocity` pattern (same as WWII RPG-7). Need to create projectile entities or use existing ones.

### 3.4 LSAT / AMELI — Belt Chain Animation

These LMGs have a `BeltChain` system that animates the ammo belt based on clip count:
```lua
SWEP.Primary.BeltChain = {
    [80] = "belt_full",
    [60] = "belt_3q",
    [40] = "belt_half",
    [20] = "belt_1q",
    [0] = "belt_empty",
}
```
The `Think2` function checks Clip1 and sets the bodygroup/sub-material based on ammo count.
**Port plan:** Port as a `CustomThink` function that checks Clip1 and sets bodygroups.

### 3.5 Minigun — Custom Crosshair

The minigun has a custom crosshair overlay:
```lua
local crosshair_minigun = Material("vgui/overlay/reticle_minigun.png", "smooth unlitgeneric")
```
Drawn in a custom `DrawHUD`. **Port plan:** Use `SWEP.CrosshairType = 3` (off) and draw the custom overlay in `DrawHUD`.

### 3.6 Tac12 — Shell-by-Shell Shotgun Reload

Standard TFA shotgun reload:
```lua
SWEP.Shotgun = true
SWEP.ShotgunEmptyAnim = false
SWEP.ShotgunStartAnimShell = true
SWEP.PumpAction = { ... }
```
**Port plan:** Use the Underhell shotgun base (`weapon_custom_uh_base_shotty`) or implement shell-by-shell reload via `CustomThink` + timer pattern (same as WWII Model 1897).

### 3.7 Remington R5 — M203 Grenade Launcher

Has `SWEP.Secondary.Sound = "Weapons_Ghosts_M203.Fire"` but no actual UGL code visible. May be a TFA base feature. **Port plan:** Check if the TFA base handles secondary fire for M203 — if so, port the logic. If not, just keep the sound as a data point.

---

## 4. TFA → Underhell Field Mapping

| TFA Ghosts | Underhell Custom | Notes |
|------------|-----------------|-------|
| `SWEP.Base = "tfa_gun_base"` | `SWEP.Base = "weapon_custom_uh_base_gun"` | Direct change |
| `SWEP.Primary.RPM` | `SWEP.Primary.Delay = 60 / RPM` | Convert RPM to delay |
| `SWEP.Primary.Damage` | `SWEP.Primary.MinDamage` + `SWEP.Primary.MaxDamage` | Single → range |
| `SWEP.Primary.NumShots` | `SWEP.Primary.NumberofShots` | Rename |
| `SWEP.Primary.Spread` | `SWEP.Primary.Spread` | Direct copy |
| `SWEP.Primary.KickUp/Down/Horizontal` | `SWEP.Primary.MinRecoil` + `SWEP.Primary.MaxRecoil` | Convert kick to recoil range |
| `SWEP.Primary.SpreadMultiplierMax` | `SWEP.Primary.SpreadMultiplierMax` | Direct copy |
| `SWEP.Primary.SpreadIncrement` | `SWEP.Primary.SpreadIncrement` | Direct copy |
| `SWEP.Primary.SpreadRecovery` | `SWEP.Primary.SpreadRecovery` | Direct copy |
| `SWEP.IronSightsPos/Ang` | `SWEP.IronSightsPos/Ang` | Direct copy |
| `SWEP.IronSightTime` | `SWEP.IronSightTime` | Direct copy |
| `SWEP.Secondary.IronFOV` | `SWEP.ZoomFov` | Convert (IronFOV is the zoomed FOV, ZoomFov is degrees to subtract) |
| `SWEP.data.ironsights = 1` | (implicit in Underhell) | Remove |
| `SWEP.InspectPos/Ang` | `SWEP.Inspection = { {pos=..., ang=...} }` | Convert format |
| `SWEP.SprintAnimation` | `SWEP.AnimatedSprint = true` + `SWEP.Animations["sprint_*"]` | Convert |
| `SWEP.EventTable` | `SWEP.AnimSounds` | Convert (time = N/30 → seconds, ACT keys → string keys) |
| `SWEP.Offset` | `SWEP.WorldModelOffset` + `SWEP.WorldModelAngle` | Convert format |
| `SWEP.LuaShellEject/Effect` | `SWEP.Shell` + `SWEP.NoShell` | Convert |
| `SWEP.ViewModelBoneMods` | `SWEP.ViewModelBoneMods` | Direct copy |
| `SWEP.VMPos/VMAng` | (not directly supported — may need custom code) | Investigate |
| `SWEP.CameraAttachmentOffsets` | `SWEP.CameraAttachment` + `SWEP.CameraOffset` | Convert |
| `SWEP.MuzzleFlashEffect` | `SWEP.MuzzleFlashType = "particle"` + `SWEP.MuzzleFlashParticle` | Convert |
| `SWEP.PumpAction` | `SWEP.IsBolt = true` + `SWEP.PumpDelay` (for snipers) | Convert |
| `SWEP.StatusLengthOverride` | (set via reload timing) | Port as needed |
| `SWEP.NZPaPName/OnPaP/PreDrawViewModel` | Keep as-is | NZ-specific, no conflict |

---

## 5. Porting Plan

### Phase 1: Foundation (Templates + Sound Script)
1. Create new addon folder (`ghosts_underhell/`)
2. Port the TFA sound script to `sound.Add()` format
3. Create weapon templates for Ghosts weapon types:
   - Standard auto/semi rifle template
   - Sniper template (with ZoomFov)
   - Shotgun template (shell-by-shell or FP6 multi-stage)
   - LMG template (with belt chain)
   - Launcher template (projectile)
4. Set up `SWEP.Category = "Ghosts"`

### Phase 2: Standard Weapons (16 weapons)
Port the simple assault rifles and SMGs:
- ak12, fad, honeybadger, ia2, maverick, mk14, msbs, remington, sa805, sc2010 (10 ARs)
- mr28 (AR/pistol hybrid)
- m27_lmg (simple LMG)
- bulldog, mts225 (simple shotguns)
- svu (simple sniper)
- chainsaw (LMG with grenade secondary)

### Phase 3: Special Weapons (9 weapons)
Port the complex weapons:
- **fp6** — Multi-stage reload (highest priority)
- **tac12** — Shell-by-shell shotgun
- **usr** — Pump-action sniper/shotgun
- **l115** — Sniper with custom scope view
- **lsat** — LMG with belt chain
- **ameli** — LMG with belt chain
- **minigun** — Custom crosshair + spin-up
- **m9a1** — Launcher pistol (PaP transforms)
- **panzerfaust** — Rocket launcher

### Phase 4: Testing & Polish
1. Test all weapons: fire, reload, sprint, inspect, deploy
2. Test PaP: camo, damage boost, ammo changes
3. Test special systems: FP6 reload, belt chains, projectiles, scope zoom
4. Test crosshair: dynamic crosshair should work on all weapons
5. Test sprint bob dampener

---

## 6. Key Differences from WWII Port

| Aspect | WWII Port | Ghosts Port |
|--------|-----------|-------------|
| Base class | `weapon_cuh_base_gun` (with attachments) | `weapon_custom_uh_base_gun` (no attachments) |
| Attachments | 41 attachment files | None (no customization) |
| Melee bashing | Yes (E+M1) | No |
| Camera bone | Yes | Yes (preserve) |
| RT scopes | Yes (7x, 4x, lens) | No (just FOV zoom) |
| Sound system | `sound.Add()` in autorun | TFA.AddFireSound → convert to `sound.Add()` |
| Pack-a-Punch | No | Yes (every weapon) |
| Custom reload | Shotgun shell-by-shell | FP6 multi-stage + shotgun shell-by-shell |
| Projectile | 5 weapons | 3 weapons (chainsaw, m9a1, panzerfaust) |
| Sprint | AnimatedSprint=true | SprintAnimation table → AnimatedSprint=true |

---

## 7. Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| FP6 multi-stage reload | High — complex ammo management with lua callbacks in EventTable | Port as custom Reload() override with timers |
| TFA Enum references | Medium — `TFA.Enum.ANIMATION_SEQ` etc. don't exist in Underhell | Replace with string-based animation keys |
| PaP system compatibility | Medium — NZ-specific, may conflict with Underhell | Keep as-is, test for conflicts |
| Projectile entities | Medium — need to create/find projectile entities | Check if existing Underhell projectile entities work |
| Belt chain system | Low — just bodygroup changes in Think | Port as CustomThink |
| Sound script conversion | Low — mechanical conversion | Script-based, 125 lines |
| ViewModelBoneMods | Low — direct copy | No conversion needed |
| Camera attachment | Low — Underhell already supports it | Map CameraAttachmentOffsets → CameraAttachment |

---

## 8. Files to Create

```
ghosts_underhell/
├── lua/
│   ├── autorun/
│   │   └── ghosts_sounds.lua          # Converted sound script
│   ├── weapons/
│   │   ├── ghosts_*.lua               # 25 weapon files
│   │   └── template_*.lua            # Templates (rifle, sniper, shotgun, lmg, launcher)
│   └── entities/                      # Projectile entities (if needed)
├── materials/                         # PaP camo, crosshair overlays
├── models/                            # (reference to TFA models — no copying needed)
└── sound/                             # (reference to TFA sounds — no copying needed)
```

---

## 9. Next Steps

1. **Await user confirmation** on the audit and plan
2. **Create the addon folder structure**
3. **Start Phase 1** (sound script + templates)
4. **Start Phase 2** (standard weapons — bulk port)
5. **Start Phase 3** (special weapons — FP6 first)
6. **Test thoroughly** using the glua skill and simulator
