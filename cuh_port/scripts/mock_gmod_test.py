#!/usr/bin/env python3
"""
mock_gmod_test.py — Mock-GLua test runner for CUH weapon base.

Loads the REAL CUH source files + ported weapon/attachment files into a
LuaJIT VM (via lupa), mocks every GMod global they touch, then runs
targeted unit tests that exercise the actual runtime logic.

Tests:
  1. InitStatCache captures 'Silenced' in _statOrigins
  2. self.Silenced reverts after suppressor removal
  3. SetNWBool('Silenced') reverts via Detach
  4. Bodygroups revert after attachment removal
  5. Grip animations swap + revert
  6. shoot_sil animation key resolves
  7. All attachment IDs registered
  8. Silenced sound selection (GetShootSound)
  9. Penetration is numeric
  10. Required SWEP fields present
"""

import os, sys, re, traceback
from pathlib import Path
from lupa import LuaRuntime

CUH_ROOT   = "/home/z/my-project/download/custom_uh_base"
PORT_ROOT  = "/home/z/my-project/repos/cuh_port_recovery"
DECOMP_DIR = "/home/z/my-project/decompile/anim_audit_all/m416"
SCRIPTS    = "/home/z/my-project/scripts"

sys.path.insert(0, SCRIPTS)
from cuh_preprocess import preprocess as _preprocess

def read(p):
    with open(p, "r", encoding="utf-8", errors="replace") as f: return f.read()

def parse_seqs(qc):
    return re.findall(r'^\$sequence\s+"([^"]+)"', read(qc), re.MULTILINE)

