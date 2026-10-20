if not ATTACHMENT then ATTACHMENT = {} end

-- Muzzle compensator (not a suppressor)
-- Bodygroup 1 = 1
-- Slight recoil reduction

ATTACHMENT.Name = "Muzzle"
ATTACHMENT.Icon = "bf3/muzzle.png"
ATTACHMENT.ShortName = "MUZZLE"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Compensator",
    Color(255, 255, 255), "-10% vertical recoil",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [1] = 1 },
    ["Bodygroups_W"] = { [1] = 1 },

    ["Primary"] = {
        ["KickUp"] = function(wep, stat) return stat * 0.9 end,
        ["KickDown"] = function(wep, stat) return stat * 0.9 end,
    },
}
