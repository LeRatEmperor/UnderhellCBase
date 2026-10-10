# SOUND enumeration

**Realm:** Server  ·  **Constants:** 28

Enumerations used by [sound.EmitHint](https://wiki.facepunch.com/gmod/sound.EmitHint).

[wiki page](https://wiki.facepunch.com/gmod/Enums/SOUND)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SOUND_BUGBAIT` | `512` | Server | Gets the antlion's attention. |
| `SOUND_BULLET_IMPACT` | `16` | Server |  |
| `SOUND_CARCASS` | `32` | Server | Considered a scent. |
| `SOUND_COMBAT` | `1` | Server |  |
| `SOUND_CONTEXT_ALLIES_ONLY` | `268435456` | Server | Only player allies can hear this sound. |
| `SOUND_CONTEXT_COMBINE_ONLY` | `8388608` | Server | Only combine can hear sounds marked this way. |
| `SOUND_CONTEXT_DANGER_APPROACH` | `134217728` | Server | Treat as a normal danger sound if you see the source, otherwise turn to face source. |
| `SOUND_CONTEXT_EXCLUDE_COMBINE` | `67108864` | Server | Combine do NOT hear this |
| `SOUND_CONTEXT_EXPLOSION` | `33554432` | Server | Context added to SOUND_COMBAT, usually. |
| `SOUND_CONTEXT_FROM_SNIPER` | `1048576` | Server | Additional context for SOUND_DANGER |
| `SOUND_CONTEXT_GUNFIRE` | `2097152` | Server | Added to SOUND_COMBAT |
| `SOUND_CONTEXT_MORTAR` | `4194304` | Server | Explosion going to happen here. |
| `SOUND_CONTEXT_PLAYER_VEHICLE` | `536870912` | Server | HACK: need this because we're not treating the SOUND_xxx values as true bit values! |
| `SOUND_CONTEXT_REACT_TO_SOURCE` | `16777216` | Server | React to sound source's origin, not sound's location |
| `SOUND_DANGER` | `8` | Server |  |
| `SOUND_DANGER_SNIPERONLY` | `2048` | Server | Only scares the sniper NPC. |
| `SOUND_GARBAGE` | `128` | Server | Considered a scent. |
| `SOUND_MEAT` | `64` | Server | Considered a scent. |
| `SOUND_MOVE_AWAY` | `4096` | Server |  |
| `SOUND_NONE` | `0` | Server |  |
| `SOUND_PHYSICS_DANGER` | `1024` | Server |  |
| `SOUND_PLAYER` | `4` | Server |  |
| `SOUND_PLAYER_VEHICLE` | `8192` | Server |  |
| `SOUND_READINESS_HIGH` | `65536` | Server |  |
| `SOUND_READINESS_LOW` | `16384` | Server | Changes listener's readiness (Player Companion only) |
| `SOUND_READINESS_MEDIUM` | `32768` | Server |  |
| `SOUND_THUMPER` | `256` | Server | Keeps certain creatures at bay, such as Antlions. |
| `SOUND_WORLD` | `2` | Server |  |
