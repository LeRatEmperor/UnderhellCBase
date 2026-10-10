# DTree_Node

**Realm:** Client, Menu  ·  **Members:** 75  ·  **Inherits:** `DPanel`  ·  `INTERNAL`

This panel is created whenever you add a node to a [DTree](https://wiki.facepunch.com/gmod/DTree).
The root node of a [DTree](https://wiki.facepunch.com/gmod/DTree) is also a [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) and controls much of its action. it can be accessed with [DTree:Root](https://wiki.facepunch.com/gmod/DTree:Root).

[wiki page](https://wiki.facepunch.com/gmod/DTree_Node)

### DTree_Node:AddFolder · Client, Menu
`DTree_Node:AddFolder(name: string, folder: string, path: string, showFiles: boolean = false, wildcard: string = *, bDontForceExpandable: boolean = false) → Panel`

A helper function that adds a new node and calls to [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder) on it.

**Arguments:**
- `name` (string) — The name of the new node
- `folder` (string) — The folder in the filesystem to use, relative to the garrysmod/ folder.
- `path` (string) — The path to search in.
- `showFiles` (boolean, default `false`) — Should files be added as nodes (true) or folders only (false)
- `wildcard` (string, default `*`) — The wildcard to use when searching for files.
- `bDontForceExpandable` (boolean, default `false`)

**Returns:**
- Panel — The created DTree_Node

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:AddFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L395-L401)

---

### DTree_Node:AddNode · Client, Menu
`DTree_Node:AddNode(name: string, icon: string = icon16/folder.png) → Panel`

Add a child node to the DTree_Node

**Arguments:**
- `name` (string) — Name of the node.
- `icon` (string, default `icon16/folder.png`) — The icon that will show next to the node in the DTree.

**Returns:**
- Panel — Returns the created DTree_Node panel.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:AddNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L338-L357)

---

### DTree_Node:AddPanel · Client, Menu · `INTERNAL`
`DTree_Node:AddPanel(pnl: Panel)`

Adds the given panel to the child nodes list, a [DListLayout](https://wiki.facepunch.com/gmod/DListLayout).

**Arguments:**
- `pnl` (Panel) — The panel to add.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:AddPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L329-L336)

---

### DTree_Node:AnimSlide · Client, Menu · `INTERNAL`
`DTree_Node:AnimSlide(anim: table, delta: number, data: table)`

Internal function that handles the expand/collapse animations.

**Arguments:**
- `anim` (table)
- `delta` (number)
- `data` (table)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:AnimSlide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L101-L124)

---

### DTree_Node:ChildExpanded · Client, Menu · `INTERNAL`
`DTree_Node:ChildExpanded(expanded: boolean)`

Called when a child node is expanded or collapsed to propagate this event to parent nodes to update layout.

**Arguments:**
- `expanded` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:ChildExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L206-L212)

---

### DTree_Node:CleanList · Client, Menu
`DTree_Node:CleanList()`

Cleans up the internal table of items (sub-nodes) of this node from invalid panels or sub-nodes that were moved from this node to another.

Appears the be completely unused by the game on its own.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:CleanList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L576-L586)

---

### DTree_Node:Copy · Client, Menu
`DTree_Node:Copy() → Panel`

Create and returns a copy of this node, including all the sub-nodes.

**Returns:**
- Panel — The copied DTree_Node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L645-L668)

---

### DTree_Node:CreateChildNodes · Client, Menu · `INTERNAL`
`DTree_Node:CreateChildNodes()`

