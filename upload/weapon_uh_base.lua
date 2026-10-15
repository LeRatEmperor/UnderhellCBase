AddCSLuaFile()

SWEP.PrintName                          = "Underhell Base"
SWEP.Author                             = ""
SWEP.Contact                            = ""
SWEP.Purpose                            = ""
SWEP.Instructions                       = ""
SWEP.Category                           = "UnderHell"
SWEP.UseHands                           = false

SWEP.Spawnable                          = false
SWEP.AdminSpawnable             		= false

SWEP.ViewModelFOV                       = 64
SWEP.ViewModel                          = "models/weapons/v_smg_mp5_pg.mdl"
SWEP.WorldModel                         = "models/weapons/w_smg_mp5_pg.mdl"

SWEP.AutoSwitchTo                       = true           
SWEP.AutoSwitchFrom                     = true

SWEP.Slot                               = 2
SWEP.SlotPos                            = 3

SWEP.HoldType                           = "smg"
SWEP.PassiveAnim                        = "passive"
SWEP.FiresUnderwater            		= false
SWEP.Weight                             = 45
SWEP.DrawCrosshair                      = false
SWEP.DrawAmmo                           = true
SWEP.DrawWeaponInfoBox          		= false

SWEP.Primary.ClipSize           		= 30
SWEP.Primary.Ammo                       = "smg1" 
SWEP.Primary.DefaultClip        		= 30
SWEP.Primary.Automatic          		= true

SWEP.Secondary.ClipSize         		= -1 
SWEP.Secondary.Ammo            			= "none" 
SWEP.Secondary.DefaultClip     			= -1     
SWEP.Secondary.Automatic        		= false

SWEP.SwayScale  = 0
SWEP.BobScale   = 0

SWEP.SwayPosition = 2
SWEP.LoweredPos            = Vector(0, 0, 0)
SWEP.LoweredAng            = Angle(0, 0, 0)

-- AnimatedFirstDraw: when true, plays a first-draw animation (via the
-- "first_draw" Animations key) instead of the position-based deploy time system.
-- Only triggers when uh_sv_deploy is enabled and it's the first time equipping.
SWEP.AnimatedFirstDraw = false

-- If a swep uses a animation for sprinting then set this to true
SWEP.AnimatedSprint = false

-- Movement
local c_jump = 0
local c_look = 0
local c_sight = 0
local c_shoot = 0

-- Viewbob sync (shared so Movement() can read them on server)
local curviewbob_p = 0
local curviewbob_y = 0

-- Bob system
local erp = 0
local erp_to_default = {}
local bob_time = 0
local bob_nextthink = 0
local c_lerp = 0
local c_test = 0
local c_lll = 0
local c_lrun = 0
local c_breath_p = 0
local c_breath_y = 0
local c_breath_r = 0
local c_veloffset = Vector(0, 0, 0)

-- Ironsights
local c_iron = 0

-- Grenades
local c_lob = 0

-- Sway
local c_oang = Angle( 0, 0, 0 )
local c_dang = Angle( 0, 0, 0 )

-- Inspection
local c_iang = Angle( 0, 0, 0 )
local c_ipos = Vector( 0, 0, 0 )

SWEP.IronSightsPos = Vector(-6, -8, -10)
SWEP.IronSightsAng = Vector(20, 40, -60)

SWEP.Inspection = {}

SWEP.HideMaterials = {}

-- VM3D2D: Draw 3D2D surfaces attached to viewmodel bones.
-- Weapons define entries in SWEP.VM3D2D. Each entry draws a cam.Start3D2D
-- billboard at a bone position with an offset. Useful for ammo counters,
-- status displays, labels, etc.
--
-- Format:
--   SWEP.VM3D2D = {
--       ["name"] = {
--           bone = "bone_name",          -- Viewmodel bone to attach to
--           pos = Vector(x, y, z),       -- Offset from bone (Right, Forward, Up)
--           ang = Angle(p, y, r),        -- Angle offset from bone
--           size = 0.004,                -- 3D2D scale
--           draw_func = function(wep)    -- Called inside cam.Start3D2D. wep = weapon.
--               surface.SetDrawColor(255, 0, 0)
--               surface.DrawRect(0, 0, 100, 100)
--           end
--       }
--   }
SWEP.VM3D2D = {}

SWEP.LeftBones = {
        ["Left_U_Arm"] = Angle(-50,50,-50)
}


