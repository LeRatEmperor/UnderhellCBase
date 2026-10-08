# TFA WWII Pistols & SMGs — Exhaustive Code Audit

**Repository:** `/home/z/my-project/repos/tfa_wwii_original/lua/weapons/`
**Scope:** 8 Pistols + 16 SMGs (24 weapon files total)
**Base class for ALL files:** `SWEP.Base = "tfa_codww2_base"`
**Common author string:** `"Olli, Fox, Mav"`

> All values are reported verbatim from source. Comments after `--` in source
> are retained where useful. `nil` indicates the field is explicitly set to `nil`
> in source. Absence of a field means it is not declared in that weapon file
> (so the base value is inherited from `tfa_codww2_base`).

---

# PISTOLS

---

## 1. 1911 (nz_kate_codww2_1911.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"1911"` |
| Category | `"nZR: WWII Kate Starting Pistols"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFlip | (not declared — inherited) |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/1911/c_1911.mdl"` |
| ViewModel_DW | `"models/weapons/tfa_codww2/1911/c_1911_akimbo.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/1911/w_1911.mdl"` |
| WorldModel_DW | `"models/weapons/tfa_codww2/1911/w_1911.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Colt"` |
| Type_Displayed | `"Pistol"` |
| Purpose | `"High damage semi-automatic pistol with moderate recoil."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPReplacement | `"tfa_vg_mustangsally"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_1911.Main"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_1911.Trans"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_1911.Sub"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_1911.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"pistol"` |
| Primary.Automatic | `false` |
| Primary.RPM | `670` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `10` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `8` |
| Primary.ClipSize_DW | `14` |
| Primary.ClipSize_Ext | `10` |
| Primary.DefaultClip | `SWEP.Primary.ClipSize * 5` (= 40) |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=`false`, range_func=`"linear"`, units=`"meters"`, lut = `{ {range=12,dmg=1}, {range=13,dmg=0.8}, {range=27,dmg=0.8}, {range=28,dmg=0.55} }` |

### Secondary Stats (Bash)
| Field | Value |
|---|---|
| Secondary.BashDamage | `35` |
| Secondary.BashSound | `Sound("TFA_CODWW2_MELEE.SwingPstl")` |
| Secondary.BashHitSound | `Sound("TFA_CODWW2_MELEE.Hit")` |
| Secondary.BashHitSound_Flesh | `Sound("TFA_CODWW2_MELEE.PstlHitPlr")` |
| Secondary.BashLength | `40` |
| Secondary.BashDelay | `0.2` |
| Secondary.BashDamageType | `DMG_CLUB` |
| Secondary.BashInterrupt | `true` |

### Fire Modes
| Field | Value |
|---|---|
| Primary.BurstDelay | `nil` |
| DisableBurstFire | `true` |
| SelectiveFire | `false` |
| OnlyBurstFire | `false` |
| BurstFireCount | `nil` |
| DefaultFireMode | `""` |
| FireModeName | `nil` |

### Shotgun Fields
Not declared (inherits base defaults; `SWEP.Shotgun` not set).

### Ironsights
| Field | Value |
|---|---|
| IronBobMult | `0.065` |
| IronBobMultWalk | `0.065` |
| data | `{}` |
| data.ironsights | `1` |
| IronInSound | `"TFA_CODWW2_PSTL.AdsUp"` |
| IronOutSound | `"TFA_CODWW2_PSTL.AdsDown"` |
| Secondary.IronFOV | `80` |
| IronSightsPos | `Vector(-4.08, -3, 0.8)` |
| IronSightsAng | `Vector(0.8, 0, 0)` |
| IronSightsPos_TAC | `Vector(-4.285, -3, 0.35)` |
| IronSightsAng_TAC | `Vector(0.8, 0, 0)` |
| IronSightTime | `0.2` |
| InspectPos | `Vector(10, -7, -2)` |
| InspectAng | `Vector(24, 42, 16)` |
| InspectPos_DW | `Vector(0, -3, -4)` |
| InspectAng_DW | `Vector(25, 0, 0)` |
| SafetyPos | `Vector(2, -11, -10)` |
| SafetyAng | `Vector(60, 0, 0)` |
| SafetyPos_TAC | `Vector(-1, 1, 2)` |
| SafetyAng_TAC | `Vector(-20, -5, -5)` |
| SafetyPos_DW | `Vector(0, -1, 1)` |
| SafetyAng_DW | `Vector(-15, 0, 0)` |

### Animations Table
| Key | type | value |
|---|---|---|
| reload_ext_knife | TFA.Enum.ANIMATION_SEQ | `"reload_ext_knife"` |
| reload_ext_knife_empty | TFA.Enum.ANIMATION_SEQ | `"reload_ext_knife_empty"` |
| reload_ext | TFA.Enum.ANIMATION_SEQ | `"reload_ext"` |
| reload_ext_empty | TFA.Enum.ANIMATION_SEQ | `"reload_ext_empty"` |

**SprintAnimation:**
- `in`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_in"`, value_empty=`"sprint_in_empty"`
- `loop`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_loop"`, value_empty=`"sprint_loop_empty"`, is_idle=`true`
- `out`: type=`TFA.Enum.ANIMATION_SEQ`, value=`"sprint_out"`, value_empty=`"sprint_out_empty"`

### Event Table
All entries are `"sound"` type with `Sound(...)` values. (No `"lua"` entries.)

| Key | Entries (time, value) |
|---|---|
| ACT_VM_DRAW | 2/30 → `TFA_CODWW2_PSTL.Raise` |
| ACT_VM_DRAW_EMPTY | 2/30 → `TFA_CODWW2_PSTL.Raise` |
| ACT_VM_HOLSTER | 2/30 → `TFA_CODWW2_PSTL.Holster` |
| ACT_VM_HOLSTER_EMPTY | 2/30 → `TFA_CODWW2_PSTL.Holster` |
| `"fire_last"` | 1/30 → `TFA_CODWW2_1911.MechEmpty` |
| `"reload"` | 10/30 → `TFA_CODWW2_1911.TacMagOut` ; 25/30 → `TFA_CODWW2_1911.TacMagIn` |
| `"reload_empty"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` ; 45/30 → `TFA_CODWW2_1911.Charge` |
| `"inspect"` | 1/30 → `TFA_CODWW2_1911.Inspect1` ; 50/30 → `TFA_CODWW2_1911.Inspect2` |
| `"inspect_empty"` | 1/30 → `TFA_CODWW2_1911.Inspect1` ; 50/30 → `TFA_CODWW2_1911.Inspect2` |
| `"inspect_epic"` | 1/30 → `TFA_CODWW2_1911.EpicInspect1` ; 45/30 → `TFA_CODWW2_1911.EpicInspect2` |
| `"draw_midempty_dw"` | 1/30 → `TFA_CODWW2_PSTL.Raise` |
| `"holster_midempty_dw"` | 1/30 → `TFA_CODWW2_PSTL.Holster` |
| `"reload_dw"` | 10/30 → `...TacMagOut_R` ; 15/30 → `...TacMagOut_L` ; 35/30 → `...TacMagIn_R` ; 40/30 → `...TacMagIn_L` |
| `"reload_midempty_dw"` | (same as reload_dw) + 62/30 → `TFA_CODWW2_1911.Charge_R` |
| `"reload_empty_dw"` | 10/30 → `...MagOut_L` ; 15/30 → `...MagOut_R` ; 35/30 → `...MagIn_L` ; 40/30 → `...MagIn_R` ; 60/30 → `...Charge_L` ; 62/30 → `...Charge_R` |
| `"inspect_midempty"` | 1/30 → `TFA_CODWW2_1911.Inspect1` ; 50/30 → `TFA_CODWW2_1911.Inspect2` |
| ACT_VM_FIDGET_SILENCED | 1/30 → `TFA_CODWW2_1911.EpicInspect1` ; 45/30 → `TFA_CODWW2_1911.EpicInspect2` |
| `"draw_knife"` | 2/30 → `TFA_CODWW2_PSTL.Raise` |
| `"draw_knife_empty"` | 2/30 → `TFA_CODWW2_PSTL.Raise` |
| `"holster_knife"` | 2/30 → `TFA_CODWW2_PSTL.Holster` |
| `"holster_knife_empty"` | 2/30 → `TFA_CODWW2_PSTL.Holster` |
| `"reload_knife"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` |
| `"reload_knife_empty"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` ; 45/30 → `TFA_CODWW2_1911.Charge` |
| `"inspect_knife"` | 1/30 → `TFA_CODWW2_1911.Inspect1` ; 55/30 → `TFA_CODWW2_1911.Inspect2` |
| `"inspect_knife_empty"` | 1/30 → `TFA_CODWW2_1911.Inspect1` ; 55/30 → `TFA_CODWW2_1911.Inspect2` |
| `"reload_ext"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` |
| `"reload_ext_empty"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` ; 45/30 → `TFA_CODWW2_1911.Charge` |
| `"reload_ext_knife"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` |
| `"reload_ext_knife_empty"` | 10/30 → `TFA_CODWW2_1911.MagOut` ; 25/30 → `TFA_CODWW2_1911.MagIn` ; 45/30 → `TFA_CODWW2_1911.Charge` |

### Sequence Overrides
**StatusLengthOverride:** reload=`35/30`, reload_empty=`35/30`, reload_dw=`35/30`, reload_empty_dw=`35/30`, reload_midempty_dw=`35/30`, reload_knife=`35/30`, reload_knife_empty=`35/30`, reload_ext=`35/30`, reload_ext_empty=`35/30`, reload_ext_knife=`35/30`, reload_ext_knife_empty=`35/30`.

**SequenceRateOverride:** draw=`45/30`, draw_empty=`45/30`, holster=`45/30`, holster_empty=`45/30`, draw_knife=`45/30`, draw_knife_empty=`45/30`, holster_knife=`45/30`, holster_knife_empty=`45/30`.

**SequenceLengthOverride:** not present.

### Bodygroups / Skins
Not declared (inherited).

### VElements
| name | model | bone | pos | angle | size | skin | bonemerge | active |
|---|---|---|---|---|---|---|---|---|
| suppressor | `models/weapons/tfa_codww2/attachments/suppressors/c_pistol_suppressor.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| tac_knife | `models/weapons/tfa_codww2/attachments/tacknife/c_combatknife.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| clip_default | `models/weapons/tfa_codww2/1911/c_1911_clip.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | true |
| ext_clip | `models/weapons/tfa_codww2/1911/c_1911_clip_ext.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| grip_default | `models/weapons/tfa_codww2/1911/c_1911_grip.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | true |
| receiver_default | `models/weapons/tfa_codww2/1911/c_1911_receiver.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | true |
| slide_default | `models/weapons/tfa_codww2/1911/c_1911_slide.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | true |
| clip_left | `models/weapons/tfa_codww2/1911/c_1911_clip_l.mdl` | tag_clip1 | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| grip_left | `models/weapons/tfa_codww2/1911/c_1911_grip_l.mdl` | tag_weapon1 | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| receiver_left | `models/weapons/tfa_codww2/1911/c_1911_receiver_l.mdl` | tag_weapon1 | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |
| slide_left | `models/weapons/tfa_codww2/1911/c_1911_slide_l.mdl` | tag_weapon1 | V(0,0,0) | A(0,0,0) | V(1,1,1) | 0 | true | false |

(All entries: type=`"Model"`, rel=`""`, color=Color(255,255,255,255), surpresslightning=false, material=`""`, bodygroup=`{}`.)

### WElements
| name | model | bone | pos | angle | bonemerge | active |
|---|---|---|---|---|---|---|
| suppressor | `models/weapons/tfa_codww2/attachments/suppressors/w_pistol_suppressor.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | false |
| tac_knife | `models/weapons/tfa_codww2/attachments/tacknife/w_combatknife.mdl` | ValveBiped.Bip01_L_Hand | V(3,1.5,0) | A(-20,90,0) | false | false |
| clip_default | `models/weapons/tfa_codww2/1911/w_1911_clip.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | true | true |
| ext_clip | `models/weapons/tfa_codww2/1911/w_1911_clip_ext.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | true | false |
| grip_default | `models/weapons/tfa_codww2/1911/w_1911_grip.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | true |
| receiver_default | `models/weapons/tfa_codww2/1911/w_1911_receiver.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | true |
| slide_default | `models/weapons/tfa_codww2/1911/w_1911_slide.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | true |
| gun_left | `models/weapons/tfa_codww2/1911/w_1911_l.mdl` | ValveBiped.Bip01_L_Hand | V(15.5,1.2,4) | A(0,0,0) | false | false |

### Attachments
| Slot | atts | order |
|---|---|---|
| 1 | `tfa_codww2_supp_pistol` | 1 |
| 2 | `tfa_codww2_knife` | 2 |
| 3 | `tfa_codww2_xmag` | 3 |
| 4 | `tfa_codww2_rifling`, `tfa_codww2_steadyaim`, `tfa_codww2_quickdraw` | 4 |
| 5 | `tfa_codww2_highcal`, `tfa_codww2_fmj` | 5 |
| 6 | `tfa_codww2_akimbo` | 6 |

**AttachmentExclusions:** `tfa_codww2_akimbo` excludes slots 1, 2, 3 (supp, knife, xmag).

### Miscellaneous
| Field | Value |
|---|---|
| CameraAttachmentOffsets | `{}` |
| CameraAttachmentScale | `2` |
| MuzzleAttachment | `"1"` |
| MuzzleAttachmentSilenced | `"2"` |
| VMPos | `Vector(0, -2.5, 0)` |
| VMAng | `Vector(0, 0, 0)` |
| VMPos_Additive | `true` |
| Offset.Pos | Up=`-6.3`, Right=`1`, Forward=`14.9` |
| Offset.Ang | Up=`180`, Right=`190`, Forward=`0` |
| Offset.Scale | `1.1` |
| ViewModelPunchPitchMultiplier | `0.5` |
| ViewModelPunchPitchMultiplier_IronSights | `0.09` |
| ViewModelPunch_MaxVertialOffset | `3` |
| ViewModelPunch_MaxVertialOffset_IronSights | `1.95` |
| ViewModelPunch_VertialMultiplier | `1` |
| ViewModelPunch_VertialMultiplier_IronSights | `0.25` |
| ViewModelPunchYawMultiplier | `0.6` |
| ViewModelPunchYawMultiplier_IronSights | `0.25` |
| ChangeStateRecoilMultiplier | `1.3` |
| CrouchRecoilMultiplier | `0.65` |
| JumpRecoilMultiplier | `1.65` |
| WallRecoilMultiplier | `1.1` |
| Primary.Spread | `.02` |
| Primary.IronAccuracy | `.01` |
| IronRecoilMultiplier | `0.7` |
| Primary.KickUp | `0.5` |
| Primary.KickDown | `0.3` |
| Primary.KickHorizontal | `0.15` |
| Primary.StaticRecoilFactor | `0.5` |
| Primary.SpreadMultiplierMax | `4` |
| Primary.SpreadIncrement | `1.5` |
| Primary.SpreadRecovery | `5` |
| ChangeStateAccuracyMultiplier | `1.5` |
| CrouchAccuracyMultiplier | `1` |
| JumpAccuracyMultiplier | `3.0` |
| WalkAccuracyMultiplier | `1.35` |
| LuaShellEject | `true` |
| LuaShellEffect | `"ShellEject"` |
| LuaShellModel | `"models/entities/tfa_codww2/shells/fx_9mm.mdl"` |
| LuaShellSound | `"TFA_CODWW2_SHELLS.Small"` |
| LuaShellScale | `1.2` |
| LuaShellEjectDelay | `0` |
| ShellAttachment | `"0"` |
| EjectionSmokeEnabled | `true` |
| CanJam | `true` |
| JamChance | `0.02` |
| JamFactor | `0.08` |
| AmmoTypeStrings | `{["pistol"] = ".45 ACP"}` |
| FireModeSound | `"TFA_CODWW2_GEN.Switch"` |
| Primary.PickupSound | `"TFA_CODWW2_PICKUP.Ammo"` |
| MoveSpeed | `1` |
| IronSightsMoveSpeed | `SWEP.MoveSpeed * 0.8` (0.8) |
| TracerCount | `1` |
| DInv2_GridSizeX | `2` |
| DInv2_GridSizeY | `2` |
| DInv2_Volume | `nil` |
| DInv2_Mass | `1.5` |
| AllowViewAttachment | `true` |
| Sprint_Mode | `TFA.Enum.LOCOMOTION_HYBRID` |
| Sights_Mode | `TFA.Enum.LOCOMOTION_HYBRID` |
| Idle_Mode | `TFA.Enum.IDLE_BOTH` |
| Idle_Blend | `0.25` |
| Idle_Smooth | `0.05` |
| SprintBobMult | `0.5` |
| ViewModelBoneMods | `{}` |
| AttachmentDependencies | `{}` |
| AttachmentTableOverride | `{}` |
| AttachmentIconOverride | `{}` |

### Custom Functions
None defined in this file (no `SWEP:Initialize`, `SWEP:Think`, `SWEP:Deploy`, `SWEP:NZMaxAmmo`, `SWEP:OnPaP`, `SWEP:ShootBullet`).

---

## 2. 1911 Upgraded — "Bacon & Eggs" (nz_kate_codww2_1911_upgraded.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | (not declared — inherits base; PrintName absent) |
| Category | `"nZR: WWII Kate Upgrades"` |
| SubCategory | (not declared — inherits base) |
| Slot | `1` |
| Spawnable | `true` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/1911/c_1911.mdl"` |
| ViewModel_DW | `"models/weapons/tfa_codww2/1911/c_1911_akimbo.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/1911/w_1911.mdl"` |
| WorldModel_DW | `"models/weapons/tfa_codww2/1911/w_1911_akimbo.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Colt"` |
| Type_Displayed | `"Pistol"` |
| Purpose | `"High damage semi-automatic pistol with moderate recoil."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Bacon & Eggs"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_1911.Main"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_1911.Trans"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_1911.Sub"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_1911.PapFlux"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_1911.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"pistol"` |
| Primary.Automatic | `false` |
| Primary.RPM | `680` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.Damage | `1115` |
| Primary.Knockback | `25` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `7` |
| Primary.ClipSize_DW | `16` |
| Primary.DefaultClip | `SWEP.Primary.ClipSize * 7` (= 49) |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"hu"`, lut=`{{range=150, damage=1}}` |

**Projectile section (unique to upgraded variant):**
| Field | Value |
|---|---|
| Primary.Projectile | `"codww2_mustang_exp"` |
| Primary.ProjectileVelocity | `13330` |
| Primary.ProjectileModel | `"models/weapons/tfa_codww2/attachments/usa_rifle_grenade/grenade_proj.mdl"` |

### Secondary Stats (Bash)
Identical to 1911 pistol: BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingPstl")`, BashHitSound=`Sound("TFA_CODWW2_MELEE.Hit")`, BashHitSound_Flesh=`Sound("TFA_CODWW2_MELEE.PstlHitPlr")`, BashLength=`40`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`""`, FireModeName=`nil`.

