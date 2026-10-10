# GM

**Realm:** Shared, Menu  ·  **Members:** 267

Hooks that are available for all gamemodes based on base gamemode.
	
	See also: [Structures/GM](https://wiki.facepunch.com/gmod/Structures/GM).

> **Using these hooks:** register with `hook.Add("<EventName>", "unique_id", func)` using the **bare event name — drop the `GM:` prefix** (e.g. `hook.Add("PlayerSay", ...)`, **not** `hook.Add("GM:PlayerSay", ...)`). Or define `function GM:<EventName>()` in your gamemode. The `GM:` shown on each member below is only the method-definition form, not the hook.Add string.

> **Part 1 of 2** (`AcceptInput` – `PlayerSetHandsModel`). All parts: [1](GM.md), [2](GM-2.md)


### GM:AcceptInput · Server · `hook`
`GM:AcceptInput(ent: Entity, input: string, activator: Entity, caller: Entity, value: any) → boolean`

Called when a map I/O event occurs.

See also [Entity:Fire](https://wiki.facepunch.com/gmod/Entity:Fire) and [Entity:Input](https://wiki.facepunch.com/gmod/Entity:Input) for functions to fire Inputs on entities.

**Arguments:**
- `ent` (Entity) — Entity that receives the input
- `input` (string) — The input name.
- `activator` (Entity) — Activator of the input
- `caller` (Entity) — Caller of the input
- `value` (any) — Data provided with the input.

**Returns:**
- boolean — Return true to prevent this input from being processed.

[wiki](https://wiki.facepunch.com/gmod/GM:AcceptInput)

---

### GM:AddDeathNotice · Client · `hook`
`GM:AddDeathNotice(attacker: string, attackerTeam: number, inflictor: string, victim: string, victimTeam: number) → any`

Adds a death notice entry.

**Arguments:**
- `attacker` (string) — The name of the attacker
- `attackerTeam` (number) — The team of the attacker
- `inflictor` (string) — Class name of the entity inflicting the damage
- `victim` (string) — Name of the victim
- `victimTeam` (number) — Team of the victim

**Returns:**
- any — `true/false` to prevent the notice from being shown.

[wiki](https://wiki.facepunch.com/gmod/GM:AddDeathNotice) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_deathnotice.lua#L202-L223)

---

### GM:AdjustMouseSensitivity · Client · `hook`
`GM:AdjustMouseSensitivity(defaultSensitivity: number, localFOV: number, defaultFOV: number) → number`

Allows you to adjust the mouse sensitivity.

**Arguments:**
- `defaultSensitivity` (number) — The old sensitivity In general it will be 0, which is equivalent to a sensitivity of 1.
- `localFOV` (number) — Player's current FOV.
- `defaultFOV` (number) — Default FOV.

**Returns:**
- number — A fraction of the normal sensitivity (0.5 would be half as sensitive).

[wiki](https://wiki.facepunch.com/gmod/GM:AdjustMouseSensitivity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L418)

---

### GM:AllowPlayerPickup · Server · `hook`
`GM:AllowPlayerPickup(ply: Player, ent: Entity) → boolean`

Called when a player tries to pick up something using the "use" key, return to override.

This hook will not be called if `sv_playerpickupallowed` is set to 0.

See [GM:GravGunPickupAllowed](https://wiki.facepunch.com/gmod/GM:GravGunPickupAllowed) for the Gravity Gun pickup variant.
See [GM:PhysgunPickup](https://wiki.facepunch.com/gmod/GM:PhysgunPickup) for the Physics Gun pickup variant.

**Arguments:**
- `ply` (Player) — The player trying to pick up something.
- `ent` (Entity) — The Entity the player attempted to pick up.

**Returns:**
- boolean — Allow the player to pick up the entity or not.

[wiki](https://wiki.facepunch.com/gmod/GM:AllowPlayerPickup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L818-L828)

---

### GM:CalcMainActivity · Shared · `hook`
`GM:CalcMainActivity(ply: Player, vel: Vector) → number, number`

This hook is used to calculate animations for a player.

**Arguments:**
- `ply` (Player) — The player to apply the animation.
- `vel` (Vector) — The velocity of the player.

**Returns:**
- number — ACT for the activity the player should use.
- number — Sequence for the player to use.

> **Warning:** This hook must return the same values at the same time on both, client **and** server. On client for players to see the animations, on server for hit detection to work properly.

[wiki](https://wiki.facepunch.com/gmod/GM:CalcMainActivity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L296-L321)

---

### GM:CalcVehicleView · Client · `hook`
`GM:CalcVehicleView(veh: Vehicle, ply: Player, view: table) → table`

Called from [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) when player is in driving a vehicle.

This hook may not be called in gamemodes that override [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView).

**Arguments:**
- `veh` (Vehicle) — The vehicle the player is driving
- `ply` (Player) — The vehicle driver
- `view` (table) — The view data containing players FOV, view position and angles, see Structures/CamData

**Returns:**
- table — The modified view table containing new values, see Structures/CamData

[wiki](https://wiki.facepunch.com/gmod/GM:CalcVehicleView) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L305)

---

### GM:CalcView · Client · `hook`
`GM:CalcView(ply: Player, origin: Vector, angles: Angle, fov: number, znear: number, zfar: number) → table{CamData}`

Allows override of the default view.

**Arguments:**
- `ply` (Player) — The local player.
- `origin` (Vector) — The player's view position.
- `angles` (Angle) — The player's view angles.
- `fov` (number) — Field of view.
- `znear` (number) — Distance to near clipping plane.
- `zfar` (number) — Distance to far clipping plane.

**Returns:**
- table{CamData} — View data table.

[wiki](https://wiki.facepunch.com/gmod/GM:CalcView) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L357)

---

### GM:CalcViewModelView · Client · `hook`
`GM:CalcViewModelView(wep: Weapon, vm: Entity, oldPos: Vector, oldAng: Angle, pos: Vector, ang: Angle) → Vector, Angle`

Allows overriding the position and angle of the viewmodel.

**Arguments:**
- `wep` (Weapon) — The weapon entity
- `vm` (Entity) — The viewmodel entity
- `oldPos` (Vector) — Original position (before viewmodel bobbing and swaying)
- `oldAng` (Angle) — Original angle (before viewmodel bobbing and swaying)
- `pos` (Vector) — Current position
- `ang` (Angle) — Current angle

**Returns:**
- Vector — New position
- Angle — New angle

[wiki](https://wiki.facepunch.com/gmod/GM:CalcViewModelView) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L555)

---

### GM:CanCreateUndo · Server · `hook`
`GM:CanCreateUndo(ply: Player, undo: table) → boolean`

Called whenever a players tries to create an undo.

**Arguments:**
- `ply` (Player) — The player who tried to create something.
- `undo` (table) — The undo table as a Structures/Undo.

**Returns:**
- boolean — Return false to disallow creation of the undo.

[wiki](https://wiki.facepunch.com/gmod/GM:CanCreateUndo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L328-L328)

---

### GM:CanEditVariable · Server · `hook`
`GM:CanEditVariable(ent: Entity, ply: Player, key: string, value: string, editor: table) → boolean`

Called when a variable is about to be edited on an Entity (called by `Edit Properties...` menu), to determine if the edit should be permitted.

See [Editable entities](https://wiki.facepunch.com/gmod/Editable_Entities) for more details about the system.

By default, Sandbox will also call [ENTITY:CanEditVariables](https://wiki.facepunch.com/gmod/ENTITY:CanEditVariables) if no hook returns a value.

**Arguments:**
- `ent` (Entity) — The entity being edited.
- `ply` (Player) — The player doing the editing.
- `key` (string) — The name of the variable.
- `value` (string) — The new value, as a string which will later be converted to its appropriate type.
- `editor` (table) — The edit table defined in Entity:NetworkVar.

**Returns:**
- boolean — Return `false` to disallow editing.

[wiki](https://wiki.facepunch.com/gmod/GM:CanEditVariable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/variable_edit.lua#L28)

---

### GM:CanExitVehicle · Server · `hook`
`GM:CanExitVehicle(veh: Vehicle, ply: Player) → boolean`

Determines if the player can exit the vehicle on their own. [Player:ExitVehicle](https://wiki.facepunch.com/gmod/Player:ExitVehicle) will bypass this hook.

See [GM:CanPlayerEnterVehicle](https://wiki.facepunch.com/gmod/GM:CanPlayerEnterVehicle) for the opposite hook.  
See also [GM:PlayerLeaveVehicle](https://wiki.facepunch.com/gmod/GM:PlayerLeaveVehicle) for a hook that will be called whenever a player exits any vehicle for any reason.

**Arguments:**
- `veh` (Vehicle) — The vehicle entity
- `ply` (Player) — The player

**Returns:**
- boolean — True if the player can exit the vehicle.

[wiki](https://wiki.facepunch.com/gmod/GM:CanExitVehicle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L567)

---

### GM:CanPlayerEnterVehicle · Server · `hook`
`GM:CanPlayerEnterVehicle(player: Player, vehicle: Vehicle, role: number) → boolean`

Determines whether or not a given player player can enter the given vehicle. [Player:EnterVehicle](https://wiki.facepunch.com/gmod/Player:EnterVehicle) will still call this hook.

Called just before [GM:PlayerEnteredVehicle](https://wiki.facepunch.com/gmod/GM:PlayerEnteredVehicle). See also [GM:CanExitVehicle](https://wiki.facepunch.com/gmod/GM:CanExitVehicle).

**Arguments:**
- `player` (Player) — The player that wants to enter a vehicle.
- `vehicle` (Vehicle) — The vehicle in question.
- `role` (number) — The seat number.

**Returns:**
- boolean — `false` if the player is not allowed to enter the vehicle.

[wiki](https://wiki.facepunch.com/gmod/GM:CanPlayerEnterVehicle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L584-L590)

---

### GM:CanPlayerSuicide · Server · `hook`
`GM:CanPlayerSuicide(player: Player) → boolean`

Determines if the player can kill themselves using the `kill` or `explode` console commands.

**Arguments:**
- `player` (Player) — The player

**Returns:**
- boolean — `true` if the player should be allowed to suicide, `false` if not.

[wiki](https://wiki.facepunch.com/gmod/GM:CanPlayerSuicide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L554-L556)

---

### GM:CanPlayerUnfreeze · Server · `hook`
`GM:CanPlayerUnfreeze(player: Player, entity: Entity, phys: PhysObj) → boolean`

Determines if the player can unfreeze the entity.

**Arguments:**
- `player` (Player) — The player
- `entity` (Entity) — The entity
- `phys` (PhysObj) — The physics object of the entity

**Returns:**
- boolean — True if they can unfreeze.

[wiki](https://wiki.facepunch.com/gmod/GM:CanPlayerUnfreeze) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L65-L69)

---

### GM:CanProperty · Shared · `hook` · `PREDICTED`
`GM:CanProperty(ply: Player, property: string, ent: Entity) → boolean`

Controls if a [property](https://wiki.facepunch.com/gmod/properties) can be used or not.

**Arguments:**
- `ply` (Player) — Player, that tried to use the property
- `property` (string) — Class of the property that is tried to use, for example - bonemanipulate
- `ent` (Entity) — The entity, on which property is tried to be used on

**Returns:**
- boolean — Return false to disallow using that property

[wiki](https://wiki.facepunch.com/gmod/GM:CanProperty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L263-L265)

---

### GM:CanUndo · Server · `hook`
`GM:CanUndo(ply: Player, undo: table{Undo}) → boolean`

Called whenever a players tries to undo.

**Arguments:**
- `ply` (Player) — The player who tried to undo something.
- `undo` (table{Undo}) — The undo table as a Structures/Undo.

**Returns:**
- boolean — Return false to disallow the undo.

[wiki](https://wiki.facepunch.com/gmod/GM:CanUndo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/undo.lua#L429-L429)

---

### GM:CaptureVideo · Menu · `hook`
`GM:CaptureVideo()`

Called each frame to record demos to video using [IVideoWriter](https://wiki.facepunch.com/gmod/IVideoWriter).

> **Note:** This hook is called every frame regardless of whether or not a demo is being recorded

[wiki](https://wiki.facepunch.com/gmod/GM:CaptureVideo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/demo_to_video.lua#L286-L310)

---

### GM:ChatText · Client · `hook`
`GM:ChatText(index: number, name: string, text: string, type: string) → boolean`

Called when a message is printed to the chat box. Note, that this isn't working with player messages even though there are arguments for it.

For player messages see [GM:PlayerSay](https://wiki.facepunch.com/gmod/GM:PlayerSay) and [GM:OnPlayerChat](https://wiki.facepunch.com/gmod/GM:OnPlayerChat)

**Arguments:**
- `index` (number) — The index of the player.
- `name` (string) — The name of the player.
- `text` (string) — The text that is being sent.
- `type` (string) — Chat filter type.

**Returns:**
- boolean — Return true to suppress the chat message.

[wiki](https://wiki.facepunch.com/gmod/GM:ChatText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L250-L260)

---

### GM:ChatTextChanged · Client · `hook`
`GM:ChatTextChanged(text: string)`

Called whenever the content of the user's chat input box is changed.

**Arguments:**
- `text` (string) — The new contents of the input box

[wiki](https://wiki.facepunch.com/gmod/GM:ChatTextChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L243-L244)

---

### GM:CheckPassword · Server · `hook`
`GM:CheckPassword(steamID64: string, ipAddress: string, svPassword: string, clPassword: string, name: string) → boolean, string`

Called when a **non local player** connects to allow the Lua system to check the password.

The default behaviour in the base gamemodes emulates what would normally happen. If `sv_password` is set and its value matches the password passed in by the client (via `password` concommand) - then they are allowed to join. If `sv_password` isn't set it lets them in too.

**Arguments:**
- `steamID64` (string) — The 64bit Steam ID of the joining player, use util.SteamIDFrom64 to convert it to a `STEAM_0:` one.
- `ipAddress` (string) — The IP of the connecting client
- `svPassword` (string) — The current value of sv_password (the password set by the server)
- `clPassword` (string) — The password provided by the client
- `name` (string) — The name of the joining player

**Returns:**
- boolean — If the hook returns `false` then the player is disconnected
- string — If returning false in the first argument, then this should be the disconnect message.

[wiki](https://wiki.facepunch.com/gmod/GM:CheckPassword) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/init.lua#L124-L141)

---

### GM:ClientSignOnStateChanged · Shared · `hook`
`GM:ClientSignOnStateChanged(userID: number, oldState: number, newState: number)`

Called when a player's sign on state changes.

**Arguments:**
- `userID` (number) — The userID of the player whose sign on state has changed.
- `oldState` (number, enum [SIGNONSTATE](https://wiki.facepunch.com/gmod/Enums/SIGNONSTATE)) — The previous sign on state.
- `newState` (number, enum [SIGNONSTATE](https://wiki.facepunch.com/gmod/Enums/SIGNONSTATE)) — The new/current sign on state.

> **Bug** ([#4899](https://github.com/Facepunch/garrysmod/issues/4899)): You cannot get a valid player object from the userID at any point during this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:ClientSignOnStateChanged)

---

### GM:CloseDermaMenus · Client, Menu · `hook`
`GM:CloseDermaMenus()`

Called when derma menus are closed with [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus).

[wiki](https://wiki.facepunch.com/gmod/GM:CloseDermaMenus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L729-L730)

---

### GM:CreateClientsideRagdoll · Client · `hook`
`GM:CreateClientsideRagdoll(entity: Entity, ragdoll: Entity)`

Called whenever an entity becomes a clientside ragdoll.

See [GM:CreateEntityRagdoll](https://wiki.facepunch.com/gmod/GM:CreateEntityRagdoll) for serverside ragdolls.

**Arguments:**
- `entity` (Entity) — The Entity that created the ragdoll
- `ragdoll` (Entity) — The ragdoll being created.

[wiki](https://wiki.facepunch.com/gmod/GM:CreateClientsideRagdoll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L732-L733)

---

### GM:CreateEntityRagdoll · Server · `hook`
`GM:CreateEntityRagdoll(owner: Entity, ragdoll: Entity)`

Called when a serverside ragdoll of an entity has been created.

See [GM:CreateClientsideRagdoll](https://wiki.facepunch.com/gmod/GM:CreateClientsideRagdoll) for clientside ragdolls.

**Arguments:**
- `owner` (Entity) — Entity that owns the ragdoll
- `ragdoll` (Entity) — The ragdoll entity

[wiki](https://wiki.facepunch.com/gmod/GM:CreateEntityRagdoll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/init.lua#L85-L86)

---

### GM:CreateMove · Client · `hook`
`GM:CreateMove(cmd: CUserCmd) → boolean`

Allows you to change the players movements before they're sent to the server.

See [Game Movement](https://wiki.facepunch.com/gmod/Game%20Movement) for an explanation on the move system.

**Arguments:**
- `cmd` (CUserCmd) — The User Command data

**Returns:**
- boolean — Return true to: * Disable Sandbox C menu "screen clicking" * Disable Teammate nocollide (verification required) * Prevent calling of C_BaseHLPlayer::CreateMove & subsequently C_BasePlayer::CreateMove

> **Note:** Due to this hook being clientside only, it could be overridden by the user allowing them to completely skip your logic, it is recommended to use [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand) in a shared file instead.

[wiki](https://wiki.facepunch.com/gmod/GM:CreateMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L653-L659)

---

### GM:CreateTeams · Shared · `hook`
`GM:CreateTeams()`

Teams are created within this hook using [team.SetUp](https://wiki.facepunch.com/gmod/team.SetUp).

This hook is called before [GM:PreGamemodeLoaded](https://wiki.facepunch.com/gmod/GM:PreGamemodeLoaded).

[wiki](https://wiki.facepunch.com/gmod/GM:CreateTeams) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L127-L149)

---

### GM:DoAnimationEvent · Shared · `hook`
`GM:DoAnimationEvent(ply: Player, event: number, data: number = 0) → number`

Called upon an animation event, this is the ideal place to call player animation functions such as [Player:AddVCDSequenceToGestureSlot](https://wiki.facepunch.com/gmod/Player:AddVCDSequenceToGestureSlot), [Player:AnimRestartGesture](https://wiki.facepunch.com/gmod/Player:AnimRestartGesture) and so on.

**Arguments:**
- `ply` (Player) — Player who is being animated
- `event` (number, enum [PLAYERANIMEVENT](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT)) — Animation event.
- `data` (number, default `0`, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The data for the event.

**Returns:**
- number — The translated activity to send to the weapon.

[wiki](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L352-L396)

---

### GM:DoPlayerDeath · Server · `hook`
`GM:DoPlayerDeath(ply: Player, attacker: Entity, dmg: CTakeDamageInfo)`

Handles the player's death.

This hook is **not** called if the player is killed by [Player:KillSilent](https://wiki.facepunch.com/gmod/Player:KillSilent). See [GM:PlayerSilentDeath](https://wiki.facepunch.com/gmod/GM:PlayerSilentDeath) for that.

* [GM:PlayerDeath](https://wiki.facepunch.com/gmod/GM:PlayerDeath) is called after this hook
* [GM:PostPlayerDeath](https://wiki.facepunch.com/gmod/GM:PostPlayerDeath) is called after that

**Arguments:**
- `ply` (Player) — The player
- `attacker` (Entity) — The entity that killed the player
- `dmg` (CTakeDamageInfo) — Damage info

> **Note:** [Player:Alive](https://wiki.facepunch.com/gmod/Player:Alive) will return false in this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:DoPlayerDeath) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/init.lua#L39-L57)

---

### GM:DrawDeathNotice · Client · `hook`
`GM:DrawDeathNotice(x: number, y: number)`

This hook is called every frame to draw all of the current death notices.

**Arguments:**
- `x` (number) — X position to draw death notices as a ratio
- `y` (number) — Y position to draw death notices as a ratio

[wiki](https://wiki.facepunch.com/gmod/GM:DrawDeathNotice) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_deathnotice.lua#L254-L292)

---

### GM:DrawMonitors · Client · `hook`
`GM:DrawMonitors()`

Called every frame before drawing the in-game monitors ( Breencast, in-game TVs, etc ), but doesn't seem to be doing anything, trying to render 2D or 3D elements fail.

[wiki](https://wiki.facepunch.com/gmod/GM:DrawMonitors) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L717-L718)

---

### GM:DrawOverlay · Client, Menu · `hook`
`GM:DrawOverlay()`

Called after all other 2D draw hooks are called. Draws over all VGUI Panels and HUDs.

Unlike [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint), this hook is called with the game paused and while the Camera SWEP is equipped.

Does not get called when `r_drawvgui` is disabled.

[wiki](https://wiki.facepunch.com/gmod/GM:DrawOverlay) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L714-L715)

---

### GM:DrawPhysgunBeam · Client · `hook`
`GM:DrawPhysgunBeam(ply: Player, physgun: Weapon, enabled: boolean, target: Entity, physBone: number, hitPos: Vector) → boolean`

Allows you to override physgun effects rendering.

**Arguments:**
- `ply` (Player) — Physgun owner
- `physgun` (Weapon) — The physgun
- `enabled` (boolean) — Is the beam enabled
- `target` (Entity) — Entity we are grabbing.
- `physBone` (number) — ID of the physics bone (PhysObj) we are grabbing at.
- `hitPos` (Vector) — Beam hit position relative to the physics bone (PhysObj) we are grabbing.

**Returns:**
- boolean — Return false to hide default effects

> **Note:** This is still called when `physgun_drawbeams` is set to `0`, because this hook is also capable of overriding physgun sprite effects, while the convar does not.

[wiki](https://wiki.facepunch.com/gmod/GM:DrawPhysgunBeam) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L634-L639)

---

### GM:EndEntityDriving · Shared · `hook`
`GM:EndEntityDriving(ent: Entity, ply: Player)`

Called right before an entity stops driving. Overriding this hook will cause it to not call [drive.End](https://wiki.facepunch.com/gmod/drive.End) and the player will not stop driving.

**Arguments:**
- `ent` (Entity) — The entity being driven
- `ply` (Player) — The player driving the entity

[wiki](https://wiki.facepunch.com/gmod/GM:EndEntityDriving) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L215-L219)

---

### GM:EntityEmitSound · Shared · `hook`
`GM:EntityEmitSound(data: table) → boolean`

Called whenever a sound has been played. This will not be called clientside if the server played the sound without the client also calling [Entity:EmitSound](https://wiki.facepunch.com/gmod/Entity:EmitSound).

**Arguments:**
- `data` (table) — Information about the played sound.

**Returns:**
- boolean — * Return `true` to apply all changes done to the data table.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityEmitSound)

---

### GM:EntityFireBullets · Shared · `hook`
`GM:EntityFireBullets(entity: Entity, data: table{Bullet}) → boolean`

Called every time a bullet is about to be fired from an entity, which allows to completely modify the bullet structure before the bullet is actually fired.

See [GM:PostEntityFireBullets](https://wiki.facepunch.com/gmod/GM:PostEntityFireBullets) if you wish to hook the final bullet values, such as the aim direction post spread calculations.

**Arguments:**
- `entity` (Entity) — The entity that fired the bullet
- `data` (table{Bullet}) — The bullet data.

**Returns:**
- boolean — * Return `true` to apply all changes done to the bullet table.

> **Warning:** This hook is called directly from [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets). Due to this, you cannot call [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets) inside this hook or an infinite loop will occur crashing the game.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityFireBullets) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L270-L272)

---

### GM:EntityKeyValue · Shared · `hook`
`GM:EntityKeyValue(ent: Entity, key: string, value: string) → string`

Called when a key-value pair is set on an entity on map spawn. Is **not** called by [Entity:SetKeyValue](https://wiki.facepunch.com/gmod/Entity:SetKeyValue).

See [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue) for a [scripted entities](https://wiki.facepunch.com/gmod/scripted%20entities) hook, and its scripted weapon alternative: [WEAPON:KeyValue](https://wiki.facepunch.com/gmod/WEAPON:KeyValue).

**Arguments:**
- `ent` (Entity) — Entity that the keyvalue is being set on
- `key` (string) — Key of the key/value pair
- `value` (string) — Value of the key/value pair

**Returns:**
- string — If set, the value of the key-value pair will be overridden by this string.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityKeyValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L120-L121)

---

### GM:EntityNetworkedVarChanged · Shared · `hook`
`GM:EntityNetworkedVarChanged(ent: Entity, name: string, oldval: any, newval: any)`

Called when an NW2Var is changed.

**Arguments:**
- `ent` (Entity) — The owner entity of the changed NW2Var
- `name` (string) — The name of the changed NW2Var
- `oldval` (any) — The old value of the NW2Var
- `newval` (any) — The new value of the NW2Var

> **Note:** This hook is fired before the client value is actually changed. Calling the GetNW2 function for the specified variable name within this hook will return the old value, not the current/updated one.  
> 
> 	This hook gets called for all NW2Vars on all Entities in a full update. The old value will be nil in this case.  
> 	If this hook seems to be called for no apparent reason, check if it's caused by a full update.
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): If a NW2Var is set on an entity that is based on a Lua Entity could result in the NW2Var being mixed up with other ones and being updated multiple times.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityNetworkedVarChanged)

---

### GM:EntityRemoved · Shared · `hook`
`GM:EntityRemoved(ent: Entity, fullUpdate: boolean)`

Called right before removal of an entity.

**Arguments:**
- `ent` (Entity) — Entity being removed
- `fullUpdate` (boolean) — Whether the removal is happening due to a full update clientside.

> **Warning:** This hook is called clientside during full updates due to how networking works in the Source Engine.
> 
> This can happen when the client briefly loses connection to the server, and can be simulated via `cl_fullupdate` for testing purposes.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityRemoved) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L98-L99)

---

### GM:EntityTakeDamage · Server · `hook`
`GM:EntityTakeDamage(target: Entity, dmg: CTakeDamageInfo) → boolean`

Called when an entity is about to take damage. You can modify all parts of the damage info in this hook or completely block the damage event.

See [GM:PostEntityTakeDamage](https://wiki.facepunch.com/gmod/GM:PostEntityTakeDamage) if you wish to hook the final damage event.

**Arguments:**
- `target` (Entity) — The entity taking damage
- `dmg` (CTakeDamageInfo) — Detailed information about the damage event.

**Returns:**
- boolean — Return true to completely block the damage event

> **Warning:** Applying damage from this hook to the entity taking damage will lead to infinite loop/crash.

[wiki](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/init.lua#L71-L72)

---

### GM:FindUseEntity · Shared · `hook`
`GM:FindUseEntity(ply: Player, defaultEnt: Entity) → Entity`

This hook polls the entity the player use action should be applied to.

**Arguments:**
- `ply` (Player) — The player who initiated the use action.
- `defaultEnt` (Entity) — The entity that was chosen by the engine.

**Returns:**
- Entity — The entity to use instead of default entity

> **Note:** The default behavior of this hook is in [CBasePlayer::FindUseEntity](https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/mp/src/game/shared/baseplayer_shared.cpp#L1068-L1270). Despite CBasePlayer::FindUseEntity being defined shared, it is only called serverside in practice, so this hook will be only called serverside, as well. It is possible for modules to call it clientside, so the Lua code should still be treated as shared.

[wiki](https://wiki.facepunch.com/gmod/GM:FindUseEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_shd.lua#L103-L120)

---

### GM:FinishChat · Client · `hook`
`GM:FinishChat()`

Runs when user cancels/finishes typing.

[wiki](https://wiki.facepunch.com/gmod/GM:FinishChat) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L237-L238)

---

### GM:FinishMove · Shared · `hook` · `PREDICTED`
`GM:FinishMove(ply: Player, mv: CMoveData) → boolean`

Called after [GM:Move](https://wiki.facepunch.com/gmod/GM:Move), applies all the changes from the [CMoveData](https://wiki.facepunch.com/gmod/CMoveData) to the player.

See [Game Movement](https://wiki.facepunch.com/gmod/Game%20Movement) for an explanation on the move system.

**Arguments:**
- `ply` (Player) — Player
- `mv` (CMoveData) — Movement data

**Returns:**
- boolean — Return true to suppress default engine behavior, i.e.

[wiki](https://wiki.facepunch.com/gmod/GM:FinishMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L189-L194)

---

### GM:ForceDermaSkin · Client · `hook`
`GM:ForceDermaSkin() → string`

Called to allow override of the default Derma skin for all panels.

**Returns:**
- string — A case sensitive Derma skin name to be used as default, registered previously via derma.DefineSkin.

> **Note:** You can [Panel:SetSkin](https://wiki.facepunch.com/gmod/Panel:SetSkin) "Default" (or other skins) on the frame/base panel and they will still take priority
> **Note:** This hook is only called on Lua start up, changing its value (or adding new hooks) after it has been already called will not have any effect.

[wiki](https://wiki.facepunch.com/gmod/GM:ForceDermaSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L437-L442)

---

### GM:GameContentChanged · Shared, Menu · `hook`
`GM:GameContentChanged()`

Called when game content has been changed, for example an addon or a mountable game was (un)mounted.

[wiki](https://wiki.facepunch.com/gmod/GM:GameContentChanged)

---

### GM:GetDeathNoticeEntityName · Server · `hook`
`GM:GetDeathNoticeEntityName(name: string|Entity) → string`

An internal function used to get an untranslated string to show in the kill feed as the entity's name. See [GM:SendDeathNotice](https://wiki.facepunch.com/gmod/GM:SendDeathNotice)

**Arguments:**
- `name` (string|Entity) — The name of the entity.

**Returns:**
- string — The untranslated name for given NPC.

[wiki](https://wiki.facepunch.com/gmod/GM:GetDeathNoticeEntityName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/npc.lua#L49-L79)

---

### GM:GetFallDamage · Server · `hook`
`GM:GetFallDamage(ply: Player, speed: number) → number`

Called when a player takes damage from falling, allows to override the damage.

**Arguments:**
- `ply` (Player) — The player
- `speed` (number) — The fall speed

**Returns:**
- number — New fall damage

[wiki](https://wiki.facepunch.com/gmod/GM:GetFallDamage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L727-L735)

---

### GM:GetGameDescription · Shared · `hook`
`GM:GetGameDescription() → string`

Called when the game(server) needs to update the text shown in the server browser as the gamemode. Runs at a ~2s interval, runs even when the server is hibernating.

**Returns:**
- string — The text to be shown in the server browser as the gamemode.

> **Note:** This hook (and the `sv_gamename_override` command) may not work on some popular gamemodes like DarkRP or Trouble Terrorist Town. This is not a bug, it's just how it works. See [here](https://github.com/Facepunch/garrysmod-issues/issues/4637#issuecomment-677884989) for more information.
> 
> Also, it **only** works on dedicated servers and is called at regular intervals (about one second) **even** if the server has no players and the hibernation function is enabled.

[wiki](https://wiki.facepunch.com/gmod/GM:GetGameDescription) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L76-L78)

---

### GM:GetMotionBlurValues · Client · `hook`
`GM:GetMotionBlurValues(horizontal: number, vertical: number, forward: number, rotational: number) → number, number, number, number`

Allows you to modify the Source Engine's motion blur shaders.

**Arguments:**
- `horizontal` (number) — The amount of horizontal blur.
- `vertical` (number) — The amount of vertical blur.
- `forward` (number) — The amount of forward/radial blur.
- `rotational` (number) — The amount of rotational blur.

**Returns:**
- number — New amount of horizontal blur.
- number — New amount of vertical blur.
- number — New amount of forward/radial blur.
- number — New amount of rotational blur.

[wiki](https://wiki.facepunch.com/gmod/GM:GetMotionBlurValues) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L462-L468)

---

### GM:GetPreferredCarryAngles · Server · `hook`
`GM:GetPreferredCarryAngles(ent: Entity, ply: Player) → Angle`

Called to determine preferred carry angles for the entity. It works for both, +use pickup and gravity gun pickup.

**Arguments:**
- `ent` (Entity) — The entity to generate carry angles for
- `ply` (Player) — The player who is holding the object

**Returns:**
- Angle — The preferred carry angles for the entity.

> **Note:** This hook can **not** override preferred carry angles of props such as the sawblade and the harpoon.
> **Warning:** Due to nature of the gravity gun coding in multiplayer, this hook **MAY** seem to not work ( but rest assured it does ), due to clientside prediction not knowing the carry angles. The +use pickup doesn't present this issue as it doesn't predict the player carrying the object clientside ( as you may notice by the prop lagging behind in multiplayer )

[wiki](https://wiki.facepunch.com/gmod/GM:GetPreferredCarryAngles)

---

### GM:GetTeamColor · Client · `hook`
`GM:GetTeamColor(ent: Entity) → Color`

Returns the color for the given entity's team. This is used in chat and deathnotice text.

**Arguments:**
- `ent` (Entity) — Entity

**Returns:**
- Color — Team Color

[wiki](https://wiki.facepunch.com/gmod/GM:GetTeamColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L124-L130)

---

### GM:GetTeamNumColor · Client · `hook`
`GM:GetTeamNumColor(team: number) → Color`

Returns the team color for the given team index.

**Arguments:**
- `team` (number) — Team index

**Returns:**
- Color — Team Color

[wiki](https://wiki.facepunch.com/gmod/GM:GetTeamNumColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L136-L140)

---

### GM:GrabEarAnimation · Shared · `hook`
`GM:GrabEarAnimation(ply: Player)`

Override this hook to disable/change ear-grabbing in your gamemode. By default, it is not called anywhere on the server.

**Arguments:**
- `ply` (Player) — Player

[wiki](https://wiki.facepunch.com/gmod/GM:GrabEarAnimation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L249-L271)

---

### GM:GravGunOnDropped · Server · `hook`
`GM:GravGunOnDropped(ply: Player, ent: Entity)`

Called when an entity is released by a gravity gun.

See [GM:PhysgunDrop](https://wiki.facepunch.com/gmod/GM:PhysgunDrop) for the Physics Gun drop variant.

**Arguments:**
- `ply` (Player) — Player who is wielding the gravity gun
- `ent` (Entity) — The entity that has been dropped

[wiki](https://wiki.facepunch.com/gmod/GM:GravGunOnDropped) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/gravitygun.lua#L33-L34)

---

### GM:GravGunOnPickedUp · Server · `hook`
`GM:GravGunOnPickedUp(ply: Player, ent: Entity)`

Called when an entity is picked up by a gravity gun.

See [GM:OnPlayerPhysicsPickup](https://wiki.facepunch.com/gmod/GM:OnPlayerPhysicsPickup) for the player `+use` pickup variant.
See [GM:OnPhysgunPickup](https://wiki.facepunch.com/gmod/GM:OnPhysgunPickup) for the Physics Gun pickup variant.

**Arguments:**
- `ply` (Player) — The player wielding the gravity gun
- `ent` (Entity) — The entity that has been picked up by the gravity gun

[wiki](https://wiki.facepunch.com/gmod/GM:GravGunOnPickedUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/gravitygun.lua#L25-L26)

---

### GM:GravGunPickupAllowed · Server · `hook`
`GM:GravGunPickupAllowed(ply: Player, ent: Entity) → boolean`

Called every tick to poll whether a player is allowed to pick up an entity with the gravity gun or not.

See [GM:AllowPlayerPickup](https://wiki.facepunch.com/gmod/GM:AllowPlayerPickup) for the +USE pickup variant.
See [GM:PhysgunPickup](https://wiki.facepunch.com/gmod/GM:PhysgunPickup) for the Physics Gun pickup variant.

Calls [ENTITY:GravGunPickupAllowed](https://wiki.facepunch.com/gmod/ENTITY:GravGunPickupAllowed) on the entity being hovered every frame in Sandbox-derived gamemodes.

**Arguments:**
- `ply` (Player) — The player wielding the gravity gun
- `ent` (Entity) — The entity the player is attempting to pick up

**Returns:**
- boolean — Return true to allow entity pick up

[wiki](https://wiki.facepunch.com/gmod/GM:GravGunPickupAllowed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/gravitygun.lua#L15-L17)

---

### GM:GravGunPunt · Shared · `hook`
`GM:GravGunPunt(ply: Player, ent: Entity) → boolean`

Called when an entity is about to be punted with the gravity gun (primary fire).

By default this function makes [ENTITY:GravGunPunt](https://wiki.facepunch.com/gmod/ENTITY:GravGunPunt) work in Sandbox derived gamemodes.

**Arguments:**
- `ply` (Player) — The player wielding the gravity gun
- `ent` (Entity) — The entity the player is attempting to punt

**Returns:**
- boolean — Return true to allow and false to disallow.

[wiki](https://wiki.facepunch.com/gmod/GM:GravGunPunt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/gravitygun.lua#L7-L9)

---

### GM:GUIMouseDoublePressed · Client · `hook`
`GM:GUIMouseDoublePressed(mouseCode: number, aimVector: Vector)`

Called when the mouse has been double clicked on any panel derived from CGModBase, such as the panel used by [gui.EnableScreenClicker](https://wiki.facepunch.com/gmod/gui.EnableScreenClicker) and the panel used by [Panel:ParentToHUD](https://wiki.facepunch.com/gmod/Panel:ParentToHUD).

By default this hook calls [GM:GUIMousePressed](https://wiki.facepunch.com/gmod/GM:GUIMousePressed).

**Arguments:**
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The code of the mouse button pressed, see MOUSE
- `aimVector` (Vector) — A normalized vector pointing in the direction the client has clicked

[wiki](https://wiki.facepunch.com/gmod/GM:GUIMouseDoublePressed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L99-L103)

---

### GM:GUIMousePressed · Client · `hook`
`GM:GUIMousePressed(mouseCode: number, aimVector: Vector)`

Called whenever a players presses a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by [gui.EnableScreenClicker](https://wiki.facepunch.com/gmod/gui.EnableScreenClicker) and the panel used by [Panel:ParentToHUD](https://wiki.facepunch.com/gmod/Panel:ParentToHUD).

See [GM:VGUIMousePressed](https://wiki.facepunch.com/gmod/GM:VGUIMousePressed) for a hook that is called on all VGUI elements.

**Arguments:**
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key that the player pressed using MOUSE.
- `aimVector` (Vector) — A normalized direction vector local to the camera.

[wiki](https://wiki.facepunch.com/gmod/GM:GUIMousePressed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L681-L682)

---

### GM:GUIMouseReleased · Client · `hook`
`GM:GUIMouseReleased(mouseCode: number, aimVector: Vector)`

Called whenever a players releases a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by [gui.EnableScreenClicker](https://wiki.facepunch.com/gmod/gui.EnableScreenClicker) and the panel used by [Panel:ParentToHUD](https://wiki.facepunch.com/gmod/Panel:ParentToHUD).

**Arguments:**
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key the player released, see MOUSE
- `aimVector` (Vector) — A normalized direction vector local to the camera.

[wiki](https://wiki.facepunch.com/gmod/GM:GUIMouseReleased) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L688-L689)

---

### GM:HandlePlayerArmorReduction · Server · `hook`
`GM:HandlePlayerArmorReduction(ply: Player, dmginfo: CTakeDamageInfo)`

Called to handle player armor reduction, when player receives damage.

**Arguments:**
- `ply` (Player) — The player that took damage.
- `dmginfo` (CTakeDamageInfo) — The taken damage.

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerArmorReduction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L829-L861)

---

### GM:HandlePlayerDriving · Shared · `hook`
`GM:HandlePlayerDriving(ply: Player) → boolean`

Allows to override player driving animations.

**Arguments:**
- `ply` (Player) — Player to process

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerDriving) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L139-L192)

---

### GM:HandlePlayerDucking · Shared · `hook`
`GM:HandlePlayerDucking(ply: Player, velocity: Vector) → boolean`

Allows to override player crouch animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerDucking) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L55-L69)

---

### GM:HandlePlayerJumping · Shared · `hook`
`GM:HandlePlayerJumping(ply: Player, velocity: Vector) → boolean`

Called every frame by the player model animation system. Allows to override player jumping animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerJumping) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L2-L53)

---

### GM:HandlePlayerLanding · Shared · `hook`
`GM:HandlePlayerLanding(ply: Player, velocity: Vector, onGround: boolean) → boolean`

Called every frame by the player model animation system. Allows to override player landing animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity
- `onGround` (boolean) — Was the player on ground?

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerLanding) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L129-L137)

---

### GM:HandlePlayerNoClipping · Shared · `hook`
`GM:HandlePlayerNoClipping(ply: Player, velocity: Vector) → boolean`

Allows to override player noclip animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerNoClipping) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L71-L98)

---

### GM:HandlePlayerSwimming · Shared · `hook`
`GM:HandlePlayerSwimming(ply: Player, velocity: Vector) → boolean`

Allows to override player swimming animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerSwimming) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L113-L127)

---

### GM:HandlePlayerVaulting · Shared · `hook`
`GM:HandlePlayerVaulting(ply: Player, velocity: Vector) → boolean`

Allows to override player flying ( in mid-air, not noclipping ) animations.

**Arguments:**
- `ply` (Player) — The player
- `velocity` (Vector) — Players velocity

**Returns:**
- boolean — Return true if we've changed/set the animation, false otherwise

[wiki](https://wiki.facepunch.com/gmod/GM:HandlePlayerVaulting) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L100-L111)

---

### GM:HideTeam · Client · `hook`
`GM:HideTeam()`

Hides the team selection panel.

[wiki](https://wiki.facepunch.com/gmod/GM:HideTeam) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_pickteam.lua#L58-L65)

---

### GM:HUDAmmoPickedUp · Client · `hook`
`GM:HUDAmmoPickedUp(itemName: string, amount: number)`

Called when the client has picked up ammo. Override to disable default HUD notification.

**Arguments:**
- `itemName` (string) — Name of the item (ammo) picked up
- `amount` (number) — Amount of the item (ammo) picked up

[wiki](https://wiki.facepunch.com/gmod/GM:HUDAmmoPickedUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_hudpickup.lua#L64-L92)

---

### GM:HUDDrawPickupHistory · Client · `hook`
`GM:HUDDrawPickupHistory()`

Renders the HUD pick-up history. Override to hide default or draw your own HUD.

[wiki](https://wiki.facepunch.com/gmod/GM:HUDDrawPickupHistory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_hudpickup.lua#L94-L173)

---

### GM:HUDDrawScoreBoard · Client · `hook`
`GM:HUDDrawScoreBoard()`

Called every frame to render the scoreboard.


It is recommended to use Derma and VGUI for this job instead of this hook. Called right after [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint).

[wiki](https://wiki.facepunch.com/gmod/GM:HUDDrawScoreBoard) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_scoreboard.lua#L294-L295)

---

### GM:HUDDrawTargetID · Client · `hook`
`GM:HUDDrawTargetID() → boolean`

Called from [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint) to draw player info when you hover over a player with your crosshair or mouse.

**Returns:**
- boolean — Should the player info be drawn.

[wiki](https://wiki.facepunch.com/gmod/GM:HUDDrawTargetID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_targetid.lua#L6-L60)

---

### GM:HUDItemPickedUp · Client · `hook`
`GM:HUDItemPickedUp(itemName: string)`

Called when an item has been picked up. Override to disable the default HUD notification.

**Arguments:**
- `itemName` (string) — Name of the picked up item

[wiki](https://wiki.facepunch.com/gmod/GM:HUDItemPickedUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_hudpickup.lua#L36-L45)

---

### GM:HUDPaint · Client · `hook`
`GM:HUDPaint()`

Called whenever the HUD should be drawn.

		This is the ideal place to draw custom HUD elements.

		To prevent the default game HUD from drawing, use [GM:HUDShouldDraw](https://wiki.facepunch.com/gmod/GM:HUDShouldDraw).

		This hook does **not** get called when the Camera SWEP is held, or when the  menu is open.  
		If you need to draw in those situations, use [GM:DrawOverlay](https://wiki.facepunch.com/gmod/GM:DrawOverlay) instead.

[wiki](https://wiki.facepunch.com/gmod/GM:HUDPaint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L80-L86)

---

### GM:HUDPaintBackground · Client · `hook`
`GM:HUDPaintBackground()`

Called before [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint) when the HUD background is being drawn.

Just like [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint), this hook will not be called when the main menu is visible. [GM:PostDrawHUD](https://wiki.facepunch.com/gmod/GM:PostDrawHUD) does not have this behavior.

Things rendered in this hook will **always** appear behind things rendered in [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint).

[wiki](https://wiki.facepunch.com/gmod/GM:HUDPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L92-L93)

---

### GM:HUDShouldDraw · Client · `hook`
`GM:HUDShouldDraw(name: string) → boolean`

Called when the Gamemode is about to draw a given element on the client's HUD (heads-up display).

**Arguments:**
- `name` (string) — The name of the HUD element.

**Returns:**
- boolean — Return false to prevent the given element from being drawn on the client's screen.

> **Warning:** This hook is called HUNDREDS of times per second (more than 5 times per frame on average). You shouldn't be performing any computationally intensive operations. For Weapons you SHOULD use [WEAPON:HUDShouldDraw](https://wiki.facepunch.com/gmod/WEAPON:HUDShouldDraw) instead.

[wiki](https://wiki.facepunch.com/gmod/GM:HUDShouldDraw) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L49-L74)

---

### GM:HUDWeaponPickedUp · Client · `hook`
`GM:HUDWeaponPickedUp(weapon: Weapon)`

Called when a weapon has been picked up. Override to disable the default HUD notification.

**Arguments:**
- `weapon` (Weapon) — The picked up weapon

[wiki](https://wiki.facepunch.com/gmod/GM:HUDWeaponPickedUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_hudpickup.lua#L36-L45)

---

### GM:Initialize · Shared · `hook`
`GM:Initialize()`

Called after the gamemode loads and starts.

No entities would be present at the time this hook is called, please see [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) for a one time fire hook after all map entities have been initialized.

[wiki](https://wiki.facepunch.com/gmod/GM:Initialize)

---

### GM:InitPostEntity · Shared · `hook`
`GM:InitPostEntity()`

Called after all the entities are initialized. Starting from this hook [LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer) will return valid object.

> **Note:** At this point the client only knows about the entities that are within the spawnpoints' [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community"). For instance, if the server sends an entity that is not within this PVS, the client will receive it as NULL entity.

[wiki](https://wiki.facepunch.com/gmod/GM:InitPostEntity)

---

### GM:InputMouseApply · Client · `hook`
`GM:InputMouseApply(cmd: CUserCmd, x: number, y: number, ang: Angle) → boolean`

Allows you to modify the supplied User Command with mouse input. This could be used to make moving the mouse do funky things to view angles.

**Arguments:**
- `cmd` (CUserCmd) — User command.
- `x` (number) — The amount of mouse movement across the X axis this frame.
- `y` (number) — The amount of mouse movement across the Y axis this frame.
- `ang` (Angle) — The current view angle.

**Returns:**
- boolean — Return true if we modified something.

[wiki](https://wiki.facepunch.com/gmod/GM:InputMouseApply)

---

### GM:IsSpawnpointSuitable · Server · `hook`
`GM:IsSpawnpointSuitable(ply: Player, spawnpoint: Entity, makeSuitable: boolean) → boolean`

Check if a player can spawn at a certain spawnpoint.

**Arguments:**
- `ply` (Player) — The player who is spawned
- `spawnpoint` (Entity) — The spawnpoint entity (on the map).
- `makeSuitable` (boolean) — If this is true, it'll kill any players blocking the spawnpoint.

**Returns:**
- boolean — Return true to indicate that the spawnpoint is suitable (Allow for the player to spawn here), false to prevent spawning.

[wiki](https://wiki.facepunch.com/gmod/GM:IsSpawnpointSuitable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L330-L358)

---

### GM:KeyPress · Shared · `hook` · `PREDICTED`
`GM:KeyPress(ply: Player, key: number)`

Called whenever a player pressed a key included within the IN keys.

For a more general purpose function that handles all kinds of input, see [GM:PlayerButtonDown](https://wiki.facepunch.com/gmod/GM:PlayerButtonDown).
See [GM:KeyRelease](https://wiki.facepunch.com/gmod/GM:KeyRelease) for the key release event.

Despite being a predicted hook, it will still be called in singleplayer for your convenience.

**Arguments:**
- `ply` (Player) — The player pressing the key.
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key that the player pressed using IN.

> **Warning:** Due to this being a predicted hook, [ParticleEffect](https://wiki.facepunch.com/gmod/Global.ParticleEffect)s created only serverside from this hook will not be networked to the client, so make sure to do that on both realms.

[wiki](https://wiki.facepunch.com/gmod/GM:KeyPress)

---

### GM:KeyRelease · Shared · `hook` · `PREDICTED`
`GM:KeyRelease(ply: Player, key: number)`

Runs when a IN key was released by a player.

For a more general purpose function that handles all kinds of input, see [GM:PlayerButtonUp](https://wiki.facepunch.com/gmod/GM:PlayerButtonUp).
See [GM:KeyPress](https://wiki.facepunch.com/gmod/GM:KeyPress) for the key press event.

Despite being a predicted hook, it will still be called in singleplayer for your convenience.

**Arguments:**
- `ply` (Player) — The player releasing the key.
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key that the player released using IN.

[wiki](https://wiki.facepunch.com/gmod/GM:KeyRelease)

---

### GM:LoadGModSave · Server · `hook` · `INTERNAL`
`GM:LoadGModSave(data: string, map: string, timestamp: number)`

Called from `gm_load` when the game should load a map.

**Arguments:**
- `data` (string) — Compressed save data
- `map` (string) — The name of the map the save was created on
- `timestamp` (number) — The time the save was created on.

[wiki](https://wiki.facepunch.com/gmod/GM:LoadGModSave)

---

### GM:LoadGModSaveFailed · Menu · `hook`
`GM:LoadGModSaveFailed(reason: string, workshopid: string)`

Called while an addon from the Steam workshop is downloading. Used by default to update details on the fancy workshop download panel.

**Arguments:**
- `reason` (string) — Failure Reason.
- `workshopid` (string) — the workshop ID of the missing map (if found).

[wiki](https://wiki.facepunch.com/gmod/GM:LoadGModSaveFailed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L40-L50)

---

### GM:MenuStart · Menu · `hook`
`GM:MenuStart()`

Called when `menu.lua` has finished loading.

[wiki](https://wiki.facepunch.com/gmod/GM:MenuStart)

---

### GM:MouthMoveAnimation · Shared · `hook`
`GM:MouthMoveAnimation(ply: Player)`

Override this gamemode function to disable mouth movement when talking on voice chat. By default, it is not called anywhere on the server.

**Arguments:**
- `ply` (Player) — Player in question

[wiki](https://wiki.facepunch.com/gmod/GM:MouthMoveAnimation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/animations.lua#L276-L294)

---

### GM:Move · Shared · `hook` · `PREDICTED`
`GM:Move(ply: Player, mv: CMoveData) → boolean`

The Move hook is called for you to manipulate the player's MoveData. 

You shouldn't adjust the player's position in any way in the move hook. This is because due to prediction errors, the netcode might run the move hook multiple times as packets arrive late. Therefore you should only adjust the movedata construct in this hook.

Generally you shouldn't have to use this hook - if you want to make a custom move type you should look at the drive system.

This hook is called after [GM:PlayerTick](https://wiki.facepunch.com/gmod/GM:PlayerTick).

See [Game Movement](https://wiki.facepunch.com/gmod/Game%20Movement) for an explanation on the move system.

**Arguments:**
- `ply` (Player) — Player
- `mv` (CMoveData) — Movement information

**Returns:**
- boolean — Return true to suppress default engine action.

[wiki](https://wiki.facepunch.com/gmod/GM:Move)

---

### GM:NeedsDepthPass · Client · `hook`
`GM:NeedsDepthPass() → boolean`

Returning true in this hook will cause it to render depth buffers defined with [render.GetResolvedFullFrameDepth](https://wiki.facepunch.com/gmod/render.GetResolvedFullFrameDepth).

**Returns:**
- boolean — Render depth buffer

[wiki](https://wiki.facepunch.com/gmod/GM:NeedsDepthPass)

---

### GM:NetworkEntityCreated · Client · `hook`
`GM:NetworkEntityCreated(ent: Entity)`

Called when an entity has been created over the network.

**Arguments:**
- `ent` (Entity) — Created entity

[wiki](https://wiki.facepunch.com/gmod/GM:NetworkEntityCreated)

---

### GM:NetworkIDValidated · Server · `hook`
`GM:NetworkIDValidated(name: string, steamID: string, ownerID: string)`

Called when a player's SteamID has been validated by Steam.

See also [GM:PlayerAuthed](https://wiki.facepunch.com/gmod/GM:PlayerAuthed) and [Player:IsFullyAuthenticated](https://wiki.facepunch.com/gmod/Player:IsFullyAuthenticated).

**Arguments:**
- `name` (string) — Player name
- `steamID` (string) — Player SteamID
- `ownerID` (string) — SteamID64 of the game license owner, in case Family Sharing is used.

> **Note:** This hook doesn't work intentionally in singleplayer [because the SteamID is not validated](https://github.com/Facepunch/garrysmod-issues/issues/4906#issuecomment-819337130) in that case. This also applies to `sv_lan 1` servers for every duplicate `-multirun` client.

[wiki](https://wiki.facepunch.com/gmod/GM:NetworkIDValidated)

---

### GM:NotifyShouldTransmit · Client · `hook`
`GM:NotifyShouldTransmit(entity: Entity, shouldtransmit: boolean)`

Called whenever this entity changes its transmission state for this [LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer), such as exiting or re entering the [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community").

**Arguments:**
- `entity` (Entity) — The entity that changed its transmission state.
- `shouldtransmit` (boolean) — `True` if we started transmitting to this client and `false` if we stopped.

> **Note:** This is the best place to handle the reset of [Entity:SetPredictable](https://wiki.facepunch.com/gmod/Entity:SetPredictable), as this would be usually called when the player lags and requests a full packet update.
> 
> 	When the entity stops transmitting, [Entity:IsDormant](https://wiki.facepunch.com/gmod/Entity:IsDormant) will only return true **after** this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:NotifyShouldTransmit)

---

### GM:OnAchievementAchieved · Client · `hook`
`GM:OnAchievementAchieved(ply: Player, achievement: number)`

Called when a player has achieved an achievement. You can get the name and other information from an achievement ID with the [achievements](https://wiki.facepunch.com/gmod/achievements) library.

**Arguments:**
- `ply` (Player) — The player that earned the achievement
- `achievement` (number) — The index of the achievement

[wiki](https://wiki.facepunch.com/gmod/GM:OnAchievementAchieved)

---

### GM:OnChatTab · Client · `hook`
`GM:OnChatTab(text: string) → string`

Called when the local player presses TAB while having their chatbox opened.

**Arguments:**
- `text` (string) — The currently typed into chatbox text

**Returns:**
- string — What should be placed into the chatbox instead of what currently is when player presses tab

> **Warning:** This function now uses [player.Iterator](https://wiki.facepunch.com/gmod/player.Iterator). This means it can't run all the time, as an error in the [GM:OnEntityCreated](https://wiki.facepunch.com/gmod/GM:OnEntityCreated) or [GM:EntityRemoved](https://wiki.facepunch.com/gmod/GM:EntityRemoved) hooks is likely to interrupt it. Make sure that no addon causes an error in these hooks.

[wiki](https://wiki.facepunch.com/gmod/GM:OnChatTab) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L184-L215)

---

### GM:OnCleanup · Client · `hook`
`GM:OnCleanup(name: string) → boolean`

Called when the player cleans up something.

**Arguments:**
- `name` (string) — The name of the cleanup type

**Returns:**
- `suppress` (boolean) — Return false to suppress the cleanup notification.

[wiki](https://wiki.facepunch.com/gmod/GM:OnCleanup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/cl_init.lua#L76-L90)

---

### GM:OnClientLuaError · Server · `hook`
`GM:OnClientLuaError(error: string, ply: Player, stack: table, name: string)`

Called on the server when a Lua error occurs on a client and is sent to the server.
  
        This hook allows server-side code to detect and log client-side errors.

See [GM:OnLuaError](https://wiki.facepunch.com/gmod/GM:OnLuaError) for a hook that captures Lua errors directly within its [realm](States).

**Arguments:**
- `error` (string) — The error that occurred.
- `ply` (Player) — The player whose client caused the error.
- `stack` (table) — The Lua error stack trace
- `name` (string) — Title of the addon that is creating the Lua errors, or "ERROR" if addon is not found.

> **Note:** Warning: the hook "protects" against lua error spam. If it has 5 errors in less than 1 second, the hook will not receive any of these 4 errors.
> **Warning:** Note that the stack argument can contain a table with 0 values.

[wiki](https://wiki.facepunch.com/gmod/GM:OnClientLuaError)

---

### GM:OnCloseCaptionEmit · Client · `hook`
`GM:OnCloseCaptionEmit(soundScript: string, duration: number, fromPlayer: boolean, fullText: string) → boolean`

Called when a caption/subtitle has been emitted to the closed caption box.

**Arguments:**
- `soundScript` (string) — The name of the soundscript, or `customLuaToken` if it's from gui.AddCaption
- `duration` (number) — How long the caption should stay for
- `fromPlayer` (boolean) — Is this caption coming from the player?
- `fullText` (string) — The caption.

**Returns:**
- boolean — Return `true` to prevent the caption from appearing

[wiki](https://wiki.facepunch.com/gmod/GM:OnCloseCaptionEmit)

---

### GM:OnContextMenuClose · Client · `hook`
`GM:OnContextMenuClose()`

Called when the context menu keybind (+menu_context) is released, which by default is C.

This hook will not run if [input.IsKeyTrapping](https://wiki.facepunch.com/gmod/input.IsKeyTrapping) returns true.

See also [GM:OnContextMenuOpen](https://wiki.facepunch.com/gmod/GM:OnContextMenuOpen).

[wiki](https://wiki.facepunch.com/gmod/GM:OnContextMenuClose)

---

### GM:OnContextMenuOpen · Client · `hook`
`GM:OnContextMenuOpen()`

Called when the context menu keybind (`+menu_context`) is pressed, which by default is .

See also [GM:OnContextMenuClose](https://wiki.facepunch.com/gmod/GM:OnContextMenuClose).

[wiki](https://wiki.facepunch.com/gmod/GM:OnContextMenuOpen)

---

### GM:OnCrazyPhysics · Shared · `hook`
`GM:OnCrazyPhysics(ent: Entity, physobj: PhysObj)`

Called when the crazy physics detection detects an entity with crazy physics, i.e. position being far outside of the map, velocities being near or at infinity, etc. The primary reason for this system is to prevent program crashes in physics engine.

**Arguments:**
- `ent` (Entity) — The entity that was detected as crazy
- `physobj` (PhysObj) — The physics object that is going crazy

[wiki](https://wiki.facepunch.com/gmod/GM:OnCrazyPhysics)

---

### GM:OnDamagedByExplosion · Server · `hook`
`GM:OnDamagedByExplosion(ply: Player, dmginfo: CTakeDamageInfo)`

Called when a player has been hurt by an explosion. Override to disable default sound effect.

**Arguments:**
- `ply` (Player) — Player who has been hurt
- `dmginfo` (CTakeDamageInfo) — Damage info from explosion

[wiki](https://wiki.facepunch.com/gmod/GM:OnDamagedByExplosion) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L554-L574)

---

### GM:OnEntityCreated · Shared · `hook`
`GM:OnEntityCreated(entity: Entity)`

Called as soon as the entity is created. Very little of the entity's properties will be initialized at this stage. (keyvalues, classname, flags, anything), especially on the serverside.

**Arguments:**
- `entity` (Entity) — The entity

> **Warning:** Removing the created entity during this event can lead to unexpected problems. Use [SafeRemoveEntityDelayed](https://wiki.facepunch.com/gmod/Global.SafeRemoveEntityDelayed)( entity, 0 ) to safely remove the entity.

[wiki](https://wiki.facepunch.com/gmod/GM:OnEntityCreated)

---

### GM:OnEntityWaterLevelChanged · Server · `hook`
`GM:OnEntityWaterLevelChanged(entity: Entity, old: number, new: number)`

Called when the [Entity:WaterLevel](https://wiki.facepunch.com/gmod/Entity:WaterLevel) of an entity is changed.

    0 - The entity isn't in water.

    1 - Slightly submerged (at least to the feet).

    2 - The majority of the entity is submerged (at least to the waist).

    3 - Completely submerged.

**Arguments:**
- `entity` (Entity) — The entity.
- `old` (number) — Previous water level.
- `new` (number) — The new water level.

> **Warning:** This hook can be considered a physics callback, so changing collision rules ([Entity:SetSolidFlags](https://wiki.facepunch.com/gmod/Entity:SetSolidFlags)) in it may lead to a crash!

[wiki](https://wiki.facepunch.com/gmod/GM:OnEntityWaterLevelChanged)

---

### GM:OnGamemodeLoaded · Shared · `hook`
`GM:OnGamemodeLoaded()`

Called when the gamemode is loaded. [gmod.GetGamemode](https://wiki.facepunch.com/gmod/gmod.GetGamemode) will be functional at this point.

[LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer)() returns NULL at the time this is run.

[wiki](https://wiki.facepunch.com/gmod/GM:OnGamemodeLoaded)

---

### GM:OnLuaError · Shared, Menu · `hook`
`GM:OnLuaError(error: string, realm: string, stack: table, name: string, id: string)`

Called when a Lua error occurs.
If you want to retrieve client errors on the server side, you can use this hook: [GM:OnClientLuaError](https://wiki.facepunch.com/gmod/GM:OnClientLuaError)

**Arguments:**
- `error` (string) — The error that occurred.
- `realm` (string) — Where the Lua error took place, "client", or "server"
- `stack` (table) — The Lua error stack trace
- `name` (string) — Title of the addon that is creating the Lua errors, or nil if addon is not found.
- `id` (string) — Steam Workshop ID of the addon creating Lua errors, if it is an addon.

> **Note:** On the [server realm](https://wiki.facepunch.com/gmod/States), this hook will only account for server-side errors, not client-side ones.

[wiki](https://wiki.facepunch.com/gmod/GM:OnLuaError) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/errors.lua)

---

### GM:OnNotifyAddonConflict · Menu · `hook`
`GM:OnNotifyAddonConflict(addon1: string, addon2: string, fileName: string)`

Called when a Addon Conflict occurs, only works in the Menu realm.

**Arguments:**
- `addon1` (string) — The first Addon
- `addon2` (string) — The second Addon
- `fileName` (string) — The File the Conflict occurred in.

[wiki](https://wiki.facepunch.com/gmod/GM:OnNotifyAddonConflict) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L260-L297)

---

### GM:OnNPCDropItem · Server · `hook`
`GM:OnNPCDropItem(npc: NPC, item: Entity)`

Called whenever an NPC drops an item upon its death, such as health kits, armor batteries, etc.

It will NOT be called for dropped weapons, with exception of Half-Life: Source NPCs, since they don't use actual weapon entities and create a weapon entity on death.  
[GM:PlayerDroppedWeapon](https://wiki.facepunch.com/gmod/GM:PlayerDroppedWeapon) works for NPC weapon drops already. (Yes, it's not a typo)

It will also not be called for live grenades spawned by Zombine.

**Arguments:**
- `npc` (NPC) — The killed NPC
- `item` (Entity) — The item that got dropped by the NPC.

[wiki](https://wiki.facepunch.com/gmod/GM:OnNPCDropItem)

---

### GM:OnNPCKilled · Server · `hook`
`GM:OnNPCKilled(npc: NPC, attacker: Entity, inflictor: Entity)`

Called whenever an NPC is killed.

**Arguments:**
- `npc` (NPC) — The killed NPC
- `attacker` (Entity) — The NPCs attacker, the entity that gets the kill credit, for example a player or an NPC.
- `inflictor` (Entity) — Death inflictor.

[wiki](https://wiki.facepunch.com/gmod/GM:OnNPCKilled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/npc.lua#L74-L138)

---

### GM:OnPauseMenuBlockedTooManyTimes · Menu · `hook`
`GM:OnPauseMenuBlockedTooManyTimes()`

Called when the main menu has been blocked by [GM:OnPauseMenuShow](https://wiki.facepunch.com/gmod/GM:OnPauseMenuShow) four times in a small interval. This is used internally to explain to the user that they can hold  to force open the main menu.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPauseMenuBlockedTooManyTimes)

---

### GM:OnPauseMenuShow · Client · `hook`
`GM:OnPauseMenuShow() → boolean`

Called when the pause menu is attempting to be opened. Allows you to prevent the main menu from being opened that time.

	The user can hold  to not call this hook. If the main menu is blocked multiple times in short succession, a warning will be displayed to the end user on how to bypass the hook.

**Returns:**
- `ShouldOpen` (boolean) — Should the menu be allowed to open?

[wiki](https://wiki.facepunch.com/gmod/GM:OnPauseMenuShow)

---

### GM:OnPermissionsChanged · Menu · `hook`
`GM:OnPermissionsChanged()`

Called when a permission gets Granted or Revoked.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPermissionsChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/permissions.lua#L221-L227)

---

### GM:OnPhysgunFreeze · Server · `hook`
`GM:OnPhysgunFreeze(weapon: Entity, physobj: PhysObj, ent: Entity, ply: Player) → boolean`

Called when a player freezes an entity with the physgun.

**Arguments:**
- `weapon` (Entity) — The weapon that was used to freeze the entity.
- `physobj` (PhysObj) — Physics object of the entity.
- `ent` (Entity) — The target entity.
- `ply` (Player) — The player who tried to freeze the entity.

**Returns:**
- boolean — Return `false` to block the unfreeze.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPhysgunFreeze)

---

### GM:OnPhysgunPickup · Server · `hook`
`GM:OnPhysgunPickup(ply: Player, ent: Entity)`

Called to when a player has successfully picked up an entity with their Physics Gun.

Not to be confused with [GM:PhysgunPickup](https://wiki.facepunch.com/gmod/GM:PhysgunPickup) which is called to ask if the player should be able to pick up an entity.


See [GM:GravGunOnPickedUp](https://wiki.facepunch.com/gmod/GM:GravGunOnPickedUp) for the Gravity Gun pickup variant.
See [GM:OnPlayerPhysicsPickup](https://wiki.facepunch.com/gmod/GM:OnPlayerPhysicsPickup) for the player `+use` pickup variant.

**Arguments:**
- `ply` (Player) — The player that has picked up something using the physics gun.
- `ent` (Entity) — The entity that was picked up.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPhysgunPickup)

---

### GM:OnPhysgunReload · Server · `hook`
`GM:OnPhysgunReload(physgun: Weapon, ply: Player) → boolean`

Called when a player reloads with the physgun. Override this to disable default unfreezing behavior.

**Arguments:**
- `physgun` (Weapon) — The physgun in question
- `ply` (Player) — The player wielding the physgun

**Returns:**
- boolean — Whether the player can reload with the physgun or not

[wiki](https://wiki.facepunch.com/gmod/GM:OnPhysgunReload)

---

### GM:OnPlayerChangedTeam · Server · `hook` · `DEPRECATED`
`GM:OnPlayerChangedTeam(ply: Player, oldTeam: number, newTeam: number)`

Called when a player has changed team using [GM:PlayerJoinTeam](https://wiki.facepunch.com/gmod/GM:PlayerJoinTeam).

**Arguments:**
- `ply` (Player) — Player who has changed team
- `oldTeam` (number) — Index of the team the player was originally in
- `newTeam` (number) — Index of the team the player has changed to

> **Warning:** This hook will not work with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add) and it is only called manually from [GM:PlayerJoinTeam](https://wiki.facepunch.com/gmod/GM:PlayerJoinTeam) by the base gamemode

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerChangedTeam)

---

### GM:OnPlayerChat · Client · `hook`
`GM:OnPlayerChat(ply: Player, text: string, teamChat: boolean, isDead: boolean) → boolean`

Called whenever a player sends a chat message. For the serverside equivalent, see [GM:PlayerSay](https://wiki.facepunch.com/gmod/GM:PlayerSay).

**Arguments:**
- `ply` (Player) — The player
- `text` (string) — The message's text
- `teamChat` (boolean) — Is the player typing in team chat?
- `isDead` (boolean) — Is the player dead?

**Returns:**
- boolean — Should the message be suppressed?

> **Note:** The input (or suppression) of this hook is based on the output from [GM:PlayerSay](https://wiki.facepunch.com/gmod/GM:PlayerSay). Chat events suppressed serverside do not call this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerChat) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L142-L182)

---

### GM:OnPlayerHitGround · Shared · `hook` · `PREDICTED`
`GM:OnPlayerHitGround(player: Entity, inWater: boolean, onFloater: boolean, speed: number) → boolean`

Called when a player makes contact with the ground after a jump or a fall.

**Arguments:**
- `player` (Entity) — Player
- `inWater` (boolean) — Did the player land in water?
- `onFloater` (boolean) — Did the player land on an object floating in the water?
- `speed` (number) — The speed at which the player hit the ground

**Returns:**
- boolean — Return true to suppress default action

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerHitGround)

---

### GM:OnPlayerJump · Shared · `hook` · `PREDICTED`
`GM:OnPlayerJump(player: Entity, speed: number)`

Called when a player jumps.

**Arguments:**
- `player` (Entity) — Player
- `speed` (number) — The velocity/impulse of the jump

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerJump)

---

### GM:OnPlayerPhysicsDrop · Server · `hook`
`GM:OnPlayerPhysicsDrop(ply: Player, ent: Entity, thrown: boolean)`

Called when a player +use drops an entity.

**Arguments:**
- `ply` (Player) — The player that dropped the object
- `ent` (Entity) — The object that was dropped.
- `thrown` (boolean) — Whether the object was throw or simply let go of.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerPhysicsDrop)

---

### GM:OnPlayerPhysicsPickup · Server · `hook`
`GM:OnPlayerPhysicsPickup(ply: Player, ent: Entity)`

Called when a player +use pickups up an entity. This will be called after the entity passes though [GM:AllowPlayerPickup](https://wiki.facepunch.com/gmod/GM:AllowPlayerPickup).

See [GM:GravGunOnPickedUp](https://wiki.facepunch.com/gmod/GM:GravGunOnPickedUp) for the Gravity Gun pickup variant.
See [GM:OnPhysgunPickup](https://wiki.facepunch.com/gmod/GM:OnPhysgunPickup) for the Physics Gun pickup variant.

**Arguments:**
- `ply` (Player) — The player that picked up the object
- `ent` (Entity) — The object that was picked up.

[wiki](https://wiki.facepunch.com/gmod/GM:OnPlayerPhysicsPickup)

---

### GM:OnReloaded · Shared · `hook`
`GM:OnReloaded()`

Called when gamemode has been reloaded by auto refresh.

> **Note:** It seems that this event can be triggered more than once for a single refresh event.

[wiki](https://wiki.facepunch.com/gmod/GM:OnReloaded)

---

### GM:OnScreenSizeChanged · Client · `hook`
`GM:OnScreenSizeChanged(oldWidth: number, oldHeight: number, newWidth: number, newHeight: number)`

Called when the player's screen resolution of the game changes. This also called when changing MSAA settings.

[ScrW](https://wiki.facepunch.com/gmod/Global.ScrW) and [ScrH](https://wiki.facepunch.com/gmod/Global.ScrH) will return the new values when this hook is called.

**Arguments:**
- `oldWidth` (number) — The previous width of the game's window.
- `oldHeight` (number) — The previous height of the game's window.
- `newWidth` (number) — The new/current width of the game's window.
- `newHeight` (number) — The new/current height of the game's window.

[wiki](https://wiki.facepunch.com/gmod/GM:OnScreenSizeChanged)

---

### GM:OnSpawnMenuClose · Client · `hook`
`GM:OnSpawnMenuClose()`

Called when a player releases the `+menu` bind on their keyboard, which is bound to  by default.

[wiki](https://wiki.facepunch.com/gmod/GM:OnSpawnMenuClose)

---

### GM:OnSpawnMenuOpen · Client · `hook`
`GM:OnSpawnMenuOpen()`

Called when a player presses the `+menu` bind on their keyboard, which is bound to  by default.

[wiki](https://wiki.facepunch.com/gmod/GM:OnSpawnMenuOpen)

---

### GM:OnTextEntryGetFocus · Client · `hook`
`GM:OnTextEntryGetFocus(panel: Panel)`

Called when a [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) gets focus.

This hook is run from [DTextEntry:OnGetFocus](https://wiki.facepunch.com/gmod/DTextEntry:OnGetFocus) and [PANEL:OnMousePressed](https://wiki.facepunch.com/gmod/PANEL:OnMousePressed) of [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry).

**Arguments:**
- `panel` (Panel) — The panel that got focus

[wiki](https://wiki.facepunch.com/gmod/GM:OnTextEntryGetFocus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L354)

---

### GM:OnTextEntryLoseFocus · Client · `hook`
`GM:OnTextEntryLoseFocus(panel: Panel)`

Called when a [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) loses focus.

**Arguments:**
- `panel` (Panel) — The panel that lost focus

[wiki](https://wiki.facepunch.com/gmod/GM:OnTextEntryLoseFocus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L362)

---

### GM:OnUndo · Client · `hook`
`GM:OnUndo(name: string, customText: string) → boolean`

Called when the player undoes something.

**Arguments:**
- `name` (string) — The name of the undo action
- `customText` (string) — The custom text for the undo, set by undo.SetCustomUndoText

**Returns:**
- `suppress` (boolean) — Return false to suppress the undo notification.

[wiki](https://wiki.facepunch.com/gmod/GM:OnUndo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/cl_init.lua#L46-L74)

---

### GM:OnViewModelChanged · Shared · `hook`
`GM:OnViewModelChanged(viewmodel: Entity, oldModel: string, newModel: string)`

Called when the player changes their weapon to another one - and their viewmodel model changes.

**Arguments:**
- `viewmodel` (Entity) — The viewmodel that is changing
- `oldModel` (string) — The old model
- `newModel` (string) — The new model

> **Bug** ([#2473](https://github.com/Facepunch/garrysmod/issues/2473)): This is not always called clientside.

[wiki](https://wiki.facepunch.com/gmod/GM:OnViewModelChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L251-L258)

---

### GM:PhysgunDrop · Shared · `hook`
`GM:PhysgunDrop(player: Player, entity: Entity)`

Called when a player drops an entity with the Physgun.

See [GM:GravGunOnDropped](https://wiki.facepunch.com/gmod/GM:GravGunOnDropped) for the Gravity Gun drop variant.

**Arguments:**
- `player` (Player) — The player who dropped an entity
- `entity` (Entity) — The dropped entity

[wiki](https://wiki.facepunch.com/gmod/GM:PhysgunDrop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L70-L71)

---

### GM:PhysgunPickup · Shared · `hook` · `PREDICTED`
`GM:PhysgunPickup(player: Player, entity: Entity) → boolean`

Called to determine if a player should be able to pick up an entity with the Physics Gun.

See [GM:OnPhysgunPickup](https://wiki.facepunch.com/gmod/GM:OnPhysgunPickup) for a hook which is called when a player has successfully picked up an entity.

See [GM:GravGunPickupAllowed](https://wiki.facepunch.com/gmod/GM:GravGunPickupAllowed) for the Gravity Gun pickup variant.
See [GM:AllowPlayerPickup](https://wiki.facepunch.com/gmod/GM:AllowPlayerPickup) for the `+USE` pickup variant.

**Arguments:**
- `player` (Player) — The player that is picking up using the Physics Gun.
- `entity` (Entity) — The entity that is being picked up.

**Returns:**
- boolean — Returns whether the player can pick up the entity or not.

[wiki](https://wiki.facepunch.com/gmod/GM:PhysgunPickup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L58-L64)

---

### GM:PlayerAmmoChanged · Shared · `hook`
`GM:PlayerAmmoChanged(ply: Player, ammoID: number, oldCount: number, newCount: number)`

Called after player's reserve ammo count changes.

**Arguments:**
- `ply` (Player) — The player whose ammo is being affected.
- `ammoID` (number) — The ammo type ID.
- `oldCount` (number) — The old ammo count.
- `newCount` (number) — The new ammo count.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerAmmoChanged)

---

### GM:PlayerAuthed · Server · `hook`
`GM:PlayerAuthed(ply: Player, steamid: string, uniqueid: string)`

Called after the player gets their [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) set for the first time. This hook will also be called in singleplayer.

See [GM:NetworkIDValidated](https://wiki.facepunch.com/gmod/GM:NetworkIDValidated) for a hook that is called with the player's SteamID is validated by Steam.

**Arguments:**
- `ply` (Player) — The player
- `steamid` (string) — The player's SteamID.
- `uniqueid` (string) — The player's UniqueID.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerAuthed)

---

### GM:PlayerBindPress · Client · `hook`
`GM:PlayerBindPress(ply: Player, bind: string, pressed: boolean, code: number) → boolean`

Runs when a bind has been pressed. Allows to block commands.

**Arguments:**
- `ply` (Player) — The player who used the command; this will always be equal to LocalPlayer.
- `bind` (string) — The bind command.
- `pressed` (boolean) — If the bind was activated or deactivated.
- `code` (number, enum [BUTTON_CODE](https://wiki.facepunch.com/gmod/Enums/BUTTON_CODE)) — The button code.

**Returns:**
- boolean — Return `true` to prevent the bind.

> **Note:** By using the "alias" console command, this hook can be effectively circumvented. To prevent this use [input.TranslateAlias](https://wiki.facepunch.com/gmod/input.TranslateAlias).
> 
> To stop the user from using `+attack`, `+left` and any other movement commands of the sort, please look into using [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand) instead.
> **Bug** ([#1176](https://github.com/Facepunch/garrysmod/issues/1176)): The third argument will always be true.
> **Bug** ([#2888](https://github.com/Facepunch/garrysmod/issues/2888)): This does not run for function keys binds (F1-F12).

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerBindPress)

---

### GM:PlayerButtonDown · Shared · `hook` · `PREDICTED`
`GM:PlayerButtonDown(ply: Player, button: number{BUTTON_CODE})`

Called when a player presses a button.

This will not be called if player has a panel opened with keyboard input enabled, use [PANEL:OnKeyCodePressed](https://wiki.facepunch.com/gmod/PANEL:OnKeyCodePressed) instead.

See [GM:KeyPress](https://wiki.facepunch.com/gmod/GM:KeyPress) for an alternative that uses [IN](https://wiki.facepunch.com/gmod/Enums/IN).
See [GM:PlayerButtonUp](https://wiki.facepunch.com/gmod/GM:PlayerButtonUp) for the "key release" event.

**Arguments:**
- `ply` (Player) — Player who pressed the button
- `button` (number{BUTTON_CODE}) — The button, see BUTTON_CODE

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerButtonDown)

---

### GM:PlayerButtonUp · Shared · `hook` · `PREDICTED`
`GM:PlayerButtonUp(ply: Player, button: number{BUTTON_CODE})`

Called when a player releases a button.

This will not be called if player has a panel opened with keyboard input enabled, use [PANEL:OnKeyCodeReleased](https://wiki.facepunch.com/gmod/PANEL:OnKeyCodeReleased) instead.

See [GM:KeyRelease](https://wiki.facepunch.com/gmod/GM:KeyRelease) for an alternative that uses [IN](https://wiki.facepunch.com/gmod/Enums/IN).
See [GM:PlayerButtonDown](https://wiki.facepunch.com/gmod/GM:PlayerButtonDown) for the "key press" event.

**Arguments:**
- `ply` (Player) — Player who released the button
- `button` (number{BUTTON_CODE}) — The button, see BUTTON_CODE

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerButtonUp)

---

### GM:PlayerCanHearPlayersVoice · Server · `hook`
`GM:PlayerCanHearPlayersVoice(listener: Player, talker: Player) → boolean, boolean`

Decides whether a player can hear another player using voice chat.

**Arguments:**
- `listener` (Player) — The listening player.
- `talker` (Player) — The talking player.

**Returns:**
- boolean — Return `true` if the listener should hear the talker, `false` if they shouldn't.
- boolean — 3D sound.

> **Warning:** This hook is called **players count * speaking players count** times every 0.3 seconds if at least 1 player is talking or every 5 seconds if no one is talking.
> 	You should ensure that your code is efficient, or this will definitely influence performance.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCanHearPlayersVoice) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L754-L761)

---

### GM:PlayerCanJoinTeam · Server · `hook`
`GM:PlayerCanJoinTeam(ply: Player, team: number) → boolean`

Returns whether or not a player is allowed to join a team

**Arguments:**
- `ply` (Player) — Player attempting to switch teams
- `team` (number) — Index of the team

**Returns:**
- boolean — Allowed to switch

> **Warning:** This hook will not work with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add) and it is only called manually from [GM:PlayerJoinTeam](https://wiki.facepunch.com/gmod/GM:PlayerJoinTeam) by the base gamemode

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCanJoinTeam)

---

### GM:PlayerCanPickupItem · Server · `hook`
`GM:PlayerCanPickupItem(ply: Player, item: Entity) → boolean`

Returns whether or not a player is allowed to pick an item up. (ammo, health, armor)

This will typically only work for base game entities, unless mod authors that implement similar entities also manually call this hook.

See [GM:PlayerCanPickupWeapon](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupWeapon) for a hook that controls weapon pickups.

**Arguments:**
- `ply` (Player) — Player attempting to pick up
- `item` (Entity) — The item the player is attempting to pick up

**Returns:**
- boolean — Allow pick up

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupItem)

---

### GM:PlayerCanPickupWeapon · Server · `hook`
`GM:PlayerCanPickupWeapon(ply: Player, weapon: Weapon) → boolean`

Returns whether or not a player is allowed to pick up a weapon.

 	If this returns `false`, [Player:Give](https://wiki.facepunch.com/gmod/Player:Give) won't work.

See [GM:PlayerCanPickupItem](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupItem) for a hook that affects things like health kits, armor batteries and ammo entities.

See [GM:WeaponEquip](https://wiki.facepunch.com/gmod/GM:WeaponEquip) for a hook that is called when a player successfully picks up a weapon after passing this hook.

**Arguments:**
- `ply` (Player) — The player attempting to pick up the weapon.
- `weapon` (Weapon) — The weapon entity in question.

**Returns:**
- boolean — `false` to disallow pickup.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupWeapon)

---

### GM:PlayerCanSeePlayersChat · Server · `hook`
`GM:PlayerCanSeePlayersChat(text: string, teamOnly: boolean, listener: Player, speaker: Player) → boolean`

Returns whether or not the player can see the other player's chat.

**Arguments:**
- `text` (string) — The chat text
- `teamOnly` (boolean) — If the message is team-only
- `listener` (Player) — The player receiving the message
- `speaker` (Player) — The player sending the message.

**Returns:**
- boolean — Can see other player's chat

> **Note:** The **speaker** parameter does not have to be a valid [Player](https://wiki.facepunch.com/gmod/Player) object which happens when console messages are displayed for example.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCanSeePlayersChat) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L763-L776)

---

### GM:PlayerChangedTeam · Server · `hook`
`GM:PlayerChangedTeam(ply: Player, oldTeam: number, newTeam: number)`

Called when a player has changed team using [Player:SetTeam](https://wiki.facepunch.com/gmod/Player:SetTeam).

**Arguments:**
- `ply` (Player) — Player whose team has changed.
- `oldTeam` (number) — Index of the team the player was originally in.
- `newTeam` (number) — Index of the team the player has changed to.

> **Warning:** [Player:Team](https://wiki.facepunch.com/gmod/Player:Team) inside this hook will return `oldTeam`.
> **Warning:** Avoid calling [Player:SetTeam](https://wiki.facepunch.com/gmod/Player:SetTeam) in this hook as it may cause an infinite loop!

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerChangedTeam)

---

### GM:PlayerCheckLimit · Shared · `hook`
`GM:PlayerCheckLimit(ply: Player, limitName: string, current: number, defaultMax: number) → boolean`

Called whenever a player is about to spawn something to see if they hit a limit for whatever they are spawning.

**Arguments:**
- `ply` (Player) — The player who is trying to spawn something.
- `limitName` (string) — The limit's name.
- `current` (number) — The amount of whatever player is trying to spawn that the player already has spawned.
- `defaultMax` (number) — The default maximum count, as dictated by the `sbox_max

**Returns:**
- boolean — Return `false` to indicate the limit was hit, or nothing otherwise

> **Note:** This hook will not be called in singleplayer, as singleplayer does not have limits.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerCheckLimit)

---

### GM:PlayerClassChanged · Client · `hook` · `INTERNAL`
`GM:PlayerClassChanged(ply: Player, newID: number)`

Called whenever a player's class is changed on the server-side with [player_manager.SetPlayerClass](https://wiki.facepunch.com/gmod/player_manager.SetPlayerClass).

**Arguments:**
- `ply` (Player) — The player whose class has been changed.
- `newID` (number) — The network ID of the player class's name string, or `0` if we are clearing a player class from the player.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerClassChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L680-L695)

---

### GM:PlayerConnect · Shared · `hook`
`GM:PlayerConnect(name: string, ip: string)`

Executes when a player connects to the server. Called before the player has been assigned a [UserID](https://wiki.facepunch.com/gmod/Player:UserID) and entity. See the [player_connect](https://wiki.facepunch.com/gmod/gameevent/player_connect) gameevent for a version of this hook called after the player entity has been created.

**Arguments:**
- `name` (string) — The player's name.
- `ip` (string) — The player's IP address.

> **Note:** This is not called clientside for the local player.
> **Note:** This is only called clientside for listen server hosts.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerConnect)

---

### GM:PlayerDeath · Server · `hook`
`GM:PlayerDeath(victim: Player, inflictor: Entity, attacker: Entity)`

Called when a player is killed by [Player:Kill](https://wiki.facepunch.com/gmod/Player:Kill) or any other normal means.

This hook is **not** called if the player is killed by [Player:KillSilent](https://wiki.facepunch.com/gmod/Player:KillSilent). See [GM:PlayerSilentDeath](https://wiki.facepunch.com/gmod/GM:PlayerSilentDeath) for that.

* [GM:DoPlayerDeath](https://wiki.facepunch.com/gmod/GM:DoPlayerDeath) is called **before** this hook.
* [GM:PostPlayerDeath](https://wiki.facepunch.com/gmod/GM:PostPlayerDeath) is called **after** this hook.

See [Player:LastHitGroup](https://wiki.facepunch.com/gmod/Player:LastHitGroup) if you need to get the last hit hitgroup of the player.

**Arguments:**
- `victim` (Player) — The player who died
- `inflictor` (Entity) — Item used to kill the victim
- `attacker` (Entity) — Player or entity that killed the victim

> **Note:** [Player:Alive](https://wiki.facepunch.com/gmod/Player:Alive) will return false in this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDeath)

---

### GM:PlayerDeathSound · Server · `hook`
`GM:PlayerDeathSound(ply: Player) → boolean`

Returns whether or not the default death sound should be muted.

**Arguments:**
- `ply` (Player) — The player

**Returns:**
- boolean — Mute death sound

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDeathSound)

---

### GM:PlayerDeathThink · Server · `hook`
`GM:PlayerDeathThink(ply: Player) → boolean`

Called every think while the player is dead. The return value will determine if the player respawns.

Overwriting this function will prevent players from respawning by pressing space or clicking.

**Arguments:**
- `ply` (Player) — The player affected in the hook.

**Returns:**
- boolean — Return a non-nil value to prevent the current gamemode from handling this event.

> **Bug** ([#1577](https://github.com/Facepunch/garrysmod/issues/1577)): This hook is not called for players with the [FL_FROZEN](https://wiki.facepunch.com/gmod/Enums/FL) flag applied.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDeathThink)

---

### GM:PlayerDisconnected · Server · `hook`
`GM:PlayerDisconnected(ply: Player)`

Called when a player leaves the server. See the [player_disconnect gameevent](https://wiki.facepunch.com/gmod/gameevent/player_disconnect) for a shared version of this hook.

**Arguments:**
- `ply` (Player) — the player

> **Bug** ([#3523](https://github.com/Facepunch/garrysmod/issues/3523)): This is not called in single-player or listen servers for the host.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDisconnected)

---

### GM:PlayerDriveAnimate · Shared · `hook`
`GM:PlayerDriveAnimate(ply: Player)`

Called to update the player's animation during a drive.

**Arguments:**
- `ply` (Player) — The driving player

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDriveAnimate)

---

### GM:PlayerDroppedWeapon · Server · `hook`
`GM:PlayerDroppedWeapon(owner: Player|NPC, wep: Weapon)`

Called when a weapon is dropped by a player via [Player:DropWeapon](https://wiki.facepunch.com/gmod/Player:DropWeapon). Despite its name, this hook is also called for NPC weapon drops.

Also called when a weapon is removed from a player via [Player:StripWeapon](https://wiki.facepunch.com/gmod/Player:StripWeapon).

See also [GM:WeaponEquip](https://wiki.facepunch.com/gmod/GM:WeaponEquip) for a hook when a player picks up a weapon.

The weapon's [Entity:GetOwner](https://wiki.facepunch.com/gmod/Entity:GetOwner) will be NULL at the time this hook is called.

[WEAPON:OnDrop](https://wiki.facepunch.com/gmod/WEAPON:OnDrop) will be called before this hook is.

**Arguments:**
- `owner` (Player|NPC) — The player or NPC who owned this weapon before it was dropped.
- `wep` (Weapon) — The weapon that was dropped.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerDroppedWeapon)

---

### GM:PlayerEndVoice · Client · `hook`
`GM:PlayerEndVoice(ply: Player)`

Called when player stops using voice chat.

**Arguments:**
- `ply` (Player) — Player who stopped talking

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerEndVoice)

---

### GM:PlayerEnteredVehicle · Server · `hook`
`GM:PlayerEnteredVehicle(ply: Player, veh: Vehicle, role: number)`

Called when a player enters a vehicle.

Called just after [GM:CanPlayerEnterVehicle](https://wiki.facepunch.com/gmod/GM:CanPlayerEnterVehicle).

See also [GM:PlayerLeaveVehicle](https://wiki.facepunch.com/gmod/GM:PlayerLeaveVehicle).

**Arguments:**
- `ply` (Player) — Player who entered vehicle.
- `veh` (Vehicle) — Vehicle the player entered.
- `role` (number) — The seat number.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerEnteredVehicle)

---

### GM:PlayerFireAnimationEvent · Client · `hook`
`GM:PlayerFireAnimationEvent(ply: Player, pos: Vector, ang: Angle, event: number, name: string) → boolean`

Called before firing clientside animation events on a player model.

See [GM:PlayerHandleAnimEvent](https://wiki.facepunch.com/gmod/GM:PlayerHandleAnimEvent) for the serverside version.

**Arguments:**
- `ply` (Player) — The player who has triggered the event.
- `pos` (Vector) — Position of the effect
- `ang` (Angle) — Angle of the effect
- `event` (number) — The event ID of happened even.
- `name` (string) — Name of the event

**Returns:**
- boolean — Return true to disable the effect

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerFireAnimationEvent)

---

### GM:PlayerFootstep · Shared · `hook`
`GM:PlayerFootstep(ply: Player, pos: Vector, foot: number, sound: string, volume: number, filter: CRecipientFilter) → boolean`

Called whenever a player steps. Return true to mute the normal sound.

See [GM:PlayerStepSoundTime](https://wiki.facepunch.com/gmod/GM:PlayerStepSoundTime) for a related hook about footstep frequency.

**Arguments:**
- `ply` (Player) — The stepping player
- `pos` (Vector) — The position of the step
- `foot` (number) — Foot that is stepped.
- `sound` (string) — Sound that is going to play
- `volume` (number) — Volume of the footstep
- `filter` (CRecipientFilter) — The Recipient filter of players who can hear the footstep

**Returns:**
- boolean — Prevent default step sound

> **Note:** This hook is called on all clients.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerFootstep)

---

### GM:PlayerFrozeObject · Server · `hook`
`GM:PlayerFrozeObject(ply: Player, ent: Entity, physobj: PhysObj)`

Called when a player freezes an object.

**Arguments:**
- `ply` (Player) — Player who has frozen an object
- `ent` (Entity) — The frozen object
- `physobj` (PhysObj) — The frozen physics object of the frozen entity ( For ragdolls )

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerFrozeObject)

---

### GM:PlayerHandleAnimEvent · Server · `hook`
`GM:PlayerHandleAnimEvent(ply: Player, event: number, eventTime: number, cycle: number, type: number, options: string)`

Called before firing serverside animation events on the player models.

See [GM:PlayerFireAnimationEvent](https://wiki.facepunch.com/gmod/GM:PlayerFireAnimationEvent) for the clientside version.

**Arguments:**
- `ply` (Player) — The player who has triggered the event.
- `event` (number) — The event ID of happened even.
- `eventTime` (number) — The absolute time this event occurred using CurTime.
- `cycle` (number) — The frame this event occurred as a number between 0 and 1.
- `type` (number) — Event type.
- `options` (string) — Name or options of this event.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerHandleAnimEvent)

---

### GM:PlayerHurt · Server · `hook`
`GM:PlayerHurt(victim: Player, attacker: Entity, healthRemaining: number, damageTaken: number)`

Called when a player gets hurt.

**Arguments:**
- `victim` (Player) — Victim
- `attacker` (Entity) — Attacker Entity
- `healthRemaining` (number) — Remaining Health
- `damageTaken` (number) — Damage Taken

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerHurt)

---

### GM:PlayerInitialSpawn · Server · `hook`
`GM:PlayerInitialSpawn(player: Player, transition: boolean)`

Called when the player spawns for the first time.

See [GM:PlayerSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSpawn) for a hook called every player spawn.

**Arguments:**
- `player` (Player) — The player who spawned.
- `transition` (boolean) — If `true`, the player just spawned from a map transition.

> **Note:** This hook is called before the player has fully loaded, when the player is still in seeing the `Starting Lua` screen. For example, trying to use the [Entity:GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel) function will return the default model (`models/player.mdl`).
> **Warning:** Sending [net](https://wiki.facepunch.com/gmod/net) messages to the spawned player in this hook may cause them to be received before the player finishes loading, for example [LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer) might return NULL since [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) may have not been called yet clientside though the net message **won't** be lost and the client still should receive it (more information here: https://github.com/Facepunch/garrysmod-requests/issues/718).
> 
> Workaround without networking:
> ```lua
> local load_queue = {}
> 
> hook.Add( "PlayerInitialSpawn", "myAddonName/Load", function( ply )
> 	load_queue[ ply ] = true
> end )
> 
> hook.Add( "StartCommand", "myAddonName/Load", function( ply, cmd )
> 	if load_queue[ ply ] and not cmd:IsForced() then
> 		load_queue[ ply ] = nil
> 
> 		-- Send what you need here if it requires the client to be fully loaded!
> 	end
> end )
> ```
> 
> 
> With networking:
> ```lua
> -- CLIENT
> hook.Add( "InitPostEntity", "Ready", function()
> 	net.Start( "cool_addon_client_ready" )
> 	net.SendToServer()
> end )
> ```
> ```lua
> -- SERVER
> util.AddNetworkString( "cool_addon_client_ready" )
> 
> net.Receive( "cool_addon_client_ready", function( len, ply )
> 	-- Send what you need here!
> end )
> ```

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerInitialSpawn)

---

### GM:PlayerJoinTeam · Server · `hook`
`GM:PlayerJoinTeam(ply: Player, team: number)`

Makes the player join a specified team. This is a convenience function that calls [Player:SetTeam](https://wiki.facepunch.com/gmod/Player:SetTeam) and runs the [GM:OnPlayerChangedTeam](https://wiki.facepunch.com/gmod/GM:OnPlayerChangedTeam) hook.

**Arguments:**
- `ply` (Player) — Player to force
- `team` (number) — The team to put player into

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerJoinTeam)

---

### GM:PlayerLeaveVehicle · Server · `hook`
`GM:PlayerLeaveVehicle(ply: Player, veh: Vehicle)`

Called when a player leaves a vehicle for any reason, including [Player:ExitVehicle](https://wiki.facepunch.com/gmod/Player:ExitVehicle). 

See [GM:PlayerEnteredVehicle](https://wiki.facepunch.com/gmod/GM:PlayerEnteredVehicle) for the opposite hook.

**Arguments:**
- `ply` (Player) — Player who left a vehicle.
- `veh` (Vehicle) — Vehicle the player left.

> **Note:** For vehicles with exit animations, this will be called **at the end** of the animation, **not at the start**!

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerLeaveVehicle)

---

### GM:PlayerLoadout · Server · `hook`
`GM:PlayerLoadout(ply: Player)`

Called to give players the default set of weapons.

**Arguments:**
- `ply` (Player) — Player to give weapons to.

> **Note:** This function may not work in your custom gamemode if you have overridden your [GM:PlayerSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSpawn) and you do not use self.BaseClass.PlayerSpawn or [hook.Call](https://wiki.facepunch.com/gmod/hook.Call).

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerLoadout)

---

### GM:PlayerNoClip · Shared · `hook` · `PREDICTED`
`GM:PlayerNoClip(ply: Player, desiredState: boolean) → boolean`

Called when a player tries to switch noclip mode. 

[MOVETYPE_NOCLIP](https://wiki.facepunch.com/gmod/Enums/MOVETYPE#MOVETYPE_NOCLIP) can be used to determine if a player is currently in noclip mode.

**Arguments:**
- `ply` (Player) — The person who entered/exited noclip
- `desiredState` (boolean) — Represents the noclip state (on/off) the user will enter if this hook allows them to.

**Returns:**
- boolean — Return false to disallow the switch.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerNoClip)

---

### GM:PlayerPostThink · Shared · `hook` · `PREDICTED`
`GM:PlayerPostThink(ply: Player)`

Called after the player's think, just after [GM:FinishMove](https://wiki.facepunch.com/gmod/GM:FinishMove).

**Arguments:**
- `ply` (Player) — The player

> **Note:** On the client side, it is only called for the local player.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerPostThink)

---

### GM:PlayerRequestTeam · Server · `hook`
`GM:PlayerRequestTeam(ply: Player, team: number)`

Request a player to join the team. This function will check if the team is available to join or not.

This hook is called when the player runs "changeteam" in the console.

To prevent the player from changing teams, see [GM:PlayerCanJoinTeam](https://wiki.facepunch.com/gmod/GM:PlayerCanJoinTeam)

**Arguments:**
- `ply` (Player) — The player to try to put into a team
- `team` (number) — Team to put the player into if the checks succeeded

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerRequestTeam)

---

### GM:PlayerSay · Server · `hook`
`GM:PlayerSay(sender: Player, text: string, teamChat: boolean) → string`

Called when a player dispatched a chat message. For the clientside equivalent, see [GM:OnPlayerChat](https://wiki.facepunch.com/gmod/GM:OnPlayerChat).

**Arguments:**
- `sender` (Player) — The player which sent the message.
- `text` (string) — The message's content.
- `teamChat` (boolean) — Return false when the message is for everyone, true when the message is for the sender's team.

**Returns:**
- string — What to show instead of original text.

> **Note:** It may be more reliable to use [gameevent/player_say](https://wiki.facepunch.com/gmod/gameevent/player_say) to read messages serverside because addons commonly return values in this hook to change chat messages.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSay)

---

### GM:PlayerSelectSpawn · Server · `hook`
`GM:PlayerSelectSpawn(ply: Player, transition: boolean) → Entity`

Called to determine a spawn point for a player to spawn at.

**Arguments:**
- `ply` (Player) — The player who needs a spawn point
- `transition` (boolean) — If true, the player just spawned from a map transition (`trigger_changelevel`).

**Returns:**
- Entity — The spawn point entity to spawn the player at

> **Note:** The spawn point entity will also impact the player's eye angle. For example, if the entity is upside down, the player's view will be as well.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSelectSpawn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L360-L495)

---

### GM:PlayerSelectTeamSpawn · Server · `hook`
`GM:PlayerSelectTeamSpawn(team: number, ply: Player) → Entity`

Find a team spawn point entity for this player.

**Arguments:**
- `team` (number) — Players team
- `ply` (Player) — The player

**Returns:**
- Entity — The entity to use as a spawn point.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSelectTeamSpawn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L301-L323)

---

### GM:PlayerSetHandsModel · Server · `hook`
`GM:PlayerSetHandsModel(ply: Player, ent: Entity)`

Called whenever view model hands needs setting a model. By default this calls [PLAYER:GetHandsModel](https://wiki.facepunch.com/gmod/PLAYER:GetHandsModel) and if that fails, sets the hands model according to his player model.

**Arguments:**
- `ply` (Player) — The player whose hands needs a model set
- `ent` (Entity) — The hands to set model of

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSetHandsModel)
