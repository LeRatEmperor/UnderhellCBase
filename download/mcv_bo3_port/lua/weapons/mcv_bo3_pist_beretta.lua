-- Beretta (ported from weapon_uh_pist_beretta to MCV base)
-- Source: Underhell base by Krede, ported to mcv_bo3_base

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "Beretta"
SWEP.Category    = "Black Ops 3 (MCV Port)"
SWEP.SubCategory = "Pistols"
SWEP.Country     = "Italy"
SWEP.Caliber     = "9x19mm"

SWEP.Slot        = 1
SWEP.HoldType    = "pistol"
SWEP.AimHoldType = "revolver"  -- MCV has no "pistol aimed" hold type; revolver is closest

SWEP.ViewModel    = "models/weapons/v_pist_beretta_pg.mdl"
SWEP.WorldModel   = "models/weapons/w_pist_beretta_pg.mdl"
SWEP.ViewModelFOV = 64

-- Ironsights (UH -> MCV: same axes, Vector -> Angle)
SWEP.IronsightPos = Vector(-4.12, -4.321, 1.879)
SWEP.IronsightAng = Angle(0, 0, 0)

-- Damage: UH had MinDamage 17 / MaxDamage 19 -> average 18
SWEP.DamageGeneric        = 18
SWEP.DamageHeadMultiplier = 2.0    -- MCV-specific; UH had no headshot mult
SWEP.DamageChestMultiplier = 1.0
SWEP.DamageStomachMultiplier = 1.0
SWEP.DamageLegMultiplier  = 0.8
SWEP.DamageArmMultiplier  = 0.8

-- Fire rate: UH Primary.Delay 0.14 -> 60/0.14 = 428 RPM
SWEP.FireRate    = 428
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.95

-- Spread: UH Primary.Spread 0.08 (tight pistol) -> MCV ~6 / 1.0 (rough conversion)
-- Note: the scales are different; tune to taste in-game.
SWEP.Spread           = 6.0
SWEP.SpreadIronsighted = 1.0

-- Recoil: UH MinRecoil -0.8 / MaxRecoil -1.1 -> average -0.95 -> MCV ViewSlideRecoilUp 1.0
SWEP.ViewSlideRecoilUp    = 1.0
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.7
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 0.8

SWEP.ShakeScale    = 0.6
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.2

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

-- Ammo
SWEP.Primary.Ammo         = "pistol"
SWEP.Primary.ClipSize      = 15
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 30
SWEP.Primary.Automatic    = false

-- Fire modes (UH had only "Semi-Auto")
SWEP.Firemodes = { MCV.FIREMODE_SEMI }

-- Sound (UH Primary.Sound + SilSound)
SWEP.SoundSingleShot = "weapons/uh_beretta/beretta_fire.wav"
SWEP.SoundEmpty      = "Weapon_Pistol.Empty"
SWEP.SoundNearlyEmpty = "Weapon_Pistol.Empty"

-- Particles (defaults; override per-weapon if BO3 has custom ones)
SWEP.MuzzleParticle          = "vietnam_muzzleflash_pistol_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_pistol_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_pistol_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_pistol_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_pistol_type1_tp"

SWEP.EjectBrassType   = 2
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_pistol_primary"
SWEP.TracerParticle2  = "vietnam_tracer_pistol_secondary"
SWEP.TracerFrequency  = 4

-- Silencer support (bodygroup only for v1)
SWEP.HasSilencer = true

-- Penetration (pistol-caliber defaults)
SWEP.MetalPenetrationDepth = 4
SWEP.GlassPenetrationDepth = 8
SWEP.ConcretePenetrationDepth = 5
SWEP.WoodPenetrationDepth = 10
SWEP.OtherPenetrationDepth = 6

-- UH reload sound timeline
SWEP.UseReloadTable = true
SWEP.ReloadTable = {
    {delay = 1.0, sound = "weapons/uh_beretta/beretta_sliderelease.wav"},
    {delay = 0.1, sound = "weapons/uh_beretta/beretta_clipout.wav"},
    {delay = 0.6, sound = "weapons/uh_beretta/beretta_clipin.wav"},
    {delay = 0.0, sound = "weapons/uh_beretta/beretta_slideback.wav"},
}

-- Animation remap. UH put ACT_VM_RELOAD string here as a placeholder.
-- For BO3 models with real sequence names, replace with the actual seq name.
SWEP.Animations = {
    ["reload_empty"]     = "ACT_VM_RELOAD",
    ["reload_empty_sil"] = "ACT_VM_RELOAD",
    ["reload_sil"]       = "ACT_VM_RELOAD",
}

-- MCV also wants timing for mag in / out (in seconds into the reload anim).
-- Without these, the bodygroup bullet counter won't update cleanly.
-- Estimate from the ReloadTable above.
SWEP.MagInTime      = 0.6   -- clipin sound at 0.6s
SWEP.MagInTimeEmpty = 0.6
SWEP.MagOutTime     = 0.1   -- clipout sound at 0.1s
SWEP.MagOutTimeEmpty = 0.1

SWEP.WeaponWeight = 1.1
