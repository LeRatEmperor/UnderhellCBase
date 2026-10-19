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
    -- Includes silenced variants (BF3 has no separate silenced anims — same sequence).
    -- Includes sprint and iron keys so all states use the foregrip anims.
    ["Animations"] = {
        ["shoot"]             = "foregrip_fire",
        ["shoot_sil"]         = "foregrip_fire",
        ["reload"]            = "foregrip_reload",
        ["reload_sil"]        = "foregrip_reload",
        ["reload_empty"]      = "foregrip_reload_empty",
        ["reload_empty_sil"]  = "foregrip_reload_empty",
        ["idle"]              = "foregrip_idle",
        ["draw"]              = "foregrip_draw",
        ["sprint_idle"]       = "foregrip_idle",
        ["sprint_in"]         = "foregrip_idle",
        ["sprint_out"]        = "foregrip_idle",
        ["iron_in"]           = "foregrip_idle",
        ["iron_idle"]         = "foregrip_idle",
        ["iron_out"]          = "foregrip_idle",
    },
}

-- Drop the HoldType change ("smg" vs "ar2") from the original TFA attachment.
-- CUH doesn't have WeaponTable.HoldType support and the difference is cosmetic.

function ATTACHMENT:Attach(wep)
    -- Force-play the foregrip idle animation immediately so the user
    -- sees the swap right away (no need to shoot first).
    if CLIENT and IsValid(wep.Owner) then
        wep:EasySendWeaponAnim("idle", ACT_VM_IDLE)
    end
end

function ATTACHMENT:Detach(wep)
    -- Force-play the regular idle animation immediately so the user
    -- sees the revert right away.
    if CLIENT and IsValid(wep.Owner) then
        wep:EasySendWeaponAnim("idle", ACT_VM_IDLE)
    end
end
