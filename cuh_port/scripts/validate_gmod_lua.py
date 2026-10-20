#!/usr/bin/env python3
"""Quick syntax validator for all GMod Lua files."""
import subprocess, sys, os
from pathlib import Path

LUACHECK = "/home/z/my-project/tools/luacheck"
DIRS = [
    "/home/z/my-project/repos/cuh_port_recovery/lua",
    "/home/z/my-project/repos/cuh_port_recovery/cuh_base_patches/lua",
    "/home/z/my-project/download/custom_uh_base/lua/weapons",
    "/home/z/my-project/download/custom_uh_base/lua/autorun",
]

files = set()
for d in DIRS:
    if Path(d).exists():
        for f in Path(d).rglob("*.lua"):
            files.add(str(f))

print(f"Linting {len(files)} files...")
args = [LUACHECK, "--no-config", "--std", "luajit", "--max-line-length", "300",
        "--ignore", "212", "213", "231", "311", "431", "542", "111"]

gmod_globals = ["SERVER","CLIENT","IsValid","CurTime","RealTime","FrameTime","Angle","Vector",
    "Color","Material","Sound","CreateMaterial","GetRenderTarget","draw","cam","render","input",
    "util","hook","timer","net","concommand","cvars","file","game","engine","language",
    "istable","isstring","isnumber","isbool","isfunction","isentity","isangle","isvector","iscolor",
    "CreateClientConVar","CreateConVar","GetConVar","ConVarExists","AddCSLuaFile","include",
    "DEFINE_BASECLASS","NetworkVar","SWEP","ATTACHMENT","CustomUH","BaseClass","ClientsideModel",
    "SetSubMaterial","PrintTable","CompileString","NULL","ErrorNoHalt",
    "ACT_VM_IDLE","ACT_VM_PRIMARYATTACK","ACT_VM_RELOAD","ACT_VM_RELOAD_EMPTY","ACT_VM_DRAW",
    "ACT_VM_DRAW_DEPLOYED","ACT_VM_DEPLOY","ACT_VM_UNDEPLOY","ACT_VM_IDLE_DEPLOYED","ACT_VM_MELEE",
    "ACT_VM_FIDGET","ACT_VM_SPRINT_IDLE","ACT_VM_SPRINT_ENTER","ACT_VM_SPRINT_LEAVE",
    "ACT_VM_PRIMARYATTACK_SILENCED","ACT_VM_SECONDARYATTACK","ACT_SHOTGUN_PUMP",
    "ACT_SHOTGUN_RELOAD_START","ACT_SHOTGUN_RELOAD_FINISH","PLAYER_ATTACK1","PLAYER_RELOAD",
    "IN_USE","IN_ATTACK","IN_ATTACK2","IN_RELOAD","IN_SPEED","CHAN_WEAPON","CHAN_USER_BASE",
    "vector_origin","angle_zero","color_black","color_white",
    "IsFirstTimePredicted","table"]
args.extend(["--globals"] + gmod_globals)
args.extend(list(files))

result = subprocess.run(args, capture_output=True, text=True, timeout=60)
output = result.stdout + result.stderr
errors = [l for l in output.split("\n") if "error" in l.lower() and "Total" not in l]
print(output.split("\n")[-2] if output.strip() else "No output")
if errors:
    print(f"\nERRORS ({len(errors)}):")
    for e in errors[:10]: print(f"  {e}")
else:
    print("0 errors")
