-- weapon_custom_uh_base_melee.lua
-- Deep-cleaned Underhell melee base for the Customized edition.
-- v2.0 — Complete rewrite
--
-- Key systems:
--   * MeleeAttack/DoMeleeTrace/EndMelee state machine (for Kate weapons)
--   * Simple PrimaryAttack with timer-based hit (for basic melee)
--   * HandleRunning override (sets Running bool, does NOT play animations)
--   * DrawWorldModel override (attaches world model to hand bone)
--   * World hit sounds with fallback chain (HitWorldSound -> HitSound -> SwingSound)
--   * Impact effects for entities and world geometry

AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"

SWEP.PrintName  = "Underhell Custom Melee Base"
SWEP.Category   = "UnderHell Custom"

SWEP.Spawnable  = false
SWEP.AdminSpawnable = false

SWEP.ViewModelFOV = 64
SWEP.ViewModel  = "models/weapons/v_axe_pg.mdl"
SWEP.WorldModel = "models/weapons/w_axe_pg.mdl"

SWEP.Slot       = 0
SWEP.SlotPos    = 0

SWEP.HoldType   = "melee"
SWEP.FiresUnderwater = false
SWEP.Weight     = 45
SWEP.DrawCrosshair = false
SWEP.DrawAmmo   = false
SWEP.ViewModelFlip = false

-- Melee stats (overridden by derived weapons)
SWEP.Primary.SwingSound    = "weapons/axe/axe_swing1.wav"
SWEP.Primary.HitSound      = {"weapons/axe/axe_hitbod1.wav", "weapons/axe/axe_hitbod2.wav", "weapons/axe/axe_hitbod3.wav"}
SWEP.Primary.HitWorldSound  = {"weapons/axe/axe_hitworld1.wav", "weapons/axe/axe_hitworld2.wav"}
SWEP.Primary.MinDamage      = 45
SWEP.Primary.MaxDamage      = 65
SWEP.Primary.Force          = 2000
SWEP.Primary.HurtTime       = 0.25
SWEP.Primary.Delay          = 0.8
SWEP.Primary.Recoil         = Angle(0, 8, 0)
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = ""
SWEP.Primary.Anim           = ACT_VM_MISSLEFT
SWEP.Primary.DamageType     = DMG_SLASH

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = ""

SWEP.SwayScale = 0
SWEP.BobScale  = 0
SWEP.SwayPosition = 2

SWEP.IronSightsPos = Vector(4.8, -8.233, 2.789)
SWEP.IronSightsAng = Vector(0, 45.777, 9.289)

SWEP.Inspection = {
    { pos = Vector(4.8, -8.233, 2.789), ang = Angle(0, 45.777, 9.289) },
    { pos = Vector(6.4, -14.825, -1.05), ang = Angle(47.076, 46.24, 45.243) },
}

SWEP.MeleeRange = 64  -- default melee range

-- ============================================================
-- Hooks for derived melee weapons
-- ============================================================
function SWEP:PreSwing()
end

function SWEP:PostHit(trace, dmginfo)
end

function SWEP:GetSwingAnim()
    return self.Primary.Anim or ACT_VM_MISSLEFT
end

-- ============================================================
-- Initialize
-- ============================================================
function SWEP:Initialize()
    BaseClass.Initialize(self)
    if isstring(self.Primary.SwingSound) then util.PrecacheSound(self.Primary.SwingSound) end
    if istable(self.Primary.HitSound) then
        for _, snd in ipairs(self.Primary.HitSound) do util.PrecacheSound(snd) end
    end
    if istable(self.Primary.HitWorldSound) then
        for _, snd in ipairs(self.Primary.HitWorldSound) do util.PrecacheSound(snd) end
    end
    util.PrecacheModel(self.ViewModel)
    util.PrecacheModel(self.WorldModel)
    self:SetWeaponHoldType(self.HoldType)
    self:SetHoldType(self.HoldType)
    self._sprintFade = 1
    self:SetNWInt("FireMode", 1)
end