Creates the container [DListLayout](https://wiki.facepunch.com/gmod/DListLayout) for the [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node)s.

This is called automatically so you don't have to.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:CreateChildNodes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L301-L327)

---

### DTree_Node:DoChildrenOrder · Client, Menu · `hook` · `INTERNAL`
`DTree_Node:DoChildrenOrder()`

Called automatically to update the status of [DTree_Node:GetLastChild](https://wiki.facepunch.com/gmod/DTree_Node:GetLastChild) on children of this node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:DoChildrenOrder)

---

### DTree_Node:DoClick · Client, Menu · `hook`
`DTree_Node:DoClick() → boolean`

Called when the node is clicked.

See also [DTree_Node:DoRightClick](https://wiki.facepunch.com/gmod/DTree_Node:DoRightClick).

**Returns:**
- boolean — Return true to prevent DoClick from being called on parent nodes or the DTree itself.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:DoClick)

---

### DTree_Node:DoRightClick · Client, Menu · `hook`
`DTree_Node:DoRightClick() → boolean`

Called when the node is right clicked.

See also [DTree_Node:DoClick](https://wiki.facepunch.com/gmod/DTree_Node:DoClick).

**Returns:**
- boolean — Return true to prevent DoRightClick from being called on parent nodes or the DTree itself.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:DoRightClick)

---

### DTree_Node:ExpandRecurse · Client, Menu
`DTree_Node:ExpandRecurse(expand: boolean)`

Expands or collapses this node, as well as ALL child nodes of this node.

Works opposite of [DTree_Node:ExpandTo](https://wiki.facepunch.com/gmod/DTree_Node:ExpandTo).

**Arguments:**
- `expand` (boolean) — Whether to expand (true) or collapse (false)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:ExpandRecurse) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L150-L162)

---

### DTree_Node:ExpandTo · Client, Menu
`DTree_Node:ExpandTo(expand: boolean)`

Collapses or expands all nodes from the topmost-level node to this one.

Works opposite of [DTree_Node:ExpandRecurse](https://wiki.facepunch.com/gmod/DTree_Node:ExpandRecurse).

**Arguments:**
- `expand` (boolean) — Whether to expand (true) or collapse (false)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:ExpandTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L164-L169)

---

### DTree_Node:FilePopulate · Client, Menu · `INTERNAL`
`DTree_Node:FilePopulate(bAndChildren: boolean, bExpand: boolean)`

Called automatically from [DTree_Node:PopulateChildrenAndSelf](https://wiki.facepunch.com/gmod/DTree_Node:PopulateChildrenAndSelf) and [DTree_Node:PopulateChildren](https://wiki.facepunch.com/gmod/DTree_Node:PopulateChildren) to populate this node with child nodes of files and folders.

**Arguments:**
- `bAndChildren` (boolean) — Does nothing.
- `bExpand` (boolean) — Expand self once population process is finished.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:FilePopulate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L474-L498)

---

### DTree_Node:FilePopulateCallback · Client, Menu · `INTERNAL`
`DTree_Node:FilePopulateCallback(files: table, folders: table, foldername: string, path: string, bAndChildren: boolean, wildcard: string)`

Called automatically from [DTree_Node:FilePopulate](https://wiki.facepunch.com/gmod/DTree_Node:FilePopulate) to actually fill the node with sub-nodes based on set preferences like should files be added, etc.

**Arguments:**
- `files` (table) — A list of files in this folder
- `folders` (table) — A list of folder in this folder.
- `foldername` (string) — The folder name/path this node represents
- `path` (string) — The Path ID search was performed with.
- `bAndChildren` (boolean) — Inherited from the FilePopulate call.
- `wildcard` (string) — The wildcard that was given

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:FilePopulateCallback) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L421-L472)

---

### DTree_Node:GetChildNode · Client, Menu
`DTree_Node:GetChildNode(num: number) → Panel`

Returns n-th child node.

Basically an alias of [Panel:GetChild](https://wiki.facepunch.com/gmod/Panel:GetChild).

**Arguments:**
- `num` (number) — The number of the child to get, starting with 0

**Returns:**
- Panel — The child panel, if valid ID is given

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetChildNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L618-L623)

---

### DTree_Node:GetChildNodeCount · Client, Menu
`DTree_Node:GetChildNodeCount() → number`

Returns the number of child nodes this node has. For use with [DTree_Node:GetChildNode](https://wiki.facepunch.com/gmod/DTree_Node:GetChildNode)

**Returns:**
- number — Number of child nodes.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetChildNodeCount) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L632-L637)

---

### DTree_Node:GetChildNodes · Client, Menu
`DTree_Node:GetChildNodes() → table`

Returns a table containing all child nodes of this node.

**Returns:**
- table — A list of all child nodes.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetChildNodes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L625-L630)

---

### DTree_Node:GetDirty · Client, Menu · `DEPRECATED`
`DTree_Node:GetDirty() → boolean`

Returns value set by [DTree_Node:SetDirty](https://wiki.facepunch.com/gmod/DTree_Node:SetDirty).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetDirty)

---

### DTree_Node:GetDoubleClickToOpen · Client, Menu
`DTree_Node:GetDoubleClickToOpen() → boolean`

Returns whether the double clock to collapse/expand functionality is enabled on this node.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetDoubleClickToOpen)

---

### DTree_Node:GetDraggableName · Client, Menu · `INTERNAL`
`DTree_Node:GetDraggableName() → string`

