# spawnmenu

**Realm:** Client  ·  **Members:** 24

The spawnmenu library is a set of functions that allow you to control the spawn (Q) menu.

[wiki page](https://wiki.facepunch.com/gmod/spawnmenu)

### spawnmenu.ActivateTool · Client
`spawnmenu.ActivateTool(tool: string, menu_only: boolean = false)`

Activates a tool, opens context menu and brings up the tool gun.

**Arguments:**
- `tool` (string) — Tool class/file name
- `menu_only` (boolean, default `false`) — Should we activate this tool in the menu only or also the toolgun?

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.ActivateTool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L272-L300)

---

### spawnmenu.ActivateToolPanel · Client
`spawnmenu.ActivateToolPanel(tab: number, cp: Panel)`

Activates tools context menu in specified tool tab.

**Arguments:**
- `tab` (number) — The tabID of the tab to open the context menu in
- `cp` (Panel) — The control panel to open

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.ActivateToolPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L256-L269)

---

### spawnmenu.ActiveControlPanel · Client
`spawnmenu.ActiveControlPanel() → Panel`

Returns currently opened control panel of a tool, post process effect or some other menu in spawnmenu.

**Returns:**
- Panel — The currently opened control panel, if any.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.ActiveControlPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L18-L20)

---

### spawnmenu.AddContentType · Client
`spawnmenu.AddContentType(name: string, constructor: function)`

Registers a new content type that is saveable into spawnlists.
Created/called by [spawnmenu.CreateContentIcon](https://wiki.facepunch.com/gmod/spawnmenu.CreateContentIcon).

**Arguments:**
- `name` (string) — An unique name of the content type.
- `constructor` (function) — A function that is called whenever we need create a new panel for this content type.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddContentType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L224-L226)

---

### spawnmenu.AddCreationTab · Client
`spawnmenu.AddCreationTab(name: string, function: function, material: string = icon16/exclamation.png, order: number = 1000, tooltip: string = nil)`

Inserts a new tab into the CreationMenus table, which will be used by the creation menu to generate its tabs (Spawnlists, Weapons, Entities, etc.)

**Arguments:**
- `name` (string) — What text will appear on the tab (i.e Spawnlists).
- `function` (function) — The function called to generate the content of the tab.
- `material` (string, default `icon16/exclamation.png`) — Path to the material that will be used as an icon on the tab.
- `order` (number, default `1000`) — The order in which this tab should be shown relative to the other tabs on the creation menu.
- `tooltip` (string, default `nil`) — The tooltip to be shown for this tab.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddCreationTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L119-L127)

---

### spawnmenu.AddPropCategory · Client
`spawnmenu.AddPropCategory(classname: string, name: string, contents: table, icon: string, id: number = 1000, parentID: number = 0, needsApp: string)`

Used to add addon spawnlists to the spawnmenu tree. This function should be called within [SANDBOX:PopulatePropMenu](https://wiki.facepunch.com/gmod/SANDBOX:PopulatePropMenu).

Addon spawnlists will not save to disk if edited.

**Arguments:**
- `classname` (string) — A unique classname of the list.
- `name` (string) — The name of the category displayed to the player, e.g.
- `contents` (table) — A table of entries for the spawn menu.
- `icon` (string) — The icon to use in the tree.
- `id` (number, default `1000`) — The unique ID number for the spawnlist category.
- `parentID` (number, default `0`) — The unique ID of the parent category.
- `needsApp` (string) — The needed game for this prop category, if one is needed.

> **Warning:** You should never try to modify player customized spawnlists!

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddPropCategory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L159-L172)

---

### spawnmenu.AddToolCategory · Client
`spawnmenu.AddToolCategory(tabName: string, className: string, printName: string)`

Used to create a new category in the list inside of a spawnmenu Tool Tab.

You must call this function from [SANDBOX:AddToolMenuCategories](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuCategories) for it to work properly.

