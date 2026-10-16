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
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
    ["sprint_idle"]  = "sprint_loop",
}

-- ============================================================
-- ANIMSOUNDS (time = N/30 -> seconds)
-- ============================================================
SWEP.AnimSounds = {
    ["act_shotgun_reload_finish"] = {
        { time = 0.1667, sound = "Weapons_Ghosts_TAC.Grab" },
        { time = 0.4333, sound = "Weapons_Ghosts_TAC.Chamber" },
        { time = 0.9333, sound = "Weapons_Ghosts_TAC.End" },
    },
    ["act_shotgun_reload_start"] = {
        { time = 0.1000, sound = "Weapons_Ghosts_TAC.Lift" },
        { time = 1.1667, sound = "Weapons_Ghosts_TAC.Insert" },
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
    ["reload"] = {
        { time = 0.2333, sound = "Weapons_Ghosts_TAC.Insert" },
    },
    ["reload_2"] = {
        { time = 0.1000, sound = "Weapons_Ghosts_TAC.Insert" },
        { time = 0.3000, sound = "iw4.ranger.insert" },
        { time = 0.5000, sound = "TFA_RENAISSANCE.SAWEDOFF.SHELL_IN" },
        { time = 0.9000, sound = "iw4.1887.insert" },
        { time = 1.1000, sound = "TFA_UGX.Spas_Insert" },
        { time = 1.3000, sound = "TFA_REN.M1887_Insert" },
        { time = 1.5000, sound = "Weapons_Ghosts_FP6.Insert" },
        { time = 1.7000, sound = "TFA_BO2.G_SHOTGUN.LOAD" },
        { time = 1.9000, sound = "TFA_T7C.Ray_Magin" },
        { time = 0.7000, sound = "ambient/alarms/train_horn2.wav" },
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

function SWEP:Reload()
    return BaseClass.Reload(self)
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