### Shotgun Fields
Not declared.

### Ironsights
Identical to 1911 base pistol: IronSightsPos=`Vector(-4.08, -3, 0.8)`, IronSightsAng=`Vector(0.8, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.35)`, IronSightsAng_TAC=`Vector(0.8, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`, IronBobMult=`0.065`, IronBobMultWalk=`0.065`, data.ironsights=`1`.

InspectPos=`Vector(10, -7, -2)`, InspectAng=`Vector(24, 42, 16)`, InspectPos_DW=`Vector(0, -3, -4)`, InspectAng_DW=`Vector(25, 0, 0)`.
SafetyPos=`Vector(2, -11, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`, SafetyPos_DW=`Vector(0, -1, 1)`, SafetyAng_DW=`Vector(-15, 0, 0)`.

### Animations Table
Empty: `SWEP.Animations = {}` (no entries).

### Event Table
Identical set of events to the base 1911 pistol (ACT_VM_DRAW, ACT_VM_DRAW_EMPTY, ACT_VM_HOLSTER, ACT_VM_HOLSTER_EMPTY, fire_last, reload, reload_empty, inspect, inspect_empty, inspect_epic, draw_midempty_dw, holster_midempty_dw, reload_dw, reload_midempty_dw, reload_empty_dw, inspect_midempty, ACT_VM_FIDGET_SILENCED). All `"sound"` type. No `"lua"` entries. **Note:** this upgraded variant does NOT include the `reload_knife` / `inspect_knife` / `reload_ext*` events (they were omitted vs the base pistol's EventTable).

### Sequence Overrides
**StatusLengthOverride:** reload=`35/30`, reload_empty=`35/30`, reload_dw=`35/30`, reload_empty_dw=`35/30`, reload_midempty_dw=`35/30`.

**SequenceRateOverride:** draw=`45/30`, draw_empty=`45/30`, draw_midempty_dw=`45/30`, holster=`45/30`, holster_empty=`45/30`, holster_midempty_dw=`45/30`.

**SequenceLengthOverride:** not present.

### Bodygroups / Skins
Not declared.

### VElements
Identical to base 1911 EXCEPT the "_left" akimbo body parts (clip_left, grip_left, receiver_left, slide_left) are set to `active = true` (vs `false` on base). Standard set: suppressor, tac_knife, clip_default (active=true), ext_clip (active=false), grip_default (active=true), receiver_default (active=true), slide_default (active=true), and the four `_left` akimbo elements all set active=true. (Same models & bones as base 1911.)

### WElements
Standard set: suppressor (active=false), tac_knife (active=false), clip_default (active=true), ext_clip (active=false), grip_default (active=true), receiver_default (active=true), slide_default (active=true). **No gun_left entry** (versus base 1911 which has gun_left).

### Attachments
Only one slot declared:
- `[6] = {atts = {"tfa_codww2_akimbo"}, order = 6, sel = 1, default = "tfa_codww2_akimbo"}`

AttachmentExclusions: `{}` (empty).

### Miscellaneous
Identical to base 1911 EXCEPT:
- `TracerName = "pap_laz_tra"`
- `MuzzleFlashEffect = "pap_laz_muz"`
- VMPos=`Vector(0, -2.5, 0)` (same)
- Offset.Pos = Up=`-5.5`, Right=`1.5`, Forward=`15.5`; Offset.Ang = Up=`-90`, Right=`180`, Forward=`5`; Scale=`1.1`
- All other fields (recoil multipliers, spread, jamming, etc.) identical to base 1911.

### Custom Functions
`DEFINE_BASECLASS(SWEP.Base)` is declared and a **custom `SWEP:ShootBullet`** is defined:

```lua
function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
    if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
    num_bullets = num_bullets or 1
    aimcone = 3
    -- SERVER only: creates ents.Create(self:GetStat("Primary.Projectile"))
    -- Spawns one entity per num_bullets, sets owner/angles/damage/velocity,
    -- optionally sets Primary.ProjectileModel.
end
```
This converts the upgraded 1911 into a projectile launcher firing `codww2_mustang_exp` entities at 13330 HU/s with a fixed aimcone of 3.

---

## 3. P08 Luger (nz_kate_codww2_luger.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"P08"` |
| Category | `"nZR: WWII Kate Starting Pistols"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `true` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/luger/c_luger.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/luger/w_luger.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"DWM"` |
| Type_Displayed | `"Pistol"` |
| Purpose | `"Fast firing semi-automatic pistol with low recoil."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"P.O.S."` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_LUGER.Mid"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_LUGER.Low"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_SHGN.Trans"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_LUGER.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"pistol"` |
| Primary.Automatic | `false` |
| Primary.RPM | `670` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `10` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `8` |
| Primary.ClipSize_Ext | `12` |
| Primary.DefaultClip | `88` |
| Primary.MaxAmmo | `80` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=36,dmg=1}, {range=39,dmg=0.5}}` |

### Secondary Stats (Bash)
Same as 1911 pistol: BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingPstl")`, BashHitSound=`Sound("TFA_CODWW2_MELEE.Hit")`, BashHitSound_Flesh=`Sound("TFA_CODWW2_MELEE.PstlHitPlr")`, BashLength=`40`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
All defaults: BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`""`, FireModeName=`nil`.

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-4.07, -3, 0.8)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.3)`, IronSightsAng_TAC=`Vector(0, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`, IronInSound=`"TFA_CODWW2_PSTL.AdsUp"`, IronOutSound=`"TFA_CODWW2_PSTL.AdsDown"`, IronBobMult=`0.065`, IronBobMultWalk=`0.065`.
InspectPos=`Vector(10, -7, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(2, -11, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`.

### Animations Table
Same 4 entries as 1911: reload_ext_knife, reload_ext_knife_empty, reload_ext, reload_ext_empty (all `TFA.Enum.ANIMATION_SEQ`, matching string values).

### Event Table
- ACT_VM_DRAW, ACT_VM_DRAW_EMPTY, ACT_VM_HOLSTER, ACT_VM_HOLSTER_EMPTY — 2/30 → PSTL.Raise / PSTL.Holster
- ACT_VM_RELOAD — 5/30 → `TFA_CODWW2_LUGER.TacMagOut`; 25/30 → `TFA_CODWW2_LUGER.TacMagIn`
- ACT_VM_RELOAD_EMPTY — 5/30 → `MagOut`; 25/30 → `MagIn`; 40/30 → `Charge`
- ACT_VM_FIDGET — 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"` — same as ACT_VM_FIDGET
- `"draw_knife"`, `"draw_knife_empty"`, `"holster_knife"`, `"holster_knife_empty"` — 2/30 PSTL.Raise/Holster
- `"reload_knife"` — 5/30 MagOut; 25/30 MagIn
- `"reload_knife_empty"` — 5/30 MagOut; 25/30 MagIn; 40/30 Charge
- `"inspect_knife"`, `"inspect_knife_empty"` — 1/30 Inspect1; 55/30 Inspect2
- `"reload_ext"` — 5/30 MagOut; 25/30 MagIn
- `"reload_ext_empty"` — 5/30 MagOut; 25/30 MagIn; 40/30 Charge
- `"reload_ext_knife"` — 5/30 MagOut; 25/30 MagIn
- `"reload_ext_knife_empty"` — 5/30 MagOut; 25/30 MagIn; 40/30 Charge

All entries `"sound"` type. No `"lua"` events.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_knife=`35/30`, reload_knife_empty=`35/30`, reload_ext=`35/30`, reload_ext_empty=`35/30`, reload_ext_knife=`35/30`, reload_ext_knife_empty=`35/30`.

**SequenceRateOverride:** ACT_VM_DRAW=`45/30`, ACT_VM_DRAW_EMPTY=`45/30`, ACT_VM_HOLSTER=`45/30`, ACT_VM_HOLSTER_EMPTY=`45/30`, draw_knife=`45/30`, draw_knife_empty=`45/30`, holster_knife=`45/30`, holster_knife_empty=`45/30`.

**SequenceLengthOverride:** not present.

### Bodygroups / Skins
Not declared.

### VElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_hub23_suppressor_pistol.mdl` | tag_weapon | false |
| tac_knife | `tacknife/c_combatknife.mdl` | tag_weapon | false |
| clip_default | `luger/c_luger_clip.mdl` | tag_clip | true |
| ext_clip | `luger/c_luger_clip_ext.mdl` | tag_clip | false |
| grip_default | `luger/c_luger_grip.mdl` | tag_weapon | true |
| receiver_default | `luger/c_luger_receiver.mdl` | tag_weapon | true |
| slide_default | `luger/c_luger_slide.mdl` | tag_weapon | true |

(All pos=V(0,0,0), angle=A(0,0,0), size=V(1,1,1), color=Color(255,255,255,255), bonemerge=true, skin=0, bodygroup=`{}`.)

### WElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_hub23_suppressor_pistol.mdl` | tag_weapon | false |
| tac_knife | `tacknife/w_combatknife.mdl` | ValveBiped.Bip01_L_Hand (pos V(3,1.5,0), ang A(-20,90,0), bonemerge=false) | false |
| clip_default | `luger/w_luger_clip.mdl` | tag_weapon (NOTE: bone is tag_weapon, not tag_clip) | true |
| ext_clip | `luger/w_luger_clip_ext.mdl` | tag_weapon | false |
| grip_default | `luger/w_luger_grip.mdl` | tag_weapon | true |
| receiver_default | `luger/w_luger_receiver.mdl` | tag_weapon | true |
| slide_default | `luger/w_luger_slide.mdl` | tag_weapon | true |

### Attachments
1: `tfa_codww2_supp_pistol` (order 1)
2: `tfa_codww2_knife` (order 2)
3: `tfa_codww2_xmag` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim`, `tfa_codww2_quickdraw` (order 4)
5: `tfa_codww2_highcal`, `tfa_codww2_fmj` (order 5)

No AttachmentExclusions entries.

### Miscellaneous
Same defaults as 1911 pistol except: VMPos=`Vector(0, 0, 0)`, IronRecoilMultiplier=`0.6` (vs 0.7 on 1911), Primary.KickDown=`0.2`, Primary.KickHorizontal=`0.1`, AmmoTypeStrings=`{["pistol"] = "9x19 Parabellum"}`, DInv2_Mass=`0.5`, TracerCount=`3`, LuaShellScale=`1.2`.

### Custom Functions
**`SWEP:OnPaP()`** — Sets `Ispackapunched=true`, `MuzzleFlashEffect="muz_pap"`, then mutates `Primary_TFA`: ClipSize=16, Damage=835, NumShots=2, RPM=680, DefaultClip=176, MaxAmmo=160, Automatic=true, and sets `self.FireModes = {"2Burst"}` (forcing 2-round burst mode after PaP). Calls `self:ClearStatCache()` and returns `true`.

**`SWEP:NZMaxAmmo()`** — Server-side only; sets owner's ammo to `Primary.MaxAmmo` (80) and clip1 to `Primary.ClipSize` (8).

---

## 4. Machine Pistol / M712 (nz_kate_codww2_m712.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"Machine Pistol"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/m712/c_m712.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m712/w_m712.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Mauser"` |
| Type_Displayed | `"Machine Pistol"` |
| Purpose | `"Full-auto machine pistol that offers a quick damage output."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Zuverlässige Seitenwaffe"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_PPSH.NPC.Med"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_MG42.Rear"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_TYPE100.Punch"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_MG42.Mech.Punch"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_M712.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"pistol"` |
| Primary.Automatic | `true` |
| Primary.RPM | `722` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `186` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `10` |
| Primary.ClipSize_Ext | `15` |
| Primary.DefaultClip | `110` |
| Primary.MaxAmmo | `100` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=5,dmg=1}, {range=6,dmg=0.8}, {range=25,dmg=0.8}, {range=26,dmg=0.61}}` |

### Secondary Stats (Bash)
Same as 1911 (BashDamage=35, BashLength=40, etc.).

### Fire Modes
All defaults (BurstDelay=nil, DisableBurstFire=true, etc.).

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-5.07, -3, 1.65)`, IronSightsAng=`Vector(0.4, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.38)`, IronSightsAng_TAC=`Vector(0.4, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`. InspectPos=`Vector(10, -7, -2)`. SafetyPos=`Vector(2, -13.5, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`.

### Animations Table
Same 4 entries as 1911 (reload_ext_knife, reload_ext_knife_empty, reload_ext, reload_ext_empty).

### Event Table
- ACT_VM_DRAW / DRAW_EMPTY / HOLSTER / HOLSTER_EMPTY: 2/30 PSTL.Raise/Holster
- ACT_VM_RELOAD: 5/30 → `TFA_CODWW2_M712.TacMagOut`; 20/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 20/30 → `MagIn`; 40/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"`: same as FIDGET
- draw_knife/_empty, holster_knife/_empty: 2/30 PSTL.Raise/Holster
- reload_knife: 5/30 MagOut; 20/30 MagIn
- reload_knife_empty: +40/30 Charge
- inspect_knife, inspect_knife_empty: 1/30 Inspect1; 55/30 Inspect2
- reload_ext, reload_ext_knife: 5/30 MagOut; 20/30 MagIn
- reload_ext_empty, reload_ext_knife_empty: +40/30 Charge

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`30/30`, ACT_VM_RELOAD_EMPTY=`30/30`, reload_knife=`30/30`, reload_knife_empty=`30/30`, reload_ext=`30/30`, reload_ext_empty=`30/30`, reload_ext_knife=`30/30`, reload_ext_knife_empty=`30/30`.

**SequenceRateOverride:** ACT_VM_DRAW=`45/30`, ACT_VM_DRAW_EMPTY=`45/30`, ACT_VM_HOLSTER=`45/30`, ACT_VM_HOLSTER_EMPTY=`45/30`, draw_knife=`45/30`, draw_knife_empty=`45/30`, holster_knife=`45/30`, holster_knife_empty=`45/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_hub23_suppressor_pistol.mdl` | tag_weapon | false |
| tac_knife | `tacknife/c_combatknife.mdl` | tag_weapon | false |
| clip_default | `m712/c_m712_clip.mdl` | tag_clip | true |
| ext_clip | `m712/c_m712_clip_ext.mdl` | tag_clip | false |
| grip_default | `m712/c_m712_grip.mdl` | tag_weapon | true |
| receiver_default | `m712/c_m712_receiver.mdl` | tag_weapon | true |
| barrel_default | `m712/c_m712_barrel.mdl` | tag_weapon | true |

### WElements
Same 7-element set as VElements (using w_m712_*.mdl models), with tac_knife using `ValveBiped.Bip01_L_Hand` (bonemerge=false, pos V(3,1.5,0), ang A(-20,90,0)).

### Attachments
Same 5-slot layout as Luger (supp_pistol, knife, xmag, rifling/steadyaim/quickdraw, highcal/fmj).

### Miscellaneous
AmmoTypeStrings=`{["pistol"] = "7.63×25mm Mauser"}`, DInv2_Mass=`0.5`, TracerCount=`3`, Primary.KickUp=`0.3`, KickDown=`0.25`, KickHorizontal=`0.1`, SpreadIncrement=`1` (vs 1.5 on semi-autos), IronRecoilMultiplier=`0.6`, VMPos=`Vector(0, -2, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Sets Ispackapunched=true, MuzzleFlashEffect="muz_pap". Primary_TFA: ClipSize=50, Damage=558, NumShots=1, RPM=732, DefaultClip=550, MaxAmmo=500, Automatic=true. ClearStatCache, return true.

**`SWEP:NZMaxAmmo()`** — standard pattern (server-only, sets ammo to MaxAmmo and clip to ClipSize).

---

## 5. Nambu Type 2 (nz_kate_codww2_nambu.lua)

> **Note:** This file is catalogued in the source list as a pistol, but its SubCategory is `"Submachine Guns"`, HoldType=`"ar2"`, Type_Displayed=`"Submachine Gun"`, Slot=`2`, Ammo=`"smg1"`. The classification mismatch is preserved verbatim.

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"Nambu Type 2"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Submachine Guns"` |
| Slot | `2` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/nambu/c_nambu.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/nambu/w_nambu.mdl"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Nambu"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with low recoil, moderate fire rate and mid range combat capabilities."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Sleeping Dragon"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_VOLK.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_VOLK.Main"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_BM38.Thump"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_BM38.Sub"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_VOLK.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `769` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `726` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `78` |
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
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=15,dmg=1}, {range=17,dmg=0.85}, {range=24,dmg=0.85}, {range=27,dmg=0.65}}` |

### Secondary Stats (Bash)
BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashHitSound=`Sound("TFA_CODWW2_MELEE.Hit")`, BashHitSound_Flesh=`Sound("TFA_CODWW2_MELEE.HitPlr")`, BashLength=`45`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`"1"`, FireModeName=`nil`.

### LowAmmo Sound
| Field | Value |
|---|---|
| FireSoundAffectedByClipSize | `true` |
| LowAmmoSoundThreshold | `0.33` |
| LowAmmoSound | `"TFA.LowAmmo.SMG"` |
| LastAmmoSound | `"TFA.LowAmmo.SMG_Dry"` |

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-2.8, -1, 1.01)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-2.81, -1, -0.16)`, IronSightsAng_NYDAR=`Vector(0, 0, 0)`, IronSightsPos_LENS=`Vector(-2.798, 0, 0.87)`, IronSightsAng_LENS=`Vector(0, 0, 0)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`, IronInSound=`"TFA_CODWW2_GEN.AdsUp"`, IronOutSound=`"TFA_CODWW2_GEN.AdsDown"`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_NAMBU.FPOCharge`
- ACT_VM_DRAW: 1/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `TFA_CODWW2_NAMBU.TacMagOut`; 40/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 35/30 → `MagIn`; 70/30 → `Charge`
- `"inspect"`: 1/30 Inspect1; 50/30 Inspect2
- `"inspect_empty"`: same as inspect
- `"inspect_epic"`: same as inspect (no epic-specific sounds)
- `"suppressor_attach"`: 1/30 → `TFA_CODWW2_PPSH.SuppOn`
- `"suppressor_remove"`: 1/30 → `TFA_CODWW2_PPSH.SuppOff`

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

**SequenceLengthOverride:** ACT_VM_DRAW=`30/30`, ACT_VM_DRAW_EMPTY=`30/30`, ACT_VM_DRAW_DEPLOYED=`55/30`, ACT_VM_RELOAD=`75/30`, ACT_VM_RELOAD_EMPTY=`105/30`.

**SequenceRateOverride:** not present.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `nambu/c_nambu_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional: `(TFA.CODWW2 and TFA.CODWW2.GetHoloSightReticle) and TFA.CODWW2.GetHoloSightReticle("sight_nydar") or nil` |
| lens_sight | `attachments/sights/c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `attachments/suppressors/c_suppressor_hub23.mdl` | tag_weapon | false |
| clip_default | `nambu/c_nambu_clip.mdl` | tag_clip | true |
| ext_clip | `nambu/c_nambu_clip_ext.mdl` | tag_clip | false |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false (bodygroup=`{[0] = 1}`) |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `nambu/w_nambu_clip.mdl`, tag_clip, true
- ext_clip: `nambu/w_nambu_clip_ext.mdl`, tag_clip, false
- sight_nydar: `nambu/w_nambu_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "8×22mm Nambu"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1` (vs 1.2 on pistols), ViewModelPunch_MaxVertialOffset=`2.5` (vs 3 on pistols), IronRecoilMultiplier=`0.7`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI` (not HYBRID), SprintBobMult=`0`, VMPos=`Vector(0, -1, 0)`. Knockback not explicitly set (inherits base).

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=60, Damage=234, NumShots=1, RPM=779, DefaultClip=660, MaxAmmo=600, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard pattern (server-only, MaxAmmo=300).

