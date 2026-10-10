# DPanel

**Realm:** Client, Menu  ·  **Members:** 13  ·  **Inherits:** `Panel`

A simple rectangular box, commonly used for parenting other elements to. Pretty much all elements are based on this.

[wiki page](https://wiki.facepunch.com/gmod/DPanel)

### DPanel:GetBackgroundColor · Client, Menu
`DPanel:GetBackgroundColor() → Color`

Returns the panel's background color.

**Returns:**
- Color — Color of the panel's background.

> **Note:** By default this returns **nil** even though the default background color is white

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetBackgroundColor)

---

### DPanel:GetDisabled · Client, Menu · `DEPRECATED`
`DPanel:GetDisabled() → boolean`

Returns whether or not the panel is disabled.

**Returns:**
- boolean — `true` if the panel is disabled (mouse input disabled and background alpha set to 75), `false` if its enabled (mouse input enabled and background alpha set to 255).

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetDisabled)

---

### DPanel:GetDrawBackground · Client, Menu · `DEPRECATED`
`DPanel:GetDrawBackground() → boolean`

Returns whether or not the panel background is being drawn. Alias of [DPanel:GetPaintBackground](https://wiki.facepunch.com/gmod/DPanel:GetPaintBackground).

**Returns:**
- boolean — True if the panel background is drawn, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetDrawBackground)

---

### DPanel:GetIsMenu · Client, Menu
`DPanel:GetIsMenu() → boolean`

Used internally by [DMenu](https://wiki.facepunch.com/gmod/DMenu).

Returns whether the frame is part of a derma menu or not.

If this is `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the frame is clicked, and thus any open menus will remain open.

**Returns:**
- `isMenu` (boolean) — Whether this panel is a Menu Component

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetIsMenu)

---

### DPanel:GetPaintBackground · Client, Menu
`DPanel:GetPaintBackground() → boolean`

Returns whether or not the panel background is being drawn.

**Returns:**
- boolean — True if the panel background is drawn, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetPaintBackground)

---

### DPanel:GetTabbingDisabled · Client, Menu · `DEPRECATED`
`DPanel:GetTabbingDisabled() → boolean`

Does nothing. Returns value set by [DPanel:SetTabbingDisabled](https://wiki.facepunch.com/gmod/DPanel:SetTabbingDisabled).

**Returns:**
- `draw` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DPanel:GetTabbingDisabled)

---

### DPanel:SetBackgroundColor · Client, Menu
`DPanel:SetBackgroundColor(color: Color)`

Sets the background color of the panel.

**Arguments:**
- `color` (Color) — The background Color.

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetBackgroundColor)

---

### DPanel:SetDisabled · Client, Menu · `DEPRECATED`
`DPanel:SetDisabled(disabled: boolean)`

Sets whether or not to disable the panel.

**Arguments:**
- `disabled` (boolean) — True to disable the panel (mouse input disabled and background alpha set to 75), false to enable it (mouse input enabled and background alpha set to 255).

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanel.lua#L26-L38)

---

### DPanel:SetDrawBackground · Client, Menu · `DEPRECATED`
`DPanel:SetDrawBackground(draw: boolean)`

Sets whether or not to draw the panel background. Alias of [DPanel:SetPaintBackground](https://wiki.facepunch.com/gmod/DPanel:SetPaintBackground).

**Arguments:**
- `draw` (boolean) — True to show the panel's background, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetDrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DPanel:SetIsMenu · Client, Menu
`DPanel:SetIsMenu(isMenu: boolean)`

Used internally by [DMenu](https://wiki.facepunch.com/gmod/DMenu).


Sets whether the frame is part of a derma menu or not.

If this is set to `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the frame is clicked, and thus any open menus will remain open.

**Arguments:**
- `isMenu` (boolean) — Whether this pane is a Menu Component

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetIsMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DPanel:SetPaintBackground · Client, Menu
`DPanel:SetPaintBackground(paint: boolean)`

Sets whether or not to paint/draw the panel background.

**Arguments:**
- `paint` (boolean) — True to show the panel's background, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DPanel:SetTabbingDisabled · Client, Menu · `DEPRECATED`
`DPanel:SetTabbingDisabled(draw: boolean)`

Does nothing.

**Arguments:**
- `draw` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DPanel:SetTabbingDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DPanel:UpdateColours · Client, Menu · `DEPRECATED`
`DPanel:UpdateColours()`

Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DPanel:UpdateColours) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanel.lua#L80-L81)
