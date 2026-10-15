# MCV Crosshair & HUD Audit — For Underhell Base Revamp

## Source
- **MCV repo:** `/home/z/my-project/source_repos/mcv_sweps/`
- **Main HUD file:** `lua/mcv/weapon_common/cl_hud.lua` (726 lines)
- **Dev HUD:** `lua/mcv/client/cl_devhud.lua`
- **Scope overlay:** `lua/mcv/client/cl_scopeoverlay.lua`
- **Underhell base (current):** `/home/z/my-project/upload/weapon_uh_base_gun.lua` lines 1287-1440

---

## How the MCV Crosshair Works

### Overview
The MCV crosshair is a **dynamic, spread-following crosshair** with:
1. A center dot
2. Four expanding/contracting lines (or a circle for shotguns)
3. Smooth interpolation (opens fast, closes smooth)
4. Walk bob (figure-of-eight sway)
5. View-punch following (stays on the actual aim point)
6. Reload fade (fades out during reload, fades back in after)
7. ADS fade (disables when aiming down sights)

### Key Functions

#### `SWEP:GetHUDBlend()` (lines 77-115)
Returns 0..1 — how far the HUD is "in". Combines:
- **Deploy slide-in** (ease-out-cubic over `HUD.InTime` = 0.35s)
- **Holster slide-out** (ease-out-cubic over `HUD.OutTimeDefault` = 0.3s)

Tracks `HUDLastFrame` to detect weapon switches. On first frame of a new weapon, sets `HUDDeployTime = now` and `HUDHintsStart = now`.

#### `SWEP:DoDrawCrosshair(x, y)` (lines 413-527)
This is the main crosshair function. GMod calls `DoDrawCrosshair` automatically. Returns `true` to suppress the default crosshair.

**Step 1: Calculate visibility alpha**
```lua
local blend = self:GetHUDBlend()
local reloading = self:GetReloading()
-- Track reload state transitions for fade-out/fade-in
local reloadTarget = (reloading or ...) and 0 or 1
self.CrosshairReloadAlpha = math.Approach(self.CrosshairReloadAlpha or 1,
    reloadTarget, FrameTime() * 8)
local a = (1 - self:GetSightAmountVisual()) * 100 * blend * self.CrosshairReloadAlpha
if a <= 0 then return true end
```
- `blend` = HUD slide-in/out (0 when holstered)
- `GetSightAmountVisual()` = ADS progress (0 = hip, 1 = fully aimed) — fades crosshair out as you ADS
- `CrosshairReloadAlpha` = smoothly fades to 0 during reload, back to 1 after

**Step 2: Follow view punch (not hip sway)**
```lua
if self.GetAimSway and MCV.RealisticShooting() then
    local aim = owner:EyeAngles() + owner:GetViewPunchAngles() * 2
    local scr = (owner:EyePos() + aim:Forward() * 4096):ToScreen()
    if scr.visible and scr.x == scr.x then
        x, y = scr.x, scr.y
    end
end
```
The crosshair follows where the gun is actually pointing (view punch × 2, same as the shot does). The hip sway's peak widens the gap instead of moving the crosshair, so the shot always lands inside.

**Step 3: Calculate gap from spread + kick + sway**
```lua
local spread = self:GetCrosshairSpread()  -- GetSpread() * 100
local kick = self:GetCrosshairKick()      -- decays over CrosshairKickTime (0.15s)
local sway = self:GetAimSwayAmplitude(true) * 1.2  -- widens gap
local target = scale * (spread + sway + math.max(self.Spread, 0.5) * HUD.CrosshairKick * kick)
```
- `spread` = current weapon spread (stance, movement, air, aim)
- `kick` = extra gap right after a shot (quadratic decay)
- `sway` = hip sway peak (keeps wandering barrel inside crosshair)

**Step 4: Smooth interpolation (opens fast, closes smooth)**
```lua
if target > self.CrossGap then
    self.CrossGap = Lerp(math.min(ft * HUD.CrosshairSmooth * 3, 1), self.CrossGap, target)
else
    self.CrossGap = Lerp(math.min(ft * HUD.CrosshairSmooth, 1), self.CrossGap, target)
end
```
- `HUD.CrosshairSmooth = 12` — closes at 12/sec
- Opens 3× faster (36/sec) — snappy response to shots
- `CrossGap` is persisted on the weapon instance

