#!/usr/bin/env python3
"""Port TFA BO4 weapons and attachments to the BO4 UHC base."""
import os, re

SRC_W = "/home/z/my-project/repos/bo4_tfa/lua/weapons"
SRC_A = "/home/z/my-project/repos/bo4_tfa/lua/tfa/att"
DST_W = "/home/z/my-project/download/bo4_uhc/lua/weapons"
DST_A = "/home/z/my-project/download/bo4_uhc/lua/customuh_attachments"

os.makedirs(DST_W, exist_ok=True)
os.makedirs(DST_A, exist_ok=True)

WEAPONS = [
    "tfa_bo4_dlc0_abr_223", "tfa_bo4_dlc0_kn57", "tfa_bo4_dlc0_mx9",
    "tfa_bo4_dlc1_icr_7", "tfa_bo4_dlc1_rampart_17",
    "tfa_bo4_dlc2_koshka", "tfa_bo4_dlc2_outlaw", "tfa_bo4_dlc2_sdm",
]

ATTACHMENTS = [
    "bo4_att_acog", "bo4_att_barrel", "bo4_att_ext_mag", "bo4_att_fast_mag",
    "bo4_att_flashlight", "bo4_att_foregrip", "bo4_att_hbs", "bo4_att_holo",
    "bo4_att_hybrid", "bo4_att_laser", "bo4_att_optic_base", "bo4_att_reddot",
    "bo4_att_reflex", "bo4_att_thermal",
]

def extract(content, field):
    m = re.search(r'SWEP\.' + re.escape(field) + r'\s*=\s*(.+)', content)
    if m:
        return m.group(1).strip().rstrip(',').strip()
    return None

def extract_primary(content, field):
    m = re.search(r'SWEP\.Primary\.' + re.escape(field) + r'\s*=\s*(.+)', content)
    if m:
        return m.group(1).strip().rstrip(',').strip()
    return None

