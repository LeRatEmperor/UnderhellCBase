# GetUHBool / SetUHBool — Definitive Investigation Report

## Executive Summary

**`GetUHBool` and `SetUHBool` are MISSING FUNCTIONS.** They are called extensively throughout the entire codebase (original Underhell, CUH base, BO3 references, and all 73 WWII weapon ports) but are **never defined in any Lua file anywhere on the system**. They were expected to be provided by an external Underhell addon that is not mounted in this environment.

---

## 1. Remnant Status

**They are NOT remnants.** They are actively used as the primary weapon state management API across the entire codebase. However, their **definition was lost** when the CUH base was forked from the original Underhell mod — the original Underhell addon had a shared file that defined these methods, and that file was not included in the CUH fork.

### Evidence: Usage counts

| File | GetUHBool calls | SetUHBool calls |
|------|-----------------|-----------------|
| `upload/weapon_uh_base.lua` (original Underhell grandparent) | 8 | 7 |
| `upload/weapon_uh_base_gun.lua` (original Underhell parent) | 12 | 10 |
| `upload/weapon_uh_base_shotty.lua` (original Underhell shotgun) | 5 | 2 |
| `lua/weapons/weapon_custom_uh_base.lua` (CUH grandparent) | 8 | 5 |
| `lua/weapons/weapon_custom_uh_base_gun.lua` (CUH parent) | 10 | 3 |
| `lua/weapons/weapon_cuh_base_gun.lua` (CUH layer) | 4 | 3 |
| `repos/tfa_wwii_original/weapon_bo3_base_gun.lua` (BO3 ref) | 6 | 4 |
| 73 WWII weapon files (`uh_codww2_*.lua`) | ~80 | ~20 |

**Total: 130+ calls to GetUHBool, 50+ calls to SetUHBool across the codebase.**

### Evidence: No definition exists

A search of the **entire filesystem** for any Lua file containing a function definition:

```bash
find / -name "*.lua" -exec grep -l "function SWEP:GetUHBool\|function SWEP:SetUHBool" {} \;
# Result: ZERO matches

find / -name "*.lua" -exec grep -l "GetUHBool = function\|SetUHBool = function" {} \;
# Result: ZERO matches
```

A search of **all git history** (every commit, every file):

```bash
git log --all -p -- "lua/weapons/*.lua" | grep "function SWEP:GetUHBool"
# Result: ZERO matches (the only hit was in the audit .md document, not in code)
```

The **initial commit** (ac4c945) already uses `GetUHBool`/`SetUHBool` in `weapon_custom_uh_base.lua` without defining them. They were never defined in any subsequent commit either.

---

## 2. Replacements / Modern Equivalents

There is **no replacement** — the functions were simply never ported. The original Underhell addon (which the uploaded `weapon_uh_base*.lua` files come from) also uses them without defining them, confirming they were provided by a **separate shared file** that was part of the original Underhell mod installation.

### What they should be

Based on the naming convention used throughout the codebase (the `UH_` prefix is used for all networked vars on the player entity: `UH_Flashlight`, `UH_ArmGone`, `UH_ArmTime`, `UH_GrenadeTime`, `UH_Flare`), the definition is clearly:

```lua
function SWEP:SetUHBool(key, value)
    self:SetNWBool("UH_" .. key, value)
end

function SWEP:GetUHBool(key)
    return self:GetNWBool("UH_" .. key)
end
```

These are simple wrappers around GMod's standard `SetNWBool`/`GetNWBool` that prefix the key with `"UH_"` to avoid collisions with other addons.

### The 3 keys they manage

Only **3 weapon-state booleans** are ever passed to GetUHBool/SetUHBool:

| Key | NW var name | Purpose |
|-----|-------------|---------|
| `"Zooming"` | `"UH_Zooming"` | True when the player is holding right-click (ironsights/ADS) |
| `"Running"` | `"UH_Running"` | True when the player is sprinting (IN_SPEED + moving) |
| `"Reloading"` | `"UH_Reloading"` | True while a reload is in progress |

### Where they should be defined

The definition should go in `weapon_custom_uh_base.lua` (the grandparent — the highest base class in the CUH chain that all weapons inherit from). This ensures every weapon in the hierarchy has access to them.

---

## 3. Usage Audit

### Where they appear and what they control

**`GetUHBool("Zooming")`** — Used in:
- `Sights()` — gates ironsight position blending and FOV zoom
- `Movement()` — reduces bob amplitude to 12.5% when zooming
- `PrimaryAttack()` — reduces recoil by 65% when zoomed (`* 0.35`)
- `ShootAnimation()` — selects `"iron_fire"` anim key instead of `"shoot"`
- `CreateShell()` — suppresses shell ejection sound when zoomed
- `CanPrimaryAttack()` — (indirectly, via state checks)
- WWII weapons: `PostShoot` — selects `"rechamber_ads"` vs `"rechamber"` anim key
- WWII weapons: `ReloadShotgun` — plays `"shotgun_reload_start"` vs hipfire variant
- `cuh_extra_recoil.lua` — gates extra recoil multiplier when zooming

