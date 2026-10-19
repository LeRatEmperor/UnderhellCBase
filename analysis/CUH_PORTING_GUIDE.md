# CUH Porting Guide — TFA WWII to Underhell Custom Base

## Complete Reference for Future Weapon Porting Projects

---

## 1. Project Overview

**Repository:** https://github.com/LeRatEmperor/UnderhellCBase
**Addon path:** `/home/z/my-project/wwiiunderhell_kate/`
**TFA source repo:** https://github.com/LeRatEmperor/tfa_nzombies_call_of_duty_wwii_weaponry_but_not_fat_3478968000
**Local TFA source:** `/home/z/my-project/source_repos/tfa_codww2_source/`
**Glua skill:** `/home/z/my-project/skills/glua/` (392 reference files)

### Stats
- **90 WWII weapons** ported (81 guns + 9 melee)
- **41 attachment files** in `lua/cuh_attachments/`
- **7 weapon templates** (auto, bolt, burst, semi, shotgun, selective, revolver_sg)
- **1183 sound definitions** in `nz_codww2_sounds.lua`
- **150 Lua files** total
- **215+ git commits**

---

## 2. Architecture

### Inheritance Chain

```
weapon_base (GMod engine)
  └─ weapon_custom_uh_base.lua (root base: viewmodel positioning, bob, hands, sprint, ironsights)
       └─ weapon_custom_uh_base_gun.lua (gun base: PrimaryAttack, Reload, Think, AnimSounds, crosshair, RT scope hook)
            ├─ weapon_custom_uh_base_melee.lua (melee base: MeleeAttack, DoMeleeHit, DrawWorldModel, HandleRunning override)
            └─ weapon_cuh_base_gun.lua (CUH base: attachment system, VElements, stat cache, ApplyAttachments)
                 └─ kate_*.lua (individual WWII weapons)
```

### Key Distinction
- **weapon_custom_uh_base** = the clean, optimized base (no attachments)
- **weapon_cuh_base_gun** = adds the attachment customization system on top
- **weapon_custom_uh_base_melee** = melee base (no attachments, no gun features)

---

## 3. Porting Process — Step by Step

### Step 1: Clone the TFA Source

```bash
cd /home/z/my-project/source_repos
git clone --depth 1 https://github.com/LeRatEmperor/tfa_nzombies_call_of_duty_wwii_weaponry_but_not_fat_3478968000.git tfa_codww2_source
```

This gives you the original TFA weapon files, attachment definitions, models, materials, sounds, and `.qc` files.

### Step 2: Choose the Right Template

Templates are in `wwiiunderhell_kate/lua/weapons/template_*.lua`:

| Template | Use For |
|----------|---------|
| `template_auto` | Full-auto rifles, LMGs, SMGs |
| `template_semi` | Semi-auto rifles, pistols |
| `template_bolt` | Bolt-action snipers |
| `template_burst` | Burst-fire weapons |
| `template_shotgun` | Shotguns (shell-by-shell reload) |
| `template_selective` | Weapons with fire mode switching |
| `template_revolver_sg` | Revolvers |

For melee weapons, use `weapon_custom_uh_base_melee` directly.

### Step 3: Map TFA Fields to CUH Fields

