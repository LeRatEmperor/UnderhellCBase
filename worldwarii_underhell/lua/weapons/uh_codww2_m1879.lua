-- Reichsrevolver — Ported from TFA WWII to CUH base
-- CUH BUILD: v1.0-wwii (2026-10-07)
-- Original: nz_kate_codww2_m1879
-- SubCategory: Pistols

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName = "Reichsrevolver"
SWEP.Category = "WWII"
SWEP.SubCategory = "Pistols"

SWEP.Slot = 1
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/m1879/c_m1879.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/m1879/w_m1879.mdl"
SWEP.LoweredPos = Vector(2, -11, -10)
SWEP.LoweredAng = Vector(60, 0, 0)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "pistol"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 25

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_M1879.Shoot")
SWEP.Primary.SilSound       = Sound("TFA_CODWW2_SUPP.Pistol")
SWEP.Primary.ClipSize       = 6
SWEP.Primary.Ammo           = "357"
SWEP.Primary.DefaultClip    = 30
SWEP.Primary.MinDamage      = 650.0
SWEP.Primary.MaxDamage      = 650.0
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.01
SWEP.Primary.Delay          = 0.175439
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.6
SWEP.Primary.MaxRecoil      = -0.5
SWEP.Primary.KickUp         = 0.6
SWEP.Primary.KickDown       = 0.5
SWEP.Primary.KickHorizontal = 0.1
SWEP.Primary.SpreadMultiplierMax = 7.5
SWEP.Primary.SpreadIncrement    = 3.0
SWEP.Primary.SpreadRecovery     = 6.0
SWEP.TwoHanded              = false
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.Shotgun = true  -- shotgun reload mechanics
SWEP.AnimatedSprint         = true
SWEP.CUHInspectOnMenu       = true

SWEP.IronSightsPos = Vector(-4.07, -3, 1.05)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- TFA-style curved ironsight dip
SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleAttachment = "2"  -- tag_flash on WWII models
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 40
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.NoShell  = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_9mm.mdl"

-- World model positioning (from TFA Offset)
SWEP.WorldModelOffset = Vector(14.3, 1.0, -6.65)
SWEP.WorldModelAngle = Angle(190.0, 180.0, 0.0)

