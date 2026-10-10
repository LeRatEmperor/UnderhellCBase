#!/usr/bin/env python3
"""
Rebuild AnimSounds tables for all WWII weapons by:
1. Parsing the sound script (nz_codww2_sounds.lua) to get all sound names per weapon
2. Matching sound name suffixes to animation keys (reload, reload_empty, draw, etc.)
3. Assigning proper timing based on standard TFA frame conversions (N/30 seconds)
4. Writing complete AnimSounds tables with ALL sound entries (not just the first)

Also: remove shotgun reload from weapons that don't need it
(keep only for: model1897, mas36, m1879)
"""
import os
import re

WWII_DIR = "/home/z/my-project/worldwarii_underhell"
WEAPONS_DIR = os.path.join(WWII_DIR, "lua", "weapons")
SOUND_SCRIPT = os.path.join(WWII_DIR, "lua", "autorun", "nz_codww2_sounds.lua")

# Weapons that should KEEP shotgun reload
SHOTGUN_RELOAD_KEEP = {
    'uh_codww2_model1897.lua',  # Combat shotgun
    'uh_codww2_mas36.lua',      # M36
    'uh_codww2_m1879.lua',      # Reichsrevolver
}

# Weapons that should LOSE shotgun reload
SHOTGUN_RELOAD_REMOVE = {
    'uh_codww2_m30.lua',
    'uh_codww2_model21.lua',
    'uh_codww2_walther.lua',
    'uh_codww2_blunderbuss.lua',
    'uh_codww2_winchester94.lua',
}


# ============================================================
# SOUND NAME → ANIMATION KEY + TIMING MAPPING
# ============================================================
# Based on standard TFA WWII EventTable patterns (frame/30 = seconds at 30fps)

