if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "7x Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
TFA.AttachmentColors["="], "7x Zoom",
TFA.AttachmentColors["-"], "+25% Zoom time",
TFA.AttachmentColors["-"], "-5% ADS Movespeed",
}
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Base = "cod_scope_base"
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
	["RTRedrawViewModel_7X"] = false,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["Secondary"] = {
		["ScopeZoom"] = function( wep, val ) return 7 end,
	},
	["COD_SightVElement"] = "scope_default",
	["COD_SightSuffix"] = "7X"
}
ATTACHMENT.Reticule = Material("models/weapons/tfa_codww2/kar98k/mtl_s2_ret_ger_k98_01")
ATTACHMENT.ReticuleScale = 1

ATTACHMENT.DInv2_GridSizeX = 1
ATTACHMENT.DInv2_GridSizeY = 1
ATTACHMENT.DInv2_Volume = nil
ATTACHMENT.DInv2_Mass = nil
ATTACHMENT.DInv2_StackSize = 1

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end