AddCSLuaFile()

SWEP.PrintName 				= "RPG-7"
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
SWEP.ViewModel				= "models/weapons/v_uhg.mdl"
SWEP.WorldModel				= "models/weapons/w_uh_rpg_launcher.mdl"

SWEP.AutoSwitchTo			= true 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 4

SWEP.HoldType 				= "rpg"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.Chambering				= false
SWEP.SmokeWidth				= 100
SWEP.Sensitivity            = 1
SWEP.ZoomFov				= 0
SWEP.ScopeBlur				= true
SWEP.ScopeFov				= 8
SWEP.TwoHanded				= true
SWEP.AnimSprint				= true

if CLIENT then
	SWEP.ScopeTexture		= CreateMaterial("UH_RPG-7_Scope_8", "Unlittwotexture", {
		["$texture2"]		= "vgui/scope_lens_g36k",
		["$model"]			= "1"
	})
	SWEP.CrossMat = Material("scope/gdcw_acogcross")
end

SWEP.FireModes = {
	{
		name = "Scoped"
	},
	{
		name = "Unscoped",
		equip = function(ply, wep)
			wep.ScopeDisabled = true
			wep.IronSightsPos = Vector(-4.6, -2, 1.25)
			wep.IronSightsAng = Vector(0, 0, 0)
			wep.ScopeBlur = false
		end,
		holster = function(ply, wep)
			wep.ScopeDisabled = false
			wep.IronSightsPos = Vector(-5.92, -7.5, 0.75)
			wep.IronSightsAng = Vector(0, 0, -25)
			wep.ScopeBlur = true
		end,
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_rpg/rocketfire1.wav")
SWEP.Primary.ClipSize 		= 1
SWEP.Primary.Ammo 			= "rpg_round" 
SWEP.Primary.DefaultClip 	= 3
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Delay 			= 0.8
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -8.6
SWEP.Primary.MaxRecoil		= -11.4
SWEP.Primary.ReloadTime		= 1

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.IronSightsPos = Vector(-5.92, -7.5, 0.75)
SWEP.IronSightsAng = Vector(0, 0, -25)

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

SWEP.SoundChanger = {
	[")weapons/ar2/ar2_reload.wav"] = "weapons/uh_g36k/g36k_silencer_on.wav"
}

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload"] = "ACT_VM_RELOAD",
	["reload_empty"] = "ACT_VM_RELOAD",
}

SWEP.AnimSounds = {
    ["reload"] = {
        {time = 1.1,   sound = "weapons/uh_g36k/g36k_silencer_on.wav"},
    },
}

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end 
	
	if SERVER then
		local ent = ents.Create( "sent_rpg_rocket" )
		ent:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 30 - self.Owner:GetUp() * 10 + (self:GetUHBool("Zooming") and Vector(0,0,0) or self.Owner:GetRight() * 5) )
		ent:SetAngles( self.Owner:GetAngles() )
		ent:Spawn()
		ent:Activate()
		ent.Owner = self.Owner
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter( self.Owner:GetAimVector() * 1000 )
		end
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

function SWEP:CustomThink( ct )
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		if self:GetUHBool("Reloading") or self:Clip1() > 0 then
			vm:SetBodygroup(1, 0)
		else
			vm:SetBodygroup(1, 1)
		end
	end
end

local sin,cos,rad = math.sin,math.cos,math.rad
local function GeneratePolyCircle( x, y, radius, quality )
	local circle = {}
	local tmp = 0
	local s,c
	for i = 1, quality do
		tmp = rad(i*360)/quality
		s = sin(tmp)
		c = cos(tmp)
		circle[i] = {x = x + c*radius,y = y + s*radius,u = (c+1)/2,v = (s+1)/2}
	end
	return circle
end

function SWEP:PostDrawViewModel( vm )
	local bone_id = vm:LookupBone("rpg")
	if !bone_id then return end
	
	local pos,ang = vm:GetBonePosition(bone_id)
	local pos = pos - ang:Forward()*6.575 + ang:Up()*5.65 + ang:Right()*3.8
	
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 180)
	ang:RotateAroundAxis(ang:Up(), -25)
	
	cam.Start3D2D(pos, ang, 0.01)
		surface.SetMaterial(self.ScopeTexture)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawPoly( GeneratePolyCircle(0, 0, 50, 25) )
	cam.End3D2D()
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