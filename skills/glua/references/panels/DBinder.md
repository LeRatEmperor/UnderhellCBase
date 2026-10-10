# DBinder

**Realm:** Client  ·  **Members:** 6  ·  **Inherits:** `DButton`

Input which can bind a command to a key. Used for binding inputs and outputs of TOOLs.

[wiki page](https://wiki.facepunch.com/gmod/DBinder)

### DBinder:GetSelectedNumber · Client
`DBinder:GetSelectedNumber() → number`

Gets the code of the key currently bound by the DBinder. Same as [DBinder:GetValue](https://wiki.facepunch.com/gmod/DBinder:GetValue). An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- number — The key code of the bound key.

[wiki](https://wiki.facepunch.com/gmod/DBinder:GetSelectedNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L4)

---

### DBinder:GetValue · Client
`DBinder:GetValue() → number`

Gets the code of the key currently bound by the DBinder. Same as [DBinder:GetSelectedNumber](https://wiki.facepunch.com/gmod/DBinder:GetSelectedNumber).

**Returns:**
- number — The key code of the bound key.

[wiki](https://wiki.facepunch.com/gmod/DBinder:GetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L83-L87)

---

### DBinder:OnChange · Client · `hook`
`DBinder:OnChange(iNum: number)`

Called when the player selects a new bind. Meant to be Overridden

**Arguments:**
- `iNum` (number) — The new bound key.

[wiki](https://wiki.facepunch.com/gmod/DBinder:OnChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L89-L90)

---

### DBinder:SetSelectedNumber · Client
`DBinder:SetSelectedNumber(keyCode: number)`

Sets the current key bound by the [DBinder](https://wiki.facepunch.com/gmod/DBinder), and updates the button's text as well as the [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key code of the key to bind.

[wiki](https://wiki.facepunch.com/gmod/DBinder:SetSelectedNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L41-L48)

---

### DBinder:SetValue · Client
`DBinder:SetValue(keyCode: number)`

Alias of [DBinder:SetSelectedNumber](https://wiki.facepunch.com/gmod/DBinder:SetSelectedNumber).

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key code of the key to bind.

[wiki](https://wiki.facepunch.com/gmod/DBinder:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L77-L81)

---

### DBinder:UpdateText · Client · `INTERNAL`
`DBinder:UpdateText()`

Used to set the text of the DBinder to the current key binding, or `NONE`.

[wiki](https://wiki.facepunch.com/gmod/DBinder:UpdateText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbinder.lua#L15-L24)
