if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "XL Barrel"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "bo7/scotia/icon/bxl"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_b_xl.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(100, 255, 100), "-15% Vertical Recoil (KickUp)",
    Color(100, 255, 100), "-15% Horizontal Recoil",
    Color(100, 255, 100), "+80% Damage Range",
    Color(255, 100, 100), "+30% Iron Sight Time",
    Color(255, 255, 255), "Summary: Extended heavy barrel",
    Color(255, 255, 255), "with significant range boost.",
}

ATTACHMENT.WeaponTable = {
    ["ViewModelBoneMods"] = {},
    ["WorldModelBoneMods"] = {},
    ["Primary"] = {
        ["KickUp"] = function(wep, val) return val * 0.85 end,
        ["KickHorizontal"] = function(wep, val) return val * 0.85 end,
        ["Range"] = function(wep, val) return val * 1.8 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.3 end,
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