See [spawnmenu.AddToolTab](https://wiki.facepunch.com/gmod/spawnmenu.AddToolTab) to add new tool tabs.  
See [spawnmenu.AddToolMenuOption](https://wiki.facepunch.com/gmod/spawnmenu.AddToolMenuOption) to add new sub options to a newly created tool category.

**Arguments:**
- `tabName` (string) — The internal tool tab name, as created with spawnmenu.AddToolTab.
- `className` (string) — The unique identifier name, which will be used to add tool option to this category.
- `printName` (string) — The nice name to be displayed to the player.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddToolCategory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L70-L84)

---

### spawnmenu.AddToolMenuOption · Client
`spawnmenu.AddToolMenuOption(tab: string, category: string, class: string, name: string, cmd: string = nil, config: string = nil, cpanel: function, table: table = {})`

Adds an option to the right side of the spawnmenu.

See [spawnmenu.AddToolTab](https://wiki.facepunch.com/gmod/spawnmenu.AddToolTab) to add new right-side tabs. See [spawnmenu.AddToolCategory](https://wiki.facepunch.com/gmod/spawnmenu.AddToolCategory) to add new categories.

**Arguments:**
- `tab` (string) — The internal name of the spawnmenu tab to add into (for example "Utilities")
- `category` (string) — The internal name of the category within the tab to add into (for example "Admin")
- `class` (string) — Unique internal identifier of the new option.
- `name` (string) — The nice name of item to show to the player.
- `cmd` (string, default `nil`) — Console command to execute when the item is selected.
- `config` (string, default `nil`) — Config name, used in older versions to load tool settings UI from a file.
- `cpanel` (function) — A function to build the context panel.
- `table` (table, default `{}`) — Allows to override the table that will be added to the tool list.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddToolMenuOption) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L86-L114)

---

### spawnmenu.AddToolTab · Client
`spawnmenu.AddToolTab(name: string, label: string = name, icon: string = icon16/wrench.png)`

Adds a new tool tab to the right side of the spawnmenu. (usually via the [SANDBOX:AddToolMenuTabs](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuTabs) hook)

