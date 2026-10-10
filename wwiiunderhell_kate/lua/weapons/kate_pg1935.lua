-- ============================================================
-- ITRA Burst (pg1935) — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_pg1935 (TFA WWII Kate)
-- Template: template_burst (Burst-Only — Type 4)
-- ============================================================
-- 4-round burst rifle. Cannot toggle to semi or full-auto.
-- Standard magazine reload. Implements the M8A7 burst-fire pattern:
--   1. FireModes[1].shoot callback initializes _burstRemaining
--   2. FireBurstRound() fires one round, decrements counter
--   3. CustomThink continues the burst even if player released M1
--   4. Holster cancels the in-flight burst
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "ITRA Burst"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Rifles"

SWEP.Slot = 2
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/pg1935/c_pg1935.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/pg1935/w_pg1935.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(-1, -2, -0.5)
SWEP.LoweredAng = Vector(-15, 25, -20)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- ============================================================
-- BURST FIRE CONFIG
-- ============================================================
SWEP.BurstCount = 4        -- rounds per burst
SWEP.BurstDelay = 0.075    -- seconds between each burst round (from TFA BurstDelay)

SWEP.FireModes = {
    {
        name = "Burst",
        shoot = function(ply, wep)
            -- Don't start a new burst if one is in flight
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end
            wep._burstRemaining = wep.BurstCount
            wep:FireBurstRound()
            return true  -- tell base to skip its own bullet fire
        end
    },
    -- Note: only 1 fire mode (burst-only). Add more if weapon supports toggle.
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_PLAYER.Lfe.Rifle")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 32
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 352
SWEP.Primary.MinDamage      = 151.0
SWEP.Primary.MaxDamage      = 151.0
SWEP.Primary.Automatic      = true   -- burst continues even if M1 held
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.015
SWEP.Primary.Delay          = 0.063025       -- 60 / RPM_Burst(952)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.4          -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.25          -- = -KickDown
SWEP.Primary.KickUp         = 0.4
SWEP.Primary.KickDown       = 0.25
SWEP.Primary.KickHorizontal = 0.2
SWEP.Primary.SpreadMultiplierMax = 6.0
SWEP.Primary.SpreadIncrement    = 1.0
SWEP.Primary.SpreadRecovery     = 6.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true          

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-3.4, -3.5, 1.3)
SWEP.IronSightsAng = Vector(0, 0, 0)
-- 4x ACOG ironsight position (computed default: IronSightsPos + delta)
SWEP.IronSightsPos_ACOG = Vector(-2.6, -3.5, 0.6)
SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)
-- Lens sight ironsight position (computed default: IronSightsPos + delta)
SWEP.IronSightsPos_Lens = Vector(-2.9, -3.5, 0.9)
SWEP.IronSightsAng_Lens = Vector(0, 0, 0)
SWEP.IronSightTime = 0.35
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
SWEP.MuzzleAttachment = "2"  -- tag_flash (auto-detected by GetMuzzle)
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (from TFA Secondary.Bash*)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 45          -- BashLength
SWEP.MeleeDelay     = 0.2         -- BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingRfl"     -- BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}         -- BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (from TFA LuaShell*)
SWEP.NoShell   = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_556.mdl"   -- LuaShellModel

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(13.9, 1.0, -6.2)    -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)    -- (Right→Pitch, Up→Yaw, Forward→Roll)

