AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Kalashnikov Concern"
SWEP.Type_Displayed = "7.62x39mm"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 2
SWEP.PrintName = "AK-12"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/ak12/c_ak12.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/ak12/world/w_ak12.mdl"
SWEP.WorldModelOffset = Vector(8.0, 1.0, -5.0)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.1
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0
SWEP.VMPos = Vector(0,0,0.5)
SWEP.VMAng = Vector(0,0,0)



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_AK12.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_AK12.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.087083  -- 689 RPM
SWEP.Primary.MinDamage = 90
SWEP.Primary.MaxDamage = 90
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 8
SWEP.FiresUnderwater = true

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		  = .03
SWEP.Primary.IronAccuracy = .005
SWEP.IronRecoilMultiplier = 0.75

SWEP.Primary.KickHorizontal		= 0.05
SWEP.Primary.MinRecoil = -0.1
SWEP.Primary.MaxRecoil = -0.2SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6


--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-2.425, -2, 1.09)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

--[nZ FUCLKKKK]
SWEP.NZPaPName = "ALWAYS KILLING"
SWEP.NZHeadShotMultiplier = 2.5
SWEP.Primary.MaxAmmo = SWEP.Primary.DefaultClip
function SWEP:NZMaxAmmo()

    local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
        self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.NZHeadShotMultiplier = 4
self.Ispackapunched = true
self.Primary.Damage = 340
self.Primary.ClipSize = 50
self.Primary.MaxAmmo = self.Primary.ClipSize * 9
self.MuzzleFlashEffect	= "muz_pap"
return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
    	vm:SetSubMaterial(0, self.nzPaPCamo)
    	vm:SetSubMaterial(1, self.nzPaPCamo)
    else
        vm:SetSubMaterial(0, nil)
    end
end

--[Tables]--



SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["deploy"] = "draw",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Lift") },
{ ["time"] = 32 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Clipout") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Clipin") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Lift") },
{ ["time"] = 32 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Clipout") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Clipin") },
{ ["time"] = 90 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_AK12.Chamber") },
},
}

--[Shit]--

SWEP.ViewModelBoneMods = {
    ["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 90) }
}
SWEP.TwoHanded = true
SWEP.ReloadSpeed = 1
SWEP.Chambering = false
SWEP.SwayPosition = 2.0
SWEP.IronSightsDipPos = Vector(0, 0, 0)
SWEP.IronSightsDipAng = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)
