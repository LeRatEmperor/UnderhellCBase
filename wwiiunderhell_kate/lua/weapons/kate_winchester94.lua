-- ============================================================
-- Lever Action (Winchester 94) — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_winchester94 (TFA WWII Kate)
-- Template: template_shotgun (Pump-Action Shotgun pattern)
-- ============================================================
-- Lever-action rifle using shotgun shell-by-shell reload.
-- IsPump=true, PumpDelay=0.4, Shotgun=true.
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Lever Action"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Snipers"

SWEP.Slot = 4
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/winchester94/c_winchester94.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/winchester94/w_winchester94.mdl"
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
SWEP.Primary.Sound          = Sound("TFA_CODWW2_LEVER.Shoot")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 6
SWEP.Primary.Ammo           = "SniperPenetratedRound"
SWEP.Primary.DefaultClip    = 66
SWEP.Primary.MinDamage      = 889.0
SWEP.Primary.MaxDamage      = 889.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.05
SWEP.Primary.Delay          = 0.24         -- 60 / RPM(250)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -0.9
SWEP.Primary.KickUp         = 1.0
SWEP.Primary.KickDown       = 0.9
SWEP.Primary.KickHorizontal = 0.3
SWEP.Primary.SpreadMultiplierMax = 4.0
SWEP.Primary.SpreadIncrement    = 2.0
SWEP.Primary.SpreadRecovery     = 2.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

-- Shotgun config
SWEP.Shotgun = true
SWEP.IsPump = true
SWEP.PumpDelay = 0.4
SWEP.Primary.ReloadTime = 0.5

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-3.9, -2, 1.2)
SWEP.IronSightsAng = Vector(0.2, 0, 0)
-- Reticle texture for RT scope (from TFA source scope_c.vtf)
SWEP.ScopeReticle = "scopes/scope_overlay_american"

-- ACOG ironsight position (from TFA source)
SWEP.IronSightsPos_ACOG = Vector(-3.04, -4.5, 0.045)
SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3
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
SWEP.NoShell   = true
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_556.mdl"

-- World model positioning (from TFA SWEP.Offset)
SWEP.WorldModelOffset = Vector(17.3, 1.0, -5.3)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)

-- ============================================================
-- ANIMATIONS (template defaults)
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
    ["start_reload"]  = "reload_start",
    ["reload_loop"]   = "reload_loop",
    ["after_reload"]  = "reload_end",
    ["shotgun_reload_start"]  = "reload_start",
    ["shotgun_reload_finish"] = "reload_end",
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LEVER.FPO" },
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
        { time = 0.1667, sound = "TFA_CODWW2_LEVER.CycleOpen" },
        { time = 0.3333, sound = "TFA_CODWW2_LEVER.Brass" },
        { time = 0.5000, sound = "TFA_CODWW2_LEVER.CycleClose" },
    },
    ["shoot_last"] = {
        { time = 0.3333, sound = "TFA_CODWW2_LEVER.CycleOpen" },
        { time = 0.5000, sound = "TFA_CODWW2_LEVER.Brass" },
        { time = 0.6667, sound = "TFA_CODWW2_LEVER.CycleClose" },
    },
    ["shotgun_reload_start"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LEVER.Start" },
    },
    ["reload_loop"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LEVER.Insert" },
    },
    ["shotgun_reload_finish"] = {
        { time = 0.1667, sound = "TFA_CODWW2_LEVER.Charge" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LEVER.Inspect1" },
        { time = 3.0000, sound = "TFA_CODWW2_LEVER.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LEVER.Inspect1" },
        { time = 3.0000, sound = "TFA_CODWW2_LEVER.Inspect2" },
    },
}

-- ============================================================
-- PUMP-ACTION RECHAMBER (PostShoot override)
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

    if not self.IsPump then return end
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
-- SHOTGUN SHELL-BY-SHELL RELOAD (KRM-262 pattern)
-- ============================================================

-- Reload() only STARTS the reload. The loop is handled by ReloadShotgun.
function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end

    local ct = CurTime()
    if self.NextReload >= ct then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self.Owner:GetNWFloat("GrenadeTime", 0) > ct then return end
    if self:GetNWFloat("DeployTime", 0) > ct then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then return end

    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

    self.Owner:SetAnimation(PLAYER_RELOAD)
    self.NextReload = ct + 0.5

    -- Play start reload animation + sounds
    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Timer-based shell insertion (KRM pattern)
    self._krm_nextShell = ct + startDur
    self.reloaddelay = self._krm_nextShell

    self:SetNextPrimaryFire(ct + startDur + 0.1)
    self:SetNextSecondaryFire(ct + startDur + 0.1)
    self.NextReload = ct + startDur + 0.1

    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)

    local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
    local amount = num * (self.Primary.ReloadTime or 0.5)
    self:SetNWFloat("ReloadTime", amount)
    self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
end

-- ReloadShotgun is called from CustomThink every tick while Reloading is true
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

    -- STOP conditions: clip full, no reserve, or fire pressed
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then

        self:ClearAnimSounds()
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)

        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur

        self._krm_nextShell = nil
        self.reloaddelay = nil

        if self.PostReload then self:PostReload() end
        return
    end

    -- TIMER-BASED shell insertion
    if self._krm_nextShell and ct >= self._krm_nextShell then
        local shellInterval = self.Primary.ReloadTime or 0.5
        self._krm_nextShell = ct + shellInterval

        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)

        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end

-- CustomThink: dispatches ReloadShotgun every tick while reloading
SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
    end
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

function SWEP:Think()
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
    self._krm_nextShell = nil
    self._justExitedSprint = false
    return true
end

-- ============================================================
-- VELEMENTS / WELEMENTS (ported 1:1 from TFA VElements/WElements)
-- Renames: angle→ang, size→scale, bodygroup→bodygroups
-- ============================================================
SWEP.ViewModelElements = {
    ["scope_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/c_winchester94_scope.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/c_winchester94_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/c_winchester94_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/c_winchester94_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["scope_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/w_winchester94_scope.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/w_winchester94_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/winchester94/w_winchester94_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
}

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments, CUH format with default=0)
-- Note: TFA source starts at index [2] (no [1] slot) — preserved.
-- ============================================================
SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_xmag_noani", "tfa_codww2_ballistic" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
}
