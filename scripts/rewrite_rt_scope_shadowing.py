#!/usr/bin/env python3
"""
Rewrite the RT scope attachment files to use MATERIAL SHADOWING
instead of SetSubMaterial.

OLD APPROACH (broken):
  - CreateMaterial with a unique name (e.g. "kate_rt_scope_35")
  - SetSubMaterial on the csModel every frame to use our material
  - PROBLEM: DrawVElements calls model:SetModel(elem.model) every
    frame BEFORE model:DrawModel(). SetModel resets all sub-material
    overrides, so our SetSubMaterial is wiped out before the lens
    is drawn.

NEW APPROACH (material shadowing):
  - In CustomThink, find the actual lens material path from
    csModel:GetMaterials()
  - Call CreateMaterial(lensPath, "UnlitGeneric", {...}) with the
    EXACT same name as the lens VMT. This creates a material that
    SHADOWS the VMT — the engine finds our material instead of the
    VMT when looking up by name.
  - Since our material has NO proxy (no TFA_COD_Scope proxy),
    SetTexture("$basetexture", RT) sticks permanently.
  - No SetSubMaterial needed — the model naturally uses the shadowed
    material because it has the same name.
  - The RenderScene hook (in cuh_rt_scope_render.lua) calls
    SetTexture every frame to update the basetexture to the RT.
"""

import os

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

FILES = {
    "tfa_codww2_mosin_scope.lua":      "scope_default",
    "tfa_codww2_arisaka_scope.lua":    "scope_default",
    "tfa_codww2_springfield_scope.lua":"scope_default",
    "tfa_codww2_kar98k_scope.lua":     "scope_default",
    "tfa_codww2_enfield_scope.lua":    "scope_default",
    "tfa_codww2_scope.lua":            "scope_default",
    "tfa_codww2_4x.lua":               "scope_acog",
}


def make_file(velem_name, scope_fov, zoom_fov, display_name):
    return f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{display_name}"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {{
    Color(255, 255, 255), "{display_name}",
    Color(255, 100, 100), "+25% Zoom time",
}}

ATTACHMENT.WeaponTable = {{
    ["VElements"] = {{
        ["{velem_name}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velem_name}"] = {{ ["active"] = true }},
    }},
    ["ScopeFov"] = {scope_fov},
    ["ZoomFov"] = {zoom_fov},
    ["Sensitivity"] = 0.2,
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = {scope_fov}
    wep.ZoomFov = {zoom_fov}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    if CLIENT then
        -- Initialize RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = {{ 256, 512, 768, 1080 }}
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- Create a placeholder ScopeTexture material. This will be REPLACED
        -- by the shadow material once we find the lens VMT path (in CustomThink).
        -- The RenderScene hook checks wep.ScopeTexture to decide whether to
        -- render the RT, so we need it set immediately.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {{
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        }})
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "{velem_name}"
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
                        local shadowMat = CreateMaterial(lensPath, "UnlitGeneric", {{
                            ["$basetexture"] = "gmod/scope",
                            ["$model"] = "1",
                            ["$translucent"] = "1",
                        }})
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
'''


def main():
    print(f"Rewriting {len(FILES)} RT scope attachment files...")
    for fname, velem in FILES.items():
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue

        # Determine FOV values
        if "4x" in fname:
            scope_fov, zoom_fov, display = 15, 25, "4x ACOG"
        elif "mosin" in fname:
            scope_fov, zoom_fov, display = 7, 15, "Mosin Scope"
        elif "arisaka" in fname:
            scope_fov, zoom_fov, display = 7, 15, "Arisaka Scope"
        elif "springfield" in fname:
            scope_fov, zoom_fov, display = 7, 15, "Springfield Scope"
        elif "kar98k" in fname:
            scope_fov, zoom_fov, display = 7, 15, "Kar98k Scope"
        elif "enfield" in fname:
            scope_fov, zoom_fov, display = 7, 15, "Enfield Scope"
        else:
            scope_fov, zoom_fov, display = 7, 15, "7x Scope"

        content = make_file(velem, scope_fov, zoom_fov, display)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"  REWROTE: {fname} (velem={velem})")
    print(f"\nDone.")


if __name__ == "__main__":
    main()
