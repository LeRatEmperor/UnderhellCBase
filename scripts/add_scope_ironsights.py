#!/usr/bin/env python3
"""
Port scope ironsight positions from TFA source into kate_ weapons.
Add IronSightsPos_7X/Ang_7X and IronSightsPos_ACOG/Ang_ACOG fields.
Update scope attachments to override IronSightsPos/Ang via WeaponTable.
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"
ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

# Scope ironsight data from TFA source (verbatim)
SCOPE_IRONSIGHTS = {
    'kate_kar98k.lua': {
        '7X': {'pos': 'Vector(-4.6065, -4.5, 0.0785)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-4.15, -7, 0.83)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_arisaka.lua': {
        '7X': {'pos': 'Vector(-2.14, -3.5, 0.2375)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-2.621, -8, -0.151)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_enfield.lua': {
        '7X': {'pos': 'Vector(-4.385, -3, 0.495)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-3.19, -5, 0.91)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_mosin.lua': {
        '7X': {'pos': 'Vector(-4.395, -2.5, 0.35)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-3.274, -2.5, 0.846)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_springfield.lua': {
        '7X': {'pos': 'Vector(-3.896, -3, 0.325)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-2.865, -3, 0.149)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_wz35.lua': {
        '7X': {'pos': 'Vector(-4.395, -4.75, 0.123)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-3.115, -6, 0.741)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_delisle.lua': {
        '7X': {'pos': 'Vector(-4.4, -5, 0.725)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-3.381, -7, 0.503)', 'ang': 'Vector(0, 0, 0)'},
    },
    'kate_sdk.lua': {
        '7X': {'pos': 'Vector(-3.751, -1.5, 0.592)', 'ang': 'Vector(0, 0, 0)'},
        'ACOG': {'pos': 'Vector(-3.752, -4, 0.175)', 'ang': 'Vector(0, 0, 0)'},
    },
}

# Map weapon-specific scope attachments to their suffix
SCOPE_ATT_SUFFIX = {
    'tfa_codww2_kar98k_scope.lua': '7X',
    'tfa_codww2_arisaka_scope.lua': '7X',
    'tfa_codww2_enfield_scope.lua': '7X',
    'tfa_codww2_mosin_scope.lua': '7X',
    'tfa_codww2_springfield_scope.lua': '7X',
    'tfa_codww2_scope.lua': '7X',  # generic 7x scope
    'tfa_codww2_4x.lua': 'ACOG',  # 4x ACOG
}


def add_scope_ironsights_to_weapon(filepath, ironsights):
    """Add IronSightsPos_7X/Ang_7X and IronSightsPos_ACOG/Ang_ACOG to a weapon."""
    with open(filepath) as f:
        content = f.read()

    # Check if already present
    if 'IronSightsPos_7X' in content:
        return False  # already has them

    # Find the IronSightsPos line and add scope variants after it
    # Pattern: SWEP.IronSightsPos = Vector(...)
    match = re.search(r'(SWEP\.IronSightsPos\s*=\s*Vector\([^)]+\))', content)
    if not match:
        return False

    insert_after = match.end()
    pos7x = ironsights['7X']['pos']
    ang7x = ironsights['7X']['ang']
    pos_acog = ironsights['ACOG']['pos']
    ang_acog = ironsights['ACOG']['ang']

    new_fields = f'''
-- Scope-specific ironsight positions (from TFA source)
SWEP.IronSightsPos_7X = {pos7x}
SWEP.IronSightsAng_7X = {ang7x}
SWEP.IronSightsPos_ACOG = {pos_acog}
SWEP.IronSightsAng_ACOG = {ang_acog}'''

    content = content[:insert_after] + new_fields + content[insert_after:]

    with open(filepath, 'w') as f:
        f.write(content)
    return True


def update_scope_attachment(filepath, suffix):
    """Update a scope attachment to override IronSightsPos/Ang via WeaponTable."""
    with open(filepath) as f:
        content = f.read()

    # Add IronSightsPos/Ang override to the WeaponTable
    # Pattern: look for the WeaponTable closing } before Attach function
    # Add the override fields
    
    # Check if already has IronSightsPos override
    if 'IronSightsPos' in content.split('function ATTACHMENT:Attach')[0].split('WeaponTable')[-1]:
        return False  # already has IronSightsPos in WeaponTable

    # Add IronSightsPos/Ang override to WeaponTable
    # Find the WeaponTable block and add before its closing }
    # The WeaponTable ends with a } before the Attach function
    insert = f'''    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_{suffix} or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_{suffix} or val end,
'''

    # Find the last } before "function ATTACHMENT:Attach"
    attach_pos = content.find('function ATTACHMENT:Attach')
    if attach_pos == -1:
        return False

    # Find the } that closes the WeaponTable (the last } before Attach)
    weapon_table_end = content.rfind('}', 0, attach_pos)
    if weapon_table_end == -1:
        return False

    # Insert before the closing }
    content = content[:weapon_table_end] + insert + content[weapon_table_end:]

    with open(filepath, 'w') as f:
        f.write(content)
    return True


def main():
    print("=== Adding scope ironsight positions to kate_ weapons ===\n")
    for filename, ironsights in SCOPE_IRONSIGHTS.items():
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        if add_scope_ironsights_to_weapon(filepath, ironsights):
            print(f"  {filename}: added IronSightsPos_7X/Ang_7X + IronSightsPos_ACOG/Ang_ACOG")
        else:
            print(f"  {filename}: already has scope ironsights")

    print("\n=== Updating scope attachments to use per-weapon ironsights ===\n")
    for filename, suffix in SCOPE_ATT_SUFFIX.items():
        filepath = os.path.join(ATT_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        if update_scope_attachment(filepath, suffix):
            print(f"  {filename}: added IronSightsPos/Ang override (suffix={suffix})")
        else:
            print(f"  {filename}: already has IronSightsPos override or no WeaponTable")


if __name__ == '__main__':
    main()