| TFA Source | CUH Target | Notes |
|------------|------------|-------|
| `SWEP.ViewModel` | `SWEP.ViewModel` | Direct copy |
| `SWEP.WorldModel` | `SWEP.WorldModel` | Direct copy |
| `SWEP.Primary.Damage` | `SWEP.Primary.MinDamage` / `SWEP.Primary.MaxDamage` | TFA uses single value; CUH uses range |
| `SWEP.Primary.ClipSize` | `SWEP.Primary.ClipSize` | Direct copy |
| `SWEP.Primary.Ammo` | `SWEP.Primary.Ammo` | Direct copy |
| `SWEP.Primary.Automatic` | `SWEP.Primary.Automatic` | Direct copy |
| `SWEP.Primary.Delay` | `SWEP.Primary.Delay` | `60 / RPM` for fire rate |
| `SWEP.Primary.Spread` | `SWEP.Primary.Spread` | Direct copy |
| `SWEP.Primary.Recoil` | `SWEP.Primary.MinRecoil` / `SWEP.Primary.MaxRecoil` | TFA single → CUH range |
| `SWEP.IronSightsPos` | `SWEP.IronSightsPos` | Direct copy |
| `SWEP.IronSightsAng` | `SWEP.IronSightsAng` | Direct copy |
| `SWEP.SprintAnimation` | `SWEP.AnimatedSprint = true` + `SWEP.Animations["sprint_in/out/idle"]` | TFA uses table; CUH uses boolean + animation keys |
| `SWEP.VElements` | `SWEP.ViewModelElements` | Rename `angle`→`ang`, `size`→`scale`, `bodygroup`→`bodygroups` |
| `SWEP.WElements` | `SWEP.WorldModelElements` | Same renames as VElements |
| `SWEP.Animations` | `SWEP.Animations` | Direct copy (sequence name strings) |
| `SWEP.EventTable` | `SWEP.AnimSounds` | Convert: `{time=N/30, sound=S}` format, time = N/30 → seconds |
| `SWEP.Attachments` | `SWEP.Attachments` | Convert to CUH format: `{ [1] = { name="Slot", atts={...}, default=0 } }` |

### Step 4: Port VElements

TFA VElements use different field names than CUH:

```lua
-- TFA format:
["barrel"] = {
    type = "Model", model = "...mdl", bone = "tag_weapon",
    pos = Vector(0,0,0), angle = Angle(0,0,0),  -- TFA: "angle"
    size = Vector(1,1,1),                         -- TFA: "size"
    color = Color(255,255,255,255),
    surpresslightning = false, material = "", skin = 0,
    bodygroup = {},                               -- TFA: "bodygroup"
    bonemerge = true, active = false,
}

-- CUH format:
["barrel"] = {
    type = "Model", model = "...mdl", bone = "tag_weapon",
    pos = Vector(0,0,0), ang = Angle(0,0,0),      -- CUH: "ang"
    scale = Vector(1,1,1),                          -- CUH: "scale"
    color = Color(255,255,255,255),
    surpresslightning = false, material = "", skin = 0,
    bodygroups = {},                                -- CUH: "bodygroups"
    bonemerge = true, active = false,
}
```

Field renames:
- `angle` → `ang`
- `size` → `scale`
- `bodygroup` → `bodygroups`

### Step 5: Port AnimSounds

TFA uses `SWEP.EventTable` with frame-based timing. CUH uses `SWEP.AnimSounds` with second-based timing:

```lua
-- TFA format (frames at 30fps):
SWEP.EventTable = {
    ["reload"] = {
        { ["time"] = 10/30, ["type"] = "sound", ["value"] = Sound("Weapon.MagOut") },
        { ["time"] = 25/30, ["type"] = "sound", ["value"] = Sound("Weapon.MagIn") },
    },
}

-- CUH format (seconds):
SWEP.AnimSounds = {
    ["reload"] = {
        { time = 0.3333, sound = "Weapon.MagOut" },  -- 10/30 = 0.3333
        { time = 0.8333, sound = "Weapon.MagIn" },   -- 25/30 = 0.8333
    },
}
```

Conversion:
- `time` = `N/30` → seconds
- `value` = `Sound("...")` → just the string `"..."`
- `type` field removed (always "sound")

### Step 6: Port Attachments

TFA attachments live in `lua/tfa/att/` and use `ATTACHMENT.Base`. CUH attachments live in `lua/cuh_attachments/` and are auto-registered.

