#!/usr/bin/env python3
"""
Port Ghosts weapons from TFA to Underhell CUH base.
Produces clean, readable weapon files matching the WWII Kate structure.

Target base: weapon_cuh_base_gun (with SWEP.Customizable = false)
Structure: 27 sections matching WWII Kate weapons
Strips: ALL TFA fields, ALL nZombies functions
Converts: EventTable → AnimSounds (proper time conversion)
"""

import os
import re
import math

SOURCE_DIR = "/home/z/my-project/source_repos/ghosts_weapons/lua/weapons"
OUTPUT_DIR = "/home/z/my-project/cod_ghosts_underhellsweps/lua/weapons"

SKIP = {"44", "mp443", "p226", "pdw", "bizon", "cbj", "k7", "vector"}

# ACT → string key mapping for AnimSounds
ACT_MAP = {
    "ACT_VM_DRAW": "deploy",
    "ACT_VM_DRAW_EMPTY": "deploy_empty",
    "ACT_VM_DRAW_SILENCED": "deploy_sil",
    "ACT_VM_DRAW_DEPLOYED": "deploy",
    "ACT_VM_HOLSTER": "holster",
    "ACT_VM_HOLSTER_EMPTY": "holster_empty",
    "ACT_VM_HOLSTER_SILENCED": "holster_sil",
    "ACT_VM_RELOAD": "reload",
    "ACT_VM_RELOAD_EMPTY": "reload_empty",
    "ACT_VM_RELOAD_SILENCED": "reload_sil",
    "ACT_VM_RELOAD2": "reload_2",
    "ACT_RELOAD_LOW": "reload_2",
    "ACT_VM_PRIMARYATTACK": "shoot",
    "ACT_VM_PRIMARYATTACK_EMPTY": "shoot_empty",
    "ACT_VM_PRIMARYATTACK_SILENCED": "shoot_sil",
    "ACT_VM_PULLBACK_HIGH": "rechamber",
    "ACT_VM_PULLBACK_LOW": "rechamber_ads",
    "ACT_VM_MISSCENTER": "melee",
    "ACT_VM_MISSLEFT": "melee",
    "ACT_VM_MISSRIGHT": "melee_right",
}


def parse_event_table(src):
    """Parse TFA EventTable and return AnimSounds entries."""
    # Find the EventTable block
    et_match = re.search(r'SWEP\.EventTable\s*=\s*\{', src)
    if not et_match:
        return {}

    et_start = et_match.start()
    # Find matching closing brace
    depth = 0
    et_end = et_start
    for i in range(et_start, len(src)):
        if src[i] == '{':
            depth += 1
        elif src[i] == '}':
            depth -= 1
            if depth == 0:
                et_end = i + 1
                break

    et_block = src[et_start:et_end]
    entries = {}

    # Parse each ACT key block
    # Pattern: [ACT_VM_RELOAD] = { { ... }, { ... } }
    for act_match in re.finditer(r'\[(ACT_\w+)\]\s*=\s*\{', et_block):
        act_name = act_match.group(1)
        key = ACT_MAP.get(act_name, act_name.lower().replace("act_vm_", ""))

        # Find entries within this block
        pos = act_match.end()
        depth = 1
        block_end = pos
        for i in range(pos, len(et_block)):
            if et_block[i] == '{':
                depth += 1
            elif et_block[i] == '}':
                depth -= 1
                if depth == 0:
                    block_end = i
                    break
        block = et_block[pos:block_end]

        # Parse sound entries: { ["time"] = N/30, ["type"] = "sound", ["value"] = Sound("...") }
        sounds = []
        for sm in re.finditer(r'\{\s*\["time"\]\s*=\s*([^,}]+)\s*,\s*\["type"\]\s*=\s*"sound"\s*,\s*\["value"\]\s*=\s*Sound\("([^"]+)"\)', block):
            time_str = sm.group(1).strip()
            sound_name = sm.group(2)

            # Convert time: N/30 → seconds
            if '/' in time_str:
                parts = time_str.split('/')
                time_val = float(parts[0]) / float(parts[1])
            else:
                try:
                    time_val = float(time_str)
                except ValueError:
                    continue

            sounds.append((time_val, sound_name))

        if sounds:
            if key not in entries:
                entries[key] = []
            entries[key].extend(sounds)

    return entries


