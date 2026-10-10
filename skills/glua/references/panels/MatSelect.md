# MatSelect

**Realm:** Client  ·  **Members:** 13  ·  **Inherits:** `ContextBase`

The panel used by Material & Lamp Sandbox tools for texture selection. Despite being only used in Sandbox, it is **not** exclusive to that gamemode.

See also [PropSelect](https://wiki.facepunch.com/gmod/PropSelect) for the prop selecting alternative.

[wiki page](https://wiki.facepunch.com/gmod/MatSelect)

### MatSelect:AddMaterial · Client
`MatSelect:AddMaterial(label: string, path: string)`

Adds a new material to the selection list.

**Arguments:**
- `label` (string) — Tooltip for the material, for when the player hovers over the material.
- `path` (string) — Path to the material.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:AddMaterial)

---

### MatSelect:AddMaterialEx · Client
`MatSelect:AddMaterialEx(label: string, path: string, value: any, convars: table)`

Adds a new material to the selection list, with some extra options.

**Arguments:**
- `label` (string) — Tooltip for the material, for when the player hovers over the material.
- `path` (string) — Path to the material.
- `value` (any) — Overrides the "value" of the material.
- `convars` (table) — A list of convar names (as keys) and their values to set when the user selects this material.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:AddMaterialEx)

---

### MatSelect:FindAndSelectMaterial · Client
`MatSelect:FindAndSelectMaterial(mat: string)`

Find a material and selects it, if it exists in this panel.

**Arguments:**
- `mat` (string) — The material to find and select within this MatSelect.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:FindAndSelectMaterial)

---

### MatSelect:FindMaterialByValue · Client
`MatSelect:FindMaterialByValue(mat: string) → DImageButton`

Find a [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) panel based on the input material path.

**Arguments:**
- `mat` (string) — The material to find within this MatSelect.

**Returns:**
- DImageButton — The found material, or nil.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:FindMaterialByValue)

---

### MatSelect:GetAutoHeight · Client
`MatSelect:GetAutoHeight() → boolean`

Returns whether the panel would set its own height to fit all materials within its height.

**Returns:**
- `autoSize` (boolean) — `true` = auto size itself.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:GetAutoHeight)

---

### MatSelect:OnRightClick · Client · `hook`
`MatSelect:OnRightClick(pnl: Panel)`

Called when the player right clicks a material.

By default, this opens a menu that lets the player copy the material path.

**Arguments:**
- `pnl` (Panel) — The DImageButton that was clicked.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:OnRightClick)

---

### MatSelect:OnSelect · Client · `hook`
`MatSelect:OnSelect(material: string, pnl: Panel)`

Called when the player selects a material.

**Arguments:**
- `material` (string) — Material path of the selected material, not including any file extension.
- `pnl` (Panel) — The DImageButton that was clicked.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:OnSelect)

---

### MatSelect:SelectedItemPaintOver · Client · `hook`
`MatSelect:SelectedItemPaintOver(w: number, h: number)`

Defines a paint over function for a [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) when it is selected.

**Arguments:**
- `w` (number) — Width of the DImageButton panel.
- `h` (number) — Height of the DImageButton panel.

> **Warning:** `self` in the context of this function is the [DImageButton](https://wiki.facepunch.com/gmod/DImageButton)!

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SelectedItemPaintOver)

---

### MatSelect:SelectMaterial · Client · `INTERNAL`
`MatSelect:SelectMaterial(mat: DImageButton)`

Selects a given material panel.

**Arguments:**
- `mat` (DImageButton) — The material to select, found by MatSelect:FindMaterialByValue

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SelectMaterial)

---

### MatSelect:SetAutoHeight · Client
`MatSelect:SetAutoHeight(autoSize: boolean)`

Sets whether the panel should set its own height to fit all materials within its height.

**Arguments:**
- `autoSize` (boolean) — If `true`, auto size itself.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SetAutoHeight)

---

### MatSelect:SetItemHeight · Client
`MatSelect:SetItemHeight(height : number)`

Sets the height of a single material in pixels.

**Arguments:**
- `height ` (number) — The height of the material, in pixels.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SetItemHeight)

---

### MatSelect:SetItemWidth · Client
`MatSelect:SetItemWidth(width: number)`

Sets the width of a single material in pixels.

**Arguments:**
- `width` (number) — The width of the material, in pixels.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SetItemWidth)

---

### MatSelect:SetNumRows · Client
`MatSelect:SetNumRows(rows: number)`

Sets the target height of the panel, in number of rows.

**Arguments:**
- `rows` (number) — Amount of rows to target the height to.

[wiki](https://wiki.facepunch.com/gmod/MatSelect:SetNumRows)
