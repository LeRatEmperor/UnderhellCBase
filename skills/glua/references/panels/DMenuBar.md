# DMenuBar

**Realm:** Client, Menu  ·  **Members:** 9  ·  **Inherits:** `DPanel`

A simple menu bar.

[wiki page](https://wiki.facepunch.com/gmod/DMenuBar)

### DMenuBar:AddMenu · Client, Menu
`DMenuBar:AddMenu(label: string) → Panel`

Creates a new [DMenu](https://wiki.facepunch.com/gmod/DMenu) object tied to a [DButton](https://wiki.facepunch.com/gmod/DButton) with the given label on the menu bar.

This will create a new menu regardless of whether or not one with the same label exists. To add **or** get a menu, use [DMenuBar:AddOrGetMenu](https://wiki.facepunch.com/gmod/DMenuBar:AddOrGetMenu).

**Arguments:**
- `label` (string) — The name (label) of the derma menu to create.

**Returns:**
- Panel — The new DMenu which will be opened when the button is clicked.

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:AddMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenubar.lua#L36-L72)

---

### DMenuBar:AddOrGetMenu · Client, Menu
`DMenuBar:AddOrGetMenu(label: string) → Panel`

Retrieves a [DMenu](https://wiki.facepunch.com/gmod/DMenu) object from the menu bar. If one with the given label doesn't exist, a new one is created.

To add a DMenu without checking, use [DMenuBar:AddMenu](https://wiki.facepunch.com/gmod/DMenuBar:AddMenu).

**Arguments:**
- `label` (string) — The name (label) of the derma menu to get or create.

**Returns:**
- Panel — The DMenu with the given label.

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:AddOrGetMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenubar.lua#L29-L34)

---

### DMenuBar:GetDrawBackground · Client, Menu · `DEPRECATED`
`DMenuBar:GetDrawBackground() → boolean`

Returns whether or not the background should be painted. Is the same as [DMenuBar:GetPaintBackground](https://wiki.facepunch.com/gmod/DMenuBar:GetPaintBackground)

**Returns:**
- boolean — Should the background be painted

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:GetDrawBackground)

---

### DMenuBar:GetIsMenu · Client, Menu
`DMenuBar:GetIsMenu() → boolean`

Returns whether or not the panel is a menu. Used for closing menus when another panel is selected.

**Returns:**
- boolean — Is a menu

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:GetIsMenu)

---

### DMenuBar:GetOpenMenu · Client, Menu
`DMenuBar:GetOpenMenu() → Panel`

If a menu is visible/opened, then the menu is returned.

**Returns:**
- Panel — Returns the visible/open menu or nil.

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:GetOpenMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenubar.lua#L19-L27)

---

### DMenuBar:GetPaintBackground · Client, Menu
`DMenuBar:GetPaintBackground() → boolean`

Returns whether or not the background should be painted. Is the same as [DMenuBar:GetDrawBackground](https://wiki.facepunch.com/gmod/DMenuBar:GetDrawBackground)

**Returns:**
- boolean — Should the background be painted

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:GetPaintBackground)

---

### DMenuBar:SetDrawBackground · Client, Menu · `DEPRECATED`
`DMenuBar:SetDrawBackground(shouldPaint: boolean)`

Sets whether or not the background should be painted. Is the same as [DMenuBar:SetPaintBackground](https://wiki.facepunch.com/gmod/DMenuBar:SetPaintBackground)

**Arguments:**
- `shouldPaint` (boolean) — Should the background be painted

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:SetDrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DMenuBar:SetIsMenu · Client, Menu
`DMenuBar:SetIsMenu(isMenu: boolean)`

Sets whether or not the panel is part of a DMenu.

If this is set to `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the panel is clicked, and thus any open menus will remain open.

**Arguments:**
- `isMenu` (boolean) — Is this a menu

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:SetIsMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DMenuBar:SetPaintBackground · Client, Menu
`DMenuBar:SetPaintBackground(shouldPaint: boolean)`

Sets whether or not the background should be painted. Is the same as [DMenuBar:SetDrawBackground](https://wiki.facepunch.com/gmod/DMenuBar:SetDrawBackground)

**Arguments:**
- `shouldPaint` (boolean) — Should the background be painted

[wiki](https://wiki.facepunch.com/gmod/DMenuBar:SetPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)
