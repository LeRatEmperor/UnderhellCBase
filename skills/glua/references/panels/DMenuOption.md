# DMenuOption

**Realm:** Client, Menu  ·  **Members:** 12  ·  **Inherits:** `DButton`  ·  `INTERNAL`

Internal subpanel that represents an option used by [DMenu](https://wiki.facepunch.com/gmod/DMenu).

[wiki page](https://wiki.facepunch.com/gmod/DMenuOption)

### DMenuOption:AddSubMenu · Client, Menu
`DMenuOption:AddSubMenu() → Panel`

Creates a sub [DMenu](https://wiki.facepunch.com/gmod/DMenu) and returns it. Has no duplicate call protection.

**Returns:**
- Panel — The created DMenu to add options to.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:AddSubMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenuoption.lua#L30-L40)

---

### DMenuOption:GetChecked · Client, Menu
`DMenuOption:GetChecked() → boolean`

Returns the checked state of [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption).

**Returns:**
- boolean — Are we checked or not

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:GetChecked)

---

### DMenuOption:GetIsCheckable · Client, Menu
`DMenuOption:GetIsCheckable() → boolean`

Returns whether the [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption) is a checkbox option or a normal button option.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:GetIsCheckable)

---

### DMenuOption:GetMenu · Client, Menu
`DMenuOption:GetMenu() → Panel`

Returns which [DMenu](https://wiki.facepunch.com/gmod/DMenu) this option belongs.

**Returns:**
- Panel — A DMenu to which this panel belongs.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:GetMenu)

---

### DMenuOption:GetRadio · Client, Menu
`DMenuOption:GetRadio() → boolean`

Returns whether this [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption) should act like a radio button, set by [DMenuOption:SetRadio](https://wiki.facepunch.com/gmod/DMenuOption:SetRadio).

**Returns:**
- `checked` (boolean) — `true` to set as a radio button.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:GetRadio)

---

### DMenuOption:OnChecked · Client, Menu
`DMenuOption:OnChecked(checked: boolean)`

Called whenever the [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption)'s checked state changes.

**Arguments:**
- `checked` (boolean) — The new checked state

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:OnChecked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenuoption.lua#L117-L118)

---

### DMenuOption:SetChecked · Client, Menu
`DMenuOption:SetChecked(checked: boolean)`

Sets the checked state of the [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption).

Invokes [DMenuOption:OnChecked](https://wiki.facepunch.com/gmod/DMenuOption:OnChecked).

**Arguments:**
- `checked` (boolean) — `true` to set as checked.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:SetChecked)

---

### DMenuOption:SetIsCheckable · Client, Menu
`DMenuOption:SetIsCheckable(checkable: boolean)`

Sets whether the [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption) is a checkbox option or a normal button option.

Enables automatic [DMenuOption:GetChecked](https://wiki.facepunch.com/gmod/DMenuOption:GetChecked) toggling with left/right clicks.

**Arguments:**
- `checkable` (boolean) — Whether the menu option should allow the player to toggle itself.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:SetIsCheckable)

---

### DMenuOption:SetMenu · Client, Menu · `INTERNAL`
`DMenuOption:SetMenu(pnl: Panel)`

Used to set the [DMenu](https://wiki.facepunch.com/gmod/DMenu) for this option.

**Arguments:**
- `pnl` (Panel) — The DMenu for this option.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:SetMenu)

---

### DMenuOption:SetRadio · Client, Menu
`DMenuOption:SetRadio(checked: boolean)`

Sets whether this [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption) should act like a radio button.

Checking a radio button automatically unchecks all adjacent radio buttons.

**Arguments:**
- `checked` (boolean) — `true` to set as a radio button.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:SetRadio)

---

### DMenuOption:SetSubMenu · Client, Menu · `INTERNAL`
`DMenuOption:SetSubMenu(menu: Panel)`

Used internally by [DMenuOption:AddSubMenu](https://wiki.facepunch.com/gmod/DMenuOption:AddSubMenu) to create the submenu arrow and assign the created submenu to be opened when this option is hovered.

**Arguments:**
- `menu` (Panel) — The sub DMenu this option belongs to.

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:SetSubMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenuoption.lua#L17-L28)

---

### DMenuOption:ToggleCheck · Client, Menu
`DMenuOption:ToggleCheck()`

Toggles the checked state of [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption). Does not respect [DMenuOption:GetIsCheckable](https://wiki.facepunch.com/gmod/DMenuOption:GetIsCheckable).

[wiki](https://wiki.facepunch.com/gmod/DMenuOption:ToggleCheck) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenuoption.lua#L110-L115)
