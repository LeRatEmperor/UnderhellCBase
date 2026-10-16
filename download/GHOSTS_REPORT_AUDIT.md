# GHOSTS WEAPONS — EXHAUSTIVE RE-PORT AUDIT

## What went wrong with the first port

1. **No AnimSounds tables** — The port script converted EventTable entries but failed because of regex issues. Weapons had NO sound timing data.
2. **TFA fields left in** — StaticRecoilFactor, IronAccuracy, LuaShell*, ViewModelPunch*, etc. were not stripped.
3. **nZombies functions left in** — OnPaP, NZMaxAmmo, PreDrawViewModel, NZHeadShotMultiplier were kept.
4. **Merged lines** — Regex replacement concatenated lines like `0.2SWEP.Primary.`.
5. **No structure** — Weapons weren't formatted like the WWII Kate weapons (clean sections, comments, consistent field ordering).
6. **Wrong base class** — Used weapon_custom_uh_base_gun instead of weapon_cuh_base_gun (user wants CUH base with customization toggle).

## Target structure (from WWII Kate weapons)

Each weapon file should have these sections in order:
1. Header comment (name, source, template)
2. AddCSLuaFile + DEFINE_BASECLASS + SWEP.Base
3. PrintName, Category, SubCategory, Slot, Spawnable
4. Appearance (UseHands, ViewModelFlip, ViewModelFOV, ViewModel, WorldModel, LoweredPos/Ang)
5. UseQCReloadEvents, UseReloadTable
6. HoldType, PassiveAnim, ZoomFov
7. FireModes table
8. Primary stats (Sound, ClipSize, Ammo, DefaultClip, MinDamage, MaxDamage, Automatic, TakeAmmo, Force, Spread, Delay, NumberofShots, MinRecoil, MaxRecoil, KickUp, KickDown, KickHorizontal, SpreadMultiplierMax, SpreadIncrement, SpreadRecovery)
9. TwoHanded, ReloadSpeed, Chambering, AnimatedSprint
10. Ironsights (IronSightsPos, IronSightsAng, IronSightTime, SwayPosition, AlternativePos/Ang)
11. RunSightsPos/Ang
12. IronSightsDipPos/Ang/Scale
13. CameraAttachment, CameraReserve, CameraOffset
14. MuzzleAttachment, MuzzleFlashType, MuzzleFlashParticle, MuzzleFlashLightColor/Size
15. Melee stats (MeleeDamage, MeleeRange, MeleeDelay, etc.)
16. Shell ejection (NoShell, ShellHeat, Shell)
17. WorldModelOffset, WorldModelAngle
18. Animations table (all keys: shoot, shoot_last, fire_ads, iron_fire, idle, idle_empty, deploy, holster, draw_first, melee, melee_empty, inspect, inspect_empty, reload, reload_empty, sprint_idle, sprint_in, sprint_out)
19. AnimSounds table (all sound timing entries, converted from EventTable: time=N/30 → seconds, Sound("...") → "...")
20. GetDisplay, GetMuzzle, GetShellEject (attachment auto-detect)
21. ShootAnimation override
22. HandleSprintingAnimations, HandleIdle, HandleInspect
23. PrimaryAttack, SecondaryAttack, Reload overrides (if needed)
24. Think override (if needed)
25. Holster, Deploy overrides
26. ViewModelElements, WorldModelElements (empty for non-customizable)
27. Attachments (empty for non-customizable)

## Customization toggle

Add `SWEP.Customizable = false` to non-customizable weapons.
The CUH base needs to check this flag and skip the attachment menu/UI for non-customizable weapons.

## Per-weapon audit

### Standard Assault Rifles (10)
- ak12, fad, honeybadger, ia2, maverick, mk14, msbs, remington, sa805, sc2010
- All have: EventTable (7-16 sounds), SprintAnimation, PaP
- No special systems
- Port: Standard template, convert EventTable → AnimSounds

### LMGs (5)
- ameli, chainsaw, lsat, m27_lmg, minigun
- ameli, lsat: Belt chain Think2 (bodygroup based on clip count)
- chainsaw: Grenade secondary (projectile), custom SecondaryAttack
- minigun: Custom crosshair, spin-up Think3, ViewModelBoneMods
- m27_lmg: Standard
- Port: Standard template + custom Think for belt chain/spin-up

