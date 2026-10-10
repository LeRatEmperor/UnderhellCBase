# DPanelList

**Realm:** Client, Menu  ·  **Members:** 12  ·  **Inherits:** `DPanel`  ·  `DEPRECATED`

Displays elements in a horizontal or vertical list. A scrollbar is automatically shown if necessary.
		You can get its vertical bar via `DPanelList.VBar`.  
		[DPanelList](https://wiki.facepunch.com/gmod/DPanelList) was succeeded in version 13 by more specialised layout elements.

[wiki page](https://wiki.facepunch.com/gmod/DPanelList)

### DPanelList:AddItem · Client, Menu · `DEPRECATED`
`DPanelList:AddItem(pnl: Panel, state: string = nil)`

Adds a existing panel to the end of [DPanelList](https://wiki.facepunch.com/gmod/DPanelList).

**Arguments:**
- `pnl` (Panel) — Panel to be used as element of list
- `state` (string, default `nil`) — If set to "ownline", the item will take its own entire line.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L105-L125)

---

### DPanelList:CleanList · Client, Menu · `DEPRECATED`
`DPanelList:CleanList()`

Removes all items.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:CleanList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L215-L225)

---

### DPanelList:Clear · Client · `DEPRECATED`
`DPanelList:Clear(remove: boolean)`

Hides all child panels, and optionally deletes them.

**Arguments:**
- `remove` (boolean) — Whether to actually delete the panels, not just hide them.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L87-L103)

---

### DPanelList:EnableVerticalScrollbar · Client, Menu · `DEPRECATED`
`DPanelList:EnableVerticalScrollbar()`

Enables/creates the vertical scroll bar so that the panel list can be scrolled through.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:EnableVerticalScrollbar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L73-L79)

---

### DPanelList:GetItems · Client, Menu · `DEPRECATED`
`DPanelList:GetItems() → table`

Returns all panels has added by [DPanelList:AddItem](https://wiki.facepunch.com/gmod/DPanelList:AddItem)

**Returns:**
- table — A table of panels used as items of DPanelList.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:GetItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L59-L65)

---

### DPanelList:GetPadding · Client, Menu · `DEPRECATED`
`DPanelList:GetPadding() → number`

Returns offset of list items from the panel borders set by [DPanelList:SetPadding](https://wiki.facepunch.com/gmod/DPanelList:SetPadding)

**Returns:**
- number — Offset from panel borders

[wiki](https://wiki.facepunch.com/gmod/DPanelList:GetPadding)

---

### DPanelList:GetSpacing · Client, Menu · `DEPRECATED`
`DPanelList:GetSpacing() → number`

Returns distance between list items set by [DPanelList:SetSpacing](https://wiki.facepunch.com/gmod/DPanelList:SetSpacing)

**Returns:**
- number — Distance between panels

[wiki](https://wiki.facepunch.com/gmod/DPanelList:GetSpacing)

---

### DPanelList:InsertAtTop · Client, Menu · `DEPRECATED`
`DPanelList:InsertAtTop(insert: Panel, strLineState: string)`

Insert given panel at the top of the list.

**Arguments:**
- `insert` (Panel) — The panel to insert
- `strLineState` (string) — If set to "ownline", no other panels will be placed to the left or right of the panel we are inserting

[wiki](https://wiki.facepunch.com/gmod/DPanelList:InsertAtTop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L156-L167)

---

### DPanelList:Rebuild · Client, Menu · `DEPRECATED` · `INTERNAL`
`DPanelList:Rebuild()`

Used internally to rebuild the child panel positions.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:Rebuild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L227-L320)

---

### DPanelList:SetAutoSize · Client, Menu · `DEPRECATED`
`DPanelList:SetAutoSize(shouldSizeToContents: boolean)`

Sets the [DPanelList](https://wiki.facepunch.com/gmod/DPanelList) to size its height to its contents. This is set to false by default.

**Arguments:**
- `shouldSizeToContents` (boolean) — Whether to size to the height of the DPanelList contents.

[wiki](https://wiki.facepunch.com/gmod/DPanelList:SetAutoSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanellist.lua#L4)

---

### DPanelList:SetPadding · Client, Menu · `DEPRECATED`
`DPanelList:SetPadding(Offset: number)`

Sets the offset of the lists items from the panel borders

**Arguments:**
- `Offset` (number) — Offset from panel borders

[wiki](https://wiki.facepunch.com/gmod/DPanelList:SetPadding)

---

### DPanelList:SetSpacing · Client, Menu · `DEPRECATED`
`DPanelList:SetSpacing(Distance: number)`

Sets distance between list items

**Arguments:**
- `Distance` (number) — Distance between panels

[wiki](https://wiki.facepunch.com/gmod/DPanelList:SetSpacing)
