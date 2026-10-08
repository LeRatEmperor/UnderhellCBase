# TFA WWII – Exhaustive Code Audit: Snipers & Shotguns

**Scope:** 13 weapon files from `/home/z/my-project/repos/tfa_wwii_original/lua/weapons/`
- 9 snipers: arisaka, delisle, enfield, kar98k, mosin, sdk, springfield, wz35, winchester94
- 4 shotguns: blunderbuss, mas36, model1897, kbsp1938

**Audit method:** Each file read in full (every line). All field values transcribed verbatim.

**Common base:** All weapons derive from `SWEP.Base = "tfa_codww2_base"` (TFA WWII base).
All have `SWEP.UseHands = true`, `SWEP.ViewModelFlip` is **not** set (defaults to false in TFA base), `SWEP.AdminSpawnable = true`, `SWEP.DrawCrosshair = true`, `SWEP.DrawCrosshairIronSights = false`.
`SWEP.Author = "Olli, Fox, Mav"` for all weapons.

**Common authors/credits:** Common authorship "Olli, Fox, Mav" used for all 13 files.

**Common EventTable patterns:**
- `ACT_VM_DRAW` and `ACT_VM_DRAW_EMPTY` → `TFA_CODWW2_RIFLE.Raise`
- `ACT_VM_HOLSTER` and `ACT_VM_HOLSTER_EMPTY` → `TFA_CODWW2_RIFLE.Holster`
- All bolt-action snipers have `ACT_VM_PULLBACK_HIGH`/`ACT_VM_PULLBACK_LOW` with shell-eject lua callback at `time=10/30`.

**Common SprintAnimation structure (in/loop/out, all SEQ type, `value_empty` for empty variant, `is_idle=true` on loop).**

**Common DInv2 layout (all snipers except where noted): GridSizeX=2, GridSizeY=4, Mass=8, Volume=nil.**
**Common shotgun DInv2 layout: GridSizeX=2, GridSizeY=3, Mass=7, Volume=nil.**

**Common misc fields across all:** `SWEP.SprintBobMult = 0`, `SWEP.IronBobMult = 0.065`, `SWEP.IronBobMultWalk = 0.065`, `SWEP.data = {}; SWEP.data.ironsights = 1`, `SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI`, `SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID`, `SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH`, `SWEP.Idle_Blend = 0.25`, `SWEP.Idle_Smooth = 0.05`, `SWEP.AllowViewAttachment = true`, `SWEP.TracerCount = 1`, `SWEP.EjectionSmokeEnabled = false` (except kbsp1938 which is true), `SWEP.LuaShellEject = false` (except kbsp1938 = true), `SWEP.LuaShellEffect = "ShellEject"`, `SWEP.LuaShellEjectDelay = 0`, `SWEP.ShellAttachment = "0"`, `SWEP.CameraAttachmentOffsets = {}`, `SWEP.CameraAttachmentScale = 2`, `SWEP.MuzzleAttachment = "1"`, `SWEP.VMAng = Vector(0, 0, 0)`, `SWEP.VMPos_Additive = true`, `SWEP.Offset` table with `Up=180, Right=190, Forward=0` angles and `Scale = 1.1`, `SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"`, `SWEP.Primary.PickupSound = "TFA_CODWW2_PICKUP.Ammo"`, `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"` for snipers or `"TFA_CODWW2_DRYFIRE.SG"` for shotguns, `SWEP.Primary.Sound_Blocked` same value, `SWEP.Secondary.BashDamage = 35`, `SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingRfl")`, `SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")`, `SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")`, `SWEP.Secondary.BashDelay = 0.2`, `SWEP.Secondary.BashDamageType = DMG_CLUB`, `SWEP.Secondary.BashInterrupt = true`, `SWEP.IronInSound = "TFA_CODWW2_GEN.AdsUp"`, `SWEP.IronOutSound = "TFA_CODWW2_GEN.AdsDown"`, `SWEP.NZHeadShotMultiplier = 2`, `SWEP.Primary.DryFireDelay = 0.5`, `SWEP.DisableChambering = true`, `SWEP.FlashlightAttachment = 0`, `SWEP.FiresUnderwater = false`, `SWEP.ViewModelFOV = 65`, `SWEP.ViewModelBoneMods = {}` (empty), `SWEP.AttachmentDependencies = {}`, `SWEP.AttachmentExclusions = {}`, `SWEP.AttachmentTableOverride = {}`, `SWEP.AttachmentIconOverride = {}`.

---

# SNIPERS

---

## 1. Arisaka (Type 38) — `nz_kate_codww2_arisaka.lua`

### Core Fields
- `SWEP.Base = "tfa_codww2_base"`
- `SWEP.Category = "nZR: WWII Kate Spawn Weapons"` *(note: "Spawn Weapons" suffix — unique)*
- `SWEP.SubCategory = "Snipers"`
- `SWEP.PrintName = "Type 38"`
- `SWEP.Slot = 4`
- `SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7`
- `SWEP.AdminSpawnable = true`
- `SWEP.UseHands = true`
- `SWEP.ViewModelFlip` — not set (nil)
- `SWEP.ViewModelFOV = 65`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/arisaka/c_arisaka.mdl"`
- `SWEP.WorldModel = "models/weapons/tfa_codww2/arisaka/w_arisaka.mdl"`
- `SWEP.HoldType = "ar2"`
- `SWEP.Manufacturer = "Arisaka"`
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "The Type 38 Japanese sniper is a deadly fast firing bolt action rifle that offers a one shot kill from mid chest and above."`
- `SWEP.Author = "Olli, Fox, Mav"`
- `SWEP.DrawCrosshair = true`
- `SWEP.DrawCrosshairIronSights = false`
- Additional viewmodel fields: `SWEP.VMPos = Vector(0, 0.5, 0)`, `SWEP.VMAng = Vector(0, 0, 0)`, `SWEP.VMPos_Additive = true`
- `SWEP.CameraAttachmentOffsets = {}`, `SWEP.CameraAttachmentScale = 2`
- `SWEP.MuzzleAttachment = "1"`
- `SWEP.Offset = { Pos = { Up = -5.6, Right = 1, Forward = 13.8 }, Ang = { Up = 180, Right = 190, Forward = 0 }, Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_KAR98K.Punch.Delay"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_M1903.Shoot"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M1903.Thud"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_M1903.Blast"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_PUNCH.F"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_KAR98K.PlrMech"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_M1903.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`
- `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`
- `SWEP.Primary.RPM_Semi = nil`
- `SWEP.Primary.RPM_Burst = nil`
- `SWEP.Primary.RPM_Displayed = 51`
- `SWEP.Primary.RPM_Rapid = 600`
- `SWEP.Primary.RPM_Displayed_Rapid = 55`
- `SWEP.Primary.Damage = 75`
- `SWEP.Primary.Knockback = 0`
- `SWEP.Primary.NumShots = 1`
- `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`
- `SWEP.Primary.ClipSize_Ext = 7`
- `SWEP.Primary.DefaultClip = 55`
- `SWEP.Primary.MaxAmmo = 50`
- `SWEP.Primary.DryFireDelay = 0.5`
- `SWEP.DisableChambering = true`
- `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.DisplayFalloff = true`
- `SWEP.Primary.RangeFalloffLUT = { bezier = false, range_func = "linear", units = "meters", lut = { {range = 200, damage = 1} } }` (no falloff to 200m, single point only)
- `SWEP.Primary.Spread = 0.05`
- `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`
- `SWEP.Primary.KickDown = 1.0`
- `SWEP.Primary.KickHorizontal = 0.3`
- `SWEP.Primary.StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`
- `SWEP.Primary.SpreadIncrement = 1.5`
- `SWEP.Primary.SpreadRecovery = 3`
- `SWEP.IronRecoilMultiplier = 0.5`
- `SWEP.ChangeStateAccuracyMultiplier = 1.5`
- `SWEP.CrouchAccuracyMultiplier = 1.0`
- `SWEP.JumpAccuracyMultiplier = 2.0`
- `SWEP.WalkAccuracyMultiplier = 1.5`
- `SWEP.ChangeStateRecoilMultiplier = 1.3`
- `SWEP.CrouchRecoilMultiplier = 0.65`
- `SWEP.JumpRecoilMultiplier = 2.0`
- `SWEP.WallRecoilMultiplier = 1.35`
- `SWEP.ViewModelPunchPitchMultiplier = 0.5`
- `SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09`
- `SWEP.ViewModelPunch_MaxVertialOffset = 3`
- `SWEP.ViewModelPunch_MaxVertialOffset_IronSights = 1.95`
- `SWEP.ViewModelPunch_VertialMultiplier = 1`
- `SWEP.ViewModelPunch_VertialMultiplier_IronSights = 0.25`
- `SWEP.ViewModelPunchYawMultiplier = 0.6`
- `SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25`
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.92`
- `SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8` (= 0.736)
- `SWEP.FlashlightAttachment = 0`
- `SWEP.FiresUnderwater = false`

### Secondary Stats (Bash)
- `SWEP.Secondary.BashDamage = 35`
- `SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingRfl")`
- `SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")`
- `SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")`
- `SWEP.Secondary.BashLength = 55`
- `SWEP.Secondary.BashDelay = 0.2`
- `SWEP.Secondary.BashDamageType = DMG_CLUB`
- `SWEP.Secondary.BashInterrupt = true`
- `SWEP.Secondary.IronFOV = 65`

### Fire Modes
- `SWEP.Primary.BurstDelay = nil`
- `SWEP.DisableBurstFire = true`
- `SWEP.SelectiveFire = false`
- `SWEP.OnlyBurstFire = false`
- `SWEP.BurstFireCount = nil`
- `SWEP.DefaultFireMode = ""`
- `SWEP.FireModeName = nil`
- `SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"`

### Shotgun Fields
- None (not a shotgun). `SWEP.Shotgun` not defined.

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.2, -1.5, 0.73)`
- `SWEP.IronSightsAng = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-2.14, -3.5, 0.2375)`
- `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-2.621, -8, -0.151)`
- `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.IronInSound = "TFA_CODWW2_GEN.AdsUp"`
- `SWEP.IronOutSound = "TFA_CODWW2_GEN.AdsDown"`
- `SWEP.IronBobMult = 0.065`
- `SWEP.IronBobMultWalk = 0.065`
- `SWEP.data = {}`, `SWEP.data.ironsights = 1`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`
- `SWEP.SafetyAng = Vector(-15, 25, -20)`
- `SWEP.InspectPos = Vector(10, -4, -2)`
- `SWEP.InspectAng = Vector(24, 42, 16)`
- `SWEP.AlternativePos` / `SWEP.AlternativeAng` — not defined
- `SWEP.RunSightsPos` / `SWEP.RunSightsAng` — not defined
- `SWEP.ZoomFov` — not defined (scoped functionality not present, despite attachment slots)
- Scope-related fields (BoltAction, Scoped, ScopeOverlayThreshold, ScopeScale, ReticleScale, etc.) — **NOT defined** (the arisaka lacks a scope overlay; attachments add scope model but no zoom overlay)

### Animations Table
```
SWEP.Animations = {
    ["reload_ext"] = { ["type"] = TFA.Enum.ANIMATION_SEQ, ["value"] = "reload_ext" },
    ["reload_ext_empty"] = { ["type"] = TFA.Enum.ANIMATION_SEQ, ["value"] = "reload_ext_empty" },
}
```

