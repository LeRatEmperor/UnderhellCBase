AddCSLuaFile()

local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "weapon_custom_uh_base_gun"
SWEP.Category = "COD: Ghosts"
SWEP.SubCategory = "Light Machine Guns"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.AnimatedSprint = true
SWEP.Type = "Light Machine Gun"
SWEP.Author = "Wavy"
SWEP.Slot = 0
SWEP.PrintName = "Minigun"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/ghosts/c_minigun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/wavy_ports/ghosts/w_minigun.mdl"
SWEP.WorldModelOffset = Vector(4.0, 1.0, 0.0)
SWEP.WorldModelAngle = Angle(0.0, 180.0, 180.0)
SWEP.WorldModelScale = 1.0
SWEP.HoldType = "crossbow"
SWEP.MuzzleAttachment = "1"



--[Gun Related]--
SWEP.Primary.Sound = "TFA_GHOSTS.MINIGUN.FIRE"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.050000  -- 1200 RPM
SWEP.Primary.MinDamage = 150
SWEP.Primary.MaxDamage = 150
SWEP.Primary.NumberofShots = 1
SWEP.Primary.ClipSize = 255
SWEP.Primary.DefaultClip = 255
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0 --0.33
SWEP.LowAmmoSound = ""
SWEP.LastAmmoSound = ""

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
		{range = 30, damage = 1.0},
		{range = 45, damage = 0.6},
	}
}

--[Recoil]--




--[Spread Related]--
SWEP.Primary.Spread		  = .03

SWEP.Primary.KickHorizontal		= 0.025
SWEP.Primary.MinRecoil = -0.1
SWEP.Primary.MaxRecoil = -0.1



--[Iron Sights]--

--[Shells]--
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
SWEP.AmmoTypeStrings = {ar2 = "7.62x51mm"}
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.TracerCount = 3

--[NZombies]--
SWEP.NZPaPName = "Death Incinerator"
SWEP.Primary.MaxAmmo = 255
function SWEP:NZMaxAmmo()

	local ammo_type = self.Primary.Ammo or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Primary.DamagePAP = 300
SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = self.Primary.DamagePAP
self.Primary.RPM = 1500
self.Primary.ClipSize = 999
self.Primary.MaxAmmo = 999
self.MuzzleFlashEffect = "muz_pap"

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


--[Animations]--
SWEP.AnimatedSprint = true
SWEP.Animations = {
    ["shoot"] = "fire",
    ["holster"] = "holster",
    ["idle"] = "idle",
    ["sprint_in"]  = "sprint_in",
    ["sprint_out"] = "sprint_out",
    ["sprint_idle"] = "sprint_loop",
}

--[Tables]--
SWEP.SequenceLengthOverride = {
}

SWEP.AnimSounds = {
    ["act_vm_draw_deployed"] = {
        { time = 0.0000, sound = "weapon_bo3_cloth.med" },
        { time = 0.0000, sound = "weapon_bo3_gear.rattle" },
    },
    ["deploy"] = {
        { time = 0.0000, sound = "weapon_bo3_cloth.med" },
        { time = 0.0000, sound = "weapon_bo3_gear.rattle" },
    },
}

--[Shit]--

	["tag_barrel_spin"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "SpinTime")

	self:NetworkVarTFA("Bool", "IsSpinning")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

function SWEP:GetAmmoForceMultiplier()
	return 1
end

function SWEP:CanPrimaryAttack(...)
	local ply = self:GetOwner()
	
	if IsValid(ply) and ply:IsPlayer() then
		if self:GetSpinTime() < 1 then
			return false
		end
	end

	return BaseClass.CanPrimaryAttack(self,...)
end

