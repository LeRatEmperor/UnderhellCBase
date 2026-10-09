if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "4x Scope"
ATTACHMENT.ShortName = "ACOG"
ATTACHMENT.Icon = "entities/tfa_codww2_4x.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "4x Zoom",
    Color(255, 100, 100), "+15% Zoom time",
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
    ["IronSightTime"] = function(wep, val) return val * 1.15 end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 15
    wep.ZoomFov = 25
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.3
    wep.Use2DScope = true
    if not wep.ScopeTexture then
        wep.ScopeTexture = Material("models/weapons/v_models/g36k/lens")
    end
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
    wep.Use2DScope = false
    wep.Sensitivity = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
end

-- CUH base handles registration
