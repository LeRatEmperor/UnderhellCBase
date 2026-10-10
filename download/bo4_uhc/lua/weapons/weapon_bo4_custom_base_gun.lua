-- weapon_bo4_custom_base_gun.lua
-- Black Ops 4: UHC base — inherits from weapon_custom_uh_base_gun.
-- v1.2 — added VElements, RT scopes, stencil reticles, bodygroups, blowback,
--         flashlight, laser, fast/ext mag reload, ElementRender hooks.
-- Category: "Black Ops 4: UHC"
-- Does NOT include mantling.

AddCSLuaFile()

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"

SWEP.PrintName  = "BO4 UHC Base"
SWEP.Category   = "Black Ops 4: UHC"
SWEP.Spawnable  = false
SWEP.AdminSpawnable = false

SWEP.Slot       = 2
SWEP.SlotPos    = 73
SWEP.HoldType   = "ar2"
SWEP.UseHands   = true
SWEP.ViewModelFOV = 65
SWEP.ViewModelFlip = false
SWEP.Weight     = 30
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.BO4Weapon          = true
SWEP.AnimatedSprint     = true
SWEP.ReloadSpeed        = 1
SWEP.Chambering         = true
SWEP.TwoHanded          = true

-- Melee bash (toggleable per-weapon)
SWEP.EnableMeleeBash    = true
SWEP.MeleeDamage        = 50
SWEP.MeleeRange         = 64
SWEP.MeleeDelay         = 0.6
SWEP.MeleeForce         = 300
SWEP.MeleeHitDelay       = 0.15
SWEP.MeleeViewPunch     = Angle(-5, 0, 0)
SWEP.MeleeSound         = "weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav"
SWEP.MeleeHitSound      = {"weapons/blackops3/rifle_butt/rifle_hit_00.wav", "weapons/blackops3/rifle_butt/rifle_hit_01.wav"}
SWEP.MeleeMissSound     = ""
SWEP.MeleeInterruptReload = true

-- Camera bone system
SWEP.CameraAttachments  = {"camera", "tag_camera"}
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraReserve      = false
SWEP.CameraOffset       = Angle(0, 0, 0)

-- Viewmodel offsets
SWEP.AlternativePos     = Vector(0, 0, 0)
SWEP.AlternativeAng     = Angle(0, 0, 0)
SWEP.LoweredPos         = Vector(0, 0, 0)
SWEP.LoweredAng         = Angle(0, 0, 0)
SWEP.SwayPosition       = 2.0

SWEP.BlowbackEnabled    = false
SWEP.BlowbackVector     = Vector(0, -2, 0)
SWEP.Blowback_Only_Iron = true

SWEP.MuzzleFlashType    = "particle"
SWEP.MuzzleFlashParticle = "muzzleflash_6"
SWEP.MuzzleFlashLightColor = Vector(0, 200, 255)
SWEP.MuzzleFlashLightSize = 128

SWEP.Animations = {}
SWEP.AnimSounds = {}

local bo4_camScale
if CLIENT then
    bo4_camScale = CreateClientConVar("bo4_camera_scale", "1.0", FCVAR_ARCHIVE, "BO4 camera bone animation scale")
end

function SWEP:Initialize()
    BaseClass.Initialize(self)
    self:SetHoldType(self.HoldType)
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

function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self.EnableMeleeBash and self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then
            self:MeleeAttack()
        end
        return
    end
    return BaseClass.PrimaryAttack(self)
end

