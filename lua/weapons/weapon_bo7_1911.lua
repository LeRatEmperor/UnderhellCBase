-- BO7 1911 — Ported from TRM base to CUH base
-- CUH BUILD: v0.6.3-bo7-1911 (2026-10-02)
-- ============================================================
-- Ported from the TRM (TriggerMiku) base to the CUH base.
-- The BO7 1911 is a semi-auto pistol with:
--   - 8-round magazine (default)
--   - 22 attachments across 5 slots (Barrel, Mag, Pistol Grip, Trigger, Muzzle)
--   - Animation-driven ironsights
--   - Camera bone system
--   - Pose-parameter-driven sprint/empty states
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_bo7_1911.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName = "1911"
SWEP.Category = "Black Ops 7: UH"
SWEP.SubCategory = ""

SWEP.Slot = 1
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel  = "models/dqr/bo7/1911/v_1911.mdl"
SWEP.WorldModel = "models/dqr/bo7/1911/w_1911.mdl"
SWEP.LoweredPos = Vector(0, 0, 0)
SWEP.LoweredAng = Vector(0, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "pistol"
SWEP.PassiveAnim = "normal"
SWEP.ZoomFov = 15

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TRM source)
SWEP.Primary.Sound          = Sound("1911_fire")
SWEP.Primary.SilSound       = Sound("1911_fire_s")
SWEP.Primary.ClipSize       = 8
SWEP.Primary.Ammo           = "pistol"
SWEP.Primary.DefaultClip    = 48
SWEP.Primary.MinDamage      = 50
SWEP.Primary.MaxDamage      = 50
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.012
SWEP.Primary.Delay          = 60 / 555
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -2.0
SWEP.Primary.MaxRecoil      = -2.0
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.8
SWEP.Primary.KickHorizontal = 0.2
SWEP.TwoHanded              = false
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = true
SWEP.AnimatedSprint         = true
SWEP.CUHInspectOnMenu       = true

-- Disable the parent base's viewmodel bobbing/breathing.
-- The 1911 uses pose-parameter-driven additive animations for
-- ironsights, sprint, walk, and empty — the parent base's position-
-- based bobbing fights with the pose parameter system and causes
-- a visual "switching between two positions every frame" bug.
SWEP.UseViewBob = false

-- Ironsights — the 1911 uses POSE-PARAMETER-BASED ironsights.
-- The "aim_offset" pose parameter drives a delta blend sequence that
-- smoothly raises the gun to the aim position. IronSightsPos/Ang are
-- zero so the parent base's Sights() function doesn't fight the pose
-- parameter system.
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.25
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 15, -15)

-- ============================================================
-- POSE PARAMETER CONFIG (from TRM source)
-- ============================================================
-- The 1911 model has additive delta blend sequences driven by these
-- pose parameters. They blend ON TOP of the current animation, so
-- they never interrupt fire/reload/idle/inspect. This is how the TRM
-- and MW bases handle ironsights, sprint, empty, and walk — they're
-- all pose-parameter-driven overlay layers.
SWEP.BasePoseParameter = {
    Sprint = { "sprint_loop", "sprint_offset" },
    Empty   = { "empty_offset" },
    Walk    = { "jog_offset", "jog_loop" },
    Aim     = { "aim_offset" },
}

-- Disable the dip system — ironsights are pose-parameter-driven,
-- so the curved dip transition is not needed (the pose parameter
-- handles the smooth transition naturally).
SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 50
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 100
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- No model-based shell ejection — the 1911 model has shell ejection
-- built into the fire animation via QC events (event 9001 MuzzleFlash).
-- Setting NoShell = true prevents the base from trying to load a shell
-- model that doesn't exist (which shows as an error).
SWEP.NoShell  = true
SWEP.ShellHeat = 0.8
SWEP.Shell     = ""

-- Bodygroups (from TRM source)
SWEP.Bodygroups_V = { Body = 0 }

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_last",
    ["reload"]       = "reload",
    ["reload_empty"] = "reload_empty",
    ["iron_fire"]    = "fire",
    ["iron_in"]      = "ads_in",
    ["iron_idle"]    = "idle",
    ["iron_out"]     = "ads_out",
    ["idle"]         = "idle",
    ["idle_empty"]   = "idle_empty",
    ["deploy"]       = "draw",
    ["melee"]        = "melee",
    ["inspect"]      = "inspect",
    ["inspect_empty"] = "inspect_empty",
    ["sprint_idle"]  = "sprint",
    ["sprint_in"]    = "sprint",
    ["sprint_out"]   = "sprint",
}

