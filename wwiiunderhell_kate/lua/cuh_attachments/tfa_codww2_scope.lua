if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "7x Scope"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
	Color(255, 255, 255), "7x Zoom",
	Color(255, 100, 100), "+25% Zoom time",
	Color(255, 100, 100), "-5% ADS Movespeed",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_default"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_default"] = {
			["active"] = true,
		},
	},
	["ScopeFov"] = 7,
	["ZoomFov"] = 15,
	["IronSightTime"] = function(wep, val) return val * 1.25 end,
	["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}

-- TFA attachment registration removed (CUH base handles this)
