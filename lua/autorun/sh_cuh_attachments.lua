-- sh_cuh_attachments.lua
-- CustomUH Attachment System — Autorun loader
-- ============================================================
-- This file lives in lua/autorun/ and handles ONLY:
--   1. Attachment data file registration (file.Find + include)
--   2. Networking (CUH2_AttSelect, CUH2_AttSync, CUH2_AttLoad)
--   3. Save/load (JSON per SteamID)
--
-- It does NOT define any SWEP: methods — those are all in
-- weapon_cuh_base_gun.lua directly. This keeps the architecture
-- clean: SWEP methods in weapon files, data/logic in autorun.
-- ============================================================

AddCSLuaFile()

-- ============================================================
-- NAMESPACE
-- ============================================================
CustomUH = CustomUH or {}
CustomUH.Attachments = CustomUH.Attachments or {}
CustomUH.Version = "3.0"

-- UI colors
CustomUH.Colors = {
    Background  = Color(30, 30, 30, 240),
    Panel       = Color(40, 40, 40, 240),
    Text        = Color(220, 220, 220, 255),
    TextBright   = Color(255, 255, 255, 255),
    TextDim      = Color(150, 150, 150, 255),
    Accent       = Color(0, 150, 255, 255),
    AccentDim    = Color(0, 80, 140, 200),
    Selected     = Color(0, 200, 100, 60),
    Hover        = Color(255, 255, 255, 20),
    StatPositive = Color(100, 255, 100, 255),
    StatNegative = Color(255, 100, 100, 255),
    StatNeutral  = Color(200, 200, 200, 255),
}

-- Convar for menu key (guard against double-registration)
if not ConVarExists("cuh_menu_key") then
    CreateClientConVar("cuh_menu_key", "c", true, false, "Key to open weapon customization")
end

-- ============================================================
-- ATTACHMENT REGISTRATION
-- ============================================================
-- Find every attachment file ONCE at addon-load time and:
--   * SERVER: AddCSLuaFile() it so it gets pushed to every client
--     that ever connects. Doing this during addon load (rather than
--     inside a Think hook) guarantees clients receive the file BEFORE
--     they try to include() it. The previous code called AddCSLuaFile
--     inside RegisterAttachments (a Think hook), which was too late
--     for already-connected clients and caused include() to fail
--     silently under pcall — so CustomUH.Attachments stayed empty
--     and the menu showed slot headers with zero attachment buttons.
--   * BOTH: include() it and register the ATTACHMENT table.
-- ============================================================

CustomUH._attFiles = file.Find("cuh_attachments/*.lua", "LUA")

if SERVER then
    for _, filename in ipairs(CustomUH._attFiles) do
        AddCSLuaFile("cuh_attachments/" .. filename)
    end
end