SWEP.AnimSounds = {}

function SWEP:ShootAnimation()
    if self:Clip1() <= 1 and self.Animations["shoot_last"] then
        return "shoot_last"
    end
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

-- ============================================================
-- IRONSIGHTS / SPRINT / IDLE HANDLERS
-- ============================================================

function SWEP:HandleIronsightsAnimations()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if self:GetUHBool("Running") then
        self.wasZooming = self:GetUHBool("Zooming")
        return
    end
    if self:GetUHBool("Reloading") then return end
    if self._meleeActive then return end
    if self._mantleActive then return end

    local isZooming = self:GetUHBool("Zooming")
    if self.wasZooming == nil then self.wasZooming = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    if self._justExitedSprint then
        self._justExitedSprint = false
        if isZooming then self.wasZooming = false end
        return
    end

    if isZooming and not self.wasZooming then
        self:EasySendWeaponAnim("iron_in", ACT_VM_DEPLOY)
    elseif not isZooming and self.wasZooming then
        self:EasySendWeaponAnim("iron_out", ACT_VM_UNDEPLOY)
    elseif isZooming then
        if vm:GetCycle() >= 1 then
            if self:Clip1() <= 0 and self.Animations["idle_empty"] then
                self:EasySendWeaponAnim("iron_idle", ACT_VM_IDLE_DEPLOYED)
            else
                self:EasySendWeaponAnim("iron_idle", ACT_VM_IDLE_DEPLOYED)
            end
        end
    end
    self.wasZooming = isZooming
end

function SWEP:HandleSprintingAnimations()
    -- The 1911 uses POSE PARAMETERS for sprint (sprint_loop/sprint_offset),
    -- NOT sequence-based sprint animations. The pose parameter is driven by
    -- UpdatePoseParameters() based on the Running bool + velocity.
    -- We do NOT play sprint_in/sprint_out/sprint_idle sequences here —
    -- that would conflict with the pose parameter system and cause jitter.
    -- Just track the state transition for _justExitedSprint (used by
    -- HandleIronsightsAnimations to skip one frame after sprint exit).
    local isRunning = self:GetUHBool("Running")
    if self.wasRunning == nil then self.wasRunning = false end
    if not isRunning and self.wasRunning then
        self._justExitedSprint = true
    end
    self.wasRunning = isRunning
end

function SWEP:HandleIdle()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if self._meleeActive or self._mantleActive then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self:GetUHBool("Zooming") then return end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end
    if vm:GetCycle() < 1 then return end
    -- Check what sequence is currently playing.
    -- Don't restart idle if it's ALREADY playing idle/idle_empty —
    -- restarting causes a visual snap because the jog_loop pose
    -- parameter (realtime delta blend) resets with the sequence.
    local curSeq = string.lower(vm:GetSequenceName(vm:GetSequence()) or "")
    if self:Clip1() <= 0 and self.Animations["idle_empty"] then
        if curSeq ~= "idle_empty" then
            self:EasySendWeaponAnim("idle_empty", ACT_VM_IDLE)
        end
    else
        if curSeq ~= "idle" then
            self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
        end
    end
end

