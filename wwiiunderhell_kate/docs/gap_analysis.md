# Porting Compatibility Gap Analysis — TFA WWII vs CUH Base

**Purpose:** This is the master document that guides the re-port of the TFA WWII weapon pack
onto the CUH (Customizable Underhell) base. It identifies every structural difference between
what the TFA WWII weapons require and what the CUH base natively provides.

**Source audits:**
- `docs/audit_pistols_smg.md` — 24 weapons (8 pistols, 16 SMGs)
- `docs/audit_rifles.md` — 20 weapons (17 rifles, 2 SMG-classified rifles, 2 shotguns)
- `docs/audit_snipers_shotguns.md` — 9 weapons (8 snipers + Winchester 94 lever)
- `docs/audit_lmg_launcher_melee.md` — 30 weapons (14 LMGs, 4 launchers, 3 specials, 9 melee)
- `docs/audit_cuh_base.md` — full audit of the 5-file CUH/UH base stack
- `docs/audit_bo3_references.md` — BO3 reference weapons (melee / KRM-262 / M8A7 / Drakon)
- `docs/audit_cuh_autorun.md` — CUH autorun + 78 attachment data files

**Base files verified by direct read:**
- `lua/weapons/weapon_cuh_base_gun.lua` (1249 lines)
- `lua/weapons/weapon_custom_uh_base_gun.lua` (1125 lines)
- `lua/weapons/weapon_custom_uh_base.lua` (1077 lines)

**TFA base class for every WWII weapon:** `SWEP.Base = "tfa_codww2_base"`
**CUH base class for customizable weapons:** `SWEP.Base = "weapon_cuh_base_gun"`
**CUH base class for non-customizable weapons:** `SWEP.Base = "weapon_custom_uh_base_gun"`

**Inheritance chain:**
```
weapon_base
└── weapon_custom_uh_base          (Sights/Movement/Deploy/CalcView/HandleBones/HandleHands)
    └── weapon_custom_uh_base_gun  (PrimaryAttack/Reload/AnimSounds/DoMuzzleFlash/ShootBullets)
        ├── weapon_cuh_base_gun    (Attachments/VElements/WElements/StatCache/Melee/CameraBone)
        ├── weapon_custom_uh_base_shotty  (ReloadShotgun/PostShoot pump/PostReload)
        └── weapon_custom_uh_base_melee   (PreSwing/PostHit/swing-based PrimaryAttack)
```

---

## SECTION 1: FIELD MAPPING (TFA → CUH)

The conversion formulas use `Delay = 60 / RPM` (seconds per shot) — the **only** real
transformation required for primary stats. Most other fields are direct rewrites or are
dropped entirely because the CUH base handles them internally.

Legend:
- ✅ **DIRECT** — same name, same type, can copy verbatim (modulo table nesting).
- 🔄 **TRANSFORM** — formula or lookup table required.
- ❌ **DROP** — no CUH equivalent; either unused by CUH or replaced by an internal mechanism.
- ➕ **ADD** — field that CUH requires but TFA doesn't declare; needs a default.

### 1.1 Primary Stats (Sound / Fire Rate / Damage)

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Primary.Sound` | `Primary.Sound` | ✅ DIRECT | CUH reads via `GetShootSound()`. TFA single-string → CUH single-string. TFA sometimes uses `Sound("path")` wrapper — strip the wrapper for CUH. |
| `Primary.SoundLyr1` … `Primary.SoundLyr6` | (none) | ❌ DROP | TFA plays up to 6 layered sounds simultaneously per shot. CUH `GetShootSound()` returns ONE sound. See §2.1 Sound Layering. |
| `Primary.SilencedSound` | `Primary.SilSound` | 🔄 RENAME | CUH reads `Primary.SilSound` in `GetShootSound()` (`weapon_custom_uh_base_gun.lua:281`). |
| `Primary.SoundEchoTable` | (none) | ❌ DROP | TFA plays indoor (key 0) + outdoor (key 256) tails based on `tr.MatType`. No CUH equivalent. See §2.1. |
| `Primary.Sound_DryFire` | (none) | ❌ DROP | TFA plays when out of ammo. CUH `CanPrimaryAttack` plays hardcoded `Weapon_SMG1.Empty` — see §2.5 for upgrade path. |
| `Primary.Sound_Blocked` | (none) | ❌ DROP | TFA plays when blocked by firemode/reload. CUH has no equivalent. |
| `Primary.RPM` | `Primary.Delay` | 🔄 `Delay = 60 / RPM` | Inverse. `SetNextPrimaryFire(CurTime() + Primary.Delay)`. For RPM=600 → Delay=0.1. |
| `Primary.RPM_Semi` | (none) | ❌ DROP | TFA alternative RPM for semi-auto firemode. CUH uses single `Primary.Delay`. Could be implemented via FireModes table if needed. |
| `Primary.RPM_Burst` | (none) | ❌ DROP | TFA alternative RPM for burst fire. CUH burst uses `BurstDelay` (seconds between burst rounds). See §4.4. |
| `Primary.RPM_Rapid` | (none) | ❌ DROP | TFA RPM used by `tfa_codww2_rapidfire` attachment. Could be implemented as attachment swapping `Primary.Delay` via `SetStat("Primary.Delay", 60 / RPM_Rapid)`. |
| `Primary.RPM_Displayed` / `RPM_Displayed_Rapid` | (none) | ❌ DROP | UI hint — not a real stat. |
| `Primary.Damage` | `Primary.MaxDamage` | 🔄 ASSIGN | TFA uses single Damage; CUH uses `math.random(MinDamage, MaxDamage)`. Set BOTH to the same value. |
| `Primary.Damage` | `Primary.MinDamage` | 🔄 ASSIGN | Same as above. |
| `Primary.Knockback` | (none) | ❌ DROP | TFA-specific. CUH uses `Primary.Force` for bullet force. |
| `Primary.NumShots` | `Primary.NumberofShots` | 🔄 RENAME | CUH `ShootBullets` reads `Primary.NumberofShots`. |
| `Primary.NumShots_Incen` | (none) | ❌ DROP | Dragon's Breath incendiary pellet count. Per-attachment handling — see §4.5 of audit_snipers_shotguns.md Model 1897. |
| `Primary.AmmoConsumption` | (none, use `Primary.TakeAmmo`) | 🔄 ASSIGN | CUH uses `TakePrimaryAmmo(Primary.TakeAmmo)` (default 1). Set `Primary.TakeAmmo = AmmoConsumption`. |
| `Primary.ClipSize` | `Primary.ClipSize` | ✅ DIRECT | Identical semantics. |
| `Primary.ClipSize_Ext` | (custom field) | ➕ KEEP | Used by `tfa_codww2_xmag`/`xmag_lmg` attachments: `Primary.ClipSize = function(wep,stat) return wep.Primary.ClipSize_Ext or stat end`. Leave as a custom field on the weapon; the attachment reads it. |
| `Primary.ClipSize_DW` | (custom field) | ➕ KEEP | Used by akimbo attachment: `Primary.ClipSize = function(wep,stat) return wep.Primary.ClipSize_DW or stat end`. |
| `Primary.DefaultClip` | `Primary.DefaultClip` | ✅ DIRECT | |
| `Primary.MaxAmmo` | (none — use reserve) | ➕ KEEP | Used by `NZMaxAmmo()` to set owner ammo. Leave as a custom field. |
| `Primary.Ammo` | `Primary.Ammo` | ✅ DIRECT | Standard GMod ammo type string. |
| `Primary.Automatic` | `Primary.Automatic` | ✅ DIRECT | Boolean — used by `CreateSmoke` delay selection (`Primary.Automatic and 0.14 or 0.32`) in `weapon_custom_uh_base_gun.lua:344`. |
| `Primary.MinDamage` / `MaxDamage` | `Primary.MinDamage` / `MaxDamage` | ✅ DIRECT | |
| `Primary.MinRecoil` / `MaxRecoil` | `Primary.MinRecoil` / `MaxRecoil` | ✅ DIRECT | CUH `PrimaryAttack` does `util.SharedRandom("uh_recoil", MinRecoil, MaxRecoil)` (`weapon_custom_uh_base_gun.lua:339`). |
| `Primary.KickUp` / `KickDown` / `KickHorizontal` | (none) | ❌ DROP | TFA multi-axis recoil. CUH uses MinRecoil/MaxRecoil as a single pitch value (`Angle(recoil, 0, 0)`). See §2.10 for ViewModelPunch-style upgrade path. |
| `Primary.Spread` | `Primary.Spread` | ✅ DIRECT | CUH multiplies by 0.18/0.26/0.34/0.5/0.62 based on crouch/zoom/air. |
| `Primary.IronAccuracy` | (custom field) | ➕ KEEP | TFA accuracy when ADS. CUH reduces `Spread` by 0.26× zoom factor (in `ShootBullets`); `IronAccuracy` is unused. For tighter ADS spread, set `Primary.Spread` lower to begin with, OR implement via attachment StatCache override. |
| `Primary.SpreadMultiplierMax` | (none) | ❌ DROP | TFA dynamic bloom cap. CUH has no bloom system. See §2.12 for upgrade path. |
| `Primary.SpreadIncrement` | (none) | ❌ DROP | TFA bloom growth per shot. |
| `Primary.SpreadRecovery` | (none) | ❌ DROP | TFA bloom decay. |
| `Primary.TakeAmmo` | `Primary.TakeAmmo` | ✅ DIRECT | Default 1. |
| `Primary.Force` | `Primary.Force` | ✅ DIRECT | Bullet force. |
| `Primary.Penetration` / `Primary.PenetrationDepth` | `SWEP.Penetration` / `SWEP.PenetrationDepth` | 🔄 MOVE | CUH reads `SWEP.Penetration` (default 2, recursion depth) and `SWEP.PenetrationDepth` (default 4, back-face trace distance) in `ShootBullets` callback (`weapon_custom_uh_base_gun.lua:336, 444`). Move from `Primary.*` to top-level SWEP. |
| `Primary.Range` | (none) | ❌ DROP | TFA bullet range. CUH bullets have unlimited range. `RangeFalloffLUT` provides distance-based damage falloff (see §2.2). |
| `Primary.RangeFalloffLUT` | (none) | ❌ DROP | TFA bezier-interpolated damage falloff. No CUH equivalent. See §2.2 for upgrade path. |
| `Primary.DryFireDelay` | (none) | ❌ DROP | TFA delays dry-fire sound. CUH uses fixed `SetNextPrimaryFire(CurTime() + 0.4)` in `CanPrimaryAttack`. |
| `DisableChambering` | `SWEP.Chambering` | 🔄 INVERT | TFA flag = true → NO chambering. CUH `SWEP.Chambering` = true → WITH chambering (+1 round). Conversion: `Chambering = not DisableChambering`. ALL WWII weapons set `DisableChambering = true` (so all port to `Chambering = false`). |
| `Primary.DisplayFalloff` | (none) | ❌ DROP | UI flag for falloff visualization. |

### 1.2 Secondary (Bash / Melee) Stats

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Secondary.BashDamage` | `SWEP.MeleeDamage` | 🔄 MOVE | CUH `MeleeAttack` reads `MeleeDamage` (default 50). Move out of `Secondary.*` to top-level. |
| `Secondary.BashSound` | `SWEP.MeleeSound` | 🔄 MOVE | Swing sound (CUH emits in `MeleeAttack` at line 1176). |
| `Secondary.BashHitSound` | `SWEP.MeleeHitSound` | 🔄 MOVE | Hit any-target sound (CUH `DoMeleeTrace` line 1206). |
| `Secondary.BashHitSound_Flesh` | (none) | ❌ DROP | TFA differentiates flesh-vs-world hit sound. CUH has single `MeleeHitSound`. See §4.5 for upgrade. |
| `Secondary.BashLength` | `SWEP.MeleeRange` | 🔄 MOVE | CUH `DoMeleeTrace` uses `MeleeRange or 64`. |
| `Secondary.BashDelay` | `SWEP.MeleeHitDelay` | 🔄 MOVE | CUH schedules trace at `ct + MeleeHitDelay` (default 0.15). |
| `Secondary.BashDamageType` | (hardcoded `DMG_CLUB`) | ❌ DROP | CUH `DoMeleeTrace` line 1199 uses `DMG_CLUB`. Could be parametrized if needed. |
| `Secondary.BashInterrupt` | `SWEP.MeleeInterruptReload` | 🔄 MOVE/INVERT | TFA = true (bash interrupts reload). CUH check is `MeleeInterruptReload ~= false` — so `true` → set `SWEP.MeleeInterruptReload = true` (or leave nil). |
| `Secondary.IronFOV` | (none) | ❌ DROP | TFA ADS FOV. CUH uses `SWEP.ZoomFov` (degrees to subtract). See §1.5. |
| `Secondary.Sound` (rifle grenade) | (FireMode.shoot) | 🔄 MOVE | TFA plays `Secondary.Sound` for grenade-launcher fire. CUH should implement this via `FireModes[N].shoot` callback returning truthy. See §4.4 / §4.10. |
| `Secondary.PickupSound` (rifle grenade) | (none) | ❌ DROP | |
| `Secondary.DefaultClip` / `Secondary.Ammo` | `Secondary.DefaultClip` / `Secondary.Ammo` | ✅ DIRECT | Standard GMod. CUH defaults: `Secondary.ClipSize = -1`, `Secondary.Ammo = "none"`, `Secondary.DefaultClip = -1`, `Secondary.Automatic = false`. |
| `Secondary.Automatic` | `Secondary.Automatic` | ✅ DIRECT | |
| `IronSightsInSound` / `IronSightsOutSound` | (hardcoded `weapons/underhell/ironsight_on.wav` / `ironsight_off.wav`) | ❌ DROP | CUH `Think()` zoom logic plays these hardcoded sounds. Could be parametrized. See §5.3. |

### 1.3 Fire Mode Stats

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Primary.BurstDelay` | (FireModes burst logic) | 🔄 MOVE | TFA = seconds between burst rounds. CUH burst fire uses `SWEP.BurstDelay` (custom field per-weapon, default 0.05) read in the `FireModes[N].shoot` callback. See §4.4 for full template. |
| `DisableBurstFire` | (no FireModes entry for burst) | ❌ DROP | If `DisableBurstFire = true`, simply don't add a burst FireMode entry. |
| `SelectiveFire` | (always enabled) | ❌ DROP | CUH `SecondaryAttack` always cycles FireMode on `IN_USE + M2`. The `FireModes` table itself controls which modes exist. |
| `OnlyBurstFire` | (only one FireMode) | 🔄 IMPLICIT | If `OnlyBurstFire = true`, define `SWEP.FireModes = { [1] = { name = "Burst", shoot = <burst fn> } }` (only one entry). |
| `BurstFireCount` | (custom field) | ➕ KEEP | Read by the burst `FireModes[N].shoot` callback. Default `SWEP.BurstCount = BurstFireCount or 4`. |
| `DefaultFireMode` | `SWEP.FireModes` ordering | 🔄 IMPLICIT | TFA `"1"` → CUH FireMode index 1 is the default (NWInt `"FireMode"` set to 1 in Initialize). For Safe mode, use index 0. |
| `FireModeName` | `SWEP.FireModes[N].name` | 🔄 MOVE | Each `FireModes` entry has a `.name` string (e.g. `"Full Auto"`, `"Semi-Auto"`, `"Burst"`). Drawn in HUD. |

### 1.4 Shotgun Stats

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Shotgun = true` | `SWEP.Shotgun = true` | ✅ DIRECT | CUH `CreateShell` picks shotgun shell sound (`weapons/underhell/shells/shotgun_shell1-3.wav`) if true. |
| `ShotgunEmptyAnim` | (hardcoded via `Clip1() <= 0` check) | ❌ DROP | CUH reload logic already checks `isEmpty` and picks `reload_empty` vs `reload` Animations key. Set `Animations["reload_empty"]` to the empty-reload sequence name. |
| `ShotgunEmptyAnim_Shell` | (no equivalent) | ❌ DROP | TFA selects per-shell animation variant when empty. CUH uses a single `reload_loop` Animations key. |
| `ShotgunStartAnimShell` | (always true in CUH) | ❌ DROP | CUH shell-by-shell reload always uses `start_reload` → `reload_loop` → `after_reload` sequence. |
| `SWEP.Primary.PumpSound` | `SWEP.Primary.PumpSound` | ✅ DIRECT | CUH shotgun `PostShoot` plays this after `PumpDelay`. |
| `SWEP.Primary.ShellSound` | `SWEP.Primary.ShellSound` | ✅ DIRECT | CUH shotgun `ReloadShotgun` plays this per shell insertion. |
| `SWEP.Primary.ReloadTime` | `SWEP.Primary.ReloadTime` | ✅ DIRECT | CUH shotgun uses this as the per-shell interval. |
| `SWEP.PumpDelay` | `SWEP.PumpDelay` | ✅ DIRECT | CUH shotgun `PostShoot`/`PostReload` default 0.5. |
| `SWEP.IsPump` | `SWEP.IsPump` | ✅ DIRECT | CUH shotgun `PostShoot` checks this. |
| `SWEP.IsBolt` | `SWEP.IsBolt` | ✅ DIRECT | CUH shotgun `Reload` flashlight/flare interrupt checks this. |
| `SWEP.TwoHanded` | `SWEP.TwoHanded` | ✅ DIRECT | Same as above. |

