# SF enumeration

**Realm:** Server  ·  **Constants:** 34

Enumerations describing certain spawnflags. Everything except for SF_PHYS* and SF_WEAPON* is serverside only.

Spawnflags are set using [Entity:SetKeyValue](https://wiki.facepunch.com/gmod/Entity:SetKeyValue) with **"spawnflags"** as the key, or using [Entity:SetSpawnFlags](https://wiki.facepunch.com/gmod/Entity:SetSpawnFlags), [Entity:AddSpawnFlags](https://wiki.facepunch.com/gmod/Entity:AddSpawnFlags), [Entity:RemoveSpawnFlags](https://wiki.facepunch.com/gmod/Entity:RemoveSpawnFlags).

* SF_CITIZEN_* spawnflags represent spawnflags only usable on [npc_citizen](https://developer.valvesoftware.com/wiki/Npc_citizen).
* SF_NPC_* - Usable on all NPCs
* SF_PHYSBOX_* - Usable on [func_physbox](https://developer.valvesoftware.com/wiki/Func_physbox)
* SF_PHYSPROP_* - Usable on [prop_physics](https://developer.valvesoftware.com/wiki/Prop_physics) entities
* SF_WEAPON_* - Usable on [Weapons](https://wiki.facepunch.com/gmod/Weapon)

[wiki page](https://wiki.facepunch.com/gmod/Enums/SF)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SF_CITIZEN_AMMORESUPPLIER` | `524288` | Server | Citizen that resupplies ammo |
| `SF_CITIZEN_FOLLOW` | `65536` | Server | "Follow the player as soon as I spawn" |
| `SF_CITIZEN_IGNORE_SEMAPHORE` | `2097152` | Server | "Work outside the speech semaphore system" |
| `SF_CITIZEN_MEDIC` | `131072` | Server | Makes the citizen a medic |
| `SF_CITIZEN_NOT_COMMANDABLE` | `1048576` | Server | Citizen cannot join players squad, and will not able to be commanded by the Half-Life 2 command system for Citizens |
| `SF_CITIZEN_RANDOM_HEAD` | `262144` | Server | Gives the citizen a random head |
| `SF_CITIZEN_RANDOM_HEAD_FEMALE` | `8388608` | Server | Gives the citizen a random female head |
| `SF_CITIZEN_RANDOM_HEAD_MALE` | `4194304` | Server | Gives the citizen a random male head |
| `SF_CITIZEN_USE_RENDER_BOUNDS` | `16777216` | Server | "Use render bounds instead of human hull for guys sitting in chairs, etc". |
| `SF_FLOOR_TURRET_CITIZEN` | `512` | Server | Makes the floor turret friendly |
| `SF_NPC_ALTCOLLISION` | `4096` | Server | Do Alternate collision for this NPC (player avoidance) |
| `SF_NPC_ALWAYSTHINK` | `1024` | Server | Think outside PVS |
| `SF_NPC_DROP_HEALTHKIT` | `8` | Server | NPC Drops health kit when it dies. |
| `SF_NPC_FADE_CORPSE` | `512` | Server | Fade Corpse |
| `SF_NPC_FALL_TO_GROUND` | `4` | Server | If not set, means *teleport* to ground |
| `SF_NPC_GAG` | `2` | Server | No IDLE sounds until angry |
| `SF_NPC_LONG_RANGE` | `256` | Server | Long Visibility/Shoot |
| `SF_NPC_NO_PLAYER_PUSHAWAY` | `16384` | Server | Ignore player push - Don't give way to player |
| `SF_NPC_NO_WEAPON_DROP` | `8192` | Server | NPC Doesn't drop weapon on death |
| `SF_NPC_START_EFFICIENT` | `16` | Server | Don't acquire enemies or avoid obstacles |
| `SF_NPC_TEMPLATE` | `2048` | Server | This entity is a template for the npc_template_maker. |
| `SF_NPC_WAIT_FOR_SCRIPT` | `128` | Server | Wait for script |
| `SF_NPC_WAIT_TILL_SEEN` | `1` | Server | Wait till seen |
| `SF_PHYSBOX_ALWAYS_PICK_UP` | `1048576` | Server | Gravity gun is ALWAYS allowed to pick this up. |
| `SF_PHYSBOX_MOTIONDISABLED` | `32768` | Server | If set, calls PhysObj:EnableMotion( false ) on the func_physbox when the physics are created |
| `SF_PHYSBOX_NEVER_PICK_UP` | `2097152` | Server | Gravity gun is NOT allowed to pick this up. |
| `SF_PHYSBOX_NEVER_PUNT` | `4194304` | Server | Gravity gun is NOT allowed to punt this entity. |
| `SF_PHYSPROP_IS_GIB` | `4194304` | Server | This flag is set if the entity is gib. |
| `SF_PHYSPROP_MOTIONDISABLED` | `8` | Server | If set, calls PhysObj:EnableMotion( false ) on the func_physbox when the physics are created. |
| `SF_PHYSPROP_PREVENT_PICKUP` | `512` | Server | Prevent that physbox from being picked up. |
| `SF_ROLLERMINE_FRIENDLY` | `65536` | Server | Makes the rollermine friendly. |
| `SF_WEAPON_NO_PHYSCANNON_PUNT` | `4` | Server | Physgun is NOT allowed to pick this up. |
| `SF_WEAPON_NO_PLAYER_PICKUP` | `2` | Server | Player is NOT allowed to pick this up. |
| `SF_WEAPON_START_CONSTRAINED` | `1` | Server | If set before Entity:Spawn, the weapon will be constrained and will not simply fall to the ground. |