# Map sound suffix → (anim_key, time_seconds)
# The suffix is matched against the part after "WEAPON_NAME."
SOUND_SUFFIX_MAP = {
    # --- DRAW ---
    'FPO': [('draw_first', 10/30)],           # 0.333s
    'FPOFoley': [('draw_first', 5/30)],
    'FPOCharge': [('draw_first', 3/30)],
    'FPOChargeRattle': [('draw_first', 8/30)],
    'FPOEpic': [('draw_first_epic', 10/30)],
    'FPOEpic1': [('draw_first_epic', 5/30)],
    'FPOEpic2': [('draw_first_epic', 15/30)],
    'FPOGrab': [('draw_first', 2/30)],
    'Raise': [('draw', 1/30)],                # 0.033s
    'Draw': [('draw', 1/30)],

    # --- HOLSTER ---
    'Holster': [('holster', 1/30)],           # 0.033s
    'Putaway': [('holster', 1/30)],

    # --- RECHAMBER (bolt-action / pump) ---
    'CycleOpen': [('rechamber', 5/30)],      # 0.167s
    'CycleClose': [('rechamber', 15/30)],     # 0.500s
    'CycleAdsOpen': [('rechamber_ads', 5/30)],
    'CycleAdsClose': [('rechamber_ads', 15/30)],

    # --- RELOAD (tactical - partial mag) ---
    'TacOpen': [('reload', 5/30)],           # 0.167s
    'TacFoley': [('reload', 3/30)],
    'TacStart': [('reload', 5/30)],
    'TacMagOut': [('reload', 15/30)],        # 0.500s
    'TacMagOutFoley': [('reload', 10/30)],
    'TacMagOutRattle': [('reload', 12/30)],
    'TacClipout': [('reload', 15/30)],
    'TacMagGrab': [('reload', 35/30)],       # 1.167s
    'TacMagGrabFoley': [('reload', 30/30)],
    'TacClipin': [('reload', 55/30)],        # 1.833s
    'TacMagIn': [('reload', 55/30)],
    'TacMagInFoley': [('reload', 50/30)],
    'TacMagInRattle': [('reload', 60/30)],
    'TacInsert': [('reload', 55/30)],
    'TacClose': [('reload', 70/30)],         # 2.333s
    'TacLoad': [('reload', 65/30)],

    # --- RELOAD EMPTY ---
    'EmptyOpen': [('reload_empty', 5/30)],
    'EmptyFoley': [('reload_empty', 3/30)],
    'EmptyStart': [('reload_empty', 5/30)],
    'EmptyInsert': [('reload_empty', 40/30)],
    'EmptyClipin': [('reload_empty', 55/30)],
    'EmptyClose': [('reload_empty', 75/30)],   # 2.500s

    # --- RELOAD EXT (extended mag, tactical) ---
    'TacExtMagout': [('reload_ext', 1/30)],
    'ExtTacMagOut': [('reload_ext', 1/30)],
    'TacExtMagOut': [('reload_ext', 1/30)],
    'TacExtMagIn': [('reload_ext', 65/30)],
    'ExtTacMagIn': [('reload_ext', 65/30)],
    'TacExtMagin': [('reload_ext', 65/30)],
    'ExtTacMagin': [('reload_ext', 65/30)],
    'ExtTacClose': [('reload_ext', 70/30)],
    'ExtTacOpen': [('reload_ext', 5/30)],

    # --- RELOAD EXT EMPTY ---
    'EmptyExtOpen': [('reload_ext_empty', 5/30)],
    'EmptyExtMagout': [('reload_ext_empty', 40/30)],
    'EmptyExtMagin': [('reload_ext_empty', 85/30)],
    'EmptyExtClose': [('reload_ext_empty', 100/30)],  # 3.333s

    # --- INSPECT ---
    'Inspect1': [('inspect', 1/30)],
    'Inspect2': [('inspect', 50/30)],         # 1.667s
    'Inspect1a': [('inspect', 1/30)],
    'Inspect1b': [('inspect', 20/30)],
    'Inspect1c': [('inspect', 40/30)],
    'Inspect2a': [('inspect', 50/30)],
    'Inspect2b': [('inspect', 70/30)],
    'Inspect2c': [('inspect', 90/30)],
    'Inspect3': [('inspect', 110/30)],
    'EpicInspect1': [('inspect_epic', 1/30)],
    'EpicInspect2': [('inspect_epic', 50/30)],
    'EpicInspect3': [('inspect_epic', 100/30)],
    'InspectEpic1': [('inspect_epic', 1/30)],
    'InspectEpic2': [('inspect_epic', 50/30)],
    'InspectEpic3': [('inspect_epic', 100/30)],

    # --- MELEE ---
    'Melee': [('melee', 5/30)],
    'Swing': [('melee', 5/30)],

    # --- SHOTGUN SHELL RELOAD ---
    'ShellIn': [('reload_loop', 10/30)],
    'ShellStart': [('start_reload', 5/30)],
    'ShellA': [('reload_loop', 10/30)],
    'ShellB': [('reload_loop', 10/30)],
    'EndPump': [('after_reload', 10/30)],
    'EndStart': [('after_reload', 5/30)],
    'RifleOpen': [('start_reload', 5/30)],
    'RifleClose': [('after_reload', 15/30)],
    'RifleChamber': [('reload_loop', 10/30)],

    # --- GRENADE/UBGL ---
    'Pin': [('reload_grenade', 5/30)],
    'PullPin': [('reload_grenade', 5/30)],
    'Throw': [('reload_grenade', 30/30)],
    'Stab': [('reload_grenade', 10/30)],
    'Pullpin': [('reload_grenade', 5/30)],
    'StickPullPin': [('reload_grenade', 5/30)],
    'StickThrow': [('reload_grenade', 30/30)],
    'StickBounce': [('reload_grenade', 20/30)],
    'PullPinQuick': [('reload_grenade', 3/30)],
}

