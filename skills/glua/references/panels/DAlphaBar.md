# DAlphaBar

**Realm:** Client, Menu  ·  **Members:** 5  ·  **Inherits:** `DPanel`

A bar to select the opacity (alpha level) of a color.

[wiki page](https://wiki.facepunch.com/gmod/DAlphaBar)

### DAlphaBar:GetBarColor · Client, Menu
`DAlphaBar:GetBarColor() → Color`

Returns the base color of the alpha bar. This is the color for which the alpha channel is being modified. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- Color — The current base Color.

[wiki](https://wiki.facepunch.com/gmod/DAlphaBar:GetBarColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dalphabar.lua#L8)

---

### DAlphaBar:GetValue · Client, Menu
`DAlphaBar:GetValue() → number`

Returns the alpha value of the alpha bar. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- number — The current alpha value.

[wiki](https://wiki.facepunch.com/gmod/DAlphaBar:GetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dalphabar.lua#L7)

---

### DAlphaBar:OnChange · Client, Menu · `hook`
`DAlphaBar:OnChange(alpha: number)`

Called when user changes the desired alpha value with the control. This function is meant to be overridden

**Arguments:**
- `alpha` (number) — The new alpha value

[wiki](https://wiki.facepunch.com/gmod/DAlphaBar:OnChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dalphabar.lua#L45-L46)

---

### DAlphaBar:SetBarColor · Client, Menu
`DAlphaBar:SetBarColor(clr: Color)`

Sets the base color of the alpha bar. This is the color for which the alpha channel is being modified. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `clr` (Color) — The new Color to set.

[wiki](https://wiki.facepunch.com/gmod/DAlphaBar:SetBarColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dalphabar.lua#L8)

---

### DAlphaBar:SetValue · Client, Menu
`DAlphaBar:SetValue(alpha: number)`

Sets the alpha value or the alpha bar. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `alpha` (number) — The new alpha value to set

[wiki](https://wiki.facepunch.com/gmod/DAlphaBar:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dalphabar.lua#L7)
