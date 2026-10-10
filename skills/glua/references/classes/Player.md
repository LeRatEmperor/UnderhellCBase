# Player

**Realm:** Shared  ·  **Members:** 270

This is a list of all methods only available for players. It is also possible to call [Entity](https://wiki.facepunch.com/gmod/Entity) functions on the Player.

[wiki page](https://wiki.facepunch.com/gmod/Player)

> **Part 1 of 2** (`AccountID` – `SprayDecal`). All parts: [1](Player.md), [2](Player-2.md)


### Player:AccountID · Shared
`Player:AccountID() → number`

Returns the player's AccountID part of their full SteamID.

Since this does not include other vital parts of the SteamID such as "Account Type" and "Account Instance", it should be avoided, as AccountIDs are finite, and can theoretically be the same for multiple valid accounts.

See [Player:SteamID](https://wiki.facepunch.com/gmod/Player:SteamID) for the text representation of the full SteamID.
See [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) for a 64bit representation of the full SteamID.

**Returns:**
- number — The AccountID of Player's SteamID.

> **Note:** In a `-multirun` environment, this will return `-1` for all "copies" of a player because they are not authenticated with Steam.
> 
> For bots this will return values starting with `0` for the first bot, `1` for the second bot and so on.

[wiki](https://wiki.facepunch.com/gmod/Player:AccountID)

---

### Player:AddCleanup · Server
`Player:AddCleanup(type: string, ent: Entity)`

Adds an entity to the player's clean up list. This uses [cleanup.Add](https://wiki.facepunch.com/gmod/cleanup.Add) internally.

**Arguments:**
- `type` (string) — The Cleanup type for this Entity.
- `ent` (Entity) — The Entity to add.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Player:AddCleanup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L107-L111)

---

### Player:AddCount · Shared
`Player:AddCount(str: string, ent: Entity)`

Adds an entity to the player's list of entities of the same type. See [Player:GetCount](https://wiki.facepunch.com/gmod/Player:GetCount) to get the current count of entities of an entity type added with this function.

**Arguments:**
- `str` (string) — The type of this Entity.
- `ent` (Entity) — The Entity you want to add to the list.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Player:AddCount) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L72-L91)

---

### Player:AddDeaths · Server
`Player:AddDeaths(count: number)`

Adds the provided amount to the player's death count.

**Arguments:**
- `count` (number) — The amount to add to the death count.

[wiki](https://wiki.facepunch.com/gmod/Player:AddDeaths)

---

### Player:AddFrags · Server
`Player:AddFrags(count: number)`

Adds the provided amount to the player's frag/kill count.

**Arguments:**
- `count` (number) — The amount to add.

[wiki](https://wiki.facepunch.com/gmod/Player:AddFrags)

---

### Player:AddFrozenPhysicsObject · Server
`Player:AddFrozenPhysicsObject(ent: Entity, physobj: PhysObj)`

Adds an entity to the player's list of frozen objects.

**Arguments:**
- `ent` (Entity) — The Entity to add.
- `physobj` (PhysObj) — The physics object of the Entity.

[wiki](https://wiki.facepunch.com/gmod/Player:AddFrozenPhysicsObject) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L9-L30)

---

### Player:AddPlayerOption · Client
`Player:AddPlayerOption(name: string, timeout: number, vote_callback: function, draw_callback: function)`

Sets up the voting system for the player.
This is a really barebone system. By calling this a vote gets started, when the player presses 0-9 the callback function gets called along with the key the player pressed. Use the draw callback to draw the vote panel.

**Arguments:**
- `name` (string) — Name of the vote
- `timeout` (number) — Time until the vote expires
- `vote_callback` (function) — The function to be run when the player presses 0-9 while a vote is active.
- `draw_callback` (function) — Used to draw the vote panel.

[wiki](https://wiki.facepunch.com/gmod/Player:AddPlayerOption) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/player.lua#L21-L39)

---

### Player:AddVCDSequenceToGestureSlot · Shared
`Player:AddVCDSequenceToGestureSlot(slot: number, sequenceId: number, cycle: number, autokill: boolean = false)`

Plays a sequence directly from a sequence number, similar to [Player:AnimRestartGesture](https://wiki.facepunch.com/gmod/Player:AnimRestartGesture). This function has the advantage to play sequences that haven't been bound to an existing [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)

**Arguments:**
- `slot` (number, enum [GESTURE_SLOT](https://wiki.facepunch.com/gmod/Enums/GESTURE_SLOT)) — Gesture slot using GESTURE_SLOT
- `sequenceId` (number) — The sequence ID to play, can be retrieved with Entity:LookupSequence.
- `cycle` (number) — The cycle to start the animation at, ranges from 0 to 1.
- `autokill` (boolean, default `false`) — If the animation should not loop.

> **Warning:** This is not automatically networked. This function has to be called on the client to be seen by said client.

[wiki](https://wiki.facepunch.com/gmod/Player:AddVCDSequenceToGestureSlot)

---

### Player:Alive · Shared
`Player:Alive() → boolean`

Checks if the player is alive. 

Player specific implementation of [Entity:Alive](https://wiki.facepunch.com/gmod/Entity:Alive), the value is synchronized to the client.

**Returns:**
- boolean — Whether the player is alive

[wiki](https://wiki.facepunch.com/gmod/Player:Alive)

---

### Player:AllowFlashlight · Shared
`Player:AllowFlashlight(canFlashlight: boolean)`

Sets if the player can toggle their flashlight. Function exists on both the server and client but has no effect when ran on the client.

This is a Lua method that internally uses [GM:PlayerSwitchFlashlight](https://wiki.facepunch.com/gmod/GM:PlayerSwitchFlashlight). If current gamemode overwrites that hook and doesn't respect [Player:CanUseFlashlight](https://wiki.facepunch.com/gmod/Player:CanUseFlashlight), this function will not have any effect.

**Arguments:**
- `canFlashlight` (boolean) — True allows flashlight toggling

[wiki](https://wiki.facepunch.com/gmod/Player:AllowFlashlight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L182)

---

### Player:AllowImmediateDecalPainting · Server
`Player:AllowImmediateDecalPainting(allow: boolean)`

Lets the player spray their decal without delay

**Arguments:**
- `allow` (boolean) — Allow or disallow

[wiki](https://wiki.facepunch.com/gmod/Player:AllowImmediateDecalPainting)

---

### Player:AnimResetGestureSlot · Shared
`Player:AnimResetGestureSlot(slot: number)`

Resets player gesture in selected slot.

**Arguments:**
- `slot` (number, enum [GESTURE_SLOT](https://wiki.facepunch.com/gmod/Enums/GESTURE_SLOT)) — Slot to reset.

[wiki](https://wiki.facepunch.com/gmod/Player:AnimResetGestureSlot)

---

### Player:AnimRestartGesture · Shared
`Player:AnimRestartGesture(slot: number, activity: number, autokill: boolean = false)`

Restart a gesture on a player, within a gesture slot.

**Arguments:**
- `slot` (number, enum [GESTURE_SLOT](https://wiki.facepunch.com/gmod/Enums/GESTURE_SLOT)) — Gesture slot using GESTURE_SLOT
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity ( see ACT ) or sequence that should be played
- `autokill` (boolean, default `false`) — Whether the animation should be automatically stopped.

> **Warning:** This is not automatically networked. This function has to be called on the client to be seen by said client.

[wiki](https://wiki.facepunch.com/gmod/Player:AnimRestartGesture)

---

### Player:AnimRestartMainSequence · Shared
`Player:AnimRestartMainSequence()`

Restarts the main animation on the player, has the same effect as calling [Entity:SetCycle](https://wiki.facepunch.com/gmod/Entity:SetCycle)( 0 ).

[wiki](https://wiki.facepunch.com/gmod/Player:AnimRestartMainSequence)

---

### Player:AnimSetGestureSequence · Shared
`Player:AnimSetGestureSequence(slot: number, sequenceID: number)`

Sets the sequence of the animation playing in the given gesture slot.

**Arguments:**
- `slot` (number, enum [GESTURE_SLOT](https://wiki.facepunch.com/gmod/Enums/GESTURE_SLOT)) — The gesture slot.
- `sequenceID` (number) — Sequence ID to set.

[wiki](https://wiki.facepunch.com/gmod/Player:AnimSetGestureSequence)

---

### Player:AnimSetGestureWeight · Shared
`Player:AnimSetGestureWeight(slot: number, weight: number)`

Sets the weight of the animation playing in the given gesture slot.

**Arguments:**
- `slot` (number, enum [GESTURE_SLOT](https://wiki.facepunch.com/gmod/Enums/GESTURE_SLOT)) — The gesture slot.
- `weight` (number) — The weight this slot should be set to.

[wiki](https://wiki.facepunch.com/gmod/Player:AnimSetGestureWeight)

---

### Player:Armor · Shared
`Player:Armor() → number`

Returns the player's armor.

**Returns:**
- number — The player's armor.

[wiki](https://wiki.facepunch.com/gmod/Player:Armor)

---

### Player:Ban · Server
`Player:Ban(minutes: number, kick: boolean = false)`

Bans the player from the server for a certain amount of minutes.

**Arguments:**
- `minutes` (number) — Duration of the ban in minutes (0 is permanent)
- `kick` (boolean, default `false`) — Whether to kick the player after banning them or not

[wiki](https://wiki.facepunch.com/gmod/Player:Ban)

---

### Player:CanUseFlashlight · Shared
`Player:CanUseFlashlight() → boolean`

Returns true if the player's flashlight hasn't been disabled by [Player:AllowFlashlight](https://wiki.facepunch.com/gmod/Player:AllowFlashlight).

**Returns:**
- boolean — Whether the player can use flashlight.

> **Note:** This is not synchronized between clients and server automatically!

[wiki](https://wiki.facepunch.com/gmod/Player:CanUseFlashlight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L183)

---

### Player:ChatPrint · Shared
`Player:ChatPrint(message: string)`

Prints a string to the chatbox of the client.

**Arguments:**
- `message` (string) — String to be printed

> **Warning:** Just like the [usermessage](https://wiki.facepunch.com/gmod/usermessage), this function is affected by the 255 byte limit!

[wiki](https://wiki.facepunch.com/gmod/Player:ChatPrint)

---

### Player:CheckLimit · Shared
`Player:CheckLimit(str: string) → boolean`

Checks if the limit of an entity type added by [Player:AddCount](https://wiki.facepunch.com/gmod/Player:AddCount) is hit or not. If it's hit, it will call the [GM:PlayerCheckLimit](https://wiki.facepunch.com/gmod/GM:PlayerCheckLimit) hook, and call [Player:LimitHit](https://wiki.facepunch.com/gmod/Player:LimitHit) if the hook doesn't return `false`.

This will always return `true` in singleplayer, as singleplayer does not have limits.

**Arguments:**
- `str` (string) — The entity type to check the limit for.

**Returns:**
- boolean — Returns `true` if the limit of this type is not hit, `false` otherwise.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Player:CheckLimit) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L9-L32)

---

### Player:ConCommand · Shared
`Player:ConCommand(command: string)`

Runs the concommand on the player. This does not work on bots. If used clientside, always runs the command on the local player.

If you wish to directly modify the movement input of bots, use [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand) instead.

**Arguments:**
- `command` (string) — command to run

> **Note:** Some commands/convars are blocked from being run/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see [Blocked ConCommands](https://wiki.facepunch.com/gmod/Blocked%20ConCommands).

[wiki](https://wiki.facepunch.com/gmod/Player:ConCommand)

---

### Player:CreateRagdoll · Server
`Player:CreateRagdoll()`

Creates the player's death ragdoll entity and deletes the old one.

This is normally used when a player dies, to create their death ragdoll.

The ragdoll will be created with the player's properties such as [Position](https://wiki.facepunch.com/gmod/Entity:GetPos), [Angles](https://wiki.facepunch.com/gmod/Entity:GetAngles), [PlayerColor](https://wiki.facepunch.com/gmod/Player:GetPlayerColor), [Velocity](https://wiki.facepunch.com/gmod/Entity:GetVelocity) and [Model](https://wiki.facepunch.com/gmod/Entity:GetModel).

You can retrieve the entity this creates with [Player:GetRagdollEntity](https://wiki.facepunch.com/gmod/Player:GetRagdollEntity).

[wiki](https://wiki.facepunch.com/gmod/Player:CreateRagdoll)

---

### Player:CrosshairDisable · Server
`Player:CrosshairDisable()`

Disables the default player's crosshair. Can be reenabled with [Player:CrosshairEnable](https://wiki.facepunch.com/gmod/Player:CrosshairEnable). This will affect [WEAPON:DoDrawCrosshair](https://wiki.facepunch.com/gmod/WEAPON:DoDrawCrosshair).

[wiki](https://wiki.facepunch.com/gmod/Player:CrosshairDisable)

---

### Player:CrosshairEnable · Server
`Player:CrosshairEnable()`

Enables the player's crosshair, if it was previously disabled via [Player:CrosshairDisable](https://wiki.facepunch.com/gmod/Player:CrosshairDisable).

[wiki](https://wiki.facepunch.com/gmod/Player:CrosshairEnable)

---

### Player:Crouching · Shared
`Player:Crouching() → boolean`

Returns whether the player is crouching or not ([FL_DUCKING](https://wiki.facepunch.com/gmod/Enums/FL) flag).

**Returns:**
- boolean — Whether the player is crouching.

[wiki](https://wiki.facepunch.com/gmod/Player:Crouching)

---

### Player:Deaths · Shared
`Player:Deaths() → number`

Returns the player's death count

**Returns:**
- number — The number of deaths the player has had.

[wiki](https://wiki.facepunch.com/gmod/Player:Deaths)

---

### Player:DebugInfo · Shared
`Player:DebugInfo()`

Prints the players' name and position to the console.

[wiki](https://wiki.facepunch.com/gmod/Player:DebugInfo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L48-L53)

---

### Player:DetonateTripmines · Server
`Player:DetonateTripmines()`

Detonates all tripmines belonging to the player.

[wiki](https://wiki.facepunch.com/gmod/Player:DetonateTripmines)

---

### Player:DisableWorldClicking · Server
`Player:DisableWorldClicking(disable: boolean)`

Disables world clicking for given player. See [Panel:SetWorldClicker](https://wiki.facepunch.com/gmod/Panel:SetWorldClicker) and [Player:IsWorldClickingDisabled](https://wiki.facepunch.com/gmod/Player:IsWorldClickingDisabled).

**Arguments:**
- `disable` (boolean) — Whether the world clicking should be disabled.

[wiki](https://wiki.facepunch.com/gmod/Player:DisableWorldClicking)

---

### Player:DoAnimationEvent · Shared
`Player:DoAnimationEvent(data: number)`

Sends a third person animation event to the player.

Calls [GM:DoAnimationEvent](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) with [PLAYERANIMEVENT_CUSTOM_GESTURE](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT) as the event, data as the given data.

**Arguments:**
- `data` (number) — The data to send.

[wiki](https://wiki.facepunch.com/gmod/Player:DoAnimationEvent)

---

### Player:DoAttackEvent · Shared
`Player:DoAttackEvent()`

Starts the player's attack animation. The attack animation is determined by the weapon's HoldType.

Similar to other animation event functions, calls [GM:DoAnimationEvent](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) with [PLAYERANIMEVENT_ATTACK_PRIMARY](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT) as the event and no extra data.

[wiki](https://wiki.facepunch.com/gmod/Player:DoAttackEvent)

---

### Player:DoCustomAnimEvent · Shared
`Player:DoCustomAnimEvent(event: number, data: number)`

Sends a specified third person animation event to the player.

Calls [GM:DoAnimationEvent](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) with specified arguments.

**Arguments:**
- `event` (number, enum [PLAYERANIMEVENT](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT)) — The event to send.
- `data` (number) — The data to send alongside the event.

[wiki](https://wiki.facepunch.com/gmod/Player:DoCustomAnimEvent)

---

### Player:DoReloadEvent · Shared
`Player:DoReloadEvent()`

Sends a third person reload animation event to the player.

Similar to other animation event functions, calls [GM:DoAnimationEvent](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) with [PLAYERANIMEVENT_RELOAD](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT) as the event and no extra data.

[wiki](https://wiki.facepunch.com/gmod/Player:DoReloadEvent)

---

### Player:DoSecondaryAttack · Shared
`Player:DoSecondaryAttack()`

Sends a third person secondary fire animation event to the player.

Similar to other animation event functions, calls [GM:DoAnimationEvent](https://wiki.facepunch.com/gmod/GM:DoAnimationEvent) with [PLAYERANIMEVENT_ATTACK_SECONDARY](https://wiki.facepunch.com/gmod/Enums/PLAYERANIMEVENT) as the event and no extra data.

[wiki](https://wiki.facepunch.com/gmod/Player:DoSecondaryAttack)

---

### Player:DrawViewModel · Shared
`Player:DrawViewModel(draw: boolean, vm: number = 0)`

Show/Hide the player's weapon's viewmodel.

**Arguments:**
- `draw` (boolean) — Should draw
- `vm` (number, default `0`) — Which view model to show/hide, 0-2.

[wiki](https://wiki.facepunch.com/gmod/Player:DrawViewModel)

---

### Player:DrawWorldModel · Server
`Player:DrawWorldModel(draw: boolean)`

Show/Hide the player's weapon's worldmodel.

**Arguments:**
- `draw` (boolean) — Should draw

[wiki](https://wiki.facepunch.com/gmod/Player:DrawWorldModel)

---

### Player:DropNamedWeapon · Server
`Player:DropNamedWeapon(class: string, target: Vector = nil, velocity: Vector = nil)`

Drops the players' weapon of a specific class.

**Arguments:**
- `class` (string) — The class to drop.
- `target` (Vector, default `nil`) — If set, launches the weapon at given position.
- `velocity` (Vector, default `nil`) — If set and previous argument is unset, launches the weapon with given velocity.

[wiki](https://wiki.facepunch.com/gmod/Player:DropNamedWeapon)

---

### Player:DropObject · Server
`Player:DropObject(entity: Entity = nil)`

Drops any object the player is currently holding with either Gravity Gun, Physics Gun or `+use` (E key)

See also [Entity:ForcePlayerDrop](https://wiki.facepunch.com/gmod/Entity:ForcePlayerDrop).

**Arguments:**
- `entity` (Entity, default `nil`) — Only drop if the held entity is this entity.

[wiki](https://wiki.facepunch.com/gmod/Player:DropObject)

---

### Player:DropWeapon · Server
`Player:DropWeapon(weapon: Weapon = nil, target: Vector = nil, velocity: Vector = nil)`

Forces the player to drop the specified weapon

**Arguments:**
- `weapon` (Weapon, default `nil`) — Weapon to be dropped.
- `target` (Vector, default `nil`) — If set, launches the weapon at given position.
- `velocity` (Vector, default `nil`) — If set and previous argument is unset, launches the weapon with given velocity.

[wiki](https://wiki.facepunch.com/gmod/Player:DropWeapon)

---

### Player:EnterVehicle · Server
`Player:EnterVehicle(vehicle: Vehicle)`

Force puts the player into a specified vehicle.
This **does not** bypass [GM:CanPlayerEnterVehicle](https://wiki.facepunch.com/gmod/GM:CanPlayerEnterVehicle).

**Arguments:**
- `vehicle` (Vehicle) — Vehicle the player will enter

[wiki](https://wiki.facepunch.com/gmod/Player:EnterVehicle)

---

### Player:EquipSuit · Server
`Player:EquipSuit()`

Equips the player with the HEV suit.

Allows the player to zoom, walk slowly, sprint, pickup armor batteries, use the health and armor stations and also shows the HUD.
The player also emits a flatline sound on death, which can be overridden with [GM:PlayerDeathSound](https://wiki.facepunch.com/gmod/GM:PlayerDeathSound).

The player is automatically equipped with the suit on spawn, if you wish to stop that, use [Player:RemoveSuit](https://wiki.facepunch.com/gmod/Player:RemoveSuit).

[wiki](https://wiki.facepunch.com/gmod/Player:EquipSuit)

---

### Player:ExitLadder · Server
`Player:ExitLadder()`

Forces the player off the current ladder if they are on one.

[wiki](https://wiki.facepunch.com/gmod/Player:ExitLadder)

---

### Player:ExitVehicle · Server
`Player:ExitVehicle()`

Forces the player to exit the vehicle if they're in one.

This function will bypass [GM:CanExitVehicle](https://wiki.facepunch.com/gmod/GM:CanExitVehicle). See also [GM:PlayerLeaveVehicle](https://wiki.facepunch.com/gmod/GM:PlayerLeaveVehicle)

[wiki](https://wiki.facepunch.com/gmod/Player:ExitVehicle)

---

### Player:Flashlight · Server
`Player:Flashlight(isOn: boolean)`

Enables/Disables the player's flashlight.

[Player:CanUseFlashlight](https://wiki.facepunch.com/gmod/Player:CanUseFlashlight) must be true in order for the player's flashlight to be changed.
[GM:PlayerSwitchFlashlight](https://wiki.facepunch.com/gmod/GM:PlayerSwitchFlashlight) can block this function.

**Arguments:**
- `isOn` (boolean) — Turns the flashlight on/off

[wiki](https://wiki.facepunch.com/gmod/Player:Flashlight)

---

### Player:FlashlightIsOn · Shared
`Player:FlashlightIsOn() → boolean`

Returns true if the player's flashlight is on.

**Returns:**
- boolean — Whether the player's flashlight is on.

[wiki](https://wiki.facepunch.com/gmod/Player:FlashlightIsOn)

---

### Player:Frags · Shared
`Player:Frags() → number`

Returns the amount of frags a player has.

**Returns:**
- number — frags

> **Note:** The value will change depending on the player's kill or suicide: +1 for a kill, -1 for a suicide.

[wiki](https://wiki.facepunch.com/gmod/Player:Frags)

---

### Player:Freeze · Server
`Player:Freeze(frozen: boolean = false)`

Freeze the player. Frozen players cannot move, look around, or attack. Key bindings are still called. Similar to [Player:Lock](https://wiki.facepunch.com/gmod/Player:Lock) but the player can still take damage.

Manages the [FL_FROZEN](https://wiki.facepunch.com/gmod/Enums/FL#FL_FROZEN) flag on the player.

**Arguments:**
- `frozen` (boolean, default `false`) — Whether the player should be frozen.

[wiki](https://wiki.facepunch.com/gmod/Player:Freeze) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L212-L220)

---

### Player:GetActiveWeapon · Shared
`Player:GetActiveWeapon() → Weapon`

Returns the player's active weapon.

If used on a [LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer)() and the player is spectating another player with `OBS_MODE_IN_EYE`, the weapon returned will be of the spectated player.

**Returns:**
- Weapon — The weapon the player currently has equipped or NULL if the player doesn't have an active weapon eg.

[wiki](https://wiki.facepunch.com/gmod/Player:GetActiveWeapon)

---

### Player:GetActivity · Server
`Player:GetActivity() → number`

Returns the player's current activity.

**Returns:**
- `act` (number) — The player's current activity.

[wiki](https://wiki.facepunch.com/gmod/Player:GetActivity)

---

### Player:GetAimVector · Shared
`Player:GetAimVector() → Vector`

Returns the direction that the player is aiming.

**Returns:**
- Vector — The direction vector of players aim

[wiki](https://wiki.facepunch.com/gmod/Player:GetAimVector)

---

### Player:GetAllowFullRotation · Shared
`Player:GetAllowFullRotation() → boolean`

Returns true if the players' model is allowed to rotate around the pitch and roll axis.

**Returns:**
- boolean — Allowed

[wiki](https://wiki.facepunch.com/gmod/Player:GetAllowFullRotation)

---

### Player:GetAllowWeaponsInVehicle · Shared
`Player:GetAllowWeaponsInVehicle() → boolean`

Returns whether the player is allowed to use their weapons in a vehicle or not.

**Returns:**
- boolean — Whether the player is allowed to use their weapons in a vehicle or not.

[wiki](https://wiki.facepunch.com/gmod/Player:GetAllowWeaponsInVehicle)

---

### Player:GetAmmo · Shared
`Player:GetAmmo() → table`

Returns a table of all ammo the player has.

**Returns:**
- table — A table with the following format * number Key - AmmoID to be used with functions like game.GetAmmoName.

[wiki](https://wiki.facepunch.com/gmod/Player:GetAmmo)

---

### Player:GetAmmoCount · Shared
`Player:GetAmmoCount(ammotype: any) → number`

Gets the amount of ammo the player has.

**Arguments:**
- `ammotype` (any) — The ammunition type.

**Returns:**
- number — The amount of ammo player has in reserve.

[wiki](https://wiki.facepunch.com/gmod/Player:GetAmmoCount)

---

### Player:GetAvoidPlayers · Shared
`Player:GetAvoidPlayers() → boolean`

Gets if the player will be pushed out of nocollided players.

**Returns:**
- boolean — pushed

[wiki](https://wiki.facepunch.com/gmod/Player:GetAvoidPlayers)

---

### Player:GetCanWalk · Shared
`Player:GetCanWalk() → boolean`

Returns true if the player is able to walk using the (default) alt key.

**Returns:**
- boolean — AbleToWalk

[wiki](https://wiki.facepunch.com/gmod/Player:GetCanWalk)

---

### Player:GetCanZoom · Shared
`Player:GetCanZoom() → boolean`

Determines whenever the player is allowed to use the zoom functionality.

**Returns:**
- boolean — canZoom

[wiki](https://wiki.facepunch.com/gmod/Player:GetCanZoom)

---

### Player:GetClassID · Shared
`Player:GetClassID() → number`

Returns the player's class id.

**Returns:**
- number — The player's class id.

[wiki](https://wiki.facepunch.com/gmod/Player:GetClassID)

---

### Player:GetCount · Shared
`Player:GetCount(type: string, minus: number = 0) → number`

Gets the total amount of entities of an entity type added by [Player:AddCount](https://wiki.facepunch.com/gmod/Player:AddCount).

Default types:
```
balloons
buttons
cameras
dynamite
effects
emitters
hoverballs
lamps
lights
npcs
props
ragdolls
sents
thrusters
vehicles
wheels
```

**Arguments:**
- `type` (string) — Type to get entity count of.
- `minus` (number, default `0`) — If specified, it will reduce the counter by this value.

**Returns:**
- `count` (number) — The returned count.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Player:GetCount) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L34-L70)

---

### Player:GetCrouchedWalkSpeed · Shared
`Player:GetCrouchedWalkSpeed() → number`

Returns the crouched walk speed multiplier.

See also [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed) and [Player:SetCrouchedWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetCrouchedWalkSpeed).

**Returns:**
- number — The crouched walk speed multiplier.

[wiki](https://wiki.facepunch.com/gmod/Player:GetCrouchedWalkSpeed)

---

### Player:GetCurrentCommand · Shared
`Player:GetCurrentCommand() → CUserCmd`

Returns the last command which was sent by the specified player. This can only be called on the player which [GetPredictionPlayer](https://wiki.facepunch.com/gmod/Global.GetPredictionPlayer)() returns.

**Returns:**
- CUserCmd — Last user commands

> **Note:** When called clientside in singleplayer during [WEAPON:Think](https://wiki.facepunch.com/gmod/WEAPON:Think), it will return nothing as the hook is not technically predicted in that instance. See the note on the page.
> **Bug** ([#3302](https://github.com/Facepunch/garrysmod/issues/3302)): This will fail in [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand).

[wiki](https://wiki.facepunch.com/gmod/Player:GetCurrentCommand)

---

### Player:GetCurrentViewOffset · Shared
`Player:GetCurrentViewOffset() → Vector`

Gets the current applied view offset, which transitions between the player's standing and ducked view offset depending on their duck state.

Do not confuse with [Player:GetViewOffset](https://wiki.facepunch.com/gmod/Player:GetViewOffset) and [Player:GetViewOffsetDucked](https://wiki.facepunch.com/gmod/Player:GetViewOffsetDucked), which always return the standing or ducked offset respectively.

**Returns:**
- Vector — The actual view offset.

[wiki](https://wiki.facepunch.com/gmod/Player:GetCurrentViewOffset)

---

### Player:GetDrivingEntity · Shared
`Player:GetDrivingEntity() → Entity`

Gets the entity the player is currently driving via the [drive](https://wiki.facepunch.com/gmod/drive) library.

**Returns:**
- Entity — The currently driven entity, or NULL entity

[wiki](https://wiki.facepunch.com/gmod/Player:GetDrivingEntity)

---

### Player:GetDrivingMode · Shared
`Player:GetDrivingMode() → number`

Returns driving mode of the player. See [Entity Driving](https://wiki.facepunch.com/gmod/Entity%20Driving).

**Returns:**
- number — The drive mode ID or 0 if player doesn't use the drive system.

[wiki](https://wiki.facepunch.com/gmod/Player:GetDrivingMode)

---

### Player:GetDuckSpeed · Shared
`Player:GetDuckSpeed() → number`

Returns a player's duck speed (in seconds)

**Returns:**
- number — duckspeed

[wiki](https://wiki.facepunch.com/gmod/Player:GetDuckSpeed)

---

### Player:GetEntityInUse · Shared
`Player:GetEntityInUse() → Entity`

Returns the entity the player is currently using, like func_tank mounted turrets or +use prop pickups.

**Returns:**
- Entity — Entity in use, or NULL entity otherwise.

[wiki](https://wiki.facepunch.com/gmod/Player:GetEntityInUse)

---

### Player:GetEyeTrace · Shared
`Player:GetEyeTrace() → table{TraceResult}`

Returns a table with information of what the player is looking at.

The results of this function are **cached** clientside every frame.

Uses [util.GetPlayerTrace](https://wiki.facepunch.com/gmod/util.GetPlayerTrace) internally and is therefore bound by its limits.

See also [Player:GetEyeTraceNoCursor](https://wiki.facepunch.com/gmod/Player:GetEyeTraceNoCursor).

**Returns:**
- table{TraceResult} — Trace information, see Structures/TraceResult.

[wiki](https://wiki.facepunch.com/gmod/Player:GetEyeTrace) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L172-L192)

---

### Player:GetEyeTraceNoCursor · Shared
`Player:GetEyeTraceNoCursor() → table{TraceResult}`

Returns the trace according to the players view direction, ignoring their mouse (holding  and moving the mouse in Sandbox).

The results of this function are **cached** clientside every frame.

Uses [util.GetPlayerTrace](https://wiki.facepunch.com/gmod/util.GetPlayerTrace) internally and is therefore bound by its limits.

See also [Player:GetEyeTrace](https://wiki.facepunch.com/gmod/Player:GetEyeTrace).

**Returns:**
- table{TraceResult} — Trace result.

[wiki](https://wiki.facepunch.com/gmod/Player:GetEyeTraceNoCursor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L194-L213)

---

### Player:GetFlashlightColor · Client · `NEW`
`Player:GetFlashlightColor() → Color`

Returns the color of a player's flashlight.

**Returns:**
- Color — Flashlight color

[wiki](https://wiki.facepunch.com/gmod/Player:GetFlashlightColor)

---

### Player:GetFOV · Shared
`Player:GetFOV() → number`

Returns the FOV of the player.

**Returns:**
- number — Field of view as a float

[wiki](https://wiki.facepunch.com/gmod/Player:GetFOV)

---

### Player:GetFriendStatus · Client
`Player:GetFriendStatus() → string`

Returns the steam "relationship" towards the player.

**Returns:**
- string — Should return one of four different things depending on their status on your friends list: "friend", "blocked", "none", "requested" or "error_nofriendid" for bots.

[wiki](https://wiki.facepunch.com/gmod/Player:GetFriendStatus)

---

### Player:GetHands · Shared
`Player:GetHands() → Entity`

Gets the hands entity of a player

**Returns:**
- Entity — The hands entity if players has one

[wiki](https://wiki.facepunch.com/gmod/Player:GetHands)

---

### Player:GetHoveredWidget · Shared
`Player:GetHoveredWidget() → Entity`

Returns the widget the player is hovering with their mouse.

**Returns:**
- Entity — The hovered widget.

[wiki](https://wiki.facepunch.com/gmod/Player:GetHoveredWidget)

---

### Player:GetHull · Shared
`Player:GetHull() → Vector, Vector`

Retrieves the minimum and maximum [Vectors](https://wiki.facepunch.com/gmod/Vector) of the [Axis-Aligned Bounding Box (AABB)](https://en.wikipedia.org/wiki/Minimum_bounding_box) used for the [Player's](https://wiki.facepunch.com/gmod/Player) physics and movement [Hull Traces](https://wiki.facepunch.com/gmod/util.TraceHull).

		See also: [Player:SetHull](https://wiki.facepunch.com/gmod/Player:SetHull), [Player:SetHullDuck](https://wiki.facepunch.com/gmod/Player:SetHullDuck), [Player:GetHullDuck](https://wiki.facepunch.com/gmod/Player:GetHullDuck)

**Returns:**
- `mins` (Vector) — The hull mins, the lowest corner of the Player's bounding box.
- `maxs` (Vector) — The hull maxs, the highest corner of the Player's bounding box, opposite of the mins.

[wiki](https://wiki.facepunch.com/gmod/Player:GetHull)

---

### Player:GetHullDuck · Shared
`Player:GetHullDuck() → Vector, Vector`

Retrieves the minimum and maximum [Vectors](https://wiki.facepunch.com/gmod/Vector) of the [Axis-Aligned Bounding Box (AABB)](https://en.wikipedia.org/wiki/Minimum_bounding_box) used for the [Player's](https://wiki.facepunch.com/gmod/Player) physics and movement [Hull Traces](https://wiki.facepunch.com/gmod/util.TraceHull) while they are crouching (or "Ducking").

		See also: [Player:SetHullDuck](https://wiki.facepunch.com/gmod/Player:SetHullDuck), [Player:GetHull](https://wiki.facepunch.com/gmod/Player:GetHull), [Player:SetHull](https://wiki.facepunch.com/gmod/Player:SetHull)

**Returns:**
- `mins` (Vector) — The hull mins, the lowest corner of the Player's bounding box while crouching.
- `maxs` (Vector) — The hull maxs, the highest corner of the Player's crouching bounding box, opposite of the mins.

[wiki](https://wiki.facepunch.com/gmod/Player:GetHullDuck)

---

### Player:GetInfo · Shared
`Player:GetInfo(cVarName: string) → string`

Retrieves the value of a client-side [ConVar](https://wiki.facepunch.com/gmod/ConVar). The [ConVar](https://wiki.facepunch.com/gmod/ConVar) must have a [FCVAR_USERINFO](https://wiki.facepunch.com/gmod/Enums/FCVAR) flag for this to work.

On client this function will return value of the local player, regardless of which player the function was called on!

See [Player:GetInfoNum](https://wiki.facepunch.com/gmod/Player:GetInfoNum) for the same function that automatically converts the string to a number.

**Arguments:**
- `cVarName` (string) — The name of the client-side ConVar.

**Returns:**
- string — The value of the ConVar.

[wiki](https://wiki.facepunch.com/gmod/Player:GetInfo)

---

### Player:GetInfoNum · Shared
`Player:GetInfoNum(cVarName: string, default: number) → number`

Retrieves the numeric value of a client-side convar, returns nil if value is not convertible to a number. The [ConVar](https://wiki.facepunch.com/gmod/ConVar) must have a [FCVAR_USERINFO](https://wiki.facepunch.com/gmod/Enums/FCVAR) flag for this to work.

**Arguments:**
- `cVarName` (string) — The name of the ConVar to query the value of
- `default` (number) — Default value if we failed to retrieve the number.

**Returns:**
- number — The value of the ConVar or the default value

[wiki](https://wiki.facepunch.com/gmod/Player:GetInfoNum)

---

### Player:GetJumpPower · Shared
`Player:GetJumpPower() → number`

Returns the jump power of the player

**Returns:**
- number — Jump power

[wiki](https://wiki.facepunch.com/gmod/Player:GetJumpPower)

---

### Player:GetLadderClimbSpeed · Shared
`Player:GetLadderClimbSpeed() → number`

Returns the player's ladder climbing speed.

See [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed) for normal walking speed, [Player:GetRunSpeed](https://wiki.facepunch.com/gmod/Player:GetRunSpeed) for sprinting speed and [Player:GetSlowWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetSlowWalkSpeed) for slow walking speed.

**Returns:**
- `speed` (number) — The ladder climbing speed.

[wiki](https://wiki.facepunch.com/gmod/Player:GetLadderClimbSpeed)

---

### Player:GetLaggedMovementValue · Shared
`Player:GetLaggedMovementValue() → number`

Returns the timescale multiplier of the player movement.

**Returns:**
- number — The timescale multiplier, defaults to `1`.

[wiki](https://wiki.facepunch.com/gmod/Player:GetLaggedMovementValue)

---

### Player:GetMaxArmor · Shared
`Player:GetMaxArmor() → number`

Returns the maximum amount of armor the player should have. Default value is 100.

**Returns:**
- `maxarmor` (number) — The new max armor value

[wiki](https://wiki.facepunch.com/gmod/Player:GetMaxArmor)

---

### Player:GetMaxSpeed · Shared
`Player:GetMaxSpeed() → number`

Returns the player's maximum movement speed.

See also [Player:SetMaxSpeed](https://wiki.facepunch.com/gmod/Player:SetMaxSpeed), [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed) and [Player:GetRunSpeed](https://wiki.facepunch.com/gmod/Player:GetRunSpeed).

**Returns:**
- number — The maximum movement speed the player can go at.

[wiki](https://wiki.facepunch.com/gmod/Player:GetMaxSpeed)

---

### Player:GetName · Shared · `DEPRECATED`
`Player:GetName() → string`

Returns the player's name, this is an alias of [Player:Nick](https://wiki.facepunch.com/gmod/Player:Nick).

**Returns:**
- string — The player's name.

> **Note:** This function overrides [Entity:GetName](https://wiki.facepunch.com/gmod/Entity:GetName) (in the Lua metatable, not in c++), keep it in mind when dealing with [ents.FindByName](https://wiki.facepunch.com/gmod/ents.FindByName) or any engine function which requires the mapping name.

[wiki](https://wiki.facepunch.com/gmod/Player:GetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L56-L56)

---

### Player:GetNoCollideWithTeammates · Shared
`Player:GetNoCollideWithTeammates() → boolean`

Returns whenever the player is set not to collide with their teammates.

**Returns:**
- boolean — noCollideWithTeammates

[wiki](https://wiki.facepunch.com/gmod/Player:GetNoCollideWithTeammates)

---

### Player:GetObserverMode · Shared
`Player:GetObserverMode() → number`

Returns the the observer mode of the player

**Returns:**
- number — Observe mode of that player, see OBS_MODE.

[wiki](https://wiki.facepunch.com/gmod/Player:GetObserverMode)

---

### Player:GetObserverTarget · Shared
`Player:GetObserverTarget() → Entity`

Returns the entity the player is currently observing.

Set using [Player:SpectateEntity](https://wiki.facepunch.com/gmod/Player:SpectateEntity).

**Returns:**
- Entity — The entity the player is currently spectating, or NULL if the player has no target.

[wiki](https://wiki.facepunch.com/gmod/Player:GetObserverTarget)

---

### Player:GetPData · Shared
`Player:GetPData(key: string, default: any = nil) → string`

Returns a **P**ersistent **Data** key-value pair from the SQL database. (`sv.db` when called on server, `cl.db` when called on client)

Internally uses the [sql](https://wiki.facepunch.com/gmod/sql) library. See [util.GetPData](https://wiki.facepunch.com/gmod/util.GetPData) for cases when the player is not currently on the server.

**Arguments:**
- `key` (string) — Name of the PData key
- `default` (any, default `nil`) — Default value if PData key doesn't exist.

**Returns:**
- string — The data in the SQL database or the default value given.

> **Note:** PData is not networked from servers to clients!
> **Note:** This function internally uses [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which can cause collisions (two or more players sharing the same PData entry). [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData) now replaces all instances of [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) with [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) when running [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData)

[wiki](https://wiki.facepunch.com/gmod/Player:GetPData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L111-L131)

---

### Player:GetPlayerColor · Shared
`Player:GetPlayerColor() → Vector`

Returns a player's character model color.

The part of the model that is colored is determined by the model's materials, and is therefore different for each model.

See [Player:GetWeaponColor](https://wiki.facepunch.com/gmod/Player:GetWeaponColor) for the accompanying function for the weapon color.

**Returns:**
- Vector — The format is `Vector(r,g,b)`, and each color component should be between 0 and 1.

> **Note:** Override this function clientside on any Entity (including a player) with a supported model set (such as default player models) and returned color will apply to the model. This is done via the `PlayerColor` [matproxy](https://wiki.facepunch.com/gmod/matproxy).

[wiki](https://wiki.facepunch.com/gmod/Player:GetPlayerColor)

---

### Player:GetPlayerInfo · Shared
`Player:GetPlayerInfo() → table`

Returns a table containing player information.

**Returns:**
- table — A table containing player information.

[wiki](https://wiki.facepunch.com/gmod/Player:GetPlayerInfo)

---

### Player:GetPreferredCarryAngles · Server
`Player:GetPreferredCarryAngles(carryEnt: Entity) → Angle`

Returns the preferred carry angles of an object, if any are set.

Calls [GM:GetPreferredCarryAngles](https://wiki.facepunch.com/gmod/GM:GetPreferredCarryAngles) with the target entity and returns the carry angles.

**Arguments:**
- `carryEnt` (Entity) — Entity to retrieve the carry angles of.

**Returns:**
- Angle — Carry angles or nil if the entity has no preferred carry angles.

[wiki](https://wiki.facepunch.com/gmod/Player:GetPreferredCarryAngles)

---

### Player:GetPressedWidget · Shared
`Player:GetPressedWidget() → Entity`

Returns the widget entity the player is using.

Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.

**Returns:**
- Entity — The pressed widget.

[wiki](https://wiki.facepunch.com/gmod/Player:GetPressedWidget)

---

### Player:GetPreviousWeapon · Shared
`Player:GetPreviousWeapon() → Entity`

Returns the weapon the player previously had equipped.

**Returns:**
- Entity — The previous weapon of the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GetPreviousWeapon)

---

### Player:GetPunchAngle · Shared · `DEPRECATED`
`Player:GetPunchAngle() → Angle`

Returns players screen punch effect angle. See [Player:ViewPunch](https://wiki.facepunch.com/gmod/Player:ViewPunch) and [Player:SetViewPunchAngles](https://wiki.facepunch.com/gmod/Player:SetViewPunchAngles)

**Returns:**
- Angle — The punch angle

[wiki](https://wiki.facepunch.com/gmod/Player:GetPunchAngle)

---

### Player:GetRagdollEntity · Shared
`Player:GetRagdollEntity() → Entity`

Returns players death ragdoll. The ragdoll is created by [Player:CreateRagdoll](https://wiki.facepunch.com/gmod/Player:CreateRagdoll).

**Returns:**
- Entity — The ragdoll.

> **Note:** Calling [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos) server-side with this function then will return the position where [Player:CreateRagdoll](https://wiki.facepunch.com/gmod/Player:CreateRagdoll) was used, as it is a hl2mp_ragdoll which is a serverside point entity that creates a clientside ragdoll for everyone (opposed to prop_ragdoll that is serverside and networks).

[wiki](https://wiki.facepunch.com/gmod/Player:GetRagdollEntity)

---

### Player:GetRenderAngles · Shared
`Player:GetRenderAngles() → Angle`

Returns the render angles for the player.

**Returns:**
- Angle — The render angles of the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GetRenderAngles)

---

### Player:GetRunSpeed · Shared
`Player:GetRunSpeed() → number`

Returns the player's sprint speed.

See also [Player:SetRunSpeed](https://wiki.facepunch.com/gmod/Player:SetRunSpeed), [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed) and [Player:GetMaxSpeed](https://wiki.facepunch.com/gmod/Player:GetMaxSpeed).

**Returns:**
- number — The sprint speed

[wiki](https://wiki.facepunch.com/gmod/Player:GetRunSpeed)

---

### Player:GetShootPos · Shared
`Player:GetShootPos() → Vector`

Returns the position of a Player's view

**Returns:**
- Vector — The position of the player's view.

> **Note:** This is the same as calling [Entity:EyePos](https://wiki.facepunch.com/gmod/Entity:EyePos) on the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GetShootPos)

---

### Player:GetSlowWalkSpeed · Shared
`Player:GetSlowWalkSpeed() → number`

Returns the player's slow walking speed, which is activated via  keybind.

See [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed) for normal walking speed, [Player:GetRunSpeed](https://wiki.facepunch.com/gmod/Player:GetRunSpeed) for sprinting speed and [Player:GetLadderClimbSpeed](https://wiki.facepunch.com/gmod/Player:GetLadderClimbSpeed) for ladder climb speed.

**Returns:**
- `speed` (number) — The new slow walking speed.

[wiki](https://wiki.facepunch.com/gmod/Player:GetSlowWalkSpeed)

---

### Player:GetStepSize · Shared
`Player:GetStepSize() → number`

Returns the maximum height player can step onto.

**Returns:**
- number — The maximum height player can get up onto without jumping, in hammer units.

[wiki](https://wiki.facepunch.com/gmod/Player:GetStepSize)

---

### Player:GetSuitPower · Shared
`Player:GetSuitPower() → number`

Returns the player's HEV suit power.

**Returns:**
- number — The current suit power.

> **Bug** ([#3449](https://github.com/Facepunch/garrysmod/issues/3449)): This will only work for the local player when used clientside.

[wiki](https://wiki.facepunch.com/gmod/Player:GetSuitPower)

---

### Player:GetTimeoutSeconds · Server
`Player:GetTimeoutSeconds() → number`

Returns the number of seconds that the player has been timing out for. You can check if a player is timing out with [Player:IsTimingOut](https://wiki.facepunch.com/gmod/Player:IsTimingOut).

**Returns:**
- number — Timeout seconds.

> **Note:** This function is relatively useless because it is tied to the value of the `sv_timeout` ConVar, which is irrelevant to the description above. [This is not considered as a bug](https://discord.com/channels/565105920414318602/567617926991970306/748970396224585738).

[wiki](https://wiki.facepunch.com/gmod/Player:GetTimeoutSeconds)

---

### Player:GetTool · Shared
`Player:GetTool(mode: string = nil) → table`

Returns [TOOL](https://wiki.facepunch.com/gmod/Structures/TOOL) table of players current tool, or of the one specified.

**Arguments:**
- `mode` (string, default `nil`) — Classname of the tool to retrieve.

**Returns:**
- table — TOOL table, or nil if the table wasn't found or the player doesn't have a tool gun.

[wiki](https://wiki.facepunch.com/gmod/Player:GetTool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L105-L115)

---

### Player:GetUnDuckSpeed · Shared
`Player:GetUnDuckSpeed() → number`

Returns a player's unduck speed (in seconds)

**Returns:**
- number — unduck speed

[wiki](https://wiki.facepunch.com/gmod/Player:GetUnDuckSpeed)

---

### Player:GetUseEntity · Shared
`Player:GetUseEntity() → Entity`

Returns the entity the player would use if they would press their `+use` keybind.

**Returns:**
- `ent` (Entity) — The entity that would be used or NULL.

> **Note:** Because entity physics objects usually do not exist on the client, the client's use entity will resolve to whatever the crosshair is placed on within a little less than 72 units of the player's eye position. This differs from the entity returned by the server, which has fully physical use checking. See [util.TraceHull](https://wiki.facepunch.com/gmod/util.TraceHull).
> 
> Issue tracker: [5027](https://github.com/Facepunch/garrysmod-issues/issues/5027)

[wiki](https://wiki.facepunch.com/gmod/Player:GetUseEntity)

---

### Player:GetUserGroup · Shared
`Player:GetUserGroup() → string`

Returns the player's user group. By default, player user groups are loaded from `garrysmod/settings/users.txt`.

**Returns:**
- string — The user group of the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GetUserGroup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L44-L48)

---

### Player:GetVehicle · Shared
`Player:GetVehicle() → Vehicle`

Returns the vehicle the player is driving.

**Returns:**
- Vehicle — The vehicle the player is currently driving, if any.

[wiki](https://wiki.facepunch.com/gmod/Player:GetVehicle)

---

### Player:GetViewEntity · Shared
`Player:GetViewEntity() → Entity`

Returns the entity the player is using to see from (such as the player itself, the camera, or another entity).

**Returns:**
- Entity — The entity the player is using to see from

> **Note:** This function will return a [NULL Entity] until [Player:SetViewEntity](https://wiki.facepunch.com/gmod/Player:SetViewEntity) has been used

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewEntity)

---

### Player:GetViewModel · Shared
`Player:GetViewModel(index: number = 0) → Entity`

Returns the player's view model entity by the index.
Each player has 3 view models by default, but only the first one is used.

To use the other viewmodels in your SWEP, see [Entity:SetWeaponModel](https://wiki.facepunch.com/gmod/Entity:SetWeaponModel).

**Arguments:**
- `index` (number, default `0`) — optional index of the view model to return, can range from 0 to 2

**Returns:**
- Entity — The view model entity

> **Note:** In the Client [realm](https://wiki.facepunch.com/gmod/States), other players' viewmodels are not available unless they are being spectated.

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewModel)

---

### Player:GetViewOffset · Shared
`Player:GetViewOffset() → Vector`

Returns the view offset of the player, which equals the difference between the player's actual position and their view when standing.

See also [Player:GetViewOffsetDucked](https://wiki.facepunch.com/gmod/Player:GetViewOffsetDucked).

**Returns:**
- Vector — New view offset, must be local vector to player's Entity:GetPos

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewOffset)

---

### Player:GetViewOffsetDucked · Shared
`Player:GetViewOffsetDucked() → Vector`

Returns the ducked view offset of the player, which equals the difference between the player's actual position and their view when ducked.

See also [Player:GetViewOffset](https://wiki.facepunch.com/gmod/Player:GetViewOffset).

**Returns:**
- Vector — New crouching view offset, must be local vector to player's Entity:GetPos

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewOffsetDucked)

---

### Player:GetViewPunchAngles · Shared
`Player:GetViewPunchAngles() → Angle`

Returns players screen punch effect angle.

**Returns:**
- Angle — The punch angle

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewPunchAngles)

---

### Player:GetViewPunchVelocity · Shared
`Player:GetViewPunchVelocity() → Angle`

Returns client's view punch velocity. See [Player:ViewPunch](https://wiki.facepunch.com/gmod/Player:ViewPunch) and [Player:SetViewPunchVelocity](https://wiki.facepunch.com/gmod/Player:SetViewPunchVelocity)

**Returns:**
- `punchVel` (Angle) — The current view punch angle velocity.

[wiki](https://wiki.facepunch.com/gmod/Player:GetViewPunchVelocity)

---

### Player:GetVoiceVolumeScale · Client
`Player:GetVoiceVolumeScale() → number`

Returns the current voice volume scale for given player on client.

**Returns:**
- number — The voice volume scale, where 0 is 0% and 1 is 100%.

[wiki](https://wiki.facepunch.com/gmod/Player:GetVoiceVolumeScale)

---

### Player:GetWalkSpeed · Shared
`Player:GetWalkSpeed() → number`

Returns the player's normal walking speed. Not sprinting, not slow walking. (+walk)

See also [Player:SetWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed), [Player:GetMaxSpeed](https://wiki.facepunch.com/gmod/Player:GetMaxSpeed) and [Player:GetRunSpeed](https://wiki.facepunch.com/gmod/Player:GetRunSpeed).

**Returns:**
- number — The normal walking speed.

[wiki](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed)

---

### Player:GetWeapon · Shared
`Player:GetWeapon(className: string) → Weapon`

Returns the weapon for the specified class

**Arguments:**
- `className` (string) — Class name of weapon

**Returns:**
- Weapon — The weapon for the specified class, or NULL ENTITY if the player does not have this weapon.

[wiki](https://wiki.facepunch.com/gmod/Player:GetWeapon)

---

### Player:GetWeaponColor · Shared
`Player:GetWeaponColor() → Vector`

Returns a player's weapon color.

The part of the model that is colored is determined by the model itself, and is different for each model. 

See [Player:GetPlayerColor](https://wiki.facepunch.com/gmod/Player:GetPlayerColor) for the accompanying function for the player character model color.

**Returns:**
- Vector — The format is `Vector(r,g,b)`, and each color should be between 0 and 1.

[wiki](https://wiki.facepunch.com/gmod/Player:GetWeaponColor)

---

### Player:GetWeapons · Shared
`Player:GetWeapons() → table`

Returns a table of the player's weapons.

**Returns:**
- table — All the weapons the player currently has.

> **Note:** This function returns a sequential table. Prefer to loop it with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of the [pairs](https://wiki.facepunch.com/gmod/Global.pairs) function.

[wiki](https://wiki.facepunch.com/gmod/Player:GetWeapons)

---

### Player:Give · Server
`Player:Give(weaponClassName: string, bNoAmmo: boolean = false) → Weapon`

Gives the player a weapon.

This function will call [GM:PlayerCanPickupWeapon](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupWeapon). If that hook returns false, this function will do nothing.

**Arguments:**
- `weaponClassName` (string) — Class name of weapon to give the player
- `bNoAmmo` (boolean, default `false`) — Set to true to not give any ammo on weapon spawn.

**Returns:**
- Weapon — The weapon given to the player, if one was given.

> **Note:** While this function is meant for weapons/pickupables only, it is **not** restricted to weapons. Any entity can be spawned using this function, including NPCs and SENTs.

[wiki](https://wiki.facepunch.com/gmod/Player:Give)

---

### Player:GiveAmmo · Server
`Player:GiveAmmo(amount: number, type: string, hidePopup: boolean = false) → number`

Gives ammo to a player

**Arguments:**
- `amount` (number) — Amount of ammo
- `type` (string) — Type of ammo.
- `hidePopup` (boolean, default `false`) — Hide display popup when giving the ammo

**Returns:**
- number — Ammo given.

[wiki](https://wiki.facepunch.com/gmod/Player:GiveAmmo)

---

### Player:GodDisable · Server
`Player:GodDisable()`

Disables god mode on the player. Removes the [FL_GODMODE](https://wiki.facepunch.com/gmod/Enums/FL#FL_GODMODE) flag from the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GodDisable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L232-L240)

---

### Player:GodEnable · Server
`Player:GodEnable()`

Enables god mode on the player. Adds the [FL_GODMODE](https://wiki.facepunch.com/gmod/Enums/FL#FL_GODMODE) flag to the player.

[wiki](https://wiki.facepunch.com/gmod/Player:GodEnable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L222-L230)

---

### Player:HasGodMode · Shared
`Player:HasGodMode() → boolean`

Returns whether the player has god mode or not, contolled by [Player:GodEnable](https://wiki.facepunch.com/gmod/Player:GodEnable) and [Player:GodDisable](https://wiki.facepunch.com/gmod/Player:GodDisable).

**Returns:**
- boolean — Whether the player has god mode or not.

[wiki](https://wiki.facepunch.com/gmod/Player:HasGodMode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L254-L262)

---

### Player:HasWeapon · Shared
`Player:HasWeapon(className: string) → boolean`

Returns if the player has the specified weapon

**Arguments:**
- `className` (string) — Class name of the weapon

**Returns:**
- boolean — True if the player has the weapon

[wiki](https://wiki.facepunch.com/gmod/Player:HasWeapon)

---

### Player:InVehicle · Shared
`Player:InVehicle() → boolean`

Returns if the player is in a vehicle

**Returns:**
- boolean — Whether the player is in a vehicle.

[wiki](https://wiki.facepunch.com/gmod/Player:InVehicle)

---

### Player:IPAddress · Server
`Player:IPAddress() → string`

Returns the player's IP address and connection port in ip:port form

**Returns:**
- `ip` (string) — The player's IP address and connection port

> **Note:** Returns `Error!` for bots.

[wiki](https://wiki.facepunch.com/gmod/Player:IPAddress)

---

### Player:IsAdmin · Shared
`Player:IsAdmin() → boolean`

Returns whether the player is an admin or not. It will also return `true` if the player is [Player:IsSuperAdmin](https://wiki.facepunch.com/gmod/Player:IsSuperAdmin) by default.

Internally this is determined by [Player:IsUserGroup](https://wiki.facepunch.com/gmod/Player:IsUserGroup).

**Returns:**
- boolean — True if the player is an admin or a super admin.

[wiki](https://wiki.facepunch.com/gmod/Player:IsAdmin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L9-L16)

---

### Player:IsBot · Shared
`Player:IsBot() → boolean`

Returns if the player is an bot or not

**Returns:**
- boolean — `true` if the player is a bot.

[wiki](https://wiki.facepunch.com/gmod/Player:IsBot)

---

### Player:IsConnected · Server
`Player:IsConnected() → boolean`

Returns true from the point when the player is sending client info but not fully in the game until they disconnect.

**Returns:**
- boolean — isConnected

[wiki](https://wiki.facepunch.com/gmod/Player:IsConnected)

---

### Player:IsDrivingEntity · Shared
`Player:IsDrivingEntity() → boolean`

Used to find out if a player is currently 'driving' an entity (by which we mean 'right click > drive' ).

**Returns:**
- boolean — A value representing whether or not the player is 'driving' an entity.

[wiki](https://wiki.facepunch.com/gmod/Player:IsDrivingEntity)

---

### Player:IsFrozen · Shared
`Player:IsFrozen() → boolean`

Returns whether the players movement is currently frozen, controlled by [Player:Freeze](https://wiki.facepunch.com/gmod/Player:Freeze).

**Returns:**
- boolean — Whether the players movement is currently frozen or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsFrozen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L244-L252)

---

### Player:IsFullyAuthenticated · Server
`Player:IsFullyAuthenticated() → boolean`

Returns whether the player identity was confirmed by the Steam network.

See also [GM:NetworkIDValidated](https://wiki.facepunch.com/gmod/GM:NetworkIDValidated).

**Returns:**
- boolean — Whether the player has been fully authenticated or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsFullyAuthenticated)

---

### Player:IsListenServerHost · Shared
`Player:IsListenServerHost() → boolean`

Returns if a player is the host of the current session.

**Returns:**
- boolean — `true` if the player is the listen server host, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Player:IsListenServerHost)

---

### Player:IsMuted · Client
`Player:IsMuted() → boolean`

Returns whether or not the player is voice muted locally.

**Returns:**
- boolean — whether or not the player is muted locally.

[wiki](https://wiki.facepunch.com/gmod/Player:IsMuted)

---

### Player:IsPlayingTaunt · Shared
`Player:IsPlayingTaunt() → boolean`

Returns true if the player is playing a taunt.

**Returns:**
- boolean — Whether the player is playing a taunt.

[wiki](https://wiki.facepunch.com/gmod/Player:IsPlayingTaunt)

---

### Player:IsSpeaking · Shared
`Player:IsSpeaking() → boolean`

Returns whenever the player is heard by the local player clientside, or if the player is speaking serverside.

**Returns:**
- boolean — Is the player speaking or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsSpeaking)

---

### Player:IsSprinting · Shared
`Player:IsSprinting() → boolean`

Returns whether the player is currently sprinting or not, specifically if they are holding their sprint key and are allowed to sprint.

This will not check if the player is currently sprinting into a wall. (i.e. holding their sprint key but not moving)

**Returns:**
- boolean — Is the player sprinting or not

[wiki](https://wiki.facepunch.com/gmod/Player:IsSprinting)

---

### Player:IsSuitEquipped · Shared
`Player:IsSuitEquipped() → boolean`

Returns whenever the player is equipped with the suit item.

**Returns:**
- boolean — Is the suit equipped or not.

> **Bug** ([#3449](https://github.com/Facepunch/garrysmod/issues/3449)): This will only work for the local player when used clientside.

[wiki](https://wiki.facepunch.com/gmod/Player:IsSuitEquipped)

---

### Player:IsSuperAdmin · Shared
`Player:IsSuperAdmin() → boolean`

Returns whether the player is a super admin.

Internally this is determined by [Player:IsUserGroup](https://wiki.facepunch.com/gmod/Player:IsUserGroup). See also [Player:IsAdmin](https://wiki.facepunch.com/gmod/Player:IsAdmin).

**Returns:**
- boolean — True if the player is a super admin.

[wiki](https://wiki.facepunch.com/gmod/Player:IsSuperAdmin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L22-L26)

---

### Player:IsTimingOut · Server
`Player:IsTimingOut() → boolean`

Returns `true` if the player is timing out (i.e. is losing connection), `false` otherwise.

A player is considered timing out when more than 4 seconds has elapsed since a network packet was received from given player.

**Returns:**
- boolean — Whether the player is timing out.

[wiki](https://wiki.facepunch.com/gmod/Player:IsTimingOut)

---

### Player:IsTyping · Shared
`Player:IsTyping() → boolean`

Returns whether the player is typing in their chat.

This may not work properly if the server uses a custom chatbox.

**Returns:**
- boolean — Whether the player is typing in their chat or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsTyping)

---

### Player:IsUserGroup · Shared
`Player:IsUserGroup(groupName: string) → boolean`

Returns whether the player is in specified group or not. See [Player:GetUserGroup](https://wiki.facepunch.com/gmod/Player:GetUserGroup) for a way to get player's user group.

**Arguments:**
- `groupName` (string) — Group to check the player for.

**Returns:**
- boolean — `true` if the player has the given user group.

[wiki](https://wiki.facepunch.com/gmod/Player:IsUserGroup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L32-L38)

---

### Player:IsVoiceAudible · Client
`Player:IsVoiceAudible() → boolean`

Returns if the player can be heard by the local player.

**Returns:**
- boolean — isAudible

[wiki](https://wiki.facepunch.com/gmod/Player:IsVoiceAudible)

---

### Player:IsWalking · Shared
`Player:IsWalking() → boolean`

Returns if the player currently walking. (`+walk` keybind)

**Returns:**
- boolean — `true` if the player is currently walking.

[wiki](https://wiki.facepunch.com/gmod/Player:IsWalking)

---

### Player:IsWorldClicking · Shared
`Player:IsWorldClicking() → boolean`

Returns whether the player is using the world clicking feature, see [Panel:SetWorldClicker](https://wiki.facepunch.com/gmod/Panel:SetWorldClicker)

**Returns:**
- boolean — Is the player world clicking or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsWorldClicking)

---

### Player:IsWorldClickingDisabled · Shared
`Player:IsWorldClickingDisabled() → boolean`

Returns whether the world clicking is disabled for given player or not. See [Player:DisableWorldClicking](https://wiki.facepunch.com/gmod/Player:DisableWorldClicking).

**Returns:**
- boolean — Whether the world clicking is disabled or not.

[wiki](https://wiki.facepunch.com/gmod/Player:IsWorldClickingDisabled)

---

### Player:KeyDown · Shared
`Player:KeyDown(key: number) → boolean`

Returns whether a key is down. This is not networked to other players, meaning only the local client can see the keys they are pressing.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key, see IN

**Returns:**
- boolean — whether the key is down or not.

[wiki](https://wiki.facepunch.com/gmod/Player:KeyDown)

---

### Player:KeyDownLast · Shared
`Player:KeyDownLast(key: number) → boolean`

Gets whether a key was down one tick ago.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key, see IN

**Returns:**
- boolean — Is key down ?

[wiki](https://wiki.facepunch.com/gmod/Player:KeyDownLast)

---

### Player:KeyPressed · Shared
`Player:KeyPressed(key: number) → boolean`

Gets whether a key was just pressed this tick.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Corresponds to an IN.

**Returns:**
- boolean — Was pressed or not

[wiki](https://wiki.facepunch.com/gmod/Player:KeyPressed)

---

### Player:KeyReleased · Shared
`Player:KeyReleased(key: number) → boolean`

Gets whether a key was just released this tick.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key, see IN

**Returns:**
- boolean — Was released or not

[wiki](https://wiki.facepunch.com/gmod/Player:KeyReleased)

---

### Player:Kick · Server
`Player:Kick(reason: string = No reason given)`

Kicks the player from the server.

**Arguments:**
- `reason` (string, default `No reason given`) — Reason to show for disconnection.

> **Note:** This can not be run before the player has fully joined in. Use [game.KickID](https://wiki.facepunch.com/gmod/game.KickID) for that.

[wiki](https://wiki.facepunch.com/gmod/Player:Kick)

---

### Player:Kill · Server
`Player:Kill()`

Kills a player and calls [GM:PlayerDeath](https://wiki.facepunch.com/gmod/GM:PlayerDeath).

[wiki](https://wiki.facepunch.com/gmod/Player:Kill)

---

### Player:KillSilent · Server
`Player:KillSilent()`

Kills a player without notifying the rest of the server.

This will call [GM:PlayerSilentDeath](https://wiki.facepunch.com/gmod/GM:PlayerSilentDeath) instead of [GM:PlayerDeath](https://wiki.facepunch.com/gmod/GM:PlayerDeath).

[wiki](https://wiki.facepunch.com/gmod/Player:KillSilent)

---

### Player:LagCompensation · Shared
`Player:LagCompensation(lagCompensation: boolean)`

This allows the server to mitigate the lag of the player by moving back all the entities that can be lag compensated to the time the player attacked with his weapon.

This technique is most commonly used on things that hit other entities instantaneously, such as traces.



Lag compensation only works for players and entities that have been enabled with [Entity:SetLagCompensated](https://wiki.facepunch.com/gmod/Entity:SetLagCompensated)

Despite being defined shared, it can only be used server-side in a [Predicted Hook](https://wiki.facepunch.com/gmod/~search?q=%3Cpredicted%3EYes).

**Arguments:**
- `lagCompensation` (boolean) — The state of the lag compensation, true to enable and false to disable.

> **Note:** [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets) calls this function internally.
> **Warning:** This function NEEDS to be disabled after you're done with it or it will break the movement of the entities affected!
> **Bug** ([#3683](https://github.com/Facepunch/garrysmod/issues/3683)): Lag compensation does not support pose parameters.

[wiki](https://wiki.facepunch.com/gmod/Player:LagCompensation)

---

### Player:LastHitGroup · Server
`Player:LastHitGroup() → number`

Returns the hitgroup where the player was last hit.

**Returns:**
- number — Hitgroup, see HITGROUP

[wiki](https://wiki.facepunch.com/gmod/Player:LastHitGroup)

---

### Player:LimitHit · Server
`Player:LimitHit(type: string)`

Shows "limit hit" notification in sandbox.

**Arguments:**
- `type` (string) — Type of hit limit.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Player:LimitHit) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L120-L124)

---

### Player:LocalEyeAngles · Shared
`Player:LocalEyeAngles() → Angle`

Returns the direction a player is looking as a entity/local-oriented angle.

Unlike [Entity:EyeAngles](https://wiki.facepunch.com/gmod/Entity:EyeAngles), this function does not include angles of the Player's [Entity:GetParent](https://wiki.facepunch.com/gmod/Entity:GetParent).

**Returns:**
- Angle — The local eye angles.

> **Bug:** Does not work correctly clientside for non local players when in a vehicle. (validate: when parented in general?)

[wiki](https://wiki.facepunch.com/gmod/Player:LocalEyeAngles)

---

### Player:Lock · Server
`Player:Lock()`

Stops a player from using any inputs, such as moving, turning, or attacking. Key binds are still called. Similar to [Player:Freeze](https://wiki.facepunch.com/gmod/Player:Freeze) but the player takes no damage.

Adds the [FL_FROZEN](https://wiki.facepunch.com/gmod/Enums/FL) and [FL_GODMODE](https://wiki.facepunch.com/gmod/Enums/FL) flags to the player.

[wiki](https://wiki.facepunch.com/gmod/Player:Lock)

---

### Player:MotionSensorPos · Shared
`Player:MotionSensorPos(bone: number) → Vector`

Returns the position of a Kinect bone.

**Arguments:**
- `bone` (number) — Bone to get the position of.

**Returns:**
- Vector — Position of the bone.

[wiki](https://wiki.facepunch.com/gmod/Player:MotionSensorPos)

---

### Player:Name · Shared · `DEPRECATED`
`Player:Name() → string`

Returns the player's nick name. Identical to [Player:Nick](https://wiki.facepunch.com/gmod/Player:Nick) and [Player:GetName](https://wiki.facepunch.com/gmod/Player:GetName).

**Returns:**
- string — Player's name.

[wiki](https://wiki.facepunch.com/gmod/Player:Name) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L57-L57)

---

### Player:Nick · Shared
`Player:Nick() → string`

Returns the player's nick name also known as display name, as it appears in Steam.

**Returns:**
- string — Player's nick name

[wiki](https://wiki.facepunch.com/gmod/Player:Nick)

---

### Player:OwnerSteamID64 · Server
`Player:OwnerSteamID64() → string`

Returns the 64-bit SteamID aka CommunityID of the Steam Account that owns the Garry's Mod license this player is using. This is useful for detecting players using Steam Family Sharing.

If player is not using Steam Family Sharing, this will return the player's actual SteamID64().

**Returns:**
- string — The 64bit SteamID

> **Note:** This data will only be available after the player has fully authenticated with Steam. See [Player:IsFullyAuthenticated](https://wiki.facepunch.com/gmod/Player:IsFullyAuthenticated).

[wiki](https://wiki.facepunch.com/gmod/Player:OwnerSteamID64)

---

### Player:PacketLoss · Shared
`Player:PacketLoss() → number`

Returns the percentage of packets lost by the client. It is not networked so it only returns 0 when run clientside.

**Returns:**
- number — Percentage of packets lost (0-100)

[wiki](https://wiki.facepunch.com/gmod/Player:PacketLoss)

---

### Player:PhysgunUnfreeze · Shared
`Player:PhysgunUnfreeze() → number`

Unfreezes the props player is looking at. This is essentially the same as pressing reload with the physics gun, including double press for unfreeze all.

For freezing props, use [PhysObj:EnableMotion](https://wiki.facepunch.com/gmod/PhysObj:EnableMotion).

**Returns:**
- number — Number of props unfrozen.

[wiki](https://wiki.facepunch.com/gmod/Player:PhysgunUnfreeze) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L53-L96)

---

### Player:PickupObject · Server
`Player:PickupObject(entity: Entity)`

This makes the player hold (same as pressing  on a small prop) given entity.

Not to be confused with picking up items like ammo or health kits.

This picks up the passed entity regardless of its mass or distance from the player.

**Arguments:**
- `entity` (Entity) — Entity to pick up.

[wiki](https://wiki.facepunch.com/gmod/Player:PickupObject)

---

### Player:PickupWeapon · Server
`Player:PickupWeapon(wep: Weapon, ammoOnly: boolean = false) → boolean`

Forces the player to pickup an existing weapon entity. The player will not pick up the weapon if they already own a weapon of given type, or if the player could not normally have this weapon in their inventory.

This function **will** bypass [GM:PlayerCanPickupWeapon](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupWeapon).

**Arguments:**
- `wep` (Weapon) — The weapon to try to pick up.
- `ammoOnly` (boolean, default `false`) — If set to true, the player will only attempt to pick up the ammo from the weapon.

**Returns:**
- `result` (boolean) — Whether the player succeeded in picking up the weapon or not.

[wiki](https://wiki.facepunch.com/gmod/Player:PickupWeapon)

---

### Player:Ping · Shared
`Player:Ping() → number`

Returns the player's ping to server.

**Returns:**
- number — The player's ping.

[wiki](https://wiki.facepunch.com/gmod/Player:Ping)

---

### Player:PlayStepSound · Server
`Player:PlayStepSound(volume: number = 1)`

Plays the correct step sound according to what the player is staying on.

**Arguments:**
- `volume` (number, default `1`) — Volume for the sound, in range from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/Player:PlayStepSound)

---

### Player:PrintMessage · Shared
`Player:PrintMessage(type: number, message: string)`

Displays a message either in their chat, console, or center of the screen. See also [PrintMessage](https://wiki.facepunch.com/gmod/Global.PrintMessage).

**Arguments:**
- `type` (number, enum [HUD](https://wiki.facepunch.com/gmod/Enums/HUD)) — Which type of message should be sent to the player (HUD).
- `message` (string) — Message to be sent to the player.

> **Note:** When called serverside, this uses the archaic user message system (the [umsg](https://wiki.facepunch.com/gmod/umsg)) and hence is limited to ≈250 characters.
> 
> `HUD_PRINTCENTER` will not work when this is called clientside.

[wiki](https://wiki.facepunch.com/gmod/Player:PrintMessage)

---

### Player:RemoveAllAmmo · Server
`Player:RemoveAllAmmo()`

Removes all ammo from a certain player

[wiki](https://wiki.facepunch.com/gmod/Player:RemoveAllAmmo)

---

### Player:RemoveAllItems · Server
`Player:RemoveAllItems()`

Removes all weapons and ammo from the player.

[wiki](https://wiki.facepunch.com/gmod/Player:RemoveAllItems)

---

### Player:RemoveAmmo · Shared
`Player:RemoveAmmo(ammoCount: number, ammoName: string)`

Removes the amount of the specified ammo from the player.

**Arguments:**
- `ammoCount` (number) — The amount of ammunition to remove.
- `ammoName` (string) — The name of the ammunition to remove from.

[wiki](https://wiki.facepunch.com/gmod/Player:RemoveAmmo)

---

### Player:RemovePData · Shared
`Player:RemovePData(key: string) → boolean`

Removes a **P**ersistent **Data** key-value pair from the SQL database. (`sv.db` when called on server, `cl.db` when called on client)

Internally uses the [sql](https://wiki.facepunch.com/gmod/sql) library. See [util.RemovePData](https://wiki.facepunch.com/gmod/util.RemovePData) for cases when the player is not currently on the server.

**Arguments:**
- `key` (string) — Key to remove

**Returns:**
- boolean — true is succeeded, false otherwise

> **Note:** PData is not networked from servers to clients!
> **Note:** This function internally uses [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which can cause collisions (two or more players sharing the same PData entry). [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData) now replaces all instances of [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) with [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) when running [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData)

[wiki](https://wiki.facepunch.com/gmod/Player:RemovePData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L148-L164)

---

### Player:RemoveSuit · Server
`Player:RemoveSuit()`

Strips the player's suit item.

[wiki](https://wiki.facepunch.com/gmod/Player:RemoveSuit)

---

### Player:ResetHull · Shared
`Player:ResetHull()`

Resets both normal and duck hulls to their default values.

[wiki](https://wiki.facepunch.com/gmod/Player:ResetHull)

---

### Player:Say · Server
`Player:Say(text: string, teamOnly: boolean = false)`

Forces the player to say whatever the first argument is. Works on bots too.

**Arguments:**
- `text` (string) — The text to force the player to say.
- `teamOnly` (boolean, default `false`) — Whether to send this message to our own team only.

> **Note:** This function ignores the default chat message cooldown
> **Warning:** The argument can only contain 126 characters. [Source SDK 2013](https://github.com/ValveSoftware/source-sdk-2013/blob/0d8dceea4310fde5706b3ce1c70609d72a38efdf/sp/src/game/server/client.cpp#L84-L86)

[wiki](https://wiki.facepunch.com/gmod/Player:Say)

---

### Player:ScreenFade · Shared
`Player:ScreenFade(flags: number, color: Color = color_white, fadeTime: number, fadeHold: number)`

Fades the screen

**Arguments:**
- `flags` (number, enum [SCREENFADE](https://wiki.facepunch.com/gmod/Enums/SCREENFADE)) — Fade flags defined with SCREENFADE.
- `color` (Color, default `color_white`) — The color of the screenfade
- `fadeTime` (number) — Fade(in/out) effect transition time ( From no fade to full fade and vice versa ).
- `fadeHold` (number) — Fade effect hold time.

[wiki](https://wiki.facepunch.com/gmod/Player:ScreenFade)

---

### Player:SelectWeapon · Server
`Player:SelectWeapon(className: string)`

Sets the active weapon of the player by its class name.

**Arguments:**
- `className` (string) — The class name of the weapon to switch to.

> **Note:** This will trigger the weapon switch event and associated animations. To switch weapons silently, use [Player:SetActiveWeapon](https://wiki.facepunch.com/gmod/Player:SetActiveWeapon).
> **Warning:** This will switch the weapon out of prediction, causing delay on the client and [WEAPON:Deploy](https://wiki.facepunch.com/gmod/WEAPON:Deploy) and [WEAPON:Holster](https://wiki.facepunch.com/gmod/WEAPON:Holster) to be called out of prediction. Try using [CUserCmd:SelectWeapon](https://wiki.facepunch.com/gmod/CUserCmd:SelectWeapon) or [input.SelectWeapon](https://wiki.facepunch.com/gmod/input.SelectWeapon), instead.

[wiki](https://wiki.facepunch.com/gmod/Player:SelectWeapon)

---

### Player:SendHint · Server
`Player:SendHint(name: string, delay: number)`

Sends a hint to a player.

**Arguments:**
- `name` (string) — Name/class/index of the hint.
- `delay` (number) — Delay in seconds before showing the hint

> **Note:** This function is only available in Sandbox and its derivatives. Since this adds `#Hint_` to the beginning of each message, you should only use it with default hint messages, or those cached with [language.Add](https://wiki.facepunch.com/gmod/language.Add). For hints with custom text, look at [notification.AddLegacy](https://wiki.facepunch.com/gmod/notification.AddLegacy).

[wiki](https://wiki.facepunch.com/gmod/Player:SendHint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L119-L127)

---

### Player:SendLua · Server
`Player:SendLua(script: string)`

Executes a simple Lua string on the player.

**Arguments:**
- `script` (string) — The script to execute, limited to 6000 bytes.

> **Note:** If you need to use this function more than once consider using [net](https://wiki.facepunch.com/gmod/net) library. Send net message and make the entire code you want to execute in [net.Receive](https://wiki.facepunch.com/gmod/net.Receive) on client.

[wiki](https://wiki.facepunch.com/gmod/Player:SendLua)

---

### Player:SetActiveWeapon · Server
`Player:SetActiveWeapon(weapon: Weapon)`

Sets the player's active weapon. You should use [CUserCmd:SelectWeapon](https://wiki.facepunch.com/gmod/CUserCmd:SelectWeapon) or [Player:SelectWeapon](https://wiki.facepunch.com/gmod/Player:SelectWeapon), instead in most cases.

This function will not trigger the weapon switch events or associated equip animations. It will bypass 
 [GM:PlayerSwitchWeapon](https://wiki.facepunch.com/gmod/GM:PlayerSwitchWeapon) and the currently active weapon's [WEAPON:Holster](https://wiki.facepunch.com/gmod/WEAPON:Holster) return value.

**Arguments:**
- `weapon` (Weapon) — The weapon to equip.

[wiki](https://wiki.facepunch.com/gmod/Player:SetActiveWeapon)

---

### Player:SetActivity · Server
`Player:SetActivity(act: number)`

Sets the player's activity.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The new activity to set.

[wiki](https://wiki.facepunch.com/gmod/Player:SetActivity)

---

### Player:SetAllowFullRotation · Shared
`Player:SetAllowFullRotation(Allowed: boolean)`

Set if the players' model is allowed to rotate around the pitch and roll axis.

**Arguments:**
- `Allowed` (boolean) — Allowed to rotate

[wiki](https://wiki.facepunch.com/gmod/Player:SetAllowFullRotation)

---

### Player:SetAllowWeaponsInVehicle · Server
`Player:SetAllowWeaponsInVehicle(allow: boolean)`

Allows player to use their weapons in a vehicle. You need to call this before entering a vehicle.

**Arguments:**
- `allow` (boolean) — Show we allow player to use their weapons in a vehicle or not.

> **Bug** ([#1277](https://github.com/Facepunch/garrysmod/issues/1277)): Shooting in a vehicle fires two bullets.

[wiki](https://wiki.facepunch.com/gmod/Player:SetAllowWeaponsInVehicle)

---

### Player:SetAmmo · Shared
`Player:SetAmmo(ammoCount: number, ammoType: any)`

Sets the amount of the specified ammo for the player.

**Arguments:**
- `ammoCount` (number) — The amount of ammunition to set.
- `ammoType` (any) — The ammunition type.

[wiki](https://wiki.facepunch.com/gmod/Player:SetAmmo)

---

### Player:SetArmor · Server
`Player:SetArmor(amount: number)`

Sets the player armor value.

See [GM:HandlePlayerArmorReduction](https://wiki.facepunch.com/gmod/GM:HandlePlayerArmorReduction) for a hook that allows manipulating what armor does.

**Arguments:**
- `amount` (number) — The amount to set the armor value of the player to.

[wiki](https://wiki.facepunch.com/gmod/Player:SetArmor)

---

### Player:SetAvoidPlayers · Shared
`Player:SetAvoidPlayers(avoidPlayers: boolean)`

Pushes the player away from other players whenever the player inside another players' bounding box.

This avoidance is performed clientside by altering movement sent to server.

This applies to players within a single team. ([Player:Team](https://wiki.facepunch.com/gmod/Player:Team))

**Arguments:**
- `avoidPlayers` (boolean) — Whether to avoid teammates, or not.

[wiki](https://wiki.facepunch.com/gmod/Player:SetAvoidPlayers)

---

### Player:SetCanWalk · Shared
`Player:SetCanWalk(canWalk: boolean)`

Set if the player should be allowed to walk using the (default) alt key. (`+walk` keybind)

**Arguments:**
- `canWalk` (boolean) — `true` allows the player to walk.

[wiki](https://wiki.facepunch.com/gmod/Player:SetCanWalk)

---

### Player:SetCanZoom · Shared
`Player:SetCanZoom(canZoom: boolean)`

Sets whether the player can use the HL2 suit zoom (`+zoom` bind) or not.

**Arguments:**
- `canZoom` (boolean) — Whether to make the player able or unable to zoom.

[wiki](https://wiki.facepunch.com/gmod/Player:SetCanZoom)

---

### Player:SetClassID · Shared · `INTERNAL`
`Player:SetClassID(classID: number)`

Sets the player's class id.

**Arguments:**
- `classID` (number) — The class id the player is being set with.

[wiki](https://wiki.facepunch.com/gmod/Player:SetClassID)

---

### Player:SetCrouchedWalkSpeed · Shared
`Player:SetCrouchedWalkSpeed(speed: number)`

Sets the crouched walk speed multiplier.

Has no effect for values above 1.

See also [Player:SetWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed) and [Player:GetCrouchedWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetCrouchedWalkSpeed).

**Arguments:**
- `speed` (number) — The walk speed multiplier that crouch speed should be.

[wiki](https://wiki.facepunch.com/gmod/Player:SetCrouchedWalkSpeed)

---

### Player:SetCurrentViewOffset · Shared
`Player:SetCurrentViewOffset(viewOffset: Vector)`

Sets the **actual** view offset which equals the difference between the players actual position and their view when standing.

Do not confuse with [Player:SetViewOffset](https://wiki.facepunch.com/gmod/Player:SetViewOffset) and [Player:SetViewOffsetDucked](https://wiki.facepunch.com/gmod/Player:SetViewOffsetDucked)

**Arguments:**
- `viewOffset` (Vector) — The new view offset.

[wiki](https://wiki.facepunch.com/gmod/Player:SetCurrentViewOffset)

---

### Player:SetDeaths · Server
`Player:SetDeaths(deathCount: number)`

Sets a player's death count

**Arguments:**
- `deathCount` (number) — Number of deaths (positive or negative)

[wiki](https://wiki.facepunch.com/gmod/Player:SetDeaths)

---

### Player:SetDrivingEntity · Shared · `INTERNAL`
`Player:SetDrivingEntity(drivingEntity: Entity = NULL, drivingMode: number)`

Sets the driving entity and driving mode.

Use [drive.PlayerStartDriving](https://wiki.facepunch.com/gmod/drive.PlayerStartDriving) instead, see [Entity Driving](https://wiki.facepunch.com/gmod/Entity%20Driving).

**Arguments:**
- `drivingEntity` (Entity, default `NULL`) — The entity the player should drive.
- `drivingMode` (number) — The driving mode index.

[wiki](https://wiki.facepunch.com/gmod/Player:SetDrivingEntity)

---

### Player:SetDSP · Shared
`Player:SetDSP(dspEffectId: number, fastReset: boolean)`

Activates a given DSP (Digital Signal Processor) effect on all sounds that the player hears. This is equivalent to setting `dsp_player` convar on the player.

		To apply a DSP effect to individual sounds, see [CSoundPatch:SetDSP](https://wiki.facepunch.com/gmod/CSoundPatch:SetDSP)

**Arguments:**
- `dspEffectId` (number) — The index of the DSP sound filter to apply.
- `fastReset` (boolean) — If set to true the sound filter will be removed faster.

[wiki](https://wiki.facepunch.com/gmod/Player:SetDSP)

---

### Player:SetDuckSpeed · Shared
`Player:SetDuckSpeed(duckSpeed: number)`

Sets how quickly a player ducks.

**Arguments:**
- `duckSpeed` (number) — How quickly the player will duck.

> **Bug** ([#2722](https://github.com/Facepunch/garrysmod/issues/2722)): This will not work for values >= 1.

[wiki](https://wiki.facepunch.com/gmod/Player:SetDuckSpeed)

---

### Player:SetEyeAngles · Shared
`Player:SetEyeAngles(angle: Angle)`

Sets the local angle of the player's view (may rotate body too if angular difference is large)

**Arguments:**
- `angle` (Angle) — Angle to set the view to

> **Note:** This function works differently when the player is in a vehicle. In that case passing `Angle(0, 90, 0)` will have the player look forward (out the windshield) and `Angle(0, 0, 0)` will have them look to the right.

[wiki](https://wiki.facepunch.com/gmod/Player:SetEyeAngles)

---

### Player:SetFlashlightColor · Client
`Player:SetFlashlightColor(color: Color = Color(255,255,255))`

Sets the color of a player's flashlight. 
		Can be used on other players.

**Arguments:**
- `color` (Color, default `Color(255,255,255)`) — Flashlight color

[wiki](https://wiki.facepunch.com/gmod/Player:SetFlashlightColor)

---

### Player:SetFOV · Shared
`Player:SetFOV(fov: number, time: number = 0, requester: Entity = self)`

Set a player's FOV (Field Of View) over a certain amount of time.

This is meant to be called on the server or shared (for prediction), it will have no effect if called clientside only. You may want to use [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) for that instead.

**Arguments:**
- `fov` (number) — the angle of perception (FOV).
- `time` (number, default `0`) — the time it takes to transition to the FOV expressed in a floating point.
- `requester` (Entity, default `self`) — The requester or "owner" of the zoom event.

[wiki](https://wiki.facepunch.com/gmod/Player:SetFOV)

---

### Player:SetFrags · Server
`Player:SetFrags(fragCount: number)`

Sets a player's frags (kills)

**Arguments:**
- `fragCount` (number) — Number of frags (positive or negative)

[wiki](https://wiki.facepunch.com/gmod/Player:SetFrags)

---

### Player:SetHands · Shared
`Player:SetHands(hands: Entity)`

Sets the hands entity of a player.

The hands entity is an entity introduced in Garry's Mod 13 and it's used to show the player's hands attached to the viewmodel.
This is similar to the approach used in L4D and CS:GO, for more information on how to implement this system in your gamemode visit [Using Viewmodel Hands](https://wiki.facepunch.com/gmod/Using%20Viewmodel%20Hands).

**Arguments:**
- `hands` (Entity) — The hands entity to set

[wiki](https://wiki.facepunch.com/gmod/Player:SetHands)

---

### Player:SetHoveredWidget · Shared
`Player:SetHoveredWidget(widget: Entity = NULL)`

Sets the widget that is currently hovered by the player's mouse.

**Arguments:**
- `widget` (Entity, default `NULL`) — The widget entity that the player is hovering.

[wiki](https://wiki.facepunch.com/gmod/Player:SetHoveredWidget)

---

### Player:SetHull · Shared
`Player:SetHull(mins: Vector, maxs: Vector)`

Sets the size of the [Player's](https://wiki.facepunch.com/gmod/Player) [Axis-Aligned Bounding Box (AABB)](https://en.wikipedia.org/wiki/Minimum_bounding_box) used for physics and movement [Hull Traces](https://wiki.facepunch.com/gmod/util.TraceHull).

		See also: [Player:GetHull](https://wiki.facepunch.com/gmod/Player:GetHull), [Player:SetHullDuck](https://wiki.facepunch.com/gmod/Player:SetHullDuck), [Player:GetHullDuck](https://wiki.facepunch.com/gmod/Player:GetHullDuck)

**Arguments:**
- `mins` (Vector) — The hull mins, the lowest corner of the Player's bounding box.
- `maxs` (Vector) — The hull maxs, the highest corner of the Player's bounding box, opposite of the mins.

> **Note:** This value is **not** replicated automatically to clients and must be manually called in both the Server and Client [Realms](https://wiki.facepunch.com/gmod/States).

[wiki](https://wiki.facepunch.com/gmod/Player:SetHull)

---

### Player:SetHullDuck · Shared
`Player:SetHullDuck(mins: Vector, maxs: Vector)`

Sets the size of the [Player's](https://wiki.facepunch.com/gmod/Player) [Axis-Aligned Bounding Box (AABB)](https://en.wikipedia.org/wiki/Minimum_bounding_box) used for physics and movement [Hull Traces](https://wiki.facepunch.com/gmod/util.TraceHull) while they are crouching (or "Ducking").

		See also: [Player:GetHullDuck](https://wiki.facepunch.com/gmod/Player:GetHullDuck), [Player:GetHull](https://wiki.facepunch.com/gmod/Player:GetHull), [Player:SetHull](https://wiki.facepunch.com/gmod/Player:SetHull)

**Arguments:**
- `mins` (Vector) — The hull mins, the lowest corner of the Player's bounding box while crouching.
- `maxs` (Vector) — The hull maxs, the highest corner of the Player's crouching bounding box, opposite of the mins.

> **Note:** This value is **not** replicated automatically to clients and must be manually called in both the Server and Client [Realms](https://wiki.facepunch.com/gmod/States).

[wiki](https://wiki.facepunch.com/gmod/Player:SetHullDuck)

---

### Player:SetJumpPower · Shared
`Player:SetJumpPower(jumpPower: number)`

Sets the jump power, eg. the velocity that will be applied to the player when they jump.

**Arguments:**
- `jumpPower` (number) — The new jump velocity.

[wiki](https://wiki.facepunch.com/gmod/Player:SetJumpPower)

---

### Player:SetLadderClimbSpeed · Shared
`Player:SetLadderClimbSpeed(speed: number)`

Sets the player's ladder climbing speed.

See [Player:SetWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed) for normal walking speed, [Player:SetRunSpeed](https://wiki.facepunch.com/gmod/Player:SetRunSpeed) for sprinting speed and [Player:SetSlowWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetSlowWalkSpeed) for slow walking speed.

**Arguments:**
- `speed` (number) — The ladder climbing speed.

[wiki](https://wiki.facepunch.com/gmod/Player:SetLadderClimbSpeed)

---

### Player:SetLaggedMovementValue · Server
`Player:SetLaggedMovementValue(timescale: number)`

Slows down the player movement simulation by the timescale, this is used internally in the HL2 weapon stripping sequence.

It achieves such behavior by multiplying the [FrameTime](https://wiki.facepunch.com/gmod/Global.FrameTime) by the specified timescale at the start of the movement simulation and then restoring it afterwards.

**Arguments:**
- `timescale` (number) — The timescale multiplier.

> **Note:** This is reset to 1 on spawn.
> 
> There is no weapon counterpart to this, you'll have to hardcode the multiplier in the weapon or call [Weapon:SetNextPrimaryFire](https://wiki.facepunch.com/gmod/Weapon:SetNextPrimaryFire) / [Weapon:SetNextSecondaryFire](https://wiki.facepunch.com/gmod/Weapon:SetNextSecondaryFire) manually.

[wiki](https://wiki.facepunch.com/gmod/Player:SetLaggedMovementValue)

---

### Player:SetLastHitGroup · Server
`Player:SetLastHitGroup(hitgroup: number)`

Sets the hitgroup where the player was last hit.

**Arguments:**
- `hitgroup` (number, enum [HITGROUP](https://wiki.facepunch.com/gmod/Enums/HITGROUP)) — The hitgroup to set as the "last hit", see HITGROUP.

[wiki](https://wiki.facepunch.com/gmod/Player:SetLastHitGroup)

---

### Player:SetMaxArmor · Server
`Player:SetMaxArmor(maxarmor: number)`

Sets the maximum amount of armor the player should have. This affects default built-in armor pickups, but not [Player:SetArmor](https://wiki.facepunch.com/gmod/Player:SetArmor).

**Arguments:**
- `maxarmor` (number) — The new max armor value.

[wiki](https://wiki.facepunch.com/gmod/Player:SetMaxArmor)

---

### Player:SetMaxSpeed · Shared
`Player:SetMaxSpeed(walkSpeed: number)`

Sets the maximum speed which the player can move at.

**Arguments:**
- `walkSpeed` (number) — The maximum speed.

> **Note:** This is called automatically by the engine. If you wish to limit player speed without setting their run/sprint speeds, see [CMoveData:SetMaxClientSpeed](https://wiki.facepunch.com/gmod/CMoveData:SetMaxClientSpeed).

[wiki](https://wiki.facepunch.com/gmod/Player:SetMaxSpeed)

---

### Player:SetMuted · Client
`Player:SetMuted(mute: boolean)`

Sets if the player should be voicechat muted locally.

**Arguments:**
- `mute` (boolean) — Mute or unmute.

[wiki](https://wiki.facepunch.com/gmod/Player:SetMuted)

---

### Player:SetNoCollideWithTeammates · Shared
`Player:SetNoCollideWithTeammates(shouldNotCollide: boolean)`

Sets whenever the player should not collide with their teammates, based on their [Player:Team](https://wiki.facepunch.com/gmod/Player:Team).

**Arguments:**
- `shouldNotCollide` (boolean) — `true` to disable, `false` to enable collision.

> **Note:** This will only work for teams with ID 1 to 4 due to internal Engine limitations.
> **Note:** This causes traces with [COLLISION_GROUP_PLAYER](https://wiki.facepunch.com/gmod/Enums/COLLISION_GROUP) to pass through players.

[wiki](https://wiki.facepunch.com/gmod/Player:SetNoCollideWithTeammates)

---

### Player:SetNoTarget · Server
`Player:SetNoTarget(visibility: boolean)`

Sets the players visibility towards NPCs.

Internally this toggles the [FL_NOTARGET](https://wiki.facepunch.com/gmod/Enums/FL) flag, which you can manually test for using [Entity:IsFlagSet](https://wiki.facepunch.com/gmod/Entity:IsFlagSet)

**Arguments:**
- `visibility` (boolean) — The visibility.

[wiki](https://wiki.facepunch.com/gmod/Player:SetNoTarget)

---

### Player:SetObserverMode · Shared
`Player:SetObserverMode(mode: number)`

Sets the players observer mode. You must start the spectating first with [Player:Spectate](https://wiki.facepunch.com/gmod/Player:Spectate).

**Arguments:**
- `mode` (number, enum [OBS_MODE](https://wiki.facepunch.com/gmod/Enums/OBS_MODE)) — Spectator mode using OBS_MODE.

[wiki](https://wiki.facepunch.com/gmod/Player:SetObserverMode)

---

### Player:SetPData · Shared
`Player:SetPData(key: string, value: any) → boolean`

Writes a **P**ersistent **Data** key-value pair to the SQL database. (`sv.db` when called on server, `cl.db` when called on client)

Internally uses the [sql](https://wiki.facepunch.com/gmod/sql) library. See [util.SetPData](https://wiki.facepunch.com/gmod/util.SetPData) for cases when the player is not currently on the server.

**Arguments:**
- `key` (string) — Name of the PData key
- `value` (any) — Value to write to the key (must be an SQL valid data type, such as a string or integer)

**Returns:**
- boolean — Whether the operation was successful or not

> **Note:** PData is not networked from servers to clients!
> **Note:** This function internally uses [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which could have caused collisions (two or more players sharing the same PData entry). [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData) now replaces all instances of [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) with [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) when running [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData)

[wiki](https://wiki.facepunch.com/gmod/Player:SetPData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L133-L146)

---

### Player:SetPlayerColor · Shared
`Player:SetPlayerColor(Color: Vector)`

Sets the player model's color. The part of the model that is colored is determined by the model itself, and is different for each model.

**Arguments:**
- `Color` (Vector) — This is the color to be set.

[wiki](https://wiki.facepunch.com/gmod/Player:SetPlayerColor)

---

### Player:SetPressedWidget · Shared
`Player:SetPressedWidget(pressedWidget: Entity = NULL)`

Sets the widget that is currently in use by the player's mouse.

Having a pressed widget stops the player from firing their weapon to allow input to be passed onto the widget.

**Arguments:**
- `pressedWidget` (Entity, default `NULL`) — The widget the player is currently using.

[wiki](https://wiki.facepunch.com/gmod/Player:SetPressedWidget)

---

### Player:SetRenderAngles · Shared
`Player:SetRenderAngles(ang: Angle)`

Sets the render angles of a player. Value set by this function is reset to player's angles ([Entity:GetAngles](https://wiki.facepunch.com/gmod/Entity:GetAngles)) right after [GM:UpdateAnimation](https://wiki.facepunch.com/gmod/GM:UpdateAnimation).

**Arguments:**
- `ang` (Angle) — The new render angles to set

[wiki](https://wiki.facepunch.com/gmod/Player:SetRenderAngles)

---

### Player:SetRunSpeed · Shared
`Player:SetRunSpeed(runSpeed: number)`

Sets the player's sprint speed.

See also [Player:GetRunSpeed](https://wiki.facepunch.com/gmod/Player:GetRunSpeed), [Player:SetWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed) and [Player:SetMaxSpeed](https://wiki.facepunch.com/gmod/Player:SetMaxSpeed).

**Arguments:**
- `runSpeed` (number) — The new sprint speed when `sv_friction` is below `10`.

> **Note:** player_default class run speed is: `400`

[wiki](https://wiki.facepunch.com/gmod/Player:SetRunSpeed)

---

### Player:SetSlowWalkSpeed · Shared
`Player:SetSlowWalkSpeed(speed: number)`

Sets the player's slow walking speed, which is activated via  keybind.

See [Player:SetWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed) for normal walking speed, [Player:SetRunSpeed](https://wiki.facepunch.com/gmod/Player:SetRunSpeed) for sprinting speed and [Player:SetLadderClimbSpeed](https://wiki.facepunch.com/gmod/Player:SetLadderClimbSpeed) for ladder climb speed.

**Arguments:**
- `speed` (number) — The new slow walking speed.

[wiki](https://wiki.facepunch.com/gmod/Player:SetSlowWalkSpeed)

---

### Player:SetStepSize · Shared
`Player:SetStepSize(stepHeight: number)`

Sets the maximum height a player can step onto without jumping.

**Arguments:**
- `stepHeight` (number) — The new maximum height the player can step onto without jumping

[wiki](https://wiki.facepunch.com/gmod/Player:SetStepSize)

---

### Player:SetSuitPower · Shared
`Player:SetSuitPower(power: number)`

Sets the player's HEV suit power.

**Arguments:**
- `power` (number) — The new suit power.

> **Bug** ([#3449](https://github.com/Facepunch/garrysmod/issues/3449)): This will only work for the local player when used clientside.

[wiki](https://wiki.facepunch.com/gmod/Player:SetSuitPower)

---

### Player:SetSuppressPickupNotices · Shared
`Player:SetSuppressPickupNotices(doSuppress: boolean)`

Sets whenever to suppress the pickup notification for the player.

**Arguments:**
- `doSuppress` (boolean) — Whenever to suppress the notice or not.

[wiki](https://wiki.facepunch.com/gmod/Player:SetSuppressPickupNotices)

---

### Player:SetTeam · Server
`Player:SetTeam(team: number)`

Sets the player to the chosen team. The value is networked to clients at reduced bit count (16 bits) as as a signed value, so the real range is [-32768, 32767].

Can be retrieved via [Player:Team](https://wiki.facepunch.com/gmod/Player:Team)

**Arguments:**
- `team` (number) — The team that the player is being set to.

[wiki](https://wiki.facepunch.com/gmod/Player:SetTeam)

---

### Player:SetUnDuckSpeed · Shared
`Player:SetUnDuckSpeed(UnDuckSpeed: number)`

Sets how quickly a player un-ducks

**Arguments:**
- `UnDuckSpeed` (number) — How quickly the player will un-duck

[wiki](https://wiki.facepunch.com/gmod/Player:SetUnDuckSpeed)

---

### Player:SetupHands · Server
`Player:SetupHands(ent: Entity = nil)`

Sets up the player's hands for the viewmodel. Calls [GM:PlayerSetHandsModel](https://wiki.facepunch.com/gmod/GM:PlayerSetHandsModel) to determine the model. If no entity is provided, uses the player's own hands model. If spectating another entity, pass that entity to use its hands model instead.

**Arguments:**
- `ent` (Entity, default `nil`) — If the player is spectating an entity, this should be the entity the player is spectating, so we can use its hands model instead.

[wiki](https://wiki.facepunch.com/gmod/Player:SetupHands) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L185-L200)

---

### Player:SetUserGroup · Server
`Player:SetUserGroup(groupName: string)`

Sets the usergroup of the player.

**Arguments:**
- `groupName` (string) — The user group of the player.

[wiki](https://wiki.facepunch.com/gmod/Player:SetUserGroup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L61-L65)

---

### Player:SetViewEntity · Server
`Player:SetViewEntity(viewEntity: Entity)`

Attaches the players view to the position and angles of the specified entity.

**Arguments:**
- `viewEntity` (Entity) — The entity to attach the player view to.

[wiki](https://wiki.facepunch.com/gmod/Player:SetViewEntity)

---

### Player:SetViewOffset · Shared
`Player:SetViewOffset(viewOffset: Vector)`

Sets the **desired** view offset which equals the difference between the players actual position and their view when standing.

If you want to set **actual** view offset, use [Player:SetCurrentViewOffset](https://wiki.facepunch.com/gmod/Player:SetCurrentViewOffset)

See also [Player:SetViewOffsetDucked](https://wiki.facepunch.com/gmod/Player:SetViewOffsetDucked) for **desired** view offset when crouching.

**Arguments:**
- `viewOffset` (Vector) — The new desired view offset when standing.

[wiki](https://wiki.facepunch.com/gmod/Player:SetViewOffset)

---

### Player:SetViewOffsetDucked · Shared
`Player:SetViewOffsetDucked(viewOffset: Vector)`

Sets the **desired** view offset which equals the difference between the players actual position and their view when crouching.

If you want to set **actual** view offset, use [Player:SetCurrentViewOffset](https://wiki.facepunch.com/gmod/Player:SetCurrentViewOffset)

See also [Player:SetViewOffset](https://wiki.facepunch.com/gmod/Player:SetViewOffset) for **desired** view offset when standing.

**Arguments:**
- `viewOffset` (Vector) — The new desired view offset when crouching.

[wiki](https://wiki.facepunch.com/gmod/Player:SetViewOffsetDucked)

---

### Player:SetViewPunchAngles · Shared
`Player:SetViewPunchAngles(punchAngle: Angle)`

Sets client's view punch angle, but not the velocity. See [Player:ViewPunch](https://wiki.facepunch.com/gmod/Player:ViewPunch)

**Arguments:**
- `punchAngle` (Angle) — The angle to set.

[wiki](https://wiki.facepunch.com/gmod/Player:SetViewPunchAngles)

---

### Player:SetViewPunchVelocity · Shared
`Player:SetViewPunchVelocity(punchVel: Angle)`

Sets client's view punch velocity. See [Player:ViewPunch](https://wiki.facepunch.com/gmod/Player:ViewPunch) and [Player:SetViewPunchAngles](https://wiki.facepunch.com/gmod/Player:SetViewPunchAngles)

**Arguments:**
- `punchVel` (Angle) — The angle velocity to set.

[wiki](https://wiki.facepunch.com/gmod/Player:SetViewPunchVelocity)

---

### Player:SetVoiceVolumeScale · Client
`Player:SetVoiceVolumeScale(a1: number)`

Sets the voice volume scale for given player on client. This value will persist from server to server, but will be reset when the game is shut down.

**Arguments:**
- `a1` (number) — The voice volume scale, where `0` is 0% and `1` is 100%.

> **Note:** This doesn't work on bots, their scale will always be `1`. Does not work with multiruns.

[wiki](https://wiki.facepunch.com/gmod/Player:SetVoiceVolumeScale)

---

### Player:SetWalkSpeed · Shared
`Player:SetWalkSpeed(walkSpeed: number)`

Sets the player's normal walking speed. Not sprinting, not slow walking .

See also [Player:SetSlowWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetSlowWalkSpeed), [Player:GetWalkSpeed](https://wiki.facepunch.com/gmod/Player:GetWalkSpeed), [Player:SetCrouchedWalkSpeed](https://wiki.facepunch.com/gmod/Player:SetCrouchedWalkSpeed), [Player:SetMaxSpeed](https://wiki.facepunch.com/gmod/Player:SetMaxSpeed) and [Player:SetRunSpeed](https://wiki.facepunch.com/gmod/Player:SetRunSpeed).

**Arguments:**
- `walkSpeed` (number) — The new walk speed when `sv_friction` is below `10`.

> **Note:** `player_default` class walk speed is: `200`.
> **Bug** ([#2030](https://github.com/Facepunch/garrysmod/issues/2030)): Using a speed of `0` can lead to prediction errors, and can cause players to move at sv_maxvelocity

[wiki](https://wiki.facepunch.com/gmod/Player:SetWalkSpeed)

---

### Player:SetWeaponColor · Shared
`Player:SetWeaponColor(Color: Vector)`

Sets the player weapon's color. The part of the model that is colored is determined by the model itself, and is different for each model.

**Arguments:**
- `Color` (Vector) — This is the color to be set.

[wiki](https://wiki.facepunch.com/gmod/Player:SetWeaponColor)

---

### Player:ShouldDrawLocalPlayer · Client
`Player:ShouldDrawLocalPlayer() → boolean`

Returns whether the player's player model will be drawn at the time the function is called.

**Returns:**
- boolean — `true` if the player's playermodel is visible

[wiki](https://wiki.facepunch.com/gmod/Player:ShouldDrawLocalPlayer)

---

### Player:ShouldDropWeapon · Server
`Player:ShouldDropWeapon(drop: boolean)`

Sets whether the player's current weapon should drop on death.

**Arguments:**
- `drop` (boolean) — Whether to drop the player's current weapon or not

> **Note:** This is reset on spawn to the [player class](https://wiki.facepunch.com/gmod/Player_Classes)'s **DropWeaponOnDie** field by [player_manager.OnPlayerSpawn](https://wiki.facepunch.com/gmod/player_manager.OnPlayerSpawn).

[wiki](https://wiki.facepunch.com/gmod/Player:ShouldDropWeapon)

---

### Player:ShowProfile · Client
`Player:ShowProfile()`

Opens the player steam profile page in the steam overlay browser.

[wiki](https://wiki.facepunch.com/gmod/Player:ShowProfile)

---

### Player:SimulateGravGunDrop · Server
`Player:SimulateGravGunDrop(ent: Entity)`

Signals the entity that it was dropped by the gravity gun.

**Arguments:**
- `ent` (Entity) — Entity that was dropped.

[wiki](https://wiki.facepunch.com/gmod/Player:SimulateGravGunDrop)

---

### Player:SimulateGravGunPickup · Server
`Player:SimulateGravGunPickup(ent: Entity, lightning: boolean = false)`

Signals the entity that it was picked up by the gravity gun. This call is only required if you want to simulate the situation of picking up objects.

**Arguments:**
- `ent` (Entity) — The entity picked up
- `lightning` (boolean, default `false`) — Whether or not to show lightning effects around the entity

[wiki](https://wiki.facepunch.com/gmod/Player:SimulateGravGunPickup)

---

### Player:Spectate · Server
`Player:Spectate(mode: number)`

Starts spectate mode for given player. This will also affect the players movetype in some cases.

**Arguments:**
- `mode` (number, enum [OBS_MODE](https://wiki.facepunch.com/gmod/Enums/OBS_MODE)) — Spectate mode, see OBS_MODE.

> **Warning:** The player must be respawned, otherwise they will be able to walk through doors and become invincible.

[wiki](https://wiki.facepunch.com/gmod/Player:Spectate)

---

### Player:SpectateEntity · Server
`Player:SpectateEntity(entity: Entity)`

Makes the player spectate the entity.

To get the applied spectated entity, use [Player:GetObserverTarget](https://wiki.facepunch.com/gmod/Player:GetObserverTarget).

**Arguments:**
- `entity` (Entity) — Entity to spectate.

> **Warning:** The player must be respawned, otherwise they will be able to walk through doors and become invincible.

[wiki](https://wiki.facepunch.com/gmod/Player:SpectateEntity)

---

### Player:SprayDecal · Server
`Player:SprayDecal(sprayOrigin: Vector, sprayEndPos: Vector)`

Makes a player spray their decal.

**Arguments:**
- `sprayOrigin` (Vector) — The location to spray from
- `sprayEndPos` (Vector) — The location to spray to

[wiki](https://wiki.facepunch.com/gmod/Player:SprayDecal)
