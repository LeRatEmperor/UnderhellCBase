AddCSLuaFile()

SWEP.PrintName                          = "Underhell Gun Base"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.UseHands                           = false
SWEP.Base                               = "weapon_uh_base"

SWEP.Spawnable                          = false
SWEP.AdminSpawnable                     = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_smg_mp5_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_smg_mp5_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                               = 2
SWEP.SlotPos                            = 3

SWEP.HoldType                           = "smg"
SWEP.FiresUnderwater                    = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = true
SWEP.DrawWeaponInfoBox                  = false
SWEP.SmokeWidth                         = 30
SWEP.Chambering                         = true
SWEP.ZoomFov							= 15

SWEP.NoShell                            = false
SWEP.ShellHeat                          = 0.8
SWEP.Shell                              = "models/weapons/shell_9mm.mdl"

-- Muzzle Flash System
SWEP.MuzzleFlashType = "default"
SWEP.MuzzleFlashTexture = ""
SWEP.MuzzleFlashParticle = ""
SWEP.MuzzleFlashColor = nil
SWEP.MuzzleFlashLightColor = nil
SWEP.MuzzleFlashScale = 1
SWEP.MuzzleFlashLightBrightness = 4
SWEP.MuzzleFlashLightSize = 96
SWEP.MuzzleFlashLightDecay = 128

SWEP.FireModes                          = {}

SWEP.Primary.Sound          = Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.SilSound           = Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.ClipSize           = 30
SWEP.Primary.Ammo                       = "UH_SMG"
SWEP.Primary.DefaultClip        = 30
SWEP.Primary.MinDamage      = 12
SWEP.Primary.MaxDamage      = 18
SWEP.Primary.Automatic          = true
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Force                      = 15
SWEP.Primary.Spread             = 0.45
SWEP.Primary.Delay                      = 0.08
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -0.6
SWEP.Primary.MaxRecoil          = -1.4

SWEP.Secondary.ClipSize         = -1 
SWEP.Secondary.Ammo             = "none" 
SWEP.Secondary.DefaultClip      = -1     
SWEP.Secondary.Automatic        = false

SWEP.SwayScale  = 0
SWEP.BobScale   = 0

SWEP.HolsterTime				= 0.3