Returns what is set by [DTree_Node:SetDraggableName](https://wiki.facepunch.com/gmod/DTree_Node:SetDraggableName).

**Returns:**
- string

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetDraggableName)

---

### DTree_Node:GetDrawLines · Client, Menu · `INTERNAL`
`DTree_Node:GetDrawLines() → boolean`

Returns whether or not this node is drawing lines

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetDrawLines)

---

### DTree_Node:GetExpanded · Client, Menu
`DTree_Node:GetExpanded() → boolean`

Returns whether the node is expanded or not.

**Returns:**
- boolean — Expanded or not.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetExpanded)

---

### DTree_Node:GetFileName · Client, Menu
`DTree_Node:GetFileName() → string`

Returns the filepath of the file attached to this node.

**Returns:**
- string

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetFileName)

---

### DTree_Node:GetFolder · Client, Menu
`DTree_Node:GetFolder() → string`

Returns the folder path to search in, set by [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder).

**Returns:**
- string — The folder path.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetFolder)

---

### DTree_Node:GetForceShowExpander · Client, Menu
`DTree_Node:GetForceShowExpander() → boolean`

Returns whether the expand/collapse button is shown on this node regardless of whether or not it has sub-nodes.

See also [DTree_Node:SetForceShowExpander](https://wiki.facepunch.com/gmod/DTree_Node:SetForceShowExpander).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetForceShowExpander)

---

### DTree_Node:GetHideExpander · Client, Menu
`DTree_Node:GetHideExpander() → boolean`

Returns whether the expand button (little + button) should be shown or hidden.

**Returns:**
- boolean — Цhether the expand button should be shown or hidden.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetHideExpander)

---

### DTree_Node:GetIcon · Client, Menu
`DTree_Node:GetIcon() → string`

Returns the image path to the icon of this node.

**Returns:**
- string — The path to the image

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L572-L574)

---

### DTree_Node:GetIndentSize · Client, Menu
`DTree_Node:GetIndentSize() → number`

Returns the indentation level of the [DTree](https://wiki.facepunch.com/gmod/DTree) this node belongs to.

Alias of [DTree:GetIndentSize](https://wiki.facepunch.com/gmod/DTree:GetIndentSize), see it for more info.

**Returns:**
- number — The indentation level.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetIndentSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L140-L142)

---

### DTree_Node:GetLastChild · Client, Menu
`DTree_Node:GetLastChild() → boolean`

Returns whether this node is the last child on this level or not.

**Returns:**
- boolean — Whether this node is the last child on this level or not.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetLastChild)

---

### DTree_Node:GetLineHeight · Client, Menu
`DTree_Node:GetLineHeight() → number`

The height of a single [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) of the [DTree](https://wiki.facepunch.com/gmod/DTree) this node belongs to.

Alias of [DTree:GetLineHeight](https://wiki.facepunch.com/gmod/DTree:GetLineHeight).

**Returns:**
- number — The height of a single DTree_Node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetLineHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L136-L138)

---

### DTree_Node:GetNeedsChildSearch · Client, Menu · `DEPRECATED` · `INTERNAL`
`DTree_Node:GetNeedsChildSearch() → boolean`

Returns whether the node still needs a filesystem search for sub-nodes.

**Returns:**
- boolean — Whether the node still needs a filesystem search.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetNeedsChildSearch)

---

### DTree_Node:GetNeedsPopulating · Client, Menu · `INTERNAL`
`DTree_Node:GetNeedsPopulating() → boolean`

Returns whether or not the node is set to be populated from the filesystem.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetNeedsPopulating)

---

### DTree_Node:GetParentNode · Client, Menu
`DTree_Node:GetParentNode() → Panel`

Returns the parent [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node). Note that [Panel:GetParent](https://wiki.facepunch.com/gmod/Panel:GetParent) will not be the same!

**Returns:**
- Panel — The parent node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetParentNode)

---

### DTree_Node:GetPathID · Client, Menu
`DTree_Node:GetPathID() → string`

