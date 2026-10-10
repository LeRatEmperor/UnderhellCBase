AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_bo3_base_gun"

SWEP.PrintName = "Maddox RFB"
SWEP.Category = "Black Ops 4: UH"
SWEP.SubCategory = ""

SWEP.Slot = 2 -- The slot the weapon will appear in when switching weapons, add 1 to get the actual slot (e.g. a value of 1 translates to weapon slot 2, the pistol slots)

SWEP.Spawnable = true -- Set this to true to make your weapon appear in the spawnmenu, set to false to hide the template

-- Appearance

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.ViewModel          = "models/weapons/wavy_ports/bo4/c_maddox.mdl"
SWEP.WorldModel         = "models/weapons/wavy_ports/bo4/w_maddox.mdl"

SWEP.LoweredPos = Vector(1.18, -1.2, -1.6476)
SWEP.LoweredAng = Vector(-13.131, 33.537, -29.906)

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.HoldType = "ar2"
SWEP.PassiveAnim = "passive"
SWEP.ZoomFov = 20

SWEP.FireModes = {
        {
                name = "Full-Auto",
                equip = function(ply, wep)
                        wep.Primary.Automatic = true
                end,
                holster = function(ply, wep)
                        wep.Primary.Automatic = false
                end
        },
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

SWEP.Primary.Sound          = Sound("TFA_BO4.MADDOX.FIRE")
SWEP.Primary.ClipSize       = 40
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 200
SWEP.Primary.MinDamage      = 75
SWEP.Primary.MaxDamage      = 75
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.028
SWEP.Primary.Delay          = 60 / 722
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.5
SWEP.TwoHanded                          = true
SWEP.ReloadSpeed = 1
SWEP.Chambering                         = false

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

SWEP.IronSightsPos = Vector(-3.33, -3.5, 1)
SWEP.IronSightsAng = Angle(0.1, 0.03, 0)
SWEP.SwayPosition = 2.0

SWEP.AlternativePos = Vector(0, 0, 0) -- Shifts gun right, back, and down
SWEP.AlternativeAng = Angle(0, 0, 0)   -- Tilts it

SWEP.Animations = {
        ["shoot"] = "fire",
        ["reload"] = "reload",
        ["reload_empty"] = "reload_empty",
        ["iron_fire"] = "fire_ads",
        ["idle"] = "idle",
        ["deploy"] = "draw",
        ["melee"] = "draw",
        ["inspect"] = "fidget",
        ["mantle"] = "draw",
        ["sprint_idle"] = "sprint_loop",
        ["sprint_in"] = "sprint_in",
        ["sprint_out"] = "sprint_out",
}

SWEP.AnimSounds = {
    ["deploy"] = {
        {time = 0, sound = "weapon_bo3_cloth.med"},
        {time = 0, sound = "weapon_bo3_gear.rattle"},
    },
    ["reload"] = {
        {time = 12 / 30, sound = "TFA_BO4.MADDOX.OUT"},
        {time = 42 / 30, sound = "TFA_BO4.MADDOX.IN"},
    },
    ["reload_empty"] = {
        {time = 12 / 30, sound = "TFA_BO4.MADDOX.OUT"},
        {time = 47 / 30, sound = "TFA_BO4.MADDOX.IN"},
        {time = 62 / 30, sound = "TFA_BO4.MADDOX.BACK"},
        {time = 67 / 30, sound = "TFA_BO4.MADDOX.FWD"},
    },
    ["inspect"] = {
        {time = 105 / 30, sound = "TFA_BO4.MADDOX.BACK"},
        {time = 127 / 30, sound = "TFA_BO4.MADDOX.FWD"},
    },
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
                        local offsetVec = Vector(4, -1, -0.5)
                        local offsetAng = Angle(190, 0, 180)
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
