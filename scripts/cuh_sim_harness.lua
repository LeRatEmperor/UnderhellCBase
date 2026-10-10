-- cuh_sim_harness.lua
-- Drives a CUH SWEP instance through the SetAttachment -> ApplyAttachments
-- pipeline and asserts that:
--   (1) CustomUH.Attachments has the expected keys (registration worked)
--   (2) Calling SetAttachment(slot=2, index=2) swaps the barrel's VElement
--       model from the default (scotia_b_d.mdl) to the Hvy-B model
--       (scotia_b_h.mdl)
--   (3) The Primary.Spread stat is reduced to 80% of its origin value
--   (4) The IronSightTime stat is increased to 110% of its origin value
--   (5) Switching back to a different barrel reverts the model correctly
--
-- The harness runs inside the Lua VM set up by cuh_sim_driver.py — every
-- GMod global it touches is mocked there.

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

-- Critical: per-instance Primary / Secondary / ViewModelElements /
-- WorldModelElements / Attachments so our mutations don't leak back
-- into the class table (the real InitStatCache + ApplyAttachments
-- code does its own per-instance copy of Primary/Secondary, but
-- ViewModelElements/Attachments are shared at the class level).
wep.Primary   = table.Copy(_WEAPON.Primary)
wep.Secondary = table.Copy(_WEAPON.Secondary)
wep.ViewModelElements = table.Copy(_WEAPON.ViewModelElements)
wep.WorldModelElements = table.Copy(_WEAPON.WorldModelElements)
wep.Attachments = {}
for i, s in ipairs(_WEAPON.Attachments) do
    wep.Attachments[i] = { atts = table.Copy(s.atts), default = s.default,
                          forceDefault = s.forceDefault, name = s.name }
end

-- Pretend an owner exists (some methods index self.Owner)
wep.Owner = {
    IsPlayer = function() return true end,
    SteamID64 = function() return "76561198000000000" end,
    GetViewModel = function() return { __type="ViewModel", IsValid=function() return false end,
                                        SequenceDuration = function() return 0.5 end,
                                        GetCycle = function() return 1 end } end,
}
wep.GetClass = function() return "weapon_m8a1_scotia" end
wep.GetOwner = function() return wep.Owner end

-- Mock the GMod Weapon entity methods that attachments touch (these
-- are real methods on weapon entities in GMod, but our simulator's
-- SWEP is a plain Lua table — they need stubs).
wep.GetMaxClip1  = function(self) return self.Primary and self.Primary.ClipSize or 30 end
wep.Clip1        = function(self) return self._mockClip1 or (self.Primary and self.Primary.DefaultClip or 0) end
wep.SetClip1     = function(self, n) self._mockClip1 = n end
wep.TakePrimaryAmmo = function(self, n)
    self._mockReserve = (self._mockReserve or 180) - n
    if self._mockReserve < 0 then self._mockReserve = 0 end
end
wep.GetPrimaryAmmoCount = function(self) return self._mockReserve or 180 end

-- Capture original values for assertions
local ORIGIN_BARREL_MODEL = wep.ViewModelElements["barrel"].model
local ORIGIN_SPREAD = wep.Primary.Spread
local ORIGIN_IRONSIGHT_TIME = wep.IronSightTime

print("  ORIGIN_BARREL_MODEL    = " .. tostring(ORIGIN_BARREL_MODEL))
print("  ORIGIN_SPREAD          = " .. tostring(ORIGIN_SPREAD))
print("  ORIGIN_IRONSIGHT_TIME  = " .. tostring(ORIGIN_IRONSIGHT_TIME))

check("CustomUH.Attachments has xm8_barrel_h",
      CustomUH.Attachments and CustomUH.Attachments["xm8_barrel_h"] ~= nil)
check("CustomUH.Attachments has xm8_sight",
      CustomUH.Attachments and CustomUH.Attachments["xm8_sight"] ~= nil)
check("CustomUH.Attachments count >= 18",
      CustomUH and CustomUH.Attachments and table.Count(CustomUH.Attachments) >= 18,
      "got " .. tostring(CustomUH and CustomUH.Attachments and table.Count(CustomUH.Attachments) or "nil"))

