-- MP5 EOD (ported from weapon_uh_smg_mp5_gl to MCV base)
-- Source: Underhell base, ported to mcv_bo3_base
-- Note: This weapon has a grenade launcher firemode (UH "Grenade").
--       MCV has native UBGL support; we use it instead of the UH firemode hack.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "MP5 EOD"
SWEP.Category    = "Black Ops 3 (MCV Port)"
SWEP.SubCategory = "SMGs"
SWEP.Country     = "Germany"
SWEP.Caliber     = "9x19mm"

SWEP.Slot        = 2
SWEP.HoldType    = "smg"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/weapons/v_smg_mp5_eod_pg.mdl"
SWEP.WorldModel   = "models/weapons/w_smg_mp5_eod_pg.mdl"
SWEP.ViewModelFOV = 64

SWEP.IronsightPos = Vector(-3.385, -5, 0.901)
SWEP.IronsightAng = Angle(0, 0, 0)

-- Launcher ironsights (UH GLSightsPos)
SWEP.IronsightPosLauncher = Vector(-4.16, -6.1, 0.81)
SWEP.IronsightAngLauncher = Angle(0, 1.2, 0)

-- Damage: UH MinDamage 16 / MaxDamage 17 -> average 16
SWEP.DamageGeneric = 16
SWEP.DamageHeadMultiplier = 1.8
SWEP.DamageChestMultiplier = 1.0
SWEP.DamageStomachMultiplier = 1.0
SWEP.DamageLegMultiplier  = 0.8
SWEP.DamageArmMultiplier  = 0.8

-- Fire rate: UH Primary.Delay 0.08 -> 60/0.08 = 750 RPM
SWEP.FireRate    = 750
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.95

-- Spread: UH 0.18 -> MCV ~8 / 2.0
SWEP.Spread           = 8.0
SWEP.SpreadIronsighted = 2.0

-- Recoil: UH -0.6 / -1.1 -> avg -0.85
SWEP.ViewSlideRecoilUp    = 0.85
SWEP.ViewSlideRecoilRight = 0.25
SWEP.ViewSlideRecoilIronsightUp    = 0.6
SWEP.ViewSlideRecoilIronsightRight = 0.15
SWEP.RecoilPushbackValue = 0.8

SWEP.ShakeScale    = 0.6
SWEP.ShakeFreq     = 55
SWEP.ShakeDuration = 0.2

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

-- Ammo
SWEP.Primary.Ammo         = "smg1"
SWEP.Primary.ClipSize      = 30
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 60
SWEP.Primary.Automatic    = true

-- Fire modes (UH had Auto / Semi-Auto / Grenade)
-- MCV native firemodes: AUTO and SEMI. The grenade mode is now a UBGL.
SWEP.Firemodes = { MCV.FIREMODE_AUTO, MCV.FIREMODE_SEMI }

-- UBGL setup (replaces UH "Grenade" firemode)
SWEP.HasRifleGrenade   = true
SWEP.RifleGrenadeIsUBGL = true
SWEP.RifleGrenadeEntity = "mcv_proj_40mm"
SWEP.RifleGrenadeForce  = 5000

-- Secondary ammo (UBGL)
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "smg1_grenade"
SWEP.Secondary.ClipSize    = -1   -- UBGL ammo is reserve, no clip
SWEP.Secondary.DefaultClip = 0

SWEP.SoundSingleShot = "weapons/uh_mp5eod/mp5_fire.wav"
SWEP.SoundGrenadeShot = "weapons/uh_glauncher/fire.wav"
SWEP.SoundEmpty = "Weapon_SMG1.Empty"

-- Particles
SWEP.MuzzleParticle          = "vietnam_muzzleflash_smg_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_smg_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_smg_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_smg_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_smg_type1_tp"

SWEP.EjectBrassType   = 2  -- 9mm
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_smg_primary"
SWEP.TracerParticle2  = "vietnam_tracer_smg_secondary"
SWEP.TracerFrequency  = 4

-- Penetration (SMG, lower than rifle)
SWEP.MetalPenetrationDepth = 6
SWEP.GlassPenetrationDepth = 10
SWEP.ConcretePenetrationDepth = 7
SWEP.WoodPenetrationDepth = 14
SWEP.OtherPenetrationDepth = 9

-- UH reload sound timeline
SWEP.UseReloadTable = true
SWEP.ReloadTable = {
    {delay = 0.4, sound = "weapons/uh_mp5eod/mp5_boltslap.wav"},
    {delay = 1.0, sound = "weapons/uh_mp5eod/mp5_clipout.wav"},
    {delay = 2.5, sound = "weapons/uh_mp5eod/mp5_clipin.wav"},
    {delay = 3.3, sound = "weapons/uh_mp5eod/mp5_boltpull.wav"},
}

-- Animation remap
SWEP.Animations = {
    ["reload_empty"] = "ACT_VM_RELOAD",
}

-- MCV mag in/out timing (estimated from ReloadTable above)
SWEP.MagInTime      = 2.5   -- clipin sound at 2.5s
SWEP.MagInTimeEmpty = 2.5
SWEP.MagOutTime     = 1.0   -- clipout sound at 1.0s
SWEP.MagOutTimeEmpty = 1.0
SWEP.MagInTimeGrenade = 0.5  -- UBGL reload

SWEP.WeaponWeight = 3.0