function SWEP:MeleeAttack()
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()
    if not (sp or iftp) then return end
    self:SetUHBool("Zooming", false)
    if self:GetUHBool("Running") then self:SetUHBool("Running", false) end
    if self.MeleeInterruptReload ~= false and self:GetUHBool("Reloading") then
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        if timer.Exists("UHReload_"..self.Owner:SteamID()) then
            timer.Remove("UHReload_"..self.Owner:SteamID())
        end
    end
    self._meleeActive = true
    self:ClearAnimSounds()
    self:EasySendWeaponAnim("melee", ACT_VM_HITCENTER)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5
    self._meleeHitTime = ct + (self.MeleeHitDelay or 0.15)
    self._meleeHitDone = false
    self._meleeEndTime = ct + animDuration
    self._nextMelee = ct + (self.MeleeDelay or 0.6)
    self:SetNextPrimaryFire(ct + animDuration)
    self:SetNextSecondaryFire(ct + animDuration)
    self.NextReload = ct + animDuration
    local seqIdx = self.Owner:SelectWeightedSequence(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
    if seqIdx and seqIdx >= 0 then
        self.Owner:AddVCDSequenceToGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD, seqIdx, 0, true)
    end
    local snd = self.MeleeSound
    if istable(snd) then snd = snd[math.random(1, #snd)] end
    if snd and snd ~= "" then
        self:EmitSound(snd, 75, 100, 1, CHAN_USER_BASE)
    end
end

function SWEP:DoMeleeTrace()
    local ply = self.Owner
    if not IsValid(ply) then return end
    local pos = ply:GetShootPos()
    local aim = ply:GetAimVector()
    local range = self.MeleeRange or 64
    local tr = util.TraceHull({
        start = pos, endpos = pos + aim * range,
        filter = ply, mask = MASK_SHOT_HULL,
        mins = Vector(-10,-10,-10), maxs = Vector(10,10,10),
    })
    if tr.Hit then
        if IsValid(tr.Entity) and SERVER then
            local dmg = DamageInfo()
            dmg:SetDamage(self.MeleeDamage or 50)
            dmg:SetAttacker(ply)
            dmg:SetInflictor(self)
            dmg:SetDamageForce(aim * (self.MeleeForce or 300))
            dmg:SetDamagePosition(tr.HitPos)
            dmg:SetDamageType(DMG_CLUB)
            tr.Entity:TakeDamageInfo(dmg)
        end
        if SERVER then util.ScreenShake(tr.HitPos, 3, 0.1, 0.3, 32) end
        local hitSnd = self.MeleeHitSound
        if istable(hitSnd) then hitSnd = hitSnd[math.random(1, #hitSnd)] end
        if hitSnd and hitSnd ~= "" then
            self:EmitSound(hitSnd, 75, 100, 1, CHAN_USER_BASE)
        end
    else
        if self.MeleeMissSound and self.MeleeMissSound ~= "" then
            self:EmitSound(self.MeleeMissSound, 65, 100, 1, CHAN_USER_BASE)
        end
    end
    ply:ViewPunch(self.MeleeViewPunch or Angle(-3,0,0))
end

function SWEP:EndMelee()
    self._meleeActive = false
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self:ClearAnimSounds()
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._meleeActive then return end
    return BaseClass.Reload(self)
end

function SWEP:CalcView(ply, pos, ang, fov)
    if self.CameraAttachments then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            if not self._cameraAttResolved then
                self._cameraAttResolved = true
                self._cameraAttID = -1
                for _, name in ipairs(self.CameraAttachments) do
                    local id = vm:LookupAttachment(name)
                    if id and id > 0 then self._cameraAttID = id break end
                end
            end
            if self._cameraAttID and self._cameraAttID > 0 then
                local angpos = vm:GetAttachment(self._cameraAttID)
                if angpos then
                    local seq = vm:GetSequenceName(vm:GetSequence()) or ""
                    if not string.find(seq, "Fire") and not string.find(seq, "Idle") then
                        local off = vm:WorldToLocalAngles(angpos.Ang)
                        if self.CameraReserve then off:Mul(-1) end
                        for _, entry in pairs(self.CameraAttachmentOffsets or {}) do
                            if entry[1] == "p" then off.p = off.p + entry[2]
                            elseif entry[1] == "y" then off.y = off.y + entry[2]
                            elseif entry[1] == "r" then off.r = off.r + entry[2] end
                        end
                        if self.ViewModelFlip then off = Angle(0,0,0) end
                        off:Mul((bo4_camScale and bo4_camScale:GetFloat()) or 1.0)
                        if self.CameraOffset then ang:Add(self.CameraOffset) end
                        ang:Add(off)
                    end
                end
            end
        end
    end
    if BaseClass.CalcView then
        return BaseClass.CalcView(self, ply, pos, ang, fov)
    end
    return pos, ang, fov
end

function SWEP:Think()
    local ct = CurTime()
    if self._meleeActive and not self._meleeHitDone and self._meleeHitTime and ct >= self._meleeHitTime then
        self._meleeHitDone = true
        if SERVER or IsFirstTimePredicted() then self:DoMeleeTrace() end
    end
    if self._meleeActive and self._meleeEndTime and ct >= self._meleeEndTime then
        self:EndMelee()
    end
    BaseClass.Think(self)
    self:HandleSprintingAnimations()
end

function SWEP:HandleSprintingAnimations()
    if not self.AnimatedSprint then return end
    local ply = self.Owner
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local isRunning = self:GetUHBool("Running")
    local isReloading = self:GetUHBool("Reloading")
    if self.wasRunning == nil then self.wasRunning = false end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end
    if isRunning and not self.wasRunning then
        if not isReloading and not self._meleeActive then
            self:EasySendWeaponAnim("sprint_in", ACT_VM_IDLE_TO_LOWERED)
        end
    elseif not isRunning and self.wasRunning then
        if not isReloading and not self._meleeActive then
            self:EasySendWeaponAnim("sprint_out", ACT_VM_LOWERED_TO_IDLE)
        end
    elseif isRunning and not isReloading and not self._meleeActive then
        if vm:GetCycle() >= 1 then
            self:EasySendWeaponAnim("sprint_idle", ACT_VM_IDLE_LOWERED)
        end
    end
    self.wasRunning = isRunning
end

function SWEP:GetViewModelPosition(pos, ang)
    if BaseClass.GetViewModelPosition then
        pos, ang = BaseClass.GetViewModelPosition(self, pos, ang)
    end
    local ft = FrameTime()
    local target = 0
    if self:GetNWInt("FireMode") == 0 and not self:GetUHBool("Running") then target = 1 end
    self._uhLower = Lerp(ft * 8, self._uhLower or 0, target)
    if self._uhLower > 0.001 then
        local lp = self.LoweredPos or vector_origin
        local la = self.LoweredAng or angle_zero
        local ap, ay, ar = 0, 0, 0
        if isangle(la) then ap, ay, ar = la.p, la.y, la.r
        elseif isvector(la) then ap, ay, ar = la.x, la.y, la.z end
        ang:RotateAroundAxis(ang:Right(), ap * self._uhLower)
        ang:RotateAroundAxis(ang:Up(), ay * self._uhLower)
        ang:RotateAroundAxis(ang:Forward(), ar * self._uhLower)
        pos = pos + ang:Right() * lp.x * self._uhLower + ang:Forward() * lp.y * self._uhLower + ang:Up() * lp.z * self._uhLower
    end
    local targetAlt = 1
    if self:GetUHBool("Running") or self:GetUHBool("Zooming") or self:GetNWInt("FireMode") == 0 then targetAlt = 0 end
    self._altFactor = Lerp(ft * 10, self._altFactor or 0, targetAlt)
    if (self.AlternativePos or self.AlternativeAng) and self._altFactor > 0.01 then
        local ap = self.AlternativePos or vector_origin
        local aa = self.AlternativeAng or angle_zero
        pos = pos + ang:Right() * ap.x * self._altFactor + ang:Forward() * ap.y * self._altFactor + ang:Up() * ap.z * self._altFactor
        local ap_p, ap_y, ap_r = 0, 0, 0
        if isangle(aa) then ap_p, ap_y, ap_r = aa.p, aa.y, aa.r
        elseif isvector(aa) then ap_p, ap_y, ap_r = aa.x, aa.y, aa.z end
        ang:RotateAroundAxis(ang:Right(), ap_p * self._altFactor)
        ang:RotateAroundAxis(ang:Up(), ap_y * self._altFactor)
        ang:RotateAroundAxis(ang:Forward(), ap_r * self._altFactor)
    end
    return pos, ang
end

function SWEP:Deploy()
    BaseClass.Deploy(self)
    self:SetHoldType(self.HoldType)
    if self.Animations and self.Animations["deploy"] then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            self:EasySendWeaponAnim("deploy", ACT_VM_DRAW)
            local dur = vm:SequenceDuration()
            self:SetNextPrimaryFire(CurTime() + dur)
            self:SetNextSecondaryFire(CurTime() + dur)
            self.NextReload = CurTime() + dur
            self._deployEndTime = CurTime() + dur
            self:SetNWFloat("DeployTime", 0)
        end
    end
    self._meleeActive = nil
    self._meleeHitTime = nil
    self._meleeHitDone = nil
    self._meleeEndTime = nil
    self._nextMelee = nil
    self._cameraAttResolved = nil
    return true
end

function SWEP:Holster(wep)
    if self._meleeActive then
        self._meleeActive = false
        self._meleeHitTime = nil
        self._meleeHitDone = nil
        self._meleeEndTime = nil
        self:ClearAnimSounds()
    end
    self.wasZooming = false
    self.wasRunning = false
    return BaseClass.Holster(wep)
end

-- ============================================================
-- VELEMENTS RENDERING (enhanced — bonemerge, bodygroups, materials)
-- ============================================================
-- Overrides the base DrawVElements to support BO4's VElement format:
--   type = "Model", model = "path.mdl", bone = "bone_name",
--   pos = Vector(), ang = Angle(), scale = Vector(1,1,1),
--   material = "mat", skin = 0, bodygroups = {},
--   bonemerge = false, surpresslightning = false,
--   active = false, translucent = false

function SWEP:InitVElements()
    if not self.ViewModelElements then return end
    if self._vElementsInit then return end
    self._vElementsInit = true
    if CLIENT then
        for name, elem in pairs(self.ViewModelElements) do
            if elem.type == "Model" and elem.model and elem.model ~= "" then
                elem._csModel = ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)
                if IsValid(elem._csModel) then
                    elem._csModel:SetNoDraw(true)
                end
            end
        end
    end
end

function SWEP:DrawVElements(vm)
    if not self.ViewModelElements then return end
    if not self._vElementsInit then self:InitVElements() end

    for name, elem in pairs(self.ViewModelElements) do
        if not elem.active then continue end

        if elem.type == "Model" and IsValid(elem._csModel) then
            local model = elem._csModel
            local boneId = vm:LookupBone(elem.bone or "")
            if boneId then
                local bPos, bAng = vm:GetBonePosition(boneId)
                if bPos then
                    if elem.bonemerge then
                        model:SetParent(vm)
                        model:AddEffects(EF_BONEMERGE)
                    else
                        model:RemoveEffects(EF_BONEMERGE)
                        model:SetParent(NULL)
                        local pos = bPos
                        pos = pos + bAng:Right() * (elem.pos and elem.pos.x or 0)
                        pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                        pos = pos + bAng:Up() * (elem.pos and elem.pos.z or 0)
                        local ang = Angle(bAng)
                        ang:RotateAroundAxis(ang:Right(), (elem.ang and elem.ang.p) or 0)
                        ang:RotateAroundAxis(ang:Up(), (elem.ang and elem.ang.y) or 0)
                        ang:RotateAroundAxis(ang:Forward(), (elem.ang and elem.ang.r) or 0)
                        model:SetPos(pos)
                        model:SetAngles(ang)
                    end

                    local scale = elem.scale or Vector(1,1,1)
                    model:SetModelScale(scale.x, 0)
                    if elem.material then model:SetMaterial(elem.material) end
                    if elem.skin then model:SetSkin(elem.skin) end
                    if elem.bodygroups then
                        for bg, val in pairs(elem.bodygroups) do
                            model:SetBodygroup(bg, val)
                        end
                    end

                    if elem.surpresslightning then
                        render.SuppressEngineLighting(true)
                    end
                    model:DrawModel()
                    if elem.surpresslightning then
                        render.SuppressEngineLighting(false)
                    end
                end
            end
        elseif elem.type == "Sprite" then
            local boneId = vm:LookupBone(elem.bone or "")
            if boneId then
                local bPos, bAng = vm:GetBonePosition(boneId)
                if bPos then
                    local pos = bPos
                    pos = pos + bAng:Right() * (elem.pos and elem.pos.x or 0)
                    pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                    pos = pos + bAng:Up() * (elem.pos and elem.pos.z or 0)
                    if elem.material then
                        render.SetMaterial(Material(elem.material))
                        local size = elem.size or 4
                        render.DrawSprite(pos, size, size, Color(255,255,255,255))
                    end
                end
            end
        end
    end
end

-- ============================================================
-- ELEMENT RENDER HOOKS (for stencil reticles, HBS radar, etc.)
-- ============================================================
SWEP.ElementRender = {}
SWEP.ElementRenderWorld = {}

function SWEP:PostDrawViewModel(vm)
    -- Draw VElements
    if self.ViewModelElements then
        self:DrawVElements(vm)
    end

    -- Call ElementRender hooks (stencil reticles, HBS, etc.)
    for name, func in pairs(self.ElementRender or {}) do
        if isfunction(func) then
            func(self, vm)
        end
    end
end

-- ============================================================
-- RT SCOPE SYSTEM
-- ============================================================
-- Supports: SWEP.RTCode(self, rt, scrw, scrh), SWEP.RTScopeAttachment,
-- SWEP.RTScopeFOV, SWEP.RTMaterialOverride, SWEP.RTOpaque, SWEP.Scoped_3D

function SWEP:DoRTScope()
    if not self.RTCode then return end
    if not self:GetUHBool("Zooming") then return end

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end

    -- Get the RT material index on the viewmodel
    local rtMat = self.RTMaterialOverride
    if not rtMat or rtMat < 1 then return end

    -- Create or get the render target
    if not self._rtTexture then
        self._rtTexture = GetRenderTarget("BO4UH_ScopeRT_" .. self:EntIndex(), 1024, 1024, false)
        if not self._rtTexture then return end
    end

    -- Render the scope view into the RT
    local attID = self.RTScopeAttachment or 1
    local scopeFOV = self.RTScopeFOV or 8

    render.PushRenderTarget(self._rtTexture, 0, 0, 1024, 1024)
    local ang = self.Owner:EyeAngles()
    local pos = self.Owner:EyePos()
    render.RenderView({
        x = 0, y = 0, w = 1024, h = 1024,
        origin = pos, angles = ang,
        drawviewmodel = false, drawhud = false,
        dopostprocess = false, fov = scopeFOV,
    })
    render.PopRenderTarget()

    -- Apply RT to the viewmodel material
    local mat = vm:GetMaterials()
    if mat and mat[rtMat] then
        local rtMatObj = Material(mat[rtMat])
        if rtMatObj then
            rtMatObj:SetTexture("$basetexture", self._rtTexture)
        end
    end

    -- Call the weapon's custom RTCode for overlays (thermal, dirt, etc.)
    self:RTCode(self._rtTexture, ScrW(), ScrH())
end

function SWEP:PreDrawViewModel()
    BaseClass.PreDrawViewModel(self)
    if self.RTCode and self:GetUHBool("Zooming") then
        self:DoRTScope()
    end
end

-- ============================================================
-- BODYGROUP SYSTEM
-- ============================================================
-- Supports: SWEP.Bodygroups_V = { [index] = value },
--           SWEP.Bodygroups_W = { [index] = value }
-- Applied to viewmodel in HandleBones, worldmodel in DrawWorldModel

SWEP.Bodygroups_V = {}
SWEP.Bodygroups_W = {}

function SWEP:ApplyBodygroupsVM(vm)
    if not IsValid(vm) then return end
    for bg, val in pairs(self.Bodygroups_V or {}) do
        vm:SetBodygroup(bg, val)
    end
end

function SWEP:HandleBones(vm, ct)
    BaseClass.HandleBones(self, vm, ct)
    self:ApplyBodygroupsVM(vm)
end

-- ============================================================
-- CHOOSE RELOAD ANIM — fast/ext mag support
-- ============================================================
-- Reads EnableFastMags / EnableExtMags (set by attachments)
-- to pick reload_quick / reload_ext sequence variants.

function SWEP:ChooseReloadAnim()
    local isEmpty = self:Clip1() <= 0
    local animKey = isEmpty and "reload_empty" or "reload"

    -- Check for fast/ext mag variants
    if self.EnableFastMags and self.Animations then
        if isEmpty and self.Animations["reload_empty_quick"] then
            animKey = "reload_empty_quick"
        elseif not isEmpty and self.Animations["reload_quick"] then
            animKey = "reload_quick"
        end
    elseif self.EnableExtMags and self.Animations then
        if isEmpty and self.Animations["reload_empty_ext"] then
            animKey = "reload_empty_ext"
        elseif not isEmpty and self.Animations["reload_ext"] then
            animKey = "reload_ext"
        end
    end

    return animKey
end

-- Override the base Reload to use ChooseReloadAnim
function SWEP:Reload()
    if self._meleeActive then return end
    local ct = CurTime()
    if not IsValid(self.Owner) then return end

    if self.NextReload < ct and not self:GetUHBool("Running") and not self:GetUHBool("Reloading")
       and not self.Owner:KeyDown(IN_USE)
       and self.Owner:GetNWFloat("UH_GrenadeTime") < ct
       and self:GetNWFloat("DeployTime") < ct then

        if self:Clip1() < (self.Chambering and self.Primary.ClipSize + 1 or self.Primary.ClipSize)
           and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then

            if SERVER then self.Owner:SetAnimation(PLAYER_RELOAD) end
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end

            self:PreReload()

            -- Pick reload animation using our enhanced chooser
            local reloadKey = self:ChooseReloadAnim()
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil

            if self.Animations and self.Animations[reloadKey] then
                self:EasySendWeaponAnim(reloadKey, ACT_VM_RELOAD)
            else
                self:EasySendWeaponAnim(isEmpty and "reload_empty" or "reload", ACT_VM_RELOAD)
            end

            local AnimTime = self.ReloadTime or (IsValid(vm) and vm:SequenceDuration() or 2)
            local speed = self.ReloadSpeed or 1
            if speed ~= 1 then
                AnimTime = AnimTime / speed
                if IsValid(vm) then vm:SetPlaybackRate(speed) end
            else
                if IsValid(vm) then vm:SetPlaybackRate(1) end
            end

            self._reloadFinished = false
            self._reloadEndTime = ct + AnimTime
            self.NextReload = ct + AnimTime + 0.5
            self:SetNextPrimaryFire(ct + AnimTime)
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
            self:SetNWFloat("ReloadTime", AnimTime)
            self:SetNWFloat("ReloadEndTime", ct + AnimTime)

            -- AnimSounds
            if reloadKey then self:SetupAnimSounds(reloadKey) end
        end
    end
end

-- ============================================================
-- ATTACHMENT SUPPORT — SightBGs, MagBGs, stat flags
-- ============================================================
-- These are called by the attachment system's Attach/Detach hooks.
-- The attachments set fields like:
--   wep.Bodygroups_V[sightMain] = sightNone
--   wep.EnableFastMags = true
--   wep.EnableExtMags = true
--   wep.Primary.ClipSize = wep.Primary.ClipSizeExt

-- Override ApplyAttachments to also handle bodygroup swaps
local BaseApplyAttachments = SWEP.ApplyAttachments
function SWEP:ApplyAttachments()
    if BaseApplyAttachments then BaseApplyAttachments(self) end

    -- Apply SightBGs (bodygroup swap for optics)
    if self.SightBGs then
        local main = self.SightBGs.main
        local current = self._currentSightBG or self.SightBGs.regular or 0
        if main then
            self.Bodygroups_V = self.Bodygroups_V or {}
            self.Bodygroups_V[main] = current
            self.Bodygroups_W = self.Bodygroups_W or {}
            self.Bodygroups_W[main] = current
        end
    end

    -- Apply MagBGs (bodygroup swap for magazines)
    if self.MagBGs then
        local main = self.MagBGs.main
        local current = self.MagBGs.regular or 0
        if self._currentMagBG then
            current = self._currentMagBG
        end
        if main then
            self.Bodygroups_V = self.Bodygroups_V or {}
            self.Bodygroups_V[main] = current
            self.Bodygroups_W = self.Bodygroups_W or {}
            self.Bodygroups_W[main] = current
        end
    end
end

-- Helper for attachments to set sight bodygroup
function SWEP:SetSightBodygroup(value)
    if not self.SightBGs then return end
    self._currentSightBG = value
    if self.SightBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.SightBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.SightBGs.main] = value
    end
    self:ApplyAttachments()
end

-- Helper for attachments to set mag bodygroup
function SWEP:SetMagBodygroup(value)
    if not self.MagBGs then return end
    self._currentMagBG = value
    if self.MagBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.MagBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.MagBGs.main] = value
    end
    self:ApplyAttachments()
end

-- ============================================================
-- DRAW WORLD MODEL — procedural placement
-- ============================================================
if CLIENT then
    function SWEP:DrawWorldModel()
        local owner = self:GetOwner()
        if IsValid(owner) then
            local offsetVec = self.Offset and self.Offset.Pos and Vector(
                self.Offset.Pos.Forward or 0,
                self.Offset.Pos.Right or 0,
                self.Offset.Pos.Up or 0
            ) or Vector(4, -2, 2)
            local offsetAng = self.Offset and self.Offset.Ang and Angle(
                self.Offset.Ang.Pitch or 0,
                self.Offset.Ang.Yaw or 0,
                self.Offset.Ang.Roll or 0
            ) or Angle(180, 180, 0)

            local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
            if boneid then
                local matrix = owner:GetBoneMatrix(boneid)
                if matrix then
                    local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
                    self:SetRenderPos(newPos)
                    self:SetRenderAngles(newAng)
                    -- Apply world bodygroups
                    for bg, val in pairs(self.Bodygroups_W or {}) do
                        self:SetBodygroup(bg, val)
                    end
                end
            end
            self:DrawModel()

            -- Call ElementRenderWorld hooks
            for name, func in pairs(self.ElementRenderWorld or {}) do
                if isfunction(func) then func(self) end
            end
        else
            self:DrawModel()
        end
    end
end

-- ============================================================
-- FLASHLIGHT SUPPORT
-- ============================================================
-- Supports: SWEP.EnableFlashlight, SWEP.FlashlightAttachment
-- Drawn as a ProjectedTexture attached to the viewmodel muzzle

SWEP.EnableFlashlight = false
SWEP.FlashlightAttachment = 1
SWEP.FlashlightAttachmentWorld = 1
SWEP.FlashlightDistance = 2048
SWEP.FlashlightBrightness = 2
SWEP.FlashlightFOV = 60
SWEP.FlashlightTexture = "effects/flashlight001"
SWEP.FlashlightColor = Color(255, 255, 255)

function SWEP:ToggleFlashlight(on)
    if on == nil then on = not (self._flashlightOn or false) end
    self._flashlightOn = on

    if on then
        if not IsValid(self._flashlightLamp) then
            self._flashlightLamp = ProjectedTexture()
            self._flashlightLamp:SetTexture(self.FlashlightTexture)
            self._flashlightLamp:SetFarZ(self.FlashlightDistance)
            self._flashlightLamp:SetFOV(self.FlashlightFOV)
            self._flashlightLamp:SetBrightness(self.FlashlightBrightness)
            self._flashlightLamp:SetColor(self.FlashlightColor)
        end
    else
        if IsValid(self._flashlightLamp) then
            self._flashlightLamp:Remove()
            self._flashlightLamp = nil
        end
    end
end

function SWEP:UpdateFlashlight(vm)
    if not self.EnableFlashlight then return end
    if not self._flashlightOn then return end
    if not IsValid(self._flashlightLamp) then return end

    local attID = self.FlashlightAttachment or 1
    local att = vm:GetAttachment(attID)
    if att then
        self._flashlightLamp:SetPos(att.Pos)
        self._flashlightLamp:SetAngles(att.Ang)
        self._flashlightLamp:Update()
    end
end

-- Hook flashlight update into PreDrawViewModel
local BO4_PreDrawVM = SWEP.PreDrawViewModel
function SWEP:PreDrawViewModel()
    BO4_PreDrawVM(self)
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        self:UpdateFlashlight(vm)
    end
end

-- ============================================================
-- LASER SIGHT SUPPORT
-- ============================================================
-- Supports: SWEP.EnableLaser, SWEP.LaserSightAttachment
-- Draws a laser dot at the trace hit position

SWEP.EnableLaser = false
SWEP.LaserSightAttachment = 1
SWEP.LaserSightAttachmentWorld = 1

function SWEP:DrawLaserDot()
    if not self.EnableLaser then return end
    if not CLIENT then return end
    if not IsValid(self.Owner) then return end

    local vm = self.Owner:GetViewModel()
    if not IsValid(vm) then return end

    local attID = self.LaserSightAttachment or 1
    local att = vm:GetAttachment(attID)
    if not att then return end

    local start = att.Pos
    local dir = self.Owner:GetAimVector()
    local tr = util.TraceLine({
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + dir * 3000,
        filter = self.Owner,
        mask = MASK_SOLID,
    })

    if tr.Hit then
        local mat = Material("effects/laser1")
        render.SetMaterial(mat)
        local size = 4
        local col = Color(255, 0, 0, 255)
        -- Laser dot
        render.DrawSprite(tr.HitPos, size, size, col)
        -- Laser beam (thin line from muzzle to hit)
        render.DrawBeam(start, tr.HitPos, 1, 0, 1, col)
    end
end

-- Hook laser into PostDrawViewModel
local BO4_PostDrawVM = SWEP.PostDrawViewModel
function SWEP:PostDrawViewModel(vm)
    BO4_PostDrawVM(self, vm)
    self:DrawLaserDot()
end

-- ============================================================
-- BLOWBACK SYSTEM
-- ============================================================
-- Supports: SWEP.BlowbackEnabled, SWEP.BlowbackVector,
-- SWEP.Blowback_Only_Iron, SWEP.BlowbackBoneMods
-- Applies bone position offset on fire, returns to rest over time

SWEP._blowbackCurrent = 0

function SWEP:UpdateBlowback(vm)
    if not self.BlowbackEnabled then return end
    if not IsValid(vm) then return end

    local ft = FrameTime()
    local target = 0

    -- Only apply blowback when aimed (if Blowback_Only_Iron)
    local isAimed = self:GetUHBool("Zooming")
    if not self.Blowback_Only_Iron or isAimed then
        -- Check if we recently fired
        local timeSinceShot = CurTime() - (self:GetNWFloat("LastRecoilTime") or 0)
        if timeSinceShot < 0.05 then
            target = 1
        end
    end

    self._blowbackCurrent = Lerp(ft * 20, self._blowbackCurrent or 0, target)

    if self._blowbackCurrent > 0.01 and self.BlowbackBoneMods then
        local bbv = self.BlowbackVector or Vector(0, 0, 0)
        local amt = self._blowbackCurrent
        for bone, mods in pairs(self.BlowbackBoneMods) do
            local boneId = vm:LookupBone(bone)
            if boneId then
                if mods.pos then
                    local pos = Vector(bbv.x * amt, bbv.y * amt, bbv.z * amt)
                    if mods.pos.x then pos.x = pos.x + mods.pos.x * amt end
                    if mods.pos.y then pos.y = pos.y + mods.pos.y * amt end
                    if mods.pos.z then pos.z = pos.z + mods.pos.z * amt end
                    vm:ManipulateBonePosition(boneId, pos)
                end
                if mods.ang then
                    vm:ManipulateBoneAngles(boneId, Angle(
                        (mods.ang.p or 0) * amt,
                        (mods.ang.y or 0) * amt,
                        (mods.ang.r or 0) * amt
                    ))
                end
            end
        end
    else
        -- Reset bone positions when blowback is at rest
        if self.BlowbackBoneMods then
            for bone, _ in pairs(self.BlowbackBoneMods) do
                local boneId = vm:LookupBone(bone)
                if boneId then
                    vm:ManipulateBonePosition(boneId, Vector(0, 0, 0))
                    vm:ManipulateBoneAngles(boneId, Angle(0, 0, 0))
                end
            end
        end
    end
end

-- Hook blowback into Think
local BO4_Think = SWEP.Think
function SWEP:Think()
    BO4_Think(self)
    if CLIENT then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            self:UpdateBlowback(vm)
        end
    end
end

-- ============================================================
-- HOLSTER — cleanup flashlight, RT
-- ============================================================
local BO4_Holster = SWEP.Holster
function SWEP:Holster(wep)
    self:ToggleFlashlight(false)
    if BO4_Holster then return BO4_Holster(self, wep) end
    return BaseClass.Holster(self, wep)
end

-- ============================================================
-- DEPLOY — reset attachment state
-- ============================================================
local BO4_Deploy = SWEP.Deploy
function SWEP:Deploy()
    local r = BO4_Deploy(self)
    self:ApplyAttachments()
    return r
end
