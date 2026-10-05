-- weapon_cuh_base_gun.lua
-- Customization UnderHell Base — Gun
-- CUH BUILD: v0.5.4-camera-bone-diag (2026-10-02)
-- ============================================================
-- Third base layer that adds attachment customization to the
-- Underhell Custom gun base. Inherits from weapon_custom_uh_base_gun.
--
-- All SWEP: methods are defined HERE (in the weapon file itself)
-- — NOT in external includes or autorun patchers. This is the
-- key design principle that makes it work reliably in GMod.
--
-- Non-customizable weapons inherit from weapon_custom_uh_base_gun.
-- Customizable weapons inherit from weapon_cuh_base_gun.
-- ============================================================

AddCSLuaFile()

print("[CUH] weapon_cuh_base_gun.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

DEFINE_BASECLASS("weapon_custom_uh_base_gun")
SWEP.Base = "weapon_custom_uh_base_gun"

SWEP.PrintName  = "CUH Gun Base"
SWEP.Category   = "UnderHell Custom"
SWEP.Spawnable  = false
SWEP.AdminSpawnable = false

-- Explicit marker so the customization menu (cl_cuh_ui.lua) can detect
-- CUH-derived weapons in O(1) without walking the Base chain. This avoids
-- the previous false-positive where TFA weapons (which also define
-- SetAttachment) opened the CUH menu.
SWEP.IsCUHWeapon = true

-- ============================================================
-- DEFAULT ATTACHMENT SYSTEM
-- ============================================================
-- A slot can define a `default` index. When no attachment is
-- selected (sel == nil), the default is auto-applied.
-- Use forceDefault = true to prevent selecting "None".
--
--   SWEP.Attachments = {
--       [1] = { atts = { "opt_red", "opt_acog" }, default = 1 },
--       [2] = { atts = { "mag_fast" } },  -- no default
--       [3] = { atts = { "grip_v" }, default = 1, forceDefault = true },
--   }
-- ============================================================

function SWEP:GetEffectiveAttachment(slot)
    if not self.Attachments or not self.Attachments[slot] then return 0 end
    local slotData = self.Attachments[slot]
    local sel = slotData.sel

    if sel == nil then
        if slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    if sel == 0 then
        if slotData.forceDefault and slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    return sel
end

-- ============================================================
-- STAT CACHE SYSTEM
-- ============================================================
-- Tracks original weapon values so attachments can modify them
-- and be cleanly removed.
--
-- Note: Functions in ATTACHMENT.WeaponTable are evaluated by
-- ApplyAttachments (in this file), not by the cache itself.
-- ============================================================

function SWEP:Initialize()
    BaseClass.Initialize(self)
    -- Apply default attachments on init. Deferred to next tick so the
    -- viewmodel entity exists on the client (needed by InitVElements
    -- to create ClientsideModels).
    timer.Simple(0, function()
        if IsValid(self) and self.ApplyAttachments then
            self:ApplyAttachments()
        end
    end)
end

-- ============================================================
-- CAMERA BONE SYSTEM (BO3-style procedural camera animation)
-- ============================================================
-- This is a direct port of the proven working BO3 base implementation.
-- Weapons declare:
--   SWEP.CameraAttachment = "Camera"        -- $attachment name on VM
--   SWEP.CameraReserve    = false            -- invert the angle
--   SWEP.CameraOffset     = Angle(0,0,0)     -- extra angle offset
--
-- When CameraAttachment is nil/empty, the system does nothing.
--
-- ConVar: cl_cuh_camera_scale (default 1.0) — player-adjustable
-- intensity multiplier. 0 = off, 1 = full BO3 intensity.
-- ============================================================
if CLIENT then
    CUH_CAMERA_SCALE = CreateClientConVar("cl_cuh_camera_scale", "1.0", true, false,
        "CUH camera bone animation scale (0 = off, 1 = full BO3 intensity)")
end

function SWEP:CalcView(ply, pos, ang, fov)
    -- Camera bone angle tracking — applied to the PLAYER'S VIEW
    if self.CameraAttachment and self.CameraAttachment ~= "" then
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        if IsValid(vm) then
            local seq = self.m_CurrentSequence or vm:GetSequenceName(vm:GetSequence()) or ""
            if not string.find(seq, "Fire") and not string.find(seq, "Idle") then
                local attID = vm:LookupAttachment(self.CameraAttachment)
                if attID and attID > 0 then
                    local att = vm:GetAttachment(attID)
                    if att then
                        if self.CameraOffset then
                            ang:Add(self.CameraOffset)
                        end
                        local localAng = vm:WorldToLocalAngles(att.Ang)
                        if self.CameraReserve then
                            localAng:Mul(-1)
                        end
                        local scale = (CLIENT and CUH_CAMERA_SCALE and CUH_CAMERA_SCALE:GetFloat()) or 1
                        localAng:Mul(scale)
                        ang:Add(localAng)
                    end
                end
            end
        end
    end

    -- Pass to parent base for view bobbing and FOV zoom
    if BaseClass.CalcView then
        return BaseClass.CalcView(self, ply, pos, ang, fov)
    end
    return pos, ang, fov
end

-- ============================================================
-- WALK/JOG/SPRINT ANIMATION SYSTEM (pose-parameter driven)
-- ============================================================
-- Drives the viewmodel's walk_loop, jog_loop, and sprint_loop pose
-- parameters based on player velocity. This is a BLEND LAYER — it
-- doesn't play or stop any sequences, so it never interrupts fire,
-- reload, inspect, idle, or any other animation. The gun just bobs
-- and sways as you move, on top of whatever else is happening.
--
-- The M8A1/XM4 models have these delta blend sequences:
--   walk_loop  — slow walk bob (blend 0=static, 1=full walk)
--   jog_loop   — jog bob (blend 0=static, 1=full jog)
--   sprint_loop — sprint bob (blend 0=static, 1=full sprint)
--
-- Velocity thresholds (in Hammer units / second):
--   0    – walkSpeed * 0.3  → idle (all pose params = 0)
--   0.3x – 1.2x walkSpeed    → walk (walk_loop ramps up)
--   1.2x – sprintThreshold    → jog (jog_loop ramps up, walk fades)
--   sprintThreshold+         → sprint (sprint_loop ramps up, jog fades)
--
-- Weapons can disable this by setting:
--   SWEP.UseWalkAnims = false
-- Weapons can tune thresholds:
--   SWEP.WalkAnimSpeed = 0.3   (fraction of walkSpeed where walk starts)
--   SWEP.JogAnimSpeed = 1.2   (fraction of walkSpeed where jog starts)
--   SWEP.SprintAnimSpeed = 1.8 (fraction of walkSpeed where sprint starts)
-- ============================================================
function SWEP:HandleWalkAnims(vm)
    if not IsValid(vm) then return end
    if self.UseWalkAnims == false then return end
    local ply = self.Owner
    if not IsValid(ply) or not ply:IsPlayer() then return end

    -- Don't drive walk anims while ironsighting or sprinting (sprint has its own system)
    -- Actually, we SHOULD drive sprint_loop here since the sprint animation
    -- system in the weapon files plays sprint_in/sprint_out/sprint_idle.
    -- The sprint_loop pose param is a blend layer on top of sprint_idle.
    -- So we drive all three based on velocity, but suppress during ironsights.

    local isZooming = self.GetUHBool and self:GetUHBool("Zooming")
    local isReloading = self.GetUHBool and self:GetUHBool("Reloading")
    local isRunning = self.GetUHBool and self:GetUHBool("Running")

    -- Target values for each pose parameter (0-1)
    local targetWalk = 0
    local targetJog = 0
    local targetSprint = 0

    if not isZooming and not isReloading then
        local vel = ply:GetVelocity()
        local velLen = vel:Length()
        local walkSpeed = ply:GetWalkSpeed()
        local walkThreshold = walkSpeed * (self.WalkAnimSpeed or 0.3)
        local jogThreshold = walkSpeed * (self.JogAnimSpeed or 1.2)
        local sprintThreshold = walkSpeed * (self.SprintAnimSpeed or 1.8)

        if velLen > walkThreshold then
            if isRunning then
                -- Sprinting — drive sprint_loop
                targetSprint = math.Clamp((velLen - jogThreshold) / (sprintThreshold - jogThreshold), 0, 1)
                -- Also ramp jog down as sprint ramps up
                targetJog = 1 - targetSprint
            elseif velLen > jogThreshold then
                -- Jogging — drive jog_loop
                targetJog = math.Clamp((velLen - jogThreshold) / (sprintThreshold - jogThreshold), 0, 1)
                targetWalk = 1 - targetJog * 0.5
            else
                -- Walking — drive walk_loop
                targetWalk = math.Clamp((velLen - walkThreshold) / (jogThreshold - walkThreshold), 0, 1)
            end
        end
    end

    -- Smooth the pose parameter changes (lerp toward target)
    -- Speed 8 = smooth but responsive (~0.1s to reach target)
    local ft = FrameTime()
    local lerpSpeed = 8
    self._walkBlend = Lerp(ft * lerpSpeed, self._walkBlend or 0, targetWalk)
    self._jogBlend = Lerp(ft * lerpSpeed, self._jogBlend or 0, targetJog)
    self._sprintBlend = Lerp(ft * lerpSpeed, self._sprintBlend or 0, targetSprint)

    -- Apply to the viewmodel's pose parameters
    -- SetPoseParameter is cheap and doesn't interfere with sequences
    vm:SetPoseParameter("walk_loop", self._walkBlend)
    vm:SetPoseParameter("jog_loop", self._jogBlend)
    vm:SetPoseParameter("sprint_loop", self._sprintBlend)
end

-- Hook into PreDrawViewModel to drive walk anims every frame.
-- PreDrawViewModel is called right before the viewmodel is rendered,
-- AFTER bone setup but BEFORE drawing. This is the correct place to
-- set pose parameters so they affect the current frame's render.
if CLIENT then
    hook.Add("PreDrawViewModel", "CUH2_WalkAnims", function(vm, ply, wep)
        if not IsValid(wep) or not wep.IsCUHWeapon then return end
        if not IsValid(vm) then return end
        if wep.HandleWalkAnims then
            wep:HandleWalkAnims(vm)
        end
    end)
end

-- NOTE: Do NOT override Deploy here — the M8A1 weapon file has its own
-- Deploy override that calls BaseClass.Deploy(self), and overriding it
-- here would interfere with the deploy/reload state machine (broke
-- reloading in a previous attempt). ApplyAttachments is called from
-- Initialize above, and from the PlayerSwitchWeapon hook in
-- sh_cuh_attachments.lua.

-- ============================================================
-- Stat cache is initialized lazily on first access (GetStat/SetStat)
-- OR when ApplyAttachments runs. Both paths funnel through InitStatCache.
--
-- IMPORTANT: the per-instance table.Copy(self.Primary) MUST happen inside
-- InitStatCache (not in a separate InitStatCacheIfNeeded helper). The
-- previous design had the copy in a separate helper that ApplyAttachments
-- bypassed by calling self:InitStatCache() directly — that left
-- self.Primary pointing at the CLASS table, so attachment SetStat calls
-- mutated the class table and bled state across every weapon of the
-- same class (visible as fire-delay / fire-timing "stutter" because
-- Primary.Delay was being clobbered on the shared class table).
-- ============================================================
function SWEP:InitStatCache()
    if self._statCache then return end

    -- Copy Primary/Secondary per-instance so attachment stat
    -- modifications don't bleed across weapons of the same class.
    -- Done here (not in Initialize) so the parent base's init still
    -- sees the original shared class table during its own setup.
    self.Primary   = table.Copy(self.Primary   or {})
    self.Secondary = table.Copy(self.Secondary or {})

    -- Copy Animations per-instance AND snapshot the origin so attachments
    -- can override anim keys (e.g. magazine swapping reload -> reload_ext02)
    -- and we can restore them on detach.
    self.Animations = table.Copy(self.Animations or {})
    self._animationsOrigin = table.Copy(self.Animations)

    -- AnimSounds likewise — mag swaps may want different reload sounds.
    if self.AnimSounds then
        self.AnimSounds = table.Copy(self.AnimSounds)
        self._animSoundsOrigin = table.Copy(self.AnimSounds)
    end

    self._statCache = {}
    self._statOrigins = {}

    -- Cache Primary table
    for k, v in pairs(self.Primary or {}) do
        self._statCache["Primary." .. k] = v
        self._statOrigins["Primary." .. k] = v
    end

    -- Cache Secondary table
    for k, v in pairs(self.Secondary or {}) do
        self._statCache["Secondary." .. k] = v
        self._statOrigins["Secondary." .. k] = v
    end

    -- Cache top-level fields (NOT Primary.* or Secondary.* —
    -- those are already cached by the loops above)
    local topLevel = {
        "DamageGeneric", "Num", "FireRate", "Spread", "SpreadIronsighted",
        "ViewSlideRecoilUp", "ViewSlideRecoilRight", "ZoomFov",
        "IronsightSpeed", "IronsightEaseIn", "ZoomSpeedIn", "ZoomSpeedOut",
        "IronSightTime", "MoveSpeed", "IronRecoilMultiplier",
    }
    for _, key in ipairs(topLevel) do
        if string.find(key, "%.") then
            local tbl, field = string.match(key, "(.+)%.(.+)")
            if self[tbl] and self[tbl][field] ~= nil then
                self._statCache[key] = self[tbl][field]
                self._statOrigins[key] = self[tbl][field]
            end
        else
            if self[key] ~= nil then
                self._statCache[key] = self[key]
                self._statOrigins[key] = self[key]
            end
        end
    end

    -- Cache IronSights positions
    if self.IronSightsPos then
        self._statCache["IronSightsPos"] = self.IronSightsPos
        self._statOrigins["IronSightsPos"] = self.IronSightsPos
    end
    if self.IronSightsAng then
        self._statCache["IronSightsAng"] = self.IronSightsAng
        self._statOrigins["IronSightsAng"] = self.IronSightsAng
    end

    self._statDirty = false
end

function SWEP:GetStat(path)
    if not self._statCache then self:InitStatCache() end
    return self._statCache[path]
end

function SWEP:SetStat(path, value)
    if not self._statCache then self:InitStatCache() end
    self._statCache[path] = value
    -- Eager write: immediately update the actual SWEP field
    if string.find(path, "%.") then
        local tbl, field = string.match(path, "(.+)%.(.+)")
        if self[tbl] then self[tbl][field] = value end
    else
        self[path] = value
    end
end

function SWEP:RestoreStat(path)
    if not self._statOrigins then return end
    local origin = self._statOrigins[path]
    if origin ~= nil then self:SetStat(path, origin) end
end

-- Write cached stats back to actual SWEP fields
function SWEP:FlushStats()
    if not self._statCache or not self._statDirty then return end

    for path, value in pairs(self._statCache) do
        if string.find(path, "%.") then
            local tbl, field = string.match(path, "(.+)%.(.+)")
            if self[tbl] then self[tbl][field] = value end
        else
            self[path] = value
        end
    end

    self._statDirty = false
end

-- ============================================================
-- VELEMENT SYSTEM — Viewmodel attachment models
-- ============================================================

function SWEP:InitVElements()
    if not self.ViewModelElements then return end
    if self._vElementsInit then return end
    self._vElementsInit = true

    if CLIENT then
        for name, elem in pairs(self.ViewModelElements) do
            if elem._defaultActive == nil then
                elem._defaultActive = elem.active or false
            end
            -- Snapshot the full element state so ApplyAttachments
            -- can restore model, bodygroups, skin, material, etc.
            -- (not just the active flag) when an attachment is removed.
            if elem._defaultSnapshot == nil then
                local snap = table.Copy(elem)
                snap._defaultSnapshot = nil
                snap._csModel = nil
                elem._defaultSnapshot = snap
            end
            if elem.type == "Model" and elem.model and elem.model ~= "" then
                elem._csModel = ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)
                if IsValid(elem._csModel) then
                    elem._csModel:SetNoDraw(true)
                    if elem.skin then elem._csModel:SetSkin(elem.skin) end
                    if elem.bodygroups then
                        for bg, val in pairs(elem.bodygroups) do
                            elem._csModel:SetBodygroup(bg, val)
                        end
                    end
                    if elem.material and elem.material ~= "" then
                        elem._csModel:SetMaterial(elem.material)
                    end
                end
            end
        end
    end
