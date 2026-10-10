include('shared.lua')

function ENT:Draw()
	self:DrawModel()
	
	--[[local mins,maxs = self:OBBMins(),self:OBBMaxs()
	
	render.DrawWireframeBox( self:GetPos(), self:GetAngles(), mins, maxs, Color(255,255,255) )]]
end