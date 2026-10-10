# dragndrop

**Realm:** Client, Menu  ·  **Members:** 11

The drag'n'drop library, used internally by certain base panels to allow for drag'n'drop functionality, like spawnmenu's customizations.

[wiki page](https://wiki.facepunch.com/gmod/dragndrop)

### dragndrop.CallReceiverFunction · Client, Menu · `INTERNAL`
`dragndrop.CallReceiverFunction(bDoDrop: boolean, command: number, mx: number, my: number)`

Calls the receiver function of hovered panel.

**Arguments:**
- `bDoDrop` (boolean) — true if the mouse was released, false if we right clicked.
- `command` (number) — The command value.
- `mx` (number) — The local to the panel mouse cursor X position when the click happened.
- `my` (number) — The local to the panel mouse cursor Y position when the click happened.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.CallReceiverFunction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L181-L198)

---

### dragndrop.Clear · Client, Menu
`dragndrop.Clear()`

Clears all the internal drag'n'drop variables.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L12-L25)

---

### dragndrop.Drop · Client, Menu · `INTERNAL`
`dragndrop.Drop()`

Handles the drop action of drag'n'drop library.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.Drop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L43-L82)

---

### dragndrop.GetDroppable · Client, Menu
`dragndrop.GetDroppable(name: string = nil) → table`

Returns a table of currently dragged panels.

**Arguments:**
- `name` (string, default `nil`) — If set, the function will return only the panels with this Panel:Droppable name.

**Returns:**
- table — A table of all panels that are being currently dragged, if any.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.GetDroppable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L168-L179)

---

### dragndrop.HandleDroppedInGame · Client, Menu
`dragndrop.HandleDroppedInGame()`

Allows you to capture the panel that was dropped into the game (dropped onto the root panel). This function is meant to be overridden.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.HandleDroppedInGame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L35-L41)

---

### dragndrop.HoverThink · Client, Menu · `INTERNAL`
`dragndrop.HoverThink()`

Handles the hover think. Called from [dragndrop.Think](https://wiki.facepunch.com/gmod/dragndrop.Think).

[wiki](https://wiki.facepunch.com/gmod/dragndrop.HoverThink) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L563-L587)

---

### dragndrop.IsDragging · Client, Menu
`dragndrop.IsDragging() → boolean`

Returns whether the user is dragging something with the drag'n'drop system.

**Returns:**
- boolean — True if the user is dragging something with the drag'n'drop system.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.IsDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L27-L33)

---

### dragndrop.StartDragging · Client, Menu · `INTERNAL`
`dragndrop.StartDragging()`

Starts the drag'n'drop.

[wiki](https://wiki.facepunch.com/gmod/dragndrop.StartDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L84-L117)

---

### dragndrop.StopDragging · Client, Menu
`dragndrop.StopDragging()`

Stops the drag'n'drop and calls [dragndrop.Clear](https://wiki.facepunch.com/gmod/dragndrop.Clear).

[wiki](https://wiki.facepunch.com/gmod/dragndrop.StopDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L119-L135)

---

### dragndrop.Think · Client, Menu · `INTERNAL`
`dragndrop.Think()`

Handles all the drag'n'drop processes. Calls [dragndrop.UpdateReceiver](https://wiki.facepunch.com/gmod/dragndrop.UpdateReceiver) and [dragndrop.HoverThink](https://wiki.facepunch.com/gmod/dragndrop.HoverThink).

[wiki](https://wiki.facepunch.com/gmod/dragndrop.Think) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L200-L237)

---

### dragndrop.UpdateReceiver · Client, Menu · `INTERNAL`
`dragndrop.UpdateReceiver()`

Updates the receiver to drop the panels onto. Called from [dragndrop.Think](https://wiki.facepunch.com/gmod/dragndrop.Think).

[wiki](https://wiki.facepunch.com/gmod/dragndrop.UpdateReceiver) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L137-L163)
