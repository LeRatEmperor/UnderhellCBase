if not ATTACHMENT then ATTACHMENT = {} end

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
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["KickUp"] = function(wep, val) return val * 0.9 end,
        ["KickDown"] = function(wep, val) return val * 0.9 end,
        ["KickHorizontal"] = function(wep, val) return val * 0.9 end,
        ["StaticRecoilFactor"] = function(wep, val) return val * 0.9 end,
        ["IronRecoilMultiplier"] = function(wep, val) return val * 1.1 end,
    },
}

function ATTACHMENT:Attach(wep)
    local partClass = self.PartClass
    local newModel = self.ModelPath

    if wep.ViewModelElements and wep.ViewModelElements[partClass] then
        if not wep.ViewModelElements[partClass]._original_model then
            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model
        end
        wep.ViewModelElements[partClass].model = newModel
    end

    if wep.WorldModelElements and wep.WorldModelElements[partClass] then
        if not wep.WorldModelElements[partClass]._original_model then
            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model
        end
        wep.WorldModelElements[partClass].model = newModel
    end

    wep:CleanupVElements()
    wep:InitVElements()
end

function ATTACHMENT:Detach(wep)
    local partClass = self.PartClass

    if wep.ViewModelElements and wep.ViewModelElements[partClass] and wep.ViewModelElements[partClass]._original_model then
        wep.ViewModelElements[partClass].model = wep.ViewModelElements[partClass]._original_model
    end

    if wep.WorldModelElements and wep.WorldModelElements[partClass] and wep.WorldModelElements[partClass]._original_model then
        wep.WorldModelElements[partClass].model = wep.WorldModelElements[partClass]._original_model
    end

    wep:CleanupVElements()
    wep:InitVElements()
end
