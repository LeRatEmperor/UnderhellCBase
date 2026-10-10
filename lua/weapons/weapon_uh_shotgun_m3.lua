AddCSLuaFile()

SWEP.PrintName 				= "Benelli M3"
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
SWEP.ViewModel				= "models/weapons/v_shot_m3_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_m3_pg.mdl"

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
SWEP.SmokeWidth				= 75
SWEP.IsPump                 = true
SWEP.PreCock				= true
SWEP.AnimSprint				= true

SWEP.ShellHeat				= 0.6
SWEP.ShellDelay				= 0.5

SWEP.FireModes = {
	{
		name = "Pump-Action"
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_m3/m3_fire.wav")
SWEP.Primary.PumpSound      = Sound("weapons/uh_m3/m3_pump.wav")
SWEP.Primary.ClipSize 		= 7
SWEP.Primary.Ammo 			= "buckshot"
SWEP.Primary.DefaultClip 	= 7
SWEP.Primary.MinDamage      = 8
SWEP.Primary.MaxDamage      = 9
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 13
SWEP.Primary.Spread 		= 0.46
SWEP.Primary.Delay 			= 1
SWEP.Primary.NumberofShots 	= 12
SWEP.Primary.MinRecoil 		= -4.5
SWEP.Primary.MaxRecoil		= -5.8
SWEP.Primary.ReloadTime		= 0.6

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.IronSightsPos = Vector(-2.86, -2.401, 1.345)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.8

if SERVER or CLIENT then
    sound.Add({
        name    = "weapons/m3/m3_insertshell.wav",
        channel = CHAN_WEAPON,
        volume  = 0.75,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/m3/m3_insertshell.wav"
    })
end

SWEP.Primary.ShellSound		= Sound("weapons/uh_m3/m3_insertshell.wav")

SWEP.ReloadTable = {}

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