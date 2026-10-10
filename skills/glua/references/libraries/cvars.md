# cvars

**Realm:** Shared, Menu  ·  **Members:** 7

The cvars library allows you to control what happens when a cvar (console variable) is changed.

[wiki page](https://wiki.facepunch.com/gmod/cvars)

### cvars.AddChangeCallback · Shared, Menu
`cvars.AddChangeCallback(name: string, callback: function, identifier: string = nil)`

Adds a callback to be called when the named convar changes.

**Arguments:**
- `name` (string) — The name of the convar to add the change callback to.
- `callback` (function) — The function to be called when the convar changes.
- `identifier` (string, default `nil`) — If set, you will be able to remove the callback using cvars.RemoveChangeCallback.

> **Bug** ([#1440](https://github.com/Facepunch/garrysmod/issues/1440)): This does not callback convars in the menu state.
> **Bug** ([#3503](https://github.com/Facepunch/garrysmod/issues/3503)): This does not callback convars on the client with FCVAR_GAMEDLL and convars on the server without FCVAR_GAMEDLL.
> **Bug** ([#3740](https://github.com/Facepunch/garrysmod/issues/3740)): This does not callback convars on the client with FCVAR_REPLICATED.

[wiki](https://wiki.facepunch.com/gmod/cvars.AddChangeCallback) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L58-L81)

---

### cvars.Bool · Shared, Menu
`cvars.Bool(cvar: string, default: boolean = nil) → boolean`

Retrieves console variable as a boolean.

**Arguments:**
- `cvar` (string) — Name of console variable.
- `default` (boolean, default `nil`) — The value to return if the console variable does not exist.

**Returns:**
- boolean — Retrieved value.

[wiki](https://wiki.facepunch.com/gmod/cvars.Bool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L122-L128)

---

### cvars.GetConVarCallbacks · Shared, Menu
`cvars.GetConVarCallbacks(name: string, createIfNotFound: boolean = false) → table`

Returns a table of the given [ConVar](https://wiki.facepunch.com/gmod/ConVar)s callbacks.

**Arguments:**
- `name` (string) — The name of the ConVar.
- `createIfNotFound` (boolean, default `false`) — Whether or not to create the internal callback table for given ConVar if there isn't one yet.

**Returns:**
- table — A table of the convar's callbacks, or nil if the convar doesn't exist.

[wiki](https://wiki.facepunch.com/gmod/cvars.GetConVarCallbacks) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L21-L31)

---

### cvars.Number · Shared, Menu
`cvars.Number(cvar: string, default: any = nil) → number`

Retrieves console variable as a number.

**Arguments:**
- `cvar` (string) — Name of console variable.
- `default` (any, default `nil`) — The value to return if the console variable does not exist.

**Returns:**
- number — Retrieved value or the second argument if the console variable does not exist.

[wiki](https://wiki.facepunch.com/gmod/cvars.Number) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L114-L120)

---

### cvars.OnConVarChanged · Shared, Menu · `INTERNAL`
`cvars.OnConVarChanged(name: string, oldVal: string, newVal: string)`

Called by the engine when a convar value changes.

**Arguments:**
- `name` (string) — Convar name.
- `oldVal` (string) — The old value of the convar.
- `newVal` (string) — The new value of the convar.

[wiki](https://wiki.facepunch.com/gmod/cvars.OnConVarChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L37-L52)

---

### cvars.RemoveChangeCallback · Shared, Menu
`cvars.RemoveChangeCallback(name: string, indentifier: string)`

Removes a callback for a convar using the the callback's identifier. The identifier should be the third argument specified for [cvars.AddChangeCallback](https://wiki.facepunch.com/gmod/cvars.AddChangeCallback).

**Arguments:**
- `name` (string) — The name of the convar to remove the callback from.
- `indentifier` (string) — The callback's identifier.

[wiki](https://wiki.facepunch.com/gmod/cvars.RemoveChangeCallback) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L87-L104)

---

### cvars.String · Shared, Menu
`cvars.String(cvar: string, default: any = nil) → string`

Retrieves console variable as a string.

**Arguments:**
- `cvar` (string) — Name of console variable.
- `default` (any, default `nil`) — The value to return if the console variable does not exist.

**Returns:**
- string — Retrieved value.

[wiki](https://wiki.facepunch.com/gmod/cvars.String) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cvars.lua#L106-L112)
