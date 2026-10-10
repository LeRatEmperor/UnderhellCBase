if not ATTACHMENT then ATTACHMENT = {} end

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
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["Spread"] = function(wep, val) return val * 0.8 end,
        ["IronAccuracy"] = function(wep, val) return val * 0.8 end,
        ["SpreadMultiplierMax"] = function(wep, val) return val * 2 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.1 end,
}

function ATTACHMENT:Attach(wep)
    local partClass = self.PartClass
    local newModel = self.ModelPath

    print("[CUH-DBG] >>> ATTACHMENT:Attach CALLED  self.Name=" .. tostring(self.Name)
        .. "  self.ID=" .. tostring(self.ID) .. "  PartClass=" .. tostring(partClass)
        .. "  newModel=" .. tostring(newModel))
    print("[CUH-DBG]   wep=" .. tostring(wep) .. "  class=" .. tostring(wep.GetClass and wep:GetClass() or "?")
        .. "  realm=" .. (SERVER and "SERVER" or "CLIENT"))
    print("[CUH-DBG]   wep.ViewModelElements present: " .. tostring(wep.ViewModelElements ~= nil))
    if wep.ViewModelElements then
        local keys = {}
        for k, _ in pairs(wep.ViewModelElements) do keys[#keys+1] = tostring(k) end
        print("[CUH-DBG]   wep.ViewModelElements keys = {" .. table.concat(keys, ", ") .. "}")
        print("[CUH-DBG]   wep.ViewModelElements['" .. tostring(partClass) .. "'] = " .. tostring(wep.ViewModelElements[partClass]))
    end

    if wep.ViewModelElements and wep.ViewModelElements[partClass] then
        print("[CUH-DBG]   BEFORE swap: elem.model = " .. tostring(wep.ViewModelElements[partClass].model))
        if not wep.ViewModelElements[partClass]._original_model then
            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model
            print("[CUH-DBG]   saved _original_model = " .. tostring(wep.ViewModelElements[partClass]._original_model))
        end
        wep.ViewModelElements[partClass].model = newModel
        print("[CUH-DBG]   AFTER swap:  elem.model = " .. tostring(wep.ViewModelElements[partClass].model))
    else
        print("[CUH-DBG]   WARNING: wep.ViewModelElements['" .. tostring(partClass) .. "'] is missing — model swap SKIPPED")
    end

    if wep.WorldModelElements and wep.WorldModelElements[partClass] then
        if not wep.WorldModelElements[partClass]._original_model then
            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model
        end
        wep.WorldModelElements[partClass].model = newModel
        print("[CUH-DBG]   WorldModelElements['" .. tostring(partClass) .. "'].model swapped too")
    end

    print("[CUH-DBG]   calling wep:CleanupVElements() + wep:InitVElements() to rebuild ClientsideModels")
    wep:CleanupVElements()
    wep:InitVElements()
    print("[CUH-DBG]   rebuilt. barrel _csModel = " .. tostring(wep.ViewModelElements and wep.ViewModelElements[partClass] and wep.ViewModelElements[partClass]._csModel))
    print("[CUH-DBG] <<< ATTACHMENT:Attach returning")
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
