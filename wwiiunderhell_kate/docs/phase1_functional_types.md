# Phase 1: Functional Weapon Type Categorization

Weapons grouped by **mechanical behavior** (not weapon class). Two weapons in the same functional type share identical reload loops, rechamber mechanics, and firing states, regardless of whether one is a "pistol" and the other is an "LMG."

## Type 1: Semi-Auto Magazine (No Rechamber)
**Mechanics:** Each trigger pull fires one round. No bolt/pump cycle after firing. Standard magazine reload.

| Weapon | Notes |
|--------|-------|
| 1911 | Pistol |
| blunderbuss | Shotgun-style but no PumpAction, uses standard mag reload |
| gewehr43 | Rifle |
| kbsp1938 | Sniper (KBP SP — no PumpAction despite being a bolt-action in real life) |
| luger | Pistol |
| m1a1 | Carbine |
| m1garand | Rifle (garand ping) |
| m30 | Drilling (rifle barrel — has secondary fire for shotgun barrel, but primary is semi-auto mag) |
| model21 | Sawed-off shotgun (no shell reload, standard mag) |
| no2 | Pistol |
| p38 | Pistol |
| ptrs41 | Anti-tank rifle |
| svt40 | Rifle |
| type5 | Rifle |

**Count: 14 weapons**

---

## Type 2: Full-Auto Magazine (No Rechamber, No Selective Fire)
**Mechanics:** Hold trigger for continuous fire. No bolt/pump cycle. Standard magazine reload. No fire-mode toggle.

| Weapon | Notes |
|--------|-------|
| arsenal | SMG |
| austen | SMG |
| bechowiec | SMG |
| beretta38 | SMG |
| blyskawica | SMG |
| breda30 | LMG |
| bren | LMG |
| chatellerault | LMG |
| emp44 | Rifle |
| erma | SMG |
| greasegun | SMG |
| lad | LMG |
| lewis | LMG |
| m1919 | LMG |
| m1928a1 | SMG (Thompson) |
| m2hyde | SMG |
| m712 | Pistol (full-auto Mauser) |
| mas38 | SMG |
| mg15 | LMG |
| mg42 | LMG |
| mg81 | LMG |
| mp28 | SMG |
| mp40 | SMG |
| nambu | Pistol (full-auto) |
| ribey | Rifle |
| sten | SMG |
| sterling | SMG |
| stinger | LMG |
| theclassic | SMG (PPSh) |
| thompson | SMG |
| type100 | SMG |
| vmg27 | LMG |
| zk383 | SMG |

**Count: 33 weapons**

---

## Type 3: Selective-Fire Magazine (Semi ↔ Full toggle, No Rechamber)
**Mechanics:** Can toggle between Semi-Auto and Full-Auto via E+M2. Standard magazine reload. No bolt/pump cycle.

| Weapon | Notes |
|--------|-------|
| as44 | Rifle |
| avs36 | Rifle |
| bar | Rifle/LMG |
| charlton | Rifle |
| federov | Rifle |
| fg42 | Rifle |
| grossfuss | Rifle/LMG |
| kgm21 | LMG |
| m1941 | Rifle/LMG |
| m2carbine | Carbine |
| stg44 | Rifle |
| volk | Rifle |
| walther | Pistol |
| wimmer | Rifle |

**Count: 14 weapons**

---

## Type 4: Burst-Only (ITRA Burst)
**Mechanics:** Only fires in burst mode (4-round burst). Cannot toggle to semi or full. Standard magazine reload.

| Weapon | BurstCount | Notes |
|--------|------------|-------|
| pg1935 | 4 | ITRA Burst rifle |

**Count: 1 weapon**

---

## Type 5: Bolt-Action Sniper (Rechamber After Every Shot)
**Mechanics:** Semi-auto fire, but after each shot a bolt-cycle animation plays (ACT_VM_PULLBACK_HIGH/LOW). Fire is locked for PumpDelay seconds. Standard magazine reload.

| Weapon | Notes |
|--------|-------|
| arisaka | Sniper |
| delisle | Sniper (suppressed) |
| enfield | Sniper |
| kar98k | Sniper |
| mosin | Sniper |
| sdk | Sniper |
| springfield | Sniper |
| wz35 | Sniper (anti-tank rifle) |

**Count: 8 weapons**

---

## Type 6: Pump-Action Shotgun (Shell-by-Shell Reload + Pump Rechamber)
**Mechanics:** Semi-auto fire, pump animation after each shot (ACT_VM_PULLBACK_HIGH). Shell-by-shell reload (start → loop → finish). Fire locked for PumpDelay.

