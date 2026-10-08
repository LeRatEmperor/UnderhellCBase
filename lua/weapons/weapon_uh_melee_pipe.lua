<<<<<<< HEAD
-- Lead Pipe — Ported from weapon_uh_base_melee to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell melee base (weapon_uh_base_melee)
-- to the CUH base (weapon_cuh_base_gun).
-- The Lead Pipe is a pure melee weapon:
--   - PrimaryAttack (M1) calls MeleeAttack() directly (no E+M1 gate)
--   - No ammo, no clip, no shell ejection
--   - Swing sound + body/world hit sounds (randomized per-swing)
--   - ACT_VM_MISSCENTER swing animation (Underhell melee pattern)
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_melee_pipe.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "Lead Pipe"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "Melees"
SWEP.UseHands                           = true

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_pipe_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_pipe_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 0
SWEP.SlotPos                            = 4

SWEP.HoldType                           = "melee"
SWEP.PassiveAnim                        = "normal"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.ViewModelFlip                      = false

-- ============================================================
-- PRIMARY (melee) STATS — preserved from source
-- ============================================================
-- Swing/Hit/HitWorld sounds use the table form so the CUH base
-- can randomize per-swing (the source computed the random suffix
-- once at file-load time, which was a bug — same sound every swing).
SWEP.Primary.SwingSound         = Sound( "weapons/uh_pipe/pipe_swing.wav" )
SWEP.Primary.HitSound           = {
    Sound( "weapons/uh_pipe/pipe_hitbod1.wav" ),
    Sound( "weapons/uh_pipe/pipe_hitbod2.wav" ),
    Sound( "weapons/uh_pipe/pipe_hitbod3.wav" ),
}
SWEP.Primary.HitWorldSound      = {
    Sound( "weapons/uh_pipe/pipe_hitworld1.wav" ),
    Sound( "weapons/uh_pipe/pipe_hitworld2.wav" ),
}
SWEP.Primary.MinDamage          = 35
SWEP.Primary.MaxDamage          = 45
SWEP.Primary.Force                      = 1800
SWEP.Primary.HurtTime           = 0.25
SWEP.Primary.Delay                      = 0.8
SWEP.Primary.Recoil                     = Angle(-4,-6,0)
SWEP.Primary.ClipSize           = -1
SWEP.Primary.DefaultClip        = -1
SWEP.Primary.Automatic          = true
SWEP.Primary.Ammo                       = "none"
SWEP.Primary.Anim                       = ACT_VM_MISSCENTER
SWEP.Primary.DamageType         = DMG_CLUB

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false
SWEP.Secondary.Ammo                     = "none"

-- No fire / shell ejection for a pure melee weapon
SWEP.NoShell    = true

-- ============================================================
-- CUH MELEE CONFIG — mapped from source Primary stats
-- ============================================================
-- MeleeAttack/DoMeleeTrace overrides below use these for the
-- swing timing, trace range, and view-punch.
SWEP.MeleeDamage    = 40     -- average (MinDamage+MaxDamage)/2; overridden in DoMeleeTrace
SWEP.MeleeMinDamage = 35
SWEP.MeleeMaxDamage = 45
SWEP.MeleeRange     = 64
SWEP.MeleeDelay     = 0.8     -- matches Primary.Delay (time between swings)
SWEP.MeleeForce     = 1800
SWEP.MeleeHitDelay  = 0.25    -- matches Primary.HurtTime (trace happens after this delay)
SWEP.MeleeViewPunch = Angle(-4, -6, 0)
SWEP.MeleeSound     = "weapons/uh_pipe/pipe_swing.wav"
SWEP.MeleeHitSound  = {
    "weapons/uh_pipe/pipe_hitbod1.wav",
    "weapons/uh_pipe/pipe_hitbod2.wav",
    "weapons/uh_pipe/pipe_hitbod3.wav",
}
SWEP.MeleeHitWorldSound = {
    "weapons/uh_pipe/pipe_hitworld1.wav",
    "weapons/uh_pipe/pipe_hitworld2.wav",
}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = false   -- melee weapon: no reload to interrupt

SWEP.FireModes = {
    { name = "Melee" }
}

SWEP.Animations = {}
SWEP.AnimSounds = {}

-- ============================================================
-- SMART MUZZLE / SHELL / DISPLAY (stubs — pure melee weapon)
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
    return ACT_VM_MISSCENTER
end

-- ============================================================
-- PRIMARY ATTACK — melee swing on M1 directly (no E+M1 gate)
-- ============================================================
-- This is the key override for melee weapons: holding M1 swings the
-- pipe. The cooldown (MeleeDelay / Primary.Delay) prevents spam.
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end

    local ct = CurTime()
    -- Respect swing cooldown (Primary.Delay on the source)
    if ct < (self._nextMelee or 0) then return end
    if self:GetNWFloat("DeployTime") > ct then return end

    if SERVER or IsFirstTimePredicted() then
        self:MeleeAttack()
    end
end

function SWEP:SecondaryAttack()
    -- Pure melee weapon: secondary does nothing
    return
end

function SWEP:Reload()
    -- Pure melee weapon: reload does nothing
    return
end

