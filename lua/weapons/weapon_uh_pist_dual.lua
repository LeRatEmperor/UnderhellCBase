AddCSLuaFile()

SWEP.PrintName 				= "Dual Berettas"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "UnderHell"
SWEP.SubCategory			= "Pistols"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable 				= true
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 70
SWEP.ViewModel				= "models/weapons/v_uh_dual_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_uh_dual_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 	= 1
SWEP.SlotPos 				= 2

SWEP.HoldType 				= "duel"
SWEP.PassiveAnim			= "normal"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 25
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 50
SWEP.Chambering				= false
SWEP.TwoHanded				= true

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	}
}

SWEP.Primary.Sound          = Sound("weapons/uh_dual/dual_fire.wav")
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Ammo 			= "pistol"
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.MinDamage      = 17
SWEP.Primary.MaxDamage		= 19
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 8
SWEP.Primary.Spread 		= 0.08
SWEP.Primary.Delay 			= 0.07
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.8
SWEP.Primary.MaxRecoil		= -1.1

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.Ammo 		= "none"
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(0, 1.321, 1.879)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.6

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
}

SWEP.ReloadTable = {
    { delay = 0.0, sound = "weapons/uh_dual/dual_reloadstart.wav"   },
    { delay = 0.33, sound = "weapons/uh_dual/dual_clipout.wav"       },
    { delay = 1.33, sound = "weapons/uh_dual/dual_rightclipin.wav"  },
    { delay = 2.66, sound = "weapons/uh_dual/dual_leftclipin.wav"    },
    { delay = 3.84, sound = "weapons/uh_dual/dual_sliderelease.wav" }
}
	
if SERVER or CLIENT then
    sound.Add({
        name    = "weapons/uh_dual/dual_reloadstart.wav",
        channel = CHAN_WEAPON,
        volume  = 0.7,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_dual/dual_reloadstart.wav"
    })

    sound.Add({
        name    = "weapons/uh_dual/dual_clipout.wav",
        channel = CHAN_WEAPON,
        volume  = 0.7,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_dual/dual_clipout.wav"
    })

    sound.Add({
        name    = "weapons/uh_dual/dual_rightclipin.wav",
        channel = CHAN_WEAPON,
        volume  = 0.7,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_dual/dual_rightclipin.wav"
    })

    sound.Add({
        name    = "weapons/uh_dual/dual_leftclipin.wav",
        channel = CHAN_WEAPON,
        volume  = 0.7,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_dual/dual_leftclipin.wav"
    })

    sound.Add({
        name    = "weapons/uh_dual/dual_sliderelease.wav",
        channel = CHAN_WEAPON,
        volume  = 0.7,
        level   = SNDLVL_NORM,
        pitch   = 100,
        sound   = "weapons/uh_dual/dual_sliderelease.wav"
    })
end

SWEP.LeftBones = {
	["m9-1"] = Angle(-50,50,50),
	["magazine-1"] = Angle(-50,50,50),
	["slide-1"] = Angle(-50,50,50),
	["trigger-1"] = Angle(-50,50,50),
}

SWEP.Inspection = {
	{
		pos = Vector(0, 0, 3),
		ang = Angle(-20, 0, 0)
	},
	{
		pos = Vector(0, -10.367, -6.02),
		ang = Angle(70, 0, 0)
	},
}

SWEP.SoundChanger = {
	["weapons/elite/elite_deploy.wav"] = "weapons/uh_dual/dual_deploy.wav",
	["weapons/elite/elite_reloadstart.wav"] = "weapons/uh_dual/dual_reloadstart.wav",
	["weapons/elite/elite_clipout.wav"] = "weapons/uh_dual/dual_clipout.wav",
	["weapons/elite/elite_rightclipin.wav"] = "weapons/uh_dual/dual_rightclipin.wav",
	["weapons/elite/elite_leftclipin.wav"] = "weapons/uh_dual/dual_leftclipin.wav",
	["weapons/elite/elite_sliderelease.wav"] = "weapons/uh_dual/dual_sliderelease.wav"
}

function SWEP:ShootAnimation()
	return self:Clip1() % 2 == 0 and ACT_VM_SECONDARYATTACK or ACT_VM_PRIMARYATTACK
end

function SWEP:GetShellDirection()
	return Angle(70,-70,0)
end


function SWEP:GetMuzzle()
	return self:Clip1() % 2 == 0 and 1 or 2
end

function SWEP:GetShellEject()
	return self:Clip1() % 2 == 0 and 3 or 4
end

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