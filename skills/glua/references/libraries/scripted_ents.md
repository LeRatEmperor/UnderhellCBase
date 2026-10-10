# scripted_ents

**Realm:** Shared  ·  **Members:** 10

The scripted_ents library allows you to access information about any scripted entities loaded into the game, as well as register your own entities.

[wiki page](https://wiki.facepunch.com/gmod/scripted_ents)

### scripted_ents.Alias · Shared
`scripted_ents.Alias(alias: string, classname: string)`

Defines an alias string that can be used to refer to another classname

**Arguments:**
- `alias` (string) — A new string which can be used to refer to another classname
- `classname` (string) — The classname the alias should refer to

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.Alias) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L253-L257)

---

### scripted_ents.Get · Shared · `INTERNAL`
`scripted_ents.Get(classname: string) → table`

Returns a copy of the ENT table for a class, including functions defined by the base class

**Arguments:**
- `classname` (string) — The classname of the ENT table to return, can be an alias

**Returns:**
- table — entTable

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.Get) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L156-L190)

---

### scripted_ents.GetList · Shared
`scripted_ents.GetList() → table<string, table>`

Returns a copy of the list of all ENT tables registered

**Returns:**
- table<string, table> — A table of all SENTs where the key is the classname and the value is a table where: * table t — The ENT table associated with the entity * boolean isBaseType — Unused.

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.GetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L225-L233)

---

### scripted_ents.GetMember · Shared
`scripted_ents.GetMember(class: string, name: string) → any`

Retrieves a member of entity's table.

**Arguments:**
- `class` (string) — Entity's class name
- `name` (string) — Name of member to retrieve

**Returns:**
- any — The member or nil if failed

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.GetMember) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L259-L275)

---

### scripted_ents.GetSpawnable · Shared
`scripted_ents.GetSpawnable() → table`

Returns a list of all ENT tables which contain ENT.Spawnable

**Returns:**
- table — A table of Structures/ENTs

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.GetSpawnable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L235-L251)

---

### scripted_ents.GetStored · Shared
`scripted_ents.GetStored(classname: string) → table`

Returns the actual ENT table for a class. Modifying functions/variables in this table will change newly spawned entities

**Arguments:**
- `classname` (string) — The classname of the ENT table to return

**Returns:**
- table — entTable

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.GetStored) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L217-L219)

---

### scripted_ents.GetType · Shared
`scripted_ents.GetType(classname: string) → string`

Returns the 'type' of a class, this will one of the following: 'anim', 'ai', 'brush', 'point'.

**Arguments:**
- `classname` (string) — The classname to check

**Returns:**
- string — type

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.GetType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L192-L211)

---

### scripted_ents.IsBasedOn · Shared
`scripted_ents.IsBasedOn(name: string, base: string) → boolean`

Checks if name is based on base

**Arguments:**
- `name` (string) — Entity's class name to be checked
- `base` (string) — Base class name to be checked

**Returns:**
- boolean — Returns true if class name is based on base, else false.

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.IsBasedOn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L44-L51)

---

### scripted_ents.OnLoaded · Shared · `INTERNAL`
`scripted_ents.OnLoaded()`

Called after all ENTS have been loaded and runs [baseclass.Set](https://wiki.facepunch.com/gmod/baseclass.Set) on each one.

You can retrieve all the currently registered ENTS with [scripted_ents.GetList](https://wiki.facepunch.com/gmod/scripted_ents.GetList).

> **Note:** This is not called after an ENT auto refresh, and thus the inherited baseclass functions retrieved with [baseclass.Get](https://wiki.facepunch.com/gmod/baseclass.Get) will not be updated

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.OnLoaded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L141-L154)

---

### scripted_ents.Register · Shared
`scripted_ents.Register(ENT: table, classname: string)`

Registers an ENT table with a classname. Reregistering an existing classname will automatically update the functions of all existing entities of that class.

**Arguments:**
- `ENT` (table) — The ENT table to register.
- `classname` (string) — The classname to register.

> **Bug:** Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied.

[wiki](https://wiki.facepunch.com/gmod/scripted_ents.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L53-L136)
