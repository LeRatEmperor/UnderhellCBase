-- sh_customuh.lua
-- CustomUH Attachment System v2 — Core
-- ============================================================
-- TFA-adjacent architecture, NOT TFA-compatible.
-- Own namespace (CustomUH), own folder (customuh_attachments/),
-- own networking. Uses TFA icon assets temporarily.
--
-- CONFLICT-FREE: All hooks, network strings, and convars use
-- unique names that won't collide with the old attachment system
-- or any other addon.
-- ============================================================

AddCSLuaFile()

-- ============================================================
-- NAMESPACE
-- ============================================================
CustomUH = CustomUH or {}
CustomUH.Attachments = CustomUH.Attachments or {}
CustomUH.AmmoTypes = CustomUH.AmmoTypes or {}
CustomUH.Version = "2.0"

-- UI color scheme (TFA-adjacent)
CustomUH.Colors = {
    Background    = Color(30, 30, 30, 240),
    Panel         = Color(40, 40, 40, 240),
    Border        = Color(60, 60, 60, 255),
    Text          = Color(220, 220, 220, 255),
    TextBright     = Color(255, 255, 255, 255),
    TextDim        = Color(150, 150, 150, 255),
    Accent         = Color(0, 150, 255, 255),
    AccentDim      = Color(0, 80, 140, 200),
    Selected       = Color(0, 200, 100, 60),
    Hover          = Color(255, 255, 255, 20),
    Separator      = Color(80, 80, 80, 255),
    StatPositive   = Color(100, 255, 100, 255),
    StatNegative   = Color(255, 100, 100, 255),
    StatNeutral    = Color(200, 200, 200, 255),
}

-- Unique prefix for all hooks, network strings, etc.
-- Uses "CUH2_" to avoid conflicts with the old "CustomUH_" prefix
local PREFIX = "CUH2_"

-- Menu key convar (guard against double-registration)
if not ConVarExists("customuh_menu_key") then
    CreateClientConVar("customuh_menu_key", "c", true, false, "Key to open weapon customization")
end

-- ============================================================
-- ATTACHMENT REGISTRATION
-- ============================================================
function CustomUH.RegisterAttachments()
    local files = file.Find("customuh_attachments/*.lua", "LUA")
    for _, filename in ipairs(files) do
        ATTACHMENT = {}
        ATTACHMENT.Base = "customuh_base"
        local path = "customuh_attachments/" .. filename
        AddCSLuaFile(path)

        -- Wrap in pcall so one bad attachment doesn't break all the others
        local ok, err = pcall(include, path)
        if not ok then
            print("[CustomUH] Error loading attachment " .. filename .. ": " .. tostring(err))
        end

        if ATTACHMENT and ATTACHMENT.Name then
            local id = string.StripExtension(filename)
            ATTACHMENT.ID = id
            CustomUH.Attachments[id] = ATTACHMENT
        end
        ATTACHMENT = nil
    end
end

-- ============================================================
-- AMMO TYPE REGISTRATION
-- ============================================================
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

function CustomUH.GetAmmoMax(ammoID)
    local ammo = CustomUH.AmmoTypes[ammoID]
    return ammo and ammo.Max or 999
end

-- ============================================================
-- DEFAULT ATTACHMENT SYSTEM
-- ============================================================
-- A slot can define a `default` index. When no attachment is
-- selected (sel == nil or 0), the default is auto-applied.
--
-- The player can still explicitly select "None" (index 0) —
-- but if the slot has `forceDefault = true`, selecting "None"
-- will snap back to the default instead.
--
-- Usage in weapon:
--   SWEP.Attachments = {
--       [1] = { atts = { "opt_red", "opt_acog" }, default = 1 },
--       [2] = { atts = { "mag_fast", "mag_ext" } },  -- no default
--   }
--
-- Usage with forceDefault:
--   [1] = { atts = { "opt_red" }, default = 1, forceDefault = true },
-- ============================================================


