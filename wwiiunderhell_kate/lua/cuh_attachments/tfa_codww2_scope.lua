if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "7x Scope"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "7x Scope",
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
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or val end,
}

function ATTACHMENT:Attach(wep)
    -- Create a unique RT material for this weapon instance.
    -- The RenderScene hook will assign the RenderTarget to this material's
    -- $basetexture, and the scope VElement's lens mesh will display the RT view.
    if CLIENT then
        local matName = "kate_scope_rt_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "vgui/scope_lens",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat

        -- Override the scope VElement's material so the lens mesh uses our RT material.
        -- The VElement's DrawVElements calls model:SetMaterial() every frame.
        if wep.ViewModelElements and wep.ViewModelElements["scope_default"] then
            wep.ViewModelElements["scope_default"]._original_material = wep.ViewModelElements["scope_default"].material
            wep.ViewModelElements["scope_default"].material = matName
        end

        -- Initialize the RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = { 256, 512, 768, 1080 }
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- Re-init VElements so the material override takes effect
        if wep.CleanupVElements then wep:CleanupVElements() end
        if wep.InitVElements then wep:InitVElements() end
    end

    -- Configure scope parameters
    wep.ScopeFov = 7
    wep.ZoomFov = 15
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false  -- NO 2D overlay — pure RT on the lens
end

function ATTACHMENT:Detach(wep)
    -- Disable RT scope
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false

    -- Restore the scope VElement's original material
    if wep.ViewModelElements and wep.ViewModelElements["scope_default"] then
        if wep.ViewModelElements["scope_default"]._original_material ~= nil then
            wep.ViewModelElements["scope_default"].material = wep.ViewModelElements["scope_default"]._original_material
            wep.ViewModelElements["scope_default"]._original_material = nil
        end
    end

    -- Re-init VElements to restore original material
    if CLIENT then
        if wep.CleanupVElements then wep:CleanupVElements() end
        if wep.InitVElements then wep:InitVElements() end
    end
end

-- CUH base handles registration
