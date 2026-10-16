AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Advanced Armament Corporation"
SWEP.Type_Displayed = ".300 AAC Blackout"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 2
SWEP.PrintName = "Honey Badger"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/honeybadger/c_honeybadger.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/honeybadger/world/w_honeybadger.mdl"
SWEP.WorldModelOffset = Vector(8.0, 1.0, -4.0)
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
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_HB.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_HB.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.075000  -- 800 RPM
SWEP.Primary.MinDamage = 90
SWEP.Primary.MaxDamage = 90
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 9
SWEP.FiresUnderwater = true

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		= .02
SWEP.Primary.IronAccuracy = .013
SWEP.IronRecoilMultiplier = 0.6

SWEP.Primary.KickHorizontal			= 0.15
SWEP.Primary.MinRecoil = -0.2
SWEP.Primary.MaxRecoil = -0.2SWEP.Primary.StaticRecoilFactor = 0.3

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0.46
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-2.91, -3.5, 0.6)
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

--[NZombies]--
SWEP.NZPaPName = "Dirty Dan"
SWEP.NZHeadShotMultiplier = 3.5
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
self.Primary.Damage = 190
self.Primary.ClipSize = 45
self.Primary.MaxAmmo = self.Primary.ClipSize * 12
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
SWEP.SequenceLengthOverride = {
	[ACT_VM_RELOAD] = 2.37,
	[ACT_VM_RELOAD_EMPTY] = 2.9,
	[ACT_VM_DRAW_DEPLOYED] = 1.5,
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
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Stock") },
{ ["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Grab") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Clipout") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Clipin") },
{ ["time"] = 56 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Clipout") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Clipin") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Chamber") },
{ ["time"] = 73 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.End") },
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
