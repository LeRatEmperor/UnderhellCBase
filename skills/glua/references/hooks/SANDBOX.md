# SANDBOX

**Realm:** Shared  ·  **Members:** 53

This is a list of hooks that are only available in Sandbox or Sandbox derived gamemodes.

Easiest way to tell if a gamemode is Sandbox derived is to check if this variable exists:

```lua
-- Replace GAMEMODE with GM if you are in gamemode files.
if ( GAMEMODE.IsSandboxDerived ) then
	-- Do stuff
end
```

> **Note:** This function or feature is only available in the Sandbox gamemode and its [derivatives](https://wiki.facepunch.com/gmod/Global.DeriveGamemode).

> **Using these hooks:** register with `hook.Add("<EventName>", "unique_id", func)` using the **bare event name — drop the `SANDBOX:` prefix** (e.g. `hook.Add("PlayerSay", ...)`, **not** `hook.Add("SANDBOX:PlayerSay", ...)`). Or define `function SANDBOX:<EventName>()` in your gamemode. The `SANDBOX:` shown on each member below is only the method-definition form, not the hook.Add string.

### SANDBOX:AddGamemodeToolMenuCategories · Client · `hook` · `INTERNAL`
`SANDBOX:AddGamemodeToolMenuCategories()`

This hook is used to add default categories to spawnmenu tool tabs.

Do not override or hook this function, use [SANDBOX:AddToolMenuCategories](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuCategories)!

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:AddGamemodeToolMenuCategories)

---

### SANDBOX:AddGamemodeToolMenuTabs · Client · `hook` · `INTERNAL`
`SANDBOX:AddGamemodeToolMenuTabs()`

This hook is used to add default tool tabs to spawnmenu.

Do not override or hook this function, use [SANDBOX:AddToolMenuTabs](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuTabs)!

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:AddGamemodeToolMenuTabs)

---

### SANDBOX:AddToolMenuCategories · Client · `hook`
`SANDBOX:AddToolMenuCategories()`

This hook is used to add new categories to spawnmenu tool tabs.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuCategories)

---

### SANDBOX:AddToolMenuTabs · Client · `hook`
`SANDBOX:AddToolMenuTabs()`

This hook is used to add new tool tabs to spawnmenu.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:AddToolMenuTabs)

---

### SANDBOX:CanArmDupe · Shared · `hook`
`SANDBOX:CanArmDupe(ply: Player) → boolean, string`

Called when a player attempts to "arm" a duplication with the Duplicator tool. Return false to prevent the player from sending data to server, and to ignore data if it was somehow sent anyway.

**Arguments:**
- `ply` (Player) — The player who attempted to arm a dupe.

**Returns:**
- boolean — Can the player arm a dupe or not.
- string — If given and the return value above is `false`, overrides the error message displayed to the player.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:CanArmDupe)

---

### SANDBOX:CanDrive · Shared · `hook` · `PREDICTED`
`SANDBOX:CanDrive(ply: Player, ent: Entity) → boolean`

Called when a player attempts to drive a prop via Prop Drive

**Arguments:**
- `ply` (Player) — The player who attempted to use Prop Drive.
- `ent` (Entity) — The entity the player is attempting to drive

**Returns:**
- boolean — Return true to allow driving, false to disallow

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:CanDrive)

---

### SANDBOX:CanTool · Shared · `hook` · `PREDICTED`
`SANDBOX:CanTool(ply: Player, tr: table{TraceResult}, toolname: string, tool: table, button: number) → boolean`

Called when a player attempts to fire their tool gun. Return true to specifically allow the attempt, false to block it.

**Arguments:**
- `ply` (Player) — The player who attempted to use their toolgun.
- `tr` (table{TraceResult}) — A trace from the players eye to where in the world their crosshair/cursor is pointing.
- `toolname` (string) — The tool mode the player currently has selected.
- `tool` (table) — The tool mode table the player currently has selected.
- `button` (number) — The tool button pressed.

**Returns:**
- boolean — Can use toolgun or not.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:CanTool)

---

### SANDBOX:ContentSidebarSelection · Client · `hook`
`SANDBOX:ContentSidebarSelection(parent: Panel, node: Panel)`