end

function SWEP:DrawVElements(vm)
    if not self.ViewModelElements then return end
    if not self._vElementsInit then self:InitVElements() end

    -- CRITICAL: Apply viewmodel bodygroups EVERY FRAME.
    -- The viewmodel (v_scotia.mdl) has the default barrel/stock/mag/pgrip
    -- baked into its mesh. Without setting bodygroups to hide them, BOTH
    -- the viewmodel's default parts AND the VElement attachment models
    -- are visible at the same time — causing z-fighting/overlap that
    -- makes it look like "nothing changed".
    -- ApplyBodygroupsVM sets vm:SetBodygroup(bg, val) for each entry in
    -- self.Bodygroups_V, hiding the default parts so only the VElement
    -- attachment models show.
    if self.ApplyBodygroupsVM then self:ApplyBodygroupsVM(vm) end

    -- ONE-TIME diagnostic print (only prints once, then every 5 seconds)
    -- so we can confirm DrawVElements IS being called every frame.
    if not self._drawVElemLastPrint or CurTime() - self._drawVElemLastPrint > 5 then
        self._drawVElemLastPrint = CurTime()
        local activeCount = 0
        local validCount = 0
        for name, elem in pairs(self.ViewModelElements) do
            if elem.active then
                activeCount = activeCount + 1
                if IsValid(elem._csModel) then
                    validCount = validCount + 1
                end
            end
        end
        print("[CUH-DBG] DrawVElements running  vm=" .. tostring(vm) .. "  activeElems=" .. activeCount .. "  validCsModels=" .. validCount)
    end

    for name, elem in pairs(self.ViewModelElements) do
        if not elem.active then continue end

        if elem.type == "Model" and IsValid(elem._csModel) then
            local model = elem._csModel

            -- CRITICAL: SetModel must be called every frame in case the
            -- model string was swapped by ApplyAttachments. The _csModel
            -- was created with the OLD model; if we don't call SetModel
            -- with the NEW string, the old model keeps drawing.
            if elem.model and elem.model ~= "" then
                model:SetModel(elem.model)
            end

            if elem.bonemerge then
                model:SetParent(vm)
                model:AddEffects(EF_BONEMERGE)
                -- Apply pos offset even for bonemerged elements.
                -- EF_BONEMERGE drives the bones, but we can still nudge
                -- the entity origin to close small gaps between parts.
                if elem.pos and (elem.pos.x ~= 0 or elem.pos.y ~= 0 or elem.pos.z ~= 0) then
                    local vmPos, vmAng = vm:GetPos(), vm:GetAngles()
                    local offset = vmPos
                        + vmAng:Right()   * (elem.pos.x or 0)
                        + vmAng:Forward() * (elem.pos.y or 0)
                        + vmAng:Up()      * (elem.pos.z or 0)
                    model:SetPos(offset)
                end
            else
                model:SetParent(NULL)
                model:RemoveEffects(EF_BONEMERGE)

                -- Manual bone positioning (only when NOT bonemerged)
                local boneId = vm:LookupBone(elem.bone or "")
                if boneId then
                    local bPos, bAng = vm:GetBonePosition(boneId)
                    if bPos then
                        local pos = bPos
                        pos = pos + bAng:Right()   * (elem.pos and elem.pos.x or 0)
                        pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                        pos = pos + bAng:Up()      * (elem.pos and elem.pos.z or 0)
                        local ang = Angle(bAng)
                        if elem.ang then
                            ang:RotateAroundAxis(ang:Right(),   elem.ang.p or 0)
                            ang:RotateAroundAxis(ang:Up(),       elem.ang.y or 0)
                            ang:RotateAroundAxis(ang:Forward(),  elem.ang.r or 0)
                        end
                        model:SetPos(pos)
                        model:SetAngles(ang)
                    end
                end
            end

            local scale = elem.scale or Vector(1, 1, 1)
            model:SetModelScale(scale.x, 0)
            if elem.material and elem.material ~= "" then model:SetMaterial(elem.material) end
            if elem.skin then model:SetSkin(elem.skin) end
            if elem.bodygroups then
                for bg, val in pairs(elem.bodygroups) do model:SetBodygroup(bg, val) end
            end

            if elem.surpresslightning then render.SuppressEngineLighting(true) end
            model:DrawModel()
            if elem.surpresslightning then render.SuppressEngineLighting(false) end

        elseif elem.type == "Sprite" then
            local boneId = vm:LookupBone(elem.bone or "")
            if boneId then
                local bPos, bAng = vm:GetBonePosition(boneId)
                if bPos then
                    local pos = bPos
                    pos = pos + bAng:Right()   * (elem.pos and elem.pos.x or 0)
                    pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                    pos = pos + bAng:Up()      * (elem.pos and elem.pos.z or 0)
                    if elem.material and elem.material ~= "" then
                        render.SetMaterial(Material(elem.material))
                        local size = elem.size or 4
                        render.DrawSprite(pos, size, size, elem.color or Color(255,255,255,255))
                    end
                end
            end
        end
    end
