# DCollapsibleCategory

**Realm:** Client, Menu  ·  **Members:** 24  ·  **Inherits:** `Panel`

The collapsible category allows you to create numerous sections of controls, and have the ability to contract/expand them.

		Consider using [DCategoryList](https://wiki.facepunch.com/gmod/DCategoryList) if you plan on using more than 1 of these.

[wiki page](https://wiki.facepunch.com/gmod/DCollapsibleCategory)

### DCollapsibleCategory:Add · Client, Menu
`DCollapsibleCategory:Add(name: string) → Panel`

Adds a new text button to the collapsible category, like the tool menu in Spawnmenu.

**Arguments:**
- `name` (string) — The name of the button

**Returns:**
- Panel — The DButton

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L75-L120)

---

### DCollapsibleCategory:AnimSlide · Client, Menu · `INTERNAL`
`DCollapsibleCategory:AnimSlide(anim: table, delta: number, data: table)`

Internal function that handles the open/close animations.

**Arguments:**
- `anim` (table)
- `delta` (number)
- `data` (table)

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:AnimSlide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L281-L307)

---

### DCollapsibleCategory:DoExpansion · Client, Menu
`DCollapsibleCategory:DoExpansion(expand: boolean)`

Forces the category to open or collapse

**Arguments:**
- `expand` (boolean) — True to open, false to collapse

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:DoExpansion) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L233-L238)

---

### DCollapsibleCategory:GetAnimTime · Client, Menu
`DCollapsibleCategory:GetAnimTime() → number`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the expand/collapse animation time set by [DCollapsibleCategory:SetAnimTime](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetAnimTime).

**Returns:**
- number — The animation time in seconds

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetAnimTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L50)

---

### DCollapsibleCategory:GetDrawBackground · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:GetDrawBackground() → boolean`

Returns whether or not the panel background is being drawn. Alias of [DCollapsibleCategory:GetPaintBackground](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetPaintBackground).

**Returns:**
- boolean — True if the panel background is drawn, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetDrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L52)

---

### DCollapsibleCategory:GetExpanded · Client, Menu
`DCollapsibleCategory:GetExpanded() → boolean`

Returns whether the DCollapsibleCategory is expanded or not.

**Returns:**
- boolean — If expanded it will return true.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L48)

---

### DCollapsibleCategory:GetHeaderHeight · Client, Menu
`DCollapsibleCategory:GetHeaderHeight() → number`

Returns the header height of the [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory).

See also [DCollapsibleCategory:SetHeaderHeight](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetHeaderHeight).

**Returns:**
- `height` (number) — The current height of the header.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetHeaderHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L162-L166)

---

### DCollapsibleCategory:GetList · Client, Menu
`DCollapsibleCategory:GetList() → Panel`

If set, the [DCategoryList](https://wiki.facepunch.com/gmod/DCategoryList) that created this panel.

See also [DCollapsibleCategory:SetList](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetList).

**Returns:**
- Panel — The DCategoryList that created us.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L54)

---

### DCollapsibleCategory:GetPadding · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:GetPadding() → number`

Doesn't actually do anything.

Returns the number set by [DCollapsibleCategory:SetPadding](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetPadding).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetPadding) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L53)

---

### DCollapsibleCategory:GetPaintBackground · Client, Menu
`DCollapsibleCategory:GetPaintBackground() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns whether or not the background should be painted.

**Returns:**
- boolean — If the background is painted or not

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L41)

---

### DCollapsibleCategory:GetStartHeight · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:GetStartHeight() → number`

Returns whatever was set by [DCollapsibleCategory:SetStartHeight](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetStartHeight)

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetStartHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L49)

---

### DCollapsibleCategory:OnToggle · Client, Menu · `hook`
`DCollapsibleCategory:OnToggle(expanded: boolean)`

Called by [DCollapsibleCategory:Toggle](https://wiki.facepunch.com/gmod/DCollapsibleCategory:Toggle). This function does nothing by itself, as you're supposed to overwrite it.

**Arguments:**
- `expanded` (boolean) — If it was expanded or not

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:OnToggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L227-L231)

---

### DCollapsibleCategory:SetAnimTime · Client, Menu
`DCollapsibleCategory:SetAnimTime(time: number)`

