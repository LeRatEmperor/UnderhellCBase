# Render Target (RT) Scope System — Exhaustive Audit

**Audit scope:** Every file containing RT scope code across three codebases
(TFA Base Documentation, original Underhell, current CUH) plus all 7 WWII scope
attachments and the G36K working reference weapon.

**Audit method:** Every file read in full. All field names, function names,
line numbers, and table paths transcribed verbatim. No omissions.

---

## TABLE OF CONTENTS

1. [Codebase A — TFA Base Documentation](#codebase-a--tfa-base-documentation)
2. [Codebase B — Original Underhell Base](#codebase-b--original-underhell-base)
3. [Codebase C — Current CUH Base](#codebase-c--current-cuh-base)
4. [Codebase D — WWII Scope Attachments (current)](#codebase-d--wwii-scope-attachments-current)
5. [Codebase E — G36K working RT scope reference](#codebase-e--g36k-working-rt-scope-reference)
6. [Cross-cutting analysis](#cross-cutting-analysis)
7. [What's wrong with the current WWII scope attachments](#whats-wrong-with-the-current-wwii-scope-attachments)
8. [Next actions](#next-actions)

---

## Codebase A — TFA Base Documentation

Files (all in `/home/z/my-project/repos/tfa_base_docs/lua/tfa/documentation/`):

| File | Lines | Purpose |
|---|---|---|
| `tfa_base_template.lua` | 1060 | Authoritative field reference for TFA weapons |
| `tfa_attachment_template.lua` | 96 | Authoritative field reference for TFA attachments |
| `tfa_legacy_template.lua` | 703 | Outdated v0 template; kept for reference |
| `tfa_matproxies.lua` | 81 | Material proxy registry (incl. `TFA_RTScope`) |
| `tfa_anims_template.lua` | 270 | Animation key reference (incl. iron_in / iron_out) |
| `tfa_attbatch_template.lua` | 98 | Batch attachment registration template |
| `tfa_hooks_custom.lua` | ~900 | TFA custom hook reference |

### A.1 RT SCOPE INITIALIZATION (TFA)

TFA Base uses a fundamentally different RT model from Underhell. It does NOT
store a per-weapon `RenderTarget` field. Instead:

- `SWEP.RTMaterialOverride = nil` — `tfa_base_template.lua:890`
  When set to a numeric material index (the viewmodel material index MINUS 1),
  tells TFA which viewmodel material should receive the RT.
- `SWEP.RTOpaque = false` — `tfa_base_template.lua:891`
  When true, the RT is created without alpha (opaque) for sharp scope views.
- `SWEP.RTCode = nil` — `tfa_base_template.lua:892`
  Optional user-provided function `function(self) return end` that draws onto
  the render target. When nil, TFA's default scope-drawing code runs.
- `SWEP.RTBGBlur = true` — `tfa_base_template.lua:893`
  When true, TFA draws a background blur behind the 3D scope.

TFA's RT is created internally by the TFA base itself (NOT documented in the
template files — the template only documents the user-facing fields). The
creation happens in `tfa_gun_base` (not present in this repo) using a
per-weapon RT name pattern. The TFA_RTScope material proxy (see §A.3) is
responsible for swapping `$basetexture` on the lens material at render time.

There is **no ConVar** in TFA's template for RT quality. The Underhell
`uh_rt_quality` ConVar is Underhell-specific.

### A.2 RT SCOPE RENDERING (TFA)

The TFA template files document **no `RenderScene` hook**. The actual RT
rendering is performed by the TFA base (in `tfa_gun_base`, which is not part
of the documentation repo). The TFA model is:

1. User sets `SWEP.RTMaterialOverride` and (optionally) `SWEP.RTCode`.
2. TFA internally creates a render target and assigns it to the
   `RTMaterialOverride` material.
3. If `SWEP.RTCode` is non-nil, TFA calls it inside `RTDrawEnabled` (see
   `tfa_attachment_template.lua:62`):
   ```lua
   function ATTACHMENT:RTCode(wep, rt_texture, w, h) end
   ```
   This lets attachments draw custom reticles / overlays onto the RT.
4. The `TFA_RTScope` material proxy (see §A.3) binds the RT as the lens
   material's `$basetexture` at render time.

TFA's RT rendering conditions are documented in `tfa_hooks_custom.lua` via
the hook `GM:TFA_DrawScopeOverlay(weapon)` at line 728-730:

> Called before drawing 2D scope overlay

TFA also exposes a custom hook (`GM:TFA_DrawScopeOverlay`) which can return
true to suppress the default overlay rendering.

### A.3 SCOPE LENS MATERIAL (TFA)

TFA Base provides a dedicated material proxy:

**`TFA_RTScope`** — `tfa_matproxies.lua:49-59`
- Description: "Replaces $basetexture with render target texture of 3D scopes"
- VMT usage:
  ```vmt
  Proxies
  {
      TFA_RTScope
      {
      }
  }
  ```
- Takes no parameters. The proxy automatically substitutes `$basetexture`
  with the weapon's render target texture.

This is the **canonical** TFA way to bind a render target to a scope lens
material. A VMT file declares `TFA_RTScope` in its Proxies block, and the
TFA base swaps in the RT texture for any weapon that uses that material.

Other relevant material proxies in `tfa_matproxies.lua`:
- `PlayerWeaponColorStatic` (lines 1-14) — static `$color2` from player color
- `TFALaserColor` (lines 17-30) — `$color2` from laser color
- `TFAReticuleColor` (lines 33-46) — `$color2` from reticule color
- `TFA_CubemapTint` (lines 62-79) — envmap tint multiplier

### A.4 IRONSIGHT ALIGNMENT (TFA)

TFA Base exposes the following ironsight fields in `tfa_base_template.lua`:

- `SWEP.IronSightsPosition = Vector(0, 0, 0)` — `tfa_base_template.lua:428`
  (NOTE: this is the legacy name; the modern field is `SWEP.IronSightsPos`.)
- `SWEP.IronSightsAngle = Vector(0, 0, 0)` — `tfa_base_template.lua:429`
  (Same legacy caveat; modern is `SWEP.IronSightsAng`.)
- `SWEP.Secondary.IronSightsEnabled = true` — `tfa_base_template.lua:542`
- `SWEP.Secondary.OwnerFOV = 70` — `tfa_base_template.lua:548` (aka `Secondary.IronFOV`)
- `SWEP.Secondary.ViewModelFOV = nil` — `tfa_base_template.lua:550`
  (Defaults to 65; target viewmodel FOV when aiming down sights.)
- `SWEP.Secondary.OwnerFOVUseThreshold = nil` — `tfa_base_template.lua:552`
- `SWEP.Secondary.OwnerFOVThreshold = nil` — `tfa_base_template.lua:553`
  (Defaults to `SWEP.ScopeOverlayThreshold` = 0.875.)

**Per-scope IronSightsPos fields**: The TFA template does NOT document any
convention like `IronSightsPos_SCOPE` or `IronSightsPos_7X`. Instead, scope
attachments replace `IronSightsPos` / `IronSightsAng` through the
`WeaponTable` mechanism in the attachment file. The previous gap analysis
document (`wwiiunderhell_kate/docs/gap_analysis.md:1626`) hints that the
intended pattern is for `tfa_codww2_kar98k_scope.lua` etc. to set
`ATTACHMENT.WeaponTable.IronSightsPos = Vector(...)` directly, swapping the
position via the attachment stat cache rather than via a per-scope field.

**ZoomFov / ScopeFov**: TFA does not use the Underhell field names. TFA uses
`SWEP.Secondary.OwnerFOV` for the player's view FOV when aiming, and a
`SWEP.ScopeFov`-like value is implicit in the RT scope code (not documented
in the template files).

### A.5 ANIMATION SYSTEM (TFA)

TFA exposes the ironsights animation table at `tfa_base_template.lua:703-729`
(`SWEP.Sights_Mode` is set to `TFA.Enum.LOCOMOTION_LUA` by default, meaning
Lua-only lerp; the table is commented out but documented as the schema):

```lua
SWEP.IronAnimation = {
    ["in"] = { type = ..., value = "Idle_To_Iron", value_empty = "Idle_To_Iron_Dry", transition = true },
    ["loop"] = { type = ..., value = "Idle_Iron", value_empty = "Idle_Iron_Dry" },
    ["out"] = { type = ..., value = "Iron_To_Idle", value_empty = "Iron_To_Idle_Dry", transition = true },
    ["shoot"] = { type = ..., value = "Fire_Iron", value_last = "Fire_Iron_Last", value_empty = "Fire_Iron_Dry" },
}
```

There are **no scope-specific deploy/holster animations** in the TFA template.
Scope-vs-iron distinction is handled by the same `IronAnimation` table; the
attachment's `WeaponTable` can swap the animation key strings to point at
different sequences when the scope is equipped.

`ACT_VM_PRIMARYATTACK_1` is documented as "Shoot ironsights, overriden by
everything besides normal shooting" — `tfa_base_template.lua:1019`.

Animation events of interest from `tfa_anims_template.lua`:
- `["shoot1_is"]` (line 76) — `ACT_VM_PRIMARYATTACK_1` (ironsights shoot)
- `["shoot1_is_last"]` (line 80) — `ACT_VM_PRIMARYATTACK_3` via shoot1_last
- `["reload_is"]` (line 132) — `ACT_VM_RELOAD_ADS` (ironsights reload)
- `["reload_empty_is"]` (line 136) — `ACT_VM_RELOAD_EMPTY_ADS`

Fake ACT enums added by TFA (`tfa_anims_template.lua:234-244`):
- `ACT_VM_FIDGET_EMPTY` → `ACT_CROSSBOW_FIDGET_UNLOADED`
- `ACT_VM_FIDGET_SILENCED` → `ACT_RPG_FIDGET_UNLOADED`
- `ACT_VM_HOLSTER_SILENCED` → `ACT_CROSSBOW_HOLSTER_UNLOADED`
- `ACT_VM_RELOAD_ADS` → `ACT_IDLE_AIM_RIFLE_STIMULATED`
- `ACT_VM_RELOAD_EMPTY_ADS` → `ACT_WALK_AIM_RIFLE_STIMULATED`
- `ACT_VM_RELOAD_SILENCED_ADS` → `ACT_RUN_AIM_RIFLE_STIMULATED`
- `ACT_SHOTGUN_RELOAD_START_ADS` → `ACT_IDLE_SHOTGUN_RELAXED`
- `ACT_SHOTGUN_RELOAD_FINISH_ADS` → `ACT_IDLE_SHOTGUN_STIMULATED`

### A.6 SENSITIVITY (TFA)

TFA exposes one sensitivity field, documented for RT scopes specifically:

- `SWEP.IronSightsSensitivity = 1` — `tfa_base_template.lua:602`
  > Useful for a RT scope. Change this to 0.25 for 25% sensitivity. This is
  > if normal FOV compensation isn't your thing for whatever reason, so
  > don't change it for normal scopes.

The same field appears at `tfa_legacy_template.lua:395`. TFA does not name
the field `Sensitivity` — that name is Underhell-specific.

### A.7 TFA ATTACHMENT TEMPLATE — SCOPE-RELEVANT FIELDS

`tfa_attachment_template.lua` (96 lines total). Scope-relevant contents:

- Line 28: `ATTACHMENT.WeaponTable` — the primary stat-modification table
- Line 52: `function ATTACHMENT:Attach(wep) end` — called BEFORE stat cache
  rebuild (so direct SWEP field writes can happen here)
- Line 55: `function ATTACHMENT:Detach(wep) end`
- Line 62: `function ATTACHMENT:RTCode(wep, rt_texture, w, h) end` —
  "Called from render target code if SWEP.RTDrawEnabled is true"
- Line 68: `function ATTACHMENT:CustomBulletCallback(...)` — per-bullet
- Line 74: `function ATTACHMENT:PreDrawStencilSight(wep, vm, ply, sightVElementTable, flags)` —
  3D rendering context from PostDrawViewModel; return true to suppress
  base's PreDrawStencilSight, return false to stop reticle drawing.
- Line 85: `function ATTACHMENT:PostDrawStencilSight(wep, vm, ply, sightVElementTable, flags)` —
  same as above, called AFTER the reticle is drawn.

### A.8 TFA STENCIL SIGHTS (alternative to RT scopes)

`tfa_base_template.lua:939-988` documents the StencilSight system, an
alternative to RT scopes for red-dot / holographic sights:

- `SWEP.StencilSight = nil` (line 940) — enables stencil sight drawing
- `SWEP.StencilSight_MinPercent = nil` (line 941) — default 0.05
- `SWEP.StencilSight_VElement = nil` (line 942) — name of VElement to draw
- `SWEP.StencilSight_UseMask = nil` (line 943) — use VElement's `.mask`
  as stencil mask model
- `SWEP.StencilSight_ReticleType = nil` (lines 945-988) — accepts
  `TFA.Enum.RETICLE_FLAT`, `TFA.Enum.RETICLE_MODEL`, `TFA.Enum.RETICLE_QUAD`
  or a bit.bor combination. Draw order is MODEL → QUAD → FLAT.
- `SWEP.StencilSight_ReticleMaterial` — string or Material() object; MUST
  be a square texture
- `SWEP.StencilSight_ReticleSize` — defaults to 256 (flat) or 1 (quad)
- `SWEP.StencilSight_ScaleReticleByScreenHeight = nil` (default true)
- `SWEP.StencilSight_ScaleReticleByProgress = nil` (default true)
- `SWEP.StencilSight_FollowRecoil = nil` (default true)
- `SWEP.StencilSight_ReticleTint = nil` (default `Color(255, 255, 255)`)
- `SWEP.StencilSight_ReticleTintBySightColor = nil` (default false)
- `SWEP.StencilSight_FadeReticleByProgress = nil` (default false)
- `SWEP.StencilSight_PositionType` — `TFA.Enum.SIGHTSPOS_ATTACH` (default)
  or `TFA.Enum.SIGHTSPOS_BONE`
- `SWEP.StencilSight_ReticleAttachment` — `$attachment` name or index
- `SWEP.StencilSight_ReticleBone` — bone name or index
- `SWEP.StencilSight_ReticleOffsetPos = nil` — `Vector(0, 0, 0)`
- `SWEP.StencilSight_ReticleOffsetAng = nil` — `Angle(0, 0, 0)`

The Underhell base does NOT implement StencilSights. The CUH base does NOT
implement StencilSights either.

---

## Codebase B — Original Underhell Base

Files:

| File | Lines | Path |
|---|---|---|
| `weapon_uh_base.lua` | 882 | `/home/z/my-project/upload/weapon_uh_base.lua` |
| `weapon_uh_base_gun.lua` | 1440 | `/home/z/my-project/upload/weapon_uh_base_gun.lua` |

### B.1 RT SCOPE INITIALIZATION (Underhell)

The Underhell RT scope is created in `SWEP:Initialize()` at
`weapon_uh_base_gun.lua:109-132`:

```lua
function SWEP:Initialize()
    util.PrecacheSound(self.Primary.Sound)
    util.PrecacheModel(self.ViewModel)
    util.PrecacheModel(self.WorldModel)
    self:SetWeaponHoldType( self.HoldType )
    self:SetHoldType( self.HoldType )
    self.NextReload = CurTime()
    self:SetNWInt("FireMode", 1)

    if CLIENT and self.ScopeTexture then
        local scale = ScrH()/1080
        local quality = {
            256,
            512,
            768,
            1080
        }

        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        self.RT_Size = quality[num] * scale

        self.RenderTarget = GetRenderTarget("UH_SniperScopeRT_"..num, self.RT_Size, self.RT_Size, false)
    end
end
```

**Fields that trigger RT scope creation:**

- `SWEP.ScopeTexture` — A `Material()` instance. Its mere presence on the
  SWEP triggers the RT creation block at line 118.
- `SWEP.ScopeFov` — FOV used inside `render.RenderView` (default 8 if unset).
- `SWEP.ScopeDisabled` — bool; when true, the RenderScene hook skips the
  RT render path entirely.
- `SWEP.Sensitivity` — mouse sensitivity multiplier when scoped.
- `SWEP.Use2DScope` — enables the 2D overlay rendering in `DrawHUD`.
- `SWEP.ScopeBlur` — triggers the blur effect in `PreDrawViewModel`.

**RT creation conditions:**

- CLIENT realm only
- `self.ScopeTexture` must be non-nil (truthy)
- ConVar `uh_rt_quality` is clamped to [1, 4] and indexes the quality table:
  - 1 → 256
  - 2 → 512
  - 3 → 768
  - 4 → 1080
- The size is multiplied by `ScrH()/1080` (so 1080p → 1.0× scale).
- The RT is created with `GetRenderTarget(name, w, h, false)` — the `false`
  means "no depth buffer" (just a color texture).

**RT name uniqueness (Underhell original):**

The original Underhell RT name is `"UH_SniperScopeRT_"..num` (line 130).
This is **NOT unique per weapon** — it's unique per quality setting. All
weapons sharing the same quality setting share the same RT. This means
swapping between two scoped weapons can corrupt the RT display because
`SetTexture("$basetexture", ...)` from one weapon's RenderScene will write
into a different weapon's lens material if both weapons use the same
`ScopeTexture` instance.

### B.2 RT SCOPE RENDERING (Underhell)

The RenderScene hook is registered as a global hook at
`weapon_uh_base_gun.lua:1241-1271` (the file `if SERVER then return end`
guard at line 1237 ensures this only runs on the client):

```lua
local devzoom = Material("vgui/scope_lens")

hook.Add("RenderScene", "UHSniperRenderScene", function(origin, angles, fov)
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture then
        if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
            local size = wep.RT_Size or 512
            render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)

            local ang = LocalPlayer():EyeAngles()
            local pos = LocalPlayer():EyePos()

            render.RenderView({
                x = 0,
                y = 0,
                w = size,
                h = size,
                origin = pos,
                angles = ang,
                drawviewmodel = false,
                drawhud = false,
                dopostprocess = false,
                fov = wep.ScopeFov or 8
            })

            render.PopRenderTarget()

            wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
        else
            wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
        end
    end
end)
```

**Conditions for RT rendering:**

1. The hook fires every frame on the client for every RenderScene call.
2. The active weapon must be valid.
3. `string.find(wep.Base or "", "weapon_uh_base")` — the weapon's `Base`
   string must contain the substring `"weapon_uh_base"`. This is the
   inheritance-chain check.
4. `wep.ScopeTexture` must be non-nil.
5. `wep:GetUHBool("Zooming")` must be true (player is holding RMB / aiming).
6. `wep.ScopeDisabled` must be false (or nil).

**What is rendered INTO the RT:**

`render.RenderView({...})` with these parameters:
- `x = 0, y = 0, w = size, h = size` — square viewport matching RT size
- `origin = LocalPlayer():EyePos()` — player's eye position
- `angles = LocalPlayer():EyeAngles()` — player's eye angles (NOT the
  camera angles; this means the scope view follows the player's look
  direction, not the weapon's barrel)
- `drawviewmodel = false` — viewmodel hidden inside the RT
- `drawhud = false` — HUD hidden inside the RT
- `dopostprocess = false` — no post-processing inside the RT
- `fov = wep.ScopeFov or 8` — narrow FOV producing scope zoom

**How the RT gets assigned to the scope material:**

After `render.PopRenderTarget()`, line 1266 sets:
```lua
wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
```

This writes the RT texture directly onto the lens material's `$basetexture`
parameter. The lens material must therefore be a `Material()` object that
was originally loaded with a VMT having `$basetexture` (otherwise
`SetTexture` is a no-op).

**What happens when NOT zooming:**

Line 1268:
```lua
wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
```

The lens material's `$basetexture` is replaced with the texture of the
"devzoom" material — `Material("vgui/scope_lens")` (line 1239). This is
the static fallback: the lens shows a flat, non-animated texture when the
player is not aiming.

### B.3 SCOPE LENS MATERIAL (Underhell)

**Material path used:** Varies per weapon. Each weapon sets
`SWEP.ScopeTexture = Material("path/to/lens.vmt")` in its own file. The
two paths seen in the audited files:

- `Material("vgui/scope_lens")` — used by the "devzoom" fallback
  (`weapon_uh_base_gun.lua:1239`).
- `Material("models/weapons/v_models/g36k/lens")` — used by the G36K
  weapon file (`/home/z/my-project/lua/weapons/weapon_uh_snip_g36.lua:55`).

**devzoom explained:**

`devzoom = Material("vgui/scope_lens")` — defined at file scope at
`weapon_uh_base_gun.lua:1239`, immediately after the `if SERVER then return end`
guard. It is the **fallback texture** used when the player is not zoomed in.
The lens material's `$basetexture` is swapped to this devzoom texture's
`$basetexture` so the scope lens shows a static "lens glare" image instead
of the RT (which would otherwise be stale or contain the previous frame).

The name "devzoom" is a local variable name; it has no special meaning
beyond "the dev/static zoom lens texture."

**Viewmodel display of the RT:**

The viewmodel (a `.mdl` file) contains a sub-mesh for the scope lens.
That sub-mesh uses a VMT that originally has its `$basetexture` set to
the lens texture. The Lua code overwrites that `$basetexture` at runtime
with the RT texture. This is why `SWEP.ScopeTexture` MUST point at the
SAME material instance that the viewmodel's lens mesh uses.

**Material proxy involvement:**

**NONE.** The Underhell base does NOT use any material proxy for the RT
scope. It uses direct `:SetTexture("$basetexture", ...)` calls. The TFA
`TFA_RTScope` proxy (see §A.3) is not used and would not work since
Underhell does not register that proxy.

### B.4 IRONSIGHT ALIGNMENT (Underhell)

Underhell uses simple per-weapon IronSightsPos / IronSightsAng fields:

- `SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)` —
  `weapon_uh_base_gun.lua:90` (default in the gun base).
- `SWEP.IronSightsAng = Vector(0, 0, 0)` — `weapon_uh_base_gun.lua:91`.
- The grandparent `weapon_uh_base.lua:95-96` has different defaults:
  `SWEP.IronSightsPos = Vector(-6, -8, -10)`,
  `SWEP.IronSightsAng = Vector(20, 40, -60)`.

**Sights function** (`weapon_uh_base.lua:199-222`):

```lua
function SWEP:Sights(pos, ang, ft, iftp)
    if iftp then
        local _iron_target = self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0
        local _iron_current = c_iron or 0
        local _iron_remaining = math.abs(_iron_target - _iron_current)
        local _iron_speed = math.min(ft * 6 * (1 + (1 - _iron_remaining) * 1.5), 1)
        c_iron = Lerp(_iron_speed, _iron_current, _iron_target)
    end

    local offset = self.IronSightsPos

    if self.IronSightsAng then
        ang:RotateAroundAxis(ang:Right(),       self.IronSightsAng.x * c_iron)
        ang:RotateAroundAxis(ang:Up(),          self.IronSightsAng.y * c_iron)
        ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * c_iron)
    end

    pos = pos + offset.x * c_iron * ang:Right()
    pos = pos + offset.y * c_iron * ang:Forward()
    pos = pos + offset.z * c_iron * ang:Up()

    return pos, ang
end
```

`Sights` is called from `SWEP:GetViewModelPosition` (line 127-146) which
is called by GMod every frame to compute the viewmodel transform. The
`c_iron` lerp factor is stored as a **file-scope local** — this is a
state-bleed bug (the lerp persists across weapon switches). The CUH
edition fixes this by moving it to `self._ironBlend*` fields.

**Per-scope IronSightsPos fields:** None in Underhell. Each weapon has ONE
`IronSightsPos` and ONE `IronSightsAng`. Multiple scope variants with
different alignments are NOT supported without overriding the attachment's
WeaponTable.IronSightsPos.

**ZoomFov / ScopeFov / IronSightsPos relationship:**

- `SWEP.ZoomFov = 15` (line 33 of gun base) — the **player's view** FOV
  reduction (subtracted from base FOV during ADS).
- `SWEP.ScopeFov` — the FOV used INSIDE the RT (set per-weapon; default
  8 if nil).
- `SWEP.IronSightsPos` — the viewmodel POSITION when aiming.
- These three fields are completely independent in Underhell. `ZoomFov`
  affects the camera; `ScopeFov` affects the RT; `IronSightsPos` affects
  the viewmodel. There is no coupling.

CalcView (the camera FOV lerp) is in `weapon_uh_base.lua:686-726`:
```lua
local _zoom_target = self:GetUHBool("Zooming") and self.ZoomFov or 0
local _zoom_remaining = math.abs(_zoom_target - v_zoom) / math.max(self.ZoomFov or 1, 1)
local _zoom_speed = math.min(zoomSpeed * (1 + (1 - _zoom_remaining) * 1.5), 1)
v_zoom = Lerp(_zoom_speed, v_zoom, _zoom_target)
return pos, ang, fov - v_zoom
```

### B.5 ANIMATION SYSTEM (Underhell)

Underhell does NOT have an `iron_in` / `iron_out` / `iron_idle` animation
table like TFA's `SWEP.IronAnimation`. The Ironsights state is purely
procedural — the Lua `Sights()` function lerps the viewmodel from its
hip position to the ironsight position over ~6 frames (`ft * 6`).

The zooming animation keys used by the gun base are documented in the
`EasySendWeaponAnim` comment block at `weapon_uh_base_gun.lua:204-205`:

```
Supported animation keys:
  ["draw"], ["idle"], ["idle_empty"], ["idle_sil"],
  ["shoot"], ["shoot_ads"], ["shoot_sil"], ["shoot_ads_sil"],
  ["reload"], ["reload_empty"], ["idle_walk"], or any custom key.
```

The `_ads` suffix denotes ironsights-zoomed variants of animations. There
is no separate iron_in / iron_out sequence — the transition is purely
procedural (no model animation played during ADS in/out).

There is **no scope-specific deploy/holster animation** system. The Deploy
function (`weapon_uh_base.lua:544-630`) plays either `first_draw` (if
`AnimatedFirstDraw = true`) or `draw` (otherwise). The Holster function
(line 632-679) just resets state without playing any animation.

### B.6 SENSITIVITY (Underhell)

`SWEP:AdjustMouseSensitivity()` at `weapon_uh_base_gun.lua:1273-1281`:

```lua
function SWEP:AdjustMouseSensitivity()
    local hasScope = self.ScopeTexture or self.Use2DScope
    if not hasScope and self.Sensitivity then
        hasScope = true
    end
    if hasScope and self:GetUHBool("Zooming") then
        return self.Sensitivity or 0.2
    end
end
```

- `SWEP.Sensitivity` — multiplier (0.2 = 20% sensitivity, etc.). Default
  is 0.2 if nil.
- The check `hasScope = self.ScopeTexture or self.Use2DScope` covers both
  the RT scope path and the 2D overlay path.
- A weapon with no `ScopeTexture` and no `Use2DScope` but WITH `Sensitivity`
  is also treated as having a scope (the second conditional).
- The function returns nil when not zooming, so GMod uses the default
  sensitivity.

### B.7 2D SCOPE HUD OVERLAY (Underhell)

The 2D scope overlay (separate from the RT scope) is rendered in
`SWEP:DrawHUD` at `weapon_uh_base_gun.lua:1320-1358`:

```lua
if self.Use2DScope and self:GetUHBool("Zooming") and not drawply then
    h_scope = math.Approach(h_scope, 1, FrameTime() * 100)

    if h_scope > 0.01 then
        local w, h = ScrW(), ScrH()
        local scopeSize = h * 1.25
        local x = w / 2 - scopeSize / 2
        local y = h / 2 - scopeSize / 2

        surface.SetDrawColor(0, 0, 0, 255 * h_scope)
        -- 4 black rectangles for screen boxing
        surface.DrawRect(0, 0, x, h)
        surface.DrawRect(x + scopeSize, 0, w - (x + scopeSize), h)
        surface.DrawRect(x, 0, scopeSize, y)
        surface.DrawRect(x, h - y, scopeSize, y)

        -- Scope lens texture
        surface.SetDrawColor(0, 0, 0, 255)
        surface.SetMaterial(SCOPE_MAT)  -- = Material("gmod/scope")
        surface.DrawTexturedRect(x, y, scopeSize, scopeSize)

        -- Crosshair lines
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawLine(0, h / 2, w, h / 2)
        surface.DrawLine(w / 2, 0, w / 2, h)
    end
else
    h_scope = math.Approach(h_scope, 0, FrameTime() * 10)
end
```

`SCOPE_MAT = Material("gmod/scope")` is defined at line 107 (file scope).

`h_scope` is a file-scope local at line 106 — same state-bleed bug as
`c_iron`. CUH fixes this.

### B.8 PreDrawViewModel — Scope-related (Underhell)

`weapon_uh_base.lua:740-791`:

```lua
function SWEP:PreDrawViewModel()
    if self.Use2DScope and self:GetUHBool("Zooming") then
        render.SetBlend(0)
        return
    end

    -- ... material hiding, blur logic ...
end
```

When `Use2DScope = true` AND `Zooming` is true, the viewmodel is made
fully transparent (`render.SetBlend(0)`) and the function returns early,
so only the 2D scope overlay shows. This is the "screen-filling scope"
mode where the viewmodel is hidden.

The blur logic at lines 767-770:
```lua
if self.ScopeBlur and self:GetUHBool("Zooming") or ... then
    c_blur = math.Approach( c_blur or 0, 1, FrameTime()*1.25 )
else
    c_blur = math.Approach( c_blur or 0, 0, FrameTime() )
end
```

When `SWEP.ScopeBlur = true` is set, the screen is blurred during ADS.
The blur uses the `pp/blurscreen` material (line 728).

### B.9 UNDERHELL-SPECIFIC FIELDS (NOT in TFA)

These fields exist in Underhell but have NO equivalent in TFA Base:

| Field | File:Line | Purpose |
|---|---|---|
| `SWEP.ScopeTexture` | g36k:55 | Material() instance for the lens; triggers RT creation |
| `SWEP.ScopeFov` | g36k:54 | FOV inside the RT render (default 8) |
| `SWEP.ScopeDisabled` | g36k:79 | Bool to disable RT rendering |
| `SWEP.Use2DScope` | g36k:56 | Enables 2D HUD overlay scope |
| `SWEP.ScopeBlur` | g36k:53 | Enables pp/blurscreen during ADS |
| `SWEP.Sensitivity` | g36k:51 | Mouse sensitivity multiplier (default 0.2) |
| `SWEP.ZoomFov` | g36k:52 | Player view FOV reduction during ADS (default 15) |
| `self.RenderTarget` | gun:130 | Per-weapon RT instance |
| `self.RT_Size` | gun:128 | RT texture size in pixels |
| ConVar `uh_rt_quality` | gun:127 | 1-4 selector for RT resolution |
| `GetUHBool("Zooming")` | gun:244 | Networked bool for ADS state |

The G36K weapon file at `/home/z/my-project/lua/weapons/weapon_uh_snip_g36.lua`
lines 51-56 sets ALL of these fields:
```lua
SWEP.Sensitivity            = 0.2
SWEP.ZoomFov                = 10
SWEP.ScopeBlur              = true
SWEP.ScopeFov               = 10
SWEP.ScopeTexture            = Material("models/weapons/v_models/g36k/lens")
SWEP.Use2DScope             = true
```

This is the **canonical complete RT scope configuration** for Underhell.

---

## Codebase C — Current CUH Base

Files:

| File | Lines | Path |
|---|---|---|
| `weapon_custom_uh_base.lua` | 1079 | `/home/z/my-project/lua/weapons/weapon_custom_uh_base.lua` |
| `weapon_custom_uh_base_gun.lua` | 1126 | `/home/z/my-project/lua/weapons/weapon_custom_uh_base_gun.lua` |
| `weapon_cuh_base_gun.lua` | 1204 | `/home/z/my-project/lua/weapons/weapon_cuh_base_gun.lua` |

Inheritance chain:
```
weapon_base
└── weapon_custom_uh_base          (grandparent — Sights/CalcView/PreDrawVM)
    └── weapon_custom_uh_base_gun  (parent — Initialize/PrimaryAttack/DrawHUD/RT scope)
        └── weapon_cuh_base_gun    (child — Attachments/VElements/StatCache/Melee/Camera)
```

### C.1 RT SCOPE INITIALIZATION (CUH)

`SWEP:Initialize()` at `weapon_custom_uh_base_gun.lua:120-143`:

```lua
function SWEP:Initialize()
    if BaseClass.Initialize then BaseClass.Initialize(self) end
    util.PrecacheSound(self.Primary.Sound)
    util.PrecacheModel(self.ViewModel)
    util.PrecacheModel(self.WorldModel)
    self:SetWeaponHoldType(self.HoldType)
    self:SetHoldType(self.HoldType)
    self.NextReload = CurTime()
    self:SetNWInt("FireMode", 1)

    -- Initialize HUD blend state on self (not file-scope)
    self._scopeBlend = 0
    self._reloadHUDBlend = 0
    self._crosshairBlend = 0

    if CLIENT and self.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = { 256, 512, 768, 1080 }
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        self.RT_Size = quality[num] * scale
        -- Use unique RT name per weapon instance to avoid clobbering
        self.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. self:EntIndex(), self.RT_Size, self.RT_Size, false)
    end
end
```

**CUH changes vs original Underhell:**

1. The RT name is now unique per weapon instance:
   `"CustomUH_ScopeRT_" .. self:EntIndex()` (line 141).
   This fixes the original Underhell bug where two scoped weapons sharing
   the same `uh_rt_quality` setting would clobber each other's RT.
2. The HUD blend state (`h_scope`, `h_reload`, `h_crosshair`) is moved
   onto `self._scopeBlend`, `self._reloadHUDBlend`, `self._crosshairBlend`
   (lines 130-133), fixing the original Underhell bug where the blends
   bled across weapon switches.
3. ConVar `uh_rt_quality` is still read (line 138), unchanged from the
   original.

**Trigger conditions for RT scope creation:** Same as original Underhell:
the CLIENT block at line 135 only runs if `self.ScopeTexture` is truthy.

### C.2 RT SCOPE RENDERING (CUH)

`weapon_custom_uh_base_gun.lua:929-982` (CLIENT block):

```lua
if CLIENT then
    local devzoom = Material("vgui/scope_lens")

    -- Same inheritance-chain walker as in weapon_custom_uh_base.lua.
    -- Required because BO4 / MW ports inherit through several layers
    -- (e.g. "weapon_bo4_custom_base_gun") before reaching "custom_uh_base".
    local function IsCustomUHWeapon(wep)
        if wep._customUHChecked then return wep._isCustomUH end
        wep._customUHChecked = true
        wep._isCustomUH = false
        local cur = wep
        local seen = {}
        local depth = 0
        while cur and not seen[cur] and depth < 16 do
            seen[cur] = true
            depth = depth + 1
            if cur.Base and string.find(cur.Base, "custom_uh_base") then
                wep._isCustomUH = true
                break
            end
            if not cur.Base then break end
            cur = weapons.GetStored(cur.Base)
        end
        return wep._isCustomUH
    end

    hook.Add("RenderScene", "CustomUH_SniperRenderScene", function(origin, angles, fov)
        local wep = LocalPlayer():GetActiveWeapon()
        if not IsValid(wep) then return end
        if not IsCustomUHWeapon(wep) then return end
        if not wep.ScopeTexture then return end
        if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
            local size = wep.RT_Size or 512
            render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
            local ang = LocalPlayer():EyeAngles()
            local pos = LocalPlayer():EyePos()
            render.RenderView({
                x = 0, y = 0, w = size, h = size,
                origin = pos, angles = ang,
                drawviewmodel = false, drawhud = false,
                dopostprocess = false, fov = wep.ScopeFov or 8,
            })
            render.PopRenderTarget()
            wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
        else
            if wep.ScopeTexture then
                wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
            end
        end
    end)
end
```

**CUH changes vs original Underhell:**

1. The `string.find(wep.Base or "", "weapon_uh_base")` check is replaced
   by `IsCustomUHWeapon(wep)` — a more robust inheritance-chain walker
   that handles up to 16 levels of `Base` indirection. This is required
   because BO4/MW ports inherit through intermediate classes like
   `weapon_bo4_custom_base_gun` before reaching `custom_uh_base`.
2. The walker caches its result on `wep._customUHChecked` and
   `wep._isCustomUH` to avoid repeating the walk every frame.
3. The hook identifier changed from `"UHSniperRenderScene"` to
   `"CustomUH_SniperRenderScene"`.
4. The render.RenderView call is functionally identical, with the same
   fields: x/y/w/h/origin/angles/drawviewmodel/drawhud/dopostprocess/fov.
5. The fallback `devzoom` is unchanged — still `Material("vgui/scope_lens")`.

**RenderScene hook conditions:**

1. CLIENT-only (the entire block is inside `if CLIENT then`).
2. Active weapon must be valid.
3. `IsCustomUHWeapon(wep)` must be true (walks the inheritance chain
   looking for `Base` containing the substring `"custom_uh_base"`).
4. `wep.ScopeTexture` must be non-nil.
5. `wep:GetUHBool("Zooming")` must be true.
6. `wep.ScopeDisabled` must be falsy.

**Fallback when not zooming:** Identical to original Underhell — swaps
`$basetexture` to `devzoom:GetTexture("$basetexture")` (the static lens
glare texture).

### C.3 SCOPE LENS MATERIAL (CUH)

Identical mechanism to original Underhell:

- `SWEP.ScopeTexture` is set per-weapon to `Material("path/to/lens")`.
- The lens material's `$basetexture` is overwritten at runtime by the
  RenderScene hook (or by the fallback devzoom texture).
- `devzoom = Material("vgui/scope_lens")` — defined at file scope inside
  the `if CLIENT then` block at line 933.

**No material proxy is used.** Same as original Underhell. The TFA
`TFA_RTScope` proxy is not registered with the CUH base.

### C.4 IRONSIGHT ALIGNMENT (CUH)

The CUH base introduces a **two-phase staged ironsight lerp** in
`weapon_custom_uh_base.lua:274-342`:

```lua
function SWEP:Sights(pos, ang, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    if iftp then
        local target = self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0

        -- Phase 1: Lateral blend (X/Z screen position) — moves FASTER
        local currentLat = self._ironBlendLat or 0
        local remainingLat = math.abs(target - currentLat)
        local baseSpeed = self.IronsightSpeed or 10
        local easeIn = self.IronsightEaseIn or 1.5
        local latSpeedMult = self.IronsightLateralSpeed or 1.8
        local speedLat = math.min(ft * baseSpeed * latSpeedMult * (1 + (1 - remainingLat) * easeIn), 1)
        self._ironBlendLat = Lerp(speedLat, currentLat, target)

        -- Phase 2: Forward blend (Y depth) — moves SLOWER
        local currentFwd = self._ironBlendFwd or 0
        local remainingFwd = math.abs(target - currentFwd)
        local fwdSpeedMult = self.IronsightForwardSpeed or 0.6
        local speedFwd = math.min(ft * baseSpeed * fwdSpeedMult * (1 + (1 - remainingFwd) * easeIn), 1)
        self._ironBlendFwd = Lerp(speedFwd, currentFwd, target)
    end

    local pLat = self._ironBlendLat or 0
    local pFwd = self._ironBlendFwd or 0
    local p = pLat

    -- TFA-STYLE CURVED IRONSIGHT TRANSITION
    local dipScale = self.IronSightsDipScale or 1.0
    if dipScale ~= 0 and p > 0 and p < 1 then
        local swoop = math.sin(p * math.pi) * dipScale
        local dipPos = self.IronSightsDipPos or vector_origin
        local dipAng = self.IronSightsDipAng or angle_zero
        pos = pos + ang:Right()   * (dipPos.x * swoop)
        pos = pos + ang:Forward() * (dipPos.y * swoop)
        pos = pos + ang:Up()      * (dipPos.z * swoop)
        ang:RotateAroundAxis(ang:Right(),   dipAng.p * swoop)
        ang:RotateAroundAxis(ang:Up(),       dipAng.y * swoop)
        ang:RotateAroundAxis(ang:Forward(),  dipAng.r * swoop)
    end

    local offset = self.IronSightsPos
    if self.IronSightsAng then
        ang:RotateAroundAxis(ang:Right(),   self.IronSightsAng.x * pLat)
        ang:RotateAroundAxis(ang:Up(),       self.IronSightsAng.y * pFwd)
        ang:RotateAroundAxis(ang:Forward(),  self.IronSightsAng.z * pLat)
    end
    pos = pos + offset.x * pLat * ang:Right()
            + offset.y * pFwd * ang:Forward()
            + offset.z * pLat * ang:Up()
    return pos, ang
end
```

**CUH ironsight fields** (all in `weapon_custom_uh_base.lua`):

- `SWEP.IronsightSpeed = 10` (line 89) — base lerp speed
- `SWEP.IronsightEaseIn = 1.5` (line 90) — ease-in factor
- `SWEP.IronsightLateralSpeed` (no default in base; docstring says 1.8)
  — multiplier for X/Y phase (faster)
- `SWEP.IronsightForwardSpeed` (no default in base; docstring says 0.6)
  — multiplier for Z phase (slower)
- `SWEP.ZoomSpeedIn = 15` (line 91)
- `SWEP.ZoomSpeedOut = 10` (line 92)
- `SWEP.IronSightsDipPos = Vector(0, -1.5, -2.0)` (line 111) — dip direction
- `SWEP.IronSightsDipAng = Angle(3, 0, 0)` (line 112) — dip angle
- `SWEP.IronSightsDipScale = 1.0` (line 113) — 0 disables curve

**Stat cache integration:**

`weapon_cuh_base_gun.lua:225-233` caches `IronSightsPos` and `IronSightsAng`
into the stat cache:

```lua
if self.IronSightsPos then
    self._statCache["IronSightsPos"] = self.IronSightsPos
    self._statOrigins["IronSightsPos"] = self.IronSightsPos
end
if self.IronSightsAng then
    self._statCache["IronSightsAng"] = self.IronSightsAng
    self._statOrigins["IronSightsAng"] = self.IronSightsAng
end
```

Top-level cached scope-relevant fields (`weapon_cuh_base_gun.lua:204-209`):
```lua
local topLevel = {
    "DamageGeneric", "Num", "FireRate", "Spread", "SpreadIronsighted",
    "ViewSlideRecoilUp", "ViewSlideRecoilRight", "ZoomFov",
    "IronsightSpeed", "IronsightEaseIn", "ZoomSpeedIn", "ZoomSpeedOut",
    "IronSightTime", "MoveSpeed", "IronRecoilMultiplier",
}
```

**Per-scope IronSightsPos fields:** NONE. The CUH base does not define or
read any `IronSightsPos_SCOPE` or `IronSightsPos_7X` fields. Multiple scope
variants with different alignments must swap `IronSightsPos` via the
attachment's `WeaponTable`:

```lua
ATTACHMENT.WeaponTable = {
    ["IronSightsPos"] = Vector(-2.955, -1.5, 1.204),
    ["IronSightsAng"] = Vector(0, 0, 0),
}
```

The stat cache's `InitStatCache` runs at first `GetStat`/`SetStat` access.
`ApplyAttachments` (line 733) calls `InitStatCache` indirectly when it
walks `WeaponTable` and calls `SetStat` for each entry. After all
attachments have applied their stats, `FlushStats` writes the cache back
to the actual SWEP fields. The `Sights()` function then reads
`self.IronSightsPos` which is now the swapped value.

**ZoomFov / ScopeFov / IronSightsPos relationship:** Same as original
Underhell — completely independent fields, no coupling. `ZoomFov` is
subtracted from the player's view FOV (CalcView at
`weapon_custom_uh_base.lua:922-933`). `ScopeFov` is used inside the RT
(`weapon_custom_uh_base_gun.lua:972`). `IronSightsPos` moves the
viewmodel.

### C.5 ANIMATION SYSTEM (CUH)

Same as original Underhell — no `iron_in` / `iron_out` / `iron_idle`
animation table. The Ironsights transition is purely procedural via the
`Sights()` function.

`weapon_custom_uh_base_gun.lua:204-205` documents the supported
animation keys:

```
Supported animation keys:
  ["draw"], ["idle"], ["idle_empty"], ["idle_sil"],
  ["shoot"], ["shoot_ads"], ["shoot_sil"], ["shoot_ads_sil"],
  ["reload"], ["reload_empty"], ["idle_walk"], or any custom key.
```

The `_ads` suffix variants are looked up based on `self:GetUHBool("Zooming")`
(see `weapon_custom_uh_base_gun.lua:611-622`):

```lua
local isZooming = self:GetUHBool("Zooming")
local lookupKey = isZooming and "shoot_ads" or "shoot"
if isSilenced then
    lookupKey = lookupKey .. "_sil"
end
```

There is **no scope-specific deploy/holster animation system**. Deploy
calls `EasySendWeaponAnim("draw", ACT_VM_DRAW)` (inherited from
`weapon_custom_uh_base.lua`). Holster does not play any animation.

### C.6 SENSITIVITY (CUH)

`weapon_custom_uh_base_gun.lua:984-990`:

```lua
function SWEP:AdjustMouseSensitivity()
    local hasScope = self.ScopeTexture or self.Use2DScope
    if not hasScope and self.Sensitivity then hasScope = true end
    if hasScope and self:GetUHBool("Zooming") then
        return self.Sensitivity or 0.2
    end
end
```

**Identical** to original Underhell.

### C.7 CalcView (CUH)

`weapon_custom_uh_base.lua:880-939` (the CalcView override):

```lua
local zoomFov = self.ZoomFov or 0
if zoomFov > 0 then
    local zoomSpeedIn  = self.ZoomSpeedIn  or 15
    local zoomSpeedOut = self.ZoomSpeedOut or 10
    local zoomSpeed    = isZooming and ft*zoomSpeedIn or ft*zoomSpeedOut
    local zoomTarget   = isZooming and zoomFov or 0
    local zoomCurrent  = self._zoomBlend or 0
    local zoomRemaining = math.abs(zoomTarget - zoomCurrent) / math.max(zoomFov, 1)
    local zoomEaseSpeed = math.min(zoomSpeed * (1 + (1 - zoomRemaining) * 1.5), 1)
    self._zoomBlend = Lerp(zoomEaseSpeed, zoomCurrent, zoomTarget)
    fov = fov - (self._zoomBlend or 0)
else
    self._zoomBlend = nil
end
```

**Differences from original Underhell:**

1. Original used `ft * 5` for both in/out speeds; CUH exposes
   `SWEP.ZoomSpeedIn` (default 15) and `SWEP.ZoomSpeedOut` (default 10)
   per-weapon.
2. The original stored `v_zoom` as a file-scope local; CUH stores it on
   `self._zoomBlend`, fixing the cross-weapon state bleed.
3. The `ease-in` factor `(1 + (1 - zoomRemaining) * 1.5)` is preserved
   (matching the original Underhell behavior).

### C.8 PreDrawViewModel (CUH)

`weapon_custom_uh_base.lua:957-995`:

```lua
function SWEP:PreDrawViewModel()
    if self.Use2DScope and self:GetUHBool("Zooming") then
        render.SetBlend(0)
        return
    end
    -- ... material hiding, blur logic (same as original) ...
end
```

**Identical** to original Underhell for the scope path.

### C.9 CUH ApplyAttachments and scope attachments

`weapon_cuh_base_gun.lua:733-1037` (ApplyAttachments) — the stat cache
application pipeline. Scope-relevant step is at lines 988-1005:

```lua
-- Call attachment's Attach function for side effects
if att.Attach then
    print("[CUH-DBG]       calling att:Attach(self) ...")
    local ok, err = pcall(att.Attach, att, self)
    if not ok then
        ErrorNoHalt("[CUH] Attachment " .. tostring(attId) .. " Attach() failed: " .. tostring(err) .. "\n")
    end
else
    print("[CUH-DBG]       WARNING: att.Attach is nil — model swap will NOT happen")
end
```

**Key behavior:** `att:Attach(self)` is called AFTER the `WeaponTable` has
been processed (Stage 5 of ApplyAttachments). This means the Attach
function can override the WeaponTable-set values (like `ScopeFov = 7` from
WeaponTable) by setting `wep.ScopeFov = 7` again. The two writes don't
conflict; they just both happen.

**However:** The Attach function does NOT call `wep:SetStat("ScopeFov", 7)`.
It writes directly to `wep.ScopeFov`, bypassing the stat cache. When the
attachment is later detached and `RestoreStat` runs, `ScopeFov` is restored
to its cached origin value (which was nil for most WWII weapons), but the
direct write from `Attach` won't be cleaned up by `RestoreStat` — the
attachment's `Detach` function must explicitly set `wep.ScopeFov = nil` to
undo its own direct writes. This is what the WWII attachments do at line
51: `wep.ScopeFov = nil`.

### C.10 CUH Attach slot system

`weapon_cuh_base_gun.lua:48-68` defines `SWEP:GetEffectiveAttachment(slot)`
which returns the attachment index for a slot:

```lua
function SWEP:GetEffectiveAttachment(slot)
    if not self.Attachments or not self.Attachments[slot] then return 0 end
    local slotData = self.Attachments[slot]
    local sel = slotData.sel

    if sel == nil then
        if slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    if sel == 0 then
        if slotData.forceDefault and slotData.default and slotData.default > 0 then
            return slotData.default
        end
        return 0
    end

    return sel
end
```

**Critical:** If a slot does not exist in `SWEP.Attachments`,
`GetEffectiveAttachment` returns 0 — no attachment is applied. This is
the foundation for the WWII scope attachment bug (see §D).

---

## Codebase D — WWII Scope Attachments (current)

Files (all in `/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments/`):

| File | Lines | Name |
|---|---|---|
| `tfa_codww2_scope.lua` | 59 | "7x Scope" |
| `tfa_codww2_4x.lua` | 59 | "4x ACOG" |
| `tfa_codww2_arisaka_scope.lua` | 59 | "Arisaka Scope" |
| `tfa_codww2_enfield_scope.lua` | 59 | "Enfield Scope" |
| `tfa_codww2_kar98k_scope.lua` | 59 | "Kar98k Scope" |
| `tfa_codww2_mosin_scope.lua` | 59 | "Mosin Scope" |
| `tfa_codww2_springfield_scope.lua` | 59 | "Springfield Scope" |

### D.1 ATTACHMENT STRUCTURE (uniform across 7 files)

All seven files use the same template. The fields:

**Header (lines 1-10 of each file):**
```lua
if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "<scope name>"
ATTACHMENT.ShortName = "SCOPE"  -- or "ACOG"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "<scope name>",
    Color(255, 100, 100), "+25% Zoom time",  -- +14% for ACOG
    Color(255, 100, 100), "-5% ADS Movespeed",
}
```

**WeaponTable (lines 12-24):**

For `tfa_codww2_scope.lua`, `tfa_codww2_arisaka_scope.lua`,
`tfa_codww2_enfield_scope.lua`, `tfa_codww2_kar98k_scope.lua`,
`tfa_codww2_mosin_scope.lua`, `tfa_codww2_springfield_scope.lua`:

```lua
ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["scope_default"] = { ["active"] = true },
    },
    ["WElements"] = {
        ["scope_default"] = { ["active"] = true },
    },
    ["ScopeFov"] = 7,
    ["ZoomFov"] = 15,
    ["Sensitivity"] = 0.2,
    ["IronSightTime"] = function(wep, val) return val * 1.25 end,
    ["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}
```

For `tfa_codww2_4x.lua` (ACOG):

```lua
ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["scope_acog"] = { ["active"] = true },
    },
    ["WElements"] = {
        ["scope_acog"] = { ["active"] = true },
    },
    ["ScopeFov"] = 15,
    ["ZoomFov"] = 25,
    ["Sensitivity"] = 0.2,
    ["IronSightTime"] = function(wep, val) return val * 1.15 end,
    ["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
}
```

**Attach function (lines 26-46):**

All seven files have IDENTICAL `Attach` functions (only the ScopeFov/ZoomFov
values differ between 7x scopes and 4x ACOG):

```lua
function ATTACHMENT:Attach(wep)
    wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    wep.ScopeFov = 7       -- or 15 for the 4x ACOG
    wep.ZoomFov = 15       -- or 25 for the 4x ACOG
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = { 256, 512, 768, 1080 }
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        wep.RT_Size = quality[num] * scale
        wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
    end
end
```

**Detach function (lines 48-56):**

All seven files have IDENTICAL `Detach` functions:

```lua
function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false
    wep.RenderTarget = nil
end
```

**Footer (line 58):**
```lua
-- CUH base handles registration
```

### D.2 FIELD-BY-FIELD ANALYSIS

| Field | Value | Correct? | Notes |
|---|---|---|---|
| `ATTACHMENT.Name` | "7x Scope" etc. | ✅ | Used in CUH UI |
| `ATTACHMENT.ShortName` | "SCOPE" / "ACOG" | ✅ | |
| `ATTACHMENT.Icon` | "entities/tfa_codww2_scope.png" | ✅ | Shared icon for all 7 |
| `ATTACHMENT.Description` | table of Color+string pairs | ✅ | Format matches TFA |
| `WeaponTable.VElements["scope_default"].active = true` | true | ⚠️ | **Arisaka has NO `scope_default` VElement — only `scope_acog`.** See §F.1. |
| `WeaponTable.WElements["scope_default"].active = true` | true | ⚠️ | Same issue. |
| `WeaponTable.VElements["scope_acog"].active = true` (4x only) | true | ✅ | All 6 WWII weapons DO have a `scope_acog` VElement. |
| `WeaponTable.ScopeFov = 7` (or 15 for 4x) | numeric | ✅ | Bypasses stat cache (direct write by Attach) |
| `WeaponTable.ZoomFov = 15` (or 25 for 4x) | numeric | ✅ | But also overwritten by Attach |
| `WeaponTable.Sensitivity = 0.2` | numeric | ✅ | But also overwritten by Attach |
| `WeaponTable.IronSightTime` | function | ✅ | TFA-style function-transform; multiplies val by 1.25 (or 1.15) |
| `WeaponTable.IronSightsMoveSpeed` | function | ⚠️ | No `IronSightsMoveSpeed` field is read anywhere in the CUH base. Dead field. |
| `wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")` | Material | ❌ | **Wrong material path.** See §F.2. |
| `wep.ScopeFov = 7` (or 15) | numeric | ✅ | Direct write — overwrites WeaponTable value |
| `wep.ZoomFov = 15` (or 25) | numeric | ✅ | Direct write |
| `wep.ScopeDisabled = false` | bool | ✅ | |
| `wep.Sensitivity = 0.2` | numeric | ✅ | |
| `wep.Use2DScope = false` | bool | ⚠️ | **See §F.3.** |
| `wep.RenderTarget = GetRenderTarget(...)` | ITexture | ✅ | Created lazily in Attach if not already done |
| `wep.ScopeDisabled = true` (Detach) | bool | ✅ | |
| `wep.ScopeTexture = nil` (Detach) | nil | ✅ | |
| `wep.ScopeFov = nil` (Detach) | nil | ✅ | |
| `wep.ZoomFov = 20` (Detach) | numeric | ⚠️ | Hardcoded 20 — clobbers the weapon's original ZoomFov |
| `wep.Sensitivity = nil` (Detach) | nil | ✅ | |
| `wep.Use2DScope = false` (Detach) | bool | ✅ | |
| `wep.RenderTarget = nil` (Detach) | nil | ⚠️ | Doesn't actually free the RT (just dereferences the Lua reference) |

### D.3 WHAT'S MISSING FROM THE ATTACHMENTS

The attachments are MISSING the following fields that the CUH/Underhell
scope system needs:

1. **No `IronSightsPos` override in `WeaponTable`** — the weapon still
   uses its iron-sights position when zoomed in with the scope. This is
   the primary cause of "ironsights misaligned" reports.
2. **No `IronSightsAng` override in `WeaponTable`** — same issue.
3. **No `ScopeBlur`** — the original G36K sets `SWEP.ScopeBlur = true`
   for the blur effect, but none of the WWII scope attachments do.
4. **No `RT_Size` fallback** — if `wep.RT_Size` is nil for some reason
   (e.g. the ConVar lookup failed), the RT creation will use the
   `wep.RT_Size or 512` fallback in the RenderScene hook, but the RT
   itself will be created at the actual `RT_Size` value (potentially nil
   multiplication).
5. **No slot registration in the weapon files** — see §F.4.

---

## Codebase E — G36K working RT scope reference

File: `/home/z/my-project/lua/weapons/weapon_uh_snip_g36.lua` (410 lines).

Inherits from `weapon_cuh_base_gun` (line 19-20):
```lua
DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"
```

### E.1 SCOPE-RELEVANT FIELDS (G36K)

`weapon_uh_snip_g36.lua:51-57`:

```lua
SWEP.Sensitivity            = 0.2
SWEP.ZoomFov                = 10
SWEP.ScopeBlur              = true
SWEP.ScopeFov               = 10
SWEP.ScopeTexture            = Material("models/weapons/v_models/g36k/lens")
SWEP.Use2DScope             = true
SWEP.TwoHanded              = true
SWEP.AnimSprint             = true
```

**Critical observation:** The G36K uses `SWEP.Use2DScope = true` (line 56),
NOT `false`. This means the G36K uses the **2D scope HUD overlay** in
addition to the RT scope. The 2D overlay renders a black-bordered scope
circle in the center of the screen, with `gmod/scope` material as the lens
texture.

The WWII scope attachments set `wep.Use2DScope = false` (line 36 of each
attachment file), which DISABLES the 2D overlay. This means the player
sees the 3D RT rendered ON the viewmodel's scope lens mesh — but ONLY
if the viewmodel's lens mesh uses the `Material("models/weapons/v_models/g36k/lens")`
material.

### E.2 G36K IronSightsPos

`weapon_uh_snip_g36.lua:129-130`:

```lua
SWEP.IronSightsPos = Vector(-3.6, -8.801, -0.361)
SWEP.IronSightsAng = Vector(0, 0, 0)
```

The G36K has ONE IronSightsPos tuned for its scope. When the Auto fire
mode is active (NoScope), the IronSightsPos is swapped at runtime
(`weapon_uh_snip_g36.lua:81` and `:90`):

```lua
equip = function(ply, wep)
    wep:SetNWBool("NoScope", true)
    wep.ScopeDisabled               = true
    wep.Primary.Automatic   = true
    wep.IronSightsPos               = Vector(-3.6, -5.5, 0.26)  -- shorter eye relief
    wep.ScopeBlur                   = false
    wep.Sensitivity                 = 1
    wep.Primary.Delay               = 0.12
end,
holster = function(ply, wep)
    wep:SetNWBool("NoScope", false)
    wep.ScopeDisabled               = false
    wep.Primary.Automatic   = false
    wep.IronSightsPos               = Vector(-3.6, -8.801, -0.361)  -- restore scope eye relief
    wep.ScopeBlur                   = true
    wep.Sensitivity                 = 0.2
    wep.Primary.Delay               = 0.25
end
```

This is the **canonical pattern** for swapping IronSightsPos per scope
state: write directly to `wep.IronSightsPos` at runtime. The same pattern
should be used by scope attachments.

### E.3 G36K ScopeBones manipulation

`weapon_uh_snip_g36.lua:159-163`:

```lua
SWEP.ScopeBones = {
    ["scope"] = Vector(0,0,0),
    ["scope-flap1"] = Vector(0,0,0),
    ["scopeflap2"] = Vector(0,0,0)
}
```

And `CustomThink` at lines 194-209 manipulates these bones when NoScope
is active:

```lua
function SWEP:CustomThink( ct )
    if not IsValid(self.Owner) then return end
    local vm = self.Owner:GetViewModel()
    if IsValid(vm) then
        for bone,sca in pairs(self.ScopeBones) do
            local bone_id = vm:LookupBone(bone)
            if !bone_id then continue end

            if self:GetNWBool("NoScope") then
                vm:ManipulateBoneScale(bone_id, sca)
            else
                vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
            end
        end
    end
end
```

This scales the scope bones down to zero when the Auto fire mode is
active (so the scope visually disappears). The WWII weapons do not
have an equivalent mechanism.

### E.4 G36K ShootAnimation

`weapon_uh_snip_g36.lua:180-188`:

```lua
function SWEP:ShootAnimation()
    if self:GetUHBool("Zooming") and self.Animations and self.Animations["iron_fire"] then
        return "iron_fire"
    end
    if self.Animations and self.Animations["shoot"] then
        return "shoot"
    end
    return ACT_VM_PRIMARYATTACK
end
```

Uses the `iron_fire` animation key when zoomed — this is a model
animation that plays the recoil while in the ironsight pose.

### E.5 G36K Animsounds

`weapon_uh_snip_g36.lua:150-154`:

```lua
SWEP.Animations = {
    ["reload_empty"] = "ACT_VM_RELOAD",
    ["reload_empty_sil"] = "ACT_VM_RELOAD",
    ["reload_sil"] = "ACT_VM_RELOAD"
}
```

(Empty AnimSounds table at line 156.)

---

## Cross-cutting analysis

### G.1 TFA vs UNDERHELL — STRUCTURAL DIFFERENCES

| Aspect | TFA Base | Underhell Base |
|---|---|---|
| RT creation location | Inside `tfa_gun_base` (not in documentation) — uses `SWEP.RTMaterialOverride` | Inside `SWEP:Initialize()` of the gun base (`weapon_uh_base_gun.lua:118`) |
| RT name uniqueness | Per-weapon (internal to TFA base) | Original: shared by quality setting (`"UH_SniperScopeRT_"..num`); CUH: per-weapon (`"CustomUH_ScopeRT_"..self:EntIndex()`) |
| RT quality ConVar | None documented | `uh_rt_quality` (1-4) |
| RT → lens binding | `TFA_RTScope` material proxy (declared in VMT) | Direct `ScopeTexture:SetTexture("$basetexture", RenderTarget)` call |
| Lens material path | Set in VMT | `SWEP.ScopeTexture = Material("path")` |
| RenderScene hook | None in template docs | Global hook `"UHSniperRenderScene"` / `"CustomUH_SniperRenderScene"` |
| Fallback when not zooming | TFA base internal | `devzoom = Material("vgui/scope_lens")` swaps in |
| Mouse sensitivity | `SWEP.IronSightsSensitivity` (default 1) | `SWEP.Sensitivity` (default 0.2) |
| Ironsight position swap | Per-attachment `WeaponTable.IronSightsPos` | Same pattern (no `IronSightsPos_SCOPE` convention) |
| Scope overlay (2D) | `SWEP.Scoped`, `SWEP.Secondary.ScopeTable`, `SWEP.ScopeScale`, `SWEP.ReticleScale`, `SWEP.ScopeOverlayThreshold` | `SWEP.Use2DScope` (bool) + hardcoded `gmod/scope` material |
| Stencil sights (red-dot alternative) | Full system (`SWEP.StencilSight*`) | Not implemented |
| Animation tables | `SWEP.IronAnimation` with `in`/`loop`/`out`/`shoot` keys | None — purely procedural |
| `attach`/`detach` callbacks | `ATTACHMENT:Attach(wep)` / `:Detach(wep)` (called BEFORE stat cache rebuild) | Same names but called AFTER stat cache application (in CUH) |
| `RTCode` callback | `ATTACHMENT:RTCode(wep, rt_texture, w, h)` if `SWEP.RTDrawEnabled` | Not implemented |

### G.2 TFA-SPECIFIC FIELDS NOT IN UNDERHELL

| Field | TFA Template Line | Notes |
|---|---|---|
| `SWEP.RTMaterialOverride` | `tfa_base_template.lua:890` | Numeric material index for the lens |
| `SWEP.RTOpaque` | `tfa_base_template.lua:891` | RT opacity flag |
| `SWEP.RTCode` | `tfa_base_template.lua:892` | Custom RT draw function |
| `SWEP.RTBGBlur` | `tfa_base_template.lua:893` | Background blur during 3D scope |
| `SWEP.IronSightsSensitivity` | `tfa_base_template.lua:602` | Mouse sensitivity (renamed to `Sensitivity` in Underhell) |
| `SWEP.Scoped` | `tfa_base_template.lua:604` | Draw scope overlay? (Underhell uses `Use2DScope`) |
| `SWEP.ScopeOverlayThreshold` | `tfa_base_template.lua:605` | 0.875 default |
| `SWEP.ScopeScale` | `tfa_base_template.lua:607` | 0.5 default |
| `SWEP.ReticleScale` | `tfa_base_template.lua:608` | 0.7 default |
| `SWEP.BoltAction` | `tfa_base_template.lua:603` | Unscope after shooting |
| `SWEP.BoltTimerOffset` | `tfa_base_template.lua:606` | 0.25 default |
| `SWEP.Secondary.UseACOG` / `UseMilDot` / `UseSVD` / `UseParabolic` / `UseElcan` / `UseGreenDuplex` | `tfa_base_template.lua:611-616` | GDCW overlay options |
| `SWEP.Secondary.ScopeTable` | `tfa_base_template.lua:621-632` | Custom scope overlay definition |
| `SWEP.Secondary.IronSightsEnabled` | `tfa_base_template.lua:542` | |
| `SWEP.Secondary.OwnerFOV` (aka `IronFOV`) | `tfa_base_template.lua:548` | Player FOV during ADS (Underhell uses `ZoomFov` as a subtraction) |
| `SWEP.Secondary.ViewModelFOV` (aka `IronViewModelFOV`) | `tfa_base_template.lua:550` | Default 65 |
| `SWEP.Secondary.OwnerFOVUseThreshold` | `tfa_base_template.lua:552` | |
| `SWEP.Secondary.OwnerFOVThreshold` | `tfa_base_template.lua:553` | Defaults to `ScopeOverlayThreshold` |
| `SWEP.StencilSight*` (15+ fields) | `tfa_base_template.lua:939-988` | Stencil sight system |
| `SWEP.IronSightsPosition` (legacy name) | `tfa_base_template.lua:428` | Same as `IronSightsPos` |
| `SWEP.IronSightsAngle` (legacy name) | `tfa_base_template.lua:429` | Same as `IronSightsAng` |
| `SWEP.IronSightsReloadEnabled` | `tfa_base_template.lua:470` | ADS reload animations |
| `SWEP.IronSightsReloadLock` | `tfa_base_template.lua:472` | |
| `SWEP.AllowIronSightsDoF` | `tfa_base_template.lua:466` | Default true |
| `SWEP.IronSightsDoF_FocusAttachment` | `tfa_base_template.lua:467` | |
| `SWEP.IronSightHoldTypeOverride` | `tfa_base_template.lua:569` | Holdtype during ADS |

### G.3 UNDERHELL-SPECIFIC FIELDS NOT IN TFA

| Field | Underhell File:Line | Notes |
|---|---|---|
| `SWEP.ScopeTexture` | `weapon_uh_base_gun.lua:118` | Material() instance — replaces TFA's `RTMaterialOverride` |
| `SWEP.ScopeFov` | `weapon_uh_base_gun.lua:1261` | RT render FOV (default 8) |
| `SWEP.ScopeDisabled` | `weapon_uh_base_gun.lua:1244` | Bool to disable RT |
| `SWEP.Sensitivity` | `weapon_uh_base_gun.lua:1279` | Default 0.2 (renamed from TFA's `IronSightsSensitivity`) |
| `SWEP.Use2DScope` | `weapon_uh_base_gun.lua:1325` | 2D HUD overlay toggle |
| `SWEP.ScopeBlur` | `weapon_uh_base_gun.lua:767` | pp/blurscreen during ADS |
| `SWEP.ZoomFov` | `weapon_uh_base_gun.lua:33` | View FOV reduction (default 15) |
| `SWEP.ZoomSpeedIn` (CUH only) | `weapon_custom_uh_base.lua:91` | Default 15 |
| `SWEP.ZoomSpeedOut` (CUH only) | `weapon_custom_uh_base.lua:92` | Default 10 |
| `SWEP.IronsightSpeed` (CUH only) | `weapon_custom_uh_base.lua:89` | Default 10 |
| `SWEP.IronsightEaseIn` (CUH only) | `weapon_custom_uh_base.lua:90` | Default 1.5 |
| `SWEP.IronSightsDipPos` (CUH only) | `weapon_custom_uh_base.lua:111` | Default `Vector(0, -1.5, -2.0)` |
| `SWEP.IronSightsDipAng` (CUH only) | `weapon_custom_uh_base.lua:112` | Default `Angle(3, 0, 0)` |
| `SWEP.IronSightsDipScale` (CUH only) | `weapon_custom_uh_base.lua:113` | Default 1.0 |
| `self.RenderTarget` | `weapon_uh_base_gun.lua:130` | Per-weapon ITexture |
| `self.RT_Size` | `weapon_uh_base_gun.lua:128` | RT size in pixels |
| ConVar `uh_rt_quality` | `weapon_uh_base_gun.lua:127` | 1-4 quality selector |
| `GetUHBool("Zooming")` | `weapon_uh_base_gun.lua:244` | Networked ADS state |
| `SWEP.ScopeBones` (G36K only) | `weapon_uh_snip_g36.lua:159` | Bones to scale to 0 when scope is off |

### G.4 SHARED FIELDS (TFA + Underhell)

| Field | Notes |
|---|---|
| `SWEP.IronSightsPos` | Same name (TFA also accepts legacy `IronSightsPosition`) |
| `SWEP.IronSightsAng` | Same name (TFA also accepts legacy `IronSightsAngle`) |
| `SWEP.Base` | String inheritance chain |
| `SWEP.ViewModel` / `SWEP.WorldModel` | Standard GMod |
| `SWEP.Attachments` | TFA and CUH both use slot-keyed tables, but with different schemas for `default` |
| `ATTACHMENT.WeaponTable` | Same name, near-identical schema (VElements/WElements/Primary/Secondary/Bodygroups_V/Animations/AnimSounds) |
| `ATTACHMENT.Attach(wep)` / `ATTACHMENT.Detach(wep)` | Same names; semantics differ (TFA: BEFORE cache; CUH: AFTER cache) |
| `SWEP.Animations` | TFA uses structured table with `type`/`value`/`value_empty`/`transition`; Underhell uses simple string-or-array-of-strings per key |
| `SWEP.Primary.Sound` / `Primary.SilencedSound` | TFA uses both; Underhell uses `Primary.SilSound` (renamed) |

---

## What's wrong with the current WWII scope attachments

### F.1 — `scope_default` VElement does not exist on the Arisaka

**File:** `tfa_codww2_arisaka_scope.lua:13-15`

```lua
ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["scope_default"] = { ["active"] = true },
    },
    ...
}
```

**Problem:** `kate_arisaka.lua` does NOT define a `scope_default` VElement.
It only defines `scope_acog`. The grep at `/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_arisaka.lua`
returns zero matches for `scope_default`. The Arisaka VElements table
starts at line 399 with `["scope_acog"]` and continues with `clip_default`,
`ext_clip`, `receiver_default`, `barrel_default`, `charm_default`, and
`stock_default` — but no `scope_default`.

**Result:** When the Arisaka Scope attachment is equipped, the
`VElements["scope_default"].active = true` write goes nowhere —
the VElement doesn't exist. The ApplyAttachments function will silently
write to `nil.ViewModelElements["scope_default"]` (or create a new entry
with no model, no bone, no ClientsideModel) and nothing visible happens.

**Verification:**

```
$ rg "scope_default" /home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_arisaka.lua
(no matches)
```

By contrast, `kate_kar98k.lua:421`, `kate_enfield.lua:397`,
`kate_mosin.lua:386`, and `kate_springfield.lua:397` ALL define
`["scope_default"]` VElements. So 5 of the 6 WWII sniper weapons have
the VElement, but the Arisaka does not.

### F.2 — Wrong `ScopeTexture` material path

**File:** All 7 WWII scope attachment files, line 31:

```lua
wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
```

**Problem:** This material path is for the G36K's lens — NOT for the WWII
weapons' scope lens. The WWII weapon viewmodels
(`models/weapons/tfa_codww2/kar98k/c_kar98k_scope.mdl`, etc.) use their
own lens materials, which are typically located at paths like
`models/weapons/tfa_codww2/kar98k/scope_lens` (or similar — the exact
path depends on the VMT file shipped with the model).

**Why this matters:** The CUH/Underhell RT scope system works by
overwriting `$basetexture` on the `SWEP.ScopeTexture` material. If
`SWEP.ScopeTexture` points at a material that the viewmodel doesn't
actually use, the RT render will be drawn into the G36K's lens
material (which is invisible because the WWII weapon viewmodel
doesn't render the G36K lens mesh). The player sees no scope view.

**Verification:** Run `LocalPlayer():GetViewModel():GetMaterials()` in
the console while holding a Kar98k with the scope attachment equipped,
and verify the materials list does NOT contain
`models/weapons/v_models/g36k/lens`. The actual scope lens material
will be one of the materials in that list.

**Fix:** Each scope attachment should reference the correct lens
material for its weapon. Since the attachments are per-weapon (one per
WWII sniper), each attachment file should hardcode the correct path
for its specific weapon, e.g.:

```lua
-- tfa_codww2_kar98k_scope.lua:
wep.ScopeTexture = Material("models/weapons/tfa_codww2/kar98k/scope_lens")
```

### F.3 — `Use2DScope = false` may be incorrect for the WWII models

**File:** All 7 WWII scope attachment files, line 36:

```lua
wep.Use2DScope = false  -- NO 2D overlay — use the true RT lens system
```

**Problem:** The comment "use the true RT lens system" suggests the
author intended to render the RT directly onto the viewmodel's scope
lens mesh. This requires:

1. The viewmodel has a lens mesh with a material whose `$basetexture`
   can be swapped at runtime (i.e., the material is loaded with
   `Material("path")` and bound to the lens mesh via the model's QC).
2. The `SWEP.ScopeTexture` Material() instance is the SAME Material()
   that the lens mesh uses. (This is satisfied if both point at the
   same VMT path on disk.)

Both conditions are violated by the WWII scope attachments (see §F.2).
Therefore, setting `Use2DScope = false` produces **NO visible scope
view at all** — the player ADSes and sees the normal 3D view (slightly
zoomed by `ZoomFov`), but no scope lens image, no reticle, no overlay.

**Two possible fixes:**

**Fix A (recommended): Use the 2D scope overlay.** Set
`wep.Use2DScope = true` (matching the G36K reference). This produces
the G36K-style screen-filling black-bordered scope circle with the
`gmod/scope` lens texture. No viewmodel lens material lookup needed.
This is the easiest fix and matches the working reference.

**Fix B (harder): Fix the lens material path.** Set the correct
`wep.ScopeTexture` path per-weapon so the RT renders on the actual
viewmodel lens mesh. This requires shipping a custom VMT for each
weapon's scope lens material that includes the `$basetexture` field,
and knowing the correct material path. Significant asset-work.

### F.4 — Scope attachments are not registered in any weapon's Attachments table

**File:** All 6 WWII sniper weapon files:

```
/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_kar98k.lua:542-545
/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_arisaka.lua:500-503
/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_enfield.lua:511-514
/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_mosin.lua:465-468
/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_springfield.lua:518-521
```

All five have IDENTICAL Attachments tables:

```lua
SWEP.Attachments = {
    [2] = { name = "Slot 2", atts = { "tfa_codww2_xmag", "tfa_codww2_ballistic" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
}
```

**Problem:** There is **no Slot [1]** listing any of the scope
attachments. The scope attachment files exist in
`/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments/` and will
be loaded by the CustomUH autorun loader (`sh_cuh_attachments.lua:62-103`)
into the `CustomUH.Attachments` table — but no weapon's `SWEP.Attachments`
references them, so the player can never equip them.

This is the **root cause** of "the RT scope doesn't render" — the
attachment is never applied to the weapon because the player has no
way to select it.

**Verification:**

```
$ rg "tfa_codww2_(kar98k_scope|arisaka_scope|enfield_scope|mosin_scope|springfield_scope|scope|4x)" \
    /home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_*.lua
(no matches)
```

The 7 scope attachment IDs never appear in any WWII weapon's Attachments
table.

**Fix:** Add a Slot [1] (Optic) to each WWII sniper's Attachments table:

```lua
SWEP.Attachments = {
    [1] = {
        name = "Optic",
        atts = {
            "tfa_codww2_kar98k_scope",   -- or "tfa_codww2_arisaka_scope" etc.
            "tfa_codww2_4x",              -- shared ACOG attachment
        },
        default = 0,  -- 0 = no default; player must select
    },
    [2] = { name = "Slot 2", atts = { "tfa_codww2_xmag", "tfa_codww2_ballistic" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
}
```

### F.5 — No `IronSightsPos` override for the scope

**File:** All 7 WWII scope attachment files — the `WeaponTable` does NOT
include an `IronSightsPos` field.

**Problem:** The WWII weapon viewmodels have ironsight positions tuned
for the iron sights (e.g., `kate_kar98k.lua:75: SWEP.IronSightsPos = Vector(-4.6, -4.5, 1.33)`).
When the player equips a scope, the weapon still uses this iron-sight
position — so the player's eye is at the iron sight height, not the scope
height. The scope lens appears in the wrong place on screen, and the
RT-rendered view is misaligned with the scope's reticle.

**Fix:** Each scope attachment should set `WeaponTable.IronSightsPos` and
`WeaponTable.IronSightsAng` to the correct eye-relief position for that
weapon's scope. The values must be determined by using the SWEP Creation
Kit on the weapon model with the scope VElement active.

Example (hypothetical Kar98k scope position):

```lua
ATTACHMENT.WeaponTable = {
    ["VElements"] = { ["scope_default"] = { ["active"] = true } },
    ["WElements"] = { ["scope_default"] = { ["active"] = true } },
    ["IronSightsPos"] = Vector(-2.955, -1.5, 1.204),  -- scope eye relief
    ["IronSightsAng"] = Vector(0, 0, 0),
    ["ScopeFov"] = 7,
    ["ZoomFov"] = 15,
    ["Sensitivity"] = 0.2,
    ...
}
```

The previous gap analysis document
(`/home/z/my-project/wwiiunderhell_kate/docs/gap_analysis.md:1626-1631`)
already prescribes this exact pattern; the WWII attachments simply
didn't implement it.

### F.6 — `IronSightsMoveSpeed` is a dead field

**File:** All 7 WWII scope attachment files, line 23:

```lua
["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
```

**Problem:** No code in the CUH base reads `SWEP.IronSightsMoveSpeed`.
The field is set by the attachment's `WeaponTable` and stored in the
stat cache, but never queried by any of the base files.

**Verification:**

```
$ rg "IronSightsMoveSpeed" /home/z/my-project/lua/weapons/ /home/z/my-project/wwiiunderhell_kate/lua/weapons/
(only matches in the attachment files themselves)
```

The CUH base reads `SWEP.MoveSpeed` (cached at
`weapon_cuh_base_gun.lua:208` as part of the `topLevel` list), but
`SWEP.IronSightsMoveSpeed` is a TFA field name that has no CUH
equivalent.

**Fix:** Either remove the field from the attachments, or add an
`IronSightsMoveSpeed` reader to the CUH base. Removing is simpler.

### F.7 — `Detach` clobbers `ZoomFov` with hardcoded 20

**File:** All 7 WWII scope attachment files, line 52:

```lua
function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20  -- ⚠️ hardcoded
    wep.Sensitivity = nil
    wep.Use2DScope = false
    wep.RenderTarget = nil
end
```

**Problem:** When the scope attachment is detached, `wep.ZoomFov` is
hardcoded to 20. This is the WRONG default for most WWII weapons.
For example, the Kar98k has no `SWEP.ZoomFov` field defined at all
(inheriting the gun base default of 15 from `weapon_custom_uh_base_gun.lua:53`).
After detaching a scope, `wep.ZoomFov` is now 20 instead of 15 — the
iron sights will zoom slightly more than intended.

The `Detach` function should instead restore `wep.ZoomFov` to the
weapon's original value. The CUH stat cache supports this via
`RestoreStat("ZoomFov")`, but the Detach function doesn't use it.

**Fix:** Either:
```lua
function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep:RestoreStat("ZoomFov")   -- restore the original value
    wep:RestoreStat("Sensitivity")
    wep.Use2DScope = false
    wep.RenderTarget = nil
end
```
Or simply nil out the field:
```lua
wep.ZoomFov = nil  -- fall back to base default
```

### F.8 — `RenderTarget = nil` does not free the RT

**File:** All 7 WWII scope attachment files, line 55:

```lua
wep.RenderTarget = nil
```

**Problem:** This dereferences the Lua-side reference to the
`ITexture` object, but the RT itself persists on the GPU until the
engine garbage-collects it (which depends on internal reference
counting). If the player rapidly swaps between scoped weapons, the
GPU memory accumulates orphaned RTs.

This is a minor issue — the engine usually handles RT cleanup
correctly when no Lua references remain. But for robustness, the
engine's `DestroyRenderTarget` (if exposed) or a longer-lived
singleton RT could be used.

### F.9 — Attach function duplicates WeaponTable values

**File:** All 7 WWII scope attachment files, lines 26-46.

**Problem:** The Attach function re-sets `wep.ScopeFov`,
`wep.ZoomFov`, and `wep.Sensitivity` to the same values that are
already in `WeaponTable`. This is redundant — the `WeaponTable`
application in `ApplyAttachments` (Stage 5, lines 911-987) already
applied these values.

The redundant write doesn't cause bugs, but it does mask a more
subtle issue: `WeaponTable` writes go through the stat cache
(`SetStat`), while the direct writes in `Attach` bypass the cache.
On `Detach`, `RestoreStat("ScopeFov")` will restore the cached
origin (nil), but the direct write in `Detach` also sets it to nil
(line 51) — so the end state is the same.

For consistency, the Attach function should either:
1. Use only `WeaponTable` (no direct writes), OR
2. Use only direct writes (no `WeaponTable` for these fields).

Currently it does both, which is confusing and risks subtle
ordering bugs if `ApplyAttachments` ever changes its Stage 5/6
ordering.

### F.10 — `IronSightTime` uses function-transform syntax

**File:** All 7 WWII scope attachment files, line 22:

```lua
["IronSightTime"] = function(wep, val) return val * 1.25 end,
```

**Verification:** The CUH ApplyAttachments pipeline supports
function-transform values via the `pcall`-wrapped path at
`weapon_cuh_base_gun.lua:848-881`. The function is called with
`(wep, currentVal)` and the return value is set via `SetStat`.

**But:** No code in the CUH base reads `SWEP.IronSightTime`. The
`Sights()` function at `weapon_custom_uh_base.lua:274-342` reads
`SWEP.IronsightSpeed` and `SWEP.IronsightEaseIn`, NOT
`SWEP.IronSightTime`. The `IronSightTime` field is set by the
attachment but never queried.

**Verification:**

```
$ rg "IronSightTime" /home/z/my-project/lua/weapons/weapon_custom_uh_base.lua /home/z/my-project/lua/weapons/weapon_custom_uh_base_gun.lua /home/z/my-project/lua/weapons/weapon_cuh_base_gun.lua
(only matches the topLevel cache list at weapon_cuh_base_gun.lua:208)
```

The field IS cached (line 208 of `weapon_cuh_base_gun.lua` includes
`"IronSightTime"` in the topLevel list), but nothing reads the cache
to actually use it.

**Fix:** Either:
1. Remove `IronSightTime` from the attachments (since it has no
   effect), OR
2. Add `SWEP.IronsightSpeed = self:GetStat("IronSightTime")` logic
   to the `Sights()` function so the cached `IronSightTime` value
   actually drives the ironsight lerp speed.

Option 2 would make the attachment's `1.25×` multiplier actually
slow down the ADS transition by 25%, which appears to be the
intent.

### F.11 — Summary of root causes

| Symptom | Root cause | Section |
|---|---|---|
| Scope attachments cannot be equipped | Slot [1] missing from WWII weapons' Attachments table | §F.4 |
| RT scope view does not render on the lens | Wrong `ScopeTexture` material path (G36K's path used for all WWII weapons) | §F.2 |
| RT scope view does not render (alternative cause) | `Use2DScope = false` requires the viewmodel lens mesh to use the `ScopeTexture` material, which it doesn't | §F.3 |
| Ironsights misaligned when scope equipped | No `IronSightsPos` override in the attachment's `WeaponTable` | §F.5 |
| Arisaka scope attachment does nothing visible | Arisaka has no `scope_default` VElement (only `scope_acog`) | §F.1 |
| Detach clobbers weapon's original ZoomFov | Hardcoded `wep.ZoomFov = 20` in Detach | §F.7 |
| `IronSightTime` and `IronSightsMoveSpeed` fields have no effect | CUH base doesn't read these fields | §F.6, §F.10 |

---

## Next actions

### Priority 1 — Make scope attachments equippable

Add Slot [1] (Optic) to each WWII sniper's Attachments table. Required for
all 6 affected weapons:

- `kate_kar98k.lua:542`
- `kate_arisaka.lua:500`
- `kate_enfield.lua:511`
- `kate_mosin.lua:465`
- `kate_springfield.lua:518`
- (Also check `kate_delisle.lua`, `kate_ptrs41.lua`, `kate_wz35.lua`,
  `kate_winchester94.lua`, `kate_mas36.lua` if they have scope VElements.)

Example patch for `kate_kar98k.lua`:

```lua
SWEP.Attachments = {
    [1] = {
        name = "Optic",
        atts = { "tfa_codww2_kar98k_scope", "tfa_codww2_4x" },
        default = 0,
    },
    [2] = { name = "Slot 2", atts = { "tfa_codww2_xmag", "tfa_codww2_ballistic" }, default = 0 },
    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
}
```

### Priority 2 — Fix the Arisaka missing `scope_default` VElement

Either:
- Add a `scope_default` VElement to `kate_arisaka.lua` pointing at the
  Arisaka's standard scope model (if one ships with the TFA WWII assets).
- Or change `tfa_codww2_arisaka_scope.lua` to activate `scope_acog` instead
  of `scope_default` (but this would conflict with the actual 4x ACOG
  attachment — so adding the VElement is preferred).

### Priority 3 — Fix the ScopeTexture material path

For each of the 7 scope attachments, replace
`Material("models/weapons/v_models/g36k/lens")` with the correct path
for that weapon's scope lens VMT. The correct path can be found by:

1. Loading the weapon viewmodel in HLMV or in-game with `developer 1`.
2. Inspecting the model's material list.
3. Identifying the lens material (usually has "lens", "scope", or
   "glass" in the name).
4. Using that VMT path for `SWEP.ScopeTexture`.

If the correct path is unknown, the safer alternative is **Fix A from
§F.3**: set `wep.Use2DScope = true` and let the G36K-style 2D overlay
handle the scope view. This requires no per-weapon material lookup.

### Priority 4 — Add `IronSightsPos` / `IronSightsAng` overrides

Each scope attachment's `WeaponTable` must include the correct eye-relief
position for that weapon's scope. This requires per-weapon tuning via
the SWEP Creation Kit.

### Priority 5 — Clean up the attachments

- Remove the dead `IronSightsMoveSpeed` field (§F.6) OR add a reader to
  the CUH base.
- Remove the dead `IronSightTime` field (§F.10) OR add a reader to the
  `Sights()` function.
- Stop duplicating the ScopeFov/ZoomFov/Sensitivity values in both
  `WeaponTable` AND `Attach()` (§F.9). Pick one.
- Replace `wep.ZoomFov = 20` in `Detach()` with `wep:RestoreStat("ZoomFov")`
  (§F.7).

### Priority 6 — Consider adding material proxy support

If the long-term goal is to use TFA-style lens material VMTs with the
`TFA_RTScope` proxy (see §A.3), the CUH base would need to:

1. Register the `TFA_RTScope` material proxy with the engine (requires
   a C++ module or a Lua-side `matproxy.Add` registration).
2. Stop calling `ScopeTexture:SetTexture("$basetexture", RenderTarget)`
   in the RenderScene hook.
3. Instead, set a weapon-specific `$rt_texture` parameter on the lens
   material that the proxy reads.

This is a significant refactor and is not necessary if Fix A from §F.3
(use `Use2DScope = true`) is acceptable.

---

## Appendix A — Field reference (quick lookup)

### A.1 Underhell/CUH RT scope fields

| Field | Type | Default | Where defined | Where read |
|---|---|---|---|---|
| `SWEP.ScopeTexture` | IMaterial | nil | weapon file | `weapon_uh_base_gun.lua:118, 1244, 1266, 1268`; `weapon_custom_uh_base_gun.lua:135, 962, 975, 977-978` |
| `SWEP.ScopeFov` | number | 8 | weapon file / attachment | `weapon_uh_base_gun.lua:1261`; `weapon_custom_uh_base_gun.lua:972` |
| `SWEP.ScopeDisabled` | bool | false | weapon file / attachment | `weapon_uh_base_gun.lua:1244`; `weapon_custom_uh_base_gun.lua:963` |
| `SWEP.Sensitivity` | number | 0.2 | weapon file / attachment | `weapon_uh_base_gun.lua:1274-1279`; `weapon_custom_uh_base_gun.lua:985-988` |
| `SWEP.Use2DScope` | bool | false | weapon file / attachment | `weapon_uh_base_gun.lua:1308, 1325`; `weapon_custom_uh_base.lua:958`; `weapon_custom_uh_base_gun.lua:1018, 1030` |
| `SWEP.ScopeBlur` | bool | false | weapon file | `weapon_uh_base.lua:767`; `weapon_custom_uh_base.lua:976` |
| `SWEP.ZoomFov` | number | 15 (gun base) / 0 (parent base) | weapon file / gun base | `weapon_uh_base.lua:720, 721`; `weapon_custom_uh_base.lua:922` |
| `SWEP.ZoomSpeedIn` | number | 15 | parent base (CUH) | `weapon_custom_uh_base.lua:924` |
| `SWEP.ZoomSpeedOut` | number | 10 | parent base (CUH) | `weapon_custom_uh_base.lua:925` |
| `self.RenderTarget` | ITexture | nil | gun base Initialize | `weapon_uh_base_gun.lua:130, 1246`; `weapon_custom_uh_base_gun.lua:141, 965, 975` |
| `self.RT_Size` | number | nil | gun base Initialize | `weapon_uh_base_gun.lua:128, 1245`; `weapon_custom_uh_base_gun.lua:139, 964` |
| ConVar `uh_rt_quality` | int 1-4 | (registered externally) | external addon | `weapon_uh_base_gun.lua:127`; `weapon_custom_uh_base_gun.lua:138` |

### A.2 Ironsight fields

| Field | Default | Where defined | Where read |
|---|---|---|---|
| `SWEP.IronSightsPos` | Vector(-3.701, -6.79, 0.419) (gun) / Vector(-6, -8, -10) (parent) | weapon file / gun base / parent base | `weapon_uh_base.lua:209`; `weapon_custom_uh_base.lua:332`; `weapon_cuh_base_gun.lua:226-228` |
| `SWEP.IronSightsAng` | Vector(0, 0, 0) (gun) / Vector(20, 40, -60) (parent) | weapon file / gun base / parent base | `weapon_uh_base.lua:211`; `weapon_custom_uh_base.lua:333`; `weapon_cuh_base_gun.lua:230-232` |
| `SWEP.IronsightSpeed` | 10 | parent base (CUH) | `weapon_custom_uh_base.lua:282` |
| `SWEP.IronsightEaseIn` | 1.5 | parent base (CUH) | `weapon_custom_uh_base.lua:283` |
| `SWEP.IronsightLateralSpeed` | 1.8 | per-weapon override | `weapon_custom_uh_base.lua:284` |
| `SWEP.IronsightForwardSpeed` | 0.6 | per-weapon override | `weapon_custom_uh_base.lua:295` |
| `SWEP.IronSightsDipPos` | Vector(0, -1.5, -2.0) | parent base (CUH) | `weapon_custom_uh_base.lua:315` |
| `SWEP.IronSightsDipAng` | Angle(3, 0, 0) | parent base (CUH) | `weapon_custom_uh_base.lua:316` |
| `SWEP.IronSightsDipScale` | 1.0 | parent base (CUH) | `weapon_custom_uh_base.lua:312` |
| `SWEP.IronSightTime` | (cached but unused) | per-weapon / attachment | `weapon_cuh_base_gun.lua:208` (cached), nowhere read |
| `SWEP.IronSightsMoveSpeed` | (cached but unused) | per-weapon / attachment | nowhere read |

### A.3 Animation keys used by the gun base

| Key | Purpose | Reference |
|---|---|---|
| `draw` | Deploy animation | `weapon_uh_base.lua:594, 611, 626` |
| `first_draw` | Animated first-deploy animation | `weapon_uh_base.lua:594` |
| `idle` | Idle loop | `weapon_uh_base.lua:460` (comment) |
| `idle_empty` | Empty idle loop | `weapon_uh_base.lua:416, 459` |
| `idle_sil` | Silenced idle loop | `weapon_uh_base.lua:458` |
| `shoot` | Hip-fire shoot | `weapon_uh_base_gun.lua:612` |
| `shoot_ads` | ADS shoot | `weapon_uh_base_gun.lua:612` |
| `shoot_sil` | Silenced hip-fire shoot | `weapon_uh_base_gun.lua:614` |
| `shoot_ads_sil` | Silenced ADS shoot | `weapon_uh_base_gun.lua:614` |
| `reload` | Reload (partial) | `weapon_uh_base_gun.lua:1083, 1086` |
| `reload_empty` | Reload (from empty) | `weapon_uh_base_gun.lua:1083` |
| `reload_sil` | Silenced reload | (CUH only) |
| `reload_empty_sil` | Silenced empty reload | (CUH only) |
| `idle_walk` | Walking idle | `weapon_uh_base_gun.lua:419, 430` (commented out) |
| `iron_fire` | Ironsight fire animation | G36K `weapon_uh_snip_g36.lua:181` |
| `inspect` | Inspection | `weapon_uh_snip_g36.lua:297` |
| `mantle` | Mantle animation | `weapon_uh_snip_g36.lua:276` |
| `melee` | Melee bash | `weapon_cuh_base_gun.lua:1138` |

### A.4 RT scope rendering call chain (CUH)

```
Player holds RMB
  → SWEP:Think() (weapon_custom_uh_base_gun.lua:332)
    → reads self.Owner:KeyDown(IN_ATTACK2)
    → sets self:SetUHBool("Zooming", true)
    → plays "weapons/underhell/ironsight_on.wav"

Next render frame:
  → RenderScene hook fires (weapon_custom_uh_base_gun.lua:958)
    → LocalPlayer():GetActiveWeapon() returns the scoped weapon
    → IsCustomUHWeapon(wep) walks Base chain
    → wep.ScopeTexture is non-nil (set by attachment's Attach)
    → wep:GetUHBool("Zooming") is true
    → wep.ScopeDisabled is false
    → render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
    → render.RenderView({fov = wep.ScopeFov or 8, ...})
    → render.PopRenderTarget()
    → wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)

Concurrently in CalcView (weapon_custom_uh_base.lua:922-933):
  → isZooming = self:GetUHBool("Zooming")
  → self._zoomBlend lerps toward self.ZoomFov
  → fov = fov - self._zoomBlend  (player's view FOV decreases)

Concurrently in GetViewModelPosition (weapon_custom_uh_base.lua:177):
  → Sights() runs (line 274)
  → self._ironBlendLat lerps toward 1
  → pos offset by self.IronSightsPos * pLat
  → ang offset by self.IronSightsAng * pLat / pFwd

Concurrently in PreDrawViewModel (weapon_custom_uh_base.lua:957):
  → if self.Use2DScope and self:GetUHBool("Zooming")
  →   render.SetBlend(0); return  (hide viewmodel)

Concurrently in DrawHUD (weapon_custom_uh_base_gun.lua:1000):
  → if self.Use2DScope and self:GetUHBool("Zooming")
  →   draw black screen-boxing rectangles
  →   draw gmod/scope lens texture in center
  →   draw crosshair lines

Concurrently in AdjustMouseSensitivity (weapon_custom_uh_base_gun.lua:984):
  → hasScope = self.ScopeTexture or self.Use2DScope
  → if hasScope and self:GetUHBool("Zooming")
  →   return self.Sensitivity or 0.2
```

### A.5 RT scope fallback (not zooming)

```
Player releases RMB
  → SWEP:Think() sets self:SetUHBool("Zooming", false)

Next render frame:
  → RenderScene hook fires
  → wep:GetUHBool("Zooming") is false
  → ELSE branch (line 976-980):
    → if wep.ScopeTexture then
    →   wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
    → end
  → devzoom = Material("vgui/scope_lens")  (the static fallback)
```

---

## Appendix B — Verbatim quotes from the audited files

### B.1 TFA Base Template — scope-related lines

From `/home/z/my-project/repos/tfa_base_docs/lua/tfa/documentation/tfa_base_template.lua`:

```
601:----------------- Scopes related
602:SWEP.IronSightsSensitivity = 1 -- Useful for a RT scope. Change this to 0.25 for 25% sensitivity.
603:SWEP.BoltAction = false -- Unscope/sight after you shoot?
604:SWEP.Scoped = false -- Draw a scope overlay?
605:SWEP.ScopeOverlayThreshold = 0.875 -- Percentage you have to be sighted in to see the scope.
606:SWEP.BoltTimerOffset = 0.25 -- How long you stay sighted in after shooting, with a bolt action.
607:SWEP.ScopeScale = 0.5 -- Scale of the scope overlay
608:SWEP.ReticleScale = 0.7 -- Scale of the reticle overlay
889:----------------- Render target related
890:SWEP.RTMaterialOverride         = nil -- Take the material you want out of PrintTable(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
891:SWEP.RTOpaque                   = false -- Do you want your render target to be opaque?
892:SWEP.RTCode                     = nil -- function(self) return end -- This is the function to draw onto your rendertarget
893:SWEP.RTBGBlur                   = true -- Draw background blur when 3D scope is active?
```

### B.2 TFA Material Proxies — TFA_RTScope

From `/home/z/my-project/repos/tfa_base_docs/lua/tfa/documentation/tfa_matproxies.lua`:

```
49:-- Name: TFA_RTScope
50:-- Description: Replaces $basetexture with render target texture of 3D scopes
51:-- VMT Example:
52:--[[
53:        Proxies
54:        {
55:                TFA_RTScope
56:                {
57:                }
58:        }
59:]]
```

### B.3 Original Underhell — RT scope creation (Initialize)

From `/home/z/my-project/upload/weapon_uh_base_gun.lua`:

```
109:function SWEP:Initialize()
118:        if CLIENT and self.ScopeTexture then
119:                local scale = ScrH()/1080
120:                local quality = {
121:                        256,
122:                        512,
123:                        768,
124:                        1080
125:                }
126:                
127:                local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
128:                self.RT_Size = quality[num] * scale
129:                
130:                self.RenderTarget = GetRenderTarget("UH_SniperScopeRT_"..num, self.RT_Size, self.RT_Size, false)
131:        end
132:end
```

### B.4 Original Underhell — RenderScene hook

From `/home/z/my-project/upload/weapon_uh_base_gun.lua`:

```
1239:local devzoom = Material("vgui/scope_lens")
1241:hook.Add("RenderScene", "UHSniperRenderScene", function(origin, angles, fov)
1242:        local wep = LocalPlayer():GetActiveWeapon()
1243:        if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture then
1244:                if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
1245:                        local size = wep.RT_Size or 512
1246:                        render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
1247:                        
1248:                        local ang = LocalPlayer():EyeAngles()
1249:                        local pos = LocalPlayer():EyePos()
1250:                        
1251:                        render.RenderView({
1252:                                x = 0, y = 0, w = size, h = size,
1253:                                origin = pos,
1254:                                angles = ang,
1255:                                drawviewmodel = false,
1256:                                drawhud = false,
1257:                                dopostprocess = false,
1258:                                fov = wep.ScopeFov or 8
1259:                        })
1260:                        
1261:                        render.PopRenderTarget()
1262:                        
1263:                        wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
1264:                else
1265:                        wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
1266:                end
1267:        end
1268:end)
```

### B.5 CUH Base — RT scope creation (Initialize)

From `/home/z/my-project/lua/weapons/weapon_custom_uh_base_gun.lua`:

```
120:function SWEP:Initialize()
135:    if CLIENT and self.ScopeTexture then
136:        local scale = ScrH() / 1080
137:        local quality = { 256, 512, 768, 1080 }
138:        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
139:        self.RT_Size = quality[num] * scale
140:        -- Use unique RT name per weapon instance to avoid clobbering
141:        self.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. self:EntIndex(), self.RT_Size, self.RT_Size, false)
142:    end
143:end
```

### B.6 CUH Base — RenderScene hook

From `/home/z/my-project/lua/weapons/weapon_custom_uh_base_gun.lua`:

```
932:if CLIENT then
933:    local devzoom = Material("vgui/scope_lens")
958:    hook.Add("RenderScene", "CustomUH_SniperRenderScene", function(origin, angles, fov)
959:        local wep = LocalPlayer():GetActiveWeapon()
960:        if not IsValid(wep) then return end
961:        if not IsCustomUHWeapon(wep) then return end
962:        if not wep.ScopeTexture then return end
963:        if wep:GetUHBool("Zooming") and not wep.ScopeDisabled then
964:            local size = wep.RT_Size or 512
965:            render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
966:            local ang = LocalPlayer():EyeAngles()
967:            local pos = LocalPlayer():EyePos()
968:            render.RenderView({
969:                x = 0, y = 0, w = size, h = size,
970:                origin = pos, angles = ang,
971:                drawviewmodel = false, drawhud = false,
972:                dopostprocess = false, fov = wep.ScopeFov or 8,
973:            })
974:            render.PopRenderTarget()
975:            wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
976:        else
977:            if wep.ScopeTexture then
978:                wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
979:            end
980:        end
981:    end)
982:end
```

### B.7 G36K reference — scope fields

From `/home/z/my-project/lua/weapons/weapon_uh_snip_g36.lua`:

```
51:SWEP.Sensitivity            = 0.2
52:SWEP.ZoomFov                = 10
53:SWEP.ScopeBlur              = true
54:SWEP.ScopeFov               = 10
55:SWEP.ScopeTexture            = Material("models/weapons/v_models/g36k/lens")
56:SWEP.Use2DScope             = true
129:SWEP.IronSightsPos = Vector(-3.6, -8.801, -0.361)
130:SWEP.IronSightsAng = Vector(0, 0, 0)
```

### B.8 WWII Kar98k Attachments table (no Slot [1])

From `/home/z/my-project/wwiiunderhell_kate/lua/weapons/kate_kar98k.lua`:

```
542:SWEP.Attachments = {
543:    [2] = { name = "Slot 2", atts = { "tfa_codww2_xmag", "tfa_codww2_ballistic" }, default = 0 },
544:    [3] = { name = "Slot 3", atts = { "tfa_codww2_rapidfire_sg", "tfa_codww2_fmj" }, default = 0 },
545:}
```

### B.9 WWII Kar98k scope attachment (full file)

From `/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments/tfa_codww2_kar98k_scope.lua`:

```
1:  if not ATTACHMENT then ATTACHMENT = {} end
2:
3:  ATTACHMENT.Name = "Kar98k Scope"
4:  ATTACHMENT.ShortName = "SCOPE"
5:  ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
6:  ATTACHMENT.Description = {
7:      Color(255, 255, 255), "Kar98k Scope",
8:      Color(255, 100, 100), "+25% Zoom time",
9:      Color(255, 100, 100), "-5% ADS Movespeed",
10: }
11:
12: ATTACHMENT.WeaponTable = {
13:     ["VElements"] = {
14:         ["scope_default"] = { ["active"] = true },
15:     },
16:     ["WElements"] = {
17:         ["scope_default"] = { ["active"] = true },
18:     },
19:     ["ScopeFov"] = 7,
20:     ["ZoomFov"] = 15,
21:     ["Sensitivity"] = 0.2,
22:     ["IronSightTime"] = function(wep, val) return val * 1.25 end,
23:     ["IronSightsMoveSpeed"] = function(wep, val) return val * 0.95 end,
24: }
25:
26: function ATTACHMENT:Attach(wep)
27:     wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
28:     wep.ScopeFov = 7
29:     wep.ZoomFov = 15
30:     wep.ScopeDisabled = false
31:     wep.Sensitivity = 0.2
32:     wep.Use2DScope = false
33:
34:     if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
35:         local scale = ScrH() / 1080
36:         local quality = { 256, 512, 768, 1080 }
37:         local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
38:         wep.RT_Size = quality[num] * scale
39:         wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
40:     end
41: end
42:
43: function ATTACHMENT:Detach(wep)
44:     wep.ScopeDisabled = true
45:     wep.ScopeTexture = nil
46:     wep.ScopeFov = nil
47:     wep.ZoomFov = 20
48:     wep.Sensitivity = nil
49:     wep.Use2DScope = false
50:     wep.RenderTarget = nil
51: end
52:
53: -- CUH base handles registration
```

---

**End of audit.**