Returns the path ID ([File Search Paths](https://wiki.facepunch.com/gmod/File%20Search%20Paths)) used in populating the [DTree](https://wiki.facepunch.com/gmod/DTree) from the filesystem.

See [DTree_Node:SetPathID](https://wiki.facepunch.com/gmod/DTree_Node:SetPathID) and [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder).

**Returns:**
- string — The Path ID

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetPathID)

---

### DTree_Node:GetRoot · Client, Menu
`DTree_Node:GetRoot() → Panel`

Returns the root node, the [DTree](https://wiki.facepunch.com/gmod/DTree) this node is under.

See also [DTree_Node:GetParentNode](https://wiki.facepunch.com/gmod/DTree_Node:GetParentNode).

**Returns:**
- Panel — The root node

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetRoot)

---

### DTree_Node:GetShowFiles · Client, Menu
`DTree_Node:GetShowFiles() → boolean`

Returns whether or not nodes for files should/will be added when populating the node from filesystem.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetShowFiles)

---

### DTree_Node:GetWildCard · Client, Menu
`DTree_Node:GetWildCard() → string`

Returns the wildcard set by [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder).

**Returns:**
- string — The search wildcard

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:GetWildCard)

---

### DTree_Node:Insert · Client, Menu
`DTree_Node:Insert(node: Panel, nodeNextTo: Panel, before: boolean)`

Inserts a sub-node into this node before or after the given node.

**Arguments:**
- `node` (Panel) — The DTree_Node to insert.
- `nodeNextTo` (Panel) — The node to insert the node above before or after.
- `before` (boolean) — true to insert before, false to insert after.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:Insert) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L588-L603)

---

### DTree_Node:InsertNode · Client, Menu · `INTERNAL`
`DTree_Node:InsertNode(node: Panel)`

Inserts an existing node as a "child" or a sub-node of this node.
Used internally by the drag'n'drop functionality.

**Arguments:**
- `node` (Panel) — Has to be DTree_Node

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:InsertNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L359-L372)

---

### DTree_Node:InstallDraggable · Client, Menu · `INTERNAL`
`DTree_Node:InstallDraggable(node: Panel)`

Called automatically internally.

Makes the target node compatible with this node's drag'n'drop.

**Arguments:**
- `node` (Panel) — The DTree_Node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:InstallDraggable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L374-L386)

---

### DTree_Node:InternalDoClick · Client, Menu · `INTERNAL`
`DTree_Node:InternalDoClick()`

See [DTree_Node:DoClick](https://wiki.facepunch.com/gmod/DTree_Node:DoClick)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:InternalDoClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L58-L71)

---

### DTree_Node:InternalDoRightClick · Client, Menu · `INTERNAL`
`DTree_Node:InternalDoRightClick()`

See [DTree_Node:DoRightClick](https://wiki.facepunch.com/gmod/DTree_Node:DoRightClick).

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:InternalDoRightClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L82-L87)

---

### DTree_Node:IsRootNode · Client, Menu
`DTree_Node:IsRootNode() → boolean`

Returns true if [DTree_Node:GetRoot](https://wiki.facepunch.com/gmod/DTree_Node:GetRoot) is the same as [DTree_Node:GetParentNode](https://wiki.facepunch.com/gmod/DTree_Node:GetParentNode) of this node.

**Returns:**
- boolean — If this is a root node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:IsRootNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L54-L56)

---

### DTree_Node:LeaveTree · Client, Menu
`DTree_Node:LeaveTree(pnl: Panel)`

Removes given node as a sub-node of this node.

It doesn't actually remove or unparent the panel, just removes it from the internal [DListView](https://wiki.facepunch.com/gmod/DListView).

**Arguments:**
- `pnl` (Panel) — The node to remove

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:LeaveTree) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L605-L610)

---

### DTree_Node:MakeFolder · Client, Menu
`DTree_Node:MakeFolder(folder: string, path: string, showFiles: boolean = false, wildcard: string = *, dontForceExpandable: boolean = false)`

Makes this node a folder in the filesystem. This will make it automatically populated.

See also [DTree_Node:AddFolder](https://wiki.facepunch.com/gmod/DTree_Node:AddFolder).

**Arguments:**
- `folder` (string) — The folder in the filesystem to use, relative to the garrysmod/ folder.
- `path` (string) — The path to search in.
- `showFiles` (boolean, default `false`) — Should files be added as nodes (true) or folders only (false)
- `wildcard` (string, default `*`) — The wildcard to use when searching for files.
- `dontForceExpandable` (boolean, default `false`) — If set to true, don't show the expand buttons on empty nodes.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L403-L419)

---

### DTree_Node:MoveChildTo · Client, Menu
`DTree_Node:MoveChildTo(node: Panel)`

Moves given panel to the top of the children of this node.

Despite name of this function, it cannot move the children to any position but the topmost.

**Arguments:**
- `node` (Panel) — The node to move.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:MoveChildTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L562-L566)

