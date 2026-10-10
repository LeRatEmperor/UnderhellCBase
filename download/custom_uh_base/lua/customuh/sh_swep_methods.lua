AddCSLuaFile()
-- sh_swep_methods.lua
-- CustomUH SWEP Methods — stat cache, ApplyAttachments, SetAttachment
-- ============================================================
-- This file is loaded by IncludeWithSWEP() in sh_customuh.lua, which
-- compiles us with CompileFile() and runs us inside an environment
-- whose `SWEP` field is the registered weapon class table returned
-- by weapons.GetStored("weapon_custom_uh_base"). As a result every
-- `function SWEP:Foo()` definition below is installed on the real
-- registered class table that all derived weapons (gun/shotty/melee/
-- M8A1) inherit from via GMod's SWEP metatable inheritance.
--
-- Do NOT rely on _G.SWEP being set at the time this file runs —
-- older code did that and it broke under various GMod versions.
-- IncludeWithSWEP() guarantees the binding via setfenv().
-- ============================================================

function SWEP:GetEffectiveAttachment(slot)
    if not self.Attachments or not self.Attachments[slot] then return 0 end
    local slotData = self.Attachments[slot]
    local sel = slotData.sel

    if sel == nil then
        if slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    if sel == 0 then
        if slotData.forceDefault and slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    return sel
end

function SWEP:InitStatCache()
    if self._statCache then return end
    self._statCache = {}
    self._statOrigins = {}

    for k, v in pairs(self.Primary or {}) do
        self._statCache["Primary." .. k] = v
        self._statOrigins["Primary." .. k] = v
    end
    for k, v in pairs(self.Secondary or {}) do
        self._statCache["Secondary." .. k] = v
        self._statOrigins["Secondary." .. k] = v
    end

    local topLevel = {
        "DamageGeneric", "Num", "FireRate", "Spread", "SpreadIronsighted",
        "ViewSlideRecoilUp", "ViewSlideRecoilRight", "ZoomFov",
        "IronsightSpeed", "IronsightEaseIn", "ZoomSpeedIn", "ZoomSpeedOut",
        "IronSightTime", "MoveSpeed", "IronRecoilMultiplier",
        "Primary.ClipSize", "Primary.ClipSizeExt",
        "Primary.Spread", "Primary.IronAccuracy", "Primary.Delay",
        "Primary.KickUp", "Primary.KickDown", "Primary.KickHorizontal",
        "Primary.MinRecoil", "Primary.MaxRecoil",
        "Primary.StaticRecoilFactor",
        "Primary.SpreadMultiplierMax", "Primary.SpreadIncrement",
        "Primary.SpreadRecovery", "Primary.Range",
        "Primary.NumberofShots", "Primary.MinDamage", "Primary.MaxDamage",
    }
    for _, key in ipairs(topLevel) do
        if string.find(key, "%.") then
            local tbl, field = string.match(key, "(.+)%.(.+)")
            if self[tbl] and self[tbl][field] ~= nil then
                self._statCache[key] = self[tbl][field]
                self._statOrigins[key] = self[tbl][field]
            end
        else
            if self[key] ~= nil then
                self._statCache[key] = self[key]
                self._statOrigins[key] = self[key]
            end
        end
    end

    if self.IronSightsPos then
        self._statCache["IronSightsPos"] = self.IronSightsPos
        self._statOrigins["IronSightsPos"] = self.IronSightsPos
    end
    if self.IronSightsAng then
        self._statCache["IronSightsAng"] = self.IronSightsAng
        self._statOrigins["IronSightsAng"] = self.IronSightsAng
    end

    self._statDirty = true
end

function SWEP:GetStat(path)
    if not self._statCache then self:InitStatCache() end
    return self._statCache[path]
end

function SWEP:SetStat(path, value)
    if not self._statCache then self:InitStatCache() end
    self._statCache[path] = value
    self._statDirty = true
end

function SWEP:RestoreStat(path)
    if not self._statOrigins then return end
    local origin = self._statOrigins[path]
    if origin ~= nil then self:SetStat(path, origin) end
end

function SWEP:FlushStats()
    if not self._statCache or not self._statDirty then return end
    for path, value in pairs(self._statCache) do
        if string.find(path, "%.") then
            local tbl, field = string.match(path, "(.+)%.(.+)")
            if self[tbl] then self[tbl][field] = value end
        else
            self[path] = value
        end
    end
    self._statDirty = false
