#!/usr/bin/env python3
"""
Comprehensive WWII port fixer:
1. Removes duplicate PrimaryAttack/Reload function definitions
2. Adds shotgun reload dispatch via CustomThink
3. Replaces GetMuzzle() with auto-detect (tag_flash → tag_silencer → fallback)
4. Adds burst fire logic (FireModes.shoot + FireBurstRound + Think loop) to pg1935 and zk383
5. Populates AnimSounds for all weapons from original TFA EventTable
"""
import os
import re

WWII_DIR = "/home/z/my-project/worldwarii_underhell"
WEAPONS_DIR = os.path.join(WWII_DIR, "lua", "weapons")
ORIGINAL_TFA_DIR = "/tmp/wwii_port/weapons"


# ============================================================
# 1. REMOVE DUPLICATE PrimaryAttack/Reload FUNCTIONS
# ============================================================
def remove_duplicate_functions_simple(filepath):
    """Keep only the FIRST definition of each function. Uses simple line-based parsing."""
    with open(filepath) as f:
        lines = f.readlines()

    blocks = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = re.match(r'^function SWEP:(\w+)\(', line)
        if m:
            func_name = m.group(1)
            depth = 1
            j = i + 1
            while j < len(lines) and depth > 0:
                l = lines[j]
                stripped = l.strip()
                if stripped.startswith('--'):
                    j += 1
                    continue
                if re.match(r'^(function|if|for|while|do)\b', stripped):
                    if stripped.startswith('if') and not re.search(r'\bthen\b', stripped) and not stripped.endswith('do'):
                        pass
                    elif stripped.startswith('do') and stripped != 'do' and not stripped.startswith('do '):
                        pass
                    else:
                        depth += 1
                if re.match(r'^end\b', stripped) or stripped == 'end':
                    depth -= 1
                j += 1
            blocks.append((i, j, func_name))
            i = j
        else:
            i += 1

    seen = set()
    blocks_to_remove = []
    for start, end, name in blocks:
        if name in seen:
            blocks_to_remove.append((start, end, name))
        else:
            seen.add(name)

    if not blocks_to_remove:
        return False

    blocks_to_remove.sort(reverse=True)
    for start, end, name in blocks_to_remove:
        actual_start = start
        if actual_start > 0 and lines[actual_start - 1].strip() == '':
            actual_start -= 1
        del lines[actual_start:end]

    with open(filepath, 'w') as f:
        f.writelines(lines)
    return True


# ============================================================
# 2. SMART GetMuzzle / GetShellEject
# ============================================================
SMART_MUZZLE_BLOCK = '''-- ============================================================
-- MUZZLE ATTACHMENT (auto-detect: tag_flash -> tag_silencer -> fallback)
-- ============================================================
function SWEP:GetMuzzle()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("tag_flash")
        if att > 0 then return att end
        att = vm:LookupAttachment("tag_silencer")
        if att > 0 then return att end
        att = vm:LookupAttachment("muzzle")
        if att > 0 then return att end
    end
    return 1
end

function SWEP:GetShellEject()
    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
    if IsValid(vm) then
        local att = vm:LookupAttachment("tag_brass")
        if att > 0 then return att end
        att = vm:LookupAttachment("shell")
        if att > 0 then return att end
    end
    return 2
end
'''

def replace_get_muzzle(filepath):
    with open(filepath) as f:
        content = f.read()
    # Remove existing GetMuzzle and GetShellEject functions
    content = re.sub(r'function SWEP:GetMuzzle\(\)\s*return\s*\d+\s*end\s*\n', '', content)
    content = re.sub(r'function SWEP:GetShellEject\(\)\s*return\s*\d+\s*end\s*\n', '', content)
    # Remove old comment headers
    content = re.sub(r'-- =+\n-- MUZZLE.*?\n-- =+\n', '', content, flags=re.DOTALL)
    # Append smart version at end of file
    if 'function SWEP:GetMuzzle' not in content:
        content = content.rstrip() + '\n\n' + SMART_MUZZLE_BLOCK.strip() + '\n'
    with open(filepath, 'w') as f:
        f.write(content)
    return True


