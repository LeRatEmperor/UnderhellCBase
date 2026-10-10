# DTileLayout

**Realm:** Client  ·  **Members:** 21  ·  **Inherits:** `DDragBase`

Similarly to [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout), this lays out panels in two dimensions as tiles.

		The difference between this and [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout) is that [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout) items all have the same height while
		[DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout) items do not have this enforcement. 
		[DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout) will find the best way to "pack" its children.  
		For example, in a two column layout, a item of height 2 units will be placed in one column while 
		two items of height 1 unit will be placed in the other column. 

		It is worth noting however that because this panel iterates through its children in an undefined order and lays out while
		it is iterating, there is no guarantee that this packing will lead to the lowest possible height.

		This is used by the spawnmenu to arrange spawnicons.

		The base size defines the smallest a tile can be, and it will resize vertically to accommodate all child panels.
		The number of elements in each row is determined by the base size and width.

		It also optionally permits the rearrangement of these tiles.
		To enable this functionality, call [DDragBase:MakeDroppable](https://wiki.facepunch.com/gmod/DDragBase:MakeDroppable) on the DTileLayout with a unique identifier.
		All panels added following this will be moveable.

[wiki page](https://wiki.facepunch.com/gmod/DTileLayout)

### DTileLayout:ClearTiles · Client · `INTERNAL`
`DTileLayout:ClearTiles()`

Clears the panel's tile table. Used by [DTileLayout:LayoutTiles](https://wiki.facepunch.com/gmod/DTileLayout:LayoutTiles).

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:ClearTiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L84-L88)

---

### DTileLayout:ConsumeTiles · Client · `INTERNAL`
`DTileLayout:ConsumeTiles(x: number, y: number, w: number, h: number)`

Called to designate a range of tiles as occupied by a panel.

**Arguments:**
- `x` (number) — The x coordinate of the top-left corner of the panel.
- `y` (number) — The y coordinate of the top-left corner of the panel.
- `w` (number) — The panel's width.
- `h` (number) — The panel's height.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:ConsumeTiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L110-L118)

---

### DTileLayout:Copy · Client
`DTileLayout:Copy() → Panel`

Creates and returns an exact copy of the DTileLayout.

**Returns:**
- Panel — The created copy.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L212-L228)

---

### DTileLayout:CopyContents · Client
`DTileLayout:CopyContents(source: Panel)`

Creates copies of all the children from the given panel object and parents them to this one.

**Arguments:**
- `source` (Panel) — The source panel from which to copy all children.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:CopyContents) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L230-L238)

---

### DTileLayout:FindFreeTile · Client · `INTERNAL`
`DTileLayout:FindFreeTile(x: number, y: number, w: number, h: number) → number, number`

Finds the coordinates of the first group of free tiles that fit the given size.

**Arguments:**
- `x` (number) — The x coordinate to start looking from.
- `y` (number) — The y coordinate to start looking from.
- `w` (number) — The needed width.
- `h` (number) — The needed height.

**Returns:**
- number — The x coordinate of the found available space.
- number — The y coordinate of the found available space.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:FindFreeTile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L51-L82)

---

### DTileLayout:FitsInTile · Client · `INTERNAL`
`DTileLayout:FitsInTile(x: number, y: number, w: number, h: number) → boolean`

Determines if a group of tiles is vacant.

**Arguments:**
- `x` (number) — The x coordinate of the first tile.
- `y` (number) — The y coordinate of the first tile.
- `w` (number) — The width needed.
- `h` (number) — The height needed.

**Returns:**
- boolean — Whether or not this group is available for occupation.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:FitsInTile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L35-L49)

---

### DTileLayout:GetBaseSize · Client
`DTileLayout:GetBaseSize() → number`

Returns the size of each single tile, set with [DTileLayout:SetBaseSize](https://wiki.facepunch.com/gmod/DTileLayout:SetBaseSize).

**Returns:**
- number — Base tile size.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetBaseSize)

---

### DTileLayout:GetBorder · Client
`DTileLayout:GetBorder() → number`

