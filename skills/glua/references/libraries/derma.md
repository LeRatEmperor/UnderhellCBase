# derma

**Realm:** Client, Menu  ·  **Members:** 13

The derma library allows you to add custom derma controls and create & modify derma skins.

[wiki page](https://wiki.facepunch.com/gmod/derma)

### derma.Color · Client, Menu
`derma.Color(name: string, pnl: Panel, default: Color)`

Gets the color from a Derma skin of a panel and returns default color if not found.

**Arguments:**
- `name` (string)
- `pnl` (Panel)
- `default` (Color) — The default Color in case of failure.

[wiki](https://wiki.facepunch.com/gmod/derma.Color) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L222-L229)

---

### derma.Controls · Client, Menu
`derma.Controls()`

[wiki](https://wiki.facepunch.com/gmod/derma.Controls)

---

### derma.DefineControl · Client, Menu
`derma.DefineControl(name: string, description: string, tab: table, base: string) → table`

Defines a new Derma control with an optional base.

This calls [vgui.Register](https://wiki.facepunch.com/gmod/vgui.Register) internally, but also does the following:
* Adds the control to [derma.GetControlList](https://wiki.facepunch.com/gmod/derma.GetControlList)
* Adds a key "Derma" - This is returned by [derma.GetControlList](https://wiki.facepunch.com/gmod/derma.GetControlList)
* Makes a global table with the name of the control (This is technically deprecated and should not be relied upon)
* If reloading (i.e. called this function with name of an existing panel), updates all existing instances of panels with this name. (Updates functions, calls [PANEL:PreAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PreAutoRefresh) and [PANEL:PostAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PostAutoRefresh), etc.)

**Arguments:**
- `name` (string) — Name of the newly created control.
- `description` (string) — Description of the control.
- `tab` (table) — Table containing control methods and properties.
- `base` (string) — Derma control to base the new control off of.

**Returns:**
- table — A table containing the new control's methods and properties.

[wiki](https://wiki.facepunch.com/gmod/derma.DefineControl) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L99-L127)

---

### derma.DefineSkin · Client, Menu
`derma.DefineSkin(name: string, descriptions: string, skin: table)`

Defines a new skin so that it is usable by Derma. The default skin can be found in `garrysmod/lua/skins/default.lua`.

**Arguments:**
- `name` (string) — Name of the skin.
- `descriptions` (string) — Description of the skin.
- `skin` (table) — Table containing skin data.

[wiki](https://wiki.facepunch.com/gmod/derma.DefineSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L132-L149)

---

### derma.GetControlList · Client, Menu
`derma.GetControlList() → table`

Returns the [derma.Controls](https://wiki.facepunch.com/gmod/derma.Controls) table, a list of all derma controls registered with [derma.DefineControl](https://wiki.facepunch.com/gmod/derma.DefineControl).

**Returns:**
- table — A listing of all available derma-based controls.

[wiki](https://wiki.facepunch.com/gmod/derma.GetControlList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L90-L94)

---

### derma.GetDefaultSkin · Client, Menu
`derma.GetDefaultSkin() → table`

Returns the default skin table, which can be changed with the hook [GM:ForceDermaSkin](https://wiki.facepunch.com/gmod/GM:ForceDermaSkin).

**Returns:**
- table — The default skin table.

[wiki](https://wiki.facepunch.com/gmod/derma.GetDefaultSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L163-L178)

---

### derma.GetNamedSkin · Client, Menu
`derma.GetNamedSkin(name: string) → table`

Returns the skin table of the skin with the supplied name.

**Arguments:**
- `name` (string) — Name of skin.

**Returns:**
- table — The skin table.

[wiki](https://wiki.facepunch.com/gmod/derma.GetNamedSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L183-L187)

---

### derma.GetSkinTable · Client, Menu
`derma.GetSkinTable() → table`

Returns a copy of the table containing every Derma skin.

**Returns:**
- table — Table of every Derma skin.

[wiki](https://wiki.facepunch.com/gmod/derma.GetSkinTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L154-L158)

---

### derma.RefreshSkins · Client, Menu
`derma.RefreshSkins()`

Clears all cached panels so that they reassess which skin they should be using.

[wiki](https://wiki.facepunch.com/gmod/derma.RefreshSkins) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L243-L247)

---

### derma.SkinChangeIndex · Client, Menu
`derma.SkinChangeIndex() → number`

Returns how many times [derma.RefreshSkins](https://wiki.facepunch.com/gmod/derma.RefreshSkins) has been called.

**Returns:**
- number — Amount of times derma.RefreshSkins has been called.

[wiki](https://wiki.facepunch.com/gmod/derma.SkinChangeIndex) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L234-L238)

---

### derma.SkinHook · Client, Menu
`derma.SkinHook(type: string, name: string, panel: Panel, vararg1: any = nil, vararg2: any = nil) → any`

Checks if a matching hook function exists in the skin _(based on the concatenation of type and name args)_, then calls it. 

This function is used dynamically inside [Derma_Hook](https://wiki.facepunch.com/gmod/Global.Derma_Hook).

**Arguments:**
- `type` (string) — The type of hook to run, usually `Paint`.
- `name` (string) — The name of the hook/panel to run.
- `panel` (Panel) — The panel to call the hook for.
- `vararg1` (any, default `nil`) — First parameter for the panel hook.
- `vararg2` (any, default `nil`) — Second parameter for the panel hook.

**Returns:**
- any — The returned variable from the skin hook.

[wiki](https://wiki.facepunch.com/gmod/derma.SkinHook) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L192-L202)

---

### derma.SkinList · Client, Menu
`derma.SkinList()`

[wiki](https://wiki.facepunch.com/gmod/derma.SkinList)

---

### derma.SkinTexture · Client, Menu
`derma.SkinTexture(name: string, pnl: Panel, fallback: function = nil) → function`

Returns a function to draw a specified texture of panels skin.

These are usually generated via [GWEN.CreateTextureBorder](https://wiki.facepunch.com/gmod/GWEN.CreateTextureBorder) and similar.

**Arguments:**
- `name` (string) — The identifier of the texture.
- `pnl` (Panel) — Panel to get the skin of.
- `fallback` (function, default `nil`) — What to return if we failed to retrieve the texture.

**Returns:**
- function — A function that is created with the GWEN library to draw a texture.

[wiki](https://wiki.facepunch.com/gmod/derma.SkinTexture) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma.lua#L207-L217)
