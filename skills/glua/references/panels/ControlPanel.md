# ControlPanel

**Realm:** Client  ·  **Members:** 10  ·  **Inherits:** `DForm`

Used by the context menu in sandbox.

[wiki page](https://wiki.facepunch.com/gmod/ControlPanel)

### ControlPanel:AddControl · Client · `DEPRECATED`
`ControlPanel:AddControl(type: string, controlinfo: table) → Panel`

Adds a control to the control panel.

**Arguments:**
- `type` (string) — The control type to add.
- `controlinfo` (table) — Each control takes their own table structure.

**Returns:**
- Panel — Returns created control

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:AddControl) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L148-L431)

---

### ControlPanel:AddPanel · Client
`ControlPanel:AddPanel(panel: Panel)`

Adds an item by calling [DForm:AddItem](https://wiki.facepunch.com/gmod/DForm:AddItem).

**Arguments:**
- `panel` (Panel) — Panel to add as an item to the control panel.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:AddPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L29-L34)

---

### ControlPanel:ClearControls · Client · `DEPRECATED`
`ControlPanel:ClearControls()`

Alias of [Panel:Clear](https://wiki.facepunch.com/gmod/Panel:Clear).

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:ClearControls) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L19-L21)

---

### ControlPanel:ColorPicker · Client
`ControlPanel:ColorPicker(label: string, convarR: string, convarG: string, convarB: string, convarA: string = nil) → Panel`

Creates a [CtrlColor](https://wiki.facepunch.com/gmod/CtrlColor) (a color picker) panel and adds it as an [item](https://wiki.facepunch.com/gmod/ControlPanel:AddPanel).

**Arguments:**
- `label` (string) — The label for this color picker.
- `convarR` (string) — Name of the convar that will store the R component of the selected color.
- `convarG` (string) — Name of the convar that will store the G component of the selected color.
- `convarB` (string) — Name of the convar that will store the B component of the selected color.
- `convarA` (string, default `nil`) — Name of the convar that will store the A component of the selected color.

**Returns:**
- Panel — The created CtrlColor panel.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:ColorPicker) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L94-L113)

---

### ControlPanel:ControlValues · Client
`ControlPanel:ControlValues(data: table)`

Sets control values of the control panel.

**Arguments:**
- `data` (table) — A two-membered table: * boolean closed - Sets if the control panel should be unexpanded.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:ControlValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L138-L145)

---

### ControlPanel:FillViaFunction · Client · `DEPRECATED`
`ControlPanel:FillViaFunction(func: function)`

Calls the given function with this panel as the only argument. Used by the spawnmenu to populate the control panel.

**Arguments:**
- `func` (function) — The builder function.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:FillViaFunction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L132-L136)

---

### ControlPanel:GetEmbeddedPanel · Client
`ControlPanel:GetEmbeddedPanel() → ControlPanel`

Returns this control panel.

**Returns:**
- ControlPanel — The same control panel the function is being called on.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:GetEmbeddedPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L23-L27)

---

### ControlPanel:KeyBinder · Client
`ControlPanel:KeyBinder(label1: string, convar1: string, label2: string = nil, convar2: string = nil) → Panel`

Creates a CtrlNumPad (a Sandbox key binder) panel and adds it as an [item](https://wiki.facepunch.com/gmod/ControlPanel:AddPanel).

**Arguments:**
- `label1` (string) — The label for the left key binder.
- `convar1` (string) — The name of the convar that will store the key code for player selected key of the left key binder.
- `label2` (string, default `nil`) — If set and `convar2` is set, the label for the right key binder.
- `convar2` (string, default `nil`) — If set and `label2` is set, the name of the convar that will store the key code for player selected key of the right key binder.

**Returns:**
- Panel — The created CtrlNumPad panel.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:KeyBinder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L117-L133)

---

### ControlPanel:MatSelect · Client
`ControlPanel:MatSelect(convar: string, options: table = nil, autostretch: boolean = nil, width: number = nil, height: number = nil) → MatSelect`

Creates a [MatSelect](https://wiki.facepunch.com/gmod/MatSelect) panel and adds it as an [item](https://wiki.facepunch.com/gmod/ControlPanel:AddPanel).

**Arguments:**
- `convar` (string) — Calls MatSelect:SetConVar with this value.
- `options` (table, default `nil`) — If specified, calls MatSelect:AddMaterial(key, value) for each table entry.
- `autostretch` (boolean, default `nil`) — If specified, calls MatSelect:SetAutoHeight with this value.
- `width` (number, default `nil`) — If specified, calls MatSelect:SetItemWidth with this value.
- `height` (number, default `nil`) — If specified, calls MatSelect:SetItemHeight with this value.

**Returns:**
- MatSelect — The created MatSelect panel.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:MatSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L36-L57)

---

### ControlPanel:ToolPresets · Client
`ControlPanel:ToolPresets(group: string, cvarList: table) → Panel`

Creates a [ControlPresets](https://wiki.facepunch.com/gmod/ControlPresets) panel and adds it as an [item](https://wiki.facepunch.com/gmod/ControlPanel:AddPanel).

**Arguments:**
- `group` (string) — The preset group.
- `cvarList` (table) — A table of convar names as keys and their defaults as the values.

**Returns:**
- Panel — The created ControlPresets panel.

[wiki](https://wiki.facepunch.com/gmod/ControlPanel:ToolPresets) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controlpanel.lua#L59-L74)