### 1.5 Ironsights / Sights

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `IronSightsPos` | `SWEP.IronSightsPos` | ✅ DIRECT | Vector. CUH `Sights()` uses for ADS position blend. |
| `IronSightsAng` | `SWEP.IronSightsAng` | ✅ DIRECT | Vector (treated as Angle in `RotateAroundAxis`). |
| `IronSightsMoveSpeed` | `SWEP.MoveSpeed` (during zoom) | ❌ DROP / REPLACE | TFA has a separate ADS move speed. CUH has no built-in ADS speed scaling; `MoveSpeed` is the universal multiplier. See §3.1 for CUH-side feature to enable. |
| `IronSightTime` | `SWEP.IronsightSpeed` (proxy) | 🔄 APPROX | TFA = seconds for full ADS transition. CUH `IronsightSpeed` (default 10) is a lerp rate — higher = faster. Conversion: `IronsightSpeed ≈ 1 / (IronSightTime * 5)` (rough — requires tuning). |
| `IronBobMult` / `IronBobMultWalk` | (none) | ❌ DROP | TFA reduces viewmodel bob when ADS. CUH already reduces bob by 0.125× when zooming (`_sightMult`). |
| `ZoomFov` (none — uses `Secondary.IronFOV`) | `SWEP.ZoomFov` | 🔄 MOVE | TFA ADS FOV is on `Secondary.IronFOV` (e.g. 70-80). CUH `ZoomFov` is degrees to SUBTRACT from base FOV (e.g. 15). Conversion: `ZoomFov = base_fov - Secondary.IronFOV` (where base_fov is ~90 default; for IronFOV=80 → ZoomFov=10). |
| `Secondary.ScopeZoom` | (custom field) | ➕ KEEP | TFA sniper scope magnification (e.g. 4, 7). Used by `ScopeFov` calculation in `RenderScene`. See §4.10. |
| `SafetyPos` / `SafetyAng` | (none) | ❌ DROP | TFA "safe mode" weapon position. CUH safe mode is FireMode 0 (no visual lowering — just locked firing). Could be implemented via `ACT_VM_IDLE_TO_LOWERED` like HandleRunning does. |
| `InspectPos` / `InspectAng` | `SWEP.Inspection` table | 🔄 MOVE/RESTRUCTURE | TFA: single Vector/Angle. CUH: `SWEP.Inspection = { {pos=V, ang=A}, {pos=V, ang=A} }` — array of stages. CUH `Inspect()` runs during deploy only (DeployTime > ct). See §4.6 for E+R inspect (uses Animations["inspect"] not Inspection table). |
| `InspectPos_DW` / `InspectAng_DW` | (none) | ❌ DROP | Akimbo-only inspect position. |
| `AlternativePos` / `AlternativeAng` | (none — comment in code) | ❌ DROP | Audit confirms `Sights()` does NOT check `AlternativePos/Ang` — comment says "not implemented in this codebase". |
| `RunSightsPos` / `RunSightsAng` | (none) | ❌ DROP | TFA lowered-weapon position. CUH uses `ACT_VM_IDLE_TO_LOWERED` / `ACT_VM_LOWERED_TO_IDLE` activities from HandleRunning. |
| `IronSightsPos_TAC` / `_NYDAR` / `_ACOG` / `_7X` / `_LENS` / `_GL` / `_DW` | (handled by attachments) | ❌ DROP / ATTACHMENT | TFA attachment swaps these by directly mutating `IronSightsPos`. CUH equivalent: attachment `WeaponTable.IronSightsPos = Vector(...)` which `SetStat("IronSightsPos", V)` calls. |
| `IronInSound` / `IronOutSound` | (hardcoded `ironsight_on.wav` / `ironsight_off.wav`) | ❌ DROP | See §1.2 note. Could be parametrized. |

### 1.6 Animations

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Animations` (table keyed by string) | `SWEP.Animations` (table keyed by string) | 🔄 RESTRUCTURE | TFA entries are `{ type = TFA.Enum.ANIMATION_SEQ, value = "seq_name" }` (or `ANIMATION_ACT`). CUH entries are simply strings (or tables of strings for random pick): `Animations = { ["shoot"] = "base_shoot", ["reload"] = { "base_reload_a", "base_reload_b" } }`. **Conversion: extract `.value` from each TFA entry.** Drop the `type` field entirely. |
| `SprintAnimation` | `SWEP.Animations["sprint_in"/"sprint_loop"/"sprint_out"]` | 🔄 RESTRUCTURE | TFA: `{ in={value, value_empty}, loop={value, value_empty, is_idle}, out={value, value_empty} }`. CUH: no dedicated `SprintAnimation` table; sprint anims live in `Animations`. Use keys `sprint_in`, `sprint_in_empty`, `sprint_loop`, `sprint_loop_empty`, `sprint_out`, `sprint_out_empty`. See §4.7. |
| `PumpAction` | (PostShoot override) | 🔄 REWRITE | TFA: `{ type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_PULLBACK_HIGH, value_is = ACT_VM_PULLBACK_LOW }`. CUH: there's NO `PumpAction` field — must override `SWEP:PostShoot()` with a `timer.Simple` that plays `EasySendWeaponAnim("rechamber", ACT_VM_PULLBACK_HIGH)`. See §4.1 (bolt) and §4.3 (pump). |
| `Sights_Mode` / `Sprint_Mode` / `Idle_Mode` | (none) | ❌ DROP | TFA locomotion mode enums (`TFA.Enum.LOCOMOTION_HYBRID`/`LOCOMOTION_ANI`/`IDLE_BOTH`). CUH uses pure animation-driven sprint + Idle activities. |
| `Idle_Blend` / `Idle_Smooth` | (none) | ❌ DROP | TFA idle blending weights. CUH has no idle-anim blending. |
| `SprintBobMult` | (none — hardcoded) | ❌ DROP | CUH `Movement()` hardcodes running amplitude multipliers (1.0 running / 0.6-0.8 not running). See §2.4. |

### 1.7 EventTable → AnimSounds

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `EventTable[ACT_VM_RELOAD] = { {time, "sound", value}, {time, "lua", fn}, ... }` | `SWEP.AnimSounds["reload"] = { {time=N, sound="path"}, {time=N, sound="path"}, ... }` | 🔄 RESTRUCTURE | See §4.9 for full mapping table. |

**ACT_VM_* → string key mapping table (from BO3 references):**

| TFA EventTable Key | CUH AnimSounds Key |
|---|---|
| `ACT_VM_DRAW` | `"draw"` |
| `ACT_VM_DRAW_EMPTY` | `"draw_empty"` |
| `ACT_VM_DRAW_DEPLOYED` | `"first_draw"` |
| `ACT_VM_DRAW_NOSHIELD` / `ACT_VM_DRAW_SILENCED` | `"draw_sil"` |
| `ACT_VM_HOLSTER` | `"holster"` |
| `ACT_VM_HOLSTER_EMPTY` | `"holster_empty"` |
| `ACT_VM_PRIMARYATTACK` | `"shoot"` |
| `ACT_VM_PRIMARYATTACK_SILENCED` | `"shoot_sil"` |
| `ACT_VM_PRIMARYATTACK_EMPTY` | `"shoot_empty"` |
| `ACT_VM_RELOAD` | `"reload"` |
| `ACT_VM_RELOAD_EMPTY` | `"reload_empty"` |
| `ACT_VM_RELOAD_SILENCED` | `"reload_sil"` |
| `ACT_SHOTGUN_RELOAD_START` | `"reload_start"` |
| `ACT_SHOTGUN_RELOAD_FINISH` | `"reload_finish"` (also aliased `"after_reload"` in CUH) |
| `ACT_VM_PULLBACK_HIGH` / `ACT_VM_PULLBACK_LOW` | `"rechamber"` |
| `ACT_SHOTGUN_PUMP` | `"pump"` |
| `ACT_VM_FIDGET` / `"inspect"` / `"inspect_empty"` | `"inspect"` / `"inspect_empty"` |
| `ACT_VM_FIDGET_SILENCED` / `"inspect_epic"` | `"inspect_epic"` |
| `ACT_VM_MELEE` | `"melee"` |
| `ACT_VM_IDLE` / `ACT_VM_IDLE_EMPTY` | (no AnimSounds entry — idle has no scheduled sounds in CUH) |
| `"fire_last"` | `"shoot_last"` |
| `"fire_knife"` / `"fire_knife_ads"` / `"fire_knife_last"` | `"shoot_knife"` / `"shoot_knife_ads"` / `"shoot_knife_last"` |
| `"reload_knife"` / `"reload_knife_empty"` | `"reload_knife"` / `"reload_knife_empty"` |
| `"reload_ext"` / `"reload_ext_empty"` | `"reload_ext"` / `"reload_ext_empty"` (per-attachment variant) |
| `"reload_dw"` / `"reload_empty_dw"` / `"reload_midempty_dw"` | (akimbo-specific — see akimbo attachment) |
| `"suppressor_attach"` / `"suppressor_remove"` | (custom keys — keep as-is) |
| `"rof_switch"` | `"rof_switch"` (keep — used by rapidfire_zk attachment on ZK-383) |
| `"inspect_knife"` / `"inspect_knife_empty"` / `"inspect_midempty"` | same string keys |

**"lua" type entries** in EventTable (e.g. `{time=10/30, type="lua", value=function(self) self:EventShell() end}`) — these are callbacks that fire at scheduled times. CUH `AnimSounds` supports `callback = function(wep) ... end` entries alongside `sound` entries. **Conversion:** rename `value` to `callback`, drop the `type` field. For `self:EventShell()` calls, replace with `function(wep) wep:CreateShell(wep.ShellDelay, 0) end`.

### 1.8 Sequence Overrides

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `SequenceLengthOverride` | (none) | ❌ DROP / REWRITE | TFA sets explicit animation durations. CUH reads `vm:SequenceDuration()` for reload duration, with optional `SWEP.ReloadTime` override (single value). For per-anim duration overrides, set `SWEP.ReloadTime` per-weapon (applies to all reload anims). |
| `SequenceRateOverride` | `SWEP.ReloadSpeed` (single value) | 🔄 APPROX | TFA per-anim playback rate. CUH `ReloadSpeed` (default 1) applies uniformly to the reload anim via `vm:SetPlaybackRate(speed)`. Set `ReloadSpeed = 1.0` for all WWII weapons (StatusLengthOverride values like 35/30 ≈ 1.17s — already the natural sequence duration in most cases). |
| `StatusLengthOverride` | `SWEP.ReloadTime` | 🔄 MOVE | TFA defines per-anim reload duration (e.g. `reload = 35/30 = 1.167s`). CUH reads `SWEP.ReloadTime` (a single number). **Conversion:** set `SWEP.ReloadTime = 35/30` if all reload variants share that duration, OR drop entirely and let `vm:SequenceDuration()` be authoritative. |

### 1.9 VElements / WElements / ViewModelBoneMods

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `VElements` (table) | `SWEP.ViewModelElements` | 🔄 RENAME/RESTRUCTURE | Schema is **almost identical**. Both use `type="Model"`, `model`, `bone`, `pos`, `angle` (CUH: `ang`), `size` (CUH: `scale`), `skin`, `bonemerge`, `bodygroup` (CUH: `bodygroups`), `active`, `surpresslightning` (typo preserved), `material`, `color`, `rel` (TFA-only). **Field renames within each entry:** `angle` → `ang`, `size` → `scale`, `bodygroup` → `bodygroups`. Drop `rel` (TFA bone-relative). TFA also supports `type="Sprite"` (same as CUH). |
| `WElements` | `SWEP.WorldModelElements` | 🔄 RENAME | Same renames as VElements. CUH `DrawWElements` uses owner's `ValveBiped.Bip01_R_Hand` bone (CUH doesn't read the WElement `bone` field for non-bonemerged elements — it always uses the right hand). |
| `ViewModelBoneMods` | (none) | ❌ DROP | TFA bone manipulation table. CUH `HandleBones` only does hardcoded `LeftBones` (left arm for grenade-throw). For custom bone mods, would need to extend `HandleBones`. |

### 1.10 Attachments

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `Attachments = { [1] = {atts = {...}, order = N, sel = N, default = "name" } }` | `Attachments = { [1] = { atts = {...}, default = N (or 0), forceDefault = bool } }` | 🔄 RESTRUCTURE | TFA uses `order` for sort order; CUH uses array index. TFA uses `sel` for current selection; CUH uses `sel` (same). TFA uses `default = "att_id"` (string); CUH uses `default = N` (numeric index into atts). **Conversion:** drop `order`; convert `default` from string to numeric index by finding the position of the default att ID in `atts`. See §4.8. |
| `AttachmentExclusions` | (none) | ❌ DROP | TFA attachment exclusion rules (e.g. akimbo excludes supp/knife/xmag). CUH has no equivalent — must be handled per-attachment in `ATTACHMENT.Attach(wep)` (check for conflicting attachment state and bail). |
| `AttachmentDependencies` | (none) | ❌ DROP | TFA cross-slot dependencies. Same workaround as exclusions. |
| `AttachmentTableOverride` | (none — handled per-attachment) | ❌ DROP / MOVE | TFA defines attachment-specific overrides at the weapon level. CUH attachments own their `WeaponTable` — overrides must live in the attachment file itself. See §4.8. |
| `AttachmentIconOverride` | (none) | ❌ DROP | TFA icon override. CUH attachments own their `Icon` field. |
| `ATTACHMENT.WeaponTable` | `ATTACHMENT.WeaponTable` | ✅ DIRECT | Same schema. Both support nested `Primary.*`/`Secondary.*`/top-level fields, `VElements`, `WElements`, `Bodygroups_V`/`Bodygroups_W`, `Animations`, `AnimSounds`. CUH additionally supports function-transform values: `function(wep, currentVal) return newVal, shouldSet end` (pcall-wrapped). |
| `ATTACHMENT.Attach(wep)` | `ATTACHMENT.Attach(wep)` | ✅ DIRECT | Both call when attached. CUH wraps in `pcall`. |
| `ATTACHMENT.Detach(wep)` | **NOT CALLED** by CUH | ❌ DROP | CUH `ApplyAttachments` only calls `Attach` (Stage 5). Stage 1 reset handles detachment via snapshot restore. **Bug** — see §5.3. Workaround: don't rely on Detach for cleanup; use snapshot mechanism. |

### 1.11 Miscellaneous

| TFA Field | CUH Field | Conversion | Notes |
|---|---|---|---|
| `AllowViewAttachment` | (always true) | ❌ DROP | TFA flag. CUH always allows attachments. |
| `LuaShellSound` | (hardcoded per Shotgun flag) | ❌ DROP | TFA custom shell-landing sound. CUH `CreateShell` plays `weapons/underhell/shells/shotgun_shell1-3.wav` if `Shotgun=true`, else `player/pl_shell1-3.wav`. See §3.3. |
| `LuaShellModel` | (none) | ❌ DROP | TFA custom shell model. CUH uses `uh_shell` effect (`util.Effect("uh_shell", fx)`). See §3.3. |
| `LuaShellScale` | (none) | ❌ DROP | |
| `LuaShellEffect` | (none) | ❌ DROP | |
| `LuaShellEject` | (always on unless `NoShell`) | 🔄 INVERT | TFA = true → enable shell. CUH `NoShell = false` → enable shell. Set `SWEP.NoShell = not LuaShellEject`. |
| `LuaShellEjectDelay` | `SWEP.ShellDelay` | 🔄 RENAME | CUH `CreateShell(delay, heat)` uses this. |
| `ShellHeat` | `SWEP.ShellHeat` | ✅ DIRECT | Default 0.8. |
| `ShellAttachment` | (none — uses `GetShellEject()` returning 2) | ❌ DROP | CUH `GetShellEject()` returns attachment 2 hardcoded. Could be parametrized. |
| `Shell` (CUH default `"models/weapons/shell_9mm.mdl"`) | (none used) | ❌ DROP | CUH doesn't use a model path; uses `uh_shell` effect. |
| `MuzzleAttachment` | (none — uses `GetMuzzle()` returning 1) | ❌ DROP | CUH `GetMuzzle()` returns 1 hardcoded. Could be parametrized. |
| `MuzzleAttachmentSilenced` | (none) | ❌ DROP | TFA attachment 2 for silenced muzzle. CUH `GetMuzzle()` always returns 1. See §3.4 for upgrade path. |
| `MuzzleFlashEnabled` | (always on unless silenced) | ❌ DROP | CUH `DoMuzzleFlash()` early-returns if `GetNWBool("Silenced")`. |
| `MuzzleFlashEffect` | `SWEP.MuzzleFlashParticle` | 🔄 RENAME | CUH `DoMuzzleFlash` checks `MuzzleFlashType == "particle"` and uses `MuzzleFlashParticle`. Set `SWEP.MuzzleFlashType = "particle"` and `SWEP.MuzzleFlashParticle = "tfa_muzzleflash_rifle"`. |
| `MuzzleFlashColor` | (none) | ❌ DROP | TFA muzzle color. CUH uses hardcoded `255, 218, 74` for dlight. |
| `SmokeParticle` | (none) | ❌ DROP | TFA smoke particle. CUH uses `uh_smoke` effect. |
| `EjectionSmokeEnabled` | (always on) | ❌ DROP | CUH always emits smoke via `CreateSmoke` if `SmokeWidth > 0`. |
| `TracerCount` | (none — CUH hardcodes `bullet.Tracer = 1`) | ❌ DROP | TFA emits a tracer every N shots. CUH emits one every shot. See §2.11 for upgrade path. |
| `TracerName` | (hardcoded `"uh_tracer"`) | ❌ DROP | CUH bullet callback uses `bullet.TracerName = "uh_tracer"`. |
| `ViewModelPunch*` (PitchMultiplier / MaxVertialOffset / VertialMultiplier / YawMultiplier + _IronSights variants) | (none) | ❌ DROP | TFA viewmodel punch system. CUH uses `Owner:ViewPunch(Angle(recoil, 0, 0))` (player camera only, no VM punch). See §2.9 for upgrade path. |
| `ViewModelFOV` | `SWEP.ViewModelFOV` | ✅ DIRECT | Default 65 in TFA, 64 in CUH base. |
| `ViewModel` / `WorldModel` | `SWEP.ViewModel` / `SWEP.WorldModel` | ✅ DIRECT | |
| `ViewModel_DW` / `WorldModel_DW` | (custom fields, used by akimbo attachment) | ➕ KEEP | Akimbo attachment reads these. |
| `ViewModelFlip` | `SWEP.ViewModelFlip` | ✅ DIRECT | Standard GMod. |
| `UseHands` | `SWEP.UseHands` | ✅ DIRECT | |
| `HoldType` | `SWEP.HoldType` | ✅ DIRECT | CUH also has `SWEP.PassiveAnim` (default `"passive"`) for sprint holdtype. |
| `MoveSpeed` | `SWEP.MoveSpeed` | ✅ DIRECT | Top-level multiplier. CUH does NOT automatically apply this — see §2.13 for upgrade. |
| `IronSightsMoveSpeed` | (none) | ❌ DROP | See §1.5. |
| `ChangeStateRecoilMultiplier` / `CrouchRecoilMultiplier` / `JumpRecoilMultiplier` / `WallRecoilMultiplier` | (none) | ❌ DROP | TFA context-sensitive recoil multipliers. CUH uses single `MinRecoil`/`MaxRecoil` with `* (Zooming and 0.35 or 1)`. See §2.10. |
| `ChangeStateAccuracyMultiplier` / `CrouchAccuracyMultiplier` / `JumpAccuracyMultiplier` / `WalkAccuracyMultiplier` | (hardcoded in `ShootBullets`) | ❌ DROP | CUH `ShootBullets` hardcodes 0.18/0.26/0.34/0.5/0.62 spread multipliers + movement-based +0.1. See §2.12. |
| `IronRecoilMultiplier` | (custom field) | ➕ KEEP / USE | TFA reduces recoil when ADS. CUH `PrimaryAttack` uses `Zooming and 0.35 or 1` hardcoded multiplier. **To use TFA's value:** override `PrimaryAttack` per-weapon, OR patch the base to read `SWEP.IronRecoilMultiplier or 0.35`. |
| `StaticRecoilFactor` | (none) | ❌ DROP | TFA recoil recovery factor. |
| `CameraAttachmentOffsets` | (none — CUH uses `SWEP.CameraAttachment` string) | ❌ DROP | TFA camera bone offset table. CUH uses `CameraAttachment` ($attachment name on VM), `CameraOffset` (Angle), `CameraReserve` (bool). |
| `CameraAttachmentScale` | `cl_cuh_camera_scale` ConVar | 🔄 MOVE | TFA per-weapon camera scale. CUH uses a global client ConVar (default 1.0). For per-weapon scale, would need to extend CalcView. |
| `VMPos` / `VMAng` | (none) | ❌ DROP | TFA viewmodel base offset. CUH `GetViewModelPosition` doesn't read VMPos. See §3.2 for upgrade path. |
| `VMPos_Additive` | (none) | ❌ DROP | |
| `Offset.Pos` / `Offset.Ang` / `Offset.Scale` | `SWEP.WorldModelOffset` / `SWEP.WorldModelAngle` | 🔄 RESTRUCTURE | TFA world-model procedural offsets. CUH `DrawWorldModel` reads `WorldModelOffset` (Vector, default `Vector(0, -2, -1)`) and `WorldModelAngle` (Angle, default `Angle(180, 90, 0)`). Conversion: `WorldModelOffset = Vector(Offset.Pos.Forward, Offset.Pos.Right, Offset.Pos.Up)`; `WorldModelAngle = Angle(Offset.Ang.Up, Offset.Ang.Right, Offset.Ang.Forward)`. Drop `Offset.Scale`. |
| `FiresUnderwater` | `SWEP.FiresUnderwater` | ✅ DIRECT | Note: TFA weapons set `true` on most weapons; CUH does NOT check this field — `CanPrimaryAttack` always returns true regardless of water. See §3.5. |
| `CanJam` / `JamChance` / `JamFactor` | (none) | ❌ DROP | TFA random jam system. No CUH equivalent. See §2.5. |
| `AmmoTypeStrings` | (none) | ❌ DROP | TFA display name override. CUH `DrawHUD` uses `language.GetPhrase(ammotype.."_ammo")` — for "pistol" → `"pistol_ammo"`. See §3.6. |
| `DInv2_GridSizeX` / `DInv2_GridSizeY` / `DInv2_Volume` / `DInv2_Mass` | (none) | ❌ DROP | TFA/Customizable Inventory v2 metadata. Not used by CUH. |
| `NZHeadShotMultiplier` | (none — relies on GMod default) | ❌ DROP | TFA headshot multiplier. GMod bullets already have a 2-3× headshot multiplier by default. |
| `NZPaPName` / `NZPaPReplacement` / `OnPaP` / `NZMaxAmmo` / `Ispackapunched` | (none) | ❌ DROP / REWRITE | NZ PaP system. See §2.12. The `OnPaP` function mutates `Primary_TFA.*` — this is TFA-specific stat cache. Must be rewritten as direct mutation of `self.Primary.*` (which CUH applies via stat cache). |
| `FlashlightAttachment` | (none — CUH doesn't use) | ❌ DROP | TFA attachment index for flashlight. CUH flashlight logic is on the player (`UH_Flashlight` NWBool), not the weapon. |
| `FireModeSound` | (hardcoded `"uh/flashlight.wav"`) | ❌ DROP | TFA firemode-switch click sound. CUH `SecondaryAttack` plays `uh/flashlight.wav` hardcoded. See §3.7. |
| `Primary.PickupSound` | (none) | ❌ DROP | TFA ammo pickup sound. |
| `IronBobMultWalk` / `IronBobMult` | (none) | ❌ DROP | See §1.5. |
| `LoopedReloadInsertAmount` | (none) | ❌ DROP | TFA shotgun multiple-shells-per-insert (used by Winchester PaP). CUH `ReloadShotgun` inserts 1 shell per cycle. |
| `FireSoundAffectedByClipSize` / `LowAmmoSoundThreshold` / `LowAmmoSound` / `LastAmmoSound` | (none) | ❌ DROP | TFA low-ammo sound variation. No CUH equivalent. See §2.3-2.4. |

---

## SECTION 2: FEATURE GAPS (TFA has, CUH doesn't)

These are features the TFA WWII weapons use that the CUH base does NOT natively support. For each, we document what the feature is, how TFA implements it, what CUH would need to add, and whether it can be worked around per-weapon.

### 2.1 Sound Layering (SoundLyr1-6 + SoundEchoTable)

**What:** TFA plays up to 6 layered fire sounds simultaneously (mid, low, sub, mechanic, etc.) plus an indoor/outdoor echo tail selected by `tr.MatType` (key 0 = indoor, key 256 = outdoor).

**TFA implementation:** TFA's `tfa_codww2_base` schedules each `SoundLyr*` to fire on `CHAN_WEAPON` / `CHAN_USER_BASE` / `CHAN_STATIC` in parallel via `EmitSound`. The `SoundEchoTable` plays the indoor sound always, and the outdoor sound only if the bullet's first trace hit `MAT_SKY` or similar outdoor surface. This produces the "booming" layered CoD WWII weapon sound profile.

**CUH status:** The CUH `GetShootSound()` returns a single sound path (or random pick from a table). The `PrimaryAttack` emits it on `CHAN_WEAPON` only. There is no layering, no echo table.

**Workaround:** Two options:
1. **Per-weapon override** of `PrimaryAttack` — emit additional sounds on different channels:
   ```lua
   function SWEP:PrimaryAttack()
       if not self:CanPrimaryAttack() then return end
       BaseClass.PrimaryAttack(self)
       if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
       if self.Primary.SoundLyr1 then self:EmitSound(self.Primary.SoundLyr1, 110, 100, 1, CHAN_USER_BASE) end
       if self.Primary.SoundLyr2 then self:EmitSound(self.Primary.SoundLyr2, 110, 100, 0.8, CHAN_ITEM) end
       -- ... up to Lyr6
   end
   ```
   **Pros:** No base changes. **Cons:** Duplicated in every weapon; doesn't handle echo tail.
2. **Base patch** — Add `SWEP:PlayFireSounds()` to CUH base, called after `BaseClass.PrimaryAttack`. Reads `Primary.SoundLyr1-6` + `SoundEchoTable` and emits them. **Recommend this path** — single point of change, applies to all weapons.

**Base change required:** Yes (option 2) — adds ~30 lines to `weapon_custom_uh_base_gun.lua`.

### 2.2 RangeFalloffLUT (damage falloff over distance)

**What:** TFA defines a per-weapon damage falloff table `{ {range=R1, damage=D1}, {range=R2, damage=D2}, ... }` with optional bezier interpolation between points and a `units` field (`"meters"` or `"hu"`).

**TFA implementation:** TFA's `ShootBullet` callback traces the bullet distance, looks up the LUT, interpolates damage between the two surrounding points, and modifies `dmginfo:SetDamage(damage * factor)`.

**CUH status:** CUH `ShootBullets` callback only does `util.ScreenShake` + `uh_hitworld` effect + recursive penetration. No distance-based damage falloff. Bullet damage is flat regardless of distance.

**Workaround:** Per-weapon override of `ShootBullets` is impractical (the bullet callback is what needs to read the LUT, and it's a closure inside `ShootBullets`). Best path is a **base patch**:

```lua
-- Add to ShootBullets bullet.Callback (after ScreenShake, before penetration):
if self.Primary.RangeFalloffLUT and self.Primary.RangeFalloffLUT.lut then
    local dist = bultrace.HitPos:Distance(bultrace.StartPos)
    -- Convert meters to Hammer units if needed (1 meter ≈ 39.37 HU ≈ 52.49 HU on the standard GMod scale)
    if self.Primary.RangeFalloffLUT.units == "meters" then
        dist = dist / 52.49
    end
    local factor = self:ComputeFalloffFactor(dist, self.Primary.RangeFalloffLUT.lut,
                                              self.Primary.RangeFalloffLUT.bezier)
    if factor and factor < 1 then
        dmginfo:ScaleDamage(factor)
    end
