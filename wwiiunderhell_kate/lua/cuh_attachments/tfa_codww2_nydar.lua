if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Nydar Reflex"
ATTACHMENT.ShortName = "NYDAR"
ATTACHMENT.Icon = "entities/tfa_codww2_nydar.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Reflex Sight",
        Color(100, 255, 100), "+10% ADS Speed",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["sight_nydar"] = {
                        ["active"] = true,
                },
        },
        ["WElements"] = {
                ["sight_nydar"] = {
                        ["active"] = true,
                },
        },
        ["IronSightTime"] = function(wep, val) return val * 0.9 end,
        -- Use the per-weapon Nydar ironsight offset if available (from TFA source)
        ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_NYDAR or val end,
        ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_NYDAR or val end,
}

-- ============================================================
-- REFLEX DOT RENDERING (ported from BO3 Drakon reference)
-- ============================================================
-- Uses the Underhell HUD rendering system to draw the reflex dot
-- texture on screen when aiming, with a delay to account for the
-- gun travel time from idle to ironsights.
-- Uses the WWII reflex dot texture (reflex/reflex_dot) instead of
-- the BO3 reddot texture (blackops3/reticles/reflex_4).

local RedDotMaterial

if CLIENT then
    RedDotMaterial = CreateMaterial("CUH_ReflexDotReticle", "UnlitGeneric", {
        ["$basetexture"] = "reflex/reflex_dot",
        ["$vertexcolor"] = 1,
        ["vertexalpha"] = 1,
        ["$additive"] = 1,
    })
end

function ATTACHMENT:Attach(wep)
    if not CLIENT then return end

    -- Override DrawHUD to draw the reflex dot when zooming
    wep._cuhPrevDrawHUD = wep.DrawHUD
    wep._cuhReflexActive = true

    wep.DrawHUD = function(self)
        -- Draw base HUD (crosshair, ammo, etc.) first
        -- Skip base DrawHUD when zoomed to hide the crosshair behind the dot
        if not self:GetUHBool("Zooming") then
            if self._cuhPrevDrawHUD then
                self._cuhPrevDrawHUD(self)
            end
            return
        end

        -- Still call base for ammo display etc.
        if self._cuhPrevDrawHUD then
            self._cuhPrevDrawHUD(self)
        end

        local delay = 0.1
        local fadeTime = 0.1
        local dotSize = 128

        local aimTime = self._cuhZoomStartTime or 0
        if CurTime() < (aimTime + delay) then return end

        local alpha = 255
        if CurTime() < (aimTime + delay + fadeTime) then
            alpha = math.Clamp((CurTime() - aimTime - delay) / fadeTime * 255, 0, 255)
        end

        surface.SetMaterial(RedDotMaterial)
        surface.SetDrawColor(255, 0, 0, alpha)
        surface.DrawTexturedRect(
            (ScrW() / 2) - (dotSize / 2),
            (ScrH() / 2) - (dotSize / 2),
            dotSize,
            dotSize
        )
    end

    -- Track zoom start time via a Think hook (per-weapon)
    if not wep._cuhReflexThinkHooked then
        wep._cuhReflexThinkHooked = true
        local prevThink = wep.Think
        wep.Think = function(self, ...)
            -- Track zoom transitions
            local isZooming = self:GetUHBool("Zooming")
            if isZooming and not self._cuhWasZooming then
                self._cuhZoomStartTime = CurTime()
            end
            self._cuhWasZooming = isZooming

            -- Call previous Think
            if prevThink then
                return prevThink(self, ...)
            end
        end
    end
end

-- ============================================================
-- DETACH: Restore original DrawHUD and Think
-- ============================================================
-- Note: Detach is never called by the base (ApplyAttachments calls
-- RestoreStat + Attach for the new selection). So the cleanup is
-- handled by the ApplyAttachments override in cuh_rt_scope_render.lua
-- which purges scope state before re-applying.
-- However, we also provide a Detach for manual cleanup.

function ATTACHMENT:Detach(wep)
    if not CLIENT then return end

    -- Restore original DrawHUD
    if wep._cuhPrevDrawHUD then
        wep.DrawHUD = wep._cuhPrevDrawHUD
        wep._cuhPrevDrawHUD = nil
    end

    wep._cuhReflexActive = nil
    wep._cuhZoomStartTime = nil
    wep._cuhWasZooming = nil
end

-- TFA attachment registration removed (CUH base handles this)
