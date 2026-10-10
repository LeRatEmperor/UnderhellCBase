# presets

**Realm:** Client  ·  **Members:** 7

The presets library lets you add and modify the pre-set options for scripted tools (selected via the white bar at the top of each tools control panel).

[wiki page](https://wiki.facepunch.com/gmod/presets)

### presets.Add · Client
`presets.Add(groupname: string, name: string, values: table)`

Adds preset to a preset group.

**Arguments:**
- `groupname` (string) — The preset group name, usually it's tool class name.
- `name` (string) — Preset name, must be unique.
- `values` (table) — A table of preset console commands.

[wiki](https://wiki.facepunch.com/gmod/presets.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L33-L45)

---

### presets.BadNameAlert · Client · `INTERNAL`
`presets.BadNameAlert()`

Used internally to tell the player that the name they tried to use in their preset is not acceptable.

[wiki](https://wiki.facepunch.com/gmod/presets.BadNameAlert) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L78-L82)

---

### presets.Exists · Client
`presets.Exists(type: string, name: string) → boolean`

Returns whether a preset with given name exists or not

**Arguments:**
- `type` (string) — The preset group name, usually it's tool class name.
- `name` (string) — Name of the preset to test

**Returns:**
- boolean — true if the preset does exist

[wiki](https://wiki.facepunch.com/gmod/presets.Exists) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L20-L31)

---

### presets.GetTable · Client
`presets.GetTable(groupname: string) → table`

Returns a table with preset names and values from a single preset group.

**Arguments:**
- `groupname` (string) — Preset group name.

**Returns:**
- table — All presets in specified group.

[wiki](https://wiki.facepunch.com/gmod/presets.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L8-L18)

---

### presets.OverwritePresetPrompt · Client · `INTERNAL`
`presets.OverwritePresetPrompt(callback: function)`

Used internally to ask the player if they want to override an already existing preset.

**Arguments:**
- `callback` (function)

[wiki](https://wiki.facepunch.com/gmod/presets.OverwritePresetPrompt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L84-L88)

---

### presets.Remove · Client
`presets.Remove(groupname: string, name: string)`

Removes a preset entry from a preset group.

**Arguments:**
- `groupname` (string) — Preset group to remove from
- `name` (string) — Name of preset to remove

[wiki](https://wiki.facepunch.com/gmod/presets.Remove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L63-L75)

---

### presets.Rename · Client
`presets.Rename(groupname: string, oldname: string, newname: string)`

Renames preset.

**Arguments:**
- `groupname` (string) — Preset group name
- `oldname` (string) — Old preset name
- `newname` (string) — New preset name

[wiki](https://wiki.facepunch.com/gmod/presets.Rename) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/presets.lua#L47-L61)
