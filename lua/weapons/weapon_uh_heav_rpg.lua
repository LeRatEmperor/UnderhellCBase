-- RPG-7 — Ported from weapon_uh_base_gun to CUH base
-- CUH BUILD: v0.7.0-uh-port (2026-10-02)
-- ============================================================
-- Ported from the legacy Underhell gun base (weapon_uh_base_gun)
-- to the CUH base (weapon_cuh_base_gun).
-- The RPG-7 fires sent_rpg_rocket entities (custom projectile):
--   - 1-round clip (rpg_round ammo), 3 in reserve
--   - Two fire modes: Scoped (default) and Unscoped
--   - Custom PrimaryAttack creates sent_rpg_rocket via ents.Create
--     (NOT ShootGrenade — keeps the source's custom rocket logic)
--   - PostDrawViewModel draws the scope lens (3D2D poly circle)
--   - CustomThink toggles rocket bodygroup based on Clip1 > 0
--   - ScopeTexture / CrossMat are CLIENT-only materials for the lens
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_uh_heav_rpg.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName                          = "RPG-7"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.SubCategory                        = "Heavy"
SWEP.UseHands                           = false

SWEP.Spawnable                          = true
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_uhg.mdl"
SWEP.WorldModel                         = "models/weapons/w_uh_rpg_launcher.mdl"

SWEP.AutoSwitchTo                       = true
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 4
SWEP.SlotPos                            = 4

SWEP.HoldType                           = "rpg"
SWEP.PassiveAnim                        = "passive"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = false
SWEP.ViewModelFlip                      = false
SWEP.Chambering                         = false
SWEP.SmokeWidth                         = 100
SWEP.Sensitivity            = 1
SWEP.ZoomFov                            = 0
SWEP.ScopeBlur                          = true
SWEP.ScopeFov                           = 8
SWEP.TwoHanded                          = true
SWEP.AnimSprint                         = true

if CLIENT then
        SWEP.ScopeTexture               = CreateMaterial("UH_RPG-7_Scope_8", "Unlittwotexture", {
                ["$texture2"]           = "vgui/scope_lens_g36k",
                ["$model"]                      = "1"
        })
        SWEP.CrossMat = Material("scope/gdcw_acogcross")
end

SWEP.FireModes = {
        {
                name = "Scoped"
        },
        {
                name = "Unscoped",
                equip = function(ply, wep)
                        wep.ScopeDisabled = true
                        wep.IronSightsPos = Vector(-4.6, -2, 1.25)
                        wep.IronSightsAng = Vector(0, 0, 0)
                        wep.ScopeBlur = false
                end,
                holster = function(ply, wep)
                        wep.ScopeDisabled = false
                        wep.IronSightsPos = Vector(-5.92, -7.5, 0.75)
                        wep.IronSightsAng = Vector(0, 0, -25)
                        wep.ScopeBlur = true
                end,
        }
}

SWEP.Primary.Sound          = Sound("weapons/uh_rpg/rocketfire1.wav")
SWEP.Primary.ClipSize           = 1
SWEP.Primary.Ammo                       = "rpg_round"
SWEP.Primary.DefaultClip        = 3
SWEP.Primary.Automatic          = false
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Delay                      = 0.8
SWEP.Primary.NumberofShots      = 1
SWEP.Primary.MinRecoil          = -8.6
SWEP.Primary.MaxRecoil          = -11.4
SWEP.Primary.ReloadTime         = 1

SWEP.Secondary.ClipSize         = -1
SWEP.Secondary.Ammo             = "none"
SWEP.Secondary.DefaultClip      = -1
SWEP.Secondary.Automatic        = false

SWEP.IronSightsPos = Vector(-5.92, -7.5, 0.75)
SWEP.IronSightsAng = Vector(0, 0, -25)

-- Sprint position (procedural, not animation-based)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.SoundChanger = {
        [")weapons/ar2/ar2_reload.wav"] = "weapons/uh_g36k/g36k_silencer_on.wav"
}

SWEP.SwayPosition = 2.4

SWEP.Animations = {
        ["reload"] = "ACT_VM_RELOAD",
        ["reload_empty"] = "ACT_VM_RELOAD",
}

SWEP.AnimSounds = {
    ["reload"] = {
        {time = 1.1,   sound = "weapons/uh_g36k/g36k_silencer_on.wav"},
    },
}

-- CUH melee bash config (E+M1)
SWEP.MeleeDamage    = 35
SWEP.MeleeRange     = 54
SWEP.MeleeDelay     = 0.4
SWEP.MeleeForce     = 200
SWEP.MeleeHitDelay  = 0.15
SWEP.MeleeViewPunch = Angle(-5, 0, 0)
SWEP.MeleeSound     = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound  = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound = ""
SWEP.MeleeInterruptReload = true

-- No shell ejection for a rocket launcher
SWEP.NoShell = true

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
-- PRIMARY ATTACK — spawn sent_rpg_rocket (preserved from source)
-- ============================================================
-- PrimaryAttack starts with the E+M1 melee gate, then falls
-- through to the RPG's custom rocket firing logic.
-- The RPG creates its own projectile entity directly via ents.Create
-- (NOT ShootGrenade — which would spawn sent_mgl_grenade).
-- This logic is kept 1:1 from the source so the rocket physics,
-- owner, and force application match the original behavior.
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

    -- Custom RPG rocket firing logic (preserved from source)
    if not self:CanPrimaryAttack() then return end

    if SERVER then
        local ent = ents.Create( "sent_rpg_rocket" )
        ent:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 30 - self.Owner:GetUp() * 10 + (self:GetUHBool("Zooming") and Vector(0,0,0) or self.Owner:GetRight() * 5) )
        ent:SetAngles( self.Owner:GetAngles() )
        ent:Spawn()
        ent:Activate()
        ent.Owner = self.Owner
        local phys = ent:GetPhysicsObject()
        if IsValid( phys ) then
            phys:ApplyForceCenter( self.Owner:GetAimVector() * 1000 )
        end
    end

    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)

    if sp or (CLIENT and iftp) then
        local fx = EffectData()
        fx:SetEntity(self)
        fx:SetOrigin(self.Owner:GetShootPos())
        fx:SetNormal(self.Owner:GetAimVector())
        fx:SetAttachment(self:GetMuzzle())
        util.Effect("uh_muzzle",fx)

        self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )

        self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
    end

    self.Owner:ViewPunch( Angle( recoil, 0, 0 ) )

    self:SendWeaponAnim( ACT_VM_IDLE )
    self:SendWeaponAnim( self:ShootAnimation() )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Owner:MuzzleFlash()
    self:EmitSound( self.Primary.Sound, 110, 100, 1, CHAN_WEAPON )
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )

    self.NextReload = CurTime() + 0.5