-- ============================================================
-- ANIMATIONS
-- ============================================================
SWEP.Animations = {
    ["shoot"]        = "fire",
    ["shoot_last"]   = "fire_last",
    ["fire_ads"]     = "fire_ads",
    ["shoot_last"]   = "ACT_VM_PRIMARYATTACK",
    ["rechamber"]    = "rechamber",  -- pump action
    ["reload"]       = "ACT_VM_RELOAD",
    ["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
    ["start_reload"]   = "reload_start",
    ["reload_loop"]    = "reload_loop",
    ["after_reload"]   = "reload_end",
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
    ["sprint_idle"]  = "sprint_loop",
    ["sprint_in"]     = "sprint_in",
    ["sprint_out"]    = "sprint_out",
}

SWEP.AnimSounds = {
    ["draw"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["draw_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Raise" },
    },
    ["fire"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["fire_ads"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["fire_knife"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["fire_knife_ads"] = {
        { time = 0.1667, sound = "TFA_CODWW2_M1879.Hammer" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["holster_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_PSTL.Holster" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1879.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_M1879.Inspect2" },
    },
    ["inspect_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_M1879.Inspect1" },
        { time = 1.8333, sound = "TFA_CODWW2_M1879.Inspect2" },
    },
    ["reload"] = {
        { time = 0.0000, sound = "TFA_CODWW2_M1879.Insert" },
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
}

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
-- IRONSIGHTS / SPRINT / IDLE HANDLERS
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
    self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
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
-- THINK
-- ============================================================

-- WWII models use attachment "2" (tag_flash) for muzzle,
-- "0" (tag_brass) for shell eject, "1" (tag_silencer) for silenced
function SWEP:GetMuzzle()
    return 2  -- tag_flash
end

function SWEP:GetShellEject()
    return 0  -- tag_brass
end

-- ============================================================
-- SHOTGUN RELOAD — shell-by-shell insertion
-- ============================================================
SWEP.IsPump = true
SWEP.PumpDelay = 0.5
SWEP.Primary.ReloadTime = 0.5

function SWEP:Reload()
    local ct = CurTime()
    if not IsValid(self.Owner) then return end
    
    -- If already reloading, handle shotgun loop
    if self:GetUHBool("Reloading") then
        -- Stop conditions
        if self:Clip1() >= self.Primary.ClipSize
           or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0
           or self.Owner:KeyPressed(IN_ATTACK) then
            -- Finish reload
            self:EasySendWeaponAnim("reload_end", ACT_SHOTGUN_RELOAD_FINISH)
            local vm = self.Owner:GetViewModel()
            local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8
            self:SetUHBool("Reloading", false)
            self:SetNWFloat("ReloadTime", 0)
            self:SetNWFloat("ReloadEndTime", 0)
            self:SetNextPrimaryFire(ct + endDur)
            self:SetNextSecondaryFire(ct + endDur)
            self.NextReload = ct + endDur
            return
        end
        -- Insert next shell
        if not self._nextShellTime or ct >= self._nextShellTime then
            self._nextShellTime = ct + (self.Primary.ReloadTime or 0.5)
            self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
            self:SetNextPrimaryFire(self._nextShellTime)
        end
        return
    end
    
    -- Start shotgun reload
    if self.NextReload < ct and not self:GetUHBool("Running")
       and self:GetNWFloat("DeployTime") < ct then
        if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and self:Clip1() < self.Primary.ClipSize then
            self.Owner:DoReloadEvent()
            self.NextReload = ct + 0.5
            self._nextShellTime = ct + (self.Primary.ReloadTime or 0.5)
            self:EasySendWeaponAnim("reload_start", ACT_SHOTGUN_RELOAD_START)
            self:SetNextPrimaryFire(ct + 0.5)
            self:SetNextSecondaryFire(ct + 0.5)
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
        end
    end
end

-- Override PostShoot for pump action
function SWEP:PostShoot()
    if not self.IsPump then return end
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.5
    -- Lock fire for at least pumpDelay (but never shorten a longer Primary.Delay)
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

-- Override PrimaryAttack for pump after fire
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
    BaseClass.PrimaryAttack(self)
    self:PostShoot()
end

function SWEP:Think()
    local ct = CurTime()
    BaseClass.Think(self)
    self:HandleSprintingAnimations()
    self:HandleIdle()
    self:HandleInspect()
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
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
-- VELEMENTS
-- ============================================================

SWEP.ViewModelElements = {
    ["suppressor"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/suppressors/c_pistol_suppressor.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false, _defaultActive = false,
    },
    ["tac_knife"] = {
        type = "Model", model = "models/weapons/tfa_codww2/attachments/tacknife/c_combatknife.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false, _defaultActive = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false, _defaultActive = false,
    },
    ["grip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/m1879/c_m1879_grip.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true, _defaultActive = true,
    },
}

SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)

-- ============================================================
-- ATTACHMENTS — all slots allow "None" (default = 0)
-- ============================================================

SWEP.Attachments = {
    [1] = { name = "Slot 1", atts = { "tfa_codww2_supp_pistol" }, default = 0 },
    [2] = { name = "Slot 2", atts = { "tfa_codww2_knife" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag_noani" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim", "tfa_codww2_quickdraw" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_highcal", "tfa_codww2_fmj" }, default = 0 },
}

-- ============================================================
-- SHOTGUN SHELL-BY-SHELL RELOAD
-- ============================================================
SWEP.Shotgun = true
SWEP.ShellLoadTime = SWEP.ShellLoadTime or 0.5

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
        self.reloaddelay = nil
        if self.PostReload then self:PostReload() end
        return
    end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) and vm:GetCycle() >= 1 then
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
    end
end

-- CustomThink: dispatches ReloadShotgun every tick while reloading
SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
    end
end
