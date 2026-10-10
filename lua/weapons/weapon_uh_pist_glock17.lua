AddCSLuaFile()

SWEP.PrintName        = "Glock-17"
SWEP.Author           = ""
SWEP.Contact          = ""
SWEP.Purpose          = ""
SWEP.Instructions     = ""
SWEP.Category         = "UnderHell"
SWEP.SubCategory	  = "Pistols"
SWEP.UseHands         = false
SWEP.Base             = "weapon_custom_uh_base_gun"

SWEP.Spawnable        = true
SWEP.AdminSpawnable   = false

SWEP.ViewModelFOV     = 64
SWEP.ViewModel        = "models/weapons/v_pist_glock17_pg.mdl"
SWEP.WorldModel       = "models/weapons/w_pist_glock17_pg.mdl"

SWEP.AutoSwitchTo     = true
SWEP.AutoSwitchFrom   = true

SWEP.Slot             = 1
SWEP.SlotPos          = 3

SWEP.HoldType         = "pistol"
SWEP.PassiveAnim      = "passive"
SWEP.FiresUnderwater  = false
SWEP.Weight           = 25
SWEP.DrawCrosshair    = false
SWEP.DrawAmmo         = false
SWEP.SmokeWidth       = 50
SWEP.Chambering       = true
SWEP.AnimSprint		  = true

SWEP.FireModes = {
    { name = "Semi-Auto" }
}

SWEP.Primary.Sound      = Sound("weapons/uh_glock/glock_fire.wav")
SWEP.Primary.ClipSize   = 17
SWEP.Primary.Ammo       = "pistol"
SWEP.Primary.DefaultClip= 18
SWEP.Primary.MinDamage  = 19
SWEP.Primary.MaxDamage  = 22
SWEP.Primary.Automatic  = false
SWEP.Primary.TakeAmmo   = 1
SWEP.Primary.Force      = 7
SWEP.Primary.Spread     = 0.1
SWEP.Primary.Delay      = 0.12
SWEP.Primary.NumberofShots = 1
SWEP.Primary.MinRecoil  = -1
SWEP.Primary.MaxRecoil  = -1.2

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo     = "none"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.IronSightsPos = Vector(-4.627, -6.361, 1.98)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.SwayPosition  = 2.6

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

if SERVER or CLIENT then

sound.Add({ 
	name = "Glock-17Clipout",  
	channel = CHAN_WEAPON, 
	volume = 0.7, 
	level = SNDLVL_NORM, 
	pitch = 100, 
	sound = "weapons/uh_glock/glock_clipout.wav"  
	})
sound.Add({ 
	name = "Glock-17ClipIn",      
	channel = CHAN_WEAPON, 
	volume = 0.7, 
	level = SNDLVL_NORM, 
	pitch = 100, 
	sound = "weapons/uh_glock/glock_clipin.wav"      
	})
sound.Add({ 
	name = "Glock-17Slideback",       
	channel = CHAN_WEAPON, 
	volume = 0.7, 
	level = SNDLVL_NORM, 
	pitch = 100, 
	sound = "weapons/uh_glock/glock_slideback.wav"       
	})
sound.Add({ 
	name = "Glock-17Slideforward", 
	channel = CHAN_WEAPON, 
	volume = 0.7, 
	level = SNDLVL_NORM, 
	pitch = 100, 
	sound = "weapons/uh_glock/glock_slideforward.wav" 
	})
end

SWEP.ReloadTable = {
    { delay = 0.00, sound = "weapons/uh_glock/glock_slideback.wav"  },  // hand leaves gun
    { delay = 0.34, sound = "weapons/uh_glock/glock_clipout.wav"      },  // mag drops
    { delay = 0.99, sound = "weapons/uh_glock/glock_clipin.wav"       },  // mag seats
    { delay = 1.37, sound = "weapons/uh_glock/glock_slideforward.wav" }   // slide release
}

SWEP.SoundChanger = {
    ["weapons/uh_glock/glock_slideback.wav"] = "weapons/uh_glock/glock_slideback.wav",
    ["weapons/uh_glock/glock_clipout.wav"]     = "weapons/uh_glock/glock_clipout.wav",
    ["weapons/uh_glock/glock_clipin.wav"]      = "weapons/uh_glock/glock_clipin.wav",
    ["weapons/uh_glock/glock_slideforward.wav"]= "weapons/uh_glock/glock_slideforward.wav"
}

function SWEP:HandleRunning(ct)
    if not IsValid(self.Owner) then return end
    if not GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end

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