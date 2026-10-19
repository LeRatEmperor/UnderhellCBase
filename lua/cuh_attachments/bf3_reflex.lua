if not ATTACHMENT then ATTACHMENT = {} end

-- Reflex red-dot sight
-- Bodygroup 0 = 1 (reflex sight model on the rail)
-- IronSightsPos/Ang swap to the _Reflex variants defined on the weapon

ATTACHMENT.Name = "Reflex"
ATTACHMENT.Icon = "bf3/reflex.png"
ATTACHMENT.ShortName = "REFLEX"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Collimator sight",
    Color(255, 255, 255), "Faster target acquisition",
}

ATTACHMENT.ModelPath = nil   -- bodygroup-only, no model swap
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [0] = 1 },
    ["Bodygroups_W"] = { [0] = 1 },

    -- Use the per-attachment sight pos/ang if the weapon defines them
    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_Reflex or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_Reflex or val end,

    -- ADS zoom: prefer IronFOV_Collimator, else slight zoom in
    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Collimator or val * 0.95 end,
    },
}

-- No Attach/Detach side-effects: ApplyAttachments handles everything via WeaponTable
