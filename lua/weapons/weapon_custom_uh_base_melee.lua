-- weapon_custom_uh_base_melee.lua
-- Deep-cleaned Underhell melee base for the Customized edition.
-- v1.1
--
-- Key changes from original:
--   * FIXED: SwingSound/HitSound/HitWorldSound now randomized per-swing (was file-load)
--   * FIXED: type(trace.Entity)=="NextBot" → trace.Entity.IsNextBot
--   * FIXED: Prediction gates standardized (server runs for MP broadcast)
--   * Added hooks: PreSwing, PostHit(trace, dmg), GetSwingAnim
--   * IsValid checks added

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

-- FIXED: sounds are now templates, randomized per-swing in PrimaryAttack
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
SWEP.Primary.Anim           = ACT_VM_MISSCENTER
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

-- ============================================================
-- Hooks for derived melee weapons (NEW)
-- ============================================================
function SWEP:PreSwing()
    -- Override in derived weapons to customize per-swing behavior
end

function SWEP:PostHit(trace, dmginfo)
    -- Override in derived weapons to add post-hit effects
end

function SWEP:GetSwingAnim()
    -- Override to return a custom activity
    return self.Primary.Anim
end

-- ============================================================
-- Initialize
-- ============================================================
function SWEP:Initialize()
    BaseClass.Initialize(self)
    -- FIXED: don't precache with random suffix — precache the template sounds
    -- The actual randomization happens per-swing in PrimaryAttack
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
    -- Initialize bob dampener to 1 (full bob) so it doesn't start at 0
    self._sprintFade = 1
    self:SetNWInt("FireMode", 1)
end

-- ============================================================
-- Think — lightweight (melee doesn't use gun's Think)
-- ============================================================
function SWEP:Think()
    if not IsValid(self.Owner) then return end
    local ct = CurTime()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        self:HandleBones(vm, ct)
        self:HandleHands(vm)
    end
    -- Don't call HandleRunning here — the Kate melee weapons have their own
    -- HandleSprintingAnimations() that uses EasySendWeaponAnim with the
    -- Animations table. HandleRunning uses SendWeaponAnim with ACT_* which
    -- doesn't look up the Animations table, so they conflict.
    -- The Kate weapons call HandleSprintingAnimations() in their Think.
    if self.CustomThink then self:CustomThink(ct) end
end

function SWEP:Reload()
    return false
end

