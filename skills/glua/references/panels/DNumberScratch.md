# DNumberScratch

**Realm:** Client, Menu  ·  **Members:** 27  ·  **Inherits:** `DImageButton`

Choose a number from a number line, with zooming for precision.
		Zoom in by moving your mouse forward and moving back does the opposite. Looks like a blue circle until you click and hold on it

[wiki page](https://wiki.facepunch.com/gmod/DNumberScratch)

### DNumberScratch:DrawNotches · Client, Menu · `INTERNAL`
`DNumberScratch:DrawNotches(level: number, x: number, y: number, w: number, h: number, range: number, value: number, min: number, max: number)`

Used by [DNumberScratch:DrawScreen](https://wiki.facepunch.com/gmod/DNumberScratch:DrawScreen).

**Arguments:**
- `level` (number)
- `x` (number)
- `y` (number)
- `w` (number)
- `h` (number)
- `range` (number)
- `value` (number)
- `min` (number)
- `max` (number)

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:DrawNotches) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L166-L249)

---

### DNumberScratch:DrawScreen · Client, Menu · `INTERNAL`
`DNumberScratch:DrawScreen(x: number, y: number, w: number, h: number)`

Used by [DNumberScratch:PaintScratchWindow](https://wiki.facepunch.com/gmod/DNumberScratch:PaintScratchWindow).

**Arguments:**
- `x` (number)
- `y` (number)
- `w` (number)
- `h` (number)

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:DrawScreen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L263-L322)

---

### DNumberScratch:GetActive · Client, Menu
`DNumberScratch:GetActive() → boolean`

Returns whether this panel is active or not, i.e. if the player is currently changing its value.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetActive)

---

### DNumberScratch:GetDecimals · Client, Menu
`DNumberScratch:GetDecimals() → number`

Returns the desired amount of numbers after the decimal point.

**Returns:**
- number — 0 for whole numbers only, 1 for one number after the decimal point, etc.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetDecimals) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L64-L68)

---

### DNumberScratch:GetFloatValue · Client, Menu
`DNumberScratch:GetFloatValue() → number`

Returns the real value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) as a number.

See also [DNumberScratch:GetTextValue](https://wiki.facepunch.com/gmod/DNumberScratch:GetTextValue) and [DNumberScratch:GetFraction](https://wiki.facepunch.com/gmod/DNumberScratch:GetFraction).

**Returns:**
- number — The real value of the DNumberScratch

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetFloatValue)

---

### DNumberScratch:GetFraction · Client, Menu
`DNumberScratch:GetFraction() → number`

Returns the value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) as a fraction, a value between 0 and 1 where 0 is the minimum and 1 is the maximum value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch).

See also:
* [DNumberScratch:GetTextValue](https://wiki.facepunch.com/gmod/DNumberScratch:GetTextValue)
* [DNumberScratch:GetFloatValue](https://wiki.facepunch.com/gmod/DNumberScratch:GetFloatValue)
* [DNumberScratch:SetFraction](https://wiki.facepunch.com/gmod/DNumberScratch:SetFraction)

**Returns:**
- number — A value between 0 and 1

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetFraction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L58-L62)

---

### DNumberScratch:GetMax · Client, Menu
`DNumberScratch:GetMax() → number`

Returns the maximum value that can be selected on the number scratch

**Returns:**
- number — The maximum value that can be selected on the number scratch

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetMax)

---

### DNumberScratch:GetMin · Client, Menu
`DNumberScratch:GetMin() → number`

Returns the minimum value that can be selected on the number scratch

**Returns:**
- number — The minimum value that can be selected on the number scratch

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetMin)

---

### DNumberScratch:GetRange · Client, Menu
`DNumberScratch:GetRange() → number`

Returns the range of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch). Basically max value - min value.

**Returns:**
- number — The range of the DNumberScratch

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetRange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L70-L72)

---

### DNumberScratch:GetShouldDrawScreen · Client, Menu
`DNumberScratch:GetShouldDrawScreen() → boolean`

Returns whether the scratch window should be visible or not.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetShouldDrawScreen)

---

### DNumberScratch:GetTextValue · Client, Menu
`DNumberScratch:GetTextValue() → string`

Returns the real value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) as a string.

See also [DNumberScratch:GetFloatValue](https://wiki.facepunch.com/gmod/DNumberScratch:GetFloatValue) and [DNumberScratch:GetFraction](https://wiki.facepunch.com/gmod/DNumberScratch:GetFraction).

**Returns:**
- string — The real value of the DNumberScratch

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetTextValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L149-L158)

---

