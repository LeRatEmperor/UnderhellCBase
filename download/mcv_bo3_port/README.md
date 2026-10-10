# Black Ops 3 Weapons - MCV Port

Black Ops 3 weapons ported to MCV (Military Conflict: Vietnam) base.

**Self-contained. No helper script. No external dependencies.**

## Files

```
lua/weapons/
  mcv_bo3_mr6.lua             -- MR6 pistol (semi-auto)
  mcv_bo3_m8a7.lua            -- M8A7 assault rifle (4-round burst + semi)
  mcv_bo3_icr1.lua            -- ICR-1 assault rifle (auto + semi)
  mcv_bo3_drakon_unscoped.lua -- Drakon with red dot (auto + semi)
  mcv_bo3_krm262.lua          -- KRM-262 pump-action shotgun
```

## How it works

Each weapon file:
1. Sets `SWEP.Base = "mcv_base"` — direct inheritance from MCV's gun base
2. Sets `SWEP.Animations = { ["shoot"] = "base_fire", ... }` — BO3 sequence names
3. Defines `function SWEP:PlayAnimation(act, mult, lock, noidle)` inline that:
   - Maps MCV's `ACT_VM_*` activity to a BO3 sequence name via `SWEP.Animations`
   - Calls `self:PlaySequence(name, mult, lock, noidle)` — which resolves via Lua inheritance to `mcv_base_core.PlaySequence`, which uses `vm:LookupSequence(name)` (works for BO3 models that don't have activity tags)
   - Falls back to `BaseClass.PlayAnimation(self, act, mult, lock, noidle)` if no mapping exists

`BaseClass` is GMod's built-in global that points to the parent SWEP class table. It's available when methods are CALLED (at runtime), even if it wasn't available at file load time. This means `BaseClass.PlayAnimation` calls MCV's native `PlayAnimation` correctly.

Each weapon also includes:
- AnimSounds timeline (timed sounds during reload anims)
- Mantle/vault detection (`BO3_IsVaulting` / `BO3_IsMantling` networked vars from BO3 parkour addon)
- Sprint animations (sprint_in / sprint_idle / sprint_out)
- ThinkWeapon override that runs BO3 state machines then delegates to MCV's ThinkWeapon

## Install

1. Copy `lua/weapons/*.lua` into your GMod addon's `lua/weapons/` folder
2. MCV must be installed first
3. Weapons appear in spawn menu under **Black Ops III**

## Debugging

Run `mcv_bo3_dumpseqs` in console while holding a weapon to dump every sequence in its viewmodel and verify which Animations entries match. Output looks like:

```
[BO3] Viewmodel: models/loyalists/blackops3/mr6/v_pistol_mr6.mdl
[BO3] 24 sequences:
  [0] idle                                    act=0      dur=2.500
  [1] base_fire                               act=0      dur=0.300
  [2] base_reload                             act=0      dur=2.000
  ...
[BO3] Animations table:
  ["shoot"]      = base_fire                  ->  FOUND seq=1
  ["reload"]     = base_reload                ->  FOUND seq=2
  ["idle"]       = base_idle                  ->  NOT FOUND
```

If you see "NOT FOUND" for a key, that sequence name doesn't exist in the model — fix the name in `SWEP.Animations` to match what `dumpseqs` shows.

## Key facts

- **BO3 models have NO `ACT_VM_*` activity tags.** They only have named sequences like `base_fire`, `base_reload`, etc.
- **MCV's `PlayAnimation` uses `vm:SelectWeightedSequence(act)`** which returns -1 for BO3 models (no activity tags).
- **MCV's `PlaySequence` uses `vm:LookupSequence(name)`** which works for BO3 models.
- **Our override** intercepts `PlayAnimation`, translates the ACT_VM to a sequence name, then calls `self:PlaySequence(name)` — same path mantle/sprint use, which we know works.

## Stats conversion

| BO3 / Underhell field | MCV field | Formula |
|---|---|---|
| `Primary.MinDamage` + `MaxDamage` | `DamageGeneric` | `(Min + Max) / 2` |
| `Primary.Delay` (sec) | `FireRate` (RPM) | `60 / Delay` |
| `Primary.Spread` (0.001-1.2) | `Spread` (3-15) + `SpreadIronsighted` (~1) | tune by feel |
| `Primary.MinRecoil` + `MaxRecoil` (neg) | `ViewSlideRecoilUp` (pos) | `-avg(Min, Max)` |
| `Primary.NumberofShots` | `Num` | direct copy |
| `Chambering = true` | `Primary.Chamber = 1` | |
| `IronSightsPos` (Vector) | `IronsightPos` (Vector) | direct copy |
| `IronSightsAng` (Vector) | `IronsightAng` (Angle) | convert type |
| "4 Round Burst" firemode | `MCV.FIREMODE_BURST` + `BurstRounds = 4` | MCV native burst |
| "Full-Auto" firemode | `MCV.FIREMODE_AUTO` | |
| "Semi-Auto" firemode | `MCV.FIREMODE_SEMI` | |
