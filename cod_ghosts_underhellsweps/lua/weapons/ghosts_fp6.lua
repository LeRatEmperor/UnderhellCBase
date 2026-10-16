-- ============================================================
-- FP6 — Ported from TFA Ghosts to CUH base
-- Source: nz_ghosts_fp6
-- Special: Multi-stage reload (5 different reload animations
--   based on shells remaining)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "FP6"
SWEP.Category    = "COD: Ghosts"
SWEP.SubCategory = "Shotguns"

SWEP.Slot = 3
SWEP.Spawnable = true
SWEP.Customizable = false
SWEP.MeleeEnabled = false

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel  = "models/weapons/iw6/fp6/c_fp6.mdl"
SWEP.WorldModel = "models/weapons/iw6/fp6/world/w_fp6.mdl"
SWEP.LoweredPos = Vector(0, 0, 0)
SWEP.LoweredAng = Vector(0, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 15

-- Fire mode
SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats
SWEP.Primary.Sound          = Sound("Weapons_Ghosts_FP6.Fire")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 5
SWEP.Primary.Ammo           = "buckshot"
SWEP.Primary.DefaultClip    = 50
SWEP.Primary.MinDamage      = 80.0
SWEP.Primary.MaxDamage      = 80.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.065
SWEP.Primary.Delay          = 0.600000    -- pump-action cycle (fire + pump)
SWEP.Primary.NumberofShots  = 8
SWEP.Primary.MinRecoil      = -1.2
SWEP.Primary.MaxRecoil      = -1.2
SWEP.Primary.KickUp         = 1.2
SWEP.Primary.KickDown       = 1.2
SWEP.Primary.KickHorizontal = 0.35
SWEP.Primary.SpreadMultiplierMax = 1.0
SWEP.Primary.SpreadIncrement    = 0.0
SWEP.Primary.SpreadRecovery     = 4.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint         = true

-- Pump-action shotgun config
SWEP.IsPump    = true
SWEP.PumpDelay = 0.200       -- pump animation starts 0.2s after fire
SWEP.Shotgun   = true

-- Ironsights
SWEP.IronSightsPos = Vector(-3.825, -2, 1)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- Ironsight dip
SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

-- Muzzle
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Shell ejection (shotgun shells built into the model, no eject)
SWEP.NoShell   = true
SWEP.ShellHeat = 0.8
SWEP.ShellDelay = 0

-- World model positioning
SWEP.WorldModelOffset = Vector(8.5, 1, -5.5)
SWEP.WorldModelAngle  = Angle(10, 180, 180)

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {
    ["shoot_last"]   = "fire_last",
    ["fire_ads"]     = "fire_ads",
    ["idle"]         = "idle",
    ["idle_empty"]   = "idle_empty",
    ["deploy"]       = "draw",
    ["holster"]      = "holster",
    ["draw_first"]   = "draw_first",
    ["melee"]        = "melee",
    ["melee_empty"]  = "melee_empty",
    ["inspect"]      = "inspect",
    ["inspect_empty"] = "inspect_empty",
    ["reload"]       = "ACT_VM_RELOAD_EMPTY",   -- full 5-round reload (empty)
    ["reload_1"]     = "ACT_VM_RELOAD",          -- 1 shell (4 remaining)
    ["reload_2"]     = "ACT_RELOAD_LOW",          -- 2 shells (3 remaining)
    ["reload_3"]     = "ACT_VM_RELOAD2",          -- 3 shells (2 remaining)
    ["reload_4"]     = "ACT_VM_RELOAD_SILENCED",   -- 4 shells (1 remaining)
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
    ["sprint_idle"]  = "sprint_loop",
}

-- ============================================================
-- ANIMSOUNDS (ported from TFA EventTable, time = N/30 -> seconds)
-- Includes pump/chamber sounds and shell insertion sounds.
-- ============================================================
SWEP.AnimSounds = {
    ["deploy"] = {
        { time = 0.1000, sound = "Weapons_Ghosts_MEDIUM.Generic" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "Weapons_Ghosts_MEDIUM.Generic" },
    },
    ["rechamber"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Chamber" },
    },
    ["rechamber_ads"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Chamber" },
    },
    ["reload"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Lift" },
        { time = 0.7000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.2333, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.7667, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 2.3000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 2.8333, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 3.3333, sound = "Weapons_Ghosts_FP6.Chamber" },
        { time = 3.8667, sound = "Weapons_Ghosts_FP6.End" },
    },
    ["reload_1"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Lift" },
        { time = 0.7000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.4333, sound = "Weapons_Ghosts_FP6.Chamber" },
        { time = 1.8667, sound = "Weapons_Ghosts_FP6.End" },
    },
    ["reload_2"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Lift" },
        { time = 0.7000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.2333, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.9000, sound = "Weapons_Ghosts_FP6.Chamber" },
        { time = 2.3667, sound = "Weapons_Ghosts_FP6.End" },
    },
    ["reload_3"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Lift" },
        { time = 0.7000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.2333, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.7667, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 2.4000, sound = "Weapons_Ghosts_FP6.Chamber" },
        { time = 2.8667, sound = "Weapons_Ghosts_FP6.End" },
    },
    ["reload_4"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_FP6.Lift" },
        { time = 0.7000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.2333, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.7667, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 2.3000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 2.8667, sound = "Weapons_Ghosts_FP6.Chamber" },
        { time = 3.4333, sound = "Weapons_Ghosts_FP6.End" },
    },
}

-- ============================================================
-- MULTI-STAGE RELOAD SYSTEM
-- ============================================================
-- The FP6 has 5 different reload animations based on how many
-- shells remain in the magazine:
--   0 shells (empty) → reload   (ACT_VM_RELOAD_EMPTY) — full 5-round reload
--   1 shell         → reload_4 (ACT_VM_RELOAD_SILENCED) — 4 shells inserted
--   2 shells         → reload_3 (ACT_VM_RELOAD2) — 3 shells inserted
--   3 shells         → reload_2 (ACT_RELOAD_LOW) — 2 shells inserted
--   4 shells         → reload_1 (ACT_VM_RELOAD) — 1 shell inserted
--
-- The reload animation timing (from TFA StatusLengthOverride):
--   reload_1 (1 shell):  21/30 = 0.7000s
--   reload_2 (2 shells): 37/30 = 1.2333s
--   reload_3 (3 shells): 53/30 = 1.7667s
--   reload_4 (4 shells): 69/30 = 2.3000s
--   reload   (5 shells): 2.85s
--
-- Ammo management: shells are inserted at specific times during
-- the animation. The base reload system sets Clip1 to full after
-- the animation ends, but we need to insert shells one at a time
-- to match the animation.

-- Reload timing table (seconds for each reload stage)
-- The full empty reload (5 shells) runs ~4.0s based on the sound
-- schedule (last sound "End" fires at 3.8667s).
SWEP.FP6_ReloadTimes = {
    [0] = 4.0000,    -- full empty reload (5 shells)
    [1] = 2.3000,   -- 4 shells to insert
    [2] = 1.7667,   -- 3 shells to insert
    [3] = 1.2333,   -- 2 shells to insert
    [4] = 0.7000,   -- 1 shell to insert
}

function SWEP:Reload()
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self:GetNWFloat("DeployTime") > CurTime() then return end

    local clip = self:Clip1()
    if clip >= self.Primary.ClipSize then return end

    -- Determine which reload animation to play
    local reloadKey
    if clip == 0 then
        reloadKey = "reload"       -- full empty reload
    elseif clip == 1 then
        reloadKey = "reload_4"     -- 4 shells to insert
    elseif clip == 2 then
        reloadKey = "reload_3"     -- 3 shells to insert
    elseif clip == 3 then
        reloadKey = "reload_2"     -- 2 shells to insert
    elseif clip == 4 then
        reloadKey = "reload_1"     -- 1 shell to insert
    else
        reloadKey = "reload_1"     -- fallback
    end

    -- Play the reload animation
    self:EasySendWeaponAnim(reloadKey, ACT_VM_RELOAD)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local animDuration = IsValid(vm) and vm:SequenceDuration() or self.FP6_ReloadTimes[clip] or 2.0
    -- Safety: never shorter than the longest sound schedule entry
    if reloadKey == "reload" and animDuration < 4.0 then
        animDuration = 4.0
    end

    -- Set reload state
    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)
    self:SetNWFloat("ReloadTime", animDuration)
    self:SetNWFloat("ReloadEndTime", CurTime() + animDuration)
    self._reloadEndTime = CurTime() + animDuration
    self._reloadFinished = false
    self._fp6_ammoAdded = false

    -- Ammo management: shells are added 0.1s BEFORE the animation ends.
    -- This avoids the "ammo instantly appears at reload start" look
    -- while guaranteeing that even a last-millisecond sprint cancel
    -- can't strip the ammo away (the 0.1s buffer absorbs Think jitter).
    local ammoTime = math.max(0.05, animDuration - 0.1)
    local clipStart = clip
    local shellsToInsert = self.Primary.ClipSize - clipStart
    timer.Simple(ammoTime, function()
        if not IsValid(self) then return end
        if not IsValid(self.Owner) then return end
        if self.Owner:GetActiveWeapon() ~= self then return end
        if not self:GetUHBool("Reloading") then return end
        if self._fp6_ammoAdded then return end
        self._fp6_ammoAdded = true

        if SERVER then
            local owner = self:GetOwner()
            local ammoType = self.Primary.Ammo
            local reserve = owner:GetAmmoCount(ammoType)
            local actualInsert = math.min(shellsToInsert, reserve)
            owner:RemoveAmmo(actualInsert, ammoType)
            self:SetClip1(clipStart + actualInsert)
        end
    end)
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

