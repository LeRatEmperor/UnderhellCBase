if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Combat Grip"
ATTACHMENT.ShortName = "PGRIP"
ATTACHMENT.Icon = "bo6/xm4/icon/ps2"
ATTACHMENT.ModelPath = "models/dqr/bo6/xm4/xm4_psg_s2.mdl"
ATTACHMENT.PartClass = "pgrip"

ATTACHMENT.Description = {
    Color(255, 255, 255), "Combat Grip",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Range"] = function(wep, val) return val * 0.85 end,
        ["KickUp"] = function(wep, val) return val * 1.20 end,
        ["KickDown"] = function(wep, val) return val * 1.20 end,
        ["KickHorizontal"] = function(wep, val) return val * 1.20 end,
        ["RPM"] = function(wep, val) return val * 1.10 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 0.85 end,
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
