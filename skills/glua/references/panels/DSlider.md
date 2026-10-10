# DSlider

**Realm:** Client, Menu  ·  **Members:** 30  ·  **Inherits:** `Panel`

Creates a slider that can be moved along the X and/or Y axis

[wiki page](https://wiki.facepunch.com/gmod/DSlider)

### DSlider:ConVarXNumberThink · Client, Menu · `INTERNAL`
`DSlider:ConVarXNumberThink()`

Used internally to set the X axis convar.

[wiki](https://wiki.facepunch.com/gmod/DSlider:ConVarXNumberThink)

---

### DSlider:ConVarYNumberThink · Client, Menu · `INTERNAL`
`DSlider:ConVarYNumberThink()`

Used internally to set the Y axis convar.

[wiki](https://wiki.facepunch.com/gmod/DSlider:ConVarYNumberThink)

---

### DSlider:GetDragging · Client, Menu
`DSlider:GetDragging() → boolean`

Identical to [DSlider:IsEditing](https://wiki.facepunch.com/gmod/DSlider:IsEditing)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L171-L173)

---

### DSlider:GetLockX · Client, Menu
`DSlider:GetLockX() → number`

Returns the draggable panel's lock on the X axis.

See [DSlider:SetLockX](https://wiki.facepunch.com/gmod/DSlider:SetLockX) for more info.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetLockX)

---

### DSlider:GetLockY · Client, Menu
`DSlider:GetLockY() → number`

Returns the draggable panel's lock on the Y axis.

See [DSlider:SetLockY](https://wiki.facepunch.com/gmod/DSlider:SetLockY) for more info.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetLockY)

---

### DSlider:GetNotchColor · Client, Menu · `DEPRECATED`
`DSlider:GetNotchColor() → Color`

Returns the current notch color, set by [DSlider:SetNotchColor](https://wiki.facepunch.com/gmod/DSlider:SetNotchColor)

**Returns:**
- `clr` (Color) — The current color

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetNotchColor)

---

### DSlider:GetNotches · Client, Menu · `DEPRECATED`
`DSlider:GetNotches() → number`

Appears to be non functioning, however is still used by panels such as [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetNotches)

---

### DSlider:GetNumSlider · Client, Menu · `DEPRECATED`
`DSlider:GetNumSlider() → any`

Does nothing.

**Returns:**
- any

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetNumSlider)

---

### DSlider:GetSlideX · Client, Menu
`DSlider:GetSlideX() → number`

Returns the target position of the draggable "knob" panel of the slider on the X axis.

Set by [DSlider:SetSlideX](https://wiki.facepunch.com/gmod/DSlider:SetSlideX).

**Returns:**
- number — The value range seems to be from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetSlideX)

---

### DSlider:GetSlideY · Client, Menu
`DSlider:GetSlideY() → number`

Returns the target position of the draggable "knob" panel of the slider on the Y axis.

Set by [DSlider:SetSlideY](https://wiki.facepunch.com/gmod/DSlider:SetSlideY).

**Returns:**
- number — The value range seems to be from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetSlideY)

---

### DSlider:GetTrapInside · Client, Menu
`DSlider:GetTrapInside() → boolean`

Returns the value set by [DSlider:SetTrapInside](https://wiki.facepunch.com/gmod/DSlider:SetTrapInside).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DSlider:GetTrapInside)

---

### DSlider:IsEditing · Client, Menu
`DSlider:IsEditing() → boolean`

Returns true if this element is being edited by the player.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DSlider:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L43-L47)

---

### DSlider:OnValueChanged · Client, Menu · `hook`
`DSlider:OnValueChanged(x: number, y: number)`

Called when the values of this slider panel were changed.

**Arguments:**
- `x` (number) — The X axis position of the slider in range 0-1
- `y` (number) — The Y axis position of the slider in range 0-1

[wiki](https://wiki.facepunch.com/gmod/DSlider:OnValueChanged)

---

### DSlider:OnValuesChangedInternal · Client, Menu · `INTERNAL`
`DSlider:OnValuesChangedInternal()`

Used internally to fire [DSlider:OnValueChanged](https://wiki.facepunch.com/gmod/DSlider:OnValueChanged)

[wiki](https://wiki.facepunch.com/gmod/DSlider:OnValuesChangedInternal)

---

### DSlider:ResetToDefaultValue · Client, Menu · `hook`
`DSlider:ResetToDefaultValue()`

This function is called by the [DSlider](https://wiki.facepunch.com/gmod/DSlider) when user middle mouse clicks on the draggable knob of the slider.

You are meant to override this function to do reset the slider to desired defaults on both axes.

By default, will reset the slider to `0.5` on both axes.

[wiki](https://wiki.facepunch.com/gmod/DSlider:ResetToDefaultValue)

---

### DSlider:SetBackground · Client, Menu
`DSlider:SetBackground(path: string)`

Sets the background for the slider.

**Arguments:**
- `path` (string) — Path to the image.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L49-L58)

---

### DSlider:SetConVarX · Client, Menu
`DSlider:SetConVarX(convar: string)`

Sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) to be set when the slider changes on the X axis.

**Arguments:**
- `convar` (string) — Name of the convar to set.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetConVarX)

---

### DSlider:SetConVarY · Client, Menu
`DSlider:SetConVarY(convar: string)`

Sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) to be set when the slider changes on the Y axis.

**Arguments:**
- `convar` (string) — Name of the convar to set.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetConVarY)

---

### DSlider:SetDragging · Client, Menu · `INTERNAL`
`DSlider:SetDragging(dragging: boolean)`

Sets whether or not the slider is being dragged.

**Arguments:**
- `dragging` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetDragging)

---

### DSlider:SetImage · Client, Menu · `DEPRECATED`
`DSlider:SetImage()`

Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L60-L62)

---

### DSlider:SetImageColor · Client, Menu · `DEPRECATED`
`DSlider:SetImageColor()`

Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetImageColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L64-L66)

---

### DSlider:SetLockX · Client, Menu
`DSlider:SetLockX(lockX: number = nil)`

Sets the lock on the X axis. 

For example the value 0.5 will lock the draggable panel to half the width of the slider's panel.

**Arguments:**
- `lockX` (number, default `nil`) — Set to nil to reset lock.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetLockX)

---

### DSlider:SetLockY · Client, Menu
`DSlider:SetLockY(lockY: number = nil)`

Sets the lock on the Y axis. 

For example the value 0.5 will lock the draggable panel to half the height of the slider's panel.

**Arguments:**
- `lockY` (number, default `nil`) — Set to nil to reset lock.

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetLockY)

