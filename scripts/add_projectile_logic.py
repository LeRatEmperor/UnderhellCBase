#!/usr/bin/env python3
"""
Add projectile firing logic to the 5 WWII weapons that need it.

Uses the same pattern as the reference RPG weapon:
  ents.Create() → SetPos → SetAngles → Spawn → SetOwner → ApplyForceCenter

Pattern from weapon_uh_heav_rpg.lua (the working reference):
  local ent = ents.Create("sent_rpg_rocket")
  ent:SetPos(owner:EyePos() + aim * 30 - up * 10 + right_offset)
  ent:SetAngles(owner:EyeAngles())
  ent:Spawn()
  ent:Activate()
  ent:SetOwner(owner)
  phys:ApplyForceCenter(aim * force)

We use ent_kate_projectile (our standalone entity) instead of TFA entities.
"""
import os
import re

WEAPONS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"

# Weapon configs
WEAPON_CONFIGS = {
    'kate_bazooka.lua': {
        'model': 'models/weapons/w_ammo_missile.mdl',
        'force': 5000,
        'isBolt': 'false',
        'damage': 500,
        'radius': 384,
        'explosion_sound': '"TFA_CODWW2_BAZOOKA.Boom"',
        'trail_sound': '"TFA_CODWW2_BAZOOKA.Loop"',
    },
    'kate_crossbow.lua': {
        'model': 'models/crossbow_bolt.mdl',
        'force': 2800,
        'isBolt': 'true',
        'damage': 200,
        'radius': 0,
        'explosion_sound': '""',
        'trail_sound': '""',
    },
    'kate_fliegerfaust.lua': {
        'model': 'models/weapons/w_ammo_missile.mdl',
        'force': 5000,
        'isBolt': 'false',
        'damage': 300,
        'radius': 256,
        'explosion_sound': '"TFA_CODWW2_BAZOOKA.Boom"',
        'trail_sound': '"TFA_CODWW2_BAZOOKA.Loop"',
    },
    'kate_panzer.lua': {
        'model': 'models/weapons/w_ammo_missile.mdl',
        'force': 5000,
        'isBolt': 'false',
        'damage': 500,
        'radius': 384,
        'explosion_sound': '"TFA_CODWW2_PANZER.Boom"',
        'trail_sound': '"TFA_CODWW2_PANZER.Loop"',
    },
    'kate_1911_upgraded.lua': {
        'model': 'models/weapons/w_ammo_missile.mdl',
        'force': 3000,
        'isBolt': 'false',
        'damage': 800,
        'radius': 512,
        'explosion_sound': '"TFA_CODWW2_MUSTANG.Boom"',
        'trail_sound': '""',
    },
}


def get_fire_projectile_override(config):
    """Generate the FireProjectile override for a weapon."""
    return f'''
-- ============================================================
-- PROJECTILE FIRING (reference: weapon_uh_heav_rpg.lua pattern)
-- ============================================================
-- Spawns ent_kate_projectile with weapon-specific config.
-- Pattern matches the RPG reference: ents.Create → SetPos → Spawn → ApplyForceCenter
SWEP.ProjectileModel = "{config['model']}"
SWEP.ProjectileForce = {config['force']}
SWEP.ProjectileIsBolt = {config['isBolt']}
SWEP.ProjectileDamage = {config['damage']}
SWEP.ProjectileRadius = {config['radius']}
SWEP.ProjectileExplosionSound = {config['explosion_sound']}
SWEP.ProjectileTrailSound = {config['trail_sound']}

function SWEP:FireProjectile()
    if not SERVER then return end

    local ent = ents.Create("ent_kate_projectile")
    if not IsValid(ent) then return end

    local owner = self.Owner
    local aim = owner:GetAimVector()
    local pos = owner:EyePos() + aim * 30 - owner:GetUp() * 10 +
        (self:GetUHBool("Zooming") and Vector(0, 0, 0) or owner:GetRight() * 5)

    ent:SetPos(pos)
    ent:SetAngles(owner:EyeAngles())
    ent:Spawn()
    ent:Activate()
    ent:SetOwner(owner)

    -- Configure projectile
    ent.ProjectileModel = self.ProjectileModel
    ent.IsBolt = self.ProjectileIsBolt
    ent.Damage = self.ProjectileDamage
    ent.DamageRadius = self.ProjectileRadius
    ent.ExplodeOnImpact = not self.ProjectileIsBolt
    ent.ExplosionSound = self.ProjectileExplosionSound
    ent.TrailSound = self.ProjectileTrailSound

    -- Apply force (same pattern as RPG reference)
    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceCenter(aim * self.ProjectileForce)
    end

    return ent
end
'''


