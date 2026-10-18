#!/usr/bin/env python3
"""
apply_sniper_fixes.py

Adds bolt-action rechamber mechanics and RT scope rendering to the
L115 and USR sniper rifles, mirroring the WWII Kate Kar98k pattern.

Changes per weapon:
  1. Bolt-action config: IsBoltAction, PumpDelay, Primary.Delay bumped
  2. RT scope config: ScopeFov, ScopeReticle, Sensitivity, ScopeBlur
  3. Rechamber animations added to Animations table
  4. PostShoot() override — plays bolt-cycle animation after PumpDelay
  5. CanPrimaryAttack() override — blocks fire during bolt cycle
  6. Initialize() override — creates ScopeTexture (CreateMaterial)
  7. PreDrawViewModel() override — applies RT submaterial to VM lens
  8. Think() updated — lazy-finds the lens material index on the VM
  9. Holster() updated — cleans up RT state
"""

import os
import re

WEAPONS_DIR = "/home/z/my-project/cod_ghosts_underhellsweps/lua/weapons"

# --- Config per weapon ---
WEAPON_CONFIGS = {
    "ghosts_l115.lua": {
        "fire_delay": "1.200000",   # bolt-action: fire + cycle
        "pump_delay": "0.500",
        "scope_fov":  "8",
        "zoom_fov":   "15",
        "reticle":    "gmod/scope",
        "mat_prefix": "ghosts_l115_rt",
    },
    "ghosts_usr.lua": {
        "fire_delay": "1.200000",
        "pump_delay": "0.500",
        "scope_fov":  "10",
        "zoom_fov":   "15",
        "reticle":    "gmod/scope",
        "mat_prefix": "ghosts_usr_rt",
    },
}


def apply_bolt_action_config(content: str, cfg: dict) -> str:
    """Update Primary.Delay and add bolt-action + RT scope config."""
    # 1. Replace Primary.Delay
    old_delay = re.search(r'SWEP\.Primary\.Delay\s*=\s*0\.\d+\s*--.*', content)
    if old_delay:
        content = content.replace(
            old_delay.group(),
            f'SWEP.Primary.Delay          = {cfg["fire_delay"]}    -- bolt-action cycle (fire + bolt)'
        )

    # 2. Add bolt-action + RT scope config after AnimatedSprint
    old_block = "SWEP.AnimatedSprint         = true\n"
    new_block = (
        "SWEP.AnimatedSprint         = true\n"
        "\n"
        "-- Bolt-action rechamber config\n"
        f'SWEP.IsBoltAction = true\n'
        f'SWEP.PumpDelay    = {cfg["pump_delay"]}       -- bolt cycle starts this many seconds after fire\n'
        "\n"
        "-- RT scope config\n"
        f'SWEP.ScopeFov      = {cfg["scope_fov"]}\n'
        f'SWEP.ZoomFov       = {cfg["zoom_fov"]}\n'
        f'SWEP.ScopeReticle  = "{cfg["reticle"]}"\n'
        'SWEP.Sensitivity   = 0.2\n'
        'SWEP.Use2DScope    = false\n'
        'SWEP.ScopeDisabled = false\n'
        'SWEP.ScopeBlur     = true\n'
    )
    content = content.replace(old_block, new_block, 1)
    return content


def add_rechamber_anims(content: str) -> str:
    """Add rechamber/rechamber_ads entries to the Animations table."""
    # Insert after ["fire_ads"] = "fire_ads",
    old = '    ["fire_ads"]     = "fire_ads",\n'
    new = (
        '    ["fire_ads"]     = "fire_ads",\n'
        '    ["rechamber"]    = "rechamber",\n'
        '    ["rechamber_ads"] = "rechamber_ads",\n'
    )
    content = content.replace(old, new, 1)
    return content


