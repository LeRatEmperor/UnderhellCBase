AddCSLuaFile()

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Sniper Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Accuracy International"
SWEP.Type_Displayed = ".338 Lapua Magnum"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 4
SWEP.PrintName = "L115"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/l115/c_l115.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/l115/world/w_l115.mdl"
SWEP.WorldModelOffset = Vector(17.0, 1.0, -7.2)
SWEP.WorldModelAngle = Angle(10.0, 0.0, 180.0)
SWEP.WorldModelScale = 1.35
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0
SWEP.TPIKPos = Vector(-2, -4, 4)



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_L115.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_L115.Outdoor")
}
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.100000  -- 600 RPM
SWEP.Primary.RPM_Displayed = 40
SWEP.Primary.MinDamage = 950
SWEP.Primary.MaxDamage = 950
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 9
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .075	
SWEP.Primary.IronAccuracy = .00001
SWEP.IronRecoilMultiplier = 0.8

SWEP.Primary.KickHorizontal			= 0.3
SWEP.Primary.MinRecoil = -0.7
SWEP.Primary.MaxRecoil = -1.0SWEP.Primary.StaticRecoilFactor = 0.6

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 25
SWEP.IronSightsPos = Vector(-5.473, -4, 0.69)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4

--[NZombies]--
SWEP.NZPaPName = "Lm40-115"
SWEP.NZHeadShotMultiplier = 4
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
self.NZHeadShotMultiplier = 6
self.Ispackapunched = true
self.Primary.Damage = 1600
self.PumpAction = nil
self.Primary.ClipSize = 15
self.Primary.MaxAmmo = self.Primary.ClipSize * 10
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

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

--[Tables]--


SWEP.PumpAction = { -- Pump/bolt animations
    ["value"] = ACT_VM_PULLBACK_HIGH, -- Number for act, String/Number for sequence
    ["value_is"] = ACT_VM_PULLBACK_LOW, -- ADS pump
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
[ACT_VM_PULLBACK_LOW] = {
{time = 0.38, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 6 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Open") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Close") },
},
[ACT_VM_PULLBACK_HIGH] = {
{time = 0.38, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 6 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Open") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Close") },
},
[ACT_VM_DRAW] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Lift") },
{ ["time"] = 16 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Stock") },
{ ["time"] = 48 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.End") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Lift") },
{ ["time"] = 26 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Clipout") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Clipin") },
{ ["time"] = 83 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{time = 0.36, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Open") },
{ ["time"] = 42 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Clipout") },
{ ["time"] = 75 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Clipin") },
{ ["time"] = 98 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.Close") },
{ ["time"] = 106 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_L115.End") },
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
