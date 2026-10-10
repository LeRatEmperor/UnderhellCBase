# baseclass

**Realm:** Shared, Menu  ·  **Members:** 2

The baseclass library. Used to lookup a field from a metatable.

[wiki page](https://wiki.facepunch.com/gmod/baseclass)

### baseclass.Get · Shared, Menu
`baseclass.Get(name: string) → table`

Gets the base class of an an object.

	This is used not just by entities, but also by widgets, panels, drive modes, weapons and gamemodes (with "gamemode_" prefix).

	The keyword **DEFINE_BASECLASS** translates into a call to this function. In the engine, it is replaced with:

	```lua
	local BaseClass = baseclass.Get
```

	

	For more information, including usage examples, see the [BaseClasses](https://wiki.facepunch.com/gmod/BaseClasses) reference page.

**Arguments:**
- `name` (string) — The child class.

**Returns:**
- table — The base class's meta table.

> **Note:** You should prefer using this instead of `self.BaseClass` to avoid infinite recursion.

[wiki](https://wiki.facepunch.com/gmod/baseclass.Get) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/baseclass.lua#L32-L41)

---

### baseclass.Set · Shared, Menu
`baseclass.Set(name: string, tab: table)`

Add a new base class that can be derived by others. This is done automatically for:
* [panels](vgui.Register)
* [drive modes](drive.Register)
* [entities and widgets](scripted_ents.Register)
* [weapons](weapons.Register)
* [gamemodes](gamemode.Register) (with prefix "gamemode_")

For more information, including usage examples, see the [BaseClasses](https://wiki.facepunch.com/gmod/BaseClasses) reference page.

**Arguments:**
- `name` (string) — The name of this base class.
- `tab` (table) — The base class.

[wiki](https://wiki.facepunch.com/gmod/baseclass.Set) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/baseclass.lua#L43-L58)