-- ============================================================
-- POSE PARAMETER SYSTEM (self-contained, from TRM base)
-- ============================================================
-- Drives the 1911's pose parameters every frame on the client.
-- This handles ironsights (aim_offset), sprint (sprint_loop/offset),
-- empty (empty_offset), and walk (jog_offset/loop) via delta blend
-- sequences that overlay on top of whatever animation is playing.
--
-- This is a self-contained port of the TRM base's UpdatePoseParameters
-- function. It does NOT require the TRM base to be installed.
-- ============================================================
function SWEP:UpdatePoseParameters()
    if SERVER then return end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end
    if not self.BasePoseParameter then return end

    local owner = self.Owner
    local speed = IsValid(owner) and owner:GetVelocity():Length2D() or 0
    local runSpeed = IsValid(owner) and owner:GetRunSpeed() or 1
    local walkSpeed = IsValid(owner) and owner:GetWalkSpeed() or 1
    local dt = FrameTime()

    -- Aim Pose — drives the aim_offset pose parameter based on ironsight state.
    -- Uses the _ironBlendLat value from the parent base's Sights() function
    -- (which lerps toward 1 when zooming, 0 when not).
    if self.BasePoseParameter.Aim then
        local aimTarget = (self.GetUHBool and self:GetUHBool("Zooming")) and 1 or 0
        self.m_AimPose = Lerp(dt * 20, self.m_AimPose or 0, aimTarget)
        for _, pose in ipairs(self.BasePoseParameter.Aim) do
            vm:SetPoseParameter(pose, self.m_AimPose)
        end
    end

    -- Sprint Pose — drives sprint_loop and sprint_offset.
    -- Active when the player is sprinting (Running bool) and moving.
    if self.BasePoseParameter.Sprint then
        local isRunning = self.GetUHBool and self:GetUHBool("Running")
        local sprintVal = (isRunning and speed > walkSpeed) and 1 or 0
        self.m_SprintPose = Lerp(dt * 10, self.m_SprintPose or 0, sprintVal)
        for _, pose in ipairs(self.BasePoseParameter.Sprint) do
            vm:SetPoseParameter(pose, self.m_SprintPose)
        end
    end

    -- Empty Pose — drives empty_offset.
    -- 1 when the magazine is empty, 0 when there are rounds.
    if self.BasePoseParameter.Empty then
        local emptyTarget = (self:Clip1() <= 0) and 1 or 0
        self.m_EmptyPose = Lerp(dt * 10, self.m_EmptyPose or 0, emptyTarget)
        for _, pose in ipairs(self.BasePoseParameter.Empty) do
            vm:SetPoseParameter(pose, self.m_EmptyPose)
        end
    end

    -- Walk Pose — drives jog_offset and jog_loop.
    -- Active when moving (but not sprinting or aiming).
    if self.BasePoseParameter.Walk then
        local isZooming = self.GetUHBool and self:GetUHBool("Zooming")
        local isRunning = self.GetUHBool and self:GetUHBool("Running")
        local walkVal = 0
        if not isZooming and not isRunning and speed > 1 then
            walkVal = math.Clamp(speed / walkSpeed, 0, 1)
        end
        self.m_WalkPose = Lerp(dt * 10, self.m_WalkPose or 0, walkVal)
        for _, pose in ipairs(self.BasePoseParameter.Walk) do
            vm:SetPoseParameter(pose, self.m_WalkPose)
        end
    end
end

-- ============================================================
-- THINK
-- ============================================================

function SWEP:Think()
    local ct = CurTime()
    local ply = self.Owner
    if IsValid(ply) then
        local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
        local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
        local isInTraversal = isVaulting or isMantling
        if isInTraversal and not self._mantleActive then
            if SERVER or IsFirstTimePredicted() then self:StartMantle() end
        end
        if not isInTraversal and self._mantleActive then self:EndMantle() end
    end
    if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
        self:EndMantle()
    end
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end
    if self._holstering and self._holsterFinish and ct >= self._holsterFinish then
        self._holstering = nil
        self._holsterFinish = nil
        if SERVER or IsFirstTimePredicted() then
            local target = self._holsterTarget
            self._holsterTarget = nil
            if IsValid(target) then self.Owner:SelectWeapon(target:GetClass()) end
        end
    end
    BaseClass.Think(self)
    self:HandleIronsightsAnimations()
    self:HandleSprintingAnimations()
    self:HandleIdle()
    self:HandleInspect()
    -- Drive pose parameters (ironsights, sprint, empty, walk)
    self:UpdatePoseParameters()
end

-- ============================================================
-- MANTLE / INSPECT / ATTACK GUARDS / HOLSTER / DEPLOY
-- ============================================================

function SWEP:StartMantle()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end
    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end
    if self._meleeActive then self:EndMelee() end
    if self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end
    self._mantleActive = true
    self:ClearAnimSounds()
    self:EasySendWeaponAnim("mantle", ACT_VM_MELEE_SHOVE)
    local vm = self.Owner:GetViewModel()
    local dur = IsValid(vm) and vm:SequenceDuration() or 0.6
    self._mantleEndTime = ct + dur
    self:SetNextPrimaryFire(ct + dur)
    self:SetNextSecondaryFire(ct + dur)
    self.NextReload = ct + dur
end

function SWEP:EndMantle()
    self._mantleActive = false
    self._mantleEndTime = nil
    self:ClearAnimSounds()
end

function SWEP:HandleInspect()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then
        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then
            self:SetNW2Bool("Inspecting", true)
            if self:Clip1() <= 0 and self.Animations["inspect_empty"] then
                self:EasySendWeaponAnim("inspect_empty", ACT_VM_FIDGET)
            else
                self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
            end
        end
    end
