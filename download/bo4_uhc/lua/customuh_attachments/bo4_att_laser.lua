if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Laser Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "20% lower base spread", "10% faster spread recovery", TFA.AttachmentColors["-"], "Exposes your current position" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_laser" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LAM"

local id = "bo4_att_laser"
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
		["Spread"] = function(wep,stat) return stat * 0.8 end,
		["SpreadRecovery"] = function(wep,stat) return stat * 1.1 end
	},
	["EnableLaser"] = true,
	["LaserSightAttachment"] = function(wep,stat) return wep.LaserSightModAttachment or 1 end,
	["LaserSightAttachmentWorld"] = function(wep,stat) return wep.LaserSightModAttachmentWorld or wep.LaserSightModAttachment or 1 end
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
