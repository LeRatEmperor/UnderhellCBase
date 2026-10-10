# table

**Realm:** Shared, Menu  ·  **Members:** 46

The [table](https://wiki.facepunch.com/gmod/Beginner_Tutorial_Tables) **type** is an object that can store multiple values.

The table **library** is a standard Lua library which provides functions to manipulate tables. In Garry's Mod there are several extra useful functions added to this library.

This category lists the functions available in the table `library`.

[wiki page](https://wiki.facepunch.com/gmod/table)

### table.Add · Shared, Menu
`table.Add(target: table, source: table) → table`

Adds all values from `source` table into the `target` table. This is most useful for sequential tables, not "dictionary" or "map" tables. See [table.Merge](https://wiki.facepunch.com/gmod/table.Merge) if you want to merge 2 tables into one.

See [table.insert](https://wiki.facepunch.com/gmod/table.insert) for a function that adds a single value, and [table.Inherit](https://wiki.facepunch.com/gmod/table.Inherit) for a function that inherits keys from one table to another.

**Arguments:**
- `target` (table) — The table to insert the new values into.
- `source` (table) — The table to retrieve the values from.

**Returns:**
- table — The target table.

[wiki](https://wiki.facepunch.com/gmod/table.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L112-L123)

---

### table.ClearKeys · Shared, Menu
`table.ClearKeys(table: table, saveKeys: boolean = false) → table`

Changes all keys to sequential integers. This creates a new table object and does not affect the original.

**Arguments:**
- `table` (table) — The original table to modify.
- `saveKeys` (boolean, default `false`) — Save the keys within each member table.

**Returns:**
- table — Table with integer keys.

[wiki](https://wiki.facepunch.com/gmod/table.ClearKeys) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L468-L481)

---

### table.CollapseKeyValue · Shared, Menu
`table.CollapseKeyValue(input: table) → table`

Collapses a table with keyvalue structure

**Arguments:**
- `input` (table) — Input table

**Returns:**
- table — Output table

[wiki](https://wiki.facepunch.com/gmod/table.CollapseKeyValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L444-L462)

---

### table.concat · Shared, Menu
`table.concat(tbl: table, concatenator: string = \, startPos: number = 1, endPos: number = #tbl) → string`

Concatenates the contents of a table to a string.

**Arguments:**
- `tbl` (table) — The table to concatenate.
- `concatenator` (string, default `\`) — A separator to insert between strings
- `startPos` (number, default `1`) — The key to start at
- `endPos` (number, default `#tbl`) — The key to end at

**Returns:**
- string — Concatenated values

[wiki](https://wiki.facepunch.com/gmod/table.concat)

---

### table.Copy · Shared, Menu
`table.Copy(originalTable: table) → table`

Creates a deep copy and returns that copy.

**Arguments:**
- `originalTable` (table) — The table to be copied.

**Returns:**
- table — A deep copy of the original table

> **Warning:** This function does NOT copy userdata, such as [Vector](https://wiki.facepunch.com/gmod/Vector)s and [Angle](https://wiki.facepunch.com/gmod/Angle)s!
> **Warning:** This function is very slow! If you know the table structure, it is better to write your own copying mechanism

[wiki](https://wiki.facepunch.com/gmod/table.Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L24-L43)

---

### table.CopyFromTo · Shared, Menu
`table.CopyFromTo(source: table, target: table)`

Empties the target table, and merges all values from the source table into it.

**Arguments:**
- `source` (table) — The table to copy from.
- `target` (table) — The table to write to.

[wiki](https://wiki.facepunch.com/gmod/table.CopyFromTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L67-L75)

---

### table.Count · Shared, Menu
`table.Count(tbl: table) → number`

Counts the amount of keys in a table. This should only be used when a table is not numerically and sequentially indexed. For those tables, consider the length (**#**) operator.

If you only want to test if the table is empty or not, use [table.IsEmpty](https://wiki.facepunch.com/gmod/table.IsEmpty) instead as it is a lot faster.

**Arguments:**
- `tbl` (table) — The table to count the keys of.

**Returns:**
- number — The number of keyvalue pairs.

[wiki](https://wiki.facepunch.com/gmod/table.Count) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L156-L160)

---

### table.DeSanitise · Shared, Menu
`table.DeSanitise(tbl: table) → table`

Converts a table that has been sanitised with [table.Sanitise](https://wiki.facepunch.com/gmod/table.Sanitise) back to its original form

**Arguments:**
- `tbl` (table) — Table to be de-sanitised

**Returns:**
- table — De-sanitised table

[wiki](https://wiki.facepunch.com/gmod/table.DeSanitise) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L317-L360)

---

### table.Empty · Shared, Menu
`table.Empty(tbl: table)`

Removes all values from a table. If your table is not a metatable, it is almost always better to use `tab = {}` to preserve performance.

**Arguments:**
- `tbl` (table) — The table to empty.

[wiki](https://wiki.facepunch.com/gmod/table.Empty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L49-L53)

---

### table.FindNext · Shared, Menu · `DEPRECATED`
`table.FindNext(tbl: table, value: any) → any`

Returns the value positioned after the supplied value in a table. If it isn't found then the first element in the table is returned

**Arguments:**
- `tbl` (table) — Table to search
- `value` (any) — Value to return element after

**Returns:**
- any — Found element

[wiki](https://wiki.facepunch.com/gmod/table.FindNext) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L605-L613)

---

### table.FindPrev · Shared, Menu · `DEPRECATED`
`table.FindPrev(tbl: table, value: any) → any`

Returns the value positioned before the supplied value in a table. If it isn't found then the last element in the table is returned

**Arguments:**
- `tbl` (table) — Table to search
- `value` (any) — Value to return element before

**Returns:**
- any — Found element

[wiki](https://wiki.facepunch.com/gmod/table.FindPrev) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L615-L625)

---

### table.Flip · Shared, Menu
`table.Flip(input: table) → table`

Flips key-value pairs of each element within a table, so that each value becomes the key, and each key becomes the value.

**Arguments:**
- `input` (table) — The table to flip items of.

**Returns:**
- table — The flipped table.

> **Warning:** Take care when using this function, as a Lua table cannot contain multiple instances of the same key. As such, data loss is possible when using this function on tables with duplicate values.
> 
> ```lua
> local test = { test = 1, test2 = 1 }
> local f = table.Flip( test )
> PrintTable( f )
> -- Outputs "1	=	test2"
> ```

[wiki](https://wiki.facepunch.com/gmod/table.Flip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L766-L776)

---

### table.ForceInsert · Shared, Menu
`table.ForceInsert(tab: table = {}, value: any) → table`

Inserts a value in to the given table even if the table is non-existent

**Arguments:**
- `tab` (table, default `{}`) — Table to insert value in to
- `value` (any) — Value to insert

**Returns:**
- table — The supplied or created table

[wiki](https://wiki.facepunch.com/gmod/table.ForceInsert) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L362-L370)

---

### table.foreach · Shared, Menu · `DEPRECATED`
`table.foreach(tbl: table, callback: function)`

Iterates for each key-value pair in the table, calling the function with the key and value of the pair. If the function returns anything, the loop is broken.

The GLua interpretation of this is [table.ForEach](https://wiki.facepunch.com/gmod/table.ForEach).

**Arguments:**
- `tbl` (table) — The table to iterate over.
- `callback` (function) — The function to run for each key and value.

[wiki](https://wiki.facepunch.com/gmod/table.foreach) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:foreach]#L-L1-L-L1)

---

### table.foreachi · Shared, Menu · `DEPRECATED`
`table.foreachi(table: table, func: function)`

Iterates for each numeric index in the table in order.

This is inherited from the original Lua implementation and is deprecated in Lua as of 5.1; see [here](http://lua-users.org/wiki/TableLibraryTutorial). You should use [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs)() instead.

**Arguments:**
- `table` (table) — The table to iterate over.
- `func` (function) — The function to run for each index.

[wiki](https://wiki.facepunch.com/gmod/table.foreachi) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:foreachi]#L-L1-L-L1)

---

### table.GetFirstKey · Shared, Menu · `DEPRECATED`
`table.GetFirstKey(tab: table) → any`

Returns the first key found in the given table

**Arguments:**
- `tab` (table) — Table to retrieve key from

**Returns:**
- any — Key

[wiki](https://wiki.facepunch.com/gmod/table.GetFirstKey) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L585-L588)

---

### table.GetFirstValue · Shared, Menu · `DEPRECATED`
`table.GetFirstValue(tab: table) → any`

Returns the first value found in the given table

**Arguments:**
- `tab` (table) — Table to retrieve value from

**Returns:**
- any — Value

[wiki](https://wiki.facepunch.com/gmod/table.GetFirstValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L590-L593)

---

### table.GetKeys · Shared, Menu
`table.GetKeys(tabl: table) → table`

Returns all keys of a table.

**Arguments:**
- `tabl` (table) — The table to get keys of

**Returns:**
- table — Table of keys

[wiki](https://wiki.facepunch.com/gmod/table.GetKeys) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L688-L700)

---

### table.GetLastKey · Shared, Menu · `DEPRECATED`
`table.GetLastKey(tab: table) → any`

Returns the last key found in the given table

**Arguments:**
- `tab` (table) — Table to retrieve key from

**Returns:**
- any — Key

[wiki](https://wiki.facepunch.com/gmod/table.GetLastKey) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L595-L598)

---

### table.GetLastValue · Shared, Menu · `DEPRECATED`
`table.GetLastValue(tab: table) → any`

Returns the last value found in the given table

**Arguments:**
- `tab` (table) — Table to retrieve value from

**Returns:**
- any — Value

[wiki](https://wiki.facepunch.com/gmod/table.GetLastValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L600-L603)

---

### table.getn · Shared, Menu · `DEPRECATED`
`table.getn(tbl: table) → number`

Returns the length of the table.

**Arguments:**
- `tbl` (table) — The table to check.

**Returns:**
- number — Sequential length.

[wiki](https://wiki.facepunch.com/gmod/table.getn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:getn]#L-L1-L-L1)

---

### table.GetWinningKey · Shared, Menu
`table.GetWinningKey(inputTable: table) → any`

Returns a key of the supplied table with the highest number value.

**Arguments:**
- `inputTable` (table) — The table to search in.

**Returns:**
- any — winningKey

[wiki](https://wiki.facepunch.com/gmod/table.GetWinningKey) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L627-L641)

---

### table.HasValue · Shared, Menu
`table.HasValue(tbl: table, value: any) → boolean`

Checks if a table has a value.

**Arguments:**
- `tbl` (table) — Table to check
- `value` (any) — Value to search for

**Returns:**
- boolean — Returns true if the table has that value, false otherwise

> **Note:** For optimization, functions that look for a value by sorting the table should never be needed if you work on a table that you built yourself.
> **Warning:** This function is **very inefficient for large tables** (O(n)) and should probably not be called in things that run each frame. Instead, consider a table structure such as example 2 below. Also see: [Tables: Bad Habits](https://wiki.facepunch.com/gmod/Tables:%20Bad%20Habits)

[wiki](https://wiki.facepunch.com/gmod/table.HasValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L101-L106)

---

### table.Inherit · Shared, Menu
`table.Inherit(target: table, base: table) → table`

Copies any missing data from `base` to `target`, and sets the `target`'s `BaseClass` member to the `base` table's pointer.

See [table.Merge](https://wiki.facepunch.com/gmod/table.Merge), which overrides existing values and doesn't add a BaseClass member.


See also [table.Add](https://wiki.facepunch.com/gmod/table.Add), which simply adds values of one table to another.

**Arguments:**
- `target` (table) — Table to copy data to
- `base` (table) — Table to copy data from

**Returns:**
- table — Target

> **Bug:** Sub-tables aren't inherited. The target's table value will take priority.

[wiki](https://wiki.facepunch.com/gmod/table.Inherit) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L6-L16)

---

### table.insert · Shared, Menu
`table.insert(tbl: table, position: number, value: any) → number`

Inserts a value into a table at the end of the table or at the given position.

**Arguments:**
- `tbl` (table) — The table to insert the variable into.
- `position` (number) — The position in the table to insert the variable.
- `value` (any) — The variable to insert into the table.

**Returns:**
- number — The index the object was placed at.

> **Note:** This function does not call the `__newindex` [metamethod](Metamethods).

[wiki](https://wiki.facepunch.com/gmod/table.insert)

---

### table.IsEmpty · Shared, Menu
`table.IsEmpty(tab: table) → boolean`

Returns whether or not the given table is empty.

This works on both sequential and non-sequential tables, and is a lot faster for non-sequential tables than `table.Count(tbl) == 0`.

For sequential tables it is better to use `tab[1] == nil`.

**Arguments:**
- `tab` (table) — Table to check.

**Returns:**
- boolean — Is empty?

[wiki](https://wiki.facepunch.com/gmod/table.IsEmpty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L59-L61)

---

### table.IsSequential · Shared, Menu
`table.IsSequential(tab: table) → boolean`

Returns whether or not the table's keys are sequential

**Arguments:**
- `tab` (table) — Table to check

**Returns:**
- boolean — Is sequential

[wiki](https://wiki.facepunch.com/gmod/table.IsSequential) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L180-L187)

---

### table.KeyFromValue · Shared, Menu
`table.KeyFromValue(tab: table, value: any) → any`

Returns the first key found to be containing the supplied value

**Arguments:**
- `tab` (table) — Table to search
- `value` (any) — Value to search for

**Returns:**
- any — Key

[wiki](https://wiki.facepunch.com/gmod/table.KeyFromValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L643-L647)

---

### table.KeysFromValue · Shared, Menu
`table.KeysFromValue(tab: table, value: any) → table`

Returns a table of keys containing the supplied value

**Arguments:**
- `tab` (table) — Table to search
- `value` (any) — Value to search for

**Returns:**
- table — Keys

[wiki](https://wiki.facepunch.com/gmod/table.KeysFromValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L659-L665)

---

### table.LowerKeyNames · Shared, Menu
`table.LowerKeyNames(tbl: table) → table`

Returns a copy of the input table with all string keys converted to be lowercase recursively

**Arguments:**
- `tbl` (table) — Table to convert

**Returns:**
- table — New table

[wiki](https://wiki.facepunch.com/gmod/table.LowerKeyNames) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L414-L438)

---

### table.maxn · Shared, Menu
`table.maxn(tbl: table) → number`

Returns the highest numerical key.

**Arguments:**
- `tbl` (table) — The table to search.

**Returns:**
- number — The highest numerical key.

[wiki](https://wiki.facepunch.com/gmod/table.maxn)

---

### table.MemberValuesFromKey · Shared, Menu
`table.MemberValuesFromKey(inputTable: table, keyName: any) → table`

Returns an array of values of given with given key from each table of given table.

See also [table.KeysFromValue](https://wiki.facepunch.com/gmod/table.KeysFromValue).

**Arguments:**
- `inputTable` (table) — The table to search in.
- `keyName` (any) — The key to lookup.

**Returns:**
- table — A list of found values, or an empty table.

[wiki](https://wiki.facepunch.com/gmod/table.MemberValuesFromKey) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L723-L729)

---

### table.Merge · Shared, Menu
`table.Merge(destination: table, source: table, forceOverride: boolean = false) → table`

Recursively merges the key-value pairs of the `source` table with the key-value pairs in the `destination` table.

See [table.Inherit](https://wiki.facepunch.com/gmod/table.Inherit), which doesn't override existing values.


See also [table.Add](https://wiki.facepunch.com/gmod/table.Add), which simply adds values of one table to another.

**Arguments:**
- `destination` (table) — The table you want the source table to merge with.
- `source` (table) — The table you want to merge with the destination table.
- `forceOverride` (boolean, default `false`) — If `true`, does not recursively merge sub-tables, and simply replaces them.

**Returns:**
- table — Destination table

> **Note:** This function can cause a stack overflow under certain circumstances.

[wiki](https://wiki.facepunch.com/gmod/table.Merge) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L81-L95)

---

### table.move · Shared, Menu
`table.move(sourceTbl: table, from: number, to: number, dest: number, destTbl: table = sourceTbl) → table`

Moves elements from one part of a table to another part a given table. This is similar to assigning elements from the source table to the destination table in multiple assignments.

**Arguments:**
- `sourceTbl` (table) — The source table from which the elements are to be moved.
- `from` (number) — The start index of the source range from which the elements are to be moved.
- `to` (number) — The end index of the source range until which the elements are to be moved.
- `dest` (number) — The index within the destination table where the moved elements should be inserted.
- `destTbl` (table, default `sourceTbl`) — The destination table to which the elements are to be moved.

**Returns:**
- table — The modified destination table.

[wiki](https://wiki.facepunch.com/gmod/table.move) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:move]#L-L1-L-L1)

---

### table.Pack · Shared, Menu
`table.Pack(items: vararg) → table, number`

Packs a set of items into a table and returns the new table. It is meant as an alternative implementation of `table.pack` from newer versions of Lua.

**Arguments:**
- `items` (vararg) — The items to pack into a table.

**Returns:**
- table — A table containing the `items`.
- number — The amount of items that were added to the table.

[wiki](https://wiki.facepunch.com/gmod/table.Pack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L2-L4)

---

### table.Random · Shared, Menu
`table.Random(haystack: table) → any, any`

Returns a random value from the supplied table.

**Arguments:**
- `haystack` (table) — The table to choose from.

**Returns:**
- any — A random value from the table.
- any — The key associated with the random value.

> **Warning:** This function iterates over the given table **twice**, therefore with sequential tables you should instead use following:
> 
> ```lua
> mytable[ math.random( #mytable ) ]
> ```

[wiki](https://wiki.facepunch.com/gmod/table.Random) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L166-L173)

---

### table.remove · Shared, Menu
`table.remove(tbl: table, index: number = #tbl) → any`

Removes a value from a table and shifts any other values down to fill the gap.

**Arguments:**
- `tbl` (table) — The table to remove the value from.
- `index` (number, default `#tbl`) — The index of the value to remove.

**Returns:**
- any — The value that was removed.

> **Note:** Does nothing if index is less than 1 or greater than `#tbl`

[wiki](https://wiki.facepunch.com/gmod/table.remove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:remove]#L-L1-L-L1)

---

### table.RemoveByValue · Shared, Menu
`table.RemoveByValue(tbl: table, val: any) → any`

Removes the first instance of a given value from the specified table with [table.remove](https://wiki.facepunch.com/gmod/table.remove), then returns the key that the value was found at.

**Arguments:**
- `tbl` (table) — The table that will be searched.
- `val` (any) — The value to find within the table.

**Returns:**
- any — The key at which the value was found, or false if the value was not found.

> **Warning:** Avoid usage of this function. It does not remove all instances of given value in the table, only the first found, and it does not work with non sequential tables!

[wiki](https://wiki.facepunch.com/gmod/table.RemoveByValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L649-L657)

---

### table.Reverse · Shared, Menu
`table.Reverse(tbl: table) → table`

Returns a reversed copy of a sequential table. Any non-sequential and non-numeric keyvalue pairs will not be copied.

**Arguments:**
- `tbl` (table) — Table to reverse.

**Returns:**
- table — A reversed copy of the table.

[wiki](https://wiki.facepunch.com/gmod/table.Reverse) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L667-L678)

---

### table.Sanitise · Shared, Menu
`table.Sanitise(tab: table) → table`

Converts [Vector](https://wiki.facepunch.com/gmod/Vector)s, [Angle](https://wiki.facepunch.com/gmod/Angle)s and [boolean](https://wiki.facepunch.com/gmod/boolean)s to be able to be converted to and from key-values via [util.TableToKeyValues](https://wiki.facepunch.com/gmod/util.TableToKeyValues).

[table.DeSanitise](https://wiki.facepunch.com/gmod/table.DeSanitise) performs the opposite transformation.

**Arguments:**
- `tab` (table) — Table to sanitise

**Returns:**
- table — Sanitised table

[wiki](https://wiki.facepunch.com/gmod/table.Sanitise) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L266-L311)

---

### table.Shuffle · Shared, Menu
`table.Shuffle(target: table)`

Performs an inline [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle) on the table in `O(n)` time

**Arguments:**
- `target` (table) — The table to shuffle.

[wiki](https://wiki.facepunch.com/gmod/table.Shuffle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L185-L191)

---

### table.sort · Shared, Menu
`table.sort(tbl: table, sorter: function = nil)`

Sorts a sequential table either ascending or by the given sort function.

**Arguments:**
- `tbl` (table) — The table to sort.
- `sorter` (function, default `nil`) — If specified, the sorting function.

> **Note:** This function modifies the table you give to it and internally uses the [quick sort algorithm](http://www.lua.org/source/5.2/ltablib.c.html#sort).

[wiki](https://wiki.facepunch.com/gmod/table.sort)

---

### table.SortByKey · Shared, Menu
`table.SortByKey(tab: table, descending: boolean = false) → table`

Returns a list of keys sorted based on values of those keys.

For normal sorting see [table.sort](https://wiki.facepunch.com/gmod/table.sort).

**Arguments:**
- `tab` (table) — Table to sort.
- `descending` (boolean, default `false`) — Should the order be descending?

**Returns:**
- table — A table of keys sorted by values from supplied table.

[wiki](https://wiki.facepunch.com/gmod/table.SortByKey) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L137-L150)

---

### table.SortByMember · Shared, Menu
`table.SortByMember(tab: table, memberKey: any, ascending: boolean = false)`

Sorts a table by a named member.

**Arguments:**
- `tab` (table) — Table to sort.
- `memberKey` (any) — The key used to identify the member.
- `ascending` (boolean, default `false`) — Whether or not the order should be ascending.

[wiki](https://wiki.facepunch.com/gmod/table.SortByMember) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L376-L408)

---

### table.SortDesc · Shared, Menu
`table.SortDesc(tbl: table)`

Sorts a table in reverse order from [table.sort](https://wiki.facepunch.com/gmod/table.sort).

**Arguments:**
- `tbl` (table) — The table to sort in descending order.

> **Note:** This function modifies the table you give to it. Like table.sort, it does not return anything.

[wiki](https://wiki.facepunch.com/gmod/table.SortDesc) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L129-L131)

---

### table.ToString · Shared, Menu
`table.ToString(tbl: table, displayName: string = nil, niceFormatting: boolean = false) → string`

Converts a table into a string

**Arguments:**
- `tbl` (table) — The table to iterate over.
- `displayName` (string, default `nil`) — A name for the table.
- `niceFormatting` (boolean, default `false`) — Adds new lines and tabs to the string.

**Returns:**
- string — The table formatted as a string.

[wiki](https://wiki.facepunch.com/gmod/table.ToString) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L253-L260)
