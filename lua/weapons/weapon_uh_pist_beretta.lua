AddCSLuaFile()

SWEP.PrintName 				= "Beretta"
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
SWEP.ViewModel				= "models/weapons/v_pist_beretta_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_beretta_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 2

SWEP.HoldType 				= "pistol"
SWEP.PassiveAnim			= "normal"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 25
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 50
SWEP.HasSilencer			= true
SWEP.AnimSprint				= true

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	}
}

SWEP.ReloadTable = {
	{delay = 1, sound = Sound("weapons/uh_beretta/beretta_sliderelease.wav")},
	{delay = 0.1, sound = Sound("weapons/uh_beretta/beretta_clipout.wav")},
	{delay = 0.6, sound = Sound("weapons/uh_beretta/beretta_clipin.wav")},
	{delay = 0, sound = Sound("weapons/uh_beretta/beretta_slideback.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_beretta/beretta_fire.wav")
SWEP.Primary.SilSound		= Sound("weapons/uh_beretta/beretta_fire_silenced.wav")
SWEP.Primary.ClipSize 		= 15
SWEP.Primary.Ammo 			= "pistol"
SWEP.Primary.DefaultClip 	= 15
SWEP.Primary.MinDamage      = 17
SWEP.Primary.MaxDamage		= 19
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 8
SWEP.Primary.Spread 		= 0.08
SWEP.Primary.Delay 			= 0.14
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.8
SWEP.Primary.MaxRecoil		= -1.1

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.IronSightsPos = Vector(-4.12, -4.321, 1.879)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
	["reload_empty_sil"] = "ACT_VM_RELOAD",
	["reload_sil"] = "ACT_VM_RELOAD"
}

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