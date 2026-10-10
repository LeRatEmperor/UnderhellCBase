# DFileBrowser

**Realm:** Client  ·  **Members:** 26  ·  **Inherits:** `DPanel`

A tree and list-based file browser.

		It allows filtering by folder (directory) name and file extension, and can display models as [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon)s.

[wiki page](https://wiki.facepunch.com/gmod/DFileBrowser)

### DFileBrowser:Clear · Client
`DFileBrowser:Clear()`

Clears the file tree and list, and resets all values.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L273-L283)

---

### DFileBrowser:GetBaseFolder · Client
`DFileBrowser:GetBaseFolder() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the root directory/folder of the file tree.

**Returns:**
- string — The path to the root folder.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetBaseFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L7)

---

### DFileBrowser:GetCurrentFolder · Client
`DFileBrowser:GetCurrentFolder() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the current directory/folder being displayed.

**Returns:**
- string — The directory the file list is currently displaying.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetCurrentFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L8)

---

### DFileBrowser:GetFileTypes · Client
`DFileBrowser:GetFileTypes() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the current file type filter on the file list.

**Returns:**
- string — The current filter applied to the file list.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetFileTypes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L6)

---

### DFileBrowser:GetFolderNode · Client
`DFileBrowser:GetFolderNode() → Panel`

Returns the [DTree Node](https://wiki.facepunch.com/gmod/DTree%20Node) that the file tree stems from.

This is a child of the root node of the [DTree](https://wiki.facepunch.com/gmod/DTree).

**Returns:**
- Panel — The DTree_Node used for the tree.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetFolderNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L267-L271)

---

### DFileBrowser:GetModels · Client
`DFileBrowser:GetModels() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns whether or not the model viewer mode is enabled. In this mode, files are displayed as [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon)s instead of a list.

**Returns:**
- boolean — Whether or not files will be displayed using SpawnIcons.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetModels) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L10)

---

### DFileBrowser:GetName · Client
`DFileBrowser:GetName() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the name being used for the file tree.

**Returns:**
- string — The name used for the root of the file tree.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L4)

---

### DFileBrowser:GetOpen · Client
`DFileBrowser:GetOpen() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns whether or not the file tree is open.

**Returns:**
- boolean — Whether or not the file tree is open.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetOpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L11)

---

### DFileBrowser:GetPath · Client
`DFileBrowser:GetPath() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the access path of the file tree. This is `GAME` unless changed with [DFileBrowser:SetPath](https://wiki.facepunch.com/gmod/DFileBrowser:SetPath).

See [file.Read](https://wiki.facepunch.com/gmod/file.Read) for how paths work.

**Returns:**
- string — The current access path i.e.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetPath) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L5)

---

### DFileBrowser:GetSearch · Client
`DFileBrowser:GetSearch() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the current search filter on the file tree.

**Returns:**
- string — The filter in use on the file tree.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:GetSearch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L9)

---

### DFileBrowser:OnDoubleClick · Client · `hook`
`DFileBrowser:OnDoubleClick(selectedPanel: Panel, filePath: string)`

Called when a file is double-clicked.

**Arguments:**
- `selectedPanel` (Panel) — The panel that was double-clicked to select this file.This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled.
- `filePath` (string) — The path to the file that was double-clicked.

> **Note:** Double-clicking a file or icon will trigger **both** this and [DFileBrowser:OnSelect](https://wiki.facepunch.com/gmod/DFileBrowser:OnSelect).

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:OnDoubleClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L297-L301)

---

### DFileBrowser:OnRightClick · Client · `hook`
`DFileBrowser:OnRightClick(filePath: string, selectedPanel: Panel)`

Called when a file is right-clicked.

**Arguments:**
- `filePath` (string) — The path to the file that was right-clicked.
- `selectedPanel` (Panel) — The panel that was right-clicked to select this file.

> **Note:** When not in model viewer mode, [DFileBrowser:OnSelect](https://wiki.facepunch.com/gmod/DFileBrowser:OnSelect) will also be called if the file is not already selected.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:OnRightClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L303-L307)

---

### DFileBrowser:OnSelect · Client · `hook`
`DFileBrowser:OnSelect(selectedPanel: Panel, filePath: string)`

Called when a file is selected.

**Arguments:**
- `selectedPanel` (Panel) — The panel that was clicked to select this file.This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled.
- `filePath` (string) — The path to the file that was selected.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:OnSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L291-L295)

---

### DFileBrowser:SetBaseFolder · Client
`DFileBrowser:SetBaseFolder(baseDir: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the root directory/folder of the file tree.

This needs to be set for the file tree to be displayed.

**Arguments:**
- `baseDir` (string) — The path to the folder to use as the root.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetBaseFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L50-L57)

---

### DFileBrowser:SetCurrentFolder · Client
`DFileBrowser:SetCurrentFolder(currentDir: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the directory/folder from which to display the file list.

**Arguments:**
- `currentDir` (string) — The directory to display files from.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetCurrentFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L104-L118)

