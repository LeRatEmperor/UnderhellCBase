#!/usr/bin/env python3
"""Convert TFA sound script to sound.Add() format."""

import re

SOURCE = "/home/z/my-project/source_repos/ghosts_weapons/lua/tfa/external/wavy_tfa_ghosts_sounds.lua"
OUTPUT = "/home/z/my-project/cod_ghosts_underhellsweps/lua/autorun/ghosts_sounds.lua"

with open(SOURCE, 'r') as f:
    src = f.read()

out = [
    '-- ghosts_sounds.lua',
    '-- Converted from TFA AddFireSound/AddWeaponSound to sound.Add()',
    '',
    'if SERVER then AddCSLuaFile() end',
    '',
]

count = 0
for line in src.split('\n'):
    line = line.strip()
    
    # Keep section comments
    if line.startswith('--GHOSTS'):
        out.append('')
        out.append(line)
        continue
    
    # TFA.AddFireSound("NAME", {"path1", "path2"}, true, ")")
    # TFA.AddFireSound("NAME", "path", true, ")")
    if line.startswith('TFA.AddFireSound('):
        name_m = re.search(r'"([^"]+)"', line)
        if not name_m: continue
        name = name_m.group(1)
        # Find all sound paths
        paths = re.findall(r'"(weapons/[^"]+)"', line)
        if not paths: continue
        sound = '{"' + '", "'.join(paths) + '}' if len(paths) > 1 else '"' + paths[0] + '"'
        out.append(f'sound.Add({{ name = "{name}", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {{95, 105}}, sound = {sound} }})')
        count += 1
        continue
    
    # TFA.AddWeaponSound("NAME", "path")
    if line.startswith('TFA.AddWeaponSound('):
        name_m = re.search(r'"([^"]+)"', line)
        if not name_m: continue
        name = name_m.group(1)
        path_m = re.findall(r'"(weapons/[^"]+)"', line)
        if not path_m: continue
        path = path_m[0]
        out.append(f'sound.Add({{ name = "{name}", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {{95, 105}}, sound = "{path}" }})')
        count += 1
        continue

out.append('')

with open(OUTPUT, 'w') as f:
    f.write('\n'.join(out))

print(f"Written {count} sound definitions to {OUTPUT}")
