AddCSLuaFile()

SWEP.PrintName 				= "Wrench"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Melees"
SWEP.UseHands 				= true
SWEP.Base					= "weapon_uh_base_melee"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_wrench_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_wrench_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 0
SWEP.SlotPos 				= 5

SWEP.HoldType 				= "melee"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.ViewModelFlip			= false

SWEP.Primary.SwingSound		= Sound( "weapons/uh_wrench/wrench_swing"..math.random(1,2)..".wav" )
SWEP.Primary.HitSound		= Sound( "weapons/uh_wrench/wrench_hitbod"..math.random(1,3)..".wav" )
SWEP.Primary.HitWorldSound	= Sound( "weapons/uh_wrench/wrench_hitworld"..math.random(1,2)..".wav" )
SWEP.Primary.MinDamage		= 27
SWEP.Primary.MaxDamage		= 32
SWEP.Primary.Force			= 1000
SWEP.Primary.HurtTime		= 0.25
SWEP.Primary.Delay			= 0.75
SWEP.Primary.Recoil			= Angle(-4,-4,0)
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""
SWEP.Primary.Anim			= ACT_VM_MISSCENTER
SWEP.Primary.DamageType		= DMG_CLUB

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""