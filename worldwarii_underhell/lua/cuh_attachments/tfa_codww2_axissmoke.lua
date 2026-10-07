if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Axis Smoke Grenade"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
	TFA.AttachmentColors["="], "Swaps grenade model to Axis version",
}
ATTACHMENT.Icon = "entities/tfa_codww2_m18_smoke.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SMOKE"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ProjectileModel"] = "models/weapons/tfa_codww2/ger_smoke/ger_smoke_proj.mdl"
	},
}

ATTACHMENT.DInv2_GridSizeX = 1
ATTACHMENT.DInv2_GridSizeY = 1
ATTACHMENT.DInv2_Volume = nil
ATTACHMENT.DInv2_Mass = nil
ATTACHMENT.DInv2_StackSize = 64

function ATTACHMENT:Attach(wep)
	wep.ViewModelKitOld = wep.ViewModelKitOld or wep.ViewModel
	wep.WorldModelKitOld = wep.WorldModelKitOld or wep.WorldModel
	wep.ViewModel = wep:GetStat("ViewModel_Axis") or wep.ViewModel
	wep.WorldModel = wep:GetStat("WorldModel_Axis") or wep.WorldModel
	if IsValid(wep.OwnerViewModel) then
		wep.OwnerViewModel:SetModel(wep.ViewModel)
		timer.Simple(0, function()
			wep:SendViewModelAnim(ACT_VM_IDLE)
		end)
	end
	--wep.Offset.Pos.Up = wep.Offset.Pos.Up  + 3
	--wep.Offset.Ang.Forward = wep.Offset.Pos.Forward + 90
	wep:SetModel(wep.WorldModel)
	wep:SetNextIdleAnim(-1)
end

function ATTACHMENT:Detach(wep)
	--wep.Offset.Pos.Up = wep.Offset.Pos.Up - 3
	--wep.Offset.Ang.Forward = wep.Offset.Ang.Forward - 90
	if wep.ViewModelKitOld then
		wep.ViewModel = wep.ViewModelKitOld
		if IsValid(wep.OwnerViewModel) then
			wep.OwnerViewModel:SetModel(wep.ViewModel)
			timer.Simple(0, function()
				wep:SendViewModelAnim(ACT_VM_IDLE)
			end)
		end
		wep.ViewModelKitOld = nil
	end
	if wep.WorldModelKitOld then
		wep.WorldModel = wep.WorldModelKitOld
		wep:SetModel(wep.WorldModel)
		wep.ViewModelKitOld = nil
	end
	wep:SetNextIdleAnim(-1)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end