MOCK_ENV = r"""
CLIENT=true; SERVER=false; GAME="garrysmod"
Color=function(r,g,b,a) return {__type="Color",r=r,g=g,b=b,a=a} end
Sound=function(s) return {__type="Sound",s=s} end
Vector=function(x,y,z) return {__type="Vector",x=x or 0,y=y or 0,z=z or 0} end
Angle=function(p,y,r) return {__type="Angle",p=p or 0,y=y or 0,r=r or 0} end
Material=function(p) return {__type="Material",p=p,IsError=function() return false end} end
CreateMaterial=function(n,s,p) return {__type="Material",name=n,IsError=function() return false end} end
GetRenderTarget=function(n,w,h) return {__type="RT",name=n} end
RENDERGROUP_VIEWMODEL=1; RENDERGROUP_OPAQUE=2
string.StripExtension=function(s) local i=string.find(s,".",1,true) if i then return string.sub(s,1,i-1) end return s end
table.Copy=function(t) if type(t)~="table" then return t end local r={} for k,v in pairs(t) do r[k]=table.Copy(v) end return r end
table.Count=function(t) local n=0 for _ in pairs(t) do n=n+1 end return n end
table.insert=table.insert or function(t,v) t[#t+1]=v end
istable=function(o) return type(o)=="table" end
isstring=function(o) return type(o)=="string" end
isnumber=function(o) return type(o)=="number" end
isbool=function(o) return type(o)=="boolean" end
isfunction=function(o) return type(o)=="function" end
isentity=function(o) return type(o)=="table" and o.__type=="Entity" end
isangle=function(o) return type(o)=="table" and o.__type=="Angle" end
isvector=function(o) return type(o)=="table" and o.__type=="Vector" end
iscolor=function(o) return type(o)=="table" and o.__type=="Color" end
util={SharedRandom=function(n,mn,mx) return (mn+mx)/2 end, AddNetworkString=function() end, NetworkVar=function() end}
hook={Add=function() end, Remove=function() end, GetTable=function() return {} end, Call=function() end}
concommand={Add=function() end, Run=function() end}
cvars={Add=function() end, Remove=function() end}
ConVarExists=function() return false end
CreateConVar=function(name,def) return {GetInt=function() return tonumber(def) or 0 end, GetFloat=function() return tonumber(def) or 0 end, GetBool=function() return def=="1" or def==true end, GetString=function() return def end, Set=function() end} end
CreateClientConVar=CreateConVar
GetConVar=CreateConVar
net={Start=function() end, WriteInt=function() end, WriteUInt=function() end, WriteString=function() end, WriteEntity=function() end, WriteBool=function() end, Send=function() end, SendToServer=function() end, Receive=function() end, Broadcast=function() end, ReadInt=function() return 0 end, ReadUInt=function() return 0 end, ReadString=function() return "" end, ReadEntity=function() return nil end, ReadBool=function() return false end}
file={Find=function() return {} end, Write=function() end, Read=function() return nil end, Exists=function() return false end, CreateDir=function() end, Delete=function() end, Open=function() return nil end}
language={Add=function() end, GetPhrase=function(p) return p end}
render={Clear=function() end, SetColorMaterial=function() end, SetMaterial=function() end, PushRenderTarget=function() end, PopRenderTarget=function() end, RenderView=function() end, ClearDepth=function() end, ClearColor=function() end, SetRenderTarget=function() end, DrawRect=function() end, DrawTexturedRect=function() end}
surface={SetFont=function() end, DrawText=function() end, GetTextSize=function() return 0,0 end, SetTextColor=function() end, SetTextPos=function() end, CreateFont=function() return 0 end}
draw={SimpleText=function() end, RoundedBox=function() end, NoTexture=function() end}
cam={Start3D=function() end, End3D=function() end, Start3D2D=function() end, End3D2D=function() end}
input={IsKeyDown=function() return false end, LookupBinding=function() return "" end}
CurTime=function() return 0 end
RealTime=function() return 0 end
FrameTime=function() return 0.016 end
IsFirstTimePredicted=function() return true end
math.random=function(a,b) if a and b then return math.floor((a+b)/2) end return 0 end
math.Round=function(v,n) local m=10^(n or 0) return math.floor(v*m+0.5)/m end
math.Clamp=function(v,mn,mx) return math.max(mn, math.min(mx,v)) end
math.Approach=function(v,t,dt) if v<t then return math.min(v+dt,t) else return math.max(v-dt,t) end end
math.ease={InOutQuad=function(t) return t*t end}
ACT_VM_IDLE=1; ACT_VM_PRIMARYATTACK=2; ACT_VM_RELOAD=3; ACT_VM_RELOAD_EMPTY=4
ACT_VM_DRAW=5; ACT_VM_DRAW_DEPLOYED=6; ACT_VM_DEPLOY=7; ACT_VM_UNDEPLOY=8
ACT_VM_IDLE_DEPLOYED=9; ACT_VM_MELEE=10; ACT_VM_FIDGET=11
ACT_VM_SPRINT_IDLE=12; ACT_VM_SPRINT_ENTER=13; ACT_VM_SPRINT_LEAVE=14
ACT_VM_PRIMARYATTACK_SILENCED=15; ACT_VM_SECONDARYATTACK=16
ACT_VM_SECONDARYATTACK_SILENCED=17; ACT_VM_IDLE_SILENCED=18
ACT_SHOTGUN_PUMP=19; ACT_SHOTGUN_RELOAD_START=20; ACT_SHOTGUN_RELOAD_FINISH=21
ACT_VM_IDLE_TO_LOWERED=22; ACT_VM_LOWERED_TO_IDLE=23
PLAYER_ATTACK1=1; PLAYER_RELOAD=2; IN_USE=1; IN_ATTACK=2; IN_ATTACK2=4
IN_RELOAD=8; IN_SPEED=32; CHAN_WEAPON=1; CHAN_USER_BASE=14; MOVETYPE_NOCLIP=8
vector_origin={__type="Vector",x=0,y=0,z=0}
angle_zero={__type="Angle",p=0,y=0,r=0}
color_black={__type="Color",r=0,g=0,b=0,a=255}
color_white={__type="Color",r=255,g=255,b=255,a=255}
AddCSLuaFile=function() end
DEFINE_BASECLASS=function(name) end
BaseClass={}
NetworkVar=function() end
IsValid=function(o) return type(o)=="table" and o.__type~="nil_obj" end
NULL={__type="nil_obj"}
PrintTable=function(t) end
ErrorNoHalt=function(msg) print("[ErrorNoHalt] "..tostring(msg)) end
_CSMODEL_LOG={}
ClientsideModel=function(model,group) local cs={__type="CSM",__model=model,DrawModel=function() end,Remove=function() end,SetModel=function(self,m) self.__model=m end,SetMaterial=function() end,SetSkin=function() end,SetBodygroup=function() end,SetColor=function() end,SetPos=function() end,SetAngles=function() end,SetNoDraw=function() end,SetParent=function() end,SetSequence=function() end,SetCycle=function() end,SetPlaybackRate=function() end,LookupSequence=function() return 0 end, SelectWeightedSequence=function() return 0 end,DrawShadow=function() end,SetLOD=function() end,AddEffects=function() end,RemoveEffects=function() end,GetMaterials=function() return {} end,SetSubMaterial=function() end} table.insert(_CSMODEL_LOG,model) return cs end
SetSubMaterial=function() end
CustomUH={}
SWEP={Primary={},Secondary={},Animations={},AnimSounds={},FireModes={},Attachments={},ViewModelElements={},WorldModelElements={},ViewModelBoneMods={},WorldModelBoneMods={},Bodygroups_V={},Bodygroups_W={}}
"""


