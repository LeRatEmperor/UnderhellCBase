# DListView_Line

**Realm:** Client, Menu  ·  **Members:** 17  ·  **Inherits:** `Panel`  ·  `INTERNAL`

A panel used by [DListView](https://wiki.facepunch.com/gmod/DListView)

[wiki page](https://wiki.facepunch.com/gmod/DListView_Line)

### DListView_Line:DataLayout · Client, Menu · `INTERNAL`
`DListView_Line:DataLayout(pnl: DListView)`

Called by [DListView:DataLayout](https://wiki.facepunch.com/gmod/DListView:DataLayout)

**Arguments:**
- `pnl` (DListView) — The list view.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:DataLayout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L166-L182)

---

### DListView_Line:GetAltLine · Client, Menu
`DListView_Line:GetAltLine() → boolean`

Returns whether this line is odd or even in the list. This is internally used (and set) to change the looks of every other line.

**Returns:**
- `alt` (boolean) — Whether this line is 'alternative'.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetAltLine)

---

### DListView_Line:GetColumnText · Client, Menu
`DListView_Line:GetColumnText(column: number) → string`

Gets the string held in the specified column of a [DListView_Line](https://wiki.facepunch.com/gmod/DListView_Line) panel.

This is the same thing as doing [DListView_Line:GetValue](https://wiki.facepunch.com/gmod/Panel:GetValue)( column_number ).

**Arguments:**
- `column` (number) — The number of the column to retrieve the text from, starts with 1.

**Returns:**
- string — The contents of the specified column.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetColumnText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L138-L144)

---

### DListView_Line:GetID · Client, Menu
`DListView_Line:GetID() → number`

Returns the ID of this line, set automatically in [DListView:AddLine](https://wiki.facepunch.com/gmod/DListView:AddLine).

**Returns:**
- number — The ID of this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetID)

---

### DListView_Line:GetListView · Client, Menu
`DListView_Line:GetListView() → DListView`

Returns the parent [DListView](https://wiki.facepunch.com/gmod/DListView) of this line.

**Returns:**
- `pnl` (DListView) — The parent DListView of this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetListView)

---

### DListView_Line:GetSortValue · Client, Menu
`DListView_Line:GetSortValue(column: number) → any`

Returns the data stored on given cell of this line.

	Used in the [DListView:SortByColumn](https://wiki.facepunch.com/gmod/DListView:SortByColumn) function in case you want to sort with something else than the text.

**Arguments:**
- `column` (number) — The number of the column to write the text from, starts with 1.

**Returns:**
- `data` (any) — The data that is set for given column of this line, if any.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetSortValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L160-L164)

---

### DListView_Line:GetValue · Client, Menu
`DListView_Line:GetValue(column: number) → string`

Alias of [DListView_Line:GetColumnText](https://wiki.facepunch.com/gmod/DListView_Line:GetColumnText). Overrides [Panel:GetValue](https://wiki.facepunch.com/gmod/Panel:GetValue).

**Arguments:**
- `column` (number) — The number of the column to retrieve the text from, starts with 1.

**Returns:**
- string — The contents of the specified column.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:GetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L138-L144)

---

### DListView_Line:IsLineSelected · Client, Menu
`DListView_Line:IsLineSelected() → boolean`

Returns whether this line is selected.

**Returns:**
- `selected` (boolean) — Whether this line is selected.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:IsLineSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L105-L109)

---

### DListView_Line:OnRightClick · Client, Menu · `hook`
`DListView_Line:OnRightClick()`

Called when the player right clicks this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:OnRightClick)

---

### DListView_Line:OnSelect · Client, Menu · `hook`
`DListView_Line:OnSelect()`

Called when the player selects this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:OnSelect)

---

### DListView_Line:SetAltLine · Client, Menu · `INTERNAL`
`DListView_Line:SetAltLine(alt: boolean)`

Sets whether this line is odd or even in the list. This is internally used (and set automatically) to change the looks of every other line.

**Arguments:**
- `alt` (boolean) — Whether this line is 'alternative'.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetAltLine)

---

### DListView_Line:SetColumnText · Client, Menu
`DListView_Line:SetColumnText(column: number, value: string) → DLabel`

Sets the string held in the specified column of a [DListView_Line](https://wiki.facepunch.com/gmod/DListView_Line) panel.

**Arguments:**
- `column` (number) — The number of the column to write the text from, starts with 1.
- `value` (string) — Column text you want to set

**Returns:**
- `label` (DLabel) — The DLabel in which the text was set.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetColumnText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L111-L135)

---

### DListView_Line:SetID · Client, Menu · `INTERNAL`
`DListView_Line:SetID(id: number)`

Sets the ID of this line, used internally by [DListView:AddLine](https://wiki.facepunch.com/gmod/DListView:AddLine).

**Arguments:**
- `id` (number) — The ID for this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetID)

---

### DListView_Line:SetListView · Client, Menu · `INTERNAL`
`DListView_Line:SetListView(pnl: DListView)`

Sets the parent [DListView](https://wiki.facepunch.com/gmod/DListView) for this line. Used internally by [DListView:AddLine](https://wiki.facepunch.com/gmod/DListView:AddLine).

**Arguments:**
- `pnl` (DListView) — The new parent DListView for this line.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetListView)

---

### DListView_Line:SetSelected · Client, Menu
`DListView_Line:SetSelected(selected: boolean)`

Sets whether this line is selected or not.

**Arguments:**
- `selected` (boolean) — Whether this line is selected.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L94-L103)

---

### DListView_Line:SetSortValue · Client, Menu
`DListView_Line:SetSortValue(column: number, data: any)`

Allows you to store data per column.

	Used in the [DListView:SortByColumn](https://wiki.facepunch.com/gmod/DListView:SortByColumn) function in case you want to sort with something else than the text.

**Arguments:**
- `column` (number) — The number of the column to write the text from, starts with 1.
- `data` (any) — Data for given column on the line you wish to set.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetSortValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L154-L158)

---

### DListView_Line:SetValue · Client, Menu
`DListView_Line:SetValue(column: number, value: string) → DLabel`

Alias of [DListView_Line:SetColumnText](https://wiki.facepunch.com/gmod/DListView_Line:SetColumnText).

**Arguments:**
- `column` (number) — The number of the column to write the text from, starts with 1.
- `value` (string) — Column text you want to set

**Returns:**
- `label` (DLabel) — The DLabel in which the text was set.

[wiki](https://wiki.facepunch.com/gmod/DListView_Line:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_line.lua#L111-L135)
