# DDragBase

**Realm:** Client, Menu  ·  **Members:** 13  ·  **Inherits:** `DPanel`  ·  `INTERNAL`

A VGUI base panel providing drag/drop functionality. Used by [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout), [DListLayout](https://wiki.facepunch.com/gmod/DListLayout) and [DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout).

[wiki page](https://wiki.facepunch.com/gmod/DDragBase)

### DDragBase:DropAction_Copy · Client, Menu · `INTERNAL`
`DDragBase:DropAction_Copy(drops: table, bDoDrop: boolean, command: string, y: number, x: number)`

Internal function used in [DDragBase:MakeDroppable](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable)

**Arguments:**
- `drops` (table)
- `bDoDrop` (boolean)
- `command` (string)
- `y` (number)
- `x` (number)

[wiki](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L47-L51)

---

### DDragBase:DropAction_Normal · Client, Menu · `INTERNAL`
`DDragBase:DropAction_Normal(drops: table, bDoDrop: boolean, command: string, y: number, x: number)`

Internal function used in [DDragBase:DropAction_Copy](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Copy)

**Arguments:**
- `drops` (table)
- `bDoDrop` (boolean)
- `command` (string)
- `y` (number)
- `x` (number)

[wiki](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Normal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L72-L137)

---

### DDragBase:DropAction_Simple · Client, Menu · `INTERNAL`
`DDragBase:DropAction_Simple(drops: table, bDoDrop: boolean, command: string, y: number, x: number)`

Internal function used in [DDragBase:DropAction_Normal](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Normal)

**Arguments:**
- `drops` (table)
- `bDoDrop` (boolean)
- `command` (string)
- `y` (number)
- `x` (number)

[wiki](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Simple) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L53-L70)

---

### DDragBase:GetDnD · Client, Menu
`DDragBase:GetDnD() → string`

Returns the drag'n'drop group this panel belongs to. See [DDragBase:MakeDroppable](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable). An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- string — Name of the DnD family.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:GetDnD) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L4)

---

### DDragBase:GetReadOnly · Client, Menu
`DDragBase:GetReadOnly() → boolean`

Returns whether this panel is read only or not for drag'n'drop purposes. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- `name` (boolean) — Whether this panel is read only or not.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:GetReadOnly) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L6)

---

### DDragBase:GetUseLiveDrag · Client, Menu
`DDragBase:GetUseLiveDrag() → boolean`

Whether this panel uses live drag'n'drop previews. An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DDragBase:GetUseLiveDrag) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L5)

---

### DDragBase:MakeDroppable · Client, Menu
`DDragBase:MakeDroppable(name: string, allowCopy: boolean)`

Makes the panel a receiver for any droppable panel with the same DnD name. Internally calls [Panel:Receiver](https://wiki.facepunch.com/gmod/Panel:Receiver).

See [Drag and Drop for VGUI](https://wiki.facepunch.com/gmod/Drag%20and%20Drop%20for%20VGUI).

**Arguments:**
- `name` (string) — The unique name for the receiver slot.
- `allowCopy` (boolean) — Whether or not to allow droppable panels to be copied when the key is held down.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L34-L44)

---

### DDragBase:OnModified · Client, Menu · `hook`
`DDragBase:OnModified()`

Called when anything is dropped on or rearranged within the [DDragBase](https://wiki.facepunch.com/gmod/DDragBase). For Override

[wiki](https://wiki.facepunch.com/gmod/DDragBase:OnModified) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L139-L141)

---

### DDragBase:SetDnD · Client, Menu · `INTERNAL`
`DDragBase:SetDnD(name: string)`

Used internally by [DDragBase:MakeDroppable](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable). 

See also [DDragBase:GetDnD](https://wiki.facepunch.com/gmod/DDragBase:GetDnD) 

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `name` (string) — Name of the DnD family.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:SetDnD) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L4)

---

### DDragBase:SetDropPos · Client, Menu
`DDragBase:SetDropPos(pos: string = 5)`

Determines where you can drop stuff.
"4" for left
"5" for center
"6" for right
"8" for top
"2" for bottom

**Arguments:**
- `pos` (string, default `5`) — Where you're allowed to drop things.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:SetDropPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L24-L32)

---

### DDragBase:SetReadOnly · Client, Menu
`DDragBase:SetReadOnly(name: boolean)`

Sets whether this panel is read only or not for drag'n'drop purposes. If set to `true`, you can only copy from this panel, and cannot modify its contents. This is an [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `name` (boolean) — Whether this panel should be read only or not.

[wiki](https://wiki.facepunch.com/gmod/DDragBase:SetReadOnly) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L6)

---

### DDragBase:SetUseLiveDrag · Client, Menu
`DDragBase:SetUseLiveDrag(newState: boolean)`

Whether to use live drag'n'drop previews. This is an [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `newState` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DDragBase:SetUseLiveDrag) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L5)

---

### DDragBase:UpdateDropTarget · Client, Menu · `INTERNAL`
`DDragBase:UpdateDropTarget(drop: number, pnl: Panel)`

Internal function used in [DDragBase:DropAction_Normal](https://wiki.facepunch.com/gmod/DDragBase:DropAction_Normal)

**Arguments:**
- `drop` (number)
- `pnl` (Panel)

[wiki](https://wiki.facepunch.com/gmod/DDragBase:UpdateDropTarget) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/ddragbase.lua#L143-L168)
