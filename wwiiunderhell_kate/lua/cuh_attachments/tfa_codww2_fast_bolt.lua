if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Fast Bolts"
ATTACHMENT.ShortName = "FAST"
ATTACHMENT.Icon = "entities/tfa_codww2_fast_bolt.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Fast Bolts",
        Color(100, 255, 100), "+40% Fire Rate",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Delay"] = function(wep, val) return val * 0.6 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