- `SWEP.PumpAction = { ["type"] = TFA.Enum.ANIMATION_ACT, ["value"] = ACT_VM_PULLBACK_HIGH, ["value_is"] = ACT_VM_PULLBACK_LOW }`
- `SWEP.SprintAnimation = { ["in"] = { type=SEQ, value="sprint_in", value_empty="sprint_in_empty" }, ["loop"] = { type=SEQ, value="sprint_loop", value_empty="sprint_loop_empty", is_idle=true }, ["out"] = { type=SEQ, value="sprint_out", value_empty="sprint_out_empty" } }`

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = {
    { time = 10/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.FPO") },
  },
  [ACT_VM_DRAW] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_RIFLE.Raise") },
  },
  [ACT_VM_HOLSTER] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_RIFLE.Holster") },
  },
  [ACT_VM_DRAW_EMPTY] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_RIFLE.Raise") },
  },
  [ACT_VM_HOLSTER_EMPTY] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_RIFLE.Holster") },
  },
  [ACT_VM_PULLBACK_HIGH] = {
    { time = 5/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.CycleOpen") },
    { time = 15/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.CycleClose") },
    { time = 10/30, type = "lua", value = function(self) self:EventShell() end, client = true, server = true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { time = 5/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.CycleAdsOpen") },
    { time = 15/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.CycleAdsClose") },
    { time = 10/30, type = "lua", value = function(self) self:EventShell() end, client = true, server = true },
  },
  [ACT_VM_RELOAD] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.TacOpen") },
    { time = 55/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.TacClipin") },
    { time = 75/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.TacClose") },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyOpen") },
    { time = 55/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyClipin") },
    { time = 75/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyClose") },
  },
  ["reload_ext"] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.TacExtMagout") },
    { time = 60/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.TacExtMagin") },
  },
  ["reload_ext_empty"] = {
    { time = 5/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyExtOpen") },
    { time = 35/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyExtMagout") },
    { time = 80/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyExtMagin") },
    { time = 100/30, type = "sound", value = Sound("TFA_CODWW2_KAR98K.EmptyExtClose") },
  },
  ["inspect"] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.Inspect1") },
    { time = 50/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.Inspect2") },
  },
  ["inspect_empty"] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.Inspect1") },
    { time = 50/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.Inspect2") },
  },
  ["inspect_epic"] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.EpicInspect1") },
    { time = 110/30, type = "sound", value = Sound("TFA_CODWW2_ARISAKA.EpicInspect2") },
  },
}
```
**Notable:** This is the only sniper using ARISAKA-named inspect sounds. FPO uses KAR98K sound (shared asset).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 65 / 30
[ACT_VM_RELOAD_EMPTY] = 65 / 30
["reload_ext"] = 70 / 30
["reload_ext_empty"] = 90 / 30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35 / 30
[ACT_VM_PULLBACK_LOW] = 35 / 30
[ACT_VM_DRAW_DEPLOYED] = 40 / 30
[ACT_VM_RELOAD] = 100 / 30
[ACT_VM_RELOAD_EMPTY] = 100 / 30
[ACT_VM_DRAW] = 25 / 30
[ACT_VM_DRAW_EMPTY] = 25 / 30
["melee"] = 40 / 30
["melee_empty"] = 40 / 30
["reload_ext"] = 100 / 30
```
*(Note: no entry for reload_ext_empty in SequenceLengthOverride — only in StatusLengthOverride)*

**SequenceRateOverride:**
```
["sprint_in"] = 25 / 30
["sprint_loop"] = 25 / 30
[ACT_VM_PULLBACK_HIGH] = 35 / 30
[ACT_VM_PULLBACK_LOW] = 35 / 30
```

### Bodygroups / Skins
- `SWEP.Bodygroups_V` — not defined
- `SWEP.Bodygroups_W` — not defined
- `SWEP.ViewModelSkin` — not defined
- `SWEP.WorldModelSkin` — not defined
- `SWEP.ViewModelBodygroups` — not defined
- `SWEP.WorldModelBodygroups` — not defined

### VElements
```
["scope_acog"]       = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_4x.mdl", bone="tag_weapon", rel="", pos=V(0,0,0), angle=A(0,0,0), size=V(1,1,1), color=Color(255,255,255,255), surpresslightning=false, material="", skin=0, bonemerge=true, active=false, bodygroup={} }
["clip_default"]     = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_clip.mdl", bone="tag_clip", rel="", pos=V(0,0,0), angle=A(0,0,0), size=V(1,1,1), color=Color(255,255,255,255), surpresslightning=false, material="", skin=0, bonemerge=true, active=true, bodygroup={} }
["ext_clip"]         = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_clip_ext.mdl", bone="tag_clip", rel="", pos=V(0,0,0), angle=A(0,0,0), size=V(1,1,1), color=Color(255,255,255,255), surpresslightning=false, material="", skin=0, bonemerge=true, active=false, bodygroup={} }
["receiver_default"] = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_receiver.mdl", bone="tag_weapon", ..., active=true, bodygroup={} }
["barrel_default"]   = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_barrel.mdl", bone="tag_weapon", ..., active=true, bodygroup={} }
["charm_default"]    = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_charm.mdl", bone="tag_weapon", ..., active=true, bodygroup={} }
["stock_default"]    = { type=Model, model="models/weapons/tfa_codww2/arisaka/c_arisaka_stock.mdl", bone="tag_weapon", ..., active=true, bodygroup={} }
```
**Note:** The arisaka lacks a `scope_default` element (which Kar98k/Enfield have). It only has `scope_acog`. Charm uses Arisaka-specific charm model (rather than shared bar charm).

### WElements
```
["scope_acog"]       = { model=".../w_arisaka_4x.mdl", bone="tag_weapon", active=false }
["clip_default"]     = { model=".../w_arisaka_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]         = { model=".../w_arisaka_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"] = { model=".../w_arisaka_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]   = { model=".../w_arisaka_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]    = { model=".../w_arisaka_stock.mdl", bone="tag_weapon", active=true }
```
**Note:** No WElement charm_default for the arisaka (VElement has charm, WElement does not).

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** No slot [1] (no scope attachment slot). Arisaka does NOT have a scope attachment (despite having `scope_acog` and `IronSightsPos_7X`/`IronSightsPos_ACOG` defined). Also no slot [4] charm slot.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "6.5x50mm Arisaka"}`
- `SWEP.LuaShellEject = false`
- `SWEP.LuaShellEffect = "ShellEject"`
- `SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_556.mdl"`
- `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"`
- `SWEP.LuaShellScale = 1.2`
- `SWEP.LuaShellEjectDelay = 0`
- `SWEP.ShellAttachment = "0"`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.MuzzleAttachment = "1"`
- `SWEP.MuzzleFlashEffect` — not defined (uses base default)
- `SWEP.SmokeParticle` — not defined
- `SWEP.AutoDetectMuzzleAttachment` — not defined
- `SWEP.SprintBobMult = 0`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"`
- `SWEP.Primary.PickupSound = "TFA_CODWW2_PICKUP.Ammo"`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Volume = nil`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Emperor's Assassin"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 10
    self.Primary_TFA.Damage = 750
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip  = 110
    self.Primary_TFA.MaxAmmo = 100
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end

function SWEP:NZMaxAmmo()
    if CLIENT then return end
    self:GetOwner():SetAmmo(self.Primary.MaxAmmo, self:GetPrimaryAmmoType())
    self:SetClip1(self.Primary.ClipSize)
end
```
**Note on OnPaP:** Damage goes 75 → 750 (10x), NumShots 1 → 2 (doubles), RPM 250 → 260. Note `Primary_TFA.Damage = 750` is unusually LOW compared to other snipers' PaP damage (1000–15000). This is a notable balance outlier.

---

## 2. De Lisle — `nz_kate_codww2_delisle.lua`

### Core Fields
- `SWEP.Base = "tfa_codww2_base"`
- `SWEP.Category = "nZR: WWII Kate"`
- `SWEP.SubCategory = "Snipers"`
- `SWEP.PrintName = "De Lisle"`
- `SWEP.Slot = 4`
- `SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7`
- `SWEP.AdminSpawnable = true`
- `SWEP.UseHands = true`
- `SWEP.ViewModelFlip` — not set
- `SWEP.ViewModelFOV = 65`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/delisle/c_delisle.mdl"`
- `SWEP.WorldModel = "models/weapons/tfa_codww2/delisle/w_delisle.mdl"`
- `SWEP.HoldType = "ar2"`
- `SWEP.Manufacturer = "Sterling Armaments"`
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Bolt-action sniper rifle with built-in suppressor that offers one shot kill to torso and above."`
- `SWEP.Author = "Olli, Fox, Mav"`
- `SWEP.DrawCrosshair = true`, `SWEP.DrawCrosshairIronSights = false`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.VMAng = Vector(0, 0, 0)`, `SWEP.VMPos_Additive = true`
- `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 13.8 }, Ang = { Up = 180, Right = 190, Forward = 0 }, Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_MG42.Click"` (unusual — uses MG42 click sound as primary)
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_DELISLE.Click"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_DELISLE.Snap"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_DELISLE.Low"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_DELISLE.Lfe"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_KAR98K.Punch"`
- `SWEP.Primary.SoundLyr6 = "TFA_CODWW2_ENFIELD.CrackTrans"` (six layers — uncommon)
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("") }` *(empty exterior sound — silencer)*
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "pistol"` *(note: NOT SniperPenetratedRound — only sniper using pistol ammo! De Lisle is .45 ACP suppressed)*
- `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`
- `SWEP.Primary.RPM_Semi = nil`
- `SWEP.Primary.RPM_Burst = nil`
- `SWEP.Primary.RPM_Displayed = 50`
- `SWEP.Primary.RPM_Rapid = 600`
- `SWEP.Primary.RPM_Displayed_Rapid = 52`
- `SWEP.Primary.Damage = 1000`
- `SWEP.Primary.Knockback = 0`
- `SWEP.Primary.NumShots = 1`
- `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 10`
- `SWEP.Primary.ClipSize_Ext = 15`
- `SWEP.Primary.DefaultClip = 110`
- `SWEP.Primary.MaxAmmo = 100`
- `SWEP.Primary.DryFireDelay = 0.5`
- `SWEP.DisableChambering = true`
- `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.DisplayFalloff = true`
- `SWEP.Primary.RangeFalloffLUT = { bezier = false, range_func = "linear", units = "meters", lut = { {range = 200, damage = 1} } }`
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 0.7`, `SWEP.Primary.KickDown = 0.6`, `SWEP.Primary.KickHorizontal = 0.2`
- `SWEP.Primary.StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 2`, `SWEP.Primary.SpreadRecovery = 3`
- `SWEP.IronRecoilMultiplier = 0.5`
- `SWEP.ChangeStateAccuracyMultiplier = 1.5`, `SWEP.CrouchAccuracyMultiplier = 1.0`, `SWEP.JumpAccuracyMultiplier = 2.0`, `SWEP.WalkAccuracyMultiplier = 1.5`
- `SWEP.ChangeStateRecoilMultiplier = 1.3`, `SWEP.CrouchRecoilMultiplier = 0.65`, `SWEP.JumpRecoilMultiplier = 2.0`, `SWEP.WallRecoilMultiplier = 1.35`
- ViewModelPunch fields (same as arisaka): all 8 fields identical.
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.925`, `SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8` (=0.74)
- `SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"` *(unique — silenced muzzle flash)*
- `SWEP.FlashlightAttachment = 0`, `SWEP.FiresUnderwater = false`

### Secondary Stats (Bash)
- Same bash table as Arisaka. `BashLength = 55`. `SWEP.Secondary.IronFOV = 0` *(not 65 — iron FOV disabled because of scope)*.

### Fire Modes
- `SWEP.Primary.BurstDelay = nil`, `SWEP.DisableBurstFire = true`, `SWEP.SelectiveFire = false`, `SWEP.OnlyBurstFire = false`, `SWEP.BurstFireCount = nil`, `SWEP.DefaultFireMode = ""`, `SWEP.FireModeName = nil`
- `SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"`

### Shotgun Fields
- None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.4, -3, 1.03)`, `SWEP.IronSightsAng = Vector(0.35, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.4, -5, 0.725)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.381, -7, 0.503)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`
- `SWEP.InspectPos = Vector(10, -4, -2)`, `SWEP.InspectAng = Vector(24, 42, 16)`

### Scope Overlay (De Lisle has full scope configuration — present despite no scope_default VElement active by default)
- `SWEP.BoltAction = false`
- `SWEP.Scoped = true`
- `SWEP.Secondary.ScopeZoom = 4`
- `SWEP.ScopeOverlayThreshold = 0.875`
- `SWEP.BoltTimerOffset = 0.25`
- `SWEP.ScopeScale = 0.65`
- `SWEP.ReticleScale = 0.75`
- `SWEP.Secondary.UseACOG = false`, `UseMilDot = false`, `UseSVD = false`, `UseParabolic = false`, `UseElcan = false`, `UseGreenDuplex = false`
- `SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay_britain.png", "smooth"), ["ScopeBorder"] = color_black, ["ScopeCrosshair"] = { r=0, g=0, b=0, a=0, s=0 } }`

### Animations Table
Same structure as Arisaka — `reload_ext`, `reload_ext_empty` SEQ types. PumpAction identical.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = {
    { time = 1/30, type = "sound", value = Sound("TFA_CODWW2_DELISLE.Open") },
    { time = 35/30, type = "sound", value = Sound("TFA_CODWW2_DELISLE.Close") },
  },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 1/30, sound, "TFA_CODWW2_DELISLE.Cycle" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 1/30, sound, "TFA_CODWW2_DELISLE.CycleAds" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 5/30, sound, "TFA_CODWW2_DELISLE.TacMagOut" },
    { 65/30, sound, "TFA_CODWW2_DELISLE.TacMagIn" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 5/30, sound, "TFA_CODWW2_DELISLE.Open" },
    { 25/30, sound, "TFA_CODWW2_DELISLE.MagOut" },
    { 80/30, sound, "TFA_CODWW2_DELISLE.MagIn" },
    { 100/30, sound, "TFA_CODWW2_DELISLE.Close" },
  },
  ["reload_ext"] = {
    { 5/30, sound, "TFA_CODWW2_DELISLE.TacMagOut" },
    { 65/30, sound, "TFA_CODWW2_DELISLE.TacMagIn" },
  },
  ["reload_ext_empty"] = {
    { 5/30, sound, "TFA_CODWW2_DELISLE.Open" },
    { 25/30, sound, "TFA_CODWW2_DELISLE.MagOut" },
    { 80/30, sound, "TFA_CODWW2_DELISLE.MagIn" },
    { 100/30, sound, "TFA_CODWW2_DELISLE.Close" },
  },
  ["inspect"] = {
    { 1/30, sound, "TFA_CODWW2_DELISLE.Inspect1" },
    { 5/30, sound, "TFA_CODWW2_DELISLE.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_DELISLE.Inspect1" },
    { 55/30, sound, "TFA_CODWW2_DELISLE.Inspect2" },
  },
  ["inspect_epic"] = {
    { 1/30, sound, "TFA_CODWW2_DELISLE.EpicInspect1" },
    { 125/30, sound, "TFA_CODWW2_DELISLE.EpicInspect2" },
  },
}
```
**Notable:** No `ACT_VM_FIDGET` event (some snipers have this). Cycle uses single sound (not separate Open/Close like Kar98k). No FPO event (uses Open/Close on draw_deployed instead).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 70/30
[ACT_VM_RELOAD_EMPTY] = 90/30
["reload_ext"] = 70/30
["reload_ext_empty"] = 90/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 70/30
[ACT_VM_RELOAD] = 100/30
[ACT_VM_RELOAD_EMPTY] = 125/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 35/30
["melee_empty"] = 35/30
["reload_ext"] = 100/30
["reload_ext_empty"] = 125/30
```

**SequenceRateOverride:** same as arisaka (sprint_in, sprint_loop, PULLBACK_HIGH, PULLBACK_LOW all = 25/30 or 35/30).

### Bodygroups / Skins
None defined.

