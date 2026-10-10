-- cuh_rt_scope_render.lua
-- ============================================================
-- RT Scope rendering for CUH weapons.
--
-- Handles:
--   1. Rendering the scope view into the RenderTarget
--   2. Compositing the reticle/overlay on top of the RT
--   3. Hiding the viewmodel (and VElements) during the RT render pass
--      so long barrels / suppressors don't clip into the scope view
-- ============================================================

if SERVER then return end

-- Use the GMod default scope material as the "not zooming" lens texture.
local DEFAULT_LENS_MAT = Material("gmod/scope")

-- Reticle overlay materials per scope type.
-- The WWII TFA scopes use scope_overlay materials. We try a list of
-- common paths and fall back to gmod/scope if none exist.
local RETICLE_CANDIDATES = {
    "gmod/scope",           -- GMod default crossbow scope (always exists)
    "scope/rifle",           -- common L4D/CS scope overlay
}

local function GetReticleMaterial(wep)
    -- Allow weapon to override the reticle path
    if wep.ScopeReticle and Material(wep.ScopeReticle):IsError() == false then
        return Material(wep.ScopeReticle)
    end
    -- Default: gmod/scope (crosshair reticle)
    return Material("gmod/scope")
end

-- Debug convar
CreateClientConVar("cuh_rt_scope_debug", "0", true, false,
    "Print RT scope debug info for CUH weapons (0=off, 1=on)")

local _dbgCounter = 0

-- ============================================================
-- Console command: cuh_rt_scope_dump
-- Dumps all RT scope state and all materials on the csModel.
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

    if wep.ScopeTexture then
        local tex = wep.ScopeTexture:GetTexture("$basetexture")
        print("\nScopeTexture basetexture: " .. tostring(tex))
        if tex then
            print("  name: " .. tostring(tex:GetName()))
        end
    end

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
-- RenderScene hook: render the scope view into the RT, composite
-- the reticle overlay, and set the RT as the basetexture.
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
        render.SetViewPort(0, 0, size, size)

        -- CRITICAL: Clear the RT before rendering. Without this, the RT
        -- may contain garbage from the previous frame.
        -- Note: render.Clear has a bug where it sets alpha incorrectly
        -- for surface draw calls on render targets. We work around this
        -- by using render.SetMaterial + render.DrawScreenQuadEx for the
        -- reticle instead of surface.* functions.
        render.Clear(0, 0, 0, 255, true, true)

        local ang = ply:EyeAngles()
        local pos = ply:EyePos()

        -- CRITICAL: Set the suppress flag so DrawVElements (overridden
        -- per-instance) skips drawing during the RT render pass.
        wep._rtScopeSuppressVElem = true

        -- Also temporarily move the viewmodel entity away so it doesn't
        -- clip into the RT view. drawviewmodel=false should hide it, but
        -- some GMod versions still draw it. We set the viewmodel's pos
        -- to a far-away location and restore after.
        local vm = ply:GetViewModel(0)
        local vmSavedPos, vmSavedAng
        if IsValid(vm) then
            vmSavedPos = vm:GetPos()
            vmSavedAng = vm:GetAngles()
            vm:SetPos(Vector(99999, 99999, 99999))
        end

        render.RenderView({
            x = 0, y = 0, w = size, h = size,
            origin = pos, angles = ang,
            drawviewmodel = false, drawhud = false,
            dopostprocess = false,
            fov = wep.ScopeFov or 8,
            -- Push the near clip plane forward to clip any weapon geometry
            -- that's very close to the camera.
            znear = 8,
        })

        -- Restore viewmodel position
        if IsValid(vm) and vmSavedPos then
            vm:SetPos(vmSavedPos)
            vm:SetAngles(vmSavedAng)
        end

        wep._rtScopeSuppressVElem = false

        -- ============================================================
        -- COMPOSITE RETICLE / OVERLAY ON TOP OF THE RT
        -- ============================================================
        -- Use cam.Start2D with surface functions for the reticle.
        -- The render.Clear bug with alpha only affects surface draw
        -- calls on render targets in some GMod versions. We use
        -- surface.DrawLine and surface.DrawRect which are simpler and
        -- more reliable than texture-based reticles.
        cam.Start2D()
            -- Draw crosshair reticle (simple lines, guaranteed to appear)
            surface.SetDrawColor(0, 0, 0, 255)
            local cx, cy = size / 2, size / 2
            -- Horizontal line
            surface.DrawRect(cx - size * 0.05, cy - 1, size * 0.1, 2)
            -- Vertical line
            surface.DrawRect(cx - 1, cy - size * 0.05, 2, size * 0.1)

            -- Draw the reticle texture on top (if available)
            local reticleMat = GetReticleMaterial(wep)
            if reticleMat and not reticleMat:IsError() then
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(reticleMat)
                surface.DrawTexturedRect(0, 0, size, size)
            end

            -- Draw scope tube vignette (black border)
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(0, 0, size * 0.15, size)
            surface.DrawRect(size * 0.85, 0, size * 0.15, size)
            surface.DrawRect(size * 0.15, 0, size * 0.70, size * 0.15)
            surface.DrawRect(size * 0.15, size * 0.85, size * 0.70, size * 0.15)
        cam.End2D()

        render.PopRenderTarget()
        render.SetViewPort(0, 0, ScrW(), ScrH())
        wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
    else
        local defaultTex = DEFAULT_LENS_MAT:GetTexture("$basetexture")
        if defaultTex then
            wep.ScopeTexture:SetTexture("$basetexture", defaultTex)
        end
    end
