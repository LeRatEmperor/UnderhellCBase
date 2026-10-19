# CUH (Custom UnderHell) Weapon Base — Complete Architecture Report

This is a complete, file-by-file reference for the CUH weapon base located at
`/home/z/my-project/download/custom_uh_base/`. It is intended to let a weapon
author write new SWEPs and attachments on top of the base without re-reading
every file.

All citations use `path:line` notation relative to the addon root
(`/home/z/my-project/download/custom_uh_base/`).

---

## 1. Top-level architecture

The addon is structured around a three-deep SWEP inheritance chain plus an
autorun-side attachment system. There are two parallel registration paths
that exist side-by-side in the codebase; only the `cuh_*` paths are
actually wired up to the live `weapon_cuh_base_gun` base.

### 1.1 Entry points (`lua/autorun/`)

| File | Purpose |
|------|---------|
| `lua/autorun/sh_customuh.lua` (`:1`–`:344`) | **Dead / superseded.** Defines the *v2 architecture plan* `CustomUH` namespace using `customuh_attachments/` folder. Patches SWEP methods into `weapon_custom_uh_base` via `IncludeWithSWEP` + `CompileFile` + `setfenv` (`:169`–`:196`). Adds net strings `CUH2_AttSelect/Sync/Load` (`:252`–`:263`). |
| `lua/autorun/sh_cuh_attachments.lua` (`:1`–`:609`) | **Live.** Defines `CustomUH` namespace (`CustomUH.Version = "3.0"`), registers attachments from `cuh_attachments/*.lua` (`:62`–`:68` for `AddCSLuaFile`, `:70`–`:103` for `include`), networking, save/load, console commands. |
| `lua/autorun/sh_custom_uh_attachments.lua` (`:1`–`:347`) | **Dead / superseded.** Earlier draft that defines `SWEP:InitStatCache` etc. directly on the global `SWEP` table, plus the `CustomUH_AttSelect/Sync` net strings (no `2` in name). |
| `lua/autorun/cl_cuh_ui.lua` (`:1`–`:352`) | **Live.** Client-side customization menu opened with `cuh_menu_key` convar (default `c`), `Think`-based key detector, `IsCUHWeapon` Base-chain walker, `DoSetAttachment` TFA-shadowing bypass, inspect-loop player. |
| `lua/autorun/cuh_extra_recoil.lua` (`:1`–`:188`) | Port of TFA's `tfa_extra_recoil.lua`, gated on `weapon.IsCUHWeapon`, with `sv_cuh_recoil_extra_*` convars. Adds extra kick + screen-shake. |
| `lua/autorun/bo7_1911_sound.lua` (`:1`–`:729`) | 700+ `sound.Add` definitions for the BO7 1911. |
| `worldwiii_underhell/lua/autorun/nz_codww2_sounds.lua` | WWII sound bank (1183 entries, per `CUH_PORTING_GUIDE.md:22`). |

### 1.2 Base SWEP chain

```
weapon_base  (engine)
  └─ weapon_custom_uh_base      (lua/weapons/weapon_custom_uh_base.lua, 1134 lines)
       └─ weapon_custom_uh_base_gun  (lua/weapons/weapon_custom_uh_base_gun.lua, 1124 lines)
            ├─ weapon_custom_uh_base_melee   (256 lines, melee)
            ├─ weapon_custom_uh_base_shotty  (230 lines, shotgun)
            └─ weapon_cuh_base_gun           (lua/weapons/weapon_cuh_base_gun.lua, 1203 lines)
                 └─ weapon_m8a1_scotia, weapon_xm4_bo6, weapon_bo7_1911, weapon_dcm_1911
                 └─ worldwarii_underhell/lua/weapons/uh_codww2_*.lua (90 WWII weapons)
                 └─ worldwiii_underhell/lua/weapons/nz_kate_codww2_*.lua
```

* `weapon_custom_uh_base` (`:16` `SWEP.Base = "weapon_base"`) — the root. Handles
  viewmodel positioning (Inspect/Grenade/Sway/Movement/Sights/Alternative),
  deploy/holster, bone manipulation, hands material swap, ConVar cache,
  `CalcView` (FOV zoom + view bob), `PreDrawViewModel`/`PostDrawViewModel`
  (VElements + VM3D2D), `DrawWeaponSelection`, `HUDShouldDraw`.
* `weapon_custom_uh_base_gun` (`:22` `DEFINE_BASECLASS("weapon_custom_uh_base")`)
  adds the gun layer: `PrimaryAttack`, `ShootBullets`, `ShootGrenade`,
  `SecondaryAttack` (firemode cycling with `+use` held), `Reload` (anim-driven),
  `Think` (reload completion + zoom logic), AnimSounds system, muzzle/shell
  effects, `DrawHUD` (crosshair + 2D scope + ammo counter), `RenderScene`
  hook for RT scopes, `AdjustMouseSensitivity`.
* `weapon_cuh_base_gun` (`:21` `DEFINE_BASECLASS("weapon_custom_uh_base_gun")`)
  adds the customization layer: stat cache, `ApplyAttachments`,
  `SetAttachment`, VElements/WElements lifecycle, bodygroup swap, melee
  attack, camera-bone CalcView override.

### 1.3 Attachment registration

Live registration happens in `lua/autorun/sh_cuh_attachments.lua`:

* **Server addon-load:** `CustomUH._attFiles = file.Find("cuh_attachments/*.lua", "LUA")` (`:62`) and `AddCSLuaFile("cuh_attachments/" .. filename)` (`:64`–`:68`). This runs *before* `RegisterAttachments` so clients receive files before they `include` them.
* **Immediate call:** `CustomUH.RegisterAttachments()` (`:415`) at addon-load time.
* **Think fallback:** `hook.Add("Think", "CUH2_Register", ...)` (`:429`) re-runs `RegisterAttachments` once on the first Think in case the early call ran before the lua files were available on the client.
* **`RegisterAttachments` body** (`:70`–`:103`): for each file, `ATTACHMENT = {}`, `pcall(include, path)`, and if `ATTACHMENT.Name` is truthy, `id = string.StripExtension(filename)`; `ATTACHMENT.ID = id`; `CustomUH.Attachments[id] = ATTACHMENT`; finally `ATTACHMENT = nil`.
* **Client without local addon:** `net.Receive("CUH2_AttList", ...)` (`:271`–`:285`) lets the server push the file list. Server sends via `PlayerInitialSpawn` (`:263`–`:267`).

### 1.4 VElement / WElement management

VElements are managed **inside** `weapon_cuh_base_gun.lua` itself (NOT the
`lua/customuh/sh_velements.lua` file — see §1.5).

* `SWEP:InitVElements` (`lua/weapons/weapon_cuh_base_gun.lua:281`–`:317`) — creates `ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)` per element, snapshots `_defaultActive` and `_defaultSnapshot`.
* `SWEP:DrawVElements(vm)` (`:319`–`:434`) — called from `SWEP:PostDrawViewModel` in the root base. Each frame: applies viewmodel bodygroups (`:332`), sets the model string fresh (`:361`–`:363`), does bonemerge or manual bone positioning, applies material/skin/bodygroups/scale, suppresses lighting if `surpresslightning`, then `model:DrawModel()`.
* `SWEP:CleanupVElements` (`:436`–`:445`) — removes all `_csModel` and sets `_vElementsInit = false`. Called from `Holster`, `OnRemove`, `att:Attach`, `att:Detach`, and the last step of `ApplyAttachments`.
* The base also re-runs `CleanupVElements + InitVElements` at the end of `ApplyAttachments` (`:1030`–`:1031`) so every model swap materializes.

WElements follow the same pattern (`:475`–`:594`). The `DrawWorldModel`
override (`:613`–`:666`) creates a per-weapon `_wmClientModel`
`ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)`, positions it at the
owner's `ValveBiped.Bip01_R_Hand` bone using `LocalToWorld` with
`SWEP.WorldModelOffset`/`SWEP.WorldModelAngle`, and then draws WElements
bonemerged to that model.

### 1.5 The three attachment folders — what's the difference?

There are **three** attachment folders on disk:

| Folder | Used by live system? | Contents |
|--------|---------------------|----------|
| `lua/cuh_attachments/` | **YES** — registered by `sh_cuh_attachments.lua:62`. | ~75 attachment data files for the M8A1/XM4/XM8/BO7 1911/DCM 1911. |
| `lua/customuh_attachments/` | **NO** — registered by `sh_customuh.lua:54` and `sh_custom_uh_attachments.lua:41`, which are dead/superseded. | 18 `xm8_*` duplicates of files also present in `cuh_attachments/`. |
| `worldwarii_underhell/lua/cuh_attachments/` | **YES** if the WWII addon is mounted (separate addon folder; same folder name `cuh_attachments/` so `file.Find("cuh_attachments/*.lua", "LUA")` picks them up too — though they live in a separate addon). | 11 `tfa_codww2_*` attachments (scopes, smoke grenade, akimbo, etc.). |

In practice: **put new attachments in `lua/cuh_attachments/<id>.lua`.**
The `customuh_attachments/` folder is dead code from an earlier architecture
draft (see `ATTACHMENT_ARCHITECTURE.md:18`).

---

## 2. SWEP table fields every weapon author sets

All fields below are read by the base. Quoted defaults are from
`weapon_custom_uh_base.lua` and `weapon_custom_uh_base_gun.lua`.

### 2.1 Identification

| Field | Default | Where read |
|-------|---------|-----------|
| `SWEP.PrintName` | `"Underhell Custom Base"` (`weapon_custom_uh_base.lua:36`) | UI menu header (`cl_cuh_ui.lua:85`), selection menu (`weapon_custom_uh_base.lua:1131`) |
| `SWEP.Category` | `"UnderHell Custom"` (`:37`) | GMod spawnmenu |
| `SWEP.SubCategory` | (none) | Used by WWII weapons (`uh_codww2_thompson.lua:13`) |
| `SWEP.Slot` | `2` (`:57`) | GMod weapon slot |
| `SWEP.SlotPos` | `3` (`:58`) | GMod slot position |
| `SWEP.Spawnable` | `false` (base) — set `true` on actual weapons (`weapon_m8a1_scotia.lua:18`) | Spawnmenu |
| `SWEP.AdminSpawnable` | `false` | Spawnmenu admin flag |
| `SWEP.Base` | required — `"weapon_cuh_base_gun"` for customizable guns | GMod inheritance |
| `SWEP.IsCUHWeapon` | set `true` on any weapon inheriting from `weapon_cuh_base_gun` (`weapon_cuh_base_gun.lua:32`) | Used by `cl_cuh_ui.lua:26` fast-path detection; used by `cuh_extra_recoil.lua:59, 125` |
| `SWEP.Customizable` | (optional) — set `false` to opt a CUH-base weapon out of the C-key menu (`cl_cuh_ui.lua:62`) | Opt-out for non-customizable weapons on the CUH base |
| `SWEP.HoldType` | `"smg"` (`:60`) | Activity translate |
| `SWEP.PassiveAnim` | `"passive"` (`:61`) | Sprint hold type |
| `SWEP.Weight` | `45` (`:63`) | GMod weapon switch priority |
| `SWEP.FiresUnderwater` | `false` (`:62`) | GMod native |

### 2.2 Damage / ammo

| Field | Default | Where read |
|-------|---------|-----------|
| `SWEP.Primary.Sound` | `Sound("weapons/mp5/mp5_fire.wav")` (`weapon_custom_uh_base_gun.lua:73`) | `SWEP:GetShootSound` (`:280`) |
| `SWEP.Primary.SilSound` | same (`:74`) | `SWEP:GetShootSound` |
| `SWEP.Primary.ClipSize` | `30` (`:75`) | reload math, HUD |
| `SWEP.Primary.Ammo` | `"UH_SMG"` (`:76`) | GMod native; also used by `CustomUH.RegisterAmmo` lookup table |
| `SWEP.Primary.DefaultClip` | `30` (`:77`) | GMod native |
| `SWEP.Primary.MinDamage` | `12` (`:78`) | `SWEP:PrimaryAttack` `:332` — `math.random(MinDamage, MaxDamage)` |
| `SWEP.Primary.MaxDamage` | `18` (`:79`) | `:332` |
| `SWEP.Primary.Automatic` | `true` (`:80`) | GMod native |
| `SWEP.Primary.TakeAmmo` | `1` (`:81`) | `:393` `self:TakePrimaryAmmo(self.Primary.TakeAmmo)` |
| `SWEP.Primary.Force` | `15` (`:82`) | bullet `Force` (`:433`) |
| `SWEP.Primary.Spread` | `0.45` (`:83`) | `SWEP:ShootBullets` `:413-419` |
| `SWEP.Primary.Delay` | `0.08` (`:84`) | `:391` `self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)` — fire rate |
| `SWEP.Primary.NumberofShots` | `1` (`:85`) | bullet `Num` (`:427`) |
| `SWEP.Primary.MinRecoil` / `MaxRecoil` | `-0.6 / -1.4` (`:86-87`) | `:339` `util.SharedRandom("uh_recoil", MinRecoil, MaxRecoil)` |
| `SWEP.Primary.KickUp / KickDown / KickHorizontal` | (optional) | Read by `cuh_extra_recoil.lua:67-69` to compute extra kick |
| `SWEP.Primary.StaticRecoilFactor` | (optional) | `cuh_extra_recoil.lua:70` |
| `SWEP.Primary.RPM` | (optional) | `cuh_extra_recoil.lua:94` — falls back to `60 / Primary.Delay` if nil |
| `SWEP.Primary.SpreadMultiplierMax` | (optional) | Cached as `Primary.SpreadMultiplierMax` in `sh_swep_methods.lua:65` |
| `SWEP.Primary.SpreadIncrement` / `SpreadRecovery` | (optional) | `sh_swep_methods.lua:65-66` |
| `SWEP.Primary.IronAccuracy` | (optional) | `sh_swep_methods.lua:65` |
| `SWEP.Primary.Range` | (optional) | `sh_swep_methods.lua:66` |
| `SWEP.PenetrationDepth` | `4` (used in `ShootBullets:444`) | bullet penetration trace |
| `SWEP.Penetration` | `2` (passed to `ShootBullets:336`) | recursion depth for penetration |
| `SWEP.Chambering` | `true` (`:46`) — set `false` on M8A1/XM4/Thompson/Kar98k | `:690-697` — when `true` and `Clip1 > 0` before reload, fills to `ClipSize + 1` |
| `SWEP.TwoHanded` | (optional) | Used by shotgun reload (`:171, 183`) |
| `SWEP.NoShell` | `false` (`:57`) | `:345` — skip shell eject |
| `SWEP.ShellHeat` | `0.8` (`:58`) | `:346` shell effect scale |
| `SWEP.Shell` | `"models/weapons/shell_9mm.mdl"` (`:59`) | shell model |
| `SWEP.Shotgun` | (optional, set `true` on shotgun base `:39`) | `:643` shell bounce sound |
| `SWEP.Secondary.*` | all defaults in `:89-92` | Not really used by guns (secondary = ironsight toggle) |

