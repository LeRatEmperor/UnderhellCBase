-- weapon_cuh_bf3_m416.lua
-- Pilot port of the BF3 M416 assault rifle to the CUH (Custom UnderHell) base.
-- Adapted from the original TFA-based bf3_m416.lua by Steffan Shibe.
-- See /home/z/my-project/download/bf3_sweps_audit.md for the field-by-field mapping.

AddCSLuaFile()

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

-- ============================================================
-- Identification
-- ============================================================
SWEP.PrintName    = "M416 (CUH)"
SWEP.Category    = "[CUH] Battlefield 3"
SWEP.Author      = "Steffan Shibe (BF3) / Z (CUH port)"
SWEP.SubCategory = "Assault Rifles"
SWEP.Slot        = 3
SWEP.SlotPos     = 10
SWEP.Spawnable   = true
SWEP.AdminSpawnable = true
SWEP.DrawAmmo    = true
SWEP.DrawCrosshair = true   -- CUH always draws crosshair via DrawHUD; harmless
SWEP.AutoSwitchTo   = true
SWEP.AutoSwitchFrom = true

-- ============================================================
-- CUH flags
-- ============================================================
SWEP.IsCUHWeapon  = true   -- fast-path for IsCUHWeapon check (cl_cuh_ui.lua:23)
SWEP.Customizable = true   -- show in C-key customization menu

-- ============================================================
-- Appearance / viewmodel
-- ============================================================
-- BF3 v_*.mdl files have their own hands mesh baked in. Using c_hands causes
-- the broken-texture magenta mess we saw earlier, so keep UseHands = false.
SWEP.UseHands         = false
SWEP.ViewModelFlip    = false
SWEP.ViewModelFOV     = 75
SWEP.ViewModel        = "models/bf3/weapons/m416.mdl"
SWEP.WorldModel       = "models/bf3/weapons/w_m416.mdl"
SWEP.WorldModelOffset = Vector(10, 1, -3)
SWEP.WorldModelAngle  = Angle(0, 90, 190)

SWEP.HoldType    = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov     = 15

SWEP.VMPos          = Vector(0, 1, -0.75)
SWEP.VMPos_Additive = false

-- Per-bone mods for the left thumb (tweaks the grip pose)
SWEP.ViewModelBoneMods = {
    ["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12, 0, -16) },
    ["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -12, 0) },
    ["ValveBiped.Bip01_L_Finger0"]  = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 8, 0) },
}

