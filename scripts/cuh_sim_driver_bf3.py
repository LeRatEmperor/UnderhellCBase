#!/usr/bin/env python3
"""cuh_sim_driver_bf3.py — Drive the BF3 CUH port simulator.

Loads:
  - The REAL CUH source (sh_cuh_attachments.lua + weapon_cuh_base_gun.lua)
  - The REAL weapon_cuh_base_gun dependencies (parent base classes loaded via include)
  - The ported weapon file (weapon_cuh_bf3_m416.lua)
  - All 9 ported attachments (cuh_attachments/bf3_*.lua)
  - The m416 model's $sequence list (parsed from the decompiled .qc)

Then runs scripts/cuh_sim_harness_bf3.lua to validate the port.
"""
import os, sys, re, struct
from pathlib import Path
from lupa import LuaRuntime

CUH_ROOT   = "/home/z/my-project/download/custom_uh_base"
PORT_ROOT  = "/home/z/my-project/cuh_port"
DECOMP_DIR = "/home/z/my-project/decompile/anim_audit_all/m416"
SYS_PATHS = "/home/z/my-project/scripts"

sys.path.insert(0, SYS_PATHS)
from cuh_preprocess import preprocess as _preprocess


def read(path):
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        return f.read()


def parse_sequences_from_qc(qc_path):
    """Parse $sequence names from a decompiled QC file."""
    text = read(qc_path)
    seqs = re.findall(r'^\$sequence\s+"([^"]+)"', text, re.MULTILINE)
    return seqs


