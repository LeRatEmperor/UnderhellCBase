AddCSLuaFile()

DEFINE_BASECLASS("weapon_bo3_base_shotty")
SWEP.Base = "weapon_bo3_base_shotty"

SWEP.PrintName = "KRM-262"
SWEP.Category = "Black Ops III"
SWEP.SubCategory = ""
SWEP.IconLetter = "u"

SWEP.Slot = 3 -- The slot the weapon will appear in when switching weapons, add 1 to get the actual slot (e.g. a value of 1 translates to weapon slot 2, the pistol slots)

SWEP.Spawnable = true -- Set this to true to make your weapon appear in the spawnmenu, set to false to hide the template

-- Appearance

SWEP.UseHands = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel          = "models/loyalists/blackops3/spartan/v_shot_spartan.mdl"
SWEP.WorldModel         = "models/loyalists/blackops3/spartan/w_shot_spartan.mdl"
SWEP.LoweredPos = Vector(2.95, -3.057, -4.119)
SWEP.LoweredAng = Vector(-13.131, 33.537, -29.906)

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.HoldType = "shotgun"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
        {
                name = "Pump-Action"
        }
}

SWEP.Primary.Sound          = Sound("CW_BLACKOPS3_SPARTAN_FIRE")
SWEP.Primary.ShellSound         = Sound("Weapon_BLACKOPS3_SPARTAN.Shell_In")
SWEP.Primary.ClipSize       = 8
SWEP.Primary.Ammo           = "12 Gauge"
SWEP.Primary.DefaultClip    = 120
SWEP.Primary.MinDamage      = 15
SWEP.Primary.MaxDamage      = 15
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.5
SWEP.Primary.Delay          = 0.7
SWEP.Primary.NumberofShots  = 8
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.5
SWEP.TwoHanded                          = true
SWEP.ReloadSpeed = 1
SWEP.Chambering                         = false
SWEP.NoShell                            = true
SWEP.AnimatedSprint                     = false
SWEP.PumpDelay = 0.2
SWEP.Primary.ReloadTime         = 0.4

-- Custom configurators

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_m3"
SWEP.MuzzleFlashLightColor = Vector(0, 200, 255)
SWEP.MuzzleFlashLightSize = 128

SWEP.MeleeDamage    = 50      -- Damage dealt by melee attack
SWEP.MeleeRange     = 64      -- Range of melee trace (Source units)
SWEP.MeleeDelay     = 0.6     -- Minimum time between melee attacks
SWEP.MeleeForce     = 300     -- Knockback force on hit
SWEP.MeleeHitDelay  = 0.15    -- Seconds after melee start to perform hit trace
SWEP.MeleeViewPunch = Angle(-5, 0, 0)  -- Camera punch on melee

SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"      -- Swing sound (leave empty for none)
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_00.wav"}      -- Sound on hit
SWEP.MeleeMissSound = "nil"      -- Sound on miss

SWEP.MeleeInterruptReload = true

SWEP.IronSightsPos = Vector(-8.62, 1.0289, 2.1)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SwayPosition = 2.0

SWEP.AlternativePos = Vector(0, 0, 0) -- Shifts gun right, back, and down
SWEP.AlternativeAng = Angle(0, 0, 0)   -- Tilts it

SWEP.Animations = {
        ["shoot"] = "base_fire",
        ["reload_loop"] = "base_reload_loop",
    ["start_reload"] = "base_reload_in",
    ["after_reload"] = "base_reload_out",
        ["sprint_idle"] = "base_sprint_loop",
        ["sprint_in"] = "base_sprint_in",
        ["sprint_out"] = "base_sprint_out",
        ["iron_fire"] = "base_fire_ads",
        ["idle"] = "base_idle",
        ["deploy"] = "base_draw",
        ["melee"] = "base_melee",
        ["inspect"] = "base_inspect",
        ["rechamber"] = "base_rechamber",
        ["rechamber_ads"] = "base_rechamber_ads",
        ["mantle"] = "base_mantle_over",
}