-- ============================================================
-- SHOOT ANIMATION SELECTION
-- ============================================================
function SWEP:ShootAnimation()
    -- Use the model's primary-attack ACT directly (rather than the
    -- "fire" sequence name). ACT_VM_PRIMARYATTACK_1 is the ADS variant
    -- that the model maps to the aimed-fire sequence.
    if self:GetUHBool("Zooming") then
        return ACT_VM_PRIMARYATTACK_1
    end
    return ACT_VM_PRIMARYATTACK
end

-- ============================================================
-- PUMP-ACTION RECHAMBER (PostShoot override)
-- ============================================================
-- After firing, plays the pump/rechamber animation (ACT_VM_PULLBACK_HIGH
-- for hipfire, ACT_VM_PULLBACK_LOW for ADS) after a short delay.
-- Primary.Delay (0.6s) is set high enough that the next shot can't
-- fire until the pump animation has completed — so the pump can
-- never be cancelled by the next trigger pull.
function SWEP:PostShoot()
    if not self.IsPump then return end
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.2
    -- Ensure next fire is at least pumpDelay away so the pump
    -- animation has time to start before the next shot.
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))
    timer.Simple(pumpDelay, function()
        if not IsValid(self) or not IsValid(self.Owner)
           or not IsValid(self.Owner:GetActiveWeapon())
           or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        local isADS = self:GetUHBool("Zooming")
        local animKey = isADS and "rechamber_ads" or "rechamber"
        local fallbackAct = isADS and ACT_VM_PULLBACK_LOW or ACT_VM_PULLBACK_HIGH
        self:EasySendWeaponAnim(animKey, fallbackAct)
    end)
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
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

-- ============================================================
-- THINK
-- ============================================================
function SWEP:Think()
    local ct = CurTime()

    -- Melee state (not used since MeleeEnabled = false, but keep for safety)
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
-- HOLSTER / DEPLOY
-- ============================================================
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
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW)
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
-- VELEMENTS / WELEMENTS (empty — not customizable)
-- ============================================================
SWEP.ViewModelElements = {}
SWEP.WorldModelElements = {}

-- ============================================================
-- ATTACHMENTS (empty — not customizable)
-- ============================================================
SWEP.Attachments = {}
