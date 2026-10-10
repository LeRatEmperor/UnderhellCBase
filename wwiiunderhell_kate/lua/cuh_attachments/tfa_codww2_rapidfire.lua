if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Rapid Fire"
ATTACHMENT.ShortName = "RPM"
ATTACHMENT.Icon = "entities/tfa_codww2_rapidfire.png"
ATTACHMENT.Description = {
        Color(100, 255, 100), "Rapid Fire",
        Color(100, 255, 100), "+15% Fire Rate",
}

ATTACHMENT.WeaponTable = {
        ["Primary"] = {
                ["Delay"] = function(wep, val) return val * 0.85 end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
