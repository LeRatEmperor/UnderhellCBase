# DPanelOverlay

**Realm:** Client, Menu  ·  **Members:** 6  ·  **Inherits:** `DPanel`

Adds curved corners.

[wiki page](https://wiki.facepunch.com/gmod/DPanelOverlay)

### DPanelOverlay:GetColor · Client, Menu
`DPanelOverlay:GetColor() → Color`

Returns the border color of the [DPanelOverlay](https://wiki.facepunch.com/gmod/DPanelOverlay) set by [DPanelOverlay:SetColor](https://wiki.facepunch.com/gmod/DPanelOverlay:SetColor).

**Returns:**
- Color — The set color.

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:GetColor)

---

### DPanelOverlay:GetType · Client, Menu
`DPanelOverlay:GetType() → number`

Returns the type of the [DPanelOverlay](https://wiki.facepunch.com/gmod/DPanelOverlay) set by [DPanelOverlay:SetType](https://wiki.facepunch.com/gmod/DPanelOverlay:SetType).

**Returns:**
- number — The set type.

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:GetType)

---

### DPanelOverlay:PaintDifferentColours · Client, Menu · `INTERNAL`
`DPanelOverlay:PaintDifferentColours(cola: table, colb: table, colc: table, cold: table, size: number)`

Used internally by the panel for type 3.

**Arguments:**
- `cola` (table)
- `colb` (table)
- `colc` (table)
- `cold` (table)
- `size` (number)

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:PaintDifferentColours) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpaneloverlay.lua#L31-L45)

---

### DPanelOverlay:PaintInnerCorners · Client, Menu · `INTERNAL`
`DPanelOverlay:PaintInnerCorners(size: number)`

Used internally by the panel for types 1 and 2.

**Arguments:**
- `size` (number)

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:PaintInnerCorners) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dpaneloverlay.lua#L19-L29)

---

### DPanelOverlay:SetColor · Client, Menu
`DPanelOverlay:SetColor(color: Color)`

Sets the border color of the [DPanelOverlay](https://wiki.facepunch.com/gmod/DPanelOverlay).

**Arguments:**
- `color` (Color) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:SetColor)

---

### DPanelOverlay:SetType · Client, Menu
`DPanelOverlay:SetType(type: number)`

Sets the type of the [DPanelOverlay](https://wiki.facepunch.com/gmod/DPanelOverlay).

**Arguments:**
- `type` (number) — The type to set.

[wiki](https://wiki.facepunch.com/gmod/DPanelOverlay:SetType)
