AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/pg_props/pg_weapons/pg_shotgun_ammo.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	ply:GiveAmmo(12, "buckshot", false)
	ply:EmitSound("UH.Ammo.Shotgun")
	self:Remove()
end