-- Backwards compatibility toggles
-- If UseQCReloadEvents is true, QC animation event 5004 sound options will be played (Simple Base style).
-- If UseReloadTable is true, Underhell's ReloadTable timeline system will be used.
-- If both are true, QC events take priority (so you don't get double sounds).
SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.ReloadTable = {}
SWEP.AnimSounds = {}

SWEP.ReloadSpeed = 1

SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Inspection = {
        {
                pos = Vector(8, -8, 0),
                ang = Angle(40, 40, 40)
        },
        {
                pos = Vector(-4, -8, -8),
                ang = Angle(20, 40, -60)
        },
}

SWEP.SwayPosition = 2

local h_scope = 0
local SCOPE_MAT = Material("gmod/scope")

function SWEP:Initialize()
        util.PrecacheSound(self.Primary.Sound)
        util.PrecacheModel(self.ViewModel)
        util.PrecacheModel(self.WorldModel)
        self:SetWeaponHoldType( self.HoldType )
        self:SetHoldType( self.HoldType )
        self.NextReload = CurTime()
        self:SetNWInt("FireMode", 1)
        
        if CLIENT and self.ScopeTexture then
                local scale = ScrH()/1080
                local quality = {
                        256,
                        512,
                        768,
                        1080
                }
                
                local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
                self.RT_Size = quality[num] * scale
                
                self.RenderTarget = GetRenderTarget("UH_SniperScopeRT_"..num, self.RT_Size, self.RT_Size, false)
        end
end

-- UG Architecture: Handles the actual sending of the sequence to the Viewmodel
function SWEP:SendSequence(vm, seq)
    if not IsValid(vm) or seq == nil then return end
    
    vm:SendViewModelMatchingSequence(seq)
end

-- UG Architecture: Looks up a sequence name/ID. If valid, plays it. If not, plays the backup Activity.
function SWEP:SendAnim(vm, lookupsequence, backup)
    if not IsValid(vm) then return end

    if lookupsequence then
        local seq = self:LookupSequence(lookupsequence)
        if seq and seq > 0 then
            self:SendSequence(vm, seq)
        else
            local act = type(backup) == "number" and vm:SelectWeightedSequence(backup) or -1
            if act >= 0 then self:SendSequence(vm, act) end
        end
    else
        local act = type(backup) == "number" and vm:SelectWeightedSequence(backup) or -1
        if act >= 0 then self:SendSequence(vm, act) end
    end
    
    vm:SetCycle(0)
end

-- Checks the SWEP.Animations table. If the key exists, tries to play it. 
-- If it doesn't exist or the lookup fails, plays the 'elseifnotfounded' fallback.
function SWEP:EasySendWeaponAnim(lookupanimation, elseifnotfounded)
    local ply = self:GetOwner()
    if not ply:IsValid() then return end

    local vm = ply:GetViewModel()
    if not vm:IsValid() then return end

    if self.Animations and self.Animations[lookupanimation] then
        local animData = self.Animations[lookupanimation]
        
        if istable(animData) then
            animData = animData[math.random(1, #animData)]
        end

        local seq = self:LookupSequence(animData)
        
        if seq and seq > 0 then
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

-- ==========================================
-- ANIM SOUNDS SYSTEM
-- Plays timed sounds during weapon animations.
-- Keyed by SWEP.Animations lookup keys (not model sequence names).
-- Inspired by CW 2.0's SWEP.Sounds, but keys by Animations key
-- so random animation variants share one sound table.
--
-- Supported animation keys:
--   ["draw"], ["idle"], ["idle_empty"], ["idle_sil"],
--   ["shoot"], ["shoot_ads"], ["shoot_sil"], ["shoot_ads_sil"],
--   ["reload"], ["reload_empty"], ["idle_walk"], or any custom key you use in Animations.
--
-- Usage in SWEP:
--   SWEP.Animations = {
--       ["draw"]         = "draw",
--       ["idle"]         = "idle",
--       ["shoot"]        = {"fire1", "fire2"},
--       ["shoot_ads"]    = "ads_fire",
--       ["reload"]       = "reload",
--       ["reload_empty"] = "reload_empty",
--   }
--
--   SWEP.AnimSounds = {
--       ["draw"] = {
--           {time = 0, sound = "weapon_draw"},
--       },
--       ["idle"] = {
--           {time = 0, sound = "weapon_idle_click"},
--       },
--       ["shoot"] = {
--           {time = 0, sound = "weapon_fire_tail"},
--       },
--       ["shoot_ads"] = {
--           {time = 0, sound = "weapon_fire_tail_ads"},
--       },
--       ["reload"] = {
--           {time = 0,   sound = "reload_magout"},
--           {time = 1.2, sound = "reload_magin"},
--       },
--       ["reload_empty"] = {
--           {time = 0,   sound = "reload_magout"},
--           {time = 1.3, sound = "reload_magin"},
--           {time = 1.7, sound = "reload_bolt"},
--       },
--   }
--
-- Optional entry fields: time, sound, level, pitch, callback
-- Empty sound strings ("") will be skipped (useful for silencing).
-- ==========================================

-- Sets up a sound timeline for the given animation key.
-- Automatically called by EasySendWeaponAnim and Reload().
function SWEP:SetupAnimSounds(animKey, variantName)
    if not self.AnimSounds then return end
    
    -- Try variant name first (specific sequence name), then base key (e.g. "reload")
    local timeline = nil
    if variantName and self.AnimSounds[variantName] then
        timeline = self.AnimSounds[variantName]
    end
    if not istable(timeline) or #timeline == 0 then
        timeline = self.AnimSounds[animKey]
    end
    
    -- Fallback: reload_empty -> reload (if reload_empty has no dedicated table)
    if (not timeline or not istable(timeline)) and animKey == "reload_empty" then
        timeline = self.AnimSounds["reload"]
    end
    
    if not istable(timeline) or #timeline == 0 then return end
    
    self._animSoundTimeline = timeline
    self._animSoundIndex = 1
    self._animSoundStartTime = CurTime()
    
    local owner = self:GetOwner()
    if IsValid(owner) then
        local vm = owner:GetViewModel()
        self._animSoundPlaybackRate = IsValid(vm) and vm:GetPlaybackRate() or 1
    else
        self._animSoundPlaybackRate = 1
    end
    self._animSoundActive = true
end

-- Processes the current sound timeline. Called from SWEP:Think().
function SWEP:ProcessAnimSounds()
    if not self._animSoundActive then return end
    
    -- Prediction guard: play sounds only once per tick
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()
    if not ((sp and SERVER) or (not sp and CLIENT and iftp)) then return end
    
    local owner = self:GetOwner()
    if not IsValid(owner) then
        self._animSoundActive = false
        return
    end
    
    local timeline = self._animSoundTimeline
    local idx = self._animSoundIndex
    
    if idx > #timeline then
        self._animSoundActive = false
        return
    end
    
    local elapsed = (CurTime() - self._animSoundStartTime) * self._animSoundPlaybackRate
    
    while idx <= #timeline and elapsed >= timeline[idx].time do
        local entry = timeline[idx]
        
        -- Play sound (skip empty strings to allow muting animations)
        if entry.sound and entry.sound ~= "" then
            owner:EmitSound(entry.sound, entry.level or 75, entry.pitch or 100, 1, CHAN_USER_BASE)
        end
        
        -- Run optional callback
        if entry.callback then
            entry.callback(self)
        end
        
        idx = idx + 1
    end
    
    self._animSoundIndex = idx
end

-- Clears the current sound timeline.
-- Call when animation is interrupted (holster, sprint, weapon swap, etc.).
function SWEP:ClearAnimSounds()
    self._animSoundActive = false
    self._animSoundTimeline = nil
    self._animSoundIndex = 0
end

function SWEP:Think()
    local ct = CurTime()
	
	    -- ==========================================
    -- RELOAD SPEED ENFORCEMENT (Think-based, not PreDrawViewModel)
    -- Applies speed directly to the original animation each frame
    -- before the engine's animation update, avoiding any "copy" flicker.
    -- Also detects when the reload animation finishes and ends it immediately.
    -- ==========================================
    if self:GetUHBool("Reloading") then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            if self.ReloadSpeed and self.ReloadSpeed ~= 1 then
                vm:SetPlaybackRate(self.ReloadSpeed)
            end

            -- End reload when the animation finishes (no timer needed)
            if self._reloadEndTime and ct >= self._reloadEndTime then
                self:_FinishReload()
            end
        end
    end
    -- ==========================================
    
    -- ==========================================
    -- HOLD-TO-ZOOM LOGIC
    -- ==========================================
    local isZooming = self:GetUHBool("Zooming")
    
    -- Conditions that prevent zooming (Jumping, Running, Reloading, etc.)
    local preventZoom = not self.Owner:OnGround() or 
                        self.Owner:GetNWBool("UH_Flare") or 
                        self.Owner:GetNWBool("UH_Flashlight") or 
                        self:GetUHBool("Running") or 
                        self:GetUHBool("Reloading") or 
                        self:GetNWFloat("DeployTime") > ct or
                        self.Owner:GetNWFloat("UH_GrenadeTime") > ct

    -- Determine if player wants to zoom.
    -- NOTE: The check 'not self.Owner:KeyDown(IN_USE)' prevents zooming when changing firemodes (E+M2).
    local wantsToZoom = self.Owner:KeyDown(IN_ATTACK2) and 
                        not preventZoom and 
                        not self.Owner:KeyDown(IN_USE) and 
                        self:GetNWInt("FireMode") != 0

    -- Force Zoom Off if something interrupted it (like jumping while zoomed)
    if isZooming and preventZoom then
        self:SetUHBool("Zooming", false)
        if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_off.wav", 65, 100, 1, CHAN_USER_BASE)
        end
    -- Handle Button Release (Stop Zooming)
    elseif isZooming and not wantsToZoom then
        self:SetUHBool("Zooming", false)
        if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_off.wav", 65, 100, 1, CHAN_USER_BASE)
        end
    -- Handle Button Press (Start Zooming)
    elseif not isZooming and wantsToZoom then
        self:SetUHBool("Zooming", true)
        if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
            self.Owner:EmitSound("weapons/underhell/ironsight_on.wav", 64, 100, 1, CHAN_USER_BASE)
        end
    end
    
    -- ==========================================
    -- STANDARD THINK LOGIC
    -- ==========================================
    
    self:HandleRunning( ct )
    
    if self.Shotgun and self.ReloadShotgun then
        self:ReloadShotgun( ct )
    end
    
    --[[ if self.WalkAnim then
        local vel = self.Owner:GetVelocity()
        local isMoving = vel:Length() > 0 and self.Owner:OnGround() and not self:GetUHBool("Zooming")

        -- Only proceed if not reloading or sprinting
        if not isReloading and not self:GetUHBool("Running") and not self:GetUHBool("Reloading") then
            -- Detect State Change (Stopped -> Moving, or Moving -> Stopped)
            if isMoving ~= (self._wasMoving or false) then
                self._wasMoving = isMoving
                
                if isMoving then
                    -- Just started walking: Play Walk Animation
                    self:EasySendWeaponAnim("idle_walk", ACT_VM_WALK)
                else
                    -- Just stopped walking — let the idle system take over
                    self._nextIdlePlay = nil
                end
            else
                -- Continuous Loop: While walking
                if isMoving then
                    local vm = self.Owner:GetViewModel()
                    if IsValid(vm) and vm:GetCycle() >= 1 then
                        -- If the animation loop finished, restart it
                        self:EasySendWeaponAnim("idle_walk", ACT_VM_WALK)
                    end
                end
            end
        end
    end ]]--
	
    -- ==========================================
    -- RELOAD COMPLETION CHECK (Cycle-based)
    -- Monitors the viewmodel cycle to detect when the reload animation
    -- finishes, avoiding the 1-frame flash that timers cause.
    -- ==========================================
    if self:GetUHBool("Reloading") and self._reloadEndTime and ct >= self._reloadEndTime then
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            local cycle = vm:GetCycle()
            
            -- Animation has reached the end (cycle wraps back or hits ~1.0)
            if cycle >= 0.95 then
                vm:SetPlaybackRate(1)
                vm:SetCycle(0)
                
                self:PostReload()
                
                -- Post-reload idle transition
                self._customIdleActive = false
                
                if self:GetNWBool("Silenced") then
                    self:EasySendWeaponAnim("idle_sil", ACT_VM_IDLE_SILENCED)
                else
					self:EasySendWeaponAnim("idle", ACT_VM_IDLE)
                    self._engineWantsIdle = true
                end
                
                self:SetUHBool("Reloading", false)
                self:SetNWFloat("ReloadTime", 0)
                self:SetNWFloat("ReloadEndTime", 0)
                self:ClearAnimSounds()
                self._reloadEndTime = nil
                
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
                    
                    if self.b_reflashlight then
                        self.b_reflashlight = nil
                        self.Owner:SetNWBool("UH_Flashlight", true)
                        self.Owner:SetNWBool("UH_ArmGone", true)
                        
                        net.Start("UH_Flashlight")
                            net.WriteEntity(self.Owner)
                            net.WriteBool(true)
                        net.Broadcast()
                    end
                end
            end
        end
    end
    
    -- ==========================================
    -- CUSTOM IDLE ANIMATION SUPPORT
    -- ==========================================
    -- Manages the ["idle"] / ["idle_empty"] loop using a timer-based approach.
    -- When the silencer is ON, this code skips entirely — the engine handles
    -- ACT_VM_IDLE_SILENCED automatically, and the silencer toggle code path
    -- handles ["idle_sil"] replay if defined.
    --
    -- WHY TIMER-BASED: The old cycle-based approach (vm:GetCycle() >= 1) works
    -- for idle_sil but NOT for idle/idle_empty. The engine auto-loops ACT_VM_IDLE,
    -- resetting cycle to 0 before Think() can see >= 1. Using a real-time timer
    -- (CurTime() + SequenceDuration()) completely bypasses this race condition.

    -- Skip entirely if silenced — engine handles it
    if not self:GetNWBool("Silenced") and not self:GetUHBool("Running") 
        and not self:GetUHBool("Reloading") 
        and self:GetNWFloat("DeployTime") < ct 
        and self:GetNWFloat("ReloadEndTime") < ct 
        and self:GetNWFloat("SilenceTime") < ct
        and self:GetNWInt("FireMode") != 0 then
        
        local vel = self.Owner:GetVelocity()
        local isMoving = vel:Length() > 0 and self.Owner:OnGround()
        
        if not isMoving and not self:GetUHBool("Zooming") then
            local vm = self.Owner:GetViewModel()
        else
            -- Moving or zooming — clear timer
            self._nextIdlePlay = nil
        end
    else
        -- Silenced / blocked state — clear timer
        self._nextIdlePlay = nil
    end
    
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        self:HandleBones( vm, ct )
        self:HandleHands( vm )
    end
    
    -- ==========================================
    -- ANIM SOUNDS PROCESSING
    -- ==========================================
    self:ProcessAnimSounds()
    
    if self.CustomThink then
        self:CustomThink( ct )
    end
end

function SWEP:GetShootSound()
    local isSilenced = self:GetNWBool("Silenced")
    local source = isSilenced and self.Primary.SilSound or self.Primary.Sound
    
    -- If the source is a table, pick a random element
    if istable(source) then
        -- Ensure the element is a string (Sound objects might be in tables)
        local soundData = source[math.random(1, #source)]
        return tostring(soundData)
    end
    
    return source
end

function SWEP:PrimaryAttack()
        if not self:CanPrimaryAttack() then return end
        
        local sp = game.SinglePlayer()
        local iftp = IsFirstTimePredicted()
        
        if SERVER or iftp then
                local mode = self.FireModes[self:GetNWInt("FireMode")]
                if mode and mode.shoot then
                        local res = mode.shoot(self.Owner, self)
                        if res then return end
                end
                
                if self:GetNWBool("Silenced") then
                        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.Round(math.random(self.Primary.MinDamage,self.Primary.MaxDamage)*0.95), self.Penetration or 2)
                else
                        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.random(self.Primary.MinDamage,self.Primary.MaxDamage), self.Penetration or 2)
                end
        end
        
        local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)
        
        if sp or (CLIENT and iftp) then
                self:DoMuzzleFlash()
                
                self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )
                
                if not self.NoShell then
                        self:CreateShell( self.ShellDelay or 0, self.ShellHeat )
                end
                
                self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
        end
        
    self.Owner:ViewPunch( Angle( recoil, 0, 0 ) )
    
    -- ==========================================
    -- ANIMATION LOGIC (Fixed Fallback for Silenced)
    -- ==========================================
    self:SendWeaponAnim( ACT_VM_IDLE, "idle" ) 
    
    local isSilenced = self:GetNWBool("Silenced")
    local baseAct = ACT_VM_PRIMARYATTACK
    if self.ShootAnimation then
        baseAct = self:ShootAnimation()
    end
    
    -- Try named key first, but respect ironsights state
    -- "shoot" / "shoot_sil" for hip fire, "shoot_ads" / "shoot_ads_sil" for ironsights
    -- If no named key exists, fall back to numeric ACT string (preserves ACT fallback behavior)
    local isZooming = self:GetUHBool("Zooming")
    local lookupKey = isZooming and "shoot_ads" or "shoot"
    if isSilenced then
        lookupKey = lookupKey .. "_sil"
    end
    if not self.Animations or not self.Animations[lookupKey] then
        -- No named key found, fall back to ACT number string for backwards compat
        lookupKey = tostring(baseAct)
        if isSilenced then
            lookupKey = lookupKey .. "_sil"
        end
    end
    
    -- ==========================================
    -- CORRECTED FALLBACK ACTIVITY LOGIC
    -- ==========================================
    -- Determine the correct default Activity if the table lookup fails
    local fallbackActivity = baseAct
    if isSilenced then
        if baseAct == ACT_VM_PRIMARYATTACK then
            fallbackActivity = ACT_VM_PRIMARYATTACK_SILENCED
        elseif baseAct == ACT_VM_SECONDARYATTACK then
            fallbackActivity = ACT_VM_SECONDARYATTACK_SILENCED
        end
    end
    
    -- Pass the calculated Fallback Activity to the helper
    self:EasySendWeaponAnim(lookupKey, fallbackActivity)

    -- ==========================================
    -- RESET CYCLE
    -- ==========================================
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        vm:SetCycle(0)
        vm:SetPlaybackRate(1)
    end
    -- ==========================================

    self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:MuzzleFlash()
        
    local fireSound = self:GetShootSound()
    self:EmitSound( fireSound, 110, 100, 1, CHAN_WEAPON )
        self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
        self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
        self:TakePrimaryAmmo(self.Primary.TakeAmmo)
        
        self.NextReload = CurTime() + 0.5
        
        self:PostShoot()
end

function SWEP:ShootBullets(pos, buldir, dmg, tries)
        if tries <= 0 then return end
        
        local movement = Vector(self.Owner:GetVelocity().x, self.Owner:GetVelocity().y, 0):LengthSqr()
        local movepercent = math.Clamp(movement/self.Owner:GetRunSpeed()^2, 0, 1)
        local move = movepercent*0.1
        
        if self.Owner:OnGround() then
                if self:GetUHBool("Zooming") and self.Owner:Crouching() then
                        spread = self.Primary.Spread * 0.18
                elseif self:GetUHBool("Zooming") then
                        spread = self.Primary.Spread * 0.26
                elseif self.Owner:Crouching() then
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
        bullet.Spread = Vector( spread, spread, 0)
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
                        tr.start = bultrace.HitPos - dir*(self.PenetrationDepth or 4)
                        tr.endpos = bultrace.HitPos
                        tr.filter = self.Owner
                        tr.mask = MASK_SHOT
                        
                        local trace = util.TraceLine(tr)
                        
                        if not trace.AllSolid and trace.Fraction > 0 and GetConVar("uh_sv_penetration"):GetBool() then
                                self:ShootBullets(trace.HitPos, buldir, math.Round(dmg*math.Rand(0.5, 0.6)), tries - 1)
                        end
                        
                        if mat == MAT_METAL or mat == MAT_VENT or mat == MAT_GRATE then
                                local fx = EffectData()
                                fx:SetOrigin(bultrace.HitPos)
                                fx:SetScale(1)
                                util.Effect("uh_hitworld",fx)
                        end
                end
        end
        
        self.Owner:FireBullets( bullet )
end

function SWEP:ShootGrenade(force)
        if SERVER then
                local ent = ents.Create( "sent_mgl_grenade" )
                ent:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 30 + self.Owner:GetUp() * -10 + (self:GetUHBool("Zooming") and Vector(0,0,0) or self.Owner:GetRight() * 5) )
                ent:SetAngles( self.Owner:GetAngles() )
                ent:Spawn()
                ent:Activate()
                ent.Owner = self.Owner
                local phys = ent:GetPhysicsObject()
                if phys != nil and (phys:IsValid()) then
                        phys:ApplyForceCenter(self.Owner:GetAimVector() * force)
                end
        end
