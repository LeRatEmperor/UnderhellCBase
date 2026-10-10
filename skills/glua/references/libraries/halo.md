# halo

**Realm:** Client  ·  **Members:** 3

The halo library is used to draw glowing outlines around entities, an example of this can be seen by picking up props with the physgun in Garry's Mod 13.

[wiki page](https://wiki.facepunch.com/gmod/halo)

### halo.Add · Client
`halo.Add(entities: table, color: Color, blurX: number = 2, blurY: number = 2, passes: number = 1, additive: boolean = true, ignoreZ: boolean = false)`

Applies a [halo](https://wiki.facepunch.com/gmod/halo) glow effect to one or multiple entities. It is preferable to add them in [GM:PreDrawHalos](https://wiki.facepunch.com/gmod/GM:PreDrawHalos), but they can be added at any time.

**Arguments:**
- `entities` (table) — A table of entities to add the halo effect to.
- `color` (Color) — The desired color of the halo.
- `blurX` (number, default `2`) — The strength of the halo's blur on the x axis.
- `blurY` (number, default `2`) — The strength of the halo's blur on the y axis.
- `passes` (number, default `1`) — The number of times the halo should be drawn per frame.
- `additive` (boolean, default `true`) — Sets the render mode of the halo to additive.
- `ignoreZ` (boolean, default `false`) — Renders the halo through anything when set to `true`.

> **Note:** The ignoreZ parameter will cause the halos to draw over the player's viewmodel. You can work around this using [render.DepthRange](https://wiki.facepunch.com/gmod/render.DepthRange) in the [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel), [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel), [GM:PreDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PreDrawPlayerHands) and [GM:PostDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PostDrawPlayerHands) hooks.

[wiki](https://wiki.facepunch.com/gmod/halo.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/halo.lua#L13-L33)

---

### halo.Render · Client · `INTERNAL`
`halo.Render(entry: table)`

Renders a halo according to the specified table, only used internally, called from a [GM:PostDrawEffects](https://wiki.facepunch.com/gmod/GM:PostDrawEffects) hook added by the halo library.

**Arguments:**
- `entry` (table) — Table with info about the halo to draw.

[wiki](https://wiki.facepunch.com/gmod/halo.Render) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/halo.lua#L39-L144)

---

### halo.RenderedEntity · Client
`halo.RenderedEntity() → Entity`

Returns the entity the halo library is currently rendering the halo for.

The main purpose of this function is to be used in [ENTITY:Draw](https://wiki.facepunch.com/gmod/ENTITY:Draw) in order not to draw certain parts of the entity when the halo is being rendered, so there's no halo around unwanted entity parts, such as lasers, 3D2D displays, etc.

**Returns:**
- Entity — If set, the currently rendered entity by the halo library.

[wiki](https://wiki.facepunch.com/gmod/halo.RenderedEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/halo.lua#L35-L37)