```lua
-- CUH attachment format:
ATTACHMENT = {}
ATTACHMENT.Name = "Extended Mag"
ATTACHMENT.ShortName = "XMAG"
ATTACHMENT.Icon = "entities/..."
ATTACHMENT.Description = { Color(100,255,100), "+50% ammo" }

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["ext_clip"] = { ["active"] = true },
    },
    ["WElements"] = {
        ["ext_clip"] = { ["active"] = true },
    },
    ["Primary"] = {
        ["ClipSize"] = function(wep, val) return val * 1.5 end,
    },
}

function ATTACHMENT:Attach(wep)
    -- Side effects (model swap, bodygroup changes, etc.)
end

function ATTACHMENT:Detach(wep)
    -- Cleanup (NOTE: Detach is NEVER CALLED by the CUH base!
    -- Use the ApplyAttachments purge pattern instead)
end
```

### Step 7: Port Ironsight Data

Scrape from the TFA source. The WWII weapons have per-sight ironsight positions:

```lua
SWEP.IronSightsPos = Vector(-3.5, -4.5, 1.15)  -- default
SWEP.IronSightsPos_7X = Vector(-3.576, -6, 0.66)  -- 7x scope
SWEP.IronSightsPos_ACOG = Vector(-2.601, -3, 0.888)  -- 4x ACOG
SWEP.IronSightsPos_NYDAR = Vector(-4.187, -2, -0.025)  -- Nydar reflex
SWEP.IronSightsPos_LENS = Vector(-4.182, -3, 1.075)  -- Lens sight
```

The attachment's WeaponTable uses functions to select the right position:
```lua
["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or val end,
```

---

## 4. Key Systems

### 4.1 MCV Dynamic Crosshair

Located in `weapon_custom_uh_base_gun.lua` inside `if CLIENT then`.

Features:
- Spread-following gap (widens with movement, jumping, firing)
- Fire kick via `GetNextPrimaryFire()` detection (client-side, works in SP/MP)
- ADS convergence (prongs collapse to center + fade to invisible)
- Walk bob (figure-of-eight, speed-scaled)
- View-punch following (stays on actual aim point)
- Reload fade (smooth fade out/in)
- Deploy/holster blend (slides in on weapon switch)
- Shadow outline for visibility on any background
- Shotgun circle mode (for multi-pellet weapons)
- Shares color with 3D2D HUD (uh_hud_r/g/b convars)
- `SWEP.CrosshairType`: 1=prong, 2=circle, 3=off (falls back to pellet counting if not set)

### 4.2 RT Scope System

**Files involved:**
- `lua/autorun/cuh_rt_scope_render.lua` — RenderScene hook, HUDPaint hook, debug commands
- `lua/cuh_attachments/tfa_codww2_*_scope.lua` — Per-scope attachment (7x scopes)
- `lua/cuh_attachments/tfa_codww2_4x.lua` — 4x ACOG
- `lua/cuh_attachments/tfa_codww2_lens_sight.lua` — Lens sight

**How it works:**
1. Attachment's `Attach()` creates a `CreateMaterial` with `Unlittwotexture` shader
   - `$basetexture` = RT (set dynamically each frame)
   - `$texture2` = reticle overlay (static, always visible)
2. `CustomThink` hook finds the lens material index on the scope csModel
3. `RenderOverride` on the csModel injects `SetSubMaterial` with `!` prefix between `SetModel` and `DrawModel`
4. `DrawVElements` per-instance override suppresses VElements during RT render pass
5. `RenderScene` hook renders the 3D scene into the RT, sets it as `$basetexture`
6. The reticle on `$texture2` stays visible on top of the RT (baked into lens)

**Critical lessons learned:**
- `SetSubMaterial` requires `!` prefix for CreateMaterial names: `csModel:SetSubMaterial(idx, "!" .. matName)`
- `render.Clear` has GMod bug #2085 — breaks surface alpha on RTs. Don't use it.
- `render.RenderView` resets the render target to the screen — must re-push RT before drawing reticle
- The `TFA_COD_Scope` C++ proxy composites the reticle at runtime — we replace it with `Unlittwotexture`
- Transparent areas of the reticle PNG must have WHITE RGB (255,255,255) so the multiply blend doesn't darken the RT
- Scope overlay textures: `materials/scopes/scope_overlay_{american,britain,german,japanese,mp}.png`
- VTFs must be DXT5 with gamma correction, 2D Texture (not Volume)