-- ============================================================
-- Fire modes
-- ============================================================
-- TFA used { "Auto", "Single", "Safe" } — burst mode dropped (CUH doesn't have built-in burst).
SWEP.FireModes = {
    { name = "Full-Auto" },
    { name = "Semi-Auto" },
    { name = "Safe" },
}

-- ============================================================
-- Primary stats
-- ============================================================
SWEP.Primary.Sound    = Sound("bf3/weapons/m416_fire.wav")
SWEP.Primary.SilSound = Sound("bf3/weapons/m416_fire_suppressed.wav")   -- TFA: SilencedSound -> CUH: SilSound

SWEP.Primary.ClipSize    = 30
SWEP.Primary.DefaultClip = 90       -- 30*3
SWEP.Primary.Ammo        = "ar2"
SWEP.Primary.Automatic   = true
SWEP.Primary.TakeAmmo    = 1
SWEP.Primary.Force       = 6

-- TFA: RPM = 800 -> CUH: Delay = 60/800 = 0.075
SWEP.Primary.Delay = 60 / 800

-- TFA: Damage = 30 (single value) -> CUH: MinDamage + MaxDamage (random in [min, max])
SWEP.Primary.MinDamage = 30
SWEP.Primary.MaxDamage = 30

-- Spread
SWEP.Primary.Spread        = 0.025
SWEP.Primary.IronAccuracy  = 0.01

-- Recoil (TFA: KickUp = 0.25, KickHorizontal = 0.1)
-- CUH wants KickUp, KickDown, KickHorizontal, MinRecoil, MaxRecoil.
-- KickDown is new — set to KickUp * 0.8 (a sensible default).
-- MinRecoil/MaxRecoil are used by util.SharedRandom in PrimaryAttack — set to
-- KickUp * 0.7 and KickUp * 1.3 to give some variation around the TFA value.
SWEP.Primary.KickUp         = 0.25
SWEP.Primary.KickDown       = 0.20    -- 0.25 * 0.8
SWEP.Primary.KickHorizontal = 0.10
SWEP.Primary.MinRecoil      = 0.175   -- 0.25 * 0.7
SWEP.Primary.MaxRecoil      = 0.325   -- 0.25 * 1.3

SWEP.Primary.NumberofShots = 1   -- TFA: NumShots -> CUH: NumberofShots

-- ============================================================
-- Ironsights
-- ============================================================
SWEP.IronSightsPos = Vector(-2.495, -4, 0.42)
SWEP.IronSightsAng = Vector(0.3, 0.05, 0)
SWEP.IronSightTime = 0.45     -- CUH requires this (default ADS transition time)

-- Sprint / alt-aim / inspect (CUH reads these)
SWEP.RunSightsPos    = Vector(5.786, 0, -1)
SWEP.RunSightsAng    = Vector(-10.778, 57.573, 0)
SWEP.AlternativePos  = Vector(0, 0, 0)
SWEP.AlternativeAng  = Angle(0, 0, 0)

-- Per-attachment sight pos/ang (referenced by bf3_reflex/kobra/eotech/acog/scope)
SWEP.SightsPos_Reflex = Vector(-2.489, -4, -0.215)
SWEP.SightsAng_Reflex = Vector(0.2, 0.009, 0)
SWEP.SightsPos_Kobra  = Vector(-2.49, -4, -0.175)
SWEP.SightsAng_Kobra  = Vector(0.2, 0.009, 0)
SWEP.SightsPos_Eotech = Vector(-2.492, -3, 0.1575)
SWEP.SightsAng_Eotech = Vector(0.2, 0.009, 0)
SWEP.SightsPos_ACOG   = Vector(-2.492, -2.5, -0.167)
SWEP.SightsAng_ACOG   = Vector(0.2, 0.009, 0)

-- IronFOV per optic (referenced by attachment WeaponTable functions)
SWEP.Secondary.IronFOV           = 65
SWEP.Secondary.IronFOV_Scope     = 10
SWEP.Secondary.IronFOV_ACOG      = 40
SWEP.Secondary.IronFOV_Collimator = 60

-- ============================================================
-- Penetration / chambering
-- ============================================================
-- CUH expects a NUMBER (penetration depth in units), not a boolean.
-- TFA's Penetration = true means "enable bullet penetration"; in CUH
-- that's equivalent to Penetration = 2 (the default depth).
SWEP.Penetration = 2
SWEP.Silenced  = false   -- explicitly set so InitStatCache captures it
SWEP.Chambering = true   -- M416 has bullet-in-chamber (was implicit in TFA)
SWEP.ReloadSpeed = 1
SWEP.TwoHanded = true

-- Use QC reload events: when true, the base plays reload sound events
-- that are baked into the model's $animation (AE_SHELL or AE_RELOAD
-- events). BF3 models emit reload sounds via QC events, so we MUST
-- enable this to hear them.
SWEP.UseQCReloadEvents = true

-- ============================================================
-- Muzzle flash + shell
-- ============================================================
SWEP.MuzzleFlashType       = "particle"
SWEP.MuzzleFlashParticle   = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(255, 200, 100)
SWEP.MuzzleFlashLightSize  = 128

SWEP.NoShell  = false
SWEP.ShellHeat = 0.8
-- Don't set SWEP.Shell — let the CUH base default to "models/weapons/shell_9mm.mdl"
-- (ships with GMod). Setting it to "models/weapons/shell_556.mdl" caused error signs
-- because that model doesn't exist in the user's GMod install.
SWEP.ShellDelay = 0

-- ============================================================
-- Melee (CUH reads these — rifle butt attack on RMB+USE)
-- ============================================================
SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 300
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = { "weapons/blackops3/rifle_butt/rifle_hit_00.wav" }
SWEP.MeleeInterruptReload = true

-- ============================================================
-- Camera (CUH inspect / mantle hooks)
-- ============================================================
SWEP.CameraAttachment = "Camera"
SWEP.CameraReserve    = false
SWEP.CameraOffset     = Angle(0, 0, 0)
SWEP.CUHInspectOnMenu = true

-- ============================================================
-- Animations
-- ============================================================
-- Pattern A: base_* + foregrip_* (verified by decompiling m416.mdl)
-- When bf3_grip is equipped, ApplyAttachments overrides these keys with
-- the foregrip_* variants via the attachment's WeaponTable.Animations block.
SWEP.Animations = {
    ["shoot"]        = "base_fire",
    ["shoot_sil"]    = "base_fire",           -- BF3 has no silenced anim; reuse base_fire
    ["reload"]       = "base_reload",
    ["reload_sil"]   = "base_reload",          -- same
    ["reload_empty"] = "base_reload_empty",
    ["reload_empty_sil"] = "base_reload_empty", -- same
    ["idle"]         = "base_idle",
    ["draw"]         = "base_draw",
    ["first_draw"]   = "base_draw",

    -- Sprint: BF3 models don't have dedicated sprint sequences, so we
    -- map sprint_idle to the regular idle and sprint_in/out to draw.
    -- When grip is attached, the grip's WeaponTable.Animations overrides
    -- these keys to the foregrip_* variants.
    ["sprint_idle"]  = "base_idle",
    ["sprint_in"]    = "base_idle",
    ["sprint_out"]   = "base_idle",

    -- Ironsights (BF3 models don't have dedicated ADS anims —
    -- fall back to base idle for iron transitions)
    ["iron_in"]      = "base_idle",
    ["iron_idle"]    = "base_idle",
    ["iron_out"]     = "base_idle",
}

