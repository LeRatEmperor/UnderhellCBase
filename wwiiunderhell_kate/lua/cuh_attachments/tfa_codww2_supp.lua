if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Suppressor"
ATTACHMENT.ShortName = "SUPP"
ATTACHMENT.Icon = "entities/tfa_codww2_supp.png"
ATTACHMENT.Description = {
    Color(100, 255, 100), "Reduced Sound",
    Color(100, 255, 100), "Stealth Fire",
    Color(255, 100, 100), "No Muzzle Flash",
}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
        ["suppressor"] = { ["active"] = true },
    },
    ["WElements"] = {
        ["suppressor"] = { ["active"] = true },
    },
}

function ATTACHMENT:Attach(wep)
    -- Enable the Underhell native silencer system
    wep.HasSilencer = true
    wep:SetNWBool("Silenced", true)
end

function ATTACHMENT:Detach(wep)
    wep:SetNWBool("Silenced", false)
    wep.HasSilencer = false
end

-- CUH base handles registration
