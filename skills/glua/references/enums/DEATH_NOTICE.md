# DEATH_NOTICE enumeration

**Realm:** Shared  ·  **Constants:** 2

Enumerations used internally by death notice system.

This enumeration is a bit field/bitflag, which means that you can combine multiple death flags using the [bit](https://wiki.facepunch.com/gmod/bit) library. You can use [bit.band](https://wiki.facepunch.com/gmod/bit.band) to test if a specific death flag is set.

[wiki page](https://wiki.facepunch.com/gmod/Enums/DEATH_NOTICE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `DEATH_NOTICE_FRIENDLY_ATTACKER` | `2` | Shared | Was the attacker friendly? |
| `DEATH_NOTICE_FRIENDLY_VICTIM` | `1` | Shared | Was the victim friendly? |
