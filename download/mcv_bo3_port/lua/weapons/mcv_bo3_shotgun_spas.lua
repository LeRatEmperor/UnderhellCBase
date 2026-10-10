-- Spas-12 (ported from weapon_uh_shotgun_spas to MCV base)
-- Source: Underhell shotgun base, ported to mcv_bo3_base

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "SPAS-12"
SWEP.Category    = "Black Ops 3 (MCV Port)"
SWEP.SubCategory = "Shotguns"
SWEP.Country     = "Italy"
SWEP.Caliber     = "12 Gauge"

SWEP.Slot        = 3
SWEP.HoldType    = "shotgun"
SWEP.AimHoldType = "rpg"  -- MCV default for shotguns

SWEP.ViewModel    = "models/weapons/v_shot_spas_pg.mdl"
SWEP.WorldModel   = "models/weapons/w_shot_spas_pg.mdl"
SWEP.ViewModelFOV = 64

SWEP.IronsightPos = Vector(-3.849, -0.141, 1.559)
SWEP.IronsightAng = Angle(0, 0.744, 0)

-- Damage: UH MinDamage 8 / MaxDamage 11 (per pellet) -> average 10
SWEP.DamageGeneric = 10
SWEP.Num           = 14  -- UH Primary.NumberofShots 14
SWEP.AmmoPerShot   = 1
SWEP.RangeModifier = 0.85

-- Spread: UH 0.39 -> MCV ~14 (shotgun-class)
SWEP.Spread           = 14.0
SWEP.SpreadIronsighted = 4.0

-- Recoil: UH -4.1 / -5.6 -> avg -4.85
SWEP.ViewSlideRecoilUp    = 4.85
SWEP.ViewSlideRecoilRight = 1.2
SWEP.ViewSlideRecoilIronsightUp    = 3.5
SWEP.ViewSlideRecoilIronsightRight = 0.8
SWEP.RecoilPushbackValue = 3.0

SWEP.ShakeScale    = 2.0
SWEP.ShakeFreq     = 45
SWEP.ShakeDuration = 0.4

SWEP.IronsightSpeedScale    = 0.85
SWEP.IronsightWalkBobbingStrength = -0.25

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

-- Ammo
SWEP.Primary.Ammo         = "buckshot"
SWEP.Primary.ClipSize      = 8
SWEP.Primary.Chamber      = 0   -- shotguns don't chamber
SWEP.Primary.DefaultClip  = 16
SWEP.Primary.Automatic    = true   -- UH Primary.Automatic = true (SPAS is unusual)

-- Fire modes (UH had "Pump-Action" only)
SWEP.Firemodes = { MCV.FIREMODE_SEMI }

-- Sound
SWEP.SoundSingleShot = "weapons/uh_spas/shotgun_fire.wav"
SWEP.SoundCycleThirdPerson = "weapons/uh_spas/shotgun_cock.wav"
SWEP.SoundEmpty = "Weapon_Shotgun.Empty"

-- Particles
SWEP.MuzzleParticle          = "vietnam_muzzleflash_shotgun_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_shotgun_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_shotgun_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_shotgun_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_shotgun_type1_tp"

SWEP.EjectBrassType   = 4  -- shotgun shell
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

-- Shotgun reload (per-shell)
SWEP.ShotgunReload = true
SWEP.ShotgunReloadRounds = 1
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.MagInTime      = 0.0
SWEP.MagInTimeEmpty = 0.0
SWEP.MagOutTime     = 0.0
SWEP.MagOutTimeEmpty = 0.0

-- Pump action (UH IsPump = true, PreCock = true)
SWEP.PlayCycleAnimation = false   -- SPAS is semi-auto; the model's pump anim is built into fire
SWEP.CyclePostDelay    = 0.9
SWEP.LastShotAnimation = true     -- play distinct last-shot anim

-- UH reload sound timeline (per-shell insert)
SWEP.UseReloadTable = true
SWEP.ReloadTable = {
    {delay = 0.1, sound = "weapons/uh_spas/shotgun_reload.wav"},
}

SWEP.Animations = {
    -- Replace these with actual BO3 sequence names if your model has them.
    -- Defaulting to ACT strings so MCV's standard shotgun reload works.
    ["start_reload"] = "ACT_SHOTGUN_RELOAD_START",
    ["reload_loop"]  = "ACT_VM_RELOAD",
    ["after_reload"] = "ACT_SHOTGUN_RELOAD_FINISH",
    ["rechamber"]    = "ACT_SHOTGUN_PUMP",
}

SWEP.WeaponWeight = 4.4

SWEP.SpreadCrouch = 0.8
SWEP.SpreadStandMove = 1.4
SWEP.SpreadJump = 3.0