def add_post_shoot(content: str) -> str:
    """Add PostShoot override after ShootAnimation function."""
    # Find the end of ShootAnimation function
    marker = (
        "    return ACT_VM_PRIMARYATTACK\n"
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- SPRINT / IDLE / INSPECT HANDLERS"
    )
    post_shoot = (
        "    return ACT_VM_PRIMARYATTACK\n"
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- BOLT-ACTION RECHAMBER (PostShoot override)\n"
        "-- ============================================================\n"
        "-- After firing, locks fire for PumpDelay, then plays the bolt-cycle\n"
        "-- animation. Primary.Delay is set high enough (1.2s) that the next\n"
        "-- shot can't fire until the bolt cycle has completed.\n"
        "function SWEP:PostShoot()\n"
        "    if not self.IsBoltAction then return end\n"
        "    local ct = CurTime()\n"
        "    local pumpDelay = self.PumpDelay or 0.5\n"
        "    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + pumpDelay))\n"
        "    self:SetNextSecondaryFire(math.max(self:GetNextSecondaryFire(), ct + pumpDelay))\n"
        "    timer.Simple(pumpDelay, function()\n"
        "        if not IsValid(self) or not IsValid(self.Owner)\n"
        "           or not IsValid(self.Owner:GetActiveWeapon())\n"
        "           or self.Owner:GetActiveWeapon() ~= self then return end\n"
        "        if self:GetUHBool(\"Reloading\") then return end\n"
        "        local animKey = self:GetUHBool(\"Zooming\") and \"rechamber_ads\" or \"rechamber\"\n"
        "        self:EasySendWeaponAnim(animKey, ACT_VM_PULLBACK_HIGH)\n"
        "    end)\n"
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- SPRINT / IDLE / INSPECT HANDLERS"
    )
    content = content.replace(marker, post_shoot, 1)
    return content


def add_can_primary_attack(content: str) -> str:
    """Add CanPrimaryAttack override before the ATTACK section."""
    marker = (
        "-- ============================================================\n"
        "-- ATTACK\n"
        "-- ============================================================\n"
        "function SWEP:PrimaryAttack()"
    )
    replacement = (
        "-- ============================================================\n"
        "-- RECHAMBER GUARD (CanPrimaryAttack override)\n"
        "-- ============================================================\n"
        "-- Blocks fire during the bolt cycle so the rechamber animation\n"
        "-- can't be cancelled by the next trigger pull.\n"
        "function SWEP:CanPrimaryAttack()\n"
        "    if self:GetNWInt(\"FireMode\") == 0 then return false end\n"
        "    if self:GetNWFloat(\"DeployTime\") > CurTime() then return false end\n"
        "    if self:GetUHBool(\"Running\") then return false end\n"
        "    if self:GetUHBool(\"Reloading\") then return false end\n"
        "    if self.IsBoltAction and CurTime() < self:GetNextPrimaryFire() then\n"
        "        return false\n"
        "    end\n"
        "    if self:Clip1() <= 0 then\n"
        "        if not self:GetUHBool(\"Reloading\") then\n"
        "            self:EmitSound(\"Weapon_SMG1.Empty\", 75, 100, 1, CHAN_USER_BASE)\n"
        "        end\n"
        "        self:SetNextPrimaryFire(CurTime() + 0.4)\n"
        "        return false\n"
        "    end\n"
        "    return true\n"
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- ATTACK\n"
        "-- ============================================================\n"
        "function SWEP:PrimaryAttack()"
    )
    content = content.replace(marker, replacement, 1)
    return content


def add_initialize(content: str, cfg: dict) -> str:
    """Add Initialize override that creates the ScopeTexture material."""
    marker = (
        "-- ============================================================\n"
        "-- HOLSTER / DEPLOY\n"
        "-- ============================================================\n"
        "function SWEP:Holster(wep)"
    )
    replacement = (
        "-- ============================================================\n"
        "-- INITIALIZE — create RT scope material (client-side)\n"
        "-- ============================================================\n"
        "function SWEP:Initialize()\n"
        "    if CLIENT then\n"
        f'        local matName = "{cfg["mat_prefix"]}_" .. self:EntIndex()\n'
        '        local reticlePath = self.ScopeReticle or "gmod/scope"\n'
        '        self.ScopeTexture = CreateMaterial(matName, "Unlittwotexture", {\n'
        '            ["$basetexture"] = "gmod/scope",\n'
        '            ["$texture2"]    = reticlePath,\n'
        '            ["$model"]       = "1",\n'
        '            ["$selfillum"]   = "1",\n'
        '            ["$selfillumtint"] = "[1 1 1]",\n'
        '            ["$color2"]      = "[1 1 1]",\n'
        "        })\n"
        "        self._rtScopeMatName = matName\n"
        "    end\n"
        "    BaseClass.Initialize(self)\n"
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- PREDRAWVIEWMODEL — apply RT scope submaterial to VM lens\n"
        "-- ============================================================\n"
        "-- The base class clears all submaterials in PreDrawViewModel, then\n"
        "-- applies HideMaterials. We call BaseClass.PreDrawViewModel first,\n"
        "-- then apply the RT scope material to the lens material index.\n"
        "function SWEP:PreDrawViewModel()\n"
        "    BaseClass.PreDrawViewModel(self)\n"
        "    if not self.ScopeTexture then return end\n"
        "    if not self._rtScopeLensIdx then return end\n"
        "    local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil\n"
        "    if not IsValid(vm) then return end\n"
        '    vm:SetSubMaterial(self._rtScopeLensIdx, "!" .. self._rtScopeMatName)\n'
        "end\n"
        "\n"
        "-- ============================================================\n"
        "-- HOLSTER / DEPLOY\n"
        "-- ============================================================\n"
        "function SWEP:Holster(wep)"
    )
    content = content.replace(marker, replacement, 1)
    return content


