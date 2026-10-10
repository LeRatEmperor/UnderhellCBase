# ContentIcon

**Realm:** Client  ·  **Members:** 12  ·  **Inherits:** `DButton`

The spawn icon used for SWEPs and other SENTs, commonly featured as part of the spawn menu. 
		Do note that at least one of your ContentIcon's parents must either be an [EditablePanel](https://wiki.facepunch.com/gmod/EditablePanel) or derived from it 
		(like a [DFrame](https://wiki.facepunch.com/gmod/DFrame), for example), else it won't be able to focus and thus be unclickable.

		This control only exists in Sandbox derived gamemodes.

[wiki page](https://wiki.facepunch.com/gmod/ContentIcon)

### ContentIcon:GetColor · Client
`ContentIcon:GetColor() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the color set by [ContentIcon:SetColor](https://wiki.facepunch.com/gmod/ContentIcon:SetColor)

**Returns:**
- Color — See Color

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L13)

---

### ContentIcon:GetContentType · Client
`ContentIcon:GetContentType() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the content type used to save and restore the content icon in a spawnlist.

**Returns:**
- string — The content type, for example "entity" or "weapon".

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:GetContentType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L14)

---

### ContentIcon:GetNPCWeapon · Client
`ContentIcon:GetNPCWeapon() → table`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.

**Returns:**
- table — A table of weapon classes to be chosen from when user tries to spawn the NPC.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:GetNPCWeapon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L16)

---

### ContentIcon:GetSpawnName · Client
`ContentIcon:GetSpawnName() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the internal "name" for the content icon, usually a class name for an entity.

**Returns:**
- string — Internal "name" to be used when user left clicks the icon.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:GetSpawnName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L15)

---

### ContentIcon:OpenMenu · Client
`ContentIcon:OpenMenu()`

A hook for override, by default does nothing. Called when user right clicks on the content icon, you are supposed to open a [DermaMenu](https://wiki.facepunch.com/gmod/Global.DermaMenu) here with additional options.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:OpenMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L104-L105)

---

### ContentIcon:SetAdminOnly · Client
`ContentIcon:SetAdminOnly(adminOnly: boolean)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets whether the content item is admin only. This makes the icon to display a admin icon in the top left corner of the icon.

**Arguments:**
- `adminOnly` (boolean) — Whether this content should be admin only or not

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetAdminOnly) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L17)

---

### ContentIcon:SetColor · Client
`ContentIcon:SetColor(clr: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the color for the content icon. Currently is not used by the content icon panel.

**Arguments:**
- `clr` (Color) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L13)

---

### ContentIcon:SetContentType · Client
`ContentIcon:SetContentType(type: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the content type used to save and restore the content icon in a spawnlist.

**Arguments:**
- `type` (string) — The content type, for example "entity" or "weapon"

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetContentType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L14)

---

### ContentIcon:SetMaterial · Client
`ContentIcon:SetMaterial(path: string)`

Sets the material to be displayed as the content icon.

**Arguments:**
- `path` (string) — Path to the icon to use.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L66-L88)

---

### ContentIcon:SetName · Client
`ContentIcon:SetName(name: string)`

Sets the tool tip and the "nice" name to be displayed by the content icon.

**Arguments:**
- `name` (string) — "Nice" name to display.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L58-L64)

---

### ContentIcon:SetNPCWeapon · Client
`ContentIcon:SetNPCWeapon(weapons: table)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets a table of weapon classes for the content icon with "NPC" content type to be randomly chosen from when user tries to spawn the NPC.

**Arguments:**
- `weapons` (table) — A table of weapon classes to be chosen from when user tries to spawn the NPC.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetNPCWeapon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L16)

---

### ContentIcon:SetSpawnName · Client
`ContentIcon:SetSpawnName(name: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the internal "name" for the content icon, usually a class name for an entity.

**Arguments:**
- `name` (string) — Internal "name" to be used when user left clicks the icon.

[wiki](https://wiki.facepunch.com/gmod/ContentIcon:SetSpawnName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L15)
