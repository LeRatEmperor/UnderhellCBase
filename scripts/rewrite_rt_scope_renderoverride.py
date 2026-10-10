#!/usr/bin/env python3
"""
Rewrite RT scope attachment files to use RenderOverride approach.

WHY PREVIOUS APPROACHES FAILED:
  1. SetSubMaterial in CustomThink:
     - DrawVElements calls model:SetModel(elem.model) every frame
       BEFORE model:DrawModel()
     - SetModel resets all sub-material overrides
     - So our SetSubMaterial (called in Think, before rendering) was wiped

  2. Material Shadowing (CreateMaterial with VMT name):
     - CreateMaterial with the same name as the TFA lens VMT did NOT
       remove the TFA_COD_Scope proxy
     - The proxy still runs every frame, resetting $basetexture to
       vgui/scope_lens (overwriting our SetTexture call)
     - Confirmed by dump: basetexture was vgui/scope_lens, not gmod/scope

NEW APPROACH (RenderOverride):
  - Create a UNIQUE material name (no conflict with VMTs, no proxy)
  - In CustomThink, set csModel.RenderOverride to a function that:
      1. Calls SetSubMaterial with our RT material
      2. Temporarily nils RenderOverride
      3. Calls DrawModel (which now draws normally, WITH our sub-material)
      4. Restores RenderOverride
  - This injects SetSubMaterial at the EXACT right moment: AFTER
    DrawVElements' SetModel call, but BEFORE the actual draw.

LENS MATERIAL INDEX:
  The dump showed TWO lens candidates:
    [0] mtl_rus_nagant_optics_02
    [1] mtl_generic_optic_ads_lens  <-- THIS is the actual lens
  The TFA COD scope system uses "mtl_generic_optic_ads_lens" as the
  glass lens material. We now target index 1 (or search for it by name).
"""

import os

ATTACHMENTS_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

FILES = {
    "tfa_codww2_mosin_scope.lua":      ("scope_default", 7, 15, "Mosin Scope"),
    "tfa_codww2_arisaka_scope.lua":    ("scope_default", 7, 15, "Arisaka Scope"),
    "tfa_codww2_springfield_scope.lua":("scope_default", 7, 15, "Springfield Scope"),
    "tfa_codww2_kar98k_scope.lua":     ("scope_default", 7, 15, "Kar98k Scope"),
    "tfa_codww2_enfield_scope.lua":    ("scope_default", 7, 15, "Enfield Scope"),
    "tfa_codww2_scope.lua":            ("scope_default", 7, 15, "7x Scope"),
    "tfa_codww2_4x.lua":               ("scope_acog",   15, 25, "4x ACOG"),
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

        -- Create a UNIQUE RT material (name does NOT conflict with any VMT,
        -- so no TFA proxy can touch it). UnlitGeneric has no proxy support,
        -- so SetTexture sticks permanently.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {{
            ["$basetexture"] = "gmod/scope",
            ["$model"] = "1",
            ["$translucent"] = "1",
        }})
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "{velem_name}"
        wep._rtScopeSubMatIndex = nil  -- found in CustomThink
        wep._rtScopeOverrideSet = false  -- RenderOverride not yet installed

        -- Hook CustomThink to:
        --   1. Find the lens sub-material index on the csModel
        --   2. Install RenderOverride on the csModel
        -- This must run AFTER InitVElements creates the csModel.
        --
        -- CRITICAL: only hook once per weapon. Capture prevThink as LOCAL
        -- upvalue to prevent recursion.
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
                        -- Set the sub-material RIGHT BEFORE drawing
                        if w._rtScopeMatName then
                            self:SetSubMaterial(w._rtScopeSubMatIndex or 0, w._rtScopeMatName)
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
        wep._rtScopeOverrideSet = nil
    end
end

-- CUH base handles registration
'''


def main():
    print(f"Rewriting {len(FILES)} RT scope attachment files (RenderOverride approach)...")
    for fname, (velem, sfov, zfov, disp) in FILES.items():
        path = os.path.join(ATTACHMENTS_DIR, fname)
        if not os.path.exists(path):
            print(f"  MISSING: {fname}")
            continue
        content = make_file(velem, sfov, zfov, disp)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"  REWROTE: {fname}")
    print(f"\nDone.")


if __name__ == "__main__":
    main()
