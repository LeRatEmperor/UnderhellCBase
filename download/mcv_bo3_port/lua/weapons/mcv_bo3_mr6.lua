-- MR6 pistol (Black Ops 3) ported to MCV base.
-- The autorun patch (lua/autorun/sh_mcv_bo3_patch.lua) handles animation
-- remap globally. This file just sets stats and the Animations table.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "MR6"
SWEP.Category    = "Black Ops III"
SWEP.Country     = "United States of America"
SWEP.Caliber     = ".45 ACP"

SWEP.Slot        = 1
SWEP.HoldType    = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.ViewModel    = "models/loyalists/blackops3/mr6/v_pistol_mr6.mdl"
SWEP.WorldModel   = "models/loyalists/blackops3/mr6/w_pistol_mr6.mdl"
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.UseHands    = false

SWEP.IronsightPos = Vector(-8.9801, 11.1574, 4.4512)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.DamageGeneric        = 35
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = 720
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.96

SWEP.Spread           = 6.5
SWEP.SpreadIronsighted = 1.3

SWEP.ViewSlideRecoilUp    = 1.25
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.85
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 0.9

SWEP.ShakeScale    = 0.5
SWEP.ShakeFreq     = 55
SWEP.ShakeDuration = 0.2

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 15

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "pistol"
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 120
SWEP.Primary.Automatic    = false

SWEP.Firemodes = { MCV.FIREMODE_SEMI }

SWEP.SoundSingleShot = "CW_BLACKOPS3_MR6_FIRE"
SWEP.SoundEmpty = "Weapon_Pistol.Empty"
SWEP.SoundNearlyEmpty = "Weapon_Pistol.Empty"

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

SWEP.MetalPenetrationDepth = 4
SWEP.GlassPenetrationDepth = 8
SWEP.ConcretePenetrationDepth = 5
SWEP.WoodPenetrationDepth = 10
SWEP.OtherPenetrationDepth = 6

SWEP.ReloadSpeed = 1

SWEP.MagInTime      = 0.75
SWEP.MagInTimeEmpty = 0.75
SWEP.MagOutTime     = 0.30
SWEP.MagOutTimeEmpty = 0.30

SWEP.BashDamage    = 50
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

SWEP.WeaponWeight = 1.1

SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 3.0

-- ============================================================
-- ANIMATION TABLE
-- ============================================================
-- Keyed by ACT_VM_* constants. Values are sequence names (strings) or
-- functions that return sequence names (for state-aware variants).
-- The autorun patch translates these when MCV calls PlayAnimation(ACT_VM_X).
SWEP.Animations = {
    [ACT_VM_IDLE]          = "base_idle",
    [ACT_VM_DRAW]          = "base_draw",
    [ACT_VM_PRIMARYATTACK] = function(self)
        if self:GetIronsight() and self:GetSighted() then return "base_fire_ads" end
        return "base_fire"
    end,
    [ACT_VM_RELOAD]        = function(self)
        if self:Clip1() <= 0 then return "base_reload_empty" end
        return "base_reload"
    end,
    [ACT_VM_RELOADEMPTY]   = "base_reload_empty",
    [ACT_VM_HOLSTER]       = "base_idle",
    [ACT_VM_HITCENTER]     = "base_melee",
}

-- Sprint / mantle sequences (played by mcv_bo3_base)
SWEP.SprintIdleSequence = "base_sprint_loop"
SWEP.SprintInSequence   = "base_sprint_in"
SWEP.SprintOutSequence  = "base_sprint_out"
SWEP.MantleSequence     = "base_mantle_over"

-- World model
if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetSkin(1)
    WorldModel:SetNoDraw(true)
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()
        if IsValid(owner) then
            local offsetVec = Vector(4, -2, 2)
            local offsetAng = Angle(180, 180, 0)
            local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
            if not boneid then return end
            local matrix = owner:GetBoneMatrix(boneid)
            if not matrix then return end
            local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
            WorldModel:SetPos(newPos)
            WorldModel:SetAngles(newAng)
            WorldModel:SetupBones()
        else
            WorldModel:SetPos(self:GetPos())
            WorldModel:SetAngles(self:GetAngles())
        end
        WorldModel:DrawModel()
    end
end
