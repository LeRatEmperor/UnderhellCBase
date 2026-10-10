# gmsave

**Realm:** Server  ·  **Members:** 5

The gmsave library provides functions relating to the singleplayer save system in Garry's Mod.

[wiki page](https://wiki.facepunch.com/gmod/gmsave)

### gmsave.LoadMap · Server
`gmsave.LoadMap(mapData: string, ply: Player = NULL, callback: function = nil)`

Loads a saved map.

**Arguments:**
- `mapData` (string) — The JSON encoded string containing all the map data.
- `ply` (Player, default `NULL`) — The player to load positions for.
- `callback` (function, default `nil`) — A function to be called after all the entities have been placed.

[wiki](https://wiki.facepunch.com/gmod/gmsave.LoadMap) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/gmsave.lua#L19-L75)

---

### gmsave.PlayerLoad · Server
`gmsave.PlayerLoad(ply: Player, data: table)`

Sets player position and angles from supplied table.

**Arguments:**
- `ply` (Player) — The player to "load" values for.
- `data` (table) — A table containing Origin and Angle keys for position and angles to set.

[wiki](https://wiki.facepunch.com/gmod/gmsave.PlayerLoad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/gmsave/player.lua#L14-L22)

---

### gmsave.PlayerSave · Server
`gmsave.PlayerSave(ply: Player) → table`

Returns a table containing player position and angles. Used by [gmsave.SaveMap](https://wiki.facepunch.com/gmod/gmsave.SaveMap).

**Arguments:**
- `ply` (Player) — The player to "save".

**Returns:**
- table — A table containing player position ( Origin ) and angles ( Angle ).

[wiki](https://wiki.facepunch.com/gmod/gmsave.PlayerSave) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/gmsave/player.lua#L2-L12)

---

### gmsave.SaveMap · Server
`gmsave.SaveMap(ply: Player) → string`

Saves the map.

**Arguments:**
- `ply` (Player) — The player, whose position should be saved for loading the save.

**Returns:**
- string — The encoded to JSON string containing save data.

[wiki](https://wiki.facepunch.com/gmod/gmsave.SaveMap) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/gmsave.lua#L77-L96)

---

### gmsave.ShouldSaveEntity · Server
`gmsave.ShouldSaveEntity(ent: Entity, t: table) → boolean`

Returns if we should save this entity in a duplication or a map save or not.

**Arguments:**
- `ent` (Entity) — The entity.
- `t` (table) — A table containing classname key with entities classname.

**Returns:**
- boolean — Should save entity or not.

[wiki](https://wiki.facepunch.com/gmod/gmsave.ShouldSaveEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/gmsave/entity_filters.lua#L49-L79)
