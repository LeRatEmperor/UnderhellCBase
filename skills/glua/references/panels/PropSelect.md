# PropSelect

**Realm:** Client  ·  **Members:** 8  ·  **Inherits:** `ContextBase`

Used in Sandbox tools to allow the player to select models out of a list. Despite being only used in Sandbox, it is **not** exclusive to that gamemode.

See also [MatSelect](https://wiki.facepunch.com/gmod/MatSelect) for the material selecting alternative.

[wiki page](https://wiki.facepunch.com/gmod/PropSelect)

### PropSelect:AddModel · Client
`PropSelect:AddModel(model: string, convars: table)`

Adds a new model to the selection list.

**Arguments:**
- `model` (string) — Model path, including `models/` and `.mdl`.
- `convars` (table) — A list of convar names (as keys) and their values to set when the user selects this model.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:AddModel)

---

### PropSelect:AddModelEx · Client
`PropSelect:AddModelEx(value: string, model: string, skin: number)`

Adds a new model to the selection list.

**Arguments:**
- `value` (string) — The "value" for this model, which is used to set the ContextBase:SetConVar.
- `model` (string) — Model path, including `models/` and `.mdl`.
- `skin` (number) — The skin number for this model.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:AddModelEx)

---

### PropSelect:FindAndSelectButton · Client
`PropSelect:FindAndSelectButton(mdl: string)`

Find and select a [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) panel based on the input model path.

**Arguments:**
- `mdl` (string) — The model to find and select within this PropSelect.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:FindAndSelectButton)

---

### PropSelect:FindModelByValue · Client
`PropSelect:FindModelByValue(mdl: string) → SpawnIcon`

Find a [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) panel based on the input model path.

**Arguments:**
- `mdl` (string) — The model to find within this PropSelect.

**Returns:**
- SpawnIcon — The found spawnicon, or `nil`.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:FindModelByValue)

---

### PropSelect:Height · Client
`PropSelect:Height()`

[wiki](https://wiki.facepunch.com/gmod/PropSelect.Height)

---

### PropSelect:OnRightClick · Client · `hook`
`PropSelect:OnRightClick(pnl: Panel)`

Called when the player right clicks a model.

By default, this opens a menu that lets the player copy the model path.

**Arguments:**
- `pnl` (Panel) — The Spawnicon that was clicked.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:OnRightClick)

---

### PropSelect:OnSelect · Client · `hook`
`PropSelect:OnSelect(pnl: Panel, model: String)`

Called when the player selects a model.

**Arguments:**
- `pnl` (Panel) — The Spawnicon that was clicked.
- `model` (String) — Path of the selected model, or its "value".

[wiki](https://wiki.facepunch.com/gmod/PropSelect:OnSelect)

---

### PropSelect:SelectModel · Client · `hook` · `INTERNAL`
`PropSelect:SelectModel(icon: SpawnIcon)`

Selects a given spawnicon panel.

**Arguments:**
- `icon` (SpawnIcon) — The spawnicon to select, retrieved via PropSelect:FindModelByValue.

[wiki](https://wiki.facepunch.com/gmod/PropSelect:SelectModel)
