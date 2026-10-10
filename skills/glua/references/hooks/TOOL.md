# TOOL

**Realm:** Shared  ·  **Members:** 10

A list of hooks (or callbacks) that are available for you to override in a tool. This is only applicable to sandbox and sandbox-derived gamemodes.

See also: [Structures/TOOL](https://wiki.facepunch.com/gmod/Structures/TOOL) and [Tool](https://wiki.facepunch.com/gmod/Tool).

> **Note:** This function or feature is only available in the Sandbox gamemode and its [derivatives](https://wiki.facepunch.com/gmod/Global.DeriveGamemode).

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `TOOL` table: `function TOOL:<Name>(...) end`. The `TOOL:` prefix shown on each member below is the method form you write.

### TOOL:BuildCPanel · Client · `hook`
`TOOL:BuildCPanel(cpanel: Panel)`

Called when the tool's control panel needs to be rebuilt.

**Arguments:**
- `cpanel` (Panel) — The DForm control panel to add settings to.

> **Warning:** Due to historical reasons, this hook does not provide the tool object as `self`! See examples.

[wiki](https://wiki.facepunch.com/gmod/TOOL.BuildCPanel)

---

### TOOL:Deploy · Shared · `hook` · `PREDICTED`
`TOOL:Deploy() → boolean`

Called when [WEAPON:Deploy](https://wiki.facepunch.com/gmod/WEAPON:Deploy) of the toolgun is called.

This is also called when switching from another tool on the server.

**Returns:**
- boolean — Return true to allow switching away from the toolgun using lastinv command

[wiki](https://wiki.facepunch.com/gmod/TOOL:Deploy)

---

### TOOL:DrawHUD · Client · `hook`
`TOOL:DrawHUD()`

Called when [WEAPON:DrawHUD](https://wiki.facepunch.com/gmod/WEAPON:DrawHUD) of the toolgun is called, only when the user has this tool selected.

[wiki](https://wiki.facepunch.com/gmod/TOOL:DrawHUD)

---

### TOOL:DrawToolScreen · Client · `hook`
`TOOL:DrawToolScreen(width: number, height: number)`

Called after the default tool screen has been drawn from [WEAPON:RenderScreen](https://wiki.facepunch.com/gmod/WEAPON:RenderScreen).

**Arguments:**
- `width` (number) — The width of the tool's screen in pixels.
- `height` (number) — The height of the tool's screen in pixels.

> **Note:** Materials rendered in this hook require $ignorez parameter to draw properly.
> **Note:** If this method exists on the TOOL object table, the default scrolling text will not be drawn

[wiki](https://wiki.facepunch.com/gmod/TOOL:DrawToolScreen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/cl_viewscreen.lua#L67-L69)

---

### TOOL:FreezeMovement · Client · `hook`
`TOOL:FreezeMovement() → boolean`

Called when [WEAPON:Think](https://wiki.facepunch.com/gmod/WEAPON:Think) of the toolgun is called, only when the user has this tool selected.

**Returns:**
- boolean — Return true to freeze the player

[wiki](https://wiki.facepunch.com/gmod/TOOL:FreezeMovement)

---

### TOOL:Holster · Shared · `hook` · `PREDICTED`
`TOOL:Holster()`

Called when [WEAPON:Holster](https://wiki.facepunch.com/gmod/WEAPON:Holster) of the toolgun is called, when switching between different toolguns.

[wiki](https://wiki.facepunch.com/gmod/TOOL:Holster)

---

### TOOL:LeftClick · Shared · `hook` · `PREDICTED`
`TOOL:LeftClick(tr: table) → boolean`

Called when the user left clicks with the tool.

**Arguments:**
- `tr` (table) — A trace from user's eyes to wherever they aim at.

**Returns:**
- boolean — Return `true` to draw the tool gun beam and play fire animations, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/TOOL:LeftClick)

---

### TOOL:Reload · Shared · `hook` · `PREDICTED`
`TOOL:Reload(tr: table) → boolean`

Called when the user presses the reload key with the tool out.

**Arguments:**
- `tr` (table) — A trace from user's eyes to wherever they aim at.

**Returns:**
- boolean — Return `true` to draw the tool gun beam and play fire animations, `false` otherwise

[wiki](https://wiki.facepunch.com/gmod/TOOL:Reload)

---

### TOOL:RightClick · Shared · `hook` · `PREDICTED`
`TOOL:RightClick(tr: table) → boolean`

Called when the user right clicks with the tool.

**Arguments:**
- `tr` (table) — A trace from user's eyes to wherever they aim at.

**Returns:**
- boolean — Return `true` to draw the tool gun beam and play fire animations, `false` otherwise

[wiki](https://wiki.facepunch.com/gmod/TOOL:RightClick)

---

### TOOL:Think · Shared · `hook`
`TOOL:Think()`

Called when [WEAPON:Think](https://wiki.facepunch.com/gmod/WEAPON:Think) of the toolgun is called. This only happens when the tool gun is currently equipped/selected by the player and the selected tool is this tool.

[wiki](https://wiki.facepunch.com/gmod/TOOL:Think)
