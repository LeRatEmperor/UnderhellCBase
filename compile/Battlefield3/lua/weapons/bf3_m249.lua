//If you are reading this, and you are going to reupload it in the workshop, posing as the author of this addon, you are a cunt

SWEP.PrintName			= "M249 SAW"
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
SWEP.ViewModel			= "models/weapons/c_m249.mdl"
SWEP.WorldModel			= "models/bf3/weapons/w_m249.mdl"
SWEP.HoldType 			= "ar2"
SWEP.VMPos				= Vector(0.5, 0, -1)
SWEP.VMPos_Additive		= false
//
SWEP.Base				= "tfa_gun_base"
SWEP.UseHands			= true
SWEP.FiresUnderwater	= false
SWEP.Penetration		= true
SWEP.SelectiveFire		= true
SWEP.BlowbackEnabled	= true
SWEP.Blowback_Only_Iron	= true
SWEP.BlowbackVector		= Vector(0, -0.5, 0)

//Primary
SWEP.Primary.Sound			= Sound("bf3/weapons/m249_fire.wav")
SWEP.Primary.SilencedSound	= Sound("bf3/weapons/m249_fire_suppressed.wav")
SWEP.Primary.RPM			= 800
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100*3
SWEP.Primary.KickUp			= 0.25
SWEP.Primary.KickHorizontal	= 0.1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.NumShots		= 1
SWEP.Primary.Damage			= 30
SWEP.Primary.Spread			= .025
SWEP.Primary.IronAccuracy	= .01


//Ironsights
SWEP.SightsPos 		= Vector(-3.411, -3, 1.09)
SWEP.SightsAng 		= Vector(0, 0.039, 0)
SWEP.InspectPos 	= Vector(5, -4, 0)
SWEP.InspectAng 	= Vector(8, 39, 8)
SWEP.RunSightsPos 	= Vector(5.786, -5, -1)
SWEP.RunSightsAng 	= Vector(-10.778, 57.573, 0)
SWEP.SprintBobMult 	= 1.5
//
SWEP.SightsPos_Reflex	= Vector(-3.405, -5.5, 0.194)
SWEP.SightsAng_Reflex 	= Vector(0, 0, 0)
SWEP.SightsPos_Kobra 	= Vector(-3.42, -5.5, 0.132)
SWEP.SightsAng_Kobra 	= Vector(0, 0, 0)
SWEP.SightsPos_Eotech	= Vector(-3.4125, -5.5, 0.352)
SWEP.SightsAng_Eotech 	= Vector(0, 0, 0)
SWEP.SightsPos_ACOG 	= Vector(-3.416, -4, 0.271)
SWEP.SightsAng_ACOG 	= Vector(0, 0, 0)
//
SWEP.Secondary.IronFOV_Scope		= 10
SWEP.Secondary.IronFOV_ACOG			= 40
SWEP.Secondary.IronFOV_Collimator	= 60


SWEP.Attachments = {
        [1] = { offset = { 0, 0 }, atts = {"bf3_reflex","bf3_kobra","bf3_eotech","bf3_acog"}, 	order = 2 },
        [2] = { offset = { 0, 0 }, atts = {"bf3_muzzle","bf3_suppressor"}, 			order = 2 },
}

SWEP.Type = "Light-Machine Gun"

SWEP.LuaShellEject 		= true
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect 	= "RifleShellEject"
SWEP.LuaShellScale 		= 0.45

SWEP.FireModes = {
	"Auto",
	"Single",
	"Safe",
}