# DIconLayout

**Realm:** Client, Menu  ·  **Members:** 18  ·  **Inherits:** `DDragBase`

DIconLayout is what replaced [DPanelList](https://wiki.facepunch.com/gmod/DPanelList) in Garry's Mod 13. 
		DPanelList still exists in GMod but is deprecated and does not support the new GWEN skin.

		[DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout) is used to make a list of panels. 
		Unlike DPanelList, DIconLayout does not automatically add a scroll bar - the example below shows you how you can do this.

[wiki page](https://wiki.facepunch.com/gmod/DIconLayout)

### DIconLayout:Copy · Client, Menu
`DIconLayout:Copy() → Panel`

Creates a replica of the DIconLayout it is called on.

**Returns:**
- Panel — The replica.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconlayout.lua#L155-L172)

---

### DIconLayout:CopyContents · Client, Menu
`DIconLayout:CopyContents(from: Panel)`

Copies the contents (Child elements) of another [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout) to itself.

**Arguments:**
- `from` (Panel) — DIconLayout to copy from.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:CopyContents) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconlayout.lua#L174-L182)

---

### DIconLayout:GetBorder · Client, Menu
`DIconLayout:GetBorder() → number`

Returns the size of the border.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetBorder)

---

### DIconLayout:GetLayoutDir · Client, Menu
`DIconLayout:GetLayoutDir() → number`

Returns the direction that it will be layed out, using the DOCK enumerations.

**Returns:**
- number — Layout direction.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetLayoutDir)

---

### DIconLayout:GetSpaceX · Client, Menu
`DIconLayout:GetSpaceX() → number`

Returns the distance between two 'icons' on the X axis.

**Returns:**
- number — Distance between two 'icons' on the X axis.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetSpaceX)

---

### DIconLayout:GetSpaceY · Client, Menu
`DIconLayout:GetSpaceY() → number`

Returns distance between two "Icons" on the Y axis.

**Returns:**
- number — distance between two "Icons" on the Y axis.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetSpaceY)

---

### DIconLayout:GetStretchHeight · Client, Menu
`DIconLayout:GetStretchHeight() → boolean`

Returns whether the icon layout will stretch its height to fit all the children.

See also [DIconLayout:GetStretchWidth](https://wiki.facepunch.com/gmod/DIconLayout:GetStretchWidth)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetStretchHeight)

---

### DIconLayout:GetStretchWidth · Client, Menu
`DIconLayout:GetStretchWidth() → boolean`

Returns whether the icon layout will stretch its width to fit all the children.

See also [DIconLayout:GetStretchHeight](https://wiki.facepunch.com/gmod/DIconLayout:GetStretchHeight)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:GetStretchWidth)

---

### DIconLayout:Layout · Client, Menu
`DIconLayout:Layout()`

Resets layout vars before calling [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout). This is called when children are added or removed, and must be called when the spacing, border or layout direction is changed.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:Layout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconlayout.lua#L29-L35)

---

### DIconLayout:LayoutIcons_LEFT · Client, Menu · `INTERNAL`
`DIconLayout:LayoutIcons_LEFT()`

Used internally to layout the child elements if the [DIconLayout:SetLayoutDir](https://wiki.facepunch.com/gmod/DIconLayout:SetLayoutDir) is set to LEFT (See [DOCK](https://wiki.facepunch.com/gmod/Enums/DOCK)).

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:LayoutIcons_LEFT) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconlayout.lua#L72-L105)

---

### DIconLayout:LayoutIcons_TOP · Client, Menu · `INTERNAL`
`DIconLayout:LayoutIcons_TOP()`

Used internally to layout the child elements if the [DIconLayout:SetLayoutDir](https://wiki.facepunch.com/gmod/DIconLayout:SetLayoutDir) is set to TOP (See [DOCK](https://wiki.facepunch.com/gmod/Enums/DOCK)).

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:LayoutIcons_TOP) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconlayout.lua#L37-L70)

---

### DIconLayout:OnModified · Client, Menu · `hook`
`DIconLayout:OnModified()`

Called when the panel is modified.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:OnModified)

---

### DIconLayout:SetBorder · Client, Menu
`DIconLayout:SetBorder(width: number)`

Sets the internal border (padding) within the DIconLayout. This will not change its size, only the positioning of children. You must call [DIconLayout:Layout](https://wiki.facepunch.com/gmod/DIconLayout:Layout) in order for the changes to take effect.

**Arguments:**
- `width` (number) — The border (padding) inside the DIconLayout.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetBorder)

---

### DIconLayout:SetLayoutDir · Client, Menu
`DIconLayout:SetLayoutDir(direction: number)`

Sets the direction that it will be layed out, using the [DOCK](https://wiki.facepunch.com/gmod/Enums/DOCK).

Currently only TOP and LEFT are supported.

**Arguments:**
- `direction` (number, enum [DOCK](https://wiki.facepunch.com/gmod/Enums/DOCK)) — DOCK

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetLayoutDir)

---

### DIconLayout:SetSpaceX · Client, Menu
`DIconLayout:SetSpaceX(xSpacing: number)`

Sets the horizontal (x) spacing between children within the DIconLayout. You must call [DIconLayout:Layout](https://wiki.facepunch.com/gmod/DIconLayout:Layout) in order for the changes to take effect.

**Arguments:**
- `xSpacing` (number) — The width of the gap between child objects.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetSpaceX)

---

### DIconLayout:SetSpaceY · Client, Menu
`DIconLayout:SetSpaceY(ySpacing: number)`

Sets the vertical (y) spacing between children within the DIconLayout. You must call [DIconLayout:Layout](https://wiki.facepunch.com/gmod/DIconLayout:Layout) in order for the changes to take effect.

**Arguments:**
- `ySpacing` (number) — The vertical gap between rows in the DIconLayout.

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetSpaceY)

---

### DIconLayout:SetStretchHeight · Client, Menu
`DIconLayout:SetStretchHeight(do_stretch: boolean)`

If set to true, the icon layout will stretch its height to fit all the children.

See also [DIconLayout:SetStretchWidth](https://wiki.facepunch.com/gmod/DIconLayout:SetStretchWidth)

**Arguments:**
- `do_stretch` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetStretchHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DIconLayout:SetStretchWidth · Client, Menu
`DIconLayout:SetStretchWidth(stretchW: boolean)`

If set to true, the icon layout will stretch its width to fit all the children.

See also [DIconLayout:SetStretchHeight](https://wiki.facepunch.com/gmod/DIconLayout:SetStretchHeight)

**Arguments:**
- `stretchW` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DIconLayout:SetStretchWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)
