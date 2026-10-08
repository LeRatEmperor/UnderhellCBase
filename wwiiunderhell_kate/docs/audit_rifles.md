# TFA WWII Rifles — Exhaustive Code Audit

**Repository:** `/home/z/my-project/repos/tfa_wwii_original/lua/weapons/`
**Scope:** 20 files — 17 Rifles + 2 SMG-classified rifles (Arsenal, Ribeyrolles) + 2 Shotguns (M30 Drilling, Model 21)
**Base class for ALL files:** `SWEP.Base = "tfa_codww2_base"`
**Common author string:** `"Olli, Fox, Mav"`

> All values are reported verbatim from source. Comments after `--` in source
> are retained where useful. `nil` indicates the field is explicitly set to `nil`
> in source. Absence of a field means it is not declared in that weapon file
> (so the base value is inherited from `tfa_codww2_base`).
>
> Conventions used by all 20 files unless otherwise noted:
> - `SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7`
> - `SWEP.AdminSpawnable = true`
> - `SWEP.UseHands = true`
> - `SWEP.ViewModelFOV = 65`
> - `SWEP.DrawCrosshair = true`
> - `SWEP.DrawCrosshairIronSights = false`
> - `SWEP.CameraAttachmentOffsets = {}`
> - `SWEP.CameraAttachmentScale = 2`
> - `SWEP.MuzzleAttachment = "1"`
> - `SWEP.VMPos_Additive = true`
> - `SWEP.Offset.Ang = {Up=180, Right=190, Forward=0}`, `SWEP.Offset.Scale = 1.1`
> - `SWEP.IronBobMult = 0.065`, `SWEP.IronBobMultWalk = 0.065`
> - `SWEP.data = {}; SWEP.data.ironsights = 1`
> - `SWEP.IronInSound = "TFA_CODWW2_GEN.AdsUp"`, `SWEP.IronOutSound = "TFA_CODWW2_GEN.AdsDown"`
> - `SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"`
> - `SWEP.Primary.PickupSound = "TFA_CODWW2_PICKUP.Ammo"`
> - `SWEP.Primary.SoundEchoTable[0] = Sound("TFA_CODWW2_TAIL.Int")`
> - `SWEP.Primary.Sound_DryFire = "TFA_CODWW2_DRYFIRE.AR"` (or `.SG`/`.SMG`)
> - `SWEP.Primary.DryFireDelay = 0.35` (0.5 for shotguns)
> - `SWEP.DisableChambering = true`
> - `SWEP.FlashlightAttachment = 0`
> - `SWEP.LuaShellEject = true`, `SWEP.LuaShellEffect = "ShellEject"`, `SWEP.LuaShellScale = 1.0`, `SWEP.LuaShellEjectDelay = 0`, `SWEP.ShellAttachment = "0"`
> - `SWEP.EjectionSmokeEnabled = true` (false for shotguns)
> - `SWEP.CanJam = true`, `SWEP.JamChance = 0.02`, `SWEP.JamFactor = 0.035` (Rifle) / `0.06` (SMG) / `0.15` (Pump/Shotgun)
> - `SWEP.InspectPos = Vector(10, -4, -2)` (Vector(10, -7, -2) for shotguns)
> - `SWEP.InspectAng = Vector(24, 42, 16)`
> - `SWEP.SafetyAng = Vector(-15, 25, -20)` (or close variant)
> - `SWEP.TracerCount = 3` (1 for shotguns)
> - `SWEP.DInv2_GridSizeX = 2`, `SWEP.DInv2_GridSizeY = 3`, `SWEP.DInv2_Volume = nil`
> - `SWEP.AllowViewAttachment = true`
> - `SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI`
> - `SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID`
> - `SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH`
> - `SWEP.Idle_Blend = 0.25`, `SWEP.Idle_Smooth = 0.05`, `SWEP.SprintBobMult = 0`
> - `SWEP.ViewModelBoneMods = {}`
> - `SWEP.AttachmentDependencies = {}`, `SWEP.AttachmentExclusions = {}`, `SWEP.AttachmentIconOverride = {}`
> - `SWEP.ViewModelPunchPitchMultiplier = 0.4` (0.5/0.65 variants)
> - `SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09`
> - `SWEP.ViewModelPunch_MaxVertialOffset = 2` (3 for marksman/shotgun)
> - `SWEP.ViewModelPunch_MaxVertialOffset_IronSights = 1.95`
> - `SWEP.ViewModelPunch_VertialMultiplier = 0.75` (1 for marksman/shotgun)
> - `SWEP.ViewModelPunch_VertialMultiplier_IronSights = 0.25`
> - `SWEP.ViewModelPunchYawMultiplier = 0.5` (0.6 for marksman/shotgun)
> - `SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25`
> - `SWEP.ChangeStateRecoilMultiplier = 1.3`, `SWEP.JumpRecoilMultiplier = 1.3`
> - `SWEP.WallRecoilMultiplier = 1.1`
> - `SWEP.ChangeStateAccuracyMultiplier = 1.5`, `SWEP.JumpAccuracyMultiplier = 3.0`, `SWEP.WalkAccuracyMultiplier = 1.15`
> - `SWEP.Secondary.BashDamage = 35`, `SWEP.Secondary.BashDelay = 0.2`, `SWEP.Secondary.BashDamageType = DMG_CLUB`, `SWEP.Secondary.BashInterrupt = true`
> - `SWEP.Secondary.BashSound = Sound("TFA_CODWW2_MELEE.SwingRfl")` (or `.SwingSmg`)
> - `SWEP.Secondary.BashHitSound = Sound("TFA_CODWW2_MELEE.Hit")`
> - `SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_CODWW2_MELEE.HitPlr")`
> - `SWEP.Secondary.IronFOV = 70` (75 for shotguns/SMGs)
> - `SWEP.IronRecoilMultiplier = 0.65` (0.7/0.8 for shotguns)
> - `SWEP.Primary.Spread = .015` (rifles), `.02` (SMG-rifles), `.05`/`.085` (shotguns)
> - `SWEP.Primary.IronAccuracy = .005` (rifles), `.01`/`.0075` (SMG-rifles), `.05`/`.085` (shotguns)
> - `SWEP.Primary.StaticRecoilFactor = 0.5` (0.4 for shotguns/SMG-rifles)
> - `SWEP.Primary.SpreadMultiplierMax = 6` (3/5 for shotguns/SMG-rifles)
> - `SWEP.Primary.SpreadRecovery = 6` (3/5 for shotguns/SMG-rifles)
> - `SWEP.NZHeadShotMultiplier = 2`
> - `SWEP.Primary.AmmoConsumption = 1`, `SWEP.Primary.Knockback = 0`
> - `SWEP.Secondary.PickupSound = "TFA_CODWW2_PICKUP.Grenade"` (where secondary fire exists)
> - Standard Lua functions defined on every rifle: `SWEP:OnPaP()`, `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()` (where grenade launcher attachment is available)
> - All rifles set `SWEP.Ispackapunched = false` initially and toggle to `true` inside `SWEP:OnPaP()`
> - All call `self:ClearStatCache()` at end of `OnPaP()` and `return true`
> - `SWEP.Primary.RPM_Semi = nil` and `SWEP.Primary.RPM_Burst = nil` on all non-burst weapons
> - `SWEP.Primary.BurstDelay = nil`, `SWEP.BurstFireCount = nil`, `SWEP.FireModeName = nil` on non-burst weapons
> - All rifles use `SWEP.Primary.Ammo = "ar2"` except arsenal/ribey (smg1) and m30/model21 (buckshot)
> - `SWEP.Secondary.Sound = "TFA_CODWW2_RFLGRND.Shoot"` (rifle grenade shoot sound) — set on every weapon with a grenade launcher attachment

---

# RIFLES (AUTOMATIC / SEMI-AUTO)

---

## 1. AS-44 (nz_kate_codww2_as44.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Rifles"` |
| Slot | `2` |
| PrintName | `"AS-44"` |
| Manufacturer | `"Never entered production"` |
| Type_Displayed | `"Rifle"` |
| Purpose | `"This automatic rifle packs a punch in damage with some heavy recoil. If you can control the kick of this rifle, you will shred through your opposition."` |
| Author | `"Olli, Fox, Mav"` |
| ViewModel | `"models/weapons/tfa_codww2/as44/c_as44.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/as44/w_as44.mdl"` |
| ViewModelFOV | `65` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -1.5, 0)` |
| VMAng | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-5.6, Right=1, Forward=12.1` |
| Offset.Scale | `1.1` |
| NZPaPName | `"American Assembled"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_RIBEY.Sub"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_AK47.Thump"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_AK47.Crack"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_AK47.Trans"` |
| Secondary.Sound | `"TFA_CODWW2_RFLGRND.Shoot"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_AK47.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.AR"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.AR"` |
| Primary.Ammo | `"ar2"` |
| Primary.Automatic | `true` |
| Primary.RPM | `483` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `514` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `112` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `30` |
| Primary.ClipSize_Ext | `45` |
| Primary.DefaultClip | `330` |
| Primary.MaxAmmo | `300` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `false` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | `bezier=false, range_func="linear", units="meters", lut={{range=60,damage=1},{range=67,damage=0.72}}` |

### Secondary Stats (Bash)
| Field | Value |
|---|---|
| Secondary.BashDamage | `35` |
| Secondary.BashSound | `Sound("TFA_CODWW2_MELEE.SwingRfl")` |
| Secondary.BashHitSound | `Sound("TFA_CODWW2_MELEE.Hit")` |
| Secondary.BashHitSound_Flesh | `Sound("TFA_CODWW2_MELEE.HitPlr")` |
| Secondary.BashLength | `45` |
| Secondary.BashDelay | `0.2` |
| Secondary.BashDamageType | `DMG_CLUB` |
| Secondary.BashInterrupt | `true` |

### Fire Modes
| Field | Value |
|---|---|
| Primary.BurstDelay | `nil` |
| DisableBurstFire | `true` |
| SelectiveFire | `true` |
| OnlyBurstFire | `false` |
| BurstFireCount | `nil` |
| DefaultFireMode | `"1"` |
| FireModeName | `nil` |

### Ironsights
| Field | Value |
|---|---|
| IronBobMult | `0.065` |
| IronBobMultWalk | `0.065` |
| Secondary.IronFOV | `70` |
| IronSightsPos | `Vector(-3.62, -3, 1.25)` |
| IronSightsAng | `Vector(0, 0, 0)` |
| IronSightsPos_NYDAR | `Vector(-3.62, -1, 0.905)` |
| IronSightsAng_NYDAR | `Vector(0, 0, 0)` |
| IronSightsPos_ACOG | `Vector(-2.501, -5.5, 1.286)` |
| IronSightsAng_ACOG | `Vector(0, 0, 0)` |
| IronSightsPos_LENS | `Vector(-3.616, -2, 1.145)` |
| IronSightsAng_LENS | `Vector(0, 0, 0)` |
| IronSightsPos_GL | `Vector(0, 0, 0)` |
| IronSightsAng_GL | `Vector(0, 0, 0)` |
| IronSightTime | `0.35` |
| SafetyPos | `Vector(-1, -2, -0.5)` |
| SafetyAng | `Vector(-15, 25, -20)` |
| InspectPos | `Vector(10, -4, -2)` |
| InspectAng | `Vector(24, 42, 16)` |

### Spread / Recoil
| Field | Value |
|---|---|
| Primary.Spread | `.015` |
| Primary.IronAccuracy | `.005` |
| IronRecoilMultiplier | `0.65` |
| Primary.KickUp | `0.4` |
| Primary.KickDown | `0.25` |
| Primary.KickHorizontal | `0.2` |
| Primary.StaticRecoilFactor | `0.5` |
| Primary.SpreadMultiplierMax | `6` |
| Primary.SpreadIncrement | `1.2` |
| Primary.SpreadRecovery | `6` |
| ChangeStateAccuracyMultiplier | `1.5` |
| CrouchAccuracyMultiplier | `0.75` |
| JumpAccuracyMultiplier | `3.0` |
| WalkAccuracyMultiplier | `1.15` |
| ViewModelPunchPitchMultiplier | `0.4` |
| ViewModelPunchPitchMultiplier_IronSights | `0.09` |
| ViewModelPunch_MaxVertialOffset | `2` |
| ViewModelPunch_MaxVertialOffset_IronSights | `1.95` |
| ViewModelPunch_VertialMultiplier | `0.75` |
| ViewModelPunch_VertialMultiplier_IronSights | `0.25` |
| ViewModelPunchYawMultiplier | `0.5` |
| ViewModelPunchYawMultiplier_IronSights | `0.25` |
| ChangeStateRecoilMultiplier | `1.3` |
| CrouchRecoilMultiplier | `0.65` |
| JumpRecoilMultiplier | `1.3` |
| WallRecoilMultiplier | `1.1` |

### LowAmmo
| Field | Value |
|---|---|
| FireSoundAffectedByClipSize | `true` |
| LowAmmoSoundThreshold | `0.33` |
| LowAmmoSound | `"TFA.LowAmmo.AssaultRifle"` |
| LastAmmoSound | `"TFA.LowAmmo.AssaultRifle_Dry"` |

### Shells
| Field | Value |
|---|---|
| LuaShellEject | `true` |
| LuaShellEffect | `"ShellEject"` |
| LuaShellModel | `"models/entities/tfa_codww2/shells/fx_556.mdl"` |
| LuaShellSound | `"TFA_CODWW2_SHELLS.Large"` |
| LuaShellScale | `1.0` |
| LuaShellEjectDelay | `0` |
| ShellAttachment | `"0"` |
| EjectionSmokeEnabled | `true` |

### Jamming
| Field | Value |
|---|---|
| CanJam | `true` |
| JamChance | `0.02` |
| JamFactor | `0.035` |

### Misc
| Field | Value |
|---|---|
| AmmoTypeStrings | `{["ar2"] = "7.62×39mm"}` |
| FireModeSound | `"TFA_CODWW2_GEN.Switch"` |
| Primary.PickupSound | `"TFA_CODWW2_PICKUP.Ammo"` |
| Secondary.PickupSound | `"TFA_CODWW2_PICKUP.Grenade"` |
| MoveSpeed | `0.95` |
| IronSightsMoveSpeed | `SWEP.MoveSpeed * 0.8` (= 0.76) |
| TracerCount | `3` |
| DInv2_GridSizeX | `2` |
| DInv2_GridSizeY | `3` |
| DInv2_Volume | `nil` |
| DInv2_Mass | `7` |
| AllowViewAttachment | `true` |
| Sprint_Mode | `TFA.Enum.LOCOMOTION_ANI` |
| Sights_Mode | `TFA.Enum.LOCOMOTION_HYBRID` |
| Idle_Mode | `TFA.Enum.IDLE_BOTH` |
| Idle_Blend | `0.25` |
| Idle_Smooth | `0.05` |
| SprintBobMult | `0` |

### Animations Table
- `melee_bayonet`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"melee_bayonet"`
- `melee_bayonet_empty`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"melee_bayonet_empty"`
- `reload_ext`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"reload_ext"`
- `reload_ext_empty`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"reload_ext_empty"`
- `reload_grenade`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"reload_grenade"`

### SprintAnimation
- `in`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_in"`, value_empty=`"sprint_in_empty"`
- `loop`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_loop"`, value_empty=`"sprint_loop_empty"`, is_idle=`true`
- `out`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_out"`, value_empty=`"sprint_out_empty"`

### Event Table (complete)
| Key | Time | Type | Value |
|---|---|---|---|
| ACT_VM_DRAW_DEPLOYED | 10/30 | sound | `Sound("TFA_CODWW2_AS44.FPO")` |
| ACT_VM_DRAW | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| ACT_VM_DRAW_EMPTY | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| ACT_VM_HOLSTER | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| ACT_VM_HOLSTER_EMPTY | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| `fire` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `idle` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `melee` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `reload` | 10/30 | sound | `Sound("TFA_CODWW2_AS44.TacMagOut")` |
| `reload` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.TacMagIn")` |
| `reload_empty` | 10/30 | sound | `Sound("TFA_CODWW2_AS44.MagOut")` |
| `reload_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.MagIn")` |
| `reload_empty` | 60/30 | sound | `Sound("TFA_CODWW2_AS44.Charge")` |
| `inspect` | 1/30 | sound | `Sound("TFA_CODWW2_AS44.Inspect1")` |
| `inspect` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.Inspect2")` |
| `inspect_empty` | 1/30 | sound | `Sound("TFA_CODWW2_AS44.Inspect1")` |
| `inspect_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.Inspect2")` |
| `inspect_epic` | 1/30 | sound | `Sound("TFA_CODWW2_AS44.EpicInspect1")` |
| `inspect_epic` | 55/30 | sound | `Sound("TFA_CODWW2_AS44.EpicInspect2")` |
| `reload_ext` | 10/30 | sound | `Sound("TFA_CODWW2_AS44.TacMagOut")` |
| `reload_ext` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.TacMagIn")` |
| `reload_ext_empty` | 10/30 | sound | `Sound("TFA_CODWW2_AS44.MagOut")` |
| `reload_ext_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AS44.MagIn")` |
| `reload_ext_empty` | 60/30 | sound | `Sound("TFA_CODWW2_AS44.Charge")` |
| `draw_grenade` | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| `draw_grenade_empty` | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| `holster_grenade` | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| `holster_grenade_empty` | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| `grenade_in` | 1/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Foley")` |
| `grenade_in` | 5/30 | lua | `function(wep) wep:AttachGrenade() end` |
| `grenade_in` | 25/30 | sound | `Sound("TFA_CODWW2_RFLGRND.On2")` |
| `grenade_in_empty` | 1/30 | sound | `Sound("TFA_CODWW2_SML.Raise")` |
| `grenade_in_empty` | 10/30 | lua | `function(wep) wep:AttachGrenade() end` |
| `grenade_out` | 20/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Off2")` |
| `grenade_out` | 65/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `grenade_out_empty` | 1/30 | sound | `Sound("TFA_CODWW2_SML.Holster")` |
| `grenade_out_empty` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `reload_grenade` | 1/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Foley")` |
| `reload_grenade` | 25/30 | sound | `Sound("TFA_CODWW2_RFLGRND.On2")` |
| `inspect_grenade` | 1/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect1")` |
| `inspect_grenade` | 50/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect1b")` |
| `inspect_grenade` | 115/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect2")` |
| `inspect_grenade_empty` | 1/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect1")` |
| `inspect_grenade_empty` | 50/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect1b")` |
| `inspect_grenade_empty` | 115/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect2")` |