-- ============================================================
-- PrimaryAttack — melee swing
-- ============================================================
function SWEP:PrimaryAttack()
    if not IsValid(self.Owner) then return end
    if self:GetNWFloat("DeployTime") > CurTime() then return end

    -- Hook: pre-swing
    self:PreSwing()

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

    -- Play swing animation
    self:SendWeaponAnim(self:GetSwingAnim())

    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    -- FIXED: standardized prediction gate (server runs for MP broadcast)
    if (sp and SERVER) or (not sp and (SERVER or (CLIENT and iftp))) then
        if GetConVar("uh_sv_voices"):GetBool() then
            self.Owner:EmitSound("uh/voice/melee/melee" .. math.random(1,8) .. ".wav", 100, math.random(80, 110), 1, CHAN_USER_BASE)
        end
    end

    -- FIXED: randomize sound per-swing (was randomized at file load)
    local swingSnd = self.Primary.SwingSound
    if istable(swingSnd) then swingSnd = swingSnd[math.random(1, #swingSnd)] end
    self:EmitSound(swingSnd, 100, math.random(90, 110), 1, CHAN_WEAPON)

    self.Owner:ViewPunch(self.Primary.Recoil)

    if SERVER or iftp then
        timer.Simple(self.Primary.HurtTime, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            if self.Owner:GetActiveWeapon() != self then return end

            local pos = self.Owner:GetShootPos()
            local aim = self.Owner:GetAimVector() * 64

            local tr = {}
            tr.start = pos
            tr.endpos = pos + aim
            tr.filter = self.Owner
            tr.mask = MASK_SHOT_HULL
            tr.mins = Vector(-16, -16, -16)
            tr.maxs = Vector(16, 16, 16)

            local trace = util.TraceHull(tr)

            if trace.Hit then
                if IsValid(trace.Entity) then
                    if SERVER then
                        local dmg = DamageInfo()
                        dmg:SetAttacker(self.Owner)
                        dmg:SetInflictor(self)
                        dmg:SetDamage(math.random(self.Primary.MinDamage, self.Primary.MaxDamage))
                        dmg:SetDamageForce(self.Owner:GetAimVector() * self.Primary.Force)
                        dmg:SetDamagePosition(trace.HitPos)
                        dmg:SetDamageType(self.Primary.DamageType)
                        trace.Entity:TakeDamageInfo(dmg)

                        -- Hook: post-hit
                        self:PostHit(trace, dmg)
                    end

                    -- FIXED: type()=="NextBot" → IsNextBot
                    if sp or (CLIENT and iftp) then
                        if trace.Entity:IsNPC() or trace.Entity:IsPlayer() or trace.Entity.IsNextBot then
                            -- FIXED: randomize per-hit
                            local hitSnd = self.Primary.HitSound
                            if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
                            if hitSnd then
                                self:EmitSound(hitSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
                            end
                            local ed = EffectData()
                            ed:SetOrigin(trace.HitPos)
                            util.Effect("BloodImpact", ed, true, true)
                        else
                            local hitWorldSnd = self.Primary.HitWorldSound
                            if istable(hitWorldSnd) then hitWorldSnd = hitWorldSnd[math.random(1, #hitWorldSnd)] end
                            if hitWorldSnd then
                                self:EmitSound(hitWorldSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
                            end
                        end
                    end
                elseif sp or (CLIENT and iftp) then
                    local hitWorldSnd = self.Primary.HitWorldSound
                    if istable(hitWorldSnd) then hitWorldSnd = hitWorldSnd[math.random(1, #hitWorldSnd)] end
                    if hitWorldSnd then
                        self:EmitSound(hitWorldSnd, 100, math.random(100, 120), 1, CHAN_WEAPON)
                    end
                    local mat = trace.MatType
                    if mat == MAT_CONCRETE or mat == MAT_METAL or mat == MAT_VENT or mat == MAT_TILE or mat == MAT_GRATE then
                        local fx = EffectData()
                        fx:SetOrigin(trace.HitPos)
                        fx:SetScale(1)
                        util.Effect("uh_hitworld", fx)
                    end
                end
            end
        end)
    end
end

function SWEP:SecondaryAttack()
    return false
end

-- ============================================================
-- Kate melee system — MeleeAttack / DoMeleeTrace / EndMelee
-- ============================================================
-- These are used by Kate WWII melee weapons (kate_trenchknife, etc.)
-- which have their own PrimaryAttack that calls self:MeleeAttack().
-- The melee base's PrimaryAttack is simpler (timer-based), but the
-- Kate weapons use a state-machine approach with hit delay timing.

function SWEP:MeleeAttack()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end

    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end

    self._meleeActive = true
    self:ClearAnimSounds()

    -- Play the melee animation from the Animations table
    -- Look up "melee" key, fall back to "shoot", then ACT_VM_MELEE
    local animKey = "melee"
    if self.Animations and self.Animations[animKey] then
        self:EasySendWeaponAnim(animKey, ACT_VM_MISSLEFT)
    elseif self.Animations and self.Animations["shoot"] then
        self:EasySendWeaponAnim("shoot", ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_MISSLEFT)
    end

    -- Use Primary.Delay for timing (not animation duration — that can be 0
    -- if the sequence isn't found, causing EndMelee to fire immediately)
    local delay = self.Primary.Delay or 0.6
    local hurtTime = self.Primary.HurtTime or 0.15
    self._meleeHitTime = ct + hurtTime
    self._meleeHitDone = false
    self._meleeEndTime = ct + delay
    self._nextMelee = ct + delay
    self:SetNextPrimaryFire(ct + delay)
    self:SetNextSecondaryFire(ct + delay)
    self.NextReload = ct + delay

    -- 3rd person player attack animation (plays on the player's body)
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
    local ply = self.Owner
    if not IsValid(ply) then return end
    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64
    local tr = util.TraceHull({
        start = pos, endpos = pos + aim * range,
        filter = ply, mask = MASK_SHOT_HULL,
        mins = Vector(-10,-10,-10), maxs = Vector(10,10,10),
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
            end
            if SERVER then util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32) end

            -- Hit entity sound (flesh/hit sound)
            local hitSnd = self.Primary.HitSound
            if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
            if hitSnd and hitSnd ~= "" then
                self:EmitSound(hitSnd, 75, 100, 1, CHAN_USER_BASE)
            end

            -- Blood impact effect for entities
            local ed = EffectData()
            ed:SetOrigin(tr.HitPos)
            util.Effect("BloodImpact", ed, true, true)
        else
            -- Hit the world (map geometry, not an entity)
            if SERVER then util.ScreenShake(tr.HitPos, 2, 0.1, 0.2, 32) end

            -- World hit sound: use HitWorldSound if set, otherwise HitSound,
            -- otherwise SwingSound as a last resort
            local worldSnd = self.Primary.HitWorldSound
            if not worldSnd then worldSnd = self.Primary.HitSound end
            if not worldSnd then worldSnd = self.Primary.SwingSound end
            if istable(worldSnd) then worldSnd = worldSnd[math.random(1, #worldSnd)] end
            if worldSnd and worldSnd ~= "" then
                self:EmitSound(worldSnd, 75, 100, 1, CHAN_USER_BASE)
            end

            -- World impact effect based on material type
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
            self:EmitSound(missSnd, 65, 100, 1, CHAN_USER_BASE)
        end
    end
    ply:ViewPunch(self.Primary.Recoil or Angle(-3,0,0))
end

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
end

-- ============================================================
-- DrawWorldModel — attach world model to player's hand bone
-- ============================================================
-- Positions the world model at the player's right hand bone using
-- WorldModelOffset and WorldModelAngle. This is needed because the
-- melee base doesn't inherit from weapon_cuh_base_gun (which has
-- its own DrawWorldModel with this logic).

if CLIENT then
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()

        -- Create the world model ClientsideModel lazily
        if not IsValid(self._wmClientModel) then
            self._wmClientModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
            if IsValid(self._wmClientModel) then
                self._wmClientModel:SetNoDraw(true)
            end
        end

        if IsValid(owner) then
            -- Position at the player's right hand bone
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

                        -- Update the model in case it was changed
                        if self._wmClientModel:GetModel() ~= self.WorldModel then
                            self._wmClientModel:SetModel(self.WorldModel)
                        end

                        self._wmClientModel:DrawModel()
                        return
                    end
                end
            end
        end

        -- Fallback: draw at weapon position (no owner or bone not found)
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
