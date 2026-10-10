# WorkshopFileBase

**Realm:** Shared, Menu  ·  **Members:** 5  ·  `INTERNAL`

This object is created by [WorkshopFileBase](https://wiki.facepunch.com/gmod/Global.WorkshopFileBase) which is used internally to fetch data of the specific namespace
		or to publish saves and dupes.  

		This also exists on the Server but most functions may throw an error. It's meant to be used clientside.

> **Note:** You need to set the `HTML` field to a [DHTML](https://wiki.facepunch.com/gmod/DHTML) panel that is set up correctly like [here](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/dupes.lua#L12), or else you might get errors.

[wiki page](https://wiki.facepunch.com/gmod/WorkshopFileBase)

### WorkshopFileBase:Fetch · Shared, Menu
`WorkshopFileBase:Fetch(type: string, offset: number, perpage: number, extratags: table, searchText: string, filter: number = nil, sort: string = nil)`

Fetches all subscriptions for the set namespace and type

**Arguments:**
- `type` (string) — The type to search for.
- `offset` (number) — Skips the first x results.
- `perpage` (number) — How many results per page should be returned.
- `extratags` (table) — additional tags to filter the results.
- `searchText` (string) — text that needs to be in the addon title.
- `filter` (number, default `nil`) — The filter for the results.
- `sort` (string, default `nil`) — How it should be sorted.

> **Note:** If you want to use the type `local` you need to implement the `:FetchLocal(offset, perpage)` function!

[wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase:Fetch)

---

### WorkshopFileBase:FetchSubscribed · Shared, Menu
`WorkshopFileBase:FetchSubscribed(offset: number, perpage: number, tags: table, searchText: string, isUGC: boolean = nil, filter: number = nil, sort: string = nil)`

Fetches all subscriptions for the set namespace and passes the result to [WorkshopFileBase:FillFileInfo](https://wiki.facepunch.com/gmod/WorkshopFileBase:FillFileInfo).

**Arguments:**
- `offset` (number) — Skips the first x results.
- `perpage` (number) — How many results per page should be returned.
- `tags` (table) — additional tags to filter the results.
- `searchText` (string) — text that needs to be in the addon title.
- `isUGC` (boolean, default `nil`) — if true it will use engine.GetUserContent instead of engine.GetAddons
- `filter` (number, default `nil`) — The filter for the results.
- `sort` (string, default `nil`) — How it should be sorted.

[wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase:FetchSubscribed)

---

### WorkshopFileBase:FillFileInfo · Shared, Menu
`WorkshopFileBase:FillFileInfo(results: table, isUGC: boolean)`

Updates the set HTML panel with the newly fetched results

**Arguments:**
- `results` (table) — The type to search for.
- `isUGC` (boolean) — Skips the first x results.

[wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase:FillFileInfo)

---

### WorkshopFileBase:Publish · Shared, Menu
`WorkshopFileBase:Publish(filename: string, image: string)`

Creates a [UGCPublishWindow](https://wiki.facepunch.com/gmod/UGCPublishWindow) to publish the dupe or save

**Arguments:**
- `filename` (string) — The type to search for.
- `image` (string) — The image to use

[wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase:Publish)

---

### WorkshopFileBase:RetrieveUserName · Shared, Menu
`WorkshopFileBase:RetrieveUserName(steamid: string, callback: function)`

Retrieves the username for the given SteamID.

**Arguments:**
- `steamid` (string) — SteamID to retrieve the name for
- `callback` (function) — Callback function.

[wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase:RetrieveUserName)
