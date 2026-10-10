# SURF enumeration

**Realm:** Shared  ·  **Constants:** 16

Surface flags, used by the [Structures/TraceResult](https://wiki.facepunch.com/gmod/Structures/TraceResult).

[wiki page](https://wiki.facepunch.com/gmod/Enums/SURF)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SURF_BUMPLIGHT` | `2048` | Shared | Calculate three lightmaps for the surface for bumpmapping |
| `SURF_HINT` | `256` | Shared | Make a primary bsp splitter |
| `SURF_HITBOX` | `32768` | Shared | This surface is part of an entity's hitbox |
| `SURF_LIGHT` | `1` | Shared | Value will hold the light strength |
| `SURF_NOCHOP` | `16384` | Shared | Don't subdivide patches on this surface |
| `SURF_NODECALS` | `8192` | Shared | No decals are applied to this surface |
| `SURF_NODRAW` | `128` | Shared | This surface is an invisible entity, equivalent to HitNoDraw in Structures/TraceResult |
| `SURF_NOLIGHT` | `1024` | Shared | This surface has no lights calculated |
| `SURF_NOPORTAL` | `32` | Shared | This surface cannot have portals placed on, used by Portal's gun |
| `SURF_NOSHADOWS` | `4096` | Shared | No shadows are cast on this surface |
| `SURF_SKIP` | `512` | Shared | This surface can be ignored by impact effects |
| `SURF_SKY` | `4` | Shared | This surface is a skybox, equivalent to HitSky in Structures/TraceResult |
| `SURF_SKY2D` | `2` | Shared | The surface is a 2D skybox |
| `SURF_TRANS` | `16` | Shared | This surface is translucent |
| `SURF_TRIGGER` | `64` | Shared | This surface is a trigger |
| `SURF_WARP` | `8` | Shared | This surface is animated water |
