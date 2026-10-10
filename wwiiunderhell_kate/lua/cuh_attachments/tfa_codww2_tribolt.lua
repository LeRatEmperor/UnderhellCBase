if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Triple Bolt"
ATTACHMENT.ShortName = "TRI"
ATTACHMENT.Icon = "entities/tfa_codww2_tribolt.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Triple Bolt",
        Color(100, 255, 100), "Fires 3 bolts",
        Color(255, 100, 100), "-40% Damage per bolt",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["NumberofShots"] = function(wep, val) return 3 end,
                ["Damage"] = function(wep, val) return val * 0.6 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
