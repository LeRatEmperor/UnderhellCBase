# FVPHYSICS enumeration

**Realm:** Shared  ·  **Constants:** 13

Enumerations used by [PhysObj:AddGameFlag](https://wiki.facepunch.com/gmod/PhysObj:AddGameFlag), [PhysObj:HasGameFlag](https://wiki.facepunch.com/gmod/PhysObj:HasGameFlag) and [PhysObj:ClearGameFlag](https://wiki.facepunch.com/gmod/PhysObj:ClearGameFlag).

[wiki page](https://wiki.facepunch.com/gmod/Enums/FVPHYSICS)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `FVPHYSICS_CONSTRAINT_STATIC` | `2` | Shared | Won't receive physics forces from collisions and won't collide with other PhysObj with the same flag set. |
| `FVPHYSICS_DMG_DISSOLVE` | `512` | Shared | Colliding with entities will cause 1000 damage with DMG_DISSOLVE as the damage type, but only if EFL_NO_DISSOLVE is not set. |
| `FVPHYSICS_DMG_SLICE` | `1` | Shared | Does slice damage, not just blunt damage. |
| `FVPHYSICS_HEAVY_OBJECT` | `32` | Shared | Will deal high physics damage even with a small mass. |
| `FVPHYSICS_MULTIOBJECT_ENTITY` | `16` | Shared | This PhysObj is part of an entity with multiple PhysObj , such as a ragdoll or a vehicle , and will be considered during collision damage events. |
| `FVPHYSICS_NO_IMPACT_DMG` | `1024` | Shared | Colliding with entities won't cause physics damage. |
| `FVPHYSICS_NO_NPC_IMPACT_DMG` | `2048` | Shared | Like FVPHYSICS_NO_NPC_IMPACT_DMG, but only checks for NPCs. |
| `FVPHYSICS_NO_PLAYER_PICKUP` | `128` | Shared | Doesn't allow the player to pick this PhysObj with the Gravity Gun or +use pickup. |
| `FVPHYSICS_NO_SELF_COLLISIONS` | `32768` | Shared | We won't collide with other PhysObj associated to the same entity, only used for vehicles and ragdolls held by the Super Gravity Gun. |
| `FVPHYSICS_PART_OF_RAGDOLL` | `8` | Shared | This PhysObj is part of a ragdoll. |
| `FVPHYSICS_PENETRATING` | `64` | Shared | Set by the physics engine when two PhysObj are penetrating each other. |
| `FVPHYSICS_PLAYER_HELD` | `4` | Shared | Set when the player is holding this PhysObj with the Physics Gun, Gravity Gun or +use pickup. |
| `FVPHYSICS_WAS_THROWN` | `256` | Shared | This object was thrown by the Gravity Gun , stuns Antlion guards, Hunters, and squashes Antlion grubs. |
