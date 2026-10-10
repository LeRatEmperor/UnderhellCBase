# list

**Realm:** Shared, Menu  ·  **Members:** 9

The list library allows you add and retrieve values to and from lists. The list library is basically a fancy wrapper for a table, but with much more limited functionality.

It is used extensively in the built-in Sandbox gamemode for addon-extensible lists of things (list of wheel models, list of thruster effects, etc) , without using global tables for this task.

See [Default Lists](https://wiki.facepunch.com/gmod/Default%20Lists) for a page of default Sandbox lists.

[wiki page](https://wiki.facepunch.com/gmod/list)

### list.Add · Shared, Menu
`list.Add(identifier: string, item: any) → number`

Adds an item to a named list.

**Arguments:**
- `identifier` (string) — The list identifier.
- `item` (any) — The item to add to the list.

**Returns:**
- number — The index at which the item was added.

[wiki](https://wiki.facepunch.com/gmod/list.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L57-L62)

---

### list.Contains · Shared, Menu
`list.Contains(list: string, value: any) → boolean`

Returns true if the list contains the value. (as a value - not a key)

For a function that looks for a key and not a value see [list.HasEntry](https://wiki.facepunch.com/gmod/list.HasEntry).

**Arguments:**
- `list` (string) — List to search through.
- `value` (any) — The value to test.

**Returns:**
- boolean — Returns true if the list contains the value, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/list.Contains) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L67-L80)

---

### list.Get · Shared, Menu
`list.Get(identifier: string) → table`

Returns a copy of the list stored at identifier.
	
	Where possible you should use the much faster helper functions:
	  [list.Contains](https://wiki.facepunch.com/gmod/list.Contains),
	  [list.HasEntry](https://wiki.facepunch.com/gmod/list.HasEntry), or
	  [list.GetEntry](https://wiki.facepunch.com/gmod/list.GetEntry).

	There is also the more dangerous option of calling [list.GetForEdit](https://wiki.facepunch.com/gmod/list.GetForEdit) to get the unprotected list if you absolutely must iterate through it in a think hook.

**Arguments:**
- `identifier` (string) — The list identifier.

**Returns:**
- table — The copy of the list.

> **Warning:** This function uses [table.Copy](https://wiki.facepunch.com/gmod/table.Copy) which can be very slow for larger lists. You should avoid calling it repeatedly or in performance sensitive hooks such as [GM:Think](https://wiki.facepunch.com/gmod/GM:Think).

[wiki](https://wiki.facepunch.com/gmod/list.Get) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L18-L23)

---

### list.GetEntry · Shared, Menu
`list.GetEntry(list: string, key: string) → any|nil`

Returns a copy of the entry in the list `list` with key `key`.

**Arguments:**
- `list` (string) — List to search through.
- `key` (string) — The key to search for.

**Returns:**
- any|nil — Returns the value if the list contains the key, nil otherwise.

[wiki](https://wiki.facepunch.com/gmod/list.GetEntry) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L16-L27)

---

### list.GetForEdit · Shared, Menu
`list.GetForEdit(identifier: string, dontCreate: boolean = false) → table`

Returns the actual table of the list stored at identifier. Modifying this will affect the stored list.

**Arguments:**
- `identifier` (string) — The list identifier.
- `dontCreate` (boolean, default `false`) — If the list at given identifier does not exist, do not create it.

**Returns:**
- table — The actual list.

[wiki](https://wiki.facepunch.com/gmod/list.GetForEdit) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L28-L33)

---

### list.GetTable · Shared, Menu
`list.GetTable() → table`

Returns a list of all lists currently in use.

**Returns:**
- table — The list of all lists, i.e.

[wiki](https://wiki.facepunch.com/gmod/list.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L38-L42)

---

### list.HasEntry · Shared, Menu
`list.HasEntry(list: string, key: any) → boolean`

Returns true if the list contains the given key.

For a function that looks for values and not keys see [list.Contains](https://wiki.facepunch.com/gmod/list.Contains).

**Arguments:**
- `list` (string) — List to search through.
- `key` (any) — The key to test.

**Returns:**
- boolean — Returns true if the list contains the key, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/list.HasEntry) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L85-L90)

---

### list.RemoveEntry · Shared, Menu
`list.RemoveEntry(list: string, key: string)`

Removes a single entry from the list `list` with key `key`.

This is equivalent to `list.Set( myList, myKey, nil )`.

**Arguments:**
- `list` (string) — List to remove an entry in.
- `key` (string) — The key for the entry to remove.

[wiki](https://wiki.facepunch.com/gmod/list.RemoveEntry)

---

### list.Set · Shared, Menu
`list.Set(identifier: string, key: any, item: any)`

Sets a specific position in the named list to a value.

**Arguments:**
- `identifier` (string) — The list identifier.
- `key` (any) — The key in the list to set.
- `item` (any) — The item to set to the list as key.

[wiki](https://wiki.facepunch.com/gmod/list.Set) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/list.lua#L47-L52)
