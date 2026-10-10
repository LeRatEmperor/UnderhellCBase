# DColorButton

**Realm:** Client, Menu  ·  **Members:** 8  ·  **Inherits:** `DLabel`

Colorful buttons. Used internally by [DColorPalette](https://wiki.facepunch.com/gmod/DColorPalette).

[wiki page](https://wiki.facepunch.com/gmod/DColorButton)

### DColorButton:GetColor · Client, Menu
`DColorButton:GetColor() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color of the button

**Returns:**
- Color — The Color of the button

[wiki](https://wiki.facepunch.com/gmod/DColorButton:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L9)

---

### DColorButton:GetDrawBorder · Client, Menu · `DEPRECATED`
`DColorButton:GetDrawBorder() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns value set by [DColorButton:SetDrawBorder](https://wiki.facepunch.com/gmod/DColorButton:SetDrawBorder). See that page for more info.

**Returns:**
- boolean — Value set by DColorButton:SetDrawBorder.

[wiki](https://wiki.facepunch.com/gmod/DColorButton:GetDrawBorder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L6)

---

### DColorButton:GetID · Client, Menu
`DColorButton:GetID() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the unique ID set by [DColorButton:SetID](https://wiki.facepunch.com/gmod/DColorButton:SetID).

Used internally by [DColorPalette](https://wiki.facepunch.com/gmod/DColorPalette)

**Returns:**
- number — The unique ID of the button

[wiki](https://wiki.facepunch.com/gmod/DColorButton:GetID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L10)

---

### DColorButton:GetSelected · Client, Menu · `DEPRECATED`
`DColorButton:GetSelected() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that is an alias of [Panel:IsSelected](https://wiki.facepunch.com/gmod/Panel:IsSelected).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DColorButton:GetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L7)

---

### DColorButton:IsDown · Client, Menu
`DColorButton:IsDown() → boolean`

Returns whether the [DColorButton](https://wiki.facepunch.com/gmod/DColorButton) is currently being pressed (the user is holding it down).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DColorButton:IsDown) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L24-L28)

---

### DColorButton:SetColor · Client, Menu
`DColorButton:SetColor(color: Color, noTooltip: boolean = false)`

Sets the color of the [DColorButton](https://wiki.facepunch.com/gmod/DColorButton).

**Arguments:**
- `color` (Color) — A Color to set the color as
- `noTooltip` (boolean, default `false`) — If true, the tooltip will not be reset to display the selected color.

[wiki](https://wiki.facepunch.com/gmod/DColorButton:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L30-L41)

---

### DColorButton:SetDrawBorder · Client, Menu · `DEPRECATED`
`DColorButton:SetDrawBorder(draw: boolean)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that does absolutely nothing at all. Default value is automatically set to true.

**Arguments:**
- `draw` (boolean) — Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DColorButton:SetDrawBorder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DColorButton:SetID · Client, Menu
`DColorButton:SetID(id: number)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that is used internally by [DColorPalette](https://wiki.facepunch.com/gmod/DColorPalette) to detect which button is which.
	
	Pairs with [DColorButton:GetID](https://wiki.facepunch.com/gmod/DColorButton:GetID)

**Arguments:**
- `id` (number) — A unique ID to give this button

[wiki](https://wiki.facepunch.com/gmod/DColorButton:SetID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorbutton.lua#L10)
