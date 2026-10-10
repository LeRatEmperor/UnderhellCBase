#!/usr/bin/env python3
"""
cuh_sim_driver.py
============================================================
Loads the actual CUH source files into a Lua VM (via lupa),
mocks every GMod global they touch, then runs the simulator
test harness (cuh_sim_harness.lua) to exercise the
SetAttachment -> ApplyAttachments pipeline.

The harness reproduces the EXACT logic of:
  - lua/autorun/sh_cuh_attachments.lua      (CustomUH.Attachments registration)
  - lua/weapons/weapon_cuh_base_gun.lua      (InitStatCache / SetStat /
                                              ApplyAttachments / SetAttachment)
  - lua/weapons/weapon_m8a1_scotia.lua       (SWEP table: ViewModelElements,
                                              Attachments, stats)
  - lua/cuh_attachments/xm8_*.lua            (all attachment files)

It does NOT mock rendering (no ClientsideModel).  Instead, every
element's "_csModel" is replaced with a Lua table that records its
`model` field at creation time, so we can assert on what model
WAS passed to ClientsideModel() — which is what actually drives
the visible attachment.
"""

import os
import sys
import traceback
from lupa import LuaRuntime

ROOT = "/home/z/my-project/download/custom_uh_base"
LUA  = "/home/z/my-project/download/custom_uh_base/lua"
HARNESS = "/home/z/my-project/scripts/cuh_sim_harness.lua"

# Local preprocessor (handles GMod LuaJIT-isms like `continue`)
sys.path.insert(0, "/home/z/my-project/scripts")
from cuh_preprocess import preprocess as _preprocess


def read(path):
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        return f.read()


