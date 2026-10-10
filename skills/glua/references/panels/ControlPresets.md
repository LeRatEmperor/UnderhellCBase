# ControlPresets

**Realm:** Client  ·  **Members:** 13  ·  **Inherits:** `Panel`

A preset manager, found at the top of almost every default tool's C-menu.

		This control only exists in Sandbox derived gamemodes.

[wiki page](https://wiki.facepunch.com/gmod/ControlPresets)

### ControlPresets:AddConVar · Client
`ControlPresets:AddConVar(convar: string)`

Adds a convar to be managed by this control.

**Arguments:**
- `convar` (string) — The convar to add.

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:AddConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L110-L114)

---

### ControlPresets:AddOption · Client
`ControlPresets:AddOption(strName: string, data: any)`

Adds option to the [DComboBox](https://wiki.facepunch.com/gmod/DComboBox) subelement with [DComboBox:AddChoice](https://wiki.facepunch.com/gmod/DComboBox:AddChoice) then adds it to the `options` subtable

**Arguments:**
- `strName` (string) — Name
- `data` (any) — data

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:AddOption) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L48-L54)

---

### ControlPresets:Clear · Client
`ControlPresets:Clear()`

Runs [Panel:Clear](https://wiki.facepunch.com/gmod/Panel:Clear) on the Internal [DComboBox](https://wiki.facepunch.com/gmod/DComboBox)

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L48-L54)

---

### ControlPresets:GetConVars · Client
`ControlPresets:GetConVars() → table`

Get a list of all Console Variables being managed by this panel.

**Returns:**
- table — numbered table of convars

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:GetConVars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L116-L120)

---

### ControlPresets:OnSelect · Client
`ControlPresets:OnSelect(index: number, value: any, data: table)`

Checks if Data is valid then uses [pairs](https://wiki.facepunch.com/gmod/Global.pairs) to iterate over the data parameter and run each entry using [RunConsoleCommand](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand)

**Arguments:**
- `index` (number) — Name
- `value` (any)
- `data` (table)

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:OnSelect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L62-L70)

---

### ControlPresets:OpenPresetEditor · Client
`ControlPresets:OpenPresetEditor()`

Creates and opens [PresetEditor](https://wiki.facepunch.com/gmod/PresetEditor)

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:OpenPresetEditor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L97-L108)

---

### ControlPresets:QuickSaveInternal · Client
`ControlPresets:QuickSaveInternal(text: string)`

**Arguments:**
- `text` (string)

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:QuickSaveInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L72-L80)

---

### ControlPresets:QuickSavePreset · Client
`ControlPresets:QuickSavePreset()`

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:QuickSavePreset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L82-L95)

---

### ControlPresets:ReloadPresets · Client
`ControlPresets:ReloadPresets()`

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:ReloadPresets) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L129-L149)

---

### ControlPresets:SetLabel · Client
`ControlPresets:SetLabel(name: string)`

Set the name label text.

**Arguments:**
- `name` (string) — The text to put in the label

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:SetLabel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L42-L46)

---

### ControlPresets:SetOptions · Client
`ControlPresets:SetOptions(Options: table)`

Uses [table.Merge](https://wiki.facepunch.com/gmod/table.Merge) to combine the provided table into the `Options` subtable

**Arguments:**
- `Options` (table) — Options

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:SetOptions) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L56-L60)

---

### ControlPresets:SetPreset · Client
`ControlPresets:SetPreset(strName: string)`

**Arguments:**
- `strName` (string) — Name of preset to set

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:SetPreset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L122-L127)

---

### ControlPresets:Update · Client
`ControlPresets:Update()`

Alias of [ControlPresets:ReloadPresets](https://wiki.facepunch.com/gmod/ControlPresets:ReloadPresets)

[wiki](https://wiki.facepunch.com/gmod/ControlPresets:Update) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/control_presets.lua#L48-L54)