Called when player selects an item on the spawnmenu sidebar at the left.

**Arguments:**
- `parent` (Panel) — The panel that holds spawnicons and the sidebar of spawnmenu
- `node` (Panel) — The item player selected

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContentSidebarSelection)

---

### SANDBOX:ContextMenuClosed · Client · `hook`
`SANDBOX:ContextMenuClosed()`

Called when the context menu is supposedly closed.

This is simply an alias of [GM:OnContextMenuClose](https://wiki.facepunch.com/gmod/GM:OnContextMenuClose).

This hook **will** be called even if the Sandbox's context menu doesn't actually exist, i.e. [SANDBOX:ContextMenuEnabled](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuEnabled) blocked its creation.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuClosed)

---

### SANDBOX:ContextMenuCreated · Client · `hook`
`SANDBOX:ContextMenuCreated(g_ContextMenu: Panel)`

Called when the context menu is created.

**Arguments:**
- `g_ContextMenu` (Panel) — The created context menu panel

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuCreated)

---

### SANDBOX:ContextMenuEnabled · Client · `hook`
`SANDBOX:ContextMenuEnabled() → boolean`

Allows to prevent the creation of the context menu. If the context menu is already created, this will have no effect.

**Returns:**
- boolean — Return `false` to prevent the context menu from being created.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuEnabled)

---

### SANDBOX:ContextMenuOpen · Client · `hook`
`SANDBOX:ContextMenuOpen() → boolean`

Called when the context menu is trying to be opened.

**Returns:**
- boolean — Return `false` to block the opening.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuOpen)

---

### SANDBOX:ContextMenuOpened · Client · `hook`
`SANDBOX:ContextMenuOpened()`

Called when the context menu is supposedly opened.

This is simply an alias of [GM:OnContextMenuOpen](https://wiki.facepunch.com/gmod/GM:OnContextMenuOpen) but will **not** be called if [SANDBOX:ContextMenuOpen](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuOpen) prevents the context menu from opening.

This hook **will** be called even if the context menu doesn't actually exist, i.e. [SANDBOX:ContextMenuEnabled](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuEnabled) blocked its creation.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuOpened)

---

### SANDBOX:ContextMenuShowTool · Client · `hook`
`SANDBOX:ContextMenuShowTool() → boolean`

Called to poll if active tool settings should appear in the context menu. Please note that this is only called on initial opening of the context menu, not every frame the context menu is in use.

**Returns:**
- boolean — Return `false` to prevent active tool settings from displaying in the context menu.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:ContextMenuShowTool)

---

### SANDBOX:OnRevertSpawnlist · Client · `hook`
`SANDBOX:OnRevertSpawnlist()`

Called when the Client reverts spawnlist changes

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:OnRevertSpawnlist) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentsidebar.lua#L70)

---

### SANDBOX:OnSaveSpawnlist · Client · `hook`
`SANDBOX:OnSaveSpawnlist()`

Called when a player saves his changes made to the spawnmenu

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:OnSaveSpawnlist) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contentsidebar.lua#L56)

---

### SANDBOX:OpenToolbox · Client · `hook` · `INTERNAL`
`SANDBOX:OpenToolbox()`

This hook is called when the player edits a category in the Spawnmenu

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:OpenToolbox) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/custom.lua#L50)

---

### SANDBOX:PaintNotes · Client · `hook`
`SANDBOX:PaintNotes()`

Called from [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint); does nothing by default.

> **Note:** This cannot be used with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add)

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PaintNotes)

---

### SANDBOX:PaintWorldTips · Client · `hook`
`SANDBOX:PaintWorldTips()`

Called from [GM:HUDPaint](https://wiki.facepunch.com/gmod/GM:HUDPaint) to draw world tips. By default, enabling cl_drawworldtooltips will stop world tips from being drawn here.
See [AddWorldTip](https://wiki.facepunch.com/gmod/Global.AddWorldTip) for more information.

> **Note:** This cannot be used with [hook.Add](https://wiki.facepunch.com/gmod/hook.Add)

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PaintWorldTips)

---

### SANDBOX:PersistenceLoad · Server · `hook`
`SANDBOX:PersistenceLoad(name: string)`

Called when persistent props are loaded.

**Arguments:**
- `name` (string) — Save from which to load.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PersistenceLoad)

---

### SANDBOX:PersistenceSave · Server · `hook`
`SANDBOX:PersistenceSave(name: string)`

Called when persistent props are saved.

**Arguments:**
- `name` (string) — Where to save.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PersistenceSave)

