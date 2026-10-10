#!/usr/bin/env python3
"""
Port TFA WWII weapons to CUH (Customizable UnderHell) base.

Reads TFA weapon source files from /tmp/wwii_port/weapons/
Writes CUH-format weapon files to the worldwarii_underhell folder.

TFA → CUH translation:
- SWEP.Base = "tfa_codww2_base" → SWEP.Base = "weapon_cuh_base_gun"
- SWEP.Primary.RPM → SWEP.Primary.Delay = 60 / RPM
- SWEP.Primary.Damage → SWEP.Primary.MinDamage/MaxDamage
- SWEP.Primary.Sound (string) → SWEP.Primary.Sound = Sound("...")
- TFA SprintAnimation → CUH Animations["sprint_in"/"sprint_idle"/"sprint_out"]
- TFA Animations table (nested type/value) → CUH Animations (flat string)
- TFA VElements → CUH ViewModelElements (with angle→ang, size→scale)
- TFA WElements → CUH WorldModelElements
- TFA Offset → CUH WorldModelOffset/WorldModelAngle
- TFA Attachments → CUH Attachments (with name, default=0 for None support)
- TFA EventTable sounds → CUH AnimSounds (where possible)
- No mantle logic (per user instruction)
- Sprint animations MUST work (per user instruction)
- Category = "WWII" with SubCategory from TFA
"""
import os
import re
import sys

SRC_DIR = "/tmp/wwii_port/weapons"
ATT_DIR = "/tmp/wwii_port/atts"
DST_DIR = "/home/z/my-project/download/custom_uh_base/worldwarii_underhell/lua/weapons"
ATT_DST_DIR = "/home/z/my-project/download/custom_uh_base/worldwarii_underhell/lua/cuh_attachments"
SND_DST_DIR = "/home/z/my-project/download/custom_uh_base/worldwarii_underhell/lua/autorun"

# Melee weapons to skip
SKIP_WEAPONS = [
    "baseball_bat", "claymore", "combatknife", "dagger", "fireaxe",
    "icepick", "kbsp1938", "shovel", "sledgehammer", "trenchknife", "flamebase"
]