def parse_sprint_animation(src):
    """Extract sprint sequence names from SprintAnimation table."""
    sa_match = re.search(r'SWEP\.SprintAnimation\s*=\s*\{', src)
    if not sa_match:
        return None, None, None

    sa_start = sa_match.start()
    depth = 0
    sa_end = sa_start
    for i in range(sa_start, len(src)):
        if src[i] == '{':
            depth += 1
        elif src[i] == '}':
            depth -= 1
            if depth == 0:
                sa_end = i + 1
                break

    sa_block = src[sa_start:sa_end]

    in_seq = re.search(r'\["in"\][^}]*"value"\s*=\s*"([^"]+)"', sa_block)
    loop_seq = re.search(r'\["loop"\][^}]*"value"\s*=\s*"([^"]+)"', sa_block)
    out_seq = re.search(r'\["out"\][^}]*"value"\s*=\s*"([^"]+)"', sa_block)

    return (
        in_seq.group(1) if in_seq else "sprint_in",
        loop_seq.group(1) if loop_seq else "sprint_loop",
        out_seq.group(1) if out_seq else "sprint_out",
    )


def parse_offset(src):
    """Parse TFA Offset table → WorldModelOffset, WorldModelAngle, Scale."""
    offset_match = re.search(
        r'SWEP\.Offset\s*=\s*\{[^}]*?Pos\s*=\s*\{[^}]*?Up\s*=\s*([-\d.]+)[^}]*?Right\s*=\s*([-\d.]+)[^}]*?Forward\s*=\s*([-\d.]+)[^}]*?\}[^}]*?Ang\s*=\s*\{[^}]*?Up\s*=\s*([-\d.]+)[^}]*?Right\s*=\s*([-\d.]+)[^}]*?Forward\s*=\s*([-\d.]+)[^}]*?\}[^}]*?(?:Scale\s*=\s*([-\d.]+))?',
        src, re.DOTALL
    )
    if not offset_match:
        return None, None, 1.0

    up = float(offset_match.group(1))
    right = float(offset_match.group(2))
    forward = float(offset_match.group(3))
    ang_up = float(offset_match.group(4))
    ang_right = float(offset_match.group(5))
    ang_forward = float(offset_match.group(6))
    scale = float(offset_match.group(7)) if offset_match.group(7) else 1.0

    return (forward, right, up), (ang_forward, ang_up, ang_right), scale


def get_field(src, pattern, default=""):
    """Extract a field value from source."""
    m = re.search(pattern, src)
    return m.group(1).strip() if m else default


def format_vector(x, y, z):
    return f"Vector({float(x):.4g}, {float(y):.4g}, {float(z):.4g})"


def format_angle(p, y, r):
    return f"Angle({float(p):.4g}, {float(y):.4g}, {float(r):.4g})"


def build_anim_sounds_block(entries):
    """Build the AnimSounds Lua block from parsed entries."""
    if not entries:
        return "SWEP.AnimSounds = {}"

    lines = ["SWEP.AnimSounds = {"]
    for key in sorted(entries.keys()):
        sounds = entries[key]
        lines.append(f'    ["{key}"] = {{')
        for time_val, sound_name in sounds:
            lines.append(f'        {{ time = {time_val:.4f}, sound = "{sound_name}" }},')
        lines.append('    },')
    lines.append("}")
    return '\n'.join(lines)


