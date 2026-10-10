# BO3 Reference Weapons — Exhaustive Technical Audit

This is the reference for how to correctly build mechanics on the Underhell / CUH base.
Every file was read line-by-line. Line numbers are verbatim from the source.

**Files audited**

| # | File | Lines | BaseClass |
|---|------|-------|-----------|
| 1 | `/tmp/my-project/upload/weapon_bo3_base_gun.lua` | 740 | `weapon_custom_uh_base_gun` |
| 2 | `/tmp/my-project/upload/weapon_bo3_base_shotty.lua` | 197 | `weapon_uh_base_shotty` |
| 3 | `/tmp/my-project/upload/weapon_bo3_krm262.lua` | 752 | `weapon_bo3_base_shotty` |
| 4 | `/tmp/my-project/upload/weapon_bo3_m8a7.lua` | 782 | `weapon_uh_base_gun` |
| 5 | `/tmp/my-project/upload/weapon_bo3_drakon_unscoped.lua` | 231 | `weapon_bo3_base_gun` |
| 6 | `/tmp/my-project/upload/weapon_bo3_mr6.lua` | 132 | `weapon_bo3_base_gun` |
| 7 | `/tmp/my-project/upload/weapon_bo3_icr1.lua` | 189 | `weapon_bo3_base_gun` |
| 8 | `/home/z/my-project/lua/weapons/weapon_bo3_base_gun.lua` | 462 | `weapon_cuh_base_gun` |

---

## 0. Critical corrections to the audit prompt

The audit prompt contains three assumptions that do NOT match the source code:

| Prompt claim | Actual source behaviour |
|---|---|
| "KRM-262 sets up `_krm_nextShell` in `Reload()`" | There is no `_krm_nextShell` field anywhere. The KRM-262 inherits `Reload()` from `weapon_bo3_base_shotty`, which uses the UH-base field `self.reloaddelay` (a single next-shell timestamp, not a KRM-specific name). |
| "SetupAnimSounds calls after every EasySendWeaponAnim" | No reference file calls `SetupAnimSounds()` explicitly. `EasySendWeaponAnim()` (provided by the UH/CUH base) is assumed to schedule the per-anim sound table internally. |
| "ReloadShotgun dispatched from Think, not CustomThink" | True for the KRM-262: the KRM-262 inherits `ReloadShotgun` and the dispatch happens inside the **UH base** Think (not in any BO3 file). The BO3 `weapon_bo3_base_shotty` only *defines* `ReloadShotgun(ct)`; it does not call it itself. |
| "Drakon: rechamber reference" | Confirmed — the Drakon has NO rechamber logic. Its `FireModes` use `equip`/`holster` callbacks to toggle `Primary.Automatic`; there is no PostShoot, no `IsBolt`/`IsPump`, no bolt timer. |

---

## 1. Per-file class hierarchy

### 1.1 `upload/weapon_bo3_base_gun.lua` (the upload / "old" BO3 base)

- **BaseClass**: `weapon_custom_uh_base_gun` (line 3–4)
- **Concrete?** No — `SWEP.Spawnable` is not set (defaults to false). Used as a base class.
- **PrintName** (line 6): `"MR6"` (copy-paste leftover from MR6)
- **Slot** (line 10): `3`

#### Functions DEFINED in this file

| Function | Line | Notes |
|---|---|---|
| `SWEP:CalcView(ply, pos, ang, fov)` | 110 | BO3 camera-bone angle tracking + pass to `BaseClass.CalcView` |
| `SWEP:Initialize()` | 139 | Calls `BaseClass.Initialize(self)` |
| `SWEP:ShootAnimation()` | 143 | Returns `"iron_fire"` / `"shoot"` / `ACT_VM_PRIMARYATTACK` |
| `SWEP:PrimaryAttack()` | 155 | Melee gate (E+M1) + delegate to base |
| `SWEP:MeleeAttack()` | 185 | Plays `["melee"]`, schedules hit + end timers |
| `SWEP:PlayMeleeSound(soundEntry, vol, pitch)` | 243 | Sound-table helper |
| `SWEP:DoMeleeTrace()` | 261 | Hull trace + DamageInfo |
| `SWEP:EndMelee()` | 311 | Clears melee state, sets `_engineWantsIdle = true` |
| `SWEP:SecondaryAttack()` | 326 | Guards against melee/mantle |
| `SWEP:Reload()` | 338 | Guards against melee/mantle |
| `SWEP:StartMantle()` | 357 | Plays `["mantle"]`, locks controls |
| `SWEP:EndMantle()` | 410 | Clears mantle state, sets `_engineWantsIdle = true` |
| `SWEP:Think()` | 418 | Parkour / mantle / melee / holster finish + `BaseClass.Think` + `HandleSprintingAnimations` |
| `SWEP:Holster()` | 480 | Clears melee/mantle/burst/rechamber/zoom/running |
| `SWEP:Deploy()` | 506 | Calls BaseClass.Deploy, plays `["deploy"]`, resets state |
| `SWEP:HandleRunning(ct)` | 541 | Sprint state machine |
| `SWEP:GetViewModelPosition(pos, ang)` | 588 | Safe-mode lowering + AlternativePos + sprint Z offset |
| `SWEP:HandleSprintingAnimations()` | 679 | `sprint_in` / `sprint_out` / `sprint_idle` |
| `SWEP:DrawWorldModel()` (CLIENT) | 722 | ClientsideModel + bone matrix |

#### Functions OVERRIDDEN from BaseClass
`CalcView`, `Initialize`, `ShootAnimation`, `PrimaryAttack`, `SecondaryAttack`, `Reload`, `Think`, `Holster`, `Deploy`, `HandleRunning`, `GetViewModelPosition`, `DrawWorldModel`.

#### Functions INHERITED unchanged (from `weapon_custom_uh_base_gun`)
`CanPrimaryAttack`, `TakePrimaryAmmo`, `ShootBullets`, `DoMuzzleFlash`, `CreateSmoke`, `CreateShell`, `GetMuzzle`, `GetShootSound`, `EasySendWeaponAnim`, `ClearAnimSounds`, `SetUHBool`/`GetUHBool`, `SetupAnimSounds` (assumed — called inside `EasySendWeaponAnim`), all FireMode / reload / inspect logic.

### 1.2 `upload/weapon_bo3_base_shotty.lua`

- **BaseClass**: `weapon_uh_base_shotty` (line 3–4)
- **Concrete?** No — `SWEP.Spawnable` not set. Base class only.
- **PrintName** (line 6): `"BO3 Shotgun Base"`
- Defines `SWEP.Shotgun = true` (line 9), `SWEP.ShellLoadTime = 0.6` (line 14)

#### Functions DEFINED

| Function | Line | Notes |
|---|---|---|
| `SWEP:CalcView(...)` | 32 | Camera-bone tracking (identical to base gun) |
| `SWEP:Reload()` | 68 | Start-reload: guards, start animation, sets `reloaddelay`, ReloadTime/ReloadEndTime NW floats |
| `SWEP:ReloadShotgun(ct)` | 136 | Per-tick shell insertion: stop conditions, then animation-driven shell insertion (when `vm:GetCycle() >= 1`) |
| `SWEP:PostShoot()` | 182 | Pump action: `IsPump` + `PumpDelay` + `Primary.PumpSound` + `["pump"]` animation |

#### OVERRIDDEN
`CalcView`, `Reload`, `ReloadShotgun`, `PostShoot`.

#### INHERITED from `weapon_uh_base_shotty` (NOT in this file)
- The dispatch of `ReloadShotgun(ct)` from `Think` — this happens inside the UH shotgun base's `Think`. The BO3 file does NOT override `Think` (so it inherits the dispatcher).
- `PrimaryAttack`, `SecondaryAttack`, `Deploy`, `Holster`, `Initialize`, melee (none — the shotgun base does not have melee; KRM-262 redefines it itself).

### 1.3 `upload/weapon_bo3_krm262.lua`

- **BaseClass**: `weapon_bo3_base_shotty` (line 3–4)
- **Concrete?** Yes — `SWEP.Spawnable = true` (line 13)
- **PrintName** (line 6): `"KRM-262"`
- **Slot** (line 11): `3`

The KRM-262 is the **most complex** reference: it overrides `PostShoot` (pump), then *re-implements* the entire BO3 base gun's melee / mantle / parkour / deploy / holster / think / sprint / world-model code inline (lines 156–752). This is because `weapon_bo3_base_shotty` inherits from `weapon_uh_base_shotty` — not from `weapon_bo3_base_gun` — so the BO3 melee/mantle/parkour code is not in its chain. The KRM copy-pastes the base-gun code back in.

#### Functions DEFINED in KRM-262

| Function | Line | Notes |
|---|---|---|
| `SWEP:PostShoot()` | 139 | OVERRIDE — pump-action animation timer with zoom-aware `rechamber` / `rechamber_ads` |
| `SWEP:Initialize()` | 156 | Trivial passthrough |
| `SWEP:ShootAnimation()` | 160 | Identical to base |
| `SWEP:PrimaryAttack()` | 172 | Identical to base gun |
| `SWEP:MeleeAttack()` | 202 | Identical to base gun |
| `SWEP:PlayMeleeSound(...)` | 254 | Identical |
| `SWEP:DoMeleeTrace()` | 272 | Identical |
| `SWEP:EndMelee()` | 322 | Identical |
| `SWEP:SecondaryAttack()` | 337 | Identical |
| `SWEP:Reload()` | 349 | OVERRIDE — *blocks reload during melee/mantle and delegates to BaseClass.Reload*. **This shadows the shotgun-base `Reload()`** — meaning the KRM-262 does NOT use the shell-by-shell start_reload flow from `weapon_bo3_base_shotty`. This is a likely bug: the shell reload only works if `BaseClass.Reload` chains back up to `weapon_bo3_base_shotty:Reload()` via `weapon_uh_base_shotty:Reload()`. |
| `SWEP:StartMantle()` | 368 | Identical to base gun |
| `SWEP:EndMantle()` | 421 | Identical |
| `SWEP:Think()` | 429 | Identical to base gun (does NOT call `ReloadShotgun`) |
| `SWEP:Holster()` | 491 | Identical to base gun |
| `SWEP:Deploy()` | 517 | Identical to base gun |
| `SWEP:HandleRunning(ct)` | 552 | Identical, but `fireDelay > 0.3` (vs `> 0` in upload base gun) |
| `SWEP:GetViewModelPosition(pos, ang)` | 599 | Identical |
| `SWEP:HandleSprintingAnimations()` | 690 | Identical |
| `SWEP:DrawWorldModel()` (CLIENT) | 733 | KRM-specific offsets |

#### OVERRIDDEN from `weapon_bo3_base_shotty`
`PostShoot` only — and `Reload` is overridden back to the base-gun pattern (guard + delegate). All other BO3 functions are *also defined locally* because they are not in the parent chain.

#### INHERITED
`ReloadShotgun` (called by UH base Think), `CalcView` (from `weapon_bo3_base_shotty`), `EasySendWeaponAnim`, `ClearAnimSounds`, `SetUHBool`, etc.

### 1.4 `upload/weapon_bo3_m8a7.lua`

- **BaseClass**: `weapon_uh_base_gun` (line 3–4) — **NOT** `weapon_bo3_base_gun`. The M8A7 re-implements the BO3 melee/mantle/parkour code inline rather than inheriting from `weapon_bo3_base_gun`.
- **Concrete?** Yes — `SWEP.Spawnable = true` (line 13)
- **PrintName** (line 6): `"M8A7"`
- **Slot** (line 10): `2`

#### Functions DEFINED

| Function | Line | Notes |
|---|---|---|
| `SWEP:ShootAnimation()` | 134 | Standard |
| `SWEP:Holster(wep)` | 146 | Takes `wep` arg (unusual) — cancels burst/melee/mantle |
| `SWEP:HandleRunning(ct)` | 174 | Standard |
| `SWEP:StartMantle()` | 225 | Standard + cancels burst |
| `SWEP:EndMantle()` | 276 | Standard |
| `SWEP:Think()` | 284 | Standard + **burst continuation block** |
| `SWEP:GetViewModelPosition(...)` | 339 | Standard |
| `SWEP:HandleSprintingAnimations()` | 430 | Standard |
| `SWEP:FireBurstRound()` | 468 | Bullets + recoil + anim + sound + ammo + PostShoot + burst bookkeeping |
| `SWEP:PrimaryAttack()` | 545 | Standard melee gate + delegate |
| `SWEP:MeleeAttack()` | 573 | Standard |
| `SWEP:PlayMeleeSound(...)` | 622 | Standard |
| `SWEP:DoMeleeTrace()` | 633 | Standard |
| `SWEP:EndMelee()` | 682 | Standard |
| `SWEP:SecondaryAttack()` | 696 | Standard guard |
| `SWEP:Reload()` | 707 | Standard guard |
| `SWEP:Deploy()` | 718 | Standard |
| `SWEP:DrawWorldModel()` (CLIENT) | 763 | M8A7-specific offsets |

#### Unique to M8A7
- `SWEP.FireModes[1].shoot` callback (lines 35–46) — drives the burst.
- `SWEP:FireBurstRound()` — single-round burst step.
- Burst continuation block in `Think` (lines 316–320).
- `BurstCount = 4`, `BurstDelay = 0.05`.

### 1.5 `upload/weapon_bo3_drakon_unscoped.lua`

- **BaseClass**: `weapon_bo3_base_gun` (line 4) — proper inheritance (no copy-paste)
- **Concrete?** Yes — `SWEP.Spawnable = true` (line 12)
- **PrintName** (line 6): `"Drakon (Reddot)"`

#### Functions DEFINED

| Function | Line | Notes |
|---|---|---|
| `SWEP:Deploy()` | 139 | Standard copy of base-gun Deploy |
| `SWEP:DrawHUD()` (CLIENT) | 174 | Red-dot reticle with fade-in |
| `SWEP:DrawWorldModel()` (CLIENT) | 213 | Drakon-specific offsets |

#### OVERRIDDEN
`Deploy` (identical to base — likely a copy-paste leftover), `DrawHUD` (unique), `DrawWorldModel` (offsets).

#### INHERITED unchanged
`PrimaryAttack`, `SecondaryAttack`, `Reload`, `Think`, `Holster`, `MeleeAttack`, `DoMeleeTrace`, `EndMelee`, `StartMantle`, `EndMantle`, `HandleSprintingAnimations`, `GetViewModelPosition`, `HandleRunning`, `CalcView`, `ShootAnimation` — all inherited from `weapon_bo3_base_gun`.

#### Rechamber analysis
**No rechamber logic exists.** The Drakon's `FireModes` (lines 31–50) use `equip`/`holster` callbacks to flip `Primary.Automatic` between Full-Auto and Semi-Auto. There is no `PostShoot` override, no `IsBolt`/`IsPump` flag, no bolt timer. The animation table (line 99–113) does NOT contain a `rechamber` key — it uses raw `ACT_VM_*` string animations, which means `EasySendWeaponAnim("shoot", ...)` resolves through the `Animations["shoot"]` lookup that returns the string `"ACT_VM_PRIMARYATTACK"`. This is a string-anim reference, not a rechamber reference.

### 1.6 `upload/weapon_bo3_mr6.lua`

