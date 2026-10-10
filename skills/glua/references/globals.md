# Global functions & values

**Realm:** Shared, Menu  ·  **Members:** 334

Functions and values in the global namespace (called directly, e.g. `Vector(0,0,0)`, `IsValid(ent)`, `hook.Add(...)` lives in the [hook](libraries/hook.md) library). **Read the entry before using — don't guess signatures.**


> **Part 1 of 2** (`AccessorFunc` – `JS_Utility`). All parts: [1](globals.md), [2](globals-2.md)


### AccessorFunc · Shared, Menu
`AccessorFunc(tab: table, key: any, name: string, force: number{FORCE} = nil)`

Adds simple Get/Set accessor functions on the specified table.
Can also force the value to be set to a number, bool or string.

**Arguments:**
- `tab` (table) — The table to add the accessor functions to.
- `key` (any) — The key of the table to be get/set.
- `name` (string) — The name of the functions (will be prefixed with Get and Set).
- `force` (number{FORCE}, default `nil`) — The type the setter should force to (uses FORCE).

[wiki](https://wiki.facepunch.com/gmod/Global.AccessorFunc) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L178-L198)

---

### Add_NPC_Class · Shared, Menu
`Add_NPC_Class(name: string)`

Defines a global entity class variable with an automatic value. In order to prevent collisions with other [CLASS](https://wiki.facepunch.com/gmod/Enums/CLASS). You should prefix your variable with CLASS_ for consistency.

**Arguments:**
- `name` (string) — The name of the new enum/global variable.

[wiki](https://wiki.facepunch.com/gmod/Global.Add_NPC_Class) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L373-L376)

---

### AddBackgroundImage · Menu
`AddBackgroundImage(path: string)`

Adds the specified image path to the main menu background pool. Image can be png or jpeg.

**Arguments:**
- `path` (string) — Path to the image.

[wiki](https://wiki.facepunch.com/gmod/Global.AddBackgroundImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/background.lua#L101-L105)

---

### AddConsoleCommand · Shared, Menu · `INTERNAL`
`AddConsoleCommand(name: string, helpText: string, flags: number{FCVAR})`

Tells the engine to register a console command. If the command was ran, the engine calls [concommand.Run](https://wiki.facepunch.com/gmod/concommand.Run).

**Arguments:**
- `name` (string) — The name of the console command to add.
- `helpText` (string) — The help text.
- `flags` (number{FCVAR}) — Concommand flags using FCVAR.

[wiki](https://wiki.facepunch.com/gmod/Global.AddConsoleCommand)

---

### AddCSLuaFile · Shared
`AddCSLuaFile(file: string = current file)`

Marks a Lua file to be sent to clients when they join the server. Doesn't do anything on the client - this means you can use it in a shared file without problems.

**Arguments:**
- `file` (string, default `current file`) — The name/path to the Lua file that should be sent, relative to the garrysmod/lua folder.

> **Note:** This function is not needed for scripts located in these paths because they are automatically sent to clients:   
> 			**lua/matproxy/**  
> 			**lua/postprocess/**  
> 			**lua/vgui/**  
> 			**lua/skins/**  
> 			**lua/autorun/**  
> 			**lua/autorun/client/**  
> 			
> 			You can add up to **8192** files. Each file can be up to **64KB** compressed (LZMA).
> **Warning:** If the file trying to be added is empty, an error will occur, and the file will not be sent to the client.
> 		
> 		The string cannot have whitespace.

[wiki](https://wiki.facepunch.com/gmod/Global.AddCSLuaFile)

---

### AddonMaterial · Client, Menu
`AddonMaterial(name: string) → IMaterial`

Loads the specified image from the `/cache` folder, used in combination with [steamworks.Download](https://wiki.facepunch.com/gmod/steamworks.Download). Most addons will provide a 512x512 png image.

**Arguments:**
- `name` (string) — The name of the file.

**Returns:**
- IMaterial — The material, returns `nil` if the cached file is not an image.

> **Note:** This works with any image file with the `.cache` file extension, even outside of the `/cache` folder.

[wiki](https://wiki.facepunch.com/gmod/Global.AddonMaterial)

---

### AddOriginToPVS · Server
`AddOriginToPVS(position: Vector)`

Adds the specified vector to the PVS which is currently building. This allows all objects in visleafs visible from that vector to be drawn.

**Arguments:**
- `position` (Vector) — The origin to add.

[wiki](https://wiki.facepunch.com/gmod/Global.AddOriginToPVS)

---

### AddPropsOfParent · Client
`AddPropsOfParent(pnlContent: Panel, node: Panel, parentid: number, customProps: table)`

This function creates a Custom Category in the Spawnlist. Use [GenerateSpawnlistFromPath](https://wiki.facepunch.com/gmod/Global.GenerateSpawnlistFromPath) if you want to create a category with the contents of a folder.

**Arguments:**
- `pnlContent` (Panel) — The SMContentPanel of the Node.
- `node` (Panel) — The Node.
- `parentid` (number) — The ParentID to use.
- `customProps` (table) — The Table with the Contents of the new Category.

> **Warning:** Using this function before [SANDBOX:PopulateContent](https://wiki.facepunch.com/gmod/SANDBOX:PopulateContent) has been called will result in an error.

[wiki](https://wiki.facepunch.com/gmod/Global.AddPropsOfParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/custom.lua#L139-L172)

---

### AddWorldTip · Client
`AddWorldTip(entindex: number = nil, text: string, dieTime: number = SysTime() + 0.05, pos: Vector = ent:GetPos(), ent: Entity = nil)`

This function creates a World Tip, similar to the one shown when aiming at a Thruster where it shows you its force.

This function will make a World Tip that will only last 50 milliseconds (1/20th of a second), so you must call it continuously as long as you want the World Tip to be shown. It is common to call it inside a Think hook.

Contrary to what the function's name implies, it is impossible to create more than one World Tip at the same time. A new World Tip will overwrite the old one, so only use this function when you know nothing else will also be using it.

See [SANDBOX:PaintWorldTips](https://wiki.facepunch.com/gmod/SANDBOX:PaintWorldTips) for more information.

**Arguments:**
- `entindex` (number, default `nil`) — This argument is no longer used; it has no effect on anything.
- `text` (string) — The text for the world tip to display.
- `dieTime` (number, default `SysTime() + 0.05`) — This argument is no longer used; when you add a World Tip it will always last only 0.05 seconds.
- `pos` (Vector, default `ent:GetPos()`) — Where in the world you want the World Tip to be drawn.
- `ent` (Entity, default `nil`) — Which entity you want to associate with the World Tip.

> **Note:** This function is only available in Sandbox and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Global.AddWorldTip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/cl_worldtips.lua#L18-L27)

---

### Angle · Shared, Menu
`Angle(pitch: number = 0, yaw: number = 0, roll: number = 0, angle: Angle, angleString: string) → Angle`

Creates an [Angle](https://wiki.facepunch.com/gmod/Angle) object, representing a [Euler Angle](https://en.wikipedia.org/wiki/Euler_angles) made up of pitch, yaw, and roll components.

**Arguments:**
- `pitch` (number, default `0`) — The pitch value of the angle, in degrees.
- `yaw` (number, default `0`) — The yaw value of the angle, in degrees.
- `roll` (number, default `0`) — The roll value of the angle, in degrees.
- `angle` (Angle) — Creates a new Angle that is a copy of the Angle passed in.
- `angleString` (string) — Attempts to parse the input string from the print format of an Angle.

**Returns:**
- Angle — The newly created Angle.

> **Warning:** This function is relatively expensive, in terms of performance, in situations where it is being called multiple times every frame (Like a loop, for example.) This is due to the overhead associated with object creation and garbage collection.
> 			Where possible, it is generally better to store an [Angle](https://wiki.facepunch.com/gmod/Angle) in a variable and re-use that variable rather than re-creating it repeatedly.
> 			In cases where an empty [Angle](https://wiki.facepunch.com/gmod/Angle) is needed, the global variable `angle_zero` is the preferred solution instead of `Angle( 0, 0, 0 )`.

[wiki](https://wiki.facepunch.com/gmod/Global.Angle)

---

### AngleRand · Shared, Menu
`AngleRand(min: number = -90 for pitch, -180 for yaw and roll, max: number = 90 for pitch, 180 for yaw and roll) → Angle`

Returns an angle with a randomized pitch, yaw, and roll between min(inclusive), max(exclusive).

**Arguments:**
- `min` (number, default `-90 for pitch, -180 for yaw and roll`) — Min bound inclusive.
- `max` (number, default `90 for pitch, 180 for yaw and roll`) — Max bound exclusive.

**Returns:**
- Angle — The randomly generated angle.

[wiki](https://wiki.facepunch.com/gmod/Global.AngleRand) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L107-L109)

---

### assert · Shared, Menu
`assert(expression: any, errorMessage: string = assertion failed!, returns: vararg = nil) → any, any, vararg`

If the result of the first argument is false or nil, an error is thrown with the second argument as the message.

**Arguments:**
- `expression` (any) — The expression to assert.
- `errorMessage` (string, default `assertion failed!`) — The error message to throw when assertion fails.
- `returns` (vararg, default `nil`) — Any arguments past the error message will be returned by a successful assert.

**Returns:**
- any — If successful, returns the first argument.
- any — If successful, returns the error message.
- vararg — Returns any arguments past the error message.

[wiki](https://wiki.facepunch.com/gmod/Global.assert)

---

### BRANCH · Shared, Menu
`BRANCH`

[wiki](https://wiki.facepunch.com/gmod/Global.BRANCH)

---

### BroadcastLua · Shared
`BroadcastLua(code: string)`

Sends the specified Lua code to all connected clients and executes it.

**Arguments:**
- `code` (string) — The code to be executed.

> **Note:** If you need to use this function more than once, consider using [net](https://wiki.facepunch.com/gmod/net) library.
> 			Send net message and make the entire code you want to execute in [net.Receive](https://wiki.facepunch.com/gmod/net.Receive) on client.  
> 
> 			If executed **clientside**, this function won't do anything.

[wiki](https://wiki.facepunch.com/gmod/Global.BroadcastLua)

---

### BuildNetworkedVarsTable · Shared
`BuildNetworkedVarsTable() → table`

Dumps the networked variables of all entities into one table and returns it.

**Returns:**
- table — Format: * key = Entity for NWVars or number (always 0) for global vars.

[wiki](https://wiki.facepunch.com/gmod/Global.BuildNetworkedVarsTable)

---

### CanAddServerToFavorites · Menu · `INTERNAL`
`CanAddServerToFavorites() → boolean`

Used internally to check if the current server the player is on can be added to favorites or not. Does not check if the server is ALREADY in the favorites.

**Returns:**
- boolean — Can add to favorites?

[wiki](https://wiki.facepunch.com/gmod/Global.CanAddServerToFavorites)

---

### CancelLoading · Menu
`CancelLoading()`

Aborts joining of the server you are currently joining.

[wiki](https://wiki.facepunch.com/gmod/Global.CancelLoading)

---

### ChangeBackground · Menu
`ChangeBackground(currentgm: string)`

Sets the active main menu background image to a random entry from the background images pool. Images are added with [AddBackgroundImage](https://wiki.facepunch.com/gmod/Global.AddBackgroundImage).

**Arguments:**
- `currentgm` (string) — Apparently does nothing.

[wiki](https://wiki.facepunch.com/gmod/Global.ChangeBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/background.lua#L109-L164)

---

### ChangeTooltip · Client, Menu
`ChangeTooltip(panel: Panel)`

Automatically called by the engine when a panel is hovered over with the mouse

**Arguments:**
- `panel` (Panel) — Panel that has been hovered over

[wiki](https://wiki.facepunch.com/gmod/Global.ChangeTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/tooltips.lua#L42-L64)

---

### ClearBackgroundImages · Menu
`ClearBackgroundImages()`

Empties the pool of main menu background images.

[wiki](https://wiki.facepunch.com/gmod/Global.ClearBackgroundImages) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/background.lua#L95-L99)

---

### ClearLuaErrorGroup · Menu
`ClearLuaErrorGroup(group_id: string)`

Clears all Lua Errors with the given group id.

**Arguments:**
- `group_id` (string) — group_id to remove.

[wiki](https://wiki.facepunch.com/gmod/Global.ClearLuaErrorGroup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L73-L86)

---

### ClearProblem · Menu
`ClearProblem(id: string)`

Removes the given Problem from the Problems table and refreshes the Problems panel.

**Arguments:**
- `id` (string) — The Problem ID to remove

[wiki](https://wiki.facepunch.com/gmod/Global.ClearProblem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L88-L98)

---

### ClientsideModel · Client
`ClientsideModel(model: string, renderGroup: number = RENDERGROUP_OTHER) → CSEnt|nil`

Creates a non physical entity that only exists on the client. See also [ents.CreateClientProp](https://wiki.facepunch.com/gmod/ents.CreateClientProp) if physics is wanted.

**Arguments:**
- `model` (string) — The file path to the model.
- `renderGroup` (number, default `RENDERGROUP_OTHER`, enum [RENDERGROUP](https://wiki.facepunch.com/gmod/Enums/RENDERGROUP)) — The render group of the entity for the clientside leaf system, see RENDERGROUP.

**Returns:**
- CSEnt|nil — Created client-side model (`C_BaseFlex`) or `nil` if creation of the entity failed for any reason.

> **Bug** ([#861](https://github.com/Facepunch/garrysmod/issues/861)): Parented clientside models will become detached if the parent entity leaves the PVS. A workaround is available on the issue tracker page linked below.
> **Bug** ([#1387](https://github.com/Facepunch/garrysmod/issues/1387)): Clientside entities are not garbage-collected, thus you must store a reference to the object (in a variable) and call [CSEnt:Remove](https://wiki.facepunch.com/gmod/CSEnt:Remove) manually when necessary.
> **Bug** ([#3184](https://github.com/Facepunch/garrysmod/issues/3184)): Clientside models will occasionally delete themselves during high server lag.

[wiki](https://wiki.facepunch.com/gmod/Global.ClientsideModel)

---

### ClientsideRagdoll · Client
`ClientsideRagdoll(model: string, renderGroup: number = RENDERGROUP_OPAQUE) → CSEnt`

Creates a fully clientside ragdoll.

**Arguments:**
- `model` (string) — The file path to the model.
- `renderGroup` (number, default `RENDERGROUP_OPAQUE`, enum [RENDERGROUP](https://wiki.facepunch.com/gmod/Enums/RENDERGROUP)) — The RENDERGROUP to assign.

**Returns:**
- CSEnt — The newly created client-side only ragdoll.

> **Note:** The ragdoll initially starts as hidden and with shadows disabled, see the example for how to enable it.
> 
> There's no need to call [Entity:Spawn](https://wiki.facepunch.com/gmod/Entity:Spawn) on this entity.
> **Bug** ([#1387](https://github.com/Facepunch/garrysmod/issues/1387)): Clientside entities are not garbage-collected, thus you must store a reference to the object and call [CSEnt:Remove](https://wiki.facepunch.com/gmod/CSEnt:Remove) manually.

[wiki](https://wiki.facepunch.com/gmod/Global.ClientsideRagdoll)

---

### ClientsideScene · Client
`ClientsideScene(name: string, targetEnt: Entity) → CSEnt`

Creates a scene entity based on the scene name and the entity.

**Arguments:**
- `name` (string) — The name of the scene.
- `targetEnt` (Entity) — The entity to play the scene on.

**Returns:**
- CSEnt — C_SceneEntity

[wiki](https://wiki.facepunch.com/gmod/Global.ClientsideScene)

---

### CloseDermaMenus · Client, Menu
`CloseDermaMenus()`

Closes all Derma menus that have been passed to [RegisterDermaMenuForClose](https://wiki.facepunch.com/gmod/Global.RegisterDermaMenuForClose) and calls [GM:CloseDermaMenus](https://wiki.facepunch.com/gmod/GM:CloseDermaMenus)

[wiki](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_menus.lua#L20-L38)

---

### collectgarbage · Shared, Menu
`collectgarbage(action: string = collect, arg: number) → any`

Executes the specified action on the garbage collector.

**Arguments:**
- `action` (string, default `collect`) — The action to run.
- `arg` (number) — The argument of the specified action, only applicable for `step`, `setpause` and `setstepmul`.

**Returns:**
- any — If the action is count this is the number of kilobytes of memory used by Lua.

[wiki](https://wiki.facepunch.com/gmod/Global.collectgarbage)

---

### Color · Shared, Menu
`Color(r: number, g: number, b: number, a: number = 255) → Color`

Creates a [Color](https://wiki.facepunch.com/gmod/Color).
	

Here is a list of colors already cached by the game 

Variable | Color (RGBA) |
-----|------------|
| color_white | Color(255, 255, 255, 255) |
| color_black | Color(0, 0, 0, 255) |
| color_transparent | Color(255, 255, 255, 0) |

**Arguments:**
- `r` (number) — An integer from `0-255` describing the red value of the color.
- `g` (number) — An integer from `0-255` describing the green value of the color.
- `b` (number) — An integer from `0-255` describing the blue value of the color.
- `a` (number, default `255`) — An integer from `0-255` describing the alpha (transparency) of the color.(default 255)

**Returns:**
- Color — The created Color.

> **Warning:** Under no circumstances should these variables be modified (by a Lerp or value modification). Some addons that use these values (e.g. color_white) will be affected by this change.
> **Warning:** This function is relatively expensive when used in rendering hooks or in operations requiring very frequent calls (like loops for example) due to object creation and garbage collection. It is better to store the color in a variable or to use the [default colors](https://wiki.facepunch.com/gmod/Global_Variables#misc) available.

[wiki](https://wiki.facepunch.com/gmod/Global.Color) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L14-L19)

---

### ColorAlpha · Shared, Menu
`ColorAlpha(color: Color, alpha: number) → table`

Returns a new [Color](https://wiki.facepunch.com/gmod/Color) with the RGB components of the given [Color](https://wiki.facepunch.com/gmod/Color) and the alpha value specified.

**Arguments:**
- `color` (Color) — The Color from which to take RGB values.
- `alpha` (number) — The new alpha value, a number between 0 and 255.

**Returns:**
- table — The new Color with the modified alpha value

[wiki](https://wiki.facepunch.com/gmod/Global.ColorAlpha) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L24-L28)

---

### ColorRand · Shared, Menu
`ColorRand(a: boolean = false) → Color`

Creates a [Color](https://wiki.facepunch.com/gmod/Color) with randomized red, green, and blue components. If the alpha argument is true, alpha will also be randomized.

**Arguments:**
- `a` (boolean, default `false`) — Should alpha be randomized.

**Returns:**
- Color — The created Color.

[wiki](https://wiki.facepunch.com/gmod/Global.ColorRand) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L114-L120)

---

### ColorToHSL · Shared, Menu
`ColorToHSL(color: Color) → number, number, number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into HSL color space.

**Arguments:**
- `color` (Color) — The Color.

**Returns:**
- number — The hue in degrees `[0, 360]`.
- number — The saturation in the range `[0, 1]`.
- number — The lightness in the range `[0, 1]`.

[wiki](https://wiki.facepunch.com/gmod/Global.ColorToHSL)

---

### ColorToHSV · Shared, Menu
`ColorToHSV(color: Color) → number, number, number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into HSV color space.

**Arguments:**
- `color` (Color) — The Color.

**Returns:**
- number — The hue in degrees `[0, 360]`.
- number — The saturation in the range `[0, 1]`.
- number — The value in the range `[0, 1]`.

[wiki](https://wiki.facepunch.com/gmod/Global.ColorToHSV)

---

### CompileFile · Shared
`CompileFile(path: string, showError: boolean = true) → function`

Attempts to compile the given file. If successful, returns a function that can be called to perform the actual execution of the script.

**Arguments:**
- `path` (string) — Path to the file, relative to the `garrysmod/lua/` directory.
- `showError` (boolean, default `true`) — Decides whether or not a non-halting error should be thrown on compile failure.

**Returns:**
- function — The function which executes the script.

[wiki](https://wiki.facepunch.com/gmod/Global.CompileFile)

---

### CompileString · Shared
`CompileString(code: string, identifier: string, handleError: boolean = true) → function`

This function will compile the code argument as lua code and return a function that will execute that code. 

Please note that this function will not automatically execute the given code after compiling it.

**Arguments:**
- `code` (string) — The code to compile.
- `identifier` (string) — An identifier in case an error is thrown.
- `handleError` (boolean, default `true`) — If false this function will return an error string instead of throwing an error.

**Returns:**
- function — A function that, when called, will execute the given code.

[wiki](https://wiki.facepunch.com/gmod/Global.CompileString)

---

### ConVarExists · Shared, Menu
`ConVarExists(name: string) → boolean`

Returns whether a [ConVar](https://wiki.facepunch.com/gmod/ConVar) with the given name exists or not

**Arguments:**
- `name` (string) — Name of the ConVar.

**Returns:**
- boolean — True if the ConVar exists, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/Global.ConVarExists)

---

### CreateClientConVar · Shared, Menu
`CreateClientConVar(name: string, default: string, shouldsave: boolean = true, userinfo: boolean = false, helptext: string, min: number = nil, max: number = nil) → ConVar`

Makes a clientside-only console variable



Although this function is shared, it should only be used clientside.

**Arguments:**
- `name` (string) — Name of the ConVar to be created and able to be accessed.
- `default` (string) — Default value of the ConVar.
- `shouldsave` (boolean, default `true`) — Should the ConVar be saved across sessions in the cfg/client.vdf file.
- `userinfo` (boolean, default `false`) — Should the ConVar and its containing data be sent to the server when it has changed.
- `helptext` (string) — Help text to display in the console.
- `min` (number, default `nil`) — If set, the convar cannot be changed to a number lower than this value.
- `max` (number, default `nil`) — If set, the convar cannot be changed to a number higher than this value.

**Returns:**
- ConVar — Created convar.

> **Note:** This function is a wrapper of [CreateConVar](https://wiki.facepunch.com/gmod/Global.CreateConVar), with the difference being that FCVAR_ARCHIVE and FCVAR_USERINFO are added automatically when **shouldsave** and **userinfo** are true, respectively.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateClientConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L414-L428)

---

### CreateContextMenu · Client · `INTERNAL`
`CreateContextMenu()`

Creates a ContextMenu.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateContextMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/contextmenu.lua#L136-L221)

---

### CreateConVar · Shared, Menu
`CreateConVar(name: string, value: string, flags: number{FCVAR}|table<number> = FCVAR_NONE, helptext: string, min: number = nil, max: number = nil) → ConVar`

Creates a console variable ([ConVar](https://wiki.facepunch.com/gmod/ConVar)).

Generally these are used for settings, which can be stored automatically across sessions if desired. They are usually set via an accompanying user interface clientside, or listed somewhere for dedicated server usage, in which case they might be set via `server.cfg` on server start up.

**Arguments:**
- `name` (string) — Name of the ConVar.
- `value` (string) — Default value of the convar.
- `flags` (number{FCVAR}|table<number>, default `FCVAR_NONE`) — Flags of the convar, see FCVAR, either as bitflag or as table.
- `helptext` (string) — The help text to show in the console.
- `min` (number, default `nil`) — If set, the ConVar cannot be changed to a number lower than this value.
- `max` (number, default `nil`) — If set, the ConVar cannot be changed to a number higher than this value.

**Returns:**
- ConVar — The convar created, or `nil` if convar could not be created.

> **Warning:** Do not use the FCVAR_NEVER_AS_STRING and FCVAR_REPLICATED flags together, as this can cause the console variable to have strange values on the client.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateConVar)

---

### CreateMaterial · Client, Menu
`CreateMaterial(name: string, shaderName: string, materialData: table) → IMaterial`

Creates a new material with the specified name and shader.

Materials created with this function can be used in [Entity:SetMaterial](https://wiki.facepunch.com/gmod/Entity:SetMaterial) and [Entity:SetSubMaterial](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial) by prepending a `!` to their material name argument.

This will not create a new material if another material object with the same name already exists. All Materials created by this functions are cleaned up on map shutdown.

**Arguments:**
- `name` (string) — The material name.
- `shaderName` (string) — The shader name.
- `materialData` (table) — Key-value table that contains shader parameters and proxies.

**Returns:**
- IMaterial — Created material

> **Note:** This does not work with [patch materials](https://developer.valvesoftware.com/wiki/Patch).
> **Bug** ([#1531](https://github.com/Facepunch/garrysmod/issues/1531)): .pngs must be loaded with [Material](https://wiki.facepunch.com/gmod/Global.Material) before being used with this function.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateMaterial)

---

### CreateNewAddonPreset · Menu
`CreateNewAddonPreset(data: string)`

Creates a new Preset from the given JSON string.

**Arguments:**
- `data` (string) — A JSON string containing all necessary information.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateNewAddonPreset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L585-L592)

---

### CreateParticleSystem · Client
`CreateParticleSystem(ent: Entity, effect: string, partAtt: number, entAtt: number = 0, offset: Vector = Vector( 0, 0, 0 )) → CNewParticleEffect`

Creates a new particle system. See also [Entity:CreateParticleEffect](https://wiki.facepunch.com/gmod/Entity:CreateParticleEffect), [ParticleEffectAttach](https://wiki.facepunch.com/gmod/Global.ParticleEffectAttach) and [CreateParticleSystemNoEntity](https://wiki.facepunch.com/gmod/Global.CreateParticleSystemNoEntity).

**Arguments:**
- `ent` (Entity) — The entity to attach the control point to.
- `effect` (string) — The name of the effect to create.
- `partAtt` (number, enum [PATTACH](https://wiki.facepunch.com/gmod/Enums/PATTACH)) — See PATTACH.
- `entAtt` (number, default `0`) — The attachment ID on the entity to attach the particle system to
- `offset` (Vector, default `Vector( 0, 0, 0 )`) — The offset from the Entity:GetPos of the entity we are attaching this CP to.

**Returns:**
- CNewParticleEffect — The created particle system.

> **Note:** The particle effect must be precached with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem) and the file its from must be added via [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) before it can be used!

[wiki](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem)

---

### CreateParticleSystemNoEntity · Client
`CreateParticleSystemNoEntity(effect: string, pos: Vector, ang: Angle = Angle( 0, 0, 0 )) → CNewParticleEffect`

Creates a new particle system, and sets control points 0 and 1 to given position, as well as optionally orientation of CP0 to the given angles. See also [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem)

**Arguments:**
- `effect` (string) — The name of the effect to create.
- `pos` (Vector) — The position for the particle system.
- `ang` (Angle, default `Angle( 0, 0, 0 )`) — The orientation of the particle system.

**Returns:**
- CNewParticleEffect — The created particle system.

> **Note:** The particle effect must be precached with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem) and the file its from must be added via [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) before it can be used!

[wiki](https://wiki.facepunch.com/gmod/Global.CreateParticleSystemNoEntity)

---

### CreatePhysCollideBox · Shared
`CreatePhysCollideBox(mins: Vector, maxs: Vector) → PhysCollide`

Creates a new [PhysCollide](https://wiki.facepunch.com/gmod/PhysCollide) from the given bounds.

**Arguments:**
- `mins` (Vector) — Min corner of the box.
- `maxs` (Vector) — Max corner of the box.

**Returns:**
- PhysCollide — The new PhysCollide.

> **Bug** ([#3568](https://github.com/Facepunch/garrysmod/issues/3568)): This fails to create planes or points - no components of the mins or maxs can be the same.

[wiki](https://wiki.facepunch.com/gmod/Global.CreatePhysCollideBox)

---

### CreatePhysCollidesFromModel · Shared
`CreatePhysCollidesFromModel(modelName: string) → table<PhysCollide>`

Creates [PhysCollide](https://wiki.facepunch.com/gmod/PhysCollide) objects for every physics object the model has. The model must be precached with [util.PrecacheModel](https://wiki.facepunch.com/gmod/util.PrecacheModel) before being used with this function.

**Arguments:**
- `modelName` (string) — Model path to get the collision objects of.

**Returns:**
- table<PhysCollide> — Table of PhysCollide objects.

[wiki](https://wiki.facepunch.com/gmod/Global.CreatePhysCollidesFromModel)

---

### CreateSound · Shared
`CreateSound(targetEnt: Entity, soundName: string, filter: CRecipientFilter = nil) → CSoundPatch`

Returns a sound parented to the specified entity.

**Arguments:**
- `targetEnt` (Entity) — The target entity.
- `soundName` (string) — The sound to play.
- `filter` (CRecipientFilter, default `nil`) — A CRecipientFilter of the players that will have this sound networked to them.

**Returns:**
- CSoundPatch — The sound object.

> **Note:** You can only create one CSoundPatch per audio file, per entity at the same time.
> **Note:** Valid sample rates: **11025 Hz, 22050 Hz and 44100 Hz**, otherwise you may see this kind of message:
> 
> `Unsupported 32-bit wave file your_sound.wav` and 
> `Invalid sample rate (48000) for sound 'your_sound.wav'`

[wiki](https://wiki.facepunch.com/gmod/Global.CreateSound)

---

### CreateSprite · Client
`CreateSprite(material: IMaterial) → Panel`

Creates and returns a new [DSprite](https://wiki.facepunch.com/gmod/DSprite) element with the supplied material.

**Arguments:**
- `material` (IMaterial) — Material the sprite should draw.

**Returns:**
- Panel — The new DSprite element.

[wiki](https://wiki.facepunch.com/gmod/Global.CreateSprite) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dsprite.lua#L51-L55)

---

### CurTime · Shared, Menu
`CurTime() → number`

Returns the uptime of the server in seconds (to at least 4 decimal places)

This is a synchronised value and affected by various factors such as host_timescale (or [game.GetTimeScale](https://wiki.facepunch.com/gmod/game.GetTimeScale)) and the server being paused - either by `sv_pausable` or all players disconnecting.

You should use this function for timing in-game events but not for real-world events.

See also: [RealTime](https://wiki.facepunch.com/gmod/Global.RealTime), [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime)

**Returns:**
- number — Time synced with the game server.

[wiki](https://wiki.facepunch.com/gmod/Global.CurTime)

---

### DamageInfo · Shared
`DamageInfo() → CTakeDamageInfo`

Returns an [CTakeDamageInfo](https://wiki.facepunch.com/gmod/CTakeDamageInfo) object.

**Returns:**
- CTakeDamageInfo — The CTakeDamageInfo object.

> **Bug** ([#2771](https://github.com/Facepunch/garrysmod/issues/2771)): This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once.

[wiki](https://wiki.facepunch.com/gmod/Global.DamageInfo)

---

### DebugInfo · Shared, Menu
`DebugInfo(slot: number, info: string)`

Writes text to the right hand side of the screen, like the old error system. Messages disappear after a couple of seconds.

**Arguments:**
- `slot` (number) — The location on the right hand screen to write the debug info to.
- `info` (string) — The debugging information to be written to the screen

[wiki](https://wiki.facepunch.com/gmod/Global.DebugInfo)

---

### DEFINE_BASECLASS · Shared, Menu
`DEFINE_BASECLASS(value: string)`

Generates and provides a local variable `BaseClass` that can be used to call the original version of a class functions after modifying it.

		This is a preprocessor keyword that is directly replaced with the following text:
```lua
local BaseClass = baseclass.Get
```lua

Because this is a simple preprocessor keyword and not a function, it will cause problems if not used properly

See [baseclass.Get](https://wiki.facepunch.com/gmod/baseclass.Get) for more information.
	

For more information, including usage examples, see the [BaseClasses](https://wiki.facepunch.com/gmod/BaseClasses) reference page.

**Arguments:**
- `value` (string) — Baseclass name

> **Warning:** The preprocessor is not smart enough to know when substitution doesn't make sense, such as: table keys and strings.  
> 
> Running `print("DEFINE_BASECLASS")` is the same as `print("local BaseClass = baseclass.Get")`

[wiki](https://wiki.facepunch.com/gmod/Global.DEFINE_BASECLASS)

---

### DeleteAddonPreset · Menu
`DeleteAddonPreset(name: string)`

Deletes the given Preset.

**Arguments:**
- `name` (string) — The name of the Preset to delete.

[wiki](https://wiki.facepunch.com/gmod/Global.DeleteAddonPreset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L611-L620)

---

### DeriveGamemode · Shared
`DeriveGamemode(base: string)`

Loads and registers the specified gamemode, setting the GM table's DerivedFrom field to the value provided, if the table exists. The DerivedFrom field is used post-gamemode-load as the "derived" parameter for [gamemode.Register](https://wiki.facepunch.com/gmod/gamemode.Register). See  [Gamemode_Creation#derivinggamemodes](https://wiki.facepunch.com/gmod/Gamemode_Creation#derivinggamemodes) for more information about deriving gamemodes.

**Arguments:**
- `base` (string) — Gamemode name to derive from.

[wiki](https://wiki.facepunch.com/gmod/Global.DeriveGamemode)

---

### Derma_Anim · Client, Menu
`Derma_Anim(name: string, panel: Panel, func: function) → table`

Creates a new derma animation.

**Arguments:**
- `name` (string) — Name of the animation to create
- `panel` (Panel) — Panel to run the animation on
- `func` (function) — Function to call to process the animation

**Returns:**
- table — A lua metatable containing four methods: * Run() - Should be called each frame you want the animation to be ran.

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_Anim) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_animation.lua#L59-L70)

---

### Derma_DrawBackgroundBlur · Client, Menu
`Derma_DrawBackgroundBlur(panel: Panel, startTime: number)`

Draws background blur around the given panel.

**Arguments:**
- `panel` (Panel) — Panel to draw the background blur around
- `startTime` (number) — Time that the blur began being painted

> **Note:** Calling this on the same [Panel](https://wiki.facepunch.com/gmod/Panel) multiple times makes the blur darker.

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_DrawBackgroundBlur) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_utils.lua#L7-L37)

---

### Derma_Hook · Client, Menu
`Derma_Hook(panel: Panel, functionName: string, hookName: string, typeName: string)`

Creates panel method that calls the supplied Derma skin hook via [derma.SkinHook](https://wiki.facepunch.com/gmod/derma.SkinHook)

**Arguments:**
- `panel` (Panel) — Panel to add the hook to
- `functionName` (string) — Name of panel function to create
- `hookName` (string) — Name of Derma skin hook to call within the function
- `typeName` (string) — Type of element to call Derma skin hook for

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_Hook) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/init.lua#L50-L56)

---

### Derma_Install_Convar_Functions · Client, Menu
`Derma_Install_Convar_Functions(target: Panel)`

Makes the panel (usually an input of sorts) respond to changes in console variables by adding next functions to the panel:
* [Panel:SetConVar](https://wiki.facepunch.com/gmod/Panel:SetConVar)
* [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged)
* [Panel:ConVarStringThink](https://wiki.facepunch.com/gmod/Panel:ConVarStringThink)
* [Panel:ConVarNumberThink](https://wiki.facepunch.com/gmod/Panel:ConVarNumberThink)

The console variable value is saved in the `m_strConVar` property of the panel.

The panel should call
[Panel:ConVarStringThink](https://wiki.facepunch.com/gmod/Panel:ConVarStringThink) or 
[Panel:ConVarNumberThink](https://wiki.facepunch.com/gmod/Panel:ConVarNumberThink) 
in its [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think) hook and should call [Panel:ConVarChanged](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) when the panel's value has changed.

**Arguments:**
- `target` (Panel) — The panel the functions should be added to.

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_Install_Convar_Functions) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/init.lua#L76-L117)

---

### Derma_Message · Client, Menu
`Derma_Message(Text: string, Title: string, Button: string) → Panel`

Creates a derma window to display information

**Arguments:**
- `Text` (string) — The text within the created panel.
- `Title` (string) — The title of the created panel.
- `Button` (string) — The text of the button to close the panel.

**Returns:**
- Panel — The created DFrame

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_Message) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_utils.lua#L45-L92)

---

### Derma_Query · Client, Menu
`Derma_Query(text: string = Message Text (Second Parameter), title: string = Message Title (First Parameter), btn1text: string, btn1func: function = nil, btn2text: string = nil, btn2func: function = nil, btn3text: string = nil, btn3func: function = nil, btn4text: string = nil, btn4func: function = nil) → Panel`

Shows a message box in the middle of the screen, with up to 4 buttons they can press.

**Arguments:**
- `text` (string, default `Message Text (Second Parameter)`) — The message to display.
- `title` (string, default `Message Title (First Parameter)`) — The title to give the message box.
- `btn1text` (string) — The text to display on the first button.
- `btn1func` (function, default `nil`) — The function to run if the user clicks the first button.
- `btn2text` (string, default `nil`) — The text to display on the second button.
- `btn2func` (function, default `nil`) — The function to run if the user clicks the second button.
- `btn3text` (string, default `nil`) — The text to display on the third button
- `btn3func` (function, default `nil`) — The function to run if the user clicks the third button.
- `btn4text` (string, default `nil`) — The text to display on the fourth button
- `btn4func` (function, default `nil`) — The function to run if the user clicks the fourth button.

**Returns:**
- Panel — The Panel object of the created window.

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_Query) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_utils.lua#L104-L179)

---

### Derma_StringRequest · Client, Menu
`Derma_StringRequest(title: string, subtitle: string, default: string, confirm: function, cancel: function = nil, confirmText: string = OK, cancelText: string = Cancel) → Panel`

Creates a derma window asking players to input a string.

**Arguments:**
- `title` (string) — The title of the created panel.
- `subtitle` (string) — The text above the input box.
- `default` (string) — The default text for the input box.
- `confirm` (function) — The function to be called once the user has confirmed their input.
- `cancel` (function, default `nil`) — The function to be called once the user has cancelled their input.
- `confirmText` (string, default `OK`) — Allows you to override text of the "OK" button
- `cancelText` (string, default `Cancel`) — Allows you to override text of the "Cancel" button

**Returns:**
- Panel — The created DFrame

[wiki](https://wiki.facepunch.com/gmod/Global.Derma_StringRequest) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_utils.lua#L194-L263)

---

### DermaMenu · Client, Menu
`DermaMenu(keepOpen: boolean = false, parent: Panel = nil) → Panel`

Creates a [DMenu](https://wiki.facepunch.com/gmod/DMenu) and closes any current menus.

**Arguments:**
- `keepOpen` (boolean, default `false`) — If we should keep other DMenus open (`true`) or not (`false`).
- `parent` (Panel, default `nil`) — The panel to parent the created menu to.

**Returns:**
- `menu` (Panel) — The created DMenu.

[wiki](https://wiki.facepunch.com/gmod/Global.DermaMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_menus.lua#L10-L18)

---

### DisableClipping · Client, Menu
`DisableClipping(disable: boolean) → boolean`

Sets whether rendering should be limited to being inside a panel or not. Needs to be used inside one of the [2d rendering hooks](https://wiki.facepunch.com/gmod/2d%20rendering%20hooks)

See also [Panel:NoClipping](https://wiki.facepunch.com/gmod/Panel:NoClipping).

**Arguments:**
- `disable` (boolean) — Whether or not clipping should be disabled

**Returns:**
- `oldState` (boolean) — Whether the clipping was enabled or not before this function call

[wiki](https://wiki.facepunch.com/gmod/Global.DisableClipping)

---

### DOF_Kill · Client
`DOF_Kill()`

Cancels current DOF post-process effect started with [DOF_Start](https://wiki.facepunch.com/gmod/Global.DOF_Start)

[wiki](https://wiki.facepunch.com/gmod/Global.DOF_Kill) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/dof.lua#L14-L26)

---

### DOF_Start · Client
`DOF_Start()`

Cancels any existing DOF post-process effects.
Begins the DOF post-process effect.

[wiki](https://wiki.facepunch.com/gmod/Global.DOF_Start) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/dof.lua#L28-L42)

---

### DOFModeHack · Client · `INTERNAL`
`DOFModeHack(enable: boolean)`

A hacky method used to fix some bugs regarding DoF. What this basically does it force all `C_BaseAnimating` entities to have the translucent [rendergroup](https://wiki.facepunch.com/gmod/Enums/RENDERGROUP), even if they use opaque or two-pass models.

This is specifically to do with [GM:NeedsDepthPass](https://wiki.facepunch.com/gmod/GM:NeedsDepthPass)

**Arguments:**
- `enable` (boolean) — Enables or disables depth-of-field mode

[wiki](https://wiki.facepunch.com/gmod/Global.DOFModeHack)

---

### DoStopServers · Menu
`DoStopServers(category: string)`

Stops searching for new servers in the given category

**Arguments:**
- `category` (string) — The category to stop searching in.

[wiki](https://wiki.facepunch.com/gmod/Global.DoStopServers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L447-L451)

---

### DrawBackground · Menu · `INTERNAL`
`DrawBackground()`

Draws the currently active main menu background image and handles transitioning between background images.

This is called by default in the menu panel's Paint hook.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/background.lua#L73-L93)

---

### DrawBloom · Client
`DrawBloom(Darken: number, Multiply: number, SizeX: number, SizeY: number, Passes: number, ColorMultiply: number, Red: number, Green: number, Blue: number)`

Draws the bloom shader, which creates a glowing effect from bright objects.

**Arguments:**
- `Darken` (number) — Determines how much to darken the effect.
- `Multiply` (number) — Will affect how bright the glowing spots are.
- `SizeX` (number) — The size of the bloom effect along the horizontal axis.
- `SizeY` (number) — The size of the bloom effect along the vertical axis.
- `Passes` (number) — Determines how much to exaggerate the effect.
- `ColorMultiply` (number) — Will multiply the colors of the glowing spots, making them more vivid.
- `Red` (number) — How much red to multiply with the glowing color.
- `Green` (number) — How much green to multiply with the glowing color.
- `Blue` (number) — How much blue to multiply with the glowing color.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawBloom) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/bloom.lua#L25-L59)

---

### DrawBokehDOF · Client
`DrawBokehDOF(intensity: number, distance: number, focus: number)`

Draws the Bokeh Depth Of Field effect .

**Arguments:**
- `intensity` (number) — Intensity of the effect.
- `distance` (number) — Not worldspace distance.
- `focus` (number) — Focus.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawBokehDOF)

---

### DrawColorModify · Client
`DrawColorModify(modifyParameters: table)`

Draws the Color Modify shader, which can be used to adjust colors on screen.

**Arguments:**
- `modifyParameters` (table) — Color modification parameters.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawColorModify) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/color_modify.lua#L19-L32)

---

### DrawMaterialOverlay · Client
`DrawMaterialOverlay(Material: string, RefractAmount: number)`

Draws a material overlay on the screen.

**Arguments:**
- `Material` (string) — This will be the material that is drawn onto the screen.
- `RefractAmount` (number) — This will adjust how much the material will refract your screen.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawMaterialOverlay) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/overlay.lua#L11-L31)

---

### DrawMotionBlur · Client
`DrawMotionBlur(AddAlpha: number, DrawAlpha: number, Delay: number)`

Creates a motion blur effect by drawing your screen multiple times.

**Arguments:**
- `AddAlpha` (number) — How much alpha to change per frame.
- `DrawAlpha` (number) — How much alpha the frames will have.
- `Delay` (number) — Determines the amount of time between frames to capture.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawMotionBlur) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/motion_blur.lua#L17-L61)

---

### DrawSharpen · Client
`DrawSharpen(Contrast: number, Distance: number)`

Draws the sharpen shader, which creates more contrast.

**Arguments:**
- `Contrast` (number) — How much contrast to create.
- `Distance` (number) — How large the contrast effect will be.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawSharpen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/sharpen.lua#L12-L22)

---

### DrawSobel · Client
`DrawSobel(Threshold: number)`

Draws the sobel shader, which detects edges and draws a black border.

**Arguments:**
- `Threshold` (number) — Determines the threshold of edges.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawSobel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/sobel.lua#L8-L18)

---

### DrawSunbeams · Client
`DrawSunbeams(darken: number, multiplier: number, sunSize: number, sunX: number, sunY: number)`

Renders the post-processing effect of beams of light originating from the map's sun. Utilises the `pp/sunbeams` material.

**Arguments:**
- `darken` (number) — `$darken` property for sunbeams material.
- `multiplier` (number) — `$multiply` property for sunbeams material.
- `sunSize` (number) — `$sunsize` property for sunbeams material.
- `sunX` (number) — `$sunx` property for sunbeams material.
- `sunY` (number) — `$suny` property for sunbeams material.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawSunbeams) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/sunbeams.lua#L14-L29)

---

### DrawTexturize · Client
`DrawTexturize(Scale: number, BaseTexture: number)`

Draws the texturize shader, which replaces each pixel on your screen with a different part of the texture depending on its brightness. See [g_texturize](https://wiki.facepunch.com/gmod/Shaders/g_texturize) for information on making the texture.

**Arguments:**
- `Scale` (number) — Scale of the texture.
- `BaseTexture` (number) — This will be the texture to use in the effect.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawTexturize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/texturize.lua#L8-L19)

---

### DrawToyTown · Client
`DrawToyTown(Passes: number, Height: number)`

Draws the toy town shader, which blurs the top and bottom of your screen. This can make very large objects look like toys, hence the name.

**Arguments:**
- `Passes` (number) — An integer determining how many times to draw the effect.
- `Height` (number) — The amount of screen which should be blurred on the top and bottom.

[wiki](https://wiki.facepunch.com/gmod/Global.DrawToyTown) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/toytown.lua#L12-L28)

---

### DropEntityIfHeld · Server · `DEPRECATED`
`DropEntityIfHeld(ent: Entity)`

Drops the specified entity if it is being held by any player with Gravity Gun, Physics Gun or `+use` pickup.

See also [Player:DropObject](https://wiki.facepunch.com/gmod/Player:DropObject) and [Entity:ForcePlayerDrop](https://wiki.facepunch.com/gmod/Entity:ForcePlayerDrop).

**Arguments:**
- `ent` (Entity) — The entity to drop.

[wiki](https://wiki.facepunch.com/gmod/Global.DropEntityIfHeld)

---

### DTVar_ReceiveProxyGL · Shared
`DTVar_ReceiveProxyGL(entity: Entity, Type: string, index: number, new value: any)`

Calls all NetworkVarNotify functions of the given entity with the given new value, but doesn't change the real value.  
internally uses [Entity:CallDTVarProxies](https://wiki.facepunch.com/gmod/Entity:CallDTVarProxies)

**Arguments:**
- `entity` (Entity) — The Entity to run the NetworkVarNotify functions from.
- `Type` (string) — The NetworkVar Type.
- `index` (number) — The NetworkVar index.
- `new value` (any) — The new value.

[wiki](https://wiki.facepunch.com/gmod/Global.DTVar_ReceiveProxyGL) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L181-L185)

---

### DynamicLight · Client
`DynamicLight(index: number, elight: boolean = false) → table`

Creates or replaces a dynamic light with the given id.

**Arguments:**
- `index` (number) — An unsigned Integer.
- `elight` (boolean, default `false`) — Allocates an elight instead of a dlight.

**Returns:**
- table — A DynamicLight structured table.

> **Note:** Only 32 dlights and 64 elights can be active at once.
> **Warning:** It is not safe to hold a reference to this object after creation since its data can be replaced by another dlight at any time.
> **Bug** ([#3798](https://github.com/Facepunch/garrysmod/issues/3798)): The minlight parameter affects the world and entities differently.

[wiki](https://wiki.facepunch.com/gmod/Global.DynamicLight)

---

### DynamicMaterial · Menu
`DynamicMaterial(materialPath: string, flags: string = nil) → IMaterial`

Creates a dynamic Material from the given materialPath

**Arguments:**
- `materialPath` (string) — The material with path.
- `flags` (string, default `nil`) — Flags, same as Material.

**Returns:**
- IMaterial — Generated material.

> **Warning:** This function should never be used in a Rendering Hook because it creates a new dynamic material every time and can fill up your vram.

[wiki](https://wiki.facepunch.com/gmod/Global.DynamicMaterial)

---

### EffectData · Shared
`EffectData() → CEffectData`

Returns a [CEffectData](https://wiki.facepunch.com/gmod/CEffectData) object to be used with [util.Effect](https://wiki.facepunch.com/gmod/util.Effect).

**Returns:**
- CEffectData — The CEffectData object.

> **Bug** ([#2771](https://github.com/Facepunch/garrysmod/issues/2771)): This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once.
> 
> As a result any values previously set (Origin, Magnitude, Scale etc) will carry over to all future calls of this function, and may unexpectedly affect effects created via [util.Effect](https://wiki.facepunch.com/gmod/util.Effect).

[wiki](https://wiki.facepunch.com/gmod/Global.EffectData)

---

### Either · Shared, Menu
`Either(condition: any, truevar: any, falsevar: any) → any`

An [eagerly evaluated](https://en.wikipedia.org/wiki/Eager_evaluation) [ternary operator](https://en.wikipedia.org/wiki/%3F:), or, in layman's terms, a compact "if then else" statement.

In most cases, you should just use Lua's ["pseudo" ternary operator](https://en.wikipedia.org/wiki/%3F:#Lua), like this:

```lua
local myCondition = true
local consequent = "myCondition is true"
local alternative = "myCondition is false"

print(myCondition and consequent or alternative)
```

In the above example, due to [short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation), `consequent` would be "skipped" and ignored (not evaluated) by Lua due to `myCondition` being `true`, and only `alternative` would be evaluated. However, when using `Either`, both `consequent` and `alternative` would be evaluated. A practical example of this can be found at the bottom of the page.

# Falsey values

If `consequent` is "falsey" (Lua considers both `false` and `nil` as false), this will not work. For example:

```lua
local X = true
local Y = false
local Z = "myCondition is false"

print(X and Y or Z)
```

This will actually print the value of `Z`.

In the above case, and other very rare cases, you may find `Either` useful.

**Arguments:**
- `condition` (any) — The condition to check if true or false.
- `truevar` (any) — If the condition isn't nil/false, returns this value.
- `falsevar` (any) — If the condition is nil/false, returns this value.

**Returns:**
- any — The result.

[wiki](https://wiki.facepunch.com/gmod/Global.Either) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L362-L365)

---

### EmitSentence · Shared
`EmitSentence(soundName: string, position: Vector, entity: number, channel: number = CHAN_AUTO, volume: number = 1, soundLevel: number = 75, soundFlags: number = 0, pitch: number = 100, DSP: number = 0)`

Plays a sentence from `scripts/sentences.txt`

**Arguments:**
- `soundName` (string) — The sound to play
- `position` (Vector) — The position to play at
- `entity` (number) — The entity to emit the sound from.
- `channel` (number, default `CHAN_AUTO`, enum [CHAN](https://wiki.facepunch.com/gmod/Enums/CHAN)) — The sound channel, see CHAN.
- `volume` (number, default `1`) — The volume of the sound, from 0 to 1
- `soundLevel` (number, default `75`, enum [SNDLVL](https://wiki.facepunch.com/gmod/Enums/SNDLVL)) — The sound level of the sound, see SNDLVL
- `soundFlags` (number, default `0`, enum [SND](https://wiki.facepunch.com/gmod/Enums/SND)) — The flags of the sound, see SND
- `pitch` (number, default `100`) — The pitch of the sound, 0-255
- `DSP` (number, default `0`) — Digital Sound Processor for this sound.

[wiki](https://wiki.facepunch.com/gmod/Global.EmitSentence)

---

### EmitSound · Shared
`EmitSound(soundName: string, position: Vector, entity: number = 0, channel: number{CHAN} = CHAN_AUTO, volume: number = 1, soundLevel: number{SNDLVL} = 75, soundFlags: number{SND} = 0, pitch: number = 100, dsp: number = 1, filter: CRecipientFilter = nil)`

Emits the specified sound at the specified position. See also [Entity:EmitSound](https://wiki.facepunch.com/gmod/Entity:EmitSound) if you wish to play sounds on a specific entity.

**Arguments:**
- `soundName` (string) — The sound to play This should either be a sound script name (sound.Add) or a file path relative to the `sound/` folder.
- `position` (Vector) — The position where the sound is meant to play, which is also used for a network filter (`CPASAttenuationFilter`) to decide which players will hear the sound.
- `entity` (number, default `0`) — The entity to emit the sound from.
- `channel` (number{CHAN}, default `CHAN_AUTO`) — The sound channel, see CHAN.
- `volume` (number, default `1`) — The volume of the sound, from 0 to 1
- `soundLevel` (number{SNDLVL}, default `75`) — The sound level of the sound, see SNDLVL
- `soundFlags` (number{SND}, default `0`) — The flags of the sound, see SND
- `pitch` (number, default `100`) — The pitch of the sound, 0-255
- `dsp` (number, default `1`) — The DSP preset for this sound.
- `filter` (CRecipientFilter, default `nil`) — If set serverside, the sound will only be networked to the clients in the filter.

> **Note:** Valid 16 bit sample rates: **11025 Hz, 22050 Hz and 44100 Hz**, otherwise you may see this kind of message:
> 
> `Unsupported 32-bit wave file your_sound.wav` and 
> `Invalid sample rate (48000) for sound 'your_sound.wav'`

[wiki](https://wiki.facepunch.com/gmod/Global.EmitSound)

---

### EndTooltip · Client, Menu
`EndTooltip(panel: Panel)`

Removes the currently active tool tip from the screen.

**Arguments:**
- `panel` (Panel) — This is the panel that has a tool tip.

[wiki](https://wiki.facepunch.com/gmod/Global.EndTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/tooltips.lua#L70-L80)

---

### Entity · Shared
`Entity(entityIndex: number) → Entity`

Returns the entity with the matching [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex).

Indices `1` through [game.MaxPlayers](https://wiki.facepunch.com/gmod/game.MaxPlayers)() are always reserved for players.

**Arguments:**
- `entityIndex` (number) — The entity index.

**Returns:**
- Entity — The entity if it exists, or `NULL` if it doesn't.

> **Note:** In examples on this wiki, `Entity( 1 )` is used when a player entity is needed (see ). In singleplayer and listen servers, `Entity( 1 )` will always be the first player. In dedicated servers, however, `Entity( 1 )` won't always be a valid player if there is no one currently on the server.

[wiki](https://wiki.facepunch.com/gmod/Global.Entity)

---

### error · Shared, Menu
`error(message: string, errorLevel: number = 1)`

Throws a Lua error and breaks out of the current call stack.

**Arguments:**
- `message` (string) — The error message to throw.
- `errorLevel` (number, default `1`) — The level to throw the error at.

[wiki](https://wiki.facepunch.com/gmod/Global.error(lowercase))

---

### ErrorNoHalt · Shared, Menu
`ErrorNoHalt(arguments: vararg)`

Throws a Lua error but does not break out of the current call stack.
This function will not print a stack trace like a normal error would.
Essentially similar if not equivalent to [Msg](https://wiki.facepunch.com/gmod/Global.Msg).

**Arguments:**
- `arguments` (vararg) — Converts all arguments to strings and prints them with no spacing.

[wiki](https://wiki.facepunch.com/gmod/Global.ErrorNoHalt)

---

### ErrorNoHaltWithStack · Shared, Menu
`ErrorNoHaltWithStack(arguments: vararg)`

Throws a Lua error but does not break out of the current call stack.

This function will print a stack trace like a normal error would.

**Arguments:**
- `arguments` (vararg) — Converts all arguments to strings and prints them with no spacing.

[wiki](https://wiki.facepunch.com/gmod/Global.ErrorNoHaltWithStack)

---

### EyeAngles · Client
`EyeAngles() → Angle`

Returns the angles of the current render context as calculated by [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView).

**Returns:**
- Angle — The angle of the currently rendered scene.

> **Bug** ([#2516](https://github.com/Facepunch/garrysmod/issues/2516)): This function is only reliable inside rendering hooks.

[wiki](https://wiki.facepunch.com/gmod/Global.EyeAngles)

---

### EyePos · Client
`EyePos() → Vector`

Returns the origin of the current render context as calculated by [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView).

**Returns:**
- Vector — Camera position.

> **Bug** ([#2516](https://github.com/Facepunch/garrysmod/issues/2516)): This function is only reliable inside rendering hooks.

[wiki](https://wiki.facepunch.com/gmod/Global.EyePos)

---

### EyeVector · Client
`EyeVector() → Vector`

Returns the normal vector of the current render context as calculated by [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView), similar to [EyeAngles](https://wiki.facepunch.com/gmod/Global.EyeAngles).

**Returns:**
- Vector — View direction of the currently rendered scene.

> **Bug** ([#2516](https://github.com/Facepunch/garrysmod/issues/2516)): This function is only reliable inside rendering hooks.

[wiki](https://wiki.facepunch.com/gmod/Global.EyeVector)

---

### FindMetaTable · Shared, Menu
`FindMetaTable(metaName: string) → table|nil`

Returns the meta table for the class with the matching name.

You can learn more about meta tables on the [Meta Tables](https://wiki.facepunch.com/gmod/Meta%20Tables) page.

You can find a list of meta tables that can be retrieved with this function on [TYPE](https://wiki.facepunch.com/gmod/Enums/TYPE). The name in the description is the string to use with this function.

Custom meta tables should be registered via [RegisterMetaTable](https://wiki.facepunch.com/gmod/Global.RegisterMetaTable).

**Arguments:**
- `metaName` (string) — The object type to retrieve the meta table of.

**Returns:**
- table|nil — The corresponding meta table or `nil` if it doesn't exist.

[wiki](https://wiki.facepunch.com/gmod/Global.FindMetaTable)

---

### FindTooltip · Client, Menu
`FindTooltip(panel: Panel) → string, Panel, Panel`

Returns the tool-tip text and tool-tip-panel (if any) of the given panel as well as itself

**Arguments:**
- `panel` (Panel) — Panel to find tool-tip of

**Returns:**
- string — tool-tip text
- Panel — tool-tip panel
- Panel — panel that the function was called with

[wiki](https://wiki.facepunch.com/gmod/Global.FindTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/tooltips.lua#L23-L36)

---

### FireAddonConflicts · Menu
`FireAddonConflicts()`

Refreshes all Addon Conflicts and Fires a Problem. Internally uses [FireProblem](https://wiki.facepunch.com/gmod/Global.FireProblem)

[wiki](https://wiki.facepunch.com/gmod/Global.FireAddonConflicts) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L321-L342)

---

### FireProblem · Menu
`FireProblem(problem: table{Problem})`

Creates a problem from the given definition.

**Arguments:**
- `problem` (table{Problem}) — The problem's definition.

> **Note:** Existing problems with the same Id will be replaced / overridden.

[wiki](https://wiki.facepunch.com/gmod/Global.FireProblem) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L100-L111)

---

### FireProblemFromEngine · Menu · `INTERNAL`
`FireProblemFromEngine(id: string, severity: number, params: string)`

This function is called from the engine to notify the player about a problem in a more user friendly way compared to a console message.

**Arguments:**
- `id` (string) — The Problem ID.
- `severity` (number) — The Problem severity.
- `params` (string) — Additional Parameters.

[wiki](https://wiki.facepunch.com/gmod/Global.FireProblemFromEngine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L188-L203)

---

### Format · Shared, Menu
`Format(format: string, formatParameters: vararg) → string`

Formats the specified values into the string given. Same as [string.format](https://wiki.facepunch.com/gmod/string.format).

**Arguments:**
- `format` (string) — The string to be formatted.
- `formatParameters` (vararg) — Values to be formatted into the string.

**Returns:**
- string — The formatted string

[wiki](https://wiki.facepunch.com/gmod/Global.Format) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L29)

---

### FrameNumber · Shared
`FrameNumber() → number`

Returns the number of frames rendered since the game was launched.

**Returns:**
- number — frame count

[wiki](https://wiki.facepunch.com/gmod/Global.FrameNumber)

---

### FrameTime · Shared, Menu
`FrameTime() → number`

Returns the [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime)-based time in seconds it took to render the last frame.

This should be used for frame/tick based timing, such as movement prediction or animations.

For real-time-based frame time that isn't affected by `host_timescale`, use [RealFrameTime](https://wiki.facepunch.com/gmod/Global.RealFrameTime). RealFrameTime is more suited for things like GUIs or HUDs.

**Returns:**
- number — time (in seconds)

[wiki](https://wiki.facepunch.com/gmod/Global.FrameTime)

---

### GameDetails · Menu
`GameDetails(servername: string, serverurl: string, mapname: string, maxplayers: number, steamid: string, gamemode: string)`

Callback function for when the client has joined a server. This function shows the server's loading URL by default.

**Arguments:**
- `servername` (string) — Server's name.
- `serverurl` (string) — Server's loading screen URL, or "" if the URL is not set.
- `mapname` (string) — Server's current map's name.
- `maxplayers` (number) — Max player count of server.
- `steamid` (string) — The local player's Player:SteamID64.
- `gamemode` (string) — Server's current gamemode's folder name.

[wiki](https://wiki.facepunch.com/gmod/Global.GameDetails) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/loading.lua#L249-L274)

---

### gcinfo · Shared, Menu · `DEPRECATED`
`gcinfo() → number`

Returns the current floored dynamic memory usage of Lua in kilobytes.

**Returns:**
- number — The current floored dynamic memory usage of Lua, in kilobytes.

[wiki](https://wiki.facepunch.com/gmod/Global.gcinfo)

---

### GenerateSpawnlistFromPath · Client · `DEPRECATED`
`GenerateSpawnlistFromPath(folder: string, path: string, name: string, icon: string = icon16/page.png, appid: number)`

This function adds all models from a specified folder to a custom Spawnlist category. Internally uses [AddPropsOfParent](https://wiki.facepunch.com/gmod/Global.AddPropsOfParent)

**Arguments:**
- `folder` (string) — the folder to search for models
- `path` (string) — The path to look for the files and directories in.
- `name` (string) — The Spawnmenu Category name
- `icon` (string, default `icon16/page.png`) — The Spawnmenu Category Icon to use
- `appid` (number) — The AppID which is needed for the Content

> **Warning:** Using this function before [SANDBOX:PopulateContent](https://wiki.facepunch.com/gmod/SANDBOX:PopulateContent) has been called will result in an error

[wiki](https://wiki.facepunch.com/gmod/Global.GenerateSpawnlistFromPath) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/creationmenu/content/contenttypes/gameprops.lua#L24-L41)

---

### GetAddonStatus · Menu
`GetAddonStatus() → boolean, boolean`

Returns if the game was started with either -noaddons or -noworkshop

**Returns:**
- `noaddons` (boolean) — true if the game was started with -noaddons.
- `noworkshop` (boolean) — true if the game was started with -noworkshop.

[wiki](https://wiki.facepunch.com/gmod/Global.GetAddonStatus)

---

### GetAPIManifest · Menu · `INTERNAL`
`GetAPIManifest(callback: function)`

Gets miscellaneous information from Facepunches API.

**Arguments:**
- `callback` (function) — Callback to be called when the API request is done.

[wiki](https://wiki.facepunch.com/gmod/Global.GetAPIManifest)

---

### GetConVar · Shared, Menu
`GetConVar(name: string) → ConVar`

Gets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) with the specified name.

**Arguments:**
- `name` (string) — Name of the ConVar to get

**Returns:**
- ConVar — The ConVar object, or nil if no such ConVar was found.

> **Note:** This function uses [GetConVar_Internal](https://wiki.facepunch.com/gmod/Global.GetConVar_Internal) internally, but caches the result in Lua for quicker lookups.

[wiki](https://wiki.facepunch.com/gmod/Global.GetConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L436-L448)

---

### GetConVar_Internal · Shared, Menu · `INTERNAL`
`GetConVar_Internal(name: string) → ConVar`

Gets the ConVar with the specified name. This function doesn't cache the convar.

**Arguments:**
- `name` (string) — Name of the ConVar to get

**Returns:**
- ConVar — The ConVar object

> **Warning:** This function is very slow and not recommended. See [GetConVar](https://wiki.facepunch.com/gmod/Global.GetConVar) for an example on how to properly store the return of what you're using so you can avoid using this function as much as possible.

[wiki](https://wiki.facepunch.com/gmod/Global.GetConVar_Internal)

---

### GetConVarNumber · Shared, Menu · `DEPRECATED`
`GetConVarNumber(name: string) → number`

Gets the numeric value ConVar with the specified name.

Returns the value of [game.MaxPlayers](https://wiki.facepunch.com/gmod/game.MaxPlayers) if `maxplayers` is specified as the convar name, even though `maxplayers` is not a convar. (it is a console **command**) You should be using aforementioned Lua function instead.

**Arguments:**
- `name` (string) — Name of the ConVar to get.

**Returns:**
- number — The ConVar's value.

[wiki](https://wiki.facepunch.com/gmod/Global.GetConVarNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L450-L454)

---

### GetConVarString · Shared, Menu · `DEPRECATED`
`GetConVarString(name: string) → string`

Gets the string value ConVar with the specified name.

Returns the value of [game.MaxPlayers](https://wiki.facepunch.com/gmod/game.MaxPlayers) if `maxplayers` is specified as the convar name, even though `maxplayers` is not a convar. (it is a console **command**) You should be using aforementioned Lua function instead.

**Arguments:**
- `name` (string) — Name of the ConVar to get.

**Returns:**
- string — The ConVar's value.

[wiki](https://wiki.facepunch.com/gmod/Global.GetConVarString) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L456-L460)

---

### GetDefaultLoadingHTML · Menu
`GetDefaultLoadingHTML() → string`

Returns the default loading screen URL (asset://garrysmod/html/loading.html)

**Returns:**
- string — Default loading url (asset://garrysmod/html/loading.html)

[wiki](https://wiki.facepunch.com/gmod/Global.GetDefaultLoadingHTML)

---

### GetDemoFileDetails · Menu
`GetDemoFileDetails(filename: string) → table`

Retrieves data about the demo with the specified filename. Similar to [GetSaveFileDetails](https://wiki.facepunch.com/gmod/Global.GetSaveFileDetails).

**Arguments:**
- `filename` (string) — The file name of the demo.

**Returns:**
- table — Demo data.

[wiki](https://wiki.facepunch.com/gmod/Global.GetDemoFileDetails)

---

### GetDownloadables · Menu
`GetDownloadables() → table<string>`

Returns a table with the names of files needed from the server you are currently joining.

**Returns:**
- table<string> — table of file names

[wiki](https://wiki.facepunch.com/gmod/Global.GetDownloadables)

---

### getfenv · Shared, Menu
`getfenv(location: function = 1) → table`

Returns the environment table of either the stack level or the function specified.

**Arguments:**
- `location` (function, default `1`) — The object to get the enviroment from.

**Returns:**
- table — The environment.

[wiki](https://wiki.facepunch.com/gmod/Global.getfenv)

---

### GetGlobal2Angle · Shared
`GetGlobal2Angle(index: string, default: Angle = Angle( 0, 0, 0 )) → Angle`

Returns an angle that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (Angle, default `Angle( 0, 0, 0 )`) — The value to return if the global value is not set.

**Returns:**
- Angle — The global value, or default if the global is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Angle)

---

### GetGlobal2Bool · Shared
`GetGlobal2Bool(index: string, default: boolean = false) → boolean`

Returns a boolean that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (boolean, default `false`) — The value to return if the global value is not set.

**Returns:**
- boolean — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Bool)

---

### GetGlobal2Entity · Shared
`GetGlobal2Entity(index: string, default: Entity = NULL) → Entity`

Returns an entity that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (Entity, default `NULL`) — The value to return if the global value is not set.

**Returns:**
- Entity — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Entity)

---

### GetGlobal2Float · Shared
`GetGlobal2Float(index: string, default: number = 0) → number`

Returns a float that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (number, default `0`) — The value to return if the global value is not set.

**Returns:**
- number — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Float)

---

### GetGlobal2Int · Shared
`GetGlobal2Int(index: string, default: number = 0) → number`

Returns an integer that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (number, default `0`) — The value to return if the global value is not set.

**Returns:**
- number — The global value, or the default if the global value is not set.

> **Warning:** The integer has a 32 bit limit. Use [GetGlobalInt](https://wiki.facepunch.com/gmod/Global.GetGlobalInt) for a higher limit

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Int)

---

### GetGlobal2String · Shared
`GetGlobal2String(index: string, default: string) → string`

Returns a string that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (string) — The value to return if the global value is not set.

**Returns:**
- string — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2String)

---

### GetGlobal2Var · Shared
`GetGlobal2Var(index: string, default: any = nil) → any`

Returns a value that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (any, default `nil`) — The value to return if the global value is not set.

**Returns:**
- any — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Var)

---

### GetGlobal2Vector · Shared
`GetGlobal2Vector(Index: string, Default: Vector) → Vector`

Returns a vector that is shared between the server and all clients.

**Arguments:**
- `Index` (string) — The unique index to identify the global value with.
- `Default` (Vector) — The value to return if the global value is not set.

**Returns:**
- Vector — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobal2Vector)

---

### GetGlobalAngle · Shared
`GetGlobalAngle(index: string, default: Angle) → Angle`

Returns an angle that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (Angle) — The value to return if the global value is not set.

**Returns:**
- Angle — The global value, or default if the global is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalAngle)

---

### GetGlobalBool · Shared
`GetGlobalBool(index: string, default: boolean = false) → boolean`

Returns a boolean that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (boolean, default `false`) — The value to return if the global value is not set.

**Returns:**
- boolean — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalBool)

---

### GetGlobalEntity · Shared
`GetGlobalEntity(index: string, default: Entity = NULL) → Entity`

Returns an entity that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (Entity, default `NULL`) — The value to return if the global value is not set.

**Returns:**
- Entity — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalEntity)

---

### GetGlobalFloat · Shared
`GetGlobalFloat(index: string, default: number = 0) → number`

Returns a float that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (number, default `0`) — The value to return if the global value is not set.

**Returns:**
- number — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalFloat)

---

### GetGlobalInt · Shared
`GetGlobalInt(index: string, default: number = 0) → number`

Returns an integer that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (number, default `0`) — The value to return if the global value is not set.

**Returns:**
- number — The global value, or the default if the global value is not set.

> **Bug** ([#3374](https://github.com/Facepunch/garrysmod/issues/3374)): This function will not round decimal values as it actually networks a float internally.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalInt)

---

### GetGlobalString · Shared
`GetGlobalString(index: string, default: string) → string`

Returns a string that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (string) — The value to return if the global value is not set.

**Returns:**
- string — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalString)

---

### GetGlobalVar · Shared
`GetGlobalVar(index: string, default: any = nil) → any`

Returns a value that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `default` (any, default `nil`) — The value to return if the global value is not set.

**Returns:**
- any — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalVar)

---

### GetGlobalVector · Shared
`GetGlobalVector(Index: string, Default: Vector) → Vector`

Returns a vector that is shared between the server and all clients.

**Arguments:**
- `Index` (string) — The unique index to identify the global value with.
- `Default` (Vector) — The value to return if the global value is not set.

**Returns:**
- Vector — The global value, or the default if the global value is not set.

[wiki](https://wiki.facepunch.com/gmod/Global.GetGlobalVector)

---

### GetHostName · Shared
`GetHostName() → string`

Returns the name of the current server.

**Returns:**
- string — The name of the server.

> **Note:** GetHostName returns information from [ConVar](https://wiki.facepunch.com/gmod/ConVars_In_Garrysmod#cvarlistdump) hostname

[wiki](https://wiki.facepunch.com/gmod/Global.GetHostName)

---

### GetHUDPanel · Client
`GetHUDPanel() → Panel`

Returns the panel that is used as a wrapper for the HUD. If you want your panel to be hidden when the main menu is opened, parent it to this. Child panels will also have their controls disabled.

See also [vgui.GetWorldPanel](https://wiki.facepunch.com/gmod/vgui.GetWorldPanel)

**Returns:**
- Panel — The HUD panel

[wiki](https://wiki.facepunch.com/gmod/Global.GetHUDPanel)

---

### GetLoadPanel · Menu
`GetLoadPanel() → Panel`

Returns the loading screen panel and creates it if it doesn't exist.

**Returns:**
- Panel — The loading screen panel

[wiki](https://wiki.facepunch.com/gmod/Global.GetLoadPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/loading.lua#L228-L236)

---

### GetLoadStatus · Menu
`GetLoadStatus() → string`

Returns the current status of the server join progress.

**Returns:**
- string — The current status

[wiki](https://wiki.facepunch.com/gmod/Global.GetLoadStatus)

---

### GetMapList · Menu
`GetMapList() → table`

Returns a table with the names of all maps and categories that you have on your client.

**Returns:**
- table — Table of map names and categories.

[wiki](https://wiki.facepunch.com/gmod/Global.GetMapList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L419-L421)

---

### getmetatable · Shared, Menu
`getmetatable(object: any) → any`

Returns the metatable of an object. This function obeys the metatable's __metatable field, and will return that field if the metatable has it set.

Use [debug.getmetatable](https://wiki.facepunch.com/gmod/debug.getmetatable) if you want the true metatable of the object.

If you want to modify the metatable, check out [FindMetaTable](https://wiki.facepunch.com/gmod/Global.FindMetaTable)

**Arguments:**
- `object` (any) — The value to return the metatable of.

**Returns:**
- any — The metatable of the value.

[wiki](https://wiki.facepunch.com/gmod/Global.getmetatable)

---

### GetOverlayPanel · Menu
`GetOverlayPanel() → Panel`

Returns the menu overlay panel, a container for panels like the error panel created in [GM:OnLuaError](https://wiki.facepunch.com/gmod/GM:OnLuaError).

**Returns:**
- Panel — The overlay panel

[wiki](https://wiki.facepunch.com/gmod/Global.GetOverlayPanel)

---

### GetPlayerList · Menu · `INTERNAL`
`GetPlayerList(serverip: string)`

Updates the PlayerList for the Currently Viewed Server. Internally uses [serverlist.PlayerList](https://wiki.facepunch.com/gmod/serverlist.PlayerList) to retrieve the PlayerList.

**Arguments:**
- `serverip` (string) — The ServerIP to retrieve the PlayerList from.

[wiki](https://wiki.facepunch.com/gmod/Global.GetPlayerList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L257-L266)

---

### GetPredictionPlayer · Shared
`GetPredictionPlayer() → Player`

Returns the player whose movement commands are currently being processed. The player this returns can safely have [Player:GetCurrentCommand](https://wiki.facepunch.com/gmod/Player:GetCurrentCommand)() called on them. See [Prediction](https://wiki.facepunch.com/gmod/Prediction).

**Returns:**
- Player — The player currently being predicted, or NULL if no command processing is currently being done.

[wiki](https://wiki.facepunch.com/gmod/Global.GetPredictionPlayer)

---

### GetRenderTarget · Client
`GetRenderTarget(name: string, width: number, height: number) → ITexture`

Creates or gets the rendertarget with the given name.

See [GetRenderTargetEx](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx) for an advanced version of this function with more options.

**Arguments:**
- `name` (string) — The internal name of the render target.
- `width` (number) — The width of the render target, must be power of 2.
- `height` (number) — The height of the render target, must be power of 2.

**Returns:**
- ITexture — The render target

> **Note:** Calling this function is equivalent to
> ```lua
> GetRenderTargetEx(name,
> 	width, height,
> 	RT_SIZE_NO_CHANGE,
> 	MATERIAL_RT_DEPTH_SEPARATE,
> 	bit.bor(2, 256),
> 	0,
> 	IMAGE_FORMAT_BGRA8888
> )
> ```
> **Warning:** Drawing rendertargets on themself can produce odd and unexpected results.
> **Warning:** Rendertargets are not garbage-collected, which means they will remain in memory until you disconnect. So make sure to avoid creating new ones unecessarily and re-use as many of your existing rendertargets as possible to avoid filling up all your memory.
> **Bug** ([#2885](https://github.com/Facepunch/garrysmod/issues/2885)): This crashes when used on a cubemap texture.

[wiki](https://wiki.facepunch.com/gmod/Global.GetRenderTarget)

---

### GetRenderTargetEx · Client
`GetRenderTargetEx(name: string, width: number, height: number, sizeMode: number{RT_SIZE}, depthMode: number{MATERIAL_RT_DEPTH}, textureFlags: number{TEXTUREFLAGS}, rtFlags: number{CREATERENDERTARGETFLAGS}, imageFormat: number) → ITexture`

Gets (or creates if it does not exist) the rendertarget with the given name, this function allows to adjust the creation of a rendertarget more than [GetRenderTarget](https://wiki.facepunch.com/gmod/Global.GetRenderTarget).

See also [render.PushRenderTarget](https://wiki.facepunch.com/gmod/render.PushRenderTarget) and [render.SetRenderTarget](https://wiki.facepunch.com/gmod/render.SetRenderTarget).

**Arguments:**
- `name` (string) — The internal name of the render target.
- `width` (number) — The width of the render target, must be power of 2.
- `height` (number) — The height of the render target, must be power of 2.
- `sizeMode` (number{RT_SIZE}) — Bitflag that influences the sizing of the render target, see RT_SIZE.
- `depthMode` (number{MATERIAL_RT_DEPTH}) — Bitflag that determines the depth buffer usage of the render target MATERIAL_RT_DEPTH.
- `textureFlags` (number{TEXTUREFLAGS}) — Bitflag that configures the texture, see TEXTUREFLAGS.
- `rtFlags` (number{CREATERENDERTARGETFLAGS}) — Flags that control the HDR behaviour of the render target, see CREATERENDERTARGETFLAGS.
- `imageFormat` (number, enum [IMAGE_FORMAT](https://wiki.facepunch.com/gmod/Enums/IMAGE_FORMAT)) — Image format, see IMAGE_FORMAT.

**Returns:**
- ITexture — The new render target.

[wiki](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx)

---

### GetSaveFileDetails · Menu
`GetSaveFileDetails(filename: string) → table`

Retrieves data about the save with the specified filename. Similar to [GetDemoFileDetails](https://wiki.facepunch.com/gmod/Global.GetDemoFileDetails).

**Arguments:**
- `filename` (string) — The file name of the save.

**Returns:**
- table — Save data.

[wiki](https://wiki.facepunch.com/gmod/Global.GetSaveFileDetails)

---

### GetServers · Menu · `INTERNAL`
`GetServers(category: string, id: number)`

Starts Searching for Servers in the given Category. Can be stopped with [DoStopServers](https://wiki.facepunch.com/gmod/Global.DoStopServers).  
		Internally uses [serverlist.Query](https://wiki.facepunch.com/gmod/serverlist.Query) to search for Servers.

**Arguments:**
- `category` (string) — The Category to start searching the Servers in.
- `id` (number) — Some ID.

[wiki](https://wiki.facepunch.com/gmod/Global.GetServers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L387-L445)

---

### GetTimeoutInfo · Client
`GetTimeoutInfo() → boolean, number`

Returns if the client is timing out, and time since last ping from the server. Similar to the server side [Player:IsTimingOut](https://wiki.facepunch.com/gmod/Player:IsTimingOut).

**Returns:**
- boolean — Is timing out?
- number — Get time since last pinged received.

[wiki](https://wiki.facepunch.com/gmod/Global.GetTimeoutInfo)

---

### GetViewEntity · Client
`GetViewEntity() → Entity`

Returns the entity the client is using to see from (such as the player itself, the camera, or another entity).

**Returns:**
- Entity — The view entity.

[wiki](https://wiki.facepunch.com/gmod/Global.GetViewEntity)

---

### GMOD_OpenURLNoOverlay · Menu · `INTERNAL`
`GMOD_OpenURLNoOverlay(url: string)`

Opens the given URL in a [HTML](https://wiki.facepunch.com/gmod/HTML) panel.

**Arguments:**
- `url` (string) — The url to open.

[wiki](https://wiki.facepunch.com/gmod/Global.GMOD_OpenURLNoOverlay) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/openurl.lua#L34-L43)

---

### HexToColor · Shared, Menu
`HexToColor(hue: string) → Color`

Converts a hexadecimal representation of a color to [Color](https://wiki.facepunch.com/gmod/Color) object.

**Arguments:**
- `hue` (string) — A hex formatted color.

**Returns:**
- Color — The Color created from the hexadecimal color code.

[wiki](https://wiki.facepunch.com/gmod/Global.HexToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L119-L161)

---

### HSLToColor · Shared, Menu
`HSLToColor(hue: number, saturation: number, lightness: number) → Color`

Converts a color from [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV) into RGB color space and returns a [Color](https://wiki.facepunch.com/gmod/Color).

**Arguments:**
- `hue` (number) — The hue in degrees from 0-360.
- `saturation` (number) — The saturation from 0-1.
- `lightness` (number) — The lightness from 0-1.

**Returns:**
- Color — The Color created from the HSL color space.

[wiki](https://wiki.facepunch.com/gmod/Global.HSLToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L76-L105)

---

### HSVToColor · Shared, Menu
`HSVToColor(hue: number, saturation: number, value: number) → Color`

Converts a color from [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV) into RGB color space and returns a [Color](https://wiki.facepunch.com/gmod/Color).

**Arguments:**
- `hue` (number) — The hue in degrees from 0-360.
- `saturation` (number) — The saturation from 0-1.
- `value` (number) — The value from 0-1.

**Returns:**
- Color — The Color created from the HSV color space.

[wiki](https://wiki.facepunch.com/gmod/Global.HSVToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L45-L74)

---

### HTTP · Shared, Menu
`HTTP(parameters: table{HTTPRequest}) → boolean`

Launches an asynchronous http request with the given parameters.

**Arguments:**
- `parameters` (table{HTTPRequest}) — The request parameters.

**Returns:**
- boolean — `true` if a request is queued, `false` if a request could not be queued.

> **Note:** HTTP-requests that respond with a large body may return an `unsuccessful` error. Try using the [Range](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Range) header to download the file in chunks.
> **Note:** HTTP-requests to destinations on private networks (such as `192.168.0.1`, or `127.0.0.1`) won't work.
> 	
> 	To enable HTTP-requests to destinations on private networks use [Command Line Parameters](https://wiki.facepunch.com/gmod/Command%20Line%20Parameters) `-allowlocalhttp`. (Dedicated servers only)
> **Bug** ([#2232](https://github.com/Facepunch/garrysmod/issues/2232)): This cannot send or receive multiple headers with the same name.

[wiki](https://wiki.facepunch.com/gmod/Global.HTTP)

---

### HWBToColor · Shared, Menu
`HWBToColor(hue: number, whiteness: number, blackness: number) → Color`

Converts a color from [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model) (Hue-Whiteness-Blackness) into RGB color space and returns a [Color](https://wiki.facepunch.com/gmod/Color).

**Arguments:**
- `hue` (number) — The hue of the color in degrees from 0-360.
- `whiteness` (number) — The whiteness of the color from 0-1.
- `blackness` (number) — The blackness of the color from 0-1.

**Returns:**
- Color — The Color created from the HWB color space.

[wiki](https://wiki.facepunch.com/gmod/Global.HWBToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L107-L117)

---

### include · Shared, Menu
`include(fileName: string) → vararg`

Executes a Lua script.

This function will try to load local client file if `sv_allowcslua` is **1**.

**Arguments:**
- `fileName` (string) — The name of the script to be executed.

**Returns:**
- vararg — Anything that the executed Lua script returns.

> **Warning:** The file you are attempting to include **MUST NOT** be empty or the include will fail. Files over a certain size (64KB compressed) may fail clientside as well.
> 
> If the file you are including is clientside or shared, it **must** be [AddCSLuaFile](https://wiki.facepunch.com/gmod/Global.AddCSLuaFile)'d or this function will error saying the file doesn't exist.

[wiki](https://wiki.facepunch.com/gmod/Global.include)

---

### IncludeCS · Shared, Menu · `DEPRECATED`
`IncludeCS(filename: string) → vararg`

This function works exactly the same as [include](https://wiki.facepunch.com/gmod/Global.include) both clientside and serverside.

The only difference is that on the serverside it also calls [AddCSLuaFile](https://wiki.facepunch.com/gmod/Global.AddCSLuaFile) on the filename, so that it gets sent to the client.

**Arguments:**
- `filename` (string) — The filename of the Lua file you want to include.

**Returns:**
- vararg — Anything that the executed Lua script returns.

[wiki](https://wiki.facepunch.com/gmod/Global.IncludeCS) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L161-L167)

---

### InvalidateInternalEntityCache · Shared · `INTERNAL`
`InvalidateInternalEntityCache(isPly: boolean)`

Called by the engine before [GM:OnEntityCreated](https://wiki.facepunch.com/gmod/GM:OnEntityCreated) and after [GM:EntityRemoved](https://wiki.facepunch.com/gmod/GM:EntityRemoved) hooks are called.
Internally used to clear the [player.Iterator](https://wiki.facepunch.com/gmod/player.Iterator) or [ents.Iterator](https://wiki.facepunch.com/gmod/ents.Iterator) cache

**Arguments:**
- `isPly` (boolean) — Reset the player.Iterator cache

[wiki](https://wiki.facepunch.com/gmod/InvalidateInternalEntityCache) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity_iter.lua#L22-L28)

---

### ipairs · Shared, Menu
`ipairs(tab: table) → function, table, number`

Returns a [Stateless Iterator](https://www.lua.org/pil/7.3.html) for a [Generic For Loops](https://www.lua.org/pil/4.3.5.html), to return ordered key-value pairs from a table.

This will only iterate through **numerical** keys, and these must also be **sequential**; starting at 1 with no gaps.

For unordered pairs, see [pairs](https://wiki.facepunch.com/gmod/Global.pairs).

For pairs sorted by key in alphabetical order, see [SortedPairs](https://wiki.facepunch.com/gmod/Global.SortedPairs).

**Arguments:**
- `tab` (table) — The table to iterate over.

**Returns:**
- function — The iterator function.
- table — The table being iterated over.
- number — The origin index =0.

[wiki](https://wiki.facepunch.com/gmod/Global.ipairs)

---

### isangle · Shared, Menu
`isangle(variable: any) → boolean`

Returns if the passed object is an [Angle](https://wiki.facepunch.com/gmod/Angle).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is an Angle.

[wiki](https://wiki.facepunch.com/gmod/Global.isangle)

---

### isbool · Shared, Menu
`isbool(variable: any) → boolean`

Returns if the passed object is a [boolean](https://wiki.facepunch.com/gmod/boolean).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a boolean.

[wiki](https://wiki.facepunch.com/gmod/Global.isbool)

---

### IsColor · Shared, Menu
`IsColor(Object: any) → boolean`

Returns whether the given object does or doesn't have a `metatable` of a color.

**Arguments:**
- `Object` (any) — The object to be tested

**Returns:**
- boolean — Whether the given object is a color or not

[wiki](https://wiki.facepunch.com/gmod/Global.IsColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L33-L37)

---

### IsConCommandBlocked · Shared, Menu · `INTERNAL`
`IsConCommandBlocked(name: string) → boolean`

Determines whether or not the provided console command will be blocked if it's ran through Lua functions, such as [RunConsoleCommand](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand) or [Player:ConCommand](https://wiki.facepunch.com/gmod/Player:ConCommand).

		For more info on blocked console commands, check out [Blocked ConCommands](https://wiki.facepunch.com/gmod/Blocked_ConCommands).

**Arguments:**
- `name` (string) — The console command to test.

**Returns:**
- boolean — Whether the command will be blocked.

[wiki](https://wiki.facepunch.com/gmod/Global.IsConCommandBlocked)

---

### IsEnemyEntityName · Shared, Menu
`IsEnemyEntityName(className: string) → boolean`

Returns if the given NPC class name is an enemy. Returns `true` if the entity name is one of the following:
* `monster_alien_grunt`
* `monster_nihilanth`
* `monster_tentacle`
* `monster_alien_slave`
* `monster_bigmomma`
* `monster_bullchicken`
* `monster_gargantua`
* `monster_human_assassin`
* `monster_babycrab`
* `monster_human_grunt`
* `monster_cockroach`
* `monster_houndeye`
* `monster_zombie`
* `monster_headcrab`
* `monster_alien_controller`
* `monster_turret`
* `monster_miniturret`
* `monster_sentry`
* `npc_antlion`
* `npc_antlionguard`
* `npc_antlionguardian`
* `npc_barnacle`
* `npc_breen`
* `npc_clawscanner`
* `npc_combine_s`
* `npc_cscanner`
* `npc_fastzombie`
* `npc_fastzombie_torso`
* `npc_headcrab`
* `npc_headcrab_fast`
* `npc_headcrab_poison`
* `npc_hunter`
* `npc_metropolice`
* `npc_manhack`
* `npc_poisonzombie`
* `npc_strider`
* `npc_stalker`
* `npc_zombie`
* `npc_zombie_torso`
* `npc_zombine`
* `npc_combine_camera`
* `npc_turret_ceiling`
* `npc_combinedropship`
* `npc_combinegunship`
* `npc_helicopter`
* `npc_turret_floor`
* `npc_antlion_worker`
* `npc_headcrab_black`

**Arguments:**
- `className` (string) — Class name of the entity to check.

**Returns:**
- boolean — Is an enemy?

[wiki](https://wiki.facepunch.com/gmod/Global.IsEnemyEntityName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L320-L322)

---

### IsEntity · Shared, Menu · `DEPRECATED`
`IsEntity()`

Identical to [Global.isentity](https://wiki.facepunch.com/gmod/Global.isentity).

[wiki](https://wiki.facepunch.com/gmod/Global.IsEntity(legacy))

---

### IsFirstTimePredicted · Shared
`IsFirstTimePredicted() → boolean`

Returns if this is the first time this hook was predicted.

This is useful for one-time logic in your SWEPs PrimaryAttack, SecondaryAttack and Reload and other  (to prevent those hooks from being called rapidly in succession). It's also useful in a Move hook for when the client predicts movement.

Visit [Prediction](https://wiki.facepunch.com/gmod/Prediction) for more information about this behavior.

**Returns:**
- boolean — Whether or not this is the first time being predicted.

> **Note:** This is already used internally for [Entity:EmitSound](https://wiki.facepunch.com/gmod/Entity:EmitSound), [Weapon:SendWeaponAnim](https://wiki.facepunch.com/gmod/Weapon:SendWeaponAnim) and [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets), but NOT in  [util.Effect](https://wiki.facepunch.com/gmod/util.Effect).

[wiki](https://wiki.facepunch.com/gmod/Global.IsFirstTimePredicted)

---

### IsFriendEntityName · Shared, Menu
`IsFriendEntityName(className: string) → boolean`

Returns if the given NPC class name is a friend. Returns `true` if the entity name is one of the following:
* `monster_scientist`
* `monster_barney`
* `npc_alyx`
* `npc_barney`
* `npc_citizen`
* `npc_dog`
* `npc_eli`
* `npc_fisherman`
* `npc_gman`
* `npc_kleiner`
* `npc_magnusson`
* `npc_monk`
* `npc_mossman`
* `npc_odessa`
* `npc_vortigaunt`

**Arguments:**
- `className` (string) — Class name of the entity to check

**Returns:**
- boolean — Is a friend

[wiki](https://wiki.facepunch.com/gmod/Global.IsFriendEntityName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L333-L335)

---

### isfunction · Shared, Menu
`isfunction(variable: any) → boolean`

Returns if the passed object is a [function](https://wiki.facepunch.com/gmod/function).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a function.

[wiki](https://wiki.facepunch.com/gmod/Global.isfunction)

---

### IsInGame · Menu
`IsInGame() → boolean`

Returns true if the client is currently playing either a singleplayer or multiplayer game.

**Returns:**
- boolean — True if we are in a game.

[wiki](https://wiki.facepunch.com/gmod/Global.IsInGame)

---

### IsInLoading · Menu
`IsInLoading() → boolean`

Returns true when the loading panel is active.

**Returns:**
- boolean — True if loading panel is active.

[wiki](https://wiki.facepunch.com/gmod/Global.IsInLoading) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/loading.lua#L239-L247)

---

### ismatrix · Shared, Menu
`ismatrix(variable: any) → boolean`

Returns whether the passed object is a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a VMatrix.

[wiki](https://wiki.facepunch.com/gmod/Global.ismatrix)

---

### IsMounted · Shared, Menu
`IsMounted(game: string) → boolean`

Checks whether or not a game is currently mounted. Uses data given by [engine.GetGames](https://wiki.facepunch.com/gmod/engine.GetGames).

**Arguments:**
- `game` (string) — The game string/app ID to check.

**Returns:**
- boolean — True if the game is mounted.

[wiki](https://wiki.facepunch.com/gmod/Global.IsMounted) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L342-L357)

---

### isnumber · Shared, Menu
`isnumber(variable: any) → boolean`

Returns if the passed object is a [number](https://wiki.facepunch.com/gmod/number).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a number.

[wiki](https://wiki.facepunch.com/gmod/Global.isnumber)

---

### ispanel · Shared, Menu
`ispanel(variable: any) → boolean`

Returns if the passed object is a [Panel](https://wiki.facepunch.com/gmod/Panel).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a Panel.

[wiki](https://wiki.facepunch.com/gmod/Global.ispanel)

---

### IsServerBlacklisted · Menu
`IsServerBlacklisted(address: string, hostname: string, description: string, gm: string, map: string) → string`

Checks if the given server data is blacklisted or not.

**Arguments:**
- `address` (string) — Server ip.
- `hostname` (string) — Server name
- `description` (string) — description to check
- `gm` (string) — Gamemode name
- `map` (string) — Map name

**Returns:**
- `result` (string) — Returns the reason why the server is blacklisted or nil if the server is not blacklisted.

[wiki](https://wiki.facepunch.com/gmod/Global.IsServerBlacklisted) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L313-L362)

---

### isstring · Shared, Menu
`isstring(variable: any) → boolean`

Returns if the passed object is a [string](https://wiki.facepunch.com/gmod/string).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a string.

[wiki](https://wiki.facepunch.com/gmod/Global.isstring)

---

### istable · Shared, Menu
`istable(variable: any) → boolean`

Returns if the passed object is a [table](https://wiki.facepunch.com/gmod/table).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a table.

> **Note:** Will return `true` if the argument has a metatable. It will return `true` for variables of type [Color](https://wiki.facepunch.com/gmod/Color) as well.

[wiki](https://wiki.facepunch.com/gmod/Global.istable)

---

### IsTableOfEntitiesValid · Shared, Menu
`IsTableOfEntitiesValid(table: table) → boolean`

Returns whether or not every element within a table is a valid entity

**Arguments:**
- `table` (table) — Table containing entities to check

**Returns:**
- boolean — All entities valid

[wiki](https://wiki.facepunch.com/gmod/Global.IsTableOfEntitiesValid) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L36-L46)

---

### IsUselessModel · Shared, Menu
`IsUselessModel(modelName: string) → boolean`

Returns whether or not a model is useless by checking that the file path is that of a proper model.

If the string ".mdl" is not found in the model name, the function will return true.

The function will also return true if any of the following strings are found in the given model name:
* "_gesture"
* "_anim"
* "_gst"
* "_pst"
* "_shd"
* "_ss"
* "_posture"
* "_anm"
* "ghostanim"
* "_paths"
* "_shared"
* "anim_"
* "gestures_"
* "shared_ragdoll_"

**Arguments:**
- `modelName` (string) — The model name to be checked

**Returns:**
- boolean — Whether or not the model is useless

[wiki](https://wiki.facepunch.com/gmod/Global.IsUselessModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L264-L278)

---

### IsValid · Shared, Menu
`IsValid(toBeValidated: any) → boolean`

Returns whether an object is valid or not. (Such as [entities](https://wiki.facepunch.com/gmod/Entity), [Panel](https://wiki.facepunch.com/gmod/Panel)s, custom [table](https://wiki.facepunch.com/gmod/table) objects and more).

Checks that an object is not [nil](https://wiki.facepunch.com/gmod/nil), has an `IsValid` method and if this method returns `true`. If the object has no `IsValid` method, it will return `false`.

**Arguments:**
- `toBeValidated` (any) — The table or object to be validated.

**Returns:**
- boolean — True if the object is valid.

> **Note:** If you are sure that the object you are about to check is not `nil` and has the `IsValid` method, it would be faster to call it directly rather than using `IsValid`.
> **Note:** Due to vehicles being technically valid the moment they're spawned, also use [Vehicle:IsValidVehicle](https://wiki.facepunch.com/gmod/Vehicle:IsValidVehicle) to make sure they're fully initialized.
> **Warning:** Putting a number in the argument will cause an error.

[wiki](https://wiki.facepunch.com/gmod/Global.IsValid) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L203-L212)

---

### isvector · Shared, Menu
`isvector(variable: any) → boolean`

Returns if the passed object is a [Vector](https://wiki.facepunch.com/gmod/Vector).

**Arguments:**
- `variable` (any) — The variable to perform the type check for.

**Returns:**
- boolean — True if the variable is a Vector.

[wiki](https://wiki.facepunch.com/gmod/Global.isvector)

---

### JoinServer · Menu
`JoinServer(IP: string)`

Joins the server with the specified IP.

**Arguments:**
- `IP` (string) — The IP of the server to join

[wiki](https://wiki.facepunch.com/gmod/Global.JoinServer)

---

### JS_Language · Client, Menu
`JS_Language(htmlPanel: Panel)`

Adds JavaScript function 'language.Update' to an HTML panel as a method to call Lua's [language.GetPhrase](https://wiki.facepunch.com/gmod/language.GetPhrase) function.

**Arguments:**
- `htmlPanel` (Panel) — Panel to add JavaScript function 'language.Update' to.

[wiki](https://wiki.facepunch.com/gmod/Global.JS_Language) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/javascript_util.lua#L2-L9)

---

### JS_Utility · Client, Menu
`JS_Utility(htmlPanel: Panel)`

Adds JavaScript function 'util.MotionSensorAvailable' to an HTML panel as a method to call Lua's [motionsensor.IsAvailable](https://wiki.facepunch.com/gmod/motionsensor.IsAvailable) function.

**Arguments:**
- `htmlPanel` (Panel) — Panel to add JavaScript function 'util.MotionSensorAvailable' to.

[wiki](https://wiki.facepunch.com/gmod/Global.JS_Utility) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/javascript_util.lua#L11-L17)
