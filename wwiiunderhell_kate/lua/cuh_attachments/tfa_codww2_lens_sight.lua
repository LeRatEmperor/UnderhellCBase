if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Lens Sight"
ATTACHMENT.ShortName = "LENS"
ATTACHMENT.Icon = "entities/tfa_codww2_lens_sight.png"
ATTACHMENT.Description = {
    Color(255, 255, 255), "Lens Sight",
    Color(100, 255, 100), "+10% ADS Speed",
}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["lens_sight"] = {
            ["active"] = true,
        },
        ["sight_default"] = {
            ["active"] = false,
        },
    },
    ["WElements"] = {
        ["lens_sight"] = {
            ["active"] = true,
        },
        ["sight_default"] = {
            ["active"] = false,
        },
    },
    ["IronSightTime"] = function(wep, val) return val * 0.9 end,
    -- Lens sight uses a low zoom (reflex-style, not magnified scope)
    ["ScopeFov"] = 30,
    ["ZoomFov"] = 40,
    ["Sensitivity"] = 0.5,
    -- Use the per-weapon Lens ironsight offset if available
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_Lens or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_Lens or val end,
}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = 30
    wep.ZoomFov = 40
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.5
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
        local mat = CreateMaterial(matName, "UnlitGeneric", {
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        })
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "lens_sight"
        wep._rtScopeSubMatIndex = nil
        wep._rtScopeOverrideSet = false

        -- CRITICAL: Override DrawVElements per-instance to skip drawing
        -- during the RT render pass. The base's DrawVElements is called
        -- during render.RenderView (via PostDrawViewModel), which draws
        -- VElements (long barrels, suppressors, front sights) into the RT.
        -- SetNoDraw doesn't help because DrawModel() is called explicitly.
        -- This per-instance override checks the _rtScopeSuppressVElem flag
        -- set by the RenderScene hook in cuh_rt_scope_render.lua.
        wep._rtScopePrevDrawVE = wep.DrawVElements
        wep.DrawVElements = function(self, vm)
            if self._rtScopeSuppressVElem then return end
            if self._rtScopePrevDrawVE then
                self._rtScopePrevDrawVE(self, vm)
            end
        end

        if not wep._rtScopeHooked then
            wep._rtScopeHooked = true
            local prevThink = wep.CustomThink
            wep._rtScopePrevThink = prevThink

            wep.CustomThink = function(w, ct)
                if w._rtScopeInThink then return end
                w._rtScopeInThink = true

                if prevThink and prevThink ~= w.CustomThink then
                    prevThink(w, ct)
                end

                if not w._rtScopeOverrideSet then
                    if not w.ViewModelElements then w._rtScopeInThink = nil return end
                    local elem = w.ViewModelElements[w._rtScopeVElement]
                    if not elem or not IsValid(elem._csModel) then w._rtScopeInThink = nil return end
                    local csModel = elem._csModel

                    local mats = csModel:GetMaterials()
                    if mats and #mats > 0 then
                        local lensIdx = nil
                        for i = 1, #mats do
                            local mn = string.lower(tostring(mats[i]))
                            if string.find(mn, "ads_lens") then
                                lensIdx = i - 1
                                break
                            end
                        end
                        if not lensIdx then
                            for i = 1, #mats do
                                local mn = string.lower(tostring(mats[i]))
                                if string.find(mn, "lens") then
                                    lensIdx = i - 1
                                    break
                                end
                            end
                        end
                        if not lensIdx then
                            for i = 1, #mats do
                                local mn = string.lower(tostring(mats[i]))
                                if string.find(mn, "optic") then
                                    lensIdx = i - 1
                                    break
                                end
                            end
                        end
                        if not lensIdx then lensIdx = 0 end

                        w._rtScopeSubMatIndex = lensIdx

                        if GetConVar("cuh_rt_scope_debug"):GetBool() then
                            print("[CUH RT] LensSight: Found lens at index " .. lensIdx)
                            print("[CUH RT] LensSight: Materials on csModel:")
                            for i = 1, #mats do
                                local marker = (i - 1 == lensIdx) and " <-- SELECTED" or ""
                                print(string.format("  [%d] %s%s", i - 1, tostring(mats[i]), marker))
                            end
                        end
                    end

                    -- Install RenderOverride on the csModel.
                    csModel.RenderOverride = function(self)
                        if w._rtScopeMatName then
                            self:SetSubMaterial(w._rtScopeSubMatIndex or 0, "!" .. w._rtScopeMatName)
                        end
                        local savedOverride = self.RenderOverride
                        self.RenderOverride = nil
                        self:DrawModel()
                        self.RenderOverride = savedOverride
                    end

                    w._rtScopeOverrideSet = true

                    if GetConVar("cuh_rt_scope_debug"):GetBool() then
                        print("[CUH RT] LensSight: RenderOverride installed on csModel")
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
        if wep.ViewModelElements and wep._rtScopeVElement then
            local elem = wep.ViewModelElements[wep._rtScopeVElement]
            if elem and IsValid(elem._csModel) then
                elem._csModel.RenderOverride = nil
                if wep._rtScopeSubMatIndex then
                    elem._csModel:SetSubMaterial(wep._rtScopeSubMatIndex, "")
                end
            end
        end

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
        -- Restore original DrawVElements
        if wep._rtScopePrevDrawVE then
            wep.DrawVElements = wep._rtScopePrevDrawVE
            wep._rtScopePrevDrawVE = nil
        end
        wep._rtScopeOverrideSet = nil
    end
end

-- CUH base handles registration