### Shotguns (5)
- bulldog, fp6, mts225, tac12, usr
- fp6: Multi-stage ChooseReloadAnim (5 reload animations, lua callbacks for ammo)
- tac12: Shell-by-shell shotgun reload (TFA Shotgun=true)
- usr: PumpAction sniper/shotgun
- bulldog, mts225: Standard pump shotguns
- Port: Shotgun template, custom reload for FP6

### Snipers (3)
- l115, svu, usr
- l115: Custom Think2 (camera lerp during ADS)
- svu: Standard semi-auto sniper
- usr: Pump-action (PumpAction table)
- Port: Sniper template with ZoomFov

### Pistols (1)
- m9a1: Standard pistol, PaP transforms into projectile launcher
- Port: Pistol template

### Launchers (1)
- panzerfaust: Projectile launcher, custom Think2, PreSpawnProjectile
- Port: Launcher template with projectile system

## EventTable → AnimSounds conversion

Each EventTable entry has:
- Key: ACT_VM_* (needs mapping to string key)
- Entries: { time = N/30, type = "sound", value = Sound("...") }
- Some entries have type = "lua" (lua callbacks for ammo management) — these CANNOT be ported to AnimSounds and need custom timer-based code

ACT key mapping:
- ACT_VM_DRAW → "deploy"
- ACT_VM_DRAW_EMPTY → "deploy_empty"  
- ACT_VM_HOLSTER → "holster"
- ACT_VM_HOLSTER_EMPTY → "holster_empty"
- ACT_VM_RELOAD → "reload"
- ACT_VM_RELOAD_EMPTY → "reload_empty"
- ACT_VM_PRIMARYATTACK → "shoot"
- ACT_VM_PULLBACK_HIGH → "rechamber"
- ACT_VM_PULLBACK_LOW → "rechamber_ads"
- ACT_VM_RELOAD_SILENCED → "reload_sil"
- ACT_VM_RELOAD2 → "reload_2"
- ACT_RELOAD_LOW → "reload_2" (or "reload_3" depending on weapon)

Time conversion: N/30 → N÷30 seconds (e.g., 10/30 = 0.3333)
Sound wrapper: Sound("name") → "name" (just the string)

## What to strip

- ALL nZombies functions: OnPaP, NZMaxAmmo, PreDrawViewModel, NZHeadShotMultiplier, NZPaPName, Ispackapunched, nzPaPCamo
- ALL TFA-specific fields: ViewModelPunch*, ChangeState*, Crouch*, Jump*, Wall*, Walk* multipliers, StaticRecoilFactor, IronAccuracy, IronRecoilMultiplier, IronBobMult*, MoveSpeed, IronSightsMoveSpeed, LuaShell*, RPM_Displayed/Semi/Burst, DryFireDelay, AmmoConsumption, SoundLyr1, SilencedSound, VMPos*, VMAng*, TPIKPos, InspectPos, InspectAng, Manufacturer, Type_Displayed, PumpAction, Shotgun*, CameraAttachmentOffsets, CameraAttachmentScale, ViewModelBoneMods, Sprint_Mode, Sights_Mode, Idle_Mode, Idle_Blend, Idle_Smooth, SprintBobMult, AllowViewAttachment, StatusLengthOverride, SequenceRateOverride, SpeedColaActivities, DTapActivities, DrawCrosshairIS, data.ironsights, Primary.Range, Primary.RangeFalloff, Primary.PenetrationPower, Primary.Knockback, DisableChambering, SelectiveFire, BurstFireCount, Offset table (convert to WorldModelOffset/Angle)
- ALL TFA.Enum references
- ALL TFA.GetStatus, self:GetStat, self:GetIronSightsProgress, self:ChooseAnimation, self:ClearStatCache, self:GetPrimaryAmmoType calls

## What to keep

- ViewModel, WorldModel, ViewModelFOV
- Primary.Sound, Primary.Ammo, Primary.Automatic, Primary.ClipSize, Primary.DefaultClip
- Primary.Spread, IronSightsPos, IronSightsAng, IronSightTime
- Secondary.IronFOV → ZoomFov
- Offset → WorldModelOffset + WorldModelAngle + WorldModelScale
- SprintAnimation → AnimatedSprint + Animations sprint keys
- EventTable → AnimSounds (sound entries only, not lua callbacks)