---

## 6. Enfield No. 2 (nz_kate_codww2_no2.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"Enfield No. 2"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/no2/c_no2.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/no2/w_no2.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Enfield"` |
| Type_Displayed | `"Revolver"` |
| Purpose | `"Revolver with high damage and high recoil."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Break Action"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_NO2.High"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_NO2.Mid"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_NO2.Low"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_NO2.Thump"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_NO2.Mech"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_SHGN.Trans"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_NO2.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"357"` |
| Primary.Automatic | `false` |
| Primary.RPM | `285` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `800` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `6` |
| Primary.ClipSize_Ext | `8` |
| Primary.DefaultClip | `66` |
| Primary.MaxAmmo | `60` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=36,dmg=1}, {range=39,dmg=0.6}}` |

### Secondary Stats (Bash)
Same as 1911 (BashDamage=35, BashLength=40, DMG_CLUB, etc.).

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`""`, FireModeName=`"Double-Action"` (unique to No.2).

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-4.725, -3, 1.2)`, IronSightsAng=`Vector(0.4, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.49)`, IronSightsAng_TAC=`Vector(-0.2, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`. InspectPos=`Vector(10, -7, -2)`. SafetyPos=`Vector(2, -11, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`.

### Animations Table
Not declared (`SWEP.Animations` absent).

### Event Table
- ACT_VM_DRAW: 2/30 PSTL.Raise
- ACT_VM_HOLSTER: 2/30 PSTL.Holster
- ACT_VM_RELOAD: 10/30 → `TFA_CODWW2_NO2.Open`; 35/30 → `Insert`; 45/30 → `Close`
- ACT_VM_RELOAD_EMPTY: same as above
- ACT_VM_FIDGET: 1/30 Inspect1; 45/30 Inspect2
- draw_knife: 2/30 PSTL.Raise
- holster_knife: 2/30 PSTL.Holster
- reload_knife / reload_knife_empty: same Open/Insert/Close pattern
- inspect_knife: 1/30 `TFA_CODWW2_1911.Inspect1`; 55/30 `TFA_CODWW2_1911.Inspect2` (NOTE: uses 1911 inspect sounds)

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_knife=`35/30`, reload_knife_empty=`35/30`.

**SequenceRateOverride:** ACT_VM_DRAW=`45/30`, ACT_VM_HOLSTER=`45/30`, draw_knife=`45/30`, holster_knife=`45/30` (note: no _empty variants present here).

### Bodygroups / Skins
Not declared.

### VElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | false |
| tac_knife | `tacknife/c_combatknife.mdl` | tag_weapon | false |
| clip_default | `no2/c_no2_clip.mdl` | tag_clip | true |
| ext_clip | `no2/c_no2_clip_ext.mdl` | tag_clip | false |
| grip_default | `no2/c_no2_grip.mdl` | tag_weapon | true |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- tac_knife: `w_combatknife.mdl`, ValveBiped.Bip01_L_Hand (pos V(3,1.5,0), ang A(-20,90,0), bonemerge=false), false
- clip_default: `no2/w_no2_clip.mdl`, tag_clip, true
- ext_clip: `no2/w_no2_clip_ext.mdl`, tag_clip, false

### Attachments
1: `tfa_codww2_supp_pistol` (order 1)
2: `tfa_codww2_knife` (order 2)
3: `tfa_codww2_xmag_noani` (order 3) — NOTE: uses xmag_noani
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim`, `tfa_codww2_quickdraw` (order 4)
5: `tfa_codww2_highcal`, `tfa_codww2_fmj` (order 5)

### Miscellaneous
AmmoTypeStrings=`{["357"] = ".380"}`, DInv2_Mass=`0.5`, TracerCount=`1`, LuaShellEject=`false`, EjectionSmokeEnabled=`false`, Primary.Spread=`.01`, Primary.IronAccuracy=`.0075`, IronRecoilMultiplier=`0.8`, KickUp=`0.9`, KickDown=`0.6`, KickHorizontal=`0.15`, SpreadMultiplierMax=`7.5`, SpreadIncrement=`3`, SpreadRecovery=`6`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=12, Damage=2400, NumShots=2, RPM=295, DefaultClip=132, MaxAmmo=120, Automatic=false. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard pattern (MaxAmmo=60).

---

## 7. 9mm SAP / Walther P38 (nz_kate_codww2_p38.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"9mm SAP"` |
| Category | `"nZR: WWII Kate Starting Pistols"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/p38/c_p38.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/p38/w_p38.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Walther"` |
| Type_Displayed | `"Pistol"` |
| Purpose | `"Semi-automatic pistol with high fire rate and moderate damage."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Taschenlocher"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_P38.Mid"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_1911.Sub"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_P38.Snap"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_P38.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"pistol"` |
| Primary.Automatic | `false` |
| Primary.RPM | `670` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `10` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `8` |
| Primary.ClipSize_Ext | `12` |
| Primary.DefaultClip | `88` |
| Primary.MaxAmmo | `80` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=36,dmg=1}, {range=39,dmg=0.5}}` |

### Secondary Stats (Bash)
Same as 1911 (BashDamage=35, BashLength=40, etc.).

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`""`, FireModeName=`nil`.

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-4.07, -3, 0.95)`, IronSightsAng=`Vector(0.5, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.44)`, IronSightsAng_TAC=`Vector(0.4, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`. InspectPos=`Vector(10, -7, -2)`. SafetyPos=`Vector(2, -11, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`.

### Animations Table
Same 4 entries as 1911.

### Event Table
- ACT_VM_DRAW / DRAW_EMPTY / HOLSTER / HOLSTER_EMPTY: 2/30 PSTL.Raise/Holster
- ACT_VM_RELOAD: 5/30 `TFA_CODWW2_P38.TacMagOut`; 25/30 `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 `MagOut`; 25/30 `MagIn`; 50/30 `Charge`
- ACT_VM_FIDGET: 1/30 Inspect1; 55/30 Inspect2
- `"inspect_empty"`: same as FIDGET
- draw_knife/_empty, holster_knife/_empty: 2/30 PSTL.Raise/Holster
- reload_knife: 5/30 MagOut; 25/30 MagIn
- reload_knife_empty: +50/30 Charge
- inspect_knife, inspect_knife_empty: 1/30 Inspect1; 55/30 Inspect2
- reload_ext: 5/30 MagOut; 25/30 MagIn
- reload_ext_empty: +50/30 Charge
- reload_ext_knife: 5/30 MagOut; 25/30 MagIn
- reload_ext_knife_empty: +50/30 Charge

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_knife=`35/30`, reload_knife_empty=`35/30`, reload_ext=`35/30`, reload_ext_empty=`35/30`, reload_ext_knife=`35/30`, reload_ext_knife_empty=`35/30`.

**SequenceRateOverride:** ACT_VM_DRAW=`45/30`, ACT_VM_DRAW_EMPTY=`45/30`, ACT_VM_HOLSTER=`45/30`, ACT_VM_HOLSTER_EMPTY=`45/30`, draw_knife=`45/30`, draw_knife_empty=`45/30`, holster_knife=`45/30`, holster_knife_empty=`45/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_hub23_suppressor_pistol.mdl` | **tag_clip** (unusual — not tag_weapon) | false |
| tac_knife | `tacknife/c_combatknife.mdl` | tag_clip | false |
| clip_default | `p38/c_p38_clip.mdl` | tag_clip | true |
| ext_clip | `p38/c_p38_clip_ext.mdl` | tag_clip | false |
| grip_default | `p38/c_p38_grip.mdl` | tag_clip | true |
| base_default | `p38/c_p38_base.mdl` | tag_clip | true |

### WElements
All bones are `tag_clip` except tac_knife (`ValveBiped.Bip01_L_Hand`):
- suppressor: `c_hub23_suppressor_pistol.mdl`, false (NOTE: uses c_ view model for world, not w_)
- tac_knife: `w_combatknife.mdl`, false
- clip_default: `w_p38_clip.mdl`, true
- ext_clip: `w_p38_clip_ext.mdl`, false
- grip_default: `w_p38_grip.mdl`, true
- base_default: `w_p38_base.mdl`, true

### Attachments
1: `tfa_codww2_supp_pistol` (order 1)
2: `tfa_codww2_knife` (order 2)
3: `tfa_codww2_xmag` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim`, `tfa_codww2_quickdraw` (order 4)
5: `tfa_codww2_highcal`, `tfa_codww2_fmj` (order 5)

### Miscellaneous
AmmoTypeStrings=`{["pistol"] = "9x19 Parabellum"}`, DInv2_Mass=`0.5`, TracerCount=`3`, KickUp=`0.4`, KickDown=`0.2`, KickHorizontal=`0.15`, SpreadIncrement=`1.5`, SpreadRecovery=`5`, IronRecoilMultiplier=`0.7`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=16, Damage=825, NumShots=4, RPM=680, DefaultClip=176, MaxAmmo=160, Automatic=false. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=80).

---

## 8. Reichsrevolver / M1879 (nz_kate_codww2_m1879.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"Reichsrevolver"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Pistols"` |
| Slot | `1` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/m1879/c_m1879.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m1879/w_m1879.mdl"` |
| HoldType | `"pistol"` |
| Manufacturer | `"Mauser"` |
| Type_Displayed | `"Revolver"` |
| Purpose | `"Revolver with high fire rate and moderate damage."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Rotierendes Blutbad"` |
| Ispackapunched | `false` |
| MuzzleFlashEffect | `"tfa_muzzleflash_revolver"` (declared in model section, unique to M1879) |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1879.Shoot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1GRND.NPC.Shot"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_M1879.Mid"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_M1879.Snap"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_M1879.Thump"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_SHGN.Trans"` |
| Primary.SoundLyr6 | `"TFA_CODWW2_KAR98K.LowCrack"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.Pistol"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_NO2.Ext")}` (reuses No.2 ext sound) |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.PSTL"` |
| Primary.Ammo | `"357"` |
| Primary.Automatic | `false` |
| Primary.RPM | `342` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `650` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `6` |
| Primary.ClipSize_Ext | `8` |
| Primary.DefaultClip | `66` |
| Primary.MaxAmmo | `60` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=36,dmg=1}, {range=39,dmg=0.46}}` |

### Secondary Stats (Bash)
Same as 1911 (BashDamage=35, BashLength=40, etc.).

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`""`, FireModeName=`"Single-Action"` (unique).

### Shotgun Fields
| Field | Value |
|---|---|
| Shotgun | `true` (unique — uses shotgun-style reload) |
| ShotgunEmptyAnim | `false` |
| ShotgunEmptyAnim_Shell | `false` |
| ShotgunStartAnimShell | `true` |

### Ironsights
IronSightsPos=`Vector(-4.07, -3, 1.05)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_TAC=`Vector(-4.285, -3, 0.6)`, IronSightsAng_TAC=`Vector(-0.2, 0, 0)`, IronSightTime=`0.2`, Secondary.IronFOV=`80`. InspectPos=`Vector(10, -7, -2)`. SafetyPos=`Vector(2, -11, -10)`, SafetyAng=`Vector(60, 0, 0)`, SafetyPos_TAC=`Vector(-1, 1, 2)`, SafetyAng_TAC=`Vector(-20, -5, -5)`.

