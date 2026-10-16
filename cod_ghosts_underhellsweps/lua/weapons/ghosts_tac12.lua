-- ============================================================
-- Tac 12 — Ported from TFA Ghosts to CUH base
-- Source: nz_ghosts_tac12
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Tac 12"
SWEP.Category    = "COD: Ghosts"
SWEP.SubCategory = "Shotguns"

SWEP.Slot = 3
SWEP.Spawnable = true
SWEP.Customizable = false
SWEP.MeleeEnabled = false

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel  = "models/weapons/iw6/tac12/c_tac12.mdl"
SWEP.WorldModel = "models/weapons/iw6/tac12/world/w_tac12.mdl"
SWEP.LoweredPos = Vector(0, 0, 0)
SWEP.LoweredAng = Vector(0, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "shotgun"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 15

-- Fire mode
SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats
SWEP.Primary.Sound          = Sound("Weapons_Ghosts_TAC.Fire")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 10
SWEP.Primary.Ammo           = "buckshot"
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.MinDamage      = 55.0
SWEP.Primary.MaxDamage      = 55.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = .067
SWEP.Primary.Delay          = 0.200000    -- 300 RPM
SWEP.Primary.NumberofShots  = 8
SWEP.Primary.MinRecoil      = -1.5
SWEP.Primary.MaxRecoil      = -1.5
SWEP.Primary.KickUp         = 1.5
SWEP.Primary.KickDown       = 1.5
SWEP.Primary.KickHorizontal = 0.35
SWEP.Primary.SpreadMultiplierMax = 1.0
SWEP.Primary.SpreadIncrement    = 0.0
SWEP.Primary.SpreadRecovery     = 6.0
-- Shotgun looped-reload settings (mirrors KRM-262 pattern):
--   ReloadTime  = seconds between shell insertions (TFA LoopedReloadInsertTime = 13/30)
--   ShellSound   = sound emitted on each per-shell loop iteration
SWEP.Primary.ReloadTime     = 13 / 30   -- ~0.4333s per shell
SWEP.Primary.ShellSound     = Sound("Weapons_Ghosts_TAC.Insert")
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint         = true

-- Ironsights
SWEP.IronSightsPos = Vector(-3.214, -3, -0.84)
SWEP.IronSightsAng = Vector(0.5, 0, 0)
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

-- Melee bash
SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 300
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "Weapons_Ghosts_LARGE.Generic"
SWEP.MeleeHitSound  = {"Weapons_Ghosts_LARGE.Generic"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection
SWEP.NoShell   = false
SWEP.ShellHeat = 0.8
SWEP.ShellDelay = 0

-- World model positioning
SWEP.WorldModelOffset = Vector(15, 1, -6.5)
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
    -- Looped shotgun reload: start -> loop -> finish (KRM-262 pattern)
    ["start_reload"]  = "ACT_SHOTGUN_RELOAD_START",   -- plays once at reload start
    ["reload_loop"]   = "ACT_VM_RELOAD",               -- loops once per shell
    ["after_reload"]  = "ACT_SHOTGUN_RELOAD_FINISH",   -- plays once at reload end
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
    ["sprint_idle"]  = "sprint_loop",
}

-- ============================================================
-- ANIMSOUNDS (time = N/30 -> seconds)
-- ============================================================
SWEP.AnimSounds = {
    -- Looped shotgun reload sounds (ported from TFA EventTable):
    --   start_reload  : Lift at 3/30=0.1s, Insert at 35/30=1.1667s
    --   reload_loop   : Insert at 7/30=0.2333s (per shell)
    --   after_reload  : Grab at 5/30=0.1667s, Chamber at 13/30=0.4333s, End at 28/30=0.9333s
    ["start_reload"] = {
        { time = 0.1000, sound = "Weapons_Ghosts_TAC.Lift" },
        { time = 1.1667, sound = "Weapons_Ghosts_TAC.Insert" },
    },
    ["reload_loop"] = {
        { time = 0.2333, sound = "Weapons_Ghosts_TAC.Insert" },
    },
    ["after_reload"] = {
        { time = 0.1667, sound = "Weapons_Ghosts_TAC.Grab" },
        { time = 0.4333, sound = "Weapons_Ghosts_TAC.Chamber" },
        { time = 0.9333, sound = "Weapons_Ghosts_TAC.End" },
    },
    ["deploy"] = {
        { time = 0.1000, sound = "Weapons_Ghosts_MEDIUM.Generic" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "Weapons_Ghosts_MEDIUM.Generic" },
    },
    ["rechamber"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_TAC.Chamber" },
    },
    ["rechamber_ads"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_TAC.Chamber" },
    },
}

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
    if self.MeleeEnabled ~= false and self.Owner:KeyDown(IN_USE) then
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

-- ============================================================
-- LOOPED SHOTGUN RELOAD (KRM-262 pattern)
-- ============================================================
-- Fully self-contained — does NOT call BaseClass.Reload.
-- The base class's cycle-based ReloadShotgun doesn't work with
-- these models, so we override both Reload() and ReloadShotgun()
-- to use a timer-based approach.
--
-- Flow:
--   1. Reload() plays start_reload (ACT_SHOTGUN_RELOAD_START) once.
--   2. When start_reload finishes, the first shell is inserted
--      (ShotgunStartAnimShell = true semantics).
--   3. ReloadShotgun() runs every Think while reloading:
--        - If clip is full, no reserve, or fire pressed -> play
--          after_reload (ACT_SHOTGUN_RELOAD_FINISH) and stop.
--        - Otherwise, every Primary.ReloadTime seconds, play
--          reload_loop (ACT_VM_RELOAD) and insert one shell.
function SWEP:Reload()
    if self._meleeActive then return end

    -- Block reload while holding E (USE) so inspect (E+R) doesn't cancel
    if self.Owner:KeyDown(IN_USE) then return end

    local ct = CurTime()

    -- Don't reload if already reloading, sprinting, or blocked
    if self.NextReload >= ct then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self.Owner:GetNWFloat("UH_GrenadeTime", 0) > ct then return end
    if self:GetNWFloat("DeployTime", 0) > ct then return end

    -- Don't reload if clip is full or no reserve ammo
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then return end

    -- Ensure fire mode is active
    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

    -- Play third-person reload animation
    if SERVER then
        self.Owner:SetAnimation(PLAYER_RELOAD)
    end
    self.NextReload = ct + 0.5

    -- Call PreReload (hook for subclasses)
    self:PreReload()

    -- Play the start reload animation
    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)

    -- Get the duration of the start_reload animation
    local vm = self.Owner:GetViewModel()
    local startDur = IsValid(vm) and vm:SequenceDuration() or 1.2

    -- Timer-based shell insertion: first shell lands when start_reload finishes
    local shellInterval = self.Primary.ReloadTime or 0.4333
    self._tac12_nextShell = ct + startDur
    self.reloaddelay = self._tac12_nextShell

    -- Block firing during reload start
    self:SetNextPrimaryFire(ct + startDur + 0.1)
    self:SetNextSecondaryFire(ct + startDur + 0.1)
    self.NextReload = ct + startDur + 0.1

    -- Set reload state
    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)

    -- HUD reload timer (shows progress bar)
    local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
    local amount = num * shellInterval
    self:SetNWFloat("ReloadTime", amount)
    self:SetNWFloat("ReloadEndTime", ct + startDur + amount)

    -- Prevent the base class's _FinishReload from double-filling the clip;
    -- we manage ammo ourselves inside ReloadShotgun().
    self._reloadFinished = true
    self._tac12_reloading = true
