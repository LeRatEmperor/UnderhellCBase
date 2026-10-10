if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Akimbo"
ATTACHMENT.AttachSound = Sound("TFA_CODWW2_ATT.Equip")
ATTACHMENT.DetachSound = Sound("TFA_CODWW2_ATT.Unequip")
ATTACHMENT.Description = {
	Color(100, 255, 100), "2x Clip Size",
	Color(100, 255, 100), "+3 Additional mags",
	Color(255, 100, 100), "Can't use other attachments",
}
ATTACHMENT.Icon = "entities/tfa_codww2_akimbo.png"
ATTACHMENT.ShortName = "DUAL"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["clip_left"] = { ["active"] = true },
		["grip_left"] = { ["active"] = true },
		["receiver_left"] = { ["active"] = true },
		["slide_left"] = { ["active"] = true },
	},
	["WElements"] = {
		["gun_left"] = { ["active"] = true },
	},
	["Akimbo"] = true,
	["AnimCycle"] = 1,
	["HoldType"] = "duel",
	["Primary"] = {
		["ClipSize"] = function(wep, stat) return wep.Primary.ClipSize_DW or stat end,
	},
	["Animations"] = {
		["draw"] = "draw_dw",
		["shoot1"] = "fire_r",
		["shoot1_last"] = "fire_last_r",
		["idle"] = "idle_midempty",
		["holster"] = "holster_dw",
		["reload"] = "reload_dw",
		["reload_empty"] = "reload_empty_dw",
		["sprint_in"] = "sprint_in",
		["sprint_idle"] = "sprint_loop",
		["sprint_out"] = "sprint_out",
	},
}

ATTACHMENT.Ammo = "pistol"

function ATTACHMENT:Attach(wep) end
function ATTACHMENT:Detach(wep) end

-- CUH base handles registration