### Sequence Overrides
**StatusLengthOverride**
- `reload`: `55/30`
- `reload_empty`: `55/30`
- `reload_ext`: `55/30`
- `reload_ext_empty`: `55/30`
- `reload_grenade`: `35/30`

**SequenceLengthOverride**
- `reload`: `85/30`
- `reload_empty`: `95/30`
- `reload_ext`: `85/30`
- `reload_ext_empty`: `95/30`
- `grenade_in`: `65/30`
- `grenade_out`: `65/30`
- `grenade_in_empty`: `20/30`
- `grenade_out_empty`: `20/30`
- `reload_grenade`: `70/30`

**SequenceRateOverride**
- `sprint_in_grenade`: `20/30`
- `sprint_loop_grenade`: `25/30`
- `sprint_in_grenade_empty`: `20/30`
- `sprint_loop_grenade_empty`: `25/30`

### Bodygroups/Skins
- `SWEP.ViewModelBoneMods = {}` (empty)
- No Bodygroups_V, Bodygroups_W, ViewModelSkin, WorldModelSkin declared (inherited from base)

### VElements
| Element | Model | Bone | rel | pos | angle | size | color | surpresslightning | material | skin | bonemerge | active | bodygroup |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| sight_nydar | `models/weapons/tfa_codww2/as44/c_as44_reflex.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| sight_nydar_lens | Conditional via `TFA.CODWW2.GetHoloSightReticle("sight_nydar")` else nil | — | — | — | — | — | — | — | — | — | — | — | — |
| scope_acog | `models/weapons/tfa_codww2/as44/c_as44_4x.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| lens_sight | `models/weapons/tfa_codww2/attachments/sights/c_lens_sight.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| clip_default | `models/weapons/tfa_codww2/as44/c_as44_clip.mdl` | tag_clip | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `true` | `{}` |
| ext_clip | `models/weapons/tfa_codww2/as44/c_as44_clip_ext.mdl` | tag_clip | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| sight_default | `models/weapons/tfa_codww2/as44/c_as44_sight.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `true` | `{}` |
| grenade_rail | `models/weapons/tfa_codww2/attachments/usa_rifle_grenade/c_rifle_grenade.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| bayonet | `models/weapons/tfa_codww2/attachments/bayonet/c_usa_bayonet.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{}` |
| charm_default | `models/weapons/tfa_codww2/mp40/c_mp40_charm.mdl` | tag_weapon | `""` | `Vector(0,0,0)` | `Angle(0,0,0)` | `Vector(1,1,1)` | `Color(255,255,255,255)` | `false` | `""` | `0` | `true` | `false` | `{[0] = 1}` |

### WElements
| Element | Model | Bone | rel | active | bodygroup |
|---|---|---|---|---|---|
| clip_default | `models/weapons/tfa_codww2/as44/w_as44_clip.mdl` | tag_clip | `""` | `true` | `{}` |
| ext_clip | `models/weapons/tfa_codww2/as44/w_as44_clip_ext.mdl` | tag_clip | `""` | `false` | `{}` |
| sight_default | `models/weapons/tfa_codww2/as44/w_as44_sight.mdl` | tag_weapon | `""` | `true` | `{}` |
| sight_nydar | `models/weapons/tfa_codww2/as44/w_as44_reflex.mdl` | tag_weapon | `""` | `false` | `{}` |
| scope_acog | `models/weapons/tfa_codww2/as44/w_as44_4x.mdl` | tag_weapon | `""` | `false` | `{}` |
| grenade_rail | `models/weapons/tfa_codww2/attachments/usa_rifle_grenade/w_rifle_grenade.mdl` | tag_weapon | `""` | `false` | `{}` |
| bayonet | `models/weapons/tfa_codww2/attachments/bayonet/w_usa_bayonet.mdl` | tag_weapon | `""` | `false` | `{}` |

(All WElements have type=`"Model"`, pos=`Vector(0,0,0)`, angle=`Angle(0,0,0)`, size=`Vector(1,1,1)`, color=`Color(255,255,255,255)`, surpresslightning=`false`, material=`""`, skin=`0`, bonemerge=`true`)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- **`SWEP:OnPaP()`** — Sets `Ispackapunched = true`, `MuzzleFlashEffect = "muz_pap"`, `Primary_TFA.ClipSize = 45`, `Primary_TFA.Damage = 336`, `Primary_TFA.NumShots = 1`, `Primary_TFA.RPM = 493`, `Primary_TFA.DefaultClip = 495`, `Primary_TFA.MaxAmmo = 450`, `Primary_TFA.Automatic = true`; calls `self:ClearStatCache()`; returns `true`.
- **`SWEP:NZMaxAmmo()`** — Server-only: sets owner ammo to `self.Primary.MaxAmmo`, sets clip to `self.Primary.ClipSize`.
- **`SWEP:AttachGrenade()`** — `self.Bodygroups_V[1] = 1`
- **`SWEP:DetachGrenade()`** — `self.Bodygroups_V[1] = 0`

---

## 2. AVS-36 (nz_kate_codww2_avs36.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Rifles"` |
| Slot | `2` |
| PrintName | `"AVS-36"` |
| Manufacturer | `"IZhMASh"` |
| Type_Displayed | `"Rifle"` |
| Purpose | `"Automatic rifle with high damage, medium fire rate and moderate recoil."` |
| ViewModel | `"models/weapons/tfa_codww2/avs36/c_avs36.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/avs36/w_avs36.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-4.95, Right=1, Forward=16.9` |
| NZPaPName | `"Vodka Raider"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_AVS.Trans"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_GEWEHR.Shot"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_AVS.Lyr2"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_FG42.Lyr3"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_MECH.Belt_Feed"` |
| Secondary.Sound | `"TFA_CODWW2_RFLGRND.Shoot"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_FG42.Ext.Mp")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.AR"` |
| Primary.Ammo | `"ar2"` |
| Primary.Automatic | `true` |
| Primary.RPM | `441` |
| Primary.RPM_Rapid | `472` |
| Primary.Damage | `185` |
| Primary.NumShots | `1` |
| Primary.ClipSize | `24` |
| Primary.ClipSize_Ext | `36` |
| Primary.DefaultClip | `264` |
| Primary.MaxAmmo | `240` |
| Primary.DryFireDelay | `0.35` |
| FiresUnderwater | `false` |
| Primary.RangeFalloffLUT | `bezier=false, linear, meters, lut={{range=45,damage=1},{range=50,damage=0.75}}` |

### Ironsights
| Field | Value |
|---|---|
| IronSightsPos | `Vector(-3.5, -4, 1.05)` |
| IronSightsAng | `Vector(0.45, 0, 0)` |
| IronSightsPos_NYDAR | `Vector(-3.52, -1, 0.6)` |
| IronSightsAng_NYDAR | `Vector(0.5, -0.05, 0)` |
| IronSightsPos_ACOG | `Vector(-2.3735, -5, 0.7395)` |
| IronSightsPos_LENS | `Vector(-3.5, -4.5, 1.05)` |
| IronSightTime | `0.35` |
| Secondary.IronFOV | `70` |

### Spread / Recoil
| Field | Value |
|---|---|
| Primary.Spread | `.015` |
| Primary.IronAccuracy | `.005` |
| Primary.KickUp | `0.32` |
| Primary.KickDown | `0.3` |
| Primary.KickHorizontal | `0.12` |
| Primary.StaticRecoilFactor | `0.5` |
| Primary.SpreadMultiplierMax | `6` |
| Primary.SpreadIncrement | `1.5` |
| Primary.SpreadRecovery | `6` |
| CrouchRecoilMultiplier | `0.65` |

### Fire Modes
- `Primary.BurstDelay = nil`, `DisableBurstFire = true`, `SelectiveFire = true`, `OnlyBurstFire = false`, `BurstFireCount = nil`, `DefaultFireMode = "1"`, `FireModeName = nil`

### Misc
- AmmoTypeStrings: `{["ar2"] = "7.62×54mmR"}`
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- Jamming: CanJam=true, JamChance=0.02, JamFactor=0.035
- DInv2_Mass: `7`

### Animations Table
- `melee_bayonet`, `melee_bayonet_empty`, `reload_ext`, `reload_ext_empty`, `reload_grenade` (all `TFA.Enum.ANIMATION_SEQ`)

### SprintAnimation
- `in`/`loop`/`out` with value_empty variants (`sprint_in_empty`, `sprint_loop_empty`, `sprint_out_empty`)

### Event Table (complete)
| Key | Time | Type | Value |
|---|---|---|---|
| ACT_VM_DRAW_DEPLOYED | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| ACT_VM_DRAW_DEPLOYED | 35/30 | sound | `Sound("TFA_CODWW2_AVS.FPO")` |
| ACT_VM_DRAW | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| ACT_VM_DRAW_EMPTY | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| ACT_VM_HOLSTER | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| ACT_VM_HOLSTER_EMPTY | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| `fire` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `idle` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `melee` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `reload` | 10/30 | sound | `Sound("TFA_CODWW2_AVS.TacMagOut")` |
| `reload` | 35/30 | sound | `Sound("TFA_CODWW2_AVS.TacMagIn")` |
| `reload_empty` | 15/30 | sound | `Sound("TFA_CODWW2_AVS.MagOut")` |
| `reload_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AVS.MagIn")` |
| `reload_empty` | 65/30 | sound | `Sound("TFA_CODWW2_AVS.Charge")` |
| `inspect` | 1/30 | sound | `Sound("TFA_CODWW2_AVS.Inspect1")` |
| `inspect` | 45/30 | sound | `Sound("TFA_CODWW2_AVS.Inspect2")` |
| `inspect_empty` | 1/30 | sound | `Sound("TFA_CODWW2_AVS.Inspect1")` |
| `inspect_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AVS.Inspect2")` |
| `inspect_epic` | 1/30 | sound | `Sound("TFA_CODWW2_AVS.EpicInspect1")` |
| `inspect_epic` | 40/30 | sound | `Sound("TFA_CODWW2_AVS.EpicInspect2")` |
| `reload_ext` | 10/30 | sound | `Sound("TFA_CODWW2_AVS.TacMagOut")` |
| `reload_ext` | 35/30 | sound | `Sound("TFA_CODWW2_AVS.TacMagIn")` |
| `reload_ext_empty` | 15/30 | sound | `Sound("TFA_CODWW2_AVS.MagOut")` |
| `reload_ext_empty` | 45/30 | sound | `Sound("TFA_CODWW2_AVS.MagIn")` |
| `reload_ext_empty` | 65/30 | sound | `Sound("TFA_CODWW2_AVS.Charge")` |
| `draw_grenade`/`draw_grenade_empty` | 1/30 | sound | `Sound("TFA_CODWW2_RIFLE.Raise")` |
| `holster_grenade`/`holster_grenade_empty` | 2/30 | sound | `Sound("TFA_CODWW2_RIFLE.Holster")` |
| `grenade_in` | 1/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Foley")` |
| `grenade_in` | 5/30 | lua | `function(wep) wep:AttachGrenade() end` |
| `grenade_in` | 25/30 | sound | `Sound("TFA_CODWW2_RFLGRND.On2")` |
| `grenade_in_empty` | 1/30 | sound | `Sound("TFA_CODWW2_SML.Raise")` |
| `grenade_in_empty` | 10/30 | lua | `function(wep) wep:AttachGrenade() end` |
| `grenade_out` | 20/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Off2")` |
| `grenade_out` | 65/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `grenade_out_empty` | 1/30 | sound | `Sound("TFA_CODWW2_SML.Holster")` |
| `grenade_out_empty` | 1/30 | lua | `function(wep) wep:DetachGrenade() end` |
| `reload_grenade` | 1/30 | sound | `Sound("TFA_CODWW2_RFLGRND.Foley")` |
| `reload_grenade` | 25/30 | sound | `Sound("TFA_CODWW2_RFLGRND.On2")` |
| `inspect_grenade` / `inspect_grenade_empty` | 1/30, 50/30, 115/30 | sound | `Sound("TFA_CODWW2_STG44.Inspect1")`, `Sound("TFA_CODWW2_STG44.Inspect1b")`, `Sound("TFA_CODWW2_STG44.Inspect2")` |

### Sequence Overrides
**StatusLengthOverride**: `reload`/`reload_empty`/`reload_ext`/`reload_ext_empty` = `45/30`, `50/30`, `45/30`, `50/30`; `reload_grenade` = `35/30`

**SequenceLengthOverride**: `grenade_in=65/30`, `grenade_out=65/30`, `grenade_in_empty=20/30`, `grenade_out_empty=20/30`, `reload_grenade=70/30`

**SequenceRateOverride**: `sprint_in=25/30`, `sprint_in_grenade=20/30`, `sprint_loop_grenade=25/30`, `sprint_in_grenade_empty=20/30`, `sprint_loop_grenade_empty=25/30`, `holster_grenade=15/30`, `holster_grenade_empty=15/30`

### VElements (10 elements)
- `sight_nydar` → `c_avs36_reflex.mdl`
- `sight_nydar_lens` → conditional `TFA.CODWW2.GetHoloSightReticle("sight_nydar")`
- `scope_acog` → `c_avs36_4x.mdl`
- `lens_sight` → shared `c_lens_sight.mdl`
- `clip_default` → `c_avs36_clip.mdl` (active=true)
- `ext_clip` → `c_avs36_clip_ext.mdl`
- `sight_default` → `c_avs36_sight.mdl` (active=true)
- `grenade_rail` → `usa_rifle_grenade/c_rifle_grenade.mdl`
- `bayonet` → `bayonet/c_usa_bayonet.mdl`
- `charm_default` → `bar/c_bar_charm.mdl` (bodygroup={[0]=1})

### WElements (7 elements)
- `clip_default` (active=true), `ext_clip`, `sight_default` (active=true), `sight_nydar`, `scope_acog`, `grenade_rail`, `bayonet`

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=555, NumShots=1, RPM=451, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 3. BAR (nz_kate_codww2_bar.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"BAR"` |
| Manufacturer | `"Colt"` |
| Type_Displayed | `"Rifle"` |
| Purpose | `"Automatic rifle with moderate recoil and fast fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/bar/c_bar.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/bar/w_bar.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-4.95, Right=1, Forward=16.9` |
| NZPaPName | `"RE-BAR"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_BAR.Blast"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_BAR.Lyr1"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_BAR.Lyr2"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_BAR.Ext.Mp")}` |
| Primary.RPM | `571` |
| Primary.RPM_Rapid | `612` |
| Primary.Damage | `130` |
| Primary.ClipSize | `20` |
| Primary.ClipSize_Ext | `30` |
| Primary.DefaultClip | `220` |
| Primary.MaxAmmo | `200` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1.0},{range=55,damage=0.74}}` |

### Ironsights
- IronSightsPos: `Vector(-3.365, -2, 1)`
- IronSightsPos_NYDAR: `Vector(-3.37, -1, 0.26)`
- IronSightsPos_ACOG: `Vector(-3.373, -1, 0.107)`
- IronSightsPos_LENS: `Vector(-3.368, -1, 0.995)`
- IronSightTime: `0.35`
- Secondary.IronFOV: `70`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.35`, KickHorizontal: `0.2`
- SpreadIncrement: `1.25`
- StaticRecoilFactor: `0.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true, DefaultFireMode="1"

### Animations
- `melee_bayonet`, `reload_ext`, `reload_ext_empty`, `reload_grenade` (no `melee_bayonet_empty`)

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 1/30 `Sound("TFA_CODWW2_BAR.FPOFoley")`, 10/30 `Sound("TFA_CODWW2_BAR.FPO")`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` all have lua `function(wep) wep:DetachGrenade() end`
- `reload`: 1/30 `TacMagOutFoley`, 1/30 `TacMagOut`, 20/30 `TacMagInFoley`, 30/30 `TacMagIn`
- `reload_empty`: 1/30 `MagOutFoley`, 10/30 `MagOut`, 30/30 `MagIn`, 40/30 `ChargeFoley`, 45/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 60/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 50/30 `EpicInspect2`
- `reload_ext`, `reload_ext_empty` mirror the patterns above
- Grenade launcher events with `AttachGrenade()` / `DetachGrenade()` lua functions

