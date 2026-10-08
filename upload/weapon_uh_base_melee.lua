AddCSLuaFile()

SWEP.PrintName 				= "Underhell Melee Base"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_axe_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_axe_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 0
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "melee"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.ViewModelFlip			= false

SWEP.Primary.SwingSound		= Sound( "weapons/axe/axe_swing"..math.random(1,2)..".wav" )
SWEP.Primary.HitSound		= Sound( "weapons/axe/axe_hitbod"..math.random(1,3)..".wav" )
SWEP.Primary.HitWorldSound	= Sound( "weapons/axe/axe_hitworld"..math.random(1,2)..".wav" )
SWEP.Primary.MinDamage		= 45
SWEP.Primary.MaxDamage		= 65
SWEP.Primary.Force			= 2000
SWEP.Primary.HurtTime		= 0.25
SWEP.Primary.Delay			= 0.8
SWEP.Primary.Recoil			= Angle(0,8,0)
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""
SWEP.Primary.Anim			= ACT_VM_MISSCENTER
SWEP.Primary.DamageType		= DMG_SLASH

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""

SWEP.SwayScale 	= 0
SWEP.BobScale 	= 0

SWEP.SwayPosition = 2


SWEP.IronSightsPos = Vector(4.8, -8.233, 2.789)
SWEP.IronSightsAng = Vector(0, 45.777, 9.289)


SWEP.Inspection = {
	{
		pos = Vector(4.8, -8.233, 2.789),
		ang = Angle(0, 45.777, 9.289)
	},
	{
		pos = Vector(6.4, -14.825, -1.05),
		ang = Angle(47.076, 46.24, 45.243)
	},
}


function SWEP:Initialize()
	util.PrecacheSound(self.Primary.SwingSound)
	util.PrecacheSound(self.Primary.HitSound)
	util.PrecacheSound(self.Primary.HitWorldSound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
	self:SetWeaponHoldType( self.HoldType )
	self:SetHoldType( self.HoldType )
    self:SetNWInt("FireMode", 1)
end

function SWEP:Think()
	local ct = CurTime()
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		self:HandleBones( vm, ct )
		self:HandleHands( vm )
	end
	
    self:HandleRunning( ct )
	
	if self.CustomThink then
		self:CustomThink( ct )
	end
end

function SWEP:Reload()
	return false
end

function SWEP:PrimaryAttack()
	if self:GetNWFloat("DeployTime") > CurTime() then return end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	
	self:SendWeaponAnim( self.Primary.Anim )
	
	local sp = game.SinglePlayer()
	local iftp = IsFirstTimePredicted()
	
	if (sp or CLIENT and iftp) and GetConVar("uh_sv_voices"):GetBool() then
		self.Owner:EmitSound( "uh/voice/melee/melee"..math.random(1,8)..".wav", 100, math.random(80, 110), 1, CHAN_USER_BASE )
	end
	
	self:EmitSound( self.Primary.SwingSound, 100, math.random(90,110), 1, CHAN_WEAPON )
	
	self.Owner:ViewPunch( self.Primary.Recoil )
	
	if SERVER or iftp then
		timer.Simple(self.Primary.HurtTime, function()
			if ( !IsValid( self ) or !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self ) then return end
			
			local pos = self.Owner:GetShootPos()
			local aim = self.Owner:GetAimVector() * 64
			
			local tr = {}
			tr.start = pos
			tr.endpos = pos + aim
			tr.filter = self.Owner
			tr.mask = MASK_SHOT_HULL
			tr.mins = Vector(-16,-16,-16)
			tr.maxs = Vector(16,16,16)
			
			local trace = util.TraceHull( tr )
			
			if trace.Hit then
				if IsValid(trace.Entity) then
					if SERVER then
						local Dmg = DamageInfo()
						Dmg:SetAttacker(self.Owner)
						Dmg:SetInflictor(self)
						Dmg:SetDamage(math.random(self.Primary.MinDamage, self.Primary.MaxDamage))
						Dmg:SetDamageForce( self.Owner:GetAimVector() * self.Primary.Force )
						Dmg:SetDamagePosition(trace.HitPos)
						Dmg:SetDamageType(self.Primary.DamageType)
						trace.Entity:TakeDamageInfo(Dmg)
					end
					
					if sp or (CLIENT and iftp) then
						if trace.Entity:IsNPC() or trace.Entity:IsPlayer() or type(trace.Entity) == "NextBot" then
							self:EmitSound( self.Primary.HitSound, 100, math.random(100,120), 1, CHAN_WEAPON )
							
							local ed = EffectData()
							ed:SetOrigin( trace.HitPos )
							util.Effect( "BloodImpact", ed, true, true )
						else
							self:EmitSound( self.Primary.HitWorldSound, 100, math.random(100,120), 1, CHAN_WEAPON )
						end
					end
				elseif sp or (CLIENT and iftp) then
					self:EmitSound( self.Primary.HitWorldSound, 100, math.random(100,120), 1, CHAN_WEAPON )
					
					local mat = trace.MatType
					
					if mat == MAT_CONCRETE or mat == MAT_METAL or mat == MAT_VENT or mat == MAT_TILE or mat == MAT_GRATE then
						local fx = EffectData()
						fx:SetOrigin(trace.HitPos)
						fx:SetScale(1)
						util.Effect("uh_hitworld",fx)
					end
				end
			end
		end)
	end
end

function SWEP:SecondaryAttack()
	return false
end

if SERVER then return end

local h_use = 0

function SWEP:DrawHUD()
	if !GetConVar("cl_drawhud"):GetBool() or self:GetNWFloat("DeployTime") > CurTime() then return end
	
	local pos = {x = ScrW()/2, y = ScrH()/2}
	local drawply = LocalPlayer():ShouldDrawLocalPlayer()
	
	if drawply then
		pos = self.Owner:GetEyeTrace().HitPos:ToScreen()
	end
	
	if GetConVar("uh_sv_grenades"):GetBool() then
		local grenades = self.Owner:GetAmmoCount("UH_Grenade")
		if grenades > 0 then
			draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2 + 1, ScrH() * 0.8 + 1, Color(0,0,0,255), TEXT_ALIGN_CENTER)
			draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2, ScrH() * 0.8, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2 + 1, ScrH() * 0.8 + 23, Color(0,0,0,255), TEXT_ALIGN_CENTER)
			draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2, ScrH() * 0.8 + 22, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		end
	end
end