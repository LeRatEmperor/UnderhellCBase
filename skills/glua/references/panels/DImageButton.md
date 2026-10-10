# DImageButton

**Realm:** Client, Menu  ·  **Members:** 13  ·  **Inherits:** `DButton`

An image button.

		This panel inherits all methods of [DButton](https://wiki.facepunch.com/gmod/DButton), such as [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick).

[wiki page](https://wiki.facepunch.com/gmod/DImageButton)

### DImageButton:DepressImage · Client, Menu · `INTERNAL`
`DImageButton:DepressImage()`

Used internally to briefly scale the image when clicked.

[wiki](https://wiki.facepunch.com/gmod/DImageButton:DepressImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L72-L91)

---

### DImageButton:GetDepressImage · Client, Menu
`DImageButton:GetDepressImage() → boolean`

Returns whether [DImageButton:DepressImage](https://wiki.facepunch.com/gmod/DImageButton:DepressImage) is functional or not.

**Returns:**
- `enable` (boolean) — `true` to enable image depressing when clicked.

[wiki](https://wiki.facepunch.com/gmod/DImageButton:GetDepressImage)

---

### DImageButton:GetImage · Client, Menu
`DImageButton:GetImage() → string`

Returns the "image" of the [DImageButton](https://wiki.facepunch.com/gmod/DImageButton). Equivalent of [DImage:GetImage](https://wiki.facepunch.com/gmod/DImage:GetImage).

**Returns:**
- string — The path to the image that is loaded.

[wiki](https://wiki.facepunch.com/gmod/DImageButton:GetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L46-L50)

---

### DImageButton:GetStretchToFit · Client, Menu
`DImageButton:GetStretchToFit() → boolean`

Returns whether the image inside the button should be stretched to fit it or not

See [DImageButton:SetStretchToFit](https://wiki.facepunch.com/gmod/DImageButton:SetStretchToFit)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DImageButton:GetStretchToFit)

---

### DImageButton:SetColor · Client, Menu
`DImageButton:SetColor(color: Color)`

Sets the color of the image. Equivalent of [DImage:SetImageColor](https://wiki.facepunch.com/gmod/DImage:SetImageColor)

**Arguments:**
- `color` (Color) — The Color to set

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L39-L44)

---

### DImageButton:SetDepressImage · Client, Menu
`DImageButton:SetDepressImage(enable: boolean)`

Controls whether [DImageButton:DepressImage](https://wiki.facepunch.com/gmod/DImageButton:DepressImage) is functional or not.

**Arguments:**
- `enable` (boolean) — `true` to enable image depressing when clicked.

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetDepressImage)

---

### DImageButton:SetIcon · Client, Menu · `DEPRECATED`
`DImageButton:SetIcon(strImage: string, strBackup: string = nil)`

Alias of [DImageButton:SetImage](https://wiki.facepunch.com/gmod/DImageButton:SetImage).

**Arguments:**
- `strImage` (string)
- `strBackup` (string, default `nil`)

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L32-L36)

---

### DImageButton:SetImage · Client, Menu
`DImageButton:SetImage(strImage: string, strBackup: string = nil)`

Sets the "image" of the [DImageButton](https://wiki.facepunch.com/gmod/DImageButton). Equivalent of [DImage:SetImage](https://wiki.facepunch.com/gmod/DImage:SetImage).

**Arguments:**
- `strImage` (string) — The path of the image to load, relative to the `materials/` folder.
- `strBackup` (string, default `nil`) — The path of the backup image.

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L32-L36)

---

### DImageButton:SetImageVisible · Client, Menu
`DImageButton:SetImageVisible(visible: boolean)`

Hides or shows the image of the image button. Internally this calls [Panel:SetVisible](https://wiki.facepunch.com/gmod/Panel:SetVisible) on the internal [DImage](https://wiki.facepunch.com/gmod/DImage).

**Arguments:**
- `visible` (boolean) — Set true to make it visible ( default ), or false to hide the image

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetImageVisible) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L26-L30)

---

### DImageButton:SetKeepAspect · Client, Menu
`DImageButton:SetKeepAspect(keep: boolean)`

Sets whether the [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) should keep the aspect ratio of its image. Equivalent of [DImage:SetKeepAspect](https://wiki.facepunch.com/gmod/DImage:SetKeepAspect).

Note that this will not try to fit the image inside the button, but instead it will fill the button with the image.

**Arguments:**
- `keep` (boolean) — true to keep the aspect ratio, false not to

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetKeepAspect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L52-L56)

---

### DImageButton:SetMaterial · Client, Menu
`DImageButton:SetMaterial(mat: IMaterial)`

Sets a [Material](https://wiki.facepunch.com/gmod/Global.Material) directly as an image. Equivalent of [DImage:SetMaterial](https://wiki.facepunch.com/gmod/DImage:SetMaterial).

**Arguments:**
- `mat` (IMaterial) — The material to set

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L59-L63)

---

### DImageButton:SetOnViewMaterial · Client, Menu
`DImageButton:SetOnViewMaterial(mat: string, backup: string)`

See [DImage:SetOnViewMaterial](https://wiki.facepunch.com/gmod/DImage:SetOnViewMaterial)

**Arguments:**
- `mat` (string)
- `backup` (string)

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetOnViewMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dimagebutton.lua#L142-L146)

---

### DImageButton:SetStretchToFit · Client, Menu
`DImageButton:SetStretchToFit(stretch: boolean)`

Sets whether the image inside the [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) should be stretched to fill the entire size of the button, without preserving aspect ratio.

If set to false, the image will not be resized at all.

**Arguments:**
- `stretch` (boolean) — True to stretch, false to not to stretch

[wiki](https://wiki.facepunch.com/gmod/DImageButton:SetStretchToFit)
