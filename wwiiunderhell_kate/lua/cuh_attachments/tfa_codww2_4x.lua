if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "4x ACOG"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "4x ACOG",
    Color(255, 100, 100), "+25% Zoom time",
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
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 15
    wep.ZoomFov = 25
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    if CLIENT then
        -- Initialize RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = { 256, 512, 768, 1080 }
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- Create a placeholder ScopeTexture material. This will be REPLACED
        -- by the shadow material once we find the lens VMT path (in CustomThink).
        -- The RenderScene hook checks wep.ScopeTexture to decide whether to
        -- render the RT, so we need it set immediately.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "scope_acog"
        wep._rtScopeShadowCreated = false  -- will be set true once shadow material is created
        wep._rtScopeShadowPath = nil       -- the lens VMT path we shadowed

        -- Hook CustomThink to find the lens material and create the shadow.
        -- This must run AFTER InitVElements creates the csModel, so we do it
        -- in Think (not in Attach, because Attach runs before InitVElements).
        --
        -- CRITICAL: only hook once per weapon (idempotent via _rtScopeHooked).
        -- Capture prevThink as LOCAL upvalue to prevent recursion.
        if not wep._rtScopeHooked then
            wep._rtScopeHooked = true
            local prevThink = wep.CustomThink
            wep._rtScopePrevThink = prevThink

            wep.CustomThink = function(w, ct)
                -- Re-entry guard
                if w._rtScopeInThink then return end
                w._rtScopeInThink = true

                -- Run previous CustomThink
                if prevThink and prevThink ~= w.CustomThink then
                    prevThink(w, ct)
                end

                -- Try to find the lens material and create the shadow
                if not w._rtScopeShadowCreated then
                    if not w.ViewModelElements then w._rtScopeInThink = nil return end
                    local elem = w.ViewModelElements[w._rtScopeVElement]
                    if not elem or not IsValid(elem._csModel) then w._rtScopeInThink = nil return end
                    local csModel = elem._csModel

                    local mats = csModel:GetMaterials()
                    if not mats or #mats == 0 then w._rtScopeInThink = nil return end

                    -- Find the lens material by name
                    local lensPath = nil
                    for i = 1, #mats do
                        local mn = string.lower(tostring(mats[i]))
                        if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                            lensPath = mats[i]
                            break
                        end
                    end

                    -- Fallback: use material at index 0
                    if not lensPath then
                        lensPath = mats[1]
                    end

                    if lensPath then
                        w._rtScopeShadowPath = lensPath
                        -- CreateMaterial with the EXACT same name as the lens VMT.
                        -- This shadows the VMT: the engine finds our material
                        -- instead of the VMT when looking up by name.
                        -- Our material has NO proxy, so SetTexture sticks.
                        local shadowMat = CreateMaterial(lensPath, "UnlitGeneric", {
                            ["$basetexture"] = "gmod/scope",
                            ["$model"] = "1",
                            ["$translucent"] = "1",
                        })
                        -- Point ScopeTexture to the shadow material so the
                        -- RenderScene hook updates THIS material's basetexture.
                        w.ScopeTexture = shadowMat
                        w._rtScopeMatName = lensPath
                        w._rtScopeShadowCreated = true
                        w._rtScopeSubMatIndex = 0  -- for debug logging compat

                        if GetConVar("cuh_rt_scope_debug"):GetBool() then
                            print("[CUH RT] Shadow material created: " .. lensPath)
                            print("[CUH RT] Materials on csModel:")
                            for i = 1, #mats do
                                print(string.format("  [%d] %s", i - 1, tostring(mats[i])))
                            end
                        end
                    end
                end

                w._rtScopeInThink = nil
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
        -- Restore previous CustomThink
        if wep._rtScopePrevThink then
            wep.CustomThink = wep._rtScopePrevThink
            wep._rtScopePrevThink = nil
        else
            wep.CustomThink = nil
        end

        wep._rtScopeMatName = nil
        wep._rtScopeVElement = nil
        wep._rtScopeSubMatIndex = nil
        wep._rtScopeHooked = nil
        wep._rtScopeShadowCreated = nil
        wep._rtScopeShadowPath = nil
    end
end

-- CUH base handles registration
