AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local boltMins, boltMaxs = Vector(-1, -1, -1), Vector(18, 1, 1)

function ENT:Initialize()
	self:SetModel("models/crossbow_arrow.mdl")
	
	self:PhysicsInitBox(boltMins, boltMaxs)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:SetMass(6)
		phys:EnableGravity(false)
	end
	
	self.m_hit = nil
end

function ENT:Think()
	if !self.m_hit then
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			local grav = physenv.GetGravity()
			phys:Wake()
			phys:ApplyForceCenter( grav*FrameTime() )
		end
	end
	
	self:NextThink(CurTime())
end

function ENT:PhysicsCollide(data,phys)
	if self.m_hit then return end
	
	phys:EnableGravity(true)
	
	self:SetNotSolid(true)
	
	self.m_hit = true
	
	local trace = {}
	trace.start = self:GetPos()
	trace.endpos = trace.start + ( ( data.HitPos - trace.start ) * 2 )
	trace.filter = {self, self.Owner}
	
	local tr = util.TraceLine( trace )
	
	local dir = (data.HitPos - trace.start):GetNormalized()
	
	self:SetPos( data.HitPos - dir*14 )
	
	if IsValid(tr.Entity) then
		if !tr.Entity:IsNPC() and !tr.Entity:IsPlayer() then
			self:SetParent( tr.Entity )
			self:EmitSound( "weapons/xbow/hit.wav", 75, math.random(95,105), 1, CHAN_USER_BASE )
			local Dmg = DamageInfo()
			Dmg:SetAttacker(self.Owner)
			Dmg:SetInflictor(self)
			Dmg:SetDamage(math.random(30, 40))
			Dmg:SetDamageForce( dir * 20 )
			Dmg:SetDamagePosition(tr.HitPos)
			Dmg:SetDamageType(DMG_GENERIC)
			tr.Entity:TakeDamageInfo(Dmg)
			
			SafeRemoveEntityDelayed( self, 10 )
		else
			local Dmg = DamageInfo()
			Dmg:SetAttacker(self.Owner)
			Dmg:SetInflictor(self)
			Dmg:SetDamage(math.random(90, 110))
			Dmg:SetDamageForce( dir * 20 )
			Dmg:SetDamagePosition(tr.HitPos)
			Dmg:SetDamageType(DMG_GENERIC)
			tr.Entity:TakeDamageInfo(Dmg)
			
			SafeRemoveEntity( self )
		end
	elseif !tr.HitSky then
		phys:EnableMotion(false)
		self:EmitSound( "weapons/xbow/hit.wav", 75, math.random(95,105), 1, CHAN_USER_BASE )
		
		local dot = dir:Dot( data.HitNormal )
		
		if dot < 0.3 then
			self:SetNotSolid(false)
			self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		end
		
		local pos1 = tr.HitPos + tr.HitNormal
		local pos2 = tr.HitPos - tr.HitNormal
		util.Decal("Impact.Concrete", pos1, pos2)
		
		SafeRemoveEntityDelayed( self, 10 )
	else
		SafeRemoveEntity( self )
	end
end