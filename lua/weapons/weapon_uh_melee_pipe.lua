AddCSLuaFile()

SWEP.PrintName 				= "Lead Pipe"
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
SWEP.ViewModel				= "models/weapons/v_pipe_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pipe_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 0
SWEP.SlotPos 				= 4

SWEP.HoldType 				= "melee"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.ViewModelFlip			= false

SWEP.Primary.SwingSound		= Sound( "weapons/uh_pipe/pipe_swing.wav" )
SWEP.Primary.HitSound		= Sound( "weapons/uh_pipe/pipe_hitbod"..math.random(1,3)..".wav" )
SWEP.Primary.HitWorldSound	= Sound( "weapons/uh_pipe/pipe_hitworld"..math.random(1,2)..".wav" )
SWEP.Primary.MinDamage		= 35
SWEP.Primary.MaxDamage		= 45
SWEP.Primary.Force			= 1800
SWEP.Primary.HurtTime		= 0.25
SWEP.Primary.Delay			= 0.8
SWEP.Primary.Recoil			= Angle(-4,-6,0)
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