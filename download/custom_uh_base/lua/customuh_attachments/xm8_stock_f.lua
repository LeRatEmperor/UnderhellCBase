-- xm8_stock_f.lua
-- CustomUH attachment — Full stock (FULL)
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "FULL"
ATTACHMENT.ShortName = "STOCK"
ATTACHMENT.Icon = "bo7/scotia/icon/sf"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_s_f.mdl"
ATTACHMENT.PartClass = "default_stock"

ATTACHMENT.Description = {
    Color(100, 255, 100), "-30% Vertical Recoil (KickUp & KickDown)",
    Color(100, 255, 100), "-30% Horizontal Recoil",
    Color(100, 255, 100), "-10% Spread",
    Color(255, 100, 100), "+80% Iron Sight Time",
    Color(255, 255, 255), "Summary: Heavy suppressor with",
    Color(255, 255, 255), "excellent recoil control penalty.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.KickUp"] = function(wep, val) return val * 0.7 end,
    ["Primary.KickDown"] = function(wep, val) return val * 0.7 end,
    ["Primary.KickHorizontal"] = function(wep, val) return val * 0.7 end,
    ["Primary.Spread"] = function(wep, val) return val * 0.9 end,
    ["IronSightTime"] = function(wep, val) return val * 1.8 end,
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
