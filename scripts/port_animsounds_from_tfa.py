#!/usr/bin/env python3
"""
Port AnimSounds from original TFA EventTable files.

This reads the ACTUAL SWEP.EventTable from each original TFA weapon file
(/home/z/my-project/repos/tfa_wwii_original/lua/weapons/nz_kate_codww2_*.lua)
and converts each entry verbatim:
    { ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_KAR98K.TacOpen") }
→   { time = 0.1667, sound = "TFA_CODWW2_KAR98K.TacOpen" }

Only 'sound' type entries are ported ('lua' type entries are skipped).
ACT_VM_* keys are mapped to string keys that the CUH AnimSounds system uses.
"""
import os
import re

TFA_DIR = "/home/z/my-project/repos/tfa_wwii_original/lua/weapons"
CUH_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

# Map ACT_VM_* constants to CUH animation keys.
# These are the string keys that EasySendWeaponAnim uses in the CUH base.
# EVERY ACT_* constant used in any TFA EventTable must be mapped here.
ACT_TO_KEY = {
    "ACT_VM_DRAW":            "draw",
    "ACT_VM_DRAW_DEPLOYED":   "draw_first",
    "ACT_VM_DRAW_EMPTY":      "draw_empty",
    "ACT_VM_HOLSTER":         "holster",
    "ACT_VM_HOLSTER_EMPTY":   "holster_empty",
    "ACT_VM_RELOAD":          "reload",
    "ACT_VM_RELOAD_EMPTY":    "reload_empty",
    "ACT_VM_RELOAD_DEPLOYED": "reload_deployed",
    "ACT_VM_RELOAD_SILENCED": "reload_silenced",
    "ACT_VM_RELOAD_END":      "reload_end",
    "ACT_VM_RELOAD2":         "reload2",
    "ACT_RELOAD_LOW":         "reload_low",
    "ACT_VM_PRIMARYATTACK":          "shoot",
    "ACT_VM_PRIMARYATTACK_1":        "shoot1",
    "ACT_VM_PRIMARYATTACK_EMPTY":    "shoot_last",
    "ACT_VM_PRIMARYATTACK_SILENCED": "shoot_silenced",
    "ACT_VM_PULLBACK_HIGH":   "rechamber",
    "ACT_VM_PULLBACK_LOW":    "rechamber_ads",
    "ACT_VM_FIDGET":          "inspect",
    "ACT_VM_FIDGET_SILENCED": "inspect_silenced",
    "ACT_VM_IDLE_EMPTY":     "idle_empty",
    "ACT_VM_HITCENTER":      "melee",
    "ACT_VM_MISSCENTER":     "melee",
    "ACT_VM_MISSLEFT":      "melee",
    "ACT_SHOTGUN_RELOAD_START":  "shotgun_reload_start",
    "ACT_SHOTGUN_RELOAD_FINISH": "shotgun_reload_finish",
}


def parse_event_table(content):
    """Parse SWEP.EventTable = { ... } from TFA weapon file content.
    Returns {anim_key: [(time, sound_name), ...]} for all 'sound' type entries.
    """
    # Find "SWEP.EventTable = {"
    m = re.search(r'SWEP\.EventTable\s*=\s*\{', content)
    if not m:
        return None
    # Match braces to find end of table
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
        return None
    table_str = content[start:i+1]
    return _extract_sounds(table_str)


