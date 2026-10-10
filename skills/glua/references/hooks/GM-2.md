# GM

**Realm:** Shared, Menu  ·  **Members:** 267

Hooks that are available for all gamemodes based on base gamemode.
	
	See also: [Structures/GM](https://wiki.facepunch.com/gmod/Structures/GM).

> **Using these hooks:** register with `hook.Add("<EventName>", "unique_id", func)` using the **bare event name — drop the `GM:` prefix** (e.g. `hook.Add("PlayerSay", ...)`, **not** `hook.Add("GM:PlayerSay", ...)`). Or define `function GM:<EventName>()` in your gamemode. The `GM:` shown on each member below is only the method-definition form, not the hook.Add string.

> **Part 2 of 2** (`PlayerSetModel` – `WorkshopSubscriptionsProgress`). All parts: [1](GM.md), [2](GM-2.md)


### GM:PlayerSetModel · Server · `hook`
`GM:PlayerSetModel(ply: Player)`

Called whenever a player spawns and must choose a model. A good place to assign a model to a player.

**Arguments:**
- `ply` (Player) — The player being chosen

> **Note:** This function may not work in your custom gamemode if you have overridden your [GM:PlayerSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSpawn) and you do not use [self.BaseClass.PlayerSpawn](https://wiki.facepunch.com/gmod/Global.DEFINE_BASECLASS) in it, or [hook.Call](https://wiki.facepunch.com/gmod/hook.Call) this hook from [GM:PlayerSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSpawn).

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSetModel)

---

### GM:PlayerShouldTakeDamage · Server · `hook`
`GM:PlayerShouldTakeDamage(ply: Player, attacker: Entity) → boolean`

Returns true if the player should take damage from the given attacker.

**Arguments:**
- `ply` (Player) — The player
- `attacker` (Entity) — The attacker

**Returns:**
- boolean — Allow damage

> **Warning:** Applying damage from this hook to the player taking damage will lead to infinite loop/crash.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerShouldTakeDamage)

---

### GM:PlayerShouldTaunt · Server · `hook`
`GM:PlayerShouldTaunt(ply: Player, act: number) → boolean`

Allows to suppress player taunts.

**Arguments:**
- `ply` (Player) — Player who tried to taunt
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — Act ID of the taunt player tries to do, see ACT

**Returns:**
- boolean — Return false to disallow player taunting

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerShouldTaunt)

---

### GM:PlayerSilentDeath · Server · `hook`
`GM:PlayerSilentDeath(ply: Player)`

