-- G36K (ported from weapon_uh_snip_g36 to MCV base)
-- Source: Underhell base, ported to mcv_bo3_base
-- This weapon is a scoped assault rifle in UH. We treat it as a scoped rifle in MCV.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "G36K"
SWEP.Category    = "Black Ops 3 (MCV Port)"
SWEP.SubCategory = "Assault Rifles"
SWEP.Country     = "Germany"
SWEP.Caliber     = "5.56x45mm"

SWEP.Slot        = 4
SWEP.HoldType    = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/weapons/v_g36k_pg.mdl"
SWEP.WorldModel   = "models/weapons/w_g36k_pg.mdl"
SWEP.ViewModelFOV = 64

SWEP.IronsightPos = Vector(-3.6, -8.801, -0.361)
SWEP.IronsightAng = Angle(0, 0, 0)

-- Damage: UH MinDamage 45 / MaxDamage 60 -> average 52
SWEP.DamageGeneric = 52
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

-- Fire rate: UH Primary.Delay 0.25 -> 60/0.25 = 240 RPM
SWEP.FireRate    = 240
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.97

-- Spread: UH 0.04 (very tight) -> MCV ~3 / 0.5
SWEP.Spread           = 3.0
SWEP.SpreadIronsighted = 0.5

-- Recoil: UH -1 / -1.4 -> avg -1.2
SWEP.ViewSlideRecoilUp    = 1.2
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.9
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 1.5

SWEP.ShakeScale    = 1.0
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25

-- Scope: UH had ScopeTexture material + ScopeFov 10. Use MCV's RT scope system.
SWEP.HasScope = true
SWEP.ScopeMaterial = NULL   -- set this to your scope lens material if you have one
SWEP.ScopeFOV  = 10
SWEP.ScopeFOV2 = 4
SWEP.RTScopeMaterialIndex = 1
SWEP.ScopeIdleLensMaterial = ""
SWEP.AdjustableScopes = false
SWEP.ViewModelZNear = 1.5   -- scoped rifles need a closer near plane

SWEP.HasBayonet = false
SWEP.HasBipod = false

-- Ammo
SWEP.Primary.Ammo         = "ar2"
SWEP.Primary.ClipSize      = 30
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 90
SWEP.Primary.Automatic    = true   -- UH G36 also has an "Auto" firemode

-- Fire modes: UH had Semi-Auto and Auto (the latter disabling the scope)
SWEP.Firemodes = { MCV.FIREMODE_SEMI, MCV.FIREMODE_AUTO }

SWEP.SoundSingleShot = "weapons/uh_g36k/g36k_fire.wav"
SWEP.SoundEmpty = "Weapon_AR2.Empty"

-- Particles
SWEP.MuzzleParticle          = "vietnam_muzzleflash_rifle_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_rifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

SWEP.EjectBrassType   = 3  -- rifle brass
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_rifle_primary"
SWEP.TracerParticle2  = "vietnam_tracer_rifle_secondary"
SWEP.TracerFrequency  = 4

-- Penetration (5.56mm rifle)
SWEP.MetalPenetrationDepth = 8
SWEP.GlassPenetrationDepth = 14
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 18
SWEP.OtherPenetrationDepth = 12

-- UH reload sound timeline
SWEP.UseReloadTable = true
SWEP.ReloadTable = {
    {delay = 0.5, sound = "weapons/uh_g36k/g36k_deploy.wav"},
    {delay = 1.0, sound = "weapons/uh_g36k/g36k_clipout.wav"},
    {delay = 1.7, sound = "weapons/uh_g36k/g36k_clipin.wav"},
    {delay = 2.5, sound = "weapons/uh_g36k/g36k_boltpull.wav"},
}

-- Animation remap
SWEP.Animations = {
    ["reload_empty"]     = "ACT_VM_RELOAD",
    ["reload_empty_sil"] = "ACT_VM_RELOAD",
    ["reload_sil"]       = "ACT_VM_RELOAD",
}

-- MCV mag in/out timing
SWEP.MagInTime      = 1.7
SWEP.MagInTimeEmpty = 1.7
SWEP.MagOutTime     = 1.0
SWEP.MagOutTimeEmpty = 1.0

SWEP.WeaponWeight = 3.5
SWEP.Silencer = false

-- UH had ScopeBones that scaled to 0 when in non-scope firemode ("NoScope").
-- MCV doesn't support bone-scale swapping; you'd need a custom ThinkWeapon hook
-- per-weapon to do this. Dropped for v1.
