# serverlist

**Realm:** Menu  ·  **Members:** 8

Menu state library to query the master server list.

[wiki page](https://wiki.facepunch.com/gmod/serverlist)

### serverlist.AddCurrentServerToFavorites · Menu · `INTERNAL`
`serverlist.AddCurrentServerToFavorites(addOrRemove: boolean)`

Adds current server the player is on to their favorites.

**Arguments:**
- `addOrRemove` (boolean) — `true` if to add, or `false` if to remove from favorites.

[wiki](https://wiki.facepunch.com/gmod/serverlist.AddCurrentServerToFavorites)

---

### serverlist.AddServerToFavorites · Menu
`serverlist.AddServerToFavorites(address: string)`

Adds the given server address to their favorites.

**Arguments:**
- `address` (string) — Server Address.

[wiki](https://wiki.facepunch.com/gmod/serverlist.AddServerToFavorites)

---

### serverlist.IsCurrentServerFavorite · Menu
`serverlist.IsCurrentServerFavorite() → boolean`

Returns true if the current server address is in their favorites.

**Returns:**
- `favorite` (boolean) — true if the current server is in their favorites

[wiki](https://wiki.facepunch.com/gmod/serverlist.IsCurrentServerFavorite)

---

### serverlist.IsServerFavorite · Menu
`serverlist.IsServerFavorite(address: string) → boolean`

Returns true if the given server address is in their favorites.

**Arguments:**
- `address` (string) — Server Address.

**Returns:**
- `favorite` (boolean) — true if the server address is in their favorites

[wiki](https://wiki.facepunch.com/gmod/serverlist.IsServerFavorite)

---

### serverlist.PingServer · Menu
`serverlist.PingServer(ip: string, callback: function)`

Queries a server for its information/ping.

**Arguments:**
- `ip` (string) — The IP address of the server, including the port.
- `callback` (function) — The function to be called if and when the request finishes.

[wiki](https://wiki.facepunch.com/gmod/serverlist.PingServer)

---

### serverlist.PlayerList · Menu
`serverlist.PlayerList(ip: string, callback: function)`

Queries a server for its player list.

**Arguments:**
- `ip` (string) — The IP address of the server, including the port.
- `callback` (function) — The function to be called if and when the request finishes.

[wiki](https://wiki.facepunch.com/gmod/serverlist.PlayerList)

---

### serverlist.Query · Menu
`serverlist.Query(data: table)`

Queries the master server for server list.

**Arguments:**
- `data` (table) — The information about what kind of servers we want.

[wiki](https://wiki.facepunch.com/gmod/serverlist.Query)

---

### serverlist.RemoveServerFromFavorites · Menu
`serverlist.RemoveServerFromFavorites(address: string)`

Removes the given server address from their favorites.

**Arguments:**
- `address` (string) — Server Address.

[wiki](https://wiki.facepunch.com/gmod/serverlist.RemoveServerFromFavorites)
