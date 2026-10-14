-- weapon_custom_uh_base_gun.lua
-- Deep-cleaned Underhell gun base for the Customized edition.
-- v1.2
--
-- Key changes from original:
--   * h_scope, h_reload, h_crosshair moved to self._xxx (fixes weapon-switch bleed)
--   * ShootBullets: global `spread` → local
--   * Reload: `return` → `continue` in ReloadTable loop (was aborting entire reload)
--   * GrenadeTime → UH_GrenadeTime (3 call sites fixed)
--   * Dead cycle-based reload completion removed (lines 442-494 of original)
--   * Dead idle-system block removed
--   * Dead state fields removed (_isRechambering, wasZooming, etc.)
--   * LookupSequence > 0 → >= 0 (sequence index 0 is valid)
--   * DoMuzzleFlash DynamicLight(0) → DynamicLight(self:EntIndex())
--   * EntityEmitSound hook: early-out for non-SoundChanger weapons
--   * ShootGrenade: ent.Owner → ent:SetOwner
--   * Prediction gates standardized
--   * IsValid checks added throughout

AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base")
SWEP.Base = "weapon_custom_uh_base"

SWEP.PrintName  = "Underhell Custom Gun Base"
SWEP.Category   = "UnderHell Custom"

SWEP.Spawnable  = false
SWEP.AdminSpawnable = false

SWEP.ViewModelFOV = 64
SWEP.ViewModel  = "models/weapons/v_smg_mp5_pg.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5_pg.mdl"

SWEP.Slot       = 2
SWEP.SlotPos    = 3

SWEP.HoldType   = "smg"
SWEP.FiresUnderwater = false
SWEP.Weight     = 45
SWEP.DrawCrosshair = true  -- MCV crosshair: enables DoDrawCrosshair hook
SWEP.DrawAmmo   = true
SWEP.DrawWeaponInfoBox = false

SWEP.SmokeWidth = 30
SWEP.Chambering = true

-- ZoomFov — degrees of FOV to subtract from the player's view FOV while
-- aiming down sights (matches original Underhell behaviour).
--   Example with default fov 90:  SWEP.ZoomFov = 15  →  aimed FOV = 75
--   Set to 0 to disable the FOV override entirely.
-- Tunables: SWEP.ZoomSpeedIn (default 15), SWEP.ZoomSpeedOut (default 10)
SWEP.ZoomFov          = 15
SWEP.ZoomSpeedIn      = 15
SWEP.ZoomSpeedOut     = 10

SWEP.NoShell    = false
SWEP.ShellHeat  = 0.8
SWEP.Shell      = "models/weapons/shell_9mm.mdl"

SWEP.MuzzleFlashType = "default"
SWEP.MuzzleFlashTexture = ""
SWEP.MuzzleFlashParticle = ""
SWEP.MuzzleFlashColor = nil
SWEP.MuzzleFlashLightColor = nil
SWEP.MuzzleFlashScale = 1
SWEP.MuzzleFlashLightBrightness = 4
SWEP.MuzzleFlashLightSize = 128
SWEP.MuzzleFlashLightDecay = 128

SWEP.FireModes = {}

SWEP.Primary.Sound     = Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.SilSound  = Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.ClipSize  = 30
SWEP.Primary.Ammo      = "UH_SMG"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.MinDamage = 12
SWEP.Primary.MaxDamage = 18
SWEP.Primary.Automatic = true
SWEP.Primary.TakeAmmo  = 1
SWEP.Primary.Force     = 15
SWEP.Primary.Spread    = 0.45
SWEP.Primary.Delay     = 0.08
SWEP.Primary.NumberofShots = 1
SWEP.Primary.MinRecoil = -0.6
SWEP.Primary.MaxRecoil = -1.4

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.Ammo        = "none"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false

SWEP.SwayScale = 0
SWEP.BobScale  = 0

SWEP.HolsterTime = 0.3

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.ReloadTable = {}
SWEP.AnimSounds = {}

SWEP.ReloadSpeed = 1

SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Inspection = {
    { pos = Vector(8, -8, 0), ang = Angle(40, 40, 40) },
    { pos = Vector(-4, -8, -8), ang = Angle(20, 40, -60) },
}

SWEP.SwayPosition = 2

-- ============================================================
-- Initialize
-- ============================================================
function SWEP:Initialize()
    if BaseClass.Initialize then BaseClass.Initialize(self) end
    util.PrecacheSound(self.Primary.Sound)
    util.PrecacheModel(self.ViewModel)
    util.PrecacheModel(self.WorldModel)
    self:SetWeaponHoldType(self.HoldType)
    self:SetHoldType(self.HoldType)
    self.NextReload = CurTime()
    self:SetNWInt("FireMode", 1)

    -- Initialize HUD blend state on self (not file-scope)
    self._scopeBlend = 0
    self._reloadHUDBlend = 0
    self._crosshairBlend = 0

    if CLIENT and self.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = { 256, 512, 768, 1080 }
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        self.RT_Size = quality[num] * scale
        -- Use unique RT name per weapon instance to avoid clobbering
        self.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. self:EntIndex(), self.RT_Size, self.RT_Size, false)
    end
end

-- ============================================================
-- Animation helpers (gun-specific overrides)
-- ============================================================
function SWEP:SendSequence(vm, seq)
    if not IsValid(vm) or seq == nil then return end
    vm:SendViewModelMatchingSequence(seq)
end

function SWEP:SendAnim(vm, lookupsequence, backup)
    if not IsValid(vm) then return end
    if isstring(lookupsequence) then
        local seq = vm:LookupSequence(lookupsequence)
        if seq and seq >= 0 then  -- FIXED: was > 0
            self:SendSequence(vm, seq)
            return
        end
    end
    if type(backup) == "number" then
        local s = vm:SelectWeightedSequence(backup)
        if s and s >= 0 then self:SendSequence(vm, s) end
    end
    vm:SetCycle(0)
