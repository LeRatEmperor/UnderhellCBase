if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Rifle Rounds"
ATTACHMENT.ShortName = "RIFLE"
ATTACHMENT.Icon = "entities/tfa_codww2_riflebullet.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Rifle Rounds",
        Color(100, 255, 100), "+10% Damage",
        Color(100, 255, 100), "-10% Spread",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Damage"] = function(wep, val) return val * 1.1 end,
                ["Spread"] = function(wep, val) return val * 0.9 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
