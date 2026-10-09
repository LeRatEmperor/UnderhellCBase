if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Mosin Scope"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "Mosin Scope",
    Color(255, 100, 100), "+25% Zoom time",
}

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
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}

function ATTACHMENT:Attach(wep)
    -- Set ScopeTexture to the actual scope lens material used by the
    -- scope model's lens mesh. The RenderScene hook will replace this
    -- material's $basetexture with the RenderTarget, so the lens
    -- displays the 3D RT view.
    wep.ScopeTexture = Material("models/weapons/tfa_codww2/mosin/mtl_generic_optic_ads_lens")
    wep.ScopeFov = 7
    wep.ZoomFov = 15
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

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
end

-- CUH base handles registration
