-- M8A7 assault rifle (Black Ops 3) - 4-round burst + semi
-- Stats + Animations table only. The autorun patch handles animation remap.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "M8A7"
SWEP.Category    = "Black Ops III"
SWEP.Country     = "United States of America"
SWEP.Caliber     = "5.56x45mm"

SWEP.Slot        = 2
SWEP.HoldType    = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/loyalists/blackops3/m8a7/v_ar_m8a7.mdl"
SWEP.WorldModel   = "models/loyalists/blackops3/m8a7/w_ar_m8a7.mdl"
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.UseHands    = false

SWEP.IronsightPos = Vector(-10.2104, -2.98, 1.0979)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.DamageGeneric        = 25
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = 1000
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.97

SWEP.Spread           = 7.0
SWEP.SpreadIronsighted = 1.5

SWEP.ViewSlideRecoilUp    = 1.25
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.85
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 1.2

SWEP.ShakeScale    = 0.7
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 15

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "ar2"
SWEP.Primary.ClipSize      = 32
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 120
SWEP.Primary.Automatic    = false

SWEP.Firemodes = { MCV.FIREMODE_BURST, MCV.FIREMODE_SEMI }
SWEP.BurstRounds = 4
SWEP.BurstRecovery = 0.2

SWEP.SoundSingleShot = "CW_BLACKOPS3_M8A7_FIRE"
SWEP.SoundEmpty = "Weapon_AR2.Empty"
SWEP.SoundNearlyEmpty = "Weapon_AR2.Empty"

SWEP.MuzzleParticle          = "vietnam_muzzleflash_rifle_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_rifle_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_rifle_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_rifle_type1_tp"

SWEP.EjectBrassType   = 3
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_rifle_primary"
SWEP.TracerParticle2  = "vietnam_tracer_rifle_secondary"
SWEP.TracerFrequency  = 4

SWEP.MetalPenetrationDepth = 8
SWEP.GlassPenetrationDepth = 14
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 18
SWEP.OtherPenetrationDepth = 12

SWEP.ReloadSpeed = 1

SWEP.MagInTime      = 1.41
SWEP.MagInTimeEmpty = 1.41
SWEP.MagOutTime     = 0.35
SWEP.MagOutTimeEmpty = 0.35

SWEP.BashDamage    = 50
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

SWEP.WeaponWeight = 3.5

SWEP.CrouchSpreadMultiplier = 0.8
SWEP.ProneSpreadMultiplier = 0.7
SWEP.StandMoveSpreadMultiplier = 1.45
SWEP.SneakMoveSpreadMultiplier = 1.35
SWEP.CrouchMoveSpreadMultiplier = 1.25
SWEP.JumpSpreadMultiplier = 3.0

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

if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetSkin(1)
    WorldModel:SetNoDraw(true)
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()
        if IsValid(owner) then
            local offsetVec = Vector(0, -2, -0.5)
            local offsetAng = Angle(180, 180, 80)
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