def port_weapon(name):
    src_path = os.path.join(SRC_W, name, "shared.lua")
    if not os.path.exists(src_path):
        print(f"  SKIP {name} - source not found")
        return
    with open(src_path) as f:
        content = f.read()

    pn = extract(content, "PrintName") or f'"{name}"'
    vm = extract(content, "ViewModel") or '""'
    wm = extract(content, "WorldModel") or '""'
    ht = extract(content, "HoldType") or '"ar2"'
    
    dmg = extract_primary(content, "Damage") or "30"
    rpm = extract_primary(content, "RPM") or "600"
    ns = extract_primary(content, "NumShots") or "1"
    cs = extract_primary(content, "ClipSize") or "30"
    dc = extract_primary(content, "DefaultClip") or "90"
    ammo = extract_primary(content, "Ammo") or '"ar2"'
    auto = extract_primary(content, "Automatic") or "true"
    snd = extract_primary(content, "Sound") or '""'
    spread = extract_primary(content, "Spread") or "0.03"
    iron_acc = extract_primary(content, "IronAccuracy") or "0.01"
    ku = extract_primary(content, "KickUp") or "0.1"
    kd = extract_primary(content, "KickDown") or "0.1"
    kh = extract_primary(content, "KickHorizontal") or "0.1"
    
    isp = extract(content, "IronSightsPos") or "Vector(0, 0, 0)"
    isa = extract(content, "IronSightsAng") or "Vector(0, 0, 0)"
    if isa.startswith("Vector("):
        isa = isa.replace("Vector(", "Angle(", 1)
    
    ironfov = extract(content, "IronFOV") or "80"
    zoomfov = extract(content, "ZoomFov") or "15"
    move_speed = extract(content, "MoveSpeed") or "1"
    
    bolt = extract(content, "BoltAction") or "false"
    selective = extract(content, "SelectiveFire") or "false"
    disable_burst = extract(content, "DisableBurstFire") or "false"
    only_burst = extract(content, "OnlyBurstFire") or "false"
    rpm_burst = extract_primary(content, "RPM_Burst") or ""
    rpm_semi = extract_primary(content, "RPM_Semi") or ""
    clip_ext = extract_primary(content, "ClipSizeExt") or ""
    
    # Firemode logic
    fm_lines = ""
    if only_burst == "true":
        fm_lines = "SWEP.Firemodes = { { name = 'Burst' } }\nSWEP.BurstRounds = 3"
    elif auto == "true" and selective == "true":
        if disable_burst == "true":
            fm_lines = "SWEP.Firemodes = { { name = 'Auto' }, { name = 'Semi-Auto' } }"
        else:
            fm_lines = "SWEP.Firemodes = { { name = 'Auto' }, { name = 'Burst' }, { name = 'Semi-Auto' } }"
    elif auto == "false" and selective == "true":
        fm_lines = "SWEP.Firemodes = { { name = 'Semi-Auto' } }"
    else:
        fm_lines = "SWEP.Firemodes = { { name = 'Auto' } }" if auto == "true" else "SWEP.Firemodes = { { name = 'Semi-Auto' } }"
    
    # Bolt action
    bolt_lines = ""
    if bolt == "true":
        bolt_lines = "\nSWEP.PlayCycleAnimation = true\nSWEP.CyclePostDelay = 0.7\nSWEP.LastShotAnimation = false"
    
    # Extra fields
    extra = ""
    if clip_ext:
        extra += f"\nSWEP.Primary.ClipSizeExt = {clip_ext}"
    if rpm_burst:
        extra += f"\nSWEP.Primary.RPM_Burst = {rpm_burst}"
    if rpm_semi:
        extra += f"\nSWEP.Primary.RPM_Semi = {rpm_semi}"
    
    short_name = name.replace("tfa_bo4_dlc0_", "").replace("tfa_bo4_dlc1_", "").replace("tfa_bo4_dlc2_", "")
    
    # World model offset (from analysis — all BO4 use same offset)
    wm_block = ""
    wm_block = """
if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetNoDraw(true)
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()
        if IsValid(owner) then
            local offsetVec = Vector(4, -2, 2)
            local offsetAng = Angle(180, 180, 0)
            local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
            if not boneid then return end
            local matrix = owner:GetBoneMatrix(boneid)
            if not matrix then return end
            local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
            WorldModel:SetPos(newPos)
            WorldModel:SetAngles(newAng)
            WorldModel:SetupBones()
        else
            WorldModel:SetPos(self:GetPos())
            WorldModel:SetAngles(self:GetAngles())
        end
        WorldModel:DrawModel()
    end
end"""
    
    out = f'''-- {pn.strip(chr(34))} (BO4) ported to BO4 UHC base.

AddCSLuaFile()

SWEP.Base        = "weapon_bo4_custom_base_gun"
SWEP.Spawnable   = true
SWEP.PrintName   = {pn}
SWEP.Category    = "Black Ops 4: UHC"

SWEP.Slot        = 2
SWEP.HoldType    = {ht}
SWEP.UseHands    = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false

SWEP.ViewModel    = {vm}
SWEP.WorldModel   = {wm}

SWEP.IronsightPos = {isp}
SWEP.IronsightAng = {isa}
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)
SWEP.LoweredPos = Vector(2.95, -3.057, -4.119)
SWEP.LoweredAng = Angle(-13.131, 33.537, -29.906)

SWEP.DamageGeneric        = {dmg}
SWEP.DamageHeadMultiplier = 2.5
SWEP.DamageChestMultiplier = 1.2
SWEP.DamageStomachMultiplier = 1.15
SWEP.DamageLegMultiplier  = 0.9
SWEP.DamageArmMultiplier  = 0.85

SWEP.FireRate    = {rpm}
SWEP.Num         = {ns}
SWEP.AmmoPerShot = 1
SWEP.RangeModifier = 0.95

SWEP.Spread           = {float(spread.split("--")[0].strip()) * 100:.1f}
SWEP.SpreadIronsighted = {float(iron_acc.split("--")[0].strip()) * 100:.1f}

SWEP.ViewSlideRecoilUp    = {float(ku.split("--")[0].strip()) * 10:.1f}
SWEP.ViewSlideRecoilRight = {float(kh.split("--")[0].strip()) * 10:.1f}
SWEP.ViewSlideRecoilIronsightUp    = {float(ku.split("--")[0].strip()) * 7:.1f}
SWEP.ViewSlideRecoilIronsightRight = {float(kh.split("--")[0].strip()) * 7:.1f}
SWEP.RecoilPushbackValue = 1.0

SWEP.ShakeScale    = 0.7
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = {float(move_speed.split("--")[0].strip()) * 0.8:.3f}
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - {ironfov}

SWEP.ZoomFov = {zoomfov}

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = {ammo}
SWEP.Primary.ClipSize      = {cs}
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = {dc}
SWEP.Primary.Automatic    = {auto}

SWEP.Primary.Sound     = {snd}
SWEP.Primary.SilSound  = {snd}

SWEP.Primary.Spread    = {spread}
SWEP.Primary.IronAccuracy = {iron_acc}
SWEP.Primary.MinDamage = {dmg}
SWEP.Primary.MaxDamage = {dmg}
SWEP.Primary.Delay    = 60 / {rpm}
SWEP.Primary.NumberofShots = {ns}
SWEP.Primary.MinRecoil = {float(ku.split("--")[0].strip()) * -1:.2f}
SWEP.Primary.MaxRecoil = {float(kd.split("--")[0].strip()) * -1:.2f}
SWEP.Primary.KickUp    = {ku}
SWEP.Primary.KickDown  = {kd}
SWEP.Primary.KickHorizontal = {kh}

{fm_lines}
SWEP.ReloadSpeed = 1
SWEP.Chambering = true

SWEP.Animations = {{
    ["shoot"]        = "base_fire",
    ["reload"]       = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["iron_fire"]    = "base_fire_ads",
    ["idle"]         = "base_idle",
    ["deploy"]       = "base_draw",
    ["sprint_idle"]  = "base_sprint_loop",
    ["sprint_in"]    = "base_sprint_in",
    ["sprint_out"]   = "base_sprint_out",
    ["melee"]        = "base_melee",
}}

SWEP.MagInTime      = 1.0
SWEP.MagInTimeEmpty = 1.5
SWEP.MagOutTime     = 0.3
SWEP.MagOutTimeEmpty = 0.3

SWEP.BashDamage    = 50
SWEP.BashRange     = 96

SWEP.WeaponWeight = 3.0

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true
SWEP.ReloadTable = {{}}
SWEP.AnimSounds = {{}}

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(0, 200, 255)
SWEP.MuzzleFlashLightSize = 128

SWEP.AnimatedSprint = true{bolt_lines}{extra}
{wm_block}
'''
    
    out_path = os.path.join(DST_W, f"bo4_uhc_{short_name}.lua")
    with open(out_path, 'w') as f:
        f.write(out)
    print(f"  OK {os.path.basename(out_path)}")

def port_attachment(name):
    src_path = os.path.join(SRC_A, name + ".lua")
    if not os.path.exists(src_path):
        print(f"  SKIP {name} - source not found")
        return
    with open(src_path) as f:
        content = f.read()
    
    # Just copy as-is — the attachment format is already compatible
    # with our CustomUH system (ATTACHMENT.Name, WeaponTable, Attach/Detach)
    out_path = os.path.join(DST_A, name + ".lua")
    with open(out_path, 'w') as f:
        f.write(content)
    print(f"  OK {os.path.basename(out_path)}")

print("Porting BO4 weapons...")
for name in WEAPONS:
    port_weapon(name)

print("\nPorting BO4 attachments...")
for name in ATTACHMENTS:
    port_attachment(name)

print(f"\nDone. {len(WEAPONS)} weapons + {len(ATTACHMENTS)} attachments ported.")
