if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "PistolGrip"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = nil
ATTACHMENT.ModelPath = "models/dqr/bo7/1911/1911_p_d.mdl"
ATTACHMENT.PartClass = "pgrip"

ATTACHMENT.Description = {
    Color(255, 255, 255), "PistolGrip",
}

ATTACHMENT.WeaponTable = {}

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
