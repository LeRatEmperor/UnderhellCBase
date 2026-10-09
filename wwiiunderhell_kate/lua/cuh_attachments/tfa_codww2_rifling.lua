if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Rifled Barrel"
ATTACHMENT.ShortName = "RIFL"
ATTACHMENT.Icon = "entities/tfa_codww2_rifling.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Rifled Barrel",
        Color(100, 255, 100), "-20% Spread",
        Color(100, 255, 100), "+Accuracy",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Spread"] = function(wep, val) return val * 0.8 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
