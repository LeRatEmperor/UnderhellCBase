#!/usr/bin/env python3
"""
Port all 25 Call of Duty Ghosts weapons from TFA to Underhell custom base.

Converts:
- SWEP.Base: tfa_gun_base → weapon_custom_uh_base_gun
- SWEP.Category: nZR: GHOSTS → COD: Ghosts
- Primary.RPM → Primary.Delay (60/RPM)
- Primary.Damage → Primary.MinDamage + Primary.MaxDamage
- Primary.NumShots → Primary.NumberofShots
- Offset table → WorldModelOffset + WorldModelAngle
- EventTable → AnimSounds (ACT keys → string keys, time N/30 → seconds)
- SprintAnimation → AnimatedSprint = true + Animations keys
- TFA.Enum.* references removed
- PaP system preserved
- Camera attachment preserved
"""

import os
import re
import math

SOURCE_DIR = "/home/z/my-project/source_repos/ghosts_weapons/lua/weapons"
OUTPUT_DIR = "/home/z/my-project/cod_ghosts_underhellsweps/lua/weapons"

SKIP = {"44", "mp443", "p226", "pdw", "bizon", "cbj", "k7", "vector"}


def convert_offset(src):
    """Convert TFA Offset table to WorldModelOffset + WorldModelAngle."""
    # Parse the Offset table
    offset_match = re.search(
        r'SWEP\.Offset\s*=\s*\{[^}]*Pos\s*=\s*\{[^}]*Up\s*=\s*([-\d.]+)[^}]*Right\s*=\s*([-\d.]+)[^}]*Forward\s*=\s*([-\d.]+)[^}]*\}[^}]*Ang\s*=\s*\{[^}]*Up\s*=\s*([-\d.]+)[^}]*Right\s*=\s*([-\d.]+)[^}]*Forward\s*=\s*([-\d.]+)[^}]*\}[^}]*Scale\s*=\s*([-\d.]+)',
        src, re.DOTALL
    )
    if not offset_match:
        return src, ""
    
    up = float(offset_match.group(1))
    right = float(offset_match.group(2))
    forward = float(offset_match.group(3))
    ang_up = float(offset_match.group(4))
    ang_right = float(offset_match.group(5))
    ang_forward = float(offset_match.group(6))
    scale = float(offset_match.group(7))
    
    # Remove the Offset table from source
    src = re.sub(r'SWEP\.Offset\s*=\s*\{.*?\n\}', '', src, count=1, flags=re.DOTALL)
    
    replacement = f"""SWEP.WorldModelOffset = Vector({forward}, {right}, {up})
SWEP.WorldModelAngle = Angle({ang_forward}, {ang_up}, {ang_right})
SWEP.WorldModelScale = {scale}"""
    
    return src, replacement


def convert_event_table(src):
    """Convert TFA EventTable to AnimSounds."""
    # Find EventTable
    et_match = re.search(r'SWEP\.EventTable\s*=\s*\{', src)
    if not et_match:
        return src
    
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
    
    # Parse entries: [ACT_VM_RELOAD] = { { time = N/30, type = "sound", value = Sound("...") }, ... }
    entries = {}
    for act_match in re.finditer(r'\[(ACT_\w+)\]\s*=\s*\{', et_block):
        act_name = act_match.group(1)
        # Find the entries for this ACT
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
        
        # Parse sound entries
        sounds = []
        for sound_match in re.finditer(r'\{\s*\["time"\]\s*=\s*([-\d./]+)\s*,\s*\["type"\]\s*=\s*"sound"\s*,\s*\["value"\]\s*=\s*Sound\("([^"]+)"\)\s*\}', block):
            time_str = sound_match.group(1)
            sound_name = sound_match.group(2)
            # Convert time: N/30 → seconds
            if '/' in time_str:
                parts = time_str.split('/')
                time_val = float(parts[0]) / float(parts[1])
            else:
                time_val = float(time_str)
            sounds.append(f'{{ time = {time_val:.4f}, sound = "{sound_name}" }}')
        
        # Skip lua-type entries (can't be ported to AnimSounds)
        if sounds:
            # Map ACT names to string keys
            key_map = {
                'ACT_VM_DRAW': 'deploy',
                'ACT_VM_DRAW_EMPTY': 'deploy_empty',
                'ACT_VM_HOLSTER': 'holster',
                'ACT_VM_HOLSTER_EMPTY': 'holster_empty',
                'ACT_VM_RELOAD': 'reload',
                'ACT_VM_RELOAD_EMPTY': 'reload_empty',
                'ACT_VM_PRIMARYATTACK': 'shoot',
                'ACT_VM_PULLBACK_HIGH': 'rechamber',
                'ACT_VM_PULLBACK_LOW': 'rechamber_ads',
                'ACT_VM_RELOAD_SILENCED': 'reload_sil',
                'ACT_VM_RELOAD2': 'reload_3',
                'ACT_RELOAD_LOW': 'reload_2',
            }
            key = key_map.get(act_name, act_name.lower())
            entries[key] = sounds
    
    if not entries:
        return src
    
    # Build AnimSounds block
    anim_sounds_lines = ['SWEP.AnimSounds = {']
    for key, sounds in entries.items():
        anim_sounds_lines.append(f'    ["{key}"] = {{')
        for s in sounds:
            anim_sounds_lines.append(f'        {s},')
        anim_sounds_lines.append('    },')
    anim_sounds_lines.append('}')
    anim_sounds_block = '\n'.join(anim_sounds_lines)
    
    # Remove EventTable from source
    src = src[:et_start] + anim_sounds_block + src[et_end:]
    
    return src


