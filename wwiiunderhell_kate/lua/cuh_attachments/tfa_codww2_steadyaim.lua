if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Steady Aim"
ATTACHMENT.ShortName = "STDY"
ATTACHMENT.Icon = "entities/tfa_codww2_steadyaim.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Steady Aim",
        Color(100, 255, 100), "-25% Spread",
        Color(100, 255, 100), "-20% Spread Max",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Spread"] = function(wep, val) return val * 0.75 end,
                ["SpreadMultiplierMax"] = function(wep, val) return val * 0.8 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
