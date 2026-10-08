AddCSLuaFile()

SWEP.PrintName 				= "Minigun"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Heavy"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_minigun_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_minigun_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 3

SWEP.HoldType 				= "crossbow"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.Chambering				= false
SWEP.SmokeWidth				= 100
SWEP.TwoHanded				= true
SWEP.AnimSprint				= true

SWEP.ShellHeat				= 1
SWEP.Shell					= "models/weapons/shell_762.mdl"

SWEP.FireModes = {
	{
		name = "Auto"
	}
}

SWEP.ReloadTable = {
	{delay = 0.6, sound = Sound("weapons/uh_minigun/minigun_boxout.wav")},
	{delay = 1.5, sound = Sound("weapons/uh_minigun/minigun_boxin.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_minigun/minigun-1.wav")
SWEP.Primary.ClipSize 		= 200
SWEP.Primary.Ammo 			= "ar2" 
SWEP.Primary.DefaultClip 	= 200
SWEP.Primary.MinDamage      = 12
SWEP.Primary.MaxDamage      = 18
SWEP.Primary.Automatic 		= true
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 15
SWEP.Primary.Spread 		= 0.1
SWEP.Primary.Delay 			= 0.08
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.6
SWEP.Primary.MaxRecoil		= -1.4

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Inspection = {
	{
		pos = Vector(8.147, -11.634, -1.204),
		ang = Angle(40, 40, 40)
	},
	{
		pos = Vector(-2.882, -7.665, -7.185),
		ang = Angle(20, 40, -44.924)
	},
}

SWEP.LeftBones = {
	["Left_U_Arm"] = Angle(-10,90,-20)
}

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

function SWEP:GetShellDirection()
	return Angle(45,-90,0)
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