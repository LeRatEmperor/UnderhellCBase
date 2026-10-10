# menubar

**Realm:** Client  ·  **Members:** 3

The menubar library.

[wiki page](https://wiki.facepunch.com/gmod/menubar)

### menubar.Init · Client
`menubar.Init()`

Creates the menu bar ( The bar at the top of the screen when holding C or Q in sandbox ) and docks it to the top of the screen. It will not appear.

Calling this multiple times will **NOT** remove previous panel.

[wiki](https://wiki.facepunch.com/gmod/menubar.Init) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/menubar.lua#L4-L12)

---

### menubar.IsParent · Client
`menubar.IsParent(pnl: Panel) → boolean`

Checks if the supplied panel is parent to the menubar

**Arguments:**
- `pnl` (Panel) — The panel to check

**Returns:**
- boolean — Is parent or not

[wiki](https://wiki.facepunch.com/gmod/menubar.IsParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/menubar.lua#L28-L32)

---

### menubar.ParentTo · Client
`menubar.ParentTo(pnl: Panel)`

Parents the menubar to the panel and displays the menubar.

**Arguments:**
- `pnl` (Panel) — The panel to parent to

[wiki](https://wiki.facepunch.com/gmod/menubar.ParentTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/menubar.lua#L14-L26)
