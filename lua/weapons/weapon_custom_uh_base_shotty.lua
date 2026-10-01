-- weapon_custom_uh_base_shotty.lua
-- Deep-cleaned Underhell shotgun base for the Customized edition.
-- v1.1
--
-- Key changes from original:
--   * FIXED: `vm` no longer leaks to global scope (was missing `local`)
--   * FIXED: GrenadeTime → UH_GrenadeTime
--   * FIXED: Removed dead SendWeaponAnim(ACT_VM_IDLE) before pump
--   * Prediction gates standardized
--   * IsValid checks added

AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"

SWEP.PrintName  = "Underhell Custom Shotgun Base"
SWEP.Category   = "UnderHell Custom"

SWEP.Spawnable  = false
SWEP.AdminSpawnable = false

SWEP.ViewModelFOV = 64
SWEP.ViewModel  = "models/weapons/v_shot_m3_pg.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3_pg.mdl"

SWEP.Slot       = 3
SWEP.SlotPos    = 0

SWEP.HoldType   = "shotgun"
SWEP.FiresUnderwater = false
SWEP.Weight     = 45
SWEP.DrawCrosshair = false
SWEP.DrawAmmo   = true
SWEP.reloaddelay = 0
SWEP.SmokeWidth = 35
SWEP.PenetrationDepth = 12
SWEP.Shell      = "models/weapons/shotgun_shell.mdl"
SWEP.Shotgun    = true

SWEP.Primary.Sound     = Sound("weapons/uh_m3/m3_fire.wav")
SWEP.Primary.PumpSound  = Sound("weapons/uh_m3/m3_pump.wav")
SWEP.Primary.ClipSize  = 8
SWEP.Primary.Ammo      = "buckshot"
SWEP.Primary.DefaultClip = 8
SWEP.Primary.MinDamage = 4
SWEP.Primary.MaxDamage = 8
SWEP.Primary.Automatic = false
SWEP.Primary.TakeAmmo  = 1
SWEP.Primary.Force     = 13
SWEP.Primary.Spread    = 1.2
SWEP.Primary.Delay     = 1.1
SWEP.Primary.NumberofShots = 10
SWEP.Primary.MinRecoil = -4.5
SWEP.Primary.MaxRecoil = -5.8
SWEP.Primary.ReloadTime = 0.5

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.Ammo        = "none"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false

function SWEP:Initialize()
    BaseClass.Initialize(self)
    if self.Primary.ShellSound then util.PrecacheSound(self.Primary.ShellSound) end
    if self.IsPump then util.PrecacheSound(self.Primary.PumpSound) end
end

-- ============================================================
-- PostShoot — pump action
-- ============================================================
function SWEP:PostShoot()
    if not self.IsPump then return end
    if self:Clip1() <= 0 and GetConVar("uh_sv_realpump"):GetBool() then
        if timer.Exists("CustomUH_Shell_" .. self.Owner:SteamID()) then
            timer.Remove("CustomUH_Shell_" .. self.Owner:SteamID())
        end
    else
        timer.Simple(self.PumpDelay or 0.5, function()
            if not IsValid(self) or self:GetUHBool("Reloading") then return end
            if not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) then return end
            if self.Owner:GetActiveWeapon() != self then return end
            if SERVER or (CLIENT and IsFirstTimePredicted()) then
                self.Owner:EmitSound(self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE)
            end
            -- FIXED: removed dead SendWeaponAnim(ACT_VM_IDLE) before pump
            self:EasySendWeaponAnim("pump", ACT_SHOTGUN_PUMP)
        end)
    end
end