end)

-- ============================================================
-- Console command: cuh_ironsight_dump
-- Dumps the current ironsight state to verify overrides are applied.
-- ============================================================
concommand.Add("cuh_ironsight_dump", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end

    print("=== CUH Ironsight Dump ===")
    print("Weapon: " .. tostring(wep))
    print("Class:  " .. tostring(wep:GetClass()))

    print("\n-- Ironsight positions --")
    print("IronSightsPos (current):     " .. tostring(wep.IronSightsPos))
    print("IronSightsAng (current):     " .. tostring(wep.IronSightsAng))

    -- Check stat cache
    if wep._statCache then
        print("\n-- Stat cache --")
        print("Cache IronSightsPos: " .. tostring(wep._statCache["IronSightsPos"]))
        print("Cache IronSightsAng: " .. tostring(wep._statCache["IronSightsAng"]))
    else
        print("\n-- Stat cache NOT initialized --")
    end

    if wep._statOrigins then
        print("\n-- Stat origins (original values) --")
        print("Origin IronSightsPos: " .. tostring(wep._statOrigins["IronSightsPos"]))
        print("Origin IronSightsAng: " .. tostring(wep._statOrigins["IronSightsAng"]))
    end

    print("\n-- Scope-specific positions --")
    print("IronSightsPos_7X:  " .. tostring(wep.IronSightsPos_7X))
    print("IronSightsAng_7X:  " .. tostring(wep.IronSightsAng_7X))
    print("IronSightsPos_ACOG:" .. tostring(wep.IronSightsPos_ACOG))
    print("IronSightsAng_ACOG:" .. tostring(wep.IronSightsAng_ACOG))
    print("IronSightsPos_Lens:" .. tostring(wep.IronSightsPos_Lens))
    print("IronSightsAng_Lens:" .. tostring(wep.IronSightsAng_Lens))

    print("\n-- RT scope state --")
    print("ScopeTexture:      " .. tostring(wep.ScopeTexture))
    print("ScopeFov:          " .. tostring(wep.ScopeFov))
    print("_rtScopeVElement:  " .. tostring(wep._rtScopeVElement))
    print("_rtScopeSuppressVElem:" .. tostring(wep._rtScopeSuppressVElem))
    print("DrawVElements override:" .. tostring(wep._rtScopePrevDrawVE ~= nil))

    print("\n=== End Dump ===")
end)

-- ============================================================
-- Console command: cuh_adjust_acog
-- Lets you adjust the ACOG/Lens ironsight position in real-time.
-- Usage:
--   cuh_adjust_acog 0 0 0.5    -- add +0.5 to Z (move eye up)
--   cuh_adjust_acog -0.3 0 0   -- subtract 0.3 from X (move eye back)
--   cuh_adjust_acog reset      -- reset to default
--   cuh_adjust_acog save       -- print the SWEP.IronSightsPos_ACOG line to copy
-- ============================================================
concommand.Add("cuh_adjust_acog", function(ply, cmd, args)
    if not IsValid(ply) then return end
    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end

    if args[1] == "reset" then
        wep.IronSightsPos_ACOG = nil
        wep.IronSightsPos_Lens = nil
        if wep._statCache then
            wep._statCache["IronSightsPos"] = wep._statOrigins and wep._statOrigins["IronSightsPos"]
            wep.IronSightsPos = wep._statCache["IronSightsPos"]
        end
        print("[CUH] ACOG/Lens ironsight position reset to default")
        return
    end

    if args[1] == "save" then
        local pos = wep.IronSightsPos_ACOG or wep.IronSightsPos
        print("[CUH] Copy this line to the weapon file:")
        print(string.format("SWEP.IronSightsPos_ACOG = Vector(%s, %s, %s)",
            tostring(pos.x), tostring(pos.y), tostring(pos.z)))
        print("SWEP.IronSightsAng_ACOG = Vector(0, 0, 0)")
        return
    end

    -- Parse dx, dy, dz
    local dx = tonumber(args[1]) or 0
    local dy = tonumber(args[2]) or 0
    local dz = tonumber(args[3]) or 0

    -- Get the base position (default IronSightsPos or current ACOG)
    local base = wep.IronSightsPos
    if not base then
        print("[CUH] Weapon has no IronSightsPos")
        return
    end

    -- Apply the adjustment
    local new_pos = Vector(base.x + dx, base.y + dy, base.z + dz)
    wep.IronSightsPos_ACOG = new_pos
    wep.IronSightsPos_Lens = new_pos

    -- Also update the stat cache and the live SWEP field
    if wep._statCache then
        wep._statCache["IronSightsPos"] = new_pos
    end
    wep.IronSightsPos = new_pos

    print(string.format("[CUH] ACOG position set to: Vector(%s, %s, %s) (dx=%s, dy=%s, dz=%s)",
        tostring(new_pos.x), tostring(new_pos.y), tostring(new_pos.z),
        tostring(dx), tostring(dy), tostring(dz)))
end)
