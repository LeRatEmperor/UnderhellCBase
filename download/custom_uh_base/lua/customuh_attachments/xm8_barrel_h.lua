-- xm8_barrel_h.lua
-- CustomUH attachment — HVY-B barrel
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Hvy-B"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "bo7/scotia/icon/bh"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_b_h.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(100, 255, 100), "-20% Spread",
    Color(100, 255, 100), "+20% Iron Sight Accuracy",
    Color(255, 100, 100), "+200% Max Spread Multiplier",
    Color(255, 100, 100), "+10% Iron Sight Time",
    Color(255, 255, 255), "Summary: Improved initial accuracy",
    Color(255, 255, 255), "but rapid spread buildup when firing.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.Spread"] = function(wep, val) return val * 0.8 end,
    ["Primary.IronAccuracy"] = function(wep, val) return val * 0.8 end,
    ["Primary.SpreadMultiplierMax"] = function(wep, val) return val * 2 end,
    ["IronSightTime"] = function(wep, val) return val * 1.1 end,
}

function ATTACHMENT:Attach(wep)
    if not wep or not wep.ViewModelElements then return end
    local elem = wep.ViewModelElements[self.PartClass]
    if not elem then return end

    if not elem._original_model then
        elem._original_model = elem.model
    end
    elem.model = self.ModelPath

    if wep.CleanupVElements then wep:CleanupVElements() end
    if wep.InitVElements then wep:InitVElements() end

    if wep.WorldModelElements and wep.WorldModelElements[self.PartClass] then
        local welem = wep.WorldModelElements[self.PartClass]
        if not welem._original_model then
            welem._original_model = welem.model
        end
        welem.model = self.ModelPath
        if wep.CleanupWElements then wep:CleanupWElements() end
        if wep.InitWElements then wep:InitWElements() end
    end
end

function ATTACHMENT:Detach(wep)
    if not wep or not wep.ViewModelElements then return end
    local elem = wep.ViewModelElements[self.PartClass]
    if elem and elem._original_model then
        elem.model = elem._original_model
    end

    if wep.WorldModelElements and wep.WorldModelElements[self.PartClass] then
        local welem = wep.WorldModelElements[self.PartClass]
        if welem and welem._original_model then
            welem.model = welem._original_model
        end
    end

    if wep.CleanupVElements then wep:CleanupVElements() end
    if wep.InitVElements then wep:InitVElements() end
    if wep.CleanupWElements then wep:CleanupWElements() end
    if wep.InitWElements then wep:InitWElements() end
end