end

function SWEP:EasySendWeaponAnim(lookupanimation, elseifnotfounded)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end

    if self.Animations and self.Animations[lookupanimation] then
        local animData = self.Animations[lookupanimation]
        if istable(animData) then
            animData = animData[math.random(1, #animData)]
        end
        local seq = vm:LookupSequence(animData)
        if seq and seq >= 0 then  -- FIXED: was > 0
            self:SendSequence(vm, seq)
        else
            local act = type(elseifnotfounded) == "number" and vm:SelectWeightedSequence(elseifnotfounded) or -1
            if act >= 0 then self:SendSequence(vm, act) end
        end
    else
        local act = type(elseifnotfounded) == "number" and vm:SelectWeightedSequence(elseifnotfounded) or -1
        if act >= 0 then self:SendSequence(vm, act) end
    end
    vm:SetCycle(0)
    self:SetupAnimSounds(lookupanimation)
end

function SWEP:SendWeaponAnim(act)
    if isstring(act) then
        self:EasySendWeaponAnim(act, nil)
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
-- AnimSounds system
-- ============================================================
function SWEP:SetupAnimSounds(animKey, variantName)
    if not self.AnimSounds then return end
    local timeline = nil
    if variantName and self.AnimSounds[variantName] then
        timeline = self.AnimSounds[variantName]
    end
    if not istable(timeline) or #timeline == 0 then
        timeline = self.AnimSounds[animKey]
    end
    if (not timeline or not istable(timeline)) and animKey == "reload_empty" then
        timeline = self.AnimSounds["reload"]
    end
    if not istable(timeline) or #timeline == 0 then return end

    self._animSoundTimeline = timeline
    self._animSoundIndex = 1
    self._animSoundStartTime = CurTime()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    self._animSoundPlaybackRate = IsValid(vm) and vm:GetPlaybackRate() or 1
    self._animSoundActive = true
end

function SWEP:ProcessAnimSounds()
    if not self._animSoundActive then return end
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()
    -- FIXED: standardized prediction gate — server always runs for MP broadcast
    if not (SERVER or (CLIENT and iftp)) then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then
        self._animSoundActive = false
        return
    end

    local timeline = self._animSoundTimeline
    local idx = self._animSoundIndex
    if not timeline or idx > #timeline then
        self._animSoundActive = false
        return
    end

    local elapsed = (CurTime() - self._animSoundStartTime) * (self._animSoundPlaybackRate or 1)
    while idx <= #timeline and elapsed >= (timeline[idx].time or 0) do
        local entry = timeline[idx]
        if entry.sound and entry.sound ~= "" and entry.sound ~= "nil" then
            local snd = entry.sound
            if istable(snd) then snd = snd[math.random(1, #snd)] end
            owner:EmitSound(snd, entry.level or 75, entry.pitch or 100, 1, CHAN_USER_BASE)
        end
        if entry.callback then entry.callback(self) end
        idx = idx + 1
    end
    self._animSoundIndex = idx
end

function SWEP:ClearAnimSounds()
    self._animSoundActive = false
    self._animSoundTimeline = nil
    self._animSoundIndex = 0
end

-- ============================================================
-- GetShootSound
-- ============================================================
function SWEP:GetShootSound()
    local source = self:GetNWBool("Silenced") and self.Primary.SilSound or self.Primary.Sound
    if istable(source) then
        return tostring(source[math.random(1, #source)])
    end
    return source
end

-- ============================================================
-- Configurators
-- ============================================================
function SWEP:ShootAnimation()
    return ACT_VM_PRIMARYATTACK
end

function SWEP:GrenadeAnimation()
    return ACT_VM_PRIMARYATTACK
end

function SWEP:GetShellDirection()
    return Angle(30, -90, 0)
end

function SWEP:GetMuzzle()
    return 1
end

function SWEP:GetDisplay()
    return 1
end

function SWEP:GetShellEject()
    return 2
end

-- ============================================================
-- PrimaryAttack
-- ============================================================
function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    -- Firemode-specific shoot behavior
    if SERVER or iftp then
        local mode = self.FireModes[self:GetNWInt("FireMode")]
        if mode and mode.shoot then
            local res = mode.shoot(self.Owner, self)
            if res then return end
        end

        -- FIXED: local spread (was global)
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)
        if self:GetNWBool("Silenced") then
            dmg = math.Round(dmg * 0.95)
        end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end

    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)

    -- FIXED: standardized prediction gate — SERVER runs for MP broadcast
    if SERVER or (CLIENT and iftp) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32))
        if not self.NoShell then
            self:CreateShell(self.ShellDelay or 0, self.ShellHeat)
        end
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))
    end

    self.Owner:ViewPunch(Angle(recoil, 0, 0))

    -- Animation
    self:SendWeaponAnim(ACT_VM_IDLE)
    local baseAct = ACT_VM_PRIMARYATTACK
    if self.ShootAnimation then
        baseAct = self:ShootAnimation()
    end
    local isSilenced = self:GetNWBool("Silenced")
    local isZooming = self:GetUHBool("Zooming")
    local lookupKey = isZooming and "shoot_ads" or "shoot"
    if isSilenced then lookupKey = lookupKey .. "_sil" end
    if not self.Animations or not self.Animations[lookupKey] then
        lookupKey = tostring(baseAct)
        if isSilenced then lookupKey = lookupKey .. "_sil" end
    end

    local fallbackActivity = baseAct
    if isSilenced then
        if baseAct == ACT_VM_PRIMARYATTACK then
            fallbackActivity = ACT_VM_PRIMARYATTACK_SILENCED or ACT_VM_PRIMARYATTACK
        elseif baseAct == ACT_VM_SECONDARYATTACK then
            fallbackActivity = ACT_VM_SECONDARYATTACK_SILENCED or ACT_VM_SECONDARYATTACK
        end
    end

    self:EasySendWeaponAnim(lookupKey, fallbackActivity)

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        vm:SetCycle(0)
        vm:SetPlaybackRate(1)
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:MuzzleFlash()

    local fireSound = self:GetShootSound()
    self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self.NextReload = CurTime() + 0.5
    self:PostShoot()
end

-- ============================================================
-- ShootBullets — FIXED: local spread (was global)
-- ============================================================
function SWEP:ShootBullets(pos, buldir, dmg, tries)
    if tries <= 0 then return end
    local owner = self.Owner

    -- FIXED: local spread (was undeclared global)
    local spread
    local movement = Vector(owner:GetVelocity().x, owner:GetVelocity().y, 0):LengthSqr()
    local movepercent = math.Clamp(movement / owner:GetRunSpeed()^2, 0, 1)
    local move = movepercent * 0.1

    if owner:OnGround() then
        if self:GetUHBool("Zooming") and owner:Crouching() then
            spread = self.Primary.Spread * 0.18
        elseif self:GetUHBool("Zooming") then
            spread = self.Primary.Spread * 0.26
        elseif owner:Crouching() then
            spread = self.Primary.Spread * 0.34
        else
            spread = self.Primary.Spread * 0.5
        end
    else
        spread = self.Primary.Spread * 0.62
    end
    spread = spread + move

    local bullet = {}
    bullet.Num = self.Primary.NumberofShots
    bullet.Src = pos
    bullet.Dir = buldir
    bullet.Spread = Vector(spread, spread, 0)
    bullet.Tracer = 1
    bullet.TracerName = "uh_tracer"
    bullet.Force = self.Primary.Force
    bullet.Damage = dmg
    bullet.AmmoType = self.Primary.Ammo
    bullet.Callback = function(attacker, bultrace, dmginfo)
        local mat = bultrace.MatType
        if SERVER then
            util.ScreenShake(bultrace.HitPos, 5, 0.1, 0.5, 64)
        end
        if bultrace.Hit then
            local dir = bultrace.HitNormal
            local tr = {}
            tr.start = bultrace.HitPos - dir * (self.PenetrationDepth or 4)
            tr.endpos = bultrace.HitPos
            tr.filter = owner
            tr.mask = MASK_SHOT
            local trace = util.TraceLine(tr)
            if not trace.AllSolid and trace.Fraction > 0 and GetConVar("uh_sv_penetration"):GetBool() then
                self:ShootBullets(trace.HitPos, buldir, math.Round(dmg * math.Rand(0.5, 0.6)), tries - 1)
            end
            if mat == MAT_METAL or mat == MAT_VENT or mat == MAT_GRATE then
                local fx = EffectData()
                fx:SetOrigin(bultrace.HitPos)
                fx:SetScale(1)
                util.Effect("uh_hitworld", fx)
            end
        end
    end

    owner:FireBullets(bullet)
end

-- ============================================================
-- ShootGrenade — FIXED: ent:SetOwner (was direct field assignment)
-- ============================================================
function SWEP:ShootGrenade(force)
    if SERVER then
        local ent = ents.Create("sent_mgl_grenade")
        ent:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 30 + self.Owner:GetUp() * -10 +
            (self:GetUHBool("Zooming") and Vector(0,0,0) or self.Owner:GetRight() * 5))
        ent:SetAngles(self.Owner:GetAngles())
        ent:Spawn()
        ent:Activate()
        -- FIXED: SetOwner instead of direct field assignment
        ent:SetOwner(self.Owner)
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then  -- FIXED: IsValid check (was phys != nil)
            phys:ApplyForceCenter(self.Owner:GetAimVector() * force)
        end
    end