SWEP.AnimSounds = {
    ["start_reload"] = {
        {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Open"},
        {time = 0.9, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
    },
    ["reload_loop"] = {
        {time = 0.35, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
    },
    ["after_reload"] = {
        {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Close"},
        {time = 0.6, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["fire_last"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["rechamber"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["rechamber_ads"] = {
        {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
    ["draw_first"] = {
        {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
        {time = 0.5, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
        {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
    },
}

function SWEP:PostShoot()
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.4

    -- Ensure fire+sprint block lasts AT LEAST pumpDelay long
    -- but don't shorten a longer Primary.Delay
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))

    timer.Simple(pumpDelay, function()
        if !IsValid(self) or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end

        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)
    end)
end

function SWEP:Initialize()
    BaseClass.Initialize(self)
end

function SWEP:ShootAnimation()
    -- If zoomed and "iron_fire" exists in Animations, return the key
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    -- If not zoomed and "shoot" exists in Animations, return the key
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

function SWEP:PrimaryAttack()
    -- Block during melee or mantle animation
    if self._meleeActive then return end
    if self._mantleActive then return end

    -- E + M1 = melee
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

    -- Normal shooting — delegate to base
    return BaseClass.PrimaryAttack(self)
end


-- ==========================================
-- MELEE ATTACK
-- ==========================================
-- Plays ["melee"] animation, schedules a hit trace at MeleeHitDelay,
-- and locks controls for the animation duration.

function SWEP:MeleeAttack()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    -- Cancel conflicting states
    self:SetUHBool("Zooming", false)

    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end

    -- Optionally cancel reload
    if self.MeleeInterruptReload ~= false and self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end

    -- Set melee state
    self._meleeActive = true
    self._engineWantsIdle = nil
    self._customIdleActive = false
    self:ClearAnimSounds()

    -- Play ["melee"] animation via EasySendWeaponAnim
    -- Falls back to ACT_VM_MELEE if the key doesn't exist.
    self:EasySendWeaponAnim("melee", ACT_VM_MELEE)

    local vm = self.Owner:GetViewModel()
    local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Timing
    self._meleeHitTime = ct + (self.MeleeHitDelay or 0.15)
    self._meleeHitDone = false
    self._meleeEndTime = ct + animDuration
    self._nextMelee = ct + (self.MeleeDelay or 0.6)

    -- Lock controls
    self:SetNextPrimaryFire(ct + animDuration)
    self:SetNextSecondaryFire(ct + animDuration)
    self.NextReload = ct + animDuration

    -- Play swing sound
    self:PlayMeleeSound(self.MeleeSound, 75, 100)
end

function SWEP:PlayMeleeSound(soundEntry, vol, pitch)
    -- Supports both single strings and tables of strings (random pick)
    if not soundEntry then return end
    local snd = soundEntry
    if istable(soundEntry) then
        snd = soundEntry[math.random(1, #soundEntry)]
    end
    if snd and snd ~= "" then
        self:EmitSound(snd, vol or 75, pitch or 100, 1, CHAN_USER_BASE)
    end
end

-- ==========================================
-- MELEE HIT TRACE
-- ==========================================
-- Hull trace forward. Applies damage to valid targets.
-- Called from Think() at MeleeHitDelay seconds after melee start.

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


-- ==========================================
-- MELEE END
-- ==========================================
-- Resets state and lets idle take over.

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self:ClearAnimSounds()
    self._engineWantsIdle = true
end


-- ==========================================
-- SECONDARY ATTACK GUARD
-- ==========================================
-- Blocks zoom during melee so ADS doesn't fight the animation.

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end


-- ==========================================
-- RELOAD (fully self-contained — does NOT call BaseClass.Reload)
-- ==========================================
-- Same fix as the MOG 12: the BO3 base shotty's cycle-based
-- ReloadShotgun doesn't work with these models. We override both
-- Reload() and ReloadShotgun() to use a timer-based approach.

function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end

    -- Block reload while holding E (USE) so inspect (E+R) doesn't cancel reload
    if self.Owner:KeyDown(IN_USE) then return end

    local ct = CurTime()

    -- Don't reload if already reloading, sprinting, or blocked
    if self.NextReload >= ct then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self.Owner:GetNWFloat("GrenadeTime", 0) > ct then return end
    if self:GetNWFloat("DeployTime", 0) > ct then return end

    -- Don't reload if clip is full or no reserve ammo
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then return end

    -- Ensure fire mode is active
    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

    -- Play third-person reload animation
    self.Owner:SetAnimation(PLAYER_RELOAD)
    self.NextReload = ct + 0.5

    -- Call PreReload (sets b_clip for pump logic)
    self:PreReload()

    -- Handle flashlight/flare cancellation (server-side)
    if SERVER then
        if self.Owner:GetNWBool("UH_Flashlight") then
            self.Owner:SetNWBool("UH_Flashlight", false)
            self.Owner:SetNWBool("UH_ArmGone", false)
            if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
            end
            self.Owner:EmitSound("uh/flashlight.wav")
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

    -- Play the start reload animation
    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)
    self:SetupAnimSounds("start_reload")

    -- Get the duration of the start_reload animation
    local vm = self.Owner:GetViewModel()
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Set up our own timer for shell insertion
    -- First shell inserts RIGHT WHEN start_reload finishes (no extra gap).
    local shellInterval = self.Primary.ReloadTime or 0.4
    self._krm_nextShell = ct + startDur

    -- Also set reloaddelay for compatibility with base class code
    self.reloaddelay = self._krm_nextShell

    -- Block firing during reload start
    self:SetNextPrimaryFire(ct + startDur + 0.1)
    self:SetNextSecondaryFire(ct + startDur + 0.1)
    self.NextReload = ct + startDur + 0.1

    -- Set reload state
    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)

    -- Set up HUD reload timer
    local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
    local amount = num * shellInterval
    self:SetNWFloat("ReloadTime", amount)
    self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
end

-- ============================================================
-- RELOAD SHOTGUN (fully self-contained, timer-based)
-- ============================================================
function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end

    -- ==========================================
    -- STOP CONDITIONS: clip full, no reserve, or fire pressed
    -- ==========================================
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then

        self:ClearAnimSounds()

        -- Play the finish animation
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)
        self:SetupAnimSounds("after_reload")

        local vm = self.Owner:GetViewModel()
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur

        self._krm_nextShell = nil
        self.reloaddelay = nil

        self:PostReload()
        return
    end

    -- ==========================================
    -- TIMER-BASED SHELL INSERTION
    -- ==========================================
    if self._krm_nextShell and ct >= self._krm_nextShell then
        local shellInterval = self.Primary.ReloadTime or 0.4

        -- Schedule the next shell insertion
        self._krm_nextShell = ct + shellInterval

        -- Play the per-shell reload animation
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
        self:SetupAnimSounds("reload_loop")

        -- Play the shell insertion sound (if set)
        if self.Primary.ShellSound then
            if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
                self.Owner:EmitSound(self.Primary.ShellSound, 75, 100, 1, CHAN_USER_BASE)
            end
        end

        -- Insert shell (server-authoritative)
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end


-- ==========================================
-- THINK OVERRIDE
-- ==========================================
-- Handles melee timing (hit trace + animation end),
-- holster finish, and delegates to base Think.

-- ==========================================
-- START MANTLE
-- ==========================================
-- Called when the BO3 parkour addon starts a vault or mantle.
-- Plays the ["mantle"] viewmodel animation and blocks weapon actions.

function SWEP:StartMantle()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if not (sp or iftp) then return end

    -- Cancel conflicting states
    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then
        self:SetUHBool("Running", false)
    end
    if self._meleeActive then
        self:EndMelee()
    end

    -- Cancel reload
    if self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end

    -- Set mantle state
    self._mantleActive = true
    self._engineWantsIdle = nil
    self._customIdleActive = false
    self:ClearAnimSounds()

    -- Play ["mantle"] animation
    self:EasySendWeaponAnim("mantle", ACT_VM_MELEE_SHOVE)

    local vm = self.Owner:GetViewModel()
    local animDuration = IsValid(vm) and vm:SequenceDuration() or (self.MantleDuration or 0.6)

    -- Use whichever is longer: animation duration or addon traversal duration
    local mantleDur = math.max(animDuration, self.MantleDuration or 0.6)
    self._mantleEndTime = ct + mantleDur

    -- Lock controls
    self:SetNextPrimaryFire(ct + mantleDur)
    self:SetNextSecondaryFire(ct + mantleDur)
    self.NextReload = ct + mantleDur
end


-- ==========================================
-- END MANTLE
-- ==========================================

function SWEP:EndMantle()
    self._mantleActive = false
    self._mantleEndTime = nil
    self:ClearAnimSounds()
    self._engineWantsIdle = true
end


function SWEP:Think()
    local ct = CurTime()

    -- ==========================================
    -- PARKOUR TRAVERSAL DETECTION
    -- ==========================================
    -- Detects when the BO3 parkour addon sets BO3_IsVaulting / BO3_IsMantling.
    local ply = self.Owner
    if IsValid(ply) then
        local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
        local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
        local isInTraversal = isVaulting or isMantling

        if isInTraversal and not self._mantleActive then
            if SERVER or IsFirstTimePredicted() then
                self:StartMantle()
            end
        end

        if not isInTraversal and self._mantleActive then
            self:EndMantle()
        end

        self._lastBO3IsVaulting = isVaulting
        self._lastBO3IsMantling = isMantling
    end

    -- Mantle timeout safety
    if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
        self:EndMantle()
    end

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then
            self:DoMeleeTrace()
        end
    end

    -- Melee end timing
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
            if IsValid(target) then
                self.Owner:SelectWeapon(target:GetClass())
            end
        end
    end

    -- ==========================================
    -- RELOAD SHOTGUN — called directly, not through BaseClass.Think
    -- ==========================================
    if self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
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
    -- Cancel any in-flight burst
    self._burstRemaining = nil
    self._burstNextFire = nil
    -- Cancel rechamber
    self._isRechambering = false
    -- Reset animation transition trackers
    self.wasZooming = false
    self.wasRunning = false
    -- Note: timer.Simple closures will still fire but the above
    -- state resets make their checks self-correcting
    return BaseClass.Holster(self)
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
        
        self:SetHoldType( self.HoldType )

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

    -- Reset melee state
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil

    -- Reset mantle state
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._lastBO3IsVaulting = false
    self._lastBO3IsMantling = false

    return false
end

function SWEP:HandleRunning( ct )
    if self:GetUHBool("Reloading") then
        return
    end
        
        local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end
        
        if self:GetNWFloat("DeployTime", 10) then


    local dist = self.Owner:GetVelocity():LengthSqr()
    local isSprinting = self.Owner:KeyDown( IN_SPEED ) and dist > self.Owner:GetWalkSpeed()^2
    local isSafeMode = self:GetNWInt("FireMode") == 0

    -- 1. SPRINTING (Takes Priority)
    if isSprinting then
        self:SetHoldType( self.PassiveAnim )
        self:SetUHBool("Running", true) -- Set to TRUE so animations play
        self:SetUHBool("Zooming", false)
        
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", false)
            self.NextReload = ct + 0.5
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove( "UHReload_"..self.Owner:SteamID() )
            end
        end

    -- 2. NOT SPRINTING
                else
                        self:SetHoldType( self.HoldType )
        
                        -- If we are in Safe Mode (and not sprinting), ensure we are flagged as NOT running.
                        -- This allows the procedural lowering to take effect.
                        if isSafeMode then
                                self:SetUHBool("Running", false) 
                        else
                                self:SetUHBool("Running", false)
                        end
                end
        end
end

function SWEP:GetViewModelPosition(pos, ang)
    local ft = FrameTime()

    -- Pass through BaseClass logic (Sway, Inspect, etc.)
    if BaseClass and BaseClass.GetViewModelPosition then
        pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    end

    -- ==========================================
    -- HYBRID LOWERING LOGIC (Safe Mode)
    -- ==========================================
    
    -- We only use procedural LoweredPos/Ang if we are in SAFE MODE
    -- AND we are NOT Sprinting.
    local target = 0
    if self:GetNWInt("FireMode") == 0 and not self:GetUHBool("Running") then
        target = 1
    end

    self._uhLower = Lerp(ft * 8, self._uhLower or 0, target)

    -- Apply Safe Mode Lowering (Procedural)
    if self._uhLower > 0.001 then
        local lp = self.LoweredPos or vector_origin
        local la = self.LoweredAng or angle_zero

        local ap, ay, ar = 0, 0, 0
        if isangle(la) then
            ap, ay, ar = la.p, la.y, la.r
        elseif isvector(la) then
            ap, ay, ar = la.x, la.y, la.z
        end

        ang:RotateAroundAxis(ang:Right(),   ap * self._uhLower)
        ang:RotateAroundAxis(ang:Up(),      ay * self._uhLower)
        ang:RotateAroundAxis(ang:Forward(), ar * self._uhLower)

        pos = pos
            + ang:Right()   * lp.x * self._uhLower
            + ang:Forward() * lp.y * self._uhLower
            + ang:Up()      * lp.z * self._uhLower
    end

    -- ==========================================
    -- ALTERNATIVE POS/ANG LOGIC (Ultra Guns Style)
    -- ==========================================
    
    -- Determine if we should show the offset
    -- We hide it if: Sprinting, Zooming, or in Safe Mode
    local targetAlt = 1
    if self:GetUHBool("Running") or self:GetUHBool("Zooming") or self:GetNWInt("FireMode") == 0 then
        targetAlt = 0
    end

    -- Smoothly interpolate the factor
    self._altFactor = Lerp(ft * 10, self._altFactor or 0, targetAlt)

    -- Apply the offset if it exists
    if (self.AlternativePos or self.AlternativeAng) and self._altFactor > 0.01 then
        local ap = self.AlternativePos or vector_origin
        local aa = self.AlternativeAng or angle_zero

        -- Apply Position Offset
        pos = pos
            + ang:Right()   * ap.x * self._altFactor
            + ang:Forward() * ap.y * self._altFactor
            + ang:Up()      * ap.z * self._altFactor

        -- Apply Angle Offset
        local ap_p, ap_y, ap_r = 0, 0, 0
        if isangle(aa) then
            ap_p, ap_y, ap_r = aa.p, aa.y, aa.r
        elseif isvector(aa) then
            ap_p, ap_y, ap_r = aa.x, aa.y, aa.z
        end

        ang:RotateAroundAxis(ang:Right(),   ap_p * self._altFactor)
        ang:RotateAroundAxis(ang:Up(),      ap_y * self._altFactor)
        ang:RotateAroundAxis(ang:Forward(), ap_r * self._altFactor)
    end

    -- ==========================================
    -- SPRINT Z-AXIS OFFSET (Smoothed)
    -- ==========================================
    local targetZ = self:GetUHBool("Running") and 0 or 0
    self._sprintZOffset = Lerp(ft * 10, self._sprintZOffset or 0, targetZ)
    pos = pos + ang:Up() * self._sprintZOffset

    return pos, ang
end

function SWEP:HandleSprintingAnimations()
    local ply = self:GetOwner()
    
    if not IsValid(ply) or not ply:IsPlayer() then return end

    -- Use UH variable for running state
    local isRunning = self:GetUHBool("Running")
    local isReloading = self:GetUHBool("Reloading")

    -- Initialize tracking variable
    if self.wasRunning == nil then self.wasRunning = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    -- TRANSITION: Enter Sprint
    if isRunning and not self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_SPRINT_ENTER)
        end
    
    -- TRANSITION: Exit Sprint
    elseif not isRunning and self.wasRunning then
        if not isReloading then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_SPRINT_LEAVE)
        end
    
    -- LOOPING: While Sprinting (and not reloading)
    elseif isRunning and not isReloading then
        -- If the current sprint animation finished (cycle >= 1), restart it
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_SPRINT_IDLE)
        end
    end

    self.wasRunning = isRunning
end

if CLIENT then
        local WorldModel = ClientsideModel(SWEP.WorldModel)
        WorldModel:SetSkin(1)
        WorldModel:SetNoDraw(true)

        function SWEP:DrawWorldModel()
                local _Owner = self:GetOwner()
                if IsValid(_Owner) then
                        local offsetVec = Vector(0, -2, -1)
                        local offsetAng = Angle(180, 90, 0)
                        local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand")
                        if not boneid then return end
                        local matrix = _Owner:GetBoneMatrix(boneid)
                        if not matrix then return end
                        local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
                        WorldModel:SetPos(newPos)
                        WorldModel:SetAngles(newAng)
                        WorldModel:SetupBones()
                else
                        WorldModel:SetPos(self:GetPos())
                        WorldModel:SetAngles(self:GetAngles())
                end
                WorldModel:DrawModel()
        end
end