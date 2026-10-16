AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Shotguns"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 3
SWEP.PrintName = "Bulldog"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/bulldog/c_bulldog.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/bulldog/world/w_bulldog.mdl"
SWEP.WorldModelOffset = Vector(9.0, 1.0, -4.5)
SWEP.WorldModelAngle = Angle(10.0, 180.0, 180.0)
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



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_MAUL.Fire"
SWEP.Primary.Ammo = "buckshot"				--What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.125000  -- 480 RPM
SWEP.Primary.MinDamage = 125
SWEP.Primary.MaxDamage = 125
SWEP.Primary.NumberofShots = 6
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 12
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .07

SWEP.Primary.KickHorizontal			= 0.35
SWEP.Primary.MinRecoil = -1.0
SWEP.Primary.MaxRecoil = -1.0


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-4, -5, 0.959)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.2

--[Shells]--

--[Misc]--

SWEP.NZPaPName = "MR. WORLDWIDE"
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
self.Primary.Damage = 250
self.Primary.ClipSize = 24
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
--[Talbes]--


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
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MAUL.Clipout") },
{ ["time"] = 41 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MAUL.Clipin") },
{ ["time"] = 54 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MAUL.Hit") },
{ ["time"] = 64 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MAUL.End") },
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