# Generic sounds (not weapon-specific)
GENERIC_SOUNDS = {
    'TFA_CODWW2_RIFLE.Raise': [('draw', 1/30), ('draw_empty', 1/30)],
    'TFA_CODWW2_RIFLE.Holster': [('holster', 1/30), ('holster_empty', 1/30)],
    'TFA_CODWW2_GEN.AdsUp': [('iron_in', 0.0)],
    'TFA_CODWW2_GEN.AdsDown': [('iron_out', 0.0)],
    'TFA_CODWW2_GEN.Switch': [('firemode_switch', 0.0)],
    'TFA_CODWW2_PICKUP.Ammo': [('pickup', 0.0)],
    'TFA_CODWW2_MELEE.SwingRfl': [('melee', 5/30)],
    'TFA_CODWW2_MELEE.SwingPst': [('melee', 5/30)],
    'TFA_CODWW2_MELEE.Hit': [('melee', 15/30)],
    'TFA_CODWW2_MELEE.HitPlr': [('melee', 15/30)],
    'TFA_CODWW2_DRYFIRE.SNP': [('shoot_empty', 0.0)],
    'TFA_CODWW2_DRYFIRE.SG': [('shoot_empty', 0.0)],
    'TFA_CODWW2_DRYFIRE.RFL': [('shoot_empty', 0.0)],
    'TFA_CODWW2_DRYFIRE.PST': [('shoot_empty', 0.0)],
    'TFA_CODWW2_SHELLS.Large': [('shell_eject', 0.0)],
    'TFA_CODWW2_SHELLS.Small': [('shell_eject', 0.0)],
    'TFA_CODWW2_TAIL.Int': [],  # echo, skip
}


def parse_sound_script(filepath):
    """Parse the sound script and return {sound_name: True} for all defined sounds."""
    sounds = set()
    with open(filepath) as f:
        content = f.read()
    # Match: name = "TFA_CODWW2_..."
    for m in re.finditer(r'name\s*=\s*"(TFA_CODWW2_[^"]+)"', content):
        sounds.add(m.group(1))
    return sounds


def get_weapon_sounds(all_sounds, weapon_prefix):
    """Get all sounds that belong to a specific weapon (by prefix).
    Tries the given prefix first, then falls back to alternative prefixes.
    """
    # Direct match
    prefix = f'TFA_CODWW2_{weapon_prefix}.'
    sounds = sorted(s for s in all_sounds if s.startswith(prefix))
    if sounds:
        return sounds

    # Try alternative prefixes for known multi-prefix weapons
    alt_prefixes = {
        'M1897': ['M1897', 'M97', 'SHGN'],
        'BLUNDER': ['BLUNDER', 'BM38'],
        'LEVER': ['LEVER', 'WINCHESTER'],
        'M1CARB': ['M1CARB', 'M2CARB'],
        'M1928': ['M1928', 'THOMPSON'],
        'M1935': ['M1935', 'PG1935', 'LSAT', 'EPM3'],
        'BERETTA38': ['BM38', 'BERETTA38'],
        'GROSSFUSS': ['GFSTG', 'GROSSFUSS'],
        'KGM21': ['GG', 'KGM21'],
        'GG': ['GG', 'M3', 'GREASE'],
        'RIBEY': ['RIBEY', 'ARSENAL'],
        'THOMPSON': ['M1928', 'THOMPSON'],
        'M1919': ['M1919', 'STINGER'],
        'PPSH': ['PPSH', 'THECLASSIC', 'RHINO'],
    }

    for alt in alt_prefixes.get(weapon_prefix, []):
        prefix = f'TFA_CODWW2_{alt}.'
        sounds = sorted(s for s in all_sounds if s.startswith(prefix))
        if sounds:
            return sounds

    return sounds


