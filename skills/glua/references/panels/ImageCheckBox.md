# ImageCheckBox

**Realm:** Client  ·  **Members:** 4  ·  **Inherits:** `Button`

A checkbox panel similar to [DCheckBox](https://wiki.facepunch.com/gmod/DCheckBox) and [DImageButton](https://wiki.facepunch.com/gmod/DImageButton) with customizable checked state image.

Uses the [Material](https://wiki.facepunch.com/gmod/Material) panel internally. Can't have a label.

> **Note:** Will error if no material was set.

[wiki page](https://wiki.facepunch.com/gmod/ImageCheckBox)

### ImageCheckBox:GetChecked · Client
`ImageCheckBox:GetChecked() → boolean`

Returns the checked state of the [ImageCheckBox](https://wiki.facepunch.com/gmod/ImageCheckBox)

**Returns:**
- boolean — true for checked, false otherwise

[wiki](https://wiki.facepunch.com/gmod/ImageCheckBox:GetChecked)

---

### ImageCheckBox:Set · Client
`ImageCheckBox:Set(OnOff: boolean)`

Sets the checked state of the checkbox.

Checked state can be obtained by [ImageCheckBox](https://wiki.facepunch.com/gmod/ImageCheckBox).State.

**Arguments:**
- `OnOff` (boolean) — true for checked, false otherwise

[wiki](https://wiki.facepunch.com/gmod/ImageCheckBox:Set) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/imagecheckbox.lua#L32-L36)

---

### ImageCheckBox:SetChecked · Client
`ImageCheckBox:SetChecked(bOn: boolean)`

Sets the checked state of the checkbox.

Checked state can be obtained via [ImageCheckBox:GetChecked](https://wiki.facepunch.com/gmod/ImageCheckBox:GetChecked)

**Arguments:**
- `bOn` (boolean) — true for checked, false otherwise

[wiki](https://wiki.facepunch.com/gmod/ImageCheckBox:SetChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/imagecheckbox.lua#L18-L24)

---

### ImageCheckBox:SetMaterial · Client
`ImageCheckBox:SetMaterial(mat: string)`

Sets the material that will be visible when the [ImageCheckBox](https://wiki.facepunch.com/gmod/ImageCheckBox) is checked.

Internally calls [Material:SetMaterial](https://wiki.facepunch.com/gmod/Material:SetMaterial).

**Arguments:**
- `mat` (string) — The file path of the material to set (relative to "garrysmod/materials/").

> **Note:** Will error if no material was set.

[wiki](https://wiki.facepunch.com/gmod/ImageCheckBox:SetMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/imagecheckbox.lua#L4-L16)