| Weapon | Notes |
|--------|-------|
| mas36 | Shotgun (MAS-36) |
| model1897 | Shotgun (Combat Shotgun) |
| winchester94 | Shotgun (Lever-action — uses same pump mechanics) |

**Count: 3 weapons**

---

## Type 7: Revolver Shotgun (Shell Reload, No Pump)
**Mechanics:** Shotgun=true (shell-by-shell reload) but no PumpAction. Semi-auto fire with no rechamber.

| Weapon | Notes |
|--------|-------|
| m1879 | Reichsrevolver |

**Count: 1 weapon**

---

## Type 8: Projectile Launcher
**Mechanics:** Fires a projectile entity instead of bullets. No standard fire/reload patterns — each has unique projectile + reload logic.

| Weapon | Projectile | Notes |
|--------|------------|-------|
| 1911_upgraded | codww2_mustang_exp | Mustang Sally (PaP 1911) |
| bazooka | wavy_missile | Rocket launcher |
| crossbow | codww2_bolt_default | Crossbow |
| fliegerfaust | wavy_missile | 3-round burst rocket |
| panzer | wavy_missile | Panzerschreck |

**Count: 5 weapons**

---

## Type 9: Flamethrower
**Mechanics:** Continuous fire beam/particle, fuel consumption, no traditional reload. Unique base class.

| Weapon | Notes |
|--------|-------|
| flamethrower | M2 Flamethrower (American) |
| flammenwerfer35 | Flammenwerfer 35 (German) |

**Count: 2 weapons**

---

## Type 10: Melee
**Mechanics:** No ranged fire. Swing-based damage trace. Unique melee base.

| Weapon | Notes |
|--------|-------|
| baseball_bat | |
| claymore | Sword |
| combatknife | |
| dagger | |
| fireaxe | |
| icepick | |
| shovel | |
| sledgehammer | |
| trenchknife | |

**Count: 9 weapons**

---

## Summary Table

| Type | Name | Count | Key Mechanic |
|------|------|-------|--------------|
| 1 | Semi-Auto Magazine | 14 | Semi fire, mag reload, no rechamber |
| 2 | Full-Auto Magazine | 33 | Auto fire, mag reload, no toggle |
| 3 | Selective-Fire Magazine | 14 | Semi↔Full toggle, mag reload |
| 4 | Burst-Only | 1 | 4-round burst, mag reload |
| 5 | Bolt-Action Sniper | 8 | Semi fire + bolt rechamber, mag reload |
| 6 | Pump-Action Shotgun | 3 | Semi fire + pump rechamber, shell reload |
| 7 | Revolver Shotgun | 1 | Semi fire, shell reload, no rechamber |
| 8 | Projectile Launcher | 5 | Projectile entity, unique reload |
| 9 | Flamethrower | 2 | Continuous beam, fuel system |
| 10 | Melee | 9 | Swing trace, no ranged fire |
| **Total** | | **90** | |

Note: `flamebase` is a base class, not a weapon. Total playable weapons = 90 (91 files - 1 base).

---

## Template Mapping

Each functional type maps to a CUH base template:

| Type | Template | Base CUH Class | Overrides Needed |
|------|----------|----------------|------------------|
| 1 | `template_semi` | weapon_cuh_base_gun | PrimaryAttack (melee), Think (idle/inspect/sprint), ShootAnimation |
| 2 | `template_auto` | weapon_cuh_base_gun | Same as Type 1 (Automatic=true) |
| 3 | `template_selective` | weapon_cuh_base_gun | Same as Type 1 + FireModes table |
| 4 | `template_burst` | weapon_cuh_base_gun | Same as Type 1 + FireModes.shoot + FireBurstRound + CustomThink |
| 5 | `template_bolt` | weapon_cuh_base_gun | Same as Type 1 + PostShoot (rechamber timer) |
| 6 | `template_shotgun` | weapon_cuh_base_gun | Same as Type 1 + PostShoot (pump) + ReloadShotgun + CustomThink |
| 7 | `template_revolver_sg` | weapon_cuh_base_gun | Same as Type 1 + ReloadShotgun + CustomThink (no PostShoot pump) |
| 8 | `template_launcher` | weapon_cuh_base_gun | Unique per weapon — no template, port individually |
| 9 | `template_flamethrower` | weapon_cuh_base_gun | Unique base — port individually |
| 10 | `template_melee` | weapon_custom_uh_base_melee | Inherit from melee base |
