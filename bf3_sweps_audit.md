# BF3 SWEPs → CUH Base Porting Audit

**Author:** Z User (assistant)
**Date:** 2026-10-19
**Scope:** All 32 BF3 weapons in `LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305`, ported to the CUH (Custom UnderHell) base at `/home/z/my-project/download/custom_uh_base/`.

This is an exhaustive, file-by-file audit of every BF3 SWEP and every BF3 attachment, plus a complete mapping of TFA conventions to CUH conventions. After the audit, the plan is to port one representative per category, simulator-test it, push, then port the rest in batches.

---

## 1. Inventory

### 1.1 Weapons (32 total)

Grouped by `SWEP.Type` field. The `HoldType` is what GMod's animation system uses; the `Type` is just a label.

| Category | Count | Weapons |
|---|---|---|
| Assault Rifle | 7 | aek971, ak74, famas, g3a3, l85a2, m16a3, m416 |
| Carbine | 7 | acwr, aks74u, asval, g36c, m4a1, scarh, (m416 is sometimes classed as carbine) |
| DMR | 1 | mk11 |
| Light-Machine Gun | 1 | m249 |
| SMG | 3 | mp7, pp19, ump45 |
| Shotgun | 4 | 870mcs, m1014, saiga12, spas12 |
| Sniper Rifle | 3 | m82a3, m98b, sv98 |
| Pistol | 8 | g18, m1911, m9, m93r, magnum44, mp412, mp443 |
| **Total** | **32** | |

### 1.2 Attachments (9 total)

All defined in `lua/tfa/att/bf3_*.lua` (TFA folder). All 9 are shared across most weapons via `SWEP.Attachments`:

| ID | Name | Bodygroup swap | Stat changes | Side-effects |
|---|---|---|---|---|
| `bf3_reflex` | Reflex | bg 0 = 1 | `IronSightsPos/Ang` → `_Reflex` variants; `Secondary.IronFOV` → `IronFOV_Collimator` | sets `wep.Secondary.IronFOV = 60` directly in `Attach` |
| `bf3_kobra` | Kobra | bg 0 = 2 | same as reflex but `_Kobra` variants | sets `wep.Secondary.IronFOV = 60` |
| `bf3_eotech` | Eotech | bg 0 = 4 | same as reflex but `_Eotech` variants | (none) |
| `bf3_acog` | ACOG | bg 0 = 3 | `_ACOG` variants; `IronFOV` → `IronFOV_ACOG` | (none, commented out) |
| `bf3_scope` | Scope | bg 0 = 5 | `_Scope` variants; `IronFOV` → `IronFOV_Scope` | `wep.Scoped = true; wep.BoltAction = true` |
| `bf3_muzzle` | Muzzle (compensator) | bg 1 = 1 | `Primary.KickUp * 0.9; KickDown * 0.9` | (none) |
| `bf3_suppressor` | Suppressor | bg 1 = 2 | `Primary.Spread * 0.9; IronAccuracy * 0.9` | `wep.Silenced = true; wep:SetSilenced(true)` |
| `bf3_laser` | Laser | bg 3 = 1; activates `VElements["laser"]` and `["laser_beam"]` | sets `LaserSightAttachment`/`LaserSightAttachmentWorld` | (none — pure visibility/bodygroup) |
| `bf3_grip` | Foregrip | bg 2 = 1 | `Primary.KickUp * 0.9; KickDown * 0.9`; overrides `Animations` table with `foregrip_*` variants | sets `wep.HoldType = "smg"`; calls `wep:ChooseIdleAnim()` |

### 1.3 Animation sequence inventory (decompiled from .mdl files)

I decompiled all 32 BF3 view models with Crowbar and inventoried every `$sequence`. There are **6 distinct animation patterns**:

#### Pattern A: AR/Carbine/LMG/DMR (16 weapons)

```
base_idle, base_draw, base_fire, base_reload, base_reload_empty
foregrip_idle, foregrip_draw, foregrip_fire, foregrip_reload, foregrip_reload_empty
```

Used by: `acwr, aek971, ak74, aks74u, asval, famas, g36c, g3a3, l85a2, m16a3, m416, m4a1, scarh, mk11, m249, ump45`

**Per-weapon variations:**
- `aek971, ak74, aks74u, asval, g36c` — use `base_reloadempty` (no underscore between "reload" and "empty")
- `scarh` — adds `base_fire_empty` and `foregrip_fire_empty`
- `m249` — only has `base_*` (no `foregrip_*`); uses `idle1` not `base_idle`
- `mk11` — full pattern + can use `bf3_scope` (sniper scope)

#### Pattern B: Pistol (5 weapons)

```
idle, draw, fire, shoot_empty, reload, reload_full, fire_empty
```

Used by: `m1911, g18, m9, m93r, mp443`

**Notes:**
- `fire` — shoot animation when clip has ammo
- `shoot_empty` — shoot animation when clip is empty (dry fire)
- `fire_empty` — alternate empty-shoot animation (some weapons have both)
- `reload_full` — reload when clip still has ammo (tactical reload)
- `reload` — reload when clip is empty (full reload)

#### Pattern C: Sniper (3 weapons)

```
idle, draw, fire, reload, reload_empty
```

Used by: `m98b, m82a3, sv98`

**Note:** All 3 snipers can equip `bf3_scope` which sets `wep.Scoped = true; wep.BoltAction = true`. The `BoltAction` flag triggers a special rechamber animation between shots.

#### Pattern D: Revolver (2 weapons)

```
mp412:     Idle, draw, fire, reload, fire_empty
magnum44:  idle, fire, reload, draw, fire_empty
```

**Note:** `mp412` uses `Idle` (capital I) — likely a typo in the original BF3 source. `magnum44` has no `shoot_empty`, just `fire_empty`.

#### Pattern E: Pump/Tube Shotgun (3 weapons)

```
idle, draw, fire1, fire2, reload_insert, reload_start, reload_end
```

Used by: `870mcs, m1014, spas12`

**Notes:**
- `fire1`/`fire2` — alternating fire animations (gives visual variety)
- `reload_start` — animation that begins the reload (open the chamber)
- `reload_insert` — animation for each shell inserted (loops N times for N shells)
- `reload_end` — animation that finishes the reload (close the chamber)

These use TFA's ` Shotgun = true` flag and TFA's per-shell reload system.

#### Pattern F: Auto Shotgun (1 weapon)

```
saiga12: idle1, draw, fire, reload, reload_empty
```

`saiga12` is a box-mag-fed shotgun — uses the SMG/sniper animation pattern (not the per-shell shotgun pattern). It reloads like a normal gun.

#### Pattern G: SMG (2 weapons)