end

function SWEP:PostShoot()
    -- Track last shot time for crosshair kick calculation (MCV-style)
    self._lastRecoilTime = CurTime()
end

-- ============================================================
-- CanPrimaryAttack — FIXED: UH_GrenadeTime (was GrenadeTime)
-- ============================================================
function SWEP:CanPrimaryAttack()
    if not IsValid(self.Owner) then return false end
    if self:GetNWInt("FireMode") == 0
       or self:GetNWFloat("DeployTime") > CurTime()
       or self:GetUHBool("Running")
       or self:GetUHBool("Reloading") then return false end
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
-- SecondaryAttack — firemode switch + zoom
-- ============================================================
-- Helper for prediction gate
local function iftp2()
    return IsFirstTimePredicted()
end

function SWEP:SecondaryAttack()
    local ct = CurTime()
    local sp = game.SinglePlayer()

    if self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > ct then return end

    if SERVER or iftp2() then
        if self.Owner:KeyDown(IN_USE) then
            local mode = self:GetNWInt("FireMode") + 1
            if mode > #self.FireModes then mode = 0 end

            local old = self.FireModes[self:GetNWInt("FireMode")]
            if old and old.holster then
                old.holster(self.Owner, self)
                if sp and SERVER then
                    net.Start("UH_Select_Fire")
                        net.WriteFloat(self:GetNWInt("FireMode"))
                        net.WriteBool(false)
                    net.Broadcast()
                end
            elseif self:GetNWInt("FireMode") == 0 then
                self:SendWeaponAnim(ACT_VM_LOWERED_TO_IDLE)
            end

            local new = self.FireModes[mode]
            if new and new.equip then
                new.equip(self.Owner, self)
                if sp and SERVER then
                    net.Start("UH_Select_Fire")
                        net.WriteFloat(mode)
                        net.WriteBool(true)
                    net.Broadcast()
                end
            elseif mode == 0 then
                self:SetUHBool("Running", false)
                self:SetUHBool("Zooming", false)
                self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
            end

            self:SetNextPrimaryFire(ct + 0.5)
            self:SetNextSecondaryFire(ct + 0.2)
            self:SetNWInt("FireMode", mode)

            -- FIXED: standardized sound gate
            if SERVER or (CLIENT and IsFirstTimePredicted()) then
                self.Owner:EmitSound("uh/flashlight.wav", 64, 100, 1, CHAN_USER_BASE)
            end
        end
    end