end
```

The `ComputeFalloffFactor` helper does linear (or bezier) interpolation between LUT points.

**Base change required:** Yes (~50 lines in `ShootBullets`).

### 2.3 LowAmmoSound (clip < 33% full)

**What:** TFA plays a different fire sound when the clip has fewer than `LowAmmoSoundThreshold * ClipSize` rounds remaining (e.g. `0.33 * 30 = 10 rounds`).

**TFA implementation:** TFA `ShootBullet` checks `self:Clip1() / self.Primary.ClipSize < self.LowAmmoSoundThreshold` and emits `LowAmmoSound` instead of `Primary.Sound`. Set `FireSoundAffectedByClipSize = true` to enable.

**CUH status:** `GetShootSound()` returns the same `Primary.Sound` regardless of clip count.

**Workaround:** Per-weapon override of `GetShootSound()`:
```lua
function SWEP:GetShootSound()
    local base = BaseClass.GetShootSound(self)
    if self.FireSoundAffectedByClipSize and self.LowAmmoSound then
        local ratio = self:Clip1() / math.max(self.Primary.ClipSize, 1)
        if ratio <= (self.LowAmmoSoundThreshold or 0.33) then
            return self.LowAmmoSound
        end
    end
    return base
end
```

**Base change required:** No (per-weapon) — but cleaner if added to base `GetShootSound()` so all weapons inherit.

### 2.4 LastAmmoSound (final shot sound)

**What:** TFA plays a distinct sound on the last shot of the clip (often a "click" + the depleted mag sound).

**TFA implementation:** TFA `EventTable["fire_last"]` triggers the sound at frame 1/30 when `self:Clip1() == 1` at fire time.

**CUH status:** No concept of "fire_last" sound. The `Animations["shoot_last"]` key (if defined) plays a different fire animation when clip==1, but no sound differentiation.

**Workaround:** Per-weapon override of `PrimaryAttack` or add to the AnimSounds timeline of `shoot_last`:
```lua
SWEP.AnimSounds["shoot_last"] = {
    { time = 0.0, sound = "TFA_CODWW2_1911.MechEmpty" },
}
```
Then set `Animations["shoot_last"] = "fire_last"` and modify `PrimaryAttack` to pick `shoot_last` key when `Clip1() <= 1`:
```lua
local lookupKey = (isZooming and "shoot_ads" or "shoot")
if self:Clip1() <= 1 and self.Animations["shoot_last"] then
    lookupKey = (isZooming and "shoot_ads_last" or "shoot_last")
end
```

**Base change required:** Yes (modify `PrimaryAttack` to pick `shoot_last` when clip==1).

### 2.5 Jamming System (CanJam, JamChance, JamFactor)

**What:** TFA randomly jams the weapon during sustained fire. The viewmodel plays a "jammed" animation, the player must press R (or another key) to clear the jam.

**TFA implementation:** TFA's `PrimaryAttack` rolls `math.Rand(0,1) < JamChance * JamFactor` per shot, where `JamFactor` increases with sustained fire count. On jam, sets `self:GetNWBool("Jammed", true)`, plays `ACT_VM_JAM` animation, and `TakePrimaryAmmo` is skipped. Pressing R clears the jam (plays `ACT_VM_UNJAM`).

**CUH status:** No jam concept.

**Workaround:** Per-weapon override of `PrimaryAttack` and `Reload`:
```lua
SWEP.CustomThink = function(self, ct)
    if self._jamActive and self.Owner:KeyPressed(IN_RELOAD) then
        self._jamActive = false
        self:EasySendWeaponAnim("unjam", ACT_VM_UNJAM)
        -- Lock inputs for unjam duration
        local vm = self.Owner:GetViewModel()
        local dur = IsValid(vm) and vm:SequenceDuration() or 1.0
        self:SetNextPrimaryFire(ct + dur)
        self.NextReload = ct + dur
    end
end

function SWEP:PrimaryAttack()
    if self._jamActive then return end
    if self.CanJam and not self:GetUHBool("Reloading") and self:Clip1() > 0 then
        local chance = (self.JamChance or 0) * (self._jamFactor or 1)
        if math.Rand(0, 1) < chance then
            self._jamActive = true
            self:EasySendWeaponAnim("jam", ACT_VM_JAM)
            self._jamFactor = 1
            return
        end
        self._jamFactor = math.min((self._jamFactor or 1) + (self.JamFactor or 0.05), 5)
    end
    BaseClass.PrimaryAttack(self)