### 2.3 Sound

| Field | Where read |
|-------|-----------|
| `SWEP.Primary.Sound` | `GetShootSound` (`:281`); `EmitSound` in `PrimaryAttack:389` |
| `SWEP.Primary.SilSound` | `GetShootSound` when `Silenced` NW bool is true |
| `SWEP.SoundChanger` | `EntityEmitSound` hook (`:833-848`) — per-sound-name override map; `false` value = suppress |
| `SWEP.UseQCReloadEvents` | `FireAnimationEvent` (`:850-865`) — when `false`, returns `true` to swallow all QC events; when `true`, plays `event==5004/6004/15` `options` as a sound |
| `SWEP.AnimSounds` | `SWEP:SetupAnimSounds` (`:215-235`), `SWEP:ProcessAnimSounds` (`:237-269`) — frame-timeline sound playback |
| `SWEP.ReloadTable` | `SWEP:Reload` (`:796-819`) — alternate sound system, used only if `UseReloadTable` and no AnimSounds active |
| `SWEP.UseReloadTable` | `true` (`:100`) |

AnimSounds entry format: `{ time = 0.333, sound = "Weapon.MagOut" }` or `{ time = 0.833, sound = {"a.wav","b.wav"}, level = 75, pitch = 100, callback = function(wep) ... end }` (`:215-269`).

ReloadTable entry format: `{ delay = 0.5, sound = "Weapon.MagIn", level = 75, pitch = 100 }` (`:796-816`).

### 2.4 Movement / viewmodel appearance

| Field | Default | Where read |
|-------|---------|-----------|
| `SWEP.ViewModel` | `"models/weapons/v_smg_mp5_pg.mdl"` (`:51`) | precache (`:123`) + GMod native |
| `SWEP.WorldModel` | `"models/weapons/w_smg_mp5_pg.mdl"` (`:52`) | precache (`:124`) + DrawWorldModel (`weapon_cuh_base_gun.lua:618`) |
| `SWEP.ViewModelFOV` | `64` (`:50`) | GMod native |
| `SWEP.ViewModelFlip` | (optional) | GMod native |
| `SWEP.UseHands` | `false` (`:38`) — set `true` on real weapons | GMod c_hands |
| `SWEP.WorldModelOffset` | `Vector(0, -2, -1)` (`weapon_cuh_base_gun.lua:633`) | Local offset from `ValveBiped.Bip01_R_Hand` |
| `SWEP.WorldModelAngle` | `Angle(180, 90, 0)` (`:634`) | Local rotation from hand bone |
| `SWEP.WorldModelSkin` | (optional) | `:622` — applied to `_wmClientModel` |
| `SWEP.VMPos` | (not used — TFA vestigial) | — |
| `SWEP.SwayScale` / `BobScale` | `0 / 0` (`:78-79`) | GMod native (set 0, we do our own) |
| `SWEP.SwayPosition` | `2` (`:81`, `:115`) | `Sway()` `:424` |
| `SWEP.LoweredPos` / `LoweredAng` | `Vector(0,0,0)` (`:82-83`) | safe-mode lowering (used by M8A1 `:26-27`, WWII weapons) |
| `SWEP.AlternativePos` / `AlternativeAng` | (optional, see `:206-254`) | "rest pose" offset applied when not sprinting/aiming/safe |
| `SWEP.RunSightsPos` / `RunSightsAng` | `Vector(0,0,0)` | Sprint position lerp (used by M8A1 `:72-73`) |
| `SWEP.UseViewBob` | (optional, set `false` on `weapon_bo7_1911.lua:77`) | When `false`, `Movement()` returns early (`:443`) — for pose-parameter weapons |
| `SWEP.AnimatedSprint` | `false` | `Movement()` `:505` — when `true` and sprinting, bob is suppressed |
| `SWEP.AnimatedFirstDraw` | `false` (`:85`) | `Deploy` (`:766-779`) — when `true`, plays `first_draw` anim on first equip |

### 2.5 Ironsights

| Field | Default | Where read |
|-------|---------|-----------|
| `SWEP.IronSightsPos` | `Vector(-6, -8, -10)` (`:115`) | `Sights()` `:390-398` |
| `SWEP.IronSightsAng` | `Vector(20, 40, -60)` (`:116`) | `Sights()` `:391-395` |
| `SWEP.IronSightTime` | (optional, e.g. `0.45` on M8A1) | Cached as a stat (`sh_swep_methods.lua:60` / `weapon_cuh_base_gun.lua:207`) — used by attachments |
| `SWEP.IronsightSpeed` | `10` (`:89`) | `Sights()` `:340` base lerp speed |
| `SWEP.IronsightEaseIn` | `1.5` (`:90`) | `Sights()` `:341, 343, 354` |
| `SWEP.IronsightLateralSpeed` | `1.8` (default, not declared) | `Sights()` `:342` |
| `SWEP.IronsightForwardSpeed` | `0.6` (default, not declared) | `Sights()` `:353` |
| `SWEP.IronSightsDipPos` | `Vector(0, -1.5, -2.0)` (`:111`) | `Sights()` `:373` sine-bump dip |
| `SWEP.IronSightsDipAng` | `Angle(3, 0, 0)` (`:112`) | `Sights()` `:374` |
| `SWEP.IronSightsDipScale` | `1.0` (`:113`) — `0` disables | `Sights()` `:370-381` |
| `SWEP.ZoomFov` | `15` (`weapon_custom_uh_base_gun.lua:53`) | `CalcView` `:978-989` — degrees of FOV to subtract while aiming |
| `SWEP.ZoomSpeedIn` / `ZoomSpeedOut` | `15 / 10` (`:54-55`) | `CalcView` `:980-987` |
| `SWEP.Sensitivity` | (optional) | `AdjustMouseSensitivity` (`:983-989`) — when set + zoomed, returns this multiplier |
| `SWEP.Use2DScope` | (optional) | `PreDrawViewModel` (`:1014`) — `render.SetBlend(0)` to hide VM when scoped; `DrawHUD` `:1029` 2D scope overlay |
| `SWEP.ScopeTexture` | (optional) | `RenderScene` hook (`:957-980`) — RT material that gets the scope view written into it |
| `SWEP.ScopeFov` | `8` (default in `RenderScene:971`) | FOV used for RT render |
| `SWEP.ScopeBlur` | (optional) | `PreDrawViewModel` (`:1032`) — blur amount while reloading/scoping |

### 2.6 Attachments table (`SWEP.Attachments`)

```lua
SWEP.Attachments = {
    [1] = { name = "Optic",       atts = { "xm8_sight" },                  default = 1 },
    [2] = { name = "Barrel",      atts = { "xm8_barrel_a", "xm8_barrel_h", ... }, default = 2 },
    [3] = { name = "Pistol Grip", atts = { "xm8_psg_c", ... },             default = 1 },
    [4] = { name = "Stock",       atts = { ... },                          default = 1 },
    [5] = { name = "Muzzle",      atts = {} },                              -- empty, no default
    [6] = { name = "Magazine",    atts = { ... },                          default = 1 },
}
```
(Quoted from `weapon_m8a1_scotia.lua:552-559`)

Per-slot keys:

| Key | Meaning |
|-----|---------|
| `name` (string) | Display name shown in menu header (`cl_cuh_ui.lua:186`) |
| `atts` (table, 1-indexed) | List of attachment IDs (strings matching the filename without `.lua`) |
| `default` (int, optional) | Auto-applied when slot's `sel` is nil. `0` = "None". |
| `forceDefault` (bool, optional) | When `true`, "None" is rejected and snapped back to `default` (`weapon_cuh_base_gun.lua:1061-1065`) |
| `sel` (int, optional) | Currently-selected index — written by `SetAttachment` (`:1067`); nil = use default |

Per-attachment lookup: `wep.Attachments[slot].atts[index]` returns the
attachment ID string, then `CustomUH.Attachments[attId]` returns the
attachment table.

### 2.7 Bodygroup / skin handling

| Field | Where read |
|-------|-----------|
| `SWEP.Bodygroups_V` | `{ [bgIndex] = value }` — applied to viewmodel every frame in `DrawVElements` (`weapon_cuh_base_gun.lua:332`, `sh_bodygroups.lua:65`) |
| `SWEP.Bodygroups_W` | Same for world model (`sh_bodygroups.lua:75`) |
| `SWEP.SightBGs` | `{ main = 1, regular = 0, acog = 1, reddot = 2 }` — `SetSightBodygroup(value)` (`:672-685`) |
| `SWEP.MagBGs` | Same shape, for mag bodygroups (`:687-700`) |
| `SWEP.WMSightBGs` / `SWEP.WMMagBGs` | World-model-specific bodygroup indices (optional) |

### 2.8 Animation-related

| Field | Where read |
|-------|-----------|
| `SWEP.Animations` | Map from lookup-key (string) → sequence name (string) OR list of sequence names OR ACT name (`"ACT_VM_PRIMARYATTACK"`) — see `EasySendWeaponAnim` (`weapon_custom_uh_base.lua:541-559`, gun base `:169-191`) |
| `SWEP.AnimSounds` | Map from anim key → timeline of `{time, sound, ...}` entries (`:215`) |
| `SWEP.ReloadAnim` | When set as a string, used as the reload sequence directly (`:727-731`) |
| `SWEP.ReloadTime` | When set, overrides `vm:SequenceDuration()` for reload length (`:772`) |
| `SWEP.ReloadSpeed` | Multiplier on playback rate (`:773-779`) |
| `SWEP.FireModes` | List of `{ name = "Full-Auto", shoot = function(ply, wep) ..., equip = ..., holster = ... }` (`:71`, `:325-329`) |
| `SWEP.Inspection` | Table of two stages: `{ {pos=Vector, ang=Angle}, {pos=Vector, ang=Angle} }` (`weapon_custom_uh_base_gun.lua:110-113`) — used by `Inspect()` (`weapon_custom_uh_base.lua:259-288`) |
| `SWEP.VM3D2D` | Map of `{ [name] = { bone, pos, ang, size, draw_func } }` (`:1064-1083` in root base) — 2D surfaces on viewmodel bones |
| `SWEP.HideMaterials` | Map of `material_path → true` — `PreDrawViewModel` (`:1022-1029`) hides these via `engine/occlusionproxy` sub-material |
| `SWEP.LeftBones` | Default `{ ["Left_U_Arm"] = Angle(-50, 50, -50) }` (`:120`) — `HandleBones` (`:685-689`) rotates left arm for grenades |

### 2.9 Muzzle / impact / effect overrides

| Field | Default | Where read |
|-------|---------|-----------|
| `SWEP.MuzzleFlashType` | `"default"` (`weapon_custom_uh_base_gun.lua:61`) | `DoMuzzleFlash` (`:570-606`) — `"particle"` branches to ParticleEffectAttach; otherwise `util.Effect("uh_muzzle", fx)` |
| `SWEP.MuzzleFlashParticle` | `""` (`:62`) | `:573-576` |
| `SWEP.MuzzleFlashTexture` | `""` (`:62`) | (read by `uh_muzzle` effect, not Lua) |
| `SWEP.MuzzleFlashColor` | `nil` (`:64`) | (read by effect) |
| `SWEP.MuzzleFlashLightColor` | `nil` (`:65`) | `:586-589` |
| `SWEP.MuzzleFlashScale` | `1` (`:66`) | `:591` |
| `SWEP.MuzzleFlashLightBrightness/Size/Decay` | `4 / 128 / 128` (`:67-69`) | `:590-593` |
| `SWEP.MuzzleAttachment` | (optional, set `"2"` on WWII weapons `uh_codww2_thompson.lua:87`) | Override of `SWEP:GetMuzzle()` (default `1`, `weapon_custom_uh_base_gun.lua:304`) — WWII weapons override `GetMuzzle` to return `2` (`tag_flash`) |
| `SWEP.PumpSound` / `SWEP.ShellSound` | (optional, shotgun) | `weapon_custom_uh_base_shotty.lua:42, 127-130` |
| `SWEP.SmokeWidth` | `30` (`weapon_custom_uh_base_gun.lua:45`) | `CreateSmoke` (`:615`) |

