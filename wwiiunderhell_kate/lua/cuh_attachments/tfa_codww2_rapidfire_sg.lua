if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Rapid Fire"
ATTACHMENT.ShortName = "RPM"
ATTACHMENT.Icon = "entities/tfa_codww2_rapidfire.png"
ATTACHMENT.Description = {
    Color(100, 255, 100), "Increased RPM",
    Color(255, 100, 100), "Shotgun variant",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Delay"] = function(wep, stat) return stat * 0.85 end,
    },
}

function ATTACHMENT:Attach(wep) end
function ATTACHMENT:Detach(wep) end

-- CUH base handles registration
