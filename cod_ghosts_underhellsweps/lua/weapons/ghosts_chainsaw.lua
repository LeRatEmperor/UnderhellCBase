AddCSLuaFile()

local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Light Machine Guns"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Manufacturer = "Auto-Ordnance Company"
SWEP.Author = "Wavy"
SWEP.Slot = 2
SWEP.PrintName = "Chain SAW"
SWEP.DrawCrosshair = true

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/ghosts/c_chain_saw.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/wavy_ports/ghosts/w_chain_saw.mdl"
SWEP.WorldModelOffset = Vector(23.0, 1.0, -5.5)
SWEP.WorldModelAngle = Angle(0.0, 180.0, 190.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "crossbow"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(-2.5, 0, 0)
SWEP.VMAng = Angle(0, 0, -5)
SWEP.VMPos_Additive = false



--[Gun Related]--
SWEP.Primary.Sound = "TFA_GHOSTS.CHAINSAW.FIRE"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.070012  -- 857 RPM
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.MinDamage = 100
SWEP.Primary.MaxDamage = 100
SWEP.Primary.NumberofShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 80
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.35
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = ""
SWEP.FireModeName = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = true
SWEP.LowAmmoSoundThreshold = 0.2 --0.33
//SWEP.LowAmmoSound = nil
//SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.DisplayFalloff = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 20, damage = 1.0},
		{range = 40, damage = 0.5},
	}
}

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		  = .03
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.8

SWEP.Primary.KickHorizontal		= 0.05
SWEP.Primary.MinRecoil = -0.1
SWEP.Primary.MaxRecoil = -0.25SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6


--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.ZoomFov = 10
SWEP.IronSightsPos = Vector(-4, -1.5, 0.60)
SWEP.IronSightsAng = Angle(0.1, 0.075, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "RifleShellEject"
--SWEP.LuaShellSound = 
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
--SWEP.AmmoTypeStrings = {ar2 = ".45 ACP"}
SWEP.InspectPos = Vector(6, -4.946, 2.2)
SWEP.InspectAng = Vector(10.8, 43.2, 20.399)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed = 0.8
SWEP.SafetyPos = Vector(0, -2, 0)
SWEP.SafetyAng = Vector(-19, 21, -21)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3

--[NZombies]--
SWEP.NZPaPName = "Sergeant Bubba"
SWEP.NZHeadShotMultiplier = 3.5
SWEP.Primary.MaxAmmo = 560
SWEP.Secondary.MaxAmmo 	= 10
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 10
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.Automatic = false
SWEP.Secondary.RPM = 350
SWEP.Secondary.Projectile = "nz_wpn_grenade"
SWEP.Secondary.ProjectileVelocity = 2000
SWEP.Secondary.ProjectileModel = "models/weapons/w_eq_fraggrenade_thrown.mdl"
SWEP.Secondary.Damage = 750
SWEP.Secondary.Sound = "TFA_BO4_OVERKILL.ShootGL"
function SWEP:NZMaxAmmo()

    local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
		self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
		self:SetClip1( self.Primary.ClipSize )

		self:GetOwner():SetAmmo( self.Secondary.MaxAmmo, self:GetSecondaryAmmoType() )
		self:SetClip2( self.Secondary.ClipSize )
    end
end

SWEP.Primary.DamagePAP = 150
SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = self.Primary.DamagePAP
self.Primary.ClipSize = 125
self.Primary.MaxAmmo = 750
self.Primary.IronAccuracy = .005
self.Secondary.MaxAmmo = 20
self.Secondary.Damage = 1500
self.MuzzleFlashEffect = "muz_pap"

return true
end

function SWEP:PreDrawViewModel(vm)
    if self.Ispackapunched then
		vm:SetSubMaterial(0, self.nzPaPCamo)
        vm:SetSubMaterial(1, self.nzPaPCamo)
    else
        vm:SetSubMaterial(0, nil)
    end
end

--[Tables]--


SWEP.SequenceLengthOverride = {
}



SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

SWEP.AnimSounds = {
    ["deploy"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_LARGE.Generic" },
    },
    ["act_vm_draw_deployed"] = {
        { time = 0.0000, sound = "Weapons_Ghosts_LARGE.Generic" },
    },
}

--[Shit]--

DEFINE_BASECLASS( SWEP.Base )

function SWEP:AltAttack( ... )
	if CurTime() > self:GetNextPrimaryFire() and true and self:Ammo2() > 0 then
		self.Owner:ViewPunch(Angle(-3,0,0))
		if IsFirstTimePredicted() then
			self:EmitSound(self.Secondary.Sound)
		end
		self:SendViewModelAnim(ACT_VM_PRIMARYATTACK)
		self:SetNextPrimaryFire(CurTime() +1)
		self:SetClip2( 0 )
		self:TakeSecondaryAmmo( 1 )
		if SERVER then
			local ent = ents.Create(self.Secondary.Projectile)
			local dir
			local ang = self:GetOwner():EyeAngles()
			dir = ang:Forward()
			ent:SetPos(self:GetOwner():GetShootPos())
			ent:SetOwner( self:GetOwner() )
			ent:SetAngles(self:GetOwner():EyeAngles())
			ent.damage = self.Secondary.Damage
			ent.mydamage = self.Secondary.Damage

			if self.Secondary.ProjectileModel then
				ent:SetModel(self.Secondary.ProjectileModel)
			end

			ent:Spawn()
			ent:SetVelocity(dir * self.Secondary.ProjectileVelocity)
			local phys = ent:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(dir * self.Secondary.ProjectileVelocity)
			end

			if self.ProjectileModel then
				ent:SetModel(self.Secondary.ProjectileModel)
			end

			ent:SetOwner(self:GetOwner())
		end
	end
	return
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
