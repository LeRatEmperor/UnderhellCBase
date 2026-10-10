# DCategoryList

**Realm:** Client, Menu  ·  **Members:** 3  ·  **Inherits:** `DScrollPanel`

A host for multiple [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory) panels. 
		As the name suggests, each one of them can be collapsed or expanded on demand by the user.

[wiki page](https://wiki.facepunch.com/gmod/DCategoryList)

### DCategoryList:Add · Client, Menu
`DCategoryList:Add(categoryName: string) → Panel`

Adds a [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory) to the list.

**Arguments:**
- `categoryName` (string) — The name of the category to add.

**Returns:**
- Panel — The created DCollapsibleCategory

[wiki](https://wiki.facepunch.com/gmod/DCategoryList:Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorylist.lua#L18-L28)

---

### DCategoryList:AddItem · Client, Menu
`DCategoryList:AddItem(element: Panel)`

Adds an element to the list.

**Arguments:**
- `element` (Panel) — VGUI element to add to the list.

[wiki](https://wiki.facepunch.com/gmod/DCategoryList:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorylist.lua#L10-L16)

---

### DCategoryList:UnselectAll · Client, Menu
`DCategoryList:UnselectAll()`

Calls [Panel:UnselectAll](https://wiki.facepunch.com/gmod/Panel:UnselectAll) on all child elements, if they have it.

[wiki](https://wiki.facepunch.com/gmod/DCategoryList:UnselectAll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorylist.lua#L37-L47)
