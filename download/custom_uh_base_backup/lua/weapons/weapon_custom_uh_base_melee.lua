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
    self:HandleRunning(ct)
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
