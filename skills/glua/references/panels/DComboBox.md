# DComboBox

**Realm:** Client, Menu  ·  **Members:** 20  ·  **Inherits:** `DButton`

A field with multiple selectable values.

[wiki page](https://wiki.facepunch.com/gmod/DComboBox)

### DComboBox:AddChoice · Client, Menu
`DComboBox:AddChoice(value: string, data: any = nil, select: boolean = false, icon: string = nil) → number`

Adds a choice to the combo box.

**Arguments:**
- `value` (string) — The text show to the user.
- `data` (any, default `nil`) — The data accompanying this string.
- `select` (boolean, default `false`) — Should this be the default selected text show to the user or not.
- `icon` (string, default `nil`) — Adds an icon for this choice.

**Returns:**
- number — The index of the new option.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:AddChoice) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L129-L149)

---

### DComboBox:AddSpacer · Client, Menu
`DComboBox:AddSpacer()`

Adds a spacer below the currently last item in the drop down. Recommended to use with [DComboBox:SetSortItems](https://wiki.facepunch.com/gmod/DComboBox:SetSortItems) set to `false`.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:AddSpacer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L132-L136)

---

### DComboBox:CheckConVarChanges · Client, Menu · `INTERNAL`
`DComboBox:CheckConVarChanges()`

Ran every frame to update the value of this panel to the value of the associated convar. See [Panel:SetConvar](https://wiki.facepunch.com/gmod/Panel:SetConvar).

[wiki](https://wiki.facepunch.com/gmod/DComboBox:CheckConVarChanges) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L213-L224)

---

### DComboBox:ChooseOption · Client, Menu
`DComboBox:ChooseOption(value: string, index: number)`

Selects a combo box option by its index and changes the text displayed at the top of the combo box.

**Arguments:**
- `value` (string) — The text to display at the top of the combo box.
- `index` (number) — The option index.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:ChooseOption) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L85-L100)

---

### DComboBox:ChooseOptionID · Client, Menu
`DComboBox:ChooseOptionID(index: number)`

Selects an option within a combo box based on its table index.

**Arguments:**
- `index` (number) — Selects the option with given index.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:ChooseOptionID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L102-L107)

---

### DComboBox:Clear · Client, Menu
`DComboBox:Clear()`

Clears the combo box's text value, choices, and data values.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L27-L40)

---

### DComboBox:CloseMenu · Client, Menu
`DComboBox:CloseMenu()`

Closes the combo box menu. Called when the combo box is clicked while open.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:CloseMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L204-L210)

---

### DComboBox:GetOptionData · Client, Menu
`DComboBox:GetOptionData(index: number) → any`

Returns an option's data based on the given index.

**Arguments:**
- `index` (number) — The option index.

**Returns:**
- any — The option's data value.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetOptionData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L48-L52)

---

### DComboBox:GetOptionText · Client, Menu
`DComboBox:GetOptionText(index: number) → string`

Returns an option's text based on the given index.

**Arguments:**
- `index` (number) — The option index.

**Returns:**
- string — The option's text value.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetOptionText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L42-L46)

---

### DComboBox:GetOptionTextByData · Client, Menu
`DComboBox:GetOptionTextByData(data: string) → string`

Returns an option's text based on the given data.

**Arguments:**
- `data` (string) — The data to look up the name of.

**Returns:**
- string — The option's text value.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetOptionTextByData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L54-L72)

---

### DComboBox:GetSelected · Client, Menu
`DComboBox:GetSelected() → string, any`

Returns the currently selected option's text and data

**Returns:**
- string — The option's text value.
- any — The option's stored data.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L115-L121)

---

### DComboBox:GetSelectedID · Client, Menu
`DComboBox:GetSelectedID() → number`

Returns the index (ID) of the currently selected option.

**Returns:**
- number — The ID of the currently selected option.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetSelectedID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L109-L113)

---

### DComboBox:GetSortItems · Client, Menu
`DComboBox:GetSortItems() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns an whether the items in the dropdown will be alphabetically sorted or not.

See [DComboBox:SetSortItems](https://wiki.facepunch.com/gmod/DComboBox:SetSortItems).

**Returns:**
- boolean — True if enabled, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:GetSortItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L8)

---

### DComboBox:IsMenuOpen · Client, Menu
`DComboBox:IsMenuOpen() → boolean`

Returns whether or not the combo box's menu is opened.

**Returns:**
- boolean — True if the menu is open, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:IsMenuOpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L151-L155)

---

### DComboBox:OnMenuOpened · Client, Menu · `hook`
`DComboBox:OnMenuOpened(menu: Panel)`

Called when the player opens the dropdown menu. For Override

**Arguments:**
- `menu` (Panel) — The DMenu menu panel.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:OnMenuOpened) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L126-L130)

---

### DComboBox:OnSelect · Client, Menu · `hook`
`DComboBox:OnSelect(index: number, value: string, data: any)`

Called when an option in the combo box is selected. This function does nothing by itself, you're supposed to overwrite it.

**Arguments:**
- `index` (number) — The index of the option for use with other DComboBox functions.
- `value` (string) — The name of the option.
- `data` (any) — The data assigned to the option.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:OnSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L120-L124)

---

### DComboBox:OpenMenu · Client, Menu
`DComboBox:OpenMenu()`

Opens the combo box drop down menu. Called when the combo box is clicked.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:OpenMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L157-L202)

---

### DComboBox:RemoveChoice · Client, Menu
`DComboBox:RemoveChoice(index: number) → string, any`

Removes a choice added with [DComboBox:AddChoice](https://wiki.facepunch.com/gmod/DComboBox:AddChoice)

**Arguments:**
- `index` (number) — The index of the option to remove.

**Returns:**
- `text` (string) — The text of the removed option.
- `data` (any) — The data of the removed option that was provided.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:RemoveChoice) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L160-L168)

---

### DComboBox:SetSortItems · Client, Menu
`DComboBox:SetSortItems(sort: boolean)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets whether or not the items should be sorted alphabetically in the dropdown menu of the [DComboBox](https://wiki.facepunch.com/gmod/DComboBox). If set to false, items will appear in the order they were added by [DComboBox:AddChoice](https://wiki.facepunch.com/gmod/DComboBox:AddChoice) calls.

This is enabled by default.

**Arguments:**
- `sort` (boolean) — true to enable, false to disable

[wiki](https://wiki.facepunch.com/gmod/DComboBox:SetSortItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DComboBox:SetValue · Client, Menu
`DComboBox:SetValue(value: string)`

Sets the text shown in the combo box when the menu is not collapsed.

**Arguments:**
- `value` (string) — The text in the DComboBox.

[wiki](https://wiki.facepunch.com/gmod/DComboBox:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcombobox.lua#L232-L236)
