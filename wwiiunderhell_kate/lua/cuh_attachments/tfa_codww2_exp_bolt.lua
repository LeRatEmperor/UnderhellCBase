if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Explosive Bolts"
ATTACHMENT.ShortName = "EXP"
ATTACHMENT.Icon = "entities/tfa_codww2_exp_bolt.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Explosive Bolts",
        Color(100, 255, 100), "+50% Damage",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.5 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