end

function SWEP:CleanupVElements()
    if not self.ViewModelElements then return end
    for name, elem in pairs(self.ViewModelElements) do
        if IsValid(elem._csModel) then
            elem._csModel:Remove()
            elem._csModel = nil
        end
    end
    self._vElementsInit = false
end

-- ============================================================
-- HOLSTER / ONREMOVE — cleanup VElement ClientsideModels
-- ============================================================

function SWEP:Holster(wep)
    if self.CleanupVElements then self:CleanupVElements() end
    if self.CleanupWElements then self:CleanupWElements() end
    return BaseClass.Holster(self, wep)
end

function SWEP:OnRemove()
    if self.CleanupVElements then self:CleanupVElements() end
    if self.CleanupWElements then self:CleanupWElements() end
    if BaseClass.OnRemove then BaseClass.OnRemove(self) end
end

-- ============================================================
-- WELEMENT SYSTEM — World model attachment models
-- ============================================================

function SWEP:InitWElements()
    if not self.WorldModelElements then return end
    if self._wElementsInit then return end
    self._wElementsInit = true

    if CLIENT then
        for name, elem in pairs(self.WorldModelElements) do
            if elem._defaultActive == nil then
                elem._defaultActive = elem.active or false
            end
            -- Snapshot for full restore on attachment removal
            if elem._defaultSnapshot == nil then
                local snap = table.Copy(elem)
                snap._defaultSnapshot = nil
                snap._csModel = nil
                elem._defaultSnapshot = snap
            end
            if elem.type == "Model" and elem.model and elem.model ~= "" then
                elem._csModel = ClientsideModel(elem.model, RENDERGROUP_OPAQUE)
                if IsValid(elem._csModel) then
                    elem._csModel:SetNoDraw(true)
                    if elem.skin then elem._csModel:SetSkin(elem.skin) end
                    if elem.bodygroups then
                        for bg, val in pairs(elem.bodygroups) do
                            elem._csModel:SetBodygroup(bg, val)
                        end
                    end
                    if elem.material and elem.material ~= "" then
                        elem._csModel:SetMaterial(elem.material)
                    end
                end
            end
        end
    end
