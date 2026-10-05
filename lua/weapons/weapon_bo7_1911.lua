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
SWEP.AnimatedSprint         = false
SWEP.CUHInspectOnMenu       = true

-- Ironsights — from TRM source: Sight.Pos = Vector(0, 2, 0.05), Angles = Angle(0, 90, 90)
-- These are the default pistol iron sight positions.
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.25
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 15, -15)

-- TFA-style curved ironsight dip
SWEP.IronSightsDipPos   = Vector(0, -1.5, -2.0)
SWEP.IronSightsDipAng   = Angle(3, 0, 0)
SWEP.IronSightsDipScale = 0

SWEP.BasePoseParameter = {
    Sprint = { "sprint_loop", "sprint_offset" },
    Empty  = { "empty_offset" },
    Walk    = { "jog_offset", "jog_loop" },
    Aim     = { "aim_offset" },
}

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

SWEP.NoShell  = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/shells/shell_pistol.mdl"

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

-- ============================================================
-- POSE PARAMETER SYSTEM (self-contained, from TRM base)
-- ============================================================
function SWEP:UpdatePoseParameters()
    if SERVER then return end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end
    if not self.BasePoseParameter then return end

    local owner = self.Owner
    local speed = IsValid(owner) and owner:GetVelocity():Length2D() or 0
    local walkSpeed = IsValid(owner) and owner:GetWalkSpeed() or 1
    local dt = FrameTime()

    -- Aim Pose
    if self.BasePoseParameter.Aim then
        local aimTarget = (self.GetUHBool and self:GetUHBool("Zooming")) and 1 or 0
        self.m_AimPose = Lerp(dt * 20, self.m_AimPose or 0, aimTarget)
        for _, pose in ipairs(self.BasePoseParameter.Aim) do
            vm:SetPoseParameter(pose, self.m_AimPose)
        end
    end

    -- Sprint Pose
    if self.BasePoseParameter.Sprint then
        local isRunning = self.GetUHBool and self:GetUHBool("Running")
        local sprintVal = (isRunning and speed > walkSpeed) and 1 or 0
        self.m_SprintPose = Lerp(dt * 10, self.m_SprintPose or 0, sprintVal)
        for _, pose in ipairs(self.BasePoseParameter.Sprint) do
            vm:SetPoseParameter(pose, self.m_SprintPose)
        end
    end

    -- Empty Pose
    if self.BasePoseParameter.Empty then
        local emptyTarget = (self:Clip1() <= 0) and 1 or 0
        self.m_EmptyPose = Lerp(dt * 10, self.m_EmptyPose or 0, emptyTarget)
        for _, pose in ipairs(self.BasePoseParameter.Empty) do
            vm:SetPoseParameter(pose, self.m_EmptyPose)
        end
    end

    -- Walk Pose
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

function SWEP:HandleSprintingAnimations()
    -- 1911 uses pose parameters for sprint, not sequences.
    -- Just track the state transition for _justExitedSprint.
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
    if self:Clip1() <= 0 and self.Animations["idle_empty"] then
        self:EasySendWeaponAnim("idle_empty", ACT_VM_IDLE)
    else
        self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
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
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end
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

-- Override Sights() — pose parameters handle ironsights
function SWEP:Sights(pos, ang, ft, iftp)
    return pos, ang
end

-- Override Movement() — pose parameters handle walk bob.
-- The parent base's position-based bob conflicts with jog_loop.
function SWEP:Movement(pos, ang, ct, ft, iftp)
    return pos, ang
end

function SWEP:GetViewModelPosition(pos, ang)
    local ft = FrameTime()
    if BaseClass and BaseClass.GetViewModelPosition then
        pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    end
    local target = 0
    if self:GetNWInt("FireMode") == 0 and not self:GetUHBool("Running") then target = 1 end
    self._uhLower = Lerp(ft * 8, self._uhLower or 0, target)
    if self._uhLower > 0.001 then
        local lp = self.LoweredPos or vector_origin
        local la = self.LoweredAng or angle_zero
        local ap, ay, ar = 0, 0, 0
        if isangle(la) then ap, ay, ar = la.p, la.y, la.r
        elseif isvector(la) then ap, ay, ar = la.x, la.y, la.z end
        ang:RotateAroundAxis(ang:Right(), ap * self._uhLower)
        ang:RotateAroundAxis(ang:Up(), ay * self._uhLower)
        ang:RotateAroundAxis(ang:Forward(), ar * self._uhLower)
        pos = pos + ang:Right() * lp.x * self._uhLower
            + ang:Forward() * lp.y * self._uhLower
            + ang:Up() * lp.z * self._uhLower
    end
    local targetAlt = 1
    if self:GetUHBool("Running") or self:GetUHBool("Zooming") or self:GetNWInt("FireMode") == 0 then
        targetAlt = 0
    end
    self._altFactor = Lerp(ft * 10, self._altFactor or 0, targetAlt)
    if (self.AlternativePos or self.AlternativeAng) and self._altFactor > 0.01 then
        local ap = self.AlternativePos or vector_origin
        local aa = self.AlternativeAng or angle_zero
        pos = pos + ang:Right() * ap.x * self._altFactor
            + ang:Forward() * ap.y * self._altFactor
            + ang:Up() * ap.z * self._altFactor
        local ap_p, ap_y, ap_r = 0, 0, 0
        if isangle(aa) then ap_p, ap_y, ap_r = aa.p, aa.y, aa.r
        elseif isvector(aa) then ap_p, ap_y, ap_r = aa.x, aa.y, aa.z end
        ang:RotateAroundAxis(ang:Right(), ap_p * self._altFactor)
        ang:RotateAroundAxis(ang:Up(), ap_y * self._altFactor)
        ang:RotateAroundAxis(ang:Forward(), ap_r * self._altFactor)
    end
    local targetSprint = self:GetUHBool("Running") and 1 or 0
    self._sprintFactor = Lerp(ft * 10, self._sprintFactor or 0, targetSprint)
    if self._sprintFactor > 0.01 then
        local sp = self.RunSightsPos or vector_origin
        local sa = self.RunSightsAng or angle_zero
        local sf = self._sprintFactor
        pos = pos + ang:Right() * sp.x * sf
            + ang:Forward() * sp.y * sf
            + ang:Up() * sp.z * sf
        local sp_p, sp_y, sp_r = 0, 0, 0
        if isangle(sa) then sp_p, sp_y, sp_r = sa.p, sa.y, sa.r
        elseif isvector(sa) then sp_p, sp_y, sp_r = sa.x, sa.y, sa.z end
        ang:RotateAroundAxis(ang:Right(), sp_p * sf)
        ang:RotateAroundAxis(ang:Up(), sp_y * sf)
        ang:RotateAroundAxis(ang:Forward(), sp_r * sf)
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