function SWEP:GetViewModelPosition(pos, ang)
        local sp,ct,ft,iftp = game.SinglePlayer(),CurTime(),FrameTime(),IsFirstTimePredicted()
        if sp then iftp = true end
        -- GetViewModelPosition is a rendering hook — always update visual
        -- lerps for smooth interpolation regardless of prediction state.
        -- Without this, viewmodel transitions stutter in multiplayer because
        -- IsFirstTimePredicted only fires at server tick rate, not render fps.
        if CLIENT then iftp = true end

        local pos,ang = self:Inspect(pos,ang,ct)
        local pos,ang = self:Grenade(pos,ang,ct,ft,iftp)
        local pos,ang = self:Sway(pos,ang,ft,iftp)
        local pos,ang = self:Movement(pos,ang,ct,ft,iftp)

        if self.IronSightsPos and self.IronSightsAng then
                pos,ang = self:Sights(pos,ang,ft,iftp)
        end

        return pos,ang
end

function SWEP:Inspect(pos, ang, ct)
        if !GetConVar("uh_sv_deploy"):GetBool() then return pos,ang end
        local t = (self:GetNWFloat("DeployTime")-ct)
        if t > 0 then
                if t > 2 then
                        local p = math.Clamp((1-(t-2))*2, 0, 1)
                        local stage = self.Inspection[1]
                        c_iang = LerpAngle( p, Angle(0, 0, 0), stage.ang )
                        c_ipos = LerpVector( p, Vector(0, 0, 0), stage.pos )
                elseif t > 1 then
                        local p = math.Clamp((1-(t-1))*2, 0, 1)
                        local oldstage = self.Inspection[1]
                        local stage = self.Inspection[2]
                        c_iang = LerpAngle( p, oldstage.ang, stage.ang )
                        c_ipos = LerpVector( p, oldstage.pos, stage.pos )
                else
                        local p = 1-t
                        local stage = self.Inspection[2]
                        c_iang = LerpAngle( p, stage.ang, Angle(0, 0, 0) )
                        c_ipos = LerpVector( p, stage.pos, Vector(0, 0, 0) )
                end
                
                ang:RotateAroundAxis(ang:Right(),       c_iang.p)
                ang:RotateAroundAxis(ang:Up(),          c_iang.y)
                ang:RotateAroundAxis(ang:Forward(), c_iang.r)
                
                pos = pos + ang:Right() * c_ipos.x + ang:Forward() * c_ipos.y + ang:Up() * c_ipos.z
        end
        return pos,ang
end

function SWEP:Grenade(pos, ang, ct, ft, iftp)
        if iftp then
                if self.Owner:GetNWFloat("UH_GrenadeTime") > ct then
                        local t = self.Owner:GetNWFloat("UH_GrenadeTime") - ct
                        if t > 0.5 then
                                c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 1)
                        else
                                c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 0)
                        end
                else
                        c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 0)
                end
        end
        
        ang:RotateAroundAxis(ang:Up(), -c_lob*12)
        ang:RotateAroundAxis(ang:Forward(), c_lob*5)
        
        return pos,ang
end

function SWEP:Sights(pos, ang, ft, iftp)
        if iftp then
                -- Ease-in: starts slow, speeds up toward target (snappier than original exponential approach)
			local _iron_target = self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0
			local _iron_current = c_iron or 0
			local _iron_remaining = math.abs(_iron_target - _iron_current)
			local _iron_speed = math.min(ft * 6 * (1 + (1 - _iron_remaining) * 1.5), 1)
			c_iron = Lerp(_iron_speed, _iron_current, _iron_target)
        end
        
        local offset = self.IronSightsPos
        
        if self.IronSightsAng then
                ang:RotateAroundAxis(ang:Right(),       self.IronSightsAng.x * c_iron)
                ang:RotateAroundAxis(ang:Up(),          self.IronSightsAng.y * c_iron)
                ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * c_iron)
        end
        
        pos = pos + offset.x * c_iron * ang:Right()
        pos = pos + offset.y * c_iron * ang:Forward()
        pos = pos + offset.z * c_iron * ang:Up()
        
        return pos, ang
end

