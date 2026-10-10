if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "NVIR"
-- ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["="], "Identify enemies by detecting their increased heat signatures against the environment", TFA.Attachments.Colors["-"], "25% higher zoom time" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_thermal" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "NVIR"

local id = "bo4_att_thermal"
local reticle = "tfa_bo4/reticles/i_attach_t8_optic_thermal_reticle_c"

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
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_BO4Thermal or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_BO4Thermal or val, true end,
	["IronSightsSensitivity"] = function(wep, val)
		local res = val * wep:Get3DSensitivity()

		return res, false, true
	end,
	["Secondary"] = {
		["IronFOV"] = 72
	},
	["EnableSights"] = true,
	["IronSightTime"] = function( wep, val ) return val * 1.25 end,
	["RTScopeFOV"] = 15,
	["RTOpaque"] = -1,
	["RTMaterialOverride"] = -1
}

local useStencils = true
local CachedMaterials = {}

local flipcv
local cd = {}
local crosscol = Color(255, 255, 255, 255)
local rcBlue = Color(75, 153, 255, 255)
local cv_cc_r = GetConVar("cl_tfa_hud_crosshair_color_r")
local cv_cc_g = GetConVar("cl_tfa_hud_crosshair_color_g")
local cv_cc_b = GetConVar("cl_tfa_hud_crosshair_color_b")
local cv_cc_a = GetConVar("cl_tfa_hud_crosshair_color_a")
local defaultscrvec = {}
local IRFX_SETTING = 
{
	[ "$pp_colour_addr" ] 		= 0,
	[ "$pp_colour_addg" ] 		= 0.15,
	[ "$pp_colour_addb" ] 		= 0.8,
	[ "$pp_colour_brightness" ] = 0.03,
	[ "$pp_colour_contrast" ]	= 1,
	[ "$pp_colour_colour" ] 	= 0.5,
	[ "$pp_colour_mulr" ] 		= 0,
	[ "$pp_colour_mulg" ] 		= 0,
	[ "$pp_colour_mulb" ] 		= 0
}

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
	
	wep.RTMaterial = Material("!tfa_rtmaterial")

	if CLIENT then
		if not wep.VElements then return end
		if not wep.VElements[id] then return end
		
		wep.ElementRenderFuncOld = wep.ElementRenderFuncOld or wep.ElementRenderFunc
		wep.ElementRenderFunc = nil
	
		wep.RTMaterialOverrideOld = wep.RTMaterialOverrideOld or wep.RTMaterialOverride
		wep.RTMaterialOverride = nil
	
		wep.RTCodeOld = wep.RTCodeOld or wep.RTCode
		wep.RTCode = function(myself, rt, scrw, scrh)
			local legacy = myself.ScopeLegacyOrientation
			local rttw = ScrW()
			local rtth = ScrH()
			local ScopeReticle_Scale = {0.4, 0.4}
			local rcGreen = Color(100, 255, 100, 255)
			local rcRed = Color(255, 75, 75, 255)
			local rcWhite = Color(255, 255, 255, 255)
			local rcGold = Color(250, 255, 0, 255)
			local myshadowmask, myreticle, mydirt
			local RTScopeOffset, RTScopeScale
			
			if not myself:VMIV() then return end
			if not IsValid(myself:GetOwner()) or not IsValid(myself.OwnerViewModel) then return end

			if not myshadowmask then
				myshadowmask = surface.GetTextureID(myself.ScopeShadow or "vgui/scope_shadowmask_test")
			end
		
			if not myreticle then
				myreticle = Material(reticle)
			end
		
			if not mydirt then
				mydirt = Material(myself.ScopeDirt or "vgui/scope_dirt")
			end
		
			if not flipcv then
				flipcv = GetConVar("cl_tfa_viewmodel_flip")
			end
		
			local RTScopeAttachment = 1
			-- local vm = myself.OwnerViewModel
			local vm = myself.VElements[id].curmodel
			-- local retAtt = vm:GetAttachment(vm:LookupAttachment("reticle"))
			if not IsValid(vm) then return end

			if not myself.LastOwnerPos then
				myself.LastOwnerPos = myself:GetOwner():GetShootPos()
			end
			local mat = Material("models/loyalists/bo4/public/optic_thermal/i_attach_t8_optic_thermal_lens_rt")
			mat:SetTexture("$basetexture", myself.RTMaterial:GetTexture("$basetexture"))

			local owoff = myself:GetOwner():GetShootPos() - myself.LastOwnerPos
			myself.LastOwnerPos = myself:GetOwner():GetShootPos()

			local scrpos
			if RTScopeAttachment and RTScopeAttachment > 0 then
				if not vm then return end
				local att = vm:GetAttachment( RTScopeAttachment or 1 )
				if not att then return end
				if not att.Pos then return end
				if not att.Ang then return end
				local pos = att.Pos - owoff
				scrpos = pos:ToScreen()
			else
				myself.defaultscrvec.x = scrw / 2
				myself.defaultscrvec.y = scrh / 2
				scrpos = myself.defaultscrvec
			end
		
			scrpos.x = scrpos.x - scrw / 2 + myself.ScopeOverlayTransforms[1]
			scrpos.y = scrpos.y - scrh / 2 + myself.ScopeOverlayTransforms[2]
			scrpos.x = scrpos.x / scrw * 1920
			scrpos.y = scrpos.y / scrw * 1920
			scrpos.x = math.Clamp(scrpos.x, -1024, 1024)
			scrpos.y = math.Clamp(scrpos.y, -1024, 1024)
			--scrpos.x = scrpos.x * ( 2 - myself.IronSightsProgress*1 )
			--scrpos.y = scrpos.y * ( 2 - myself.IronSightsProgress*1 )
			scrpos.x = scrpos.x * myself.ScopeOverlayTransformMultiplier
			scrpos.y = scrpos.y * myself.ScopeOverlayTransformMultiplier
		
			if not myself.scrpos then
				myself.scrpos = scrpos
			end
		
			myself.scrpos.x = math.Approach(myself.scrpos.x, scrpos.x, (scrpos.x - myself.scrpos.x) * FrameTime() * 10)
			myself.scrpos.y = math.Approach(myself.scrpos.y, scrpos.y, (scrpos.y - myself.scrpos.y) * FrameTime() * 10)
			scrpos = myself.scrpos
			render.OverrideAlphaWriteEnable(true, true)
			surface.SetDrawColor(color_white)
			surface.DrawRect(-512, -512, 1024, 1024)
			render.OverrideAlphaWriteEnable(true, true)
			local ang = legacy and myself:GetOwner():EyeAngles() or vm:GetAngles()
			if RTScopeAttachment and RTScopeAttachment > 0 then
				local AngPos = vm:GetAttachment( RTScopeAttachment )
		
				if AngPos then
					ang = AngPos.Ang
		
					if flipcv:GetBool() then
						ang.y = -ang.y
					end
		
					-- for _, v in pairs(myself.ScopeAngleTransforms) do
					-- 	if v[1] == "P" then
					-- 		ang:RotateAroundAxis(ang:Right(), v[2])
					-- 	elseif v[1] == "Y" then
					-- 		ang:RotateAroundAxis(ang:Up(), v[2])
					-- 	elseif v[1] == "R" then
					-- 		ang:RotateAroundAxis(ang:Forward(), v[2])
					-- 	end
					-- end
				end
			end
		
			cd.angles = ang
			cd.origin = myself:GetOwner():GetShootPos()
		
			if not RTScopeOffset then
				RTScopeOffset = {0, 0}
			end
		
			if not RTScopeScale then
				RTScopeScale = {1, 1}
			end
		
			local rtow, rtoh = RTScopeOffset[1], RTScopeOffset[2]
			local rtw, rth = rttw * RTScopeScale[1], rtth * RTScopeScale[2]
			cd.x = 0
			cd.y = 0
			cd.w = rtw
			cd.h = rth
			cd.fov = myself:GetStat("RTScopeFOV")
			cd.drawviewmodel = false
			cd.drawhud = false

			render.Clear(0, 0, 0, 255, true, true)
			render.SetScissorRect(0 + rtow, 0 + rtoh, rtw + rtow, rth + rtoh, true)
			render.SuppressEngineLighting(true)
			render.SetLightingMode(1)
			render.PushFlashlightMode( true )
			render.PopFlashlightMode()
			if myself.IronSightsProgress > 0.01 then
				render.RenderView(cd)
				-- DrawColorModify(IRFX_SETTING)
				-- DrawBloom( 0.65, 2.5, 10, 10, 1, 1, 1, 1, 1 )

				cam.Start3D(cd.origin, cd.angles)
				-- cam.IgnoreZ(true)
				-- render.OverrideDepthEnable( true, true )
				-- DrawColorModify(IRFX_SETTING)
				render.OverrideColorWriteEnable( true, true )
				render.SetColorModulation( 1, 1, 1 )

				for _, ent in pairs(ents.GetAll()) do
					if ent:IsNPC() or ent:IsPlayer() or ent:IsVehicle() or ent:IsWeapon() then
						if not ent:IsEffectActive(EF_NODRAW) then
							render.SuppressEngineLighting(true)
							render.MaterialOverride( Material("tfa_bo4/util/white") )
							render.SetBlend( 1 )
							ent:DrawModel()
							render.SetBlend( 0 )
							render.MaterialOverride( nil )
							render.SuppressEngineLighting(false)
						end
					end
				end

				render.OverrideColorWriteEnable( false, false )
				-- render.OverrideDepthEnable( false, false )
				-- cam.IgnoreZ(false)
				cam.End3D()
			end

			render.PushFlashlightMode( false )
			render.PopFlashlightMode()
			render.SetLightingMode(0)
			render.SuppressEngineLighting(false)
			
			render.SetScissorRect(0, 0, rtw, rth, false)
			render.OverrideAlphaWriteEnable(false, true)
			
			cam.Start2D()
			
			draw.NoTexture()
			surface.SetTexture(myshadowmask)
			surface.SetDrawColor(color_white)
		
			-- if myself:Do3DScopeOverlay() then
				surface.DrawTexturedRect(scrpos.x + rtow - rtw / 2, scrpos.y + rtoh - rth / 2, rtw * 2, rth * 2)
			-- end

			if myself.ScopeReticule_CrossCol then
				crosscol.r = cv_cc_r:GetFloat()
				crosscol.g = cv_cc_g:GetFloat()
				crosscol.b = cv_cc_b:GetFloat()
				crosscol.a = cv_cc_a:GetFloat()
				surface.SetDrawColor(crosscol)
			end
			
			surface.SetDrawColor(rcGold)
			surface.SetMaterial(myreticle)
			local tmpborderw = rtw * (1 - ScopeReticle_Scale[1]) / 2
			local tmpborderh = rth * (1 - ScopeReticle_Scale[2]) / 2
			surface.DrawTexturedRect(rtow + tmpborderw, rtoh + tmpborderh, rtw - tmpborderw * 2, rth - tmpborderh * 2)
		
			surface.SetDrawColor(color_black)
			draw.NoTexture()
		
			-- if myself:Do3DScopeOverlay() then
				surface.DrawRect(scrpos.x - 2048 + rtow, -1024 + rtoh, 2048, 2048)
				surface.DrawRect(scrpos.x + rtw + rtow, -1024 + rtoh, 2048, 2048)
				surface.DrawRect(-1024 + rtow, scrpos.y - 2048 + rtoh, 2048, 2048)
				surface.DrawRect(-1024 + rtow, scrpos.y + rth + rtoh, 2048, 2048)
			-- end
		
			surface.SetDrawColor(ColorAlpha(rcBlue, 30))
			surface.DrawRect(0, 0, rtw, rth)

			surface.SetDrawColor(ColorAlpha(color_black, 255 - 255 * (math.Clamp(myself.IronSightsProgress - 0.75, 0, 0.25) * 4)))
			surface.DrawRect(-1024 + rtow, -1024 + rtoh, 2048, 2048)
			surface.SetMaterial(mydirt)
			surface.SetDrawColor(ColorAlpha(color_white, 128))
			surface.DrawTexturedRect(0, 0, rtw, rth)
			surface.SetDrawColor(ColorAlpha(color_white, 64))
			surface.DrawTexturedRectUV(rtow, rtoh, rtw, rth, 2, 0, 0, 2)
			cam.End2D()
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
		
		wep.RTMaterialOverride = wep.RTMaterialOverrideOld
		wep.RTMaterialOverrideOld = nil
		
		wep.RTCode = wep.RTCodeOld
		wep.RTCodeOld = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end