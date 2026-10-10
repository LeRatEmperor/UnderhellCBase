# SpawnIcon

**Realm:** Client  ·  **Members:** 7  ·  **Inherits:** `DButton`

A "spawn icon" displays an image for the given model path.
		It is mostly used in the Spawn Menu ().
		It uses [ModelImage](https://wiki.facepunch.com/gmod/ModelImage) internally.

[wiki page](https://wiki.facepunch.com/gmod/SpawnIcon)

### SpawnIcon:GetBodyGroup · Client
`SpawnIcon:GetBodyGroup() → string`

Returns the currently active [Sub Model IDs](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#submodels) for each Body Group of the spawn icon.  
		
		This is set by [SpawnIcon:SetBodyGroup](https://wiki.facepunch.com/gmod/SpawnIcon:SetBodyGroup).

**Returns:**
- string — The Body Groups of the spawnicon

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:GetBodyGroup)

---

### SpawnIcon:GetModelName · Client
`SpawnIcon:GetModelName() → string`

Returns the currently set model name. This is set by [SpawnIcon:SetModelName](https://wiki.facepunch.com/gmod/SpawnIcon:SetModelName).

**Returns:**
- string — The model name

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:GetModelName)

---

### SpawnIcon:GetSkinID · Client
`SpawnIcon:GetSkinID() → number`

Returns the currently set skin of the spawnicon. This is set by [SpawnIcon:SetSkinID](https://wiki.facepunch.com/gmod/SpawnIcon:SetSkinID).

**Returns:**
- number — Current skin ID

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:GetSkinID)

---

### SpawnIcon:OpenMenu · Client
`SpawnIcon:OpenMenu()`

Called when right clicked on the SpawnIcon. It will not be called if there is a selection ([Panel:GetSelectionCanvas](https://wiki.facepunch.com/gmod/Panel:GetSelectionCanvas)), in which case [SANDBOX:SpawnlistOpenGenericMenu](https://wiki.facepunch.com/gmod/SANDBOX:SpawnlistOpenGenericMenu) is called.

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:OpenMenu)

---

### SpawnIcon:SetBodyGroup · Client · `INTERNAL`
`SpawnIcon:SetBodyGroup(bodyGroupId: number, activeSubModelId: number)`

Sets the active [Sub Model ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#submodels) for the given [Body Group 		ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id), so it can be retrieved with [SpawnIcon:GetBodyGroup](https://wiki.facepunch.com/gmod/SpawnIcon:GetBodyGroup).  

		Use [Panel:SetModel](https://wiki.facepunch.com/gmod/Panel:SetModel) instead.

**Arguments:**
- `bodyGroupId` (number) — The Body Group ID to set the active Sub Model ID for.
- `activeSubModelId` (number) — The Sub Model ID to set as active.

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:SetBodyGroup)

---

### SpawnIcon:SetModelName · Client · `INTERNAL`
`SpawnIcon:SetModelName(mdl: string)`

Sets the model name, so it can be retrieved with [SpawnIcon:GetModelName](https://wiki.facepunch.com/gmod/SpawnIcon:GetModelName). Use [Panel:SetModel](https://wiki.facepunch.com/gmod/Panel:SetModel) instead.

**Arguments:**
- `mdl` (string) — The model name to set

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:SetModelName)

---

### SpawnIcon:SetSkinID · Client · `INTERNAL`
`SpawnIcon:SetSkinID(skin: number)`

Sets the skin id of the spawn icon, so it can be retrieved with [SpawnIcon:GetSkinID](https://wiki.facepunch.com/gmod/SpawnIcon:GetSkinID). Use [Panel:SetModel](https://wiki.facepunch.com/gmod/Panel:SetModel) instead.

**Arguments:**
- `skin` (number) — Skin ID to set

[wiki](https://wiki.facepunch.com/gmod/SpawnIcon:SetSkinID)
