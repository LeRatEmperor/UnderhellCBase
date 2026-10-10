# DListView_Column

**Realm:** Client, Menu  ·  **Members:** 17  ·  **Inherits:** `Panel`  ·  `INTERNAL`

A single column, used by [DListView](https://wiki.facepunch.com/gmod/DListView).

[wiki page](https://wiki.facepunch.com/gmod/DListView_Column)

### DListView_Column:DoClick · Client, Menu · `hook`
`DListView_Column:DoClick()`

Called when the column is left clicked (on key release) by the client.

See also [DListView_Column:DoRightClick](https://wiki.facepunch.com/gmod/DListView_Column:DoRightClick).

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:DoClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L91-L96)

---

### DListView_Column:DoRightClick · Client, Menu · `hook`
`DListView_Column:DoRightClick()`

Called when the column is right clicked (on key release) by the client.

See also [DListView_Column:DoClick](https://wiki.facepunch.com/gmod/DListView_Column:DoClick).

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:DoRightClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L98-L100)

---

### DListView_Column:GetColumnID · Client, Menu
`DListView_Column:GetColumnID() → number`

Gets the index used for this column.

**Returns:**
- `index` (number) — The column index of the DListView_Column.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetColumnID)

---

### DListView_Column:GetDescending · Client, Menu
`DListView_Column:GetDescending() → boolean`

Returns whether the column is sorted in descending order or not.

**Returns:**
- `desc` (boolean) — Whether the column is sorted in descending order or not.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetDescending)

---

### DListView_Column:GetFixedWidth · Client, Menu
`DListView_Column:GetFixedWidth() → number`

Returns the fixed width of this column.

**Returns:**
- `width` (number) — The fixed width.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetFixedWidth)

---

### DListView_Column:GetMaxWidth · Client, Menu
`DListView_Column:GetMaxWidth() → number`

Returns the maximum width set with [DListView_Column:SetMaxWidth](https://wiki.facepunch.com/gmod/DListView_Column:SetMaxWidth).

**Returns:**
- `width` (number) — The maximum width

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetMaxWidth)

---

### DListView_Column:GetMinWidth · Client, Menu
`DListView_Column:GetMinWidth() → number`

Returns the minimum width set with [DListView_Column:SetMinWidth](https://wiki.facepunch.com/gmod/DListView_Column:SetMinWidth).

**Returns:**
- `width` (number) — The minimum width

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetMinWidth)

---

### DListView_Column:GetTextAlign · Client, Menu
`DListView_Column:GetTextAlign() → number`

Returns the text alignment for the column

**Returns:**
- `alignment` (number) — The direction of the content, based on the number pad.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:GetTextAlign)

---

### DListView_Column:ResizeColumn · Client, Menu
`DListView_Column:ResizeColumn(size: number)`

Resizes the column, additionally adjusting the size of the column to the right, if any.

**Arguments:**
- `size` (number) — The amount to add to the current column's width.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:ResizeColumn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L127-L131)

---

### DListView_Column:SetColumnID · Client, Menu · `INTERNAL`
`DListView_Column:SetColumnID(index: number)`

Sets the index used for this column.

**Arguments:**
- `index` (number) — The column index of the DListView_Column.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetColumnID)

---

### DListView_Column:SetDescending · Client, Menu
`DListView_Column:SetDescending(desc: boolean)`

Sets whether the column is sorted in descending order or not.

**Arguments:**
- `desc` (boolean) — Whether the column is sorted in descending order or not.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetDescending)

---

### DListView_Column:SetFixedWidth · Client, Menu
`DListView_Column:SetFixedWidth(width: number)`

Sets the fixed width of the column.

**Arguments:**
- `width` (number) — The number value which will determine a fixed width.

> **Note:** Internally this will set [SetMinWidth](https://wiki.facepunch.com/gmod/DListView_Column:SetMinWidth) and [SetMaxWidth](https://wiki.facepunch.com/gmod/DListView_Column:SetMaxWidth) to the value provided

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetFixedWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L84-L89)

---

### DListView_Column:SetMaxWidth · Client, Menu
`DListView_Column:SetMaxWidth(width: number)`

Sets the maximum width of a column.

**Arguments:**
- `width` (number) — The number value which will determine a maximum width.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetMaxWidth)

---

### DListView_Column:SetMinWidth · Client, Menu
`DListView_Column:SetMinWidth(width: number)`

Sets the minimum width of a column.

**Arguments:**
- `width` (number) — The number value which will determine a minimum width.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetMinWidth)

---

### DListView_Column:SetName · Client, Menu
`DListView_Column:SetName(name: string)`

Sets the text in the column's header.

**Arguments:**
- `name` (string) — The new name that the column's header will use.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L102-L106)

---

### DListView_Column:SetTextAlign · Client, Menu
`DListView_Column:SetTextAlign(alignment: number)`

Sets the text alignment for the column

**Arguments:**
- `alignment` (number) — The direction of the content, based on the number pad.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetTextAlign)

---

### DListView_Column:SetWidth · Client, Menu
`DListView_Column:SetWidth(width: number)`

Sets the width of the panel.

**Arguments:**
- `width` (number) — The number value which will determine panel width.

[wiki](https://wiki.facepunch.com/gmod/DListView_Column:SetWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlistview_column.lua#L133-L145)
