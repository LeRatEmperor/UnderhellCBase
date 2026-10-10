# DListView

**Realm:** Client, Menu  ·  **Members:** 36  ·  **Inherits:** `DPanel`

A data view with rows and columns.

[wiki page](https://wiki.facepunch.com/gmod/DListView)

### DListView:AddColumn · Client, Menu
`DListView:AddColumn(column: string, position: number = nil) → Panel`

Adds a column to the listview.

**Arguments:**
- `column` (string) — The name of the column to add.
- `position` (number, default `nil`) — At which position to insert the new column compared to the other columns.

**Returns:**
- Panel — The newly created DListView_Column.

[wiki](https://wiki.facepunch.com/gmod/DListView:AddColumn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L62-L94)

---

### DListView:AddLine · Client, Menu
`DListView:AddLine(text: vararg) → Panel`

Adds a line to the list view.

**Arguments:**
- `text` (vararg) — Values for a new row in the DListView, If several arguments are supplied, each argument will correspond to a respective column in the DListView.

**Returns:**
- Panel — The newly created DListView_Line.

[wiki](https://wiki.facepunch.com/gmod/DListView:AddLine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L285-L314)

---

### DListView:ClearSelection · Client, Menu
`DListView:ClearSelection()`

Clears the current selection in the DListView.

[wiki](https://wiki.facepunch.com/gmod/DListView:ClearSelection) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L324-L330)

---

### DListView:ColumnWidth · Client, Menu
`DListView:ColumnWidth(column: number) → number`

Gets the width of a column.

**Arguments:**
- `column` (number) — The column to get the width of.

**Returns:**
- number — Width of the column.

[wiki](https://wiki.facepunch.com/gmod/DListView:ColumnWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L111-L118)

---

### DListView:DataLayout · Client, Menu
`DListView:DataLayout() → number`

Creates the lines and gets the height of the contents, in a DListView.

**Returns:**
- number — The height of the contents

[wiki](https://wiki.facepunch.com/gmod/DListView:DataLayout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L264-L283)

---

### DListView:DisableScrollbar · Client, Menu
`DListView:DisableScrollbar()`

Removes the scrollbar.

[wiki](https://wiki.facepunch.com/gmod/DListView:DisableScrollbar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L40-L48)

---

### DListView:DoDoubleClick · Client, Menu · `hook`
`DListView:DoDoubleClick(lineID: number, line: Panel)`

Called when a line in the DListView is double clicked.

**Arguments:**
- `lineID` (number) — The line number of the double clicked line.
- `line` (Panel) — The double clicked DListView_Line.

[wiki](https://wiki.facepunch.com/gmod/DListView:DoDoubleClick)

---

### DListView:FixColumnsLayout · Client, Menu · `INTERNAL`
`DListView:FixColumnsLayout()`

Internal helper function called from the [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) of [DListView](https://wiki.facepunch.com/gmod/DListView).

[wiki](https://wiki.facepunch.com/gmod/DListView:FixColumnsLayout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L120-L180)

---

### DListView:GetCanvas · Client, Menu
`DListView:GetCanvas() → Panel`

Gets the canvas.

**Returns:**
- Panel — The canvas.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L58-L60)

---

### DListView:GetDataHeight · Client, Menu
`DListView:GetDataHeight() → number`

Returns the height of the data of the [DListView](https://wiki.facepunch.com/gmod/DListView).

See also [DListView:SetDataHeight](https://wiki.facepunch.com/gmod/DListView:SetDataHeight).

**Returns:**
- number — The height of the data of the DListView.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetDataHeight)

---

### DListView:GetDirty · Client, Menu · `INTERNAL`
`DListView:GetDirty() → boolean`

See [DListView:SetDirty](https://wiki.facepunch.com/gmod/DListView:SetDirty).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DListView:GetDirty)

---

### DListView:GetHeaderHeight · Client, Menu
`DListView:GetHeaderHeight() → number`

Returns the height of the header of the [DListView](https://wiki.facepunch.com/gmod/DListView).

See also [DListView:SetHeaderHeight](https://wiki.facepunch.com/gmod/DListView:SetHeaderHeight).

**Returns:**
- number — The height of the header of the DListView.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetHeaderHeight)

---

### DListView:GetHideHeaders · Client, Menu
`DListView:GetHideHeaders() → boolean`

Returns whether the header line should be visible on not.

**Returns:**
- boolean — Whether the header line should be visible on not.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetHideHeaders)

---

### DListView:GetInnerTall · Client, Menu
`DListView:GetInnerTall() → number`

Returns the height of [DListView:GetCanvas](https://wiki.facepunch.com/gmod/DListView:GetCanvas).

Intended to represent the height of all data lines.

**Returns:**
- number — The height of DListView:GetCanvas.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetInnerTall) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L54-L56)

---

### DListView:GetLine · Client, Menu
`DListView:GetLine(id: number) → Panel`

Gets the [DListView_Line](https://wiki.facepunch.com/gmod/DListView_Line) at the given index.

**Arguments:**
- `id` (number) — The index of the line to get.

**Returns:**
- Panel — The DListView_Line at the given index.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetLine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L340-L344)

---

### DListView:GetLines · Client, Menu
`DListView:GetLines() → table`

Gets all of the lines added to the DListView.

**Returns:**
- table — The lines added to the DListView.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetLines) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L50-L52)

---

### DListView:GetMultiSelect · Client, Menu
`DListView:GetMultiSelect() → boolean`

Returns whether multiple lines can be selected or not.

See [DListView:SetMultiSelect](https://wiki.facepunch.com/gmod/DListView:SetMultiSelect).

**Returns:**
- boolean — Whether multiple lines can be selected or not.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetMultiSelect)

---

### DListView:GetSelected · Client, Menu
`DListView:GetSelected() → table`

Gets all of the lines that are currently selected.

**Returns:**
- table — A table of DListView_Lines.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L539-L551)

---

### DListView:GetSelectedLine · Client, Menu
`DListView:GetSelectedLine() → number, Panel`

Gets the currently selected [DListView_Line](https://wiki.facepunch.com/gmod/DListView_Line) index.

If [DListView:SetMultiSelect](https://wiki.facepunch.com/gmod/DListView:SetMultiSelect) is set to true, only the first line of all selected lines will be returned. Use [DListView:GetSelected](https://wiki.facepunch.com/gmod/DListView:GetSelected) instead to get all of the selected lines.

**Returns:**
- number — The index of the currently selected line.
- Panel — The currently selected DListView_Line.

[wiki](https://wiki.facepunch.com/gmod/DListView:GetSelectedLine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L332-L338)

---

### DListView:GetSortable · Client, Menu
`DListView:GetSortable() → boolean`

Returns whether sorting of columns by clicking their headers is allowed or not.

See also [DListView:SetSortable](https://wiki.facepunch.com/gmod/DListView:SetSortable).

**Returns:**
- boolean — Whether sorting of columns by clicking their headers is allowed or not

[wiki](https://wiki.facepunch.com/gmod/DListView:GetSortable)

---

### DListView:GetSortedID · Client, Menu · `INTERNAL`
`DListView:GetSortedID(lineId: number) → number`

Converts LineID to SortedID

**Arguments:**
- `lineId` (number) — The DListView_Line:GetID of a line to look up

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DListView:GetSortedID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L346-L354)

---

### DListView:OnClickLine · Client, Menu · `INTERNAL`
`DListView:OnClickLine(line: Panel, isSelected: boolean)`

Called whenever a line is clicked.

**Arguments:**
- `line` (Panel) — The selected line.
- `isSelected` (boolean) — Boolean indicating whether the line is selected.

[wiki](https://wiki.facepunch.com/gmod/DListView:OnClickLine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L356-L431)

---

### DListView:OnRequestResize · Client, Menu · `INTERNAL`
`DListView:OnRequestResize(column: Panel, size: number)`

Called from [DListView_Column](https://wiki.facepunch.com/gmod/DListView_Column).

**Arguments:**
- `column` (Panel) — The column which initialized the resize
- `size` (number)

[wiki](https://wiki.facepunch.com/gmod/DListView:OnRequestResize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L232-L262)

---

### DListView:OnRowRightClick · Client, Menu · `hook`
`DListView:OnRowRightClick(lineID: number, line: Panel)`

Called when a row is right-clicked

**Arguments:**
- `lineID` (number) — The line ID of the right clicked line
- `line` (Panel) — The line panel itself, a DListView_Line.

[wiki](https://wiki.facepunch.com/gmod/DListView:OnRowRightClick)

---

### DListView:OnRowSelected · Client, Menu · `hook`
`DListView:OnRowSelected(rowIndex: number, row: Panel)`

Called internally by [DListView:OnClickLine](https://wiki.facepunch.com/gmod/DListView:OnClickLine) when a line is selected. This is the function you should override to define the behavior when a line is selected.

**Arguments:**
- `rowIndex` (number) — The index of the row/line that the user clicked on.
- `row` (Panel) — The DListView_Line that the user clicked on.

[wiki](https://wiki.facepunch.com/gmod/DListView:OnRowSelected)

---

### DListView:RemoveLine · Client, Menu
`DListView:RemoveLine(line: number)`

Removes a line from the list view.

**Arguments:**
- `line` (number) — Removes the given row, by row id (same number as DListView:GetLine).

[wiki](https://wiki.facepunch.com/gmod/DListView:RemoveLine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L96-L109)

---

### DListView:SelectFirstItem · Client, Menu
`DListView:SelectFirstItem()`

Selects the line at the first index of the DListView if one has been added.

[wiki](https://wiki.facepunch.com/gmod/DListView:SelectFirstItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L501-L506)

---

### DListView:SelectItem · Client, Menu
`DListView:SelectItem(Line: Panel)`

Selects a line in the listview.

**Arguments:**
- `Line` (Panel) — The line to select.

[wiki](https://wiki.facepunch.com/gmod/DListView:SelectItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L492-L499)

---

### DListView:SetDataHeight · Client, Menu
`DListView:SetDataHeight(height: number)`

Sets the height of all lines of the [DListView](https://wiki.facepunch.com/gmod/DListView) except for the header line.

See also [DListView:SetHeaderHeight](https://wiki.facepunch.com/gmod/DListView:SetHeaderHeight).

**Arguments:**
- `height` (number) — The new height to set.

[wiki](https://wiki.facepunch.com/gmod/DListView:SetDataHeight)

---

### DListView:SetDirty · Client, Menu · `INTERNAL`
`DListView:SetDirty(isDirty: boolean)`

Used internally to signify if the [DListView](https://wiki.facepunch.com/gmod/DListView) needs a rebuild.

**Arguments:**
- `isDirty` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DListView:SetDirty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DListView:SetHeaderHeight · Client, Menu
`DListView:SetHeaderHeight(height: number)`

Sets the height of the header line of the [DListView](https://wiki.facepunch.com/gmod/DListView).

See also [DListView:SetDataHeight](https://wiki.facepunch.com/gmod/DListView:SetDataHeight).

**Arguments:**
- `height` (number) — The new height to set.

[wiki](https://wiki.facepunch.com/gmod/DListView:SetHeaderHeight)

---

### DListView:SetHideHeaders · Client, Menu
`DListView:SetHideHeaders(hide: boolean)`

Sets whether the header line should be visible on not.

**Arguments:**
- `hide` (boolean) — Whether the header line should be visible on not.

[wiki](https://wiki.facepunch.com/gmod/DListView:SetHideHeaders)

---

### DListView:SetMultiSelect · Client, Menu
`DListView:SetMultiSelect(allowMultiSelect: boolean)`

Sets whether multiple lines can be selected by the user by using the  or  keys. When set to false, only one line can be selected.

**Arguments:**
- `allowMultiSelect` (boolean) — Whether multiple lines can be selected or not

[wiki](https://wiki.facepunch.com/gmod/DListView:SetMultiSelect)

---

### DListView:SetSortable · Client, Menu
`DListView:SetSortable(isSortable: boolean)`

Enables/disables the sorting of columns by clicking.

**Arguments:**
- `isSortable` (boolean) — Whether sorting columns with clicking is allowed or not.

> **Note:** This will only affect columns that are created after this function is called. Existing columns will be unaffected.

[wiki](https://wiki.facepunch.com/gmod/DListView:SetSortable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DListView:SortByColumn · Client, Menu
`DListView:SortByColumn(columnIndex: number, descending: boolean = false)`

Sorts the items in the specified column.

**Arguments:**
- `columnIndex` (number) — The index of the column that should be sorted.
- `descending` (boolean, default `false`) — Whether the items should be sorted in descending order or not.

[wiki](https://wiki.facepunch.com/gmod/DListView:SortByColumn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L470-L490)

---

### DListView:SortByColumns · Client, Menu
`DListView:SortByColumns(column1: number = nil, descrending1: boolean = false, column2: number = nil, descrending2: boolean = false, column3: number = nil, descrending3: boolean = false, column4: number = nil, descrending4: boolean = false)`

Sorts the list based on given columns.

All arguments are optional

**Arguments:**
- `column1` (number, default `nil`)
- `descrending1` (boolean, default `false`)
- `column2` (number, default `nil`)
- `descrending2` (boolean, default `false`)
- `column3` (number, default `nil`)
- `descrending3` (boolean, default `false`)
- `column4` (number, default `nil`)
- `descrending4` (boolean, default `false`)

[wiki](https://wiki.facepunch.com/gmod/DListView:SortByColumns) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview.lua#L433-L468)
