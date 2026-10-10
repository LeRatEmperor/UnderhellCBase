-- cuh_rt_scope_render.lua
-- ============================================================
-- RT Scope rendering for CUH weapons.
--
-- PROBLEM #1:
--   The base (weapon_uh_base_gun.lua, line ~1241) has a RenderScene
--   hook that renders the scope view into the RenderTarget and sets
--   it as the basetexture of wep.ScopeTexture.  BUT the hook guard is:
--       string.find(wep.Base or "", "weapon_uh_base")
--   which matches "weapon_uh_base_gun" but NOT "weapon_cuh_base_gun"
--   (the substring "weapon_uh_base" is not in "weapon_cuh_base_gun").
--   So for ALL CUH-derived weapons, the base's RT pipeline is skipped.
--
-- PROBLEM #2:
--   The SetSubMaterial approach in the attachment files doesn't work
--   because DrawVElements calls model:SetModel(elem.model) every frame
--   BEFORE model:DrawModel().  SetModel resets all sub-material
--   overrides, so our SetSubMaterial (called in CustomThink before
--   rendering) is wiped out before the lens is drawn.
--
-- SOLUTION:
--   Use MATERIAL SHADOWING instead of SetSubMaterial.  We find the
--   actual lens material path from the csModel, then call
--   CreateMaterial with that EXACT name.  This creates a new material
--   that SHADOWS the VMT — the engine finds our material instead of
--   the VMT when looking up by name.  Since our material has no proxy
--   (no TFA_COD_Scope proxy), SetTexture("$basetexture", RT) sticks.
--
--   We still need a RenderScene hook to render the scope view into the
--   RT and to set the basetexture every frame (same as the base does
--   for UH weapons).
-- ============================================================

if SERVER then return end

-- Use the GMod default scope material as the "not zooming" lens texture.
local DEFAULT_LENS_MAT = Material("gmod/scope")

-- Debug convar
CreateClientConVar("cuh_rt_scope_debug", "0", true, false,
    "Print RT scope debug info for CUH weapons (0=off, 1=on)")

local _dbgCounter = 0

-- ============================================================
-- Find the lens material path on the scope VElement csModel.
-- Returns: (materialPath, materialIndex) or (nil, nil)
-- ============================================================
local function FindLensMaterial(wep)
    if not wep.ViewModelElements then return nil, nil end
    if not wep._rtScopeVElement then return nil, nil end
    local elem = wep.ViewModelElements[wep._rtScopeVElement]
    if not elem or not IsValid(elem._csModel) then return nil, nil end
    local csModel = elem._csModel

    local mats = csModel:GetMaterials()
    if not mats or #mats == 0 then return nil, nil end

    -- Try to find by name first
    for i = 1, #mats do
        local mn = string.lower(tostring(mats[i]))
        if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
            return mats[i], i - 1  -- 0-based index
        end
    end

    -- Fallback: return all materials so we can log them for debugging
    return nil, nil, mats
end