def get_weapon_prefix(filename):
    """Extract the weapon prefix from the CUH filename."""
    name = filename.replace('uh_codww2_', '').replace('.lua', '')
    # Map CUH weapon name to sound script prefix (based on actual sound script prefixes)
    name_map = {
        'kar98k': 'KAR98K',
        '1911': '1911',
        'model1897': 'M1897',
        'm30': 'M30',
        'model21': 'MODEL21',
        'walther': 'WALTHER',
        'blunderbuss': 'BLUNDER',
        'mas36': 'MAS36',
        'winchester94': 'LEVER',
        'm1879': 'M1879',
        'arisaka': 'ARISAKA',
        'delisle': 'DELISLE',
        'enfield': 'ENFIELD',
        'mosin': 'MOSIN',
        'sdk': 'SDK',
        'springfield': 'M1903',
        'wz35': 'WZ35',
        'stg44': 'STG44',
        'bar': 'BAR',
        'fg42': 'FG42',
        'mp40': 'MP40',
        'thompson': 'M1928',
        'm1garand': 'M1GRND',
        'm1a1': 'M1CARB',
        'm2carbine': 'M1CARB',
        'mg42': 'MG42',
        'bren': 'BREN',
        'lewis': 'LEWIS',
        'm1919': 'M1919',
        'greasegun': 'GREASE',
        'sterling': 'STRLNG',
        'sten': 'STEN',
        'mp28': 'MP28',
        'm1928a1': 'M1928',
        'm2hyde': 'HYDE',
        'austen': 'AUausten',
        'bechowiec': 'STEN',
        'blyskawica': 'PIORUN',
        'erma': 'ERMA',
        'volk': 'VOLK',
        'type100': 'TYPE100',
        'type5': 'TYPE5',
        'nambu': 'NAMBU',
        'p38': 'P38',
        'luger': 'LUGER',
        'm712': 'M712',
        'no2': 'NO2',
        'stinger': 'M1919',
        'ribey': 'RIBEY',
        'gewehr43': 'GEWEHR',
        'svt40': 'SVT',
        'avs36': 'AVS',
        'as44': 'AS44',
        'charlton': 'FDRV',
        'federov': 'FDRV',
        'breda30': 'BREDA',
        'chatellerault': 'AXE',
        'm1941': 'M1941',
        'mg15': 'MG15',
        'mg81': 'MG81',
        'lad': 'LAD',
        'grossfuss': 'GFSTG',
        'emp44': 'EMP44',
        'kgm21': 'GG',
        'vmg27': 'VMG27',
        'ptrs41': 'PTRS',
        'wimmer': 'BZKA',
        'pg1935': 'M1935',
        'zk383': 'ZK383',
        'arsenal': 'RIBEY',
        'beretta38': 'BM38',
        'mas38': 'MAS38',
        'theclassic': 'PPSH',
    }
    return name_map.get(name, name.upper())

