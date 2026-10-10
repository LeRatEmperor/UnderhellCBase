if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "45 Round Mags"
ATTACHMENT.ShortName = "MAG"
ATTACHMENT.Icon = "bo7/scotia/icon/me1"
ATTACHMENT.ModelPath = "models/dqr/bo7/scotia/scotia_m_l.mdl"
ATTACHMENT.PartClass = "mag"

ATTACHMENT.Description = {
    Color(100, 255, 100), "45 Round Magazine",
    Color(100, 255, 100), "+5% Static Recoil Factor",
    Color(255, 100, 100), "+5% Iron Sight Accuracy Penalty",
    Color(255, 100, 100), "+5% Iron Sight Time",
    Color(255, 100, 100), "-5% Move Speed",
}

ATTACHMENT.WeaponTable = {
    ["xmag1"] = true,
    ["Animations"] = {
        ["reload"] = "reload_ext01",
        ["reload_empty"] = "reload_empty_ext01",
        ["inspect_empty"] = "inspect_empty_ext01",
    },
    ["Primary"] = {
        ["StaticRecoilFactor"] = function(wep, val) return val * 1.05 end,
        ["IronAccuracy"] = function(wep, val) return val * 1.05 end,
        ["ClipSize"] = function(wep, val) return 45 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.05 end,
    ["MoveSpeed"] = function(wep, val) return val * 0.95 end,
}

-- Simple clip sync helper using standard GMod SetClip1/TakePrimaryAmmo.
-- Tops up the weapon's primary clip to its max and pulls the difference
-- from the owner's primary ammo reserves.
function SyncClipToMax(wep)
    if not IsValid(wep) then return end
    local maxClip = wep:GetMaxClip1()
    if not maxClip or maxClip <= 0 then return end

    local currentClip = wep:Clip1() or 0
    local needed = maxClip - currentClip
    if needed <= 0 then return end

    wep:SetClip1(maxClip)

    if wep.TakePrimaryAmmo then
        wep:TakePrimaryAmmo(needed)
    end
end

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
    SyncClipToMax(wep)
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
    SyncClipToMax(wep)
end
