if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Nydar Reflex"
ATTACHMENT.ShortName = "NYDAR"
ATTACHMENT.Icon = "entities/tfa_codww2_nydar.png"
ATTACHMENT.Description = {
	Color(255, 255, 255), "Reflex Sight",
	Color(100, 255, 100), "+10% ADS Speed",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["sight_nydar"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["sight_nydar"] = {
			["active"] = true,
		},
	},
	["IronSightTime"] = function(wep, val) return val * 0.9 end,
}

-- TFA attachment registration removed (CUH base handles this)
