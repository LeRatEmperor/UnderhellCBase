# NAV_MESH enumeration

**Realm:** Server  ·  **Constants:** 22

Enumerations used by [CNavArea:GetAttributes](https://wiki.facepunch.com/gmod/CNavArea:GetAttributes) and [CNavArea:HasAttributes](https://wiki.facepunch.com/gmod/CNavArea:HasAttributes).

[wiki page](https://wiki.facepunch.com/gmod/Enums/NAV_MESH)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `NAV_MESH_AVOID` | `128` | Server | Avoid this area unless alternatives are too dangerous |
| `NAV_MESH_BLOCKED_LUA` | `65536` | Server | Whether the area is blocked via CNavArea:MarkAsBlocked. |
| `NAV_MESH_BLOCKED_PROPDOOR` | `268435456` | Server | Whether the area has a `prop_door_rotating` that is blocking it (because the door is closed) |
| `NAV_MESH_CLIFF` | `32768` | Server | This nav area is adjacent to a drop of at least `CliffHeight` (300 hammer units). |
| `NAV_MESH_CROUCH` | `1` | Server | Must crouch to use this node/area |
| `NAV_MESH_DONT_HIDE` | `512` | Server | Area should not be considered for hiding spot generation |
| `NAV_MESH_FUNC_COST` | `536870912` | Server | Area has designer specified cost controlled by `func_nav_cost` entities |
| `NAV_MESH_HAS_ELEVATOR` | `1073741824` | Server | Area is in an elevator's path |
| `NAV_MESH_INVALID` | `0` | Server | The nav area is invalid. |
| `NAV_MESH_JUMP` | `2` | Server | Must jump to traverse this area (only used during generation) |
| `NAV_MESH_NAV_BLOCKER` | `-2147483648` | Server | Whether the area is blocked by a `func_nav_blocker` entity and is impassible. |
| `NAV_MESH_NO_HOSTAGES` | `2048` | Server | Hostages shouldn't use this area |
| `NAV_MESH_NO_JUMP` | `8` | Server | Inhibit discontinuity jumping |
| `NAV_MESH_NO_MERGE` | `8192` | Server | Don't merge this area with adjacent areas |
| `NAV_MESH_OBSTACLE_TOP` | `16384` | Server | This nav area is the climb point on the tip of an obstacle |
| `NAV_MESH_PRECISE` | `4` | Server | Do not adjust for obstacles, just move along area |
| `NAV_MESH_RUN` | `32` | Server | Must run to traverse this area |
| `NAV_MESH_STAIRS` | `4096` | Server | This area represents stairs, do not attempt to climb or jump them - just walk up |
| `NAV_MESH_STAND` | `1024` | Server | Bots hiding in this area should stand |
| `NAV_MESH_STOP` | `16` | Server | Must stop when entering this area |
| `NAV_MESH_TRANSIENT` | `256` | Server | Area may become blocked, and should be periodically checked |
| `NAV_MESH_WALK` | `64` | Server | Must walk to traverse this area |
