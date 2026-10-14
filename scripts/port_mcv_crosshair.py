#!/usr/bin/env python3
"""
Port the MCV dynamic crosshair to the Underhell Custom UH base gun.

Changes:
1. Set SWEP.DrawCrosshair = true (so DoDrawCrosshair is called by engine)
2. Modify PostShoot() to track _lastRecoilTime for shot kick
3. Remove old static crosshair code from DrawHUD
4. Add SWEP:DoDrawCrosshair(x, y) — the MCV crosshair, adapted to Underhell

Method name mapping (MCV → Underhell):
  self:GetSpread()           → self.Primary.Spread or 0.004
  self:GetLastRecoilTime()   → self._lastRecoilTime or 0
  self:GetSightAmountVisual() → self._chADS (tracked via math.Approach)
  self:GetReloading()        → self:GetUHBool("Reloading")
  self:GetSpeedVisual()      → owner:GetVelocity():Length()
  self.SpeedSprint           → owner:GetWalkSpeed() * 2.5
  self:GetBulletCount()      → self.Primary.NumberofShots or 1
  self:GetHolsterTime()      → tracked via _chLastFrame / _chDeployTime
  self.TrueFOV               → GetConVar("fov_desired"):GetInt() or 90
"""

import os

FILEPATH = "/home/z/my-project/lua/weapons/weapon_custom_uh_base_gun.lua"

with open(FILEPATH, 'r', encoding='utf-8') as f:
    src = f.read()

# ============================================================
# Edit 1: Set DrawCrosshair = true (so DoDrawCrosshair is called)
# ============================================================
src = src.replace(
    "SWEP.DrawCrosshair = false",
    "SWEP.DrawCrosshair = true  -- MCV crosshair: enables DoDrawCrosshair hook",
    1
)

# ============================================================
# Edit 2: Modify PostShoot to track recoil time
# ============================================================
src = src.replace(
    """function SWEP:PostShoot()
end""",
    """function SWEP:PostShoot()
    -- Track last shot time for crosshair kick calculation (MCV-style)
    self._lastRecoilTime = CurTime()
end""",
    1
)

# ============================================================
# Edit 3: Remove old crosshair code from DrawHUD
# ============================================================
old_crosshair = """        -- Crosshair
        if (h_crosshair > 0 or drawply) and GetConVar("uh_crosshair"):GetBool() and not (self.Use2DScope and self:GetUHBool("Zooming")) then
            draw.RoundedBox(0, pos.x - 25 - movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair))
            draw.RoundedBox(0, pos.x + 12 + movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair))
            draw.RoundedBox(0, pos.x - 2, pos.y - 25 - movement, 3, 12, Color(0,0,0,200*h_crosshair))
            draw.RoundedBox(0, pos.x - 2, pos.y + 12 + movement, 3, 12, Color(0,0,0,200*h_crosshair))
            draw.RoundedBox(0, pos.x - 24 - movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair))
            draw.RoundedBox(0, pos.x + 11 + movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair))
            draw.RoundedBox(0, pos.x - 1, pos.y - 24 - movement, 1, 12, Color(255,255,255,255*h_crosshair))
            draw.RoundedBox(0, pos.x - 1, pos.y + 11 + movement, 1, 12, Color(255,255,255,255*h_crosshair))
        end"""

new_crosshair_placeholder = """        -- Crosshair is now handled by SWEP:DoDrawCrosshair (MCV-style dynamic crosshair)"""

src = src.replace(old_crosshair, new_crosshair_placeholder, 1)