- **BaseClass**: `weapon_bo3_base_gun` (line 4)
- **Concrete?** Yes — `SWEP.Spawnable = true` (line 12)
- **PrintName** (line 6): `"MR6"`

#### Functions DEFINED

| Function | Line | Notes |
|---|---|---|
| `SWEP:DrawWorldModel()` (CLIENT) | 114 | MR6-specific offsets |

That's it. The MR6 is purely a config file — it inherits everything from `weapon_bo3_base_gun` and only adds stats, the Animations table, AnimSounds for reload/reload_empty, and a DrawWorldModel override.

### 1.7 `upload/weapon_bo3_icr1.lua`

- **BaseClass**: `weapon_bo3_base_gun` (line 4)
- **Concrete?** Yes — `SWEP.Spawnable = true` (line 12)
- **PrintName** (line 6): `"ICR-1"`

#### Functions DEFINED

| Function | Line | Notes |
|---|---|---|
| `SWEP:Deploy()` | 131 | Standard copy (likely redundant — base gun's Deploy is identical) |
| `SWEP:DrawWorldModel()` (CLIENT) | 171 | ICR-1-specific offsets |

#### Unique config
- `FireModes` (lines 31–50) with `equip`/`holster` callbacks toggling `Primary.Automatic` (Full-Auto ↔ Semi-Auto)
- AnimSounds includes `draw_first` (lines 125–128) — bolt back/forward on first deploy

### 1.8 `/home/z/my-project/lua/weapons/weapon_bo3_base_gun.lua` — the CUH-side BO3 base

- **BaseClass**: `weapon_cuh_base_gun` (line 14–15) — *different* from upload's `weapon_custom_uh_base_gun`
- **Concrete?** No — `SWEP.Spawnable = false`, `SWEP.AdminSpawnable = false` (lines 24–25)
- **PrintName** (line 17): `"BO3 Gun Base"`
- **Marker**: `SWEP.IsCUHWeapon = true` (line 26) — used by CUH menu detection
- Has a `print("[CUH] weapon_bo3_base_gun.lua loading...")` debug at the top (line 3)
- **No `CalcView` override** (line 116–118 comment) — inherits camera-bone handling from `weapon_cuh_base_gun`.

#### Functions DEFINED (CUH version)

| Function | Line | Notes |
|---|---|---|
| `SWEP:Initialize()` | 120 | Passthrough |
| `SWEP:ShootAnimation()` | 124 | Standard |
| `SWEP:PrimaryAttack()` | 134 | Melee gate |
| `SWEP:MeleeAttack()` | 155 | Standard |
| `SWEP:PlayMeleeSound(...)` | 200 | Standard |
| `SWEP:DoMeleeTrace()` | 211 | Standard |
| `SWEP:EndMelee()` | 250 | **Does NOT set `_engineWantsIdle`** (upload version does) |
| `SWEP:SecondaryAttack()` | 258 | Guard |
| `SWEP:Reload()` | 264 | **Adds `IN_USE` block** — prevents E+R (inspect) from triggering base reload |
| `SWEP:StartMantle()` | 275 | Standard |
| `SWEP:EndMantle()` | 310 | **Does NOT set `_engineWantsIdle`** |
| `SWEP:Think()` | 316 | Standard (no holster finish block in this version — wait, actually it does, lines 342–350) |
| `SWEP:Holster()` | 356 | Standard |
| `SWEP:Deploy()` | 377 | Standard + **`timer.Simple(0, ApplyAttachments)`** + sets `_justExitedSprint = false` |
| `SWEP:HandleRunning(ct)` | 412 | Cleaner version (no `DeployTime` no-op check) |
| `SWEP:HandleSprintingAnimations()` | 438 | Standard + sets `_justExitedSprint = true` on exit |

#### Functions OVERRIDDEN
Same set as upload version, **except** `CalcView`, `GetViewModelPosition`, `DrawWorldModel` are NOT overridden — they are inherited from `weapon_cuh_base_gun`.

#### INHERITED from `weapon_cuh_base_gun` (and transitively `weapon_custom_uh_base_gun`)
`CalcView` (with camera bone), `GetViewModelPosition` (with sway / inspect / lowering), `DrawWorldModel`, attachment system, stat cache, save/load per SteamID.

### 1.9 Upload vs CUH-side base gun — diff summary

| Aspect | `upload/weapon_bo3_base_gun.lua` | `/home/z/.../weapon_bo3_base_gun.lua` |
|---|---|---|
| BaseClass | `weapon_custom_uh_base_gun` | `weapon_cuh_base_gun` |
| Has `print()` debug | No | Yes (line 3) |
| Has `IsCUHWeapon` marker | No | Yes |
| Has `MantleDuration` default | Yes (`0.6`) | Yes (`0.6`) |
| Has `CalcView` override | Yes (camera bone) | No (inherited from CUH base) |
| Has `CameraAttachment = "Camera"` | Yes (line 58) | No (commented out, lines 68–74) |
| Has `bo3_camScale` ConVar | Yes (`bo3_camera_scale`) | No (lives in `weapon_cuh_base_gun`) |
| `EndMelee` sets `_engineWantsIdle = true` | Yes | No |
| `EndMantle` sets `_engineWantsIdle = true` | Yes | No |
| `MeleeAttack` clears `_engineWantsIdle`, `_customIdleActive` | Yes | No (only `ClearAnimSounds`) |
| `Reload()` blocks `IN_USE` | No | Yes (line 267) |
| `Deploy` applies attachments | No | Yes (`timer.Simple(0, ApplyAttachments)`, lines 404–408) |
| `Deploy` resets `_justExitedSprint` | No | Yes (line 402) |
| `HandleSprintingAnimations` sets `_justExitedSprint` | No | Yes (line 455) |
| `HandleRunning` has dead `if self:GetNWFloat("DeployTime", 10) then` | Yes | No (cleaned up) |
| Has `GetViewModelPosition` override | Yes (LoweredPos + AltPos + sprint Z) | No (inherited) |
| Has `DrawWorldModel` override | Yes (CLIENT block at end) | No (inherited) |

The CUH-side version is the **streamlined production** version. The upload version is the **older standalone** version that carried its own camera-bone CalcView, LoweredPos logic, and world-model code.

---

## 2. MELEE SYSTEM — the working reference

The canonical melee implementation lives in `upload/weapon_bo3_base_gun.lua`. It is duplicated verbatim in `weapon_bo3_krm262.lua` (lines 172–329) and `weapon_bo3_m8a7.lua` (lines 545–689). The CUH-side version (`/home/z/.../weapon_bo3_base_gun.lua`) is functionally identical but slightly trimmed.

### 2.1 E + M1 trigger — `PrimaryAttack` (upload base gun, lines 155–176)

```lua
function SWEP:PrimaryAttack()
    -- Block during melee or mantle animation
    if self._meleeActive then return end
    if self._mantleActive then return end

    -- E + M1 = melee
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end

        if SERVER or IsFirstTimePredicted() then
            self:MeleeAttack()
        end
        return
    end

    -- Normal shooting — delegate to base
    return BaseClass.PrimaryAttack(self)
end
```

**Guard chain (in order):**
1. `_meleeActive` — already mid-melee
2. `_mantleActive` — already mid-mantle
3. `IN_USE` key down → enter melee branch
4. `_nextMelee` cooldown
5. `Reloading` UH bool
6. `DeployTime` NW float (deploy animation still playing)
7. `FireMode == 0` (safe mode)
8. `SERVER or IsFirstTimePredicted()` — prediction gate

If `IN_USE` is NOT held, falls through to `BaseClass.PrimaryAttack(self)`.

### 2.2 `MeleeAttack()` — full flow (upload base gun, lines 185–241)

```lua
function SWEP:MeleeAttack()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    -- Cancel conflicting states
    self:SetUHBool("Zooming", false)

    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end

    -- Optionally cancel reload
    if self.MeleeInterruptReload ~= false and self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end

    -- Set melee state
    self._meleeActive = true
    self._engineWantsIdle = nil
    self._customIdleActive = false
    self:ClearAnimSounds()

    -- Play ["melee"] animation via EasySendWeaponAnim
    -- Falls back to ACT_VM_MELEE if the key doesn't exist.
    self:EasySendWeaponAnim("melee", ACT_VM_MELEE)

    local vm = self.Owner:GetViewModel()
    local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Timing
    self._meleeHitTime = ct + (self.MeleeHitDelay or 0.15)
    self._meleeHitDone = false
    self._meleeEndTime = ct + animDuration
    self._nextMelee = ct + (self.MeleeDelay or 0.6)

    -- Lock controls
    self:SetNextPrimaryFire(ct + animDuration)
    self:SetNextSecondaryFire(ct + animDuration)
    self.NextReload = ct + animDuration

    -- Play thirdperson shove animation (combine soldier/elite style)
    local seqIdx = self.Owner:SelectWeightedSequence(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
    if seqIdx and seqIdx > 0 then
        self.Owner:AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, seqIdx, 0, true)
    end

    -- Play swing sound
    self:PlayMeleeSound(self.MeleeSound, 75, 100)
end
```

**Step-by-step:**
1. Prediction gate (`sp or iftp`).
2. Cancel `Zooming` UH bool.
3. Cancel `Running` UH bool if set.
4. If `MeleeInterruptReload ~= false` AND currently reloading: clear Reloading bool, zero out `ReloadTime`/`ReloadEndTime` NW floats, kill the `UHReload_<steamid>` timer.
5. Set `_meleeActive = true`, clear `_engineWantsIdle`, `_customIdleActive`, call `ClearAnimSounds()`.
6. Play `["melee"]` anim via `EasySendWeaponAnim("melee", ACT_VM_MELEE)` — fallback to `ACT_VM_MELEE` if the key is absent.
7. Get viewmodel, read `SequenceDuration()` (fallback `0.5`).
8. Schedule `_meleeHitTime = ct + MeleeHitDelay` (default `0.15`).
9. Set `_meleeHitDone = false`.
10. Schedule `_meleeEndTime = ct + animDuration`.
11. Set `_nextMelee = ct + MeleeDelay` (default `0.6`) — the cooldown gate from `PrimaryAttack`.
12. Lock `SetNextPrimaryFire`, `SetNextSecondaryFire`, and `NextReload` to `ct + animDuration`.
13. Play thirdperson gesture: `ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND` via `AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, ...)`.
14. Play swing sound via `PlayMeleeSound(self.MeleeSound, 75, 100)`.

### 2.3 `PlayMeleeSound(soundEntry, vol, pitch)` (lines 243–253)

```lua
function SWEP:PlayMeleeSound(soundEntry, vol, pitch)
    -- Supports both single strings and tables of strings (random pick)
    if not soundEntry then return end
    local snd = soundEntry
    if istable(soundEntry) then
        snd = soundEntry[math.random(1, #soundEntry)]
    end
    if snd and snd ~= "" then
        self:EmitSound(snd, vol or 75, pitch or 100, 1, CHAN_USER_BASE)
    end
end
```

- Accepts string OR table-of-strings (random pick).
- Skips if `nil` or `""`.
- Channel is `CHAN_USER_BASE`.

### 2.4 `DoMeleeTrace()` (lines 261–303)

```lua
function SWEP:DoMeleeTrace()
    local ply = self.Owner
    if not IsValid(ply) then return end

    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64

    local tr = util.TraceHull({
        start = pos,
        endpos = pos + aim * range,
        filter = ply,
        mins = Vector(-10, -10, -10),
        maxs = Vector(10, 10, 10),
        mask = MASK_SHOT_HULL,
    })

    if tr.Hit then
        local target = tr.Entity

        if IsValid(target) and SERVER then
            local dmg = DamageInfo()
            dmg:SetDamage(self.MeleeDamage or 50)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(self)
            dmg:SetDamageForce(aim * (self.MeleeForce or 300))
            dmg:SetDamagePosition(tr.HitPos)
            dmg:SetDamageType(DMG_CLUB)

            target:TakeDamageInfo(dmg)
        end

        if SERVER then
            util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32)
        end

        self:PlayMeleeSound(self.MeleeHitSound, 75, 100)
    else
        self:PlayMeleeSound(self.MeleeMissSound, 65, 100)
    end

    ply:ViewPunch(self.MeleeViewPunch or Angle(-3, 0, 0))
end
```

**Trace parameters:**
- Type: `util.TraceHull` (box trace, not a ray).
- Hull box: ±10 units (a 20×20×20 cube).
- Mask: `MASK_SHOT_HULL`.
- Filter: owner.
- Range: `self.MeleeRange` (default 64).

**DamageInfo (server only, only if `tr.Hit` and `IsValid(target)`):**
- `SetDamage(self.MeleeDamage or 50)`
- `SetAttacker(ply)`
- `SetInflictor(self)`
- `SetDamageForce(aim * (self.MeleeForce or 300))`
- `SetDamagePosition(tr.HitPos)`
- `SetDamageType(DMG_CLUB)`
- Applied via `target:TakeDamageInfo(dmg)`.

**Side effects on hit (server only):**
- `util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32)` — amplitude 3, frequency 0.1, duration 0.3, radius 32.
- Plays `MeleeHitSound` at volume 75.

**On miss:**
- Plays `MeleeMissSound` at volume 65.

**Always:**
- `ply:ViewPunch(self.MeleeViewPunch or Angle(-3, 0, 0))`.

### 2.5 `EndMelee()` (lines 311–318)

```lua
function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self:ClearAnimSounds()
    self._engineWantsIdle = true
end
```

Clears: `_meleeActive`, `_meleeHitTime`, `_meleeHitDone`, `_meleeEndTime`, calls `ClearAnimSounds()`, signals engine idle takeover with `_engineWantsIdle = true`.

**NOTE (CUH-side version, line 250–256):** The CUH version does NOT set `_engineWantsIdle = true`. It only clears the four melee state fields and calls `ClearAnimSounds()`.

### 2.6 Melee state machine in `Think` (upload base gun, lines 450–461)

```lua
-- Melee hit timing
if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
    self._meleeHitDone = true
    if SERVER or IsFirstTimePredicted() then
        self:DoMeleeTrace()
    end
end

-- Melee end timing
if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
    self:EndMelee()
end
```

**Hit trace dispatch:** fires ONCE at `_meleeHitTime`, gated by `_meleeHitDone == false`, prediction-wrapped (`SERVER or IsFirstTimePredicted()`).

**End dispatch:** fires when `ct >= _meleeEndTime`, calls `EndMelee()` (which clears all state).

### 2.7 Melee fields (every reference weapon — all use identical values)

| Field | Default | Purpose |
|---|---|---|
| `MeleeDamage` | `50` | Damage per hit |
| `MeleeRange` | `64` | Trace length (Source units) |
| `MeleeDelay` | `0.6` | Cooldown between melee attacks (`_nextMelee` gate) |
| `MeleeForce` | `300` | Knockback force scalar |
| `MeleeHitDelay` | `0.15` | Seconds after start to perform hit trace |
| `MeleeViewPunch` | `Angle(-5, 0, 0)` | Camera punch on melee (fallback `Angle(-3, 0, 0)` in code) |
| `MeleeSound` | `"weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"` | Swing sound |
| `MeleeHitSound` | `{"...rifle_hit_00.wav", "...rifle_hit_00.wav"}` | Hit sound (table — random pick) |
| `MeleeMissSound` | `"nil"` | Miss sound |
| `MeleeInterruptReload` | `true` | If true, melee cancels in-progress reload |

### 2.8 Holster clears melee state (upload base gun, lines 480–487)

```lua
function SWEP:Holster()
    if self._meleeActive then
        self._meleeActive = false
        self._meleeHitTime = nil
        self._meleeHitDone = nil
        self._meleeEndTime = nil
        self:ClearAnimSounds()
    end
    ...
end
```

### 2.9 Deploy resets melee state (upload base gun, lines 525–530)

```lua
-- Reset melee state
self._meleeActive = nil
self._meleeHitTime = nil
self._meleeHitDone = nil
self._meleeEndTime = nil
self._nextMelee = nil
```

Also resets mantle state (lines 532–536) and `_lastBO3IsVaulting` / `_lastBO3IsMantling` to `false`.

---

## 3. SHOTGUN RELOAD SYSTEM (KRM-262 reference, base in `weapon_bo3_base_shotty.lua`)

The shell-by-shell reload flow is defined entirely in `upload/weapon_bo3_base_shotty.lua` (lines 68–177). The KRM-262 inherits `ReloadShotgun` and only overrides `PostShoot` (pump) — the rest of the shotgun reload state is inherited.

### 3.1 `Reload()` — start-reload flow (lines 68–127)

```lua
function SWEP:Reload()
    local ct = CurTime()

    if self.NextReload < ct and not self:GetUHBool("Reloading") and not self:GetUHBool("Running")
        and self.Owner:GetNWFloat("GrenadeTime") < ct
        and self:GetNWFloat("DeployTime") < ct then

        if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and self:Clip1() < self.Primary.ClipSize then
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

            self.Owner:SetAnimation(PLAYER_RELOAD)
            self.NextReload = ct + 0.5

            self:PreReload()

            if SERVER then
                if self.Owner:GetNWBool("UH_Flashlight") then
                    self.Owner:SetNWBool("UH_Flashlight", false)
                    self.Owner:SetNWBool("UH_ArmGone", false)
                    if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                        self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
                    end
                    self.Owner:EmitSound("uh/flashlight.wav")
                    net.Start("UH_Flashlight")
                        net.WriteEntity(self.Owner)
                        net.WriteBool(false)
                    net.Broadcast()
                elseif self.Owner:GetNWBool("UH_Flare") then
                    UHThrowFlare(self.Owner)
                    self.Owner:SetNWBool("UH_ArmGone", false)
                    if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                        self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
                    end
                end
            end

            -- Play the start reload animation via named key
            self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)

            local vm = self.Owner:GetViewModel()
            local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

            self:SetNextPrimaryFire(ct + startDur + 0.1)
            self:SetNextSecondaryFire(ct + startDur + 0.1)
            self.NextReload = ct + startDur + 0.1

            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)

            -- Shell insertion starts after the start animation finishes.
            -- The reloaddelay timer in ReloadShotgun handles the rest.
            self.reloaddelay = ct + startDur + self.ShellLoadTime

            local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
            local amount = num * self.ShellLoadTime
            self:SetNWFloat("ReloadTime", amount)
            self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
        end
    end
end
```

**Guard chain (outer, line 71):**
1. `NextReload < ct` (fire/reload cooldown expired)
2. `not Reloading` (not already reloading)
3. `not Running` (not sprinting)
4. `GrenadeTime < ct` (not cooking a grenade)
5. `DeployTime < ct` (deploy finished)

**Guard chain (inner, line 75):**
6. Reserve ammo > 0
7. `Clip1() < Primary.ClipSize` (clip not already full)

**Side effects:**
- If `FireMode == 0` (safe mode), auto-bumps to `1` (line 76).
- Plays `PLAYER_RELOAD` thirdperson anim.
- Sets `NextReload = ct + 0.5` (brief lockout during the start anim).
- Calls `PreReload()` hook (line 81) — UH-base hook.
- Server-side: clears `UH_Flashlight` / `UH_Flare` states if active, broadcasts net message, sets arm-gone timing (unless `IsBolt`/`IsPump`/`TwoHanded`).
- Plays `["start_reload"]` anim (fallback `ACT_SHOTGUN_RELOAD_START`).
- Reads `vm:SequenceDuration()` as `startDur` (fallback `0.5`).
- Locks primary, secondary, NextReload for `startDur + 0.1`.
- Sets `Reloading = true`, `Zooming = false`.
- **Sets `self.reloaddelay = ct + startDur + self.ShellLoadTime`** — this is the field the prompt called `_krm_nextShell`. The actual name is `reloaddelay` (a UH-base field). It is the timestamp at which the FIRST shell will be inserted.
- Computes `num = min(clipRoom, reserveAmmo)` and `amount = num * ShellLoadTime`.
- Sets `ReloadTime` NW float = `amount` (total reload duration, used by HUD).
- Sets `ReloadEndTime` NW float = `ct + startDur + amount` (absolute finish time).

**HUD reload timer (ReloadTime / ReloadEndTime NW floats):**
- `ReloadTime` is set to the *remaining duration* of the shell insertion phase (NOT counting the start animation). Used by the HUD progress bar.
- `ReloadEndTime` is the absolute `CurTime()` at which the entire reload will finish (start anim + shells).
- Both are zeroed in `ReloadShotgun` when reload ends (lines 152–153) and also when reload is cancelled (lines 219–220 in `MeleeAttack`, lines 387–388 in `StartMantle`).

### 3.2 `ReloadShotgun(ct)` — shell-by-shell loop (lines 136–177)

```lua
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

    -- STOP CONDITIONS: clip full, no reserve ammo, or player pressed fire
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then

        self:ClearAnimSounds()
        -- Play the end animation
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)

        local vm = self.Owner:GetViewModel()
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur

        self.reloaddelay = nil

        self:PostReload()
        return
    end

    -- RELOAD LOOP: animation-driven shell insertion
    -- When reload_loop finishes one cycle, insert a shell and restart.
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) and vm:GetCycle() >= 1 then
        -- Insert shell
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end

        -- Restart the animation (replays reload_loop)
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
    end
end
```

**Dispatch mechanism:**
- The BO3 shotgun base does NOT override `Think`. The `ReloadShotgun(ct)` method is called from the UH base (`weapon_uh_base_shotty:Think`), which passes `CurTime()` as `ct`. This is why the prompt notes "dispatched from Think, not CustomThink" — but the dispatcher is the *UH* base, not any BO3 file.

**Function flow:**
1. If not `Reloading`, return immediately.
2. Check stop conditions (any of):
   - `Clip1() >= Primary.ClipSize` (clip full)
   - Reserve ammo `<= 0`
   - `KeyPressed(IN_ATTACK)` (player pressed fire to cancel)
3. If stopping:
   - `ClearAnimSounds()`
   - Play `["after_reload"]` anim (fallback `ACT_SHOTGUN_RELOAD_FINISH`)
   - Read `endDur` from viewmodel (fallback `0.8`)
   - Clear `Reloading` UH bool
   - Zero `ReloadTime` and `ReloadEndTime` NW floats
   - Lock primary, secondary, `NextReload` for `endDur`
   - Clear `self.reloaddelay`
   - Call `PostReload()` hook
   - Return
4. Otherwise, *animation-driven* shell insertion:
   - If viewmodel exists and `vm:GetCycle() >= 1` (animation reached end):
     - **SERVER ONLY**: `SetClip1(Clip1() + 1)`, `RemoveAmmo(1, Primary.Ammo, false)`
     - Replay `["reload_loop"]` anim (fallback `ACT_VM_RELOAD`)

**Important: this is NOT timer-driven.** The comment at the top of `ReloadShotgun` ("Adds one shell per ShellLoadTime interval (via reloaddelay timer)") is misleading — the code actually inserts shells when the `reload_loop` animation reaches cycle 1, NOT when `ct >= reloaddelay`. The animation's natural duration is what sets the per-shell cadence. `reloaddelay` is set in `Reload()` but is not actually checked here (it's used by the UH base elsewhere, presumably as a no-earlier-than gate for the first shell).

