AddCSLuaFile()

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Remington Arms"
SWEP.Type_Displayed = ".308 Winchester"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 4
SWEP.PrintName = "USR"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/usr/c_usr.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/usr/world/w_usr.mdl"
SWEP.WorldModelOffset = Vector(6.0, 1.0, -3.0)
SWEP.WorldModelAngle = Angle(10.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0
SWEP.VMPos = Vector(0,-4,-1)
SWEP.VMAng = Vector(0,0,0)
SWEP.TPIKPos = Vector(-4, -4, 3)



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_USR.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("Weapons_Ghosts_USR.Indoor"),
	[256] = Sound("Weapons_Ghosts_USR.Outdoor")
}
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.100000  -- 600 RPM
SWEP.Primary.RPM_Displayed = 51
SWEP.Primary.MinDamage = 800
SWEP.Primary.MaxDamage = 800
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 12
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .1	
SWEP.Primary.IronAccuracy = .00001
SWEP.IronRecoilMultiplier = 0.8

SWEP.Primary.KickHorizontal			= 0.3
SWEP.Primary.MinRecoil = -1.1
SWEP.Primary.MaxRecoil = -1.1SWEP.Primary.StaticRecoilFactor = 0.6

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 30
SWEP.IronSightsPos = Vector(-4.736, -2, 0.803)
SWEP.IronSightsAng = Vector(0, 0, 0.9)
SWEP.IronSightTime = 0.45

--[NZombies]--
SWEP.NZPaPName = "USPS"
SWEP.NZHeadShotMultiplier = 3
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
self.Primary.Damage = 1400
self.PumpAction = nil
self.Primary.ClipSize = 16
self.Primary.MaxAmmo = self.Primary.ClipSize * 12
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


--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

--[Tables]--


SWEP.PumpAction = { -- Pump/bolt animations
    ["value"] = ACT_VM_PULLBACK_HIGH, -- Number for act, String/Number for sequence
}

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
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Lift") },
{ ["time"] = 23 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Close") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_PULLBACK_HIGH] = {
{time = 0.3, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 6 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Open") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Close") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Lift") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Clipout") },
{ ["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Clipin") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 16 / 30, ["type"] = "lua",   ["value"] = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Open") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Clipout") },
{ ["time"] = 95 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Clipin") },
{ ["time"] = 120 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_USR.Close") },
},
}

--[Shit]--

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Sway(pos, ang, ftv, ...)
	local spos, sang = BaseClass.Sway(self, pos * 1, ang * 1, ftv, ...)

	if self.IronSightsProgress > .01 then
		spos = Lerp(self.IronSightsProgress * .85, spos, pos)
		sang = Lerp(self.IronSightsProgress * .85, sang, ang)
	end

	return spos, sang
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if self._chADS or 0 >= 0.9 then
		self.Bodygroups_V = self.Bodygroups_V or {}
		self.Bodygroups_V[1] = 1 
	else
		self.Bodygroups_V = self.Bodygroups_V or {}
		self.Bodygroups_V[1] = 0 
	end

	return BaseClass.Think2(self, ...)
end



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
