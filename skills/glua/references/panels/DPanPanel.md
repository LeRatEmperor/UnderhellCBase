# DPanPanel

**Realm:** Client, Menu  ·  **Members:** 5  ·  **Inherits:** `DPanel`

A panel similar to [DScrollPanel](https://wiki.facepunch.com/gmod/DScrollPanel), but that allows the player to pan around, for example a zoomed in image within a small window.

[wiki page](https://wiki.facepunch.com/gmod/DPanPanel)

### DPanPanel:AddItem · Client, Menu
`DPanPanel:AddItem(pnl: Panel)`

Parents the passed panel to the [DPanPanel:GetCanvas](https://wiki.facepunch.com/gmod/DPanPanel:GetCanvas).

**Arguments:**
- `pnl` (Panel) — The panel to add.

[wiki](https://wiki.facepunch.com/gmod/DPanPanel:AddItem)

---

### DPanPanel:GetCanvas · Client, Menu
`DPanPanel:GetCanvas() → Panel`

The internal canvas panel.

**Returns:**
- Panel — The canvas panel.

[wiki](https://wiki.facepunch.com/gmod/DPanPanel:GetCanvas)

---

### DPanPanel:OnScroll · Client, Menu · `INTERNAL`
`DPanPanel:OnScroll(x: number, y: number)`

Used internally, called from [DPanPanel:ScrollToChild](https://wiki.facepunch.com/gmod/DPanPanel:ScrollToChild).

**Arguments:**
- `x` (number)
- `y` (number)

[wiki](https://wiki.facepunch.com/gmod/DPanPanel:OnScroll)

---

### DPanPanel:ScrollToChild · Client, Menu
`DPanPanel:ScrollToChild(pnl: Panel)`

Scroll to a specific child panel.

**Arguments:**
- `pnl` (Panel) — The panel to scroll to.

[wiki](https://wiki.facepunch.com/gmod/DPanPanel:ScrollToChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpanpanel.lua#L123-L135)

---

### DPanPanel:SetCanvas · Client, Menu · `INTERNAL`
`DPanPanel:SetCanvas(pnl: Panel)`

Used internally.

**Arguments:**
- `pnl` (Panel) — The canvas panel.

[wiki](https://wiki.facepunch.com/gmod/DPanPanel:SetCanvas)