### 3.3 `SetupAnimSounds` calls after every `EasySendWeaponAnim`

**None.** No BO3 reference file calls `SetupAnimSounds()` explicitly. The `EasySendWeaponAnim` helper (provided by the UH/CUH base) is assumed to internally call `SetupAnimSounds(self.AnimSounds[<key>])` after sending the weapon anim. Each KRM-262 `AnimSounds` entry (e.g. `["reload_loop"]` with `{time=0.35, sound="Weapon_BLACKOPS3_SPARTAN.Shell_In"}`) is therefore triggered automatically by `EasySendWeaponAnim`.

### 3.4 Animation keys used (shotgun reload)

| Key | Used at | Defined in |
|---|---|---|
| `start_reload` | `Reload()` line 105 | `weapon_bo3_base_shotty` line 17 = `"base_reload_in"` |
| `reload_loop` | `ReloadShotgun()` line 175 | NOT in base shotty's `Animations` table; KRM-262 line 90 = `"base_reload_loop"` |
| `after_reload` | `ReloadShotgun()` line 146 | `weapon_bo3_base_shotty` line 18 = `"base_reload_out"`; KRM-262 line 92 = `"base_reload_out"` |

### 3.5 PreReload / PostReload hooks

- `PreReload()` — called at line 81, BEFORE the start animation. (Provided by UH base; default no-op.)
- `PostReload()` — called at line 160, AFTER the end animation begins. (Provided by UH base; default no-op.)

---

## 4. PUMP ACTION / RECHAMBER (KRM-262 reference)

The KRM-262 overrides `PostShoot` (lines 139–154) to play the pump animation. This is the only rechamber pattern in the BO3 references — the Drakon has none (see §6).

### 4.1 `PostShoot()` — pump animation timer (KRM-262 lines 139–154)

```lua
function SWEP:PostShoot()
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.4

    -- Ensure fire+sprint block lasts AT LEAST pumpDelay long
    -- but don't shorten a longer Primary.Delay
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))

    timer.Simple(pumpDelay, function()
        if !IsValid(self) or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end

        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)
    end)
end
```

**Flow:**
1. Read `PumpDelay` (KRM = `0.2`, fallback `0.4`).
2. **Lock fire**: `SetNextPrimaryFire(math.max(current, ct + pumpDelay))`. This ensures the next shot is blocked for AT LEAST `pumpDelay`, but never *shortens* a longer `Primary.Delay` that was already set by the base.
3. Same for `SetNextSecondaryFire`.
4. Schedule `timer.Simple(pumpDelay, ...)`:
   - Validates self, owner, owner's active weapon still matches (handles holster/swap).
   - Picks `"rechamber_ads"` if `Zooming` UH bool is set, else `"rechamber"`.
   - Plays the anim via `EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)` — fallback `ACT_SHOTGUN_PUMP`.

### 4.2 `PumpDelay` field

KRM-262 line 58: `SWEP.PumpDelay = 0.2`

### 4.3 How `PrimaryAttack` calls `PostShoot`

The KRM-262's `PrimaryAttack` (lines 172–193) delegates to `BaseClass.PrimaryAttack(self)`:

```lua
return BaseClass.PrimaryAttack(self)
```

`PostShoot` is therefore called by the UH base's `PrimaryAttack` implementation (after firing bullets). The BO3 files do NOT call `PostShoot` explicitly from `PrimaryAttack` — they rely on the UH base calling it.

### 4.4 `rechamber` vs `rechamber_ads` animation keys

KRM-262 `Animations` (lines 101–102):
```lua
["rechamber"]      = "base_rechamber",
["rechamber_ads"]  = "base_rechamber_ads",
```

KRM-262 `AnimSounds` (lines 124–131):
```lua
["rechamber"] = {
    {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
    {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
},
["rechamber_ads"] = {
    {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
    {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
},
```

The zoom check happens inside the `timer.Simple` callback at fire time + `PumpDelay` (line 151). This means the player's zoom state at that moment (not at fire time) decides which anim plays.

### 4.5 The other PostShoot — `weapon_bo3_base_shotty` lines 182–197

```lua
function SWEP:PostShoot()
    if not self.IsPump then return end

    if self:Clip1() <= 0 and GetConVar("uh_sv_realpump"):GetBool() then
        if timer.Exists("UH_Shell_"..self.Owner:SteamID()) then
            timer.Remove("UH_Shell_"..self.Owner:SteamID())
        end
    else
        timer.Simple(self.PumpDelay or 0.5, function()
            if not IsValid(self) or self:GetUHBool("Reloading") or not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() ~= self then return end
            if game.SinglePlayer() or IsFirstTimePredicted() then
                self.Owner:EmitSound(self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE)
            end
            self:EasySendWeaponAnim("pump", ACT_SHOTGUN_PUMP)
        end)
    end
end
```