end
```

**Base change required:** No (per-weapon). However, ~80% of WWII weapons use CanJam=true, so a base patch would be cleaner. **Decision: port per-weapon for now; revisit base patch if too much duplication.**

### 2.6 Chambering (DisableChambering flag)

**What:** When false (i.e. chambering enabled), reloading a non-empty mag gives +1 round (the round that was already in the chamber). When true (chambering disabled), reload only fills to exactly ClipSize.

**TFA implementation:** TFA reads `DisableChambering` flag in `TakeAmmo` logic. ALL WWII weapons set `DisableChambering = true` (no chambering).

**CUH status:** CUH supports this natively! `SWEP.Chambering = true` (the inverse flag) triggers the +1 logic in `_FinishReload` (`weapon_custom_uh_base_gun.lua:690`). The CUH base default is `SWEP.Chambering = true`.

**Workaround:** None needed. Set `SWEP.Chambering = false` for all WWII weapons (since they all have `DisableChambering = true`). Direct conversion: `Chambering = not DisableChambering`.

**Base change required:** No.

### 2.7 PumpAction (bolt/pump system)

**What:** Bolt-action snipers (Kar98k, Mosin, etc.) play a `ACT_VM_PULLBACK_HIGH` (hipfire) or `ACT_VM_PULLBACK_LOW` (ADS) animation after every shot, with a shell ejection at time 10/30. Combat shotgun plays `ACT_SHOTGUN_PUMP` after every shot.

**TFA implementation:** `SWEP.PumpAction = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_PULLBACK_HIGH, value_is = ACT_VM_PULLBACK_LOW }` — TFA's base picks the right activity based on `Zooming` bool. Pump anim is played in TFA's PostShoot equivalent.

**CUH status:** CUH gun base `PostShoot()` is a no-op stub. The shotgun base's `PostShoot()` handles pump only if `SWEP.IsPump = true` and uses `ACT_SHOTGUN_PUMP` (not `PULLBACK_HIGH/LOW`). Bolt-action snipers have NO rechamber mechanism.

**Workaround:** Per-weapon override of `PostShoot` with `timer.Simple`:
```lua
function SWEP:PostShoot()
    if not self.PumpAction then return end
    local isZooming = self:GetUHBool("Zooming")
    local act = isZooming and ACT_VM_PULLBACK_LOW or ACT_VM_PULLBACK_HIGH
    local pumpDelay = self.PumpDelay or 0.1
    timer.Simple(pumpDelay, function()
        if not IsValid(self) then return end
        if not IsValid(self.Owner) or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        if SERVER or IsFirstTimePredicted() then
            self:EasySendWeaponAnim(isZooming and "rechamber_ads" or "rechamber", act)
            -- Shell eject handled via AnimSounds timeline for "rechamber"
        end
    end)
    self:SetNextPrimaryFire(CurTime() + (self.SequenceLengthOverride or {})[act] or 0.6)
end
```

For combat shotgun (Model 1897), use `ACT_SHOTGUN_PUMP` directly via the CUH shotgun base `PostShoot` mechanism (already implemented).

**Base change required:** No (per-weapon PostShoot override works). See §4.1 and §4.3 for full templates.

### 2.8 ShotgunEmptyAnim / ShotgunStartAnimShell

**What:** TFA differentiates between shell-by-shell reload when clip is empty (plays `reload_start_empty` + `reload_loop_empty`) vs. when clip has rounds. Also supports per-shell start animation variants.

**TFA implementation:** TFA's shotgun reload picks anim variants based on `ShotgunEmptyAnim` flag and current clip state.

**CUH status:** CUH `weapon_custom_uh_base_shotty.lua` `Reload()` calls `EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)` unconditionally. `ReloadShotgun` plays `after_reload` + `reload_loop` per shell. There is no separate empty-vs-non-empty reload anim path.

**Workaround:** Per-weapon override of `Reload` (on top of shotgun base):
```lua
function SWEP:Reload()
    local isEmpty = self:Clip1() <= 0
    -- Override the start_reload key based on emptiness
    self._shotgunEmptyReload = isEmpty
    BaseClass.Reload(self)
end

-- And override EasySendWeaponAnim or add a custom start_reload resolution
```

OR define `Animations["start_reload_empty"]` and modify the CUH shotgun base to check `Clip1() <= 0` before picking the anim key.

**Decision:** Most TFA WWII shotguns set `ShotgunEmptyAnim = false` (Blunderbuss, MAS 36, Winchester) — for those, no override needed. For Model 1897 (`ShotgunEmptyAnim = true`), need a per-weapon override. See §4.2.

**Base change required:** Optional base patch for empty-reload-anim detection (~10 lines in `weapon_custom_uh_base_shotty.lua:Reload`).

### 2.9 ViewModelPunch (viewmodel recoil animation)

**What:** TFA's viewmodel "kicks" up after each shot, decaying over ~0.5s. The kick amount is configurable per-weapon: `ViewModelPunchPitchMultiplier`, `ViewModelPunch_MaxVertialOffset`, `ViewModelPunchYawMultiplier`, and `_IronSights` variants (reduced when ADS).

**TFA implementation:** TFA reads these fields in `PrimaryAttack` and applies a procedural viewmodel position offset (via bone manipulation or `GetViewModelPosition`). The kick decays exponentially.

**CUH status:** CUH only does `Owner:ViewPunch(Angle(recoil, 0, 0))` (player camera punch) — no viewmodel-specific kick. The viewmodel stays at its idle position during fire.

**Workaround:** Per-weapon override of `GetViewModelPosition` that tracks a `_vmPunch` value:
```lua
SWEP._vmPunch = 0
SWEP._vmPunchYaw = 0

function SWEP:GetViewModelPosition(pos, ang)
    pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    local ct = CurTime()
    local ft = FrameTime()
    -- Decay punch
    self._vmPunch = Lerp(ft * 8, self._vmPunch, 0)
    self._vmPunchYaw = Lerp(ft * 8, self._vmPunchYaw, 0)
    local isZoom = self:GetUHBool("Zooming")
    local pitchMult = isZoom and (self.ViewModelPunchPitchMultiplier_IronSights or 0.09) or (self.ViewModelPunchPitchMultiplier or 0.5)
    local maxVert = isZoom and (self.ViewModelPunch_MaxVertialOffset_IronSights or 1.95) or (self.ViewModelPunch_MaxVertialOffset or 3)
    local vertical = math.Clamp(self._vmPunch * pitchMult, -maxVert, maxVert)
    local yaw = math.Clamp(self._vmPunchYaw * (isZoom and (self.ViewModelPunchYawMultiplier_IronSights or 0.25) or (self.ViewModelPunchYawMultiplier or 0.6)), -2, 2)
    pos = pos + ang:Up() * vertical
    pos = pos + ang:Right() * yaw
    return pos, ang
end

function SWEP:PostShoot()
    -- Apply punch
    self._vmPunch = math.Rand(0.5, 1.5)
    self._vmPunchYaw = math.Rand(-0.5, 0.5)
end
```

**Base change required:** No (per-weapon). For uniformity across all WWII weapons, a base patch in `weapon_custom_uh_base_gun.lua` would be ~40 lines and would auto-read the TFA field names.

### 2.10 Recoil Multipliers (ChangeState / Crouch / Jump / Wall)

**What:** TFA applies context-sensitive recoil multipliers — e.g. `JumpRecoilMultiplier = 1.65` makes recoil 65% stronger while airborne. `IronRecoilMultiplier = 0.7` reduces recoil by 30% when ADS.

**TFA implementation:** TFA's `ShootBullet` checks player state (crouching, in air, ADS, just-changed-state) and multiplies the base recoil.

**CUH status:** CUH `PrimaryAttack` only applies a single hardcoded `* (Zooming and 0.35 or 1)` multiplier. No state-aware recoil.

**Workaround:** Per-weapon override of `PrimaryAttack` (after `BaseClass.PrimaryAttack(self)`):
```lua
-- Apply state-based recoil multiplier to view angles
local ct = CurTime()
local mult = 1
if not self.Owner:OnGround() then mult = mult * (self.JumpRecoilMultiplier or 1.0)
elseif self.Owner:Crouching() then mult = mult * (self.CrouchRecoilMultiplier or 1.0) end
if self:GetUHBool("Zooming") then mult = mult * (self.IronRecoilMultiplier or 0.35) end
-- ... etc
```

**Base change required:** Optional (~20 lines in PrimaryAttack to read these fields if defined).

### 2.11 TracerCount (tracer every N shots)

**What:** TFA emits a tracer every Nth shot (e.g. `TracerCount = 3` → tracer on shots 1, 4, 7, ...). Other shots have no tracer (less visual clutter).

**TFA implementation:** TFA `ShootBullet` increments a per-weapon counter and sets `bullet.Tracer = (counter % TracerCount == 0) and 1 or 0`.

**CUH status:** CUH `ShootBullets` hardcodes `bullet.Tracer = 1` (always on).

**Workaround:** Per-weapon counter:
```lua
SWEP._tracerCounter = 0
function SWEP:ShootBullets(pos, buldir, dmg, tries)
    self._tracerCounter = (self._tracerCounter or 0) + 1
    -- Cannot easily intercept bullet.Tracer without overriding ShootBullets entirely.
    -- Better: override ShootBullets via a wrapper.
    BaseClass.ShootBullets(self, pos, buldir, dmg, tries)
end
```

This doesn't actually work because `BaseClass.ShootBullets` builds the bullet table internally and hardcodes `Tracer = 1`. The cleanest path is a base patch to read `SWEP.TracerCount`:
```lua
bullet.Tracer = (self.TracerCount and (self._tracerCounter or 0) % self.TracerCount == 0) and 1 or 0
```

**Base change required:** Yes (~5 lines in `ShootBullets`).

### 2.12 NZ PaP System (OnPaP, NZMaxAmmo, NZPaPName, NZPaPReplacement)

**What:** The Mystery Box / Pack-a-Punch system: spending points upgrades a weapon. TFA PaP multiplies damage ~3x, increases clip size, doubles NumShots, sets `Ispackapunched = true`, sets `MuzzleFlashEffect = "muz_pap"`, sometimes swaps to a different weapon class (`NZPaPReplacement`).

**TFA implementation:**
- `SWEP:OnPaP()` — runs on PaP activation. Mutates `Primary_TFA.*` fields (TFA's stat cache), then calls `self:ClearStatCache()` to flush.
- `SWEP:NZMaxAmmo()` — refills owner ammo to `Primary.MaxAmmo` and clip1 to `Primary.ClipSize`.
- `SWEP.NZPaPName` — display name of the upgraded weapon.
- `SWEP.NZPaPReplacement` — class name of a replacement weapon (e.g. `"tfa_vg_mustangsally"` for the 1911 PaP).

**CUH status:** No NZ integration. The CUH stat cache (`_statCache`) is a different system from TFA's `Primary_TFA`. Calling `self:ClearStatCache()` would fail.

**Workaround:** Per-weapon `OnPaP` rewrite. Instead of mutating `Primary_TFA`, mutate `self.Primary.*` directly AND call `self:ApplyAttachments()` to refresh the stat cache:
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.MuzzleFlashParticle = "muz_pap"
    self.Primary.ClipSize = 16
    self.Primary.Damage = 835
    self.Primary.NumShots = 2
    self.Primary.Delay = 60 / 680  -- RPM 680
    self.Primary.DefaultClip = 176
    self.Primary.MaxAmmo = 160
    self.Primary.Automatic = true
    -- Refresh stat cache so attachments re-apply on top
    if self.ApplyAttachments then self:ApplyAttachments() end
    return true
end

function SWEP:NZMaxAmmo()
    if SERVER then
        self.Owner:SetAmmo(self.Primary.MaxAmmo or 80, self.Primary.Ammo)
        self:SetClip1(self.Primary.ClipSize or 8)
    end
end
```

**NZ PaP replacement** (Mustang Sally etc.) is a separate weapon class — needs its own port (e.g. `uh_codww2_1911_upgraded.lua` as a new SWEP file, inheriting from `uh_codww2_1911`).

**Base change required:** No (per-weapon). The base CUH layer doesn't need to know about NZ.

### 2.13 DInv2 Inventory (grid dimensions)

**What:** TFA weapons declare inventory dimensions (`DInv2_GridSizeX/Y`, `DInv2_Volume`, `DInv2_Mass`) for the "Dark Inventory 2" system.

**TFA implementation:** Stored as SWEP fields, read by the DInv2 addon when constructing inventory slots.

**CUH status:** CUH base does not declare or use these fields. Weapons can still declare them and DInv2 (if installed) will read them.

**Workaround:** Just keep the fields on the ported weapon — they're harmless metadata.

**Base change required:** No.

### 2.14 FireSoundAffectedByClipSize (low ammo sound)

(See §2.3 — same system.)

### 2.15 SequenceLengthOverride / SequenceRateOverride

**What:** TFA defines per-anim playback rate (e.g. `draw = 45/30` means the draw anim plays at 45/30 = 1.5× speed, finishing in 30 frames worth of time but played in 20 frames). `StatusLengthOverride` defines the per-anim effective duration (e.g. `reload = 35/30` means reload takes 35/30 = 1.167 seconds regardless of the natural anim duration).

**TFA implementation:** TFA's animation system reads these tables and applies `vm:SetPlaybackRate(SequenceRateOverride[anim])` and `vm:SetSequenceDuration(SequenceLengthOverride[anim])` per animation play.

**CUH status:** CUH `EasySendWeaponAnim` reads `vm:SequenceDuration()` for natural duration, with optional `SWEP.ReloadSpeed` global multiplier. No per-anim override tables.

