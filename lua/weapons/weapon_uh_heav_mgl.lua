-- Grenade Launcher (MGL) — Ported from weapon_uh_base_shotty to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell shotgun base (weapon_uh_base_shotty)
-- to the CUH base (weapon_cuh_base_gun).
-- The MGL is a 6-round revolver grenade launcher:
--   - 6-round cylinder (UH_MGL ammo)
--   - PrimaryAttack calls ShootGrenade(10000) — inherited from CUH base
--     (which spawns sent_mgl_grenade with force=10000)
--   - Shotgun-style shell-by-shell reload (inserts one grenade at a time)
--   - Reload() starts the reload; ReloadShotgun() handles the loop
--   - CustomThink dispatches ReloadShotgun every tick while reloading
--   - NoShell = true (grenade launchers don't eject shells)
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_heav_mgl.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "Grenade Launcher"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "Heavy"
SWEP.UseHands                           = false

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 60
SWEP.ViewModel                          = "models/weapons/v_mgl_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_mgl_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 4
SWEP.SlotPos                            = 2

SWEP.HoldType                           = "shotgun"
SWEP.PassiveAnim                        = "passive"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.ViewModelFlip                      = false
SWEP.Chambering                         = false
SWEP.SmokeWidth                         = 100
SWEP.TwoHanded                          = true
SWEP.AnimSprint                         = true

-- Shotgun-style reload: inserted one shell at a time
SWEP.Shotgun    = true

SWEP.FireModes = {
        {
                name = "Semi-Auto"
        }
}

SWEP.Primary.Sound          = Sound("weapons/uh_mgl/fire.wav")
SWEP.Primary.ShellSound     = Sound("weapons/uh_mgl/insert.wav")
SWEP.Primary.ClipSize           = 6
SWEP.Primary.Ammo                       = "UH_MGL"
SWEP.Primary.DefaultClip        = 6
SWEP.Primary.Automatic          = false
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Delay                      = 0.8
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -3.6
SWEP.Primary.MaxRecoil          = -4.4
SWEP.Primary.ReloadTime         = 1

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.Ammo             = "none"
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false

SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 3.2

-- CUH melee bash config (E+M1)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 54
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- No shell ejection for a grenade launcher
SWEP.NoShell = true

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
-- ATTACK GUARDS (E+M1 = melee bash)
-- ============================================================
-- PrimaryAttack starts with the E+M1 melee gate, then falls
-- through to the MGL's custom grenade firing logic.
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

    -- Custom MGL grenade firing logic (preserved from source)
    if not self:CanPrimaryAttack() then return end

    if SERVER then
        self:ShootGrenade(10000)
    end

    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)

    if sp or (CLIENT and iftp) then
        local fx = EffectData()
        fx:SetEntity(self)
        fx:SetOrigin(self.Owner:GetShootPos())
        fx:SetNormal(self.Owner:GetAimVector())
        fx:SetAttachment(self:GetMuzzle())
        util.Effect("uh_muzzle",fx)

        self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )

        self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
    end

    self.Owner:ViewPunch( Angle( recoil, 0, 0 ) )

    self:SendWeaponAnim( ACT_VM_IDLE )
    self:SendWeaponAnim( self:ShootAnimation() )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Owner:MuzzleFlash()
    self:EmitSound( self.Primary.Sound, 110, 100, 1, CHAN_WEAPON )
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

    self.NextReload = CurTime() + 0.5
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end

-- ============================================================
-- SHOTGUN SHELL-BY-SHELL RELOAD (KRM-262 / Model 1897 pattern)
-- ============================================================
-- Reload() only STARTS the reload. The loop is handled by ReloadShotgun,
-- which is dispatched every tick by CustomThink while Reloading is true.
function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end

    local ct = CurTime()
    if self.NextReload >= ct then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self:GetNWFloat("DeployTime", 0) > ct then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then return end

    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

    self.Owner:SetAnimation(PLAYER_RELOAD)
    self.NextReload = ct + 0.5

    -- Play start reload animation (use ACT_VM_RELOAD since MGL has no
    -- dedicated ACT_SHOTGUN_RELOAD_START animation)
    self:EasySendWeaponAnim("reload_empty", ACT_SHOTGUN_RELOAD_START)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Timer-based shell insertion (one grenade per Primary.ReloadTime interval)
    self._krm_nextShell = ct + startDur
    self.reloaddelay = self._krm_nextShell

    self:SetNextPrimaryFire(ct + startDur + 0.1)
    self:SetNextSecondaryFire(ct + startDur + 0.1)
    self.NextReload = ct + startDur + 0.1

    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)

    local num = math.min(self.Primary.ClipSize - self:Clip1(),
                         self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
    local amount = num * (self.Primary.ReloadTime or 1)
    self:SetNWFloat("ReloadTime", amount)
    self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
end

-- ReloadShotgun is called from CustomThink every tick while Reloading is true
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

    -- STOP conditions: clip full, no reserve, or fire pressed
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

        self._krm_nextShell = nil
        self.reloaddelay = nil

        if self.PostReload then self:PostReload() end
        return
    end

    -- TIMER-BASED shell insertion
    if self._krm_nextShell and ct >= self._krm_nextShell then
        local shellInterval = self.Primary.ReloadTime or 1
        self._krm_nextShell = ct + shellInterval

        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)

        -- Play the shell insertion sound (one per grenade inserted)
        if self.Primary.ShellSound then
            self:EmitSound(self.Primary.ShellSound, 70, 100, 1, CHAN_ITEM)
        end

        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end

-- CustomThink: dispatches ReloadShotgun every tick while reloading
function SWEP:CustomThink(ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
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
        self._krm_nextShell = nil
        self.reloaddelay = nil
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
-- HOLSTER / DEPLOY
-- ============================================================
function SWEP:Holster(wep)
    self._justExitedSprint = false
    self.wasZooming = false
    self.wasRunning = false
    self._krm_nextShell = nil
    self.reloaddelay = nil
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
    self._krm_nextShell = nil
    self.reloaddelay = nil
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
