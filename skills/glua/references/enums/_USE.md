# _USE enumeration

**Realm:** Shared  ·  **Constants:** 4

Enumerations used by [Entity:SetUseType](https://wiki.facepunch.com/gmod/Entity:SetUseType). Affects when [ENTITY:Use](https://wiki.facepunch.com/gmod/ENTITY:Use) is triggered.

Not to be confused with [USE](https://wiki.facepunch.com/gmod/Enums/USE) used for [ENTITY:Use](https://wiki.facepunch.com/gmod/ENTITY:Use) and others.

[wiki page](https://wiki.facepunch.com/gmod/Enums/_USE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `CONTINUOUS_USE` | `0` | Shared | Fire a USE_ON signal every tick as long as the player holds their use key and aims at the target. |
| `DIRECTIONAL_USE` | `2` | Shared | Like a wheel turning. |
| `ONOFF_USE` | `1` | Shared | Fires a USE_ON signal when starting to use an entity, and a USE_OFF signal when letting go. |
| `SIMPLE_USE` | `3` | Shared | Fire a USE_ON signal only once when player presses their use key while aiming at the target. |
