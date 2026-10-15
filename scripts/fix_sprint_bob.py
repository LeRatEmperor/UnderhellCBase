#!/usr/bin/env python3
"""Fix the AnimatedSprint viewmodel bob jump in weapon_uh_base.lua."""

FILEPATH = "/home/z/my-project/upload/weapon_uh_base.lua"

with open(FILEPATH, 'r', encoding='utf-8') as f:
    src = f.read()

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
            c_sprintfade = Lerp(ft * 8, c_sprintfade or 0, 0)  -- fade out (sprint in)
        else
            c_sprintfade = Lerp(ft * 5, c_sprintfade or 0, 1)  -- fade in (sprint out)
        end
        local bob_fade = bob * (c_sprintfade or 1)

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

if OLD in src:
    src = src.replace(OLD, NEW, 1)
    with open(FILEPATH, 'w', encoding='utf-8') as f:
        f.write(src)
    print("Patched successfully!")
else:
    print("ERROR: pattern not found")
    # Try with \r\n
    OLD_CRLF = OLD.replace('\n', '\r\n')
    NEW_CRLF = NEW.replace('\n', '\r\n')
    if OLD_CRLF in src:
        src = src.replace(OLD_CRLF, NEW_CRLF, 1)
        with open(FILEPATH, 'w', encoding='utf-8') as f:
            f.write(src)
        print("Patched successfully (CRLF)!")
    else:
        print("ERROR: pattern not found with CRLF either")
