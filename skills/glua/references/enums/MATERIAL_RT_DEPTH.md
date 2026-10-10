# MATERIAL_RT_DEPTH enumeration

**Realm:** Client  ·  **Constants:** 4

Enumerations used by [GetRenderTargetEx](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx). Clientside only.

[wiki page](https://wiki.facepunch.com/gmod/Enums/MATERIAL_RT_DEPTH)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MATERIAL_RT_DEPTH_NONE` | `2` | Client | Do not create a depth-stencil buffer.Disable depth and stencil buffer usage if used as render target 0. |
| `MATERIAL_RT_DEPTH_ONLY` | `3` | Client | Create a depth-stencil buffer.Use the created depth-stencil buffer if used as render target 0. |
| `MATERIAL_RT_DEPTH_SEPARATE` | `1` | Client | Create a depth-stencil buffer.Use the created depth-stencil buffer if used as render target 0. |
| `MATERIAL_RT_DEPTH_SHARED` | `0` | Client | Do not create a depth-stencil buffer.Use the default depth-stencil buffer if used as render target 0. |
