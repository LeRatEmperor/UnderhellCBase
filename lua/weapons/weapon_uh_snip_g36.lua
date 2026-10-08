AddCSLuaFile()

SWEP.PrintName 				= "G36K Assault Rifle"
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
SWEP.ViewModel				= "models/weapons/v_g36k_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_g36k_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 4
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "ar2"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.HasSilencer			= true
SWEP.SmokeWidth				= 80
SWEP.Sensitivity            = 0.2
SWEP.ZoomFov				= 10
SWEP.ScopeBlur				= true
SWEP.ScopeFov				= 10
SWEP.ScopeTexture			= Material("models/weapons/v_models/g36k/lens")
SWEP.TwoHanded				= true
SWEP.AnimSprint				= true

SWEP.Shell					= "models/weapons/shell_762.mdl"

SWEP.FireModes = {
	{
		name = "Semi-Auto",
		equip = function(ply, wep)
			wep.Primary.Automatic = false
		end,
		holster = function(ply, wep)
			wep.Primary.Automatic = true
		end
	},
	{
		name = "Auto",
		equip = function(ply, wep)
			wep:SetNWBool("NoScope", true)
			wep.ScopeDisabled		= true
			wep.Primary.Automatic	= true
			wep.IronSightsPos 		= Vector(-3.6, -5.5, 0.26)
			wep.ScopeBlur 			= false
			wep.Sensitivity 		= 1
			wep.Primary.Delay 		= 0.12
		end,
		holster = function(ply, wep)
			wep:SetNWBool("NoScope", false)
			wep.ScopeDisabled		= false
			wep.Primary.Automatic	= false
			wep.IronSightsPos 		= Vector(-3.6, -8.801, -0.361)
			wep.ScopeBlur 			= true
			wep.Sensitivity 		= 0.2
			wep.Primary.Delay 		= 0.25
		end
	}
}

SWEP.ReloadTable = {
	{delay = 0.5, sound = Sound("weapons/uh_g36k/g36k_deploy.wav")},
	{delay = 1, sound = Sound("weapons/uh_g36k/g36k_clipout.wav")},
	{delay = 1.7, sound = Sound("weapons/uh_g36k/g36k_clipin.wav")},
	{delay = 2.5, sound = Sound("weapons/uh_g36k/g36k_boltpull.wav")},
}

SWEP.Primary.Sound          = Sound("weapons/uh_g36k/g36k_fire.wav")
SWEP.Primary.SilSound		= Sound("weapons/uh_g36k/g36k_fire_silenced.wav")
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Ammo 			= "ar2" 
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.MinDamage      = 45
SWEP.Primary.MaxDamage      = 60
SWEP.Primary.Automatic 		= false
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 15
SWEP.Primary.Spread 		= 0.04
SWEP.Primary.Delay 			= 0.25
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -1
SWEP.Primary.MaxRecoil		= -1.4

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.UseQCReloadEvents = false
SWEP.UseReloadTable    = true

SWEP.IronSightsPos = Vector(-3.6, -8.801, -0.361)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.SwayPosition = 2.4

SWEP.Animations = {
	["reload_empty"] = "ACT_VM_RELOAD",
	["reload_empty_sil"] = "ACT_VM_RELOAD",
	["reload_sil"] = "ACT_VM_RELOAD"
}

SWEP.ScopeBones = {
	["scope"] = Vector(0,0,0),
	["scope-flap1"] = Vector(0,0,0),
	["scopeflap2"] = Vector(0,0,0)
}


function SWEP:CustomThink( ct )
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		for bone,sca in pairs(self.ScopeBones) do
			local bone_id = vm:LookupBone(bone)
			if !bone_id then continue end
			
			if self:GetNWBool("NoScope") then
				vm:ManipulateBoneScale(bone_id, sca)
			else
				vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
			end
		end
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