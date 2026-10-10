# DGrid

**Realm:** Client, Menu  ·  **Members:** 10  ·  **Inherits:** `Panel`

A really simple grid layout panel.

> **Note:** This panel will set its size automatically based on set column count. 
> 		This makes it play badly with [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock) and cause a [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) call every frame.

[wiki page](https://wiki.facepunch.com/gmod/DGrid)

### DGrid:AddItem · Client, Menu
`DGrid:AddItem(item: Panel)`

Adds a new item to the grid.

**Arguments:**
- `item` (Panel) — The item to add.

[wiki](https://wiki.facepunch.com/gmod/DGrid:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dgrid.lua#L28-L39)

---

### DGrid:GetCols · Client, Menu
`DGrid:GetCols() → number`

Returns the number of columns of this [DGrid](https://wiki.facepunch.com/gmod/DGrid). Set by [DGrid:SetCols](https://wiki.facepunch.com/gmod/DGrid:SetCols).

**Returns:**
- number — The number of columns of this DGrid

[wiki](https://wiki.facepunch.com/gmod/DGrid:GetCols)

---

### DGrid:GetColWide · Client, Menu
`DGrid:GetColWide() → number`

Returns the width of each column of the [DGrid](https://wiki.facepunch.com/gmod/DGrid), which is set by [DGrid:SetColWide](https://wiki.facepunch.com/gmod/DGrid:SetColWide).

**Returns:**
- number — The width of each column

[wiki](https://wiki.facepunch.com/gmod/DGrid:GetColWide)

---

### DGrid:GetItems · Client, Menu
`DGrid:GetItems() → table`

Returns a list of panels in the grid.

**Returns:**
- table — A list of Panels.

[wiki](https://wiki.facepunch.com/gmod/DGrid:GetItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dgrid.lua#L20-L26)

---

### DGrid:GetRowHeight · Client, Menu
`DGrid:GetRowHeight() → number`

Returns the height of each row of the [DGrid](https://wiki.facepunch.com/gmod/DGrid), which is set by [DGrid:SetRowHeight](https://wiki.facepunch.com/gmod/DGrid:SetRowHeight).

**Returns:**
- number — The height of each row

[wiki](https://wiki.facepunch.com/gmod/DGrid:GetRowHeight)

---

### DGrid:RemoveItem · Client, Menu
`DGrid:RemoveItem(item: Panel, bDontDelete: boolean = false)`

Removes given panel from the [DGrid:GetItems](https://wiki.facepunch.com/gmod/DGrid:GetItems).

**Arguments:**
- `item` (Panel) — Item to remove from the grid
- `bDontDelete` (boolean, default `false`) — If set to true, the actual panel will not be removed via Panel:Remove.

[wiki](https://wiki.facepunch.com/gmod/DGrid:RemoveItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dgrid.lua#L41-L59)

---

### DGrid:SetCols · Client, Menu
`DGrid:SetCols(cols: number)`

Sets the number of columns this panel should have.

The [DGrid](https://wiki.facepunch.com/gmod/DGrid) will resize its width to match this value.

**Arguments:**
- `cols` (number) — The desired number of columns

[wiki](https://wiki.facepunch.com/gmod/DGrid:SetCols)

---

### DGrid:SetColWide · Client, Menu
`DGrid:SetColWide(colWidth: number)`

Sets the width of each column.

The cell panels (grid items) will not be resized or centered.

**Arguments:**
- `colWidth` (number) — The width of each column.

[wiki](https://wiki.facepunch.com/gmod/DGrid:SetColWide)

---

### DGrid:SetRowHeight · Client, Menu
`DGrid:SetRowHeight(rowHeight: number)`

Sets the height of each row. 

The cell panels (grid items) will not be resized or centered.

**Arguments:**
- `rowHeight` (number) — The height of each row

[wiki](https://wiki.facepunch.com/gmod/DGrid:SetRowHeight)

---

### DGrid:SortByMember · Client, Menu
`DGrid:SortByMember(key: string, desc: boolean = true)`

Sorts the items in the grid. Does not visually update the grid, use [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) for that.

**Arguments:**
- `key` (string) — A key in the panel from DGrid:GetItems.
- `desc` (boolean, default `true`) — True for descending order, false for ascending.

[wiki](https://wiki.facepunch.com/gmod/DGrid:SortByMember) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dgrid.lua#L82-L107)
