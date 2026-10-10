if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Recon"
-- ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "Magnification Optic", TFA.Attachments.Colors["-"], "10% higher zoom time" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_recon" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Recon"
ATTACHMENT.Base = "bo4_att_optic_base"

local id = "bo4_att_acog"
local reticle = "cw_codol/reticles/ret_default_acota31ncm_alpha2"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		[id] = {
			["active"] = true
		}
	},
	["WElements"] = {
		[id] = {
			["active"] = true
		}
	},
	
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_BO4ACOG or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_BO4ACOG or val, true end,
	["Secondary"] = {
		["IronFOV"] = 36
	},
	["EnableSights"] = true,
	["IronSightTime"] = function( wep, val ) return val * 1.10 end
}

local useStencils = true
local CachedMaterials = {}

function ATTACHMENT:Attach(wep)
	if not IsValid(wep) then return end
	
	if wep.SightBGs and wep.SightBGs.none then
		if not wep.Bodygroups_V then
			wep.Bodygroups_V = {}
		end
		
		wep.Bodygroups_V[wep.SightBGs.main] = wep.SightBGs.none
	end
	
	if wep.WMSightBGs and wep.WMSightBGs.none then
		if not wep.Bodygroups_W then
			wep.Bodygroups_W = {}
		end
		
		wep.Bodygroups_W[wep.WMSightBGs.main] = wep.WMSightBGs.none
	end
	
	if CLIENT then
		wep.RTCodeOld = wep.RTCodeOld or wep.RTCode
		wep.RTCode = nil
		
		wep.RTMaterialOverrideOld = wep.RTMaterialOverrideOld or wep.RTMaterialOverride
		wep.RTMaterialOverride = nil
		
		wep.ElementRenderFuncOld = wep.ElementRenderFuncOld or wep.ElementRenderFunc
		wep.ElementRenderFunc = nil
		
		wep.ElementRender[id] = function()
			-- local ply = LocalPlayer()
			if not wep:VMIV() then return end
			if not wep.VElements then return end
			if not wep.VElements[id] then return end
			
			if not IsValid(wep:GetOwner()) or not IsValid(wep.OwnerViewModel) then return end
		
			local parent = id
			local model = wep.VElements[parent].curmodel
			local retAtt = model:GetAttachment(model:LookupAttachment("reticle"))
			if not retAtt then return end
			
			local s = 1
			local retDist = retAtt.Pos:Distance(EyePos()) * 2
			local p = retAtt.Pos + retAtt.Ang:Forward() * retDist
			local retNorm = retAtt.Ang:Forward()
			local a = retAtt.Ang
			local retAng = retAtt.Ang.z + 180

			local rcGreen = Color(100, 255, 100, 255)
			local rcRed = Color(255, 75, 75, 255)
			local rcWhite = Color(255, 255, 255, 255)
			local material = reticle
			CachedMaterials[material] = CachedMaterials[material] or Material(material, "noclamp nocull smooth")
		
			if wep.VMRedraw then return end
			wep.VMRedraw = true
		
			local model
			if isstring(parent) and wep.VElements[parent] and wep.VElements[parent].curmodel then
				model = wep.VElements[parent].curmodel
			end
		
			if useStencils and IsValid(model) then
				render.UpdateScreenEffectTexture()
				render.ClearStencil()
				render.SetStencilEnable(true)
				render.SetStencilCompareFunction(STENCIL_ALWAYS)
				render.SetStencilPassOperation(STENCIL_REPLACE)
				render.SetStencilFailOperation(STENCIL_KEEP)
				render.SetStencilZFailOperation(STENCIL_REPLACE)
				render.SetStencilWriteMask(255)
				render.SetStencilTestMask(255)
				render.SetStencilReferenceValue(54)
		
				render.SetBlend(0)
					model:DrawModel() -- we "draw" only parent model (for models without any attachments just use rtcircle model with 0 alpha as parent)
				render.SetBlend(1)
		
				render.SetStencilCompareFunction(STENCIL_EQUAL)
			end
		
			render.OverrideDepthEnable(true, true)
		
			render.SetMaterial(CachedMaterials[material])

			-- cam.Start3D2D(p, a, s)
				render.CullMode(MATERIAL_CULLMODE_CW)
				render.DrawQuadEasy(p, retNorm, s, s, rcRed, retAng)
				render.CullMode(MATERIAL_CULLMODE_CCW)
			-- cam.End3D2D()

			render.OverrideDepthEnable(false, false)
		
			if useStencils and IsValid(model) then
				render.SetStencilEnable(false)
			end
		
			wep.VMRedraw = false
		end
	end
end

function ATTACHMENT:Detach(wep)
	if not IsValid(wep) then return end
	
	if wep.SightBGs and wep.SightBGs.ironsight then
		if not wep.Bodygroups_V then
			wep.Bodygroups_V = {}
		end
		
		wep.Bodygroups_V[wep.SightBGs.main] = wep.SightBGs.ironsight
	end

	if wep.WMSightBGs and wep.WMSightBGs.ironsight then
		if not wep.Bodygroups_W then
			wep.Bodygroups_W = {}
		end
		
		wep.Bodygroups_W[wep.WMSightBGs.main] = wep.WMSightBGs.ironsight
	end
	
	if CLIENT then
		if not wep.VElements then return end
		wep.ElementRenderFunc = wep.ElementRenderFuncOld
		wep.ElementRenderFuncOld = nil
		
		wep.ElementRender[id] = nil
		
		wep.RTMaterialOverride = wep.RTMaterialOverrideOld
		wep.RTMaterialOverrideOld = nil
		
		wep.RTCode = wep.RTCodeOld
		wep.RTCodeOld = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
