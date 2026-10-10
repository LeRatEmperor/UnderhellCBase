# STENCILOPERATION enumeration

**Realm:** Client  ·  **Constants:** 8

Enumerations for use with [render.SetStencilPassOperation](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation), [render.SetStencilFailOperation](https://wiki.facepunch.com/gmod/render.SetStencilFailOperation) and [render.SetStencilZFailOperation](https://wiki.facepunch.com/gmod/render.SetStencilZFailOperation). Clientside only.


Also see this corresponding MSDN entry: http://msdn.microsoft.com/en-us/library/windows/desktop/ff476219%28v=vs.85%29.aspx.

[wiki page](https://wiki.facepunch.com/gmod/Enums/STENCILOPERATION)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `STENCILOPERATION_DECR` | `8` | Client | Decrements the value in the stencil buffer by 1, wrapping around on overflow. |
| `STENCILOPERATION_DECRSAT` | `5` | Client | Decrements the value in the stencil buffer by 1, clamping the result. |
| `STENCILOPERATION_INCR` | `7` | Client | Increments the value in the stencil buffer by 1, wrapping around on overflow. |
| `STENCILOPERATION_INCRSAT` | `4` | Client | Increments the value in the stencil buffer by 1, clamping the result. |
| `STENCILOPERATION_INVERT` | `6` | Client | Inverts the value in the stencil buffer. |
| `STENCILOPERATION_KEEP` | `1` | Client | Preserves the existing stencil buffer value. |
| `STENCILOPERATION_REPLACE` | `3` | Client | Sets the value in the stencil buffer to the reference value, set using render.SetStencilReferenceValue. |
| `STENCILOPERATION_ZERO` | `2` | Client | Sets the value in the stencil buffer to 0. |
