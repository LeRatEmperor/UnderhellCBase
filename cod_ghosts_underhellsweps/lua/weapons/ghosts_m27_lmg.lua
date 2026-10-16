AddCSLuaFile()

local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Light Machine Guns"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Auto-Ordnance Company"
SWEP.Author = "Wavy"
SWEP.Slot = 2
SWEP.PrintName = "M27-IAR"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/ghosts/c_m27_lmg.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/wavy_ports/ghosts/w_m27_lmg.mdl"
SWEP.WorldModelOffset = Vector(14.0, 1.0, -6.5)
SWEP.WorldModelAngle = Angle(0.0, 180.0, 195.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Angle(0, 0, -5)
SWEP.VMPos_Additive = false



--[Gun Related]--
SWEP.Primary.Sound = "TFA_GHOSTS.M27_LMG.FIRE"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.080000  -- 750 RPM
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.MinDamage = 100
SWEP.Primary.MaxDamage = 100
SWEP.Primary.NumberofShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.35
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = ""
SWEP.FireModeName = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = true
SWEP.LowAmmoSoundThreshold = 0.2 --0.33
//SWEP.LowAmmoSound = nil
//SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.DisplayFalloff = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 30, damage = 1.0},
		{range = 45, damage = 0.6},
	}
}

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		  = .035
SWEP.Primary.IronAccuracy = .008
SWEP.IronRecoilMultiplier = 0.6

SWEP.Primary.KickHorizontal		= 0.15
SWEP.Primary.MinRecoil = -0.15
SWEP.Primary.MaxRecoil = -0.25SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 1.0
SWEP.Primary.SpreadRecovery = 5


--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.ZoomFov = 20
SWEP.IronSightsPos = Vector(-4.44, -4, 0.25)
SWEP.IronSightsAng = Angle(0.1, 0, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "RifleShellEject"
--SWEP.LuaShellSound = 
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
--SWEP.AmmoTypeStrings = {ar2 = ".45 ACP"}
SWEP.InspectPos = Vector(9, -2, -2)
SWEP.InspectAng = Vector(10.8, 43.2, 20.399)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed = 0.4
SWEP.SafetyPos = Vector(0, -2, 0)
SWEP.SafetyAng = Vector(-19, 21, -21)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3

--[NZombies]--
SWEP.NZPaPName = "Mystifier 2.0"
SWEP.NZHeadShotMultiplier = 3
SWEP.Primary.MaxAmmo = 400
function SWEP:NZMaxAmmo()

	local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Primary.DamagePAP = 175
SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = self.Primary.DamagePAP
self.Primary.ClipSize = 125
self.Primary.MaxAmmo = 800
self.MuzzleFlashEffect = "muz_pap"
self.NZHeadShotMultiplier = 4

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
}



SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

SWEP.AnimSounds = {
    ["deploy"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_LARGE.Generic" },
    },
    ["act_vm_draw_deployed"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_LARGE.Generic" },
    },
}

--[Shit]--

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
