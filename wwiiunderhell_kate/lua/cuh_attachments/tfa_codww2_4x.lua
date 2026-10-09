if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "4x ACOG"
ATTACHMENT.ShortName = "ACOG"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "4x ACOG",
    Color(255, 100, 100), "+14% Zoom time",
    Color(255, 100, 100), "-5% ADS Movespeed",
}

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

function ATTACHMENT:Attach(wep)
    -- Enable the true RT scope system (NOT the 2D overlay)
    -- ScopeTexture is a Material() whose $basetexture gets replaced with
    -- the RenderTarget by the RenderScene hook. The viewmodel's scope
    -- lens mesh uses this material, so the 3D view appears ON the lens.
    wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    wep.ScopeFov = 15
    wep.ZoomFov = 25
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false  -- NO 2D overlay — use the true RT lens system

    -- Initialize RenderTarget if not already done
    if CLIENT and not wep.RenderTarget and wep.ScopeTexture then
        local scale = ScrH() / 1080
        local quality = { 256, 512, 768, 1080 }
        local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
        wep.RT_Size = quality[num] * scale
        wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
    end
end

function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false
    wep.RenderTarget = nil
end

-- CUH base handles registration
