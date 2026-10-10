if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Base Attachment"
ATTACHMENT.ShortName = nil --Abbreviation, 5 chars or less please
ATTACHMENT.Description = {} --TFA.Attachments.Colors["+"], "Does something good", TFA.Attachments.Colors["-"], "Does something bad" }
ATTACHMENT.Icon = nil --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.WeaponTable = {} --put replacements for your SWEP talbe in here e.g. ["Primary"] = {}

function ATTACHMENT:CanAttach(wep)
	return true --can be overridden per-attachment
end

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

if matproxy then 
	matproxy.Add({
		name = "TFA_BO4_IronsightVectorResult",
		init = function(self, mat, values)
			self.resultVar = values.resultvar
			self.ResultDefault = Vector(values.resultdefault) -- original overreflective value
			self.ResultZoomed = Vector(values.resultzoomed) * .25
		end,
		bind = function(self, mat, ent)
			local ply = LocalPlayer()
			if IsValid(ply) then
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and wep.CLIronSightsProgress then
					local newVector = LerpVector(math.Clamp(wep.CLIronSightsProgress, 0, 1), self.ResultDefault, self.ResultZoomed)
					mat:SetVector(self.resultVar, newVector)
				end
			end
		end
	})
end