-- ============================================================
-- Fliegerfaust — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_fliegerfaust (TFA WWII Kate)
-- Template: template_burst (3-Round Burst Launcher)
-- ============================================================
-- only includes burst-fire scaffolding. When projectile support is
-- added, override FireBurstRound() to spawn rocket entities.
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Fliegerfaust"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Launchers"

SWEP.Slot = 4
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(1, -1, -0.5)
SWEP.LoweredAng = Vector(-20, 35, -25)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "passive"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- ============================================================
-- BURST FIRE CONFIG (per spec)
-- ============================================================
SWEP.BurstCount = 3        -- rounds per burst
SWEP.BurstDelay = 0.075    -- seconds between each burst round

SWEP.FireModes = {
    {
        name = "Burst",
        shoot = function(ply, wep)
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end
            wep._burstRemaining = wep.BurstCount
            wep:FireBurstRound()
            return true
        end
    },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_BZKA.Body")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 9
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.DefaultClip    = 99
SWEP.Primary.MinDamage      = 2000.0
SWEP.Primary.MaxDamage      = 2000.0
SWEP.Primary.Automatic      = true   -- burst continues even if M1 held
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.15
SWEP.Primary.Delay          = 0.375       -- 60 / RPM(160)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.3          -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.3          -- = -KickDown
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.3
SWEP.Primary.KickHorizontal = 0.3
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-2.5, 0, -4.5)
SWEP.IronSightsAng = Vector(17, -2.5, -10)
SWEP.IronSightTime = 0.45
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint (procedural position, not animation)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- TFA-style curved ironsight dip — DISABLED for WWII (position-based ADS only)
SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system (BO3-style)
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

-- Muzzle
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (from TFA Secondary.Bash*)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 60          -- BashLength
SWEP.MeleeDelay     = 0.2         -- BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingLrg"     -- BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}         -- BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (TFA source has LuaShellEject = false)
SWEP.NoShell   = true
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_762.mdl"   -- LuaShellModel

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(13.0, 1.0, -6.0)   -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)   -- (Right→Pitch, Up→Yaw, Forward→Roll)

-- ============================================================
-- ANIMATIONS (template defaults)
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_last",
    ["fire_ads"]     = "fire_ads",
    ["iron_fire"]    = "fire_ads",
    ["idle"]         = "idle",
    ["idle_empty"]   = "idle_empty",
    ["deploy"]       = "draw",
    ["holster"]      = "holster",
    ["draw_first"]   = "draw_first",
    ["melee"]        = "melee",
    ["melee_empty"]  = "melee_empty",
    ["inspect"]      = "inspect",
    ["inspect_empty"] = "inspect_empty",
    ["reload"]       = "ACT_VM_RELOAD",
    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LNCHR.Raise" },
    },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LNCHR.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LNCHR.Holster" },
    },
    ["reload"] = {
        { time = 0.0333, sound = "TFA_CODWW2_PANZER.Rattle" },
        { time = 0.6667, sound = "TFA_CODWW2_PANZER.RocketIn" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_PANZER.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_PANZER.Inspect2" },
    },
}

-- ============================================================
-- BURST FIRE LOGIC
-- ============================================================

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

-- ============================================================
-- SMART MUZZLE / SHELL AUTO-DETECT
-- ============================================================
function SWEP:GetDisplay()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("1")
        if att > 0 then return att end
    end
    return 1
end

function SWEP:GetMuzzle()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("1")
        if att > 0 then return att end
        att = vm:LookupAttachment("2")
        if att > 0 then return att end
    end
    return 1
end

function SWEP:GetShellEject()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("0")
        if att > 0 then return att end
    end
    return 2
end

function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

-- ============================================================
-- SPRINT / IDLE / INSPECT HANDLERS
-- ============================================================
function SWEP:HandleSprintingAnimations()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local isRunning = self:GetUHBool("Running")
    if self.wasRunning == nil then self.wasRunning = false end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end
    if isRunning and not self.wasRunning then
        if not self:GetUHBool("Reloading") then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)
        end
    elseif not isRunning and self.wasRunning then
        if not self:GetUHBool("Reloading") then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)
        end
    elseif isRunning and not self:GetUHBool("Reloading") then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end
    self.wasRunning = isRunning
end

function SWEP:HandleIdle()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if self._meleeActive then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self:GetUHBool("Zooming") then return end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end
    if vm:GetCycle() < 1 then return end
    self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
end

function SWEP:HandleInspect()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then
        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then
            if not self:GetNW2Bool("Inspecting") then
                self:SetNW2Bool("Inspecting", true)
                self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
            end
        end
    elseif self:GetNW2Bool("Inspecting") then
        self:SetNW2Bool("Inspecting", false)
    end
end

-- ============================================================
-- ATTACK
-- ============================================================

-- ============================================================
-- PROJECTILE FIRING (reference: weapon_uh_heav_rpg.lua pattern)
-- ============================================================
-- Spawns ent_kate_projectile with weapon-specific config.
-- Pattern matches the RPG reference: ents.Create → SetPos → Spawn → ApplyForceCenter
SWEP.ProjectileModel = "models/weapons/w_ammo_missile.mdl"
SWEP.ProjectileForce = 5000
SWEP.ProjectileIsBolt = false
SWEP.ProjectileDamage = 300
SWEP.ProjectileRadius = 256
SWEP.ProjectileExplosionSound = "TFA_CODWW2_BAZOOKA.Boom"
SWEP.ProjectileTrailSound = "TFA_CODWW2_BAZOOKA.Loop"

function SWEP:FireProjectile()
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
end

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
    BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end

-- ============================================================
-- THINK — includes burst continuation
-- ============================================================
function SWEP:Think()
    local ct = CurTime()

    -- Continue burst rounds even if player released M1
    if self._burstRemaining and self._burstRemaining > 0 then
        if ct >= (self._burstNextFire or 0) then
            self:FireBurstRound()
        end
    end

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end
    BaseClass.Think(self)
    if not IsValid(self.Owner) then return end
    self:HandleSprintingAnimations()
    self:HandleIdle()
    self:HandleInspect()
end

-- ============================================================
-- HOLSTER / DEPLOY — cancel burst on switch
-- ============================================================
function SWEP:Holster(wep)
    self._burstRemaining = nil
    self._burstNextFire = nil
    self._justExitedSprint = false
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(self, wep)
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    self:SetHoldType(self.HoldType)
    if self.Animations and self.Animations["deploy"] then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW_DEPLOYED)
            local dur = vm:SequenceDuration()
            self:SetNextPrimaryFire(CurTime() + dur)
            self:SetNextSecondaryFire(CurTime() + dur)
            self.NextReload = CurTime() + dur
            self._nextIdlePlay = nil
            self._deployEndTime = CurTime() + dur
            self:SetNWFloat("DeployTime", 0)
        end
    end
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil
    self._burstRemaining = nil
    self._burstNextFire = nil
    self._justExitedSprint = false
    return true
end

-- ============================================================
-- VELEMENTS / WELEMENTS (ported 1:1 from TFA VElements/WElements)
-- Renames: angle→ang, size→scale, bodygroup→bodygroups
-- ============================================================
SWEP.ViewModelElements = {
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_mag.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["rocket_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/c_fliegerfaust_rocket.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_mag.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["rocket_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/fliegerfaust/w_fliegerfaust_rocket.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments — empty in source)
-- ============================================================
SWEP.Attachments = {}
