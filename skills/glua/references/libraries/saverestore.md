# saverestore

**Realm:** Shared  ·  **Members:** 13

The saverestore library contains functions relating to the singleplayer save system built into the game.

[wiki page](https://wiki.facepunch.com/gmod/saverestore)

### saverestore.AddRestoreHook · Shared
`saverestore.AddRestoreHook(identifier: string, callback: function)`

Adds a restore/load hook for the Half-Life 2 save system.

**Arguments:**
- `identifier` (string) — The unique identifier for this hook.
- `callback` (function) — The function to be called when an engine save is being loaded.

[wiki](https://wiki.facepunch.com/gmod/saverestore.AddRestoreHook) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L362-L369)

---

### saverestore.AddSaveHook · Shared
`saverestore.AddSaveHook(identifier: string, callback: function)`

Adds a save hook for the Half-Life 2 save system. You can use this to carry data through level transitions in Half-Life 2.

**Arguments:**
- `identifier` (string) — The unique identifier for this hook.
- `callback` (function) — The function to be called when an engine save is being saved.

[wiki](https://wiki.facepunch.com/gmod/saverestore.AddSaveHook) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L348-L355)

---

### saverestore.LoadEntity · Shared
`saverestore.LoadEntity(ent: Entity, save: IRestore)`

Loads [Entity:GetTable](https://wiki.facepunch.com/gmod/Entity:GetTable) from the save game file that is being loaded and merges it with the given entitys [Entity:GetTable](https://wiki.facepunch.com/gmod/Entity:GetTable).

**Arguments:**
- `ent` (Entity) — The entity which will receive the loaded values from the save.
- `save` (IRestore) — The restore object to read the Entity:GetTable from.

[wiki](https://wiki.facepunch.com/gmod/saverestore.LoadEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L325-L341)

---

### saverestore.LoadGlobal · Shared · `INTERNAL`
`saverestore.LoadGlobal(save: IRestore)`

Called by engine when a save is being loaded.

This handles loading gamemode and calls all of the hooks added with [saverestore.AddRestoreHook](https://wiki.facepunch.com/gmod/saverestore.AddRestoreHook).

**Arguments:**
- `save` (IRestore) — The restore object to read data from the save file with.

[wiki](https://wiki.facepunch.com/gmod/saverestore.LoadGlobal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L399-L425)

---

### saverestore.PreRestore · Shared · `INTERNAL`
`saverestore.PreRestore()`

Called by the engine just before [saverestore.LoadGlobal](https://wiki.facepunch.com/gmod/saverestore.LoadGlobal) is.

[wiki](https://wiki.facepunch.com/gmod/saverestore.PreRestore) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L55-L60)

---

### saverestore.PreSave · Shared · `INTERNAL`
`saverestore.PreSave()`

Called by the engine just before [saverestore.SaveGlobal](https://wiki.facepunch.com/gmod/saverestore.SaveGlobal) is.

[wiki](https://wiki.facepunch.com/gmod/saverestore.PreSave) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L48-L53)

---

### saverestore.ReadTable · Shared
`saverestore.ReadTable(save: IRestore) → table`

Reads a table from the save game file that is being loaded.

**Arguments:**
- `save` (IRestore) — The restore object to read the table from.

**Returns:**
- table — The table that has been read, if any

[wiki](https://wiki.facepunch.com/gmod/saverestore.ReadTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L264-L304)

---

### saverestore.ReadVar · Shared
`saverestore.ReadVar(save: IRestore) → any`

Loads a variable from the save game file that is being loaded.

Variables will be read in the save order you have saved them.

**Arguments:**
- `save` (IRestore) — The restore object to read variables from.

**Returns:**
- any — The variable that was read, if any.

[wiki](https://wiki.facepunch.com/gmod/saverestore.ReadVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L178-L207)

---

### saverestore.SaveEntity · Shared
`saverestore.SaveEntity(ent: Entity, save: ISave)`

Saves entitys [Entity:GetTable](https://wiki.facepunch.com/gmod/Entity:GetTable) to the save game file that is being saved.

**Arguments:**
- `ent` (Entity) — The entity to save Entity:GetTable of.
- `save` (ISave) — The save object to save Entity:GetTable to.

[wiki](https://wiki.facepunch.com/gmod/saverestore.SaveEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L311-L319)

---

### saverestore.SaveGlobal · Shared · `INTERNAL`
`saverestore.SaveGlobal(save: ISave)`

Called by engine when a save is being saved.

This handles saving gamemode and calls all of the hooks added with [saverestore.AddSaveHook](https://wiki.facepunch.com/gmod/saverestore.AddSaveHook).

**Arguments:**
- `save` (ISave) — The save object to write data into the save file.

[wiki](https://wiki.facepunch.com/gmod/saverestore.SaveGlobal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L376-L392)

---

### saverestore.WritableKeysInTable · Shared
`saverestore.WritableKeysInTable(table: table) → number`

Returns how many writable keys are in the given table.

**Arguments:**
- `table` (table) — The table to test.

**Returns:**
- number — The number of keys that can be written with saverestore.WriteTable.

[wiki](https://wiki.facepunch.com/gmod/saverestore.WritableKeysInTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L125-L137)

---

### saverestore.WriteTable · Shared
`saverestore.WriteTable(table: table, save: ISave)`

Write a table to a save game file that is being saved.

**Arguments:**
- `table` (table) — The table to write
- `save` (ISave) — The save object to write the table to.

[wiki](https://wiki.facepunch.com/gmod/saverestore.WriteTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L213-L258)

---

### saverestore.WriteVar · Shared
`saverestore.WriteVar(value: any, save: ISave)`

Writes a variable to the save game file that is being saved.

**Arguments:**
- `value` (any) — The value to save.
- `save` (ISave) — The save object to write the variable to.

[wiki](https://wiki.facepunch.com/gmod/saverestore.WriteVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/saverestore.lua#L144-L171)
