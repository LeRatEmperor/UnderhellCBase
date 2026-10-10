# DModelSelect

**Realm:** Client  ·  **Members:** 2  ·  **Inherits:** `DPanelSelect`  ·  `DEPRECATED`

A vertical list of models.

[wiki page](https://wiki.facepunch.com/gmod/DModelSelect)

### DModelSelect:SetHeight · Client · `DEPRECATED`
`DModelSelect:SetHeight(num: number = 2)`

Sets the height of the panel **in the amount of 64px spawnicons**.

Overrides [Panel:SetHeight](https://wiki.facepunch.com/gmod/Panel:SetHeight).

**Arguments:**
- `num` (number, default `2`) — Basically how many rows of 64x64 px spawnicons should fit in this DModelSelect

[wiki](https://wiki.facepunch.com/gmod/DModelSelect:SetHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelselect.lua#L11-L15)

---

### DModelSelect:SetModelList · Client · `DEPRECATED`
`DModelSelect:SetModelList(models: table, convar: string, dontSort: boolean, dontCallListConVars: boolean)`

Called to set the list of models within the panel element.

**Arguments:**
- `models` (table) — Each key is a model path, the value is a kay-value table where they key is a convar name and value is the value to set to that convar.
- `convar` (string) — ConVar to set when a model from this list is selected.
- `dontSort` (boolean) — Do not sort the list.
- `dontCallListConVars` (boolean) — If set, only the `convar` from the 2nd argument will be set, not individual convars from the models list.

[wiki](https://wiki.facepunch.com/gmod/DModelSelect:SetModelList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelselect.lua#L17-L49)
