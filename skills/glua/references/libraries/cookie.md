# cookie

**Realm:** Shared, Menu  ·  **Members:** 4

Functions to persist data on a user's computer.

		The data will be read / written to / from a database  
		corresponding to the realm the library was used in.

		| Realm | Database File | 
		|:-----:|:-----|
		| [Server](https://wiki.facepunch.com/gmod/States#server) | `garrysmod/sv.db`
		| [Client](https://wiki.facepunch.com/gmod/States#client) | `garrysmod/cl.db`
		| [Menu](https://wiki.facepunch.com/gmod/States#menu) | `garrysmod/mn.db`

[wiki page](https://wiki.facepunch.com/gmod/cookie)

### cookie.Delete · Shared, Menu
`cookie.Delete(key: string)`

Removes any cookie with the given name.
		
		Does nothing if the cookie doesn't exist.

**Arguments:**
- `key` (string) — The name of the cookie that you want to delete.

[wiki](https://wiki.facepunch.com/gmod/cookie.Delete) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cookie.lua#L94-L102)

---

### cookie.GetNumber · Shared, Menu
`cookie.GetNumber(name: string, default: any = nil) → number`

Gets the value of a cookie on the client as a number.

**Arguments:**
- `name` (string) — The name of the cookie that you want to get.
- `default` (any, default `nil`) — Value to return if the cookie does not exist.

**Returns:**
- number — The cookie value.

[wiki](https://wiki.facepunch.com/gmod/cookie.GetNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cookie.lua#L84-L91)

---

### cookie.GetString · Shared, Menu
`cookie.GetString(name: string, default: any = nil) → string`

Gets the value of a cookie on the client as a string.

**Arguments:**
- `name` (string) — The name of the cookie that you want to get.
- `default` (any, default `nil`) — Value to return if the cookie does not exist.

**Returns:**
- string — The cookie value.

[wiki](https://wiki.facepunch.com/gmod/cookie.GetString) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cookie.lua#L74-L81)

---

### cookie.Set · Shared, Menu
`cookie.Set(key: string, value: string)`

Creates / updates a cookie in the [Database](https://wiki.facepunch.com/gmod/cookie).

**Arguments:**
- `key` (string) — The name of the cookie.
- `value` (string) — The data stored in the cookie.

[wiki](https://wiki.facepunch.com/gmod/cookie.Set) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/cookie.lua#L105-L107)
