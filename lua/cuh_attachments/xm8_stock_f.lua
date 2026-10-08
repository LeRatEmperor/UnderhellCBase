if not ATTACHMENT then ATTACHMENT = {} end

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
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["KickUp"] = function(wep, val) return val * 0.7 end,
        ["KickDown"] = function(wep, val) return val * 0.7 end,
        ["KickHorizontal"] = function(wep, val) return val * 0.7 end,
        ["Spread"] = function(wep, val) return val * 0.9 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.8 end,
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
