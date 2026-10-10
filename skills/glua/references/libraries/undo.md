# undo

**Realm:** Shared  ·  **Members:** 11

The undo library allows you to add custom entities to the undo list, allowing users to "undo" their creation with their undo (default: ) key.

[wiki page](https://wiki.facepunch.com/gmod/undo)

### undo.AddEntity · Server
`undo.AddEntity(ent: Entity)`

Adds an entity to the current undo block

**Arguments:**
- `ent` (Entity) — The entity to add

[wiki](https://wiki.facepunch.com/gmod/undo.AddEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L237-L244)

---

### undo.AddFunction · Server
`undo.AddFunction(func: function, arguments: vararg)`

Adds a function to call when the current undo block is undone. Note that if an undo has a function, the player will always be notified when this undo is performed, even if the entity it is meant to undo no longer exists.

**Arguments:**
- `func` (function) — The function to call.
- `arguments` (vararg) — Arguments to pass to the function (after the undo info table)

[wiki](https://wiki.facepunch.com/gmod/undo.AddFunction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L249-L256)

---

### undo.Create · Server
`undo.Create(name: string)`

Begins a new undo entry

**Arguments:**
- `name` (string) — Name of the undo message to show to players

[wiki](https://wiki.facepunch.com/gmod/undo.Create) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L213-L221)

---

### undo.Do_Undo · Server
`undo.Do_Undo(tab: table{Undo}) → number`

Processes an undo block (in table form). This is used internally by the undo manager when a player presses Z.

You should use `gmod_undo` or `gmod_undonum *num*` console commands instead of calling this function directly.

**Arguments:**
- `tab` (table{Undo}) — The undo block to process as an Structures/Undo

**Returns:**
- number — Number of removed entities

[wiki](https://wiki.facepunch.com/gmod/undo.Do_Undo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L355-L395)

---

### undo.Finish · Server
`undo.Finish(NiceText: string = nil)`

Completes an undo entry, and registers it with the player's client

**Arguments:**
- `NiceText` (string, default `nil`) — Text that appears in the player's undo history.

[wiki](https://wiki.facepunch.com/gmod/undo.Finish) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L318-L350)

---

### undo.GetTable · Shared
`undo.GetTable() → table<table{Undo}>`

Serverside, returns a table containing all undo blocks of all players. Clientside, returns a table of the local player's undo blocks.

**Returns:**
- table<table{Undo}> — The undo table.

> **Note:** Serverside, this table's keys use [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) to store a player's undo blocks.

[wiki](https://wiki.facepunch.com/gmod/undo.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L187-L189)

---

### undo.MakeUIDirty · Client · `INTERNAL`
`undo.MakeUIDirty()`

Makes the UI dirty - it will re-create the controls the next time it is viewed.

[wiki](https://wiki.facepunch.com/gmod/undo.MakeUIDirty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L116-L120)

---

### undo.ReplaceEntity · Server
`undo.ReplaceEntity(from: Entity, to: Entity|nil) → boolean`

Replaces any instance of the "from" reference with the "to" reference, in any existing undo block.

You very likely want to call [cleanup.ReplaceEntity](https://wiki.facepunch.com/gmod/cleanup.ReplaceEntity) with the same entities as well.

**Arguments:**
- `from` (Entity) — The old entity
- `to` (Entity|nil) — The new entity to replace the old one.

**Returns:**
- boolean — Whether the entity was replaced

[wiki](https://wiki.facepunch.com/gmod/undo.ReplaceEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L261-L282)

---

### undo.SetCustomUndoText · Server
`undo.SetCustomUndoText(customText: string)`

Sets a custom undo text for the current undo block

**Arguments:**
- `customText` (string) — The text to display when the undo block is undone

[wiki](https://wiki.facepunch.com/gmod/undo.SetCustomUndoText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L226-L232)

---

### undo.SetPlayer · Server
`undo.SetPlayer(ply: Player)`

Sets the player which the current undo block belongs to

**Arguments:**
- `ply` (Player) — The player responsible for undoing the block

[wiki](https://wiki.facepunch.com/gmod/undo.SetPlayer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L288-L295)

---

### undo.SetupUI · Client · `INTERNAL`
`undo.SetupUI()`

Adds a hook (CPanelPaint) to the control panel paint function so we can determine when it is being drawn.

[wiki](https://wiki.facepunch.com/gmod/undo.SetupUI) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L149-L160)
