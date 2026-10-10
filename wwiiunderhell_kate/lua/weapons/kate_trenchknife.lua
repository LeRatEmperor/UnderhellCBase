-- ============================================================
-- Trench Knife -- Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_trenchknife (TFA WWII Kate Melees)
-- Template: melee (semi-auto shell that calls MeleeAttack on M1)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Trench Knife"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Melee"

SWEP.Slot = 0
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/trenchknife/c_trenchknife.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/trenchknife/w_trenchknife.mdl"
SWEP.LoweredPos = Vector(0, 0, 0)
SWEP.LoweredAng = Vector(0, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "knife"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- Fire mode (melee swing)
SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source -- Primary.Attacks[1])
SWEP.Primary.Sound          = Sound("TFA_CODWW2_MELEE.SwingPstl")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = -1              -- melee: infinite (no magazine)
SWEP.Primary.Ammo           = "none"          -- melee: no ammo
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.MinDamage      = 400.0      -- = TFA Primary.Attacks[1].dmg (= Secondary.Damage)
SWEP.Primary.MaxDamage      = 400.0
SWEP.Primary.Automatic      = true            -- continuous swinging
SWEP.Primary.TakeAmmo       = 0
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.0
SWEP.Primary.Delay          = 1.2   -- = TFA Primary.Attacks[1].end (time before next attack)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = 0
SWEP.Primary.MaxRecoil      = 0
SWEP.Primary.KickUp         = 0
SWEP.Primary.KickDown       = 0
SWEP.Primary.KickHorizontal = 0
SWEP.Primary.SpreadMultiplierMax = 1.0
SWEP.Primary.SpreadIncrement    = 0.0
SWEP.Primary.SpreadRecovery     = 0.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint         = true

-- Ironsights (melee -- no real ironsights)
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.2
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

-- Muzzle (unused on melee but kept for compatibility)
SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee stats (from TFA Primary.Attacks[1])
SWEP.MeleeDamage    = 400                  -- = TFA Primary.Attacks[1].dmg
SWEP.MeleeRange     = 50                   -- = TFA Primary.Attacks[1].len
SWEP.MeleeDelay     = 1.2             -- = TFA Primary.Attacks[1].end (swing speed)
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2667           -- = TFA Primary.Attacks[1].delay
SWEP.MeleeViewPunch = Angle(0, 0, 0)               -- = TFA Primary.Attacks[1].viewpunch
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingPstl"             -- = TFA Primary.Sound
SWEP.MeleeHitSound  = {"TFA_CODWW2_KNIFE.Stab"}            -- = TFA Primary.Sound_HitFlesh (stab/hit)
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (melee -- no shell)
SWEP.NoShell   = true
SWEP.ShellHeat = 0.8
SWEP.Shell     = ""

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(3, 1.2, -0.6)    -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(0, -90, 10)    -- (Pitch=Right, Yaw=Up, Roll=Forward)

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_last",
    ["fire_ads"]     = "fire_ads",
    ["iron_fire"]    = "fire_ads",
    ["idle"]         = "idle",
    ["idle_empty"]   = "idle",
    ["deploy"]       = "draw",
    ["holster"]      = "holster",
    ["draw_first"]   = "draw",
    ["melee"]        = "melee",
    ["melee_empty"]  = "melee",
    ["inspect"]      = "inspect",
    ["inspect_empty"] = "inspect",
    ["reload"]       = "ACT_VM_RELOAD",
    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 -> seconds)
-- ============================================================
SWEP.AnimSounds = {
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KNIFE.Draw" },
    },
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KNIFE.Draw" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_SML.Holster" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_KNIFE.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_KNIFE.Inspect2" },
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
-- ATTACK -- M1 swings directly (no E+M1 check, melee weapon)
-- ============================================================
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    local ct = CurTime()
    if ct < (self._nextMelee or 0) then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetNWFloat("DeployTime") > ct then return end
    if self:GetNWInt("FireMode") == 0 then return end
    if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
end

function SWEP:SecondaryAttack()
    -- Melee weapons have no ironsights
end

function SWEP:Reload()
    -- Melee weapons have no reload
end

-- ============================================================
-- THINK -- melee state machine + standard handlers
-- ============================================================
function SWEP:Think()
    local ct = CurTime()

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
-- VELEMENTS / WELEMENTS (melee weapons use the model directly)
-- ============================================================
SWEP.ViewModelElements = {}
SWEP.WorldModelElements = {}

-- ============================================================
-- ATTACHMENTS (melee weapons have no attachments)
-- ============================================================
SWEP.Attachments = {}