---

### SANDBOX:PlayerGiveSWEP · Server · `hook`
`SANDBOX:PlayerGiveSWEP(ply: Player, weapon: string, spawninfo: table) → boolean`

Called when a player attempts to give themselves a weapon from the Q menu. (Left mouse clicks on an icon)

Not to be confused with [SANDBOX:PlayerSpawnSWEP](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnSWEP), which is called when the weapon is spawned as entity on the ground.

**Arguments:**
- `ply` (Player) — The player who attempted to give themselves a weapon.
- `weapon` (string) — Class name of the weapon the player tried to give themselves.
- `spawninfo` (table) — The weapon list table of this weapon, see CCGiveSWEP and weapons.Register

**Returns:**
- boolean — Can the SWEP be given to the player

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerGiveSWEP) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/commands.lua#L902)

---

### SANDBOX:PlayerSpawnedEffect · Server · `hook`
`SANDBOX:PlayerSpawnedEffect(ply: Player, model: string, ent: Entity)`

Called after the player spawned an effect.

**Arguments:**
- `ply` (Player) — The player that spawned the effect
- `model` (string) — The model of spawned effect
- `ent` (Entity) — The spawned effect itself

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedEffect)

---

### SANDBOX:PlayerSpawnedNPC · Server · `hook`
`SANDBOX:PlayerSpawnedNPC(ply: Player, ent: Entity)`

Called after the player spawned an NPC.

**Arguments:**
- `ply` (Player) — The player that spawned the NPC
- `ent` (Entity) — The spawned NPC itself

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedNPC)

---

### SANDBOX:PlayerSpawnedProp · Server · `hook`
`SANDBOX:PlayerSpawnedProp(ply: Player, model: string, entity: Entity)`

Called when a player has successfully spawned a prop from the Q menu.

**Arguments:**
- `ply` (Player) — The player who spawned a prop.
- `model` (string) — Path to the model of the prop the player is attempting to spawn.
- `entity` (Entity) — The entity that was spawned.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedProp)

---

### SANDBOX:PlayerSpawnedRagdoll · Server · `hook`
`SANDBOX:PlayerSpawnedRagdoll(ply: Player, model: string, ent: Entity)`

Called after the player spawned a ragdoll.

**Arguments:**
- `ply` (Player) — The player that spawned the ragdoll
- `model` (string) — The ragdoll model that player wants to spawn
- `ent` (Entity) — The spawned ragdoll itself

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedRagdoll)

---

### SANDBOX:PlayerSpawnedSENT · Server · `hook`
`SANDBOX:PlayerSpawnedSENT(ply: Player, ent: Entity)`

Called after the player has spawned a scripted entity.

**Arguments:**
- `ply` (Player) — The player that spawned the SENT
- `ent` (Entity) — The spawned SENT

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedSENT)

---

### SANDBOX:PlayerSpawnedSWEP · Server · `hook`
`SANDBOX:PlayerSpawnedSWEP(ply: Player, ent: Entity)`

Called after the player has spawned a weapon from the spawnmenu with a middle mouse click (mouse wheel click).

For a hook capable of preventing such spawns, see [SANDBOX:PlayerSpawnSWEP](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnSWEP).  
For left mouse click spawns, see [SANDBOX:PlayerGiveSWEP](https://wiki.facepunch.com/gmod/SANDBOX:PlayerGiveSWEP).

**Arguments:**
- `ply` (Player) — The player that spawned the SWEP
- `ent` (Entity) — The SWEP itself

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedSWEP)

---

### SANDBOX:PlayerSpawnedVehicle · Server · `hook`
`SANDBOX:PlayerSpawnedVehicle(ply: Player, ent: Entity)`

Called after the player spawned a vehicle.

**Arguments:**
- `ply` (Player) — The player that spawned the vehicle
- `ent` (Entity) — The vehicle itself

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedVehicle)

