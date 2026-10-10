#!/usr/bin/env python3
"""
Add PrimaryAttack override with melee bash (E+M1) to weapons that lost it
when their shotgun reload code was stripped.

Also:
- Add rechamber + shotgun reload to Winchester 94 (lever action)
- Lower PumpDelay on sniper rifles (keep combat shotgun delay)
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

# Weapons that need PrimaryAttack + melee bash added
NEED_MELEE = [
    'uh_codww2_blunderbuss.lua',
    'uh_codww2_m30.lua',
    'uh_codww2_model21.lua',
    'uh_codww2_walther.lua',
]

# Standard PrimaryAttack override with melee bash
PRIMARY_ATTACK_WITH_MELEE = '''-- ============================================================
-- ATTACK
-- ============================================================
function SWEP:PrimaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then
        local ct = CurTime()
        if ct < (self._nextMelee or 0) then return end
        if self:GetUHBool("Reloading") then return end
        if self:GetNWFloat("DeployTime") > ct then return end
        if self:GetNWInt("FireMode") == 0 then return end
        if SERVER or IsFirstTimePredicted() then self:MeleeAttack() end
        return
    end
    BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
    if self._meleeActive then return end
    if self._mantleActive then return end
    return BaseClass.SecondaryAttack(self)
end

function SWEP:Reload()
    if self._meleeActive or self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    return BaseClass.Reload(self)
end
'''

# Weapons that need rechamber (bolt-action / lever-action snipers)
# Winchester 94 is lever-action — needs both rechamber AND shotgun reload
# It was previously in the "remove shotgun reload" list, but user now says it needs it

# Sniper rifles that need PumpDelay lowered
SNIPER_WEAPONS = {
    'uh_codww2_arisaka.lua',
    'uh_codww2_delisle.lua',
    'uh_codww2_enfield.lua',
    'uh_codww2_kar98k.lua',
    'uh_codww2_mosin.lua',
    'uh_codww2_sdk.lua',
    'uh_codww2_springfield.lua',
    'uh_codww2_wz35.lua',
}


def add_melee_to_weapon(filepath):
    """Add PrimaryAttack/SecondaryAttack/Reload overrides with melee bash."""
    with open(filepath) as f:
        content = f.read()

    if 'function SWEP:PrimaryAttack' in content:
        return False  # already has it

    # Find a good insertion point — after the Think function or at the end
    # Look for the HOLSTER/DEPLOY section
    insert_point = content.find('-- ============================================================\n-- HOLSTER / DEPLOY')
    if insert_point == -1:
        # Just append at end
        content = content.rstrip() + '\n\n' + PRIMARY_ATTACK_WITH_MELEE
    else:
        content = content[:insert_point] + PRIMARY_ATTACK_WITH_MELEE + '\n' + content[insert_point:]

    with open(filepath, 'w') as f:
        f.write(content)
    return True


def lower_sniper_pumpdelay(filepath):
    """Lower PumpDelay on sniper rifles from 0.8 to 0.5."""
    with open(filepath) as f:
        content = f.read()

    # The snipers use PostShoot override with PumpDelay
    old = 'SWEP.PumpDelay = SWEP.PumpDelay or 0.8'
    new = 'SWEP.PumpDelay = SWEP.PumpDelay or 0.5'
    if old in content:
        content = content.replace(old, new)
        with open(filepath, 'w') as f:
            f.write(content)
        return True

    # Also check for inline values
    old2 = 'local pumpDelay = self.PumpDelay or 0.8'
    new2 = 'local pumpDelay = self.PumpDelay or 0.5'
    if old2 in content:
        content = content.replace(old2, new2)
        with open(filepath, 'w') as f:
            f.write(content)
        return True

    return False


def add_winchester94_rechamber_and_shotgun_reload(filepath):
    """Add rechamber (PostShoot) and shotgun reload to Winchester 94 (lever action)."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # Add IsPump and PumpDelay if not present (for lever-action rechamber)
    if 'SWEP.IsPump' not in content:
        # Add after IsBoltAction
        content = re.sub(
            r'(SWEP\.IsBoltAction\s*=\s*\w+)',
            r'\1\nSWEP.IsPump = true\nSWEP.PumpDelay = 0.6  -- lever cycle time',
            content,
            count=1
        )
        changes.append('added IsPump/PumpDelay')

    # Add PostShoot override if not present
    if 'function SWEP:PostShoot' not in content:
        postshoot = '''
-- ============================================================
-- LEVER-ACTION RECHAMBER
-- ============================================================
function SWEP:PostShoot()
    if not self.IsPump then return end
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.6
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
end
'''
        content = content.rstrip() + '\n' + postshoot
        changes.append('added PostShoot')

    # Add shotgun reload if not present
    if 'function SWEP:ReloadShotgun' not in content:
        shotgun_block = '''
-- ============================================================
-- SHOTGUN SHELL-BY-SHELL RELOAD
-- ============================================================
SWEP.Shotgun = true
SWEP.ShellLoadTime = SWEP.ShellLoadTime or 0.5

function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then
        self:ClearAnimSounds()
        self:EasySendWeaponAnim("shotgun_reload_finish", ACT_SHOTGUN_RELOAD_FINISH)
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur
        self.reloaddelay = nil
        if self.PostReload then self:PostReload() end
        return
    end
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) and vm:GetCycle() >= 1 then
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
    end
end

-- CustomThink: dispatches ReloadShotgun every tick while reloading
SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
    end
end
'''
        content = content.rstrip() + '\n' + shotgun_block
        changes.append('added shotgun reload')

    # Add shotgun anim keys if not present
    if '"shotgun_reload_start"' not in content:
        content = content.replace(
            '    ["after_reload"]   = "reload_end",',
            '    ["after_reload"]   = "reload_end",\n    ["shotgun_reload_start"]  = "reload_start",\n    ["shotgun_reload_finish"] = "reload_end",',
            1
        )
        changes.append('added shotgun anim keys')

    # Replace the Reload() to be shotgun-style if it's currently standard
    # Check if Reload already calls BaseClass.Reload (standard) vs shotgun start
    if 'function SWEP:Reload()' in content:
        # Check if it's the standard reload (calls BaseClass.Reload)
        reload_match = re.search(r'function SWEP:Reload\(\).*?\nend', content, re.DOTALL)
        if reload_match and 'BaseClass.Reload' in reload_match.group(0):
            # Replace with shotgun-style reload
            new_reload = '''function SWEP:Reload()
    local ct = CurTime()
    if not IsValid(self.Owner) then return end
    if self:GetUHBool("Reloading") then return end
    if self.NextReload < ct and not self:GetUHBool("Running")
       and self:GetNWFloat("DeployTime") < ct then
        if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 and self:Clip1() < self.Primary.ClipSize then
            self.Owner:DoReloadEvent()
            self.NextReload = ct + 0.5
            self:EasySendWeaponAnim("shotgun_reload_start", ACT_SHOTGUN_RELOAD_START)
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5
            self:SetNextPrimaryFire(ct + startDur + 0.1)
            self:SetNextSecondaryFire(ct + startDur + 0.1)
            self.NextReload = ct + startDur + 0.1
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
        end
    end
end'''
            content = content[:reload_match.start()] + new_reload + content[reload_match.end():]
            changes.append('replaced Reload with shotgun start')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)
    return changes