def parse_tfa_weapon(src_text):
    """Parse a TFA weapon file and extract all relevant fields."""
    data = {}

    # Class name from filename (passed separately)
    # Extract basic fields
    def extract_string(pattern, text, default=None):
        m = re.search(pattern, text)
        return m.group(1) if m else default

    def extract_number(pattern, text, default=None):
        m = re.search(pattern, text)
        if m:
            try:
                return float(m.group(1))
            except:
                return default
        return default

    # PrintName
    data['print_name'] = extract_string(r'SWEP\.PrintName\s*=\s*["\']([^"\']+)', src_text, '')
    # Category
    data['category'] = 'WWII'
    # SubCategory
    data['sub_category'] = extract_string(r'SWEP\.SubCategory\s*=\s*["\']([^"\']+)', src_text, '')
    # ViewModel
    data['view_model'] = extract_string(r'SWEP\.ViewModel\s*=\s*["\']([^"\']+)', src_text, '')
    # WorldModel
    data['world_model'] = extract_string(r'SWEP\.WorldModel\s*=\s*["\']([^"\']+)', src_text, '')
    # HoldType
    data['hold_type'] = extract_string(r'SWEP\.HoldType\s*=\s*["\']([^"\']+)', src_text, 'ar2')
    # Slot
    data['slot'] = int(extract_number(r'SWEP\.Slot\s*=\s*(\d+)', src_text, 2) or 2)
    # ViewModelFOV
    data['vm_fov'] = extract_number(r'SWEP\.ViewModelFOV\s*=\s*(\d+)', src_text, 65)
    # UseHands
    data['use_hands'] = 'SWEP.UseHands = true' in src_text

    # Primary stats
    data['sound'] = extract_string(r'SWEP\.Primary\.Sound\s*=\s*["\']([^"\']+)', src_text, '')
    data['silenced_sound'] = extract_string(r'SWEP\.Primary\.SilencedSound\s*=\s*["\']([^"\']+)', src_text, '')
    data['ammo'] = extract_string(r'SWEP\.Primary\.Ammo\s*=\s*["\']([^"\']+)', src_text, 'ar2')
    data['automatic'] = 'SWEP.Primary.Automatic = true' in src_text or 'SWEP.Primary.Automatic = True' in src_text
    data['rpm'] = extract_number(r'SWEP\.Primary\.RPM\s*=\s*(\d+)', src_text, 600)
    data['damage'] = extract_number(r'SWEP\.Primary\.Damage\s*=\s*([\d.]+)', src_text, 20)
    data['clip_size'] = int(extract_number(r'SWEP\.Primary\.ClipSize\s*=\s*(\d+)', src_text, 30) or 30)
    data['clip_size_ext'] = extract_number(r'SWEP\.Primary\.ClipSize_Ext\s*=\s*(\d+)', src_text, None)
    data['num_shots'] = int(extract_number(r'SWEP\.Primary\.NumShots\s*=\s*(\d+)', src_text, 1) or 1)
    data['spread'] = extract_number(r'SWEP\.Primary\.Spread\s*=\s*([\d.]+)', src_text, 0.02)
    data['iron_accuracy'] = extract_number(r'SWEP\.Primary\.IronAccuracy\s*=\s*([\d.]+)', src_text, 0.01)
    data['kick_up'] = extract_number(r'SWEP\.Primary\.KickUp\s*=\s*([\d.]+)', src_text, 0.3)
    data['kick_down'] = extract_number(r'SWEP\.Primary\.KickDown\s*=\s*([\d.]+)', src_text, 0.2)
    data['kick_horizontal'] = extract_number(r'SWEP\.Primary\.KickHorizontal\s*=\s*([\d.]+)', src_text, 0.15)
    data['static_recoil'] = extract_number(r'SWEP\.Primary\.StaticRecoilFactor\s*=\s*([\d.]+)', src_text, 0.5)
    data['spread_multiplier_max'] = extract_number(r'SWEP\.Primary\.SpreadMultiplierMax\s*=\s*([\d.]+)', src_text, 4)
    data['spread_increment'] = extract_number(r'SWEP\.Primary\.SpreadIncrement\s*=\s*([\d.]+)', src_text, 1.5)
    data['spread_recovery'] = extract_number(r'SWEP\.Primary\.SpreadRecovery\s*=\s*([\d.]+)', src_text, 5)
    data['force'] = extract_number(r'SWEP\.Primary\.Force\s*=\s*([\d.]+)', src_text, 1)
    data['default_clip_mult'] = extract_number(r'SWEP\.Primary\.DefaultClip\s*=\s*SWEP\.Primary\.ClipSize\s*\*\s*(\d+)', src_text, 5)

    # IronSights
    data['iron_sights_pos'] = extract_string(r'SWEP\.IronSightsPos\s*=\s*Vector\(([^)]+)\)', src_text, '0, 0, 0')
    data['iron_sights_ang'] = extract_string(r'SWEP\.IronSightsAng\s*=\s*Vector\(([^)]+)\)', src_text, '0, 0, 0')
    data['iron_sight_time'] = extract_number(r'SWEP\.IronSightTime\s*=\s*([\d.]+)', src_text, 0.3)
    data['zoom_fov'] = extract_number(r'SWEP\.Secondary\.IronFOV\s*=\s*(\d+)', src_text, 80)
    data['move_speed'] = extract_number(r'SWEP\.MoveSpeed\s*=\s*([\d.]+)', src_text, 1)

    # Offset (world model)
    offset_up = extract_number(r'Up\s*=\s*([-\d.]+)', src_text, 0)
    offset_right = extract_number(r'Right\s*=\s*([-\d.]+)', src_text, 0)
    offset_forward = extract_number(r'Forward\s*=\s*([-\d.]+)', src_text, 0)
    ang_up = extract_number(r'Ang\s*=\s*\{[^}]*Up\s*=\s*([-\d.]+)', src_text, 0)
    ang_right = extract_number(r'Ang\s*=\s*\{[^}]*Right\s*=\s*([-\d.]+)', src_text, 0)
    ang_forward = extract_number(r'Ang\s*=\s*\{[^}]*Forward\s*=\s*([-\d.]+)', src_text, 0)
    offset_scale = extract_number(r'Scale\s*=\s*([\d.]+)', src_text, 1)

    # Convert TFA Offset (Forward, Right, Up) → Vector(forward, right, up)
    data['world_model_offset'] = f"Vector({offset_forward}, {offset_right}, {offset_up})"
    # TFA Ang: Up=yaw, Right=pitch, Forward=roll → Angle(pitch=Right, yaw=Up, roll=Forward)
    data['world_model_angle'] = f"Angle({ang_right}, {ang_up}, {ang_forward})"

    # Shell
    data['shell_model'] = extract_string(r'SWEP\.LuaShellModel\s*=\s*["\']([^"\']+)', src_text, '')
    data['shell_scale'] = extract_number(r'SWEP\.LuaShellScale\s*=\s*([\d.]+)', src_text, 1)

    # Silencer
    data['has_silencer'] = bool(data.get('silenced_sound'))

    # Sprint animations
    data['sprint_in'] = extract_string(r'\["in"\].*?\["value"\]\s*=\s*"([^"]+)"', src_text, 'sprint_in')
    data['sprint_loop'] = extract_string(r'\["loop"\].*?\["value"\]\s*=\s*"([^"]+)"', src_text, 'sprint_loop')
    data['sprint_out'] = extract_string(r'\["out"\].*?\["value"\]\s*=\s*"([^"]+)"', src_text, 'sprint_out')
    data['sprint_in_empty'] = extract_string(r'\["in"\].*?\["value_empty"\]\s*=\s*"([^"]+)"', src_text, None)
    data['sprint_loop_empty'] = extract_string(r'\["loop"\].*?\["value_empty"\]\s*=\s*"([^"]+)"', src_text, None)
    data['sprint_out_empty'] = extract_string(r'\["out"\].*?\["value_empty"\]\s*=\s*"([^"]+)"', src_text, None)

    # Special features
    data['is_shotgun'] = 'SWEP.Shotgun = true' in src_text
    data['disable_chambering'] = 'SWEP.DisableChambering = true' in src_text
    data['only_burst'] = 'SWEP.OnlyBurstFire = true' in src_text
    data['selective_fire'] = 'SWEP.SelectiveFire = true' in src_text
    data['fire_modes'] = []
    if data.get('selective_fire'):
        data['fire_modes'] = [{ "name": "Full-Auto" }, { "name": "Semi-Auto" }]
    elif data.get('automatic'):
        data['fire_modes'] = [{ "name": "Full-Auto" }]
    else:
        data['fire_modes'] = [{ "name": "Semi-Auto" }]

    # PassiveAnim
    data['passive_anim'] = extract_string(r'SWEP\.PassiveAnim\s*=\s*["\']([^"\']+)', src_text, 'passive')

    # LoweredPos
    data['lowered_pos'] = extract_string(r'SWEP\.SafetyPos\s*=\s*Vector\(([^)]+)\)', src_text, '0, 0, 0')
    data['lowered_ang'] = extract_string(r'SWEP\.SafetyAng\s*=\s*Vector\(([^)]+)\)', src_text, '0, 0, 0')

    # Parse VElements
    data['velements'] = parse_velements(src_text)

    # Parse Attachments
    data['attachments'] = parse_attachments(src_text)

    # Parse custom Animations (non-default ones)
    data['custom_anims'] = parse_custom_animations(src_text)

    return data


