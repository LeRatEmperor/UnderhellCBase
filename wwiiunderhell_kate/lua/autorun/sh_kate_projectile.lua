-- Projectile firing helper for Kate WWII weapons
-- Call from weapon: self:FireProjectile(projectileModel, force, isBolt, damage, radius)
-- Spawns an ent_kate_projectile entity and applies force

function SWEP:FireProjectile(projectileModel, force, isBolt, damage, radius)
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
    ent.ProjectileModel = projectileModel
    ent.IsBolt = isBolt or false
    ent.Damage = damage or 500
    ent.DamageRadius = radius or 256
    ent.ExplodeOnImpact = not isBolt
    ent.ExplosionSound = self.ProjectileExplosionSound or "TFA_CODWW2_BAZOOKA.Boom"
    ent.TrailSound = self.ProjectileTrailSound or ""

    -- Apply velocity
    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceCenter(aim * (force or 5000))
    end

    return ent
end