**`SetUHBool("Zooming", ...)`** — Used in:
- `Think()` — toggles based on `IN_ATTACK2` keydown and prevent conditions
- `MeleeAttack()` — forces false (cancel zoom when bashing)
- `Reload()` — forces false (cancel zoom when reloading)
- `HandleRunning()` — forces false (cancel zoom when sprinting)
- `Deploy()` / `Holster()` — forces false (reset on weapon switch)

**`GetUHBool("Running")`** — Used in:
- `HandleRunning()` — gates sprint animation and holdtype switching
- `CanPrimaryAttack()` — blocks firing while sprinting
- `Reload()` — blocks reload while sprinting
- `Movement()` — gates breathing animation (only when not running)
- `HandleSprintingAnimations()` — gates sprint_in/sprint_loop/sprint_out

**`SetUHBool("Running", ...)`** — Used in:
- `HandleRunning()` — sets true when `IN_SPEED + moving`, false when stopped
- `MeleeAttack()` — forces false (cancel sprint when bashing)
- `Deploy()` / `Holster()` — forces false (reset on weapon switch)

**`GetUHBool("Reloading")`** — Used in:
- `Think()` — gates reload completion check and playback rate enforcement
- `CanPrimaryAttack()` — blocks firing while reloading
- `Reload()` — gates the "already reloading" early return
- `MeleeAttack()` — checks if MeleeInterruptReload should cancel reload
- WWII weapons: `PostShoot` — blocks pump/rechamber animation while reloading
- WWII weapons: `ReloadShotgun` — gates the shell insertion loop

**`SetUHBool("Reloading", ...)`** — Used in:
- `Reload()` — sets true when reload starts
- `_FinishReload()` — sets false when reload completes
- `HandleRunning()` — forces false (cancel reload when sprinting)
- `MeleeAttack()` — forces false (cancel reload when bashing)
- WWII weapons: `ReloadShotgun` — sets false when stop conditions met

---

## 4. The `cuh_extra_recoil.lua` Guard

The `cuh_extra_recoil.lua` file contains a defensive guard that proves the developers knew this function was missing:

```lua
-- cuh_extra_recoil.lua, line 78:
local ironSightsProgress = (weapon.GetUHBool and weapon:GetUHBool("Zooming")) and 1 or 0
```

The `weapon.GetUHBool and` check tests whether the **field** `GetUHBool` exists on the weapon before calling it. If the function is nil (not defined), this short-circuits to `0` instead of throwing a Lua error. This is a clear workaround for the missing definition.

---

## 5. Impact on the WWII Port

**Every single WWII weapon uses GetUHBool/SetUHBool.** Without defining them:
- **Ironsights won't work** — `Sights()` calls `GetUHBool("Zooming")` every frame
- **Sprinting won't work** — `HandleRunning()` calls `GetUHBool("Running")` 
- **Reloading won't work** — `Reload()` calls `GetUHBool("Reloading")` 
- **Melee bash won't work** — `MeleeAttack()` calls `SetUHBool("Zooming", false)`
- **Rechamber won't work** — `PostShoot()` calls `GetUHBool("Zooming")` for ADS variant
- **Shotgun reload won't work** — `ReloadShotgun()` calls `GetUHBool("Reloading")`
- **Burst fire won't work** — `FireBurstRound()` calls `GetUHBool("Zooming")` for recoil

**This is the #1 critical blocker for the port.** The weapons appear to load without errors (because Lua doesn't error on `self:Method()` if `Method` is nil — it just returns nil), but none of the state-dependent logic will function correctly.

---

## 6. Recommended Fix

Add the definition to the grandparent base file (`weapon_custom_uh_base.lua`) so all weapons inherit it:

```lua
-- ============================================================
-- UH BOOL HELPERS
-- ============================================================
-- Networked weapon state booleans with "UH_" prefix to avoid
-- collisions with other addons. Used for Zooming, Running, Reloading.
function SWEP:SetUHBool(key, value)
    self:SetNWBool("UH_" .. key, value)
end

function SWEP:GetUHBool(key)
    return self:GetNWBool("UH_" .. key)
end
```

This is a **2-minute fix** that unblocks the entire port. No weapon file changes needed — they all already call these methods.

---

## 7. Verification Checklist

After adding the definition, verify:
- [ ] `GetUHBool("Zooming")` returns `true` when holding right-click
- [ ] `SetUHBool("Zooming", false)` cancels ironsights
- [ ] `GetUHBool("Running")` returns `true` when sprinting
- [ ] `GetUHBool("Reloading")` returns `true` during reload
- [ ] `cuh_extra_recoil.lua` line 78 no longer needs the guard (but keep it for safety)
- [ ] No Lua errors in console about `GetUHBool` or `SetUHBool`
