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

    -- CUH reads wep:GetNWBool("Silenced") in PrimaryAttack to:
    --   - choose Primary.SilSound vs Primary.Sound
    --   - append "_sil" to the animation lookup key
    -- ApplyAttachments Step 5 calls SetStat on each WeaponTable key, which
    -- for boolean values just sets wep[<key>] = true. But "Silenced" is checked
    -- via GetNWBool (a network var), not via self.Silenced, so the WeaponTable
    -- entry alone doesn't work. We need an Attach() side-effect.
    -- The CUH base restores _defaultSnapshot when attachments are removed,
    -- but SetNWBool isn't part of the snapshot. This means once silenced,
    -- the weapon stays silenced until re-deploy. Known limitation.
}

function ATTACHMENT:Attach(wep)
    wep:SetNWBool("Silenced", true)
end

-- Detach is NEVER CALLED by the CUH base (see cuh_base_analysis.md §7.2)
-- To un-silence: select "None" in the muzzle slot, then re-deploy the weapon.
function ATTACHMENT:Detach(wep)
    wep:SetNWBool("Silenced", false)
end
