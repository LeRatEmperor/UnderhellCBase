#!/usr/bin/env python3
"""
Remove ALL shotgun reload code from the 5 weapons that don't need it.
This includes:
- The original "SHOTGUN RELOAD — shell-by-shell insertion" block (timer-based)
- The appended "SHOTGUN SHELL-BY-SHELL RELOAD" block (ReloadShotgun function)
- The CustomThink dispatcher
- SWEP.Shotgun = true
- SWEP.IsPump = true / SWEP.PumpDelay
- The pump PostShoot (keep the base PostShoot which is empty)
- start_reload/reload_loop/after_reload animation keys
- The "Override PrimaryAttack for pump after fire" block
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

SHOTGUN_RELOAD_REMOVE = {
    'uh_codww2_m30.lua',
    'uh_codww2_model21.lua',
    'uh_codww2_walther.lua',
    'uh_codww2_blunderbuss.lua',
    'uh_codww2_winchester94.lua',
}


def remove_shotgun_code(filepath):
    """Remove ALL shotgun-related code blocks from the file."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # 1. Remove the "SHOTGUN RELOAD — shell-by-shell insertion" block
    # This block starts with "-- ====...\n-- SHOTGUN RELOAD" and ends before the next "-- ====..." header
    # or before "function SWEP:Holster" or similar
    pattern1 = re.compile(
        r'-- =+\n-- SHOTGUN RELOAD — shell-by-shell insertion\n-- =+\n.*?(?=\n-- =+\n-- (HOLSTER|DEPLOY|VELEMENTS|ATTACHMENTS|PUMP|IRONSIGHTS|RECHAMBER|MUZZLE|BURST|ATTACK|SMART)|\nfunction SWEP:Holster|\nSWEP\.ViewModelElements|\nSWEP\.WorldModelElements|\nSWEP\.Attachments|\Z)',
        re.DOTALL
    )
    new_content = pattern1.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed SHOTGUN RELOAD block')

    # 2. Remove the "SHOTGUN SHELL-BY-SHELL RELOAD" block (appended by previous script)
    pattern2 = re.compile(
        r'-- =+\n-- SHOTGUN SHELL-BY-SHELL RELOAD\n-- =+\n.*?(?=\n-- =+\n|\nfunction SWEP:Holster|\nSWEP\.\w+ = |\Z)',
        re.DOTALL
    )
    new_content = pattern2.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed SHELL-BY-SHELL RELOAD block')

    # 3. Remove the "PUMP-ACTION RECHAMBER" block (appended PostShoot)
    pattern3 = re.compile(
        r'-- =+\n-- PUMP-ACTION RECHAMBER \(after every shot\)\n-- =+\n.*?(?=\n-- =+\n|\nfunction SWEP:|\nSWEP\.\w+ = |\Z)',
        re.DOTALL
    )
    new_content = pattern3.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed PUMP-ACTION RECHAMBER block')

    # 4. Remove the "BOLT-ACTION RECHAMBER" block (for snipers that also got shotgun code)
    pattern4 = re.compile(
        r'-- =+\n-- BOLT-ACTION RECHAMBER.*?\n-- =+\n.*?(?=\n-- =+\n|\nfunction SWEP:|\nSWEP\.\w+ = |\Z)',
        re.DOTALL
    )
    new_content = pattern4.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed BOLT-ACTION RECHAMBER block')

    # 5. Remove the "Override PrimaryAttack for pump after fire" block
    # This is a PrimaryAttack that calls self:PostShoot() after BaseClass.PrimaryAttack
    pattern5 = re.compile(
        r'-- Override PrimaryAttack for pump after fire\nfunction SWEP:PrimaryAttack\(\).*?self:PostShoot\(\)\nend\n',
        re.DOTALL
    )
    new_content = pattern5.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed pump PrimaryAttack override')

    # 6. Remove standalone ReloadShotgun function (if it survived the block removal)
    pattern6 = re.compile(
        r'\n*function SWEP:ReloadShotgun\(ct\).*?\nend\n',
        re.DOTALL
    )
    new_content = pattern6.sub('\n', content)
    if new_content != content:
        content = new_content
        changes.append('removed standalone ReloadShotgun')

    # 7. Remove standalone shotgun Reload override
    # This is a Reload() that has shotgun-specific logic (reloaddelay, ShellLoadTime, etc.)
    pattern7 = re.compile(
        r'function SWEP:Reload\(\)\s*\n.*?self\.ShellLoadTime.*?end\n',
        re.DOTALL
    )
    new_content = pattern7.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun Reload override')

    # 8. Remove CustomThink that dispatches ReloadShotgun
    pattern8 = re.compile(
        r'-- CustomThink: dispatches ReloadShotgun.*?\nSWEP\.CustomThink = function\(self, ct\)\n    if self\.Shotgun and self\.ReloadShotgun and self:GetUHBool\("Reloading"\) then\n        self:ReloadShotgun\(ct\)\n    end\nend\n',
        re.DOTALL
    )
    new_content = pattern8.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun CustomThink')

    # 9. Remove standalone SWEP.Shotgun = true, SWEP.IsPump = true, SWEP.PumpDelay, SWEP.ShellLoadTime, SWEP.Primary.ReloadTime
    for line_pattern in [
        r'^SWEP\.Shotgun = true\n',
        r'^SWEP\.IsPump = true\n',
        r'^SWEP\.PumpDelay = [\d\.]+\n',
        r'^SWEP\.ShellLoadTime = SWEP\.ShellLoadTime or [\d\.]+\n',
        r'^SWEP\.Primary\.ReloadTime = [\d\.]+\n',
    ]:
        new_content = re.sub(line_pattern, '', content, flags=re.MULTILINE)
        if new_content != content:
            content = new_content

    # 10. Remove start_reload/reload_loop/after_reload animation keys
    pattern10 = re.compile(
        r'    \["start_reload"\]\s*=\s*"reload_start",\n    \["reload_loop"\]\s*=\s*"reload_loop",\n    \["after_reload"\]\s*=\s*"reload_end",\n'
    )
    new_content = pattern10.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed shotgun anim keys')

    # 11. Also remove any "Override PostShoot for pump action" block
    pattern11 = re.compile(
        r'-- Override PostShoot for pump action\nfunction SWEP:PostShoot\(\).*?\nend\n',
        re.DOTALL
    )
    new_content = pattern11.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed pump PostShoot override')

    # 12. Clean up any orphaned "function SWEP:PostShoot()" that might remain
    pattern12 = re.compile(
        r'\n*function SWEP:PostShoot\(\)\s*\n.*?\nend\n',
        re.DOTALL
    )
    new_content = pattern12.sub('\n', content)
    if new_content != content:
        content = new_content
        changes.append('removed orphaned PostShoot')

    # Write back if any changes
    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Removing ALL shotgun reload code from 5 weapons ===\n")
    for filename in SHOTGUN_RELOAD_REMOVE:
        filepath = os.path.join(WWII_WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = remove_shotgun_code(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
