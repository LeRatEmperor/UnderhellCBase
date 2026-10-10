# DProperty_Combo

**Realm:** Client  ·  **Members:** 4  ·  **Inherits:** `DProperty_Generic`  ·  `INTERNAL`

[DComboBox](https://wiki.facepunch.com/gmod/DComboBox) control for a [DProperties](https://wiki.facepunch.com/gmod/DProperties) panel.

[wiki page](https://wiki.facepunch.com/gmod/DProperty_Combo)

### DProperty_Combo:AddChoice · Client
`DProperty_Combo:AddChoice(Text: string, data: any, select: boolean = false)`

Add a choice to your combo control.

**Arguments:**
- `Text` (string) — Shown text.
- `data` (any) — Stored Data.
- `select` (boolean, default `false`) — Select this element?

[wiki](https://wiki.facepunch.com/gmod/DProperty_Combo:AddChoice)

---

### DProperty_Combo:DataChanged · Client
`DProperty_Combo:DataChanged(data: any)`

Called after the user selects a new value.

**Arguments:**
- `data` (any) — The new data that was selected.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Combo:DataChanged)

---

### DProperty_Combo:SetSelected · Client
`DProperty_Combo:SetSelected(Id: number)`

Set the selected option.

**Arguments:**
- `Id` (number) — Id of the choice to be selected.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Combo:SetSelected)

---

### DProperty_Combo:Setup · Client · `INTERNAL`
`DProperty_Combo:Setup(data: table = { text = 'Select...' })`

Sets up a combo control.

**Arguments:**
- `data` (table, default `{ text = 'Select...' }`) — Data to use to set up the combo box control.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Combo:Setup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/prop_combo.lua#L7-L62)