**Workaround:** Most WWII weapons set values like `35/30` (≈1.17s) which roughly matches the natural anim duration — so dropping these tables entirely should produce correct behavior. For weapons where the override significantly differs from natural duration (e.g. Winchester's `draw = 30/30`), set `SWEP.ReloadTime` if it applies to reload, OR override `EasySendWeaponAnim` per-weapon.

For SequenceRateOverride on `sprint_in`/`sprint_loop` (25/30 = 0.83× speed), override the sprint anim handling:
```lua
function SWEP:HandleSprintingAnimations()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        vm:SetPlaybackRate(self._sprintRate or 25/30)
    end
    BaseClass.HandleSprintingAnimations(self)
end
```

**Base change required:** No, but the natural durations must match — verify per weapon.

---

## SECTION 3: FEATURE GAPS (CUH has, TFA doesn't)

These are CUH features that TFA WWII weapons don't use, but could benefit from enabling during the port.

### 3.1 Staged Ironsight Blend (Phase 1 lateral, Phase 2 forward)

**What:** CUH `Sights()` uses a two-phase blend — the gun snaps to the correct screen position (X/Z) at 1.8× speed, then eases forward (Y/depth) at 0.6× speed. This produces a "present then push" motion that feels more natural than a single linear lerp.

**How CUH implements it:** See `weapon_custom_uh_base.lua:274-342`. Tunables: `IronsightSpeed` (10), `IronsightEaseIn` (1.5), `IronsightLateralSpeed` (1.8), `IronsightForwardSpeed` (0.6). Plus a sine-bump "dip" via `IronSightsDipPos/Ang/Scale` (curve through a low-point at midpoint).

**Should we enable:** Yes — every WWII weapon gets this automatically by inheriting from CUH. Set `SWEP.IronSightsDipScale = 0` if you want pure linear TFA-style blending (no sine bump).

### 3.2 Camera Bone System (BO3-style)

**What:** CUH `CalcView` reads a `$attachment` named `"Camera"` on the viewmodel and applies its angle to the player's view, scaled by `cl_cuh_camera_scale` (default 1.0). This makes the camera follow procedural weapon animation (recoil, inspect, reload) for a more cinematic feel.

**How CUH implements it:** See `weapon_cuh_base_gun.lua:111-143`. Skips during Fire/Idle sequences. Excludes `Fire`/`Idle` because the fire/idle anims already have view kick baked in.

**Should we enable:** Yes — but only if the viewmodels have a `"Camera"` $attachment. Most TFA WWII viewmodels have one. Set `SWEP.CameraAttachment = "Camera"` and `SWEP.CameraOffset = Angle(0,0,0)`.

### 3.3 Shell + Smoke Effects (via `util.Effect`)

**What:** CUH uses `uh_shell` and `uh_smoke` effects (data-driven) rather than direct particle spawning. This allows the same effect to be reused across weapons with different parameters (shell heat, smoke width).

**How CUH implements it:** `CreateShell(delay, heat)` and `CreateSmoke(att, delay)` in `weapon_custom_uh_base_gun.lua:608-667`. Customizable via `SWEP.ShellHeat`, `SWEP.SmokeWidth`, `SWEP.ShellDelay`, `SWEP.NoShell`.

**Should we enable:** Yes — these are automatic. The shell sound is auto-picked based on `SWEP.Shotgun` flag.

### 3.4 Stat Cache System (attachment-driven stat overrides)

**What:** CUH `InitStatCache` snapshots all `Primary.*`, `Secondary.*`, top-level stats (DamageGeneric, Num, FireRate, Spread, ZoomFov, IronSightTime, MoveSpeed, etc.), IronSightsPos/Ang, Animations, and AnimSounds. Attachments can modify these via `SetStat(path, value)` and the changes are cleanly restored when the attachment is removed.

**How CUH implements it:** 6-stage `ApplyAttachments` pipeline. Stage 1 restores all stats from origin snapshot. Stage 5 applies each equipped attachment's `WeaponTable` entries (with function-transform support).

**Should we enable:** Yes — auto-enabled. Attachments that override stats work transparently. Note: the `GetStat` stub shadow bug (see §5.1) currently breaks function-transforms — must be fixed first.

### 3.5 VElements / WElements (ClientsideModel attachment rendering)

**What:** CUH `InitVElements`/`DrawVElements` create `ClientsideModel`s for each VElement entry and render them at the specified bone every frame. WElements do the same for the world model. Attachments can swap models by mutating `elem.model`.

**How CUH implements it:** See `weapon_cuh_base_gun.lua:281-585`. Idempotent init via `_vElementsInit` flag. `_defaultSnapshot` captures original state for restore-on-detach. `ApplyBodygroupsVM` / `ApplyBodygroupsWM` apply per-frame bodygroup overrides.

**Should we enable:** Yes — auto-enabled for all CUH-derived weapons.

### 3.6 CUH Attachment Menu (Press C key)

**What:** CUH provides a VGUI menu (bound to `c` key by default, configurable via `cuh_menu_key` ConVar) that shows all attachment slots for the active weapon. Players click to select attachments, which net-sync to the server and save to per-SteamID JSON.

**How CUH implements it:** See `lua/autorun/cl_cuh_ui.lua` and `lua/autorun/sh_cuh_attachments.lua`. Auto-loads on weapon switch via `PlayerSwitchWeapon` hook.

**Should we enable:** Yes — every WWII weapon with `SWEP.Attachments = {...}` automatically gets the menu.

### 3.7 AnimSounds Timeline System

**What:** CUH `AnimSounds` table schedules sound callbacks along an animation timeline. Each entry has `time` (seconds), `sound` (path or table for random), `level`, `pitch`, and optional `callback`. The timeline advances per Think frame, scaled by `vm:GetPlaybackRate()` so it stays in sync with reload-speed-modified anims.

**How CUH implements it:** `SetupAnimSounds(animKey, variantName)` snapshots the timeline. `ProcessAnimSounds()` advances it each Think.

**Should we enable:** Yes — this is the conversion target for TFA `EventTable`. See §4.9 for the mapping.

### 3.8 Save/Load Attachments Per SteamID

**What:** CUH saves the player's attachment selections to `data/cuh_saves/<steamid64>.json` keyed by weapon class. On spawn/weapon-switch, the saved selection auto-loads.

**How CUH implements it:** `CustomUH.SaveAttachments(wep, ply)` / `LoadAttachments(wep, ply)` in `sh_cuh_attachments.lua:122-234`. Triggers on `PlayerDeath` and `PlayerDisconnected` (auto-save).

**Should we enable:** Yes — automatic.

### 3.9 Melee System (E+M1 gun-butt)

**What:** CUH `MeleeAttack` plays a melee animation, schedules a hull-trace hit at `MeleeHitDelay`, applies damage on hit, plays hit/miss sound, and view-punch. Cancels reload and zoom on activation.

**How CUH implements it:** See `weapon_cuh_base_gun.lua:1138-1214`. State machine in `Think()` (lines 1231-1249) handles hit-trace timing and end-of-anim cleanup.

**Should we enable:** Yes — replaces TFA `Secondary.Bash*` fields. Set `SWEP.MeleeDamage`, `SWEP.MeleeSound`, `SWEP.MeleeHitSound`, `SWEP.MeleeMissSound`, `SWEP.MeleeRange`, `SWEP.MeleeHitDelay`, `SWEP.MeleeDelay`, `SWEP.MeleeForce`, `SWEP.MeleeViewPunch`. Override `PrimaryAttack` to dispatch on `IN_USE` — see §4.5.

### 3.10 Inspect (E+R) — Custom Animation

**What:** CUH `EasySendWeaponAnim("inspect", ACT_VM_FIDGET)` plays the weapon's inspect animation. Can be triggered via `IN_USE + IN_RELOAD` key combo (E+R). The AnimSounds timeline fires inspection sound effects at scheduled times.

**How CUH implements it:** Inspect dispatch typically lives in `Reload`'s `IN_USE` guard (the gun base `Reload` returns early if IN_USE is held, freeing up E+R for inspect). Weapons can implement their own inspect trigger.

**Should we enable:** Yes — define `Animations["inspect"]`, `Animations["inspect_empty"]`, `Animations["inspect_epic"]` + matching AnimSounds entries. See §4.6.

### 3.11 Sprint Animation System

**What:** CUH `HandleRunning` plays `ACT_VM_IDLE_TO_LOWERED` when entering sprint and `ACT_VM_LOWERED_TO_IDLE` when exiting. Weapons can override these to use named sequences via `Animations["sprint_in"]` / `Animations["sprint_loop"]` / `Animations["sprint_out"]`.

**How CUH implements it:** See `weapon_custom_uh_base.lua:551-616`. The `HandleSprintingAnimations` helper (defined in BO3 base / weapon files) reads `Animations["sprint_in"]` etc. and plays them via `EasySendWeaponAnim`.

**Should we enable:** Yes — define the sprint keys in `Animations`. See §4.7.

### 3.12 Dynamic Muzzle Flash Light

**What:** CUH `DoMuzzleFlash` creates a `DynamicLight(self:EntIndex())` at the muzzle attachment with configurable color, brightness, size, decay. Gated by `uh_dynamiclight` ConVar.

**How CUH implements it:** See `weapon_custom_uh_base_gun.lua:570-606`. Reads `MuzzleFlashLightColor`, `MuzzleFlashLightBrightness`, `MuzzleFlashLightSize`, `MuzzleFlashLightDecay`, `MuzzleFlashScale`.

**Should we enable:** Yes — automatic if `MuzzleFlashType = "particle"`.

### 3.13 Sniper Scope RT (Render Target)

**What:** CUH `RenderScene` hook renders the scope view to a per-weapon render target when `Zooming` is true. The RT is then mapped to a `ScopeTexture` material that the viewmodel displays in the scope lens.

**How CUH implements it:** See `weapon_custom_uh_base_gun.lua:135-141` (RT creation in Initialize) and `957-980` (RenderScene hook). Reads `SWEP.ScopeTexture`, `SWEP.ScopeFov` (default 8), `SWEP.RT_Size`, `SWEP.ScopeDisabled`.

**Should we enable:** Yes for snipers — set `SWEP.ScopeTexture = Material("scopes/scope_overlay.png", "smooth")`, `SWEP.ScopeFov = 8`, `SWEP.Use2DScope = true`. See §4.10.

### 3.14 CustomThink Hook

**What:** CUH `Think()` invokes `self:CustomThink(ct)` at the end (after reload-completion, zoom logic, AnimSounds). Weapons can register per-frame logic without overriding Think entirely.

**How CUH implements it:** See `weapon_custom_uh_base_gun.lua:923-925`.

**Should we enable:** Yes — used for jam decay, burst continuation, pump-action delay, etc.

### 3.15 PreReload / PostReload Hooks

**What:** `PreReload()` is called before the reload animation plays. `PostReload()` is called after reload completes. Used by shotgun base for backup-clip logic and pump-after-reload.

**Should we enable:** Yes — for bolt-action snipers, can use `PostReload` to play a chamber-round animation. For Model 1897, `PostReload` plays pump-after-reload if was empty.

### 3.16 PostShoot Hook

**What:** `PostShoot()` is called at the end of `PrimaryAttack`. Used by shotgun base for pump-action, by bolt-action snipers for rechamber, etc.

**Should we enable:** Yes — primary hook for all post-fire mechanics.

---

## SECTION 4: MECHANICS PORTING GUIDE

For each major mechanic, the step-by-step porting guide with code templates.

### 4.1 Bolt-Action Rechamber (8 snipers)

**Applies to:** Kar98k, Mosin, Arisaka, Springfield, De Lisle, MAS 36 PTRS-41, Wz.35.

**TFA input:**
```lua
SWEP.PumpAction = { ["type"] = TFA.Enum.ANIMATION_ACT, ["value"] = ACT_VM_PULLBACK_HIGH, ["value_is"] = ACT_VM_PULLBACK_LOW }
SWEP.SequenceLengthOverride = { [ACT_VM_PULLBACK_HIGH] = 35/30, [ACT_VM_PULLBACK_LOW] = 35/30 }
SWEP.EventTable = {
    [ACT_VM_PULLBACK_HIGH] = {
        { 5/30, "sound", Sound("TFA_CODWW2_KAR98K.BoltUp") },
        { 10/30, "lua", function(self) self:EventShell() end, client=true, server=true },
        { 15/30, "sound", Sound("TFA_CODWW2_KAR98K.BoltForward") },
    },
    [ACT_VM_PULLBACK_LOW] = { ... same ... },
}
```

**CUH porting steps:**
1. Drop `SWEP.PumpAction` field entirely (CUH doesn't read it).
2. Add `SWEP.PumpDelay = 0.1` (delay after shot before rechamber anim plays).
3. Add `SWEP.IsBolt = true` (so reload flashlight logic skips the arm-gone check).
4. Define `SWEP.Animations["rechamber"]` and `SWEP.Animations["rechamber_ads"]` (the same anim sequence is fine — both can map to `"base_rechamber"`).
5. Define `SWEP.AnimSounds["rechamber"]` with the bolt-up/forward sounds and a shell-eject callback.
6. Override `SWEP:PostShoot()` to schedule the rechamber anim + lock fire delay.

**Exact code template:**
```lua
-- In weapon file:
SWEP.IsBolt = true
SWEP.PumpDelay = 0.1  -- seconds after shot before rechamber anim plays
SWEP.RechamberDuration = 35/30  -- total rechamber duration (for fire delay lock)

SWEP.Animations = {
    ["rechamber"] = "rechamber_high",
    ["rechamber_ads"] = "rechamber_low",
}

SWEP.AnimSounds = {
    ["rechamber"] = {
        { time = 5/30,  sound = "TFA_CODWW2_KAR98K.BoltUp" },
        { time = 10/30, callback = function(wep) wep:CreateShell(wep.ShellDelay or 0, 0) end },
        { time = 15/30, sound = "TFA_CODWW2_KAR98K.BoltForward" },
    },
    -- rechamber_ads inherits from rechamber via SetupAnimSounds fallback
}

function SWEP:PostShoot()
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.1
    local isZooming = self:GetUHBool("Zooming")
    timer.Simple(pumpDelay, function()
        if not IsValid(self) then return end
        if not IsValid(self.Owner) or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        if SERVER or IsFirstTimePredicted() then
            self:EasySendWeaponAnim(isZooming and "rechamber_ads" or "rechamber",
                                     isZooming and ACT_VM_PULLBACK_LOW or ACT_VM_PULLBACK_HIGH)
        end
    end)
    -- Lock fire for rechamber duration
    self:SetNextPrimaryFire(ct + (self.RechamberDuration or 1.17))
    self:SetNextSecondaryFire(ct + (self.RechamberDuration or 1.17))
    self.NextReload = ct + (self.RechamberDuration or 1.17)
end
```

**Note on EventShell:** TFA's `self:EventShell()` calls `self:CreateShell(0, 0)` essentially. CUH `CreateShell(delay, heat)` already handles the shell eject effect. Replace the lua-callback with `function(wep) wep:CreateShell(0, 0) end`.

### 4.2 Shotgun Shell-by-Shell Reload (4 weapons)

**Applies to:** Model 1897, Blunderbuss (sort of — single shell), MAS 36 (sniper with shotgun reload), Winchester 94 (lever-action with shotgun reload).

**TFA input:**
```lua
SWEP.Shotgun = true
SWEP.ShotgunEmptyAnim = true  -- Model 1897 only; false on others
SWEP.ShotgunEmptyAnim_Shell = true  -- Model 1897 only
SWEP.ShotgunStartAnimShell = true
SWEP.Primary.PumpSound = "TFA_CODWW2_M1897.Rack"
SWEP.Primary.ShellSound = "TFA_CODWW2_M1897.Insert"
SWEP.Primary.ReloadTime = 0.5  -- per-shell interval
```

**CUH porting steps:**
1. Set `SWEP.Base = "weapon_custom_uh_base_shotty"` (NOT `weapon_cuh_base_gun` — shotguns inherit from the gun-shotty layer, NOT the CUH layer).

   **⚠️ Important decision:** The shotgun base does NOT inherit from `weapon_cuh_base_gun` — it inherits from `weapon_custom_uh_base_gun`. This means shotguns CANNOT use the CUH attachment system.

   **Workaround:** Either:
   - (a) Create a new `weapon_cuh_base_shotty` base that inherits from `weapon_custom_uh_base_shotty` + adds the CUH attachment layer (significant work).
   - (b) Don't make shotguns customizable — just use `weapon_custom_uh_base_shotty` directly. **Recommend this for the first pass.**

2. Set `SWEP.Shotgun = true`.
3. Set `SWEP.IsPump = true` (Model 1897 only — triggers pump-after-fire).
4. Set `SWEP.PumpDelay = 0.5` (or per-weapon).
5. Set `SWEP.Primary.PumpSound`, `SWEP.Primary.ShellSound`, `SWEP.Primary.ReloadTime`.
6. Set `SWEP.CustomThink` to dispatch `ReloadShotgun`:
   ```lua
   SWEP.CustomThink = function(self, ct)
       if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
           self:ReloadShotgun(ct)
       end
   end
   ```
7. Define `SWEP.Animations["start_reload"]`, `["reload_loop"]`, `["after_reload"]`.

**Exact code template (KRM-262 pattern from BO3 references):**
```lua
SWEP.Base = "weapon_custom_uh_base_shotty"  -- NOT cuh_base_gun
SWEP.Shotgun = true
SWEP.IsPump = true  -- Model 1897 only
SWEP.PumpDelay = 0.5
SWEP.ShellLoadTime = 0.5  -- per-shell interval (CUH reads this in BO3 shotgun base; matches Primary.ReloadTime in UH shotgun base)

SWEP.Primary.PumpSound = "TFA_CODWW2_M1897.Rack"
SWEP.Primary.ShellSound = "TFA_CODWW2_M1897.Insert"
SWEP.Primary.ReloadTime = 0.5

SWEP.Animations = {
    ["start_reload"] = "reload_start",
    ["reload_loop"]  = "reload_loop",
    ["after_reload"] = "reload_end",
    ["pump"]         = "pump",
}

SWEP.AnimSounds = {
    ["reload_start"] = {
        { time = 0.0, sound = "TFA_CODWW2_M1897.Start" },
    },
    ["reload_loop"] = {  -- per-shell insertion sound
        { time = 0.0, sound = "TFA_CODWW2_M1897.Insert" },
    },
    ["reload_finish"] = {
        { time = 0.0, sound = "TFA_CODWW2_M1897.End" },
    },
    ["pump"] = {
        { time = 0.0, sound = "TFA_CODWW2_M1897.Rack" },
    },
}

SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
    end
end

-- Model 1897: also override PostShoot for pump-after-fire (already in shotty base)
-- Blunderbuss: IsPump = false (single-shot, no pump needed)
-- MAS 36 / Winchester: IsPump = false (bolt/lever, not pump)
```

**Empty-reload anim differentiation (Model 1897 only):**
Override `Reload()` to pick `start_reload_empty` if `Clip1() <= 0`:
```lua
function SWEP:Reload()
    if not IsValid(self.Owner) then return end
    local ct = CurTime()
    if self.NextReload < ct and not self:GetUHBool("Reloading") and not self:GetUHBool("Running")
       and self.Owner:GetNWFloat("UH_GrenadeTime") < ct
       and self:GetNWFloat("DeployTime") < ct then
        if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and self:Clip1() < self.Primary.ClipSize then
            -- Pick empty vs non-empty start anim
            local isEmpty = self:Clip1() <= 0
            local startKey = isEmpty and "start_reload_empty" or "start_reload"
            self:EasySendWeaponAnim(startKey, ACT_SHOTGUN_RELOAD_START)
            -- ...rest of base Reload body (state flags, reloaddelay, NW floats)
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
            self.reloaddelay = ct + (IsValid(self.Owner:GetViewModel()) and self.Owner:GetViewModel():SequenceDuration() or 0.5) + (self.ShellLoadTime or 0.5)
            self.NextReload = ct + 0.5
            return
        end
    end
end
```

### 4.3 Pump-Action Rechamber (combat shotgun — Model 1897)

**Same as bolt-action (§4.1) but with `ACT_SHOTGUN_PUMP`:**

**Already handled by CUH shotgun base `PostShoot`:**
```lua
-- In weapon_custom_uh_base_shotty.lua:PostShoot (line 72)
function SWEP:PostShoot()
    if not self.IsPump then return end
    if self:Clip1() <= 0 and GetConVar("uh_sv_realpump"):GetBool() then
        if timer.Exists("CustomUH_Shell_" .. self.Owner:SteamID()) then
            timer.Remove("CustomUH_Shell_" .. self.Owner:SteamID())
        end
    else
        timer.Simple(self.PumpDelay or 0.5, function()
            if not IsValid(self) or self:GetUHBool("Reloading") then return end
            if not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) then return end
            if self.Owner:GetActiveWeapon() != self then return end
            if SERVER or (CLIENT and IsFirstTimePredicted()) then
                self.Owner:EmitSound(self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE)
            end
            self:EasySendWeaponAnim("pump", ACT_SHOTGUN_PUMP)
        end)
    end
end
```

**Weapon file requirements:**
```lua
SWEP.Base = "weapon_custom_uh_base_shotty"
SWEP.IsPump = true
SWEP.PumpDelay = 0.3
SWEP.Primary.PumpSound = "TFA_CODWW2_M1897.Rack"
SWEP.Animations = { ["pump"] = "pump" }
SWEP.AnimSounds = { ["pump"] = { { time = 0.0, sound = "TFA_CODWW2_M1897.Rack" } } }
```

**Dragon's Breath variant (incendiary shells):** Override `PostShoot` to check for incendiary attachment state and play `"rechamber_dragon"` animation:
```lua
function SWEP:PostShoot()
    if not self.IsPump then return end
    local isDragon = self:GetNWBool("DragonShells")
    timer.Simple(self.PumpDelay or 0.5, function()
        if not IsValid(self) or self:GetUHBool("Reloading") then return end
        if not IsValid(self.Owner) or self.Owner:GetActiveWeapon() ~= self then return end
        if SERVER or IsFirstTimePredicted() then
            self.Owner:EmitSound(self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE)
        end
        self:EasySendWeaponAnim(isDragon and "rechamber_dragon" or "pump", ACT_SHOTGUN_PUMP)
    end)
end
```

### 4.4 Burst Fire (ITRA Burst, ZK-383)

**Applies to:** ITRA Burst (4-round burst, locked), ZK-383 (rapid-fire attachment swaps to higher RPM — not actually burst).

**TFA input:**
```lua
SWEP.Primary.RPM_Burst = 952
SWEP.Primary.BurstDelay = 0.2  -- ITRA only; later overridden to nil
SWEP.DisableBurstFire = false
SWEP.OnlyBurstFire = true  -- ITRA only
SWEP.BurstFireCount = 4
```

**CUH porting steps:**
1. Define `SWEP.FireModes` table with a burst entry.
2. Define `SWEP:FireBurstRound()` helper that fires one bullet.
3. Add burst continuation in `CustomThink` or override `Think`.

**Exact code template (M8A7 pattern from BO3 references):**
```lua
SWEP.BurstCount = 4  -- from BurstFireCount
SWEP.BurstDelay = 0.05  -- seconds between burst rounds (override of TFA's 0.2)

SWEP.FireModes = {
    [1] = {
        name = "Burst",
        shoot = function(owner, wep)
            if wep._burstActive then return false end  -- already bursting
            wep._burstActive = true
            wep._burstRemaining = wep.BurstCount or 4
            wep:FireBurstRound()
            return false  -- let PrimaryAttack continue (fire the first bullet)
        end,
        holster = function(owner, wep)
            wep._burstActive = false
            wep._burstRemaining = 0
        end,
    },
}

function SWEP:FireBurstRound()
    if not self:CanPrimaryAttack() then
        self._burstActive = false
        self._burstRemaining = 0
        return
    end
    -- Fire one round (duplicate of PrimaryAttack bullet logic)
    if SERVER or IsFirstTimePredicted() then
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)
        if self:GetNWBool("Silenced") then dmg = math.Round(dmg * 0.95) end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end
    self:DoMuzzleFlash()
    if not self.NoShell then self:CreateShell(self.ShellDelay or 0, self.ShellHeat) end
    self:EasySendWeaponAnim("shoot", ACT_VM_PRIMARYATTACK)
    self:EmitSound(self:GetShootSound(), 110, 100, 1, CHAN_WEAPON)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self._burstRemaining = (self._burstRemaining or 0) - 1
    self._burstNextShot = CurTime() + self.BurstDelay
end

SWEP.CustomThink = function(self, ct)
    if self._burstActive and self._burstRemaining > 0 then
        if ct >= (self._burstNextShot or 0) then
            self:FireBurstRound()
        end
    elseif self._burstActive and self._burstRemaining <= 0 then
        self._burstActive = false
        -- Reset fire delay to allow next trigger pull
        self:SetNextPrimaryFire(ct + (60 / (self.Primary.RPM_Burst or self.Primary.RPM or 600)))
    end
end
```

**Notes:**
- `FireModes[1].shoot` returns `false` (does NOT abort PrimaryAttack) so the parent's bullet-firing logic runs for the FIRST round of the burst.
- Subsequent burst rounds are fired by `FireBurstRound` from `CustomThink`.
- The burst ends either when `_burstRemaining <= 0` OR when clip runs out (`CanPrimaryAttack` returns false).

**ITRA Burst specifics:**
- Set `OnlyBurstFire = true` equivalent: define `SWEP.FireModes` with ONLY the burst entry (no full-auto entry).
- `DefaultFireMode = "1"` equivalent: `SWEP:SetNWInt("FireMode", 1)` in Initialize (already default).

**OnPaP (converts ITRA Burst from burst → full-auto):**
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary.ClipSize = 60
    self.Primary.Damage = 453
    self.Primary.NumShots = 2
    self.Primary.Delay = 60 / 724  -- RPM 724
    self.Primary.DefaultClip = 660
    self.Primary.MaxAmmo = 600
    self.Primary.Automatic = true
    -- Disable burst — replace FireModes with full-auto only
    self.FireModes = {
        [1] = { name = "Full Auto" },
    }
    if self.ApplyAttachments then self:ApplyAttachments() end
    return true
end
```

### 4.5 Melee Bash (all weapons)

**Applies to:** Every WWII weapon — all have `Secondary.Bash*` fields.

**TFA input:**
```lua
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingRfl")
SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")
SWEP.Secondary.BashLength = 45
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = true
```

**CUH porting steps:**
1. Move all `Secondary.Bash*` to top-level `SWEP.Melee*` (renaming as per §1.2).
2. Override `PrimaryAttack` to dispatch to `MeleeAttack` when `IN_USE` is held.
3. Optionally override `DoMeleeTrace` to differentiate flesh-vs-world hit sounds.

**Exact code template (BO3 base pattern):**
```lua
-- Top-level field mapping (replaces Secondary.Bash*):
SWEP.MeleeDamage = 35       -- from Secondary.BashDamage
SWEP.MeleeSound = "TFA_CODWW2_MELEE.SwingRfl"  -- from Secondary.BashSound
SWEP.MeleeHitSound = "TFA_CODWW2_MELEE.Hit"     -- from Secondary.BashHitSound
SWEP.MeleeHitSoundFlesh = "TFA_CODWW2_MELEE.HitPlr"  -- from Secondary.BashHitSound_Flesh (custom CUH field)
SWEP.MeleeMissSound = ""    -- no TFA equivalent; CUH plays this on miss
SWEP.MeleeRange = 45        -- from Secondary.BashLength
SWEP.MeleeHitDelay = 0.2    -- from Secondary.BashDelay
SWEP.MeleeDelay = 0.6       -- cooldown (no TFA equivalent; default)
SWEP.MeleeForce = 300       -- default
SWEP.MeleeViewPunch = Angle(-3, 0, 0)  -- default
SWEP.MeleeInterruptReload = true  -- from Secondary.BashInterrupt

SWEP.Animations = {
    ["melee"] = "bash",  -- bash animation sequence
}

-- E + M1 dispatch (must be in EVERY weapon file — or fix the base, see §5.6)
function SWEP:PrimaryAttack()
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") and self.MeleeInterruptReload ~= false then
            -- MeleeAttack will cancel the reload internally
        elseif self:GetUHBool("Reloading") then
            return
        end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then
            self:MeleeAttack()
        end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

-- Differentiate flesh-vs-world hit sound (optional, replaces default DoMeleeTrace):
function SWEP:DoMeleeTrace()
    local ply = self.Owner
    if not IsValid(ply) then return end
    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64
    local tr = util.TraceHull({
        start = pos, endpos = pos + aim * range,
        filter = ply, mask = MASK_SHOT_HULL,
        mins = Vector(-10,-10,-10), maxs = Vector(10,10,10),
    })
    if tr.Hit then
        if IsValid(tr.Entity) and SERVER then
            local dmg = DamageInfo()
            dmg:SetDamage(self.MeleeDamage or 50)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(self)
            dmg:SetDamageForce(aim * (self.MeleeForce or 300))
            dmg:SetDamagePosition(tr.HitPos)
            dmg:SetDamageType(DMG_CLUB)
            tr.Entity:TakeDamageInfo(dmg)
        end
        if SERVER then util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32) end
        -- Pick flesh vs world sound
        local hitSnd = self.MeleeHitSound
        if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsNextBot()) then
            hitSnd = self.MeleeHitSoundFlesh or self.MeleeHitSound
        end
        if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
        if hitSnd and hitSnd ~= "" then
            self:EmitSound(hitSnd, 75, 100, 1, CHAN_USER_BASE)
        end
    else
        if self.MeleeMissSound and self.MeleeMissSound ~= "" then
            self:EmitSound(self.MeleeMissSound, 65, 100, 1, CHAN_USER_BASE)
        end
    end
    ply:ViewPunch(self.MeleeViewPunch or Angle(-3,0,0))
