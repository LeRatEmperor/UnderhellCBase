# STENCIL enumeration

**Realm:** Client  ·  **Constants:** 16

Enumerations for use with [render.SetStencilCompareFunction](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction).

The comparison is between the reference value set by [render.SetStencilReferenceValue](https://wiki.facepunch.com/gmod/render.SetStencilReferenceValue), and the value of each pixel in the stencil buffer.

These enumerations are mirrors of [STENCILCOMPARISONFUNCTION](https://wiki.facepunch.com/gmod/Enums/STENCILCOMPARISONFUNCTION).

Also see this corresponding MSDN entry: https://msdn.microsoft.com/en-us/library/windows/desktop/ff476101%28v=vs.85%29.aspx.

[wiki page](https://wiki.facepunch.com/gmod/Enums/STENCIL)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `STENCIL_ALWAYS` | `8` | Client | Always passes. |
| `STENCIL_DECR` | `8` | Client | Decrements the value in the stencil buffer by 1, wrapping around on overflow. |
| `STENCIL_DECRSAT` | `5` | Client | Decrements the value in the stencil buffer by 1, clamping the result. |
| `STENCIL_EQUAL` | `3` | Client | Passes where the reference value is equal to the stencil value. |
| `STENCIL_GREATER` | `5` | Client | Passes where the reference value is greater than the stencil value. |
| `STENCIL_GREATEREQUAL` | `7` | Client | Passes where the reference value is greater than or equal to the stencil value. |
| `STENCIL_INCR` | `7` | Client | Increments the value in the stencil buffer by 1, wrapping around on overflow. |
| `STENCIL_INCRSAT` | `4` | Client | Increments the value in the stencil buffer by 1, clamping the result. |
| `STENCIL_INVERT` | `6` | Client | Inverts the value in the stencil buffer. |
| `STENCIL_KEEP` | `1` | Client | Preserves the existing stencil buffer value. |
| `STENCIL_LESS` | `2` | Client | Passes where the reference value is less than the stencil value. |
| `STENCIL_LESSEQUAL` | `4` | Client | Passes where the reference value is less than or equal to the stencil value. |
| `STENCIL_NEVER` | `1` | Client | Never passes. |
| `STENCIL_NOTEQUAL` | `6` | Client | Passes where the reference value is not equal to the stencil value. |
| `STENCIL_REPLACE` | `3` | Client | Sets the value in the stencil buffer to the reference value, set using render.SetStencilReferenceValue. |
| `STENCIL_ZERO` | `2` | Client | Sets the value in the stencil buffer to 0. |
