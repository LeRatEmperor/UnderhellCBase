if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Med"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "bo7/scotia/icon/bm"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_b_m.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(255, 100, 100), "+50% Static Recoil Factor",
    Color(255, 100, 100), "+20% Iron Sight Accuracy Penalty",
    Color(100, 255, 100), "-20% Iron Sight Recoil Multiplier",
    Color(255, 255, 255), "Summary: High-recoil stock for",
    Color(255, 255, 255), "improved aiming stability.",
}

ATTACHMENT.WeaponTable = {
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["StaticRecoilFactor"] = function(wep, val) return val * 1.5 end,
        ["IronAccuracy"] = function(wep, val) return val * 1.2 end,
        ["IronRecoilMultiplier"] = function(wep, val) return val * 0.8 end,
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