end
```

**Recommended base patch:** Add the E+M1 dispatch to `weapon_cuh_base_gun.lua:PrimaryAttack` so weapon files don't need to duplicate it (see §5.6).

### 4.6 Inspect (E+R)

**Applies to:** Every WWII weapon — all have inspect animations in their EventTable.

**TFA input:**
```lua
SWEP.EventTable = {
    ["inspect"] = { { 1/30, "sound", "TFA_CODWW2_1911.Inspect1" }, { 50/30, "sound", "TFA_CODWW2_1911.Inspect2" } },
    ["inspect_empty"] = { ... },
    ["inspect_epic"] = { ... },
    [ACT_VM_FIDGET] = { ... },  -- alias for "inspect"
    [ACT_VM_FIDGET_SILENCED] = { ... },  -- alias for "inspect_epic"
}
SWEP.InspectPos = Vector(10, -7, -2)
SWEP.InspectAng = Vector(24, 42, 16)
```

**CUH porting steps:**
1. Convert EventTable entries to AnimSounds.
2. Add `Animations["inspect"]`, `["inspect_empty"]`, `["inspect_epic"]` mapping to sequence names.
3. Implement E+R trigger (override `Reload` since base `Reload` blocks on `IN_USE`).

**Exact code template:**
```lua
SWEP.Animations = {
    ["inspect"] = "inspect",
    ["inspect_empty"] = "inspect_empty",
    ["inspect_epic"] = "inspect_epic",
}

SWEP.AnimSounds = {
    ["inspect"] = {
        { time = 1/30,  sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 50/30, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 1/30,  sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 50/30, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_epic"] = {
        { time = 1/30,  sound = "TFA_CODWW2_1911.EpicInspect1" },
        { time = 45/30, sound = "TFA_CODWW2_1911.EpicInspect2" },
    },
}

SWEP._isInspecting = false

function SWEP:Reload()
    local ct = CurTime()
    -- E + R = inspect
    if self.Owner:KeyDown(IN_USE) and not self:GetUHBool("Reloading") and not self._isInspecting
       and self:GetNWFloat("DeployTime") < ct and self.NextReload < ct then
        self._isInspecting = true
        local isEmpty = self:Clip1() <= 0
        local inspectKey = isEmpty and "inspect_empty" or "inspect"
        -- Optionally pick "inspect_epic" randomly (10% chance)
        if math.Rand(0, 1) < 0.1 and self.Animations["inspect_epic"] then
            inspectKey = "inspect_epic"
        end
        self:EasySendWeaponAnim(inspectKey, ACT_VM_FIDGET)
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        local dur = IsValid(vm) and vm:SequenceDuration() or 3.0
        self:SetNextPrimaryFire(ct + dur)
        self:SetNextSecondaryFire(ct + dur)
        self.NextReload = ct + dur
        timer.Simple(dur, function()
            if IsValid(self) then self._isInspecting = false end
        end)
        return
    end
    return BaseClass.Reload(self)
end
```

**Notes:**
- The base `Reload` already returns early if `IN_USE` is held (`weapon_custom_uh_base_gun.lua:708`) — but it just does nothing. Our override intercepts E+R BEFORE the base check, dispatches inspect, and returns.
- Inspect cancels reload if pressed during reload? Set `_isInspecting` to skip if Reloading bool is true (as in the template above).
- Epic inspect variants trigger ~10% of the time (matches TFA behaviour for ACT_VM_FIDGET_SILENCED).

### 4.7 Sprint Animations

**Applies to:** Every WWII weapon — all have `SprintAnimation` tables.

**TFA input:**
```lua
SWEP.SprintAnimation = {
    ["in"]   = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_in",   value_empty = "sprint_in_empty" },
    ["loop"] = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_loop", value_empty = "sprint_loop_empty", is_idle = true },
    ["out"]  = { type = TFA.Enum.ANIMATION_SEQ, value = "sprint_out",  value_empty = "sprint_out_empty" },
}
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI  -- or HYBRID
SWEP.SprintBobMult = 0  -- disable viewmodel bob during sprint
```

**CUH porting steps:**
1. Move all sprint anim sequence names to `SWEP.Animations`:
   - `sprint_in` → value
   - `sprint_in_empty` → value_empty
   - `sprint_loop` → value
   - `sprint_loop_empty` → value_empty
   - `sprint_out` → value
   - `sprint_out_empty` → value_empty
2. Define `SWEP:HandleSprintingAnimations()` to play these in/out/loop anims.
3. Handle empty-clip variants.

**Exact code template (BO3 base pattern):**
```lua
SWEP.Animations = {
    ["sprint_in"]       = "sprint_in",
    ["sprint_in_empty"] = "sprint_in_empty",
    ["sprint_loop"]     = "sprint_loop",
    ["sprint_loop_empty"] = "sprint_loop_empty",
    ["sprint_out"]      = "sprint_out",
    ["sprint_out_empty"] = "sprint_out_empty",
}

function SWEP:HandleSprintingAnimations()
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if not IsValid(vm) then return end

    local isRunning = self:GetUHBool("Running")
    local isEmpty = self:Clip1() <= 0

    -- Detect transitions
    if isRunning and not self._wasSprinting then
        -- ENTER sprint
        local key = isEmpty and "sprint_in_empty" or "sprint_in"
        self:EasySendWeaponAnim(key, ACT_VM_IDLE_TO_LOWERED)
        self._wasSprinting = true
        self._sprintLoopNext = CurTime() + (IsValid(vm) and vm:SequenceDuration() or 0.5)
    elseif not isRunning and self._wasSprinting then
        -- EXIT sprint
        local key = isEmpty and "sprint_out_empty" or "sprint_out"
        self:EasySendWeaponAnim(key, ACT_VM_LOWERED_TO_IDLE)
        self._wasSprinting = false
        self._sprintLoopNext = nil
    elseif isRunning and self._wasSprinting then
        -- LOOP sprint
        if CurTime() >= (self._sprintLoopNext or math.huge) then
            if vm:GetCycle() >= 1.0 then
                local key = isEmpty and "sprint_loop_empty" or "sprint_loop"
                self:EasySendWeaponAnim(key, ACT_VM_IDLE_LOWERED)
                self._sprintLoopNext = CurTime() + (IsValid(vm) and vm:SequenceDuration() or 0.5)
            end
        end
    end
end

SWEP.CustomThink = function(self, ct)
    -- Dispatch sprint anim updates
    self:HandleSprintingAnimations()
end
```

**Note on `Sprint_Mode = LOCOMOTION_HYBRID`:** TFA hybrid mode blends animation + procedural. CUH doesn't support hybrid — just animation. Weapons using `LOCOMOTION_ANI` (animation only) port cleanly. Weapons using `LOCOMOTION_HYBRID` need to choose one (recommend `LOCOMOTION_ANI` since CUH already does procedural lowering via `ACT_VM_IDLE_TO_LOWERED`).

### 4.8 Attachment System Conversion

**TFA input:**
```lua
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_supp_pistol"}, order = 1},
    [2] = {atts = {"tfa_codww2_knife"}, order = 2},
    [3] = {atts = {"tfa_codww2_xmag"}, order = 3},
    [4] = {atts = {"tfa_codww2_rifling", "tfa_codww2_steadyaim", "tfa_codww2_quickdraw"}, order = 4},
    [5] = {atts = {"tfa_codww2_highcal", "tfa_codww2_fmj"}, order = 5},
    [6] = {atts = {"tfa_codww2_akimbo"}, order = 6, sel = 1, default = "tfa_codww2_akimbo"},
}
SWEP.AttachmentExclusions = { ["tfa_codww2_akimbo"] = {1, 2, 3} }  -- akimbo excludes slots 1,2,3
```

**CUH conversion:**
```lua
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_supp_pistol"}},  -- no order field needed
    [2] = {atts = {"tfa_codww2_knife"}},
    [3] = {atts = {"tfa_codww2_xmag"}},
    [4] = {atts = {"tfa_codww2_rifling", "tfa_codww2_steadyaim", "tfa_codww2_quickdraw"}},
    [5] = {atts = {"tfa_codww2_highcal", "tfa_codww2_fmj"}},
    [6] = {atts = {"tfa_codww2_akimbo"}, default = 1, forceDefault = false},
    -- Note: `default = 1` is the NUMERIC index into atts (vs TFA's "tfa_codww2_akimbo" string)
}
-- AttachmentExclusions: NO direct equivalent — handle in attachment's Attach() function
```

**VElement format conversion:**
```lua
-- TFA:
SWEP.VElements = {
    ["suppressor"] = {
        type = "Model",
        model = "models/weapons/tfa_codww2/attachments/suppressors/c_pistol_suppressor.mdl",
        bone = "tag_weapon",
        rel = "",  -- TFA-only field, drop
        pos = Vector(0,0,0),
        angle = Angle(0,0,0),
        size = Vector(1,1,1),
        color = Color(255,255,255,255),
        surpresslightning = false,
        material = "",
        skin = 0,
        bonemerge = true,
        active = false,
        bodygroup = {},  -- TFA name
    },
}

