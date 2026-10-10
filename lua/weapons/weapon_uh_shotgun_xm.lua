AddCSLuaFile()

SWEP.PrintName 				= "XM1014"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Shotguns"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_shotty"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_shot_xm1014_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_xm1014_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 3
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "shotgun"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.reloaddelay 			= 0
SWEP.SmokeWidth				= 110
SWEP.TwoHanded				= true
SWEP.PreCock				= true
SWEP.AnimSprint				= true

SWEP.ShellHeat				= 0.75

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
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_xm/xm1014_fire.wav")
SWEP.Primary.PumpSound      = Sound("weapons/uh_xm/xm1014_cock.wav")
SWEP.Primary.ShellSound     = Sound("weapons/uh_xm/xm1014_insertshell.wav")
SWEP.Primary.ClipSize 		= 8
SWEP.Primary.Ammo 			= "buckshot" 
SWEP.Primary.DefaultClip 	= 8 
SWEP.Primary.MinDamage      = 9
SWEP.Primary.MaxDamage      = 13
SWEP.Primary.Automatic 		= true
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 8
SWEP.Primary.Spread 		= 0.51
SWEP.Primary.Delay 			= 0.35
SWEP.Primary.NumberofShots 	= 8
SWEP.Primary.MinRecoil 		= -3
SWEP.Primary.MaxRecoil		= -4.5
SWEP.Primary.ReloadTime		= 0.6


SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.IronSightsPos = Vector(-3.481, -3.161, 1.08)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

function SWEP:PostReload()
	if !GetConVar("uh_sv_realpump"):GetBool() then return end
	if SERVER and self.b_clip <= 0 and self:Clip1() > self.b_clip then
		self.b_clip = nil
		
		local ct = CurTime()
		local delay = self.PumpDelay or 0.5
		
		self:SetNextPrimaryFire(ct + delay + 1.5)
		self:SetNextSecondaryFire(ct + delay + 1.5)
		self.NextReload = ct + delay + 1.5
		
		timer.Simple(delay, function()
			if !IsValid(self) or self:GetNWBool("Reloading") or self:GetNWBool("Running") or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
			self.Owner:EmitSound( self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE )
			self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
		end)
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