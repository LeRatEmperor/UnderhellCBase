# ContentHeader

**Realm:** Client  ·  **Members:** 2  ·  **Inherits:** `DLabelEditable`  ·  `INTERNAL`

The ContentHeader is used internally by the Spawnmenu and only use this if you know 
		what you're doing because you can break a few things with it.

[wiki page](https://wiki.facepunch.com/gmod/ContentHeader)

### ContentHeader:OpenMenu · Client
`ContentHeader:OpenMenu(style: string, hookname: string = PopulateContent)`

Creates a [DermaMenu](https://wiki.facepunch.com/gmod/Global.DermaMenu) and adds a delete option before opening the menu

**Arguments:**
- `style` (string)
- `hookname` (string, default `PopulateContent`) — A Populate Hook like PopulateEntities

[wiki](https://wiki.facepunch.com/gmod/ContentHeader:OpenMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentheader.lua#L96-L105)

---

### ContentHeader:ToTable · Client
`ContentHeader:ToTable(bigtable: table)`

**Arguments:**
- `bigtable` (table)

[wiki](https://wiki.facepunch.com/gmod/ContentHeader:ToTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentheader.lua#L44-L53)
