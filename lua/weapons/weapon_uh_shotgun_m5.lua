AddCSLuaFile()

SWEP.PrintName 				= "M5"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Shotguns"
SWEP.UseHands 				= true
SWEP.Base                   = "weapon_uh_base_shotty"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_shot_m5_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_m5_pg.mdl"

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
SWEP.SmokeWidth				= 100
SWEP.IsPump                 = true
SWEP.PreCock				= true
SWEP.AnimSprint				= true

SWEP.ShellHeat				= 0.65
SWEP.ShellDelay				= 0.75

SWEP.FireModes = {
	{
		name = "Pump-Action"
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_m5/m5_fire.wav")
SWEP.Primary.ShellSound		= Sound("weapons/uh_m5/m5_insertshell.wav")
SWEP.Primary.PumpSound      = Sound("weapons/uh_m5/m5_pump.wav")
SWEP.Primary.ClipSize 		= 5
SWEP.Primary.Ammo 			= "buckshot"
SWEP.Primary.DefaultClip 	= 5
SWEP.Primary.MinDamage      = 9
SWEP.Primary.MaxDamage      = 11
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 13
SWEP.Primary.Spread 		= 0.31
SWEP.Primary.Delay 			= 1.3
SWEP.Primary.NumberofShots 	= 12
SWEP.Primary.MinRecoil 		= -4.5
SWEP.Primary.MaxRecoil		= -5.8
SWEP.Primary.ReloadTime		= 0.6

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.IronSightsPos = Vector(-3.441, -1.775, 1.2)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.8

function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

	local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end

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