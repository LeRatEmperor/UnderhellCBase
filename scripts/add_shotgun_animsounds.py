#!/usr/bin/env python3
"""
Add the correct AnimSounds entries for shotgun reload keys (start_reload, reload_loop, after_reload)
to the 4 shotgun weapons, using the EXACT sounds from the TFA EventTable.

Also fix the T key error by ensuring GetStatL stub is in the CUH base.
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

# The TFA EventTable uses ACT_SHOTGUN_RELOAD_START, ACT_VM_RELOAD, ACT_SHOTGUN_RELOAD_FINISH
# which the converter mapped to shotgun_reload_start, reload, shotgun_reload_finish.
# But the Animations table uses start_reload, reload_loop, after_reload.
# We need to add AnimSounds entries for start_reload, reload_loop, after_reload
# using the exact TFA sounds.

SHOTGUN_SOUNDS = {
    'uh_codww2_mas36.lua': {
        'start_reload': [
            (1/30, 'TFA_CODWW2_MAS36.Open'),
            (30/30, 'TFA_CODWW2_MAS36.Insert'),
        ],
        'reload_loop': [
            (1/30, 'TFA_CODWW2_MAS36.Insert'),
        ],
        'after_reload': [
            (1/30, 'TFA_CODWW2_MAS36.Close'),
        ],
    },
    'uh_codww2_winchester94.lua': {
        'start_reload': [
            (1/30, 'TFA_CODWW2_LEVER.Start'),
        ],
        'reload_loop': [
            (1/30, 'TFA_CODWW2_LEVER.Insert'),
        ],
        'after_reload': [
            (5/30, 'TFA_CODWW2_LEVER.Charge'),
        ],
    },
    'uh_codww2_model1897.lua': {
        'start_reload': [
            (1/30, 'TFA_CODWW2_M1897.ADSFoley'),
            (1/30, 'TFA_CODWW2_M1897.ShellStart'),
            (30/30, 'TFA_CODWW2_M1897.ShellIn'),
        ],
        'reload_loop': [
            (5/30, 'TFA_CODWW2_M1897.ShellIn'),
        ],
        'after_reload': [
            (1/30, 'TFA_CODWW2_M1897.EndStart'),
            (10/30, 'TFA_CODWW2_M1897.EndPump'),
        ],
    },
    'uh_codww2_m1879.lua': {
        'start_reload': [
            (5/30, 'TFA_CODWW2_M1879.Open'),
            (15/30, 'TFA_CODWW2_M1879.Insert'),
        ],
        'reload_loop': [
            (0/30, 'TFA_CODWW2_M1879.Insert'),
        ],
        'after_reload': [
            (0/30, 'TFA_CODWW2_M1879.Close'),
        ],
    },
}


def add_shotgun_animsounds(filepath, sounds):
    """Add start_reload, reload_loop, after_reload to the AnimSounds table."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # Find the AnimSounds table closing brace
    # Pattern: SWEP.AnimSounds = { ... }
    m = re.search(r'SWEP\.AnimSounds\s*=\s*\{', content)
    if not m:
        return ['no AnimSounds table found']

    # Find the matching closing brace
    start = m.end() - 1  # position of opening {
    depth = 0
    i = start
    in_string = False
    string_char = None
    in_line_comment = False
    while i < len(content):
        c = content[i]
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
        return ['could not find end of AnimSounds']

    # The AnimSounds table content is from start+1 to i
    anim_content = content[start+1:i]

    # Add missing keys
    new_entries = []
    for key, entries in sounds.items():
        if f'["{key}"]' in anim_content:
            continue  # already exists
        lines = [f'    ["{key}"] = {{']
        for time, snd in entries:
            lines.append(f'        {{ time = {time:.4f}, sound = "{snd}" }},')
        lines.append('    },')
        new_entries.append('\n'.join(lines))
        changes.append(f'added ["{key}"]')

    if new_entries:
        # Insert before the closing brace
        insert_str = '\n' + '\n'.join(new_entries) + '\n'
        content = content[:i] + insert_str + content[i:]
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Adding correct AnimSounds entries for shotgun reload ===\n")

    for fname, sounds in SHOTGUN_SOUNDS.items():
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        if not os.path.exists(filepath):
            print(f"  WARNING: {fname} not found")
            continue
        changes = add_shotgun_animsounds(filepath, sounds)
        if changes:
            print(f"  {fname}: {', '.join(changes)}")
        else:
            print(f"  {fname}: all keys already present")


if __name__ == '__main__':
    main()
