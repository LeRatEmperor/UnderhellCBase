if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Full Metal Jacket"
ATTACHMENT.ShortName = "FMJ"
ATTACHMENT.Icon = "entities/tfa_codww2_fmj.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Full Metal Jacket",
        Color(100, 255, 100), "+15% Damage",
        Color(100, 255, 100), "+Penetration",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.15 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