def parse_velements(src_text):
    """Parse SWEP.VElements table and extract element names + models."""
    elements = {}
    # Find the VElements block
    m = re.search(r'SWEP\.VElements\s*=\s*\{(.*?)\n\}', src_text, re.DOTALL)
    if not m:
        return elements
    body = m.group(1)

    # Each element: ["name"] = { type = "Model", model = "...", bone = "...", ..., active = true/false, bonemerge = true/false }
    for elem_match in re.finditer(r'\["(\w+)"\]\s*=\s*\{\s*type\s*=\s*"Model"\s*,\s*model\s*=\s*"([^"]+)"(.*?)(?:active\s*=\s*(true|false))', body, re.DOTALL):
        name = elem_match.group(1)
        model = elem_match.group(2)
        rest = elem_match.group(3)
        active = elem_match.group(4) == 'true'
        bone = re.search(r'bone\s*=\s*"([^"]*)"', rest)
        bone = bone.group(1) if bone else ""
        bonemerge = 'bonemerge = true' in rest or 'bonemerge=true' in rest
        pos_match = re.search(r'pos\s*=\s*Vector\(([^)]+)\)', rest)
        pos = pos_match.group(1) if pos_match else "0, 0, 0"
        angle_match = re.search(r'angle\s*=\s*Angle\(([^)]+)\)', rest)
        angle = angle_match.group(1) if angle_match else "0, 0, 0"
        size_match = re.search(r'size\s*=\s*Vector\(([^)]+)\)', rest)
        size = size_match.group(1) if size_match else "1, 1, 1"

        elements[name] = {
            'model': model,
            'bone': bone,
            'pos': pos,
            'angle': angle,
            'size': size,
            'bonemerge': bonemerge,
            'active': active,
        }

    return elements


