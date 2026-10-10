# DVScrollBar

**Realm:** Client, Menu  ·  **Members:** 10  ·  **Inherits:** `Panel`

A generic vertical scrollbar, used in [DScrollPanel](https://wiki.facepunch.com/gmod/DScrollPanel). See the horizontal alternative [here](DHScrollBar).

The scrollbar notably contains `DVScrollBar.btnUp`, `DVScrollBar.btnDown`, and `DVScrollBar.btnGrip` which are the up button, down button, and grip respectively. Editing the paint functions of these allows custom scrollbar styling (See [DScrollPanel:GetVBar](https://wiki.facepunch.com/gmod/DScrollPanel:GetVBar) for an example), although it is a better idea to use [Derma Skins](Derma_Skin_Creation).

[wiki page](https://wiki.facepunch.com/gmod/DVScrollBar)

### DVScrollBar:AddScroll · Client, Menu
`DVScrollBar:AddScroll(add: number) → boolean`

Adds specified amount of scroll in pixels.

**Arguments:**
- `add` (number) — How much to scroll downwards.

**Returns:**
- boolean — True if the scroll level was changed (i.e.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:AddScroll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L138-L147)

---

### DVScrollBar:AnimateTo · Client, Menu
`DVScrollBar:AnimateTo(scroll: number, length: number, delay: number = 0, ease: number = -1)`

Smoothly scrolls to given level.

**Arguments:**
- `scroll` (number) — The scroll level to animate to.
- `length` (number) — Length of the animation in seconds
- `delay` (number, default `0`) — Delay of the animation in seconds
- `ease` (number, default `-1`) — See Panel:NewAnimation for explanation.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:AnimateTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L173-L184)

---

### DVScrollBar:BarScale · Client, Menu
`DVScrollBar:BarScale() → number`

Returns the scale of the scroll bar based on the difference in size between the visible "window" into the canvas that is being scrolled. Should be used after [DVScrollBar:SetUp](https://wiki.facepunch.com/gmod/DVScrollBar:SetUp).

**Returns:**
- number — The scale of the scrollbar.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:BarScale) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L108-L114)

---

### DVScrollBar:GetHideButtons · Client, Menu
`DVScrollBar:GetHideButtons() → boolean`

Returns whether or not the manual up/down scroll buttons are visible or not. Set by [DVScrollBar:SetHideButtons](https://wiki.facepunch.com/gmod/DVScrollBar:SetHideButtons).

**Returns:**
- boolean — Whether or not the manual up/down scroll buttons are visible or not.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:GetHideButtons)

---

### DVScrollBar:GetOffset · Client, Menu
`DVScrollBar:GetOffset() → number`

Returns the negative of [DVScrollBar:GetScroll](https://wiki.facepunch.com/gmod/DVScrollBar:GetScroll).

**Returns:**
- number — The scroll offset.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:GetOffset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L193-L198)

---

### DVScrollBar:GetScroll · Client, Menu
`DVScrollBar:GetScroll() → number`

Returns the amount of scroll level from the top in pixels

**Returns:**
- number — The amount of scroll level from the top

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:GetScroll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L186-L191)

---

### DVScrollBar:Grip · Client, Menu · `INTERNAL`
`DVScrollBar:Grip()`

Called from within [DScrollBarGrip](https://wiki.facepunch.com/gmod/DScrollBarGrip)

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:Grip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L256-L269)

---

### DVScrollBar:SetHideButtons · Client, Menu
`DVScrollBar:SetHideButtons(hide: boolean)`

Allows hiding the up and down buttons for better visual stylisation.

**Arguments:**
- `hide` (boolean) — True to hide

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:SetHideButtons)

---

### DVScrollBar:SetScroll · Client, Menu
`DVScrollBar:SetScroll(scroll: number)`

Sets the scroll level in pixels.

**Arguments:**
- `scroll` (number) — The new scroll value.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:SetScroll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L149-L171)

---

### DVScrollBar:SetUp · Client, Menu
`DVScrollBar:SetUp(barSize: number, canvasSize: number)`

Sets up the scrollbar for use.

The scrollbar will automatically disable itself if the total height of the canvas is lower than the height of the panel that holds the canvas during this function call.

**Arguments:**
- `barSize` (number) — The size of the panel that holds the canvas, basically size of "1 page".
- `canvasSize` (number) — The total size of the canvas, this typically is the bigger number.

[wiki](https://wiki.facepunch.com/gmod/DVScrollBar:SetUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dvscrollbar.lua#L116-L125)
