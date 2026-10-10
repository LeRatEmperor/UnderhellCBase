#!/usr/bin/env python3
"""
Fix RT scopes: use CustomThink to re-apply SetSubMaterial EVERY FRAME.

The problem: ApplyAttachments Stage 6 (CleanupVElements + InitVElements)
DESTROYS and REBUILDS the ClientsideModels AFTER Attach() runs.
So SetSubMaterial called in Attach() is applied to a model that gets
destroyed immediately. The new model has default materials (with the
TFA proxy).

Fix: instead of SetSubMaterial in Attach(), set a CustomThink function
that re-applies SetSubMaterial EVERY FRAME on the current ClientsideModel.
This ensures the override persists even after the model is rebuilt.
"""
import os

ATT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/cuh_attachments"

SCOPES = {
    'tfa_codww2_kar98k_scope.lua': {
        'name': 'Kar98k Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_arisaka_scope.lua': {
        'name': 'Arisaka Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_enfield_scope.lua': {
        'name': 'Enfield Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_mosin_scope.lua': {
        'name': 'Mosin Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_springfield_scope.lua': {
        'name': 'Springfield Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_scope.lua': {
        'name': '7x Scope', 'velement': 'scope_default', 'fov': 7, 'zoom': 15,
    },
    'tfa_codww2_4x.lua': {
        'name': '4x ACOG', 'velement': 'scope_acog', 'fov': 15, 'zoom': 25,
    },
}


def write_scope_attachment(filepath, config):
    name = config['name']
    velem = config['velement']
    fov = config['fov']
    zoom = config['zoom']

    content = f'''if not ATTACHMENT then ATTACHMENT = {{}} end

ATTACHMENT.Name = "{name}"
ATTACHMENT.ShortName = "SCOPE"
ATTACHMENT.Icon = "entities/tfa_codww2_scope.png"
ATTACHMENT.Description = {{
    Color(255, 255, 255), "{name}",
    Color(255, 100, 100), "+25% Zoom time",
}}

ATTACHMENT.WeaponTable = {{
    ["VElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["WElements"] = {{
        ["{velem}"] = {{ ["active"] = true }},
    }},
    ["ScopeFov"] = {fov},
    ["ZoomFov"] = {zoom},
    ["Sensitivity"] = 0.2,
    ["IronSightsPos"] = function(wep, val) return wep.IronSightsPos_7X or wep.IronSightsPos_ACOG or val end,
    ["IronSightsAng"] = function(wep, val) return wep.IronSightsAng_7X or wep.IronSightsAng_ACOG or val end,
}}

function ATTACHMENT:Attach(wep)
    wep.ScopeFov = {fov}
    wep.ZoomFov = {zoom}
    wep.ScopeDisabled = false
    wep.Sensitivity = 0.2
    wep.Use2DScope = false

    if CLIENT then
        -- Create a custom RT material with NO VMT = NO proxy block.
        -- The TFA_COD_Scope proxy in the WWII VMTs resets $basetexture
        -- every frame. Our custom material has no proxy, so SetTexture sticks.
        local matName = "kate_rt_scope_" .. wep:EntIndex()
        local mat = CreateMaterial(matName, "UnlitGeneric", {{
            ["$basetexture"] = "vgui/scope_lens",
            ["$model"] = "1",
            ["$translucent"] = "1",
        }})
        wep.ScopeTexture = mat
        wep._rtScopeMatName = matName
        wep._rtScopeVElement = "{velem}"
        wep._rtScopeSubMatIndex = nil  -- will be found on first Think

        -- Initialize RenderTarget
        if not wep.RenderTarget then
            local scale = ScrH() / 1080
            local quality = {{ 256, 512, 768, 1080 }}
            local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
            wep.RT_Size = quality[num] * scale
            wep.RenderTarget = GetRenderTarget("CustomUH_ScopeRT_" .. wep:EntIndex(), wep.RT_Size, wep.RT_Size, false)
        end

        -- CustomThink re-applies SetSubMaterial EVERY FRAME.
        -- This is necessary because ApplyAttachments Stage 6 destroys
        -- and rebuilds the ClientsideModels AFTER Attach() runs, so
        -- any SetSubMaterial called in Attach() is lost. By applying
        -- it every frame in CustomThink, the override persists.
        wep._rtScopePrevThink = wep.CustomThink
        wep.CustomThink = function(w, ct)
            -- Run any previous CustomThink
            if w._rtScopePrevThink then w._rtScopePrevThink(w, ct) end

            if not w._rtScopeMatName then return end
            if not w.ViewModelElements then return end
            local elem = w.ViewModelElements[w._rtScopeVElement]
            if not elem or not IsValid(elem._csModel) then return end
            local csModel = elem._csModel

            -- Find the lens sub-material index (only once, then cache it)
            if not w._rtScopeSubMatIndex then
                local mats = csModel:GetMaterials()
                if mats then
                    for i = 1, #mats do
                        local mn = string.lower(tostring(mats[i]))
                        if string.find(mn, "lens") or string.find(mn, "optic") or string.find(mn, "scope") then
                            w._rtScopeSubMatIndex = i - 1  -- 0-based
                            break
                        end
                    end
                end
                -- If not found by name, try index 0 (first material is often the lens)
                if not w._rtScopeSubMatIndex then
                    w._rtScopeSubMatIndex = 0
                end
            end

            -- Apply the sub-material override EVERY FRAME
            csModel:SetSubMaterial(w._rtScopeSubMatIndex, w._rtScopeMatName)
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
        -- Restore the original sub-material
        if wep._rtScopeSubMatIndex and wep._rtScopeVElement then
            if wep.ViewModelElements and wep.ViewModelElements[wep._rtScopeVElement] then
                local elem = wep.ViewModelElements[wep._rtScopeVElement]
                if IsValid(elem._csModel) then
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
    end
end

-- CUH base handles registration
'''
    with open(filepath, 'w') as f:
        f.write(content)


def main():
    print("=== Rewriting scope attachments with CustomThink SetSubMaterial ===\n")
    for filename, config in SCOPES.items():
        filepath = os.path.join(ATT_DIR, filename)
        write_scope_attachment(filepath, config)
        print(f"  {filename}: CustomThink re-applies SetSubMaterial every frame")


if __name__ == '__main__':
    main()