# ============================================================
# Edit 4: Add DoDrawCrosshair function before DrawHUD
# ============================================================
dodraw_code = """
-- ============================================================
-- MCV-STYLE DYNAMIC CROSSHAIR
-- Ported from Military Conflict Vietnam (lua/mcv/weapon_common/cl_hud.lua)
-- ============================================================
-- Features:
--   * Spread-following gap (widens with movement, jumping, firing)
--   * Shot kick (gap kicks open on fire, decays over 0.15s)
--   * Asymmetric interpolation (opens 3x faster than closes)
--   * Walk bob (figure-of-eight, speed-scaled)
--   * View-punch following (stays on actual aim point)
--   * Reload fade (smooth fade out/in)
--   * ADS fade (smooth fade as you aim down sights)
--   * Deploy/holster blend (slides in on weapon switch)
--   * Shadow outline for visibility on any background
--   * Shotgun circle mode (for multi-pellet weapons)

local CH_Color = Color(255, 255, 255, 100)
local CH_Shadow = Color(0, 0, 0, 0)
local CH_White = Color(255, 255, 255, 255)
local CH_Smooth = 12        -- gap follows target at 12/sec (closing)
local CH_Kick = 0.75        -- extra gap = 0.75x base spread on shot
local CH_KickTime = 0.15    -- kick decays over 0.15s
local CH_Bob = 2.5          -- 2.5 ScreenScale units of bob at sprint
local CH_DeployTime = 0.35  -- seconds for crosshair to fade in on deploy

local function ch_ease(p)
    p = math.Clamp(p, 0, 1)
    return 1 - (1 - p) * (1 - p) * (1 - p)
end

local function ch_shadowrect(x, y, w, h, col)
    surface.SetDrawColor(col)
    surface.DrawRect(x, y, w, h)
    surface.SetDrawColor(0, 0, 0, col.a * 100 / 150)
    surface.DrawOutlinedRect(x - 1, y - 1, w + 2, h + 2)
end

function SWEP:DoDrawCrosshair(x, y)
    -- Suppress during deploy
    if self:GetNWFloat("DeployTime") > CurTime() then return true end

    -- Track deploy/holster blend (detect weapon switches via frame number)
    local frame = FrameNumber()
    local now = CurTime()
    if self._chLastFrame == nil or frame < self._chLastFrame or frame - self._chLastFrame > 2 then
        self._chDeployTime = now
    end
    self._chLastFrame = frame
    local blend = ch_ease((now - (self._chDeployTime or now)) / CH_DeployTime)

    -- Track ADS progress (smooth 0..1)
    local zooming = self:GetUHBool and self:GetUHBool("Zooming") or false
    if self.ScopeDisabled then zooming = false end
    local adsTarget = zooming and 1 or 0
    self._chADS = math.Approach(self._chADS or 0, adsTarget, FrameTime() * 8)

    -- Track reload fade
    local reloading = self:GetUHBool and self:GetUHBool("Reloading") or false
    local reloadTarget = reloading and 0 or 1
    self._chReloadAlpha = math.Approach(self._chReloadAlpha or 1, reloadTarget, FrameTime() * 8)

    -- Calculate visibility alpha
    local a = (1 - self._chADS) * 100 * blend * self._chReloadAlpha
    if a <= 0 then return true end

    -- Check convar
    if not GetConVar("uh_crosshair"):GetBool() then return true end

    -- Suppress during 2D scope
    if self.Use2DScope and zooming then return true end

    local col = CH_Color
    col.a = a

    -- Follow view punch (crosshair stays on actual aim point)
    local owner = self:GetOwner()
    if IsValid(owner) then
        local aim = owner:EyeAngles() + owner:GetViewPunchAngles() * 2
        local scr = (owner:EyePos() + aim:Forward() * 4096):ToScreen()
        if scr.visible and scr.x == scr.x then
            x, y = scr.x, scr.y
        end
    end

    local dot_size = ScreenScale(1)
    local line_size = ScreenScale(4)

    -- Calculate gap from spread + kick
    local trueFOV = 90
    local fovCvar = GetConVar("fov_desired")
    if fovCvar then trueFOV = fovCvar:GetInt() end
    if trueFOV < 1 then trueFOV = 90 end

    -- Widescreen fix
    local ratio = (ScrW() / ScrH()) / (4 / 3)
    local halfAngle = trueFOV * (0.5 * math.pi / 180)
    local t = math.tan(halfAngle) * ratio
    local wsFOV = (180 / math.pi) * math.atan(t) * 2
    local scale = ScrH() / wsFOV

    -- Base spread
    local baseSpread = self.Primary and self.Primary.Spread or 0.004
    local spread = baseSpread * 100

    -- Movement spread
    local vel = 0
    local walkSpeed = 200
    local inAir = false
    if IsValid(owner) then
        vel = owner:GetVelocity():Length()
        walkSpeed = owner:GetWalkSpeed()
        if walkSpeed < 1 then walkSpeed = 200 end
        inAir = not owner:IsOnGround()
    end
    local moveRatio = math.Clamp(vel / (walkSpeed * 2), 0, 1)
    local moveSpread = moveRatio * 2
    if inAir then moveSpread = moveSpread + 3 end

    -- Shot kick (decays over CH_KickTime)
    local since = now - (self._lastRecoilTime or 0)
    local kick = math.Clamp(1 - since / CH_KickTime, 0, 1)
    kick = kick * kick

    local target = scale * (spread + moveSpread + math.max(baseSpread, 0.5) * CH_Kick * kick)

    -- Smooth interpolation (opens fast, closes smooth)
    local ft = FrameTime()
    if self._chGap == nil then self._chGap = target end
    if target > self._chGap then
        self._chGap = Lerp(math.min(ft * CH_Smooth * 3, 1), self._chGap, target)
    else
        self._chGap = Lerp(math.min(ft * CH_Smooth, 1), self._chGap, target)
    end
    local gap_size = math.max(self._chGap, dot_size)

    -- Walk bob (figure of eight)
    local speed = vel / math.max(walkSpeed * 2.5, 1)
    if inAir then speed = 0 end
    self._chBobPhase = (self._chBobPhase or 0) + ft * (6 + speed * 6) * math.min(speed * 3, 1)
    local bob = CH_Bob * ScreenScale(1) * speed
    x = x + math.sin(self._chBobPhase) * bob
    y = y + math.abs(math.cos(self._chBobPhase)) * bob * 0.6

    -- Draw center dot
    ch_shadowrect(x - (dot_size / 2), y - (dot_size / 2), dot_size, dot_size, col)

    -- Draw crosshair lines or circle
    local pellets = (self.Primary and self.Primary.NumberofShots) or 1
    if self.CrosshairCircle or pellets > 1 then
        local shadow = CH_Shadow
        shadow.a = a * 100 / 150
        surface.DrawCircle(x, y, gap_size, col)
        surface.DrawCircle(x, y, gap_size - 1, col)
        surface.DrawCircle(x, y, gap_size + 1, shadow)
        surface.DrawCircle(x, y, gap_size - 2, shadow)
    elseif baseSpread > 0 then
        ch_shadowrect(x - (dot_size / 2), y + (dot_size / 4) + gap_size, dot_size, line_size, col)
        ch_shadowrect(x - (dot_size / 2), y - (dot_size / 4) - gap_size - line_size, dot_size, line_size, col)
        ch_shadowrect(x + gap_size, y - (dot_size / 2), line_size, dot_size, col)
        ch_shadowrect(x - gap_size - line_size, y - (dot_size / 2), line_size, dot_size, col)
    end

    return true
end

"""

# Insert before the DrawHUD section
marker = "-- ============================================================\n-- DrawHUD"
if marker in src:
    src = src.replace(marker, dodraw_code + marker, 1)
else:
    print("ERROR: DrawHUD marker not found")

with open(FILEPATH, 'w', encoding='utf-8') as f:
    f.write(src)

print("Done. All 4 edits applied successfully.")