-- ============================================================
-- MELEE ATTACK — override to use ACT_VM_MISSCENTER (Underhell swing)
-- ============================================================
-- Same as BaseClass.MeleeAttack but plays the source's ACT_VM_MISSCENTER
-- swing animation and the pipe's swing sound (instead of ACT_VM_MELEE
-- + MeleeSound from CUH base).
function SWEP:MeleeAttack()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end

    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end

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
    -- Underhell melee swing animation (ACT_VM_MISSCENTER from source)
    self:SendWeaponAnim(self.Primary.Anim or ACT_VM_MISSCENTER)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5
    self._meleeHitTime = ct + (self.MeleeHitDelay or 0.15)
    self._meleeHitDone = false
    self._meleeEndTime = ct + animDuration
    self._nextMelee = ct + (self.MeleeDelay or 0.6)
    self:SetNextPrimaryFire(ct + animDuration)
    self:SetNextSecondaryFire(ct + animDuration)
    self.NextReload = ct + animDuration

    -- Play PLAYER_ATTACK1 gesture (3rd-person arm swing)
    self.Owner:SetAnimation(PLAYER_ATTACK1)

    local seqIdx = self.Owner:SelectWeightedSequence(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
    if seqIdx and seqIdx >= 0 then
        self.Owner:AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, seqIdx, 0, true)
    end

    -- Swing sound (randomized per-swing if it's a table)
    local snd = self.MeleeSound
    if istable(snd) then snd = snd[math.random(1, #snd)] end
    if snd and snd ~= "" then
        self:EmitSound(snd, 100, math.random(90, 110), 1, CHAN_WEAPON)
    end

    -- View punch (matches source Primary.Recoil)
    self.Owner:ViewPunch(self.MeleeViewPunch or Angle(-3, 0, 0))
end

-- ============================================================
-- DO MELEE TRACE — override to differentiate body vs world hits
-- (preserves source: Primary.HitSound on body, Primary.HitWorldSound on world)
-- ============================================================
function SWEP:DoMeleeTrace()
    local ply = self.Owner
    if not IsValid(ply) then return end
    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64
    local tr = util.TraceHull({
        start = pos, endpos = pos + aim * range,
        filter = ply, mask = MASK_SHOT_HULL,
        mins = Vector(-16, -16, -16), maxs = Vector(16, 16, 16),
    })

    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if tr.Hit then
        if IsValid(tr.Entity) then
            -- Apply damage on server
            if SERVER then
                local dmg = DamageInfo()
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamage(math.random(self.MeleeMinDamage or self.MeleeDamage,
                                           self.MeleeMaxDamage or self.MeleeDamage))
                dmg:SetDamageForce(aim * (self.MeleeForce or 300))
                dmg:SetDamagePosition(tr.HitPos)
                dmg:SetDamageType(self.Primary.DamageType or DMG_CLUB)
                tr.Entity:TakeDamageInfo(dmg)
            end

            if sp or (CLIENT and iftp) then
                -- Body hit sound (NPC/player/NextBot) vs world hit sound
                if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity.IsNextBot then
                    local hitSnd = self.MeleeHitSound
                    if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
                    if hitSnd and hitSnd ~= "" then
                        self:EmitSound(hitSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
                    end
                    local ed = EffectData()
                    ed:SetOrigin(tr.HitPos)
                    util.Effect("BloodImpact", ed, true, true)
                else
                    -- World/entity hit sound
                    local hitWorldSnd = self.MeleeHitWorldSound
                    if istable(hitWorldSnd) then hitWorldSnd = hitWorldSnd[math.random(1, #hitWorldSnd)] end
                    if hitWorldSnd and hitWorldSnd ~= "" then
                        self:EmitSound(hitWorldSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
                    end
                end
            end
            if SERVER then util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32) end
        elseif sp or (CLIENT and iftp) then
            -- Hit world (no entity)
            local hitWorldSnd = self.MeleeHitWorldSound
            if istable(hitWorldSnd) then hitWorldSnd = hitWorldSnd[math.random(1, #hitWorldSnd)] end
            if hitWorldSnd and hitWorldSnd ~= "" then
                self:EmitSound(hitWorldSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
            end
            local mat = tr.MatType
            if mat == MAT_CONCRETE or mat == MAT_METAL or mat == MAT_VENT or mat == MAT_TILE or mat == MAT_GRATE then
                local fx = EffectData()
                fx:SetOrigin(tr.HitPos)
                fx:SetScale(1)
                util.Effect("uh_hitworld", fx)
            end
        end
    else
        -- Miss sound (pipe has none — swing sound already played)
        if self.MeleeMissSound and self.MeleeMissSound ~= "" then
            self:EmitSound(self.MeleeMissSound, 65, 100, 1, CHAN_USER_BASE)
        end
    end
end

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self:ClearAnimSounds()
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
-- POST RELOAD (no-op for melee weapon — no reload to resume from)
-- ============================================================
function SWEP:PostReload()
end
=======
AddCSLuaFile()

SWEP.PrintName 				= "Lead Pipe"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Melees"
SWEP.UseHands 				= true
SWEP.Base					= "weapon_uh_base_melee"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_pipe_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pipe_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 0
SWEP.SlotPos 				= 4

SWEP.HoldType 				= "melee"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.ViewModelFlip			= false

SWEP.Primary.SwingSound		= Sound( "weapons/uh_pipe/pipe_swing.wav" )
SWEP.Primary.HitSound		= Sound( "weapons/uh_pipe/pipe_hitbod"..math.random(1,3)..".wav" )
SWEP.Primary.HitWorldSound	= Sound( "weapons/uh_pipe/pipe_hitworld"..math.random(1,2)..".wav" )
SWEP.Primary.MinDamage		= 35
SWEP.Primary.MaxDamage		= 45
SWEP.Primary.Force			= 1800
SWEP.Primary.HurtTime		= 0.25
SWEP.Primary.Delay			= 0.8
SWEP.Primary.Recoil			= Angle(-4,-6,0)
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""
SWEP.Primary.Anim			= ACT_VM_MISSCENTER
SWEP.Primary.DamageType		= DMG_CLUB

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""
>>>>>>> 963627a2ad1eb95ef5e1f82e13de3ca5bfdb473a
