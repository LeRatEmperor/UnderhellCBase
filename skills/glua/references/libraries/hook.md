# hook

**Realm:** Shared, Menu  ·  **Members:** 5

The hook library allows you to add hooks called by the game engine, allowing multiple scripts to modify game function.

[wiki page](https://wiki.facepunch.com/gmod/hook)

### hook.Add · Shared, Menu
`hook.Add(eventName: string, identifier: any, func: function)`

Registers a function (or "callback") with the [Hook](https://wiki.facepunch.com/gmod/Hook) system so that it will be called automatically whenever a specific event (or "hook") occurs.

**Arguments:**
- `eventName` (string) — The event to hook on to.
- `identifier` (any) — The unique identifier, usually a string.
- `func` (function) — The function to be called, arguments given to it depend on the identifier used.

[wiki](https://wiki.facepunch.com/gmod/hook.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/hook.lua#L23-L34)

---

### hook.Call · Shared, Menu
`hook.Call(eventName: string, gamemodeTable: table = nil, args: vararg = nil) → vararg`

Calls all hooks associated with the given event until one returns something other than `nil`, and then returns that data.

In almost all cases, you should use [hook.Run](https://wiki.facepunch.com/gmod/hook.Run) instead - it calls hook.Call internally but supplies the gamemode table by itself, making your code neater.

**Arguments:**
- `eventName` (string) — The event to call hooks for.
- `gamemodeTable` (table, default `nil`) — If the gamemode is specified, the gamemode hook within will be called, otherwise not.
- `args` (vararg, default `nil`) — The arguments to be passed to the hooks.

**Returns:**
- vararg — Return data from called hooks.

[wiki](https://wiki.facepunch.com/gmod/hook.Call) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/hook.lua#L67-L125)

---

### hook.GetTable · Shared, Menu
`hook.GetTable() → table`

Returns a list of all the hooks registered with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add).

**Returns:**
- table — A table of tables.

[wiki](https://wiki.facepunch.com/gmod/hook.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/hook.lua#L15-L15)

---

### hook.Remove · Shared, Menu
`hook.Remove(eventName: string, identifier: any)`

Removes the hook with the supplied identifier from the given event.

**Arguments:**
- `eventName` (string) — The event name.
- `identifier` (any) — The unique identifier of the hook to remove, usually a string.

[wiki](https://wiki.facepunch.com/gmod/hook.Remove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/hook.lua#L42-L49)

---

### hook.Run · Shared, Menu
`hook.Run(eventName: string, args: vararg) → vararg`

Calls all hooks associated with the given event **until** one returns something other than `nil` and then returns that data. If no hook returns any data, it will try to call the `GAMEMODE:

**Arguments:**
- `eventName` (string) — The event to call hooks for.
- `args` (vararg) — The arguments to be passed to the hooks.

**Returns:**
- vararg — Return data from called hooks.

[wiki](https://wiki.facepunch.com/gmod/hook.Run) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/hook.lua#L57-L59)