```
mp7, pp19: idle, draw, fire, reload, reload_empty
```

Simple 5-anim pattern.

---

## 2. SWEP field-by-field audit

This section inventories every SWEP field used by BF3 weapons, what it does in TFA, and how it maps to CUH.

### 2.1 Identification fields

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.PrintName` | all 32 | weapon spawnmenu name | `SWEP.PrintName` | direct copy |
| `SWEP.Category` | all 32 | spawnmenu category | `SWEP.Category` | direct copy (or update to "[CUH] Battlefield 3") |
| `SWEP.Author` | all 32 | author string | `SWEP.Author` | direct copy |
| `SWEP.Spawnable` | all 32 | spawnable flag | `SWEP.Spawnable` | direct copy |
| `SWEP.AdminSpawnable` | all 32 | admin spawnable flag | (no CUH equivalent — set both `Spawnable` and `AdminSpawnable`) | direct copy |
| `SWEP.Slot` | all 32 | weapon slot (1-5) | `SWEP.Slot` | direct copy |
| `SWEP.SlotPos` | all 32 | slot position | `SWEP.SlotPos` | direct copy |
| `SWEP.DrawAmmo` | all 32 | show ammo HUD | `SWEP.DrawAmmo` | direct copy |
| `SWEP.DrawCrosshair` | all 32 | show crosshair | (CUH always draws crosshair via `DrawHUD`) | set but ignored by CUH |
| `SWEP.Type` | all 32 | weapon category label | (no CUH equivalent — used only by TFA inspect HUD) | drop or convert to `SWEP.SubCategory` |
| `SWEP.AdminSpawnable` | all 32 | admin-only spawn | (no CUH equivalent) | direct copy |

### 2.2 Base + appearance

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.Base` | all 32 | base class | `SWEP.Base = "weapon_cuh_base_gun"` | always change from `"tfa_gun_base"` to `"weapon_cuh_base_gun"` |
| `SWEP.ViewModel` | all 32 | viewmodel path | `SWEP.ViewModel` | direct copy (we're using the BF3 v_*.mdl files, NOT the c_*.mdl) |
| `SWEP.WorldModel` | all 32 | worldmodel path | `SWEP.WorldModel` | direct copy |
| `SWEP.ViewModelFOV` | 31 of 32 | viewmodel FOV | `SWEP.ViewModelFOV` | direct copy (870mcs doesn't set this — defaults to 62) |
| `SWEP.HoldType` | all 32 | hold anim type | `SWEP.HoldType` | direct copy |
| `SWEP.VMPos` | all 32 | viewmodel position offset | `SWEP.VMPos` | direct copy (CUH uses Vector) |
| `SWEP.VMAng` | 1 (870mcs) | viewmodel angle offset | `SWEP.VMAng` | direct copy |
| `SWEP.VMPos_Additive` | all 32 | whether VMPos is additive | `SWEP.VMPos_Additive` | direct copy |
| `SWEP.UseHands` | 31 of 32 | use c_hands system | `SWEP.UseHands` | **set to `false`** — BF3 v_*.mdl files have their own hands mesh baked in; using c_hands causes the broken-texture mess we saw earlier |

### 2.3 Primary stats

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.Primary.Sound` | 31 of 32 | fire sound | `SWEP.Primary.Sound` | direct copy |
| `SWEP.Primary.SilencedSound` | 24 of 32 | suppressed fire sound | `SWEP.Primary.SilSound` | **rename** to `SilSound` |
| `SWEP.Primary.RPM` | all 32 | rounds per minute | `SWEP.Primary.Delay = 60 / RPM` | **convert**: e.g. `RPM = 850` → `Delay = 60/850 ≈ 0.0706` |
| `SWEP.Primary.ClipSize` | all 32 | clip capacity | `SWEP.Primary.ClipSize` | direct copy |
| `SWEP.Primary.DefaultClip` | all 32 | starting ammo | `SWEP.Primary.DefaultClip` | direct copy |
| `SWEP.Primary.Automatic` | all 32 | full-auto fire | `SWEP.Primary.Automatic` | direct copy |
| `SWEP.Primary.Ammo` | all 32 | ammo type string | `SWEP.Primary.Ammo` | direct copy (e.g. `"ar2"`, `"pistol"`, `"357"`, `"buckshot"`, `"smg1"`) |
| `SWEP.Primary.NumShots` | all 32 | pellets per shot | `SWEP.Primary.NumberofShots` | **rename** to `NumberofShots` (note: 870mcs etc. use `NumShots = 12` for shotgun) |
| `SWEP.Primary.Damage` | all 32 | damage per hit | `SWEP.Primary.MinDamage` + `SWEP.Primary.MaxDamage` | **convert**: single value → both min and max set to same value |
| `SWEP.Primary.Spread` | all 32 | hip-fire cone | `SWEP.Primary.Spread` | direct copy |
| `SWEP.Primary.IronAccuracy` | all 32 | ADS cone | `SWEP.Primary.IronAccuracy` | direct copy |
| `SWEP.Primary.KickUp` | all 32 | vertical recoil | `SWEP.Primary.KickUp` | direct copy |
| `SWEP.Primary.KickHorizontal` | all 32 | horizontal recoil | `SWEP.Primary.KickHorizontal` | direct copy |
| (none) | (none) | (none) | `SWEP.Primary.KickDown` | set to `KickUp * 0.8` (TFA only used `KickUp`, but CUH wants both) |
| (none) | (none) | (none) | `SWEP.Primary.MinRecoil` | set to `KickUp * 0.7` (CUH uses `MinRecoil`/`MaxRecoil` for `util.SharedRandom`) |
| (none) | (none) | (none) | `SWEP.Primary.MaxRecoil` | set to `KickUp * 1.3` |
| (none) | (none) | (none) | `SWEP.Primary.Force` | set to `6` (default bullet force) |
| (none) | (none) | (none) | `SWEP.Primary.TakeAmmo` | set to `1` (ammo per shot) |

### 2.4 Movement + ironsights

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.SightsPos` | all 32 | ironsight viewmodel offset | `SWEP.IronSightsPos` | **rename** to `IronSightsPos` |
| `SWEP.SightsAng` | all 32 | ironsight viewmodel angle | `SWEP.IronSightsAng` | **rename** to `IronSightsAng` (note: TFA used `Vector`, CUH expects `Vector` too — direct copy is fine; angle is in degrees, both use the same convention) |
| `SWEP.InspectPos` | all 32 | inspect viewmodel offset | (no CUH equivalent — CUH inspect just plays `ACT_VM_FIDGET`) | drop or convert to `SWEP.AlternativePos` for the "alt aim" pose |
| `SWEP.InspectAng` | all 32 | inspect viewmodel angle | (no CUH equivalent) | drop |
| `SWEP.RunSightsPos` | all 32 | sprint viewmodel offset | `SWEP.RunSightsPos` | direct copy |
| `SWEP.RunSightsAng` | all 32 | sprint viewmodel angle | `SWEP.RunSightsAng` | direct copy |
| `SWEP.SprintBobMult` | all 32 | sprint bob multiplier | (no CUH equivalent) | drop |
| `SWEP.Secondary.IronFOV` | all 32 | ADS zoom factor | `SWEP.Secondary.IronFOV` | direct copy (used by `AdjustMouseSensitivity` for sensitivity scaling) |
| `SWEP.Secondary.IronFOV_Scope` | 16 of 32 | scope zoom | `SWEP.Secondary.IronFOV_Scope` | direct copy (only set on snipers + weapons that can equip `bf3_scope`) |
| `SWEP.Secondary.IronFOV_ACOG` | 16 of 32 | ACOG zoom | `SWEP.Secondary.IronFOV_ACOG` | direct copy |
| `SWEP.Secondary.IronFOV_Collimator` | 16 of 32 | red-dot zoom | `SWEP.Secondary.IronFOV_Collimator` | direct copy |
| `SWEP.SightsPos_Reflex` etc. | 16 of 32 | per-attachment sight pos | `SWEP.SightsPos_Reflex` etc. | direct copy — these are read by the attachment's `WeaponTable.IronSightsPos` function |
| `SWEP.SightsAng_Reflex` etc. | 16 of 32 | per-attachment sight ang | `SWEP.SightsAng_Reflex` etc. | direct copy |

### 2.5 Features

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.FiresUnderwater` | all 32 | can fire underwater | (no CUH equivalent — always allowed) | drop |
| `SWEP.Penetration` | all 32 | bullet penetration | `SWEP.Penetration` | direct copy |
| `SWEP.SelectiveFire` | all 32 | fire mode switching | (CUH always allows firemode switching via RMB+USE) | drop |
| `SWEP.BlowbackEnabled` | 22 of 32 | model-based recoil | (no CUH equivalent — CUH uses ViewPunch only) | drop (or implement custom) |
| `SWEP.Blowback_Only_Iron` | 22 of 32 | blowback only in ADS | (no CUH equivalent) | drop |
| `SWEP.BlowbackVector` | 14 of 32 | blowback direction | (no CUH equivalent) | drop |
| `SWEP.BlowbackBoneMods` | 1 (mk11) | bone-specific blowback | (no CUH equivalent) | drop |
| `SWEP.BlowbackEject` | 1 (mp412) | blowback shell ejection | (no CUH equivalent) | drop |
| `SWEP.DisableChambering` | 2 (mp412, magnum44) | disable bullet-in-chamber | `SWEP.Chambering = false` | **rename** + invert (`DisableChambering = true` → `Chambering = false`) |
| `SWEP.Shotgun` | 4 (870mcs, m1014, spas12, saiga12) | TFA per-shell reload | (CUH has `weapon_custom_uh_base_shotty` for shotguns; needs different base) | **change Base** from `weapon_cuh_base_gun` to `weapon_custom_uh_base_shotty` (CUH's shotgun base — currently no CUH layer equivalent, so we need to verify it works) |
| `SWEP.BoltAction` | 2 (m98b, mk11 with scope) | sniper bolt-action | (no direct CUH equivalent; CUH doesn't have a rechamber animation system) | drop OR add a custom `ShootAnimation` that plays `fire` then `idle` after a delay |
| `SWEP.Scoped` | 2 (m98b, mk11 with scope) | scope view | `SWEP.ScopeTexture` (Material) | **convert**: set `SWEP.ScopeTexture = Material("bf3/scope.png", "smooth")` |
| `SWEP.ScopeOverlayThreshold` | 2 (m98b, mk11) | when scope overlay appears | (no CUH equivalent) | drop |
| `SWEP.ScopeScale` | 2 (m98b, mk11) | scope overlay scale | (no CUH equivalent) | drop |
| `SWEP.ReticleScale` | 2 (m98b, mk11) | reticle scale | (no CUH equivalent) | drop |
| `SWEP.Secondary.UseParabolic` | 2 (m98b, mk11) | parabolic scope reticle | (no CUH equivalent) | drop |
| `SWEP.Secondary.ScopeTable` | 2 (m98b, mk11) | scope material config | (no CUH equivalent — CUH just uses `SWEP.ScopeTexture`) | drop, convert to `ScopeTexture` |

### 2.6 Fire modes

TFA uses `SWEP.FireModes = { "Auto", "2Burst", "Single", "Safe" }` — strings that map to TFA's built-in firemode implementations.

CUH uses `SWEP.FireModes` as a table of `{ name = "Full-Auto", shoot = function(ply, wep) ... end }` — each entry has a `name` and optional `shoot` callback.

Migration:
```lua
-- TFA:
SWEP.FireModes = { "Auto", "2Burst", "Single", "Safe" }

-- CUH (drop 2Burst for now — not built into CUH):
SWEP.FireModes = {
    { name = "Full-Auto" },
    { name = "Semi-Auto" },
    { name = "Safe" },
}
```

For weapons with burst mode (m16a3, m4a1, m416, acwr, famas), we'd need to implement a custom shoot callback. For the pilot port, drop burst mode and just have Auto/Semi/Safe.

### 2.7 Shell ejection

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.LuaShellEject` | 28 of 32 | lua-driven shell ejection | (CUH always ejects shells if `SWEP.Shell` is set) | drop |
| `SWEP.LuaShellEjectDelay` | 28 of 32 | delay before eject | `SWEP.ShellDelay` | **rename** |
| `SWEP.LuaShellEffect` | 28 of 32 | shell effect name | (no CUH equivalent — CUH uses `SWEP.Shell` model path) | drop |
| `SWEP.LuaShellScale` | 28 of 32 | shell scale | (no CUH equivalent) | drop |
| (none) | (none) | (none) | `SWEP.Shell` | set to `"models/weapons/shell_556.mdl"` for rifles, `"models/weapons/shell_762.mdl"` for snipers/LMGs, `"models/weapons/shell_9mm.mdl"` for pistols/SMGs, `"models/weapons/shell_12gauge.mdl"` for shotguns (drop entirely for revolvers — they don't eject) |
| (none) | (none) | (none) | `SWEP.ShellHeat` | set to `0.8` (heat value for shell glow effect) |
| (none) | (none) | (none) | `SWEP.NoShell` | set to `true` for revolvers (mp412, magnum44) |

### 2.8 ViewModelBoneMods + VElements

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.ViewModelBoneMods` | 1 (m98b) | per-bone scale/pos/angle mods | `SWEP.ViewModelBoneMods` | direct copy (note: BF3 m98b uses old bone names like `Bip01 L Finger01` — need to rename to `ValveBiped.Bip01_L_Finger01` if we're using the c_arms system, otherwise keep as-is) |
| `SWEP.VElements` | 3 (acwr, mk11, mp7) | extra viewmodel elements | `SWEP.ViewModelElements` | **rename** + **change format** (see below) |
| `SWEP.WolrdModelBoneMods` | 0 | (typo, never used) | (drop) | drop |

**VElement format conversion:**

TFA VElement format (from `bf3_acwr.lua`):
```lua
SWEP.VElements = {
    ["laser"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "weapon", rel = "",
                  pos = Vector(-1.4, 9.899, 2.7), angle = Angle(0, -90, 0),
                  size = Vector(0.5, 0.5, 0.5), color = Color(255, 0, 0, 255),
                  surpresslightning = false, material = "", skin = 0,
                  bodygroup = {}, bonemerge = false, active = false },
}
```

CUH ViewModelElements format (from `weapon_m8a1_scotia.lua`):
```lua
SWEP.ViewModelElements = {
    ["laser"] = { model = "models/tfa/lbeam.mdl", bone = "weapon",
                  pos = Vector(-1.4, 9.899, 2.7), angle = Angle(0, -90, 0),
                  size = Vector(0.5, 0.5, 0.5), material = "",
                  active = false },
}
```

Differences:
- TFA has `type = "Model"` — CUH doesn't (all elements are models)
- TFA has `rel = ""` (relative bone for positioning) — CUH doesn't have this
- TFA has `color = Color(...)` — CUH doesn't support per-element color
- TFA has `surpresslightning` (sic) — CUH supports this too, but spelled the same
- TFA has `bodygroup = {}` (table of bg index → value) — CUH has the same
- TFA has `bonemerge = false` — CUH has the same

### 2.9 Attachments table

TFA format:
```lua
SWEP.Attachments = {
    [1] = { offset = { 0, 0 }, atts = {"bf3_reflex","bf3_kobra","bf3_eotech","bf3_acog"}, order = 2 },
    [2] = { offset = { 0, 0 }, atts = {"bf3_muzzle","bf3_suppressor"}, order = 2 },
    ...
}
```

CUH format:
```lua
SWEP.Attachments = {
    [1] = { name = "Optic",   atts = { "bf3_reflex","bf3_kobra","bf3_eotech","bf3_acog" }, default = 1 },
    [2] = { name = "Muzzle",  atts = { "bf3_muzzle","bf3_suppressor" }, default = 1 },
    ...
}
```

Conversion:
- Drop `offset` (TFA UI position — CUH UI uses a different layout)
- Drop `order` (TFA UI sort order)
- Add `name` (slot label shown in CUH UI)
- Add `default = 1` (auto-apply first attachment on first ApplyAttachments — or `0` for "none")

### 2.10 Laser sight fields

| TFA field | Used by | TFA purpose | CUH equivalent | Migration notes |
|---|---|---|---|---|
| `SWEP.LaserSightModAttachment` | 3 (acwr, mk11, mp7) | VM attachment index for laser origin | (no CUH equivalent — CUH doesn't have a laser system built-in) | drop OR implement custom in `PostDrawViewModel` |
| `SWEP.LaserModAttachmentWorld` | 3 (acwr, mk11, mp7) | WM attachment index for laser origin | (no CUH equivalent) | drop |

For the pilot port, we'll drop the laser sight visual but keep the bodygroup swap (so the laser bodygroup still toggles when the attachment is equipped). The `VElements["laser"]` visibility toggle in `bf3_laser.lua` will work because CUH's VElement `active` flag is the same field.

### 2.11 ViewModelPunch fields

7 weapons set `SWEP.ViewModelPunchPitchMultiplier`, `ViewModelPunchYawMultiplier`, `ViewModelPunch_VertialMultiplier` (sic), etc. — these are TFA's viewmodel-pitch-on-fire system.

CUH doesn't have an equivalent. Drop these for the pilot port.

---

## 3. Animation mapping (TFA conventions → CUH conventions)

This is the most critical section. CUH looks up animations by string key (e.g. `"shoot"`, `"reload"`); if the key isn't in `SWEP.Animations`, it falls back to an `ACT_VM_*` activity. The BF3 models' sequence names don't match CUH's expected keys, so we MUST build an `SWEP.Animations` table per weapon that maps CUH's keys to the actual sequence names.

### 3.1 CUH's expected animation keys (from base code analysis)

| Key | When it's looked up | Fallback activity |
|---|---|---|
| `shoot` | hipfire | `ACT_VM_PRIMARYATTACK` |
| `shoot_sil` | hipfire + silenced | `ACT_VM_PRIMARYATTACK_SILENCED` or `ACT_VM_PRIMARYATTACK` |
| `shoot_ads` | ADS fire | (same as `shoot` if not defined) |
| `shoot_ads_sil` | ADS fire + silenced | (same as `shoot_sil`) |
| `shoot_last` | last bullet before empty | (same as `shoot`) |
| `shoot_last_sil` | last bullet + silenced | (same as `shoot_sil`) |
| `reload` | tactical reload (clip has ammo) | `ACT_VM_RELOAD` |
| `reload_sil` | tactical reload + silenced | `ACT_VM_RELOAD` |
| `reload_empty` | empty reload | `ACT_VM_RELOAD_EMPTY` |
| `reload_empty_sil` | empty reload + silenced | `ACT_VM_RELOAD_EMPTY` |
| `idle` | idle (clip has ammo) | `ACT_VM_IDLE` |
| `idle_empty` | idle (clip is empty) | `ACT_VM_IDLE` |
| `idle_empty_sil` | idle empty + silenced | `ACT_VM_IDLE` |
| `draw` / `first_draw` | deploy | `ACT_VM_DRAW` / `ACT_VM_DRAW_DEPLOYED` |
| `melee` | rifle butt attack | `ACT_VM_MELEE` |
| `inspect` / `inspect_empty` | inspect key (T) | `ACT_VM_FIDGET` |
| `iron_in` | enter ADS | `ACT_VM_DEPLOY` |
| `iron_out` | exit ADS | `ACT_VM_UNDEPLOY` |
| `iron_idle` | idle in ADS | `ACT_VM_IDLE_DEPLOYED` |
| `sprint_in` / `sprint_out` / `sprint_idle` | sprint transitions | `ACT_VM_SPRINT_*` |
| `mantle` | mantle/vault animation | `ACT_VM_DRAW` |

### 3.2 Shotgun-specific keys (from `weapon_custom_uh_base_shotty.lua`)

| Key | When | Fallback |
|---|---|---|
| `start_reload` | begin reload (open chamber) | `ACT_SHOTGUN_RELOAD_START` |
| `reload_loop` | per-shell insert | `ACT_VM_RELOAD` |
| `after_reload` | end reload (close chamber) | `ACT_SHOTGUN_RELOAD_FINISH` |
| `pump` | pump action between shots | `ACT_SHOTGUN_PUMP` |
| `rechamber` | alternate name for pump | `ACT_SHOTGUN_PUMP` |

### 3.3 Mapping per pattern

#### Pattern A (AR/Carbine/LMG/DMR) — base_*/foregrip_* animations

```lua
SWEP.Animations = {
    ["shoot"]        = "base_fire",
    ["reload"]       = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["idle"]         = "base_idle",
    ["draw"]         = "base_draw",
    ["first_draw"]   = "base_draw",
    -- iron sights (no BF3-specific ADS anims; fall back to ACT_VM_*)
    ["iron_in"]      = "base_idle",
    ["iron_idle"]    = "base_idle",
    ["iron_out"]     = "base_idle",
    -- inspect (no BF3-specific fidget; fall back to ACT_VM_FIDGET)
    -- sprint (no BF3-specific sprint; fall back to ACT_VM_SPRINT_*)
    -- melee (no BF3-specific melee; fall back to ACT_VM_MELEE)
}

-- When bf3_grip is equipped, the Attach() function overrides Animations to use foregrip_* variants
```

**Per-weapon variations:**
- `aek971, ak74, aks74u, asval, g36c`: use `base_reloadempty` (no underscore) — set `["reload_empty"] = "base_reloadempty"`
- `scarh`: adds `base_fire_empty` — set `["shoot_last"] = "base_fire_empty"` (plays when last bullet fired)
- `m249`: uses `idle1` not `base_idle` — set `["idle"] = "idle1"`; only has `base_*` (no foregrip)
- `mk11`: full pattern + can use `bf3_scope` — same as base pattern, scope just changes stats

#### Pattern B (Pistol) — idle/draw/fire/shoot_empty/reload/reload_full/fire_empty

```lua
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]    = "shoot_empty",   -- dry fire on last shot
    ["shoot_empty"]   = "fire_empty",    -- alternate empty-shoot
    ["reload"]        = "reload_full",   -- tactical reload (clip has ammo)
    ["reload_empty"]  = "reload",        -- empty reload
    ["idle"]         = "idle",
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}
```

**Note:** TFA's pistol pattern distinguishes between `reload` (empty) and `reload_full` (tactical). CUH's convention is the opposite: `reload` = tactical (clip has ammo), `reload_empty` = empty. So we swap them in the mapping.

#### Pattern C (Sniper) — idle/draw/fire/reload/reload_empty

```lua
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["reload"]       = "reload",
    ["reload_empty"] = "reload_empty",
    ["idle"]         = "idle",
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}
```

**Note:** When `bf3_scope` is equipped, the attachment sets `wep.Scoped = true; wep.BoltAction = true`. CUH doesn't have a built-in bolt-action system, so we'll need to either:
- Drop the bolt-action flag (simplest — just plays `fire` then back to `idle`), OR
- Add a custom `ShootAnimation` that plays `fire`, then waits ~0.5s, then plays `idle` (the bolt cycling animation)

For the pilot port, drop the bolt-action flag.

#### Pattern D (Revolver) — mp412: Idle/draw/fire/reload/fire_empty; magnum44: idle/fire/reload/draw/fire_empty

```lua
-- mp412:
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_empty",   -- last shot dry-fire
    ["reload"]       = "reload",
    ["reload_empty"] = "reload",       -- revolvers only have one reload anim
    ["idle"]         = "Idle",          -- note capital I!
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}