function SWEP:Sway(pos, ang, ft, iftp)
        local sway = GetConVar("uh_vmsway"):GetFloat() or 1.2
        
        if sway == 0 then return pos,ang end
        
    local angdelta = self.Owner:EyeAngles() - c_oang
        
        if angdelta.y >= 180 then
                angdelta.y = angdelta.y - 360
        elseif angdelta.y <= -180 then
                angdelta.y = angdelta.y + 360
        end
        
        angdelta.p = math.Clamp(angdelta.p, -5, 5)
        angdelta.y = math.Clamp(angdelta.y, -5, 5)
        angdelta.r = math.Clamp(angdelta.r, -5, 5)
        
        if self:GetUHBool("Zooming") then
                angdelta = angdelta * 0.05
        end
        
        if iftp then
                local newang = LerpAngle( math.Clamp(ft * 10, 0, 1), c_dang, angdelta )
                c_dang = newang
        end
    c_oang = self.Owner:EyeAngles()
        
        local psway = sway / (self.SwayPosition or 2)
        
        ang:RotateAroundAxis( ang:Right(), -c_dang.p*sway )
        ang:RotateAroundAxis( ang:Up(), c_dang.y*sway )
        ang:RotateAroundAxis( ang:Forward(), c_dang.y*sway )
        
        pos = pos + ang:Right()*c_dang.y*psway + ang:Up()*c_dang.p*psway
        
    return pos,ang
end

function SWEP:Movement(pos, ang, ct, ft, iftp)
        local bob = GetConVar("uh_vmbob"):GetFloat()
        local idle = GetConVar("uh_vmidle"):GetFloat()

        if bob == 0 and idle == 0 then return pos,ang end

        local vel = self.Owner:GetVelocity()
        local move = Vector(vel.x, vel.y, 0)
        local moveSpeed = move:Length()
        local maxSpeed = self.Owner:GetRunSpeed()
        local maxWalk = self.Owner:GetWalkSpeed()
        local onGround = self.Owner:OnGround()
        local isRunning = self:GetUHBool("Running")
        local isZooming = self:GetUHBool("Zooming")
        local ft8 = math.Clamp(ft * 8, 0, 1)

        if iftp then
                -- COSINE BOB (Speed-Adaptive)
                -- Frequency scales with the character's
                -- run/walk speed instead of being hardcoded.
                -- Naturally decays when stopping.
                if isRunning and onGround then
                        erp_to_default = {}
                        bob_time = ct * (3.7 + math.Clamp(maxSpeed / 150, 0, 3)) * 2
                        erp = math.cos(bob_time) * 2
                elseif moveSpeed > 0 and onGround and (bob_nextthink + ft * 5) < ct then
                        erp_to_default = {}
                        bob_time = ct * (2.75 + math.Clamp(maxWalk / 120, 0, 2)) * 2
                        erp = math.cos(bob_time) * 0.5
                elseif not onGround then
                        if not erp_to_default[1] then
                                erp_to_default = {erp, ct + 0.1}
                        end
                        erp = erp_to_default[1] * math.Clamp((erp_to_default[2] - ct) * 2, 0, 1)
                        bob_nextthink = ct
                else
                        if not erp_to_default[1] then
                                erp_to_default = {erp, ct + 0.33}
                        end
                        erp = erp_to_default[1] * math.Clamp((erp_to_default[2] - ct) * 3, 0, 1)
                end

                -- Zoom factor: reduces bob amplitude when ADS
                c_sight = Lerp(ft8, c_sight, isZooming and 0.125 or 1)

                -- Double-smooth the cosine wave
                local walkRemapped = math.Clamp(moveSpeed / maxWalk, 0, 1)
                c_lerp = Lerp(ft * 12, c_lerp, (erp * walkRemapped * c_sight) * 1.1)
                c_test = Lerp(ft * 4, c_test, c_lerp)
                c_lll = Lerp(ft * 10, c_lll, math.abs(c_lerp))

                -- Running direction: drives bob asymmetry (-1 or 1)
                c_lrun = Lerp(ft * 14, c_lrun, isRunning and -1 or 1)

                -- Jump
                c_jump = Lerp(ft8, c_jump, self.Owner:GetMoveType() == MOVETYPE_NOCLIP and 0 or math.Clamp(vel.z / 120, -1.5, 1))

                -- Look direction lean
                local velNorm = move:GetNormalized()
                local rd = self.Owner:GetRight():Dot(velNorm)
                local mp = math.Clamp(moveSpeed / maxSpeed, 0, 1)

                if rd > 0.5 then
                        c_look = Lerp(ft * 5, c_look, 5 * mp)
                elseif rd < -0.5 then
                        c_look = Lerp(ft * 5, c_look, -5 * mp)
                else
                        c_look = Lerp(ft * 5, c_look, 0)
                end

                -- Velocity direction offset
                local normalized = vel:GetNormalized()
                c_veloffset = Lerp(ft * 4, c_veloffset, -(normalized / 3) * walkRemapped)
        end

        -- Jump
        pos = pos + ang:Up() * c_jump
        ang.p = ang.p + c_jump * 2
        ang.r = ang.r + c_look


        --  Viewbob sync (camera + viewmodel move together)
        -- Match the camera's position-based bob so the viewmodel
        -- stays anchored to the camera instead of floating independently
        pos = pos + ang:Up() * curviewbob_p
        pos = pos + ang:Right() * curviewbob_y

        -- COSINE Viewmodel Bob
        if bob != 0 and not (self.AnimatedSprint and isRunning) then
                -- Position: lateral sway + vertical bounce
                pos = pos + ang:Right() * c_lerp * (isRunning and 1 or 0.6) * bob
                pos = pos + ang:Up() * c_lll * 2 * (isZooming and -0.45 or 0.65) * (isRunning and 1 or 0.8) * bob
                pos.z = pos.z + c_veloffset.z * bob

                -- Angle: pitch/yaw/roll from bob
                ang:RotateAroundAxis(ang:Up(), -c_test * c_lrun * 10 * bob)
                ang:RotateAroundAxis(ang:Right(), -c_test * c_lrun * 1.2 * bob)
                ang:RotateAroundAxis(ang:Forward(), c_test * 3 * bob)
        end

        -- Breathing Idle
        if idle != 0 then
                if not isRunning and not isZooming and moveSpeed < 1 then
                        c_breath_p = Lerp(ft * 10, c_breath_p, math.sin(ct * 0.5) * idle)
                        c_breath_y = Lerp(ft * 10, c_breath_y, math.sin(ct * 1) * 0.5 * idle)
                        c_breath_r = Lerp(ft * 10, c_breath_r, math.sin(ct * 2) * 0.25 * idle)
                else
                        c_breath_p = Lerp(ft * 10, c_breath_p, 0)
                        c_breath_y = Lerp(ft * 10, c_breath_y, 0)
                        c_breath_r = Lerp(ft * 10, c_breath_r, 0)
                end

                ang.p = ang.p + c_breath_p * c_sight
                ang.y = ang.y + c_breath_y * c_sight
                ang.r = ang.r + c_breath_r * c_sight
        end

        return pos,ang
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
        return true -- Fuck the particles.
