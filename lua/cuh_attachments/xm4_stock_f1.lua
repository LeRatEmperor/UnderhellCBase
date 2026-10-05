if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Balanced stock"
ATTACHMENT.ShortName = "STOCK"
ATTACHMENT.Icon = "bo6/xm4/icon/sf"
ATTACHMENT.ModelPath = "models/dqr/bo6/xm4/xm4_stock_f1.mdl"
ATTACHMENT.PartClass = "default_stock"

ATTACHMENT.Description = {
    Color(255, 255, 255), "Balanced stock",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Range"] = function(wep, val) return val * 0.85 end,
        ["KickUp"] = function(wep, val) return val * .85 end,
        ["KickDown"] = function(wep, val) return val * .85 end,
        ["KickHorizontal"] = function(wep, val) return val * .85 end,
        ["RPM"] = function(wep, val) return val * 1.10 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.15 end,
    ["MoveSpeed"] = function(wep, val) return val * 1.05 end,
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
    wep:CleanupWElements()
    wep:InitWElements()
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
    wep:CleanupWElements()
    wep:InitWElements()
end