### Animations Table
Not declared (`SWEP.Animations` absent).

### Event Table
- `"fire"`: 5/30 → `TFA_CODWW2_M1879.Hammer`
- `"fire_ads"`: 5/30 → `TFA_CODWW2_M1879.Hammer`
- `"fire_knife"`: 5/30 → `TFA_CODWW2_M1879.Hammer`
- `"fire_knife_ads"`: 5/30 → `TFA_CODWW2_M1879.Hammer`
- ACT_VM_DRAW: 2/30 PSTL.Raise
- ACT_VM_HOLSTER: 2/30 PSTL.Holster
- ACT_SHOTGUN_RELOAD_START: 5/30 → `M1879.Open`; 15/30 → `Insert`
- ACT_VM_RELOAD: 0/30 → `Insert` (per-shell insert)
- ACT_SHOTGUN_RELOAD_FINISH: 0/30 → `Close`
- ACT_VM_FIDGET: 1/30 Inspect1; 55/30 Inspect2
- `"draw_knife"`: 2/30 PSTL.Raise
- `"holster_knife"`: 2/30 PSTL.Holster
- `"reload_in_knife"`: 5/30 → `Open`; 15/30 → `Insert`
- `"reload_knife"`: 0/30 → `Insert`
- `"reload_out_knife"`: 0/30 → `Close`
- `"inspect_knife"`: 1/30 Inspect1; 55/30 Inspect2

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** empty table `{}`.

**SequenceRateOverride:** ACT_VM_DRAW=`45/30`, ACT_VM_HOLSTER=`45/30`, draw_knife=`45/30`, holster_knife=`45/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | false |
| tac_knife | `tacknife/c_combatknife.mdl` | tag_weapon | false |
| clip_default | `m1879/c_m1879_clip.mdl` | tag_clip | true |
| ext_clip | `m1879/c_m1879_clip_ext.mdl` | tag_clip | false |
| grip_default | `m1879/c_m1879_grip.mdl` | tag_weapon | true |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- tac_knife: `w_combatknife.mdl`, ValveBiped.Bip01_L_Hand (pos V(3,1.5,0), ang A(-20,90,0), bonemerge=false), false
- clip_default: `m1879/w_m1879_clip.mdl`, tag_clip, true
- ext_clip: `m1879/w_m1879_clip_ext.mdl`, tag_clip, false
- grip_default: `m1879/w_m1879_grip.mdl`, tag_weapon, true

### Attachments
1: `tfa_codww2_supp_pistol` (order 1)
2: `tfa_codww2_knife` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim`, `tfa_codww2_quickdraw` (order 4)
5: `tfa_codww2_highcal`, `tfa_codww2_fmj` (order 5)

### Miscellaneous
AmmoTypeStrings=`{["357"] = "10.6x25mmR"}`, DInv2_Mass=`0.5`, TracerCount=`1`, LuaShellEject=`false`, EjectionSmokeEnabled=`false`, Primary.Spread=`.01`, IronAccuracy=`.0075`, IronRecoilMultiplier=`0.7`, KickUp=`0.6`, KickDown=`0.5`, KickHorizontal=`0.1`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`7.5`, SpreadIncrement=`3`, SpreadRecovery=`6`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=16, Damage=1950, NumShots=1, RPM=352, DefaultClip=176, MaxAmmo=160, Automatic=false. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=60).

---

# SMGs

---

## 9. Austen (nz_kate_codww2_austen.lua)

### Core Fields
| Field | Value |
|---|---|
| Base | `"tfa_codww2_base"` |
| PrintName | `"Austen"` |
| Category | `"nZR: WWII Kate"` |
| SubCategory | `"Submachine Guns"` |
| Slot | `2` |
| Spawnable | `TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7` |
| AdminSpawnable | `true` |
| UseHands | `true` |
| ViewModelFOV | `65` |
| ViewModel | `"models/weapons/tfa_codww2/austen/c_austen.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/austen/w_austen.mdl"` |
| HoldType | `"smg"` |
| Manufacturer | `"Diecasters Ltd & W. T. Carmichael Ltd"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG that has the best range in class."` |
| Author | `"Olli, Fox, Mav"` |
| DrawCrosshair | `true` |
| DrawCrosshairIronSights | `false` |
| NZPaPName | `"Kangaroo Killer"` |
| Ispackapunched | `false` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STEN.Shot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_STEN.Mechy"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_STEN.Clicky"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_M1928.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `600` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `638` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `55` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `35` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=30,dmg=1}, {range=35,dmg=0.5}}` |

### Secondary Stats (Bash)
BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashHitSound=`Sound("TFA_CODWW2_MELEE.Hit")`, BashHitSound_Flesh=`Sound("TFA_CODWW2_MELEE.HitPlr")`, BashLength=`45`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`"1"`, FireModeName=`nil`.

### LowAmmo
FireSoundAffectedByClipSize=`true`, LowAmmoSoundThreshold=`0.33`, LowAmmoSound=`"TFA.LowAmmo.SMG"`, LastAmmoSound=`"TFA.LowAmmo.SMG_Dry"`.

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-3.96, -1, 1.45)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.963, -1, 0.903)`, IronSightsAng_NYDAR=`Vector(0, 0, 0)`, IronSightsPos_LENS=`Vector(-3.958, -1, 1.434)`, IronSightsAng_LENS=`Vector(0, 0, 0)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`, IronInSound=`"TFA_CODWW2_GEN.AdsUp"`, IronOutSound=`"TFA_CODWW2_GEN.AdsDown"`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 1/30 → `TFA_CODWW2_AUausten.FPOCharge`
- ACT_VM_DRAW: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 10/30 → `AUausten.TacMagOut`; 35/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 10/30 → `MagOut`; 35/30 → `MagIn`; 50/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 70/30 → `Inspect2`
- `"inspect_empty"`: same as FIDGET
- `"suppressor_attach"`: 1/30 → `TFA_CODWW2_MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `TFA_CODWW2_MP40.SuppOff`

All `"sound"` type.

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `austen/c_austen_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional `TFA.CODWW2.GetHoloSightReticle("sight_nydar") or nil` |
| lens_sight | `attachments/sights/c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `attachments/suppressors/c_pistol_suppressor.mdl` | tag_weapon | false |
| clip_default | `austen/c_austen_clip.mdl` | tag_clip | true |
| ext_clip | `austen/c_austen_clip_ext.mdl` | tag_clip | false |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- clip_default: `austen/w_austen_clip.mdl`, tag_clip, true
- ext_clip: `austen/w_austen_clip_ext.mdl`, tag_clip, false
- sight_nydar: `austen/w_austen_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=50, Damage=165, NumShots=2, RPM=610, DefaultClip=550, MaxAmmo=500, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=250).

---

## 10. Bechowiec (nz_kate_codww2_bechowiec.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Bechowiec"` |
| HoldType | `"rpg"` (unusual for an SMG — possibly a typo in source) |
| Manufacturer | `"Armia Krajowa"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with steady recoil and high fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/bechowiec/c_bechowiec.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/bechowiec/w_bechowiec.mdl"` |
| NZPaPName | `"Pepper Shaker"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STEN.Mechy"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_EMP44.Center"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_EMP44.Wide"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_RIBEY.Trans"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_M1928.Short.Low"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("nil"), [256]=Sound("TFA_CODWW2_GG.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `830` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `882` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `50` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `45` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.65}}` |

### Secondary Stats (Bash)
BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashLength=`45`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
BurstDelay=`nil`, DisableBurstFire=`true`, SelectiveFire=`false`, OnlyBurstFire=`false`, BurstFireCount=`nil`, DefaultFireMode=`"1"`, FireModeName=`nil`.

### LowAmmo
FireSoundAffectedByClipSize=`true`, LowAmmoSoundThreshold=`0.33`, LowAmmoSound=`"TFA.LowAmmo.SMG"`, LastAmmoSound=`"TFA.LowAmmo.SMG_Dry"`.

### Shotgun Fields
Not declared.

### Ironsights
IronSightsPos=`Vector(-4.176, 0, 1.795)`, IronSightsAng=`Vector(0.1, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.98, 0, 0.43)`, IronSightsAng_NYDAR=`Vector(0, 0, 0)`, IronSightsPos_LENS=`Vector(-4.175, 0, 1.713)`, IronSightsAng_LENS=`Vector(0, 0, 0)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(1, -1, -0.5)`, SafetyAng=`Vector(-20, 35, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |
| suppressor_remove_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove_knife"` |
| suppressor_attach_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach_knife"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 15/30 → `TFA_CODWW2_MP40.Charge`
- ACT_VM_DRAW: 1/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `MP40.TacMagOut`; 35/30 → `TacMagIn` (NOTE: uses MP40 sounds, not Bechowiec-specific)
- ACT_VM_RELOAD_EMPTY: 5/30 → `MP40.MagOut`; 35/30 → `MagIn`; 60/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `MP40.Inspect1`; 50/30 → `Inspect2`
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`40/30`, ACT_VM_RELOAD_EMPTY=`40/30`.

**SequenceLengthOverride:** ACT_VM_DRAW_DEPLOYED=`45/30`, ACT_VM_RELOAD=`70/30`, ACT_VM_RELOAD_EMPTY=`90/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `bechowiec/c_bechowiec_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional (TFA.CODWW2.GetHoloSightReticle or nil) |
| lens_sight | `attachments/sights/c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `attachments/suppressors/c_suppressor_hub23.mdl` | tag_weapon | false |
| ext_clip | `bechowiec/c_bechowiec_clip_ext.mdl` | tag_clip | false (NOTE: no clip_default element — model has integrated mag) |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- sight_nydar: `bechowiec/w_bechowiec_reflex.mdl`, tag_weapon, false
(only 2 WElements — no clip/stock/etc.)

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.25`, KickDown=`0.25`, KickHorizontal=`0.25`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=150, NumShots=3, RPM=840, DefaultClip=704, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

## 11. Blyskawica (nz_kate_codww2_blyskawica.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Blyskawica"` |
| HoldType | `"smg"` |
| Manufacturer | `"Armia Krajowa"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Fast firing automatic SMG high on accuracy."` |
| ViewModel | `"models/weapons/tfa_codww2/blyskawica/c_blyskawica.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/blyskawica/w_blyskawica.mdl"` |
| NZPaPName | `"Zasadzka"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1928.Plr.Blast"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1928.Plr.Low"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_STEN.Clicky"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("nil"), [256]=Sound("TFA_CODWW2_PPSH.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `750` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `785` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `65` |
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
| FiresUnderwater | `true` |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=30,dmg=1}, {range=33,dmg=0.7}}` |

### Secondary Stats (Bash)
BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashLength=`45`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
DefaultFireMode=`"1"`, all others default.

### LowAmmo
FireSoundAffectedByClipSize=`true`, LowAmmoSoundThreshold=`0.33`, LowAmmoSound=`"TFA.LowAmmo.SMG"`, LastAmmoSound=`"TFA.LowAmmo.SMG_Dry"`.

### Ironsights
IronSightsPos=`Vector(-3.8, -0, 1.5)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.8, 0, 0.8)`, IronSightsAng_NYDAR=`Vector(0, 0, 0)`, IronSightsPos_LENS=`Vector(-3.796, 0, 1.518)`, IronSightsAng_LENS=`Vector(0, 0, 0)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-2, -2, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 25/30 → `TFA_CODWW2_PIORUN.Charge`
- ACT_VM_DRAW / DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `PIORUN.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 35/30 → `MagIn`; 60/30 → `Charge`
- `"inspect"`: 1/30 → `PIORUN.Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"`: same as inspect
- `"inspect_epic"`: 1/30 → `PIORUN.EpicInspect1`; 90/30 → `EpicInspect2`; 190/30 → `Inspect2`
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

### VElements
| name | model | bone | pos | angle | bonemerge | active |
|---|---|---|---|---|---|---|
| sight_nydar | `sten/c_sten_reflex.mdl` (NOTE: reuses Sten reflex model) | tag_weapon | V(0.55, 0, -0.02) | A(0, -90, 0) | false | false |
| sight_nydar_lens | conditional or nil | — | — | — | — | — |
| lens_sight | `attachments/sights/c_lens_sight.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | false |
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | false |
| clip_default | `blyskawica/c_blyskawica_clip.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | true | true |
| ext_clip | `blyskawica/c_blyskawica_clip_ext.mdl` | tag_clip | V(0,0,0) | A(0,0,0) | true | false |
| sights_default | `blyskawica/c_blyskawica_sight.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | true |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | V(0,0,0) | A(0,0,0) | true | false |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- clip_default: `blyskawica/w_blyskawica_clip.mdl`, tag_clip, true
- ext_clip: `blyskawica/w_blyskawica_clip_ext.mdl`, tag_clip, false
- sight_nydar: `blyskawica/w_blyskawica_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -0.75, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=60, Damage=195, NumShots=1, RPM=760, DefaultClip=660, MaxAmmo=600, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=300).

---

## 12. Chatellerault (nz_kate_codww2_chatellerault.lua)

> **Note:** File declares SubCategory=`"Light Machine Guns"`, Type_Displayed=`"Light Machine Gun"`, Slot=`3`, Ammo=`"ar2"`. The PaP listing categorizes this as an SMG audit per user instruction, but the source classification is LMG.

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Chatellerault"` |
| SubCategory | `"Light Machine Guns"` |
| Slot | `3` |
| HoldType | `"ar2"` |
| Manufacturer | `"Manufacture d'Armes de Châtellerault"` |
| Type_Displayed | `"Light Machine Gun"` |
| Purpose | `"Automatic LMG with steady recoil and moderate fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/chatellerault/c_chatellerault.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/chatellerault/w_chatellerault.mdl"` |
| NZPaPName | `"Chatter Box"` |
| MuzzleFlashEffect | `"tfa_muzzleflash_rifle"` (declared in gun section; overrides default) |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_BREN.Plr"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_BREN.Low"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_PLAYER.Sub.thump_shrt"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_MECH.Belt_Feed"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_BREN.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.LMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.LMG"` |
| Primary.Ammo | `"ar2"` |
| Primary.Automatic | `true` |
| Primary.RPM | `510` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `545` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `200` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `25` |
| Primary.ClipSize_Ext | `37` |
| Primary.DefaultClip | `275` |
| Primary.MaxAmmo | `250` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `false` (unique — most others are true) |
| Primary.DisplayFalloff | `true` |
| Primary.RangeFalloffLUT | bezier=false, range_func=`"linear"`, units=`"meters"`, lut=`{{range=150,dmg=1}, {range=200,dmg=0.8}}` |

### Secondary Stats (Bash)
BashDamage=`35`, BashSound=`Sound("TFA_CODWW2_MELEE.SwingLrg")` (NOTE: SwingLrg, not SwingSmg), BashHitSound=`Sound("TFA_CODWW2_MELEE.Hit")`, BashHitSound_Flesh=`Sound("TFA_CODWW2_MELEE.HitPlr")`, BashLength=`50`, BashDelay=`0.2`, BashDamageType=`DMG_CLUB`, BashInterrupt=`true`.

### Fire Modes
DefaultFireMode=`""`, all defaults.

### LowAmmo
Not declared (no FireSoundAffectedByClipSize).

