-- xm8_smag.lua
-- CustomUH attachment — 20 Round Mags
-- Ported from TFA format.
-- Note: TFA's ["smag1"] = true internal marker and TFA.Enum.ANIMATION_SEQ
-- references have been removed/replaced. Animations are preserved as data
-- for future CustomUH animation-system integration.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "20 Round Mags"
ATTACHMENT.ShortName = "MAG"
ATTACHMENT.Icon = "bo7/scotia/icon/mf1"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_m_f.mdl"
ATTACHMENT.PartClass = "mag"

ATTACHMENT.Description = {
    Color(100, 255, 100), "20 Round Magazine",
    Color(100, 255, 100), "-30% Static Recoil Factor",
    Color(100, 255, 100), "+30% Iron Sight Accuracy",
    Color(100, 255, 100), "-30% Iron Sight Time",
    Color(100, 255, 100), "+15% Move Speed",
    Color(255, 255, 255), "Summary: Low-capacity magazine with",
    Color(255, 255, 255), "significant accuracy and handling benefits.",
}

ATTACHMENT.WeaponTable = {
    ["Primary.StaticRecoilFactor"] = function(wep, val) return val * 0.7 end,
    ["Primary.IronAccuracy"] = function(wep, val) return val * 0.7 end,
    ["Primary.ClipSize"] = function(wep, val) return 20 end,
    ["IronSightTime"] = function(wep, val) return val * 0.7 end,
    ["MoveSpeed"] = function(wep, val) return val * 1.15 end,

    -- Reload animations (preserved from TFA, type converted from
    -- TFA.Enum.ANIMATION_SEQ to "seq" string for CustomUH compat).
    ["Animations"] = {
        ["reload"] = {
            ["type"] = "seq",
            ["value"] = "reload_fast02",
        },
        ["reload_empty"] = {
            ["type"] = "seq",
            ["value"] = "reload_empty_fast02",
        },
        ["inspect_empty"] = {
            ["type"] = "seq",
            ["value"] = "inspect_empty_fast02",
        },
    },
}

-- Sync the live clip1 to the new ClipSize after a mag swap, refunding
-- overflow back to the reserve ammo pool. This replaces TFA's ReloadWep
-- helper, which used TFA-specific methods (Unload, GetPrimaryClipSizeForReload).
local function SyncClipToMax(wep)
    if not IsValid(wep) then return end
    timer.Simple(0.1, function()
        if not IsValid(wep) then return end
        local maxClip = wep.Primary and wep.Primary.ClipSize or 0
        if maxClip <= 0 then return end
        local current = wep:Clip1()
        if current > maxClip then
            local refund = current - maxClip
            wep:SetClip1(maxClip)
            if wep.GiveAmmo then
                local ammoType = wep.GetPrimaryAmmoType and wep:GetPrimaryAmmoType() or "ar2"
                wep:GiveAmmo(refund, ammoType, true)
            end
        elseif current == 0 and wep.Ammo1 and wep:Ammo1() > 0 then
            local load = math.min(maxClip, wep:Ammo1())
            wep:SetClip1(load)
            if wep.TakePrimaryAmmo then wep:TakePrimaryAmmo(load) end
        end
    end)
end

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

    SyncClipToMax(wep)
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

    SyncClipToMax(wep)
end
