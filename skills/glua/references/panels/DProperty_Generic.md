# DProperty_Generic

**Realm:** Client  ·  **Members:** 4  ·  **Inherits:** `Panel`  ·  `INTERNAL`

A base for other controls for [DProperties](https://wiki.facepunch.com/gmod/DProperties). Acts as a generic text input on its own.

[wiki page](https://wiki.facepunch.com/gmod/DProperty_Generic)

### DProperty_Generic:GetRow · Client
`DProperty_Generic:GetRow() → Panel`

Returns the internal row panel of a [DProperties](https://wiki.facepunch.com/gmod/DProperties) that this panel belongs to.

**Returns:**
- Panel — The row panel.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Generic:GetRow)

---

### DProperty_Generic:SetRow · Client · `INTERNAL`
`DProperty_Generic:SetRow(row: Panel)`

Called internally by [DProperties](https://wiki.facepunch.com/gmod/DProperties).

**Arguments:**
- `row` (Panel) — The new row panel.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Generic:SetRow)

---

### DProperty_Generic:Setup · Client
`DProperty_Generic:Setup(data: table)`

Sets up a generic control for use by [DProperties](https://wiki.facepunch.com/gmod/DProperties).

**Arguments:**
- `data` (table) — See Editable Entities.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Generic:Setup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/prop_generic.lua#L41-L75)

---

### DProperty_Generic:ValueChanged · Client
`DProperty_Generic:ValueChanged(newVal: any, force: boolean)`

Called by this control, or a derived control, to alert the row of the change.

**Arguments:**
- `newVal` (any) — The new value.
- `force` (boolean) — Force an update.

[wiki](https://wiki.facepunch.com/gmod/DProperty_Generic:ValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/prop_generic.lua#L31-L39)
