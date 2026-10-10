# DHScrollBar

**Realm:** Client, Menu  ·  **Members:** 10  ·  **Inherits:** `Panel`

A generic horizontal scrollbar. See the vertical alternative [here](DVScrollBar).

The scrollbar notably contains `DHScrollBar.btnLeft`, `DHScrollBar.btnRight`, and `DHScrollBar.btnGrip` which are the left button, right button, and grip respectively. Editing the paint functions of these allows custom scrollbar styling, although it is a better idea to use [Derma Skins](Derma_Skin_Creation).

[wiki page](https://wiki.facepunch.com/gmod/DHScrollBar)

### DHScrollBar:AddScroll · Client, Menu
`DHScrollBar:AddScroll(add: number) → boolean`

Adds specified amount of scroll in pixels.

**Arguments:**
- `add` (number) — How much to scroll rightwards.

**Returns:**
- boolean — True if the scroll level was changed (i.e.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:AddScroll)

---

### DHScrollBar:AnimateTo · Client, Menu
`DHScrollBar:AnimateTo(scroll: number, length: number, delay: number = 0, ease: number = -1)`

Smoothly scrolls to given level.

**Arguments:**
- `scroll` (number) — The scroll level to animate to.
- `length` (number) — Length of the animation in seconds
- `delay` (number, default `0`) — Delay of the animation in seconds
- `ease` (number, default `-1`) — See Panel:NewAnimation for explanation.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:AnimateTo)

---

### DHScrollBar:BarScale · Client, Menu
`DHScrollBar:BarScale() → number`

Returns the scale of the scroll bar based on the difference in size between the visible "window" into the canvas that is being scrolled. Should be used after [DHScrollBar:SetUp](https://wiki.facepunch.com/gmod/DHScrollBar:SetUp).

**Returns:**
- number — The scale of the scrollbar.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:BarScale)

---

### DHScrollBar:GetHideButtons · Client, Menu
`DHScrollBar:GetHideButtons() → boolean`

Returns whether or not the manual left/right scroll buttons are visible or not. Set by [DHScrollBar:SetHideButtons](https://wiki.facepunch.com/gmod/DHScrollBar:SetHideButtons).

**Returns:**
- boolean — Whether or not the manual left/right scroll buttons are visible or not.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:GetHideButtons)

---

### DHScrollBar:GetOffset · Client, Menu
`DHScrollBar:GetOffset() → number`

Returns the negative of [DHScrollBar:GetScroll](https://wiki.facepunch.com/gmod/DHScrollBar:GetScroll).

**Returns:**
- number — The scroll offset.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:GetOffset)

---

### DHScrollBar:GetScroll · Client, Menu
`DHScrollBar:GetScroll() → number`

Returns the amount of scroll level from the left in pixels.

**Returns:**
- number — The amount of scroll level from the left edge.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:GetScroll)

---

### DHScrollBar:Grip · Client, Menu · `INTERNAL`
`DHScrollBar:Grip()`

Called from within [DScrollBarGrip](https://wiki.facepunch.com/gmod/DScrollBarGrip)

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:Grip)

---

### DHScrollBar:SetHideButtons · Client, Menu
`DHScrollBar:SetHideButtons(hide: boolean)`

Allows hiding the left and right buttons for better visual stylisation.

**Arguments:**
- `hide` (boolean) — True to hide

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:SetHideButtons)

---

### DHScrollBar:SetScroll · Client, Menu
`DHScrollBar:SetScroll(scroll: number)`

Sets the scroll level in pixels.

**Arguments:**
- `scroll` (number) — The new scroll value.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:SetScroll)

---

### DHScrollBar:SetUp · Client, Menu
`DHScrollBar:SetUp(barSize: number, canvasSize: number)`

Sets up the scrollbar for use.

The scrollbar will automatically disable itself if the total width of the canvas is lower than the width of the panel that holds the canvas during this function call.

**Arguments:**
- `barSize` (number) — The size of the panel that holds the canvas, basically size of "1 page".
- `canvasSize` (number) — The total size of the canvas, this typically is the bigger number.

[wiki](https://wiki.facepunch.com/gmod/DHScrollBar:SetUp)
