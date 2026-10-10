# EF enumeration

**Realm:** Shared  ·  **Constants:** 12

Enumerations used by [Entity:AddEffects](https://wiki.facepunch.com/gmod/Entity:AddEffects),  [Entity:RemoveEffects](https://wiki.facepunch.com/gmod/Entity:RemoveEffects) and  [Entity:IsEffectActive](https://wiki.facepunch.com/gmod/Entity:IsEffectActive).

[wiki page](https://wiki.facepunch.com/gmod/Enums/EF)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `EF_BONEMERGE` | `1` | Shared | Performs bone merge on client side, merging bone positions of child entities (Entity:SetParent) with those of the parent, by bone names. |
| `EF_BONEMERGE_FASTCULL` | `128` | Shared | For use with EF_BONEMERGE. |
| `EF_BRIGHTLIGHT` | `2` | Shared | DLIGHT centered at entity origin. |
| `EF_DIMLIGHT` | `4` | Shared | Player flashlight. |
| `EF_FOLLOWBONE` | `1024` | Shared | Internal flag that is set by Entity:FollowBone. |
| `EF_ITEM_BLINK` | `256` | Shared | Makes the entity blink. |
| `EF_NODRAW` | `32` | Shared | Prevents the entity from drawing and networking. |
| `EF_NOFLASHLIGHT` | `8192` | Shared | GMod-specific. |
| `EF_NOINTERP` | `8` | Shared | Don't interpolate the next frame. _(DEPRECATED)_ |
| `EF_NORECEIVESHADOW` | `64` | Shared | Don't receive shadows. |
| `EF_NOSHADOW` | `16` | Shared | Disables shadow. |
| `EF_PARENT_ANIMATES` | `512` | Shared | Always assume that the parent entity is animating. |