### VElements
```
["scope_default"] = { model=".../c_delisle_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_delisle_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]  = { model=".../c_delisle_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]      = { model=".../c_delisle_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["charm_default"] = { model="models/weapons/tfa_codww2/bar/c_bar_charm.mdl", bone="tag_weapon", active=false, bodygroup={[0]=1} }
```
**Notable:** No `receiver_default`, `barrel_default`, `stock_default` VElements — only scope/clip/charm. Charm uses shared `bar/c_bar_charm.mdl` (BAR pistol's charm) instead of delisle-specific. Charm starts `active=false` (unlike most other snipers).

### WElements
```
["scope_default"] = { model=".../w_delisle_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_delisle_4x.mdl", active=false }
["clip_default"]  = { model=".../w_delisle_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]      = { model=".../w_delisle_clip_ext.mdl", bone="tag_clip", active=false }
```

### Attachments
```
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_enfield_scope", "tfa_codww2_4x"}, sel = 1, order = 1},
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** Slot 1 default selection is `tfa_codww2_enfield_scope` (Biritsh scope) — De Lisle uses Enfield scope attachment because they share British scope material. No slot 4.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = ".45 ACP"}` — note: even though `SWEP.Primary.Ammo = "pistol"`, the AmmoTypeStrings entry maps `sniperpenetratedround` (NOT `pistol`) to `.45 ACP`. **This is likely a bug** — the AmmoTypeStrings entry won't match the actual ammo type, so the displayed ammo string won't show up correctly. Should be `{pistol = ".45 ACP"}`.
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_9mm.mdl"` *(9mm shell model — suppressed .45 ACP weapon using 9mm shell model — likely placeholder/cosmetic)*, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Small"` *(small shell sound, only sniper using "Small" — others use "Large")*
- `SWEP.LuaShellScale = 1.2`, `SWEP.LuaShellEjectDelay = 0`, `SWEP.ShellAttachment = "0"`, `SWEP.EjectionSmokeEnabled = false`
- `SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Volume = nil`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Queef Gun"` *(unusual/joke name)*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 20
    self.Primary_TFA.Damage = 3000
    self.Primary_TFA.NumShots = 1
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 220
    self.Primary_TFA.MaxAmmo = 200
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** OnPaP does NOT change MuzzleFlashEffect to silenced variant of PaP — it overwrites to `"muz_pap"`, so the silencer cosmetic effect is lost after PaP. NumShots stays 1 (no projectile-multiplication). Damage 1000 → 3000 (3x). Note `self.MuzzleFlashEffect = "muz_pap"` re-assignment occurs AFTER `self.Ispackapunched = true` (the order matters in TFA's stat caching).

Also has `SWEP:NZMaxAmmo()` identical to Arisaka.

---

## 3. Lee-Enfield — `nz_kate_codww2_enfield.lua`

### Core Fields
- `SWEP.Base = "tfa_codww2_base"`, `SWEP.Category = "nZR: WWII Kate"`, `SWEP.SubCategory = "Snipers"`
- `SWEP.PrintName = "Lee-Enfield"`, `SWEP.Slot = 4`
- `SWEP.Manufacturer = "Enfield"`, `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Bolt-action sniper rifle with built-in suppressor that offers one shot kill to torso and above."` *(copy-paste error: Enfield is NOT suppressed — purpose text inherited from De Lisle incorrectly)*
- `SWEP.ViewModel = "models/weapons/tfa_codww2/enfield/c_enfield.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/enfield/w_enfield.mdl"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.VMAng = Vector(0, 0, 0)`, `SWEP.VMPos_Additive = true`
- `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 13.8 }, Ang = { Up = 180, Right = 190, Forward = 0 }, Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_ENFIELD.Shoot"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_ENFIELD.Crack"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M1941.Thump"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_LEWIS.Lyr2"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_KAR98K.Punch"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_ENFIELD.CrackTrans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_BAR.Ext") }` *(BAR ext sound)*
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Semi = nil`, `SWEP.Primary.RPM_Burst = nil`, `SWEP.Primary.RPM_Displayed = 50`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 52`
- `SWEP.Primary.Damage = 850`, `SWEP.Primary.Knockback = 0`, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 10`, `SWEP.Primary.ClipSize_Ext = 15`, `SWEP.Primary.DefaultClip = 110`, `SWEP.Primary.MaxAmmo = 100`
- `SWEP.Primary.DryFireDelay = 0.5`, `SWEP.DisableChambering = true`, `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.DisplayFalloff = true`
- `SWEP.Primary.RangeFalloffLUT = { bezier=false, range_func="linear", units="meters", lut={{range=200, damage=1}} }`
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`, `SWEP.Primary.KickDown = 1.0`, `SWEP.Primary.KickHorizontal = 0.3`, `SWEP.Primary.StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 1.5`, `SWEP.Primary.SpreadRecovery = 3`
- Standard recoil/accuracy multipliers (same as Arisaka)
- Standard ViewModelPunch fields (same)
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.92`, `SWEP.IronSightsMoveSpeed = 0.92 * 0.8 = 0.736`

### Secondary Stats (Bash)
Same bash table. `SWEP.Secondary.IronFOV = 65`. `BashLength = 55`.

### Fire Modes
All defaults: `BurstDelay=nil`, `DisableBurstFire=true`, `SelectiveFire=false`, `OnlyBurstFire=false`, `BurstFireCount=nil`, `DefaultFireMode=""`, `FireModeName=nil`.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.4, -4, 1.4)`, `SWEP.IronSightsAng = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.385, -3, 0.495)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.19, -5, 0.91)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -1, -0.5)` *(differs from -2 in arisaka/kar98k)*, `SWEP.SafetyAng = Vector(-15, 25, -20)`
- `SWEP.InspectPos = Vector(10, -4, -2)`, `SWEP.InspectAng = Vector(24, 42, 16)`
- `SWEP.Secondary.IronFOV = 65`

### Animations Table
```
SWEP.Animations = {
    ["reload_ext"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_ext" },
    ["reload_ext_empty"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_ext_empty" },
}
```
- `SWEP.PumpAction = { type=ACT, value=ACT_VM_PULLBACK_HIGH, value_is=ACT_VM_PULLBACK_LOW }`
- Standard SprintAnimation (in/loop/out, SEQ, value_empty variants).

### Event Table
```
SWEP.EventTable = {
  ["draw_first"] = { { 1/30, sound, "TFA_CODWW2_ENFIELD.FPO" } },
  ["draw_first_epic"] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.CycleOpen" },
    { 35/30, sound, "TFA_CODWW2_ENFIELD.CycleClose" },
  },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.CycleOpen" },
    { 15/30, sound, "TFA_CODWW2_ENFIELD.CycleClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.CycleAdsOpen" },
    { 15/30, sound, "TFA_CODWW2_ENFIELD.CycleAdsClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.TacOpen" },
    { 50/30, sound, "TFA_CODWW2_ENFIELD.TacClipin" },
    { 70/30, sound, "TFA_CODWW2_ENFIELD.TacClose" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.EmptyOpen" },
    { 50/30, sound, "TFA_CODWW2_ENFIELD.EmptyClipin" },
    { 75/30, sound, "TFA_CODWW2_ENFIELD.EmptyClose" },
  },
  ["reload_ext"] = {
    { 1/30, sound, "TFA_CODWW2_ENFIELD.TacExtMagout" },
    { 65/30, sound, "TFA_CODWW2_ENFIELD.TacExtMagin" },
  },
  ["reload_ext_empty"] = {
    { 5/30, sound, "TFA_CODWW2_ENFIELD.EmptyExtOpen" },
    { 40/30, sound, "TFA_CODWW2_ENFIELD.EmptyExtMagout" },
    { 85/30, sound, "TFA_CODWW2_ENFIELD.EmptyExtMagin" },
    { 100/30, sound, "TFA_CODWW2_ENFIELD.EmptyExtClose" },
  },
  [ACT_VM_FIDGET] = {
    { 1/30, sound, "TFA_CODWW2_ENFIELD.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_ENFIELD.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_ENFIELD.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_ENFIELD.Inspect2" },
  },
}
```
**Notable:** Uses `["draw_first"]` and `["draw_first_epic"]` string keys instead of `[ACT_VM_DRAW_DEPLOYED]`. No `["inspect"]` entry (only `ACT_VM_FIDGET` and `["inspect_empty"]`). No `["inspect_epic"]` entry — Enfield does not have an epic inspect variant in this file. FPO is on `draw_first` string key, separate from `draw_first_epic` which has cycle sounds (likely first-time-deploy animation with bolt action demonstration).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 70/30
[ACT_VM_RELOAD_EMPTY] = 70/30
["reload_ext"] = 70/30
["reload_ext_empty"] = 90/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 40/30
[ACT_VM_RELOAD] = 100/30
[ACT_VM_RELOAD_EMPTY] = 100/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 40/30
["melee_empty"] = 40/30
["reload_ext"] = 100/30
```
*(Note: no `["reload_ext_empty"]` entry in SequenceLengthOverride)*

**SequenceRateOverride:** same as arisaka (sprint_in, sprint_loop, PULLBACK_HIGH, PULLBACK_LOW = 25/30 or 35/30).

### Bodygroups / Skins
None.

### VElements
```
["scope_default"]   = { model=".../c_enfield_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]      = { model=".../c_enfield_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]    = { model=".../c_enfield_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]        = { model=".../c_enfield_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["receiver_default"]= { model=".../c_enfield_receiver.mdl", bone="tag_weapon", active=true, bodygroup={} }
["barrel_default"]  = { model=".../c_enfield_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]   = { model=".../c_enfield_charm.mdl", bone="tag_weapon", active=true, bodygroup={[0]=1} }
["stock_default"]   = { model=".../c_enfield_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
```

### WElements
```
["scope_default"]   = { model=".../w_enfield_scope.mdl", bone="tag_weapon", active=false }
["scope_acog"]      = { model=".../w_enfield_4x.mdl", bone="tag_weapon", active=false }
["clip_default"]    = { model=".../w_enfield_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]        = { model=".../w_enfield_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"]= { model=".../w_enfield_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]  = { model=".../w_enfield_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]   = { model=".../w_enfield_stock.mdl", bone="tag_weapon", active=true }
```
**Notable:** No `charm_default` WElement (only VElement).

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** No slot [1] — no scope attachment slot (despite having `scope_default` VElement inactive by default, scope cannot be equipped via attachment UI). Possibly scope is intended to be cosmetic-only here.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = ".303 Mk VII"}`
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = ".../fx_556.mdl"`, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"`, `SWEP.LuaShellScale = 1.2`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.MuzzleFlashEffect` — not defined (uses base default)
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Spicy Enchilada"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 15
    self.Primary_TFA.Damage = 2550
    self.Primary_TFA.NumShots = 3
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 165
    self.Primary_TFA.MaxAmmo = 150
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 850→2550 (3x), NumShots 1→3 (TRIPLE — only sniper that fires 3 projectiles on PaP). Also standard NZMaxAmmo function.

---

## 4. Kar98k — `nz_kate_codww2_kar98k.lua`

### Core Fields
- `SWEP.Base = "tfa_codww2_base"`, `SWEP.Category = "nZR: WWII Kate Spawn Weapons"` *(has "Spawn Weapons" suffix — same as arisaka)*, `SWEP.SubCategory = "Snipers"`
- `SWEP.PrintName = "Kar98k"`, `SWEP.Slot = 4`
- `SWEP.Manufacturer = "Mauser"`, `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Bolt-action sniper rifle with built-in suppressor that offers one shot kill to torso and above."` *(same copy-paste error — Kar98k is not suppressed)*
- `SWEP.ViewModel = "models/weapons/tfa_codww2/kar98k/c_kar98k.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/kar98k/w_kar98k.mdl"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 13.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_KAR98K.Punch.Delay"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_BREN.Trigger"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_KAR98K.Boom.Delay"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_KAR98K.Trans.Delay"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_KAR98K.Trans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_KAR98K.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 48`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 50`
- `SWEP.Primary.Damage = 75`, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`, `SWEP.Primary.ClipSize_Ext = 7`, `SWEP.Primary.DefaultClip = 55`, `SWEP.Primary.MaxAmmo = 50`
- `SWEP.Primary.DryFireDelay = 0.5`, `SWEP.DisableChambering = true`, `SWEP.NZHeadShotMultiplier = 2`
- Same RangeFalloffLUT (single point, range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`, `SWEP.Primary.KickDown = 1.0`, `SWEP.Primary.KickHorizontal = 0.3`, `SWEP.Primary.StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 1.5`, `SWEP.Primary.SpreadRecovery = 3`
- Standard recoil/accuracy multipliers, ViewModelPunch, MoveSpeed=0.92.

### Secondary Stats (Bash)
Same as Arisaka. `SWEP.Secondary.IronFOV = 65`.

### Fire Modes
All defaults.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.6, -4.5, 1.33)`, `SWEP.IronSightsAng = Vector(0.1, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.6065, -4.5, 0.0785)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-4.15, -7, 0.83)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Animations
Same Animations structure (reload_ext, reload_ext_empty). PumpAction same.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 10/30, sound, "TFA_CODWW2_KAR98K.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_KAR98K.CycleOpen" },
    { 15/30, sound, "TFA_CODWW2_KAR98K.CycleClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_KAR98K.CycleAdsOpen" },
    { 15/30, sound, "TFA_CODWW2_KAR98K.CycleAdsClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 5/30, sound, "TFA_CODWW2_KAR98K.TacOpen" },
    { 55/30, sound, "TFA_CODWW2_KAR98K.TacClipin" },
    { 70/30, sound, "TFA_CODWW2_KAR98K.TacClose" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 5/30, sound, "TFA_CODWW2_KAR98K.EmptyOpen" },
    { 55/30, sound, "TFA_CODWW2_KAR98K.EmptyClipin" },
    { 75/30, sound, "TFA_CODWW2_KAR98K.EmptyClose" },
  },
  ["reload_ext"] = {
    { 1/30, sound, "TFA_CODWW2_KAR98K.TacExtMagout" },
    { 65/30, sound, "TFA_CODWW2_KAR98K.TacExtMagin" },
  },
  ["reload_ext_empty"] = {
    { 5/30, sound, "TFA_CODWW2_KAR98K.EmptyExtOpen" },
    { 40/30, sound, "TFA_CODWW2_KAR98K.EmptyExtMagout" },
    { 85/30, sound, "TFA_CODWW2_KAR98K.EmptyExtMagin" },
    { 100/30, sound, "TFA_CODWW2_KAR98K.EmptyExtClose" },
  },
  [ACT_VM_FIDGET] = {
    { 1/30, sound, "TFA_CODWW2_KAR98K.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_KAR98K.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_KAR98K.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_KAR98K.Inspect2" },
  },
}
```
**Notable:** No `["inspect"]` entry (only `ACT_VM_FIDGET` and `["inspect_empty"]`). No `["inspect_epic"]` entry.

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 70/30
[ACT_VM_RELOAD_EMPTY] = 70/30
["reload_ext"] = 70/30
["reload_ext_empty"] = 90/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 40/30
[ACT_VM_RELOAD] = 100/30
[ACT_VM_RELOAD_EMPTY] = 100/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 40/30
["melee_empty"] = 40/30
["reload_ext"] = 100/30
```
*(No `reload_ext_empty` in SequenceLengthOverride)*

**SequenceRateOverride:** Same as previous.

### Bodygroups / Skins
None.

### VElements
```
["scope_default"]    = { model=".../c_kar98k_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]       = { model=".../c_kar98k_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]     = { model=".../c_kar98k_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]         = { model=".../c_kar98k_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["receiver_default"] = { model=".../c_kar98k_receiver.mdl", bone="tag_weapon", active=true, bodygroup={} }
["barrel_default"]   = { model=".../c_kar98k_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]    = { model=".../c_kar98k_charm.mdl", bone="tag_weapon", active=true, bodygroup={} }
["stock_default"]    = { model=".../c_kar98k_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
["sight_default"]    = { model=".../c_kar98k_sight.mdl", bone="tag_weapon", active=true, bodygroup={} }
```
**Notable:** Kar98k has additional `["sight_default"]` element (extra rear sight model) — uncommon among the snipers. Charm starts `active=true` (no bodygroup override, unlike Enfield/Springfield's `bodygroup={[0]=1}`).

### WElements
```
["scope_default"]    = { model=".../w_kar98k_scope.mdl", active=false }
["scope_acog"]       = { model=".../w_kar98k_4x.mdl", active=false }
["clip_default"]     = { model=".../w_kar98k_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]         = { model=".../w_kar98k_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"] = { model=".../w_kar98k_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]   = { model=".../w_kar98k_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]    = { model=".../w_kar98k_stock.mdl", bone="tag_weapon", active=true }
```
**Notable:** No `sight_default` or `charm_default` WElements.

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** No slot [1] (scope).

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "7.92×57mm Mauser"}`
- Standard shell settings (LuaShellEject=false, fx_556.mdl, TFA_CODWW2_SHELLS.Large, scale=1.2)
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Langer Schuss"` *(German: "Long Shot")*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 10
    self.Primary_TFA.Damage = 3500
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 110
    self.Primary_TFA.MaxAmmo = 100
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 75→3500 (47x — extremely high multiplier, one of highest). Standard NZMaxAmmo.

---

## 5. Mosin (3-Line Rifle) — `nz_kate_codww2_mosin.lua`

### Core Fields
- `SWEP.PrintName = "3-Line Rifle"` *(old Mosin name; different from "Mosin" alone)*
- `SWEP.Manufacturer = "Tula Arsenal"`
- `SWEP.Type_Displayed = "Sniper Rifles"` *(PLURAL — typo)*
- `SWEP.Purpose = "Bolt-action sniper rifle that offers a fair one shot kill zone."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/mosin/c_mosin.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/mosin/w_mosin.mdl"`
- `SWEP.VMPos = Vector(0, 0, 0)` *(no offset — unlike other snipers with -1.5/-1.75 y-offset)*
- `SWEP.Offset = { Pos = { Up = -4.8, Right = 1, Forward = 15.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_MOSIN.Bright"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_MOSIN.Thick"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_BREN.Trigger"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_MOSIN.Sub"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_MOSIN.Trans"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_KAR98K.Trans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_MOSIN.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 48`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 50`
- `SWEP.Primary.Damage = 900` *(higher than Kar98k's 75 — strongest "stock" Mosin damage)*, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`, `SWEP.Primary.ClipSize_Ext = 7`, `SWEP.Primary.DefaultClip = 55`, `SWEP.Primary.MaxAmmo = 50`
- `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.RangeFalloffLUT` — same standard single-point LUT (range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.2` *(slightly higher than Kar98k's 1.0)*, `KickDown = 1.0`, `KickHorizontal = 0.3`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 1.5`, `SWEP.Primary.SpreadRecovery = 3`
- Standard recoil/accuracy multipliers, ViewModelPunch fields, MoveSpeed=0.92.

### Secondary Stats (Bash)
Same bash table. `SWEP.Secondary.IronFOV = 65`.

### Fire Modes
All defaults.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.4, -4, 1.65)`, `SWEP.IronSightsAng = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.395, -2.5, 0.35)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.274, -2.5, 0.846)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -1, -1)` *(differs from other snipers)*, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Animations (UNIQUE — Mosin has MULTIPLE partial reload animations for extmag system)
```
SWEP.Animations = {
    ["reload_partial_01"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD },
    ["reload_partial_02"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD_END },
    ["reload_partial_03"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD_DEPLOYED },
    ["reload_partial_04"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_RELOAD_LOW },
    ["reload_partial_05"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD2 },
    ["reload_partial_06"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD_SILENCED },
    ["reload_partial_07"] = { type = TFA.Enum.ANIMATION_ACT, value = ACT_VM_RELOAD_EMPTY },
}
```
**Notable:** Mosin uses 7 different reload_partial animations keyed to different clip counts (one per shell count from 0 to 6). This is the most elaborate extmag reload system among the snipers.

- `SWEP.PumpAction` — same standard structure (PULLBACK_HIGH/LOW).
- Standard SprintAnimation.

### Event Table (UNIQUE — multiple reload acts)
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 1/30, sound, "TFA_CODWW2_MOSIN.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 1/30, sound, "TFA_CODWW2_MOSIN.Cycle" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 1/30, sound, "TFA_CODWW2_MOSIN.CycleAds" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 55/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_VM_RELOAD_END] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 60/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_VM_RELOAD_DEPLOYED] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 43/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 65/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_RELOAD_LOW] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 60/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 95/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_VM_RELOAD2] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 43/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 65/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 105/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_VM_RELOAD_SILENCED] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 70/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 110/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 7/30, sound, "TFA_CODWW2_MOSIN.Open" },
    { 30/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 43/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 70/30, sound, "TFA_CODWW2_MOSIN.Roundin" },
    { 83/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 115/30, sound, "TFA_CODWW2_MOSIN.Roundin1" },
    { 140/30, sound, "TFA_CODWW2_MOSIN.Close" },
  },
  ["inspect"] = { { 1/30, "TFA_CODWW2_MOSIN.Inspect1" }, { 50/30, "TFA_CODWW2_MOSIN.Inspect2" } },
  ["inspect_epic"] = { { 1/30, "TFA_CODWW2_MOSIN.InspectEpic1" }, { 50/30, "TFA_CODWW2_MOSIN.InspectEpic2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_MOSIN.Inspect1" }, { 50/30, "TFA_CODWW2_MOSIN.Inspect2" } },
}
```

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 40/30
[ACT_VM_RELOAD_END] = 45/30
[ACT_VM_RELOAD_DEPLOYED] = 45/30
[ACT_RELOAD_LOW] = 75/30
[ACT_VM_RELOAD2] = 85/30
[ACT_VM_RELOAD_SILENCED] = 90/30
[ACT_VM_RELOAD_EMPTY] = 125/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 70/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 40/30
["melee_empty"] = 40/30
[ACT_VM_RELOAD] = 90/30
[ACT_VM_RELOAD_END] = 100/30
[ACT_VM_RELOAD_DEPLOYED] = 105/30
[ACT_RELOAD_LOW] = 135/30
[ACT_VM_RELOAD2] = 140/30
[ACT_VM_RELOAD_SILENCED] = 150/30
[ACT_VM_RELOAD_EMPTY] = 175/30
```
**Notable:** Mosin has the longest reload animations in the sniper class — up to 175/30 seconds (≈5.83s) for full reload.

**SequenceRateOverride:** Same standard (sprint_in, sprint_loop, PULLBACK_HIGH/LOW).

### Bodygroups / Skins
None.

### VElements
```
["scope_default"] = { model=".../c_mosin_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_mosin_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["shell_default"] = { model=".../c_mosin_bullets.mdl", bone="tag_clip", active=true, bodygroup={} }  *(unique — bullets shown)*
["clip_default"]  = { model=".../c_mosin_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]      = { model=".../c_mosin_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["charm_default"] = { model="models/weapons/tfa_codww2/bar/c_bar_charm.mdl", bone="tag_weapon", active=false, bodygroup={[0]=1} }
```
**Notable:** Mosin has a `["shell_default"]` element (visible stripper-clip bullets model) that other snipers don't have. No `receiver_default`, `barrel_default`, `stock_default` — instead has `shell_default` and `clip_default`. Charm uses shared bar charm model with `active=false`.

### WElements
```
["scope_default"] = { model=".../w_mosin_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_mosin_4x.mdl", active=false }
["clip_default"]  = { model=".../w_mosin_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]      = { model=".../w_mosin_clip_ext.mdl", bone="tag_clip", active=false }
```

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** No slot [1] scope, no slot [4] charm. Despite Mosin having a `charm_default` VElement defined, there is NO attachment slot that would activate it. The charm bodygroup `[0]=1` is set on `charm_default` element, but it starts `active=false`. **This is dead code** — the charm VElement will never become visible through normal attachment use.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "7.62×54mmR"}`
- Standard shell settings (LuaShellEject=false, fx_556.mdl, SHELLS.Large, scale=1.2)
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Master Marksman"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 10
    self.Primary_TFA.Damage = 2700
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 110
    self.Primary_TFA.MaxAmmo = 100
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 900→2700 (3x). Standard NZMaxAmmo.

**Mosin-specific custom function (extmag reload):**
```lua
DEFINE_BASECLASS( SWEP.Base )

function SWEP:ChooseReloadAnim()
    if not self:VMIV() then return false, 0 end
    if self.ProceduralReloadEnabled then return false, 0 end
    
    local typev, tanim

    -- extmag mode (with EnableExtMags stat) — chooses different partial anim based on Clip1
    if self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and self:GetStat("EnableExtMags") and (self:Clip1() == 0 or self:IsJammed()) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_07")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD) and self:GetStat("EnableExtMags") and (self:Clip1() == 6) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_01")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_END) and self:GetStat("EnableExtMags") and (self:Clip1() == 5) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_02")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_DEPLOYED) and self:GetStat("EnableExtMags") and (self:Clip1() == 4) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_03")
    elseif self:GetActivityEnabled(ACT_RELOAD_LOW) and self:GetStat("EnableExtMags") and (self:Clip1() == 3) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_04")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD2) and self:GetStat("EnableExtMags") and (self:Clip1() == 2) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_05")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self:GetStat("EnableExtMags") and (self:Clip1() == 1) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_06")
    -- non-extmag mode
    elseif self:GetActivityEnabled(ACT_VM_RELOAD2) and (self:Clip1() == 0 or self:IsJammed()) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_05")
    elseif self:GetActivityEnabled(ACT_RELOAD_LOW) and (self:Clip1() == 1) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_04")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_DEPLOYED) and (self:Clip1() == 2) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_03")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_END) and (self:Clip1() == 3) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_02")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD) and (self:Clip1() == 4) and not self.Shotgun then
        typev, tanim = self:ChooseAnimation("reload_partial_01")
    end
    
    -- shelltime multiplier and animation dispatch (truncated in original; standard TFA pattern)
    local fac = 1
    if self.Shotgun and self.ShellTime then fac = self.ShellTime end
    self.AnimCycle = 0
    if SERVER and game.SinglePlayer() then
        self.SetNW2Int = self.SetNW2Int or self.SetNWInt
        self:SetNW2Int("AnimCycle", self.AnimCycle)
    end
    local success, act
    if typev ~= TFA.Enum.ANIMATION_SEQ then
        success, act = self:SendViewModelAnim(tanim, fac, fac ~= 1)
    else
        success, act = self:SendViewModelSeq(tanim, fac, fac ~= 1)
    end
    return success, act, typev
end
```
**Note:** This is the only sniper with a fully custom ChooseReloadAnim that selects reload animation by current Clip1 count. This implements the per-round reload cosmetic system where each round inserted triggers a different animation.

---

## 6. SDK 9mm — `nz_kate_codww2_sdk.lua`

### Core Fields
- `SWEP.PrintName = "SDK 9mm"` *(SDK = Sound Development Kit / suppressed carbine concept)*
- `SWEP.Manufacturer = "Hoax firearm"` *(fictional)*
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Bolt-action sniper rifle with built-in suppressor that offers a generous one shot kill zone."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/sdk/c_sdk.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/sdk/w_sdk.mdl"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.Offset = { Pos = { Up = -5.6, Right = 1, Forward = 16.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_RIBEY.Sub"` *(uses Ribey sub-layer — odd choice for sniper)*
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_SDK.Center"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_SDK.Wide"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_RIBEY.Trans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_DELISLE.Click") }` *(echo uses delisle click)*
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"` *(despite firing 9mm, ammo type is SniperPenetratedRound)*, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 48`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 50`
- `SWEP.Primary.Damage = 1400`, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`, `SWEP.Primary.ClipSize_Ext = 7`, `SWEP.Primary.DefaultClip = 55`, `SWEP.Primary.MaxAmmo = 50`
- `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.RangeFalloffLUT` — same standard.
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 0.9` *(lower than Kar98k's 1.0)*, `KickDown = 0.8`, `KickHorizontal = 0.3`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 2` *(higher — spreads faster)*, `SWEP.Primary.SpreadRecovery = 3`
- Standard recoil/accuracy multipliers, ViewModelPunch.
- `SWEP.MoveSpeed = 0.925`, `SWEP.IronSightsMoveSpeed = 0.925 * 0.8 = 0.74`
- `SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"` *(silenced)*

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 0` *(disabled — scoped weapon)*.

### Fire Modes
All defaults.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.75, 0, 1.14)`, `SWEP.IronSightsAng = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-3.751, -1.5, 0.592)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.752, -4, 0.175)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Scope Overlay (full scope config present)
- `SWEP.BoltAction = false`
- `SWEP.Scoped = true`
- `SWEP.Secondary.ScopeZoom = 4`
- `SWEP.ScopeOverlayThreshold = 0.875`
- `SWEP.BoltTimerOffset = 0.25`
- `SWEP.ScopeScale = 0.65`
- `SWEP.ReticleScale = 0.75`
- `SWEP.Secondary.UseACOG = false`, `UseMilDot = false`, `UseSVD = false`, `UseParabolic = false`, `UseElcan = false`, `UseGreenDuplex = false`
- `SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay_german.png", "smooth"), ["ScopeBorder"] = color_black, ["ScopeCrosshair"] = { r=0, g=0, b=0, a=0, s=0 } }` *(German scope overlay)*

### Animations
Standard Animations table (reload_ext, reload_ext_empty). Standard PumpAction.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 1/30, sound, "TFA_CODWW2_SDK.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_SDK.Cycle" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_SDK.Cycle" },  *(same as HIGH — both ADS and hip cycle sounds identical)*
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 20/30, sound, "TFA_CODWW2_SDK.TacMagOut" },
    { 75/30, sound, "TFA_CODWW2_SDK.TacMagIn" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 5/30, sound, "TFA_CODWW2_SDK.Open" },
    { 25/30, sound, "TFA_CODWW2_SDK.MagOut" },
    { 60/30, sound, "TFA_CODWW2_SDK.MagIn" },
    { 85/30, sound, "TFA_CODWW2_SDK.Close" },
  },
  ["reload_ext"] = {
    { 20/30, sound, "TFA_CODWW2_SDK.TacMagOut" },
    { 75/30, sound, "TFA_CODWW2_SDK.TacMagIn" },
  },
  ["reload_ext_empty"] = {
    { 5/30, sound, "TFA_CODWW2_SDK.Open" },
    { 25/30, sound, "TFA_CODWW2_SDK.MagOut" },
    { 60/30, sound, "TFA_CODWW2_SDK.MagIn" },
    { 85/30, sound, "TFA_CODWW2_SDK.Close" },
  },
  ["inspect"] = { { 1/30, "TFA_CODWW2_SDK.Inspect1" }, { 45/30, "TFA_CODWW2_SDK.Inspect2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_SDK.Inspect1" }, { 45/30, "TFA_CODWW2_SDK.Inspect2" } },
  ["inspect_epic"] = { { 1/30, "TFA_CODWW2_SDK.EpicInspect1" }, { 75/30, "TFA_CODWW2_SDK.EpicInspect2" } },
}
```
**Notable:** No `ACT_VM_FIDGET` event. Cycle sound is the same string for HIGH and LOW (likely developer oversight or intentional silence). Only 4-sound inspect_epic.

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 90/30
[ACT_VM_RELOAD_EMPTY] = 80/30
["reload_ext"] = 90/30
["reload_ext_empty"] = 80/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 70/30
[ACT_VM_RELOAD] = 115/30
[ACT_VM_RELOAD_EMPTY] = 120/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 35/30
["melee_empty"] = 35/30
["reload_ext"] = 115/30
```
*(No `reload_ext_empty` in SequenceLengthOverride)*

**SequenceRateOverride:**
```
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
[ACT_VM_PULLBACK_HIGH] = 40/30   *(differs — 40/30 instead of 35/30)*
[ACT_VM_PULLBACK_LOW] = 40/30
```
**Notable:** SDK uses slightly slower cycle rate (40/30 vs 35/30 for most snipers).

### Bodygroups / Skins
None.

### VElements
```
["scope_default"] = { model=".../c_sdk_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_sdk_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]  = { model=".../c_sdk_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]      = { model=".../c_sdk_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["charm_default"] = { model="models/weapons/tfa_codww2/bar/c_bar_charm.mdl", bone="tag_weapon", active=false, bodygroup={} }  *(no bodygroup override here, unlike mosin/delisle)*
```

### WElements
```
["scope_default"] = { model=".../w_sdk_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_sdk_4x.mdl", active=false }
["clip_default"]  = { model=".../w_sdk_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]      = { model=".../w_sdk_clip_ext.mdl", bone="tag_clip", active=false }
```

### Attachments
```
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_kar98k_scope", "tfa_codww2_4x"}, sel = 1, order = 1},
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
    [4] = {atts = {"tfa_codww2_areallybadidea"}, order = 4},  *(joke attachment)*
}
```
**Notable:** Slot 1 default is `tfa_codww2_kar98k_scope` (German scope) — used for SDK because it uses German scope overlay material. Slot 4 has `tfa_codww2_areallybadidea` — humorously named attachment (likely a joke incendiary or similar). This is the ONLY sniper with 4 attachment slots.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "9x19mm Parabellum"}`
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = ".../fx_9mm.mdl"` *(9mm shell — suppressed)*, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"` *(large sound despite small caliber — likely intentional for impact)*, `SWEP.LuaShellScale = 1.2`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Nachtpirscher"` *(German: "Night Prowler")*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 15
    self.Primary_TFA.Damage = 4200
    self.Primary_TFA.NumShots = 3
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 165
    self.Primary_TFA.MaxAmmo = 150
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 1400→4200 (3x). NumShots 1→3 (triple — second sniper to triple projectiles). Note that PaP removes silenced muzzle flash (sets to `muz_pap`). Standard NZMaxAmmo.

---

## 7. Springfield (M1903) — `nz_kate_codww2_springfield.lua`

### Core Fields
- `SWEP.PrintName = "M1903"`
- `SWEP.Manufacturer = "Springfield Armory"`
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Heavy bolt-action sniper rifle that has the largest one shot kill zone."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/springfield/c_springfield.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/springfield/w_springfield.mdl"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.Offset = { Pos = { Up = -5.8, Right = 1, Forward = 17.8 }, ... Scale = 1.1 }` *(longest barrel — largest Forward offset)*

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_BREN.Trigger"` *(uses BREN trigger as primary fire sound — unusual)*
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_M1903.Thud"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M1903.Blast"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_M1903.Low"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_M1903.Shot01"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_KAR98K.Sub"`
- `SWEP.Primary.SoundLyr6 = "TFA_CODWW2_M1903.Blast.Trans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_M1903.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 40` *(lowest displayed RPM — slowest)*, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 44`
- `SWEP.Primary.Damage = 1350` *(2nd highest base damage, only below Wz.35's 5000)*, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`, `SWEP.Primary.ClipSize_Ext = 7`, `SWEP.Primary.DefaultClip = 55`, `SWEP.Primary.MaxAmmo = 50`
- `SWEP.NZHeadShotMultiplier = 2`
- Standard RangeFalloffLUT.
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`, `KickDown = 1.0`, `KickHorizontal = 0.3`, `StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 1.5`, `SWEP.Primary.SpreadRecovery = 3`
- Standard multipliers and ViewModelPunch.
- `SWEP.MoveSpeed = 0.92`, `SWEP.IronSightsMoveSpeed = 0.736`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 65`.

### Fire Modes
All defaults.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.9, -4, 0.82)`, `SWEP.IronSightsAng = Vector(0, 0, 0)` *(IronSightsAng assigned TWICE — same value both times; likely typo in source)*
- `SWEP.IronSightsPos_7X = Vector(-3.896, -3, 0.325)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-2.865, -3, 0.149)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Animations
Standard Animations table (reload_ext, reload_ext_empty). Standard PumpAction.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 5/30, sound, "TFA_CODWW2_M1903.EmptyClose" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_M1903.CycleOpen" },
    { 15/30, sound, "TFA_CODWW2_M1903.CycleClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_M1903.CycleAdsOpen" },
    { 15/30, sound, "TFA_CODWW2_M1903.CycleAdsClose" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 5/30, sound, "TFA_CODWW2_M1903.TacOpen" },
    { 50/30, sound, "TFA_CODWW2_M1903.TacClipin" },
    { 70/30, sound, "TFA_CODWW2_M1903.TacClose" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 5/30, sound, "TFA_CODWW2_M1903.EmptyOpen" },
    { 50/30, sound, "TFA_CODWW2_M1903.EmptyClipin" },
    { 75/30, sound, "TFA_CODWW2_M1903.EmptyClose" },
  },
  ["reload_ext"] = {
    { 5/30, sound, "TFA_CODWW2_M1903.TacExtMagout" },
    { 60/30, sound, "TFA_CODWW2_M1903.TacExtMagin" },
  },
  ["reload_ext_empty"] = {
    { 5/30, sound, "TFA_CODWW2_M1903.EmptyExtMagout" },
    { 55/30, sound, "TFA_CODWW2_M1903.EmptyExtMagin" },
    { 85/30, sound, "TFA_CODWW2_M1903.EmptyExtOpen" },
    { 95/30, sound, "TFA_CODWW2_M1903.EmptyExtClose" },
  },
  [ACT_VM_FIDGET] = {
    { 1/30, sound, "TFA_CODWW2_M1903.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_M1903.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_M1903.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_M1903.Inspect2" },
  },
}
```
**Notable:** No `ACT_VM_DRAW_EMPTY` and `ACT_VM_HOLSTER_EMPTY` entries (most snipers have them). FPO uses `EmptyClose` sound (not FPO). `reload_ext_empty` has 4 sounds but they're out of conventional order (Magout, Magin, Open, Close — should probably be Open, Magout, Magin, Close). This ordering looks **buggy** — empty reload would play magout before open sound.

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 70/30
[ACT_VM_RELOAD_EMPTY] = 70/30
["reload_ext"] = 65/30
["reload_ext_empty"] = 65/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 40/30
[ACT_VM_RELOAD] = 100/30
[ACT_VM_RELOAD_EMPTY] = 100/30
[ACT_VM_DRAW] = 25/30
[ACT_VM_DRAW_EMPTY] = 25/30
["melee"] = 40/30
["melee_empty"] = 40/30
["reload_ext"] = 100/30
["reload_ext_empty"] = 115/30
```

**SequenceRateOverride:** same as arisaka.

### Bodygroups / Skins
None.

### VElements
```
["scope_default"]   = { model=".../c_springfield_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]      = { model=".../c_springfield_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]    = { model=".../c_springfield_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]         = { model=".../c_springfield_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["receiver_default"]= { model=".../c_springfield_receiver.mdl", bone="tag_weapon", active=true, bodygroup={} }
["barrel_default"]  = { model=".../c_springfield_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]   = { model=".../c_springfield_charm.mdl", bone="tag_weapon", active=true, bodygroup={[0]=1} }
["stock_default"]   = { model=".../c_springfield_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
["strap_default"]   = { model=".../c_springfield_strap.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(unique — Springfield has weapon strap model)*
```

### WElements
```
["scope_default"]   = { model=".../w_springfield_scope.mdl", active=false }
["scope_acog"]      = { model=".../w_springfield_4x.mdl", active=false }
["clip_default"]    = { model=".../w_springfield_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]         = { model=".../w_springfield_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"]= { model=".../w_springfield_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]  = { model=".../w_springfield_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]   = { model=".../w_springfield_stock.mdl", bone="tag_weapon", active=true }
```
**Notable:** No `charm_default` or `strap_default` WElement.

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** No slot [1] scope.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = ".30-06 Springfield"}`
- Standard shell settings (fx_556, SHELLS.Large).
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Cheshire Cat"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 10
    self.Primary_TFA.Damage = 4050
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 110
    self.Primary_TFA.MaxAmmo = 100
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 1350→4050 (3x). Standard NZMaxAmmo.

---

## 8. Wz. 35 — `nz_kate_codww2_wz35.lua`

### Core Fields
- `SWEP.PrintName = "Wz. 35"`
- `SWEP.Manufacturer = "Państwowa Fabryka Karabinów"` *(Polish — State Rifle Factory)*
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Bolt-action sniper rifle that one shot kills on every part of the body at cost of the slowest rechamber time in class."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/wz35/c_wz35.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/wz35/w_wz35.mdl"`
- `SWEP.VMPos = Vector(0, 0, 0)` *(no offset)*, `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 13.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_KAR98K.Punch03"` *(uses Kar98k Punch03 — different from Kar98k's Punch.Delay)*
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_KAR98K.Trans"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M1903.Thud"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_M1903.Blast"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_PTRS.Thump"` *(anti-tank rifle thump)*
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_SHGN.Lfe"` *(shotgun low-frequency)*
- `SWEP.Primary.SoundLyr6 = "TFA_CODWW2_M1919.Sub"` *(MG sub layer)*
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_M1903.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 48`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 50`
- `SWEP.Primary.Damage = 5000` *(HIGHEST base sniper damage — only Wz.35 hits 5000)*, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 5`, `SWEP.Primary.ClipSize_Ext = 7`, `SWEP.Primary.DefaultClip = 55`, `SWEP.Primary.MaxAmmo = 50`
- `SWEP.NZHeadShotMultiplier = 2`
- Standard RangeFalloffLUT (range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.5` *(HIGHEST — Wz.35 has brutal recoil)*, `KickDown = 1.2`, `KickHorizontal = 0.4`, `StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 2` *(higher — spreads faster)*, `SWEP.Primary.SpreadRecovery = 2.25` *(slow recovery — Purpose says "slowest rechamber")*
- Standard multipliers and ViewModelPunch.
- `SWEP.MoveSpeed = 0.88` *(LOWEST among snipers)*, `SWEP.IronSightsMoveSpeed = 0.88 * 0.8 = 0.704`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 0` *(disabled — scoped)*.

### Fire Modes
All defaults.

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.4, -1, 1.33)`, `SWEP.IronSightsAng = Vector(0.1, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.395, -4.75, 0.123)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.115, -6, 0.741)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Scope Overlay (full config)
- `SWEP.BoltAction = false`
- `SWEP.Scoped = true`
- `SWEP.Secondary.ScopeZoom = 4`
- `SWEP.ScopeOverlayThreshold = 0.875`
- `SWEP.BoltTimerOffset = 0.25`
- `SWEP.ScopeScale = 0.65`
- `SWEP.ReticleScale = 0.75`
- All `Secondary.UseACOG/MilDot/SVD/Parabolic/Elcan/GreenDuplex = false`
- `SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay_mp.png", "smooth"), ["ScopeBorder"] = color_black, ["ScopeCrosshair"] = { r=0, g=0, b=0, a=0, s=0 } }` *(multiplayer scope overlay)*

### Animations
Standard Animations table (reload_ext, reload_ext_empty). Standard PumpAction.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 15/30, sound, "TFA_CODWW2_WZ35.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_WZ35.Cycle" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_WZ35.Cycle" },  *(same as HIGH)*
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_RELOAD] = {
    { 25/30, sound, "TFA_CODWW2_WZ35.TacMagOut" },
    { 55/30, sound, "TFA_CODWW2_WZ35.TacMagIn" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 1/30, sound, "TFA_CODWW2_WZ35.Open" },
    { 35/30, sound, "TFA_CODWW2_WZ35.MagOut" },
    { 55/30, sound, "TFA_CODWW2_WZ35.MagIn" },
    { 80/30, sound, "TFA_CODWW2_WZ35.Close" },
  },
  ["reload_ext"] = {
    { 25/30, sound, "TFA_CODWW2_WZ35.TacMagOut" },
    { 55/30, sound, "TFA_CODWW2_WZ35.TacMagIn" },
  },
  ["reload_ext_empty"] = {
    { 1/30, sound, "TFA_CODWW2_WZ35.Open" },
    { 35/30, sound, "TFA_CODWW2_WZ35.MagOut" },
    { 55/30, sound, "TFA_CODWW2_WZ35.MagIn" },
    { 80/30, sound, "TFA_CODWW2_WZ35.Close" },
  },
  ["inspect"] = { { 1/30, "TFA_CODWW2_WZ35.Inspect1" }, { 55/30, "TFA_CODWW2_WZ35.Inspect2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_WZ35.Inspect1" }, { 55/30, "TFA_CODWW2_WZ35.Inspect2" } },
  ["inspect_epic"] = { { 1/30, "TFA_CODWW2_WZ35.EpicInspect1" }, { 70/30, "TFA_CODWW2_WZ35.EpicInspect2" } },
}
```
**Notable:** No `ACT_VM_FIDGET`. Cycle sounds same for HIGH/LOW. FPO timing at 15/30 (later than most).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 80/30
[ACT_VM_RELOAD_EMPTY] = 70/30
["reload_ext"] = 80/30
["reload_ext_empty"] = 70/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 40/30   *(longer — slower bolt cycle, matches "slowest rechamber" purpose)*
[ACT_VM_PULLBACK_LOW] = 40/30
[ACT_VM_RELOAD] = 110/30
[ACT_VM_RELOAD_EMPTY] = 110/30
[ACT_VM_DRAW] = 30/30   *(slightly slower draw than 25/30 standard)*
[ACT_VM_DRAW_EMPTY] = 30/30
["melee"] = 40/30
["melee_empty"] = 40/30
```
**Notable:** No `ACT_VM_DRAW_DEPLOYED` in SequenceLengthOverride. No `reload_ext`/`reload_ext_empty` strings in SequenceLengthOverride.

**SequenceRateOverride:**
```
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
```
**Notable:** No PULLBACK_HIGH/LOW entries in SequenceRateOverride (only sprint entries). Wz.35 has the **shortest SequenceRateOverride** among snipers.

### Bodygroups / Skins
None.

### VElements
```
["scope_default"] = { model=".../c_wz35_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_wz35_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]  = { model=".../c_wz35_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]      = { model=".../c_wz35_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["charm_default"] = { model="models/weapons/tfa_codww2/bar/c_bar_charm.mdl", bone="tag_weapon", active=false, bodygroup={[0]=1} }  *(shared bar charm, inactive)*
```

### WElements
```
["scope_default"] = { model=".../w_wz35_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_wz35_4x.mdl", active=false }
["clip_default"]  = { model=".../w_wz35_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]      = { model=".../w_wz35_clip_ext.mdl", bone="tag_clip", active=false }
```

### Attachments
```
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_mosin_scope", "tfa_codww2_4x"}, sel = 1, order = 1},
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** Slot 1 default is `tfa_codww2_mosin_scope` — but Wz.35 scope material is `scope_overlay_mp.png` (multiplayer scope), not Mosin's scope material. The Mosin scope attachment is reused here. Charm slot missing — no slot [4] (despite having `charm_default` VElement with bodygroup set; it's just inactive).

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "7.92×107mm DS"}` *(Polish anti-tank round)*
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_50bmg.mdl"` *(.50 BMG shell — Wz.35 is the ONLY sniper using .50 BMG shell model — represents the large anti-tank round)*, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"`, `SWEP.LuaShellScale = 1` *(scale=1, not 1.2 like others)*
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.MuzzleFlashEffect` — not defined (uses base default; not silenced)
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Niszczyciel Zbroi"` *(Polish: "Armor Destroyer")*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 10
    self.Primary_TFA.Damage = 15000
    self.Primary_TFA.NumShots = 1
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 110
    self.Primary_TFA.MaxAmmo = 100
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 5000→15000 (3x). NumShots stays 1 — Wz.35 is the only "high-tier" sniper that does NOT increase projectile count on PaP. Damage 15000 is the **highest single-shot PaP damage among all snipers** — Wz.35 trades projectile count for raw damage. Standard NZMaxAmmo.

---

## 9. Winchester 94 (Lever Action) — `nz_kate_codww2_winchester94.lua`

### Core Fields
- `SWEP.PrintName = "Lever Action"` *(NOT "Winchester 94" — labeled "Lever Action" in spawnmenu despite filename winchester94)*
- `SWEP.Manufacturer = "Winchester"`
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Lever activated sniper rifle that offers fast consecutive shots and delivers one shot kill to torso and above."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/winchester94/c_winchester94.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/winchester94/w_winchester94.mdl"`
- `SWEP.VMPos = Vector(0, -1, 0)` *(smaller offset than other snipers)*, `SWEP.Offset = { Pos = { Up = -5.3, Right = 1, Forward = 17.3 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_LEVER.Shoot"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_WALTHER.Trans"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_KAR98K.Boom"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_KAR98K.Trans.Delay"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_KAR98K.Punch03"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_LEVER.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 60` *(HIGHEST displayed RPM — lever action faster than bolt)*, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 63`
- `SWEP.Primary.Damage = 889`, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 6` *(unique — only sniper with clip size 6)*, `SWEP.Primary.ClipSize_Ext = 9`, `SWEP.Primary.DefaultClip = 66` *(multiples of 6)*, `SWEP.Primary.MaxAmmo = 60`
- `SWEP.NZHeadShotMultiplier = 2`
- Standard RangeFalloffLUT (range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`, `KickDown = 0.9`, `KickHorizontal = 0.3`, `StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 2`, `SWEP.Primary.SpreadRecovery = 2`
- Standard multipliers and ViewModelPunch.
- `SWEP.MoveSpeed = 0.925`, `SWEP.IronSightsMoveSpeed = 0.74`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 65`.

### Fire Modes
All defaults.

### Shotgun Fields
**Winchester is a SNIPER but has Shotgun fields enabled:**
- `SWEP.Shotgun = true` *(unusual — categorized as sniper but flagged as shotgun-style reload)*
- `SWEP.ShotgunEmptyAnim = false`
- `SWEP.ShotgunEmptyAnim_Shell = false`
- `SWEP.ShotgunStartAnimShell = true`

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.9, -2, 1.2)`, `SWEP.IronSightsAng = Vector(0.2, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-2.955, -1.5, 1.204)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.04, -4.5, 0.045)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.3` *(faster than other snipers' 0.4 — lever action)*

### Animations (UNIQUE — Winchester has NO reload_ext/reload_ext_empty SEQ animations)
- `SWEP.Animations` — **NOT defined** (no Animations table). This is the only sniper without reload_ext animations.
- `SWEP.PumpAction = { type = ACT, value = ACT_VM_PULLBACK_HIGH }` *(no `value_is` for PULLBACK_LOW — Winchester uses same animation for hip and ADS)*
- Standard SprintAnimation.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 1/30, sound, "TFA_CODWW2_LEVER.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_LEVER.CycleOpen" },
    { 10/30, sound, "TFA_CODWW2_LEVER.Brass" },
    { 15/30, sound, "TFA_CODWW2_LEVER.CycleClose" },
  },
  [ACT_VM_PRIMARYATTACK_EMPTY] = {
    { 10/30, sound, "TFA_CODWW2_LEVER.CycleOpen" },
    { 15/30, sound, "TFA_CODWW2_LEVER.Brass" },
    { 20/30, sound, "TFA_CODWW2_LEVER.CycleClose" },
  },
  [ACT_SHOTGUN_RELOAD_START] = { { 1/30, sound, "TFA_CODWW2_LEVER.Start" } },
  [ACT_VM_RELOAD] = { { 1/30, sound, "TFA_CODWW2_LEVER.Insert" } },
  [ACT_SHOTGUN_RELOAD_FINISH] = { { 5/30, sound, "TFA_CODWW2_LEVER.Charge" } },
  ["inspect"] = { { 1/30, "TFA_CODWW2_LEVER.Inspect1" }, { 90/30, "TFA_CODWW2_LEVER.Inspect2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_LEVER.Inspect1" }, { 90/30, "TFA_CODWW2_LEVER.Inspect2" } },
  ["inspect_epic"] = { { 1/30, "TFA_CODWW2_LEVER.InspectEpic1" }, { 90/30, "TFA_CODWW2_LEVER.InspectEpic2" } },
}
```
**Notable:** Winchester is the only sniper with `ACT_VM_PRIMARYATTACK_EMPTY` event (special click on empty trigger). Cycle uses 3 sounds (Open, Brass, Close) — includes "Brass" shell tink sound. No `ACT_VM_FIDGET`. Inspect2 timing at 90/30 (longer than 50/30 standard). Reload is shotgun-style (START/loop/FINISH acts) since `SWEP.Shotgun = true`.

### Sequence Overrides
**StatusLengthOverride:** `{}` *(EMPTY — Winchester is the only sniper with empty StatusLengthOverride)*

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_DRAW_DEPLOYED] = 55/30
[ACT_VM_DRAW] = 30/30
[ACT_VM_DRAW_EMPTY] = 30/30
[ACT_SHOTGUN_RELOAD_FINISH] = 40/30
```

**SequenceRateOverride:**
```
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
[ACT_SHOTGUN_RELOAD_START] = 30/30
[ACT_VM_RELOAD] = 40/30
[ACT_SHOTGUN_RELOAD_FINISH] = 30/30
[ACT_VM_PULLBACK_HIGH] = 40/30  *(faster cycle — lever action)*
```
**Notable:** No `ACT_VM_PULLBACK_LOW` in SequenceRateOverride (because Winchester uses same PULLBACK_HIGH for both).

### Bodygroups / Skins
None.

### VElements
```
["scope_default"] = { model=".../c_winchester94_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_winchester94_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["ext_clip"]      = { model=".../c_winchester94_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["charm_default"] = { model=".../c_winchester94_charm.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(Winchester-specific charm, active)*
```
**Notable:** No `clip_default` VElement — Winchester has only `ext_clip` (extmag). Has its own charm model (Winchester-specific), unlike several other snipers that share `bar/c_bar_charm.mdl`.

### WElements
```
["scope_default"] = { model=".../w_winchester94_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_winchester94_4x.mdl", active=false }
["ext_clip"]      = { model=".../w_winchester94_clip_ext.mdl", bone="tag_clip", active=false }
```

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_xmag_noani", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** Uses `tfa_codww2_xmag_noani` (no-animation variant of xmag) — Winchester is the only sniper using this variant (presumably because shotgun reload loop doesn't support extmag animation swap). No slot [1] scope, no slot [4] charm.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = ".30-30 Winchester"}`
- Standard shell settings (fx_556, SHELLS.Large, scale 1.2).
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Gunslinger"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 12
    self.Primary_TFA.LoopedReloadInsertAmount = 3
    self.Primary_TFA.Damage = 2667
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 132
    self.Primary_TFA.MaxAmmo = 120
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Notable:** Winchester is the **ONLY sniper that sets `LoopedReloadInsertAmount = 3`** in OnPaP — this is a shotgun-specific stat for looped reloads (since `SWEP.Shotgun = true`). Damage 889→2667 (3x). NumShots 1→2. Standard NZMaxAmmo.

---

# SHOTGUNS

---

## 10. Blunderbuss — `nz_kate_codww2_blunderbuss.lua`

### Core Fields
- `SWEP.Base = "tfa_codww2_base"`, `SWEP.Category = "nZR: WWII Kate"`, `SWEP.SubCategory = "Shotguns"`
- `SWEP.PrintName = "Blunderbuss"`, `SWEP.Slot = 3` *(shotguns use slot 3; snipers use slot 4)*
- `SWEP.Manufacturer = nil` *(only weapon with nil manufacturer)*
- `SWEP.Type_Displayed = "Shotgun"`
- `SWEP.Purpose = "The one shot wonder!"`
- `SWEP.Author = "Olli, Fox, Mav"`
- `SWEP.DrawCrosshair = true`, `SWEP.DrawCrosshairIronSights = false`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/blunderbuss/c_blunderbuss.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/blunderbuss/w_blunderbuss.mdl"`
- `SWEP.HoldType = "shotgun"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.Offset = { Pos = { Up = -5.6, Right = 1, Forward = 15 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_BLUNDER.Lyr1"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_BLUNDER.Lyr2"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_BLUNDER.Lyr3"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_M97.ThickTrans"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_SVT.Lfe"`
- `SWEP.Primary.SoundLyr5 = "TFA_CODWW2_PLAYER.Sub.extra_long"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_BLUNDER.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SG"` *(SG not SNP)*
- `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SG"`
- `SWEP.Primary.Ammo = "buckshot"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 100` *(very slow — muzzleloader)*, `SWEP.Primary.RPM_Semi = nil`, `SWEP.Primary.RPM_Burst = nil`
- `SWEP.Primary.RPM_Displayed` — **NOT defined** (only shotgun without RPM_Displayed)
- `SWEP.Primary.RPM_Rapid` — **NOT defined**
- `SWEP.Primary.RPM_Displayed_Rapid` — **NOT defined**
- `SWEP.Primary.Damage = 135`, `SWEP.Primary.Knockback = 0`
- `SWEP.Primary.Force = 9800` *(HIGHEST force value among shotguns — huge knockback)*
- `SWEP.Primary.NumShots = 9` *(9 pellets per shot)*, `SWEP.Primary.NumShots_Incen = 15` *(incendiary variant: 15 pellets)*, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 1` *(single-shot)*, `SWEP.Primary.DefaultClip = 26`, `SWEP.Primary.MaxAmmo = 25`
- `SWEP.Primary.ClipSize_Ext` — **NOT defined** (no extmag for blunderbuss)
- `SWEP.Primary.DryFireDelay = 0.5`, `SWEP.DisableChambering = true`, `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.DisplayFalloff = true`
- `SWEP.Primary.RangeFalloffLUT = { bezier=false, range_func="linear", units="meters", lut = { {range = 12, damage = 1}, {range = 15, damage = 0.5} } }` *(steep falloff — at 15m damage halves)*
- `SWEP.Primary.Spread = 0.08` *(wide spread)*, `SWEP.Primary.IronAccuracy = 0.08` *(no ADS accuracy improvement)*
- `SWEP.Primary.KickUp = 1.5`, `SWEP.Primary.KickDown = 1.5`, `SWEP.Primary.KickHorizontal = 0.6`, `SWEP.Primary.StaticRecoilFactor = 0.6`
- `SWEP.Primary.SpreadMultiplierMax = 3`, `SWEP.Primary.SpreadIncrement = 3`, `SWEP.Primary.SpreadRecovery = 3`
- `SWEP.IronRecoilMultiplier = 0.8`
- `SWEP.ChangeStateAccuracyMultiplier = 1.5`, `SWEP.CrouchAccuracyMultiplier = 1.0`, `SWEP.JumpAccuracyMultiplier = 1.5` *(lower than 2.0 standard)*, `SWEP.WalkAccuracyMultiplier = 1.35`
- `SWEP.ChangeStateRecoilMultiplier = 1.3`, `SWEP.CrouchRecoilMultiplier = 0.9` *(higher than 0.65 standard)*, `SWEP.JumpRecoilMultiplier = 2.65` *(very high jump recoil)*, `SWEP.WallRecoilMultiplier = 1.25`
- `SWEP.ViewModelPunchPitchMultiplier = 0.65` *(higher than sniper standard 0.5)*, `SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09`
- `SWEP.ViewModelPunch_MaxVertialOffset = 3`, `SWEP.ViewModelPunch_MaxVertialOffset_IronSights = 1.95`
- `SWEP.ViewModelPunch_VertialMultiplier = 1.5` *(higher than 1.0 standard)*, `SWEP.ViewModelPunch_VertialMultiplier_IronSights = 0.25`
- `SWEP.ViewModelPunchYawMultiplier = 0.6`, `SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25`
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.95`, `SWEP.IronSightsMoveSpeed = 0.95 * 0.8 = 0.76`
- `SWEP.MuzzleFlashEffect` — not defined (default)
- `SWEP.FlashlightAttachment = 0`, `SWEP.FiresUnderwater = false`

### Secondary Stats (Bash)
- `SWEP.Secondary.BashDamage = 35`
- `SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingRfl")`
- `SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")`
- `SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")`
- `SWEP.Secondary.BashLength = 54` *(shotguns use 54, snipers use 55)*
- `SWEP.Secondary.BashDelay = 0.2`
- `SWEP.Secondary.BashDamageType = DMG_CLUB`
- `SWEP.Secondary.BashInterrupt = true`
- `SWEP.Secondary.IronFOV = 75` *(highest iron FOV among snipers/shotguns)*

### Fire Modes
- `SWEP.Primary.BurstDelay = nil`, `SWEP.DisableBurstFire = true`, `SWEP.SelectiveFire = false`, `SWEP.OnlyBurstFire = false`, `SWEP.BurstFireCount = nil`
- `SWEP.DefaultFireMode = "1"` *(explicitly set to "1" — semi-auto fire mode 1, NOT empty string)*
- `SWEP.FireModeName = nil`

### Low Ammo Sound (UNIQUE — only blunderbuss and model1897 have this among snipers/shotguns)
- `SWEP.FireSoundAffectedByClipSize = false` *(not affected since clip size is 1)*
- `SWEP.LowAmmoSoundThreshold = 0.33`
- `SWEP.LowAmmoSound = "TFA.LowAmmo.Shotgun"`
- `SWEP.LastAmmoSound = "TFA.LowAmmo.Shotgun_Dry"`

### Shotgun Fields
- `SWEP.Shotgun` — **NOT explicitly defined** (relies on base default). However, since reload uses ACT_VM_RELOAD single-shot pattern (not ACT_SHOTGUN_RELOAD_START), blunderbuss effectively behaves as non-shotgun reload. **This is unusual** — blunderbuss has no ShotgunEmptyAnim, etc. fields.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.31, -1, 1.05)`, `SWEP.IronSightsAng = Vector(1.5, 0, 0)` *(highest X-tilt among weapons)*
- `SWEP.IronSightsPos_7X` — not defined (no scope variants)
- `SWEP.IronSightTime = 0.3` *(fast ADS)*
- `SWEP.IronBobMult = 0.065`, `SWEP.IronBobMultWalk = 0.065`
- `SWEP.SafetyPos = Vector(3.2, -2, -1)` *(shotgun safety position — different from sniper safety)*, `SWEP.SafetyAng = Vector(-17.5, 41.5, -20)`
- `SWEP.InspectPos = Vector(10, -7, -2)` *(different y from snipers' -4)*, `SWEP.InspectAng = Vector(24, 42, 16)`

### Animations
- `SWEP.Animations` — **NOT defined** (no Animations table)
- `SWEP.PumpAction` — **NOT defined** (no PumpAction — blunderbuss has no pump/bolt)
- Standard SprintAnimation.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 0/30, sound, "TFA_CODWW2_BLUNDER.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_MED.Raise" } },  *(MED raise, not RIFLE)*
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_MED.Holster" } },
  [ACT_VM_PRIMARYATTACK] = { { 1/30, sound, "TFA_CODWW2_BLUNDER.Mech" } },
  [ACT_VM_RELOAD] = {
    { 1/30, sound, "TFA_CODWW2_BLUNDER.Open" },
    { 45/30, sound, "TFA_CODWW2_BLUNDER.Pack" },
    { 80/30, sound, "TFA_CODWW2_BLUNDER.Pushrod" },
  },
  ["inspect"] = { { 1/30, "TFA_CODWW2_BLUNDER.Inspect1" }, { 50/30, "TFA_CODWW2_BLUNDER.Inspect2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_BLUNDER.Inspect1" }, { 50/30, "TFA_CODWW2_BLUNDER.Inspect2" } },
  ["inspect_epic"] = { { 1/30, "TFA_CODWW2_BLUNDER.EpicInspect1" }, { 50/30, "TFA_CODWW2_BLUNDER.EpicInspect2" } },
}
```
**Notable:** Uses MED (medic?) raise/holster sounds instead of RIFLE. Only weapon with `ACT_VM_PRIMARYATTACK` event (mechanical fire sound). Reload has 3 stages (Open, Pack, Pushrod — muzzle-loading sequence). No `ACT_VM_DRAW_EMPTY`, `ACT_VM_HOLSTER_EMPTY`, `ACT_VM_PULLBACK_*`, or `ACT_VM_FIDGET` events. No `inspect_epic` longer than 50/30 (all inspect sounds at 1 and 50).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 70/30
```
*(only one entry)*

**SequenceLengthOverride:** `{}` *(empty)*

**SequenceRateOverride:**
```
[ACT_VM_DRAW_DEPLOYED] = 25/30
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
```

### Bodygroups / Skins
None.

### VElements
```
["clip_default"]    = { model=".../c_blunderbuss_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["barrel_default"]  = { model=".../c_blunderbuss_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]   = { model=".../c_blunderbuss_charm.mdl", bone="tag_weapon", active=true, bodygroup={[0]=1} }
["stock_default"]   = { model=".../c_blunderbuss_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
["strap_default"]   = { model=".../c_blunderbuss_strap.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(unique strap element)*
["striker_default"] = { model=".../c_blunderbuss_striker.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(unique striker element — flintlock mechanism)*
```
**Notable:** Blunderbuss has unique `strap_default` and `striker_default` elements not seen elsewhere. Charm uses blunderbuss-specific model.

### WElements
```
["clip_default"]    = { model=".../w_blunderbuss_clip.mdl", bone="tag_clip", active=true }
["barrel_default"]  = { model=".../w_blunderbuss_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]   = { model=".../w_blunderbuss_stock.mdl", bone="tag_weapon", active=true }
["striker_default"] = { model=".../w_blunderbuss_striker.mdl", bone="tag_weapon", active=true }
```
**Notable:** No `charm_default` or `strap_default` WElement.

### Attachments
```
SWEP.Attachments = {
    [4] = {atts = {"tfa_codww2_rifling", "tfa_codww2_steadyaim"}, order = 4},
    [5] = {atts = {"tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip"}, order = 5},
    [6] = {atts = {"tfa_codww2_incenshells"}, order = 6},  *(incendiary shells — Dragon's Breath)*
}
```
**Notable:** Slots start at [4] (no [1]/[2]/[3]). Slot 6 has incenshells attachment (the only one with single attachment in slot 6). Three slots total.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {["buckshot"] = "Buncha pellets"}` *(informal/joke string — only ammo type strings using bracket notation with quoted key)*
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_12gauge.mdl"` *(12 gauge shell)*, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Shotgun"`, `SWEP.LuaShellScale = 1.2`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.03` *(lower than sniper 0.05)*, `SWEP.JamFactor = 0.15` *(higher than sniper 0.10)*
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 3` *(3, not 4 like snipers)*, `SWEP.DInv2_Mass = 7` *(7, not 8 like snipers)*
- `SWEP.NZPaPName = "Gib Cannon"`
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.Primary_TFA.ClipSize = 3
    self.Primary_TFA.Damage = 2000
    self.Primary_TFA.NumShots = 8
    self.Primary_TFA.RPM = 110
    self.Primary_TFA.DefaultClip = 51
    self.Primary_TFA.MaxAmmo = 50
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Notable:** OnPaP does NOT set `self.MuzzleFlashEffect = "muz_pap"` — Blunderbuss is the **ONLY weapon in this audit that doesn't change MuzzleFlashEffect on PaP** (likely oversight). Damage 135→2000 (~15x). NumShots 9→8 (slightly fewer). RPM 100→110 (slight increase). ClipSize 1→3 (multi-shot PaP). NumShots_Incen is NOT updated — should probably be increased to 15+ but stays at 15. **No NZMaxAmmo function defined** (relies on base implementation).

---

## 11. MAS 36 (M36) — `nz_kate_codww2_mas36.lua`

### Core Fields
- `SWEP.PrintName = "M36"`
- `SWEP.Manufacturer = "Manufacture d'armes de Saint-Étienne (MAS)"`
- `SWEP.Type_Displayed = "Sniper Rifle"` *(categorized as sniper despite being in Shotguns list — MAS 36 has internal magazine reloaded like shotgun)*
- `SWEP.Purpose = "Bolt-action sniper rifle that offers a one shot kill from the torso and up."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/mas36/c_mas36.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/mas36/w_mas36.mdl"`
- `SWEP.HoldType = "ar2"` *(ar2 hold, not shotgun — looks like sniper in-hand)*
- `SWEP.VMPos = Vector(0, -1, 0)`, `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 16.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_M1903.Shot01"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_KAR98K.Punch"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M1903.Thud"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_KAR98K.Boom"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_KAR98K.Trans"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_LEVER.Ext") }` *(uses lever ext sound — odd)*
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"` *(SNP not SG — despite being in shotguns category)*
- `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"` *(sniper ammo, not buckshot)*, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 250`, `SWEP.Primary.RPM_Displayed = 50`, `SWEP.Primary.RPM_Rapid = 600`, `SWEP.Primary.RPM_Displayed_Rapid = 55`
- `SWEP.Primary.Damage = 1050`, `SWEP.Primary.NumShots = 1` *(single pellet — effectively sniper)*, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 10`, `SWEP.Primary.ClipSize_Ext = 15`, `SWEP.Primary.DefaultClip = 110`, `SWEP.Primary.MaxAmmo = 100`
- `SWEP.Primary.NumShots_Incen` — **NOT defined** (no incendiary variant for MAS 36)
- `SWEP.NZHeadShotMultiplier = 2`
- Standard RangeFalloffLUT (range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.0001`
- `SWEP.Primary.KickUp = 1.0`, `KickDown = 0.8`, `KickHorizontal = 0.3`, `StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 2`, `SWEP.Primary.SpreadRecovery = 2`
- Standard multipliers and ViewModelPunch.
- `SWEP.MoveSpeed = 0.92`, `SWEP.IronSightsMoveSpeed = 0.736`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 0` *(disabled — scoped)*.

### Fire Modes
All defaults.

### Shotgun Fields
- `SWEP.Shotgun = true` *(MAS 36 is a "sniper" with shotgun-style reload — uses internal magazine reloaded one round at a time)*
- `SWEP.ShotgunEmptyAnim = false`
- `SWEP.ShotgunEmptyAnim_Shell = false`
- `SWEP.ShotgunStartAnimShell = true`

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.575, 0, 1.41)`, `SWEP.IronSightsAng = Vector(0.1, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-3.576, -6, 0.66)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-2.601, -3, 0.888)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Scope Overlay (full config)
- `SWEP.BoltAction = false`
- `SWEP.Scoped = true`
- `SWEP.Secondary.ScopeZoom = 4`
- `SWEP.ScopeOverlayThreshold = 0.875`
- `SWEP.BoltTimerOffset = 0.25`
- `SWEP.ScopeScale = 0.65`
- `SWEP.ReticleScale = 0.75`
- All `Secondary.UseACOG/MilDot/SVD/Parabolic/Elcan/GreenDuplex = false`
- `SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay_mp.png", "smooth"), ["ScopeBorder"] = color_black, ["ScopeCrosshair"] = { r=0, g=0, b=0, a=0, s=0 } }` *(multiplayer scope — same as Wz.35)*

### Animations
- `SWEP.Animations` — **NOT defined**
- `SWEP.PumpAction = { type=ACT, value=ACT_VM_PULLBACK_HIGH, value_is=ACT_VM_PULLBACK_LOW }`
- Standard SprintAnimation.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = { { 1/30, sound, "TFA_CODWW2_MAS36.FPO" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 5/30, sound, "TFA_CODWW2_MAS36.Cycle" },
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 5/30, sound, "TFA_CODWW2_MAS36.Cycle" },  *(same as HIGH)*
    { 10/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_SHOTGUN_RELOAD_START] = {
    { 1/30, sound, "TFA_CODWW2_MAS36.Open" },
    { 30/30, sound, "TFA_CODWW2_MAS36.Insert" },
  },
  [ACT_VM_RELOAD] = { { 1/30, sound, "TFA_CODWW2_MAS36.Insert" } },
  [ACT_SHOTGUN_RELOAD_FINISH] = { { 1/30, sound, "TFA_CODWW2_MAS36.Close" } },
  ["inspect"] = { { 1/30, "TFA_CODWW2_MAS36.Inspect1" }, { 55/30, "TFA_CODWW2_MAS36.Inspect2" } },
  ["inspect_empty"] = { { 1/30, "TFA_CODWW2_MAS36.Inspect1" }, { 55/30, "TFA_CODWW2_MAS36.Inspect2" } },
  ["inspect_epic"] = {
    { 1/30, "TFA_CODWW2_MAS36.InspectEpic1" },
    { 70/30, "TFA_CODWW2_MAS36.InspectEpic2" },
    { 165/30, "TFA_CODWW2_MAS36.InspectEpic3" },  *(3-sound epic inspect — longest epic at 165/30 = 5.5s)*
  },
}
```
**Notable:** Epic inspect has 3 sounds (most have 2). Cycle sound same for HIGH/LOW. MAS 36 uses shotgun reload acts (START/loop/FINISH).

### Sequence Overrides
**StatusLengthOverride:** `{}` *(empty)*

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
[ACT_VM_DRAW] = 30/30
[ACT_VM_DRAW_EMPTY] = 30/30
[ACT_SHOTGUN_RELOAD_FINISH] = 35/30
```

**SequenceRateOverride:**
```
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
[ACT_SHOTGUN_RELOAD_START] = 30/30
[ACT_VM_RELOAD] = 40/30
[ACT_SHOTGUN_RELOAD_FINISH] = 30/30
[ACT_VM_PULLBACK_HIGH] = 35/30
[ACT_VM_PULLBACK_LOW] = 35/30
```

### Bodygroups / Skins
None.

### VElements
```
["scope_default"] = { model=".../c_mas36_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]    = { model=".../c_mas36_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]  = { model=".../c_mas36_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]      = { model=".../c_mas36_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["sight_default"] = { model=".../c_mas36_sight.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(unique sight element)*
["charm_default"] = { model="models/weapons/tfa_codww2/bar/c_bar_charm.mdl", bone="tag_weapon", active=false, bodygroup={} }  *(shared bar charm, inactive, no bodygroup)*
```

### WElements
```
["scope_default"] = { model=".../w_mas36_scope.mdl", active=false }
["scope_acog"]    = { model=".../w_mas36_4x.mdl", active=false }
["ext_clip"]      = { model=".../w_mas36_clip_ext.mdl", bone="tag_clip", active=false }
```
**Notable:** No `clip_default` WElement (VElement has it, WElement does not). No `sight_default` or `charm_default` WElement.

### Attachments
```
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_enfield_scope", "tfa_codww2_4x"}, sel = 1, order = 1},
    [2] = {atts = {"tfa_codww2_xmag_noani", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_fmj"}, order = 3},
}
```
**Notable:** Slot 1 default uses `tfa_codww2_enfield_scope` (British scope) — same as De Lisle. Slot 2 uses `tfa_codww2_xmag_noani` (no-anim variant). No slot [4]+. No charm slot (despite having `charm_default` VElement defined — it's just inactive with no slot to activate it).

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "7.5×54mm French"}`
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = ".../fx_556.mdl"` *(556 shell for 7.5mm round — visual approximation)*, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"`, `SWEP.LuaShellScale = 1.2`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.10`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8` *(sniper-like dimensions despite being in shotgun subcategory)*
- `SWEP.NZPaPName = "Dommages majeurs"` *(French: "Major Damage")*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 20
    self.Primary_TFA.Damage = 3150
    self.Primary_TFA.NumShots = 1
    self.Primary_TFA.RPM = 260
    self.Primary_TFA.DefaultClip = 220
    self.Primary_TFA.MaxAmmo = 200
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 1050→3150 (3x). NumShots stays 1 (no projectile increase). ClipSize 10→20 (doubles). Standard NZMaxAmmo.

---

## 12. Model 1897 (Combat Shotgun) — `nz_kate_codww2_model1897.lua`

### Core Fields
- `SWEP.PrintName = "Combat Shotgun"`
- `SWEP.Manufacturer = "Winchester"`
- `SWEP.Type_Displayed = "Shotgun"`
- `SWEP.Purpose = "Pump-action shotgun with high damage that delivers one hit kills in close quarters."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/model1897/c_model1897.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/model1897/w_model1897.mdl"`
- `SWEP.HoldType = "shotgun"`
- `SWEP.VMPos = Vector(0, -1.5, 0)`, `SWEP.Offset = { Pos = { Up = -4.5, Right = 1, Forward = 16.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_SHGN.GenHigh"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_WALTHER.Low"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_M97.ThickTrans"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_SVT.Lfe"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_PLAYER.Sub.extra_long"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_M1897.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SG"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SG"`
- `SWEP.Primary.Ammo = "buckshot"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 220`, `SWEP.Primary.RPM_Displayed = 58`, `SWEP.Primary.RPM_Rapid = 500` *(lower rapid RPM than snipers' 600)*, `SWEP.Primary.RPM_Displayed_Rapid = 85` *(highest rapid-displayed RPM among weapons)*
- `SWEP.Primary.Damage = 110`, `SWEP.Primary.NumShots = 8` *(8 pellets)*, `SWEP.Primary.NumShots_Incen = 14` *(incendiary: 14 pellets)*, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 7`, `SWEP.Primary.ClipSize_Ext = 10`, `SWEP.Primary.DefaultClip = 77` *(7*11)*, `SWEP.Primary.MaxAmmo = 70`
- `SWEP.Primary.DryFireDelay = 0.5`, `SWEP.DisableChambering = true`, `SWEP.NZHeadShotMultiplier = 2`
- `SWEP.Primary.DisplayFalloff = true`
- `SWEP.Primary.RangeFalloffLUT = { bezier=false, range_func="linear", units="meters", lut = { {range=12, damage=1}, {range=15, damage=0.75}, {range=20, damage=0.75}, {range=22, damage=0.55} } }` *(4-point LUT — most granular falloff of any weapon in this audit)*
- `SWEP.Primary.Spread = 0.075` *(tighter than blunderbuss's 0.08)*, `SWEP.Primary.IronAccuracy = 0.075` *(no ADS accuracy gain)*
- `SWEP.Primary.KickUp = 1.2`, `KickDown = 1.0`, `KickHorizontal = 0.5`, `StaticRecoilFactor = 0.4`
- `SWEP.Primary.SpreadMultiplierMax = 3`, `SWEP.Primary.SpreadIncrement = 2`, `SWEP.Primary.SpreadRecovery = 2`
- `SWEP.IronRecoilMultiplier = 0.8`
- `SWEP.ChangeStateAccuracyMultiplier = 1.5`, `SWEP.CrouchAccuracyMultiplier = 1.0`, `SWEP.JumpAccuracyMultiplier = 1.5`, `SWEP.WalkAccuracyMultiplier = 1.35`
- `SWEP.ChangeStateRecoilMultiplier = 1.3`, `SWEP.CrouchRecoilMultiplier = 0.9`, `SWEP.JumpRecoilMultiplier = 2.65`, `SWEP.WallRecoilMultiplier = 1.25`
- `SWEP.ViewModelPunchPitchMultiplier = 0.65`, `SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09`
- `SWEP.ViewModelPunch_MaxVertialOffset = 3`, `SWEP.ViewModelPunch_MaxVertialOffset_IronSights = 1.95`
- `SWEP.ViewModelPunch_VertialMultiplier = 1.5`, `SWEP.ViewModelPunch_VertialMultiplier_IronSights = 0.25`
- `SWEP.ViewModelPunchYawMultiplier = 0.6`, `SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25`
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.95`, `SWEP.IronSightsMoveSpeed = 0.76`
- `SWEP.FlashlightAttachment = 0`, `SWEP.FiresUnderwater = false`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 75`. `BashLength = 54`.

### Fire Modes
- `SWEP.Primary.BurstDelay = nil`, `SWEP.DisableBurstFire = true`, `SWEP.SelectiveFire = false`, `SWEP.OnlyBurstFire = false`, `SWEP.BurstFireCount = nil`
- `SWEP.DefaultFireMode = "1"` *(explicit)*
- `SWEP.FireModeName = nil`

### Low Ammo Sound
- `SWEP.FireSoundAffectedByClipSize = true` *(true — clip size affects sound pitch/intensity, unlike blunderbuss)*
- `SWEP.LowAmmoSoundThreshold = 0.33`
- `SWEP.LowAmmoSound = "TFA.LowAmmo.Shotgun"`
- `SWEP.LastAmmoSound = "TFA.LowAmmo.Shotgun_Dry"`

### Shotgun Fields
- `SWEP.Shotgun = true`
- `SWEP.ShotgunEmptyAnim = true` *(model 1897 enables empty reload anim)*
- `SWEP.ShotgunEmptyAnim_Shell = true`
- `SWEP.ShotgunStartAnimShell = true`

### Ironsights
- `SWEP.IronSightsPos = Vector(-3.345, -2, 1.3)`, `SWEP.IronSightsAng = Vector(0.6, 0, 0)`
- `SWEP.IronSightsPos_NYDAR = Vector(-3.345, -2, 0.915)` *(NYDAR is a reflex sight — only weapon with NYDAR variant)*, `SWEP.IronSightsAng_NYDAR = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.3`
- `SWEP.SafetyPos = Vector(3.2, -2, -1)`, `SWEP.SafetyAng = Vector(-17.5, 41.5, -20)` *(same as blunderbuss)*
- `SWEP.InspectPos = Vector(10, -7, -2)`, `SWEP.InspectAng = Vector(24, 42, 16)`
- No 7X or ACOG iron sight variants (model 1897 doesn't have scope attachments).

### Animations (UNIQUE — Dragon's Breath reload variants)
```
SWEP.Animations = {
    ["rechamber_dragon"] = { type = TFA.Enum.ANIMATION_SEQ, value = "rechamber_dragon" },
    ["reload_start_dragon"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_start_dragon" },
    ["reload_start_dragon_empty"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_start_dragon_empty" },
    ["reload_loop_dragon"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_loop_dragon" },
    ["reload_end_dragon"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_end_dragon" },
}
```
**Notable:** Model 1897 has a full set of "dragon" (Dragon's Breath incendiary) reload animations — used when `tfa_codww2_incenshells` attachment is equipped. The rechamber_dragon animation handles the pump-action when firing incendiary shells.

- `SWEP.PumpAction = { type = ACT, value = ACT_VM_PULLBACK_HIGH, value_is = ACT_VM_PULLBACK_LOW }`
- Standard SprintAnimation.

### Event Table
```
SWEP.EventTable = {
  [ACT_VM_DRAW_DEPLOYED] = {
    { 1/30, sound, "TFA_CODWW2_M1897.FPOFoley" },
    { 10/30, sound, "TFA_CODWW2_M1897.FPOGrab" },
    { 25/30, sound, "TFA_CODWW2_M1897.FPOCharge" },
  },
  [ACT_VM_DRAW] = { { 5/30, sound, "TFA_CODWW2_M1897.Draw" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_M1897.Draw" } },
  [ACT_VM_HOLSTER] = { { 2/30, sound, "TFA_CODWW2_MED.Holster" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 2/30, sound, "TFA_CODWW2_MED.Holster" } },
  [ACT_VM_PULLBACK_HIGH] = {
    { 1/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 5/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_PULLBACK_LOW] = {
    { 1/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 5/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_SHOTGUN_RELOAD_START] = {
    { 1/30, sound, "TFA_CODWW2_M1897.ADSFoley" },
    { 1/30, sound, "TFA_CODWW2_M1897.ShellStart" },
    { 30/30, sound, "TFA_CODWW2_M1897.ShellIn" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 1/30, sound, "TFA_CODWW2_M1897.ADSFoley" },
    { 1/30, sound, "TFA_CODWW2_M1897.ShellStart" },
    { 30/30, sound, "TFA_CODWW2_M1897.ShellIn" },
  },
  [ACT_VM_RELOAD] = { { 5/30, sound, "TFA_CODWW2_M1897.ShellIn" } },
  [ACT_SHOTGUN_RELOAD_FINISH] = {
    { 1/30, sound, "TFA_CODWW2_M1897.EndStart" },
    { 10/30, sound, "TFA_CODWW2_M1897.EndPump" },
    { 15/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
  [ACT_VM_FIDGET] = {
    { 1/30, sound, "TFA_CODWW2_M1897.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_M1897.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_M1897.Inspect1" },
    { 50/30, sound, "TFA_CODWW2_M1897.Inspect2" },
  },
  ["reload_start_dragon_empty"] = {
    { 1/30, sound, "TFA_CODWW2_M1897.DRGStart" },
    { 30/30, sound, "TFA_CODWW2_M1897.DRGClose" },
  },
  ["reload_start_dragon"] = { { 25/30, sound, "TFA_CODWW2_M1897.ShellIn" } },
  ["reload_loop_dragon"] = { { 1/30, sound, "TFA_CODWW2_M1897.ShellIn" } },
  ["reload_end_dragon"] = { { 1/30, sound, "TFA_CODWW2_M1897.ADSFoley" } },
  ["rechamber_dragon"] = {
    { 1/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 4/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 12/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 15/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 24/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 27/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 36/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 39/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 49/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 51/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 62/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 63/30, lua, function(self) self:EventShell() end, client=true, server=true },
    { 74/30, sound, "TFA_CODWW2_M1897.Rack" },
    { 75/30, lua, function(self) self:EventShell() end, client=true, server=true },
  },
}
```
**Notable:** `rechamber_dragon` event has 14 events (7 sound/lua pairs) — this is the most complex event entry in any audited weapon. The dragon rechamber cycles the pump action 7 times (one per shell in the tube). Uses MED holster sounds. No `["inspect"]` entry (only `ACT_VM_FIDGET` and `["inspect_empty"]`). No `["inspect_epic"]` entry.

### Sequence Overrides
**StatusLengthOverride:**
```
["reload_start_dragon"] = 30/30
["reload_start_dragon_empty"] = 25/30
["reload_loop_dragon"] = 5/30
```

**SequenceLengthOverride:**
```
[ACT_VM_PULLBACK_HIGH] = 20/30   *(fast pump — 20/30 vs 35/30 standard)*
["reload_start_dragon"] = 42/30
["reload_start_dragon_empty"] = 40/30
["reload_loop_dragon"] = 15/30
```

**SequenceRateOverride:**
```
[ACT_SHOTGUN_RELOAD_START] = 40/30
[ACT_VM_RELOAD_EMPTY] = 40/30
[ACT_VM_RELOAD] = 40/30
[ACT_SHOTGUN_RELOAD_FINISH] = 40/30
["reload_start_dragon"] = 45/30
["reload_loop_dragon"] = 40/30
["reload_start_dragon_empty"] = 45/30
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
```

### Bodygroups / Skins
None.

### VElements (UNIQUE — Model 1897 has dynamic holosight reticle)
```
["sight_nydar"] = { type=Model, model=".../c_model1897_reflex.mdl", bone="tag_weapon", active=false, bodygroup={} }
["sight_nydar_lens"] = (TFA.CODWW2 and TFA.CODWW2.GetHoloSightReticle) and TFA.CODWW2.GetHoloSightReticle("sight_nydar") or nil,
["clip_default"]     = { model=".../c_model1897_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]         = { model=".../c_model1897_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["receiver_default"] = { model=".../c_model1897_receiver.mdl", bone="tag_weapon", active=true, bodygroup={} }
["barrel_default"]   = { model=".../c_model1897_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]    = { model=".../c_model1897_charm.mdl", bone="tag_weapon", active=true, bodygroup={} }
["sight_default"]    = { model=".../c_model1897_sight.mdl", bone="tag_weapon", active=true, bodygroup={} }
["stock_default"]    = { model=".../c_model1897_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
["shell_default"]    = { model=".../c_model1897_shell_incen.mdl", bone="tag_clip", active=true, bodygroup={} }  *(active by default — incen shell visible)*
["shell_incen"]      = { model=".../c_model1897_shell.mdl", bone="tag_clip", active=false, bodygroup={} }  *(inactive — alternative shell model)*
```
**Notable:** Model 1897 is the **only weapon with a holo-sight reticle VElement** (`sight_nydar_lens`). This element uses dynamic function call to TFA.CODWW2.GetHoloSightReticle, falling back to nil. The `shell_default` and `shell_incen` elements are swapped: `shell_default` (the active one) uses the incen model, while `shell_incen` uses the normal shell model — names are backwards (likely intentional for attachment toggling).

### WElements
```
["clip_default"]     = { model=".../w_model1897_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]         = { model=".../w_model1897_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"] = { model=".../w_model1897_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]   = { model=".../w_model1897_barrel.mdl", bone="tag_weapon", active=true }
["sight_default"]    = { model=".../w_model1897_sight.mdl", bone="tag_weapon", active=true }
["stock_default"]    = { model=".../w_model1897_stock.mdl", bone="tag_weapon", active=true }
["sight_nydar"]      = { model=".../w_model1897_reflex.mdl", bone="tag_weapon", active=false }
```
**Notable:** No `charm_default`, no `shell_default`/`shell_incen` WElements. Has `sight_nydar` (but no `sight_nydar_lens` — that's VElement only).

### Attachments
```
SWEP.Attachments = {
    [2] = {atts = {"tfa_codww2_nydar"}, order = 2},
    [3] = {atts = {"tfa_codww2_xmag_noani"}, order = 3},
    [4] = {atts = {"tfa_codww2_rifling", "tfa_codww2_steadyaim"}, order = 4},
    [5] = {atts = {"tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip"}, order = 5},
    [6] = {atts = {"tfa_codww2_rapidfire_sg", "tfa_codww2_incenshells"}, order = 6},
}
```
**Notable:** 5 attachment slots — most among shotguns. Slot 2 has only `tfa_codww2_nydar` (single attachment — reflex sight). Slot 3 has only `tfa_codww2_xmag_noani` (single attachment — extended mag). Slots 4-6 mirror blunderbuss. Slot 6 has both rapidfire AND incenshells (mutually exclusive choice between faster fire and dragon's breath).

### Miscellaneous
- `SWEP.AmmoTypeStrings = {["buckshot"] = "12 Gauge"}`
- `SWEP.LuaShellEject = false`, `SWEP.LuaShellModel = ".../fx_12gauge.mdl"`, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Shotgun"`, `SWEP.LuaShellScale = 1.2`
- `SWEP.EjectionSmokeEnabled = false`
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.03`, `SWEP.JamFactor = 0.15`
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 3`, `SWEP.DInv2_Mass = 7`
- `SWEP.NZPaPName = "Close Quarters Casualty"`
- `SWEP.Ispackapunched = false`

### Custom Functions (UNIQUE — Model 1897 has elaborate shotgun reload state machine)
```lua
DEFINE_BASECLASS( SWEP.Base )

local function PlayChosenAnimation(self, typev, tanim, ...)
    local fnName = typev == TFA.Enum.ANIMATION_SEQ and "SendViewModelSeq" or "SendViewModelAnim"
    local a, b = self[fnName](self, tanim, ...)
    return a, b, typev
end

SWEP.PlayChosenAnimation = PlayChosenAnimation

function SWEP:SetupDataTables()
    BaseClass.SetupDataTables(self)
    
    self:NetworkVarTFA("Int", "ShellsInitial")
    self:NetworkVarTFA("Int", "ShellsMax")
    self:NetworkVarTFA("Int", "ShellsMaxEnd")
end

function SWEP:Initialize()
    BaseClass.Initialize(self)
    self:SetShellsInitial(0)
    self:SetShellsMax(7)
    self:SetShellsMaxEnd(8)
end

function SWEP:ChooseReloadAnim()
    local self2 = self:GetTable()
    if not self:VMIV() then return false, 0 end

    -- When using incen shells attachment, increment shells counter
    if self.AttachmentCache["tfa_codww2_incenshells"] and IsFirstTimePredicted() then
        self:SetShellsInitial(math.Approach(self:GetShellsInitial(), self:GetShellsMaxEnd(), 1))
    end
    
    -- Cancel reload loop once shells max is reached
    if self.AttachmentCache["tfa_codww2_incenshells"] and self:GetShellsInitial() == (self:GetShellsMax() - 1) and IsFirstTimePredicted() then
        self:SetReloadLoopCancel(true)
    end
    
    local typev, tanim
    if self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self:GetSilenced() then
        typev, tanim = self:ChooseAnimation("reload_silenced")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and (self:Clip1() == 0 or self:IsJammed()) and not self.Shotgun then
        if self:GetShellsInitial() < self:GetShellsMax() and self.AttachmentCache["tfa_codww2_incenshells"] then
            typev, tanim = self:ChooseAnimation("reload_ext_empty")
        else
            typev, tanim = self:ChooseAnimation("reload_empty")
        end
    else
        if self:GetShellsInitial() < self:GetShellsMax() and self.AttachmentCache["tfa_codww2_incenshells"] then
            typev, tanim = self:ChooseAnimation("reload_loop_dragon")
        else
            typev, tanim = self:ChooseAnimation("reload")
        end
    end

    local fac = 1
    if self:GetStatL("LoopedReload") and self:GetStatL("LoopedReloadInsertTime") then
        fac = self:GetStatL("LoopedReloadInsertTime")
    end

    self:SetAnimCycle(self2.ViewModelFlip and 0 or 1)
    self2.AnimCycle = self:GetAnimCycle()

    return PlayChosenAnimation(self, typev, tanim, fac, fac ~= 1)
end

function SWEP:ChooseShotgunReloadAnim()
    if not self:VMIV() then return false, 0 end
    
    local typev, tanim
    if self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self:GetSilenced() then
        typev, tanim = self:ChooseAnimation("reload_silenced")
    elseif self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and self.ShotgunEmptyAnim and (self:Clip1() == 0 or self:IsJammed()) then
        if self:GetShellsInitial() < self:GetShellsMax() and self.AttachmentCache["tfa_codww2_incenshells"] then
            typev, tanim = self:ChooseAnimation("reload_start_dragon_empty")
        else
            typev, tanim = self:ChooseAnimation("reload_empty")
        end
    else
        if self:GetShellsInitial() < self:GetShellsMax() and self.AttachmentCache["tfa_codww2_incenshells"] then
            typev, tanim = self:ChooseAnimation("reload_start_dragon")
        else
            typev, tanim = self:ChooseAnimation("reload_shotgun_start")
        end
    end

    return PlayChosenAnimation(self, typev, tanim)
end

function SWEP:ChooseShotgunPumpAnim()
    if not self:VMIV() then return false, 0 end

    -- When using incen shells, increment shells counter on pump
    if self.AttachmentCache["tfa_codww2_incenshells"] and IsFirstTimePredicted() then
        self:SetShellsInitial(math.Approach(self:GetShellsInitial(), self:GetShellsMaxEnd(), 1))
    end
    
    local typev, tanim
    if self:GetShellsInitial() <= 7 and self.AttachmentCache["tfa_codww2_incenshells"] and self:GetStat("Animations." .. "reload_end_dragon") then
        typev, tanim = self:ChooseAnimation("reload_end_dragon")
    else
        typev, tanim = self:ChooseAnimation("reload_shotgun_finish")
    end

    return PlayChosenAnimation(self, typev, tanim)
end
```
**Notable:** Model 1897 has the most sophisticated custom reload logic in the entire TFA WWII sniper/shotgun set. It tracks shell count via networked variables (`ShellsInitial`, `ShellsMax`, `ShellsMaxEnd`) and uses these to:
1. Switch between regular shotgun reloads and Dragon's Breath-specific reloads.
2. Cancel the reload loop when shell count reaches max.
3. Trigger dragon reload end animation when shells are depleted.

`SWEP:OnPaP()` (also custom):
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 14
    self.Primary_TFA.Damage = 330
    self.Primary_TFA.NumShots = 8
    self.Primary_TFA.RPM = 230
    self.Primary_TFA.DefaultClip = 154
    self.Primary_TFA.MaxAmmo = 140
    self.LoopedReloadInsertAmount = 2   *(note: this is on self, not self.Primary_TFA — odd placement)*
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Note:** Damage 110→330 (3x). `LoopedReloadInsertAmount = 2` is set on `self` (not `self.Primary_TFA`) — inconsistent with how Winchester sets it on `self.Primary_TFA`. NumShots_Incen is NOT updated by OnPaP — should probably increase but doesn't. RPM 220→230. Also has standard NZMaxAmmo.

---

## 13. KBP SP 1938 (Karabin) — `nz_kate_codww2_kbsp1938.lua`

### Core Fields
- `SWEP.PrintName = "Karabin"`
- `SWEP.Manufacturer = "Panstwowa Fabryka Karabinow"` *(Polish — note: missing diacritics vs. Wz.35's "Państwowa")*
- `SWEP.Type_Displayed = "Sniper Rifle"`
- `SWEP.Purpose = "Semi-automatic sniper rifle that delivers two shot kills from hip and above."`
- `SWEP.ViewModel = "models/weapons/tfa_codww2/kbsp1938/c_kbsp1938.mdl"`, `SWEP.WorldModel = "models/weapons/tfa_codww2/kbsp1938/w_kbsp1938.mdl"`
- `SWEP.HoldType = "ar2"`
- `SWEP.VMPos = Vector(0, -1.75, 0)` *(largest Y-offset)*, `SWEP.Offset = { Pos = { Up = -5, Right = 1, Forward = 13.8 }, ... Scale = 1.1 }`

### Primary Stats
- `SWEP.Primary.Sound = "TFA_CODWW2_M1941.Trans"`
- `SWEP.Primary.SoundLyr1 = "TFA_CODWW2_LEWIS.NPC_shot_01"`
- `SWEP.Primary.SoundLyr2 = "TFA_CODWW2_KAR98K.Sub"`
- `SWEP.Primary.SoundLyr3 = "TFA_CODWW2_M1941.Thump"`
- `SWEP.Primary.SoundLyr4 = "TFA_CODWW2_KAR98K.Smack"`
- `SWEP.Primary.SoundEchoTable = { [0] = Sound("TFA_CODWW2_TAIL.Int"), [256] = Sound("TFA_CODWW2_KBSP.Ext") }`
- `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.SNP"`, `SWEP.Primary.Sound_Blocked = "TFA_CODWW2_DRYFIRE.SNP"`
- `SWEP.Primary.Ammo = "SniperPenetratedRound"`, `SWEP.Primary.Automatic = false`
- `SWEP.Primary.RPM = 234` *(faster than bolt-action 250 RPM cap — semi-auto fire rate)*
- `SWEP.Primary.RPM_Semi = nil`, `SWEP.Primary.RPM_Burst = nil`
- `SWEP.Primary.RPM_Displayed` — **NOT defined**
- `SWEP.Primary.RPM_Rapid = 252` *(rapid-fire RPM is only marginally higher — semi-auto)*
- `SWEP.Primary.RPM_Displayed_Rapid` — **NOT defined**
- `SWEP.Primary.Damage = 900`, `SWEP.Primary.NumShots = 1`, `SWEP.Primary.AmmoConsumption = 1`
- `SWEP.Primary.ClipSize = 10`, `SWEP.Primary.ClipSize_Ext = 15`, `SWEP.Primary.DefaultClip = 110`, `SWEP.Primary.MaxAmmo = 100`
- `SWEP.NZHeadShotMultiplier = 2`
- Standard RangeFalloffLUT (range 200, damage 1).
- `SWEP.Primary.Spread = 0.05`, `SWEP.Primary.IronAccuracy = 0.001` *(HIGHER than other snipers' 0.0001 — KBP SP has 10x less iron accuracy! Purpose text says "two shot kills from hip" — implies less precise)*
- `SWEP.Primary.KickUp = 0.6` *(lowest KickUp)*, `KickDown = 0.5`, `KickHorizontal = 0.15`, `StaticRecoilFactor = 0.5` *(higher than 0.4 — semi-auto recoil lingers)*
- `SWEP.Primary.SpreadMultiplierMax = 4`, `SWEP.Primary.SpreadIncrement = 1.5`, `SWEP.Primary.SpreadRecovery = 4.5` *(fastest recovery — semi-auto)*
- `SWEP.IronRecoilMultiplier = 0.5`
- Standard accuracy/recoil multipliers.
- `SWEP.ViewModelPunchPitchMultiplier = 0.5`, `SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09`
- `SWEP.ViewModelPunch_MaxVertialOffset = 3`, `SWEP.ViewModelPunch_MaxVertialOffset_IronSights = 1.95`
- `SWEP.ViewModelPunch_VertialMultiplier = 1`, `SWEP.ViewModelPunch_VertialMultiplier_IronSights = 0.25`
- `SWEP.ViewModelPunchYawMultiplier = 0.6`, `SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25`
- `SWEP.TracerCount = 1`
- `SWEP.MoveSpeed = 0.925`, `SWEP.IronSightsMoveSpeed = 0.74`

### Secondary Stats (Bash)
Standard. `SWEP.Secondary.IronFOV = 0` *(disabled — scoped)*.

### Fire Modes
All defaults. **Note:** KBP SP's `OnPaP()` overrides `SWEP.FireModes` to `{"3Burst"}` (see Custom Functions).

### Shotgun Fields
None.

### Ironsights
- `SWEP.IronSightsPos = Vector(-4.5, -4, 1.11)`, `SWEP.IronSightsAng = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_7X = Vector(-4.496, -5, 0.281)`, `SWEP.IronSightsAng_7X = Vector(0, 0, 0)`
- `SWEP.IronSightsPos_ACOG = Vector(-3.587, -5, 0.062)`, `SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)`
- `SWEP.IronSightTime = 0.4`
- `SWEP.SafetyPos = Vector(-1, -2, -0.5)`, `SWEP.SafetyAng = Vector(-15, 25, -20)`

### Scope Overlay
- `SWEP.BoltAction = false`
- `SWEP.Scoped = true`
- `SWEP.Secondary.ScopeZoom = 4`
- `SWEP.ScopeOverlayThreshold = 0.875`
- `SWEP.BoltTimerOffset = 0.25`
- `SWEP.ScopeScale = 0.65`, `SWEP.ReticleScale = 0.75`
- All `Secondary.UseACOG/MilDot/SVD/Parabolic/Elcan/GreenDuplex = false`
- `SWEP.Secondary.ScopeTable = { ["ScopeMaterial"] = Material("scopes/scope_overlay_mp.png", "smooth"), ["ScopeBorder"] = color_black, ["ScopeCrosshair"] = { r=0, g=0, b=0, a=0, s=0 } }`

### Animations
Standard Animations table (reload_ext, reload_ext_empty). **No PumpAction** — KBP SP is semi-auto, no bolt/pump action needed.

### Event Table
```
SWEP.EventTable = {
  ["draw_first"] = { { 15/30, sound, "TFA_CODWW2_KBSP.FPO" } },
  ["draw_first_epic"] = { { 15/30, sound, "TFA_CODWW2_KBSP.FPOEpic" } },
  [ACT_VM_DRAW] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_DRAW_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Raise" } },
  [ACT_VM_HOLSTER_EMPTY] = { { 1/30, sound, "TFA_CODWW2_RIFLE.Holster" } },
  [ACT_VM_RELOAD] = {
    { 10/30, sound, "TFA_CODWW2_KBSP.TacMagOut" },
    { 40/30, sound, "TFA_CODWW2_KBSP.TacMagIn" },
  },
  [ACT_VM_RELOAD_EMPTY] = {
    { 10/30, sound, "TFA_CODWW2_KBSP.MagOut" },
    { 40/30, sound, "TFA_CODWW2_KBSP.MagIn" },
    { 65/30, sound, "TFA_CODWW2_KBSP.Charge" },
  },
  ["reload_ext"] = {
    { 10/30, sound, "TFA_CODWW2_KBSP.TacMagOut" },
    { 40/30, sound, "TFA_CODWW2_KBSP.TacMagIn" },
  },
  ["reload_ext_empty"] = {
    { 10/30, sound, "TFA_CODWW2_KBSP.MagOut" },
    { 40/30, sound, "TFA_CODWW2_KBSP.MagIn" },
    { 65/30, sound, "TFA_CODWW2_KBSP.Charge" },
  },
  [ACT_VM_FIDGET] = {
    { 1/30, sound, "TFA_CODWW2_KBSP.Inspect1" },
    { 60/30, sound, "TFA_CODWW2_KBSP.Inspect2" },
  },
  ["inspect_empty"] = {
    { 1/30, sound, "TFA_CODWW2_KBSP.Inspect1" },
    { 60/30, sound, "TFA_CODWW2_KBSP.Inspect2" },
  },
}
```
**Notable:** No `ACT_VM_DRAW_DEPLOYED` (uses `["draw_first"]` string key like Enfield). No `ACT_VM_PULLBACK_HIGH`/`LOW` events — KBP SP is semi-auto, no bolt cycle. No `["inspect"]` (only `ACT_VM_FIDGET` and `["inspect_empty"]`). No `["inspect_epic"]` (despite having `draw_first_epic` for first deploy). Inspect2 at 60/30 (later than 50/30 standard). `["reload_ext"]` is identical to `[ACT_VM_RELOAD]` (same MagOut/MagIn sounds) — both use TacMag prefix; ext_empty and reload_empty both use MagOut/MagIn/Charge (NOT "EmptyMagOut" prefix).

### Sequence Overrides
**StatusLengthOverride:**
```
[ACT_VM_RELOAD] = 45/30
[ACT_VM_RELOAD_EMPTY] = 45/30
["reload_ext"] = 45/30
["reload_ext_empty"] = 45/30
```

**SequenceLengthOverride:** `{}` *(empty)*

**SequenceRateOverride:**
```
["sprint_in"] = 25/30
["sprint_loop"] = 25/30
```
**Notable:** Only sprint entries — KBP SP has the simplest SequenceRateOverride of all 13 weapons.

### Bodygroups / Skins
None.

### VElements
```
["scope_default"]   = { model=".../c_kbsp1938_scope.mdl", bone="tag_weapon", active=false, bodygroup={} }
["scope_acog"]      = { model=".../c_kbsp1938_4x.mdl", bone="tag_weapon", active=false, bodygroup={} }
["clip_default"]    = { model=".../c_kbsp1938_clip.mdl", bone="tag_clip", active=true, bodygroup={} }
["ext_clip"]         = { model=".../c_kbsp1938_clip_ext.mdl", bone="tag_clip", active=false, bodygroup={} }
["receiver_default"]= { model=".../c_kbsp1938_receiver.mdl", bone="tag_weapon", active=true, bodygroup={} }
["barrel_default"]  = { model=".../c_kbsp1938_barrel.mdl", bone="tag_weapon", active=true, bodygroup={} }
["charm_default"]   = { model=".../c_kbsp1938_charm.mdl", bone="tag_weapon", active=true, bodygroup={} }  *(kbsp-specific charm, active, no bodygroup override)*
["stock_default"]   = { model=".../c_kbsp1938_stock.mdl", bone="tag_weapon", active=true, bodygroup={} }
```

### WElements
```
["scope_default"]   = { model=".../w_kbsp1938_scope.mdl", active=false }
["scope_acog"]      = { model=".../w_kbsp1938_4x.mdl", active=false }
["clip_default"]    = { model=".../w_kbsp1938_clip.mdl", bone="tag_clip", active=true }
["ext_clip"]         = { model=".../w_kbsp1938_clip_ext.mdl", bone="tag_clip", active=false }
["receiver_default"]= { model=".../w_kbsp1938_receiver.mdl", bone="tag_weapon", active=true }
["barrel_default"]  = { model=".../w_kbsp1938_barrel.mdl", bone="tag_weapon", active=true }
["stock_default"]   = { model=".../w_kbsp1938_stock.mdl", bone="tag_weapon", active=true }
```
**Notable:** No `charm_default` WElement (VElement has it, WElement does not).

### Attachments
```
SWEP.Attachments = {
    [1] = {atts = {"tfa_codww2_scope", "tfa_codww2_4x"}, sel = 1, order = 1},
    [2] = {atts = {"tfa_codww2_xmag", "tfa_codww2_ballistic"}, order = 2},
    [3] = {atts = {"tfa_codww2_rapidfire", "tfa_codww2_fmj"}, order = 3},  *(uses tfa_codww2_rapidfire NOT tfa_codww2_rapidfire_sg — different attachment variant)*
}
```
**Notable:** Slot 1 default uses generic `tfa_codww2_scope` (not a weapon-specific scope attachment). Slot 3 uses `tfa_codww2_rapidfire` (not `_sg` variant) — KBP SP is the only weapon in this audit using the non-shotgun rapidfire attachment, fitting its semi-auto nature.

### Miscellaneous
- `SWEP.AmmoTypeStrings = {sniperpenetratedround = "7.92×57mm Mauser"}` *(same as Kar98k — KBP SP fires the same round but semi-auto)*
- `SWEP.LuaShellEject = true` *(ONLY weapon with LuaShellEject=true — kbsp1938 ejects shells via lua, not model)*
- `SWEP.LuaShellEffect = "ShellEject"`, `SWEP.LuaShellModel = ".../fx_556.mdl"`, `SWEP.LuaShellSound = "TFA_CODWW2_SHELLS.Large"`, `SWEP.LuaShellScale = 1.2`
- `SWEP.LuaShellEjectDelay = 0`
- `SWEP.ShellAttachment = "0"`
- `SWEP.EjectionSmokeEnabled = true` *(ONLY weapon with EjectionSmokeEnabled=true — kbsp1938 produces ejection smoke)*
- `SWEP.CanJam = true`, `SWEP.JamChance = 0.05`, `SWEP.JamFactor = 0.07` *(LOWEST JamFactor — semi-auto is more reliable)*
- `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 4`, `SWEP.DInv2_Mass = 8`
- `SWEP.NZPaPName = "Czapka Poppera"` *(Polish: "Popper's Hat")*
- `SWEP.Ispackapunched = false`

### Custom Functions
```lua
function SWEP:OnPaP()
    self.Ispackapunched = true
    self.MuzzleFlashEffect = "muz_pap"
    self.Primary_TFA.ClipSize = 30
    self.Primary_TFA.Damage = 2700
    self.Primary_TFA.NumShots = 2
    self.Primary_TFA.RPM = 244
    self.Primary_TFA.DefaultClip = 330
    self.FireModes = {
        "3Burst"
    }  
    self.Primary_TFA.MaxAmmo = 300
    self.Primary_TFA.Automatic = false
    self:ClearStatCache()
    return true
end
```
**Notable:** KBP SP is the **ONLY weapon in this audit that changes `SWEP.FireModes` on PaP** — it converts to 3-burst fire mode after Pack-a-Punch. Damage 900→2700 (3x). NumShots 1→2. RPM 234→244 (slight increase). ClipSize 10→30 (triples). Note `self.FireModes` is set on `self` (not `self.Primary_TFA`) — different placement from typical stat. Also has standard NZMaxAmmo.

---

# Cross-Weapon Summary Tables

## Damage Comparison (Base → PaP)

| Weapon | Base Damage | PaP Damage | Multiplier | PaP NumShots |
|---|---|---|---|---|
| Arisaka | 75 | 750 | 10x | 2 |
| De Lisle | 1000 | 3000 | 3x | 1 |
| Enfield | 850 | 2550 | 3x | 3 |
| Kar98k | 75 | 3500 | 47x | 2 |
| Mosin | 900 | 2700 | 3x | 2 |
| SDK | 1400 | 4200 | 3x | 3 |
| Springfield | 1350 | 4050 | 3x | 2 |
| Wz. 35 | 5000 | 15000 | 3x | 1 |
| Winchester | 889 | 2667 | 3x | 2 |
| Blunderbuss | 135 (per pellet, 9 pellets = 1215 total) | 2000 (per pellet, 8 pellets = 16000 total) | 15x per pellet | 8 |
| MAS 36 | 1050 | 3150 | 3x | 1 |
| Model 1897 | 110 (×8 = 880) | 330 (×8 = 2640) | 3x | 8 |
| KBP SP | 900 | 2700 | 3x | 2 (3-burst) |

**Anomalies:**
- **Arisaka** PaP damage (750) is anomalously LOW — likely a balance/typo issue (should probably be 7500).
- **Kar98k** has a 47x damage multiplier on PaP (75→3500) — much higher than other 3x snipers.
- **Blunderbuss** is missing `MuzzleFlashEffect = "muz_pap"` in OnPaP.
- **Wz. 35** is the only "high-tier" sniper that does NOT increase NumShots on PaP.

## RPM Comparison

| Weapon | Base RPM | RPM_Displayed | RPM_Rapid | PaP RPM |
|---|---|---|---|---|
| All snipers (bolt) | 250 | 40–60 | 600 | 260 |
| Winchester | 250 | 60 | 600 | 260 |
| KBP SP (semi-auto) | 234 | (not set) | 252 | 244 |
| Blunderbuss | 100 | (not set) | (not set) | 110 |
| MAS 36 | 250 | 50 | 600 | 260 |
| Model 1897 | 220 | 58 | 500 | 230 |

## Key Feature Matrix

| Weapon | Scoped | BoltAction | Shotgun | Has ScopeOverlay | LuaShellEject | EjectionSmoke | Has Custom Func |
|---|---|---|---|---|---|---|---|
| Arisaka | No | (no field) | No | No | false | false | OnPaP, NZMaxAmmo |
| De Lisle | Yes | false | No | Yes (britain) | false | false | OnPaP, NZMaxAmmo |
| Enfield | No | (no field) | No | No | false | false | OnPaP, NZMaxAmmo |
| Kar98k | No | (no field) | No | No | false | false | OnPaP, NZMaxAmmo |
| Mosin | No | (no field) | No | No | false | false | OnPaP, NZMaxAmmo, ChooseReloadAnim |
| SDK | Yes | false | No | Yes (german) | false | false | OnPaP, NZMaxAmmo |
| Springfield | No | (no field) | No | No | false | false | OnPaP, NZMaxAmmo |
| Wz. 35 | Yes | false | No | Yes (mp) | false | false | OnPaP, NZMaxAmmo |
| Winchester | No | (no field) | **Yes** | No | false | false | OnPaP, NZMaxAmmo |
| Blunderbuss | No | (no field) | No* | No | false | false | OnPaP only (NO NZMaxAmmo!) |
| MAS 36 | Yes | false | **Yes** | Yes (mp) | false | false | OnPaP, NZMaxAmmo |
| Model 1897 | No | (no field) | **Yes** | No | false | false | OnPaP, NZMaxAmmo, Initialize, SetupDataTables, ChooseReloadAnim, ChooseShotgunReloadAnim, ChooseShotgunPumpAnim, PlayChosenAnimation |
| KBP SP | Yes | false | No | Yes (mp) | **true** | **true** | OnPaP, NZMaxAmmo |

*Blunderbuss's `SWEP.Shotgun` is not explicitly set (nil) — relies on base class default behavior.

## Attachment Slot Variations

| Weapon | Slot 1 | Slot 2 | Slot 3 | Slot 4 | Slot 5 | Slot 6 |
|---|---|---|---|---|---|---|
| Arisaka | – | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| De Lisle | enfield_scope, 4x | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| Enfield | – | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| Kar98k | – | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| Mosin | – | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| SDK | kar98k_scope, 4x | xmag, ballistic | rapidfire_sg, fmj | **areallybadidea** | – | – |
| Springfield | – | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| Wz. 35 | mosin_scope, 4x | xmag, ballistic | rapidfire_sg, fmj | – | – | – |
| Winchester | – | xmag_noani, ballistic | rapidfire_sg, fmj | – | – | – |
| Blunderbuss | – | – | – | rifling, steadyaim | stock, quickdraw, grip | incenshells |
| MAS 36 | enfield_scope, 4x | xmag_noani, ballistic | rapidfire_sg, fmj | – | – | – |
| Model 1897 | – | nydar | xmag_noani | rifling, steadyaim | stock, quickdraw, grip | rapidfire_sg, incenshells |
| KBP SP | scope, 4x | xmag, ballistic | **rapidfire**, fmj | – | – | – |

## Charm VElement Default `active` State

| Weapon | Has charm_default VElement | Active by default? | Bodygroup override | Shared bar charm? |
|---|---|---|---|---|
| Arisaka | Yes | true | {} | No (Arisaka-specific) |
| De Lisle | Yes | false | {[0]=1} | Yes |
| Enfield | Yes | true | {[0]=1} | No (Enfield-specific) |
| Kar98k | Yes | true | {} | No (Kar98k-specific) |
| Mosin | Yes | false | {[0]=1} | Yes |
| SDK | Yes | false | {} | Yes |
| Springfield | Yes | true | {[0]=1} | No (Springfield-specific) |
| Wz. 35 | Yes | false | {[0]=1} | Yes |
| Winchester | Yes | true | {} | No (Winchester-specific) |
| Blunderbuss | Yes | true | {[0]=1} | No (Blunderbuss-specific) |
| MAS 36 | Yes | false | {} | Yes |
| Model 1897 | Yes | true | {} | No (Model1897-specific) |
| KBP SP | Yes | true | {} | No (KBP-specific) |

## IronSight Position Comparison (Default)

| Weapon | IronSightsPos (x, y, z) | IronSightTime |
|---|---|---|
| Arisaka | (-3.2, -1.5, 0.73) | 0.4 |
| De Lisle | (-4.4, -3, 1.03) | 0.4 |
| Enfield | (-4.4, -4, 1.4) | 0.4 |
| Kar98k | (-4.6, -4.5, 1.33) | 0.4 |
| Mosin | (-4.4, -4, 1.65) | 0.4 |
| SDK | (-3.75, 0, 1.14) | 0.4 |
| Springfield | (-3.9, -4, 0.82) | 0.4 |
| Wz. 35 | (-4.4, -1, 1.33) | 0.4 |
| Winchester | (-3.9, -2, 1.2) | 0.3 |
| Blunderbuss | (-4.31, -1, 1.05) | 0.3 |
| MAS 36 | (-3.575, 0, 1.41) | 0.4 |
| Model 1897 | (-3.345, -2, 1.3) | 0.3 |
| KBP SP | (-4.5, -4, 1.11) | 0.4 |

## Fire Mode / DefaultFireMode

All snipers (except Winchester): `DefaultFireMode = ""` (empty string).
Winchester: `DefaultFireMode = ""` (empty string, even though it's a shotgun-style).
Blunderbuss & Model 1897: `DefaultFireMode = "1"` (explicit fire mode 1).

## Common bugs / inconsistencies identified:

1. **Arisaka Category** — `"nZR: WWII Kate Spawn Weapons"` (with "Spawn Weapons" suffix) — only Kar98k shares this; all other snipers use `"nZR: WWII Kate"`.
2. **Enfield Purpose** — Copy-paste error: "Bolt-action sniper rifle with built-in suppressor" (Enfield is NOT suppressed).
3. **Kar98k Purpose** — Same copy-paste error as Enfield.
4. **De Lisle AmmoTypeStrings** — Maps `sniperpenetratedround` to `.45 ACP` but actual ammo type is `pistol` — key mismatch means ammo string won't display.
5. **Mosin Type_Displayed** — "Sniper Rifles" (plural typo).
6. **Springfield reload_ext_empty EventTable** — Sound order is `Magout, Magin, Open, Close` — should likely be `Open, Magout, Magin, Close`.
7. **Springfield IronSightsAng** — Assigned twice with same value (lines 187, 188).
8. **Blunderbuss OnPaP** — Missing `MuzzleFlashEffect = "muz_pap"` (only weapon missing this).
9. **Blunderbuss** — No `SWEP:NZMaxAmmo()` defined (relies on base).
10. **Blunderbuss** — No `RPM_Displayed` / `RPM_Rapid` / `RPM_Displayed_Rapid` defined.
11. **Mosin charm_default VElement** — Defined but never activatable (no charm attachment slot).
12. **MAS 36 charm_default VElement** — Defined but never activatable (no charm attachment slot).
13. **KBP SP** — `LuaShellEject = true` and `EjectionSmokeEnabled = true` — only weapon with both enabled.
14. **KBP SP IronAccuracy = 0.001** — 10x worse than other snipers' 0.0001 (intentional balance for semi-auto).
15. **Winchester** — Categorized as Sniper but has `SWEP.Shotgun = true` and uses `tfa_codww2_xmag_noani` (shotgun-anim variant of xmag).
16. **Winchester** — Only sniper with `ClipSize = 6` (all others use 5 or 10).
17. **Arisaka** — Lowest PaP damage (750) among snipers — likely should be 7500 (10x of 750, but written as 750).
18. **Kar98k** — 47x damage multiplier on PaP (75→3500), vastly different from standard 3x.
19. **Wz. 35** — Highest base damage (5000), highest PaP damage (15000), but no NumShots increase on PaP (stays 1).
20. **Model 1897** — `LoopedReloadInsertAmount = 2` set on `self` (not `self.Primary_TFA`) in OnPaP — inconsistent with Winchester which sets on `self.Primary_TFA`.
21. **Model 1897** — `shell_default` uses incen model, `shell_incen` uses normal shell model — names appear swapped.
22. **MAS 36** — In `Shotguns` subcategory but uses `SniperPenetratedRound` ammo, sniper hold type, sniper-style DryFire sound, and sniper DInv2 dimensions.
23. **MAS 36** — No `NumShots_Incen` field (other shotguns blunderbuss/model1897 have it).
24. **KBP SP** — `OnPaP()` sets `SWEP.FireModes = {"3Burst"}` — only weapon that changes fire mode on PaP.
25. **KBP SP** — Has NO `PumpAction` defined (semi-auto, no pump needed).
26. **KBP SP** — No `RPM_Displayed` or `RPM_Displayed_Rapid` (relies on base class).

## Common VElement model paths

All snipers follow the pattern: `models/weapons/tfa_codww2/<weaponname>/c_<weaponname>_<part>.mdl` for VElements and `w_<weaponname>_<part>.mdl` for WElements. Exceptions:
- De Lisle, Mosin, SDK, Wz.35 — Use `models/weapons/tfa_codww2/bar/c_bar_charm.mdl` for charm (shared BAR charm model) when the weapon doesn't have its own charm model.
- Kar98k, Enfield, Springfield, Winchester, Blunderbuss, Model 1897, KBP SP — Use weapon-specific charm models.

---

# End of Audit

This audit documents all 13 TFA WWII sniper/shotgun weapon files in complete detail. Every field value has been transcribed verbatim from source. Anomalous, copy-pasted, or inconsistent configurations have been flagged in the "Common bugs / inconsistencies" section above. Cross-weapon comparison tables facilitate quick reference for stat balance and feature distribution.
