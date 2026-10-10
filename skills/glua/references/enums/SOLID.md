# SOLID enumeration

**Realm:** Shared  ·  **Constants:** 7

For use with [Entity:PhysicsInit](https://wiki.facepunch.com/gmod/Entity:PhysicsInit), [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid) and [Entity:GetSolid](https://wiki.facepunch.com/gmod/Entity:GetSolid).

[wiki page](https://wiki.facepunch.com/gmod/Enums/SOLID)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SOLID_BBOX` | `2` | Shared | Uses the entity's axis-aligned bounding box for collisions. |
| `SOLID_BSP` | `1` | Shared | The entity has a brush model defined by the map. |
| `SOLID_CUSTOM` | `5` | Shared | Always call the entity's `ICollideable::TestCollision` method for traces regardless of the presence of `FSOLID_CUSTOMRAYTEST` or `FSOLID_CUSTOMBOXTEST`. |
| `SOLID_NONE` | `0` | Shared | Does not collide with anything. |
| `SOLID_OBB` | `3` | Shared | Uses the entity's object-aligned bounding box for collisions. |
| `SOLID_OBB_YAW` | `4` | Shared | Same as SOLID_OBB but restricts orientation to the Z-axis. |
| `SOLID_VPHYSICS` | `6` | Shared | Uses the PhysObjects of the entity. |