def get_projectile_primary_attack(config):
    """Generate a PrimaryAttack that fires a projectile instead of bullets."""
    return '''
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    if not self:CanPrimaryAttack() then return end
    local ct = CurTime()

    -- Fire projectile (same pattern as weapon_uh_heav_rpg.lua)
    if SERVER or IsFirstTimePredicted() then
        self:FireProjectile()
    end

    -- Visual feedback
    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
    if SERVER or (CLIENT and IsFirstTimePredicted()) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + 0.32)
    end
    self.Owner:ViewPunch(Angle(recoil, 0, 0))
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    -- Animation
    local shootAnim = self:ShootAnimation()
    if type(shootAnim) == "string" then
        self:EasySendWeaponAnim(shootAnim, ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end

    -- Sound
    local fireSound = self:GetShootSound()
    if fireSound and fireSound ~= "" then
        self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)
    end

    -- Ammo
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)

    -- Timing
    self:SetNextPrimaryFire(ct + self.Primary.Delay)
    self:SetNextSecondaryFire(ct + self.Primary.Delay)
    self.NextReload = ct + 0.5
    self:PostShoot()
end
'''


def get_burst_projectile_fire_round(config):
    """Generate FireBurstRound that fires projectiles instead of bullets."""
    return '''
function SWEP:FireBurstRound()
    if not IsValid(self) or not IsValid(self.Owner) then return end
    if not self:CanPrimaryAttack() then
        self._burstRemaining = nil
        return
    end
    local ct = CurTime()
    local iftp = IsFirstTimePredicted()

    -- Fire projectile instead of bullets
    if SERVER or iftp then
        self:FireProjectile()
    end

    -- Recoil
    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
        * (self:GetUHBool("Zooming") and 0.35 or 1)
    if SERVER or (CLIENT and iftp) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + 0.14)
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))
    end
    self.Owner:ViewPunch(Angle(recoil, 0, 0))

    -- Animation
    local shootAnim = self:ShootAnimation()
    if type(shootAnim) == "string" then
        self:EasySendWeaponAnim(shootAnim, ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:MuzzleFlash()

    local fireSound = self:GetShootSound()
    if fireSound and fireSound ~= "" then
        self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)
    end
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self.NextReload = CurTime() + 0.5

    -- Burst timing
    if SERVER or iftp then
        self._burstRemaining = self._burstRemaining - 1
        if self._burstRemaining > 0 then
            self._burstNextFire = ct + self.BurstDelay
            self:SetNextPrimaryFire(ct + self.BurstDelay)
        else
            self._burstRemaining = nil
            self:SetNextPrimaryFire(ct + self.Primary.Delay * 3)
            self:SetNextSecondaryFire(ct + self.Primary.Delay * 3)
        end
    end
end
'''


def update_weapon(filepath, config, is_burst=False):
    """Add projectile firing logic to a weapon."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # Add FireProjectile function + config fields (before PrimaryAttack)
    if 'function SWEP:FireProjectile' not in content:
        # Find the PrimaryAttack function and insert before it
        insert_point = content.find('function SWEP:PrimaryAttack')
        if insert_point == -1:
            # Append at end
            content = content.rstrip() + '\n' + get_fire_projectile_override(config)
        else:
            content = content[:insert_point] + get_fire_projectile_override(config) + '\n' + content[insert_point:]
        changes.append('added FireProjectile')

    # Replace PrimaryAttack with projectile-firing version
    if is_burst:
        # Replace FireBurstRound
        old_burst = re.search(r'function SWEP:FireBurstRound\(\).*?\nend\n', content, re.DOTALL)
        if old_burst:
            content = content[:old_burst.start()] + get_burst_projectile_fire_round(config).rstrip() + '\n' + content[old_burst.end():]
            changes.append('replaced FireBurstRound with projectile version')
    else:
        # Replace PrimaryAttack
        old_pa = re.search(r'function SWEP:PrimaryAttack\(\).*?\nend\n', content, re.DOTALL)
        if old_pa:
            content = content[:old_pa.start()] + get_projectile_primary_attack(config).rstrip() + '\n' + content[old_pa.end():]
            changes.append('replaced PrimaryAttack with projectile version')

    # Remove TODO comments
    content = re.sub(r'\s*-- TODO: When projectile.*\n', '\n', content)
    content = re.sub(r'\s*-- NOTE: Projectile system.*\n', '\n', content)
    content = re.sub(r'\s*-- NOTE: TFA source fires.*\n', '\n', content)
    content = re.sub(r'\s*-- NOTE: This port.*\n', '\n', content)
    content = re.sub(r'\s*-- NOTE: burst-fire scaffolding.*\n', '\n', content)

    # Clean up extra blank lines
    content = re.sub(r'\n\n\n+', '\n\n', content)

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print("=== Adding projectile firing to WWII weapons ===\n")

    for filename, config in WEAPON_CONFIGS.items():
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue

        is_burst = (filename == 'kate_fliegerfaust.lua')
        changes = update_weapon(filepath, config, is_burst)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
