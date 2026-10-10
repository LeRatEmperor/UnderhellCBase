# drive

**Realm:** Shared  ·  **Members:** 12

The drive library is for adding custom control modes to the new "remote control" entity piloting system in Garry's Mod 13. See [Entity Driving](https://wiki.facepunch.com/gmod/Entity%20Driving).

[wiki page](https://wiki.facepunch.com/gmod/drive)

### drive.CalcView · Shared · `INTERNAL`
`drive.CalcView(ply: Player, view: table{ViewData}) → boolean`

Used internally to make [DRIVE:CalcView](https://wiki.facepunch.com/gmod/DRIVE:CalcView) work, called by default from `base` gamemode's [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) hook.

**Arguments:**
- `ply` (Player) — The player.
- `view` (table{ViewData}) — The view, see Structures/ViewData.

**Returns:**
- boolean — True if succeeded.

[wiki](https://wiki.facepunch.com/gmod/drive.CalcView) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L154-L162)

---

### drive.CreateMove · Shared · `INTERNAL`
`drive.CreateMove(cmd: CUserCmd) → boolean`

Clientside, the client creates the cmd (usercommand) from their input device (mouse, keyboard) and then it's sent to the server. Restrict view angles here.

**Arguments:**
- `cmd` (CUserCmd) — The user command.

**Returns:**
- boolean — True if succeeded.

[wiki](https://wiki.facepunch.com/gmod/drive.CreateMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L141-L149)

---

### drive.DestroyMethod · Shared · `INTERNAL`
`drive.DestroyMethod(ply: Player)`

Destroys players current driving method.

**Arguments:**
- `ply` (Player) — The player to affect.

[wiki](https://wiki.facepunch.com/gmod/drive.DestroyMethod) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L103-L109)

---

### drive.End · Shared
`drive.End(ply: Player, ent: Entity)`

Player has stopped driving the entity.

**Arguments:**
- `ply` (Player) — The player.
- `ent` (Entity) — The entity.

[wiki](https://wiki.facepunch.com/gmod/drive.End) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L214-L240)

---

### drive.FinishMove · Shared · `INTERNAL`
`drive.FinishMove(ply: Player, mv: CMoveData) → boolean`

The move is finished. Copy mv back into the target.

**Arguments:**
- `ply` (Player) — The player.
- `mv` (CMoveData) — The move data.

**Returns:**
- boolean — True if succeeded.

[wiki](https://wiki.facepunch.com/gmod/drive.FinishMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L196-L209)

---

### drive.GetMethod · Shared · `INTERNAL`
`drive.GetMethod(ply: Player) → table`

Returns ( or creates if inexistent ) a driving method.

**Arguments:**
- `ply` (Player) — The player.

**Returns:**
- table — A method object.

[wiki](https://wiki.facepunch.com/gmod/drive.GetMethod) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L56-L101)

---

### drive.Move · Shared · `INTERNAL`
`drive.Move(ply: Player, mv: CMoveData) → boolean`

The move is executed here.

**Arguments:**
- `ply` (Player) — The player.
- `mv` (CMoveData) — The move data.

**Returns:**
- boolean — True if succeeded.

[wiki](https://wiki.facepunch.com/gmod/drive.Move) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L183-L191)

---

### drive.PlayerStartDriving · Shared
`drive.PlayerStartDriving(ply: Player, ent: Entity, mode: string)`

Starts driving for the player.

**Arguments:**
- `ply` (Player) — The player to affect.
- `ent` (Entity) — The entity to drive.
- `mode` (string) — The driving mode.

[wiki](https://wiki.facepunch.com/gmod/drive.PlayerStartDriving) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L39-L48)

---

### drive.PlayerStopDriving · Shared
`drive.PlayerStopDriving(ply: Player)`

Stops the player from driving anything. ( For example a prop in sandbox )

**Arguments:**
- `ply` (Player) — The player to affect.

[wiki](https://wiki.facepunch.com/gmod/drive.PlayerStopDriving) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L50-L54)

---

### drive.Register · Shared
`drive.Register(name: string, data: table, base: string = nil)`

Registers a new entity drive mode/method.

**Arguments:**
- `name` (string) — The name of the drive mode/method.
- `data` (table) — The data required to create the drive mode/method.
- `base` (string, default `nil`) — The name of a drive mode/method to inherit code from.

[wiki](https://wiki.facepunch.com/gmod/drive.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L14-L37)

---

### drive.Start · Shared
`drive.Start(ply: Player, ent: Entity)`

Called when the player first starts driving this entity.

**Arguments:**
- `ply` (Player) — The player.
- `ent` (Entity) — The entity.

[wiki](https://wiki.facepunch.com/gmod/drive.Start) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L114-L134)

---

### drive.StartMove · Shared · `INTERNAL`
`drive.StartMove(ply: Player, mv: CMoveData, cmd: CUserCmd) → boolean`

The user command is received by the server and then converted into a move. This is also run clientside when in multiplayer, for prediction to work.

**Arguments:**
- `ply` (Player) — The player.
- `mv` (CMoveData) — The move data.
- `cmd` (CUserCmd) — The user command.

**Returns:**
- boolean — True if succeeded.

[wiki](https://wiki.facepunch.com/gmod/drive.StartMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/drive.lua#L169-L177)