def _extract_sounds(table_str):
    """Extract all 'sound' type entries from the EventTable string.
    Returns {anim_key: [(time, sound_name), ...]}
    """
    sounds = {}
    i = 0
    n = len(table_str)
    while i < n:
        # Skip whitespace
        while i < n and table_str[i] in ' \t\n':
            i += 1
        if i >= n:
            break
        c = table_str[i]
        # Skip outer braces and commas
        if c in '{}':
            i += 1
            continue
        if c == ',':
            i += 1
            continue
        # Match key: either [ACT_VM_X] or ["string_key"] or bare_identifier
        key = None
        if c == '[':
            j = table_str.find(']', i)
            if j == -1:
                break
            inner = table_str[i+1:j].strip()
            if inner.startswith('"') or inner.startswith("'"):
                key = inner[1:-1]
            else:
                key = inner  # ACT_VM_X identifier
            i = j + 1
        elif c.isalpha() or c == '_':
            m = re.match(r'\w+', table_str[i:])
            if m:
                key = m.group(0)
                i += len(key)
            else:
                i += 1
                continue
        else:
            i += 1
            continue
        # Skip whitespace and '='
        while i < n and table_str[i] in ' \t\n':
            i += 1
        if i < n and table_str[i] == '=':
            i += 1
        else:
            continue
        # Skip whitespace
        while i < n and table_str[i] in ' \t\n':
            i += 1
        # Match value: should be a table { ... }
        if i >= n or table_str[i] != '{':
            continue
        # Find matching brace
        depth = 1
        j = i + 1
        in_str = False
        str_char = None
        while j < n and depth > 0:
            ch = table_str[j]
            if in_str:
                if ch == '\\':
                    j += 2
                    continue
                if ch == str_char:
                    in_str = False
                j += 1
                continue
            if ch == '"' or ch == "'":
                in_str = True
                str_char = ch
                j += 1
                continue
            if table_str[j:j+2] == '--':
                # Skip line comment
                while j < n and table_str[j] != '\n':
                    j += 1
                continue
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
            j += 1
        value_str = table_str[i:j]

        # Determine anim_key
        anim_key = ACT_TO_KEY.get(key, key)
        if anim_key == key and key.startswith("ACT_"):
            # Unmapped ACT_ constant — skip
            i = j
            continue

        # Parse sound entries from value_str
        entries = _parse_sound_entries(value_str)
        if entries:
            # Merge with existing entries for this key (some files have
            # multiple values that map to the same key, e.g. ACT_VM_PULLBACK_HIGH
            # and ["rechamber"] both map to "rechamber")
            existing = sounds.get(anim_key, [])
            existing.extend(entries)
            sounds[anim_key] = existing
        i = j
    return sounds


def _parse_sound_entries(value_str):
    """Parse the list of { ["time"] = N/30, ["type"] = "sound", ["value"] = Sound("...") } entries.
    Returns [(time, sound_name), ...] for 'sound' type entries only.
    """
    # Strip the outer braces — the value_str is like "{ {entry1}, {entry2}, ... }"
    # and we need to parse the INNER entries, not treat the whole thing as one entry.
    inner = value_str.strip()
    if inner.startswith('{'):
        inner = inner[1:]
    if inner.endswith('}'):
        inner = inner[:-1]

    entries = []
    i = 0
    n = len(inner)
    while i < n:
        # Find next '{'
        while i < n and inner[i] != '{':
            i += 1
        if i >= n:
            break
        # Match brace
        depth = 1
        j = i + 1
        in_str = False
        str_char = None
        while j < n and depth > 0:
            ch = inner[j]
            if in_str:
                if ch == '\\':
                    j += 2
                    continue
                if ch == str_char:
                    in_str = False
                j += 1
                continue
            if ch == '"' or ch == "'":
                in_str = True
                str_char = ch
                j += 1
                continue
            if inner[j:j+2] == '--':
                while j < n and inner[j] != '\n':
                    j += 1
                continue
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
            j += 1
        entry_str = inner[i:j]
        i = j

        # Parse entry_str
        # Match: ["time"] = <expr>, ["type"] = "sound", ["value"] = Sound("X")
        time_m = re.search(r'\["time"\]\s*=\s*([^\n,]+?)(?:,|\s*\n)', entry_str)
        type_m = re.search(r'\["type"\]\s*=\s*"(\w+)"', entry_str)
        if not type_m:
            # Try single-quote
            type_m = re.search(r"\[\"type\"\]\s*=\s*\'(\w+)\'", entry_str)
        if not type_m:
            continue
        if type_m.group(1) != 'sound':
            continue  # skip 'lua' type entries
        value_m = re.search(r'\["value"\]\s*=\s*Sound\("([^"]+)"\)', entry_str)
        if not value_m:
            value_m = re.search(r"\[\"value\"\]\s*=\s*Sound\(\'([^\']+)\'\)", entry_str)
        if not value_m:
            # Try without Sound() wrapper
            value_m = re.search(r'\["value"\]\s*=\s*"([^"]+)"', entry_str)
        if not value_m:
            continue
        time_str = time_m.group(1).strip() if time_m else "0"
        # Evaluate the time expression (e.g. "5 / 30")
        try:
            time_val = eval(time_str, {'__builtins__': {}})
        except Exception:
            time_val = 0
        sound_name = value_m.group(1)
        entries.append((time_val, sound_name))
    return entries


