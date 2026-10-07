if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tone Deaf"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = { Color(100, 255, 100), "Annoy everyone around you" }
ATTACHMENT.Icon = "entities/areallyfuckingbadidea.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "JOKE"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Sound"] = Sound("TFA_CODWW2_TONE.Bang"),
		["Sound_Silenced"] = Sound("TFA_CODWW2_TONE.Bang"),
	},
}

function ATTACHMENT:Attach(wep)
	wep.Silenced = true
	wep:SetSilenced(true)
end

function ATTACHMENT:Detach(wep)
	wep.Silenced = false
	wep:SetSilenced(false)
end


-- TFA attachment registration removed (CUH base handles this)
