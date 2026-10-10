# SND enumeration

**Realm:** Shared  ·  **Constants:** 11

Sound flags used by [EmitSound](https://wiki.facepunch.com/gmod/Global.EmitSound) and [Entity:EmitSound](https://wiki.facepunch.com/gmod/Entity:EmitSound).

[wiki page](https://wiki.facepunch.com/gmod/Enums/SND)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SND_CHANGE_PITCH` | `2` | Shared | Change sound pitch. |
| `SND_CHANGE_VOL` | `1` | Shared | Change sound volume. |
| `SND_DELAY` | `16` | Shared | Sound has an initial delay. |
| `SND_DO_NOT_OVERWRITE_EXISTING_ON_CHANNEL` | `1024` | Shared | Unused/legacy; does nothing. |
| `SND_IGNORE_NAME` | `512` | Shared | Used to change all sounds (e.g. |
| `SND_IGNORE_PHONEMES` | `256` | Shared | If the sound has any associated phoneme (character lip-sync) data, ignore it. |
| `SND_NOFLAGS` | `0` | Shared | To keep the compiler happy |
| `SND_SHOULDPAUSE` | `128` | Shared | This sound should be paused if the game is paused. |
| `SND_SPAWNING` | `8` | Shared | We're spawning, used in some cases for ambients. |
| `SND_STOP` | `4` | Shared | Stop the sound. |
| `SND_STOP_LOOPING` | `32` | Shared | Stop all looping sounds on the entity. |
