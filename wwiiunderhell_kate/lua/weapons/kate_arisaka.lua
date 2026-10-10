-- ============================================================
-- Type 38 (Arisaka) — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_arisaka (TFA WWII Kate)
-- Template: template_bolt (Bolt-Action Sniper)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Type 38"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Snipers"

SWEP.Slot = 4
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/arisaka/c_arisaka.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/arisaka/w_arisaka.mdl"
SWEP.LoweredPos = Vector(-1, -2, -0.5)
SWEP.LoweredAng = Vector(-15, 25, -20)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_KAR98K.Punch.Delay")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 5
SWEP.Primary.Ammo           = "SniperPenetratedRound"
SWEP.Primary.DefaultClip    = 55
SWEP.Primary.MinDamage      = 75.0
SWEP.Primary.MaxDamage      = 75.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.05
SWEP.Primary.Delay          = 0.24         -- 60 / RPM(250)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.0
SWEP.Primary.KickUp         = 1.0
SWEP.Primary.KickDown       = 1.0
SWEP.Primary.KickHorizontal = 0.3
SWEP.Primary.SpreadMultiplierMax = 4.0
SWEP.Primary.SpreadIncrement    = 1.5
SWEP.Primary.SpreadRecovery     = 3.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

-- Bolt-action rechamber config
SWEP.IsBoltAction = true
SWEP.PumpDelay = 0.4

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-3.2, -1.5, 0.73)
-- Scope-specific ironsight positions (from TFA source)
SWEP.IronSightsPos_7X = Vector(-2.14, -3.5, 0.2375)
SWEP.IronSightsAng_7X = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
-- Reticle texture for RT scope (from TFA source scope_c.vtf)
SWEP.ScopeReticle = "scopes/scope_overlay_japanese"

-- ACOG ironsight position (from TFA source)
SWEP.IronSightsPos_ACOG = Vector(-2.621, -8, -0.151)
SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (from TFA Secondary.Bash*)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 55
SWEP.MeleeDelay     = 0.2
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingRfl"
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (from TFA LuaShell*)
SWEP.NoShell   = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_556.mdl"

-- World model positioning (from TFA SWEP.Offset)
SWEP.WorldModelOffset = Vector(13.8, 1.0, -5.6)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)

-- ============================================================
-- ANIMATIONS (template defaults + TFA source custom animations)
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_last",
    ["fire_ads"]     = "fire_ads",
    ["iron_fire"]    = "fire_ads",
    ["rechamber"]    = "rechamber",
    ["rechamber_ads"] = "rechamber_ads",
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
    ["reload_ext"]         = "reload_ext",
    ["reload_ext_empty"]   = "reload_ext_empty",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- NOTE: lua-type events (EventShell calls) are NOT ported —
-- CUH AnimSounds only supports sound events. The shell eject
-- is handled by the PostShoot/GetShellEject logic instead.
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.3333, sound = "TFA_CODWW2_KAR98K.FPO" },
    },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" },
    },
    ["draw_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" },
    },
    ["holster"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Holster" },
    },
    ["holster_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Holster" },
    },
    ["rechamber"] = {
        { time = 0.1667, sound = "TFA_CODWW2_KAR98K.CycleOpen" },
        { time = 0.5000, sound = "TFA_CODWW2_KAR98K.CycleClose" },
    },
    ["rechamber_ads"] = {
        { time = 0.1667, sound = "TFA_CODWW2_KAR98K.CycleAdsOpen" },
        { time = 0.5000, sound = "TFA_CODWW2_KAR98K.CycleAdsClose" },
    },
    ["reload"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KAR98K.TacOpen" },
        { time = 1.8333, sound = "TFA_CODWW2_KAR98K.TacClipin" },
        { time = 2.5000, sound = "TFA_CODWW2_KAR98K.TacClose" },
    },
    ["reload_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KAR98K.EmptyOpen" },
        { time = 1.8333, sound = "TFA_CODWW2_KAR98K.EmptyClipin" },
        { time = 2.5000, sound = "TFA_CODWW2_KAR98K.EmptyClose" },
    },
    ["reload_ext"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KAR98K.TacExtMagout" },
        { time = 2.0000, sound = "TFA_CODWW2_KAR98K.TacExtMagin" },
    },
    ["reload_ext_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_KAR98K.EmptyExtOpen" },
        { time = 1.1667, sound = "TFA_CODWW2_KAR98K.EmptyExtMagout" },
        { time = 2.6667, sound = "TFA_CODWW2_KAR98K.EmptyExtMagin" },
        { time = 3.3333, sound = "TFA_CODWW2_KAR98K.EmptyExtClose" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_ARISAKA.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_ARISAKA.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_ARISAKA.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_ARISAKA.Inspect2" },
    },
}

-- ============================================================
-- BOLT-ACTION RECHAMBER (PostShoot override)
-- ============================================================
function SWEP:PostShoot()

-- ============================================================
-- RECHAMBER GUARD (CanPrimaryAttack override)
-- ============================================================
-- Prevents spamming fire to bypass the bolt-action rechamber delay.
-- The base CanPrimaryAttack doesn't check GetNextPrimaryFire(), so
-- players could click rapidly to fire faster than the PumpDelay.
-- This override blocks fire until the rechamber sequence completes.
function SWEP:CanPrimaryAttack()
    if self:GetNWInt("FireMode") == 0 then return false end
    if self:GetNWFloat("DeployTime") > CurTime() then return false end
    if self:GetUHBool("Running") then return false end
    if self:GetUHBool("Reloading") then return false end
    -- CRITICAL: Block fire during bolt-action rechamber
    if self.IsBoltAction and CurTime() < self:GetNextPrimaryFire() then
        return false
    end
    if self:Clip1() <= 0 then
        if not self:GetUHBool("Reloading") then
            self:EmitSound("Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE)
        end
        self:SetNextPrimaryFire(CurTime() + 0.4)
        return false
    end
    return true
end

    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.4
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))
    timer.Simple(pumpDelay, function()
        if not IsValid(self) or not IsValid(self.Owner)
           or not IsValid(self.Owner:GetActiveWeapon())
           or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        self:EasySendWeaponAnim(animKey, ACT_VM_PULLBACK_HIGH)
    end)
end

-- ============================================================
-- SMART MUZZLE / SHELL
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

function SWEP:Think()
    local ct = CurTime()
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

function SWEP:Holster(wep)
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
    self._justExitedSprint = false
    return true
end

-- ============================================================
-- VELEMENTS / WELEMENTS (ported 1:1 from TFA VElements/WElements)
-- Renames: angle→ang, size→scale, bodygroup→bodygroups
-- ============================================================
SWEP.ViewModelElements = {
    ["scope_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_scope.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false, _defaultActive = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/c_arisaka_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["scope_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_scope.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false, _defaultActive = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/arisaka/w_arisaka_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments, CUH format with default=0)
-- Note: TFA source starts at index [2] (no [1] slot) — preserved.
-- ============================================================
SWEP.Attachments = {
        [1] = { name = "Optic", atts = { "tfa_codww2_arisaka_scope", "tfa_codww2_4x" }, default = 0 },
[2] = { name = "Slot 2", atts = { "tfa_codww2_xmag", "tfa_codww2_ballistic" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
}
