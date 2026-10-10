AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Kate Projectile"
ENT.Author = ""
ENT.Category = "Kate WWII"
ENT.Spawnable = false
ENT.AdminSpawnable = false

-- Server-side constants
ENT.ExplodeOnImpact = true
ENT.Damage = 500
ENT.DamageRadius = 256
ENT.ExplosionEffect = "tfa_codww2_explosion"
ENT.ExplosionSound = "TFA_CODWW2_BAZOOKA.Boom"
ENT.TracerEffect = "tfa_codww2_rocket_trail"
ENT.IsBolt = false

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Owner")
end

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.ProjectileModel or "models/weapons/w_missile_launch.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
            phys:EnableGravity(self.IsBolt or false)
            phys:EnableDrag(false)
        end

        self.Trail = util.SpriteTrail(
            self, 0,
            self.TrailColor or Color(255, 200, 100),
            false,
            self.TrailWidth or 8,
            0,
            self.TrailLife or 0.5,
            1 / (self.TrailWidth or 8) * 0.5,
            self.TrailTexture or "trails/smoke"
        )

        -- Lifetime safety: remove after 10 seconds if no impact
        timer.Simple(10, function()
            if IsValid(self) then
                if self.ExplodeOnImpact then
                    self:DoExplosion()
                end
                self:Remove()
            end
        end)
    end
end

function ENT:DoExplosion()
    if not SERVER then return end
    if self.Exploded then return end
    self.Exploded = true

    local pos = self:GetPos()

    -- Explosion damage
    local dmg = DamageInfo()
    dmg:SetDamage(self.Damage)
    dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
    dmg:SetInflictor(self)
    dmg:SetDamageType(DMG_BLAST)
    dmg:SetDamagePosition(pos)
    dmg:SetReportedPosition(pos)

    util.BlastDamageInfo(dmg, pos, self.DamageRadius)

    -- Explosion effect
    local fx = EffectData()
    fx:SetOrigin(pos)
    fx:SetNormal(self:GetForward())
    fx:SetScale(1)
    util.Effect("tfa_codww2_explosion", fx, true, true)

    -- Sound
    self:EmitSound(self.ExplosionSound, 100, 100, 1, CHAN_AUTO)

    -- Screen shake
    util.ScreenShake(pos, 10, 0.5, 0.5, 512)

    SafeRemoveEntity(self)
end

function ENT:PhysicsCollide(data, physobj)
    if not SERVER then return end
    if self.Exploded then return end

    if self.ExplodeOnImpact then
        self:DoExplosion()
    else
        -- Bolt: stick into the surface
        local ent = data.HitEntity
        if IsValid(ent) then
            -- Apply damage to hit entity
            local dmg = DamageInfo()
            dmg:SetDamage(self.Damage)
            dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
            dmg:SetInflictor(self)
            dmg:SetDamageType(DMG_BULLET)
            dmg:SetDamagePosition(data.HitPos)
            dmg:SetDamageForce(self:GetForward() * 5000)
            ent:TakeDamageInfo(dmg)
        end

        -- Impact effect
        local fx = EffectData()
        fx:SetOrigin(data.HitPos)
        fx:SetNormal(data.HitNormal)
        util.Effect("cball_explode", fx, true, true)

        self:Remove()
    end
end

function ENT:Think()
    if SERVER and not self.IsBolt then
        -- Rocket: emit trail sound
        if self.TrailSound and not self.TrailSoundPlayed then
            self:EmitSound(self.TrailSound, 80, 100, 0.5, CHAN_AUTO)
            self.TrailSoundPlayed = true
        end
    end
end