# ============================================================
# 3. SHOTGUN RELOAD HELPERS
# ============================================================
SHOTGUN_HELPERS = '''-- ============================================================
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
        self:EasySendWeaponAnim("after_reload", ACT_SHOTGUN_RELOAD_FINISH)
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

function SWEP:Reload()
    if self._meleeActive or self._mantleActive then return end
    if self.Owner:KeyDown(IN_USE) then return end
    local ct = CurTime()
    if self.NextReload < ct and not self:GetUHBool("Reloading") and not self:GetUHBool("Running")
        and self.Owner:GetNWFloat("GrenadeTime") < ct
        and self:GetNWFloat("DeployTime") < ct then
        if self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and self:Clip1() < self.Primary.ClipSize then
            if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
            self.Owner:SetAnimation(PLAYER_RELOAD)
            self.NextReload = ct + 0.5
            if self.PreReload then self:PreReload() end
            self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)
            local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil
            local startDur = IsValid(vm) and vm:SequenceDuration() or 0.5
            self:SetNextPrimaryFire(ct + startDur + 0.1)
            self:SetNextSecondaryFire(ct + startDur + 0.1)
            self.NextReload = ct + startDur + 0.1
            self:SetUHBool("Reloading", true)
            self:SetUHBool("Zooming", false)
            self.reloaddelay = ct + startDur + self.ShellLoadTime
            local num = math.min(self.Primary.ClipSize - self:Clip1(), self.Owner:GetAmmoCount(self:GetPrimaryAmmoType()))
            local amount = num * self.ShellLoadTime
            self:SetNWFloat("ReloadTime", amount)
            self:SetNWFloat("ReloadEndTime", ct + startDur + amount)
        end
    end
end

-- CustomThink: dispatches ReloadShotgun every tick while reloading
SWEP.CustomThink = function(self, ct)
    if self.Shotgun and self.ReloadShotgun and self:GetUHBool("Reloading") then
        self:ReloadShotgun(ct)
    end
end
'''

PUMP_POSTSHOOT = '''-- ============================================================
-- PUMP-ACTION RECHAMBER (after every shot)
-- ============================================================
SWEP.IsPump = true
SWEP.PumpDelay = SWEP.PumpDelay or 0.5

function SWEP:PostShoot()
    local ct = CurTime()
    local pumpDelay = self.PumpDelay or 0.5
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


# ============================================================
# 4. BURST FIRE LOGIC
# ============================================================
BURST_FIRE_BLOCK = '''-- ============================================================
-- BURST FIRE LOGIC
-- ============================================================
SWEP.BurstCount = SWEP.BurstFireCount or 3
SWEP.BurstDelay = SWEP.BurstDelay or 0.075

SWEP.FireModes = {
    {
        name = "Burst",
        shoot = function(ply, wep)
            if wep._burstRemaining and wep._burstRemaining > 0 then return true end
            if not wep:CanPrimaryAttack() then return false end
            wep._burstRemaining = wep.BurstCount
            wep._burstDelay = wep.BurstDelay
            wep:FireBurstRound()
            return true
        end
    },
    { name = "Semi-Auto" }
}

function SWEP:FireBurstRound()
    if not IsValid(self) or not IsValid(self.Owner) then return end
    if not self:CanPrimaryAttack() then
        self._burstRemaining = nil
        return
    end
    local ct = CurTime()
    local sp = game.SinglePlayer()
    local iftp = IsFirstTimePredicted()

    if SERVER or iftp then
        local dmg = math.random(self.Primary.MinDamage, self.Primary.MaxDamage)
        if self:GetNWBool("Silenced") then dmg = math.Round(dmg * 0.95) end
        self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), dmg, self.Penetration or 2)
    end

    local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil)
        * (self:GetUHBool("Zooming") and 0.35 or 1)
    if sp or (CLIENT and iftp) then
        self:DoMuzzleFlash()
        self:CreateSmoke(self:GetMuzzle(), self.Primary.Delay + 0.14)
        if not self.NoShell then self:CreateShell(self.ShellDelay or 0, self.ShellHeat) end
        self.Owner:SetEyeAngles(self.Owner:EyeAngles() + Angle(recoil, 0, 0))
    end
    self.Owner:ViewPunch(Angle(recoil, 0, 0))

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

