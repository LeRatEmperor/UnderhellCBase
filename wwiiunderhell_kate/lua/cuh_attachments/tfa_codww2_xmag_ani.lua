if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Magazine (Animated)"
ATTACHMENT.ShortName = "XMAG+"
ATTACHMENT.Icon = "entities/tfa_codww2_xmag.png"
ATTACHMENT.Description = {
        Color(100, 255, 100), "Extended Magazine (Animated)",
        Color(100, 255, 100), "2x Magazine Capacity",
}

-- Custom fields used by Attach/Detach to perform a model swap on the mag/clip
-- VElement (mirrors the XM4 animated xmag reference pattern).
ATTACHMENT.ModelPath = "models/weapons/tfa_codww2/mag_ext.mdl"
ATTACHMENT.PartClass = "clip"

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["ext_clip"] = {
                        ["active"] = true,
                },
                ["clip_default"] = {
                        ["active"] = false,
                },
        },
        ["WElements"] = {
                ["ext_clip"] = {
                        ["active"] = true,
                },
                ["clip_default"] = {
                        ["active"] = false,
                },
        },
        ["Primary"] = {
                ["ClipSize"] = function(wep, val) return val * 2 end,
        },
        ["Animations"] = {
                ["reload"] = {
                        ["type"] = 1,
                        ["value"] = "reload_ext",
                },
                ["reload_empty"] = {
                        ["type"] = 1,
                        ["value"] = "reload_ext_empty",
                },
        },
}

-- Returns the VElement name to swap ("mag" preferred, falls back to "clip_default").
local function GetMagElementName(wep)
        if wep.VElements then
                if wep.VElements["mag"] then return "mag" end
                if wep.VElements["clip_default"] then return "clip_default" end
                if wep.VElements["ext_clip"] then return "ext_clip" end
        end
        return nil
end

function ATTACHMENT:Attach(wep)
        local name = GetMagElementName(wep)
        if not name then return end
        local elem = wep.VElements[name]
        if not elem then return end
        -- Stash the original model so Detach can restore it.
        wep.VMagModelOld = wep.VMagModelOld or elem.model
        elem.model = self.ModelPath or elem.model
        -- Force the clientside model to rebuild with the new model string.
        if wep.InitVElements then wep:InitVElements() end
        if wep.InitWElements then wep:InitWElements() end
end

function ATTACHMENT:Detach(wep)
        local name = GetMagElementName(wep)
        if not name then return end
        local elem = wep.VElements[name]
        if not elem then return end
        if wep.VMagModelOld then
                elem.model = wep.VMagModelOld
                wep.VMagModelOld = nil
                if wep.InitVElements then wep:InitVElements() end
                if wep.InitWElements then wep:InitWElements() end
        end
end

-- TFA attachment registration removed (CUH base handles this)
