# DRGBPicker

**Realm:** Client, Menu  ·  **Members:** 4  ·  **Inherits:** `DPanel`

DRGBPicker is an interactive panel which can be used to select a color hue.

See [DColorCube](https://wiki.facepunch.com/gmod/DColorCube) for a color picker which controls brightness and saturation.

See [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer) for a color picker that allows control over hue, saturation, and brightness at once.

[wiki page](https://wiki.facepunch.com/gmod/DRGBPicker)

### DRGBPicker:GetPosColor · Client, Menu · `INTERNAL`
`DRGBPicker:GetPosColor(x: number, y: number) → Color, number, number`

Returns the color at given position on the internal texture.

**Arguments:**
- `x` (number) — The X coordinate on the texture to get the color from
- `y` (number) — The Y coordinate on the texture to get the color from

**Returns:**
- Color — The Color
- number — The X-coordinate clamped to the texture's width.
- number — The Y-coordinate clamped to the texture's height.

[wiki](https://wiki.facepunch.com/gmod/DRGBPicker:GetPosColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/drgbpicker.lua#L17-L29)

---

### DRGBPicker:GetRGB · Client, Menu
`DRGBPicker:GetRGB() → Color`

Returns the color currently set on the color picker.

**Returns:**
- Color — The color set on the color picker, see Color.

[wiki](https://wiki.facepunch.com/gmod/DRGBPicker:GetRGB)

---

### DRGBPicker:OnChange · Client, Menu · `hook`
`DRGBPicker:OnChange(col: Color)`

Function which is called when the cursor is clicked and/or moved on the color picker. Meant to be overridden.

**Arguments:**
- `col` (Color) — The color that is selected on the color picker (Color form).

[wiki](https://wiki.facepunch.com/gmod/DRGBPicker:OnChange)

---

### DRGBPicker:SetRGB · Client, Menu
`DRGBPicker:SetRGB(color: Color)`

Sets the color stored in the color picker.

**Arguments:**
- `color` (Color) — The color to set, see Color.

> **Note:** This function is meant to be called internally and will not update the position of the color picker line or call [DRGBPicker:OnChange](https://wiki.facepunch.com/gmod/DRGBPicker:OnChange)

[wiki](https://wiki.facepunch.com/gmod/DRGBPicker:SetRGB)