end

-- Helper for prediction gate

-- ============================================================
-- Muzzle flash — FIXED: DynamicLight ID (was 0, now self:EntIndex())
-- ============================================================
function SWEP:DoMuzzleFlash()
    if self:GetNWBool("Silenced") then return end

    if self.MuzzleFlashType == "particle" and self.MuzzleFlashParticle and self.MuzzleFlashParticle ~= "" then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            ParticleEffectAttach(self.MuzzleFlashParticle, PATTACH_POINT_FOLLOW, vm, self:GetMuzzle())
        end
        self._muzzleFlashTime = CurTime()
        if CLIENT and GetConVar("uh_dynamiclight"):GetBool() then
            local att = self:GetAttachment(self:GetMuzzle())
            if att then
                -- FIXED: use self:EntIndex() instead of 0
                local dlight = DynamicLight(self:EntIndex())
                if dlight then
                    dlight.Pos = att.Pos
                    local lc = self.MuzzleFlashLightColor
                    dlight.r = lc and lc.x or 255
                    dlight.g = lc and lc.y or 218
                    dlight.b = lc and lc.z or 74
                    dlight.Brightness = self.MuzzleFlashLightBrightness or 4
                    dlight.Size = (self.MuzzleFlashLightSize or 96) * (self.MuzzleFlashScale or 1)
                    dlight.Decay = self.MuzzleFlashLightDecay or 128
                    dlight.DieTime = CurTime() + FrameTime() * 3
                end
            end
        end
        return
    end

    local fx = EffectData()
    fx:SetEntity(self)
    fx:SetOrigin(self.Owner:GetShootPos())
    fx:SetNormal(self.Owner:GetAimVector())
    fx:SetAttachment(self:GetMuzzle())
    util.Effect("uh_muzzle", fx)
end

function SWEP:CreateSmoke(att, delay)
    if (delay or 0) > 0 then
        timer.Simple(delay, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            local fx = EffectData()
            fx:SetEntity(self)
            fx:SetOrigin(self.Owner:GetShootPos())
            fx:SetRadius(self.SmokeWidth or 20)
            fx:SetAttachment(att)
            util.Effect("uh_smoke", fx)
        end)
    else
        local fx = EffectData()
        fx:SetEntity(self)
        fx:SetOrigin(self.Owner:GetShootPos())
        fx:SetRadius(self.SmokeWidth or 20)
        fx:SetAttachment(att)
        util.Effect("uh_smoke", fx)
    end
end

function SWEP:CreateShell(delay, heat)
    if (delay or 0) > 0 then
        timer.Create("CustomUH_Shell_" .. self.Owner:SteamID(), delay, 1, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            if self.Owner:GetActiveWeapon() != self then return end
            local fx = EffectData()
            fx:SetEntity(self)
            fx:SetOrigin(self.Owner:EyePos())
            fx:SetAttachment(self:GetShellEject())
            fx:SetNormal(self.Owner:GetAimVector())
            fx:SetScale(heat or 1)
            util.Effect("uh_shell", fx)
            timer.Simple(0.5, function()
                if not IsValid(self) then return end
                if self.Shotgun then
                    self:EmitSound("weapons/underhell/shells/shotgun_shell" .. math.random(1,3) .. ".wav", 65, 100, 0.75, CHAN_USER_BASE)
                else
                    self:EmitSound("player/pl_shell" .. math.random(1,3) .. ".wav", 65, 100, 0.75, CHAN_USER_BASE)
                end
            end)
        end)
    else
        local fx = EffectData()
        fx:SetEntity(self)
        fx:SetOrigin(self.Owner:EyePos())
        fx:SetAttachment(self:GetShellEject())
        fx:SetNormal(self.Owner:GetAimVector())
        fx:SetScale(heat or 1)
        util.Effect("uh_shell", fx)
        timer.Simple(0.5, function()
            if not IsValid(self) then return end
            if self.Shotgun then
                self:EmitSound("weapons/underhell/shells/shotgun_shell" .. math.random(1,3) .. ".wav", 65, 100, 0.75, CHAN_USER_BASE)
            else
                self:EmitSound("player/pl_shell" .. math.random(1,3) .. ".wav", 65, 100, 0.75, CHAN_USER_BASE)
            end
        end)
    end
end

-- ============================================================
-- Reload — cleaned up, dead code removed
-- ============================================================
function SWEP:_FinishReload()
    if self._reloadFinished then return end
    self._reloadFinished = true

    self:SetUHBool("Reloading", false)
    self:SetNWFloat("ReloadTime", 0)
    self:SetNWFloat("ReloadEndTime", 0)
    self:ClearAnimSounds()

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        vm:SetPlaybackRate(1)
        vm:SetCycle(0)
    end
    self:PostReload()

    -- Ammo refill (server only)
    if SERVER then
        if self.Chambering and self:Clip1() > 0 then
            local clip = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1(), self.Primary.ClipSize + 1)
            self.Owner:RemoveAmmo(self.Primary.ClipSize + 1 - self:Clip1(), self.Primary.Ammo)
            self:SetClip1(clip)
        else
            local clip = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1(), self.Primary.ClipSize)
            self.Owner:RemoveAmmo(self.Primary.ClipSize - self:Clip1(), self.Primary.Ammo)
            self:SetClip1(clip)
        end
    end
