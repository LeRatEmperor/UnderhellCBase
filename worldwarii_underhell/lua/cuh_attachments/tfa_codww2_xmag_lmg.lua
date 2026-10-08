if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = { Color(100, 255, 100), "Increased magazine size"}
ATTACHMENT.Icon = "entities/tfa_codww2_xmag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "XMAG"

ATTACHMENT.WeaponTable = {
--["EnableExtMags"] = true,
	["VElements"] = {
		["ext_clip"] = {
			["active"] = true
		},
		["clip_default"] = {
			["active"] = false
		}
	},
	["WElements"] = {
		["ext_clip"] = {
			["active"] = true
		},
		["clip_default"] = {
			["active"] = false
		}
	},
	["Primary"] = {
		["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_Ext or stat end,
	},
	["Animations"] = {
		["draw"] = {
			["type"] = 1, --Sequence or act
			["value"] = "draw_knife"
		},
		["draw_empty"] = {
			["type"] = 1, --Sequence or act
			["value"] = "draw_knife_empty"
		},
		["shoot1"] = {
			["type"] = 1, --Sequence or act
			["value"] = "fire_knife"
		},
		["shoot1_is"] = {
			["type"] = 1, --Sequence or act
			["value"] = "fire_knife_ads"
		},
		["shoot1_last"] = {
			["type"] = 1, --Sequence or act
			["value"] = "fire_knife_last"
		},
		["reload"] = {
			["type"] = 1, --Sequence or act
			["value"] = "reload_knife"
		},
		["reload_empty"] = {
			["type"] = 1, --Sequence or act
			["value"] = "reload_knife_empty"
		},
		["inspect"] = {
			["type"] = 1, --Sequence or act
			["value"] = "inspect_knife"
		},
		["inspect_empty"] = {
			["type"] = 1, --Sequence or act
			["value"] = "inspect_knife_empty"
		},
	},
	["SprintAnimation"] = {
		["in"] = function(wep,val)
			if not wep.SprintAnimation["in"] then return end
			val = table.Copy(val) or {}
			if wep.SprintAnimation_Tactical and wep.SprintAnimation_Tactical["in"] then
				val["type"] = wep.SprintAnimation_Tactical["in"].type
				if val.value then
					val["value"] = wep.SprintAnimation_Tactical["in"].value or "sprint_in"
				end
			else
				val["type"] = 1 --Sequence or act
				if val.value then
					val["value"] = "sprint_in"
				end
				if val.value_empty then
					val["value_empty"] = "sprint_in_empty"
				end
			end
			return val, true, false
		end,
		["loop"] = function(wep,val)
			if not wep.SprintAnimation.loop then return end
			val = table.Copy(val) or {}
			if wep.SprintAnimation_Tactical and wep.SprintAnimation_Tactical["loop"] then
				val["type"] = wep.SprintAnimation_Tactical["loop"].type
				if val.value then
					val["value"] = wep.SprintAnimation_Tactical["loop"].value or "sprint_loop"
				end
				if val.value_empty then
					val["value_empty"] = wep.SprintAnimation_Tactical["loop"].value_empty or "sprint_loop_empty"
				end
			else
				val["type"] = 1 --Sequence or act
				if val.value then
					val["value"] = "sprint_loop"
				end
				if val.value_empty then
					val["value_empty"] = "sprint_loop_empty"
				end
			end
			return val, true, false
		end,
		["out"] = function(wep,val)
			if not wep.SprintAnimation.out then return end
			val = table.Copy(val) or {}
			if wep.SprintAnimation_Grip and wep.SprintAnimation_Tactical["out"] then
				val["type"] = wep.SprintAnimation_Tactical["out"].type
				if val.value then
					val["value"] = wep.SprintAnimation_Tactical["out"].value or "sprint_out"
				end
				if val.value_empty then
					val["value_empty"] = wep.SprintAnimation_Tactical["out"].value_empty or "sprint_out_empty"
				end
			else
				val["type"] = 1 --Sequence or act
				if val.value then
					val["value"] = "sprint_out"
				end
				if val.value_empty then
					val["value_empty"] = "sprint_out_empty"
				end
			end
			return val, true, false
		end
	},
	["IronAnimation"] = {
		["shoot"] = function(wep,val)
			if not wep.IronAnimation.shoot then return end
			val = table.Copy(val) or {}
			val["type"] = 1 --Sequence or act
			if val.value then
				val["value"] = "fire_knife_ads"
			end
			if val.value_last then
				val["value_last"] = "fire_last"
			end
			return val, true, false
		end
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_TAC or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_TAC or val end,
	["VMPos"] = function( wep, val ) return wep.VMPos_TAC or val end,
	["VMAng"] = function( wep, val ) return wep.VMAng_TAC or val end,
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end