### 4.3 Reflex Sight System (Nydar)

**File:** `lua/cuh_attachments/tfa_codww2_nydar.lua`

Uses a `HUDPaint` hook (NOT `DrawHUD` override) to draw the red dot:
- `_reflexActive` toggle controls rendering (ON when Nydar equipped, OFF when deselected)
- Purged in `ApplyAttachments` override (since `Detach` is never called by the base)
- 0.1s delay + 0.1s fade-in for gun travel time
- `CreateMaterial` with `UnlitGeneric` + `$additive` for glowing dot

**Why HUDPaint instead of DrawHUD:**
- Overriding `DrawHUD` caused recursion bugs and broke the HUD when switching attachments
- `HUDPaint` is a separate hook that doesn't interfere with `DrawHUD`

### 4.4 Attachment System (CUH Base)

**File:** `lua/weapons/weapon_cuh_base_gun.lua`

**ApplyAttachments pipeline (6 stages):**
1. InitVElements/InitWElements (create ClientsideModels)
2. Full reset: RestoreStat for all cached stats, reset VElements to snapshots
3. Reset WElements to default state
4. Reset bodygroups
5. Apply each equipped attachment:
   - WeaponTable stats (functions evaluated, non-functions direct-set)
   - VElement/WElement overrides (merge per-key)
   - Animations overrides (merge per-key)
   - AnimSounds overrides (merge per-key)
   - Call `att:Attach(wep)` for side effects
6. Re-init VElements/WElements (rebuild ClientsideModels)

**Critical: `Detach()` is NEVER CALLED.** The base only calls `RestoreStat` + `Attach` for the new selection. To clean up, use the `ApplyAttachments` override pattern in `cuh_rt_scope_render.lua`:
```lua
wep.ApplyAttachments = function(self)
    -- PURGE state BEFORE calling original
    self.Sensitivity = 0.8
    self.ScopeTexture = nil
    self._reflexActive = false
    -- Then call original
    origApply(self)
end
```

**Stat Cache:**
- `InitStatCache` snapshots original values for `Primary.*`, `Secondary.*`, and top-level fields
- `SetStat(path, value)` caches + eagerly writes to the SWEP field
- `RestoreStat(path)` restores from `_statOrigins` (only if origin ~= nil)
- **Sensitivity is NOT in the topLevel list** — must be manually purged in the ApplyAttachments override
- Functions in WeaponTable are evaluated: `function(wep, val) return val * 1.5 end`

**IsAttachmentEquipped helper:**
```lua
function SWEP:IsAttachmentEquipped(attId)
    -- Checks all slots for a specific attachment ID
end
```
Used by the tactical knife for priority detection.

### 4.5 Melee Base

**File:** `lua/weapons/weapon_custom_uh_base_melee.lua`

**Key design:**
- `HandleRunning` override sets the `Running` bool but does NOT play animations (Kate weapons have their own `HandleSprintingAnimations`)
- `MeleeAttack()` / `DoMeleeHit()` / `EndMelee()` state machine with hit delay timing
- `MeleeAttackRight()` for secondary attack (2x damage, ACT_VM_MISSRIGHT)
- `DrawWorldModel` attaches the world model to the player's right hand bone
- `DoMeleeHit` has 3 cases: entity hit (damage + blood), world hit (sound + effect), miss (swing sound)
- World hit sound fallback: `HitWorldSound` → `HitSound` → `SwingSound`

### 4.6 Sprint Bob Dampener

**File:** `lua/weapons/weapon_custom_uh_base.lua` (Movement function)

