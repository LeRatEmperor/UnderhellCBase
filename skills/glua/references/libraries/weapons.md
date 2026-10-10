# weapons

**Realm:** Shared  ·  **Members:** 6

The weapons library allows you to access information about any scripted weapons loaded into the game, as well as register your own weapons.

[wiki page](https://wiki.facepunch.com/gmod/weapons)

### weapons.Get · Shared
`weapons.Get(classname: string) → table`

Get a `copy` of weapon table by name. This function also inherits fields from the weapon's base class, unlike [weapons.GetStored](https://wiki.facepunch.com/gmod/weapons.GetStored) or [weapons.GetList](https://wiki.facepunch.com/gmod/weapons.GetList).

**Arguments:**
- `classname` (string) — Class name of weapon to retrieve

**Returns:**
- table — The retrieved table or nil

> **Note:** This will only work on SWEP's, this means that this will not return anything for HL2/HL:S weapons.

[wiki](https://wiki.facepunch.com/gmod/weapons.Get) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L131-L162)

---

### weapons.GetList · Shared
`weapons.GetList() → table`

Get a list of all the registered SWEPs. This does not include weapons added to spawnmenu manually.

**Returns:**
- table — List of all the registered SWEPs

> **Note:** This function does not inherit fields from the weapon's base class, unlike [weapons.Get](https://wiki.facepunch.com/gmod/weapons.Get)

[wiki](https://wiki.facepunch.com/gmod/weapons.GetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L176-L184)

---

### weapons.GetStored · Shared
`weapons.GetStored(weapon_class: string) → table`

Gets the REAL weapon table, not a copy. The produced table does *not* inherit fields from the weapon's base class, unlike [weapons.Get](https://wiki.facepunch.com/gmod/weapons.Get).

**Arguments:**
- `weapon_class` (string) — Weapon class to retrieve weapon table of

**Returns:**
- table — The weapon table

> **Warning:** Modifying this table will modify what is stored by the weapons library. Take a copy or use [weapons.Get](https://wiki.facepunch.com/gmod/weapons.Get) to avoid this.

[wiki](https://wiki.facepunch.com/gmod/weapons.GetStored) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L168-L170)

---

### weapons.IsBasedOn · Shared
`weapons.IsBasedOn(name: string, base: string) → boolean`

Checks if name is based on base

**Arguments:**
- `name` (string) — Entity's class name to be checked
- `base` (string) — Base class name to be checked

**Returns:**
- boolean — Returns true if class name is based on base, else false.

[wiki](https://wiki.facepunch.com/gmod/weapons.IsBasedOn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L32-L39)

---

### weapons.OnLoaded · Shared · `INTERNAL`
`weapons.OnLoaded()`

Called after all SWEPS have been loaded and runs [baseclass.Set](https://wiki.facepunch.com/gmod/baseclass.Set) on each one.

You can retrieve all the currently registered SWEPS with [weapons.GetList](https://wiki.facepunch.com/gmod/weapons.GetList).

> **Note:** This is not called after a SWEP auto refresh, and thus the inherited baseclass functions retrieved with [baseclass.Get](https://wiki.facepunch.com/gmod/baseclass.Get) will not be updated

[wiki](https://wiki.facepunch.com/gmod/weapons.OnLoaded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L112-L125)

---

### weapons.Register · Shared
`weapons.Register(ENT: table, classname: string)`

Registers a Scripted Weapon (SWEP) class manually. When the engine spawns an entity, weapons registered with this function will be created if the class names match.

See also [scripted_ents.Register](https://wiki.facepunch.com/gmod/scripted_ents.Register) for Scripted Entities (SENTs)

**Arguments:**
- `ENT` (table) — The SWEP table to register.
- `classname` (string) — Classname to assign to that swep

> **Bug:** Sub-tables provided in the first argument will not carry over their metatable, and will receive a BaseClass key if the table was merged with the base's. Userdata references, which includes Vectors, Angles, Entities, etc. will not be copied.

[wiki](https://wiki.facepunch.com/gmod/weapons.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L46-L107)
