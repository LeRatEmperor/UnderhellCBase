# BLENDFUNC enumeration

**Realm:** Shared, Menu  ·  **Constants:** 5

These enums are used by [render.OverrideBlend](https://wiki.facepunch.com/gmod/render.OverrideBlend) to combine the Source and Destination color and alpha into a final pixel color after they have been multiplied by their corresponding [Blend Multiplier](https://wiki.facepunch.com/gmod/Enums/BLEND).

All results will be clamped in the range `(0-1)` and will produce final pixel channel values in the range `(0-255)`.

For an interactive demonstration of how these enums behave, see [Anders Riggelsen's Visual glBlendFunc Tool here](https://www.andersriggelsen.dk/glblendfunc.php)

[wiki page](https://wiki.facepunch.com/gmod/Enums/BLENDFUNC)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `BLENDFUNC_ADD` | `0` | Shared, Menu | Source + Destination Adds each channel of the Source with the same channel of the Destination. |
| `BLENDFUNC_MAX` | `4` | Shared, Menu | Max(Source, Destination All of the Source channels are added together and compared to all of the Destination channels added together and the larger of the two is used as the final pixel color. |
| `BLENDFUNC_MIN` | `3` | Shared, Menu | Min(Source, Destination All of the Source channels are added together and compared to all of the Destination channels added together and the smaller of the two is used as the final pixel color. |
| `BLENDFUNC_REVERSE_SUBTRACT` | `2` | Shared, Menu | Destination - Source Subtracts each channel of the Source from the same channel of the Destination. |
| `BLENDFUNC_SUBTRACT` | `1` | Shared, Menu | Source - Destination Subtracts each channel of the Destination from the same channel of the Source. |
