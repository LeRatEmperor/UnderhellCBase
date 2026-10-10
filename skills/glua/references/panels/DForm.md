# DForm

**Realm:** Client, Menu  ·  **Members:** 18  ·  **Inherits:** `DCollapsibleCategory`

An easy form with functions to quickly add form elements

[wiki page](https://wiki.facepunch.com/gmod/DForm)

### DForm:AddItem · Client, Menu
`DForm:AddItem(left: Panel, right: Panel = nil)`

Adds one or two items to the DForm.
If this method is called with only one argument, it is added to the bottom of the form. If two arguments are passed, they are placed side-by-side at the bottom of the form.

Internally, this function is used by the various DForm functions to, for example, add labels to the left of buttons.

**Arguments:**
- `left` (Panel) — Left-hand element to add to the DForm.
- `right` (Panel, default `nil`) — Right-hand element to add to the DForm.

[wiki](https://wiki.facepunch.com/gmod/DForm:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L42-L73)

---

### DForm:Button · Client, Menu
`DForm:Button(text: string, concommand: string, args: vararg = nil) → DButton`

Adds a [DButton](https://wiki.facepunch.com/gmod/DButton) onto the [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `text` (string) — The text on the button
- `concommand` (string) — The concommand to run when the button is clicked
- `args` (vararg, default `nil`) — The arguments to pass on to the concommand when the button is clicked

**Returns:**
- DButton — The created DButton

[wiki](https://wiki.facepunch.com/gmod/DForm:Button) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L211-L224)

---

### DForm:CheckBox · Client, Menu
`DForm:CheckBox(label: string, convar: string) → DCheckBoxLabel`

Adds a [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel) onto the [DForm](https://wiki.facepunch.com/gmod/DForm).

**Arguments:**
- `label` (string) — The label to be set next to the check box
- `convar` (string) — The console variable to change when this is changed

**Returns:**
- DCheckBoxLabel — The created DCheckBoxLabel

> **Note:** This will run [DCheckBoxLabel:OnChange](https://wiki.facepunch.com/gmod/DCheckBoxLabel:OnChange) when being added. This is caused by [Panel:SetConVar](https://wiki.facepunch.com/gmod/Panel:SetConVar) being used when this function is used. To avoid this, use [DForm:AddItem](https://wiki.facepunch.com/gmod/DForm:AddItem) with a [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel).

[wiki](https://wiki.facepunch.com/gmod/DForm:CheckBox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L149-L160)

---

### DForm:ComboBox · Client, Menu
`DForm:ComboBox(title: string, convar: string) → DComboBox, DLabel`

Adds a [DComboBox](https://wiki.facepunch.com/gmod/DComboBox) onto the [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `title` (string) — Text to the left of the combo box
- `convar` (string) — Console variable to change when the user selects something from the dropdown.

**Returns:**
- DComboBox — The created DComboBox
- DLabel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/DForm:ComboBox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L91-L109)

---

### DForm:ControlHelp · Client, Menu
`DForm:ControlHelp(help: string) → DLabel`

Adds a [DLabel](https://wiki.facepunch.com/gmod/DLabel) onto the [DForm](https://wiki.facepunch.com/gmod/DForm). Unlike [DForm:Help](https://wiki.facepunch.com/gmod/DForm:Help), this is indented and is colored blue, depending on the derma skin.

**Arguments:**
- `help` (string) — The help message to be displayed.

**Returns:**
- DLabel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/DForm:ControlHelp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L182-L204)

---

### DForm:GetAutoSize · Client, Menu · `DEPRECATED`
`DForm:GetAutoSize() → boolean`

An Accessor Function in DForm that does nothing.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DForm:GetAutoSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L6)

---

### DForm:GetSpacing · Client, Menu · `DEPRECATED`
`DForm:GetSpacing() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that does nothing.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DForm:GetSpacing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L7)

---

### DForm:Help · Client, Menu
`DForm:Help(help: string) → DLabel`

Adds a [DLabel](https://wiki.facepunch.com/gmod/DLabel) onto the [DForm](https://wiki.facepunch.com/gmod/DForm) as a helper

**Arguments:**
- `help` (string) — The help message to be displayed

**Returns:**
- DLabel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/DForm:Help) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L162-L180)

---

### DForm:ListBox · Client, Menu · `DEPRECATED`
`DForm:ListBox(label: string = nil) → DListBox, DLabel`

Adds a [DListBox](https://wiki.facepunch.com/gmod/DListBox) onto the [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `label` (string, default `nil`) — The label to set on the DListBox

**Returns:**
- DListBox — The created DListBox
- DLabel — The created DLabel if label string was specified

[wiki](https://wiki.facepunch.com/gmod/DForm:ListBox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L234-L251)

---

### DForm:NumberWang · Client, Menu
`DForm:NumberWang(label: string, convar: string, min: number, max: number, decimals: number = nil) → DNumberWang, DLabel`

Adds a [DNumberWang](https://wiki.facepunch.com/gmod/DNumberWang) onto the [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `label` (string) — The label to be placed next to the DNumberWang
- `convar` (string) — The console variable to change when the slider is changed
- `min` (number) — The minimum value of the slider
- `max` (number) — The maximum value of the slider
- `decimals` (number, default `nil`) — The number of decimals to allow in the slider (Optional)

**Returns:**
- DNumberWang — The created DNumberWang
- DLabel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/DForm:NumberWang) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L111-L129)

---

### DForm:NumSlider · Client, Menu
`DForm:NumSlider(label: string, convar: string, min: number, max: number, decimals: number = 2) → DNumSlider`

Adds a [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider) onto the [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `label` (string) — A short label for the slider.
- `convar` (string) — The console variable to change when the slider is changed
- `min` (number) — The minimum value of the slider
- `max` (number) — The maximum value of the slider
- `decimals` (number, default `2`) — The number of decimals to allow for the slider value.

**Returns:**
- DNumSlider — The created DNumSlider.

[wiki](https://wiki.facepunch.com/gmod/DForm:NumSlider) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L131-L147)

---

### DForm:PanelSelect · Client, Menu · `DEPRECATED`
`DForm:PanelSelect() → DPanelSelect`

Creates a [DPanelSelect](https://wiki.facepunch.com/gmod/DPanelSelect) and docks it to the top of the DForm.

**Returns:**
- DPanelSelect — The created DPanelSelect.

[wiki](https://wiki.facepunch.com/gmod/DForm:PanelSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L226-L232)

---

### DForm:PropSelect · Client, Menu
`DForm:PropSelect(label: string, convar: string, models: table, height: number = 2) → PropSelect`

Creates a [PropSelect](https://wiki.facepunch.com/gmod/PropSelect) panel and docks it to the top of the DForm.

**Arguments:**
- `label` (string) — The label to display above the prop select.
- `convar` (string) — The convar to set the selected model to.
- `models` (table) — A table of models to display for selection.
- `height` (number, default `2`) — The height of the prop select panel, in 64px icon increments.

**Returns:**
- PropSelect — The created PropSelect panel.

[wiki](https://wiki.facepunch.com/gmod/DForm:PropSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L91-L132)

---

### DForm:Rebuild · Client, Menu · `DEPRECATED`
`DForm:Rebuild()`

Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DForm:Rebuild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L253-L254)

---

### DForm:SetAutoSize · Client, Menu · `DEPRECATED`
`DForm:SetAutoSize(a1: boolean)`

an [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that does nothing

**Arguments:**
- `a1` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DForm:SetAutoSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DForm:SetName · Client, Menu · `DEPRECATED`
`DForm:SetName(name: string)`

Sets the title (header) name of the DForm. This is `Label` until set.

**Arguments:**
- `name` (string) — The new header name.

[wiki](https://wiki.facepunch.com/gmod/DForm:SetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L24-L28)

---

### DForm:SetSpacing · Client, Menu · `DEPRECATED`
`DForm:SetSpacing(a1: number)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that does nothing.

**Arguments:**
- `a1` (number)

[wiki](https://wiki.facepunch.com/gmod/DForm:SetSpacing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L7)

---

### DForm:TextEntry · Client, Menu
`DForm:TextEntry(label: string, convar: string) → DTextEntry, DLabel`

Adds a [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) to a [DForm](https://wiki.facepunch.com/gmod/DForm)

**Arguments:**
- `label` (string) — The label to be next to the text entry
- `convar` (string) — The console variable to be changed when the text entry is changed

**Returns:**
- DTextEntry — The created DTextEntry
- DLabel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/DForm:TextEntry) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dform.lua#L75-L89)
