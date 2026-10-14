AddCSLuaFile()

SWEP.PrintName                          = "Underhell Shotgun Base"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.UseHands                           = false
SWEP.Base                   = "weapon_uh_base_gun"

SWEP.Spawnable                          = false
SWEP.AdminSpawnable             = false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_shot_m3_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_shot_m3_pg.mdl"

SWEP.AutoSwitchTo                       = true           
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                                       = 3
SWEP.SlotPos                            = 0

SWEP.HoldType                           = "shotgun"
SWEP.FiresUnderwater            = false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = true 
SWEP.reloaddelay                        = 0
SWEP.SmokeWidth                         = 35
SWEP.PenetrationDepth           = 12
SWEP.Shell                                      = "models/weapons/shotgun_shell.mdl"
SWEP.Shotgun                            = true

SWEP.Primary.Sound          = Sound("weapons/uh_m3/m3_fire.wav")
SWEP.Primary.PumpSound      = Sound("weapons/uh_m3/m3_pump.wav")
SWEP.Primary.ClipSize           = 8
SWEP.Primary.Ammo                       = "buckshot" 
SWEP.Primary.DefaultClip        = 8
SWEP.Primary.MinDamage      = 4
SWEP.Primary.MaxDamage      = 8
SWEP.Primary.Automatic          = false
SWEP.Primary.TakeAmmo           = 1
SWEP.Primary.Force                      = 13
SWEP.Primary.Spread             = 1.2
SWEP.Primary.Delay                      = 1.1
SWEP.Primary.NumberofShots      = 10
SWEP.Primary.MinRecoil          = -4.5
SWEP.Primary.MaxRecoil          = -5.8
SWEP.Primary.ReloadTime         = 0.5

SWEP.Secondary.ClipSize         = -1 
SWEP.Secondary.Ammo             = "none" 
SWEP.Secondary.DefaultClip      = -1     
SWEP.Secondary.Automatic        = false


function SWEP:Initialize()
        util.PrecacheSound(self.Primary.Sound)
        if self.Primary.ShellSound then
                util.PrecacheSound(self.Primary.ShellSound)
        end
        if self.IsPump then
                util.PrecacheSound(self.Primary.PumpSound)
        end
        util.PrecacheModel(self.ViewModel)
        util.PrecacheModel(self.WorldModel)
        self:SetWeaponHoldType( self.HoldType )
        self:SetHoldType( self.HoldType )
        self.NextReload = CurTime()
        self:SetNWInt("FireMode", 1)
end

function SWEP:PostShoot()
        if self.IsPump then
                if self:Clip1() <= 0 and GetConVar("uh_sv_realpump"):GetBool() then
                        if timer.Exists("UH_Shell_"..self.Owner:SteamID()) then
                                timer.Remove( "UH_Shell_"..self.Owner:SteamID() )
                        end
                else
                        timer.Simple(self.PumpDelay or 0.5, function()
                                if !IsValid(self) or self:GetUHBool("Reloading") or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
                                if game.SinglePlayer() or IsFirstTimePredicted() then
                                        self.Owner:EmitSound( self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE )
                                end
                                self:SendWeaponAnim( ACT_VM_IDLE )
                                self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
                        end)
                end
        end
end

function SWEP:ReloadShotgun( ct )
        if self:GetUHBool("Reloading") then
                if self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 or self:Clip1() >= self.Primary.ClipSize or self.Owner:KeyPressed( IN_ATTACK ) then
                        self:SetUHBool("Reloading", false)
                        self:SetNWFloat("ReloadTime", 0)
                        self:SetNWFloat("ReloadEndTime", 0)
                        self:SetNextPrimaryFire( ct + self.Primary.ReloadTime + 0.5 )
                        self:SetNextSecondaryFire( ct + self.Primary.ReloadTime + 0.5 )
                        self.NextReload = ct + self.Primary.ReloadTime + 0.5
                        timer.Simple(self.Primary.ReloadTime, function()
                                if !IsValid(self) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
                                self:EasySendWeaponAnim( "after_reload", ACT_SHOTGUN_RELOAD_FINISH )
                                self:SetupAnimSounds("reload_end")
                                self:PostReload()
                        end)
                elseif SERVER or !game.SinglePlayer() then
                        if self.reloaddelay < ct then
                                self.reloaddelay = ct + self.Primary.ReloadTime
                                self:SetNextPrimaryFire( self.reloaddelay )
                                if self.Primary.ShellSound then
                                        if (game.SinglePlayer() and SERVER) or (CLIENT and IsFirstTimePredicted()) then
                                                self.Owner:EmitSound( self.Primary.ShellSound, 75, 100, 1, CHAN_USER_BASE )
                                        end
                                end
                                self:EasySendWeaponAnim( "after_reload", ACT_SHOTGUN_RELOAD_FINISH )
                                self:SetupAnimSounds("reload_loop")
                                vm = self.Owner:GetViewModel()
                                vm:SetPlaybackRate(.01)
                                timer.Simple(.05, function()
                                        self:EasySendWeaponAnim( "reload_loop", ACT_VM_RELOAD )
                                end)
                                self:SetClip1(self:Clip1() + 1)
                                self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
                        end
                end
        end
