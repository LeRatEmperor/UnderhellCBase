#!/usr/bin/env python3
"""Add start_reload, reload_loop, after_reload animation keys to shotgun weapons."""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

SHOTGUN_WEAPONS = {
    'uh_codww2_model1897.lua', 'uh_codww2_m30.lua', 'uh_codww2_model21.lua',
    'uh_codww2_walther.lua', 'uh_codww2_blunderbuss.lua', 'uh_codww2_mas36.lua',
    'uh_codww2_winchester94.lua', 'uh_codww2_m1879.lua',
}


def add_shotgun_anim_keys(filepath):
    with open(filepath) as f:
        content = f.read()

    # Find the Animations table and add the shotgun reload keys if missing
    # We'll add them right after the existing ["reload"] line
    changes = []

    if '["start_reload"]' not in content:
        # Try to insert after ["reload_empty"] = ... line
        # Pattern: ["reload_empty"] = "...",
        pattern = re.compile(r'(\s*\["reload_empty"\]\s*=\s*[^,\n]+,?)', re.MULTILINE)
        replacement = r'\1\n    ["start_reload"]   = "reload_start",\n    ["reload_loop"]    = "reload_loop",\n    ["after_reload"]   = "reload_end",'
        new_content = pattern.sub(replacement, content, count=1)
        if new_content == content:
            # Try inserting after ["reload"] line instead
            pattern2 = re.compile(r'(\s*\["reload"\]\s*=\s*[^,\n]+,?)', re.MULTILINE)
            replacement2 = r'\1\n    ["start_reload"]   = "reload_start",\n    ["reload_loop"]    = "reload_loop",\n    ["after_reload"]   = "reload_end",'
            new_content = pattern2.sub(replacement2, content, count=1)
        if new_content != content:
            content = new_content
            changes.append('added shotgun reload anim keys')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)
    return changes


def main():
    print("=== Adding shotgun reload animation keys ===")
    for filename in SHOTGUN_WEAPONS:
        filepath = os.path.join(WWII_WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = add_shotgun_anim_keys(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
