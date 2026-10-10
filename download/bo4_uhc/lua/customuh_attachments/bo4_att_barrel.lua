if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Long Barrel"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "10% higher base accuracy", "10% higher scoped accuracy"}
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_longbarrel" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Barrel"

local id = "bo4_att_barrel"
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
	["Primary"] = {
		["Spread"] = function(wep,stat) return stat * 0.9 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.9 end
	},
}

function ATTACHMENT:Attach(wep)
	if not IsValid(wep) then return end
end

function ATTACHMENT:Detach(wep)
	if not IsValid(wep) then return end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
