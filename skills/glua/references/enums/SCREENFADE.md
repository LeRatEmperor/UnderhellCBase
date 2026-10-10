# SCREENFADE enumeration

**Realm:** Shared  ·  **Constants:** 5

Bitflags used by [Player:ScreenFade](https://wiki.facepunch.com/gmod/Player:ScreenFade).

[wiki page](https://wiki.facepunch.com/gmod/Enums/SCREENFADE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `SCREENFADE.IN` | `1` | Shared | Instant fade in, slowly fade out (based on fade time given) after the hold time has passed |
| `SCREENFADE.MODULATE` | `4` | Shared | Instead of blending multiple active screen fades, modulate them. |
| `SCREENFADE.OUT` | `2` | Shared | Slowly fade in (based on fade time given), hold time passes, instantly disappear |
| `SCREENFADE.PURGE` | `16` | Shared | Used to purge all currently active screen fade effects, meant to be used in conjunction with flags above as a "priority effect". |
| `SCREENFADE.STAYOUT` | `8` | Shared | Never disappear. |
