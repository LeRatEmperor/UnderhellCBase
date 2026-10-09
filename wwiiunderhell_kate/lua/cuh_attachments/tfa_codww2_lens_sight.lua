if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Lens Sight"
ATTACHMENT.ShortName = "LENS"
ATTACHMENT.Icon = "entities/tfa_codww2_lens_sight.png"
ATTACHMENT.Description = {
	Color(255, 255, 255), "Lens Sight",
	Color(100, 255, 100), "+10% ADS Speed",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["lens_sight"] = {
			["active"] = true,
		},
		["sight_default"] = {
			["active"] = false,
		},
	},
	["WElements"] = {
		["lens_sight"] = {
			["active"] = true,
		},
		["sight_default"] = {
			["active"] = false,
		},
	},
	["IronSightTime"] = function(wep, val) return val * 0.9 end,
}

-- TFA attachment registration removed (CUH base handles this)