def main():
    print("=== Adding melee bash to 4 weapons ===")
    for fname in NEED_MELEE:
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        if not os.path.exists(filepath):
            print(f"  WARNING: {fname} not found")
            continue
        if add_melee_to_weapon(filepath):
            print(f"  {fname}: added PrimaryAttack with melee bash")
        else:
            print(f"  {fname}: already has PrimaryAttack")

    print("\n=== Lowering PumpDelay on sniper rifles ===")
    for fname in SNIPER_WEAPONS:
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        if not os.path.exists(filepath):
            print(f"  WARNING: {fname} not found")
            continue
        if lower_sniper_pumpdelay(filepath):
            print(f"  {fname}: PumpDelay 0.8 → 0.5")
        else:
            print(f"  {fname}: no PumpDelay found to change")

    print("\n=== Adding rechamber + shotgun reload to Winchester 94 ===")
    filepath = os.path.join(WWII_WEAPONS_DIR, 'uh_codww2_winchester94.lua')
    if os.path.exists(filepath):
        changes = add_winchester94_rechamber_and_shotgun_reload(filepath)
        if changes:
            print(f"  uh_codww2_winchester94.lua: {', '.join(changes)}")
        else:
            print(f"  uh_codww2_winchester94.lua: no changes needed")


if __name__ == '__main__':
    main()
