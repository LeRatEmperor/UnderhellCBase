-- KRM-262 pump-action shotgun (Black Ops 3)
-- Stats + Animations table only. The autorun patch handles animation remap.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "KRM-262"
SWEP.Category    = "Black Ops III"
SWEP.Country     = "United States of America"
SWEP.Caliber     = "12 Gauge"

SWEP.Slot        = 3
SWEP.HoldType    = "shotgun"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/loyalists/blackops3/spartan/v_shot_spartan.mdl"
SWEP.WorldModel   = "models/loyalists/blackops3/spartan/w_shot_spartan.mdl"
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.UseHands    = false

SWEP.IronsightPos = Vector(-8.62, 1.0289, 2.1)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.DamageGeneric        = 15
SWEP.DamageHeadMultiplier = 1.5
SWEP.DamageChestMultiplier = 1.0
SWEP.DamageStomachMultiplier = 1.0
SWEP.DamageLegMultiplier  = 0.85
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = 86
SWEP.Num         = 8
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.85

SWEP.Spread           = 14.0
SWEP.SpreadIronsighted = 5.0

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
SWEP.IronsightFov = 90 - 15

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "buckshot"
SWEP.Primary.ClipSize      = 8
SWEP.Primary.Chamber      = 0
SWEP.Primary.DefaultClip  = 24
SWEP.Primary.Automatic    = false

SWEP.Firemodes = { MCV.FIREMODE_SEMI }

SWEP.SoundSingleShot = "CW_BLACKOPS3_SPARTAN_FIRE"
SWEP.SoundEmpty = "Weapon_Shotgun.Empty"
SWEP.SoundNearlyEmpty = "Weapon_Shotgun.Empty"
SWEP.SoundCycleThirdPerson = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"

SWEP.MuzzleParticle          = "vietnam_muzzleflash_shotgun_type1_fp"
SWEP.MuzzleParticleSmoke     = "vietnam_muzzleflash_shotgun_type1_fp_smoke"
SWEP.MuzzleParticleIronsighted = "vietnam_muzzleflash_shotgun_type1_fp_is"
SWEP.MuzzleParticleIronsightedSmoke = "vietnam_muzzleflash_shotgun_type1_fp_is_smoke"
SWEP.MuzzleParticle3rdPerson = "vietnam_muzzleflash_shotgun_type1_tp"

SWEP.EjectBrassType   = 4
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "vietnam_tracer_shotgun_primary"
SWEP.TracerParticle2  = "vietnam_tracer_shotgun_secondary"
SWEP.TracerFrequency  = 1

SWEP.MetalPenetrationDepth = 3
SWEP.GlassPenetrationDepth = 6
SWEP.ConcretePenetrationDepth = 4
SWEP.WoodPenetrationDepth = 8
SWEP.OtherPenetrationDepth = 5

SWEP.ReloadSpeed = 1

SWEP.MagInTime      = 0.0
SWEP.MagInTimeEmpty = 0.0
SWEP.MagOutTime     = 0.0
SWEP.MagOutTimeEmpty = 0.0

SWEP.BashDamage    = 50
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

SWEP.ShotgunReload = true
SWEP.ShotgunReloadRounds = 1
SWEP.ShotgunReloadEmptyStartAnimation = false
SWEP.PlayCycleAnimation = false
SWEP.CyclePostDelay = 0.7
SWEP.LastShotAnimation = false
SWEP.NoEjectOnShoot = false

SWEP.WeaponWeight = 4.5

SWEP.CrouchSpreadMultiplier = 0.7
SWEP.ProneSpreadMultiplier = 0.6
SWEP.StandMoveSpreadMultiplier = 1.4
SWEP.SneakMoveSpreadMultiplier = 1.3
SWEP.CrouchMoveSpreadMultiplier = 1.2
SWEP.JumpSpreadMultiplier = 3.0

SWEP.Animations = {
    [ACT_VM_IDLE]          = "base_idle",
    [ACT_VM_DRAW]          = "base_draw",
    [ACT_VM_PRIMARYATTACK] = function(self)
        if self:GetIronsight() and self:GetSighted() then return "base_fire_ads" end
        return "base_fire"
    end,
    [ACT_VM_RELOAD]             = "base_reload_loop",     -- per-shell insert loop
    [ACT_SHOTGUN_RELOAD_START]  = "base_reload_in",
    [ACT_SHOTGUN_RELOAD_FINISH] = "base_reload_out",
    [ACT_SHOTGUN_PUMP]          = "base_rechamber",
    [ACT_VM_HOLSTER]            = "base_idle",
    [ACT_VM_HITCENTER]          = "base_melee",
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
            local offsetVec = Vector(0, -2, -1)
            local offsetAng = Angle(180, 90, 0)
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
