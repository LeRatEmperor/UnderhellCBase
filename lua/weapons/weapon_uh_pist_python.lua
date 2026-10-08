AddCSLuaFile()

SWEP.PrintName 				= "Python"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Pistols"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_pist_python_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_python_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "revolver"
SWEP.PassiveAnim			= "normal"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 25
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 70
SWEP.Chambering				= false
SWEP.AnimSprint				= true

SWEP.NoShell				= true
SWEP.Shell					= "models/weapons/shell_762.mdl"

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	}
}

SWEP.ReloadTable = {
	{delay = 0.1, sound = Sound("weapons/uh_python/python_unfold.wav")},
	{delay = 0.5, sound = Sound("weapons/uh_python/python_bulletsout.wav")},
	{delay = 1.6, sound = Sound("weapons/uh_python/python_bulletsin.wav")},
	{delay = 2, sound = Sound("weapons/uh_python/python_blick.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_python/python_fire.wav")
SWEP.Primary.ClipSize 		= 6
SWEP.Primary.Ammo 			= "357"
SWEP.Primary.DefaultClip 	= 6
SWEP.Primary.MinDamage      = 34
SWEP.Primary.MaxDamage      = 38
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 7
SWEP.Primary.Spread 		= 0.021
SWEP.Primary.Delay 			= 0.42
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -2.3
SWEP.Primary.MaxRecoil		= -2.8

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-4.297, -6.5, 1.358)
SWEP.IronSightsAng = Vector(0.25, 0, 0)

SWEP.SwayPosition = 2.8

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

function SWEP:GetShellDirection()
	return Angle(-90,-180,0)
end

function SWEP:CustomThink()
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		vm:SetBodygroup(1, 1)
	end
end

function SWEP:PreReload()
	local SP = game.SinglePlayer()
	local IFTP = IsFirstTimePredicted()
	
	if (SP and SERVER) or (!SP and CLIENT and IFTP) then
		timer.Simple(0.8, function()
			if ( !IsValid( self ) or !self:GetUHBool("Reloading") or !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self ) then return end
			self:CreateShell(0, 0)
			self:CreateShell(0, 0)
			self:CreateShell(0, 0)
			self:CreateShell(0, 0)
			self:CreateShell(0, 0)
			self:CreateShell(0, 0)
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