-- magnum44:
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_empty",
    ["reload"]       = "reload",
    ["reload_empty"] = "reload",
    ["idle"]         = "idle",
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}
```

**Note:** `mp412` has `DisableChambering = true` — set `SWEP.Chambering = false` in CUH (revolver cylinder doesn't chamber a round).

#### Pattern E (Pump Shotgun) — idle/draw/fire1/fire2/reload_insert/reload_start/reload_end

```lua
SWEP.Animations = {
    ["shoot"]         = { "fire1", "fire2" },  -- table = pick random
    ["reload"]        = "reload_start",       -- begin reload (open chamber)
    ["reload_loop"]   = "reload_insert",      -- per-shell insert
    ["reload_empty"]  = "reload_end",         -- end reload (close chamber)
    ["idle"]          = "idle",
    ["draw"]          = "draw",
    ["first_draw"]    = "draw",
    ["pump"]          = "reload_insert",      -- pump action (some shotguns pump between shots)
}
```

**Note:** `SWEP.Base` should be `weapon_custom_uh_base_shotty` (CUH's shotgun base), not `weapon_cuh_base_gun`. The shotgun base has per-shell reload logic. We need to verify the shotgun base still works (it's part of the CUH addon but no weapons currently use it — see `weapon_cuh_base_gun` for the modern customization layer; the shotgun base is older and might not be fully integrated).

#### Pattern F (Auto Shotgun, saiga12) — idle1/draw/fire/reload/reload_empty

```lua
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["reload"]       = "reload",
    ["reload_empty"] = "reload_empty",
    ["idle"]         = "idle1",
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}
```

**Note:** `saiga12` is functionally a rifle (box-mag reload), so use `weapon_cuh_base_gun` (not the shotgun base). But it fires `buckshot` ammo with `NumShots = 12`.

#### Pattern G (SMG) — idle/draw/fire/reload/reload_empty

```lua
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["reload"]       = "reload",
    ["reload_empty"] = "reload_empty",
    ["idle"]         = "idle",
    ["draw"]         = "draw",
    ["first_draw"]   = "draw",
}
```

---

## 4. Attachment porting details

Each TFA attachment file needs to be ported to CUH format. The structure is largely compatible (both use `ATTACHMENT = {}` + `Name`/`Icon`/`ShortName`/`WeaponTable`/`Attach`/`Detach`), but there are differences:

### 4.1 Common porting steps for all 9 attachments

1. Move file from `lua/tfa/att/bf3_*.lua` to `lua/cuh_attachments/bf3_*.lua`
2. Drop the `if not TFA_ATTACHMENT_ISUPDATING then TFAUpdateAttachments() end` boilerplate at the bottom
3. (Optional) Add `ATTACHMENT.ModelPath = nil` and `ATTACHMENT.PartClass = nil` — BF3 attachments are bodygroup-only, they don't swap models. CUH's attachment loader handles nil `ModelPath` fine.
4. (Optional) Add `ATTACHMENT.Description = { Color(255,255,255), "..." }` — BF3 attachments don't have descriptions, but CUH's UI shows them
5. The `WeaponTable` block needs no changes — CUH's `ApplyAttachments` parses the same `Bodygroups_V`/`Bodygroups_W`/`IronSightsPos`/`IronSightsAng`/`Secondary.IronFOV`/`Primary.KickUp`/etc. structure
6. The `Attach()`/`Detach()` functions need updates:

### 4.2 Per-attachment Attach/Detach changes

#### `bf3_reflex`, `bf3_kobra` — set `wep.Secondary.IronFOV = 60` in Attach

TFA: sets `wep.Secondary.IronFOV = 60` (overwrite the weapon's default).

CUH: `Secondary.IronFOV` is read by `AdjustMouseSensitivity`. Setting it via `Attach()` works — but it won't be reverted automatically (since `Detach()` is never called). The fix: use `WeaponTable.Secondary.IronFOV = function(wep, val) return wep.Secondary.IronFOV_Collimator or val * 0.95 end` instead of `Attach()`. This way `ApplyAttachments` handles the value via the stat cache, and the original value is auto-restored via `_defaultSnapshot`.

Migration: drop the `Attach`/`Detach` functions entirely; rely on the `WeaponTable.Secondary.IronFOV` function.

#### `bf3_eotech`, `bf3_acog` — no side-effects (commented out)

Migration: drop the empty `Attach`/`Detach` functions.

#### `bf3_scope` — sets `wep.Scoped = true; wep.BoltAction = true`

TFA: sets two flags that TFA's `Think` checks to enable scope view + bolt-cycle animation.

CUH: doesn't have `BoltAction` support; `Scoped` is replaced by setting `SWEP.ScopeTexture` to a Material. The scope view is rendered when `wep:GetUHBool("Zooming")` is true AND `wep.ScopeTexture` is set.

Migration: in `Attach(wep)`, set `wep.ScopeTexture = Material("bf3/scope.png", "smooth")`. In `Detach(wep)`, set `wep.ScopeTexture = nil` (but `Detach` is never called — so we need a different mechanism).

Better migration: move the `Scoped` flag to a `WeaponTable` entry. CUH doesn't have `WeaponTable.Scoped` directly, but we can add a custom stat:
```lua
ATTACHMENT.WeaponTable = {
    ["ScopeTexture"] = function(wep, val) return Material("bf3/scope.png", "smooth") end,
    -- BoltAction dropped for now
}
```
This works because `ApplyAttachments` Step 5 calls `SetStat("ScopeTexture", <Material>)` which restores the original (nil) when the attachment is removed.

#### `bf3_muzzle`, `bf3_suppressor` — `bf3_suppressor` calls `wep:SetSilenced(wep.Silenced)`

TFA: `wep:SetSilenced(true)` is a TFA method that sets a networked bool and triggers the silenced fire sound.

CUH: `wep:GetNWBool("Silenced")` is read by `PrimaryAttack` to choose `SilSound` vs `Sound`, and by `EasySendWeaponAnim` to append `_sil` to the lookup key. There's no `SetSilenced` method — instead, set `wep:SetNWBool("Silenced", true)` directly.

Migration:
```lua
function ATTACHMENT:Attach(wep)
    wep:SetNWBool("Silenced", true)
