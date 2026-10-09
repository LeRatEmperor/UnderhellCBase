if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "ACOG 4x"
ATTACHMENT.ShortName = "4X"
ATTACHMENT.Icon = "entities/tfa_codww2_4x.png"
ATTACHMENT.Description = {
	Color(255, 255, 255), "4x Zoom",
	Color(255, 100, 100), "+15% Zoom time",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_acog"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_acog"] = {
			["active"] = true,
		},
	},
	["ScopeFov"] = 15,
	["ZoomFov"] = 25,
	["IronSightTime"] = function(wep, val) return val * 1.15 end,
	["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}

-- TFA attachment registration removed (CUH base handles this)
