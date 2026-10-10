-- ============================================================
-- LAD Machine Gun — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_lad (TFA WWII Kate)
-- Template: template_auto (Full-Auto)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "LAD Machine Gun"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Light Machine Guns"

SWEP.Slot = 3
SWEP.Spawnable = true

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/lad/c_lad.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/lad/w_lad.mdl"
SWEP.LoweredPos = Vector(1, -1, -0.5)
SWEP.LoweredAng = Vector(-20, 35, -25)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
    { name = "Full-Auto" },
}

SWEP.Primary.Sound          = Sound("TFA_CODWW2_MG42.High")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 50
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 550
SWEP.Primary.MinDamage      = 190.0
SWEP.Primary.MaxDamage      = 190.0
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.03
SWEP.Primary.Delay          = 0.110092     -- 60 / RPM(545)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.3
SWEP.Primary.MaxRecoil      = -0.3
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.3
SWEP.Primary.KickHorizontal = 0.15
SWEP.Primary.SpreadMultiplierMax = 5.0
SWEP.Primary.SpreadIncrement    = 0.65
SWEP.Primary.SpreadRecovery     = 4.5
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

SWEP.IronSightsPos = Vector(-2.6, 0, 0.6)
SWEP.IronSightsAng = Vector(0, 0, 0)
-- Reticle texture for 4x ACOG RT scope
SWEP.ScopeReticle = "scopes/scope_overlay_mp"

-- ACOG ironsight position (from TFA source)
SWEP.IronSightsPos_ACOG = Vector(-1.465, -3, 0.26)
SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)

-- NYDAR ironsight position (from TFA source)
SWEP.IronSightsPos_NYDAR = Vector(-2.61, -3, 1.015)
SWEP.IronSightsAng_NYDAR = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

SWEP.MuzzleAttachment = "2"
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 50
SWEP.MeleeDelay     = 0.2
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingLrg"
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.NoShell   = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_9mm.mdl"

SWEP.WorldModelOffset = Vector(13.9, 1.0, -5.75)
SWEP.WorldModelAngle  = Angle(190.0, 180.0, 0.0)

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
    -- Custom
    ["reload_knife"]      = "reload_knife",
    ["reload_knife_empty"] = "reload_knife_empty",
    ["inspect_knife"]     = "inspect_knife",
    ["inspect_knife_empty"] = "inspect_knife_empty",
    ["inspect_epic"]      = "inspect_epic",
    ["draw_first_knife"]  = "draw_first_knife",
    ["draw_knife"]        = "draw_knife",
    ["draw_knife_empty"]  = "draw_knife_empty",
    ["holster_knife"]     = "holster_knife",
    ["holster_knife_empty"] = "holster_knife_empty",
}

-- ============================================================
-- ANIMSOUNDS — lua-type events (Bodygroups_V updates) skipped
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
        { time = 1.0000, sound = "TFA_CODWW2_LAD.FPO" },
    },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["draw_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["holster_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["reload"] = {
        { time = 0.1667, sound = "TFA_CODWW2_LAD.TacOpen" },
        { time = 1.3333, sound = "TFA_CODWW2_LAD.TacBeltOut" },
        { time = 2.3333, sound = "TFA_CODWW2_LAD.TacBeltIn" },
        { time = 3.3333, sound = "TFA_CODWW2_LAD.TacClose" },
    },
    ["reload_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_LAD.Open" },
        { time = 1.5000, sound = "TFA_CODWW2_LAD.BeltIn" },
        { time = 2.3333, sound = "TFA_CODWW2_LAD.Close" },
        { time = 3.3333, sound = "TFA_CODWW2_LAD.Charge" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_LAD.Inspect2" },
    },
    ["inspect_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_LAD.Inspect2" },
    },
    ["inspect_epic"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.EpicInspect1" },
        { time = 3.8333, sound = "TFA_CODWW2_LAD.EpicInspect2" },
        { time = 7.5000, sound = "TFA_CODWW2_LAD.EpicInspect3" },
    },
    ["draw_first_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.FPO" },
    },
    ["draw_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["draw_knife_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["holster_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["holster_knife_empty"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["reload_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.ExtTacOpen" },
        { time = 0.8333, sound = "TFA_CODWW2_LAD.ExtTacMagOut" },
        { time = 2.6667, sound = "TFA_CODWW2_LAD.ExtTacMagIn" },
        { time = 3.8333, sound = "TFA_CODWW2_LAD.ExtTacClose" },
    },
    ["reload_knife_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.ExtOpen" },
        { time = 1.1667, sound = "TFA_CODWW2_LAD.ExtMagOut" },
        { time = 1.8333, sound = "TFA_CODWW2_LAD.ExtMagIn" },
        { time = 3.0000, sound = "TFA_CODWW2_LAD.ExtClose" },
        { time = 3.6667, sound = "TFA_CODWW2_LAD.ExtCharge" },
    },
    ["inspect_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_LAD.Inspect2" },
    },
    ["inspect_knife_empty"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LAD.Inspect1" },
        { time = 1.6667, sound = "TFA_CODWW2_LAD.Inspect2" },
    },
}

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

function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

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

SWEP.ViewModelElements = {
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/c_lad_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/c_lad_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/c_lad_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/c_lad_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/breda30/c_breda30_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
}

SWEP.WorldModelElements = {
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/w_lad_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/w_lad_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/w_lad_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/lad/w_lad_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
}

SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_nydar", "tfa_codww2_4x" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag_lmg" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_rapidfire", "tfa_codww2_fmj" }, default = 0 },
}
