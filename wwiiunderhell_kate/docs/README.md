# Underhell CUH Base + Reference Weapons — Technical Audit

This directory contains the complete technical documentation of the CUH (Customizable Underhell) weapon base, the BO3 reference weapons, and the gap analysis for porting TFA WWII weapons.

## Document Index

### TFA WWII Weapon Audits (source material)
| Document | Weapons | Lines | Size |
|----------|---------|-------|------|
| [audit_pistols_smg.md](audit_pistols_smg.md) | 8 pistols + 16 SMGs | 3,419 | 162 KB |
| [audit_rifles.md](audit_rifles.md) | 20 rifles | 2,996 | 131 KB |
| [audit_snipers_shotguns.md](audit_snipers_shotguns.md) | 9 snipers + 4 shotguns | 3,130 | 155 KB |
| [audit_lmg_launcher_melee.md](audit_lmg_launcher_melee.md) | 14 LMGs + 4 launchers + 3 flamethrowers + 9 melee | 4,367 | 193 KB |

### CUH Base Architecture Audits (target framework)
| Document | Content | Lines | Size |
|----------|---------|-------|------|
| [audit_cuh_base.md](audit_cuh_base.md) | Full CUH base: weapon_cuh_base_gun, weapon_custom_uh_base_gun, weapon_custom_uh_base, shotty base, melee base | 4,056 | 188 KB |
| [audit_bo3_references.md](audit_bo3_references.md) | BO3 base gun, base shotty, KRM-262, M8A7, Drakon, MR6, ICR-1 | 2,525 | 117 KB |
| [audit_cuh_autorun.md](audit_cuh_autorun.md) | sh_cuh_attachments, cl_cuh_ui, cuh_extra_recoil, 78 attachment data files | 1,748 | 94 KB |

### Porting Guide
| Document | Content | Lines | Size |
|----------|---------|-------|------|
| [gap_analysis.md](gap_analysis.md) | Field mapping, feature gaps, mechanics porting guide, critical issues, port order | 2,078 | 116 KB |

**TOTAL: 24,395 lines, ~1.2 MB of documentation**

---

## Architecture Overview

### Inheritance Chain
```
weapon_base (engine)
  └─ weapon_custom_uh_base (grandparent — Sights/Movement/Deploy/CalcView)
      └─ weapon_custom_uh_base_gun (parent — PrimaryAttack/Reload/Think/AnimSounds)
          └─ weapon_cuh_base_gun (CUH — attachments/VElements/camera bone/melee)
              └─ uh_codww2_* (WWII ports)
```

### Key Systems
- **PrimaryAttack**: FireModes.shoot callback → ShootBullets → recoil → animation → PostShoot
- **Reload**: Magazine-style with _reloadEndTime → _FinishReload (shotguns override with ReloadShotgun)
- **Think**: Reload completion + zoom logic + AnimSounds processing + CustomThink + melee state machine
- **AnimSounds**: Timeline system — SetupAnimSounds starts, ProcessAnimSounds ticks
- **Attachments**: 6-stage ApplyAttachments pipeline (reset → restore → apply per-slot)
- **VElements/WElements**: ClientsideModel bonemerged to viewmodel/world model
- **Camera Bone**: CalcView reads VM attachment angle for BO3-style view animation
- **Melee**: E+M1 → MeleeAttack → Think state machine → DoMeleeTrace → EndMelee

---

## Critical Issues Identified

### Must Fix Before Porting (CRITICAL)
1. **GetStat shadowed by TFA stub** — breaks function-transform attachments (~30% of WWII attachments affected)
2. **SetUHBool/GetUHBool undefined** — must verify external Underhell addon is mounted
3. **~19 missing attachment data files** — WWII weapons reference attachments that don't exist

### Should Fix (HIGH)
4. ATTACHMENT.Detach never called — cleanup code can't run
5. E+M1 melee dispatch not in base — every weapon duplicates it
6. FlushStats unreachable — _statDirty never set true

