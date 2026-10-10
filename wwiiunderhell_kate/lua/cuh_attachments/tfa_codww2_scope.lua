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
        -- Create a custom RT material with NO VMT = NO proxy block.
        -- The TFA_COD_Scope proxy in the WWII VMTs resets $basetexture
        -- every frame. Our custom material has no proxy, so SetTexture sticks.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "scope_default"
        wep._rtScopeSubMatIndex = nil  -- will be found on first Think

        -- Initialize RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = { 256, 512, 768, 1080 }
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- CustomThink re-applies SetSubMaterial EVERY FRAME.
        -- This is necessary because ApplyAttachments Stage 6 destroys
        -- and rebuilds the ClientsideModels AFTER Attach() runs, so
        -- any SetSubMaterial called in Attach() is lost. By applying
        -- it every frame in CustomThink, the override persists.
        -- CRITICAL: only hook CustomThink ONCE per weapon.
        -- The OLD code re-saved prev think into wep._rtScopePrevThink every
        -- Attach() call, but the closure body read w._rtScopePrevThink at
        -- *call time*. After a second Attach() (which happens routinely —
        -- ApplyAttachments re-runs on every attachment change, weapon switch,
        -- SWEP:Initialize), the field pointed back at our own closure →
        -- infinite recursion → stack overflow.
        -- Fix: capture prevThink as a LOCAL upvalue, and gate with _rtScopeHooked.
        if not wep._rtScopeHooked then
            wep._rtScopeHooked = true
            local prevThink = wep.CustomThink
            wep._rtScopePrevThink = prevThink

            wep.CustomThink = function(w, ct)
                -- Re-entry guard: if we're already inside this closure
                -- (e.g. due to stale state from a previous Lua refresh),
                -- bail out immediately to prevent any recursion.
                if w._rtScopeInThink then return end
                w._rtScopeInThink = true

                -- Run previous CustomThink via the LOCAL upvalue.
                -- NEVER call ourselves (recursion guard): if prevThink
                -- happens to be the same function as w.CustomThink,
                -- skip the call.
                if prevThink and prevThink ~= w.CustomThink then
                    prevThink(w, ct)
                end

                if not w._rtScopeMatName then
                    w._rtScopeInThink = nil
                    return
                end
                if not w.ViewModelElements then w._rtScopeInThink = nil return end
                local elem = w.ViewModelElements[w._rtScopeVElement]
                if not elem or not IsValid(elem._csModel) then w._rtScopeInThink = nil return end
                local csModel = elem._csModel

                -- Find the lens sub-material index (only once, then cache it)
                if not w._rtScopeSubMatIndex then
                    local mats = csModel:GetMaterials()
                    if mats then
                        for i = 1, #mats do
                            local mn = string.lower(tostring(mats[i]))
                            if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                                w._rtScopeSubMatIndex = i - 1  -- 0-based
                                break
                            end
                        end
                    end
                    -- If not found by name, try index 0 (first material is often the lens)
                    if not w._rtScopeSubMatIndex then
                        w._rtScopeSubMatIndex = 0
                    end
                end

                -- Apply the sub-material override EVERY FRAME
                csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
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
        -- Restore the original sub-material
        if wep._rtScopeSubMatIndex and wep._rtScopeVElement then
            if wep.ViewModelElements and wep.ViewModelElements[wep._rtScopeVElement] then
                local elem = wep.ViewModelElements[wep._rtScopeVElement]
                if IsValid(elem._csModel) then
                    elem._csModel:SetSubMaterial(wep._rtScopeSubMatIndex, "")
                end
            end
        end

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
        wep._rtScopeHooked = nil  -- allow a future Attach() to re-hook
    end
end

-- CUH base handles registration
