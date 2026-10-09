if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Magazine"
ATTACHMENT.ShortName = "XMAG"
ATTACHMENT.Icon = "entities/tfa_codww2_xmag.png"
ATTACHMENT.Description = {
        Color(100, 255, 100), "Extended Magazine",
        Color(100, 255, 100), "2x Magazine Capacity",
}

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
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
