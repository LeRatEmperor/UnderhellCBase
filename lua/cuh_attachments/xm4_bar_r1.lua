if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Long Barrel"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "bo6/xm4/icon/br1"
ATTACHMENT.ModelPath = "models/dqr/bo6/xm4/xm4_bar_r1.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(255, 255, 255), "Long Barrel",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Range"] = function(wep, val) return val * 1.25 end,
        ["KickUp"] = function(wep, val) return val * 0.9 end,
        ["KickDown"] = function(wep, val) return val * .9 end,
        ["KickHorizontal"] = function(wep, val) return val * .9 end,
        ["Spread"] = function(wep, val) return val * 0.80 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.20 end,
    ["MoveSpeed"] = function(wep, val) return val * 0.85 end,
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