def build_animsounds(weapon_sounds):
    """Build the AnimSounds table from weapon-specific sound names."""
    sounds_by_key = {}  # {anim_key: [(time, sound_name), ...]}

    for sound_name in weapon_sounds:
        # Check if it's a generic sound
        if sound_name in GENERIC_SOUNDS:
            for anim_key, time in GENERIC_SOUNDS[sound_name]:
                sounds_by_key.setdefault(anim_key, []).append((time, sound_name))
            continue

        # Extract the suffix (part after WEAPON_PREFIX.)
        parts = sound_name.split('.', 1)
        if len(parts) < 2:
            continue
        suffix = parts[1]

        # Skip shooting/echo/lyr sounds (handled by PrimaryAttack, not AnimSounds)
        skip_suffixes = {'Ext', 'Main', 'Sub', 'Boom', 'Boom.Delay', 'Punch', 'Punch.Delay',
                        'Punch03', 'Trans', 'Trans.Delay', 'Low', 'LowCrack', 'Crack',
                        'High', 'Mid', 'Thick', 'ThickTrans', 'Lfe', 'Plr', 'PlrMech',
                        'Smack', 'Int.Delay', 'NPC.Shot', 'NPC_shot_01', 'Shot', 'Shot01',
                        'Shoot', 'ShootLast', 'Last', 'LastShot', 'Tail', 'Tail05',
                        'Dist', 'Wide', 'Stereo', 'Super_Dist', 'Hit', 'HitLow', 'HitReverb',
                        'Lyr1', 'Lyr2', 'Lyr3', 'Lyr4', 'GenHigh', 'GenBoom', 'GenBlast',
                        'MidBlast', 'BigBlast', 'DeepBlast', 'Blast', 'Fire', 'MP_Shot',
                        'Ducker', 'Mech', 'MechEmpty', 'Mechy', 'PapFlux', 'CrackTrans',
                        'Accent', 'Thump', 'Brass', 'Bright', 'Trigger', 'Click', 'Clicky',
                        'Snap', 'Tick', 'Ping', 'Rattle', 'Hold', 'Settle', 'Stop',
                        'Bounce', 'Land', 'Drop', 'Center', 'Center1', 'Center2',
                        'ChargeRattle', 'ChargeLyr', 'ChargeFoley',
                        }
        if suffix in skip_suffixes:
            continue

        # Look up the suffix in the mapping
        if suffix in SOUND_SUFFIX_MAP:
            for anim_key, time in SOUND_SUFFIX_MAP[suffix]:
                sounds_by_key.setdefault(anim_key, []).append((time, sound_name))
        else:
            # Try partial matching for compound suffixes
            # e.g. "TacMagOut_L" → try "TacMagOut"
            matched = False
            for pattern, mappings in SOUND_SUFFIX_MAP.items():
                if suffix.startswith(pattern) or suffix == pattern:
                    for anim_key, time in mappings:
                        sounds_by_key.setdefault(anim_key, []).append((time, sound_name))
                    matched = True
                    break
            if not matched:
                # Unknown suffix — skip it (it's probably a shooting/echo sound)
                pass

    # Sort each key's sounds by time and deduplicate
    for key in sounds_by_key:
        # Deduplicate by (time, sound) — keep unique entries
        seen = set()
        unique = []
        for time, snd in sorted(sounds_by_key[key]):
            if (time, snd) not in seen:
                seen.add((time, snd))
                unique.append((time, snd))
        sounds_by_key[key] = unique

    return sounds_by_key


def generate_animsounds_lua(sounds_by_key):
    """Generate the SWEP.AnimSounds = {...} Lua code."""
    if not sounds_by_key:
        return 'SWEP.AnimSounds = {}'

    lines = ['SWEP.AnimSounds = {']
    for key in sorted(sounds_by_key.keys()):
        entries = sounds_by_key[key]
        if not entries:
            continue
        lines.append('    ["' + key + '"] = {')
        for time, snd in entries:
            snd_escaped = snd.replace('\\', '\\\\').replace('"', '\\"')
            lines.append(f'        {{ time = {time:.4f}, sound = "{snd_escaped}" }},')
        lines.append('    },')
    lines.append('}')
    return '\n'.join(lines)


def update_weapon_animsounds(filepath, all_sounds):
    """Update a weapon file's AnimSounds table."""
    filename = os.path.basename(filepath)
    weapon_prefix = get_weapon_prefix(filename)
    weapon_sounds = get_weapon_sounds(all_sounds, weapon_prefix)

    if not weapon_sounds:
        return f'no sounds found for prefix {weapon_prefix}'

    sounds_by_key = build_animsounds(weapon_sounds)
    if not sounds_by_key:
        return f'no matching sounds for {weapon_prefix}'

    animsounds_lua = generate_animsounds_lua(sounds_by_key)

    with open(filepath) as f:
        content = f.read()

    # Replace existing SWEP.AnimSounds = {...} block
    # Match from "SWEP.AnimSounds = {" to the matching closing "}"
    # The table can be multi-line, so we need to find the matching brace
    pattern = re.compile(r'SWEP\.AnimSounds\s*=\s*\{', re.MULTILINE)
    m = pattern.search(content)
    if not m:
        # No existing AnimSounds — append at end
        content = content.rstrip() + '\n\n' + animsounds_lua + '\n'
    else:
        # Find the matching closing brace
        start = m.end() - 1  # position of opening {
        depth = 0
        i = start
        in_string = False
        string_char = None
        in_long_comment = False
        in_line_comment = False
        while i < len(content):
            c = content[i]
            if in_long_comment:
                if content[i:i+2] == ']]':
                    in_long_comment = False
                    i += 2
                    continue
                i += 1
                continue
            if in_line_comment:
                if c == '\n':
                    in_line_comment = False
                i += 1
                continue
            if in_string:
                if c == '\\':
                    i += 2
                    continue
                if c == string_char:
                    in_string = False
                i += 1
                continue
            if content[i:i+4] == '--[[':
                in_long_comment = True
                i += 4
                continue
            if content[i:i+2] == '--':
                in_line_comment = True
                i += 2
                continue
            if c == '"' or c == "'":
                in_string = True
                string_char = c
                i += 1
                continue
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    break
            i += 1

        if i >= len(content):
            return 'could not find end of AnimSounds table'

        # Replace from m.start() to i+1
        content = content[:m.start()] + animsounds_lua + content[i+1:]

    with open(filepath, 'w') as f:
        f.write(content)

    total_entries = sum(len(v) for v in sounds_by_key.values())
    return f'AnimSounds rebuilt ({len(sounds_by_key)} keys, {total_entries} entries)'


