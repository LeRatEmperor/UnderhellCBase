if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "CQB"
ATTACHMENT.ShortName = "PSGrip"
ATTACHMENT.Icon = "bo7/scotia/icon/pc"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_p_c.mdl"
ATTACHMENT.PartClass = "pgrip"

ATTACHMENT.Description = {
    Color(255, 100, 100), "+30% Static Recoil Factor",
    Color(100, 255, 100), "-10% Iron Sight Time",
    Color(255, 255, 255), "Summary: Adjustable stock for",
    Color(255, 255, 255), "faster handling but less stable."
}

ATTACHMENT.WeaponTable = {
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["StaticRecoilFactor"] = function(wep, val) return val * 1.3 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 0.9 end,
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
