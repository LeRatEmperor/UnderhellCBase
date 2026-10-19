-- GMod CUH luacheck configuration
-- GMod uses LuaJIT (Lua 5.1 + extensions like `continue`, `goto`)

-- Use luajit standard library (includes continue, goto)
std = "luajit"

-- GMod globals
globals = {
    "SERVER", "CLIENT", "MENU", "GAME",
    "IsValid", "IsFirstTimePredicted",
    "CurTime", "RealTime", "FrameTime", "SysTime",
    "Angle", "Vector", "Color", "Material", "Sound", "Texture",
    "CreateMaterial", "GetRenderTarget", "GetRenderTargetEx",
    "draw", "cam", "render", "input", "util",
    "hook", "timer", "net", "concommand", "cvars",
    "file", "game", "engine", "system", "language",
    "bit", "band", "bor", "bxor", "bnot", "lshift", "rshift",
    "istable", "isstring", "isnumber", "isbool", "isfunction", "isentity",
    "isangle", "isvector", "iscolor", "ispanel", "isnpc", "isplayer",
    "isweapon", "isworld",
    "CreateClientConVar", "CreateConVar", "GetConVar", "ConVarExists",
    "AddCSLuaFile", "include", "DEFINE_BASECLASS",
    "NetworkVar", "ENT", "SWEP", "GM", "gamemode",
    "ACT_VM_IDLE", "ACT_VM_PRIMARYATTACK", "ACT_VM_RELOAD", "ACT_VM_RELOAD_EMPTY",
    "ACT_VM_DRAW", "ACT_VM_DRAW_DEPLOYED", "ACT_VM_DEPLOY", "ACT_VM_UNDEPLOY",
    "ACT_VM_IDLE_DEPLOYED", "ACT_VM_MELEE", "ACT_VM_FIDGET",
    "ACT_VM_SPRINT_IDLE", "ACT_VM_SPRINT_ENTER", "ACT_VM_SPRINT_LEAVE",
    "ACT_VM_PRIMARYATTACK_SILENCED", "ACT_VM_SECONDARYATTACK",
    "ACT_VM_SECONDARYATTACK_SILENCED", "ACT_VM_IDLE_SILENCED",
    "ACT_SHOTGUN_PUMP", "ACT_SHOTGUN_RELOAD_START", "ACT_SHOTGUN_RELOAD_FINISH",
    "ACT_VM_IDLE_TO_LOWERED", "ACT_VM_LOWERED_TO_IDLE",
    "PLAYER_ATTACK1", "PLAYER_RELOAD",
    "IN_USE", "IN_ATTACK", "IN_ATTACK2", "IN_RELOAD", "IN_SPEED",
    "CHAN_WEAPON", "CHAN_USER_BASE",
    "MOVETYPE_NOCLIP",
    "vector_origin", "angle_zero", "color_black", "color_white",
    "ATTACHMENT", "CustomUH", "Customizable", "NULL", "BaseClass",
    "ClientsideModel", "SetSubMaterial", "PrintTable",
    "CompileString",
}

-- Max line length (GMod code is often long)
max_line_length = 300

-- Warnings to ignore (common in GMod code)
ignore = {
    "212", -- unused argument
    "213", -- unused argument
    "231", -- unused variable
    "311", -- value assigned but unused
    "431", -- shadowing local
    "542", -- empty if
    "111", -- setting non-standard global
}

files = {
    "lua/",
    "cuh_base_patches/lua/",
}
