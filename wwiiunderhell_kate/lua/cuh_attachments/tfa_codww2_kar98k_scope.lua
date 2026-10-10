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
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or val end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 7
    wep.ZoomFov = 15
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

        -- Create a UNIQUE RT material (name does NOT conflict with any VMT,
        -- so no TFA proxy can touch it). UnlitGeneric has no proxy support,
        -- so SetTexture sticks permanently.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        -- Use UnlitGeneric shader (bright RT, no darkening).
        -- The reticle is composited onto the RT in the RenderScene hook
        -- via render.SetRenderTarget + render.DrawScreenQuadEx.
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "scope_default"
        wep._rtScopeSubMatIndex = nil  -- found in CustomThink
        wep._rtScopeOverrideSet = false  -- RenderOverride not yet installed

        -- Hook CustomThink to:
        --   1. Find the lens sub-material index on the csModel
        --   2. Install RenderOverride on the csModel
        -- This must run AFTER InitVElements creates the csModel.
        --
        -- CRITICAL: only hook once per weapon. Capture prevThink as LOCAL
        -- upvalue to prevent recursion.
        -- CRITICAL: Override DrawVElements per-instance to skip drawing
        -- during the RT render pass. The base's DrawVElements is called
        -- during render.RenderView (via PostDrawViewModel), which draws
        -- VElements (long barrels, suppressors, front sights) into the RT.
        -- SetNoDraw doesn't help because DrawModel() is called explicitly.
        -- This per-instance override checks the _rtScopeSuppressVElem flag
        -- set by the RenderScene hook in cuh_rt_scope_render.lua.
        -- CRITICAL: capture prevDrawVE as a LOCAL upvalue (NOT a weapon
        -- table field). Reading self._rtScopePrevDrawVE at call time causes
        -- infinite recursion when Attach() runs a second time (the field
        -- then points to our own closure). Same bug pattern as CustomThink.
        -- Gate with _rtScopeDrawVEHooked so we only hook once per weapon.
        if not wep._rtScopeDrawVEHooked then
            wep._rtScopeDrawVEHooked = true
            local prevDrawVE = wep.DrawVElements
            wep._rtScopePrevDrawVE = prevDrawVE

            wep.DrawVElements = function(self, vm)
                if self._rtScopeSuppressVElem then return end
                -- Call previous DrawVElements via the LOCAL upvalue.
                -- NEVER call ourselves (recursion guard).
                if prevDrawVE and prevDrawVE ~= self.DrawVElements then
                    prevDrawVE(self, vm)
                end
            end
        end

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

                -- Find lens index and install RenderOverride
                if not w._rtScopeOverrideSet then
                    if not w.ViewModelElements then w._rtScopeInThink = nil return end
                    local elem = w.ViewModelElements[w._rtScopeVElement]
                    if not elem or not IsValid(elem._csModel) then w._rtScopeInThink = nil return end
                    local csModel = elem._csModel

                    -- Find the lens material index.
                    -- Priority: "ads_lens" > "lens" > "optic" > "scope" > index 0
                    local mats = csModel:GetMaterials()
                    if mats and #mats > 0 then
                        local lensIdx = nil
                        -- First pass: look for "ads_lens" (TFA's actual lens material)
                        for i = 1, #mats do
                            local mn = string.lower(tostring(mats[i]))
                            if string.find(mn, "ads_lens") then
                                lensIdx = i - 1
                                break
                            end
                        end
                        -- Second pass: look for "lens"
                        if not lensIdx then
                            for i = 1, #mats do
                                local mn = string.lower(tostring(mats[i]))
                                if string.find(mn, "lens") then
                                    lensIdx = i - 1
                                    break
                                end
                            end
                        end
                        -- Third pass: "optic"
                        if not lensIdx then
                            for i = 1, #mats do
                                local mn = string.lower(tostring(mats[i]))
                                if string.find(mn, "optic") then
                                    lensIdx = i - 1
                                    break
                                end
                            end
                        end
                        -- Fallback: index 0
                        if not lensIdx then lensIdx = 0 end

                        w._rtScopeSubMatIndex = lensIdx

                        if GetConVar("cuh_rt_scope_debug"):GetBool() then
                            print("[CUH RT] Found lens at index " .. lensIdx)
                            print("[CUH RT] Materials on csModel:")
                            for i = 1, #mats do
                                local marker = (i - 1 == lensIdx) and " <-- SELECTED" or ""
                                print(string.format("  [%d] %s%s", i - 1, tostring(mats[i]), marker))
                            end
                        end
                    end

                    -- Install RenderOverride on the csModel.
                    -- This injects SetSubMaterial at the EXACT right moment:
                    -- AFTER DrawVElements calls SetModel (which resets submats),
                    -- but BEFORE the actual draw.
                    --
                    -- How it works:
                    --   1. DrawVElements calls model:SetModel(elem.model)
                    --      -> resets all sub-materials
                    --   2. DrawVElements calls model:DrawModel()
                    --   3. DrawModel sees RenderOverride is set, calls it
                    --   4. Our RenderOverride calls SetSubMaterial (sets our RT mat)
                    --   5. Our RenderOverride temporarily nils itself, calls
                    --      DrawModel again (this time it draws normally,
                    --      WITH our sub-material)
                    --   6. Our RenderOverride restores itself for next frame
                    csModel.RenderOverride = function(self)
                        -- Set the RT on the lens material
                        if w._rtScopeMatName then
                            self:SetSubMaterial(w._rtScopeSubMatIndex or 0, "!" .. w._rtScopeMatName)
                        end


                        -- Temporarily remove RenderOverride so DrawModel
                        -- does the actual rendering (not recursion)
                        local savedOverride = self.RenderOverride
                        self.RenderOverride = nil
                        self:DrawModel()
                        self.RenderOverride = savedOverride
                    end

                    w._rtScopeOverrideSet = true

                    if GetConVar("cuh_rt_scope_debug"):GetBool() then
                        print("[CUH RT] RenderOverride installed on csModel")
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
        -- Remove RenderOverride and restore sub-material
        if wep.ViewModelElements and wep._rtScopeVElement then
            local elem = wep.ViewModelElements[wep._rtScopeVElement]
            if elem and IsValid(elem._csModel) then
                elem._csModel.RenderOverride = nil
                if wep._rtScopeSubMatIndex then
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
        wep._rtScopeHooked = nil
        wep._rtScopeDrawVEHooked = nil
        -- Restore original DrawVElements
        if wep._rtScopePrevDrawVE then
            wep.DrawVElements = wep._rtScopePrevDrawVE
            wep._rtScopePrevDrawVE = nil
        end
        wep._rtScopeOverrideSet = nil
    end
end

-- CUH base handles registration
