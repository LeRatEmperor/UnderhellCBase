# RT_SIZE enumeration

**Realm:** Client  ·  **Constants:** 10

Enumerations used by [GetRenderTargetEx](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx). Clientside only.

[wiki page](https://wiki.facepunch.com/gmod/Enums/RT_SIZE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `RT_SIZE_DEFAULT` | `1` | Client | Don't play with the specified width and height other than making sure it fits in the framebuffer. |
| `RT_SIZE_FULL_FRAME_BUFFER` | `4` | Client | Same size as frame buffer, or next lower power of 2 if we can't do that. |
| `RT_SIZE_FULL_FRAME_BUFFER_ROUNDED_UP` | `6` | Client | Same size as the frame buffer, rounded up if necessary for systems that can't do non-power of two textures. |
| `RT_SIZE_HDR` | `3` | Client | frame_buffer_width / 4 |
| `RT_SIZE_LITERAL` | `8` | Client | Use the size passed in. |
| `RT_SIZE_LITERAL_PICMIP` | `9` | Client | Use the size passed in, don't clamp to the frame buffer size, but do apply picmip restrictions. |
| `RT_SIZE_NO_CHANGE` | `0` | Client | Only allowed for render targets that don't want a depth buffer (because if they have a depth buffer, the render target must be less than or equal to the size of the framebuffer). |
| `RT_SIZE_OFFSCREEN` | `5` | Client | Target of specified size, don't mess with dimensions |
| `RT_SIZE_PICMIP` | `2` | Client | Apply picmip to the render target's width and height. |
| `RT_SIZE_REPLAY_SCREENSHOT` | `7` | Client | Rounded down to power of 2, essentially |