-- ============================================================
-- ADDCSLUAFILE FOR SUB-MODULES (sends to client)
-- ============================================================
AddCSLuaFile("customuh/sh_swep_methods.lua")
AddCSLuaFile("customuh/sh_velements.lua")
AddCSLuaFile("customuh/sh_welements.lua")
AddCSLuaFile("customuh/sh_bodygroups.lua")
AddCSLuaFile("customuh/sh_att_ammo.lua")
AddCSLuaFile("customuh/sh_att_save.lua")
AddCSLuaFile("customuh/cl_att_ui.lua")
AddCSLuaFile("customuh/cl_att_scope.lua")

-- ============================================================
-- SWEP METHOD REGISTRATION — deferred until weapon base is loaded
-- ============================================================
-- DESIGN RATIONALE
-- ----------------
-- The sub-modules in lua/customuh/ define `function SWEP:Foo()` at
-- file scope. In Lua, `function SWEP:Foo()` desugars to
-- `SWEP.Foo = function(self, ...) ... end`, which requires SWEP to
-- be a non-nil table at the point the assignment runs.
--
-- The OLD approach did `_G.SWEP = base` then `include(path)`. This
-- is fragile: GMod's include() does NOT guarantee that the included
-- file runs in the caller's environment, so `_G.SWEP` set here may
-- not be visible to the included file. Console errors of the form
-- "attempt to index global 'SWEP' (a nil value)" result.
--
-- The NEW approach uses CompileFile() + setfenv() to construct a
-- dedicated environment for the included file in which `SWEP` is
-- guaranteed to be the registered base table, with the real _G as
-- a metatable fallback for all other globals (hook, net, CustomUH,
-- util, etc.) and a __newindex metamethod that propagates any new
-- globals the file creates back into _G. This is bulletproof
-- regardless of:
--   * what the weapon base class is named,
--   * which GMod version's include() path/env semantics are in use,
--   * whether SWEP is treated as a global or upvalue by the compiler.
-- ============================================================

-- Candidate base class names. The current file registers as
-- `weapon_custom_uh_base` (filename `weapon_custom_uh_base.lua`).
-- The user has historically renamed the base between `weapon_custom_uh_base`
-- and `weapon_custom_uhc_base` (with/without 'c'); we try both so a future
-- rename does not silently break the patcher again.
local CUH_BASE_CANDIDATES = {
    "weapon_custom_uh_base",
    "weapon_custom_uhc_base",
}

-- Compiles the file at `path` (relative to lua/) and runs it inside an
-- environment where SWEP = `base`. Returns true on success, false on error.
local function IncludeWithSWEP(path, base)
    local fn = CompileFile(path)
    if not fn then
        ErrorNoHalt("[CustomUH] CompileFile failed (file not found?): " .. path .. "\n")
        return false
    end

    -- Build an environment with SWEP pre-bound to the base table.
    -- __index    = _G  -> all normal globals (hook, net, CustomUH, util, ...)
    --                are accessible via metamethod fallback.
    -- __newindex = _G  -> any new global the file creates (e.g. a stray
    --                `function Foo()` at file scope) lands in the real _G,
    --                so the file behaves like a normal top-level Lua chunk.
    local env = setmetatable({ SWEP = base }, {
        __index = _G,
        __newindex = function(_, k, v) _G[k] = v end,
    })

    -- setfenv on a Lua-function (the result of CompileFile) is supported
    -- by LuaJIT and Lua 5.1, which is what GMod uses.
    setfenv(fn, env)

    local ok, err = pcall(fn)
    if not ok then
        ErrorNoHalt("[CustomUH] Error while running " .. path .. ": " .. tostring(err) .. "\n")
    end
    return ok
end

