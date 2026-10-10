if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Rapid Fire"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
	Color(100, 255, 100), "Increased RPM",
}
ATTACHMENT.Icon = "entities/tfa_codww2_rapidfire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RPM"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["RPM_Burst"] = function( wep, stat) return wep.Primary.RPM_Burst_Rapid or stat end,
		["RPM_Displayed"] = function( wep, stat) return wep.Primary.RPM_Displayed_Rapid or stat end,
	}
}


-- TFA attachment registration removed (CUH base handles this)
