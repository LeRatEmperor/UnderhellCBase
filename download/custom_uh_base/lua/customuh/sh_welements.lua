AddCSLuaFile()
-- sh_welements.lua
-- CustomUH WElement System — World model attachment models
-- ============================================================
-- Same format as VElements but for the world model (thirdperson).
-- Drawn on the owner's right hand bone.
-- ============================================================

-- ============================================================
-- INIT — create ClientsideModels for all WElements
-- ============================================================
function SWEP:InitWElements()
    if not self.WorldModelElements then return end
    if self._wElementsInit then return end
    self._wElementsInit = true

    if CLIENT then
        for name, elem in pairs(self.WorldModelElements) do
            -- Store default active state
            if elem._defaultActive == nil then
                elem._defaultActive = elem.active or false
            end

            if elem.type == "Model" and elem.model and elem.model ~= "" then
                elem._csModel = ClientsideModel(elem.model, RENDERGROUP_OPAQUE)
                if IsValid(elem._csModel) then
                    elem._csModel:SetNoDraw(true)

                    if elem.skin then elem._csModel:SetSkin(elem.skin) end
                    if elem.bodygroups then
                        for bg, val in pairs(elem.bodygroups) do
                            elem._csModel:SetBodygroup(bg, val)
                        end
                    end
                    if elem.material and elem.material ~= "" then
                        elem._csModel:SetMaterial(elem.material)
                    end
                end
            end
        end
    end
end

-- ============================================================
-- DRAW — render all active WElements on the world model
-- ============================================================
function SWEP:DrawWElements(owner)
    if not self.WorldModelElements then return end
    if not self._wElementsInit then self:InitWElements() end

    if not IsValid(owner) then return end

    local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand")
    if not boneid then return end

    local matrix = owner:GetBoneMatrix(boneid)
    if not matrix then return end

    local handPos = matrix:GetTranslation()
    local handAng = matrix:GetAngles()

    for name, elem in pairs(self.WorldModelElements) do
        if not elem.active then continue end

        if elem.type == "Model" and IsValid(elem._csModel) then
            local model = elem._csModel

            -- Position offset from hand bone
            local pos = handPos
            if elem.pos then
                pos = pos + handAng:Right()   * elem.pos.x
                pos = pos + handAng:Forward() * elem.pos.y
                pos = pos + handAng:Up()      * elem.pos.z
            end

            -- Angle offset from hand bone
            local ang = Angle(handAng)
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

            model:DrawModel()
        end
    end
end

-- ============================================================
-- CLEANUP — remove all world ClientsideModels
-- ============================================================
function SWEP:CleanupWElements()
    if not self.WorldModelElements then return end

    for name, elem in pairs(self.WorldModelElements) do
        if IsValid(elem._csModel) then
            elem._csModel:Remove()
            elem._csModel = nil
        end
    end

    self._wElementsInit = false
end
