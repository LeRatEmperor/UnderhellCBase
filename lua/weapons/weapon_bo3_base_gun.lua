AddCSLuaFile()

print("[CUH] weapon_bo3_base_gun.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

-- BO3 base gun inherits from weapon_cuh_base_gun, which provides:
-- - TFA-style attachment customization
-- - BO3-style camera bone procedural animation (CalcView)
-- - Animations/AnimSounds override system
-- - VElement/WElement model swap system
-- - Stat cache with restore-on-detach
-- - Save/load per SteamID
-- All BO3 weapons inherit from THIS file and get everything for free.

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName  = "BO3 Gun Base"
SWEP.Category   = "Black Ops III"
SWEP.SubCategory = ""

SWEP.Slot       = 3
SWEP.SlotPos    = 3

SWEP.Spawnable  = false
SWEP.AdminSpawnable = false
SWEP.IsCUHWeapon = true  -- marker for CUH menu detection

-- Appearance
SWEP.UseHands       = false
SWEP.ViewModelFlip  = false
SWEP.ViewModelFOV   = 65
SWEP.ViewModel      = "models/loyalists/blackops3/mr6/v_pistol_mr6.mdl"
SWEP.WorldModel     = "models/loyalists/blackops3/mr6/w_pistol_mr6.mdl"
SWEP.LoweredPos     = Vector(2.95, -3.057, -4.119)
SWEP.LoweredAng     = Vector(-13.131, 33.537, -29.906)

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.HoldType    = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov     = 20

SWEP.FireModes = {
    { name = "Semi-Auto" },
}

SWEP.Primary.Sound          = Sound("CW_BLACKOPS3_MR6_FIRE")
SWEP.Primary.ClipSize       = 20
SWEP.Primary.Ammo           = ".45 ACP"
SWEP.Primary.DefaultClip    = 120
SWEP.Primary.MinDamage      = 30
SWEP.Primary.MaxDamage      = 40
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.15
SWEP.Primary.Delay          = 50 / 600
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.5
SWEP.TwoHanded              = true
SWEP.ReloadSpeed            = 1
SWEP.Chambering             = true
SWEP.MantleDuration         = 0.6
SWEP.AnimatedSprint        = false

-- Camera bone config — inherited from CUH base's CalcView.
-- To enable camera bone animation, set this to the attachment name
-- on your viewmodel (e.g. "Camera"). Leave nil/empty for no camera
-- bone (no errors, no overhead).
--   SWEP.CameraAttachment = "Camera"
--   SWEP.CameraReserve    = false      -- true to invert the angle
--   SWEP.CameraOffset     = Angle(0, 0, 0) -- extra angle offset

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(0, 200, 255)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 50
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.6
SWEP.MeleeForce     = 300
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_00.wav"}
SWEP.MeleeMissSound = "nil"
SWEP.MeleeInterruptReload = true

SWEP._lastBO3IsVaulting = false
SWEP._lastBO3IsMantling = false

SWEP.IronSightsPos = Vector(-8.9801, 11.1574, 4.4512)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SwayPosition = 2.0

SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)

SWEP.Animations = {
    ["shoot"]        = "base_fire",
    ["reload"]       = "base_reload",
    ["reload_empty"] = "base_reload_empty",
    ["sprint_idle"]  = "base_idle",
    ["iron_fire"]    = "base_fire_ads",
    ["idle"]         = "base_idle",
    ["deploy"]       = "base_draw",
    ["melee"]        = "base_melee",
    ["mantle"]       = "base_mantle_over",
}

SWEP.AnimSounds = {}

-- CalcView is inherited from weapon_cuh_base_gun.lua, which handles
-- the BO3 camera bone system + parent base view bob/zoom.
-- No override needed here.

function SWEP:Initialize()
    BaseClass.Initialize(self)
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

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then
            self:MeleeAttack()
        end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

-- ==========================================
-- MELEE ATTACK
-- ==========================================

