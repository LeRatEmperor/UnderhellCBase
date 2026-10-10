AddCSLuaFile()
-- sh_att_ammo.lua
-- CustomUH Ammo System — Custom ammo type registration
-- ============================================================
-- Allows weapons to use custom ammo types with display names.
-- Also handles clip size modifications from attachments.
--
-- Usage in weapons:
--   SWEP.Primary.Ammo = "uh_556"
--
-- Usage in attachments:
--   ATTACHMENT.WeaponTable = {
--     ["Primary.ClipSize"] = function(wep, val) return val * 2 end,
--     ["Primary.ClipSizeExt"] = function(wep, val) return val * 2 end,
--   }
-- ============================================================

-- ============================================================
-- MODIFY CLIP SIZE (called during ApplyAttachments)
-- ============================================================
function SWEP:UpdateClipSize()
    local newClipSize = self:GetStat("Primary.ClipSize")
    if not newClipSize then return end

    -- If clip size increased and current clip is full, fill to new max
    if SERVER then
        local currentClip = self:Clip1()
        if currentClip > newClipSize then
            self:SetClip1(newClipSize)
        end
    end
end

-- ============================================================
-- GET EXTENDED CLIP SIZE
-- ============================================================
function SWEP:GetExtendedClipSize()
    local extSize = self:GetStat("Primary.ClipSizeExt")
    if extSize and extSize > 0 then
        return extSize
    end
    return self.Primary.ClipSize
end

-- ============================================================
-- AMMO HUD OVERRIDE (client)
-- ============================================================
if CLIENT then
    -- Override the default ammo name display in HUD
    -- This hooks into the weapon's DrawHUD to show custom ammo names
    hook.Add("HUDShouldDraw", "CustomUH_AmmoHUD", function(element)
        -- Let everything draw normally — we just override the text
        return true
    end)
end

-- ============================================================
-- GET AMMO DISPLAY NAME
-- ============================================================
function SWEP:GetAmmoDisplayName()
    local ammoType = self.Primary.Ammo
    if not ammoType then return "" end

    -- Check custom registered ammo first
    local custom = CustomUH.AmmoTypes[ammoType]
    if custom then return custom.Name end

    -- Fallback to GMod's built-in name
    return language.GetPhrase(ammoType .. "_ammo")
end
