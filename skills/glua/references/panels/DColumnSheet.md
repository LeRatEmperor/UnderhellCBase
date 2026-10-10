# DColumnSheet

**Realm:** Client, Menu  ·  **Members:** 4  ·  **Inherits:** `Panel`

Similar to [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet), but with tabs on the left.

[wiki page](https://wiki.facepunch.com/gmod/DColumnSheet)

### DColumnSheet:AddSheet · Client, Menu
`DColumnSheet:AddSheet(name: string, pnl: Panel, icon: string = nil) → table`

Adds a new column/tab.

**Arguments:**
- `name` (string) — Name of the column/tab
- `pnl` (Panel) — Panel to be used as contents of the tab.
- `icon` (string, default `nil`) — Icon for the tab.

**Returns:**
- table — A table containing the following keys: * DButton / DImageButton Button - The created tab button that will switch to the given panel.

[wiki](https://wiki.facepunch.com/gmod/DColumnSheet:AddSheet) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolumnsheet.lua#L24-L62)

---

### DColumnSheet:GetActiveButton · Client, Menu
`DColumnSheet:GetActiveButton() → Panel`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the active button of this [DColumnSheet](https://wiki.facepunch.com/gmod/DColumnSheet).

**Returns:**
- Panel — The active button

[wiki](https://wiki.facepunch.com/gmod/DColumnSheet:GetActiveButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolumnsheet.lua#L4)

---

### DColumnSheet:SetActiveButton · Client, Menu · `INTERNAL`
`DColumnSheet:SetActiveButton(active: Panel)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that makes a button an active button for this [DColumnSheet](https://wiki.facepunch.com/gmod/DColumnSheet).

**Arguments:**
- `active` (Panel) — The button to make active button

[wiki](https://wiki.facepunch.com/gmod/DColumnSheet:SetActiveButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolumnsheet.lua#L64-L83)

---

### DColumnSheet:UseButtonOnlyStyle · Client, Menu
`DColumnSheet:UseButtonOnlyStyle()`

Makes the tabs/buttons show only the image and no text.

[wiki](https://wiki.facepunch.com/gmod/DColumnSheet:UseButtonOnlyStyle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolumnsheet.lua#L20-L22)
