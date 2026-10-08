-- G36K Assault Rifle (with Scope) — Ported from weapon_uh_base_gun to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell gun base (weapon_uh_base_gun)
-- to the CUH base (weapon_cuh_base_gun).
-- Despite the file name "snip_g36", this is actually an assault rifle
-- with a 2D scope (ZoomFov + ScopeTexture).
--   - 30-round AR magazine (ar2 ammo)
--   - 2 fire modes: Semi-Auto (scoped), Auto (no-scope)
--   - CustomThink manipulates scope bones based on NoScope NWBool
--   - The Auto mode equips NoScope (faster fire, no zoom)
--   - ScopeTexture drives the 2D scope render in the parent base
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_snip_g36.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "G36K Assault Rifle"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "Snipers"
SWEP.UseHands                           = false

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_g36k_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_g36k_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 4
SWEP.SlotPos                            = 0

SWEP.HoldType                           = "ar2"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.HasSilencer                        = true
SWEP.SmokeWidth                         = 80
SWEP.Sensitivity            = 0.2
SWEP.ZoomFov                            = 10
SWEP.ScopeBlur                          = true
SWEP.ScopeFov                           = 10
SWEP.ScopeTexture                       = Material("models/weapons/v_models/g36k/lens")
SWEP.Use2DScope                         = true
SWEP.TwoHanded                          = true
SWEP.AnimSprint                         = true

SWEP.Shell                                      = "models/weapons/shell_762.mdl"

-- ============================================================
-- FIRE MODES — Semi-Auto (scoped) and Auto (NoScope)
-- ============================================================
SWEP.FireModes = {
    {
        name = "Semi-Auto",
        equip = function(ply, wep)
            wep.Primary.Automatic = false
        end,
        holster = function(ply, wep)
            wep.Primary.Automatic = true
        end
    },
    {
        name = "Auto",
        equip = function(ply, wep)
            wep:SetNWBool("NoScope", true)
            wep.ScopeDisabled               = true
            wep.Primary.Automatic   = true
            wep.IronSightsPos               = Vector(-3.6, -5.5, 0.26)
            wep.ScopeBlur                   = false
            wep.Sensitivity                 = 1
            wep.Primary.Delay               = 0.12
        end,
        holster = function(ply, wep)
            wep:SetNWBool("NoScope", false)
            wep.ScopeDisabled               = false
            wep.Primary.Automatic   = false
            wep.IronSightsPos               = Vector(-3.6, -8.801, -0.361)
            wep.ScopeBlur                   = true
            wep.Sensitivity                 = 0.2
            wep.Primary.Delay               = 0.25
        end
    }
}

SWEP.ReloadTable = {
    {delay = 0.5, sound = Sound("weapons/uh_g36k/g36k_deploy.wav")},
    {delay = 1, sound = Sound("weapons/uh_g36k/g36k_clipout.wav")},
    {delay = 1.7, sound = Sound("weapons/uh_g36k/g36k_clipin.wav")},
    {delay = 2.5, sound = Sound("weapons/uh_g36k/g36k_boltpull.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_g36k/g36k_fire.wav")
SWEP.Primary.SilSound           = Sound("weapons/uh_g36k/g36k_fire_silenced.wav")
SWEP.Primary.ClipSize           = 30
SWEP.Primary.Ammo                       = "ar2"
SWEP.Primary.DefaultClip        = 30
SWEP.Primary.MinDamage      = 45
SWEP.Primary.MaxDamage      = 60
SWEP.Primary.Automatic          = false
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Force                      = 15
SWEP.Primary.Spread             = 0.04
SWEP.Primary.Delay                      = 0.25
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -1
SWEP.Primary.MaxRecoil          = -1.4

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.Ammo             = "none"
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.6, -8.801, -0.361)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- CUH melee bash config (E+M1)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 54
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/axe/axe_swing1.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.Animations = {
    ["reload_empty"] = "ACT_VM_RELOAD",
    ["reload_empty_sil"] = "ACT_VM_RELOAD",
    ["reload_sil"] = "ACT_VM_RELOAD"
}

SWEP.AnimSounds = {}

-- Scope bones — scaled down when NoScope is active (Auto fire mode)
SWEP.ScopeBones = {
    ["scope"] = Vector(0,0,0),
    ["scope-flap1"] = Vector(0,0,0),
    ["scopeflap2"] = Vector(0,0,0)
}

-- ============================================================
-- SMART MUZZLE / SHELL / DISPLAY
-- ============================================================
function SWEP:GetMuzzle()
    return 1
end

function SWEP:GetShellEject()
    return 2
end

function SWEP:GetDisplay()
    return 1
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
-- CUSTOM THINK — manipulate scope bones based on NoScope state
-- (kept from source; called by BaseClass.Think at end of every tick)
-- ============================================================
function SWEP:CustomThink( ct )
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        for bone,sca in pairs(self.ScopeBones) do
            local bone_id = vm:LookupBone(bone)
            if !bone_id then continue end

            if self:GetNWBool("NoScope") then
                vm:ManipulateBoneScale(bone_id, sca)
            else
                vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
            end
        end
    end
end

-- ============================================================
-- THINK (with melee + mantle state machine)
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

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end

    -- Holster finish
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
    -- CustomThink is called by BaseClass.Think above (manipulates scope bones)
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
    self:EasySendWeaponAnim("mantle", ACT_VM_DRAW)
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
-- ATTACK GUARDS (E+M1 = melee bash)
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
-- HANDLE RUNNING (preserved from source: Underhell lowering anims)
-- ============================================================
function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

    local vel = self.Owner:GetVelocity():LengthSqr()
    local sprinting = self.Owner:KeyDown(IN_SPEED)
        and vel > self.Owner:GetWalkSpeed() ^ 2

    if sprinting then
        -- ENTER RUNNING
        if not self:GetUHBool("Running") then
            -- ONLY play lowering anim if NOT reloading
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE)
                self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
            end
        end

        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
    else
        -- EXIT RUNNING
        if self:GetUHBool("Running") then
            -- Same rule applies here
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)
                self:SendWeaponAnim(ACT_VM_LOWERED_TO_IDLE)
            end
        end

        self:SetUHBool("Running", false)
    end
end

-- ============================================================
-- POST RELOAD (resumes sprint after reload if still holding IN_SPEED)
-- ============================================================
function SWEP:PostReload()
    if IsValid(self.Owner)
    and self.Owner:KeyDown(IN_SPEED) then
        timer.Simple(0, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            self:SetUHBool("Running", true)

            self:SendWeaponAnim(ACT_VM_IDLE)
            self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
        end)
    end
end
