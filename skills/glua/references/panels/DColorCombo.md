# DColorCombo

**Realm:** Client  ·  **Members:** 5  ·  **Inherits:** `DPropertySheet`

The **DColorCombo** allows the user to choose color, without alpha, 
		using [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer) or [DColorPalette](https://wiki.facepunch.com/gmod/DColorPalette) in a tabbed view.

[wiki page](https://wiki.facepunch.com/gmod/DColorCombo)

### DColorCombo:BuildControls · Client · `INTERNAL`
`DColorCombo:BuildControls()`

Called internally to create panels necessary for this panel to work.

[wiki](https://wiki.facepunch.com/gmod/DColorCombo:BuildControls) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcombo.lua#L14-L55)

---

### DColorCombo:GetColor · Client
`DColorCombo:GetColor() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color of the [DColorCombo](https://wiki.facepunch.com/gmod/DColorCombo).

**Returns:**
- Color — A Color

[wiki](https://wiki.facepunch.com/gmod/DColorCombo:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcombo.lua#L4)

---

### DColorCombo:IsEditing · Client
`DColorCombo:IsEditing() → boolean`

Returns true if the panel is currently being edited

More of a internal method, it technically should only ever work (i.e. return true) inside [DColorCombo:OnValueChanged](https://wiki.facepunch.com/gmod/DColorCombo:OnValueChanged).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DColorCombo:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcombo.lua#L57-L61)

---

### DColorCombo:OnValueChanged · Client · `hook`
`DColorCombo:OnValueChanged(newcol: Color)`

Called when the value (color) of this panel was changed. For override

**Arguments:**
- `newcol` (Color)

[wiki](https://wiki.facepunch.com/gmod/DColorCombo:OnValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcombo.lua#L63-L67)

---

### DColorCombo:SetColor · Client
`DColorCombo:SetColor(clr: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color of this panel. See also [DColorCombo:GetColor](https://wiki.facepunch.com/gmod/DColorCombo:GetColor)

**Arguments:**
- `clr` (Color) — A Color.

[wiki](https://wiki.facepunch.com/gmod/DColorCombo:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorcombo.lua#L69-L75)
