AddCSLuaFile()
-- sh_att_save.lua
-- CustomUH Save/Load System — Attachment persistence
-- ============================================================
-- Saves attachment selections per-player per-weapon-class to JSON.
-- Survives death, game reloads, and server restarts.
--
-- File location: data/customuh_saves/<steamid64>.json
-- Format:
--   {
--     "weapon_bo4_kn57": { "1": 2, "2": 0, "3": 1 },
--     "weapon_bo4_sdm": { "1": 0, "2": 1 }
--   }
-- ============================================================

local SAVE_DIR = "customuh_saves"

-- ============================================================
-- GET SAVE PATH
-- ============================================================
function CustomUH.GetSavePath(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return nil end
    return SAVE_DIR .. "/" .. ply:SteamID64() .. ".json"
end

-- ============================================================
-- LOAD ATTACHMENTS (server → sends to client)
-- ============================================================
function CustomUH.LoadAttachments(wep, ply)
    if not IsValid(ply) then ply = wep:GetOwner() end
    if not IsValid(ply) then return end

    local path = CustomUH.GetSavePath(ply)
    if not path then return end

    -- Read save file
    if not file.Exists(path, "DATA") then return end

    local data = util.JSONToTable(file.Read(path, "DATA") or "")
    if not data then return end

    -- Find this weapon's saved attachments
    local class = wep:GetClass()
    local saved = data[class]
    if not saved then return end

    -- Apply saved selections
    if not wep.Attachments then return end

    local changed = false
    for slot, index in pairs(saved) do
        slot = tonumber(slot) or slot
        if wep.Attachments[slot] then
            -- Validate the index still exists
            if index == 0 or (wep.Attachments[slot].atts and index <= #wep.Attachments[slot].atts) then
                wep.Attachments[slot].sel = index
                changed = true
            end
        end
    end

    if changed then
        wep:ApplyAttachments()

        -- Send saved state to client
        net.Start("CUH2_AttLoad")
            net.WriteEntity(wep)
            local count = 0
            local tempData = {}
            for slot, index in pairs(saved) do
                slot = tonumber(slot) or slot
                if wep.Attachments[slot] then
                    if index == 0 or (wep.Attachments[slot].atts and index <= #wep.Attachments[slot].atts) then
                        count = count + 1
                        tempData[count] = { slot = slot, index = index }
                    end
                end
            end
            net.WriteUInt(count, 8)
            for i = 1, count do
                net.WriteUInt(tempData[i].slot, 8)
                net.WriteUInt(tempData[i].index, 8)
            end
        net.Send(ply)
    end
end

-- ============================================================
-- SAVE ATTACHMENTS (server)
-- ============================================================
function CustomUH.SaveAttachments(wep, ply)
    if not IsValid(ply) then ply = wep:GetOwner() end
    if not IsValid(ply) then return end
    if not wep.Attachments then return end

    local path = CustomUH.GetSavePath(ply)
    if not path then return end

    -- Read existing saves
    local data = {}
    if file.Exists(path, "DATA") then
        data = util.JSONToTable(file.Read(path, "DATA") or "") or {}
    end

    -- Build current weapon's selections
    local class = wep:GetClass()
    local current = {}
    for slot, slotData in pairs(wep.Attachments) do
        if slotData.sel and slotData.sel > 0 then
            current[tostring(slot)] = slotData.sel
        else
            current[tostring(slot)] = 0
        end
    end

    -- Only save if there are non-zero selections
    local hasAttachments = false
    for _, v in pairs(current) do
        if v > 0 then hasAttachments = true break end
    end

    if hasAttachments then
        data[class] = current
    else
        data[class] = nil -- remove if no attachments equipped
    end

    -- Create directory if it doesn't exist
    if not file.Exists(SAVE_DIR, "DATA") then
        file.CreateDir(SAVE_DIR)
    end

    file.Write(path, util.TableToJSON(data, true))
end

-- ============================================================
-- SAVE ALL WEAPONS FOR A PLAYER (called on death/disconnect)
-- ============================================================
function CustomUH.SaveAllAttachments(ply)
    if not IsValid(ply) then return end

    for _, wep in pairs(ply:GetWeapons()) do
        if wep.Attachments then
            CustomUH.SaveAttachments(wep, ply)
        end
    end
end

-- ============================================================
-- HOOKS — auto save/load
-- ============================================================

-- Load on weapon deploy
hook.Add("WeaponDeployed", "CustomUH_LoadOnDeploy", function(wep, ply)
    if not IsValid(wep) or not IsValid(ply) then return end
    if not wep.Attachments then return end

    -- Small delay to let the weapon initialize
    timer.Simple(0.1, function()
        if IsValid(wep) and IsValid(ply) then
            CustomUH.LoadAttachments(wep, ply)
        end
    end)
end)

-- Save on player death
hook.Add("PlayerDeath", "CustomUH_SaveOnDeath", function(ply)
    if IsValid(ply) then
        CustomUH.SaveAllAttachments(ply)
    end
end)

-- Save on disconnect
hook.Add("PlayerDisconnected", "CustomUH_SaveOnDisconnect", function(ply)
    if IsValid(ply) then
        CustomUH.SaveAllAttachments(ply)
    end
end)

-- Save on weapon holster
hook.Add("WeaponHolstered", "CustomUH_SaveOnHolster", function(wep, ply)
    if IsValid(wep) and IsValid(ply) and wep.Attachments then
        CustomUH.SaveAttachments(wep, ply)
    end
end)
