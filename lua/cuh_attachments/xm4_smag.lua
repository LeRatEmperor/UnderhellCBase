if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "20 Round Mags"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = "bo6/xm4/icon/m20"
ATTACHMENT.ModelPath = "models/dqr/bo6/xm4/xm4_mag_f3.mdl"
ATTACHMENT.PartClass = "mag"

ATTACHMENT.Description = {
    Color(255, 255, 255), "20 Round Mags",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["ClipSize"] = function(wep, val) return 20 end,
    },
    ["Animations"] = {
        ["reload"] = "reload_fast01",
        ["reload_empty"] = "reload_empty_fast01",
        ["inspect"] = "Inspect_Fast03",
        ["inspect_empty"] = "Inspect_Empty_Fast03",
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
