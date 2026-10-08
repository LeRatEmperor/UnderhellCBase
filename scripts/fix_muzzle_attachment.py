#!/usr/bin/env python3
"""
Fix muzzle flash and shell eject attachment lookup.

The TFA WWII models define attachments by NAME ("0", "1", "2"), NOT by
bone name ("tag_brass", "tag_silencer", "tag_flash"). The current
GetMuzzle/GetShellEject use LookupAttachment("tag_flash") which returns 0
(not found) for most WWII models.

TFA uses:
  MuzzleAttachment = "1"  → attachment named "1" → on bone tag_silencer
  ShellAttachment  = "0"  → attachment named "0" → on bone tag_brass

Fix: change GetMuzzle to return LookupAttachment("1") and
GetShellEject to return LookupAttachment("0").
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

ALL_FILES = [
    'kate_1911.lua', 'kate_mp40.lua', 'kate_stg44.lua',
    'kate_pg1935.lua', 'kate_kar98k.lua', 'kate_model1897.lua',
    'kate_m1879.lua',
    'template_semi.lua', 'template_auto.lua', 'template_selective.lua',
    'template_burst.lua', 'template_bolt.lua', 'template_shotgun.lua',
    'template_revolver_sg.lua',
]

NEW_GET_MUZZLE = '''function SWEP:GetMuzzle()
    -- TFA WWII models use attachment name "1" (on bone tag_silencer)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("1")
        if att > 0 then return att end
        -- Fallback: try attachment name "2" (on bone tag_flash, some models)
        att = vm:LookupAttachment("2")
        if att > 0 then return att end
    end
    return 1
end'''

NEW_GET_SHELL = '''function SWEP:GetShellEject()
    -- TFA WWII models use attachment name "0" (on bone tag_brass)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("0")
        if att > 0 then return att end
    end
    return 2
end'''


def fix_file(filepath):
    with open(filepath) as f:
        content = f.read()

    # Replace GetMuzzle
    old_muzzle = re.compile(
        r'function SWEP:GetMuzzle\(\).*?\nend\n',
        re.DOTALL
    )
    content = old_muzzle.sub(NEW_GET_MUZZLE + '\n', content, count=1)

    # Replace GetShellEject
    old_shell = re.compile(
        r'function SWEP:GetShellEject\(\).*?\nend\n',
        re.DOTALL
    )
    content = old_shell.sub(NEW_GET_SHELL + '\n', content, count=1)

    with open(filepath, 'w') as f:
        f.write(content)


def main():
    print("=== Fixing GetMuzzle/GetShellEject on all weapons + templates ===\n")
    for filename in ALL_FILES:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        fix_file(filepath)
        print(f"  {filename}: fixed")


if __name__ == '__main__':
    main()
