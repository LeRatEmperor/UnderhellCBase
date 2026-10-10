# DColorPalette

**Realm:** Client, Menu  ·  **Members:** 23  ·  **Inherits:** `DIconLayout`

The **DColorPalette** allows the player to select a color from a list of given colors.  
		This panel supports saving across sessions via the panel cookie system.  
		Use [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName) to change "save files".

[wiki page](https://wiki.facepunch.com/gmod/DColorPalette)

### DColorPalette:DoClick · Client, Menu · `DEPRECATED`
`DColorPalette:DoClick(clr: Color, btn: Panel)`

Basically the same functionality as [DColorPalette:OnValueChanged](https://wiki.facepunch.com/gmod/DColorPalette:OnValueChanged), you should use that instead!

For Override

**Arguments:**
- `clr` (Color) — The new color via the Color
- `btn` (Panel) — The DColorButton that was pressed.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:DoClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L121-L125)

---

### DColorPalette:GetButtonSize · Client, Menu
`DColorPalette:GetButtonSize() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the size of each palette button. Set by [DColorPalette:SetButtonSize](https://wiki.facepunch.com/gmod/DColorPalette:SetButtonSize).

**Returns:**
- number — The size of each palette button

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetButtonSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L11)

---

### DColorPalette:GetConVarA · Client, Menu
`DColorPalette:GetConVarA() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the alpha channel of the color.

See also:
* [DColorPalette:GetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarR) - For the red channel
* [DColorPalette:GetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarG) - For the green channel
* [DColorPalette:GetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarB) - For the blue channel

**Returns:**
- string — The ConVar name for the alpha channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarA) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L9)

---

### DColorPalette:GetConVarB · Client, Menu
`DColorPalette:GetConVarB() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the blue channel of the color.

See also:
* [DColorPalette:GetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarR) - For the red channel
* [DColorPalette:GetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarG) - For the green channel
* [DColorPalette:GetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the blue channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L8)

---

### DColorPalette:GetConVarG · Client, Menu
`DColorPalette:GetConVarG() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the green channel of the color.

See also:
* [DColorPalette:GetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarR) - For the red channel
* [DColorPalette:GetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarB) - For the blue channel
* [DColorPalette:GetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the green channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarG) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L7)

---

### DColorPalette:GetConVarR · Client, Menu
`DColorPalette:GetConVarR() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the red channel of the color.

See also:
* [DColorPalette:GetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarG) - For the green channel
* [DColorPalette:GetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarB) - For the blue channel
* [DColorPalette:GetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the red channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetConVarR) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L6)

---

### DColorPalette:GetNumRows · Client, Menu
`DColorPalette:GetNumRows() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the number of rows of the palette, provided 6 colors fill each row. This value is equal to the number of colors in the DColorPalette divided by 6.

**Returns:**
- number — Number of rows of the DColorPalette.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:GetNumRows) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L13)

---

### DColorPalette:NetworkColorChange · Client, Menu · `INTERNAL`
`DColorPalette:NetworkColorChange()`

Used internally to make sure changes on one palette affect other palettes with same name.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:NetworkColorChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L103-L119)

---

### DColorPalette:OnRightClickButton · Client, Menu
`DColorPalette:OnRightClickButton(pnl: Panel)`

Called when a palette button has been pressed. For Override

**Arguments:**
- `pnl` (Panel) — The DColorButton that was pressed.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:OnRightClickButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L232-L234)

---

### DColorPalette:OnValueChanged · Client, Menu · `hook`
`DColorPalette:OnValueChanged(newcol: Color)`

Called when the color is changed after clicking a new value. For Override

**Arguments:**
- `newcol` (Color) — The new color of the DColorPalette

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:OnValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L228-L230)

---

### DColorPalette:Reset · Client, Menu
`DColorPalette:Reset()`

Resets this entire color palette to a default preset one, without saving.

