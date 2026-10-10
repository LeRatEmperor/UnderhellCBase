# DMG enumeration

**Realm:** Shared  ·  **Constants:** 33

Enumerations used by [CTakeDamageInfo:GetDamageType](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamageType), [CTakeDamageInfo:SetDamageType](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageType) and [CTakeDamageInfo:IsDamageType](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsDamageType).

This enumeration is a bit field/bitflag, which means that you can combine multiple damage types using the [bit](https://wiki.facepunch.com/gmod/bit) library. You can use [bit.band](https://wiki.facepunch.com/gmod/bit.band) to test if a specific damage type is set.

[wiki page](https://wiki.facepunch.com/gmod/Enums/DMG)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `DMG_ACID` | `1048576` | Shared | Toxic chemical or acid burn damage used by the Antlion Workers |
| `DMG_AIRBOAT` | `33554432` | Shared | Airboat gun damage |
| `DMG_ALWAYSGIB` | `8192` | Shared | Always create gibs |
| `DMG_BLAST` | `64` | Shared | Explosion damage like grenades, helicopter bombs, combine mines, Will be ignored by most vehicle passengers. |
| `DMG_BLAST_SURFACE` | `134217728` | Shared | This won't hurt the player underwater |
| `DMG_BUCKSHOT` | `536870912` | Shared | The pellets fired from a shotgun |
| `DMG_BULLET` | `2` | Shared | Bullet damage from Ceiling Turrets, the Strider, Turrets and most guns. |
| `DMG_BURN` | `8` | Shared | Damage from fire |
| `DMG_CLUB` | `128` | Shared | Blunt attacks such as from the Crowbar, Antlion Guard & Hunter |
| `DMG_CRUSH` | `1` | Shared | Caused by physics interaction and ignored by airboat drivers. |
| `DMG_DIRECT` | `268435456` | Shared | Direct damage to the entity that does not go through any damage value modifications |
| `DMG_DISSOLVE` | `67108864` | Shared | Forces the entity to dissolve on death. |
| `DMG_DROWN` | `16384` | Shared | Drown damage |
| `DMG_DROWNRECOVER` | `524288` | Shared | Damage applied to the player to restore health after drowning |
| `DMG_ENERGYBEAM` | `1024` | Shared | Laser damage |
| `DMG_FALL` | `32` | Shared | Fall damage |
| `DMG_GENERIC` | `0` | Shared | Generic damage (used by weapon_fists) |
| `DMG_MISSILEDEFENSE` | `2147483648` | Shared | Damage from npc_missiledefense, npc_combinegunship, or monster_mortar |
| `DMG_NERVEGAS` | `65536` | Shared | Neurotoxin damage |
| `DMG_NEVERGIB` | `4096` | Shared | Crossbow damage, never creates gibs. |
| `DMG_PARALYZE` | `32768` | Shared | Same as DMG_POISON |
| `DMG_PHYSGUN` | `8388608` | Shared | Damage done by the gravity gun. |
| `DMG_PLASMA` | `16777216` | Shared | Plasma damage |
| `DMG_POISON` | `131072` | Shared | Poison damage used by Antlion Workers & Poison Headcrabs. |
| `DMG_PREVENT_PHYSICS_FORCE` | `2048` | Shared | Prevent a physics force. |
| `DMG_RADIATION` | `262144` | Shared | Radiation damage & it will be ignored by most vehicle passengers |
| `DMG_REMOVENORAGDOLL` | `4194304` | Shared | Don't create a ragdoll on death |
| `DMG_SHOCK` | `256` | Shared | Electrical damage, shows smoke at the damage position and its used by Stalkers & Vortigaunts |
| `DMG_SLASH` | `4` | Shared | Used by the Stunstick, Manhacks, Antlions, Antlion Guards, Headcrabs, Fast Headcrabs, all Zombies types, Hunter, and potentially other NPCs attacks |
| `DMG_SLOWBURN` | `2097152` | Shared | In an oven |
| `DMG_SNIPER` | `1073741824` | Shared | Damage from SniperRound/SniperPenetratedRound ammo types |
| `DMG_SONIC` | `512` | Shared | Sonic damage, used by the Gargantua and Houndeye NPCs |
| `DMG_VEHICLE` | `16` | Shared | Hit by a vehicle (This will need to be set for passengers of some vehicle to receive damage) |
