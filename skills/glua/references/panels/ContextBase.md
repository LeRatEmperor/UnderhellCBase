# ContextBase

**Realm:** Client  ·  **Members:** 4  ·  **Inherits:** `Panel`

A base for all context menu panels ( The ones used for tool options in sandbox )

[wiki page](https://wiki.facepunch.com/gmod/ContextBase)

### ContextBase:ControlValues · Client
`ContextBase:ControlValues(contextData: table)`

Called by spawnmenu functions (when creating a context menu) to fill this control with data.

**Arguments:**
- `contextData` (table) — A two-membered table: * string convar - The console variable to use.

[wiki](https://wiki.facepunch.com/gmod/ContextBase:ControlValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/contextbase.lua#L20-L25)

---

### ContextBase:ConVar · Client
`ContextBase:ConVar() → string`

Returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) for the panel to change/handle, set by [ContextBase:SetConVar](https://wiki.facepunch.com/gmod/ContextBase:SetConVar)

**Returns:**
- string — The ConVar for the panel to change.

[wiki](https://wiki.facepunch.com/gmod/ContextBase:ConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/contextbase.lua#L16-L18)

---

### ContextBase:SetConVar · Client
`ContextBase:SetConVar(cvar: string)`

Sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) for the panel to change/handle.

**Arguments:**
- `cvar` (string) — The ConVar for the panel to change.

[wiki](https://wiki.facepunch.com/gmod/ContextBase:SetConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/contextbase.lua#L12-L14)

---

### ContextBase:TestForChanges · Client
`ContextBase:TestForChanges()`

You should override this function and use it to check whether your convar value changed.

[wiki](https://wiki.facepunch.com/gmod/ContextBase:TestForChanges) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/contextbase.lua#L40-L45)