### Ironsights
IronSightsPos=`Vector(-3.425, -1, 2.2)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.543, -1, 0.92)`, IronSightsAng_NYDAR=`Vector(0, 0, 0)`, IronSightsPos_ACOG=`Vector(-3.568, -6, 1.227)` (unique — has ACOG scope position), IronSightsAng_ACOG=`Vector(0, 0, 0)`, IronSightTime=`0.4` (vs 0.3 on SMGs), Secondary.IronFOV=`70`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(1, -1, -0.5)`, SafetyAng=`Vector(-20, 35, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| reload_ext | TFA.Enum.ANIMATION_SEQ | `"reload_ext"` |
| reload_ext_empty | TFA.Enum.ANIMATION_SEQ | `"reload_ext_empty"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 15/30 → `TFA_CODWW2_BREN.FPO`
- ACT_VM_DRAW / DRAW_EMPTY: 1/30 → `TFA_CODWW2_LRG.Raise` (NOTE: LRG.Raise, not SML.Raise)
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_LRG.Holster`
- ACT_VM_RELOAD: 15/30 → `BREN.TacMagOut`; 75/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 15/30 → `MagOut`; 75/30 → `MagIn`; 130/30 → `Charge`
- `"inspect"`: 1/30 → `BREN.Inspect1`; 75/30 → `Inspect2`
- `"inspect_empty"`: same as inspect
- `"inspect_epic"`: 1/30 → `BREN.EpicInspect1`; 80/30 → `EpicInspect2`
- `"reload_ext"`: 15/30 → `BREN.ExtTacMagOut`; 65/30 → `ExtTacMagIn`
- `"reload_ext_empty"`: 15/30 → `ExtMagOut`; 65/30 → `ExtMagIn`; 120/30 → `ExtCharge`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`95/30`, ACT_VM_RELOAD_EMPTY=`95/30`, reload_ext=`90/30`, reload_ext_empty=`90/30`.

**SequenceLengthOverride:** ACT_VM_DRAW_DEPLOYED=`55/30`, ACT_VM_DRAW=`30/30`, ACT_VM_DRAW_EMPTY=`30/30`, ACT_VM_RELOAD=`130/30`, ACT_VM_RELOAD_EMPTY=`175/30`, reload_ext=`130/30`, reload_ext_empty=`165/30`.

**SequenceRateOverride:** sprint_in=`25/30`, sprint_loop=`25/30`, sprint_in_empty=`25/30`, sprint_loop_empty=`25/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `chatellerault/c_chatellerault_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| scope_acog | `chatellerault/c_chatellerault_4x.mdl` | tag_weapon | false (unique — has 4x scope) |
| clip_default | `chatellerault/c_chatellerault_clip.mdl` | tag_clip | true |
| ext_clip | `chatellerault/c_chatellerault_clip_ext.mdl` | tag_clip | false |
| bipod_default | `chatellerault/c_chatellerault_bipod.mdl` | tag_weapon | true (unique — has bipod) |
| charm_default | `breda30/c_breda30_charm.mdl` (uses breda30 charm) | tag_weapon | false |

### WElements
- clip_default: `w_chatellerault_clip.mdl`, tag_clip, true
- ext_clip: `w_chatellerault_clip_ext.mdl`, tag_clip, false
- sight_nydar: `w_chatellerault_reflex.mdl`, tag_weapon, false
- scope_acog: `w_chatellerault_4x.mdl`, tag_weapon, false

### Attachments
1: (not declared — slot 1 is absent, so no suppressor)
2: `tfa_codww2_nydar`, `tfa_codww2_4x` (order 2)
3: `tfa_codww2_xmag` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["ar2"] = "7.5×54mm French"}`, DInv2_GridSizeY=`4`, DInv2_Mass=`10`, TracerCount=`5`, LuaShellModel=`"models/entities/tfa_codww2/shells/fx_556.mdl"`, LuaShellSound=`"TFA_CODWW2_SHELLS.Large"`, ViewModelPunch_MaxVertialOffset=`3`, IronRecoilMultiplier=`0.5`, KickUp=`0.4`, KickDown=`0.3`, KickHorizontal=`0.1`, StaticRecoilFactor=`0.5`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`5`, ChangeStateAccuracyMultiplier=`1.5`, CrouchAccuracyMultiplier=`0.65`, JumpAccuracyMultiplier=`2.0`, WalkAccuracyMultiplier=`1.35`, MoveSpeed=`0.9` (vs 1 on others), IronSightsMoveSpeed=`0.9*0.8=0.72`, JamFactor=`0.03` (LMG jamming), JumpRecoilMultiplier=`2.65` (unique — much higher), Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`1` (vs 0 on SMGs), VMPos=`Vector(0, -1.5, 0)`, Primary.Spread=`.03`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=50, Damage=600, NumShots=1, RPM=520, DefaultClip=550, MaxAmmo=500, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=250).

---

## 13. Erma EMP (nz_kate_codww2_erma.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Erma EMP"` |
| HoldType | `"smg"` |
| Manufacturer | `"Erma Werke"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with low kick and moderate fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/erma/c_erma.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/erma/w_erma.mdl"` |
| NZPaPName | `"ERRRM, ACKSHUALLY..."` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_MP28.Snap"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_MP28.Thump"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_EJECT.SMG"` (NOTE: skips Lyr3 and Lyr4) |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_STEN.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `588` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `631` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `67` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=13,dmg=1}, {range=15,dmg=0.86}, {range=36,dmg=0.86}, {range=38,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG (BashDamage=35, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashLength=45, BashDelay=0.2, DMG_CLUB, BashInterrupt=true).

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard (FireSoundAffectedByClipSize=true, threshold=0.33, LowAmmoSound="TFA.LowAmmo.SMG", LastAmmoSound="TFA.LowAmmo.SMG_Dry").

### Ironsights
IronSightsPos=`Vector(-3.65, -3, 2.4)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.652, -1, 1.275)`, IronSightsPos_LENS=`Vector(-3.647, -3, 2.436)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -1, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_ERMA.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 1-2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `ERMA.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 25/30 → `MagIn`; 55/30 → `Charge`
- `"inspect"`: 1/30 → `Inspect1`; 50/30 → `Inspect2`
- `"inspect_empty"`: same
- `"inspect_epic"`: same (no epic-specific sounds)
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

### VElements
| name | model | bone | active | bodygroup |
|---|---|---|---|---|
| sight_nydar | `erma/c_erma_reflex.mdl` | tag_weapon | false | `{}` |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false | `{}` |
| suppressor | `c_suppressor_hub23.mdl` | tag_weapon | false | `{}` |
| clip_default | `erma/c_erma_clip.mdl` | tag_clip | true | `{}` |
| ext_clip | `erma/c_erma_clip_ext.mdl` | tag_clip | false | `{}` |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false | `{[0] = 1}` (sets bodygroup 0 to 1) |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `erma/w_erma_clip.mdl`, tag_clip, true
- ext_clip: `erma/w_erma_clip_ext.mdl`, tag_clip, false
- sight_nydar: `erma/w_erma_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "7.63×25mm Mauser"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.25`, KickDown=`0.25`, KickHorizontal=`0.25`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1, 0)`.

**ViewModelBoneMods:** Has one entry — `["tag_charm_base"] = { scale = Vector(1, 1, 1), pos = Vector(1.5, -0.55, 0.85), angle = Angle(0, 0, 0) }` (unique — only Erma and M1928 have this).

### Custom Functions
**`SWEP:OnPaP()`** — Sets Ispackapunched=true, MuzzleFlashEffect="muz_pap". Primary_TFA: ClipSize=64, Damage=201. **Also sets `SWEP.Primary.Knockback = 0`** (unusual — this is `SWEP.Primary`, not `Primary_TFA`; probably no-op since OnPaP runs once). Then NumShots=1, RPM=598, DefaultClip=704, MaxAmmo=640, Automatic=true. ClearStatCache, return true.

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

## 14. Grease Gun (nz_kate_codww2_greasegun.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Grease Gun"` |
| HoldType | `"smg"` |
| Manufacturer | `"General Motors"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with low recoil and steady fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/greasegun/c_greasegun.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/greasegun/w_greasegun.mdl"` |
| NZPaPName | `"BBQ Bacon Burger"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_GG.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_GG.Lyr2"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_GG.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `545` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `582` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `52` |
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
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.83}, {range=36,dmg=0.83}, {range=38,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash (BashDamage=35, BashSound=`Sound("TFA_CODWW2_MELEE.SwingSmg")`, BashLength=45).

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-4.1, -2.25, 1.04)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-4.1, -2.25, 0.585)`, IronSightsPos_LENS=`Vector(-4.097, -2.25, 1.035)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-2.5, -1, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| reload_ext | TFA.Enum.ANIMATION_SEQ | `"reload_ext"` |
| reload_ext_empty | TFA.Enum.ANIMATION_SEQ | `"reload_ext_empty"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |
| suppressor_attach_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` (NOTE: value is `"suppressor_attach"`, not `"suppressor_attach_knife"` — likely a copy-paste bug) |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 1/30 → `TFA_CODWW2_GG.FPO`
- ACT_VM_DRAW: 1/30 → `TFA_CODWW2_GG.Pullout`
- ACT_VM_DRAW_EMPTY: 2/30 → `TFA_CODWW2_GG.Pullout`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_MED.Holster` (NOTE: uses MED.Holster, not SML.Holster)
- ACT_VM_RELOAD: 5/30 → `GG.MagOut`; 30/30 → `MagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 30/30 → `MagIn`; 50/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"`: same
- `"draw_knife"` / `"draw_knife_empty"`: 2/30 → `TFA_CODWW2_SML.Raise`
- `"holster_knife"` / `"holster_knife_empty"`: 2/30 → `TFA_CODWW2_SML.Holster`
- `"reload_ext"`: 5/30 → `GG.MagOut`; 30/30 → `MagIn`
- `"reload_ext_empty"`: +50/30 → `Charge`
- `"suppressor_attach"`: 1/30 → `GG.SuppOn`
- `"suppressor_remove"`: 1/30 → `GG.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_ext=`35/30`, reload_ext_empty=`35/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `greasegun/c_greasegun_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `greasegun/c_greasegun_suppressor.mdl` (uses weapon-specific suppressor model, not generic) | tag_weapon | false |
| clip_default | `greasegun/c_greasegun_clip.mdl` | tag_clip | true |
| ext_clip | `greasegun/c_greasegun_clip_ext.mdl` | tag_clip | false |
| receiver_default | `greasegun/c_greasegun_receiver.mdl` | tag_weapon | true |
| barrel_default | `greasegun/c_greasegun_barrel.mdl` | tag_weapon | true |
| charm_default | `greasegun/c_greasegun_charm.mdl` | tag_weapon | true (active=true, unusual) |
| sight_default | `greasegun/c_greasegun_sight.mdl` | tag_weapon | true |
| stock_default | `greasegun/c_greasegun_stock.mdl` | tag_weapon | true |

### WElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `greasegun/w_greasegun_suppressor.mdl` | tag_weapon | false |
| clip_default | `greasegun/w_greasegun_clip.mdl` | tag_clip | true |
| ext_clip | `greasegun/w_greasegun_clip_ext.mdl` | tag_clip | false |
| receiver_default | `greasegun/w_greasegun_receiver.mdl` | tag_weapon | true |
| barrel_default | `greasegun/w_greasegun_barrel.mdl` | tag_weapon | true |
| sight_default | `greasegun/w_greasegun_sight.mdl` | tag_weapon | true |
| stock_default | `greasegun/w_greasegun_stock.mdl` | tag_weapon | true |
| sight_nydar | `greasegun/w_greasegun_reflex.mdl` | tag_weapon | false |

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag` (order 3, NOTE: uses regular xmag, not xmag_noani)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = ".45 ACP"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1.75, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=156, NumShots=2, RPM=555, DefaultClip=704, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=300).

---

## 15. Waffe 28 / MP28 (nz_kate_codww2_mp28.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Waffe 28"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Bergmann Waffenfabrik Qingdao Iron Works"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Full-auto ballistic firearm. Modest fire rate and magazine grip provide natural stability."` |
| ViewModel | `"models/weapons/tfa_codww2/mp28/c_mp28.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/mp28/w_mp28.mdl"` |
| NZPaPName | `"Hyper Activity"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_MP28.Snap"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_MP28.Thump"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_EJECT.SMG"` (skips Lyr3 and Lyr4) |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_MP28.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `1000` (very high) |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `1071` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `71` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.655, -3, 2.2)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.65, -3, 1.225)`, IronSightsPos_LENS=`Vector(-3.65, -3, 2.23)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |
| suppressor_remove_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove_knife"` |
| suppressor_attach_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach_knife"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_MP28.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `MP28.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 25/30 → `MagIn`; 55/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 50/30 → `Inspect2`
- `"inspect_empty"`: same
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`, reload_knife=`45/30`, reload_knife_empty=`45/30`.

### VElements
| name | model | bone | active | bodygroup |
|---|---|---|---|---|
| sight_nydar | `mp28/c_mp28_reflex.mdl` | tag_weapon | false | `{}` |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false | `{}` |
| suppressor | `c_suppressor_hub23.mdl` | tag_weapon | false | `{}` |
| clip_default | `mp28/c_mp28_clip.mdl` | tag_clip | true | `{}` |
| ext_clip | `mp28/c_mp28_clip_ext.mdl` | tag_clip | false | `{}` |
| receiver_default | `mp28/c_mp28_receiver.mdl` | tag_weapon | true | `{}` |
| barrel_default | `mp28/c_mp28_barrel.mdl` | tag_weapon | true | `{}` |
| charm_default | `mp28/c_mp28_charm.mdl` (uses weapon-specific charm model, not bar charm) | tag_weapon | true | `{[0] = 1}` |
| sights_default | `mp28/c_mp28_sight.mdl` | tag_weapon | true | `{}` |
| stock_default | `mp28/c_mp28_stock.mdl` | tag_weapon | true | `{}` |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `mp28/w_mp28_clip.mdl`, tag_clip, true
- ext_clip: `mp28/w_mp28_clip_ext.mdl`, tag_clip, false
- receiver_default: `mp28/w_mp28_receiver.mdl`, tag_weapon, true
- barrel_default: `mp28/w_mp28_barrel.mdl`, tag_weapon, true
- sight_default: `mp28/w_mp28_sight.mdl`, tag_weapon, true
- stock_default: `mp28/w_mp28_stock.mdl`, tag_weapon, true
- sight_nydar: `mp28/w_mp28_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "7.63×25mm Mauser"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -2, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=213, NumShots=1, RPM=1010, DefaultClip=700, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

## 16. MP40 (nz_kate_codww2_mp40.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"MP40"` |
| HoldType | `"smg"` |
| Manufacturer | `"Steyr-Mannlicher"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with balanced recoil and steady fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/mp40/c_mp40.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/mp40/w_mp40.mdl"` |
| NZPaPName | `"Mitternachtsmorde"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_MP40.Shoot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_MP40.Sub"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_MP40.Mech"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_MP40.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `689` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `740` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `53` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.86}, {range=36,dmg=0.86}, {range=38,dmg=0.6}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-4.184, -2.75, 1.3)`, IronSightsAng=`Vector(0.2, 0, 0)`, IronSightsPos_NYDAR=`Vector(-4.18, -2.75, 0.31)`, IronSightsPos_LENS=`Vector(-4.175, -2.75, 1.3)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(0, -2, -0.2)`, SafetyAng=`Vector(-19, 21, -21)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |
| suppressor_remove_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove_knife"` |
| suppressor_attach_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach_knife"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_MP40.Charge`
- ACT_VM_DRAW: 1/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `MP40.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 30/30 → `MagIn`; 55/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 70/30 → `Inspect2`
- `"inspect_empty"`: same
- `"draw_knife"` / `"draw_knife_empty"`: 2/30 → `SML.Raise`
- `"holster_knife"` / `"holster_knife_empty"`: 2/30 → `SML.Holster`
- `"reload_knife"`: 5/30 → `TacMagOut`; 30/30 → `TacMagIn`
- `"reload_knife_empty"`: 5/30 → `MagOut`; 30/30 → `MagIn`; 55/30 → `Charge`
- `"inspect_knife"` / `"inspect_knife_empty"`: 1/30 → `Inspect1`; 70/30 → `Inspect2`
- `"suppressor_attach"`: `{ time = 0.01, type = "sound", value = Sound"TFA_CODWW2_MP40.SuppOn" }` (NOTE: uses unbracketed table syntax `value = Sound"..."` and time=0.01 instead of 1/30)
- `"suppressor_remove"`: `{ time = 0.01, type = "sound", value = Sound"TFA_CODWW2_MP40.SuppOff" }`
- `"suppressor_attach_knife"`: same as above
- `"suppressor_remove_knife"`: same as above

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_knife=`35/30`, reload_knife_empty=`35/30`.

**SequenceLengthOverride:** ACT_VM_DRAW=`25/30`, ACT_VM_DRAW_EMPTY=`25/30`, ACT_VM_RELOAD=`68/30`, ACT_VM_RELOAD_EMPTY=`88/30`, reload_knife=`68/30`, reload_knife_empty=`88/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `mp40/c_mp40_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `c_suppressor_hub23.mdl` | tag_weapon | false |
| clip_default | `mp40/c_mp40_clip.mdl` | tag_clip | true |
| ext_clip | `mp40/c_mp40_clip_ext.mdl` | tag_clip | false |
| receiver_default | `mp40/c_mp40_receiver.mdl` | tag_weapon | true |
| barrel_default | `mp40/c_mp40_barrel.mdl` | tag_weapon | true |
| charm_default | `mp40/c_mp40_charm.mdl` | tag_weapon | true |
| sight_default | `mp40/c_mp40_sight.mdl` | tag_weapon | true |
| stock_default | `mp40/c_mp40_stock.mdl` | tag_weapon | true |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `mp40/w_mp40_clip.mdl`, tag_clip, true
- ext_clip: `mp40/w_mp40_clip_ext.mdl`, tag_clip, false
- receiver_default: `mp40/w_mp40_receiver.mdl`, tag_weapon, true
- barrel_default: `mp40/w_mp40_barrel.mdl`, tag_weapon, true
- sight_default: `mp40/w_mp40_sight.mdl`, tag_weapon, true
- stock_default: `mp40/w_mp40_stock.mdl`, tag_weapon, true
- sight_nydar: `mp40/w_mp40_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_ani` (order 3, NOTE: uses `xmag_ani`, not `xmag_noani` — unique)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1.75, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=159, NumShots=1, RPM=699, DefaultClip=704, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

## 17. M1928 / Thompson M1928A1 (nz_kate_codww2_m1928a1.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"M1928"` |
| HoldType | `"smg"` |
| Manufacturer | `"Auto-Ordnance"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with moderate recoil and high fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/m1928a1/c_m1928a1.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m1928a1/w_m1928a1.mdl"` |
| NZPaPName | `"Typewriter"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1928.Plr.Blast"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1928.Short.Snap"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_M1928.Short.Low"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("nil"), [256]=Sound("TFA_CODWW2_M1928.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `909` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `967` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `72` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `50` |
| Primary.DefaultClip | `550` |
| Primary.MaxAmmo | `500` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=28,dmg=1}, {range=30,dmg=0.65}}` |

