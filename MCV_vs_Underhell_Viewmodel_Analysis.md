# MCV vs Underhell Base — Viewmodel "Feel" Deep Comparison

**Question being answered:** Why does the MCV base feel "snappier and more rigid" than the Underhell base, even after the easing/zoom changes were applied — and why does Underhell still feel "mushy and flimsy"?

**TL;DR (top-level diagnosis):**

The previous Underhell "ease-in" patch was applied in the **wrong direction**. `weapon_custom_uh_base.lua:243` adds a multiplier of `(1 + (1 - remaining) * easeIn)` which is **largest when `remaining` is small** (i.e. near the end of the transition). That is literally the textbook definition of an **ease-IN** curve — slow start, accelerating finish — which is the exact shape the human brain reads as "mushy". To make something feel snappy you want **ease-OUT** (fast start, decelerating finish) or constant-rate linear, never ease-in.

On top of that, MCV runs **one** smoothing system per channel with a constant `engine.TickInterval()` rate (the easing is layered on top as a pure visual presentation); Underhell runs **five** chained systems (Inspect → Grenade → Sway → Movement → Sights), each with its own `Lerp(ft*N, …)` state, each adding positional and angular drag, and the Sway layer is a **mouse-look lag system** (the viewmodel chases the camera with `LerpAngle(ft*10, …)`), which MCV doesn't have at all in its default mode.

---

## 1. Ironsight / ADS transition

### MCV — `lua/weapons/mcv_base/sh_sights.lua`

**Lines 1–4 (transition time, constant rate):**
```lua
// How long a full hip <-> sight transition takes, in seconds.
function SWEP:GetSightTime()
    return 0.2 / self.IronsightSpeedScale  -- IronsightSpeedScale = 0.85 → 0.235 s
end
```

**Lines 8 & 10–21 (the easing function, applied only to the VISUAL copy):**
```lua
SWEP.SightEase = "InOutSine"

local function smoothstep(p)
    return p * p * (3 - 2 * p)
end

function SWEP:GetSightEase()
    local ease = self.SightEase
    if isfunction(ease) then return ease end
    if isstring(ease) and math.ease and math.ease[ease] then return math.ease[ease] end
    return smoothstep
end
```

**Lines 120–125 (the raw gameplay blend — linear, constant rate, tick-integrated):**
```lua
local target = sighted and 1 or 0
local cur = self:GetSightAmountRaw()

if cur != target then
    self:SetSightAmountRaw(math.Approach(cur, target, engine.TickInterval() / self:GetSightTime()))
end
```

**Lines 36–38 vs 75–77 (gameplay vs visual read-out):**
```lua
// gameplay — reads the raw tick-integrated value, eased
function SWEP:GetSightAmount()
    return applyEase(self, self:GetSightAmountRaw())
end
...
// visual — eased copy of the visual catch-up value
function SWEP:GetSightAmountVisual()
    return applyEase(self, self:GetSightAmountRawVisual())
end
```

**Lines 48–72 (the visual catch-up, which absorbs prediction corrections):**
```lua
function SWEP:GetSightAmountRawVisual()
    ...
    local rate = math.max(1 / self:GetSightTime(), math.abs(raw - cur) / self.VisualSightCatchUp)
    cur = math.Approach(cur, raw, rate * FrameTime())
    ...
end
```

### Underhell — `lua/weapons/weapon_custom_uh_base.lua`

**Lines 88–92 (configurable speeds):**
```lua
SWEP.IronsightSpeed  = 10
SWEP.IronsightEaseIn = 1.5
SWEP.ZoomSpeedIn     = 15
SWEP.ZoomSpeedOut    = 10
```

**Lines 235–255 (the Sights() function — single state, ease-IN):**
```lua
function SWEP:Sights(pos, ang, ft, iftp)
    if not IsValid(self.Owner) then return pos, ang end
    if iftp then
        local target = self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0
        local current = self._ironBlend or 0
        local remaining = math.abs(target - current)
        local baseSpeed = self.IronsightSpeed or 10
        local easeIn = self.IronsightEaseIn or 1.5
        local speed = math.min(ft * baseSpeed * (1 + (1 - remaining) * easeIn), 1)
        self._ironBlend = Lerp(speed, current, target)
    end
    ...
end
```

**Lines 809–823 in CalcView (the FOV zoom uses the same shape):**
```lua
local zoomSpeed    = isZooming and ft*zoomSpeedIn or ft*zoomSpeedOut
local zoomTarget   = isZooming and zoomFov or 0
local zoomCurrent  = self._zoomBlend or 0
local zoomRemaining = math.abs(zoomTarget - zoomCurrent) / math.max(zoomFov, 1)
local zoomEaseSpeed = math.min(zoomSpeed * (1 + (1 - zoomRemaining) * 1.5), 1)
self._zoomBlend = Lerp(zoomEaseSpeed, zoomCurrent, zoomTarget)
```

### Concrete difference

Plug in numbers at 60 fps (`ft ≈ 0.0166`), Underhell's `speed` factor at three points in the transition:

| `remaining` (distance to target) | `1 + (1-remaining)*1.5` | effective `speed = ft*10*…` |
|---|---|---|
| 1.00 (just pressed RMB) | 1.00 | **0.166** ← slow start |
| 0.50 (halfway)            | 1.75 | 0.291 |
| 0.10 (almost there)       | 2.35 | **0.391** ← fast finish |

That is the canonical shape of an ease-IN curve. The gun takes ~6 frames (`0.166 + 0.166·0.834 + …` → 1−0.834⁶ ≈ 0.66) to even reach the halfway mark, then snaps the rest of the way. Players read "I pressed RMB and the gun didn't move" as the dominant feel.

MCV inverts the architecture: the underlying state moves at a **constant linear rate** (`math.Approach(cur, target, TickInterval / SightTime)`), and the easing (`InOutSine`, which is symmetric — slow at both ends, fast in the middle) is applied **only to the visual read-out**, never to the gameplay state. The middle of the transition is the fast part, which is what reads as "snappy": the gun starts moving immediately, accelerates through the middle, decelerates only at the very end to settle.

