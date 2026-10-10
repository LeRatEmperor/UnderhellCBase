-- ============================================================
-- Volkssturmgewehr — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_volk (TFA WWII Kate)
-- Template: template_selective (Selective-Fire: Semi ↔ Full toggle)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Volkssturmgewehr"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Rifles"

SWEP.Slot = 2
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/volk/c_volk.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/volk/w_volk.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(-1, -2, -0.5)
SWEP.LoweredAng = Vector(-15, 25, -20)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- Fire modes: Semi-Auto AND Full-Auto (toggle with E + Right-Click)
SWEP.FireModes = {
    { name = "Semi-Auto" },
    { name = "Full-Auto" } }

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_VOLK.Lyr1")
SWEP.Primary.SilSound       = Sound("")             -- TFA source has no silenced sound
SWEP.Primary.ClipSize       = 30
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 330                   -- TFA: DefaultClip
SWEP.Primary.MinDamage      = 157.0
SWEP.Primary.MaxDamage      = 157.0
SWEP.Primary.Automatic      = true                  -- base default; FireMode cycling toggles effective behavior
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.015
SWEP.Primary.Delay          = 0.083102               -- 60 / RPM(722)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.4                  -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.3                  -- = -KickDown
SWEP.Primary.KickUp         = 0.4
SWEP.Primary.KickDown       = 0.3
SWEP.Primary.KickHorizontal = 0.2
SWEP.Primary.SpreadMultiplierMax = 6.0
SWEP.Primary.SpreadIncrement    = 1.0
SWEP.Primary.SpreadRecovery     = 6.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-4.19, -3, 1.07)
SWEP.IronSightsAng = Vector(0, 0, 0)
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
SWEP.WorldModelOffset = Vector(15.0, 1.0, -5.6)   -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)   -- (Right→Pitch, Up→Yaw, Forward→Roll)

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
    ["melee_bayonet"]   = "melee_bayonet",
    ["reload_ext"]      = "reload_ext",
    ["reload_ext_empty"] = "reload_ext_empty",
    ["reload_grenade"]  = "reload_grenade" }

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ACT_VM_* keys mapped to string keys per spec.
-- NOTE: lua-type events (AttachGrenade / DetachGrenade calls) are NOT ported —
-- CUH AnimSounds only supports sound events. The grenade bodygroup toggle
-- would need to be re-implemented via a separate AnimEvents system.
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.5000, sound = "TFA_CODWW2_VOLK.Charge" } },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_RIFLE.Raise" } },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_RIFLE.Holster" } },
    ["reload"] = {
        { time = 0.1667, sound = "TFA_CODWW2_VOLK.TacMagOut" },
        { time = 1.0000, sound = "TFA_CODWW2_VOLK.TacMagIn" } },
    ["reload_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_VOLK.MagOut" },
        { time = 1.0000, sound = "TFA_CODWW2_VOLK.MagIn" },
        { time = 2.1667, sound = "TFA_CODWW2_VOLK.Charge" } },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_VOLK.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_VOLK.Inspect2" } },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_VOLK.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_VOLK.Inspect2" } },
    ["inspect_epic"] = {
        { time = 0.0333, sound = "TFA_CODWW2_VOLK.EpicInspect1" },
        { time = 3.5000, sound = "TFA_CODWW2_VOLK.EpicInspect2" } },
    --[Extended Mag]--
    ["reload_ext"] = {
        { time = 0.3333, sound = "TFA_CODWW2_VOLK.TacMagOut" },
        { time = 1.1667, sound = "TFA_CODWW2_VOLK.TacMagIn" } },
    ["reload_ext_empty"] = {
        { time = 0.3333, sound = "TFA_CODWW2_VOLK.MagOut" },
        { time = 1.1667, sound = "TFA_CODWW2_VOLK.MagIn" },
        { time = 2.1667, sound = "TFA_CODWW2_VOLK.Charge" } },
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
-- SMART MUZZLE / SHELL AUTO-DETECT
-- ============================================================
-- WWII models use: tag_flash (muzzle), tag_brass (shell eject), tag_silencer
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
-- THINK
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
-- VELEMENTS / WELEMENTS (ported 1:1 from TFA VElements/WElements)
-- Renames: angle→ang, size→scale, bodygroup→bodygroups
-- Dynamic sight_nydar_lens entry skipped (runtime helper not available in CUH)
-- ============================================================
SWEP.ViewModelElements = {
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/c_volk_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/c_volk_4x.mdl",
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
        type = "Model", model = "models/weapons/tfa_codww2/volk/c_volk_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/c_volk_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/c_volk_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true },
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
        active = false } }

SWEP.WorldModelElements = {
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/w_volk_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/w_volk_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/w_volk_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/volk/w_volk_4x.mdl",
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
-- ============================================================
SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_lens_sight", "tfa_codww2_nydar", "tfa_codww2_4x" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_bayonet" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip" }, default = 0 },
    [7] = { name = "Slot 7", atts = { "tfa_codww2_highcal", "tfa_codww2_rapidfire", "tfa_codww2_fmj" }, default = 0 } }
