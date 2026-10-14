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
        ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_NYDAR or val end,
        ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_NYDAR or val end,
}

-- ============================================================
-- REFLEX DOT RENDERING (via HUDPaint hook — does NOT override DrawHUD)
-- ============================================================
-- Uses a HUDPaint hook that checks _reflexActive before drawing.
-- This completely avoids overriding DrawHUD, which was breaking
-- the HUD when switching between attachments.

local RedDotMaterial

if CLIENT then
    RedDotMaterial = CreateMaterial("UH_ReflexDotReticle", "UnlitGeneric", {
        ["$basetexture"] = "reflex/reflex_dot",
        ["$vertexcolor"] = 1,
        ["$vertexalpha"] = 1,
        ["$additive"] = 1,
    })

    -- Single HUDPaint hook for ALL weapons — checks _reflexActive flag
    hook.Add("HUDPaint", "CUH_ReflexDot", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) then return end
        if not wep.IsCUHWeapon then return end

        -- Toggle: only draw if the Nydar is actively equipped
        if not wep._reflexActive then return end

        -- Only draw when zooming
        if not wep.GetUHBool or not wep:GetUHBool("Zooming") then return end

        -- Track zoom start time for delay
        local isZooming = wep:GetUHBool("Zooming")
        if isZooming and not wep._wasZooming then
            wep._zoomStartTime = CurTime()
        end
        wep._wasZooming = isZooming

        local delay = 0.1
        local fadeTime = 0.1
        local dotSize = 128

        local aimTime = wep._zoomStartTime or 0
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
    end)
end

function ATTACHMENT:Attach(wep)
    if not CLIENT then return end
    -- Set the toggle ON — the HUDPaint hook checks this flag
    wep._reflexActive = true
end

function ATTACHMENT:Detach(wep)
    if not CLIENT then return end
    -- Turn the toggle OFF
    wep._reflexActive = false
    wep._zoomStartTime = nil
    wep._wasZooming = nil
end

-- TFA attachment registration removed (CUH base handles this)
