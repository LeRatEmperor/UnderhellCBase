-- fix_usehands.lua
-- Run this in GMod console to fix weapons that have UseHands = false
-- This enables c_hands on all weapons

-- List of weapons that have UseHands = false in the original BF3 SWEP code:
local broken_weapons = {
    "bf3_famas",
    "bf3_g36c", 
    "bf3_g3a3",
    "bf3_l85a2",
    "bf3_m416",
    "bf3_scarh",
}

hook.Add("Initialize", "FixUseHands", function()
    for _, wep_class in ipairs(broken_weapons) do
        local wep = weapons.GetStored(wep_class)
        if wep then
            wep.UseHands = true
            print("[FixUseHands] Set " .. wep_class .. ".UseHands = true")
        end
    end
end)
