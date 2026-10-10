# RENDERMODE enumeration

**Realm:** Shared  ·  **Constants:** 11

Enumerations used by [Entity:SetRenderMode](https://wiki.facepunch.com/gmod/Entity:SetRenderMode) and [Entity:GetRenderMode](https://wiki.facepunch.com/gmod/Entity:GetRenderMode).

[wiki page](https://wiki.facepunch.com/gmod/Enums/RENDERMODE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `RENDERMODE_ENVIROMENTAL` | `6` | Shared | Causes the material to be not be drawn at all, similarly to Don't Render. |
| `RENDERMODE_GLOW` | `3` | Shared | Intended for glowing sprites. |
| `RENDERMODE_NONE` | `10` | Shared | The entity is still being drawn and networked albeit invisible, therefore not making this Render Mode ideal for performance reasons. |
| `RENDERMODE_NORMAL` | `0` | Shared | Default render mode. |
| `RENDERMODE_TRANSADD` | `5` | Shared | Add the material's color values to the existing image, instead of performing a multiplication. |
| `RENDERMODE_TRANSADDFRAMEBLEND` | `7` | Shared | Functions like Additive, but also blends between animation frames. |
| `RENDERMODE_TRANSALPHA` | `4` | Shared | Enables Alphatesting. |
| `RENDERMODE_TRANSALPHADD` | `8` | Shared | Functions similarly to Additive, except that the alpha channel controls the opacity of the sprite. |
| `RENDERMODE_TRANSCOLOR` | `1` | Shared | Supports transparency. |
| `RENDERMODE_TRANSTEXTURE` | `2` | Shared |  |
| `RENDERMODE_WORLDGLOW` | `9` | Shared | Functions similarly to Glow, with the exception that the size of the sprite is relative to the world rather than the screen. |