```lua
if self.AnimatedSprint and isRunning then
    self._sprintFade = Lerp(ft8, self._sprintFade or 1, 0)  -- fade out
else
    self._sprintFade = Lerp(ft * 5, self._sprintFade or 1, 1)  -- fade in
end
local bob_fade = bob * (self._sprintFade or 1)
```

- When `AnimatedSprint = true` and sprinting, the bob smoothly fades to 0
- When sprint ends, it fades back to 1
- Default fallback is 1 (full bob) — NOT 0 (the bug that caused "broken dampener")
- Initialized to 1 in `Initialize()`

### 4.7 HandleRunning Override (Gun Base)

**File:** `lua/weapons/weapon_custom_uh_base_gun.lua`

Blocks sprint during reload:
```lua
function SWEP:HandleRunning(ct)
    if self:GetUHBool("Reloading") then
        -- Exit sprint if running, but don't start a new one
        return
    end
    BaseClass.HandleRunning(self, ct)  -- call parent
end
```

### 4.8 Sound Script

**File:** `lua/autorun/nz_codww2_sounds.lua`

1183 sound definitions using `sound.Add()`. All sounds use the `TFA_CODWW2_*` prefix. The file is shared (runs on both server and client).

---

## 5. Common Pitfalls & Lessons Learned

### 5.1 Recursion Bugs (Stack Overflow)
**Pattern that ALWAYS causes recursion:**
```lua
-- BROKEN: reads self._prev at CALL TIME
wep._prev = wep.SomeMethod
wep.SomeMethod = function(self)
    self._prev(self)  -- after 2nd Attach(), _prev = our own closure → ∞
end
```

**Correct pattern (local upvalue + idempotent guard):**
```lua
if not wep._hooked then
    wep._hooked = true
    local prev = wep.SomeMethod  -- LOCAL upvalue, captured once
    wep.SomeMethod = function(self, ...)
        if prev and prev ~= self.SomeMethod then
            prev(self, ...)
        end
        -- new code
    end
end
```

### 5.2 `Detach()` is Never Called
The CUH base's `ApplyAttachments` only calls `RestoreStat` + `Attach`. It NEVER calls `Detach`. To clean up state when an attachment is deselected, purge in the `ApplyAttachments` override BEFORE calling the original.

### 5.3 `SetSubMaterial` Requires `!` Prefix
```lua
csModel:SetSubMaterial(idx, "!" .. matName)  -- CORRECT
csModel:SetSubMaterial(idx, matName)          -- BROKEN (looks for .vmt file)
```

### 5.4 `render.Clear` Breaks Surface Alpha (GMod Bug #2085)
Don't call `render.Clear` on RTs before `surface.DrawTexturedRect`. The alpha gets set incorrectly, making draws invisible.

### 5.5 `render.RenderView` Resets Render Target
After `render.RenderView`, the current RT is reset to the screen. Must re-push the RT before drawing anything on it.

### 5.6 CRLF Line Endings
The original `weapon_uh_base.lua` uses CRLF (`\r\n`). When modifying with Python, preserve CRLF by working at the byte level:
```python
with open(filepath, 'rb') as f:
    raw = f.read()
# modify raw bytes
with open(filepath, 'wb') as f:
    f.write(raw)
```

### 5.7 Client-Only Code
All `surface.*`, `render.*`, `cam.*`, `draw.*`, `vgui.*` calls must be inside `if CLIENT then` blocks. The `DoDrawCrosshair` function and the entire MCV crosshair block must be wrapped.

### 5.8 `PostShoot` Doesn't Run on Client in Singleplayer
In singleplayer, `SWEP:PrimaryAttack` is only called on the server. Use `GetNextPrimaryFire()` (a networked value) for client-side shot detection instead.