function SWEP:CanSpinUp()
    stat = self:GetStatus()

		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:IsSafety() then
		return false
	end

    return true
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()

	if CLIENT and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			self.SpinSpeed = math.Approach(self.SpinSpeed, 20, FrameTime()*60)
		end
		self:DoSpin()
	end

	if CLIENT and sp then
        return BaseClass.Think2(self,...)
	end

	if IsValid(ply) and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			if not self:GetIsSpinning() then
				if IsFirstTimePredicted() then self:EmitSoundNet("TFA_GHOSTS.MINIGUN.START") end
			end

			self:SetIsSpinning(true) 
		else
			if l_CT() > self:GetNextPrimaryFire() or self.Primary.Automatic then
				if self:GetIsSpinning() then
					if IsFirstTimePredicted() then self:EmitSoundNet("TFA_GHOSTS.MINIGUN.STOP") end
				end

				self:SetIsSpinning(false)
			end
		end

		if self:GetIsSpinning() then
			self:SetSpinTime(self:GetSpinTime() + (FrameTime() / 0.4))

			if self:GetSpinTime() >= 1 then
				--self:EmitSoundNet("TFA_BO3_M134.SpinLoop")

				if not (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) then
					self:SetIsSpinning(false)
				end
			end 
		else
			self:SetSpinTime(0)
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:DoSpin()
	if not CLIENT then return end
	if not sp and not IsFirstTimePredicted() then return end

	self.SpinAng = self.SpinAng or 0
	self.SpinSpeed = self.SpinSpeed or 10

	if self.SpinAng > 7200 then
		self.SpinAng = -7200
	end

	self.SpinAng = self.SpinAng - self.SpinSpeed

	if self.SpinSpeed > 0 then
		self.SpinSpeed = self.SpinSpeed * 0.98
	elseif self.SpinSpeed < 0 then
		self.SpinSpeed = 0
	end

	self.ViewModelBoneMods["tag_barrel_spin"].angle = Angle(0, 0, -self.SpinAng)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_GHOSTS.MINIGUN.FIRE")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_GHOSTS.MINIGUN.FIRE")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSoundNet("TFA_GHOSTS.MINIGUN.FIRE")
	return BaseClass.Holster(self,...)
end

local crosshair_minigun = Material("vgui/overlay/reticle_minigun.png", "smooth unlitgeneric")
local CMIX_MULT = 1
local c1t = {}
local c2t = {}

local function ColorMix(c1, c2, fac, t)
	c1 = c1 or color_white
	c2 = c2 or color_white
	c1t.r = c1.r
	c1t.g = c1.g
	c1t.b = c1.b
	c1t.a = c1.a
	c2t.r = c2.r
	c2t.g = c2.g
	c2t.b = c2.b
	c2t.a = c2.a

	for k, v in pairs(c1t) do
		if t == CMIX_MULT then
			c1t[k] = Lerp(fac, v, (c1t[k] / 255 * c2t[k] / 255) * 255)
		else
			c1t[k] = Lerp(fac, v, c2t[k])
		end
	end

	return Color(c1t.r, c1t.g, c1t.b, c1t.a)
end

local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

function SWEP:DrawHUDBackground() //hehe funny copy paste entire function to change 1 thing
	local self2 = self:GetTable()
	local x, y

	local ply = LocalPlayer()
	if not ply:IsValid() or self:GetOwner() ~= ply then return false end

	if not ply.interpposx then
		ply.interpposx = ScrW() / 2
	end

	if not ply.interpposy then
		ply.interpposy = ScrH() / 2
	end

	local tr = {}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 0x7FFF
	tr.filter = ply
	tr.mask = MASK_NPCSOLID
	local traceres = util.TraceLine(tr)
	local targent = traceres.Entity

	if self:GetOwner():ShouldDrawLocalPlayer() and not ply:GetNW2Bool("ThirtOTS", false) then
		local coords = traceres.HitPos:ToScreen()
		coords.x = math.Clamp(coords.x, 0, ScrW())
		coords.y = math.Clamp(coords.y, 0, ScrH())
		ply.interpposx = math.Approach(ply.interpposx, coords.x, (ply.interpposx - coords.x) * RealFrameTime() * 7.5)
		ply.interpposy = math.Approach(ply.interpposy, coords.y, (ply.interpposy - coords.y) * RealFrameTime() * 7.5)
		x, y = ply.interpposx, ply.interpposy
		-- Center of screen
	elseif sv_tfa_fixed_crosshair:GetBool() then
		x, y = ScrW() / 2, ScrH() / 2
	else
		tr.endpos = tr.start + self:GetAimAngle():Forward() * 0x7FFF
		local pos = util.TraceLine(tr).HitPos:ToScreen()
		x, y = pos.x, pos.y
	end

	local stat = self2.GetStatus(self)
	self2.clrelp = self2.clrelp or 0
	self2.clrelp = math.Approach(
		self2.clrelp,

	local crossa = 255 * math.pow(math.min(1 - (((self2.IronSightsProgressUnpredicted2 or self._chADS or 0) and
		not self2.GetStatL(self, "DrawCrosshairIronSights")) and (self2.IronSightsProgressUnpredicted2 or self._chADS or 0) or 0),
		1 - self:GetSprintProgress(),
		1 - self:GetInspectingProgress(),
		self2.clrelp),
	2)

	teamcol = self2.GetTeamColor(self, targent)
	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa
	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_minigun)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
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
