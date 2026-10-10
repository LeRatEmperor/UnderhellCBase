if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Foregrip"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "25% lower H-recoil", TFA.Attachments.Colors["+"], "25% lower V-recoil", TFA.Attachments.Colors["-"], "10% higher spread recovery" }
ATTACHMENT.Icon = "tfa_bo4/icon_atts/ui_icon_attachment_grip" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FGRIP"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["bo4_att_foregrip"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["bo4_att_foregrip"] = {
			["active"] = true
		}
	},
	["Primary"] = {
		["SpreadRecovery"] = function(wep,stat) return stat * 1.1 end,
		["KickUp"] = function(wep,stat) return stat * 0.75 end,
		["KickDown"] = function(wep,stat) return stat * 0.75 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.75 end,
	},
	
	["PumpAction"] = function(wep,val)
		val = table.Copy(val) or {}
		val["type"] = TFA.Enum.ANIMATION_SEQ
		if val.value then
			val["value"] = "grip_rechamber"
		end
		if val.value_is then
			val["value_is"] = "grip_rechamber_ads"
		end
		return val, true, false
	end,
	
	["IronAnimation"] = {
		["loop"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_idle"
		},

		["shoot"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_fire_ads"
		}
	},
	
	["SprintAnimation"] = {
		["in"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_sprint_in"
		},

		["loop"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_sprint_loop",
			["is_idle"] = true
		},
		
		["out"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_sprint_out"
		}
	},
	
	["Animations"] = {
		["draw"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_draw"
		},
		
		["shoot1"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_fire"
		},
		
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_reload"
		},
		
		["reload_empty"] = function(wep, val)
			if not wep.Animations.reload_empty then return end
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "grip_reload_empty"

			return val, true
		end,
		
		["reload_quick"] = function(wep, val)
			if not wep.Animations.reload_quick then return end
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "grip_reload_quick"

			return val, true
		end,
		
		["reload_empty_quick"] = function(wep, val)
			if not wep.Animations.reload_empty_quick then return end
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "grip_reload_empty_quick"

			return val, true
		end,
		
		["reload_ext"] = function(wep, val)
			if not wep.Animations.reload_ext then return end
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "grip_reload_ext"

			return val, true
		end,
		
		["reload_empty_ext"] = function(wep, val)
			if not wep.Animations.reload_empty_ext then return end
			val.type = TFA.Enum.ANIMATION_SEQ
			val.value = "grip_reload_empty_ext"

			return val, true
		end,
		
		["idle"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_idle"
		},
		
		["holster"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_holster"
		},
		
		["inspect"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_inspect"
		},
		
		["bash"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ,
			["value"] = "grip_melee"
		}
	}
}

function ATTACHMENT:Attach(wep)
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach(wep)
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
