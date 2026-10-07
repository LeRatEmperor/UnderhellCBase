
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Akimbo"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "2x Clip Size",
	TFA.AttachmentColors["+"], "+3 Additional mags",
	TFA.AttachmentColors["-"], "Can't use other attachments",
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
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:Clip1() == 1 then
				val["value"] = "draw_midempty_dw"
			else
				val["value"] = "draw_dw"
			end
			return val, true, true
		end,
		["shoot1"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
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
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:Clip1() == 2 then
				val["value"] = "fire_last_r"
			elseif wep:Clip1() == 1 then
				val["value"] = "fire_last_l"
			end
			return val, true, true
		end,
		["idle"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
			if wep:Clip1() == 1 then
				val["value"] = "idle_midempty"
			else
				val["value"] = "idle"
			end
			return val, true, true
		end,
		["holster"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:Clip1() == 1 then
				val["value"] = "holster_midempty_dw"
			else
				val["value"] = "holster_dw"
			end
			return val, true, true
		end,
		["reload"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
			if wep:Clip1() == 1 then
				val["value"] = "reload_midempty_dw"
			else
				val["value"] = "reload_dw"
			end
			return val, true, true
		end,
		["inspect"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_ACT
			if wep:Clip1() == 1 then
				val["value"] = ACT_RPG_FIDGET_UNLOADED
			else
				val["value"] = ACT_VM_FIDGET
			end
			return val, true, true
		end,
		["bash"] = function(wep, val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ
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
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
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
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
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
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
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

ATTACHMENT.DInv2_GridSizeX = 1
ATTACHMENT.DInv2_GridSizeY = 1
ATTACHMENT.DInv2_Volume = nil
ATTACHMENT.DInv2_Mass = nil
ATTACHMENT.DInv2_StackSize = 1

ATTACHMENT.Ammo = "pistol"

function ATTACHMENT:Attach(wep)
	wep.StatCache_Blacklist["Akimbo"] = true
	wep.StatCache_Blacklist["Akimbo_Inverted"] = true
	wep.StatCache_Blacklist["AnimCycle"] = true
	
	self.DefaultClip = (wep:GetStat("Primary.ClipSize_DW") * 3)
	
	if SERVER and not wep.HasBeenGivenDWAmmo and (IsValid(wep:GetOwner()) and wep:GetOwner().GiveAmmo) then
		wep:SetClip1( math.Clamp( self.DefaultClip,0,1 ) )
		wep:GetOwner():GiveAmmo( math.max( self.DefaultClip - 1, 0 ), self.Ammo )
		wep:EmitSound( wep:GetStat("Primary.PickupSound") )
		wep.HasBeenGivenDWAmmo = 1
	end

	wep:Unload()
	
	wep.ViewModelKitOld = wep.ViewModelKitOld or wep.ViewModel
	wep.WorldModelKitOld = wep.WorldModelKitOld or wep.WorldModel
	wep.ViewModel = wep:GetStat("ViewModel_DW") or wep.ViewModel
	wep.WorldModel = wep:GetStat("WorldModel_DW") or wep.WorldModel
	if IsValid(wep.OwnerViewModel) then
		wep.OwnerViewModel:SetModel(wep.ViewModel)
	end
	wep:SetModel(wep.WorldModel)
	
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
	wep:SetNextIdleAnim(-1)
end

function ATTACHMENT:Detach(wep)
	wep.StatCache_Blacklist["Akimbo"] = false
	wep.StatCache_Blacklist["Akimbo_Inverted"] = false
	wep.StatCache_Blacklist["AnimCycle"] = false

	wep:Unload()
	
	if wep.ViewModelKitOld then
		wep.ViewModel = wep.ViewModelKitOld
		if IsValid(wep.OwnerViewModel) then
			wep.OwnerViewModel:SetModel(wep.ViewModel)
		end
		wep.ViewModelKitOld = nil
	end
	if wep.WorldModelKitOld then
		wep.WorldModel = wep.WorldModelKitOld
		wep:SetModel(wep.WorldModel)
		wep.ViewModelKitOld = nil
	end
	
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
	wep:SetNextIdleAnim(-1)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
