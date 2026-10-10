# GWEN

**Realm:** Client, Menu  ·  **Members:** 4

GWEN is a system that allows you to load a spritesheet and generate a skin out of it.

[wiki page](https://wiki.facepunch.com/gmod/GWEN)

### GWEN.CreateTextureBorder · Client, Menu
`GWEN.CreateTextureBorder(x: number, y: number, w: number, h: number, left: number, top: number, right: number, bottom: number, material: IMaterial = nil) → function`

This is a utility function that generates a specialized drawing function to render scalable textured borders. This is done with [9-slice scaling](https://en.wikipedia.org/wiki/9-slice_scaling). This is used in derma skins to create a bordered rectangle drawing function from an image.

The texture is taken from `SKIN.GwenTexture` when the `material` argument is not supplied.

**Arguments:**
- `x` (number) — The X coordinate on the texture.
- `y` (number) — The Y coordinate on the texture.
- `w` (number) — Width of the area on texture.
- `h` (number) — Height of the area on texture.
- `left` (number) — Left width of border.
- `top` (number) — Top width of border.
- `right` (number) — Right width of border.
- `bottom` (number) — Bottom width of border.
- `material` (IMaterial, default `nil`) — If set, given material will be used over the SKIN's default material, which is `SKIN.GwenTexture`.

**Returns:**
- `drawFunc` (function) — The drawing function.

[wiki](https://wiki.facepunch.com/gmod/GWEN.CreateTextureBorder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L6-L53)

---

### GWEN.CreateTextureCentered · Client, Menu
`GWEN.CreateTextureCentered(x: number, y: number, w: number, h: number, material: IMaterial = nil) → function`

Used in derma skins to create a fixed scale rectangle drawing function from an image. it will be drawn in the center of the box.

The texture is taken from `SKIN.GwenTexture` when the `material` is not supplied.

**Arguments:**
- `x` (number) — The X coordinate on the texture.
- `y` (number) — The Y coordinate on the texture.
- `w` (number) — Width of the area on texture.
- `h` (number) — Height of the area on texture.
- `material` (IMaterial, default `nil`) — If set, given material will be used over the SKIN's default material, which is `SKIN.GwenTexture`.

**Returns:**
- function — The drawing function.

[wiki](https://wiki.facepunch.com/gmod/GWEN.CreateTextureCentered) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L82-L112)

---

### GWEN.CreateTextureNormal · Client, Menu
`GWEN.CreateTextureNormal(x: number, y: number, w: number, h: number, material: IMaterial = nil) → function`

Helper function that returns a specialized drawing function for rendering a texture that scales freely to fit the given area.



The texture is taken from `SKIN.GwenTexture` when the `material` is not supplied.

**Arguments:**
- `x` (number) — The X coordinate on the texture.
- `y` (number) — The Y coordinate on the texture.
- `w` (number) — Width of the area on texture.
- `h` (number) — Height of the area on texture.
- `material` (IMaterial, default `nil`) — If set, given material will be used over the SKIN's default material, which is `SKIN.GwenTexture`.

**Returns:**
- function — The drawing function.

[wiki](https://wiki.facepunch.com/gmod/GWEN.CreateTextureNormal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L55-L80)

---

### GWEN.TextureColor · Client, Menu
`GWEN.TextureColor(x: number, y: number) → Color`

Retrieves the color from a materials texture at the provided UV coordinates

**Arguments:**
- `x` (number) — X position of the pixel to get the color from.
- `y` (number) — Y position of the pixel to get the color from.

**Returns:**
- Color — The color of the point on the skin.

[wiki](https://wiki.facepunch.com/gmod/GWEN.TextureColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L114-L120)
