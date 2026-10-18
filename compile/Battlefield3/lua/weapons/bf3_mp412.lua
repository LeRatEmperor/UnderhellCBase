//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "MP412"
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
SWEP.ViewModel			= "models/weapons/c_mp412.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_mp412.mdl"
SWEP.HoldType 			= "revolver"
SWEP.VMPos				= Vector(0.25, 1, -0.25)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= false
SWEP.Blowback_Only_Iron	= true
SWEP.DisableChambering 	= true

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/mp412_fire.wav")
SWEP.Primary.RPM			= 160
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6*3
SWEP.Primary.KickUp			= 0.65
SWEP.Primary.KickHorizontal	= 0.35
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Damage			= 85
SWEP.Primary.Spread			= .015
SWEP.Primary.IronAccuracy	= .005


//Ironsights
SWEP.SightsPos 		= Vector(-2.372, -4, 0.67)
SWEP.SightsAng 		= Vector(0.2, 0, 0)
SWEP.InspectPos 	= Vector(5, -4, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(2, -7.628, -6.624)
SWEP.RunSightsAng 	= Vector(50, 0, 0)
SWEP.SprintBobMult 	= 1

SWEP.Type = "Pistol"

SWEP.LuaShellEject 		= false
SWEP.BlowbackEject 		= false

SWEP.FireModes = {
	"Single",
	"Safe",
}