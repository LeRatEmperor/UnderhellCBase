# RENDERGROUP enumeration

**Realm:** Shared  ·  **Constants:** 10

Enumerations used by [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel), `ENT.RenderGroup` in [Structures/ENT](https://wiki.facepunch.com/gmod/Structures/ENT) and [Entity:GetRenderGroup](https://wiki.facepunch.com/gmod/Entity:GetRenderGroup).

[wiki page](https://wiki.facepunch.com/gmod/Enums/RENDERGROUP)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `RENDERGROUP_BOTH` | `9` | Shared | For both translucent/transparent and opaque/solid anim entities For scripted entities, this will have both, ENTITY:Draw and ENTITY:DrawTranslucent called |
| `RENDERGROUP_OPAQUE` | `7` | Shared | For non transparent/solid entities. |
| `RENDERGROUP_OPAQUE_BRUSH` | `12` | Shared | For brush entities |
| `RENDERGROUP_OPAQUE_HUGE` | `1` | Shared | Huge opaque entity, possibly leftover from goldsrc |
| `RENDERGROUP_OTHER` | `13` | Shared | Unclassfied. |
| `RENDERGROUP_STATIC` | `6` | Shared | Static props? |
| `RENDERGROUP_STATIC_HUGE` | `0` | Shared | Huge static prop, possibly leftover from goldsrc |
| `RENDERGROUP_TRANSLUCENT` | `8` | Shared | For translucent/transparent entities For scripted entities, this will have ENTITY:DrawTranslucent called |
| `RENDERGROUP_VIEWMODEL` | `10` | Shared | Solid weapon view models |
| `RENDERGROUP_VIEWMODEL_TRANSLUCENT` | `11` | Shared | Transparent overlays etc |
