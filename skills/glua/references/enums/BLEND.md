# BLEND enumeration

**Realm:** Client  ·  **Constants:** 11

These enums are used by [render.OverrideBlend](https://wiki.facepunch.com/gmod/render.OverrideBlend) to determine what the Source and Destination color and alpha channel values for a given pixel will be multiplied by before they are sent to the [Blend Function](https://wiki.facepunch.com/gmod/Enums/BLENDFUNC) to calculate the pixel's final color during draw operations.

For an interactive demonstration of how these enums behave, see [Anders Riggelsen's Visual glBlendFunc Tool here](https://www.andersriggelsen.dk/glblendfunc.php)

[wiki page](https://wiki.facepunch.com/gmod/Enums/BLEND)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `BLEND_DST_ALPHA` | `6` | Client | All color and alpha channels will be set to the the Destination alpha value. |
| `BLEND_DST_COLOR` | `2` | Client | The Multiplier will be the same as the Destination color and alpha. |
| `BLEND_ONE` | `1` | Client | The Multiplier will be `r=1`, `g=1`, `b=1`, `a=1` This is useful for keeping the Source or Destination as their starting values. |
| `BLEND_ONE_MINUS_DST_ALPHA` | `7` | Client | All color and alpha channels will be set to the Destination alpha value subtracted from `1`. |
| `BLEND_ONE_MINUS_DST_COLOR` | `3` | Client | Each color and alpha channel value of the Destination is subtracted from `1`. |
| `BLEND_ONE_MINUS_SRC_ALPHA` | `5` | Client | All color and alpha channels will be set to the Source alpha value subtracted from `1`. |
| `BLEND_ONE_MINUS_SRC_COLOR` | `10` | Client | Each color and alpha channel value of the Source is subtracted from `1`. |
| `BLEND_SRC_ALPHA` | `4` | Client | All color and alpha channels will be the same as the Source alpha value. |
| `BLEND_SRC_ALPHA_SATURATE` | `8` | Client | First, the Source alpha is compared against the Destination alpha value subtracted from `1` and the smaller of the two is kept. |
| `BLEND_SRC_COLOR` | `9` | Client | The Multiplier will be the same as the Source color and alpha. |
| `BLEND_ZERO` | `0` | Client | The Multiplier will be `r=0`, `g=0`, `b=0`, `a=0` This is useful for removing the Source or Destination from the final pixel color. |
