-- weapon_custom_uh_base.lua
-- Deep-cleaned Underhell SWEP base for the Customized edition.
-- v1.2 — CalcView/PreDrawVM now check wep.Base for "custom_uh_base" instead of class name
--
-- Key changes from original:
--   * All file-scope lerp upvalues moved to self._xxx (fixes weapon-switch state bleed)
--   * Prediction gates standardized
--   * Dead code removed
--   * Bugs fixed (Deploy return, HandleRunning cancel, DrawWeaponSelection precedence, etc.)
--   * ConVar lookups cached
--   * IsValid checks added throughout
--   * Ease-in ironsight interpolation (snappier feel)
--   * Configurable ironsight/zoom speeds via SWEP fields

AddCSLuaFile()
SWEP.Base = "weapon_base"

-- ============================================================
-- getUHCacheMat — cached Material() lookup
-- ============================================================
-- Returns a cached IMaterial for the given material path, creating
-- it on first access and reusing on subsequent calls. This avoids
-- creating new IMaterial objects every frame in HandleHands().
-- ============================================================
local UH_MaterialCache = UH_MaterialCache or {}
function getUHCacheMat(matPath)
    if not matPath then return nil end
    if UH_MaterialCache[matPath] then return UH_MaterialCache[matPath] end
    local mat = Material(matPath)
    if not mat then return nil end
    if mat:GetName() == "___error" then return nil end
    UH_MaterialCache[matPath] = mat
    return mat
end

SWEP.PrintName        = "Underhell Custom Base"
SWEP.Category         = "UnderHell Custom"
SWEP.UseHands         = false

SWEP.Spawnable        = false
SWEP.AdminSpawnable   = false

-- ============================================================
-- Initialize — sets up view state, can be overridden
-- ============================================================
function SWEP:Initialize()
    self:ResetViewState()
end

SWEP.ViewModelFOV     = 64
SWEP.ViewModel        = "models/weapons/v_smg_mp5_pg.mdl"
SWEP.WorldModel       = "models/weapons/w_smg_mp5_pg.mdl"

SWEP.AutoSwitchTo     = true
SWEP.AutoSwitchFrom   = true

SWEP.Slot             = 2
SWEP.SlotPos          = 3

SWEP.HoldType         = "smg"
SWEP.PassiveAnim      = "passive"
SWEP.FiresUnderwater  = false
SWEP.Weight           = 45
SWEP.DrawCrosshair    = false
SWEP.DrawAmmo         = true
SWEP.DrawWeaponInfoBox = false

SWEP.Primary.ClipSize   = 30
SWEP.Primary.Ammo       = "smg1"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic  = true

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.Ammo        = "none"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false

SWEP.SwayScale = 0
SWEP.BobScale  = 0

SWEP.SwayPosition = 2
SWEP.LoweredPos   = Vector(0, 0, 0)
SWEP.LoweredAng   = Angle(0, 0, 0)

SWEP.AnimatedFirstDraw = false
SWEP.AnimatedSprint = false

-- Configurable ironsight/zoom speeds
SWEP.IronsightSpeed  = 10
SWEP.IronsightEaseIn = 1.5
SWEP.ZoomSpeedIn     = 15
SWEP.ZoomSpeedOut    = 10

-- ============================================================
-- TFA-style curved ironsight transition
-- ============================================================
-- Instead of a straight-line lerp from hip to ironsight, the gun dips
-- down/back through a sine bump, then recovers to the iron position.
-- This mimics the natural wrist motion of shouldering a rifle.
--
-- The dip is a sine wave (0 at start, peaks at midpoint, 0 at end) so
-- the start and end positions are NEVER changed — only the middle of
-- the transition is displaced.
--
-- Per-weapon tuning (override in any weapon file):
--   SWEP.IronSightsDipPos   = Vector(right, forward, up)  — dip direction
--   SWEP.IronSightsDipAng   = Angle(pitch, yaw, roll)     — dip angle
--   SWEP.IronSightsDipScale = 1.0                          — 0 disables curve
--
-- Defaults:
SWEP.IronSightsDipPos   = Vector(0, -1.5, -2.0)   -- back & down at midpoint
SWEP.IronSightsDipAng   = Angle(3, 0, 0)           -- muzzle tilts down ~3deg
SWEP.IronSightsDipScale = 1.0                       -- set 0 to disable

SWEP.IronSightsPos = Vector(-6, -8, -10)
SWEP.IronSightsAng = Vector(20, 40, -60)
SWEP.Inspection = {}
SWEP.HideMaterials = {}
SWEP.VM3D2D = {}
SWEP.LeftBones = { ["Left_U_Arm"] = Angle(-50, 50, -50) }

-- ============================================================
-- STATE INITIALIZATION
-- ============================================================
function SWEP:ResetViewState()
    self._ironBlend    = 0
    self._ironBlendLat = 0
    self._ironBlendFwd = 0
    self._swayAng      = Angle(0, 0, 0)
    self._oldEyeAng    = Angle(0, 0, 0)
    self._viewBobP     = 0
    self._viewBobY     = 0
    self._zoomBlend    = 0
    self._blurAmount   = 0
    self._inspectAng   = Angle(0, 0, 0)
    self._inspectPos   = Vector(0, 0, 0)
    self._grenadeLerp = 0
    self._jumpBlend    = 0
    self._lookBlend    = 0
    self._sightMult    = 0
    self._bobLerp      = 0
    self._bobSmooth    = 0
    self._bobAbs       = 0
    self._runDir       = 0
    self._breathP      = 0
    self._breathY      = 0
    self._breathR      = 0
    self._velOffset    = Vector(0, 0, 0)
    self._erp          = 0
    self._erpDecay     = {}
    self._bobTime      = 0
    self._bobNextThink = 0
    self._oldHandTex   = nil
    self._grenLerp     = 0
    self._handSkin     = nil
end

