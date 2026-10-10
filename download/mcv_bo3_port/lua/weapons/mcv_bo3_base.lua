-- mcv_bo3_base: middle-man base between mcv_base and BO3 weapons.

AddCSLuaFile()

DEFINE_BASECLASS("mcv_base")
SWEP.Base = "mcv_base"
local BaseClass = BaseClass

SWEP.Spawnable = false
SWEP.PrintName = "BO3 Base"
SWEP.Category = "Black Ops III"

SWEP.AnimatedSprint = true
SWEP.MantleDuration = 0.6

-- Debug convar
local BO3_DEBUG = CreateConVar("mcv_bo3_debug", "0", FCVAR_REPLICATED, "BO3 debug prints")

-- ============================================================
-- PlayAnimation OVERRIDE
-- ============================================================
function SWEP:PlayAnimation(act, mult, lock, noidle)
    mult = mult or 1
    lock = lock or false
    noidle = noidle or false

    local entry = self.Animations and self.Animations[act]
    if entry then
        local seqName = isfunction(entry) and entry(self) or entry
        if isstring(seqName) and seqName ~= "" then
            local owner = self:GetOwner()
            local vm = IsValid(owner) and owner:GetViewModel() or nil
            if IsValid(vm) and vm:LookupSequence(seqName) ~= -1 then
                local t = self:PlaySequence(seqName, mult, lock, noidle)
                -- Setup AnimSounds for this sequence
                if t and self.AnimSounds and self.AnimSounds[seqName] then
                    local timeline = self.AnimSounds[seqName]
                    if istable(timeline) and #timeline > 0 then
                        self._bo3AnimSounds = timeline
                        self._bo3AnimSoundIdx = 1
                        self._bo3AnimSoundStart = CurTime()
                        self._bo3AnimSoundRate = IsValid(vm) and vm:GetPlaybackRate() or 1
                        if BO3_DEBUG:GetBool() then
                            print("[BO3] AnimSounds setup for '" .. seqName .. "' (" .. #timeline .. " entries)")
                        end
                    end
                end
                return t
            end
        end
    end

    return BaseClass.PlayAnimation(self, act, mult, lock, noidle)
end

function SWEP:HasAnimation(act)
    if not act then return false end
    if self.Animations and self.Animations[act] then return true end
    local vm = self:GetOwner():GetViewModel()
    return IsValid(vm) and vm:SelectWeightedSequence(act) ~= -1
end

-- ============================================================
-- IdleSequence OVERRIDE — sprint idle loop
-- ============================================================
function SWEP:IdleSequence()
    if self.AnimatedSprint and self.GetIsSprinting and self:GetIsSprinting() then
        if self.SprintIdleSequence and self:HasSequence(self.SprintIdleSequence) then
            return self.SprintIdleSequence
        end
    end
    return nil
end

-- ============================================================
-- Helper: play a sequence by name
-- ============================================================
local function play_seq(self, seqName, lock, noidle)
    if not seqName or seqName == "" then return false end
    local owner = self:GetOwner()
    local vm = IsValid(owner) and owner:GetViewModel() or nil
    if not IsValid(vm) then return false end
    if vm:LookupSequence(seqName) == -1 then
        if BO3_DEBUG:GetBool() then print("[BO3] sequence '" .. seqName .. "' NOT on model") end
        return false
    end
    self:PlaySequence(seqName, 1, lock == nil and true or lock, noidle or false)
    return true
end

-- ============================================================
-- ANIM SOUNDS PROCESSING
-- ============================================================
local function process_anim_sounds(self)
    if not self._bo3AnimSounds then return end
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()
    if not ((sp and SERVER) or (not sp and CLIENT and iftp)) then return end

    local owner = self:GetOwner()
    if not IsValid(owner) then
        self._bo3AnimSounds = nil
        return
    end

    local timeline = self._bo3AnimSounds
    local idx = self._bo3AnimSoundIdx
    if idx > #timeline then
        self._bo3AnimSounds = nil
        return
    end

    local elapsed = (CurTime() - self._bo3AnimSoundStart) * (self._bo3AnimSoundRate or 1)
    while idx <= #timeline and elapsed >= (timeline[idx].time or 0) do
        local entry = timeline[idx]
        if entry.sound and entry.sound ~= "" and entry.sound ~= "nil" then
            local snd = entry.sound
            if istable(snd) then snd = snd[math.random(1, #snd)] end
            owner:EmitSound(snd, entry.level or 75, entry.pitch or 100, 1, CHAN_USER_BASE)
            if BO3_DEBUG:GetBool() then print("[BO3] AnimSound: " .. snd .. " at " .. elapsed) end
        end
        idx = idx + 1
    end
    self._bo3AnimSoundIdx = idx
end

-- ============================================================
-- SPRINT TRANSITIONS
-- ============================================================
local function think_sprint(self)
    if not self.AnimatedSprint then return end
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local isRunning = self.GetIsSprinting and self:GetIsSprinting() or false
    local isReloading = self.GetReloading and self:GetReloading() or false
    if self.wasRunning == nil then self.wasRunning = false end

    if BO3_DEBUG:GetBool() and isRunning ~= self.wasRunning then
        print("[BO3] Sprint state: " .. tostring(isRunning) .. " (was " .. tostring(self.wasRunning) .. ")")
    end

    if isRunning and not self.wasRunning then
        if not isReloading and not self._mantleActive then
            if BO3_DEBUG:GetBool() then print("[BO3] Playing sprint_in: " .. tostring(self.SprintInSequence)) end
            play_seq(self, self.SprintInSequence, true, false)
        end
    elseif not isRunning and self.wasRunning then
        if not isReloading and not self._mantleActive then
            if BO3_DEBUG:GetBool() then print("[BO3] Playing sprint_out: " .. tostring(self.SprintOutSequence)) end
            play_seq(self, self.SprintOutSequence, true, false)
        end
    end
    self.wasRunning = isRunning
end

-- ============================================================
-- MANTLE / VAULT
-- ============================================================
local function think_mantle(self)
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    local isVaulting = ply.GetNW2Bool and ply:GetNW2Bool("BO3_IsVaulting", false) or false
    local isMantling = ply.GetNW2Bool and ply:GetNW2Bool("BO3_IsMantling", false) or false
    local isInTraversal = isVaulting or isMantling

    if BO3_DEBUG:GetBool() and isInTraversal ~= (self._mantleActive or false) then
        print("[BO3] Mantle state: vaulting=" .. tostring(isVaulting) .. " mantling=" .. tostring(isMantling))
    end

    if isInTraversal and not self._mantleActive then
        self._mantleActive = true
        self._mantleEndTime = CurTime() + (self.MantleDuration or 0.6)
        if self.SetIronsight then self:SetIronsight(false) end
        if self.SetReloading then self:SetReloading(false) end
        if BO3_DEBUG:GetBool() then print("[BO3] Playing mantle: " .. tostring(self.MantleSequence)) end
        play_seq(self, self.MantleSequence, true, false)
        self:SetNextPrimaryFire(self._mantleEndTime)
        self:SetNextSecondaryFire(self._mantleEndTime)
    elseif not isInTraversal and self._mantleActive then
        self._mantleActive = false
        self._mantleEndTime = nil
    end

    if self._mantleActive and self._mantleEndTime and CurTime() >= self._mantleEndTime then
        self._mantleActive = false
        self._mantleEndTime = nil
    end
end

-- ============================================================
-- ThinkWeapon OVERRIDE
-- ============================================================
function SWEP:ThinkWeapon()
    process_anim_sounds(self)
    think_sprint(self)
    think_mantle(self)
    BaseClass.ThinkWeapon(self)
end

function SWEP:Holster(wep)
    self._mantleActive = false
    self._mantleEndTime = nil
    self.wasRunning = false
    self._bo3AnimSounds = nil
    return BaseClass.Holster(self, wep)
end

function SWEP:Deploy()
    self._mantleActive = false
    self._mantleEndTime = nil
    self.wasRunning = false
    self._bo3AnimSounds = nil
    return BaseClass.Deploy(self)
end
