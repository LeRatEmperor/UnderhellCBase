# COLLISION_GROUP enumeration

**Realm:** Shared  ·  **Constants:** 23

Enumerations used by [Entity:SetCollisionGroup](https://wiki.facepunch.com/gmod/Entity:SetCollisionGroup), [Entity:GetCollisionGroup](https://wiki.facepunch.com/gmod/Entity:GetCollisionGroup) and [Traces](https://wiki.facepunch.com/gmod/Structures/Trace#collisiongroup).

[wiki page](https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `COLLISION_GROUP_BREAKABLE_GLASS` | `6` | Shared | NPCs can see straight through an Entity with this applied. |
| `COLLISION_GROUP_DEBRIS` | `1` | Shared | Collides with nothing but world and static stuff |
| `COLLISION_GROUP_DEBRIS_TRIGGER` | `2` | Shared | Same as debris, but hits triggers. |
| `COLLISION_GROUP_DISSOLVING` | `16` | Shared | Things that are dissolving are in this group |
| `COLLISION_GROUP_DOOR_BLOCKER` | `14` | Shared | Blocks entities not permitted to get near moving doors |
| `COLLISION_GROUP_HL2_SPIT` | `22` | Shared | Half-Life 2 exclusive collision group, acts similarly to `COLLISION_GROUP_PROJECTILE` but is also ignored by player movement. |
| `COLLISION_GROUP_IN_VEHICLE` | `10` | Shared | Doesn't collide with anything, no traces |
| `COLLISION_GROUP_INTERACTIVE` | `4` | Shared | Collides with everything except interactive debris or debris |
| `COLLISION_GROUP_INTERACTIVE_DEBRIS` | `3` | Shared | Collides with everything except other interactive debris or debris |
| `COLLISION_GROUP_NONE` | `0` | Shared | Normal |
| `COLLISION_GROUP_NPC` | `9` | Shared | Generic NPC group |
| `COLLISION_GROUP_NPC_ACTOR` | `18` | Shared | Used so NPCs in scripts ignore the player |
| `COLLISION_GROUP_NPC_SCRIPTED` | `19` | Shared | Used for NPCs in scripts that should not collide with each other |
| `COLLISION_GROUP_PASSABLE_DOOR` | `15` | Shared | Lets the Player through, nothing else. |
| `COLLISION_GROUP_PLAYER` | `5` | Shared | Used by players, but NOT for movement collision. |
| `COLLISION_GROUP_PLAYER_MOVEMENT` | `8` | Shared | For HL2, same as Collision_Group_Player, for TF2, this filters out other players and CBaseObjects |
| `COLLISION_GROUP_PROJECTILE` | `13` | Shared | Set on projectiles. |
| `COLLISION_GROUP_PUSHAWAY` | `17` | Shared | Nonsolid on client and server, pushaway in player code |
| `COLLISION_GROUP_VEHICLE` | `7` | Shared | Used by driveable vehicles. |
| `COLLISION_GROUP_VEHICLE_CLIP` | `12` | Shared | Only collides with vehicles |
| `COLLISION_GROUP_WEAPON` | `11` | Shared | Doesn't collide with players and vehicles |
| `COLLISION_GROUP_WORLD` | `20` | Shared | Doesn't collide with players/props |
| `LAST_SHARED_COLLISION_GROUP` | `21` | Shared | Amount of COLLISION_GROUP_ enumerations |
