-- xm8_psg_c.lua
-- CustomUH attachment — CQB pistol grip
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "CQB"
ATTACHMENT.ShortName = "PSGrip"
ATTACHMENT.Icon = "bo7/scotia/icon/pc"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_p_c.mdl"
ATTACHMENT.PartClass = "pgrip"

ATTACHMENT.Description = {
    Color(255, 100, 100), "+30% Static Recoil Factor",
    Color(100, 255, 100), "-10% Iron Sight Time",
    Color(255, 255, 255), "Summary: Adjustable stock for",
    Color(255, 255, 255), "faster handling but less stable.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.StaticRecoilFactor"] = function(wep, val) return val * 1.3 end,
    ["IronSightTime"] = function(wep, val) return val * 0.9 end,
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