end

function SWEP:EasySendWeaponAnim(lookupanimation, elseifnotfounded)
        self:SendWeaponAnim(elseifnotfounded or ACT_VM_DRAW)
end

function SWEP:HandleRunning( ct )
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local fireDelay = self:GetNextPrimaryFire() - ct
        if fireDelay > 0.3 then return end
    end
    -- Don't let sprint override the animated first draw
    if self:GetNWBool("FirstDrawPlaying") then return end

    if self:GetUHBool("Running") or self:GetNWInt("FireMode") == 0 then
        self:SetHoldType( self.PassiveAnim )
    else
        self:SetHoldType( self.HoldType )
    end
    
    if !GetConVar("uh_sv_running"):GetBool() then return end
    if self:GetNWInt("FireMode") == 0 then return end
    
    local dist = self.Owner:GetVelocity():LengthSqr()
    
    if self.Owner:KeyDown( IN_SPEED ) and dist > self.Owner:GetWalkSpeed()^2 then
        if !self:GetUHBool("Running") then
            local act = ACT_VM_IDLE_TO_LOWERED
            
            if self.HasSilencer and self:GetNWBool("Silenced") then
                act = ACT_VM_IDLE_SILENCED
            elseif self.Animations and self.Animations["idle_empty"] and self:Clip1() <= 0 then
                local vm = self.Owner:GetViewModel()
                if IsValid(vm) then
                    local seq = vm:LookupSequence(self.Animations["idle_empty"])
                    if seq and seq > 0 then
                        act = seq
                    end
                end
            end
            
            -- Clear any pending custom idle — we're sprinting now
            self._engineWantsIdle = nil
            self._customIdleActive = false
            
            self:SendWeaponAnim( ACT_VM_IDLE )
            self:SendWeaponAnim( act )
            
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                vm:SetBodygroup(1, self:GetNWBool("Silenced") and 1 or 0)
            end
        end
        self:SetUHBool("Running", true)
        self:SetUHBool("Zooming", false)
        
        if self:GetUHBool("Reloading") then
            self:SetUHBool("Reloading", true)
            self.NextReload = ct + 0.5
            if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove( "UHReload_"..self.Owner:SteamID() )
            end
        end
        
    elseif self:GetUHBool("Running") then
        if self:GetNextPrimaryFire() < ct + 0.5 then
            self:SetNextPrimaryFire( ct + 0.5 )
            self:SetNextSecondaryFire( ct + 0.5 )
        end
        
        local act = ACT_VM_LOWERED_TO_IDLE
        
        if self.HasSilencer and self:GetNWBool("Silenced") then
            act = ACT_VM_IDLE_SILENCED
        elseif self.Animations and self.Animations["idle_empty"] and self:Clip1() <= 0 then
            local vm = self.Owner:GetViewModel()
            if IsValid(vm) then
                local seq = vm:LookupSequence(self.Animations["idle_empty"])
                if seq and seq > 0 then
                    act = seq
                end
            end
        end

        self:SendWeaponAnim( act )
        
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
            vm:SetBodygroup(1, self:GetNWBool("Silenced") and 1 or 0)
        end
        
        self:SetUHBool("Running", false)
    end
