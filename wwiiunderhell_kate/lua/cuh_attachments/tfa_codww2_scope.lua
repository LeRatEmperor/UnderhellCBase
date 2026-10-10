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
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 7
    wep.ZoomFov = 15
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    if CLIENT then
        -- Create a custom RT material with NO VMT file = NO proxy block.
        -- The TFA_COD_Scope proxy in the WWII lens VMTs resets $basetexture
        -- every frame, overwriting our SetTexture call. By using a custom
        -- material that has no proxy, SetTexture actually takes effect.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "vgui/scope_lens",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat

        -- Initialize RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = { 256, 512, 768, 1080 }
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- Find the lens sub-material index on the scope VElement's
        -- ClientsideModel and override it with our custom RT material.
        -- This bypasses the model's default material (which has the
        -- TFA_COD_Scope proxy that resets $basetexture every frame).
        if wep.ViewModelElements and wep.ViewModelElements["scope_default"] then
            local elem = wep.ViewModelElements["scope_default"]
            if IsValid(elem._csModel) then
                local mats = elem._csModel:GetMaterials()
                if mats then
                    for i = 1, #mats do
                        local matName2 = string.lower(tostring(mats[i]))
                        if string.find(matName2, "lens") or string.find(matName2, "optic") or string.find(matName2, "scope") then
                            -- Sub-material indices are 0-based in Source
                            local subIndex = i - 1
                            elem._csModel:SetSubMaterial(subIndex, matName)
                            wep._rtScopeSubMatIndex = subIndex
                            wep._rtScopeVElement = "scope_default"
                            break
                        end
                    end
                end
            end
        end
    end
end

function ATTACHMENT:Detach(wep)
    wep.ScopeDisabled = true
    wep.ScopeTexture = nil
    wep.ScopeFov = nil
    wep.ZoomFov = 20
    wep.Sensitivity = nil
    wep.Use2DScope = false

    if CLIENT then
        -- Restore the original sub-material on the VElement's ClientsideModel
        if wep._rtScopeSubMatIndex and wep._rtScopeVElement then
            if wep.ViewModelElements and wep.ViewModelElements[wep._rtScopeVElement] then
                local elem = wep.ViewModelElements[wep._rtScopeVElement]
                if IsValid(elem._csModel) then
                    elem._csModel:SetSubMaterial(wep._rtScopeSubMatIndex, "")
                end
            end
            wep._rtScopeSubMatIndex = nil
            wep._rtScopeVElement = nil
        end
    end
end

-- CUH base handles registration