-- ============================================================
-- CONVAR CACHE
-- ============================================================
local cv_sway, cv_bob, cv_idle, cv_deploy, cv_blur, cv_blur_amount, cv_viewbob, cv_hands

local function cache_convars()
    cv_sway        = cv_sway        or GetConVar("uh_vmsway")
    cv_bob         = cv_bob         or GetConVar("uh_vmbob")
    cv_idle        = cv_idle        or GetConVar("uh_vmidle")
    cv_deploy      = cv_deploy      or GetConVar("uh_sv_deploy")
    cv_blur        = cv_blur        or GetConVar("uh_blur")
    cv_blur_amount = cv_blur_amount or GetConVar("uh_blur_amount")
    cv_viewbob     = cv_viewbob     or GetConVar("uh_viewbob")
    cv_hands       = cv_hands       or GetConVar("uh_hands")
end

-- ============================================================
-- GetViewModelPosition
-- ============================================================
function SWEP:GetViewModelPosition(pos, ang)
    if not IsValid(self.Owner) then return pos, ang end
    local sp = game.SinglePlayer()
    local ct = CurTime()
    local ft = FrameTime()
    local iftp = IsFirstTimePredicted()
    if sp then iftp = true end
    if CLIENT then iftp = true end

    if not self._ironBlendLat then self:ResetViewState() end

    -- Per-weapon toggle: if UseViewModelBob is false, skip ALL viewmodel
    -- position modifications (Sway, Movement, Sights, Inspect, Grenade).
    -- This is for weapons that use pose-parameter-driven additive animations
    -- (like TRM/MW base weapons) where the model handles ironsights,
    -- sprint, walk, and empty via pose parameters — the parent base's
    -- position-based bobbing/sway fights with the pose parameter system
    -- and causes a visual "switching between two positions every frame" bug.
    if self.UseViewModelBob == false then
        return pos, ang
    end

    pos, ang = self:Inspect(pos, ang, ct)
    pos, ang = self:Grenade(pos, ang, ct, ft, iftp)
    pos, ang = self:Sway(pos, ang, ft, iftp)
    pos, ang = self:Movement(pos, ang, ct, ft, iftp)
    if self.IronSightsPos and self.IronSightsAng then
        pos, ang = self:Sights(pos, ang, ft, iftp)
    end
    return pos, ang
end

-- ============================================================
-- Inspect
-- ============================================================
function SWEP:Inspect(pos, ang, ct)
    if not cv_deploy or not cv_deploy:GetBool() then return pos, ang end
    local t = self:GetNWFloat("DeployTime") - ct
    if t <= 0 then return pos, ang end
    if not self.Inspection or not self.Inspection[1] then return pos, ang end

    if t > 2 then
        local p = math.Clamp((1-(t-2))*2, 0, 1)
        local stage = self.Inspection[1]
        self._inspectAng = LerpAngle(p, Angle(0,0,0), stage.ang)
        self._inspectPos = LerpVector(p, Vector(0,0,0), stage.pos)
    elseif t > 1 then
        local p = math.Clamp((1-(t-1))*2, 0, 1)
        local oldstage = self.Inspection[1]
        local stage = self.Inspection[2] or oldstage
        self._inspectAng = LerpAngle(p, oldstage.ang, stage.ang)
        self._inspectPos = LerpVector(p, oldstage.pos, stage.pos)
    else
        local p = 1-t
        local stage = self.Inspection[2] or self.Inspection[1]
        self._inspectAng = LerpAngle(p, stage.ang, Angle(0,0,0))
        self._inspectPos = LerpVector(p, stage.pos, Vector(0,0,0))
    end

    ang:RotateAroundAxis(ang:Right(),    self._inspectAng.p)
    ang:RotateAroundAxis(ang:Up(),       self._inspectAng.y)
    ang:RotateAroundAxis(ang:Forward(),  self._inspectAng.r)
    pos = pos + ang:Right()*self._inspectPos.x + ang:Forward()*self._inspectPos.y + ang:Up()*self._inspectPos.z
    return pos, ang
end