end

function SWEP:ApplyAttachments()
    if not self.Attachments then return end
    if not self._statOrigins then self:InitStatCache() end

    -- 1. FULL RESET
    for path, _ in pairs(self._statCache) do
        self:RestoreStat(path)
    end

    -- 2. RESET VELEMENTS
    if self.ViewModelElements then
        for name, elem in pairs(self.ViewModelElements) do
            elem.active = elem._defaultActive or false
        end
    end

    -- 3. RESET WELEMENTS
    if self.WorldModelElements then
        for name, elem in pairs(self.WorldModelElements) do
            elem.active = elem._defaultActive or false
        end
    end

    -- 4. RESET BODYGROUPS
    if self.ResetBodygroups then self:ResetBodygroups() end

    -- 5. APPLY each equipped attachment
    for slot = 1, #self.Attachments do
        local slotData = self.Attachments[slot]
        if slotData then
            local sel = self:GetEffectiveAttachment(slot)
            if sel and sel > 0 then
                local attId = slotData.atts[sel]
                if attId and CustomUH.Attachments[attId] then
                    local att = CustomUH.Attachments[attId]

                    if att.WeaponTable then
                        for path, value in pairs(att.WeaponTable) do
                            if path ~= "VElements" and path ~= "WElements"
                               and path ~= "Bodygroups_V" and path ~= "Bodygroups_W"
                               and path ~= "ViewModelBoneMods" and path ~= "WorldModelBoneMods"
                               and path ~= "Animations" then
                                if isfunction(value) then
                                    local currentVal = self:GetStat(path)
                                    local newVal, shouldSet = value(self, currentVal)
                                    if shouldSet ~= false then
                                        self:SetStat(path, newVal)
                                    end
                                else
                                    self:SetStat(path, value)
                                end
                            end
                        end

                        if att.WeaponTable.Bodygroups_V then
                            self.Bodygroups_V = self.Bodygroups_V or {}
                            for bg, val in pairs(att.WeaponTable.Bodygroups_V) do
                                self.Bodygroups_V[bg] = val
                            end
                        end
                        if att.WeaponTable.Bodygroups_W then
                            self.Bodygroups_W = self.Bodygroups_W or {}
                            for bg, val in pairs(att.WeaponTable.Bodygroups_W) do
                                self.Bodygroups_W[bg] = val
                            end
                        end
                    end

                    if att.WeaponTable and att.WeaponTable.VElements then
                        if not self.ViewModelElements then self.ViewModelElements = {} end
                        for name, override in pairs(att.WeaponTable.VElements) do
                            if self.ViewModelElements[name] then
                                for k, v in pairs(override) do
                                    self.ViewModelElements[name][k] = v
                                end
                            else
                                self.ViewModelElements[name] = table.Copy(override)
                            end
                        end
                    end

                    if att.WeaponTable and att.WeaponTable.WElements then
                        if not self.WorldModelElements then self.WorldModelElements = {} end
                        for name, override in pairs(att.WeaponTable.WElements) do
                            if self.WorldModelElements[name] then
                                for k, v in pairs(override) do
                                    self.WorldModelElements[name][k] = v
                                end
                            else
                                self.WorldModelElements[name] = table.Copy(override)
                            end
                        end
                    end

                    if att.Attach then att:Attach(self) end
                end
            end
        end
    end

    self:FlushStats()

    if self.CleanupVElements then self:CleanupVElements() end
    if self.InitVElements then self:InitVElements() end
    if self.CleanupWElements then self:CleanupWElements() end
    if self.InitWElements then self:InitWElements() end
end

function SWEP:SetAttachment(slot, index)
    if not self.Attachments or not self.Attachments[slot] then return end

    if index > 0 and (not self.Attachments[slot].atts or index > #self.Attachments[slot].atts) then
        return
    end

    if index == 0 and self.Attachments[slot].forceDefault
        and self.Attachments[slot].default and self.Attachments[slot].default > 0 then
        index = self.Attachments[slot].default
    end

    self.Attachments[slot].sel = index
    self:ApplyAttachments()

    if CLIENT then
        net.Start("CUH2_AttSelect")
            net.WriteEntity(self)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.SendToServer()
    end

    if SERVER then
        CustomUH.SaveAttachments(self, self.Owner)
    end
end
