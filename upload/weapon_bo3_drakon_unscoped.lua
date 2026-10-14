AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_bo3_base_gun"

SWEP.PrintName = "Drakon (Reddot)"
SWEP.Category = "Black Ops III"
SWEP.SubCategory = ""

SWEP.Slot = 3 -- The slot the weapon will appear in when switching weapons, add 1 to get the actual slot (e.g. a value of 1 translates to weapon slot 2, the pistol slots)

SWEP.Spawnable = true -- Set this to true to make your weapon appear in the spawnmenu, set to false to hide the template

-- Appearance

SWEP.UseHands = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ViewModel		= "models/weapons/drakon/v_sr_drakon_reddot.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/drakon/w_sr_drakon.mdl"
SWEP.LoweredPos = Vector(2.95, -3.057, -4.119)
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

SWEP.Primary.Sound          = Sound("CW_BLACKOPS3_DRAKON_FIRE")
SWEP.Primary.ClipSize       = 20
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.DefaultClip    = 120
SWEP.Primary.MinDamage      = 30
SWEP.Primary.MaxDamage      = 75
SWEP.Primary.Automatic      = true
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 6
SWEP.Primary.Spread         = 0.001
SWEP.Primary.Delay          = 60 / 240
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -1.0
SWEP.Primary.MaxRecoil      = -1.5
SWEP.TwoHanded				= true
SWEP.ReloadSpeed = 1
SWEP.Chambering				= true
SWEP.Use2DScope				= false
SWEP.AnimatedSprint			= true

-- Custom configurators

SWEP.MuzzleFlashType = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_SR25"
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

SWEP.IronSightsPos = Vector(-9.24, -14.8513, -0.09)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SwayPosition = 2.0

SWEP.AlternativePos = Vector(0, 0, 0) -- Shifts gun right, back, and down
SWEP.AlternativeAng = Angle(0, 0, 0)   -- Tilts it

SWEP.Animations = {
	["deploy"] = "ACT_VM_DRAW_QUICK",
	["first_draw"] = "ACT_VM_DRAW_FIRST",
	["holster"] = "ACT_VM_HOLSTER",
	["shoot"] = "ACT_VM_PRIMARYATTACK",
	["iron_fire"] = "ACT_VM_PRIMARYATTACK",
	["reload_empty"] = "ACT_VM_RELOAD_EMPTY",
	["reload"] = "ACT_VM_RELOAD",
	["idle"] = "ACT_VM_IDLE",
	["melee"] = "ACT_VM_THROW",
	["mantle"] = "ACT_VM_MANTLE",
	["sprint_idle"] = "ACT_VM_SPRINT_LOOP",
	["sprint_in"] = "ACT_VM_SPRINT_START",
	["sprint_out"] = "ACT_VM_SPRINT_END",
}

SWEP.AnimSounds = {
    ["reload"] = {
        {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
        {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
    },
    ["reload_empty"] = {
        {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
        {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
        {time = 2.65, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
        {time = 2.80, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
    },
}

local RedDotMaterial

if CLIENT then
    RedDotMaterial = CreateMaterial("UH_RedDotReticle", "UnlitGeneric", {
        ["$basetexture"] = "blackops3/reticles/reflex_4",
        ["$vertexcolor"] = 1,
        ["$vertexalpha"] = 1,
        ["$additive"] = 1,
    })
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

function SWEP:DrawHUD()
    -- Draw base HUD (crosshair, ammo, etc.) first
    -- Skip base DrawHUD when zoomed to hide the crosshair behind the dot
    if not self:GetUHBool("Zooming") then
        self.BaseClass.DrawHUD(self)
        return
    end

    -- Still call base for ammo display etc., but crosshair is auto-hidden
    -- by h_crosshair going to 0 when Zooming (handled in base DrawHUD)
    self.BaseClass.DrawHUD(self)

    local delay = 0.1
    local fadeTime = 0.1
    local dotSize = 128

    local aimTime = self._zoomStartTime or 0
    if CurTime() < (aimTime + delay) then return end

    local alpha = 255
    if CurTime() < (aimTime + delay + fadeTime) then
        alpha = math.Clamp((CurTime() - aimTime - delay) / fadeTime * 255, 0, 255)
    end

    surface.SetMaterial(RedDotMaterial)
    surface.SetDrawColor(255, 0, 0, alpha)
    surface.DrawTexturedRect(
        (ScrW() / 2) - (dotSize / 2),
        (ScrH() / 2) - (dotSize / 2),
        dotSize,
        dotSize
    )
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)
	WorldModel:SetSkin(1)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()
		if IsValid(_Owner) then
			local offsetVec = Vector(0, -2, 0)
			local offsetAng = Angle(175, 185, 0)
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