**Step 5: Walk bob (figure of eight)**
```lua
local speed = self:GetSpeedVisual() / math.max(self.SpeedSprint, 1)
if IsValid(owner) and !owner:IsOnGround() then speed = 0 end
self.CrossBobPhase = (self.CrossBobPhase or 0) + ft * (6 + speed * 6) * math.min(speed * 3, 1)
local bob = HUD.CrosshairBob * ScreenScale(1) * speed
x = x + math.sin(self.CrossBobPhase) * bob
y = y + math.abs(math.cos(self.CrossBobPhase)) * bob * 0.6
```
- Horizontal: `sin(phase)` — sways left/right
- Vertical: `abs(cos(phase))` — bobs up/down (always positive, so it bobs up)
- Speed: 6 + speed*6 cycles/sec, faster when sprinting
- `HUD.CrosshairBob = 2.5` ScreenScale units at full sprint

**Step 6: Draw (dot + lines OR circle)**
```lua
local dot_size = ScreenScale(1)
local line_size = ScreenScale(4)

-- Center dot (always)
drawshadowrect(x - dot_size/2, y - dot_size/2, dot_size, dot_size, col)

-- Circle mode (shotguns or CrosshairCircle flag)
if self.CrosshairCircle or self:GetBulletCount() > 1 then
    surface.DrawCircle(x, y, gap_size, col)
    surface.DrawCircle(x, y, gap_size - 1, col)
    surface.DrawCircle(x, y, gap_size + 1, shadow)
    surface.DrawCircle(x, y, gap_size - 2, shadow)
-- Line mode (regular weapons with spread > 0)
elseif (self.Spread or 0) > 0 then
    drawshadowrect(x - dot/2, y + dot/4 + gap, dot, line, col)  -- bottom
    drawshadowrect(x - dot/2, y - dot/4 - gap - line, dot, line, col)  -- top
    drawshadowrect(x + gap, y - dot/2, line, dot, col)  -- right
    drawshadowrect(x - gap - line, y - dot/2, line, dot, col)  -- left
end
```
- `drawshadowrect` draws a filled rect + a black outline (shadow) for visibility on any background
- Shotguns use a circle instead of 4 lines
- Weapons with `Spread = 0` only show the center dot (precision)

### `drawshadowrect` helper (line 372)
```lua
local function drawshadowrect(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
    surface.SetDrawColor(0, 0, 0, col.a * 100 / 150)  -- shadow at ~67% of main alpha
    surface.DrawOutlinedRect(x - 1, y - 1, w + 2, h + 2)
end
```
Draws the shape + a 1px black outline for contrast.

### Tuning Constants (lines 395-398)
```lua
HUD.CrosshairSmooth = 12    -- gap follows target at 12/sec (closing)
HUD.CrosshairKick = 0.75    -- extra gap = 0.75× base spread on shot
HUD.CrosshairKickTime = 0.15 -- kick decays over 0.15s
HUD.CrosshairBob = 2.5      -- 2.5 ScreenScale units of bob at sprint
```

---

## How the MCV HUD Works

### Color System (lines 10-13)
```lua
HUD.Color = Color(255, 255, 255, 150)        -- main (ammo count, crosshair)
HUD.ColorBright = Color(255, 255, 255, 230)   -- key labels in hints
HUD.ColorDim = Color(255, 255, 255, 140)     -- hint action text
HUD.ColorIcon = Color(255, 255, 255, 70)     -- spawn icon behind ammo
```
All white-based with varying alpha. Clean, modern look.

### Easing (lines 26-29)
```lua
local function ease(p)
    p = math.Clamp(p, 0, 1)
    return 1 - (1 - p) * (1 - p) * (1 - p)  -- ease out cubic
end
```
Used for deploy/holster slide animations.

### Ammo Counter (lines 246-283)
- Firemode label (top right, small font)
- Ammo count (large font, right-aligned)
- Reserve (small font, right of ammo count)
- Weapon icon (mirrored, tilted 45°, behind ammo counter)
- **Rolling numbers**: `RollHUDNumber` animates count changes over 0.25s

