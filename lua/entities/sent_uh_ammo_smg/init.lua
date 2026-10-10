AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel(math.random(1,2) == 1 and "models/pg_props/pg_weapons/pg_smg_ammo.mdl" or "models/pg_props/pg_weapons/pg_smg_ammo_closed.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	ply:GiveAmmo(50, "smg1", false)
	ply:EmitSound("UH.Ammo.SMG")
	self:Remove()
end