end

function SWEP:Reload()
        if self.NextReload < CurTime() and !self:GetUHBool("Reloading") and !self:GetUHBool("Running") and self.Owner:GetNWFloat("GrenadeTime") < CurTime() then
                if self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ) != 0 and self:Clip1() < self.Primary.ClipSize then
                        if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
                        
                        self.Owner:DoReloadEvent()
                        self.NextReload = CurTime() + 0.5
                        
                        self:PreReload()
                        
                        if SERVER then
                                if self.Owner:GetNWBool("UH_Flashlight") then
                                        self.Owner:SetNWBool("UH_Flashlight", false)
                                        self.Owner:SetNWBool("UH_ArmGone", false)
                                        if !self.IsBolt and !self.IsPump and !self.TwoHanded then
                                                self.Owner:SetNWFloat("UH_ArmTime", CurTime() + 0.25)
                                        end
                                        self.Owner:EmitSound("uh/flashlight.wav")
                                        
                                        net.Start("UH_Flashlight")
                                                net.WriteEntity(self.Owner)
                                                net.WriteBool(false)
                                        net.Broadcast()
                                elseif self.Owner:GetNWBool("UH_Flare") then
                                        UHThrowFlare( self.Owner )
                                        
                                        self.Owner:SetNWBool("UH_ArmGone", false)
                                        if !self.IsBolt and !self.IsPump and !self.TwoHanded then
                                                self.Owner:SetNWFloat("UH_ArmTime", CurTime() + 0.25)
                                        end
                                end
                        end
                        
                        self.reloaddelay = CurTime() + self.Primary.ReloadTime
                        self:EasySendWeaponAnim( "idle", ACT_VM_IDLE )
                        self:EasySendWeaponAnim( "start_reload", ACT_SHOTGUN_RELOAD_START )
                        self:SetupAnimSounds("reload_start")
                        
                        self:SetNextPrimaryFire( CurTime() + 0.5 )
                        self:SetNextSecondaryFire( CurTime() + 0.5 )
                        
                        self:SetUHBool("Reloading", true)
                        self:SetUHBool("Zooming", false)
                        
                        local num = math.min(self.Primary.ClipSize-self:Clip1(), self.Owner:GetAmmoCount( self:GetPrimaryAmmoType() ))
                        local amount = num * self.Primary.ReloadTime
                        
                        self:SetNWFloat("ReloadTime", amount)
                        self:SetNWFloat("ReloadEndTime", CurTime() + amount)
                end
        end
end

function SWEP:PreReload()
        if SERVER then
                self.b_clip = self:Clip1()
        end
end

function SWEP:PostReload()
        if !GetConVar("uh_sv_realpump"):GetBool() or !self.IsPump then return end
        if SERVER and self.b_clip <= 0 and self:Clip1() > self.b_clip then
                self.b_clip = nil
                
                local ct = CurTime()
                local delay = self.PumpDelay or 0.5
                
                self:CreateShell( self.ShellDelay, 0 )
                self:SetNextPrimaryFire(ct + delay + 0.6)
                self:SetNextSecondaryFire(ct + delay + 0.6)
                self.NextReload = ct + delay + 0.6
                
                timer.Simple(delay, function()
                        if !IsValid(self) or self:GetUHBool("Reloading") or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
                        self.Owner:EmitSound( self.Primary.PumpSound, 75, 100, 1, CHAN_USER_BASE )
                        self:EasySendWeaponAnim( "rechamber", ACT_SHOTGUN_PUMP )
                end)
        end
end