-- ============================================================
-- HandleRunning override — sets Running bool ONLY (no animations)
-- ============================================================
-- The parent's HandleRunning sets the Running bool AND plays sprint
-- animations via SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED). But the Kate
-- melee weapons have their own HandleSprintingAnimations() that uses
-- EasySendWeaponAnim("sprint_in") with the Animations table.
-- If both run, they conflict (wrong animation + animation fighting).
--
-- This override sets the Running bool (needed for _sprintFade in the
-- Movement function) but does NOT play any animations. The Kate
-- weapons' HandleSprintingAnimations() handles the animation part.
function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if self:GetNWBool("FirstDrawPlaying") then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

    -- Update hold type
    if self:GetUHBool("Running") or self:GetNWInt("FireMode") == 0 then
        self:SetHoldType(self.PassiveAnim)
    else
        self:SetHoldType(self.HoldType)
    end

    local dist = self.Owner:GetVelocity():LengthSqr()
    if self.Owner:KeyDown(IN_SPEED) and dist > self.Owner:GetWalkSpeed()^2 then
        -- Enter sprint — set Running bool (NO animation, let Kate weapon handle it)
        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
    elseif self:GetUHBool("Running") then
        -- Exit sprint — set Running false (NO animation, let Kate weapon handle it)
        self:SetUHBool("Running", false)
    end
end

-- ============================================================
-- Think
-- ============================================================
function SWEP:Think()
    if not IsValid(self.Owner) then return end
    local ct = CurTime()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        self:HandleBones(vm, ct)
        self:HandleHands(vm)
    end
    self:HandleRunning(ct)
    if self.CustomThink then self:CustomThink(ct) end
end

function SWEP:Reload()
    return false
end

