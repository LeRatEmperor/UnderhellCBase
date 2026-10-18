//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "870MCS"
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
SWEP.Secondary.IronFOV	= 70
SWEP.Secondary.IronFOV	= 65
SWEP.ViewModel			= "models/weapons/c_870mcs.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_870mcs.mdl"
SWEP.HoldType 			= "shotgun"
SWEP.VMPos				= Vector(0.5, 0.5, -1)
SWEP.VMAng				= Vector(0, 0, 0)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= false
SWEP.Shotgun			= true

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/870mcs_fire.wav")
SWEP.Primary.RPM			= 90
SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 7*11
SWEP.Primary.KickUp			= 2
SWEP.Primary.KickHorizontal	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.NumShots		= 12
SWEP.Primary.Damage			= 12
SWEP.Primary.Spread			= .09
SWEP.Primary.IronAccuracy	= .07


//Ironsights
SWEP.SightsPos 		= Vector(-2, -4, 0.6)
SWEP.SightsAng 		= Vector(0.5, 0, 0)
SWEP.InspectPos 	= Vector(5, -4, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(5.786, -5, -1)
SWEP.RunSightsAng 	= Vector(-10.778, 57.573, 0)
SWEP.SprintBobMult 	= 1.5

SWEP.Type = "Shotgun"

SWEP.LuaShellEject 		= true
SWEP.LuaShellEjectDelay = 0.25
SWEP.LuaShellEffect 	= "RifleShellEject"
SWEP.LuaShellScale 		= 0.45

SWEP.FireModes = {
	"Single",
	"Safe",
}