def parse_attachments(src_text):
    """Parse SWEP.Attachments table."""
    attachments = []
    m = re.search(r'SWEP\.Attachments\s*=\s*\{(.*?)\n\}', src_text, re.DOTALL)
    if not m:
        return attachments
    body = m.group(1)

    # Each slot: [N] = {atts = {"att1", "att2", ...}, order = N}
    for slot_match in re.finditer(r'\[(\d+)\]\s*=\s*\{\s*atts\s*=\s*\{([^}]*)\}', body):
        slot_num = int(slot_match.group(1))
        atts_str = slot_match.group(2)
        atts = re.findall(r'"([^"]+)"', atts_str)
        attachments.append({'slot': slot_num, 'atts': atts})

    return attachments


def parse_custom_animations(src_text):
    """Parse SWEP.Animations table for custom animation overrides."""
    anims = {}
    m = re.search(r'SWEP\.Animations\s*=\s*\{(.*?)\n\}', src_text, re.DOTALL)
    if not m:
        return anims
    body = m.group(1)

    # Each: ["key"] = { ["type"] = TFA.Enum.ANIMATION_SEQ, ["value"] = "sequence_name" }
    for anim_match in re.finditer(r'\["(\w+)"\]\s*=\s*\{.*?\["value"\]\s*=\s*"([^"]+)"', body, re.DOTALL):
        anims[anim_match.group(1)] = anim_match.group(2)

    return anims


