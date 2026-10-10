# DImage

**Realm:** Client, Menu  ·  **Members:** 18  ·  **Inherits:** `DPanel`

[DImage](https://wiki.facepunch.com/gmod/DImage) is an advanced, more robust version of the [Material](https://wiki.facepunch.com/gmod/Material) panel.

		See [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) for a click-able version of this panel.

[wiki page](https://wiki.facepunch.com/gmod/DImage)

### DImage:DoLoadMaterial · Client, Menu · `INTERNAL`
`DImage:DoLoadMaterial()`

Actually loads the [IMaterial](https://wiki.facepunch.com/gmod/IMaterial) to render it. Called from [DImage:LoadMaterial](https://wiki.facepunch.com/gmod/DImage:LoadMaterial).

[wiki](https://wiki.facepunch.com/gmod/DImage:DoLoadMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L47-L65)

---

### DImage:FixVertexLitMaterial · Client, Menu · `INTERNAL`
`DImage:FixVertexLitMaterial()`

"Fixes" the current material of the [DImage](https://wiki.facepunch.com/gmod/DImage) if it has VertexLit shader by creating a new one with the same name and a prefix of "_DImage" and automatically calling [DImage:SetMaterial](https://wiki.facepunch.com/gmod/DImage:SetMaterial) with the new material.

This fixes the problem where using materials using shaders that expect lighting information causing "weird" flickering when displayed in 2D/Unlit environment.

[wiki](https://wiki.facepunch.com/gmod/DImage:FixVertexLitMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L111-L141)

---

### DImage:GetFailsafeMatName · Client, Menu · `INTERNAL`
`DImage:GetFailsafeMatName() → string`

Returns the texture path set by [DImage:SetFailsafeMatName](https://wiki.facepunch.com/gmod/DImage:SetFailsafeMatName).

**Returns:**
- string

[wiki](https://wiki.facepunch.com/gmod/DImage:GetFailsafeMatName)

---

### DImage:GetImage · Client, Menu
`DImage:GetImage() → string`

Returns the image loaded in the image panel.

**Returns:**
- string — The path to the image that is loaded.

[wiki](https://wiki.facepunch.com/gmod/DImage:GetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L105-L109)

---

### DImage:GetImageColor · Client, Menu
`DImage:GetImageColor() → Color`

Returns the color override of the image panel.

**Returns:**
- `col` (Color) — The color override of the image.

[wiki](https://wiki.facepunch.com/gmod/DImage:GetImageColor)

---

### DImage:GetKeepAspect · Client, Menu
`DImage:GetKeepAspect() → boolean`

Returns whether the [DImage](https://wiki.facepunch.com/gmod/DImage) should keep the aspect ratio of its image when being resized.

See [DImage:SetKeepAspect](https://wiki.facepunch.com/gmod/DImage:SetKeepAspect) for more info on how it works.

**Returns:**
- boolean — Whether the DImage should keep the aspect ratio of its image when being resized.

[wiki](https://wiki.facepunch.com/gmod/DImage:GetKeepAspect)

---

### DImage:GetMaterial · Client, Menu
`DImage:GetMaterial() → IMaterial`

Returns the current [Material](https://wiki.facepunch.com/gmod/Global.Material) of the [DImage](https://wiki.facepunch.com/gmod/DImage).

**Returns:**
- IMaterial

[wiki](https://wiki.facepunch.com/gmod/DImage:GetMaterial)

---

### DImage:GetMatName · Client, Menu · `INTERNAL`
`DImage:GetMatName() → string`

Returns the texture path set by [DImage:SetMatName](https://wiki.facepunch.com/gmod/DImage:SetMatName).

**Returns:**
- string

[wiki](https://wiki.facepunch.com/gmod/DImage:GetMatName)

---

### DImage:LoadMaterial · Client, Menu · `INTERNAL`
`DImage:LoadMaterial()`

Initializes the loading process of the material to render if it is not loaded yet.

You do not need to call this function. It is done for you automatically.

[wiki](https://wiki.facepunch.com/gmod/DImage:LoadMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L37-L45)

---

### DImage:PaintAt · Client, Menu
`DImage:PaintAt(posX: number, posY: number, width: number, height: number)`

Paints a ghost copy of the DImage panel at the given position and dimensions. This function overrides [Panel:PaintAt](https://wiki.facepunch.com/gmod/Panel:PaintAt).

**Arguments:**
- `posX` (number) — The x coordinate to draw the panel from.
- `posY` (number) — The y coordinate to draw the panel from.
- `width` (number) — The width of the panel image to be drawn.
- `height` (number) — The height of the panel image to be drawn.

[wiki](https://wiki.facepunch.com/gmod/DImage:PaintAt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L155-L218)

---

### DImage:SetFailsafeMatName · Client, Menu · `INTERNAL`
`DImage:SetFailsafeMatName(backupMat: string)`

Sets the backup material to be loaded when the image is first rendered. Used by [DImage:SetOnViewMaterial](https://wiki.facepunch.com/gmod/DImage:SetOnViewMaterial).

**Arguments:**
- `backupMat` (string)

[wiki](https://wiki.facepunch.com/gmod/DImage:SetFailsafeMatName)

---

### DImage:SetImage · Client, Menu
`DImage:SetImage(strImage: string, strBackup: string = nil)`

Sets the image to load into the frame. If the first image can't be loaded and `strBackup` is set, that image will be loaded instead.

This eventually calls [DImage:SetMaterial](https://wiki.facepunch.com/gmod/DImage:SetMaterial).

**Arguments:**
- `strImage` (string) — The path of the image to load, relative to the `materials/` folder.
- `strBackup` (string, default `nil`) — The path of the backup image.

[wiki](https://wiki.facepunch.com/gmod/DImage:SetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L91-L103)

---

### DImage:SetImageColor · Client, Menu
`DImage:SetImageColor(col: Color)`

Sets the image's color override.

**Arguments:**
- `col` (Color) — The color override of the image.

[wiki](https://wiki.facepunch.com/gmod/DImage:SetImageColor)

---

### DImage:SetKeepAspect · Client, Menu
`DImage:SetKeepAspect(keep: boolean)`

Sets whether the [DImage](https://wiki.facepunch.com/gmod/DImage) should keep the aspect ratio of its image when being resized.

Note that this will not try to fit the image inside the button, but instead it will fill the button with the image.

**Arguments:**
- `keep` (boolean) — true to keep the aspect ratio, false not to

[wiki](https://wiki.facepunch.com/gmod/DImage:SetKeepAspect)

---

### DImage:SetMaterial · Client, Menu
`DImage:SetMaterial(mat: IMaterial)`

Sets a [Material](https://wiki.facepunch.com/gmod/Global.Material) directly as an image.

**Arguments:**
- `mat` (IMaterial) — The material to set

[wiki](https://wiki.facepunch.com/gmod/DImage:SetMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L67-L89)

---

### DImage:SetMatName · Client, Menu · `INTERNAL`
`DImage:SetMatName(mat: string)`

Sets the material to be loaded when the image is first rendered. Used by [DImage:SetOnViewMaterial](https://wiki.facepunch.com/gmod/DImage:SetOnViewMaterial).

**Arguments:**
- `mat` (string)

[wiki](https://wiki.facepunch.com/gmod/DImage:SetMatName)

---

### DImage:SetOnViewMaterial · Client, Menu
`DImage:SetOnViewMaterial(mat: string, backupMat: string)`

Similar to [DImage:SetImage](https://wiki.facepunch.com/gmod/DImage:SetImage), but will only do the expensive part of actually loading the textures/material if the material is about to be rendered/viewed.

Useful for cases like [DIconBrowser](https://wiki.facepunch.com/gmod/DIconBrowser), where there are hundreds of small icons in 1 panel in a list that do not need all to be loaded at the same time.

**Arguments:**
- `mat` (string)
- `backupMat` (string)

[wiki](https://wiki.facepunch.com/gmod/DImage:SetOnViewMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L25-L31)

---

### DImage:Unloaded · Client, Menu
`DImage:Unloaded() → boolean`

Returns true if the image is **not** yet loaded.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DImage:Unloaded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimage.lua#L33-L35)