end

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
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
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._justExitedSprint = false
    return true
end

function SWEP:HandleRunning(ct)
    if self:GetUHBool("Reloading") then return end
    -- NOTE: Removed the fireDelay > 0.3 gate from the M8A1 version.
    -- That gate caused the Running bool to flicker on/off rapidly when
    -- the fire delay was between 0 and 0.3 seconds, which in turn
    -- caused the sprint pose parameter to jitter.
    -- For pose-parameter-driven weapons, the Running bool must be stable.
    local dist = self.Owner:GetVelocity():LengthSqr()
    local isSprinting = self.Owner:KeyDown(IN_SPEED) and dist > self.Owner:GetWalkSpeed()^2
    if isSprinting then
        self:SetHoldType(self.PassiveAnim)
        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", false)
            self.NextReload = ct + 0.5
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove("UHReload_"..self.Owner:SteamID())
            end
        end
    else
        self:SetHoldType(self.HoldType)
        self:SetUHBool("Running", false)
    end
end

-- Override Sights() to do nothing — ironsights are pose-parameter-driven.
-- The parent base's Sights() applies position/angle offsets which would
-- conflict with the pose parameter system. The pose parameter
-- (aim_offset) handles the ironsight transition smoothly via the
-- model's delta blend sequence.
function SWEP:Sights(pos, ang, ft, iftp)
    return pos, ang
end

-- GetViewModelPosition — for pose-parameter-driven weapons, we just
-- call the parent base (which handles Sway/Movement/Inspect/Grenade
-- but skips Sights() because UseViewModelBob = false). We do NOT
-- apply any of our own position offsets (LoweredPos, AlternativePos,
-- RunSightsPos) because those fight with the pose parameter system.
-- The pose parameters handle sprint, ironsights, and empty state.
function SWEP:GetViewModelPosition(pos, ang)
    if BaseClass and BaseClass.GetViewModelPosition then
        return BaseClass.GetViewModelPosition(self, pos, ang)
    end
    return pos, ang
end

-- ============================================================
-- VELEMENTS — attachment models (bonemerged parts)
-- ============================================================

SWEP.ViewModelElements = {
    ["barrel"] = {
        type = "Model", model = "models/dqr/bo7/1911/1911_b_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["mag"] = {
        type = "Model", model = "models/dqr/bo7/1911/1911_m_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["pgrip"] = {
        type = "Model", model = "models/dqr/bo7/1911/1911_p_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["trigger"] = {
        type = "Model", model = "models/dqr/bo7/1911/1911_t_d.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["muzzle"] = {
        type = "Model", model = "",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {}, bonemerge = false,
        active = false, _defaultActive = false,
    },
}

SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)

-- ============================================================
-- ATTACHMENTS
-- ============================================================
-- Ported from TRM's category-based system.
-- TRM slots: Barrel, Mag, PGrip, Trigger, Optic, Muzzle, Laser
-- CUH port:  Barrel, Magazine, Pistol Grip, Trigger, Muzzle
-- (Optic and Laser not ported — no optic/laser models in this addon)

SWEP.Attachments = {
    [1] = { name = "Barrel",      atts = { "bo7_1911_barrel_d", "bo7_1911_barrel_h", "bo7_1911_barrel_m", "bo7_1911_barrel_s", "bo7_1911_barrel_v" }, default = 1 },
    [2] = { name = "Magazine",    atts = { "bo7_1911_mag_d", "bo7_1911_mag_e1", "bo7_1911_mag_e2", "bo7_1911_mag_f" }, default = 1 },
    [3] = { name = "Pistol Grip", atts = { "bo7_1911_pgrip_d", "bo7_1911_pgrip_c", "bo7_1911_pgrip_l", "bo7_1911_pgrip_q", "bo7_1911_pgrip_r", "bo7_1911_pgrip_t" }, default = 1 },
    [4] = { name = "Trigger",     atts = { "bo7_1911_tr_d", "bo7_1911_tr_f" }, default = 1 },
    [5] = { name = "Muzzle",      atts = { "bo7_1911_muz_b", "bo7_1911_muz_c", "bo7_1911_muz_m", "bo7_1911_muz_s" }, default = 0 },
    [6] = { name = "Misc",        atts = { "bo7_1911_misc_pos" }, default = 0 },
}