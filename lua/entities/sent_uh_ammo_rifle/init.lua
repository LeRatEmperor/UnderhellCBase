AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_weapons/pg_rifle_ammo.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	ply:GiveAmmo(50, "ar2", false)
	ply:EmitSound("UH.Ammo.Rifle")
	self:Remove()
end