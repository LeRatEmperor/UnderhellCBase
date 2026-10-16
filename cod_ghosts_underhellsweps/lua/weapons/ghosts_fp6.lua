AddCSLuaFile()

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Shotguns"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Author				= "Goanna, Fox, Mav"
SWEP.Slot = 3
SWEP.PrintName = "FP6"
SWEP.DrawCrosshair		= true

--[Model]--
SWEP.ViewModel			= "models/weapons/iw6/fp6/c_fp6.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/iw6/fp6/world/w_fp6.mdl"
SWEP.WorldModelOffset = Vector(8.5, 1.0, -5.5)
SWEP.WorldModelAngle = Angle(10.0, 180.0, 180.0)
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
SWEP.Primary.Sound = "Weapons_Ghosts_FP6.Fire"
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.240000  -- 250 RPM
SWEP.Primary.MinDamage = 80
SWEP.Primary.MaxDamage = 80
SWEP.Primary.NumberofShots = 8
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 50
SWEP.FiresUnderwater = true

--[Spread Related]--
SWEP.Primary.Spread		= .065	

SWEP.Primary.KickHorizontal			= 0.35
SWEP.Primary.MinRecoil = -1.2
SWEP.Primary.MaxRecoil = -1.2


--[Iron Sights]--
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-3.825, -2, 1)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--

--[Misc]--

--[NZombies]--
SWEP.NZPaPName = "FireyPussy650000"
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
self.PumpAction = nil
self.Primary.ClipSize = 10
self.Primary.MaxAmmo = self.Primary.ClipSize * 30
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






    ["value"] = ACT_VM_PULLBACK_HIGH, -- Number for act, String/Number for sequence
	["value_empty"] = ACT_VM_PULLBACK_HIGH,
    ["value_is"] = ACT_VM_PULLBACK_LOW, -- ADS pump
}

SWEP.AnimatedSprint = true

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
	},
	[ACT_VM_HOLSTER] = {
		{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_MEDIUM.Generic") },
	},
	[ACT_VM_PULLBACK_HIGH] = {
		{time = 0.1, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
	},
	[ACT_VM_PULLBACK_LOW] = {
		{time = 0.1, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
	},
	[ACT_VM_RELOAD] = {
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Lift") },
		{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 43 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
		{ ["time"] = 56 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.End") },
	},
	[ACT_RELOAD_LOW] = {
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Lift") },
		{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 21 / 30, ["type"] = "lua", ["value"] = function(self, ply)
	
			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and self:Clip1() ~= 9 and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 8 or 4) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 57 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
		{ ["time"] = 71 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.End") },
	},
	[ACT_VM_RELOAD2] = {
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Lift") },
		{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 21 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and self:Clip1() ~= 7 and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 6 or 3) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 37 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 8 or 4) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 72 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
		{ ["time"] = 86 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.End") },
	},
	[ACT_VM_RELOAD_SILENCED] = {
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Lift") },
		{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 21 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and self:Clip1() ~= 3 and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end

			self:SetClip1(self.Ispackapunched and 4 or 2) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 37 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 6 or 3) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 53 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 8 or 4) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 69 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 86 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
		{ ["time"] = 103 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.End") },
	},
	[ACT_VM_RELOAD_EMPTY] = {
		{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Lift") },
		{ ["time"] = 21 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 21 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and self:Clip1() ~= 1 and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end

			self:SetClip1(self.Ispackapunched and 2 or 1) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 37 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end

			self:SetClip1(self.Ispackapunched and 4 or 2) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 53 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 53 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end

			self:SetClip1(self.Ispackapunched and 6 or 3) 

		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 69 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 69 / 30, ["type"] = "lua", ["value"] = function(self, ply)

			local owner = self:GetOwner()
			local ammo_type = self.Primary.Ammo
			local cost = self.Ispackapunched and 2 or 1

			if owner:IsValid() then owner:RemoveAmmo(cost, ammo_type) end
            
			self:SetClip1(self.Ispackapunched and 8 or 4) 
		end, ["client"] = true, ["server"] = true },
		{ ["time"] = 85 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Insert") },
		{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.Chamber") },
		{ ["time"] = 116 / 30, ["type"] = "sound", ["value"] = Sound("Weapons_Ghosts_FP6.End") },
	},
}

--[Shit]--

--[The Sauce]--
--(Credit to 'Momentary Bliss' for the code in HLA shotgun used to make this possible)--
DEFINE_BASECLASS( SWEP.Base )

SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["deploy"] = "draw",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
	["reload_1"] = {
		["value"] = ACT_VM_RELOAD
	},
	["reload_2"] = {
		["value"] = ACT_RELOAD_LOW
	},
	["reload_3"] = {
		["value"] = ACT_VM_RELOAD2
	},
	["reload_4"] = {
		["value"] = ACT_VM_RELOAD_SILENCED
	},
	["reload"] = {
		["value"] = ACT_VM_RELOAD_EMPTY
	},
}

function SWEP:ChooseReloadAnim()

	local clip = self:Clip1()

	local Reload_Table = { 
		[4] = { act = ACT_VM_RELOAD, seq = "reload_1"},
		[3] = { act = ACT_RELOAD_LOW, seq = "reload_2"},
		[2] = { act = ACT_VM_RELOAD2, seq = "reload_3"},
		[1] = { act = ACT_VM_RELOAD_SILENCED, seq = "reload_4"},
		[0] = { act = ACT_VM_RELOAD_EMPTY, seq = "reload"},
	}

	local Reload_Pap_Table = {
		[9] = { act = ACT_VM_RELOAD, seq = "reload_1"},
		[8] = { act = ACT_VM_RELOAD, seq = "reload_1"},
		[7] = { act = ACT_RELOAD_LOW, seq = "reload_2"},
		[6] = { act = ACT_RELOAD_LOW, seq = "reload_2"},
		[5] = { act = ACT_VM_RELOAD2, seq = "reload_3"}, 
		[4] = { act = ACT_VM_RELOAD2, seq = "reload_3"}, 
		[3] = { act = ACT_VM_RELOAD_SILENCED, seq = "reload_4"},
		[2] = { act = ACT_VM_RELOAD_SILENCED, seq = "reload_4"},
		[1] = { act = ACT_VM_RELOAD_EMPTY, seq = "reload"},
		[0] = { act = ACT_VM_RELOAD_EMPTY, seq = "reload"},
	}

	if self.Ispackapunched then Reload_Table = Reload_Pap_Table end

	if self:GetActivityEnabled( Reload_Table[clip].act ) then

		typev, tanim = self:LookupSequence( Reload_Table[clip].seq )

	else

		local _
		_, tanim = self:ChooseIdleAnim()

		return false, tanim

	end

		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
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
