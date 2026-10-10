# surface

**Realm:** Client, Menu  ·  **Members:** 32

The surface library allows you to draw text and shapes on the screen. Primarily used for making HUDs & custom GUI panels.

[wiki page](https://wiki.facepunch.com/gmod/surface)

### surface.CreateFont · Client, Menu
`surface.CreateFont(fontName: string, fontData: table{FontData})`

Creates a new font.

To prevent the font from displaying incorrectly when using the `outline` setting, set `antialias` to false. This will ensure the text properly fills out the entire outline.

Be sure to check the [List of Default Fonts](https://wiki.facepunch.com/gmod/Default_Fonts) first! Those fonts can be used without using this function.

See Also: [Finding the Font Name](https://wiki.facepunch.com/gmod/Finding%20the%20Font%20Name).

**Arguments:**
- `fontName` (string) — The new font name.
- `fontData` (table{FontData}) — The font properties.

> **Warning:** Due to the static nature of fonts, do **NOT** create the font more than once. You should only be creating them once, it is recommended to create them at the top of your script. Do not use this function within [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint) or any other hook!
> 
> Define fonts that you will actually use, as fonts are very taxing on performance and will cause crashes! Do not create fonts for every size.

[wiki](https://wiki.facepunch.com/gmod/surface.CreateFont)

---

### surface.DisableClipping · Client, Menu · `DEPRECATED`
`surface.DisableClipping(disable: boolean) → boolean`

Enables or disables the clipping used by the VGUI that limits the drawing operations to a panels bounds.

Identical to [DisableClipping](https://wiki.facepunch.com/gmod/Global.DisableClipping). See also [Panel:NoClipping](https://wiki.facepunch.com/gmod/Panel:NoClipping).

**Arguments:**
- `disable` (boolean) — True to disable, false to enable the clipping

**Returns:**
- `oldState` (boolean) — Whether the clipping was enabled or not before this function call

[wiki](https://wiki.facepunch.com/gmod/surface.DisableClipping)

---

### surface.DrawCircle · Client, Menu
`surface.DrawCircle(originX: number, originY: number, radius: number, r: number, g: number, b: number, a: number = 255, originX: number, originY: number, radius: number, color: Color)`

Draws a hollow circle, made of lines. For a filled circle, see examples for [surface.DrawPoly](https://wiki.facepunch.com/gmod/surface.DrawPoly).

**Arguments:**
- `originX` (number) — The center x integer coordinate.
- `originY` (number) — The center y integer coordinate.
- `radius` (number) — The radius of the circle.
- `r` (number) — The red value of the color to draw the circle with.
- `g` (number) — The green value of the color to draw the circle with.
- `b` (number) — The blue value of the color to draw the circle with.
- `a` (number, default `255`) — The alpha value of the color to draw the circle with.
- `originX` (number) — The center x integer coordinate.
- `originY` (number) — The center y integer coordinate.
- `radius` (number) — The radius of the circle.
- `color` (Color) — A Color object/table to read the color from.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawCircle)

---

### surface.DrawLine · Client, Menu
`surface.DrawLine(startX: number, startY: number, endX: number, endY: number)`

Draws a line from one point to another.

**Arguments:**
- `startX` (number) — The start x float coordinate.
- `startY` (number) — The start y float coordinate.
- `endX` (number) — The end x float coordinate.
- `endY` (number) — The end y float coordinate.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawLine)

---

### surface.DrawOutlinedRect · Client, Menu
`surface.DrawOutlinedRect(x: number, y: number, w: number, h: number, thickness: number = 1)`

Draws a hollow box with a given border width.

**Arguments:**
- `x` (number) — The start x integer coordinate.
- `y` (number) — The start y integer coordinate.
- `w` (number) — The integer width.
- `h` (number) — The integer height.
- `thickness` (number, default `1`) — The thickness of the outlined box border.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawOutlinedRect)

---

### surface.DrawPoly · Client, Menu
`surface.DrawPoly(vertices: table)`

Draws a textured polygon (secretly a triangle fan) with a maximum of 4096 vertices.
Only works properly with convex polygons. You may try to render concave polygons, but there is no guarantee that things wont get messed up.

Unlike most surface library functions, non-integer coordinates are not rounded.

**Arguments:**
- `vertices` (table) — A table containing integer vertices.

> **Warning:** You must reset the drawing color and texture before calling the function to ensure consistent results. See examples below.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawPoly)

---

### surface.DrawRect · Client, Menu
`surface.DrawRect(x: number, y: number, width: number, height: number)`

Draws a solid rectangle on the screen.

**Arguments:**
- `x` (number) — The X integer co-ordinate.
- `y` (number) — The Y integer co-ordinate.
- `width` (number) — The integer width of the rectangle.
- `height` (number) — The integer height of the rectangle.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawRect)

---

### surface.DrawText · Client, Menu
`surface.DrawText(text: string, forceAdditive: boolean = nil)`

Draw the specified text on the screen, using the previously set [position](surface.SetTextPos), [font](surface.SetFont) and [color](surface.SetTextColor). This function does **not** handle newlines.

This function moves the [text position](surface.SetTextPos) by the length of the drawn text - this can be used to change text properties (such as font or color) without having to manually recalculate the text position. See example #2 for example use of this behavior.

**Arguments:**
- `text` (string) — The text to be rendered.
- `forceAdditive` (boolean, default `nil`) — `true` to force text to render additive, `false` to force not additive, `nil` to use font's value.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawText)

---

### surface.DrawTexturedRect · Client, Menu
`surface.DrawTexturedRect(x: number, y: number, width: number, height: number)`

Draw a textured rectangle with the given position and dimensions on the screen, using the current active texture set with [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial). It is also affected by [surface.SetDrawColor](https://wiki.facepunch.com/gmod/surface.SetDrawColor).

See also [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial) and [render.DrawScreenQuadEx](https://wiki.facepunch.com/gmod/render.DrawScreenQuadEx).  
See also [surface.DrawTexturedRectUV](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectUV) and [surface.DrawTexturedRectRotated](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectRotated).

**Arguments:**
- `x` (number) — The X integer co-ordinate.
- `y` (number) — The Y integer co-ordinate.
- `width` (number) — The integer width of the rectangle.
- `height` (number) — The integer height of the rectangle.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawTexturedRect)

---

### surface.DrawTexturedRectRotated · Client, Menu
`surface.DrawTexturedRectRotated(x: number, y: number, width: number, height: number, rotation: number)`

Draw a textured rotated rectangle with the given position and dimensions and angle on the screen, using the current active texture.

See also [surface.DrawTexturedRectUV](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectUV) and [surface.DrawTexturedRect](https://wiki.facepunch.com/gmod/surface.DrawTexturedRect).

**Arguments:**
- `x` (number) — The X integer co-ordinate, representing the center of the rectangle.
- `y` (number) — The Y integer co-ordinate, representing the center of the rectangle.
- `width` (number) — The integer width of the rectangle.
- `height` (number) — The integer height of the rectangle.
- `rotation` (number) — The rotation of the rectangle, in degrees.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectRotated)

---

### surface.DrawTexturedRectUV · Client, Menu
`surface.DrawTexturedRectUV(x: number, y: number, width: number, height: number, startU: number, startV: number, endU: number, endV: number)`

Draws a textured rectangle with a repeated or partial texture.

`u` and `v` refer to texture coordinates.
* (u, v) = (0, 0) is the top left
* (u, v) = (1, 0) is the top right
* (u, v) = (1, 1) is the bottom right
* (u, v) = (0, 1) is the bottom left

Using a start point of (1, 0) and an end point to (0, 1), you can draw an image flipped horizontally, same goes with other directions. Going above 1 will tile the texture. Negative values are allowed as well.

Here's a helper image:


See also [surface.DrawTexturedRect](https://wiki.facepunch.com/gmod/surface.DrawTexturedRect) and [surface.DrawTexturedRectRotated](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectRotated).

**Arguments:**
- `x` (number) — The X integer coordinate.
- `y` (number) — The Y integer coordinate.
- `width` (number) — The integer width of the rectangle.
- `height` (number) — The integer height of the rectangle.
- `startU` (number) — The U texture mapping of the rectangle origin.
- `startV` (number) — The V texture mapping of the rectangle origin.
- `endU` (number) — The U texture mapping of the rectangle end.
- `endV` (number) — The V texture mapping of the rectangle end.

> **Note:** If you are using a .png image, you need supply the "noclamp" flag as second parameter for [Material](https://wiki.facepunch.com/gmod/Global.Material) if you intend to use tiling.
> **Note:** If you find that `surface.DrawTexturedRectUV` is getting your texture coordinates (u0, v0), (u1, v1) wrong and you're rendering with a material created with [CreateMaterial](https://wiki.facepunch.com/gmod/Global.CreateMaterial), try adjusting them with the following code:
> 
> ```lua
> local du = 0.5 / 32 -- half pixel anticorrection
> local dv = 0.5 / 32 -- half pixel anticorrection
> local u0, v0 = (u0 - du) / (1 - 2 * du), (v0 - dv) / (1 - 2 * dv)
> local u1, v1 = (u1 - du) / (1 - 2 * du), (v1 - dv) / (1 - 2 * dv)
> ```
> 
> 
> **Explanation:**
> `surface.DrawTexturedRectUV` tries to correct the texture coordinates by half a pixel (something to do with sampling) and computes the correction using `IMaterial::GetMappingWidth()`/`GetMappingHeight()`. If the material was created without a `$basetexture`, then `GetMappingWidth()`/`GetMappingHeight()` uses the width and height of the error material (which is 32x32).
> **Bug** ([#3173](https://github.com/Facepunch/garrysmod/issues/3173)): The UV offsets might require (sub-)pixel correction for accurate tiling results.

[wiki](https://wiki.facepunch.com/gmod/surface.DrawTexturedRectUV)

---

### surface.GetAlphaMultiplier · Client, Menu
`surface.GetAlphaMultiplier() → number`

Returns the current alpha multiplier affecting drawing operations. This is set by [surface.SetAlphaMultiplier](https://wiki.facepunch.com/gmod/surface.SetAlphaMultiplier) or by the game engine in certain other cases.

**Returns:**
- number — The multiplier ranging from 0 to 1.

[wiki](https://wiki.facepunch.com/gmod/surface.GetAlphaMultiplier)

---

### surface.GetDrawColor · Client, Menu
`surface.GetDrawColor() → Color`

Returns the current color affecting draw operations.

**Returns:**
- Color — The color that drawing operations will use.

[wiki](https://wiki.facepunch.com/gmod/surface.GetDrawColor)

---

### surface.GetHUDTexture · Client
`surface.GetHUDTexture(name: string) → number`

Returns the [HUD icon](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/hud_textures.txt) TextureID of a texture with the specified name.

You probably want to use [Material](https://wiki.facepunch.com/gmod/Global.Material) and [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial).

**Arguments:**
- `name` (string) — The name of the texture.

**Returns:**
- `texID` (number) — The texture ID, for use with surface.SetTexture.

[wiki](https://wiki.facepunch.com/gmod/surface.GetHUDTexture)

---

### surface.GetPanelPaintState · Client
`surface.GetPanelPaintState() → table{PanelPaintState}`

Retrieves the position and [ScissorRect](https://wiki.facepunch.com/gmod/render.SetScissorRect) information for the [Panel](https://wiki.facepunch.com/gmod/Panel) that is currently being drawn.

When using the [surface](https://wiki.facepunch.com/gmod/surface) library (and, by extension, the [draw](https://wiki.facepunch.com/gmod/draw) library) inside of the [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) function, the origin (The on-screen position of `(0,0)`) is automatically shifted to the top-left corner of the panel to make it easier to draw the panel's contents.  Additionally, [render.SetScissorRect](https://wiki.facepunch.com/gmod/render.SetScissorRect) is used to clip (or "mask") all drawn content to within the boundaries of the panel.  This function returns the information used by the [surface](https://wiki.facepunch.com/gmod/surface) library about the current panel's origin and [ScissorRect](https://wiki.facepunch.com/gmod/render.SetScissorRect).

**Returns:**
- table{PanelPaintState} — A table containing the position and ScissorRect boundaries for the Panel currently being drawn.

[wiki](https://wiki.facepunch.com/gmod/surface.GetPanelPaintState)

---

### surface.GetScissorRect · Client · `NEW`
`surface.GetScissorRect() → boolean, number, number, number, number`

Retrieves the currently active scissor rect for the surface library. A faster, narrower version of [surface.GetPanelPaintState](https://wiki.facepunch.com/gmod/surface.GetPanelPaintState).

Useful for panel retrieving current panel's culling from [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint).

This does **NOT** return values set by [render.SetScissorRect](https://wiki.facepunch.com/gmod/render.SetScissorRect).

**Returns:**
- boolean — Whether the scissor rect is active or not.
- number — Left edge of the scissor rect.
- number — Top edge of the scissor rect.
- number — Right edge of the scissor rect.
- number — Bottom edge of the scissor rect.

[wiki](https://wiki.facepunch.com/gmod/surface.GetScissorRect)

---

### surface.GetTextColor · Client, Menu
`surface.GetTextColor() → Color`

Returns the current color affecting text draw operations.

**Returns:**
- Color — The color that text drawing operations will use.

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextColor)

---

### surface.GetTextPos · Client, Menu
`surface.GetTextPos() → number, number`

Returns the X and Y co-ordinate that has been set with [surface.SetTextPos](https://wiki.facepunch.com/gmod/surface.SetTextPos) or changed by [surface.DrawText](https://wiki.facepunch.com/gmod/surface.DrawText).

**Returns:**
- `x` (number) — The X integer co-ordinate.
- `y` (number) — The Y integer co-ordinate.

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextPos)

---

### surface.GetTextSize · Client, Menu
`surface.GetTextSize(text: string) → number, number`

Returns the width and height (in pixels) of the given text with the font that has been set with [surface.SetFont](https://wiki.facepunch.com/gmod/surface.SetFont).

**Arguments:**
- `text` (string) — The string to check the size of.

**Returns:**
- number — Width of the provided text.
- number — Height of the provided text.

> **Note:** Takes into account new lines, the returned height is for the entire text, but [surface.DrawText](https://wiki.facepunch.com/gmod/surface.DrawText) does not!

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextSize)

---

### surface.GetTextureID · Client, Menu
`surface.GetTextureID(name/path: string) → number`

Returns the texture id of the material with the given name/path, for use with [surface.SetTexture](https://wiki.facepunch.com/gmod/surface.SetTexture).

Opposite version of this function is [surface.GetTextureNameByID](https://wiki.facepunch.com/gmod/surface.GetTextureNameByID).

**Arguments:**
- `name/path` (string) — Name or path of the texture.

**Returns:**
- number — The texture ID

> **Note:** This function will not work with .png or .jpg images. For that, see [Material](https://wiki.facepunch.com/gmod/Global.Material). You will probably want to use it regardless.

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextureID)

---

### surface.GetTextureNameByID · Client, Menu
`surface.GetTextureNameByID(id: number) → string`

Returns name/path of texture by ID. Opposite version of this function is [surface.GetTextureID](https://wiki.facepunch.com/gmod/surface.GetTextureID).

**Arguments:**
- `id` (number) — ID of texture.

**Returns:**
- string — Returns name/path of texture.

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextureNameByID)

---

### surface.GetTextureSize · Client, Menu
`surface.GetTextureSize(textureID: number) → number, number`

Returns the size of the texture with the associated texture ID.

For `.png/.jpg` textures loaded with [Material](https://wiki.facepunch.com/gmod/Global.Material) you can use the `$realheight` and `$realwidth` material parameters ([IMaterial:GetInt](https://wiki.facepunch.com/gmod/IMaterial:GetInt)) to get the size of the image.

**Arguments:**
- `textureID` (number) — The texture ID, returned by surface.GetTextureID.

**Returns:**
- number — The texture width.
- number — The texture height.

[wiki](https://wiki.facepunch.com/gmod/surface.GetTextureSize)

---

### surface.PlaySound · Client, Menu
`surface.PlaySound(soundfile: string)`

Play a sound file directly on the client (such as UI sounds, etc).

**Arguments:**
- `soundfile` (string) — The path to the sound file.

> **Note:** Valid sample rates: **11025 Hz, 22050 Hz and 44100 Hz**, otherwise you may see this kind of message:
> 
> `Unsupported 32-bit wave file your_sound.wav` and 
> `Invalid sample rate (48000) for sound 'your_sound.wav'`

[wiki](https://wiki.facepunch.com/gmod/surface.PlaySound)

---

### surface.ScreenHeight · Client, Menu · `DEPRECATED`
`surface.ScreenHeight() → number`

Returns the height of the current client's screen.

**Returns:**
- number — screenHeight

[wiki](https://wiki.facepunch.com/gmod/surface.ScreenHeight)

---

### surface.ScreenWidth · Client, Menu · `DEPRECATED`
`surface.ScreenWidth() → number`

Returns the width of the current client's screen.

**Returns:**
- number — screenWidth

[wiki](https://wiki.facepunch.com/gmod/surface.ScreenWidth)

---

### surface.SetAlphaMultiplier · Client, Menu
`surface.SetAlphaMultiplier(multiplier: number)`

Sets the alpha multiplier that will influence all upcoming drawing operations.
See also [render.SetBlend](https://wiki.facepunch.com/gmod/render.SetBlend).

**Arguments:**
- `multiplier` (number) — The multiplier ranging from 0 to 1.

[wiki](https://wiki.facepunch.com/gmod/surface.SetAlphaMultiplier)

---

### surface.SetDrawColor · Client, Menu
`surface.SetDrawColor(r: number, g: number, b: number, a: number = 255, color: Color)`

Set the color of any future shapes to be drawn, can be set by either using R, G, B, A as separate values or by a [Color](https://wiki.facepunch.com/gmod/Color).

**Arguments:**
- `r` (number) — The red value of color.
- `g` (number) — The green value of color.
- `b` (number) — The blue value of color.
- `a` (number, default `255`) — The alpha value of color.
- `color` (Color) — A Color object/table to read the color from.

> **Note:** The alpha value may not work properly if you're using a material without `$vertexalpha`.
> **Note:** Due to post processing and gamma correction the color you set with this function may appear differently when rendered. This problem does not occur on materials drawn with [surface.DrawTexturedRect](https://wiki.facepunch.com/gmod/surface.DrawTexturedRect).

[wiki](https://wiki.facepunch.com/gmod/surface.SetDrawColor)

---

### surface.SetFont · Client, Menu
`surface.SetFont(fontName: string)`

Set the current font to be used for text operations later.

The fonts must first be created with [surface.CreateFont](https://wiki.facepunch.com/gmod/surface.CreateFont) or be one of the [Default Fonts](https://wiki.facepunch.com/gmod/Default%20Fonts).

**Arguments:**
- `fontName` (string) — The name of the font to use.

[wiki](https://wiki.facepunch.com/gmod/surface.SetFont)

---

### surface.SetMaterial · Client, Menu
`surface.SetMaterial(material: IMaterial)`

Sets the material to be used in all upcoming draw operations using the surface library.

Not to be confused with [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial).

If you need to unset the texture, use the [draw.NoTexture](https://wiki.facepunch.com/gmod/draw.NoTexture) convenience function.

**Arguments:**
- `material` (IMaterial) — The material to be used.

> **Warning:** [Material](https://wiki.facepunch.com/gmod/Global.Material) function calls are expensive to be done inside this function or inside rendering context, you should be caching the results of [Material](https://wiki.facepunch.com/gmod/Global.Material) calls

[wiki](https://wiki.facepunch.com/gmod/surface.SetMaterial)

---

### surface.SetTextColor · Client, Menu
`surface.SetTextColor(r: number, g: number, b: number, a: number = 255, color: Color)`

Set the color of any future text to be drawn, can be set by either using R, G, B, A as separate numbers or by providing a [Color](https://wiki.facepunch.com/gmod/Color).

**Arguments:**
- `r` (number) — The red value of color.
- `g` (number) — The green value of color
- `b` (number) — The blue value of color
- `a` (number, default `255`) — The alpha value of color
- `color` (Color) — A Color object/table to read the color from.

[wiki](https://wiki.facepunch.com/gmod/surface.SetTextColor)

---

### surface.SetTextPos · Client, Menu
`surface.SetTextPos(x: number, y: number)`

Set the top-left position to draw any future text at.

**Arguments:**
- `x` (number) — The X integer co-ordinate.
- `y` (number) — The Y integer co-ordinate.

[wiki](https://wiki.facepunch.com/gmod/surface.SetTextPos)

---

### surface.SetTexture · Client, Menu
`surface.SetTexture(textureID: number)`

Sets the texture to be used in all upcoming draw operations using the surface library.

This is a legacy method, and should probably not be used, see [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial) and [IMaterial](https://wiki.facepunch.com/gmod/IMaterial) for a better alternative.

**Arguments:**
- `textureID` (number) — The ID of the texture to draw with returned by surface.GetTextureID.

[wiki](https://wiki.facepunch.com/gmod/surface.SetTexture)
