//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "Saiga-12K"
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
SWEP.Secondary.IronFOV	= 65
SWEP.ViewModel			= "models/weapons/c_saiga12.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_saiga12.mdl"
SWEP.HoldType 			= "ar2"
SWEP.VMPos				= Vector(0.25, 0, -0.5)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= false

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/saiga12_fire.wav")
SWEP.Primary.RPM			= 250
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6*11
SWEP.Primary.KickUp			= 1
SWEP.Primary.KickHorizontal	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.NumShots		= 12
SWEP.Primary.Damage			= 12
SWEP.Primary.Spread			= .09
SWEP.Primary.IronAccuracy	= .07


//Ironsights
SWEP.SightsPos 		= Vector(-2.026, -4, 0.589)
SWEP.SightsAng 		= Vector(0.4, 0.039, 0)
SWEP.InspectPos 	= Vector(5, -4, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(5.786, -5, -1)
SWEP.RunSightsAng 	= Vector(-10.778, 57.573, 0)
SWEP.SprintBobMult 	= 1.5

SWEP.Type = "Shotgun"

SWEP.LuaShellEject 		= true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect 	= "RifleShellEject"
SWEP.LuaShellScale 		= 0.5

SWEP.FireModes = {
	"Single",
	"Safe",
}