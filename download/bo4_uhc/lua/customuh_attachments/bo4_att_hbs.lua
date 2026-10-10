if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Heartbeat Sensor"
-- ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Tracks the movements of nearby targets" }
ATTACHMENT.Icon = "cw_codol/icon_atts/codol_att_hbs" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HBS"

local id = "bo4_att_hbs"
local reticle = "cw_codol/reticles/dualoptic_0"

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
}

local useStencils = true
local CachedMaterials = {}

function ATTACHMENT:Attach(wep)
	if CLIENT then
		-- if not wep.VElements then return end
		-- if not retAtt then return end

		wep.ElementRender[id] = function()
			-- local ply = LocalPlayer()
			if not wep:VMIV() then return end
			if not wep.VElements then return end
			if not wep.VElements[id] then return end
			
			if not IsValid(wep:GetOwner()) or not IsValid(wep.OwnerViewModel) then return end
		
			local natural = 
			{
				["npc_crow"] = true,
				["npc_pigeon"] = true,
				["npc_seagull"] = true,
				["npc_gman"] = true,
			}
			
			local friendly = 
			{
				["npc_monk"] = true,
				["npc_citizen"] = true,
				["npc_alyx"] = true,
				["npc_barney"] = true,
				["npc_kleiner"] = true,
				["npc_mossman"] = true,
				["npc_eli"] = true,
				["npc_dog"] = true,
				["npc_magnusson"] = true,
				["npc_vortigaunt"] = true,
			}
			
			local undefined = 
			{
				["npc_dog"] = true,
				["npc_turret"] = true,
			}

			local parent = id
			local model
			if isstring(parent) and wep.VElements[parent] and wep.VElements[parent].curmodel then
				model = wep.VElements[parent].curmodel
			end
			local retAtt = model:GetAttachment(model:LookupAttachment("tag_motion_tracker"))
			if not retAtt then return end
			
			local retSize = 2
			local retDist = -0.2
			local retPos = retAtt.Pos + retAtt.Ang:Up() * -1 + retAtt.Ang:Forward() * retDist
			local retNorm = retAtt.Ang:Forward()
			local retAng = retAtt.Ang.z + 180

			local rcGreen = Color(100, 255, 100, 255)
			local rcRed = Color(255, 75, 75, 255)
			local rcWhite = Color(255, 255, 255, 255)
			local rc

			local material = Material(reticle)
		
			if IsValid(model) then
				-- render.OverrideDepthEnable(true, true)
				render.SetMaterial(material)
	
				for k, v in pairs(ents.GetAll()) do
					if (v:IsNPC() or (v:IsPlayer() and v != wep.Owner)) and not undefined[v:GetClass()] then
						local distsqr = math.Round(wep.Owner:GetPos():DistToSqr(v:GetPos()) / 2500, 2)
						if distsqr <= 150 then
							local dist = math.sqrt(distsqr)
							local aimPos = wep.Owner:GetAimVector()
							local entPos = v:GetPos() - wep.Owner:GetPos()
							aimPos.z = 0
							entPos.z = 0
							local dot = aimPos:GetNormalized():Dot(entPos:GetNormalized())
							local dotcos = math.cos(math.acos(dot))
							local dotsin = math.sin(math.acos(dot))
							local dotcross = aimPos:GetNormalized():Cross(entPos:GetNormalized())
							-- wtf
							if dotcross.z <= 0 then
								dotsin = math.sin(math.acos(dot))
							else
								dotsin = math.sin(math.acos(dot)) * -1
							end
							
							local teammate
							if v:IsPlayer() then
								local entteam = team.GetName(v:Team())
								local ownerteam = team.GetName(wep.Owner:Team())
								if (entteam == ownerteam) then
									teammate = true
								else
									teammate = false
								end
							end
							
							if friendly[v:GetClass()] or teammate then
								rc = rcGreen
							elseif natural[v:GetClass()] then
								rc = rcWhite
							else
								rc = rcRed
							end
							
							local curX = math.Clamp( dist * dotsin / 4, -1.3, 1.3 )
							local curY = math.Clamp( dist * dotcos / 4, 0, 1.9 )
							local curZ = retPos.z
							local deltaPos = retPos + retAtt.Ang:Right() * curX + retAtt.Ang:Up() * curY
							-- cam.IgnoreZ(true)
								render.CullMode(MATERIAL_CULLMODE_CW)
									render.DrawQuadEasy(deltaPos, retNorm, retSize, retSize, rc, retAng)
								render.CullMode(MATERIAL_CULLMODE_CCW)
							-- cam.IgnoreZ(false)
						end
					end
				end
	
				-- render.OverrideDepthEnable(false, false)
			end
		end
	end
end

function ATTACHMENT:Detach(wep)
	if CLIENT then
		if not wep.VElements then return end
		wep.ElementRender[id] = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end