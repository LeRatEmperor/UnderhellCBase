# DTab

**Realm:** Client, Menu  ·  **Members:** 7  ·  **Inherits:** `DButton`  ·  `INTERNAL`

This element is created within and only used in the [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet) file. These can be elements are stored items are stored in the `Items` subtable of the [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet)

[wiki page](https://wiki.facepunch.com/gmod/DTab)

### DTab:GetPanel · Client, Menu
`DTab:GetPanel() → Panel`

Returns the panel that the tab represents.

**Returns:**
- Panel — Panel added to the sheet using DPropertySheet:AddSheet.

[wiki](https://wiki.facepunch.com/gmod/DTab:GetPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L5)

---

### DTab:GetPropertySheet · Client, Menu
`DTab:GetPropertySheet() → Panel`

The [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet) this tab belongs to.

**Returns:**
- `pnl` (Panel) — The DPropertySheet this tab belongs to.

[wiki](https://wiki.facepunch.com/gmod/DTab:GetPropertySheet)

---

### DTab:GetTabHeight · Client, Menu · `INTERNAL`
`DTab:GetTabHeight() → number`

Returns the target height of this tab. Used internally by [DTab](https://wiki.facepunch.com/gmod/DTab)'s [PANEL:ApplySchemeSettings](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings).

**Returns:**
- number — Either 20, or 28 if DTab:IsActive.

[wiki](https://wiki.facepunch.com/gmod/DTab:GetTabHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L80-L88)

---

### DTab:IsActive · Client, Menu
`DTab:IsActive() → boolean`

Returns whether the tab is the currently selected tab of the associated [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

**Returns:**
- boolean — Currently selected tab.

[wiki](https://wiki.facepunch.com/gmod/DTab:IsActive) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L34-L36)

---

### DTab:SetPanel · Client, Menu · `INTERNAL`
`DTab:SetPanel(pnl: Panel)`

Used internally by [DTab:Setup](https://wiki.facepunch.com/gmod/DTab:Setup).

**Arguments:**
- `pnl` (Panel) — The contents of this tab.

[wiki](https://wiki.facepunch.com/gmod/DTab:SetPanel)

---

### DTab:SetPropertySheet · Client, Menu · `INTERNAL`
`DTab:SetPropertySheet(pnl: Panel)`

Used internally by [DTab:Setup](https://wiki.facepunch.com/gmod/DTab:Setup).

**Arguments:**
- `pnl` (Panel) — The DPropertySheet to set for this tab.

[wiki](https://wiki.facepunch.com/gmod/DTab:SetPropertySheet)

---

### DTab:Setup · Client, Menu · `INTERNAL`
`DTab:Setup(label: string, sheet: Panel, pnl: Panel, icon: string = nil)`

Used internally by [DPropertySheet:AddSheet](https://wiki.facepunch.com/gmod/DPropertySheet:AddSheet).

**Arguments:**
- `label` (string) — Label of the tab
- `sheet` (Panel) — The DPropertySheet this tab belongs to.
- `pnl` (Panel) — Panel to be used as contents of the tab.
- `icon` (string, default `nil`) — Icon for the tab.

[wiki](https://wiki.facepunch.com/gmod/DTab:Setup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpropertysheet.lua#L17-L32)
