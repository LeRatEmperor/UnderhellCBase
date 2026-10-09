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
    -- Override the shoot sound to use the silenced variant.
    -- This replaces Primary.Sound at the stat-cache level, so
    -- GetShootSound() returns the silenced sound.
    -- We do NOT set the 'Silenced' NW bool — that would trigger
    -- the animation system's '_sil' suffix lookup which breaks
    -- WWII weapon animations (they don't have _sil sequence variants).
    ["Primary"] = {
        ["Sound"] = function(wep, val) return wep.Primary.SilSound or val end,
    },
    -- Flag for muzzle flash suppression. The weapon's DoMuzzleFlash
    -- checks this field instead of the NW 'Silenced' bool.
    ["SuppressedFlash"] = true,
}

function ATTACHMENT:Attach(wep)
    -- Set the non-networked flag for muzzle flash suppression.
    -- This does NOT trigger the animation swap system.
    wep.SuppressedFlash = true
end

function ATTACHMENT:Detach(wep)
    wep.SuppressedFlash = false
end

-- CUH base handles registration