end

function SWEP:HandleBones( vm, ct )
        if game.SinglePlayer() or IsFirstTimePredicted() then
                self.c_grenlerp = Lerp( FrameTime() * 5, self.c_grenlerp or 0, (self.Owner:GetNWFloat("UH_ArmTime") > ct or self.Owner:GetNWBool("UH_ArmGone")) and 1 or 0 )
        end
        
        for bone,ang in pairs(self.LeftBones) do
                local bone_id = vm:LookupBone(bone)
                if !bone_id then continue end
                
                vm:ManipulateBoneAngles(bone_id, ang * (self.c_grenlerp or 0))
        end
        
        if self:GetNWBool("Silenced") or self:GetNWFloat("SilenceTime") > ct then
                vm:SetBodygroup(1, 1)
        else
                vm:SetBodygroup(1, 0)
        end
end

function SWEP:HandleHands( vm )
        local skin = math.Clamp(self.Owner:GetInfoNum("uh_hands", 0), -1, 3)
        if skin then
                vm:SetSkin( skin != -1 and skin or 0 )
                if CLIENT and vm.uh_hands != skin then
                        vm.uh_hands = skin
                        if skin == 0 then
                                local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
                                local newmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands_casual" )
                                local oldtex = handmat:GetTexture("$basetexture")
                                local newtex = newmat:GetTexture("$basetexture")
                                if !cs_oldtex and oldtex != newtex and oldtex:GetName() != newtex:GetName() then
                                        cs_oldtex = {}
                                        cs_oldtex.tex = oldtex
                                        cs_oldtex.detail = handmat:GetTexture("$detail")
                                        cs_oldtex.blendfactor = handmat:GetFloat("$detailblendfactor") or 0
                                        cs_oldtex.blendmode = handmat:GetInt("$detailblendmode") or 0
                                        cs_oldtex.scale = handmat:GetFloat("$detailscale") or 1
                                end
                                handmat:SetTexture("$basetexture", newtex)
                                handmat:SetTexture("$detail", newmat:GetTexture("$detail"))
                                handmat:SetFloat("$detailblendfactor", newmat:GetFloat("$detailblendfactor"))
                                handmat:SetInt("$detailblendmode", newmat:GetInt("$detailblendmode"))
                                handmat:SetFloat("$detailscale", newmat:GetFloat("$detailscale"))
                        else
                                local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
                                if cs_oldtex then
                                        local detail = cs_oldtex.detail
                                        handmat:SetTexture("$basetexture", cs_oldtex.tex)
                                        handmat:SetTexture("$detail", detail and !string.find(detail:GetName(), "error") and detail or Material("color"):GetTexture("$basetexture"))
                                        handmat:SetFloat("$detailblendfactor", cs_oldtex.blendfactor or 0)
                                        handmat:SetInt("$detailblendmode", cs_oldtex.blendmode or 0)
                                        handmat:SetFloat("$detailscale", cs_oldtex.scale or 1)
                                end
                        end
                end
        end
end

function SWEP:ClearAnimSounds()
        self._animSoundActive = false
        self._animSoundTimeline = nil
        self._animSoundIndex = 0
end