---

### SANDBOX:PlayerSpawnEffect · Server · `hook`
`SANDBOX:PlayerSpawnEffect(ply: Player, model: string) → boolean`

Called to ask if player allowed to spawn a particular effect or not.

**Arguments:**
- `ply` (Player) — The player that wants to spawn an effect
- `model` (string) — The effect model that player wants to spawn

**Returns:**
- boolean — Return false to disallow spawning that effect

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnEffect)

---

### SANDBOX:PlayerSpawnNPC · Server · `hook`
`SANDBOX:PlayerSpawnNPC(ply: Player, npc_type: string, weapon: string) → boolean`

Called to ask if player allowed to spawn a particular NPC or not.

**Arguments:**
- `ply` (Player) — The player that wants to spawn that NPC
- `npc_type` (string) — The npc type that player is trying to spawn
- `weapon` (string) — The weapon of that NPC

**Returns:**
- boolean — Return false to disallow spawning that NPC

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnNPC)

---

### SANDBOX:PlayerSpawnObject · Server · `hook`
`SANDBOX:PlayerSpawnObject(ply: Player, model: string, skin: number) → boolean`

Called to ask whether player is allowed to spawn a given model. This includes props, effects, and ragdolls and is called before the respective PlayerSpawn* hook.

**Arguments:**
- `ply` (Player) — The player in question
- `model` (string) — Model path
- `skin` (number) — Skin number

**Returns:**
- boolean — Return false to disallow the player to spawn the given model.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnObject)

---

### SANDBOX:PlayerSpawnProp · Server · `hook`
`SANDBOX:PlayerSpawnProp(ply: Player, model: string) → boolean`

Called when a player attempts to spawn a prop from the Q menu.

**Arguments:**
- `ply` (Player) — The player who attempted to spawn a prop.
- `model` (string) — Path to the model of the prop the player is attempting to spawn.

**Returns:**
- boolean — Should the player be able to spawn the prop or not.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnProp)

---

### SANDBOX:PlayerSpawnRagdoll · Server · `hook`
`SANDBOX:PlayerSpawnRagdoll(ply: Player, model: string) → boolean`

Called when a player attempts to spawn a ragdoll from the Q menu.

**Arguments:**
- `ply` (Player) — The player who attempted to spawn a ragdoll.
- `model` (string) — Path to the model of the ragdoll the player is attempting to spawn.

**Returns:**
- boolean — Should the player be able to spawn the ragdoll or not.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnRagdoll)

---

### SANDBOX:PlayerSpawnSENT · Server · `hook`
`SANDBOX:PlayerSpawnSENT(ply: Player, class: string) → boolean`

Called when a player attempts to spawn an Entity from the Q menu.

**Arguments:**
- `ply` (Player) — The player who attempted to spawn the entity.
- `class` (string) — Class name of the entity the player tried to spawn.

**Returns:**
- boolean — Should the player be able to spawn the entity or not.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnSENT)

---

### SANDBOX:PlayerSpawnSWEP · Server · `hook`
`SANDBOX:PlayerSpawnSWEP(ply: Player, weapon: string, swep: table) → boolean`

Called when a player attempts to spawn a weapon from the spawnmenu as an entity on the ground, by middle mouse clicking (mouse wheel clicking) on a weapon icon.

Not to be confused with [SANDBOX:PlayerGiveSWEP](https://wiki.facepunch.com/gmod/SANDBOX:PlayerGiveSWEP), which is called only when the weapon is given to the player directly, if they don't already have it.

See [SANDBOX:PlayerSpawnedSWEP](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnedSWEP) for post entity creation event.

**Arguments:**
- `ply` (Player) — The player who attempted to spawn a weapon.
- `weapon` (string) — Class name of the weapon the player tried to spawn.
- `swep` (table) — Information about the weapon the player is trying to spawn, see Structures/SWEP

**Returns:**
- boolean — Can the SWEP be spawned

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnSWEP)

---

### SANDBOX:PlayerSpawnVehicle · Server · `hook`
`SANDBOX:PlayerSpawnVehicle(ply: Player, model: string, name: string, table: table) → boolean`

