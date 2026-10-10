<<<<<<< HEAD
-- Beretta — Ported from weapon_uh_base_gun to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell gun base (weapon_uh_base_gun)
-- to the CUH base (weapon_cuh_base_gun).
-- The Beretta is a semi-auto pistol with:
--   - 15-round magazine
--   - Silencer support (Primary.SilSound + reload_sil anims)
--   - Underhell-style lowering animations (ACT_VM_IDLE_TO_LOWERED)
--   - ReloadTable-driven reload sound timing
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_pist_beretta.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "Beretta"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "Pistols"
SWEP.UseHands                           = false

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_pist_beretta_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_pist_beretta_pg.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 1
SWEP.SlotPos                            = 2

SWEP.HoldType                           = "pistol"
SWEP.PassiveAnim                        = "normal"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 25
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.SmokeWidth                         = 50
SWEP.HasSilencer                        = true
SWEP.AnimSprint                         = true

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.FireModes = {
    {
        name = "Semi-Auto"
    }
}

SWEP.ReloadTable = {
    {delay = 1, sound = Sound("weapons/uh_beretta/beretta_sliderelease.wav")},
    {delay = 0.1, sound = Sound("weapons/uh_beretta/beretta_clipout.wav")},
    {delay = 0.6, sound = Sound("weapons/uh_beretta/beretta_clipin.wav")},
    {delay = 0, sound = Sound("weapons/uh_beretta/beretta_slideback.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_beretta/beretta_fire.wav")
SWEP.Primary.SilSound           = Sound("weapons/uh_beretta/beretta_fire_silenced.wav")
SWEP.Primary.ClipSize           = 15
SWEP.Primary.Ammo                       = "pistol"
SWEP.Primary.DefaultClip        = 15
SWEP.Primary.MinDamage      = 17
SWEP.Primary.MaxDamage          = 19
SWEP.Primary.Automatic          = false
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Force                      = 8
SWEP.Primary.Spread             = 0.08
SWEP.Primary.Delay                      = 0.14
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -0.8
SWEP.Primary.MaxRecoil          = -1.1

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.Ammo             = "none"
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false

SWEP.IronSightsPos = Vector(-4.12, -4.321, 1.879)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- CUH melee bash config (E+M1)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 54
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/axe/axe_swing1.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

SWEP.Animations = {
    ["reload_empty"] = "ACT_VM_RELOAD",
    ["reload_empty_sil"] = "ACT_VM_RELOAD",
    ["reload_sil"] = "ACT_VM_RELOAD"
}

SWEP.AnimSounds = {}

-- ============================================================
-- SMART MUZZLE / SHELL / DISPLAY
-- ============================================================
function SWEP:GetMuzzle()
    return 1
end

function SWEP:GetShellEject()
    return 2
end

function SWEP:GetDisplay()
    return 1
end

function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end

-- ============================================================
-- THINK (with melee + mantle state machine)
-- ============================================================
function SWEP:Think()
    local ct = CurTime()

    local ply = self.Owner
    if IsValid(ply) then
        local isVaulting = ply:GetNW2Bool("BO3_IsVaulting", false)
        local isMantling = ply:GetNW2Bool("BO3_IsMantling", false)
        local isInTraversal = isVaulting or isMantling
        if isInTraversal and not self._mantleActive then
            if SERVER or IsFirstTimePredicted() then self:StartMantle() end
        end
        if not isInTraversal and self._mantleActive then self:EndMantle() end
    end

    if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
        self:EndMantle()
    end

    -- Melee hit timing
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
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
            if IsValid(target) then self.Owner:SelectWeapon(target:GetClass()) end
        end
    end

    BaseClass.Think(self)
    self:HandleInspect()
end

-- ============================================================
-- MANTLE
-- ============================================================
function SWEP:StartMantle()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end
    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end
    if self._meleeActive then self:EndMelee() end
    if self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end
    self._mantleActive = true
    self:ClearAnimSounds()
    self:EasySendWeaponAnim("mantle", ACT_VM_DRAW)
    local vm = self.Owner:GetViewModel()
    local dur = IsValid(vm) and vm:SequenceDuration() or 0.6
    self._mantleEndTime = ct + dur
    self:SetNextPrimaryFire(ct + dur)
    self:SetNextSecondaryFire(ct + dur)
    self.NextReload = ct + dur
end

function SWEP:EndMantle()
    self._mantleActive = false
    self._mantleEndTime = nil
    self:ClearAnimSounds()
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

-- ============================================================
-- ATTACK GUARDS (E+M1 = melee bash)
-- ============================================================
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end

-- ============================================================
-- HOLSTER / DEPLOY
-- ============================================================
function SWEP:Holster(wep)
    self._justExitedSprint = false
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(self, wep)
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    self:SetHoldType(self.HoldType)
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil
    self._mantleActive = nil
    self._mantleEndTime = nil
    self._justExitedSprint = false
    return true
end

-- ============================================================
-- HANDLE RUNNING (preserved from source: Underhell lowering anims)
-- ============================================================
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
            -- ONLY play lowering anim if NOT reloading
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
            -- Same rule applies here
            if not self:GetUHBool("Reloading") then
                self:SendWeaponAnim(ACT_VM_IDLE_LOWERED)
                self:SendWeaponAnim(ACT_VM_LOWERED_TO_IDLE)
            end
        end

        self:SetUHBool("Running", false)
    end
end

-- ============================================================
-- POST RELOAD (resumes sprint after reload if still holding IN_SPEED)
-- ============================================================
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
=======
AddCSLuaFile()

SWEP.PrintName 				= "Beretta"
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

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_pist_beretta_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_beretta_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 1
SWEP.SlotPos 				= 2

SWEP.HoldType 				= "pistol"
SWEP.PassiveAnim			= "normal"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 25
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.SmokeWidth				= 50
SWEP.HasSilencer			= true
SWEP.AnimSprint				= true

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.FireModes = {
	{
		name = "Semi-Auto"
	}
}

SWEP.ReloadTable = {
	{delay = 1, sound = Sound("weapons/uh_beretta/beretta_sliderelease.wav")},
	{delay = 0.1, sound = Sound("weapons/uh_beretta/beretta_clipout.wav")},
	{delay = 0.6, sound = Sound("weapons/uh_beretta/beretta_clipin.wav")},
	{delay = 0, sound = Sound("weapons/uh_beretta/beretta_slideback.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_beretta/beretta_fire.wav")
SWEP.Primary.SilSound		= Sound("weapons/uh_beretta/beretta_fire_silenced.wav")
SWEP.Primary.ClipSize 		= 15
SWEP.Primary.Ammo 			= "pistol"
SWEP.Primary.DefaultClip 	= 15
SWEP.Primary.MinDamage      = 17
SWEP.Primary.MaxDamage		= 19
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 8
SWEP.Primary.Spread 		= 0.08
SWEP.Primary.Delay 			= 0.14
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.8
SWEP.Primary.MaxRecoil		= -1.1

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false 

SWEP.IronSightsPos = Vector(-4.12, -4.321, 1.879)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
	["reload_empty_sil"] = "ACT_VM_RELOAD",
	["reload_sil"] = "ACT_VM_RELOAD"
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
>>>>>>> 963627a2ad1eb95ef5e1f82e13de3ca5bfdb473a
