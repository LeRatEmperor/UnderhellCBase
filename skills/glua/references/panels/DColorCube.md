# DColorCube

**Realm:** Client, Menu  ·  **Members:** 13  ·  **Inherits:** `DSlider`

The DColorCube allows a user to select saturation and value but not hue. Uses HSV colors

[wiki page](https://wiki.facepunch.com/gmod/DColorCube)

### DColorCube:GetBaseRGB · Client, Menu
`DColorCube:GetBaseRGB() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the base Color set by [DColorCube:SetBaseRGB](https://wiki.facepunch.com/gmod/DColorCube:SetBaseRGB).

**Returns:**
- Color — A Color

[wiki](https://wiki.facepunch.com/gmod/DColorCube:GetBaseRGB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L5)

---

### DColorCube:GetDefaultColor · Client, Menu
`DColorCube:GetDefaultColor() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color cube's default color. By default, it is set to white. (255 255 255 RGB)

**Returns:**
- Color — The default Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:GetDefaultColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L7)

---

### DColorCube:GetHue · Client, Menu · `DEPRECATED`
`DColorCube:GetHue() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the value set by [DColorCube:SetHue](https://wiki.facepunch.com/gmod/DColorCube:SetHue).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DColorCube:GetHue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L4)

---

### DColorCube:GetRGB · Client, Menu
`DColorCube:GetRGB() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color cube's current set color.

**Returns:**
- Color — The set color, uses Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:GetRGB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L6)

---

### DColorCube:OnUserChanged · Client, Menu · `hook`
`DColorCube:OnUserChanged(color: Color)`

Function which is called when the color cube slider is moved (through user input). Meant to be overridden.

**Arguments:**
- `color` (Color) — The new color, uses Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:OnUserChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L89-L93)

---

### DColorCube:ResetToDefaultValue · Client, Menu
`DColorCube:ResetToDefaultValue()`

Sets the color to whatever [DColorCube:GetDefaultColor](https://wiki.facepunch.com/gmod/DColorCube:GetDefaultColor) returns

[wiki](https://wiki.facepunch.com/gmod/DColorCube:ResetToDefaultValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L43-L48)

---

### DColorCube:SetBaseRGB · Client, Menu
`DColorCube:SetBaseRGB(color: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the base color and the color used to draw the color cube panel itself.

**Arguments:**
- `color` (Color) — The base color to set, uses Color.

> **Note:** Calling this when using a color that isn't 100% saturated and valued ([HSVToColor](https://wiki.facepunch.com/gmod/Global.HSVToColor) with saturation and value set to 1) causes the color cube to look inaccurate compared to the color that's returned by methods like [DColorCube:GetRGB](https://wiki.facepunch.com/gmod/DColorCube:GetRGB) and [DColorCube:OnUserChanged](https://wiki.facepunch.com/gmod/DColorCube:OnUserChanged). You should use [DColorCube:SetColor](https://wiki.facepunch.com/gmod/DColorCube:SetColor) instead

[wiki](https://wiki.facepunch.com/gmod/DColorCube:SetBaseRGB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L97-L102)

---

### DColorCube:SetColor · Client, Menu
`DColorCube:SetColor(color: Color)`

Sets the base color of the color cube and updates the slider position.

**Arguments:**
- `color` (Color) — The color to set, uses Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L85-L95)

---

### DColorCube:SetDefaultColor · Client, Menu
`DColorCube:SetDefaultColor(a1: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the color cube's default color. This value will be used to reset to on middle mouse click of the color cube's draggable slider.

**Arguments:**
- `a1` (Color) — The new default Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:SetDefaultColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L7)

---

### DColorCube:SetHue · Client, Menu · `DEPRECATED`
`DColorCube:SetHue(hue: number)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that appears to do nothing and unused.

**Arguments:**
- `hue` (number)

[wiki](https://wiki.facepunch.com/gmod/DColorCube:SetHue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L4)

---

### DColorCube:SetRGB · Client, Menu · `INTERNAL`
`DColorCube:SetRGB(clr: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that used internally to set the real "output" color of the panel.

**Arguments:**
- `clr` (Color) — A Color

[wiki](https://wiki.facepunch.com/gmod/DColorCube:SetRGB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L6)

---

### DColorCube:TranslateValues · Client, Menu · `INTERNAL`
`DColorCube:TranslateValues(x: number = nil, y: number = nil) → number, number`

Updates the color cube RGB based on the given x and y position and returns its arguments. Similar to [DColorCube:UpdateColor](https://wiki.facepunch.com/gmod/DColorCube:UpdateColor).

**Arguments:**
- `x` (number, default `nil`) — The x position to sample color from/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
- `y` (number, default `nil`) — The y position to sample color from/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).

**Returns:**
- number — The given x position.
- number — The given y position.

[wiki](https://wiki.facepunch.com/gmod/DColorCube:TranslateValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L55-L62)

---

### DColorCube:UpdateColor · Client, Menu · `INTERNAL`
`DColorCube:UpdateColor(x: number = nil, y: number = nil)`

Updates the color cube RGB based on the given x and y position. Similar to [DColorCube:TranslateValues](https://wiki.facepunch.com/gmod/DColorCube:TranslateValues).

**Arguments:**
- `x` (number, default `nil`) — The x position to set color to/the percentage of saturation to remove from the color (ranges from 0.0 to 1.0).
- `y` (number, default `nil`) — The y position to set color to/the percentage of brightness or value to remove from the color (ranges from 0.0 to 1.0).

[wiki](https://wiki.facepunch.com/gmod/DColorCube:UpdateColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcube.lua#L64-L77)