### DNumberScratch:GetZoom · Client, Menu
`DNumberScratch:GetZoom() → number`

Returns the zoom level of the scratch window

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:GetZoom)

---

### DNumberScratch:IdealZoom · Client, Menu
`DNumberScratch:IdealZoom() → number`

Returns the ideal zoom level for the panel based on the [DNumberScratch:GetRange](https://wiki.facepunch.com/gmod/DNumberScratch:GetRange).

**Returns:**
- number — The ideal zoom level for the panel based on the panels range.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:IdealZoom) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L74-L78)

---

### DNumberScratch:IsEditing · Client, Menu
`DNumberScratch:IsEditing() → boolean`

Returns whether the player is currently editing the value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L259-L261)

---

### DNumberScratch:LockCursor · Client, Menu · `INTERNAL`
`DNumberScratch:LockCursor()`

Used to lock the cursor in place.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:LockCursor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L114-L119)

---

### DNumberScratch:OnValueChanged · Client, Menu · `hook`
`DNumberScratch:OnValueChanged(newValue: number)`

Called when the value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) is changed.

**Arguments:**
- `newValue` (number) — The new value

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:OnValueChanged)

---

### DNumberScratch:PaintScratchWindow · Client, Menu · `INTERNAL`
`DNumberScratch:PaintScratchWindow()`

Used to paint the 'scratch' window.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:PaintScratchWindow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L324-L345)

---

### DNumberScratch:SetActive · Client, Menu · `INTERNAL`
`DNumberScratch:SetActive(active: boolean)`

Sets whether or not the panel is 'active'.

Forcing this panel to be active may not work.

**Arguments:**
- `active` (boolean) — true to activate, false to deactivate.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetActive)

---

### DNumberScratch:SetDecimals · Client, Menu
`DNumberScratch:SetDecimals(decimals: number)`

Sets the desired amount of numbers after the decimal point.

**Arguments:**
- `decimals` (number) — 0 for whole numbers only, 1 for one number after the decimal point, etc.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetDecimals)

---

### DNumberScratch:SetFloatValue · Client, Menu · `INTERNAL`
`DNumberScratch:SetFloatValue(val: number)`

Does not trigger [DNumberScratch:OnValueChanged](https://wiki.facepunch.com/gmod/DNumberScratch:OnValueChanged)

Use [DNumberScratch:SetValue](https://wiki.facepunch.com/gmod/DNumberScratch:SetValue) instead.

**Arguments:**
- `val` (number) — The value to set

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetFloatValue)

---

### DNumberScratch:SetFraction · Client, Menu
`DNumberScratch:SetFraction(frac: number)`

Sets the value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) as a fraction, a value between 0 and 1 where 0 is the minimum and 1 is the maximum value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch)

**Arguments:**
- `frac` (number) — A value between 0 and 1

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetFraction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L52-L56)

---

### DNumberScratch:SetMax · Client, Menu
`DNumberScratch:SetMax(max: number)`

Sets the max value that can be selected on the number scratch

**Arguments:**
- `max` (number) — The maximum number

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetMax)

---

### DNumberScratch:SetMin · Client, Menu
`DNumberScratch:SetMin(min: number)`

Sets the minimum value that can be selected on the number scratch.

**Arguments:**
- `min` (number) — The minimum number

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetMin)

---

### DNumberScratch:SetShouldDrawScreen · Client, Menu · `INTERNAL`
`DNumberScratch:SetShouldDrawScreen(shouldDraw: boolean)`

Sets if the scratch window should be drawn or not. Cannot be used to force it to draw, only to hide it, which will not stop the panel from working with invisible window.

**Arguments:**
- `shouldDraw` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetShouldDrawScreen)

---

### DNumberScratch:SetValue · Client, Menu
`DNumberScratch:SetValue(val: number)`

Sets the value of the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) and triggers [DNumberScratch:OnValueChanged](https://wiki.facepunch.com/gmod/DNumberScratch:OnValueChanged)

**Arguments:**
- `val` (number) — The value to set.

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L40-L50)

---

### DNumberScratch:SetZoom · Client, Menu
`DNumberScratch:SetZoom(zoom: number)`

Sets the zoom level of the scratch panel.

**Arguments:**
- `zoom` (number)

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:SetZoom)

---

### DNumberScratch:UpdateConVar · Client, Menu · `INTERNAL`
`DNumberScratch:UpdateConVar()`

Forces the assigned ConVar to be updated to the value of this [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch)

[wiki](https://wiki.facepunch.com/gmod/DNumberScratch:UpdateConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberscratch.lua#L160-L164)