### Rolling Numbers (lines 208-243)
The ammo count doesn't snap — it rolls up/down smoothly:
```lua
HUD.CountUpTime = 0.25    -- covers the whole jump in 0.25s
HUD.CountUpMin = 30       -- never slower than 30/sec
```
- Magazine count: snaps DOWN (shot must read instantly), rolls UP (reload)
- Reserve: rolls in both directions

### Control Hints (lines 286-333)
- Fade in on deploy, stay for `HUD.HintDuration` (6s), fade out over `HUD.HintFade` (1s)
- Each line staggers in 0.06s after the one below
- Key labels are bright, actions are dim
- Configurable via `mcv_hud_hints` convar (0=off, 1=every deploy, 2=first deploy, 3=always)

### HUDShouldDraw (lines 534-537)
Suppresses the default GMod ammo HUD:
```lua
local shoulddraw = {
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
}
function SWEP:HUDShouldDraw(element)
    if shoulddraw[element] then return false end
end
```

---

## Comparison: MCV vs Underhell (Current)

| Feature | MCV | Underhell (current) |
|---------|-----|---------------------|
| **Crosshair type** | Dynamic dot + 4 lines/circle | Static 4 lines |
| **Spread following** | ✅ Gap follows live spread | ❌ Fixed movement-based gap |
| **Shot kick** | ✅ Gap kicks open on shot, decays | ❌ No kick |
| **Walk bob** | ✅ Figure-of-eight, speed-scaled | ❌ None |
| **View punch following** | ✅ Follows actual aim point | ❌ Stays at screen center |
| **Reload fade** | ✅ Smooth fade out/in | ✅ Binary (h_crosshair) |
| **ADS fade** | ✅ Smooth (GetSightAmountVisual) | ✅ Binary (Zooming bool) |
| **Deploy/holster animation** | ✅ Slide-in/out with easing | ❌ None |
| **Shadow/outline** | ✅ Black outline for contrast | ✅ Black + white layers |
| **Shotgun circle** | ✅ Circle for multi-pellet | ❌ Same as rifles |
| **Ammo counter** | Rolling numbers, icon behind | Static text, no icon |
| **Control hints** | Fade after deploy, staggered | None |

---

## Key MCV Patterns Worth Stealing

### 1. `DoDrawCrosshair` instead of `DrawHUD`
MCV uses `DoDrawCrosshair(x, y)` — GMod calls this automatically with the crosshair position. Returning `true` suppresses the default crosshair. This is cleaner than drawing in `DrawHUD`.

### 2. Spread-following gap
The gap is calculated from `GetSpread() * 100` + kick + sway. This makes the crosshair actually represent where bullets will land.

### 3. Asymmetric interpolation
Opens 3× faster than it closes — snappy on shots, smooth on recovery.

### 4. View-punch following
The crosshair moves to where the gun actually points (view punch × 2), so it stays accurate after recoil.

### 5. `drawshadowrect` helper
Simple but effective: draws shape + 1px black outline at 67% alpha for visibility on any background.

### 6. Rolling numbers
Ammo count animates smoothly instead of snapping — feels premium.

### 7. Deploy/holster slide
HUD elements slide in/out with ease-out-cubic — smooth transitions on weapon switch.

---

## What We Need from the Underhell Base

To port the MCV crosshair to Underhell, we need these methods/values from the weapon:
- `self:GetSpread()` or `self.Spread` — current weapon spread
- `self:GetLastRecoilTime()` — for kick calculation (or we track it in PostShoot)
- `self:GetSightAmountVisual()` — ADS progress (0..1) — Underhell has `c_iron` we can expose
- `self:GetReloading()` — reload state — Underhell has `GetUHBool("Reloading")`
- `self:GetSpeedVisual()` / `self.SpeedSprint` — for walk bob — can use player velocity
- `self:GetBulletCount()` — for shotgun circle — Underhell has `self.Primary.NumberofShots`
- `self:GetHolsterTime()` — for holster animation — Underhell has holster logic

The MCV crosshair is self-contained in `DoDrawCrosshair` — it can be dropped into the Underhell base with minimal changes (just mapping the method names).

---

## Next Steps
Awaiting user instructions on what to do with this audit — whether to:
- Port the MCV crosshair into `weapon_uh_base_gun.lua`
- Create a separate crosshair module
- Cherry-pick specific features (spread-following, kick, walk bob, etc.)
