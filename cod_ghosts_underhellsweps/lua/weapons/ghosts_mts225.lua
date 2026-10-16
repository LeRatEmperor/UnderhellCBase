AddCSLuaFile()

local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Shotguns"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Author = "Wavy"
SWEP.Slot = 2
SWEP.PrintName = "MTS-225"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/ghosts/c_mts225.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/wavy_ports/ghosts/w_mts225.mdl"
SWEP.WorldModelOffset = Vector(14.0, 1.0, -5.5)
SWEP.WorldModelAngle = Angle(0.0, 180.0, 195.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "ar2"
SWEP.MuzzleAttachment = "1"



--[Gun Related]--
SWEP.Primary.Sound = "TFA_GHOSTS.MTS225.FIRE"
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.240000  -- 250 RPM
SWEP.Primary.MinDamage = 100
SWEP.Primary.MaxDamage = 100
SWEP.Primary.NumberofShots = 8
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
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
		{range = 10, damage = 1.0},
		{range = 20, damage = 0.2},
	}
}

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		  = .045

SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.MinRecoil = -0.5
SWEP.Primary.MaxRecoil = -0.5



--[Iron Sights]--
SWEP.ZoomFov = 20
SWEP.IronSightsPos = Vector(-5, -2, 0.95)
SWEP.IronSightsAng = Angle(0.1, 0.03, 0)
SWEP.IronSightTime = 0.25

--[Shells]--
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
--SWEP.AmmoTypeStrings = {ar2 = ".45 ACP"}
SWEP.SafetyPos = Vector(0, -2, 0)
SWEP.SafetyAng = Vector(-19, 21, -21)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3

--[NZombies]--
SWEP.NZPaPName = "Engine-115"
SWEP.Primary.MaxAmmo = 60
function SWEP:NZMaxAmmo()

	local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Primary.DamagePAP = 150
SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = self.Primary.DamagePAP
self.Primary.Spread = .02
self.Primary.NumShots = 10
self.Primary.MaxAmmo = 100
self.Primary.Force = 9800
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
