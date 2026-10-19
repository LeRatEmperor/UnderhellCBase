if not ATTACHMENT then ATTACHMENT = {} end

-- Ballistic scope (sniper-grade, 8x+)
-- Bodygroup 0 = 5
-- Sets ScopeTexture on the weapon so CUH's RenderScene hook draws the scope view

ATTACHMENT.Name = "Scope"
ATTACHMENT.Icon = "bf3/scope_ballistic.png"
ATTACHMENT.ShortName = "SCOPE"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Ballistic scope",
    Color(255, 100, 100), "Bolt-action feel (no actual bolt cycle in pilot port)",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [0] = 5 },
    ["Bodygroups_W"] = { [0] = 5 },

    ["IronSightsPos"] = function(wep, val) return wep.SightsPos_Scope or val end,
    ["IronSightsAng"] = function(wep, val) return wep.SightsAng_Scope or val end,

    ["Secondary"] = {
        ["IronFOV"] = function(wep, val) return wep.Secondary.IronFOV_Scope or val * 0.95 end,
    },

    -- CUH reads ScopeTexture (a Material) and draws an RT scope view when Zooming is true.
    -- Returning a Material from a function-valued WeaponTable entry works because
    -- ApplyAttachments calls SetStat("ScopeTexture", <return value>), and stat cache
    -- restores the original (nil) when the attachment is removed via _defaultSnapshot.
    ["ScopeTexture"] = function(wep, val) return Material("bf3/scope.png", "smooth") end,
}
