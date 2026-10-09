if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "7x Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
Color(255, 255, 255), "7x Zoom",
Color(255, 100, 100), "+25% Zoom time",
Color(255, 100, 100), "-5% ADS Movespeed",
}
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SCOPE"
-- ATTACHMENT.Base = "cod_scope_base" (CUH doesn't need this)
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_default"] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["scope_default"] = {
			["active"] = true
		}
	},
	["ScopeFov"] = 7,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
}


-- TFA attachment registration removed (CUH base handles this)
