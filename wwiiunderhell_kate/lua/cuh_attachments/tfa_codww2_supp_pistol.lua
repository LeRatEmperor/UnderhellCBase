if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Pistol Suppressor"
ATTACHMENT.ShortName = "P-SUPP"
ATTACHMENT.Icon = "entities/tfa_codww2_supp_pistol.png"
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
