if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tactical Knife"
ATTACHMENT.ShortName = "KNIFE"
ATTACHMENT.Icon = "entities/tfa_codww2_knife.png"
ATTACHMENT.Description = {
	Color(100, 255, 100), "+Melee Damage",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["tac_knife"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["tac_knife"] = {
			["active"] = true,
		},
	},
	["MeleeRange"] = function(wep, val) return val + 15 end,
	["MeleeDamage"] = function(wep, val) return val + 20 end,
}

-- TFA attachment registration removed (CUH base handles this)