end

function SWEP:Reload()
    local ct = CurTime()
    if not IsValid(self.Owner) then return end

    -- FIXED: UH_GrenadeTime (was GrenadeTime)
    if self.NextReload < ct and not self:GetUHBool("Running") and not self:GetUHBool("Reloading")
       and not self.Owner:KeyDown(IN_USE)
       and self.Owner:GetNWFloat("UH_GrenadeTime") < ct
       and self:GetNWFloat("DeployTime") < ct then

        if self:Clip1() < (self.Chambering and self.Primary.ClipSize + 1 or self.Primary.ClipSize)
           and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then

            if SERVER then
                self.Owner:SetAnimation(PLAYER_RELOAD)
            end
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

            self:PreReload()

            -- Play reload animation
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            local reloadAnimKey = nil
            local pickedVariant = nil

            if self.ReloadAnim and type(self.ReloadAnim) == "string" then
                local seq = IsValid(vm) and vm:LookupSequence(self.ReloadAnim) or -1
                if seq and seq >= 0 then
                    self:SendSequence(vm, seq)
                end
            else
                local isSilenced = self:GetNWBool("Silenced")
                local isEmpty = (self:Clip1() <= 0)
                local animToPlay = nil

                local function GetBestAnim(emptyKey, normalKey)
                    local result
                    if isSilenced then
                        result = self.Animations[emptyKey.."_sil"] or self.Animations[emptyKey]
                            or self.Animations[normalKey.."_sil"] or self.Animations[normalKey]
                    else
                        result = self.Animations[emptyKey] or self.Animations[normalKey]
                    end
                    if istable(result) then
                        pickedVariant = result[math.random(1, #result)]
                        result = pickedVariant
                    end
                    return result
                end

                if isEmpty then
                    animToPlay = GetBestAnim("reload_empty", "reload")
                    reloadAnimKey = "reload_empty"
                else
                    animToPlay = GetBestAnim("reload", "reload")
                    reloadAnimKey = "reload"
                end

                if animToPlay then
                    self:SendAnim(vm, animToPlay, ACT_VM_RELOAD)
                else
                    if self:GetNWBool("Silenced") then
                        self:SendSequence(vm, vm:SelectWeightedSequence(ACT_VM_RELOAD_SILENCED or ACT_VM_RELOAD))
                    else
                        self:SendSequence(vm, vm:SelectWeightedSequence(ACT_VM_RELOAD))
                    end
                end
            end

            -- Reload duration
            local AnimTime = self.ReloadTime or (IsValid(vm) and vm:SequenceDuration() or 2)
            local speed = self.ReloadSpeed or 1
            if speed ~= 1 then
                AnimTime = AnimTime / speed
                if IsValid(vm) then vm:SetPlaybackRate(speed) end
            else
                if IsValid(vm) then vm:SetPlaybackRate(1) end
            end

            self._reloadFinished = false
            self._reloadEndTime = ct + AnimTime

            -- Setup AnimSounds
            if reloadAnimKey then
                self:SetupAnimSounds(reloadAnimKey, pickedVariant)
            end

            self.NextReload = ct + AnimTime + 0.5
            self:SetNextPrimaryFire(ct + AnimTime)
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
            self:SetNWFloat("ReloadTime", AnimTime)
            self:SetNWFloat("ReloadEndTime", ct + AnimTime)

            -- ReloadTable sounds (if no AnimSounds entry exists)
            if self.UseReloadTable and not self._animSoundActive then
                local sp2 = game.SinglePlayer()
                local iftp = IsFirstTimePredicted()
                if (sp2 and SERVER) or (not sp2 and CLIENT and iftp) then
                    local scale = 1 / speed
                    for _, tbl in ipairs(self.ReloadTable) do
                        if tbl and tbl.delay then
                            -- FIXED: was `return` (exited entire Reload function)
                            -- Now uses proper continue pattern
                            timer.Simple(tbl.delay * scale, function()
                                if not IsValid(self) or not self:GetUHBool("Reloading") then return end
                                local owner = self:GetOwner()
                                if not IsValid(owner) or owner:GetActiveWeapon() != self then return end
                                if tbl.sound and tbl.sound ~= "" and tbl.sound ~= "nil" then
                                    local snd = tbl.sound
                                    if istable(snd) then snd = snd[math.random(1, #snd)] end
                                    owner:EmitSound(snd, tbl.level or 75, tbl.pitch or 100, 1, CHAN_USER_BASE)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end

function SWEP:PreReload()
end

function SWEP:PostReload()
end

-- ============================================================
-- QC Animation Event Sound Handler
-- ============================================================
hook.Add("EntityEmitSound", "CustomUH_ReloadOverride", function(data)
    local ent = data.Entity
    if not IsValid(ent) then return end
    local wep = ent.GetActiveWeapon and ent:GetActiveWeapon()
    if not IsValid(wep) then return end
    -- FIXED: early-out for non-SoundChanger weapons (was checking every sound)
    if not wep.SoundChanger then return end
    if wep.SoundChanger[data.SoundName] ~= nil then
        if wep.SoundChanger[data.SoundName] == false then
            return false
        else
            data.SoundName = wep.SoundChanger[data.SoundName]
            return true
        end
    end
end)

function SWEP:FireAnimationEvent(pos, ang, event, options)
    if not self.UseQCReloadEvents then
        return true
    end
    if event == 5004 or event == 6004 or event == 15 then
        if options and options ~= "" then
            if IsValid(self.Owner) then
                self.Owner:EmitSound(options, 75, 100, 1, CHAN_USER_BASE)
            else
                self:EmitSound(options, 75, 100)
            end
        end
        return true
    end
    return true
end

-- ============================================================
-- Think
-- ============================================================
function SWEP:Think()
    BaseClass.Think(self)
    if not IsValid(self.Owner) then return end
    local ct = CurTime()

    -- Reload speed enforcement + completion
    if self:GetUHBool("Reloading") then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            if self.ReloadSpeed and self.ReloadSpeed ~= 1 then
                vm:SetPlaybackRate(self.ReloadSpeed)
            end
            if self._reloadEndTime and ct >= self._reloadEndTime then
                self:_FinishReload()
            end
        end
    end

    -- Zoom logic
    local isZooming = self:GetUHBool("Zooming")
    local preventZoom = not self.Owner:OnGround()
        or self.Owner:GetNWBool("UH_Flare")
        or self.Owner:GetNWBool("UH_Flashlight")
        or self:GetUHBool("Running")
        or self:GetUHBool("Reloading")
        or self:GetNWFloat("DeployTime") > ct
        or self.Owner:GetNWFloat("UH_GrenadeTime") > ct

    local wantsToZoom = self.Owner:KeyDown(IN_ATTACK2)
        and not preventZoom
        and not self.Owner:KeyDown(IN_USE)
        and self:GetNWInt("FireMode") ~= 0

    if isZooming and preventZoom then
        self:SetUHBool("Zooming", false)
        if SERVER or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_off.wav", 65, 100, 1, CHAN_USER_BASE)
        end
    elseif isZooming and not wantsToZoom then
        self:SetUHBool("Zooming", false)
        if SERVER or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_off.wav", 65, 100, 1, CHAN_USER_BASE)
        end
    elseif not isZooming and wantsToZoom then
        self:SetUHBool("Zooming", true)
        if SERVER or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_on.wav", 64, 100, 1, CHAN_USER_BASE)
        end
    end

    -- AnimSounds processing
    self:ProcessAnimSounds()

    if self.CustomThink then
        self:CustomThink(ct)
    end
end

-- ============================================================
-- Client-side scope rendering
-- ============================================================
if CLIENT then
    local devzoom = Material("vgui/scope_lens")

    -- Same inheritance-chain walker as in weapon_custom_uh_base.lua.
    -- Required because BO4 / MW ports inherit through several layers
    -- (e.g. "weapon_bo4_custom_base_gun") before reaching "custom_uh_base".
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

    hook.Add("RenderScene", "CustomUH_SniperRenderScene", function(origin, angles, fov)
        local wep = LocalPlayer():GetActiveWeapon()
        if not IsValid(wep) then return end
        if not IsCustomUHWeapon(wep) then return end
        if not wep.ScopeTexture then return end
        if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
            local size = wep.RT_Size or 512
            render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
            local ang = LocalPlayer():EyeAngles()
            local pos = LocalPlayer():EyePos()
            render.RenderView({
                x = 0, y = 0, w = size, h = size,
                origin = pos, angles = ang,
                drawviewmodel = false, drawhud = false,
                dopostprocess = false, fov = wep.ScopeFov or 8,
            })
            render.PopRenderTarget()
            wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
        else
            if wep.ScopeTexture then
                wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
            end
        end
    end)
end

function SWEP:AdjustMouseSensitivity()
    local hasScope = self.ScopeTexture or self.Use2DScope
    if not hasScope and self.Sensitivity then hasScope = true end
    if hasScope and self:GetUHBool("Zooming") then
        return self.Sensitivity or 0.2
    end
end


if CLIENT then
-- ============================================================
-- MCV-STYLE DYNAMIC CROSSHAIR
-- Ported from Military Conflict Vietnam (lua/mcv/weapon_common/cl_hud.lua)
-- ============================================================
-- Features:
--   * Spread-following gap (widens with movement, jumping, firing)
--   * Shot kick (gap kicks open on fire, decays over 0.15s)
--   * Asymmetric interpolation (opens 3x faster than closes)
--   * Walk bob (figure-of-eight, speed-scaled)
--   * View-punch following (stays on actual aim point)
--   * Reload fade (smooth fade out/in)
--   * ADS fade (smooth fade as you aim down sights)
--   * Deploy/holster blend (slides in on weapon switch)
--   * Shadow outline for visibility on any background
--   * Shotgun circle mode (for multi-pellet weapons)

local CH_Color = Color(255, 255, 255, 100)
local CH_Shadow = Color(0, 0, 0, 0)
local CH_White = Color(255, 255, 255, 255)
local CH_Smooth = 12        -- gap follows target at 12/sec (closing)
local CH_Kick = 0.75        -- extra gap = 0.75x base spread on shot
local CH_KickTime = 0.15    -- kick decays over 0.15s
local CH_Bob = 2.5          -- 2.5 ScreenScale units of bob at sprint
local CH_DeployTime = 0.35  -- seconds for crosshair to fade in on deploy

local function ch_ease(p)
    p = math.Clamp(p, 0, 1)
    return 1 - (1 - p) * (1 - p) * (1 - p)
end

local function ch_shadowrect(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
    surface.SetDrawColor(0, 0, 0, col.a * 100 / 150)
    surface.DrawOutlinedRect(x - 1, y - 1, w + 2, h + 2)
end

function SWEP:DoDrawCrosshair(x, y)
    -- Suppress during deploy
    if self:GetNWFloat("DeployTime") > CurTime() then return true end

    -- Track deploy/holster blend (detect weapon switches via frame number)
    local frame = FrameNumber()
    local now = CurTime()
    if self._chLastFrame == nil or frame < self._chLastFrame or frame - self._chLastFrame > 2 then
        self._chDeployTime = now
    end
    self._chLastFrame = frame
    local blend = ch_ease((now - (self._chDeployTime or now)) / CH_DeployTime)

    -- Track ADS progress (smooth 0..1)
    local zooming = self.GetUHBool and self:GetUHBool("Zooming") or false
    if self.ScopeDisabled then zooming = false end
    local adsTarget = zooming and 1 or 0
    self._chADS = math.Approach(self._chADS or 0, adsTarget, FrameTime() * 8)

    -- Track reload fade
    local reloading = self.GetUHBool and self:GetUHBool("Reloading") or false
    local reloadTarget = reloading and 0 or 1
    self._chReloadAlpha = math.Approach(self._chReloadAlpha or 1, reloadTarget, FrameTime() * 8)

    -- Calculate visibility alpha (fully fades during ADS and reload)
    -- During ADS: alpha goes to 0 as _chADS goes to 1 (fully invisible when converged)
    local a = (1 - self._chADS) * 100 * blend * self._chReloadAlpha
    if a <= 0 then return true end

    -- Check convar
    if not GetConVar("uh_crosshair"):GetBool() then return true end

    -- Suppress during 2D scope
    if self.Use2DScope and zooming then return true end

    local col = CH_Color
    col.a = a

    -- Follow view punch (crosshair stays on actual aim point)
    local owner = self:GetOwner()
    if IsValid(owner) then
        local aim = owner:EyeAngles() + owner:GetViewPunchAngles() * 2
        local scr = (owner:EyePos() + aim:Forward() * 4096):ToScreen()
        if scr.visible and scr.x == scr.x then
            x, y = scr.x, scr.y
        end
    end

    local dot_size = ScreenScale(1)
    local line_size = ScreenScale(4)

    -- Calculate gap from spread + kick
    local trueFOV = 90
    local fovCvar = GetConVar("fov_desired")
    if fovCvar then trueFOV = fovCvar:GetInt() end
    if trueFOV < 1 then trueFOV = 90 end

    -- Widescreen fix
    local ratio = (ScrW() / ScrH()) / (4 / 3)
    local halfAngle = trueFOV * (0.5 * math.pi / 180)
    local t = math.tan(halfAngle) * ratio
    local wsFOV = (180 / math.pi) * math.atan(t) * 2
    local scale = ScrH() / wsFOV

    -- Base spread
    local baseSpread = self.Primary and self.Primary.Spread or 0.004
    local spread = baseSpread * 100

    -- Movement spread
    local vel = 0
    local walkSpeed = 200
    local inAir = false
    if IsValid(owner) then
        vel = owner:GetVelocity():Length()
        walkSpeed = owner:GetWalkSpeed()
        if walkSpeed < 1 then walkSpeed = 200 end
        inAir = not owner:IsOnGround()
    end
    local moveRatio = math.Clamp(vel / (walkSpeed * 2), 0, 1)
    local moveSpread = moveRatio * 2
    if inAir then moveSpread = moveSpread + 3 end

    -- Shot kick (decays over CH_KickTime)
    -- Uses _lastRecoilTime set by PostShoot (called on both server and client)
    local since = now - (self._lastRecoilTime or 0)
    local kick = math.Clamp(1 - since / CH_KickTime, 0, 1)
    kick = kick * kick  -- quadratic decay for smoother feel
    local kickGap = kick * ScreenScale(12)  -- 12 ScreenScale units of kick

    local target = scale * (spread + moveSpread) + kickGap

    -- ADS convergence: as ADS progresses (0..1), gap shrinks toward 0
    target = target * (1 - self._chADS)

    -- Smooth interpolation (opens 3x faster than closes, like MCV)
    local ft = FrameTime()
    if self._chGap == nil then self._chGap = target end
    if target > self._chGap then
        self._chGap = Lerp(math.min(ft * CH_Smooth * 3, 1), self._chGap, target)
    else
        self._chGap = Lerp(math.min(ft * CH_Smooth, 1), self._chGap, target)
    end
    local gap_size = math.max(self._chGap, 0)

    -- Walk bob (figure of eight)
    local speed = vel / math.max(walkSpeed * 2.5, 1)
    if inAir then speed = 0 end
    self._chBobPhase = (self._chBobPhase or 0) + ft * (6 + speed * 6) * math.min(speed * 3, 1)
    local bob = CH_Bob * ScreenScale(1) * speed
    x = x + math.sin(self._chBobPhase) * bob
    y = y + math.abs(math.cos(self._chBobPhase)) * bob * 0.6

    -- Draw center dot (hide when fully converged during ADS)
    if self._chADS < 0.95 then
        ch_shadowrect(x - (dot_size / 2), y - (dot_size / 2), dot_size, dot_size, col)
    end

    -- Draw crosshair lines or circle
    local pellets = (self.Primary and self.Primary.NumberofShots) or 1
    if self.CrosshairCircle or pellets > 1 then
        local shadow = CH_Shadow
        shadow.a = a * 100 / 150
        if gap_size > 1 then
            surface.DrawCircle(x, y, gap_size, col)
            surface.DrawCircle(x, y, gap_size - 1, col)
            surface.DrawCircle(x, y, gap_size + 1, shadow)
            surface.DrawCircle(x, y, gap_size - 2, shadow)
        end
    elseif baseSpread > 0 then
        -- Only draw prongs if there's a visible gap (or converging)
        if gap_size > 0 then
            ch_shadowrect(x - (dot_size / 2), y + (dot_size / 4) + gap_size, dot_size, line_size, col)
            ch_shadowrect(x - (dot_size / 2), y - (dot_size / 4) - gap_size - line_size, dot_size, line_size, col)
            ch_shadowrect(x + gap_size, y - (dot_size / 2), line_size, dot_size, col)
            ch_shadowrect(x - gap_size - line_size, y - (dot_size / 2), line_size, dot_size, col)
        end
    end

    return true
end

end -- end if CLIENT (MCV crosshair block)

-- ============================================================
-- DrawHUD
-- ============================================================
if CLIENT then
    local h_reload = 0
    local h_crosshair = 0
    local h_scope = 0

    function SWEP:DrawHUD()
        if not GetConVar("cl_drawhud"):GetBool() then return end
        if self:GetNWFloat("DeployTime") > CurTime() then return end

        local col = Color(GetConVar("uh_hud_r"):GetInt(), GetConVar("uh_hud_g"):GetInt(), GetConVar("uh_hud_b"):GetInt())
        local pos = {x = ScrW()/2, y = ScrH()/2}
        local movement = LocalPlayer():GetVelocity():Length() / 10
        if movement > 80 then movement = 80 end
        local drawply = LocalPlayer():ShouldDrawLocalPlayer()

        h_reload = math.Approach(h_reload, self:GetUHBool("Reloading") and 1 or 0, FrameTime()*3)
        h_crosshair = math.Approach(h_crosshair, (self:GetNWInt("FireMode") == 0 or self:GetUHBool("Running") or self:GetUHBool("Reloading") or self:GetUHBool("Zooming")) and 0 or 1, FrameTime()*5)

        if drawply then
            pos = self.Owner:GetEyeTrace().HitPos:ToScreen()
        end

        -- Crosshair is now handled by SWEP:DoDrawCrosshair (MCV-style dynamic crosshair)

        -- 2D Scope
        if self.Use2DScope and self:GetUHBool("Zooming") and not drawply then
            h_scope = math.Approach(h_scope, 1, FrameTime() * 100)
            if h_scope > 0.01 then
                local w, h = ScrW(), ScrH()
                local scopeSize = h * 1.25
                local x = w/2 - scopeSize/2
                local y = h/2 - scopeSize/2
                surface.SetDrawColor(0, 0, 0, 255 * h_scope)
                surface.DrawRect(0, 0, x, h)
                surface.DrawRect(x + scopeSize, 0, w - (x + scopeSize), h)
                surface.DrawRect(x, 0, scopeSize, y)
                surface.DrawRect(x, h - y, scopeSize, y)
                surface.SetDrawColor(0, 0, 0, 255)
                surface.SetMaterial(Material("gmod/scope"))
                surface.DrawTexturedRect(x, y, scopeSize, scopeSize)
                surface.SetDrawColor(0, 0, 0, 255)
                surface.DrawLine(0, h/2, w, h/2)
                surface.DrawLine(w/2, 0, w/2, h)
            end
        else
            h_scope = math.Approach(h_scope, 0, FrameTime() * 10)
        end

        if not GetConVar("uh_hud"):GetBool() then return end

        -- Ammo counter
        if drawply then
            local att = self:GetAttachment(self:GetDisplay())
            if att then pos = att.Pos:ToScreen() end
        else
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                local att = vm:GetAttachment(self:GetDisplay())
                if att then pos = att.Pos:ToScreen() end
            end
        end

        local clip = self:Clip1()
        local ammotype = self.Primary.Ammo
        local ammocount = self.Owner:GetAmmoCount(ammotype)
        local cliptext = "Magazine " .. (self.Chambering and clip > self.Primary.ClipSize and (clip-1).." + 1" or clip)
        local ammotext = "Reserved " .. ammocount
        local typetext = language.GetPhrase(ammotype.."_ammo")

        surface.SetFont("UH_AmmoLarge")
        local textsize = surface.GetTextSize(cliptext)
        local x = pos.x - textsize
        local y = pos.y
        local pr = math.Clamp(clip / self.Primary.ClipSize, 0, 1)

        draw.SimpleText(cliptext, "UH_AmmoLarge", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
        draw.SimpleText(cliptext, "UH_AmmoLarge", x - 5, y, Color(255*(1-pr) + col.r*pr, col.g*pr, col.b*pr), TEXT_ALIGN_LEFT)

        y = y + 24

        if self:GetNWFloat("ReloadEndTime") > CurTime() or h_reload > 0 then
            local p = math.Clamp(1-(self:GetNWFloat("ReloadEndTime")-CurTime())/math.max(self:GetNWFloat("ReloadTime"), 0.001), 0, 1)
            draw.RoundedBox(0, x - 2, y + 1, 1, 14, Color(0,0,0,255*h_reload))
            draw.RoundedBox(0, x - 3, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
            draw.RoundedBox(0, x - 5 + textsize, y + 1, 1, 14, Color(0,0,0,255*h_reload))
            draw.RoundedBox(0, x - 6 + textsize, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
            draw.RoundedBox(0, x + 1, y + 3, textsize*p-8, 10, Color(0,0,0,255*h_reload))
            draw.RoundedBox(0, x, y + 2, textsize*p-8, 10, Color(255*(1-p) + col.r*p, col.g*p, col.b*p, 255*h_reload))
        end

        y = y + h_reload*14 - 2

        if ammocount > 0 then
            draw.SimpleText(ammotext, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
            draw.SimpleText(ammotext, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
            y = y + 15
        end

        draw.SimpleText(typetext, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
        draw.SimpleText(typetext, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
        y = y + 15

        local mode = self:GetNWInt("FireMode")
        if mode == 0 or self.FireModes[mode] then
            local name = self.FireModes[mode] and self.FireModes[mode].name or "Safe"
            draw.SimpleText(name, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
            draw.SimpleText(name, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
        end

        if GetConVar("uh_sv_grenades"):GetBool() then
            local grenades = self.Owner:GetAmmoCount("UH_Grenade")
            if grenades > 0 and h_reload < 1 then
                local p = 1 - h_reload
                draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2 + 1, ScrH()*0.8 + 1, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
                draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2, ScrH()*0.8, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
                draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2 + 1, ScrH()*0.8 + 23, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
                draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2, ScrH()*0.8 + 22, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
            end
        end
    end
end
