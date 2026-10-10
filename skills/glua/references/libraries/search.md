# search

**Realm:** Client  ·  **Members:** 2

The search library

[wiki page](https://wiki.facepunch.com/gmod/search)

### search.AddProvider · Client
`search.AddProvider(provider: function, id: string = nil)`

Adds a search result provider. For examples, see [gamemodes/sandbox/gamemode/cl_search_models.lua](https://github.com/Facepunch/garrysmod/blob/7c23addd2c35d3d046c80e3d0cb6052055eca3e2/garrysmod/gamemodes/sandbox/gamemode/cl_search_models.lua)

**Arguments:**
- `provider` (function) — Provider function.
- `id` (string, default `nil`) — If provided, ensures that only one provider exists with the given ID at a time.

[wiki](https://wiki.facepunch.com/gmod/search.AddProvider) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/search.lua#L6-L18)

---

### search.GetResults · Client
`search.GetResults(query: string, types: string = nil, maxResults: number = 1024) → table`

Retrieves search results.

**Arguments:**
- `query` (string) — Search query
- `types` (string, default `nil`) — If set, only searches given provider type(s), instead of everything.
- `maxResults` (number, default `1024`) — How many results to stop at

**Returns:**
- table — A table of results

[wiki](https://wiki.facepunch.com/gmod/search.GetResults) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/search.lua#L20-L49)
