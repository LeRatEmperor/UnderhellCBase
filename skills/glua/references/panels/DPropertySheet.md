# DPropertySheet

**Realm:** Client, Menu  ·  **Members:** 16  ·  **Inherits:** `Panel`

A tab oriented control where you can create multiple tabs with items within. Used mainly for organization.

[wiki page](https://wiki.facepunch.com/gmod/DPropertySheet)

### DPropertySheet:AddSheet · Client, Menu
`DPropertySheet:AddSheet(name: string, pnl: Panel, icon: string = nil, noStretchX: boolean = false, noStretchY: boolean = false, tooltip: string = nil) → table`

Adds a new tab.

**Arguments:**
- `name` (string) — Name of the tab
- `pnl` (Panel) — Panel to be used as contents of the tab.
- `icon` (string, default `nil`) — Icon for the tab.
- `noStretchX` (boolean, default `false`) — Should DPropertySheet try to fill itself with given panel horizontally.
- `noStretchY` (boolean, default `false`) — Should DPropertySheet try to fill itself with given panel vertically.
- `tooltip` (string, default `nil`) — Tooltip for the tab when user hovers over it with his cursor

**Returns:**
- table — A table containing the following keys: * Panel Tab - The created DTab.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:AddSheet) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L175-L210)

---

### DPropertySheet:CloseTab · Client, Menu
`DPropertySheet:CloseTab(tab: Panel, removePanel: boolean) → Panel`

Removes tab and/or panel from the parent DPropertySheet.

**Arguments:**
- `tab` (Panel) — The DTab of the sheet from DPropertySheet.
- `removePanel` (boolean) — Set to true to remove the associated panel object as well.

**Returns:**
- Panel — The panel of the tab.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:CloseTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L405-L441)

---

### DPropertySheet:CrossFade · Client, Menu · `INTERNAL`
`DPropertySheet:CrossFade(anim: table, delta: number, data: table)`

Internal function that handles the cross fade animation when the player switches tabs.

**Arguments:**
- `anim` (table)
- `delta` (number)
- `data` (table)

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:CrossFade) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L254-L302)

---

### DPropertySheet:GetActiveTab · Client, Menu
`DPropertySheet:GetActiveTab() → Panel`

Returns the active [DTab](https://wiki.facepunch.com/gmod/DTab) of this [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

**Returns:**
- Panel — The DTab

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:GetActiveTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L151)

---

### DPropertySheet:GetFadeTime · Client, Menu
`DPropertySheet:GetFadeTime() → number`

Returns the amount of time (in seconds) it takes to fade between tabs.

	Set by [DPropertySheet:SetFadeTime](https://wiki.facepunch.com/gmod/DPropertySheet:SetFadeTime)

**Returns:**
- number — The amount of time (in seconds) it takes to fade between tabs.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:GetFadeTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L153)

---

### DPropertySheet:GetItems · Client, Menu
`DPropertySheet:GetItems() → table`

Returns a list of all tabs of this [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

**Returns:**
- table — A table of tables.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:GetItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L248-L252)

---

### DPropertySheet:GetPadding · Client, Menu
`DPropertySheet:GetPadding() → number`

Gets the padding from the parent panel to child panels.

**Returns:**
- number — Padding

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:GetPadding) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L152)

---

### DPropertySheet:GetShowIcons · Client, Menu · `DEPRECATED`
`DPropertySheet:GetShowIcons() → boolean`

Returns whatever value was set by [DPropertySheet:SetShowIcons](https://wiki.facepunch.com/gmod/DPropertySheet:SetShowIcons).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:GetShowIcons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L155)

---

### DPropertySheet:OnActiveTabChanged · Client, Menu · `hook`
`DPropertySheet:OnActiveTabChanged(old: Panel, new: Panel)`

Called when a player switches the tabs.

		Source code states that this is meant to be overridden.

**Arguments:**
- `old` (Panel) — The previously active DTab
- `new` (Panel) — The newly active DTab

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:OnActiveTabChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L238-L240)

---

### DPropertySheet:SetActiveTab · Client, Menu
`DPropertySheet:SetActiveTab(tab: Panel)`

Sets the active tab of the [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

**Arguments:**
- `tab` (Panel) — The DTab to set active.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SetActiveTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L212-L236)

---

### DPropertySheet:SetFadeTime · Client, Menu
`DPropertySheet:SetFadeTime(time: number = 0.1)`

Sets the amount of time (in seconds) it takes to fade between tabs.

**Arguments:**
- `time` (number, default `0.1`) — The amount of time it takes (in seconds) to fade between tabs.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SetFadeTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L153)

---

### DPropertySheet:SetPadding · Client, Menu
`DPropertySheet:SetPadding(padding: number = 8)`

Sets the padding from parent panel to children panel.

**Arguments:**
- `padding` (number, default `8`) — Amount of padding

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SetPadding) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L152)

---

### DPropertySheet:SetShowIcons · Client, Menu · `DEPRECATED`
`DPropertySheet:SetShowIcons(show: boolean)`

Does nothing.

**Arguments:**
- `show` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SetShowIcons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L155)

---

### DPropertySheet:SetupCloseButton · Client, Menu
`DPropertySheet:SetupCloseButton(func: function)`

Creates a close button on the right side of the [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet) that will run the given callback function when pressed.

**Arguments:**
- `func` (function) — Callback function to be called when the close button is pressed.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SetupCloseButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L391-L403)

---

### DPropertySheet:SizeToContentWidth · Client, Menu
`DPropertySheet:SizeToContentWidth()`

Sets the width of the [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet) to fit the contents of all of the tabs.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SizeToContentWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L359-L374)

---

### DPropertySheet:SwitchToName · Client, Menu
`DPropertySheet:SwitchToName(name: string)`

Switches the active tab to a tab with given name.

**Arguments:**
- `name` (string) — Case sensitive name of the tab.

[wiki](https://wiki.facepunch.com/gmod/DPropertySheet:SwitchToName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L376-L389)
