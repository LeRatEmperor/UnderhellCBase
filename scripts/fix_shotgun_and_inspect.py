#!/usr/bin/env python3
"""
Comprehensive fix for M36, Winchester 94, and the T key error.

Based on the study of BO3 KRM-262 reference:
1. Fix lever-action/shotgun reload to use KRM-262 pattern:
   - Reload() only STARTS the reload (no inline loop)
   - ReloadShotgun() uses timer-based shell insertion (not cycle-based)
   - Add SetupAnimSounds calls after every EasySendWeaponAnim
   - Use consistent keys: start_reload, reload_loop, after_reload
2. Fix M36 AnimSounds to use the correct keys matching the Animations table
3. Fix duplicate shoot_last key in Animations
4. Fix inspect (E+R) — ensure all weapons have HandleInspect
5. Fix T key error — the GetStatL stub may not be enough; check if TFA
   hooks are running on CUH weapons and block them
"""
import os
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"


def fix_shotgun_weapon(filepath, weapon_prefix):
    """Fix a shotgun weapon using the KRM-262 pattern."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # 1. Remove duplicate shoot_last key
    # Pattern: ["shoot_last"] = "fire_last",\n... ["shoot_last"] = "ACT_VM_PRIMARYATTACK",
    # Keep only the first one
    content = re.sub(
        r'    \["shoot_last"\]\s*=\s*"fire_last",\n(.*?)    \["shoot_last"\]\s*=\s*"ACT_VM_PRIMARYATTACK",\n',
        r'    ["shoot_last"] = "fire_last",\n\1',
        content,
        count=1,
        flags=re.DOTALL
    )

    # 2. Replace the conflicting Reload() with the KRM-262 pattern (start-only, no loop)
    new_reload = '''function SWEP:Reload()
    if self._mantleActive then return end
    if self._meleeActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    local ct = CurTime()
    if self.NextReload >= ct then return end
    if self:GetUHBool("Reloading") then return end
    if self:GetUHBool("Running") then return end
    if self.Owner:GetNWFloat("GrenadeTime", 0) > ct then return end
    if self:GetNWFloat("DeployTime", 0) > ct then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then return end
    if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
    self.Owner:SetAnimation(PLAYER_RELOAD)
    self.NextReload = ct + 0.5
    -- Play start reload animation + sounds
    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)
    self:SetupAnimSounds("start_reload")
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5
    -- Timer-based shell insertion (KRM-262 pattern)
    self._krm_nextShell = ct + startDur
    self.reloaddelay = self._krm_nextShell
    self:SetNextPrimaryFire(ct + startDur + 0.1)
    self:SetNextSecondaryFire(ct + startDur + 0.1)
    self.NextReload = ct + startDur + 0.1
    self:SetUHBool("Reloading", true)
    self:SetUHBool("Zooming", false)
    local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
    local amount = num * (self.Primary.ReloadTime or 0.5)
    self:SetNWFloat("ReloadTime", amount)
    self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
end'''

    # Find and replace the existing Reload() function
    reload_pattern = re.compile(r'function SWEP:Reload\(\).*?\nend\n', re.DOTALL)
    m = reload_pattern.search(content)
    if m:
        content = content[:m.start()] + new_reload + '\n' + content[m.end():]
        changes.append('replaced Reload with KRM pattern')

    # 3. Replace ReloadShotgun with the KRM-262 timer-based pattern
    new_reload_shotgun = '''function SWEP:ReloadShotgun(ct)
    if not self:GetUHBool("Reloading") then return end
    -- STOP conditions: clip full, no reserve, or fire pressed
    if self:Clip1() >= self.Primary.ClipSize
        or self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0
        or self.Owner:KeyPressed(IN_ATTACK) then
        self:ClearAnimSounds()
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)
        self:SetupAnimSounds("after_reload")
        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
        local endDur = IsValid(vm) and vm:SequenceDuration() or 0.8
        self:SetUHBool("Reloading", false)
        self:SetNWFloat("ReloadTime", 0)
        self:SetNWFloat("ReloadEndTime", 0)
        self:SetNextPrimaryFire(ct + endDur)
        self:SetNextSecondaryFire(ct + endDur)
        self.NextReload = ct + endDur
        self._krm_nextShell = nil
        self.reloaddelay = nil
        if self.PostReload then self:PostReload() end
        return
    end
    -- TIMER-BASED shell insertion (KRM-262 pattern)
    if self._krm_nextShell and ct >= self._krm_nextShell then
        local shellInterval = self.Primary.ReloadTime or 0.5
        self._krm_nextShell = ct + shellInterval
        self:EasySendWeaponAnim("reload_loop", ACT_VM_RELOAD)
        self:SetupAnimSounds("reload_loop")
        if SERVER then
            self:SetClip1(self:Clip1() + 1)
            self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
        end
    end
end'''

    shotgun_pattern = re.compile(r'function SWEP:ReloadShotgun\(ct\).*?\nend\n', re.DOTALL)
    m = shotgun_pattern.search(content)
    if m:
        content = content[:m.start()] + new_reload_shotgun + '\n' + content[m.end():]
        changes.append('replaced ReloadShotgun with timer-based pattern')

    # 4. Add start_reload, reload_loop, after_reload to AnimSounds if missing
    # These should match the TFA EventTable sounds
    tfa_sounds = {
        'MAS36': {
            'start_reload': [(0.0333, 'TFA_CODWW2_MAS36.Open'), (1.0, 'TFA_CODWW2_MAS36.Insert')],
            'reload_loop': [(0.0333, 'TFA_CODWW2_MAS36.Insert')],
            'after_reload': [(0.0333, 'TFA_CODWW2_MAS36.Close')],
        },
        'LEVER': {
            'start_reload': [(0.0333, 'TFA_CODWW2_LEVER.Start')],
            'reload_loop': [(0.0333, 'TFA_CODWW2_LEVER.Insert')],
            'after_reload': [(0.1667, 'TFA_CODWW2_LEVER.Charge')],
        },
        'M1897': {
            'start_reload': [(0.0333, 'TFA_CODWW2_M1897.ADSFoley'), (0.0333, 'TFA_CODWW2_M1897.ShellStart'), (1.0, 'TFA_CODWW2_M1897.ShellIn')],
            'reload_loop': [(0.0333, 'TFA_CODWW2_M1897.ShellIn')],
            'after_reload': [(0.0333, 'TFA_CODWW2_M1897.EndStart'), (0.3333, 'TFA_CODWW2_M1897.EndPump')],
        },
        'M1879': {
            'start_reload': [(0.0333, 'TFA_CODWW2_M1879.Open')],
            'reload_loop': [(0.0333, 'TFA_CODWW2_M1879.Insert')],
            'after_reload': [(0.0333, 'TFA_CODWW2_M1879.Close')],
        },
    }

    sounds = tfa_sounds.get(weapon_prefix)
    if sounds:
        # Find the AnimSounds table and add the missing keys
        # Check which keys are already present
        for key, entries in sounds.items():
            if f'["{key}"]' not in content.split('SWEP.AnimSounds')[1].split('}')[0] if 'SWEP.AnimSounds' in content else '':
                # Add the key to AnimSounds
                lines = [f'    ["{key}"] = {{']
                for time, snd in entries:
                    lines.append(f'        {{ time = {time:.4f}, sound = "{snd}" }},')
                lines.append('    },')
                entry = '\n'.join(lines)
                # Insert before the closing } of AnimSounds
                content = content.replace(
                    '\n}\n\n-- ',  # the closing brace of AnimSounds
                    '\n' + entry + '\n}\n\n-- ',
                    1
                )
                changes.append(f'added AnimSounds["{key}"]')

    # 5. Add SetupAnimSounds calls to PostShoot (for rechamber sounds)
    # The PostShoot calls EasySendWeaponAnim but doesn't call SetupAnimSounds
    if 'self:SetupAnimSounds(animKey)' not in content:
        content = content.replace(
            'self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)',
            'self:EasySendWeaponAnim(animKey, ACT_SHOTGUN_PUMP)\n        self:SetupAnimSounds(animKey)',
            1
        )
        changes.append('added SetupAnimSounds to PostShoot')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def fix_inspect_support(filepath):
    """Ensure the weapon has HandleInspect and it works with E+R."""
    with open(filepath) as f:
        content = f.read()

    changes = []

    # Check if HandleInspect exists
    if 'function SWEP:HandleInspect' not in content:
        # Add HandleInspect function
        handle_inspect = '''
function SWEP:HandleInspect()
    local ply = self:GetOwner()
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) then
        if not self:GetUHBool("Reloading") and not self:GetUHBool("Running") then
            if not self:GetNW2Bool("Inspecting") then
                self:SetNW2Bool("Inspecting", true)
                self:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
                self:SetupAnimSounds("inspect")
            end
        end
    elseif self:GetNW2Bool("Inspecting") then
        -- Clear inspecting when E+R released
        self:SetNW2Bool("Inspecting", false)
    end
end
'''
        # Insert before the Think function
        think_match = re.search(r'function SWEP:Think\(\)', content)
        if think_match:
            content = content[:think_match.start()] + handle_inspect + '\n' + content[think_match.start():]
            changes.append('added HandleInspect')
        else:
            content = content.rstrip() + '\n' + handle_inspect
            changes.append('added HandleInspect')

    # Ensure HandleInspect is called from Think
    if 'self:HandleInspect()' not in content:
        # Add to Think after BaseClass.Think
        content = content.replace(
            'BaseClass.Think(self)\n',
            'BaseClass.Think(self)\n    self:HandleInspect()\n',
            1
        )
        changes.append('added HandleInspect call to Think')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)
    return changes


def main():
    print("=== Fixing shotgun weapons (M36, Winchester 94, Model1897, M1879) ===\n")

    shotgun_fixes = {
        'uh_codww2_mas36.lua': 'MAS36',
        'uh_codww2_winchester94.lua': 'LEVER',
        'uh_codww2_model1897.lua': 'M1897',
        'uh_codww2_m1879.lua': 'M1879',
    }

    for fname, prefix in shotgun_fixes.items():
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        if not os.path.exists(filepath):
            print(f"  WARNING: {fname} not found")
            continue
        changes = fix_shotgun_weapon(filepath, prefix)
        if changes:
            print(f"  {fname}: {', '.join(changes)}")
        else:
            print(f"  {fname}: no changes needed")

    print("\n=== Fixing inspect (E+R) on all weapons ===\n")

    # Check all weapons for HandleInspect
    no_inspect = []
    for fname in sorted(os.listdir(WWII_WEAPONS_DIR)):
        if not fname.startswith('uh_codww2_') or not fname.endswith('.lua'):
            continue
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        with open(filepath) as f:
            content = f.read()
        if 'function SWEP:HandleInspect' not in content:
            no_inspect.append(fname)

    if no_inspect:
        print(f"  Weapons MISSING HandleInspect ({len(no_inspect)}):")
        for f in no_inspect:
            print(f"    - {f}")
        # Fix them
        for fname in no_inspect:
            filepath = os.path.join(WWII_WEAPONS_DIR, fname)
            changes = fix_inspect_support(filepath)
            if changes:
                print(f"  Fixed {fname}: {', '.join(changes)}")
    else:
        print("  All weapons have HandleInspect")

    # Also check that HandleInspect is called from Think
    print("\n=== Checking HandleInspect call in Think ===")
    no_call = []
    for fname in sorted(os.listdir(WWII_WEAPONS_DIR)):
        if not fname.startswith('uh_codww2_') or not fname.endswith('.lua'):
            continue
        filepath = os.path.join(WWII_WEAPONS_DIR, fname)
        with open(filepath) as f:
            content = f.read()
        if 'function SWEP:HandleInspect' in content and 'self:HandleInspect()' not in content:
            no_call.append(fname)
    if no_call:
        print(f"  Weapons with HandleInspect but no call in Think ({len(no_call)}):")
        for f in no_call:
            changes = fix_inspect_support(os.path.join(WWII_WEAPONS_DIR, f))
            if changes:
                print(f"  Fixed {f}: {', '.join(changes)}")
    else:
        print("  All weapons call HandleInspect from Think")


if __name__ == '__main__':
    main()
