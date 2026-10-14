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
-- REFLEX DOT RENDERING (ported 1:1 from BO3 Drakon reference)
-- ============================================================
-- Uses the Underhell HUD rendering system to draw the reflex dot
-- texture on screen when aiming, with a delay to account for the
-- gun travel time from idle to ironsights.
-- Uses the WWII reflex dot texture (reflex/reflex_dot) instead of
-- the BO3 reddot texture (blackops3/reticles/reflex_4).

local RedDotMaterial

if CLIENT then
    RedDotMaterial = CreateMaterial("UH_ReflexDotReticle", "UnlitGeneric", {
        ["$basetexture"] = "reflex/reflex_dot",
        ["$vertexcolor"] = 1,
        ["$vertexalpha"] = 1,
        ["$additive"] = 1,
    })
end

function ATTACHMENT:Attach(wep)
    if not CLIENT then return end

    -- Override DrawHUD — calls self.BaseClass.DrawHUD(self) directly
    -- (same as the Drakon reference). No prev capture, no recursion.
    wep.DrawHUD = function(self)
        if not self:GetUHBool("Zooming") then
            self.BaseClass.DrawHUD(self)
            return
        end

        self.BaseClass.DrawHUD(self)

        local delay = 0.1
        local fadeTime = 0.1
        local dotSize = 128

        local aimTime = self._zoomStartTime or 0
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

    -- Track zoom start time via Think (same as Drakon)
    wep._reflexThinkInstalled = true
    local prevThink = wep.Think
    wep.Think = function(self, ...)
        local isZooming = self:GetUHBool("Zooming")
        if isZooming and not self._wasZooming then
            self._zoomStartTime = CurTime()
        end
        self._wasZooming = isZooming

        if prevThink then
            return prevThink(self, ...)
        end
    end
end

function ATTACHMENT:Detach(wep)
    if not CLIENT then return end

    -- Restore by nil'ing the instance override — weapon falls back to
    -- the class table's DrawHUD/Think.
    wep.DrawHUD = nil
    wep.Think = nil
    wep._zoomStartTime = nil
    wep._wasZooming = nil
    wep._reflexThinkInstalled = nil
end

-- TFA attachment registration removed (CUH base handles this)