---

### DFileBrowser:SetFileTypes · Client
`DFileBrowser:SetFileTypes(fileTypes: string = *.*)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the file type filter for the file list.

This accepts the same file extension wildcards as [file.Find](https://wiki.facepunch.com/gmod/file.Find).

**Arguments:**
- `fileTypes` (string, default `*.*`) — A list of file types to display, separated by spaces e.g.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetFileTypes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L81-L90)

---

### DFileBrowser:SetModels · Client
`DFileBrowser:SetModels(showModels: boolean = false)`

Enables or disables the model viewer mode. In this mode, files are displayed as [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon)s instead of a list.

**Arguments:**
- `showModels` (boolean, default `false`) — Whether or not to display files using SpawnIcons.

> **Note:** This should only be used for `.mdl` files; the spawn icons will display error models for others. See [DFileBrowser:SetFileTypes](https://wiki.facepunch.com/gmod/DFileBrowser:SetFileTypes)

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetModels) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L92-L102)

---

### DFileBrowser:SetName · Client
`DFileBrowser:SetName(treeName: string = `baseFolder`)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the name to use for the file tree.

**Arguments:**
- `treeName` (string, default ``baseFolder``) — The name for the root of the file tree.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L36-L48)

---

### DFileBrowser:SetOpen · Client
`DFileBrowser:SetOpen(open: boolean = false, useAnim: boolean = false)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that opens or closes the file tree.

**Arguments:**
- `open` (boolean, default `false`) — `true` to open the tree, `false` to close it.
- `useAnim` (boolean, default `false`) — If `true`, the DTree's open/close animation is used.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetOpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L120-L131)

---

### DFileBrowser:SetPath · Client
`DFileBrowser:SetPath(path: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the access path for the file tree. This is set to `GAME` by default.

See [file.Read](https://wiki.facepunch.com/gmod/file.Read) for how paths work.

**Arguments:**
- `path` (string) — The access path i.e.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetPath) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L59-L66)

---

### DFileBrowser:SetSearch · Client
`DFileBrowser:SetSearch(filter: string = *)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the search filter for the file tree.

This accepts the same wildcards as [file.Find](https://wiki.facepunch.com/gmod/file.Find).

**Arguments:**
- `filter` (string, default `*`) — The filter to use on the file tree.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetSearch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L68-L79)

---

### DFileBrowser:Setup · Client · `INTERNAL`
`DFileBrowser:Setup() → boolean`

Called to set up the [DTree](https://wiki.facepunch.com/gmod/DTree) and file viewer when a base path has been set.

Calls [DFileBrowser:SetupTree](https://wiki.facepunch.com/gmod/DFileBrowser:SetupTree) and [DFileBrowser:SetupFiles](https://wiki.facepunch.com/gmod/DFileBrowser:SetupFiles).

**Returns:**
- boolean — Whether or not the variables needed to set up have been defined.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:Setup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L202-L208)

---

### DFileBrowser:SetupFiles · Client · `INTERNAL`
`DFileBrowser:SetupFiles() → boolean`

Called to set up the [DListView](https://wiki.facepunch.com/gmod/DListView) or [DIconBrowser](https://wiki.facepunch.com/gmod/DIconBrowser) by [DFileBrowser:Setup](https://wiki.facepunch.com/gmod/DFileBrowser:Setup).

The icon browser is used when in models mode. See [DFileBrowser:SetModels](https://wiki.facepunch.com/gmod/DFileBrowser:SetModels).

**Returns:**
- boolean — Whether or not the files pane was set up successfully.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetupFiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L169-L200)

---

### DFileBrowser:SetupTree · Client · `INTERNAL`
`DFileBrowser:SetupTree() → boolean`

Called to set up the [DTree](https://wiki.facepunch.com/gmod/DTree) by [DFileBrowser:Setup](https://wiki.facepunch.com/gmod/DFileBrowser:Setup).

**Returns:**
- boolean — Whether or not the tree was set up successfully.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SetupTree) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L143-L167)

---

### DFileBrowser:ShowFolder · Client · `INTERNAL`
`DFileBrowser:ShowFolder(currentDir: string)`

Builds the file or icon list for the current directory.

You should use [DFileBrowser:SetCurrentFolder](https://wiki.facepunch.com/gmod/DFileBrowser:SetCurrentFolder) to change the directory.

**Arguments:**
- `currentDir` (string) — The directory to populate the list from.

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:ShowFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L210-L257)

---

### DFileBrowser:SortFiles · Client
`DFileBrowser:SortFiles(descending: boolean = false)`

Sorts the file list.

**Arguments:**
- `descending` (boolean, default `false`) — The sort order.

> **Note:** This is only functional when not using the model viewer. See [DFileBrowser:SetModels](https://wiki.facepunch.com/gmod/DFileBrowser:SetModels)

[wiki](https://wiki.facepunch.com/gmod/DFileBrowser:SortFiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dfilebrowser.lua#L259-L265)