**Notable:** No `Primary.ClipSize_Ext` field (only standard ClipSize), so xmag is not natively declared.

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.286, -0.5, 0.75)`, IronSightsAng=`Vector(0.7, 0, 0)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`. **No NYDAR or LENS positions** (despite presence of sight_nydar VElement — likely intentional since M1928 has no optical attachment slot).

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(0, -1.5, -0.2)`, SafetyAng=`Vector(-19, 21, -21)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 20/30 → `TFA_CODWW2_M1928.FPOCharge`
- ACT_VM_DRAW: 1/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 1/30 → `M1928.Start`; 10/30 → `TacMagOut`; 40/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 1/30 → `Start`; 15/30 → `MagOut`; 45/30 → `MagIn`; 65/30 → `MagTap` (NOTE: uses MagTap, not Charge — unique)
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 50/30 → `Inspect2`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`50/30` (NOTE: different times for reload vs reload_empty).

**SequenceRateOverride:** `"fire_ads" = 30 / 45` (unique — adjusts fire_ads animation rate).

### VElements
| name | model | bone | active |
|---|---|---|---|
| ext_clip | `m1928a1/c_m1928a1_clip_ext.mdl` | tag_clip | **true** (default mag is the ext_clip — drum mag) |
| receiver_default | `m1928a1/c_m1928a1_receiver.mdl` | tag_weapon | true |
| sight_default | `m1928a1/c_m1928a1_sight.mdl` | tag_weapon | true |
| stock_default | `m1928a1/c_m1928a1_stock.mdl` | tag_weapon | true |
| charm_default | `thompson/c_thompson_charm.mdl` (uses thompson charm model) | tag_weapon | true |

**NOTE:** No `clip_default`, no `sight_nydar`, no `lens_sight`, no `suppressor`, no `barrel_default` — much smaller VElements table than other SMGs.

### WElements
- ext_clip: `m1928a1/w_m1928a1_clip_ext.mdl`, tag_clip, true
- receiver_default: `m1928a1/w_m1928a1_receiver.mdl`, tag_weapon, true
- sight_default: `m1928a1/w_m1928a1_sight.mdl`, tag_weapon, true
- stock_default: `m1928a1/w_m1928a1_stock.mdl`, tag_weapon, true

### Attachments
| Slot | atts | order |
|---|---|---|
| 4 | `tfa_codww2_rifling`, `tfa_codww2_steadyaim` | 4 |
| 5 | `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` | 5 |
| 6 | `tfa_codww2_rapidfire`, `tfa_codww2_fmj` | 6 |

**NOTE:** Slots 1, 2, 3 (suppressor, nydar, xmag) are absent — M1928 cannot equip those attachment types. This is a deliberate restriction (drum mag default; cannot swap mags or add suppressor/sight).

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = ".45 ACP"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.3`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1, 0)`.

**ViewModelBoneMods:** Has one entry — `["tag_charm_base"] = { scale = Vector(1, 1, 1), pos = Vector(-2.5, -0.23, 0.55), angle = Angle(0, 0, 0) }` (unique).

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=100, Damage=216, NumShots=1, RPM=919, DefaultClip=1100, MaxAmmo=1000, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=500).

---

## 18. M267 / M2 Hyde (nz_kate_codww2_m2hyde.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"M267"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Marlin Firearms & General Motors"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG that offers versatility in all categories."` |
| ViewModel | `"models/weapons/tfa_codww2/m2hyde/c_m2hyde.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/m2hyde/w_m2hyde.mdl"` |
| NZPaPName | `"Dr. Jekyll"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STG44.Clicky"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_BM38.Snap"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_BM38.Thump"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.msel_a_01"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_GG.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `640` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `681` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `58` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `20` |
| Primary.ClipSize_Ext | `30` |
| Primary.DefaultClip | `220` |
| Primary.MaxAmmo | `200` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=25,dmg=1}, {range=27,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-2.995, 1, 0.69)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.001, 1, 0.56)`, IronSightsPos_LENS=`Vector(-2.995, 0, 0.685)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(0, -3, -0.2)`, SafetyAng=`Vector(-19, 21, -21)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 5/30 → `TFA_CODWW2_HYDE.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 1-2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `HYDE.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 25/30 → `MagIn`; 50/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 50/30 → `Inspect2`
- `"inspect_empty"`: same
- `"suppressor_attach"`: 1/30 → `TFA_CODWW2_PPSH.SuppOn` (NOTE: uses PPSH sounds, not MP40)
- `"suppressor_remove"`: 1/30 → `TFA_CODWW2_PPSH.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`25/30` (NOTE: reload_empty is shorter than reload — unusual).

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `m2hyde/c_m2hyde_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `c_pistol_suppressor.mdl` (uses generic pistol suppressor, not hub23) | tag_weapon | false |
| clip_default | `m2hyde/c_m2hyde_clip.mdl` | tag_clip | true |
| ext_clip | `m2hyde/c_m2hyde_clip_ext.mdl` | tag_clip | false |
| sight_default | `m2hyde/c_m2hyde_sight.mdl` | tag_weapon | true |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false (bodygroup=`{[0] = 1}`) |

### WElements
| name | model | bone | active |
|---|---|---|---|
| suppressor | `w_pistol_suppressor.mdl` | tag_weapon | false |
| clip_default | `m2hyde/w_m2hyde_clip.mdl` | tag_clip | true |
| ext_clip | `m2hyde/w_m2hyde_clip_ext.mdl` | tag_clip | false |
| sight_nydar | `m2hyde/w_m2hyde_reflex.mdl` | tag_weapon | false |
| sight_default | `m2hyde/w_m2hyde_sight.mdl` | tag_weapon | true |

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = ".45 ACP"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=40, Damage=174, NumShots=1, RPM=650, DefaultClip=440, MaxAmmo=400, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=200).

---

## 19. Sten (nz_kate_codww2_sten.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Sten"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Royal Small Arms Factory"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Mid range sub machine gun."` |
| ViewModel | `"models/weapons/tfa_codww2/sten/c_sten.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/sten/w_sten.mdl"` |
| NZPaPName | `"Pencil Stencil"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STEN.Shot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_STEN.Mechy"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_STEN.Clicky"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_PPSH.Plr.Ext")}` (uses PPSH ext sound) |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `638` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `679` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `55` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=30,dmg=1}, {range=33,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.2, -2.5, 1.7)`, IronSightsAng=`Vector(1, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.202, -1, 1.34)`, IronSightsPos_LENS=`Vector(-3.198, -2, 1.783)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_STEN.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `STEN.TacMagOut`; 40/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 40/30 → `MagIn`; 60/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"`: same
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

**SequenceLengthOverride:** ACT_VM_DRAW=`25/30`, ACT_VM_DRAW_EMPTY=`25/30`, ACT_VM_RELOAD=`73/30`, ACT_VM_RELOAD_EMPTY=`88/30`.

**SequenceRateOverride:** `"sprint_loop" = 25 / 30` (only adjusts sprint_loop).

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `sten/c_sten_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | false |
| clip_default | `sten/c_sten_clip.mdl` | tag_clip | true |
| ext_clip | `sten/c_sten_clip_ext.mdl` | tag_clip | false |
| receiver_default | `sten/c_sten_receiver.mdl` | tag_weapon | true |
| barrel_default | `sten/c_sten_barrel.mdl` | tag_weapon | true |
| charm_default | `sten/c_sten_charm.mdl` (weapon-specific) | tag_weapon | true |
| sight_default | `sten/c_sten_sight.mdl` | tag_weapon | true |
| stock_default | `sten/c_sten_stock.mdl` | tag_weapon | true |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- clip_default: `sten/w_sten_clip.mdl`, tag_clip, true
- ext_clip: `sten/w_sten_clip_ext.mdl`, tag_clip, false
- receiver_default: `sten/w_sten_receiver.mdl`, tag_weapon, true
- barrel_default: `sten/w_sten_barrel.mdl`, tag_weapon, true
- sight_default: `sten/w_sten_sight.mdl`, tag_weapon, true
- stock_default: `sten/w_sten_stock.mdl`, tag_weapon, true
- sight_nydar: `sten/w_sten_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.35`, KickDown=`0.255` (NOTE: 0.255, not 0.25), KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1.25, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=165, NumShots=2, RPM=648, DefaultClip=704, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

## 20. Sterling (nz_kate_codww2_sterling.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Sterling"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Sterling Armaments"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"The Sterling SMG offers strong damage numbers with a slower fire rate than other weapons in it's class."` |
| ViewModel | `"models/weapons/tfa_codww2/sterling/c_sterling.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/sterling/w_sterling.mdl"` |
| NZPaPName | `"Scrap Trap"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_STEN.Shot"` (reuses Sten sounds) |
| Primary.SoundLyr1 | `"TFA_CODWW2_STEN.Mechy"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_STEN.Clicky"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_STEN.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `545` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `582` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `79` |
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
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=15,dmg=1}, {range=17,dmg=0.86}, {range=30,dmg=0.86}, {range=32,dmg=0.66}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-4.07, 1, 2.5)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-4.071, 0, 1.89)`, IronSightsPos_LENS=`Vector(-4.065, 0, 2.535)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 15/30 → `TFA_CODWW2_STRLNG.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `STRLNG.TacMagOut`; 35/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 35/30 → `MagIn`; 60/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 105/30 → `Inspect2` (NOTE: 105/30 = 3.5s — longest inspect in class)
- `"inspect_empty"`: same
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

**SequenceLengthOverride:** ACT_VM_DRAW=`30/30`, ACT_VM_DRAW_EMPTY=`30/30`, ACT_VM_DRAW_DEPLOYED=`45/30`, ACT_VM_RELOAD=`65/30`, ACT_VM_RELOAD_EMPTY=`95/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `sterling/c_sterling_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | false |
| clip_default | `sterling/c_sterling_clip.mdl` | tag_clip | true |
| ext_clip | `sterling/c_sterling_clip_ext.mdl` | tag_clip | false |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- clip_default: `sterling/w_sterling_clip.mdl`, tag_clip, true
- ext_clip: `sterling/w_sterling_clip_ext.mdl`, tag_clip, false
- sight_nydar: `sterling/w_sterling_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9x19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=60, Damage=237, NumShots=1, RPM=555, DefaultClip=660, MaxAmmo=600, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=300).

---

## 21. PPSh-41 / "The Classic" (nz_kate_codww2_theclassic.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"PPSh-41"` |
| HoldType | `"ar2"` |
| Manufacturer | `"too many"` (humorous — likely the source was originally planned to have multiple manufacturers) |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with a large magazine and modest damage."` |
| ViewModel | `"models/weapons/tfa_codww2/ppsh41/c_theclassic.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/ppsh41/w_ppsh41.mdl"` |
| NZPaPName | `"Dream Warrior"` |
| Spawnable | `true` (NOTE: this is the only one in this audit set without the `TFA_BASE_VERSION >= 4.7` check — file is older) |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_PPSH.Thump"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_STEN.High"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundLyr5 | `"TFA_CODWW2_EJECT.SMG"` (skips Lyr3 and Lyr4) |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_PPSH.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `900` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `80` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `70` |
| Primary.DefaultClip | `770` |
| Primary.MaxAmmo | `700` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=100,dmg=1}}` (NOTE: only one falloff point — flat damage to 100m) |

**Notable:** No `Primary.RPM_Rapid`, no `Primary.ClipSize_Ext` (only one mag — drum).

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.99, -2.75, 1.4)`, IronSightsAng=`Vector(0, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.99, -2.75, 0.88)`, IronSightsPos_LENS=`Vector(-3.985, -2.75, 1.38)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(0, -3, -0.2)`, SafetyAng=`Vector(-19, 21, -21)`.

### Animations Table
Not declared (`SWEP.Animations` absent — empty section).

### Event Table
- ACT_VM_DRAW_DEPLOYED: 15/30 → `TFA_CODWW2_PPSH.FPOCharge`; 15/30 → `TFA_CODWW2_PPSH.FPOChargeRattle` (two simultaneous sounds)
- ACT_VM_DRAW / DRAW_EMPTY: 1-2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 1/30 → `PPSH.EmptyStart`; 5/30 → `TacMagOut`; 5/30 → `TacMagOutRattle`; 35/30 → `TacMagIn`; 35/30 → `TacMagInRattle` (NOTE: dual sound at 5/30 and 35/30 — layered rattle sounds)
- ACT_VM_RELOAD_EMPTY: 1/30 → `EmptyStart`; 5/30 → `MagOut`; 5/30 → `MagOutRattle`; 35/30 → `MagIn`; 35/30 → `MagInRattle`; 60/30 → `Charge`; 60/30 → `ChargeRattle`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"inspect_empty"`: same

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`45/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| clip_default | `ppsh41/c_ppsh41_clip_ext.mdl` (NOTE: default clip uses the "ext" model — drum mag is default) | tag_clip | true |
| receiver_default | `ppsh41/c_ppsh41_receiver.mdl` | tag_weapon | true |
| barrel_default | `ppsh41/c_ppsh41_barrel.mdl` | tag_weapon | true |
| charm_default | `ppsh41/c_ppsh41_charm.mdl` | tag_weapon | true |
| sight_default | `ppsh41/c_ppsh41_sight.mdl` | tag_weapon | true |
| stock_default | `ppsh41/c_ppsh41_stock.mdl` | tag_weapon | true |

**Notable:** No sight_nydar, no suppressor VElement (since it has no supp attachment slot).

### WElements
- clip_default: `ppsh41/w_ppsh41_clip_ext.mdl`, tag_clip, true
- receiver_default: `ppsh41/w_ppsh41_receiver.mdl`, tag_weapon, true
- barrel_default: `ppsh41/w_ppsh41_barrel.mdl`, tag_weapon, true
- sight_default: `ppsh41/w_ppsh41_sight.mdl`, tag_weapon, true
- stock_default: `ppsh41/w_ppsh41_stock.mdl`, tag_weapon, true

### Attachments
**Empty table — `SWEP.Attachments = {}`**. PPSh-41 has NO attachments slots at all (no supp, no nydar, no xmag, no rifling, no stock, no rapidfire). Completely stock-locked weapon.

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "7.62×25mm Tokarev"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.3`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1.75, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=115, Damage=240, NumShots=1, RPM=910, DefaultClip=1265, MaxAmmo=1150, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=700).

---

## 22. Thompson (nz_kate_codww2_thompson.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Thompson"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Auto-Ordnance"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with moderate recoil and high fire rate."` |
| ViewModel | `"models/weapons/tfa_codww2/thompson/c_thompson.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/thompson/w_thompson.mdl"` |
| NZPaPName | `"Tommy Jarvis"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_M1928.Short.Shot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1928.Short.Snap"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_M1928.Short.Low"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("nil"), [256]=Sound("TFA_CODWW2_M1928.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `909` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `967` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `70` |
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
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=28,dmg=1}, {range=30,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.285, -0.5, 0.73)`, IronSightsAng=`Vector(0.9, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.29, -1, 0.76)`, IronSightsPos_LENS=`Vector(-3.285, -1.5, 1.015)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(0, -1.5, -0.2)`, SafetyAng=`Vector(-19, 21, -21)`.

