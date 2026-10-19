if not ATTACHMENT then ATTACHMENT = {} end

-- Foregrip
-- Bodygroup 2 = 1
-- Slight recoil reduction
-- Overrides Animations table to use the foregrip_* sequence variants

ATTACHMENT.Name = "Grip"
ATTACHMENT.Icon = "bf3/grip.png"
ATTACHMENT.ShortName = "GRIP"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Foregrip",
    Color(100, 255, 100), "-10% vertical recoil",
    Color(255, 255, 255), "Uses foregrip_* animations",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [2] = 1 },
    ["Bodygroups_W"] = { [2] = 1 },

    ["Primary"] = {
        ["KickUp"] = function(wep, stat) return stat * 0.9 end,
        ["KickDown"] = function(wep, stat) return stat * 0.9 end,
    },

    -- Override each animation key individually to use the foregrip_* variant.
    -- Includes sprint_idle/in/out so sprinting also uses the foregrip anims
    -- (BF3 models don't have dedicated sprint sequences — they reuse idle/draw).
    ["Animations"] = {
        ["shoot"]        = "foregrip_fire",
        ["reload"]       = "foregrip_reload",
        ["reload_empty"] = "foregrip_reload_empty",
        ["idle"]         = "foregrip_idle",
        ["draw"]         = "foregrip_draw",
        ["sprint_idle"]  = "foregrip_idle",
        ["sprint_in"]    = "foregrip_draw",
        ["sprint_out"]   = "foregrip_draw",
    },
}

-- Drop the HoldType change ("smg" vs "ar2") from the original TFA attachment.
-- CUH doesn't have WeaponTable.HoldType support and the difference is cosmetic.
