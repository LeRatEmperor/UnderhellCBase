# DNumSlider

**Realm:** Client, Menu  ·  **Members:** 21  ·  **Inherits:** `Panel`

The **DNumSlider** allows you to create a slider, allowing the user to slide it to set a value, or changing the value in the box.

[wiki page](https://wiki.facepunch.com/gmod/DNumSlider)

### DNumSlider:GetDecimals · Client, Menu
`DNumSlider:GetDecimals() → number`

Returns the amount of numbers after the decimal point.

**Returns:**
- number — 0 for whole numbers only, 1 for one number after the decimal point, etc.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetDecimals) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L124-L126)

---

### DNumSlider:GetDefaultValue · Client, Menu
`DNumSlider:GetDefaultValue() → number`

Returns the default value of the slider, if one was set by [DNumSlider:SetDefaultValue](https://wiki.facepunch.com/gmod/DNumSlider:SetDefaultValue)

**Returns:**
- number — The default value of the slider

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetDefaultValue)

---

### DNumSlider:GetMax · Client, Menu
`DNumSlider:GetMax() → number`

Returns the maximum value of the slider

**Returns:**
- number — The maximum value of the slider

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L71-L73)

---

### DNumSlider:GetMin · Client, Menu
`DNumSlider:GetMin() → number`

Returns the minimum value of the slider

**Returns:**
- number — The minimum value of the slider

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetMin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L67-L69)

---

### DNumSlider:GetRange · Client, Menu
`DNumSlider:GetRange() → number`

Returns the range of the slider, basically maximum value - minimum value.

**Returns:**
- number — The range of the slider

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetRange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L75-L77)

---

### DNumSlider:GetTextArea · Client, Menu
`DNumSlider:GetTextArea() → Panel`

Returns the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) component of the slider.

**Returns:**
- Panel — The DTextEntry.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetTextArea) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L190-L194)

---

### DNumSlider:GetValue · Client, Menu
`DNumSlider:GetValue() → number`

Returns the value of the [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider)

**Returns:**
- number — The value of the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:GetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L114-L116)

---

### DNumSlider:IsEditing · Client, Menu
`DNumSlider:IsEditing() → boolean`

Returns true if either the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry), the [DSlider](https://wiki.facepunch.com/gmod/DSlider) or the [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch) are being edited.

**Returns:**
- boolean — Whether or not the DNumSlider is being edited by the player.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L131-L135)

---

### DNumSlider:OnValueChanged · Client, Menu · `hook`
`DNumSlider:OnValueChanged(value: number)`

Called when the value of the slider is changed, through code or changing the slider.

**Arguments:**
- `value` (number) — The new value of the DNumSlider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:OnValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L193-L197)

---

### DNumSlider:ResetToDefaultValue · Client, Menu
`DNumSlider:ResetToDefaultValue()`

Resets the slider to the default value, if one was set by [DNumSlider:SetDefaultValue](https://wiki.facepunch.com/gmod/DNumSlider:SetDefaultValue).

This function is called by the [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider) when user middle mouse clicks on the draggable knob of the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:ResetToDefaultValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L79-L82)

---

### DNumSlider:SetConVar · Client, Menu
`DNumSlider:SetConVar(cvar: string)`

Sets the console variable to be updated when the value of the slider is changed.

**Arguments:**
- `cvar` (string) — The name of the ConVar to be updated.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L149-L152)

---

### DNumSlider:SetDark · Client, Menu
`DNumSlider:SetDark(dark: boolean)`

Calls [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark) on the [DLabel](https://wiki.facepunch.com/gmod/DLabel) part of the [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider).

**Arguments:**
- `dark` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetDark) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L63-L65)

---

### DNumSlider:SetDecimals · Client, Menu
`DNumSlider:SetDecimals(decimals: number)`

Sets the desired amount of numbers after the decimal point.

**Arguments:**
- `decimals` (number) — 0 for whole numbers only, 1 for one number after the decimal point, etc.

> **Note:** This doesn't affect values passed to [DNumSlider:OnValueChanged](https://wiki.facepunch.com/gmod/DNumSlider:OnValueChanged).
> **Note:** To get right values passed to [DNumSlider:OnValueChanged](https://wiki.facepunch.com/gmod/DNumSlider:OnValueChanged) use [math.Round](https://wiki.facepunch.com/gmod/math.Round).

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetDecimals) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L118-L122)

---

### DNumSlider:SetDefaultValue · Client, Menu
`DNumSlider:SetDefaultValue(default: number)`

Sets the default value of the slider, to be used by [DNumSlider:ResetToDefaultValue](https://wiki.facepunch.com/gmod/DNumSlider:ResetToDefaultValue) or by middle mouse clicking the draggable knob of the slider.

**Arguments:**
- `default` (number) — The new default value of the slider to set

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetDefaultValue)

---

### DNumSlider:SetMax · Client, Menu
`DNumSlider:SetMax(max: number)`

Sets the maximum value for the slider.

**Arguments:**
- `max` (number) — The value to set as maximum for the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L93-L100)

---

### DNumSlider:SetMin · Client, Menu
`DNumSlider:SetMin(min: number)`

Sets the minimum value for the slider

**Arguments:**
- `min` (number) — The value to set as minimum for the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetMin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L84-L91)

---

### DNumSlider:SetMinMax · Client, Menu
`DNumSlider:SetMinMax(min: number, max: number)`

Sets the minimum and the maximum value of the slider.

**Arguments:**
- `min` (number) — The minimum value of the slider.
- `max` (number) — The maximum value of the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetMinMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L57-L61)

---

### DNumSlider:SetValue · Client, Menu
`DNumSlider:SetValue(val: number)`

Sets the value of the [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider).

**Arguments:**
- `val` (number) — The value to set.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L102-L112)

---

### DNumSlider:TranslateSliderValues · Client, Menu · `INTERNAL`
`DNumSlider:TranslateSliderValues(x: number, y: number) → number, number`

**Arguments:**
- `x` (number)
- `y` (number)

**Returns:**
- number
- number — The second passed argument.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:TranslateSliderValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L182-L188)

---

### DNumSlider:UpdateNotches · Client, Menu · `INTERNAL`
`DNumSlider:UpdateNotches()`

Updates visual notches on the slider.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:UpdateNotches) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L196-L207)

---

### DNumSlider:ValueChanged · Client, Menu · `INTERNAL`
`DNumSlider:ValueChanged(value: number)`

Called when the value has been changed. This will also be called when the user manually changes the value through the text panel.

This is an internal function. Override [DNumSlider:OnValueChanged](https://wiki.facepunch.com/gmod/DNumSlider:OnValueChanged) instead.

**Arguments:**
- `value` (number) — The value the slider has been changed to.

[wiki](https://wiki.facepunch.com/gmod/DNumSlider:ValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumslider.lua#L162-L174)