Called to ask if player allowed to spawn a particular vehicle or not.

**Arguments:**
- `ply` (Player) — The player that wants to spawn that vehicle
- `model` (string) — The vehicle model that player wants to spawn
- `name` (string) — Vehicle name
- `table` (table) — Table of that vehicle, containing info about it See Structures/VehicleTable.

**Returns:**
- boolean — Return false to disallow spawning that vehicle

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PlayerSpawnVehicle)

---

### SANDBOX:PopulateContent · Client · `hook`
`SANDBOX:PopulateContent(pnlContent: Panel, tree: Panel, node: Panel)`

Called by the spawnmenu when the content tab is generated

**Arguments:**
- `pnlContent` (Panel) — The SpawnmenuContentPanel
- `tree` (Panel) — The ContentNavBar tree from the SpawnmenuContentPanel
- `node` (Panel) — The old Spawnlists

> **Warning:** Creating an error in this Hook will result in a completely broken Content Tab

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateContent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/content.lua#L91)

---

### SANDBOX:PopulateEntities · Client · `hook`
`SANDBOX:PopulateEntities(pnlContent: Panel, tree: Panel, node: Panel)`

Called by the spawnmenu when the Entities tab is generated

**Arguments:**
- `pnlContent` (Panel) — The SpawnmenuContentPanel
- `tree` (Panel) — The ContentNavBar tree from the SpawnmenuContentPanel
- `node` (Panel) — The old Spawnlists

> **Warning:** Creating an error in this Hook will result in a completely broken Entites Tab

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateEntities) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/entities.lua#L75)

---

### SANDBOX:PopulateNPCs · Client · `hook`
`SANDBOX:PopulateNPCs(pnlContent: Panel, tree: Panel, node: Panel)`

Called by the spawnmenu when the NPCs tab is generated

**Arguments:**
- `pnlContent` (Panel) — The SpawnmenuContentPanel
- `tree` (Panel) — The ContentNavBar tree from the SpawnmenuContentPanel
- `node` (Panel) — The old Spawnlists

> **Warning:** Creating an error in this Hook will result in a completely broken NPCs Tab

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateNPCs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/npcs.lua#L141)

---

### SANDBOX:PopulatePropMenu · Client · `hook`
`SANDBOX:PopulatePropMenu()`

This hook makes the engine load the spawnlist text files.
It calls [spawnmenu.PopulateFromEngineTextFiles](https://wiki.facepunch.com/gmod/spawnmenu.PopulateFromEngineTextFiles) by default.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulatePropMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/content.lua#L90)

---

### SANDBOX:PopulateToolMenu · Client · `hook`
`SANDBOX:PopulateToolMenu()`

Add the [Scripted TOOLs](https://wiki.facepunch.com/gmod/TOOL) to the tool menu. You want to call [spawnmenu.AddToolMenuOption](https://wiki.facepunch.com/gmod/spawnmenu.AddToolMenuOption) in this hook.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateToolMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/spawnmenu.lua#L241)

---

### SANDBOX:PopulateVehicles · Client · `hook`
`SANDBOX:PopulateVehicles(pnlContent: Panel, tree: Panel, node: Panel)`

Called by the spawnmenu when the Vehicles tab is generated

**Arguments:**
- `pnlContent` (Panel) — The SpawnmenuContentPanel
- `tree` (Panel) — The ContentNavBar tree from the SpawnmenuContentPanel
- `node` (Panel) — The old Spawnlists

> **Warning:** Creating an error in this Hook will result in a completely broken vehicles Tab

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateVehicles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/vehicles.lua#L77)

---

### SANDBOX:PopulateWeapons · Client · `hook`
`SANDBOX:PopulateWeapons(pnlContent: Panel, tree: Panel, node: Panel)`

Called by the spawnmenu when the Weapons tab is generated

**Arguments:**
- `pnlContent` (Panel) — The SpawnmenuContentPanel
- `tree` (Panel) — The ContentNavBar tree from the SpawnmenuContentPanel
- `node` (Panel) — The old Spawnlists

> **Warning:** Creating an error in this Hook will result in a completely broken Weapons Tab

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PopulateWeapons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/weapons.lua#L75)

---

### SANDBOX:PostReloadToolsMenu · Client · `hook`
`SANDBOX:PostReloadToolsMenu()`

Called right after the Lua Loaded tool menus are reloaded. This is a good place to set up any [ControlPanel](https://wiki.facepunch.com/gmod/ControlPanel)s.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PostReloadToolsMenu)

---

### SANDBOX:PreRegisterTOOL · Shared · `hook`
`SANDBOX:PreRegisterTOOL(tool: table, class: string) → boolean`

Called just before registering a Sandbox scripted tool.

**Arguments:**
- `tool` (table) — The TOOL table to be registered.
- `class` (string) — The class name to be assigned.

**Returns:**
- boolean — Return `false` to prevent the TOOL from being registered.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PreRegisterTOOL) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L163-L165)

---

### SANDBOX:PreReloadToolsMenu · Client · `hook`
`SANDBOX:PreReloadToolsMenu()`

Called right before the Lua Loaded tool menus are reloaded.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:PreReloadToolsMenu)

