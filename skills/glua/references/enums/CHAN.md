# CHAN enumeration

**Realm:** Shared  ·  **Constants:** 11

Enumerations used by [EmitSound](https://wiki.facepunch.com/gmod/Global.EmitSound) and [sound.Add](https://wiki.facepunch.com/gmod/sound.Add).

[wiki page](https://wiki.facepunch.com/gmod/Enums/CHAN)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `CHAN_AUTO` | `0` | Shared | Automatic channel |
| `CHAN_BODY` | `4` | Shared | Clothing, ragdoll impacts, footsteps, knocking/pounding/punching etc. |
| `CHAN_ITEM` | `3` | Shared | Channel for items ( Health kits, etc ) |
| `CHAN_REPLACE` | `-1` | Shared | Used when playing sounds through console commands. |
| `CHAN_STATIC` | `6` | Shared | A constant/background sound that doesn't require any reaction. |
| `CHAN_STREAM` | `5` | Shared | Stream channel from the static or dynamic area |
| `CHAN_USER_BASE` | `136` | Shared | Channels from this and onwards are allocated to game code |
| `CHAN_VOICE` | `2` | Shared | Channel for NPC voices |
| `CHAN_VOICE2` | `7` | Shared | TF2s Announcer dialogue channel |
| `CHAN_VOICE_BASE` | `8` | Shared | Channels 8-135 (128 channels) are allocated for player voice chat This channel allows same sounds files to play multiple times without cutting out. |
| `CHAN_WEAPON` | `1` | Shared | Channel for weapon sounds |
