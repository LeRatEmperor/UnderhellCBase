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
SWEP.Slot = 3
SWEP.PrintName = "IA-2"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/ia2/c_ia2.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/ia2/world/w_ia2.mdl"
SWEP.WorldModelOffset = Vector(8.5, 1.0, -4.5)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.05
SWEP.HoldType = "ar2"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_IA2.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_IA2.Outdoor")
}
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.110092  -- 545 RPM
SWEP.Primary.MinDamage = 250
SWEP.Primary.MaxDamage = 250
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 108
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .045	

SWEP.Primary.KickHorizontal			= 0.2
SWEP.Primary.MinRecoil = -0.2
SWEP.Primary.MaxRecoil = -0.5


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 25
SWEP.IronSightsPos = Vector(-4.901, -2, 1.789)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--

--[Misc]--

--[NZombies]--
SWEP.NZPaPName = "Ian Gallagher"
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
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_HB.Lift") },
{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.End") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LARGE.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Lift") },
{ ["time"] = 17 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipout") },
{ ["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipin") },
{ ["time"] = 67 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Lift") },
{ ["time"] = 17 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipout") },
{ ["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Clipin") },
{ ["time"] = 69 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.Chamber") },
{ ["time"] = 88 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_IA2.End") },
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
