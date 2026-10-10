if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Flashlight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "Switchable flashlight", TFA.AttachmentColors["+"], "Improves the visibility in dark areas", TFA.AttachmentColors["-"], "Exposes your current position" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_laser" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FL"

local id = "bo4_att_flashlight"
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
	
	["EnableFlashlight"] = true,
	["FlashlightAttachment"] = function(wep,stat) return wep.FlashlightModAttachment or 1 end,
	["FlashlightAttachmentWorld"] = function(wep,stat) return wep.FlashlightModAttachmentWorld or wep.FlashlightModAttachment or 1 end
}

function ATTACHMENT:Attach(wep)
	if not IsValid(wep) then return end
	
	if SERVER and IsValid(wep:GetOwner()) and wep:GetOwner():IsPlayer() then
		wep:GetOwner():Flashlight(false)
		
		if not wep:GetFlashlightEnabled() then
			wep:ToggleFlashlight(true)
		end
	end
end

function ATTACHMENT:Detach(wep)
	if not IsValid(wep) then return end
	
	if SERVER and IsValid(wep:GetOwner()) and wep:GetOwner():IsPlayer() then
		wep:GetOwner():Flashlight(false)
		
		if wep:GetFlashlightEnabled() then
			wep:ToggleFlashlight(false)
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
