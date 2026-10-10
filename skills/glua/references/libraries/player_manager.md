# player_manager

**Realm:** Shared  ·  **Members:** 14

The player_manager library lets you manage players, such as setting their models or creating player classes.

[wiki page](https://wiki.facepunch.com/gmod/player_manager)

### player_manager.AddValidHands · Shared
`player_manager.AddValidHands(name: string, model: string, skin: number = 0, bodygroups: string = 0000000, matchBodySkin: boolean = false)`

Assigns view model hands to player model.

**Arguments:**
- `name` (string) — Player model name.
- `model` (string) — Hands model.
- `skin` (number, default `0`) — Skin to apply to the hands.
- `bodygroups` (string, default `0000000`) — Bodygroups to apply to the hands.
- `matchBodySkin` (boolean, default `false`) — If set to `true`, the skin of the hands will be set to the skin of the playermodel.

[wiki](https://wiki.facepunch.com/gmod/player_manager.AddValidHands) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L30-L34)

---

### player_manager.AddValidModel · Shared
`player_manager.AddValidModel(name: string, model: string)`

Associates a simplified name with a path to a valid player model.


Only used internally.

**Arguments:**
- `name` (string) — Simplified name.
- `model` (string) — Valid PlayerModel path.

[wiki](https://wiki.facepunch.com/gmod/player_manager.AddValidModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L20-L25)

---

### player_manager.AllValidModels · Shared
`player_manager.AllValidModels() → table`

Returns the entire list of valid player models.

**Returns:**
- table — List of all valid player models.

[wiki](https://wiki.facepunch.com/gmod/player_manager.AllValidModels) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L39-L41)

---

### player_manager.ClearPlayerClass · Shared
`player_manager.ClearPlayerClass(ply: Player)`

Clears a player's class association by setting their ClassID to 0.

**Arguments:**
- `ply` (Player) — Player to clear class from.

[wiki](https://wiki.facepunch.com/gmod/player_manager.ClearPlayerClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L399-L403)

---

### player_manager.GetPlayerClass · Shared
`player_manager.GetPlayerClass(ply: Player) → string`

Gets a players class.

**Arguments:**
- `ply` (Player) — Player to get class.

**Returns:**
- string — The players class.

[wiki](https://wiki.facepunch.com/gmod/player_manager.GetPlayerClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L390-L397)

---

### player_manager.GetPlayerClasses · Shared
`player_manager.GetPlayerClasses() → table`

Retrieves a copy of all registered player classes.

**Returns:**
- table — A copy of all registered player classes.

[wiki](https://wiki.facepunch.com/gmod/player_manager.GetPlayerClasses) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L300-L304)

---

### player_manager.GetPlayerClassTable · Shared
`player_manager.GetPlayerClassTable(ply: Player) → table`

Gets a players' class table.

**Arguments:**
- `ply` (Player) — Player to get class of.

**Returns:**
- table — The players class table.

[wiki](https://wiki.facepunch.com/gmod/player_manager.GetPlayerClassTable)

---

### player_manager.OnPlayerSpawn · Shared
`player_manager.OnPlayerSpawn(ply: Player, transition: boolean)`

Applies basic class variables when the player spawns.

Called from [GM:PlayerSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSpawn) in the base gamemode.

**Arguments:**
- `ply` (Player) — Player to setup.
- `transition` (boolean) — If true, the player just spawned from a map transition.

[wiki](https://wiki.facepunch.com/gmod/player_manager.OnPlayerSpawn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L421-L444)

---

### player_manager.RegisterClass · Shared
`player_manager.RegisterClass(name: string, table: table, base: string = nil)`

Register a class metatable to be assigned to players later.

**Arguments:**
- `name` (string) — Class name.
- `table` (table) — Class metatable, see Structures/PLAYER.
- `base` (string, default `nil`) — Base class name.

[wiki](https://wiki.facepunch.com/gmod/player_manager.RegisterClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L349-L374)

---

### player_manager.RunClass · Shared
`player_manager.RunClass(ply: Player, funcName: string, arguments: vararg) → vararg`

Execute a named function within the player's set class.

**Arguments:**
- `ply` (Player) — Player to execute function on.
- `funcName` (string) — Name of function.
- `arguments` (vararg) — Optional arguments.

**Returns:**
- vararg — The values returned by the called function.

[wiki](https://wiki.facepunch.com/gmod/player_manager.RunClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L405-L415)

---

### player_manager.SetPlayerClass · Shared
`player_manager.SetPlayerClass(ply: Player, className: string)`

Sets a player's class.

**Arguments:**
- `ply` (Player) — Player to set class.
- `className` (string) — Name of class to set.

[wiki](https://wiki.facepunch.com/gmod/player_manager.SetPlayerClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L376-L388)

---

### player_manager.TranslatePlayerHands · Shared
`player_manager.TranslatePlayerHands(name: string) → table`

Retrieves correct hands for given player model. By default returns citizen hands.

**Arguments:**
- `name` (string) — Player model name.

**Returns:**
- table — A table with following contents: * string model - Model of hands.

> **Note:** See [player_manager.AddValidHands](https://wiki.facepunch.com/gmod/player_manager.AddValidHands) for defining/linking hands to a model - this must be defined somewhere otherwise the model will return citizen hands here.

[wiki](https://wiki.facepunch.com/gmod/player_manager.TranslatePlayerHands) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L72-L79)

---

### player_manager.TranslatePlayerModel · Shared
`player_manager.TranslatePlayerModel(shortName: string) → string`

Returns the valid model path for a simplified name.

**Arguments:**
- `shortName` (string) — The short name of the model.

**Returns:**
- string — The valid model path for the short name.

[wiki](https://wiki.facepunch.com/gmod/player_manager.TranslatePlayerModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L48-L55)

---

### player_manager.TranslateToPlayerModelName · Shared
`player_manager.TranslateToPlayerModelName(model: string) → string`

Returns the simplified name for a valid model path of a player model.

Opposite of [player_manager.TranslatePlayerModel](https://wiki.facepunch.com/gmod/player_manager.TranslatePlayerModel).

**Arguments:**
- `model` (string) — The model path to a player model.

**Returns:**
- string — The simplified name for that model.

[wiki](https://wiki.facepunch.com/gmod/player_manager.TranslateToPlayerModelName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/player_manager.lua#L58-L67)
