-- MP5 EOD (with Grenade Launcher) — Ported from weapon_uh_base_gun to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell gun base (weapon_uh_base_gun)
-- to the CUH base (weapon_cuh_base_gun).
-- The MP5 EOD is an SMG with an underslung grenade launcher:
--   - 30-round SMG magazine (smg1 ammo)
--   - 3 fire modes: Auto, Semi-Auto, Grenade
--   - FireModes[3].shoot calls wep:ShootGrenade(10000) to spawn sent_mgl_grenade
--   - CustomThink switches ironsight positions when GL mode is active
--   - GLSightsPos/GLSightsAng used in fire mode 3 (Grenade)
--   - HandleRunning does NOT cancel reloads on sprint (kept from source)
--   - PostReload resumes sprint if IN_SPEED held after reload
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_smg_mp5_gl.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "MP5 EOD"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "SMGs"
SWEP.UseHands                           = false

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_smg_mp5_eod_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_smg_mp5_eod_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 2
SWEP.SlotPos                            = 0

SWEP.HoldType                           = "smg"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.SmokeWidth                         = 50
SWEP.AnimSprint                         = true

-- ============================================================
-- FIRE MODES — third mode is the Grenade Launcher
-- ============================================================
-- FireModes[3].shoot callback is invoked by BaseClass.PrimaryAttack
-- via the standard `mode.shoot(self.Owner, self)` hook.
-- It calls wep:ShootGrenade(10000) which spawns sent_mgl_grenade
-- (ShootGrenade is inherited from weapon_custom_uh_base_gun.lua).
SWEP.FireModes = {
    {
        name = "Auto",
        equip = function(ply, wep)
            wep.Primary.Automatic = true
        end,
        holster = function(ply, wep)
            wep.Primary.Automatic = false
        end
    },
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
        name = "Grenade",
        equip = function(ply,wep)
            wep.Primary.Automatic = false
        end,
        holster = function(ply,wep)
            wep.Primary.Automatic = true
        end,
        shoot = function(ply,wep)
            if ply:GetAmmoCount(wep.Secondary.Ammo) <= 0 then return true end

            if SERVER then
                wep:ShootGrenade(10000)
            end

            local SP = game.SinglePlayer()
            local IFTP = IsFirstTimePredicted()

            if (SP and SERVER) or (!SP and CLIENT and IFTP) then
                local fx = EffectData()
                fx:SetEntity(wep)
                fx:SetOrigin(ply:GetShootPos())
                fx:SetNormal(ply:GetAimVector())
                fx:SetAttachment(wep:GetMuzzle())
                util.Effect("uh_muzzle",fx)

                wep:CreateSmoke( wep.Primary.Delay + (wep.Primary.Automatic and 0.14 or 0.32) )
            end

            local recoil = util.SharedRandom("uh_recoil", wep.Primary.MinRecoil, wep.Primary.MaxRecoil) * (wep:GetNWBool("Zooming") and 0.35 or 1)

            ply:SetEyeAngles( ply:EyeAngles() + Angle( recoil, 0, 0 ) )
            ply:ViewPunch( Angle( recoil, 0, 0 ) )

            wep:SendWeaponAnim( ACT_VM_IDLE )
            wep:SendWeaponAnim( wep:ShootAnimation() )
            ply:SetAnimation( PLAYER_ATTACK1 )
            ply:MuzzleFlash()
            wep:EmitSound( wep.Secondary.Sound, 110, 100, 1, CHAN_WEAPON )
            wep:TakeSecondaryAmmo(wep.Secondary.TakeAmmo)
            wep:SetNextPrimaryFire( CurTime() + wep.Secondary.Delay )
            wep:SetNextSecondaryFire( CurTime() + wep.Secondary.Delay )

            wep.NextReload = CurTime() + 0.5

            return true
        end
    }
}

SWEP.ReloadTable = {
    {delay = 0.4, sound = Sound("weapons/uh_mp5eod/mp5_boltslap.wav")},
    {delay = 1, sound = Sound("weapons/uh_mp5eod/mp5_clipout.wav")},
    {delay = 2.5, sound = Sound("weapons/uh_mp5eod/mp5_clipin.wav")},
    {delay = 3.3, sound = Sound("weapons/uh_mp5eod/mp5_boltpull.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_mp5eod/mp5_fire.wav")
SWEP.Primary.ClipSize           = 30
SWEP.Primary.Ammo                       = "smg1"
SWEP.Primary.DefaultClip        = 30
SWEP.Primary.MinDamage      = 16
SWEP.Primary.MaxDamage      = 17
SWEP.Primary.Automatic          = true
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Force                      = 12
SWEP.Primary.Spread             = 0.18
SWEP.Primary.Delay                      = 0.08
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -0.6
SWEP.Primary.MaxRecoil          = -1.1

SWEP.Secondary.Sound            = Sound("weapons/uh_glauncher/fire.wav")
SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.Ammo             = "smg1_grenade"
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Delay            = 0.8
SWEP.Secondary.TakeAmmo         = 1
SWEP.Secondary.MinRecoil        = -2.4
SWEP.Secondary.MaxRecoil        = -3.1

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.385, -5, 0.901)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.GLSightsPos = Vector(-4.16, -6.1, 0.81)
SWEP.GLSightsAng = Vector(0, 1.2, 0)

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
}

SWEP.AnimSounds = {}

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
-- CAN PRIMARY ATTACK — allow GL mode (FireMode 3) to fire with
-- secondary ammo even when primary clip is empty.
-- ============================================================
function SWEP:CanPrimaryAttack()
    if not IsValid(self.Owner) then return false end
    if self:GetNWInt("FireMode") == 0
       or self:GetNWFloat("DeployTime") > CurTime()
       or self:GetUHBool("Running")
       or self:GetUHBool("Reloading") then return false end

    -- Grenade Launcher mode: use secondary ammo
    if self:GetNWInt("FireMode") == 3 then
        if self.Owner:GetAmmoCount(self.Secondary.Ammo) <= 0 then
            self:EmitSound("Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE)
            self:SetNextPrimaryFire(CurTime() + 0.4)
            return false
        end
        return true
    end

    -- Standard SMG modes: check primary clip
    if self:Clip1() <= 0 then
        if not self:GetUHBool("Reloading") then
            self:EmitSound("Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE)
        end
        self:SetNextPrimaryFire(CurTime() + 0.4)
        return false
    end
    return true
end

-- ============================================================
-- CUSTOM THINK — switch ironsight positions when GL mode is active
-- (kept from source; called by BaseClass.Think at end of every tick)
-- ============================================================
function SWEP:CustomThink(ct)
    if SERVER then return end
    if self:GetNWInt("FireMode") != 3 then
        self.IronSightsPos = Vector(-3.385, -5, 0.901)
        self.IronSightsAng = Vector(0, 0, 0)
    else
        self.IronSightsPos = Vector(-4.16, -6.1, 0.81)
        self.IronSightsAng = Vector(0, 1.2, 0)
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
    -- CustomThink is called by BaseClass.Think above (switches GL ironsights)
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
-- HANDLE RUNNING (preserved from source: does NOT cancel reloads
-- on sprint — this lets the MP5 finish reloading even if the player
-- starts sprinting mid-reload)
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
