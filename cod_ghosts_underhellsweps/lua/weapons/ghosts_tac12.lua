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
SWEP.PrintName = "Tac 12"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/tac12/c_tac12.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/tac12/world/w_tac12.mdl"
SWEP.WorldModelOffset = Vector(15.0, 1.0, -6.5)
SWEP.WorldModelAngle = Angle(10.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.05
SWEP.HoldType = "shotgun"
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.Shell = "models/weapons/shell_556.mdl"
SWEP.ShellHeat = 0.5
SWEP.ShellDelay = 0





--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_TAC.Fire"
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.200000  -- 300 RPM
SWEP.Primary.MinDamage = 55
SWEP.Primary.MaxDamage = 55
SWEP.Primary.NumberofShots = 8
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 60
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .067

SWEP.Primary.KickHorizontal			= 0.35
SWEP.Primary.MinRecoil = -1.5
SWEP.Primary.MaxRecoil = -1.5


--[Shotgun Code]--
SWEP.LoopedReloadInsertAmount = 1 -- How much rounds to insert on each reload cycle
SWEP.LoopedReloadInsertTime = 13 / 30


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-3.214, -3, -0.84)
SWEP.IronSightsAng = Vector(0.5, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--

--[Misc]--

--[NZombies]--
SWEP.NZPaPName = "Special Edition Gold Sauce"
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
self.Primary.RPM = 600
self.Primary.Damage = 165
self.Primary.NumShots = 4
self.VMPos = Vector(0,25,-3)
self.VMAng = Vector(0,0,135)
self.Manufacturer = "McDonalds"

self.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(3, 3, 3), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 0.3, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(3, 3, 3), pos = Vector(30, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(56, 3, 3), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["bullet0_jnt"] = { scale = Vector(5, 5, 5), pos = Vector(0, 0, 10), angle = Angle(0, 0, 0) },
}

self.Animations = {
	["reload"] = {
		["value"] = ACT_VM_RELOAD2
	},
	["reload_shotgun_start"] = {
		["value"] = ACT_VM_RELOAD2
	},
	["reload_shotgun_finish"] = {
		["value"] = ACT_VM_RELOAD2
	},
}
self.PumpAction = nil
self.Primary.ClipSize = 90
self.Primary.MaxAmmo = self.Primary.ClipSize * 4
self.MuzzleFlashEffect = "muz_pap"
self.LoopedReloadInsertAmount = 30 -- How much rounds to insert on each reload cycle
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
    ["value"] = ACT_VM_PULLBACK_HIGH, -- Number for act, String/Number for sequence
	["value_empty"] = ACT_VM_PULLBACK_HIGH,
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
[ACT_VM_DRAW] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
},
[ACT_VM_PULLBACK_HIGH] = {
{ ["time"] = 3 / 30, ["type"] = "lua",   ["value"] = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Chamber") },
},
[ACT_VM_PULLBACK_LOW] = {
{ ["time"] = 3 / 30, ["type"] = "lua",   ["value"] = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Chamber") },
},
[ACT_SHOTGUN_RELOAD_START] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Lift") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Insert") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 7 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Insert") },
},
[ACT_SHOTGUN_RELOAD_FINISH] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Grab") },
{ ["time"] = 13 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Chamber") },
{ ["time"] = 28 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.End") },
},
[ACT_VM_RELOAD2] = {
{ ["time"] = 1 / 10, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_TAC.Insert") },
{ ["time"] = 3 / 10, ["type"] = "sound", ["value"] = Sound("iw4.ranger.insert") },
{ ["time"] = 5 / 10, ["type"] = "sound", ["value"] = Sound("TFA_RENAISSANCE.SAWEDOFF.SHELL_IN") },
{ ["time"] = 9 / 10, ["type"] = "sound", ["value"] = Sound("iw4.1887.insert") },
{ ["time"] = 11 / 10, ["type"] = "sound", ["value"] = Sound("TFA_UGX.Spas_Insert") },
{ ["time"] = 13 / 10, ["type"] = "sound", ["value"] = Sound("TFA_REN.M1887_Insert") },
{ ["time"] = 15 / 10, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
{ ["time"] = 17 / 10, ["type"] = "sound", ["value"] = Sound("TFA_BO2.G_SHOTGUN.LOAD") },
{ ["time"] = 19 / 10, ["type"] = "sound", ["value"] = Sound("TFA_T7C.Ray_Magin") },
{ ["time"] = 7 / 10, ["type"] = "sound", ["value"] = Sound("ambient/alarms/train_horn2.wav") },
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