-- ============================================================
-- ReloadShotgun — per-shell insertion loop
-- ============================================================
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end
    if not IsValid(self.Owner) then return end

    -- Stop conditions: clip full, no reserve, or player pressed fire
    if self:Clip1() >= self.Primary.ClipSize
       or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
       or self.Owner:KeyPressed(IN_ATTACK) then

        self:ClearAnimSounds()
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)

        -- FIXED: local vm (was global)
        local vm = self.Owner:GetViewModel()
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur
        self.reloaddelay = nil
        self:PostReload()
        return
    end

    -- Per-shell insertion
    if SERVER or not game.SinglePlayer() then
        if self.reloaddelay < ct then
            self.reloaddelay = ct + self.Primary.ReloadTime
            self:SetNextPrimaryFire(self.reloaddelay)
            if self.Primary.ShellSound then
                if SERVER or (CLIENT and IsFirstTimePredicted()) then
                    self.Owner:EmitSound(self.Primary.ShellSound, 75, 100, 1, CHAN_USER_BASE)
                end
            end
            self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)
            self:SetupAnimSounds("reload_loop")
            -- FIXED: local vm (was global)
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then vm:SetPlaybackRate(0.01) end
            timer.Simple(0.05, function()
                if not IsValid(self) then return end
                self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
            end)
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end

-- ============================================================
-- Reload — shotgun-specific
-- ============================================================
function SWEP:Reload()
    local ct = CurTime()
    if not IsValid(self.Owner) then return end

    -- FIXED: UH_GrenadeTime (was GrenadeTime)
    if self.NextReload < ct and not self:GetUHBool("Reloading") and not self:GetUHBool("Running")
       and self.Owner:GetNWFloat("UH_GrenadeTime") < ct
       and self:GetNWFloat("DeployTime") < ct then

        if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and self:Clip1() < self.Primary.ClipSize then
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

            self.Owner:DoReloadEvent()
            self.NextReload = ct + 0.5
            self:PreReload()

            -- Flashlight/flare interrupt handling (shared with gun base)
            if SERVER then
                if self.Owner:GetNWBool("UH_Flashlight") then
                    self.Owner:SetNWBool("UH_Flashlight", false)
                    self.Owner:SetNWBool("UH_ArmGone", false)
                    if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                        self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
                    end
                    self.Owner:EmitSound("uh/flashlight.wav")
                    self.b_reflashlight = true
                    net.Start("UH_Flashlight")
                        net.WriteEntity(self.Owner)
                        net.WriteBool(false)
                    net.Broadcast()
                elseif self.Owner:GetNWBool("UH_Flare") then
                    UHThrowFlare(self.Owner)
                    self.Owner:SetNWBool("UH_ArmGone", false)
                    if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                        self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
                    end
                end
            end

            self.reloaddelay = ct + self.Primary.ReloadTime
            self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)
            self:SetupAnimSounds("reload_start")

            self:SetNextPrimaryFire(ct + 0.5)
            self:SetNextSecondaryFire(ct + 0.5)
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)

            local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
            local amount = num * self.Primary.ReloadTime
            self:SetNWFloat("ReloadTime", amount)
            self:SetNWFloat("ReloadEndTime", ct + amount)
        end
    end
end

function SWEP:PreReload()
    if SERVER then
        self._backupClip = self:Clip1()
    end
end

function SWEP:PostReload()
    if not (GetConVar("uh_sv_realpump"):GetBool() and self.IsPump) then return end
    if SERVER and self._backupClip and self._backupClip <= 0 and self:Clip1() > self._backupClip then
        self._backupClip = nil
        local ct = CurTime()
        local delay = self.PumpDelay or 0.5
        self:CreateShell(self.ShellDelay, 0)
        self:SetNextPrimaryFire(ct + delay + 0.6)
        self:SetNextSecondaryFire(ct + delay + 0.6)
        self.NextReload = ct + delay + 0.6
        timer.Simple(delay, function()
            if not IsValid(self) or self:GetUHBool("Reloading") then return end
            if not IsValid(self.Owner) or not IsValid(self.Owner:GetActiveWeapon()) then return end
            if self.Owner:GetActiveWeapon() != self then return end
            self.Owner:EmitSound(self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE)
            self:EasySendWeaponAnim("rechamber", ACT_SHOTGUN_PUMP)
        end)
    end
end
