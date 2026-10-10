-- ============================================================
-- M1879 Reichsrevolver — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_m1879 (TFA WWII Kate)
-- Template: template_revolver_sg (Revolver Shotgun — Type 7)
-- ============================================================
-- Single-action revolver with shell-by-shell reload. Has NO pump
-- rechamber (semi-auto trigger, one round per trigger pull). The
-- cylinder is reloaded one cartridge at a time via the shotgun-reload
-- pattern (start → loop × N → finish).
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Reichsrevolver"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Pistols"

SWEP.Slot = 1
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/m1879/c_m1879.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/m1879/w_m1879.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(2, -11, -10)
SWEP.LoweredAng = Vector(60, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "pistol"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_M1879.Shoot")
SWEP.Primary.SilSound       = Sound("TFA_CODWW2_SUPP.Pistol")   -- Primary.SilencedSound
SWEP.Primary.ClipSize       = 6
SWEP.Primary.Ammo           = "357"
SWEP.Primary.DefaultClip    = 66
SWEP.Primary.MinDamage      = 650.0
SWEP.Primary.MaxDamage      = 650.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1                              -- AmmoConsumption
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.01                            -- Primary.Spread
SWEP.Primary.Delay          = 0.175439                       -- 60 / RPM(342)
SWEP.Primary.NumberofShots  = 1                              -- NumShots
SWEP.Primary.MinRecoil      = -0.6                           -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.5                           -- = -KickDown
SWEP.Primary.KickUp         = 0.6
SWEP.Primary.KickDown       = 0.5
SWEP.Primary.KickHorizontal = 0.1
SWEP.Primary.SpreadMultiplierMax = 7.5
SWEP.Primary.SpreadIncrement    = 3.0
SWEP.Primary.SpreadRecovery     = 6.0
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true          

-- Shotgun config (shell reload, but NO pump)
SWEP.Shotgun = true
SWEP.IsPump = false         -- ← KEY DIFFERENCE: no pump rechamber
SWEP.Primary.ReloadTime = 0.4     -- per-shell insertion time (template default)

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-4.07, -3, 1.05)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.2
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
SWEP.MuzzleAttachment = "1"   -- tag_flash (TFA: MuzzleAttachment = "1")
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (from TFA Secondary.Bash*)
SWEP.MeleeDamage    = 35            -- BashDamage
SWEP.MeleeRange     = 40            -- BashLength
SWEP.MeleeDelay     = 0.2           -- BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingPstl"   -- BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}        -- BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (from TFA LuaShell*)
-- model handles its own shell ejection
SWEP.NoShell   = true
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_9mm.mdl"   -- LuaShellModel

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(14.3, 1.0, -6.65)   -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)    -- (Right→Pitch, Up→Yaw, Forward→Roll)

-- ============================================================
-- ANIMATIONS (template defaults + TFA source custom animations)
-- TFA source defines only SprintAnimation (sequences); other entries
-- use template defaults. Sprint seq names: sprint_in/_loop/_out (+_empty).
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
    ["start_reload"]  = "reload_start",
    ["reload_loop"]   = "reload_loop",
    ["after_reload"]  = "reload_end",
    ["start_reload"]  = "reload_start",
    ["after_reload"] = "reload_end",
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]    = "sprint_in",
    ["sprint_out"]   = "sprint_out",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ACT_VM_* keys mapped to string keys per spec; string keys kept as-is.
-- Only "sound" type entries are ported (no "lua" type entries exist).
-- ============================================================
SWEP.AnimSounds = {
    ["fire"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["fire_ads"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["draw"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["start_reload"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Open" },
        { time = 0.5000, sound = "TFA_CODWW2_M1879.Insert" },
    },
    ["reload_loop"] = {
        { time = 0.0000, sound = "TFA_CODWW2_M1879.Insert" },
    },
    ["after_reload"] = {
        { time = 0.0000, sound = "TFA_CODWW2_M1879.Close" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1879.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_M1879.Inspect2" },
    },
    -- [Tac Knife attachment variants] --
    ["fire_knife"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["fire_knife_ads"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["draw_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["holster_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["reload_in_knife"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Open" },
        { time = 0.5000, sound = "TFA_CODWW2_M1879.Insert" },
    },
    ["reload_knife"] = {
        { time = 0.0000, sound = "TFA_CODWW2_M1879.Insert" },
    },
    ["reload_out_knife"] = {
        { time = 0.0000, sound = "TFA_CODWW2_M1879.Close" },
    },
    ["inspect_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1879.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_M1879.Inspect2" },
    },
}

-- ============================================================
-- SHOTGUN SHELL-BY-SHELL RELOAD (same as template_revolver_sg)
-- ============================================================

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

    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

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

function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

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

SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
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
    -- NOTE: No PostShoot override — no pump rechamber
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

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
-- WElements use w_ prefixed models (already w_ in TFA source).
-- ============================================================
SWEP.ViewModelElements = {
    ["suppressor"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/suppressors/c_pistol_suppressor.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["tac_knife"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/tacknife/c_combatknife.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["grip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_grip.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["suppressor"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/suppressors/w_pistol_suppressor.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["tac_knife"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/tacknife/w_combatknife.mdl",
        bone = "ValveBiped.Bip01_L_Hand", pos = Vector(3, 1.5, 0), ang = Angle(-20, 90, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = false,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/w_m1879_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/w_m1879_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["grip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/w_m1879_grip.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments, CUH format with default=0)
-- ============================================================
SWEP.Attachments = {
    [1] = { name = "Slot 1", atts = { "tfa_codww2_supp_pistol" }, default = 0 },
    [2] = { name = "Slot 2", atts = { "tfa_codww2_knife" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag_noani" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim", "tfa_codww2_quickdraw" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_highcal", "tfa_codww2_fmj" }, default = 0 },
}
