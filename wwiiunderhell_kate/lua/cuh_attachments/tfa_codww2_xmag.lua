if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Extended Mags"
ATTACHMENT.ShortName = "XMAG"
ATTACHMENT.Icon = "entities/tfa_codww2_xmag.png"
ATTACHMENT.Description = {
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
        ["Animations"] = {
                ["reload"] = "reload_ext",
                ["reload_empty"] = "reload_ext_empty",
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
