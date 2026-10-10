# PLAYER

**Realm:** Shared  ·  **Members:** 14

Represents a player class.

The player class hooks have one special field:
* [Player](https://wiki.facepunch.com/gmod/Player) **Player** - The player for which a hook is called.

> **Note:** These hooks are used in [player_manager](https://wiki.facepunch.com/gmod/player_manager) this can't be [hooked](https://wiki.facepunch.com/gmod/hook.Add)

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `PLAYER` table: `function PLAYER:<Name>(...) end`. The `PLAYER:` prefix shown on each member below is the method form you write.

### PLAYER:ClassChanged · Shared · `hook`
`PLAYER:ClassChanged()`

Called when the player's class was changed from this class.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:ClassChanged)

---

### PLAYER:Death · Server · `hook`
`PLAYER:Death()`

Called when the player dies

[wiki](https://wiki.facepunch.com/gmod/PLAYER:Death) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L74-L75)

---

### PLAYER:FinishMove · Shared · `hook`
`PLAYER:FinishMove(mv: CMoveData) → boolean`

Called from [GM:FinishMove](https://wiki.facepunch.com/gmod/GM:FinishMove).

**Arguments:**
- `mv` (CMoveData)

**Returns:**
- boolean — Return true to prevent default action

> **Note:** This hook is run after the [drive.FinishMove](https://wiki.facepunch.com/gmod/drive.FinishMove) has been called.
> **Warning:** This hook will not work if the current gamemode overrides [GM:FinishMove](https://wiki.facepunch.com/gmod/GM:FinishMove) and does not call this hook.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:FinishMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_class/player_sandbox.lua#L161-L197)

---

### PLAYER:GetHandsModel · Server · `hook`
`PLAYER:GetHandsModel() → table`

Called on player spawn to determine which hand model to use

**Returns:**
- table — A table containing info about view model hands model to be set.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:GetHandsModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L126-L133)

---

### PLAYER:Init · Shared · `hook`
`PLAYER:Init()`

Called when the class object is created

[wiki](https://wiki.facepunch.com/gmod/PLAYER:Init) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L37-L43)

---

### PLAYER:Loadout · Server · `hook`
`PLAYER:Loadout()`

Called on spawn to give the player their default loadout

[wiki](https://wiki.facepunch.com/gmod/PLAYER:Loadout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L60-L65)

---

### PLAYER:Move · Shared · `hook`
`PLAYER:Move(mv: CMoveData) → boolean`

Called from [GM:Move](https://wiki.facepunch.com/gmod/GM:Move).

**Arguments:**
- `mv` (CMoveData) — Movement information

**Returns:**
- boolean — Return true to prevent default action

> **Note:** This hook is run after the [drive.Move](https://wiki.facepunch.com/gmod/drive.Move) has been called.
> **Warning:** This hook will not work if the current gamemode overrides [GM:Move](https://wiki.facepunch.com/gmod/GM:Move) and does not call this hook.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:Move) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L86)

---

### PLAYER:PostDrawViewModel · Client · `hook`
`PLAYER:PostDrawViewModel(viewmodel: Entity, weapon: Entity)`

Called after the viewmodel has been drawn

**Arguments:**
- `viewmodel` (Entity) — The viewmodel
- `weapon` (Entity) — The weapon

[wiki](https://wiki.facepunch.com/gmod/PLAYER:PostDrawViewModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L110-L118)

---

### PLAYER:PreDrawViewModel · Client · `hook`
`PLAYER:PreDrawViewModel(viewmodel: Entity, weapon: Entity)`

Called before the viewmodel is drawn

**Arguments:**
- `viewmodel` (Entity) — The viewmodel
- `weapon` (Entity) — The weapon

[wiki](https://wiki.facepunch.com/gmod/PLAYER:PreDrawViewModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L100-L108)

---

### PLAYER:SetModel · Server · `hook`
`PLAYER:SetModel()`

Called when we need to set player model from the class.

> **Note:** This will only be called if you have not overridden [GM:PlayerSetModel](https://wiki.facepunch.com/gmod/GM:PlayerSetModel) or call this function from it or anywhere else using [player_manager.RunClass](https://wiki.facepunch.com/gmod/player_manager.RunClass)

[wiki](https://wiki.facepunch.com/gmod/PLAYER:SetModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L67-L74)

---

### PLAYER:SetupDataTables · Shared · `hook`
`PLAYER:SetupDataTables()`

Setup the network table accessors.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:SetupDataTables) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L27-L34)

---

### PLAYER:Spawn · Server · `hook`
`PLAYER:Spawn()`

Called when the player spawns

[wiki](https://wiki.facepunch.com/gmod/PLAYER:Spawn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L45-L52)

---

### PLAYER:StartMove · Shared · `hook`
`PLAYER:StartMove(mv: CMoveData, cmd: CUserCmd) → boolean`

Called from [GM:CreateMove](https://wiki.facepunch.com/gmod/GM:CreateMove).

**Arguments:**
- `mv` (CMoveData) — The move data to override/use
- `cmd` (CUserCmd) — The command data

**Returns:**
- boolean — Return true to prevent default action

> **Note:** This hook is run after the [drive.StartMove](https://wiki.facepunch.com/gmod/drive.StartMove) has been called.
> **Warning:** This hook will not work if the current gamemode overrides [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) and does not call this hook.

[wiki](https://wiki.facepunch.com/gmod/PLAYER:StartMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L85)

---

### PLAYER:ViewModelChanged · Client · `hook`
`PLAYER:ViewModelChanged(viewmodel: Entity, old: string, new: string)`

Called when the player changes their weapon to another one causing their viewmodel model to change

**Arguments:**
- `viewmodel` (Entity) — The viewmodel that is changing
- `old` (string) — The old model
- `new` (string) — The new model

[wiki](https://wiki.facepunch.com/gmod/PLAYER:ViewModelChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/player_default.lua#L89-L98)
