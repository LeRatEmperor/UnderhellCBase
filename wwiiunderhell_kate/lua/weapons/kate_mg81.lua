-- ============================================================
-- MG 81 — Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_mg81 (TFA WWII Kate)
-- Template: template_auto (Full-Auto)
-- ============================================================

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "MG 81"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Light Machine Guns"

SWEP.Slot = 3
SWEP.Spawnable = true

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/mg81/c_mg81.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/mg81/w_mg81.mdl"
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

SWEP.Primary.Sound          = Sound("TFA_CODWW2_STG44.Blast")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 60
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 660
SWEP.Primary.MinDamage      = 300.0
SWEP.Primary.MaxDamage      = 300.0
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.03
SWEP.Primary.Delay          = 0.122199     -- 60 / RPM(491)
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -0.3
SWEP.Primary.MaxRecoil      = -0.2
SWEP.Primary.KickUp         = 0.3
SWEP.Primary.KickDown       = 0.2
SWEP.Primary.KickHorizontal = 0.2
SWEP.Primary.SpreadMultiplierMax = 5.0
SWEP.Primary.SpreadIncrement    = 0.75
SWEP.Primary.SpreadRecovery     = 4.5
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false
SWEP.AnimatedSprint = true

SWEP.IronSightsPos = Vector(-3.595, -3, -0.11)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.35
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
SWEP.Shell     = "models/entities/tfa_codww2/shells/fx_556.mdl"

SWEP.WorldModelOffset = Vector(14.9, 1.0, -5.75)
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
    ["inspect_epic"]      = "inspect_epic",
    ["draw_first_knife"]  = "draw_first_knife",
    ["draw_knife"]        = "draw_knife",
    ["holster_knife"]     = "holster_knife",
}

-- ============================================================
-- ANIMSOUNDS — lua-type events (Bodygroups_V updates) skipped
-- ============================================================
SWEP.AnimSounds = {
    ["draw_first"] = {
        { time = 0.1667, sound = "TFA_CODWW2_MG81.FPO" },
    },
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["reload"] = {
        { time = 0.6667, sound = "TFA_CODWW2_MG81.TacOpen" },
        { time = 2.0000, sound = "TFA_CODWW2_MG81.TacBeltIn" },
        { time = 4.3333, sound = "TFA_CODWW2_MG81.TacClose" },
    },
    ["reload_empty"] = {
        { time = 0.6667, sound = "TFA_CODWW2_MG81.Open" },
        { time = 2.8333, sound = "TFA_CODWW2_MG81.BeltIn" },
        { time = 4.5000, sound = "TFA_CODWW2_MG81.Close" },
        { time = 5.5000, sound = "TFA_CODWW2_MG81.Charge" },
    },
    ["inspect"] = {
        { time = 0.0333, sound = "TFA_CODWW2_MG81.Inspect1" },
        { time = 3.5000, sound = "TFA_CODWW2_MG81.Inspect2" },
    },
    ["inspect_epic"] = {
        { time = 0.0333, sound = "TFA_CODWW2_MG81.EpicInspect1" },
        { time = 2.6667, sound = "TFA_CODWW2_MG81.EpicInspect2" },
    },
    ["draw_first_knife"] = {
        { time = 0.1667, sound = "TFA_CODWW2_BREDA.FPO" },
    },
    ["draw_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LRG.Raise" },
    },
    ["holster_knife"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LRG.Holster" },
    },
    ["reload_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_MG81.ExtTacOpen" },
        { time = 1.3333, sound = "TFA_CODWW2_MG81.ExtTacMagOut" },
        { time = 3.3333, sound = "TFA_CODWW2_MG81.ExtTacMagIn" },
        { time = 4.8333, sound = "TFA_CODWW2_MG81.ExtTacClose" },
    },
    ["reload_knife_empty"] = {
        { time = 0.1667, sound = "TFA_CODWW2_MG81.ExtOpen" },
        { time = 2.0000, sound = "TFA_CODWW2_MG81.ExtMagOut" },
        { time = 3.3333, sound = "TFA_CODWW2_MG81.ExtMagIn" },
        { time = 4.5000, sound = "TFA_CODWW2_MG81.ExtClose" },
        { time = 5.6667, sound = "TFA_CODWW2_MG81.ExtCharge" },
    },
    ["inspect_knife"] = {
        { time = 0.0333, sound = "TFA_CODWW2_MG81.Inspect1" },
        { time = 2.1667, sound = "TFA_CODWW2_MG81.Inspect2" },
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
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["clip_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_clip.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["ext_clip"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_clip_ext.mdl",
        bone = "tag_clip", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["bipod_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_bipod.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["charm_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_charm.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/c_mg81_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["bipod_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/w_mg81_bipod.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["sight_nydar"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/w_mg81_reflex.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["scope_acog"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/w_mg81_4x.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = false,
    },
    ["sight_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/mg81/w_mg81_sight.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_nydar", "tfa_codww2_4x" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_xmag_lmg" }, default = 0 },
    [4] = { name = "Slot 4", atts = { "tfa_codww2_rifling", "tfa_codww2_steadyaim" }, default = 0 },
    [5] = { name = "Slot 5", atts = { "tfa_codww2_stock", "tfa_codww2_quickdraw", "tfa_codww2_grip" }, default = 0 },
    [6] = { name = "Slot 6", atts = { "tfa_codww2_rapidfire", "tfa_codww2_fmj" }, default = 0 },
}