end

function SWEP:DrawWElements(owner)
    if not self.WorldModelElements then return end
    if not self._wElementsInit then self:InitWElements() end
    if not IsValid(owner) then return end

    local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
    if not boneid then return end
    local matrix = owner:GetBoneMatrix(boneid)
    if not matrix then return end

    local handPos = matrix:GetTranslation()
    local handAng = matrix:GetAngles()

    for name, elem in pairs(self.WorldModelElements) do
        if not elem.active then continue end

        if elem.type == "Model" and IsValid(elem._csModel) then
            local model = elem._csModel

            local pos = handPos
            if elem.pos then
                pos = pos + handAng:Right()   * elem.pos.x
                pos = pos + handAng:Forward() * elem.pos.y
                pos = pos + handAng:Up()      * elem.pos.z
            end

            local ang = Angle(handAng)
            if elem.ang then
                ang:RotateAroundAxis(ang:Right(),   elem.ang.p or 0)
                ang:RotateAroundAxis(ang:Up(),       elem.ang.y or 0)
                ang:RotateAroundAxis(ang:Forward(),  elem.ang.r or 0)
            end

            model:SetPos(pos)
            model:SetAngles(ang)

            local scale = elem.scale or Vector(1, 1, 1)
            model:SetModelScale(scale.x, 0)

            if elem.material and elem.material ~= "" then model:SetMaterial(elem.material) end
            if elem.skin then model:SetSkin(elem.skin) end
            if elem.bodygroups then
                for bg, val in pairs(elem.bodygroups) do model:SetBodygroup(bg, val) end
            end

            model:DrawModel()
        end
    end