---

### SANDBOX:SpawnlistContentChanged · Client · `hook`
`SANDBOX:SpawnlistContentChanged()`

Called when changes were made to the spawnmenu like creating a new category.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnlistContentChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/custom.lua#L44)

---

### SANDBOX:SpawnlistOpenGenericMenu · Client · `hook` · `INTERNAL`
`SANDBOX:SpawnlistOpenGenericMenu(canvas: Panel)`

Called when there's one or more items selected in the spawnmenu by the player, to open the multi selection right click menu ([DMenu](https://wiki.facepunch.com/gmod/DMenu))

**Arguments:**
- `canvas` (Panel) — The canvas that has the selection.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnlistOpenGenericMenu)

---

### SANDBOX:SpawnMenuEnabled · Client · `hook`
`SANDBOX:SpawnMenuEnabled() → boolean`

If false is returned then the spawn menu is never created. This saves load times if your mod doesn't actually use the spawn menu for any reason.

**Returns:**
- boolean — Whether to create spawnmenu or not.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnMenuEnabled)

---

### SANDBOX:SpawnmenuIconMenuOpen · Client · `hook`
`SANDBOX:SpawnmenuIconMenuOpen(menu: Panel, icon: Panel, contentType: string)`

Called when the player opens a context menu by right clicking one of the spawnmenu icons. Either [ContentIcon](https://wiki.facepunch.com/gmod/ContentIcon) or [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon).

This hook can be used to add new custom menu options to the context menu.

**Arguments:**
- `menu` (Panel) — The DMenu to add options to.
- `icon` (Panel) — The ContentIcon or SpawnIcon that was right clicked.
- `contentType` (string) — The content type, such as: * `weapon` * `entity` * `vehicle` * `npc` * `model` * `tool` * `postprocess` Addon related icons may have different types.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnmenuIconMenuOpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenticon.lua#L32)

---

### SANDBOX:SpawnMenuOpen · Client · `hook`
`SANDBOX:SpawnMenuOpen() → boolean`

Called when spawnmenu is trying to be opened.

**Returns:**
- boolean — Return false to dissallow opening the spawnmenu

> **Note:** Hiding the spawnmenu will not stop people from being able to use the various console commands to spawn in items, etc. See GM:PlayerSpawn* hooks for blocking actual spawning.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnMenuOpen)

---

### SANDBOX:SpawnMenuOpened · Client · `hook`
`SANDBOX:SpawnMenuOpened()`

Called when the spawnmenu is opened.

This is an alias of [GM:OnSpawnMenuOpen](https://wiki.facepunch.com/gmod/GM:OnSpawnMenuOpen) but will **not** be called if [SANDBOX:SpawnMenuOpen](https://wiki.facepunch.com/gmod/SANDBOX:SpawnMenuOpen) prevents the spawnmenu from opening.

This hook **will** be called even if the spawnmenu doesn't actually exist, i.e. [SANDBOX:SpawnMenuEnabled](https://wiki.facepunch.com/gmod/SANDBOX:SpawnMenuEnabled) blocked its creation.

[wiki](https://wiki.facepunch.com/gmod/SANDBOX:SpawnMenuOpened)
