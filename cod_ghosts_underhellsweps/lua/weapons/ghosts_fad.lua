AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "SIMA Electronica"
SWEP.Type_Displayed = "5.56×45mm NATO"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 2
SWEP.PrintName = "FAD"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/fad/c_fad.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/fad/world/w_fad.mdl"
SWEP.WorldModelOffset = Vector(4.5, 1.0, -5.5)
SWEP.WorldModelAngle = Angle(10.0, -90.0, 180.0)
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
SWEP.TPIKPos = Vector(-4, -4, 3)



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_FAD.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_FAD.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.068027  -- 882 RPM
SWEP.Primary.MinDamage = 105
SWEP.Primary.MaxDamage = 105
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 42
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 11
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .02
SWEP.Primary.IronAccuracy = .013
SWEP.IronRecoilMultiplier = 0.55

SWEP.Primary.KickHorizontal			= 0.15
SWEP.Primary.MinRecoil = -0.15
SWEP.Primary.MaxRecoil = -0.3SWEP.Primary.StaticRecoilFactor = 0.3

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0.47
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-3.18, -5, 0.2)
SWEP.IronSightsAng = Vector(1.5, 0, 0)
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

SWEP.NZPaPName = "Trndsttr"
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
self.Ispackapunched = true
self.Primary.Damage = 280
self.Primary.ClipSize = 64
self.Primary.MaxAmmo = self.Primary.ClipSize * 14
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
	[ACT_VM_RELOAD] = 3.05,
	[ACT_VM_RELOAD_EMPTY] = 3.65,
	[ACT_VM_DRAW_DEPLOYED] = 1.35,
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
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Lift") },
{ ["time"] = 28 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.End") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Lift") },
{ ["time"] = 19 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Clipout") },
{ ["time"] = 68 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Clipin") },
{ ["time"] = 82 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Lift") },
{ ["time"] = 19 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Clipout") },
{ ["time"] = 68 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Clipin") },
{ ["time"] = 82 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.Chamber") },
{ ["time"] = 97 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FAD.End") },
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