end
function ATTACHMENT:Detach(wep)
    wep:SetNWBool("Silenced", false)
end
```

But again, `Detach` is never called. We need to handle this via a `WeaponTable` entry — but `WeaponTable` doesn't support arbitrary method calls, only stat values.

The cleanest solution: extend CUH's `ApplyAttachments` to handle a special `WeaponTable.Silenced = true` key that maps to `wep:SetNWBool("Silenced", true)`. But that requires modifying the CUH base, which we want to avoid for the pilot port.

Alternative: just call `wep:SetNWBool("Silenced", true)` in `Attach()` and accept that it won't be reverted automatically. The user can manually switch off the suppressor by selecting "None" in the muzzle slot — but `Silenced` will stay true until they re-deploy the weapon. This is a known CUH limitation.

For the pilot port, use the simple `Attach()` approach and document the limitation.

#### `bf3_laser` — toggles VElement visibility

TFA: sets `VElements["laser"].active = true` and `VElements["laser_beam"].active = true` via the `WeaponTable.VElements` mechanism.

CUH: same mechanism — `WeaponTable.VElements = { ["laser"] = { ["active"] = true } }` works the same way.

Migration: no changes needed to the `WeaponTable`. But drop the `LaserSightAttachment`/`LaserSightAttachmentWorld` stat functions since CUH doesn't have a laser sight system. Keep the `VElements` and `Bodygroups_V`/`Bodygroups_W` entries.

#### `bf3_grip` — overrides Animations + HoldType

TFA: overrides the `Animations` table with `foregrip_*` variants + sets `wep.HoldType = "smg"` + calls `wep:ChooseIdleAnim()`.

CUH: `WeaponTable.Animations` is a per-key merge — so `["idle"] = "foregrip_idle"` overrides just that key, not the whole table. We need to override `idle`, `draw`, `shoot`, `reload`, `reload_empty` to their `foregrip_*` variants. TFA also includes `["shoot1"]` and `["shoot1_empty"]` and `["loop"]` and `["base_fireselect"]` — these are TFA-specific and don't have CUH equivalents. Drop them.

The HoldType change is trickier. CUH doesn't have `WeaponTable.HoldType` support. We'd need to set it in `Attach(wep)`:
```lua
function ATTACHMENT:Attach(wep)
    wep.HoldType = "smg"
