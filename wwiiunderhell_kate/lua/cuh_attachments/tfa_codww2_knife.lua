if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Tactical Knife"
ATTACHMENT.ShortName = "KNIFE"
ATTACHMENT.Icon = "entities/tfa_codww2_knife.png"
ATTACHMENT.Description = {
        Color(100, 255, 100), "+Melee Damage",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["tac_knife"] = {
                        ["active"] = true,
                },
        },
        ["WElements"] = {
                ["tac_knife"] = {
                        ["active"] = true,
                },
        },
        ["MeleeRange"] = function(wep, val) return val + 15 end,
        ["MeleeDamage"] = function(wep, val) return val + 20 end,
        ["Animations"] = {
                -- Deploy / Holster
                ["deploy"]              = "draw_knife",
                ["deploy_empty"]        = "draw_knife_empty",
                ["holster"]             = "holster_knife",
                ["holster_empty"]       = "holster_knife_empty",
                -- Idle
                ["idle"]                = "idle_knife",
                ["idle_empty"]          = "idle_knife_empty",
                -- Fire
                ["shoot"]               = "fire_knife",
                ["shoot_ads"]            = "fire_knife_ads",
                ["shoot_empty"]         = "fire_knife_last",
                ["iron_fire"]            = "fire_knife_ads",
                -- Melee
                ["melee"]               = "melee_knife",
                ["melee_empty"]         = "melee_knife_empty",
                -- Inspect
                ["inspect"]             = "inspect_knife",
                ["inspect_empty"]       = "inspect_knife_empty",
                -- Sprint
                ["sprint_in"]           = "sprint_in_knife",
                ["sprint_out"]          = "sprint_out_knife",
                ["sprint_idle"]         = "sprint_loop_knife",
                ["sprint_in_empty"]     = "sprint_in_knife_empty",
                ["sprint_out_empty"]    = "sprint_out_knife_empty",
                ["sprint_idle_empty"]   = "sprint_loop_knife_empty",
                -- Reload — uses functions to handle ext mag priority
                -- When extended mags are also equipped, the ext_knife variant is used
                ["reload"] = function(wep, val)
                        if wep:IsAttachmentEquipped("tfa_codww2_xmag") then
                                return "reload_ext_knife"
                        end
                        return "reload_knife"
                end,
                ["reload_empty"] = function(wep, val)
                        if wep:IsAttachmentEquipped("tfa_codww2_xmag") then
                                return "reload_ext_knife_empty"
                        end
                        return "reload_knife_empty"
                end,
        },
}

-- ============================================================
-- ATTACH: Mark the weapon as having the tactical knife
-- ============================================================
function ATTACHMENT:Attach(wep)
    wep._hasTacKnife = true
end

function ATTACHMENT:Detach(wep)
    wep._hasTacKnife = false
end

-- TFA attachment registration removed (CUH base handles this)
