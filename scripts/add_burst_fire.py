#!/usr/bin/env python3
"""Add proper burst fire logic to pg1935 (ITRA Burst) and zk383."""
import re

WWII_WEAPONS_DIR = "/home/z/my-project/worldwarii_underhell/lua/weapons"

BURST_FIRE_REPLACEMENT = '''-- ============================================================
-- BURST FIRE LOGIC (modeled on BO3 M8A7)
-- ============================================================
SWEP.BurstCount = SWEP.BurstFireCount or 3
SWEP.BurstDelay = SWEP.BurstDelay or 0.075

SWEP.FireModes = {
    {
        name = "Burst",
        shoot = function(ply, wep)
            -- Don't start a new burst if one is in flight
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end
            wep._burstRemaining = wep.BurstCount
            wep._burstDelay = wep.BurstDelay
            wep:FireBurstRound()
            return true
        end
    },
    { name = "Semi-Auto" }
}'''

BURST_FUNCTIONS = '''
-- ============================================================
-- BURST FIRE LOGIC
-- ============================================================
function SWEP:FireBurstRound()
    if not IsValid(self) or not IsValid(self.Owner) then return end
    if not self:CanPrimaryAttack() then
        self._burstRemaining = nil
        return
    end
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    -- Bullets
    if SERVER or iftp then
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)
        if self:GetNWBool("Silenced") then dmg = math.Round(dmg * 0.95) end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end

    -- Recoil
    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
        * (self:GetUHBool("Zooming") and 0.35 or 1)
    if sp or (CLIENT and iftp) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + 0.14)
        if not self.NoShell then self:CreateShell(self.ShellDelay or 0, self.ShellHeat) end
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))
    end
    self.Owner:ViewPunch(Angle(recoil, 0, 0))

    -- Animation
    local shootAnim = self:ShootAnimation()
    if type(shootAnim) == "string" then
        self:EasySendWeaponAnim(shootAnim, ACT_VM_PRIMARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:MuzzleFlash()

    local fireSound = self:GetShootSound()
    self:EmitSound(fireSound, 110, 100, 1, CHAN_WEAPON)
    self:TakePrimaryAmmo(self.Primary.TakeAmmo)
    self.NextReload = CurTime() + 0.5
    self:PostShoot()

    -- Burst timing
    if SERVER or iftp then
        self._burstRemaining = self._burstRemaining - 1
        if self._burstRemaining > 0 then
            self._burstNextFire = ct + self._burstDelay
            self:SetNextPrimaryFire(ct + self._burstDelay)
        else
            self._burstRemaining = nil
            self:SetNextPrimaryFire(ct + self.Primary.Delay * 3)
            self:SetNextSecondaryFire(ct + self.Primary.Delay * 3)
        end
    end
end

-- CustomThink: continues burst rounds even if player released M1
SWEP.CustomThink = function(self, ct)
    if self._burstRemaining and self._burstRemaining > 0 then
        if ct >= (self._burstNextFire or 0) then
            self:FireBurstRound()
        end
    end
end

-- Cancel burst on holster
local _origHolster = SWEP.Holster
function SWEP:Holster(wep)
    self._burstRemaining = nil
    self._burstNextFire = nil
    if _origHolster then return _origHolster(self, wep) end
    return true
end'''


def update_burst_weapon(filepath):
    with open(filepath) as f:
        content = f.read()

    changes = []

    # 1. Replace the simple FireModes block with the burst-fire FireModes
    if 'function SWEP:FireBurstRound' not in content:
        # Match the existing block: SWEP.FireModes = { ... } + BurstFireCount + BurstDelay + OnlyBurstFire + DisableBurstFire
        pattern = re.compile(
            r'SWEP\.FireModes\s*=\s*\{[^}]*\}\s*\}\s*\nSWEP\.BurstFireCount\s*=\s*\d+\s*\nSWEP\.BurstDelay\s*=\s*[\d\.]+\s*\nSWEP\.OnlyBurstFire\s*=\s*\w+\s*\nSWEP\.DisableBurstFire\s*=\s*\w+',
            re.DOTALL
        )
        new_content = pattern.sub(BURST_FIRE_REPLACEMENT, content, count=1)
        if new_content == content:
            # Try alternative pattern (some files might not have all 5 lines)
            pattern2 = re.compile(
                r'SWEP\.FireModes\s*=\s*\{\s*\n\s*\{ name = "Burst" \},\s*\n\s*\{ name = "Semi-Auto" \},\s*\n\s*\}\s*\nSWEP\.BurstFireCount\s*=\s*\d+\s*\nSWEP\.BurstDelay\s*=\s*[\d\.]+\s*\nSWEP\.OnlyBurstFire\s*=\s*\w+\s*\nSWEP\.DisableBurstFire\s*=\s*\w+',
                re.DOTALL
            )
            new_content = pattern2.sub(BURST_FIRE_REPLACEMENT, content, count=1)
        if new_content != content:
            content = new_content
            changes.append('replaced FireModes with burst-fire version')
        else:
            print(f"  WARNING: Could not match FireModes block in {filepath}")
            # Show what's there for debugging
            m = re.search(r'SWEP\.FireModes.*?SWEP\.DisableBurstFire.*?\n', content, re.DOTALL)
            if m:
                print(f"    Found block:\n{m.group(0)}")

    # 2. Add the FireBurstRound function + Think loop + Holster override at end of file
    if 'function SWEP:FireBurstRound' not in content:
        content = content.rstrip() + '\n\n' + BURST_FUNCTIONS.strip() + '\n'
        changes.append('added FireBurstRound + Think loop')

    if changes:
        with open(filepath, 'w') as f:
            f.write(content)
    return changes


def main():
    for filename in ['uh_codww2_pg1935.lua', 'uh_codww2_zk383.lua']:
        filepath = f"{WWII_WEAPONS_DIR}/{filename}"
        print(f"\n=== Processing {filename} ===")
        changes = update_burst_weapon(filepath)
        if changes:
            for c in changes:
                print(f"  - {c}")
        else:
            print("  no changes needed")


if __name__ == '__main__':
    main()
