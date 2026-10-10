if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Grenade Launcher"
ATTACHMENT.ShortName = "GL"
ATTACHMENT.Icon = "entities/tfa_codww2_rifle_grenade.png"
ATTACHMENT.Description = {
	Color(255, 255, 255), "Grenade Launcher",
	Color(255, 255, 255), "Press R to fire grenade",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["grenade_rail"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["grenade_rail"] = {
			["active"] = true,
		},
	},
}

-- TFA attachment registration removed (CUH base handles this)