end
```

But again, this won't revert when the attachment is removed. For the pilot port, drop the HoldType change — it's a minor visual difference (smg vs ar2 hold anim).

Migration:
```lua
ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [2] = 1 },
    ["Bodygroups_W"] = { [2] = 1 },
    ["Primary"] = {
        ["KickUp"] = function(wep, stat) return stat * 0.9 end,
        ["KickDown"] = function(wep, stat) return stat * 0.9 end,
    },
    ["Animations"] = {
        ["shoot"]        = "foregrip_fire",
        ["reload"]       = "foregrip_reload",
        ["reload_empty"] = "foregrip_reload_empty",
        ["idle"]         = "foregrip_idle",
        ["draw"]         = "foregrip_draw",
    },
}
-- Drop Attach/Detach entirely
```

---

## 5. Pilot port plan — 8 representative weapons

One per category:

| Category | Weapon | Pattern | Notes |
|---|---|---|---|
| Assault Rifle | `bf3_m416` | A (base/foregrip) | Standard AR, has all 4 attachment slots |
| Carbine | `bf3_acwr` | A (base/foregrip) | Has VElements (laser), already in the bf3-c-hands branch |
| DMR | `bf3_mk11` | A (base/foregrip) | Has BlowbackBoneMods, scope attachment, VElements |
| LMG | `bf3_m249` | A (base only, no foregrip) | 100-round belt, idle1 not base_idle |
| SMG | `bf3_mp7` | G (smg pattern) | Has VElements (laser), smg holdtype |
| Shotgun | `bf3_870mcs` | E (pump shotgun) | Per-shell reload, needs `weapon_custom_uh_base_shotty` |
| Sniper | `bf3_m98b` | C (sniper) | Has ViewModelBoneMods, scope attachment |
| Pistol | `bf3_m1911` | B (pistol) | Suppressor attachment only |
| Revolver | `bf3_mp412` | D (revolver) | `Chambering = false`, no shell eject |

That's 9 representatives (one extra for revolver since it's distinct from pistol). Each will be ported with its attachments, simulator-tested, and pushed to a new `cuh-port-pilot` branch on `UnderhellCBase`.

---

## 6. Known limitations of the pilot port

These are things we're explicitly NOT doing in the pilot port, to keep scope manageable. They can be added later if the user wants them:

1. **Burst fire mode** — CUH doesn't have built-in burst. The 5 BF3 weapons that use `2Burst` (m16a3, m4a1, m416, acwr, famas) will only get Auto/Semi/Safe.
2. **Bolt-action sniper** — `bf3_scope` won't set `BoltAction = true` since CUH doesn't support it. Snipers will fire semi-auto even with the scope equipped.
3. **Blowback** — CUH doesn't have a blowback system. The 22 BF3 weapons that use `BlowbackEnabled = true` will lose the model-recoil effect.
4. **Laser sight visual** — `bf3_laser` will toggle the VElement visibility (laser bodygroup model appears) but won't draw an actual laser beam (CUH has no laser system).
5. **Inspect animations** — BF3 models don't have inspect sequences; CUH will fall back to `ACT_VM_FIDGET` (which will likely not exist on BF3 models → no inspect anim plays).
6. **Sprint animations** — BF3 models don't have sprint sequences; CUH will fall back to `ACT_VM_SPRINT_*` (same situation).
7. **Suppressor revert** — `bf3_suppressor` sets `wep:SetNWBool("Silenced", true)` in `Attach()` but never reverts it (since `Detach()` isn't called). Selecting "None" in the muzzle slot won't un-silence the weapon until re-deploy.
8. **InspectPos/Ang** — CUH doesn't use these (no custom inspect pose); the data is dropped.
9. **Per-weapon ViewModelPunch** — all 7 ViewModelPunch* fields dropped.
10. **SprintBobMult** — dropped (CUH has its own sprint bob).
11. **Fire sound pitch variation** — TFA varies fire sound pitch per shot; CUH plays the same sound. Could be added later via `AnimSounds` or a custom `PostShoot` hook.

---

## 7. Next steps

1. Pick `bf3_m416` (Assault Rifle) as the first pilot weapon — it has the standard pattern with all 4 attachment slots and is a good baseline.
2. Port `bf3_m416.lua` + 4 attachments (`bf3_reflex`, `bf3_kobra`, `bf3_eotech`, `bf3_acog`) + 2 muzzle attachments (`bf3_muzzle`, `bf3_suppressor`) + `bf3_laser` + `bf3_grip` (8 attachments total — these are shared across all weapons, so we only port them once).
3. Extend the Lua simulator to validate the ported SWEP table (required fields present, types correct) + attachments table (every ID in `SWEP.Attachments[].atts` exists in `CustomUH.Attachments`) + animation keys (every sequence name in `SWEP.Animations` exists in the model's `$sequence` list).
4. Run the simulator, fix every error.
5. Push to `cuh-port-pilot` branch on `UnderhellCBase`.
6. Wait for user's in-game test feedback, then port the remaining 8 categories following the same template.

---

## Appendix A: Complete BF3 weapon quick-reference table

| Weapon | HoldType | Type | Pattern | Sequence list | Has VElements | Has Attachments | Special |
|---|---|---|---|---|---|---|---|
| bf3_870mcs | shotgun | Shotgun | E | idle draw fire1 fire2 reload_insert reload_start reload_end | no | none | `Shotgun = true`, `Automatic = false`, `NumShots = 12`, `LuaShellEjectDelay = 0.25` |
| bf3_acwr | ar2 | Carbine | A | base_idle/draw/fire/reload/reload_empty + foregrip_* | yes (laser) | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_aek971 | ar2 | AR | A | base_* + foregrip_* (uses `base_reloadempty`) | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_ak74 | ar2 | AR | A | base_* + foregrip_* (uses `base_reloadempty`) | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_aks74u | ar2 | Carbine | A | base_* + foregrip_* (uses `base_reloadempty`) | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_asval | ar2 | Carbine | A | base_* + foregrip_* (uses `base_reloadempty`) | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_famas | ar2 | AR | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_g18 | revolver | Pistol | B | idle draw fire shoot_empty reload reload_full fire_empty | no | 1 slot: muzzle (suppressor only) | `Automatic = true`, `FireModes = {Auto, Single, Safe}` |
| bf3_g36c | ar2 | Carbine | A | base_* + foregrip_* (uses `base_reloadempty`) | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_g3a3 | ar2 | AR | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, Single, Safe}` |
| bf3_l85a2 | ar2 | AR | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_m1014 | shotgun | Shotgun | E | idle draw fire1 fire2 reload_insert reload_start reload_end | no | none | `Shotgun = true`, `Automatic = true` (auto shotgun), `NumShots = 12` |
| bf3_m16a3 | ar2 | AR | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_m1911 | revolver | Pistol | B | idle draw fire shoot_empty reload reload_full fire_empty | no | 1 slot: muzzle (suppressor only) | `FireModes = {Single, Safe}` |
| bf3_m249 | ar2 | LMG | A (modified) | idle1 draw fire reload (NO foregrip_*) | no | 2 slots: optic, muzzle | `BlowbackEnabled`, `ClipSize = 100`, `FireModes = {Auto, Single, Safe}` |
| bf3_m416 | ar2 | AR | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_m4a1 | ar2 | Carbine | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, 2Burst, Single, Safe}` |
| bf3_m82a3 | ar2 | Sniper | C | idle fire draw reload reload_empty | no | 2 slots: optic, muzzle | `Scoped = false` (default), `ScopeTable`, `FireModes = {Single, Safe}` |
| bf3_m9 | revolver | Pistol | B | idle draw fire shoot_empty reload reload_full fire_empty | no | 1 slot: muzzle (suppressor only) | `FireModes = {Single, Safe}` |
| bf3_m93r | revolver | Pistol | B | idle draw fire shoot_empty reload reload_full fire_empty | no | 1 slot: muzzle (suppressor only) | `Automatic = true`, `FireModes = {Auto, 2Burst, Single, Safe}` (burst pistol) |
| bf3_m98b | ar2 | Sniper | C | idle draw fire reload reload_empty | no (has ViewModelBoneMods) | 2 slots: optic, muzzle | `Scoped = false`, `ScopeTable`, `FireModes = {Single, Safe}`, `Damage = 150` |
| bf3_magnum44 | revolver | Pistol | D (revolver) | idle fire reload draw fire_empty | no | none | `DisableChambering = true`, `FireModes = {Single, Safe}` |
| bf3_mk11 | ar2 | DMR | A | base_* + foregrip_* | yes (laser) | 4 slots: optic (with scope), muzzle, laser, grip | `BlowbackEnabled`, `BlowbackBoneMods`, `Scoped = false`, `ScopeTable`, `Damage = 150` |
| bf3_mp412 | revolver | Pistol | D (revolver) | Idle draw fire reload fire_empty | no | none | `DisableChambering = true`, `Blowback_Only_Iron`, `FireModes = {Single, Safe}` |
| bf3_mp443 | revolver | Pistol | B | idle draw fire shoot_empty reload reload_full fire_empty | no | 1 slot: muzzle (suppressor only) | `FireModes = {Single, Safe}` |
| bf3_mp7 | smg | SMG | G | idle reload reload_empty draw fire | yes (laser) | 3 slots: optic, muzzle, laser | `BlowbackEnabled`, `FireModes = {Auto, Single, Safe}`, `RPM = 1100` |
| bf3_pp19 | ar2 | SMG | G | idle draw fire reload reload_empty | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, Single, Safe}` |
| bf3_saiga12 | ar2 | Shotgun | F (auto shotgun) | idle1 draw fire reload reload_empty | no | 2 slots: optic, muzzle | `Shotgun = true`, `Automatic = true`, `NumShots = 12`, functionally a rifle |
| bf3_scarh | ar2 | Carbine | A | base_* + foregrip_* + base_fire_empty + foregrip_fire_empty | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, Single, Safe}` |
| bf3_spas12 | shotgun | Shotgun | E | idle draw fire1 fire2 reload_insert reload_start reload_end | no | none | `Shotgun = true`, `Automatic = true`, `NumShots = 12` |
| bf3_sv98 | ar2 | Sniper | C | idle draw fire reload reload_empty | no | 2 slots: optic, muzzle | `Scoped = false`, `ScopeTable`, `FireModes = {Single, Safe}` |
| bf3_ump45 | ar2 | SMG | A | base_* + foregrip_* | no | 4 slots: optic, muzzle, laser, grip | `BlowbackEnabled`, `FireModes = {Auto, Single, Safe}` |

---

## Appendix B: CUH base lookup keys (from source code analysis)

These are the animation keys CUH looks up via `self.Animations[key]` or `EasySendWeaponAnim(key, ACT_*)`:

### Gun base (`weapon_custom_uh_base_gun.lua`)
- `shoot`, `shoot_sil`, `shoot_ads`, `shoot_ads_sil`, `shoot_last`, `shoot_last_sil` (PrimaryAttack)
- `reload`, `reload_sil`, `reload_empty`, `reload_empty_sil` (Reload)
- `idle`, `idle_empty`, `idle_empty_sil` (Think idle)
- (firemode switch: looks up `ACT_VM_*` directly, no Animations key)

### Root base (`weapon_custom_uh_base.lua`)
- `draw`, `first_draw` (Deploy)

### CUH layer (`weapon_cuh_base_gun.lua`)
- `melee` (MeleeAttack — overrides fire mode key)

### Shotgun base (`weapon_custom_uh_base_shotty.lua`)
- `start_reload`, `reload_loop`, `after_reload`, `pump`, `rechamber` (per-shell reload)

### Per-weapon overrides (from existing CUH weapons like `weapon_m8a1_scotia`)
- `iron_in`, `iron_out`, `iron_idle` (deploy/undeploy/loop ADS — looked up in `HandleIronsightsAnimations`)
- `inspect`, `inspect_empty` (looked up in `Deploy` when `CUHInspectOnMenu` is true)
- `sprint_in`, `sprint_out`, `sprint_idle` (looked up in `HandleSprintingAnimations`)
- `mantle` (mantle/vault — looked up in `HandleMantle`)

---

## Appendix C: Pilot port file structure

```
cuh-port-pilot branch on LeRatEmperor/UnderhellCBase
├── lua/
│   ├── weapons/
│   │   ├── weapon_cuh_bf3_m416.lua      (Assault Rifle pilot)
│   │   ├── weapon_cuh_bf3_acwr.lua      (Carbine pilot)
│   │   ├── weapon_cuh_bf3_mk11.lua      (DMR pilot)
│   │   ├── weapon_cuh_bf3_m249.lua      (LMG pilot)
│   │   ├── weapon_cuh_bf3_mp7.lua       (SMG pilot)
│   │   ├── weapon_cuh_bf3_870mcs.lua    (Shotgun pilot)
│   │   ├── weapon_cuh_bf3_m98b.lua      (Sniper pilot)
│   │   ├── weapon_cuh_bf3_m1911.lua     (Pistol pilot)
│   │   └── weapon_cuh_bf3_mp412.lua     (Revolver pilot)
│   └── cuh_attachments/
│       ├── bf3_reflex.lua
│       ├── bf3_kobra.lua
│       ├── bf3_eotech.lua
│       ├── bf3_acog.lua
│       ├── bf3_scope.lua
│       ├── bf3_muzzle.lua
│       ├── bf3_suppressor.lua
│       ├── bf3_laser.lua
│       └── bf3_grip.lua
└── scripts/
    └── cuh_sim_harness_bf3.lua          (extended simulator for BF3 port validation)
```

Each weapon file is named `weapon_cuh_bf3_<weapon>.lua` (not `bf3_<weapon>.lua`) so they don't collide with the original TFA weapon files if the user has both installed. The class name follows the file name (e.g. `SWEP.ClassName = "weapon_cuh_bf3_m416"`).

---

End of audit. Next step: port `weapon_cuh_bf3_m416` + 9 attachments + simulator harness.
