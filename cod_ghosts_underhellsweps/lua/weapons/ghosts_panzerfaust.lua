AddCSLuaFile()

local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Launchers"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Type = "Rocket Launcher"
SWEP.Author = "Wavy"
SWEP.Slot = 2
SWEP.PrintName = "Panzerfaust-3"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/ghosts/c_panzerfaust.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/wavy_ports/ghosts/w_panzerfaust.mdl"
SWEP.WorldModelOffset = Vector(14.0, 1.0, -5.5)
SWEP.WorldModelAngle = Angle(180.0, 0.0, -9.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "rpg"
SWEP.MuzzleAttachment = "1"



--[Gun Related]--
SWEP.Primary.Sound = "TFA_GHOSTS.PANZERFAUST.FIRE"
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.300000  -- 200 RPM
SWEP.Primary.MinDamage = 1000
SWEP.Primary.MaxDamage = 1000
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.FiresUnderwater = true
--SWEP.Primary.Projectile = "nz_wpn_missile" --Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 --Entity to shoot's velocity
SWEP.Primary.ProjectileModel = "models/weapons/dod/pzsk_rocket.mdl" --Entity to shoot's velocity

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = ""
SWEP.FireModeName = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.2 --0.33
//SWEP.LowAmmoSound = nil
//SWEP.LastAmmoSound = nil

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		= .001	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.KickUp				= 0.5	-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.5		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)

--[Iron Sights]--
SWEP.ZoomFov = 15
SWEP.IronSightsPos = Vector(-1, -5, 1.5)
SWEP.IronSightsAng = Angle(3.6, -24.9, 37)
SWEP.IronSightTime = 0.5

--[Shells]--
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = false
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_silenced"

--[Misc]--
--SWEP.AmmoTypeStrings = {buckshot = ".45 ACP"}
SWEP.SafetyPos = Vector(0, -2, 0)
SWEP.SafetyAng = Vector(-19, 21, -21)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3

--[NZombies]--
SWEP.NZPaPName = "Raketenwerfer-115"
SWEP.Primary.MaxAmmo = 20
function SWEP:NZMaxAmmo()

	local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Automatic = true
self.Primary.ClipSize = 10
self.Primary.MaxAmmo = 50
self.MuzzleFlashEffect = "muz_pap"
self.MoveSpeed = 1 
self.IronSightsMoveSpeed = 0.5
self.Primary.Damage	= 2000

return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
        vm:SetSubMaterial(0, self.nzPaPCamo)
    else
        vm:SetSubMaterial(0, nil)
    end
end

--[Tables]--


SWEP.SequenceLengthOverride = {
}



SWEP.EventTable = {
[ACT_VM_RELOAD] = {
{ ["time"] = 20 / 35, ["type"] = "sound", ["value"] = Sound("TFA_GHOSTS.PANZERFAUST.RELOAD") },
},
}

SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["deploy"] = "draw",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

--[Shit]--

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PrimaryAttack(...)
    --[[if self.Ispackapunched then -- comment this out if you don't want it to go away on pap!
        self._pendingShot = false
        self._weForcedADS = false
        return BaseClass.PrimaryAttack(self, ...)
    end]]
    if self._chADS or 0 >= 0.95 then
        return BaseClass.PrimaryAttack(self, ...)
    end
    -- pup will only force ur ads if you are even able to shoot
    local hasAmmo = self:Clip1() > 0 or self:GetStatL("Primary.ClipSize") <= 0
    if not hasAmmo then return end
    self._pendingShot = true
    self._weForcedADS = true
end

function SWEP:Think2(...)
    local ply = self:GetOwner()

    -- pup notices ur not ads'd, its gonna change that :3
    if self._pendingShot then
        local stat = self:GetStatus()
            self:SetIronSightsRaw(true)
        end
        if self._chADS or 0 >= 0.95 then
            self._pendingShot = false
            BaseClass.PrimaryAttack(self)
        end
    end

    -- pups the one who forced u to ads so its gonna keep u ads'd til it sees any reason not to
    if self._weForcedADS and not self._pendingShot then
        local hasAmmo = self:Clip1() > 0 or self:GetStatL("Primary.ClipSize") <= 0
        local holdingAttack = IsValid(ply) and self:KeyDown(IN_ATTACK)
        if hasAmmo and holdingAttack then
            local stat = self:GetStatus()
                self:SetIronSightsRaw(true)
            end
        else
            -- reasons not to:
            self._weForcedADS = false
            self._unADSAt = CurTime() + 0.3
        end
    end

    -- pup pulls u out of ur ads >:3
    if self._unADSAt then
        if CurTime() >= self._unADSAt then
            local stat = self:GetStatus()
                self._unADSAt = nil
                self:SetIronSightsRaw(false)
            end
        else
            -- timers still going, wait just a moment...
            self:SetIronSightsRaw(true)
        end
    end

    return BaseClass.Think2(self, ...)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local snd1 = self:GetStatL("Primary.SoundLyr1")
	if snd1 and ifp and self.Ispackapunched then
		self:EmitGunfireSound(snd1)
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

SWEP.TwoHanded = true
SWEP.ReloadSpeed = 1
SWEP.Chambering = false
SWEP.SwayPosition = 2.0
SWEP.IronSightsDipPos = Vector(0, 0, 0)
SWEP.IronSightsDipAng = Angle(0, 0, 0)
SWEP.IronSightsDipScale = 0
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)
SWEP.AlternativePos = Vector(0, 0, 0)
SWEP.AlternativeAng = Angle(0, 0, 0)
