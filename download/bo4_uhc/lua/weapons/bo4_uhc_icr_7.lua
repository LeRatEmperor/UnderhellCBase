-- ICR-7"		-- Weapon name (Shown on HUD) (BO4) ported to BO4 UHC base.

AddCSLuaFile()

SWEP.Base        = "weapon_bo4_custom_base_gun"
SWEP.Spawnable   = true
SWEP.PrintName   = "ICR-7"		-- Weapon name (Shown on HUD)
SWEP.Category    = "Black Ops 4: UHC"

SWEP.Slot        = 2
SWEP.HoldType    = "ar2" -- This is how others view you carrying the weapon. Options include:
SWEP.UseHands    = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false

SWEP.ViewModel    = "models/loyalists/bo4/icr_7/icr_7_vm.mdl" --Viewmodel path
SWEP.WorldModel   = "models/loyalists/bo4/icr_7/icr_7_wm.mdl"

SWEP.IronsightPos = Vector(-3.506, -3.918, 0.572)
SWEP.IronsightAng = Angle(-0.239, 0, 0)
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)
SWEP.LoweredPos = Vector(2.95, -3.057, -4.119)
SWEP.LoweredAng = Angle(-13.131, 33.537, -29.906)

SWEP.DamageGeneric        = 33 -- Damage, in standard damage points.
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = 600 -- This is in Rounds Per Minute / RPM
SWEP.Num         = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.95

SWEP.Spread           = 3.0
SWEP.SpreadIronsighted = 0.5

SWEP.ViewSlideRecoilUp    = 0.8
SWEP.ViewSlideRecoilRight = 0.8
SWEP.ViewSlideRecoilIronsightUp    = 0.5
SWEP.ViewSlideRecoilIronsightRight = 0.5
SWEP.RecoilPushbackValue = 1.0

SWEP.ShakeScale    = 0.7
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 0.700
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 80

SWEP.ZoomFov = 15

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = "ar2" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.ClipSize      = 35 -- This is the size of a clip
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = 105 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Automatic    = true -- Automatic/Semi Auto

SWEP.Primary.Sound     = Sound("Notetracks.BO4.ICR_7.Fire") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilSound  = Sound("Notetracks.BO4.ICR_7.Fire") -- This is the sound of the weapon, when you shoot.

SWEP.Primary.Spread    = 0.03 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = 0.005 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.MinDamage = 33 -- Damage, in standard damage points.
SWEP.Primary.MaxDamage = 33 -- Damage, in standard damage points.
SWEP.Primary.Delay    = 60 / 600 -- This is in Rounds Per Minute / RPM
SWEP.Primary.NumberofShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.MinRecoil = -0.07
SWEP.Primary.MaxRecoil = -0.07
SWEP.Primary.KickUp    = 0.075 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown  = 0.075 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.075 -- This is the maximum sideways recoil (no real term)

SWEP.Firemodes = { { name = 'Semi-Auto' } }
SWEP.ReloadSpeed = 1
SWEP.Chambering = true

SWEP.Animations = {
    ["shoot"]        = "base_fire",
    ["reload"]       = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["iron_fire"]    = "base_fire_ads",
    ["idle"]         = "base_idle",
    ["deploy"]       = "base_draw",
    ["sprint_idle"]  = "base_sprint_loop",
    ["sprint_in"]    = "base_sprint_in",
    ["sprint_out"]   = "base_sprint_out",
    ["melee"]        = "base_melee",
}

SWEP.MagInTime      = 1.0
SWEP.MagInTimeEmpty = 1.5
SWEP.MagOutTime     = 0.3
SWEP.MagOutTimeEmpty = 0.3

SWEP.BashDamage    = 50
SWEP.BashRange     = 96

SWEP.WeaponWeight = 3.0

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true
SWEP.ReloadTable = {}
SWEP.AnimSounds = {}

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(0, 200, 255)
SWEP.MuzzleFlashLightSize = 128

SWEP.AnimatedSprint = true
SWEP.Primary.ClipSizeExt = 52 -- This is the size of a clip
SWEP.Primary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi = 600 -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM

if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
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
