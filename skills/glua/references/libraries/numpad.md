# numpad

**Realm:** Server  ·  **Members:** 8

The numpad module allows you to execute functions on a key press or release.

[wiki page](https://wiki.facepunch.com/gmod/numpad)

### numpad.Activate · Server
`numpad.Activate(ply: Player, key: number, isButton: boolean = false)`

Activates numpad key owned by the player

**Arguments:**
- `ply` (Player) — The player whose numpad should be simulated
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key to press, see KEY
- `isButton` (boolean, default `false`) — Should this keypress pretend to be a from a `gmod_button`?

[wiki](https://wiki.facepunch.com/gmod/numpad.Activate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L96-L117)

---

### numpad.Deactivate · Server
`numpad.Deactivate(ply: Player, key: number, isButton: boolean = false)`

Deactivates numpad key owned by the player

**Arguments:**
- `ply` (Player) — The player whose numpad should be simulated
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key to press, corresponding to KEY
- `isButton` (boolean, default `false`) — Should this keypress pretend to be a from a `gmod_button`?

[wiki](https://wiki.facepunch.com/gmod/numpad.Deactivate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L122-L140)

---

### numpad.FromButton · Server
`numpad.FromButton() → boolean`

Returns true during a function added with [numpad.Register](https://wiki.facepunch.com/gmod/numpad.Register) when the third argument to [numpad.Activate](https://wiki.facepunch.com/gmod/numpad.Activate) is true.

This is caused when a numpad function is triggered by a button SENT being used.

**Returns:**
- boolean — wasButton

[wiki](https://wiki.facepunch.com/gmod/numpad.FromButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L30-L34)

---

### numpad.OnDown · Server
`numpad.OnDown(ply: Player, key: number, name: string, ...: vararg) → number`

Calls a function registered with [numpad.Register](https://wiki.facepunch.com/gmod/numpad.Register) when a player presses specified key.

See for key released action: [numpad.OnUp](https://wiki.facepunch.com/gmod/numpad.OnUp)

**Arguments:**
- `ply` (Player) — The player whose numpad should be watched
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, corresponding to KEY
- `name` (string) — The name of the function to run, corresponding with the one used in numpad.Register
- `...` (vararg) — Arguments to pass to the function passed to numpad.Register.

**Returns:**
- number — The impulse ID

[wiki](https://wiki.facepunch.com/gmod/numpad.OnDown) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L174-L188)

---

### numpad.OnUp · Server
`numpad.OnUp(ply: Player, key: number, name: string, ...: vararg) → number`

Calls a function registered with [numpad.Register](https://wiki.facepunch.com/gmod/numpad.Register) when a player releases specified key.

See for key pressed action: [numpad.OnDown](https://wiki.facepunch.com/gmod/numpad.OnDown)

**Arguments:**
- `ply` (Player) — The player whose numpad should be watched
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, corresponding to KEY
- `name` (string) — The name of the function to run, corresponding with the one used in numpad.Register
- `...` (vararg) — Arguments to pass to the function passed to numpad.Register.

**Returns:**
- number — The impulse ID

[wiki](https://wiki.facepunch.com/gmod/numpad.OnUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L193-L207)

---

### numpad.Register · Server
`numpad.Register(id: string, func: function)`

Registers a numpad library action for use with [numpad.OnDown](https://wiki.facepunch.com/gmod/numpad.OnDown) and [numpad.OnUp](https://wiki.facepunch.com/gmod/numpad.OnUp)

**Arguments:**
- `id` (string) — The unique id of your action.
- `func` (function) — The function to be executed.

[wiki](https://wiki.facepunch.com/gmod/numpad.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L243-L247)

---

### numpad.Remove · Server
`numpad.Remove(ID: number)`

Removes a function added by either [numpad.OnUp](https://wiki.facepunch.com/gmod/numpad.OnUp) or [numpad.OnDown](https://wiki.facepunch.com/gmod/numpad.OnDown)

**Arguments:**
- `ID` (number) — The impulse ID returned by numpad.OnUp or numpad.OnDown

[wiki](https://wiki.facepunch.com/gmod/numpad.Remove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L231-L238)

---

### numpad.Toggle · Server
`numpad.Toggle(ply: Player, key: number)`

Either runs [numpad.Activate](https://wiki.facepunch.com/gmod/numpad.Activate) or [numpad.Deactivate](https://wiki.facepunch.com/gmod/numpad.Deactivate) depending on the key's current state

**Arguments:**
- `ply` (Player) — The player whose numpad should be simulated
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key to press, corresponding to KEY

[wiki](https://wiki.facepunch.com/gmod/numpad.Toggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/numpad.lua#L145-L154)
