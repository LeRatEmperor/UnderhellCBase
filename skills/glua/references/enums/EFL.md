# EFL enumeration

**Realm:** Shared  ·  **Constants:** 32

Enumerations used by [Entity:AddEFlags](https://wiki.facepunch.com/gmod/Entity:AddEFlags), [Entity:RemoveEFlags](https://wiki.facepunch.com/gmod/Entity:RemoveEFlags) and [Entity:IsEFlagSet](https://wiki.facepunch.com/gmod/Entity:IsEFlagSet).

[wiki page](https://wiki.facepunch.com/gmod/Enums/EFL)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `EFL_BOT_FROZEN` | `256` | Shared | This is set on bots that are frozen |
| `EFL_CHECK_UNTOUCH` | `16777216` | Shared | The entity is about to have its untouch callback checked, e.g. |
| `EFL_DIRTY_ABSANGVELOCITY` | `8192` | Shared | Some 'dirty' bits with respect to absolute computations. |
| `EFL_DIRTY_ABSTRANSFORM` | `2048` | Shared | Some 'dirty' bits with respect to absolute computations. |
| `EFL_DIRTY_ABSVELOCITY` | `4096` | Shared | Some 'dirty' bits with respect to absolute computations. |
| `EFL_DIRTY_SHADOWUPDATE` | `32` | Shared | (Client only) need shadow manager to update the shadow |
| `EFL_DIRTY_SPATIAL_PARTITION` | `32768` | Shared | Used internally by the engine when an entity's "spatial partition" needs to be recalculated. |
| `EFL_DIRTY_SURROUNDING_COLLISION_BOUNDS` | `16384` | Shared | Marks the entity as having a 'dirty' surrounding box. |
| `EFL_DONTBLOCKLOS` | `33554432` | Shared | Entity shouldn't block NPC line-of-sight |
| `EFL_DONTWALKON` | `67108864` | Shared | NPCs should not walk on this entity |
| `EFL_DORMANT` | `2` | Shared | Entity is dormant, no updates to client |
| `EFL_FORCE_CHECK_TRANSMIT` | `128` | Shared | The default behavior in ShouldTransmit is to not send an entity if it doesn't have a model. |
| `EFL_HAS_PLAYER_CHILD` | `16` | Shared | One of the child entities is a player |
| `EFL_IN_SKYBOX` | `131072` | Shared | This is set if the entity detects that it's in the skybox. |
| `EFL_IS_BEING_LIFTED_BY_BARNACLE` | `1048576` | Shared | The entity is currently being lifted by a Barnacle. |
| `EFL_KEEP_ON_RECREATE_ENTITIES` | `16` | Shared | This is a special entity that should not be deleted when we respawn entities via game.CleanUpMap. |
| `EFL_KILLME` | `1` | Shared | This entity is marked for death -- This allows the game to actually delete ents at a safe time. |
| `EFL_NO_AUTO_EDICT_ATTACH` | `1024` | Shared | Don't attach the edict |
| `EFL_NO_DAMAGE_FORCES` | `-2147483648` | Shared | Doesn't accept forces from physics damage |
| `EFL_NO_DISSOLVE` | `134217728` | Shared | The entity shouldn't dissolve |
| `EFL_NO_GAME_PHYSICS_SIMULATION` | `8388608` | Shared | The entity is currently not simulating any physics. |
| `EFL_NO_MEGAPHYSCANNON_RAGDOLL` | `268435456` | Shared | Mega physcannon can't ragdoll these guys |
| `EFL_NO_PHYSCANNON_INTERACTION` | `1073741824` | Shared | Physcannon can't pick these up or punt them |
| `EFL_NO_ROTORWASH_PUSH` | `2097152` | Shared | The entity is not affected by 'rotorwash push'--the wind-push effect caused by helicopters close to the ground in Half-Life 2. |
| `EFL_NO_THINK_FUNCTION` | `4194304` | Shared | Avoid executing the entity's Think |
| `EFL_NO_WATER_VELOCITY_CHANGE` | `536870912` | Shared | Don't adjust this entity's velocity when transitioning into water |
| `EFL_NOCLIP_ACTIVE` | `4` | Shared | Lets us know when the noclip command is active |
| `EFL_NOTIFY` | `64` | Shared | Another entity is watching events on this entity (used by teleport) |
| `EFL_SERVER_ONLY` | `512` | Shared | Non-networked entity |
| `EFL_SETTING_UP_BONES` | `8` | Shared | Set while a model is setting up its bones |
| `EFL_TOUCHING_FLUID` | `524288` | Shared | Used to determine if an entity is floating |
| `EFL_USE_PARTITION_WHEN_NOT_SOLID` | `262144` | Shared | Entities with this flag set show up in the partition even when not solid |
