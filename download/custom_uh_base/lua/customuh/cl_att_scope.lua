AddCSLuaFile()
-- cl_att_scope.lua
-- CustomUH Scope/RT System — Render target scopes
-- ============================================================
-- Renders a scope view into a render target texture and applies it
-- to the viewmodel's scope material.
--
-- Attachment defines:
--   ATTACHMENT.RTScope = {
--       MaterialIndex = 1,       -- VM material slot for RT texture
--       ScopeFOV = 8,            -- FOV when scoped
--       Reticle = "path/to/reticle.png",
--       ReticleColor = Color(255, 0, 0),
--       ReticleScale = 1.0,
--   }
--
-- On Attach:
--   Saves old RTMaterialOverride and RTCode
--   Sets RTMaterialOverride = att.MaterialIndex
--   Sets RTCode = render function
--
-- On Detach:
--   Restores old values
-- ============================================================

-- ============================================================
-- SCOPE RENDERING (called from PreDrawViewModel)
-- ============================================================
function SWEP:DoRTScope()
    if not self.RTCode then return end
    if not self:GetUHBool("Zooming") then return end

    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if not IsValid(vm) then return end

    local rtMat = self.RTMaterialOverride
    if not rtMat or rtMat < 1 then return end

    -- Create or get render target
    if not self._rtTexture then
        self._rtTexture = GetRenderTarget("CustomUH_ScopeRT_" .. self:EntIndex(), 1024, 1024, false)
        if not self._rtTexture then return end
    end

    local scopeFOV = self.RTScopeFOV or 8

    -- Render the scope view into the RT
    render.PushRenderTarget(self._rtTexture, 0, 0, 1024, 1024)
    local ang = self.Owner:EyeAngles()
    local pos = self.Owner:EyePos()
    render.RenderView({
        x = 0, y = 0, w = 1024, h = 1024,
        origin = pos, angles = ang,
        drawviewmodel = false, drawhud = false,
        dopostprocess = false, fov = scopeFOV,
    })
    render.PopRenderTarget()

    -- Apply RT to the viewmodel material
    local mat = vm:GetMaterials()
    if mat and mat[rtMat] then
        local rtMatObj = Material(mat[rtMat])
        if rtMatObj then
            rtMatObj:SetTexture("$basetexture", self._rtTexture)
        end
    end

    -- Call custom RT code for overlays (thermal, dirt, etc.)
    self:RTCode(self._rtTexture, ScrW(), ScrH())
end

-- ============================================================
-- CLEANUP RT SCOPE
-- ============================================================
function SWEP:CleanupRTScope()
    self._rtTexture = nil
end

-- ============================================================
-- ATTACHMENT HELPER — Setup scope from attachment
-- ============================================================
function SWEP:SetupRTScope(att)
    if not att or not att.RTScope then
        self:ClearRTScope()
        return
    end

    -- Save old values for restore on detach
    self._oldRTMaterialOverride = self._oldRTMaterialOverride or self.RTMaterialOverride
    self._oldRTCode = self._oldRTCode or self.RTCode
    self._oldRTScopeFOV = self._oldRTScopeFOV or self.RTScopeFOV

    -- Apply new scope settings
    self.RTMaterialOverride = att.RTScope.MaterialIndex or 1
    self.RTScopeFOV = att.RTScope.ScopeFOV or 8

    -- Set up RTCode for reticle overlay
    if att.RTScope.Reticle then
        local reticleMat = Material(att.RTScope.Reticle, "smooth")
        local reticleColor = att.RTScope.ReticleColor or Color(255, 0, 0, 255)
        local reticleScale = att.RTScope.ReticleScale or 1.0

        self.RTCode = function(rt, scrw, scrh)
            if not self:GetUHBool("Zooming") then return end
            if not reticleMat or reticleMat:IsError() then return end

            -- Draw reticle overlay
            cam.Start2D()
                local cx, cy = scrw / 2, scrh / 2
                local size = 32 * reticleScale
                surface.SetMaterial(reticleMat)
                surface.SetDrawColor(reticleColor)
                surface.DrawTexturedRect(cx - size / 2, cy - size / 2, size, size)
            cam.End2D()
        end
    end
end

-- ============================================================
-- CLEAR RT SCOPE (restore old values)
-- ============================================================
function SWEP:ClearRTScope()
    self.RTMaterialOverride = self._oldRTMaterialOverride
    self.RTCode = self._oldRTCode
    self.RTScopeFOV = self._oldRTScopeFOV
    self._oldRTMaterialOverride = nil
    self._oldRTCode = nil
    self._oldRTScopeFOV = nil
end