end

function SWEP:CleanupWElements()
    if not self.WorldModelElements then return end
    for name, elem in pairs(self.WorldModelElements) do
        if IsValid(elem._csModel) then
            elem._csModel:Remove()
            elem._csModel = nil
        end
    end
    self._wElementsInit = false
end

-- ============================================================
-- DRAW WORLD MODEL — render weapon + WElements
-- ============================================================

function SWEP:DrawWorldModel()
    local owner = self:GetOwner()
    if IsValid(owner) then
        -- Draw the base world model
        self:DrawModel()
        -- Draw attachment elements on top
        self:DrawWElements(owner)
    else
        -- No owner — draw at weapon position (ground spawn)
        self:DrawModel()
    end
end

-- ============================================================
-- BODYGROUP SYSTEM — sight/mag bodygroup swaps
-- ============================================================

function SWEP:SetSightBodygroup(value)
    if not self.SightBGs then return end
    self._currentSightBG = value
    if self.SightBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.SightBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.SightBGs.main] = value
    end
    if self.WMSightBGs and self.WMSightBGs.main then
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.WMSightBGs.main] = value
    end
end

function SWEP:SetMagBodygroup(value)
    if not self.MagBGs then return end
    self._currentMagBG = value
    if self.MagBGs.main then
        self.Bodygroups_V = self.Bodygroups_V or {}
        self.Bodygroups_V[self.MagBGs.main] = value
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.MagBGs.main] = value
    end
    if self.WMMagBGs and self.WMMagBGs.main then
        self.Bodygroups_W = self.Bodygroups_W or {}
        self.Bodygroups_W[self.WMMagBGs.main] = value
    end
end

function SWEP:ApplyBodygroupsVM(vm)
    if not IsValid(vm) then return end
    for bg, val in pairs(self.Bodygroups_V or {}) do
        vm:SetBodygroup(bg, val)
    end
end

function SWEP:ApplyBodygroupsWM(wm)
    if not IsValid(wm) then return end
    for bg, val in pairs(self.Bodygroups_W or {}) do
        wm:SetBodygroup(bg, val)
    end
end

function SWEP:ResetBodygroups()
    self.Bodygroups_V = {}
    self.Bodygroups_W = {}
    self._currentSightBG = nil
    self._currentMagBG = nil
    if self.SightBGs and self.SightBGs.regular ~= nil then
        self:SetSightBodygroup(self.SightBGs.regular)
    end
    if self.MagBGs and self.MagBGs.regular ~= nil then
        self:SetMagBodygroup(self.MagBGs.regular)
    end
end

-- ============================================================
-- APPLY ATTACHMENTS — rebuild stats, VElements, WElements, bodygroups
-- ============================================================

