# FSOLID enumeration

**Realm:** Shared  ·  **Constants:** 11

Enumerations used by [Entity:SetSolidFlags](https://wiki.facepunch.com/gmod/Entity:SetSolidFlags) and [Entity:GetSolidFlags](https://wiki.facepunch.com/gmod/Entity:GetSolidFlags).

[wiki page](https://wiki.facepunch.com/gmod/Enums/FSOLID)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `FSOLID_CUSTOMBOXTEST` | `2` | Shared | Ignore solid type + always call into the entity for swept box tests |
| `FSOLID_CUSTOMRAYTEST` | `1` | Shared | Ignore solid type + always call into the entity for ray tests |
| `FSOLID_FORCE_WORLD_ALIGNED` | `64` | Shared | Forces the collision representation to be world-aligned even if it's SOLID_BSP or SOLID_VPHYSICS |
| `FSOLID_MAX_BITS` | `10` | Shared | The amount of bits needed to store the all the flags in a variable/sent over network. |
| `FSOLID_NOT_SOLID` | `4` | Shared | The object is currently not solid |
| `FSOLID_NOT_STANDABLE` | `16` | Shared | The player can't stand on this |
| `FSOLID_ROOT_PARENT_ALIGNED` | `256` | Shared | Collisions are defined in root parent's local coordinate space |
| `FSOLID_TRIGGER` | `8` | Shared | This is something may be collideable but fires touch functions even when it's not collideable (when the FSOLID_NOT_SOLID flag is set) |
| `FSOLID_TRIGGER_TOUCH_DEBRIS` | `512` | Shared | This trigger will touch debris objects |
| `FSOLID_USE_TRIGGER_BOUNDS` | `128` | Shared | Uses a special trigger bounds separate from the normal OBB |
| `FSOLID_VOLUME_CONTENTS` | `32` | Shared | Contains volumetric contents (like water) |