### 2.10 Callback hooks the base calls (and what to override)

These are the SWEP methods defined on the base — child weapons can
override any of them. **Always call `BaseClass.X(self, ...)`** (note: pass
`self` explicitly — see the bug note at `weapon_m8a1_scotia.lua:360-364`).

| Method | File:Line | What the base does | Override guidance |
|--------|----------|---------------------|-------------------|
| `SWEP:Initialize()` | `weapon_custom_uh_base.lua:46` (root), `weapon_custom_uh_base_gun.lua:120` (gun), `weapon_cuh_base_gun.lua:80` (CUH) | Root: `ResetViewState()`. Gun: precaches, sets hold type, inits HUD blend, creates scope RT. CUH: `BaseClass.Initialize(self)` + `timer.Simple(0, function() self:ApplyAttachments() end)`. | Call `BaseClass.Initialize(self)` first; add per-weapon fields after. |
| `SWEP:Deploy()` | `weapon_custom_uh_base.lua:743` | Server: gives bonus ammo if `uh_sv_ammo` convar on. Resets view state. Plays `first_draw` or `draw` anim. Sets `DeployTime` NW float. | Always `return true` (was `false`, fixed `:797`). Call `BaseClass.Deploy(self)` first. |
| `SWEP:Holster(wep)` | `weapon_custom_uh_base.lua:803`, `weapon_cuh_base_gun.lua:451` | CUH adds: `CleanupVElements`, `CleanupWElements`, remove `_wmClientModel`. Then root: reset view state, restore hand material, clear bone manipulation, remove reload timer. | **Pass `self` explicitly** (`weapon_m8a1_scotia.lua:360-364`). Return `true` to allow holster. |
| `SWEP:Think()` | root `:881`, gun `:870`, CUH **does not override** | Root: `cache_convars`, `HandleBones(vm)`, `HandleHands(vm)`, `HandleRunning(ct)`. Gun: also reload completion (`:876-886`), zoom logic (`:888-918`), `ProcessAnimSounds`, `CustomThink` hook. | M8A1/Thompson/Kar98k override and call `BaseClass.Think(self)` first, then add their ironsight/sprint/inspect handlers. |
| `SWEP:PrimaryAttack()` | `weapon_custom_uh_base_gun.lua:318` | `CanPrimaryAttack` gate → `ShootBullets` → `DoMuzzleFlash` + `CreateSmoke` + `CreateShell` + view-punch → animation lookup → `TakePrimaryAmmo` → `PostShoot`. | M8A1/XM4/Thompson/Kar98k wrap with melee/mantle guards. |
| `SWEP:SecondaryAttack()` | `:514` | Hold `+use` + RMB = cycle firemode; otherwise nothing (zoom is handled in Think via `IN_ATTACK2`). | M8A1 wraps with melee/mantle guards. |
| `SWEP:Reload()` | `:702` | `NextReload`/`Reloading`/`Running`/`UH_GrenadeTime`/`DeployTime` gate → `PreReload` → play anim (`reload` or `reload_empty`, with `_sil` variants) → set `ReloadEndTime` → fire AnimSounds OR ReloadTable timers. | Shotgun overrides entirely (`weapon_custom_uh_base_shotty.lua:150`). |
| `SWEP:DrawHUD()` | `:999` (CLIENT) | Crosshair, 2D scope overlay, ammo counter, firemode name, grenades counter. | Melee base replaces with minimal HUD (`weapon_custom_uh_base_melee.lua:242`). |
| `SWEP:DrawWorldModel()` | `weapon_cuh_base_gun.lua:613` | Creates `_wmClientModel`, positions at hand bone, draws receiver + WElements. | — |
| `SWEP:PreDrawViewModel()` | `weapon_custom_uh_base.lua:1013` | Clears sub-materials, applies `HideMaterials`, draws scope blur. | — |
| `SWEP:PostDrawViewModel(vm)` | `:1056` | Calls `InitVElements` (lazy) + `DrawVElements(vm)` + draws `VM3D2D` surfaces. | — |
| `SWEP:CalcView(ply, pos, ang, fov)` | root `:932`, CUH `:111` | Root: view bob + FOV zoom. CUH: camera-bone angle tracking from `SWEP.CameraAttachment`. | Override and call `BaseClass.CalcView(self, ply, pos, ang, fov)` to preserve FOV zoom. |
| `SWEP:GetViewModelPosition(pos, ang)` | `:177` | Chains `Inspect` → `Grenade` → `Sway` → `Movement` → `Sights` → `Alternative`. | M8A1/XM4/Thompson/Kar98k override to add safe-mode lowering + alternative + sprint position lerps (see `weapon_m8a1_scotia.lua:435-494`). |
| `SWEP:HandleRunning(ct)` | `:609` (root), M8A1 also overrides | Sets `Running` NW bool based on `IN_SPEED` + velocity; plays sprint anims; cancels reload. | M8A1/Thompson/Kar98k override to use position-based sprint instead of anim-based. |
| `SWEP:HandleBones(vm, ct)` | `:679` | Left-bone lerp for grenades, silencer bodygroup on the VM. | — |
| `SWEP:HandleHands(vm)` | `:700` | Skin/material swap for hand models. | — |
| `SWEP:FireAnimationEvent(pos, ang, event, options)` | root `:534` (returns `true`, swallows all), gun `:850-865` | When `UseQCReloadEvents`, plays sound for events 5004/6004/15. | — |
| `SWEP:DrawWeaponSelection(x, y, w, h, alpha)` | `:1096` | Spinning world model in selection box + clip count text. | — |
| `SWEP:AdjustMouseSensitivity()` | `:983` | Returns `SWEP.Sensitivity` when zoomed and weapon has scope. | — |
| `SWEP:ShootAnimation()` | `:291` (gun) returns `ACT_VM_PRIMARYATTACK` | M8A1/Thompson/Kar98k override to return `"iron_fire"` when zooming. | — |
| `SWEP:PreReload()` / `PostReload()` | `:824-828` | Empty stubs. | Override for per-weapon reload behavior (shotgun uses `PreReload` to back up clip `:207`, `PostReload` for real-pump `:212`). |
| `SWEP:PostShoot()` | `:484` | Empty stub. | Shotgun overrides for pump-action (`:72`). |
| `SWEP:CustomDeploy()` / `CustomHolster(wep)` / `CustomThink(ct)` | root `:752, 863, 923` | Empty stubs. | Cheap override hooks for child weapons. |
| `SWEP:CustomThink(ct)` is called from `Think()` after base behavior. |

### 2.11 Methods defined only on the CUH layer (`weapon_cuh_base_gun.lua`)

| Method | Line | Purpose |
|--------|------|---------|
| `SWEP:GetEffectiveAttachment(slot)` | `:48` | Resolves `sel` → `default` → `0`, applying `forceDefault`. |
| `SWEP:InitStatCache()` | `:165` | Snapshots `Primary`/`Secondary`/`Animations`/`AnimSounds` (per-instance `table.Copy`), plus `topLevel` fields list (`:204-209`). |
| `SWEP:GetStat(path)` | `:238` | Reads from `_statCache`. |
| `SWEP:SetStat(path, value)` | `:243` | Writes cache + eagerly writes to `self.Primary[field]` or `self[field]`. |
| `SWEP:RestoreStat(path)` | `:255` | Restores from `_statOrigins`. |
| `SWEP:FlushStats()` | `:262` | Bulk write-back from cache (used by `sh_swep_methods.lua:225`; live `weapon_cuh_base_gun.lua` uses eager writes instead). |
| `SWEP:InitVElements()` | `:281` | Creates `ClientsideModel`s for VElements, snapshots `_defaultActive` and `_defaultSnapshot`. |
| `SWEP:DrawVElements(vm)` | `:319` | Per-frame render of all active VElements. |
| `SWEP:CleanupVElements()` | `:436` | Removes all `_csModel`s, sets `_vElementsInit = false`. |
| `SWEP:InitWElements()` | `:475` | Same for WElements (RENDERGROUP_OPAQUE). |
| `SWEP:DrawWElements(owner)` | `:511` | Per-frame render at hand bone. |
| `SWEP:CleanupWElements()` | `:585` | Cleanup. |
| `SWEP:DrawWorldModel()` | `:613` | Receiver + WElements draw. |
| `SWEP:SetSightBodygroup(value)` / `SetMagBodygroup(value)` | `:672` / `:687` | Sets `Bodygroups_V[_W]` for sight/mag bodygroup slots. |
| `SWEP:ApplyBodygroupsVM(vm)` / `ApplyBodygroupsWM(wm)` | `:702` / `:709` | Iterates `Bodygroups_V`/`Bodygroups_W` and sets bodygroups. |
| `SWEP:ResetBodygroups()` | `:716` | Clears bodygroup tables, restores regular sight/mag. |
| `SWEP:ApplyAttachments()` | `:733` | The 6-stage pipeline — see §3.2. |
| `SWEP:SetAttachment(slot, index)` | `:1043` | Sets `sel`, runs `ApplyAttachments`, networks to server (CLIENT) or saves + broadcasts (SERVER). |
| `SWEP:GetActivityEnabled()` | `:1111` | TFA stub, returns `false`. |
| `SWEP:MeleeAttack()` / `DoMeleeTrace()` / `EndMelee()` | `:1120` / `:1162` / `:1198` | Melee state machine (uses `MeleeDamage`, `MeleeRange`, `MeleeDelay`, `MeleeForce`, `MeleeHitDelay`, `MeleeViewPunch`, `MeleeSound`, `MeleeHitSound`, `MeleeMissSound`, `MeleeInterruptReload`). |

---

## 3. Attachment system in detail

### 3.1 Registration table format

A live attachment file looks like this (quoted verbatim from
`lua/cuh_attachments/xm8_barrel_s.lua`):

```lua
if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Compact"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "bo7/scotia/icon/bs"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_b_s.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(255, 100, 100), "-20% Damage Range",
    Color(100, 255, 100), "-20% Iron Sight Time",
    Color(255, 255, 255), "Summary: Improved handling at the",
    Color(255, 255, 255), "cost of reduced effective range.",
}

ATTACHMENT.WeaponTable = {
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["Range"] = function(wep, val) return val * 0.80 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 0.80 end,
}

function ATTACHMENT:Attach(wep)
    local partClass = self.PartClass
    local newModel = self.ModelPath
    if wep.ViewModelElements and wep.ViewModelElements[partClass] then
        if not wep.ViewModelElements[partClass]._original_model then
            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model
        end
        wep.ViewModelElements[partClass].model = newModel
    end
    if wep.WorldModelElements and wep.WorldModelElements[partClass] then
        if not wep.WorldModelElements[partClass]._original_model then
            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model
        end
        wep.WorldModelElements[partClass].model = newModel
    end
    wep:CleanupVElements()
    wep:InitVElements()
end

function ATTACHMENT:Detach(wep)
    -- NEVER CALLED by the base — see §7.2
    ...
end
```

The file is `include`d into a clean environment where global `ATTACHMENT = {}`
has been pre-set (`sh_cuh_attachments.lua:82`). After include,
`CustomUH.Attachments[id] = ATTACHMENT` where `id = string.StripExtension(filename)`
(`:91-94`). The `ATTACHMENT.ID` field is also set.

### 3.2 All keys an attachment table can carry

| Key | Type | Purpose | Example |
|-----|------|---------|---------|
| `Name` | string | **Required.** If nil/empty, attachment is skipped during registration. | `"Compact"` |
| `ShortName` | string | Optional short label for menu button (`cl_cuh_ui.lua:314`). | `"BARREL"` |
| `Icon` | string (material path) or nil | Optional icon for menu button (`:271-280`). Falls back to text. | `"bo7/scotia/icon/bs"` or `"entities/ins2_att_fsi.png"` |
| `Description` | table of alternating `Color, string` pairs | Tooltip text. `cl_cuh_ui.lua:300-305` only extracts the string entries. | `Color(255, 100, 100), "-20% Damage Range"` |
| `ModelPath` | string or nil | Model to swap in for the VElement/WElement keyed by `PartClass`. | `"models/dqr/bo7/scotia/scotia_b_s.mdl"` |
| `PartClass` | string or nil | Key into `SWEP.ViewModelElements` / `SWEP.WorldModelElements` to swap. Common values: `"barrel"`, `"mag"`, `"pgrip"`, `"stock"`, `"muzzle"`, `"trigger"`. | `"barrel"` |
| `ID` | string | Auto-set by the loader (`sh_cuh_attachments.lua:93`). Filename without extension. | `"xm8_barrel_s"` |
| `WeaponTable` | table | Stat/model/animation overrides — see below. | (see below) |
| `RTScope` | table | Optional RT scope config (`cl_att_scope.lua:8-15`): `{ MaterialIndex, ScopeFOV, Reticle, ReticleColor, ReticleScale }` | (stub, not currently used by live attachment files) |
| `Base` | string | Only set when `sh_customuh.lua:57` (the dead code path) is used (`ATTACHMENT.Base = "customuh_base"`). Not used by live system. | — |
| `Attach(wep)` | function | Side-effects: model swap, bodygroup change, scope setup. Called by `ApplyAttachments` Step 5 (`weapon_cuh_base_gun.lua:993-1005`) inside `pcall`. | (see above) |
| `Detach(wep)` | function | Cleanup. **NEVER CALLED by the live base** (see §7.2 and `CUH_PORTING_GUIDE.md:284-294`). | — |

### 3.3 `ATTACHMENT.WeaponTable` shape

The `WeaponTable` is iterated by `ApplyAttachments` Step 5
(`weapon_cuh_base_gun.lua:832-908`). Each top-level key is one of:

