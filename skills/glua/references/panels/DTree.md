# DTree

**Realm:** Client, Menu  ·  **Members:** 21  ·  **Inherits:** `DScrollPanel`

A tree view element for Derma.

See also [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node).

[wiki page](https://wiki.facepunch.com/gmod/DTree)

### DTree:AddNode · Client, Menu
`DTree:AddNode(name: string, icon: string = icon16/folder.png) → Panel`

Add a node to the DTree

**Arguments:**
- `name` (string) — Name of the option.
- `icon` (string, default `icon16/folder.png`) — The icon that will show nexto the node in the DTree.

**Returns:**
- Panel — Returns the created DTree_Node panel.

[wiki](https://wiki.facepunch.com/gmod/DTree:AddNode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L39-L43)

---

### DTree:ChildExpanded · Client, Menu · `hook` · `INTERNAL`
`DTree:ChildExpanded(bExpand: boolean)`

Calls directly to [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout).
Called by [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node)s when a sub element has been expanded or collapsed.

Used as a placeholder function alongside [DTree:ExpandTo](https://wiki.facepunch.com/gmod/DTree:ExpandTo), [DTree:SetExpanded](https://wiki.facepunch.com/gmod/DTree:SetExpanded) and [DTree:MoveChildTo](https://wiki.facepunch.com/gmod/DTree:MoveChildTo).

The [DTree](https://wiki.facepunch.com/gmod/DTree) acts a root node and methods with the same name in [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) call to the parent.

**Arguments:**
- `bExpand` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:ChildExpanded)

---

### DTree:DoClick · Client, Menu · `hook`
`DTree:DoClick(node: DTree_Node) → boolean`

Called when the any node is clicked. Called by [DTree_Node:DoClick](https://wiki.facepunch.com/gmod/DTree_Node:DoClick).

**Arguments:**
- `node` (DTree_Node) — The right clicked node.

**Returns:**
- `suppress` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:DoClick)

---

### DTree:DoRightClick · Client, Menu · `hook`
`DTree:DoRightClick(node: DTree_Node) → boolean`

Called when the any node is right clicked. Called by [DTree_Node:DoRightClick](https://wiki.facepunch.com/gmod/DTree_Node:DoRightClick).

**Arguments:**
- `node` (DTree_Node) — The right clicked node.

**Returns:**
- `suppress` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:DoRightClick)

---

### DTree:ExpandTo · Client, Menu · `INTERNAL`
`DTree:ExpandTo(bExpand: boolean)`

Does nothing. Used as a placeholder empty function alongside [DTree:MoveChildTo](https://wiki.facepunch.com/gmod/DTree:MoveChildTo), [DTree:SetExpanded](https://wiki.facepunch.com/gmod/DTree:SetExpanded) and [DTree:ChildExpanded](https://wiki.facepunch.com/gmod/DTree:ChildExpanded).

The [DTree](https://wiki.facepunch.com/gmod/DTree) acts a root node and methods with the same name in [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) call to the parent.

**Arguments:**
- `bExpand` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:ExpandTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L57-L58)

---

### DTree:GetClickOnDragHover · Client, Menu
`DTree:GetClickOnDragHover() → boolean`

Returns the status of [DTree:SetClickOnDragHover](https://wiki.facepunch.com/gmod/DTree:SetClickOnDragHover). See that for more info.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTree:GetClickOnDragHover)

---

### DTree:GetIndentSize · Client, Menu
`DTree:GetIndentSize() → number`

Returns the indentation size of the [DTree](https://wiki.facepunch.com/gmod/DTree), the distance between each "level" of the tree is offset on the left from the previous level.

Currently this feature has no effect on the [DTree](https://wiki.facepunch.com/gmod/DTree) element.

**Returns:**
- number — The indentation size.

[wiki](https://wiki.facepunch.com/gmod/DTree:GetIndentSize)

---

### DTree:GetLineHeight · Client, Menu
`DTree:GetLineHeight() → number`

Returns the height of each [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) in the tree.

**Returns:**
- number — The height of each DTree_Node in the tree.

[wiki](https://wiki.facepunch.com/gmod/DTree:GetLineHeight)

---

### DTree:GetSelectedItem · Client, Menu
`DTree:GetSelectedItem() → Panel`

Returns the currently selected node.

**Returns:**
- Panel — Curently selected DTree_Node.

[wiki](https://wiki.facepunch.com/gmod/DTree:GetSelectedItem)

---

### DTree:GetShowIcons · Client, Menu
`DTree:GetShowIcons() → boolean`

Returns whether or not the [Silkicons](https://wiki.facepunch.com/gmod/Silkicons) next to each node of the DTree will be displayed.

Individual icons can be set with [DTree_Node:SetIcon](https://wiki.facepunch.com/gmod/DTree_Node:SetIcon) or passed as the second argument in [DTree:AddNode](https://wiki.facepunch.com/gmod/DTree:AddNode).

**Returns:**
- boolean — Whether or not the silkicons next to each node will be displayed.

[wiki](https://wiki.facepunch.com/gmod/DTree:GetShowIcons)

---

### DTree:LayoutTree · Client, Menu · `DEPRECATED`
`DTree:LayoutTree()`

Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DTree:LayoutTree) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L109-L113)

---

### DTree:MoveChildTo · Client, Menu
`DTree:MoveChildTo(child: Panel, pos: number)`

Moves given node to the top of [DTree](https://wiki.facepunch.com/gmod/DTree)s children. (Makes it the topmost mode)

Used as a placeholder function alongside [DTree:ExpandTo](https://wiki.facepunch.com/gmod/DTree:ExpandTo), [DTree:SetExpanded](https://wiki.facepunch.com/gmod/DTree:SetExpanded) and [DTree:ChildExpanded](https://wiki.facepunch.com/gmod/DTree:ChildExpanded).

The [DTree](https://wiki.facepunch.com/gmod/DTree) acts a root node and methods with the same name in [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) call to the parent.

**Arguments:**
- `child` (Panel) — The node to move
- `pos` (number) — Unused, does nothing.

[wiki](https://wiki.facepunch.com/gmod/DTree:MoveChildTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L103-L107)

---

### DTree:OnNodeSelected · Client, Menu · `hook`
`DTree:OnNodeSelected(node: Panel)`

This function is called when a node within a tree is selected.

**Arguments:**
- `node` (Panel) — The node that was selected.

[wiki](https://wiki.facepunch.com/gmod/DTree:OnNodeSelected)

---

### DTree:Root · Client, Menu
`DTree:Root() → Panel`

Returns the root [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node), the node that is the parent to all other nodes of the DTree.

**Returns:**
- Panel — Root node.

[wiki](https://wiki.facepunch.com/gmod/DTree:Root) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L35-L37)

---

### DTree:SetClickOnDragHover · Client, Menu
`DTree:SetClickOnDragHover(enable: boolean)`

Enables the "click when drag-hovering" functionality.

If enabled, when hovering over any [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) of this [DTree](https://wiki.facepunch.com/gmod/DTree) while dragging a panel, the node will be automatically clicked on (and subsequently [DTree:OnNodeSelected](https://wiki.facepunch.com/gmod/DTree:OnNodeSelected) will be called) to open any attached panels, such as spawnlists in spawnmenu.

See also: [PANEL:DragHoverClick](https://wiki.facepunch.com/gmod/PANEL:DragHoverClick).

**Arguments:**
- `enable` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:SetClickOnDragHover)

---

### DTree:SetExpanded · Client, Menu · `INTERNAL`
`DTree:SetExpanded(bExpand: boolean)`

Does nothing. Is not called by the [DTree](https://wiki.facepunch.com/gmod/DTree) itself.

Used as a placeholder empty function alongside [DTree:ExpandTo](https://wiki.facepunch.com/gmod/DTree:ExpandTo), [DTree:MoveChildTo](https://wiki.facepunch.com/gmod/DTree:MoveChildTo) and [DTree:ChildExpanded](https://wiki.facepunch.com/gmod/DTree:ChildExpanded) to prevent errors when [DTree_Node:SetExpanded](https://wiki.facepunch.com/gmod/DTree_Node:SetExpanded) is incorrectly used on a [DTree](https://wiki.facepunch.com/gmod/DTree).

**Arguments:**
- `bExpand` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTree:SetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L60-L64)

---

### DTree:SetIndentSize · Client, Menu
`DTree:SetIndentSize(size: number)`

Sets the indentation size of the [DTree](https://wiki.facepunch.com/gmod/DTree), the distance between each "level" of the tree is offset on the left from the previous level.

Currently this feature has no effect on the [DTree](https://wiki.facepunch.com/gmod/DTree) element.

**Arguments:**
- `size` (number) — The new indentation size.

[wiki](https://wiki.facepunch.com/gmod/DTree:SetIndentSize)

---

### DTree:SetLineHeight · Client, Menu
`DTree:SetLineHeight(h: number)`

Sets the height of each [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node) in the tree.

The default value is 17.

**Arguments:**
- `h` (number) — The height to set.

[wiki](https://wiki.facepunch.com/gmod/DTree:SetLineHeight)

---

### DTree:SetSelectedItem · Client, Menu
`DTree:SetSelectedItem(node: Panel)`

Set the currently selected top-level node.

**Arguments:**
- `node` (Panel) — DTree_Node to select.

[wiki](https://wiki.facepunch.com/gmod/DTree:SetSelectedItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L85-L98)

---

### DTree:SetShowIcons · Client, Menu
`DTree:SetShowIcons(show: boolean)`

Sets whether or not the [Silkicons](https://wiki.facepunch.com/gmod/Silkicons) next to each node of the DTree will be displayed.

Individual icons can be set with [DTree_Node:SetIcon](https://wiki.facepunch.com/gmod/DTree_Node:SetIcon) or passed as the second argument in [DTree:AddNode](https://wiki.facepunch.com/gmod/DTree:AddNode).

**Arguments:**
- `show` (boolean) — Whether or not to show icons.

[wiki](https://wiki.facepunch.com/gmod/DTree:SetShowIcons)

---

### DTree:ShowIcons · Client, Menu
`DTree:ShowIcons() → boolean`

Returns whether or not the [Silkicons](https://wiki.facepunch.com/gmod/Silkicons) next to each node of the DTree will be displayed.

Alias of [DTree:GetShowIcons](https://wiki.facepunch.com/gmod/DTree:GetShowIcons).

**Returns:**
- boolean — Whether or not the silkicons next to each node will be displayed.

[wiki](https://wiki.facepunch.com/gmod/DTree:ShowIcons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtree.lua#L51-L55)
