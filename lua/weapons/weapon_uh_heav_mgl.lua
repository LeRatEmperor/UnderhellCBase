AddCSLuaFile()

SWEP.PrintName 				= "Grenade Launcher"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Heavy"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_shotty"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 60
SWEP.ViewModel				= "models/weapons/v_mgl_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_mgl_pg.mdl"

SWEP.AutoSwitchTo			= true 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 2

SWEP.HoldType 				= "shotgun"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.Chambering				= false
SWEP.SmokeWidth				= 100
SWEP.TwoHanded				= true
SWEP.AnimSprint				= true

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_mgl/fire.wav")
SWEP.Primary.ShellSound     = Sound("weapons/uh_mgl/insert.wav")
SWEP.Primary.ClipSize 		= 6
SWEP.Primary.Ammo 			= "UH_MGL" 
SWEP.Primary.DefaultClip 	= 6
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Delay 			= 0.8
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -3.6
SWEP.Primary.MaxRecoil		= -4.4
SWEP.Primary.ReloadTime		= 1

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

SWEP.SwayPosition = 3.2

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end 
	
	if SERVER then
		self:ShootGrenade(10000)
	end
	
	local sp = game.SinglePlayer()
	local iftp = IsFirstTimePredicted()
	
	local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)
	
	if sp or (CLIENT and iftp) then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetAttachment(self:GetMuzzle())
		util.Effect("uh_muzzle",fx)
		
		self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )
		
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
	end
	
	self.Owner:ViewPunch( Angle( recoil, 0, 0 ) )
	
	self:SendWeaponAnim( ACT_VM_IDLE )
	self:SendWeaponAnim( self:ShootAnimation() )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:MuzzleFlash()
	self:EmitSound( self.Primary.Sound, 110, 100, 1, CHAN_WEAPON )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	
	self.NextReload = CurTime() + 0.5
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