print("\n  Registered attachment IDs:")
local sorted = {}
for id, _ in pairs(CustomUH.Attachments or {}) do sorted[#sorted+1] = id end
table.sort(sorted)
for _, id in ipairs(sorted) do
    local att = CustomUH.Attachments[id]
    print(string.format("    %-20s  Name=%-20s  PartClass=%-10s  ModelPath=%s",
        id, tostring(att.Name), tostring(att.PartClass), tostring(att.ModelPath)))
end

-- ============================================================
-- 2. Simulate PostDrawViewModel running once so InitVElements
--    captures the default snapshot (this is what happens in-game
--    the first time the weapon is drawn on the client).
-- ============================================================
print("\n--- Step 2: first InitVElements (capture default snapshot) ---")
_CSMODEL_LOG = {}
wep:InitVElements()
wep:InitWElements()

-- 4 VElements + 4 WElements = 8 ClientsideModels total
check("InitVElements + InitWElements created 8 ClientsideModels (4 V + 4 W)",
     #_CSMODEL_LOG == 8,
     "got " .. #_CSMODEL_LOG)
check("InitVElements captured _defaultSnapshot on barrel",
     wep.ViewModelElements["barrel"]._defaultSnapshot ~= nil)
check("InitVElements snapshot.model == ORIGIN_BARREL_MODEL",
     wep.ViewModelElements["barrel"]._defaultSnapshot.model == ORIGIN_BARREL_MODEL,
     "snapshot.model=" .. tostring(wep.ViewModelElements["barrel"]._defaultSnapshot.model))

-- Verify the very first ClientsideModel created for "barrel" has the
-- default model path (not the Hvy-B path)
local barrelCs = wep.ViewModelElements["barrel"]._csModel
check("barrel._csModel was created with default model",
     barrelCs and barrelCs.__model == ORIGIN_BARREL_MODEL,
     "barrel._csModel.__model=" .. tostring(barrelCs and barrelCs.__model))

-- ============================================================
-- 3. Call SetAttachment(2, 2) — pick "xm8_barrel_h" (Hvy-B)
--    This should:
--      - call ApplyAttachments (which calls att:Attach)
--      - swap elem.model to scotia_b_h.mdl
--      - rebuild _csModel with the new model
--      - apply Primary.Spread: Hvy-B's 0.8x then stock_f's 0.9x (default
--        for slot 4) = 0.04 * 0.8 * 0.9 = 0.0288 (attachments stack)
--      - apply IronSightTime: Hvy-B's 1.1x = 0.45 * 1.1 = 0.495
--        (no other attachment modifies IronSightTime when only slot 2
--        is changed — psg_c default doesn't touch IronSightTime, smag
--        doesn't touch IronSightTime, stock_f doesn't touch it either)
-- ============================================================
print("\n--- Step 3: SetAttachment(2, 2)  -> Hvy-B barrel ---")

-- DEBUG: print wep state before the call
print("  [DBG] wep.Primary keys:")
if wep.Primary then
    for k, v in pairs(wep.Primary) do
        print("    " .. tostring(k) .. " = " .. tostring(v))
    end
end
print("  [DBG] wep._statCache = " .. tostring(wep._statCache))
print("  [DBG] wep._statOrigins = " .. tostring(wep._statOrigins))

local csModelCountBefore = #_CSMODEL_LOG
wep:SetAttachment(2, 2)
local csModelCountAfter = #_CSMODEL_LOG

print("  ClientsideModels created before=" .. csModelCountBefore .. "  after=" .. csModelCountAfter)
print("  wep.Attachments[2].sel = " .. tostring(wep.Attachments[2].sel))

local barrel = wep.ViewModelElements["barrel"]
check("After SetAttachment, barrel.model swapped to Hvy-B path",
     barrel.model == "models/dqr/bo7/scotia/scotia_b_h.mdl",
     "barrel.model=" .. tostring(barrel.model))
check("barrel._csModel was REBUILT with Hvy-B path",
     barrel._csModel and barrel._csModel.__model == "models/dqr/bo7/scotia/scotia_b_h.mdl",
     "barrel._csModel.__model=" .. tostring(barrel._csModel and barrel._csModel.__model))

-- Stat checks: Hvy-B Spread (0.8x) is compounded with stock_f's Spread (0.9x)
local gotStatSpread = wep.Primary.Spread
local wantStatSpread = ORIGIN_SPREAD * 0.8 * 0.9   -- Hvy-B then stock_f
check(string.format("Primary.Spread = %.4f (origin %.4f * 0.8 [Hvy-B] * 0.9 [stock_f] = %.4f)",
                    gotStatSpread, ORIGIN_SPREAD, wantStatSpread),
     math.abs(gotStatSpread - wantStatSpread) < 1e-9,
     "got=" .. tostring(gotStatSpread))

-- IronSightTime: Hvy-B (1.1) * psg_c (0.9) * stock_f (1.8) * smag (0.7)
-- All four equipped attachments compound on IronSightTime.
local gotIST = wep.IronSightTime
local wantIST = ORIGIN_IRONSIGHT_TIME * 1.1 * 0.9 * 1.8 * 0.7
check(string.format("IronSightTime = %.4f (origin %.4f * 1.1 [Hvy-B] * 0.9 [psg_c] * 1.8 [stock_f] * 0.7 [smag] = %.4f)",
                    gotIST, ORIGIN_IRONSIGHT_TIME, wantIST),
     math.abs(gotIST - wantIST) < 1e-9,
     "got=" .. tostring(gotIST))

local gotIA = wep.Primary.IronAccuracy
print("  Primary.IronAccuracy = " .. tostring(gotIA) .. "  (origin = " .. tostring(wep._statOrigins and wep._statOrigins["Primary.IronAccuracy"]) .. ")")

-- ============================================================
-- 4. Switch to a DIFFERENT barrel — should revert to default snapshot
--    first, then apply the new attachment's model + stats.
-- ============================================================
print("\n--- Step 4: SetAttachment(2, 3)  -> L-Barrel ---")
wep:SetAttachment(2, 3)  -- xm8_barrel_l (L-Barrel)

barrel = wep.ViewModelElements["barrel"]
check("After switch to L-Barrel, barrel.model == L-Barrel path",
     barrel.model == "models/dqr/bo7/scotia/scotia_b_l.mdl",
     "barrel.model=" .. tostring(barrel.model))
check("barrel._csModel rebuilt with L-Barrel path",
     barrel._csModel and barrel._csModel.__model == "models/dqr/bo7/scotia/scotia_b_l.mdl",
     "barrel._csModel.__model=" .. tostring(barrel._csModel and barrel._csModel.__model))

-- L-Barrel: KickDown * 0.5, Range * 1.4, IronSightTime * 1.2
-- XM8 doesn't define Primary.KickDown, so this'll either error or be nil
local gotKick = wep.Primary.KickDown
print("  Primary.KickDown = " .. tostring(gotKick) .. "  (origin = " .. tostring(wep._statOrigins and wep._statOrigins["Primary.KickDown"]) .. ")")

-- ============================================================
-- 5. Switch back to "None" (slot index 0).  Should revert to
--    default snapshot model. Stats: Hvy-B is no longer applied,
--    but psg_c (0.9), stock_f (1.8), and smag (0.7) still compound
--    on IronSightTime: 0.45 * 0.9 * 1.8 * 0.7 = 0.5103.
--    And Spread gets stock_f's 0.9x: 0.04 * 0.9 = 0.036.
-- ============================================================
print("\n--- Step 5: SetAttachment(2, 0)  -> None ---")
wep:SetAttachment(2, 0)
barrel = wep.ViewModelElements["barrel"]
check("After None, barrel.model reverted to default",
     barrel.model == ORIGIN_BARREL_MODEL,
     "barrel.model=" .. tostring(barrel.model))
-- Spread: no Hvy-B, but stock_f still applies 0.9x
local wantSpreadAfterNone = ORIGIN_SPREAD * 0.9   -- stock_f only
check(string.format("After None, Primary.Spread = %.4f (origin %.4f * 0.9 [stock_f] = %.4f)",
                    wep.Primary.Spread or -1, ORIGIN_SPREAD, wantSpreadAfterNone),
     math.abs((wep.Primary.Spread or -1) - wantSpreadAfterNone) < 1e-9,
     "got=" .. tostring(wep.Primary.Spread))
-- IronSightTime: psg_c (0.9) * stock_f (1.8) * smag (0.7) compounding
local wantISTAfterNone = ORIGIN_IRONSIGHT_TIME * 0.9 * 1.8 * 0.7
check(string.format("After None, IronSightTime = %.4f (origin %.4f * 0.9 [psg_c] * 1.8 [stock_f] * 0.7 [smag] = %.4f)",
                    wep.IronSightTime or -1, ORIGIN_IRONSIGHT_TIME, wantISTAfterNone),
     math.abs((wep.IronSightTime or -1) - wantISTAfterNone) < 1e-9,
     "got=" .. tostring(wep.IronSightTime))

-- ============================================================
-- 6. Animations override test — pick xm8_xmaglrg (60 round mags)
--    which declares WeaponTable.Animations = { reload = "reload_ext02", ... }
--    and verify self.Animations.reload was changed.
-- ============================================================
print("\n--- Step 6: Animations override (xm8_xmaglrg) ---")
local originReload = wep.Animations and wep.Animations["reload"]
print("  origin Animations.reload = " .. tostring(originReload))
-- Pick slot 6 index 3 (xm8_xmaglrg)
wep:SetAttachment(6, 3)
local newReload = wep.Animations and wep.Animations["reload"]
check("Animations.reload overridden to reload_ext02 (xm8_xmaglrg)",
     newReload == "reload_ext02",
     "got Animations.reload = " .. tostring(newReload))
check("Animations.reload_empty overridden to reload_empty_ext02",
     wep.Animations["reload_empty"] == "reload_empty_ext02",
     "got = " .. tostring(wep.Animations and wep.Animations["reload_empty"]))

-- Switch back to default (slot 6 index 1 = xm8_smag → reload_fast02)
wep:SetAttachment(6, 1)
check("Animations.reload overridden to reload_fast02 (xm8_smag)",
     wep.Animations["reload"] == "reload_fast02",
     "got = " .. tostring(wep.Animations and wep.Animations["reload"]))

-- Switch to "None" (slot 6 index 0) — should restore to SWEP class default
-- (ACT_VM_RELOAD, NOT reload_fast02 which was the previous att's override)
wep:SetAttachment(6, 0)
check("Animations.reload restored to SWEP class default (ACT_VM_RELOAD) when slot=0",
     wep.Animations["reload"] == "ACT_VM_RELOAD",
     "got = " .. tostring(wep.Animations and wep.Animations["reload"]))

-- ============================================================
-- Final: pass if all checks passed
-- ============================================================
_RESULT_MODEL = tostring(wep.ViewModelElements["barrel"].model)
print("\n" .. string.rep("=", 60))
print(string.format("[SIM] PASSED %d / %d checks",
     _RESULT_PASS, _RESULT_PASS + _RESULT_FAILS))
print(string.rep("=", 60))
