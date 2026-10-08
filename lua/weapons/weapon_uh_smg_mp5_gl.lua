AddCSLuaFile()

SWEP.PrintName 				= "MP5 EOD"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "SMGs"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_smg_mp5_eod_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mp5_eod_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 2
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "smg"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 50
SWEP.AnimSprint				= true

SWEP.FireModes = {
	{
		name = "Auto",
		equip = function(ply, wep)
			wep.Primary.Automatic = true
		end,
		holster = function(ply, wep)
			wep.Primary.Automatic = false
		end
	},
	{
		name = "Semi-Auto",
		equip = function(ply, wep)
			wep.Primary.Automatic = false
		end,
		holster = function(ply, wep)
			wep.Primary.Automatic = true
		end
	},
	{
		name = "Grenade",
		equip = function(ply,wep)
			wep.Primary.Automatic = false
		end,
		holster = function(ply,wep)
			wep.Primary.Automatic = true
		end,
		shoot = function(ply,wep)
			if ply:GetAmmoCount(wep.Secondary.Ammo) <= 0 then return true end
			
			if SERVER then
				wep:ShootGrenade(10000)
			end
			
			local SP = game.SinglePlayer()
			local IFTP = IsFirstTimePredicted()
			
			if (SP and SERVER) or (!SP and CLIENT and IFTP) then
				local fx = EffectData()
				fx:SetEntity(wep)
				fx:SetOrigin(ply:GetShootPos())
				fx:SetNormal(ply:GetAimVector())
				fx:SetAttachment(wep:GetMuzzle())
				util.Effect("uh_muzzle",fx)
				
				wep:CreateSmoke( wep.Primary.Delay + (wep.Primary.Automatic and 0.14 or 0.32) )
			end
			
			local recoil = util.SharedRandom("uh_recoil", wep.Primary.MinRecoil, wep.Primary.MaxRecoil) * (wep:GetNWBool("Zooming") and 0.35 or 1)
			
			ply:SetEyeAngles( ply:EyeAngles() + Angle( recoil, 0, 0 ) )
			ply:ViewPunch( Angle( recoil, 0, 0 ) )
			
			wep:SendWeaponAnim( ACT_VM_IDLE )
			wep:SendWeaponAnim( wep:ShootAnimation() )
			ply:SetAnimation( PLAYER_ATTACK1 )
			ply:MuzzleFlash()
			wep:EmitSound( wep.Secondary.Sound, 110, 100, 1, CHAN_WEAPON )
			wep:TakeSecondaryAmmo(wep.Secondary.TakeAmmo)
			wep:SetNextPrimaryFire( CurTime() + wep.Secondary.Delay ) 
			wep:SetNextSecondaryFire( CurTime() + wep.Secondary.Delay )
			
			wep.NextReload = CurTime() + 0.5
			
			return true
		end
	}
}

SWEP.ReloadTable = {
	{delay = 0.4, sound = Sound("weapons/uh_mp5eod/mp5_boltslap.wav")},
	{delay = 1, sound = Sound("weapons/uh_mp5eod/mp5_clipout.wav")},
	{delay = 2.5, sound = Sound("weapons/uh_mp5eod/mp5_clipin.wav")},
	{delay = 3.3, sound = Sound("weapons/uh_mp5eod/mp5_boltpull.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_mp5eod/mp5_fire.wav")
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Ammo 			= "smg1" 
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.MinDamage      = 16
SWEP.Primary.MaxDamage      = 17
SWEP.Primary.Automatic 		= true
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 12
SWEP.Primary.Spread 		= 0.18
SWEP.Primary.Delay 			= 0.08
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.6
SWEP.Primary.MaxRecoil		= -1.1

SWEP.Secondary.Sound		= Sound("weapons/uh_glauncher/fire.wav")
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.Ammo 		= "smg1_grenade"
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Delay 		= 0.8
SWEP.Secondary.TakeAmmo		= 1
SWEP.Secondary.MinRecoil 	= -2.4
SWEP.Secondary.MaxRecoil	= -3.1

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.385, -5, 0.901)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.GLSightsPos = Vector(-4.16, -6.1, 0.81)
SWEP.GLSightsAng = Vector(0, 1.2, 0)

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

function SWEP:CustomThink(ct)
	if SERVER then return end
	if self:GetNWInt("FireMode") != 3 then
		self.IronSightsPos = Vector(-3.385, -5, 0.901)
		self.IronSightsAng = Vector(0, 0, 0)
	else
		self.IronSightsPos = Vector(-4.16, -6.1, 0.81)
		self.IronSightsAng = Vector(0, 1.2, 0)
	end
end

function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

    local vel = self.Owner:GetVelocity():LengthSqr()
    local sprinting = self.Owner:KeyDown(IN_SPEED)
        and vel > self.Owner:GetWalkSpeed() ^ 2

    if sprinting then
        -- ENTER RUNNING
        if not self:GetUHBool("Running") then
            -- ❗ ONLY play lowering anim if NOT reloading
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE)
                self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
            end
        end

        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
    else
        -- EXIT RUNNING
        if self:GetUHBool("Running") then
            -- ❗ Same rule applies here
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)
                self:SendWeaponAnim(ACT_VM_LOWERED_TO_IDLE)
            end
        end

        self:SetUHBool("Running", false)
    end
end

function SWEP:PostReload()
    if IsValid(self.Owner)
    and self.Owner:KeyDown(IN_SPEED) then
        timer.Simple(0, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            self:SetUHBool("Running", true)

            self:SendWeaponAnim(ACT_VM_IDLE)
            self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
        end)
    end
end