# vgui

**Realm:** Client, Menu  ·  **Members:** 15

The **vgui** library allows you to script and create your own panels using **V**alve's **G**raphical **U**ser **I**nterface (VGUI) system.

For an alphabetically ordered list of VGUI panels, see [VGUI Element List](https://wiki.facepunch.com/gmod/VGUI%20Element%20List).

[wiki page](https://wiki.facepunch.com/gmod/vgui)

### vgui.Create · Client, Menu
`vgui.Create(classname: string, parent: Panel = nil, name: string = nil) → Panel`

Creates a panel by the specified classname.

**Arguments:**
- `classname` (string) — Classname of the panel to create.
- `parent` (Panel, default `nil`) — Panel to parent to.
- `name` (string, default `nil`) — Custom name of the created panel for scripting/debugging purposes.

**Returns:**
- Panel — The created panel, or `nil` if creation failed for whatever reason.

> **Note:** Custom VGUI elements are not loaded instantly. Use [GM:OnGamemodeLoaded](https://wiki.facepunch.com/gmod/GM:OnGamemodeLoaded) to create them on startup.

[wiki](https://wiki.facepunch.com/gmod/vgui.Create) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L19-L48)

---

### vgui.CreateFromTable · Client, Menu
`vgui.CreateFromTable(metatable: table, parent: Panel = nil, name: string = nil) → Panel`

Creates a panel from a table, used alongside [vgui.RegisterFile](https://wiki.facepunch.com/gmod/vgui.RegisterFile) and [vgui.RegisterTable](https://wiki.facepunch.com/gmod/vgui.RegisterTable) to efficiently define, register, and instantiate custom panels.

**Arguments:**
- `metatable` (table) — Your PANEL table.
- `parent` (Panel, default `nil`) — Which panel to parent the newly created panel to.
- `name` (string, default `nil`) — Custom name of the created panel for scripting/debugging purposes.

**Returns:**
- Panel — The created panel, or `nil` if creation failed for whatever reason.

[wiki](https://wiki.facepunch.com/gmod/vgui.CreateFromTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L50-L69)

---

### vgui.CreateX · Client, Menu · `INTERNAL`
`vgui.CreateX(class: string, parent: Panel = nil, name: string = nil) → Panel`

Creates an engine panel.

**Arguments:**
- `class` (string) — Class of the panel to create
- `parent` (Panel, default `nil`) — If specified, parents created panel to given one
- `name` (string, default `nil`) — Name of the created panel

**Returns:**
- Panel — Created panel

[wiki](https://wiki.facepunch.com/gmod/vgui.CreateX) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L13-L13)

---

### vgui.CursorVisible · Client, Menu
`vgui.CursorVisible() → boolean`

Returns whenever the cursor is currently active and visible.

**Returns:**
- boolean — Whether the cursor is visible or not.

[wiki](https://wiki.facepunch.com/gmod/vgui.CursorVisible)

---

### vgui.Exists · Client, Menu
`vgui.Exists(Panelname: string) → boolean`

Returns true if Lua-defined panel exists by name. Uses [vgui.GetControlTable](https://wiki.facepunch.com/gmod/vgui.GetControlTable) internally.

**Arguments:**
- `Panelname` (string) — The name of the panel to get test.

**Returns:**
- boolean — Whether a panel with given name was registered yet or not.

[wiki](https://wiki.facepunch.com/gmod/vgui.Exists) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L19-L21)

---

### vgui.FocusedHasParent · Client, Menu
`vgui.FocusedHasParent(parent: Panel) → boolean`

Returns whether the currently focused panel is a child of the given one.

**Arguments:**
- `parent` (Panel) — The parent panel to check the currently focused one against.

**Returns:**
- boolean — Whether or not the focused panel is a child of the passed one.

[wiki](https://wiki.facepunch.com/gmod/vgui.FocusedHasParent)

---

### vgui.GetAll · Client, Menu
`vgui.GetAll() → table<Panel>`

Returns all Lua-created panels.

Used internally for [PANEL:PreAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PreAutoRefresh) and [PANEL:PostAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PostAutoRefresh).

**Returns:**
- table<Panel> — List of all Lua created panels.

[wiki](https://wiki.facepunch.com/gmod/vgui.GetAll)

---

### vgui.GetControlTable · Client, Menu
`vgui.GetControlTable(Panelname: string) → table`

Returns the table of a Lua-defined panel by name. Does not return parent members of the table!

**Arguments:**
- `Panelname` (string) — The name of the panel to get the table of.

**Returns:**
- table — The `PANEL` table of the a Lua-defined panel with given name.

[wiki](https://wiki.facepunch.com/gmod/vgui.GetControlTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L15-L17)

---

### vgui.GetHoveredPanel · Client, Menu
`vgui.GetHoveredPanel() → Panel`

Returns the panel the cursor is hovering above.

**Returns:**
- Panel — The panel that the user is currently hovering over with their cursor.

> **Warning:** This returns a cached value that is only updated after rendering and `before` the next VGUI Think/Layout pass.
> 
> ie. it lags one frame behind panel layout and is completely unhelpful for [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) if your panels are moving around under the mouse a lot every frame.

[wiki](https://wiki.facepunch.com/gmod/vgui.GetHoveredPanel)

---

### vgui.GetKeyboardFocus · Client, Menu
`vgui.GetKeyboardFocus() → Panel`

Returns the panel which is currently receiving keyboard input.

**Returns:**
- Panel — The panel with keyboard focus

[wiki](https://wiki.facepunch.com/gmod/vgui.GetKeyboardFocus)

---

### vgui.GetWorldPanel · Client, Menu
`vgui.GetWorldPanel() → Panel`

Returns the global world panel which is the parent to all others, except for the HUD panel.

See also [GetHUDPanel](https://wiki.facepunch.com/gmod/Global.GetHUDPanel).

**Returns:**
- Panel — The world panel

[wiki](https://wiki.facepunch.com/gmod/vgui.GetWorldPanel)

---

### vgui.IsHoveringWorld · Client, Menu
`vgui.IsHoveringWorld() → boolean`

Returns whenever the cursor is hovering the world panel.

**Returns:**
- boolean — isHoveringWorld

[wiki](https://wiki.facepunch.com/gmod/vgui.IsHoveringWorld)

---

### vgui.Register · Client, Menu
`vgui.Register(classname: string, panelTable: table, baseName: string = Panel) → table`

Registers a panel for later creation via [vgui.Create](https://wiki.facepunch.com/gmod/vgui.Create).

**Arguments:**
- `classname` (string) — Classname of the panel to register.
- `panelTable` (table) — The table containing the panel information.
- `baseName` (string, default `Panel`) — Classname of a panel to inherit functionality from.

**Returns:**
- table — The given panel table from second argument

[wiki](https://wiki.facepunch.com/gmod/vgui.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L71-L95)

---

### vgui.RegisterFile · Client, Menu
`vgui.RegisterFile(file: string) → table`

Registers a new [VGUI](https://wiki.facepunch.com/gmod/VGUI) panel from a file, to be used with [vgui.CreateFromTable](https://wiki.facepunch.com/gmod/vgui.CreateFromTable).

File file must use the `PANEL` global that is provided just before the file is [include](https://wiki.facepunch.com/gmod/Global.include)d, for example:


```lua
PANEL.Base = "Panel"

function PANEL:Init()
	-- Your code...
end

function PANEL:Think()
	-- Your code...
end
```

**Arguments:**
- `file` (string) — The file to register

**Returns:**
- table — A table containing info about the panel.

[wiki](https://wiki.facepunch.com/gmod/vgui.RegisterFile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L109-L126)

---

### vgui.RegisterTable · Client, Menu
`vgui.RegisterTable(panel: table, base: string = Panel) → table`

Registers a table to use as a panel, to be used with [vgui.CreateFromTable](https://wiki.facepunch.com/gmod/vgui.CreateFromTable).

All this function does is assigns Base key to your table and returns the table.

**Arguments:**
- `panel` (table) — The PANEL table.
- `base` (string, default `Panel`) — A base for the panel.

**Returns:**
- table — The PANEL table

[wiki](https://wiki.facepunch.com/gmod/vgui.RegisterTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/scriptedpanels.lua#L97-L107)