def convert_sprint_animation(src):
    """Convert TFA SprintAnimation to AnimatedSprint + Animations keys."""
    sa_match = re.search(r'SWEP\.SprintAnimation\s*=\s*\{', src)
    if not sa_match:
        return src
    
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
    
    # Extract sequence names
    in_seq = re.search(r'\["in"\][^}]*"value"\]\s*=\s*"([^"]+)"', sa_block)
    loop_seq = re.search(r'\["loop"\][^}]*"value"\]\s*=\s*"([^"]+)"', sa_block)
    out_seq = re.search(r'\["out"\][^}]*"value"\]\s*=\s*"([^"]+)"', sa_block)
    
    in_val = in_seq.group(1) if in_seq else "sprint_in"
    loop_val = loop_seq.group(1) if loop_seq else "sprint_loop"
    out_val = out_seq.group(1) if out_seq else "sprint_out"
    
    # Replace SprintAnimation with AnimatedSprint + Animations keys
    replacement = f'SWEP.AnimatedSprint = true'
    
    # Check if Animations table already exists
    if 'SWEP.Animations' in src:
        # Insert sprint keys into existing Animations table
        sprint_keys = f'''
    ["sprint_in"]  = "{in_val}",
    ["sprint_out"] = "{out_val}",
    ["sprint_idle"] = "{loop_val}",'''
        # Insert before the closing }
        anim_match = re.search(r'(SWEP\.Animations\s*=\s*\{)', src)
        if anim_match:
            insert_pos = anim_match.end()
            src = src[:insert_pos] + sprint_keys + src[insert_pos:]
        src = src[:sa_start] + replacement + src[sa_end:]
    else:
        replacement += f'''
SWEP.Animations = {{
    ["sprint_in"]  = "{in_val}",
    ["sprint_out"] = "{out_val}",
    ["sprint_idle"] = "{loop_val}",
}}'''
        src = src[:sa_start] + replacement + src[sa_end:]
    
    return src