-- ============================================================
-- Console command: cuh_rt_scope_dump
-- Dumps all RT scope state and all materials on the csModel.
-- Run this while holding a scoped CUH weapon.
-- ============================================================
concommand.Add("cuh_rt_scope_dump", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end

    print("=== CUH RT Scope Dump ===")
    print("Weapon: " .. tostring(wep))
    print("Class:  " .. tostring(wep:GetClass()))
    print("Base:   " .. tostring(wep.Base))
    print("IsCUH:  " .. tostring(wep.IsCUHWeapon))

    print("\n-- Scope state --")
    print("ScopeTexture:     " .. tostring(wep.ScopeTexture))
    print("RenderTarget:     " .. tostring(wep.RenderTarget))
    print("RT_Size:          " .. tostring(wep.RT_Size))
    print("ScopeFov:         " .. tostring(wep.ScopeFov))
    print("ScopeDisabled:    " .. tostring(wep.ScopeDisabled))
    print("_rtScopeMatName:  " .. tostring(wep._rtScopeMatName))
    print("_rtScopeVElement: " .. tostring(wep._rtScopeVElement))
    print("_rtScopeSubMatIdx:" .. tostring(wep._rtScopeSubMatIndex))
    print("_rtScopeHooked:   " .. tostring(wep._rtScopeHooked))
    print("CustomThink set:  " .. tostring(wep.CustomThink ~= nil))

    if wep.GetUHBool then
        print("Zooming:          " .. tostring(wep:GetUHBool("Zooming")))
    end

    -- ScopeTexture basetexture
    if wep.ScopeTexture then
        local tex = wep.ScopeTexture:GetTexture("$basetexture")
        print("\nScopeTexture basetexture: " .. tostring(tex))
        if tex then
            print("  name: " .. tostring(tex:GetName()))
        end
    end

    -- VElement csModel materials
    if wep.ViewModelElements and wep._rtScopeVElement then
        local elem = wep.ViewModelElements[wep._rtScopeVElement]
        print("\n-- VElement: " .. wep._rtScopeVElement .. " --")
        print("  active:  " .. tostring(elem and elem.active))
        print("  model:   " .. tostring(elem and elem.model))
        print("  _csModel:" .. tostring(elem and elem._csModel))
        if elem and IsValid(elem._csModel) then
            local csModel = elem._csModel
            local mats = csModel:GetMaterials()
            print("\n  -- csModel:GetMaterials() --")
            if mats and #mats > 0 then
                for i = 1, #mats do
                    local marker = ""
                    local mn = string.lower(tostring(mats[i]))
                    if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                        marker = " <-- LENS CANDIDATE"
                    end
                    print(string.format("  [%d] %s%s", i - 1, tostring(mats[i]), marker))
                end
            else
                print("  (no materials returned)")
            end

            -- Current sub-material at target index
            if wep._rtScopeSubMatIndex then
                local subMat = csModel:GetSubMaterial(wep._rtScopeSubMatIndex)
                print(string.format("\n  Current subMat[%d]: %s", wep._rtScopeSubMatIndex, tostring(subMat)))
            end
        end
    else
        print("\n(ViewModelElements or _rtScopeVElement not set)")
    end

    print("\n=== End Dump ===")
end)

-- ============================================================
-- RenderScene hook: render the scope view into the RT and set
-- it as the basetexture of the scope material.
-- ============================================================
hook.Add("RenderScene", "CUH_RTScope_RenderScene", function(origin, angles, fov)
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end

    if not wep.IsCUHWeapon then return end
    if not wep.ScopeTexture then return end
    if not wep.RenderTarget then return end

    -- Optional debug logging
    if GetConVar("cuh_rt_scope_debug"):GetBool() then
        _dbgCounter = _dbgCounter + 1
        if _dbgCounter >= 60 then
            _dbgCounter = 0
            local zooming = wep.GetUHBool and wep:GetUHBool("Zooming") or false
            print(string.format("[CUH RT] zooming=%s scopeFov=%s rtSize=%s matName=%s subMatIdx=%s",
                tostring(zooming), tostring(wep.ScopeFov), tostring(wep.RT_Size),
                tostring(wep._rtScopeMatName), tostring(wep._rtScopeSubMatIndex)))
        end
    end

    local isZooming = false
    if wep.GetUHBool then
        isZooming = wep:GetUHBool("Zooming") and not wep.ScopeDisabled
    end

    if isZooming then
        local size = wep.RT_Size or 512
        render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)

        local ang = ply:EyeAngles()
        local pos = ply:EyePos()

        render.RenderView({
            x = 0, y = 0, w = size, h = size,
            origin = pos, angles = ang,
            drawviewmodel = false, drawhud = false,
            dopostprocess = false,
            fov = wep.ScopeFov or 8,
        })

        render.PopRenderTarget()
        wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
    else
        local defaultTex = DEFAULT_LENS_MAT:GetTexture("$basetexture")
        if defaultTex then
            wep.ScopeTexture:SetTexture("$basetexture", defaultTex)
        end
    end
end)
