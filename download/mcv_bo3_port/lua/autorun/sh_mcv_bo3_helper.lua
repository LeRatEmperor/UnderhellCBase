-- ============================================================
-- MCV_BO3 Helper - Patches mcv_base_core to support BO3 weapons
-- ============================================================
-- This file patches mcv_base_core's PlayAnimation so that when MCV
-- requests an ACT_VM_* activity, it first checks the weapon's
-- SWEP.Animations table for a BO3 sequence name mapping.
--
-- If a mapping exists, it calls applySequence directly with the
-- sequence looked up by name (vm:LookupSequence). If no mapping
-- exists, it falls through to MCV's native behavior
-- (vm:SelectWeightedSequence on the activity).
--
-- This patch is GLOBAL - it applies to ALL weapons derived from
-- mcv_base_core (which includes mcv_base, mcv_melee, mcv_throwable,
-- etc.). Weapons that don't have an Animations table are unaffected.
--
-- Install: place in lua/autorun/ (loaded automatically).
-- Requires MCV to be loaded first (uses a hook to ensure ordering).

AddCSLuaFile()

MCV_BO3 = MCV_BO3 or {}

-- ============================================================
-- DEBUG
-- ============================================================

local BO3_DEBUG = CreateConVar("mcv_bo3_debug", "0", FCVAR_REPLICATED,
    "Print BO3 animation lookup diagnostics to console")

-- ============================================================
-- ACT -> Animations key mapping
-- ============================================================
-- Given a weapon self and an ACT_VM_*, returns the matching key
-- from SWEP.Animations (e.g. "shoot", "reload", "idle") and its
-- value (sequence name, activity string, or table of variants).
-- State-aware: prefers ironsight variants when sighted, empty
-- variants when clip is empty.

function MCV_BO3.PickKey(self, act)
    if not self.Animations then return nil, nil end

    local isZooming = self.GetIronsight and self:GetIronsight() and self.GetSighted and self:GetSighted()
    local isEmpty = self:Clip1() <= 0

    local function try(...)
        for _, k in ipairs({...}) do
            if self.Animations[k] then
                return k, self.Animations[k]
            end
        end
        return nil, nil
    end

    if act == ACT_VM_IDLE then
        return try(isEmpty and "idle_empty", "idle")
    elseif act == ACT_VM_DRAW or act == ACT_VM_READY then
        return try("first_draw", "deploy", "draw")
    elseif act == ACT_VM_HOLSTER then
        return try("holster")
    elseif act == ACT_VM_PRIMARYATTACK or act == ACT_VM_PRIMARYATTACK_DEPLOYED then
        return try(isZooming and "iron_fire", "shoot")
    elseif act == ACT_VM_SHOOTLAST then
        return try("shoot_last", "iron_fire", "shoot")
    elseif act == ACT_VM_RELOAD then
        return try(isEmpty and "reload_empty", "reload")
    elseif act == ACT_VM_RELOADEMPTY then
        return try("reload_empty", "reload")
    elseif act == ACT_SHOTGUN_RELOAD_START then
        return try("start_reload")
    elseif act == ACT_VM_RELOAD_END or act == ACT_VM_RELOAD_END_EMPTY or act == ACT_SHOTGUN_RELOAD_FINISH then
        return try("after_reload", "reload_end")
    elseif act == ACT_SHOTGUN_PUMP then
        return try("pump", "rechamber")
    elseif act == ACT_VM_RELOAD_INSERT_PULL then
        return try("bolt_pull", "rechamber")
    elseif act == ACT_VM_HITCENTER then
        return try("bash")
    end

    return nil, nil
end