function SWEP:ApplyAttachments()
    print("[CUH-DBG] >>> ApplyAttachments CALLED  realm=" .. (SERVER and "SERVER" or "CLIENT")
        .. "  wep=" .. tostring(self) .. "  class=" .. tostring(self.GetClass and self:GetClass() or "?"))
    if not self.Attachments then
        print("[CUH-DBG]   ABORT: self.Attachments is nil")
        return
    end
    if not self._statOrigins then self:InitStatCache() end

    print("[CUH-DBG]   CustomUH.Attachments count = " .. tostring(CustomUH and CustomUH.Attachments and table.Count(CustomUH.Attachments) or "nil"))
    if CustomUH and CustomUH.Attachments then
        local keys = {}
        for k, _ in pairs(CustomUH.Attachments) do keys[#keys+1] = k end
        print("[CUH-DBG]   CustomUH.Attachments keys = {" .. table.concat(keys, ", ") .. "}")
    end

    -- 0. ENSURE SNAPSHOT — call InitVElements/InitWElements once now, BEFORE
    -- any attachment modifies the model. This guarantees the _defaultSnapshot
    -- captures the DEFAULT model state (not a previously-attached model).
    --
    -- Why this matters: InitVElements lazily snapshots the elem on first
    -- call. If the first call happens to be AFTER an attachment's Attach()
    -- has already swapped elem.model, the snapshot would capture the swapped
    -- model — and Step 2 below would "restore" to the wrong (already-swapped)
    -- model on every subsequent ApplyAttachments call. Calling Init here
    -- (before Step 5's Attach calls) prevents that.
    --
    -- InitVElements/InitWElements are idempotent (guarded by _vElementsInit
    -- / _wElementsInit), so this is a no-op if PostDrawViewModel already
    -- ran the snapshot.
    if self.InitVElements then self:InitVElements() end
    if self.InitWElements then self:InitWElements() end

    -- 1. FULL RESET: restore all stats to origin values
    for path, _ in pairs(self._statCache) do
        self:RestoreStat(path)
    end

    -- 1b. RESET ANIMATIONS to origin (per-instance snapshot taken in InitStatCache).
    -- Attachments can override anim keys (e.g. magazine swapping
    -- reload -> reload_ext02). Restore them before re-applying.
    if self._animationsOrigin then
        self.Animations = table.Copy(self._animationsOrigin)
    end
    if self._animSoundsOrigin then
        self.AnimSounds = table.Copy(self._animSoundsOrigin)
    end

    -- 2. RESET VELEMENTS to default state (full restore from snapshot)
    if self.ViewModelElements then
        for name, elem in pairs(self.ViewModelElements) do
            if elem._defaultSnapshot then
                for k, v in pairs(elem._defaultSnapshot) do
                    elem[k] = v
                end
            else
                elem.active = elem._defaultActive or false
            end
        end
    end

    -- 3. RESET WELEMENTS to default state (full restore from snapshot)
    if self.WorldModelElements then
        for name, elem in pairs(self.WorldModelElements) do
            if elem._defaultSnapshot then
                for k, v in pairs(elem._defaultSnapshot) do
                    elem[k] = v
                end
            else
                elem.active = elem._defaultActive or false
            end
        end
    end

    -- 4. RESET BODYGROUPS
    self:ResetBodygroups()

    -- 5. APPLY each equipped attachment (respecting defaults)
    print("[CUH-DBG]   ApplyAttachments step 5: iterating " .. #self.Attachments .. " slots")
    for slot = 1, #self.Attachments do
        local slotData = self.Attachments[slot]
        if slotData then
            local sel = self:GetEffectiveAttachment(slot)
            print("[CUH-DBG]     slot=" .. slot .. "  sel(effective)=" .. tostring(sel)
                .. "  atts count=" .. tostring(slotData.atts and #slotData.atts or 0))
            if sel and sel > 0 then
                local attId = slotData.atts[sel]
                print("[CUH-DBG]       attId = " .. tostring(attId) .. "  (slotData.atts[" .. sel .. "])")
                if attId and CustomUH and CustomUH.Attachments and CustomUH.Attachments[attId] then
                    local att = CustomUH.Attachments[attId]
                    print("[CUH-DBG]       att FOUND:  Name=" .. tostring(att.Name) .. "  PartClass=" .. tostring(att.PartClass) .. "  ModelPath=" .. tostring(att.ModelPath))
                    print("[CUH-DBG]       att.Attach = " .. tostring(att.Attach) .. "  att.WeaponTable = " .. tostring(att.WeaponTable))
                    print("[CUH-DBG]       ViewModelElements['" .. tostring(att.PartClass) .. "'] present: "
                        .. tostring(self.ViewModelElements and self.ViewModelElements[att.PartClass] ~= nil))
                    if self.ViewModelElements and self.ViewModelElements[att.PartClass] then
                        print("[CUH-DBG]         current elem.model = " .. tostring(self.ViewModelElements[att.PartClass].model))
                    end

                    -- Apply WeaponTable stats
                    if att.WeaponTable then
                        for path, value in pairs(att.WeaponTable) do
                            if path ~= "VElements" and path ~= "WElements"
                               and path ~= "Bodygroups_V" and path ~= "Bodygroups_W"
                               and path ~= "ViewModelBoneMods" and path ~= "WorldModelBoneMods"
                               and path ~= "Animations" then
                                -- Handle nested Primary/Secondary tables:
                                -- iterate sub-keys and apply each as
                                -- "Primary.Spread", "Primary.Delay", etc.
                                -- Otherwise SetStat("Primary", table) would
                                -- REPLACE the entire Primary table, losing
                                -- Damage / ClipSize / Ammo / etc.
                                if (path == "Primary" or path == "Secondary") and istable(value) then
                                    for subKey, subVal in pairs(value) do
                                        local fullPath = path .. "." .. subKey
                                        if isfunction(subVal) then
                                            local currentVal = self:GetStat(fullPath)
                                            -- Defensive: if the weapon doesn't define this stat
                                            -- (currentVal is nil) we cannot meaningfully transform
                                            -- it — calling subVal(self, nil) would crash inside
                                            -- the attachment's `val * 0.8` etc. and abort the
                                            -- ENTIRE ApplyAttachments, which prevents the model
                                            -- swap and bodygroup changes from running too
                                            -- (visible as "attachments don't apply at all").
                                            -- Wrap in pcall as a final safety net so a buggy
                                            -- attachment function never breaks the whole pipeline.
                                            if currentVal ~= nil then
                                                local ok, newVal, shouldSet = pcall(subVal, self, currentVal)
                                                if ok and shouldSet ~= false and newVal ~= nil then
                                                    self:SetStat(fullPath, newVal)
                                                elseif not ok then
                                                    print("[CUH-DBG]   WARNING: attachment stat function crashed for "
                                                        .. tostring(fullPath) .. ": " .. tostring(newVal))
                                                end
                                            else
                                                print("[CUH-DBG]   SKIP: stat " .. tostring(fullPath)
                                                    .. " not defined on weapon — function transform ignored")
                                            end
                                        else
                                            self:SetStat(fullPath, subVal)
                                        end
                                    end
                                elseif isfunction(value) then
                                    local currentVal = self:GetStat(path)
                                    if currentVal ~= nil then
                                        local ok, newVal, shouldSet = pcall(value, self, currentVal)
                                        if ok and shouldSet ~= false and newVal ~= nil then
                                            self:SetStat(path, newVal)
                                        elseif not ok then
                                            print("[CUH-DBG]   WARNING: attachment stat function crashed for "
                                                .. tostring(path) .. ": " .. tostring(newVal))
                                        end
                                    else
                                        print("[CUH-DBG]   SKIP: stat " .. tostring(path)
                                            .. " not defined on weapon — function transform ignored")
                                    end
                                else
                                    self:SetStat(path, value)
                                end
                            end
                        end

                        -- Bodygroups_V
                        if att.WeaponTable.Bodygroups_V then
                            self.Bodygroups_V = self.Bodygroups_V or {}
                            for bg, val in pairs(att.WeaponTable.Bodygroups_V) do
                                self.Bodygroups_V[bg] = val
                            end
                        end
                        -- Bodygroups_W
                        if att.WeaponTable.Bodygroups_W then
                            self.Bodygroups_W = self.Bodygroups_W or {}
                            for bg, val in pairs(att.WeaponTable.Bodygroups_W) do
                                self.Bodygroups_W[bg] = val
                            end
                        end
                    end

                    -- VElement overrides
                    if att.WeaponTable and att.WeaponTable.VElements then
                        if not self.ViewModelElements then self.ViewModelElements = {} end
                        for name, override in pairs(att.WeaponTable.VElements) do
                            if self.ViewModelElements[name] then
                                for k, v in pairs(override) do
                                    self.ViewModelElements[name][k] = v
                                end
                            else
                                self.ViewModelElements[name] = table.Copy(override)
                            end
                        end
                    end

                    -- WElement overrides
                    if att.WeaponTable and att.WeaponTable.WElements then
                        if not self.WorldModelElements then self.WorldModelElements = {} end
                        for name, override in pairs(att.WeaponTable.WElements) do
                            if self.WorldModelElements[name] then
                                for k, v in pairs(override) do
                                    self.WorldModelElements[name][k] = v
                                end
                            else
                                self.WorldModelElements[name] = table.Copy(override)
                            end
                        end
                    end

                    -- Animations overrides — merges per-key into self.Animations.
                    -- Values can be either:
                    --   * a string (sequence name or ACT_VM_* name) -> direct assignment
                    --   * a function(wep, val) -> called, result stored
                    -- Example:
                    --   ATTACHMENT.WeaponTable = {
                    --       ["Animations"] = {
                    --           ["reload"]       = "reload_ext02",
                    --           ["reload_empty"] = "reload_empty_ext02",
                    --       },
                    --   }
                    if att.WeaponTable and att.WeaponTable.Animations then
                        if not self.Animations then self.Animations = {} end
                        for animKey, animVal in pairs(att.WeaponTable.Animations) do
                            if isfunction(animVal) then
                                local cur = self.Animations[animKey]
                                local ok, newVal = pcall(animVal, self, cur)
                                if ok and newVal ~= nil then
                                    self.Animations[animKey] = newVal
                                elseif not ok then
                                    ErrorNoHalt("[CUH] Attachment " .. tostring(attId)
                                        .. " Animations[" .. tostring(animKey)
                                        .. "] function crashed: " .. tostring(newVal) .. "\n")
                                end
                            else
                                self.Animations[animKey] = animVal
                            end
                        end
                    end

                    -- AnimSounds overrides — same pattern as Animations.
                    if att.WeaponTable and att.WeaponTable.AnimSounds then
                        if not self.AnimSounds then self.AnimSounds = {} end
                        for key, val in pairs(att.WeaponTable.AnimSounds) do
                            if isfunction(val) then
                                local cur = self.AnimSounds[key]
                                local ok, newVal = pcall(val, self, cur)
                                if ok and newVal ~= nil then
                                    self.AnimSounds[key] = newVal
                                elseif not ok then
                                    ErrorNoHalt("[CUH] Attachment " .. tostring(attId)
                                        .. " AnimSounds[" .. tostring(key)
                                        .. "] function crashed: " .. tostring(newVal) .. "\n")
                                end
                            else
                                self.AnimSounds[key] = val
                            end
                        end
                    end

                    -- Call attachment's Attach function for side effects
                    -- (e.g. model swap via wep.ViewModelElements[PartClass].model = newModel)
                    -- Wrapped in pcall so a buggy attachment never breaks the
                    -- entire ApplyAttachments pipeline (which would prevent
                    -- ALL subsequent slots from being applied).
                    if att.Attach then
                        print("[CUH-DBG]       calling att:Attach(self) ...")
                        local ok, err = pcall(att.Attach, att, self)
                        if not ok then
                            print("[CUH-DBG]       ERROR in att:Attach: " .. tostring(err))
                            ErrorNoHalt("[CUH] Attachment " .. tostring(attId) .. " Attach() failed: " .. tostring(err) .. "\n")
                        else
                            print("[CUH-DBG]       att:Attach returned. elem.model now = "
                                .. tostring(self.ViewModelElements and self.ViewModelElements[att.PartClass] and self.ViewModelElements[att.PartClass].model))
                        end
                    else
                        print("[CUH-DBG]       WARNING: att.Attach is nil — model swap will NOT happen")
                    end
                else
                    print("[CUH-DBG]       NOT FOUND in CustomUH.Attachments  attId=" .. tostring(attId))
                end
            else
                print("[CUH-DBG]       sel is nil or 0 — skipping")
            end
        else
            print("[CUH-DBG]     slot=" .. slot .. "  slotData is nil")
        end
    end

    -- 6. Re-init VElements and WElements (in case models were swapped).
    --    Attach() may already have done CleanupVElements + InitVElements
    --    for its own part, but we re-run all four so EVERY element picks
    --    up the new model/bodygroup/skin/material fields. This is what
    --    actually rebuilds the ClientsideModels that DrawVElements and
    --    DrawWElements render each frame.
    print("[CUH-DBG]   ApplyAttachments step 6: CleanupVElements + InitVElements (rebuild ClientsideModels)")
    if self.ViewModelElements then
        for name, elem in pairs(self.ViewModelElements) do
            print("[CUH-DBG]     VElement['" .. tostring(name) .. "']  model=" .. tostring(elem.model)
                .. "  _csModel=" .. tostring(elem._csModel) .. "  active=" .. tostring(elem.active))
        end
    end
    if self.CleanupVElements then self:CleanupVElements() end
    if self.InitVElements then self:InitVElements() end
    if self.CleanupWElements then self:CleanupWElements() end
    if self.InitWElements then self:InitWElements() end
    print("[CUH-DBG]   post-rebuild VElement barrel _csModel = "
        .. tostring(self.ViewModelElements and self.ViewModelElements["barrel"] and self.ViewModelElements["barrel"]._csModel))
    print("[CUH-DBG] <<< ApplyAttachments returning")
end

-- ============================================================
-- SET ATTACHMENT — select an attachment in a slot
-- ============================================================

function SWEP:SetAttachment(slot, index)
    print("[CUH-DBG] >>> SetAttachment CALLED  slot=" .. tostring(slot) .. " index=" .. tostring(index)
        .. " realm=" .. (SERVER and "SERVER" or "CLIENT") .. " wep=" .. tostring(self)
        .. " class=" .. tostring(self.GetClass and self:GetClass() or "?"))

    if not self.Attachments or not self.Attachments[slot] then
        print("[CUH-DBG]   ABORT: self.Attachments missing or no slot " .. tostring(slot))
        return
    end

    -- Validate index
    if index > 0 and (not self.Attachments[slot].atts or index > #self.Attachments[slot].atts) then
        print("[CUH-DBG]   ABORT: index out of range (atts count=" .. tostring(self.Attachments[slot].atts and #self.Attachments[slot].atts) .. ")")
        return
    end

    -- forceDefault check: if player tries to select "None" (0)
    -- and forceDefault is on, snap back to default instead
    if index == 0 and self.Attachments[slot].forceDefault
        and self.Attachments[slot].default and self.Attachments[slot].default > 0 then
        index = self.Attachments[slot].default
        print("[CUH-DBG]   forceDefault: snapped 0 -> " .. tostring(index))
    end

    self.Attachments[slot].sel = index
    print("[CUH-DBG]   self.Attachments[" .. slot .. "].sel = " .. tostring(index)
        .. "  atts[index]=" .. tostring(self.Attachments[slot].atts and self.Attachments[slot].atts[index]))
    print("[CUH-DBG]   CustomUH.Attachments has " .. tostring(CustomUH and CustomUH.Attachments and table.Count(CustomUH.Attachments) or "nil/empty") .. " entries")
    print("[CUH-DBG]   calling self:ApplyAttachments() ...")
    self:ApplyAttachments()
    print("[CUH-DBG] <<< SetAttachment returning (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")

    -- Network to server
    if CLIENT then
        print("[CUH-DBG]   CLIENT sending net CUH2_AttSelect (slot=" .. slot .. " index=" .. index .. ")")
        net.Start("CUH2_AttSelect")
            net.WriteEntity(self)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.SendToServer()
    end

    -- Save on server + broadcast to all clients
    -- When SetAttachment is called directly on the server (e.g. via
    -- the cuh_set console command, or via the CUH2_AttSelect net
    -- receiver), we MUST broadcast CUH2_AttSync to all clients so
    -- they apply the same attachment locally. Without this, the
    -- server's copy of the weapon has the swapped model string,
    -- but the clients' copies don't — so no visual change appears.
    if SERVER then
        if CustomUH.SaveAttachments then
            CustomUH.SaveAttachments(self, self.Owner)
        end
        print("[CUH-DBG]   SERVER broadcasting CUH2_AttSync (slot=" .. slot .. " index=" .. index .. ")")
        net.Start("CUH2_AttSync")
            net.WriteEntity(self)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.Broadcast()
    end
end

-- ============================================================
-- TFA COMPATIBILITY STUBS
-- ============================================================
-- TFA Base's keybind system calls GetActivityEnabled on
-- all weapons. We don't use TFA's activity system, so we
-- stub it out to prevent errors.
function SWEP:GetActivityEnabled()
    return false
end

-- ============================================================
-- MELEE ATTACK
-- ============================================================
-- Plays the melee animation, schedules the hit trace, and
-- locks controls for the duration.
function SWEP:MeleeAttack()
    local ct = CurTime()
    if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end

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
    self:EasySendWeaponAnim("melee", ACT_VM_MELEE)

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