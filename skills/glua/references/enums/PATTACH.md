# PATTACH enumeration

**Realm:** Shared  ·  **Constants:** 6

Enumerations used by [ParticleEffectAttach](https://wiki.facepunch.com/gmod/Global.ParticleEffectAttach).

[wiki page](https://wiki.facepunch.com/gmod/Enums/PATTACH)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `PATTACH_ABSORIGIN` | `0` | Shared | Particle spawns in entity's origin and does not follow it |
| `PATTACH_ABSORIGIN_FOLLOW` | `1` | Shared | Particle attaches to entity's origin and follows the entity |
| `PATTACH_CUSTOMORIGIN` | `2` | Shared | Create at a custom origin, but don't follow |
| `PATTACH_POINT` | `3` | Shared | Particle attaches to passed to ParticleEffectAttach attachment id, but does not follow the entity |
| `PATTACH_POINT_FOLLOW` | `4` | Shared | Particle attaches to passed to ParticleEffectAttach attachment id and follows the entity |
| `PATTACH_WORLDORIGIN` | `5` | Shared | Particle spawns in the beginning of coordinates ( Vector( 0, 0, 0 ) ), used for control points that don't attach to an entity |