This is the **shotgun-base** version that KRM-262 overrides. Differences:
- Gated by `self.IsPump` (not present → return).
- Checks `uh_sv_realpump` ConVar — if true and clip is empty, removes the `UH_Shell_` timer (no pump on empty).
- Uses `["pump"]` anim key (no `_ads` variant).
- Plays `Primary.PumpSound` (KRM-262 doesn't have a `PumpSound` field — the override plays sound through `AnimSounds["rechamber"]` instead).

The KRM-262's override is *simpler* (no `IsPump` gate, no realpump ConVar) and *richer* (zoom-aware anim selection, anim-sound driven pump rather than direct `EmitSound`).

---

## 5. BURST FIRE (M8A7 reference)

The M8A7 is the burst-fire reference. It is also the only BO3 reference that inherits directly from `weapon_uh_base_gun` (not `weapon_bo3_base_gun`) — it copy-pastes the BO3 melee/mantle/parkour code inline.

### 5.1 `SWEP.FireModes` table (lines 32–51)

```lua
SWEP.FireModes = {
    {
        name = "4 Round Burst",
        shoot = function(ply, wep)
            -- Don't start a new burst if one is already going
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end

            -- Initialize burst — fire first round immediately
            wep._burstRemaining = (wep.BurstCount or 3)
            wep._burstDelay = wep.BurstDelay or 0.1
            wep:FireBurstRound()

            return true
        end
    },
    {
        name = "Semi-Auto"
    }
}
```

**FireMode[1] = "4 Round Burst"** has a `shoot` callback. **FireMode[2] = "Semi-Auto"** has no callback — falls through to the UH base's normal `PrimaryAttack`.

### 5.2 Shoot callback flow

1. If `_burstRemaining > 0`, return `true` (already mid-burst — `true` tells the UH base the input was consumed, so the M1 press doesn't fall through to default fire).
2. If `CanPrimaryAttack()` returns false (out of ammo, etc.), return `false`.
3. Initialize burst state:
   - `_burstRemaining = BurstCount or 3` (M8A7 = `4`)
   - `_burstDelay = BurstDelay or 0.1` (M8A7 = `0.05`)
4. Call `FireBurstRound()` — fires the first round immediately.
5. Return `true`.

### 5.3 `FireBurstRound()` — full flow (lines 468–537)

```lua
function SWEP:FireBurstRound()
    if not IsValid(self) or not IsValid(self.Owner) then return end
    if not self:CanPrimaryAttack() then
        self._burstRemaining = nil
        return
    end

    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    -- Bullets
    if SERVER or iftp then
        if self:GetNWBool("Silenced") then
            self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.Round(math.random(self.Primary.MinDamage, self.Primary.MaxDamage) * 0.95), self.Penetration or 2)
        else
            self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.random(self.Primary.MinDamage, self.Primary.MaxDamage), self.Penetration or 2)
        end
    end

    -- Recoil
    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)

    if sp or (CLIENT and iftp) then
            self:DoMuzzleFlash()
            
            self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )
            
            if not self.NoShell then
                self:CreateShell( self.ShellDelay or 0, self.ShellHeat )
            end
            
            self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
    end

    self.Owner:ViewPunch(Angle(recoil, 0, 0))

    -- Animation: uses ShootAnimation() which checks ["iron_fire"] (zoomed)
    -- or ["fire"] (hip), falls back to ACT_VM_PRIMARYATTACK.
    local shootAnim = self:ShootAnimation()
    if type(shootAnim) == "string" then
        self:EasySendWeaponAnim(shootAnim, ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:MuzzleFlash()

    local fireSound = self:GetShootSound()
    self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)

    self.NextReload = CurTime() + 0.5
    self:PostShoot()

    -- Burst timing
    if SERVER or iftp then
        self._burstRemaining = self._burstRemaining - 1

        if self._burstRemaining > 0 then
            self._burstNextFire = ct + self._burstDelay
            self:SetNextPrimaryFire(ct + self._burstDelay)
        else
            self._burstRemaining = nil
            self:SetNextPrimaryFire(ct + self.Primary.Delay * 3)
            self:SetNextSecondaryFire(ct + self.Primary.Delay * 3)
        end
    end
end
```

**Step-by-step:**

1. **Validity + CanPrimaryAttack check** (lines 469–473): If can't attack, clear `_burstRemaining` and return — this terminates the burst if ammo runs out mid-burst.

2. **Bullets** (lines 480–486): `SERVER or iftp` gate. Two paths:
   - Silenced (`GetNWBool("Silenced")`): `ShootBullets` with `math.Round(rand(MinDmg, MaxDmg) * 0.95)` and `Penetration or 2`.
   - Normal: `ShootBullets` with `math.random(MinDmg, MaxDmg)` and `Penetration or 2`.

3. **Recoil** (line 489): `util.SharedRandom("uh_recoil", MinRecoil, MaxRecoil) * (Zooming and 0.35 or 1)` — shared random so client/server agree; multiplied by 0.35 if zooming.

4. **Visual + eye-angle recoil** (lines 491–501): `sp or (CLIENT and iftp)` gate.
   - `DoMuzzleFlash()`
   - `CreateSmoke(self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32))`
   - If `not NoShell`: `CreateShell(self.ShellDelay or 0, self.ShellHeat)`
   - `Owner:SetEyeAngles(EyeAngles() + Angle(recoil, 0, 0))` — actual camera kick.

5. **ViewPunch** (line 503): `Angle(recoil, 0, 0)`.

6. **Animation** (lines 507–512): Calls `ShootAnimation()` (returns the key string), then `EasySendWeaponAnim(key, ACT_VM_PRIMARYATTACK)`. If `ShootAnimation()` returns a non-string (the `ACT_VM_PRIMARYATTACK` fallback), uses bare `SendWeaponAnim`.

7. **Thirdperson + sound** (lines 514–518): `Owner:SetAnimation(PLAYER_ATTACK1)`, `Owner:MuzzleFlash()`, `EmitSound(GetShootSound(), 110, 100, 1, CHAN_WEAPON)`.

8. **Ammo + reload lockout** (lines 519–521): `TakePrimaryAmmo(TakeAmmo)`, `NextReload = CurTime() + 0.5`.

9. **PostShoot** (line 522): Calls `PostShoot()` — for the M8A7 this is the UH base's `PostShoot` (no pump; M8A7 doesn't override).

10. **Burst bookkeeping** (lines 525–536): `SERVER or iftp` gate.
    - Decrement `_burstRemaining`.
    - If more rounds remain (`_burstRemaining > 0`):
      - `_burstNextFire = ct + _burstDelay` — when the next round fires.
      - `SetNextPrimaryFire(ct + _burstDelay)` — fire gate.
    - Else (burst done):
      - `_burstRemaining = nil`
      - `SetNextPrimaryFire(ct + Primary.Delay * 3)` — **post-burst cooldown** = 3× the normal delay.
      - `SetNextSecondaryFire(ct + Primary.Delay * 3)`.

### 5.4 `BurstCount`, `BurstDelay` fields

M8A7 lines 70–71:
```lua
SWEP.BurstCount = 4    -- rounds per burst
SWEP.BurstDelay = 0.05  -- seconds between each round
```

### 5.5 Burst state fields

| Field | Purpose | Set where |
|---|---|---|
| `_burstRemaining` | Rounds left in current burst (nil when no burst) | shoot callback, FireBurstRound, Holster, StartMantle |
| `_burstNextFire` | Absolute time the next burst round should fire | FireBurstRound |
| `_burstDelay` | Per-round delay (cached from `BurstDelay` at burst start) | shoot callback |

### 5.6 Burst continuation in `Think` (lines 316–320)

```lua
-- Continue burst rounds (works even if player released M1)
if self._burstRemaining and self._burstRemaining > 0 then
    if ct >= (self._burstNextFire or 0) then
        self:FireBurstRound()
    end
end
```

This is inline in `Think` (NOT `CustomThink`). It fires the next burst round when `ct >= _burstNextFire`, regardless of whether the player is still holding M1 — this is what makes it a true burst (releasing M1 doesn't cancel the burst).

### 5.7 How Holster cancels the burst (lines 146–171)

```lua
function SWEP:Holster(wep)
    -- Cancel any in-flight burst
    self._burstRemaining = nil
    self._burstNextFire = nil
    -- Cancel rechamber
    self._isRechambering = false
    -- Reset animation transition trackers
    self.wasZooming = false
    self.wasRunning = false
    -- Cancel melee
    if self._meleeActive then
        self._meleeActive = false
        self._meleeHitTime = nil
        self._meleeHitDone = nil
        self._meleeEndTime = nil
        self:ClearAnimSounds()
    end
    -- Cancel mantle
    if self._mantleActive then
        self._mantleActive = false
        self._mantleEndTime = nil
        self:ClearAnimSounds()
    end
    -- Note: timer.Simple closures will still fire but the above
    -- state resets make their checks self-correcting
    return BaseClass.Holster(self, wep)
end
```

**NOTE:** The M8A7's `Holster` takes a `wep` argument (line 146) and passes it to `BaseClass.Holster(self, wep)`. This is the only BO3 reference that does so — Garry's Mod's `Holster` is documented to receive the new weapon as an argument, so this is technically more correct than the other files (which ignore it).

### 5.8 Post-burst cooldown

`Primary.Delay * 3` — set on both `SetNextPrimaryFire` and `SetNextSecondaryFire` when the burst finishes (line 533–534). For the M8A7: `0.06 * 3 = 0.18` seconds. This prevents immediately starting a new burst.

### 5.9 StartMantle also cancels burst (lines 250–252)

```lua
-- Cancel burst
self._burstRemaining = nil
self._burstNextFire = nil
```

This is in M8A7's `StartMantle()` — unique to the M8A7 (the base gun's `StartMantle` does not cancel burst, since the base gun has no burst).

---

## 6. PARKOUR / MANTLE SYSTEM

The parkour detection system is identical across `weapon_bo3_base_gun`, `weapon_bo3_krm262`, `weapon_bo3_m8a7`, and the CUH-side base. The mantle state is driven by an external BO3 parkour addon that sets `BO3_IsVaulting` / `BO3_IsMantling` NW2 bools on the player.

### 6.1 BO3_IsVaulting / BO3_IsMantling detection (upload base gun lines 425–443)

```lua
local ply = self.Owner
if IsValid(ply) then
    local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
    local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
    local isInTraversal = isVaulting or isMantling

    if isInTraversal and not self._mantleActive then
        if SERVER or IsFirstTimePredicted() then
            self:StartMantle()
        end
    end

    if not isInTraversal and self._mantleActive then
        self:EndMantle()
    end

    self._lastBO3IsVaulting = isVaulting
    self._lastBO3IsMantling = isMantling
end
```

- Reads BOTH `BO3_IsVaulting` and `BO3_IsMantling` and ORs them into `isInTraversal`.
- Starts mantle on rising edge (`isInTraversal and not _mantleActive`).
- Ends mantle on falling edge (`not isInTraversal and _mantleActive`).
- Caches `_lastBO3IsVaulting` / `_lastBO3IsMantling` (these are NOT read anywhere else in the file — they are vestigial tracking fields, possibly used by subclasses or for debugging).

### 6.2 `StartMantle()` (upload base gun lines 357–403)

```lua
function SWEP:StartMantle()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    -- Cancel conflicting states
    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end
    if self._meleeActive then
        self:EndMelee()
    end

    -- Cancel reload
    if self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end

    -- Set mantle state
    self._mantleActive = true
    self._engineWantsIdle = nil
    self._customIdleActive = false
    self:ClearAnimSounds()

    -- Play ["mantle"] animation
    self:EasySendWeaponAnim("mantle", ACT_VM_MELEE_SHOVE)

    local vm = self.Owner:GetViewModel()
    local animDuration = IsValid(vm) and vm:SequenceDuration() or (self.MantleDuration or 0.6)

    -- Use whichever is longer: animation duration or addon traversal duration
    local mantleDur = math.max(animDuration, self.MantleDuration or 0.6)
    self._mantleEndTime = ct + mantleDur

    -- Lock controls
    self:SetNextPrimaryFire(ct + mantleDur)
    self:SetNextSecondaryFire(ct + mantleDur)
    self.NextReload = ct + mantleDur
end
```

**Flow:**
1. Prediction gate.
2. Cancel `Zooming`, `Running`.
3. If mid-melee, call `EndMelee()` to clean it up.
4. If reloading, cancel reload (same pattern as melee): clear bool, zero NW floats, kill `UHReload_` timer.
5. Set `_mantleActive = true`, clear `_engineWantsIdle`, `_customIdleActive`, call `ClearAnimSounds()`.
6. Play `["mantle"]` anim (fallback `ACT_VM_MELEE_SHOVE`).
7. Read `vm:SequenceDuration()` (fallback `MantleDuration or 0.6`).
8. `mantleDur = math.max(animDuration, MantleDuration)` — uses whichever is longer (so the weapon stays locked even if the anim is shorter than the traversal, or vice versa).
9. `_mantleEndTime = ct + mantleDur`.
10. Lock primary, secondary, `NextReload` for `mantleDur`.

### 6.3 `EndMantle()` (lines 410–415)

```lua
function SWEP:EndMantle()
    self._mantleActive = false
    self._mantleEndTime = nil
    self:ClearAnimSounds()
    self._engineWantsIdle = true
end
```

**CUH-side version** (line 310–314): Does NOT set `_engineWantsIdle = true`.

### 6.4 `_mantleActive`, `_mantleEndTime` state

| Field | Set where | Cleared where |
|---|---|---|
| `_mantleActive` | `StartMantle` | `EndMantle`, `Think` (timeout), `Holster`, `Deploy` |
| `_mantleEndTime` | `StartMantle` | `EndMantle`, `Holster`, `Deploy` |

### 6.5 Mantle timeout (lines 446–448)

```lua
-- Mantle timeout safety
if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
    self:EndMantle()
end
```

Safety net in case the parkour addon doesn't clear its NW bools — the mantle will end at `_mantleEndTime` regardless. This guarantees the weapon can't be locked forever.

### 6.6 Mantle animation key

| File | `["mantle"]` value |
|---|---|
| upload base gun | `"base_mantle_over"` (line 99) |
| KRM-262 | `"base_mantle_over"` (line 103) |
| M8A7 | `"base_mantle_over"` (line 112) |
| Drakon | `"ACT_VM_MANTLE"` (line 109) |
| MR6 | `"base_mantle_over"` (line 90) |
| ICR-1 | `"base_mantle_over"` (line 108) |
| CUH base | `"base_mantle_over"` (line 111) |

### 6.7 `MantleDuration` field

- upload base gun: `SWEP.MantleDuration = 0.6` (line 55)
- M8A7: `SWEP.MantleDuration = 0.6` (line 93)
- CUH base: `SWEP.MantleDuration = 0.6` (line 65)
- KRM-262, Drakon, MR6, ICR-1: NOT defined — they inherit or rely on the `or 0.6` fallback in `StartMantle`.

---

## 7. DEPLOY / HOLSTER SYSTEM

### 7.1 `Deploy()` (upload base gun lines 506–539)

```lua
function SWEP:Deploy()
    BaseClass.Deploy(self)
        
        self:SetHoldType( self.HoldType )

    if self.Animations and self.Animations["deploy"] then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW)
            local dur = vm:SequenceDuration()
            self:SetNextPrimaryFire(CurTime() + dur)
            self:SetNextSecondaryFire(CurTime() + dur)
            self.NextReload = CurTime() + dur
            self._nextIdlePlay = nil
            self._deployEndTime = CurTime() + dur
            self:SetNWFloat("DeployTime", 0)
        end
    end

    -- Reset melee state
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil

    -- Reset mantle state
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._lastBO3IsVaulting = false
    self._lastBO3IsMantling = false

    return false
end
```

**Flow:**
1. Call `BaseClass.Deploy(self)`.
2. `SetHoldType(self.HoldType)`.
3. If `Animations["deploy"]` exists:
   - Get viewmodel, validate.
   - Play `["deploy"]` anim (fallback `ACT_VM_DRAW`).
   - Read `dur = vm:SequenceDuration()`.
   - Lock primary, secondary, `NextReload` for `dur`.
   - Clear `_nextIdlePlay`.
   - Set `_deployEndTime = CurTime() + dur` (used elsewhere? not in this file — likely consumed by the UH base).
   - **`SetNWFloat("DeployTime", 0)`** — immediately clears the deploy-time NW float so the deploy animation is the only lockout (NOT a future timestamp). This is unusual: setting `DeployTime` to `0` rather than `CurTime() + dur` means subsequent `DeployTime < ct` checks (in `PrimaryAttack`, `Reload`) pass immediately. The actual lockout is via `SetNextPrimaryFire` etc.
4. Reset all melee state to `nil`.
5. Reset all mantle state to `nil`, plus the BO3 parkour cache fields to `false`.
6. Return `false` — **NOTE**: returning `false` from `Deploy` in Garry's Mod means "don't play the default draw animation"; the BO3 code has already played its own. (CUH-side version returns `true`.)

**CUH-side version differences (lines 377–410):**
- Adds `_justExitedSprint = false` reset.
- Adds `timer.Simple(0, function() if IsValid(self) and self.ApplyAttachments then self:ApplyAttachments() end end)` — applies attachment defaults on deploy (after one tick, so the viewmodel exists).
- Returns `true` (not `false`).

### 7.2 `Holster()` (upload base gun lines 480–504)

```lua
function SWEP:Holster()
    if self._meleeActive then
        self._meleeActive = false
        self._meleeHitTime = nil
        self._meleeHitDone = nil
        self._meleeEndTime = nil
        self:ClearAnimSounds()
    end
    if self._mantleActive then
        self._mantleActive = false
        self._mantleEndTime = nil
        self:ClearAnimSounds()
    end
    -- Cancel any in-flight burst
    self._burstRemaining = nil
    self._burstNextFire = nil
    -- Cancel rechamber
    self._isRechambering = false
    -- Reset animation transition trackers
    self.wasZooming = false
    self.wasRunning = false
    -- Note: timer.Simple closures will still fire but the above
    -- state resets make their checks self-correcting
    return BaseClass.Holster(self)
end
```

**State cleared (in order):**
1. `_meleeActive` + 3 sub-fields + `ClearAnimSounds()`
2. `_mantleActive` + sub-field + `ClearAnimSounds()`
3. `_burstRemaining`, `_burstNextFire` (cancel in-flight burst — even though upload base gun has no burst, the cleanup is there for subclasses)
4. `_isRechambering = false` (cancel any rechamber state — also defensive; the upload base gun never sets this)
5. `wasZooming = false`, `wasRunning = false` (animation transition trackers)
6. Delegates to `BaseClass.Holster(self)`.

**Comment is important**: "timer.Simple closures will still fire but the above state resets make their checks self-correcting." This refers to the KRM-262's `PostShoot` timer and any other deferred timers — they validate `IsValid(self)`, `IsValid(self.Owner)`, `self.Owner:GetActiveWeapon() == self` before acting, so a holster just makes their guards fail and they no-op.

### 7.3 `_holstering`, `_holsterFinish`, `_holsterTarget` — deferred weapon switch

These are handled in `Think` (upload base gun lines 463–474):

```lua
-- Holster finish
if self._holstering and self._holsterFinish and ct >= self._holsterFinish then
    self._holstering = nil
    self._holsterFinish = nil
    if SERVER or IsFirstTimePredicted() then
        local target = self._holsterTarget
        self._holsterTarget = nil
        if IsValid(target) then
            self.Owner:SelectWeapon(target:GetClass())
        end
    end
end
```

- `_holstering` (truthy) — flag indicating a holster is in progress.
- `_holsterFinish` — absolute `CurTime()` at which the holster completes.
- `_holsterTarget` — the weapon entity to switch to after holster.

**This is a deferred weapon switch**: the BO3 base supports a "play holster animation, THEN switch" pattern. The actual setting of `_holstering` / `_holsterFinish` / `_holsterTarget` is NOT in this file — it must be done by an external caller (probably the weapon-switch HUD or a higher-level controller) before `Think` runs.

The `Think` block fires the actual `Owner:SelectWeapon(target:GetClass())` once `ct >= _holsterFinish`, prediction-wrapped.

**CUH-side version** has the same block (lines 342–350).

---

## 8. THINK FUNCTION — the full state machine

### 8.1 `Think()` (upload base gun lines 418–478)

```lua
function SWEP:Think()
    local ct = CurTime()

    -- ==========================================
    -- PARKOUR TRAVERSAL DETECTION
    -- ==========================================
    local ply = self.Owner
    if IsValid(ply) then
        local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
        local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
        local isInTraversal = isVaulting or isMantling

        if isInTraversal and not self._mantleActive then
            if SERVER or IsFirstTimePredicted() then
                self:StartMantle()
            end
        end

        if not isInTraversal and self._mantleActive then
            self:EndMantle()
        end

        self._lastBO3IsVaulting = isVaulting
        self._lastBO3IsMantling = isMantling
    end

    -- Mantle timeout safety
    if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
        self:EndMantle()
    end

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then
            self:DoMeleeTrace()
        end
    end

    -- Melee end timing
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end

    -- Holster finish
    if self._holstering and self._holsterFinish and ct >= self._holsterFinish then
        self._holstering = nil
        self._holsterFinish = nil
        if SERVER or IsFirstTimePredicted() then
            local target = self._holsterTarget
            self._holsterTarget = nil
            if IsValid(target) then
                self.Owner:SelectWeapon(target:GetClass())
            end
        end
    end

    BaseClass.Think(self)
    self:HandleSprintingAnimations()
end
```

**Order of checks (verbatim):**

1. **Parkour traversal detection** (lines 425–443): Read `BO3_IsVaulting` / `BO3_IsMantling` NW2 bools. Start mantle on rising edge (prediction-wrapped). End mantle on falling edge. Cache last-seen values.
2. **Mantle timeout safety** (lines 446–448): If `ct >= _mantleEndTime`, end the mantle (regardless of parkour addon state).
3. **Melee hit timing** (lines 451–456): If `ct >= _meleeHitTime` AND not already done, set `_meleeHitDone = true` and call `DoMeleeTrace()` (prediction-wrapped).
4. **Melee end timing** (lines 459–461): If `ct >= _meleeEndTime`, call `EndMelee()`.
5. **Holster finish** (lines 464–474): If `ct >= _holsterFinish`, clear holster state and call `Owner:SelectWeapon(target:GetClass())` (prediction-wrapped).
6. **`BaseClass.Think(self)`** (line 476): Delegate to the UH/CUH base Think — this is where FireMode processing, reload state machine, idle handling, inspect, recoil recovery, etc. happen.
7. **`HandleSprintingAnimations()`** (line 477): Sprint in/out/loop anim dispatcher (defined locally on this SWEP).

**NOTE on `ReloadShotgun` dispatch**: This Think does NOT call `ReloadShotgun`. For the KRM-262, `ReloadShotgun` is dispatched by the UH shotgun base's `Think` (which is reached via the `BaseClass.Think(self)` call at line 476 / 487). This is why the prompt says "dispatched from Think, not CustomThink" — but the dispatcher is `weapon_uh_base_shotty:Think`, not the BO3 file's Think.

### 8.2 M8A7 `Think` (lines 284–337) — adds burst continuation

The M8A7 `Think` is identical to the upload base gun's EXCEPT for one inserted block (lines 316–320):

```lua
-- Continue burst rounds (works even if player released M1)
if self._burstRemaining and self._burstRemaining > 0 then
    if ct >= (self._burstNextFire or 0) then
        self:FireBurstRound()
    end
end
```

This is inserted BETWEEN the mantle timeout block and the melee hit timing block. The full M8A7 Think order:

1. Parkour detection
2. Mantle timeout
3. **Burst continuation** ← M8A7 only
4. Melee hit timing
5. Melee end timing
6. `BaseClass.Think(self)`
7. `HandleSprintingAnimations()`

(Note: the M8A7 Think does NOT have the holster-finish block.)

### 8.3 CUH-side `Think` (lines 316–354)

Identical to upload base gun's Think (parkour → mantle timeout → melee hit → melee end → holster finish → BaseClass.Think → HandleSprintingAnimations). No `_lastBO3IsVaulting` / `_lastBO3IsMantling` cache writes inside the `if IsValid(ply)` block — actually it does have them (line 327 is just `if not isInTraversal and self._mantleActive then self:EndMantle() end` without the cache write — wait, looking again, line 327 ends the `if IsValid(ply)` block, so no cache writes). Let me re-read:

```lua
local ply = self.Owner
if IsValid(ply) then
    local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
    local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
    local isInTraversal = isVaulting or isMantling
    if isInTraversal and not self._mantleActive then
        if SERVER or IsFirstTimePredicted() then self:StartMantle() end
    end
    if not isInTraversal and self._mantleActive then self:EndMantle() end
end
```

The CUH version does NOT write `_lastBO3IsVaulting` / `_lastBO3IsMantling` — those cache fields are vestigial in the upload version, and the CUH version simply dropped them.

---

## 9. ANIMATION SYSTEM

### 9.1 `SWEP.Animations` table — every key per file

| Key | upload base gun | base shotty | KRM-262 | M8A7 | Drakon | MR6 | ICR-1 | CUH base |
|---|---|---|---|---|---|---|---|---|
| `shoot` | `base_fire` | — | `base_fire` | `base_fire` | `ACT_VM_PRIMARYATTACK` | `base_fire` | `base_fire` | `base_fire` |
| `reload` | `base_reload` | — | — | `base_reload` | `ACT_VM_RELOAD` | `base_reload` | `base_reload` | `base_reload` |
| `reload_empty` | `base_reload_empty` | — | — | `base_reload_empty` | `ACT_VM_RELOAD_EMPTY` | `base_reload_empty` | `base_reload_empty` | `base_reload_empty` |
| `sprint_idle` | `base_idle` | — | `base_sprint_loop` | `base_sprint_loop` | `ACT_VM_SPRINT_LOOP` | `base_sprint_loop` | `base_sprint_loop` | `base_idle` |
| `sprint_in` | — | — | `base_sprint_in` | `base_sprint_in` | `ACT_VM_SPRINT_START` | `base_sprint_in` | `base_sprint_in` | — |
| `sprint_out` | — | — | `base_sprint_out` | `base_sprint_out` | `ACT_VM_SPRINT_END` | `base_sprint_out` | `base_sprint_out` | — |
| `iron_fire` | `base_fire_ads` | — | `base_fire_ads` | `base_fire_ads` | `ACT_VM_PRIMARYATTACK` | `base_fire_ads` | `base_fire_ads` | `base_fire_ads` |
| `idle` | `base_idle` | — | `base_idle` | `base_idle` | `ACT_VM_IDLE` | `base_idle` | `base_idle` | `base_idle` |
| `deploy` | `base_draw` | — | `base_draw` | `base_draw` | `ACT_VM_DRAW_QUICK` | `base_draw` | `base_draw` | `base_draw` |
| `melee` | `base_melee` | — | `base_melee` | `base_melee` | `ACT_VM_THROW` | `base_melee` | `base_melee` | `base_melee` |
| `mantle` | `base_mantle_over` | — | `base_mantle_over` | `base_mantle_over` | `ACT_VM_MANTLE` | `base_mantle_over` | `base_mantle_over` | `base_mantle_over` |
| `inspect` | — | — | `base_inspect` | — | — | — | `base_inspect` | — |
| `rechamber` | — | — | `base_rechamber` | — | — | — | — | — |
| `rechamber_ads` | — | — | `base_rechamber_ads` | — | — | — | — | — |
| `reload_loop` | — | — | `base_reload_loop` | — | — | — | — | — |
| `start_reload` | — | `base_reload_in` | `base_reload_in` | — | — | — | — | — |
| `after_reload` | — | `base_reload_out` | `base_reload_out` | — | — | — | — | — |
| `pump` | — | (used in code, not in table) | — | — | — | — | — | — |
| `first_draw` | — | — | — | — | `ACT_VM_DRAW_FIRST` | — | — | — |
| `holster` | — | — | — | — | `ACT_VM_HOLSTER` | — | — | — |

**Key observations:**
- The Drakon uses `ACT_VM_*` *string* animations rather than sequence names. This is unusual — `EasySendWeaponAnim` must accept either form (a string that the UH base resolves to a sequence, or a direct ACT enum).
- The base shotty only defines `start_reload` and `after_reload` — `reload_loop` is added by the KRM-262 subclass.
- The upload base gun does NOT define `sprint_in`/`sprint_out` — but `HandleSprintingAnimations` references both keys (lines 697, 703). The `EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)` call will fall back to `ACT_VM_SPRINT_ENTER` since the key is absent. This is a likely bug/oversight in the upload base gun.
- The CUH base gun similarly lacks `sprint_in`/`sprint_out`.

### 9.2 `SWEP.AnimSounds` — every key per file

#### KRM-262 (lines 106–137)
```lua
SWEP.AnimSounds = {
    ["start_reload"] = {
        {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Open"},
        {time = 0.9, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
    },
    ["reload_loop"] = {
        {time = 0.35, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
    },
    ["after_reload"] = {
        {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Close"},
        {time = 0.6, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["fire_last"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["rechamber"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["rechamber_ads"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["draw_first"] = {
        {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
        {time = 0.5, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
}
```

**Note**: `fire_last` is defined here but is NOT referenced in any code in the KRM-262 file. It's likely consumed by the UH base when `Clip1() == 1` (last round before empty). Similarly, `draw_first` is defined but not referenced in KRM-262 code — likely consumed by the UH base's first-deploy logic.

#### M8A7 (lines 118–132)
```lua
SWEP.AnimSounds = {
    ["reload"] = {
        {time = 0.35, sound = "Weapon_BLACKOPS3_M8A7.Magout"},
        {time = 1.41, sound = "Weapon_BLACKOPS3_M8A7.Magin"},
        {time = 1.90, sound = "Weapon_BLACKOPS3_M8A7.Tap"},
    },
    ["reload_empty"] = {
        {time = 0.35, sound = "Weapon_BLACKOPS3_M8A7.Magout"},
        {time = 1.41, sound = "Weapon_BLACKOPS3_M8A7.Magin"},
        {time = 1.90, sound = "Weapon_BLACKOPS3_M8A7.Tap"},
        {time = 2.25, sound = "Weapon_BLACKOPS3_M8A7.Bolt_Back"},
        {time = 2.45, sound = "Weapon_BLACKOPS3_M8A7.Bolt_Forward"},
    },
}
```

#### Drakon (lines 115–126)
```lua
SWEP.AnimSounds = {
    ["reload"] = {
        {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
        {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
    },
    ["reload_empty"] = {
        {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
        {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
        {time = 2.65, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
        {time = 2.80, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
    },
}
```

(Note: Drakon uses `Weapon_BLACKOPS3_ARAK.*` sounds — likely a copy-paste from an ARAK weapon.)

#### MR6 (lines 96–107)
```lua
SWEP.AnimSounds = {
    ["reload"] = {
        {time = 0.3, sound = "Weapon_BLACKOPS3_MR6.Magout"},
        {time = 0.75, sound = "Weapon_BLACKOPS3_MR6.Magin"},
    },
    ["reload_empty"] = {
        {time = 0.3, sound = "Weapon_BLACKOPS3_MR6.Magout"},
        {time = 0.75, sound = "Weapon_BLACKOPS3_MR6.Magin"},
        {time = 1.2, sound = "Weapon_BLACKOPS3_MR6.Slide_Back"},
        {time = 1.35, sound = "Weapon_BLACKOPS3_MR6.Slide_Forward"},
    },
}
```

#### ICR-1 (lines 114–129)
```lua
SWEP.AnimSounds = {
    ["reload"] = {
        {time = 0.4, sound = "Weapon_BLACKOPS3_ISR27.Magout"},
        {time = 1.50, sound = "Weapon_BLACKOPS3_ISR27.Magin"},
    },
    ["reload_empty"] = {
        {time = 0.4, sound = "Weapon_BLACKOPS3_ISR27.Magout"},
        {time = 1.50, sound = "Weapon_BLACKOPS3_ISR27.Magin"},
        {time = 2.1, sound = "Weapon_BLACKOPS3_ISR27.Bolt_Back"},
        {time = 2.25, sound = "Weapon_BLACKOPS3_ISR27.Bolt_Forward"},
    },
    ["draw_first"] = {
        {time = 0.5, sound = "Weapon_BLACKOPS3_ISR27.Bolt_Back"},
        {time = 0.7, sound = "Weapon_BLACKOPS3_ISR27.Bolt_Forward"},
    },
}
```

#### Upload base gun / base shotty / CUH base
All three have `SWEP.AnimSounds = {}` (empty table) — no anim-driven sounds at the base level.

### 9.3 `ShootAnimation()` — animation selection helper

Defined identically in upload base gun (line 143), KRM-262 (line 160), M8A7 (line 134), CUH base (line 124):

```lua
function SWEP:ShootAnimation()
    -- If zoomed and "iron_fire" exists in Animations, return the key
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    -- If not zoomed and "shoot" exists in Animations, return the key
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end
```

- Returns the string key (`"iron_fire"` or `"shoot"`) when applicable.
- Falls back to `ACT_VM_PRIMARYATTACK` (the integer ACT enum) if no key matches.

The M8A7's `FireBurstRound` checks the return type (line 508):
```lua
if type(shootAnim) == "string" then
    self:EasySendWeaponAnim(shootAnim, ACT_VM_PRIMARYATTACK)
else
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end
```

This shows how to handle the dual return type: string → `EasySendWeaponAnim`; non-string (the ACT enum) → bare `SendWeaponAnim`.

### 9.4 `HandleSprintingAnimations()` — sprint anim dispatcher

Defined identically in upload base gun (line 679), KRM-262 (line 690), M8A7 (line 430), CUH base (line 438). The CUH version adds `_justExitedSprint` flagging.

```lua
function SWEP:HandleSprintingAnimations()
    local ply = self:GetOwner()
    
    if not IsValid(ply) or not ply:IsPlayer() then return end

    -- Use UH variable for running state
    local isRunning = self:GetUHBool("Running")
    local isReloading = self:GetUHBool("Reloading")

    -- Initialize tracking variable
    if self.wasRunning == nil then self.wasRunning = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    -- TRANSITION: Enter Sprint
    if isRunning and not self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)
        end
    
    -- TRANSITION: Exit Sprint
    elseif not isRunning and self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)
        end
    
    -- LOOPING: While Sprinting (and not reloading)
    elseif isRunning and not isReloading then
        -- If the current sprint animation finished (cycle >= 1), restart it
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end

    self.wasRunning = isRunning
end
```

**Three branches:**
1. **Enter sprint** (rising edge): play `["sprint_in"]` (fallback `ACT_VM_SPRINT_ENTER`). Skip if reloading.
2. **Exit sprint** (falling edge): play `["sprint_out"]` (fallback `ACT_VM_SPRINT_LEAVE`). Skip if reloading.
3. **Looping sprint** (sustained): if `vm:GetCycle() >= 1` (anim reached end), restart `["sprint_idle"]` (fallback `ACT_VM_SPRINT_IDLE`). Skip if reloading.

**CUH version adds**: `self._justExitedSprint = true` after the exit-sprint anim (line 455). This flag is consumed elsewhere (probably by the inspect system or to suppress the first idle frame after sprint).

### 9.5 How `EasySendWeaponAnim` + `SetupAnimSounds` work together

The BO3 files call `EasySendWeaponAnim(key, fallbackACT)` everywhere. They never call `SetupAnimSounds` directly. The contract (inferred from usage):

- `EasySendWeaponAnim(key, fallbackACT)`:
  1. Look up `self.Animations[key]`. If present, send that sequence (or string-anim) on the viewmodel.
  2. If absent, send the `fallbackACT` (e.g. `ACT_VM_MELEE`).
  3. Internally call `SetupAnimSounds(self.AnimSounds[key])` to schedule the per-time sound entries via `timer.Simple` (or a similar mechanism).
  4. Reset the viewmodel's cycle to 0.

The exact implementation lives in `weapon_custom_uh_base_gun` (or `weapon_cuh_base_gun`) and is NOT in any of the audited files.

---

## 10. SPRINT SYSTEM

### 10.1 `HandleRunning(ct)` (upload base gun lines 541–586)

```lua
function SWEP:HandleRunning( ct )
    if self:GetUHBool("Reloading") then
        return
    end
        
        local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0 then return end
    end
        
        if self:GetNWFloat("DeployTime", 10) then


    local dist = self.Owner:GetVelocity():LengthSqr()
    local isSprinting = self.Owner:KeyDown( IN_SPEED ) and dist > self.Owner:GetWalkSpeed()^2
    local isSafeMode = self:GetNWInt("FireMode") == 0

    -- 1. SPRINTING (Takes Priority)
    if isSprinting then
        self:SetHoldType( self.PassiveAnim )
        self:SetUHBool("Running", true) -- Set to TRUE so animations play
        self:SetUHBool("Zooming", false)
        
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", false)
            self.NextReload = ct + 0.5
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove( "UHReload_"..self.Owner:SteamID() )
            end
        end

    -- 2. NOT SPRINTING
                else
                        self:SetHoldType( self.HoldType )
        
                        -- If we are in Safe Mode (and not sprinting), ensure we are flagged as NOT running.
                        -- This allows the procedural lowering to take effect.
                        if isSafeMode then
                                self:SetUHBool("Running", false) 
                        else
                                self:SetUHBool("Running", false)
                        end
                end
        end
end
```

**Flow:**
1. If reloading, return immediately (don't change sprint state mid-reload).
2. If viewmodel valid and fire delay > 0 (still in fire cooldown), return.
3. The `if self:GetNWFloat("DeployTime", 10) then` line is a **dead/no-op check** — it always evaluates truthy (a non-zero number is truthy in Lua), so it's effectively a no-op. The CUH version removes this.
4. Compute `dist = Owner:GetVelocity():LengthSqr()` (squared length — cheaper than `Length()`).
5. `isSprinting = KeyDown(IN_SPEED) AND dist > WalkSpeed^2`.
6. `isSafeMode = FireMode == 0`.
7. If sprinting:
   - `SetHoldType(PassiveAnim)` (e.g. `"passive"`).
   - `SetUHBool("Running", true)`.
   - `SetUHBool("Zooming", false)` (cancel ADS).
   - If reloading (defensive — already checked at top): cancel reload, lock `NextReload` for 0.5s, kill the UHReload timer.
8. If NOT sprinting:
   - `SetHoldType(HoldType)` (e.g. `"ar2"`, `"shotgun"`, `"pistol"`).
   - `SetUHBool("Running", false)` (same in both safe/non-safe mode branches — the if/else here is vestigial; both paths do the same thing).

**KRM-262 version** (lines 552–597): identical, except `fireDelay > 0.3` (line 560) vs `> 0` (upload base gun line 549). This means the KRM-262 allows sprinting during the first 0.3s of fire cooldown, while the upload base gun blocks sprinting until fire cooldown is fully expired.

**M8A7 version** (lines 174–219): identical to KRM-262 — `fireDelay > 0.3`.

**CUH version** (lines 412–436): cleaner — removes the dead `DeployTime` check, removes the vestigial `isSafeMode` if/else.

### 10.2 `wasRunning` state tracking

- Initialized to `false` on first call (`if self.wasRunning == nil then self.wasRunning = false end`).
- Set to `isRunning` at the end of every `HandleSprintingAnimations` call.
- Reset to `false` in `Holster` (line 499 upload / line 500 KRM / line 154 M8A7 / line 373 CUH).
- Reset to `false` in M8A7 `Holster` only.

### 10.3 `_justExitedSprint` flag

Only the CUH version sets this (line 455): `self._justExitedSprint = true` when transitioning out of sprint. Reset to `false` in `Deploy` (line 402). Not read anywhere in the audited files — likely consumed by the CUH base's idle or inspect logic.

### 10.4 Sprint cancels reload

In `HandleRunning`:
```lua
if self:GetUHBool("Reloading") then
    self:SetUHBool("Reloading", false)
    self.NextReload = ct + 0.5
    if timer.Exists("UHReload_"..self.Owner:SteamID()) then
        timer.Remove( "UHReload_"..self.Owner:SteamID() )
    end
end
```

This is inside the `if isSprinting then` branch — so sprinting cancels reload (but not vice versa; the top-of-function `if Reloading then return end` blocks the entire function if reloading, which means sprint state can't be CLEARED while reloading either. This is asymmetric and likely a bug — but it's how the upload version works. The KRM/M8A7 versions have the same pattern.

Actually wait — re-reading: the top `if Reloading then return end` is the FIRST check. So if you're reloading, `HandleRunning` exits immediately and doesn't even reach the sprint-detection logic. That means:
- If you're reloading and start sprinting: `HandleRunning` returns early, doesn't set `Running=true`, doesn't cancel reload.
- The reload continues. Sprint doesn't cancel reload via `HandleRunning`.
- The cancel-reload block inside `if isSprinting then` only fires if you're NOT reloading at the top check but somehow become reloading mid-function — which can't happen in a single tick.

This is dead code in the sprint-cancels-reload sense. The actual sprint-cancels-reload happens elsewhere (probably in the reload logic itself, which checks `Running` and bails).

---

## 11. IDLE / INSPECT SYSTEM

### 11.1 `HandleIdle()`

**NOT DEFINED in any audited BO3 file.** The idle handling is inherited from the UH/CUH base. The BO3 files only set `_engineWantsIdle` and `_customIdleActive` flags in `MeleeAttack` / `StartMantle` / `EndMelee` / `EndMantle`, which the UH base reads to decide whether to play the idle animation.

The upload version sets `_engineWantsIdle = true` in `EndMelee` (line 317) and `EndMantle` (line 414). The CUH version does NOT — relying on the CUH base to detect the cleared `_meleeActive` / `_mantleActive` flags.

### 11.2 `HandleInspect()` — E + R

**NOT DEFINED in any audited BO3 file.** Inspect is inherited from the UH/CUH base. The BO3 files reference an `inspect` animation key only in:
- KRM-262 `Animations["inspect"] = "base_inspect"` (line 100)
- ICR-1 `Animations["inspect"] = "base_inspect"` (line 107)

The detection (IN_USE + IN_RELOAD) is done by the UH base, which then plays `["inspect"]` if defined.

The CUH-side `Reload()` adds an `IN_USE` block (line 267):
```lua
if self.Owner:KeyDown(IN_USE) then return end
```
This prevents E+R from triggering reload — so E+R is reserved for inspect. The upload version does NOT have this guard, meaning E+R in the upload version would trigger reload (and NOT inspect, since reload takes the input).

### 11.3 `Inspecting` NW2 bool

Not referenced in any audited BO3 file. Managed entirely by the UH/CUH base.

### 11.4 How inspect animation works

The UH/CUH base detects `IN_USE + IN_RELOAD` (E + R), sets some `Inspecting` NW bool, plays `["inspect"]` anim via `EasySendWeaponAnim`. The BO3 files only contribute the `Animations["inspect"]` mapping (KRM-262 and ICR-1 only).

---

## 12. CAMERA BONE / CALCVIEW

### 12.1 `CalcView()` (upload base gun lines 110–137, base shotty lines 32–59)

```lua
function SWEP:CalcView(ply, pos, ang, fov)
    -- Camera bone angle tracking
    if self.CameraAttachment then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            local seq = self.m_CurrentSequence or vm:GetSequenceName(vm:GetSequence()) or ""
            if not string.find(seq, "Fire") and not string.find(seq, "Idle") then
                local attID = vm:LookupAttachment(self.CameraAttachment)
                if attID and attID > 0 then
                    local att = vm:GetAttachment(attID)
                    if att then
                        if self.CameraOffset then ang:Add(self.CameraOffset) end
                        local localAng = vm:WorldToLocalAngles(att.Ang)
                        if self.CameraReserve then localAng:Mul(-1) end
                        localAng:Mul((bo3_camScale and bo3_camScale:GetFloat()) or 1)
                        ang:Add(localAng)
                    end
                end
            end
        end
    end

    -- Pass to UH base for viewbobbing and FOV zoom
    if BaseClass.CalcView then
        return BaseClass.CalcView(self, ply, pos, ang, fov)
    end
    return pos, ang, fov
end
```

**Flow:**
1. If `CameraAttachment` is set (e.g. `"Camera"`):
   - Get viewmodel.
   - Get current sequence name (prefer `self.m_CurrentSequence`, fallback to viewmodel's current sequence name).
   - **EXCLUDE** sequences containing `"Fire"` or `"Idle"` — camera bone only applies during other states (reload, sprint, inspect, etc.).
   - Look up the attachment by name. If found, get its `Ang`.
   - Add `CameraOffset` to `ang` (if set).
   - Convert `att.Ang` to local angles relative to the viewmodel (`WorldToLocalAngles`).
   - If `CameraReserve`, multiply by `-1` (invert).
   - Multiply by `bo3_camScale` ConVar float (fallback `1`).
   - Add the local angles to the player's view angles.
2. Delegate to `BaseClass.CalcView` (UH base) for viewbobbing and FOV zoom.

### 12.2 `CameraAttachment` field

| File | Value |
|---|---|
| upload base gun | `"Camera"` (line 58) |
| base shotty | `"Camera"` (line 23) |
| KRM-262 | inherited from base shotty |
| M8A7 | NOT SET (M8A7 doesn't override CalcView and inherits from `weapon_uh_base_gun` which may or may not have camera bone — likely doesn't) |
| Drakon / MR6 / ICR-1 | inherited from upload base gun = `"Camera"` |
| CUH base | NOT SET (commented out, lines 68–74) — inherited from `weapon_cuh_base_gun` |

### 12.3 `CameraReserve`, `CameraOffset`

- `CameraReserve` (bool): if true, multiply localAng by -1 (invert).
- `CameraOffset` (Angle): added to `ang` before applying the camera bone.

All files that set these use `CameraReserve = false` and `CameraOffset = Angle(0, 0, 0)`.

### 12.4 Fire/Idle exclusion

The `string.find(seq, "Fire")` and `string.find(seq, "Idle")` checks (line 116) skip the camera bone during fire and idle animations. This is because the camera bone would otherwise fight the fire animation's recoil.

### 12.5 `cl_cuh_camera_scale` / `bo3_camera_scale` ConVar

Upload base gun + base shotty (lines 105–108 / 27–30):
```lua
local bo3_camScale
if CLIENT then
    bo3_camScale = CreateClientConVar("bo3_camera_scale", "1.0", FCVAR_ARCHIVE, "BO3 camera bone animation scale")
end
```

- ConVar name: `bo3_camera_scale` (NOT `cl_cuh_camera_scale` as the prompt states).
- Default: `1.0`.
- Flag: `FCVAR_ARCHIVE` (saved to user config).
- Help text: `"BO3 camera bone animation scale"`.

The CUH-side base gun does NOT create this ConVar — it's expected to live in `weapon_cuh_base_gun` (presumably with the same or a `cl_cuh_camera_scale` name; not verifiable from these files).

---

## 13. WORLD MODEL

### 13.1 `DrawWorldModel()` (upload base gun lines 717–740)

```lua
if CLIENT then
        local WorldModel = ClientsideModel(SWEP.WorldModel)
        WorldModel:SetSkin(1)
        WorldModel:SetNoDraw(true)

        function SWEP:DrawWorldModel()
                local _Owner = self:GetOwner()
                if IsValid(_Owner) then
                        local offsetVec = Vector(4, -2, 2)
                        local offsetAng = Angle(180, 180, 0)
                        local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand")
                        if not boneid then return end
                        local matrix = _Owner:GetBoneMatrix(boneid)
                        if not matrix then return end
                        local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
                        WorldModel:SetPos(newPos)
                        WorldModel:SetAngles(newAng)
                        WorldModel:SetupBones()
                else
                        WorldModel:SetPos(self:GetPos())
                        WorldModel:SetAngles(self:GetAngles())
                end
                WorldModel:DrawModel()
        end
end
```

**Pattern:**
1. Create a `ClientsideModel` ONCE at file load (cached upvalue `WorldModel`).
2. `SetSkin(1)` — second skin (BO3 guns use skin 1 as default).
3. `SetNoDraw(true)` — we'll draw it manually.
4. In `DrawWorldModel()`:
   - If owner is valid: attach to `ValveBiped.Bip01_R_Hand` bone via `LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())`.
   - If dropped (no owner): use the weapon entity's own pos/ang.
   - Always call `WorldModel:DrawModel()`.

### 13.2 `WorldModelOffset`, `WorldModelAngle`

The prompt references `WorldModelOffset` and `WorldModelAngle` fields — these do NOT exist as SWEP fields. The offsets are hardcoded *per-weapon* inside the `DrawWorldModel` closure (e.g. `Vector(4, -2, 2)` for MR6, `Vector(0, -2, -1)` for KRM, `Vector(0, -2, -0.5)` for M8A7, etc.).

### 13.3 Per-weapon offset table

| File | offsetVec | offsetAng |
|---|---|---|
| upload base gun | `Vector(4, -2, 2)` | `Angle(180, 180, 0)` |
| KRM-262 | `Vector(0, -2, -1)` | `Angle(180, 90, 0)` |
| M8A7 | `Vector(0, -2, -0.5)` | `Angle(180, 180, 80)` |
| Drakon | `Vector(0, -2, 0)` | `Angle(175, 185, 0)` |
| MR6 | `Vector(4, -2, 2)` | `Angle(180, 180, 0)` |
| ICR-1 | `Vector(-0.2, -1, -0.5)` | `Angle(180, 180, 0)` |
| CUH base | (no override — inherited) | — |

### 13.4 Skin

All CLIENT blocks call `WorldModel:SetSkin(1)`. This is hardcoded — there is no `WorldModelSkin` SWEP field.

---

## 14. STAT / CONFIG FIELDS — comprehensive reference

### 14.1 All `SWEP.Primary` fields (M8A7 as reference; others vary)

| Field | M8A7 | KRM-262 | Drakon | MR6 | ICR-1 |
|---|---|---|---|---|---|
| `Sound` | `CW_BLACKOPS3_M8A7_FIRE` | `CW_BLACKOPS3_SPARTAN_FIRE` | `CW_BLACKOPS3_DRAKON_FIRE` | `CW_BLACKOPS3_MR6_FIRE` | `CW_BLACKOPS3_ISR27_FIRE` |
| `ShellSound` | — | `Weapon_BLACKOPS3_SPARTAN.Shell_In` | — | — | — |
| `ClipSize` | 32 | 8 | 20 | 20 | 30 |
| `Ammo` | `ar2` | `12 Gauge` | `ar2` | `.45 ACP` | `ar2` |
| `DefaultClip` | 120 | 120 | 120 | 120 | 120 |
| `MinDamage` | 20 | 15 | 30 | 30 | 21 |
| `MaxDamage` | 30 | 15 | 75 | 40 | 30 |
| `Automatic` | false | false | true | false | true |
| `TakeAmmo` | 1 | 1 | 1 | 1 | 1 |
| `Force` | 6 | 6 | 6 | 6 | 6 |
| `Spread` | 0.25 | 0.5 | 0.001 | 0.15 | 0.2 |
| `Delay` | 0.06 | 0.7 | 60/240 (0.25) | 50/600 (~0.083) | 60/600 (0.1) |
| `NumberofShots` | 1 | 8 | 1 | 1 | 1 |
| `MinRecoil` | -1.0 | -1.0 | -1.0 | -1.0 | -1.0 |
| `MaxRecoil` | -1.5 | -1.5 | -1.5 | -1.5 | -1.5 |
| `ReloadTime` | — | 0.4 | — | — | — |
| `PumpSound` | — | (not set — KRM uses AnimSounds instead) | — | — | — |

### 14.2 All `SWEP.Secondary` fields

None of the audited BO3 files define `SWEP.Secondary` — they all inherit it from the UH/CUH base. The UH base typically defines `Secondary.Automatic = false`, `Secondary.ClipSize = -1`, etc. (Standard GMod pattern for ADS-only right-click.)

### 14.3 All melee fields (identical across all BO3 weapons)

| Field | Value |
|---|---|
| `MeleeDamage` | `50` |
| `MeleeRange` | `64` |
| `MeleeDelay` | `0.6` |
| `MeleeForce` | `300` |
| `MeleeHitDelay` | `0.15` |
| `MeleeViewPunch` | `Angle(-5, 0, 0)` |
| `MeleeSound` | `"weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"` |
| `MeleeHitSound` | `{"...rifle_hit_00.wav", "...rifle_hit_00.wav"}` |
| `MeleeMissSound` | `"nil"` |
| `MeleeInterruptReload` | `true` |

### 14.4 Animation/sound fields

| Field | Used by | Notes |
|---|---|---|
| `Animations` (table) | all | Maps string keys to viewmodel sequence names (or `ACT_VM_*` strings) |
| `AnimSounds` (table) | all | Maps string keys to arrays of `{time=, sound=}` entries |
| `UseQCReloadEvents` | all | `false` everywhere — don't use QC event-driven reload sounds |
| `UseReloadTable` | all | `true` everywhere — use the `AnimSounds` table for reload sounds instead |
| `AnimatedSprint` | all | `false` everywhere — sprint is animation-driven by `HandleSprintingAnimations`, not the UH base's animated-sprint system |

### 14.5 Movement / ironsight fields

| Field | M8A7 | KRM-262 | Drakon | MR6 | ICR-1 |
|---|---|---|---|---|---|
| `LoweredPos` | `Vector(2.95, -3.057, -4.119)` | same | same | same | same |
| `LoweredAng` | `Vector(-13.131, 33.537, -29.906)` | same | same | same | same |
| `IronSightsPos` | `Vector(-10.2104, -2.98, 1.0979)` | `Vector(-8.62, 1.0289, 2.1)` | `Vector(-9.24, -14.8513, -0.09)` | `Vector(-8.9801, 11.1574, 4.4512)` | `Vector(-8.05, -0.7082, 0.8839)` |
| `IronSightsAng` | `Vector(0, 0, 0)` | same | same | same | same |
| `SwayPosition` | `2.0` | `2.0` | `2.0` | `2.0` | `2.0` |
| `AlternativePos` | `Vector(0, 0, 0)` | `Vector(0, 0, 0)` | `Vector(0, 0, 0)` | `Vector(0, 0, 0)` | `Vector(0, 0, 0)` |
| `AlternativeAng` | `Angle(0, 0, 0)` | `Angle(0, 0, 0)` | `Angle(0, 0, 0)` | `Angle(0, 0, 0)` | `Angle(0, 0, 0)` |
| `ZoomFov` | `20` | `20` | `20` | `20` | `20` |
| `MantleDuration` | `0.6` | — | — | — | — |
| `HoldType` | `ar2` | `shotgun` | `ar2` | `pistol` | `ar2` |
| `PassiveAnim` | `passive` | `passive` | `passive` | `passive` | `passive` |

### 14.6 Attachment-related fields

Only the CUH-side base gun references attachments:

```lua
SWEP.IsCUHWeapon = true  -- marker for CUH menu detection
```

And in `Deploy`:
```lua
timer.Simple(0, function()
    if IsValid(self) and self.ApplyAttachments then
        self:ApplyAttachments()
    end
end)
```

No other audited BO3 file references the attachment system — they rely on inheritance from `weapon_cuh_base_gun` (CUH version) or don't have attachments at all (upload version, which inherits from `weapon_custom_uh_base_gun`).

### 14.7 Other config fields

| Field | M8A7 | KRM-262 | Drakon | MR6 | ICR-1 | CUH base |
|---|---|---|---|---|---|---|
| `TwoHanded` | true | true | true | true | true | true |
| `ReloadSpeed` | 1 | 1 | 1 | 1 | 1 | 1 |
| `Chambering` | true | false | true | true | true | true |
| `NoShell` | — | true | — | — | — | — |
| `Use2DScope` | — | — | false | — | — | — |
| `Shotgun` | — | (inherited true) | — | — | — | — |
| `ShellLoadTime` | — | (inherited 0.6) | — | — | — | — |
| `PumpDelay` | — | 0.2 | — | — | — | — |
| `BurstCount` | 4 | — | — | — | — | — |
| `BurstDelay` | 0.05 | — | — | — | — | — |
| `MuzzleFlashType` | `"particle"` | `"particle"` | `"particle"` | `"particle"` | `"particle"` | `"particle"` |
| `MuzzleFlashParticle` | `muzzleflash_6` | `muzzleflash_m3` | `muzzleflash_SR25` | `muzzleflash_6` | `muzzleflash_6` | `muzzleflash_6` |
| `MuzzleFlashLightColor` | `Vector(0, 200, 255)` | same | same | same | same | same |
| `MuzzleFlashLightSize` | 128 | 128 | 128 | 128 | 128 | 128 |
| `IconLetter` | — | `"u"` | — | — | — | — |
| `Slot` | 2 | 3 | 3 | 1 | 2 | 3 |
| `SlotPos` | 3 | — | — | — | — | 3 |
| `Spawnable` | true | true | true | true | true | false |

---

## 15. CUSTOM FUNCTIONS — unique helpers and overrides not covered above

### 15.1 `GetViewModelPosition` — Safe-Mode lowering + AlternativePos + sprint Z (upload base gun lines 588–677)

This is a three-stage VM position modifier:

1. **Pass-through to BaseClass** (line 592–594): `pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)` — gets sway, inspect, ironsight transformations.

2. **Safe-Mode Lowering (procedural)** (lines 602–629): If `FireMode == 0` AND not running, lerp `_uhLower` toward 1 (else 0). When `_uhLower > 0.001`, apply `LoweredPos` (vector) and `LoweredAng` (vector or angle — handles both forms) by rotating around Right/Up/Forward axes and translating along them.

3. **AlternativePos/Ang (Ultra Guns style)** (lines 637–667): If NOT (Running OR Zooming OR FireMode==0), lerp `_altFactor` toward 1. When `_altFactor > 0.01`, apply `AlternativePos` and `AlternativeAng` similarly to LoweredPos.

4. **Sprint Z-axis offset (smoothed)** (lines 672–674): `targetZ = Running and 0 or 0` — **always 0**, so this is effectively a no-op. Vestigial code (likely intended to be `Running and -2 or 0` or similar). Lerps `_sprintZOffset` toward `targetZ`, adds `ang:Up() * _sprintZOffset` to `pos`.

The CUH-side base gun does NOT override `GetViewModelPosition` — it inherits the CUH base's version.

### 15.2 `DrawHUD` — red-dot reticle (Drakon lines 174–206)

```lua
function SWEP:DrawHUD()
    -- Draw base HUD (crosshair, ammo, etc.) first
    if not self:GetUHBool("Zooming") then
        self.BaseClass.DrawHUD(self)
        return
    end

    self.BaseClass.DrawHUD(self)

    local delay = 0.1
    local fadeTime = 0.1
    local dotSize = 128

    local aimTime = self._zoomStartTime or 0
    if CurTime() < (aimTime + delay) then return end

    local alpha = 255
    if CurTime() < (aimTime + delay + fadeTime) then
        alpha = math.Clamp((CurTime() - aimTime - delay) / fadeTime * 255, 0, 255)
    end

    surface.SetMaterial(RedDotMaterial)
    surface.SetDrawColor(255, 0, 0, alpha)
    surface.DrawTexturedRect(
        (ScrW() / 2) - (dotSize / 2),
        (ScrH() / 2) - (dotSize / 2),
        dotSize,
        dotSize
    )
end
```

**Flow:**
1. If not zooming: call base DrawHUD (crosshair visible) and return.
2. If zooming: call base DrawHUD anyway (for ammo), then draw the red-dot reticle on top.
3. Reticle has a 0.1s delay (`delay`) before appearing, then a 0.1s fade-in (`fadeTime`).
4. Reticle material: `RedDotMaterial` (lines 128–137):
   ```lua
   RedDotMaterial = CreateMaterial("UH_RedDotReticle", "UnlitGeneric", {
       ["$basetexture"] = "blackops3/reticles/reflex_4",
       ["$vertexcolor"] = 1,
       ["$vertexalpha"] = 1,
       ["$additive"] = 1,
   })
   ```
5. Reticle color: red with computed alpha (255 max).
6. Reticle size: 128×128, centered on screen.

The `_zoomStartTime` field is NOT set in this file — it's expected to be set by the UH base when zooming starts. If never set, defaults to `0`, which means `CurTime() < 0.1` is false (so the reticle appears immediately with full alpha).

### 15.3 `Initialize` — passthrough (upload base gun line 139, KRM-262 line 156, CUH base line 120)

```lua
function SWEP:Initialize()
    BaseClass.Initialize(self)
end
```

Trivial — exists only so subclasses can extend. Doesn't add any behavior.

### 15.4 `SecondaryAttack` guard (upload base gun lines 326–330)

```lua
function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end
```

Blocks ADS (right-click) during melee and mantle. Otherwise delegates to base.

### 15.5 `Reload` guard (upload base gun lines 338–342, CUH base lines 264–269)

Upload version:
```lua
function SWEP:Reload()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.Reload(self)
end
```

CUH version (adds `IN_USE` block):
```lua
function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end
```

The `IN_USE` block in the CUH version prevents E+R from triggering reload — preserving E+R for the inspect animation.

### 15.6 KRM-262 `Reload` override (KRM-262 lines 349–353) — shadow conflict

```lua
function SWEP:Reload()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.Reload(self)
end
```

**This is a problem.** The KRM-262 inherits from `weapon_bo3_base_shotty`, whose `Reload()` (lines 68–127) contains the entire shell-by-shell start-reload flow. By overriding `Reload()` to just delegate to `BaseClass.Reload`, the KRM-262 bypasses its own parent's reload logic. Whether this works depends on whether `BaseClass.Reload` (i.e. `weapon_bo3_base_shotty:Reload`) is reachable through the inheritance chain — which it should be, since `BaseClass` in the KRM-262 IS `weapon_bo3_base_shotty`. So calling `BaseClass.Reload(self)` should call the shotgun-base `Reload()` with `self` being the KRM-262. This works correctly via Lua's method-call semantics.

But the KRM-262's local `Reload` definition is still unnecessary — it adds nothing over inheriting. It's defensive copy-paste.

---

## 16. Field/state cross-reference — every `_`-prefixed internal field

| Field | Set in | Read in | Cleared in | Purpose |
|---|---|---|---|---|
| `_meleeActive` | `MeleeAttack` | `PrimaryAttack`, `SecondaryAttack`, `Reload`, `Think`, `StartMantle`, `Holster` | `EndMelee`, `Holster`, `Deploy` | Melee in-progress flag |
| `_meleeHitTime` | `MeleeAttack` | `Think` | `EndMelee`, `Holster`, `Deploy` | When to perform hit trace |
| `_meleeHitDone` | `MeleeAttack` (false), `Think` (true) | `Think` | `EndMelee`, `Holster`, `Deploy` | One-shot guard for hit trace |
| `_meleeEndTime` | `MeleeAttack` | `Think` | `EndMelee`, `Holster`, `Deploy` | When to end melee |
| `_nextMelee` | `MeleeAttack` | `PrimaryAttack` | `Holster`, `Deploy` | Melee cooldown gate |
| `_mantleActive` | `StartMantle` | `PrimaryAttack`, `SecondaryAttack`, `Reload`, `Think` | `EndMantle`, `Holster`, `Deploy` | Mantle in-progress flag |
| `_mantleEndTime` | `StartMantle` | `Think` | `EndMantle`, `Holster`, `Deploy` | Mantle timeout |
| `_lastBO3IsVaulting` | `Think` | (nowhere) | `Deploy` | Vestigial cache |
| `_lastBO3IsMantling` | `Think` | (nowhere) | `Deploy` | Vestigial cache |
| `_burstRemaining` | FireMode `shoot` callback, `FireBurstRound` (dec) | `Think`, `FireBurstRound` | `Holster`, `StartMantle` (M8A7), `FireBurstRound` (when 0) | Burst round counter |
| `_burstNextFire` | `FireBurstRound` | `Think` | `Holster`, `StartMantle` (M8A7) | When next burst round fires |
| `_burstDelay` | FireMode `shoot` callback | `FireBurstRound` | (not cleared — set fresh each burst) | Per-round delay cached |
| `_isRechambering` | (not set by BO3 files) | (not read by BO3 files) | `Holster` | Defensive clear — UH base field |
| `_holstering` | (external) | `Think` | `Think` | Deferred holster in progress |
| `_holsterFinish` | (external) | `Think` | `Think` | When to finish holster |
| `_holsterTarget` | (external) | `Think` | `Think` | Weapon to switch to after holster |
| `_engineWantsIdle` | `MeleeAttack` (nil), `EndMelee` (true), `StartMantle` (nil), `EndMantle` (true) | (UH base, not audited) | `MeleeAttack`, `StartMantle` (set to nil) | Signal UH base to play idle |
| `_customIdleActive` | `MeleeAttack` (false), `StartMantle` (false) | (UH base) | (not explicitly cleared) | Custom idle playing flag |
| `_nextIdlePlay` | `Deploy` (nil) | (UH base) | `Deploy` | Idle schedule timestamp |
| `_deployEndTime` | `Deploy` | (not in audited files — UH base) | — | Deploy animation finish time |
| `_uhLower` | `GetViewModelPosition` | `GetViewModelPosition` | — | Safe-mode lowering lerp factor |
| `_altFactor` | `GetViewModelPosition` | `GetViewModelPosition` | — | AlternativePos lerp factor |
| `_sprintZOffset` | `GetViewModelPosition` | `GetViewModelPosition` | — | Sprint Z offset lerp (always 0) |
| `_zoomStartTime` | (UH base) | `DrawHUD` (Drakon) | — | When ADS started |
| `wasRunning` | `HandleSprintingAnimations` | `HandleSprintingAnimations` | `Holster` | Sprint transition tracker |
| `wasZooming` | (not set by BO3 files) | (not read) | `Holster` | Defensive clear — UH base field |
| `_justExitedSprint` | `HandleSprintingAnimations` (true, CUH only) | (CUH base, not audited) | `Deploy` (CUH) | Just-exited-sprint flag |

---

## 17. Summary of working patterns (the "how to build a BO3 weapon" recipe)

Based on the audited references, here is the canonical pattern for a new BO3 weapon on the CUH base:

### 17.1 Minimal weapon (config-only) — like MR6

```lua
AddCSLuaFile()
DEFINE_BASECLASS("weapon_bo3_base_gun")
SWEP.Base = "weapon_bo3_base_gun"

SWEP.PrintName = "My Weapon"
SWEP.Category = "Black Ops III"
SWEP.Spawnable = true
SWEP.Slot = 1

SWEP.ViewModel = "models/.../v_myweapon.mdl"
SWEP.WorldModel = "models/.../w_myweapon.mdl"
SWEP.HoldType = "pistol"

SWEP.FireModes = { { name = "Semi-Auto" } }

SWEP.Primary.Sound = Sound("...")
SWEP.Primary.ClipSize = 12
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.DefaultClip = 96
SWEP.Primary.MinDamage = 20
SWEP.Primary.MaxDamage = 30
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.1
SWEP.Primary.Spread = 0.15
SWEP.Primary.NumberofShots = 1
SWEP.Primary.MinRecoil = -1.0
SWEP.Primary.MaxRecoil = -1.5

SWEP.IronSightsPos = Vector(...)
SWEP.Animations = {
    ["shoot"] = "base_fire",
    ["reload"] = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["iron_fire"] = "base_fire_ads",
    ["idle"] = "base_idle",
    ["deploy"] = "base_draw",
    ["melee"] = "base_melee",
    ["mantle"] = "base_mantle_over",
    ["sprint_idle"] = "base_sprint_loop",
    ["sprint_in"] = "base_sprint_in",
    ["sprint_out"] = "base_sprint_out",
}

SWEP.AnimSounds = {
    ["reload"] = { {time=0.3, sound="..."}, ... },
    ["reload_empty"] = { ... },
}

-- Melee fields (optional — defaults are inherited)
SWEP.MeleeDamage = 50
SWEP.MeleeRange = 64
-- ... (etc.)

if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetSkin(1)
    WorldModel:SetNoDraw(true)
    function SWEP:DrawWorldModel()
        -- bone-attached world model
    end
end
```

### 17.2 Burst weapon — like M8A7

Add to the FireModes:
```lua
SWEP.FireModes = {
    {
        name = "4 Round Burst",
        shoot = function(ply, wep)
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end
            wep._burstRemaining = wep.BurstCount or 3
            wep._burstDelay = wep.BurstDelay or 0.1
            wep:FireBurstRound()
            return true
        end
    },
    { name = "Semi-Auto" }
}
SWEP.BurstCount = 4
SWEP.BurstDelay = 0.05
```

Add `FireBurstRound` (copy from M8A7 lines 468–537) and the burst-continuation block in `Think` (M8A7 lines 316–320).

### 17.3 Pump shotgun — like KRM-262

Inherit from `weapon_bo3_base_shotty` (NOT `weapon_bo3_base_gun`), then:
- Set `SWEP.IsPump = true` (or override `PostShoot` like KRM-262)
- Set `SWEP.PumpDelay = 0.2`
- Add `["rechamber"]` and `["rechamber_ads"]` to Animations
- Add `["rechamber"]` and `["rechamber_ads"]` to AnimSounds with pump back/forward sounds
- Copy-paste the BO3 melee/mantle/parkour/deploy/holster/sprint code (because shotgun base doesn't inherit from `weapon_bo3_base_gun`)

### 17.4 Sniper with red dot — like Drakon

Inherit from `weapon_bo3_base_gun`, then:
- Override `DrawHUD` to draw the red-dot reticle when `Zooming`
- Create the reticle material with `CreateMaterial("UnlitGeneric", {...})`
- Use `ACT_VM_*` string animations if the model lacks proper sequence names

### 17.5 Equip/Holster fire-mode callbacks — like ICR-1, Drakon

```lua
SWEP.FireModes = {
    {
        name = "Full-Auto",
        equip = function(ply, wep) wep.Primary.Automatic = true end,
        holster = function(ply, wep) wep.Primary.Automatic = false end
    },
    {
        name = "Semi-Auto",
        equip = function(ply, wep) wep.Primary.Automatic = false end,
        holster = function(ply, wep) wep.Primary.Automatic = true end
    }
}
```

The UH base calls `equip` when entering the fire mode and `holster` when leaving it.

---

## 18. Anomalies and likely bugs

1. **KRM-262 `Reload` override is redundant** (lines 349–353): it just delegates to `BaseClass.Reload`. This works (because `BaseClass` is `weapon_bo3_base_shotty`, which has the shell-reload `Reload`), but the override adds nothing. The override was probably copy-pasted from `weapon_bo3_base_gun` without realizing the parent already provides the shell reload.

2. **KRM-262 copy-pastes the entire BO3 base gun** (lines 156–752): because it inherits from `weapon_bo3_base_shotty` (which inherits from `weapon_uh_base_shotty`, not `weapon_bo3_base_gun`), the BO3 melee/mantle/parkour code is not in its chain. The KRM-262 re-defines `PrimaryAttack`, `MeleeAttack`, `PlayMeleeSound`, `DoMeleeTrace`, `EndMelee`, `SecondaryAttack`, `Reload`, `StartMantle`, `EndMantle`, `Think`, `Holster`, `Deploy`, `HandleRunning`, `GetViewModelPosition`, `HandleSprintingAnimations`, and `DrawWorldModel` — all of which are identical to the upload base gun except for the world-model offsets and the `fireDelay > 0.3` threshold in `HandleRunning`. **The proper fix** would be to make `weapon_bo3_base_shotty` inherit from `weapon_bo3_base_gun` (multiple inheritance via mixin or re-parenting), or to factor the shared BO3 code into a separate mixin file.

3. **M8A7 inherits from `weapon_uh_base_gun` instead of `weapon_bo3_base_gun`** (line 4): same problem as KRM-262 — the M8A7 re-defines all the BO3 melee/mantle/parkour code inline. Should inherit from `weapon_bo3_base_gun`.

4. **Upload base gun lacks `sprint_in` / `sprint_out` in Animations** (line 90–100): `HandleSprintingAnimations` references both keys (lines 697, 703) but they're not in the table. `EasySendWeaponAnim` falls back to `ACT_VM_SPRINT_ENTER` / `ACT_VM_SPRINT_LEAVE`. This is likely intentional (rely on the ACT fallback) but is inconsistent with the per-weapon overrides that DO define these keys.

5. **`HandleRunning` dead `DeployTime` check** (upload base gun line 552): `if self:GetNWFloat("DeployTime", 10) then` always evaluates truthy — it's a no-op. CUH version removes it.

6. **`HandleRunning` vestigial `isSafeMode` if/else** (upload base gun lines 579–583): both branches set `Running = false`. CUH version simplifies.

7. **`GetViewModelPosition` sprint Z offset is always 0** (upload base gun line 672): `targetZ = Running and 0 or 0` — always 0. Vestigial / placeholder.

8. **`_lastBO3IsVaulting` / `_lastBO3IsMantling` are written but never read** (upload base gun lines 441–442, 452–453): they're cached but no code consumes them. CUH version drops them.

9. **`MeleeAttack` clears `_engineWantsIdle` and `_customIdleActive`** (upload base gun lines 211–212) but the CUH version (line 177) doesn't. The upload version's `_engineWantsIdle = nil` is defensive; the CUH version relies on `EndMelee` setting it to `true`. But the CUH `EndMelee` (line 250–256) doesn't set it either — this means the CUH version has NO idle-takeover signal after melee. This is either a bug or the CUH base detects the cleared `_meleeActive` flag directly.

10. **M8A7 `Holster` takes `wep` argument** (line 146) — the only BO3 file that does. Technically more correct (GMod's `Holster` is documented to receive the new weapon), but inconsistent with the others.

11. **`weapon_bo3_base_shotty` `PostShoot` uses `["pump"]` anim key** (line 195) but the KRM-262 doesn't define `["pump"]` in its `Animations` table. Since the KRM-262 overrides `PostShoot`, this isn't a problem — but if a subclass inherits from `weapon_bo3_base_shotty` without overriding `PostShoot` AND doesn't define `["pump"]`, the fallback `ACT_SHOTGUN_PUMP` will be used.

12. **Drakon uses `Weapon_BLACKOPS3_ARAK.*` sounds** (lines 117–124) — likely a copy-paste from an ARAK weapon. Should be `Weapon_BLACKOPS3_DRAKON.*`.

13. **Drakon has NO rechamber logic** despite the audit prompt calling it the "rechamber reference". The Drakon is full-auto/semi-auto toggle via `Primary.Automatic` — there is no bolt, no pump, no PostShoot. The animation table doesn't even have a `rechamber` key. The prompt's assumption is incorrect.

14. **`reloaddelay` field name** — the prompt calls this `_krm_nextShell`, but the actual field is `reloaddelay` (a UH-base field). The KRM-262 doesn't introduce a KRM-specific name; it uses the inherited field.

15. **KRM-262 `PostShoot` does NOT check `IsPump`** (line 139): unlike `weapon_bo3_base_shotty:PostShoot` (line 183) which has `if not self.IsPump then return end`. The KRM-262's override assumes it's always a pump — fine for the KRM-262, but if a subclass inherits without setting `IsPump`, the base `PostShoot` would no-op while the KRM's wouldn't (the KRM's always runs). This is consistent (the KRM is always a pump) but documents that `IsPump` is NOT consulted by the KRM's PostShoot.

16. **KRM-262 `PostShoot` does NOT check `uh_sv_realpump` ConVar** (line 139): the base shotty's version does (line 185). The KRM-262 always pumps, even on empty magazine. This may or may not be intentional.

17. **KRM-262 `PostShoot` does NOT play `Primary.PumpSound`** (line 139): the base shotty's version does (line 193). The KRM-262 instead relies on `AnimSounds["rechamber"]` / `AnimSounds["rechamber_ads"]` for the pump sound. This is cleaner (sound is animation-driven) but means `Primary.PumpSound` is unused for the KRM-262.

---

## 19. Next actions

1. **Fix the KRM-262 inheritance chain**: either re-parent `weapon_bo3_base_shotty` to inherit from `weapon_bo3_base_gun` (preferred — single inheritance), or factor the shared BO3 melee/mantle/parkour code into a mixin that both base files include. This eliminates ~580 lines of duplicated code in the KRM-262.

2. **Fix the M8A7 inheritance**: re-parent to `weapon_bo3_base_gun` (line 4: change `weapon_uh_base_gun` → `weapon_bo3_base_gun`). This eliminates ~600 lines of duplicated code.

3. **Decide on idle signaling convention**: pick ONE of (a) set `_engineWantsIdle = true` in `EndMelee`/`EndMantle` (upload style), or (b) clear melee/mantle flags and let the CUH base detect them (CUH style). Currently the upload version does (a) and the CUH version does (b) — pick one and apply consistently.

4. **Add `sprint_in` / `sprint_out` to the upload base gun's `Animations` table** (or document that they intentionally fall back to ACT enums).

5. **Remove vestigial code** in the upload base gun: `_lastBO3IsVaulting`/`_lastBO3IsMantling` cache, dead `DeployTime` check, vestigial `isSafeMode` if/else, the always-zero sprint Z offset.

6. **Fix the Drakon's sound names** (`ARAK` → `DRAKON`).

7. **Document the Drakon as the "string-anim reference"** rather than the "rechamber reference" — it has no rechamber logic. The KRM-262 is the actual rechamber/pump reference.

8. **Verify the `reloaddelay` field semantics**: the comment in `ReloadShotgun` says "shell insertion is via reloaddelay timer" but the code is actually animation-driven (`vm:GetCycle() >= 1`). Document the actual mechanism: shells are inserted when the `reload_loop` animation completes a cycle, NOT on a timer.

9. **Document the `EasySendWeaponAnim` contract**: it accepts (key, fallbackACT), looks up `self.Animations[key]`, falls back to fallbackACT, and internally calls `SetupAnimSounds(self.AnimSounds[key])`. This contract is inferred from usage — verify against the actual UH/CUH base implementation.

10. **Add the `IN_USE` block to `Reload` in the upload base gun** (CUH base has it, upload doesn't). Without it, E+R triggers reload instead of inspect.

---

End of audit. 8 files, 3,483 total lines, every line read.