SWEP.AnimSounds = {}

-- ============================================================
-- VElements / WElements
-- ============================================================
-- TFA: SWEP.VElements = { ["laser"] = { type = "Model", ... } }
-- CUH: SWEP.ViewModelElements = { ["laser"] = { type = "Model", model = "...", ... } }
-- Conversion notes:
--   - Keep "type = 'Model'" (CUH's InitVElements checks elem.type == "Model")
--   - Drop "rel" (TFA relative-bone field — CUH doesn't have this)
--   - Drop "color" (TFA per-element color — CUH doesn't support this)
--   - Use "ang" (NOT "angle") — CUH's DrawVElements reads elem.ang, not elem.angle
--   - Bone name must EXACTLY match the model's bone name (case-sensitive).
--     The BF3 m416 model has bone "Weapon" (capital W), NOT "weapon".
SWEP.ViewModelElements = {
    ["laser"] = {
        type = "Model",
        model = "models/tfa/lbeam.mdl",
        bone = "Weapon",   -- capital W — matches m416.mdl's actual bone name
        pos = Vector(1.4, 7.899, 3.6),   -- flipped X from -1.4 to 1.4 (was on wrong side)
        ang = Angle(0, -90, 0),
        size = Vector(0.5, 0.5, 0.5),
        material = "",
        skin = 0,
        bodygroup = {},
        surpresslightning = false,
        bonemerge = false,
        active = false,   -- toggled true by bf3_laser attachment
    },
}

SWEP.WorldModelElements = {}   -- no WElements for BF3 weapons (world models have their own meshes)

-- ============================================================
-- Default bodygroups
-- ============================================================
-- CRITICAL: must set default bodygroup state so ResetBodygroups can
-- restore to these values when attachments are removed.
-- BF3 models have 4 attachment bodygroups:
--   [0] = sight (0=ironsights, 1=reflex, 2=kobra, 3=acog, 4=eotech, 5=scope)
--   [1] = barrel (0=default, 1=muzzle/compensator, 2=suppressor)
--   [2] = grip (0=no grip, 1=foregrip)
--   [3] = laser (0=no laser, 1=laser)
-- All default to 0 (no attachments equipped).
SWEP.Bodygroups_V = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }
SWEP.Bodygroups_W = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }

-- ============================================================
-- Attachments table (CUH format)
-- ============================================================
-- TFA format: { offset = {0,0}, atts = {...}, order = N }
-- CUH format: { name = "Slot Label", atts = {...}, default = 1 }
-- The bf3_* attachment IDs are the filenames of the cuh_attachments/*.lua files.
SWEP.Attachments = {
    [1] = { name = "Optic",  atts = { "bf3_reflex", "bf3_kobra", "bf3_eotech", "bf3_acog" }, default = 0 },
    [2] = { name = "Muzzle", atts = { "bf3_muzzle", "bf3_suppressor" }, default = 0 },
    [3] = { name = "Laser",  atts = { "bf3_laser" }, default = 0 },
    [4] = { name = "Grip",   atts = { "bf3_grip" }, default = 0 },
}

-- ============================================================
-- Method overrides
-- ============================================================
-- ShootAnimation: return the CUH animation key to use for the fire anim.
-- Default CUH behavior: looks up "shoot" / "shoot_ads" / "shoot_sil" / "shoot_ads_sil".
-- BF3 weapons don't have ADS-specific fire anims, so just return "shoot" regardless of zoom.
function SWEP:ShootAnimation()
    return "shoot"
end

-- ============================================================
-- Ironsight + sprint animation handlers
-- (copied from weapon_xm4_bo6.lua — the working CUH reference)
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

    local isZooming = self:GetUHBool("Zooming")
    if self.wasZooming == nil then self.wasZooming = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

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

function SWEP:Think()
    BaseClass.Think(self)
    self:HandleIronsightsAnimations()
    self:HandleSprintingAnimations()
end

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self.Owner:KeyDown(IN_USE) then return end   -- RMB+USE = melee, not reload
    return BaseClass.Reload(self)
end

function SWEP:Holster(wep)
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(self, wep)
end
