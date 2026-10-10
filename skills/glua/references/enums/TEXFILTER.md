# TEXFILTER enumeration

**Realm:** Shared, Menu  ·  **Constants:** 4

Enumerations used by [render.PushFilterMin](https://wiki.facepunch.com/gmod/render.PushFilterMin) and [render.PushFilterMag](https://wiki.facepunch.com/gmod/render.PushFilterMag).

See [this](https://msdn.microsoft.com/en-us/library/windows/desktop/bb172615(v=vs.85).aspx) and [this page](https://en.wikipedia.org/wiki/Texture_filtering) for more information on texture filtering.

[wiki page](https://wiki.facepunch.com/gmod/Enums/TEXFILTER)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `TEXFILTER.ANISOTROPIC` | `3` | Shared, Menu | Highest quality filter. |
| `TEXFILTER.LINEAR` | `2` | Shared, Menu | Basic interpolation between 2 samples. |
| `TEXFILTER.NONE` | `0` | Shared, Menu | Disables any filter override. |
| `TEXFILTER.POINT` | `1` | Shared, Menu | Point sampling, no interpolation. |