### Sequence Overrides
**StatusLengthOverride**: reload=40/30, reload_empty=40/30, reload_ext=40/30, reload_ext_empty=40/30, reload_grenade=35/30

**SequenceLengthOverride**: reload=65/30, reload_empty=85/30, reload_ext=65/30, reload_ext_empty=85/30, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30

**SequenceRateOverride**: sprint_in=25/30, sprint_loop=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (14 elements)
- sight_nydar → c_bar_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_bar_4x.mdl
- lens_sight → shared
- clip_default → c_bar_clip.mdl (active=true)
- ext_clip → c_bar_clip_ext.mdl
- receiver_default → c_bar_receiver.mdl (active=true)
- barrel_default → c_bar_barrel.mdl (active=true)
- charm_default → c_bar_charm.mdl (active=true)
- sight_default → c_bar_sight.mdl (active=true)
- rail_sights → c_bar_rail_sight.mdl (active=false)
- stock_default → c_bar_stock.mdl (active=true)
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl

### WElements (10 elements)
- clip_default (active), ext_clip, receiver_default (active), barrel_default (active), sight_default (active), stock_default (active), sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=45, Damage=390, NumShots=1, RPM=581, DefaultClip=495, MaxAmmo=450, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 4. Charlton / NZ-41 (nz_kate_codww2_charlton.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"NZ-41"` |
| Manufacturer | `"Charlton Motor Workshops"` |
| Purpose | `"Automatic rifle with high damage, slow fire rate and low recoil."` |
| ViewModel | `"models/weapons/tfa_codww2/charlton/c_charlton.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/charlton/w_charlton.mdl"` |
| HoldType | `"ar2"` |
| NZPaPName | `"nZ+?"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_NZ41.Center1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_NZ41.Center2"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_VMG27.Lfe"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_NZ41.Wide"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_NZ41.Ext")` |
| Primary.RPM | `400` |
| Primary.RPM_Rapid | `425` |
| Primary.Damage | `170` |
| Primary.ClipSize | `24` |
| Primary.ClipSize_Ext | `36` |
| Primary.DefaultClip | `264` |
| Primary.MaxAmmo | `240` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.667}}` |

### Ironsights
- IronSightsPos: `Vector(-4.42, -3, 1.35)`
- IronSightsPos_NYDAR: `Vector(-4.42, -5, 1.095)`
- IronSightsPos_ACOG: `Vector(-5.945, -4, 0.891)`
- IronSightsPos_LENS: `Vector(-4.415, -3, 1.366)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.25`, KickHorizontal: `0.3`
- SpreadIncrement: `1.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `reload_ext`, `reload_ext_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 15/30 `Sound("TFA_CODWW2_NZ41.FPO")`
- `fire`, `idle`, `melee` all have `function(wep) wep:DetachGrenade() end`
- `reload`: 20/30 `TacMagOut`, 50/30 `TacMagIn`
- `reload_empty`: 20/30 `MagOut`, 50/30 `MagIn`, 75/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 55/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 70/30 `EpicInspect2`
- `reload_ext`: 20/30 `ExtTacMagOut`, 50/30 `ExtTacMagIn`
- `reload_ext_empty`: 20/30 `ExtMagOut`, 50/30 `ExtMagIn`, 75/30 `ExtCharge`
- Grenade launcher events with `AttachGrenade()` / `DetachGrenade()`

### Sequence Overrides
- StatusLengthOverride: reload=65/30, reload_empty=65/30, reload_ext=65/30, reload_ext_empty=65/30, reload_grenade=35/30
- SequenceLengthOverride: grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (10 elements)
- sight_nydar → c_charlton_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_charlton_4x.mdl
- lens_sight → shared
- clip_default → c_charlton_clip.mdl (active=true)
- ext_clip → c_charlton_clip_ext.mdl
- sight_default → c_charlton_sight.mdl (active=true)
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl
- charm_default → bar/c_bar_charm.mdl (no bodygroup)

### WElements (7 elements)
- clip_default, ext_clip, sight_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=48, Damage=510, NumShots=2, RPM=410, DefaultClip=528, MaxAmmo=480, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 5. Federov / Automaton (nz_kate_codww2_federov.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Automaton"` |
| Manufacturer | `"Kovrov Arms Factory"` |
| Purpose | `"Automatic rifle with steady fire rate and is deadly at mid to long range engagements."` |
| ViewModel | `"models/weapons/tfa_codww2/federov/c_federov.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/federov/w_federov.mdl"` |
| HoldType | `"smg"` (NOTE: only rifle using `"smg"` holdtype) |
| VMPos | `Vector(0, -1, 0)` |
| Offset.Pos | `Up=-4.95, Right=2, Forward=12.9` |
| NZPaPName | `"Federal Offence"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_RIBEY.Sub"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_FDRV.Stereo"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_FDRV.Center"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_FDRV.High"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_RIBEY.Trans"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_FDRV.Ext")` |
| Primary.RPM | `472` |
| Primary.RPM_Rapid | `502` |
| Primary.Damage | `125` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `37` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.85}}` |

### Ironsights
- IronSightsPos: `Vector(-4.445, -2, 1.85)`
- IronSightsAng: `Vector(-0.15, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-4.42, -2, 1.24)`
- IronSightsPos_ACOG: `Vector(-3.291, -5.5, 1.096)`
- IronSightsPos_LENS: `Vector(-4.445, -4, 1.88)`
- **IronhSightsAng_GL** (typo in source!): `Vector(0, 0, 0)` — note misspelling "IronhSights"

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.35`, KickDown: `0.25`, KickHorizontal: `0.2`
- SpreadIncrement: `1.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `reload_grenade` (only — no melee_bayonet_empty, no reload_ext)

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 10/30 `Sound("TFA_CODWW2_FDRV.FPO")`
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 15/30 `TacMagOut`, 40/30 `TacMagIn`
- `reload_empty`: 15/30 `MagOut`, 40/30 `MagIn`, 65/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 100/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 90/30 `EpicInspect2`
- Grenade launcher events with `AttachGrenade()` / `DetachGrenade()`

### Sequence Overrides
- StatusLengthOverride: reload=45/30, reload_empty=45/30, reload_grenade=35/30
- SequenceLengthOverride: grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: holster_grenade=15/30, holster_grenade_empty=15/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (10 elements)
- sight_nydar → c_federov_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_federov_4x.mdl
- lens_sight → shared
- clip_default → c_federov_clip.mdl (active=true)
- ext_clip → c_federov_clip_ext.mdl
- sight_default → c_federov_sight.mdl (active=true)
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl
- charm_default → bar/c_bar_charm.mdl (bodygroup={[0]=1})

### WElements (7 elements)
- clip_default, ext_clip, sight_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=375, NumShots=2, RPM=482, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 6. FG 42 (nz_kate_codww2_fg42.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"FG 42"` |
| Manufacturer | `"Heinrich Krieghoff & Rheinmetall"` |
| Purpose | `"Automatic rifle with high damage and modest fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/fg42/c_fg42.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/fg42/w_fg42.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-3.95, Right=1, Forward=13.9` |
| NZPaPName | `"Feral Growl 84"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_FG42.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_FG42.Lyr2"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_FG42.Lyr3"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_FG42.Ext.Mp")` |
| Primary.RPM | `422` |
| Primary.RPM_Rapid | `451` |
| Primary.Damage | `180` |
| Primary.ClipSize | `20` |
| Primary.ClipSize_Ext | `30` |
| Primary.DefaultClip | `220` |
| Primary.MaxAmmo | `200` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1.0},{range=55,damage=0.75}}` |

### Ironsights
- IronSightsPos: `Vector(-3.47, -4, 0.37)`
- IronSightsPos_NYDAR: `Vector(-3.47, -3, 0.484)`
- IronSightsPos_ACOG: `Vector(-3.153, -6.5, 0.671)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.25`, KickHorizontal: `0.25`
- SpreadIncrement: `1.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_ext`, `reload_ext_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 1/30 `FG42.FPOFoley`, 5/30 `FG42.FPO`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 10/30 `TacMagOutFoley`, 10/30 `TacMagOut`, 25/30 `TacMagGrabFoley`, 25/30 `TacMagGrab`, 40/30 `TacMagInFoley`, 40/30 `TacMagIn`
- `reload_empty`: 10/30 `MagOutFoley`, 10/30 `MagOut`, 35/30 `MagGrabFoley`, 35/30 `MagGrab`, 50/30 `MagInFoley`, 55/30 `MagIn`, 70/30 `Charge`, 70/30 `ChargeFoley`
- `inspect`: 1/30 `Inspect1`, 60/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 30/30 `EpicInspect2`
- `reload_ext` / `reload_ext_empty` similar with `TacMagIn` at 40/30 vs 45/30 timings
- Grenade launcher events with `On` / `Off` (not On2/Off2 — German variant uses different sounds)

### Sequence Overrides
- StatusLengthOverride: reload=45/30, reload_empty=60/30, reload_ext=45/30, reload_ext_empty=60/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=40/30**, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (12 elements)
- sight_nydar → c_fg42_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_fg42_4x.mdl
- clip_default → c_fg42_clip.mdl (active=true)
- ext_clip → c_fg42_clip_ext.mdl
- receiver_default → c_fg42_receiver.mdl (active=true)
- barrel_default → c_fg42_barrel.mdl (active=true)
- charm_default → c_fg42_charm.mdl (active=true)
- sight_default → c_fg42_sight.mdl (active=true)
- stock_default → c_fg42_stock.mdl (active=true)
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl** (German)
- bayonet → **bayonet/c_ger_bayonet.mdl** (German)

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_nydar`, `tfa_codww2_4x` (NOTE: no lens_sight!) | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=540, NumShots=1, RPM=452, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 7. Gewehr 43 (nz_kate_codww2_gewehr43.lua)

### Core Fields
| Field | Value |
|---|---|
| Category | `"nZR: WWII Kate Spawn Weapons"` (NOTE: Spawn Weapons category!) |
| PrintName | `"Gewehr 43"` |
| Manufacturer | `"Walther"` |
| Purpose | `"Fastest semi-automatic rifle in class with low recoil. Can take out enemies in three shots."` |
| ViewModel | `"models/weapons/tfa_codww2/gewehr43/c_gewehr43.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/gewehr43/w_gewehr43.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -1.5, 0)` |
| Offset.Pos | `Up=-5, Right=1, Forward=13.7` |
| NZPaPName | `"Graham Crackers"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1GRND.Low.Lyr"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_GEWEHR.Body"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_GEWEHR.High"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_TRANS.CP.B"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_GEWEHR.Ext")` |
| Primary.Automatic | `false` (SEMI-AUTO) |
| Primary.RPM | `517` |
| Primary.RPM_Rapid | `550` |
| Primary.Damage | `40` |
| Primary.ClipSize | `12` |
| Primary.ClipSize_Ext | `18` |
| Primary.DefaultClip | `132` |
| Primary.MaxAmmo | `120` |
| Primary.RangeFalloffLUT | `lut={{range=30,damage=1},{range=35,damage=0.87}}` |

### Ironsights
- IronSightsPos: `Vector(-3.9, -5, 1.05)`
- IronSightsPos_NYDAR: `Vector(-3.9, -2, 0.28)`
- IronSightsPos_ACOG: `Vector(-4.4545, -2, 0.8255)`
- IronSightsPos_LENS: `Vector(-3.896, -5, 1.027)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.3`, KickHorizontal: `0.25`
- SpreadIncrement: `1.5`, SpreadRecovery: `5.5` (different from default 6)

### Fire Modes
- DisableBurstFire=true, SelectiveFire=**false** (semi-only), DefaultFireMode=`""`

### LowAmmo
- LowAmmoSound: `"TFA.LowAmmo.AssaultRifle"`
- LastAmmoSound: `"TFA_CODWW2_GEWEHR.Mech"` (different — not the _Dry sound)

### Misc
- RegularMoveSpeedMultiplier: `0.95` (NOT MoveSpeed — uses different field name!)
- AimingDownSightsSpeedMultiplier: `SWEP.RegularMoveSpeedMultiplier * 0.8` (= 0.76)
- AmmoTypeStrings: `{["ar2"] = "7.92×57mm Mauser"}`

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_ext`, `reload_ext_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 1/30 `Sound("TFA_CODWW2_GEWEHR.FPO")`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 10/30 `TacMagOut`, 40/30 `TacMagIn`
- `reload_empty`: 10/30 `MagOut`, 40/30 `MagIn`, 65/30 `Charge`
- `inspect`/`inspect_empty`: 1/30 `Inspect1`, 50/30 `Inspect2` (no inspect_epic!)
- `reload_ext`/`reload_ext_empty` mirror reload/reload_empty (no separate ext sounds)
- Grenade launcher events (German): `RFLGRND.On` / `RFLGRND.Off` (NOT On2/Off2)

### Sequence Overrides
- StatusLengthOverride: reload=50/30, reload_empty=50/30, reload_ext=50/30, reload_ext_empty=50/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=50/30**, reload=75/30, reload_empty=90/30, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=20/30, sprint_loop=25/30, sprint_out=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (13 elements)
- sight_nydar → c_gewehr43_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_gewehr43_4x.mdl
- lens_sight → shared
- clip_default → c_gewehr43_clip.mdl (active=true)
- ext_clip → c_gewehr43_clip_ext.mdl
- receiver_default → c_gewehr43_receiver.mdl (active=true)
- barrel_default → c_gewehr43_barrel.mdl (active=true)
- charm_default → c_gewehr43_charm.mdl (active=true, bodygroup={[0]=1})
- sight_defaults (note plural "sight_defaults") → c_gewehr43_sight.mdl (active=true)
- stock_default → c_gewehr43_stock.mdl (active=true)
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl**
- bayonet → **bayonet/c_ger_bayonet.mdl**

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_defaults (plural), stock_default, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=25, Damage=120, NumShots=2, RPM=527, DefaultClip=275, MaxAmmo=250, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 8. M1 Carbine (nz_kate_codww2_m1a1.lua)

### Core Fields
| Field | Value |
|---|---|
| Category | `"nZR: WWII Kate Spawn Weapons"` |
| PrintName | `"M1 Carbine"` |
| Manufacturer | `"General Motors"` |
| Purpose | `"Semi-automatic rifle that fires quickly with low recoil. Can take out enemies in three shots."` |
| ViewModel | `"models/weapons/tfa_codww2/m1a1/c_m1a1.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m1a1/w_m1a1.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-5.95, Right=1, Forward=14` |
| NZPaPName | `"Infantry Division"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1CARB.Tail05"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1CARB.Shot"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_M1CARB.Low"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_M1CARB.Ping"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_M1CARB.Ext.Mp")` |
| Primary.Automatic | `false` (SEMI-AUTO) |
| Primary.RPM | `454` |
| Primary.RPM_Rapid | `483` |
| Primary.Damage | `50` |
| Primary.ClipSize | `15` |
| Primary.ClipSize_Ext | `22` |
| Primary.DefaultClip | `165` |
| Primary.MaxAmmo | `150` |
| Primary.RangeFalloffLUT | `lut={{range=30,damage=1},{range=35,damage=0.88},{range=50,damage=0.88},{range=55,damage=0.75}}` (4-point LUT) |

### Ironsights
- IronSightsPos: `Vector(-3.9, -3, 0.97)`
- IronSightsAng: `Vector(0.1, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.9, -2, 0.66)`
- IronSightsPos_ACOG: `Vector(-2.78, -4, 0.42)`
- IronSightsPos_LENS: `Vector(-3.897, -1, 0.966)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.35`, KickHorizontal: `0.1`
- SpreadIncrement: `1.5`, SpreadRecovery: `5.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=**false** (semi-only), DefaultFireMode=`""`

### LowAmmo
- LowAmmoSound: `"TFA.LowAmmo.AssaultRifle"`
- LastAmmoSound: `"TFA_CODWW2_M1CARB.LastShot"` (unique)

### Misc
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- AmmoTypeStrings: `{["ar2"] = ".30 Carbine"}`

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_grenade`

### Event Table (notable)
- `draw_first`: 1/30 `M1CARB.FPOFoley`, 15/30 `M1CARB.FPO`
- `draw_first_epic`: 1/30 `M1CARB.FPOFoley`, 10/30 `M1CARB.FPOEpic`
- `ACT_VM_DRAW`/`ACT_VM_DRAW_EMPTY`: 1/30 `RIFLE.Raise`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 1/30 `TacStart`, 15/30 `TacMagOut`, 38/30 `TacMagIn`
- `reload_empty`: 1/30 `TacStart`, 15/30 `MagOut`, 38/30 `MagIn`, 70/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 55/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 45/30 `EpicInspect2`
- Grenade launcher events with `On2`/`Off2`

