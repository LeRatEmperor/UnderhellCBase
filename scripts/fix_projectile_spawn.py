#!/usr/bin/env python3
"""
Fix: move projectile config BEFORE ent:Spawn() in all 5 WWII weapons.

Root cause: FireProjectile() sets ent.ProjectileModel, ent.Damage, etc.
AFTER calling ent:Spawn(). But Initialize() runs during Spawn() and reads
those fields. Since they're nil at that point, the entity initializes
with wrong defaults (wrong model → wrong physics hull → PhysicsCollide
never fires → no explosion).

Fix: set all config fields BEFORE Spawn(), then call Spawn().
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

WEAPONS = [
    'kate_bazooka.lua',
    'kate_crossbow.lua',
    'kate_fliegerfaust.lua',
    'kate_panzer.lua',
    'kate_1911_upgraded.lua',
]

NEW_FIRE_PROJECTILE = '''function SWEP:FireProjectile()
    if not SERVER then return end

    local ent = ents.Create("ent_kate_projectile")
    if not IsValid(ent) then return end

    local owner = self.Owner
    local aim = owner:GetAimVector()
    local pos = owner:EyePos() + aim * 30 - owner:GetUp() * 10 +
        (self:GetUHBool("Zooming") and Vector(0, 0, 0) or owner:GetRight() * 5)

    -- Set position and angles BEFORE Spawn
    ent:SetPos(pos)
    ent:SetAngles(owner:EyeAngles())

    -- CRITICAL: set ALL config fields BEFORE Spawn() so Initialize()
    -- can read them. If set after Spawn, the physics hull is initialized
    -- with the wrong model and PhysicsCollide never fires.
    ent.ProjectileModel = self.ProjectileModel
    ent.IsBolt = self.ProjectileIsBolt
    ent.Damage = self.ProjectileDamage
    ent.DamageRadius = self.ProjectileRadius
    ent.ExplodeOnImpact = not self.ProjectileIsBolt
    ent.ExplosionSound = self.ProjectileExplosionSound
    ent.TrailSound = self.ProjectileTrailSound

    -- NOW spawn — Initialize() will read the correct fields
    ent:Spawn()
    ent:Activate()
    ent:SetOwner(owner)

    -- Apply force (same pattern as RPG reference)
    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceCenter(aim * self.ProjectileForce)
    end

    return ent
end'''


def fix_weapon(filepath):
    with open(filepath) as f:
        content = f.read()

    # Find and replace the FireProjectile function
    pattern = re.compile(
        r'function SWEP:FireProjectile\(\).*?\nend\n',
        re.DOTALL
    )
    match = pattern.search(content)
    if not match:
        return False

    content = content[:match.start()] + NEW_FIRE_PROJECTILE + '\n' + content[match.end():]

    with open(filepath, 'w') as f:
        f.write(content)
    return True


def main():
    print("=== Fixing FireProjectile: move config before Spawn() ===\n")
    for filename in WEAPONS:
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        if fix_weapon(filepath):
            print(f"  {filename}: fixed")
        else:
            print(f"  {filename}: no FireProjectile found")


if __name__ == '__main__':
    main()