### Should Fix (MEDIUM/LOW)
7. [CUH-DBG] prints ungated — console spam
8. Material caching in UI — Material() called every frame
9. 1ms polling timer in cuh_extra_recoil — should be event-driven

---

## Porting Roadmap

### Conversion Rules
| TFA Field | CUH Field | Formula |
|-----------|-----------|---------|
| Primary.RPM | Primary.Delay | `Delay = 60 / RPM` |
| DisableChambering | Chambering | `Chambering = not DisableChambering` |
| Secondary.BashDamage | MeleeDamage | Direct |
| EventTable[ACT_VM_RELOAD] | AnimSounds["reload"] | Time: N/30 → N/30 (seconds) |
| VElements | ViewModelElements | `angle→ang`, `size→scale`, `bodygroup→bodygroups` |

### Recommended Port Order
1. **Tier 1**: Simple semi-auto pistols (1911, P38, Luger, Nambu, No2) — 5 weapons, ~5 hrs
2. **Tier 2**: Full-auto SMGs (MP40, Sten, MP28, etc.) — 16 weapons, ~16 hrs
3. **Tier 3**: Standard rifles (STG44, BAR, FG42, etc.) — 20 weapons, ~20 hrs
4. **Tier 4**: Bolt-action snipers (Kar98k, Mosin, etc.) — 8 weapons, ~16 hrs
5. **Tier 5**: Shotguns (Model 1897, MAS36, etc.) — 4 weapons, ~12 hrs
6. **Tier 6**: LMGs (MG42, Bren, Lewis, etc.) — 14 weapons, ~14 hrs
7. **Tier 7**: Burst-fire (ITRA Burst, ZK-383) — 2 weapons, ~6 hrs
8. **Tier 8**: Special weapons (launchers, flamethrowers, melee) — 22 weapons, ~36-60 hrs

**Total estimated effort: ~120-150 hours (3-4 weeks)**

---

## Key Mechanics Porting Templates

### Bolt-Action Rechamber (PostShoot override)
```lua
SWEP.PumpDelay = 0.5
function SWEP:PostShoot()
    local ct = CurTime()
    self:SetNextPrimaryFire(math.max(self:GetNextPrimaryFire(), ct + self.PumpDelay))
    timer.Simple(self.PumpDelay, function()
        if not IsValid(self) or not IsValid(self.Owner) then return end
        if self.Owner:GetActiveWeapon() ~= self then return end
        if self:GetUHBool("Reloading") then return end
        local animKey = self:GetUHBool("Zooming") and "rechamber_ads" or "rechamber"
        self:EasySendWeaponAnim(animKey, ACT_VM_PULLBACK_HIGH)
    end)
end
```

### Shotgun Shell-by-Shell Reload (KRM pattern)
```lua
SWEP.Shotgun = true
function SWEP:Reload() -- Start only
    -- guards...
    self:EasySendWeaponAnim("start_reload", ACT_SHOTGUN_RELOAD_START)
    self._krm_nextShell = ct + startDur
    self:SetUHBool("Reloading", true)
end
function SWEP:ReloadShotgun(ct) -- Timer-based loop
    -- stop conditions → after_reload
    -- _krm_nextShell → reload_loop + insert shell
end
SWEP.CustomThink = function(self, ct)
    if self:GetUHBool("Reloading") then self:ReloadShotgun(ct) end
end
```

### Burst Fire (M8A7 pattern)
```lua
SWEP.FireModes = {
    { name = "Burst", shoot = function(ply, wep)
        if wep._burstRemaining and wep._burstRemaining > 0 then return true end
        wep._burstRemaining = wep.BurstCount
        wep:FireBurstRound()
        return true
    end },
    { name = "Semi-Auto" }
}
function SWEP:FireBurstRound() -- fires 1 round, decrements, schedules next
end
SWEP.CustomThink = function(self, ct)
    if self._burstRemaining and self._burstRemaining > 0 then
        if ct >= (self._burstNextFire or 0) then self:FireBurstRound() end
    end
end
```

See [gap_analysis.md](gap_analysis.md) for complete templates and the full porting guide.
