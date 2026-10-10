# DScrollPanel

**Realm:** Client, Menu  ·  **Members:** 10  ·  **Inherits:** `DPanel`

DScrollPanel is a VGUI Element similar to DPanel however it has a vertical scrollbar docked to the right which can be used to put more content in a smaller area. DScrollPanels are essentially [DPanel](https://wiki.facepunch.com/gmod/DPanel)s with the Scroll Bar.

This can be used to replace the [DPanelList](https://wiki.facepunch.com/gmod/DPanelList) with [DPanelList:EnableVerticalScrollbar](https://wiki.facepunch.com/gmod/DPanelList:EnableVerticalScrollbar) and get similar functionality as well as using a non-deprecated element.

If you would like to paint or edit the elements of the scrollbar use [DScrollPanel:GetVBar](https://wiki.facepunch.com/gmod/DScrollPanel:GetVBar). If you want to see if the scrollbar is visible then use the VBar.Enabled variable on the scrollbar's VBar.

> **Note:** [Panel:DockPadding](https://wiki.facepunch.com/gmod/Panel:DockPadding) will not have an effect on children of this panel. Use the function on [DScrollPanel:GetCanvas](https://wiki.facepunch.com/gmod/DScrollPanel:GetCanvas) instead.

[wiki page](https://wiki.facepunch.com/gmod/DScrollPanel)

### DScrollPanel:AddItem · Client, Menu
`DScrollPanel:AddItem(pnl: Panel)`

Parents the passed panel to the DScrollPanel's canvas.

**Arguments:**
- `pnl` (Panel) — The panel to add.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L33-L37)

---

### DScrollPanel:GetCanvas · Client, Menu
`DScrollPanel:GetCanvas() → Panel`

Returns the canvas ( The panel all child panels are parented to ) of the DScrollPanel.

**Returns:**
- Panel — The canvas

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:GetCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L57-L61)

---

### DScrollPanel:GetPadding · Client, Menu · `DEPRECATED`
`DScrollPanel:GetPadding() → number`

Gets the [DScrollPanel](https://wiki.facepunch.com/gmod/DScrollPanel)s padding, set by [DScrollPanel:SetPadding](https://wiki.facepunch.com/gmod/DScrollPanel:SetPadding).

**Returns:**
- number — DScrollPanels padding

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:GetPadding)

---

### DScrollPanel:GetVBar · Client, Menu
`DScrollPanel:GetVBar() → Panel{DVScrollBar}`

Returns the vertical scroll bar of the panel.

**Returns:**
- Panel{DVScrollBar} — The DVScrollBar.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:GetVBar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L51-L55)

---

### DScrollPanel:InnerWidth · Client, Menu
`DScrollPanel:InnerWidth() → number`

Return the width of the DScrollPanel's canvas.

**Returns:**
- number — The width of the DScrollPanel's canvas

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:InnerWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L63-L67)

---

### DScrollPanel:PerformLayoutInternal · Client, Menu · `INTERNAL`
`DScrollPanel:PerformLayoutInternal()`

Used internally to rebuild the panel's children positioning. You should use [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) instead.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:PerformLayoutInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L109-L131)

---

### DScrollPanel:Rebuild · Client, Menu · `INTERNAL`
`DScrollPanel:Rebuild()`

Used internally to rebuild the panel's children positioning. You should use [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) instead.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:Rebuild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L69-L80)

---

### DScrollPanel:ScrollToChild · Client, Menu
`DScrollPanel:ScrollToChild(panel: Panel)`

Scrolls to the given child

**Arguments:**
- `panel` (Panel) — The panel to scroll to, must be a child of the DScrollPanel.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:ScrollToChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dscrollpanel.lua#L94-L106)

---

### DScrollPanel:SetCanvas · Client, Menu · `INTERNAL`
`DScrollPanel:SetCanvas(canvas: Panel)`

Sets the canvas of the DScrollPanel.

**Arguments:**
- `canvas` (Panel) — The new canvas

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:SetCanvas)

---

### DScrollPanel:SetPadding · Client, Menu · `DEPRECATED`
`DScrollPanel:SetPadding(padding: number)`

Sets the DScrollPanel's padding. This function appears to be unused.

**Arguments:**
- `padding` (number) — The padding of the DScrollPanel.

[wiki](https://wiki.facepunch.com/gmod/DScrollPanel:SetPadding)
