AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Beretta"
SWEP.Type_Displayed = "9x19mm Parabellum"
SWEP.Author	= "Goanna, Fox, Mav"
SWEP.Slot = 1
SWEP.PrintName = "M9A1"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/m9a1/c_m9a1.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/m9a1/world/w_m9a1.mdl"
SWEP.WorldModelOffset = Vector(9.5, 1.5, -4.8)
SWEP.WorldModelAngle = Angle(8.0, -90.0, 180.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "pistol"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_M9A1.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_M9A1.Outdoor")
}
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.090090  -- 666 RPM
SWEP.Primary.MinDamage = 10
SWEP.Primary.MaxDamage = 10
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .0175
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.65

SWEP.Primary.KickHorizontal			= 0.2
SWEP.Primary.MinRecoil = -0.3
SWEP.Primary.MaxRecoil = -0.35SWEP.Primary.StaticRecoilFactor = 0.4

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0.6
SWEP.Primary.SpreadRecovery = 3.5

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 0
SWEP.IronSightsPos = Vector(-2.99, -1, 1.57)
SWEP.IronSightsAng = Vector(-1.4, 0, 0)
SWEP.IronSightTime = 0.2

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.FlashlightAttachment = 1

SWEP.NZHeadShotMultiplier = 2.5
SWEP.Primary.MaxAmmo = SWEP.Primary.DefaultClip
function SWEP:NZMaxAmmo()

    local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
        self:SetClip1( self.Primary.ClipSize )
    end
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.NZPaPName						= "Monster Caulk 9000"
self.Primary.Damage 			= 3000
self.Primary.Spread				= 0
self.Primary.ClipSize 			= 15
self.Primary.RPM 				= 200
self.Primary.Spread 			= .001
self.Primary.IronAccuracy 		= .001
self.Primary.Projectile         = "mustangsally_proj"
self.Primary.ProjectileVelocity = 6000
self.Primary.MaxAmmo 			= self.Primary.ClipSize * 6
self.MuzzleFlashEffect = "muz_pap"
self.Primary.MaxFalloff  		= 30
self.NZRePaPText = "Re-PaP"
return true
end

--[Tables]--


function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
    	vm:SetSubMaterial(3, self.nzPaPCamo)
    else
        vm:SetSubMaterial(0, nil)
    end
end

SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["holster"] = "holster",
    ["deploy"] = "draw",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

SWEP.IronAnimation = {
	["loop"] = {
		["value"] = "ads_idle", --Number for act, String/Number for sequence
		["value_empty"] = "ads_idle_empty"
	},
	["shoot"] = {
		["value"] = ACT_VM_PRIMARYATTACK_1, --Number for act, String/Number for sequence
		["value_last"] = ACT_VM_PRIMARYATTACK_2
	} --What do you think
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SMALL.Generic") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_SMALL.Generic") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 6 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_M9A1.Clipout") },
{ ["time"] = 24 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_M9A1.Clipin") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 6 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_M9A1.Clipout") },
{ ["time"] = 24 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_M9A1.Clipin") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_M9A1.Chamber") },
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
