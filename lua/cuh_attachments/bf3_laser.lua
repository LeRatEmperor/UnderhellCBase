if not ATTACHMENT then ATTACHMENT = {} end

-- Laser sight
-- Bodygroup 3 = 1 (laser housing on the weapon)
-- Toggles the VElement["laser"] and ["laser_beam"] models' active flag

ATTACHMENT.Name = "Laser"
ATTACHMENT.Icon = "bf3/laser.png"
ATTACHMENT.ShortName = "LASER"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Visible laser",
    Color(255, 255, 255), "Bodygroup + VElement visibility only",
    Color(255, 255, 255), "(Pilot port: no actual laser beam drawn)",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    -- Activate the VElement models (set their "active" flag to true)
    -- CUH's ApplyAttachments Step 5 merges per-key into SWEP.ViewModelElements[name]
    ["VElements"] = {
        ["laser"] = { ["active"] = true },
        ["laser_beam"] = { ["active"] = true },
    },

    ["Bodygroups_V"] = { [3] = 1 },
    ["Bodygroups_W"] = { [3] = 1 },

    -- Drop LaserSightAttachment/LaserModAttachmentWorld (CUH has no laser beam system)
}
