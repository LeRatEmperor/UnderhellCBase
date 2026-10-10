# Tool

**Realm:** Shared  ·  **Members:** 33

A list of functions available inside a Sandbox Toolgun tool.

You can find the hooks [here](https://wiki.facepunch.com/gmod/TOOL_Hooks), and members [here](https://wiki.facepunch.com/gmod/Structures/TOOL).

[wiki page](https://wiki.facepunch.com/gmod/Tool)

### Tool:Allowed · Shared
`Tool:Allowed() → boolean`

Returns whether the tool is allowed to be used or not. This function ignores the [SANDBOX:CanTool](https://wiki.facepunch.com/gmod/SANDBOX:CanTool) hook.

By default this will always return true clientside and uses `TOOL.AllowedCVar`which is a [ConVar](https://wiki.facepunch.com/gmod/ConVar) object pointing to  `toolmode_allow_*toolname*` convar on the server.

**Returns:**
- boolean — Returns true if the tool is allowed.

[wiki](https://wiki.facepunch.com/gmod/Tool:Allowed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L90)

---

### Tool:BuildConVarList · Shared
`Tool:BuildConVarList() → table`

Builds a list of all ConVars set via the ClientConVar variable on the [Structures/TOOL](https://wiki.facepunch.com/gmod/Structures/TOOL) and their default values. This is used for the preset system.

**Returns:**
- `convars` (table) — A list of all convars and their default values.

[wiki](https://wiki.facepunch.com/gmod/Tool:BuildConVarList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L67)

---

### Tool:CheckObjects · Shared · `INTERNAL`
`Tool:CheckObjects()`

Checks all added objects to see if they're still valid, if not, clears the list of objects.

[wiki](https://wiki.facepunch.com/gmod/Tool:CheckObjects) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L117)

---

### Tool:ClearObjects · Shared
`Tool:ClearObjects()`

Clears all objects previously set with [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).

[wiki](https://wiki.facepunch.com/gmod/Tool:ClearObjects) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L34)

---

### Tool:Create · Shared · `INTERNAL`
`Tool:Create() → Tool`

Initializes the tool object

**Returns:**
- `tool` (Tool) — The created tool object.

[wiki](https://wiki.facepunch.com/gmod/Tool:Create) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L11)

---

### Tool:CreateConVars · Shared · `INTERNAL`
`Tool:CreateConVars()`

Creates clientside ConVars based on the ClientConVar table specified in the tool structure. Also creates the 'toolmode_allow_X' ConVar.

[wiki](https://wiki.facepunch.com/gmod/Tool:CreateConVars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L33)

---

### Tool:GetBone · Shared
`Tool:GetBone(id: number) → number`

Retrieves a physics bone number previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- number — Associated physics bone with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetBone) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L81)

---

### Tool:GetClientBool · Shared
`Tool:GetClientBool(name: string, default: boolean = false) → number`

Attempts to grab a clientside tool [ConVar](https://wiki.facepunch.com/gmod/ConVar) value as a [boolean](https://wiki.facepunch.com/gmod/boolean).

**Arguments:**
- `name` (string) — Name of the ConVar to retrieve.
- `default` (boolean, default `false`) — The default value to return in case the lookup fails.

**Returns:**
- number — The value of the requested ConVar.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetClientBool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L87)

---

### Tool:GetClientInfo · Shared
`Tool:GetClientInfo(name: string) → string`

Attempts to grab a clientside tool [ConVar](https://wiki.facepunch.com/gmod/ConVar) as a [string](https://wiki.facepunch.com/gmod/string).

**Arguments:**
- `name` (string) — Name of the convar to retrieve.

**Returns:**
- string — The value of the requested ConVar.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetClientInfo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L67)

---

### Tool:GetClientNumber · Shared
`Tool:GetClientNumber(name: string, default: number = 0) → number`

Attempts to grab a clientside tool [ConVar](https://wiki.facepunch.com/gmod/ConVar)'s value as a [number](https://wiki.facepunch.com/gmod/number).

**Arguments:**
- `name` (string) — Name of the convar to retrieve.
- `default` (number, default `0`) — The default value to return in case the lookup fails.

**Returns:**
- number — The value of the requested ConVar.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetClientNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L77)

---

### Tool:GetEnt · Shared
`Tool:GetEnt(id: number) → Entity`

Retrieves an Entity previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- Entity — Associated Entity with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetEnt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L48)

---

### Tool:GetHelpText · Shared
`Tool:GetHelpText() → string`

Returns a language key based on this tool's name and the current stage it is on.

**Returns:**
- `key` (string) — The returned language key, for example `"#tool.weld.1"`

[wiki](https://wiki.facepunch.com/gmod/Tool:GetHelpText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L163)

---

### Tool:GetLocalPos · Shared
`Tool:GetLocalPos(id: number) → Vector`

Retrieves an local vector previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).
See also [Tool:GetPos](https://wiki.facepunch.com/gmod/Tool:GetPos).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- Vector — Associated local vector with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetLocalPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L76)

---

### Tool:GetMode · Shared
`Tool:GetMode() → string`

Returns the name of the current tool mode.

**Returns:**
- string — The current tool mode.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetMode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L101)

---

### Tool:GetNormal · Shared
`Tool:GetNormal(id: number) → Vector`

Retrieves an normal vector previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- Vector — Associated normal vector with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetNormal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L85)

---

### Tool:GetOperation · Shared
`Tool:GetOperation() → number`

Returns the current operation of the tool set by [Tool:SetOperation](https://wiki.facepunch.com/gmod/Tool:SetOperation).

**Returns:**
- number — The current operation the tool is at.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetOperation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L28)

---

### Tool:GetOwner · Shared
`Tool:GetOwner() → Player`

Returns the owner of this tool.

**Returns:**
- Player — Player using the tool

[wiki](https://wiki.facepunch.com/gmod/Tool:GetOwner) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L120)

---

### Tool:GetPhys · Shared
`Tool:GetPhys(id: number) → PhysObj`

Retrieves an [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).
See also [Tool:GetEnt](https://wiki.facepunch.com/gmod/Tool:GetEnt).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- PhysObj — Associated PhysObj with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetPhys) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L100-L108)

---

### Tool:GetPos · Shared
`Tool:GetPos(id: number) → Vector`

Retrieves an vector previously stored using [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject). See also [Tool:GetLocalPos](https://wiki.facepunch.com/gmod/Tool:GetLocalPos).

**Arguments:**
- `id` (number) — The id of the object which was set in Tool:SetObject.

**Returns:**
- Vector — Associated vector with given id.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemode/sandbox/entities/weapons/gmod_tool/object.lua#L61)

---

### Tool:GetServerInfo · Shared
`Tool:GetServerInfo(name: string) → string`

Attempts to grab a serverside tool [ConVar](https://wiki.facepunch.com/gmod/ConVar).
This will not do anything on client, despite the function being defined shared.

**Arguments:**
- `name` (string) — Name of the convar to retrieve.

**Returns:**
- string — The value of the requested ConVar.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetServerInfo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool.lua#L59)

---

### Tool:GetStage · Shared
`Tool:GetStage() → number`

Returns the current stage of the tool set by [Tool:SetStage](https://wiki.facepunch.com/gmod/Tool:SetStage).

**Returns:**
- number — The current stage of the current operation the tool is at.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetStage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L16)

---

### Tool:GetSWEP · Shared · `DEPRECATED`
`Tool:GetSWEP() → Weapon`

Returns the Tool Gun (`gmod_tool`) Scripted [Weapon](https://wiki.facepunch.com/gmod/Weapon).

**Returns:**
- Weapon — The tool gun weapon.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetSWEP)

---

### Tool:GetWeapon · Shared
`Tool:GetWeapon() → Weapon`

Returns the Tool Gun (`gmod_tool`) Scripted [Weapon](https://wiki.facepunch.com/gmod/Weapon).

**Returns:**
- Weapon — The tool gun weapon.

[wiki](https://wiki.facepunch.com/gmod/Tool:GetWeapon)

---

### Tool:MakeGhostEntity · Shared
`Tool:MakeGhostEntity(model: string, pos: Vector, angle: Angle)`

Initializes the ghost entity with the given model. Removes any old ghost entity if called multiple times.

The ghost is a regular prop_physics entity in singleplayer games, and a clientside prop in multiplayer games.

**Arguments:**
- `model` (string) — The model of the new ghost entity
- `pos` (Vector) — Position to initialize the ghost entity at, usually not needed since this is updated in Tool:UpdateGhostEntity.
- `angle` (Angle) — Angle to initialize the ghost entity at, usually not needed since this is updated in Tool:UpdateGhostEntity.

[wiki](https://wiki.facepunch.com/gmod/Tool:MakeGhostEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/ghostentity.lua#L6)

---

### Tool:NumObjects · Shared
`Tool:NumObjects() → number`

Returns the amount of stored objects ( [Entity](https://wiki.facepunch.com/gmod/Entity)s ) the tool has.

**Returns:**
- number — The amount of stored objects, or Tool:GetStage clientide.

[wiki](https://wiki.facepunch.com/gmod/Tool:NumObjects) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L149)

---

### Tool:RebuildControlPanel · Client
`Tool:RebuildControlPanel(extra_args: vararg)`

Automatically forces the tool's control panel to be rebuilt.

**Arguments:**
- `extra_args` (vararg) — Any arguments given to this function will be added to TOOL.BuildCPanel's arguments.

[wiki](https://wiki.facepunch.com/gmod/Tool:RebuildControlPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stool_cl.lua#L12)

---

### Tool:ReleaseGhostEntity · Shared
`Tool:ReleaseGhostEntity()`

Removes any ghost entity created for this tool.

This is called automatically at various points, including when changing tools, holstering the toolgun, therefore it is a very good idea to implement this callback in your custom tool to cleanup any custom ghost entities.

[wiki](https://wiki.facepunch.com/gmod/Tool:ReleaseGhostEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/ghostentity.lua#L68)

---

### Tool:SetObject · Shared
`Tool:SetObject(id: number, ent: Entity, pos: Vector, phys: PhysObj, bone: number, normal: Vector)`

Stores an [Entity](https://wiki.facepunch.com/gmod/Entity) for later use in the tool.

The stored values can be retrieved by [Tool:GetEnt](https://wiki.facepunch.com/gmod/Tool:GetEnt), [Tool:GetPos](https://wiki.facepunch.com/gmod/Tool:GetPos), [Tool:GetLocalPos](https://wiki.facepunch.com/gmod/Tool:GetLocalPos), [Tool:GetPhys](https://wiki.facepunch.com/gmod/Tool:GetPhys), [Tool:GetBone](https://wiki.facepunch.com/gmod/Tool:GetBone) and [Tool:GetNormal](https://wiki.facepunch.com/gmod/Tool:GetNormal)

**Arguments:**
- `id` (number) — The id of the object to store.
- `ent` (Entity) — The entity to store.
- `pos` (Vector) — The position to store.
- `phys` (PhysObj) — The physics object to store.
- `bone` (number) — The hit bone to store.
- `normal` (Vector) — The hit normal to store.

[wiki](https://wiki.facepunch.com/gmod/Tool:SetObject) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L112)

---

### Tool:SetOperation · Shared
`Tool:SetOperation(operation: number)`

Sets the current operation of the tool. Does nothing clientside. See also [Tool:SetStage](https://wiki.facepunch.com/gmod/Tool:SetStage).

Operations and stages work as follows:
* Operation 1
* * Stage 1
* * Stage 2
* * Stage 3
* Operation 2
* * Stage 1
* * Stage 2
* * Stage ...

**Arguments:**
- `operation` (number) — The new operation ID to set.

[wiki](https://wiki.facepunch.com/gmod/Tool:SetOperation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L20)

---

### Tool:SetStage · Shared
`Tool:SetStage(stage: number)`

Sets the current stage of the tool. Does nothing clientside.

See also [Tool:SetOperation](https://wiki.facepunch.com/gmod/Tool:SetOperation).

**Arguments:**
- `stage` (number) — The new stage to set.

[wiki](https://wiki.facepunch.com/gmod/Tool:SetStage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod//gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L8-L14)

---

### Tool:StartGhostEntity · Shared
`Tool:StartGhostEntity(ent: Entity)`

Initializes the ghost entity based on the supplied entity.

**Arguments:**
- `ent` (Entity) — The entity to copy ghost parameters off

[wiki](https://wiki.facepunch.com/gmod/Tool:StartGhostEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/ghostentity.lua#L54)

---

### Tool:UpdateData · Shared · `INTERNAL`
`Tool:UpdateData()`

Sets the tool's stage to how many stored objects the tool has.

[wiki](https://wiki.facepunch.com/gmod/Tool:UpdateData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/object.lua#L2)

---

### Tool:UpdateGhostEntity · Shared
`Tool:UpdateGhostEntity()`

Updates the position and orientation of the ghost entity based on where the toolgun owner is looking along with data from object with id 1 set by [Tool:SetObject](https://wiki.facepunch.com/gmod/Tool:SetObject).

This should be called in the tool's [TOOL:Think](https://wiki.facepunch.com/gmod/TOOL:Think) hook.

This command is only used for tools that move props, such as easy weld, axis and motor. If you want to update a ghost like the thruster tool does it for example, check its [source code](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/stools/thruster.lua#L179).

[wiki](https://wiki.facepunch.com/gmod/Tool:UpdateGhostEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/weapons/gmod_tool/ghostentity.lua#L101)
