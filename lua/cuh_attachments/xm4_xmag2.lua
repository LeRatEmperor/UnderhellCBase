if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "60 Round Mags"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = "bo6/xm4/icon/m60"
ATTACHMENT.ModelPath = "models/dqr/bo6/xm4/xm4_mag_ext2.mdl"
ATTACHMENT.PartClass = "mag"

ATTACHMENT.Description = {
    Color(255, 255, 255), "60 Round Mags",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["ClipSize"] = function(wep, val) return 60 end,
    },
    ["Animations"] = {
        ["reload"] = "reload_ext02",
        ["reload_empty"] = "reload_empty_ext02",
        ["inspect"] = "inspect_ext02",
        ["inspect_empty"] = "inspect_empty_ext02",
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
