AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 3
SWEP.PrintName = "SVU"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/svu/c_svu.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/svu/world/w_svu.mdl"
SWEP.WorldModelOffset = Vector(3.5, 1.0, -4.6)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_SVU.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("Weapons_Ghosts_SVU.Indoor"),
	[256] = Sound("Weapons_Ghosts_SVU.Outdoor")
}
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.150000  -- 400 RPM
SWEP.Primary.MinDamage = 400
SWEP.Primary.MaxDamage = 400
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 11
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .025

SWEP.Primary.KickHorizontal			= 0.15
SWEP.Primary.MinRecoil = -0.35
SWEP.Primary.MaxRecoil = -0.6


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 25
SWEP.IronSightsPos = Vector(-2.961, -3, 2.16)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.ShellAttachment = "0"

--[Misc]--
SWEP.InspectionPos = Vector(20, 30, 1.041)
SWEP.InspectionAng = Vector(40, 90, 40)

--[NZombies]--
SWEP.NZPaPName = "SteVen Universe"
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
self.Ispackapunched = true
self.Primary.Automatic = true
self.Primary.Damage = 650
self.Primary.ClipSize = 27
self.Primary.MaxAmmo = self.Primary.ClipSize * 11
self.MuzzleFlashEffect = "muz_pap"
return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
    	vm:SetSubMaterial(0, self.nzPaPCamo)
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
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Lift") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.End") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Lift") },
{ ["time"] = 18 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipout") },
{ ["time"] = 44 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Clipin") },
{ ["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Lift") },
{ ["time"] = 18 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipout") },
{ ["time"] = 49 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Clipin") },
{ ["time"] = 81 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Open") },
{ ["time"] = 89 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SVU.Close") },
{ ["time"] = 101 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_2010.End") },
},
}

--[Shit]--
SWEP.SprintBobMult = 0
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
