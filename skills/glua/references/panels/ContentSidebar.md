# ContentSidebar

**Realm:** Client  ·  **Members:** 3  ·  **Inherits:** `DPanel`  ·  `INTERNAL`

The ContentSidebar is internally used by the spawnmenu and manages things like the Spawnmenu Toolbar.
		It internally uses a DTree which is accessible with ContentSidebar .Tree.
		When [ContentSidebar:EnableModify](https://wiki.facepunch.com/gmod/ContentSidebar:EnableModify) has been called ContentSidebar.Toolbox will return a [ContentSidebarToolbox](https://wiki.facepunch.com/gmod/ContentSidebarToolbox)

[wiki page](https://wiki.facepunch.com/gmod/ContentSidebar)

### ContentSidebar:CreateSaveNotification · Client
`ContentSidebar:CreateSaveNotification(style: string, hookname: string = PopulateContent)`

Creates a Save Notification which will be shown when [SANDBOX:SpawnlistContentChanged](https://wiki.facepunch.com/gmod/SANDBOX:SpawnlistContentChanged) has been called.

**Arguments:**
- `style` (string)
- `hookname` (string, default `PopulateContent`) — A Populate Hook like PopulateEntities

[wiki](https://wiki.facepunch.com/gmod/ContentSidebar:CreateSaveNotification) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentsidebar.lua#L42-L84)

---

### ContentSidebar:EnableModify · Client
`ContentSidebar:EnableModify()`

Internally calls [ContentSidebar:EnableSearch](https://wiki.facepunch.com/gmod/ContentSidebar:EnableSearch), [ContentSidebar:CreateSaveNotification](https://wiki.facepunch.com/gmod/ContentSidebar:CreateSaveNotification) and creates a ContentSidebarToolbox which is accessible under ContentSidebar.Toolbox. Call the Hook [SANDBOX:OpenToolbox](https://wiki.facepunch.com/gmod/SANDBOX:OpenToolbox) to open the created Toolbox

[wiki](https://wiki.facepunch.com/gmod/ContentSidebar:EnableModify) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentsidebar.lua#L25-L40)

---

### ContentSidebar:EnableSearch · Client
`ContentSidebar:EnableSearch(style: string, hookname: string = PopulateContent)`

Creates a search bar which will be displayed over the Nodes.

**Arguments:**
- `style` (string)
- `hookname` (string, default `PopulateContent`) — A Populate Hook like PopulateEntities

[wiki](https://wiki.facepunch.com/gmod/ContentSidebar:EnableSearch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentsidebar.lua#L20-L23)