### 5.9 `BaseClass` vs Local Capture
```lua
-- BROKEN: captures nil (method not on this class, it's on the parent)
local orig = SWEP.HandleRunning  -- nil!

-- CORRECT: use BaseClass (resolves at call time)
BaseClass.HandleRunning(self, ct)
```

### 5.10 Transparent PNG → VTF
Transparent areas must have WHITE RGB (255,255,255), not black (0,0,0). The `Unlittwotexture` shader multiplies `$basetexture × $texture2`. Black transparent areas make the RT dark: `RT × 0 = 0`.

---

## 6. File Structure

```
wwiiunderhell_kate/
├── lua/
│   ├── autorun/
│   │   ├── cuh_rt_scope_render.lua      # RT scope + reflex + sensitivity fix
│   │   ├── nz_codww2_sounds.lua         # 1183 sound definitions
│   │   └── sh_kate_projectile.lua       # Projectile entities
│   ├── cuh_attachments/                  # 41 attachment files
│   │   ├── tfa_codww2_4x.lua            # 4x ACOG (RT scope)
│   │   ├── tfa_codww2_*_scope.lua       # 7x sniper scopes (RT scope)
│   │   ├── tfa_codww2_lens_sight.lua    # Lens sight (RT scope)
│   │   ├── tfa_codww2_nydar.lua         # Nydar reflex (HUDPaint dot)
│   │   ├── tfa_codww2_knife.lua         # Tactical knife (anim overrides)
│   │   ├── tfa_codww2_xmag*.lua         # Extended mags
│   │   ├── tfa_codww2_supp*.lua         # Suppressors
│   │   ├── tfa_codww2_bayonet*.lua      # Bayonets
│   │   └── ...                          # Other attachments
│   ├── weapons/
│   │   ├── kate_*.lua                   # 90 weapons (81 guns + 9 melee)
│   │   └── template_*.lua               # 7 templates
│   └── entities/                         # Projectile entities
├── materials/
│   ├── scopes/                           # RT scope overlay textures
│   │   ├── scope_overlay_*.png/vmt/vtf  # 5 faction overlays
│   └── reflex/
│       └── reflex_dot.png/vmt           # Reflex dot texture
├── base_backup/                         # Backup of all base files
└── docs/                               # Audit documents
```

**Base files (in `/lua/weapons/`):**
```
weapon_custom_uh_base.lua        # Root base (viewmodel, bob, hands, sprint, ironsights)
weapon_custom_uh_base_gun.lua    # Gun base (PrimaryAttack, Reload, Think, crosshair, scope)
weapon_custom_uh_base_melee.lua  # Melee base (MeleeAttack, DoMeleeHit, DrawWorldModel)
weapon_custom_uh_base_shotty.lua # Shotgun base (shell-by-shell reload)
```

---

## 7. Debug Console Commands

| Command | Description |
|---------|-------------|
| `cuh_rt_scope_debug 1` | Print RT scope state every 60 frames |
| `cuh_rt_scope_dump` | Full RT scope state dump (materials, csModel, sub-materials) |
| `cuh_ironsight_dump` | Ironsight position dump (current, cache, origins, scope-specific) |
| `cuh_adjust_acog <dx> <dy> <dz>` | Real-time ACOG ironsight adjustment |
| `cuh_adjust_acog reset` | Reset ACOG to default |
| `cuh_adjust_acog save` | Print the SWEP.IronSightsPos_ACOG line to copy |

---

## 8. Porting Checklist

For each weapon:

