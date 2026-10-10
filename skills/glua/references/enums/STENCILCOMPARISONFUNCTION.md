# STENCILCOMPARISONFUNCTION enumeration

**Realm:** Client  ·  **Constants:** 8

Enumerations for use with [render.SetStencilCompareFunction](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction).

The comparison is between the reference value set by [render.SetStencilReferenceValue](https://wiki.facepunch.com/gmod/render.SetStencilReferenceValue), and the value of each pixel in the stencil buffer.

Clientside only.


Also see this corresponding MSDN entry: http://msdn.microsoft.com/en-us/library/windows/desktop/ff476101%28v=vs.85%29.aspx.

[wiki page](https://wiki.facepunch.com/gmod/Enums/STENCILCOMPARISONFUNCTION)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `STENCILCOMPARISONFUNCTION_ALWAYS` | `8` | Client | Always passes. |
| `STENCILCOMPARISONFUNCTION_EQUAL` | `3` | Client | Passes where the reference value is equal to the stencil value. |
| `STENCILCOMPARISONFUNCTION_GREATER` | `5` | Client | Passes where the reference value is greater than the stencil value. |
| `STENCILCOMPARISONFUNCTION_GREATEREQUAL` | `7` | Client | Passes where the reference value is greater than or equal to the stencil value. |
| `STENCILCOMPARISONFUNCTION_LESS` | `2` | Client | Passes where the reference value is less than the stencil value. |
| `STENCILCOMPARISONFUNCTION_LESSEQUAL` | `4` | Client | Passes where the reference value is less than or equal to the stencil value. |
| `STENCILCOMPARISONFUNCTION_NEVER` | `1` | Client | Never passes. |
| `STENCILCOMPARISONFUNCTION_NOTEQUAL` | `6` | Client | Passes where the reference value is not equal to the stencil value. |
