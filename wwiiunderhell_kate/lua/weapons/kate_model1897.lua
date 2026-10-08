-- ============================================================
-- Combat Shotgun (Model 1897) — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_model1897 (TFA WWII Kate)
-- Template: template_shotgun (Pump-Action Shotgun — Type 6)
-- ============================================================
-- Pump-action shotgun. Fires one round per trigger pull, plays a
-- pump animation (rechamber) after firing, reloads shell-by-shell.
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Combat Shotgun"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Shotguns"

SWEP.Slot = 3
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/model1897/c_model1897.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/model1897/w_model1897.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(3.2, -2, -1)
SWEP.LoweredAng = Vector(-17.5, 41.5, -20)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "shotgun"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_SHGN.GenHigh")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 7
SWEP.Primary.Ammo           = "buckshot"
SWEP.Primary.DefaultClip    = 77
SWEP.Primary.MinDamage      = 110.0
SWEP.Primary.MaxDamage      = 110.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.075
SWEP.Primary.Delay          = 0.272727       -- 60 / RPM(220)
SWEP.Primary.NumberofShots  = 8
SWEP.Primary.MinRecoil      = -1.2          -- = -KickUp
SWEP.Primary.MaxRecoil      = -1.0          -- = -KickDown
SWEP.Primary.KickUp         = 1.2
SWEP.Primary.KickDown       = 1.0
SWEP.Primary.KickHorizontal = 0.5
SWEP.Primary.SpreadMultiplierMax = 3.0
SWEP.Primary.SpreadIncrement    = 2.0
SWEP.Primary.SpreadRecovery     = 2.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true          -- TFA: DisableChambering = true

-- Range falloff (from TFA Primary.RangeFalloffLUT)
SWEP.Primary.RangeFalloffLUT = {
    bezier = false,
    range_func = "linear",
    units = "meters",
    lut = {
        {range = 12, damage = 1},
        {range = 15, damage = 0.75},
        {range = 20, damage = 0.75},
        {range = 22, damage = 0.55},
    }
}

-- Shotgun config
SWEP.Shotgun = true
SWEP.IsPump = true
SWEP.PumpDelay = 0.4           -- 20/30 from SequenceLengthOverride[ACT_VM_PULLBACK_HIGH]
SWEP.Primary.ReloadTime = 0.7     -- per-shell insertion time (template default)

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-3.345, -2, 1.3)
SWEP.IronSightsAng = Vector(0.6, 0, 0)
SWEP.IronSightTime = 0.3
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
SWEP.MeleeRange     = 54          -- BashLength
SWEP.MeleeDelay     = 0.2         -- BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingRfl"     -- BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}         -- BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (from TFA LuaShell*)
SWEP.NoShell   = true              -- shotguns don't auto-eject shells
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_12gauge.mdl"   -- LuaShellModel

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(16.8, 1.0, -4.5)    -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)    -- (Right→Pitch, Up→Yaw, Forward→Roll)

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
    ["start_reload"]  = "reload_start",
    ["reload_loop"]   = "reload_loop",
    ["after_reload"]  = "reload_end",
    ["start_reload"]  = "reload_start",
    ["after_reload"] = "reload_end",
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
    -- Custom (from TFA SWEP.Animations table — incendiary dragon shell variants)
    ["rechamber_dragon"]         = "rechamber_dragon",
    ["reload_start_dragon"]       = "reload_start_dragon",
    ["reload_start_dragon_empty"] = "reload_start_dragon_empty",
    ["reload_loop_dragon"]        = "reload_loop_dragon",
    ["reload_end_dragon"]         = "reload_end_dragon",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ACT_VM_* keys mapped to string keys per spec.
-- NOTE: lua-type events (EventShell calls) are NOT ported —
-- CUH AnimSounds only supports sound events. The shell eject
-- is handled by the PostShoot/GetShellEject logic instead.
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.FPOFoley" },
        { time = 0.3333, sound = "TFA_CODWW2_M1897.FPOGrab" },
        { time = 0.8333, sound = "TFA_CODWW2_M1897.FPOCharge" },
    },
    ["draw"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1897.Draw" },
    },
    ["draw_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Draw" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_MED.Holster" },
    },
    ["holster_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_MED.Holster" },
    },
    ["rechamber"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Rack" },
    },
    ["rechamber_ads"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Rack" },
    },
    ["start_reload"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ADSFoley" },
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ShellStart" },
        { time = 1.0000, sound = "TFA_CODWW2_M1897.ShellIn" },
    },
    ["reload_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ADSFoley" },
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ShellStart" },
        { time = 1.0000, sound = "TFA_CODWW2_M1897.ShellIn" },
    },
    ["reload"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1897.ShellIn" },
    },
    ["after_reload"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.EndStart" },
        { time = 0.3333, sound = "TFA_CODWW2_M1897.EndPump" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_M1897.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_M1897.Inspect2" },
    },
    --[Dragon (Incendiary Shells)]--
    ["reload_start_dragon_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.DRGStart" },
        { time = 1.0000, sound = "TFA_CODWW2_M1897.DRGClose" },
    },
    ["reload_start_dragon"] = {
        { time = 0.8333, sound = "TFA_CODWW2_M1897.ShellIn" },
    },
    ["reload_loop_dragon"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ShellIn" },
    },
    ["reload_end_dragon"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.ADSFoley" },
    },
    ["rechamber_dragon"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 0.4000, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 0.8000, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 1.2000, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 1.6333, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 2.0667, sound = "TFA_CODWW2_M1897.Rack" },
        { time = 2.4667, sound = "TFA_CODWW2_M1897.Rack" },
    },
}

-- ============================================================
-- PUMP-ACTION RECHAMBER (PostShoot override)
-- ============================================================
function SWEP:PostShoot()
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
        self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)
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
function SWEP:GetMuzzle()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("tag_flash")
        if att > 0 then return att end
        att = vm:LookupAttachment("tag_silencer")
        if att > 0 then return att end
    end
    return 1
end

function SWEP:GetShellEject()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("tag_brass")
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
    -- PostShoot (pump) is called automatically by BaseClass.PrimaryAttack
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
-- Dynamic sight_nydar_lens entry (TFA.CODWW2.GetHoloSightReticle) skipped — resolves to nil in CUH
-- ============================================================
SWEP.ViewModelElements = {
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["shell_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_shell_incen.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["shell_incen"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/c_model1897_shell.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
}

SWEP.WorldModelElements = {
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["stock_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_stock.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/model1897/w_model1897_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
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
    [2] = { name = "Slot 2", atts = { "tfa_codww2_nydar" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag_noani" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_incenshells" }, default = 0 },
}
