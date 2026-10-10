#!/usr/bin/env python3
"""Port TFA NMRIH weapons to MCV base."""
import os, re

SRC = "/home/z/my-project/repos/tfa_nmrih/lua/weapons"
DST = "/home/z/my-project/download/mcv_nmrih_port/lua/weapons"

FIREARMS = [
    "tfa_nmrih_1892", "tfa_nmrih_1911", "tfa_nmrih_500a", "tfa_nmrih_870",
    "tfa_nmrih_cz", "tfa_nmrih_fal", "tfa_nmrih_g17", "tfa_nmrih_jae700",
    "tfa_nmrih_m16_ch", "tfa_nmrih_m16_rt", "tfa_nmrih_m92fs", "tfa_nmrih_mac10",
    "tfa_nmrih_mkiii", "tfa_nmrih_mp5", "tfa_nmrih_rug1022", "tfa_nmrih_rug1022_25",
    "tfa_nmrih_sako", "tfa_nmrih_sako_is", "tfa_nmrih_sks", "tfa_nmrih_sks_nb",
    "tfa_nmrih_superx3", "tfa_nmrih_sv10", "tfa_nmrih_sw686",
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
    src_path = os.path.join(SRC, name, "shared.lua")
    if not os.path.exists(src_path):
        print(f"  SKIP {name} - source not found")
        return
    
    with open(src_path) as f:
        content = f.read()
    
    pn = extract(content, "PrintName") or f'"{name}"'
    vm = extract(content, "ViewModel") or '""'
    wm = extract(content, "WorldModel") or '""'
    fov = extract(content, "ViewModelFOV") or "65"
    ht = extract(content, "HoldType") or '"pistol"'
    
    dmg = extract_primary(content, "Damage") or "30"
    rpm = extract_primary(content, "RPM") or "600"
    ns = extract_primary(content, "NumShots") or "1"
    cs = extract_primary(content, "ClipSize") or "30"
    dc = extract_primary(content, "DefaultClip") or "90"
    ammo = extract_primary(content, "Ammo") or '"pistol"'
    auto = extract_primary(content, "Automatic") or "false"
    snd = extract_primary(content, "Sound") or '""'
    
    isp = extract(content, "IronSightsPos") or "Vector(0, 0, 0)"
    isa = extract(content, "IronSightsAng") or "Vector(0, 0, 0)"
    
    # Convert IronSightsAng Vector to Angle
    if isa.startswith("Vector("):
        isa = isa.replace("Vector(", "Angle(", 1)
    
    sg = "true" if (extract(content, "Shotgun") == "true" or extract(content, "LoopedReload") == "true") else "false"
    bolt = extract(content, "BoltAction") or "false"
    
    if ht == '"shotgun"':
        aht = '"rpg"'
        mp = "vietnam_muzzleflash_shotgun_type1_fp"
        mps = "vietnam_muzzleflash_shotgun_type1_fp_smoke"
        mpi = "vietnam_muzzleflash_shotgun_type1_fp_is"
        mpis = "vietnam_muzzleflash_shotgun_type1_fp_is_smoke"
        mptp = "vietnam_muzzleflash_shotgun_type1_tp"
        bt = "4"
        tr = "vietnam_tracer_shotgun_primary"
        slot = 3
    elif ht == '"pistol"':
        aht = '"revolver"'
        mp = "vietnam_muzzleflash_pistol_type1_fp"
        mps = "vietnam_muzzleflash_pistol_type1_fp_smoke"
        mpi = "vietnam_muzzleflash_pistol_type1_fp_is"
        mpis = "vietnam_muzzleflash_pistol_type1_fp_is_smoke"
        mptp = "vietnam_muzzleflash_pistol_type1_tp"
        bt = "2"
        tr = "vietnam_tracer_pistol_primary"
        slot = 1
    else:
        aht = '"rpg"'
        mp = "vietnam_muzzleflash_rifle_type1_fp"
        mps = "vietnam_muzzleflash_rifle_type1_fp_smoke"
        mpi = "vietnam_muzzleflash_rifle_type1_fp_is"
        mpis = "vietnam_muzzleflash_rifle_type1_fp_is_smoke"
        mptp = "vietnam_muzzleflash_rifle_type1_tp"
        bt = "3"
        tr = "vietnam_tracer_rifle_primary"
        slot = 2
    
    if auto == "true":
        fm = "{ MCV.FIREMODE_AUTO, MCV.FIREMODE_SEMI }"
    else:
        fm = "{ MCV.FIREMODE_SEMI }"
    
    sg_line = f"SWEP.ShotgunReload = {sg}" if sg == "true" else "-- SWEP.ShotgunReload = false"
    
    bolt_lines = ""
    if bolt == "true":
        bolt_lines = "\nSWEP.PlayCycleAnimation = true\nSWEP.AnimationHandlesHammer = true"
    
    short_name = name.replace("tfa_nmrih_", "")
    
    out = f'''-- {pn.strip(chr(34))} (NMRIH) ported to MCV base via mcv_nmrih_base.

AddCSLuaFile()

SWEP.Base        = "mcv_nmrih_base"
SWEP.Spawnable   = true
SWEP.PrintName   = {pn}
SWEP.Category    = "TFA NMRIH (MCV Port)"

SWEP.Slot        = {slot}
SWEP.HoldType    = {ht}
SWEP.AimHoldType = {aht}

SWEP.ViewModel    = {vm}
SWEP.WorldModel   = {wm}
SWEP.ViewModelFOV = {fov}
SWEP.ViewModelFlip = false
SWEP.UseHands    = true

SWEP.IronsightPos = {isp}
SWEP.IronsightAng = {isa}
SWEP.CustomPos = Vector(0, 0, 0)
SWEP.CustomAng = Angle(0, 0, 0)

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

SWEP.Spread           = 6.0
SWEP.SpreadIronsighted = 1.0

SWEP.ViewSlideRecoilUp    = 1.0
SWEP.ViewSlideRecoilRight = 0.3
SWEP.ViewSlideRecoilIronsightUp    = 0.7
SWEP.ViewSlideRecoilIronsightRight = 0.2
SWEP.RecoilPushbackValue = 0.8

SWEP.ShakeScale    = 0.7
SWEP.ShakeFreq     = 50
SWEP.ShakeDuration = 0.3

SWEP.IronsightSpeedScale    = 0.8
SWEP.IronsightWalkBobbingStrength = -0.25
SWEP.IronsightFov = 90 - 10

SWEP.HasScope = false
SWEP.HasBayonet = false
SWEP.HasBipod = false

SWEP.Primary.Ammo         = {ammo}
SWEP.Primary.ClipSize      = {cs}
SWEP.Primary.Chamber      = 1
SWEP.Primary.DefaultClip  = {dc}
SWEP.Primary.Automatic    = {auto}

SWEP.Firemodes = {fm}

SWEP.SoundSingleShot = {snd}
SWEP.SoundEmpty = "Weapon_Pistol.Empty"
SWEP.SoundNearlyEmpty = "Weapon_Pistol.Empty"

SWEP.MuzzleParticle          = "{mp}"
SWEP.MuzzleParticleSmoke     = "{mps}"
SWEP.MuzzleParticleIronsighted = "{mpi}"
SWEP.MuzzleParticleIronsightedSmoke = "{mpis}"
SWEP.MuzzleParticle3rdPerson = "{mptp}"

SWEP.EjectBrassType   = {bt}
SWEP.EjectBrassTrail  = "vietnam_weaponeffect_shelleject_trail"
SWEP.EjectBrassParticle = "vietnam_weaponeffect_shelleject_side"

SWEP.TracerParticle   = "{tr}"
SWEP.TracerParticle2  = "{tr}_secondary"
SWEP.TracerFrequency  = 4

SWEP.MetalPenetrationDepth = 8
SWEP.GlassPenetrationDepth = 14
SWEP.ConcretePenetrationDepth = 10
SWEP.WoodPenetrationDepth = 18
SWEP.OtherPenetrationDepth = 12

SWEP.MagInTime      = 1.0
SWEP.MagInTimeEmpty = 1.5
SWEP.MagOutTime     = 0.3
SWEP.MagOutTimeEmpty = 0.3

SWEP.BashDamage    = 5
SWEP.BashRange     = 96
SWEP.BayonetDamage = 100
SWEP.BayonetRange  = 128

SWEP.WeaponWeight = 3.0

SWEP.CrouchSpreadMultiplier = 0.85
SWEP.ProneSpreadMultiplier = 0.75
SWEP.StandMoveSpreadMultiplier = 1.5
SWEP.SneakMoveSpreadMultiplier = 1.4
SWEP.CrouchMoveSpreadMultiplier = 1.35
SWEP.JumpSpreadMultiplier = 3.0

{sg_line}
SWEP.ShotgunReloadRounds = 1
SWEP.PlayCycleAnimation = false
SWEP.CyclePostDelay = 0.7
SWEP.LastShotAnimation = false
SWEP.NoEjectOnShoot = false
SWEP.HasEmptyReload = true{bolt_lines}
'''
    
    out_path = os.path.join(DST, f"mcv_nmrih_{short_name}.lua")
    with open(out_path, 'w') as f:
        f.write(out)
    print(f"  OK {os.path.basename(out_path)}")

print("Porting NMRIH firearms...")
for name in FIREARMS:
    port_weapon(name)

print(f"\nDone. {len(FIREARMS)} weapons ported.")
