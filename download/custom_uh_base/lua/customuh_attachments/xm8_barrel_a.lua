-- xm8_barrel_a.lua
-- CustomUH attachment — Auto barrel (MS-8.5)
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "MS-8.5"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = nil
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_b_a.mdl"
ATTACHMENT.PartClass = "barrel"

ATTACHMENT.Description = {
    Color(100, 255, 100), "+15% Damage Range",
    Color(100, 255, 100), "-15% Iron Sight Time",
    Color(255, 255, 255), "Summary: Increased effective range",
    Color(255, 255, 255), "with faster target acquisition.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.Range"] = function(wep, val) return val * 0.85 end,
    ["IronSightTime"] = function(wep, val) return val * 0.85 end,
}

function ATTACHMENT:Attach(wep)
    if not wep or not wep.ViewModelElements then return end
    local elem = wep.ViewModelElements[self.PartClass]
    if not elem then return end

    -- Save original model path if not already saved
    if not elem._original_model then
        elem._original_model = elem.model
    end

    -- Swap to new model
    elem.model = self.ModelPath

    -- Rebuild view-model ClientsideModels
    if wep.CleanupVElements then wep:CleanupVElements() end
    if wep.InitVElements then wep:InitVElements() end

    -- Mirror to world model if present
    if wep.WorldModelElements and wep.WorldModelElements[self.PartClass] then
        local welem = wep.WorldModelElements[self.PartClass]
        if not welem._original_model then
            welem._original_model = welem.model
        end
        welem.model = self.ModelPath
        if wep.CleanupWElements then wep:CleanupWElements() end
        if wep.InitWElements then wep:InitWElements() end
    end
end

function ATTACHMENT:Detach(wep)
    if not wep or not wep.ViewModelElements then return end
    local elem = wep.ViewModelElements[self.PartClass]
    if elem and elem._original_model then
        elem.model = elem._original_model
    end

    if wep.WorldModelElements and wep.WorldModelElements[self.PartClass] then
        local welem = wep.WorldModelElements[self.PartClass]
        if welem and welem._original_model then
            welem.model = welem._original_model
        end
    end

    if wep.CleanupVElements then wep:CleanupVElements() end
    if wep.InitVElements then wep:InitVElements() end
    if wep.CleanupWElements then wep:CleanupWElements() end
    if wep.InitWElements then wep:InitWElements() end
end
