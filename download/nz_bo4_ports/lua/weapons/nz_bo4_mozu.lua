AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_bo3_base_gun"

SWEP.PrintName = "Mozu"
SWEP.Category = "Black Ops 4: UH"
SWEP.SubCategory = ""

SWEP.Slot = 2 -- The slot the weapon will appear in when switching weapons, add 1 to get the actual slot (e.g. a value of 1 translates to weapon slot 2, the pistol slots)

SWEP.Spawnable = true -- Set this to true to make your weapon appear in the spawnmenu, set to false to hide the template

-- Appearance

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel          = "models/weapons/bo4/c_bo4_mozu.mdl"
SWEP.WorldModel         = "models/weapons/bo4/w_bo4_mozu.mdl"

SWEP.LoweredPos = Vector(1.18, -1.2, -1.6476)
SWEP.LoweredAng = Vector(-13.131, 33.537, -29.906)

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.HoldType = "revolver"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 5

SWEP.FireModes = {
        {
                name = "Semi-Auto",
                equip = function(ply, wep)
                        wep.Primary.Automatic = false
                end,
                holster = function(ply, wep)
                        wep.Primary.Automatic = true
                end
        }
}

SWEP.Primary.Sound          = Sound("weapons/bo4/mozu/wpn_pistol_revolver.wav")
SWEP.Primary.ShellSound     = Sound("Weapon_BLACKOPS3_SPARTAN.Shell_In")
SWEP.Primary.ClipSize       = 6
SWEP.Primary.Ammo           = "357"
SWEP.Primary.DefaultClip    = 18
SWEP.Primary.MinDamage      = 400
SWEP.Primary.MaxDamage      = 400
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.03
SWEP.Primary.Delay          = 60 / 480
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.5
SWEP.Primary.ReloadTime     = 0.4
SWEP.TwoHanded                          = true
SWEP.ReloadSpeed = 1
SWEP.Chambering                         = true
SWEP.Shotgun                            = true

SWEP.AnimatedSprint                     = false

-- Custom configurators

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_ak74"
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

SWEP.IronSightsPos = Vector(-5.66, -2.68, 1.99)
SWEP.IronSightsAng = Angle(0, 0, 0)
SWEP.SwayPosition = 2.0

SWEP.AlternativePos = Vector(0, 0, 0) -- Shifts gun right, back, and down
SWEP.AlternativeAng = Angle(0, 0, 0)   -- Tilts it

SWEP.Animations = {
        ["shoot"] = "fire",
        ["start_reload"] = "ACT_SHOTGUN_RELOAD_START",
        ["reload_loop"] = "ACT_VM_RELOAD",
        ["after_reload"] = "ACT_SHOTGUN_RELOAD_FINISH",
        ["iron_fire"] = "Fire_Iron",
        ["idle"] = "idle",
        ["deploy"] = "draw",
        ["melee"] = "draw",
        ["inspect"] = "fidget",
        ["mantle"] = "draw",
        ["sprint_idle"] = "Sprint_",
        ["sprint_in"] = "Idle_to_Sprint",
        ["sprint_out"] = "Sprint_to_Idle",
}

SWEP.AnimSounds = {
}

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

-- ============================================================
-- RELOAD SHOTGUN (fully self-contained, timer-based)
-- ============================================================
-- The Mozu is a revolver that uses shotgun-style reloading
-- (one shell at a time via speedloader). The BO3 base shotty's
-- ReloadShotgun uses vm:GetCycle() >= 1 which doesn't work with
-- this model, so we use a timer-based approach instead.
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

        local vm = self.Owner:GetViewModel()
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8

        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur

        self._mozu_nextShell = nil
        self.reloaddelay = nil

        self:PostReload()
        return
    end

    -- ==========================================
    -- TIMER-BASED SHELL INSERTION
    -- ==========================================
    if self._mozu_nextShell and ct >= self._mozu_nextShell then
        local shellInterval = self.Primary.ReloadTime or 0.4

        -- Schedule the next shell insertion
        self._mozu_nextShell = ct + shellInterval

        -- Play the per-shell reload animation
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)

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

-- ============================================================
-- RELOAD (fully self-contained — does NOT call BaseClass.Reload)
-- ============================================================
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

    -- Get the duration of the start_reload animation
    local vm = self.Owner:GetViewModel()
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5

    -- Set up our own timer for shell insertion
    -- First shell inserts RIGHT WHEN start_reload finishes (no extra gap).
    local shellInterval = self.Primary.ReloadTime or 0.4
    self._mozu_nextShell = ct + startDur

    -- Also set reloaddelay for compatibility with base class code
    self.reloaddelay = self._mozu_nextShell

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
        self:HandleInspect()
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

if CLIENT then
        local WorldModel = ClientsideModel(SWEP.WorldModel)
        WorldModel:SetSkin(1)
        WorldModel:SetNoDraw(true)

        function SWEP:DrawWorldModel()
                local _Owner = self:GetOwner()
                if IsValid(_Owner) then
                        local offsetVec = Vector(3.5, -1, -1)
                        local offsetAng = Angle(0, 0, 180)
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