- [ ] Copy the TFA source file
- [ ] Change `SWEP.Base` to `weapon_cuh_base_gun` (or `weapon_custom_uh_base_melee` for melee)
- [ ] Add `DEFINE_BASECLASS`
- [ ] Rename VElement fields: `angle`→`ang`, `size`→`scale`, `bodygroup`→`bodygroups`
- [ ] Convert `Primary.Damage` to `MinDamage`/`MaxDamage`
- [ ] Convert `Primary.Recoil` to `MinRecoil`/`MaxRecoil`
- [ ] Convert `EventTable` to `AnimSounds` (time = N/30 → seconds, remove `Sound()` wrapper)
- [ ] Set `SWEP.AnimatedSprint = true` if the TFA weapon has sprint animations
- [ ] Add sprint animation keys to `SWEP.Animations` (`sprint_in`, `sprint_out`, `sprint_idle`)
- [ ] Set `SWEP.Category = "Kate WWII"`
- [ ] Set `SWEP.UseHands = true`
- [ ] Add `SWEP.CameraAttachment = "Camera"`
- [ ] Add `SWEP.MuzzleAttachment = "2"`
- [ ] Add melee stats if applicable (`MeleeDamage`, `MeleeRange`, `MeleeDelay`, etc.)
- [ ] Add `SWEP.IsCUHWeapon = true` (for CUH weapons only, NOT melee)
- [ ] Convert `SWEP.Attachments` to CUH format
- [ ] Port attachment files to `lua/cuh_attachments/`
- [ ] Scrape `IronSightsPos_*` data from TFA source
- [ ] Add `SWEP.ScopeReticle` for scoped weapons
- [ ] Test: deploy, fire, reload, sprint, inspect, melee bash
- [ ] Test: attachments (apply/detach, model swaps, stat changes)
- [ ] Test: scopes (RT rendering, reticle, ironsight alignment)
- [ ] Test: sensitivity reset after detaching scopes

---

## 9. Simulator

**File:** `scripts/simulate_crosshair.py`

3-pass simulator for the crosshair code:
- Pass 1: Syntax + Logic (balanced ends, convars, method names)
- Pass 2: Edge Cases + Recursion (nil guards, NaN, division by zero)
- Pass 3: Integration + State Leak (no double crosshair, no conflict, state on self)

Run with: `python3 scripts/simulate_crosshair.py`

---

## 10. Scripts Archive

72 Python scripts in `/scripts/` for automated porting and fixing:

| Script | Purpose |
|--------|---------|
| `scrape_tfa_ironsights.py` | Scrape IronSightsPos_* from TFA source → Kate weapons |
| `add_scope_reticle.py` | Add ScopeReticle to scoped weapons |
| `update_scope_reticle_factions.py` | Map weapons to faction scope overlays |
| `fix_scope_overlay_pngs.py` | Fill transparent PNG areas with white RGB |
| `port_mcv_crosshair.py` | Port MCV dynamic crosshair to Underhell base |
| `simulate_crosshair.py` | 3-pass simulator for crosshair code |
| `convert_melee_weapons.py` | Convert melee weapons to melee base |
| `fix_sprint_bob_v2.py` | Add sprint bob dampener (byte-level CRLF) |
| `fix_optics_and_rechamber.py` | Add ScopeReticle + CanPrimaryAttack override |
| `fix_sensitivity_origin.py` | Fix sensitivity persistence (stat cache purge) |

---

## 11. Future Project Tips

1. **Always clone the TFA source first** — you'll need the `.qc` files for animation sequence names
2. **Use the glua skill** — it catches bugs like the `!` prefix, `render.Clear` alpha bug, and realm issues
3. **Run the simulator** before shipping — it catches recursion, nil access, and state leaks
4. **Preserve CRLF** when modifying the old base files — use byte-level Python
5. **Never modify `weapon_uh_base.lua`** — it's the old base, not in the inheritance chain. The actual base is `weapon_custom_uh_base.lua`
6. **Test in singleplayer** — prediction issues are the #1 source of bugs (PostShoot, NextPrimaryFire)
7. **Use `HUDPaint` hooks** instead of overriding `DrawHUD` — avoids recursion and state leaks
8. **Use `_reflexActive` toggle pattern** for attachment-controlled rendering
9. **The `ApplyAttachments` override is the cleanup point** — Detach is never called
10. **Initialize state variables to their default** in `Initialize()` (e.g., `_sprintFade = 1`)
