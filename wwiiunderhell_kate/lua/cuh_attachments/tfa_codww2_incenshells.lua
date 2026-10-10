if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Incendiary Shells"
ATTACHMENT.ShortName = "INCEN"
ATTACHMENT.Icon = "entities/tfa_codww2_incenshells.png"
ATTACHMENT.Description = {
        Color(255, 150, 50), "Incendiary Shells",
        Color(100, 255, 100), "+20% Damage",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["shell_incen"] = {
                        ["active"] = true,
                },
                ["shell_default"] = {
                        ["active"] = false,
                },
        },
        ["WElements"] = {
                ["shell_incen"] = {
                        ["active"] = true,
                },
                ["shell_default"] = {
                        ["active"] = false,
                },
        },
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.2 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
