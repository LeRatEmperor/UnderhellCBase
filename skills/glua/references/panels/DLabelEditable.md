# DLabelEditable

**Realm:** Client, Menu  ·  **Members:** 4  ·  **Inherits:** `DLabel`

An editable [DLabel](https://wiki.facepunch.com/gmod/DLabel), double click on it to edit.

		This is used in the spawnmenu spawnlist headers.

[wiki page](https://wiki.facepunch.com/gmod/DLabelEditable)

### DLabelEditable:GetAutoStretch · Client
`DLabelEditable:GetAutoStretch() → boolean`

Returns whether the editable label will stretch to the text entered or not.

**Returns:**
- boolean — Whether the editable label will stretch to the text entered or not.

[wiki](https://wiki.facepunch.com/gmod/DLabelEditable:GetAutoStretch)

---

### DLabelEditable:IsEditing · Client, Menu
`DLabelEditable:IsEditing() → boolean`

Returns whether this [DLabelEditable](https://wiki.facepunch.com/gmod/DLabelEditable) is being edited or not. (i.e. has focus)

**Returns:**
- boolean — Whether this DLabelEditable is being edited or not

[wiki](https://wiki.facepunch.com/gmod/DLabelEditable:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabeleditable.lua#L74-L80)

---

### DLabelEditable:OnLabelTextChanged · Client
`DLabelEditable:OnLabelTextChanged(txt: string) → string`

A hook called when the player presses Enter (i.e. the finished editing the label) and the text has changed.

Allows you to override/modify the text that will be set to display.

**Arguments:**
- `txt` (string) — The original user input text

**Returns:**
- string — If provided, will override the text that will be applied to the label itself.

[wiki](https://wiki.facepunch.com/gmod/DLabelEditable:OnLabelTextChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabeleditable.lua#L82-L86)

---

### DLabelEditable:SetAutoStretch · Client
`DLabelEditable:SetAutoStretch(stretch: boolean)`

Sets whether the editable label should stretch to the text entered or not.

**Arguments:**
- `stretch` (boolean) — Whether the editable label should stretch to the text entered or not.

[wiki](https://wiki.facepunch.com/gmod/DLabelEditable:SetAutoStretch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)