### Animations Table
| Key | type | value |
|---|---|---|
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |
| suppressor_remove_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove_knife"` |
| suppressor_attach_knife | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach_knife"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 20/30 → `TFA_CODWW2_M1928.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 1-2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 1/30 → `M1928.Start`; 10/30 → `TacMagOut`; 40/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 1/30 → `Start`; 15/30 → `MagOut`; 45/30 → `MagIn`; 65/30 → `MagTap`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 50/30 → `Inspect2`
- `"inspect_empty"`: same
- `"draw_knife"` / `"draw_knife_empty"`: 2/30 → `SML.Raise`
- `"holster_knife"` / `"holster_knife_empty"`: 2/30 → `SML.Holster`
- `"reload_knife"`: 1/30 → `Start`; 10/30 → `TacMagOut`; 40/30 → `TacMagIn`
- `"reload_knife_empty"`: 1/30 → `Start`; 15/30 → `MagOut`; 45/30 → `MagIn`; 65/30 → `MagSmack` (NOTE: uses MagSmack, not MagTap — inconsistency with non-knife reload_empty)
- `"inspect_knife"` / `"inspect_knife_empty"`: 1/30 → `Inspect1`; 55/30 → `Inspect2`
- `"suppressor_attach"`: 2/30 → `M1928.SuppOn`
- `"suppressor_remove"`: 2/30 → `M1928.SuppOff`
- `"suppressor_attach_knife"`: 1/30 → `M1928.SuppOn` (different time than non-knife variant)
- `"suppressor_remove_knife"`: 1/30 → `M1928.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`45/30`, ACT_VM_RELOAD_EMPTY=`50/30`, reload_knife=`45/30`, reload_knife_empty=`50/30`.

### VElements
| name | model | bone | active |
|---|---|---|---|
| sight_nydar | `thompson/c_thompson_reflex.mdl` | tag_weapon | false |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false |
| suppressor | `c_pistol_suppressor.mdl` | tag_weapon | false |
| clip_default | `thompson/c_thompson_clip.mdl` | tag_clip | true |
| ext_clip | `thompson/c_thompson_clip_ext.mdl` | tag_clip | false |
| receiver_default | `thompson/c_thompson_receiver.mdl` | tag_weapon | true |
| barrel_default | `thompson/c_thompson_barrel.mdl` | tag_weapon | true |
| charm_default | `thompson/c_thompson_charm.mdl` | tag_weapon | true |
| sight_default | `thompson/c_thompson_sight.mdl` | tag_weapon | true |
| stock_default | `thompson/c_thompson_stock.mdl` | tag_weapon | true |

### WElements
- suppressor: `w_pistol_suppressor.mdl`, tag_weapon, false
- clip_default: `thompson/w_thompson_clip.mdl`, tag_clip, true
- ext_clip: `thompson/w_thompson_clip_ext.mdl`, tag_clip, false
- receiver_default: `thompson/w_thompson_receiver.mdl`, tag_weapon, true
- barrel_default: `thompson/w_thompson_barrel.mdl`, tag_weapon, true
- sight_default: `thompson/w_thompson_sight.mdl`, tag_weapon, true
- stock_default: `thompson/w_thompson_stock.mdl`, tag_weapon, true
- sight_nydar: `thompson/w_thompson_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_ani` (order 3, NOTE: uses `xmag_ani`, like MP40)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = ".45 ACP"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.3`, KickDown=`0.25`, KickHorizontal=`0.25` (NOTE: 0.25, higher than other SMGs at 0.2), StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=60, Damage=210, NumShots=2, RPM=919, DefaultClip=660, MaxAmmo=600, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=300).

---

## 23. Type 100 (nz_kate_codww2_type100.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"Type 100"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Nagoya Arsenal"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with modest damage and longest range capability in class."` |
| ViewModel | `"models/weapons/tfa_codww2/type100/c_type100.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/type100/w_type100.mdl"` |
| NZPaPName | `"Warrior's Spirit"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_TYPE100.Shoot"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_TYPE100.Sub"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_TYPE100.Mech"` |
| Primary.SoundLyr3 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("nil"), [256]=Sound("TFA_CODWW2_TYPE100.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `652` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `693` |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `40` (lowest damage SMG) |
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
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.86}, {range=36,dmg=0.86}, {range=38,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults.

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.5, -2, 1.55)`, IronSightsAng=`Vector(0.45, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.505, -2, 0.425)`, IronSightsPos_LENS=`Vector(-3.499, -2, 1.695)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| reload_ext | TFA.Enum.ANIMATION_SEQ | `"reload_ext"` |
| reload_ext_empty | TFA.Enum.ANIMATION_SEQ | `"reload_ext_empty"` |
| suppressor_remove | TFA.Enum.ANIMATION_SEQ | `"suppressor_remove"` |
| suppressor_attach | TFA.Enum.ANIMATION_SEQ | `"suppressor_attach"` |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_TYPE100.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 1-2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `TYPE100.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 30/30 → `MagIn`; 50/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 45/30 → `Inspect2`
- `"inspect_empty"`: same
- `"reload_ext"`: 5/30 → `TacMagOut`; 30/30 → `TacMagIn`
- `"reload_ext_empty"`: 5/30 → `MagOut`; 30/30 → `MagIn`; 50/30 → `Charge`
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`35/30`, ACT_VM_RELOAD_EMPTY=`35/30`, reload_ext=`35/30`, reload_ext_empty=`35/30`.

### VElements
| name | model | bone | active | bodygroup |
|---|---|---|---|---|
| sight_nydar | `type100/c_type100_reflex.mdl` | tag_weapon | false | `{}` |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false | `{}` |
| suppressor | `c_suppressor_hub23.mdl` | tag_weapon | false | `{}` |
| clip_default | `type100/c_type100_clip.mdl` | tag_clip | true | `{}` |
| ext_clip | `type100/c_type100_clip_ext.mdl` | tag_clip | false | `{}` |
| receiver_default | `type100/c_type100_receiver.mdl` | tag_weapon | true | `{}` |
| barrel_default | `type100/c_type100_barrel.mdl` | tag_weapon | true | `{}` |
| charm_default | `type100/c_type100_charm.mdl` (weapon-specific) | tag_weapon | true | `{[0] = 1}` |
| sights_default | `type100/c_type100_sight.mdl` | tag_weapon | true | `{}` |
| stock_default | `type100/c_type100_stock.mdl` | tag_weapon | true | `{}` |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `type100/w_type100_clip.mdl`, tag_clip, true
- ext_clip: `type100/w_type100_clip_ext.mdl`, tag_clip, false
- receiver_default: `type100/w_type100_receiver.mdl`, tag_weapon, true
- barrel_default: `type100/w_type100_barrel.mdl`, tag_weapon, true
- sights_default: `type100/w_type100_sight.mdl`, tag_weapon, true
- stock_default: `type100/w_type100_stock.mdl`, tag_weapon, true
- sight_nydar: `type100/w_type100_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp` (order 1)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag` (order 3, NOTE: uses regular xmag)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire`, `tfa_codww2_fmj` (order 6)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "8×22mm Nambu"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.3`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, -1, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=50, Damage=120, NumShots=2, RPM=662, DefaultClip=550, MaxAmmo=500, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=300).

---

## 24. ZK-383 (nz_kate_codww2_zk383.lua)

### Core Fields
| Field | Value |
|---|---|
| PrintName | `"ZK-383"` |
| HoldType | `"ar2"` |
| Manufacturer | `"Zbrojovka Brno"` |
| Type_Displayed | `"Submachine Gun"` |
| Purpose | `"Automatic SMG with built-in selective fire attachment that offers two firing modes. Fast firing is more effective in close quarters, while slow firing offers strong mid-range fighting capability."` |
| ViewModel | `"models/weapons/tfa_codww2/zk383/c_zk383.mdl"` |
| WorldModel | `"models/weapons/tfa_codww2/zk383/w_zk383.mdl"` |
| NZPaPName | `"Zak Bagans"` |

### Primary Stats
| Field | Value |
|---|---|
| Primary.Sound | `"TFA_CODWW2_ZK383.Lyr1"` |
| Primary.SoundLyr1 | `"TFA_CODWW2_M1941.Trans"` |
| Primary.SoundLyr2 | `"TFA_CODWW2_ZK383.Lyr3"` (NOTE: skips from Lyr2 → Lyr3 using ZK383.Lyr3) |
| Primary.SoundLyr3 | `"TFA_CODWW2_PLAYER.Sub.extra_short"` |
| Primary.SoundLyr4 | `"TFA_CODWW2_EJECT.SMG"` |
| Primary.SilencedSound | `"TFA_CODWW2_SUPP.SMG"` |
| Primary.SoundEchoTable | `{[0]=Sound("TFA_CODWW2_TAIL.Int"), [256]=Sound("TFA_CODWW2_MP28.Ext")}` |
| Primary.Sound_DryFire | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Sound_Blocked | `"TFA_CODWW2_DRYFIRE.SMG"` |
| Primary.Ammo | `"smg1"` |
| Primary.Automatic | `true` |
| Primary.RPM | `652` |
| Primary.RPM_Semi | `nil` |
| Primary.RPM_Burst | `nil` |
| Primary.RPM_Rapid | `810` (highest rapid-fire gap — 158 RPM over base) |
| NZHeadShotMultiplier | `2` |
| Primary.Damage | `76` |
| Primary.Knockback | `0` |
| Primary.NumShots | `1` |
| Primary.AmmoConsumption | `1` |
| Primary.ClipSize | `32` |
| Primary.ClipSize_Ext | `48` |
| Primary.DefaultClip | `352` |
| Primary.MaxAmmo | `320` |
| Primary.DryFireDelay | `0.35` |
| DisableChambering | `true` |
| FlashlightAttachment | `0` |
| FiresUnderwater | `true` |
| Primary.RangeFalloffLUT | units=`"meters"`, lut=`{{range=20,dmg=1}, {range=22,dmg=0.86}, {range=36,dmg=0.86}, {range=38,dmg=0.65}}` |

### Secondary Stats (Bash)
Standard SMG bash.

### Fire Modes
DefaultFireMode=`"1"`, defaults. (NOTE: Per Purpose text, the ZK-383 has a built-in selective fire attachment — see Attachments slot 6 `tfa_codww2_rapidfire_zk` which is the unique ZK variant.)

### LowAmmo
Standard SMG.

### Ironsights
IronSightsPos=`Vector(-3.655, -3, 1.96)`, IronSightsAng=`Vector(0.4, 0, 0)`, IronSightsPos_NYDAR=`Vector(-3.655, -3, 1.575)`, IronSightsPos_LENS=`Vector(-3.646, -3, 1.983)`, IronSightTime=`0.3`, Secondary.IronFOV=`75`.

InspectPos=`Vector(10, -4, -2)`, InspectAng=`Vector(24, 42, 16)`.
SafetyPos=`Vector(-1.5, -2, -0.2)`, SafetyAng=`Vector(-15, 10, -25)`.

### Animations Table
| Key | type | value |
|---|---|---|
| rof_switch | TFA.Enum.ANIMATION_SEQ | `"rof_switch"` (unique animation for the rapidfire toggle) |

### Event Table
- ACT_VM_DRAW_DEPLOYED: 10/30 → `TFA_CODWW2_ZK383.FPOCharge`
- ACT_VM_DRAW / DRAW_EMPTY: 2/30 → `TFA_CODWW2_SML.Raise`
- ACT_VM_HOLSTER / HOLSTER_EMPTY: 2/30 → `TFA_CODWW2_SML.Holster`
- ACT_VM_RELOAD: 5/30 → `ZK383.TacMagOut`; 30/30 → `TacMagIn`
- ACT_VM_RELOAD_EMPTY: 5/30 → `MagOut`; 25/30 → `MagIn`; 55/30 → `Charge`
- ACT_VM_FIDGET: 1/30 → `Inspect1`; 50/30 → `Inspect2`
- `"inspect_empty"`: same
- `"suppressor_attach"`: 1/30 → `MP40.SuppOn`
- `"suppressor_remove"`: 1/30 → `MP40.SuppOff`
- `"rof_switch"`: 1/30 → `TFA_CODWW2_GEN.Switch` (the rapidfire toggle sound)

### Sequence Overrides
**StatusLengthOverride:** ACT_VM_RELOAD=`40/30`, ACT_VM_RELOAD_EMPTY=`40/30`, reload_knife=`40/30`, reload_knife_empty=`40/30`.

### VElements
| name | model | bone | active | bodygroup |
|---|---|---|---|---|
| sight_nydar | `zk383/c_zk383_reflex.mdl` | tag_weapon | false | `{}` |
| sight_nydar_lens | conditional or nil |
| lens_sight | `c_lens_sight.mdl` | tag_weapon | false | `{}` |
| suppressor | `c_suppressor_hub23.mdl` | tag_weapon | false | `{}` |
| clip_default | `zk383/c_zk383_clip.mdl` | tag_clip | true | `{}` |
| ext_clip | `zk383/c_zk383_clip_ext.mdl` | tag_clip | false | `{}` |
| sight_default | `zk383/c_zk383_sight.mdl` | tag_weapon | true | `{}` |
| charm_default | `bar/c_bar_charm.mdl` | tag_weapon | false | `{[0] = 1}` |

### WElements
- suppressor: `w_suppressor_hub23.mdl`, tag_weapon, false
- clip_default: `zk383/w_zk383_clip.mdl`, tag_clip, true
- ext_clip: `zk383/w_zk383_clip_ext.mdl`, tag_clip, false
- sight_default: `zk383/w_zk383_sight.mdl`, tag_weapon, true
- sight_nydar: `zk383/w_zk383_reflex.mdl`, tag_weapon, false

### Attachments
1: `tfa_codww2_supp_pistol` (order 1, NOTE: uses supp_pistol, not supp — only SMG with pistol suppressor)
2: `tfa_codww2_nydar`, `tfa_codww2_lens_sight` (order 2)
3: `tfa_codww2_xmag_noani` (order 3)
4: `tfa_codww2_rifling`, `tfa_codww2_steadyaim` (order 4)
5: `tfa_codww2_stock`, `tfa_codww2_quickdraw`, `tfa_codww2_grip` (order 5)
6: `tfa_codww2_rapidfire_zk`, `tfa_codww2_fmj` (order 6, NOTE: uses `rapidfire_zk` — the unique ZK-383 selective-fire toggle attachment)

### Miscellaneous
AmmoTypeStrings=`{["smg1"] = "9×19mm Parabellum"}`, DInv2_GridSizeY=`3`, DInv2_Mass=`5`, TracerCount=`3`, LuaShellScale=`1.1`, ViewModelPunch_MaxVertialOffset=`2.5`, IronRecoilMultiplier=`0.65`, KickUp=`0.4`, KickDown=`0.25`, KickHorizontal=`0.2`, StaticRecoilFactor=`0.4`, SpreadMultiplierMax=`5`, SpreadIncrement=`1`, SpreadRecovery=`6`, CrouchRecoilMultiplier=`0.8`, JumpRecoilMultiplier=`1.3`, WallRecoilMultiplier=`1.0`, CrouchAccuracyMultiplier=`0.85`, JumpAccuracyMultiplier=`3.5`, Sprint_Mode=`TFA.Enum.LOCOMOTION_ANI`, SprintBobMult=`0`, VMPos=`Vector(0, 0, 0)`.

### Custom Functions
**`SWEP:OnPaP()`** — Primary_TFA: ClipSize=64, Damage=228, NumShots=1, RPM=752, DefaultClip=704, MaxAmmo=640, Automatic=true. MuzzleFlashEffect="muz_pap".

**`SWEP:NZMaxAmmo()`** — standard (MaxAmmo=320).

---

# Cross-Weapon Summary Tables

## A. Primary Stat Comparison Table

