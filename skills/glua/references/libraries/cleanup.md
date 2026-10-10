# cleanup

**Realm:** Shared  ·  **Members:** 8

The cleanup library allows you to control what happens to custom entities when the clean-up buttons are pressed in the Utilities tab of the Spawn menu (default Q).

[wiki page](https://wiki.facepunch.com/gmod/cleanup)

### cleanup.Add · Server
`cleanup.Add(pl: Player, type: string, ent: Entity)`

Adds an entity to a player's cleanup list.

**Arguments:**
- `pl` (Player) — Who's cleanup list to add the entity to.
- `type` (string) — The type of cleanup.
- `ent` (Entity) — The entity to add to the player's cleanup list.

[wiki](https://wiki.facepunch.com/gmod/cleanup.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L59-L74)

---

### cleanup.CC_AdminCleanup · Server · `INTERNAL`
`cleanup.CC_AdminCleanup(pl: Player, command: string, args: table)`

Called by the `gmod_admin_cleanup` console command. Allows admins to clean up the server.

**Arguments:**
- `pl` (Player) — The player that called the console command.
- `command` (string) — The console command that called this function.
- `args` (table) — First and only arg is the cleanup type.

[wiki](https://wiki.facepunch.com/gmod/cleanup.CC_AdminCleanup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L148-L200)

---

### cleanup.CC_Cleanup · Server · `INTERNAL`
`cleanup.CC_Cleanup(pl: Player, command: string, args: table)`

Called by the `gmod_cleanup` console command. Allows players to cleanup their own props.

**Arguments:**
- `pl` (Player) — The player that called the console command.
- `command` (string) — The console command that called this function.
- `args` (table) — First and only argument is the cleanup type.

[wiki](https://wiki.facepunch.com/gmod/cleanup.CC_Cleanup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L98-L146)

---

### cleanup.GetList · Server
`cleanup.GetList()`

Gets the cleanup list.

[wiki](https://wiki.facepunch.com/gmod/cleanup.GetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L40-L42)

---

### cleanup.GetTable · Shared
`cleanup.GetTable() → table`

Gets the table of cleanup types.

**Returns:**
- table — A list of cleanup types.

[wiki](https://wiki.facepunch.com/gmod/cleanup.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L31-L33)

---

### cleanup.Register · Shared
`cleanup.Register(type: string)`

Registers a new cleanup type.

**Arguments:**
- `type` (string) — Name of type.

[wiki](https://wiki.facepunch.com/gmod/cleanup.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L17-L29)

---

### cleanup.ReplaceEntity · Server
`cleanup.ReplaceEntity(from: Entity, to: Entity|nil) → boolean`

Replaces one entity in the cleanup module with another.

You very likely want to call [undo.ReplaceEntity](https://wiki.facepunch.com/gmod/undo.ReplaceEntity) with the same entities as well.

**Arguments:**
- `from` (Entity) — The old entity.
- `to` (Entity|nil) — The new entity.

**Returns:**
- boolean — Whether any action was taken.

[wiki](https://wiki.facepunch.com/gmod/cleanup.ReplaceEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L76-L95)

---

### cleanup.UpdateUI · Client · `INTERNAL`
`cleanup.UpdateUI()`

Repopulates the clients cleanup menu.

[wiki](https://wiki.facepunch.com/gmod/cleanup.UpdateUI) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cleanup.lua#L207-L236)
