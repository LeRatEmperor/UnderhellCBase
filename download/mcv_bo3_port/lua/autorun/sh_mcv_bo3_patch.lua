-- MCV BO3 Animation Patch
-- ============================================================
-- Patches mcv_base_core.PlayAnimation + HasAnimation ONCE, globally.
-- Any weapon with a SWEP.Animations table can use sequence names
-- instead of ACT_VM_* activity tags.
--
-- Weapon files just do:
--   SWEP.Base = "mcv_base"
--   SWEP.Animations = {
--       [ACT_VM_PRIMARYATTACK] = "base_fire",     -- string: sequence name
--       [ACT_VM_RELOAD] = function(self)         -- function: state-aware
--           return self:Clip1() <= 0 and "base_reload_empty" or "base_reload"
--       end,
--   }
--
-- That's it. No per-weapon override code. MCV's Reload/Deploy/Idle/etc.
-- all work natively because they call self:PlayAnimation(ACT_VM_X) which
-- hits our patch and translates to the sequence name.
--
-- The patch falls through to MCV's native PlayAnimation if:
--   - The weapon has no Animations table, OR
--   - The Animations table has no entry for the activity, OR
--   - The model doesn't have the named sequence
-- MCV's own weapons are completely unaffected.

AddCSLuaFile()

local function patch_mcv()
    local core = weapons.GetStored("mcv_base_core")
    if not core then return false end
    if core._bo3_patched then return true end

    local MCV_PlayAnimation = core.PlayAnimation
    local MCV_HasAnimation = core.HasAnimation
    if not MCV_PlayAnimation then return false end

    -- Wrap PlayAnimation: check Animations table first, fall back to native.
    -- If a mapping exists, call self:PlaySequence(seqName, ...) which resolves
    -- via inheritance to mcv_base_core.PlaySequence, which calls applySequence
    -- internally — same code path MCV uses, just routed through LookupSequence
    -- instead of SelectWeightedSequence.
    core.PlayAnimation = function(self, act, mult, lock, noidle)
        mult = mult or 1
        lock = lock or false
        noidle = noidle or false

        local entry = self.Animations and self.Animations[act]
        if entry then
            local seqName = entry
            if isfunction(entry) then seqName = entry(self) end

            if isstring(seqName) and seqName ~= "" then
                -- self:PlaySequence resolves via inheritance to mcv_base_core.PlaySequence
                -- which does vm:LookupSequence(name) and applySequence().
                -- If the sequence doesn't exist, PlaySequence prints "INVALID SEQUENCE"
                -- and returns nil — same as MCV's native "INVALID ACT" path.
                return self:PlaySequence(seqName, mult, lock, noidle)
            end
        end

        -- Fall through to MCV's native PlayAnimation (uses SelectWeightedSequence)
        return MCV_PlayAnimation(self, act, mult, lock, noidle)
    end

    -- Wrap HasAnimation so MCV's Deploy() check works:
    --   if self:HasAnimation(ACT_VM_READY) then ...
    if MCV_HasAnimation then
        core.HasAnimation = function(self, act)
            if not act then return false end
            if self.Animations and self.Animations[act] then return true end
            return MCV_HasAnimation(self, act)
        end
    end

    core._bo3_patched = true
    print("[MCV_BO3] Patched mcv_base_core.PlayAnimation + HasAnimation")
    return true
end

-- Wait for MCV to register, then patch.
hook.Add("Think", "MCV_BO3_Patch", function()
    if patch_mcv() then
        hook.Remove("Think", "MCV_BO3_Patch")
    end
end)

concommand.Add("mcv_bo3_status", function()
    local core = weapons.GetStored("mcv_base_core")
    print("[MCV_BO3] mcv_base_core found: " .. tostring(core ~= nil))
    if core then
        print("[MCV_BO3] _bo3_patched: " .. tostring(core._bo3_patched))
    end
end)
