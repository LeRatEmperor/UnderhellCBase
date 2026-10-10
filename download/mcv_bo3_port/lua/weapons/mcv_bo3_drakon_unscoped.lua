-- Drakon (red dot) rifle (Black Ops 3) - full-auto + semi
-- Stats + Animations table only. The autorun patch handles animation remap.

AddCSLuaFile()

SWEP.Base        = "mcv_bo3_base"
SWEP.Spawnable   = true
SWEP.PrintName   = "Drakon (Red Dot)"
SWEP.Category    = "Black Ops III"
SWEP.Country     = "United States of America"
SWEP.Caliber     = "7.62x51mm"

SWEP.Slot        = 3
SWEP.HoldType    = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.ViewModel    = "models/weapons/drakon/v_sr_drakon_reddot.mdl"
SWEP.WorldModel   = "models/loyalists/blackops3/drakon/w_sr_drakon.mdl"
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.UseHands    = false

SWEP.IronsightPos = Vector(-9.24, -14.8513, -0.09)
SWEP.IronsightAng = Angle(0, 0, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.DamageGeneric        = 52
SWEP.DamageHeadMultiplier = 2.8
SWEP.DamageChestMultiplier = 1.3
SWEP.DamageStomachMultiplier = 1.2
SWEP.DamageLegMultiplier  = 0.85
SWEP.DamageArmMultiplier  = 0.8

SWEP.FireRate    = 240
SWEP.Num         = 1
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.98

SWEP.Spread           = 3.0
SWEP.SpreadIronsighted = 0.5

SWEP.ViewSlideRecoilUp    = 1.5
SWEP.ViewSlideRecoilRight = 0.4
SWEP.ViewSlideRecoilIronsightUp    = 1.1
SWEP.ViewSlideRecoilIronsightRight = 0.25
SWEP.RecoilPushbackValue = 1.6

SWEP.ShakeScale    = 1.0
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 1.0
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 15

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "ar2"
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 120
SWEP.Primary.Automatic    = true

SWEP.Firemodes = { MCV.FIREMODE_AUTO, MCV.FIREMODE_SEMI }

SWEP.SoundSingleShot = "CW_BLACKOPS3_DRAKON_FIRE"
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

SWEP.MetalPenetrationDepth = 10
SWEP.GlassPenetrationDepth = 16
SWEP.ConcretePenetrationDepth = 12
SWEP.WoodPenetrationDepth = 20
SWEP.OtherPenetrationDepth = 14

SWEP.ReloadSpeed = 1

SWEP.MagInTime      = 2.00
SWEP.MagInTimeEmpty = 2.00
SWEP.MagOutTime     = 0.50
SWEP.MagOutTimeEmpty = 0.50

SWEP.BashDamage    = 50
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

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

-- Red dot reticle HUD overlay (only when aimed)
if CLIENT then
    local RedDotMaterial = CreateMaterial("BO3_Drakon_RedDot", "UnlitGeneric", {
        ["$basetexture"] = "blackops3/reticles/reflex_4",
        ["$vertexcolor"] = 1,
        ["$vertexalpha"] = 1,
        ["$additive"] = 1,
    })
    local BaseDrawHUD = SWEP.DrawHUD
    function SWEP:DrawHUD()
        if BaseDrawHUD then BaseDrawHUD(self) end
        if not (self:GetIronsight() and self:GetSighted()) then return end
        local dotSize = 128
        surface.SetMaterial(RedDotMaterial)
        surface.SetDrawColor(255, 0, 0, 255)
        surface.DrawTexturedRect(
            (ScrW() / 2) - (dotSize / 2),
            (ScrH() / 2) - (dotSize / 2),
            dotSize, dotSize
        )
    end
end

if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetSkin(1)
    WorldModel:SetNoDraw(true)
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()
        if IsValid(owner) then
            local offsetVec = Vector(0, -2, 0)
            local offsetAng = Angle(175, 185, 0)
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
