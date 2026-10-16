AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 2
SWEP.PrintName = "MSBS"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/msbs/c_msbs.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/msbs/world/w_msbs.mdl"
SWEP.WorldModelOffset = Vector(14.5, 0.8, -6.0)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_MSBS.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_MSBS.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.072029  -- 833 RPM
SWEP.Primary.BurstDelay = 0.25
SWEP.Primary.MinDamage = 80
SWEP.Primary.MaxDamage = 80
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 180
SWEP.FiresUnderwater = true
SWEP.OnlyBurstFire = true

--[Spread Related]--
SWEP.Primary.Spread		= .02	

SWEP.Primary.KickHorizontal			= 0.1
SWEP.Primary.MinRecoil = -0.2
SWEP.Primary.MaxRecoil = -0.3


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-3.105, -3.5, 0.95)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.ShellAttachment  = "0"

--[Misc]--

--[NZombies]--
SWEP.NZPaPName = "M4rtyr S41nt BULL Sh1t"
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
self.Primary.Damage = 190
self.Primary.ClipSize = 45
self.Primary.MaxAmmo = self.Primary.ClipSize * 9
self.MuzzleFlashEffect = "muz_pap"
return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
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
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Chamber") },
{ ["time"] = 38 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.End") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Lift") },
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Clipout") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Clipin") },
{ ["time"] = 62 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Lift") },
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Clipout") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Clipin") },
{ ["time"] = 58 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.Chamber") },
{ ["time"] = 76 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MSBS.End") },
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
