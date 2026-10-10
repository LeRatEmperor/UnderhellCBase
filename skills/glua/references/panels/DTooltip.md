# DTooltip

**Realm:** Client, Menu  ·  **Members:** 5  ·  **Inherits:** `DLabel`  ·  `INTERNAL`

The panel used internally for tooltips. See [Panel:SetTooltip](https://wiki.facepunch.com/gmod/Panel:SetTooltip) for more information.

[wiki page](https://wiki.facepunch.com/gmod/DTooltip)

### DTooltip:Close · Client, Menu
`DTooltip:Close()`

Forces the tooltip to close. This will remove the panel.

[wiki](https://wiki.facepunch.com/gmod/DTooltip:Close) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtooltip.lua#L122-L133)

---

### DTooltip:DrawArrow · Client, Menu
`DTooltip:DrawArrow(x: number, y: number)`

Used to draw a triangle beneath the [DTooltip](https://wiki.facepunch.com/gmod/DTooltip)

**Arguments:**
- `x` (number) — arrow location on the x axis
- `y` (number) — arrow location on the y axis

> **Note:** Requires [DTooltip:SetContents](https://wiki.facepunch.com/gmod/DTooltip:SetContents), without this it will error

[wiki](https://wiki.facepunch.com/gmod/DTooltip:DrawArrow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtooltip.lua#L58-L65)

---

### DTooltip:OpenForPanel · Client, Menu · `INTERNAL`
`DTooltip:OpenForPanel(pnl: Panel)`

Sets up the tooltip for display for given panel and starts the timer.

Normally you wouldn't call this and you'd use [Panel:SetTooltip](https://wiki.facepunch.com/gmod/Panel:SetTooltip), [Panel:SetTooltipPanel](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanel) or [Panel:SetTooltipPanelOverride](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanelOverride).

**Arguments:**
- `pnl` (Panel) — The panel to open the tooltip for.

[wiki](https://wiki.facepunch.com/gmod/DTooltip:OpenForPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtooltip.lua#L98-L120)

---

### DTooltip:PositionTooltip · Client, Menu · `INTERNAL`
`DTooltip:PositionTooltip()`

Positions the [DTooltip](https://wiki.facepunch.com/gmod/DTooltip) so it doesn't stay in the same draw position.

[wiki](https://wiki.facepunch.com/gmod/DTooltip:PositionTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtooltip.lua#L67-L89)

---

### DTooltip:SetContents · Client, Menu
`DTooltip:SetContents(panel: Panel, delete: boolean = false)`

What Panel you want put inside of the [DTooltip](https://wiki.facepunch.com/gmod/DTooltip)

**Arguments:**
- `panel` (Panel) — Contents
- `delete` (boolean, default `false`) — If set to true, the panel in the first argument will be automatically removed when DTooltip is closed via DTooltip:Close.

> **Note:** You can only have one Panel at a time; use Parenting to add more

[wiki](https://wiki.facepunch.com/gmod/DTooltip:SetContents) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtooltip.lua#L24-L35)