See [spawnmenu.GetToolMenu](https://wiki.facepunch.com/gmod/spawnmenu.GetToolMenu) for a function to retrieve existing tool tabs.

See [spawnmenu.AddCreationTab](https://wiki.facepunch.com/gmod/spawnmenu.AddCreationTab) for tabs on the left side of the spawnmenu.

See [spawnmenu.AddToolCategory](https://wiki.facepunch.com/gmod/spawnmenu.AddToolCategory) to add new categories to the newly created tool tab.  
See [spawnmenu.AddToolMenuOption](https://wiki.facepunch.com/gmod/spawnmenu.AddToolMenuOption) to add new options to the categories within a tool tab.

**Arguments:**
- `name` (string) — The internal name of the tab.
- `label` (string, default `name`) — The 'nice' name of the tab that is displayed to the player.
- `icon` (string, default `icon16/wrench.png`) — The file path to the icon of the tab.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.AddToolTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L64-L68)

---

### spawnmenu.ClearToolMenus · Client
`spawnmenu.ClearToolMenus()`

Clears all the tools from the different tool categories and the categories itself, if ran at the correct place.

Seems to only work when ran at initialization.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.ClearToolMenus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L60-L62)

---

### spawnmenu.CreateContentIcon · Client
`spawnmenu.CreateContentIcon(type: string, parent: Panel = nil, data: table) → Panel`

Creates a new [ContentIcon](https://wiki.facepunch.com/gmod/ContentIcon) previously defined via [spawnmenu.AddContentType](https://wiki.facepunch.com/gmod/spawnmenu.AddContentType).

**Arguments:**
- `type` (string) — The type of the content icon.
- `parent` (Panel, default `nil`) — The parent to add the ContentIcon to.
- `data` (table) — The data to send to the content icon in spawnmenu.AddContentType.

**Returns:**
- Panel — The created ContentIcon, if it was returned by spawnmenu.AddContentType.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.CreateContentIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L240-L245)

---

### spawnmenu.DoSaveToTextFiles · Client · `INTERNAL`
`spawnmenu.DoSaveToTextFiles(spawnlists: table)`

Calls [spawnmenu.SaveToTextFiles](https://wiki.facepunch.com/gmod/spawnmenu.SaveToTextFiles).

**Arguments:**
- `spawnlists` (table) — A table containing spawnlists.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.DoSaveToTextFiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L199-L203)

---

### spawnmenu.GetContentType · Client
`spawnmenu.GetContentType(contentType: string) → function`

Returns the function to create an vgui element for a specified content type, previously defined by [spawnmenu.AddContentType](https://wiki.facepunch.com/gmod/spawnmenu.AddContentType).

If a content type doesn't exist, a dummy function will be returned, and a warning printed to the console.

You probably want to use [spawnmenu.CreateContentIcon](https://wiki.facepunch.com/gmod/spawnmenu.CreateContentIcon) to create icons.

**Arguments:**
- `contentType` (string) — The content type name.

**Returns:**
- function — The panel creation function.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetContentType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L228-L238)

---

### spawnmenu.GetCreationTabs · Client
`spawnmenu.GetCreationTabs() → table`

Returns the list of Creation tabs. Creation tabs are added via [spawnmenu.AddCreationTab](https://wiki.facepunch.com/gmod/spawnmenu.AddCreationTab).

**Returns:**
- table — The list of Creation tabs.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetCreationTabs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L132-L136)

---

### spawnmenu.GetCustomPropTable · Client
`spawnmenu.GetCustomPropTable() → table`

Similar to [spawnmenu.GetPropTable](https://wiki.facepunch.com/gmod/spawnmenu.GetPropTable), but only returns spawnlists created by addons via [spawnmenu.AddPropCategory](https://wiki.facepunch.com/gmod/spawnmenu.AddPropCategory).

These spawnlists are shown in a separate menu in-game.

**Returns:**
- table — See spawnmenu.GetPropTable for table format.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetCustomPropTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L150-L154)

---

### spawnmenu.GetPropTable · Client
`spawnmenu.GetPropTable() → table`

Returns a table of all prop categories and their props in the spawnmenu.

Note that if the spawnmenu has not been populated, this will return an empty table.

This will not return spawnlists created by addons, see  [spawnmenu.GetCustomPropTable](https://wiki.facepunch.com/gmod/spawnmenu.GetCustomPropTable) for that.

**Returns:**
- table — Table of all the prop categories and props in the following format: ```lua { ["settings/spawnlist/001-construction props.txt"] = { name = "Construction Props", icon = "icon16/page.png", id = 1, parentid = 0, needsapp = "", contents = { { model = "models/Cranes/crane_frame.mdl", type = "model" } -- etc.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetPropTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L141-L145)

---

### spawnmenu.GetToolMenu · Client
`spawnmenu.GetToolMenu(name: string, label: string = name, icon: string = icon16/wrench.png) → table`

Returns an existing tool tab by name from the right side of the spawnmenu (usually during the [SANDBOX:AddToolMenuTabs](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuTabs) hook)

If the requested tooltab does not exist, it will be added. See also [spawnmenu.AddToolTab](https://wiki.facepunch.com/gmod/spawnmenu.AddToolTab).

**Arguments:**
- `name` (string) — The internal name of the tab.
- `label` (string, default `name`) — The 'nice' name of the tab
- `icon` (string, default `icon16/wrench.png`) — The file path to the icon of the tab.

**Returns:**
- table — A table of tables representing categories and items in the left part of the tab.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetToolMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L32-L58)

---

### spawnmenu.GetTools · Client
`spawnmenu.GetTools() → table`

Gets a table of tools on the client.

**Returns:**
- table — A table with groups of tools, along with information on each tool.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.GetTools) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L25-L27)

---

### spawnmenu.PopulateFromEngineTextFiles · Client · `INTERNAL`
`spawnmenu.PopulateFromEngineTextFiles()`

Calls [spawnmenu.PopulateFromTextFiles](https://wiki.facepunch.com/gmod/spawnmenu.PopulateFromTextFiles).

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.PopulateFromEngineTextFiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L177-L194)

---

### spawnmenu.PopulateFromTextFiles · Client · `INTERNAL`
`spawnmenu.PopulateFromTextFiles(callback: function)`

Loads spawnlists from text files. You probably are looking for [spawnmenu.AddPropCategory](https://wiki.facepunch.com/gmod/spawnmenu.AddPropCategory).

**Arguments:**
- `callback` (function) — The function to call.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.PopulateFromTextFiles)

---

### spawnmenu.SaveToTextFiles · Client · `INTERNAL`
`spawnmenu.SaveToTextFiles(spawnlists: table)`

Saves a table of spawnlists to files.

**Arguments:**
- `spawnlists` (table) — A table containing spawnlists.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.SaveToTextFiles)

---

### spawnmenu.SetActiveControlPanel · Client · `INTERNAL`
`spawnmenu.SetActiveControlPanel(pnl: Panel)`

Sets currently active control panel to be returned by [spawnmenu.ActiveControlPanel](https://wiki.facepunch.com/gmod/spawnmenu.ActiveControlPanel).

**Arguments:**
- `pnl` (Panel) — The panel to set.

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.SetActiveControlPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L14-L16)

---

### spawnmenu.SwitchCreationTab · Client
`spawnmenu.SwitchCreationTab(id: string)`

Switches the creation tab (left side of the spawnmenu) on the spawnmenu to the given tab.

**Arguments:**
- `id` (string) — The tab ID to open

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.SwitchCreationTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L198-L205)

---

### spawnmenu.SwitchToolTab · Client
`spawnmenu.SwitchToolTab(id: number)`

Opens specified tool tab in spawnmenu.

**Arguments:**
- `id` (number) — The tab ID to open

[wiki](https://wiki.facepunch.com/gmod/spawnmenu.SwitchToolTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/spawnmenu.lua#L247-L254)