def main():
    lua = LuaRuntime(unpack_returned_tuples=True)

    # ------------------------------------------------------------------
    # 1.  Build a mock GMod environment inside the Lua VM.
    #     Every function the CUH code touches must exist (even if it's
    #     a no-op), otherwise the include will crash with attempt to
    #     index nil.
    # ------------------------------------------------------------------
    lua.execute(r"""
        -- ============================================================
        -- MOCK GARRY'S MOD API  (subset that CUH actually touches)
        -- ============================================================
        CLIENT = true
        SERVER = false
        game   = { SinglePlayer = function() return false end }

        -- Color / Sound / Vector / Angle just become marker tables
        Color   = function(r,g,b,a) return {__type="Color", r=r, g=g, b=b, a=a} end
        Sound   = function(s) return {__type="Sound", s=s} end
        Vector  = function(x,y,z) return {__type="Vector", x=x or 0, y=y or 0, z=z or 0} end
        Angle   = function(p,y,r) return {__type="Angle", p=p or 0, y=y or 0, r=r or 0} end
        Material= function(p) return {__type="Material", p=p, IsError=function() return false end} end
        RENDERGROUP_VIEWMODEL = 1
        RENDERGROUP_OPAQUE    = 2

        -- String helpers (GMod extensions to standard string lib)
        string.StripExtension = function(s)
            -- Find a literal "." (NOT a pattern).  Use plain=true.
            local i = string.find(s, ".", 1, true)
            if i then return string.sub(s, 1, i-1) end
            return s
        end

        -- Table helpers
        table.Copy  = function(t)
            if type(t) ~= "table" then return t end
            local r = {}
            for k, v in pairs(t) do r[k] = table.Copy(v) end
            return r
        end
        table.Count = function(t)
            local n = 0
            for _ in pairs(t) do n = n + 1 end
            return n
        end
        table.insert = table.insert or function(t, v) t[#t+1] = v end
        table.Copy   = table.Copy

        -- File API — reads from the real on-disk files in /home/z/my-project
        -- so the include() of an attachment file actually loads its source.
        -- 'LUA' path is treated as: <LUA_ROOT>/<path>
        LUA_ROOT = "/home/z/my-project/download/custom_uh_base/lua"
        -- _FILE_LISTING is a Python-injected {dir -> [filename...]} table
        -- so we don't need io.popen (which lupa's sandbox doesn't allow).
        _FILE_LISTING = _FILE_LISTING or {}
        file = {
            Find = function(pattern, mount)
                -- pattern like "cuh_attachments/*.lua"
                local dir, glob = string.match(pattern, "^(.-)/([^/]+)$")
                if not dir then return {}, {} end
                local listing = _FILE_LISTING[dir]
                if not listing then return {}, {} end
                local out = {}
                for _, fn in ipairs(listing) do
                    if glob == "*.lua" and string.match(fn, "%.lua$") then
                        table.insert(out, fn)
                    end
                end
                table.sort(out)
                return out
            end,
            Exists = function(path, mount)
                local full = LUA_ROOT .. "/" .. path
                local f = io.open(full, "r")
                if f then f:close() return true end
                return false
            end,
            Read = function(path, mount)
                local full = LUA_ROOT .. "/" .. path
                local f = io.open(full, "rb")
                if not f then return nil end
                local s = f:read("*a")
                f:close()
                return s
            end,
            Write = function(path, data)
                -- pretend; track in a side-table for assertions
                _FILE_WRITES = _FILE_WRITES or {}
                _FILE_WRITES[path] = data
            end,
            CreateDir = function(path) end,
        }

        -- `include` is the GMod shared-file loader.  We use Lua's loadfile
        -- to read & compile the file from disk, then run it in the global
        -- environment so ATTACHMENT / SWEP / CustomUH globals propagate.
        --
        -- SOURCE PATCHES:  GMod uses LuaJIT (5.1 semantics); some CUH code
        -- reassigns for-loop variables (illegal in 5.4).  We patch the
        -- known pattern `slot = tonumber(slot) or slot` to a shadowing
        -- local declaration so it runs under Lua 5.4 too.  Behavior is
        -- identical to LuaJIT.
        local _PATCHES = {
            -- file pattern (substring match), old text, new text
            { "sh_cuh_attachments.lua",
              "slot = tonumber(slot) or slot",
              "local slot = tonumber(slot) or slot" },
        }
        function include(path)
            local full = LUA_ROOT .. "/" .. path
            local f = io.open(full, "r")
            if not f then
                error("include: file not found: " .. full)
            end
            local src = f:read("*a")
            f:close()
            -- Plain-text find/replace (string.gsub treats ( ) etc as
            -- pattern metacharacters, which breaks our patch strings).
            local function plainReplace(s, old, new)
                local i = string.find(s, old, 1, true)
                if not i then return s, 0 end
                local j = i + #old - 1
                return s:sub(1, i-1) .. new .. s:sub(j+1), 1
            end
            for _, p in ipairs(_PATCHES) do
                if string.find(path, p[1], 1, true) then
                    local new_src, n = plainReplace(src, p[2], p[3])
                    print("[SIM PATCH]  " .. path .. "  matched '" .. p[1] .. "'  replaced " .. tostring(n) .. " occurrence(s)")
                    src = new_src
                end
            end
            local chunk, err = load(src, "@" .. path)
            if not chunk then
                error("include: compile error in " .. path .. ": " .. tostring(err))
            end
            return chunk()
        end

        -- AddCSLuaFile is a no-op (server-only optimization)
        function AddCSLuaFile(path) end

        -- net library stubs
        net = {
            Start    = function() end,
            WriteEntity = function(e) end,
            WriteUInt = function(n, bits) end,
            WriteString = function(s) end,
            Send     = function(p) end,
            SendToServer = function() end,
            Broadcast = function() end,
            Receive  = function(name, fn) end,
        }
        util = {
            AddNetworkString = function(s) end,
            JSONToTable = function(s)
                -- Minimal: assume the simulator doesn't actually need this
                return nil
            end,
            TableToJSON = function(t, pretty)
                return "{}"
            end,
            TraceHull = function(t) return {Hit=false} end,
        }

        -- timer
        timer = {
            Simple = function(delay, fn) end,
            Exists = function(name) return false end,
            Remove = function(name) end,
            Create = function(name, delay, reps, fn) end,
        }

        -- hook (collect handlers but never invoke them — we drive the
        -- tests directly, we don't run a real Think loop)
        _HOOKS = {}
        hook = {
            Add = function(name, id, fn)
                _HOOKS[name] = _HOOKS[name] or {}
                _HOOKS[name][id] = fn
            end,
            Remove = function(name, id)
                if _HOOKS[name] then _HOOKS[name][id] = nil end
            end,
        }

        -- ConVar stubs
        function ConVarExists(name) return false end
        function CreateClientConVar(name, default, save, user, help)
            return {
                GetString = function() return default end,
                GetInt    = function() return tonumber(default) or 0 end,
                GetBool   = function() return default == "1" or default == true end,
            }
        end

        -- ClientsideModel — the SIMULATOR'S KEY WITNESS.
        -- Instead of creating an actual GMod entity, we make a small Lua
        -- table that records the model string it was created with, plus
        -- no-op methods for everything InitVElements/DrawVElements call.
        -- This lets us assert "the barrel _csModel was created with the
        -- Hvy-B model path, not the default one".
        _CSMODEL_LOG = {}
        function ClientsideModel(model, group)
            local cs = {
                __type    = "ClientsideModel",
                __model   = model,
                __group   = group,
                __removed = false,
                SetNoDraw      = function(self, b) end,
                SetSkin        = function(self, s) self.skin = s end,
                SetBodygroup   = function(self, bg, val) self.bodygroups = self.bodygroups or {}; self.bodygroups[bg] = val end,
                SetMaterial    = function(self, m) self.material = m end,
                SetParent      = function(self, p) self.parent = p end,
                SetPos         = function(self, v) end,
                SetAngles      = function(self, a) end,
                SetModelScale  = function(self, s, t) end,
                AddEffects     = function(self, e) end,
                RemoveEffects  = function(self, e) end,
                DrawModel      = function(self) end,
                Remove         = function(self) self.__removed = true end,
                IsValid        = function(self) return not self.__removed end,
            }
            table.insert(_CSMODEL_LOG, cs)
            return cs
        end
        function IsValid(obj)
            if obj == nil then return false end
            if type(obj) == "table" then
                if obj.__removed == true then return false end
                if obj.IsValid then return obj:IsValid() end
                return true
            end
            return true
        end

        -- istable / isfunction / isangle / isvector / isstring / isnumber
        function istable(t)    return type(t) == "table" end
        function isfunction(f) return type(f) == "function" end
        function isstring(s)   return type(s) == "string" end
        function isnumber(n)   return type(n) == "number" end
        function isangle(a)    return type(a) == "table" and a.__type == "Angle" end
        function isvector(v)   return type(v) == "table" and v.__type == "Vector" end

        -- concommand
        concommand = { Add = function(name, fn) end }

        -- surface
        surface = {
            PlaySound = function(s) end,
            SetDrawColor = function() end,
            SetMaterial = function() end,
            DrawTexturedRect = function() end,
            DrawOutlinedRect = function() end,
        }
        draw = {
            RoundedBox = function() end,
            RoundedBoxEx = function() end,
            SimpleText = function() end,
        }
        vgui = { Create = function() return {} end }

        -- math
        math.Approach = math.Approach or function(cur, target, delta)
            if cur < target then return math.min(cur + delta, target) end
            if cur > target then return math.max(cur - delta, target) end
            return cur
        end
        math.random = math.random

        -- print helper to keep things aligned
        _SIM_LOG = {}
        local _orig_print = print
        function print(...)
            local parts = {}
            for i = 1, select("#", ...) do
                local v = select(i, ...)
                if type(v) == "table" then
                    if v.__type == "Color" then
                        parts[i] = string.format("Color(%d,%d,%d,%d)", v.r, v.g, v.b, v.a)
                    elseif v.__type == "Sound" then
                        parts[i] = "Sound(" .. tostring(v.s) .. ")"
                    elseif v.__type == "Vector" then
                        parts[i] = string.format("Vec(%.2f,%.2f,%.2f)", v.x, v.y, v.z)
                    elseif v.__type == "Angle" then
                        parts[i] = string.format("Ang(%.2f,%.2f,%.2f)", v.p, v.y, v.r)
                    elseif v.__type == "ClientsideModel" then
                        parts[i] = "CS(" .. tostring(v.__model) .. ")"
                    else
                        parts[i] = tostring(v)
                    end
                else
                    parts[i] = tostring(v)
                end
            end
            local line = table.concat(parts, "\t")
            table.insert(_SIM_LOG, line)
            _orig_print(line)
        end

        -- Defines
        DEFINE_BASECLASS = function(name) _BASECLASS = name end
        function weapons_GetStored(name) return _WEAPON_CLASSES and _WEAPON_CLASSES[name] end
        weapons = { GetStored = weapons_GetStored }

        -- SWEP / hook stubs
        -- GMod's SWEP loader implicitly initializes SWEP.Primary and
        -- SWEP.Secondary to empty tables when they're not declared by
        -- the weapon class.  The CUH parent bases set fields on
        -- SWEP.Primary.Sound etc. without ever declaring
        -- SWEP.Primary = {}, so we MUST pre-initialize it here.
        SWEP = {
            Primary   = {},
            Secondary = {},
        }
        function SWEP_Inject(tbl)
            for k, v in pairs(tbl) do SWEP[k] = v end
        end

        print("[SIM] mock GMod environment ready")
    """)

    # ------------------------------------------------------------------
    # 1.5 Pre-compute the cuh_attachments file listing and inject it
    #     into Lua as _FILE_LISTING (so file.Find doesn't need io.popen).
    #     IMPORTANT: convert the Python list to a real Lua table because
    #     lupa's auto-wrapping of Python lists is 0-indexed and confuses
    #     Lua's ipairs (which expects 1-indexed tables).
    # ------------------------------------------------------------------
    listing_dir = os.path.join(LUA, "cuh_attachments")
    listing = []
    if os.path.isdir(listing_dir):
        for fn in sorted(os.listdir(listing_dir)):
            if fn.endswith(".lua"):
                listing.append(fn)
    # Build the listing as a Lua table directly (1-indexed via t[i]=v)
    lualisting = lua.table()
    for i, fn in enumerate(listing, start=1):
        lualisting[i] = fn
    _wrapper = lua.table()
    _wrapper["cuh_attachments"] = lualisting
    lua.globals()._FILE_LISTING = _wrapper
    print(f"[SIM] injected _FILE_LISTING with {len(listing)} attachment files")

    # ------------------------------------------------------------------
    # 1.6  Pre-process every CUH source file ONCE (in Python) and stash
    #      the patched source in a {path -> patched_source} dict that
    #      the Lua include() can read.  This avoids needing to do the
    #      `continue` -> `goto` rewrite inside Lua itself.
    # ------------------------------------------------------------------
    PATCHED = {}
    for relpath in [
        "autorun/sh_cuh_attachments.lua",
        "weapons/weapon_cuh_base_gun.lua",
        "weapons/weapon_m8a1_scotia.lua",
        "weapons/weapon_custom_uh_base_gun.lua",
        "weapons/weapon_custom_uh_base.lua",
        "weapons/weapon_custom_uh_base_melee.lua",
        "weapons/weapon_custom_uh_base_shotty.lua",
        "autorun/cl_cuh_ui.lua",
    ]:
        full = os.path.join(LUA, relpath)
        if os.path.exists(full):
            src = read(full)
            patched = _preprocess(src)
            PATCHED[relpath] = patched
    # Also patch all attachment files
    att_dir = os.path.join(LUA, "cuh_attachments")
    if os.path.isdir(att_dir):
        for fn in sorted(os.listdir(att_dir)):
            if fn.endswith(".lua"):
                full = os.path.join(att_dir, fn)
                src = read(full)
                patched = _preprocess(src)
                PATCHED["cuh_attachments/" + fn] = patched

    # Inject into Lua VM
    _patched_lua = lua.table()
    for k, v in PATCHED.items():
        _patched_lua[k] = v
    lua.globals()._PATCHED_SOURCES = _patched_lua
    print(f"[SIM] pre-patched {len(PATCHED)} source files")

    # ------------------------------------------------------------------
    # 1.7  Override the Lua-side include() to use the patched sources if
    #      available, else fall back to reading the file from disk.
    # ------------------------------------------------------------------
    lua.execute(r"""
        function include(path)
            local src = _PATCHED_SOURCES and _PATCHED_SOURCES[path]
            if not src then
                local full = LUA_ROOT .. "/" .. path
                local f = io.open(full, "r")
                if not f then
                    error("include: file not found: " .. full)
                end
                src = f:read("*a")
                f:close()
            end
            local chunk, err = load(src, "@" .. path)
            if not chunk then
                error("include: compile error in " .. path .. ": " .. tostring(err))
            end
            return chunk()
        end
    """)
    print("[SIM] include() now prefers patched sources")
    #       a) sh_cuh_attachments.lua  (autorun)
    #       b) weapon_cuh_base_gun.lua  (parent of weapon_m8a1_scotia)
    #       c) weapon_m8a1_scotia.lua   (the actual XM8 weapon)
    # ------------------------------------------------------------------
    print("\n[SIM] loading sh_cuh_attachments.lua ...")
    lua.execute(f"include('autorun/sh_cuh_attachments.lua')")

    print("\n[SIM] loading weapons/weapon_cuh_base_gun.lua ...")
    # weapon_cuh_base_gun.lua uses DEFINE_BASECLASS / SWEP — these are
    # already stubbed.  The file's top-level statements define SWEP.*
    # fields and functions; we capture SWEP into a global _CUH_BASE.
    lua.execute(r"""
        -- GMod implicitly initializes SWEP.Primary and SWEP.Secondary to
        -- empty tables for every weapon class.  CUH's parent bases never
        -- declare `SWEP.Primary = {}` themselves — they just start setting
        -- SWEP.Primary.Sound etc. — so we MUST pre-init them here.
        SWEP = {
            Primary   = {},
            Secondary = {},
        }
        DEFINE_BASECLASS("weapon_custom_uh_base_gun")
        SWEP.Base = "weapon_custom_uh_base_gun"
        include('weapons/weapon_cuh_base_gun.lua')
        _CUH_BASE = SWEP
        print("[SIM] _CUH_BASE methods:")
        for k, v in pairs(_CUH_BASE) do
            if type(v) == "function" then
                print("  " .. k)
            end
        end
        print("[SIM DBG] _CUH_BASE.Primary keys:")
        if _CUH_BASE.Primary then
            for k, v in pairs(_CUH_BASE.Primary) do
                print("    " .. tostring(k) .. " = " .. tostring(v))
            end
        end
    """)

    print("\n[SIM] loading weapons/weapon_m8a1_scotia.lua ...")
    lua.execute(r"""
        print("[SIM DBG] _CUH_BASE.Primary = " .. tostring(_CUH_BASE and _CUH_BASE.Primary))
        print("[SIM DBG] _CUH_BASE.Secondary = " .. tostring(_CUH_BASE and _CUH_BASE.Secondary))
        print("[SIM DBG] _CUH_BASE keys (non-function):")
        if _CUH_BASE then
            for k, v in pairs(_CUH_BASE) do
                if type(v) ~= "function" then
                    print("    " .. tostring(k) .. " = " .. tostring(v))
                end
            end
        end
        -- Mimic GMod SWEP inheritance: start the child SWEP with a deep
        -- copy of the parent class table (so child.Primary already has
        -- the parent's defaults; child overrides specific fields on top).
        SWEP = table.Copy(_CUH_BASE)
        print("[SIM DBG] after copy: SWEP.Primary = " .. tostring(SWEP.Primary))
        DEFINE_BASECLASS("weapon_cuh_base_gun")
        SWEP.Base = "weapon_cuh_base_gun"
        include('weapons/weapon_m8a1_scotia.lua')
        _WEAPON = SWEP
        print("[SIM] _WEAPON class = " .. tostring(_WEAPON.PrintName))
        print("[SIM]   ViewModelElements keys:")
        for k, v in pairs(_WEAPON.ViewModelElements or {}) do
            print("    " .. k .. "  ->  " .. tostring(v.model))
        end
        print("[SIM]   Attachments slots:")
        for i, s in ipairs(_WEAPON.Attachments or {}) do
            local atts = ""
            for _, a in ipairs(s.atts or {}) do atts = atts .. a .. " " end
            print(string.format("    slot %d  atts=[%s]  default=%s  sel=%s",
                i, atts, tostring(s.default), tostring(s.sel)))
        end
    """)

    # ------------------------------------------------------------------
    # 3.  Run the test harness — instantiate a SWEP instance, call
    #     SetAttachment, inspect the resulting state.
    # ------------------------------------------------------------------
    print("\n[SIM] running harness ...")
    lua.execute(read(HARNESS))

    # Harness sets globals _RESULT_MODEL, _RESULT_STATS, _RESULT_PASS
    model  = lua.globals()._RESULT_MODEL
    stats  = lua.globals()._RESULT_STATS
    passed = lua.globals()._RESULT_PASS
    fails  = lua.globals()._RESULT_FAILS

    print("\n" + "=" * 70)
    print(f"[SIM] RESULT  model={model}  pass={passed}  fails={fails}")
    print("=" * 70)
    return 0 if bool(passed) else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as e:
        traceback.print_exc()
        sys.exit(2)