-- ============================================================
-- ANIMATIONS (template defaults + TFA source custom animations)
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
    -- Custom (from TFA SWEP.Animations table)
    ["melee_bayonet"]    = "melee_bayonet",
    ["reload_ext_empty"] = "reload_ext_empty",
    ["reload_grenade"]   = "reload_grenade" }

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ACT_VM_* keys mapped to string keys per spec.
-- NOTE: lua-type events (AttachGrenade / DetachGrenade calls) are NOT ported —
-- CUH AnimSounds only supports sound events. The grenade bodygroup toggle
-- would need to be re-implemented via a separate AnimEvents system.
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.3333, sound = "TFA_CODWW2_M1935.FPO" } },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" } },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_RIFLE.Holster" } },
    ["reload"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1935.TacMagOut" },
        { time = 1.5000, sound = "TFA_CODWW2_M1935.TacMagIn" } },
    ["reload_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1935.MagOut" },
        { time = 1.5000, sound = "TFA_CODWW2_M1935.MagIn" } },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1935.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_M1935.Inspect2" } },
    ["inspect_epic"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1935.EpicInspect1" },
        { time = 3.0000, sound = "TFA_CODWW2_M1935.EpicInspect2" } },
    --[Extended Mag]--
    ["reload_ext_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1935.MagOut" },
        { time = 1.5000, sound = "TFA_CODWW2_M1935.MagIn" } },
    --[Grenade Launcher]--
    ["draw_grenade"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" } },
    ["draw_grenade_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" } },
    ["holster_grenade"] = {
        { time = 0.0667, sound = "TFA_CODWW2_RIFLE.Holster" } },
    ["holster_grenade_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_RIFLE.Holster" } },
    ["grenade_in"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RFLGRND.Foley" },
        { time = 0.8333, sound = "TFA_CODWW2_RFLGRND.On" } },
    ["grenade_in_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_SML.Raise" } },
    ["grenade_out"] = {
        { time = 0.6667, sound = "TFA_CODWW2_RFLGRND.Off" } },
    ["grenade_out_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_SML.Holster" } },
    ["reload_grenade"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RFLGRND.Foley" },
        { time = 0.8333, sound = "TFA_CODWW2_RFLGRND.On" } },
    ["inspect_grenade"] = {
        { time = 0.0333, sound = "TFA_CODWW2_STG44.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_STG44.Inspect1b" },
        { time = 3.8333, sound = "TFA_CODWW2_STG44.Inspect2" } },
    ["inspect_grenade_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_STG44.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_STG44.Inspect1b" },
        { time = 3.8333, sound = "TFA_CODWW2_STG44.Inspect2" } } }

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

    -- Bullets
    if SERVER or iftp then
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)
        if self:GetNWBool("Silenced") then dmg = math.Round(dmg * 0.95) end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end

    -- Recoil
    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
        * (self:GetUHBool("Zooming") and 0.35 or 1)
    if SERVER or (CLIENT and iftp) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + 0.14)
        if not self.NoShell then self:CreateShell(self.ShellDelay or 0, self.ShellHeat) end
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
    self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)
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
-- SMART MUZZLE / SHELL
-- ============================================================
function SWEP:GetDisplay()
    -- Override: return the index of attachment "1" (tag_silencer)
    -- so the 3D2D ammo counter appears near the muzzle/sights,
    -- not at __illumPosition on j_gun (the grip).
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("1")
        if att > 0 then return att end
    end
    return 1
end

function SWEP:GetMuzzle()
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
end

function SWEP:GetShellEject()
    -- TFA WWII models use attachment name "0" (on bone tag_brass)
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
-- SPRINT / IDLE / INSPECT
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
    BaseClass.Think(self)
    if not IsValid(self.Owner) then return end
    local ct = CurTime()

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end

    -- Continue burst rounds even if player released M1
    if self._burstRemaining and self._burstRemaining > 0 then
        if ct >= (self._burstNextFire or 0) then
            self:FireBurstRound()
        end
    end

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
-- Dynamic sight_nydar_lens entry skipped (runtime helper not available in CUH)
-- ============================================================
SWEP.ViewModelElements = {
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/c_pg1935_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/c_pg1935_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["lens_sight"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/sights/c_lens_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/c_pg1935_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/c_pg1935_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["grenade_rail"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/ger_rifle_grenade/c_rifle_grenade.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["bayonet"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/bayonet/c_ger_bayonet.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/bar/c_bar_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {[0] = 1}, bonemerge = true,
        active = false } }

SWEP.WorldModelElements = {
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/w_pg1935_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/w_pg1935_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/w_pg1935_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/pg1935/w_pg1935_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["grenade_rail"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/ger_rifle_grenade/w_rifle_grenade.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["bayonet"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/bayonet/w_ger_bayonet.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false } }

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments, CUH format with default=0)
-- Note: TFA source starts at index [2] (no [1] slot) — preserved.
-- ============================================================
SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_lens_sight", "tfa_codww2_nydar", "tfa_codww2_4x" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_bayonet" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip" }, default = 0 },
    [7] = { name = "Slot 7", atts = { "tfa_codww2_highcal", "tfa_codww2_rapidfire_pg1935", "tfa_codww2_fmj" }, default = 0 } }
