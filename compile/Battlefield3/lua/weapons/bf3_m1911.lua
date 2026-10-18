//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "M1911"
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
SWEP.ViewModel			= "models/weapons/c_m1911.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_m1911.mdl"
SWEP.HoldType 			= "revolver"
SWEP.VMPos				= Vector(0.25, 0, -0.75)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= false

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/m1911_fire.wav")
SWEP.Primary.SilencedSound	= Sound("bf3/weapons/m1911_fire_suppressed.wav")
SWEP.Primary.RPM			= 400
SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8*3
SWEP.Primary.KickUp			= 0.25
SWEP.Primary.KickHorizontal	= 0.1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Damage			= 35
SWEP.Primary.Spread			= .025
SWEP.Primary.IronAccuracy	= .01


//Ironsights
SWEP.SightsPos 		= Vector(-2.54, -4, 0.78)
SWEP.SightsAng 		= Vector(1, 0, 0)
SWEP.InspectPos 	= Vector(6, -5, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(2, -7.628, -6.624)
SWEP.RunSightsAng 	= Vector(50, 0, 0)
SWEP.SprintBobMult 	= 1

SWEP.Attachments = {
    [1] = { offset = { 0, 0 }, atts = {"bf3_suppressor"},order = 2 },
}

SWEP.Type = "Pistol"

SWEP.LuaShellEject 		= true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect 	= "RifleShellEject"
SWEP.LuaShellScale 		= 0.425

SWEP.FireModes = {
	"Single",
	"Safe",
}