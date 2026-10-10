# draw

**Realm:** Client, Menu  ·  **Members:** 11

The draw library's purpose is to simplify the usage of the [surface](https://wiki.facepunch.com/gmod/surface) library.

[wiki page](https://wiki.facepunch.com/gmod/draw)

### draw.DrawText · Client, Menu
`draw.DrawText(text: string, font: string = DermaDefault, x: number = 0, y: number = 0, color: Color = Color( 255, 255, 255, 255 ), xAlign: number = TEXT_ALIGN_LEFT)`

Simple draw text at position, but this will expand newlines and tabs.



See also [MarkupObject](https://wiki.facepunch.com/gmod/MarkupObject) for limited width and markup support.

**Arguments:**
- `text` (string) — Text to be drawn.
- `font` (string, default `DermaDefault`) — Name of font to draw the text in.
- `x` (number, default `0`) — The X Coordinate.
- `y` (number, default `0`) — The Y Coordinate.
- `color` (Color, default `Color( 255, 255, 255, 255 )`) — Color to draw the text in.
- `xAlign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — Where to align the text horizontally.

[wiki](https://wiki.facepunch.com/gmod/draw.DrawText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L126-L162)

---

### draw.GetFontHeight · Client, Menu
`draw.GetFontHeight(font: string) → number`

Returns the height of the specified font in pixels. This is equivalent to the height of the character `W`. See [surface.GetTextSize](https://wiki.facepunch.com/gmod/surface.GetTextSize).

**Arguments:**
- `font` (string) — Name of the font to get the height of.

**Returns:**
- number — The font height.

[wiki](https://wiki.facepunch.com/gmod/draw.GetFontHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L37-L49)

---

### draw.NoTexture · Client, Menu
`draw.NoTexture()`

Sets drawing texture to a default white texture (vgui/white) via [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial). Useful for resetting the drawing texture.

[wiki](https://wiki.facepunch.com/gmod/draw.NoTexture) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L302-L304)

---

### draw.RoundedBox · Client, Menu
`draw.RoundedBox(cornerRadius: number, x: number, y: number, width: number, height: number, color: Color)`

Draws a rounded rectangle.

**Arguments:**
- `cornerRadius` (number) — Radius of the rounded corners, works best with a multiple of 2.
- `x` (number) — The x coordinate of the top left of the rectangle.
- `y` (number) — The y coordinate of the top left of the rectangle.
- `width` (number) — The width of the rectangle.
- `height` (number) — The height of the rectangle.
- `color` (Color) — The color to fill the rectangle with.

> **Note:** This function actually draws rectangles with 'gui/cornerX' textures applied to it's rounded corners. It means that this function will fail (or will be drawn not as expected) with any vertex operations, such as model matrices like [cam.Start3D2D](https://wiki.facepunch.com/gmod/cam.Start3D2D) (corners would be pixelated) or stencil operations. Consider using [surface.DrawPoly](https://wiki.facepunch.com/gmod/surface.DrawPoly) or [mesh](https://wiki.facepunch.com/gmod/mesh) library

[wiki](https://wiki.facepunch.com/gmod/draw.RoundedBox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L169-L173)

---

### draw.RoundedBoxEx · Client, Menu
`draw.RoundedBoxEx(cornerRadius: number, x: number, y: number, width: number, height: number, color: Color, roundTopLeft: boolean = false, roundTopRight: boolean = false, roundBottomLeft: boolean = false, roundBottomRight: boolean = false)`

Draws a rounded rectangle. This function also lets you specify which corners are drawn rounded.

**Arguments:**
- `cornerRadius` (number) — Radius of the rounded corners, works best with a power of 2 number.
- `x` (number) — The x coordinate of the top left of the rectangle.
- `y` (number) — The y coordinate of the top left of the rectangle.
- `width` (number) — The width of the rectangle.
- `height` (number) — The height of the rectangle.
- `color` (Color) — The color to fill the rectangle with.
- `roundTopLeft` (boolean, default `false`) — Whether the top left corner should be rounded.
- `roundTopRight` (boolean, default `false`) — Whether the top right corner should be rounded.
- `roundBottomLeft` (boolean, default `false`) — Whether the bottom left corner should be rounded.
- `roundBottomRight` (boolean, default `false`) — Whether the bottom right corner should be rounded.

> **Note:** This function actually draws rectangles with 'gui/cornerX' textures applied to it's rounded corners. It means that this function will fail (or will be drawn not as expected) with any vertex operations, such as model matrices like [cam.Start3D2D](https://wiki.facepunch.com/gmod/cam.Start3D2D) (corners would be pixelated) or stencil operations. Consider using [surface.DrawPoly](https://wiki.facepunch.com/gmod/surface.DrawPoly) or [mesh](https://wiki.facepunch.com/gmod/mesh) library

[wiki](https://wiki.facepunch.com/gmod/draw.RoundedBoxEx) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L180-L233)

---

### draw.SimpleText · Client, Menu
`draw.SimpleText(text: string, font: string = DermaDefault, x: number = 0, y: number = 0, color: Color = Color( 255, 255, 255, 255 ), xAlign: number = TEXT_ALIGN_LEFT, yAlign: number = TEXT_ALIGN_TOP) → number, number`

Draws text on the screen.

**Arguments:**
- `text` (string) — The text to be drawn.
- `font` (string, default `DermaDefault`) — The font.
- `x` (number, default `0`) — The X Coordinate.
- `y` (number, default `0`) — The Y Coordinate.
- `color` (Color, default `Color( 255, 255, 255, 255 )`) — The color of the text.
- `xAlign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the X coordinate using TEXT_ALIGN.
- `yAlign` (number, default `TEXT_ALIGN_TOP`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the Y coordinate using TEXT_ALIGN.

**Returns:**
- number — The width of the text.
- number — The height of the text.

> **Note:** This function does not handle newlines properly. See [draw.DrawText](https://wiki.facepunch.com/gmod/draw.DrawText) for a function that does.

[wiki](https://wiki.facepunch.com/gmod/draw.SimpleText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L56-L94)

---

### draw.SimpleTextOutlined · Client, Menu
`draw.SimpleTextOutlined(Text: string, font: string = DermaDefault, x: number = 0, y: number = 0, color: Color = Color( 255, 255, 255, 255 ), xAlign: number = TEXT_ALIGN_LEFT, yAlign: number = TEXT_ALIGN_TOP, outlinewidth: number, outlinecolor: table = Color( 255, 255, 255, 255 )) → number, number`

Creates a simple line of text that is outlined.

**Arguments:**
- `Text` (string) — The text to draw.
- `font` (string, default `DermaDefault`) — The font name to draw with.
- `x` (number, default `0`) — The X Coordinate.
- `y` (number, default `0`) — The Y Coordinate.
- `color` (Color, default `Color( 255, 255, 255, 255 )`) — The color of the text.
- `xAlign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the X Coordinate using TEXT_ALIGN.
- `yAlign` (number, default `TEXT_ALIGN_TOP`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the Y Coordinate using TEXT_ALIGN.
- `outlinewidth` (number) — Width of the outline.
- `outlinecolor` (table, default `Color( 255, 255, 255, 255 )`) — Color of the outline.

**Returns:**
- number — The width of the text.
- number — The height of the text.

[wiki](https://wiki.facepunch.com/gmod/draw.SimpleTextOutlined) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L101-L114)

---

### draw.Text · Client, Menu
`draw.Text(textdata: table) → number, number`

Works like [draw.SimpleText](https://wiki.facepunch.com/gmod/draw.SimpleText) but uses a table structure instead.

**Arguments:**
- `textdata` (table) — The text properties.

**Returns:**
- number — Width of drawn text.
- number — Height of drawn text.

[wiki](https://wiki.facepunch.com/gmod/draw.Text) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L259-L263)

---

### draw.TextShadow · Client, Menu
`draw.TextShadow(textdata: table, distance: number, alpha: number = 200) → number, number`

Works like [draw.Text](https://wiki.facepunch.com/gmod/draw.Text), but draws the text with a shadow.

**Arguments:**
- `textdata` (table) — The text properties.
- `distance` (number) — How far away the shadow appears.
- `alpha` (number, default `200`) — How visible the shadow is (0-255).

**Returns:**
- `textWidth` (number) — The width of drawn text.
- `textHeight` (number) — The height of drawn text.

[wiki](https://wiki.facepunch.com/gmod/draw.TextShadow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L269-L285)

---

### draw.TexturedQuad · Client, Menu
`draw.TexturedQuad(texturedata: table)`

Draws a texture with a table structure.

**Arguments:**
- `texturedata` (table) — The texture properties.

[wiki](https://wiki.facepunch.com/gmod/draw.TexturedQuad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L292-L300)

---

### draw.WordBox · Client, Menu
`draw.WordBox(bordersize: number, x: number, y: number, text: string, font: string, boxcolor: Color, textcolor: Color, xalign: number = TEXT_ALIGN_LEFT, yalign: number = TEXT_ALIGN_TOP) → number, number`

Draws a rounded box with text in it.

**Arguments:**
- `bordersize` (number) — Size of border, should be multiple of 2.
- `x` (number) — The X Coordinate.
- `y` (number) — The Y Coordinate.
- `text` (string) — Text to draw.
- `font` (string) — Font to draw in.
- `boxcolor` (Color) — The box color.
- `textcolor` (Color) — The text color.
- `xalign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the X coordinate using TEXT_ALIGN.
- `yalign` (number, default `TEXT_ALIGN_TOP`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the Y coordinate using TEXT_ALIGN.

**Returns:**
- number — The width of the word box.
- number — The height of the word box.

[wiki](https://wiki.facepunch.com/gmod/draw.WordBox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/draw.lua#L240-L253)
