if not ATTACHMENT then
        ATTACHMENT = {}
end

ATTACHMENT.Name = "Suppressor"
ATTACHMENT.ShortName = "SUPP"
ATTACHMENT.Icon = "entities/tfa_codww2_supp.png"
ATTACHMENT.Description = {
        Color(255, 255, 255), "Suppressor",
        Color(100, 255, 100), "Reduced Sound",
        Color(100, 255, 100), "Stealth Fire",
}

ATTACHMENT.WeaponTable = {
        ["VElements"] = {
                ["suppressor"] = {
                        ["active"] = true,
                },
        },
        ["WElements"] = {
                ["suppressor"] = {
                        ["active"] = true,
                },
        },
        ["Primary"] = {
                ["Sound"] = function(wep, val) return wep.Primary.SilSound or val end,
        },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

-- TFA attachment registration removed (CUH base handles this)