| Key | Value type | How it's applied |
|-----|-----------|------------------|
| `"Primary"` | table of `{ stat = value-or-function }` | Iterate sub-keys; for each `subKey`, build `fullPath = "Primary." .. subKey`. If function: `pcall(subVal, self, currentVal)` — only called if `currentVal ~= nil` (`:858-869`). Otherwise direct `SetStat`. |
| `"Secondary"` | same | Same pattern. |
| Any other top-level string path (e.g. `"IronSightTime"`, `"MoveSpeed"`, `"ZoomFov"`, `"IronSightsPos"`) | value or `function(wep, val)` | `:874-890` — same pcall + nil-skip pattern. |
| `"VElements"` | `{ [elemName] = { key=val, ... } }` | Merge per-key into `SWEP.ViewModelElements[elemName]` (`:911-921`). |
| `"WElements"` | same | Same for `SWEP.WorldModelElements` (`:924-936`). |
| `"Bodygroups_V"` / `"Bodygroups_W"` | `{ [bg] = val }` | Merge into `SWEP.Bodygroups_V` / `_W` (`:895-907`). |
| `"Animations"` | `{ [animKey] = string-or-function }` | Merge per-key into `SWEP.Animations`. Functions are `pcall`'d with current value (`:949-966`). |
| `"AnimSounds"` | `{ [key] = table-or-function }` | Same pattern (`:969-986`). |
| `"ViewModelBoneMods"` / `"WorldModelBoneMods"` | (any) | **Currently ignored** — listed in the skip-set (`:834-836`) but no code reads them. |
| Any custom key (e.g. `"xmag2"`) | any | Direct `SetStat(path, value)` — ends up on `self[path]` or `self.Primary[path]`. The `xm8_xmaglrg.lua:17` uses `["xmag2"] = true` as a flag. |

Functions in `WeaponTable` are evaluated with `function(wep, val) return ... end`
where `val` is the current stat value. Returning `nil` or `false` from the
function causes the stat to be skipped (`:860-861, 877-878`).

### 3.4 How slots are defined and attachments claim a slot

The `SWEP.Attachments` table is an array (1-indexed). Each entry is a slot
with `atts = { "attId1", "attId2", ... }`. The slot's `default` index (1-based)
auto-applies on first `ApplyAttachments`. The `forceDefault` flag prevents
the user from picking "None" (index 0).

The attachment doesn't "claim" a slot in its own definition — the weapon
defines which slot each attachment ID appears in. This is the inverse of
TFA's `ATTACHMENT.Slot` design.

### 3.5 Scope attachments — `cl_att_scope.lua`

The scope system in `lua/customuh/cl_att_scope.lua` (129 lines) is a **stub
implementation**. The methods `SWEP:DoRTScope`, `SWEP:SetupRTScope(att)`,
`SWEP:ClearRTScope`, `SWEP:CleanupRTScope` exist but `DoRTScope` is never
called from `PreDrawViewModel` in the live code path.

**The live RT scope system** lives in `weapon_custom_uh_base_gun.lua:931-981`
under `if CLIENT then`:

* A `RenderScene` hook (`:957-980`) renders the scope view into `wep.RenderTarget` whenever `wep:GetUHBool("Zooming")` is true and `wep.ScopeTexture` is set.
* `SWEP:AdjustMouseSensitivity` (`:983`) returns `SWEP.Sensitivity` (default `0.2`) when zoomed.
* Per-weapon setup: `SWEP.ScopeTexture` (a `Material()` of the lens material), `SWEP.ScopeFov` (default `8`), `SWEP.RenderTarget` (created in `Initialize:135-142` with name `"CustomUH_ScopeRT_" .. self:EntIndex()`).

For an actual RT scope attachment example, see `CUH_PORTING_GUIDE.md:227-261`:
the attachment's `Attach(wep)` function uses `CreateMaterial` with
`Unlittwotexture` shader, sets `$basetexture` to the RT and `$texture2` to a
reticle overlay. Critical lessons (`CUH_PORTING_GUIDE.md:244-251`):

* `SetSubMaterial` requires `"!"` prefix for `CreateMaterial` names.
* `render.Clear` has GMod bug #2085 — breaks surface alpha on RTs.
* `render.RenderView` resets the render target to the screen — must re-push RT.
* Transparent areas of reticle PNGs must have WHITE RGB so the multiply blend doesn't darken.

### 3.6 Ammo attachments — `sh_att_ammo.lua`

This 70-line file (`lua/customuh/sh_att_ammo.lua`) is loaded via
`IncludeWithSWEP` from the dead `sh_customuh.lua:124` path — **NOT loaded
by the live system**. The methods it defines (`UpdateClipSize`,
`GetExtendedClipSize`, `GetAmmoDisplayName`) are reachable only if the dead
v2 path runs.

**The live ammo system** is purely stat-cache based: attachments modify
`Primary.ClipSize` directly via `WeaponTable.Primary.ClipSize = function(wep, val) return 60 end`
(see `xm8_xmaglrg.lua:25-29`). The custom ammo *name* is registered in
`sh_cuh_attachments.lua:417-424` via `CustomUH.RegisterAmmo("ar2", "7.62mm", 300)`
etc.; the HUD (`weapon_custom_uh_base_gun.lua:1071`) uses
`language.GetPhrase(ammotype.."_ammo")` for display, not `CustomUH.GetAmmoName`.

The `xm8_xmaglrg.lua:37-51` attachment defines a `SyncClipToMax(wep)` helper
that tops up the weapon's clip to its new max after the mag-size change.

### 3.7 Attachment persistence — `sh_att_save.lua`

`lua/customuh/sh_att_save.lua` (185 lines) is also part of the dead v2
system (`IncludeWithSWEP` from `sh_customuh.lua:125`). Its hooks
(`WeaponDeployed`, `WeaponHolstered`) are NOT real GMod hooks (see
`docs/worklog.md:228` "WeaponDeployed is NOT a standard GMod hook").

**The live save/load system** is in `sh_cuh_attachments.lua:124-234`:

* Save path: `data/cuh_saves/<steamid64>.json` (`:125, :129`)
* JSON format: `{ "weapon_m8a1_scotia": { "1": 1, "2": 2, "3": 1, ... }, "weapon_xm4_bo6": { ... } }` (`sh_att_save.lua:8-13` documents the format)
* `CustomUH.LoadAttachments(wep, ply)` (`sh_cuh_attachments.lua:132-185`): reads JSON, finds `data[wep:GetClass()]`, validates each slot/index, sets `sel`, then `wep:ApplyAttachments()` + sends `CUH2_AttLoad` net message to the player.
* `CustomUH.SaveAttachments(wep, ply)` (`:187-225`): writes current `sel` per slot to JSON.
* `CustomUH.SaveAllAttachments(ply)` (`:227-234`): iterates `ply:GetWeapons()`.
* **Hooks** (`:382-404`):
  * `PlayerSwitchWeapon` → `CustomUH.LoadAttachments(newWep, ply)` (deferred to next tick) — fires only for `IsCUHWeapon == true` weapons.
  * `PlayerDeath` → `SaveAllAttachments(ply)`.
  * `PlayerDisconnected` → `SaveAllAttachments(ply)`.

### 3.8 Attachment UI — `cl_cuh_ui.lua`

The live menu is `lua/autorun/cl_cuh_ui.lua` (352 lines). Summary:

* **Keybind:** `cuh_menu_key` convar (default `"c"`) registered at `sh_cuh_attachments.lua:43-45`. `Think` hook `CUH2_MenuKey` (`:333-346`) polls `input.IsKeyDown` and toggles the menu.
* **Console command fallback:** `cuh_menu` (`:349-351`).
* **Weapon eligibility:** `IsCUHWeapon(wep)` (`:23-41`) — fast path on `wep.IsCUHWeapon == true`, otherwise walks `SWEP.Base` chain looking for `"cuh_base"`. Also respects `wep.Customizable == false` opt-out.
* **Menu layout:** `DFrame` 640×520, `DScrollPanel` per slot, each slot has a header `DPanel` + row `DPanel`. Each row has a "None" `DButton` (50×50) plus per-attachment `DButton`s (50×50). Icon via `Material(att.Icon, "smooth")` if set, else text fallback.
* **Click handler:** `DoSetAttachment(slot, index)` (`:226-244`) — uses `debug.getinfo` to detect if `wep.SetAttachment` is shadowed by TFA, in which case it bypasses and calls `net.Start("CUH2_AttSelect")` directly. Otherwise calls `wep:SetAttachment(slot, index)` (the live CUH method).
* **Inspect loop:** When menu is open and weapon has `CUHInspectOnMenu = true` and an `inspect` animation, plays the inspect animation in a loop via `Think` hook `CUH2_InspectLoop` (`:121-154`).
* **TFA suppression:** `OnContextMenuOpen` hook (`:44-46`) suppresses GMod's context menu while our menu is open.
* **Debug commands:** `cuh_debug`, `cuh_apply`, `cuh_set <slot> <index>`, `cuh_reset`, `cuh_save`, `cuh_load` (defined in `sh_cuh_attachments.lua:443-609`).

---

## 4. VElements / WElements / bodygroups

### 4.1 Full VElement example

Quoted verbatim from `weapon_m8a1_scotia.lua:504-533`:

```lua
SWEP.ViewModelElements = {
    ["barrel"] = {
        type = "Model", model = "models/dqr/bo7/scotia/scotia_b_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[2]=1, [1]=1}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["mag"] = {
        type = "Model", model = "models/dqr/bo7/scotia/scotia_m_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=1}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["default_stock"] = {
        type = "Model", model = "models/dqr/bo7/scotia/scotia_s_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=0}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["pgrip"] = {
        type = "Model", model = "models/dqr/bo7/scotia/scotia_p_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=0}, bonemerge = true,
        active = true, _defaultActive = true,
    },
}

SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)
```

**Important:** `WorldModelElements` MUST be `table.Copy`'d — sharing the
same table causes `InitVElements` and `InitWElements` to clobber each
other's `_csModel` fields (different render groups). See comment at
`weapon_m8a1_scotia.lua:535-538`.