function SWEP:Deploy()
        if SERVER then
                if !self.b_ammogiven then
                        self.b_ammogiven = true
                        if GetConVar("uh_sv_ammo"):GetBool() and self.Primary.ClipSize > 0 then
                                self.Owner:GiveAmmo(self.Primary.ClipSize * 5, self.Primary.Ammo, true)
                        end
                end
        end
        
        if self.CustomDeploy then
                self:CustomDeploy()
        end
        
        self._isRechambering = false
        self._burstRemaining = nil
        self._burstNextFire = nil
        self.wasZooming = false
        self.wasRunning = false
        self._lastIdleSilenced = nil
        self._lastIdleEmpty = nil
        self._holsterDone = nil
        self._holsterEndTime = nil
        self._holsterTarget = nil
        self:ClearAnimSounds()
        
        self:SetUHBool("Reloading", false)
        self:SetUHBool("Zooming", false)
        self:SetUHBool("Running", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self.NextReload = CurTime() + 0.5
        self:SetNextPrimaryFire( CurTime() + 1 )
        self:SetNextSecondaryFire( CurTime() + 1 )

        -- ==========================================
        -- FIRST DRAW: Animated vs Position-based
        -- AnimatedFirstDraw = true: plays "first_draw" animation
        --   with its own AnimSounds timeline.
        -- AnimatedFirstDraw = false (default): uses the original
        --   position-based DeployTime system.
        -- ==========================================
        if not self:GetNWBool("FirstTimeDeployed") and GetConVar("uh_sv_deploy"):GetBool() then
                self:SetNWBool("FirstTimeDeployed", true)

                if self.AnimatedFirstDraw then
                        -- Animated first draw: play the "first_draw" animation
                        -- Do NOT set DeployTime here — that would trigger the
                        -- position-based inspection offsets in Inspect().
                        local vm = self.Owner:GetViewModel()
                        self:EasySendWeaponAnim("first_draw", ACT_VM_DRAW)

                        -- Lock controls for the animation duration
                        local animDuration = IsValid(vm) and vm:SequenceDuration() or 3
                        animDuration = math.max(3, animDuration)

                        self:SetNextPrimaryFire( CurTime() + animDuration )
                        self:SetNextSecondaryFire( CurTime() + animDuration )
                        self.NextReload = CurTime() + animDuration

                        -- Flag prevents sprint from overriding the animation
                        self:SetNWBool("FirstDrawPlaying", true)
                        timer.Simple(animDuration, function()
                                if IsValid(self) then self:SetNWBool("FirstDrawPlaying", false) end
                        end)
                else
                        -- Position-based first draw (original behavior)
                        self:EasySendWeaponAnim("draw", ACT_VM_DRAW)

                        local animtime = math.max(3, self.Owner:GetViewModel():SequenceDuration())

                        self:SetNWFloat("DeployTime", CurTime() + animtime)
                        if self.PreCock then
                                timer.Simple(animtime - 1.5, function()
                                        if !IsValid(self) or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
                                        self.Owner:EmitSound( self.Primary.PumpSound )
                                        self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
                                end)
                        end
                end
        else
                -- Normal draw (not first time)
                self:EasySendWeaponAnim("draw", ACT_VM_DRAW)
        end

        return false
end

function SWEP:Holster( wep )
        if !game.SinglePlayer() and !IsFirstTimePredicted() then return true end
        local vm = self.Owner:GetViewModel()
        if IsValid(vm) then
                if IsValid(wep) and string.find(wep:GetClass(), "weapon_uh_base") then
                        vm:SetSkin(0)
                        if CLIENT and GetConVar("uh_hands"):GetInt() == 0 then
                                local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
                                local v = cs_oldtex
                                if v then
                                        local detail = v.detail
                                        handmat:SetTexture("$basetexture", v.tex)
                                        handmat:SetTexture("$detail", detail and !string.find(detail:GetName(), "error") and detail or Material("color"):GetTexture("$basetexture"))
                                        handmat:SetFloat("$detailblendfactor", v.blendfactor or 0)
                                        handmat:SetInt("$detailblendmode", v.blendmode or 0)
                                        handmat:SetFloat("$detailscale", v.scale or 1)
                                end
                        end
                end
                for bone_id = 0, vm:GetBoneCount() - 1 do
                        if string.find(vm:GetBoneName(bone_id), "INVALIDBONE") then continue end
                        vm:ManipulateBonePosition(bone_id, Vector(0,0,0))
                        vm:ManipulateBoneAngles(bone_id, Angle(0,0,0))
                        vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
                end
        end
        self:SetUHBool("Reloading", false)
        self:SetUHBool("Zooming", false)
        self:SetUHBool("Running", false)
        self:SetNWBool("FirstDrawPlaying", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self._customIdleActive = false
        self._customIdleKey = nil
        self._engineWantsIdle = nil
        self:ClearAnimSounds()
        if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
                timer.Remove( "UHReload_"..self.Owner:SteamID() )
        end
        self.NextReload = CurTime() + 0.5
        self.m_skin = nil
        self.b_reflashlight = nil
        if self.CustomHolster then
                self:CustomHolster( wep )
        end
        return true
end

if SERVER then return end

-- Camera bob (UG-inspired, position-based movement)
local v_zoom = 0

function SWEP:CalcView( ply, pos, ang, fov )
        if LocalPlayer():ShouldDrawLocalPlayer() then return end
        
        local ft,ct = FrameTime(),CurTime()
        local intensity = GetConVar("uh_viewbob"):GetFloat() or 1
        local ws = self.Owner:GetWalkSpeed()
        local vel = self.Owner:GetVelocity():Length()
        local onGround = self.Owner:OnGround()
        local isZooming = self:GetUHBool("Zooming")
        
        if intensity > 0 and onGround and vel > ws * 0.3 then
                local zoomFactor = isZooming and 0.15 or 1
                
                if vel < ws * 1.2 then
                        -- Walking: up/down bounce + subtle left/right sway
                        curviewbob_p = math.cos(ct * 15) * 1 * zoomFactor * intensity
                        curviewbob_y = math.cos(ct * 12) * 0.5 * zoomFactor * intensity
                else
                        -- Running: faster, bigger movement
                        curviewbob_p = math.cos(ct * 20) * 1.2 * zoomFactor * intensity
                        curviewbob_y = math.cos(ct * 15) * 0.6 * zoomFactor * intensity
                end
        else
                -- Standing still / airborne: smooth decay to zero
                curviewbob_p = Lerp(ft * 10, curviewbob_p, 0)
                curviewbob_y = Lerp(ft * 10, curviewbob_y, 0)
        end
        
        -- Apply as POSITION offsets, not rotation
        pos = pos + ang:Up() * curviewbob_p
        pos = pos + ang:Right() * curviewbob_y
        
        local zoomSpeed = self:GetUHBool("Zooming") and ft * 5 or ft * 5
        -- Ease-in for zoom FOV: starts slow, speeds up
	local _zoom_target = self:GetUHBool("Zooming") and self.ZoomFov or 0
	local _zoom_remaining = math.abs(_zoom_target - v_zoom) / math.max(self.ZoomFov or 1, 1)
	local _zoom_speed = math.min(zoomSpeed * (1 + (1 - _zoom_remaining) * 1.5), 1)
	v_zoom = Lerp(_zoom_speed, v_zoom, _zoom_target)
        
        return pos, ang, fov - v_zoom
end

local blurmat = Material("pp/blurscreen")
local c_blur = 0

hook.Add("PreDrawViewModel", "UH_CleanupSubMaterials", function(vm, ply, wep)
        if not IsValid(wep) or not wep.GetClass then return end
        if string.find(wep:GetClass(), "weapon_uh_base") then return end
        -- wipe all submaterial overrides every frame
        for i = 0, #vm:GetMaterials() do
                vm:SetSubMaterial(i, "")
        end
end)

function SWEP:PreDrawViewModel()
    if self.Use2DScope and self:GetUHBool("Zooming") then
        render.SetBlend(0)
        return
    end

	-- Texture Hiding Stuff (This is how I got the c_hands to work)
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        local materials = vm:GetMaterials()
        -- Always clear first (prevents cross-weapon contamination)
        for i = 0, #materials do
            vm:SetSubMaterial(i, "")
        end
        -- Re-apply hidden materials if this weapon has any
        if self.HideMaterials then
            for index = 1, #materials do
                local material = materials[index]
                if self.HideMaterials[material] then
                    vm:SetSubMaterial(index - 1, "engine/occlusionproxy")
                end
            end
        end
    end

	-- Blur Logic
    if !GetConVar("uh_blur"):GetBool() then return end
    if self.ScopeBlur and self:GetUHBool("Zooming") or self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > CurTime() then
        c_blur = math.Approach( c_blur or 0, 1, FrameTime()*1.25 )
    else
        c_blur = math.Approach( c_blur or 0, 0, FrameTime() )
    end
    
    if c_blur > 0 then
        cam.Start2D()
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(blurmat)
            
            local b = GetConVar("uh_blur_amount"):GetInt()
            local w,h = ScrW(),ScrH()
            
            for i = 1, b do
                blurmat:SetFloat("$blur", i * c_blur)
                blurmat:Recompute()
                
                render.UpdateScreenEffectTexture()
                
                surface.DrawTexturedRect(0, 0, w, h)
            end
        cam.End2D()
    end
end

-- VM3D2D rendering system
-- Renders 3D2D billboards attached to viewmodel bones.
-- Called automatically by the engine via the PostDrawViewModel hook.
function SWEP:PostDrawViewModel(vm)
    if not self.VM3D2D then return end

    for name, elem in pairs(self.VM3D2D) do
        if not elem.bone or not elem.draw_func then continue end

        local boneIdx = vm:LookupBone(elem.bone)
        if not boneIdx then continue end

        local bonePos, boneAng = vm:GetBonePosition(boneIdx)
        if not bonePos then continue end

        -- Apply position offset in bone's local space
        local pos = Vector(bonePos)
        local ang = Angle(boneAng)

        pos = pos + ang:Right()   * (elem.pos and elem.pos.x or 0)
        pos = pos + ang:Forward() * (elem.pos and elem.pos.y or 0)
        pos = pos + ang:Up()      * (elem.pos and elem.pos.z or 0)

        ang:RotateAroundAxis(ang:Right(),   (elem.ang and elem.ang.p) or 0)
        ang:RotateAroundAxis(ang:Up(),      (elem.ang and elem.ang.y) or 0)
        ang:RotateAroundAxis(ang:Forward(), (elem.ang and elem.ang.r) or 0)

        cam.Start3D2D(pos, ang, elem.size or 0.004)
            elem.draw_func(self)
        cam.End3D2D()
    end
end

function SWEP:HUDShouldDraw( name )
    if GetConVar("uh_hud"):GetBool() and ( name == "CHudAmmo" or name == "CHudSecondaryAmmo" ) then return false end
    return true
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
        -- Borders
        y = y + 10
        x = x + 10
        wide = wide - 20
        tall = tall - 20
        
        if self.WorldModel and self.WorldModel != "" then
                if !IsValid(UHWeaponInfo) then
                        UHWeaponInfo = ClientsideModel( self.WorldModel, RENDER_GROUP_OPAQUE_ENTITY );
                        UHWeaponInfo:SetNoDraw( true );
                else
                        UHWeaponInfo:SetModel( self.WorldModel )
                        
                        local vec = Vector(48,48,48)
                        local ang = Vector(-48,-48,-48):Angle()
                        
                        cam.Start3D( vec, ang, 20, x, y+35, wide, tall, 5, 4096 )
                                cam.IgnoreZ( true )
                                render.SuppressEngineLighting( true )
                                
                                render.SetLightingOrigin( self:GetPos() )
                                render.ResetModelLighting( 50/255, 50/255, 50/255 )
                                render.SetColorModulation( 1, 1, 1 )
                                render.SetBlend( alpha/255 )
                                
                                render.SetModelLighting( 4, 1, 1, 1 )
                                
                                UHWeaponInfo:SetRenderAngles( Angle( 0, RealTime() * 30 % 360, 0 ) )
                                UHWeaponInfo:DrawModel()
                                UHWeaponInfo:SetRenderAngles()
                                
                                render.SetColorModulation( 1, 1, 1 )
                                render.SetBlend( 1 )
                                render.SuppressEngineLighting( false )
                                cam.IgnoreZ( false )
                        cam.End3D()
                end
        else
                surface.SetDrawColor( 255, 255, 255, alpha )
                surface.SetTexture( self.WepSelectIcon )

                surface.DrawTexturedRect( x, y, wide, tall )
        end
        
        if self.Primary.ClipSize > 0 then
                if self:Clip1()/self.Primary.ClipSize > 0.25 then
                        draw.SimpleText(self:Clip1().."/"..self.Owner:GetAmmoCount(self.Primary.Ammo), "HudSelectionText", x + wide/2, y + tall - 14, Color(255,230,0,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
                else
                        draw.SimpleText(self:Clip1().."/"..self.Owner:GetAmmoCount(self.Primary.Ammo), "HudSelectionText", x + wide/2, y + tall - 14, Color(255,0,0,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
                end
        end
end