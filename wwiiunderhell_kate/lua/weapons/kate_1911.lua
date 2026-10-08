-- ============================================================
-- 1911 — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_1911 (TFA WWII Kate Starting Pistols)
-- Template: template_semi (Semi-Auto)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "1911"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Pistols"

SWEP.Slot = 1
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/1911/c_1911.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/1911/w_1911.mdl"
-- SafetyPos / SafetyAng from TFA source → CUH LoweredPos / LoweredAng
SWEP.LoweredPos = Vector(2, -11, -10)
SWEP.LoweredAng = Vector(60, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "pistol"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- Fire mode
SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_1911.Main")
SWEP.Primary.SilSound       = Sound("TFA_CODWW2_SUPP.Pistol")
SWEP.Primary.ClipSize       = 8
SWEP.Primary.Ammo           = "pistol"
SWEP.Primary.DefaultClip    = 40          -- TFA: ClipSize * 5
SWEP.Primary.MinDamage      = 10.0
SWEP.Primary.MaxDamage      = 10.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.02
SWEP.Primary.Delay          = 0.089552    -- 60 / RPM(670)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.5        -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.3        -- = -KickDown
SWEP.Primary.KickUp         = 0.5
SWEP.Primary.KickDown       = 0.3
SWEP.Primary.KickHorizontal = 0.15
SWEP.Primary.SpreadMultiplierMax = 4.0
SWEP.Primary.SpreadIncrement    = 1.5
SWEP.Primary.SpreadRecovery     = 5.0
SWEP.TwoHanded              = false
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true       

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-4.08, -3, 0.8)
SWEP.IronSightsAng = Vector(0.8, 0, 0)
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
SWEP.MuzzleAttachment = "2"  -- tag_flash (auto-detected by GetMuzzle)
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (from TFA Secondary.Bash*)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 40
SWEP.MeleeDelay     = 0.2          -- BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingPstl"     -- BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}           -- BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (from TFA LuaShell*)
SWEP.NoShell   = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_9mm.mdl"   -- LuaShellModel

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(14.9, 1.0, -6.3)   -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)   -- (Right→Pitch, Up→Yaw, Forward→Roll)

-- ============================================================
-- ANIMATIONS (template defaults + TFA source custom animations)
-- TFA source uses sequence names (strings) — keep as string.
-- "ACT_VM_RELOAD" / "ACT_VM_RELOAD_EMPTY" are kept as strings per template.
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
    ["reload_ext_knife"]       = "reload_ext_knife",
    ["reload_ext_knife_empty"] = "reload_ext_knife_empty",
    ["reload_ext"]             = "reload_ext",
    ["reload_ext_empty"]       = "reload_ext_empty",
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 → seconds)
-- ACT_VM_* keys mapped to string keys per spec.
-- ============================================================
SWEP.AnimSounds = {
    ["draw"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["draw_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["draw_midempty_dw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["draw_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["draw_knife_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["holster_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["holster_midempty_dw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["holster_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["holster_knife_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["fire_last"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.MechEmpty" },
    },
    ["reload"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.TacMagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.TacMagIn" },
    },
    ["reload_empty"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.Charge" },
    },
    ["reload_dw"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.TacMagOut_R" },
        { time = 0.5000, sound = "TFA_CODWW2_1911.TacMagOut_L" },
        { time = 1.1667, sound = "TFA_CODWW2_1911.TacMagIn_R" },
        { time = 1.3333, sound = "TFA_CODWW2_1911.TacMagIn_L" },
    },
    ["reload_midempty_dw"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.TacMagOut_R" },
        { time = 0.5000, sound = "TFA_CODWW2_1911.TacMagOut_L" },
        { time = 1.1667, sound = "TFA_CODWW2_1911.TacMagIn_R" },
        { time = 1.3333, sound = "TFA_CODWW2_1911.TacMagIn_L" },
        { time = 2.0667, sound = "TFA_CODWW2_1911.Charge_R" },
    },
    ["reload_empty_dw"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut_L" },
        { time = 0.5000, sound = "TFA_CODWW2_1911.MagOut_R" },
        { time = 1.1667, sound = "TFA_CODWW2_1911.MagIn_L" },
        { time = 1.3333, sound = "TFA_CODWW2_1911.MagIn_R" },
        { time = 2.0000, sound = "TFA_CODWW2_1911.Charge_L" },
        { time = 2.0667, sound = "TFA_CODWW2_1911.Charge_R" },
    },
    ["reload_knife"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
    },
    ["reload_knife_empty"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.Charge" },
    },
    ["reload_ext"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
    },
    ["reload_ext_empty"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.Charge" },
    },
    ["reload_ext_knife"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
    },
    ["reload_ext_knife_empty"] = {
        { time = 0.3333, sound = "TFA_CODWW2_1911.MagOut" },
        { time = 0.8333, sound = "TFA_CODWW2_1911.MagIn" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.Charge" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_epic"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.EpicInspect1" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.EpicInspect2" },
    },
    ["inspect_midempty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_silenced"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.EpicInspect1" },
        { time = 1.5000, sound = "TFA_CODWW2_1911.EpicInspect2" },
    },
    ["inspect_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_1911.Inspect2" },
    },
    ["inspect_knife_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_1911.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_1911.Inspect2" },
    },
}

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
-- WorldModelElements uses the w_ prefixed models from TFA WElements
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
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["grip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_grip.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["slide_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_slide.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    --[Leftist / akimbo]--
    ["clip_left"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_clip_l.mdl",
        bone = "tag_clip1", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["grip_left"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_grip_l.mdl",
        bone = "tag_weapon1", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["receiver_left"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_receiver_l.mdl",
        bone = "tag_weapon1", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["slide_left"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/c_1911_slide_l.mdl",
        bone = "tag_weapon1", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
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
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["grip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_grip.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["slide_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_slide.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    --[Leftist / akimbo]--
    ["gun_left"] = {
        type = "Model", model = "models/weapons/tfa_codww2/1911/w_1911_l.mdl",
        bone = "ValveBiped.Bip01_L_Hand", pos = Vector(15.5, 1.2, 4), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = false,
        active = false,
    },
}

-- ============================================================
-- ATTACHMENTS (from TFA SWEP.Attachments, CUH format with default=0)
-- ============================================================
SWEP.Attachments = {
    [1] = { name = "Slot 1", atts = { "tfa_codww2_supp_pistol" }, default = 0 },
    [2] = { name = "Slot 2", atts = { "tfa_codww2_knife" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim", "tfa_codww2_quickdraw" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_highcal", "tfa_codww2_fmj" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_akimbo" }, default = 0 },
}
