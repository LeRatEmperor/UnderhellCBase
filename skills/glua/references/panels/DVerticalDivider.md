# DVerticalDivider

**Realm:** Client  ·  **Members:** 22  ·  **Inherits:** `DPanel`

Vertical version of [DHorizontalDivider](https://wiki.facepunch.com/gmod/DHorizontalDivider).

[wiki page](https://wiki.facepunch.com/gmod/DVerticalDivider)

### DVerticalDivider:DoConstraints · Client · `INTERNAL`
`DVerticalDivider:DoConstraints()`

Used internally to clamp the vertical divider to [DVerticalDivider:GetTopMin](https://wiki.facepunch.com/gmod/DVerticalDivider:GetTopMin) and [DVerticalDivider:GetBottomMin](https://wiki.facepunch.com/gmod/DVerticalDivider:GetBottomMin).

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:DoConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dverticaldivider.lua#L76-L82)

---

### DVerticalDivider:GetBottom · Client
`DVerticalDivider:GetBottom() → Panel`

Returns the bottom content panel of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Returns:**
- Panel — The bottom content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetBottom)

---

### DVerticalDivider:GetBottomMin · Client
`DVerticalDivider:GetBottomMin() → number`

Returns the minimum height of the bottom content panel.

**Returns:**
- number — The minimum height of the bottom content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetBottomMin)

---

### DVerticalDivider:GetDividerHeight · Client
`DVerticalDivider:GetDividerHeight() → number`

Returns the height of the divider bar between the top and bottom content panels of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Returns:**
- number — The height of the divider bar.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetDividerHeight)

---

### DVerticalDivider:GetDragging · Client
`DVerticalDivider:GetDragging() → boolean`

Returns whether the divider is being dragged or not.

**Returns:**
- boolean — If true, mouse movement will alter the size of the divider.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetDragging)

---

### DVerticalDivider:GetHoldPos · Client · `INTERNAL`
`DVerticalDivider:GetHoldPos() → number`

Returns the local Y position of where the user starts dragging the divider.

**Returns:**
- number — The local Y position where divider dragging has started.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetHoldPos)

---

### DVerticalDivider:GetMiddle · Client
`DVerticalDivider:GetMiddle() → Panel`

Returns the middle content panel of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Returns:**
- Panel — The middle content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetMiddle)

---

### DVerticalDivider:GetTop · Client
`DVerticalDivider:GetTop() → Panel`

Returns the top content panel of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Returns:**
- Panel — The top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetTop)

---

### DVerticalDivider:GetTopHeight · Client
`DVerticalDivider:GetTopHeight() → number`

Returns the current height of the top content panel set by [DVerticalDivider:SetTopHeight](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTopHeight) or by the user.

**Returns:**
- number — The current height of the DVerticalDivider.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetTopHeight)

---

### DVerticalDivider:GetTopMax · Client
`DVerticalDivider:GetTopMax() → number`

Returns the maximum height of the top content panel. See [DVerticalDivider:SetTopMax](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTopMax) for more information.

**Returns:**
- number — The maximum height of the top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetTopMax)

---

### DVerticalDivider:GetTopMin · Client
`DVerticalDivider:GetTopMin() → number`

Returns the minimum height of the top content panel.

**Returns:**
- number — The minimum height of the top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:GetTopMin)

---

### DVerticalDivider:SetBottom · Client
`DVerticalDivider:SetBottom(pnl: Panel)`

Sets the passed panel as the bottom content of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Arguments:**
- `pnl` (Panel) — The panel to set as the bottom content.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetBottom) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dverticaldivider.lua#L69-L74)

---

### DVerticalDivider:SetBottomMin · Client
`DVerticalDivider:SetBottomMin(height: number)`

Sets the minimum height of the bottom content panel.

**Arguments:**
- `height` (number) — The minimum height of the bottom content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetBottomMin)

---

### DVerticalDivider:SetDividerHeight · Client
`DVerticalDivider:SetDividerHeight(height: number)`

Sets the height of the divider bar between the top and bottom content panels of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Arguments:**
- `height` (number) — The height of the divider bar.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetDividerHeight)

---

### DVerticalDivider:SetDragging · Client · `INTERNAL`
`DVerticalDivider:SetDragging(isDragging: boolean)`

Sets whether the divider is being dragged or not.

**Arguments:**
- `isDragging` (boolean) — Setting this to true causes cursor movement to alter the position of the divider.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetDragging)

---

### DVerticalDivider:SetHoldPos · Client · `INTERNAL`
`DVerticalDivider:SetHoldPos(y: number)`

Sets the local Y position of where the user starts dragging the divider.

**Arguments:**
- `y` (number) — The local Y position where divider dragging has started.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetHoldPos)

---

### DVerticalDivider:SetMiddle · Client
`DVerticalDivider:SetMiddle(pnl: Panel)`

Places the passed panel in between the top and bottom content panels of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Arguments:**
- `pnl` (Panel) — The panel to set as the middle content.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetMiddle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dverticaldivider.lua#L116-L126)

---

### DVerticalDivider:SetTop · Client
`DVerticalDivider:SetTop(pnl: Panel)`

Sets the passed panel as the top content of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider).

**Arguments:**
- `pnl` (Panel) — The panel to set as the top content.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dverticaldivider.lua#L62-L67)

---

### DVerticalDivider:SetTopHeight · Client
`DVerticalDivider:SetTopHeight(height: number)`

Sets the height of the top content panel.

The height of the bottom content panel is automatically calculated by taking the total height of the [DVerticalDivider](https://wiki.facepunch.com/gmod/DVerticalDivider) and subtracting it with the height of the top content panel and the divider bar.

**Arguments:**
- `height` (number) — The height of the top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTopHeight)

---

### DVerticalDivider:SetTopMax · Client
`DVerticalDivider:SetTopMax(height: number)`

Sets the maximum height of the top content panel. This is ignored if the panel would exceed the minimum bottom content panel height set from [DVerticalDivider:SetBottomMin](https://wiki.facepunch.com/gmod/DVerticalDivider:SetBottomMin).

**Arguments:**
- `height` (number) — The maximum height of the top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTopMax)

---

### DVerticalDivider:SetTopMin · Client
`DVerticalDivider:SetTopMin(height: number)`

Sets the minimum height of the top content panel.

**Arguments:**
- `height` (number) — The minimum height of the top content panel.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:SetTopMin)

---

### DVerticalDivider:StartGrab · Client · `INTERNAL`
`DVerticalDivider:StartGrab()`

Causes the user to start dragging the divider.

[wiki](https://wiki.facepunch.com/gmod/DVerticalDivider:StartGrab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dverticaldivider.lua#L140-L150)