def update_think(content: str) -> str:
    """Add lazy lens-index finding to Think()."""
    # Find the Think function and add lens finding after BaseClass.Think
    old = (
        "    BaseClass.Think(self)\n"
        "    if not IsValid(self.Owner) then return end\n"
        "    self:HandleSprintingAnimations()\n"
        "    self:HandleIdle()\n"
        "    self:HandleInspect()\n"
        "end"
    )
    new = (
        "    BaseClass.Think(self)\n"
        "    if not IsValid(self.Owner) then return end\n"
        "\n"
        "    -- Lazy-find the lens material index on the VM (client-side)\n"
        "    if CLIENT and not self._rtScopeLensFound then\n"
        "        local vm = IsValid(self.Owner) and self.Owner:GetViewModel() or nil\n"
        "        if IsValid(vm) then\n"
        "            local mats = vm:GetMaterials()\n"
        "            if mats and #mats > 0 then\n"
        "                local lensIdx = nil\n"
        "                for i = 1, #mats do\n"
        "                    local mn = string.lower(tostring(mats[i]))\n"
        '                    if string.find(mn, "lens") or string.find(mn, "scope")\n'
        '                       or string.find(mn, "optic") then\n'
        "                        lensIdx = i - 1\n"
        "                        break\n"
        "                    end\n"
        "                end\n"
        "                if not lensIdx then lensIdx = 0 end\n"
        "                self._rtScopeLensIdx = lensIdx\n"
        "                self._rtScopeLensFound = true\n"
        "            end\n"
        "        end\n"
        "    end\n"
        "\n"
        "    self:HandleSprintingAnimations()\n"
        "    self:HandleIdle()\n"
        "    self:HandleInspect()\n"
        "end"
    )
    content = content.replace(old, new, 1)
    return content


def update_holster(content: str) -> str:
    """Add RT scope cleanup to Holster."""
    old = (
        "function SWEP:Holster(wep)\n"
        "    self._justExitedSprint = false\n"
        "    self.wasZooming = false\n"
        "    self.wasRunning = false\n"
        "    return BaseClass.Holster(self, wep)\n"
        "end"
    )
    new = (
        "function SWEP:Holster(wep)\n"
        "    self._justExitedSprint = false\n"
        "    self.wasZooming = false\n"
        "    self.wasRunning = false\n"
        "    -- Reset lens finding so it re-scans on next deploy\n"
        "    self._rtScopeLensFound = nil\n"
        "    self._rtScopeLensIdx = nil\n"
        "    return BaseClass.Holster(self, wep)\n"
        "end"
    )
    content = content.replace(old, new, 1)
    return content


def process_file(filepath: str, cfg: dict) -> None:
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    original = content

    content = apply_bolt_action_config(content, cfg)
    content = add_rechamber_anims(content)
    content = add_post_shoot(content)
    content = add_can_primary_attack(content)
    content = add_initialize(content, cfg)
    content = update_think(content)
    content = update_holster(content)

    if content == original:
        print(f"  WARNING: no changes applied to {os.path.basename(filepath)}")
        return

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"  OK: {os.path.basename(filepath)}")


def main():
    for filename, cfg in WEAPON_CONFIGS.items():
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.exists(filepath):
            print(f"  ERROR: {filepath} not found")
            continue
        print(f"Processing {filename}...")
        process_file(filepath, cfg)
    print("Done.")


if __name__ == "__main__":
    main()
