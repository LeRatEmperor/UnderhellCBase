# DNotify

**Realm:** Client  ·  **Members:** 9  ·  **Inherits:** `Panel`

A panel that fades its contents in and out once, like a notification.

[wiki page](https://wiki.facepunch.com/gmod/DNotify)

### DNotify:AddItem · Client
`DNotify:AddItem(pnl: Panel, lifeLength: number = nil)`

Adds a panel to the notification

**Arguments:**
- `pnl` (Panel) — The panel to add
- `lifeLength` (number, default `nil`) — If set, overrides DNotify:SetLife for when the given panel should be removed.

[wiki](https://wiki.facepunch.com/gmod/DNotify:AddItem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnotify.lua#L28-L43)

---

### DNotify:GetAlignment · Client
`DNotify:GetAlignment() → number`

Returns the current alignment of this notification panel. Set by [DNotify:SetAlignment](https://wiki.facepunch.com/gmod/DNotify:SetAlignment).

**Returns:**
- number — The numpad alignment

[wiki](https://wiki.facepunch.com/gmod/DNotify:GetAlignment)

---

### DNotify:GetItems · Client
`DNotify:GetItems() → table`

Returns all the items added with [DNotify:AddItem](https://wiki.facepunch.com/gmod/DNotify:AddItem).

**Returns:**
- table — A table of Panels.

[wiki](https://wiki.facepunch.com/gmod/DNotify:GetItems) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnotify.lua#L22-L26)

---

### DNotify:GetLife · Client
`DNotify:GetLife() → number`

Returns the display time in seconds of the DNotify. This is set with 
[DNotify:SetLife](https://wiki.facepunch.com/gmod/DNotify:SetLife).

**Returns:**
- number — The display time in seconds.

[wiki](https://wiki.facepunch.com/gmod/DNotify:GetLife)

---

### DNotify:GetSpacing · Client
`DNotify:GetSpacing() → number`

Returns the spacing between items set by [DNotify:SetSpacing](https://wiki.facepunch.com/gmod/DNotify:SetSpacing).

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/DNotify:GetSpacing)

---

### DNotify:SetAlignment · Client
`DNotify:SetAlignment(alignment: number)`

Sets the alignment of the child panels in the notification

**Arguments:**
- `alignment` (number) — It's the Numpad alignment, 6 is right, 9 is top left, etc.

[wiki](https://wiki.facepunch.com/gmod/DNotify:SetAlignment)

---

### DNotify:SetLife · Client
`DNotify:SetLife(time: number)`

Sets the display time in seconds for the DNotify.

**Arguments:**
- `time` (number) — The time in seconds.

[wiki](https://wiki.facepunch.com/gmod/DNotify:SetLife)

---

### DNotify:SetSpacing · Client
`DNotify:SetSpacing(spacing: number)`

Sets the spacing between child elements of the notification panel.

**Arguments:**
- `spacing` (number)

[wiki](https://wiki.facepunch.com/gmod/DNotify:SetSpacing)

---

### DNotify:Shuffle · Client · `INTERNAL`
`DNotify:Shuffle()`

Used internally to position and fade in/out its [DNotify:GetItems](https://wiki.facepunch.com/gmod/DNotify:GetItems).

[wiki](https://wiki.facepunch.com/gmod/DNotify:Shuffle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dnotify.lua#L65-L117)