See [DColorPalette:ResetSavedColors](https://wiki.facepunch.com/gmod/DColorPalette:ResetSavedColors) for version that also saves the changes.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:Reset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L127-L131)

---

### DColorPalette:ResetSavedColors · Client, Menu
`DColorPalette:ResetSavedColors()`

Resets this entire color palette to a default preset one and saves the changes.

See [DColorPalette:Reset](https://wiki.facepunch.com/gmod/DColorPalette:Reset) for version that does not save the changes.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:ResetSavedColors) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L133-L148)

---

### DColorPalette:SaveColor · Client, Menu
`DColorPalette:SaveColor(btn: Panel, clr: Color)`

Saves the color of given button across sessions.  
The color is saved as a panel cookie, see [Panel:SetCookie](https://wiki.facepunch.com/gmod/Panel:SetCookie) and [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName).  
It is expected that the amount of colors per palette ([Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName)) is the same every time.

**Arguments:**
- `btn` (Panel) — The button to save the color of.
- `clr` (Color) — The color to save to this button's index

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SaveColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L210-L222)

---

### DColorPalette:SetButtonSize · Client, Menu
`DColorPalette:SetButtonSize(size: number)`

Sets the size of each palette button.

This is best kept to such a number, where this equation would return a whole number:
`WidthOfColorPalette / ButtonSize= WholeNumber`

If not, there will be ugly whitespace on the right side of the panel.

**Arguments:**
- `size` (number) — Sets the new size

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetButtonSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L181-L191)

---

### DColorPalette:SetColor · Client, Menu · `DEPRECATED`
`DColorPalette:SetColor(clr: Color)`

Currently does nothing. Intended to "select" the color.

**Arguments:**
- `clr` (Color)

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L224-L226)

---

### DColorPalette:SetColorButtons · Client, Menu
`DColorPalette:SetColorButtons(tab: table)`

Clears the palette and adds new buttons with given colors.

**Arguments:**
- `tab` (table) — A number indexed table where each value is a Color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetColorButtons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L164-L179)

---

### DColorPalette:SetConVarA · Client, Menu
`DColorPalette:SetConVarA(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the alpha channel of the color.

See also:
* [DColorPalette:SetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarR) - For the red channel
* [DColorPalette:SetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarG) - For the green channel
* [DColorPalette:SetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarB) - For the blue channel

**Arguments:**
- `convar` (string) — The ConVar name for the alpha channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarA) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L9)

---

### DColorPalette:SetConVarB · Client, Menu
`DColorPalette:SetConVarB(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the blue channel of the color.

See also:
* [DColorPalette:SetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarR) - For the red channel
* [DColorPalette:SetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarG) - For the green channel
* [DColorPalette:SetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the blue channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L8)

---

### DColorPalette:SetConVarG · Client, Menu
`DColorPalette:SetConVarG(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the green channel of the color.

See also:
* [DColorPalette:SetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarR) - For the red channel
* [DColorPalette:SetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarB) - For the blue channel
* [DColorPalette:SetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the green channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarG) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L7)

---

### DColorPalette:SetConVarR · Client, Menu
`DColorPalette:SetConVarR(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the red channel of the color.

See also:
* [DColorPalette:SetConVarG](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarG) - For the green channel
* [DColorPalette:SetConVarB](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarB) - For the blue channel
* [DColorPalette:SetConVarA](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the red channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarR) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L6)

---

### DColorPalette:SetNumRows · Client, Menu
`DColorPalette:SetNumRows(rows: number)`

Roughly sets the number of colors that can be picked by the user. If the DColorPalette is exactly 6 rows tall, this function will set the number of colors shown per row in the palette. This is an [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `rows` (number) — Scale for the range of colors that the user can pick.

> **Note:** [DColorPalette:Reset](https://wiki.facepunch.com/gmod/DColorPalette:Reset) or [DColorPalette:ResetSavedColors](https://wiki.facepunch.com/gmod/DColorPalette:ResetSavedColors) must be called after this function to apply changes.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:SetNumRows) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L189-L189)

---

### DColorPalette:UpdateConVar · Client, Menu · `INTERNAL`
`DColorPalette:UpdateConVar(name: string, key: string, clr: Color)`

Internal helper function for [DColorPalette:UpdateConVars](https://wiki.facepunch.com/gmod/DColorPalette:UpdateConVars).

**Arguments:**
- `name` (string) — The name of the console variable to set
- `key` (string) — The key of the 3rd argument to set the convar to Possible values: "r", "g", "b", "a"
- `clr` (Color) — The Color to retrieve the info from.

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:UpdateConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L193-L199)

---

### DColorPalette:UpdateConVars · Client, Menu · `INTERNAL`
`DColorPalette:UpdateConVars(clr: Color)`

Updates all the console variables set by [DColorPalette:SetConVarR](https://wiki.facepunch.com/gmod/DColorPalette:SetConVarR) and so on with given color.

Called internally when a palette color is clicked.

**Arguments:**
- `clr` (Color) — A Color

[wiki](https://wiki.facepunch.com/gmod/DColorPalette:UpdateConVars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolorpalette.lua#L201-L208)
