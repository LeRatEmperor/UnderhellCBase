if not ATTACHMENT then ATTACHMENT = {} end

-- Suppressor
-- Bodygroup 1 = 2 (suppressor model on barrel)
-- Swaps the fire SOUND via stat cache (no SetNWBool needed)
-- Slight spread + IronAccuracy improvement
--
-- IMPORTANT: Does NOT use SetNWBool("Silenced") or the built-in
-- Underhell silencer system. Instead, it replaces Primary.Sound
-- with Primary.SilSound via the stat cache. When GetShootSound()
-- runs, it reads self.Primary.Sound (which is now SilSound) because
-- GetNWBool("Silenced") is false (we never set it).
--
-- This avoids the server-authoritative NW bool issue AND avoids
-- HandleBones overwriting bodygroup 1 (since GetNWBool("Silenced")
-- is never true, HandleBones sets bg[1]=0 which is correct —
-- the actual bodygroup override comes from Bodygroups_V[1]=2
-- applied by ApplyBodygroupsVM in DrawVElements).

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
        -- Swap the fire sound: replace Primary.Sound with Primary.SilSound.
        -- When GetShootSound runs, it checks GetNWBool("Silenced") (which is
        -- false since we don't set it), so it reads self.Primary.Sound —
        -- but Primary.Sound has been replaced with SilSound by the stat cache.
        -- When the suppressor is removed, RestoreStat reverts Primary.Sound
        -- to the original value. No SetNWBool needed, no Detach needed.
        ["Sound"] = function(wep, val) return wep.Primary.SilSound end,
    },
}

-- No Attach/Detach functions needed — everything is handled by the stat cache.
-- The stat cache properly reverts all changes when the attachment is removed.
