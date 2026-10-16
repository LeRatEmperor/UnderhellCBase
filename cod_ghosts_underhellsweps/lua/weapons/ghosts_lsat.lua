AddCSLuaFile()

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Light Machine Guns"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Textron Systems"
SWEP.Type_Displayed = "5.56x45mm LSAT Caseless Ammunition"
SWEP.Author	= "Goanna, Fox, Mav"
SWEP.Slot = 3
SWEP.PrintName = "LSAT"
SWEP.DrawCrosshair = true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/lsat/c_lsat.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/lsat/world/w_lsat.mdl"
SWEP.WorldModelOffset = Vector(9.0, 1.0, -6.0)
SWEP.WorldModelAngle = Angle(8.0, 180.0, 180.0)
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



--[Gun Related]--
SWEP.Primary.Sound = "Weapons_Ghosts_LSAT.Fire"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("nil"),
	[256] = Sound("Weapons_Ghosts_LSAT.Outdoor")
}
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.075000  -- 800 RPM
SWEP.Primary.MinDamage = 115
SWEP.Primary.MaxDamage = 115
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 400
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .055
SWEP.Primary.IronAccuracy = .025
SWEP.IronRecoilMultiplier = 0.575

SWEP.Primary.KickHorizontal			= 0.15
SWEP.Primary.MinRecoil = -0.2
SWEP.Primary.MaxRecoil = -0.3SWEP.Primary.StaticRecoilFactor = 0.35

SWEP.Primary.SpreadMultiplierMax = 1.8
SWEP.Primary.SpreadIncrement = 0.2
SWEP.Primary.SpreadRecovery = 2.5

--[Iron Sights]--
SWEP.IronBobMult = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-3.35, -2.7, 0.65)
SWEP.IronSightsAng = Vector(0, 0, -0.4)
SWEP.IronSightTime = 0.35

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellEjectDelay = 0

--[Misc]--
SWEP.InspectPos = Vector(2, -1, -1)
SWEP.InspectAng = Vector(10, 10, 0)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8

--[NZombies]--
SWEP.NZPaPName = "Jetpack Joyride"
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
self.NZHeadShotMultiplier = 6
self.Primary.Knockback = 45
self.Primary.Damage = 230
self.Primary.ClipSize = 125
self.Primary.MaxAmmo = self.Primary.ClipSize * 4
self.MuzzleFlashEffect = "muz_pap"
return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
    	vm:SetSubMaterial(2, self.nzPaPCamo)
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
{ ["time"] = 14 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Chamber") },
{ ["time"] = 43 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.End") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 77 / 30, ["type"] = "lua", ["value"] = function(wep) wep:ResetBones() end, ["client"] = true, ["server"] = true},	
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Lift") },
{ ["time"] = 26 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Open") },
{ ["time"] = 54 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Clipout") },
{ ["time"] = 122 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Clipin") },
{ ["time"] = 177 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Close") },
{ ["time"] = 202 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.End") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 77 / 30, ["type"] = "lua", ["value"] = function(wep) wep:ResetBones() end, ["client"] = true, ["server"] = true},	
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Lift") },
{ ["time"] = 26 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Open") },
{ ["time"] = 54 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Clipout") },
{ ["time"] = 122 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Clipin") },
{ ["time"] = 177 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Close") },
{ ["time"] = 201 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.Chamber") },
{ ["time"] = 224 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_LSAT.End") },
},
}

--[Shit]--

SWEP.ViewModelBoneMods = {
        ["bullet0_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet1_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet2_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet3_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet4_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet5_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet6_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
        ["bullet7_jnt"] = {scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)},
}

SWEP.Primary.BeltChain = {
        [0] = "bullet0_jnt",
        [1] = "bullet1_jnt",
        [2] = "bullet2_jnt",
        [3] = "bullet3_jnt",
        [4] = "bullet4_jnt",
        [5] = "bullet5_jnt",
        [6] = "bullet6_jnt",
        [7] = "bullet7_jnt",
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Think2(...)
	local self2 = self:GetTable()

	if CLIENT then
			local belt = self.Primary.BeltChain
			local keys = table.GetKeys(belt)
			local bullet
				
			for i = 1, #keys do
				if self:Clip1() <= keys[i] then
					bullet = belt[keys[i]]
					self.ViewModelBoneMods[bullet].scale = Vector(0, 0, 0)
				elseif self:Clip1() > keys[i] then
					bullet = belt[keys[i]]
					self.ViewModelBoneMods[bullet].scale = Vector(1, 1, 1)
				end
			end
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:ResetBones()
	if not CLIENT then return end
	local belt = self.Primary.BeltChain
	local keys = table.GetKeys(belt)
	local bullet
	for i = 1, #keys do
		bullet = belt[keys[i]]
		self.ViewModelBoneMods[bullet].scale = Vector(1, 1, 1)
	end
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