end

-- ============================================================
-- RELOAD SHOTGUN (timer-based, called every Think while reloading)
-- ============================================================
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

    -- ==========================================
    -- STOP CONDITIONS: clip full, no reserve, or fire pressed
    -- ==========================================
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then

        self:ClearAnimSounds()

        -- Play the finish animation
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)

        local vm = self.Owner:GetViewModel()
        local endDur = IsValid(vm) and vm:SequenceDuration() or 1.0

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur

        self._tac12_nextShell = nil
        self._tac12_reloading = nil
        self.reloaddelay = nil

        self:PostReload()
        return
    end

    -- ==========================================
    -- TIMER-BASED SHELL INSERTION
    -- ==========================================
    if self._tac12_nextShell and ct >= self._tac12_nextShell then
        local shellInterval = self.Primary.ReloadTime or 0.4333

        -- Schedule the next shell insertion
        self._tac12_nextShell = ct + shellInterval

        -- Play the per-shell reload animation
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)

        -- Play the shell insertion sound (if set)
        if self.Primary.ShellSound then
            if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
                self.Owner:EmitSound(self.Primary.ShellSound, 75, 100, 1, CHAN_USER_BASE)
            end
        end

        -- Insert shell (server-authoritative)
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end

-- ============================================================
-- THINK
-- ============================================================
function SWEP:Think()
    local ct = CurTime()
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end

    -- ==========================================
    -- LOOPED SHOTGUN RELOAD — must run BEFORE BaseClass.Think
    -- so the base class doesn't try to _FinishReload on us.
    -- ==========================================
    if self._tac12_reloading and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
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
    -- Cancel any in-progress looped reload so timers don't fire post-holster
    self._tac12_nextShell = nil
    self._tac12_reloading = nil
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
