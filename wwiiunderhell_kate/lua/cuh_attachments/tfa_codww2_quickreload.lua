if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Quick Reload"
ATTACHMENT.ShortName = "QR"
ATTACHMENT.Icon = "entities/tfa_codww2_quickreload.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Quick Reload",
        Color(100, 255, 100), "+25% Reload Speed",
}

ATTACHMENT.WeaponTable = {
        ["ReloadSpeed"] = function(wep, val) return val * 1.25 end,
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
