# concommand

**Realm:** Shared, Menu  ·  **Members:** 5

The concommand library is used to create console commands which can be used to network (basic) information & events between the client and the server.

[wiki page](https://wiki.facepunch.com/gmod/concommand)

### concommand.Add · Shared, Menu
`concommand.Add(name: string, callback: function, autoComplete: function = nil, helpText: string = nil, flags: number{FCVAR}|table<number> = 0)`

Creates a console command that runs a function in lua with optional autocompletion function and help text.

**Arguments:**
- `name` (string) — The command name to be used in console.
- `callback` (function) — The function to run when the concommand is executed.
- `autoComplete` (function, default `nil`) — The function to call which should return a table of options for autocompletion.
- `helpText` (string, default `nil`) — The text to display should a user run 'help cmdName'.
- `flags` (number{FCVAR}|table<number>, default `0`) — Console command modifier flags.

> **Warning:** Clients can still run commands created only on the server. Always check permissions in the callback.
> **Bug** ([#1183](https://github.com/Facepunch/garrysmod/issues/1183)): This will fail if the concommand was previously removed with [concommand.Remove](https://wiki.facepunch.com/gmod/concommand.Remove) in a different realm (creating a command on the client that was removed from the server and vice-versa).

[wiki](https://wiki.facepunch.com/gmod/concommand.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/concommand.lua#L28-L33)

---

### concommand.AutoComplete · Shared, Menu · `INTERNAL`
`concommand.AutoComplete(command: string, arguments: string) → table`

Used by the engine to call the autocomplete function for a console command, and retrieve returned options.

**Arguments:**
- `command` (string) — Name of command.
- `arguments` (string) — Arguments given to the command.

**Returns:**
- table — Possibilities for auto-completion.

[wiki](https://wiki.facepunch.com/gmod/concommand.AutoComplete) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/concommand.lua#L67-L75)

---

### concommand.GetTable · Shared, Menu
`concommand.GetTable() → table<string,function>, table<string,function>`

Returns the tables of all console command callbacks, and autocomplete functions, that were added to the game with [concommand.Add](https://wiki.facepunch.com/gmod/concommand.Add).

**Returns:**
- table<string,function> — Table of command callback functions.
- table<string,function> — Table of command autocomplete functions.

[wiki](https://wiki.facepunch.com/gmod/concommand.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/concommand.lua#L20-L22)

---

### concommand.Remove · Shared, Menu
`concommand.Remove(name: string)`

Removes a console command.

**Arguments:**
- `name` (string) — The name of the command to be removed.

> **Bug** ([#1183](https://github.com/Facepunch/garrysmod/issues/1183)): [concommand.Add](https://wiki.facepunch.com/gmod/concommand.Add) will fail if the concommand was previously removed with this function in a different realm (creating a command on the client that was removed from the server and vice-versa).

[wiki](https://wiki.facepunch.com/gmod/concommand.Remove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/concommand.lua#L39-L43)

---

### concommand.Run · Shared, Menu · `INTERNAL`
`concommand.Run(ply: Player, cmd: string, args: any, argumentString: string) → boolean`

Used by the engine to run a console command's callback function. This will only be called for commands that were added with [AddConsoleCommand](https://wiki.facepunch.com/gmod/Global.AddConsoleCommand), which [concommand.Add](https://wiki.facepunch.com/gmod/concommand.Add) calls internally. An error is sent to the player's console if no callback is found.

This will still be called for concommands removed with [concommand.Remove](https://wiki.facepunch.com/gmod/concommand.Remove) but will return false. This will not be called for concommands added by the engine, only those made from Lua.

**Arguments:**
- `ply` (Player) — Player to run concommand on.
- `cmd` (string) — Command name.
- `args` (any) — Command arguments.
- `argumentString` (string) — string of all arguments sent to the command.

**Returns:**
- boolean — `true` if the console command with the given name exists, and `false` if it doesn't.

[wiki](https://wiki.facepunch.com/gmod/concommand.Run) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/concommand.lua#L49-L61)
