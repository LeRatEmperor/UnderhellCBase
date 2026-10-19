if not ATTACHMENT then ATTACHMENT = {} end

-- ACOG 4x scope
-- Bodygroup 0 = 3

ATTACHMENT.Name = "ACOG"
ATTACHMENT.Icon = "bf3/acog.png"
ATTACHMENT.ShortName = "ACOG"

ATTACHMENT.Description = {
    Color(100, 255, 100), "4x magnification scope",
    Color(255, 100, 100), "Slower ADS",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [0] = 3 },
    ["Bodygroups_W"] = { [0] = 3 },

    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_ACOG or val end,

    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_ACOG or val * 0.95 end,
    },
}
