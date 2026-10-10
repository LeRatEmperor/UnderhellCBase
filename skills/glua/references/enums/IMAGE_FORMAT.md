# IMAGE_FORMAT enumeration

**Realm:** Client  ·  **Constants:** 10

Enumerations used by [GetRenderTargetEx](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx) to determine the byte format of each pixel in the [Render Target](https://wiki.facepunch.com/gmod/render_rendertargets).

[wiki page](https://wiki.facepunch.com/gmod/Enums/IMAGE_FORMAT)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `IMAGE_FORMAT_ABGR8888` | `1` | Client | Probably legacy format. |
| `IMAGE_FORMAT_ARGB8888` | `11` | Client | `IMAGE_FORMAT_RGBA8888` with different byte order. |
| `IMAGE_FORMAT_BGR888` | `3` | Client | Legacy format. |
| `IMAGE_FORMAT_BGRA8888` | `12` | Client | `IMAGE_FORMAT_RGBA8888` with different byte order. |
| `IMAGE_FORMAT_DEFAULT` | `-1` | Client |  |
| `IMAGE_FORMAT_RGB565` | `4` | Client | Red, Green, Blue, 5 bit per pixel for Red and Blue channels, 6 bits for Green. |
| `IMAGE_FORMAT_RGB888` | `2` | Client | Legacy format. |
| `IMAGE_FORMAT_RGBA16161616` | `25` | Client | RGBA, but 16 bits per pixel. |
| `IMAGE_FORMAT_RGBA16161616F` | `24` | Client | RGBA, but floating point 16 bits per pixel. |
| `IMAGE_FORMAT_RGBA8888` | `0` | Client | Red, Green, Blue, Alpha, 8 bit per pixel. |
