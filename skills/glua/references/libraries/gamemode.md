# gamemode

**Realm:** Shared  ·  **Members:** 3

The gamemode library provides functions relating to the gamemode system in Garry's Mod. This entire library also passes through the C -> Lua bridge.

[wiki page](https://wiki.facepunch.com/gmod/gamemode)

### gamemode.Call · Shared
`gamemode.Call(name: string, args: vararg) → any`

Called by the engine to call a hook within the loaded gamemode.

The supplied event 'name' must be defined in the active gamemode. Otherwise, nothing will happen - not even hooks added with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add) will be called.

This is similar to [hook.Run](https://wiki.facepunch.com/gmod/hook.Run) and [hook.Call](https://wiki.facepunch.com/gmod/hook.Call), except the hook library will call hooks created with hook.Add even if there is no corresponding gamemode function.

**Arguments:**
- `name` (string) — The name of the hook to call.
- `args` (vararg) — The arguments.

**Returns:**
- any — The result of the hook function - can be up to 6 values.

[wiki](https://wiki.facepunch.com/gmod/gamemode.Call) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/gamemode.lua#L74-L83)

---

### gamemode.Get · Shared · `INTERNAL`
`gamemode.Get(name: string) → table`

This returns the internally stored gamemode table.

**Arguments:**
- `name` (string) — The name of the gamemode you want to get.

**Returns:**
- table — The gamemode's table.

[wiki](https://wiki.facepunch.com/gmod/gamemode.Get) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/gamemode.lua#L66-L68)

---

### gamemode.Register · Shared · `INTERNAL`
`gamemode.Register(gm: table, name: string, derived: string)`

Called by the engine when a gamemode is being loaded.

**Arguments:**
- `gm` (table) — Your GM table.
- `name` (string) — Name of your gamemode, lowercase, no spaces.
- `derived` (string) — The gamemode name that your gamemode is derived from.

[wiki](https://wiki.facepunch.com/gmod/gamemode.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/gamemode.lua#L20-L60)