def remove_shotgun_reload(filepath):
    """Remove shotgun reload code from weapons that don't need it."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # Remove the SHOTGUN SHELL-BY-SHELL RELOAD block
    pattern = re.compile(
        r'-- =+\n-- SHOTGUN SHELL-BY-SHELL RELOAD\n-- =+\n.*?(?=\n-- =+\n|\nfunction SWEP:|\nSWEP\.\w+|\Z)',
        re.DOTALL
    )
    new_content = pattern.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun reload block')

    # Remove the CustomThink that dispatches ReloadShotgun
    pattern2 = re.compile(
        r'-- CustomThink: dispatches ReloadShotgun.*?\nSWEP\.CustomThink = function\(self, ct\)\n    if self\.Shotgun and self\.ReloadShotgun and self:GetUHBool\("Reloading"\) then\n        self:ReloadShotgun\(ct\)\n    end\nend\n',
        re.DOTALL
    )
    new_content = pattern2.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun CustomThink')

    # Remove SWEP.Shotgun = true if it was added by the shotgun block
    pattern3 = re.compile(r'^SWEP\.Shotgun = true\n', re.MULTILINE)
    new_content = pattern3.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed SWEP.Shotgun = true')

    # Remove SWEP.ShellLoadTime if present
    pattern4 = re.compile(r'^SWEP\.ShellLoadTime = SWEP\.ShellLoadTime or [\d\.]+\n', re.MULTILINE)
    new_content = pattern4.sub('', content, count=1)
    if new_content != content:
        content = new_content

    # Remove SWEP.IsPump = true (keep the pump PostShoot though — it's fine for shotguns)
    # Actually, keep IsPump and PostShoot — the pump action after firing is still wanted
    # Just remove the shell-by-shell reload

    # Remove the start_reload/reload_loop/after_reload animation keys
    # (these are only for shotgun shell reload)
    pattern5 = re.compile(r'    \["start_reload"\]\s*=\s*"reload_start",\n    \["reload_loop"\]\s*=\s*"reload_loop",\n    \["after_reload"\]\s*=\s*"reload_end",\n')
    new_content = pattern5.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun anim keys')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Rebuilding AnimSounds tables from sound script ===\n")

    # Parse the sound script
    all_sounds = parse_sound_script(SOUND_SCRIPT)
    print(f"Found {len(all_sounds)} sound definitions in sound script\n")

    # Process each weapon
    for filename in sorted(os.listdir(WEAPONS_DIR)):
        if not filename.startswith('uh_codww2_') or not filename.endswith('.lua'):
            continue
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.isfile(filepath):
            continue

        result = update_weapon_animsounds(filepath, all_sounds)
        print(f"  {filename}: {result}")

    # Remove shotgun reload from weapons that don't need it
    print("\n=== Removing shotgun reload from weapons that don't need it ===\n")
    for filename in SHOTGUN_RELOAD_REMOVE:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = remove_shotgun_reload(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