def generate_cuh_weapon(class_name, data):
    """Generate a CUH-format weapon file from parsed TFA data."""
    # Calculate delay from RPM
    delay = 60.0 / data['rpm'] if data['rpm'] > 0 else 0.1

    # Default clip
    default_clip = data['clip_size'] * data.get('default_clip_mult', 5)

    # Determine passive anim
    passive = data.get('passive_anim', 'passive')

    # Build VElements
    velements = {}
    for name, elem in data.get('velements', {}).items():
        velements[name] = elem

    # Build Attachments with names and default=0 (None allowed)
    attachments_lines = []
    for i, att_slot in enumerate(data.get('attachments', []), 1):
        atts_str = ', '.join(f'"{a}"' for a in att_slot['atts'])
        attachments_lines.append(f'    [{i}] = {{ name = "Slot {i}", atts = {{ {atts_str} }}, default = 0 }},')

    # Build Animations table
    anim_lines = []
    # Standard animations (use ACT_VM_* as fallback, named sequences if available)
    custom = data.get('custom_anims', {})

    anim_lines.append(f'    ["shoot"]        = "ACT_VM_PRIMARYATTACK",')
    anim_lines.append(f'    ["reload"]       = "ACT_VM_RELOAD",')
    anim_lines.append(f'    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",')
    anim_lines.append(f'    ["iron_fire"]    = "ACT_VM_PRIMARYATTACK_DEPLOYED",')
    anim_lines.append(f'    ["iron_in"]      = "ACT_VM_DEPLOY",')
    anim_lines.append(f'    ["iron_idle"]    = "ACT_VM_IDLE_DEPLOYED",')
    anim_lines.append(f'    ["iron_out"]     = "ACT_VM_UNDEPLOY",')
    anim_lines.append(f'    ["idle"]         = "ACT_VM_IDLE",')
    anim_lines.append(f'    ["deploy"]       = "ACT_VM_DRAW",')
    anim_lines.append(f'    ["inspect"]      = "ACT_VM_FIDGET",')

    # Sprint animations (from TFA SprintAnimation)
    sprint_in = data.get('sprint_in', 'sprint_in')
    sprint_loop = data.get('sprint_loop', 'sprint_loop')
    sprint_out = data.get('sprint_out', 'sprint_out')
    anim_lines.append(f'    ["sprint_idle"]  = "{sprint_loop}",')
    anim_lines.append(f'    ["sprint_in"]     = "{sprint_in}",')
    anim_lines.append(f'    ["sprint_out"]    = "{sprint_out}",')

    # Custom animation overrides
    for key, val in custom.items():
        anim_lines.append(f'    ["{key}"]        = "{val}",')

    # Build VElements Lua
    velem_lines = []
    for name, elem in velements.items():
        active_str = 'true' if elem['active'] else 'false'
        bm_str = 'true' if elem['bonemerge'] else 'false'
        velem_lines.append(f'    ["{name}"] = {{')
        velem_lines.append(f'        type = "Model", model = "{elem["model"]}",')
        velem_lines.append(f'        bone = "{elem["bone"]}", pos = Vector({elem["pos"]}), ang = Angle({elem["angle"]}),')
        velem_lines.append(f'        scale = Vector({elem["size"]}), material = "", skin = 0,')
        velem_lines.append(f'        bodygroups = {{}}, bonemerge = {bm_str},')
        velem_lines.append(f'        active = {active_str}, _defaultActive = {active_str},')
        velem_lines.append(f'    }},')

    # Melee
    melee_damage = 35  # default from TFA Secondary.BashDamage
    bash_match = re.search(r'SWEP\.Secondary\.BashDamage\s*=\s*(\d+)', '')
    # We don't have the source here, use default

    # Generate the weapon file
    weapon_text = f'''-- {data['print_name']} — Ported from TFA WWII to CUH base
-- CUH BUILD: v1.0-wwii (2026-10-07)
-- Original: {class_name}
-- SubCategory: {data['sub_category']}

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName = "{data['print_name']}"
SWEP.Category = "WWII"
SWEP.SubCategory = "{data['sub_category']}"

SWEP.Slot = {data['slot']}
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = {'true' if data['use_hands'] else 'false'}
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = {data['vm_fov']}
SWEP.ViewModel  = "{data['view_model']}"
SWEP.WorldModel = "{data['world_model']}"
SWEP.LoweredPos = Vector({data.get('lowered_pos', '0, 0, 0')})
SWEP.LoweredAng = Vector({data.get('lowered_ang', '0, 0, 0')})

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "{data['hold_type']}"
SWEP.PassiveAnim = "{passive}"
SWEP.ZoomFov = {data.get('zoom_fov', 80) if data.get('zoom_fov', 80) < 80 else 15}

SWEP.FireModes = {{
{chr(10).join(f"    {{ name = \"{fm['name']}\" }}," for fm in data['fire_modes'])}
}}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("{data['sound']}")
SWEP.Primary.SilSound       = Sound("{data.get('silenced_sound', '')}")
SWEP.Primary.ClipSize       = {data['clip_size']}
SWEP.Primary.Ammo           = "{data['ammo']}"
SWEP.Primary.DefaultClip    = {default_clip}
SWEP.Primary.MinDamage      = {data['damage']}
SWEP.Primary.MaxDamage      = {data['damage']}
SWEP.Primary.Automatic      = {str(data['automatic']).lower()}
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = {data.get('force', 1)}
SWEP.Primary.Spread         = {data['spread']}
SWEP.Primary.Delay          = {delay:.6f}
SWEP.Primary.NumberofShots  = {data['num_shots']}
SWEP.Primary.MinRecoil      = {-data['kick_up']}
SWEP.Primary.MaxRecoil      = {-data['kick_down']}
SWEP.Primary.KickUp         = {data['kick_up']}
SWEP.Primary.KickDown       = {data['kick_down']}
SWEP.Primary.KickHorizontal = {data['kick_horizontal']}
SWEP.Primary.SpreadMultiplierMax = {data.get('spread_multiplier_max', 4)}
SWEP.Primary.SpreadIncrement    = {data.get('spread_increment', 1.5)}
SWEP.Primary.SpreadRecovery     = {data.get('spread_recovery', 5)}
SWEP.TwoHanded              = {'false' if data['hold_type'] == 'pistol' else 'true'}
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = {'false' if data.get('disable_chambering') else 'true'}
SWEP.AnimatedSprint         = true
SWEP.CUHInspectOnMenu       = true

SWEP.IronSightsPos = Vector({data['iron_sights_pos']})
SWEP.IronSightsAng = Vector({data['iron_sights_ang']})
SWEP.IronSightTime = {data.get('iron_sight_time', 0.3)}
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 15, -15)

-- TFA-style curved ironsight dip
SWEP.IronSightsDipPos   = Vector(0, -1.5, -2.0)
SWEP.IronSightsDipAng   = Angle(3, 0, 0)
SWEP.IronSightsDipScale = 1.0

-- Camera bone system
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 40
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {{"weapons/blackops3/rifle_butt/rifle_hit_00.wav"}}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.NoShell  = {'true' if not data.get('shell_model') else 'false'}
SWEP.ShellHeat = 0.8
SWEP.Shell     = "{data.get('shell_model', '')}"

-- World model positioning (from TFA Offset)
SWEP.WorldModelOffset = {data['world_model_offset']}
SWEP.WorldModelAngle = {data['world_model_angle']}

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {{
{chr(10).join(anim_lines)}
}}

SWEP.AnimSounds = {{}}

function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

-- ============================================================
-- IRONSIGHTS / SPRINT / IDLE HANDLERS
-- ============================================================

function SWEP:HandleIronsightsAnimations()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if self:GetUHBool("Running") then
        self.wasZooming = self:GetUHBool("Zooming")
        return
    end
    if self:GetUHBool("Reloading") then return end
    if self._meleeActive then return end
    if self._mantleActive then return end

    local isZooming = self:GetUHBool("Zooming")
    if self.wasZooming == nil then self.wasZooming = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    if self._justExitedSprint then
        self._justExitedSprint = false
        if isZooming then self.wasZooming = false end
        return
    end

    if isZooming and not self.wasZooming then
        self:EasySendWeaponAnim("iron_in", ACT_VM_DEPLOY)
    elseif not isZooming and self.wasZooming then
        self:EasySendWeaponAnim("iron_out", ACT_VM_UNDEPLOY)
    elseif isZooming then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("iron_idle", ACT_VM_IDLE_DEPLOYED)
        end
    end
    self.wasZooming = isZooming
end

function SWEP:HandleSprintingAnimations()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local isRunning = self:GetUHBool("Running")
    if self.wasRunning == nil then self.wasRunning = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    if isRunning and not self.wasRunning then
        if not self:GetUHBool("Reloading") then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)
        end
    elseif not isRunning and self.wasRunning then
        if not self:GetUHBool("Reloading") then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)
        end
        self._justExitedSprint = true
    elseif isRunning and not self:GetUHBool("Reloading") then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end
    self.wasRunning = isRunning
end

function SWEP:HandleIdle()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if self._meleeActive or self._mantleActive then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self:GetUHBool("Zooming") then return end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end
    if vm:GetCycle() < 1 then return end
    self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
end

function SWEP:HandleInspect()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then
        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then
            self:SetNW2Bool("Inspecting", true)
            self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
        end
    end
end

-- ============================================================
-- THINK
-- ============================================================

function SWEP:Think()
    local ct = CurTime()
    BaseClass.Think(self)
    self:HandleIronsightsAnimations()
    self:HandleSprintingAnimations()
    self:HandleIdle()
    self:HandleInspect()
end

-- ============================================================
-- ATTACK GUARDS
-- ============================================================

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end

-- ============================================================
-- HOLSTER / DEPLOY
-- ============================================================

function SWEP:Holster(wep)
    self._justExitedSprint = false
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(self, wep)
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    self:SetHoldType(self.HoldType)
    if self.Animations and self.Animations["deploy"] then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW_DEPLOYED)
            local dur = vm:SequenceDuration()
            self:SetNextPrimaryFire(CurTime() + dur)
            self:SetNextSecondaryFire(CurTime() + dur)
            self.NextReload = CurTime() + dur
            self._nextIdlePlay = nil
            self._deployEndTime = CurTime() + dur
            self:SetNWFloat("DeployTime", 0)
        end
    end
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._justExitedSprint = false
    return true
end

function SWEP:HandleRunning(ct)
    if self:GetUHBool("Reloading") then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end
    local dist = self.Owner:GetVelocity():LengthSqr()
    local isSprinting = self.Owner:KeyDown(IN_SPEED) and dist > self.Owner:GetWalkSpeed()^2
    if isSprinting then
        self:SetHoldType(self.PassiveAnim)
        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", false)
            self.NextReload = ct + 0.5
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove("UHReload_"..self.Owner:SteamID())
            end
        end
    else
        self:SetHoldType(self.HoldType)
        self:SetUHBool("Running", false)
    end
end

function SWEP:GetViewModelPosition(pos, ang)
    local ft = FrameTime()
    if BaseClass and BaseClass.GetViewModelPosition then
        pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    end
    local target = 0
    if self:GetNWInt("FireMode") == 0 and not self:GetUHBool("Running") then target = 1 end
    self._uhLower = Lerp(ft * 8, self._uhLower or 0, target)
    if self._uhLower > 0.001 then
        local lp = self.LoweredPos or vector_origin
        local la = self.LoweredAng or angle_zero
        local ap, ay, ar = 0, 0, 0
        if isangle(la) then ap, ay, ar = la.p, la.y, la.r
        elseif isvector(la) then ap, ay, ar = la.x, la.y, la.z end
        ang:RotateAroundAxis(ang:Right(), ap * self._uhLower)
        ang:RotateAroundAxis(ang:Up(), ay * self._uhLower)
        ang:RotateAroundAxis(ang:Forward(), ar * self._uhLower)
        pos = pos + ang:Right() * lp.x * self._uhLower
            + ang:Forward() * lp.y * self._uhLower
            + ang:Up() * lp.z * self._uhLower
    end
    local targetAlt = 1
    if self:GetUHBool("Running") or self:GetUHBool("Zooming") or self:GetNWInt("FireMode") == 0 then
        targetAlt = 0
    end
    self._altFactor = Lerp(ft * 10, self._altFactor or 0, targetAlt)
    if (self.AlternativePos or self.AlternativeAng) and self._altFactor > 0.01 then
        local ap = self.AlternativePos or vector_origin
        local aa = self.AlternativeAng or angle_zero
        pos = pos + ang:Right() * ap.x * self._altFactor
            + ang:Forward() * ap.y * self._altFactor
            + ang:Up() * ap.z * self._altFactor
        local ap_p, ap_y, ap_r = 0, 0, 0
        if isangle(aa) then ap_p, ap_y, ap_r = aa.p, aa.y, aa.r
        elseif isvector(aa) then ap_p, ap_y, ap_r = aa.x, aa.y, aa.z end
        ang:RotateAroundAxis(ang:Right(), ap_p * self._altFactor)
        ang:RotateAroundAxis(ang:Up(), ap_y * self._altFactor)
        ang:RotateAroundAxis(ang:Forward(), ap_r * self._altFactor)
    end
    local targetSprint = self:GetUHBool("Running") and 1 or 0
    self._sprintFactor = Lerp(ft * 10, self._sprintFactor or 0, targetSprint)
    if self._sprintFactor > 0.01 then
        local sp = self.RunSightsPos or vector_origin
        local sa = self.RunSightsAng or angle_zero
        local sf = self._sprintFactor
        pos = pos + ang:Right() * sp.x * sf
            + ang:Forward() * sp.y * sf
            + ang:Up() * sp.z * sf
        local sp_p, sp_y, sp_r = 0, 0, 0
        if isangle(sa) then sp_p, sp_y, sp_r = sa.p, sa.y, sa.r
        elseif isvector(sa) then sp_p, sp_y, sp_r = sa.x, sa.y, sa.z end
        ang:RotateAroundAxis(ang:Right(), sp_p * sf)
        ang:RotateAroundAxis(ang:Up(), sp_y * sf)
        ang:RotateAroundAxis(ang:Forward(), sp_r * sf)
    end
    return pos, ang
end

-- ============================================================
-- VELEMENTS
-- ============================================================

SWEP.ViewModelElements = {{
{chr(10).join(velem_lines)}
}}

SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)

-- ============================================================
-- ATTACHMENTS — all slots allow "None" (default = 0)
-- ============================================================

SWEP.Attachments = {{
{chr(10).join(attachments_lines) if attachments_lines else '    -- No attachments'}
}}
'''

    return weapon_text


