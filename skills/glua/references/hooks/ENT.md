# ENT

**Realm:** Shared  ·  **Members:** 81

A list of hooks **only** available for [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities).

The exceptions to this rule are documented at [Custom Entity Fields](https://wiki.facepunch.com/gmod/Custom%20Entity%20Fields), which can be applied to all entities.

Some more "hooks" are available for all entities (including engine entities) with the function [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback).

See also: [Structures/ENT](https://wiki.facepunch.com/gmod/Structures/ENT)

> **Note:** The hooks listed here are also dependent on the scripted entity type. For instance, a base scripted entity will not use [ENTITY:DoSchedule](https://wiki.facepunch.com/gmod/ENTITY:DoSchedule) at all, that is only for scripted NPCs

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `ENT` table: `function ENT:<Name>(...) end`. The `ENT:` prefix shown on each member below is the method form you write.

### ENT:AcceptInput · Server · `hook`
`ENT:AcceptInput(inputName: string, activator: Entity, caller: Entity, param: string) → boolean`

Called when another entity fires an event to this entity.

**Arguments:**
- `inputName` (string) — The name of the input that was triggered.
- `activator` (Entity) — The initial cause for the input getting triggered.
- `caller` (Entity) — The entity that directly triggered the input.
- `param` (string) — The input parameter.

**Returns:**
- boolean — Should we suppress the default action for this input?

[wiki](https://wiki.facepunch.com/gmod/ENTITY:AcceptInput)

---

### ENT:AddOutputFromAcceptInput · Server · `hook`
`ENT:AddOutputFromAcceptInput(name: string, data: string) → boolean`

A helper function for creating [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities).

Similar to [ENTITY:AddOutputFromKeyValue](https://wiki.facepunch.com/gmod/ENTITY:AddOutputFromKeyValue), call it from [ENTITY:AcceptInput](https://wiki.facepunch.com/gmod/ENTITY:AcceptInput) and it'll return true if it successfully added an output from the passed input data.

**Arguments:**
- `name` (string) — The input name from ENTITY:AcceptInput.
- `data` (string) — The input data from ENTITY:AcceptInput.

**Returns:**
- boolean — Whether any outputs were added or not.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:AddOutputFromAcceptInput)

---

### ENT:AddOutputFromKeyValue · Server · `hook`
`ENT:AddOutputFromKeyValue(key: string, value: string) → boolean`

A helper function for creating [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities).

Call it from [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue) and it'll return true if it successfully added an output from the passed KV pair.

**Arguments:**
- `key` (string) — The key-value key.
- `value` (string) — The key-value value.

**Returns:**
- boolean — Whether any outputs were added or not.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:AddOutputFromKeyValue)

---

### ENT:CalcAbsolutePosition · Shared · `hook`
`ENT:CalcAbsolutePosition(pos: Vector, ang: Angle) → Vector, Angle`

Called whenever the entity's position changes. A callback for when an entity's angle changes is available via [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback).

Like [ENTITY:RenderOverride](https://wiki.facepunch.com/gmod/ENTITY:RenderOverride), this hook works on any entity (scripted or not) it is applied on.

**Arguments:**
- `pos` (Vector) — The entity's actual position.
- `ang` (Angle) — The entity's actual angles.

**Returns:**
- Vector — New position
- Angle — New angles

> **Note:** The give concommand will call this hook serverside only upon entity spawn.
> **Note:** If EFL_DIRTY_ABSTRANSFORM is set on the entity, this will be called serverside only; otherwise, this will be called clientside only. This means serverside calls of [Entity:SetPos](https://wiki.facepunch.com/gmod/Entity:SetPos) without the EFL_DIRTY_ABSTRANSFORM flag enabled (most cases) will be called clientside only.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:CalcAbsolutePosition)

---

### ENT:CanEditVariables · Server · `hook`
`ENT:CanEditVariables(ply: Player) → boolean`

Called by the Sandbox gamemode from the default implementation of [GM:CanEditVariable](https://wiki.facepunch.com/gmod/GM:CanEditVariable).

**Arguments:**
- `ply` (Player) — The player is trying to edit a variable on this entity.

**Returns:**
- boolean — `true` to allow the edit, `false` to disallow.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:CanEditVariables)

---

### ENT:CanProperty · Shared · `hook`
`ENT:CanProperty(ply: Player, property: string) → boolean`

Controls if a property can be used on this entity or not.

This hook will only work in Sandbox derived gamemodes that do not have [GM:CanProperty](https://wiki.facepunch.com/gmod/GM:CanProperty) overridden.

**Arguments:**
- `ply` (Player) — Player, that tried to use the property
- `property` (string) — Class of the property that is tried to use, for example - bonemanipulate

**Returns:**
- boolean — Return false to disallow using that property, return true to allow.

> **Note:** This hook will work on ALL entities, not just the scripted ones (SENTs)

[wiki](https://wiki.facepunch.com/gmod/ENTITY:CanProperty) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/shared.lua#L239-L241)

---

### ENT:CanTool · Shared · `hook`
`ENT:CanTool(ply: Player, tr: table{TraceResult}, toolname: string, tool: table, button: number) → boolean`

Controls if a tool can be used on this entity or not.

This hook will only work in Sandbox derived gamemodes that do not have [SANDBOX:CanTool](https://wiki.facepunch.com/gmod/SANDBOX:CanTool) overridden.

**Arguments:**
- `ply` (Player) — Player, that tried to use the tool
- `tr` (table{TraceResult}) — The trace of the tool.
- `toolname` (string) — Class of the tool that is tried to use, for example - `weld`
- `tool` (table) — The tool mode table the player currently has selected.
- `button` (number) — The tool button pressed.

**Returns:**
- boolean — Return `false` to disallow using that tool on this entity, return `true` to allow.

> **Note:** This hook will work on ALL entities, not just the scripted ones (SENTs)

[wiki](https://wiki.facepunch.com/gmod/ENTITY:CanTool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/shared.lua#L73)

---

### ENT:CreateSchedulesInternal · Server · `hook` · `INTERNAL`
`ENT:CreateSchedulesInternal()`

Called just before [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize) for "ai" type entities only.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:CreateSchedulesInternal)

---

### ENT:DoImpactEffect · Shared · `hook`
`ENT:DoImpactEffect(tr: table, damageType: number) → boolean`

Called so the entity can override the bullet impact effects it makes. This is called when the entity itself fires bullets via [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets), not when it gets hit.

**Arguments:**
- `tr` (table) — A Structures/TraceResult from the bullet's start point to the impact point
- `damageType` (number, enum [DMG](https://wiki.facepunch.com/gmod/Enums/DMG)) — The damage type of bullet.

**Returns:**
- boolean — Return true to not do the default thing - which is to call `UTIL_ImpactTrace` in C++

> **Note:** This hook only works for the `anim` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:DoImpactEffect)

---

### ENT:DoingEngineSchedule · Server · `hook`
`ENT:DoingEngineSchedule() → boolean`

Called by the default `base_ai` SNPC, checking whether `ENT.bDoingEngineSchedule` is set by [ENTITY:StartEngineSchedule](https://wiki.facepunch.com/gmod/ENTITY:StartEngineSchedule)..

**Returns:**
- `ENT.bDoingEngineSchedule` (boolean)

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:DoingEngineSchedule) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L193)

---

### ENT:DoSchedule · Server · `hook`
`ENT:DoSchedule(sched: table)`

Runs a Lua schedule. Runs tasks inside the schedule.

**Arguments:**
- `sched` (table) — The schedule to run.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:DoSchedule) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L63)

---

### ENT:Draw · Client · `hook`
`ENT:Draw(flags: number)`

Called if and when the entity should be drawn opaquely, based on the [Entity:GetRenderGroup](https://wiki.facepunch.com/gmod/Entity:GetRenderGroup) of the entity.

See [Structures/ENT](https://wiki.facepunch.com/gmod/Structures/ENT) and [RENDERGROUP](https://wiki.facepunch.com/gmod/Enums/RENDERGROUP) for more information.

See also [ENTITY:DrawTranslucent](https://wiki.facepunch.com/gmod/ENTITY:DrawTranslucent).

**Arguments:**
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The bit flags from STUDIO

> **Note:** This function will not called if the entity's render bounds are not in player's view. See [Entity:SetRenderBounds](https://wiki.facepunch.com/gmod/Entity:SetRenderBounds).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:Draw)

---

### ENT:DrawTranslucent · Client · `hook`
`ENT:DrawTranslucent(flags: number)`

Called when the entity should be drawn translucently. If your scripted entity has a translucent model, it will be invisible unless it is drawn here.

See [ENTITY:Draw](https://wiki.facepunch.com/gmod/ENTITY:Draw) for the opaque rendering alternative to this hook.

**Arguments:**
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The bit flags from STUDIO

[wiki](https://wiki.facepunch.com/gmod/ENTITY:DrawTranslucent)

---

### ENT:EndTouch · Server · `hook`
`ENT:EndTouch(entity: Entity)`

Called when the entity stops touching another entity.

See [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch) and [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch) for related hooks.

**Arguments:**
- `entity` (Entity) — The entity that we no longer touch.

> **Warning:** This only works for **brush** entities and for entities that have [Entity:SetTrigger](https://wiki.facepunch.com/gmod/Entity:SetTrigger) set to true.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:EndTouch)

---

### ENT:EngineScheduleFinish · Server · `hook`
`ENT:EngineScheduleFinish()`

Called whenever an engine schedule is finished; either the last task within the engine schedule has been finished or the schedule has been interrupted by an interrupt condition.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).
> **Note:** This hook isn't called when the engine schedule is failed, the schedule is cleared with [NPC:ClearSchedule](https://wiki.facepunch.com/gmod/NPC:ClearSchedule) or [NPC:SetSchedule](https://wiki.facepunch.com/gmod/NPC:SetSchedule) has been called.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:EngineScheduleFinish)

---

### ENT:ExpressionFinished · Server · `hook`
`ENT:ExpressionFinished(strExp: string)`

Called when an NPC's expression has finished.

**Arguments:**
- `strExp` (string) — The path of the expression.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:ExpressionFinished) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/init.lua#L94)

---

### ENT:FireAnimationEvent · Client · `hook`
`ENT:FireAnimationEvent(pos: Vector, ang: Angle, event: number, name: string) → boolean`

Called before firing clientside animation events, such as muzzle flashes or shell ejections.

See [ENTITY:HandleAnimEvent](https://wiki.facepunch.com/gmod/ENTITY:HandleAnimEvent) for the serverside version.

**Arguments:**
- `pos` (Vector) — Position of the effect
- `ang` (Angle) — Angle of the effect
- `event` (number) — The event ID of happened even.
- `name` (string) — Name of the event

**Returns:**
- boolean — Return true to disable the effect

> **Note:** This hook only works on "anim", "nextbot" and "ai" type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:FireAnimationEvent)

---

### ENT:GetAttackSpread · Server · `hook`
`ENT:GetAttackSpread(wep: Weapon, target: NPC) → number`

Called to determine how good an NPC is at using a particular weapon.

**Arguments:**
- `wep` (Weapon) — The weapon being used by the NPC.
- `target` (NPC) — The target the NPC is attacking

**Returns:**
- number — The number of degrees of inaccuracy in the NPC's attack.

> **Note:** "ai" base only

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetAttackSpread) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/init.lua#L135)

---

### ENT:GetRelationship · Server · `hook`
`ENT:GetRelationship(ent: Entity) → number{D}`

Called when scripted NPC needs to check how he "feels" against another entity, such as when [NPC:Disposition](https://wiki.facepunch.com/gmod/NPC:Disposition) is called.

**Arguments:**
- `ent` (Entity) — The entity in question

**Returns:**
- number{D} — How our scripter NPC "feels" towards the entity in question.

> **Note:** Scripted NPCs will not select other entities using same [Entity:GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel) as this Scripted NPC's [Entity:GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel) as enemy, unless [NPC:AddEntityRelationship](https://wiki.facepunch.com/gmod/NPC:AddEntityRelationship) is cast.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetRelationship) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/init.lua#L84)

---

### ENT:GetRenderMesh · Client · `hook`
`ENT:GetRenderMesh() → table`

Specify a mesh that should be rendered instead of this SENT's model.

**Returns:**
- table — A table containing the following keys: * IMesh Mesh - (Required) The mesh to render instead of the default model * IMaterial Material - (Required) The material to render the mesh with.

> **Note:** You should not be creating or modifying an [IMesh](https://wiki.facepunch.com/gmod/IMesh) in this hook. [Reference](https://github.com/Facepunch/garrysmod-issues/issues/6411#issuecomment-3070608549)

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetRenderMesh)

---

### ENT:GetShadowCastDirection · Client · `hook`
`ENT:GetShadowCastDirection(type: number) → Vector`

Called when the shadow needs to be recomputed. Allows shadow angles to be customized. This only works for `anim` type entities.

**Arguments:**
- `type` (number) — Type of the shadow this entity uses.

**Returns:**
- `dir` (Vector) — The new shadow direction to use.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetShadowCastDirection)

---

### ENT:GetSoundInterests · Server · `hook`
`ENT:GetSoundInterests() → number`

Called every second to poll the sound hint interests of this SNPC. This is used in conjunction with other sound hint functions, such as [sound.EmitHint](https://wiki.facepunch.com/gmod/sound.EmitHint) and [NPC:GetBestSoundHint](https://wiki.facepunch.com/gmod/NPC:GetBestSoundHint).

**Returns:**
- `types` (number) — A bitflag representing which sound types this NPC wants to react to.

> **Note:** This hook only exists for `ai` type SENTs

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetSoundInterests)

---

### ENT:GravGunPickupAllowed · Server · `hook`
`ENT:GravGunPickupAllowed(ply: Player) → boolean`

Called by [GM:GravGunPickupAllowed](https://wiki.facepunch.com/gmod/GM:GravGunPickupAllowed) on ALL entites in Sandbox-derived  gamemodes and acts as an override.

**Arguments:**
- `ply` (Player) — The player aiming at us

**Returns:**
- boolean — Return true to allow the entity to be picked up

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GravGunPickupAllowed)

---

### ENT:GravGunPunt · Shared · `hook`
`ENT:GravGunPunt(ply: Player) → boolean`

Called when this entity is about to be punted with the gravity gun (primary fire).

Only works in Sandbox derived gamemodes and only if [GM:GravGunPunt](https://wiki.facepunch.com/gmod/GM:GravGunPunt) is not overridden.

**Arguments:**
- `ply` (Player) — The player pressing left-click with the gravity gun at an entity

**Returns:**
- boolean — Return true or false to enable or disable punting respectively.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GravGunPunt)

---

### ENT:HandleAnimEvent · Server · `hook`
`ENT:HandleAnimEvent(event: number, eventTime: number, cycle: number, type: number, options: string) → boolean`

Called before firing serverside animation events, such as weapon reload, drawing and holstering for NPCs, scripted sequences, etc.

See [ENTITY:FireAnimationEvent](https://wiki.facepunch.com/gmod/ENTITY:FireAnimationEvent) for the clientside version.

**Arguments:**
- `event` (number) — The ID of the event.
- `eventTime` (number) — The absolute time this event occurred using CurTime.
- `cycle` (number) — The frame this event occurred as a number between 0 and 1.
- `type` (number) — Event type.
- `options` (string) — Name or options of this event.

**Returns:**
- boolean — Return true to mark the event as handled.

> **Note:** This hook only works on "anim", "ai" and "nextbot" type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:HandleAnimEvent)

---

### ENT:ImpactTrace · Client · `hook`
`ENT:ImpactTrace(traceResult: table, damageType: number, customImpactName: string = nil) → boolean`

Called when a bullet trace hits this entity and allows you to override the default behavior by returning true.

**Arguments:**
- `traceResult` (table) — The trace that hit this entity as a Structures/TraceResult.
- `damageType` (number, enum [DMG](https://wiki.facepunch.com/gmod/Enums/DMG)) — The damage bits associated with the trace, see DMG
- `customImpactName` (string, default `nil`) — The effect name to override the impact effect with.

**Returns:**
- boolean — Return true to override the default impact effects.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:ImpactTrace)

---

### ENT:Initialize · Shared · `hook`
`ENT:Initialize()`

Called when the entity is created. This is called when you [Entity:Spawn](https://wiki.facepunch.com/gmod/Entity:Spawn) the custom entity.

This is called **after** [ENTITY:SetupDataTables](https://wiki.facepunch.com/gmod/ENTITY:SetupDataTables) and [GM:OnEntityCreated](https://wiki.facepunch.com/gmod/GM:OnEntityCreated).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:Initialize)

---

### ENT:IsJumpLegal · Server · `hook`
`ENT:IsJumpLegal(startPos: Vector, apex: Vector, endPos: Vector) → boolean`

Called when deciding if the Scripted NPC should be able to perform a certain jump or not.

**Arguments:**
- `startPos` (Vector) — Start of the jump
- `apex` (Vector) — Apex point of the jump
- `endPos` (Vector) — The landing position

**Returns:**
- boolean — Return true if this jump should be allowed to be performed, false otherwise.

> **Note:** This is only called for "ai" type entities

[wiki](https://wiki.facepunch.com/gmod/ENTITY:IsJumpLegal)

---

### ENT:KeyValue · Server · `hook`
`ENT:KeyValue(key: string, value: string) → boolean`

Called when the engine sets a value for this scripted entity.

This hook is called **before** [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize) when the key-values are set by the map.
Otherwise this hook will be called whenever [Entity:SetKeyValue](https://wiki.facepunch.com/gmod/Entity:SetKeyValue) is called on the entity.

See [GM:EntityKeyValue](https://wiki.facepunch.com/gmod/GM:EntityKeyValue) for a hook that works for all entities.

See [WEAPON:KeyValue](https://wiki.facepunch.com/gmod/WEAPON:KeyValue) for a hook that works for scripted weapons.

**Arguments:**
- `key` (string) — The key that was affected.
- `value` (string) — The new value.

**Returns:**
- boolean — Return true to suppress this KeyValue or return false or nothing to apply this key value.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:KeyValue)

---

### ENT:NextTask · Server · `hook`
`ENT:NextTask(sched: table)`

Start the next task in specific Lua schedule.

**Arguments:**
- `sched` (table) — The schedule to start next task in.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:NextTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L108)

---

### ENT:OnChangeActiveWeapon · Server · `hook`
`ENT:OnChangeActiveWeapon(old: Weapon, new: Weapon)`

Called when the currently active weapon of the SNPC changes.

**Arguments:**
- `old` (Weapon) — The previous active weapon.
- `new` (Weapon) — The new active weapon.

> **Note:** This hook only works on `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnChangeActiveWeapon)

---

### ENT:OnChangeActivity · Server · `hook`
`ENT:OnChangeActivity(act: number)`

Called when the NPC has changed its activity.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The new activity.

> **Note:** This hook only works for `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnChangeActivity)

---

### ENT:OnCondition · Server · `hook`
`ENT:OnCondition(conditionID: number)`

Called each time the NPC updates its condition.

**Arguments:**
- `conditionID` (number) — The ID of condition.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnCondition)

---

### ENT:OnDuplicated · Server · `hook`
`ENT:OnDuplicated(entTable: table)`

Called on any entity after it has been created by the [duplicator](https://wiki.facepunch.com/gmod/duplicator) and before any bone/entity modifiers have been applied.

This hook is called after [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize) and before [ENTITY:PostEntityPaste](https://wiki.facepunch.com/gmod/ENTITY:PostEntityPaste).

**Arguments:**
- `entTable` (table) — The stored data about the original entity that was duplicated.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnDuplicated)

---

### ENT:OnEntityCopyTableFinish · Server · `hook`
`ENT:OnEntityCopyTableFinish(data: table)`

Called after duplicator finishes saving the entity, allowing you to modify the save data.

This is called after [ENTITY:PostEntityCopy](https://wiki.facepunch.com/gmod/ENTITY:PostEntityCopy).

**Arguments:**
- `data` (table) — The save Structures/EntityCopyData that you can modify.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnEntityCopyTableFinish)

---

### ENT:OnMovementComplete · Server · `hook`
`ENT:OnMovementComplete()`

Called when the SNPC completes its movement to its destination.

> **Note:** This hook only works on `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnMovementComplete)

---

### ENT:OnMovementFailed · Server · `hook`
`ENT:OnMovementFailed()`

Called when the SNPC failed to move to its destination.

> **Note:** This hook only works on `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnMovementFailed)

---

### ENT:OnReloaded · Shared · `hook`
`ENT:OnReloaded()`

Called when the entity is reloaded by the lua auto-refresh system, i.e. when the developer edits the lua file for the entity while the game is running.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnReloaded)

---

### ENT:OnRemove · Shared · `hook`
`ENT:OnRemove(fullUpdate: boolean)`

Called when the entity is about to be removed.

See also [Entity:CallOnRemove](https://wiki.facepunch.com/gmod/Entity:CallOnRemove), which can even be used on engine (non-Lua) entities.

**Arguments:**
- `fullUpdate` (boolean) — Whether the removal is happening due to a full update clientside.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnRemove)

---

### ENT:OnRestore · Shared · `hook`
`ENT:OnRestore()`

Called when the entity is reloaded from a Source Engine save (not the Sandbox saves or dupes) or on a changelevel (for example Half-Life 2 campaign level transitions).

For the [duplicator](https://wiki.facepunch.com/gmod/duplicator) callbacks, see [ENTITY:OnDuplicated](https://wiki.facepunch.com/gmod/ENTITY:OnDuplicated).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnRestore)

---

### ENT:OnStateChange · Server · `hook`
`ENT:OnStateChange(oldState: number, newState: number)`

Called by the engine when NPC's state changes.

**Arguments:**
- `oldState` (number, enum [NPC_STATE](https://wiki.facepunch.com/gmod/Enums/NPC_STATE)) — The old state.
- `newState` (number, enum [NPC_STATE](https://wiki.facepunch.com/gmod/Enums/NPC_STATE)) — The new state.

> **Note:** This hook only exists for `ai` type SENTs.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnStateChange)

---

### ENT:OnTakeDamage · Server · `hook`
`ENT:OnTakeDamage(damage: CTakeDamageInfo) → number`

Called when the entity is taking damage.

**Arguments:**
- `damage` (CTakeDamageInfo) — The damage to be applied to the entity.

**Returns:**
- number — How much damage the entity took.

> **Note:** This hook is only called for `ai`, `nextbot` and `anim` type entities.
> **Warning:** Calling [Entity:TakeDamage](https://wiki.facepunch.com/gmod/Entity:TakeDamage), [Entity:TakeDamageInfo](https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo), [Entity:DispatchTraceAttack](https://wiki.facepunch.com/gmod/Entity:DispatchTraceAttack), or [Player:TraceHullAttack](https://wiki.facepunch.com/gmod/Player:TraceHullAttack) (if the entity is hit) in this hook on the victim entity can cause infinite loops since the hook will be called again. Make sure to setup recursion safeguards like the example below.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage)

---

### ENT:OnTaskComplete · Server · `hook`
`ENT:OnTaskComplete()`

Called from the engine when TaskComplete is called.
This allows us to move onto the next task - even when TaskComplete was called from an engine side task.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnTaskComplete)

---

### ENT:OnTaskFailed · Server · `hook`
`ENT:OnTaskFailed(failCode: number, failReason: string)`

Called when a task this NPC was running has failed for whatever reason.

**Arguments:**
- `failCode` (number) — The fail code for the task.
- `failReason` (string) — If set, a custom reason for the failure.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OnTaskFailed)

---

### ENT:OverrideMove · Server · `hook`
`ENT:OverrideMove(interval: number) → boolean`

Called to completely override NPC movement. This can be used for example for flying NPCs.

**Arguments:**
- `interval` (number) — Time interval for the movement, in seconds.

**Returns:**
- boolean — Return `true` to disable the default movement code.

> **Note:** This hook only exists for `ai` type SENTs.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OverrideMove)

---

### ENT:OverrideMoveFacing · Server · `hook`
`ENT:OverrideMoveFacing(interval: number, AILMG: table) → boolean`

Called to completely override the direction NPC will be facing during navigation.

**Arguments:**
- `interval` (number) — Time interval for the movement, in seconds.
- `AILMG` (table) — Extra data for the movement.

**Returns:**
- boolean — Return `true` to disable the default movement facing code.

> **Note:** This hook only exists for `ai` type SENTs.
> **Note:** This hook is called by the default movement hook. Returning `true` inside [ENTITY:OverrideMove](https://wiki.facepunch.com/gmod/ENTITY:OverrideMove) will prevent engine from calling this hook.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:OverrideMoveFacing)

---

### ENT:PassesTriggerFilters · Server · `hook`
`ENT:PassesTriggerFilters(ent: Entity) → boolean`

Polls whenever the entity should trigger the brush.

**Arguments:**
- `ent` (Entity) — The entity that is about to trigger.

**Returns:**
- boolean — Should trigger or not.

> **Warning:** This hook is broken and will not work without code below

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PassesTriggerFilters)

---

### ENT:PhysicsCollide · Server · `hook`
`ENT:PhysicsCollide(colData: table, collider: PhysObj)`

Called when the entity collides with anything via [physics objects](PhysObj). The [move type](Enums/MOVETYPE) and [solid mode](Enums/SOLID) must be `VPHYSICS` for the hook to be called.  
This hook only works for `anim` type entities.

This is different from [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch).

**Arguments:**
- `colData` (table) — Information regarding the collision.
- `collider` (PhysObj) — The physics object that collided.

> **Note:** If you want to use this hook on default/engine/non-Lua entities (like `prop_physics`), use [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback) instead! This page describes a hook for Lua scripted entities

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PhysicsCollide)

---

### ENT:PhysicsSimulate · Shared · `hook`
`ENT:PhysicsSimulate(phys: PhysObj, deltaTime: number) → Vector, Vector, number`

Called from the Entity's motion controller to simulate physics.

This will only be called after using [Entity:StartMotionController](https://wiki.facepunch.com/gmod/Entity:StartMotionController) on a [scripted entity](https://wiki.facepunch.com/gmod/Scripted_Entities) of `anim` type.

**Arguments:**
- `phys` (PhysObj) — The physics object of the entity.
- `deltaTime` (number) — Time since the last call.

**Returns:**
- Vector — Angular force.
- Vector — Linear force.
- number — One of the SIM.

> **Note:** This hook can work on the CLIENT if you call [Entity:StartMotionController](https://wiki.facepunch.com/gmod/Entity:StartMotionController) and use [Entity:AddToMotionController](https://wiki.facepunch.com/gmod/Entity:AddToMotionController) on the physics objects you want to control
> **Warning:** Do not use functions such as [PhysObj:EnableCollisions](https://wiki.facepunch.com/gmod/PhysObj:EnableCollisions) or [PhysObj:EnableGravity](https://wiki.facepunch.com/gmod/PhysObj:EnableGravity) in this hook as they're very likely to crash your game. You may want to use [ENTITY:PhysicsUpdate](https://wiki.facepunch.com/gmod/ENTITY:PhysicsUpdate) instead.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PhysicsSimulate)

---

### ENT:PhysicsUpdate · Shared · `hook`
`ENT:PhysicsUpdate(phys: PhysObj)`

Called whenever a physics object of this entity is updated.

This hook won't be called if the Entity's [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) goes asleep, or doesn't exist.

**Arguments:**
- `phys` (PhysObj) — The physics object of the entity.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PhysicsUpdate)

---

### ENT:PostEntityCopy · Server · `hook`
`ENT:PostEntityCopy()`

Called after the duplicator finished copying the entity.

See also [ENTITY:PreEntityCopy](https://wiki.facepunch.com/gmod/ENTITY:PreEntityCopy), [ENTITY:PostEntityPaste](https://wiki.facepunch.com/gmod/ENTITY:PostEntityPaste) and [ENTITY:OnEntityCopyTableFinish](https://wiki.facepunch.com/gmod/ENTITY:OnEntityCopyTableFinish).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PostEntityCopy)

---

### ENT:PostEntityPaste · Server · `hook`
`ENT:PostEntityPaste(ply: Player, ent: Entity, createdEntities: table)`

Called after the [duplicator](https://wiki.facepunch.com/gmod/duplicator) pastes the entity, after the bone/entity modifiers have been applied to the entity.

This hook is called after [ENTITY:OnDuplicated](https://wiki.facepunch.com/gmod/ENTITY:OnDuplicated). See also [ENTITY:PreEntityCopy](https://wiki.facepunch.com/gmod/ENTITY:PreEntityCopy).

**Arguments:**
- `ply` (Player) — The player who pasted the entity.
- `ent` (Entity) — The entity itself.
- `createdEntities` (table) — All entities that are within the placed dupe.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PostEntityPaste)

---

### ENT:PreEntityCopy · Server · `hook`
`ENT:PreEntityCopy()`

Called before the duplicator copies the entity.

If you are looking for a way to make the duplicator spawn another entity when duplicated. (For example, you duplicate a `prop_physics`, but you want the duplicator to spawn `prop_physics_my`), you should add `prop_physics.ClassOverride = "prop_physics_my"`. The duplication table should be also stored on that `prop_physics`, not on `prop_physics_my`.

See also [ENTITY:PostEntityCopy](https://wiki.facepunch.com/gmod/ENTITY:PostEntityCopy).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:PreEntityCopy)

---

### ENT:RenderOverride · Client · `hook`
`ENT:RenderOverride(flags: number)`

Called instead of the engine drawing function of the entity. This hook works on any entity (scripted or not) it is applied on.

This does not work on "physgun_beam", use [GM:DrawPhysgunBeam](https://wiki.facepunch.com/gmod/GM:DrawPhysgunBeam) instead.

**Arguments:**
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

> **Bug** ([#3292](https://github.com/Facepunch/garrysmod/issues/3292)): Drawing a viewmodel in this function will cause [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel), [WEAPON:PreDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PreDrawViewModel), [WEAPON:ViewModelDrawn](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn), [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel), and [WEAPON:PostDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PostDrawViewModel) to be called twice.
> **Bug** ([#3299](https://github.com/Facepunch/garrysmod/issues/3299)): This is called before PrePlayerDraw for players. If this function exists at all on a player, their worldmodel will always be rendered regardless of PrePlayerDraw's return.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:RenderOverride)

---

### ENT:ResolveCustomFlyCollision · Server · `hook` · `NEW`
`ENT:ResolveCustomFlyCollision(traceResult: table{TraceResult}, vel: vector) → boolean`

Called during a non-VPhysics collision event for flying entities. 

This is best used to make projectiles bounce off from surfaces in their own way. For this to be triggered, this entity must be the one that's colliding, have some velocity, [Entity:GetMoveType](https://wiki.facepunch.com/gmod/Entity:GetMoveType) must be either [MOVETYPE_FLY](https://wiki.facepunch.com/gmod/Enums/MOVETYPE#MOVETYPE_FLY) or [MOVETYPE_FLYGRAVITY](https://wiki.facepunch.com/gmod/Enums/MOVETYPE#MOVETYPE_FLYGRAVITY), and [Entity:GetMoveCollide](https://wiki.facepunch.com/gmod/Entity:GetMoveCollide) must be [MOVECOLLIDE_FLY_CUSTOM](https://wiki.facepunch.com/gmod/Enums/MOVECOLLIDE#MOVECOLLIDE_FLY_CUSTOM).

**Arguments:**
- `traceResult` (table{TraceResult}) — The Structures/TraceResult where the collision occured.
- `vel` (vector) — The calculated velocity after calculations such as bounciness, elasticity, ground sliding etc...

**Returns:**
- boolean — Return `true` to prevent default action.

> **Note:** This works only on `anim` type entities.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:ResolveCustomFlyCollision)

---

### ENT:RunAI · Server · `hook`
`ENT:RunAI() → boolean`

Called from the engine every [m_flNextDecisionTime](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/ai_basenpc.cpp#L3943C10-L3943C30) in seconds. This interval changes depending on NPC's [Efficiency](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/ai_basenpc.cpp#L3093). Returning `true` inside this hook will allow [CAI_BaseNPC::MaintainSchedule](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/ai_basenpc_schedule.cpp#L562) to also be called.

**Returns:**
- boolean — `true` to run engine schedules

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:RunAI) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L5)

---

### ENT:RunEngineTask · Server · `hook`
`ENT:RunEngineTask(taskID: number, taskData: number) → boolean`

Called when an engine task is ran on the entity.

**Arguments:**
- `taskID` (number) — The task ID, see ai_task.h
- `taskData` (number) — The task data.

**Returns:**
- boolean — true to prevent default action

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:RunEngineTask)

---

### ENT:RunTask · Server · `hook`
`ENT:RunTask(task: table)`

Called every think on running task.
The actual task function should tell us when the task is finished.

**Arguments:**
- `task` (table) — The task to run

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:RunTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L138)

---

### ENT:ScheduleFinished · Server · `hook`
`ENT:ScheduleFinished()`

Called whenever a Lua schedule is finished or [ENTITY:StartEngineSchedule](https://wiki.facepunch.com/gmod/ENTITY:StartEngineSchedule) is called. Clears out schedule and task data stored within NPC's table.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:ScheduleFinished) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L80)

---

### ENT:SelectSchedule · Server · `hook`
`ENT:SelectSchedule()`

Set the schedule we should be playing right now. Allows the NPC to start either a Lua schedule or an engine schedule. Despite sharing the same name as `CAI_BaseNPC::SelectSchedule()`, this isn't hooked to that function; this is called by Lua's [ENTITY:RunAI](https://wiki.facepunch.com/gmod/ENTITY:RunAI), doesn't return an engine function, returning an engine function doesn't help and doesn't make the NPC start an engine schedule. To alter initial engine schedule, it is recommended to use [ENTITY:TranslateSchedule](https://wiki.facepunch.com/gmod/ENTITY:TranslateSchedule).

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SelectSchedule) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L39)

---

### ENT:SetAutomaticFrameAdvance · Shared · `hook`
`ENT:SetAutomaticFrameAdvance(enable: boolean)`

Toggles automatic frame advancing for animated sequences on an entity.

This has the same effect as setting the ``ENT.AutomaticFrameAdvance`` property. (See [Structures/ENT](https://wiki.facepunch.com/gmod/Structures/ENT))

**Arguments:**
- `enable` (boolean) — Whether or not to set automatic frame advancing.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SetAutomaticFrameAdvance)

---

### ENT:SetTask · Server · `hook`
`ENT:SetTask(task: table)`

Sets the current task, to be used in a Lua schedule.

**Arguments:**
- `task` (table) — The task to set.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SetTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L93)

---

### ENT:SetupDataTables · Shared · `hook`
`ENT:SetupDataTables()`

Called when the entity should set up its [Data Tables](https://wiki.facepunch.com/gmod/Networking_Entities).

This is a much better option than using Set/Get Networked Values.

This hook is called after [GM:OnEntityCreated](https://wiki.facepunch.com/gmod/GM:OnEntityCreated) and [GM:NetworkEntityCreated](https://wiki.facepunch.com/gmod/GM:NetworkEntityCreated).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SetupDataTables)

---

### ENT:SpawnFunction · Server · `hook`
`ENT:SpawnFunction(ply: Player, tr: table, ClassName: string)`

This is the spawn function. It's called when a player spawns the entity from the spawnmenu.

If you want to make your SENT spawnable you need this function to properly create the entity.

**Arguments:**
- `ply` (Player) — The player that is spawning this SENT
- `tr` (table) — A Structures/TraceResult from player eyes to their aim position
- `ClassName` (string) — The classname of your entity

> **Warning:** Unlike other ENTITY functions, the "self" parameter of this function is not an entity but rather the table used to generate the SENT. This table is equivalent to [scripted_ents.GetStored](https://wiki.facepunch.com/gmod/scripted_ents.GetStored)("ent_name").

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SpawnFunction)

---

### ENT:StartEngineSchedule · Server · `hook`
`ENT:StartEngineSchedule(scheduleID: number)`

Called by the engine only whenever [NPC:SetSchedule](https://wiki.facepunch.com/gmod/NPC:SetSchedule) is called.

**Arguments:**
- `scheduleID` (number, enum [SCHED](https://wiki.facepunch.com/gmod/Enums/SCHED)) — Schedule ID to start.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StartEngineSchedule)

---

### ENT:StartEngineTask · Server · `hook`
`ENT:StartEngineTask(taskID: number, TaskData: number) → boolean`

Called when an engine task has been started on the entity.

**Arguments:**
- `taskID` (number) — Task ID to start, see ai_task.h
- `TaskData` (number) — Task data

**Returns:**
- boolean — true to stop default action

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StartEngineTask)

---

### ENT:StartSchedule · Server · `hook`
`ENT:StartSchedule(sched: Schedule)`

Starts a schedule previously created by [ai_schedule.New](https://wiki.facepunch.com/gmod/ai_schedule.New).

Not to be confused with [ENTITY:StartEngineSchedule](https://wiki.facepunch.com/gmod/ENTITY:StartEngineSchedule) or [NPC:SetSchedule](https://wiki.facepunch.com/gmod/NPC:SetSchedule) which start an Engine-based schedule.

**Arguments:**
- `sched` (Schedule) — Schedule to start.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StartSchedule) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L50)

---

### ENT:StartTask · Server · `hook`
`ENT:StartTask(task: Task)`

Called once when a LUA schedule has started a task.

**Arguments:**
- `task` (Task) — The task to start, created by ai_task.New.

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StartTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/schedules.lua#L129)

---

### ENT:StartTouch · Server · `hook`
`ENT:StartTouch(entity: Entity)`

Called when the entity starts touching another entity.

See [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch) and [ENTITY:EndTouch](https://wiki.facepunch.com/gmod/ENTITY:EndTouch) for related hooks.

**Arguments:**
- `entity` (Entity) — The entity that we started touching for the first time.

> **Warning:** This only works for **brush** entities and for entities that have [Entity:SetTrigger](https://wiki.facepunch.com/gmod/Entity:SetTrigger) set to true.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StartTouch)

---

### ENT:StoreOutput · Server · `hook`
`ENT:StoreOutput(name: string, info: string)`

Used to store an output so it can be triggered with [ENTITY:TriggerOutput](https://wiki.facepunch.com/gmod/ENTITY:TriggerOutput).
Outputs compiled into a map are passed to entities as key/value pairs through [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue).

TriggerOutput will do nothing if this function has not been called first.

**Arguments:**
- `name` (string) — Name of output to store
- `info` (string) — Output info

[wiki](https://wiki.facepunch.com/gmod/ENTITY:StoreOutput) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_entity/outputs.lua#L10-L28)

---

### ENT:TaskFinished · Server · `hook`
`ENT:TaskFinished() → boolean`

Returns true if the current running [Task](https://wiki.facepunch.com/gmod/Task) is finished. 
Tasks finish whenever [NPC:TaskComplete](https://wiki.facepunch.com/gmod/NPC:TaskComplete) is called, which sets `TASKSTATUS_COMPLETE` for all NPCs, also sets `self.bTaskComplete` for `ai` type [SENTs](Scripted_Entities).

**Returns:**
- boolean — Is the current running Task is finished or not.

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TaskFinished)

---

### ENT:TaskTime · Server · `hook`
`ENT:TaskTime() → number`

Returns how many seconds we've been doing this current task

**Returns:**
- number — How many seconds we've been doing this current task

> **Note:** This hook only exists for `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TaskTime)

---

### ENT:TestCollision · Shared · `hook`
`ENT:TestCollision(startpos: Vector, delta: Vector, isbox: boolean, extents: Vector, mask: number) → table`

Allows you to override trace result when a trace hits the entity.

Your entity **must** have [Entity:EnableCustomCollisions](https://wiki.facepunch.com/gmod/Entity:EnableCustomCollisions) enabled for this hook to work.

Your entity must also be otherwise "hit-able" with a trace, so it should have [SOLID_OBB](https://wiki.facepunch.com/gmod/Enums/SOLID#SOLID_OBB) or [SOLID_VPHYSICS](https://wiki.facepunch.com/gmod/Enums/SOLID#SOLID_VPHYSICS) be set (as an example), and it must have its [collision bounds](https://wiki.facepunch.com/gmod/Entity:SetCollisionBounds) be set accordingly.

**Arguments:**
- `startpos` (Vector) — Start position of the trace.
- `delta` (Vector) — Offset from startpos to the endpos of the trace.
- `isbox` (boolean) — Is the trace a hull trace?
- `extents` (Vector) — Size of the hull trace, with the center of the Bounding Box being `0, 0, 0`, so mins are `-extents`, and maxs are `extents`.
- `mask` (number, enum [CONTENTS](https://wiki.facepunch.com/gmod/Enums/CONTENTS)) — The CONTENTS mask.

**Returns:**
- table — Returning a `table` will allow you to override trace results.

> **Note:** This hook is called for `anim` type only.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TestCollision)

---

### ENT:Think · Shared · `hook`
`ENT:Think() → boolean`

Called every frame on the client.
Called about 5-6 times per second on the server.

**Returns:**
- boolean — Return `true` if you used Entity:NextThink to override the next execution time.

> **Note:** You may need to call [Entity:Spawn](https://wiki.facepunch.com/gmod/Entity:Spawn) to get this hook to run server side.
> 
> You can force it to run at servers tickrate using the example below.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:Think)

---

### ENT:Touch · Server · `hook`
`ENT:Touch(entity: Entity)`

Called every tick for every entity being "touched". Touching is usually detected via AABB intersection checks using entity's [collision bounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds).

Entities like triggers would be using the touch hooks for their function.

See [Entity:PhysicsCollide](https://wiki.facepunch.com/gmod/Entity:PhysicsCollide) for physics based collision events.

See also [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch) and [ENTITY:EndTouch](https://wiki.facepunch.com/gmod/ENTITY:EndTouch).

**Arguments:**
- `entity` (Entity) — The entity that touched it.

> **Note:** For physics enabled entities, this hook will **not** be ran while the entity's physics is asleep. See [PhysObj:Wake](https://wiki.facepunch.com/gmod/PhysObj:Wake).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:Touch)

---

### ENT:TranslateActivity · Server · `hook`
`ENT:TranslateActivity(oldAct: number{ACT}) → number{ACT}`

Called by the engine to alter NPC activities, if desired by the NPC.

**Arguments:**
- `oldAct` (number{ACT}) — The activity to translate.

**Returns:**
- `newAct` (number{ACT}) — The activity that should override the incoming activity.

> **Note:** This hook only exists for `ai` type SENTs.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TranslateActivity)

---

### ENT:TranslateNavGoal · Server · `hook`
`ENT:TranslateNavGoal(target: NPC|Entity = GetEnemy() or m_hGoalEnt, currentGoal: Vector = GetEnemyLastKnownPos() or m_hGoalEnt:GetPos()) → Vector`

Called by the engine to alter NPC's final position to reach its enemy or target. This is called twice for `GOALTYPE_PATHCORNER`; first is for the first path_corner and second for the next connected path_corner.

**Arguments:**
- `target` (NPC|Entity, default `GetEnemy() or m_hGoalEnt`) — The enemy being chased or the path_corner in query.
- `currentGoal` (Vector, default `GetEnemyLastKnownPos() or m_hGoalEnt:GetPos()`) — The target's origin.

**Returns:**
- Vector — The actual point that NPC will move to reach its enemy or target.

> **Note:** This hook only exists for `ai` type SENTs.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TranslateNavGoal)

---

### ENT:TranslateSchedule · Server · `hook`
`ENT:TranslateSchedule(schedule: number{SCHED}) → number{SCHED}`

Called by the engine to alter NPC schedules, if desired by the NPC.

**Arguments:**
- `schedule` (number{SCHED}) — The schedule to translate.

**Returns:**
- number{SCHED} — The schedule that should override the incoming schedule.

> **Note:** This hook only exists for `ai` type SENTs.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TranslateSchedule)

---

### ENT:TriggerOutput · Server · `hook`
`ENT:TriggerOutput(output: string, activator: Entity, data: string = nil)`

Triggers all outputs stored using [ENTITY:StoreOutput](https://wiki.facepunch.com/gmod/ENTITY:StoreOutput).

**Arguments:**
- `output` (string) — Name of output to fire
- `activator` (Entity) — Activator entity
- `data` (string, default `nil`) — The data to give to the output.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:TriggerOutput) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_entity/outputs.lua#L105-L123)

---

### ENT:UpdateTransmitState · Server · `hook`
`ENT:UpdateTransmitState() → number`

Called whenever the transmit state should be updated.

**Returns:**
- number — Transmit state to set, see TRANSMIT.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:UpdateTransmitState)

---

### ENT:Use · Server · `hook`
`ENT:Use(activator: Entity, caller: Entity, useType: number{USE}, value: number)`

Called when an entity "uses" this entity, for example a player pressing their `+use` key (default ) on this entity.

To change how often the hook is called, see [Entity:SetUseType](https://wiki.facepunch.com/gmod/Entity:SetUseType).

**Arguments:**
- `activator` (Entity) — The entity that caused this input.
- `caller` (Entity) — The entity responsible for the input.
- `useType` (number{USE}) — Use type, see USE.
- `value` (number) — Any passed value.

> **Note:** This hook only works for `nextbot`, `ai` and `anim` scripted entity types.

[wiki](https://wiki.facepunch.com/gmod/ENTITY:Use)
