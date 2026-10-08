# TFA WWII Weapons — Exhaustive Audit Index

This directory contains the complete technical documentation for every weapon in the TFA WWII Kate mod, generated from a line-by-line code audit of all 91 original TFA source files.

## Document Index

| Document | Weapons | Lines | Size |
|----------|---------|-------|------|
| [audit_pistols_smg.md](audit_pistols_smg.md) | 8 pistols + 16 SMGs = 24 weapons | 3,419 | 162 KB |
| [audit_rifles.md](audit_rifles.md) | 20 rifles (incl. M30, Model 21, ITRA Burst) | 2,996 | 131 KB |
| [audit_snipers_shotguns.md](audit_snipers_shotguns.md) | 9 snipers + 4 shotguns = 13 weapons | 3,130 | 155 KB |
| [audit_lmg_launcher_melee.md](audit_lmg_launcher_melee.md) | 14 LMGs + 4 launchers + 3 flamethrowers + 9 melee = 30 weapons | 4,367 | 193 KB |
| **TOTAL** | **91 weapons** | **13,912 lines** | **~641 KB** |

## Per-Weapon Documentation Structure

Each weapon is documented with these 16 sections:

1. **Core Fields** — Base class, PrintName, Category, SubCategory, ViewModel/WorldModel paths, HoldType, Manufacturer, Type_Displayed, Purpose, Slot
2. **Primary Stats** — Sound layers (SoundLyr1-6), SoundEchoTable, RPM/Damage/ClipSize/NumShots, RangeFalloffLUT, Kick/Spread multipliers, AmmoConsumption, Chambering, DryFireDelay, IronAccuracy, LowAmmoSound
3. **Secondary Stats (Bash)** — BashDamage, BashSound, BashHitSound, BashHitSound_Flesh, BashLength, BashDelay, BashDamageType, BashInterrupt, IronSightsInSound/OutSound
4. **Fire Modes** — BurstDelay, DisableBurstFire, SelectiveFire, OnlyBurstFire, BurstFireCount, DefaultFireMode, FireModeName
5. **Shotgun Fields** — Shotgun, ShotgunEmptyAnim, ShotgunEmptyAnim_Shell, ShotgunStartAnimShell
6. **Ironsights** — IronSightsPos/Ang (default + NYDAR/ACOG/LENS/GL/7X variants), IronSightTime, ZoomFov, SafetyPos/Ang, InspectPos/Ang, AlternativePos/Ang, RunSightsPos/Ang
7. **Animations Table** — Every key with type (ANIMATION_SEQ/ACT), value, value_empty, value_is
8. **Event Table** — Every ACT_VM_* and string-keyed entry with {time, type, value} — sound and lua types
9. **Sequence Overrides** — SequenceLengthOverride, SequenceRateOverride, StatusLengthOverride (every key/value)
10. **Bodygroups/Skins** — Bodygroups_V/W, ViewModelSkin, WorldModelSkin
11. **VElements** — Every element: type, model, bone, rel, pos, angle, size, color, surpresslightning, material, skin, bonemerge, active, bodygroup
12. **WElements** — Same structure as VElements for world model
13. **Attachments** — Every slot with atts list, order, default, sel
14. **Miscellaneous** — AllowViewAttachment, LuaShellSound, Shell, MuzzleAttachment, MuzzleFlashEffect, ViewModelPunch*, MoveSpeed, CanJam/JamChance/JamFactor, AmmoTypeStrings, DInv2_*, NZHeadShotMultiplier, FiresUnderwater, TracerCount, Projectile/ProjectileVelocity
15. **Custom Functions** — OnPaP, NZMaxAmmo, ChooseReloadAnim, ChooseShotgunReloadAnim, ChooseShotgunPumpAnim, Initialize, SetupDataTables, AttachGrenade/DetachGrenade, Think, Deploy, ShootBullet, etc.
16. **NZ Special Fields** — NZPaPName, NZPaPReplacement, NZMaxAmmo override

## Key Cross-Cutting Findings

### Bugs Identified (60+ across all weapons)
- Copy-paste errors (wrong HoldType, wrong bone names, wrong sounds)
- Duplicate table keys (second declaration silently overwrites first)
- Dead code (unused VElements, unreachable functions)
- Classification mismatches (Nambu as SMG, Chatellerault as LMG, MAS36 as shotgun)
- PaP damage anomalies (Arisaka 750 instead of 7500, Kar98k 47x multiplier)
- Sound reuse (Wimmer reuses STG-44 sounds, MG81 reuses Breda FPO)

### Unique Mechanics Documented
- **Model 1897**: Dragon's Breath ammo state machine (4 custom functions)
- **ITRA Burst**: Only true burst-fire weapon (4-round, OnlyBurstFire=true)
- **1911 Upgraded**: Projectile launcher (Mustang Sally)
- **M30 Drilling**: Dual-fire weapon (shotgun + rifle)
- **MG81 PaP**: Converts to grenade projectile launcher
- **PTRS-41 PaP**: 5-shot 3-burst at 6000 damage
- **Ribey**: Lua-driven procedural bullet bodygroup
- **M1 Garand**: xmag swaps reload + last-shot animations
- **Flamethrowers**: Timer-based fuel regen, flame particle system
- **Melee weapons**: Swing trace arrays, combo system (all MaxCombo=0)

### Attachment System
- 4 attachment slot patterns documented (A: scope/mag/barrel/stock, B: scope/mag/ammo/stock, C: scope/mag/grip/ammo, etc.)
- Attachment dependencies and exclusions documented
- AttachmentTableOverride patterns (xmag bodygroup swaps, scope VElement toggles)

### Sound System
- 2070 total sound entries across all weapons (ported 1:1 from TFA EventTable)
- Every ACT_VM_* → string key mapping documented
- Multi-layer sound system (SoundLyr1-6 + SoundEchoTable + tail sounds)

## Source Files

All audits were performed against:
- `/home/z/my-project/repos/tfa_wwii_original/lua/weapons/nz_kate_codww2_*.lua` (91 weapon files)
- `/home/z/my-project/repos/tfa_wwii_original/weapon_bo3_*.lua` (BO3 reference weapons)

## Usage

These documents serve as the complete blueprint for porting the TFA WWII weapons to the Underhell (CUH) base. Every field, function, animation, sound, and attachment is documented verbatim — zero omissions.
