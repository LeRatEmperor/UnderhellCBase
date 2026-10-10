-- ============================================================
-- Flamenwerfer 35 -- Ported from TFA WWII to CUH base
-- Source: nz_kate_codww2_flammenwerfer35 (TFA WWII Kate Specials)
-- Template: full-auto (flame particle system deferred -- hitscan stub for now)
-- ============================================================
-- The flame particle system and projectile entity will be added in a later
-- phase. For now this is a standard full-auto hitscan weapon using the
-- flamethrower's stats (15 dmg, 600 range, ~1000 RPM).

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName   = "Flamenwerfer 35"
SWEP.Category    = "Kate WWII"
SWEP.SubCategory = "Specials"

SWEP.Slot = 4
SWEP.Spawnable = true

-- Appearance
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel  = "models/weapons/tfa_codww2/flammenwerfer35/c_flammenwerfer35.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/flammenwerfer35/w_flammenwerfer35.mdl"
SWEP.LoweredPos = Vector(1, -1, -0.5)
SWEP.LoweredAng = Vector(-15, 30, -20)

SWEP.UseQCReloadEvents = true
SWEP.UseReloadTable = true

SWEP.HoldType = "shotgun"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

-- Fire mode: Full-Auto only
SWEP.FireModes = {
    { name = "Full-Auto" },
}

-- Primary stats (from TFA source)
SWEP.Primary.Sound          = Sound("TFA_CODWW2_M2FT.Start")
SWEP.Primary.SilSound       = Sound("")
SWEP.Primary.ClipSize       = 100             -- = TFA Primary.ClipSize
SWEP.Primary.Ammo           = "AlyxGun"       -- = TFA Primary.Ammo
SWEP.Primary.DefaultClip    = 100             -- = TFA Primary.DefaultClip
SWEP.Primary.MinDamage      = 15.0            -- = TFA Primary.Damage
SWEP.Primary.MaxDamage      = 15.0
SWEP.Primary.Automatic      = true            -- = TFA Primary.Automatic
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 1
SWEP.Primary.Spread         = 0.03            -- = TFA Primary.Spread
SWEP.Primary.Delay          = 0.06            -- 60 / RPM(1000)
SWEP.Primary.NumberofShots  = 1               -- = TFA Primary.NumShots
SWEP.Primary.MinRecoil      = -0.05           -- = -KickUp
SWEP.Primary.MaxRecoil      = -0.05           -- = -KickDown
SWEP.Primary.KickUp         = 0.05            -- = TFA Primary.KickUp
SWEP.Primary.KickDown       = 0.05            -- = TFA Primary.KickDown
SWEP.Primary.KickHorizontal = 0.0             -- = TFA Primary.KickHorizontal
SWEP.Primary.SpreadMultiplierMax = 5.0        -- = TFA Primary.SpreadMultiplierMax
SWEP.Primary.SpreadIncrement    = 0.3        -- = TFA Primary.SpreadIncrement
SWEP.Primary.SpreadRecovery     = 4.0         -- = TFA Primary.SpreadRecovery
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = false           -- = TFA DisableChambering
SWEP.AnimatedSprint         = true

-- Ironsights (from TFA source)
SWEP.IronSightsPos = Vector(-2.86, -3, 1.5)
SWEP.IronSightsAng = Vector(1.5, 0, 0)
SWEP.IronSightTime = 0.45
SWEP.SwayPosition = 2.0
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- TFA-style curved ironsight dip -- DISABLED for WWII (position-based ADS only)
SWEP.IronSightsDipPos   = Vector(0, 0, 0)
SWEP.IronSightsDipAng   = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0

-- Camera bone system (BO3-style)
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve = false
SWEP.CameraOffset = Angle(0, 0, 0)

-- Muzzle
SWEP.MuzzleAttachment = "2"   -- tag_flash (auto-detected by GetMuzzle)
SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize = 128

-- Melee bash (E + Left-Click) -- from TFA Secondary.Bash*
SWEP.MeleeDamage    = 35                       -- = TFA Secondary.BashDamage
SWEP.MeleeRange     = 60                        -- = TFA Secondary.BashLength
SWEP.MeleeDelay     = 0.2                       -- = TFA Secondary.BashDelay
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.2
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "TFA_CODWW2_MELEE.SwingLrg"   -- = TFA Secondary.BashSound
SWEP.MeleeHitSound  = {"TFA_CODWW2_MELEE.Hit"}      -- = TFA Secondary.BashHitSound
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- Shell ejection (flamethrower -- no shell)
SWEP.NoShell   = true                           -- = TFA LuaShellEject = false
SWEP.ShellHeat = 0.8
SWEP.Shell     = ""

-- World model positioning (from TFA SWEP.Offset: Pos=Up/Right/Forward, Ang=Up/Right/Forward)
SWEP.WorldModelOffset = Vector(13.8, 1, -3.8)   -- (Forward, Right, Up)
SWEP.WorldModelAngle  = Angle(190, 180, 0)      -- (Pitch=Right, Yaw=Up, Roll=Forward)

-- ============================================================
-- ANIMATIONS
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
}

-- ============================================================
-- ANIMSOUNDS (ported 1:1 from TFA EventTable, time = N/30 -> seconds)
-- ============================================================
SWEP.AnimSounds = {
    ["draw"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LNCHR.Raise" },
    },
    ["draw_first"] = {
        { time = 0.0333, sound = "TFA_CODWW2_LNCHR.Raise" },
    },
    ["holster"] = {
        { time = 0.0667, sound = "TFA_CODWW2_LNCHR.Holster" },
    },
}

-- ============================================================
-- SMART MUZZLE / SHELL AUTO-DETECT
-- ============================================================
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
-- Renames: angle->ang, size->scale, bodygroup->bodygroups
-- WorldModelElements uses the w_ prefixed models from TFA WElements
-- ============================================================
SWEP.ViewModelElements = {
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/c_flammenwerfer35_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/c_flammenwerfer35_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["muzzle_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/c_flammenwerfer35_muzzle.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

SWEP.WorldModelElements = {
    ["backpack_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/w_flammenwerfer35_backpack.mdl",
        bone = "ValveBiped.Bip01_Spine4", pos = Vector(-11, -4, 0), ang = Angle(180, -100, 0),
        scale = Vector(1.1, 1.1, 1.1), material = "", skin = 0,
        bodygroups = {}, bonemerge = false,
        active = true,
    },
    ["receiver_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/w_flammenwerfer35_receiver.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["barrel_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/w_flammenwerfer35_barrel.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
    ["muzzle_default"] = {
        type = "Model", model = "models/weapons/tfa_codww2/flammenwerfer35/w_flammenwerfer35_muzzle.mdl",
        bone = "tag_weapon", pos = Vector(0, 0, 0), ang = Angle(0, 0, 0),
        scale = Vector(1, 1, 1), material = "", skin = 0,
        bodygroups = {}, bonemerge = true,
        active = true,
    },
}

-- ============================================================
-- ATTACHMENTS (none -- flamethrower has no attachments)
-- ============================================================
SWEP.Attachments = {}
