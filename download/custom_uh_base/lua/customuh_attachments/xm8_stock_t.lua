-- xm8_stock_t.lua
-- CustomUH attachment — Tactical stock (TAC)
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "TAC"
ATTACHMENT.ShortName = "STOCK"
ATTACHMENT.Icon = "bo7/scotia/icon/st"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_s_t.mdl"
ATTACHMENT.PartClass = "default_stock"

ATTACHMENT.Description = {
    Color(100, 255, 100), "-10% All Recoil (Vertical & Horizontal)",
    Color(100, 255, 100), "-10% Static Recoil Factor",
    Color(255, 100, 100), "+10% Iron Sight Recoil Multiplier",
    Color(255, 255, 255), "Summary: Balanced grip that reduces",
    Color(255, 255, 255), "overall recoil with slight aim penalty.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.KickUp"] = function(wep, val) return val * 0.9 end,
    ["Primary.KickDown"] = function(wep, val) return val * 0.9 end,
    ["Primary.KickHorizontal"] = function(wep, val) return val * 0.9 end,
    ["Primary.StaticRecoilFactor"] = function(wep, val) return val * 0.9 end,
    ["IronRecoilMultiplier"] = function(wep, val) return val * 1.1 end,
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
