# CUH RT Scope System — Status & Brainstorm Doc

## Project Overview
- **Repo:** https://github.com/LeRatEmperor/UnderhellCBase
- **Addon path:** `/home/z/my-project/wwiiunderhell_kate/`
- **TFA source repo:** `/home/z/my-project/source_repos/tfa_codww2_source/` (local only, gitignored)
- **Glua skill:** Installed at `/home/z/my-project/skills/glua/` (392 reference files). Available via `Skill(command="glua")` after session restart, or readable manually with the Read tool.

## Architecture
- **Inheritance chain:** `weapon_base` → `weapon_custom_uh_base` → `weapon_custom_uh_base_gun` → `weapon_cuh_base_gun` → `kate_*` (WWII ports)
- **Base files (user's own, DO NOT MODIFY):** `/home/z/my-project/upload/weapon_cuh_base_gun.lua`, `weapon_uh_base_gun.lua`, `weapon_uh_base.lua`
- **Attachment system:** `ApplyAttachments()` 6-stage pipeline with stat cache, VElement model swaps
- **90 WWII weapons** ported to `wwiiunderhell_kate/lua/weapons/kate_*.lua`
- **39 attachment files** in `wwiiunderhell_kate/lua/cuh_attachments/`

## RT Scope System — Current State

### What's Working ✅
1. **RT renders the zoomed 3D scene** — `render.RenderView` into a RenderTarget, confirmed working
2. **Scope lens shows the RT** — via `SetSubMaterial` with `!` prefix on the csModel (RenderOverride approach)
3. **Viewmodel clipping fixed** — `DrawVElements` per-instance override checks `_rtScopeSuppressVElem` flag
4. **Ironsight alignment** — scraped `IronSightsPos_ACOG`, `_LENS`, `_NYDAR` from TFA source for 67 weapons
5. **No stack overflows** — all hooks use local upvalue capture + idempotent guards

### What's Not Working ❌
**The reticle/crosshair texture is NOT appearing on top of the RT scene.**

The RT shows the zoomed 3D scene, but the reticle (crosshair, range-finding ticks) that should be "baked into" the scope lens is missing.

### Approaches Tried and Their Results

| Approach | Result |
|----------|--------|
| `cam.Start2D` + `surface.DrawTexturedRect` inside `PushRenderTarget` | RT works (3D scene shows), but reticle texture doesn't appear |
| `render.SetMaterial` + `render.DrawScreenQuadEx` | **Breaks RT entirely** (missing texture) — reverted |
| `HUDPaint` 2D overlay | Draws reticle over the entire HUD, not on the scope lens — reverted |
| Material shadowing (CreateMaterial with VMT name) | TFA proxy survived, overwrote basetexture — reverted |

## Key Technical Details

### The `!` Prefix (CRITICAL)
`Entity:SetSubMaterial(index, materialName)` — when using a `CreateMaterial` name, you MUST prepend `!`:
```lua
csModel:SetSubMaterial(idx, "!" .. matName)  -- NOT just matName
```
Without `!`, GMod looks for a `.vmt` file on disk (which doesn't exist for CreateMaterial materials) and the override silently fails.

### RenderOverride on csModel
`DrawVElements` calls `model:SetModel(elem.model)` every frame before `model:DrawModel()`, which resets sub-material overrides. Fix: install `csModel.RenderOverride` that calls `SetSubMaterial` right before drawing:
```lua
csModel.RenderOverride = function(self)
    self:SetSubMaterial(idx, "!" .. matName)
    local saved = self.RenderOverride
    self.RenderOverride = nil
    self:DrawModel()
    self.RenderOverride = saved
end
```

### DrawVElements Suppress Flag
`DrawVElements` is called during `render.RenderView` (via PostDrawViewModel hook), drawing VElements into the RT. Fix: per-instance override checks `_rtScopeSuppressVElem`:
```lua
wep.DrawVElements = function(self, vm)
    if self._rtScopeSuppressVElem then return end
    prevDrawVE(self, vm)
end
```

### The Base's RT Hook (weapon_uh_base_gun.lua line 1241)
```lua
hook.Add("RenderScene", "UHSniperRenderScene", function(origin, angles, fov)
    local wep = LocalPlayer():GetActiveWeapon()
    if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture then
        -- renders RT, sets basetexture
    end
end)
```
The `string.find(wep.Base, "weapon_uh_base")` check matches `weapon_uh_base_gun` but NOT `weapon_cuh_base_gun` (substring mismatch). That's why we have our own `CUH_RTScope_RenderScene` hook in `cuh_rt_scope_render.lua`.

### The Scout Sniper Approach (reference)
The Scout sniper (`/home/z/my-project/lua/weapons/weapon_uh_snip_scout.lua`) uses:
```lua
SWEP.ScopeTexture = Material("models/weapons/v_models/sniper_scout/lens")
SWEP.ScopeFov = 7
```
The `lens` VMT has the reticle BAKED INTO the basetexture — no runtime compositing needed. The RT only contains the 3D scene; the reticle is part of the lens texture itself.

### TFA Source Scope Lens VMT
The TFA WWII scope lens VMT (`mtl_generic_optic_ads_lens.vmt`) contains:
```
$basetexture "models/weapons/tfa_codww2/attachments/lens_sight/hipfire_c"
"Proxies" {
    "TFA_COD_Scope" { }  -- C++ proxy that composites the reticle
}
```
The `TFA_COD_Scope` C++ proxy composites the reticle at runtime. We can't use this proxy (it's C++, registered by TFA Base).

### TFA Source Reticle Textures
Each scoped weapon has a `scope_c.vtf` reticle texture:
- `models/weapons/tfa_codww2/mosin/scope_c`
- `models/weapons/tfa_codww2/arisaka/scope_c`
- `models/weapons/tfa_codww2/springfield/scope_c`
- etc. (10 weapons total)

These have been added as `SWEP.ScopeReticle` fields to the Kate weapon files.

## Key Files

### RT Scope Autorun
- **`wwiiunderhell_kate/lua/autorun/cuh_rt_scope_render.lua`**
  - `RenderScene` hook: renders 3D scene into RT, composites reticle (currently broken)
  - `cuh_rt_scope_dump` console command
  - `cuh_ironsight_dump` console command
  - `cuh_adjust_acog` console command (real-time ironsight adjustment)

### RT Scope Attachments (8 files)
- `tfa_codww2_mosin_scope.lua`, `tfa_codww2_arisaka_scope.lua`, `tfa_codww2_springfield_scope.lua`, `tfa_codww2_kar98k_scope.lua`, `tfa_codww2_enfield_scope.lua`, `tfa_codww2_scope.lua` — 7x sniper scopes
- `tfa_codww2_4x.lua` — 4x ACOG
- `tfa_codww2_lens_sight.lua` — Lens sight (reflex-style)

Each attachment file:
1. Creates a unique `CreateMaterial` (`kate_rt_scope_<entIndex>`)
2. Hooks `CustomThink` to find lens material index + install `RenderOverride` on csModel
3. Overrides `DrawVElements` per-instance to check `_rtScopeSuppressVElem`
4. All hooks use local upvalue capture + idempotent guards (no stack overflow)

### Debug Console Commands
- `cuh_rt_scope_debug 1` — print RT state every 60 frames
- `cuh_rt_scope_dump` — full RT scope state dump
- `cuh_ironsight_dump` — ironsight position dump
- `cuh_adjust_acog <dx> <dy> <dz>` — real-time ACOG position adjustment
- `cuh_adjust_acog reset` — reset to default
- `cuh_adjust_acog save` — print the SWEP.IronSightsPos_ACOG line to copy

## Brainstorm: Reticle Compositing Options

### Option A: Static reticle as ScopeTexture basetexture (simplest)
Set the `scope_c` texture as the `ScopeTexture` basetexture directly when NOT zooming. When zooming, switch to the RT. The lens always shows something (reticle when idle, RT scene when zoomed). Downside: no reticle visible when zoomed.

### Option B: Two-layer approach (separate reticle VElement)
Add a second VElement on top of the scope model — a flat plane with the reticle texture. This plane always renders the reticle, and the scope lens below it shows the RT. Downside: requires a model or ClientsideModel for the reticle plane.

### Option C: matproxy.Add (Lua material proxy)
Register a Lua material proxy via `matproxy.Add` that composites the reticle onto the RT, similar to what the TFA C++ proxy does. Most faithful but complex. See `/home/z/my-project/skills/glua/references/libraries/matproxy.md` for the API.

### Option D: Stencil-based reticle
Use stencils to draw the reticle only inside the scope lens circle. The RT shows the 3D scene; a stencil pass draws the reticle on top. Complex but precise.

### Option E: Two sub-materials on the scope model
The scope model has multiple material indices. Use one for the RT (lens glass) and another for the reticle overlay. The reticle material uses `$additive` or `$translucent` to render on top of the RT. No RT compositing needed — the model itself has both materials.

### Option F (user's suggestion): Use the same texture the Scout uses
The Scout uses `Material("models/weapons/v_models/sniper_scout/lens")` — a VMT with the reticle baked into the basetexture. For WWII scopes, we could create a custom VMT that combines the RT basetexture with a reticle overlay, but this requires a custom VMT with a proxy or a composite texture.

## How to Pick Up After Restart
1. The glua skill will be available via `Skill(command="glua")` after restart
2. Read this doc: `/home/z/my-project/download/RT_SCOPE_STATUS.md`
3. The RT scene rendering works — only the reticle compositing is broken
4. The TFA source is at `/home/z/my-project/source_repos/tfa_codww2_source/`
5. All code is committed to GitHub (repo: UnderhellCBase)
6. The user's clean base files are at `/home/z/my-project/upload/` — DO NOT MODIFY these
7. All fixes must be per-weapon or in the autorun file (`cuh_rt_scope_render.lua`)
