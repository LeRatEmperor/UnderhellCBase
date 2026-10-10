-- Mossberg 500A (NMRIH) ported to MCV base via mcv_nmrih_base.

AddCSLuaFile()

SWEP.Base        = "mcv_nmrih_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "Mossberg 500A"
SWEP.Category    = "TFA NMRIH (MCV Port)"

SWEP.Slot        = 3
SWEP.HoldType    = "shotgun"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/weapons/tfa_nmrih/v_fa_500a.mdl" --Viewmodel path
SWEP.WorldModel   = "models/weapons/tfa_nmrih/w_fa_500a.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50
SWEP.ViewModelFlip = false
SWEP.UseHands    = true

SWEP.IronsightPos = Vector(-2.72, 0.096, 1.679)
SWEP.IronsightAng = Angle(-0.145, 0.045, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.DamageGeneric        = 12
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = 60
SWEP.Num         = 12
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.95

SWEP.Spread           = 6.0
SWEP.SpreadIronsighted = 1.0

SWEP.ViewSlideRecoilUp    = 1.0
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.7
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 0.8

SWEP.ShakeScale    = 0.7
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 0.8
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 10

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "buckshot"
SWEP.Primary.ClipSize      = 6
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 24
SWEP.Primary.Automatic    = false

SWEP.Firemodes = { MCV.FIREMODE_SEMI }

SWEP.SoundSingleShot = "Weapon_500Pump.Single"
SWEP.SoundEmpty = "Weapon_Pistol.Empty"
SWEP.SoundNearlyEmpty = "Weapon_Pistol.Empty"

SWEP.MuzzleParticle          = "vietnam_muzzleflash_shotgun_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_shotgun_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_shotgun_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_shotgun_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_shotgun_type1_tp"

SWEP.EjectBrassType   = 4
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_shotgun_primary"
SWEP.TracerParticle2  = "vietnam_tracer_shotgun_primary_secondary"
SWEP.TracerFrequency  = 4

SWEP.MetalPenetrationDepth = 8
SWEP.GlassPenetrationDepth = 14
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 18
SWEP.OtherPenetrationDepth = 12

SWEP.MagInTime      = 1.0
SWEP.MagInTimeEmpty = 1.5
SWEP.MagOutTime     = 0.3
SWEP.MagOutTimeEmpty = 0.3

SWEP.BashDamage    = 5
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

SWEP.WeaponWeight = 3.0

SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 3.0

SWEP.ShotgunReload = true
SWEP.ShotgunReloadRounds = 1
SWEP.PlayCycleAnimation = false
SWEP.CyclePostDelay = 0.7
SWEP.LastShotAnimation = false
SWEP.NoEjectOnShoot = false
SWEP.HasEmptyReload = true