### Sequence Overrides
- StatusLengthOverride: reload=45/30, reload_empty=45/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=40/30**, reload=65/30, reload_empty=95/30, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, holster_grenade=15/30, holster_grenade_empty=15/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (13 elements)
- sight_nydar → c_m1a1_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_m1a1_4x.mdl
- lens_sight → shared
- clip_default → c_m1a1_clip.mdl (active=true)
- ext_clip → c_m1a1_clip_ext.mdl
- receiver_default → c_m1a1_receiver.mdl (active=true)
- barrel_default → c_m1a1_barrel.mdl (active=true)
- charm_default → c_m1a1_charm.mdl (active=true, bodygroup={[0]=1})
- sight_default → c_m1a1_sight.mdl (active=true)
- stock_default → c_m1a1_stock.mdl (active=true)
- rail_sights → c_m1a1_front_sight.mdl
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=24, Damage=150, NumShots=2, RPM=464, DefaultClip=264, MaxAmmo=240, **FireModes = { "3Burst" }**, Automatic=true (adds 3-burst fire mode on PaP)
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 9. M1 Garand (nz_kate_codww2_m1garand.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"M1 Garand"` |
| Manufacturer | `"Springfield Armory"` |
| Purpose | `"Semi-auto marksman rifle. Delivers high damage that can take out enemies in two shots."` |
| ViewModel | `"models/weapons/tfa_codww2/m1garand/c_m1garand.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m1garand/w_m1garand.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -1, 0)` |
| Offset.Pos | `Up=-5.6, Right=1, Forward=14` |
| NZPaPName | `"All American"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1GRND.Snap"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1GRND.Mid"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_M1GRND.Low.Lyr"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_M1GRND.Sub"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_M1GRND.Ext")` |
| Primary.Automatic | `false` (SEMI-AUTO) |
| Primary.RPM | `525` |
| Primary.RPM_Rapid | `346` (lower than RPM — unique!) |
| Primary.Damage | `165` |
| Primary.ClipSize | `8` (en-bloc clip) |
| Primary.ClipSize_Ext | `12` |
| Primary.DefaultClip | `88` |
| Primary.MaxAmmo | `80` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.92},{range=75,damage=0.92},{range=80,damage=0.75}}` (4-point LUT with plateau) |

### Ironsights
- IronSightsPos: `Vector(-4.45, -2.5, 0.85)`
- IronSightsPos_NYDAR: `Vector(-4.456, -2, 0.36)`
- IronSightsPos_ACOG: `Vector(-3.204, -4, 0.415)`
- IronSightTime: `0.35`

### Spread / Recoil (marksman-style)
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.5`, KickDown: `0.35`, KickHorizontal: `0.15`
- SpreadIncrement: `1.75`, SpreadRecovery: `5`
- ViewModelPunchPitchMultiplier: `0.5` (vs 0.4 standard)
- ViewModelPunch_MaxVertialOffset: `3` (vs 2 standard)
- ViewModelPunch_VertialMultiplier: `1` (vs 0.75 standard)
- ViewModelPunchYawMultiplier: `0.6` (vs 0.5 standard)

### Fire Modes
- DisableBurstFire=true, SelectiveFire=**false** (semi-only), DefaultFireMode=`""`

### LowAmmo
- LowAmmoSound: `""` (empty)
- LastAmmoSound: `""` (empty)
- FireSoundAffectedByClipSize: `true`

### Misc
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- AmmoTypeStrings: `{["ar2"] = ".30-06 Springfield"}`

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_ext`, `reload_ext_empty`, `fire_last_ext`, `reload_grenade`
- Note: `fire_last_ext` is unique — used for the last-shot ext-mag variant

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 15/30 `Sound("TFA_CODWW2_M1GRND.Charge")`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `fire_last` ALSO has sound: 1/30 `Sound("TFA_CODWW2_M1GRND.Ping")` (the iconic Garand ping!)
- `reload`: 1/30 `Start`, 1/30 `Charge`, 10/30 `Ping`, 30/30 `MagIn`, 60/30 `Charge`
- `reload_empty`: 1/30 `Start`, 20/30 `MagIn`, 50/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 90/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 60/30 `EpicInspect2`
- `reload_ext`: 1/30 `Start`, 5/30 `TacExtMagOut`, 25/30 `TacExtMagIn`
- `reload_ext_empty`: 1/30 `Start`, 5/30 `ExtMagOut`, 30/30 `ExtMagIn`, 50/30 `Charge`
- `inspect_ext`: 1/30 `Inspect1`, 90/30 `Inspect2`
- `fire_last_ext`: 1/30 `Sound("TFA_CODWW2_M1CARB.LastShot")` (uses M1 Carbine sound, not M1 Garand)
- Grenade launcher events with `On2`/`Off2`
- `inspect_grenade` / `inspect_grenade_empty`: 1/30 `STG44.Inspect1`, 40/30 `STG44.Inspect2`, 100/30 `STG44.Inspect1b` (different order than other rifles!)

### Sequence Overrides
- StatusLengthOverride: reload=40/30, reload_empty=30/30, reload_ext=35/30, reload_ext_empty=35/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=45/30**, draw=35/30, draw_empty=35/30, reload=90/30, reload_empty=80/30, reload_ext=60/30, reload_ext_empty=75/30, melee=35/30, melee_empty=35/30, melee_bayonet=30/30, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30, holster_grenade=15/30, holster_grenade_empty=15/30

### VElements (15 elements)
- sight_nydar → c_m1garand_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_m1garand_4x.mdl
- lens_sight → shared
- clip_default → c_m1garand_clip.mdl (active=true)
- ext_clip → c_m1garand_clip_ext.mdl
- receiver_default → c_m1garand_receiver.mdl (active=true)
- barrel_default → c_m1garand_barrel.mdl (active=true)
- charm_default → c_m1garand_charm.mdl (active=true)
- sight_default → c_m1garand_sight.mdl (active=true)
- stock_default → c_m1garand_stock.mdl (active=true)
- sling_default → c_m1garand_sling.mdl (active=true) — UNIQUE to M1 Garand
- rail_sights → c_m1garand_front_post.mdl
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### AttachmentTableOverride (UNIQUE)
```lua
SWEP.AttachmentTableOverride = {
    ["tfa_codww2_xmag"] = {
        ["Animations"] = {
            ["reload"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_ext" },
            ["reload_empty"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_ext_empty" },
            ["shoot1_last"] = { type = TFA.Enum.ANIMATION_SEQ, value = "fire_last_ext" },
        },
    },
}
```
The xmag attachment overrides reload animations AND the last-shot animation (fire_last_ext). This is unique among rifles.

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=24, Damage=495, NumShots=2, RPM=334, DefaultClip=264, MaxAmmo=240, **FireModes = { "2Burst" }**, Automatic=**false** (stays semi, adds 2-burst)
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 10. M2 Carbine (nz_kate_codww2_m2carbine.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"M2 Carbine"` |
| Manufacturer | `"General Motors"` |
| Purpose | `"The M2 Carbine rifle is a fully automatic version of the M1A1. It's deadly accurate and offers a 3 shot kill at the cost of effectiveness at closer ranges."` |
| ViewModel | `"models/weapons/tfa_codww2/m2carbine/c_m2carbine.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m2carbine/w_m2carbine.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -0.5, 0)` |
| Offset.Pos | `Up=-6.5, Right=1, Forward=14` |
| NZPaPName | `"Spray Can"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STG44.Clicky"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1CARB.Low"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_M1CARB.Ping"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_M1GRND.NPC.Ext")` |
| Primary.Automatic | `true` (AUTO) |
| Primary.RPM | `461` |
| Primary.RPM_Rapid | `490` |
| Primary.Damage | `176` |
| Primary.ClipSize | `15` |
| Primary.ClipSize_Ext | `22` |
| Primary.DefaultClip | `165` |
| Primary.MaxAmmo | `150` |
| Primary.RangeFalloffLUT | `lut={{range=30,damage=1},{range=35,damage=0.75}}` |

### Ironsights (identical to M1A1)
- IronSightsPos: `Vector(-3.9, -3, 0.97)`
- IronSightsAng: `Vector(0.1, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.9, -2, 0.66)`
- IronSightsPos_ACOG: `Vector(-2.78, -4, 0.42)`
- IronSightsPos_LENS: `Vector(-3.897, -1, 0.966)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.32`, KickDown: `0.27`, KickHorizontal: `0.2`
- SpreadIncrement: `1.3`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=**true**, DefaultFireMode=`"1"`

### LowAmmo
- LastAmmoSound: `"TFA_CODWW2_M1CARB.LastShot"`

### Misc
- MoveSpeed: `1` (full speed — different from M1A1's 0.95)
- IronSightsMoveSpeed: `0.8`
- AmmoTypeStrings: `{["ar2"] = ".30 Carbine"}`

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 1/30 `M1CARB.FPOFoley`, 15/30 `M1CARB.FPO`
- `fire`, `fire_last`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 1/30 `TacStart`, 10/30 `TacMagOut`, 35/30 `TacMagIn`
- `reload_empty`: 1/30 `TacStart`, 10/30 `MagOut`, 35/30 `MagIn`, 70/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 45/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 45/30 `EpicInspect2`
- Grenade launcher events with `On2`/`Off2`

### Sequence Overrides
- StatusLengthOverride: reload=45/30, reload_empty=45/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=40/30**, reload=70/30, reload_empty=95/30, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, holster_grenade=15/30, holster_grenade_empty=15/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (11 elements)
- sight_nydar → **c_m1a1_reflex.mdl** (reuses M1A1 model)
- sight_nydar_lens (conditional)
- scope_acog → **c_m1a1_4x.mdl** (reuses M1A1)
- lens_sight → shared
- clip_default → c_m2carbine_clip.mdl (active=true)
- ext_clip → c_m2carbine_clip_ext.mdl
- sight_default → c_m2carbine_sight.mdl (active=true)
- rail_sights → c_m2carbine_front_sight.mdl
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl
- charm_default → bar/c_bar_charm.mdl (bodygroup={[0]=1})

### WElements (7 elements)
- clip_default, ext_clip, sight_default, sight_nydar (uses m1a1 model), scope_acog (uses m1a1 model), grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### ViewModelBoneMods (UNIQUE)
```lua
SWEP.ViewModelBoneMods = {
    ["tag_charm_base"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
```
Only M2 Carbine defines a ViewModelBoneMods entry.

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=64, Damage=528, NumShots=1, RPM=661, DefaultClip=704, MaxAmmo=640, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 11. M1941 Johnson (nz_kate_codww2_m1941.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"M1941"` |
| Manufacturer | `"Johnson Automatics, Inc."` |
| Purpose | `"Automatic rifle with a fast fire rate and moderate damage."` |
| ViewModel | `"models/weapons/tfa_codww2/m1941/c_m1941.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m1941/w_m1941.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-6, Right=1, Forward=14.6` |
| NZPaPName | `"Magic Johnson"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1941.Trans"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1941.Thump"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_TYPE100.Sub"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_MECH.Belt_Feed"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_M1CARB.Ext")` |
| Primary.RPM | `800` (highest base RPM of rifles) |
| Primary.RPM_Rapid | `857` |
| Primary.Damage | `124` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `37` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.74}}` |

### Ironsights
- IronSightsPos: `Vector(-3.99, -3, -0.31)`
- IronSightsAng: `Vector(0.36, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-4.005, -4, 0.96)`
- IronSightsPos_ACOG: `Vector(-3.37, -5, 0.327)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.35`, KickDown: `0.32`, KickHorizontal: `0.27`
- SpreadIncrement: `1.25`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_ext`, `reload_ext_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 5/30 `Sound("TFA_CODWW2_M1941.FPO")`
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end` (NO `fire_last`!)
- `reload`: 5/30 `TacMagOut`, 35/30 `TacMagIn`
- `reload_empty`: 1/30 `Charge`, 25/30 `MagOut`, 55/30 `MagIn` (Charge plays FIRST — unique)
- `inspect`: 1/30 `Inspect1`, 80/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 40/30 `EpicInspect2`
- `reload_ext`: 15/30 `TacMagOut`, 45/30 `TacMagIn`
- `reload_ext_empty`: 1/30 `Charge`, 25/30 `MagOut`, 55/30 `MagIn`
- Grenade launcher events with `On2`/`Off2`

### Sequence Overrides
- StatusLengthOverride: reload=55/30, reload_empty=70/30, reload_ext=60/30, reload_ext_empty=70/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=40/30**, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, holster_grenade=15/30, holster_grenade_empty=15/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (12 elements)
- sight_nydar → c_m1941_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_m1941_4x.mdl
- clip_default → c_m1941_clip.mdl (active=true)
- ext_clip → c_m1941_clip_ext.mdl
- receiver_default → c_m1941_receiver.mdl (active=true)
- barrel_default → c_m1941_barrel.mdl (active=true)
- charm_default → c_m1941_charm.mdl (active=true)
- sight_default → c_m1941_sight.mdl (active=true)
- stock_default → c_m1941_stock.mdl (active=true)
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl
- (NO lens_sight element!)

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_nydar`, `tfa_codww2_4x` (NO lens_sight) | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=372, NumShots=1, RPM=810, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 12. STG-44 (nz_kate_codww2_stg44.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"STG-44"` |
| Manufacturer | `"C.G. Haenel Waffen & Fahrradfabrik"` |
| Purpose | `"Automatic rifle with modest damage and low recoil."` |
| ViewModel | `"models/weapons/tfa_codww2/stg44/c_stg44.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/stg44/w_stg44.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-4, Right=1, Forward=14.5` |
| NZPaPName | `"Gewehr der Zeitalter"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STG44.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_STG44.Lyr2"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_STG44.Sub"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_STG44.Ext.Mp")` |
| Primary.RPM | `666` |
| Primary.RPM_Rapid | `714` |
| Primary.Damage | `100` |
| Primary.ClipSize | `30` |
| Primary.ClipSize_Ext | `45` |
| Primary.DefaultClip | `330` |
| Primary.MaxAmmo | `300` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.74}}` |

### Ironsights
- IronSightsPos: `Vector(-3.62, -7, 0.25)`
- IronSightsAng: `Vector(0.35, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.62, -4, -0.64)`
- IronSightsPos_ACOG: `Vector(-3.62, -9, 0.325)`
- IronSightsPos_LENS: `Vector(-3.62, -6, 0.305)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.25`, KickHorizontal: `0.15`
- SpreadIncrement: `1.2`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Misc
- SafetyPos: `Vector(-0, -3.4, -1.4)` (unique — uses `-0` and different values)
- SafetyAng: `Vector(-19, 28, -26)` (different)
- AmmoTypeStrings: `{["ar2"] = "7.92×33mm Kurz"}`

### Animations
- `melee_bayonet`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 15/30 `Sound("TFA_CODWW2_STG44.Charge")`
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 15/30 `TacMagOut`, 50/30 `TacMagIn`
- `reload_empty`: 15/30 `MagOut`, 50/30 `MagIn`, 70/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 20/30 `Inspect1b`, 50/30 `Inspect2` (3 sounds!)
- `inspect_empty`: same as inspect
- `inspect_epic`: 1/30 `EpicInspect1`, 60/30 `EpicInspect2`
- `reload_ext`/`reload_ext_empty` mirror reload/reload_empty
- Grenade launcher events with `On`/`Off` (German, not On2/Off2)

### Sequence Overrides
- StatusLengthOverride: reload=55/30, reload_empty=55/30, reload_grenade=35/30
- SequenceLengthOverride: grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: holster_grenade=15/30, sprint_loop=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (14 elements)
- sight_nydar → c_stg44_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_stg44_4x.mdl
- lens_sight → shared
- clip_default → c_stg44_clip.mdl (active=true)
- ext_clip → c_stg44_clip_ext.mdl
- receiver_default → c_stg44_receiver.mdl (active=true)
- barrel_default → c_stg44_barrel.mdl (active=true)
- charm_default → c_stg44_charm.mdl (active=true)
- sight_default → c_stg44_sight.mdl (active=true)
- rail_sights → c_stg44_folded_sight.mdl
- stock_default → c_stg44_stock.mdl (active=true)
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl**
- bayonet → **bayonet/c_ger_bayonet.mdl**

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=60, Damage=300, NumShots=2, RPM=676, DefaultClip=660, MaxAmmo=600, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 13. SVT-40 (nz_kate_codww2_svt40.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"SVT-40"` |
| Manufacturer | `"Tula Arms Plant"` |
| Purpose | `"Semi-auto marksman assault rifle. Delivers high damage that can take out enemies in two shots."` |
| ViewModel | `"models/weapons/tfa_codww2/svt40/c_svt40.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/svt40/w_svt40.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-5.5, Right=1, Forward=14` |
| NZPaPName | `"Survivor"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_SVT.Lfe"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_SVT.Trans"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_SVT.Mechy"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_SVT.Thump"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_SVT.Ext")` |
| Primary.Automatic | `false` (SEMI-AUTO) |
| Primary.RPM | `257` |
| Primary.RPM_Rapid | `273` |
| Primary.Damage | `200` |
| Primary.ClipSize | `10` |
| Primary.ClipSize_Ext | `15` |
| Primary.DefaultClip | `110` |
| Primary.MaxAmmo | `100` |
| Primary.RangeFalloffLUT | `lut={{range=30,damage=1},{range=35,damage=0.88}}` |

### Ironsights
- IronSightsPos: `Vector(-3.5, -4.5, 1.15)`
- IronSightsPos_NYDAR: `Vector(-3.502, -7, 0.775)`
- IronSightsPos_ACOG: `Vector(-2.3925, -4, 0.574)`
- IronSightsPos_LENS: `Vector(-3.497, -5, 1.126)`
- IronSightTime: `0.35`

