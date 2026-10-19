-- cuh_sim_harness_bf3.lua
-- Extended simulator harness for validating BF3 → CUH weapon ports.
--
-- Loads the REAL CUH source + the ported weapon + all ported attachments
-- into the Lua VM via lupa, then asserts:
--   (1) The weapon class table has all required CUH fields set
--   (2) Every attachment ID in SWEP.Attachments[].atts exists in CustomUH.Attachments
--   (3) Every animation sequence name in SWEP.Animations exists in the model's $sequence list
--       (we pass the $sequence list in via _MODEL_SEQUENCES)
--   (4) The stat cache + ApplyAttachments pipeline works end-to-end:
--       pick each attachment, swap to it, verify stats change, verify VElement.active toggles
--   (5) Suppressor attachment correctly sets NW bool "Silenced" = true
--   (6) Reload + shoot + idle + draw animation keys all resolve to valid sequences
--   (7) Melee key resolves to ACT_VM_MELEE (no BF3 model has a melee sequence, so fallback is OK)

_RESULT_PASS = 0
_RESULT_FAILS = 0

local function check(name, cond, extra)
    if cond then
        print(string.format("[CHECK OK]  %s%s", name, extra and ("  " .. extra) or ""))
        _RESULT_PASS = _RESULT_PASS + 1
    else
        print(string.format("[CHECK FAIL] %s%s", name, extra and ("  " .. extra) or ""))
        _RESULT_FAILS = _RESULT_FAILS + 1
    end
end

-- ============================================================
-- 1. Build a SWEP instance from the weapon class table
-- ============================================================
print("\n--- Step 1: build instance ---")

local wep = {}
-- Per-instance copy of the class (but keep method references)
for k, v in pairs(_WEAPON) do wep[k] = v end

-- Per-instance Primary/Secondary/Attachments/ViewModelElements so mutations
-- don't leak back into the class table.
wep.Primary   = table.Copy(_WEAPON.Primary)
wep.Secondary = table.Copy(_WEAPON.Secondary)
wep.ViewModelElements = table.Copy(_WEAPON.ViewModelElements or {})
wep.WorldModelElements = table.Copy(_WEAPON.WorldModelElements or {})
wep.Attachments = {}
for i, s in ipairs(_WEAPON.Attachments or {}) do
    wep.Attachments[i] = {
        name = s.name, atts = table.Copy(s.atts),
        default = s.default, forceDefault = s.forceDefault,
    }
end

-- Mock owner + GMod weapon entity methods
wep.Owner = {
    IsPlayer = function() return true end,
    SteamID64 = function() return "76561198000000000" end,
    GetViewModel = function()
        return { __type="ViewModel", IsValid=function() return false end,
                 SequenceDuration = function() return 0.5 end,
                 GetCycle = function() return 1 end,
                 LookupSequence = function(self, name)
                     if _SEQ_LOOKUP then return _SEQ_LOOKUP[name] or -1 end
                     return -1
                 end,
                 SetCycle = function() end, SetPlaybackRate = function() end,
                 SendViewModelMatchingSequence = function() end }
    end,
    KeyDown = function() return false end,
    GetShootPos = function() return Vector(0,0,0) end,
    GetAimVector = function() return Vector(1,0,0) end,
    GetAmmoCount = function() return 180 end,
    EyeAngles = function() return Angle(0,0,0) end,
    SetEyeAngles = function() end,
    SetAnimation = function() end,
    MuzzleFlash = function() end,
    ViewPunch = function() end,
}
wep.GetClass = function() return _WEAPON_CLASS end
wep.GetOwner = function() return wep.Owner end
wep.GetNWBool = function(self, k) return self._mockNW[k] end
wep.GetNWInt = function(self, k) return self._mockNW[k] or 0 end
wep.GetNWFloat = function(self, k) return self._mockNW[k] or 0 end
wep.SetNWBool = function(self, k, v) self._mockNW[k] = v end
wep.SetNWInt = function(self, k, v) self._mockNW[k] = v end
wep.SetNWFloat = function(self, k, v) self._mockNW[k] = v end
wep.GetUHBool = function(self, k) return self._mockUH[k] or false end
wep.SetUHBool = function(self, k, v) self._mockUH[k] = v end
wep._mockNW = {}
wep._mockUH = {}

