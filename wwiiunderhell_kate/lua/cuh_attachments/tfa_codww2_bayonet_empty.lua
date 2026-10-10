if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Bayonet (Empty)"
ATTACHMENT.ShortName = "BAYO"
ATTACHMENT.Icon = "entities/tfa_codww2_bayonet.png"
ATTACHMENT.Description = {
	Color(100, 255, 100), "+Melee Range",
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
	-- Empty-mag variant: overrides use _empty animation sequences
	["Animations"] = {
		["shoot1_last"] = "fire_bayonet_empty",
		["reload_empty"] = "reload_bayonet_empty",
		["inspect_empty"] = "inspect_bayonet_empty",
	},
}

-- TFA attachment registration removed (CUH base handles this)