end

-- ============================================================
-- CUSTOM THINK — toggle rocket bodygroup based on Clip1
-- ============================================================
function SWEP:CustomThink( ct )
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        if self:GetUHBool("Reloading") or self:Clip1() > 0 then
            vm:SetBodygroup(1, 0)
        else
            vm:SetBodygroup(1, 1)
        end
    end
end

-- ============================================================
-- POST DRAW VIEW MODEL — scope lens (3D22 poly circle)
-- ============================================================
local sin,cos,rad = math.sin,math.cos,math.rad
local function GeneratePolyCircle( x, y, radius, quality )
    local circle = {}
    local tmp = 0
    local s,c
    for i = 1, quality do
        tmp = rad(i*360)/quality
        s = sin(tmp)
        c = cos(tmp)
        circle[i] = {x = x + c*radius,y = y + s*radius,u = (c+1)/2,v = (s+1)/2}
    end
    return circle
end

function SWEP:PostDrawViewModel( vm )
    local bone_id = vm:LookupBone("rpg")
    if !bone_id then return end

    local pos,ang = vm:GetBonePosition(bone_id)
    local pos = pos - ang:Forward()*6.575 + ang:Up()*5.65 + ang:Right()*3.8

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 180)
    ang:RotateAroundAxis(ang:Up(), -25)

    cam.Start3D2D(pos, ang, 0.01)
        surface.SetMaterial(self.ScopeTexture)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawPoly( GeneratePolyCircle(0, 0, 50, 25) )
    cam.End3D2D()
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