function MCV_BO3.ResolveVariant(animData)
    if istable(animData) and animData[1] then
        return animData[math.random(1, #animData)]
    end
    return animData
end

function MCV_BO3.ParseActivity(s)
    if not isstring(s) then return nil end
    if string.find(s, "^ACT_") then
        local n = _G[s]
        if type(n) == "number" then return n end
    end
    return nil
end

-- ============================================================
-- ANIM SOUNDS TIMELINE
-- ============================================================

function MCV_BO3.SetupAnimSounds(self, animKey, variantName)
    if not self.AnimSounds then return end

    local timeline = nil
    if variantName and self.AnimSounds[variantName] then
        timeline = self.AnimSounds[variantName]
    end
    if not istable(timeline) or #timeline == 0 then
        timeline = self.AnimSounds[animKey]
    end
    if (not timeline or not istable(timeline)) and animKey == "reload_empty" then
        timeline = self.AnimSounds["reload"]
    end
    if not istable(timeline) or #timeline == 0 then return end

    self._animSoundTimeline = timeline
    self._animSoundIndex = 1
    self._animSoundStartTime = CurTime()

    local owner = self:GetOwner()
    if IsValid(owner) then
        local vm = owner:GetViewModel()
        self._animSoundPlaybackRate = IsValid(vm) and vm:GetPlaybackRate() or 1
    else
        self._animSoundPlaybackRate = 1
    end
    self._animSoundActive = true
end

function MCV_BO3.ProcessAnimSounds(self)
    if not self._animSoundActive then return end
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()
    if not ((sp and SERVER) or (not sp and CLIENT and iftp)) then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then
        self._animSoundActive = false
        return
    end

    local timeline = self._animSoundTimeline
    local idx = self._animSoundIndex
    if idx > #timeline then
        self._animSoundActive = false
        return
    end

    local elapsed = (CurTime() - self._animSoundStartTime) * (self._animSoundPlaybackRate or 1)
    while idx <= #timeline and elapsed >= (timeline[idx].time or 0) do
        local entry = timeline[idx]
        if entry.sound and entry.sound ~= "" and entry.sound ~= "nil" then
            local snd = entry.sound
            if istable(snd) then snd = snd[math.random(1, #snd)] end
            owner:EmitSound(snd, entry.level or 75, entry.pitch or 100, 1, CHAN_USER_BASE)
        end
        if entry.callback then entry.callback(self) end
        idx = idx + 1
    end
    self._animSoundIndex = idx
end

function MCV_BO3.ClearAnimSounds(self)
    self._animSoundActive = false
    self._animSoundTimeline = nil
    self._animSoundIndex = 0
end

-- ============================================================
-- PATCH mcv_base_core
-- ============================================================
-- We wait for MCV to be fully loaded, then wrap its PlayAnimation
-- and PlaySequence methods on the mcv_base_core class table.
--
-- This is a GLOBAL patch - it applies to every weapon derived from
-- mcv_base_core. Weapons without an Animations table are unaffected
-- (the wrapper checks for self.Animations first and falls through to
-- MCV's native behavior if absent or if no mapping is found).

local function patch_mcv()
    local core = weapons.GetStored("mcv_base_core")
    if not core then
        ErrorNoHalt("[MCV_BO3] mcv_base_core not found! MCV not loaded?\n")
        return false
    end

    -- Already patched?
    if core._bo3_patched then
        print("[MCV_BO3] Already patched, skipping")
        return true
    end

    local MCV_PlayAnimation = core.PlayAnimation
    local MCV_PlaySequence  = core.PlaySequence

    if not MCV_PlayAnimation or not MCV_PlaySequence then
        ErrorNoHalt("[MCV_BO3] mcv_base_core missing PlayAnimation/PlaySequence!\n")
        return false
    end

    print("[MCV_BO3] Patching mcv_base_core.PlayAnimation")
    print("[MCV_BO3]   original PlayAnimation = " .. tostring(MCV_PlayAnimation))
    print("[MCV_BO3]   original PlaySequence  = " .. tostring(MCV_PlaySequence))

    -- Wrap PlayAnimation: check Animations table first, fall back to MCV native
    function core:PlayAnimation(act, mult, lock, noidle)
        mult = mult or 1
        lock = lock or false
        noidle = noidle or false

        -- If this weapon has an Animations table, try to remap the activity
        if self.Animations then
            local key, animData = MCV_BO3.PickKey(self, act)

            if BO3_DEBUG:GetBool() then
                print("[BO3] PlayAnimation act=" .. tostring(act) .. " key=" .. tostring(key) .. " data=" .. tostring(animData))
            end

            if animData then
                local picked = MCV_BO3.ResolveVariant(animData)
                local parsedAct = MCV_BO3.ParseActivity(picked)

                if parsedAct then
                    -- Entry is an activity string like "ACT_VM_RELOAD"
                    -- Check if the model has this activity tagged
                    local owner = self:GetOwner()
                    local vm = IsValid(owner) and owner:GetViewModel() or nil
                    if IsValid(vm) then
                        local seq = vm:SelectWeightedSequence(parsedAct)
                        if seq ~= -1 then
                            -- Model has the activity, call MCV's native PlayAnimation
                            -- (which calls applySequence with the right seq id)
                            local t = MCV_PlayAnimation(self, parsedAct, mult, lock, noidle)
                            if BO3_DEBUG:GetBool() then print("[BO3]   -> activity " .. picked .. " seq=" .. seq .. " t=" .. tostring(t)) end
                            if t then MCV_BO3.SetupAnimSounds(self, key, picked) end
                            return t
                        end
                        if BO3_DEBUG:GetBool() then print("[BO3]   -> activity " .. picked .. " not on model") end
                    end
                else
                    -- Entry is a sequence name like "base_fire"
                    -- Look it up directly and call MCV's native PlaySequence
                    -- (NOT self:PlaySequence - that would recurse into this wrapper
                    -- and there's no Animations key for an arbitrary sequence name)
                    local owner = self:GetOwner()
                    local vm = IsValid(owner) and owner:GetViewModel() or nil
                    if IsValid(vm) then
                        local seq = vm:LookupSequence(picked)
                        if seq ~= -1 then
                            local t = MCV_PlaySequence(self, picked, mult, lock, noidle)
                            if BO3_DEBUG:GetBool() then print("[BO3]   -> seq '" .. picked .. "' id=" .. seq .. " t=" .. tostring(t)) end
                            if t then MCV_BO3.SetupAnimSounds(self, key, picked) end
                            return t
                        end
                        if BO3_DEBUG:GetBool() then print("[BO3]   -> seq '" .. picked .. "' not on model") end
                    end
                end
            end
        end

        -- No Animations table, or mapping failed, or model doesn't have the
        -- sequence - fall back to MCV's native PlayAnimation (which uses
        -- SelectWeightedSequence on the activity and may print INVALID ACT
        -- if the model lacks the activity tag).
        return MCV_PlayAnimation(self, act, mult, lock, noidle)
    end

    core._bo3_patched = true
    print("[MCV_BO3] Patched mcv_base_core.PlayAnimation successfully")

    -- Also wrap ThinkWeapon on mcv_base (not mcv_base_core - that's where
    -- the gun-specific Think_Sights/Think_Reload etc. live)
    local base = weapons.GetStored("mcv_base")
    if base and not base._bo3_think_patched then
        local MCV_ThinkWeapon = base.ThinkWeapon
        if MCV_ThinkWeapon then
            print("[MCV_BO3] Patching mcv_base.ThinkWeapon")
            function base:ThinkWeapon()
                MCV_BO3.ProcessAnimSounds(self)
                MCV_ThinkWeapon(self)
            end
            base._bo3_think_patched = true
            print("[MCV_BO3] Patched mcv_base.ThinkWeapon successfully")
        end
    end

    -- Wrap Holster on mcv_base_core to clear anim sounds state
    if not core._bo3_holster_patched then
        local MCV_Holster = core.Holster
        if MCV_Holster then
            function core:Holster(wep)
                MCV_BO3.ClearAnimSounds(self)
                self._mantleActive = false
                self._mantleEndTime = nil
                return MCV_Holster(self, wep)
            end
            core._bo3_holster_patched = true
            print("[MCV_BO3] Patched mcv_base_core.Holster")
        end
    end

    return true
end

-- ============================================================
-- MANTLE / VAULT DETECTION
-- ============================================================

function MCV_BO3.HandleMantle(self)
    local ct = CurTime()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end

    local isVaulting = ply.GetNW2Bool and ply:GetNW2Bool("BO3_IsVaulting", false) or false
    local isMantling = ply.GetNW2Bool and ply:GetNW2Bool("BO3_IsMantling", false) or false
    local isInTraversal = isVaulting or isMantling

    if isInTraversal and not self._mantleActive then
        self._mantleActive = true
        self._mantleEndTime = ct + (self.MantleDuration or 0.6)
        MCV_BO3.ClearAnimSounds(self)
        if self.SetIronsight then self:SetIronsight(false) end
        if self.SetReloading then self:SetReloading(false) end
        if self.Animations and self.Animations["mantle"] then
            local picked = MCV_BO3.ResolveVariant(self.Animations["mantle"])
            local parsedAct = MCV_BO3.ParseActivity(picked)
            if parsedAct then
                self:PlayAnimation(parsedAct, 1, true)
            else
                self:PlaySequence(picked, 1, true)
            end
        end
        self:SetNextPrimaryFire(self._mantleEndTime)
        self:SetNextSecondaryFire(self._mantleEndTime)
    elseif not isInTraversal and self._mantleActive then
        self._mantleActive = false
        self._mantleEndTime = nil
    end

    if self._mantleActive and self._mantleEndTime and ct >= self._mantleEndTime then
        self._mantleActive = false
        self._mantleEndTime = nil
    end
end

-- ============================================================
-- SPRINT ANIMATIONS
-- ============================================================

function MCV_BO3.HandleSprintAnims(self)
    if not self.AnimatedSprint then return end
    if not self.Animations then return end
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local isRunning = self.GetIsSprinting and self:GetIsSprinting() or false
    local isReloading = self.GetReloading and self:GetReloading() or false
    if self.wasRunning == nil then self.wasRunning = false end

    local vm = ply:GetViewModel()
    if not IsValid(vm) then return end

    if isRunning and not self.wasRunning then
        if not isReloading and not self._mantleActive and self.Animations["sprint_in"] then
            local picked = MCV_BO3.ResolveVariant(self.Animations["sprint_in"])
            local parsedAct = MCV_BO3.ParseActivity(picked)
            if parsedAct then
                self:PlayAnimation(parsedAct, 1, true)
            else
                self:PlaySequence(picked, 1, true)
            end
        end
    elseif not isRunning and self.wasRunning then
        if not isReloading and not self._mantleActive and self.Animations["sprint_out"] then
            local picked = MCV_BO3.ResolveVariant(self.Animations["sprint_out"])
            local parsedAct = MCV_BO3.ParseActivity(picked)
            if parsedAct then
                self:PlayAnimation(parsedAct, 1, true)
            else
                self:PlaySequence(picked, 1, true)
            end
        end
    elseif isRunning and not isReloading then
        if vm:GetCycle() >= 1 and self.Animations["sprint_idle"] then
            local picked = MCV_BO3.ResolveVariant(self.Animations["sprint_idle"])
            local parsedAct = MCV_BO3.ParseActivity(picked)
            if parsedAct then
                self:PlayAnimation(parsedAct, 1, false)
            else
                self:PlaySequence(picked, 1, false)
            end
        end
    end

    self.wasRunning = isRunning
end

-- Add mantle + sprint to ThinkWeapon (wrap a second time if we already
-- wrapped once for anim sounds - the patched ThinkWeapon above calls
-- MCV_ThinkWeapon which is the original, so we need to add our stuff
-- BEFORE it)
local function patch_think_for_mantle_sprint()
    local base = weapons.GetStored("mcv_base")
    if not base then return end
    if base._bo3_mantle_patched then return end

    local current_think = base.ThinkWeapon
    if not current_think then return end

    function base:ThinkWeapon()
        MCV_BO3.HandleMantle(self)
        MCV_BO3.HandleSprintAnims(self)
        current_think(self)
    end
    base._bo3_mantle_patched = true
    print("[MCV_BO3] Patched mcv_base.ThinkWeapon for mantle/sprint")
end

-- ============================================================
-- HOOK TO ENSURE PATCHING HAPPENS AFTER MCV LOADS
-- ============================================================

hook.Add("Initialize", "MCV_BO3_Patch", function()
    if patch_mcv() then
        patch_think_for_mantle_sprint()
    end
end)

-- Also try on Think (first tick) in case Initialize runs before MCV registers
hook.Add("Think", "MCV_BO3_Patch_Retry", function()
    if MCV_BO3._patched then
        hook.Remove("Think", "MCV_BO3_Patch_Retry")
        return
    end
    if weapons.GetStored("mcv_base_core") and weapons.GetStored("mcv_base") then
        if patch_mcv() then
            patch_think_for_mantle_sprint()
            MCV_BO3._patched = true
            hook.Remove("Think", "MCV_BO3_Patch_Retry")
        end
    end
end)

-- ============================================================
-- DEBUG CONSOLE COMMAND
-- ============================================================

concommand.Add("mcv_bo3_dumpseqs", function(ply)
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then
        print("[BO3] No active weapon")
        return
    end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then
        print("[BO3] No viewmodel")
        return
    end
    print("========================================")
    print("[BO3] Viewmodel: " .. tostring(vm:GetModel()))
    print("[BO3] Weapon class: " .. tostring(wep:GetClass()))
    print("[BO3] Weapon Base: " .. tostring(wep.Base))
    print("========================================")
    local count = vm:SequenceCount()
    print("[BO3] " .. count .. " sequences:")
    for i = 0, count - 1 do
        local name = vm:GetSequenceName(i)
        local act = vm:GetSequenceActivity(i)
        local dur = vm:SequenceDuration(i)
        print(string.format("  [%d] %-40s act=%-6d dur=%.3f", i, name, act, dur))
    end
    print("========================================")
    if wep.Animations then
        print("[BO3] Animations table:")
        for k, v in pairs(wep.Animations) do
            local vstr = istable(v) and table.concat(v, "|") or tostring(v)
            local first = istable(v) and v[1] or v
            local seq = vm:LookupSequence(tostring(first))
            local found = seq >= 0 and "FOUND seq=" .. seq or "NOT FOUND"
            print(string.format("  [\"%s\"] = %-30s  ->  %s", k, vstr, found))
        end
    else
        print("[BO3] No Animations table on this weapon")
    end
    print("========================================")
end)

concommand.Add("mcv_bo3_status", function()
    local core = weapons.GetStored("mcv_base_core")
    print("========================================")
    print("[BO3] Status:")
    print("  MCV_BO3._patched = " .. tostring(MCV_BO3._patched))
    if core then
        print("  mcv_base_core found = yes")
        print("  _bo3_patched = " .. tostring(core._bo3_patched))
        print("  _bo3_holster_patched = " .. tostring(core._bo3_holster_patched))
    else
        print("  mcv_base_core found = NO")
    end
    local base = weapons.GetStored("mcv_base")
    if base then
        print("  mcv_base found = yes")
        print("  _bo3_think_patched = " .. tostring(base._bo3_think_patched))
        print("  _bo3_mantle_patched = " .. tostring(base._bo3_mantle_patched))
    else
        print("  mcv_base found = NO")
    end
    print("========================================")
end)
