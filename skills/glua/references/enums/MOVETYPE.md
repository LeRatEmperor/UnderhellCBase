# MOVETYPE enumeration

**Realm:** Shared  ·  **Constants:** 12

Enumerations used by [Entity:SetMoveType](https://wiki.facepunch.com/gmod/Entity:SetMoveType) and [Entity:GetMoveType](https://wiki.facepunch.com/gmod/Entity:GetMoveType).

[wiki page](https://wiki.facepunch.com/gmod/Enums/MOVETYPE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MOVETYPE_CUSTOM` | `11` | Shared | Custom movetype, can be applied to the player to prevent the default movement code from running, while still calling the related hooks |
| `MOVETYPE_FLY` | `4` | Shared | Fly, no gravity |
| `MOVETYPE_FLYGRAVITY` | `5` | Shared | Fly, with gravity |
| `MOVETYPE_ISOMETRIC` | `1` | Shared | For players, in TF2 commander view, etc |
| `MOVETYPE_LADDER` | `9` | Shared | For players, when moving on a ladder |
| `MOVETYPE_NOCLIP` | `8` | Shared | Noclip |
| `MOVETYPE_NONE` | `0` | Shared | Don't move |
| `MOVETYPE_OBSERVER` | `10` | Shared | Spectator movetype. |
| `MOVETYPE_PUSH` | `7` | Shared | Doesn't collide with the world, but does push and crush entities. |
| `MOVETYPE_STEP` | `3` | Shared | Monster/NPC movement |
| `MOVETYPE_VPHYSICS` | `6` | Shared | Physics movetype |
| `MOVETYPE_WALK` | `2` | Shared | Player only, moving on the ground |