def generate_animsounds_lua(sounds):
    """Generate SWEP.AnimSounds = {...} Lua code from the sounds dict."""
    if not sounds:
        return 'SWEP.AnimSounds = {}'
    lines = ['SWEP.AnimSounds = {']
    for key in sorted(sounds.keys()):
        entries = sounds[key]
        if not entries:
            continue
        # Sort by time
        entries.sort(key=lambda x: x[0])
        lines.append('    ["' + key + '"] = {')
        for time, snd in entries:
            snd_escaped = snd.replace('\\', '\\\\').replace('"', '\\"')
            lines.append(f'        {{ time = {time:.4f}, sound = "{snd_escaped}" }},')
        lines.append('    },')
    lines.append('}')
    return '\n'.join(lines)


def update_weapon_animsounds(cuh_filepath, tfa_filepath):
    """Read the TFA EventTable and write the corresponding AnimSounds to the CUH file."""
    with open(tfa_filepath) as f:
        tfa_content = f.read()
    sounds = parse_event_table(tfa_content)
    if sounds is None:
        return 'no EventTable found'
    if not sounds:
        return 'EventTable has no sound entries'
    animsounds_lua = generate_animsounds_lua(sounds)
    with open(cuh_filepath) as f:
        cuh_content = f.read()
    # Replace existing SWEP.AnimSounds = {...} block
    # Find the start of the AnimSounds table
    pattern = re.compile(r'SWEP\.AnimSounds\s*=\s*\{', re.MULTILINE)
    m = pattern.search(cuh_content)
    if not m:
        # No existing AnimSounds — append at end
        cuh_content = cuh_content.rstrip() + '\n\n' + animsounds_lua + '\n'
    else:
        # Find the matching closing brace
        start = m.end() - 1  # position of opening {
        depth = 0
        i = start
        in_string = False
        string_char = None
        in_long_comment = False
        in_line_comment = False
        while i < len(cuh_content):
            c = cuh_content[i]
            if in_long_comment:
                if cuh_content[i:i+2] == ']]':
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
            if cuh_content[i:i+4] == '--[[':
                in_long_comment = True
                i += 4
                continue
            if cuh_content[i:i+2] == '--':
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
        if i >= len(cuh_content):
            return 'could not find end of AnimSounds table'
        # Replace from m.start() to i+1
        cuh_content = cuh_content[:m.start()] + animsounds_lua + cuh_content[i+1:]
    with open(cuh_filepath, 'w') as f:
        f.write(cuh_content)
    total_entries = sum(len(v) for v in sounds.values())
    return f'AnimSounds ported ({len(sounds)} keys, {total_entries} entries)'


def main():
    print("=== Porting AnimSounds from original TFA EventTable files ===\n")

    # Build mapping: CUH filename → TFA filename
    cuh_files = sorted(f for f in os.listdir(CUH_DIR) if f.startswith('uh_codww2_') and f.endswith('.lua'))

    for cuh_filename in cuh_files:
        # uh_codww2_kar98k.lua → nz_kate_codww2_kar98k.lua
        weapon_name = cuh_filename.replace('uh_codww2_', '').replace('.lua', '')
        tfa_filename = f'nz_kate_codww2_{weapon_name}.lua'
        tfa_filepath = os.path.join(TFA_DIR, tfa_filename)
        cuh_filepath = os.path.join(CUH_DIR, cuh_filename)

        if not os.path.exists(tfa_filepath):
            print(f"  {cuh_filename}: TFA source not found ({tfa_filename})")
            continue

        result = update_weapon_animsounds(cuh_filepath, tfa_filepath)
        print(f"  {cuh_filename}: {result}")


if __name__ == '__main__':
    main()