Sets the time in seconds it takes to expand the DCollapsibleCategory

**Arguments:**
- `time` (number) — The time in seconds it takes to expand

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetAnimTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L50)

---

### DCollapsibleCategory:SetContents · Client, Menu
`DCollapsibleCategory:SetContents(pnl: Panel)`

Sets the contents of the DCollapsibleCategory.

**Arguments:**
- `pnl` (Panel) — The panel, containing the contents for the DCollapsibleCategory, mostly an DScrollPanel

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetContents) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L176-L196)

---

### DCollapsibleCategory:SetDrawBackground · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:SetDrawBackground(draw: boolean)`

Sets whether or not to draw the panel background. Alias of [DCollapsibleCategory:SetPaintBackground](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetPaintBackground).

**Arguments:**
- `draw` (boolean) — True to show the panel's background, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetDrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DCollapsibleCategory:SetExpanded · Client, Menu
`DCollapsibleCategory:SetExpanded(expanded: boolean = true)`

Sets whether the [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory) is expanded or not upon opening the container.

You should use [DCollapsibleCategory:Toggle](https://wiki.facepunch.com/gmod/DCollapsibleCategory:Toggle) or [DCollapsibleCategory:DoExpansion](https://wiki.facepunch.com/gmod/DCollapsibleCategory:DoExpansion) instead.

**Arguments:**
- `expanded` (boolean, default `true`) — Whether it shall be expanded or not by default

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L198-L207)

---

### DCollapsibleCategory:SetHeaderHeight · Client, Menu
`DCollapsibleCategory:SetHeaderHeight(height: number)`

Sets the header height of the [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory).

See also [DCollapsibleCategory:GetHeaderHeight](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetHeaderHeight).

**Arguments:**
- `height` (number) — The new height to set.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetHeaderHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L156-L160)

---

### DCollapsibleCategory:SetLabel · Client, Menu
`DCollapsibleCategory:SetLabel(label: string)`

Sets the name of the DCollapsibleCategory.

**Arguments:**
- `label` (string) — The label/name of the DCollapsibleCategory.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetLabel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L150-L154)

---

### DCollapsibleCategory:SetList · Client, Menu
`DCollapsibleCategory:SetList(pnl: Panel)`

Used internally by [DCategoryList](https://wiki.facepunch.com/gmod/DCategoryList) when it creates a [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory) during [DCategoryList:Add](https://wiki.facepunch.com/gmod/DCategoryList:Add).

If set, [Panel:UnselectAll](https://wiki.facepunch.com/gmod/Panel:UnselectAll) will be called on the list, instead of calling it on the category panel itself when a category is clicked.

**Arguments:**
- `pnl` (Panel) — The Panel:UnselectAll that is the "parent" of this panel.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L54)

---

### DCollapsibleCategory:SetPadding · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:SetPadding(padding: number)`

Doesn't actually do anything.

**Arguments:**
- `padding` (number)

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetPadding) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L53)

---

### DCollapsibleCategory:SetPaintBackground · Client, Menu
`DCollapsibleCategory:SetPaintBackground(paint: boolean)`

Sets whether or not the background should be painted.

**Arguments:**
- `paint` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DCollapsibleCategory:SetStartHeight · Client, Menu · `DEPRECATED`
`DCollapsibleCategory:SetStartHeight(height: number)`

Does nothing.

**Arguments:**
- `height` (number)

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:SetStartHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L49)

---

### DCollapsibleCategory:Toggle · Client, Menu
`DCollapsibleCategory:Toggle()`

Toggles the expanded state of the [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory).

See [DCollapsibleCategory:GetExpanded](https://wiki.facepunch.com/gmod/DCollapsibleCategory:GetExpanded) for a function to retrieve the expanded state.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:Toggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L209-L225)

---

### DCollapsibleCategory:UpdateAltLines · Client, Menu · `INTERNAL`
`DCollapsibleCategory:UpdateAltLines()`

Used internally to update the "AltLine" property on all "child" panels.

[wiki](https://wiki.facepunch.com/gmod/DCollapsibleCategory:UpdateAltLines) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcategorycollapse.lua#L135-L142)
