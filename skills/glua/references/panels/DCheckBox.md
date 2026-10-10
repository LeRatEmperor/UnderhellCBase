# DCheckBox

**Realm:** Client, Menu  ·  **Members:** 7  ·  **Inherits:** `DButton`

The DCheckBox is a checkbox. It allows you to get a boolean value from the user (true/false - yes/no)

[wiki page](https://wiki.facepunch.com/gmod/DCheckBox)

### DCheckBox:DoClick · Client, Menu
`DCheckBox:DoClick()`

Calls [DCheckBox:Toggle](https://wiki.facepunch.com/gmod/DCheckBox:Toggle)

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:DoClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L38-L42)

---

### DCheckBox:GetChecked · Client, Menu
`DCheckBox:GetChecked() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that gets the checked state of the checkbox.

**Returns:**
- boolean — Whether the box is checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:GetChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L4)

---

### DCheckBox:IsEditing · Client, Menu
`DCheckBox:IsEditing() → boolean`

Returns whether the state of the checkbox is being edited. This means whether the user is currently clicking (mouse-down) on the checkbox, and applies to both the left and right mouse buttons.

**Returns:**
- boolean — Whether the checkbox is being clicked.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L19-L21)

---

### DCheckBox:OnChange · Client, Menu · `hook`
`DCheckBox:OnChange(bVal: boolean)`

Called when the "checked" state is changed. This is for Overriding

**Arguments:**
- `bVal` (boolean) — Whether the CheckBox is checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:OnChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L51-L55)

---

### DCheckBox:SetChecked · Client, Menu
`DCheckBox:SetChecked(checked: boolean)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the checked state of the checkbox. Does not call the checkbox's [DCheckBox:OnChange](https://wiki.facepunch.com/gmod/DCheckBox:OnChange) and [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) methods, unlike [DCheckBox:SetValue](https://wiki.facepunch.com/gmod/DCheckBox:SetValue).

**Arguments:**
- `checked` (boolean) — Whether the box should be checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:SetChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DCheckBox:SetValue · Client, Menu
`DCheckBox:SetValue(checked: boolean)`

Sets the checked state of the checkbox, and calls the checkbox's [DCheckBox:OnChange](https://wiki.facepunch.com/gmod/DCheckBox:OnChange) and [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) methods.

**Arguments:**
- `checked` (boolean) — Whether the box should be checked or not.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L23-L36)

---

### DCheckBox:Toggle · Client, Menu
`DCheckBox:Toggle()`

Toggles the checked state of the checkbox, and calls the checkbox's [DCheckBox:OnChange](https://wiki.facepunch.com/gmod/DCheckBox:OnChange) and [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) methods. [DCheckBox:DoClick](https://wiki.facepunch.com/gmod/DCheckBox:DoClick) is an alias of this function.

[wiki](https://wiki.facepunch.com/gmod/DCheckBox:Toggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcheckbox.lua#L44-L52)
