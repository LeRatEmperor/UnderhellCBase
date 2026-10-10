# DHorizontalDivider

**Realm:** Client  ·  **Members:** 19  ·  **Inherits:** `DPanel`

Creates an invisible vertical divider between two GUI elements.

[wiki page](https://wiki.facepunch.com/gmod/DHorizontalDivider)

### DHorizontalDivider:GetDividerWidth · Client
`DHorizontalDivider:GetDividerWidth() → number`

Returns the width of the horizontal divider bar, set by [DHorizontalDivider:SetDividerWidth](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetDividerWidth).

**Returns:**
- number — The width of the horizontal divider bar

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetDividerWidth)

---

### DHorizontalDivider:GetDragging · Client
`DHorizontalDivider:GetDragging() → boolean`

Returns whether or not the player is currently dragging the middle divider bar.

**Returns:**
- boolean — Whether or not the player is currently dragging the middle divider bar.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetDragging)

---

### DHorizontalDivider:GetHoldPos · Client · `INTERNAL`
`DHorizontalDivider:GetHoldPos() → number`

Returns the local X coordinate of where the player started dragging the thing

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetHoldPos)

---

### DHorizontalDivider:GetLeft · Client
`DHorizontalDivider:GetLeft() → Panel`

Returns the left side content of the [DHorizontalDivider](https://wiki.facepunch.com/gmod/DHorizontalDivider)

**Returns:**
- Panel — The content on the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetLeft)

---

### DHorizontalDivider:GetLeftMin · Client
`DHorizontalDivider:GetLeftMin() → number`

Returns the minimum width of the left side, set by [DHorizontalDivider:SetLeftMin](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetLeftMin).

**Returns:**
- number — The minimum width of the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetLeftMin)

---

### DHorizontalDivider:GetLeftWidth · Client
`DHorizontalDivider:GetLeftWidth() → number`

Returns the current width of the left side, set by [DHorizontalDivider:SetLeftWidth](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetLeftWidth) or by the user.

**Returns:**
- number — The current width of the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetLeftWidth)

---

### DHorizontalDivider:GetMiddle · Client
`DHorizontalDivider:GetMiddle() → Panel`

Returns the middle content, set by [DHorizontalDivider:SetMiddle](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetMiddle).

**Returns:**
- Panel — The middle content

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetMiddle)

---

### DHorizontalDivider:GetRight · Client
`DHorizontalDivider:GetRight() → Panel`

Returns the right side content

**Returns:**
- Panel — The right side content

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetRight)

---

### DHorizontalDivider:GetRightMin · Client
`DHorizontalDivider:GetRightMin() → number`

Returns the minimum width of the right side, set by [DHorizontalDivider:SetRightMin](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetRightMin).

**Returns:**
- number — The minimum width of the right side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:GetRightMin)

---

### DHorizontalDivider:SetDividerWidth · Client
`DHorizontalDivider:SetDividerWidth(width: number)`

Sets the width of the horizontal divider bar.

**Arguments:**
- `width` (number) — The width of the horizontal divider bar.

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetDividerWidth)

---

### DHorizontalDivider:SetDragging · Client · `INTERNAL`
`DHorizontalDivider:SetDragging(dragonot: boolean)`

Sets whether the player is dragging the divider or not

**Arguments:**
- `dragonot` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DHorizontalDivider:SetHoldPos · Client · `INTERNAL`
`DHorizontalDivider:SetHoldPos(x: number)`

Sets the local X coordinate of where the player started dragging the thing

**Arguments:**
- `x` (number)

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetHoldPos)

---

### DHorizontalDivider:SetLeft · Client
`DHorizontalDivider:SetLeft(pnl: Panel)`

Sets the left side content of the [DHorizontalDivider](https://wiki.facepunch.com/gmod/DHorizontalDivider).

**Arguments:**
- `pnl` (Panel) — The panel to set as the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetLeft) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontaldivider.lua#L59-L67)

---

### DHorizontalDivider:SetLeftMin · Client
`DHorizontalDivider:SetLeftMin(minWidth: number)`

Sets the minimum width of the left side

**Arguments:**
- `minWidth` (number) — The minimum width of the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetLeftMin)

---

### DHorizontalDivider:SetLeftWidth · Client
`DHorizontalDivider:SetLeftWidth(width: number)`

Sets the current/starting width of the left side.

The width of the right side is automatically calculated by subtracting this from the total width of the [DHorizontalDivider](https://wiki.facepunch.com/gmod/DHorizontalDivider).

**Arguments:**
- `width` (number) — The current/starting width of the left side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetLeftWidth)

---

### DHorizontalDivider:SetMiddle · Client
`DHorizontalDivider:SetMiddle(middle: Panel)`

Sets the middle content, over the draggable divider bar panel.

**Arguments:**
- `middle` (Panel) — The middle content

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetMiddle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontaldivider.lua#L69-L77)

---

### DHorizontalDivider:SetRight · Client
`DHorizontalDivider:SetRight(pnl: Panel)`

Sets the right side content

**Arguments:**
- `pnl` (Panel) — The right side content

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetRight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontaldivider.lua#L79-L87)

---

### DHorizontalDivider:SetRightMin · Client
`DHorizontalDivider:SetRightMin(minWidth: number)`

Sets the minimum width of the right side

**Arguments:**
- `minWidth` (number) — The minimum width of the right side

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:SetRightMin)

---

### DHorizontalDivider:StartGrab · Client · `INTERNAL`
`DHorizontalDivider:StartGrab()`

[wiki](https://wiki.facepunch.com/gmod/DHorizontalDivider:StartGrab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhorizontaldivider.lua#L144-L154)
