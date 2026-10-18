//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "M82A3"
SWEP.Category			= "[TFA][AT] Battlefield 3"
SWEP.Author				= "Steffan Shibe"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.Slot				= 3
SWEP.SlotPos			= 10
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true
//
SWEP.ViewModelFOV		= 75
SWEP.Secondary.IronFOV	= 10
SWEP.ViewModel			= "models/weapons/c_m82a3.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_m82a3.mdl"
SWEP.ViewModelBoneMods 	= {
	["Bone22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16, 4, 2) }
}
SWEP.HoldType 			= "ar2"
SWEP.VMPos				= Vector(0.5, 0, -0.5)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= false

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/m82a3_fire.wav")
SWEP.Primary.RPM			= 120
SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10*3
SWEP.Primary.KickUp			= 1
SWEP.Primary.KickHorizontal	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Damage			= 150
SWEP.Primary.Spread			= .08
SWEP.Primary.IronAccuracy	= .0
SWEP.BlowbackBoneMods 		= {
	["Bolt"] 	= { scale = Vector(1, 1, 1), pos = Vector(0, 3, 0), angle = Angle(0, 0, 0) },
}


//Ironsights
SWEP.SightsPos 		= Vector(-2.481, -3, 1.09)
SWEP.SightsAng 		= Vector(0, 0.039, 0)
SWEP.InspectPos 	= Vector(5, -4, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(5.786, -5, -1)
SWEP.RunSightsAng 	= Vector(-10.778, 57.573, 0)
SWEP.SprintBobMult 	= 1.5


SWEP.Type = "Sniper Rifle"

SWEP.LuaShellEject 		= true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect 	= "RifleShellEject"
SWEP.LuaShellScale 		= 0.85

SWEP.FireModes = {
	"Single",
	"Safe",
}

SWEP.BoltAction                 = false
SWEP.Scoped                     = true
SWEP.ScopeOverlayThreshold      = 0.9
SWEP.ScopeScale                 = 0.6
SWEP.ReticleScale               = 0.5
SWEP.Secondary.UseParabolic     = true 
SWEP.Secondary.ScopeTable 	= {
	["ScopeMaterial"] 		=  Material("bf3/scope.png", "smooth"),
	["ScopeBorder"] 		= color_black,
	["ScopeCrosshair"] 		= { ["r"] = 0, ["g"]  = 0, ["b"] = 0, ["a"] = 255, ["s"] = 1 }
}