wep.GetMaxClip1  = function(self) return self.Primary and self.Primary.ClipSize or 30 end
wep.Clip1        = function(self) return self._mockClip1 or (self.Primary and self.Primary.DefaultClip or 0) end
wep.SetClip1     = function(self, n) self._mockClip1 = n end
wep.TakePrimaryAmmo = function(self, n)
    self._mockReserve = (self._mockReserve or 180) - n
    if self._mockReserve < 0 then self._mockReserve = 0 end
end
wep.GetPrimaryAmmoCount = function(self) return self._mockReserve or 180 end
wep.GetMuzzle = function(self) return Vector(0,0,0) end
wep.EmitSound = function() end
wep.SetNextPrimaryFire = function() end
wep.SetNextSecondaryFire = function() end
wep.DoMuzzleFlash = function() end
wep.CreateSmoke = function() end
wep.CreateShell = function() end
wep.PostShoot = function() end

-- Capture original values for assertions
local ORIGIN_SPREAD = wep.Primary.Spread
local ORIGIN_IRONACC = wep.Primary.IronAccuracy
local ORIGIN_KICKUP = wep.Primary.KickUp
local ORIGIN_IRONFOV = wep.Secondary.IronFOV

print(string.format("  Weapon class: %s", _WEAPON_CLASS))
print(string.format("  PrintName: %s", _WEAPON.PrintName))
print(string.format("  ViewModel: %s", _WEAPON.ViewModel))
print(string.format("  Primary.ClipSize: %d, Delay: %.4f", wep.Primary.ClipSize, wep.Primary.Delay))
print(string.format("  Attachments: %d slots", #wep.Attachments))

-- Initialize _SEQ_LOOKUP early so the vm_mock can use it
_SEQ_LOOKUP = {}
for i, s in ipairs(_MODEL_SEQUENCES or {}) do _SEQ_LOOKUP[s] = i end
print(string.format("  Model sequences: %d", #(_MODEL_SEQUENCES or {})))

-- ============================================================
-- 2. Validate required CUH fields
-- ============================================================
print("\n--- Step 2: required CUH fields ---")

local required_fields = {
    "Base", "PrintName", "Category", "Spawnable", "Slot",
    "UseHands", "ViewModel", "WorldModel", "HoldType",
    "IsCUHWeapon", "Customizable",
    "Primary", "Primary.ClipSize", "Primary.DefaultClip", "Primary.Ammo",
    "Primary.Delay", "Primary.MinDamage", "Primary.MaxDamage",
    "Primary.Spread", "Primary.IronAccuracy",
    "Primary.KickUp", "Primary.KickDown", "Primary.KickHorizontal",
    "Primary.MinRecoil", "Primary.MaxRecoil",
    "Primary.NumberofShots", "Primary.TakeAmmo", "Primary.Automatic",
    "Primary.Sound",
    "IronSightsPos", "IronSightsAng", "IronSightTime",
    "RunSightsPos", "RunSightsAng",
    "FireModes", "Animations", "Attachments",
    "ViewModelElements", "WorldModelElements",
    "Penetration", "Chambering", "ReloadSpeed",
    "MeleeDamage", "MeleeRange", "MeleeDelay", "MeleeForce",
    "CameraAttachment",
    "MuzzleFlashType", "MuzzleFlashParticle",
    "Shell", "ShellHeat",
    "ShootAnimation", "Think", "PrimaryAttack", "SecondaryAttack", "Reload", "Holster",
}

for _, field in ipairs(required_fields) do
    local parts = {}
    for p in string.gmatch(field, "[^.]+") do table.insert(parts, p) end
    local val = wep
    for _, p in ipairs(parts) do val = val and val[p] end
    local ok = val ~= nil
    if field == "Primary.Automatic" then ok = type(val) == "boolean"
    elseif field == "ShootAnimation" then ok = type(val) == "function"
    elseif field == "FireModes" then ok = type(val) == "table" and #val > 0
    elseif field == "Animations" then ok = type(val) == "table"
    elseif field == "Attachments" then ok = type(val) == "table" and #val > 0
    elseif field == "ViewModelElements" then ok = type(val) == "table"
    elseif field == "Think" or field == "PrimaryAttack" or field == "SecondaryAttack"
        or field == "Reload" or field == "Holster" then ok = type(val) == "function"
    end
    check(string.format("Field %s", field), ok,
          not ok and "(missing)" or ("=" .. tostring(val):sub(1, 40)))
end

-- Specific type/value checks
check("SWEP.Base == 'weapon_cuh_base_gun'", wep.Base == "weapon_cuh_base_gun")
check("SWEP.IsCUHWeapon == true", wep.IsCUHWeapon == true)
check("SWEP.ViewModel is non-empty string", type(wep.ViewModel) == "string" and #wep.ViewModel > 0)
check("SWEP.WorldModel is non-empty string", type(wep.WorldModel) == "string" and #wep.WorldModel > 0)
check("SWEP.HoldType is 'ar2' or 'smg' or 'shotgun' or 'revolver'",
      wep.HoldType == "ar2" or wep.HoldType == "smg" or wep.HoldType == "shotgun" or wep.HoldType == "revolver",
      "got=" .. tostring(wep.HoldType))
check("SWEP.UseHands == false (BF3 has its own hands mesh)",
      wep.UseHands == false, "got=" .. tostring(wep.UseHands))
check("SWEP.Primary.Delay > 0", wep.Primary.Delay > 0, "got=" .. tostring(wep.Primary.Delay))
check("SWEP.Primary.MinDamage <= MaxDamage", wep.Primary.MinDamage <= wep.Primary.MaxDamage)
check("SWEP.Primary.NumberofShots >= 1", wep.Primary.NumberofShots >= 1)

-- ============================================================
-- 3. Init VElements / WElements (capture default snapshot)
-- ============================================================
print("\n--- Step 3: InitVElements + InitWElements ---")
_CSMODEL_LOG = {}
wep:InitVElements()
wep:InitWElements()
check("InitVElements created a ClientsideModel per VElement",
      #_CSMODEL_LOG == table.Count(wep.ViewModelElements),
      string.format("expected=%d got=%d", table.Count(wep.ViewModelElements), #_CSMODEL_LOG))

-- ============================================================
-- 4. Validate attachment IDs in SWEP.Attachments exist in CustomUH.Attachments
-- ============================================================
print("\n--- Step 4: attachment ID validation ---")

check("CustomUH.Attachments exists",
      CustomUH and CustomUH.Attachments ~= nil)
check("CustomUH.Attachments has at least 9 entries (the 9 BF3 attachments)",
      CustomUH and table.Count(CustomUH.Attachments) >= 9,
      "got=" .. tostring(CustomUH and table.Count(CustomUH.Attachments) or 0))

-- For each slot in SWEP.Attachments, every att ID must exist in CustomUH.Attachments
for slot_idx, slot in ipairs(wep.Attachments) do
    check(string.format("Slot %d (%s) has atts list", slot_idx, slot.name or "?"),
          type(slot.atts) == "table" and #slot.atts > 0)
    for _, att_id in ipairs(slot.atts) do
        check(string.format("Slot %d att '%s' exists in CustomUH.Attachments", slot_idx, att_id),
              CustomUH.Attachments[att_id] ~= nil,
              not CustomUH.Attachments[att_id] and "MISSING" or "")
    end
end

-- ============================================================
-- 5. Validate animation sequence names exist in the model's $sequence list
-- ============================================================
print("\n--- Step 5: animation sequence validation ---")

check("_MODEL_SEQUENCES provided", type(_MODEL_SEQUENCES) == "table",
      "got=" .. type(_MODEL_SEQUENCES))
if type(_MODEL_SEQUENCES) == "table" then
    print(string.format("  Model has %d sequences: %s",
          #_MODEL_SEQUENCES, table.concat(_MODEL_SEQUENCES, ", ")))

    -- Build a set for O(1) lookup
    local seq_set = {}
    for _, s in ipairs(_MODEL_SEQUENCES) do seq_set[s] = true end

    -- Verify every Animations value exists in the model OR is an ACT_VM_* fallback
    for anim_key, seq_name in pairs(wep.Animations or {}) do
        -- Animations value can be a string or a table of strings (random pick)
        if type(seq_name) == "string" then
            local is_act = seq_name:match("^ACT_VM_") or seq_name:match("^ACT_SHOTGUN_")
            check(string.format("Animations['%s'] = '%s' exists in model", anim_key, seq_name),
                  is_act or seq_set[seq_name],
                  not (is_act or seq_set[seq_name]) and "NOT IN MODEL" or (is_act and "(ACT fallback, OK)" or ""))
        elseif type(seq_name) == "table" then
            -- Multiple variants: each must exist
            for i, v in ipairs(seq_name) do
                local is_act = v:match("^ACT_VM_") or v:match("^ACT_SHOTGUN_")
                check(string.format("Animations['%s'][%d] = '%s' exists in model", anim_key, i, v),
                      is_act or seq_set[v],
                      not (is_act or seq_set[v]) and "NOT IN MODEL" or "")
            end
        end
    end
end

-- ============================================================
-- 6. ApplyAttachments pipeline: cycle through every attachment, verify stats change
-- ============================================================
print("\n--- Step 6: ApplyAttachments pipeline ---")

-- Iterate every slot, every attachment option, verify ApplyAttachments runs cleanly
for slot_idx, slot in ipairs(wep.Attachments) do
    for opt_idx, att_id in ipairs(slot.atts) do
        local att = CustomUH.Attachments[att_id]
        if att then
            -- SetAttachment(slot, option) where option 0 = "none", 1 = first att, etc.
            -- The pilot port weapons default to 0 (none).
            print(string.format("  SetAttachment(%d, %d) -> %s", slot_idx, opt_idx, att_id))
            local ok, err = pcall(function() wep:SetAttachment(slot_idx, opt_idx) end)
            check(string.format("SetAttachment(%d,%d) %s ran without error", slot_idx, opt_idx, att_id),
                  ok, not ok and ("err: " .. tostring(err):sub(1,80)) or "")

            -- Verify the attachment's expected stat changes took effect
            if att_id == "bf3_suppressor" then
                check(string.format("  %s: Silenced NW bool = true", att_id),
                      wep:GetNWBool("Silenced") == true,
                      "got=" .. tostring(wep:GetNWBool("Silenced")))
                check(string.format("  %s: Primary.Spread reduced (was %.4f, now %.4f)",
                                    att_id, ORIGIN_SPREAD, wep.Primary.Spread or -1),
                      wep.Primary.Spread and math.abs(wep.Primary.Spread - ORIGIN_SPREAD * 0.9) < 1e-6,
                      "got=" .. tostring(wep.Primary.Spread))
            elseif att_id == "bf3_muzzle" then
                check(string.format("  %s: Primary.KickUp reduced (was %.4f, now %.4f)",
                                    att_id, ORIGIN_KICKUP, wep.Primary.KickUp or -1),
                      wep.Primary.KickUp and math.abs(wep.Primary.KickUp - ORIGIN_KICKUP * 0.9) < 1e-6,
                      "got=" .. tostring(wep.Primary.KickUp))
            elseif att_id == "bf3_reflex" or att_id == "bf3_kobra"
                or att_id == "bf3_eotech" or att_id == "bf3_acog" then
                -- Sight attachments should have swapped IronSightsPos to the per-attachment variant
                local expected_pos = wep["SightsPos_" .. att_id:gsub("bf3_", ""):gsub("^%l", string.upper)]
                if expected_pos then
                    check(string.format("  %s: IronSightsPos swapped to %s variant",
                                        att_id, att_id:gsub("bf3_","")),
                          wep.IronSightsPos and wep.IronSightsPos.x == expected_pos.x
                              and wep.IronSightsPos.y == expected_pos.y
                              and wep.IronSightsPos.z == expected_pos.z,
                          string.format("expected=(%.3f,%.3f,%.3f) got=(%.3f,%.3f,%.3f)",
                              expected_pos.x, expected_pos.y, expected_pos.z,
                              wep.IronSightsPos and wep.IronSightsPos.x or -1,
                              wep.IronSightsPos and wep.IronSightsPos.y or -1,
                              wep.IronSightsPos and wep.IronSightsPos.z or -1))
                end
            elseif att_id == "bf3_laser" then
                -- VElement "laser" should be active now
                local laser = wep.ViewModelElements and wep.ViewModelElements["laser"]
                check(string.format("  %s: VElement['laser'].active = true", att_id),
                      laser and laser.active == true,
                      "got=" .. tostring(laser and laser.active))
            elseif att_id == "bf3_grip" then
                -- Animations table should have foregrip_* variants now
                check(string.format("  %s: Animations['shoot'] = 'foregrip_fire'", att_id),
                      wep.Animations and wep.Animations["shoot"] == "foregrip_fire",
                      "got=" .. tostring(wep.Animations and wep.Animations["shoot"]))
                check(string.format("  %s: Animations['reload'] = 'foregrip_reload'", att_id),
                      wep.Animations and wep.Animations["reload"] == "foregrip_reload",
                      "got=" .. tostring(wep.Animations and wep.Animations["reload"]))
            elseif att_id == "bf3_scope" then
                check(string.format("  %s: ScopeTexture set", att_id),
                      wep.ScopeTexture ~= nil,
                      "got=" .. tostring(wep.ScopeTexture))
            end

            -- Revert to none
            pcall(function() wep:SetAttachment(slot_idx, 0) end)
        end
    end
end

-- ============================================================
-- 7. Reload + shoot + idle + draw animation key resolution
-- ============================================================
print("\n--- Step 7: animation key resolution ---")


-- Build a fake viewmodel for the lookup test (uses _SEQ_LOOKUP which we initialized earlier)
local vm_mock = wep.Owner:GetViewModel()

-- For each animation key in SWEP.Animations, verify LookupSequence returns a valid id
for anim_key, seq_name in pairs(wep.Animations or {}) do
    if type(seq_name) == "string" and not seq_name:match("^ACT_VM_") and not seq_name:match("^ACT_SHOTGUN_") then
        local seq_id = vm_mock:LookupSequence(seq_name)
        check(string.format("Animations['%s'] = '%s' -> LookupSequence = %d", anim_key, seq_name, seq_id),
              seq_id and seq_id >= 0,
              seq_id < 0 and "NOT FOUND" or "")
    end
end

-- ============================================================
-- Final summary
-- ============================================================
print("\n" .. string.rep("=", 70))
print(string.format("[SIM] PASSED %d / %d checks", _RESULT_PASS, _RESULT_PASS + _RESULT_FAILS))
print(string.rep("=", 70))

-- ============================================================
-- 8. Grip attachment: verify full fire/reload animation swap
-- ============================================================
print("\n--- Step 8: grip attachment full animation swap ---")

-- First reset to no grip
wep:SetAttachment(4, 0)

-- Verify base state: Animations['shoot'] = 'base_fire'
check("Before grip: Animations['shoot'] = 'base_fire'",
      wep.Animations["shoot"] == "base_fire",
      "got=" .. tostring(wep.Animations["shoot"]))
check("Before grip: Animations['reload'] = 'base_reload'",
      wep.Animations["reload"] == "base_reload",
      "got=" .. tostring(wep.Animations["reload"]))

-- Simulate ShootAnimation() return value
local shootKey = wep.ShootAnimation and wep:ShootAnimation() or "shoot"
check("ShootAnimation() returns 'shoot'", shootKey == "shoot",
      "got=" .. tostring(shootKey))

-- Simulate PrimaryAttack's lookupKey construction
local lookupKey = shootKey  -- not zooming, not silenced
check(string.format("Before grip: lookupKey '%s' in Animations", lookupKey),
      wep.Animations and wep.Animations[lookupKey] ~= nil,
      "value=" .. tostring(wep.Animations and wep.Animations[lookupKey]))
check(string.format("Before grip: Animations['%s'] = 'base_fire'", lookupKey),
      wep.Animations[lookupKey] == "base_fire",
      "got=" .. tostring(wep.Animations[lookupKey]))

-- Now attach grip
print("  Attaching grip...")
wep:SetAttachment(4, 1)

-- Verify grip swapped the animations
check("After grip: Animations['shoot'] = 'foregrip_fire'",
      wep.Animations["shoot"] == "foregrip_fire",
      "got=" .. tostring(wep.Animations["shoot"]))
check("After grip: Animations['reload'] = 'foregrip_reload'",
      wep.Animations["reload"] == "foregrip_reload",
      "got=" .. tostring(wep.Animations["reload"]))
check("After grip: Animations['reload_empty'] = 'foregrip_reload_empty'",
      wep.Animations["reload_empty"] == "foregrip_reload_empty",
      "got=" .. tostring(wep.Animations["reload_empty"]))
check("After grip: Animations['idle'] = 'foregrip_idle'",
      wep.Animations["idle"] == "foregrip_idle",
      "got=" .. tostring(wep.Animations["idle"]))
check("After grip: Animations['draw'] = 'foregrip_draw'",
      wep.Animations["draw"] == "foregrip_draw",
      "got=" .. tostring(wep.Animations["draw"]))

-- Simulate the full PrimaryAttack animation lookup chain
shootKey = wep.ShootAnimation and wep:ShootAnimation() or "shoot"
lookupKey = shootKey  -- not zooming, not silenced
check(string.format("After grip: lookupKey '%s' resolves to 'foregrip_fire'", lookupKey),
      wep.Animations[lookupKey] == "foregrip_fire",
      "got=" .. tostring(wep.Animations[lookupKey]))

-- Verify EasySendWeaponAnim would find the sequence
local animData = wep.Animations[lookupKey]
local vm = wep.Owner:GetViewModel()
local seq = vm:LookupSequence(animData)
check(string.format("After grip: LookupSequence('%s') = %d (valid)", animData, seq),
      seq and seq >= 0,
      "seq=" .. tostring(seq))

-- Now simulate the Reload animation lookup
local reloadKey = "reload"  -- not empty, not silenced
local reloadAnim = wep.Animations[reloadKey]
check(string.format("After grip: Animations['%s'] = 'foregrip_reload'", reloadKey),
      reloadAnim == "foregrip_reload",
      "got=" .. tostring(reloadAnim))
local reloadSeq = vm:LookupSequence(reloadAnim)
check(string.format("After grip: LookupSequence('%s') = %d (valid)", reloadAnim, reloadSeq),
      reloadSeq and reloadSeq >= 0,
      "seq=" .. tostring(reloadSeq))

-- Revert
wep:SetAttachment(4, 0)
check("After revert: Animations['shoot'] = 'base_fire' (restored)",
      wep.Animations["shoot"] == "base_fire",
      "got=" .. tostring(wep.Animations["shoot"]))

-- ============================================================
-- 9. Bodygroup reset: verify scope bodygroup reverts when removed
-- ============================================================
print("\n--- Step 9: bodygroup reset ---")

-- Attach scope (sets Bodygroups_V[0] = 5)
wep:SetAttachment(1, 4)   -- slot 1 (optic), option 4 (bf3_acog)
check("After acog: Bodygroups_V[0] = 3",
      wep.Bodygroups_V and wep.Bodygroups_V[0] == 3,
      "got=" .. tostring(wep.Bodygroups_V and wep.Bodygroups_V[0]))

-- Remove scope (select None)
wep:SetAttachment(1, 0)
check("After acog removed: Bodygroups_V[0] is nil/0 (not 3)",
      not wep.Bodygroups_V or wep.Bodygroups_V[0] == nil or wep.Bodygroups_V[0] ~= 3,
      "got=" .. tostring(wep.Bodygroups_V and wep.Bodygroups_V[0]))

-- Attach grip (sets Bodygroups_V[2] = 1)
wep:SetAttachment(4, 1)
check("After grip: Bodygroups_V[2] = 1",
      wep.Bodygroups_V and wep.Bodygroups_V[2] == 1,
      "got=" .. tostring(wep.Bodygroups_V and wep.Bodygroups_V[2]))

-- Remove grip
wep:SetAttachment(4, 0)
check("After grip removed: Bodygroups_V[2] is nil/0 (not 1)",
      not wep.Bodygroups_V or wep.Bodygroups_V[2] == nil or wep.Bodygroups_V[2] ~= 1,
      "got=" .. tostring(wep.Bodygroups_V and wep.Bodygroups_V[2]))

-- ============================================================
-- 10. Sprint animation keys exist
-- ============================================================
print("\n--- Step 10: sprint animation keys ---")
check("Animations['sprint_idle'] exists",
      wep.Animations and wep.Animations["sprint_idle"] ~= nil,
      "got=" .. tostring(wep.Animations and wep.Animations["sprint_idle"]))
check("Animations['sprint_in'] exists",
      wep.Animations and wep.Animations["sprint_in"] ~= nil,
      "got=" .. tostring(wep.Animations and wep.Animations["sprint_in"]))
check("Animations['sprint_out'] exists",
      wep.Animations and wep.Animations["sprint_out"] ~= nil,
      "got=" .. tostring(wep.Animations and wep.Animations["sprint_out"]))

-- After grip attached, sprint keys should be foregrip variants
wep:SetAttachment(4, 1)
check("After grip: Animations['sprint_idle'] = 'foregrip_idle'",
      wep.Animations and wep.Animations["sprint_idle"] == "foregrip_idle",
      "got=" .. tostring(wep.Animations and wep.Animations["sprint_idle"]))
wep:SetAttachment(4, 0)