### Spread / Recoil (marksman-style)
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.6`, KickDown: `0.5`, KickHorizontal: `0.3`
- SpreadIncrement: `2`, SpreadRecovery: `5`
- ViewModelPunchPitchMultiplier: `0.5`
- ViewModelPunch_MaxVertialOffset: `3`
- ViewModelPunch_VertialMultiplier: `1`
- ViewModelPunchYawMultiplier: `0.6`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=**false** (semi-only), DefaultFireMode=`"1"`

### LowAmmo
- **LastAmmoSound = Sound("")** (NOTE: declared directly as `SWEP.LastAmmoSound = Sound("")` outside the typical pattern, also overwritten later by `SWEP.LastAmmoSound = "TFA.LowAmmo.AssaultRifle_Dry"`)

### Misc
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- AmmoTypeStrings: `{["ar2"] = "7.62×54mmR"}`

### Animations
- `melee_bayonet`, `melee_bayonet_empty`, `reload_grenade`

### Event Table (notable)
- `draw_first`: 1/30 `Sound("TFA_CODWW2_SVT.FPO")`
- `draw_first_epic`: 1/30 `Sound("TFA_CODWW2_SVT.FPOEpic")`
- `fire`, `idle`, `idle_empty`, `melee` → `function(wep) wep:DetachGrenade() end`
- `fire_last`: 1/30 `Sound("TFA_CODWW2_GEWEHR.Mech")`, 1/30 lua `function(wep) wep:DetachGrenade() end` (uses GEWEHR mech sound)
- `reload`: 1/30 `TacMagOut`, 40/30 `TacMagIn`
- `reload_empty`: 1/30 `MagOut`, 40/30 `MagIn`, 65/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 45/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 45/30 `EpicInspect2`
- Grenade launcher events with `On2`/`Off2`

### Sequence Overrides
- StatusLengthOverride: reload=50/30, reload_empty=50/30, reload_grenade=35/30
- SequenceLengthOverride: **ACT_VM_DRAW_DEPLOYED=50/30**, grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, holster_grenade=15/30, holster_grenade_empty=15/30

### VElements (13 elements)
- sight_nydar → c_svt40_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_svt40_4x.mdl
- lens_sight → shared
- clip_default → c_svt40_clip.mdl (active=true)
- ext_clip → c_svt40_clip_ext.mdl
- receiver_default → c_svt40_receiver.mdl (active=true)
- barrel_default → c_svt40_barrel.mdl (active=true)
- charm_default → c_svt40_charm.mdl (active=true, bodygroup={[0]=1})
- sight_default → c_svt40_sight.mdl (active=true)
- stock_default → c_svt40_stock.mdl (active=true)
- grenade_rail → usa_rifle_grenade/c_rifle_grenade.mdl
- bayonet → bayonet/c_usa_bayonet.mdl

### WElements (10 elements)
- clip_default, ext_clip, receiver_default, barrel_default, sight_default, stock_default, sight_nydar, scope_acog, grenade_rail, bayonet

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet_empty`, `tfa_codww2_rifle_grenade` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=25, Damage=600, NumShots=1, RPM=867, DefaultClip=275, MaxAmmo=250, Automatic=true (high RPM on PaP despite being semi-auto base)
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 14. Volkssturmgewehr (nz_kate_codww2_volk.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Volkssturmgewehr"` |
| Manufacturer | `"Gustloff Werke"` |
| Purpose | `"Automatic rifle with moderate fire rate and high recoil."` |
| ViewModel | `"models/weapons/tfa_codww2/volk/c_volk.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/volk/w_volk.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -1.5, 0)` |
| Offset.Pos | `Up=-5.6, Right=1, Forward=15` |
| NZPaPName | `"Letzter Ausweg"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_VOLK.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_VOLK.Main"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_TYPE100.Sub"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_VOLK.Ext")` |
| Primary.RPM | `722` |
| Primary.RPM_Rapid | `769` |
| Primary.Damage | `157` |
| Primary.ClipSize | `30` |
| Primary.ClipSize_Ext | `45` |
| Primary.DefaultClip | `330` |
| Primary.MaxAmmo | `300` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.67}}` |

### Ironsights
- IronSightsPos: `Vector(-4.19, -3, 1.07)`
- IronSightsPos_NYDAR: `Vector(-4.187, -2, -0.025)`
- IronSightsPos_ACOG: `Vector(-4.184, -4.5, 0.215)`
- IronSightsPos_LENS: `Vector(-4.182, -3, 1.075)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.3`, KickHorizontal: `0.2`
- SpreadIncrement: `1`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `reload_ext`, `reload_ext_empty`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 15/30 `Sound("TFA_CODWW2_VOLK.Charge")`
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 5/30 `TacMagOut`, 30/30 `TacMagIn`
- `reload_empty`: 5/30 `MagOut`, 30/30 `MagIn`, 65/30 `Charge`
- `inspect`: 1/30 `Inspect1`, 50/30 `Inspect2`
- `inspect_epic`: 1/30 `EpicInspect1`, 105/30 `EpicInspect2` (longest epic inspect time)
- `reload_ext`: 10/30 `TacMagOut`, 35/30 `TacMagIn`
- `reload_ext_empty`: 10/30 `MagOut`, 35/30 `MagIn`, 65/30 `Charge`
- Grenade launcher events with `On`/`Off` (German)

### Sequence Overrides
- StatusLengthOverride: reload=50/30, reload_empty=50/30, reload_ext=50/30, reload_ext_empty=50/30, reload_grenade=35/30
- SequenceLengthOverride: **reload_grenade=80/30** (NOTE: listed twice with conflicting values — `["reload_grenade"] = 80/30` then `["reload_grenade"] = 70/30` — the second wins), grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30

### VElements (9 elements)
- sight_nydar → c_volk_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_volk_4x.mdl
- lens_sight → shared
- clip_default → c_volk_clip.mdl (active=true)
- ext_clip → c_volk_clip_ext.mdl
- charm_default → c_volk_charm.mdl (active=true)
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl**
- bayonet → **bayonet/c_ger_bayonet.mdl**
- (NO sight_default, NO receiver_default, NO barrel_default)

### WElements (6 elements)
- clip_default, ext_clip, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=64, Damage=471, NumShots=1, RPM=732, DefaultClip=704, MaxAmmo=640, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 15. Wimmersperg Spz (nz_kate_codww2_wimmer.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Wimmersperg Spz"` |
| Manufacturer | `"Never entered production"` |
| Purpose | `"Automatic rifle with high damage and moderate fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/wimmer/c_wimmer.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/wimmer/w_wimmer.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, 0, 0)` |
| Offset.Pos | `Up=-3.3, Right=1, Forward=14` |
| NZPaPName | `"A Fucking Pipe"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_RIBEY.Sub"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_FDRV.Stereo"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_FDRV.Center"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_FDRV.High"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_RIBEY.Trans"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_FDRV.Ext")` |
| Primary.RPM | `520` |
| Primary.RPM_Rapid | `552` |
| Primary.Damage | `177` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `37` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.RangeFalloffLUT | `lut={{range=50,damage=1},{range=55,damage=0.75}}` |

### Ironsights
- IronSightsPos: `Vector(-2.97, -5, 0.4)`
- IronSightsAng: `Vector(0.25, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-2.97, -3, -0.585)`
- IronSightsPos_ACOG: `Vector(-3.058, -7, 0.36)`
- IronSightsPos_LENS: `Vector(-2.965, -5, 0.38)`
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.35`, KickDown: `0.35`, KickHorizontal: `0.15`
- SpreadIncrement: `1.5`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=true

### Animations
- `melee_bayonet`, `reload_grenade`

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 10/30 `Sound("TFA_CODWW2_STG44.Charge")` (uses STG44 charge sound)
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 10/30 `STG44.TacMagOut`, 50/30 `STG44.TacMagIn` (uses STG44 sounds!)
- `reload_empty`: 10/30 `STG44.MagOut`, 50/30 `STG44.MagIn`, 65/30 `STG44.Charge`
- `inspect`: 1/30 `STG44.Inspect1`, 20/30 `STG44.Inspect1b`, 50/30 `STG44.Inspect2`
- `inspect_epic`: 1/30 `STG44.EpicInspect1`, 60/30 `STG44.EpicInspect2`
- Grenade launcher events with `On`/`Off` (German) — uses STG44 sounds throughout

### Sequence Overrides
- StatusLengthOverride: reload=55/30, reload_empty=55/30, reload_grenade=35/30
- SequenceLengthOverride: **reload_grenade=80/30** (NOTE: again listed twice with conflicting values — `["reload_grenade"] = 80/30` then `["reload_grenade"] = 70/30` — the second wins), grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30
- SequenceRateOverride: holster_grenade=15/30, sprint_in=25/30, sprint_loop=25/30

### VElements (10 elements)
- sight_nydar → c_wimmer_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_wimmer_4x.mdl
- lens_sight → shared
- clip_default → c_wimmer_clip.mdl (active=true)
- ext_clip → c_wimmer_clip_ext.mdl
- sight_default → c_wimmer_sight.mdl (active=true)
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl**
- bayonet → **bayonet/c_ger_bayonet.mdl**
- charm_default → bar/c_bar_charm.mdl (no bodygroup)
- (NO receiver_default, NO barrel_default)

### WElements (7 elements)
- clip_default, ext_clip, sight_default, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag_noani` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 7 |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=531, NumShots=2, RPM=530, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

## 16. ITRA Burst / PG1935 (nz_kate_codww2_pg1935.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"ITRA Burst"` |
| Manufacturer | `"Breda"` |
| Purpose | `"The ITRA Burst is a 4-round burst semi-automatic rifle that offers accuracy and moderate damage over long ranges."` |
| ViewModel | `"models/weapons/tfa_codww2/pg1935/c_pg1935.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/pg1935/w_pg1935.mdl"` |
| HoldType | `"ar2"` |
| VMPos | `Vector(0, -1.75, 0)` |
| Offset.Pos | `Up=-6.2, Right=1, Forward=13.9` |
| NZPaPName | `"ARTI Auto"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_PLAYER.Lfe.Rifle"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_SVT.Trans"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_SVT.Mechy"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_SVT.Thump"` |
| Primary.SoundEchoTable[256] | `Sound("TFA_CODWW2_SVT.Ext")` |
| Primary.Automatic | `true` |
| **Primary.RPM_Displayed** | `952` (UNIQUE — burst fire displayed RPM) |
| Primary.RPM_Semi | `nil` |
| **Primary.RPM_Burst** | `952` (UNIQUE — burst fire RPM) |
| **Primary.RPM_Burst_Rapid** | `1013` (UNIQUE) |
| **Primary.RPM_Displayed_Rapid** | `1013` (UNIQUE) |
| **Primary.BurstDelay** | `0.2` (UNIQUE — only rifle with burst delay set in primary section, also overridden to nil later) |
| Primary.Damage | `151` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.RangeFalloffLUT | `lut={{range=60,damage=1},{range=65,damage=0.73}}` |

### Ironsights
- IronSightsPos: `Vector(-3.4, -3.5, 1.3)`
- IronSightsPos_NYDAR: `Vector(-3.4, -2, -0.02)`
- IronSightsPos_ACOG: `Vector(-2.993, -2, 0.722)`
- IronSightsPos_LENS: `Vector(-3.395, -3.5, 1.235)`
- **IronhSightsAng_GL** (typo in source!): `Vector(0, 0, 0)` — note misspelling "IronhSights"
- IronSightTime: `0.35`

### Spread / Recoil
- Spread: `.015`, IronAccuracy: `.005`
- KickUp: `0.4`, KickDown: `0.25`, KickHorizontal: `0.2`
- SpreadIncrement: `1`

### Fire Modes (UNIQUE — burst fire)
| Field | Value |
|---|---|
| Primary.BurstDelay | `nil` (overridden from `0.2` set earlier) |
| **DisableBurstFire** | `false` (UNIQUE — only rifle that allows burst fire) |
| SelectiveFire | `false` |
| **OnlyBurstFire** | `true` (UNIQUE — only rifle locked to burst) |
| **BurstFireCount** | `4` (UNIQUE — 4-round burst) |
| DefaultFireMode | `"1"` |

### Animations
- `melee_bayonet`, `reload_ext_empty`, `reload_grenade` (NO melee_bayonet_empty, NO reload_ext)

### Event Table (notable)
- `ACT_VM_DRAW_DEPLOYED`: 10/30 `Sound("TFA_CODWW2_M1935.FPO")`
- `fire`, `idle`, `melee` → `function(wep) wep:DetachGrenade() end`
- `reload`: 5/30 `TacMagOut`, 45/30 `TacMagIn`
- `reload_empty`: 5/30 `MagOut`, 45/30 `MagIn` (NO Charge sound — unique, no charging handle)
- `inspect`: 1/30 `Inspect1`, 55/30 `Inspect2` (no inspect_empty!)
- `inspect_epic`: 1/30 `EpicInspect1`, 90/30 `EpicInspect2`
- `reload_ext_empty`: 5/30 `MagOut`, 45/30 `MagIn`
- Grenade launcher events with `On`/`Off` (German)

### Sequence Overrides
- StatusLengthOverride: reload=60/30, reload_empty=60/30, reload_ext_empty=60/30, reload_grenade=35/30
- SequenceLengthOverride: grenade_in=65/30, grenade_out=65/30, grenade_in_empty=20/30, grenade_out_empty=20/30, reload_grenade=70/30
- SequenceRateOverride: sprint_in=25/30, sprint_loop=25/30, sprint_in_grenade=20/30, sprint_loop_grenade=25/30, sprint_in_grenade_empty=20/30, sprint_loop_grenade_empty=25/30

### VElements (9 elements)
- sight_nydar → c_pg1935_reflex.mdl
- sight_nydar_lens (conditional)
- scope_acog → c_pg1935_4x.mdl
- lens_sight → shared
- clip_default → c_pg1935_clip.mdl (active=true)
- ext_clip → c_pg1935_clip_ext.mdl
- grenade_rail → **ger_rifle_grenade/c_rifle_grenade.mdl**
- bayonet → **bayonet/c_ger_bayonet.mdl**
- charm_default → bar/c_bar_charm.mdl (bodygroup={[0]=1})
- (NO sight_default, NO receiver_default, NO barrel_default)