Returns the border spacing set by [DTileLayout:SetBorder](https://wiki.facepunch.com/gmod/DTileLayout:SetBorder).

**Returns:**
- number — The border spacing

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetBorder)

---

### DTileLayout:GetMinHeight · Client
`DTileLayout:GetMinHeight() → number`

Returns the minimum height the DTileLayout can resize to.

**Returns:**
- number — The minimum height the panel can shrink to.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetMinHeight)

---

### DTileLayout:GetSpaceX · Client
`DTileLayout:GetSpaceX() → number`

Returns the X axis spacing between 2 elements set by [DTileLayout:SetSpaceX](https://wiki.facepunch.com/gmod/DTileLayout:SetSpaceX).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetSpaceX)

---

### DTileLayout:GetSpaceY · Client
`DTileLayout:GetSpaceY() → number`

Returns the Y axis spacing between 2 elements set by [DTileLayout:SetSpaceY](https://wiki.facepunch.com/gmod/DTileLayout:SetSpaceY).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetSpaceY)

---

### DTileLayout:GetTile · Client · `INTERNAL`
`DTileLayout:GetTile(x: number, y: number) → any`

Gets the occupied state of a tile.

**Arguments:**
- `x` (number) — The x coordinate of the tile.
- `y` (number) — The y coordinate of the tile.

**Returns:**
- any — The occupied state of the tile, normally `1` or `nil`.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:GetTile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L90-L98)

---

### DTileLayout:Layout · Client
`DTileLayout:Layout()`

Resets the last width/height info, and invalidates the panel's layout, causing it to recalculate all child positions. It is called whenever a child is added or removed, and can be called to refresh the panel.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:Layout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L27-L33)

---

### DTileLayout:LayoutTiles · Client · `INTERNAL`
`DTileLayout:LayoutTiles()`

Called by [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) to arrange and lay out the child panels, if it has changed in size.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:LayoutTiles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L120-L154)

---

### DTileLayout:OnModified · Client · `hook`
`DTileLayout:OnModified()`

Called when anything is dropped on or rearranged within the DTileLayout.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:OnModified)

---

### DTileLayout:SetBaseSize · Client
`DTileLayout:SetBaseSize(size: number)`

Sets the size of a single tile. If a child panel is larger than this size, it will occupy several tiles.

If you are setting the size of the children properly then you probably don't need to change this.

**Arguments:**
- `size` (number) — The size of each tile.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetBaseSize)

---

### DTileLayout:SetBorder · Client
`DTileLayout:SetBorder(border: number)`

Sets the spacing between the border/edge of the [DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout) and all the elements inside.

**Arguments:**
- `border` (number)

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetBorder)

---

### DTileLayout:SetMinHeight · Client
`DTileLayout:SetMinHeight(minH: number)`

Determines the minimum height the DTileLayout will resize to. This is useful if child panels will be added/removed often.

**Arguments:**
- `minH` (number) — The minimum height the panel can shrink to.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetMinHeight)

---

### DTileLayout:SetSpaceX · Client
`DTileLayout:SetSpaceX(spacingX: number)`

Sets the spacing between 2 elements in the [DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout) on the X axis.

**Arguments:**
- `spacingX` (number) — New X axis spacing.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetSpaceX)

---

### DTileLayout:SetSpaceY · Client
`DTileLayout:SetSpaceY(spaceY: number)`

Sets the spacing between 2 elements in the [DTileLayout](https://wiki.facepunch.com/gmod/DTileLayout) on the Y axis.

**Arguments:**
- `spaceY` (number) — New Y axis spacing.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetSpaceY)

---

### DTileLayout:SetTile · Client · `INTERNAL`
`DTileLayout:SetTile(x: number, y: number, state: any)`

Called to set the occupied state of a tile.

**Arguments:**
- `x` (number) — The x coordinate of the tile.
- `y` (number) — The y coordinate of the tile.
- `state` (any) — The new state of the tile, normally `1` or `nil`.

[wiki](https://wiki.facepunch.com/gmod/DTileLayout:SetTile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtilelayout.lua#L100-L108)