---

### DTree_Node:MoveToTop · Client, Menu
`DTree_Node:MoveToTop()`

Moves this node to the top of the level.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:MoveToTop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L553-L560)

---

### DTree_Node:OnModified · Client, Menu · `hook`
`DTree_Node:OnModified()`

Called when sub-nodes of this [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) were changed, such as being rearranged if that functionality is enabled.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:OnModified)

---

### DTree_Node:OnNodeAdded · Client, Menu · `hook`
`DTree_Node:OnNodeAdded(newNode: DTree_Node)`

Called when a new sub-node is added this node.

**Arguments:**
- `newNode` (DTree_Node) — The newly added sub node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:OnNodeAdded)

---

### DTree_Node:OnNodeSelected · Client, Menu · `hook` · `INTERNAL`
`DTree_Node:OnNodeSelected(node: Panel)`

Called when this or a sub node is selected. Do not use this, it is not for override.

Use [DTree:OnNodeSelected](https://wiki.facepunch.com/gmod/DTree:OnNodeSelected) or [DTree_Node:DoClick](https://wiki.facepunch.com/gmod/DTree_Node:DoClick) instead.

**Arguments:**
- `node` (Panel)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:OnNodeSelected)

---

### DTree_Node:PerformRootNodeLayout · Client, Menu · `INTERNAL`
`DTree_Node:PerformRootNodeLayout()`

Called automatically to perform layout on this node if this node [DTree_Node:IsRootNode](https://wiki.facepunch.com/gmod/DTree_Node:IsRootNode).

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:PerformRootNodeLayout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L235-L248)

---

### DTree_Node:PopulateChildren · Client, Menu · `INTERNAL`
`DTree_Node:PopulateChildren()`

Called automatically from [DTree_Node:PopulateChildrenAndSelf](https://wiki.facepunch.com/gmod/DTree_Node:PopulateChildrenAndSelf).

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:PopulateChildren) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L500-L512)

---

### DTree_Node:PopulateChildrenAndSelf · Client, Menu · `INTERNAL`
`DTree_Node:PopulateChildrenAndSelf(expand: boolean)`

Called automatically from [DTree_Node:SetExpanded](https://wiki.facepunch.com/gmod/DTree_Node:SetExpanded) (or when user manually expands the node) to populate the node with sub-nodes from the filesystem if this was enabled via [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder).

**Arguments:**
- `expand` (boolean) — Expand self once population process is finished.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:PopulateChildrenAndSelf) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L514-L521)

---

### DTree_Node:SetDirty · Client, Menu · `DEPRECATED`
`DTree_Node:SetDirty(dirty: boolean)`

Appears to have no effect on the [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node).

**Arguments:**
- `dirty` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetDirty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetDoubleClickToOpen · Client, Menu
`DTree_Node:SetDoubleClickToOpen(enable: boolean)`

Sets whether double clicking the node should expand/collapse it or not.

**Arguments:**
- `enable` (boolean) — true to enable, false to disable this functionality.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetDoubleClickToOpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetDraggableName · Client, Menu · `INTERNAL`
`DTree_Node:SetDraggableName(name: string)`

Used to store name for sub elements for a [Panel:Droppable](https://wiki.facepunch.com/gmod/Panel:Droppable) call.

**Arguments:**
- `name` (string)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetDraggableName)

---

### DTree_Node:SetDrawLines · Client, Menu · `INTERNAL`
`DTree_Node:SetDrawLines(draw: boolean)`

Sets whether or not this node should draw visual lines.

**Arguments:**
- `draw` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetDrawLines) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetExpanded · Client, Menu
`DTree_Node:SetExpanded(expand: boolean, surpressAnimation: boolean = false)`

Expands or collapses this node.

**Arguments:**
- `expand` (boolean) — Whether to expand (true) or collapse (false)
- `surpressAnimation` (boolean, default `false`) — Whether to play animation (false) or not (true)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L171-L204)

---

### DTree_Node:SetFileName · Client, Menu · `INTERNAL`
`DTree_Node:SetFileName(filename: string)`

Sets the file full filepath to the file attached to this node

**Arguments:**
- `filename` (string)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetFileName)

---

### DTree_Node:SetFolder · Client, Menu · `INTERNAL`
`DTree_Node:SetFolder(folder: string)`

Sets the folder to search files and folders in.

Use [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder) instead.

**Arguments:**
- `folder` (string)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetFolder)

