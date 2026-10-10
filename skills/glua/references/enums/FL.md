# FL enumeration

**Realm:** Shared  ·  **Constants:** 32

Enumerations used by [Entity:AddFlags](https://wiki.facepunch.com/gmod/Entity:AddFlags), [Entity:RemoveFlags](https://wiki.facepunch.com/gmod/Entity:RemoveFlags) and [Entity:IsFlagSet](https://wiki.facepunch.com/gmod/Entity:IsFlagSet).

[wiki page](https://wiki.facepunch.com/gmod/Enums/FL)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `FL_AIMTARGET` | `131072` | Shared | This entity can be aimed at |
| `FL_ANIMDUCKING` | `4` | Shared | Is the player in the process of ducking or standing up |
| `FL_ATCONTROLS` | `128` | Shared | This player is controlling something UI related in the world, this prevents his movement, but doesn't freeze mouse movement, jumping, etc. |
| `FL_BASEVELOCITY` | `16777216` | Shared | Base velocity has been applied this frame (used to convert base velocity into momentum) |
| `FL_CLIENT` | `256` | Shared | Is this entity a player or not |
| `FL_CONVEYOR` | `8192` | Shared | This entity is a func_conveyor |
| `FL_DISSOLVING` | `536870912` | Shared | The entity is currently dissolving |
| `FL_DONTTOUCH` | `8388608` | Shared | Doesn't generate touch functions, calls ENTITY:EndTouch when this flag gets set during a touch callback |
| `FL_DUCKING` | `2` | Shared | Is player ducking or not |
| `FL_FAKECLIENT` | `512` | Shared | Bots have this flag |
| `FL_FLY` | `2048` | Shared | This entity can fly |
| `FL_FROZEN` | `64` | Shared | Completely freezes the player |
| `FL_GODMODE` | `32768` | Shared | Whether the player has god mode enabled |
| `FL_GRAPHED` | `1048576` | Shared | worldgraph has this ent listed as something that blocks a connection |
| `FL_GRENADE` | `2097152` | Shared | This entity is a grenade, unused |
| `FL_INRAIN` | `32` | Shared | Indicates the entity is standing in rain |
| `FL_INWATER` | `1024` | Shared | Is the player in water or not |
| `FL_KILLME` | `134217728` | Shared | This entity is about to get removed |
| `FL_NOTARGET` | `65536` | Shared | Makes the entity invisible to AI |
| `FL_NPC` | `16384` | Shared | NPCs have this flag (NPC: Ignore player push) |
| `FL_OBJECT` | `67108864` | Shared | This entity can be seen by NPCs |
| `FL_ONFIRE` | `268435456` | Shared | This entity is on fire |
| `FL_ONGROUND` | `1` | Shared | Is the entity on ground or not |
| `FL_ONTRAIN` | `16` | Shared | This player is controlling a func_train |
| `FL_PARTIALGROUND` | `262144` | Shared | Not all corners are valid |
| `FL_STATICPROP` | `524288` | Shared | It's a static prop |
| `FL_STEPMOVEMENT` | `4194304` | Shared | Changes the SV_Movestep() behavior to not do any processing |
| `FL_SWIM` | `4096` | Shared | This entity can swim |
| `FL_TRANSRAGDOLL` | `1073741824` | Shared | This entity is about to become a ragdoll |
| `FL_UNBLOCKABLE_BY_PLAYER` | `-2147483648` | Shared | This moving door can't be blocked by the player |
| `FL_WATERJUMP` | `8` | Shared | The player is jumping out of water |
| `FL_WORLDBRUSH` | `33554432` | Shared | This entity is a brush and part of the world |