Called when the player is killed by [Player:KillSilent](https://wiki.facepunch.com/gmod/Player:KillSilent).

The player is already considered dead when this hook is called.

* See [GM:PlayerDeath](https://wiki.facepunch.com/gmod/GM:PlayerDeath) for a hook which handles all other death causes.
* [GM:PostPlayerDeath](https://wiki.facepunch.com/gmod/GM:PostPlayerDeath) is called **after** this hook.

**Arguments:**
- `ply` (Player) — The player who was killed

> **Note:** [Player:Alive](https://wiki.facepunch.com/gmod/Player:Alive) will return true in this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSilentDeath)

---

### GM:PlayerSpawn · Server · `hook`
`GM:PlayerSpawn(player: Player, transition: boolean)`

Called whenever a player spawns, including respawns.

See [GM:PlayerInitialSpawn](https://wiki.facepunch.com/gmod/GM:PlayerInitialSpawn) for a hook called only the first time a player spawns.

See the [player_spawn gameevent](https://wiki.facepunch.com/gmod/gameevent/player_spawn) for a shared version of this hook.

**Arguments:**
- `player` (Player) — The player who spawned.
- `transition` (boolean) — If true, the player just spawned from a map transition.

> **Warning:** By default, in "base" derived gamemodes, this hook will also call [GM:PlayerLoadout](https://wiki.facepunch.com/gmod/GM:PlayerLoadout) and [GM:PlayerSetModel](https://wiki.facepunch.com/gmod/GM:PlayerSetModel), which may override your [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel) and [Player:Give](https://wiki.facepunch.com/gmod/Player:Give) calls. Consider using the other hooks or a 0-second timer.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSpawn)

---

### GM:PlayerSpawnAsSpectator · Server · `hook`
`GM:PlayerSpawnAsSpectator(ply: Player)`

Called to spawn the player as a spectator.

**Arguments:**
- `ply` (Player) — The player to spawn as a spectator

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSpawnAsSpectator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player.lua#L219-L233)

---

### GM:PlayerSpray · Server · `hook`
`GM:PlayerSpray(sprayer: Player) → boolean`

Determines if the player can spray using the `impulse 201` console command.

**Arguments:**
- `sprayer` (Player) — The player.

**Returns:**
- boolean — Return `false` to allow spraying, return `true` to prevent spraying.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSpray)

---

### GM:PlayerStartTaunt · Server · `hook`
`GM:PlayerStartTaunt(ply: Player, act: number, length: number)`

Called when player starts taunting.

**Arguments:**
- `ply` (Player) — The player who is taunting
- `act` (number) — The sequence ID of the taunt
- `length` (number) — Length of the taunt

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerStartTaunt)

---

### GM:PlayerStartVoice · Client · `hook`
`GM:PlayerStartVoice(ply: Player, plyIndex: number = nil) → boolean`

Called when a player starts using voice chat.

**Arguments:**
- `ply` (Player) — Player who started using voice chat.
- `plyIndex` (number, default `nil`) — The player index.

**Returns:**
- boolean — Set true to hide player's `CHudVoiceStatus`.

> **Note:** Set mp_show_voice_icons to 0, if you want disable icons above player.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerStartVoice)

---

### GM:PlayerStepSoundTime · Shared · `hook`
`GM:PlayerStepSoundTime(ply: Player, type: number, walking: boolean) → number`

Allows you to override the time between footsteps.

See [GM:PlayerFootstep](https://wiki.facepunch.com/gmod/GM:PlayerFootstep) for a related hook about footstep sounds themselves.

**Arguments:**
- `ply` (Player) — Player who is walking
- `type` (number, enum [STEPSOUNDTIME](https://wiki.facepunch.com/gmod/Enums/STEPSOUNDTIME)) — The type of footsteps, see STEPSOUNDTIME
- `walking` (boolean) — Is the player walking or not ( +walk?

**Returns:**
- number — Time between footsteps, in ms

> **Note:** This hook is called on all clients.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerStepSoundTime)

---

### GM:PlayerSwitchFlashlight · Server · `hook`
`GM:PlayerSwitchFlashlight(ply: Player, enabled: boolean) → boolean`

Called whenever a player attempts to either turn on or off their flashlight, returning false will deny the change.

**Arguments:**
- `ply` (Player) — The player who attempts to change their flashlight state.
- `enabled` (boolean) — The new state the player requested, true for on, false for off.

**Returns:**
- boolean — Can toggle the flashlight or not

> **Note:** Also gets called when using [Player:Flashlight](https://wiki.facepunch.com/gmod/Player:Flashlight).

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSwitchFlashlight)

---

### GM:PlayerSwitchWeapon · Shared · `hook` · `PREDICTED`
`GM:PlayerSwitchWeapon(player: Player, oldWeapon: Weapon, newWeapon: Weapon) → boolean`

Called when a player attempts to switch their weapon.

Primary usage of this hook is to prevent/allow weapon switching, **not** to detect weapon switching. It will not be called for [Player:SetActiveWeapon](https://wiki.facepunch.com/gmod/Player:SetActiveWeapon).

**Arguments:**
- `player` (Player) — The player switching weapons.
- `oldWeapon` (Weapon) — The previous weapon.
- `newWeapon` (Weapon) — The weapon the player switched to.

**Returns:**
- boolean — Return `true` to prevent weapon switch.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerSwitchWeapon)

---

### GM:PlayerTick · Shared · `hook` · `PREDICTED`
`GM:PlayerTick(player: Player, mv: CMoveData)`

The Move hook is called for you to manipulate the player's [CMoveData](https://wiki.facepunch.com/gmod/CMoveData). This hook is called moments before [GM:Move](https://wiki.facepunch.com/gmod/GM:Move) and [GM:PlayerNoClip](https://wiki.facepunch.com/gmod/GM:PlayerNoClip).

**Arguments:**
- `player` (Player) — The player
- `mv` (CMoveData) — The current movedata for the player.

> **Warning:** This hook will not run when inside a vehicle. [GM:VehicleMove](https://wiki.facepunch.com/gmod/GM:VehicleMove) will be called instead.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerTick)

---

### GM:PlayerTraceAttack · Shared · `hook`
`GM:PlayerTraceAttack(ply: Player, dmginfo: CTakeDamageInfo, dir: Vector, trace: table{TraceResult}) → boolean`

Called when a player has been hit by a trace and damaged (such as from a bullet). Returning true overrides the damage handling and prevents [GM:ScalePlayerDamage](https://wiki.facepunch.com/gmod/GM:ScalePlayerDamage) from being called.

**Arguments:**
- `ply` (Player) — The player that has been hit
- `dmginfo` (CTakeDamageInfo) — The damage info of the bullet
- `dir` (Vector) — Normalized vector direction of the bullet's path
- `trace` (table{TraceResult}) — The trace of the bullet's path, see Structures/TraceResult

**Returns:**
- boolean — Override engine handling

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerTraceAttack)

---

### GM:PlayerUnfrozeObject · Server · `hook`
`GM:PlayerUnfrozeObject(ply: Player, ent: Entity, physobj: PhysObj)`

Called when a player unfreezes an object.

**Arguments:**
- `ply` (Player) — Player who has unfrozen an object
- `ent` (Entity) — The unfrozen object
- `physobj` (PhysObj) — The frozen physics object of the unfrozen entity ( For ragdolls )

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerUnfrozeObject)

---

### GM:PlayerUse · Server · `hook`
`GM:PlayerUse(ply: Player, ent: Entity) → boolean`

Triggered when the player presses use on an object. Continuously runs until USE is released but will not activate other Entities until the USE key is released; dependent on activation type of the Entity.

**Arguments:**
- `ply` (Player) — The player pressing the "use" key.
- `ent` (Entity) — The entity which the player is looking at / activating USE on.

**Returns:**
- boolean — Return `false` if the player is not allowed to USE the entity.

[wiki](https://wiki.facepunch.com/gmod/GM:PlayerUse)

---

### GM:PopulateMenuBar · Client · `hook`
`GM:PopulateMenuBar(menubar: Panel)`

Called when it's time to populate the context menu menu bar at the top.

**Arguments:**
- `menubar` (Panel) — The DMenuBar itself.

[wiki](https://wiki.facepunch.com/gmod/GM:PopulateMenuBar)

---

### GM:PostCleanupMap · Shared · `hook`
`GM:PostCleanupMap()`

Called right after the map has cleaned up (usually because [game.CleanUpMap](https://wiki.facepunch.com/gmod/game.CleanUpMap) was called)

See also [GM:PreCleanupMap](https://wiki.facepunch.com/gmod/GM:PreCleanupMap).

[wiki](https://wiki.facepunch.com/gmod/GM:PostCleanupMap)

---

### GM:PostDraw2DSkyBox · Client · `hook`
`GM:PostDraw2DSkyBox()`

Called right after the 2D skybox has been drawn - allowing you to draw over it.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDraw2DSkyBox)

---

### GM:PostDrawEffects · Client · `hook`
`GM:PostDrawEffects()`

Called after rendering effects. This is where halos are drawn. Called just before [GM:PreDrawHUD](https://wiki.facepunch.com/gmod/GM:PreDrawHUD) (The two hooks are basically identical).

See [GM:PreDrawEffects](https://wiki.facepunch.com/gmod/GM:PreDrawEffects) for the associated hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawEffects)

---

### GM:PostDrawHUD · Client · `hook`
`GM:PostDrawHUD()`

Called after [GM:PreDrawHUD](https://wiki.facepunch.com/gmod/GM:PreDrawHUD),  [GM:HUDPaintBackground](https://wiki.facepunch.com/gmod/GM:HUDPaintBackground) and [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint) but before  [GM:DrawOverlay](https://wiki.facepunch.com/gmod/GM:DrawOverlay).

Unlike [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint)([Background](https://wiki.facepunch.com/gmod/GM:HUDPaintBackground)) hooks, this will still be called when the main menu is visible. And so will be [GM:PreDrawHUD](https://wiki.facepunch.com/gmod/GM:PreDrawHUD)

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawHUD)

---

### GM:PostDrawOpaqueRenderables · Client · `hook`
`GM:PostDrawOpaqueRenderables(bDrawingDepth: boolean, bDrawingSkybox: boolean, isDraw3DSkybox: boolean)`

Called after drawing opaque entities.

See also [GM:PostDrawTranslucentRenderables](https://wiki.facepunch.com/gmod/GM:PostDrawTranslucentRenderables) and [GM:PreDrawOpaqueRenderables](https://wiki.facepunch.com/gmod/GM:PreDrawOpaqueRenderables).

**Arguments:**
- `bDrawingDepth` (boolean) — Whether the current draw is writing depth.
- `bDrawingSkybox` (boolean) — Whether the current draw is drawing the 3D or 2D skybox.
- `isDraw3DSkybox` (boolean) — Whether the current draw is drawing the 3D.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawOpaqueRenderables)

---

### GM:PostDrawPlayerHands · Client · `hook`
`GM:PostDrawPlayerHands(hands: Entity, vm: Entity, ply: Player, weapon: Weapon, flags: number)`

Called after the player hands are drawn.

See [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel) for the view model alternative.  
See [GM:PreDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PreDrawPlayerHands) for a hook that is called just before view model hands are drawn.

**Arguments:**
- `hands` (Entity) — This is the gmod_hands entity.
- `vm` (Entity) — This is the view model entity.
- `ply` (Player) — The the owner of the view model.
- `weapon` (Weapon) — This is the weapon that is from the view model.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawPlayerHands)

---

### GM:PostDrawSkyBox · Client · `hook`
`GM:PostDrawSkyBox()`

Called after drawing the 3D skybox. This will not be called if skybox rendering was prevented via the [GM:PreDrawSkyBox](https://wiki.facepunch.com/gmod/GM:PreDrawSkyBox) hook.

See also [GM:PostDraw2DSkyBox](https://wiki.facepunch.com/gmod/GM:PostDraw2DSkyBox).

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawSkyBox)

---

### GM:PostDrawTranslucentRenderables · Client · `hook`
`GM:PostDrawTranslucentRenderables(bDrawingDepth: boolean, bDrawingSkybox: boolean, isDraw3DSkybox: boolean)`

Called after all translucent entities are drawn.

See also [GM:PostDrawOpaqueRenderables](https://wiki.facepunch.com/gmod/GM:PostDrawOpaqueRenderables) and  [GM:PreDrawTranslucentRenderables](https://wiki.facepunch.com/gmod/GM:PreDrawTranslucentRenderables).

**Arguments:**
- `bDrawingDepth` (boolean) — Whether the current call is writing depth.
- `bDrawingSkybox` (boolean) — Whether the current call is drawing the 3D or 2D skybox.
- `isDraw3DSkybox` (boolean) — Whether the current call is drawing the 3D skybox.

> **Bug** ([#3295](https://github.com/Facepunch/garrysmod/issues/3295)): This is still called when r_drawentities or r_drawopaquerenderables is disabled.
> **Bug** ([#3296](https://github.com/Facepunch/garrysmod/issues/3296)): This is not called when r_drawtranslucentworld is disabled.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawTranslucentRenderables)

---

### GM:PostDrawViewModel · Client · `hook`
`GM:PostDrawViewModel(viewmodel: Entity, player: Player, weapon: Weapon, flags: number)`

Called after view model is drawn.

The render FOV in this hook is different from the main view, as view models are usually rendered with a different FOV. Every render operation will only be accurate with the view model entity.

See [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel) for a hook that is called just before a view model is drawn.

For view model hands alternative, see [GM:PostDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PostDrawPlayerHands).

**Arguments:**
- `viewmodel` (Entity) — Players view model
- `player` (Player) — The owner of the weapon/view model
- `weapon` (Weapon) — The weapon the player is currently holding
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel)

---

### GM:PostEntityFireBullets · Shared · `hook`
`GM:PostEntityFireBullets(entity: Entity, data: table{FiredBullet}) → boolean`

Called every time a bullet pellet (i.e. this hook is called multiple times for a shotgun shot) is fired from an entity. Notably this hook will have the final damage and aim direction for the bullet pellet.

See [GM:EntityFireBullets](https://wiki.facepunch.com/gmod/GM:EntityFireBullets) if you wish to modify the bullets before they are fired.

**Arguments:**
- `entity` (Entity) — The entity that fired the bullet
- `data` (table{FiredBullet}) — A table of data about the bullet that was fired.

**Returns:**
- boolean — Return `false` to suppress the bullet.

> **Warning:** This hook is called directly from [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets). Due to this, you cannot call [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets) inside this hook or an infinite loop will occur crashing the game.

[wiki](https://wiki.facepunch.com/gmod/GM:PostEntityFireBullets)

---

### GM:PostEntityTakeDamage · Server · `hook`
`GM:PostEntityTakeDamage(ent: Entity, dmginfo: CTakeDamageInfo, wasDamageTaken: boolean)`

Called when an entity receives a damage event, after passing damage filters, etc.

See [GM:EntityTakeDamage](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage) if you wish to prevent damage events, or otherwise alter them.

**Arguments:**
- `ent` (Entity) — The entity that took the damage.
- `dmginfo` (CTakeDamageInfo) — Detailed information about the damage event.
- `wasDamageTaken` (boolean) — Whether the entity actually took the damage.

> **Warning:** Applying damage from this hook to the entity taking damage will lead to infinite loop/crash.

[wiki](https://wiki.facepunch.com/gmod/GM:PostEntityTakeDamage)

---

### GM:PostGamemodeLoaded · Shared · `hook`
`GM:PostGamemodeLoaded()`

Called after the gamemode has loaded.

[wiki](https://wiki.facepunch.com/gmod/GM:PostGamemodeLoaded)

---

### GM:PostPlayerDeath · Server · `hook`
`GM:PostPlayerDeath(ply: Player)`

Called right after [GM:DoPlayerDeath](https://wiki.facepunch.com/gmod/GM:DoPlayerDeath), [GM:PlayerDeath](https://wiki.facepunch.com/gmod/GM:PlayerDeath) and [GM:PlayerSilentDeath](https://wiki.facepunch.com/gmod/GM:PlayerSilentDeath).

This hook will be called for all deaths, including [Player:KillSilent](https://wiki.facepunch.com/gmod/Player:KillSilent)

**Arguments:**
- `ply` (Player) — The player

> **Note:** [Player:Alive](https://wiki.facepunch.com/gmod/Player:Alive) will return false in this hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PostPlayerDeath)

---

### GM:PostPlayerDraw · Client · `hook`
`GM:PostPlayerDraw(ply: Player, flags: number)`

Called after a given player in your [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") was drawn.

This hook will not be called if player was prevented from being drawn via [GM:PrePlayerDraw](https://wiki.facepunch.com/gmod/GM:PrePlayerDraw).

**Arguments:**
- `ply` (Player) — The player that was drawn.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/GM:PostPlayerDraw)

---

### GM:PostProcessPermitted · Client · `hook`
`GM:PostProcessPermitted(effect_name: string) → boolean`

Allows you to suppress post processing effect drawing.

**Arguments:**
- `effect_name` (string) — The classname of Post Processing effect

**Returns:**
- boolean — Return true/false depending on whether this post process should be allowed

[wiki](https://wiki.facepunch.com/gmod/GM:PostProcessPermitted)

---

### GM:PostRender · Client · `hook`
`GM:PostRender()`

Called after the frame has been rendered.

[wiki](https://wiki.facepunch.com/gmod/GM:PostRender)

---

### GM:PostRenderVGUI · Client · `hook`
`GM:PostRenderVGUI()`

Called after the VGUI has been drawn.

[wiki](https://wiki.facepunch.com/gmod/GM:PostRenderVGUI)

---

### GM:PostUndo · Server · `hook`
`GM:PostUndo(undo: table, count: number)`

Called just after performing an undo.

**Arguments:**
- `undo` (table) — The undo table.
- `count` (number) — The amount of props/actions undone.

[wiki](https://wiki.facepunch.com/gmod/GM:PostUndo)

---

### GM:PreCleanupMap · Shared · `hook`
`GM:PreCleanupMap()`

Called right before the map cleans up (usually because [game.CleanUpMap](https://wiki.facepunch.com/gmod/game.CleanUpMap) was called)

See also [GM:PostCleanupMap](https://wiki.facepunch.com/gmod/GM:PostCleanupMap).

[wiki](https://wiki.facepunch.com/gmod/GM:PreCleanupMap)

---

### GM:PreDrawEffects · Client · `hook`
`GM:PreDrawEffects()`

Called just after [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel) and can technically be considered as a "PostDrawAllViewModels".

See [GM:PostDrawEffects](https://wiki.facepunch.com/gmod/GM:PostDrawEffects) for the associated hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawEffects)

---

### GM:PreDrawHalos · Client · `hook`
`GM:PreDrawHalos()`

Called before rendering the halos. This is the place to call [halo.Add](https://wiki.facepunch.com/gmod/halo.Add). This hook is actually running inside of [GM:PostDrawEffects](https://wiki.facepunch.com/gmod/GM:PostDrawEffects).

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawHalos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/halo.lua#L148)

---

### GM:PreDrawHUD · Client · `hook`
`GM:PreDrawHUD()`

Called just after [GM:PostDrawEffects](https://wiki.facepunch.com/gmod/GM:PostDrawEffects) (duplicate of it). Drawing anything in it seems to work incorrectly.

See [GM:PostDrawHUD](https://wiki.facepunch.com/gmod/GM:PostDrawHUD) for the associated hook.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawHUD)

---

### GM:PreDrawOpaqueRenderables · Client · `hook`
`GM:PreDrawOpaqueRenderables(isDrawingDepth: boolean, isDrawSkybox: boolean, isDraw3DSkybox: boolean) → boolean`

Called before all opaque entities are drawn.

See also [GM:PreDrawTranslucentRenderables](https://wiki.facepunch.com/gmod/GM:PreDrawTranslucentRenderables) and  [GM:PostDrawOpaqueRenderables](https://wiki.facepunch.com/gmod/GM:PostDrawOpaqueRenderables).

**Arguments:**
- `isDrawingDepth` (boolean) — Whether the current draw is writing depth.
- `isDrawSkybox` (boolean) — Whether the current draw is drawing the 3D or 2D skybox.
- `isDraw3DSkybox` (boolean) — Whether the current draw is drawing the 3D.

**Returns:**
- boolean — Return true to prevent opaque renderables from drawing.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawOpaqueRenderables)

---

### GM:PreDrawPlayerHands · Client · `hook`
`GM:PreDrawPlayerHands(hands: Entity, vm: Entity, ply: Player, weapon: Weapon, flags: number) → boolean`

Called before the player hands are drawn.

See [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel) for the view model alternative.  
See [GM:PostDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PostDrawPlayerHands) for a hook that is called just before view model hands are drawn.

**Arguments:**
- `hands` (Entity) — This is the gmod_hands entity before it is drawn.
- `vm` (Entity) — This is the view model entity before it is drawn.
- `ply` (Player) — The the owner of the view model.
- `weapon` (Weapon) — This is the weapon that is from the view model.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

**Returns:**
- boolean — Return true to prevent the viewmodel hands from rendering

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawPlayerHands)

---

### GM:PreDrawSkyBox · Client · `hook`
`GM:PreDrawSkyBox() → boolean`

Called before the 3D sky box is drawn. This will not be called for maps with no 3D skybox, or when the 3d skybox is disabled. (`r_3dsky 0`)

See also [GM:PostDrawSkyBox](https://wiki.facepunch.com/gmod/GM:PostDrawSkyBox)

**Returns:**
- boolean — Return true to disable skybox drawing (both 2D and 3D skybox)

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawSkyBox)

---

### GM:PreDrawTranslucentRenderables · Client · `hook`
`GM:PreDrawTranslucentRenderables(isDrawingDepth: boolean, isDrawSkybox: boolean, isDraw3DSkybox: boolean) → boolean`

Called before all the translucent entities are drawn.

See also [GM:PreDrawOpaqueRenderables](https://wiki.facepunch.com/gmod/GM:PreDrawOpaqueRenderables) and  [GM:PostDrawTranslucentRenderables](https://wiki.facepunch.com/gmod/GM:PostDrawTranslucentRenderables).

**Arguments:**
- `isDrawingDepth` (boolean) — Whether the current draw is writing depth.
- `isDrawSkybox` (boolean) — Whether the current draw is drawing the 3D or 2D skybox.
- `isDraw3DSkybox` (boolean) — Whether the current draw is drawing the 3D.

**Returns:**
- boolean — Return true to prevent translucent renderables from drawing.

> **Bug** ([#3295](https://github.com/Facepunch/garrysmod/issues/3295)): This is still called when r_drawentities or r_drawopaquerenderables is disabled.
> **Bug** ([#3296](https://github.com/Facepunch/garrysmod/issues/3296)): This is not called when r_drawtranslucentworld is disabled.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawTranslucentRenderables)

---

### GM:PreDrawViewModel · Client · `hook`
`GM:PreDrawViewModel(vm: Entity, ply: Player, weapon: Weapon, flags: number) → boolean`

Called before the view model has been drawn.

By default this hook also calls [WEAPON:PreDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PreDrawViewModel), so you can use that if developing a scripted weapon.

See [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel) for a hook that runs immediately after rendering a view model.  
See [GM:PreDrawViewModels](https://wiki.facepunch.com/gmod/GM:PreDrawViewModels) for a hook that runs before **all** view models are drawn within a frame.

For view model hands, see [GM:PreDrawPlayerHands](https://wiki.facepunch.com/gmod/GM:PreDrawPlayerHands).

**Arguments:**
- `vm` (Entity) — This is the view model entity before it is drawn.
- `ply` (Player) — The owner of the view model.
- `weapon` (Weapon) — This is the weapon that is from the view model.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

**Returns:**
- boolean — Return true to prevent the default view model rendering.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel)

---

### GM:PreDrawViewModels · Client · `hook`
`GM:PreDrawViewModels()`

Called just before all view models (there are 3 per player, see [Player:GetViewModel](https://wiki.facepunch.com/gmod/Player:GetViewModel)) and entities with `RENDERGROUP_VIEWMODEL` are drawn.

See [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel) and [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel) for hooks that run for specific view models.

You can use [GM:PreDrawEffects](https://wiki.facepunch.com/gmod/GM:PreDrawEffects) as a "`PostDrawViewModels`" hook as it is called just after the all the view model(s) are drawn.

[wiki](https://wiki.facepunch.com/gmod/GM:PreDrawViewModels)

---

### GM:PreGamemodeLoaded · Shared · `hook`
`GM:PreGamemodeLoaded()`

Called before the gamemode is loaded.

[wiki](https://wiki.facepunch.com/gmod/GM:PreGamemodeLoaded)

---

### GM:PrePlayerDraw · Client · `hook`
`GM:PrePlayerDraw(player: Player, flags: number) → boolean`

Called before the player is drawn.

See also [GM:PostPlayerDraw](https://wiki.facepunch.com/gmod/GM:PostPlayerDraw).

**Arguments:**
- `player` (Player) — The player that is about to be drawn.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

**Returns:**
- boolean — Return `true` to prevent default player rendering, which hides the player.

[wiki](https://wiki.facepunch.com/gmod/GM:PrePlayerDraw)

---

### GM:PreRegisterSENT · Shared · `hook`
`GM:PreRegisterSENT(ent: table, class: string) → boolean`

Called by [scripted_ents.Register](https://wiki.facepunch.com/gmod/scripted_ents.Register).

**Arguments:**
- `ent` (table) — The entity table to be registered.
- `class` (string) — The class name to be assigned.

**Returns:**
- boolean — Return `false` to prevent the entity from being registered.

[wiki](https://wiki.facepunch.com/gmod/GM:PreRegisterSENT) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/scripted_ents.lua#L55)

---

### GM:PreRegisterSWEP · Shared · `hook`
`GM:PreRegisterSWEP(swep: table, class: string) → boolean`

Called when a Scripted Weapon (SWEP) is about to be registered, allowing addons to alter the weapon's SWEP table with custom data for later usage. Called internally from [weapons.Register](https://wiki.facepunch.com/gmod/weapons.Register).

**Arguments:**
- `swep` (table) — The SWEP table to be registered.
- `class` (string) — The class name to be assigned.

**Returns:**
- boolean — Return `false` to prevent the weapon from being registered.

[wiki](https://wiki.facepunch.com/gmod/GM:PreRegisterSWEP) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/weapons.lua#L48)

---

### GM:PreRender · Client · `hook`
`GM:PreRender() → boolean`

Called before the renderer is about to start rendering the next frame.

**Returns:**
- boolean — Return true to prevent all rendering.

[wiki](https://wiki.facepunch.com/gmod/GM:PreRender)

---

### GM:PreUndo · Server · `hook`
`GM:PreUndo(undo: table) → boolean`

Called just before performing an undo.

**Arguments:**
- `undo` (table) — The undo table.

**Returns:**
- boolean — Return `false` to disallow the undo.

[wiki](https://wiki.facepunch.com/gmod/GM:PreUndo)

---

### GM:PreventScreenClicks · Client · `hook`
`GM:PreventScreenClicks() → boolean`

This will prevent  from sending to server when player tries to shoot from C menu.

**Returns:**
- boolean — Return true to prevent screen clicks.

[wiki](https://wiki.facepunch.com/gmod/GM:PreventScreenClicks)

---

### GM:PropBreak · Shared · `hook`
`GM:PropBreak(attacker: Player, prop: Entity)`

Called when a prop has been destroyed.

**Arguments:**
- `attacker` (Player) — The person who broke the prop.
- `prop` (Entity) — The entity that has been broken by the attacker.

[wiki](https://wiki.facepunch.com/gmod/GM:PropBreak)

---

### GM:RenderScene · Client · `hook`
`GM:RenderScene(origin: Vector, angles: Angle, fov: number) → boolean`

Render the scene. Used by the `Stereoscopy` post-processing effect.

**Arguments:**
- `origin` (Vector) — View origin
- `angles` (Angle) — View angles
- `fov` (number) — View FOV

**Returns:**
- boolean — Return `true` to override drawing the scene.

> **Note:** Materials rendered in this hook require `$ignorez` parameter to draw properly.

[wiki](https://wiki.facepunch.com/gmod/GM:RenderScene)

---

### GM:RenderScreenspaceEffects · Client · `hook`
`GM:RenderScreenspaceEffects()`

Used to render post processing effects.

[wiki](https://wiki.facepunch.com/gmod/GM:RenderScreenspaceEffects)

---

### GM:Restored · Shared · `hook`
`GM:Restored()`

Called when the game is reloaded from a Source Engine save system ( not the Sandbox saves or dupes ).

See [GM:Saved](https://wiki.facepunch.com/gmod/GM:Saved) for a hook that is called when such a save file is created.

[wiki](https://wiki.facepunch.com/gmod/GM:Restored)

---

### GM:Saved · Shared · `hook`
`GM:Saved()`

Called when the game is saved using the Source Engine save system (not the Sandbox saves or dupes).

See [GM:Restored](https://wiki.facepunch.com/gmod/GM:Restored) for a hook that is called when such a save file is loaded.

See also the [saverestore](https://wiki.facepunch.com/gmod/saverestore) for relevant functions.

[wiki](https://wiki.facepunch.com/gmod/GM:Saved)

---

### GM:ScaleNPCDamage · Server · `hook`
`GM:ScaleNPCDamage(npc: NPC, hitgroup: number, dmginfo: CTakeDamageInfo)`

Called when an NPC takes damage.

**Arguments:**
- `npc` (NPC) — The NPC that takes damage
- `hitgroup` (number, enum [HITGROUP](https://wiki.facepunch.com/gmod/Enums/HITGROUP)) — The hitgroup (hitbox) enum where the NPC took damage.
- `dmginfo` (CTakeDamageInfo) — Damage info

> **Note:** This hook is called only when a specific hit group of the NPC is hit. In cases where the hitgroup doesn't matter, you should use [GM:EntityTakeDamage](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage) instead!

[wiki](https://wiki.facepunch.com/gmod/GM:ScaleNPCDamage)

---

### GM:ScalePlayerDamage · Shared · `hook`
`GM:ScalePlayerDamage(ply: Player, hitgroup: number, dmginfo: CTakeDamageInfo) → boolean`

This hook allows you to change how much damage a player receives when one takes damage to a specific body part.

**Arguments:**
- `ply` (Player) — The player taking damage.
- `hitgroup` (number, enum [HITGROUP](https://wiki.facepunch.com/gmod/Enums/HITGROUP)) — The hitgroup where the player took damage.
- `dmginfo` (CTakeDamageInfo) — The damage info.

**Returns:**
- boolean — Return true to prevent damage that this hook is called for, stop blood particle effects and blood decals.

> **Note:** This is called only for bullet damage a player receives, you should use [GM:EntityTakeDamage](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage) instead if you need to detect **ALL** damage.

[wiki](https://wiki.facepunch.com/gmod/GM:ScalePlayerDamage)

---

### GM:ScoreboardHide · Client · `hook`
`GM:ScoreboardHide()`

Called when player released the scoreboard button ( by default).

[wiki](https://wiki.facepunch.com/gmod/GM:ScoreboardHide)

---

### GM:ScoreboardShow · Client · `hook`
`GM:ScoreboardShow() → boolean`

Called when player presses the scoreboard button ( by default).

**Returns:**
- boolean — Return true to prevent default scoreboard from showing.

[wiki](https://wiki.facepunch.com/gmod/GM:ScoreboardShow)

---

### GM:SendDeathNotice · Server · `hook`
`GM:SendDeathNotice(attacker: Entity|string|nil, inflictor: string, victim: Entity|string, flags: number)`

An internal function used to send a death notice event to all clients.

**Arguments:**
- `attacker` (Entity|string|nil) — The entity that caused the death.
- `inflictor` (string) — The attacker's weapon class name or the attacker itself if no weapon was equipped.
- `victim` (Entity|string) — The entity that died.
- `flags` (number) — Death notice flags.

[wiki](https://wiki.facepunch.com/gmod/GM:SendDeathNotice)

---

### GM:SetPlayerSpeed · Shared · `hook`
`GM:SetPlayerSpeed(ply: Player, walkSpeed: number, runSpeed: number)`

Sets player run and sprint speeds.

**Arguments:**
- `ply` (Player) — The player to set the speed of.
- `walkSpeed` (number) — The walk speed.
- `runSpeed` (number) — The run speed.

> **Warning:** This is not a hook. Treat this as a utility function to set the player's speed.
> **Bug** ([#2030](https://github.com/Facepunch/garrysmod/issues/2030)): Using a speed of `0` can lead to prediction errors, and can cause players to move at `sv_maxvelocity`

[wiki](https://wiki.facepunch.com/gmod/GM:SetPlayerSpeed)

---

### GM:SetupMove · Shared · `hook` · `PREDICTED`
`GM:SetupMove(ply: Player, mv: CMoveData, cmd: CUserCmd)`

SetupMove is called before the engine process movements. This allows us to override the players movement.

See [Game Movement](https://wiki.facepunch.com/gmod/Game%20Movement) for an explanation on the move system.

**Arguments:**
- `ply` (Player) — The player whose movement we are about to process
- `mv` (CMoveData) — The move data to override/use
- `cmd` (CUserCmd) — The command data

[wiki](https://wiki.facepunch.com/gmod/GM:SetupMove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/shared.lua#L179-L184)

---

### GM:SetupPlayerVisibility · Server · `hook`
`GM:SetupPlayerVisibility(ply: Player, viewEntity: Entity)`

Allows you to add extra positions to the player's [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community"). This is the place to call [AddOriginToPVS](https://wiki.facepunch.com/gmod/Global.AddOriginToPVS).

**Arguments:**
- `ply` (Player) — The player
- `viewEntity` (Entity) — Players Player:GetViewEntity

[wiki](https://wiki.facepunch.com/gmod/GM:SetupPlayerVisibility)

---

### GM:SetupSkyboxFog · Client · `hook`
`GM:SetupSkyboxFog(scale: number) → boolean`

Allows you to use render.Fog* functions to manipulate skybox fog.
		This will not be called for maps with no 3D skybox, or when the 3d skybox is disabled. (`r_3dsky 0`)

**Arguments:**
- `scale` (number) — The scale of 3D skybox

**Returns:**
- boolean — Return true to tell the engine that fog is set up

[wiki](https://wiki.facepunch.com/gmod/GM:SetupSkyboxFog)

---

### GM:SetupWorldFog · Client · `hook`
`GM:SetupWorldFog() → boolean`

Allows you to use render.Fog* functions to manipulate world fog.

**Returns:**
- boolean — Return true to tell the engine that fog is set up

[wiki](https://wiki.facepunch.com/gmod/GM:SetupWorldFog)

---

### GM:ShouldCollide · Shared · `hook` · `PREDICTED`
`GM:ShouldCollide(ent1: Entity, ent2: Entity) → boolean`

Called to decide whether a pair of entities should collide with each other. This is only called if [Entity:SetCustomCollisionCheck](https://wiki.facepunch.com/gmod/Entity:SetCustomCollisionCheck) was used on one or both entities.

Where applicable, consider using [constraint.NoCollide](https://wiki.facepunch.com/gmod/constraint.NoCollide) or a [logic_collision_pair](https://developer.valvesoftware.com/wiki/Logic_collision_pair) entity instead - they are considerably easier to use and may be more appropriate in some situations.

**Arguments:**
- `ent1` (Entity) — The first entity in the collision poll.
- `ent2` (Entity) — The second entity in the collision poll.

**Returns:**
- boolean — Whether the entities should collide.

> **Warning:** This hook **must** return the same value consistently for the same pair of entities.  
> 	If an entity changed in such a way that its collision rules change, you **must** call [Entity:CollisionRulesChanged](https://wiki.facepunch.com/gmod/Entity:CollisionRulesChanged) on that entity immediately - **not in this hook and not in physics callbacks.**  
> 	As long as you religiously follow the rules set by the examples this hook will work reliably without breaking, even a small mistake might break physics.
> **Bug** ([#642](https://github.com/Facepunch/garrysmod/issues/642)): This hook can cause all physics to break under certain conditions.

[wiki](https://wiki.facepunch.com/gmod/GM:ShouldCollide)

---

### GM:ShouldDrawLocalPlayer · Client · `hook`
`GM:ShouldDrawLocalPlayer(ply: Player) → boolean`

Called to determine if the [LocalPlayer](https://wiki.facepunch.com/gmod/Global.LocalPlayer) should be drawn.

If you're using this hook to draw a player for a [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) hook, then you may want to consider using the `drawviewer` variable you can use in your [Structures/CamData](https://wiki.facepunch.com/gmod/Structures/CamData) table instead.

**Arguments:**
- `ply` (Player) — The player.

**Returns:**
- boolean — `true` to draw the player, `false` to hide.

> **Note:** This hook has an internal cache that is reset at the start of every frame. This will prevent this hook from running in certain cases. This cache is reset in [cam.Start](https://wiki.facepunch.com/gmod/cam.Start) and in a future update in [render.RenderView](https://wiki.facepunch.com/gmod/render.RenderView) when rendering extra views.

[wiki](https://wiki.facepunch.com/gmod/GM:ShouldDrawLocalPlayer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L406-L410)

---

### GM:ShowHelp · Shared · `hook`
`GM:ShowHelp(ply: Player)`

Called when a player executes `gm_showhelp` console command. (Default bind is )

**Arguments:**
- `ply` (Player) — Player who executed the command

[wiki](https://wiki.facepunch.com/gmod/GM:ShowHelp)

---

### GM:ShowSpare1 · Shared · `hook`
`GM:ShowSpare1(ply: Player)`

Called when a player executes `gm_showspare1` console command ( Default bind is  ).

**Arguments:**
- `ply` (Player) — Player who executed the command.

[wiki](https://wiki.facepunch.com/gmod/GM:ShowSpare1)

---

### GM:ShowSpare2 · Shared · `hook`
`GM:ShowSpare2(ply: Player)`

Called when a player executes `gm_showspare2` console command ( Default bind is  ).

**Arguments:**
- `ply` (Player) — Player who executed the command.

[wiki](https://wiki.facepunch.com/gmod/GM:ShowSpare2)

---

### GM:ShowTeam · Shared · `hook`
`GM:ShowTeam(ply: Player)`

Called when a player executes `gm_showteam` console command. ( Default bind is  )

**Arguments:**
- `ply` (Player) — Player who executed the command

[wiki](https://wiki.facepunch.com/gmod/GM:ShowTeam)

---

### GM:ShutDown · Shared · `hook`
`GM:ShutDown()`

Called whenever the Lua environment is about to be shut down, for example on map change, or when the server is going to shut down.

[wiki](https://wiki.facepunch.com/gmod/GM:ShutDown)

---

### GM:SpawniconGenerated · Client · `hook`
`GM:SpawniconGenerated(lastmodel: string, imagename: string, modelsleft: number)`

Called when spawn icon is generated.

**Arguments:**
- `lastmodel` (string) — File path of previously generated model.
- `imagename` (string) — File path of the generated icon.
- `modelsleft` (number) — Amount of models left to generate.

[wiki](https://wiki.facepunch.com/gmod/GM:SpawniconGenerated)

---

### GM:SpawnMenuCreated · Client · `hook`
`GM:SpawnMenuCreated()`

Called when the Spawnmenu is Created.

[wiki](https://wiki.facepunch.com/gmod/GM:SpawnMenuCreated) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/spawnmenu.lua#L247)

---

### GM:StartChat · Client · `hook`
`GM:StartChat(isTeamChat: boolean) → boolean`

Runs when the user tries to open the chat box.

**Arguments:**
- `isTeamChat` (boolean) — Whether the message was sent through team chat.

**Returns:**
- boolean — Return true to hide the default chat box.

> **Warning:** Returning `true` won't stop the chatbox from taking VGUI focus. [chat.Close](https://wiki.facepunch.com/gmod/chat.Close) may be of use to mitigate that, or usage of [GM:PlayerBindPress](https://wiki.facepunch.com/gmod/GM:PlayerBindPress).

[wiki](https://wiki.facepunch.com/gmod/GM:StartChat)

---

### GM:StartCommand · Shared · `hook` · `PREDICTED`
`GM:StartCommand(ply: Player, ucmd: CUserCmd)`

Allows you to change the players inputs before they are processed by the server. This function is also called for bots, making it the best solution to control them.

This is basically a shared version of [GM:CreateMove](https://wiki.facepunch.com/gmod/GM:CreateMove).

**Arguments:**
- `ply` (Player) — The player
- `ucmd` (CUserCmd) — The usercommand

> **Note:** This hook is predicted, but not by usual means, it is called when a [CUserCmd](https://wiki.facepunch.com/gmod/CUserCmd) is generated on the client, and on the server when it is received, so it is necessary for this hook to be called clientside even on singleplayer

[wiki](https://wiki.facepunch.com/gmod/GM:StartCommand)

---

### GM:StartEntityDriving · Shared · `hook`
`GM:StartEntityDriving(ent: Entity, ply: Player)`

Called right before an entity starts driving. Overriding this hook will cause it to not call [drive.Start](https://wiki.facepunch.com/gmod/drive.Start) and the player will not begin driving the entity.

**Arguments:**
- `ent` (Entity) — The entity that is going to be driven
- `ply` (Player) — The player that is going to drive the entity

[wiki](https://wiki.facepunch.com/gmod/GM:StartEntityDriving)

---

### GM:StartGame · Menu · `hook`
`GM:StartGame()`

Called when you start a new game via the menu.

[wiki](https://wiki.facepunch.com/gmod/GM:StartGame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/html/js/menu/control.NewGame.js#L174)

---

### GM:Think · Shared, Menu · `hook`
`GM:Think()`

Called every rendered frame on client, except when the game is paused.

Called every game tick on the server, including when the game is paused. This will be the same as [GM:Tick](https://wiki.facepunch.com/gmod/GM:Tick) on the server when there is no lag, but will only be called once every processed server frame during lag.
[CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) is guaranteed to be different with each call to this hook on the server.

See [GM:Tick](https://wiki.facepunch.com/gmod/GM:Tick) for a hook that runs every tick on both the client and server.

> **Note:** On server, this hook **WILL NOT** run if the server is empty, unless you set the [ConVar](https://wiki.facepunch.com/gmod/ConVar) `sv_hibernate_think` to `1`.

[wiki](https://wiki.facepunch.com/gmod/GM:Think)

---

### GM:Tick · Shared · `hook`
`GM:Tick()`

Called every game tick. [engine.TickCount](https://wiki.facepunch.com/gmod/engine.TickCount) is guaranteed to be different between each call.

Server side, this is similar to [GM:Think](https://wiki.facepunch.com/gmod/GM:Think) (See that page for details). 

The default tickrate is `66.6666` (15 millisecond intervals). It can be changed via the `-tickrate` [command line option](Command_Line_Parameters).  
See [engine.TickInterval](https://wiki.facepunch.com/gmod/engine.TickInterval) for a function to retrieve this data at runtime.

> **Note:** This hook **WILL NOT** run if the server is empty, unless you set the [ConVar](https://wiki.facepunch.com/gmod/ConVar) `sv_hibernate_think` to 1

[wiki](https://wiki.facepunch.com/gmod/GM:Tick)

---

### GM:TranslateActivity · Shared · `hook`
`GM:TranslateActivity(ply: Player, act: number) → number`

Allows you to translate player activities.

**Arguments:**
- `ply` (Player) — The player
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity.

**Returns:**
- number — The new, translated activity

> **Note:** Isn't called when CalcMainActivity returns a valid override sequence id

[wiki](https://wiki.facepunch.com/gmod/GM:TranslateActivity)

---

### GM:UpdateAnimation · Shared · `hook`
`GM:UpdateAnimation(ply: Player, velocity: Vector, maxSeqGroundSpeed: number)`

Animation updates (pose params etc) should be done here.

**Arguments:**
- `ply` (Player) — The player to update the animation info for.
- `velocity` (Vector) — The player's velocity.
- `maxSeqGroundSpeed` (number) — Speed of the animation - used for playback rate scaling.

[wiki](https://wiki.facepunch.com/gmod/GM:UpdateAnimation)

---

### GM:VariableEdited · Server · `hook`
`GM:VariableEdited(ent: Entity, ply: Player, key: string, val: string, editor: table)`

Called when a variable is edited on an Entity (called by Edit Properties... menu). See [Editable Entities](https://wiki.facepunch.com/gmod/Editable%20Entities) for more information.

**Arguments:**
- `ent` (Entity) — The entity being edited
- `ply` (Player) — The player doing the editing
- `key` (string) — The name of the variable
- `val` (string) — The new value, as a string which will later be converted to its appropriate type
- `editor` (table) — The edit table defined in Entity:NetworkVar

> **Warning:** This hook is called to change a variable and not after a variable was changed

[wiki](https://wiki.facepunch.com/gmod/GM:VariableEdited)

---

### GM:VehicleMove · Shared · `hook` · `PREDICTED`
`GM:VehicleMove(ply: Player, veh: Vehicle, mv: CMoveData)`

Called when you are driving a vehicle. This hook works just like [GM:Move](https://wiki.facepunch.com/gmod/GM:Move).

This hook is called before [GM:Move](https://wiki.facepunch.com/gmod/GM:Move) and will be called when [GM:PlayerTick](https://wiki.facepunch.com/gmod/GM:PlayerTick) is not.

**Arguments:**
- `ply` (Player) — Player who is driving the vehicle
- `veh` (Vehicle) — The vehicle being driven
- `mv` (CMoveData) — Move data

[wiki](https://wiki.facepunch.com/gmod/GM:VehicleMove)

---

### GM:VGUIMousePressAllowed · Client · `hook`
`GM:VGUIMousePressAllowed(button: number) → boolean`

Called when user clicks on a VGUI panel.

**Arguments:**
- `button` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The button that was pressed, see MOUSE

**Returns:**
- boolean — Return true if the mouse click should be ignored or not.

[wiki](https://wiki.facepunch.com/gmod/GM:VGUIMousePressAllowed)

---

### GM:VGUIMousePressed · Client, Menu · `hook`
`GM:VGUIMousePressed(pnl: Panel, mouseCode: number)`

Called when a mouse button is pressed on a VGUI element or menu.

**Arguments:**
- `pnl` (Panel) — Panel that currently has focus.
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key that the player pressed using MOUSE.

[wiki](https://wiki.facepunch.com/gmod/GM:VGUIMousePressed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_menus.lua#L71)

---

### GM:WeaponEquip · Server · `hook`
`GM:WeaponEquip(weapon: Weapon, owner: Player)`

Called as a weapon entity is picked up by a player. (Including [Player:Give](https://wiki.facepunch.com/gmod/Player:Give))

Contrary to the name of the hook, it is **not called** when the player switches their active weapon to another.

See also [GM:PlayerDroppedWeapon](https://wiki.facepunch.com/gmod/GM:PlayerDroppedWeapon) and [GM:PlayerCanPickupWeapon](https://wiki.facepunch.com/gmod/GM:PlayerCanPickupWeapon).

**Arguments:**
- `weapon` (Weapon) — The equipped weapon.
- `owner` (Player) — The player that is picking up the weapon.

> **Note:** At the time when this hook is called [Entity:GetOwner](https://wiki.facepunch.com/gmod/Entity:GetOwner) will return `NULL`. The owner is set on the next frame.
> **Note:** This will not be called when picking up a weapon you already have as the weapon will be removed and [WEAPON:EquipAmmo](https://wiki.facepunch.com/gmod/WEAPON:EquipAmmo) will be called instead.

[wiki](https://wiki.facepunch.com/gmod/GM:WeaponEquip)

---

### GM:WorkshopDownloadedFile · Menu · `hook`
`GM:WorkshopDownloadedFile(id: number, title: string)`

Called when an addon from the Steam workshop finishes downloading. Used by default to update details on the workshop downloading panel.

**Arguments:**
- `id` (number) — Workshop ID of addon.
- `title` (string) — Name of addon.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopDownloadedFile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L32-L38)

---

### GM:WorkshopDownloadFile · Menu · `hook`
`GM:WorkshopDownloadFile(id: number, imageID: number, title: string, size: number)`

Called when an addon from the Steam workshop begins downloading. Used by default to place details on the workshop downloading panel.

**Arguments:**
- `id` (number) — Workshop ID of addon.
- `imageID` (number) — ID of addon's preview image.
- `title` (string) — Name of addon.
- `size` (number) — File size of addon in bytes.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopDownloadFile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L21-L30)

---

### GM:WorkshopDownloadProgress · Menu · `hook`
`GM:WorkshopDownloadProgress(id: number, imageID: number, title: string, downloaded: number, expected: number)`

Called while an addon from the Steam workshop is downloading. Used by default to update details on the fancy workshop download panel.

**Arguments:**
- `id` (number) — Workshop ID of addon.
- `imageID` (number) — ID of addon's preview image.
- `title` (string) — Name of addon.
- `downloaded` (number) — Current bytes of addon downloaded.
- `expected` (number) — Expected file size of addon in bytes.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopDownloadProgress) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L40-L50)

---

### GM:WorkshopDownloadTotals · Menu · `hook`
`GM:WorkshopDownloadTotals(remain: number, total: number)`

Called after [GM:WorkshopStart](https://wiki.facepunch.com/gmod/GM:WorkshopStart).

**Arguments:**
- `remain` (number) — Remaining addons to download
- `total` (number) — Total addons needing to be downloaded

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopDownloadTotals) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L52-L71)

---

### GM:WorkshopEnd · Menu · `hook`
`GM:WorkshopEnd()`

Called when downloading content from Steam workshop ends. Used by default to hide fancy workshop downloading panel.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopEnd) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L13-L19)

---

### GM:WorkshopExtractProgress · Menu · `hook`
`GM:WorkshopExtractProgress(id: number, ImageID: number, title: string, percent: number)`

Called while an addon from the Steam workshop is extracting. Used by default to update details on the fancy workshop download panel.

**Arguments:**
- `id` (number) — Workshop ID of addon.
- `ImageID` (number) — ID of addon's preview image.
- `title` (string) — Name of addon.
- `percent` (number) — Current bytes of addon extracted.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopExtractProgress) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L52-L62)

---

### GM:WorkshopStart · Menu · `hook`
`GM:WorkshopStart()`

Called when downloading content from Steam workshop begins. Used by default to show fancy workshop downloading panel.

The order of Workshop hooks is this:
* WorkshopStart
* WorkshopDownloadTotals
* * These are called for each new item:
* WorkshopDownloadFile
* WorkshopDownloadProgress - This is called until the file is finished
* WorkshopDownloadedFile
* WorkshopEnd (this ones called once)

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopStart) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L5-L11)

---

### GM:WorkshopSubscriptionsChanged · Menu · `hook`
`GM:WorkshopSubscriptionsChanged()`

Called when UGC subscription status changes.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopSubscriptionsChanged)

---

### GM:WorkshopSubscriptionsMessage · Menu · `hook`
`GM:WorkshopSubscriptionsMessage(message: string)`

Called when a Workshop Message is received?. Currently, it seems like the message will be **#ugc.mounting** every time.

**Arguments:**
- `message` (string) — The Message from the Workshop.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopSubscriptionsMessage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mount/mount.lua#L95-L103)

---

### GM:WorkshopSubscriptionsProgress · Menu · `hook` · `INTERNAL`
`GM:WorkshopSubscriptionsProgress(num: number, max: number)`

Called by the engine when the game initially fetches subscriptions to be displayed on the bottom of the main menu screen.

**Arguments:**
- `num` (number) — Amount of subscribed addons that have info retrieved.
- `max` (number) — Total amount of subscribed addons that need their info retrieved.

[wiki](https://wiki.facepunch.com/gmod/GM:WorkshopSubscriptionsProgress)
