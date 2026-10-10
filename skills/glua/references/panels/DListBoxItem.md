# DListBoxItem

**Realm:** Client  ·  **Members:** 3  ·  **Inherits:** `DLabel`  ·  `DEPRECATED`

[wiki page](https://wiki.facepunch.com/gmod/DListBoxItem)

### DListBoxItem:GetMother · Client · `DEPRECATED`
`DListBoxItem:GetMother() → Panel`

Returns the parent "mother" of this **DListBoxItem** set by [DListBoxItem:SetMother](https://wiki.facepunch.com/gmod/DListBoxItem:SetMother).

**Returns:**
- Panel — The "mother" DListBox.

[wiki](https://wiki.facepunch.com/gmod/DListBoxItem:GetMother)

---

### DListBoxItem:Select · Client · `DEPRECATED`
`DListBoxItem:Select(onlyMe: boolean)`

Selects this item.

**Arguments:**
- `onlyMe` (boolean) — Whether to deselect other items.

[wiki](https://wiki.facepunch.com/gmod/DListBoxItem:Select) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistbox.lua#L40-L46)

---

### DListBoxItem:SetMother · Client · `DEPRECATED` · `INTERNAL`
`DListBoxItem:SetMother(parent: Panel)`

Sets the "mother" (parent) panel for this item. Done internally by [DListBox:AddItem](https://wiki.facepunch.com/gmod/DListBox:AddItem)

**Arguments:**
- `parent` (Panel) — The "mother" panel to set.

[wiki](https://wiki.facepunch.com/gmod/DListBoxItem:SetMother)
