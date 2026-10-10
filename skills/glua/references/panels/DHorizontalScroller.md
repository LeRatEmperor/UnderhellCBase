# DHorizontalScroller

**Realm:** Client, Menu  ·  **Members:** 11  ·  **Inherits:** `Panel`

A very basic horizontal scrollable panel, similar to [DScrollPanel](https://wiki.facepunch.com/gmod/DScrollPanel).

		Used internally in [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

[wiki page](https://wiki.facepunch.com/gmod/DHorizontalScroller)

### DHorizontalScroller:AddPanel · Client, Menu
`DHorizontalScroller:AddPanel(pnl: Panel)`

Adds a panel to the [DHorizontalScroller](https://wiki.facepunch.com/gmod/DHorizontalScroller).

**Arguments:**
- `pnl` (Panel) — The panel to add.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:AddPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L96-L103)

---

### DHorizontalScroller:GetCanvas · Client, Menu
`DHorizontalScroller:GetCanvas() → Panel`

Returns the internal canvas panel where the content of [DHorizontalScroller](https://wiki.facepunch.com/gmod/DHorizontalScroller) are placed on.

**Returns:**
- Panel — The DDragBase panel.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:GetCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L62-L64)

---

### DHorizontalScroller:GetOverlap · Client, Menu
`DHorizontalScroller:GetOverlap() → number`

Returns the overlap set by [DHorizontalScroller:SetOverlap](https://wiki.facepunch.com/gmod/DHorizontalScroller:SetOverlap).

**Returns:**
- number — The overlap.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:GetOverlap)

---

### DHorizontalScroller:GetShowDropTargets · Client, Menu
`DHorizontalScroller:GetShowDropTargets() → boolean`

Returns whether this panel should show drop targets.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:GetShowDropTargets)

---

### DHorizontalScroller:MakeDroppable · Client, Menu
`DHorizontalScroller:MakeDroppable(name: string)`

Same as [DDragBase:MakeDroppable](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable).
TODO: Transclude or whatever to here?

**Arguments:**
- `name` (string)

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:MakeDroppable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L92-L94)

---

### DHorizontalScroller:OnDragModified · Client, Menu · `hook`
`DHorizontalScroller:OnDragModified()`

Called when the panel is scrolled.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:OnDragModified)

---

### DHorizontalScroller:ScrollToChild · Client, Menu
`DHorizontalScroller:ScrollToChild(target: Panel)`

Scrolls the [DHorizontalScroller](https://wiki.facepunch.com/gmod/DHorizontalScroller) to given child panel.

**Arguments:**
- `target` (Panel) — The target child panel.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:ScrollToChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L66-L79)

---

### DHorizontalScroller:SetOverlap · Client, Menu
`DHorizontalScroller:SetOverlap(overlap: number)`

Controls the spacing between elements of the horizontal scroller.

**Arguments:**
- `overlap` (number) — Overlap in pixels.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:SetOverlap)

---

### DHorizontalScroller:SetScroll · Client, Menu
`DHorizontalScroller:SetScroll(scroll: number)`

Sets the scroll amount, automatically clamping the value.

**Arguments:**
- `scroll` (number) — The new scroll amount

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:SetScroll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L81-L86)

---

### DHorizontalScroller:SetShowDropTargets · Client, Menu
`DHorizontalScroller:SetShowDropTargets(newState: boolean)`

Sets whether this panel should show drop targets.

**Arguments:**
- `newState` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:SetShowDropTargets) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DHorizontalScroller:SetUseLiveDrag · Client, Menu
`DHorizontalScroller:SetUseLiveDrag(newState: boolean)`

Same as [DDragBase:SetUseLiveDrag](https://wiki.facepunch.com/gmod/DDragBase:SetUseLiveDrag)

**Arguments:**
- `newState` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DHorizontalScroller:SetUseLiveDrag) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontalscroller.lua#L88-L90)
