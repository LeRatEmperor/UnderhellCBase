if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "High Caliber"
ATTACHMENT.ShortName = "HCAL"
ATTACHMENT.Icon = "entities/tfa_codww2_highcal.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "High Caliber",
        Color(100, 255, 100), "+25% Damage",
        Color(255, 100, 100), "+10% Spread",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.25 end,
                ["Spread"] = function(wep, val) return val * 1.1 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
