#!/usr/bin/env python3
"""Fix AnimatedSprint bob jump — properly handle CRLF line endings."""

import re

FILEPATH = "/home/z/my-project/upload/weapon_uh_base.lua"

with open(FILEPATH, 'rb') as f:
    raw = f.read()

# Detect line ending style
crlf = b'\r\n' in raw[:200]
lf_only = not crlf
print(f"Line endings: {'CRLF' if crlf else 'LF'}")

# Read as text with universal newlines, then write back with original style
with open(FILEPATH, 'r', encoding='utf-8') as f:
    src = f.read()

# The old block (works with both \n and \r\n because Python's universal
# newlines normalizes everything to \n when reading)
OLD = """        -- COSINE Viewmodel Bob
        if bob != 0 and not (self.AnimatedSprint and isRunning) then
                -- Position: lateral sway + vertical bounce
                pos = pos + ang:Right() * c_lerp * (isRunning and 1 or 0.6) * bob
                pos = pos + ang:Up() * c_lll * 2 * (isZooming and -0.45 or 0.65) * (isRunning and 1 or 0.8) * bob
                pos.z = pos.z + c_veloffset.z * bob

                -- Angle: pitch/yaw/roll from bob
                ang:RotateAroundAxis(ang:Up(), -c_test * c_lrun * 10 * bob)
                ang:RotateAroundAxis(ang:Right(), -c_test * c_lrun * 1.2 * bob)
                ang:RotateAroundAxis(ang:Forward(), c_test * 3 * bob)
        end"""

NEW = """        -- COSINE Viewmodel Bob
        -- When AnimatedSprint is on, smoothly fade the bob out during sprint
        -- and fade it back in when sprint ends. This prevents the "jump"
        -- that occurs when the bob is hard-disabled/enabled.
        if self.AnimatedSprint and isRunning then
            c_sprintfade = Lerp(ft8, c_sprintfade, 0)
        else
            c_sprintfade = Lerp(ft * 5, c_sprintfade, 1)
        end
        local bob_fade = bob * c_sprintfade

        if bob_fade != 0 then
                -- Position: lateral sway + vertical bounce
                pos = pos + ang:Right() * c_lerp * (isRunning and 1 or 0.6) * bob_fade
                pos = pos + ang:Up() * c_lll * 2 * (isZooming and -0.45 or 0.65) * (isRunning and 1 or 0.8) * bob_fade
                pos.z = pos.z + c_veloffset.z * bob_fade

                -- Angle: pitch/yaw/roll from bob
                ang:RotateAroundAxis(ang:Up(), -c_test * c_lrun * 10 * bob_fade)
                ang:RotateAroundAxis(ang:Right(), -c_test * c_lrun * 1.2 * bob_fade)
                ang:RotateAroundAxis(ang:Forward(), c_test * 3 * bob_fade)
        end"""

# Also add c_sprintfade declaration
OLD_DECL = "local c_veloffset = Vector(0, 0, 0)"
NEW_DECL = "local c_veloffset = Vector(0, 0, 0)\nlocal c_sprintfade = 1  -- 1 = full bob, 0 = no bob (sprinting with AnimatedSprint)"

changed = False

if OLD in src:
    src = src.replace(OLD, NEW, 1)
    changed = True
    print("Bob block replaced")
else:
    print("ERROR: bob block not found")

if OLD_DECL in src:
    src = src.replace(OLD_DECL, NEW_DECL, 1)
    changed = True
    print("Variable declaration added")
else:
    print("ERROR: declaration not found")

if changed:
    # Write back with CRLF if the file originally had CRLF
    if crlf:
        src = src.replace('\n', '\r\n')
    with open(FILEPATH, 'w', encoding='utf-8') as f:
        f.write(src)
    print("File written successfully")
else:
    print("No changes made")