---

### DTree_Node:SetForceShowExpander · Client, Menu
`DTree_Node:SetForceShowExpander(forceShow: boolean)`

Sets whether or not the expand/collapse button (+/- button) should be shown on this node regardless of whether it has sub-elements or not.

**Arguments:**
- `forceShow` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetForceShowExpander) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetHideExpander · Client, Menu · `INTERNAL`
`DTree_Node:SetHideExpander(hide: boolean)`

Sets whether the expand button (little + button) should be shown or hidden.

**Arguments:**
- `hide` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetHideExpander) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetIcon · Client, Menu
`DTree_Node:SetIcon(path: string)`

Sets the material for the icon of the [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node).

**Arguments:**
- `path` (string) — The path to the material to be used.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L126-L130)

---

### DTree_Node:SetLastChild · Client, Menu · `INTERNAL`
`DTree_Node:SetLastChild(last: boolean)`

Called automatically to set whether this node is the last child on this level or not.

**Arguments:**
- `last` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetLastChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetNeedsChildSearch · Client, Menu · `DEPRECATED` · `INTERNAL`
`DTree_Node:SetNeedsChildSearch(newState: boolean)`

Sets whether the node still needs a filesystem search for sub-nodes.

**Arguments:**
- `newState` (boolean) — New state.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetNeedsChildSearch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetNeedsPopulating · Client, Menu · `INTERNAL`
`DTree_Node:SetNeedsPopulating(needs: boolean)`

Sets whether or not the node needs populating from the filesystem.

**Arguments:**
- `needs` (boolean) — Whether or not the node needs populating

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetNeedsPopulating)

---

### DTree_Node:SetParentNode · Client, Menu · `INTERNAL`
`DTree_Node:SetParentNode(parent: Panel)`

Sets the parent node of this node. Not the same as [Panel:SetParent](https://wiki.facepunch.com/gmod/Panel:SetParent).

This is set automatically, you shouldn't use this.

**Arguments:**
- `parent` (Panel) — The panel to set as a parent node for this node

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetParentNode)

---

### DTree_Node:SetPathID · Client, Menu · `INTERNAL`
`DTree_Node:SetPathID(path: string)`

Sets the path ID ([File Search Paths](https://wiki.facepunch.com/gmod/File%20Search%20Paths)) for populating the tree from the filesystem.

Use [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder) instead.

**Arguments:**
- `path` (string) — The path ID to set.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetPathID)

---

### DTree_Node:SetRoot · Client, Menu · `INTERNAL`
`DTree_Node:SetRoot(root: Panel)`

Sets the root node (the [DTree](https://wiki.facepunch.com/gmod/DTree)) of this node.

This is set automatically, you shouldn't use this.

**Arguments:**
- `root` (Panel) — The panel to set as root node.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetRoot)

---

### DTree_Node:SetSelected · Client, Menu · `INTERNAL`
`DTree_Node:SetSelected(selected: boolean)`

Called automatically to update the "selected" status of this node.

**Arguments:**
- `selected` (boolean) — Whether this node is currently selected or not.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L523-L528)

---

### DTree_Node:SetShowFiles · Client, Menu · `INTERNAL`
`DTree_Node:SetShowFiles(showFiles: boolean)`

Sets whether or not nodes for files should be added when populating the node from filesystem.

**Arguments:**
- `showFiles` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetShowFiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTree_Node:SetupCopy · Client, Menu · `DEPRECATED`
`DTree_Node:SetupCopy()`

Currently does nothing, not implemented.

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetupCopy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L670-L674)

---

### DTree_Node:SetWildCard · Client, Menu · `INTERNAL`
`DTree_Node:SetWildCard(wildcard: string)`

Sets the search wildcard.

Use [DTree_Node:MakeFolder](https://wiki.facepunch.com/gmod/DTree_Node:MakeFolder) instead

**Arguments:**
- `wildcard` (string) — The wildcard to set

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:SetWildCard)

---

### DTree_Node:ShowIcons · Client, Menu
`DTree_Node:ShowIcons() → number`

Returns whether or not the [DTree](https://wiki.facepunch.com/gmod/DTree) this node is in has icons enabled.

See [DTree:ShowIcons](https://wiki.facepunch.com/gmod/DTree:ShowIcons) for more info.

**Returns:**
- number — Whether the icons are shown or not

[wiki](https://wiki.facepunch.com/gmod/DTree_Node:ShowIcons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree_node.lua#L132-L134)