local function PatchCustomUHBase()
    -- Find the registered base class table. weapons.GetStored returns the
    -- SAME table the engine uses for instances of the class, so adding
    -- methods to it propagates to every derived weapon (gun/shotty/melee/M8A1)
    -- via GMod's normal SWEP metatable inheritance.
    local base
    for _, className in ipairs(CUH_BASE_CANDIDATES) do
        base = weapons.GetStored(className)
        if base then break end
    end
    if not base then return end          -- weapons not loaded yet; retry next Think
    if base._cuh_methods_patched then return end

    -- IMPORTANT: do NOT set _cuh_methods_patched = true yet.
    -- If any include fails, we want to be able to retry on the next Think
    -- frame. Only mark as patched once every include has succeeded.

    local allOk = true

    allOk = IncludeWithSWEP("customuh/sh_swep_methods.lua", base) and allOk
    allOk = IncludeWithSWEP("customuh/sh_velements.lua",     base) and allOk
    allOk = IncludeWithSWEP("customuh/sh_welements.lua",     base) and allOk
    allOk = IncludeWithSWEP("customuh/sh_bodygroups.lua",    base) and allOk
    allOk = IncludeWithSWEP("customuh/sh_att_ammo.lua",      base) and allOk
    allOk = IncludeWithSWEP("customuh/sh_att_save.lua",      base) and allOk

    if CLIENT then
        allOk = IncludeWithSWEP("customuh/cl_att_scope.lua", base) and allOk
        allOk = IncludeWithSWEP("customuh/cl_att_ui.lua",    base) and allOk
    end

    if allOk then
        base._cuh_methods_patched = true
        hook.Remove("Think", "CUH2_PatchBase")
    else
        -- One or more sub-modules failed. Leave the hook installed so we
        -- retry on the next Think frame. Logged via ErrorNoHalt above.
        -- To prevent infinite retry spam in the console, hard-cap attempts.
        base._cuh_patch_attempts = (base._cuh_patch_attempts or 0) + 1
        if base._cuh_patch_attempts >= 60 then
            -- ~1 second of Think frames at 60fps; give up to avoid log spam.
            ErrorNoHalt("[CustomUH] Patching failed after "
                .. base._cuh_patch_attempts .. " attempts. Giving up.\n")
            base._cuh_methods_patched = true   -- stop retrying
            hook.Remove("Think", "CUH2_PatchBase")
        end
    end
end

hook.Add("Think", "CUH2_PatchBase", PatchCustomUHBase)

-- ============================================================
-- NETWORKING (conflict-free)
-- ============================================================
local netStrings = {
    [PREFIX .. "AttSelect"] = true,
    [PREFIX .. "AttSync"]   = true,
    [PREFIX .. "AttLoad"]   = true,
}

-- Register network strings (server only)
-- pcall guards against double-registration
if SERVER then
    for name, _ in pairs(netStrings) do
        pcall(util.AddNetworkString, name)
    end
end

if SERVER then
    net.Receive(PREFIX .. "AttSelect", function(len, ply)
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)

        if not IsValid(wep) then return end
        if wep:GetOwner() ~= ply then return end
        if not wep.Attachments or not wep.Attachments[slot] then return end

        if index > 0 and (not wep.Attachments[slot].atts or index > #wep.Attachments[slot].atts) then
            return
        end

        -- forceDefault check
        if index == 0 and wep.Attachments[slot].forceDefault
            and wep.Attachments[slot].default and wep.Attachments[slot].default > 0 then
            index = wep.Attachments[slot].default
        end

        wep.Attachments[slot].sel = index
        wep:ApplyAttachments()
        CustomUH.SaveAttachments(wep, ply)

        net.Start(PREFIX .. "AttSync")
            net.WriteEntity(wep)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.Broadcast()
    end)
end

if CLIENT then
    net.Receive(PREFIX .. "AttSync", function()
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)

        if IsValid(wep) and wep.Attachments and wep.Attachments[slot] then
            wep.Attachments[slot].sel = index
            wep:ApplyAttachments()
        end
    end)

    net.Receive(PREFIX .. "AttLoad", function()
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
-- INIT — register on first Think (unique hook name)
-- ============================================================
hook.Add("Think", PREFIX .. "Register", function()
    if not CustomUH._registered then
        CustomUH._registered = true
        CustomUH.RegisterAttachments()

        CustomUH.RegisterAmmo("ar2", "7.62mm", 300)
        CustomUH.RegisterAmmo("smg1", "9mm", 240)
        CustomUH.RegisterAmmo("pistol", ".45 ACP", 150)
        CustomUH.RegisterAmmo("357", ".357 Magnum", 60)
        CustomUH.RegisterAmmo("buckshot", "12 Gauge", 80)
        CustomUH.RegisterAmmo("SniperPenetratedRound", ".50 BMG", 60)
        CustomUH.RegisterAmmo("RPG_Round", "RPG", 20)
    end
end)