-- ============================================================
-- Grenade
-- ============================================================
function SWEP:Grenade(pos, ang, ct, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    if iftp then
        local grenTime = self.Owner:GetNWFloat("UH_GrenadeTime")
        if grenTime > ct then
            local t = grenTime - ct
            if t > 0.5 then
                self._grenadeLerp = Lerp(math.Clamp(ft*6,0,1), self._grenadeLerp or 0, 1)
            else
                self._grenadeLerp = Lerp(math.Clamp(ft*6,0,1), self._grenadeLerp or 0, 0)
            end
        else
            self._grenadeLerp = Lerp(math.Clamp(ft*6,0,1), self._grenadeLerp or 0, 0)
        end
    end
    ang:RotateAroundAxis(ang:Up(),      -self._grenadeLerp*12)
    ang:RotateAroundAxis(ang:Forward(),  self._grenadeLerp*5)
    return pos, ang
end

-- ============================================================
-- Sights — staged ironsight blend (X/Y first, then Z)
-- ============================================================
-- Two-phase ADS movement matching good FPS game feel:
--   Phase 1: Gun snaps to the correct screen position (IronSightsPos.x/y)
--            quickly — the lateral/vertical alignment.
--   Phase 2: Gun eases forward into the eye (IronSightsPos.z) AFTER
--            the screen position is established.
--
-- This produces a "present then push" motion that feels more natural
-- than a single linear lerp moving all 3 axes at once.
--
-- Tunables per-weapon:
--   SWEP.IronsightSpeed       — base lerp speed (default 10)
--   SWEP.IronsightEaseIn      — ease-in factor (default 1.5)
--   SWEP.IronsightLateralSpeed — multiplier for X/Y phase (default 1.8x faster)
--   SWEP.IronsightForwardDelay — how long to wait before Z starts (default 0.0 = immediate, but slower speed handles it)
--   SWEP.IronsightForwardSpeed — multiplier for Z phase (default 0.6x slower)
-- ============================================================
function SWEP:Sights(pos, ang, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    if iftp then
        local target = self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0

        -- Phase 1: Lateral blend (X/Z screen position) — moves FASTER
        local currentLat = self._ironBlendLat or 0
        local remainingLat = math.abs(target - currentLat)
        local baseSpeed = self.IronsightSpeed or 10
        local easeIn = self.IronsightEaseIn or 1.5
        local latSpeedMult = self.IronsightLateralSpeed or 1.8
        local speedLat = math.min(ft * baseSpeed * latSpeedMult * (1 + (1 - remainingLat) * easeIn), 1)
        self._ironBlendLat = Lerp(speedLat, currentLat, target)

        -- Phase 2: Forward blend (Y depth) — moves SLOWER
        -- No hold/threshold logic — just a slower speed multiplier.
        -- The lateral arrives at the target first because it's 3x faster,
        -- creating the "present then push" effect naturally without
        -- any oscillation from threshold checks.
        local currentFwd = self._ironBlendFwd or 0
        local remainingFwd = math.abs(target - currentFwd)
        local fwdSpeedMult = self.IronsightForwardSpeed or 0.6
        local speedFwd = math.min(ft * baseSpeed * fwdSpeedMult * (1 + (1 - remainingFwd) * easeIn), 1)
        self._ironBlendFwd = Lerp(speedFwd, currentFwd, target)
    end

    local pLat = self._ironBlendLat or 0  -- lateral blend (X/Y)
    local pFwd = self._ironBlendFwd or 0  -- forward blend (Z)
    local p = pLat  -- for dip calculation, use lateral progress

    -- ============================================================
    -- TFA-STYLE CURVED IRONSIGHT TRANSITION
    -- ============================================================
    -- Sine bump: 0 at p=0, peaks at 1 when p=0.5, 0 at p=1.
    -- Added on top of the linear lerp so the gun dips below the
    -- straight-line path at the midpoint, then recovers to the
    -- iron position. Endpoints are NEVER changed.
    -- ============================================================
    local dipScale = self.IronSightsDipScale or 1.0
    if dipScale ~= 0 and p > 0 and p < 1 then
        local swoop = math.sin(p * math.pi) * dipScale
        local dipPos = self.IronSightsDipPos or vector_origin
        local dipAng = self.IronSightsDipAng or angle_zero
        pos = pos + ang:Right()   * (dipPos.x * swoop)
        pos = pos + ang:Forward() * (dipPos.y * swoop)
        pos = pos + ang:Up()      * (dipPos.z * swoop)
        ang:RotateAroundAxis(ang:Right(),   dipAng.p * swoop)
        ang:RotateAroundAxis(ang:Up(),       dipAng.y * swoop)
        ang:RotateAroundAxis(ang:Forward(),  dipAng.r * swoop)
    end

    -- Staged ironsight lerp:
    --   X/Z (horizontal + vertical) uses pLat — moves together to screen position
    --   Y (forward/depth) uses pFwd — eases forward after X/Z is in place
    -- GMod viewmodel coordinate system:
    --   offset.x = right (horizontal)
    --   offset.y = forward (depth, toward eye) — DELAYED
    --   offset.z = up (vertical)
    local offset = self.IronSightsPos
    if self.IronSightsAng then
        ang:RotateAroundAxis(ang:Right(),   self.IronSightsAng.x * pLat)
        ang:RotateAroundAxis(ang:Up(),       self.IronSightsAng.y * pFwd)
        ang:RotateAroundAxis(ang:Forward(),  self.IronSightsAng.z * pLat)
    end
    pos = pos + offset.x * pLat * ang:Right()
            + offset.y * pFwd * ang:Forward()
            + offset.z * pLat * ang:Up()
    return pos, ang
end

-- ============================================================
-- Sway
-- ============================================================
function SWEP:Sway(pos, ang, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    local sway = (cv_sway and cv_sway:GetFloat()) or 1.2
    if sway == 0 then return pos, ang end

    local eyeAng = self.Owner:EyeAngles()
    local angdelta = eyeAng - (self._oldEyeAng or eyeAng)
    if angdelta.y >= 180 then angdelta.y = angdelta.y - 360
    elseif angdelta.y <= -180 then angdelta.y = angdelta.y + 360 end
    angdelta.p = math.Clamp(angdelta.p, -5, 5)
    angdelta.y = math.Clamp(angdelta.y, -5, 5)
    angdelta.r = math.Clamp(angdelta.r, -5, 5)
    if self:GetUHBool("Zooming") then angdelta = angdelta * 0.05 end

    if iftp then
        self._swayAng = LerpAngle(math.Clamp(ft*10,0,1), self._swayAng or Angle(0,0,0), angdelta)
    end
    self._oldEyeAng = eyeAng

    local psway = sway / (self.SwayPosition or 2)
    local sa = self._swayAng or Angle(0,0,0)
    ang:RotateAroundAxis(ang:Right(),   -sa.p*sway)
    ang:RotateAroundAxis(ang:Up(),        sa.y*sway)
    ang:RotateAroundAxis(ang:Forward(),  sa.y*sway)
    pos = pos + ang:Right()*sa.y*psway + ang:Up()*sa.p*psway
    return pos, ang
end

-- ============================================================
-- Movement — bob, breathing, jump, look lean
-- ============================================================
function SWEP:Movement(pos, ang, ct, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    local bob = (cv_bob and cv_bob:GetFloat()) or 0
    local idle = (cv_idle and cv_idle:GetFloat()) or 0
    if bob == 0 and idle == 0 then return pos, ang end

    local owner = self.Owner
    local vel = owner:GetVelocity()
    local moveSpeed = math.sqrt(vel.x*vel.x + vel.y*vel.y)
    local maxSpeed = owner:GetRunSpeed()
    local maxWalk = owner:GetWalkSpeed()
    local onGround = owner:OnGround()
    local isRunning = self:GetUHBool("Running")
    local isZooming = self:GetUHBool("Zooming")
    local ft8 = math.Clamp(ft*8, 0, 1)

    if iftp then
        if isRunning and onGround then
            self._erpDecay = {}
            self._bobTime = ct * (3.7 + math.Clamp(maxSpeed/150, 0, 3)) * 2
            self._erp = math.cos(self._bobTime) * 2
        elseif moveSpeed > 0 and onGround then
            self._erpDecay = {}
            self._bobTime = ct * (2.75 + math.Clamp(maxWalk/120, 0, 2)) * 2
            self._erp = math.cos(self._bobTime) * 0.5
        elseif not onGround then
            if not self._erpDecay[1] then self._erpDecay = {self._erp, ct + 0.1} end
            self._erp = self._erpDecay[1] * math.Clamp((self._erpDecay[2]-ct)*2, 0, 1)
            self._bobNextThink = ct
        else
            if not self._erpDecay[1] then self._erpDecay = {self._erp, ct + 0.33} end
            self._erp = self._erpDecay[1] * math.Clamp((self._erpDecay[2]-ct)*3, 0, 1)
        end

        self._sightMult = Lerp(ft8, self._sightMult or 0, isZooming and 0.125 or 1)
        local walkRemapped = math.Clamp(moveSpeed/maxWalk, 0, 1)
        self._bobLerp = Lerp(ft*12, self._bobLerp or 0, (self._erp*walkRemapped*self._sightMult)*1.1)
        self._bobSmooth = Lerp(ft*4, self._bobSmooth or 0, self._bobLerp)
        self._bobAbs = Lerp(ft*10, self._bobAbs or 0, math.abs(self._bobLerp))
        self._runDir = Lerp(ft*14, self._runDir or 0, isRunning and -1 or 1)
        self._jumpBlend = Lerp(ft8, self._jumpBlend or 0, owner:GetMoveType()==MOVETYPE_NOCLIP and 0 or math.Clamp(vel.z/120, -1.5, 1))

        local velNorm = Vector(vel.x, vel.y, 0)
        velNorm:Normalize()
        local rd = owner:GetRight():Dot(velNorm)
        local mp = math.Clamp(moveSpeed/maxSpeed, 0, 1)
        if rd > 0.5 then
            self._lookBlend = Lerp(ft*5, self._lookBlend or 0, 5*mp)
        elseif rd < -0.5 then
            self._lookBlend = Lerp(ft*5, self._lookBlend or 0, -5*mp)
        else
            self._lookBlend = Lerp(ft*5, self._lookBlend or 0, 0)
        end
        self._velOffset = Lerp(ft*4, self._velOffset or Vector(0,0,0), -(velNorm/3)*walkRemapped)
    end

    pos = pos + ang:Up()*(self._jumpBlend or 0)
    ang.p = ang.p + (self._jumpBlend or 0)*2
    ang.r = ang.r + (self._lookBlend or 0)

    pos = pos + ang:Up()*(self._viewBobP or 0)
    pos = pos + ang:Right()*(self._viewBobY or 0)

    if bob ~= 0 and not (self.AnimatedSprint and isRunning) then
        pos = pos + ang:Right()*(self._bobLerp or 0)*(isRunning and 1 or 0.6)*bob
        pos = pos + ang:Up()*(self._bobAbs or 0)*2*(isZooming and -0.45 or 0.65)*(isRunning and 1 or 0.8)*bob
        pos.z = pos.z + (self._velOffset or Vector(0,0,0)).z*bob
        ang:RotateAroundAxis(ang:Up(),      -(self._bobSmooth or 0)*(self._runDir or 0)*10*bob)
        ang:RotateAroundAxis(ang:Right(),   -(self._bobSmooth or 0)*(self._runDir or 0)*1.2*bob)
        ang:RotateAroundAxis(ang:Forward(),  (self._bobSmooth or 0)*3*bob)
    end

    if idle ~= 0 then
        if not isRunning and not isZooming and moveSpeed < 1 then
            self._breathP = Lerp(ft*10, self._breathP or 0, math.sin(ct*0.5)*idle)
            self._breathY = Lerp(ft*10, self._breathY or 0, math.sin(ct*1)*0.5*idle)
            self._breathR = Lerp(ft*10, self._breathR or 0, math.sin(ct*2)*0.25*idle)
        else
            self._breathP = Lerp(ft*10, self._breathP or 0, 0)
            self._breathY = Lerp(ft*10, self._breathY or 0, 0)
            self._breathR = Lerp(ft*10, self._breathR or 0, 0)
        end
        ang.p = ang.p + (self._breathP or 0)*(self._sightMult or 1)
        ang.y = ang.y + (self._breathY or 0)*(self._sightMult or 1)
        ang.r = ang.r + (self._breathR or 0)*(self._sightMult or 1)
    end
    return pos, ang
end

-- ============================================================
-- FireAnimationEvent
-- ============================================================
function SWEP:FireAnimationEvent(pos, ang, event, options)
    return true
end

-- ============================================================
-- Animation helpers
-- ============================================================
function SWEP:EasySendWeaponAnim(lookupkey, fallbackact)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end
    if self.Animations and self.Animations[lookupkey] then
        local animData = self.Animations[lookupkey]
        if istable(animData) then animData = animData[math.random(1, #animData)] end
        local seq = vm:LookupSequence(animData)
        if seq and seq >= 0 then
            vm:SendViewModelMatchingSequence(seq)
            vm:SetCycle(0)
            return
        end
    end
    if type(fallbackact) == "number" then
        local s = vm:SelectWeightedSequence(fallbackact)
        if s and s >= 0 then vm:SendViewModelMatchingSequence(s) end
        vm:SetCycle(0)
    end
end

function SWEP:SendSequence(vm, seq)
    if not IsValid(vm) or seq == nil then return end
    vm:SendViewModelMatchingSequence(seq)
end

function SWEP:SendAnim(vm, lookupsequence, backup)
    if not IsValid(vm) then return end
    if isstring(lookupsequence) then
        local seq = vm:LookupSequence(lookupsequence)
        if seq and seq >= 0 then self:SendSequence(vm, seq) return end
    end
    if type(backup) == "number" then
        local s = vm:SelectWeightedSequence(backup)
        if s and s >= 0 then self:SendSequence(vm, s) end
    end
    vm:SetCycle(0)
end

function SWEP:SendWeaponAnim(act)
    if isstring(act) then self:EasySendWeaponAnim(act, nil)
    elseif type(act) == "number" then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            local s = vm:SelectWeightedSequence(act)
            if s and s >= 0 then vm:SendViewModelMatchingSequence(s) end
            vm:SetCycle(0)
        end
    end
end

function SWEP:LookupSequence(name)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return -1 end
    return vm:LookupSequence(name)
end

-- ============================================================
-- ClearAnimSounds
-- ============================================================
function SWEP:ClearAnimSounds()
    self._animSoundActive = false
    self._animSoundTimeline = nil
    self._animSoundIndex = 0
end

-- ============================================================
-- HandleRunning
-- ============================================================
function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end
    if self:GetNWBool("FirstDrawPlaying") then return end

    if self:GetUHBool("Running") or self:GetNWInt("FireMode") == 0 then
        self:SetHoldType(self.PassiveAnim)
    else
        self:SetHoldType(self.HoldType)
    end

    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

    local dist = self.Owner:GetVelocity():LengthSqr()
    if self.Owner:KeyDown(IN_SPEED) and dist > self.Owner:GetWalkSpeed()^2 then
        if not self:GetUHBool("Running") then
            local act = ACT_VM_IDLE_TO_LOWERED
            if self.HasSilencer and self:GetNWBool("Silenced") then
                act = ACT_VM_IDLE_SILENCED
            elseif self.Animations and self.Animations["idle_empty"] and self:Clip1() <= 0 then
                local vm2 = self.Owner:GetViewModel()
                if IsValid(vm2) then
                    local seq = vm2:LookupSequence(self.Animations["idle_empty"])
                    if seq and seq >= 0 then act = seq end
                end
            end
            self:SendWeaponAnim(ACT_VM_IDLE)
            self:SendWeaponAnim(act)
            if IsValid(vm) then vm:SetBodygroup(1, self:GetNWBool("Silenced") and 1 or 0) end
        end
        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
        -- FIXED: cancel reload properly
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", false)
            self:SetNWFloat("ReloadTime", 0)
            self:SetNWFloat("ReloadEndTime", 0)
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove("UHReload_"..self.Owner:SteamID())
            end
        end
    elseif self:GetUHBool("Running") then
        if self:GetNextPrimaryFire() < ct + 0.5 then
            self:SetNextPrimaryFire(ct + 0.5)
            self:SetNextSecondaryFire(ct + 0.5)
        end
        local act = ACT_VM_LOWERED_TO_IDLE
        if self.HasSilencer and self:GetNWBool("Silenced") then
            act = ACT_VM_IDLE_SILENCED
        elseif self.Animations and self.Animations["idle_empty"] and self:Clip1() <= 0 then
            local vm2 = self.Owner:GetViewModel()
            if IsValid(vm2) then
                local seq = vm2:LookupSequence(self.Animations["idle_empty"])
                if seq and seq >= 0 then act = seq end
            end
        end
        self:SendWeaponAnim(act)
        if IsValid(vm) then vm:SetBodygroup(1, self:GetNWBool("Silenced") and 1 or 0) end
        self:SetUHBool("Running", false)
    end
end

-- ============================================================
-- HandleBones
-- ============================================================
function SWEP:HandleBones(vm, ct)
    if not IsValid(self.Owner) then return end
    if game.SinglePlayer() or IsFirstTimePredicted() then
        self._grenLerp = Lerp(FrameTime()*5, self._grenLerp or 0,
            (self.Owner:GetNWFloat("UH_ArmTime") > ct or self.Owner:GetNWBool("UH_ArmGone")) and 1 or 0)
    end
    for bone, ang in pairs(self.LeftBones) do
        local bone_id = vm:LookupBone(bone)
        if not bone_id then continue end
        vm:ManipulateBoneAngles(bone_id, ang * (self._grenLerp or 0))
    end
    if self:GetNWBool("Silenced") or self:GetNWFloat("SilenceTime") > ct then
        vm:SetBodygroup(1, 1)
    else
        vm:SetBodygroup(1, 0)
    end
end

-- ============================================================
-- HandleHands
-- ============================================================
function SWEP:HandleHands(vm)
    if not IsValid(self.Owner) then return end
    local skin = math.Clamp(self.Owner:GetInfoNum("uh_hands", 0), -1, 3)
    if skin ~= -1 then
        vm:SetSkin(skin)
        if CLIENT and self._handSkin ~= skin then
            self._handSkin = skin
            local handmat = getUHCacheMat("models/weapons/v_models/hands/v_hands")
            local newmat = getUHCacheMat("models/weapons/v_models/hands/v_hands_casual")
            if handmat and newmat then
                local oldtex = handmat:GetTexture("$basetexture")
                local newtex = newmat:GetTexture("$basetexture")
                if not self._oldHandTex and oldtex ~= newtex and oldtex:GetName() ~= newtex:GetName() then
                    self._oldHandTex = {
                        tex = oldtex, detail = handmat:GetTexture("$detail"),
                        blendfactor = handmat:GetFloat("$detailblendfactor") or 0,
                        blendmode = handmat:GetInt("$detailblendmode") or 0,
                        scale = handmat:GetFloat("$detailscale") or 1,
                    }
                end
                handmat:SetTexture("$basetexture", newtex)
                handmat:SetTexture("$detail", newmat:GetTexture("$detail"))
                handmat:SetFloat("$detailblendfactor", newmat:GetFloat("$detailblendfactor"))
                handmat:SetInt("$detailblendmode", newmat:GetInt("$detailblendmode"))
                handmat:SetFloat("$detailscale", newmat:GetFloat("$detailscale"))
            end
        end
    else
        local handmat = getUHCacheMat("models/weapons/v_models/hands/v_hands")
        if handmat and self._oldHandTex then
            local detail = self._oldHandTex.detail
            handmat:SetTexture("$basetexture", self._oldHandTex.tex)
            handmat:SetTexture("$detail", detail and not string.find(detail:GetName(),"error") and detail or Material("color"):GetTexture("$basetexture"))
            handmat:SetFloat("$detailblendfactor", self._oldHandTex.blendfactor or 0)
            handmat:SetInt("$detailblendmode", self._oldHandTex.blendmode or 0)
            handmat:SetFloat("$detailscale", self._oldHandTex.scale or 1)
        end
    end
end

-- ============================================================
-- Deploy
-- ============================================================
function SWEP:Deploy()
    if SERVER then
        if not self.b_ammogiven then
            self.b_ammogiven = true
            if GetConVar("uh_sv_ammo"):GetBool() and self.Primary.ClipSize > 0 then
                self.Owner:GiveAmmo(self.Primary.ClipSize * 5, self.Primary.Ammo, true)
            end
        end
    end
    if self.CustomDeploy then self:CustomDeploy() end

    self:ResetViewState()
    self:ClearAnimSounds()

    self:SetUHBool("Reloading", false)
    self:SetUHBool("Zooming", false)
    self:SetUHBool("Running", false)
    self:SetNWFloat("ReloadTime", 0)
    self:SetNWFloat("ReloadEndTime", 0)
    self.NextReload = CurTime() + 0.5
    self:SetNextPrimaryFire(CurTime() + 1)
    self:SetNextSecondaryFire(CurTime() + 1)

    if not self:GetNWBool("FirstTimeDeployed") and GetConVar("uh_sv_deploy"):GetBool() then
        self:SetNWBool("FirstTimeDeployed", true)
        if self.AnimatedFirstDraw then
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            self:EasySendWeaponAnim("first_draw", ACT_VM_DRAW)
            local animDuration = IsValid(vm) and vm:SequenceDuration() or 3
            animDuration = math.max(3, animDuration)
            self:SetNextPrimaryFire(CurTime() + animDuration)
            self:SetNextSecondaryFire(CurTime() + animDuration)
            self.NextReload = CurTime() + animDuration
            self:SetNWBool("FirstDrawPlaying", true)
            timer.Simple(animDuration, function()
                if IsValid(self) then self:SetNWBool("FirstDrawPlaying", false) end
            end)
        else
            self:EasySendWeaponAnim("draw", ACT_VM_DRAW)
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            local animtime = math.max(3, IsValid(vm) and vm:SequenceDuration() or 3)
            self:SetNWFloat("DeployTime", CurTime() + animtime)
            if self.PreCock then
                timer.Simple(animtime - 1.5, function()
                    if not IsValid(self) or not IsValid(self.Owner) then return end
                    if not IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
                    self.Owner:EmitSound(self.Primary.PumpSound)
                    self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
                end)
            end
        end
    else
        self:EasySendWeaponAnim("draw", ACT_VM_DRAW)
    end
    return true  -- FIXED: was false
end

-- ============================================================
-- Holster
-- ============================================================
function SWEP:Holster(wep)
    -- Defensive: some derived weapons used to call BaseClass.Holster(wep)
    -- without passing `self`, which made `self` be the (sometimes NULL)
    -- `wep` argument and threw "Tried to use a NULL entity!" on
    -- self.Owner. Guard against NULL self here too so the error can never
    -- recur even if a future caller makes the same mistake.
    if not IsValid(self) then return true end
    if not IsValid(self.Owner) then return true end
    if not game.SinglePlayer() and not IsFirstTimePredicted() then return true end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        -- Guard against NULL entity when entering vehicles
        local wepBase = nil
        if IsValid(wep) then
            wepBase = wep.Base
        end
        if wepBase and string.find(wepBase, "custom_uh_base") then
            vm:SetSkin(0)
            if CLIENT and GetConVar("uh_hands"):GetInt() == 0 then
                local handmat = getUHCacheMat("models/weapons/v_models/hands/v_hands")
                if handmat and self._oldHandTex then
                    local detail = self._oldHandTex.detail
                    handmat:SetTexture("$basetexture", self._oldHandTex.tex)
                    handmat:SetTexture("$detail", detail and not string.find(detail:GetName(),"error") and detail or Material("color"):GetTexture("$basetexture"))
                    handmat:SetFloat("$detailblendfactor", self._oldHandTex.blendfactor or 0)
                    handmat:SetInt("$detailblendmode", self._oldHandTex.blendmode or 0)
                    handmat:SetFloat("$detailscale", self._oldHandTex.scale or 1)
                end
            end
        end
        for bone_id = 0, vm:GetBoneCount() - 1 do
            if not string.find(vm:GetBoneName(bone_id), "INVALIDBONE") then
                vm:ManipulateBonePosition(bone_id, Vector(0,0,0))
                vm:ManipulateBoneAngles(bone_id, Angle(0,0,0))
                vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
            end
        end
    end
    self:SetUHBool("Reloading", false)
    self:SetUHBool("Zooming", false)
    self:SetUHBool("Running", false)
    -- Reset ZoomFov lerp so the next weapon doesn't inherit a zoomed view
    self._zoomBlend = nil
    self._customUHChecked = nil  -- force re-check on next equip
    self:SetNWBool("FirstDrawPlaying", false)
    self:SetNWFloat("ReloadTime", 0)
    self:SetNWFloat("ReloadEndTime", 0)
    -- Nil guard: ClearAnimSounds is defined in this base (line ~494) AND in
    -- weapon_custom_uh_base_gun.lua (line ~271). However, when switching
    -- FROM a CUH-derived weapon (e.g. M8A1) to a non-CUH weapon, the
    -- engine can call Holster on a weapon instance whose metatable lookup
    -- for ClearAnimSounds returns nil (e.g. if a child base failed to
    -- inherit properly, or during partial-state edge cases like entering
    -- a vehicle). Guard against the nil case so holster never errors.
    if self.ClearAnimSounds then self:ClearAnimSounds() end
    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
    if timer.Exists("UHReload_"..self.Owner:SteamID()) then
        timer.Remove("UHReload_"..self.Owner:SteamID())
    end
    self.NextReload = CurTime() + 0.5
    if self.CustomHolster then self:CustomHolster(wep) end
    return true
end

function SWEP:ClientHolster()
    if game.SinglePlayer() then self:CallOnClient("ClientHolster") end
    if SERVER then return end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        vm:SetSubMaterial()
        vm:SetMaterial()
        vm:StopParticles()
    end
end

-- ============================================================
-- Think
-- ============================================================
function SWEP:Think()
    cache_convars()
    if not IsValid(self.Owner) then return end
    local ct = CurTime()
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        self:HandleBones(vm, ct)
        self:HandleHands(vm)
    end
    self:HandleRunning(ct)
end

-- ============================================================
-- CalcView — SWEP method (client-only)
-- ============================================================
-- This is the primary view-modification hook. The engine calls
-- SWEP:CalcView on the active weapon every frame. No class-name
-- check or inheritance walker is needed — if you inherit from this
-- base, you get the FOV zoom and view bob automatically.
--
-- Child weapons that override CalcView should call BaseClass.CalcView
-- first to preserve the FOV zoom / view bob behaviour:
--   function SWEP:CalcView(ply, pos, ang, fov)
--       pos, ang, fov = BaseClass.CalcView(self, ply, pos, ang, fov)
--       -- custom camera logic here
--       return pos, ang, fov
--   end
-- ============================================================
if CLIENT then
    -- Walks the SWEP inheritance chain looking for a Base named
    -- "custom_uh_base". Used by the PreDrawViewModel cleanup hook below.
    local function IsCustomUHWeapon(wep)
        if wep._customUHChecked then return wep._isCustomUH end
        wep._customUHChecked = true
        wep._isCustomUH = false
        local cur = wep
        local seen = {}
        local depth = 0
        while cur and not seen[cur] and depth < 16 do
            seen[cur] = true
            depth = depth + 1
            if cur.Base and string.find(cur.Base, "custom_uh_base") then
                wep._isCustomUH = true
                break
            end
            if not cur.Base then break end
            cur = weapons.GetStored(cur.Base)
        end
        return wep._isCustomUH
    end

    function SWEP:CalcView(ply, pos, ang, fov)
        if not IsValid(ply) then return end
        if ply:ShouldDrawLocalPlayer() then return end
        if not IsValid(self.Owner) or self.Owner ~= ply then return end

        local ft = FrameTime()
        local intensity = (cv_viewbob and cv_viewbob:GetFloat()) or 1
        local vel = ply:GetVelocity()
        local velLen = vel:Length()
        local onGround = ply:OnGround()
        local isZooming = self.GetUHBool and self:GetUHBool("Zooming")

        -- ============================================================
        -- VIEW BOB — position offset based on movement speed
        -- ============================================================
        if intensity > 0 and onGround and velLen > ply:GetWalkSpeed() * 0.3 then
            local zoomFactor = isZooming and 0.15 or 1
            if velLen < ply:GetWalkSpeed() * 1.2 then
                self._viewBobP = math.cos(CurTime()*15) * 1 * zoomFactor * intensity
                self._viewBobY = math.cos(CurTime()*12) * 0.5 * zoomFactor * intensity
            else
                self._viewBobP = math.cos(CurTime()*20) * 1.2 * zoomFactor * intensity
                self._viewBobY = math.cos(CurTime()*15) * 0.6 * zoomFactor * intensity
            end
        else
            self._viewBobP = Lerp(ft*10, self._viewBobP or 0, 0)
            self._viewBobY = Lerp(ft*10, self._viewBobY or 0, 0)
        end

        pos = pos + ang:Up() * (self._viewBobP or 0)
        pos = pos + ang:Right() * (self._viewBobY or 0)

        -- ============================================================
        -- SWEP.ZoomFov — FOV zoom while aiming down sights.
        -- ------------------------------------------------------------
        -- The player's view FOV is reduced by `ZoomFov` degrees while
        -- aiming. With the default SWEP.ZoomFov = 15 and a base FOV of
        -- 90, the aimed FOV is 75. Increase ZoomFov for more zoom:
        --   SWEP.ZoomFov = 30  →  aimed FOV = 60 (mild sniper)
        --   SWEP.ZoomFov = 60  →  aimed FOV = 30 (heavy sniper)
        --
        -- Tunables per-weapon:
        --   SWEP.ZoomFov       — FOV degrees to subtract while aiming (default 15)
        --   SWEP.ZoomSpeedIn   — lerp speed while aiming in  (default 15)
        --   SWEP.ZoomSpeedOut  — lerp speed while aiming out (default 10)
        -- ============================================================
        local zoomFov = self.ZoomFov or 0
        if zoomFov > 0 then
            local zoomSpeedIn  = self.ZoomSpeedIn  or 15
            local zoomSpeedOut = self.ZoomSpeedOut or 10
            local zoomSpeed    = isZooming and ft*zoomSpeedIn or ft*zoomSpeedOut
            local zoomTarget   = isZooming and zoomFov or 0
            local zoomCurrent  = self._zoomBlend or 0
            -- Ease-out: snap accelerates as it approaches the target
            local zoomRemaining = math.abs(zoomTarget - zoomCurrent) / math.max(zoomFov, 1)
            local zoomEaseSpeed = math.min(zoomSpeed * (1 + (1 - zoomRemaining) * 1.5), 1)
            self._zoomBlend = Lerp(zoomEaseSpeed, zoomCurrent, zoomTarget)
            fov = fov - (self._zoomBlend or 0)
        else
            self._zoomBlend = nil
        end

        return pos, ang, fov
    end

    -- PreDrawViewModel cleanup hook — this stays as a hook because it needs
    -- to run for ALL viewmodels (not just the active weapon's) to clear
    -- stale sub-materials from previous frames.
    hook.Add("PreDrawViewModel", "CustomUH_CleanupSubMaterials", function(vm, ply, wep)
        if not IsValid(wep) or not wep.GetClass then return end
        if not IsCustomUHWeapon(wep) then return end
        local materials = vm:GetMaterials()
        for i = 0, #materials - 1 do
            vm:SetSubMaterial(i, "")
        end
    end)
end

-- ============================================================
-- PreDrawViewModel
-- ============================================================
function SWEP:PreDrawViewModel()
    if self.Use2DScope and self:GetUHBool("Zooming") then
        render.SetBlend(0)
        return
    end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local materials = vm:GetMaterials()
        for i = 0, #materials - 1 do vm:SetSubMaterial(i, "") end
        if self.HideMaterials then
            for index = 1, #materials do
                local material = materials[index]
                if self.HideMaterials[material] then
                    vm:SetSubMaterial(index - 1, "engine/occlusionproxy")
                end
            end
        end
    end
    if not (cv_blur and cv_blur:GetBool()) then return end
    if (self.ScopeBlur and self:GetUHBool("Zooming")) or self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > CurTime() then
        self._blurAmount = math.Approach(self._blurAmount or 0, 1, FrameTime()*1.25)
    else
        self._blurAmount = math.Approach(self._blurAmount or 0, 0, FrameTime())
    end
    if (self._blurAmount or 0) > 0 then
        cam.Start2D()
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(Material("pp/blurscreen"))
            local b = (cv_blur_amount and cv_blur_amount:GetInt()) or 5
            local w, h = ScrW(), ScrH()
            for i = 1, b do
                Material("pp/blurscreen"):SetFloat("$blur", i * (self._blurAmount or 0))
                Material("pp/blurscreen"):Recompute()
                render.UpdateScreenEffectTexture()
                surface.DrawTexturedRect(0, 0, w, h)
            end
        cam.End2D()
    end
end

-- ============================================================
-- PostDrawViewModel — VM3D2D + VElements
-- ============================================================
function SWEP:PostDrawViewModel(vm)
    -- VElements (attachment models on viewmodel bones)
    if self.ViewModelElements then
        if not self._vElementsInit then self:InitVElements() end
        self:DrawVElements(vm)
    end

    -- VM3D2D (2D surfaces on bones)
    if self.VM3D2D then
        for name, elem in pairs(self.VM3D2D) do
            if not elem.bone or not elem.draw_func then continue end
            local boneIdx = vm:LookupBone(elem.bone)
            if not boneIdx then continue end
            local bonePos, boneAng = vm:GetBonePosition(boneIdx)
            if not bonePos then continue end
            local pos = Vector(bonePos)
            local ang = Angle(boneAng)
            pos = pos + ang:Right()*(elem.pos and elem.pos.x or 0)
            pos = pos + ang:Forward()*(elem.pos and elem.pos.y or 0)
            pos = pos + ang:Up()*(elem.pos and elem.pos.z or 0)
            ang:RotateAroundAxis(ang:Right(), (elem.ang and elem.ang.p) or 0)
            ang:RotateAroundAxis(ang:Up(), (elem.ang and elem.ang.y) or 0)
            ang:RotateAroundAxis(ang:Forward(), (elem.ang and elem.ang.r) or 0)
            cam.Start3D2D(pos, ang, elem.size or 0.004)
                elem.draw_func(self)
            cam.End3D2D()
        end
    end
end

-- ============================================================
-- HUD
-- ============================================================
function SWEP:HUDShouldDraw(name)
    if GetConVar("uh_hud"):GetBool() and (name == "CHudAmmo" or name == "CHudSecondaryAmmo") then
        return false
    end
    return true
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
    y = y + 10; x = x + 10; wide = wide - 20; tall = tall - 20
    if self.WorldModel and self.WorldModel ~= "" then
        if not IsValid(self._selectionModel) then
            self._selectionModel = ClientsideModel(self.WorldModel, RENDER_GROUP_OPAQUE_ENTITY)
            self._selectionModel:SetNoDraw(true)
        else
            self._selectionModel:SetModel(self.WorldModel)
            local vec = Vector(48, 48, 48)
            local ang = Vector(-48, -48, -48):Angle()
            cam.Start3D(vec, ang, 20, x, y+35, wide, tall, 5, 4096)
                cam.IgnoreZ(true)
                render.SuppressEngineLighting(true)
                render.SetLightingOrigin(self:GetPos())
                render.ResetModelLighting(50/255, 50/255, 50/255)
                render.SetColorModulation(1, 1, 1)
                render.SetBlend(alpha/255)
                render.SetModelLighting(4, 1, 1, 1)
                -- FIXED: operator precedence
                self._selectionModel:SetRenderAngles(Angle(0, (RealTime()*30) % 360, 0))
                self._selectionModel:DrawModel()
                self._selectionModel:SetRenderAngles()
                render.SetColorModulation(1, 1, 1)
                render.SetBlend(1)
                render.SuppressEngineLighting(false)
                cam.IgnoreZ(false)
            cam.End3D()
        end
    else
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetTexture(self.WepSelectIcon or -1)
        surface.DrawTexturedRect(x, y, wide, tall)
    end
    if self.Primary.ClipSize > 0 then
        local col = (self:Clip1()/self.Primary.ClipSize > 0.25) and Color(255,230,0,alpha) or Color(255,0,0,alpha)
        draw.SimpleText(self:Clip1().."/"..(IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) or 0),
            "HudSelectionText", x+wide/2, y+tall-14, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
    end
end
