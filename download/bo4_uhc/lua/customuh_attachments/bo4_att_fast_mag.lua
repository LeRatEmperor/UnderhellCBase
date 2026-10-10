if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Fast Mags"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Reload faster" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_fastmags" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Fast Mags"

ATTACHMENT.WeaponTable = {
	["EnableFastMags"] = true,

	["VElements"] = {
		["bo4_att_fast_mag"] = {
			["active"] = true
		}
	},
	
	["WElements"] = {
		["bo4_att_fast_mag"] = {
			["active"] = true
		}
	}
}

function ATTACHMENT:Attach(wep)
	if not IsValid(wep) then return end

	if wep.MagBGs and wep.MagBGs.fast_mag then
		if not wep.Bodygroups_V then
			wep.Bodygroups_V = {}
		end
		
		wep.Bodygroups_V[wep.MagBGs.main] = wep.MagBGs.fast_mag
	end
	
	if wep.WMMagBGs and wep.WMMagBGs.fast_mag then
		if not wep.Bodygroups_W then
			wep.Bodygroups_W = {}
		end
		
		wep.Bodygroups_W[wep.WMMagBGs.main] = wep.WMMagBGs.fast_mag
	end
	
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	if not IsValid(wep) then return end

	if wep.MagBGs and wep.MagBGs.regular then
		if not wep.Bodygroups_V then
			wep.Bodygroups_V = {}
		end
		
		wep.Bodygroups_V[wep.MagBGs.main] = wep.MagBGs.regular
	end
	
	if wep.WMMagBGs and wep.WMMagBGs.regular then
		if not wep.Bodygroups_W then
			wep.Bodygroups_W = {}
		end
		
		wep.Bodygroups_W[wep.WMMagBGs.main] = wep.WMMagBGs.regular
	end
	
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