### 4.2 Per-element keys

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `type` | string | `"Model"` | Element type. `"Model"` (drawn via `ClientsideModel:DrawModel`) or `"Sprite"` (`render.DrawSprite`). |
| `model` | string | required for `Model` | `.mdl` path. Re-set every frame in `DrawVElements` (`weapon_cuh_base_gun.lua:361-363`) so attachment model swaps take effect. |
| `bone` | string | `""` (empty → bonemerge-only) | Viewmodel bone name to attach to (for non-bonemerged elements). |
| `pos` | Vector | `Vector(0,0,0)` | Offset from bone position: `pos.x = right`, `pos.y = forward`, `pos.z = up`. |
| `ang` | Angle | `Angle(0,0,0)` | Rotation: `.p` rotates around right, `.y` around up, `.r` around forward. Note: this is `Angle`, not Vector. (TFA's `angle` was renamed to `ang`.) |
| `scale` | Vector | `Vector(1,1,1)` | Model scale. (TFA's `size` was renamed to `scale`.) |
| `material` | string | `""` | Material override path. |
| `skin` | int | `0` | Skin index. |
| `bodygroups` | table `{ [bg] = val }` | `{}` | Per-bodygroup overrides. (TFA's `bodygroup` was renamed to `bodygroups`.) |
| `bonemerge` | bool | `false` | If `true`, parents to the VM with `EF_BONEMERGE` and lets the engine drive bone positions. |
| `surpresslightning` | bool | `false` | If `true`, wraps `DrawModel` in `render.SuppressEngineLighting(true/false)`. (Typo preserved from TFA.) |
| `active` | bool | `false` | Whether the element is currently drawn. Toggled by attachments. |
| `_defaultActive` | bool | set by `InitVElements` | Snapshot of `active` taken on first init (`weapon_cuh_base_gun.lua:288-290`). |
| `_defaultSnapshot` | table | set by `InitVElements` | Full `table.Copy` of the element (minus `_defaultSnapshot`, `_csModel`) for restore-on-detach (`:294-299`). |
| `_original_model` | string | set by `att:Attach` | Some attachments store the default model string here for `Detach` to restore. (See `xm8_barrel_s.lua:31`.) |
| `_csModel` | `ClientsideModel` | set by `InitVElements` | The actual GMod clientside entity, created with `ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)`. |

For Sprite elements (`sh_velements.lua:175-193`): `material` (string),
`size` (number, default `4`), `color` (Color, default `Color(255,255,255,255)`).

### 4.3 How bones are picked and positions interpreted

In `DrawVElements` (`weapon_cuh_base_gun.lua:383-401`):

* If `bonemerge = true`: `model:SetParent(vm)`, `model:AddEffects(EF_BONEMERGE)`. The engine matches bones by name. The `pos` offset is applied in **viewmodel world space** (`:372-378`), not bone-local space — closing small gaps between parts. Angles are not applied.
* If `bonemerge = false` (or nil): `vm:LookupBone(elem.bone or "")` → `vm:GetBonePosition(boneId)` → manual `pos + ang` math using bone's right/forward/up vectors.

The WElement system (`:511-582`) uses the **owner's** bone (`ValveBiped.Bip01_R_Hand`) for non-bonemerged, or parents to `self._wmClientModel` for bonemerged. The owner is passed as the first arg.

### 4.4 Renderer hooks

* `SWEP:PostDrawViewModel(vm)` (`weapon_custom_uh_base.lua:1056`) — called by GMod after the viewmodel is drawn. Calls `InitVElements` (lazy) + `DrawVElements(vm)` + iterates `VM3D2D` surfaces.
* `SWEP:DrawWorldModel()` (`weapon_cuh_base_gun.lua:613`) — called by GMod for world model. Creates `_wmClientModel` lazily, positions it, calls `DrawWElements(owner)`. **Does NOT** call `BaseClass.DrawWorldModel` — fully overrides.
* `SWEP:PreDrawViewModel()` (`weapon_custom_uh_base.lua:1013`) — clears sub-materials, applies `HideMaterials`, draws scope blur. Runs BEFORE the engine draws the viewmodel.
* `SWEP:Think()` (root `:881`) — `HandleBones` applies `LeftBones` rotation + silencer bodygroup on the viewmodel.
* `SWEP:DrawWorldModelTranslucent` — **not overridden** in the base.
* `SWEP:PreDraw` — **not overridden** in the base.

### 4.5 Bodygroups per-attachment

`sh_bodygroups.lua` (99 lines) defines the bodygroup system. Loaded via
the dead `sh_customuh.lua:120` `IncludeWithSWEP` path — **but the same
methods are also defined directly in `weapon_cuh_base_gun.lua:668-727`**,
so they're available live.

The two ways attachments set bodygroups:

1. **WeaponTable-driven** (preferred for bodygroup swaps via `WeaponTable.Bodygroups_V` / `Bodygroups_W`):
   ```lua
   ATTACHMENT.WeaponTable = {
       ["Bodygroups_V"] = { [2] = 0 },   -- set bodygroup 2 to value 0 on viewmodel
       ["Bodygroups_W"] = { [2] = 0 },
       ["VElements"] = {
           ["barrel"] = { ["bodygroups"] = { [1] = 0, [2] = 0 } },  -- set bodygroups ON THE CSMODEL
       },
   }
   ```
   (Quoted from `xm4_sight.lua:13-35`.)
   `Bodygroups_V`/`_W` are applied to the VM/WM directly every frame by `ApplyBodygroupsVM`/`ApplyBodygroupsWM`. The `VElements[name].bodygroups` are applied to the per-element `_csModel` in `DrawVElements:408-410`.

2. **Att:Attach-driven** (preferred for sight/mag swaps that go through named indices):
   ```lua
   function ATTACHMENT:Attach(wep)
       wep:SetSightBodygroup(wep.SightBGs.acog)
       wep:SetMagBodygroup(wep.MagBGs.ext_mag)
   end
   ```
   Where `SWEP.SightBGs = { main = 1, regular = 0, acog = 1, reddot = 2 }` and `SWEP.MagBGs = { main = 2, regular = 0, fast = 1, ext = 2 }`.

`ResetBodygroups` (`weapon_cuh_base_gun.lua:716-727`) is called at the start of `ApplyAttachments` Step 4. It clears `Bodygroups_V`/`_W` and restores `SightBGs.regular` / `MagBGs.regular`.

---

## 5. Damage / fire / animation pipeline

### 5.1 Trace attack vs. hitscan vs. projectile

The base uses **hitscan** via `Entity:FireBullets` (`weapon_custom_uh_base_gun.lua:461`).
Each bullet is configured with `bullet.Num`, `bullet.Src`, `bullet.Dir`,
`bullet.Spread`, `bullet.Tracer = 1`, `bullet.TracerName = "uh_tracer"`,
`bullet.Force`, `bullet.Damage`, `bullet.AmmoType`, `bullet.Callback`.

The callback (`:436-458`) handles penetration: traces from `HitPos - Normal * PenetrationDepth` to `HitPos`; if the trace isn't `AllSolid` and `Fraction > 0` and `uh_sv_penetration` is on, recursively fires `ShootBullets(trace.HitPos, buldir, dmg*0.5-0.6, tries-1)`.

Projectiles exist for grenades: `SWEP:ShootGrenade(force)` (`:467-482`)
creates a `sent_mgl_grenade` entity, sets owner, applies force.

### 5.2 Fire-call sequence

Quoted from `SWEP:PrimaryAttack` (`weapon_custom_uh_base_gun.lua:318-396`):

```lua
function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end                       -- :319
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if SERVER or iftp then
        local mode = self.FireModes[self:GetNWInt("FireMode")]            -- :325
        if mode and mode.shoot then
            local res = mode.shoot(self.Owner, self)
            if res then return end
        end
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)  -- :332
        if self:GetNWBool("Silenced") then dmg = math.Round(dmg * 0.95) end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end

    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
        * (self:GetUHBool("Zooming") and 0.35 or 1)                       -- :339

    if SERVER or (CLIENT and iftp) then
        self:DoMuzzleFlash()                                              -- :343
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32))
        if not self.NoShell then self:CreateShell(self.ShellDelay or 0, self.ShellHeat) end
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))
    end

    self.Owner:ViewPunch(Angle(recoil, 0, 0))                            -- :351

    self:SendWeaponAnim(ACT_VM_IDLE)
    local baseAct = ACT_VM_PRIMARYATTACK
    if self.ShootAnimation then baseAct = self:ShootAnimation() end
    -- ... build lookupKey based on silenced/zooming ...
    self:EasySendWeaponAnim(lookupKey, fallbackActivity)                -- :377

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then vm:SetCycle(0); vm:SetPlaybackRate(1) end

    self.Owner:SetAnimation(PLAYER_ATTACK1)                              -- :385
    self.Owner:MuzzleFlash()                                             -- :386

    local fireSound = self:GetShootSound()
    self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)                   -- :389

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)              -- :391
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)                          -- :393
    self.NextReload = CurTime() + 0.5
    self:PostShoot()                                                     -- :395
end
```

So the sequence is:
1. `CanPrimaryAttack` gate (checks firemode, deploy time, running, reloading, clip)
2. Fire-mode-specific `shoot` hook (if defined)
3. `ShootBullets` — `FireBullets` with penetration callback
4. Recoil: `SetEyeAngles + Angle(recoil,0,0)` + `ViewPunch`
5. `DoMuzzleFlash` + `CreateSmoke` + `CreateShell`
6. `EasySendWeaponAnim(lookupKey, fallbackActivity)` — picks animation
7. `Owner:SetAnimation(PLAYER_ATTACK1)` — third-person shoot anim
8. `Owner:MuzzleFlash()` — engine muzzle flash
9. `EmitSound(fireSound)` — fire sound
10. `SetNextPrimaryFire`/`SetNextSecondaryFire` to `CurTime() + Primary.Delay`
11. `TakePrimaryAmmo`
12. `PostShoot` (overridden by shotgun for pump-action)

### 5.3 RPM / CycleTime / FireDelay

The base uses `SWEP.Primary.Delay` (in seconds) as the fire interval.
`SetNextPrimaryFire(CurTime() + self.Primary.Delay)` (`:391`).

To convert RPM → Delay: `SWEP.Primary.Delay = 60 / RPM` (e.g. `weapon_m8a1_scotia.lua:51` `60 / 900`).

There is no separate `CycleTime`/`FireDelay` field. `FireRate` is a top-level stat (`sh_swep_methods.lua:58`) but is **not read by the gun base** — it's only there for attachment functions to mutate.

### 5.4 Reloads

`SWEP:Reload` (`:702-822`) is **animation-driven**:

* Gating: `NextReload < ct`, not `Running`, not `Reloading`, no `+use`, `UH_GrenadeTime < ct`, `DeployTime < ct`.
* Clip-low + has-ammo check.
* Picks `reload` (partial) or `reload_empty` (clip1 == 0) animation, with `_sil` variants if silenced.
* Animation choice: tries `self.Animations[emptyKey.."_sil"]` → `self.Animations[emptyKey]` → `self.Animations[normalKey.."_sil"]` → `self.Animations[normalKey]`. Picks a random variant if the value is a table.
* `AnimTime = self.ReloadTime or vm:SequenceDuration()`. If `ReloadSpeed ~= 1`, divides `AnimTime` by speed and sets `vm:SetPlaybackRate(speed)`.
* Sets `_reloadEndTime = ct + AnimTime`, `Reloading = true`, `Zooming = false`, `ReloadTime` NW float, `ReloadEndTime` NW float.
* AnimSounds: `SetupAnimSounds(reloadAnimKey, pickedVariant)` if a key was picked.
* ReloadTable fallback: if `UseReloadTable` and no AnimSounds active, iterates `self.ReloadTable` and `timer.Simple(tbl.delay * scale, ...)` for each sound.

`SWEP:Think` (`:870-926`) handles reload completion:
```lua
if self:GetUHBool("Reloading") then
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        if self.ReloadSpeed and self.ReloadSpeed ~= 1 then
            vm:SetPlaybackRate(self.ReloadSpeed)
        end
        if self._reloadEndTime and ct >= self._reloadEndTime then
            self:_FinishReload()  -- sets Reloading=false, PostReload, refills clip from reserves
        end
    end
end
```

`_FinishReload` (`:672-700`) sets `Reloading = false`, calls `PostReload`, then on SERVER refills the clip from the owner's reserve, respecting `Chambering` (one extra round if `Clip1 > 0` before reload).

### 5.5 Blowback

There is **no built-in blowback system** in the CUH base. The viewmodel
must handle its own recoil via animations (`shoot`/`iron_fire` sequences).
The `cuh_extra_recoil.lua` addon (`lua/autorun/cuh_extra_recoil.lua`)
provides extra view-punch recoil based on `Primary.KickUp + KickDown + KickHorizontal + StaticRecoilFactor`, modified by crouching/ironsighting, but this is view-recoil only, not model-recoil.

### 5.6 Ironsights toggle

Ironsights are toggled by **right-mouse-button (IN_ATTACK2)** but NOT in
`SWEP:SecondaryAttack` — they're handled in `SWEP:Think`
(`weapon_custom_uh_base_gun.lua:888-918`):

```lua
local wantsToZoom = self.Owner:KeyDown(IN_ATTACK2)
    and not preventZoom
    and not self.Owner:KeyDown(IN_USE)
    and self:GetNWInt("FireMode") ~= 0

if isZooming and preventZoom then
    self:SetUHBool("Zooming", false)
    -- play ironsight_off sound
elseif isZooming and not wantsToZoom then
    self:SetUHBool("Zooming", false)
    -- play ironsight_off sound
elseif not isZooming and wantsToZoom then
    self:SetUHBool("Zooming", true)
    -- play ironsight_on sound
end
```

Holding `+use` (`IN_USE`) and pressing RMB cycles firemodes in
`SWEP:SecondaryAttack` (`:514-563`).

### 5.7 Inspect key

The "inspect" key is **`+use + reload`** (IN_USE + IN_RELOAD pressed) —
see `weapon_m8a1_scotia.lua:307-316`:

```lua
function SWEP:HandleInspect()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then
        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then
            self:SetNW2Bool("Inspecting", true)
            self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
        end
    end
end
```

Note: this consumes the IN_USE+IN_RELOAD combo, so you can't reload with
`+use` held. The M8A1 wraps `SWEP:Reload` to early-return if `+use` is held
(`weapon_m8a1_scotia.lua:346`).

There is also a separate "inspect on menu open" feature: when the C-key
menu opens and `SWEP.CUHInspectOnMenu = true`, the inspect animation loops
(`cl_cuh_ui.lua:109-155`).

---

## 6. State persistence / network vars

### 6.1 `NetworkVar` / `SetNW*` variables the base uses

The base uses the legacy `SetNWBool/Float/Int` API (NOT `NetworkVar`/`SetupDataTables`).
Here is every networked variable touched:

| Variable | Type | Set by | Read by |
|----------|------|--------|---------|
| `FireMode` | Int | `Initialize` `:128` (`SetNWInt("FireMode", 1)`), `SecondaryAttack` `:555` (cycle), `Deploy` if safe→1, `Holster` if safe→1 | `HandleRunning`, `CanPrimaryAttack`, `DrawHUD`, `Movement`, `Alternative`, `GetViewModelPosition` |
| `DeployTime` | Float | `Deploy` `:784` (`SetNWFloat("DeployTime", CurTime() + animtime)`); M8A1 sets to `0` after deploy anim | `Inspect`, `CanPrimaryAttack`, `Reload`, `Think` (zoom gate), `DrawHUD` |
| `ReloadTime` | Float | `Reload` `:793` | `DrawHUD` reload progress bar |
| `ReloadEndTime` | Float | `Reload` `:794`, shotgun `:201` | `Think` reload completion, `DrawHUD` |
| `FirstTimeDeployed` | Bool | `Deploy` `:767` | `Deploy` (gate first-draw anim) |
| `FirstDrawPlaying` | Bool | `Deploy` `:776`, `:778` (timer), `Holster` `:847` | `HandleRunning` `:616` (skip while first-draw playing) |
| `Silenced` | Bool | (set by external silencer code or attachment) | `HandleBones`, `GetShootSound`, `DoMuzzleFlash`, `PrimaryAttack` (damage), `HandleRunning` (anim choice) |
| `SilenceTime` | Float | (external) | `HandleBones` `:690` |
| `UH_GrenadeTime` | Float | (player NW var, set by grenade SWEP) | `Grenade` `:296`, `Reload` gate `:709`, `Think` zoom gate `:896` |
| `UH_ArmTime` | Float | (player NW var) | `HandleBones` `:683` (left-arm lerp for grenade throw) |
| `UH_ArmGone` | Bool | (player NW var) | `HandleBones` `:683` |
| `UH_Flashlight` | Bool | (player NW var, shotgun `:168-179` clears it) | `Think` zoom gate `:892` |
| `UH_Flare` | Bool | (player NW var) | `Think` zoom gate `:891` |
| `Inspecting` | NW2Bool | `HandleInspect` `:312` (`SetNW2Bool`) | (read by external code for visual effects) |
| `BO3_IsVaulting` / `BO3_IsMantling` | NW2Bool | (player NW2 var, set by parkour addon) | M8A1/Thompson/Kar98k Think |

The CUH-specific state vars are all on `self` (not networked):
`_statCache`, `_statOrigins`, `_animationsOrigin`, `_animSoundsOrigin`, `_vElementsInit`, `_wElementsInit`, `_wmClientModel`, `_meleeActive`, `_meleeHitTime`, `_meleeHitDone`, `_meleeEndTime`, `_nextMelee`, `_mantleActive`, `_mantleEndTime`, `_reloadFinished`, `_reloadEndTime`, `_ironBlendLat`, `_ironBlendFwd`, `_zoomBlend`, `_altFactor`, `_sprintFactor`, `_uhLower`, `_sprintFade`, `_animSoundTimeline`, `_animSoundIndex`, `_animSoundStartTime`, `_animSoundPlaybackRate`, `_animSoundActive`, etc.

The base also uses `self:SetUHBool(...)` and `self:GetUHBool(...)` for
`Running`, `Zooming`, `Reloading` — these are defined in the parent
Underhell base (not in this addon's lua/) and resolve to `SetNWBool` /
`GetNWBool` calls. The parent Underhell base is not in this repo's
lua/weapons/ folder; it's `weapon_uh_base.lua` per `CUH_PORTING_GUIDE.md:558`
("Never modify `weapon_uh_base.lua` — it's the old base").

### 6.2 Client/server boundary

* **SERVER only:** `Deploy` ammo give (`:747`), `ShootGrenade` entity spawn (`:469`), `_FinishReload` clip refill (`:689`), `CustomUH.SaveAttachments` (`sh_cuh_attachments.lua:187`), `CustomUH.LoadAttachments` net send (`:176-184`), `CUH2_AttSelect` receiver (`:289-336`), `CUH2_AttList` sender (`:253-260`).
* **CLIENT only:** All VElement/WElement `ClientsideModel` creation (`InitVElements:286`, `InitWElements:480`), `DrawVElements`, `DrawWElements`, `DrawWorldModel`, `DrawHUD`, `CalcView`, `PreDrawViewModel`, `PostDrawViewModel`, `RenderScene` hook, the customization menu (`cl_cuh_ui.lua`), `CUH2_AttSync`/`CUH2_AttLoad` receivers.
* **SHARED:** `Initialize`, `Think`, `PrimaryAttack`, `SecondaryAttack`, `Reload`, `Holster`, `ApplyAttachments`, `SetAttachment`, `InitStatCache`, `GetStat`/`SetStat`/`RestoreStat`, all the AnimSounds methods. Many gate on `if SERVER or iftp then` for prediction.

### 6.3 Net messages registered by the base

| Net string | Registered | Sender | Receiver | Payload |
|-----------|-----------|--------|----------|---------|
| `CUH2_AttSelect` | `sh_cuh_attachments.lua:240` (also `sh_customuh.lua:262`) | CLIENT → SERVER (`SetAttachment` `weapon_cuh_base_gun.lua:1078`) | SERVER (`sh_cuh_attachments.lua:289-336`) | `Entity(wep)`, `UInt8(slot)`, `UInt8(index)` |
| `CUH2_AttSync` | `sh_cuh_attachments.lua:241` | SERVER broadcast (`SetAttachment` `:1097-1101`, server receiver `:330-334`) | CLIENT (`sh_cuh_attachments.lua:340-354`) | Same as AttSelect |
| `CUH2_AttLoad` | `sh_cuh_attachments.lua:242` | SERVER → single player (`LoadAttachments` `:176-184`) | CLIENT (`sh_cuh_attachments.lua:356-370`) | `Entity(wep)`, `UInt8(count)`, then `count × (UInt8 slot, UInt8 index)` |
| `CUH2_AttList` | `sh_cuh_attachments.lua:243` | SERVER → single player on `PlayerInitialSpawn` (`:263-267`) | CLIENT (`:271-285`) | `UInt8(n)`, then `n × String(filename)` |
| `UH_Select_Fire` | (defined in parent base, used in `SecondaryAttack:529, 542`) | SERVER broadcast | CLIENT | `Float(firemode)`, `Bool(isEquip)` |
| `UH_Flashlight` | (parent base) | shotgun `:176-179` | CLIENT | `Entity(player)`, `Bool(false)` |
| `CustomUH_AttSelect` / `CustomUH_AttSync` | `sh_custom_uh_attachments.lua:220-221` (DEAD) | (dead) | (dead) | — |

---

## 7. Known bugs / TODOs / footguns

### 7.1 `TODO`/`FIXME`/`WARNING` comments in the base

Searches for explicit markers turned up these notable comments:

* `weapon_custom_uh_base.lua:797` — `return true  -- FIXED: was false` (Deploy must return true).
* `weapon_custom_uh_base.lua:850-856` — Nil-guard comment for `ClearAnimSounds` ("Guard against the nil case so holster never errors").
* `weapon_custom_uh_base_gun.lua:405` — `-- FIXED: local spread (was undeclared global)`.
* `weapon_custom_uh_base_gun.lua:803-805` — `-- FIXED: was 'return' (exited entire Reload function)` (the ReloadTable loop).
* `weapon_cuh_base_gun.lua:145-150` — `-- NOTE: Do NOT override Deploy here` (would interfere with reload state machine; this was a regression that was fixed and re-fixed multiple times).
* `weapon_cuh_base_gun.lua:156-164` — Comment about why `table.Copy(self.Primary)` must happen inside `InitStatCache` (not in a separate helper), to prevent class-table bleed.
* `weapon_cuh_base_gun.lua:856-857` — `-- Wrap in pcall as a final safety net so a buggy attachment function never breaks the whole pipeline` (the bug fixed in commit `cuh-attachment-fix`).

### 7.2 `Detach()` is NEVER CALLED by the base

`CUH_PORTING_GUIDE.md:284-294` is explicit:

> **Critical: `Detach()` is NEVER CALLED.** The base only calls `RestoreStat` + `Attach` for the new selection. To clean up, use the `ApplyAttachments` override pattern in `cuh_rt_scope_render.lua`:
> ```lua
> wep.ApplyAttachments = function(self)
>     -- PURGE state BEFORE calling original
>     self.Sensitivity = 0.8
>     self.ScopeTexture = nil
>     self._reflexActive = false
>     -- Then call original
>     origApply(self)
> end
> ```

The CUH base's `ApplyAttachments` (`weapon_cuh_base_gun.lua:733-1037`) does:

1. Restore all stats from `_statOrigins`
2. Restore `Animations`/`AnimSounds` from origin snapshots
3. Restore each VElement from `_defaultSnapshot`
4. Restore each WElement from `_defaultSnapshot`
5. `ResetBodygroups()`
6. Apply each equipped attachment's `WeaponTable` + `att:Attach(wep)`

So the only cleanup path for attachment state is the `ApplyAttachments`
override pattern (purge in override, then call original). Detach functions
defined in attachment files are dead code.

### 7.3 Recursion bugs

`CUH_PORTING_GUIDE.md:367-388` documents a critical pattern that recurses:

```lua
-- BROKEN: reads self._prev at CALL TIME
wep._prev = wep.SomeMethod
wep.SomeMethod = function(self)
    self._prev(self)  -- after 2nd Attach(), _prev = our own closure → ∞
end
```

The correct pattern uses a local upvalue + idempotent guard:
```lua
if not wep._hooked then
    wep._hooked = true
    local prev = wep.SomeMethod  -- LOCAL upvalue, captured once
    wep.SomeMethod = function(self, ...)
        if prev and prev ~= self.SomeMethod then
            prev(self, ...)
        end
        -- new code
    end
end
```

### 7.4 `BaseClass` vs local capture

`CUH_PORTING_GUIDE.md:421-428`:

> `local orig = SWEP.HandleRunning  -- nil!` (when the method isn't on this class, it's on the parent)
> Correct: `BaseClass.HandleRunning(self, ct)` (resolves at call time).

### 7.5 Holster NULL entity crash

`weapon_m8a1_scotia.lua:360-364`:
> CRITICAL: must pass `self` explicitly. Using `BaseClass.Holster(wep)` passes `wep` as `self`, so when entering a vehicle (wep == NULL) the parent Holster does self.Owner on a NULL entity and throws "Tried to use a NULL entity!".

The root base `Holster` (`weapon_custom_uh_base.lua:803-865`) defensively
guards with `if not IsValid(self) then return true end` and
`if not IsValid(self.Owner) then return true end`.

### 7.6 Realm mismatches / prediction gates

The worklog (`docs/worklog.md:206-217`) notes:
> RELOAD BROKEN: My Deploy override (timer.Simple(0, ApplyAttachments)) interfered with the parent base's deploy/reload state machine. ApplyAttachments resets Primary.ClipSize/Delay/etc. on the next tick, which confused the reload timer.

The fix was to call `ApplyAttachments` from `Initialize` (deferred to next
tick) instead of `Deploy` (`weapon_cuh_base_gun.lua:80-90`).

### 7.7 Issues spotted during this audit

* `weapon_cuh_base_gun.lua:734-735, 811, 816, 823, 826, 829, 994, 1000, 1004, 1023, 1026, 1030, 1034, 1036` — there are **~30 `print("[CUH-DBG]...")`** statements left in production code. These should be wrapped in a debug convar or removed.
* `sh_customuh.lua` and `sh_custom_uh_attachments.lua` are dead code that nevertheless runs at addon-load. They register `CustomUH_AttSelect`/`CustomUH_AttSync` net strings (`sh_custom_uh_attachments.lua:220-221`) and define duplicate `SWEP:InitStatCache`/`ApplyAttachments`/`SetAttachment` methods on the global `SWEP` table. If a future refactor accidentally calls one of these duplicate methods, behavior will silently differ from the live `weapon_cuh_base_gun.lua` versions.
* `sh_customuh.lua:54` registers from `customuh_attachments/` folder — but the actual attachment files live in `cuh_attachments/` and `customuh_attachments/` (both folders exist on disk). Only `cuh_attachments/` is wired up to the live `weapon_cuh_base_gun.lua`.
* `weapon_custom_uh_base_gun.lua:1083-1085` calls `CustomUH.SaveAttachments(self, self.Owner)` from `SetAttachment` only when `SERVER` — but `SetAttachment` on CLIENT also calls `ApplyAttachments` which mutates `_statCache` on the client. If the server later broadcasts `CUH2_AttSync` (e.g. another client changed the attachment), the client's already-mutated state gets overwritten — usually fine, but could cause a one-frame flicker.
* `weapon_cuh_base_gun.lua:111-143` — the camera bone system reads `self.m_CurrentSequence` (`:116`) but **never sets it anywhere** in this file. Either dead code or a vestige of a deleted method.
* `weapon_xm4_bo6.lua:468-471` — there's a syntax error: a stray `,` after `SWEP.ViewModelElements = {` line that's part of an incomplete block:
  ```lua
  ,
      Ang = { Up = 90, Right = -180, Forward = 79 },
      Scale = 1
  }
  ```
  This file may not parse cleanly — verify before using as a template.
* `lua/customuh/sh_att_ammo.lua:21-32` `SWEP:UpdateClipSize` is defined but never called by any live code path.
* `lua/customuh/sh_att_save.lua:154-164` registers a `WeaponDeployed` hook that **is not a standard GMod hook** and is never fired — confirmed dead by `docs/worklog.md:228`.
* `lua/customuh/sh_att_save.lua:180-185` registers `WeaponHolstered` hook — also not standard GMod.
* `lua/customuh/cl_att_ui.lua` and `lua/autorun/cl_cuh_ui.lua` both define `OpenMenu()` and `Think` key-detection hooks. The `cl_cuh_ui.lua` version (under `lua/autorun/`) is the live one; the `cl_att_ui.lua` version (under `lua/customuh/`) is dead unless the dead v2 `IncludeWithSWEP` path runs.
* `lua/customuh/cl_att_scope.lua:8-15` documents `ATTACHMENT.RTScope` but no live attachment file defines this field — the RT scope system is implemented in `weapon_custom_uh_base_gun.lua:931-981` instead, using per-weapon `SWEP.ScopeTexture`/`SWEP.ScopeFov`/`SWEP.RenderTarget` fields.

### 7.8 Worklog-known issues

From `docs/worklog.md`:

* **State bleed** across weapons from file-scope upvalues (`worklog.md:91`) — fixed by moving all to `self._xxx`.
* **`GrenadeTime` vs `UH_GrenadeTime`** inconsistency (`worklog.md:92`) — fixed in 3 call sites.
* **Three reload completion paths** (`worklog.md:94`) — consolidated to Think-based.
* **ShootBullets global `spread`** (`worklog.md:95`) — fixed to local.
* **ReloadTable `return` instead of `continue`** (`worklog.md:96`) — fixed.
* **Melee SwingSound/HitSound randomized at file load** (`worklog.md:97`) — fixed per-swing.
* **Melee `type()=="NextBot"` never matches** (`worklog.md:98`) — fixed to `IsNextBot`.
* **LookupSequence `> 0`** treats index 0 as not found (`worklog.md:99`) — fixed to `>= 0`.
* **Shotgun `vm` leaks to global** (`worklog.md:100`) — fixed with `local`.

### 7.9 Porting pitfalls from `CUH_PORTING_GUIDE.md`

* **CRLF line endings** in the original `weapon_uh_base.lua` (`CUH_PORTING_GUIDE.md:406-413`) — use byte-level Python to modify.
* **`render.Clear` breaks RT surface alpha** (GMod bug #2085) — don't use it before `surface.DrawTexturedRect`.
* **`render.RenderView` resets render target** — re-push RT before drawing overlay.
* **`SetSubMaterial` requires `"!"` prefix** for `CreateMaterial` names.
* **Transparent PNG → VTF**: transparent areas must have WHITE RGB, not black.
* **Client-only code** (`surface.*`, `render.*`, `cam.*`, `draw.*`, `vgui.*`) must be inside `if CLIENT then`.
* **`PostShoot` doesn't run on client in singleplayer** — use `GetNextPrimaryFire()` for client-side shot detection.
* **`WeaponDeployed` is NOT a standard GMod hook** — replaced with `PlayerSwitchWeapon`.
* **`Deploy()` must return `true`** or the deploy is cancelled.

---

## 8. The simulator files (`tools/simulator/`)

### 8.1 `cuh_preprocess.py` (256 lines)

Converts GMod LuaJIT-isms to plain Lua 5.4 so the lupa-based simulator can
load the actual source files.

What it does:

1. **`continue` keyword** (LuaJIT extension) → `goto __cont_N__` + label insertion before the enclosing loop's `end` (`:99-239`). The line-based scanner tracks block openers (`function`, `if`, `for`, `while`, `do`, `repeat`) and closers (`end`, `until`) so it knows which loop each `continue` belongs to.

2. **`slot = tonumber(slot) or slot`** → `local slot = tonumber(slot) or slot` (`:62-72`). LuaJIT allows reassigning for-loop variables in the body; Lua 5.4 makes them const. The shadowing `local` declaration is behaviorally identical.

3. **Simulator instrumentation** (sim-only prints injected into `InitStatCache`, `RestoreStat`, `SetStat`) — only triggered when the simulator loads the patched source (`:76-96`).

### 8.2 `cuh_sim_driver.py` (549 lines)

The Python driver. Uses `lupa.LuaRuntime` to spin up a Lua VM, then:

1. **Mocks the GMod API** (`:53-364`): `Color`, `Sound`, `Vector`, `Angle`, `Material`, `string.StripExtension`, `table.Copy`, `table.Count`, `file.Find/Exists/Read/Write/CreateDir` (reads from actual disk under `LUA_ROOT`), `include` (uses `load` + `chunk()` so ATTACHMENT/SWEP globals propagate), `AddCSLuaFile` (no-op), `net` (no-op stubs), `util.AddNetworkString/JSONToTable/TableToJSON/TraceHull`, `timer.Simple/Exists/Remove/Create`, `hook.Add/Remove` (collects but doesn't invoke), `ConVarExists`, `CreateClientConVar`, `ClientsideModel` (creates a fake Lua table with `__model`, `__group`, `__removed` fields and stub methods — recorded in `_CSMODEL_LOG`), `IsValid`, `istable/isfunction/isstring/isnumber/isangle/isvector`, `concommand.Add`, `surface/draw/vgui` stubs, `math.Approach`, `DEFINE_BASECLASS`, `weapons.GetStored`, and a global `SWEP = { Primary = {}, Secondary = {} }`.

2. **Pre-computes the attachment file listing** (`:373-386`) from disk and injects as `_FILE_LISTING` so `file.Find` doesn't need `io.popen`.

3. **Pre-patches every CUH source file** via `cuh_preprocess.preprocess` (`:394-425`) and stores the patched source in `_PATCHED_SOURCES` so `include` prefers the patched version.

4. **Loads the live source files in order** (`:455-522`):
   - `autorun/sh_cuh_attachments.lua` (registers all attachments into `CustomUH.Attachments`)
   - `weapons/weapon_cuh_base_gun.lua` (defines `_CUH_BASE` = the SWEP table with all the methods)
   - `weapons/weapon_m8a1_scotia.lua` (deep-copies `_CUH_BASE` into `SWEP`, includes the file, captures `_WEAPON`)

5. **Runs the test harness** (`:528-540`): executes `cuh_sim_harness.lua`, reads `_RESULT_PASS`/`_RESULT_FAILS`/`_RESULT_MODEL` globals.

### 8.3 `cuh_sim_harness.lua` (242 lines)

The actual test assertions (16 checks). It:

1. Builds a per-instance copy of `_WEAPON` (the M8A1 class table) — `:33-50`. Stubs `Owner`, `GetClass`, `GetMaxClip1`, `Clip1`, `SetClip1`, `TakePrimaryAmmo`, `GetPrimaryAmmoCount`.
2. Captures `ORIGIN_BARREL_MODEL`, `ORIGIN_SPREAD`, `ORIGIN_IRONSIGHT_TIME` for assertions.
3. Calls `InitVElements` + `InitWElements` (`:109-110`) — expects 8 `ClientsideModel`s created (4 V + 4 W). Asserts `_defaultSnapshot` captured the original model.
4. `SetAttachment(2, 2)` — picks `xm8_barrel_h` (Hvy-B). Asserts:
   - `barrel.model` swapped to `scotia_b_h.mdl` (`:162-164`)
   - `barrel._csModel.__model` rebuilt with new path (`:165-167`)
   - `Primary.Spread = 0.04 * 0.8 [Hvy-B] * 0.9 [stock_f default] = 0.0288` (`:172-175`)
   - `IronSightTime = 0.45 * 1.1 [Hvy-B] * 0.9 [psg_c] * 1.8 [stock_f] * 0.7 [smag] = 0.5103` (`:179-184`)
5. `SetAttachment(2, 3)` — switch to L-Barrel. Asserts model swap (`:197-202`).
6. `SetAttachment(2, 0)` — "None". Asserts model reverts to default; stats recompute with only the remaining slot defaults active (`:219-233`).

### 8.4 How complete is each (working / stub / partial)

| File | Status | Notes |
|------|--------|-------|
| `cuh_preprocess.py` | **Working** for the subset of LuaJIT-isms CUH uses. Documented as "approximate (doesn't handle multi-line strings/comments perfectly)" (`:17-19`). |
| `cuh_sim_driver.py` | **Working** for the M8A1 + attachments test. Hardcoded to load M8A1 (`:456-522`). Only mocks what M8A1 touches — would need extension to load other weapons. |
| `cuh_sim_harness.lua` | **Working** for M8A1, 16 checks, all passing per `README.md:84-87`. |

### 8.5 Gaps for running SWEP code outside GMod

If you want to run a different weapon (not M8A1) through the simulator:

1. **`cuh_sim_driver.py:456-522`** hardcodes `weapon_m8a1_scotia.lua`. Change the path or parameterize.
2. **The harness** (`cuh_sim_harness.lua`) hardcodes M8A1-specific assertions (Hvy-B barrel path, `0.04` spread origin, `0.45` IronSightTime origin). A new weapon needs a new harness.
3. **The mock environment** (`cuh_sim_driver.py:53-364`) doesn't mock:
   - `Owner:GetViewModel()` returns a stub table with `SequenceDuration = 0.5`, `GetCycle = 1` — but real weapons need `LookupSequence`, `LookupBone`, `GetBonePosition`, `LookupAttachment`, `GetAttachment`, `SendViewModelMatchingSequence`, `SetPlaybackRate`, `SetCycle`, `:GetSequenceName`, `:GetSequence`, etc.
   - `render.*` (PushRenderTarget, RenderView, PopRenderTarget, SuppressEngineLighting, etc.)
   - `surface.*`, `draw.*`, `cam.*`, `vgui.*` (stubbed but not functional)
   - `ParticleEffectAttach`, `EffectData`, `util.Effect`, `util.ScreenShake`, `util.TraceLine`, `util.TraceHull` (only `TraceHull` is stubbed)
   - `DamageInfo`
   - `ents.Create`, `DynamicLight`, `LocalPlayer`, `EyePos`, etc.
4. **`CurTime`**, `FrameTime`, `IsFirstTimePredicted`, `game.SinglePlayer` are partially mocked but not as functions of state.
5. **The simulator runs in CLIENT realm** (`CLIENT = true, SERVER = false` at `cuh_sim_driver.py:57-58`), so SERVER-only branches (clip refill, save) don't execute.
6. **`net.SendToServer`** is a no-op stub — client-side `SetAttachment` calls `ApplyAttachments` locally but the server-side save never happens. The simulator doesn't test server-side state.

In short: the simulator is good for asserting that the
`SetAttachment → ApplyAttachments → CleanupVElements + InitVElements`
pipeline produces the right model strings and stat values. It is NOT
useful for testing fire/reload/anim behavior.

---

## 9. Concrete example: minimal new weapon

Below is a minimal new weapon on the CUH base, adapted from
`weapon_m8a1_scotia.lua` (stripped to essentials). File path:
`lua/weapons/weapon_my_new_gun.lua`.

```lua
AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName    = "My New Gun"
SWEP.Category     = "My Mods"
SWEP.SubCategory  = "Rifles"
SWEP.Slot         = 2
SWEP.Spawnable    = true
SWEP.IsCUHWeapon  = true   -- lets the C-key menu detect us in O(1)
SWEP.Customizable = true   -- (default truthy; set false to opt OUT of menu)

-- Appearance
SWEP.UseHands         = true
SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV     = 70
SWEP.ViewModel        = "models/weapons/v_mygun.mdl"
SWEP.WorldModel       = "models/weapons/w_mygun.mdl"
SWEP.WorldModelOffset = Vector(10, 1, -3)
SWEP.WorldModelAngle  = Angle(0, 90, 190)

SWEP.HoldType    = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov     = 15

SWEP.FireModes = {
    { name = "Full-Auto" },
    { name = "Semi-Auto" },
}

-- Primary stats
SWEP.Primary.Sound          = Sound("mygun/fire")
SWEP.Primary.SilSound       = Sound("mygun/fire_sil")
SWEP.Primary.ClipSize       = 30
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 90
SWEP.Primary.MinDamage      = 25
SWEP.Primary.MaxDamage      = 25
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.04
SWEP.Primary.Delay          = 60 / 700       -- 700 RPM
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.3
SWEP.Primary.MaxRecoil      = -0.2
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.2
SWEP.Primary.KickHorizontal = 0.25

SWEP.TwoHanded       = true
SWEP.ReloadSpeed     = 1
SWEP.Chambering      = false
SWEP.AnimatedSprint  = false
SWEP.CUHInspectOnMenu = true

SWEP.IronSightsPos = Vector(-0.025, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.45
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)
SWEP.RunSightsPos   = Vector(0, 0, 0)
SWEP.RunSightsAng   = Vector(-15, 15, -15)
SWEP.IronSightsDipPos   = Vector(0, -1.5, -2.0)
SWEP.IronSightsDipAng   = Angle(3, 0, 0)
SWEP.IronSightsDipScale = 1.0

SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve    = false
SWEP.CameraOffset     = Angle(0, 0, 0)

SWEP.MuzzleFlashType       = "particle"
SWEP.MuzzleFlashParticle   = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize  = 128

SWEP.NoShell  = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/weapons/shell_556.mdl"

SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 300
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav"}
SWEP.MeleeInterruptReload = true

SWEP.Animations = {
    ["shoot"]        = "ACT_VM_PRIMARYATTACK",
    ["reload"]       = "ACT_VM_RELOAD",
    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
    ["iron_fire"]    = "iron_fire",
    ["iron_in"]      = "ads_in",
    ["iron_idle"]    = "iron_idle",
    ["iron_out"]     = "ads_out",
    ["idle"]         = "ACT_VM_IDLE",
    ["deploy"]       = "ACT_VM_DRAW_DEPLOYED",
    ["melee"]        = "ACT_VM_MELEE",
    ["inspect"]      = "ACT_VM_FIDGET",
    ["sprint_idle"]  = "ACT_VM_SPRINT_IDLE",
    ["sprint_in"]    = "ACT_VM_SPRINT_ENTER",
    ["sprint_out"]   = "ACT_VM_SPRINT_LEAVE",
}
SWEP.AnimSounds = {}

function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    return "shoot"
end

function SWEP:Think()
    BaseClass.Think(self)
    -- Per-weapon Think logic here
end

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end

function SWEP:Holster(wep)
    return BaseClass.Holster(self, wep)   -- MUST pass self explicitly
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    return true   -- MUST return true
end

-- ============================================================
-- VElements — one per "part class": barrel, mag, stock, pgrip, sight
-- ============================================================
SWEP.ViewModelElements = {
    ["barrel"] = {
        type = "Model", model = "models/weapons/parts/mygun_barrel_default.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["mag"] = {
        type = "Model", model = "models/weapons/parts/mygun_mag_30.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["stock"] = {
        type = "Model", model = "models/weapons/parts/mygun_stock_default.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["pgrip"] = {
        type = "Model", model = "models/weapons/parts/mygun_pgrip_default.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
}
SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)   -- MUST be a copy

-- ============================================================
-- Attachment slots — one sight, one mag, one barrel
-- ============================================================
SWEP.Attachments = {
    [1] = { name = "Optic",    atts = { "mygun_sight_default", "mygun_sight_red" }, default = 1 },
    [2] = { name = "Barrel",   atts = { "mygun_barrel_short", "mygun_barrel_long" }, default = 1 },
    [3] = { name = "Magazine", atts = { "mygun_mag_30", "mygun_mag_60" }, default = 1 },
}
```

File-path conventions:

* Weapon file: `lua/weapons/weapon_<name>.lua` — must `AddCSLuaFile()` at top, set `SWEP.Base = "weapon_cuh_base_gun"`, and `DEFINE_BASECLASS("weapon_cuh_base_gun")`.
* Attachment files: `lua/cuh_attachments/<attachment_id>.lua` — one file per attachment, where `<attachment_id>` is the string used in `SWEP.Attachments[slot].atts`.
* Optional sound scripts: `lua/autorun/<weapon_name>_sound.lua` with `sound.Add({...})` calls.

---

## 10. Concrete example: minimal new attachment

Below is a minimal red-dot sight attachment. File path:
`lua/cuh_attachments/mygun_sight_red.lua`.

```lua
if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name      = "Red Dot Sight"
ATTACHMENT.ShortName = "RDS"
ATTACHMENT.Icon      = "entities/mygun_red_dot.png"   -- optional
ATTACHMENT.ModelPath = "models/weapons/parts/mygun_sight_red.mdl"
ATTACHMENT.PartClass = "barrel"   -- swaps the "barrel" VElement/WElement's model

ATTACHMENT.Description = {
    Color(100, 255, 100), "Faster ADS",
    Color(255, 100, 100), "-5% move speed",
}

ATTACHMENT.WeaponTable = {
    -- Stat overrides
    ["Primary"] = {
        -- These are applied only if the weapon defines Primary.IronAccuracy
        ["IronAccuracy"] = function(wep, val) return val * 0.7 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 0.85 end,
    ["MoveSpeed"]     = function(wep, val) return val * 0.95 end,

    -- Bodygroup swap (hide the default ironsight bodygroup)
    ["Bodygroups_V"] = { [2] = 1 },
    ["Bodygroups_W"] = { [2] = 1 },

    -- Animation override (use the red-dot-specific ads sequence)
    ["Animations"] = {
        ["iron_in"]   = "ads_in_red",
        ["iron_idle"] = "iron_idle_red",
        ["iron_out"]  = "ads_out_red",
    },
}

function ATTACHMENT:Attach(wep)
    -- Swap the VElement/WElement model for this PartClass
    local partClass = self.PartClass
    local newModel  = self.ModelPath
    if wep.ViewModelElements and wep.ViewModelElements[partClass] then
        if not wep.ViewModelElements[partClass]._original_model then
            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model
        end
        wep.ViewModelElements[partClass].model = newModel
    end
    if wep.WorldModelElements and wep.WorldModelElements[partClass] then
        if not wep.WorldModelElements[partClass]._original_model then
            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model
        end
        wep.WorldModelElements[partClass].model = newModel
    end

    -- Rebuild the ClientsideModels with the new model path
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end

function ATTACHMENT:Detach(wep)
    -- NOTE: NEVER CALLED by the base.
    -- ApplyAttachments restores from _defaultSnapshot automatically.
    -- This Detach function is here only for direct callers / debugging.
    local partClass = self.PartClass
    if wep.ViewModelElements and wep.ViewModelElements[partClass] and wep.ViewModelElements[partClass]._original_model then
        wep.ViewModelElements[partClass].model = wep.ViewModelElements[partClass]._original_model
    end
    if wep.WorldModelElements and wep.WorldModelElements[partClass] and wep.WorldModelElements[partClass]._original_model then
        wep.WorldModelElements[partClass].model = wep.WorldModelElements[partClass]._original_model
    end
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end
```

To bind this attachment to a slot in a weapon, add the attachment ID to the slot's `atts` list (as already shown in §9):

```lua
SWEP.Attachments = {
    [1] = { name = "Optic", atts = { "mygun_sight_default", "mygun_sight_red" }, default = 1 },
    -- ...
}
```

The string `"mygun_sight_red"` must exactly match the filename `lua/cuh_attachments/mygun_sight_red.lua` (without the `.lua` extension). The loader does `id = string.StripExtension(filename)` and stores `CustomUH.Attachments[id] = ATTACHMENT` (`sh_cuh_attachments.lua:91-94`).

File-path conventions for attachments:

* File location: `lua/cuh_attachments/<attachment_id>.lua` (NOT `customuh_attachments/` — that folder is dead code).
* The file must start with `if not ATTACHMENT then ATTACHMENT = {} end` (or simply `ATTACHMENT = {}`) so the loader's pre-set `ATTACHMENT` global is used.
* `ATTACHMENT.Name` is **required** — without it, the loader skips the file (`sh_cuh_attachments.lua:91`).
* `ATTACHMENT.ModelPath` is the new model to swap in. Optional (e.g. `dcm_fullauto.lua` sets `nil` because it's a stat-only attachment).
* `ATTACHMENT.PartClass` is the key into `SWEP.ViewModelElements` / `SWEP.WorldModelElements`. Must match the VElement name on the weapon (e.g. `"barrel"`, `"mag"`, `"pgrip"`, `"stock"`, `"muzzle"`).

---

## Appendix A: Method reference (quick lookup)

All `SWEP:` methods defined on the base, with file:line.

### Root base (`weapon_custom_uh_base.lua`)

* `:Initialize`, `:ResetViewState`, `:GetViewModelPosition`, `:Alternative`, `:Inspect`, `:Grenade`, `:Sights`, `:Sway`, `:Movement`, `:FireAnimationEvent`, `:EasySendWeaponAnim`, `:SendSequence`, `:SendAnim`, `:SendWeaponAnim`, `:LookupSequence`, `:ClearAnimSounds`, `:HandleRunning`, `:HandleBones`, `:HandleHands`, `:Deploy`, `:Holster`, `:ClientHolster`, `:Think`, `:CalcView` (CLIENT), `:PreDrawViewModel`, `:PostDrawViewModel`, `:HUDShouldDraw`, `:DrawWeaponSelection`

### Gun base (`weapon_custom_uh_base_gun.lua`)

* `:Initialize`, `:SendSequence`, `:SendAnim`, `:EasySendWeaponAnim`, `:SendWeaponAnim`, `:LookupSequence`, `:SetupAnimSounds`, `:ProcessAnimSounds`, `:ClearAnimSounds`, `:GetShootSound`, `:ShootAnimation`, `:GrenadeAnimation`, `:GetShellDirection`, `:GetMuzzle`, `:GetDisplay`, `:GetShellEject`, `:PrimaryAttack`, `:ShootBullets`, `:ShootGrenade`, `:PostShoot`, `:CanPrimaryAttack`, `:SecondaryAttack`, `:DoMuzzleFlash`, `:CreateSmoke`, `:CreateShell`, `:_FinishReload`, `:Reload`, `:PreReload`, `:PostReload`, `:FireAnimationEvent`, `:Think`, `:AdjustMouseSensitivity`, `:DrawHUD` (CLIENT)

### Shotgun base (`weapon_custom_uh_base_shotty.lua`)

* `:Initialize`, `:PostShoot`, `:ReloadShotgun`, `:Reload`, `:PreReload`, `:PostReload`

### Melee base (`weapon_custom_uh_base_melee.lua`)

* `:PreSwing`, `:PostHit(trace, dmginfo)`, `:GetSwingAnim`, `:Initialize`, `:Think`, `:Reload`, `:PrimaryAttack`, `:SecondaryAttack`, `:DrawHUD` (CLIENT)

### CUH customization base (`weapon_cuh_base_gun.lua`)

* `:GetEffectiveAttachment`, `:Initialize`, `:CalcView`, `:InitStatCache`, `:GetStat`, `:SetStat`, `:RestoreStat`, `:FlushStats`, `:InitVElements`, `:DrawVElements`, `:CleanupVElements`, `:Holster`, `:OnRemove`, `:InitWElements`, `:DrawWElements`, `:CleanupWElements`, `:DrawWorldModel`, `:SetSightBodygroup`, `:SetMagBodygroup`, `:ApplyBodygroupsVM`, `:ApplyBodygroupsWM`, `:ResetBodygroups`, `:ApplyAttachments`, `:SetAttachment`, `:GetActivityEnabled`, `:MeleeAttack`, `:DoMeleeTrace`, `:EndMelee`

### Customuh helper modules (loaded by dead v2 path)

From `lua/customuh/sh_swep_methods.lua`: `GetEffectiveAttachment`, `InitStatCache`, `GetStat`, `SetStat`, `RestoreStat`, `FlushStats`, `ApplyAttachments`, `SetAttachment`
From `lua/customuh/sh_velements.lua`: `InitVElements`, `DrawVElements`, `CleanupVElements`, `GetActiveVElementCount`
From `lua/customuh/sh_welements.lua`: `InitWElements`, `DrawWElements`, `CleanupWElements`
From `lua/customuh/sh_bodygroups.lua`: `SetSightBodygroup`, `SetMagBodygroup`, `ApplyBodygroupsVM`, `ApplyBodygroupsWM`, `ResetBodygroups`
From `lua/customuh/sh_att_ammo.lua`: `UpdateClipSize`, `GetExtendedClipSize`, `GetAmmoDisplayName`
From `lua/customuh/sh_att_save.lua`: `CustomUH.GetSavePath`, `CustomUH.LoadAttachments`, `CustomUH.SaveAttachments`, `CustomUH.SaveAllAttachments`
From `lua/customuh/cl_att_ui.lua`: `OpenMenu()` (local), `Think` hook `CUH2_MenuKey`
From `lua/customuh/cl_att_scope.lua`: `DoRTScope`, `CleanupRTScope`, `SetupRTScope(att)`, `ClearRTScope`

---

## Appendix B: File inventory (live vs dead)

### Live files (loaded by GMod)

| File | Lines | Role |
|------|------|------|
| `lua/autorun/sh_cuh_attachments.lua` | 609 | **Live.** Attachment registration, save/load, networking, debug commands. |
| `lua/autorun/cl_cuh_ui.lua` | 352 | **Live.** Customization menu. |
| `lua/autorun/cuh_extra_recoil.lua` | 188 | **Live.** Extra recoil + screenshake. |
| `lua/autorun/bo7_1911_sound.lua` | 729 | **Live.** BO7 1911 sound bank. |
| `lua/weapons/weapon_custom_uh_base.lua` | 1134 | **Live.** Root base. |
| `lua/weapons/weapon_custom_uh_base_gun.lua` | 1124 | **Live.** Gun base. |
| `lua/weapons/weapon_custom_uh_base_shotty.lua` | 230 | **Live.** Shotgun base. |
| `lua/weapons/weapon_custom_uh_base_melee.lua` | 256 | **Live.** Melee base. |
| `lua/weapons/weapon_cuh_base_gun.lua` | 1203 | **Live.** Customization base. |
| `lua/weapons/weapon_m8a1_scotia.lua` | 563 | **Live.** M8A1 weapon. |
| `lua/weapons/weapon_xm4_bo6.lua` | 528 | **Live.** XM4 weapon (has stray `,` syntax bug at line 468 — verify). |
| `lua/weapons/weapon_bo7_1911.lua` | 617 | **Live.** BO7 1911 weapon. |
| `lua/weapons/weapon_dcm_1911.lua` | 575 | **Live.** DCM 1911 weapon. |
| `lua/cuh_attachments/*.lua` | ~75 files | **Live.** Attachment data files. |

### Dead / superseded files (still loaded but unused)

| File | Lines | Why dead |
|------|------|---------|
| `lua/autorun/sh_customuh.lua` | 343 | v2 architecture plan, loads from `customuh_attachments/` (the wrong folder). |
| `lua/autorun/sh_custom_uh_attachments.lua` | 347 | v1 architecture, uses `CustomUH_AttSelect` net strings (no `2` in name). |
| `lua/customuh/sh_swep_methods.lua` | 259 | Methods defined here are superseded by `weapon_cuh_base_gun.lua`. |
| `lua/customuh/sh_velements.lua` | 223 | Same. |
| `lua/customuh/sh_welements.lua` | 121 | Same. |
| `lua/customuh/sh_bodygroups.lua` | 99 | Same. |
| `lua/customuh/sh_att_ammo.lua` | 70 | `UpdateClipSize` never called. |
| `lua/customuh/sh_att_save.lua` | 185 | Uses non-existent `WeaponDeployed`/`WeaponHolstered` hooks. |
| `lua/customuh/cl_att_ui.lua` | 221 | Superseded by `lua/autorun/cl_cuh_ui.lua`. |
| `lua/customuh/cl_att_scope.lua` | 129 | `DoRTScope` never called. Live RT system in `weapon_custom_uh_base_gun.lua:931-981`. |
| `lua/customuh_attachments/*.lua` | 18 files | Wrong folder (live loader uses `cuh_attachments/`). |

### WWII addon (separate addon folder, mounted by GMod)

| Path | Files | Role |
|------|------|------|
| `worldwarii_underhell/lua/weapons/uh_codww2_*.lua` and `nz_kate_codww2_*.lua` | ~100 | WWII weapons. |
| `worldwiii_underhell/lua/cuh_attachments/tfa_codww2_*.lua` | 11 | WWII attachments (scopes, akimbo, smoke grenade). |
| `worldwiii_underhell/lua/autorun/nz_codww2_sounds.lua` | (large) | WWII sound bank. |

### Developer tools (NOT loaded by GMod)

| Path | Files | Role |
|------|------|------|
| `tools/simulator/cuh_sim_driver.py` | 549 | Python driver — loads CUH source into lupa Lua VM, mocks GMod API, runs harness. |
| `tools/simulator/cuh_sim_harness.lua` | 242 | 16-check assertions for M8A1. |
| `tools/simulator/cuh_preprocess.py` | 256 | LuaJIT → Lua 5.4 source rewriter. |
| `tools/porting/port_nmrih_weapons.py`, `gen_base.py`, `gen_gun.py`, `port_bo4.py` | various | One-off porting scripts. |

---

End of report.
