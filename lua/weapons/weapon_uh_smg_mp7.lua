AddCSLuaFile()

SWEP.PrintName 				= "MP7"
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
SWEP.ViewModel				= "models/weapons/v_smg_mp7_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mp7_pg.mdl"

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
	}
}

SWEP.ReloadTable = {
	{delay = 0.3, sound = Sound("weapons/uh_mp7/mp7_magout.wav")},
	{delay = 1.1, sound = Sound("weapons/uh_mp7/mp7_magin.wav")},
	{delay = 1.9, sound = Sound("weapons/uh_mp7/mp7_charger.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_mp7/mp7_fire.wav")
SWEP.Primary.ClipSize 		= 40
SWEP.Primary.Ammo 			= "smg1" 
SWEP.Primary.DefaultClip 	= 40
SWEP.Primary.MinDamage      = 12
SWEP.Primary.MaxDamage      = 15
SWEP.Primary.Automatic 		= true
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 10
SWEP.Primary.Spread 		= 0.16
SWEP.Primary.Delay 			= 0.09
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.6
SWEP.Primary.MaxRecoil		= -1

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.475, -3.881, 0.959)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.LeftBones = {
	["Left_U_Arm"] = Angle(-20,70,-25)
}

SWEP.SwayPosition = 3.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
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