class TestRunner:
    def __init__(self, verbose=False):
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.verbose = verbose
        self.passed = 0
        self.failed = 0

    def setup(self):
        self.lua.execute(MOCK_ENV)
        # CUH autorun
        self.lua.execute(_preprocess(read(os.path.join(CUH_ROOT,"lua/autorun/sh_cuh_attachments.lua"))))
        # CUH base layers
        for f in ["weapon_custom_uh_base.lua","weapon_custom_uh_base_gun.lua","weapon_cuh_base_gun.lua"]:
            self.lua.execute(_preprocess(read(os.path.join(CUH_ROOT,"lua/weapons",f))))
        self.lua.execute("_BASECLASS=SWEP; SWEP=nil")
        # Attachments
        att_dir = os.path.join(PORT_ROOT,"lua/cuh_attachments")
        for fname in sorted(os.listdir(att_dir)):
            if not fname.endswith(".lua"): continue
            self.lua.execute(_preprocess(read(os.path.join(att_dir,fname))))
            self.lua.execute(f'if ATTACHMENT and ATTACHMENT.Name then local id=string.StripExtension("{fname}") ATTACHMENT.ID=id CustomUH.Attachments=CustomUH.Attachments or {{}} CustomUH.Attachments[id]=ATTACHMENT end ATTACHMENT=nil')
        # Weapon
        self.lua.execute("SWEP={Primary={},Secondary={},Animations={},AnimSounds={},FireModes={},Attachments={},ViewModelElements={},WorldModelElements={},ViewModelBoneMods={},WorldModelBoneMods={},Bodygroups_V={},Bodygroups_W={}}")
        self.lua.execute(_preprocess(read(os.path.join(PORT_ROOT,"lua/weapons/weapon_cuh_bf3_m416.lua"))))
        # Inherit
        self.lua.execute("for k,v in pairs(_BASECLASS) do if SWEP[k]==nil then SWEP[k]=v end end _WEAPON=SWEP; SWEP=nil")
        # Sequences
        qc=os.path.join(DECOMP_DIR,"m416.qc")
        seqs = parse_seqs(qc) if os.path.exists(qc) else []
        self.lua.execute("_MODEL_SEQUENCES={"+", ".join(f'"{s}"' for s in seqs)+"}")
        # Build instance + mock owner
        self.lua.execute(r"""
            _WEP={}
            for k,v in pairs(_WEAPON) do _WEP[k]=v end
            _WEP.Primary=table.Copy(_WEAPON.Primary)
            _WEP.Secondary=table.Copy(_WEAPON.Secondary)
            _WEP.Animations=table.Copy(_WEAPON.Animations)
            _WEP.ViewModelElements=table.Copy(_WEAPON.ViewModelElements)
            _WEP.WorldModelElements=table.Copy(_WEAPON.WorldModelElements or {})
            _WEP.Attachments={}
            for i,s in ipairs(_WEAPON.Attachments or {}) do
                _WEP.Attachments[i]={name=s.name,atts=table.Copy(s.atts),default=s.default,forceDefault=s.forceDefault}
            end
            _WEP.Bodygroups_V=table.Copy(_WEAPON.Bodygroups_V or {})
            _WEP.Bodygroups_W=table.Copy(_WEAPON.Bodygroups_W or {})
            _WEP.Owner={
                IsPlayer=function() return true end,
                GetViewModel=function() return {__type="VM",IsValid=function() return false end,SequenceDuration=function() return 0.5 end,GetCycle=function() return 1 end,LookupSequence=function(self,n) if _SEQ_LOOKUP then return _SEQ_LOOKUP[n] or -1 end return -1 end,SelectWeightedSequence=function() return 0 end,SetCycle=function() end,SetPlaybackRate=function() end,SendViewModelMatchingSequence=function() end} end,
                KeyDown=function() return false end,
                GetShootPos=function() return Vector(0,0,0) end,
                GetAimVector=function() return Vector(1,0,0) end,
                GetAmmoCount=function() return 180 end,
                EyeAngles=function() return Angle(0,0,0) end,
                SetEyeAngles=function() end,
                SetAnimation=function() end,
                MuzzleFlash=function() end,
                ViewPunch=function() end,
                GetVelocity=function() return Vector(0,0,0) end,
                GetRunSpeed=function() return 200 end,
                GetWalkSpeed=function() return 100 end,
                OnGround=function() return true end,
                Crouching=function() return false end,
                GetActiveWeapon=function() return _WEP end,
            }
            _WEP.GetClass=function() return "weapon_cuh_bf3_m416" end
            _WEP.GetOwner=function() return _WEP.Owner end
            _WEP._mockNW={}; _WEP._mockUH={}
            _WEP.GetNWBool=function(self,k) return self._mockNW[k] end
            _WEP.GetNWInt=function(self,k) return self._mockNW[k] or 0 end
            _WEP.GetNWFloat=function(self,k) return self._mockNW[k] or 0 end
            _WEP.SetNWBool=function(self,k,v) self._mockNW[k]=v end
            _WEP.SetNWInt=function(self,k,v) self._mockNW[k]=v end
            _WEP.SetNWFloat=function(self,k,v) self._mockNW[k]=v end
            _WEP.SetUHBool=function(self,k,v) self._mockUH[k]=v end
            _WEP.GetUHBool=function(self,k) return self._mockUH[k] or false end
            _WEP.GetMaxClip1=function(self) return self.Primary and self.Primary.ClipSize or 30 end
            _WEP.Clip1=function(self) return self.Primary and self.Primary.DefaultClip or 90 end
            _WEP.SetClip1=function(self,n) end
            _WEP.TakePrimaryAmmo=function(self,n) end
            _WEP.GetPrimaryAmmoCount=function(self) return 180 end
            _WEP.GetMuzzle=function(self) return Vector(0,0,0) end
            _WEP.EmitSound=function() end
            _WEP.SetNextPrimaryFire=function() end
            _WEP.SetNextSecondaryFire=function() end
            _WEP.DoMuzzleFlash=function() end
            _WEP.CreateSmoke=function() end
            _WEP.CreateShell=function() end
            _WEP.PostShoot=function() end
            _WEP.ClearAnimSounds=function() end
            _SEQ_LOOKUP={}
            for i,s in ipairs(_MODEL_SEQUENCES or {}) do _SEQ_LOOKUP[s]=i end
            print("[MOCK] _SEQ_LOOKUP has " .. #_SEQ_LOOKUP .. " entries")
        """)

    def check(self, name, cond, extra=""):
        if cond:
            self.passed += 1
            if self.verbose: print(f"  [PASS] {name}" + (f"  {extra}" if extra else ""))
        else:
            self.failed += 1
            print(f"  [FAIL] {name}" + (f"  {extra}" if extra else ""))

    def t_stat_cache_has_silenced(self):
        self.lua.execute("_WEP:InitStatCache()")
        origin = self.lua.execute("return _WEP._statOrigins and _WEP._statOrigins['Silenced']")
        self.check("InitStatCache captures 'Silenced' in _statOrigins", origin is not None, f"origin={origin}")

    def t_silenced_reverts(self):
        self.lua.execute("_WEP:SetAttachment(2, 2)")
        v1 = self.lua.execute("return _WEP.Silenced")
        self.check("After suppressor attached: self.Silenced is truthy", v1==True or v1==1, f"got={v1}")
        self.lua.execute("_WEP:SetAttachment(2, 0)")
        v2 = self.lua.execute("return _WEP.Silenced")
        self.check("After suppressor removed: self.Silenced reverts to nil/false", v2 is None or v2 is False, f"got={v2}")

    def t_nw_bool_reverts(self):
        self.lua.execute("_WEP:SetAttachment(2, 2)")
        v1 = self.lua.execute("return _WEP:GetNWBool('Silenced')")
        self.check("After suppressor: NWBool('Silenced')=true", v1==True, f"got={v1}")
        self.lua.execute("_WEP:SetAttachment(2, 0)")
        v2 = self.lua.execute("return _WEP:GetNWBool('Silenced')")
        self.check("After suppressor removed: NWBool('Silenced')=false (via Detach)", v2==False, f"got={v2}")

    def t_bodygroups_revert(self):
        self.lua.execute("_WEP:SetAttachment(1, 4)")
        bg = self.lua.execute("return _WEP.Bodygroups_V and _WEP.Bodygroups_V[0]")
        self.check("After acog: Bodygroups_V[0]=3", bg==3, f"got={bg}")
        self.lua.execute("_WEP:SetAttachment(1, 0)")
        bg2 = self.lua.execute("return _WEP.Bodygroups_V and _WEP.Bodygroups_V[0]")
        self.check("After acog removed: Bodygroups_V[0] reverts to 0", bg2==0 or bg2==None, f"got={bg2}")

    def t_grip_anims(self):
        self.lua.execute("_WEP:SetAttachment(4, 1)")
        s = self.lua.execute("return _WEP.Animations['shoot']")
        i = self.lua.execute("return _WEP.Animations['idle']")
        self.check("After grip: Animations['shoot']='foregrip_fire'", s=="foregrip_fire", f"got={s}")
        self.check("After grip: Animations['idle']='foregrip_idle'", i=="foregrip_idle", f"got={i}")
        self.lua.execute("_WEP:SetAttachment(4, 0)")
        s2 = self.lua.execute("return _WEP.Animations['shoot']")
        i2 = self.lua.execute("return _WEP.Animations['idle']")
        self.check("After grip removed: Animations['shoot']='base_fire'", s2=="base_fire", f"got={s2}")
        self.check("After grip removed: Animations['idle']='base_idle'", i2=="base_idle", f"got={i2}")

    def t_shoot_sil_exists(self):
        val = self.lua.execute("return _WEP.Animations['shoot_sil']")
        self.check("Animations['shoot_sil'] exists", val is not None and val is not None, f"got={val}")
        if val:
            sid = self.lua.execute(f"return _SEQ_LOOKUP['{val}'] or -1")
            self.check(f"LookupSequence('{val}') valid", sid is not None and sid>=0, f"sid={sid}")

    def t_attachment_ids(self):
        result = self.lua.execute("""
            local ok=true; local missing={}
            for _,s in ipairs(_WEP.Attachments or {}) do
                for _,a in ipairs(s.atts or {}) do
                    if not CustomUH.Attachments[a] then ok=false table.insert(missing,a) end
                end
            end
            return ok, table.concat(missing,", ")
        """)
        ok, missing = result if isinstance(result, tuple) else (result, "")
        self.check("All attachment IDs registered", ok, f"missing: {missing}" if not ok else "")

    def t_sound_selection(self):
        self.lua.execute("_WEP.Silenced=true")
        s1 = self.lua.execute("return _WEP:GetShootSound()")
        sil = self.lua.execute("return _WEP.Primary.SilSound")
        self.check("GetShootSound returns SilSound when Silenced=true", s1==sil or (isinstance(s1,dict) and isinstance(sil,dict) and s1.get('s')==sil.get('s')), f"got={s1} exp={sil}")
        self.lua.execute("_WEP.Silenced=false")
        s2 = self.lua.execute("return _WEP:GetShootSound()")
        reg = self.lua.execute("return _WEP.Primary.Sound")
        self.check("GetShootSound returns Sound when Silenced=false", s2==reg or (isinstance(s2,dict) and isinstance(reg,dict) and s2.get('s')==reg.get('s')), f"got={s2} exp={reg}")

    def t_penetration_numeric(self):
        pen = self.lua.execute("return _WEAPON.Penetration")
        self.check("SWEP.Penetration is numeric", isinstance(pen,(int,float)) and not isinstance(pen,bool), f"got={pen} type={type(pen).__name__}")

    def t_required_fields(self):
        fields = ["Base","PrintName","ViewModel","WorldModel","HoldType","IsCUHWeapon",
                  "UseHands","IronSightsPos","IronSightsAng","IronSightTime",
                  "RunSightsPos","RunSightsAng","FireModes","Animations","Attachments",
                  "ViewModelElements","Bodygroups_V","UseQCReloadEvents"]
        for f in fields:
            val = self.lua.execute(f"return _WEAPON['{f}']")
            self.check(f"Required field: {f}", val is not None and val is not None and val!=0, f"got={val}")

    def run_all(self):
        print("="*60)
        print("Mock-GLua Test Runner — CUH BF3 Port")
        print("="*60)
        try:
            self.setup()
        except Exception as e:
            print(f"\n[SETUP ERROR] {e}")
            traceback.print_exc()
            return 1
        tests = [
            ("Stat cache captures Silenced", self.t_stat_cache_has_silenced),
            ("Silenced reverts after removal", self.t_silenced_reverts),
            ("NWBool Silenced reverts via Detach", self.t_nw_bool_reverts),
            ("Bodygroups revert", self.t_bodygroups_revert),
            ("Grip animations swap + revert", self.t_grip_anims),
            ("shoot_sil animation key exists", self.t_shoot_sil_exists),
            ("Attachment IDs registered", self.t_attachment_ids),
            ("Silenced sound selection", self.t_sound_selection),
            ("Penetration is numeric", self.t_penetration_numeric),
            ("Required SWEP fields", self.t_required_fields),
        ]
        for name, fn in tests:
            print(f"\n--- {name} ---")
            try: fn()
            except Exception as e:
                print(f"  [ERROR] {e}")
                traceback.print_exc()
                self.failed += 1
        print(f"\n{'='*60}")
        total = self.passed + self.failed
        print(f"Results: {self.passed} passed / {total} total")
        if self.failed == 0: print("ALL TESTS PASSED")
        else: print(f"{self.failed} TESTS FAILED")
        print(f"{'='*60}")
        return 0 if self.failed==0 else 1

if __name__ == "__main__":
    verbose = "--verbose" in sys.argv or "-v" in sys.argv
    sys.exit(TestRunner(verbose=verbose).run_all())