-- Burst continuation in CustomThink
SWEP.CustomThink = function(self, ct)
    if self._burstRemaining and self._burstRemaining > 0 then
        if ct >= (self._burstNextFire or 0) then
            self:FireBurstRound()
        end
    end
end
'''


# ============================================================
# 5. PARSE TFA EventTable -> CUH AnimSounds
# ============================================================
ACT_TO_KEY = {
    "ACT_VM_DRAW_DEPLOYED": "draw_first",
    "ACT_VM_DRAW_EMPTY": "draw_empty",
    "ACT_VM_DRAW": "draw",
    "ACT_VM_HOLSTER_EMPTY": "holster_empty",
    "ACT_VM_HOLSTER": "holster",
    "ACT_VM_PULLBACK_HIGH": "rechamber",
    "ACT_VM_PULLBACK_LOW": "rechamber_ads",
    "ACT_VM_RELOAD_EMPTY": "reload_empty",
    "ACT_VM_RELOAD": "reload",
    "ACT_VM_PRIMARYATTACK_SILENCED": "shoot_silenced",
    "ACT_VM_PRIMARYATTACK": "shoot",
    "ACT_VM_FIDGET": "inspect",
    "ACT_VM_MELEE": "melee",
    "ACT_VM_HITCENTER": "melee",
    "ACT_VM_HITMISS": "melee",
    "ACT_VM_IDLE": "idle",
    "ACT_VM_IDLE_EMPTY": "idle_empty",
    "ACT_VM_SPRINT_ENTER": "sprint_in",
    "ACT_VM_SPRINT_LEAVE": "sprint_out",
    "ACT_VM_SPRINT_IDLE": "sprint_idle",
}


def parse_tfa_event_table(content):
    m = re.search(r'SWEP\.EventTable\s*=\s*\{', content)
    if not m:
        return None
    start = m.end() - 1
    depth = 0
    i = start
    in_string = False
    string_char = None
    in_long_comment = False
    in_line_comment = False
    while i < len(content):
        c = content[i]
        if in_long_comment:
            if content[i:i+2] == ']]':
                in_long_comment = False
                i += 2
                continue
            i += 1
            continue
        if in_line_comment:
            if c == '\n':
                in_line_comment = False
            i += 1
            continue
        if in_string:
            if c == '\\':
                i += 2
                continue
            if c == string_char:
                in_string = False
            i += 1
            continue
        if content[i:i+4] == '--[[':
            in_long_comment = True
            i += 4
            continue
        if content[i:i+2] == '--':
            in_line_comment = True
            i += 2
            continue
        if c == '"' or c == "'":
            in_string = True
            string_char = c
            i += 1
            continue
        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1
            if depth == 0:
                break
        i += 1
    if i >= len(content):
        return None
    return content[start:i+1]


def extract_sounds_from_event_table(table_str):
    sounds = {}
    i = 0
    n = len(table_str)
    while i < n:
        while i < n and table_str[i] in ' \t\n':
            i += 1
        if i >= n:
            break
        c = table_str[i]
        if c in '{}':
            i += 1
            continue
        if c == ',':
            i += 1
            continue
        key = None
        if c == '[':
            j = table_str.find(']', i)
            if j == -1:
                break
            inner = table_str[i+1:j].strip()
            if inner.startswith('"') or inner.startswith("'"):
                key = inner[1:-1]
            else:
                key = inner
            i = j + 1
        elif c.isalpha() or c == '_':
            m = re.match(r'\w+', table_str[i:])
            if m:
                key = m.group(0)
                i += len(key)
            else:
                i += 1
                continue
        else:
            i += 1
            continue
        while i < n and table_str[i] in ' \t\n':
            i += 1
        if i < n and table_str[i] == '=':
            i += 1
        else:
            continue
        while i < n and table_str[i] in ' \t\n':
            i += 1
        if i >= n or table_str[i] != '{':
            continue
        depth = 1
        j = i + 1
        in_str = False
        str_char = None
        while j < n and depth > 0:
            ch = table_str[j]
            if in_str:
                if ch == '\\':
                    j += 2
                    continue
                if ch == str_char:
                    in_str = False
                j += 1
                continue
            if ch == '"' or ch == "'":
                in_str = True
                str_char = ch
                j += 1
                continue
            if table_str[j:j+2] == '--':
                while j < n and table_str[j] != '\n':
                    j += 1
                continue
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
            j += 1
        value_str = table_str[i:j]
        anim_key = ACT_TO_KEY.get(key, key)
        if anim_key == key and key.startswith("ACT_"):
            i = j
            continue
        entries = parse_sound_entries(value_str)
        if entries:
            sounds[anim_key] = entries
        i = j
    return sounds


def parse_sound_entries(value_str):
    entries = []
    i = 0
    n = len(value_str)
    while i < n:
        while i < n and value_str[i] != '{':
            i += 1
        if i >= n:
            break
        depth = 1
        j = i + 1
        in_str = False
        str_char = None
        while j < n and depth > 0:
            ch = value_str[j]
            if in_str:
                if ch == '\\':
                    j += 2
                    continue
                if ch == str_char:
                    in_str = False
                j += 1
                continue
            if ch == '"' or ch == "'":
                in_str = True
                str_char = ch
                j += 1
                continue
            if value_str[j:j+2] == '--':
                while j < n and value_str[j] != '\n':
                    j += 1
                continue
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
            j += 1
        entry_str = value_str[i:j]
        i = j
        time_m = re.search(r'\["time"\]\s*=\s*([\d\s\.\+\-\*\/]+)', entry_str)
        type_m = re.search(r'\["type"\]\s*=\s*"(\w+)"', entry_str)
        if not type_m:
            type_m = re.search(r"\[\"type\"\]\s*=\s*\'(\w+)\'", entry_str)
        if not type_m:
            continue
        if type_m.group(1) != 'sound':
            continue
        value_m = re.search(r'\["value"\]\s*=\s*Sound\("([^"]+)"\)', entry_str)
        if not value_m:
            value_m = re.search(r"\[\"value\"\]\s*=\s*Sound\(\'([^\']+)\'\)", entry_str)
        if not value_m:
            value_m = re.search(r'\["value"\]\s*=\s*"([^"]+)"', entry_str)
        if not value_m:
            continue
        time_str = time_m.group(1).strip() if time_m else "0"
        try:
            time_val = eval(time_str, {'__builtins__': {}})
        except Exception:
            time_val = 0
        sound_name = value_m.group(1)
        entries.append({'time': time_val, 'sound': sound_name})
    return entries


def generate_animsounds_lua(sounds):
    if not sounds:
        return ''
    lines = ['SWEP.AnimSounds = {']
    for key, entries in sounds.items():
        lines.append(f'    ["{key}"] = {{')
        for e in entries:
            snd = e['sound']
            snd_escaped = snd.replace('\\', '\\\\').replace('"', '\\"')
            lines.append(f'        {{ time = {e["time"]:.4f}, sound = "{snd_escaped}" }},')
        lines.append('    },')
    lines.append('}')
    return '\n'.join(lines)


# ============================================================
# MAIN
# ============================================================
def find_original_tfa(weapon_filename):
    name = weapon_filename.replace('uh_codww2_', '').replace('.lua', '')
    candidate = f'nz_kate_codww2_{name}.lua'
    path = os.path.join(ORIGINAL_TFA_DIR, candidate)
    if os.path.exists(path):
        return path
    candidate2 = f'nz_kate_codww2_{name}_upgraded.lua'
    path2 = os.path.join(ORIGINAL_TFA_DIR, candidate2)
    if os.path.exists(path2):
        return path2
    return None


SHOTGUN_WEAPONS = {
    'uh_codww2_model1897.lua', 'uh_codww2_m30.lua', 'uh_codww2_model21.lua',
    'uh_codww2_walther.lua', 'uh_codww2_blunderbuss.lua', 'uh_codww2_mas36.lua',
    'uh_codww2_winchester94.lua', 'uh_codww2_m1879.lua',
}


def update_weapon_file(filepath):
    filename = os.path.basename(filepath)
    changes = []

    # 1. Remove duplicate functions
    if remove_duplicate_functions_simple(filepath):
        changes.append('removed duplicates')
        with open(filepath) as f:
            content = f.read()
    else:
        with open(filepath) as f:
            content = f.read()

    # 2. Replace GetMuzzle/GetShellEject with smart auto-detect
    if 'function SWEP:GetMuzzle' in content or 'SWEP:GetMuzzle' in content:
        replace_get_muzzle(filepath)
        changes.append('smart GetMuzzle')
        with open(filepath) as f:
            content = f.read()

    # 3. Add AnimSounds from original TFA EventTable
    original_path = find_original_tfa(filename)
    if original_path:
        with open(original_path) as f:
            tfa_content = f.read()
        table_str = parse_tfa_event_table(tfa_content)
        if table_str:
            sounds = extract_sounds_from_event_table(table_str)
            if sounds:
                animsounds_lua = generate_animsounds_lua(sounds)
                # Replace existing empty or partial AnimSounds table
                new_content = re.sub(
                    r'SWEP\.AnimSounds\s*=\s*\{[^}]*\}',
                    animsounds_lua.replace('\\', '\\\\'),
                    content,
                    count=1
                )
                if new_content != content:
                    content = new_content
                    changes.append(f'AnimSounds({len(sounds)})')

    # 4. Add burst fire logic to pg1935 and zk383
    if filename in ('uh_codww2_pg1935.lua', 'uh_codww2_zk383.lua'):
        if 'function SWEP:FireBurstRound' not in content:
            # Replace the FireModes + BurstFireCount + BurstDelay block with the burst logic
            new_content = re.sub(
                r'SWEP\.FireModes\s*=\s*\{[^}]*\}\s*\nSWEP\.BurstFireCount\s*=\s*\d+\s*\nSWEP\.BurstDelay\s*=\s*[\d\.]+\s*\nSWEP\.OnlyBurstFire\s*=\s*\w+\s*\nSWEP\.DisableBurstFire\s*=\s*\w+',
                BURST_FIRE_BLOCK.strip(),
                content,
                count=1
            )
            if new_content != content:
                content = new_content
                changes.append('burst fire')

    # 5. Add shotgun reload + pump for shotgun weapons
    if filename in SHOTGUN_WEAPONS:
        if 'function SWEP:ReloadShotgun' not in content:
            # Set IsPump = true
            if 'SWEP.IsPump' not in content and 'SWEP.IsBoltAction' in content:
                content = re.sub(
                    r'SWEP\.IsBoltAction\s*=\s*\w+',
                    'SWEP.IsBoltAction = true\nSWEP.IsPump = true\nSWEP.PumpDelay = 0.5',
                    content,
                    count=1
                )
            elif 'SWEP.IsPump' not in content:
                # Just add it somewhere
                content = re.sub(
                    r'(SWEP\.IsBoltAction\s*=\s*\w+)',
                    r'\1\nSWEP.IsPump = true\nSWEP.PumpDelay = 0.5',
                    content,
                    count=1
                )
            # Append shotgun helpers
            content = content.rstrip() + '\n\n' + SHOTGUN_HELPERS.strip() + '\n'
            if 'function SWEP:PostShoot' not in content:
                content = content.rstrip() + '\n\n' + PUMP_POSTSHOOT.strip() + '\n'
            changes.append('shotgun reload + pump')

    # Write back if any changes
    if changes:
        with open(filepath, 'w') as f:
            f.write(content)

    return changes


def main():
    print(f"=== WWII Port Fixer ===")
    stats = {'processed': 0, 'changed': 0, 'changes': 0}
    for filename in sorted(os.listdir(WEAPONS_DIR)):
        if not filename.startswith('uh_codww2_') or not filename.endswith('.lua'):
            continue
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.isfile(filepath):
            continue
        stats['processed'] += 1
        changes = update_weapon_file(filepath)
        if changes:
            stats['changed'] += 1
            stats['changes'] += len(changes)
            print(f"  {filename}: {', '.join(changes)}")
    print(f"\n=== Summary ===")
    print(f"Files processed: {stats['processed']}")
    print(f"Files with changes: {stats['changed']}")
    print(f"Total changes: {stats['changes']}")


if __name__ == '__main__':
    main()
