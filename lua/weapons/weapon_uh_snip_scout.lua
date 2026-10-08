AddCSLuaFile()

SWEP.PrintName 				= "Scout"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Snipers"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_scout_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_scout_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "ar2"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 120
SWEP.IsBolt					= true
SWEP.Sensitivity            = 0.15
SWEP.ZoomFov				= 10
SWEP.ScopeBlur				= true
SWEP.ScopeFov				= 7
SWEP.ScopeTexture			= Material("models/weapons/v_models/sniper_scout/lens")
SWEP.AnimSprint				= true

SWEP.ShellHeat				= 0.5
SWEP.ShellDelay				= 0.6
SWEP.Shell					= "models/weapons/shell_762.mdl"

SWEP.FireModes = {
	{
		name = "Bolt-Action"
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_scout/scout_fire-1.wav")
SWEP.Primary.ClipSize 		= 10
SWEP.Primary.Ammo 			= "ar2" 
SWEP.Primary.DefaultClip 	= 10
SWEP.Primary.MinDamage      = 90
SWEP.Primary.MaxDamage      = 110
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 15
SWEP.Primary.Spread 		= 0.004
SWEP.Primary.Delay 			= 1.5
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -5.6
SWEP.Primary.MaxRecoil		= -6.4

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.954, -6.9, 1.376)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SoundChanger = {
	["weapons/scout/scout_clipout.wav"] = "weapons/uh_scout/scout_clipout.wav",
	["weapons/scout/scout_clipin.wav"] = "weapons/uh_scout/scout_clipin.wav",
	["weapons/scout/scout_bolt.wav"] = "weapons/uh_scout/scout_bolt.wav"
}

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload"] = "scout_reload",
	["reload_empty"] = "scout_reload",
}

if SERVER or CLIENT then
    sound.Add({
        name    = "weapons/uh_scout/scout_clipout.wav",
        channel = CHAN_WEAPON,
        volume  = 1,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_scout/scout_clipout.wav"
    })

    sound.Add({
        name    = "weapons/uh_scout/scout_clipin.wav",
        channel = CHAN_WEAPON,
        volume  = 1,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_scout/scout_clipin.wav"
    })

    sound.Add({
        name    = "weapons/uh_scout/scout_bolt.wav",
        channel = CHAN_WEAPON,
        volume  = 1,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_scout/scout_bolt.wav"
    })
end

SWEP.ReloadTable = {
    { delay = 0.45, sound = "weapons/uh_scout/scout_clipout.wav" },  // hand grabs mag
    { delay = 1.65, sound = "weapons/uh_scout/scout_clipin.wav"  },  // mag seats
    { delay = 3.38, sound = "weapons/uh_scout/scout_bolt.wav"    }   // bolt just before end
}

function SWEP:PostShoot()
	if self:GetUHBool("Zooming") then
		self:SetUHBool("Zooming", false)
	end
    -- timing from scout view-model: bolt happens ~ 0.55 s after shot
    timer.Simple(0.55, function()
        if not IsValid(self) or not IsValid(self.Owner) then return end
        if self.Owner:GetActiveWeapon() ~= self then return end
        self.Owner:EmitSound("weapons/uh_scout/scout_bolt.wav", 75, 100, 0.7, CHAN_WEAPON)
    end)
end

function SWEP:GetShellDirection()
	if self:Clip1() <= 0 and self:GetUHBool("Reloading") then
		return Angle(30,-35,0)
	else
		return Angle(30,-80,0)
	end
end

function SWEP:PreReload()
	if SERVER and self:Clip1() <= 0 then
		self:CreateShell( 3.8, 0 )
	end
end

function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end
	local vm = self.Owner and self.Owner:GetViewModel()
	if !self:GetUHBool("Running") and (not IsValid(vm) or vm:GetCycle() >= 1) then
	
	local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end

    local vel = self.Owner:GetVelocity():LengthSqr()
    local sprinting = self.Owner:KeyDown(IN_SPEED)
        and vel > self.Owner:GetWalkSpeed() ^ 2

    if sprinting then
        -- ENTER RUNNING
        if not self:GetUHBool("Running") then
            -- ❗ ONLY play lowering anim if NOT reloading
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE)
                self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
            end
        end

        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
    else
        -- EXIT RUNNING
        if self:GetUHBool("Running") then
            -- ❗ Same rule applies here
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)
                self:SendWeaponAnim(ACT_VM_LOWERED_TO_IDLE)
            end
        end

        self:SetUHBool("Running", false)
		end
	end
end

function SWEP:PostReload()
    if IsValid(self.Owner)
    and self.Owner:KeyDown(IN_SPEED) then
        timer.Simple(0, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            self:SetUHBool("Running", true)

            self:SendWeaponAnim(ACT_VM_IDLE)
            self:SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)
        end)
    end
end