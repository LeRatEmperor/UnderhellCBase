if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Tactical Stock"
ATTACHMENT.ShortName = "STK"
ATTACHMENT.Icon = "entities/tfa_codww2_stock.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Tactical Stock",
        Color(100, 255, 100), "-25% Recoil",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["stock"] = {
                        ["active"] = true,
                },
        },
        ["WElements"] = {
                ["stock"] = {
                        ["active"] = true,
                },
        },
        ["Primary"] = {
                ["KickUp"] = function(wep, val) return val * 0.75 end,
                ["KickDown"] = function(wep, val) return val * 0.75 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
