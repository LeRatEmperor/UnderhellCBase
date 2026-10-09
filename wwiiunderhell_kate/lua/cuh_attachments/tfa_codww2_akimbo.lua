
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Akimbo"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
	Color(100, 255, 100), "2x Clip Size",
	Color(100, 255, 100), "+3 Additional mags",
	Color(255, 100, 100), "Can't use other attachments",
}
ATTACHMENT.Icon = "entities/tfa_codww2_akimbo.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "DUAL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["clip_left"] = {
			["active"] = true
		},
		["grip_left"] = {
			["active"] = true
		},
		["receiver_left"] = {
			["active"] = true
		},
		["slide_left"] = {
			["active"] = true
		},
	},
	["WElements"] = { --ive tried 3 times, with 3 different methods, over 3 days, and ive come to the conclussion proper w_models with this method is impossible
		["gun_left"] = {
			["active"] = true
		},
	},

	["Akimbo"] = true,
	["Akimbo_Inverted"] = false,
	["AnimCycle"] = 1,
	["HoldType"] = "duel",
	["Primary"] = {
		["ClipSize"] = function( wep, stat) return wep.Primary.ClipSize_DW or stat end,
	},
	["data"] = {
		["ironsights"] = 0
	},

	["Animations"] = {
		["draw"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = 1
			if wep:Clip1() == 1 then
				val["value"] = "draw_midempty_dw"
			else
				val["value"] = "draw_dw"
			end
			return val, true, true
		end,
		["shoot1"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 2 then
				val["value"] = "fire_last_r"
			elseif wep:GetAnimCycle() == 0 and not wep.Akimbo_Inverted then
				val["value"] = "fire_r"
			else
				val["value"] = "fire_l"
			end
			return val, true, true
		end,
		["shoot1_last"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 2 then
				val["value"] = "fire_last_r"
			elseif wep:Clip1() == 1 then
				val["value"] = "fire_last_l"
			end
			return val, true, true
		end,
		["idle"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 1 then
				val["value"] = "idle_midempty"
			else
				val["value"] = "idle"
			end
			return val, true, true
		end,
		["holster"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = 1
			if wep:Clip1() == 1 then
				val["value"] = "holster_midempty_dw"
			else
				val["value"] = "holster_dw"
			end
			return val, true, true
		end,
		["reload"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = 1
			if wep:Clip1() == 1 then
				val["value"] = "reload_midempty_dw"
			else
				val["value"] = "reload_dw"
			end
			return val, true, true
		end,
		["inspect"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = 2
			if wep:Clip1() == 1 then
				val["value"] = ACT_RPG_FIDGET_UNLOADED
			else
				val["value"] = ACT_VM_FIDGET
			end
			return val, true, true
		end,
		["bash"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = 1
			if wep:Clip1() == 1 then
				val["value"] = "melee_midempty"
			else
				val["value"] = "melee"
			end
			return val, true, true
		end,
	},
	["SprintAnimation"] = {
		["in"] = function(wep,val)
			if not wep.SprintAnimation["in"] then return end
			val = table.Copy(val) or {}
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 1 then
				val["value"] = "sprint_in_midempty"
			else
				val["value"] = "sprint_in"
			end
			if val.value_empty then
				val["value_empty"] = "sprint_in_empty"
			end
			return val, true, true
		end,
		["loop"] = function(wep,val)
			if not wep.SprintAnimation.loop then return end
			val = table.Copy(val) or {}
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 1 then
				val["value"] = "sprint_loop_midempty"
			else
				val["value"] = "sprint_loop"
			end
			if val.value_empty then
				val["value_empty"] = "sprint_loop_empty"
			end
			return val, true, true
		end,
		["out"] = function(wep,val)
			if not wep.SprintAnimation.out then return end
			val = table.Copy(val) or {}
			val["type"] = 1 --Sequence or act
			if wep:Clip1() == 1 then
				val["value"] = "sprint_out_midempty"
			else
				val["value"] = "sprint_out"
			end
			if val.value_empty then
				val["value_empty"] = "sprint_out_empty"
			end
			return val, true, true
		end,
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_DW or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_DW or val end,
	["VMPos"] = function( wep, val ) return wep.VMPos_DW or val end,
	["VMAng"] = function( wep, val ) return wep.VMAng_DW or val end,
	["SafetyPos"] = function( wep, val ) return wep.SafetyPos_DW or val end,
	["SafetyAng"] = function( wep, val ) return wep.SafetyAng_DW or val end,
	["InspectPos"] = function( wep, val ) return wep.InspectPos_DW or val end,
	["InspectAng"] = function( wep, val ) return wep.InspectAng_DW or val end,
}


ATTACHMENT.Ammo = "pistol"

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