def main():
    lua = LuaRuntime(unpack_returned_tuples=True)

    # ------------------------------------------------------------------
    # 1. Mock GMod environment
    # ------------------------------------------------------------------
    lua.execute(r"""
        CLIENT = true
        SERVER = false
        game   = { SinglePlayer = function() return false end }

        Color   = function(r,g,b,a) return {__type="Color", r=r, g=g, b=b, a=a} end
        Sound   = function(s) return {__type="Sound", s=s} end
        Vector  = function(x,y,z) return {__type="Vector", x=x or 0, y=y or 0, z=z or 0} end
        Angle   = function(p,y,r) return {__type="Angle", p=p or 0, y=y or 0, r=r or 0} end
        Material= function(p, opt) return {__type="Material", p=p, opt=opt, IsError=function() return false end} end
        RENDERGROUP_VIEWMODEL = 1
        RENDERGROUP_OPAQUE    = 2

        string.StripExtension = function(s)
            local i = string.find(s, ".", 1, true)
            if i then return string.sub(s, 1, i-1) end
            return s
        end

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
        table.Insert = table.insert

        util = { SharedRandom = function(name, min, max) return (min+max)/2 end }

        -- NetworkVar mock: just returns a function that does nothing
        NetworkVar = function() end

        -- GMod weapon entity globals
        ACT_VM_IDLE = 1
        ACT_VM_PRIMARYATTACK = 2
        ACT_VM_RELOAD = 3
        ACT_VM_RELOAD_EMPTY = 4
        ACT_VM_DRAW = 5
        ACT_VM_DRAW_DEPLOYED = 6
        ACT_VM_DEPLOY = 7
        ACT_VM_UNDEPLOY = 8
        ACT_VM_IDLE_DEPLOYED = 9
        ACT_VM_MELEE = 10
        ACT_VM_FIDGET = 11
        ACT_VM_SPRINT_IDLE = 12
        ACT_VM_SPRINT_ENTER = 13
        ACT_VM_SPRINT_LEAVE = 14
        ACT_VM_PRIMARYATTACK_SILENCED = 15
        ACT_VM_SECONDARYATTACK = 16
        ACT_VM_SECONDARYATTACK_SILENCED = 17
        ACT_SHOTGUN_PUMP = 18
        ACT_SHOTGUN_RELOAD_START = 19
        ACT_SHOTGUN_RELOAD_FINISH = 20
        PLAYER_ATTACK1 = 1
        PLAYER_RELOAD = 2

        IN_USE = 1

        IsValid = function(o) return type(o) == "table" and o.__type ~= "nil_obj" end

        AddCSLuaFile = function() end

        DEFINE_BASECLASS = function(name) end
        BaseClass = {}  -- global table for base class method calls

        ConVarExists = function(name) return false end
        CreateClientConVar = function(name, def, save, user, help, min, max)
            return { GetInt = function() return tonumber(def) or 0 end,
                     GetFloat = function() return tonumber(def) or 0 end,
                     GetBool = function() return def == "1" or def == true end,
                     GetString = function() return def end, Set = function() end, SetBool = function() end }
        end
        CreateConVar = function(name, def, flags, help, min, max)
            return { GetInt = function() return tonumber(def) or 0 end,
                     GetFloat = function() return tonumber(def) or 0 end,
                     GetBool = function() return def == "1" or def == true end,
                     GetString = function() return def end, Set = function() end }
        end
        GetConVar = function(name)
            return { GetInt = function() return 0 end, GetFloat = function() return 0 end,
                     GetBool = function() return false end, GetString = function() return "" end,
                     Set = function() end }
        end
        cvars = { Add = function() end, Remove = function() end }
        concmand = { Add = function() end, Remove = function() end, Run = function() end }
        concommand = { Add = function() end, Remove = function() end, Run = function() end, AutoComplete = function() return {} end }

        language = { Add = function() end, GetPhrase = function(p) return p end }

        render = { Clear = function() end, SetColorMaterial = function() end,
                   SetMaterial = function() end, DrawRect = function() end,
                   DrawTexturedRect = function() end, PushRenderTarget = function() end,
                   PopRenderTarget = function() end, RenderView = function() end,
                   ClearDepth = function() end, ClearColor = function() end }

        surface = { SetFont = function() end, DrawText = function() end,
                    GetTextSize = function() return 0, 0 end,
                    SetTextColor = function() end, SetTextPos = function() end,
                    CreateFont = function() return 0 end }

        draw = { SimpleText = function() end, RoundedBox = function() end }

        cam = { Start3D = function() end, End3D = function() end,
                Start3D2D = function() end, End3D2D = function() end }

        input = { IsKeyDown = function() return false end,
                  LookupBinding = function() return "" end,
                  GetBinding = function() return "" end }

        draw.NoTexture = function() end

        -- Material system mocks (Material() returns a stub table)
        -- (already defined above)

        -- GMod weapon entity methods used by ApplyAttachments
        SetSubMaterial = function() end

        istable = function(o) return type(o) == "table" end
        isstring = function(o) return type(o) == "string" end
        isnumber = function(o) return type(o) == "number" end
        isfunction = function(o) return type(o) == "function" end
        isbool = function(o) return type(o) == "boolean" end
        isentity = function(o) return type(o) == "table" and o.__type == "Entity" end
        isangle = function(o) return type(o) == "table" and o.__type == "Angle" end
        isvector = function(o) return type(o) == "table" and o.__type == "Vector" end
        iscolor = function(o) return type(o) == "table" and o.__type == "Color" end


        GetParent = function() return nil end
        GetAttachments = function() return {} end

        -- More globals
        math.random = function(a, b) if a and b then return math.floor((a+b)/2) end return 0 end
        math.Clamp = function(v, mn, mx) return math.max(mn, math.min(mx, v)) end
        math.Round = function(v, n) local m = 10 ^ (n or 0); return math.floor(v*m + 0.5) / m end
        math.Approach = function(v, t, dt) if v < t then return math.min(v+dt, t) else return math.max(v-dt, t) end end
        math.ease = { InOutQuad = function(t) return t*t end }

        CurTime = function() return 0 end
        RealTime = function() return 0 end
        FrameTime = function() return 0.016 end

        PrintTable = function(t) end

        -- Stat-cache mocks (CUH base uses these)
        GetStat = function(wep, path, default)
            local parts = {}
            for p in string.gmatch(path, "[^.]+") do table.insert(parts, p) end
            local v = wep
            for _, p in ipairs(parts) do v = v and v[p] end
            return v ~= nil and v or default
        end

        IsFirstTimePredicted = function() return true end

        -- ClientsideModel mock: log creation
        _CSMODEL_LOG = {}
        ClientsideModel = function(model, group)
            local cs = { __type="ClientsideModel", __model=model, group=group,
                         DrawModel=function() end, Remove=function() end,
                         SetModel=function(self, m) self.__model = m end,
                         SetMaterial=function() end, SetSkin=function() end,
                         SetBodygroup=function() end, SetColor=function() end,
                         SetPos=function() end, SetAngles=function() end,
                         SetNoDraw=function() end, SetParent=function() end,
                         SetSequence=function() end, SetCycle=function() end,
                         SetPlaybackRate=function() end, LookupSequence=function() return 0 end,
                         DrawShadow=function() end, SetLOD=function() end, }
            table.insert(_CSMODEL_LOG, model)
            return cs
        end

        hook = { Add = function() end, Remove = function() end, GetTable = function() return {} end, Call = function() end }
        convar = { Add = function() end }
        net = { Start = function() end, WriteInt = function() end, WriteString = function() end,
                WriteUInt = function() end, Send = function() end, Receive = function() end,
                ReadInt = function() return 0 end, ReadString = function() return "" end,
                SendToServer = function() end,
                WriteEntity = function() end, WriteBool = function() end,
                ReadBool = function() return false end, ReadEntity = function() return nil end,
                Broadcast = function() end }
        util.AddNetworkString = function() end

        file = { Find = function() return {} end, Write = function() end, Read = function() return nil end,
                 Exists = function() return false end, CreateDir = function() end, Delete = function() end }

        -- CustomUH namespace (sh_cuh_attachments.lua populates it)
        CustomUH = {}

        -- SWEP namespace (weapon base files populate this)
        SWEP = { Primary = {}, Secondary = {}, Animations = {}, AnimSounds = {},
                 FireModes = {}, Attachments = {},
                 ViewModelElements = {}, WorldModelElements = {},
                 ViewModelBoneMods = {}, WorldModelBoneMods = {},
                 Bodygroups_V = {}, Bodygroups_W = {} }
    """)

    # ------------------------------------------------------------------
    # 2. Load the REAL CUH source
    # ------------------------------------------------------------------
    print("[sim] Loading CUH sh_cuh_attachments.lua...")
    sh_attach_path = os.path.join(CUH_ROOT, "lua/autorun/sh_cuh_attachments.lua")
    lua.execute(_preprocess(read(sh_attach_path)))

    print("[sim] Loading CUH weapon_custom_uh_base.lua...")
    root_base_path = os.path.join(CUH_ROOT, "lua/weapons/weapon_custom_uh_base.lua")
    lua.execute(_preprocess(read(root_base_path)))

    print("[sim] Loading CUH weapon_custom_uh_base_gun.lua...")
    gun_base_path = os.path.join(CUH_ROOT, "lua/weapons/weapon_custom_uh_base_gun.lua")
    lua.execute(_preprocess(read(gun_base_path)))

    print("[sim] Loading CUH weapon_cuh_base_gun.lua...")
    cuh_base_path = os.path.join(CUH_ROOT, "lua/weapons/weapon_cuh_base_gun.lua")
    lua.execute(_preprocess(read(cuh_base_path)))

    # Capture the loaded base class methods — these will be inherited
    # by the weapon file when we copy them onto the weapon table after loading.
    print("[sim] Capturing _BASECLASS...")
    lua.execute("_BASECLASS = SWEP; SWEP = nil")

    # ------------------------------------------------------------------
    # 3. Load the ported attachments (cuh_attachments/bf3_*.lua)
    # ------------------------------------------------------------------
    att_dir = os.path.join(PORT_ROOT, "lua/cuh_attachments")
    for fname in sorted(os.listdir(att_dir)):
        if not fname.endswith(".lua"):
            continue
        print(f"[sim] Loading attachment {fname}...")
        lua.execute(_preprocess(read(os.path.join(att_dir, fname))))
        # Register the attachment (mirrors CustomUH.RegisterAttachments behavior)
        lua.execute(f"""
            if ATTACHMENT and ATTACHMENT.Name then
                local id = string.StripExtension("{fname}")
                ATTACHMENT.ID = id
                CustomUH.Attachments = CustomUH.Attachments or {{}}
                CustomUH.Attachments[id] = ATTACHMENT
            end
            ATTACHMENT = nil
        """)

    # ------------------------------------------------------------------
    # 4. Load the ported weapon (weapon_cuh_bf3_m416.lua)
    # ------------------------------------------------------------------
    weapon_path = os.path.join(PORT_ROOT, "lua/weapons/weapon_cuh_bf3_m416.lua")
    print(f"[sim] Loading weapon {weapon_path}...")
    lua.execute(f"""
        _WEAPON = nil
        SWEP = {{ Primary = {{}}, Secondary = {{}}, Animations = {{}}, AnimSounds = {{}},
                 FireModes = {{}}, Attachments = {{}},
                 ViewModelElements = {{}}, WorldModelElements = {{}},
                 ViewModelBoneMods = {{}}, WorldModelBoneMods = {{}},
                 Bodygroups_V = {{}}, Bodygroups_W = {{}} }}
    """)
    lua.execute(_preprocess(read(weapon_path)))
    # Copy methods from _BASECLASS to SWEP if not already set on SWEP
    # (simulates GMod's SWEP inheritance)
    lua.execute('''
        for k, v in pairs(_BASECLASS) do
            if SWEP[k] == nil then
                SWEP[k] = v
            end
        end
        _WEAPON = SWEP; SWEP = nil
    ''')
    lua.execute(f"""
        _WEAPON_CLASS = 'weapon_cuh_bf3_m416'
    """)

    # ------------------------------------------------------------------
    # 5. Parse the m416 model's $sequence list
    # ------------------------------------------------------------------
    qc_path = os.path.join(DECOMP_DIR, "m416.qc")
    if os.path.exists(qc_path):
        seqs = parse_sequences_from_qc(qc_path)
        print(f"[sim] m416 model has {len(seqs)} sequences: {', '.join(seqs)}")
        # Pass to Lua as a list
        lua_seq_list = "{" + ", ".join(f'"{s}"' for s in seqs) + "}"
        lua.execute(f"_MODEL_SEQUENCES = {lua_seq_list}")
    else:
        print(f"[sim] WARN: {qc_path} not found, no sequence validation")
        lua.execute("_MODEL_SEQUENCES = {}")

    # ------------------------------------------------------------------
    # 6. Run the harness
    # ------------------------------------------------------------------
    harness_path = os.path.join(PORT_ROOT, "scripts/cuh_sim_harness_bf3.lua")
    print(f"\n[sim] Running harness {harness_path}...")
    lua.execute(read(harness_path))

    # Get the pass/fail counts
    result = lua.execute("return {_RESULT_PASS, _RESULT_FAILS}")
    passed, failed = result[0], result[1]
    print(f"\n[sim] Final: PASS={passed}, FAIL={failed}")
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
