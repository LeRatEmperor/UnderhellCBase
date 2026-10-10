-- cuh_rt_scope_render.lua
-- ============================================================
-- RT Scope rendering for CUH weapons.
--
-- PROBLEM:
--   The base (weapon_uh_base_gun.lua, line ~1241) has a RenderScene
--   hook that renders the scope view into the RenderTarget and sets
--   it as the basetexture of wep.ScopeTexture.  BUT the hook guard is:
--       string.find(wep.Base or "", "weapon_uh_base")
--   which matches "weapon_uh_base_gun" but NOT "weapon_cuh_base_gun"
--   (the substring "weapon_uh_base" is not in "weapon_cuh_base_gun").
--   So for ALL CUH-derived weapons, the base's RT pipeline is skipped.
--
-- FIX:
--   This file adds a parallel RenderScene hook that checks
--   wep.IsCUHWeapon (set on the CUH base) instead of string-matching
--   the Base class name.  It replicates the base's RT rendering logic.
--
--   We CANNOT modify the base file (user's own version), so this
--   autorun file is the correct place for the fix.
-- ============================================================

if SERVER then return end

-- Use the GMod default scope material as the "not zooming" lens texture.
-- This definitely exists (it's the crossbow scope texture).
-- The base tries to use Material("vgui/scope_lens") which doesn't exist
-- in standard GMod, causing the pink/black missing texture.
local DEFAULT_LENS_MAT = Material("gmod/scope")

-- Debug convar: set to 1 to print RT scope state every 60 frames.
CreateClientConVar("cuh_rt_scope_debug", "0", true, false,
    "Print RT scope debug info for CUH weapons (0=off, 1=on)")

local _dbgCounter = 0

hook.Add("RenderScene", "CUH_RTScope_RenderScene", function(origin, angles, fov)
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local wep = ply:GetActiveWeapon()
    if not IsValid(wep) then return end

    -- Only handle CUH weapons (the base's hook handles weapon_uh_base_* weapons)
    if not wep.IsCUHWeapon then return end

    -- Only act if a scope is attached
    if not wep.ScopeTexture then return end
    if not wep.RenderTarget then return end

    -- Optional debug logging (every 60 frames when enabled)
    if GetConVar("cuh_rt_scope_debug"):GetBool() then
        _dbgCounter = _dbgCounter + 1
        if _dbgCounter >= 60 then
            _dbgCounter = 0
            local zooming = wep.GetUHBool and wep:GetUHBool("Zooming") or false
            local scopeDisabled = wep.ScopeDisabled
            local scopeFov = wep.ScopeFov
            local rtSize = wep.RT_Size
            local matName = wep._rtScopeMatName
            local subMatIdx = wep._rtScopeSubMatIndex
            print(string.format(
                "[CUH RT] zooming=%s scopeDisabled=%s scopeFov=%s rtSize=%s matName=%s subMatIdx=%s",
                tostring(zooming), tostring(scopeDisabled), tostring(scopeFov),
                tostring(rtSize), tostring(matName), tostring(subMatIdx)
            ))
        end
    end

    -- Check zoom state (same check as the base)
    local isZooming = false
    if wep.GetUHBool then
        isZooming = wep:GetUHBool("Zooming") and not wep.ScopeDisabled
    end

    if isZooming then
        -- Render the scope view into the RenderTarget
        local size = wep.RT_Size or 512
        render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)

        local ang = ply:EyeAngles()
        local pos = ply:EyePos()

        render.RenderView({
            x = 0,
            y = 0,
            w = size,
            h = size,
            origin = pos,
            angles = ang,
            drawviewmodel = false,
            drawhud = false,
            dopostprocess = false,
            fov = wep.ScopeFov or 8,
        })

        render.PopRenderTarget()

        -- Set the RT as the basetexture of the scope material
        wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
    else
        -- When not zooming, show a static lens texture (not missing texture)
        local defaultTex = DEFAULT_LENS_MAT:GetTexture("$basetexture")
        if defaultTex then
            wep.ScopeTexture:SetTexture("$basetexture", defaultTex)
        end
    end
end)
