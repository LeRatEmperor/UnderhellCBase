AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/items/boxmrounds.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
end

function ENT:Use(ply, caller)
	ply:GiveAmmo(6, "UH_Arrow", false)
	ply:EmitSound("BaseCombatCharacter.AmmoPickup")
	self:Remove()
end