function CustomUH.RegisterAttachments()
    -- Use the file list captured at addon-load time. On a server-only
    -- install (where the client never had the addon mounted locally),
    -- the server pushes this list over net via CUH2_AttList and the
    -- client replaces CustomUH._attFiles with the networked copy.
    local files = CustomUH._attFiles or {}
    print("[CUH-DBG] RegisterAttachments CALLED  realm=" .. (SERVER and "SERVER" or "CLIENT")
        .. "  file count=" .. #files)
    for i, fn in ipairs(files) do
        print("[CUH-DBG]   file[" .. i .. "] = " .. tostring(fn))
    end
    for _, filename in ipairs(files) do
        ATTACHMENT = {}
        local path = "cuh_attachments/" .. filename

        local ok, err = pcall(include, path)
        if not ok then
            print("[CUH-DBG]   Error loading " .. filename .. ": " .. tostring(err))
            print("[CustomUH] Error loading " .. filename .. ": " .. tostring(err))
        end

        if ATTACHMENT and ATTACHMENT.Name then
            local id = string.StripExtension(filename)
            ATTACHMENT.ID = id
            CustomUH.Attachments[id] = ATTACHMENT
            print("[CUH-DBG]   registered attachment id='" .. id .. "'  Name='" .. tostring(ATTACHMENT.Name) .. "'  PartClass=" .. tostring(ATTACHMENT.PartClass))
        else
            print("[CUH-DBG]   ATTACHMENT skipped (no .Name): " .. filename)
            print("[CustomUH] Attachment skipped (no .Name): " .. filename)
        end
        ATTACHMENT = nil
    end
    print("[CUH-DBG] RegisterAttachments DONE  total registered = " .. table.Count(CustomUH.Attachments))
end

-- ============================================================
-- AMMO TYPE REGISTRATION
-- ============================================================
CustomUH.AmmoTypes = CustomUH.AmmoTypes or {}

function CustomUH.RegisterAmmo(ammoID, displayName, maxReserve)
    CustomUH.AmmoTypes[ammoID] = {
        Name = displayName or ammoID,
        Max = maxReserve or 999,
    }
end

function CustomUH.GetAmmoName(ammoID)
    local ammo = CustomUH.AmmoTypes[ammoID]
    return ammo and ammo.Name or ammoID
end

-- ============================================================
-- SAVE/LOAD SYSTEM
-- ============================================================
local SAVE_DIR = "cuh_saves"

function CustomUH.GetSavePath(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return nil end
    return SAVE_DIR .. "/" .. ply:SteamID64() .. ".json"
end

function CustomUH.LoadAttachments(wep, ply)
    if not IsValid(ply) then ply = wep:GetOwner() end
    if not IsValid(ply) then return end
    if not wep.Attachments then return end

    local path = CustomUH.GetSavePath(ply)
    if not path or not file.Exists(path, "DATA") then return end

    local data = util.JSONToTable(file.Read(path, "DATA") or "")
    if not data then return end

    local class = wep:GetClass()
    local saved = data[class]
    if not saved then return end

    local changed = false
    local tempData = {}

    for slot, index in pairs(saved) do
        slot = tonumber(slot) or slot
        if wep.Attachments[slot] then
            if index == 0 or (wep.Attachments[slot].atts and index <= #wep.Attachments[slot].atts) then
                wep.Attachments[slot].sel = index
                changed = true
                tempData[#tempData + 1] = { slot = slot, index = index }
            end
        end
    end

    if changed then
        wep:ApplyAttachments()

        -- Send saved state to client
        net.Start("CUH2_AttLoad")
            net.WriteEntity(wep)
            net.WriteUInt(#tempData, 8)
            for i = 1, #tempData do
                net.WriteUInt(tempData[i].slot, 8)
                net.WriteUInt(tempData[i].index, 8)
            end
        net.Send(ply)
    end
end

function CustomUH.SaveAttachments(wep, ply)
    if not IsValid(ply) then ply = wep:GetOwner() end
    if not IsValid(ply) then return end
    if not wep.Attachments then return end

    local path = CustomUH.GetSavePath(ply)
    if not path then return end

    local data = {}
    if file.Exists(path, "DATA") then
        data = util.JSONToTable(file.Read(path, "DATA") or "") or {}
    end

    local class = wep:GetClass()
    local current = {}
    local hasAttachments = false

    for slot, slotData in pairs(wep.Attachments) do
        if slotData.sel and slotData.sel > 0 then
            current[tostring(slot)] = slotData.sel
            hasAttachments = true
        else
            current[tostring(slot)] = 0
        end
    end

    if hasAttachments then
        data[class] = current
    else
        data[class] = nil
    end

    if not file.Exists(SAVE_DIR, "DATA") then
        file.CreateDir(SAVE_DIR)
    end

    file.Write(path, util.TableToJSON(data, true))
end

function CustomUH.SaveAllAttachments(ply)
    if not IsValid(ply) then return end
    for _, wep in pairs(ply:GetWeapons()) do
        if wep.Attachments then
            CustomUH.SaveAttachments(wep, ply)
        end
    end
end

-- ============================================================
-- NETWORKING
-- ============================================================
if SERVER then
    util.AddNetworkString("CUH2_AttSelect")
    util.AddNetworkString("CUH2_AttSync")
    util.AddNetworkString("CUH2_AttLoad")
    util.AddNetworkString("CUH2_AttList")
end

-- ============================================================
-- CUH2_AttList — server pushes the attachment filename list to
-- clients that don't have the addon mounted locally. The client
-- then include()s each (which works because we AddCSLuaFile'd
-- them at addon-load time on the server).
-- ============================================================
if SERVER then
    local function SendAttList(ply)
        net.Start("CUH2_AttList")
            net.WriteUInt(#CustomUH._attFiles, 8)
            for _, fn in ipairs(CustomUH._attFiles) do
                net.WriteString(fn)
            end
        net.Send(ply)
    end

    -- Send to a player as soon as they finish initializing
    hook.Add("PlayerInitialSpawn", "CUH2_SendAttList", function(ply)
        timer.Simple(1, function()
            if IsValid(ply) then SendAttList(ply) end
        end)
    end)
end

if CLIENT then
    net.Receive("CUH2_AttList", function()
        local n = net.ReadUInt(8)
        local list = {}
        for i = 1, n do
            list[i] = net.ReadString()
        end
        -- Only adopt the server's list if we didn't find any files
        -- locally — preserves the local file.Find result when the
        -- addon is mounted on the client (which is faster and works
        -- even before PlayerInitialSpawn fires).
        if not CustomUH._attFiles or #CustomUH._attFiles == 0 then
            CustomUH._attFiles = list
            CustomUH.RegisterAttachments()
        end
    end)
end

if SERVER then
    net.Receive("CUH2_AttSelect", function(len, ply)
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)

        print("[CUH-DBG] SERVER net CUH2_AttSelect  ply=" .. tostring(ply) .. "  wep=" .. tostring(wep)
            .. "  slot=" .. tostring(slot) .. "  index=" .. tostring(index))

        if not IsValid(wep) then
            print("[CUH-DBG]   ABORT: wep not valid")
            return
        end
        if wep:GetOwner() ~= ply then
            print("[CUH-DBG]   ABORT: owner mismatch  owner=" .. tostring(wep:GetOwner()))
            return
        end
        if not wep.Attachments or not wep.Attachments[slot] then
            print("[CUH-DBG]   ABORT: wep.Attachments or slot missing")
            return
        end

        -- Validate index
        if index > 0 and (not wep.Attachments[slot].atts or index > #wep.Attachments[slot].atts) then
            print("[CUH-DBG]   ABORT: index out of range")
            return
        end

        -- forceDefault check
        if index == 0 and wep.Attachments[slot].forceDefault
            and wep.Attachments[slot].default and wep.Attachments[slot].default > 0 then
            index = wep.Attachments[slot].default
            print("[CUH-DBG]   forceDefault snapped 0 -> " .. tostring(index))
        end

        wep.Attachments[slot].sel = index
        print("[CUH-DBG]   SERVER calling wep:ApplyAttachments() ...")
        wep:ApplyAttachments()
        print("[CUH-DBG]   SERVER calling CustomUH.SaveAttachments ...")
        CustomUH.SaveAttachments(wep, ply)

        -- Broadcast to all clients
        net.Start("CUH2_AttSync")
            net.WriteEntity(wep)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.Broadcast()
        print("[CUH-DBG]   SERVER broadcast CUH2_AttSync done")
    end)
end

if CLIENT then
    net.Receive("CUH2_AttSync", function()
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)

        print("[CUH-DBG] CLIENT net CUH2_AttSync  wep=" .. tostring(wep) .. "  slot=" .. tostring(slot) .. "  index=" .. tostring(index))

        if IsValid(wep) and wep.Attachments and wep.Attachments[slot] then
            wep.Attachments[slot].sel = index
            print("[CUH-DBG]   CLIENT calling wep:ApplyAttachments() ...")
            wep:ApplyAttachments()
        else
            print("[CUH-DBG]   ABORT: wep invalid or Attachments/slot missing")
        end
    end)

    net.Receive("CUH2_AttLoad", function()
        local wep = net.ReadEntity()
        local count = net.ReadUInt(8)

        if not IsValid(wep) or not wep.Attachments then return end

        for i = 1, count do
            local slot = net.ReadUInt(8)
            local index = net.ReadUInt(8)
            if wep.Attachments[slot] then
                wep.Attachments[slot].sel = index
            end
        end
        wep:ApplyAttachments()
    end)
end

-- ============================================================
-- HOOKS — auto save/load
-- ============================================================

-- Load on weapon deploy
hook.Add("WeaponDeployed", "CUH2_LoadOnDeploy", function(wep, ply)
    if not IsValid(wep) or not IsValid(ply) then return end
    if not wep.Attachments then return end
    if SERVER then
        timer.Simple(0.1, function()
            if IsValid(wep) and IsValid(ply) then
                CustomUH.LoadAttachments(wep, ply)
            end
        end)
    end
end)

-- Save on player death
hook.Add("PlayerDeath", "CUH2_SaveOnDeath", function(ply)
    if IsValid(ply) then CustomUH.SaveAllAttachments(ply) end
end)

-- Save on disconnect
hook.Add("PlayerDisconnected", "CUH2_SaveOnDisconnect", function(ply)
    if IsValid(ply) then CustomUH.SaveAllAttachments(ply) end
end)

-- ============================================================
-- INIT — register immediately at addon load, plus a Think fallback
-- ============================================================
-- Call RegisterAttachments() right now (the file list was captured
-- at addon-load time, AddCSLuaFile ran on the server during addon
-- load, and local clients have the lua files mounted). This avoids
-- the previous 1-frame delay where opening the menu in the very
-- first tick could see an empty CustomUH.Attachments table.
-- ============================================================
CustomUH.RegisterAttachments()

-- Register default ammo types
CustomUH.RegisterAmmo("ar2", "7.62mm", 300)
CustomUH.RegisterAmmo("smg1", "9mm", 240)
CustomUH.RegisterAmmo("pistol", ".45 ACP", 150)
CustomUH.RegisterAmmo("357", ".357 Magnum", 60)
CustomUH.RegisterAmmo("buckshot", "12 Gauge", 80)
CustomUH.RegisterAmmo("SniperPenetratedRound", ".50 BMG", 60)
CustomUH.RegisterAmmo("RPG_Round", "RPG", 20)

-- Think fallback: re-register on the first Think in case the early
-- call ran before the addon's lua files were fully available on the
-- client (rare, but harmless — RegisterAttachments is idempotent).
hook.Add("Think", "CUH2_Register", function()
    if CustomUH._registered then return end
    CustomUH._registered = true
    CustomUH.RegisterAttachments()
end)
