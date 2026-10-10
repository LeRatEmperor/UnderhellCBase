if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Quickdraw Stock"
ATTACHMENT.ShortName = "QD"
ATTACHMENT.Icon = "entities/tfa_codww2_quickdraw.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Quickdraw Stock",
        Color(100, 255, 100), "+30% ADS Speed",
}

ATTACHMENT.WeaponTable = {
        ["IronSightTime"] = function(wep, val) return val * 0.7 end,
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
