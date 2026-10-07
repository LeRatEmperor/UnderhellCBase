#!/usr/bin/env python3
"""
Update shotgun PostShoot to also lock fire for at least PumpDelay.
Currently it just plays the animation but doesn't prevent the player from firing
again before the pump completes.
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

SHOTGUN_WEAPONS = {
    'uh_codww2_model1897.lua', 'uh_codww2_m30.lua', 'uh_codww2_model21.lua',
    'uh_codww2_walther.lua', 'uh_codww2_blunderbuss.lua', 'uh_codww2_mas36.lua',
    'uh_codww2_winchester94.lua', 'uh_codww2_m1879.lua',
}

# New PostShoot that locks fire for PumpDelay
NEW_POSTSHOOT = '''function SWEP:PostShoot()
    if not self.IsPump then return end
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.5
    -- Lock fire for at least pumpDelay (but never shorten a longer Primary.Delay)
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))
    timer.Simple(pumpDelay, function()
        if not IsValid(self) or not IsValid(self.Owner)
           or not IsValid(self.Owner:GetActiveWeapon())
           or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)
    end)
end'''


def update_shotgun_postshoot(filepath):
    with open(filepath) as f:
        content = f.read()

    # Find and replace existing PostShoot function
    pattern = re.compile(
        r'function SWEP:PostShoot\(\).*?\nend\n',
        re.DOTALL
    )
    if not pattern.search(content):
        # No existing PostShoot — append new one
        content = content.rstrip() + '\n\n' + NEW_POSTSHOOT + '\n'
        with open(filepath, 'w') as f:
            f.write(content)
        return ['added PostShoot']

    new_content = pattern.sub(NEW_POSTSHOOT + '\n', content, count=1)
    if new_content != content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        return ['updated PostShoot with fire lock']
    return []


def main():
    print("=== Updating shotgun PostShoot to lock fire for PumpDelay ===")
    for filename in SHOTGUN_WEAPONS:
        filepath = os.path.join(WWII_WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            continue
        changes = update_shotgun_postshoot(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")


if __name__ == '__main__':
    main()