end

function SWEP:PostShoot()
end

-- Configurable functions
function SWEP:ShootAnimation()
        return ACT_VM_PRIMARYATTACK
end

function SWEP:GrenadeAnimation()
        return ACT_VM_PRIMARYATTACK
end

function SWEP:GetShellDirection()
        return Angle(30,-90,0)
end

-- Viewmodel functions
function SWEP:GetMuzzle()
        return 1
end

function SWEP:GetDisplay()
        return 1
end

function SWEP:GetShellEject()
        return 2
end

function SWEP:DoMuzzleFlash()
        if self:GetNWBool("Silenced") then return end

        if self.MuzzleFlashType == "particle" and self.MuzzleFlashParticle and self.MuzzleFlashParticle ~= "" then
                local vm = self.Owner:GetViewModel()
                if IsValid(vm) then
                        ParticleEffectAttach(self.MuzzleFlashParticle, PATTACH_POINT_FOLLOW, vm, self:GetMuzzle())
                end

                -- Mark time so PostDrawOpaqueRenderables can clear depth for this frame
                self._muzzleFlashTime = CurTime()

                if CLIENT and GetConVar("uh_dynamiclight"):GetBool() then
                        local att = self:GetAttachment(self:GetMuzzle())
                        if att then
                                local dlight = DynamicLight(0)
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

