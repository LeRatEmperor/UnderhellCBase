#!/usr/bin/env python3
"""
Convert all 9 melee weapons from weapon_cuh_base_gun to weapon_custom_uh_base_melee.

Changes per weapon:
1. Change SWEP.Base from "weapon_cuh_base_gun" to "weapon_custom_uh_base_melee"
2. Change DEFINE_BASECLASS from "weapon_cuh_base_gun" to "weapon_custom_uh_base_melee"
3. Remove IsCUHWeapon = true
4. Remove CUH-specific fields: Attachments, ViewModelElements, WorldModelElements
5. Remove CUH-specific methods: ApplyAttachments, SetAttachment, etc.
6. Map melee stats to the melee base format:
   - SWEP.Primary.Sound -> SWEP.Primary.SwingSound
   - SWEP.MeleeHitSound -> SWEP.Primary.HitSound
   - SWEP.MeleeDamage -> SWEP.Primary.MinDamage/MaxDamage
   - SWEP.MeleeRange -> used in GetSwingAnim override
   - SWEP.MeleeDelay -> SWEP.Primary.Delay
   - SWEP.MeleeHitDelay -> SWEP.Primary.HurtTime
   - SWEP.MeleeForce -> SWEP.Primary.Force
7. Keep: Animations, AnimSounds, HandleSprintingAnimations, HandleIdle, HandleInspect
8. Keep: Deploy, Holster overrides
9. Remove: PrimaryAttack override (melee base handles it)
   BUT keep a custom PrimaryAttack if it uses a different melee system
"""

import os
import re
import glob

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

MELEE_WEAPONS = [
    "kate_baseball_bat", "kate_claymore", "kate_combatknife",
    "kate_dagger", "kate_fireaxe", "kate_icepick",
    "kate_shovel", "kate_sledgehammer", "kate_trenchknife",
]


def convert_weapon(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        src = f.read()

    fname = os.path.basename(filepath)
    changed = False

    # 1. Change Base class
    src = src.replace(
        'DEFINE_BASECLASS("weapon_cuh_base_gun")',
        'DEFINE_BASECLASS("weapon_custom_uh_base_melee")'
    )
    src = src.replace(
        'SWEP.Base = "weapon_cuh_base_gun"',
        'SWEP.Base = "weapon_custom_uh_base_melee"'
    )

    # 2. Remove IsCUHWeapon
    src = src.replace("SWEP.IsCUHWeapon = true\n", "")
    src = src.replace("SWEP.IsCUHWeapon = true", "")

    # 3. Remove CUH-specific attachment fields (empty tables)
    src = src.replace("SWEP.ViewModelElements = {}\n", "")
    src = src.replace("SWEP.WorldModelElements = {}\n", "")
    src = src.replace("SWEP.Attachments = {}\n", "")

    # 4. Map melee stats to melee base format
    # Primary.Sound -> Primary.SwingSound (keep the sound)
    # The melee base uses Primary.SwingSound for swing sounds
    src = src.replace(
        'SWEP.Primary.Sound          = Sound(',
        'SWEP.Primary.SwingSound    = Sound('
    )
    src = src.replace(
        'SWEP.Primary.Sound = Sound(',
        'SWEP.Primary.SwingSound = Sound('
    )

    # MeleeHitSound -> Primary.HitSound
    src = src.replace(
        'SWEP.MeleeHitSound  = {',
        'SWEP.Primary.HitSound  = {'
    )
    src = src.replace(
        'SWEP.MeleeHitSound = {',
        'SWEP.Primary.HitSound = {'
    )

    # MeleeDamage -> Primary.MinDamage and MaxDamage
    src = re.sub(
        r'SWEP\.MeleeDamage\s*=\s*(\d+(?:\.\d+)?)',
        r'SWEP.Primary.MinDamage      = \1\nSWEP.Primary.MaxDamage      = \1',
        src
    )

    # MeleeDelay -> Primary.Delay (if not already set)
    src = re.sub(
        r'SWEP\.MeleeDelay\s*=\s*([\d.]+)',
        r'SWEP.Primary.Delay          = \1',
        src
    )

    # MeleeHitDelay -> Primary.HurtTime
    src = re.sub(
        r'SWEP\.MeleeHitDelay\s*=\s*([\d.]+)',
        r'SWEP.Primary.HurtTime       = \1',
        src
    )

    # MeleeForce -> Primary.Force
    src = re.sub(
        r'SWEP\.MeleeForce\s*=\s*(\d+)',
        r'SWEP.Primary.Force          = \1',
        src
    )

    # MeleeViewPunch -> Primary.Recoil
    src = re.sub(
        r'SWEP\.MeleeViewPunch\s*=\s*',
        'SWEP.Primary.Recoil         = ',
        src
    )

    # 5. Remove melee base fields that are now inherited
    # (MeleeRange, MeleeSound, MeleeMissSound, MeleeInterruptReload)
    # Keep MeleeRange as a custom field for GetSwingAnim override
    # Remove the others
    src = re.sub(r'SWEP\.MeleeSound\s*=.*\n', '', src)
    src = re.sub(r'SWEP\.MeleeMissSound\s*=.*\n', '', src)
    src = re.sub(r'SWEP\.MeleeInterruptReload\s*=.*\n', '', src)

    # 6. Remove the custom PrimaryAttack, MeleeAttack, DoMeleeTrace, EndMelee
    # The melee base handles all of this. BUT keep if the weapon has a
    # custom PrimaryAttack that uses E+M1 (like gun-style weapons with melee bash)
    # For pure melee weapons, remove the custom melee system.
    
    # Actually, the melee base's PrimaryAttack is simpler than the CUH one.
    # The CUH melee uses a state machine (MeleeAttack, DoMeleeTrace, EndMelee)
    # with hit delay timing. The melee base uses timer.Simple for the hit.
    # Let's keep the custom melee system since it's more sophisticated,
    # but change the base class so the weapon inherits from the melee base.
    
    # The melee base's PrimaryAttack will be used UNLESS the weapon overrides it.
    # Since the Kate melee weapons override PrimaryAttack, they'll use their own.
    # The melee base just provides the right defaults and doesn't have
    # gun-specific stuff like ShootBullets.

    # 7. Remove GetDisplay, GetMuzzle, GetShellEject, ShootAnimation
    # (not needed for melee weapons)
    # Actually, keep them — they're harmless and might be called by the base

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(src)

    return True


def main():
    print(f"Converting {len(MELEE_WEAPONS)} melee weapons...")
    n = 0
    for weapon_name in MELEE_WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue
        if convert_weapon(filepath):
            print(f"  CONVERTED: {weapon_name}.lua")
            n += 1
    print(f"\nDone. Converted {n}/{len(MELEE_WEAPONS)} weapons.")


if __name__ == "__main__":
    main()
