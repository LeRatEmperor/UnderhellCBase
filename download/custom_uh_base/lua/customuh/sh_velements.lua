AddCSLuaFile()
-- sh_velements.lua
-- CustomUH VElement System — Viewmodel attachment models
-- ============================================================
-- Supports: bonemerge, bodygroups, skin, material, scale,
--           surpresslightning, sprites, proper cleanup.
--
-- VElement format (in weapon or attachment WeaponTable):
--   ["my_att"] = {
--       type     = "Model",
--       model    = "path/to/model.mdl",
--       bone     = "bone_name",           -- VM bone to attach to
--       pos      = Vector(x, y, z),       -- offset from bone
--       ang      = Angle(p, y, r),        -- rotation from bone
--       scale    = Vector(1, 1, 1),
--       material = "material_path",
--       skin     = 0,
--       bodygroups = { [0] = 1, [1] = 2 },
--       bonemerge = false,                 -- if true, uses EF_BONEMERGE
--       surpresslightning = false,
--       active   = false,                  -- toggled by attachments
--   }
-- ============================================================

-- ============================================================
-- INIT — create ClientsideModels for all VElements
-- ============================================================
function SWEP:InitVElements()
    if not self.ViewModelElements then return end
    if self._vElementsInit then return end
    self._vElementsInit = true

    if CLIENT then
        for name, elem in pairs(self.ViewModelElements) do
            -- Store default active state for reset
            if elem._defaultActive == nil then
                elem._defaultActive = elem.active or false
            end

            if elem.type == "Model" and elem.model and elem.model ~= "" then
                elem._csModel = ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)
                if IsValid(elem._csModel) then
                    elem._csModel:SetNoDraw(true)

                    -- Apply skin
                    if elem.skin then elem._csModel:SetSkin(elem.skin) end

                    -- Apply bodygroups
                    if elem.bodygroups then
                        for bg, val in pairs(elem.bodygroups) do
                            elem._csModel:SetBodygroup(bg, val)
                        end
                    end

                    -- Apply material
                    if elem.material and elem.material ~= "" then
                        elem._csModel:SetMaterial(elem.material)
                    end
                end
            end
        end
    end
end

-- ============================================================
-- DRAW — render all active VElements on the viewmodel
-- ============================================================
function SWEP:DrawVElements(vm)
    if not self.ViewModelElements then return end
    if not self._vElementsInit then self:InitVElements() end

    for name, elem in pairs(self.ViewModelElements) do
        if not elem.active then continue end

        if elem.type == "Model" and IsValid(elem._csModel) then
            local model = elem._csModel

            if elem.bonemerge then
                -- BONEMERGE: parent to viewmodel, let engine handle bone following
                model:SetParent(vm)
                model:AddEffects(EF_BONEMERGE)

                -- Still apply position/angle/scale offsets on top
                if elem.pos then
                    local boneId = vm:LookupBone(elem.bone or "")
                    if boneId then
                        local bPos, bAng = vm:GetBonePosition(boneId)
                        if bPos then
                            local pos = bPos
                            pos = pos + bAng:Right() * (elem.pos.x or 0)
                            pos = pos + bAng:Forward() * (elem.pos.y or 0)
                            pos = pos + bAng:Up() * (elem.pos.z or 0)
                            model:SetPos(pos)
                        end
                    end
                end

                -- Apply scale
                local scale = elem.scale or Vector(1, 1, 1)
                model:SetModelScale(scale.x, 0)

                -- Apply material/skin/bodygroups (in case changed by attachment)
                if elem.material and elem.material ~= "" then
                    model:SetMaterial(elem.material)
                end
                if elem.skin then model:SetSkin(elem.skin) end
                if elem.bodygroups then
                    for bg, val in pairs(elem.bodygroups) do
                        model:SetBodygroup(bg, val)
                    end
                end

                -- Suppress engine lighting if requested
                if elem.surpresslightning then
                    render.SuppressEngineLighting(true)
                end

                model:DrawModel()

                if elem.surpresslightning then
                    render.SuppressEngineLighting(false)
                end
            else
                -- MANUAL BONE FOLLOWING
                local boneId = vm:LookupBone(elem.bone or "")
                if boneId then
                    local bPos, bAng = vm:GetBonePosition(boneId)
                    if bPos then
                        -- Position offset from bone
                        local pos = bPos
                        pos = pos + bAng:Right()   * (elem.pos and elem.pos.x or 0)
                        pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                        pos = pos + bAng:Up()      * (elem.pos and elem.pos.z or 0)

                        -- Angle offset from bone
                        local ang = Angle(bAng)
                        if elem.ang then
                            ang:RotateAroundAxis(ang:Right(),   elem.ang.p or 0)
                            ang:RotateAroundAxis(ang:Up(),       elem.ang.y or 0)
                            ang:RotateAroundAxis(ang:Forward(),  elem.ang.r or 0)
                        end

                        model:SetPos(pos)
                        model:SetAngles(ang)

                        -- Scale
                        local scale = elem.scale or Vector(1, 1, 1)
                        model:SetModelScale(scale.x, 0)

                        -- Material/skin/bodygroups
                        if elem.material and elem.material ~= "" then
                            model:SetMaterial(elem.material)
                        end
                        if elem.skin then model:SetSkin(elem.skin) end
                        if elem.bodygroups then
                            for bg, val in pairs(elem.bodygroups) do
                                model:SetBodygroup(bg, val)
                            end
                        end

                        -- Lighting
                        if elem.surpresslightning then
                            render.SuppressEngineLighting(true)
                        end

                        model:DrawModel()

                        if elem.surpresslightning then
                            render.SuppressEngineLighting(false)
                        end
                    end
                end
            end

        elseif elem.type == "Sprite" then
            -- Sprite element (drawn at bone position)
            local boneId = vm:LookupBone(elem.bone or "")
            if boneId then
                local bPos, bAng = vm:GetBonePosition(boneId)
                if bPos then
                    local pos = bPos
                    pos = pos + bAng:Right()   * (elem.pos and elem.pos.x or 0)
                    pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                    pos = pos + bAng:Up()      * (elem.pos and elem.pos.z or 0)

                    if elem.material then
                        render.SetMaterial(Material(elem.material))
                        local size = elem.size or 4
                        render.DrawSprite(pos, size, size, elem.color or Color(255, 255, 255, 255))
                    end
                end
            end
        end
    end
end

-- ============================================================
-- CLEANUP — remove all ClientsideModels
-- ============================================================
function SWEP:CleanupVElements()
    if not self.ViewModelElements then return end

    for name, elem in pairs(self.ViewModelElements) do
        if IsValid(elem._csModel) then
            elem._csModel:Remove()
            elem._csModel = nil
        end
    end

    self._vElementsInit = false
end

-- ============================================================
-- GET ACTIVE VELEMENT COUNT (for debugging)
-- ============================================================
function SWEP:GetActiveVElementCount()
    if not self.ViewModelElements then return 0 end
    local count = 0
    for name, elem in pairs(self.ViewModelElements) do
        if elem.active then count = count + 1 end
    end
    return count
end
