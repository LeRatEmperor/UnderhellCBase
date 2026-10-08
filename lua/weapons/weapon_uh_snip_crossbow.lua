AddCSLuaFile()

SWEP.PrintName              = "Crossbow"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.Category               = "UnderHell"
SWEP.SubCategory			= "Snipers"
SWEP.UseHands               = false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable              = true
SWEP.AdminSpawnable         = false

SWEP.ViewModelFOV           = 64
SWEP.ViewModel              = "models/weapons/v_crossbow_pg.mdl"
SWEP.WorldModel             = "models/weapons/w_crossbow_pg.mdl"

SWEP.AutoSwitchTo           = true         
SWEP.AutoSwitchFrom         = true

SWEP.Slot                   = 4
SWEP.SlotPos                = 0

SWEP.HoldType               = "crossbow"
SWEP.FiresUnderwater        = false
SWEP.Weight                 = 45
SWEP.DrawCrosshair          = false
SWEP.DrawAmmo               = false
SWEP.SmokeWidth             = 120
SWEP.Chambering             = false
SWEP.Sensitivity            = 0.15
SWEP.ZoomFov                = 10
SWEP.ScopeBlur              = true
SWEP.ScopeFov               = 8
SWEP.ScopeTexture           = Material("models/weapons/v_models/pg_crossbow/lens")
SWEP.AnimSprint				= true

SWEP.ShellHeat              = 0.5
SWEP.ShellDelay             = 0.6
SWEP.Shell                  = "models/weapons/shell_762.mdl"

SWEP.FireModes = {
    { name = "Bolt-Action" }
}

SWEP.Primary.Sound          = Sound("weapons/uh_xbow/fire.wav")
SWEP.Primary.ClipSize       = 1
SWEP.Primary.Ammo           = "UH_Arrow" 
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.MinDamage      = 90
SWEP.Primary.MaxDamage      = 110
SWEP.Primary.Automatic      = false
SWEP.Primary.TakeAmmo       = 1
SWEP.Primary.Force          = 15
SWEP.Primary.Spread         = 0.004
SWEP.Primary.Delay          = 1.5
SWEP.Primary.NumberofShots  = 1
SWEP.Primary.MinRecoil      = -5.6
SWEP.Primary.MaxRecoil      = -6.4
SWEP.TwoHanded				= true

SWEP.Secondary.ClipSize     = -1 
SWEP.Secondary.Ammo         = "none" 
SWEP.Secondary.DefaultClip  = -1     
SWEP.Secondary.Automatic    = false

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos          = Vector(-4.08, -5.7, 1.21)
SWEP.IronSightsAng          = Vector(0, 0, 0)

SWEP.SwayPosition           = 2.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD"
}

-- Ensure sound precaches correctly on Chromium
if SERVER then
    util.PrecacheSound("weapons/crossbow/reload1.wav")
end

sound.Add({
    name = "Weapon_Crossbow.Reload",
    channel = CHAN_WEAPON,
    volume = 0.7,
    level = SNDLVL_NORM,
    pitch = 100,
    sound = "weapons/crossbow/reload1.wav"  -- fixed path (no 'sound/' prefix)
})

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    if SERVER then
        local ent = ents.Create("sent_uh_arrow")
        ent:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 16)
        ent:Spawn()
        ent:Activate()
        ent.Owner = self.Owner
        ent:SetAngles(self.Owner:GetAngles())
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:ApplyForceCenter(self.Owner:GetAimVector() * 15000)
        end
    end

    local SP = game.SinglePlayer()
    local IFTP = IsFirstTimePredicted()

    if (SP and SERVER) or (not SP and CLIENT and IFTP) then
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(math.random(self.Primary.MinRecoil, self.Primary.MaxRecoil) / 2, 0, 0))
    end

    self.Owner:ViewPunch(Angle(math.random(self.Primary.MinRecoil, self.Primary.MaxRecoil) / 2, 0, 0))

    self:SendWeaponAnim(ACT_VM_IDLE)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:EmitSound(self.Primary.Sound, 110, 100, 1, CHAN_WEAPON)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:GetShellDirection()
    if self:Clip1() <= 0 and self:GetUHBool("Reloading") then
        return Angle(30, -35, 0)
    else
        return Angle(30, -80, 0)
    end
end

-- Completely block all model animation sounds during reload
function SWEP:FireAnimationEvent(pos, ang, event, name)
    if self:GetActivity() == ACT_VM_RELOAD then
        return true
    end
    return false
end

function SWEP:Reload()
    if self:DefaultReload(ACT_VM_RELOAD) then
        timer.Simple(0.65, function()
            if not IsValid(self) or not IsValid(self.Owner) then return end
            if self:GetActivity() == ACT_VM_RELOAD then
                self:EmitSound("Weapon_Crossbow.Reload")
            end
        end)
    end
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