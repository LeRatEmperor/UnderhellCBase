# MOVECOLLIDE enumeration

**Realm:** Shared  ·  **Constants:** 5

Enumerations used by [Entity:SetMoveCollide](https://wiki.facepunch.com/gmod/Entity:SetMoveCollide) and [Entity:GetMoveCollide](https://wiki.facepunch.com/gmod/Entity:GetMoveCollide).

[wiki page](https://wiki.facepunch.com/gmod/Enums/MOVECOLLIDE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MOVECOLLIDE_COUNT` | `4` | Shared | Number of different movecollides |
| `MOVECOLLIDE_DEFAULT` | `0` | Shared | Default behavior |
| `MOVECOLLIDE_FLY_BOUNCE` | `1` | Shared | Entity bounces, reflects, based on elasticity of surface and object - applies friction (adjust velocity) |
| `MOVECOLLIDE_FLY_CUSTOM` | `2` | Shared | ENTITY:ResolveCustomFlyCollision will modify the velocity however it likes |
| `MOVECOLLIDE_FLY_SLIDE` | `3` | Shared | Entity slides along surfaces (no bounce) - applies friciton (adjusts velocity) |
