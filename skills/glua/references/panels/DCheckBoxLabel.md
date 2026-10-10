# DCheckBoxLabel

**Realm:** Client, Menu  ·  **Members:** 13  ·  **Inherits:** `DPanel`

The **DCheckBoxLabel** is a [DCheckBox](https://wiki.facepunch.com/gmod/DCheckBox) with a [DLabel](https://wiki.facepunch.com/gmod/DLabel) next to it. 
		It allows you to get a boolean value from the user (true/false - yes/no)

[wiki page](https://wiki.facepunch.com/gmod/DCheckBoxLabel)

### DCheckBoxLabel:GetChecked · Client, Menu
`DCheckBoxLabel:GetChecked() → boolean`

Gets the checked state of the checkbox. This calls the checkbox's [DCheckBox:GetChecked](https://wiki.facepunch.com/gmod/DCheckBox:GetChecked) function.

**Returns:**
- boolean — Whether the box is checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:GetChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L111-L113)

---

### DCheckBoxLabel:GetIndent · Client, Menu
`DCheckBoxLabel:GetIndent() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that gets the indentation of the element on the X axis. See also [DCheckBoxLabel:SetIndent](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetIndent)

**Returns:**
- number — How much the content is moved to the right in pixels

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:GetIndent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L81)

---

### DCheckBoxLabel:OnChange · Client, Menu · `hook`
`DCheckBoxLabel:OnChange(bVal: boolean)`

Called when the "checked" state is changed. This is meant to be Overriden

**Arguments:**
- `bVal` (boolean) — Whether the checkbox is checked or unchecked.

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:OnChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L179-L183)

---

### DCheckBoxLabel:SetBright · Client, Menu
`DCheckBoxLabel:SetBright(bright: boolean)`

Sets the color of the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel)'s text to the bright text color defined in the skin.

**Arguments:**
- `bright` (boolean) — true makes the text bright.

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetBright) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L95-L97)

---

### DCheckBoxLabel:SetChecked · Client, Menu
`DCheckBoxLabel:SetChecked(checked: boolean)`

Sets the checked state of the checkbox. Does not call [DCheckBoxLabel:OnChange](https://wiki.facepunch.com/gmod/DCheckBoxLabel:OnChange) or [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged), unlike [DCheckBoxLabel:SetValue](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetValue).

**Arguments:**
- `checked` (boolean) — Whether the box should be checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L107-L109)

---

### DCheckBoxLabel:SetConVar · Client, Menu
`DCheckBoxLabel:SetConVar(convar: string)`

Sets the console variable to be set when the checked state of the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel) changes.

**Arguments:**
- `convar` (string) — The name of the convar to set

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L99-L101)

---

### DCheckBoxLabel:SetDark · Client, Menu
`DCheckBoxLabel:SetDark(darkify: boolean)`

Sets the text of the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel) to be dark colored in accordance with the currently active Derma skin.

**Arguments:**
- `darkify` (boolean) — True to be dark, false to be default

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetDark) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L91-L93)

---

### DCheckBoxLabel:SetFont · Client, Menu
`DCheckBoxLabel:SetFont(font: string)`

Sets the font of the text part of the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel).

**Arguments:**
- `font` (string) — Font name

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetFont) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L153-L158)

---

### DCheckBoxLabel:SetIndent · Client, Menu
`DCheckBoxLabel:SetIndent(ident: number)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the indentation of the element on the X axis.

**Arguments:**
- `ident` (number) — How much in pixels to move the content to the right

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetIndent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L81)

---

### DCheckBoxLabel:SetTextColor · Client, Menu
`DCheckBoxLabel:SetTextColor(color: Color)`

Sets the text color for the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel).

**Arguments:**
- `color` (Color) — The text color.

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetTextColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L131-L135)

---

### DCheckBoxLabel:SetValue · Client, Menu
`DCheckBoxLabel:SetValue(checked: boolean)`

Sets the checked state of the checkbox, and calls [DCheckBoxLabel:OnChange](https://wiki.facepunch.com/gmod/DCheckBoxLabel:OnChange) and the checkbox's [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) methods.

**Arguments:**
- `checked` (boolean) — Whether the box should be checked or not (1 or 0 can also be used).

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L103-L105)

---

### DCheckBoxLabel:SizeToContents · Client, Menu
`DCheckBoxLabel:SizeToContents()`

Sizes the panel to the size of the internal DLabel and DButton

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:SizeToContents) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L137-L144)

---

### DCheckBoxLabel:Toggle · Client, Menu
`DCheckBoxLabel:Toggle()`

Toggles the checked state of the [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel).

[wiki](https://wiki.facepunch.com/gmod/DCheckBoxLabel:Toggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L115-L117)