### WElements (6 elements)
- clip_default, ext_clip, sight_nydar, scope_acog, grenade_rail (ger), bayonet (ger)

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_lens_sight`, `tfa_codww2_nydar`, `tfa_codww2_4x` | 2 |
| [3] | `tfa_codww2_xmag` | 3 |
| [4] | `tfa_codww2_bayonet`, `tfa_codww2_rifle_grenade_ger` | 4 |
| [5] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 5 |
| [6] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 6 |
| [7] | `tfa_codww2_highcal`, **`tfa_codww2_rapidfire_pg1935`** (UNIQUE variant!), `tfa_codww2_fmj` | 7 |

### AttachmentTableOverride (UNIQUE)
```lua
SWEP.AttachmentTableOverride = {
    ["tfa_codww2_xmag"] = {
        ["Animations"] = {
            ["reload"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload" },
            ["reload_empty"] = { type = TFA.Enum.ANIMATION_SEQ, value = "reload_ext_empty" },
        },
    },
}
```
The xmag attachment keeps `reload` as-is but swaps `reload_empty` to `reload_ext_empty`. This is different from M1 Garand's override pattern.

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=60, Damage=453, NumShots=2, RPM=724, DefaultClip=660, MaxAmmo=600, **Primary_TFA.DisableBurstFire = true**, **Primary_TFA.OnlyBurstFire = false**, Automatic=true (converts from burst to full-auto on PaP)
- `SWEP:NZMaxAmmo()`, `SWEP:AttachGrenade()`, `SWEP:DetachGrenade()`

---

# SMG-CLASSIFIED RIFLES

---

## 17. Proto-X1 / Arsenal (nz_kate_codww2_arsenal.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Submachine Guns"` (NOTE: classified as SMG despite being in rifle list) |
| Slot | `2` |
| PrintName | `"Proto-X1"` |
| Manufacturer | `"Tokyo Arsenal"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with a smaller magazine and a moderate damage output."` |
| ViewModel | `"models/weapons/tfa_codww2/arsenal/c_arsenal.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/arsenal/w_arsenal.mdl"` |
| HoldType | `"smg"` |
| VMPos | `Vector(0, -1, 0)` |
| Offset.Pos | `Up=-5, Right=1, Forward=17.6` |
| NZPaPName | `"PR0T0-G3N"` |
| **MuzzleAttachmentSilenced** | `"2"` (UNIQUE — has silenced muzzle attachment point) |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_RIBEY.Sub"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_TOKYO.Center"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_TOKYO.Stereo"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_TOKYO.High"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_RIBEY.Trans"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_EJECT.SMG"` |
| **Primary.SilencedSound** | `"TFA_CODWW2_SUPP.SMG"` (UNIQUE — supports suppressor) |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.SMG.Int"), [256]=Sound("TFA_CODWW2_TOKYO.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` (SMG dry fire) |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `750` |
| Primary.RPM_Rapid | `797` |
| Primary.Damage | `65` |
| Primary.ClipSize | `24` |
| Primary.ClipSize_Ext | `36` |
| Primary.DefaultClip | `264` |
| Primary.MaxAmmo | `240` |
| Primary.RangeFalloffLUT | `lut={{range=25,damage=1},{range=27,damage=0.65}}` |

### Ironsights
- IronSightsPos: `Vector(-3.76, -4, 0.95)`
- IronSightsAng: `Vector(1, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.765, 0, 0.09)`
- IronSightsPos_LENS: `Vector(-3.757, -4, 1.27)`
- IronSightTime: `0.3` (faster than rifle 0.35)
- Secondary.IronFOV: `75`

### Spread / Recoil (SMG-style)
- Spread: `.02`, IronAccuracy: `.01`
- KickUp: `0.4`, KickDown: `0.25`, KickHorizontal: `0.2`
- StaticRecoilFactor: `0.4`
- SpreadMultiplierMax: `5`, SpreadIncrement: `1`, SpreadRecovery: `6`
- ViewModelPunchPitchMultiplier: `0.5`
- ViewModelPunch_MaxVertialOffset: `2.5`
- ViewModelPunch_VertialMultiplier: `1`
- ViewModelPunchYawMultiplier: `0.6`
- CrouchRecoilMultiplier: `0.8`
- WallRecoilMultiplier: `1.0`
- CrouchAccuracyMultiplier: `0.85`
- JumpAccuracyMultiplier: `3.5`
- WalkAccuracyMultiplier: `1.35`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=false, DefaultFireMode=`"1"`

### Bash (SMG-style)
- Secondary.BashSound: `Sound("TFA_CODWW2_MELEE.SwingSmg")` (NOT SwingRfl)
- Secondary.BashLength: `45`

### Shells (SMG-style)
- LuaShellModel: `"models/entities/tfa_codww2/shells/fx_9mm.mdl"` (9mm, not 556)
- LuaShellSound: `"TFA_CODWW2_SHELLS.Small"` (Small, not Large)
- LuaShellScale: `1.1`

### Jamming (SMG-style)
- CanJam=true, JamChance=0.02, JamFactor=**0.06** (higher than rifle 0.035)

### Misc
- MoveSpeed: `1` (full speed)
- IronSightsMoveSpeed: `0.8`
- SafetyPos: `Vector(0, -3, -0.2)`
- SafetyAng: `Vector(-19, 21, -21)`
- TracerCount: `3`
- AmmoTypeStrings: `{["smg1"] = "8x22mm Nambu"}`
- DInv2_Mass: `5` (lighter than rifles)

### Animations (UNIQUE — suppressor animations)
- `suppressor_remove`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"suppressor_remove"`
- `suppressor_attach`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"suppressor_attach"`
- `suppressor_remove_knife`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"suppressor_remove_knife"`
- `suppressor_attach_knife`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"suppressor_attach_knife"`

### Event Table (complete)
| Key | Time | Type | Value |
|---|---|---|---|
| ACT_VM_DRAW_DEPLOYED | 5/30 | sound | `Sound("TFA_CODWW2_TOKYO.FPOCharge")` |
| ACT_VM_DRAW | 1/30 | sound | `Sound("TFA_CODWW2_SML.Raise")` |
| ACT_VM_DRAW_EMPTY | 2/30 | sound | `Sound("TFA_CODWW2_SML.Raise")` |
| ACT_VM_HOLSTER | 2/30 | sound | `Sound("TFA_CODWW2_SML.Holster")` |
| ACT_VM_HOLSTER_EMPTY | 2/30 | sound | `Sound("TFA_CODWW2_SML.Holster")` |
| ACT_VM_RELOAD | 5/30 | sound | `Sound("TFA_CODWW2_TOKYO.TacMagOut")` |
| ACT_VM_RELOAD | 35/30 | sound | `Sound("TFA_CODWW2_TOKYO.TacMagIn")` |
| ACT_VM_RELOAD_EMPTY | 5/30 | sound | `Sound("TFA_CODWW2_TOKYO.MagOut")` |
| ACT_VM_RELOAD_EMPTY | 35/30 | sound | `Sound("TFA_CODWW2_TOKYO.MagIn")` |
| ACT_VM_RELOAD_EMPTY | 60/30 | sound | `Sound("TFA_CODWW2_TOKYO.Charge")` |
| `inspect` | 1/30 | sound | `Sound("TFA_CODWW2_TOKYO.Inspect1")` |
| `inspect` | 50/30 | sound | `Sound("TFA_CODWW2_TOKYO.Inspect2")` |
| `inspect_epic` | 1/30 | sound | `Sound("TFA_CODWW2_TOKYO.Inspect1")` |
| `inspect_epic` | 50/30 | sound | `Sound("TFA_CODWW2_TOKYO.Inspect2")` |
| `inspect_empty` | 1/30 | sound | `Sound("TFA_CODWW2_TOKYO.EpicInspect1")` |
| `inspect_empty` | 50/30 | sound | `Sound("TFA_CODWW2_TOKYO.EpicInspect2")` |
| `draw_knife` / `draw_knife_empty` | 2/30 | sound | `Sound("TFA_CODWW2_SML.Raise")` |
| `holster_knife` / `holster_knife_empty` | 2/30 | sound | `Sound("TFA_CODWW2_SML.Holster")` |
| `reload_knife` | 5/30 | sound | `Sound("TFA_CODWW2_TOKYO.TacMagOut")` |
| `reload_knife` | 35/30 | sound | `Sound("TFA_CODWW2_TOKYO.TacMagIn")` |
| `reload_knife_empty` | 5/30 | sound | `Sound("TFA_CODWW2_TOKYO.MagOut")` |
| `reload_knife_empty` | 35/30 | sound | `Sound("TFA_CODWW2_TOKYO.MagIn")` |
| `reload_knife_empty` | 60/30 | sound | `Sound("TFA_CODWW2_TOKYO.Charge")` |
| `inspect_knife` / `inspect_knife_empty` | 1/30, 50/30 | sound | `Sound("TFA_CODWW2_TOKYO.Inspect1")`, `Sound("TFA_CODWW2_TOKYO.Inspect2")` |
| `suppressor_attach` | 1/30 | sound | `Sound("TFA_CODWW2_MP40.SuppOn")` |
| `suppressor_remove` | 1/30 | sound | `Sound("TFA_CODWW2_MP40.SuppOff")` |
| `suppressor_attach_knife` | 1/30 | sound | `Sound("TFA_CODWW2_MP40.SuppOn")` |
| `suppressor_remove_knife` | 1/30 | sound | `Sound("TFA_CODWW2_MP40.SuppOff")` |

### Sequence Overrides
**StatusLengthOverride**
- `ACT_VM_RELOAD`: `45/30`
- `ACT_VM_RELOAD_EMPTY`: `45/30`
- `reload_knife`: `45/30`
- `reload_knife_empty`: `45/30`

(Uses ACT_VM_* keys, not string keys like other rifles)

### VElements (7 elements)
- sight_nydar → c_arsenal_reflex.mdl
- sight_nydar_lens (conditional)
- lens_sight → shared
- suppressor → **c_suppressor_hub23.mdl** (UNIQUE — has suppressor VElement)
- clip_default → c_arsenal_clip.mdl (active=true)
- ext_clip → c_arsenal_clip_ext.mdl
- charm_default → bar/c_bar_charm.mdl (no bodygroup)
- (NO scope_acog, NO sight_default, NO grenade_rail, NO bayonet)

### WElements (5 elements)
- suppressor → **w_suppressor_hub23.mdl** (UNIQUE)
- clip_default, ext_clip, sight_nydar
- (NO bayonet, NO grenade_rail)

### Attachments
| Slot | atts | order |
|---|---|---|
| [1] | `tfa_codww2_supp` | 1 (UNIQUE — suppressor in slot 1) |
| [2] | `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (NO 4x scope!) | 2 |
| [3] | `tfa_codww2_xmag_ani` | 3 |
| [4] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 4 |
| [5] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 5 |
| [6] | `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 6 (NO highcal, NO bayonet, NO rifle_grenade) |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=48, Damage=195, NumShots=2, RPM=760, DefaultClip=528, MaxAmmo=480, Automatic=true
- `SWEP:NZMaxAmmo()` — server-only sets ammo
- **NO `SWEP:AttachGrenade()` or `SWEP:DetachGrenade()`** — Arsenal does NOT have grenade launcher

---

## 18. Ribeyrolles (nz_kate_codww2_ribey.lua)

### Core Fields
| Field | Value |
|---|---|
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Submachine Guns"` (NOTE: classified as SMG) |
| PrintName | `"Ribeyrolles"` |
| Manufacturer | `"Never entered production"` |
| Type_Displayed | `"Submachine Gun?"` (with question mark!) |
| Purpose | `"Automatic SMG that thrives in mid range engagements."` |
| ViewModel | `"models/weapons/tfa_codww2/ribey/c_ribey.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/ribey/w_ribey.mdl"` |
| HoldType | `"ar2"` (NOTE: uses ar2 holdtype despite SMG classification) |
| VMPos | `Vector(0, -1.5, 0)` |
| Offset.Pos | `Up=-7, Right=1, Forward=20.8` |
| NZPaPName | `"Baby Back Ribs"` |
| **MuzzleAttachmentSilenced** | `"2"` (UNIQUE — has silenced muzzle attachment point) |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_RIBEY.Sub"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_RIBEY.Lyr1"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_RIBEY.Blast"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_RIBEY.Trans"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_EJECT.SMG"` |
| **Primary.SilencedSound** | `"TFA_CODWW2_SUPP.SMG"` (UNIQUE — supports suppressor) |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_RIBEY.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `588` |
| Primary.RPM_Rapid | `625` |
| Primary.Damage | `85` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `37` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.RangeFalloffLUT | `lut={{range=30,damage=1},{range=32,damage=0.65}}` |

### Ironsights
- IronSightsPos: `Vector(-3.08, -9, 0.81)`
- IronSightsPos_NYDAR: `Vector(-3.66, -5, 0.75)`
- IronSightsPos_LENS: `Vector(-3.073, -9, 1.314)`
- IronSightTime: `0.3`
- Secondary.IronFOV: `75`
- (NO IronSightsPos_ACOG — does not support 4x scope)

### Spread / Recoil (SMG-style)
- Spread: `.02`, IronAccuracy: `.0075`
- KickUp: `0.4`, KickDown: `0.3`, KickHorizontal: `0.25`
- StaticRecoilFactor: `0.4`
- SpreadMultiplierMax: `5`, SpreadIncrement: `1`, SpreadRecovery: `6`
- ViewModelPunchPitchMultiplier: `0.5`
- ViewModelPunch_MaxVertialOffset: `2.5`
- ViewModelPunch_VertialMultiplier: `1`
- ViewModelPunchYawMultiplier: `0.6`
- CrouchRecoilMultiplier: `0.8`
- WallRecoilMultiplier: `1.0`
- CrouchAccuracyMultiplier: `0.85`
- JumpAccuracyMultiplier: `3.5`
- WalkAccuracyMultiplier: `1.35`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=false, DefaultFireMode=`"1"`

### Bash (SMG-style)
- Secondary.BashSound: `Sound("TFA_CODWW2_MELEE.SwingSmg")`
- Secondary.BashLength: `45`

### Shells (SMG-style)
- LuaShellModel: `"models/entities/tfa_codww2/shells/fx_9mm.mdl"`
- LuaShellSound: `"TFA_CODWW2_SHELLS.Small"`
- LuaShellScale: `1.1`

### Jamming (SMG-style)
- CanJam=true, JamChance=0.02, JamFactor=**0.06**

### Misc
- MoveSpeed: `1`, IronSightsMoveSpeed: `0.8`
- SafetyPos: `Vector(-1.5, -2, -0)`
- SafetyAng: `Vector(-15, 10, -25)`
- TracerCount: `3`
- AmmoTypeStrings: `{["smg1"] = "8×35mm Ribeyrolles"}`
- DInv2_Mass: `5`

### Animations (UNIQUE — suppressor animations)
- `suppressor_remove`, `suppressor_attach`, `suppressor_remove_knife`, `suppressor_attach_knife`

### Event Table (notable — UNIQUE Lua bodygroup updates)
- `ACT_VM_DRAW_DEPLOYED`: 5/30 `Sound("TFA_CODWW2_RIBEY.FPOCharge")`, 1s lua `function(self) self.Bodygroups_V[1] = math.Clamp(self:Clip1(),0,18) end`
- `ACT_VM_DRAW`: 1/30 `Sound("TFA_CODWW2_SML.Raise")`, 1s lua `function(self) self.Bodygroups_V[1] = math.Clamp(self:Clip1(),0,18) end`
- `ACT_VM_DRAW_EMPTY`: 2/30 `Sound("TFA_CODWW2_SML.Raise")`, 1s lua bodygroup update
- `ACT_VM_HOLSTER`/`ACT_VM_HOLSTER_EMPTY`: 2/30 `Sound("TFA_CODWW2_SML.Holster")`
- **ACT_VM_PRIMARYATTACK**: 0 lua `function(self) self.Bodygroups_V[1] = math.Clamp(self:Clip1(),0,18) end` (updates bullet bodygroup on each shot!)
- **ACT_VM_PRIMARYATTACK_1**: 0 lua bodygroup update
- **ACT_VM_PRIMARYATTACK_EMPTY**: 0 lua bodygroup update
- `ACT_VM_RELOAD`: 1/30 `TacMagOut`, 25/30 `TacMagIn`, 25/30 lua `function(self) self.Bodygroups_V[1] = math.Clamp( math.Round( (self:Clip1() + self:Ammo1()) ),0,18) end`
- `ACT_VM_RELOAD_EMPTY`: 1/30 `MagOut`, 25/30 `MagIn`, 70/30 `Charge`, 25/30 lua bodygroup update
- `ACT_VM_FIDGET`: 1/30 `Inspect1`, 50/30 `Inspect2`
- `inspect_empty`: 1/30 `Inspect1`, 50/30 `Inspect2`
- `draw_knife`/`draw_knife_empty`: 2/30 `SML.Raise`
- `holster_knife`/`holster_knife_empty`: 2/30 `SML.Holster`
- `reload_knife`: 1/30 lua `function(self) self.Bodygroups_V[1] = 0 end`, 5/30 `ExtTacMagOut`, 25/30 `ExtTacMagIn`
- `reload_knife_empty`: 1/30 lua `function(self) self.Bodygroups_V[1] = 0 end`, 5/30 `ExtMagOut`, 25/30 `ExtMagIn`, 65/30 `ExtCharge`
- `inspect_knife`/`inspect_knife_empty`: 1/30, 50/30 `Inspect1`, `Inspect2`
- `suppressor_attach`/`suppressor_remove`/`suppressor_attach_knife`/`suppressor_remove_knife`: 1/30 `MP40.SuppOn`/`MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride**
- `ACT_VM_RELOAD`: `40/30`
- `ACT_VM_RELOAD_EMPTY`: `40/30`
- `reload_knife`: `40/30`
- `reload_knife_empty`: `40/30`

### VElements (8 elements)
- sight_nydar → c_ribey_reflex.mdl
- sight_nydar_lens (conditional)
- lens_sight → shared
- suppressor → **c_pistol_suppressor.mdl** (UNIQUE — pistol suppressor)
- clip_default → c_ribey_clip.mdl (active=true)
- ext_clip → c_ribey_clip_ext.mdl
- sight_default → c_ribey_sight.mdl (active=true)
- charm_default → bar/c_bar_charm.mdl (no bodygroup)

### WElements (5 elements)
- suppressor → **w_pistol_suppressor.mdl**
- clip_default, ext_clip, sight_default, sight_nydar

### Attachments
| Slot | atts | order |
|---|---|---|
| [1] | `tfa_codww2_supp` | 1 (UNIQUE — suppressor in slot 1) |
| [2] | `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (NO 4x scope!) | 2 |
| [3] | `tfa_codww2_xmag_ani` | 3 |
| [4] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 4 |
| [5] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 5 |
| [6] | `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 6 (NO highcal) |

### AttachmentTableOverride (UNIQUE)
```lua
SWEP.AttachmentTableOverride = {
    ["tfa_codww2_lens_sight"] = {
        ["VElements"] = {
            ["lens_sight"] = { ["active"] = true },
            ["sight_default"] = { ["active"] = false },
        },
        ["WElements"] = {
            ["lens_sight"] = { ["active"] = true },
            ["sight_default"] = { ["active"] = false },
        },
    },
    ["tfa_codww2_xmag_ani"] = {
        ["Bodygroups_V"] = { [1] = 0 },
    }
}
```
The lens_sight attachment toggles VElement visibility, and xmag_ani sets bodygroup [1] to 0 (so the procedural bullet bodygroup stops updating when extended mag is attached).

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=50, Damage=255, NumShots=2, RPM=598, DefaultClip=550, MaxAmmo=500, Automatic=true
- `SWEP:NZMaxAmmo()` — server-only sets ammo
- **NO `SWEP:AttachGrenade()` or `SWEP:DetachGrenade()`** — Ribey does NOT have grenade launcher

---

# SHOTGUNS

---

## 19. M30 Luftwaffe Drilling (nz_kate_codww2_m30.lua)

### Core Fields
| Field | Value |
|---|---|
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Shotguns"` |
| Slot | `3` (UNIQUE — slot 3, not 2) |
| PrintName | `"M30 Luftwaffe Drilling"` |
| Manufacturer | `"Sauer & Sohn"` |
| Type_Displayed | `"Shotgun"` |
| Purpose | `"Dual barrel shotgun that delivers two quick wide-spread shells."` |
| ViewModel | `"models/weapons/tfa_codww2/m30/c_m30.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m30/w_m30.mdl"` |
| HoldType | `"shotgun"` |
| VMPos | `Vector(0, -1.75, 0)` |
| Offset.Pos | `Up=-4.6, Right=1, Forward=13.5` |
| NZPaPName | `"Langer Stock"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_SHGN.GenHigh"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_SHGN.HighSnap"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_SHGN.GenBlast"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_SHGN.DeepBlast"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_SHGN.MidBlast"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_SHGN.Lfe"` |
| Primary.SoundLyr6 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_M30.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SG"` (SHOTGUN dry fire) |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SG"` |
| Primary.Ammo | `"buckshot"` |
| Primary.Automatic | `false` |
| Primary.RPM | `150` |
| Primary.RPM_Rapid | `160` |
| Primary.Damage | `125` |
| Primary.NumShots | `8` |
| **Primary.NumShots_Incen** | `14` (UNIQUE — incendiary shell pellet count) |
| Primary.ClipSize | `2` |
| Primary.DefaultClip | `42` |
| Primary.MaxAmmo | `40` |
| Primary.DryFireDelay | `0.5` (longer than rifles) |
| Primary.RangeFalloffLUT | `lut={{range=20,damage=1.0},{range=22,damage=0.4}}` (steep falloff) |

### Secondary Stats (Bash)
| Field | Value |
|---|---|
| Secondary.BashDamage | `35` |
| Secondary.BashSound | `Sound("TFA_CODWW2_MELEE.SwingRfl")` |
| Secondary.BashLength | `54` (longer than rifle 45) |
| Secondary.BashDelay | `0.2` |

### Fire Modes
- DisableBurstFire=true, SelectiveFire=false, DefaultFireMode=`"1"`

### Ironsights
- IronSightsPos: `Vector(-3.245, -1, 1.28)`
- IronSightsAng: `Vector(0.4, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.244, -1, 0.12)`
- IronSightTime: `0.3` (faster than rifle 0.35)
- Secondary.IronFOV: `75`

### Spread / Recoil (shotgun-style)
- Spread: `.05`, IronAccuracy: `.05`
- KickUp: `1.0`, KickDown: `1.0`, KickHorizontal: `0.4`
- StaticRecoilFactor: `0.4`
- SpreadMultiplierMax: `3`, SpreadIncrement: `2`, SpreadRecovery: `3`
- ViewModelPunchPitchMultiplier: `0.65`
- ViewModelPunch_MaxVertialOffset: `3`
- ViewModelPunch_VertialMultiplier: `1.5`
- ViewModelPunchYawMultiplier: `0.6`
- IronRecoilMultiplier: `0.7`
- CrouchRecoilMultiplier: `0.9`
- JumpRecoilMultiplier: `2.65` (very high!)
- WallRecoilMultiplier: `1.25`
- CrouchAccuracyMultiplier: `1.0`
- JumpAccuracyMultiplier: `1.5`
- WalkAccuracyMultiplier: `1.35`

### Shells (shotgun-style)
- LuaShellEject: `false` (no lua shell eject — uses model animation)
- LuaShellModel: `"models/entities/tfa_codww2/shells/fx_12gauge.mdl"`
- LuaShellSound: `"TFA_CODWW2_SHELLS.Shotgun"`
- LuaShellScale: `1.2`
- EjectionSmokeEnabled: `false`

### Jamming (shotgun-style)
- CanJam=true, JamChance=**0.03** (higher), JamFactor=**0.15** (much higher)

### Misc
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- SafetyPos: `Vector(3.2, -2, -1)`
- SafetyAng: `Vector(-17.5, 41.5, -20)`
- TracerCount: `1` (low)
- InspectPos: `Vector(10, -7, -2)` (different Y from rifles)
- AmmoTypeStrings: `{["buckshot"] = "12 Gauge"}`

### Animations (UNIQUE — no Animations table declared; uses base animations)

### Event Table (UNIQUE — uses ACT_VM_RELOAD with shell eject lua events)
| Key | Time | Type | Value |
|---|---|---|---|
| ACT_VM_DRAW_DEPLOYED | 1/30 | sound | `Sound("TFA_CODWW2_M30.FPO")` |
| ACT_VM_DRAW | 1/30 | sound | `Sound("TFA_CODWW2_M30.Draw")` |
| ACT_VM_HOLSTER | 1/30 | sound | `Sound("TFA_CODWW2_MED.Holster")` |
| ACT_VM_RELOAD | 10/30 | sound | `Sound("TFA_CODWW2_M30.TacOpen")` |
| ACT_VM_RELOAD | 25/30 | lua | `function(self) self:EventShell() end` (client=true, server=true) |
| ACT_VM_RELOAD | 50/30 | sound | `Sound("TFA_CODWW2_M30.TacInsert")` |
| ACT_VM_RELOAD | 75/30 | sound | `Sound("TFA_CODWW2_M30.TacClose")` |
| ACT_VM_RELOAD_EMPTY | 10/30 | sound | `Sound("TFA_CODWW2_M30.EmptyOpen")` |
| ACT_VM_RELOAD_EMPTY | 25/30 | lua | `function(self) self:EventShell() end` (TWICE — for both shells) |
| ACT_VM_RELOAD_EMPTY | 50/30 | sound | `Sound("TFA_CODWW2_M30.EmptyInsert")` |
| ACT_VM_RELOAD_EMPTY | 100/30 | sound | `Sound("TFA_CODWW2_M30.EmptyClose")` |
| `reload_rifle` | 10/30 | sound | `Sound("TFA_CODWW2_M30.RifleOpen")` |
| `reload_rifle` | 50/30 | sound | `Sound("TFA_CODWW2_M30.RifleChamber")` |
| `reload_rifle` | 75/30 | sound | `Sound("TFA_CODWW2_M30.RifleClose")` |
| ACT_VM_FIDGET | 1/30 | sound | `Sound("TFA_CODWW2_M30.Inspect1")` |
| ACT_VM_FIDGET | 40/30 | sound | `Sound("TFA_CODWW2_M30.Inspect2")` |
| `inspect_rifle` | 1/30 | sound | `Sound("TFA_CODWW2_M30.Inspect1")` |
| `inspect_rifle` | 40/30 | sound | `Sound("TFA_CODWW2_M30.Inspect2")` |
| `idle_to_rifle` | 1/30 | sound | `Sound("TFA_CODWW2_M30.SwitchOn")` |
| `rifle_to_idle` | 1/30 | sound | `Sound("TFA_CODWW2_M30.SwitchOFF")` |

### Sequence Overrides
**StatusLengthOverride**
- `reload`: `65/30`
- `reload_empty`: `90/30`
- `reload_rifle`: `65/30`

**SequenceLengthOverride**
- `reload`: `95/30`
- `reload_empty`: `120/30`
- `reload_rifle`: `95/30`

**SequenceRateOverride**
- `sprint_in`: `25/30`
- `sprint_loop`: `25/30`

### VElements (9 elements)
- sight_nydar → c_m30_reflex.mdl
- sight_nydar_lens (conditional)
- shell_default → c_m30_clip.mdl (active=true) — represents shotgun shells
- shell_incen → c_m30_clip_incen.mdl (incendiary shells)
- receiver_default → c_m30_receiver.mdl (active=true)
- barrel_default → c_m30_barrel.mdl (active=true)
- charm_default → c_m30_charm.mdl (active=true)
- stock_default → c_m30_stock.mdl (active=true)
- sights_default → c_m30_sight.mdl (active=true)
- (NO scope_acog, NO lens_sight, NO grenade_rail, NO bayonet, NO ext_clip)

### WElements (5 elements)
- receiver_default, barrel_default, stock_default, sight_nydar, sights_default

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_nydar` (only!) | 2 |
| [4] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 4 |
| [5] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 5 |
| [6] | `tfa_codww2_rapidfire`, **`tfa_codww2_incenshells`**, **`tfa_codww2_riflebullet`** | 6 (UNIQUE — incendiary shells and rifle bullet attachments!) |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=4, Damage=375, NumShots=8, RPM=160, DefaultClip=44, MaxAmmo=40, **FireModes = { "2Burst" }**, Automatic=false (adds 2-burst on PaP)
- `SWEP:NZMaxAmmo()` — server-only sets ammo
- **NO `SWEP:AttachGrenade()` or `SWEP:DetachGrenade()`**
- **`DEFINE_BASECLASS( SWEP.Base )`** declared (UNIQUE — only M30 does this explicitly)

### Secondary Fire (UNIQUE — rifle bullet secondary)
The M30 Drilling is a combination gun — shotgun primary + rifle secondary:
```lua
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.AmmoConsumption = 1
SWEP.Secondary.Ammo = "SniperPenetratedRound"
SWEP.Secondary.Sound = "TFA_CODWW2_WALTHER.High"
SWEP.Secondary.Damage = 108
```
This is the ONLY weapon in the rifle audit with a functional secondary fire mode (rifle bullet).

---

## 20. Sawed-off Shotgun / Model 21 (nz_kate_codww2_model21.lua)

### Core Fields
| Field | Value |
|---|---|
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Shotguns"` |
| Slot | `3` |
| PrintName | `"Sawed-off Shotgun"` |
| Manufacturer | `"Remington"` |
| Type_Displayed | `"Shotgun"` |
| Purpose | `"Sawed-off shotgun with a high close range damage output."` |
| ViewModel | `"models/weapons/tfa_codww2/model21/c_model21.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/model21/w_model21.mdl"` |
| HoldType | `"shotgun"` |
| VMPos | `Vector(0, -1.5, 0)` |
| Offset.Pos | `Up=-5, Right=1, Forward=16.4` |
| NZPaPName | `"Short Stop"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_SHGN.BigBlast"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_SHGN.GenHigh"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_SHGN.Trans"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_SHGN.GenBlast"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_SHGN.GenBoom"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_SHGN.Lfe"` |
| Primary.SoundLyr6 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_MODEL21.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SG"` |
| Primary.Ammo | `"buckshot"` |
| Primary.Automatic | `false` |
| Primary.RPM | `130` |
| Primary.RPM_Rapid | `212` |
| Primary.Damage | `80` |
| Primary.NumShots | `8` |
| **Primary.NumShots_Incen** | `14` |
| Primary.ClipSize | `2` |
| Primary.DefaultClip | `42` |
| Primary.MaxAmmo | `40` |
| Primary.DryFireDelay | `0.5` |
| Primary.RangeFalloffLUT | `lut={{range=13,damage=1},{range=16,damage=0.5}}` (very steep — sawed-off) |

### Bash
- Secondary.BashLength: `54`

### Fire Modes
- DisableBurstFire=true, SelectiveFire=false, DefaultFireMode=`"1"`

### Ironsights
- IronSightsPos: `Vector(-3.69, -1, 1.6)`
- IronSightsAng: `Vector(1, 0, 0)`
- IronSightsPos_NYDAR: `Vector(-3.7, -1, 1.03)`
- IronSightTime: `0.3`
- Secondary.IronFOV: `75`

### Spread / Recoil (sawed-off style — widest spread)
- Spread: `.085`, IronAccuracy: `.085` (very wide!)
- KickUp: `1.5`, KickDown: `1.2`, KickHorizontal: `0.65` (highest kicks)
- StaticRecoilFactor: `0.4`
- SpreadMultiplierMax: `3`, SpreadIncrement: `2`, SpreadRecovery: `3`
- ViewModelPunchPitchMultiplier: `0.65`
- ViewModelPunch_MaxVertialOffset: `3`
- ViewModelPunch_VertialMultiplier: `1.5`
- ViewModelPunchYawMultiplier: `0.6`
- IronRecoilMultiplier: `0.8`
- CrouchRecoilMultiplier: `0.9`
- JumpRecoilMultiplier: `2.65`
- WallRecoilMultiplier: `1.25`

### Shells (shotgun-style)
- LuaShellEject: `false`
- LuaShellModel: `"models/entities/tfa_codww2/shells/fx_12gauge.mdl"`
- LuaShellSound: `"TFA_CODWW2_SHELLS.Shotgun"`
- LuaShellScale: `1.2`
- EjectionSmokeEnabled: `false`

### Jamming
- CanJam=true, JamChance=0.03, JamFactor=0.15

### Misc
- MoveSpeed: `0.95`, IronSightsMoveSpeed: `0.76`
- SafetyPos: `Vector(3.2, -2, -1)`
- SafetyAng: `Vector(-17.5, 41.5, -20)`
- TracerCount: `1`
- InspectPos: `Vector(10, -7, -2)`
- AmmoTypeStrings: `{["buckshot"] = "12 Gauge"}`

### Animations
- No `SWEP.Animations` table declared (uses base animations)

### Event Table
| Key | Time | Type | Value |
|---|---|---|---|
| ACT_VM_DRAW_DEPLOYED | 1/30 | sound | `Sound("TFA_CODWW2_MODEL21.FPO")` |
| ACT_VM_DRAW | 5/30 | sound | `Sound("TFA_CODWW2_MODEL21.Draw")` |
| ACT_VM_HOLSTER | 2/30 | sound | `Sound("TFA_CODWW2_MED.Holster")` |
| ACT_VM_RELOAD_EMPTY | 10/30 | sound | `Sound("TFA_CODWW2_MODEL21.EmptyOpen")` |
| ACT_VM_RELOAD_EMPTY | 15/30 | lua | `function(self) self:EventShell() end` (client=true, server=true) |
| ACT_VM_RELOAD_EMPTY | 16/30 | lua | `function(self) self:EventShell() end` (client=true, server=true) — ejects BOTH shells |
| ACT_VM_RELOAD_EMPTY | 40/30 | sound | `Sound("TFA_CODWW2_MODEL21.ShellA")` |
| ACT_VM_RELOAD_EMPTY | 60/30 | sound | `Sound("TFA_CODWW2_MODEL21.ShellB")` |
| ACT_VM_RELOAD_EMPTY | 90/30 | sound | `Sound("TFA_CODWW2_MODEL21.EmptyClose")` |
| ACT_VM_RELOAD | 10/30 | sound | `Sound("TFA_CODWW2_MODEL21.TacOpen")` |
| ACT_VM_RELOAD | 15/30 | lua | `function(self) self:EventShell() end` (client=true, server=true) |
| ACT_VM_RELOAD | 40/30 | sound | `Sound("TFA_CODWW2_MODEL21.TacInsert")` |
| ACT_VM_RELOAD | 75/30 | sound | `Sound("TFA_CODWW2_MODEL21.TacClose")` |
| ACT_VM_FIDGET | 1/30 | sound | `Sound("TFA_CODWW2_MODEL21.Inspect1")` |
| ACT_VM_FIDGET | 50/30 | sound | `Sound("TFA_CODWW2_MODEL21.Inspect2")` |

### Sequence Overrides
**StatusLengthOverride**
- `ACT_VM_RELOAD`: `50/30`
- `ACT_VM_RELOAD_EMPTY`: `70/30`

**SequenceLengthOverride**: `{}` (empty)

**SequenceRateOverride**
- `sprint_in`: `25/30`
- `sprint_loop`: `25/30`

### VElements (8 elements)
- sight_nydar → c_model21_reflex.mdl
- sight_nydar_lens (conditional)
- shell_default → c_model21_clip.mdl (active=true)
- shell_incen → c_model21_clip_incen.mdl
- receiver_default → c_model21_receiver.mdl (active=true)
- barrel_default → c_model21_barrel.mdl (active=true)
- charm_default → c_model21_charm.mdl (active=true)
- stock_default → c_model21_stock.mdl (active=true)
- (NO sights_default, NO scope_acog, NO lens_sight, NO grenade_rail, NO bayonet, NO ext_clip)

### WElements (4 elements)
- receiver_default, barrel_default, stock_default, sight_nydar

### Attachments
| Slot | atts | order |
|---|---|---|
| [2] | `tfa_codww2_nydar` (only!) | 2 |
| [4] | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 4 |
| [5] | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 5 |
| [6] | `tfa_codww2_rapidfire`, **`tfa_codww2_incenshells`** | 6 (NO riflebullet — sawed-off doesn't have rifle mode) |

### Custom Functions
- `SWEP:OnPaP()` → ClipSize=4, Damage=240, NumShots=8, RPM=140, DefaultClip=44, MaxAmmo=40, Automatic=false (stays semi)
- `SWEP:NZMaxAmmo()` — server-only sets ammo
- **NO `SWEP:AttachGrenade()` or `SWEP:DetachGrenade()`**

---

# CROSS-WEAPON SUMMARY TABLES

## Damage / RPM Comparison (base values)

| Weapon | PrintName | RPM | Damage | NumShots | ClipSize | DPS (single) | Automatic |
|---|---|---|---|---|---|---|---|
| Arsenal | Proto-X1 | 750 | 65 | 1 | 24 | 812.5 | true |
| AS-44 | AS-44 | 483 | 112 | 1 | 30 | 902.5 | true |
| AVS-36 | AVS-36 | 441 | 185 | 1 | 24 | 1358.5 | true |
| BAR | BAR | 571 | 130 | 1 | 20 | 1236.8 | true |
| Charlton | NZ-41 | 400 | 170 | 1 | 24 | 1133.3 | true |
| Federov | Automaton | 472 | 125 | 1 | 25 | 983.3 | true |
| FG 42 | FG 42 | 422 | 180 | 1 | 20 | 1266 | true |
| Gewehr 43 | Gewehr 43 | 517 | 40 | 1 | 12 | 344.7 | false |
| M1 Carbine | M1 Carbine | 454 | 50 | 1 | 15 | 378.3 | false |
| M1 Garand | M1 Garand | 525 | 165 | 1 | 8 | 1443.8 | false |
| M2 Carbine | M2 Carbine | 461 | 176 | 1 | 15 | 1352.3 | true |
| M1941 | M1941 | 800 | 124 | 1 | 25 | 1653.3 | true |
| Ribey | Ribeyrolles | 588 | 85 | 1 | 25 | 833.0 | true |
| STG-44 | STG-44 | 666 | 100 | 1 | 30 | 1110.0 | true |
| SVT-40 | SVT-40 | 257 | 200 | 1 | 10 | 856.7 | false |
| Volk | Volkssturmgewehr | 722 | 157 | 1 | 30 | 1889.0 | true |
| Wimmer | Wimmersperg Spz | 520 | 177 | 1 | 25 | 1534.0 | true |
| ITRA Burst | ITRA Burst | 952 (burst) | 151 | 1 | 32 | ~575 (burst) | true (burst) |
| M30 Drilling | M30 Luftwaffe Drilling | 150 | 125 | 8 | 2 | 1000 (per shell × 8) | false |
| Model 21 | Sawed-off Shotgun | 130 | 80 | 8 | 2 | 693.3 (per shell × 8) | false |

## Pack-a-Punch Damage Comparison

| Weapon | NZPaPName | PaP Damage | PaP RPM | PaP NumShots | PaP ClipSize | FireModes on PaP |
|---|---|---|---|---|---|---|
| Arsenal | PR0T0-G3N | 195 | 760 | 2 | 48 | — |
| AS-44 | American Assembled | 336 | 493 | 1 | 45 | — |
| AVS-36 | Vodka Raider | 555 | 451 | 1 | 50 | — |
| BAR | RE-BAR | 390 | 581 | 1 | 45 | — |
| Charlton | nZ+? | 510 | 410 | 2 | 48 | — |
| Federov | Federal Offence | 375 | 482 | 2 | 50 | — |
| FG 42 | Feral Growl 84 | 540 | 452 | 1 | 50 | — |
| Gewehr 43 | Graham Crackers | 120 | 527 | 2 | 25 | — |
| M1 Carbine | Infantry Division | 150 | 464 | 2 | 24 | {"3Burst"} |
| M1 Garand | All American | 495 | 334 | 2 | 24 | {"2Burst"} |
| M2 Carbine | Spray Can | 528 | 661 | 1 | 64 | — |
| M1941 | Magic Johnson | 372 | 810 | 1 | 50 | — |
| Ribey | Baby Back Ribs | 255 | 598 | 2 | 50 | — |
| STG-44 | Gewehr der Zeitalter | 300 | 676 | 2 | 60 | — |
| SVT-40 | Survivor | 600 | 867 | 1 | 25 | — |
| Volk | Letzter Ausweg | 471 | 732 | 1 | 64 | — |
| Wimmer | A Fucking Pipe | 531 | 530 | 2 | 50 | — |
| ITRA Burst | ARTI Auto | 453 | 724 | 2 | 60 | (DisableBurstFire=true, OnlyBurstFire=false) |
| M30 Drilling | Langer Stock | 375 | 160 | 8 | 4 | {"2Burst"} |
| Model 21 | Short Stop | 240 | 140 | 8 | 4 | — |

## Attachment Slot Patterns

### Pattern A: Full rifle with grenade launcher (most common)
Used by: AS-44, AVS-36, BAR, Charlton, Federov, Gewehr 43, M1 Carbine, M1 Garand, M2 Carbine, M1941, STG-44, SVT-40, Volk, Wimmer, ITRA Burst
- Slot [2]: sights (lens_sight, nydar, 4x)
- Slot [3]: xmag
- Slot [4]: bayonet + rifle_grenade (or _ger / _empty variants)
- Slot [5]: rifling, steadyaim
- Slot [6]: stock, quickdraw, grip
- Slot [7]: highcal, rapidfire, fmj

### Pattern B: SMG with suppressor (Arsenal, Ribey)
- Slot [1]: suppressor (UNIQUE)
- Slot [2]: sights (no 4x scope)
- Slot [3]: xmag_ani
- Slot [4]: rifling, steadyaim
- Slot [5]: stock, quickdraw, grip
- Slot [6]: rapidfire, fmj (NO highcal — SMGs can't use highcal)

### Pattern C: Shotgun (M30, Model 21)
- Slot [2]: nydar only (no other sights)
- Slot [4]: rifling, steadyaim
- Slot [5]: stock, quickdraw, grip
- Slot [6]: rapidfire + shotgun-specific (incenshells, riflebullet for M30)

## Bayonet / Grenade Launcher Attachment Variants

| Weapon | Bayonet | Grenade Launcher | Notes |
|---|---|---|---|
| AS-44 | bayonet_empty | rifle_grenade (USA) | |
| AVS-36 | bayonet_empty | rifle_grenade (USA) | |
| BAR | bayonet | rifle_grenade (USA) | |
| Charlton | bayonet | rifle_grenade (USA) | |
| Federov | bayonet | rifle_grenade (USA) | |
| FG 42 | bayonet_empty | rifle_grenade_ger (GER) | German attachments |
| Gewehr 43 | bayonet_empty | rifle_grenade_ger (GER) | German |
| M1 Carbine | bayonet_empty | rifle_grenade (USA) | |
| M1 Garand | bayonet_empty | rifle_grenade (USA) | |
| M2 Carbine | bayonet_empty | rifle_grenade (USA) | |
| M1941 | bayonet_empty | rifle_grenade (USA) | |
| STG-44 | bayonet | rifle_grenade_ger (GER) | German |
| SVT-40 | bayonet_empty | rifle_grenade (USA) | |
| Volk | bayonet | rifle_grenade_ger (GER) | German |
| Wimmer | bayonet | rifle_grenade_ger (GER) | German |
| ITRA Burst | bayonet | rifle_grenade_ger (GER) | German |
| Arsenal | NONE | NONE | No melee/grenade attachments |
| Ribey | NONE | NONE | No melee/grenade attachments |
| M30 | NONE | NONE | No melee/grenade attachments |
| Model 21 | NONE | NONE | No melee/grenade attachments |

`bayonet_empty` means the weapon model has a bayonet lug but the bayonet attachment starts "empty" (no bayonet attached by default). `bayonet` means the weapon model includes a default bayonet that the attachment replaces/removes.

## Notable Quirks / Bugs Found

1. **Federov `IronhSightsAng_GL`** (line 199): Typo — should be `IronSightsAng_GL`. This means the GL ironsight angle is never set on Federov.

2. **ITRA Burst `IronhSightsAng_GL`** (line 202): Same typo as Federov.

3. **Volk `SequenceLengthOverride`** (lines 264-270): `reload_grenade` is defined twice — first as `80/30`, then as `70/30`. The second definition wins (Lua behavior), so effective value is `70/30`.

4. **Wimmer `SequenceLengthOverride`** (lines 256-262): Same duplicate-key bug as Volk — `reload_grenade` defined as `80/30` then `70/30`. Effective value: `70/30`.

5. **SVT-40 `LastAmmoSound`** (line 73): Declared as `SWEP.LastAmmoSound = Sound("")` at top, then overwritten by `SWEP.LastAmmoSound = "TFA.LowAmmo.AssaultRifle_Dry"` later. The second assignment wins.

6. **Gewehr 43 `RegularMoveSpeedMultiplier`** (lines 223-224): Uses `RegularMoveSpeedMultiplier` and `AimingDownSightsSpeedMultiplier` instead of the standard `MoveSpeed` and `IronSightsMoveSpeed`. These are different field names — may or may not be handled by the base, but it's inconsistent with all other rifles.

7. **ITRA Burst `Primary.BurstDelay`** (line 83 vs 108): Set to `0.2` in the primary stats section, then overridden to `nil` in the firemode section. The second assignment wins, so effective value is `nil`. This may be intentional (cleanup) or a leftover.

8. **ITRA Burst `Primary.RPM`**: Not declared explicitly — uses `RPM_Displayed = 952` and `RPM_Burst = 952` instead. The base RPM may default to a different value.

9. **M1 Garand `fire_last_ext` event** (line 396): Uses `Sound("TFA_CODWW2_M1CARB.LastShot")` (M1 Carbine sound) instead of an M1 Garand-specific sound. Likely intentional reuse but worth noting.

10. **M2 Carbine `ViewModelBoneMods`**: Only weapon that defines a ViewModelBoneMods entry (`tag_charm_base`), even though it's a no-op (identity transform).

11. **Ribey EventTable `ACT_VM_PRIMARYATTACK`**: Has unique lua events that update `Bodygroups_V[1]` to `math.Clamp(self:Clip1(),0,18)` — this is a procedural bullet-in-magazine visual that updates on every shot. The clamp to 18 suggests the model has 18 visible bullet bodygroups.

12. **M30 Drilling `DEFINE_BASECLASS( SWEP.Base )`**: Only weapon that explicitly calls `DEFINE_BASECLASS`. This is typically needed when overriding methods that call `BaseClass.Method(self)`, but M30 doesn't appear to override any such methods — may be leftover from a removed feature.

13. **M30 Drilling Secondary Fire**: The only weapon with a functional secondary fire (rifle bullet, 108 damage, SniperPenetratedRound ammo). All other rifles' secondary fire is the bash/melee.

14. **M1 Garand `inspect_grenade` event order**: Uses `Inspect1` → `Inspect2` → `Inspect1b` (different order from all other rifles which use `Inspect1` → `Inspect1b` → `Inspect2`).

15. **Wimmer uses STG44 sounds**: All reload/inspect/charge sounds for Wimmer are `TFA_CODWW2_STG44.*` — Wimmer has no unique sound set, reusing STG-44's.

16. **M1941 `reload_empty` event order**: `Charge` plays at 1/30 (FIRST), then `MagOut` at 25/30, then `MagIn` at 55/30. This is unusual — the charge sound plays before the mag is out. Likely represents the Johnson's side-charging handle being racked first.

17. **Federov `HoldType = "smg"`**: Only "rifle" classified weapon that uses the SMG holdtype. May be intentional (Fedorov was a light automatic rifle) but visually distinct from other rifles.

18. **Volk `inspect_epic` time**: 105/30 = 3.5 seconds — longest epic inspect of any rifle.

---

# ATTACHMENT INVENTORY (all unique attachments referenced)

## Sights
- `tfa_codww2_lens_sight` — lens sight (most rifles)
- `tfa_codww2_nydar` — Nydar reflex sight (most rifles + shotguns)
- `tfa_codww2_4x` — 4x scope (rifles only, not SMGs/shotguns)

## Magazines
- `tfa_codww2_xmag` — extended mag (most rifles)
- `tfa_codww2_xmag_ani` — animated extended mag (Arsenal, Ribey — has bodygroup animations)
- `tfa_codww2_xmag_noani` — non-animated extended mag (Federov, M1 Carbine, M2 Carbine, STG-44, SVT-40, Wimmer)

## Underbarrel
- `tfa_codww2_bayonet` — bayonet (BAR, Charlton, STG-44, Volk, Wimmer, ITRA Burst)
- `tfa_codww2_bayonet_empty` — empty bayonet lug (AS-44, AVS-36, Federov, Gewehr 43, M1 Carbine, M1 Garand, M2 Carbine, M1941, SVT-40)
- `tfa_codww2_rifle_grenade` — USA rifle grenade launcher
- `tfa_codww2_rifle_grenade_ger` — German rifle grenade launcher

## Performance
- `tfa_codww2_rifling` — rifling (accuracy)
- `tfa_codww2_steadyaim` — steady aim (recoil)
- `tfa_codww2_stock` — stock
- `tfa_codww2_quickdraw` — quickdraw
- `tfa_codww2_grip` — grip
- `tfa_codww2_highcal` — high caliber (rifles only)
- `tfa_codww2_rapidfire` — rapid fire (most)
- `tfa_codww2_rapidfire_pg1935` — rapid fire variant (ITRA Burst only)
- `tfa_codww2_fmj` — full metal jacket (penetration)

## Shotgun-specific
- `tfa_codww2_incenshells` — incendiary shells (M30, Model 21)
- `tfa_codww2_riflebullet` — rifle bullet (M30 only — enables secondary fire)

## Suppressor (SMG-rifles only)
- `tfa_codww2_supp` — suppressor (Arsenal, Ribey)

---

# EVENT TABLE PATTERN ANALYSIS

## Standard Rifle Event Pattern (no ext mag)
Used by: STG-44, M1941 (partial), Wimmer (partial)

```
ACT_VM_DRAW_DEPLOYED → FPO sound
ACT_VM_DRAW → RIFLE.Raise
ACT_VM_HOLSTER → RIFLE.Holster
fire/idle/melee → lua DetachGrenade()
reload → TacMagOut, TacMagIn
reload_empty → MagOut, MagIn, Charge
inspect → Inspect1, Inspect2
inspect_epic → EpicInspect1, EpicInspect2
grenade_in → RFLGRND.Foley, lua AttachGrenade(), RFLGRND.On/On2
grenade_out → RFLGRND.Off/Off2, lua DetachGrenade()
```

## Extended Mag Event Pattern
Most rifles with `reload_ext`/`reload_ext_empty` reuse the same TacMagOut/MagOut + TacMagIn/MagIn + Charge sounds as regular reloads. Exceptions:
- **BAR**: Has unique foley variants (`TacMagOutFoley`, `TacMagInFoley`, `MagOutFoley`, `MagInFoley`, `ChargeFoley`)
- **FG 42**: Has unique foley + grab sounds (`TacMagGrabFoley`, `TacMagGrab`, `MagGrabFoley`, `MagGrab`, `MagInFoley`, `ChargeFoley`)
- **Charlton**: Has unique Ext sounds (`ExtTacMagOut`, `ExtTacMagIn`, `ExtMagOut`, `ExtMagIn`, `ExtCharge`)
- **M1 Garand**: Has unique Ext sounds (`TacExtMagOut`, `TacExtMagIn`, `ExtMagOut`, `ExtMagIn`)
- **M1941**: Uses same sounds for ext reloads (no unique ext sounds)

## Grenade Launcher Sound Variants
- **On2/Off2**: AS-44, AVS-36, BAR, Charlton, Federov, M1 Carbine, M1 Garand, M2 Carbine, M1941, SVT-40
- **On/Off** (no "2"): FG 42, Gewehr 43, STG-44, Volk, Wimmer, ITRA Burst

This correlates with the grenade launcher attachment: USA uses On2/Off2, German uses On/Off.

---

# FINAL NOTES

This audit covers all 20 files listed in the task. Every field, function, table, and mechanic present in source has been documented. Key observations:

1. **All 20 files share `SWEP.Base = "tfa_codww2_base"`** — they inherit common behavior from the base.

2. **All 20 files define `SWEP:OnPaP()`** for Pack-a-Punch behavior, modifying `Primary_TFA.*` stats and calling `self:ClearStatCache()`.

3. **All 20 files define `SWEP:NZMaxAmmo()`** with identical implementation (server-side ammo reset).

4. **16 of 20 files define `SWEP:AttachGrenade()` and `SWEP:DetachGrenade()`** — the 4 exceptions are Arsenal, Ribey, M30, and Model 21 (which lack grenade launcher attachments).

5. **16 of 20 files use `SWEP.Primary.Ammo = "ar2"`** — Arsenal and Ribey use `"smg1"`, M30 and Model 21 use `"buckshot"`.

6. **All 20 files use `SWEP.NZHeadShotMultiplier = 2`**.

7. **All 20 files use `SWEP.Primary.Knockback = 0`** and `SWEP.Primary.AmmoConsumption = 1`.

8. **All 20 files set `SWEP.DisableChambering = true`** — no weapon chambers a round from the magazine on reload.

9. **All 20 files set `SWEP.FlashlightAttachment = 0`** — none have a weapon-mounted flashlight.

10. **The ITRA Burst (pg1935) is the only true burst-fire weapon** — `DisableBurstFire = false`, `OnlyBurstFire = true`, `BurstFireCount = 4`. All others are either full-auto or semi-auto.

11. **The M30 Drilling is the only weapon with a functional secondary fire mode** (rifle bullet).

12. **The M1 Garand and M1 Carbine gain burst fire modes on Pack-a-Punch** — `FireModes = {"2Burst"}` and `FireModes = {"3Burst"}` respectively. The M30 Drilling also gains `{"2Burst"}` on PaP.

13. **The ITRA Burst converts FROM burst TO full-auto on Pack-a-Punch** — unique behavior where PaP removes the burst-fire restriction.
