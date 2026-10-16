#!/usr/bin/env python3
"""Add SWEP.Primary.HitWorldSound to all 9 melee weapons."""

import os

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Map weapon -> (sound_prefix, sound_name)
# The "Stab"/"Hit" sound IS the world hit sound in TFA WWII
MELEE_SOUNDS = {
    "kate_baseball_bat": "TFA_CODWW2_BAT.Stab",
    "kate_claymore": "TFA_CODWW2_SWORD.Stab",
    "kate_combatknife": "TFA_CODWW2_KNIFE.Stab",
    "kate_dagger": "TFA_CODWW2_KNIFE.Stab",
    "kate_fireaxe": "TFA_CODWW2_AXE.Stab",
    "kate_icepick": "TFA_CODWW2_KNIFE.Stab",
    "kate_shovel": "TFA_CODWW2_KNIFE.Stab",
    "kate_sledgehammer": "TFA_CODWW2_HAMMER.Hit",
    "kate_trenchknife": "TFA_CODWW2_KNIFE.Stab",
}


def main():
    print(f"Adding HitWorldSound to {len(MELEE_SOUNDS)} melee weapons...")
    n = 0
    for weapon_name, sound_name in MELEE_SOUNDS.items():
        filepath = os.path.join(WEAPONS_DIR, weapon_name + ".lua")
        if not os.path.exists(filepath):
            print(f"  MISSING: {weapon_name}.lua")
            continue

        with open(filepath, 'r', encoding='utf-8') as f:
            src = f.read()

        if "HitWorldSound" in src:
            print(f"  SKIP (already has HitWorldSound): {weapon_name}")
            continue

        # Add after the HitSound line
        import re
        pattern = r'(SWEP\.Primary\.HitSound\s*=\s*\{[^}]*\})'
        match = re.search(pattern, src)
        if match:
            insert_pos = match.end()
            new_line = f'\nSWEP.Primary.HitWorldSound  = Sound("{sound_name}")'
            src = src[:insert_pos] + new_line + src[insert_pos:]
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(src)
            print(f"  ADDED: {weapon_name} -> {sound_name}")
            n += 1
        else:
            print(f"  ERROR: HitSound not found in {weapon_name}")

    print(f"\nDone. Added HitWorldSound to {n} weapons.")


if __name__ == "__main__":
    main()
