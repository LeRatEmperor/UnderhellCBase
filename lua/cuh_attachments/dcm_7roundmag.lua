if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "7 Round Mag"
ATTACHMENT.ShortName = "MAG"
ATTACHMENT.Icon = "entities/7roundsmag.png"
ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.Description = {
    Color(100, 255, 100), "Faster reload animation",
    Color(255, 255, 255), "7-round magazine with extended reload",
}

-- The 7-round mag attachment changes the reload animations to the
-- "fast" variants (reload_fast, reload_empty_fast) which are shorter.
-- This matches the TRM source: weapon.Animations.Reload = Reload_Fast
ATTACHMENT.WeaponTable = {
    ["Animations"] = {
        ["reload"]       = "reload_fast",
        ["reload_empty"] = "reload_empty_fast",
    },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end
