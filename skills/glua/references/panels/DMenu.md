# DMenu

**Realm:** Client, Menu  ·  **Members:** 27  ·  **Inherits:** `DScrollPanel`

A simple menu with sub menu, icon and convar support.

[wiki page](https://wiki.facepunch.com/gmod/DMenu)

### DMenu:AddCVar · Client, Menu
`DMenu:AddCVar(strText: string, convar: string, on: string, off: string, funcFunction: function = nil) → Panel`

Creates a [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar) and adds it as an option into the menu. Checking and unchecking the option will alter the given console variable's value.

**Arguments:**
- `strText` (string) — The text of the button
- `convar` (string) — The console variable to change
- `on` (string) — The value of the console variable to set when the option is checked
- `off` (string) — The value of the console variable to set when the option is unchecked
- `funcFunction` (function, default `nil`) — If set, the function will be called every time the option is pressed/clicked/selected.

**Returns:**
- Panel — The created DMenuOptionCVar

[wiki](https://wiki.facepunch.com/gmod/DMenu:AddCVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L49-L64)

---

### DMenu:AddOption · Client, Menu
`DMenu:AddOption(name: string, func: function = nil) → Panel`

Add an option to the DMenu

**Arguments:**
- `name` (string) — Name of the option.
- `func` (function, default `nil`) — Function to execute when this option is clicked.

**Returns:**
- Panel — Returns the created DMenuOption panel.

[wiki](https://wiki.facepunch.com/gmod/DMenu:AddOption) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L36-L47)

---

### DMenu:AddPanel · Client, Menu
`DMenu:AddPanel(pnl: Panel)`

Adds a panel to the [DMenu](https://wiki.facepunch.com/gmod/DMenu) as if it were an option.

This invokes [DScrollPanel:AddItem](https://wiki.facepunch.com/gmod/DScrollPanel:AddItem) and will not create a new panel if a class name is passed, unlike [Panel:Add](https://wiki.facepunch.com/gmod/Panel:Add).

**Arguments:**
- `pnl` (Panel) — The panel that you want to add.

[wiki](https://wiki.facepunch.com/gmod/DMenu:AddPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L29-L34)

---

### DMenu:AddSpacer · Client, Menu
`DMenu:AddSpacer()`

Adds a horizontal line spacer.

[wiki](https://wiki.facepunch.com/gmod/DMenu:AddSpacer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L66-L78)

---

### DMenu:AddSubMenu · Client, Menu
`DMenu:AddSubMenu(Name: string, func: function = nil) → Panel, Panel`

Add a sub menu to the DMenu

**Arguments:**
- `Name` (string) — Name of the sub menu.
- `func` (function, default `nil`) — Function to execute when this sub menu is clicked.

**Returns:**
- Panel — The created sub DMenu
- Panel — The created DMenuOption

[wiki](https://wiki.facepunch.com/gmod/DMenu:AddSubMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L80-L92)

---

### DMenu:ChildCount · Client, Menu
`DMenu:ChildCount() → number`

Returns the number of child elements of [DMenu](https://wiki.facepunch.com/gmod/DMenu)'s [DScrollPanel:GetCanvas](https://wiki.facepunch.com/gmod/DScrollPanel:GetCanvas).

**Returns:**
- number — The number of child elements

[wiki](https://wiki.facepunch.com/gmod/DMenu:ChildCount) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L145-L147)

---

### DMenu:ClearHighlights · Client, Menu · `DEPRECATED`
`DMenu:ClearHighlights()`

Clears all highlights made by [DMenu:HighlightItem](https://wiki.facepunch.com/gmod/DMenu:HighlightItem).

Doesn't appear to be used or do anything.

[wiki](https://wiki.facepunch.com/gmod/DMenu:ClearHighlights) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L266-L272)

---

### DMenu:CloseSubMenu · Client, Menu · `INTERNAL`
`DMenu:CloseSubMenu(menu: Panel)`

Used internally by [DMenu:OpenSubMenu](https://wiki.facepunch.com/gmod/DMenu:OpenSubMenu).

**Arguments:**
- `menu` (Panel) — The menu to close

[wiki](https://wiki.facepunch.com/gmod/DMenu:CloseSubMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L129-L134)

---

### DMenu:GetChild · Client, Menu
`DMenu:GetChild(childIndex: number)`

Gets a child by its index.

**Arguments:**
- `childIndex` (number) — The index of the child to get.

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L149-L151)

---

### DMenu:GetDeleteSelf · Client, Menu · `DEPRECATED`
`DMenu:GetDeleteSelf() → boolean`

Set by [DMenu:SetDeleteSelf](https://wiki.facepunch.com/gmod/DMenu:SetDeleteSelf)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetDeleteSelf)

---

### DMenu:GetDrawBorder · Client, Menu · `DEPRECATED`
`DMenu:GetDrawBorder() → boolean`

Returns the value set by [DMenu:SetDrawBorder](https://wiki.facepunch.com/gmod/DMenu:SetDrawBorder).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetDrawBorder)

---

### DMenu:GetDrawColumn · Client, Menu
`DMenu:GetDrawColumn() → boolean`

Returns whether the [DMenu](https://wiki.facepunch.com/gmod/DMenu) should draw the icon column with a different color or not.

See [DMenu:SetDrawColumn](https://wiki.facepunch.com/gmod/DMenu:SetDrawColumn)

**Returns:**
- boolean — Whether to draw the column or not

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetDrawColumn)

---

### DMenu:GetMaxHeight · Client, Menu
`DMenu:GetMaxHeight() → number`

Returns the maximum height of the [DMenu](https://wiki.facepunch.com/gmod/DMenu).

**Returns:**
- number — The maximum height in pixels

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetMaxHeight)

---

### DMenu:GetMinimumWidth · Client, Menu
`DMenu:GetMinimumWidth() → number`

Returns the minimum width of the [DMenu](https://wiki.facepunch.com/gmod/DMenu) in pixels

**Returns:**
- number — the minimum width of the DMenu

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetMinimumWidth)

---

### DMenu:GetOpenSubMenu · Client, Menu · `INTERNAL`
`DMenu:GetOpenSubMenu() → Panel`

Returns the currently opened submenu.

Used internally to store the open submenu by [DMenu:Hide](https://wiki.facepunch.com/gmod/DMenu:Hide), [DMenu:OpenSubMenu](https://wiki.facepunch.com/gmod/DMenu:OpenSubMenu).

**Returns:**
- Panel — The currently opened submenu, if any.

[wiki](https://wiki.facepunch.com/gmod/DMenu:GetOpenSubMenu)

---

### DMenu:Hide · Client, Menu
`DMenu:Hide()`

Used to safely hide (not remove) the menu. This will also hide any opened submenues recursively.

[wiki](https://wiki.facepunch.com/gmod/DMenu:Hide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L94-L104)

---

### DMenu:HighlightItem · Client, Menu · `DEPRECATED`
`DMenu:HighlightItem(item: Panel)`

Highlights selected item in the [DMenu](https://wiki.facepunch.com/gmod/DMenu) by setting the item's key "Highlight" to true.

Doesn't appear to be working or used.

**Arguments:**
- `item` (Panel) — The item to highlight.

[wiki](https://wiki.facepunch.com/gmod/DMenu:HighlightItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L274-L282)

---

### DMenu:Open · Client, Menu
`DMenu:Open(x: number = gui.MouseX(), y: number = gui.MouseY(), skipanimation: any = nil, ownerpanel: Panel = nil)`

Opens the [DMenu](https://wiki.facepunch.com/gmod/DMenu) at given position.

**Arguments:**
- `x` (number, default `gui.MouseX()`) — Position (X coordinate) to open the menu at.
- `y` (number, default `gui.MouseY()`) — Position (Y coordinate) to open the menu at.
- `skipanimation` (any, default `nil`) — This argument does nothing.
- `ownerpanel` (Panel, default `nil`) — If `x` and `y` are not set manually, setting this argument will offset the `y` position of the opened menu by the height of given panel.

[wiki](https://wiki.facepunch.com/gmod/DMenu:Open) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L194-L249)

---

### DMenu:OpenSubMenu · Client, Menu
`DMenu:OpenSubMenu(item: Panel, menu: Panel = nil)`

Closes any active sub menus, and opens a new one.

**Arguments:**
- `item` (Panel) — The DMenuOption to open the submenu at
- `menu` (Panel, default `nil`) — The submenu to open.

[wiki](https://wiki.facepunch.com/gmod/DMenu:OpenSubMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L106-L127)

---

### DMenu:OptionSelected · Client, Menu
`DMenu:OptionSelected(option: Panel, optionText: string)`

Called when a option has been selected

**Arguments:**
- `option` (Panel) — The DMenuOption that was selected
- `optionText` (string) — The options text

[wiki](https://wiki.facepunch.com/gmod/DMenu:OptionSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L260-L264)

---

### DMenu:OptionSelectedInternal · Client, Menu · `INTERNAL`
`DMenu:OptionSelectedInternal(option: Panel)`

Called by [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption). Calls [DMenu:OptionSelected](https://wiki.facepunch.com/gmod/DMenu:OptionSelected).

**Arguments:**
- `option` (Panel) — The DMenuOption that called this function

[wiki](https://wiki.facepunch.com/gmod/DMenu:OptionSelectedInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L254-L258)

---

### DMenu:SetDeleteSelf · Client, Menu
`DMenu:SetDeleteSelf(newState: boolean)`

Set to true by default. IF set to true, the menu will be deleted when it is closed, not simply hidden.

This is used by [DMenuBar](https://wiki.facepunch.com/gmod/DMenuBar)

**Arguments:**
- `newState` (boolean) — true to delete menu on close, false to simply hide.

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetDeleteSelf)

---

### DMenu:SetDrawBorder · Client, Menu · `DEPRECATED`
`DMenu:SetDrawBorder(bool: boolean)`

Does nothing.

**Arguments:**
- `bool` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetDrawBorder)

---

### DMenu:SetDrawColumn · Client, Menu
`DMenu:SetDrawColumn(draw: boolean)`

Sets whether the [DMenu](https://wiki.facepunch.com/gmod/DMenu) should draw the icon column with a different color.

**Arguments:**
- `draw` (boolean) — Whether to draw the column or not

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetDrawColumn)

---

### DMenu:SetMaxHeight · Client, Menu
`DMenu:SetMaxHeight(maxHeight: number)`

Sets the maximum height the [DMenu](https://wiki.facepunch.com/gmod/DMenu) can have. If the height of all menu items exceed this value, a scroll bar will be automatically added.

**Arguments:**
- `maxHeight` (number) — The maximum height of the DMenu to set, in pixels

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetMaxHeight)

---

### DMenu:SetMinimumWidth · Client, Menu
`DMenu:SetMinimumWidth(minWidth: number)`

Sets the minimum width of the [DMenu](https://wiki.facepunch.com/gmod/DMenu). The menu will be stretched to match the given value.

**Arguments:**
- `minWidth` (number) — The minimum width of the DMenu in pixels

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetMinimumWidth)

---

### DMenu:SetOpenSubMenu · Client, Menu · `INTERNAL`
`DMenu:SetOpenSubMenu(item: Panel)`

Used internally to store the open submenu by [DMenu:Hide](https://wiki.facepunch.com/gmod/DMenu:Hide), [DMenu:OpenSubMenu](https://wiki.facepunch.com/gmod/DMenu:OpenSubMenu), [DMenu:CloseSubMenu](https://wiki.facepunch.com/gmod/DMenu:CloseSubMenu)

**Arguments:**
- `item` (Panel) — The menu to store

[wiki](https://wiki.facepunch.com/gmod/DMenu:SetOpenSubMenu)
