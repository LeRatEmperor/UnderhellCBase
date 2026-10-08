#!/usr/bin/env python3
"""
Improve bolt-action rechamber for sniper weapons:
- Replace DoRechamber() with a PostShoot() override (KRM-style)
- Use EasySendWeaponAnim to trigger AnimSounds
- Lock NextPrimaryFire for the bolt cycle time
- Remove the explicit DoRechamber call from PrimaryAttack (PostShoot is called by base)
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

# Bolt-action snipers + lever-action
BOLT_ACTION_WEAPONS = {
    'uh_codww2_arisaka.lua', 'uh_codww2_delisle.lua', 'uh_codww2_enfield.lua',
    'uh_codww2_kar98k.lua', 'uh_codww2_mosin.lua', 'uh_codww2_sdk.lua',
    'uh_codww2_springfield.lua', 'uh_codww2_wz35.lua', 'uh_codww2_winchester94.lua',
}


# Replace DoRechamber + add PostShoot override
RECHAMBER_BLOCK = '''
-- ============================================================
-- BOLT-ACTION RECHAMBER (KRM-style PostShoot override)
-- ============================================================
SWEP.PumpDelay = SWEP.PumpDelay or 0.8  -- bolt cycle time

function SWEP:PostShoot()
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.8
    -- Lock fire for at least pumpDelay (but never shorten a longer Primary.Delay)
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))
    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))
    timer.Simple(pumpDelay, function()
        if not IsValid(self) or not IsValid(self.Owner)
           or not IsValid(self.Owner:GetActiveWeapon())
           or self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        -- Use EasySendWeaponAnim so AnimSounds get triggered
        self:EasySendWeaponAnim(animKey, ACT_VM_PULLBACK_HIGH)
    end)
end
'''


def update_sniper_rechamber(filepath):
    with open(filepath) as f:
        content = f.read()
    changes = []

    # 1. Remove existing DoRechamber function (it bypasses EasySendWeaponAnim)
    # Match the DoRechamber function block (from "function SWEP:DoRechamber()" to its matching "end")
    do_rechamber_pattern = re.compile(
        r'-- =+\n-- RECHAMBER.*?\n-- =+\nfunction SWEP:DoRechamber\(\).*?\nend\n',
        re.DOTALL
    )
    new_content = do_rechamber_pattern.sub('', content, count=1)
    if new_content == content:
        # Try without the comment header
        do_rechamber_pattern2 = re.compile(
            r'function SWEP:DoRechamber\(\).*?\nend\n',
            re.DOTALL
        )
        new_content = do_rechamber_pattern2.sub('', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed old DoRechamber')

    # 2. Remove the explicit DoRechamber call from PrimaryAttack (PostShoot is auto-called by base)
    # Pattern: "if self:Clip1() > 0 or not self:GetUHBool(\"Reloading\") then\n        self:DoRechamber()\n    end"
    do_rechamber_call_pattern = re.compile(
        r'\s*-- Play rechamber after firing\s*\n\s*if self:Clip1\(\) > 0 or not self:GetUHBool\("Reloading"\) then\s*\n\s*self:DoRechamber\(\)\s*\n\s*end\s*\n',
        re.DOTALL
    )
    new_content = do_rechamber_call_pattern.sub('\n', content, count=1)
    if new_content != content:
        content = new_content
        changes.append('removed explicit DoRechamber call')

    # 3. Append the new PostShoot override at end of file
    if 'function SWEP:PostShoot' not in content:
        content = content.rstrip() + '\n\n' + RECHAMBER_BLOCK.strip() + '\n'
        changes.append('added PostShoot override')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)
    return changes


def main():
    print("=== Updating bolt-action sniper rechamber logic ===")
    for filename in BOLT_ACTION_WEAPONS:
        filepath = os.path.join(WWII_WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  WARNING: {filename} not found")
            continue
        changes = update_sniper_rechamber(filepath)
        if changes:
            print(f"  {filename}: {', '.join(changes)}")
        else:
            print(f"  {filename}: no changes needed")


if __name__ == '__main__':
    main()
