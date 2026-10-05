-- XM4 (Black Ops 6) — Ported from TFA to CUH base
-- Inherits from weapon_cuh_base_gun (which adds customization)
-- Uses animation-driven ironsights. No sprint animation (same as M8A1).
-- CUH BUILD: v0.6.0-xm4-port (2026-10-02)

AddCSLuaFile()

print("[CUH] weapon_xm4_bo6.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName = "XM4"
SWEP.Category = "Black Ops 7: UH"
SWEP.SubCategory = ""

SWEP.Slot = 2
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 75
SWEP.ViewModel  = "models/weapons/v_xm4_v.mdl"
SWEP.WorldModel = "models/weapons/w_xm4_w.mdl"
SWEP.LoweredPos = Vector(2.614, -5.292, -0.304)
SWEP.LoweredAng = Vector(-9.473, 29.982, -14.617)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "smg"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 15

SWEP.FireModes = {
    { name = "Full-Auto" },
    { name = "Semi-Auto" },
}

SWEP.Primary.Sound          = Sound("bo6_xm4_fire")
SWEP.Primary.ClipSize       = 30
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 90
SWEP.Primary.MinDamage      = 26
SWEP.Primary.MaxDamage      = 26
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.04
SWEP.Primary.Delay          = 60 / 700
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.3
SWEP.Primary.MaxRecoil      = -0.2
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.2
SWEP.Primary.KickHorizontal = 0.25
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint         = false
SWEP.CUHInspectOnMenu       = true

SWEP.IronSightsPos = Vector(-0.025, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.45
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 15, -15)

-- TFA-style curved ironsight dip
SWEP.IronSightsDipPos   = Vector(0, -1.5, -2.0)
SWEP.IronSightsDipAng   = Angle(3, 0, 0)
SWEP.IronSightsDipScale = 1.0

-- Camera bone system: uses the "camera" $attachment on v_xm4_v.mdl
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 300
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.NoShell  = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/dqr/bo6/xm4/545s.mdl"

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "ACT_VM_PRIMARYATTACK",
    ["reload"]       = "ACT_VM_RELOAD",
    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
    ["iron_fire"]    = "iron_fire",
    ["iron_in"]      = "ads_in",
    ["iron_idle"]    = "iron_idle",
    ["iron_out"]     = "ads_out",
    ["idle"]         = "ACT_VM_IDLE",
    ["deploy"]       = "ACT_VM_DRAW_DEPLOYED",
    ["melee"]        = "ACT_VM_MELEE",
    ["inspect"]      = "ACT_VM_FIDGET",
    ["mantle"]       = "ACT_VM_MELEE_SHOVE",
    ["sprint_idle"]  = "ACT_VM_SPRINT_IDLE",
    ["sprint_in"]    = "ACT_VM_SPRINT_ENTER",
    ["sprint_out"]   = "ACT_VM_SPRINT_LEAVE",
}

SWEP.AnimSounds = {}

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
-- IRONSIGHTS ANIMATION HANDLER (with sprint-conflict fix)
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
            self:EasySendWeaponAnim("iron_idle", ACT_VM_IDLE_DEPLOYED)
        end
    end
    self.wasZooming = isZooming
end

-- ============================================================
-- SPRINTING ANIMATION HANDLER
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
        self._justExitedSprint = true
    elseif isRunning and not self:GetUHBool("Reloading") then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end
    self.wasRunning = isRunning
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
    self:HandleInspect()
end

-- ============================================================
-- MANTLE
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
            self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
        end
    end
end

-- ============================================================
-- ATTACK GUARDS
-- ============================================================

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
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._justExitedSprint = false
    return true
end

-- ============================================================
-- HANDLE RUNNING
-- ============================================================

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

-- ============================================================
-- GET VIEW MODEL POSITION
-- ============================================================

function SWEP:GetViewModelPosition(pos, ang)
    local ft = FrameTime()
    if BaseClass and BaseClass.GetViewModelPosition then
        pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    end
    -- Safe mode lowering
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
    -- Alternative pos/ang
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
    -- Sprint position (procedural, not animation-based)
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
        type = "Model", model = "models/dqr/bo6/xm4/xm4_bar_def.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[2]=1, [1]=1}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["mag"] = {
        type = "Model", model = "models/dqr/bo6/xm4/xm4_mag_30.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=1}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["default_stock"] = {
        type = "Model", model = "models/dqr/bo6/xm4/xm4_stock_def.mdl",
        bone = "", pos = Vector(0,0.1,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=0}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["pgrip"] = {
        type = "Model", model = "models/dqr/bo6/xm4/xm4_psg_def.mdl",
        bone = "", pos = Vector(0,0,0), ang = Angle(0,0,0),
        scale = Vector(1,1,1), material = "", skin = 0,
        bodygroups = {[1]=0}, bonemerge = true,
        active = true, _defaultActive = true,
    },
}

SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)

SWEP.Bodygroups_V = { [2] = 1 }

-- ============================================================
-- ATTACHMENTS — default configuration
-- ============================================================
--   1: Magazine → default = xm4_smag (30 Round)
--   2: Barrel   → default = xm4_bar_h1 (Short)
--   3: Pistol Grip → default = xm4_p_m (Medium)
--   4: Stock    → default = xm4_stock_f1 (Full)
--   5: Muzzle   → NO default
--   6: Optic    → default = xm4_sight (Default Ironsight)

SWEP.Attachments = {
    [1] = { name = "Magazine",    atts = { "xm4_smag", "xm4_xmag", "xm4_xmag2", "xm4_xmag3" }, default = 1 },
    [2] = { name = "Barrel",      atts = { "xm4_bar_h1", "xm4_bar_h2", "xm4_bar_m1", "xm4_bar_r1", "xm4_bar_v1" }, default = 1 },
    [3] = { name = "Pistol Grip", atts = { "xm4_p_m", "xm4_p_q1", "xm4_p_q2", "xm4_p_s1", "xm4_p_s2" }, default = 1 },
    [4] = { name = "Stock",       atts = { "xm4_stock_f1", "xm4_stock_b1", "xm4_stock_l1", "xm4_stock_m1", "xm4_stock_m2" }, default = 1 },
    [5] = { name = "Muzzle",      atts = {} },
    [6] = { name = "Optic",       atts = { "xm4_sight" }, default = 1 },
}