function SWEP:MeleeAttack()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end

    if self.MeleeInterruptReload ~= false and self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end

    self._meleeActive = true
    self:ClearAnimSounds()
    self:EasySendWeaponAnim("melee", ACT_VM_MELEE)

    local vm = self.Owner:GetViewModel()
    local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5

    self._meleeHitTime = ct + (self.MeleeHitDelay or 0.15)
    self._meleeHitDone = false
    self._meleeEndTime = ct + animDuration
    self._nextMelee = ct + (self.MeleeDelay or 0.6)

    self:SetNextPrimaryFire(ct + animDuration)
    self:SetNextSecondaryFire(ct + animDuration)
    self.NextReload = ct + animDuration

    local seqIdx = self.Owner:SelectWeightedSequence(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
    if seqIdx and seqIdx > 0 then
        self.Owner:AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, seqIdx, 0, true)
    end

    self:PlayMeleeSound(self.MeleeSound, 75, 100)
end

function SWEP:PlayMeleeSound(soundEntry, vol, pitch)
    if not soundEntry then return end
    local snd = soundEntry
    if istable(soundEntry) then
        snd = soundEntry[math.random(1, #soundEntry)]
    end
    if snd and snd ~= "" then
        self:EmitSound(snd, vol or 75, pitch or 100, 1, CHAN_USER_BASE)
    end
end

function SWEP:DoMeleeTrace()
    local ply = self.Owner
    if not IsValid(ply) then return end

    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64

    local tr = util.TraceHull({
        start = pos,
        endpos = pos + aim * range,
        filter = ply,
        mins = Vector(-10, -10, -10),
        maxs = Vector(10, 10, 10),
        mask = MASK_SHOT_HULL,
    })

    if tr.Hit then
        local target = tr.Entity
        if IsValid(target) and SERVER then
            local dmg = DamageInfo()
            dmg:SetDamage(self.MeleeDamage or 50)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(self)
            dmg:SetDamageForce(aim * (self.MeleeForce or 300))
            dmg:SetDamagePosition(tr.HitPos)
            dmg:SetDamageType(DMG_CLUB)
            target:TakeDamageInfo(dmg)
        end
        if SERVER then
            util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32)
        end
        self:PlayMeleeSound(self.MeleeHitSound, 75, 100)
    else
        self:PlayMeleeSound(self.MeleeMissSound, 65, 100)
    end
    ply:ViewPunch(self.MeleeViewPunch or Angle(-3, 0, 0))
end

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self:ClearAnimSounds()
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

-- ==========================================
-- MANTLE
-- ==========================================

function SWEP:StartMantle()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end
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
    local animDuration = IsValid(vm) and vm:SequenceDuration() or (self.MantleDuration or 0.6)
    local mantleDur = math.max(animDuration, self.MantleDuration or 0.6)
    self._mantleEndTime = ct + mantleDur

    self:SetNextPrimaryFire(ct + mantleDur)
    self:SetNextSecondaryFire(ct + mantleDur)
    self.NextReload = ct + mantleDur
end

function SWEP:EndMantle()
    self._mantleActive = false
    self._mantleEndTime = nil
    self:ClearAnimSounds()
end

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
    self:HandleSprintingAnimations()
end

function SWEP:Holster()
    if self._meleeActive then
        self._meleeActive = false
        self._meleeHitTime = nil
        self._meleeHitDone = nil
        self._meleeEndTime = nil
        self:ClearAnimSounds()
    end
    if self._mantleActive then
        self._mantleActive = false
        self._mantleEndTime = nil
        self:ClearAnimSounds()
    end
    self._burstRemaining = nil
    self._burstNextFire = nil
    self._isRechambering = false
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(self)
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    self:SetHoldType(self.HoldType)
    if self.Animations and self.Animations["deploy"] then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW)
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
    self._lastBO3IsVaulting = false
    self._lastBO3IsMantling = false
    self._justExitedSprint = false
    -- Apply attachments on deploy so defaults/saved selections materialize.
    timer.Simple(0, function()
        if IsValid(self) and self.ApplyAttachments then
            self:ApplyAttachments()
        end
    end)
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

function SWEP:HandleSprintingAnimations()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local isRunning = self:GetUHBool("Running")
    local isReloading = self:GetUHBool("Reloading")
    if self.wasRunning == nil then self.wasRunning = false end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    if isRunning and not self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)
        end
    elseif not isRunning and self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)
        end
        self._justExitedSprint = true
    elseif isRunning and not isReloading then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end
    self.wasRunning = isRunning
end
