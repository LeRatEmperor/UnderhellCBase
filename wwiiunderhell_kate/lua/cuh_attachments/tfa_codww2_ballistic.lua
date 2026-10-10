if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Ballistic Rounds"
ATTACHMENT.ShortName = "BALL"
ATTACHMENT.Icon = "entities/tfa_codww2_ballistic.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Ballistic Rounds",
        Color(100, 255, 100), "+30% Damage",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.3 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
