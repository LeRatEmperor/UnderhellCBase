if not ATTACHMENT then ATTACHMENT = {} end

-- Suppressor
-- Bodygroup 1 = 2
-- Slight spread + IronAccuracy improvement, silenced fire sound + animation

ATTACHMENT.Name = "Suppressor"
ATTACHMENT.Icon = "bf3/suppressor.png"
ATTACHMENT.ShortName = "SUPPRESSOR"

ATTACHMENT.Description = {
    Color(100, 255, 100), "Silenced fire",
    Color(100, 255, 100), "-10% spread",
    Color(100, 255, 100), "-10% ADS spread",
}

ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = { [1] = 2 },
    ["Bodygroups_W"] = { [1] = 2 },

    ["Primary"] = {
        ["Spread"] = function(wep, stat) return stat * 0.9 end,
        ["IronAccuracy"] = function(wep, stat) return stat * 0.9 end,
    },

    -- Set Silenced = true via the stat cache so both client and server
    -- agree. The CUH base's PrimaryAttack checks self:GetNWBool("Silenced")
    -- for sound/animation selection. We set BOTH the stat (self.Silenced)
    -- AND the NW bool (in Attach/Detach) so it works regardless of which
    -- code path reads it.
    ["Silenced"] = true,
}

function ATTACHMENT:Attach(wep)
    wep:SetNWBool("Silenced", true)
end

function ATTACHMENT:Detach(wep)
    wep:SetNWBool("Silenced", false)
end
