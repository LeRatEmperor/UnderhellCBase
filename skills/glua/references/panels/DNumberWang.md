# DNumberWang

**Realm:** Client, Menu  ·  **Members:** 18  ·  **Inherits:** `DTextEntry`

DNumberWang is a VGUI element that allows you to input a numeric value using up and down arrows or direct entry.

[wiki page](https://wiki.facepunch.com/gmod/DNumberWang)

### DNumberWang:GetDecimals · Client, Menu
`DNumberWang:GetDecimals() → number`

Returns the amount of decimal places allowed in the number selector, set by [DNumberWang:SetDecimals](https://wiki.facepunch.com/gmod/DNumberWang:SetDecimals)

**Returns:**
- number — The amount of decimal places allowed in the number selector.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetDecimals)

---

### DNumberWang:GetFloatValue · Client, Menu · `DEPRECATED`
`DNumberWang:GetFloatValue() → number`

Returns whatever is set by [DNumberWang:SetFloatValue](https://wiki.facepunch.com/gmod/DNumberWang:SetFloatValue) or 0.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetFloatValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L114-L120)

---

### DNumberWang:GetFraction · Client, Menu
`DNumberWang:GetFraction(val: number)`

Returns a fraction representing the current number selector value to number selector min/max range ratio. If argument `val` is supplied, that number will be computed instead.

**Arguments:**
- `val` (number) — The fraction numerator.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetFraction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L218-L225)

---

### DNumberWang:GetInterval · Client, Menu
`DNumberWang:GetInterval() → number`

Returns interval at which the up and down buttons change the current value.

**Returns:**
- `min` (number) — The current interval.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetInterval)

---

### DNumberWang:GetMax · Client, Menu
`DNumberWang:GetMax() → number`

Returns the maximum numeric value allowed by the number selector.

**Returns:**
- number — The maximum value.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetMax)

---

### DNumberWang:GetMin · Client, Menu
`DNumberWang:GetMin() → number`

Returns the minimum numeric value allowed by the number selector.

**Returns:**
- number — The minimum number.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetMin)

---

### DNumberWang:GetTextArea · Client, Menu · `DEPRECATED`
`DNumberWang:GetTextArea() → Panel`

This function returns the panel it is used on.

**Returns:**
- Panel — self

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetTextArea) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L238-L242)

---

### DNumberWang:GetValue · Client, Menu
`DNumberWang:GetValue() → number`

Returns the numeric value inside the number selector.

**Returns:**
- number — The numeric value.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:GetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L171-L175)

---

### DNumberWang:HideWang · Client, Menu
`DNumberWang:HideWang()`

Hides the number selector arrows.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:HideWang) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L73-L78)

---

### DNumberWang:OnValueChanged · Client, Menu · `hook`
`DNumberWang:OnValueChanged(val: number)`

Called when the number selector value is changed.

**Arguments:**
- `val` (number) — The new value of the number selector.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:OnValueChanged)

---

### DNumberWang:SetDecimals · Client, Menu
`DNumberWang:SetDecimals(num: number)`

Sets the amount of decimal places allowed in the number selector.

**Arguments:**
- `num` (number) — The amount of decimal places.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetDecimals) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L88-L93)

---

### DNumberWang:SetFloatValue · Client, Menu · `DEPRECATED`
`DNumberWang:SetFloatValue(val: number)`

Appears to do nothing.

**Arguments:**
- `val` (number)

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetFloatValue)

---

### DNumberWang:SetFraction · Client, Menu
`DNumberWang:SetFraction(val: number)`

Sets the value of the number selector based on the given fraction number.

**Arguments:**
- `val` (number) — The fraction of the number selector's range.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetFraction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L227-L232)

---

### DNumberWang:SetInterval · Client, Menu
`DNumberWang:SetInterval(min: number)`

Sets interval at which the up and down buttons change the current value.

**Arguments:**
- `min` (number) — The new interval.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetInterval)

---

### DNumberWang:SetMax · Client, Menu
`DNumberWang:SetMax(max: number)`

Sets the maximum numeric value allowed by the number selector.

**Arguments:**
- `max` (number) — The maximum value.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L108-L112)

---

### DNumberWang:SetMin · Client, Menu
`DNumberWang:SetMin(min: number)`

Sets the minimum numeric value allowed by the number selector.

**Arguments:**
- `min` (number) — The minimum value.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetMin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L102-L106)

---

### DNumberWang:SetMinMax · Client, Menu
`DNumberWang:SetMinMax(min: number, max: number)`

Sets the minimum and maximum value allowed by the number selector.

**Arguments:**
- `min` (number) — The minimum value.
- `max` (number) — The maximum value.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetMinMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L95-L100)

---

### DNumberWang:SetValue · Client, Menu
`DNumberWang:SetValue(val: number)`

Sets the value of the [DNumberWang](https://wiki.facepunch.com/gmod/DNumberWang) and triggers [DNumberWang:OnValueChanged](https://wiki.facepunch.com/gmod/DNumberWang:OnValueChanged)

**Arguments:**
- `val` (number) — The value to set.

[wiki](https://wiki.facepunch.com/gmod/DNumberWang:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnumberwang.lua#L122-L167)
