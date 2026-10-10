if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Bayonet"
ATTACHMENT.ShortName = "BAYO"
ATTACHMENT.Icon = "entities/tfa_codww2_bayonet.png"
ATTACHMENT.Description = {
	Color(100, 255, 100), "+Melee Range",
	Color(100, 255, 100), "+Melee Damage",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["bayonet"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["bayonet"] = {
			["active"] = true,
		},
	},
	["MeleeRange"] = function(wep, val) return val + 20 end,
	["MeleeDamage"] = function(wep, val) return val + 25 end,
}

-- TFA attachment registration removed (CUH base handles this)
