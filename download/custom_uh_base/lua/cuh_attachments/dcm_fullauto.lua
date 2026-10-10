if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Full Auto"
ATTACHMENT.ShortName = "AUTO"
ATTACHMENT.Icon = "entities/fullauto.png"
ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.Description = {
    Color(100, 255, 100), "Full-automatic fire",
    Color(255, 100, 100), "Reduced accuracy",
}

-- The full-auto attachment makes the weapon fire automatically.
-- This matches the TRM source: weapon.Primary.Automatic = true
ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Automatic"] = true,
    },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end