function SWEP:CreateSmoke( att, delay )
        if (delay or 0) > 0 then
                timer.Simple(delay, function()
                        if not IsValid(self) or not IsValid(self.Owner) then return end
                        local fx = EffectData()
                        fx:SetEntity(self)
                        fx:SetOrigin(self.Owner:GetShootPos())
                        fx:SetRadius(self.SmokeWidth or 20)
                        fx:SetAttachment(att)
                        util.Effect("uh_smoke",fx)
                end)
        else
                local fx = EffectData()
                fx:SetEntity(self)
                fx:SetOrigin(self.Owner:GetShootPos())
                fx:SetRadius(self.SmokeWidth or 20)
                fx:SetAttachment(att)
                util.Effect("uh_smoke",fx)
        end
end

function SWEP:CreateShell( delay, heat )
        if (delay or 0) > 0 then
                timer.Create("UH_Shell_"..self.Owner:SteamID(), delay, 1, function()
                        if not IsValid( self ) or not IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end
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
                                        self:EmitSound("weapons/underhell/shells/shotgun_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
                                else
                                        self:EmitSound("player/pl_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
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
                                self:EmitSound("weapons/underhell/shells/shotgun_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
                        else
                                self:EmitSound("player/pl_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
                        end
                end)
        end
end

function SWEP:CanPrimaryAttack()
        if self:GetNWInt("FireMode") == 0 or self:GetNWFloat("DeployTime") > CurTime() or self:GetUHBool("Running") or self:GetUHBool("Reloading") then return false end
        if self:Clip1() <= 0 then
                if not self:GetUHBool("Reloading") then
                        self:EmitSound( "Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE )
                end
                self:SetNextPrimaryFire( CurTime() + 0.4 )
                return false
        end
        return true
end

function SWEP:SecondaryAttack()
    local ct, sp = CurTime(), game.SinglePlayer()
    
    -- Block if reloading or deploying
    if self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > ct then return end
    
    if SERVER or IsFirstTimePredicted() then
        -- Check if player is pressing USE (E) + Attack2 (M2) for Firemode Switching
        if self.Owner:KeyDown(IN_USE) then
            local mode = self:GetNWInt("FireMode") + 1
            if mode > #self.FireModes then
                mode = 0
            end
            
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
                self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )
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
                self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
            end
            
            self:SetNextPrimaryFire( ct + 0.5 )
            self:SetNextSecondaryFire( ct + 0.2 )
            
            self:SetNWInt("FireMode", mode)
            if sp and SERVER or CLIENT then
                self.Owner:EmitSound("uh/flashlight.wav", 64, 100, 1, CHAN_USER_BASE)
            end
        end
    end
end

-- ==========================================
-- RELOAD END (called from Think, replaces timer)
-- ==========================================
function SWEP:_FinishReload()
    if self._reloadFinished then return end
    self._reloadFinished = true

    self:SetUHBool("Reloading", false)
    self:SetNWFloat("ReloadTime", 0)
    self:SetNWFloat("ReloadEndTime", 0)
    self:ClearAnimSounds()

    -- Visual cleanup
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        vm:SetPlaybackRate(1)
        vm:SetCycle(0)
    end

    self:PostReload()

    -- Idle transition
    self._customIdleActive = false
    if IsValid(vm) then
        if self:GetNWBool("Silenced") then
            self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
        else
            self._engineWantsIdle = true
        end
    end

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

        if self.b_reflashlight then
            self.b_reflashlight = nil
            self.Owner:SetNWBool("UH_Flashlight", true)
            self.Owner:SetNWBool("UH_ArmGone", true)
            net.Start("UH_Flashlight")
                net.WriteEntity(self.Owner)
                net.WriteBool(true)
            net.Broadcast()
        end
    end
end

function SWEP:Reload()
    local ct = CurTime()
    
    if self.NextReload < ct and !self:GetUHBool("Running") and !self:GetUHBool("Reloading") and not self.Owner:KeyDown(IN_USE) and self.Owner:GetNWFloat("GrenadeTime") < ct and self:GetNWFloat("DeployTime") < ct then
        if self:Clip1() < ( self.Chambering and self.Primary.ClipSize + 1 or self.Primary.ClipSize ) and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
            if SERVER then
                                self.Owner:SetAnimation(PLAYER_RELOAD)
                        end
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
            
            self:PreReload()
            
            -- ==========================================
            -- FLASHLIGHT/FLARE LOGIC
            -- ==========================================
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
                    UHThrowFlare( self.Owner )
                    
                    self.Owner:SetNWBool("UH_ArmGone", false)
                    if not self.IsBolt and not self.IsPump and not self.TwoHanded then
                        self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
                    end
                else
                    self.b_reflashlight = nil
                end
            end
            
            -- ==========================================
            -- PLAY ANIMATION (Hybrid Logic)
            -- ==========================================
            local vm = self.Owner:GetViewModel()
            local playedAnim = false
            local reloadAnimKey = nil  -- AnimSounds key for reload animation

            -- PRIORITY 1: UH Legacy Style (String Override)
            if self.ReloadAnim and type(self.ReloadAnim) == "string" then
                local seq = vm:LookupSequence(self.ReloadAnim)
                if seq and seq > 0 then
                    self:SendSequence(vm, seq)
                end
                playedAnim = true
            -- PRIORITY 2: UG Table Style
            else
                local isSilenced = self:GetNWBool("Silenced")
                local isEmpty = (self:Clip1() <= 0)
                
                local animToPlay = nil
                local pickedVariant = nil

                local function GetBestAnim(emptyKey, normalKey)
                    local result
                    if isSilenced then
                        result = self.Animations[emptyKey.."_sil"] 
                            or self.Animations[emptyKey] 
                            or self.Animations[normalKey.."_sil"] 
                            or self.Animations[normalKey]
                    else
                        result = self.Animations[emptyKey] 
                            or self.Animations[normalKey]
                    end
                    
                    -- Support table variants (e.g. {"Reload_Half", "Reload_Half_Elite"})
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
                    playedAnim = true
                end
            end

            -- PRIORITY 3: Standard Engine Animations
            if not playedAnim then
                if self:GetNWBool("Silenced") then
                    self:SendSequence(vm, vm:SelectWeightedSequence(ACT_VM_RELOAD_SILENCED))
                else
                    self:SendSequence(vm, vm:SelectWeightedSequence(ACT_VM_RELOAD))
                end
            end

            -- ==========================================
            -- RELOAD DURATION LOGIC
            -- ==========================================
            -- Use SWEP.ReloadTime if defined, otherwise fall back to
            -- the full viewmodel sequence duration.
            local AnimTime = self.ReloadTime or vm:SequenceDuration()
            local speed = self.ReloadSpeed or 1

            if speed ~= 1 then
                AnimTime = AnimTime / speed
                vm:SetPlaybackRate(speed)
            else
                vm:SetPlaybackRate(1)
            end
            -- ==========================================

            -- Track reload end time for Think()-based detection
            self._reloadFinished = false
            self._reloadEndTime = ct + AnimTime
            -- ==========================================

            -- Track reload end time for Think()-based detection

            -- ==========================================
            -- ANIM SOUNDS SETUP (after playback rate is known)
            -- ==========================================
            if reloadAnimKey then
                self:SetupAnimSounds(reloadAnimKey, pickedVariant)
            end

            self.NextReload = ct + AnimTime + 0.5
            self:SetNextPrimaryFire( ct + AnimTime )
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
            self:SetNWFloat("ReloadTime", AnimTime)
            self:SetNWFloat("ReloadEndTime", ct + AnimTime)
            
            -- ==========================================
            -- RELOAD COMPLETION (Cycle-based, like CW 2.0 / TFA)
            -- ==========================================
            -- Instead of a timer (which can desync from the animation),
            -- we track the reload end time and check vm:GetCycle() in Think().
            -- This prevents the "two animations" flash because we complete
            -- reload on the exact frame the animation finishes.
            self._reloadEndTime = ct + AnimTime
            
            -- ==========================================
            -- SOUND TABLE (Scaled)
            -- ==========================================
            local sp = game.SinglePlayer()
            local iftp = IsFirstTimePredicted()
            if (sp and SERVER) or (!sp and CLIENT and iftp) then
                if self.UseReloadTable and not self.UseQCReloadEvents and not self._animSoundActive then
                    -- Scale sounds by speed so they match the visual
                    local scale = 1 / speed
                    
                    for num,tbl in pairs(self.ReloadTable) do
                        if not tbl or not tbl.delay then return end
                        timer.Simple(tbl.delay * scale, function()
                            if not IsValid(self) or not self:GetUHBool("Reloading") or not IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end
                            if tbl.sound then
                                self.Owner:EmitSound( tbl.sound, tbl.level or 75, tbl.pitch or 100, 1, CHAN_USER_BASE )
                            end
                        end)
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

hook.Add("EntityEmitSound", "UHReloadOverride", function(data)
        local ent = data.Entity
        if not IsValid(ent) then return end
        local wep = ent.GetActiveWeapon and ent:GetActiveWeapon()
        if not IsValid(wep) then return end
        
        --[[if string.find(data.SoundName, "weapon") then
                print(data.SoundName)
        end]]
        
        if wep.SoundChanger and wep.SoundChanger[data.SoundName] ~= nil then
                if wep.SoundChanger[data.SoundName] == false then
                        return false
                else
                        data.SoundName = wep.SoundChanger[data.SoundName]
                        return true
                end
        end
end)

-- QC ANIMATION EVENT SUPPORT (5004 = PlaySound)
-- When UseQCReloadEvents == true this will play sounds embedded as event 5004 in the model's QC animations.
-- Otherwise we defer to BaseClass.FireAnimationEvent to preserve original behavior.
function SWEP:FireAnimationEvent(pos, ang, event, options)
        -- If QC reload events disabled, pass to base handling
        if not self.UseQCReloadEvents then
                if BaseClass and BaseClass.FireAnimationEvent then
                        return BaseClass.FireAnimationEvent(self, pos, ang, event, options)
                end
                return true
        end

        -- 5004 = play sound event in QC files
        -- 6004 = AE_CL_PLAYSOUND (client-side play sound)
        if event == 5004 or event == 6004 or event == 15 then
                if options and options ~= "" then
                        if IsValid(self.Owner) then
                                self.Owner:EmitSound(options, 75, 100, 1, CHAN_USER_BASE)
                        else
                                self:EmitSound(options, 75, 100)
                        end
                end

                -- Prevent default handling
                return true
        end

        -- Fallback to base handler for other events
        if BaseClass and BaseClass.FireAnimationEvent then
                return BaseClass.FireAnimationEvent(self, pos, ang, event, options)
        end

        return true
end

if SERVER then return end

local devzoom = Material("vgui/scope_lens")

hook.Add("RenderScene", "UHSniperRenderScene", function(origin, angles, fov)
        local wep = LocalPlayer():GetActiveWeapon()
        if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture then
                if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
                        local size = wep.RT_Size or 512
                        render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
                        
                        local ang = LocalPlayer():EyeAngles()
                        local pos = LocalPlayer():EyePos()
                        
                        render.RenderView({
                                x = 0,
                                y = 0,
                                w = size,
                                h = size,
                                origin = pos,
                                angles = ang,
                                drawviewmodel = false,
                                drawhud = false,
                                dopostprocess = false,
                                fov = wep.ScopeFov or 8
                        })
                        
                        render.PopRenderTarget()
                        
                        wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
                else
                        wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
                end
        end
end)

function SWEP:AdjustMouseSensitivity()
    local hasScope = self.ScopeTexture or self.Use2DScope
    if not hasScope and self.Sensitivity then
        hasScope = true
    end
    if hasScope and self:GetUHBool("Zooming") then
        return self.Sensitivity or 0.2
    end
end

local h_reload = 0
local h_crosshair = 0
local h_use = 0

function SWEP:DrawHUD()
    if not GetConVar("cl_drawhud"):GetBool() or self:GetNWFloat("DeployTime") > CurTime() then return end
    
    -- ==========================================
    -- PART 1: CROSSHAIR & HUD (Original UH + Animation Logic)
    -- ==========================================
    local col = Color(GetConVar("uh_hud_r"):GetInt(), GetConVar("uh_hud_g"):GetInt(), GetConVar("uh_hud_b"):GetInt())
    local pos = {x = ScrW()/2, y = ScrH()/2}
    local movement = LocalPlayer():GetVelocity():Length()/10
    local drawply = LocalPlayer():ShouldDrawLocalPlayer()
    if movement > 80 then movement = 80 end
    
    -- Handle Crosshair Fading
    h_reload = math.Approach(h_reload or 0, self:GetUHBool("Reloading") and 1 or 0, FrameTime()*3)
    h_crosshair = math.Approach(h_crosshair or 0, (self:GetNWInt("FireMode") == 0 or self:GetUHBool("Running") or self:GetUHBool("Reloading") or self:GetUHBool("Zooming")) and 0 or 1, FrameTime()*5)
    
    if drawply then
        pos = self.Owner:GetEyeTrace().HitPos:ToScreen()
    end
    
    -- Draw Crosshair (Only if not using 2D Scope or if 2D Scope is disabled)
    if (h_crosshair > 0 or drawply) and GetConVar("uh_crosshair"):GetBool() and not (self.Use2DScope and self:GetUHBool("Zooming")) then
        draw.RoundedBox(0, pos.x - 25 - movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair)) --Left
        draw.RoundedBox(0, pos.x + 12 + movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair)) --Right
        draw.RoundedBox(0, pos.x - 2, pos.y - 25 - movement, 3, 12, Color(0,0,0,200*h_crosshair)) --Top
        draw.RoundedBox(0, pos.x - 2, pos.y + 12 + movement, 3, 12, Color(0,0,0,200*h_crosshair)) --Bottom
        
        draw.RoundedBox(0, pos.x - 24 - movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair)) --Left
        draw.RoundedBox(0, pos.x + 11 + movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair)) --Right
        draw.RoundedBox(0, pos.x - 1, pos.y - 24 - movement, 1, 12, Color(255,255,255,255*h_crosshair)) --Top
        draw.RoundedBox(0, pos.x - 1, pos.y + 11 + movement, 1, 12, Color(255,255,255,255*h_crosshair)) --Bottom
    end
    
    -- ==========================================
    -- PART 2: ULTRA GUNS 2D SCOPE SYSTEM (FIXED)
    -- Rendered BEFORE the uh_hud check so the scope works
    -- regardless of whether the custom HUD is enabled.
    -- ==========================================
    if self.Use2DScope and self:GetUHBool("Zooming") and not drawply then
        -- Calculate intensity locally using math.Approach to fix visibility
        -- This replaces the self.c_iron dependency
        h_scope = math.Approach(h_scope, 1, FrameTime() * 100)
        
        if h_scope > 0.01 then
            local w, h = ScrW(), ScrH()
            local scopeSize = h * 1.25 -- Size of the scope circle (matches Ultra Guns)
            
            local x = w / 2 - scopeSize / 2
            local y = h / 2 - scopeSize / 2

            surface.SetDrawColor(0, 0, 0, 255 * h_scope)

            -- Draw the 4 black rectangles to mask the screen (Screen Boxing)
            surface.DrawRect(0, 0, x, h)           -- Left Box
            surface.DrawRect(x + scopeSize, 0, w - (x + scopeSize), h) -- Right Box
            surface.DrawRect(x, 0, scopeSize, y)   -- Top Box
            surface.DrawRect(x, h - y, scopeSize, y) -- Bottom Box

            -- Draw the scope lens texture (The reticle/lens)
            surface.SetDrawColor(0, 0, 0, 255)
            surface.SetMaterial(SCOPE_MAT)
            surface.DrawTexturedRect(x, y, scopeSize, scopeSize)
            
            -- Draw Crosshairs over the scope
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawLine(0, h / 2, w, h / 2)     -- Horizontal Line
            surface.DrawLine(w / 2, 0, w / 2, h)     -- Vertical Line
        end
    else
        -- Fade out when not zooming
        h_scope = math.Approach(h_scope, 0, FrameTime() * 10)
    end

    -- ==========================================
    -- PART 1b: CUSTOM HUD (Ammo Counter, etc.)
    -- Below this point, the custom HUD toggle applies.
    -- ==========================================
    if not GetConVar("uh_hud"):GetBool() then return end
    
    -- Draw Ammo Counter
    if drawply then
        local att = self:GetAttachment( self:GetDisplay() )
        if att then pos = att.Pos:ToScreen() end
    else
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            local att = vm:GetAttachment( self:GetDisplay() )
            if att then pos = att.Pos:ToScreen() end
        end
    end
    
    local clip = self:Clip1()
    local ammotype = self.Primary.Ammo
    local ammocount = self.Owner:GetAmmoCount(ammotype)
    
    local cliptext = "Magazine "..(self.Chambering and clip > self.Primary.ClipSize and (clip-1).." + 1" or clip)
    local ammotext = "Reserved "..ammocount
    local typetext = language.GetPhrase(ammotype.."_ammo")
    
    surface.SetFont("UH_AmmoLarge")
    local textsize = surface.GetTextSize(cliptext)
    
    local x = pos.x - textsize
    local y = pos.y
    local pr = math.Clamp(clip / self.Primary.ClipSize, 0, 1)
    
    draw.SimpleText(cliptext, "UH_AmmoLarge", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
    draw.SimpleText(cliptext, "UH_AmmoLarge", x - 5, y, Color(255*(1-pr) + col.r*pr,col.g*pr,col.b*pr), TEXT_ALIGN_LEFT)
    
    y = y + 24
    
    if self:GetNWFloat("ReloadEndTime") > CurTime() or h_reload > 0 then
        local p = math.Clamp(1-(self:GetNWFloat("ReloadEndTime")-CurTime())/self:GetNWFloat("ReloadTime"), 0, 1)
        
        draw.RoundedBox(0, x - 2, y + 1, 1, 14, Color(0,0,0,255*h_reload))
        draw.RoundedBox(0, x - 3, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
        draw.RoundedBox(0, x - 5 + textsize, y + 1, 1, 14, Color(0,0,0,255*h_reload))
        draw.RoundedBox(0, x - 6 + textsize, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
        
        draw.RoundedBox(0, x + 1, y + 3, textsize*p-8, 10, Color(0,0,0,255*h_reload))
        draw.RoundedBox(0, x, y + 2, textsize*p-8, 10, Color(255*(1-p) + col.r*p,col.g*p,col.b*p,255*h_reload))
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
            local p = 1-h_reload
            draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2 + 1, ScrH() * 0.8 + 1, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
            draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2, ScrH() * 0.8, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
            draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2 + 1, ScrH() * 0.8 + 23, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
            draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2, ScrH() * 0.8 + 22, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
        end
    end
end