**Why MCV feels snappier, one sentence:** MCV moves the underlying sight value at a constant linear rate (so the gun starts moving on the very first tick after RMB) and only eases the *visual presentation* with a symmetric `InOutSine`, whereas Underhell eases the actual state value with a curve that is slowest at the moment of input (ease-in) and fastest at the end — so the player presses aim and the gun visibly hesitates.

---

## 2. Viewmodel sway / weapon sway

### MCV

MCV **disables engine sway** almost entirely and does **not** implement a per-frame mouse-look lag system at all in its default (non-realistic) mode.

**`shared.lua:185-186` (engine sway/bob scale):**
```lua
SWEP.BobScale  = 0
SWEP.SwayScale = 0.1
```

**`sh_shoot.lua:280-340` (the only custom sway code — and it's gated behind `MCV.RealisticShooting()`):**
```lua
SWEP.HipSwayScale = 0.25

function SWEP:GetAimSwayAmplitude(visual)
    if !MCV.RealisticShooting() then return 0 end      -- ← ZERO sway in default mode

    local steady = visual and self:GetSwaySteadyVisual() or self:GetSwaySteady()
    if steady <= 0 then return 0 end

    local sa = visual and self:GetSightAmountVisual() or self:GetSightAmount()
    local amp = (self.Spread or 0) * self:StatMult("spread") * self.HipSwayScale * (1 - sa)
    if (self.Num or 1) > 1 then amp = amp * 0.5 end
    local stance = visual and self:GetStanceSpreadMultiplierVisual() or self:GetStanceSpreadMultiplier()
    return amp * stance * steady
end

function SWEP:GetAimSway(visual)
    local amp = self:GetAimSwayAmplitude(visual)
    if amp <= 0.0001 then return angle_zero end
    local t = CurTime() + self:EntIndex() * 7.3
    local p = (math.sin(t * 1.1) * 0.6 + math.sin(t * 2.3 + 1.7) * 0.4) * amp
    local y = (math.sin(t * 0.8 + 0.9) * 0.6 + math.sin(t * 1.9 + 3.1) * 0.4) * amp
    return Angle(p, y, 0)
end
```

Note the amplitude: `Spread * 0.25 * (1 - sa) * stance` — for a typical rifle with `Spread = 6.3`, max hip amplitude is `6.3 * 0.25 * 1 = 1.575` degrees in realistic mode, **zero** in default mode. And the sway is a **time-driven sine**, not a mouse-look-driven lag — the gun slowly breathes around its aim point rather than chasing the cursor.

### Underhell — `weapon_custom_uh_base.lua:260-286`

```lua
SWEP.SwayPosition = 2

function SWEP:Sway(pos, ang, ft, iftp)
    ...
    local sway = (cv_sway and cv_sway:GetFloat()) or 1.2     -- amplitude 1.2
    ...
    local eyeAng = self.Owner:EyeAngles()
    local angdelta = eyeAng - (self._oldEyeAng or eyeAng)
    ...
    angdelta.p = math.Clamp(angdelta.p, -5, 5)
    angdelta.y = math.Clamp(angdelta.y, -5, 5)
    angdelta.r = math.Clamp(angdelta.r, -5, 5)
    if self:GetUHBool("Zooming") then angdelta = angdelta * 0.05 end

    if iftp then
        self._swayAng = LerpAngle(math.Clamp(ft*10,0,1), self._swayAng or Angle(0,0,0), angdelta)
    end
    self._oldEyeAng = eyeAng

    local psway = sway / (self.SwayPosition or 2)            -- 1.2 / 2 = 0.6
    local sa = self._swayAng or Angle(0,0,0)
    ang:RotateAroundAxis(ang:Right(),   -sa.p*sway)          -- ×1.2
    ang:RotateAroundAxis(ang:Up(),        sa.y*sway)          -- ×1.2
    ang:RotateAroundAxis(ang:Forward(),  sa.y*sway)          -- ×1.2
    pos = pos + ang:Right()*sa.y*psway + ang:Up()*sa.p*psway  -- ×0.6
    return pos, ang
end
```

### Concrete difference

- **MCV default mode:** amplitude `0` (literally no sway); the viewmodel tracks the camera 1:1 plus the engine's residual `SwayScale = 0.1` (10%).
- **Underhell:** amplitude `1.2` (angular) and `0.6` (positional) with a `LerpAngle(ft*10, …)` chase — i.e. the viewmodel **lags the camera** with an exponential approach whose half-life is ~6 frames (~100 ms). The gun visibly trails the cursor on every mouse-look.

The exponential lag is the textbook recipe for "flimsy": the player flicks the mouse and the gun drags behind, then overshoots, then settles. MCV simply doesn't do this — the gun rotates with the camera.

**Why MCV feels snappier, one sentence:** MCV doesn't implement mouse-look viewmodel lag at all in its default mode (SwayScale 0.1, custom AimSway returns 0 unless `MCV.RealisticShooting()` is on), so the gun tracks the camera 1:1, while Underhell lerps the viewmodel angle toward the per-frame mouse delta with a `ft*10 ≈ 0.166` factor — that 100 ms exponential chase is what reads as "the gun is dragging behind my cursor."

---

## 3. Viewmodel bob (walking/running)

### MCV

MCV does **not bob the viewmodel position/angle from Lua at all**. Engine `BobScale = 0` (`shared.lua:185`). What it does instead is drive the model's own `player_movement` **pose parameter** so the *animation itself* plays the walk/run layer — the bones do the work, the viewmodel frame transform doesn't.

**`sh_think.lua` (mcv_base_core) lines 38–82:**
```lua
SWEP.SpeedSprint = 273
SWEP.SpeedRun = 100
SWEP.SpeedWalk = 25
SWEP.SpeedSprintThreshold = 150
SWEP.SpeedAcceleration = 750 // units per second the blend moves at
SWEP.MovementPoseWalk = 148
SWEP.MovementPoseSprint = 245
SWEP.MovementPoseSighted = 130

function SWEP:GetMovementPose(speed, sa)
    local lo, hi = self.MovementPoseWalk, self.MovementPoseSprint
    local walk = math.min(self.SpeedRun, lo * self.MovementPoseWalkMax)
    local pose
    if speed <= self.SpeedRun then
        pose = speed / self.SpeedRun * walk
    else
        pose = Lerp((speed - self.SpeedRun) / math.max(self.SpeedSprint - self.SpeedRun, 1), walk, hi)
    end
    local sighted = math.min(speed / self.SpeedRun, 1) * self.MovementPoseSighted * self.SightedSwayFraction
    ...
    return Lerp(sa, pose, sighted)
end
```

**`sh_vm.lua` (mcv_base_core) line 32 (where it's applied):**
```lua
vm:SetPoseParameter("player_movement", self:GetMovementPose(speed, sa))
```

The "speed" itself is integrated linearly:

**`sh_think.lua:141-148`:**
```lua
function SWEP:Think_Speed()
    local target = self:GetTargetSpeed()
    local cur = self:GetSpeed()
    if cur == target then return end
    self:SetSpeed(math.Approach(cur, target, engine.TickInterval() * self.SpeedAcceleration))
end
```

`engine.TickInterval() * 750 = 11.7 units/tick` — the blend reaches 273 (full sprint) in ~23 ticks (~0.36 s), and stops instantly on key release (no decay tail).

### Underhell — `weapon_custom_uh_base.lua:291-378`

```lua
function SWEP:Movement(pos, ang, ct, ft, iftp)
    ...
    if iftp then
        if isRunning and onGround then
            self._erpDecay = {}
            self._bobTime = ct * (3.7 + math.Clamp(maxSpeed/150, 0, 3)) * 2
            self._erp = math.cos(self._bobTime) * 2
        elseif moveSpeed > 0 and onGround then
            self._erpDecay = {}
            self._bobTime = ct * (2.75 + math.Clamp(maxWalk/120, 0, 2)) * 2
            self._erp = math.cos(self._bobTime) * 0.5
        elseif not onGround then
            if not self._erpDecay[1] then self._erpDecay = {self._erp, ct + 0.1} end
            self._erp = self._erpDecay[1] * math.Clamp((self._erpDecay[2]-ct)*2, 0, 1)
            self._bobNextThink = ct
        else
            if not self._erpDecay[1] then self._erpDecay = {self._erp, ct + 0.33} end
            self._erp = self._erpDecay[1] * math.Clamp((self._erpDecay[2]-ct)*3, 0, 1)
        end

        self._sightMult = Lerp(ft8, self._sightMult or 0, isZooming and 0.125 or 1)
        local walkRemapped = math.Clamp(moveSpeed/maxWalk, 0, 1)
        self._bobLerp   = Lerp(ft*12, self._bobLerp or 0, (self._erp*walkRemapped*self._sightMult)*1.1)
        self._bobSmooth = Lerp(ft*4,  self._bobSmooth or 0, self._bobLerp)
        self._bobAbs    = Lerp(ft*10, self._bobAbs or 0, math.abs(self._bobLerp))
        self._runDir    = Lerp(ft*14, self._runDir or 0, isRunning and -1 or 1)
        self._jumpBlend = Lerp(ft8,   self._jumpBlend or 0, ... math.Clamp(vel.z/120, -1.5, 1))
        ...
    end

    pos = pos + ang:Up()*(self._jumpBlend or 0)
    ang.p = ang.p + (self._jumpBlend or 0)*2
    ang.r = ang.r + (self._lookBlend or 0)

    pos = pos + ang:Up()*(self._viewBobP or 0)
    pos = pos + ang:Right()*(self._viewBobY or 0)

    if bob ~= 0 and not (self.AnimatedSprint and isRunning) then
        pos = pos + ang:Right()*(self._bobLerp or 0)*(isRunning and 1 or 0.6)*bob
        pos = pos + ang:Up()*(self._bobAbs or 0)*2*(isZooming and -0.45 or 0.65)*(isRunning and 1 or 0.8)*bob
        pos.z = pos.z + (self._velOffset or Vector(0,0,0)).z*bob
        ang:RotateAroundAxis(ang:Up(),      -(self._bobSmooth or 0)*(self._runDir or 0)*10*bob)
        ang:RotateAroundAxis(ang:Right(),   -(self._bobSmooth or 0)*(self._runDir or 0)*1.2*bob)
        ang:RotateAroundAxis(ang:Forward(),  (self._bobSmooth or 0)*3*bob)
    end
    ...
end
```

### Concrete difference

- **MCV:** Viewmodel `pos`/`ang` is never modified by movement in Lua — only the model's `player_movement` pose parameter changes, which drives the model's own walk/run animation layers. There's no position offset, no angle offset, no roll, no jump dip. The weapon stays exactly where the script put it; the bones do the visual work.
- **Underhell:** Adds five separate position offsets (jump dip, viewBobP, viewBobY, bobLerp×Right, bobAbs×Up, velOffset.z) and four angle rotations (jump blend pitch, look blend roll, bob yaw, bob pitch, bob roll). Each of these has its own `_xxx` lerp state with a different `Lerp(ft*N, …)` rate (N ∈ {4, 5, 8, 10, 12, 14}). Worse, the `_erpDecay` block on line 321 keeps the gun still-bobbing for **0.33 seconds after the player stops moving** — a literal "tail" of motion that hangs in the air.

**Why MCV feels snappier, one sentence:** MCV doesn't bob the viewmodel frame transform at all — it drives the walk/run layers through the model's `player_movement` pose parameter, so the gun frame is rigid and only the bones swing — while Underhell stacks five separate position offsets and four angle offsets, each lerped at a different rate (ft·4 to ft·14) with a 0.33 s post-stop decay tail, so the gun is always drifting on at least one of those channels.

---

## 4. Recoil / viewpunch on fire

### MCV — `sh_shoot.lua:425-440`

```lua
self:SetLastRecoilTime(CurTime())

local sa = self:GetSightAmount()
local recoilup = Lerp(sa, self.ViewSlideRecoilUp, self.ViewSlideRecoilIronsightUp) * recoilmult  -- 1.35 deg
local recoilright = Lerp(sa, self.ViewSlideRecoilRight, self.ViewSlideRecoilIronsightRight) * recoilmult  -- 0.48 deg

if MCV.RealisticShooting() then
    owner:ViewPunch((1 - (sa * 0.5)) * Angle(((sa * recoilup) + ((1 - sa) * recoilright)) * (-sa + ...), recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))
else
    owner:ViewPunch(Angle(-recoilup, recoilright * util.SharedRandom("MCVRecoilLeftRight", -1, 1), 0))
end
```

And the post-shot camera shake (high-frequency roll), `cl_camera.lua:3-11`:
```lua
function SWEP:CalcView(ply, pos, ang, fov)
    local rec = (self:GetLastRecoilTime() + self.ShakeDuration) - CurTime()  -- ShakeDuration = 0.4
    rec = math.max(rec, 0) * self.ShakeScale                                 -- 1.0
    if rec > 0 then
        ang.r = ang.r + (math.sin(CurTime() * self.ShakeFreq) * rec)         -- 45 Hz shake
    end
    ...
end
```

Default values (`shared.lua:103-114`):
```lua
SWEP.ViewSlideRecoilUp = 1.35
SWEP.ViewSlideRecoilRight = 0.48
SWEP.ViewSlideRecoilIronsightUp = 1.35
SWEP.ViewSlideRecoilIronsightRight = 0.48
SWEP.ShakeScale = 1
SWEP.ShakeFreq = 45.0
SWEP.ShakeDuration = 0.4
```

### Underhell — `weapon_custom_uh_base_gun.lua:339-351`

```lua
SWEP.Primary.MinRecoil = -0.6
SWEP.Primary.MaxRecoil = -1.4

local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)

if SERVER or (CLIENT and iftp) then
    self:DoMuzzleFlash()
    self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32))
    if not self.NoShell then
        self:CreateShell(self.ShellDelay or 0, self.ShellHeat)
    end
    self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))   -- ← PERMANENT CLIMB
end

self.Owner:ViewPunch(Angle(recoil, 0, 0))
```

### Concrete difference

- **MCV:** Calls only `owner:ViewPunch(...)` once per shot. The engine's `ViewPunch` is a transient kick — it has its own internal decay so the view snaps up and recovers automatically. MCV *never* writes to `SetEyeAngles`. The view snaps by 1.35° up + ~0.48° random sideways, then bounces back to where you were aiming within ~0.4 s (with a 45 Hz roll shake riding on top for tactile feel). On full auto the punch accumulates briefly but the underlying eye angle never moves, so the player's aim point stays put.
- **Underhell:** Calls **both** `Owner:SetEyeAngles(...)` (which **permanently** rotates the eye up by 0.6–1.4° per shot, accumulating across the burst) **and** `Owner:ViewPunch(...)` (a transient kick on top). For a 750-RPM weapon, that's ~12.5 shots/sec × ~1° = ~12.5°/sec of permanent view climb during a burst, requiring the player to constantly drag the mouse back down. There is no recovery; the player is fighting the gun.

**Why MCV feels snappier, one sentence:** MCV applies only a transient `ViewPunch` (which the engine auto-decays back to your original aim in 0.4 s, with a 45 Hz shake for tactile feel), whereas Underhell writes to `SetEyeAngles` on every shot — permanently pushing the eye up by 0.6–1.4° per round, so the view climbs and the player has to manually correct it, which reads as the weapon "wandering" rather than "kicking and returning".

---

## 5. Viewmodel position update — `GetViewModelPosition`

### MCV — `mcv_base_core/sh_vm.lua:165-210`

```lua
function SWEP:GetViewModelPosition(pos, ang)
    if GetPredictionPlayer() != self:GetOwner() then
        local vm = self:GetOwner():GetViewModel()
        self:UpdateViewModelAnimation(vm)
        self:DoBodygroups(vm, true)
        if IsValid(vm) then vm:InvalidateBoneCache() end
    end
    local aim_delta = self:GetSightAmountVisual()
    local aim_punch = self:GetOwner():GetViewPunchAngles()

    local ipos, iang = self.IronsightPos, self.IronsightAng
    ...
    local offsetpos = LerpVector(aim_delta, self.CustomPos, ipos)
    local offsetang = LerpAngle(aim_delta, self.CustomAng, iang)

    if self.GetAimSway then
        local sw = self:GetAimSway(true)
        if sw != angle_zero then
            ang:RotateAroundAxis(ang:Right(), -sw.p)
            ang:RotateAroundAxis(ang:Up(), sw.y)
        end
    end

    pos:Add(ang:Right() * offsetpos.x)
    pos:Add(ang:Forward() * offsetpos.y)
    pos:Add(ang:Up() * offsetpos.z)

    ang:RotateAroundAxis(ang:Right(), offsetang.p)
    ang:RotateAroundAxis(ang:Up(), offsetang.y)
    ang:RotateAroundAxis(ang:Forward(), offsetang.r)

    return pos, ang
end
```

Total offsets applied: ONE LerpVector + ONE LerpAngle (hip→sight), plus the optional `AimSway` (which is zero in default mode, see §2).

### Underhell — `weapon_custom_uh_base.lua:154-173`

```lua
function SWEP:GetViewModelPosition(pos, ang)
    ...
    pos, ang = self:Inspect(pos, ang, ct)         -- 3-stage rotation animation on DeployTime
    pos, ang = self:Grenade(pos, ang, ct, ft, iftp) -- grenade lerp (ft*6)
    pos, ang = self:Sway(pos, ang, ft, iftp)      -- mouse-look lag (ft*10)
    pos, ang = self:Movement(pos, ang, ct, ft, iftp) -- bob+breath+jump+look+vel (ft*4..14)
    if self.IronSightsPos and self.IronSightsAng then
        pos, ang = self:Sights(pos, ang, ft, iftp)  -- iron blend (ft*10..23.5 ease-in)
    end
    return pos, ang
end
```

Each of the five sub-functions mutates `pos` and `ang` and reads/writes its own `self._xxx` lerp state.

### Concrete difference

- **MCV:** One position Lerp + one angle Lerp, both driven by the single eased sight value. There is **no per-frame smoothing on the position itself** — the position is computed directly from `aim_delta` every frame. The smoothing lives entirely in the `aim_delta` value (which itself is a tick-integrated `math.Approach` followed by an `InOutSine` ease).
- **Underhell:** Five chained transforms, each with its own lerp state (`_ironBlend`, `_swayAng`, `_bobLerp`, `_bobSmooth`, `_bobAbs`, `_runDir`, `_jumpBlend`, `_lookBlend`, `_velOffset`, `_breathP/Y/R`, `_grenadeLerp`, `_inspectAng`, `_inspectPos`). Each frame, the viewmodel position is the **sum** of all of these. Each one has its own exponential approach curve. The combined result is a position that is **always settling toward** some moving target — never actually *at* the target.

**Why MCV feels snappier, one sentence:** MCV's `GetViewModelPosition` does exactly one LerpVector + one LerpAngle from the script's hip pose to its sight pose and nothing else, so the gun position is a pure function of `aim_delta` and is wherever that value says it is — whereas Underhell chains five subsystems (Inspect, Grenade, Sway, Movement, Sights), each contributing its own exponentially-lerped offset, so the gun position is always the sum of five different exponential approaches that are each chasing a different moving target.

---

## 6. Idle breathing / micro-movements

### MCV

**There is no idle breathing in MCV's Lua.** The viewmodel frame transform never adds a breathing offset. The only idle motion comes from the model's own `ACT_VM_IDLE` animation (and the rare `ACT_VM_FIDGET`), which is a single canned animation with no programmatic drift.

The closest thing MCV has is the realistic-mode `GetAimSway` (§2), which is a sine wave over time with amplitude `Spread * 0.25 * (1-sa) * stance` — for a typical rifle that's ~1.5° max, only when *not* sighted, only in realistic mode. In default mode it returns `angle_zero`.

### Underhell — `weapon_custom_uh_base.lua:363-376`

```lua
if idle ~= 0 then
    if not isRunning and not isZooming and moveSpeed < 1 then
        self._breathP = Lerp(ft*10, self._breathP or 0, math.sin(ct*0.5)*idle)
        self._breathY = Lerp(ft*10, self._breathY or 0, math.sin(ct*1)*0.5*idle)
        self._breathR = Lerp(ft*10, self._breathR or 0, math.sin(ct*2)*0.25*idle)
    else
        self._breathP = Lerp(ft*10, self._breathP or 0, 0)
        self._breathY = Lerp(ft*10, self._breathY or 0, 0)
        self._breathR = Lerp(ft*10, self._breathR or 0, 0)
    end
    ang.p = ang.p + (self._breathP or 0)*(self._sightMult or 1)
    ang.y = ang.y + (self._breathY or 0)*(self._sightMult or 1)
    ang.r = ang.r + (self._breathR or 0)*(self._sightMult or 1)
end
```

`idle` is a convar (`uh_vmidle`), defaulting to whatever it's set to (non-zero). Three independent sine channels at frequencies 0.5 Hz, 1 Hz, 2 Hz — pitch, yaw, and roll all quietly oscillating while the player stands still.

### Concrete difference

- **MCV:** No idle breathing at all. The gun sits perfectly still.
- **Underhell:** Three independent sine-wave channels (pitch @ 0.5 Hz, yaw @ 1 Hz, roll @ 2 Hz), each smoothed through `Lerp(ft*10, …)` so even the breathing has lag. Amplitude scaled by `idle` convar and by `_sightMult` (which itself is `Lerp(ft*8, …)` so it eases in/out when you zoom).

**Why MCV feels snappier, one sentence:** MCV has no idle breathing code at all — the gun is dead still when you stand — whereas Underhell superimposes three sine-wave channels of breathing on pitch/yaw/roll with their own `ft*10` lerp smoothing, which keeps the gun perpetually drifting by a fraction of a degree even when nothing is happening.

---

## 7. FrameTime usage

### MCV

MCV distinguishes **two clocks**:

1. **`engine.TickInterval()`** — used for the *gameplay* state (`SightAmountRaw`, `Speed`), so the value is identical on client and server and a prediction error costs exactly one tick of travel.
2. **`FrameTime()`** — used **only** for the visual catch-up copies, and **always with a bounded rate**.

`sights.lua:64`:
```lua
local rate = math.max(1 / self:GetSightTime(), math.abs(raw - cur) / self.VisualSightCatchUp)
cur = math.Approach(cur, raw, rate * FrameTime())
```

`sh_think.lua (mcv_base_core):128`:
```lua
local rate = math.max(self.SpeedAcceleration, math.abs(speed - cur) / self.VisualSpeedCatchUp)
cur = math.Approach(cur, speed, rate * FrameTime())
```

The pattern is always: `math.Approach(cur, target, max(normal_rate, gap / catchup_time) * ft)`. The `math.Approach` (constant-rate, additive) is the key — it never gives the "drag-toward-target" feel of `Lerp(k, cur, target)` (which is multiplicative and asymptotic). `Approach` reaches the target in finite time; `Lerp` only approaches it asymptotically.

### Underhell

Underhell uses `Lerp(k, current, target)` everywhere, with `k = ft * factor`:

| File:Line | Lerp factor | Effective k @ 60 fps | Half-life |
|---|---|---|---|
| `base.lua:219` Grenade lerp | `ft*6` | 0.10 | ~6.6 frames (110 ms) |
| `base.lua:243` Sights (max) | `ft*23.5` | 0.39 | ~1.4 frames (24 ms) |
| `base.lua:243` Sights (start) | `ft*10` | 0.166 | ~3.8 frames (64 ms) |
| `base.lua:275` Sway | `ft*10` | 0.166 | ~3.8 frames (64 ms) |
| `base.lua:305` Movement ft8 | `ft*8` | 0.133 | ~4.8 frames (80 ms) |
| `base.lua:327` bobLerp | `ft*12` | 0.20 | ~3.1 frames (52 ms) |
| `base.lua:328` bobSmooth | `ft*4` | 0.066 | ~10 frames (170 ms) |
| `base.lua:329` bobAbs | `ft*10` | 0.166 | ~3.8 frames (64 ms) |
| `base.lua:330` runDir | `ft*14` | 0.23 | ~2.7 frames (45 ms) |
| `base.lua:331` jumpBlend | `ft*8` | 0.133 | ~4.8 frames (80 ms) |
| `base.lua:338-342` lookBlend | `ft*5` | 0.083 | ~8 frames (133 ms) |
| `base.lua:344` velOffset | `ft*4` | 0.066 | ~10 frames (170 ms) |
| `base.lua:365-367` breath | `ft*10` | 0.166 | ~3.8 frames (64 ms) |
| `base.lua:531` grenLerp | `ft*5` | 0.083 | ~8 frames (133 ms) |
| `base.lua:788` viewBob decay | `ft*10` | 0.166 | ~3.8 frames (64 ms) |
| `base.lua:818` zoom ease | `ft*15*…` | 0.25-0.625 | ~1-2 frames |
| `gun.lua:1010` crosshair blend | `ft*5` | 0.083 | ~8 frames |

**Concrete difference:** MCV uses `math.Approach(cur, target, step)` (additive, finite-time) for both the gameplay blend and the visual catch-up. Underhell uses `Lerp(k, cur, target)` (multiplicative, asymptotic) for everything. The mathematical difference:

- `Approach(cur, 1, 0.1)` reaches 1 in finite steps (10 frames), then stops.
- `Lerp(0.166, cur, 1)` reaches 0.5 after 4 frames, 0.95 after ~17 frames, 0.99 after ~26 frames — it never actually arrives.

The asymptotic approach is the textbook definition of "mushy": the value is always *almost there* but never *there*.

**Why MCV feels snappier, one sentence:** MCV integrates its gameplay state with `math.Approach` (constant-rate, reaches the target in finite time, then stops) and only eases the *visual presentation* on top — whereas Underhell uses `Lerp(k, cur, target)` (exponential, asymptotic, never actually arrives) for every smoothing system, which mathematically guarantees the gun is always 1–2% shy of where it should be, forever.

---

## 8. State transitions (sprint in/out, deploy, holster)

### MCV

**Deploy** (`mcv_base_core/sh_deploy.lua:23-57`):
```lua
function SWEP:Deploy()
    ...
    self:SetHolsterCommand(0)
    self:SetHolsterTime(0)
    ...
    self:GetOwner():SetSaveValue("m_flNextAttack", SERVER and 0 or CurTime())  -- ready NOW
    ...
    if self:ViewModelHidden() then
        self:SetReady(true)
    elseif !self:GetReady() and !self:GetGrenadeLauncher() and self:HasAnimation(ACT_VM_READY) then
        self:PlayAnimation(ACT_VM_READY, 1, true)
        self:SetReady(true)
    else
        self:DeployAnimation()  -- ACT_VM_DRAW at speed 1
        self:SetReady(true)
    end
    ...
end
```

`m_flNextAttack` is set to 0 (server) or `CurTime()` (client) — the weapon is **immediately** usable. No `SetNextPrimaryFire` lockout is added.

**Holster** (`mcv_base_core/sh_deploy.lua:74-119`):
```lua
function SWEP:Holster(wep)
    ...
    if forced or (self:GetHolsterTime() != 0 and self:GetHolsterTime() <= CurTime()) or !IsValid(wep) then
        -- final holster, done immediately
        ...
        return true
    else
        ...
        local t = self:PlayAnimation(ACT_VM_HOLSTER, 1, true, true)  -- model's own holster duration
        self:SetHolsterTime(CurTime() + (t or 0))
        ...
    end
end
```

The holster animation runs at the model's own duration (typically 0.4–0.6 s), no extension.

**Sprint in/out** (`mcv_base_core/sh_think.lua:141-148` and `mcv_base/sh_gun.lua:122-126`):
```lua
function SWEP:Think_Speed()
    local target = self:GetTargetSpeed()
    local cur = self:GetSpeed()
    if cur == target then return end
    self:SetSpeed(math.Approach(cur, target, engine.TickInterval() * self.SpeedAcceleration))  -- 750 units/sec²
end
```

`SpeedAcceleration = 750` — sprint reach in ~0.36 s, **stops on key release with no decay tail** (the target becomes 0 and `Approach` decelerates at the same 750 units/sec², no separate "ease out").

### Underhell

**Deploy** (`weapon_custom_uh_base.lua:592-647`):
```lua
function SWEP:Deploy()
    ...
    self.NextReload = CurTime() + 0.5                                       -- reload locked for 0.5 s
    self:SetNextPrimaryFire(CurTime() + 1)                                  -- fire locked for 1.0 s
    self:SetNextSecondaryFire(CurTime() + 1)                                -- aim locked for 1.0 s
    ...
    if not self:GetNWBool("FirstTimeDeployed") and GetConVar("uh_sv_deploy"):GetBool() then
        self:SetNWBool("FirstTimeDeployed", true)
        if self.AnimatedFirstDraw then
            ...
            local animDuration = IsValid(vm) and vm:SequenceDuration() or 3
            animDuration = math.max(3, animDuration)                        -- ≥3 s first-draw animation
            self:SetNextPrimaryFire(CurTime() + animDuration)               -- fire locked for ≥3 s
            self:SetNextSecondaryFire(CurTime() + animDuration)
            self.NextReload = CurTime() + animDuration
            ...
        else
            self:EasySendWeaponAnim("draw", ACT_VM_DRAW)
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            local animtime = math.max(3, IsValid(vm) and vm:SequenceDuration() or 3)  -- ≥3 s
            self:SetNWFloat("DeployTime", CurTime() + animtime)            -- DeployTime gates zoom & reload for ≥3 s
            ...
        end
    else
        self:EasySendWeaponAnim("draw", ACT_VM_DRAW)
    end
    return true
end
```

The `DeployTime` NW float is checked in `Think` (`gun.lua:895`) to prevent zooming, and in `PreDrawViewModel` (`base.lua:863`) to drive the blur effect — so for ≥3 seconds after switching, you cannot aim down sights **and** the screen blur is at full intensity.

**Holster** (`base.lua:652-696`): Holster returns `true` immediately, but `Deploy` on the next weapon still applies the 1–3 second lockout.

**Sprint in/out** (`base.lua:458-523`): sprint state is toggled by animation send (`SendWeaponAnim(ACT_VM_IDLE_TO_LOWERED)` etc.) — the transition speed is gated by the model's animation duration, not by a programmatic blend. The fire-blocking on sprint exit (`base.lua:505-508`):
```lua
if self:GetNextPrimaryFire() < ct + 0.5 then
    self:SetNextPrimaryFire(ct + 0.5)
    self:SetNextSecondaryFire(ct + 0.5)
end
```
That's a **hard 0.5-second fire lockout** when coming out of sprint, on top of any other delay. MCV has no such lockout.

### Concrete difference

| Transition | MCV lockout | Underhell lockout |
|---|---|---|
| Deploy (subsequent) | none (model anim only) | 1.0 s fire, 1.0 s aim, 0.5 s reload |
| First deploy (animated) | none | ≥3.0 s fire, ≥3.0 s aim, ≥3.0 s reload, ≥3 s blur |
| Sprint → fire | none | 0.5 s fire, 0.5 s aim |
| Holster | model anim duration | immediate |
| Reload → fire | `GetNextPrimaryFire` only | `NextReload + 0.5` and `GetNextPrimaryFire` |

**Why MCV feels snappier, one sentence:** MCV sets `m_flNextAttack` to 0 on deploy and applies no extra sprint-out or post-deploy fire lockouts (only the model's own animation duration gates the visual), whereas Underhell adds a 1-second fire/aim lockout on every deploy, a 0.5-second lockout on sprint exit, and a 3-second lockout on first deploy — so the player constantly hits "I want to shoot now" and is told "not yet".

---

## Summary of the eight differences, ranked by impact on "mushy/flimsy" perception

| # | Aspect | MCV approach | Underhell approach | Impact on "mushy" feel |
|---|---|---|---|---|
| 5 | `GetViewModelPosition` | 1 LerpVector + 1 LerpAngle | 5 chained subsystems, each with own lerp state | **Critical** — compounding smoothing is the root cause |
| 2 | Mouse-look sway | None in default mode (SwayScale 0.1) | `LerpAngle(ft*10, …)` chasing per-frame eye-delta, amplitude 1.2 | **Critical** — weapon visibly lags cursor |
| 7 | Lerp primitive | `math.Approach` (finite-time, additive) | `Lerp(k, cur, target)` (asymptotic, never arrives) | **Critical** — values are always 1–2% shy |
| 1 | Ironsight easing | Linear raw + `InOutSine` visual (symmetric) | Ease-IN (slow start, fast finish) on the actual state | **High** — wrong direction of easing |
| 4 | Recoil | `ViewPunch` only (engine auto-decays) | `SetEyeAngles` + `ViewPunch` (permanent climb) | **High** — gun "wanders up", player must correct |
| 8 | Deploy/sprint lockouts | None | 1 s deploy, 0.5 s sprint-out, ≥3 s first-deploy | **High** — "I want to shoot, not yet" |
| 3 | Viewmodel bob | None (drives `player_movement` pose param only) | 5 pos offsets + 4 angle rotations, ft·4..14 rates | **Medium** — gun drifts while walking |
| 6 | Idle breathing | None | 3 sine channels, ft·10 lerp | **Low–Medium** — gun never sits still |

## Concrete next actions to make Underhell feel snappier (priority order)

These are surgical changes that target the root causes above, in priority order. All are localised edits to `weapon_custom_uh_base.lua` and `weapon_custom_uh_base_gun.lua` — no model or animation changes needed.

### Action 1 — Invert the ironsight easing (file: `weapon_custom_uh_base.lua`, lines 235–245)

**Problem:** `1 + (1 - remaining) * easeIn` is largest at the *end* of the transition — ease-IN, slow start.

**Fix:** Replace with ease-OUT (large at the start, small at the end), or remove the easing entirely and use a constant rate via `math.Approach`:

```lua
-- Option A: ease-OUT (fast start, decelerating finish — what "snappy" reads as)
local speed = math.min(ft * baseSpeed * (1 + remaining * easeOut), 1)
-- 'remaining' is 1 at the start, 0 at the end, so the multiplier is 2.5 at start, 1.0 at end

-- Option B: constant-rate (matches MCV's underlying state exactly)
local step = ft / (self.IronsightTime or 0.2)  -- 0.2-second total transition
self._ironBlend = math.Approach(current, target, step)
```

Apply the same fix to the FOV zoom in `CalcView` at lines 809–823 (the `1 + (1 - zoomRemaining) * 1.5` factor has the same shape and the same problem).

### Action 2 — Remove or severely dampen the mouse-look sway (file: `weapon_custom_uh_base.lua`, lines 260–286)

**Problem:** `LerpAngle(ft*10, …)` chasing the per-frame `angdelta` makes the viewmodel visibly drag behind the cursor.

**Fix options, in order of snappiness:**

```lua
-- Option A: remove the chase entirely, treat angdelta as instantaneous (matches MCV default)
self._swayAng = angdelta

-- Option B: drastically reduce the lag (one-tick lag instead of ~6-tick lag)
self._swayAng = LerpAngle(math.Clamp(ft*60, 0, 1), self._swayAng or Angle(0,0,0), angdelta)
-- ft*60 ≈ 1.0 at 60fps, so the chase is effectively instantaneous

-- Option C: gate the whole sway system behind a "realistic mode" convar the way MCV does
if not RealisticUHShooting() then return pos, ang end
```

Also reduce `SWEP.SwayPosition` (line 81) from 2 to ~10, and the `sway` convar default from 1.2 to ~0.3, to bring the angular amplitude in line with MCV's `SwayScale = 0.1`.

### Action 3 — Remove the post-stop bob decay tail (file: `weapon_custom_uh_base.lua`, lines 320–323)

**Problem:** When the player stops moving, `_erpDecay` holds the previous bob value for 0.33 seconds and decays it linearly — the gun keeps drifting for a third of a second after the player has stopped.

**Fix:** Either remove the tail entirely (set `_erp = 0` immediately on stop) or shorten it to 0.05 s:

```lua
else
    if not self._erpDecay[1] then self._erpDecay = {self._erp, ct + 0.05} end  -- was ct + 0.33
    self._erp = self._erpDecay[1] * math.Clamp((self._erpDecay[2]-ct)*20, 0, 1)  -- was *3
end
```

### Action 4 — Replace the recoil `SetEyeAngles` with `ViewPunch` only (file: `weapon_custom_uh_base_gun.lua`, line 348)

**Problem:** `self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))` permanently rotates the eye up by 0.6–1.4° per shot. On full auto this climbs without bound and the player must manually correct it.

**Fix:** Delete line 348 entirely. `ViewPunch` on line 351 already handles the kick and auto-decays. If you want some retained climb for "feel", apply it as a *small* fraction via `ViewPunch` only:

```lua
-- delete the SetEyeAngles line entirely; the ViewPunch on the next line is sufficient
self.Owner:ViewPunch(Angle(recoil, 0, 0))
```

If you want some "memory" of the climb, scale the punch instead (so it accumulates briefly but decays):

```lua
-- A punch with a longer decay time gives the "climb" feel without permanent eye rotation
self.Owner:ViewPunch(Angle(recoil * 1.5, 0, 0))  -- slightly larger punch, engine decays it
```

### Action 5 — Remove the deploy/sprint lockouts (file: `weapon_custom_uh_base.lua`, lines 611–613 and 505–508)

**Problem:** 1-second fire/aim lockout on every deploy, 0.5-second lockout on sprint exit, ≥3-second lockout on first deploy. The player constantly hits "shoot" and is told "not yet".

**Fix:** Remove the lockouts; let the model's own animation duration (already non-zero) gate the visual:

```lua
-- Deploy: remove these three lines (611-613)
-- self.NextReload = CurTime() + 0.5
-- self:SetNextPrimaryFire(CurTime() + 1)
-- self:SetNextSecondaryFire(CurTime() + 1)

-- Sprint exit: remove this block (505-508)
-- if self:GetNextPrimaryFire() < ct + 0.5 then
--     self:SetNextPrimaryFire(ct + 0.5)
--     self:SetNextSecondaryFire(ct + 0.5)
-- end

-- First-deploy: remove the math.max(3, animDuration) forced minimum (line 621)
local animDuration = IsValid(vm) and vm:SequenceDuration() or 0.5  -- use actual anim length, not 3 s minimum
```

### Action 6 — Optionally remove idle breathing (file: `weapon_custom_uh_base.lua`, lines 363–376)

**Problem:** Three sine channels of breathing on a stationary viewmodel.

**Fix:** Either gate behind a convar (default off) or reduce amplitude by 10×:

```lua
if idle ~= 0 and not isRunning and not isZooming and moveSpeed < 1 then
    self._breathP = Lerp(ft*10, self._breathP or 0, math.sin(ct*0.5)*idle*0.1)  -- ×0.1
    self._breathY = Lerp(ft*10, self._breathY or 0, math.sin(ct*1)*0.05*idle)   -- ×0.1
    self._breathR = Lerp(ft*10, self._breathR or 0, math.sin(ct*2)*0.025*idle)  -- ×0.1
    ...
end
```

Or simply skip the entire `if idle ~= 0 then` block when the convar is at its default — the gun sits dead still, the way MCV does.

---

## Closing note on the architecture difference

The deepest architectural difference, which the eight points above are symptoms of, is this:

- **MCV** treats the viewmodel position as a **pure function of one value** (`aim_delta`, plus optionally `speed` for the pose parameter). That one value is integrated with `math.Approach` (finite-time, deterministic across realms) and then eased for visual presentation only. The position is wherever that value says it is — no chase, no lag, no asymptotic approach.

- **Underhell** treats the viewmodel position as the **sum of five independent chase systems**, each with its own exponential `Lerp(k, cur, target)` state and its own target. Each system is always 1–5% shy of its target, so the sum is always drifting. Even if every individual lerp were tuned perfectly, the *composition* of five exponential approaches chasing five different targets is mathematically guaranteed to never settle.

The patch in the file header comment ("* Ease-in ironsight interpolation (snappier feel)") was applied to only one of those five systems (Sights), and was applied in the wrong direction (ease-IN instead of ease-OUT). Even if it had been applied correctly, the other four systems (Sway, Movement's bob/breath/jump/look, Grenade, Inspect) would still be contributing their own asymptotic drag.

The minimal change that will produce the most perceptible improvement is **Action 1 + Action 2 + Action 4** together: invert the ironsight easing, remove the mouse-look sway, and stop permanently rotating the eye on fire. Those three changes alone will move the Underhell base most of the way toward MCV's "snappy and rigid" feel, without requiring any rewrite of the architecture.