-- ============================================================
-- PrimaryAttack — simple timer-based melee (for basic melee weapons)
-- ============================================================
function SWEP:PrimaryAttack()
    if not IsValid(self.Owner) then return end
    if self:GetNWFloat("DeployTime") > CurTime() then return end

    self:PreSwing()

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

    -- Play swing animation
    self:SendWeaponAnim(self:GetSwingAnim())

    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if (sp and SERVER) or (not sp and (SERVER or (CLIENT and iftp))) then
        if GetConVar("uh_sv_voices"):GetBool() then
            self.Owner:EmitSound("uh/voice/melee/melee" .. math.random(1,8) .. ".wav", 100, math.random(80, 110), 1, CHAN_USER_BASE)
        end
    end

    local swingSnd = self.Primary.SwingSound
    if istable(swingSnd) then swingSnd = swingSnd[math.random(1, #swingSnd)] end
    self:EmitSound(swingSnd, 100, math.random(90, 110), 1, CHAN_WEAPON)

    self.Owner:ViewPunch(self.Primary.Recoil)

    if SERVER or iftp then
        timer.Simple(self.Primary.HurtTime, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            if self.Owner:GetActiveWeapon() != self then return end
            self:DoMeleeHit()
        end)
    end
end

-- ============================================================
-- DoMeleeHit — shared hit logic (used by both PrimaryAttack and DoMeleeTrace)
-- ============================================================
function SWEP:DoMeleeHit()
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

    if tr.Hit then
        if IsValid(tr.Entity) then
            -- Hit an entity (player, NPC, prop)
            if SERVER then
                local dmg = DamageInfo()
                dmg:SetDamage(math.random(self.Primary.MinDamage or 50, self.Primary.MaxDamage or 50))
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamageForce(aim * (self.Primary.Force or 300))
                dmg:SetDamagePosition(tr.HitPos)
                dmg:SetDamageType(self.Primary.DamageType or DMG_CLUB)
                tr.Entity:TakeDamageInfo(dmg)
                self:PostHit(tr, dmg)
            end
            if SERVER then util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32) end

            -- Hit entity sound
            local hitSnd = self.Primary.HitSound
            if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
            if hitSnd and hitSnd ~= "" then
                self:EmitSound(hitSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
            end

            -- Blood impact effect
            local ed = EffectData()
            ed:SetOrigin(tr.HitPos)
            util.Effect("BloodImpact", ed, true, true)
        else
            -- Hit the world (map geometry)
            if SERVER then util.ScreenShake(tr.HitPos, 2, 0.1, 0.2, 32) end

            -- World hit sound: HitWorldSound -> HitSound -> SwingSound
            local worldSnd = self.Primary.HitWorldSound
            if not worldSnd then worldSnd = self.Primary.HitSound end
            if not worldSnd then worldSnd = self.Primary.SwingSound end
            if istable(worldSnd) then worldSnd = worldSnd[math.random(1, #worldSnd)] end
            if worldSnd and worldSnd ~= "" then
                self:EmitSound(worldSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
            end

            -- World impact effect
            local mat = tr.MatType
            if mat == MAT_CONCRETE or mat == MAT_METAL or mat == MAT_VENT or mat == MAT_TILE or mat == MAT_GRATE then
                local fx = EffectData()
                fx:SetOrigin(tr.HitPos)
                fx:SetScale(1)
                util.Effect("uh_hitworld", fx)
            end
        end
    else
        -- Missed — play swing sound
        local missSnd = self.Primary.SwingSound
        if istable(missSnd) then missSnd = missSnd[math.random(1, #missSnd)] end
        if missSnd and missSnd ~= "" then
            self:EmitSound(missSnd, 100, math.random(90, 110), 1, CHAN_WEAPON)
        end
    end
end

function SWEP:SecondaryAttack()
    return false
end

-- ============================================================
-- Kate melee state machine — MeleeAttack / DoMeleeTrace / EndMelee
-- ============================================================
-- Used by Kate WWII melee weapons which override PrimaryAttack and call
-- self:MeleeAttack(). This provides the state machine with hit delay.

function SWEP:MeleeAttack()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end

    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end

    self._meleeActive = true
    self:ClearAnimSounds()

    -- Play melee animation from Animations table
    local animKey = "melee"
    if self.Animations and self.Animations[animKey] then
        self:EasySendWeaponAnim(animKey, ACT_VM_MISSLEFT)
    elseif self.Animations and self.Animations["shoot"] then
        self:EasySendWeaponAnim("shoot", ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_MISSLEFT)
    end

    local delay = self.Primary.Delay or 0.6
    local hurtTime = self.Primary.HurtTime or 0.15
    self._meleeHitTime = ct + hurtTime
    self._meleeHitDone = false
    self._meleeEndTime = ct + delay
    self._nextMelee = ct + delay
    self:SetNextPrimaryFire(ct + delay)
    self:SetNextSecondaryFire(ct + delay)
    self.NextReload = ct + delay

    -- 3rd person player attack animation
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    local seqIdx = self.Owner:SelectWeightedSequence(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
    if seqIdx and seqIdx >= 0 then
        self.Owner:AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, seqIdx, 0, true)
    end

    local snd = self.Primary.SwingSound
    if istable(snd) then snd = snd[math.random(1, #snd)] end
    if snd and snd ~= "" then
        self:EmitSound(snd, 75, 100, 1, CHAN_USER_BASE)
    end
end

function SWEP:DoMeleeTrace()
    -- Just call DoMeleeHit (shared hit logic)
    self:DoMeleeHit()
end

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
end

-- ============================================================
-- DrawWorldModel — attach to player's hand bone
-- ============================================================
if CLIENT then
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()

        if not IsValid(self._wmClientModel) then
            self._wmClientModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
            if IsValid(self._wmClientModel) then
                self._wmClientModel:SetNoDraw(true)
            end
        end

        if IsValid(owner) then
            local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
            if boneid then
                local matrix = owner:GetBoneMatrix(boneid)
                if matrix then
                    local offsetVec = self.WorldModelOffset or Vector(0, -2, -1)
                    local offsetAng = self.WorldModelAngle or Angle(180, 90, 0)
                    local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

                    if IsValid(self._wmClientModel) then
                        self._wmClientModel:SetPos(newPos)
                        self._wmClientModel:SetAngles(newAng)
                        self._wmClientModel:SetupBones()

                        if self._wmClientModel:GetModel() ~= self.WorldModel then
                            self._wmClientModel:SetModel(self.WorldModel)
                        end

                        self._wmClientModel:DrawModel()
                        return
                    end
                end
            end
        end

        if IsValid(self._wmClientModel) then
            self._wmClientModel:SetPos(self:GetPos())
            self._wmClientModel:SetAngles(self:GetAngles())
            self._wmClientModel:SetupBones()
            self._wmClientModel:DrawModel()
        else
            self:DrawModel()
        end
    end
end

-- ============================================================
-- DrawHUD — minimal (just grenades counter)
-- ============================================================
if CLIENT then
    function SWEP:DrawHUD()
        if not GetConVar("cl_drawhud"):GetBool() then return end
        if self:GetNWFloat("DeployTime") > CurTime() then return end

        if GetConVar("uh_sv_grenades"):GetBool() then
            local grenades = self.Owner:GetAmmoCount("UH_Grenade")
            if grenades > 0 then
                draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2 + 1, ScrH()*0.8 + 1, Color(0,0,0,255), TEXT_ALIGN_CENTER)
                draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2, ScrH()*0.8, Color(255,255,255,255), TEXT_ALIGN_CENTER)
                draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2 + 1, ScrH()*0.8 + 23, Color(0,0,0,255), TEXT_ALIGN_CENTER)
                draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2, ScrH()*0.8 + 22, Color(255,255,255,255), TEXT_ALIGN_CENTER)
            end
        end
    end
end
