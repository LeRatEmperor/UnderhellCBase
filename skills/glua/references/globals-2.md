# Global functions & values

**Realm:** Shared, Menu  ·  **Members:** 334

Functions and values in the global namespace (called directly, e.g. `Vector(0,0,0)`, `IsValid(ent)`, `hook.Add(...)` lives in the [hook](libraries/hook.md) library). **Read the entry before using — don't guess signatures.**


> **Part 2 of 2** (`JS_Workshop` – `xpcall`). All parts: [1](globals.md), [2](globals-2.md)


### JS_Workshop · Client, Menu
`JS_Workshop(htmlPanel: Panel)`

Adds workshop related JavaScript functions to an HTML panel, used by the "Dupes" and "Saves" tabs in the spawnmenu.

**Arguments:**
- `htmlPanel` (Panel) — Panel to add JavaScript functions to.

[wiki](https://wiki.facepunch.com/gmod/Global.JS_Workshop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/javascript_util.lua#L19-L39)

---

### Label · Client, Menu
`Label(text: string, parent: Panel = nil) → Panel`

Convenience function that creates a [DLabel](https://wiki.facepunch.com/gmod/DLabel), sets the text, and returns it

**Arguments:**
- `text` (string) — The string to set the label's text to
- `parent` (Panel, default `nil`) — Optional.

**Returns:**
- Panel — The created DLabel

[wiki](https://wiki.facepunch.com/gmod/Global.Label) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L291-L298)

---

### LanguageChanged · Menu
`LanguageChanged(lang: string)`

Callback function for when the client's language changes. Called by the engine.

**Arguments:**
- `lang` (string) — The new language code.

[wiki](https://wiki.facepunch.com/gmod/Global.LanguageChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L534-L544)

---

### Lerp · Shared, Menu
`Lerp(t: number, from: number, to: number) → number`

Performs a linear interpolation from the start number to the end number.

This function provides a very efficient and easy way to smooth out movements.

See also [math.ease](https://wiki.facepunch.com/gmod/math.ease) for functions that allow to have non linear animations using linear interpolation.

**Arguments:**
- `t` (number) — The fraction for finding the result.
- `from` (number) — The starting number.
- `to` (number) — The ending number.

**Returns:**
- number — The result of the linear interpolation, `from + (to - from) * t`.

> **Note:** This function is not meant to be used with constant value in the first argument if you're dealing with animation! Use a value that changes over time. See example for **proper** usage of Lerp for animations.

[wiki](https://wiki.facepunch.com/gmod/Global.Lerp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L239-L246)

---

### LerpAngle · Shared, Menu
`LerpAngle(ratio: number, angleStart: Angle, angleEnd: Angle) → Angle`

Returns point between first and second angle using given fraction and linear interpolation

**Arguments:**
- `ratio` (number) — Ratio of progress through values
- `angleStart` (Angle) — Angle to begin from
- `angleEnd` (Angle) — Angle to end at

**Returns:**
- Angle — angle

> **Note:** This function is not meant to be used with constant value in the first argument, if you're dealing with animation! Use a value that changes over time

[wiki](https://wiki.facepunch.com/gmod/Global.LerpAngle)

---

### LerpVector · Shared, Menu
`LerpVector(fraction: number, from: Vector, to: Vector) → Vector`

Linear interpolation between two vectors. It is commonly used to smooth movement between two vectors

**Arguments:**
- `fraction` (number) — Fraction ranging from 0 to 1
- `from` (Vector) — The initial Vector
- `to` (Vector) — The desired Vector

**Returns:**
- Vector — The lerped vector.

> **Note:** This function is not meant to be used with constant value in the first argument, if you're dealing with animation! Use a value that changes over time

[wiki](https://wiki.facepunch.com/gmod/Global.LerpVector)

---

### ListAddonPresets · Menu · `INTERNAL`
`ListAddonPresets()`

Loads all Addon Presets and updates the Preset list.

[wiki](https://wiki.facepunch.com/gmod/Global.ListAddonPresets) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L621-L625)

---

### LoadAddonPresets · Menu
`LoadAddonPresets() → string`

Returns the contents of `addonpresets.txt` located in the `garrysmod/settings` folder. By default, this file stores your addon presets as JSON.

You can use [SaveAddonPresets](https://wiki.facepunch.com/gmod/Global.SaveAddonPresets) to modify this file.

**Returns:**
- `JSON` (string) — The contents of the file.

[wiki](https://wiki.facepunch.com/gmod/Global.LoadAddonPresets)

---

### LoadLastMap · Menu · `INTERNAL`
`LoadLastMap()`

This function is used to get the last map and category to which the map belongs from the cookie saved with [SaveLastMap](https://wiki.facepunch.com/gmod/Global.SaveLastMap).

[wiki](https://wiki.facepunch.com/gmod/Global.LoadLastMap) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L451-L464)

---

### LoadNewsList · Menu · `INTERNAL`
`LoadNewsList()`

Updates the News List

[wiki](https://wiki.facepunch.com/gmod/Global.LoadNewsList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L300-L307)

---

### LoadPresets · Client · `INTERNAL`
`LoadPresets() → table`

Loads all preset settings for the [presets](https://wiki.facepunch.com/gmod/presets) and returns them in a table

**Returns:**
- table — Preset data

[wiki](https://wiki.facepunch.com/gmod/Global.LoadPresets)

---

### Localize · Client, Menu · `DEPRECATED`
`Localize(localizationToken: string, default: string) → string`

Returns a localization for the given token, if none is found it will return the default (second) parameter.

**Arguments:**
- `localizationToken` (string) — The token to find a translation for.
- `default` (string) — The default value to be returned if no translation was found.

**Returns:**
- string — The localized string, 128 char limit.

[wiki](https://wiki.facepunch.com/gmod/Global.Localize)

---

### LocalPlayer · Client
`LocalPlayer() → Player`

Returns the player object of the current client.

**Returns:**
- Player — The player object representing the client.

> **Note:** LocalPlayer() will return NULL until all entities have been initialized. See [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity).

[wiki](https://wiki.facepunch.com/gmod/Global.LocalPlayer)

---

### LocalToWorld · Shared
`LocalToWorld(localPos: Vector, localAng: Angle, originPos: Vector, originAngle: Angle) → Vector, Angle`

Translates a vector and angle from a local coordinate system into a global coordinate system.

For the reverse of this function see [WorldToLocal](https://wiki.facepunch.com/gmod/Global.WorldToLocal).

For working with an entity's local space vectors/angles you might consider using [Entity:LocalToWorld](https://wiki.facepunch.com/gmod/Entity:LocalToWorld)/[Entity:LocalToWorldAngles](https://wiki.facepunch.com/gmod/Entity:LocalToWorldAngles) instead.

**Arguments:**
- `localPos` (Vector) — A vector from a local coordinate system.
- `localAng` (Angle) — An angle from a local coordinate system.
- `originPos` (Vector) — The origin of a global coordinate system, in worldspace coordinates.
- `originAngle` (Angle) — The angles of a global coordinate system, as a worldspace angle.

**Returns:**
- Vector — The corresponding worldspace vector to `localPos`.
- Angle — The corresponding worldspace angle to `localAng`.

[wiki](https://wiki.facepunch.com/gmod/Global.LocalToWorld)

---

### MainEyeAngles · Client
`MainEyeAngles() → Angle`

Returns the main view angles, as they were at the start of the latest main view render.

This is a good alternative to [EyeAngles](https://wiki.facepunch.com/gmod/Global.EyeAngles) which is affected by other rendering operations, including [render.RenderView](https://wiki.facepunch.com/gmod/render.RenderView).

**Returns:**
- Angle — The angles of the main view.

[wiki](https://wiki.facepunch.com/gmod/Global.MainEyeAngles)

---

### MainEyePos · Client
`MainEyePos() → Vector`

Returns the origin of the main view, as it was at the start of the latest main view render.

This is a good alternative to [EyePos](https://wiki.facepunch.com/gmod/Global.EyePos) which is affected by other rendering operations, including [render.RenderView](https://wiki.facepunch.com/gmod/render.RenderView).

**Returns:**
- Vector — Main camera position.

[wiki](https://wiki.facepunch.com/gmod/Global.MainEyePos)

---

### MakeBalloon · Server · `INTERNAL`
`MakeBalloon(ply: player, r: number = 255, g: number = 255, b: number = 255, force: number = 0, data: table{BalloonData}) → Entity`

This function makes a balloon appear, similar to the one from the Toolgun.

**Arguments:**
- `ply` (player) — The player who spawns the balloon.
- `r` (number, default `255`) — Balloon color (red)
- `g` (number, default `255`) — Balloon color (green)
- `b` (number, default `255`) — Balloon color (blue).
- `force` (number, default `0`) — The lift force applied to the balloon.
- `data` (table{BalloonData}) — Data applied to the balloon.

**Returns:**
- `balloon` (Entity) — Returns the created balloon entity.

> **Warning:** This function doesn't make the rope attached to the balloon appear.

[wiki](https://wiki.facepunch.com/gmod/MakeBalloon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stools/balloon.lua#L135-L174)

---

### Material · Shared, Menu
`Material(materialName: string, pngParameters: string = nil) → IMaterial, number`

Either returns the material with the given name, or loads the material interpreting the first argument as the path.

## .png, .jpg and other image formats

This function is capable to loading `.png` or `.jpg` images, generating a texture and material for them on the fly.

PNG, JPEG, GIF, and TGA files will work, but only if they have the `.png` or `.jpg` file extensions (even if the actual image format doesn't match the file extension)

Use [AddonMaterial](https://wiki.facepunch.com/gmod/Global.AddonMaterial) for image files with the `.cache` file extension. (from [steamworks.Download](https://wiki.facepunch.com/gmod/steamworks.Download))

While images are no longer scaled to Power of 2 (sizes of 8, 16, 32, 64, 128, etc.) sizes since February 2019, it is still a good practice for things like icons, etc.

**Arguments:**
- `materialName` (string) — The material name or path relative to the `materials/` folder.
- `pngParameters` (string, default `nil`) — A string containing space separated keywords which will be used to add material parameters.

**Returns:**
- IMaterial — Generated material.
- number — How long it took for the function to run.

> **Warning:** Server-side, this function can consistently return an invalid material (with '__error') depending on the file type loaded.
> **Warning:** This function is very expensive when used in rendering hooks or in operations requiring very frequent calls. It is a good idea to cache the material in a variable (like in the examples).

[wiki](https://wiki.facepunch.com/gmod/Global.Material) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L17-L31)

---

### Matrix · Shared
`Matrix(data: table = {{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}) → VMatrix`

Returns a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) object, a 4x4 matrix.

**Arguments:**
- `data` (table, default `{{1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}}`) — Initial data to initialize the matrix with.

**Returns:**
- VMatrix — New matrix.

[wiki](https://wiki.facepunch.com/gmod/Global.Matrix)

---

### MenuGetAddonData · Menu · `INTERNAL`
`MenuGetAddonData(workshopItemID: string)`

This function retrieves the Addon data and passes it onto JS(JavaScript)

**Arguments:**
- `workshopItemID` (string) — The ID of Steam Workshop item.

[wiki](https://wiki.facepunch.com/gmod/Global.MenuGetAddonData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L572-L577)

---

### Mesh · Client
`Mesh(mat: IMaterial = nil, boneWeights: number = 0) → IMesh`

Returns a new static mesh object.

**Arguments:**
- `mat` (IMaterial, default `nil`) — The material the mesh is intended to be rendered with.
- `boneWeights` (number, default `0`) — Number of bone weights per vertex.

**Returns:**
- IMesh — The created object.

[wiki](https://wiki.facepunch.com/gmod/Global.Mesh)

---

### Model · Shared, Menu
`Model(model: string) → string`

Runs [util.PrecacheModel](https://wiki.facepunch.com/gmod/util.PrecacheModel) and returns the string.

**Arguments:**
- `model` (string) — The model to precache.

**Returns:**
- string — The same string entered as an argument.

[wiki](https://wiki.facepunch.com/gmod/Global.Model) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L134-L137)

---

### module · Shared, Menu
`module(name: string, loaders: vararg)`

Creates a table with the specified module name and sets the function environment for said table.

Any passed loaders are called with the table as an argument. An example of this is [package.seeall](https://wiki.facepunch.com/gmod/package.seeall).

**Arguments:**
- `name` (string) — The name of the module.
- `loaders` (vararg) — Calls each function passed with the new table as an argument.

[wiki](https://wiki.facepunch.com/gmod/Global.module)

---

### Msg · Shared, Menu
`Msg(args: vararg)`

Writes every given argument to the console. Limitations of [print](https://wiki.facepunch.com/gmod/Global.print) apply.

Automatically attempts to convert each argument to a string. (See [tostring](https://wiki.facepunch.com/gmod/Global.tostring))

Unlike [print](https://wiki.facepunch.com/gmod/Global.print), arguments are not separated by anything. They are simply concatenated.

Additionally, a newline isn't added automatically to the end, so subsequent Msg or print operations will continue the same line of text in the console. See [MsgN](https://wiki.facepunch.com/gmod/Global.MsgN) for a version that does add a newline.

The text is blue on the server, orange on the client, and green on the menu:

**Arguments:**
- `args` (vararg) — List of values to print.

[wiki](https://wiki.facepunch.com/gmod/Global.Msg)

---

### MsgAll · Shared
`MsgAll(args: vararg)`

Works exactly like [Msg](https://wiki.facepunch.com/gmod/Global.Msg) except that, if called on the server, will print to all players consoles plus the server console. Limitations of [print](https://wiki.facepunch.com/gmod/Global.print) apply.

**Arguments:**
- `args` (vararg) — List of values to print.

[wiki](https://wiki.facepunch.com/gmod/Global.MsgAll)

---

### MsgC · Shared, Menu
`MsgC(args: vararg)`

Just like [Msg](https://wiki.facepunch.com/gmod/Global.Msg), except it can also print colored text, just like [chat.AddText](https://wiki.facepunch.com/gmod/chat.AddText).

**Arguments:**
- `args` (vararg) — Values to print.

[wiki](https://wiki.facepunch.com/gmod/Global.MsgC)

---

### MsgN · Shared, Menu
`MsgN(args: vararg)`

Same as [print](https://wiki.facepunch.com/gmod/Global.print), except it concatinates the arguments without inserting any whitespace in between them.

See also [Msg](https://wiki.facepunch.com/gmod/Global.Msg), which doesn't add a newline (`"\n"`) at the end.

**Arguments:**
- `args` (vararg) — List of values to print.

[wiki](https://wiki.facepunch.com/gmod/Global.MsgN)

---

### NamedColor · Client
`NamedColor(name: string) → Color`

Returns named color defined in `resource/ClientScheme.res`.

**Arguments:**
- `name` (string) — Name of color

**Returns:**
- Color — A Color or nil

[wiki](https://wiki.facepunch.com/gmod/Global.NamedColor)

---

### newproxy · Shared, Menu
`newproxy(addMetatable: boolean = false, userData: userdata) → userdata`

Creates a new [userdata](https://wiki.facepunch.com/gmod/userdata) object.

**Arguments:**
- `addMetatable` (boolean, default `false`) — If true, the created userdata will be given its own metatable.
- `userData` (userdata) — Creates a new userdata with the same metatable the userdata passed in had.

**Returns:**
- userdata — The newly created userdata.

> **Bug** ([#5299](https://github.com/Facepunch/garrysmod/issues/5299)): Fails under certain conditions when called in coroutines

[wiki](https://wiki.facepunch.com/gmod/Global.newproxy)

---

### next · Shared, Menu
`next(tab: table, prevKey: any = nil) → any, any`

Returns the next key and value pair in a table.

**Arguments:**
- `tab` (table) — The table
- `prevKey` (any, default `nil`) — The previous key in the table.

**Returns:**
- any — The next key for the table.
- any — The value associated with that key.

> **Note:** Table keys in Lua have no specific order, and will be returned in whatever order they exist in memory. This may not always be in ascending order or alphabetical order. If you need to iterate over an array in order, use [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs).

[wiki](https://wiki.facepunch.com/gmod/Global.next)

---

### NumDownloadables · Menu
`NumDownloadables() → number`

Returns the number of files needed from the server you are currently joining.

**Returns:**
- number — The number of downloadables

[wiki](https://wiki.facepunch.com/gmod/Global.NumDownloadables)

---

### NumModelSkins · Client
`NumModelSkins(modelName: string) → number`

Returns the amount of skins the specified model has.

See also [Entity:SkinCount](https://wiki.facepunch.com/gmod/Entity:SkinCount) if you have an entity.

**Arguments:**
- `modelName` (string) — Model to return amount of skins of

**Returns:**
- number — Amount of skins

[wiki](https://wiki.facepunch.com/gmod/Global.NumModelSkins) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/model_database.lua#L84-L93)

---

### OnModelLoaded · Client · `INTERNAL`
`OnModelLoaded(modelName: string, numPostParams: number, numSeq: number, numAttachments: number, numBoneControllers: number, numSkins: number, size: number)`

Called by the engine when a model has been loaded. Caches model information with the [sql](https://wiki.facepunch.com/gmod/sql).

**Arguments:**
- `modelName` (string) — Name of the model.
- `numPostParams` (number) — Number of pose parameters the model has.
- `numSeq` (number) — Number of sequences the model has.
- `numAttachments` (number) — Number of attachments the model has.
- `numBoneControllers` (number) — Number of bone controllers the model has.
- `numSkins` (number) — Number of skins that the model has.
- `size` (number) — Size of the model.

[wiki](https://wiki.facepunch.com/gmod/Global.OnModelLoaded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/model_database.lua#L28-L78)

---

### OpenFolder · Menu
`OpenFolder(folder: string)`

Opens a folder with the given name in the garrysmod folder using the operating system's file browser.

**Arguments:**
- `folder` (string) — The subdirectory to open in the garrysmod folder.

> **Bug** ([#1532](https://github.com/Facepunch/garrysmod/issues/1532)): This does not work on OSX or Linux.

[wiki](https://wiki.facepunch.com/gmod/Global.OpenFolder)

---

### OpenProblemsPanel · Menu
`OpenProblemsPanel()`

Opens the Problems Panel.

[wiki](https://wiki.facepunch.com/gmod/Global.OpenProblemsPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L165-L185)

---

### OrderVectors · Shared, Menu
`OrderVectors(vector1: Vector, vector2: Vector)`

Modifies the given vectors so that all of vector2's axis are larger than vector1's by switching them around. Also known as ordering vectors.

**Arguments:**
- `vector1` (Vector) — Bounding box min resultant
- `vector2` (Vector) — Bounding box max resultant

> **Note:** This function will irreversibly modify the given vectors

[wiki](https://wiki.facepunch.com/gmod/Global.OrderVectors)

---

### pairs · Shared, Menu
`pairs(tab: table) → function, table, any`

Returns an iterator function([next](https://wiki.facepunch.com/gmod/Global.next)) for a for loop that will return the values of the specified table in an arbitrary order.

* For alphabetical **key** order use [SortedPairs](https://wiki.facepunch.com/gmod/Global.SortedPairs).
* For alphabetical **value** order use [SortedPairsByValue](https://wiki.facepunch.com/gmod/Global.SortedPairsByValue).

**Arguments:**
- `tab` (table) — The table to iterate over.

**Returns:**
- function — The iterator (next).
- table — The table being iterated over.
- any — nil (for the constructor).

[wiki](https://wiki.facepunch.com/gmod/Global.pairs)

---

### Particle · Shared, Menu
`Particle(file: string) → string`

Calls [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) and returns given string.

**Arguments:**
- `file` (string) — The particle file.

**Returns:**
- string — The particle file.

[wiki](https://wiki.facepunch.com/gmod/Global.Particle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L142-L147)

---

### ParticleEffect · Shared
`ParticleEffect(particleName: string, position: Vector, angles: Angle, parent: Entity = NULL)`

Creates a particle effect. See also [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem).

**Arguments:**
- `particleName` (string) — The name of the particle effect.
- `position` (Vector) — The start position of Control Point 0 for the particle system.
- `angles` (Angle) — The orientation of Control Point 0 for the particle system.
- `parent` (Entity, default `NULL`) — If set, the particle will be parented to the entity.

> **Note:** The particle effect must be precached **serverside** with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem) and the file its from must be added via [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) before it can be used!

[wiki](https://wiki.facepunch.com/gmod/Global.ParticleEffect)

---

### ParticleEffectAttach · Shared
`ParticleEffectAttach(particleName: string, attachType: number, entity: Entity, attachmentID: number)`

Creates a particle effect with specialized parameters. See also [Entity:CreateParticleEffect](https://wiki.facepunch.com/gmod/Entity:CreateParticleEffect) and [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem).

**Arguments:**
- `particleName` (string) — The name of the particle effect.
- `attachType` (number, enum [PATTACH](https://wiki.facepunch.com/gmod/Enums/PATTACH)) — Attachment type using PATTACH.
- `entity` (Entity) — The entity to be used in the way specified by the attachType.
- `attachmentID` (number) — The id of the attachment to be used in the way specified by the attachType.

> **Note:** The particle effect must be precached **serverside** with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem) and the file its from must be added via [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) before it can be used!

[wiki](https://wiki.facepunch.com/gmod/Global.ParticleEffectAttach)

---

### ParticleEmitter · Client
`ParticleEmitter(position: Vector, use3D: boolean = false) → CLuaEmitter`

Creates a new [CLuaEmitter](https://wiki.facepunch.com/gmod/CLuaEmitter).

**Arguments:**
- `position` (Vector) — The start position of the emitter.
- `use3D` (boolean, default `false`) — Whenever to render the particles in 2D or 3D mode.

**Returns:**
- CLuaEmitter — The new particle emitter.

> **Note:** Do not forget to delete the emitter with [CLuaEmitter:Finish](https://wiki.facepunch.com/gmod/CLuaEmitter:Finish) once you are done with it
> **Warning:** There is a limit of 4097 emitters that can be active at once, exceeding this limit will throw a non-halting error in console!

[wiki](https://wiki.facepunch.com/gmod/Global.ParticleEmitter)

---

### Path · Server
`Path(type: string) → PathFollower`

Creates a path for the bot to follow using one of two types (`Follow` or `Chase`)

`Follow` is a general purpose path. Best used for static or infrequently updated locations. The path will only be updated once [PathFollower:Update](https://wiki.facepunch.com/gmod/PathFollower:Update) is called. This needs to be done manually (typically inside the bots `BehaveThread` coroutine.

`Chase` is a specifically optimized for chasing a moving entity. Paths of this type will use [PathFollower:Chase](https://wiki.facepunch.com/gmod/PathFollower:Chase)

**Arguments:**
- `type` (string) — The type of the path to create, must be `"Follow"` or `"Chase"`

**Returns:**
- PathFollower — The path

[wiki](https://wiki.facepunch.com/gmod/Global.Path)

---

### pcall · Shared, Menu
`pcall(func: function, arguments: vararg) → boolean, vararg`

Calls a function and catches an error that can be thrown while the execution of the call.

**Arguments:**
- `func` (function) — Function to be executed and of which the errors should be caught of
- `arguments` (vararg) — Arguments to call the function with.

**Returns:**
- boolean — If the function had no errors occur within it.
- vararg — If an error occurred, this will be a string containing the error message.

> **Bug** ([#2036](https://github.com/Facepunch/garrysmod/issues/2036)): This cannot stop errors from hooks called from the engine.
> **Bug** ([#2498](https://github.com/Facepunch/garrysmod/issues/2498)): This does not stop [Global.Error](https://wiki.facepunch.com/gmod/Global.Error) and [ErrorNoHalt](https://wiki.facepunch.com/gmod/Global.ErrorNoHalt) from sending error messages to the server (if called clientside) or calling the [GM:OnLuaError](https://wiki.facepunch.com/gmod/GM:OnLuaError) hook. The success boolean returned will always return true and thus you will not get the error message returned. [Global.error](https://wiki.facepunch.com/gmod/Global.error) does not exhibit these behaviours.

[wiki](https://wiki.facepunch.com/gmod/Global.pcall)

---

### Player · Shared
`Player(playerIndex: number) → Player`

Returns the player with the matching [Player:UserID](https://wiki.facepunch.com/gmod/Player:UserID).

For a function that returns a player based on their [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex), see [Entity](https://wiki.facepunch.com/gmod/Global.Entity).

For a function that returns a player based on their connection ID, see [player.GetByID](https://wiki.facepunch.com/gmod/player.GetByID).

**Arguments:**
- `playerIndex` (number) — The player index.

**Returns:**
- Player — The retrieved player.

[wiki](https://wiki.facepunch.com/gmod/Global.Player)

---

### PositionSpawnIcon · Client
`PositionSpawnIcon(model: Entity, position: Vector, noAngles: boolean) → table`

Moves the given model to the given position and calculates appropriate camera parameters for rendering the model to an icon.

The output table interacts nicely with [Panel:RebuildSpawnIconEx](https://wiki.facepunch.com/gmod/Panel:RebuildSpawnIconEx) with a few key renames.

**Arguments:**
- `model` (Entity) — Model that is being rendered to the spawn icon
- `position` (Vector) — Position that the model is being rendered at
- `noAngles` (boolean) — If true the function won't reset the angles to 0 for the model.

**Returns:**
- table — Table of information of the view which can be used for rendering

[wiki](https://wiki.facepunch.com/gmod/Global.PositionSpawnIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/client.lua#L176-L217)

---

### PrecacheParticleSystem · Shared
`PrecacheParticleSystem(particleSystemName: string)`

Precaches a particle system with the specified name. The particle system must come from a file that is loaded with [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) beforehand.

When used on the server, it automatically precaches the particle on client.

**Arguments:**
- `particleSystemName` (string) — The name of the particle system.

> **Warning:** There is a limit of 4096 precached particles on the server. So only precache particles that are actually going to be used.

[wiki](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem)

---

### PrecacheScene · Server
`PrecacheScene(scene: string)`

Precaches a scene file.

**Arguments:**
- `scene` (string) — Path to the scene file to precache.

[wiki](https://wiki.facepunch.com/gmod/Global.PrecacheScene)

---

### PrecacheSentenceFile · Shared
`PrecacheSentenceFile(filename: string)`

Load and precache a custom sentence file.

**Arguments:**
- `filename` (string) — The path to the custom sentences.txt.

[wiki](https://wiki.facepunch.com/gmod/Global.PrecacheSentenceFile)

---

### PrecacheSentenceGroup · Server
`PrecacheSentenceGroup(group: string)`

Precache a sentence group in a sentences.txt definition file.

**Arguments:**
- `group` (string) — The group to precache.

[wiki](https://wiki.facepunch.com/gmod/Global.PrecacheSentenceGroup)

---

### print · Shared, Menu
`print(args: vararg)`

Writes every given argument to the console.
Automatically attempts to convert each argument to a string. (See [tostring](https://wiki.facepunch.com/gmod/Global.tostring))

Separates lines with a line break (`"\n"`)

Separates arguments with a tab character (`"\t"`).

Can only print up to `4096` characters at a time, and will stop at NULL character. (`"\0"`)

See [Msg](https://wiki.facepunch.com/gmod/Global.Msg) for alternative that doesn't force add a new line, and [MsgC](https://wiki.facepunch.com/gmod/Global.MsgC) for adding colored text to the console.

**Arguments:**
- `args` (vararg) — List of values to print.

[wiki](https://wiki.facepunch.com/gmod/Global.print)

---

### PrintMessage · Server
`PrintMessage(type: number, message: string)`

Displays a message in the chat, console, or center of screen of every player.

This uses the archaic user message system ([umsg](https://wiki.facepunch.com/gmod/umsg)) and hence is limited to 255 characters.

**Arguments:**
- `type` (number, enum [HUD](https://wiki.facepunch.com/gmod/Enums/HUD)) — Which type of message should be sent to the players (see HUD)
- `message` (string) — Message to be sent to the players

[wiki](https://wiki.facepunch.com/gmod/Global.PrintMessage)

---

### PrintTable · Shared, Menu
`PrintTable(tableToPrint: table, indent: number = 0, done: table = {})`

Recursively prints the contents of a table to the console.

The table keys will be sorted alphabetically or numerically when printed to the console.

**Arguments:**
- `tableToPrint` (table) — The table to be printed
- `indent` (number, default `0`) — Number of tabs to start indenting at.
- `done` (table, default `{}`) — Internal argument, you shouldn't normally change this.

[wiki](https://wiki.facepunch.com/gmod/Global.PrintTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L59-L93)

---

### ProjectedTexture · Client
`ProjectedTexture() → ProjectedTexture`

Creates a new [ProjectedTexture](https://wiki.facepunch.com/gmod/ProjectedTexture).

**Returns:**
- ProjectedTexture — Newly created projected texture.

[wiki](https://wiki.facepunch.com/gmod/Global.ProjectedTexture)

---

### ProtectedCall · Shared
`ProtectedCall(func: function, arguments: vararg) → boolean`

Runs a function without stopping the whole script on error.

This function is similar to [pcall](https://wiki.facepunch.com/gmod/Global.pcall) and [xpcall](https://wiki.facepunch.com/gmod/Global.xpcall) except the errors are still printed and sent to the error handler (i.e. sent to server console if clientside and [GM:OnLuaError](https://wiki.facepunch.com/gmod/GM:OnLuaError) called).

**Arguments:**
- `func` (function) — Function to run
- `arguments` (vararg) — Arguments to call the function with.

**Returns:**
- boolean — Whether the function executed successfully or not

[wiki](https://wiki.facepunch.com/gmod/Global.ProtectedCall)

---

### RandomPairs · Shared, Menu
`RandomPairs(table: table, descending: boolean = nil) → function`

Returns an iterator function that can be used to loop through a table in random order

**Arguments:**
- `table` (table) — Table to create iterator for
- `descending` (boolean, default `nil`) — Whether the iterator should iterate descending or not

**Returns:**
- function — Iterator function

[wiki](https://wiki.facepunch.com/gmod/Global.RandomPairs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L563-L580)

---

### rawequal · Shared, Menu
`rawequal(value1: any, value2: any) → boolean`

Compares the two values without calling their __eq operator.

**Arguments:**
- `value1` (any) — The first value to compare.
- `value2` (any) — The second value to compare.

**Returns:**
- boolean — Whether or not the two values are equal.

[wiki](https://wiki.facepunch.com/gmod/Global.rawequal)

---

### rawget · Shared, Menu
`rawget(table: table, index: any) → any`

Gets the value with the specified key from the table without calling the __index method.

**Arguments:**
- `table` (table) — Table to get the value from.
- `index` (any) — The index to get the value from.

**Returns:**
- any — The value.

[wiki](https://wiki.facepunch.com/gmod/Global.rawget)

---

### rawset · Shared, Menu
`rawset(table: table, index: any, value: any)`

Sets the value with the specified key from the table without calling the __newindex method.

**Arguments:**
- `table` (table) — Table to get the value from.
- `index` (any) — The index to get the value from.
- `value` (any) — The value to set for the specified key.

[wiki](https://wiki.facepunch.com/gmod/Global.rawset)

---

### RealFrameTime · Client
`RealFrameTime() → number`

Returns the real frame-time which is unaffected by host_timescale. To be used for GUI effects (for example)

**Returns:**
- number — Real frame time

> **Note:** The returned number is clamped between `0` and `0.1`.

[wiki](https://wiki.facepunch.com/gmod/Global.RealFrameTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/client.lua#L10-L10)

---

### RealTime · Shared
`RealTime() → number`

Returns the uptime of the game/server in seconds (to at least **4** decimal places). This value updates itself once every time the realm thinks. For servers, this is the server tickrate. For clients, its their current FPS.



You should use this function (or [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime)) for timing real-world events such as user interaction, but not for timing game events such as animations.

See also: [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime), [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime)

**Returns:**
- number — Uptime of the game/server.

> **Note:** This is **not** synchronised or affected by the game.
> 
> This will be affected by precision loss if the uptime is more than 30+(?) days, and effectively cease to be functional after 50+(?) days.
> 
> Changing the map will **not** fix it like it does with [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime). A server restart is necessary.

[wiki](https://wiki.facepunch.com/gmod/Global.RealTime)

---

### RecipientFilter · Server
`RecipientFilter(unreliable: boolean = false) → CRecipientFilter`

Creates a new [CRecipientFilter](https://wiki.facepunch.com/gmod/CRecipientFilter).

**Arguments:**
- `unreliable` (boolean, default `false`) — If set to true, makes the filter unreliable.

**Returns:**
- CRecipientFilter — The new created recipient filter.

[wiki](https://wiki.facepunch.com/gmod/Global.RecipientFilter)

---

### RecordDemoFrame · Menu · `INTERNAL`
`RecordDemoFrame()`

Adds a frame to the currently recording demo.

[wiki](https://wiki.facepunch.com/gmod/Global.RecordDemoFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/demo_to_video.lua#L312)

---

### RefreshAddonConflicts · Menu
`RefreshAddonConflicts()`

Refreshes all Addon Conflicts after 1 Second. Internally uses [FireAddonConflicts](https://wiki.facepunch.com/gmod/Global.FireAddonConflicts)

[wiki](https://wiki.facepunch.com/gmod/Global.RefreshAddonConflicts) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/problems/problems.lua#L317-L319)

---

### RegisterDermaMenuForClose · Client, Menu
`RegisterDermaMenuForClose(menu: Panel)`

Registers a Derma element to be closed the next time [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) is called

**Arguments:**
- `menu` (Panel) — Menu to be registered for closure

[wiki](https://wiki.facepunch.com/gmod/Global.RegisterDermaMenuForClose) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_menus.lua#L4-L8)

---

### RegisterMetaTable · Shared, Menu
`RegisterMetaTable(metaName: string, metaTable: table)`

Registers a given table as a metatable. It can then be accessed by other code/addons via [FindMetaTable](https://wiki.facepunch.com/gmod/Global.FindMetaTable).

**Arguments:**
- `metaName` (string) — The new metatable name.
- `metaTable` (table) — The new metatable table.

[wiki](https://wiki.facepunch.com/gmod/Global.RegisterMetaTable)

---

### RememberCursorPosition · Client, Menu
`RememberCursorPosition()`

Saves position of your cursor on screen. You can restore it by using [RestoreCursorPosition](https://wiki.facepunch.com/gmod/Global.RestoreCursorPosition). This is used internally by the spawn menu/context menu

[wiki](https://wiki.facepunch.com/gmod/Global.RememberCursorPosition) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L391-L400)

---

### RemoveTooltip · Client, Menu
`RemoveTooltip()`

Does the removing of the tooltip panel. Called by [EndTooltip](https://wiki.facepunch.com/gmod/Global.EndTooltip).

[wiki](https://wiki.facepunch.com/gmod/Global.RemoveTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/tooltips.lua#L9-L18)

---

### RenderAngles · Client
`RenderAngles() → Angle`

Returns the angle that the clients view is being rendered at. Returns `angles` from the return value of [render.GetViewSetup](https://wiki.facepunch.com/gmod/render.GetViewSetup).

See also [EyeAngles](https://wiki.facepunch.com/gmod/Global.EyeAngles).

**Returns:**
- Angle — Render Angles

[wiki](https://wiki.facepunch.com/gmod/Global.RenderAngles)

---

### RenderDoF · Client
`RenderDoF(origin: Vector, angle: Angle, usableFocusPoint: Vector, angleSize: number, radialSteps: number, passes: number, spin: boolean, inView: table, fov: number)`

Renders a Depth of Field effect

**Arguments:**
- `origin` (Vector) — Origin to render the effect at
- `angle` (Angle) — Angle to render the effect at
- `usableFocusPoint` (Vector) — Point to focus the effect at
- `angleSize` (number) — Angle size of the effect
- `radialSteps` (number) — Amount of radial steps to render the effect with
- `passes` (number) — Amount of render passes
- `spin` (boolean) — Whether to cycle the frame or not
- `inView` (table) — Table of view data
- `fov` (number) — FOV to render the effect with

[wiki](https://wiki.facepunch.com/gmod/Global.RenderDoF) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/super_dof.lua#L158-L263)

---

### RenderStereoscopy · Client
`RenderStereoscopy(viewOrigin: Vector, viewAngles: Angle)`

Renders the stereoscopic post-process effect

**Arguments:**
- `viewOrigin` (Vector) — Origin to render the effect at
- `viewAngles` (Angle) — Angles to render the effect at

[wiki](https://wiki.facepunch.com/gmod/Global.RenderStereoscopy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/stereoscopy.lua#L11-L37)

---

### RenderSuperDoF · Client
`RenderSuperDoF(viewOrigin: Vector, viewAngles: Angle, viewFOV: number)`

Renders the Super Depth of Field post-process effect

**Arguments:**
- `viewOrigin` (Vector) — Origin to render the effect at
- `viewAngles` (Angle) — Angles to render the effect at
- `viewFOV` (number) — Field of View to render the effect at

[wiki](https://wiki.facepunch.com/gmod/Global.RenderSuperDoF) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/super_dof.lua#L265-L313)

---

### RequestConnectToServer · Menu · `INTERNAL`
`RequestConnectToServer(serverip: string)`

If the server has the permission "connect" granted, it will instantly connect you to the server.  
If the permission is not granted it will, it opens a confirmation window to connect to the server.

**Arguments:**
- `serverip` (string) — The server ip to connect to

[wiki](https://wiki.facepunch.com/gmod/Global.RequestConnectToServer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/openurl.lua#L292-L300)

---

### RequestOpenURL · Menu · `INTERNAL`
`RequestOpenURL(url: string)`

Opens a confirmation window to open the url.

**Arguments:**
- `url` (string) — The Website URL to open.

[wiki](https://wiki.facepunch.com/gmod/Global.RequestOpenURL) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/openurl.lua#L286-L291)

---

### RequestPermission · Menu · `INTERNAL`
`RequestPermission(permission: string)`

Opens a confirmation window to grant the requested permission.

**Arguments:**
- `permission` (string) — The permission to ask

[wiki](https://wiki.facepunch.com/gmod/Global.RequestPermission) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/openurl.lua#L301-L305)

---

### require · Shared, Menu
`require(name: string)`

First tries to load a binary module with the given name, if unsuccessful, it tries to load a Lua module with the given name.

**Arguments:**
- `name` (string) — The name of the module to be loaded.

> **Note:** This function will try to load local client file if `sv_allowcslua` is set to `1`
> **Note:** Binary modules can't be installed as part of an addon and have to be put directly into ``garrysmod/lua/bin/`` to be detected.
> 	This is a safety measure, because modules can be malicious and harm the system.
> **Bug** ([#2498](https://github.com/Facepunch/garrysmod/issues/2498)): Running this function with [pcall](https://wiki.facepunch.com/gmod/Global.pcall) or [xpcall](https://wiki.facepunch.com/gmod/Global.xpcall) will still print an error that counts towards sv_kickerrornum.

[wiki](https://wiki.facepunch.com/gmod/Global.require)

---

### RestoreCursorPosition · Client, Menu
`RestoreCursorPosition()`

Restores position of your cursor on screen. You can save it by using [RememberCursorPosition](https://wiki.facepunch.com/gmod/Global.RememberCursorPosition).

[wiki](https://wiki.facepunch.com/gmod/Global.RestoreCursorPosition) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L402-L407)

---

### RunConsoleCommand · Shared, Menu
`RunConsoleCommand(command: string, arguments: vararg)`

Executes the given console command with the parameters.

**Arguments:**
- `command` (string) — The command to be executed.
- `arguments` (vararg) — The arguments.

> **Note:** Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see [Blocked ConCommands](https://wiki.facepunch.com/gmod/Blocked%20ConCommands).

[wiki](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand)

---

### RunGameUICommand · Menu
`RunGameUICommand(command: string)`

Runs a menu command. Equivalent to [RunConsoleCommand](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand)`( "gamemenucommand", command )` unless the command starts with the `"engine"` keyword in which case it is equivalent to [RunConsoleCommand](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand)`( command )`.

**Arguments:**
- `command` (string) — The menu command to run Should be one of the following: * `Disconnect` - Disconnects from the current server.

> **Warning:** Invoking engine commands no longer works, prints out `Not running engine cmd 'concommand'`

[wiki](https://wiki.facepunch.com/gmod/Global.RunGameUICommand)

---

### RunString · Shared, Menu
`RunString(code: string, identifier: string = RunString, handleError: boolean = true) → string`

Evaluates and executes the given code, will throw an error on failure.

**Arguments:**
- `code` (string) — The code to execute.
- `identifier` (string, default `RunString`) — The name that should appear in any error messages caused by this code.
- `handleError` (boolean, default `true`) — If false, this function will return a string containing any error messages instead of throwing an error.

**Returns:**
- string — If handleError is false, the error message (if any).

> **Note:** Local variables are not passed to the given code.

[wiki](https://wiki.facepunch.com/gmod/Global.RunString)

---

### RunStringEx · Shared, Menu · `DEPRECATED`
`RunStringEx(code: string, identifier: string = RunString, handleError: boolean = true) → string`

Alias of [RunString](https://wiki.facepunch.com/gmod/Global.RunString).

**Arguments:**
- `code` (string) — The code to execute.
- `identifier` (string, default `RunString`) — The name that should appear in any error messages caused by this code.
- `handleError` (boolean, default `true`) — If false, this function will return a string containing any error messages instead of throwing an error.

**Returns:**
- string — If handleError is false, the error message (if any).

[wiki](https://wiki.facepunch.com/gmod/Global.RunStringEx)

---

### SafeRemoveEntity · Shared, Menu
`SafeRemoveEntity(ent: Entity)`

Removes the given entity unless it is a player or the world entity.

**Arguments:**
- `ent` (Entity) — Entity to safely remove.

[wiki](https://wiki.facepunch.com/gmod/Global.SafeRemoveEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L217-L223)

---

### SafeRemoveEntityDelayed · Shared, Menu
`SafeRemoveEntityDelayed(entity: Entity, delay: number)`

Removes entity after delay using [SafeRemoveEntity](https://wiki.facepunch.com/gmod/Global.SafeRemoveEntity).

**Arguments:**
- `entity` (Entity) — Entity to be removed.
- `delay` (number) — Delay for entity removal in seconds.

[wiki](https://wiki.facepunch.com/gmod/Global.SafeRemoveEntityDelayed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L228-L234)

---

### SaveAddonPresets · Menu
`SaveAddonPresets(JSON: string)`

Sets the content of `addonpresets.txt` located in the `garrysmod/settings` folder. By default, this file stores your addon presets as JSON.

You can use [LoadAddonPresets](https://wiki.facepunch.com/gmod/Global.LoadAddonPresets) to retrieve the data in this file.

**Arguments:**
- `JSON` (string) — The new contents of the file.

[wiki](https://wiki.facepunch.com/gmod/Global.SaveAddonPresets)

---

### SaveHideNews · Menu · `INTERNAL`
`SaveHideNews(hide: boolean)`

Hides the News List when set to true.

**Arguments:**
- `hide` (boolean) — true if it should hide the News.

> **Note:** If you call this don't forget to call [LoadNewsList](https://wiki.facepunch.com/gmod/Global.LoadNewsList) to update the News List.

[wiki](https://wiki.facepunch.com/gmod/Global.SaveHideNews) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L309-L311)

---

### SaveLastMap · Menu · `INTERNAL`
`SaveLastMap(map: string, category: string)`

This function is used to save the last map and category to which the map belongs as a .

**Arguments:**
- `map` (string) — The name of the map.
- `category` (string) — The name of the category to which this map belongs.

[wiki](https://wiki.facepunch.com/gmod/Global.SaveLastMap) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L441-L449)

---

### SavePresets · Client · `INTERNAL`
`SavePresets(presets: table)`

Overwrites all presets with the supplied table. Used by the [presets](https://wiki.facepunch.com/gmod/presets) for preset saving

**Arguments:**
- `presets` (table) — Presets to be saved

[wiki](https://wiki.facepunch.com/gmod/Global.SavePresets)

---

### ScreenScale · Client
`ScreenScale(size: number) → number`

Returns a number based on the `size` argument and the players' screen width. This is used to scale user interface (UI) elements to be consistently sized and positioned across all screen resolutions.

The width is scaled in relation to `640x480` resolution, and does **not** take into account non the aspect ratio. See example below for how to adjust for that.

This function can also be used for scaling font sizes.

See [ScreenScaleH](https://wiki.facepunch.com/gmod/Global.ScreenScaleH) for a function that scales from height.

**Arguments:**
- `size` (number) — The position or size you want to scale within 640 pixel wide screen.

**Returns:**
- number — The scaled number based on the player's screen width.

[wiki](https://wiki.facepunch.com/gmod/Global.ScreenScale) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/globals.lua#L6-L8)

---

### ScreenScaleH · Client
`ScreenScaleH(size: number) → number`

Returns a number based on the `size` argument and players' screen height. The height is scaled in relation to `640x480` resolution.  This function is primarily used for scaling font sizes.

See [ScreenScale](https://wiki.facepunch.com/gmod/Global.ScreenScale) for a function that scales from width.

**Arguments:**
- `size` (number) — The number you want to scale.

**Returns:**
- number — The scaled number based on your screen's height.

[wiki](https://wiki.facepunch.com/gmod/Global.ScreenScaleH) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/globals.lua#L10-L12)

---

### ScrH · Client, Menu
`ScrH() → number`

Gets the height of the game's window (in pixels).

**Returns:**
- number — The height of the game's window in pixels

> **Note:** ScrH() returns the height from the current viewport, this can be changed via [render.SetViewPort](https://wiki.facepunch.com/gmod/render.SetViewPort), inside Render Targets and cam.Start contexts.

[wiki](https://wiki.facepunch.com/gmod/Global.ScrH)

---

### ScrW · Client, Menu
`ScrW() → number`

Gets the width of the game's window (in pixels).

**Returns:**
- number — The width of the game's window in pixels

> **Note:** ScrW() returns the width from the current viewport, this can be changed via [render.SetViewPort](https://wiki.facepunch.com/gmod/render.SetViewPort), inside Render Targets and cam.Start contexts.

[wiki](https://wiki.facepunch.com/gmod/Global.ScrW)

---

### select · Shared, Menu
`select(parameter: any, vararg: vararg) → any`

Used to select single values from a vararg or get the count of values in it.

**Arguments:**
- `parameter` (any) — Can be a number or string.
- `vararg` (vararg) — The vararg.

**Returns:**
- any — Returns a number or vararg, depending on the select method.

[wiki](https://wiki.facepunch.com/gmod/Global.select)

---

### SendUserMessage · Shared · `DEPRECATED`
`SendUserMessage(name: string, recipients: any, args: vararg)`

Send a usermessage

**Arguments:**
- `name` (string) — The name of the usermessage
- `recipients` (any) — Can be a CRecipientFilter, table or Player object.
- `args` (vararg) — Data to send in the usermessage

> **Note:** This does nothing clientside.

[wiki](https://wiki.facepunch.com/gmod/Global.SendUserMessage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/usermessage.lua#L11-L39)

---

### SentenceDuration · Shared
`SentenceDuration(name: string) → number`

Returns approximate duration of a sentence by name. See [EmitSentence](https://wiki.facepunch.com/gmod/Global.EmitSentence).

**Arguments:**
- `name` (string) — The sentence name.

**Returns:**
- number — The approximate duration.

[wiki](https://wiki.facepunch.com/gmod/Global.SentenceDuration)

---

### ServerLog · Server
`ServerLog(parameter: string)`

Prints `ServerLog: PARAM` without a newline, to the server log and console.

As of June 2022, if `sv_logecho` is set to `0` (defaults to `1`) the message will not print to console and will only be written to the server's log file.

**Arguments:**
- `parameter` (string) — The value to be printed to console.

[wiki](https://wiki.facepunch.com/gmod/Global.ServerLog)

---

### SetClipboardText · Client, Menu
`SetClipboardText(text: string)`

Adds the given string to the computers clipboard, which can then be pasted in or outside of GMod with Ctrl + V.

**Arguments:**
- `text` (string) — The text to add to the clipboard.

[wiki](https://wiki.facepunch.com/gmod/Global.SetClipboardText)

---

### setfenv · Shared, Menu
`setfenv(location: function, environment: table) → function`

Sets the environment for a function or a stack level. Can be used to sandbox code.

**Arguments:**
- `location` (function) — The function to set the environment for, or a number representing stack level.
- `environment` (table) — Table to be used as the the environment.

**Returns:**
- function — The function passed, otherwise nil.

[wiki](https://wiki.facepunch.com/gmod/Global.setfenv)

---

### SetGlobal2Angle · Shared
`SetGlobal2Angle(index: any, angle: Angle)`

Defines an angle to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global angle with
- `angle` (Angle) — Angle to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Angle)

---

### SetGlobal2Bool · Shared
`SetGlobal2Bool(index: any, bool: boolean)`

Defined a boolean to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global boolean with
- `bool` (boolean) — Boolean to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Bool)

---

### SetGlobal2Entity · Shared
`SetGlobal2Entity(index: any, ent: Entity)`

Defines an entity to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global entity with
- `ent` (Entity) — Entity to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Entity)

---

### SetGlobal2Float · Shared
`SetGlobal2Float(index: any, float: number)`

Defines a floating point number to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global float with
- `float` (number) — Float to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** This function has a floating point precision error. Use [SetGlobalFloat](https://wiki.facepunch.com/gmod/Global.SetGlobalFloat) instead

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Float)

---

### SetGlobal2Int · Shared
`SetGlobal2Int(index: string, value: number)`

Sets an integer that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `value` (number) — The value to set the global value to

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** The integer has a 32 bit limit. Use [SetGlobalInt](https://wiki.facepunch.com/gmod/Global.SetGlobalInt) instead

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Int)

---

### SetGlobal2String · Shared
`SetGlobal2String(index: any, string: string)`

Defines a string with a maximum of 511 characters to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global string with
- `string` (string) — String to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2String)

---

### SetGlobal2Var · Shared
`SetGlobal2Var(index: any, value: any)`

Defines a variable to be automatically networked to clients


| Allowed Types   |  
| --------------- |  
| Angle           |  
| Boolean         |  
| Entity          |  
| Float           |  
| Int             |  
| String          |  
| Vector          |

**Arguments:**
- `index` (any) — Index to identify the global vector with
- `value` (any) — Value to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** Trying to network a type that is not listed above will result in a nil value!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Var)

---

### SetGlobal2Vector · Shared
`SetGlobal2Vector(index: any, vec: Vector)`

Defines a vector to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global vector with
- `vec` (Vector) — Vector to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobal2Vector)

---

### SetGlobalAngle · Shared
`SetGlobalAngle(index: any, angle: Angle)`

Defines an angle to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global angle with
- `angle` (Angle) — Angle to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Angle](https://wiki.facepunch.com/gmod/Global.SetGlobal2Angle). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalAngle)

---

### SetGlobalBool · Shared
`SetGlobalBool(index: any, bool: boolean)`

Defined a boolean to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global boolean with
- `bool` (boolean) — Boolean to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Bool](https://wiki.facepunch.com/gmod/Global.SetGlobal2Bool). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalBool)

---

### SetGlobalEntity · Shared
`SetGlobalEntity(index: any, ent: Entity)`

Defines an entity to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global entity with
- `ent` (Entity) — Entity to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Entity](https://wiki.facepunch.com/gmod/Global.SetGlobal2Entity). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalEntity)

---

### SetGlobalFloat · Shared
`SetGlobalFloat(index: any, float: number)`

Defines a floating point number to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global float with
- `float` (number) — Float to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Float](https://wiki.facepunch.com/gmod/Global.SetGlobal2Float). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalFloat)

---

### SetGlobalInt · Shared
`SetGlobalInt(index: string, value: number)`

Sets an integer that is shared between the server and all clients.

**Arguments:**
- `index` (string) — The unique index to identify the global value with.
- `value` (number) — The value to set the global value to

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Int](https://wiki.facepunch.com/gmod/Global.SetGlobal2Int). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)
> **Bug** ([#3374](https://github.com/Facepunch/garrysmod/issues/3374)): This function will not round decimal values as it actually networks a 64 bit float internally.

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalInt)

---

### SetGlobalString · Shared
`SetGlobalString(index: any, string: string)`

Defines a string with a maximum of 199 characters to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global string with
- `string` (string) — String to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Note:** If you want to have a higher characters limit use [SetGlobal2String](https://wiki.facepunch.com/gmod/Global.SetGlobal2String)
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2String](https://wiki.facepunch.com/gmod/Global.SetGlobal2String). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalString)

---

### SetGlobalVar · Shared
`SetGlobalVar(index: any, value: any)`

Defines a variable to be automatically networked to clients


| Allowed Types   |  
| --------------- |  
| Angle           |  
| Boolean         |  
| Entity          |  
| Float           |  
| Int             |  
| String          |  
| Vector          |

**Arguments:**
- `index` (any) — Index to identify the global vector with
- `value` (any) — Value to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** Trying to network a type that is not listed above will result in an error!  
> There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Var](https://wiki.facepunch.com/gmod/Global.SetGlobal2Var). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalVar)

---

### SetGlobalVector · Shared
`SetGlobalVector(index: any, vec: Vector)`

Defines a vector to be automatically networked to clients

**Arguments:**
- `index` (any) — Index to identify the global vector with
- `vec` (Vector) — Vector to be networked

> **Note:** Running this function clientside will only set it clientside for the client it is called on!
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [SetGlobal2Vector](https://wiki.facepunch.com/gmod/Global.SetGlobal2Vector). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage](https://wiki.facepunch.com/gmod/Networking_Usage)

[wiki](https://wiki.facepunch.com/gmod/Global.SetGlobalVector)

---

### setmetatable · Shared, Menu
`setmetatable(Tab: table, Metatable: table) → table`

Sets, changes or removes a table's metatable. Returns Tab (the first argument).

**Arguments:**
- `Tab` (table) — The table who's metatable to change.
- `Metatable` (table) — The metatable to assign.

**Returns:**
- table — The first argument.

[wiki](https://wiki.facepunch.com/gmod/Global.setmetatable)

---

### SetPhysConstraintSystem · Shared
`SetPhysConstraintSystem(constraintSystem: Entity)`

Called by the engine to set which [constraint system](https://developer.valvesoftware.com/wiki/Phys_constraintsystem) the next created constraints should use.

**Arguments:**
- `constraintSystem` (Entity) — Constraint system to use

[wiki](https://wiki.facepunch.com/gmod/Global.SetPhysConstraintSystem)

---

### SortedPairs · Shared, Menu
`SortedPairs(table: table, desc: boolean = false) → function, table`

This function can be used in a for loop instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs). It sorts all **keys** alphabetically.

For sorting by specific **value member**, use [SortedPairsByMemberValue](https://wiki.facepunch.com/gmod/Global.SortedPairsByMemberValue).


For sorting by **value**, use [SortedPairsByValue](https://wiki.facepunch.com/gmod/Global.SortedPairsByValue).

**Arguments:**
- `table` (table) — The table to sort
- `desc` (boolean, default `false`) — Reverse the sorting order

**Returns:**
- function — Iterator function
- table — The table being iterated over

[wiki](https://wiki.facepunch.com/gmod/Global.SortedPairs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L510-L522)

---

### SortedPairsByMemberValue · Shared, Menu
`SortedPairsByMemberValue(table: table, memberKey: any, descending: boolean = false) → function, table`

Returns an iterator function that can be used to loop through a table in order of member values, when the values of the table are also tables and contain that member.

To sort by **value**, use [SortedPairsByValue](https://wiki.facepunch.com/gmod/Global.SortedPairsByValue).


To sort by **keys**, use [SortedPairs](https://wiki.facepunch.com/gmod/Global.SortedPairs).

**Arguments:**
- `table` (table) — Table to create iterator for.
- `memberKey` (any) — Key of the value member to sort by.
- `descending` (boolean, default `false`) — Whether the iterator should iterate in descending order or not.

**Returns:**
- function — Iterator function
- table — The table the iterator was created for.

[wiki](https://wiki.facepunch.com/gmod/Global.SortedPairsByMemberValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L546-L558)

---

### SortedPairsByValue · Shared, Menu
`SortedPairsByValue(table: table, descending: boolean = false) → function, table`

Returns an iterator function that can be used to loop through a table in order of its **values**.

To sort by specific **value member**, use [SortedPairsByMemberValue](https://wiki.facepunch.com/gmod/Global.SortedPairsByMemberValue).


To sort by **keys**, use [SortedPairs](https://wiki.facepunch.com/gmod/Global.SortedPairs).

**Arguments:**
- `table` (table) — Table to create iterator for
- `descending` (boolean, default `false`) — Whether the iterator should iterate in descending order or not

**Returns:**
- function — Iterator function
- table — The table which will be iterated over

[wiki](https://wiki.facepunch.com/gmod/Global.SortedPairsByValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/table.lua#L528-L540)

---

### Sound · Shared, Menu
`Sound(soundPath: string) → string`

Runs [util.PrecacheSound](https://wiki.facepunch.com/gmod/util.PrecacheSound) and returns the string.

**Arguments:**
- `soundPath` (string) — The soundpath to precache.

**Returns:**
- string — The string passed as the first argument.

> **Bug:** [util.PrecacheSound](https://wiki.facepunch.com/gmod/util.PrecacheSound) does nothing and therefore so does this function.

[wiki](https://wiki.facepunch.com/gmod/Global.Sound) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L126-L129)

---

### SoundDuration · Shared
`SoundDuration(soundName: string) → number`

Returns the approximate duration of the specified sound in seconds, for `.wav` and `.mp3` sounds.

**Arguments:**
- `soundName` (string) — The sound file path.

**Returns:**
- number — Sound duration in seconds.

> **Note:** This function will not work with sound files prepended with a [sound character](https://developer.valvesoftware.com/wiki/Soundscripts#Sound_Characters).
> **Bug:** This function only works on mp3 files if the file is encoded with constant bitrate.

[wiki](https://wiki.facepunch.com/gmod/Global.SoundDuration)

---

### SQLStr · Shared, Menu
`SQLStr(input: string, noQuotes: boolean = false) → string`

Returns the input value in an escaped form so that it can safely be used inside of queries. The returned value is surrounded by quotes unless `noQuotes` is true. Alias of [sql.SQLStr](https://wiki.facepunch.com/gmod/sql.SQLStr).

**Arguments:**
- `input` (string) — String to be escaped
- `noQuotes` (boolean, default `false`) — Set this as `true`, and the function will not wrap the input string in apostrophes.

**Returns:**
- string — Escaped input

> **Warning:** Do not use this function with external database engines such as `MySQL`. `MySQL` and `SQLite` use different escape sequences that are incompatible with each other! Escaping strings with inadequate functions is dangerous and will lead to SQL injection vulnerabilities.

[wiki](https://wiki.facepunch.com/gmod/Global.SQLStr) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/sql.lua#L9-L25)

---

### SScale · Client · `DEPRECATED`
`SScale(Size: number)`

Returns a number based on the Size argument and your screen's width. Alias of [ScreenScale](https://wiki.facepunch.com/gmod/Global.ScreenScale).

**Arguments:**
- `Size` (number) — The number you want to scale.

[wiki](https://wiki.facepunch.com/gmod/Global.SScale) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/globals.lua#L6-L8)

---

### STNDRD · Shared, Menu
`STNDRD(number: number) → string`

Returns the ordinal suffix of a given number.

**Arguments:**
- `number` (number) — The number to find the ordinal suffix of.

**Returns:**
- string — suffix

[wiki](https://wiki.facepunch.com/gmod/Global.STNDRD) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L286-L293)

---

### SuppressHostEvents · Server
`SuppressHostEvents(suppressPlayer: Player)`

Suppress any networking from the server to the specified player. Set this to [NULL](https://wiki.facepunch.com/gmod/NULL) to stop suppressing network events.

This is automatically called by the engine before/after a player fires their weapon, reloads, or causes any other similar shared-predicted event to occur.

**Arguments:**
- `suppressPlayer` (Player) — The player to suppress any networking to.

[wiki](https://wiki.facepunch.com/gmod/Global.SuppressHostEvents)

---

### SysTime · Shared, Menu
`SysTime() → number`

Returns a highly accurate time in seconds since the start up, ideal for benchmarking. Unlike [RealTime](https://wiki.facepunch.com/gmod/Global.RealTime), this value will be updated any time the function is called, allowing for sub-think precision.

**Returns:**
- number — Uptime of the server.

[wiki](https://wiki.facepunch.com/gmod/Global.SysTime)

---

### TauntCamera · Shared
`TauntCamera() → table`

Returns a TauntCamera object

**Returns:**
- table — TauntCamera

[wiki](https://wiki.facepunch.com/gmod/Global.TauntCamera) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/player_class/taunt_camera.lua#L11-L122)

---

### TextEntryLoseFocus · Client, Menu
`TextEntryLoseFocus()`

Clears focus from any text entries player may have focused.

[wiki](https://wiki.facepunch.com/gmod/Global.TextEntryLoseFocus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L399-L417)

---

### TimedCos · Shared, Menu
`TimedCos(frequency: number, min: number, max: number, offset: number) → number`

Returns a cosine value that fluctuates based on the current time

**Arguments:**
- `frequency` (number) — The frequency of fluctuation
- `min` (number) — Minimum value
- `max` (number) — Maximum value
- `offset` (number) — Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time

**Returns:**
- number — Cosine value

[wiki](https://wiki.facepunch.com/gmod/Global.TimedCos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L305-L307)

---

### TimedSin · Shared, Menu
`TimedSin(frequency: number, origin: number, max: number, offset: number) → number`

Returns a sine value that fluctuates based on [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime). The value returned will be between the start value plus/minus the range value.

**Arguments:**
- `frequency` (number) — The frequency of fluctuation, in
- `origin` (number) — The center value of the sine wave.
- `max` (number) — This argument's distance from origin defines the size of the full range of the sine wave.
- `offset` (number) — Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time

**Returns:**
- number — Sine value

> **Bug:** The range arguments don't work as intended. The existing (bugged) behavior is documented below.

[wiki](https://wiki.facepunch.com/gmod/Global.TimedSin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L298-L300)

---

### tobool · Shared, Menu
`tobool(input: any) → boolean`

Attempts to return an appropriate boolean for the given value

**Arguments:**
- `input` (any) — The object to be converted to a boolean

**Returns:**
- boolean — * `false` for the boolean `false`.

[wiki](https://wiki.facepunch.com/gmod/Global.tobool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L251-L254)

---

### ToggleFavourite · Menu
`ToggleFavourite(map: string)`

Toggles whether or not the named map is favorited in the new game list.

**Arguments:**
- `map` (string) — Map to toggle favorite.

[wiki](https://wiki.facepunch.com/gmod/Global.ToggleFavourite) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L423-L439)

---

### tonumber · Shared, Menu
`tonumber(value: string, base: number = 10) → number|nil`

Converts strings containing numbers into actual [number](https://wiki.facepunch.com/gmod/number)s.  

Can also convert numbers from other [numerical bases](https://www.mathsisfun.com/numbers/bases.html) to base 10.

**Arguments:**
- `value` (string) — The value to be converted.
- `base` (number, default `10`) — The numerical base of the digits in the input value.

**Returns:**
- number|nil — The base `10` number representation of the input value, or `nil` if the conversion failed.

[wiki](https://wiki.facepunch.com/gmod/Global.tonumber)

---

### tostring · Shared, Menu
`tostring(value: any) → string`

Attempts to convert the value to a string. If the value is an object and its metatable has defined the __tostring metamethod, this will call that function.

[print](https://wiki.facepunch.com/gmod/Global.print) also uses this functionality.

**Arguments:**
- `value` (any) — The object to be converted to a string.

**Returns:**
- string — The string representation of the value.

[wiki](https://wiki.facepunch.com/gmod/Global.tostring)

---

### TranslateDownloadableName · Menu · `DEPRECATED` · `INTERNAL`
`TranslateDownloadableName(filename: string) → string`

Returns "Lua Cache File" if the given file name is in a certain string table, nothing otherwise.

**Arguments:**
- `filename` (string) — File name to test

**Returns:**
- string — "Lua Cache File" if the given file name is in a certain string table, nothing otherwise.

[wiki](https://wiki.facepunch.com/gmod/Global.TranslateDownloadableName)

---

### type · Shared, Menu
`type(var: any) → string`

Returns a string representing the name of the type of the passed object.

**Arguments:**
- `var` (any) — The object to get the type of.

**Returns:**
- string — The name of the object's type.

> **Warning:** This will return `table` if the input is [Color](https://wiki.facepunch.com/gmod/Global.Color), consider using [IsColor](https://wiki.facepunch.com/gmod/Global.IsColor) in that case.

[wiki](https://wiki.facepunch.com/gmod/Global.type) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L51-L65)

---

### TypeID · Shared
`TypeID(variable: any) → number`

Gets the associated type ID of the variable. Unlike [type](https://wiki.facepunch.com/gmod/Global.type), this does not work with [no value](https://wiki.facepunch.com/gmod/no%20value) - an argument must be provided.

**Arguments:**
- `variable` (any) — The variable to get the type ID of.

**Returns:**
- number — The type ID of the variable.

> **Warning:** This will return `TYPE_TABLE` for [Color](https://wiki.facepunch.com/gmod/Color) objects.
> 
> All subclasses of [Entity](https://wiki.facepunch.com/gmod/Entity) will return `TYPE_ENTITY`.
> **Bug:** This returns garbage for _LOADLIB objects.
> **Bug:** This returns `TYPE_NIL` for [proto](https://wiki.facepunch.com/gmod/proto)s.

[wiki](https://wiki.facepunch.com/gmod/Global.TypeID)

---

### unpack · Shared, Menu
`unpack(tbl: table, startIndex: number = 1, endIndex: number = #tbl) → vararg`

This function takes a numeric indexed table and return all the members as a vararg. If specified, it will start at the given index and end at end index.

**Arguments:**
- `tbl` (table) — The table to generate the vararg from.
- `startIndex` (number, default `1`) — Which index to start from.
- `endIndex` (number, default `#tbl`) — Which index to end at.

**Returns:**
- vararg — Output values

[wiki](https://wiki.facepunch.com/gmod/Global.unpack)

---

### UnPredictedCurTime · Shared, Menu
`UnPredictedCurTime() → number`

Returns the current asynchronous in-game time. This will not be synced with the players current clock allowing you to get [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) without interference from [Prediction](https://wiki.facepunch.com/gmod/Prediction).

**Returns:**
- number — The asynchronous in-game time.

[wiki](https://wiki.facepunch.com/gmod/Global.UnPredictedCurTime)

---

### UpdateAddonDisabledState · Menu · `INTERNAL`
`UpdateAddonDisabledState()`

This function retrieves the values from [GetAddonStatus](https://wiki.facepunch.com/gmod/Global.GetAddonStatus) and passes them to JS(JavaScript).

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateAddonDisabledState) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L567-L570)

---

### UpdateAddonMapList · Menu · `INTERNAL`
`UpdateAddonMapList()`

This function is called by [UpdateMapList](https://wiki.facepunch.com/gmod/Global.UpdateMapList) to pass the AddonMaps to JS to be used for the Search.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateAddonMapList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L271-L278)

---

### UpdateGames · Menu · `INTERNAL`
`UpdateGames()`

Updates the Gamelist.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateGames) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L546-L553)

---

### UpdateLanguages · Menu · `INTERNAL`
`UpdateLanguages()`

This function searches for all available languages and passes them to JS(JavaScript). JS then updates the Language list with the given languages.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateLanguages) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L523-L532)

---

### UpdateLoadPanel · Menu
`UpdateLoadPanel(javascript: string)`

Runs JavaScript on the loading screen panel ([GetLoadPanel](https://wiki.facepunch.com/gmod/Global.GetLoadPanel)).

**Arguments:**
- `javascript` (string) — JavaScript to run on the loading panel.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateLoadPanel)

---

### UpdateMapList · Menu · `INTERNAL`
`UpdateMapList()`

This function updates the Map List

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateMapList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/getmaps.lua#L280-L293)

---

### UpdateServerSettings · Menu · `INTERNAL`
`UpdateServerSettings()`

Updates the Server Settings when called.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateServerSettings) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L216-L252)

---

### UpdateSubscribedAddons · Menu · `INTERNAL`
`UpdateSubscribedAddons()`

Updates the Addons list.

[wiki](https://wiki.facepunch.com/gmod/Global.UpdateSubscribedAddons) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/menu/mainmenu.lua#L555-L565)

---

### UTIL_IsUselessModel · Shared, Menu · `DEPRECATED`
`UTIL_IsUselessModel(modelName: string) → boolean`

This function is an alias of [IsUselessModel](https://wiki.facepunch.com/gmod/Global.IsUselessModel).

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

[wiki](https://wiki.facepunch.com/gmod/Global.UTIL_IsUselessModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L264-L278)

---

### ValidPanel · Client, Menu · `DEPRECATED`
`ValidPanel(panel: Panel)`

Returns if a panel is safe to use.

**Arguments:**
- `panel` (Panel) — The panel to validate.

[wiki](https://wiki.facepunch.com/gmod/Global.ValidPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L432-L438)

---

### Vector · Shared, Menu
`Vector(x: number = 0, y: number = 0, z: number = 0, vector: Vector, vectorString: string) → Vector`

Creates a [Vector](https://wiki.facepunch.com/gmod/Vector) object.

**Arguments:**
- `x` (number, default `0`) — The x component of the vector.
- `y` (number, default `0`) — The y component of the vector.
- `z` (number, default `0`) — The z component of the vector.
- `vector` (Vector) — Creates a new Vector that is a copy of the given Vector.
- `vectorString` (string) — Attempts to parse the input string from the print format of an Vector.

**Returns:**
- Vector — The created vector object.

> **Warning:** Creating Vectors is relatively expensive when used in often running hooks or in operations requiring very frequent calls (like loops for example) due to object creation and garbage collection. It is better to store the vector in a variable or to use the [default vectors](https://wiki.facepunch.com/gmod/Global_Variables#misc) available. See [Vector:Add](https://wiki.facepunch.com/gmod/Vector:Add).

[wiki](https://wiki.facepunch.com/gmod/Global.Vector)

---

### VectorRand · Shared, Menu
`VectorRand(min: number = -1, max: number = 1) → Vector`

Returns a random vector whose components are each between min(inclusive), max(exclusive).

**Arguments:**
- `min` (number, default `-1`) — Min bound inclusive.
- `max` (number, default `1`) — Max bound exclusive.

**Returns:**
- Vector — The random direction vector.

[wiki](https://wiki.facepunch.com/gmod/Global.VectorRand) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L98-L102)

---

### VGUIFrameTime · Shared, Menu · `DEPRECATED`
`VGUIFrameTime()`

Identical to [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime). On Windows, will be the previous value of [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime).

[wiki](https://wiki.facepunch.com/gmod/Global.VGUIFrameTime)

---

### VGUIRect · Client
`VGUIRect(x: number, y: number, w: number, h: number) → Panel`

Creates and returns a [DShape](https://wiki.facepunch.com/gmod/DShape) rectangle GUI element with the given dimensions.

**Arguments:**
- `x` (number) — X position of the created element
- `y` (number) — Y position of the created element
- `w` (number) — Width of the created element
- `h` (number) — Height of the created element

**Returns:**
- Panel — DShape element

[wiki](https://wiki.facepunch.com/gmod/Global.VGUIRect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dshape.lua#L33-L39)

---

### VisualizeLayout · Client, Menu · `INTERNAL`
`VisualizeLayout(panel: Panel)`

Briefly displays layout details of the given panel on-screen

**Arguments:**
- `panel` (Panel) — Panel to display layout details of

[wiki](https://wiki.facepunch.com/gmod/Global.VisualizeLayout) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/vgui_showlayout.lua#L42-L49)

---

### WorkshopFileBase · Client, Menu · `INTERNAL`
`WorkshopFileBase(namespace: string, requiredTags: table) → table`

Returns a new WorkshopFileBase element

**Arguments:**
- `namespace` (string) — Namespace for the file base
- `requiredTags` (table) — Tags required for a Workshop submission to be interacted with by the filebase

**Returns:**
- table — WorkshopFileBase element

[wiki](https://wiki.facepunch.com/gmod/Global.WorkshopFileBase) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/workshop_files.lua#L7-L271)

---

### WorldToLocal · Shared
`WorldToLocal(position: Vector, angle: Angle, newSystemOrigin: Vector, newSystemAngles: Angle) → Vector, Angle`

Translates a worldspace vector and angle into a specific coordinate system.

**Arguments:**
- `position` (Vector) — A worldspace vector.
- `angle` (Angle) — A worldspace angle.
- `newSystemOrigin` (Vector) — The origin of the new coordinate system.
- `newSystemAngles` (Angle) — The angles of the new coordinate system.

**Returns:**
- Vector — The corresponding local space `position`
- Angle — The corresponding local space `angle`

[wiki](https://wiki.facepunch.com/gmod/Global.WorldToLocal)

---

### xpcall · Shared, Menu
`xpcall(func: function, errorCallback: function, arguments: vararg) → boolean, vararg`

Attempts to call the first function. If the execution succeeds, this returns `true` followed by the returns of the function. If execution fails, this returns `false` and the second function is called with the error message. 

Unlike in [pcall](https://wiki.facepunch.com/gmod/Global.pcall), the stack is not unwound and can therefore be used for stack analyses with the [debug](https://wiki.facepunch.com/gmod/debug).

**Arguments:**
- `func` (function) — The function to call initially.
- `errorCallback` (function) — The function to be called if execution of the first fails; the error message is passed as a string.
- `arguments` (vararg) — Arguments to pass to the initial function.

**Returns:**
- boolean — Status of the execution; `true` for success, `false` for failure.
- vararg — The returns of the first function if execution succeeded, otherwise the first return value of the error callback.

> **Bug** ([#2036](https://github.com/Facepunch/garrysmod/issues/2036)): This cannot stop errors from hooks called from the engine.
> **Bug** ([#2498](https://github.com/Facepunch/garrysmod/issues/2498)): This does not stop [Global.Error](https://wiki.facepunch.com/gmod/Global.Error) and [ErrorNoHalt](https://wiki.facepunch.com/gmod/Global.ErrorNoHalt) (As well as [include](https://wiki.facepunch.com/gmod/Global.include)) from sending error messages to the server (if called clientside) or calling the [GM:OnLuaError](https://wiki.facepunch.com/gmod/GM:OnLuaError) hook. The success boolean returned will always return true and thus you will not get the error message returned. [Global.error](https://wiki.facepunch.com/gmod/Global.error) does not exhibit these behaviours.

[wiki](https://wiki.facepunch.com/gmod/Global.xpcall)
