# DModelSelectMulti

**Realm:** Client, Menu  ·  **Members:** 1  ·  **Inherits:** `DPropertySheet`  ·  `DEPRECATED`

A combination of [DModelSelect](https://wiki.facepunch.com/gmod/DModelSelect) and [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet).

[wiki page](https://wiki.facepunch.com/gmod/DModelSelectMulti)

### DModelSelectMulti:AddModelList · Client, Menu · `DEPRECATED`
`DModelSelectMulti:AddModelList(name: string, models: table, convar: string, dontSort: boolean, dontCallListConVars: boolean)`

Adds a new tab of models.

**Arguments:**
- `name` (string) — Name of the tab to add.
- `models` (table) — Models list for this tab.
- `convar` (string) — ConVar to set when a model from this list is selected.
- `dontSort` (boolean) — Do not sort the list.
- `dontCallListConVars` (boolean) — If set, only the `convar` from the 2nd argument will be set, not individual convars from the models list.

[wiki](https://wiki.facepunch.com/gmod/DModelSelectMulti:AddModelList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelselectmulti.lua#L17-L29)
