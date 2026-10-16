AddCSLuaFile()

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Remington Arms"
SWEP.Type_Displayed = "5.56x45mm NATO"
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 2
SWEP.PrintName = "Remington R5"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/remington_r5/c_remington_r5.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/remington_r5/world/w_remington_r5.mdl"
SWEP.WorldModelOffset = Vector(8.0, 1.0, -5.8)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.1
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_RR5.Fire"
SWEP.Secondary.Sound = "Weapons_Ghosts_M203.Fire"
SWEP.Primary.SilencedSound = Sound("Weapons_Ghosts_SUPP.Fire")
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_RR5.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.095087  -- 631 RPM
SWEP.Primary.MinDamage = 120
SWEP.Primary.MaxDamage = 120
SWEP.Primary.Velocity = 850
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 9
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .02	
SWEP.Primary.IronAccuracy = .013
SWEP.IronRecoilMultiplier = 0.6

SWEP.Primary.KickHorizontal			= 0.2
SWEP.Primary.MinRecoil = -0.25
SWEP.Primary.MaxRecoil = -0.3SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0.48
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-2.7, -2, 0.36)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos_GL = Vector(0, -1, 0)
SWEP.IronSightsAng_GL = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "RifleShellEject"
SWEP.ShellAttachment = "0"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

--[NZombies]--
SWEP.NZPaPName = "skate 5"
SWEP.NZHeadShotMultiplier = 2
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
self.Primary.Damage = 320
self.Primary.ClipSize = 50
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
{ ["time"] = 11 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Draw") },
{ ["time"] = 33 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.End") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Lift") },
{ ["time"] = 11 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Clipout") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Clipin") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Lift") },
{ ["time"] = 11 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Clipout") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Clipin") },
{ ["time"] = 57 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.Chamber") },
{ ["time"] = 71 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_RR5.End") },
},
}

--[Shit]--
SWEP.MuzzleAttachmentSilenced = 1
SWEP.MuzzleAttachmentLong = 2

--[ATTACHMENTS]--

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}
SWEP.AttachmentTableOverride = {}

DEFINE_BASECLASS( SWEP.Base )

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
