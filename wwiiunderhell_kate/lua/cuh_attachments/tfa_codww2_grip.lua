if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Foregrip"
ATTACHMENT.ShortName = "GRIP"
ATTACHMENT.Icon = "entities/tfa_codww2_grip.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Foregrip",
        Color(100, 255, 100), "-15% Spread",
        Color(100, 255, 100), "-20% Recoil",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["grip"] = {
                        ["active"] = true,
                },
        },
        ["WElements"] = {
                ["grip"] = {
                        ["active"] = true,
                },
        },
        ["Primary"] = {
                ["Spread"] = function(wep, val) return val * 0.85 end,
                ["KickUp"] = function(wep, val) return val * 0.8 end,
                ["KickDown"] = function(wep, val) return val * 0.8 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