def build_animations_block(sprint_in, sprint_out, sprint_idle):
    """Build the Animations Lua block."""
    lines = [
        "SWEP.Animations = {",
        '    ["shoot"]        = "fire",',
        '    ["shoot_last"]   = "fire_last",',
        '    ["fire_ads"]     = "fire_ads",',
        '    ["iron_fire"]    = "fire_ads",',
        '    ["idle"]         = "idle",',
        '    ["idle_empty"]   = "idle_empty",',
        '    ["deploy"]       = "draw",',
        '    ["holster"]      = "holster",',
        '    ["draw_first"]   = "draw_first",',
        '    ["melee"]        = "melee",',
        '    ["melee_empty"]  = "melee_empty",',
        '    ["inspect"]      = "inspect",',
        '    ["inspect_empty"] = "inspect_empty",',
        '    ["reload"]       = "ACT_VM_RELOAD",',
        '    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",',
    ]
    if sprint_in:
        lines.append(f'    ["sprint_in"]    = "{sprint_in}",')
    if sprint_out:
        lines.append(f'    ["sprint_out"]   = "{sprint_out}",')
    if sprint_idle:
        lines.append(f'    ["sprint_idle"]  = "{sprint_idle}",')
    lines.append("}")
    return '\n'.join(lines)


def port_weapon(src_path, weapon_name):
    """Port a single TFA Ghosts weapon to Underhell CUH format."""
    with open(src_path, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = weapon_name.replace('nz_ghosts_', 'ghosts_')

    # Extract all needed fields
    print_name = get_field(src, r'SWEP\.PrintName\s*=\s*"([^"]+)"', fname)
    sub_category = get_field(src, r'SWEP\.SubCategory\s*=\s*"([^"]+)"', "")
    slot = get_field(src, r'SWEP\.Slot\s*=\s*(\d+)', "2")
    view_model = get_field(src, r'SWEP\.ViewModel\s*=\s*"([^"]+)"', "")
    world_model = get_field(src, r'SWEP\.WorldModel\s*=\s*"([^"]+)"', "")
    vm_fov = get_field(src, r'SWEP\.ViewModelFOV\s*=\s*(\d+)', "70")
    hold_type = get_field(src, r'SWEP\.HoldType\s*=\s*"([^"]+)"', "ar2")
    
    primary_sound = get_field(src, r'SWEP\.Primary\.Sound\s*=\s*"([^"]+)"', "")
    primary_ammo = get_field(src, r'SWEP\.Primary\.Ammo\s*=\s*"([^"]+)"', "ar2")
    primary_auto = get_field(src, r'SWEP\.Primary\.Automatic\s*=\s*(\w+)', "true")
    rpm = get_field(src, r'SWEP\.Primary\.RPM\s*=\s*(\d+)', "600")
    damage = get_field(src, r'SWEP\.Primary\.Damage\s*=\s*(\d+)', "50")
    clip_size = get_field(src, r'SWEP\.Primary\.ClipSize\s*=\s*(\d+)', "30")
    num_shots = get_field(src, r'SWEP\.Primary\.NumShots\s*=\s*(\d+)', "1")
    spread = get_field(src, r'SWEP\.Primary\.Spread\s*=\s*([-\d.]+)', "0.03")
    kick_up = get_field(src, r'SWEP\.Primary\.KickUp\s*=\s*([-\d.]+)', "0.5")
    kick_down = get_field(src, r'SWEP\.Primary\.KickDown\s*=\s*([-\d.]+)', "0.3")
    kick_horiz = get_field(src, r'SWEP\.Primary\.KickHorizontal\s*=\s*([-\d.]+)', "0.1")
    
    default_clip_match = re.search(r'SWEP\.Primary\.DefaultClip\s*=\s*SWEP\.Primary\.ClipSize\s*\*\s*(\d+)', src)
    if default_clip_match:
        default_clip_mult = int(default_clip_match.group(1))
        default_clip = int(clip_size) * default_clip_mult
    else:
        default_clip = get_field(src, r'SWEP\.Primary\.DefaultClip\s*=\s*(\d+)', str(int(clip_size) * 5))

    iron_pos_match = re.search(r'SWEP\.IronSightsPos\s*=\s*Vector\s*\(([^)]+)\)', src)
    iron_pos = iron_pos_match.group(1) if iron_pos_match else "0, 0, 0"
    iron_ang_match = re.search(r'SWEP\.IronSightsAng\s*=\s*Vector\s*\(([^)]+)\)', src)
    iron_ang = iron_ang_match.group(1) if iron_ang_match else "0, 0, 0"
    iron_time = get_field(src, r'SWEP\.IronSightTime\s*=\s*([-\d.]+)', "0.3")
    
    iron_fov = get_field(src, r'SWEP\.Secondary\.IronFOV\s*=\s*(\d+)', "75")
    zoom_fov = 90 - int(iron_fov) if iron_fov else 15

    # Parse Offset
    wm_offset, wm_angle, wm_scale = parse_offset(src)

    # Parse EventTable → AnimSounds
    anim_sounds = parse_event_table(src)

    # Parse SprintAnimation
    sprint_in, sprint_out, sprint_idle = parse_sprint_animation(src)

    # Calculate delay from RPM
    delay = 60.0 / float(rpm)

    # Calculate recoil
    min_recoil = -float(kick_down)
    max_recoil = -float(kick_up)

    # Determine fire mode
    if primary_auto.lower() == "true":
        fire_mode = '{ name = "Full-Auto" }'
    else:
        fire_mode = '{ name = "Semi-Auto" }'

    # Determine shell type
    if primary_ammo == "buckshot":
        shell_model = "models/weapons/shell_12g.mdl"
        shell_heat = "0.8"
    elif primary_ammo == "pistol":
        shell_model = "models/weapons/shell_9mm.mdl"
        shell_heat = "0.8"
    else:
        shell_model = "models/weapons/shell_556.mdl"
        shell_heat = "0.5"

    # Build the weapon file
    lines = []

    # Header
    lines.append(f'-- ============================================================')
    lines.append(f'-- {print_name} — Ported from TFA Ghosts to CUH base')
    lines.append(f'-- Source: {weapon_name}')
    lines.append(f'-- ============================================================')
    lines.append('')
    lines.append('AddCSLuaFile()')
    lines.append('')
    lines.append('DEFINE_BASECLASS("weapon_cuh_base_gun")')
    lines.append('SWEP.Base = "weapon_cuh_base_gun"')
    lines.append('')
    lines.append(f'SWEP.PrintName   = "{print_name}"')
    lines.append(f'SWEP.Category    = "COD: Ghosts"')
    lines.append(f'SWEP.SubCategory = "{sub_category}"')
    lines.append('')
    lines.append(f'SWEP.Slot = {slot}')
    lines.append('SWEP.Spawnable = true')
    lines.append('SWEP.Customizable = false')
    lines.append('')

    # Appearance
    lines.append('-- Appearance')
    lines.append('SWEP.UseHands = true')
    lines.append('SWEP.ViewModelFlip = false')
    lines.append(f'SWEP.ViewModelFOV = {vm_fov}')
    lines.append(f'SWEP.ViewModel  = "{view_model}"')
    lines.append(f'SWEP.WorldModel = "{world_model}"')
    lines.append('SWEP.LoweredPos = Vector(0, 0, 0)')
    lines.append('SWEP.LoweredAng = Vector(0, 0, 0)')
    lines.append('')
    lines.append('SWEP.UseQCReloadEvents = true')
    lines.append('SWEP.UseReloadTable = true')
    lines.append('')

    # Hold type
    lines.append(f'SWEP.HoldType = "{hold_type}"')
    lines.append('SWEP.PassiveAnim = "passive"')
    lines.append(f'SWEP.ZoomFov = {zoom_fov}')
    lines.append('')

    # Fire modes
    lines.append('-- Fire mode')
    lines.append('SWEP.FireModes = {')
    lines.append(f'    {fire_mode},')
    lines.append('}')
    lines.append('')

    # Primary stats
    lines.append('-- Primary stats')
    lines.append(f'SWEP.Primary.Sound          = Sound("{primary_sound}")')
    lines.append(f'SWEP.Primary.SilSound       = Sound("")')
    lines.append(f'SWEP.Primary.ClipSize       = {clip_size}')
    lines.append(f'SWEP.Primary.Ammo           = "{primary_ammo}"')
    lines.append(f'SWEP.Primary.DefaultClip    = {default_clip}')
    lines.append(f'SWEP.Primary.MinDamage      = {damage}.0')
    lines.append(f'SWEP.Primary.MaxDamage      = {damage}.0')
    lines.append(f'SWEP.Primary.Automatic      = {primary_auto}')
    lines.append('SWEP.Primary.TakeAmmo       = 1')
    lines.append('SWEP.Primary.Force          = 1')
    lines.append(f'SWEP.Primary.Spread         = {spread}')
    lines.append(f'SWEP.Primary.Delay          = {delay:.6f}    -- {rpm} RPM')
    lines.append(f'SWEP.Primary.NumberofShots  = {num_shots}')
    lines.append(f'SWEP.Primary.MinRecoil      = {min_recoil}')
    lines.append(f'SWEP.Primary.MaxRecoil      = {max_recoil}')
    lines.append(f'SWEP.Primary.KickUp         = {kick_up}')
    lines.append(f'SWEP.Primary.KickDown       = {kick_down}')
    lines.append(f'SWEP.Primary.KickHorizontal = {kick_horiz}')
    lines.append('SWEP.Primary.SpreadMultiplierMax = 1.0')
    lines.append('SWEP.Primary.SpreadIncrement    = 0.0')
    lines.append('SWEP.Primary.SpreadRecovery     = 6.0')
    lines.append('SWEP.TwoHanded              = true')
    lines.append('SWEP.ReloadSpeed            = 1')
    lines.append('SWEP.Chambering             = false')
    lines.append('SWEP.AnimatedSprint         = true')
    lines.append('')

    # Ironsights
    lines.append('-- Ironsights')
    lines.append(f'SWEP.IronSightsPos = Vector({iron_pos})')
    lines.append(f'SWEP.IronSightsAng = Vector({iron_ang})')
    lines.append(f'SWEP.IronSightTime = {iron_time}')
    lines.append('SWEP.SwayPosition = 2.0')
    lines.append('SWEP.AlternativePos = Vector(0, 0, 0)')
    lines.append('SWEP.AlternativeAng = Angle(0, 0, 0)')
    lines.append('')

    # Sprint
    lines.append('-- Sprint')
    lines.append('SWEP.RunSightsPos = Vector(0, 0, 0)')
    lines.append('SWEP.RunSightsAng = Vector(0, 0, 0)')
    lines.append('')

    # Ironsight dip
    lines.append('-- Ironsight dip')
    lines.append('SWEP.IronSightsDipPos   = Vector(0, 0, 0)')
    lines.append('SWEP.IronSightsDipAng   = Angle(0, 0, 0)')
    lines.append('SWEP.IronSightsDipScale = 0')
    lines.append('')

    # Camera
    lines.append('-- Camera bone system')
    lines.append('SWEP.CameraAttachment = "Camera"')
    lines.append('SWEP.CameraReserve = false')
    lines.append('SWEP.CameraOffset = Angle(0, 0, 0)')
    lines.append('')

    # Muzzle
    lines.append('-- Muzzle')
    lines.append('SWEP.MuzzleAttachment = "2"')
    lines.append('SWEP.MuzzleFlashType = "particle"')
    lines.append('SWEP.MuzzleFlashParticle = "muzzleflash_6"')
    lines.append('SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)')
    lines.append('SWEP.MuzzleFlashLightSize = 128')
    lines.append('')

    # Melee
    lines.append('-- Melee bash')
    lines.append('SWEP.MeleeDamage    = 50')
    lines.append('SWEP.MeleeRange     = 64')
    lines.append('SWEP.MeleeDelay     = 0.6')
    lines.append('SWEP.MeleeForce     = 300')
    lines.append('SWEP.MeleeHitDelay  = 0.15')
    lines.append('SWEP.MeleeViewPunch = Angle(-5, 0, 0)')
    lines.append('SWEP.MeleeSound     = "Weapons_Ghosts_LARGE.Generic"')
    lines.append('SWEP.MeleeHitSound  = {"Weapons_Ghosts_LARGE.Generic"}')
    lines.append('SWEP.MeleeMissSound = ""')
    lines.append('SWEP.MeleeInterruptReload = true')
    lines.append('')

    # Shell
    lines.append('-- Shell ejection')
    lines.append(f'SWEP.NoShell   = false')
    lines.append(f'SWEP.ShellHeat = {shell_heat}')
    lines.append(f'SWEP.Shell     = "{shell_model}"')
    lines.append(f'SWEP.ShellDelay = 0')
    lines.append('')

    # World model
    lines.append('-- World model positioning')
    if wm_offset:
        lines.append(f'SWEP.WorldModelOffset = Vector({wm_offset[0]:.4g}, {wm_offset[1]:.4g}, {wm_offset[2]:.4g})')
        lines.append(f'SWEP.WorldModelAngle  = Angle({wm_angle[0]:.4g}, {wm_angle[1]:.4g}, {wm_angle[2]:.4g})')
    else:
        lines.append('SWEP.WorldModelOffset = Vector(8, 1, -5)')
        lines.append('SWEP.WorldModelAngle  = Angle(8, 180, 180)')
    lines.append('')

    # Animations
    lines.append('-- ============================================================')
    lines.append('-- ANIMATIONS')
    lines.append('-- ============================================================')
    lines.append(build_animations_block(sprint_in, sprint_out, sprint_idle))
    lines.append('')

    # AnimSounds
    lines.append('-- ============================================================')
    lines.append('-- ANIMSOUNDS (ported from TFA EventTable, time = N/30 → seconds)')
    lines.append('-- ============================================================')
    lines.append(build_anim_sounds_block(anim_sounds))
    lines.append('')

    # Smart muzzle/shell
    lines.append('-- ============================================================')
    lines.append('-- SMART MUZZLE / SHELL AUTO-DETECT')
    lines.append('-- ============================================================')
    lines.append('function SWEP:GetDisplay()')
    lines.append('    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil')
    lines.append('    if IsValid(vm) then')
    lines.append('        local att = vm:LookupAttachment("1")')
    lines.append('        if att > 0 then return att end')
    lines.append('    end')
    lines.append('    return 1')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:GetMuzzle()')
    lines.append('    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil')
    lines.append('    if IsValid(vm) then')
    lines.append('        local att = vm:LookupAttachment("1")')
    lines.append('        if att > 0 then return att end')
    lines.append('        att = vm:LookupAttachment("2")')
    lines.append('        if att > 0 then return att end')
    lines.append('    end')
    lines.append('    return 1')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:GetShellEject()')
    lines.append('    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil')
    lines.append('    if IsValid(vm) then')
    lines.append('        local att = vm:LookupAttachment("0")')
    lines.append('        if att > 0 then return att end')
    lines.append('    end')
    lines.append('    return 2')
    lines.append('end')
    lines.append('')

    # Shoot animation
    lines.append('-- ============================================================')
    lines.append('-- SHOOT ANIMATION SELECTION')
    lines.append('-- ============================================================')
    lines.append('function SWEP:ShootAnimation()')
    lines.append('    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then')
    lines.append('        return "iron_fire"')
    lines.append('    end')
    lines.append('    if self.Animations and self.Animations["shoot"] then')
    lines.append('        return "shoot"')
    lines.append('    end')
    lines.append('    return ACT_VM_PRIMARYATTACK')
    lines.append('end')
    lines.append('')

    # Sprint/Idle/Inspect handlers
    lines.append('-- ============================================================')
    lines.append('-- SPRINT / IDLE / INSPECT HANDLERS')
    lines.append('-- ============================================================')
    lines.append('function SWEP:HandleSprintingAnimations()')
    lines.append('    local ply = self:GetOwner()')
    lines.append('    if not IsValid(ply) or not ply:IsPlayer() then return end')
    lines.append('    local isRunning = self:GetUHBool("Running")')
    lines.append('    if self.wasRunning == nil then self.wasRunning = false end')
    lines.append('    local vm = ply:GetViewModel()')
    lines.append('    if not IsValid(vm) then return end')
    lines.append('    if isRunning and not self.wasRunning then')
    lines.append('        if not self:GetUHBool("Reloading") then')
    lines.append('            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)')
    lines.append('        end')
    lines.append('    elseif not isRunning and self.wasRunning then')
    lines.append('        if not self:GetUHBool("Reloading") then')
    lines.append('            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)')
    lines.append('        end')
    lines.append('    elseif isRunning and not self:GetUHBool("Reloading") then')
    lines.append('        if vm:GetCycle() >= 1 then')
    lines.append('            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)')
    lines.append('        end')
    lines.append('    end')
    lines.append('    self.wasRunning = isRunning')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:HandleIdle()')
    lines.append('    local ply = self:GetOwner()')
    lines.append('    if not IsValid(ply) or not ply:IsPlayer() then return end')
    lines.append('    if self._meleeActive then return end')
    lines.append('    if self:GetUHBool("Reloading") then return end')
    lines.append('    if self:GetUHBool("Running") then return end')
    lines.append('    if self:GetUHBool("Zooming") then return end')
    lines.append('    local vm = ply:GetViewModel()')
    lines.append('    if not IsValid(vm) then return end')
    lines.append('    if vm:GetCycle() < 1 then return end')
    lines.append('    self:EasySendWeaponAnim("idle", ACT_VM_IDLE)')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:HandleInspect()')
    lines.append('    local ply = self:GetOwner()')
    lines.append('    if not IsValid(ply) or not ply:IsPlayer() then return end')
    lines.append('    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then')
    lines.append('        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then')
    lines.append('            if not self:GetNW2Bool("Inspecting") then')
    lines.append('                self:SetNW2Bool("Inspecting", true)')
    lines.append('                self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)')
    lines.append('            end')
    lines.append('        end')
    lines.append('    elseif self:GetNW2Bool("Inspecting") then')
    lines.append('        self:SetNW2Bool("Inspecting", false)')
    lines.append('    end')
    lines.append('end')
    lines.append('')

    # Attack
    lines.append('-- ============================================================')
    lines.append('-- ATTACK')
    lines.append('-- ============================================================')
    lines.append('function SWEP:PrimaryAttack()')
    lines.append('    if self._meleeActive then return end')
    lines.append('    if self.Owner:KeyDown(IN_USE) then')
    lines.append('        local ct = CurTime()')
    lines.append('        if ct < (self._nextMelee or 0) then return end')
    lines.append('        if self:GetUHBool("Reloading") then return end')
    lines.append('        if self:GetNWFloat("DeployTime") > ct then return end')
    lines.append('        if self:GetNWInt("FireMode") == 0 then return end')
    lines.append('        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end')
    lines.append('        return')
    lines.append('    end')
    lines.append('    BaseClass.PrimaryAttack(self)')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:SecondaryAttack()')
    lines.append('    if self._meleeActive then return end')
    lines.append('    return BaseClass.SecondaryAttack(self)')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:Reload()')
    lines.append('    return BaseClass.Reload(self)')
    lines.append('end')
    lines.append('')

    # Think
    lines.append('-- ============================================================')
    lines.append('-- THINK')
    lines.append('-- ============================================================')
    lines.append('function SWEP:Think()')
    lines.append('    local ct = CurTime()')
    lines.append('    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then')
    lines.append('        self._meleeHitDone = true')
    lines.append('        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end')
    lines.append('    end')
    lines.append('    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then')
    lines.append('        self:EndMelee()')
    lines.append('    end')
    lines.append('    BaseClass.Think(self)')
    lines.append('    if not IsValid(self.Owner) then return end')
    lines.append('    self:HandleSprintingAnimations()')
    lines.append('    self:HandleIdle()')
    lines.append('    self:HandleInspect()')
    lines.append('end')
    lines.append('')

    # Holster/Deploy
    lines.append('-- ============================================================')
    lines.append('-- HOLSTER / DEPLOY')
    lines.append('-- ============================================================')
    lines.append('function SWEP:Holster(wep)')
    lines.append('    self._justExitedSprint = false')
    lines.append('    self.wasZooming = false')
    lines.append('    self.wasRunning = false')
    lines.append('    return BaseClass.Holster(self, wep)')
    lines.append('end')
    lines.append('')
    lines.append('function SWEP:Deploy()')
    lines.append('    BaseClass.Deploy(self)')
    lines.append('    self:SetHoldType(self.HoldType)')
    lines.append('    if self.Animations and self.Animations["deploy"] then')
    lines.append('        local vm = self.Owner:GetViewModel()')
    lines.append('        if IsValid(vm) then')
    lines.append('            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW)')
    lines.append('            local dur = vm:SequenceDuration()')
    lines.append('            self:SetNextPrimaryFire(CurTime() + dur)')
    lines.append('            self:SetNextSecondaryFire(CurTime() + dur)')
    lines.append('            self.NextReload = CurTime() + dur')
    lines.append('            self._nextIdlePlay = nil')
    lines.append('            self._deployEndTime = CurTime() + dur')
    lines.append('            self:SetNWFloat("DeployTime", 0)')
    lines.append('        end')
    lines.append('    end')
    lines.append('    self._meleeActive = nil')
    lines.append('    self._meleeHitTime = nil')
    lines.append('    self._meleeHitDone = nil')
    lines.append('    self._meleeEndTime = nil')
    lines.append('    self._nextMelee = nil')
    lines.append('    self._justExitedSprint = false')
    lines.append('    return true')
    lines.append('end')
    lines.append('')

    # VElements/WElements (empty)
    lines.append('-- ============================================================')
    lines.append('-- VELEMENTS / WELEMENTS (empty — not customizable)')
    lines.append('-- ============================================================')
    lines.append('SWEP.ViewModelElements = {}')
    lines.append('SWEP.WorldModelElements = {}')
    lines.append('')

    # Attachments (empty)
    lines.append('-- ============================================================')
    lines.append('-- ATTACHMENTS (empty — not customizable)')
    lines.append('-- ============================================================')
    lines.append('SWEP.Attachments = {}')

    output = '\n'.join(lines) + '\n'

    output_path = os.path.join(OUTPUT_DIR, fname + '.lua')
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(output)

    # Count sounds
    sound_count = sum(len(sounds) for sounds in anim_sounds.values())

    return fname, sound_count


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    weapons = []
    for f in sorted(os.listdir(SOURCE_DIR)):
        if not f.startswith('nz_ghosts_') or not f.endswith('.lua'):
            continue
        name = f.replace('.lua', '')
        weapon_name = name.replace('nz_ghosts_', '')
        if weapon_name in SKIP:
            print(f"  SKIP: {weapon_name}")
            continue
        weapons.append((name, weapon_name))

    print(f"\nPorting {len(weapons)} weapons...\n")

    total_sounds = 0
    for name, weapon_name in weapons:
        src_path = os.path.join(SOURCE_DIR, name + '.lua')
        fname, sound_count = port_weapon(src_path, name)
        total_sounds += sound_count
        print(f"  PORTED: {fname} ({sound_count} sounds)")

    print(f"\nDone. Ported {len(weapons)} weapons with {total_sounds} total AnimSounds entries.")


if __name__ == "__main__":
    main()
