# DLabelURL

**Realm:** Client, Menu  ·  **Members:** 9  ·  **Inherits:** `URLLabel`

Underlined link label without a DoClick function. When a valid URL is set and the label is clicked, it will open a browser window and navigate to the address.

This panel uses [gui.OpenURL](https://wiki.facepunch.com/gmod/gui.OpenURL) internally and its restrictions apply.

[wiki page](https://wiki.facepunch.com/gmod/DLabelURL)

### DLabelURL:GetAutoStretchVertical · Client, Menu · `DEPRECATED`
`DLabelURL:GetAutoStretchVertical() → boolean`

Does absolutely nothing at all.

**Returns:**
- `draw` (boolean) — Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:GetAutoStretchVertical)

---

### DLabelURL:GetColor · Client, Menu
`DLabelURL:GetColor() → Color`

Gets the current text color of the [DLabelURL](https://wiki.facepunch.com/gmod/DLabelURL). Returns either [DLabelURL:GetTextColor](https://wiki.facepunch.com/gmod/DLabelURL:GetTextColor) or if that is unset -  [DLabelURL:GetTextStyleColor](https://wiki.facepunch.com/gmod/DLabelURL:GetTextStyleColor).

**Returns:**
- Color — The current text Color.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabelurl.lua#L36-L40)

---

### DLabelURL:GetTextColor · Client, Menu
`DLabelURL:GetTextColor() → Color`

Gets the current text color of the [DLabelURL](https://wiki.facepunch.com/gmod/DLabelURL) set by [DLabelURL:SetTextColor](https://wiki.facepunch.com/gmod/DLabelURL:SetTextColor).

**Returns:**
- Color — The current text Color.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:GetTextColor)

---

### DLabelURL:GetTextStyleColor · Client, Menu
`DLabelURL:GetTextStyleColor() → Color`

Returns the color set by [DLabelURL:SetTextStyleColor](https://wiki.facepunch.com/gmod/DLabelURL:SetTextStyleColor).

**Returns:**
- Color — The Color

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:GetTextStyleColor)

---

### DLabelURL:SetAutoStretchVertical · Client, Menu · `DEPRECATED`
`DLabelURL:SetAutoStretchVertical(draw: boolean)`

Does absolutely nothing at all.

**Arguments:**
- `draw` (boolean) — Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:SetAutoStretchVertical)

---

### DLabelURL:SetColor · Client, Menu
`DLabelURL:SetColor(col: Color)`

Alias of [DLabelURL:SetTextColor](https://wiki.facepunch.com/gmod/DLabelURL:SetTextColor).

**Arguments:**
- `col` (Color) — The Color to use.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabelurl.lua#L28-L33)

---

### DLabelURL:SetTextColor · Client, Menu
`DLabelURL:SetTextColor(col: Color)`

Sets the text color of the [DLabelURL](https://wiki.facepunch.com/gmod/DLabelURL). Overrides [DLabelURL:SetTextStyleColor](https://wiki.facepunch.com/gmod/DLabelURL:SetTextStyleColor).


This should only be used immediately after it is created, and otherwise [Panel:SetFGColor](https://wiki.facepunch.com/gmod/Panel:SetFGColor).

**Arguments:**
- `col` (Color) — The Color to use.

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:SetTextColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabelurl.lua#L28-L33)

---

### DLabelURL:SetTextStyleColor · Client, Menu
`DLabelURL:SetTextStyleColor(color: Color)`

Sets the base text color of the [DLabelURL](https://wiki.facepunch.com/gmod/DLabelURL). This is overridden by [DLabelURL:SetTextColor](https://wiki.facepunch.com/gmod/DLabelURL:SetTextColor).

**Arguments:**
- `color` (Color) — The Color to set

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:SetTextStyleColor)

---

### DLabelURL:UpdateFGColor · Client, Menu · `INTERNAL`
`DLabelURL:UpdateFGColor()`

Used internally to set correct text color via [Panel:SetFGColor](https://wiki.facepunch.com/gmod/Panel:SetFGColor) and [DLabelURL:GetColor](https://wiki.facepunch.com/gmod/DLabelURL:GetColor).

[wiki](https://wiki.facepunch.com/gmod/DLabelURL:UpdateFGColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabelurl.lua#L56-L61)
