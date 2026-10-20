if not ATTACHMENT then ATTACHMENT = {} end

-- Kobra red-dot sight (Russian collimator)
-- Bodygroup 0 = 2

ATTACHMENT.Name = "Kobra"
ATTACHMENT.Icon = "bf3/kobra.png"
ATTACHMENT.ShortName = "KOBRA"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Russian collimator sight",
    Color(255, 255, 255), "Same stats as Reflex, different reticle",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [0] = 2 },
    ["Bodygroups_W"] = { [0] = 2 },

    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_Kobra or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_Kobra or val end,

    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Collimator or val * 0.95 end,
    },
}
