-- BO3 Shotgun base for MCV (Military Conflict: Vietnam)
-- Sits between mcv_bo3_base and individual BO3 shotgun weapons.
-- Uses MCV's native shotgun reload system but with BO3 sequence names.
--
-- Key difference from mcv_bo3_base:
--   - Shotgun reload loop is driven by the BO3 model's auto-transition:
--     start_reload -> reload_loop (infinite) -> after_reload
--   - We DON'T manually restart reload_loop each cycle (MCV does that);
--     we let the model transition naturally and only insert shells on a timer.

AddCSLuaFile()

SWEP.Base       = "mcv_bo3_base"
SWEP.Spawnable  = false
SWEP.PrintName  = "BO3 Shotgun Base"
SWEP.Category   = "Black Ops III"

-- Shotgun-specific
SWEP.ShotgunReload = true
SWEP.ShotgunReloadRounds = 1
SWEP.ShotgunReloadEmptyStartAnimation = false

-- BO3 shotguns use an infinite-loop reload animation in the model.
-- Shell insertion cadence (per shell).
SWEP.ShellLoadTime = 0.6

-- Override the per-shell reload to match BO3's animation-driven loop.
-- MCV's base sh_reload handles shotgun reload via:
--   1. Play ACT_SHOTGUN_RELOAD_START
--   2. Loop ACT_VM_RELOAD until clip is full or player fires
--   3. Play ACT_SHOTGUN_RELOAD_FINISH
--
-- BO3 models auto-transition between these states via their own QC
-- sequence transitions, so we just need to make sure the right
-- sequences get played. The Animations table remap in mcv_bo3_base
-- handles the names. We just need to make sure the model's
-- base_reload_in / base_reload_out / base_reload_loop sequences are
-- mapped correctly in the per-weapon Animations table.

-- PostShoot: BO3 pumps (for pump-action shotguns)
-- MCV's base sh_shoot handles the pump via PlayCycleAnimation +
-- CyclePostDelay, but BO3 pumps are triggered as a PostShoot anim.
-- We keep MCV's system but ensure the "pump" Animations key is set.
if SERVER then return end
