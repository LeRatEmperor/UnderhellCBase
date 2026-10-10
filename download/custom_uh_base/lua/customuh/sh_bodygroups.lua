AddCSLuaFile()
-- sh_bodygroups.lua
-- CustomUH Bodygroup Swap System
-- ============================================================
-- Handles sight and magazine bodygroup changes when attachments
-- are equipped/removed.
--
-- Weapon defines:
--   SWEP.SightBGs = { main = 1, regular = 0, acog = 1, reddot = 2, ... }
--   SWEP.MagBGs   = { main = 2, regular = 0, fast_mag = 1, ext_mag = 2 }
--   SWEP.WMSightBGs = { ... }  -- world model equivalents
--   SWEP.WMMagBGs   = { ... }
--
-- Attachment calls:
--   wep:SetSightBodygroup(wep.SightBGs.acog)
--   wep:SetMagBodygroup(wep.MagBGs.ext_mag)
-- ============================================================

-- ============================================================
-- SIGHT BODYGROUP
-- ============================================================
function SWEP:SetSightBodygroup(value)
    if not self.SightBGs then return end
    self._currentSightBG = value

    if self.SightBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.SightBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.SightBGs.main] = value
    end

    -- World model bodygroup (if different from viewmodel)
    if self.WMSightBGs and self.WMSightBGs.main then
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.WMSightBGs.main] = value
    end
end

-- ============================================================
-- MAGAZINE BODYGROUP
-- ============================================================
function SWEP:SetMagBodygroup(value)
    if not self.MagBGs then return end
    self._currentMagBG = value

    if self.MagBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.MagBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.MagBGs.main] = value
    end

    -- World model bodygroup
    if self.WMMagBGs and self.WMMagBGs.main then
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.WMMagBGs.main] = value
    end
end

-- ============================================================
-- APPLY BODYGROUPS TO VIEWMODEL
-- ============================================================
-- Called from HandleBones or PostDrawViewModel
function SWEP:ApplyBodygroupsVM(vm)
    if not IsValid(vm) then return end
    for bg, val in pairs(self.Bodygroups_V or {}) do
        vm:SetBodygroup(bg, val)
    end
end

-- ============================================================
-- APPLY BODYGROUPS TO WORLD MODEL
-- ============================================================
function SWEP:ApplyBodygroupsWM(wm)
    if not IsValid(wm) then return end
    for bg, val in pairs(self.Bodygroups_W or {}) do
        wm:SetBodygroup(bg, val)
    end
end

-- ============================================================
-- RESET BODYGROUPS (called during ApplyAttachments full reset)
-- ============================================================
function SWEP:ResetBodygroups()
    self.Bodygroups_V = {}
    self.Bodygroups_W = {}
    self._currentSightBG = nil
    self._currentMagBG = nil

    -- Restore regular sight bodygroup
    if self.SightBGs and self.SightBGs.regular ~= nil then
        self:SetSightBodygroup(self.SightBGs.regular)
    end
    -- Restore regular mag bodygroup
    if self.MagBGs and self.MagBGs.regular ~= nil then
        self:SetMagBodygroup(self.MagBGs.regular)
    end
end