| Weapon | PrintName | Ammo | RPM | RPM_Rapid | Dmg | ClipSize | ClipSize_Ext | DefaultClip | MaxAmmo | Auto? |
|---|---|---|---|---|---|---|---|---|---|---|
| 1911 | 1911 | pistol | 670 | — | 10 | 8 | 10 | 40 | — | false |
| 1911_Up | Bacon & Eggs | pistol | 680 | — | 1115 | 7 | — | 49 | — | false |
| Luger | P08 | pistol | 670 | — | 10 | 8 | 12 | 88 | 80 | false |
| M712 | Machine Pistol | pistol | 722 | — | 186 | 10 | 15 | 110 | 100 | true |
| Nambu | Nambu Type 2 | smg1 | 769 | 726 | 78 | 30 | 45 | 330 | 300 | true |
| No2 | Enfield No. 2 | 357 | 285 | — | 800 | 6 | 8 | 66 | 60 | false |
| P38 | 9mm SAP | pistol | 670 | — | 10 | 8 | 12 | 88 | 80 | false |
| M1879 | Reichsrevolver | 357 | 342 | — | 650 | 6 | 8 | 66 | 60 | false |
| Austen | Austen | smg1 | 600 | 638 | 55 | 25 | 35 | 275 | 250 | true |
| Bechowiec | Bechowiec | smg1 | 830 | 882 | 50 | 32 | 45 | 352 | 320 | true |
| Blyskawica | Blyskawica | smg1 | 750 | 785 | 65 | 30 | 45 | 330 | 300 | true |
| Chatellerault | Chatellerault | ar2 | 510 | 545 | 200 | 25 | 37 | 275 | 250 | true |
| Erma | Erma EMP | smg1 | 588 | 631 | 67 | 32 | 48 | 352 | 320 | true |
| Greasegun | Grease Gun | smg1 | 545 | 582 | 52 | 30 | 45 | 330 | 300 | true |
| MP28 | Waffe 28 | smg1 | 1000 | 1071 | 71 | 32 | 48 | 352 | 320 | true |
| MP40 | MP40 | smg1 | 689 | 740 | 53 | 32 | 48 | 352 | 320 | true |
| M1928A1 | M1928 | smg1 | 909 | 967 | 72 | 50 | — | 550 | 500 | true |
| M2Hyde | M267 | smg1 | 640 | 681 | 58 | 20 | 30 | 220 | 200 | true |
| Sten | Sten | smg1 | 638 | 679 | 55 | 32 | 48 | 352 | 320 | true |
| Sterling | Sterling | smg1 | 545 | 582 | 79 | 30 | 45 | 330 | 300 | true |
| TheClassic | PPSh-41 | smg1 | 900 | — | 80 | 70 | — | 770 | 700 | true |
| Thompson | Thompson | smg1 | 909 | 967 | 70 | 30 | 45 | 330 | 300 | true |
| Type100 | Type 100 | smg1 | 652 | 693 | 40 | 30 | 45 | 330 | 300 | true |
| ZK383 | ZK-383 | smg1 | 652 | 810 | 76 | 32 | 48 | 352 | 320 | true |

## B. OnPaP Damage / RPM Comparison

| Weapon | PaP Name | PaP Dmg | PaP RPM | PaP ClipSize | PaP NumShots | PaP Auto? |
|---|---|---|---|---|---|---|
| Luger | P.O.S. | 835 | 680 | 16 | 2 | true (also forces 2Burst) |
| M712 | Zuverlässige Seitenwaffe | 558 | 732 | 50 | 1 | true |
| Nambu | Sleeping Dragon | 234 | 779 | 60 | 1 | true |
| No2 | Break Action | 2400 | 295 | 12 | 2 | false |
| P38 | Taschenlocher | 825 | 680 | 16 | 4 | false |
| M1879 | Rotierendes Blutbad | 1950 | 352 | 16 | 1 | false |
| Austen | Kangaroo Killer | 165 | 610 | 50 | 2 | true |
| Bechowiec | Pepper Shaker | 150 | 840 | 64 | 3 | true |
| Blyskawica | Zasadzka | 195 | 760 | 60 | 1 | true |
| Chatellerault | Chatter Box | 600 | 520 | 50 | 1 | true |
| Erma | ERRRM, ACKSHUALLY... | 201 | 598 | 64 | 1 | true |
| Greasegun | BBQ Bacon Burger | 156 | 555 | 64 | 2 | true |
| MP28 | Hyper Activity | 213 | 1010 | 64 | 1 | true |
| MP40 | Mitternachtsmorde | 159 | 699 | 64 | 1 | true |
| M1928A1 | Typewriter | 216 | 919 | 100 | 1 | true |
| M2Hyde | Dr. Jekyll | 174 | 650 | 40 | 1 | true |
| Sten | Pencil Stencil | 165 | 648 | 64 | 2 | true |
| Sterling | Scrap Trap | 237 | 555 | 60 | 1 | true |
| TheClassic | Dream Warrior | 240 | 910 | 115 | 1 | true |
| Thompson | Tommy Jarvis | 210 | 919 | 60 | 2 | true |
| Type100 | Warrior's Spirit | 120 | 662 | 50 | 2 | true |
| ZK383 | Zak Bagans | 228 | 752 | 64 | 1 | true |

## C. Attachment Layout Comparison

| Weapon | Suppressor slot | Sight slot | Xmag slot | Special |
|---|---|---|---|---|
| 1911 | tfa_codww2_supp_pistol | (none) | tfa_codww2_xmag | has akimbo (slot 6) + AttachmentExclusions |
| 1911_Up | (none) | (none) | (none) | forced akimbo default |
| Luger | tfa_codww2_supp_pistol | (none) | tfa_codww2_xmag | — |
| M712 | tfa_codww2_supp_pistol | (none) | tfa_codww2_xmag | — |
| Nambu | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| No2 | tfa_codww2_supp_pistol | (none) | xmag_noani | — |
| P38 | tfa_codww2_supp_pistol | (none) | tfa_codww2_xmag | — |
| M1879 | tfa_codww2_supp_pistol | (none) | xmag_noani | — |
| Austen | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| Bechowiec | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| Blyskawica | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| Chatellerault | (none — slot 1 absent) | nydar, **4x (ACOG)** | xmag | unique bipod/scope/bipod elements |
| Erma | tfa_codww2_supp | nydar, lens_sight | xmag_noani | has ViewModelBoneMods entry |
| Greasegun | tfa_codww2_supp | nydar, lens_sight | xmag | weapon-specific suppressor model |
| MP28 | tfa_codww2_supp | nydar, lens_sight | xmag_noani | weapon-specific charm model |
| MP40 | tfa_codww2_supp | nydar, lens_sight | **xmag_ani** | only SMG with animated xmag |
| M1928A1 | (none — slots 1,2,3 absent) | (none) | (none) | drum-mag default, no suppressor/nydar/xmag slots |
| M2Hyde | tfa_codww2_supp | nydar, lens_sight | xmag_noani | uses PPSH.SuppOn/Off sounds |
| Sten | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| Sterling | tfa_codww2_supp | nydar, lens_sight | xmag_noani | — |
| TheClassic | (none — Attachments={}) | (none) | (none) | no attachment slots at all |
| Thompson | tfa_codww2_supp | nydar, lens_sight | **xmag_ani** | uses M1928 reload/inspect sounds |
| Type100 | tfa_codww2_supp | nydar, lens_sight | xmag | weapon-specific charm model |
| ZK383 | **tfa_codww2_supp_pistol** | nydar, lens_sight | xmag_noani | **unique `tfa_codww2_rapidfire_zk` toggle** in slot 6 |

## D. Custom ShootBullet / Projectile Weapons

Only one weapon in the set overrides the base ShootBullet:

- **`nz_kate_codww2_1911_upgraded.lua`** — implements `SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)` which spawns `codww2_mustang_exp` entities (one per num_bullets) at velocity `13330` HU/s with a fixed aimcone of 3, and a fixed projectile model. This effectively makes the upgraded 1911 a projectile (grenade-like) launcher.

## E. OnPaP Special Behaviours

- **Luger** OnPaP uniquely forces `self.FireModes = {"2Burst"}` (changing the weapon's firing mode after PaP).
- **Erma** OnPaP additionally sets `SWEP.Primary.Knockback = 0` (no-op quirk).
- **All others** simply mutate `Primary_TFA` (ClipSize, Damage, NumShots, RPM, DefaultClip, MaxAmmo, Automatic) and set `MuzzleFlashEffect = "muz_pap"`.

## F. NZMaxAmmo Implementation

All non-pistol-classified weapons (everything except the 1911 base pistol and 1911 upgraded) implement `SWEP:NZMaxAmmo()` with the identical body:

```lua
function SWEP:NZMaxAmmo()
    if CLIENT then return end
    self:GetOwner():SetAmmo(self.Primary.MaxAmmo, self:GetPrimaryAmmoType())
    self:SetClip1(self.Primary.ClipSize)
end
```

The base 1911 and 1911_upgraded do **not** override `NZMaxAmmo` (so they inherit base behavior).

## G. Lua-Shell Configuration

| Weapon | LuaShellModel | LuaShellScale | LuaShellEject | EjectionSmokeEnabled |
|---|---|---|---|---|
| All Pistols (semi-auto) | fx_9mm.mdl | 1.2 | true | true |
| No2 (revolver) | fx_9mm.mdl | 1.2 | **false** | **false** |
| M1879 (revolver, shotgun=true) | fx_9mm.mdl | 1.2 | **false** | **false** |
| All SMGs | fx_9mm.mdl | **1.1** | true | true |
| Chatellerault | **fx_556.mdl** | 1.1 | true | true |

## H. Unique/Notable Quirks Catalogue

1. **1911 base**: Only pistol with `NZPaPReplacement` (`"tfa_vg_mustangsally"` — externally replaced) rather than `OnPaP` + `NZPaPName`.
2. **1911 Upgraded**: Only weapon with custom `ShootBullet` + projectile (`codww2_mustang_exp`) + PaP laser effects (`pap_laz_tra`, `pap_laz_muz`). Offset.Ang differs significantly (Up=-90 vs Up=180).
3. **Luger**: Only pistol with `SWEP.FireModes = {"2Burst"}` mutation inside `OnPaP`.
4. **M712**: Categorised SubCategory=`"Pistols"` but Type_Displayed=`"Machine Pistol"` and Automatic=true; uses a mix of PPSH/MG42/TYPE100 sound layers.
5. **Nambu**: SubCategory=`"Submachine Guns"` and Slot=`2` despite being included in the pistol audit list — classification mismatch.
6. **No2**: Only pistol with FireModeName=`"Double-Action"`. Uses `1911.Inspect1/2` sounds for inspect_knife (likely a copy-paste bug).
7. **P38**: Suppressors and tac_knife VElements use bone `tag_clip` (not `tag_weapon`) — unusual and may be a typo. WElements even uses the c_ view model for the suppressor (rather than w_).
8. **M1879**: Only pistol with `SWEP.Shotgun = true` (shotgun-style reload). Also has FireModeName=`"Single-Action"`. Has 6 sound layers (Lyr1-6) — most of any pistol.
9. **Bechowiec**: HoldType=`"rpg"` (almost certainly a typo — should be `"smg"`). Uses MP40 reload/inspect sounds (no Bechowiec-specific reload/inspect sounds).
10. **Chatellerault**: Classified as LMG (Slot=3, SubCategory=`"Light Machine Guns"`, Ammo=`"ar2"`, IronFOV=70, MoveSpeed=0.9). Has unique ACOG scope and bipod VElements. JumpRecoilMultiplier=2.65 (vs ~1.3 for SMGs). MuzzleFlashEffect declared as `"tfa_muzzleflash_rifle"`. FiresUnderwater=false (only weapon in set with this).
11. **Erma**: SoundLyr5 set but Lyr3/Lyr4 skipped. ViewModelBoneMods has a `tag_charm_base` entry (only Erma and M1928A1 have this).
12. **Greasegun**: Animations table has `suppressor_attach_knife` with value `"suppressor_attach"` (without `_knife` suffix) — copy-paste bug. Uses weapon-specific suppressor model rather than generic hub23.
13. **MP40**: EventTable uses different table syntax for suppressor_attach/remove (`time = 0.01` instead of `1/30`, and `value = Sound"..."` without parentheses). Only SMG with `tfa_codww2_xmag_ani` (animated ext mag).
14. **M1928A1**: Only weapon with `SequenceRateOverride["fire_ads"] = 30/45`. Default mag is the ext_clip (drum) — no `clip_default` element. Attachments table only has slots 4, 5, 6 (no suppressor/sight/xmag slots). Reload_empty uses `MagTap` instead of `Charge`. ViewModelBoneMods has `tag_charm_base` entry (like Erma).
15. **M2Hyde**: StatusLengthOverride for reload_empty (25/30) is shorter than reload (35/30) — unusual. Uses PPSH.SuppOn/Off sounds (not MP40).
16. **Sten**: KickDown=`0.255` (vs 0.25 everywhere else — likely typo). SoundEchoTable[256] reuses `TFA_CODWW2_PPSH.Plr.Ext` (not Sten's own Ext). SequenceRateOverride only adjusts `sprint_loop`.
17. **Sterling**: FIDGET Inspect2 at 105/30 = 3.5s (longest inspect). Reuses Sten fire sounds entirely (no Sterling-specific fire sound).
18. **PPSh-41 / TheClassic**: Only weapon with `SWEP.Spawnable = true` (no TFA_BASE_VERSION check — older file). Manufacturer=`"too many"` (humorous). Attachments table empty (no slots). VElements default mag is `c_ppsh41_clip_ext.mdl` (drum mag is default). EventTable has dual simultaneous sounds at 5/30 and 35/30 (rattle layers). DefaultClip=770 (very high — matches drum mag).
19. **Thompson**: EventTable has `MagSmack` for reload_knife_empty vs `MagTap` for reload_empty — inconsistent sound naming. Only SMG with `KickHorizontal = 0.25` (vs 0.2 elsewhere).
20. **ZK383**: Only weapon with `rof_switch` animation and `tfa_codww2_rapidfire_zk` attachment (a unique selective-fire toggle attachment). Slot 1 uses `tfa_codww2_supp_pistol` (only SMG with pistol suppressor instead of regular SMG suppressor). SoundLyr ordering unusual (SoundLyr2 = ZK383.Lyr3). RPM_Rapid=810 gives a 158 RPM rapid-fire boost (largest gap in the SMG class).

## I. Code Quality Observations

- All 24 files share near-identical structure (sections in order: Core, Model, NZombies/OnPaP, Gun Related, Firemode, Range, Recoil, Spread, Bash, IronSights, Shells, Jamming, Misc, DInventory2, Animations, Tables/StatusLengthOverride, SprintAnimation, EventTable, Shit, Attachments).
- Multiple files have inconsistencies that suggest copy-paste development (see "Unique/Notable Quirks" above).
- The base 1911 file uses `SWEP.NZPaPReplacement` (external replacement) instead of `SWEP:OnPaP()` — unique pattern in this set; all others use `OnPaP`.
- The 1911 upgraded file is the only one with a `SWEP:ShootBullet` override and projectile logic.
- The base 1911 has `DefaultClip = SWEP.Primary.ClipSize * 5` (formula) — most others hardcode the value.
- 7 weapons use `tfa_codww2_xmag_noani` (Nambu, No2, M1879, Austen, Bechowiec, Blyskawica, Erma, M2Hyde, Sten, Sterling, ZK383), 2 use `tfa_codww2_xmag_ani` (MP40, Thompson), 4 use plain `tfa_codww2_xmag` (1911, Luger, M712, P38, Greasegun, Type100, Chatellerault). M1928A1 and TheClassic have no xmag slot.

## J. Next Actions / Recommendations

1. **Verify copy-paste bugs**:
   - P38 VElement bones for suppressor and tac_knife are `tag_clip` — likely should be `tag_weapon`.
   - Bechowiec HoldType=`"rpg"` — likely should be `"smg"`.
   - Bechowiec reload/inspect reuse MP40 sounds (no Bechowiec-specific reload/inspect sounds authored).
   - MP40 suppressor EventTable uses non-standard `value = Sound"..."` (without parentheses) and `time = 0.01` (not `1/30`).
   - No2 inspect_knife reuses `TFA_CODWW2_1911.Inspect1/Inspect2` sounds (not NO2-specific).
   - Sten KickDown=`0.255` (off-by-one digit from 0.25).
   - Thompson reload_knife_empty uses `MagSmack` while reload_empty uses `MagTap` — investigate which is correct.
   - Greasegun `suppressor_attach_knife` animation value is `"suppressor_attach"` (not `"suppressor_attach_knife"`).
2. **Investigate Nambu classification** — file is in SubCategory=`"Submachine Guns"` but is in the pistol audit list (per user instruction). Decide whether to reclassify the SubCategory as `"Pistols"` (matching user expectation) or leave the source classification.
3. **Verify Chatellerault inclusion** — file is in SubCategory=`"Light Machine Guns"`, Slot=`3`, Ammo=`"ar2"` — definitely an LMG, not an SMG.
4. **Document PPSh-41 (TheClassic) attachment absence** — confirm intentional that this weapon has no attachment slots.
5. **Verify ZK-383 selective fire mechanic** — confirm the `tfa_codww2_rapidfire_zk` attachment and `rof_switch` animation are wired up correctly to switch RPM between 652 (base) and 810 (rapid).
6. **Confirm 1911 base Pistol's `NZPaPReplacement = "tfa_vg_mustangsally"`** is the intended behaviour (replace on PaP rather than mutate stats in-place). The `1911_upgraded.lua` file is the pre-PaP'd version with its own `ShootBullet` projectile logic — verify the projectile entity `codww2_mustang_exp` exists and is registered.

---

**End of audit.**