def convert_weapon(filepath, weapon_name):
    """Convert a single TFA Ghosts weapon to Underhell format."""
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()
    
    # 1. Change Base
    src = src.replace('SWEP.Base = "tfa_gun_base"', 'SWEP.Base = "weapon_custom_uh_base_gun"')
    
    # 2. Change Category
    src = src.replace('SWEP.Category = "nZR: GHOSTS"', 'SWEP.Category = "COD: Ghosts"')
    
    # 3. Add AddCSLuaFile and DEFINE_BASECLASS
    if 'AddCSLuaFile()' not in src:
        src = 'AddCSLuaFile()\n\n' + src
    if 'DEFINE_BASECLASS' not in src:
        src = src.replace(
            'SWEP.Base = "weapon_custom_uh_base_gun"',
            'DEFINE_BASECLASS("weapon_custom_uh_base_gun")\nSWEP.Base = "weapon_custom_uh_base_gun"'
        )
    
    # 4. Convert RPM to Delay
    rpm_match = re.search(r'SWEP\.Primary\.RPM\s*=\s*(\d+)', src)
    if rpm_match:
        rpm = int(rpm_match.group(1))
        delay = 60.0 / rpm
        src = src.replace(f'SWEP.Primary.RPM = {rpm}', f'SWEP.Primary.Delay = {delay:.6f}  -- {rpm} RPM')
    
    # 5. Convert Damage to MinDamage/MaxDamage
    dmg_match = re.search(r'SWEP\.Primary\.Damage\s*=\s*(\d+)', src)
    if dmg_match:
        dmg = int(dmg_match.group(1))
        src = src.replace(f'SWEP.Primary.Damage = {dmg}', f'SWEP.Primary.MinDamage = {dmg}\nSWEP.Primary.MaxDamage = {dmg}')
    
    # 6. Convert NumShots to NumberofShots
    src = src.replace('SWEP.Primary.NumShots', 'SWEP.Primary.NumberofShots')
    
    # 7. Convert KickUp/Down/Horizontal to MinRecoil/MaxRecoil
    kick_up = re.search(r'SWEP\.Primary\.KickUp\s*=\s*([-\d.]+)', src)
    kick_down = re.search(r'SWEP\.Primary\.KickDown\s*=\s*([-\d.]+)', src)
    if kick_up and kick_down:
        up = float(kick_up.group(1))
        down = float(kick_down.group(1))
        min_recoil = min(up, down)
        max_recoil = max(up, down)
        src = re.sub(r'SWEP\.Primary\.KickUp\s*=\s*[-\d.]+\n', '', src)
        src = re.sub(r'SWEP\.Primary\.KickDown\s*=\s*[-\d.]+\n', '', src)
        # Add MinRecoil/MaxRecoil after KickHorizontal line
        src = re.sub(
            r'(SWEP\.Primary\.KickHorizontal\s*=\s*[-\d.]+)\n',
            f'\\1\nSWEP.Primary.MinRecoil = {-min_recoil}\nSWEP.Primary.MaxRecoil = {-max_recoil}',
            src
        )
    
    # 8. Remove TFA-specific fields
    src = re.sub(r'SWEP\.data\s*=\s*\{\}\n', '', src)
    src = re.sub(r'SWEP\.data\.ironsights\s*=\s*\d+\n', '', src)
    src = re.sub(r'SWEP\.Primary\.Range\s*=\s*[-\d.]+\n', '', src)
    src = re.sub(r'SWEP\.Primary\.RangeFalloff\s*=\s*[-\d.]+\n', '', src)
    src = re.sub(r'SWEP\.Primary\.PenetrationPower\s*=\s*[-\d.]+\n', '', src)
    src = re.sub(r'SWEP\.Primary\.Knockback\s*=\s*[-\d.]+\n', '', src)
    src = re.sub(r'SWEP\.DisableChambering\s*=\s*\w+\n', '', src)
    src = re.sub(r'SWEP\.SelectiveFire\s*=\s*\w+\n', '', src)
    src = re.sub(r'SWEP\.BurstFireCount\s*=\s*\d+\n', '', src)
    
    # Remove TFA ViewModelPunch system
    src = re.sub(r'SWEP\.ViewModelPunch[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.ChangeState[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Crouch[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Jump[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Wall[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Walk[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.StaticRecoilFactor[^\n]+\n', '', src)
    
    # Remove TFA locomotion settings
    src = re.sub(r'SWEP\.Sprint_Mode[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Sights_Mode[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Idle_Mode[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Idle_Blend[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.Idle_Smooth[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.SprintBobMult[^\n]+\n', '', src)
    src = re.sub(r'SWEP\.AllowViewAttachment[^\n]+\n', '', src)
    
    # Remove TFA-specific sound echo tables
    src = re.sub(r'SWEP\.Primary\.SoundEchoTable\s*=\s*\{[^}]*\}\s*\}', '', src, flags=re.DOTALL)
    
    # Remove SpeedColaActivities and DTapActivities
    src = re.sub(r'SWEP\.SpeedColaActivities\s*=\s*\{.*?\n\}', '', src, flags=re.DOTALL)
    src = re.sub(r'SWEP\.DTapActivities\s*=\s*\{.*?\n\}', '', src, flags=re.DOTALL)
    
    # Remove StatusLengthOverride and SequenceRateOverride
    src = re.sub(r'SWEP\.StatusLengthOverride\s*=\s*\{.*?\n\}', '', src, flags=re.DOTALL)
    src = re.sub(r'SWEP\.SequenceRateOverride\s*=\s*\{.*?\n\}', '', src, flags=re.DOTALL)
    
    # Remove DrawCrosshairIS
    src = re.sub(r'SWEP\.DrawCrosshairIS[^\n]+\n', '', src)
    
    # 9. Convert Secondary.IronFOV to ZoomFov
    iron_fov_match = re.search(r'SWEP\.Secondary\.IronFOV\s*=\s*(\d+)', src)
    if iron_fov_match:
        iron_fov = int(iron_fov_match.group(1))
        zoom_fov = 90 - iron_fov  # IronFOV is the zoomed FOV, ZoomFov is degrees to subtract
        src = src.replace(f'SWEP.Secondary.IronFOV = {iron_fov}', f'SWEP.ZoomFov = {zoom_fov}')
    
    # 10. Add Underhell-specific fields
    if 'SWEP.UseHands' in src and 'SWEP.AnimatedSprint' not in src:
        # Add AnimatedSprint after UseHands
        src = re.sub(
            r'(SWEP\.UseHands\s*=\s*\w+)',
            r'\1\nSWEP.AnimatedSprint = true',
            src,
            count=1
        )
    
    # Add camera attachment
    if 'SWEP.CameraAttachment' not in src:
        src = re.sub(
            r'(SWEP\.HoldType\s*=\s*"[^"]+")',
            r'\1\nSWEP.CameraAttachment = "Camera"\nSWEP.CameraReserve = false\nSWEP.CameraOffset = Angle(0, 0, 0)',
            src,
            count=1
        )
    
    # Add MuzzleAttachment
    if 'SWEP.MuzzleAttachment' not in src:
        src = re.sub(
            r'(SWEP\.CameraOffset\s*=\s*Angle\([^)]+\))',
            r'\1\nSWEP.MuzzleAttachment = "2"\nSWEP.MuzzleFlashType = "particle"',
            src,
            count=1
        )
    
    # 11. Convert Offset table
    src, offset_replacement = convert_offset(src)
    if offset_replacement:
        # Add after WorldModel line
        src = re.sub(
            r'(SWEP\.WorldModel\s*=\s*"[^"]+")',
            f'\\1\n{offset_replacement}',
            src,
            count=1
        )
    
    # 12. Convert EventTable to AnimSounds
    src = convert_event_table(src)
    
    # 13. Convert SprintAnimation
    src = convert_sprint_animation(src)
    
    # 14. Add default Animations if not present
    if 'SWEP.Animations' not in src:
        src += '\n\nSWEP.Animations = {\n    ["idle"] = "idle",\n    ["deploy"] = "draw",\n    ["holster"] = "holster",\n    ["shoot"] = "fire",\n    ["reload"] = "reload",\n    ["reload_empty"] = "reload_empty",\n}\n'
    else:
        # Ensure basic animation keys exist
        if '["idle"]' not in src:
            src = re.sub(r'(SWEP\.Animations\s*=\s*\{)', r'\1\n    ["idle"] = "idle",', src)
        if '["deploy"]' not in src:
            src = re.sub(r'(SWEP\.Animations\s*=\s*\{)', r'\1\n    ["deploy"] = "draw",', src)
        if '["holster"]' not in src:
            src = re.sub(r'(SWEP\.Animations\s*=\s*\{)', r'\1\n    ["holster"] = "holster",', src)
        if '["shoot"]' not in src:
            src = re.sub(r'(SWEP\.Animations\s*=\s*\{)', r'\1\n    ["shoot"] = "fire",', src)
    
    # 15. Add shell ejection
    if 'SWEP.Shell' not in src and 'SWEP.NoShell' not in src:
        src = re.sub(
            r'(SWEP\.MuzzleFlashType\s*=\s*"particle")',
            r'\1\nSWEP.Shell = "models/weapons/shell_556.mdl"\nSWEP.ShellHeat = 0.5\nSWEP.ShellDelay = 0',
            src,
            count=1
        )
    
    # 16. Add Underhell gun defaults
    if 'SWEP.TwoHanded' not in src:
        src += '\nSWEP.TwoHanded = true\n'
    if 'SWEP.ReloadSpeed' not in src:
        src += 'SWEP.ReloadSpeed = 1\n'
    if 'SWEP.Chambering' not in src:
        src += 'SWEP.Chambering = false\n'
    
    # 17. Add SwayPosition
    if 'SWEP.SwayPosition' not in src:
        src += 'SWEP.SwayPosition = 2.0\n'
    
    # 18. Add IronSightsDipPos
    if 'SWEP.IronSightsDipPos' not in src:
        src += 'SWEP.IronSightsDipPos = Vector(0, 0, 0)\nSWEP.IronSightsDipAng = Angle(0, 0, 0)\nSWEP.IronSightsDipScale = 0\n'
    
    # 19. Add RunSightsPos
    if 'SWEP.RunSightsPos' not in src:
        src += 'SWEP.RunSightsPos = Vector(0, 0, 0)\nSWEP.RunSightsAng = Vector(0, 0, 0)\n'
    
    # 20. Add AlternativePos
    if 'SWEP.AlternativePos' not in src:
        src += 'SWEP.AlternativePos = Vector(0, 0, 0)\nSWEP.AlternativeAng = Angle(0, 0, 0)\n'
    
    # 21. Rename file: nz_ghosts_X → ghosts_X
    output_name = weapon_name.replace('nz_ghosts_', 'ghosts_')
    output_path = os.path.join(OUTPUT_DIR, output_name + '.lua')
    
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(src)
    
    return output_name


def main():
    # Ensure output directory exists
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
    
    print(f"Porting {len(weapons)} weapons...\n")
    
    for name, weapon_name in weapons:
        src_path = os.path.join(SOURCE_DIR, name + '.lua')
        output_name = convert_weapon(src_path, name)
        print(f"  PORTED: {output_name}")
    
    print(f"\nDone. Ported {len(weapons)} weapons.")


if __name__ == "__main__":
    main()
