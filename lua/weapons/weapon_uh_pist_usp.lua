AddCSLuaFile()

SWEP.PrintName 				= "Socom USP"
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
SWEP.ViewModel				= "models/weapons/v_pist_socom_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_socom_pg.mdl"

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
SWEP.SmokeWidth				= 55
SWEP.HasSilencer			= true
SWEP.AnimSprint				= true

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	},
	{
		name = "Laser-Sight",
		equip = function(ply,wep)
			wep:SetNWBool("Laser", true)
		end,
		holster = function(ply,wep)
			wep:SetNWBool("Laser", false)
		end
	}
}

SWEP.ReloadTable = {
	{delay = 0.1, sound = Sound("weapons/uh_usp/usp_slideback.wav")},
	{delay = 0.3, sound = Sound("weapons/uh_usp/usp_clipout.wav")},
	{delay = 1, sound = Sound("weapons/uh_usp/usp_clipin.wav")},
	{delay = 1.4, sound = Sound("weapons/uh_usp/usp_slideforward.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_usp/usp_fire.wav")
SWEP.Primary.SilSound		= Sound("weapons/uh_usp/usp_fire_silenced.wav")
SWEP.Primary.ClipSize 		= 12
SWEP.Primary.Ammo 			= "pistol"
SWEP.Primary.DefaultClip 	= 12
SWEP.Primary.MinDamage      = 21
SWEP.Primary.MaxDamage      = 25
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 7
SWEP.Primary.Spread 		= 0.07
SWEP.Primary.Delay 			= 0.16
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -1.1
SWEP.Primary.MaxRecoil		= -1.4

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.04, -4.64, 1.799)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload_sil"] = "ACT_VM_RELOAD",
	["reload_empty"] = "ACT_VM_RELOAD",
	["reload_empty_sil"] = "ACT_VM_RELOAD",
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

if SERVER then return end

local laser = Material("effects/laser1")
local sprite = Material("sprites/glow04_noz")

function SWEP:ViewModelDrawn(vm)
	if !self:GetNWBool("Laser") then return end
	local boneid = vm:LookupBone("SMDImport")
	local pos,ang = vm:GetBonePosition( boneid )
	if pos and ang then
		ang:RotateAroundAxis(ang:Up(), 90)
		pos = pos + ang:Forward()*4
		
		local tr = self.Owner:GetEyeTrace()
		
		if !self:GetNWBool("Zooming") then
			tr = util.TraceLine({
				start = pos,
				endpos = pos + ang:Forward()*16000,
				filter = {self.Owner, self}
			})
		end
		
		render.SetMaterial(laser)
		render.DrawBeam(pos, tr.HitPos, 1, 0, 1, Color(255, 0, 0))
		render.SetMaterial(sprite)
		render.DrawSprite(tr.HitPos, 3, 3, Color(255, 0, 0))
	end
end

function SWEP:DrawWorldModel()
	self:DrawModel()
	
	if !self:GetNWBool("Laser") then return end
	local att = self:GetAttachment( self:GetMuzzle() )
	if att then
		local pos = att.Pos
		local ang = att.Ang
		
		ang:RotateAroundAxis(ang:Up(), 2)
		pos = pos + ang:Right()*2.5 - ang:Forward()*0.4
		
		local tr = self.Owner:GetEyeTrace()
		
		if !self:GetNWBool("Zooming") then
			tr = util.TraceLine({
				start = pos,
				endpos = pos + ang:Forward()*16000,
				filter = {self.Owner, self}
			})
		end
		
		render.SetMaterial(laser)
		render.DrawBeam(pos, tr.HitPos, 3, 0, 1, Color(255, 0, 0))
		render.SetMaterial(sprite)
		render.DrawSprite(pos, 6, 6, Color(255, 0, 0))
		render.DrawSprite(tr.HitPos, 4, 4, Color(255, 0, 0))
	end
end