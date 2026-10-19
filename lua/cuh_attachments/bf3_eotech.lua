if not ATTACHMENT then ATTACHMENT = {} end

-- Eotech holographic sight
-- Bodygroup 0 = 4

ATTACHMENT.Name = "Eotech"
ATTACHMENT.Icon = "bf3/eotech.png"
ATTACHMENT.ShortName = "EOTECH"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Holographic sight",
    Color(255, 255, 255), "Wide field of view",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [0] = 4 },
    ["Bodygroups_W"] = { [0] = 4 },

    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_Eotech or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_Eotech or val end,

    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Collimator or val * 0.95 end,
    },
}
