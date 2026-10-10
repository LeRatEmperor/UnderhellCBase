-- mcv_nmrih_base: middle-man base for TFA NMRIH weapons on MCV.
--
-- NMRIH models have ACT_VM_* activities tagged on their sequences, but some
-- activity names differ from what MCV expects. This base:
--   1. Remaps mismatched activities (RELOADEMPTY → RELOAD_EMPTY, etc.)
--   2. Uses NMRIH's empty/dry variants (_EMPTY, _DRY) when clip is 0
--   3. Plays NMRIH iron sight transition + idle + fire sequences
--   4. Plays NMRIH sprint transition + loop sequences
--   5. Plays NMRIH walk loop sequences
--   6. Routes QC animation event sounds (event 5004)
--
-- Weapon files just set SWEP.Base = "mcv_nmrih_base" and stats. No per-weapon
-- override code needed.

AddCSLuaFile()

DEFINE_BASECLASS("mcv_base")
SWEP.Base = "mcv_base"
local BaseClass = BaseClass

SWEP.Spawnable = false
SWEP.PrintName = "NMRIH Base"
SWEP.Category = "TFA NMRIH (MCV Port)"

-- NMRIH models have normal-length fire animations (not stretched to 60
-- frames like MCV's ported models). ShootAnimRate=0.5 would play them
-- 2× too fast. Set to 1 for correct speed.
SWEP.ShootAnimRate = 1

-- ============================================================
-- NMRIH ACTIVITY LOOKUP
-- ============================================================
-- Some NMRIH activities are standard GMod globals (ACT_VM_RELOAD_EMPTY,
-- ACT_VM_DRYFIRE, etc.). Others might be NMRIH-custom and not exist as
-- Lua globals. We cache whatever we find at first use.

local act_cache = {}

local function get_act(name)
    if act_cache[name] ~= nil then return act_cache[name] end
    local val = _G[name]
    act_cache[name] = val or false
    return val
end

-- ============================================================
-- ACTIVITY REMAP TABLE
-- ============================================================
local ACT_REMAP = {
    [ACT_VM_RELOADEMPTY] = function() return get_act("ACT_VM_RELOAD_EMPTY") end,
    [ACT_VM_SHOOTLAST] = function() return ACT_VM_PRIMARYATTACK_EMPTY end,
    [ACT_VM_READY] = function() return get_act("ACT_VM_DRAW_EMPTY") or ACT_VM_DRAW end,
}

-- ============================================================
-- MUZZLE FLASH FIX
-- ============================================================
-- NMRIH models use numeric attachment names ("1" for muzzle, "2" for
-- shell eject) instead of named ones ("muzzle", "eject"). MCV's
-- DoMuzzle, GetTracerOrigin, and DoEject all use LookupAttachment("muzzle")
-- which returns 0 for NMRIH models, causing the muzzle flash to play
-- at the camera position instead of the gun's muzzle.
--
-- We override GetTracerOrigin and DoMuzzle to try "muzzle" first
-- (for MCV compatibility), then fall back to "1".

function SWEP:GetTracerOrigin()
    local owner = self:GetOwner()
    if SERVER or owner != LocalPlayer() or owner:ShouldDrawLocalPlayer() then
        local id = self:LookupAttachment("muzzle")
        if id == 0 then id = self:LookupAttachment("1") end
        local att = id > 0 and self:GetAttachment(id)
        return att and att.Pos or owner:GetShootPos()
    end
    local vm = owner:GetViewModel()
    local muzz_qca = vm:LookupAttachment("muzzle")
    if muzz_qca == 0 then muzz_qca = vm:LookupAttachment("1") end
    if self:GetAkimbo() and self:Clip1() % 2 == 1 then
        local left = vm:LookupAttachment("muzzleleft")
        if left == 0 then left = vm:LookupAttachment("muzzle2") end
        if left == 0 then left = muzz_qca end
        muzz_qca = left
    end
    local att = muzz_qca > 0 and vm:GetAttachment(muzz_qca)
    if !att then
        return owner:GetShootPos()
    end
    return att.Pos
end

function SWEP:DoMuzzle(alt)
    if !IsFirstTimePredicted() then return end
    local owner = self:GetOwner()
    if !IsValid(owner) then return end
    local vm = owner:IsPlayer() and owner:GetViewModel() or self
    if !IsValid(vm) then return end

    -- Try "muzzle" first, fall back to "1" for NMRIH models
    local muzz_qca = vm:LookupAttachment("muzzle")
    if muzz_qca == 0 then muzz_qca = vm:LookupAttachment("1") end

    if self:GetGrenadeLauncher() and self.RifleGrenadeIsUBGL then
        local gl_muzz = vm:LookupAttachment("muzzle2")
        if gl_muzz > 0 then muzz_qca = gl_muzz end
    end

    local is_volley = self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount

    if self:GetAkimbo() and self:Clip1() % 2 == 1 and !is_volley then
        local left = vm:LookupAttachment("muzzleleft")
        if left == 0 then left = vm:LookupAttachment("muzzle2") end
        if left == 0 then left = muzz_qca end
        muzz_qca = left
    end

    local data = EffectData()
    data:SetEntity(self)
    data:SetAttachment(muzz_qca)
    data:SetMagnitude((self:GetAkimbo() and self:Clip1() % 2 == 1 and !is_volley) and 1 or 0)

    util.Effect("mcv_muzzleeffect", data)

    if self:GetAkimbo() and is_volley then
        local data2 = EffectData()
        data2:SetEntity(self)
        local att4 = vm:LookupAttachment("muzzle2")
        if att4 == 0 then att4 = 4 end
        data2:SetAttachment(att4)
        data2:SetMagnitude(1)
        util.Effect("mcv_muzzleeffect", data2)
    end

    if CLIENT and self:GetOwner() == LocalPlayer() then
        self:DoMuzzleLight()
    elseif game.SinglePlayer() and owner:IsPlayer() then
        self:CallOnClient("DoMuzzleLight")
    end
end

-- ============================================================
-- SHELL EJECT FIX
-- ============================================================
-- Override DoEject to use "2" instead of "eject" for NMRIH models
function SWEP:DoEject(attachment)
    if !IsFirstTimePredicted() then return end
    if self.EjectBrassType == 0 then return end
    local owner = self:GetOwner()
    if !IsValid(owner) then return end
    local vm = owner:IsPlayer() and owner:GetViewModel() or self
    if !IsValid(vm) then return end

    -- Try the passed attachment name, then "eject", then "2" for NMRIH
    local names = {}
    if attachment then table.insert(names, attachment) end
    table.insert(names, "eject")
    table.insert(names, "2")

    if !attachment and self:GetAkimbo() then
        local is_volley = self:GetFiremodeValue() == MCV.FIREMODE_VOLLEY and self:Clip1() >= self.VolleyCount
        if is_volley then
            names = {"eject", "eject2", "2"}
        elseif self:Clip1() % 2 == 1 then
            names = {"eject2", "2"}
        end
    end

    local att_id = 0
    for _, name in ipairs(names) do
        att_id = vm:LookupAttachment(name)
        if att_id > 0 then break end
    end

    if att_id == 0 then return end

    local att = vm:GetAttachment(att_id)
    if !att then return end

    local data = EffectData()
    data:SetEntity(self)
    data:SetOrigin(att.Pos)
    data:SetNormal(att.Ang:Forward())
    data:SetAttachment(att_id)
    data:SetScale(self.EjectBrassType)

    util.Effect("mcv_shelleffect", data)
end

-- ============================================================
-- STATE HELPERS
-- ============================================================
local function is_empty(self)
    return self:Clip1() <= 0
end

local function is_aimed(self)
    return self.GetIronsight and self:GetIronsight() and self.GetSighted and self:GetSighted()
end

local function is_sprinting(self)
    return self.GetIsSprinting and self:GetIsSprinting()
end

local function is_walking(self)
    local owner = self:GetOwner()
    if not IsValid(owner) or not owner:IsPlayer() then return false end
    -- Use actual velocity, NOT MCV's smoothed GetSpeed() which has ~1s lag
    local vel = owner:GetVelocity()
    local speed = math.sqrt(vel.x * vel.x + vel.y * vel.y)
    return speed > 10 and not is_sprinting(self) and not is_aimed(self)
end

-- ============================================================
-- PlayAnimation OVERRIDE
-- ============================================================
function SWEP:PlayAnimation(act, mult, lock, noidle)
    mult = mult or 1
    lock = lock or false
    noidle = noidle or false

    -- Step 1: Activity remap
    local remapped = act
    local remap = ACT_REMAP[act]
    if remap then
        local new_act = remap(self)
        if new_act then remapped = new_act end
    end

    -- Step 2: Iron sight fire redirect
    if remapped == ACT_VM_PRIMARYATTACK and is_aimed(self) then
        local iron_act = get_act("ACT_VM_IRON_FIRE")
        if iron_act then
            if is_empty(self) then
                local dry = get_act("ACT_VM_IRON_FIRE_DRY")
                if dry then remapped = dry end
            elseif self.LastShotAnimation and self:Clip1() == 1 then
                local last = get_act("ACT_VM_IRON_FIRE_LAST")
                if last then remapped = last end
            else
                remapped = iron_act
            end
        end
    end

    -- Step 3: Empty variant redirect
    -- IMPORTANT: Skip empty idle variant while reloading. MCV's Think calls
    -- Idle() BEFORE Think_Reload() calls RestoreClip(). If we remap to
    -- ACT_VM_IDLE_EMPTY while the reload anim just finished, the empty idle
    -- plays for its full loop duration before Idle() re-evaluates.
    local is_reloading = self.GetReloading and self:GetReloading()
    if is_empty(self) and not is_reloading then
        if remapped == ACT_VM_IDLE then
            local e = get_act("ACT_VM_IDLE_EMPTY")
            if e then remapped = e end
        elseif remapped == ACT_VM_DRAW then
            local e = get_act("ACT_VM_DRAW_EMPTY")
            if e then remapped = e end
        elseif remapped == ACT_VM_HOLSTER then
            local e = get_act("ACT_VM_HOLSTER_EMPTY")
            if e then remapped = e end
        elseif remapped == ACT_VM_HITCENTER then
            local e = get_act("ACT_VM_HITCENTER_DRY")
            if e then remapped = e end
        elseif remapped == ACT_VM_FIDGET then
            local e = get_act("ACT_CROSSBOW_FIDGET_UNLOADED")
            if e then remapped = e end
        end
    end

    return BaseClass.PlayAnimation(self, remapped, mult, lock, noidle)
end

-- ============================================================
-- HasAnimation OVERRIDE
-- ============================================================
function SWEP:HasAnimation(act)
    if not act then return false end
    local remap = ACT_REMAP[act]
    if remap then
        local new_act = remap(self)
        if new_act then
            local vm = self:GetOwner():GetViewModel()
            if IsValid(vm) and vm:SelectWeightedSequence(new_act) ~= -1 then return true end
        end
    end
    local vm = self:GetOwner():GetViewModel()
    return IsValid(vm) and vm:SelectWeightedSequence(act) ~= -1
end

-- ============================================================
-- IdleSequence OVERRIDE — iron sight / sprint / walk idle
-- ============================================================
function SWEP:IdleSequence()
    local owner = self:GetOwner()
    if not IsValid(owner) then return nil end
    local vm = owner:GetViewModel()
    if not IsValid(vm) then return nil end

    -- IMPORTANT: MCV's Think calls Idle() BEFORE Think_Reload() calls
    -- RestoreClip(). So when the reload animation finishes, Idle() runs
    -- while the clip is still 0 (hasn't been refilled yet). If we check
    -- is_empty() at this point, it returns true → we'd return the empty
    -- walk/sprint variant. Then RestoreClip fills the clip, but the empty
    -- walk/sprint is already playing.
    -- Fix: if Reloading is still true (hasn't been cleared by Think_Reload
    -- yet), treat the clip as non-empty for idle selection purposes.
    local is_reloading = self.GetReloading and self:GetReloading()
    local empty = is_empty(self) and not is_reloading

    -- Sprint idle
    if is_sprinting(self) then
        local seq = empty and "Sprint_Empty_" or "Sprint_"
        if vm:LookupSequence(seq) ~= -1 then return seq end
        if empty and vm:LookupSequence("Sprint_Dry_") ~= -1 then return "Sprint_Dry_" end
        return nil
    end

    -- NOTE: Iron sight idle and transitions removed — the NMRIH transition
    -- sequences have baked-in viewmodel movement that fights MCV's
    -- IronsightPos/Ang lerp, causing visual misalignment. MCV's native
    -- position lerp handles the visual transition instead. Iron sight
    -- FIRE animation is still handled by the PlayAnimation override above
    -- (redirects ACT_VM_PRIMARYATTACK → ACT_VM_IRON_FIRE when aimed).

    -- Walk idle
    if is_walking(self) then
        local seq = empty and "Walk_Empty" or "Walk"
        if vm:LookupSequence(seq) ~= -1 then return seq end
        if empty and vm:LookupSequence("walk_empty") ~= -1 then return "walk_empty" end
        return nil
    end

    return nil
end

-- ============================================================
-- TRANSITIONS (iron sight enter/exit, sprint enter/exit)
-- ============================================================
local function play_transition(self, seq_name, lock, noidle)
    if not seq_name then return end
    local owner = self:GetOwner()
    local vm = IsValid(owner) and owner:GetViewModel() or nil
    if not IsValid(vm) or vm:LookupSequence(seq_name) == -1 then return end
    self:PlaySequence(seq_name, 1, lock == nil and true or lock, noidle or false)
end

local function think_transitions(self)
    local owner = self:GetOwner()
    if not IsValid(owner) or not owner:IsPlayer() then return end

    local empty = is_empty(self)
    local sprinting = is_sprinting(self)
    local walking = is_walking(self)
    local is_reloading = self.GetReloading and self:GetReloading()

    -- Track empty state for the IdleSequence empty-idle lookup.
    -- We do NOT force SetNextIdle(0) on the empty→non-empty transition
    -- because that can interrupt the reload animation's final frames.
    -- MCV's Idle() will re-evaluate naturally when NextIdle expires,
    -- and at that point is_empty() will return false → regular idle.
    local was_empty = self._nmrihWasEmpty or false
    if empty ~= was_empty then
        self._nmrihWasEmpty = empty
        -- Only force immediate re-evaluation when going TO empty
        -- (fired last round — want the empty idle right after fire anim)
        if empty and not is_reloading and self.SetNextIdle then
            self:SetNextIdle(0)
        end
    end

    -- NOTE: Iron sight transitions removed (see comment above)

    -- Sprint transitions
    -- IMPORTANT: Don't play sprint transitions while reloading OR while a
    -- fire animation is still playing. NMRIH fire animations include the
    -- pump/bolt — interrupting them cuts off that part. Also, playing a
    -- transition animation overrides AnimLockTime (set by the reload anim),
    -- causing Think_Reload to call RestoreClip too early.
    local anim_playing = self.GetNextIdle and self:GetNextIdle() > CurTime()
    if sprinting ~= (self._nmrihWasSprinting or false) then
        if sprinting and not is_reloading and not anim_playing then
            play_transition(self, empty and "Idle_to_Sprint_Empty" or "Idle_to_Sprint", true, false)
        elseif not sprinting and not is_reloading and not anim_playing then
            play_transition(self, empty and "Sprint_to_Idle_Empty" or "Sprint_to_Idle", true, false)
        end
        self._nmrihWasSprinting = sprinting
    end

    -- Walk state tracking: force Idle() to re-evaluate when walk state
    -- changes, so the walk animation starts/stops immediately instead of
    -- waiting for the current idle loop to finish.
    -- IMPORTANT: Don't force NextIdle while reloading — Idle() would play
    -- the sprint/walk idle sequence with lock=false, overriding the reload
    -- animation and setting AnimLockTime=0, cutting the reload short.
    -- Walk/sprint state tracking: force Idle() to re-evaluate when walk/sprint
    -- state changes, so the walk/sprint animation starts/stops immediately.
    -- BUT: only force SetNextIdle(0) when no animation is currently playing.
    -- For NMRIH weapons, the fire animation includes the pump/bolt (shotguns,
    -- bolt-actions, lever-actions). If we force Idle() while the fire
    -- animation is still playing, Idle() plays the walk/sprint sequence via
    -- PlaySequence(lock=false), which overrides the fire animation — cutting
    -- off the pump/bolt.
    -- Check: GetNextIdle() > CurTime() means an animation's idle timer
    -- hasn't expired yet (the fire anim is still playing). Don't interrupt it.
    if not is_reloading then
        local was_walking = self._nmrihWasWalking or false
        if walking ~= was_walking then
            self._nmrihWasWalking = walking
            -- Only force re-evaluation if no animation is currently playing
            -- (NextIdle has already expired → the current idle loop finished)
            if self.SetNextIdle and self:GetNextIdle() <= CurTime() then
                self:SetNextIdle(0)
            end
        end

        if sprinting ~= (self._nmrihWasSprintingForIdle or false) then
            self._nmrihWasSprintingForIdle = sprinting
            if self.SetNextIdle and self:GetNextIdle() <= CurTime() then
                self:SetNextIdle(0)
            end
        end
    else
        self._nmrihWasWalking = walking
        self._nmrihWasSprintingForIdle = sprinting
    end
end

-- ============================================================
-- QC ANIMATION EVENT SOUNDS
-- ============================================================
function SWEP:FireAnimationEvent(pos, ang, event, options, source)
    if event == 5004 or event == 6004 then
        if options and options ~= "" then
            local owner = self:GetOwner()
            if IsValid(owner) then
                owner:EmitSound(options, 75, 100, 1, CHAN_USER_BASE)
            else
                self:EmitSound(options, 75, 100)
            end
        end
        return true
    end
    return BaseClass.FireAnimationEvent and BaseClass.FireAnimationEvent(self, pos, ang, event, options, source) or true
end

-- ============================================================
-- ThinkWeapon OVERRIDE
-- ============================================================
function SWEP:ThinkWeapon()
    think_transitions(self)
    BaseClass.ThinkWeapon(self)
end

-- ============================================================
-- HOLSTER / DEPLOY
-- ============================================================
function SWEP:Holster(wep)
    self._nmrihWasSprinting = false
    self._nmrihWasSprintingForIdle = false
    self._nmrihWasWalking = false
    return BaseClass.Holster(self, wep)
end

function SWEP:Deploy()
    self._nmrihWasSprinting = false
    self._nmrihWasSprintingForIdle = false
    self._nmrihWasWalking = false
    return BaseClass.Deploy(self)
end

-- ============================================================
-- DEBUG
-- ============================================================
concommand.Add("mcv_nmrih_dumpacts", function(ply)
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then print("[NMRIH] No active weapon") return end
    local vm = ply:GetViewModel()
    if not IsValid(vm) then print("[NMRIH] No viewmodel") return end
    print("========================================")
    print("[NMRIH] Viewmodel: " .. tostring(vm:GetModel()))
    print("[NMRIH] Weapon class: " .. tostring(wep:GetClass()))
    print("[NMRIH] Weapon Base: " .. tostring(wep.Base))
    print("========================================")
    print("[NMRIH] Activity globals:")
    local nmrih_acts = {
        "ACT_VM_RELOAD_EMPTY", "ACT_VM_DRAW_EMPTY", "ACT_VM_HOLSTER_EMPTY",
        "ACT_VM_IDLE_EMPTY", "ACT_VM_DRYFIRE", "ACT_VM_HITCENTER_DRY",
        "ACT_VM_IRON_FIRE", "ACT_VM_IRON_FIRE_LAST", "ACT_VM_IRON_FIRE_DRY",
        "ACT_VM_IRON_IDLE", "ACT_VM_IRON_IDLE_DRY",
        "ACT_VM_IDLE_TO_IRON", "ACT_VM_IDLE_TO_IRON_DRY",
        "ACT_VM_IRON_TO_IDLE", "ACT_VM_IRON_TO_IDLE_DRY",
        "ACT_VM_SPRINT", "ACT_VM_SPRINT_DRY",
        "ACT_VM_IDLE_TO_SPRINT", "ACT_VM_IDLE_TO_SPRINT_DRY",
        "ACT_VM_SPRINT_TO_IDLE", "ACT_VM_SPRINT_TO_IDLE_DRY",
        "ACT_VM_WALK", "ACT_VM_WALK_DRY",
    }
    for _, name in ipairs(nmrih_acts) do
        local val = _G[name]
        local status = "MISSING"
        if val then
            local seq = vm:SelectWeightedSequence(val)
            status = "global=" .. tostring(val) .. " seq=" .. tostring(seq)
        end
        print(string.format("  %-30s %s", name, status))
    end
    print("========================================")
    print("[NMRIH] Sequence name lookups:")
    local nmrih_seqs = {
        "Idle_To_Iron", "Idle_To_Iron_Dry", "Idle_Iron", "Idle_Iron_Dry",
        "Iron_To_Idle", "Iron_To_Idle_Dry", "Fire_Iron", "Fire_Iron_Last",
        "Fire_Iron_Dry",
        "Idle_to_Sprint", "Idle_to_Sprint_Empty", "Sprint_", "Sprint_Empty_",
        "Sprint_Dry_", "Sprint_to_Idle", "Sprint_to_Idle_Empty",
        "Walk", "Walk_Empty", "walk_empty",
        "idle", "fire", "fire_last", "draw", "holster",
        "reload_start", "reload_insert", "reload_end",
    }
    for _, name in ipairs(nmrih_seqs) do
        local seq = vm:LookupSequence(name)
        local found = seq >= 0 and "FOUND seq=" .. seq or "NOT FOUND"
        print(string.format("  %-30s %s", name, found))
    end
    print("========================================")
end)
