-- xm8_psg_q.lua
-- CustomUH attachment — Quick pistol grip (FAST)
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "FAST"
ATTACHMENT.ShortName = "PSGrip"
ATTACHMENT.Icon = "bo7/scotia/icon/pq"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_p_q.mdl"
ATTACHMENT.PartClass = "pgrip"

ATTACHMENT.Description = {
    Color(100, 255, 100), "-30% Iron Sight Time",
    Color(255, 255, 255), "Summary: Ultra-fast target",
    Color(255, 255, 255), "acquisition and aiming.",
}

ATTACHMENT.WeaponTable = {
    ["IronSightTime"] = function(wep, val) return val * 0.70 end,
}

function ATTACHMENT:Attach(wep)
    if not wep or not wep.ViewModelElements then return end
    local elem = wep.ViewModelElements[self.PartClass]
    if not elem then return end

    if not elem._original_model then
        elem._original_model = elem.model
    end
    elem.model = self.ModelPath

    if wep.CleanupVElements then wep:CleanupVElements() end
    if wep.InitVElements then wep:InitVElements() end

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