---

### DSlider:SetNotchColor · Client, Menu · `DEPRECATED`
`DSlider:SetNotchColor(clr: Color)`

Sets the current notch color, overriding the color set by the derma skin.

**Arguments:**
- `clr` (Color) — The new color to set

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetNotchColor)

---

### DSlider:SetNotches · Client, Menu · `DEPRECATED`
`DSlider:SetNotches(notches: number)`

Appears to be non functioning, however is still used by panels such as [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider).

**Arguments:**
- `notches` (number)

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetNotches)

---

### DSlider:SetNumSlider · Client, Menu · `DEPRECATED`
`DSlider:SetNumSlider(slider: any)`

Does nothing.

**Arguments:**
- `slider` (any)

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetNumSlider)

---

### DSlider:SetSlideX · Client, Menu
`DSlider:SetSlideX(x: number)`

Used to position the draggable panel of the slider on the X axis.

**Arguments:**
- `x` (number) — The value range seems to be from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetSlideX) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L161-L164)

---

### DSlider:SetSlideY · Client, Menu
`DSlider:SetSlideY(y: number)`

Used to position the draggable panel of the slider on the Y axis.

**Arguments:**
- `y` (number) — The value range seems to be from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetSlideY) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dslider.lua#L166-L169)

---

### DSlider:SetTrapInside · Client, Menu
`DSlider:SetTrapInside(trap: boolean)`

Makes the slider itself, the "knob", trapped within the bounds of the slider panel. Example:

**Arguments:**
- `trap` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DSlider:SetTrapInside)

---

### DSlider:TranslateValues · Client, Menu · `hook`
`DSlider:TranslateValues(x: number, y: number) → number, number`

For override by child panels, such as [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider). Allows changing the output values of the slider.

**Arguments:**
- `x` (number) — The input X coordinate, in range of 0-1.
- `y` (number) — The input Y coordinate, in range of 0-1.

**Returns:**
- number — The output X coordinate, in range of 0-1.
- number — The output X coordinate, in range of 0-1.

[wiki](https://wiki.facepunch.com/gmod/DSlider:TranslateValues)