-- CUH:
SWEP.ViewModelElements = {
    ["suppressor"] = {
        type = "Model",
        model = "models/weapons/tfa_codww2/attachments/suppressors/c_pistol_suppressor.mdl",
        bone = "tag_weapon",
        -- rel dropped
        pos = Vector(0,0,0),
        ang = Angle(0,0,0),  -- renamed from "angle"
        scale = Vector(1,1,1),  -- renamed from "size"
        color = Color(255,255,255,255),
        surpresslightning = false,  -- typo preserved from TFA
        material = "",
        skin = 0,
        bonemerge = true,
        active = false,
        bodygroups = {},  -- renamed from "bodygroup"
    },
}
```

Same for `SWEP.WElements` → `SWEP.WorldModelElements`.

**ATTACHMENT.WeaponTable format:**
```lua
-- TFA (and CUH — they're identical):
ATTACHMENT = {
    Name = "Extended Mags",
    ShortName = "XMAG",
    Icon = "entities/tfa_codww2_xmag.png",
    Description = {Color(100,255,100), "Increased magazine size"},
    AttachSound = "TFA_CODWW2_ATT.Equip",
    DetachSound = "TFA_CODWW2_ATT.Unequip",
    WeaponTable = {
        VElements = { ["clip_default"] = { active = false }, ["ext_clip"] = { active = true } },
        WElements = { ["clip_default"] = { active = false }, ["ext_clip"] = { active = true } },
        Primary = {
            ClipSize = function(wep, stat) return wep.Primary.ClipSize_Ext or stat end,
        },
        Animations = {
            ["reload"] = "reload_ext",
            ["reload_empty"] = "reload_ext_empty",
        },
    },
    Attach = function(wep) end,  -- pcall-wrapped by CUH
    Detach = function(wep) end,  -- NOT CALLED by CUH — see §5.3
}
```

**Conversion:** ATTACHMENT.WeaponTable format is essentially identical between TFA and CUH. No structural changes needed. The only behavior difference is that CUH's `WeaponTable.VElements[name].active = false` works because the snapshot mechanism restores on detach.

### 4.9 Sound System (EventTable → AnimSounds)

**Conversion algorithm:**

1. For each TFA EventTable key, determine the CUH AnimSounds key (use the mapping table in §1.7).
2. For each entry in the TFA timeline array:
   - Extract `time` (a fraction like `5/30` — keep as a number, no conversion needed).
   - If `type == "sound"`, set `sound = value` (the sound path or `Sound(...)` wrapper — strip the wrapper).
   - If `type == "lua"`, set `callback = value` (the function). The function's first arg becomes `wep` (instead of `self`).
   - Copy `level` (default 75) and `pitch` (default 100) if present.

**Example conversion (Kar98k EventTable):**
```lua
-- TFA:
SWEP.EventTable = {
    [ACT_VM_DRAW] = { { 1/30, "sound", Sound("TFA_CODWW2_RIFLE.Raise") } },
    [ACT_VM_HOLSTER] = { { 2/30, "sound", Sound("TFA_CODWW2_RIFLE.Holster") } },
    [ACT_VM_RELOAD] = {
        { 5/30, "sound", Sound("TFA_CODWW2_KAR98K.TacMagOut") },
        { 25/30, "sound", Sound("TFA_CODWW2_KAR98K.TacMagIn") },
    },
    [ACT_VM_RELOAD_EMPTY] = {
        { 5/30, "sound", Sound("TFA_CODWW2_KAR98K.MagOut") },
        { 25/30, "sound", Sound("TFA_CODWW2_KAR98K.MagIn") },
        { 40/30, "sound", Sound("TFA_CODWW2_KAR98K.Charge") },
    },
    [ACT_VM_PULLBACK_HIGH] = {
        { 5/30, "sound", Sound("TFA_CODWW2_KAR98K.BoltUp") },
        { 10/30, "lua", function(self) self:EventShell() end, client=true, server=true },
        { 15/30, "sound", Sound("TFA_CODWW2_KAR98K.BoltForward") },
    },
    [ACT_VM_FIDGET] = { { 1/30, "sound", Sound("TFA_CODWW2_KAR98K.Inspect1") }, { 50/30, "sound", Sound("TFA_CODWW2_KAR98K.Inspect2") } },
    ["inspect_empty"] = { ... },
}

-- CUH:
SWEP.AnimSounds = {
    ["draw"] = { { time = 1/30, sound = "TFA_CODWW2_RIFLE.Raise" } },
    ["holster"] = { { time = 2/30, sound = "TFA_CODWW2_RIFLE.Holster" } },
    ["reload"] = {
        { time = 5/30,  sound = "TFA_CODWW2_KAR98K.TacMagOut" },
        { time = 25/30, sound = "TFA_CODWW2_KAR98K.TacMagIn" },
    },
    ["reload_empty"] = {
        { time = 5/30,  sound = "TFA_CODWW2_KAR98K.MagOut" },
        { time = 25/30, sound = "TFA_CODWW2_KAR98K.MagIn" },
        { time = 40/30, sound = "TFA_CODWW2_KAR98K.Charge" },
    },
    ["rechamber"] = {
        { time = 5/30,  sound = "TFA_CODWW2_KAR98K.BoltUp" },
        { time = 10/30, callback = function(wep) wep:CreateShell(0, 0) end },
        { time = 15/30, sound = "TFA_CODWW2_KAR98K.BoltForward" },
    },
    ["inspect"] = {
        { time = 1/30,  sound = "TFA_CODWW2_KAR98K.Inspect1" },
        { time = 50/30, sound = "TFA_CODWW2_KAR98K.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 1/30,  sound = "TFA_CODWW2_KAR98K.Inspect1" },
        { time = 50/30, sound = "TFA_CODWW2_KAR98K.Inspect2" },
    },
}
```

**Handling "lua" type entries:**
- `self:EventShell()` → `function(wep) wep:CreateShell(0, 0) end`
- `self.Bodygroups_V[1] = math.Clamp(self:Clip1(), 0, 26)` → `function(wep) wep.Bodygroups_V = wep.Bodygroups_V or {}; wep.Bodygroups_V[1] = math.Clamp(wep:Clip1(), 0, 26) end`
- Custom TFA methods (e.g. `self:DetachGrenade()`) — port the method to the CUH weapon file as `function SWEP:DetachGrenade() ... end`, then use `function(wep) wep:DetachGrenade() end` in the callback.

**Handling multiple sounds at the same time:** TFA supports multiple entries at the same `time` value. CUH AnimSounds also supports this — just add multiple entries with the same `time`. The `ProcessAnimSounds` while-loop fires all entries whose `time <= elapsed`.

### 4.10 Scope/Zoom System

**Applies to:** All snipers — Kar98k, Mosin, Arisaka, Springfield, De Lisle, MAS 36, PTRS-41, Wz.35, Winchester 94.

**TFA input:**
```lua
SWEP.Secondary.ScopeZoom = 4  -- or 7
SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay.png", "smooth"), ... }
SWEP.Secondary.UseACOG = false  -- (or true for ACOG variant)
SWEP.ScopeOverlayThreshold = 0.875
SWEP.ScopeScale = 0.65
SWEP.ReticleScale = 0.75
SWEP.IronSightsPos_7X = Vector(...)  -- scope-variant ironsight position
SWEP.IronSightsPos_ACOG = Vector(...)
SWEP.BoltAction = false  -- Winchester sets this; others false
SWEP.Scoped = true
SWEP.Secondary.IronFOV = 65  -- or 0 for "disabled" (scoped)
```

**CUH porting steps:**
1. Set `SWEP.Use2DScope = true` (enables the 2D scope overlay rendering).
2. Set `SWEP.ScopeTexture = Material("scopes/scope_overlay.png", "smooth")`.
3. Set `SWEP.ScopeFov = 8` (very narrow FOV for sniper zoom — equivalent to ~10x scope).
4. Set `SWEP.ZoomFov = 25` (or similar — degrees to subtract from base FOV during ADS).
5. Set `SWEP.Sensitivity = 0.2` (mouse sensitivity multiplier when scoped — `AdjustMouseSensitivity` reads this).
6. For scope attachments (e.g. 7X scope), use the attachment's `WeaponTable.IronSightsPos = Vector(...)` to swap the ironsight position.

**Exact code template:**
```lua
SWEP.Use2DScope = true
SWEP.ScopeTexture = Material("scopes/scope_overlay_mp.png", "smooth")
SWEP.ScopeFov = 8  -- equivalent to ~10x magnification (90 / 8 = 11.25)
SWEP.ZoomFov = 25  -- degrees subtracted from base FOV
SWEP.Sensitivity = 0.2  -- mouse sensitivity multiplier when scoped
SWEP.ScopeOverlayThreshold = 0.875
SWEP.ScopeScale = 0.65
SWEP.ReticleScale = 0.75
SWEP.ScopeDisabled = false

-- IronSightsPos is the HIPFIRE position. Scope-variant ironsight positions
-- are swapped by the scope attachment (tfa_codww2_kar98k_scope etc.):
-- In tfa_codww2_kar98k_scope.lua:
--   ATTACHMENT.WeaponTable.IronSightsPos = Vector(-2.955, -1.5, 1.204)  -- IronSightsPos_7X
--   ATTACHMENT.WeaponTable.IronSightsAng = Vector(0, 0, 0)
--   -- And optionally:
--   ATTACHMENT.WeaponTable.Silenced = false  -- if scope disables silenced firing
```

**Scope rendering flow (already in CUH base):**
1. `PreDrawViewModel` → if `Use2DScope and Zooming` → `render.SetBlend(0)` (hide viewmodel so only scope overlay shows).
2. `RenderScene` hook → if `Zooming` → render scene to per-weapon RT at `ScopeFov` FOV → map RT to `ScopeTexture`.
3. `DrawHUD` → if `Use2DScope and Zooming` → draw scope vignette using `gmod/scope` material.

**No additional weapon code needed** — just set the fields above and the base handles rendering.

**ACOG variant (4× scope):** Same mechanism but different `ScopeFov` (e.g. `SWEP.ScopeFov = 22.5` for 4× magnification = 90/4).

---

## SECTION 5: CRITICAL ISSUES TO FIX IN CUH BASE

These base-level bugs and missing features must be fixed BEFORE porting weapons, otherwise the ported weapons will exhibit broken behavior.

### 5.1 GetStat Shadowed by TFA Stub (CRITICAL)

**Bug:** The CUH base defines `SWEP:GetStat(path)` at line 238 of `weapon_cuh_base_gun.lua` (the stat cache reader). The SAME file ALSO defines `SWEP:GetStat(name, default)` at line 1125 (the TFA compatibility stub returning `default`). Both are on the same class table — the later definition wins, so `GetStat` ALWAYS returns `default` (the TFA stub), never the cached value.

**Impact:** In `ApplyAttachments` Stage 5 (lines 848, 875), the function-transform path calls `self:GetStat(fullPath)` to get the current value, then calls the attachment's function with it. Because `GetStat` returns `default` (nil when called with one arg), the `if currentVal ~= nil then` guard always skips the function-transform. **Function-transform attachments silently don't work.**

This affects ~30% of TFA WWII attachments that use function-transforms (e.g. `tfa_codww2_xmag`'s `Primary.ClipSize = function(wep, stat) return wep.Primary.ClipSize_Ext or stat end`).

**Fix:** Rename the TFA stub to `GetStatTFA`:
```lua
-- weapon_cuh_base_gun.lua line 1125:
function SWEP:GetStatTFA(name, default)  -- renamed from GetStat
    return default
end
```

TFA only calls `IsTFAWeapon()` first (returns false from the stub at line 1120), so TFA shouldn't proceed to call `GetStat`. Even if it did, TFA's behavior would be unchanged (it gets `default` = nil).

### 5.2 SetUHBool/GetUHBool External Dependency (CRITICAL)

**Bug:** `SetUHBool` / `GetUHBool` are NOT defined anywhere in `/home/z/my-project/lua/`. All 5 base files call them on every state transition (Reloading / Zooming / Running bools). They must be provided by an external Underhell addon that registers them as Entity/Weapon meta-methods.

**Impact:** If the Underhell meta-method addon is missing, every state transition silently fails — weapons can't reload, can't ADS, can't sprint. This is the single most critical external dependency.

**Fix:** Two options:
1. **Verify the external addon is mounted** before porting. Check for the existence of `lua/autorun/uh_metatable.lua` or similar in the Underhell addon.
2. **Define them in the grandparent** using `SetNWBool` / `GetNWBool` internally:
   ```lua
   -- Add to weapon_custom_uh_base.lua (grandparent) at file scope:
   function SWEP:SetUHBool(key, value)
       self:SetNWBool("UH_" .. key, value)
   end
   function SWEP:GetUHBool(key)
       return self:GetNWBool("UH_" .. key)
   end
   ```

**Decision:** First verify the addon is mounted (preferred). If not, define them in the grandparent.

### 5.3 ATTACHMENT.Detach Never Called (HIGH)

**Bug:** `ApplyAttachments` Stage 5 only calls `att:Attach(self)` — it never calls `att:Detach(wep)` for previously-equipped attachments. Detachment is handled entirely by the snapshot/restore mechanism (Stages 1-4 reset, Stage 5 re-apply).

**Impact:** Attachments that register hooks in `Attach` (e.g. a custom HUD drawer, a Think hook) will leave the hook registered when deselected — accumulating hooks across re-selects. Also: state mutated by `Attach` outside the snapshot's coverage (e.g. `wep.SomeCustomField = true`) is NOT restored.

**Fix:** Add a `Detach` call before Stage 1 reset:
```lua
-- In ApplyAttachments, BEFORE Stage 1 reset:
-- Stage 0.5: Detach previously-equipped attachments
for slot = 1, #self.Attachments do
    local slotData = self.Attachments[slot]
    if slotData and slotData._prevSel and slotData._prevSel > 0 then
        local attId = slotData.atts and slotData.atts[slotData._prevSel]
        if attId and CustomUH and CustomUH.Attachments and CustomUH.Attachments[attId] then
            local att = CustomUH.Attachments[attId]
            if att.Detach then
                local ok, err = pcall(att.Detach, att, self)
                if not ok then
                    ErrorNoHalt("[CUH] Attachment " .. tostring(attId) .. " Detach() failed: " .. tostring(err) .. "\n")
                end
            end
        end
    end
end
-- Then track new selections for next time
for slot = 1, #self.Attachments do
    local slotData = self.Attachments[slot]
    if slotData then
        slotData._prevSel = self:GetEffectiveAttachment(slot)
    end
end
```

**Decision:** Apply this fix. It's a small addition (~20 lines) and prevents hook accumulation.

### 5.4 Melee State Machine in Think (VERIFIED FIXED)

**Status:** Already fixed. The CUH base `Think()` (line 1231) calls `BaseClass.Think(self)` then runs the melee state machine (lines 1237-1249). The `_meleeHitTime`, `_meleeHitDone`, `_meleeEndTime` state is properly tracked.

**No action needed.** Verified by reading `weapon_cuh_base_gun.lua:1231-1249`.

### 5.5 E+M1 Melee Dispatch Not in Base (HIGH)

**Bug:** The CUH base `PrimaryAttack` is NOT overridden to dispatch to `MeleeAttack` on `IN_USE + M1`. The dispatch lives in weapon files (e.g. M8A1 at `weapon_m8a1_scotia.lua:325-333`), meaning EVERY customizable weapon must duplicate the E+M1 dispatch logic.

**Impact:** A weapon file that forgets the override silently has no melee. With ~80 WWII weapons, this is a high chance of mistakes.

**Fix:** Add a `PrimaryAttack` override to `weapon_cuh_base_gun.lua`:
```lua
-- weapon_cuh_base_gun.lua — add new function:
function SWEP:PrimaryAttack()
    -- E + M1 = melee
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") and self.MeleeInterruptReload == false then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then
            self:MeleeAttack()
        end
        return
    end
    return BaseClass.PrimaryAttack(self)
end
```

**Decision:** Apply this fix. Weapons that need a different E+M1 behavior (e.g. to also handle parkour/mantle) can still override.

### 5.6 FlushStats Unreachable (MEDIUM)

**Bug:** `FlushStats()` (line 262) always returns early at the `if not self._statCache or not self._statDirty then return end` guard. `_statDirty` is set to `false` in `InitStatCache` and never set to `true` anywhere else. `SetStat` does eager writes (immediately updates the SWEP field) but never sets `_statDirty = true`.

**Impact:** `FlushStats` is dead code. No current code calls it, so this is purely a maintenance issue. The eager-write path in `SetStat` already updates the SWEP field immediately, so `FlushStats` is functionally redundant.

**Fix:** Two options:
1. **Remove `FlushStats` entirely** (and the `_statDirty` field). Eager-write is the actual write path.
2. **Refactor `SetStat` to lazy-write** (don't update SWEP field immediately; set `_statDirty = true`), and call `FlushStats` at the end of `ApplyAttachments` Stage 5. This batches writes.

**Decision:** Remove `FlushStats` (option 1) — it's the simpler path and matches the current behavior.

### 5.7 Missing Attachment Data Files (~19) (HIGH)

**Bug:** WWII weapons reference many `tfa_codww2_*` attachment IDs that have NO corresponding file in either `cuh_attachments/` folder. These will result in **empty menu slots** — the slot header shows but no attachment buttons appear.

**Missing attachment IDs (referenced by weapons but no file exists):**
- `tfa_codww2_xmag` (12 weapons!)
- `tfa_codww2_ballistic` (10+ weapons)
- `tfa_codww2_rapidfire_sg` (10+ weapons)
- `tfa_codww2_fmj` (10+ weapons)
- `tfa_codww2_4x` (5+ weapons)
- `tfa_codww2_rapidfire` (2+ weapons)
- `tfa_codww2_supp_pistol` (2 weapons)
- `tfa_codww2_nydar` (3 weapons)
- `tfa_codww2_lens_sight` (2 weapons)
- `tfa_codww2_xmag_noani` (3 weapons)
- `tfa_codww2_rifling` (3 weapons)
- `tfa_codww2_steadyaim` (3 weapons)
- `tfa_codww2_stock` (3 weapons)
- `tfa_codww2_quickdraw` (3 weapons)
- `tfa_codww2_grip` (3 weapons)
- `tfa_codww2_highcal` (2 weapons)
- `tfa_codww2_knife` (1 weapon)
- `tfa_codww2_bayonet` (1 weapon)
- `tfa_codww2_rifle_grenade_ger` (1 weapon)

**Total: ~19 missing attachment files.**

**Fix:** Two options:
1. **Port the missing attachment files** — create one file per missing ID in `lua/cuh_attachments/tfa_codww2_*.lua`. Each file should follow the existing `tfa_codww2_*` attachment pattern.
2. **Strip the references** from WWII weapons' `Attachments` tables — only keep slots whose attachments actually exist.

**Decision:** Port the missing files. Most of them are simple stat modifications (e.g. `tfa_codww2_fmj` increases penetration, `tfa_codww2_rifling` reduces spread). One file per missing ID, ~30 minutes per file = ~10 hours total.

### 5.8 [CUH-DBG] Prints Ungated (LOW)

**Bug:** The CUH base and autorun files contain ~50 `print("[CUH-DBG] ...")` calls that flood the console on every:
- `ApplyAttachments` call (~30 prints per call)
- `SetAttachment` call (~10 prints per call)
- `RegisterAttachments` call (1 print per file = 78 prints on addon load)
- Net message receivers (CUH2_AttSelect, CUH2_AttSync)
- Save/load operations

**Impact:** Server console becomes unusable when players switch weapons frequently. Also affects client FPS slightly due to console I/O.

**Fix:** Gate all `[CUH-DBG]` prints behind a `cuh_debug_verbose` ConVar (default 0):
```lua
-- Add at top of weapon_cuh_base_gun.lua:
CUH_DEBUG_VERBOSE = CreateConVar("cuh_debug_verbose", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE}, "Enable CUH debug prints")

-- Then wrap each print:
if CUH_DEBUG_VERBOSE:GetBool() then print("[CUH-DBG] ...") end

-- OR define a helper:
local function dbg(fmt, ...)
    if CUH_DEBUG_VERBOSE:GetBool() then print(string.format("[CUH-DBG] " .. fmt, ...)) end
end
```

**Decision:** Apply this fix. Single-pass refactor (~50 print calls wrapped).

### 5.9 Additional Issues (MEDIUM)

These were identified in the CUH base audit but aren't critical for the WWII port:

- **`DrawHUD` uses file-scope lerp upvalues** (h_reload, h_crosshair, h_scope) instead of the `self._xxx` fields initialized in `Initialize`. Causes weapon-switch state bleed. Fix: replace file-scope locals with `self._reloadHUDBlend`, `self._crosshairBlend`, `self._scopeBlend`.
- **`InitStatCache`'s `topLevel` list is hardcoded** — 15 specific field names. Attachments that want to modify a top-level field NOT in this list (e.g. `PenetrationDepth`, `ShellDelay`, `MuzzleFlashScale`) will be silently ignored. Fix: expand the list or auto-discover.
- **`DrawWorldModel` doesn't re-apply `WorldModelSkin`** if it changes. Fix: move `SetSkin` call inside the draw loop.
- **`HandleHands` creates a new `Material("color")`** every frame. Fix: cache at file scope.

---

## SECTION 6: RECOMMENDED PORT ORDER

Port weapons in increasing complexity order. Each tier validates the porting patterns established in the previous tier.

### Tier 1: Simple Semi-Auto Pistols (5 weapons)

**Weapons:** 1911, P38, Luger, Nambu, No2 (Webley)
**Why first:** Simplest mechanics — semi-auto fire, single magazine reload, basic bash. Validates:
- TFA → CUH field conversion (RPM → Delay, Damage → Min/MaxDamage, etc.)
- Sound + EventTable → AnimSounds conversion
- VElement/WElement format conversion
- Attachments table conversion (default → numeric index)
- Bash → MeleeAttack dispatch
- Inspect (E+R) override

**Estimated time:** 1 hour per weapon × 5 = 5 hours

### Tier 2: Full-Auto SMGs (12 weapons)

**Weapons:** MP40, Sten, MP28, MP3008, Thompson, PPSH, Type 100, M712 (machine pistol), SDK, Ribeyrolles, AS-44, M1941
**Why second:** Adds full-auto fire handling. Validates:
- `Primary.Automatic = true` path
- Sustained-fire mechanics (recoil per shot, shell eject per shot)
- FireModes table with Full-Auto entry
- Akimbo attachment (M712, SDK use it — most complex attachment)

**Estimated time:** 1 hour per weapon × 12 = 12 hours

### Tier 3: Standard Rifles (12 weapons)

**Weapons:** STG44, BAR, FG42, M1 Garand, M1 Carbine, SVT-40, Gewehr 43, Type 99 Arisaka (rifle variant), Volkssturmgewehr, Ribeyrolles (already in Tier 2), Turner SMLE, De Lisle
**Why third:** Adds grenade launcher attachment (Turner, M1 Garand). Validates:
- Grenade launcher FireModes.shoot callback (returns truthy to abort bullet fire)
- Secondary.Sound = grenade launcher shoot sound
- AttachGrenade / DetachGrenade functions
- Bayonet attachment (Volkssturmgewehr has melee_bayonet anim)

**Estimated time:** 1.5 hours per weapon × 12 = 18 hours

### Tier 4: Bolt-Action Snipers (8 weapons)

**Weapons:** Kar98k, Mosin, Arisaka, Springfield, De Lisle (already in Tier 3), MAS 36, PTRS-41, Wz.35, Winchester 94 (lever)
**Why fourth:** Adds bolt-action rechamber mechanics. Validates:
- PostShoot override with `timer.Simple` for `ACT_VM_PULLBACK_HIGH`/`LOW`
- Scope/RT system (`Use2DScope`, `ScopeTexture`, `ScopeFov`)
- Scope attachment swapping `IronSightsPos`
- Winchester 94 special case: lever-action + shotgun reload (uses `Shotgun = true`)

**Estimated time:** 2 hours per weapon × 8 = 16 hours

### Tier 5: Shotguns (4 weapons)

**Weapons:** Model 1897, Blunderbuss, MAS 36 (already in Tier 4), Winchester 94 (already in Tier 4)
**Why fifth:** Adds shell-by-shell reload. Validates:
- `weapon_custom_uh_base_shotty` base class
- `ReloadShotgun` per-shell loop via `CustomThink`
- `IsPump = true` for pump-action (Model 1897)
- Empty-vs-non-empty reload anim differentiation (Model 1897)
- Dragon's Breath incendiary variant (Model 1897 has `rechamber_dragon` anim)

**Estimated time:** 2.5 hours per weapon × 4 = 10 hours

### Tier 6: LMGs (14 weapons)

**Weapons:** MG42, MG81, Bren, Lewis, Breda 30, Stinger, LAD, DP-28, Type 99 LMG, MG15, FG42 (already in Tier 3), AS-44 (already in Tier 2), M1919, Maxim
**Why sixth:** High fire-rate sustained fire. Validates:
- Large mag + sustained recoil
- Bodygroup-driven ammo belt (`Bodygroups_V[1] = math.Clamp(Clip1(), 0, 26)` via lua EventTable callback)
- `tfa_codww2_xmag_lmg` attachment (most complex attachment — function-based Animations overrides)

**Estimated time:** 1.5 hours per weapon × 14 = 21 hours

### Tier 7: Burst-Fire (2 weapons)

**Weapons:** ITRA Burst, ZK-383
**Why seventh:** Most complex fire-mode mechanic. Validates:
- `FireModes[N].shoot` callback with burst continuation
- `FireBurstRound()` per-bullet helper
- `BurstCount` / `BurstDelay` fields
- ITRA: `OnlyBurstFire = true` (single FireMode)
- ZK-383: `tfa_codww2_rapidfire_zk` attachment swaps RPM (not burst)
- ITRA OnPaP: converts burst → full-auto

**Estimated time:** 3 hours per weapon × 2 = 6 hours

### Tier 8: Special Weapons (12 weapons)

**Weapons:** Panzerschreck, Panzerfaust, M9A1 Bazooka, Type 99 Mortar, M2 Flamethrower, Flammenwerfer 35, Molotov, M30 Luftwaffe Drilling, Model 21 (double-barrel shotgun), and 9 melee weapons (combat knife, katanas, etc.)
**Why last:** Most bespoke mechanics. Validates:
- Launcher: `ShootGrenade` (already in CUH base) + `FireModes[N].shoot` returning truthy to abort bullet fire
- Flamethrower: `tfa_codww2_flamebase` base (NOT `tfa_codww2_base`) — needs separate port path
- Melee: `tfa_melee_base` → `weapon_custom_uh_base_melee` (CUH melee base, different mechanics)

**Estimated time:** 3-5 hours per weapon × 12 = 36-60 hours

### Total estimated port time: ~120-150 hours (3-4 weeks of dedicated work)

**Milestones:**
- End of Tier 1 (5 hours): Validate field-conversion patterns + simple weapons playable.
- End of Tier 2 (17 hours): All SMGs playable, akimbo validated.
- End of Tier 3 (35 hours): All standard guns playable, grenade launcher validated.
- End of Tier 4 (51 hours): All snipers playable, scope system validated.
- End of Tier 5 (61 hours): All shotguns playable, shell-reload validated.
- End of Tier 6 (82 hours): All LMGs playable, bodygroup+function-transform attachments validated.
- End of Tier 7 (88 hours): Burst fire validated.
- End of Tier 8 (~120-150 hours): Complete pack ported.

**Pre-port checklist (must complete first):**
1. Fix §5.1 GetStat shadow bug
2. Verify §5.2 SetUHBool/GetUHBool dependency is mounted (or define in grandparent)
3. Apply §5.3 ATTACHMENT.Detach call (recommended)
4. Apply §5.5 E+M1 melee dispatch in base (recommended)
5. Apply §5.8 [CUH-DBG] print gating
6. Port §5.7 missing attachment files (~19 files)

---

## APPENDIX A: Quick Reference Cheat Sheet

### A.1 RPM → Delay conversion table (common values)

| RPM | Delay (seconds) |
|---|---|
| 100 | 0.600 |
| 220 | 0.273 |
| 250 | 0.240 |
| 300 | 0.200 |
| 483 | 0.124 |
| 500 | 0.120 |
| 600 | 0.100 |
| 652 | 0.092 |
| 670 | 0.090 |
| 680 | 0.088 |
| 700 | 0.086 |
| 722 | 0.083 |
| 800 | 0.075 |
| 952 | 0.063 |
| 1013 | 0.059 |

### A.2 FireModes template (most common: Full-Auto + Semi-Auto + Safe)

```lua
SWEP.FireModes = {
    [1] = { name = "Full Auto" },
    [2] = {
        name = "Semi-Auto",
        shoot = function(owner, wep)
            -- Force single-shot by setting Automatic=false temporarily
            wep.Primary.Automatic = false
            return false  -- let PrimaryAttack continue
        end,
        holster = function(owner, wep)
            wep.Primary.Automatic = true  -- restore for next mode
        end,
    },
    -- [0] is implicit "Safe" — never declared, FireMode NWInt 0 means safe
}
```

### A.3 Default attachment fields (per slot)

| Field | Type | Default | Purpose |
|---|---|---|---|
| `atts` | table | (required) | Array of attachment ID strings |
| `default` | number | `0` | Index of default attachment (auto-applied on init) |
| `forceDefault` | bool | `false` | If true, slot cannot be set to "None" |
| `sel` | number | `nil` | Currently-selected index (mutated at runtime) |

### A.4 VElement field rename table

| TFA field | CUH field | Notes |
|---|---|---|
| `type` | `type` | Same (`"Model"` or `"Sprite"`) |
| `model` | `model` | Same |
| `bone` | `bone` | Same (string bone name) |
| `rel` | (drop) | TFA-only relative-bone field |
| `pos` | `pos` | Same (Vector) |
| `angle` | `ang` | Renamed |
| `size` | `scale` | Renamed |
| `color` | `color` | Same (Color) |
| `surpresslightning` | `surpresslightning` | Same (typo preserved) |
| `material` | `material` | Same |
| `skin` | `skin` | Same |
| `bonemerge` | `bonemerge` | Same |
| `active` | `active` | Same |
| `bodygroup` | `bodygroups` | Renamed (and table-indexed) |

### A.5 Critical file paths

| File | Path | Role |
|---|---|---|
| CUH base | `lua/weapons/weapon_cuh_base_gun.lua` | Attachment system, VElements, stat cache, melee |
| Parent gun | `lua/weapons/weapon_custom_uh_base_gun.lua` | PrimaryAttack, Reload, AnimSounds, ShootBullets |
| Grandparent | `lua/weapons/weapon_custom_uh_base.lua` | Sights, Movement, Deploy, CalcView, HandleBones |
| Shotgun | `lua/weapons/weapon_custom_uh_base_shotty.lua` | ReloadShotgun, PostShoot pump |
| Melee | `lua/weapons/weapon_custom_uh_base_melee.lua` | PreSwing, PostHit, melee PrimaryAttack |
| Autorun | `lua/autorun/sh_cuh_attachments.lua` | Attachment registration, net strings, save/load |
| UI | `lua/autorun/cl_cuh_ui.lua` | Attachment menu VGUI |
| Extra recoil | `lua/autorun/cuh_extra_recoil.lua` | Camera bone-driven extra recoil |
| Attachment data | `lua/cuh_attachments/*.lua` | Per-attachment definitions |
| WWII attachments | `worldwarii_underhell/lua/cuh_attachments/*.lua` | WWII-specific attachment files (11) |

---

## APPENDIX B: Verification Checklist

Before marking a weapon as ported, verify:

- [ ] Weapon spawns in spawnmenu under correct category
- [ ] Primary fire works (single-shot for semi-auto, sustained for full-auto)
- [ ] Fire rate matches TFA RPM (test by ear or with debug print)
- [ ] Reload animation plays correctly (tactical and empty variants)
- [ ] Reload sounds fire at correct times via AnimSounds timeline
- [ ] ADS works (IronSightsPos applied, ZoomFov reduces FOV)
- [ ] Sprint animation plays when IN_SPEED + moving
- [ ] Bash (E+M1) plays melee anim + deals damage
- [ ] Inspect (E+R) plays inspect anim + sounds
- [ ] Attachments menu opens with C key (if customizable)
- [ ] At least one attachment slot works (swap model, change stats)
- [ ] Attachment save/load persists across weapon switch
- [ ] Dry-fire sound plays when out of ammo
- [ ] For bolt-action: rechamber anim plays after every shot
- [ ] For shotgun: shell-by-shell reload works (one shell per interval)
- [ ] For burst: fires correct burst count, then stops
- [ ] For sniper: 2D scope overlay appears when ADS
- [ ] For LMG: bodygroup-driven ammo belt updates per shot
- [ ] Animations don't break on weapon switch ( holster → redeploy )
- [ ] No `[CUH-DBG]` prints spam the console (after §5.8 fix)
- [ ] No `attempt to call method GetStatL (a nil value)` errors

---

**END OF GAP ANALYSIS DOCUMENT**

**Next steps:**
1. Review this document with the team.
2. Address §5 critical issues (GetStat shadow, SetUHBool dependency, missing attachment files).
3. Begin Tier 1 port (5 simple pistols).
4. After Tier 1, re-evaluate the conversion patterns and refine this document.
