if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Kar98k Scope"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "Kar98k Scope",
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
    print("[RT-DBG] tfa_codww2_kar98k_scope ATTACH() called | realm=" .. (SERVER and "SERVER" or "CLIENT"))

    -- Set ScopeTexture to the actual scope lens material used by the
    -- scope model's lens mesh. The RenderScene hook will replace this
    -- material's $basetexture with the RenderTarget, so the lens
    -- displays the 3D RT view.
    wep.ScopeTexture = Material("models/weapons/tfa_codww2/kar98k/mtl_generic_optic_ads_lens")
    print("[RT-DBG] ScopeTexture set to: " .. tostring(wep.ScopeTexture))
    print("[RT-DBG] ScopeTexture name: " .. tostring(wep.ScopeTexture and wep.ScopeTexture:GetName() or "nil"))
    print("[RT-DBG] ScopeTexture basetexture: " .. tostring(wep.ScopeTexture and wep.ScopeTexture:GetTexture("$basetexture") or "nil"))

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
        print("[RT-DBG] RenderTarget created: " .. tostring(wep.RenderTarget) .. " | size=" .. tostring(wep.RT_Size))
    else
        print("[RT-DBG] RenderTarget NOT created | CLIENT=" .. tostring(CLIENT) .. " | existing RT=" .. tostring(wep.RenderTarget) .. " | scopeTexture=" .. tostring(wep.ScopeTexture))
    end

    print("[RT-DBG] Final state: ScopeTexture=" .. tostring(wep.ScopeTexture) .. " | RT=" .. tostring(wep.RenderTarget) .. " | ScopeFov=" .. tostring(wep.ScopeFov) .. " | ScopeDisabled=" .. tostring(wep.ScopeDisabled))
end

function ATTACHMENT:Detach(wep)
    print("[RT-DBG] tfa_codww2_kar98k_scope DETACH() called | realm=" .. (SERVER and "SERVER" or "CLIENT"))
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false
end

-- CUH base handles registration
