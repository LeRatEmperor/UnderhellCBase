# DListBox

**Realm:** Client, Menu  ·  **Members:** 7  ·  **Inherits:** `DPanelList`  ·  `DEPRECATED`

A simple list box with optional multi-select.  
		As this is deprecated, it is recommended that you use [DListView](https://wiki.facepunch.com/gmod/DListView), which contains the same functionality with multi-column options.

[wiki page](https://wiki.facepunch.com/gmod/DListBox)

### DListBox:GetMultiple · Client, Menu · `DEPRECATED`
`DListBox:GetMultiple() → boolean`

Returns whether the list box can select multiple items.

**Returns:**
- `multiple` (boolean) — Whether the list box can select multiple items.

[wiki](https://wiki.facepunch.com/gmod/DListBox:GetMultiple)

---

### DListBox:GetSelectedItems · Client, Menu · `DEPRECATED`
`DListBox:GetSelectedItems() → table`

Returns selected items.

**Returns:**
- table — The selected items.

[wiki](https://wiki.facepunch.com/gmod/DListBox:GetSelectedItems)

---

### DListBox:GetSelectedValues · Client, Menu · `DEPRECATED`
`DListBox:GetSelectedValues() → table`

Returns selected item values.

**Returns:**
- table — The selected item values.

[wiki](https://wiki.facepunch.com/gmod/DListBox:GetSelectedValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistbox.lua#L162-L178)

---

### DListBox:SelectByName · Client, Menu · `DEPRECATED`
`DListBox:SelectByName(val: string)`

Select a [DListBoxItem](https://wiki.facepunch.com/gmod/DListBoxItem) based on its value.

**Arguments:**
- `val` (string) — Panel:GetValue of a DListBoxItem to select.

[wiki](https://wiki.facepunch.com/gmod/DListBox:SelectByName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistbox.lua#L150-L160)

---

### DListBox:SelectItem · Client, Menu · `DEPRECATED` · `INTERNAL`
`DListBox:SelectItem(item: Panel, onlyme: boolean)`

Used internally to select a specific panel.

**Arguments:**
- `item` (Panel) — DListBox to select.
- `onlyme` (boolean) — Whether to deselect other selected items.

[wiki](https://wiki.facepunch.com/gmod/DListBox:SelectItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistbox.lua#L126-L148)

---

### DListBox:SetMultiple · Client, Menu · `DEPRECATED`
`DListBox:SetMultiple(multiple: boolean)`

Sets whether the list box can select multiple items.

**Arguments:**
- `multiple` (boolean) — Whether the list box can select multiple items.

[wiki](https://wiki.facepunch.com/gmod/DListBox:SetMultiple) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DListBox:SetSelectedItems · Client, Menu · `DEPRECATED` · `INTERNAL`
`DListBox:SetSelectedItems(items: table)`

Sets selected items.

**Arguments:**
- `items` (table) — The items to select.

[wiki](https://wiki.facepunch.com/gmod/DListBox:SetSelectedItems)