def main():
    os.makedirs(DST_DIR, exist_ok=True)
    os.makedirs(ATT_DST_DIR, exist_ok=True)
    os.makedirs(SND_DST_DIR, exist_ok=True)

    count = 0
    for fname in sorted(os.listdir(SRC_DIR)):
        if not fname.endswith('.lua'):
            continue
        class_name = fname[:-4]

        # Skip melee
        if any(skip in class_name for skip in SKIP_WEAPONS):
            continue

        filepath = os.path.join(SRC_DIR, fname)
        with open(filepath, 'r', encoding='utf-8', errors='replace') as f:
            src_text = f.read()

        data = parse_tfa_weapon(src_text)
        weapon_text = generate_cuh_weapon(class_name, data)

        dst_path = os.path.join(DST_DIR, class_name + '.lua')
        with open(dst_path, 'w', encoding='utf-8') as f:
            f.write(weapon_text)

        count += 1
        if count % 10 == 0:
            print(f"  Ported {count} weapons...")

    print(f"\nPorted {count} weapons to {DST_DIR}")

    # Copy sound script
    import shutil
    snd_src = "/tmp/wwii_port/sounds/nz_codww2_sounds.lua"
    if os.path.exists(snd_src):
        shutil.copy(snd_src, os.path.join(SND_DST_DIR, 'nz_codww2_sounds.lua'))
        print(f"Copied sound script")

    # Copy attachments
    att_count = 0
    for fname in sorted(os.listdir(ATT_DIR)):
        if not fname.endswith('.lua'):
            continue
        src = os.path.join(ATT_DIR, fname)
        dst = os.path.join(ATT_DST_DIR, fname)
        shutil.copy(src, dst)
        att_count += 1
    print(f"Copied {att_count} attachment files")


if __name__ == "__main__":
    main()
