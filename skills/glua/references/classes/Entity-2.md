# Entity

**Realm:** Shared  ·  **Members:** 557

This is a list of all available methods for all entities, which includes [Players](https://wiki.facepunch.com/gmod/Player), [Weapons](https://wiki.facepunch.com/gmod/Weapon), [NPCs](https://wiki.facepunch.com/gmod/NPC) and [Vehicles](https://wiki.facepunch.com/gmod/Vehicle).

For a list of possible members of [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities) see [ENT Structure](https://wiki.facepunch.com/gmod/Structures/ENT).

[wiki page](https://wiki.facepunch.com/gmod/Entity)

> **Part 2 of 3** (`GetNWVarTable` – `SetFriction`). All parts: [1](Entity.md), [2](Entity-2.md), [3](Entity-3.md)


### Entity:GetNWVarTable · Shared
`Entity:GetNWVarTable() → table<string,any>`

Returns all the networked variables in an entity.

**Returns:**
- table<string,any> — Key-Value table of all networked variables.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWVarTable)

---

### Entity:GetNWVector · Shared
`Entity:GetNWVector(key: string, fallback: any = Vector( 0, 0, 0 )) → any`

Retrieves a networked vector value at specified index on the entity that is set by [Entity:SetNWVector](https://wiki.facepunch.com/gmod/Entity:SetNWVector).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Vector( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWVector)

---

### Entity:GetOwner · Shared
`Entity:GetOwner() → Entity`

Returns the owner entity of this entity. See [Entity:SetOwner](https://wiki.facepunch.com/gmod/Entity:SetOwner) for more info.

**Returns:**
- Entity — The owner entity of this entity.

> **Note:** This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetOwner)

---

### Entity:GetParent · Shared
`Entity:GetParent() → Entity`

Returns the parent entity of this entity.

**Returns:**
- Entity — parentEntity

[wiki](https://wiki.facepunch.com/gmod/Entity:GetParent)

---

### Entity:GetParentAttachment · Shared
`Entity:GetParentAttachment() → number`

Returns the attachment/bone index of the entity's parent. Returns 0 if the entity is not parented to an attachment/bone or if it isn't parented at all.

This is set by second argument of [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent) or the **SetParentAttachment** input.

**Returns:**
- number — The parented attachment/bone index

[wiki](https://wiki.facepunch.com/gmod/Entity:GetParentAttachment)

---

### Entity:GetParentPhysNum · Shared
`Entity:GetParentPhysNum() → number`

If the entity is parented to an entity that has a model with multiple physics objects (like a ragdoll), this is used to retrieve what physics object number the entity is parented to on it's parent.

**Returns:**
- number — The physics object id, or nil if the entity has no parent

[wiki](https://wiki.facepunch.com/gmod/Entity:GetParentPhysNum)

---

### Entity:GetParentWorldTransformMatrix · Shared
`Entity:GetParentWorldTransformMatrix() → VMatrix`

Returns the position and angle of the entity's move parent as a 3x4 matrix ([VMatrix](https://wiki.facepunch.com/gmod/VMatrix) is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.

**Returns:**
- VMatrix — The position and angle matrix.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetParentWorldTransformMatrix)

---

### Entity:GetPersistent · Shared
`Entity:GetPersistent() → boolean`

Returns whether the entity is persistent or not.

See [Entity:SetPersistent](https://wiki.facepunch.com/gmod/Entity:SetPersistent) for more information on persistence.

**Returns:**
- boolean — True if the entity is set to be persistent.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPersistent)

---

### Entity:GetPhysicsAttacker · Server
`Entity:GetPhysicsAttacker(timeLimit: number = 1) → Player`

Returns player who is claiming kills of physics damage the entity deals.

**Arguments:**
- `timeLimit` (number, default `1`) — The time to check if the entity was still a proper physics attacker.

**Returns:**
- Player — The player.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPhysicsAttacker)

---

### Entity:GetPhysicsObject · Shared
`Entity:GetPhysicsObject() → PhysObj`

Returns the entity's physics object, if the entity has physics. Same as `ent:GetPhysicsObjectNum( 0 )`

**Returns:**
- PhysObj — The entity's physics object.

> **Note:** Entities don't have clientside physics objects by default, so this will return `[NULL PHYSOBJ]` on the client in most cases.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObject)

---

### Entity:GetPhysicsObjectCount · Shared
`Entity:GetPhysicsObjectCount() → number`

Returns the number of physics objects an entity has (usually 1 for non-ragdolls)

**Returns:**
- number — numObjects

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObjectCount)

---

### Entity:GetPhysicsObjectNum · Shared
`Entity:GetPhysicsObjectNum(physNum: number) → PhysObj`

Returns a specific physics object from an entity with multiple [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ects (like ragdolls)

See also [Entity:TranslateBoneToPhysBone](https://wiki.facepunch.com/gmod/Entity:TranslateBoneToPhysBone).

**Arguments:**
- `physNum` (number) — The number corresponding to the PhysObj to grab.

**Returns:**
- PhysObj — The physics object or nil if not found

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObjectNum)

---

### Entity:GetPlaybackRate · Shared
`Entity:GetPlaybackRate() → number`

Returns the playback rate of the main sequence on this entity, with 1.0 being the default speed.

**Returns:**
- number — The playback rate.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPlaybackRate)

---

### Entity:GetPos · Shared
`Entity:GetPos() → Vector`

Gets the position of given entity in the world.

See [Entity:GetLocalPos](https://wiki.facepunch.com/gmod/Entity:GetLocalPos) for the position relative to the entity's [Entity:GetParent](https://wiki.facepunch.com/gmod/Entity:GetParent).

**Returns:**
- Vector — The position of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPos)

---

### Entity:GetPoseParameter · Shared
`Entity:GetPoseParameter(name: string) → number`

Returns the pose parameter value

**Arguments:**
- `name` (string) — Pose parameter name to look up.

**Returns:**
- number — Value of given pose parameter.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPoseParameter)

---

### Entity:GetPoseParameterName · Shared
`Entity:GetPoseParameterName(id: number) → string`

Returns name of given pose parameter

**Arguments:**
- `id` (number) — Id of the pose paremeter

**Returns:**
- string — Name of given pose parameter

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPoseParameterName)

---

### Entity:GetPoseParameterRange · Shared
`Entity:GetPoseParameterRange(id: number) → number, number`

Returns pose parameter range

**Arguments:**
- `id` (number) — Pose parameter ID to look up.

**Returns:**
- number — The minimum value
- number — The maximum value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPoseParameterRange)

---

### Entity:GetPredictable · Client
`Entity:GetPredictable() → boolean`

Returns whether this entity is predictable or not.

See [Entity:SetPredictable](https://wiki.facepunch.com/gmod/Entity:SetPredictable) for more information

**Returns:**
- boolean — Whether this entity is predictable or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetPredictable)

---

### Entity:GetPreferredCarryAngles · Server
`Entity:GetPreferredCarryAngles(ply: Player) → Angle`

Called to override the preferred carry angles of this object.

**Arguments:**
- `ply` (Player) — The player who is holding the object.

**Returns:**
- Angle — Return an angle to override the carry angles.

> **Note:** This callback is only called for `anim` and `ai` type entities. For rest use [GM:GetPreferredCarryAngles](https://wiki.facepunch.com/gmod/GM:GetPreferredCarryAngles).

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetPreferredCarryAngles)

---

### Entity:GetRagdollOwner · Shared
`Entity:GetRagdollOwner() → Entity`

Returns the entity which the ragdoll came from. The opposite of [Player:GetRagdollEntity](https://wiki.facepunch.com/gmod/Player:GetRagdollEntity).

**Returns:**
- Entity — The entity who owns the ragdoll.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRagdollOwner)

---

### Entity:GetRenderAngles · Client
`Entity:GetRenderAngles() → Angle`

Returns the entity's render angles, set by [Entity:SetRenderAngles](https://wiki.facepunch.com/gmod/Entity:SetRenderAngles) in a drawing hook.

**Returns:**
- Angle — The entitys render angles

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderAngles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/entity.lua#L16)

---

### Entity:GetRenderBounds · Client
`Entity:GetRenderBounds() → Vector, Vector`

Returns render bounds of the entity as local vectors. Can be overridden by [Entity:SetRenderBounds](https://wiki.facepunch.com/gmod/Entity:SetRenderBounds).

If the render bounds are not inside players view, the entity will not be drawn!

**Returns:**
- Vector — The minimum vector of the bounds
- Vector — The maximum vector of the bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderBounds)

---

### Entity:GetRenderFX · Shared
`Entity:GetRenderFX() → number`

Returns current render FX of the entity.

**Returns:**
- number — The current render FX of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderFX)

---

### Entity:GetRenderGroup · Client
`Entity:GetRenderGroup() → number`

Returns the render group of the entity.

**Returns:**
- number — The render group.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderGroup)

---

### Entity:GetRenderMode · Shared
`Entity:GetRenderMode() → number`

Returns the render mode of the entity.

**Returns:**
- number — The render Mode.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderMode)

---

### Entity:GetRenderOrigin · Client
`Entity:GetRenderOrigin() → Vector`

Returns the entity's render origin, set by [Entity:SetRenderOrigin](https://wiki.facepunch.com/gmod/Entity:SetRenderOrigin) in a drawing hook.

**Returns:**
- Vector — The entitys render origin

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRenderOrigin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/entity.lua#L17)

---

### Entity:GetRight · Shared
`Entity:GetRight() → Vector`

Returns the rightward vector of the entity, as a normalized direction vector

**Returns:**
- Vector — rightDir

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRight)

---

### Entity:GetRotatedAABB · Shared
`Entity:GetRotatedAABB(min: Vector, max: Vector) → Vector, Vector`

Returns axis-aligned bounding box (AABB) of a orientated bounding box (OBB) based on entity's rotation.

**Arguments:**
- `min` (Vector) — Minimum extent of an OBB in local coordinates.
- `max` (Vector) — Maximum extent of an OBB in local coordinates.

**Returns:**
- Vector — Minimum extent of the AABB relative to entity's position.
- Vector — Maximum extent of the AABB relative to entity's position.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetRotatedAABB)

---

### Entity:GetSaveTable · Shared
`Entity:GetSaveTable(showAll: boolean = false) → table`

Returns a table of save values for an entity.

These tables are not the same between the client and the server, and different entities may have different fields.



You can get the list different fields an entity has by looking at it's source code (the 2013 SDK can be found [online](https://github.com/ValveSoftware/source-sdk-2013)). Accessible fields are defined by each `DEFINE_FIELD` and `DEFINE_KEYFIELD` inside the `DATADESC` block.

Take the headcrab, for example:

```lua
BEGIN_DATADESC( CBaseHeadcrab )
	// m_nGibCount - don't save
	DEFINE_FIELD( m_bHidden, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_flTimeDrown, FIELD_TIME ),
	DEFINE_FIELD( m_bCommittedToJump, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_vecCommittedJumpPos, FIELD_POSITION_VECTOR ),
	DEFINE_FIELD( m_flNextNPCThink, FIELD_TIME ),
	DEFINE_FIELD( m_flIgnoreWorldCollisionTime, FIELD_TIME ),
	
	DEFINE_KEYFIELD( m_bStartBurrowed, FIELD_BOOLEAN, "startburrowed" ),
	DEFINE_FIELD( m_bBurrowed, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_flBurrowTime, FIELD_TIME ),
	DEFINE_FIELD( m_nContext, FIELD_INTEGER ),
	DEFINE_FIELD( m_bCrawlFromCanister, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_bMidJump, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_nJumpFromCanisterDir, FIELD_INTEGER ),
	DEFINE_FIELD( m_bHangingFromCeiling, FIELD_BOOLEAN ),
	DEFINE_FIELD( m_flIlluminatedTime, FIELD_TIME ),
		
	DEFINE_INPUTFUNC( FIELD_VOID, "Burrow", InputBurrow ),
	DEFINE_INPUTFUNC( FIELD_VOID, "BurrowImmediate", InputBurrowImmediate ),
	DEFINE_INPUTFUNC( FIELD_VOID, "Unburrow", InputUnburrow ),
	DEFINE_INPUTFUNC( FIELD_VOID, "StartHangingFromCeiling", InputStartHangingFromCeiling ),
	DEFINE_INPUTFUNC( FIELD_VOID, "DropFromCeiling", InputDropFromCeiling ),
	
	// Function Pointers
	DEFINE_THINKFUNC( EliminateRollAndPitch ),
	DEFINE_THINKFUNC( ThrowThink ),
	DEFINE_ENTITYFUNC( LeapTouch ),
END_DATADESC()
```

* For each **DEFINE_FIELD**, the save table will have a key with name of **first** argument.
* For each **DEFINE_KEYFIELD**, the save table will have a key with name of the **third** argument.

**Arguments:**
- `showAll` (boolean, default `false`) — If set, shows all variables, not just the ones marked for save/load system.

**Returns:**
- table — A table containing all save values in key/value format.

> **Note:** It is highly recommended to use [Entity:GetInternalVariable](https://wiki.facepunch.com/gmod/Entity:GetInternalVariable) for retrieving a single key of the save table for performance reasons.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSaveTable)

---

### Entity:GetSequence · Shared
`Entity:GetSequence() → number`

Return the index of the model sequence that is currently active for the entity.

**Returns:**
- number — The index of the model sequence.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequence)

---

### Entity:GetSequenceActivity · Shared
`Entity:GetSequenceActivity(seq: number) → number`

Return activity id out of sequence id. Opposite of [Entity:SelectWeightedSequence](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequence).

**Arguments:**
- `seq` (number) — The sequence ID

**Returns:**
- number — The activity ID, ie ACT

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceActivity)

---

### Entity:GetSequenceActivityName · Shared
`Entity:GetSequenceActivityName(sequenceId: number) → string`

Returns the activity name for the given sequence id.

**Arguments:**
- `sequenceId` (number) — The sequence id.

**Returns:**
- string — The ACT as a string, returns "Not Found!" with an invalid sequence and "No model!" when no model is set.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceActivityName)

---

### Entity:GetSequenceCount · Shared
`Entity:GetSequenceCount() → number`

Returns the amount of sequences ( animations ) the entity's model has.

**Returns:**
- number — The amount of sequences ( animations ) the entity's model has.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceCount)

---

### Entity:GetSequenceGroundSpeed · Shared
`Entity:GetSequenceGroundSpeed(sequenceId: number) → number`

Returns the ground speed of the entity's sequence.

**Arguments:**
- `sequenceId` (number) — The sequence ID.

**Returns:**
- number — The ground speed of this sequence.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceGroundSpeed)

---

### Entity:GetSequenceInfo · Shared
`Entity:GetSequenceInfo(sequenceId: number) → table`

Returns a table of information about an entity's sequence.

**Arguments:**
- `sequenceId` (number) — The sequence id of the entity.

**Returns:**
- table — Table of information about the entity's sequence, or `nil` is ID is out of range.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceInfo)

---

### Entity:GetSequenceList · Shared
`Entity:GetSequenceList() → table`

Returns a list of all sequences ( animations ) the model has.

**Returns:**
- table — The list of all sequences ( animations ) the model has.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceList)

---

### Entity:GetSequenceMoveDist · Shared
`Entity:GetSequenceMoveDist(sequenceId: number) → number`

Returns an entity's sequence move distance (the change in position over the course of the entire sequence).

See [Entity:GetSequenceMovement](https://wiki.facepunch.com/gmod/Entity:GetSequenceMovement) for a similar function with more options.

**Arguments:**
- `sequenceId` (number) — The sequence index.

**Returns:**
- number — The move distance of the sequence.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceMoveDist)

---

### Entity:GetSequenceMovement · Shared
`Entity:GetSequenceMovement(sequenceId: number, startCycle: number = 0, endCyclnde: number = 1) → boolean, Vector, Angle`

Returns the delta movement and angles of a sequence of the entity's model.

**Arguments:**
- `sequenceId` (number) — The sequence index.
- `startCycle` (number, default `0`) — The sequence start cycle.
- `endCyclnde` (number, default `1`) — The sequence end cycle.

**Returns:**
- boolean — Whether the operation was successful
- Vector — The delta vector of the animation, how much the model's origin point moved.
- Angle — The delta angle of the animation.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceMovement)

---

### Entity:GetSequenceMoveYaw · Server
`Entity:GetSequenceMoveYaw(seq: number) → number`

Returns the change in heading direction in between the start and the end of the sequence.

**Arguments:**
- `seq` (number) — The sequence index.

**Returns:**
- number — The yaw delta.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceMoveYaw)

---

### Entity:GetSequenceName · Shared
`Entity:GetSequenceName(index: number) → string`

Return the name of the sequence for the index provided.
Refer to [Entity:GetSequence](https://wiki.facepunch.com/gmod/Entity:GetSequence) to find the current active sequence on this entity.

See [Entity:LookupSequence](https://wiki.facepunch.com/gmod/Entity:LookupSequence) for a function that does the opposite.

**Arguments:**
- `index` (number) — The index of the sequence to look up.

**Returns:**
- string — Name of the sequence, `"Unknown"` if it was out of bounds or `"Not Found!"` if -1 is provided.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceName)

---

### Entity:GetSequenceVelocity · Shared
`Entity:GetSequenceVelocity(sequenceId: number, cycle: number) → Vector`

Returns an entity's sequence velocity at given animation frame.

**Arguments:**
- `sequenceId` (number) — The sequence index.
- `cycle` (number) — The point in animation, from `0` to `1`.

**Returns:**
- Vector — Velocity of the sequence at given point in the animation.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSequenceVelocity)

---

### Entity:GetShouldPlayPickupSound · Shared
`Entity:GetShouldPlayPickupSound() → boolean`

Checks if the entity plays a sound when picked up by a player.

**Returns:**
- boolean — `true` if it plays the pickup sound, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetShouldPlayPickupSound) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L7-L9)

---

### Entity:GetShouldServerRagdoll · Shared
`Entity:GetShouldServerRagdoll() → boolean`

Returns if entity should create a server ragdoll on death or a client one.

**Returns:**
- boolean — Returns true if ragdoll will be created on server, false if on client

[wiki](https://wiki.facepunch.com/gmod/Entity:GetShouldServerRagdoll)

---

### Entity:GetSkin · Shared
`Entity:GetSkin() → number`

Returns the skin index of the current skin. Can be manipulated via [Entity:SetSkin](https://wiki.facepunch.com/gmod/Entity:SetSkin).

**Returns:**
- number — Current skin index.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSkin)

---

### Entity:GetSolid · Shared
`Entity:GetSolid() → number`

Returns solid type of an entity.

**Returns:**
- number — The solid type.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSolid)

---

### Entity:GetSolidFlags · Shared
`Entity:GetSolidFlags() → number{FSOLID}`

Returns solid flag(s) of an entity.

**Returns:**
- number{FSOLID} — The flag(s) of the entity, see FSOLID.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSolidFlags)

---

### Entity:GetSpawnEffect · Shared
`Entity:GetSpawnEffect() → boolean`

Returns if we should show a spawn effect on spawn on this entity.

**Returns:**
- boolean — The flag to allow or disallow the spawn effect.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSpawnEffect)

---

### Entity:GetSpawnFlags · Shared
`Entity:GetSpawnFlags() → number`

Returns the bitwise spawn flags used by the entity. These can be set by [Entity:SetKeyValue](https://wiki.facepunch.com/gmod/Entity:SetKeyValue).

**Returns:**
- number — The spawn flags of the entity, see SF_Enums.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSpawnFlags)

---

### Entity:GetSubMaterial · Shared
`Entity:GetSubMaterial(index: number) → string`

Returns the material override for the given index. 

Returns "" if no material override exists. Use [Entity:GetMaterials](https://wiki.facepunch.com/gmod/Entity:GetMaterials) to list it's default materials.

**Arguments:**
- `index` (number) — The index of the sub material.

**Returns:**
- string — The material that overrides this index, if any.

> **Bug** ([#3362](https://github.com/Facepunch/garrysmod/issues/3362)): The server's value takes priority on the client.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSubMaterial)

---

### Entity:GetSubModels · Shared
`Entity:GetSubModels() → table<table>`

Returns a list of models included into the entity's model in the .qc file.

**Returns:**
- table<table> — The list of models included into the entity's model in the .qc file.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSubModels)

---

### Entity:GetSurroundingBounds · Shared
`Entity:GetSurroundingBounds() → Vector, Vector`

Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box for hitbox detection. In most cases, this will return the same bounding box as [Entity:WorldSpaceAABB](https://wiki.facepunch.com/gmod/Entity:WorldSpaceAABB) unless it was changed by [Entity:SetSurroundingBounds](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBounds) or [Entity:SetSurroundingBoundsType](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBoundsType).

**Returns:**
- Vector — The minimum vector for the entity's bounding box in world space.
- Vector — The maximum vector for the entity's bounding box in world space.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetSurroundingBounds)

---

### Entity:GetTable · Shared
`Entity:GetTable() → table`

Returns a [table](https://wiki.facepunch.com/gmod/table) that contains all lua-based key-value pairs saved on the [Entity](https://wiki.facepunch.com/gmod/Entity).

		For retrieving engine-based key-value pairs, see [Entity:GetSaveTable](https://wiki.facepunch.com/gmod/Entity:GetSaveTable)

**Returns:**
- table — A table of the lua data stored on the Entity, or `nil` if the Entity is NULL.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetTable)

---

### Entity:GetTouchTrace · Shared
`Entity:GetTouchTrace() → table{TraceResult}`

Returns the last trace used in the collision callbacks such as [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch), [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch) and [ENTITY:EndTouch](https://wiki.facepunch.com/gmod/ENTITY:EndTouch).

**Returns:**
- table{TraceResult} — The Structures/TraceResult

> **Note:** This returns the last collision trace used, regardless of the entity that caused it. As such, it's only reliable when used in the hooks mentioned above

[wiki](https://wiki.facepunch.com/gmod/Entity:GetTouchTrace)

---

### Entity:GetTransmitWithParent · Shared
`Entity:GetTransmitWithParent() → boolean`

Returns true if the TransmitWithParent flag is set or not.

**Returns:**
- boolean — Is the TransmitWithParent flag is set or not

[wiki](https://wiki.facepunch.com/gmod/Entity:GetTransmitWithParent)

---

### Entity:GetUnFreezable · Server
`Entity:GetUnFreezable() → boolean`

Returns if the entity is unfreezable, meaning it can't be frozen with the physgun. By default props are freezable, so this function will typically return false.

**Returns:**
- boolean — True if the entity is unfreezable, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetUnFreezable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L590-L592)

---

### Entity:GetUp · Shared
`Entity:GetUp() → Vector`

Returns the upward vector of the entity, as a normalized direction vector

**Returns:**
- Vector — upDir

[wiki](https://wiki.facepunch.com/gmod/Entity:GetUp)

---

### Entity:GetVar · Shared
`Entity:GetVar(key: any, default: any = nil) → any`

Retrieves a value from entity's [Entity:GetTable](https://wiki.facepunch.com/gmod/Entity:GetTable). Set by [Entity:SetVar](https://wiki.facepunch.com/gmod/Entity:SetVar).

**Arguments:**
- `key` (any) — Key of the value to retrieve
- `default` (any, default `nil`) — A default value to fallback to if we couldn't retrieve the value from entity

**Returns:**
- any — Retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L45-L55)

---

### Entity:GetVelocity · Shared
`Entity:GetVelocity() → Vector`

Returns the entity's velocity.

This returns the total velocity of the entity and is equal to local velocity + base velocity.

Clientside the velocity may be estimated for certain entities, such as physics based entities, instead of returning the "real" velocity from the server.

**Returns:**
- Vector — The velocity of the entity.

> **Bug** ([#774](https://github.com/Facepunch/garrysmod/issues/774)): This can become out-of-sync on the client if the server has been up for a long time.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetVelocity)

---

### Entity:GetWorkshopID · Server · `DEPRECATED`
`Entity:GetWorkshopID() → number`

Returns ID of workshop addon that the entity is from.

**Returns:**
- number — The workshop ID

[wiki](https://wiki.facepunch.com/gmod/Entity:GetWorkshopID)

---

### Entity:GetWorldTransformMatrix · Shared
`Entity:GetWorldTransformMatrix() → VMatrix`

Returns the position and angle of the entity as a 3x4 matrix ([VMatrix](https://wiki.facepunch.com/gmod/VMatrix) is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.

**Returns:**
- VMatrix — The position and angle matrix.

> **Bug** ([#2764](https://github.com/Facepunch/garrysmod/issues/2764)): This returns incorrect results for the angular component (columns 1-3) for the local player clientside.
> **Bug** ([#3106](https://github.com/Facepunch/garrysmod/issues/3106)): This will use the local player's [EyeAngles](https://wiki.facepunch.com/gmod/Global.EyeAngles) in [rendering hooks](https://wiki.facepunch.com/gmod/3D_Rendering_Hooks).
> **Bug** ([#3107](https://github.com/Facepunch/garrysmod/issues/3107)): Columns 1-3 will be all 0 (angular component) in [rendering hooks](https://wiki.facepunch.com/gmod/3D_Rendering_Hooks) while paused in single-player.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetWorldTransformMatrix)

---

### Entity:GibBreakClient · Shared
`Entity:GibBreakClient(force: Vector, clr: Color = nil)`

Causes the entity to break into its current models gibs, if it has any.

You must call [Entity:PrecacheGibs](https://wiki.facepunch.com/gmod/Entity:PrecacheGibs) on the entity before using this function, or it will not create any gibs.

If called on server, the gibs will be spawned on the currently connected clients and will not be synchronized. Otherwise the gibs will be spawned only for the client the function is called on.

**Arguments:**
- `force` (Vector) — The force to apply to the created gibs.
- `clr` (Color, default `nil`) — If set, this will be color of the broken gibs instead of the entity's color.

> **Note:** this function will not remove or hide the entity it is called on.
> 	For more expensive version of this function see [Entity:GibBreakServer](https://wiki.facepunch.com/gmod/Entity:GibBreakServer).

[wiki](https://wiki.facepunch.com/gmod/Entity:GibBreakClient)

---

### Entity:GibBreakServer · Shared
`Entity:GibBreakServer(force: Vector)`

Causes the entity to break into its current models gibs, if it has any.

You must call [Entity:PrecacheGibs](https://wiki.facepunch.com/gmod/Entity:PrecacheGibs) on the entity before using this function, or it will not create any gibs.

The gibs will be spawned on the server and be synchronized with all clients.

Note, that this function will not remove or hide the entity it is called on.

This function is affected by `props_break_max_pieces_perframe`, `props_break_max_pieces`, `prop_active_gib_limit` and `prop_active_gib_max_fade_time` console variables.

**Arguments:**
- `force` (Vector) — The force to apply to the created gibs

> **Note:** Despite existing on client, it doesn't actually do anything on client.
> **Warning:** Large numbers of serverside gibs will cause lag.
> 
> You can avoid this cost by spawning the gibs on the client using [Entity:GibBreakClient](https://wiki.facepunch.com/gmod/Entity:GibBreakClient)

[wiki](https://wiki.facepunch.com/gmod/Entity:GibBreakServer)

---

### Entity:HasBoneManipulations · Shared
`Entity:HasBoneManipulations() → boolean`

Returns whether or not the bone manipulation functions have ever been called on given  entity.

Related functions are [Entity:ManipulateBonePosition](https://wiki.facepunch.com/gmod/Entity:ManipulateBonePosition), [Entity:ManipulateBoneAngles](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneAngles), [Entity:ManipulateBoneJiggle](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneJiggle), and [Entity:ManipulateBoneScale](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneScale).

**Returns:**
- boolean — True if the entity has been bone manipulated, false otherwise.

> **Bug** ([#3131](https://github.com/Facepunch/garrysmod/issues/3131)): This will return true if the entity's bones have ever been manipulated. Resetting the position/angles/jiggle/scaling to 0,0,0 will not affect this function.

[wiki](https://wiki.facepunch.com/gmod/Entity:HasBoneManipulations)

---

### Entity:HasFlexManipulatior · Shared
`Entity:HasFlexManipulatior() → boolean`

Returns whether or not the the entity has had flex manipulations performed with [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight) or [Entity:SetFlexScale](https://wiki.facepunch.com/gmod/Entity:SetFlexScale).

**Returns:**
- boolean — True if the entity has flex manipulations, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:HasFlexManipulatior)

---

### Entity:HasSpawnFlags · Shared
`Entity:HasSpawnFlags(spawnFlags: number) → boolean`

Returns whether this entity has the specified spawnflags bits set.

**Arguments:**
- `spawnFlags` (number, enum [SF](https://wiki.facepunch.com/gmod/Enums/SF)) — The spawnflag bits to check, see SF.

**Returns:**
- boolean — Whether the entity has that spawnflag set or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:HasSpawnFlags)

---

### Entity:HeadTarget · Server
`Entity:HeadTarget(origin: Vector) → Vector`

Returns the position of the head of this entity, NPCs use this internally to aim at their targets.

**Arguments:**
- `origin` (Vector) — The vector of where the attack comes from.

**Returns:**
- Vector — The head position.

> **Note:** This only works on players and NPCs.

[wiki](https://wiki.facepunch.com/gmod/Entity:HeadTarget)

---

### Entity:Health · Shared
`Entity:Health() → number`

Returns the health of the entity.

**Returns:**
- number — health

[wiki](https://wiki.facepunch.com/gmod/Entity:Health)

---

### Entity:Ignite · Server
`Entity:Ignite(length: number, radius: number = 0)`

Sets the entity on fire.

See also [Entity:Extinguish](https://wiki.facepunch.com/gmod/Entity:Extinguish).

**Arguments:**
- `length` (number) — How long to keep the entity ignited, in seconds.
- `radius` (number, default `0`) — The radius of the ignition, will ignite everything around the entity that is in this radius.

[wiki](https://wiki.facepunch.com/gmod/Entity:Ignite)

---

### Entity:InitializeAsClientEntity · Client · `DEPRECATED`
`Entity:InitializeAsClientEntity()`

Initializes this entity as being clientside only.

Only works on entities fully created clientside, and as such it currently has no use due to this being automatically called by [ents.CreateClientProp](https://wiki.facepunch.com/gmod/ents.CreateClientProp), [ents.CreateClientside](https://wiki.facepunch.com/gmod/ents.CreateClientside), [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel) and [ClientsideScene](https://wiki.facepunch.com/gmod/Global.ClientsideScene).

[wiki](https://wiki.facepunch.com/gmod/Entity:InitializeAsClientEntity)

---

### Entity:Input · Server
`Entity:Input(input: string, activator: Entity = nil, caller: Entity = nil, param: string|number|boolean = nil)`

Fires input to the entity with the ability to make another entity responsible, bypassing the event queue system.

You should only use this function over [Entity:Fire](https://wiki.facepunch.com/gmod/Entity:Fire) if you know what you are doing.

See [Entity:Fire](https://wiki.facepunch.com/gmod/Entity:Fire) for a function that conforms to the internal map IO event queue and [GM:AcceptInput](https://wiki.facepunch.com/gmod/GM:AcceptInput) for a hook that can intercept inputs.

**Arguments:**
- `input` (string) — The name of the input to fire
- `activator` (Entity, default `nil`) — The entity that caused this input (i.e.
- `caller` (Entity, default `nil`) — The entity that is triggering this input (i.e.
- `param` (string|number|boolean, default `nil`) — The value to give to the input.

[wiki](https://wiki.facepunch.com/gmod/Entity:Input)

---

### Entity:InstallDataTable · Shared · `INTERNAL`
`Entity:InstallDataTable()`

Sets up Data Tables from entity to use with [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar).

[wiki](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L217-L590)

---

### Entity:InvalidateBoneCache · Client
`Entity:InvalidateBoneCache()`

Resets the entity's bone cache values in order to prepare for a model change.

This should be called after calling [Entity:SetPoseParameter](https://wiki.facepunch.com/gmod/Entity:SetPoseParameter).

[wiki](https://wiki.facepunch.com/gmod/Entity:InvalidateBoneCache)

---

### Entity:IsConstrained · Shared
`Entity:IsConstrained() → boolean`

Returns true if the entity has constraints attached to it

**Returns:**
- boolean — Whether the entity is constrained or not.

> **Bug** ([#3837](https://github.com/Facepunch/garrysmod/issues/3837)): This will only update clientside if the server calls it first. This only checks constraints added through the [constraint](https://wiki.facepunch.com/gmod/constraint) so this will not react to map constraints.
> 
> For a serverside alternative, see [constraint.HasConstraints](https://wiki.facepunch.com/gmod/constraint.HasConstraints)

[wiki](https://wiki.facepunch.com/gmod/Entity:IsConstrained) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L75-L97)

---

### Entity:IsConstraint · Server
`Entity:IsConstraint() → boolean`

Returns if entity is constraint or not.

This also means that [Entity:GetConstrainedPhysObjects](https://wiki.facepunch.com/gmod/Entity:GetConstrainedPhysObjects). [Entity:GetConstrainedEntities](https://wiki.facepunch.com/gmod/Entity:GetConstrainedEntities) and  [Entity:SetPhysConstraintObjects](https://wiki.facepunch.com/gmod/Entity:SetPhysConstraintObjects) can be used on this entity.

**Returns:**
- boolean — Is the entity a constraint or not

> **Warning:** For some constraint entities, such as `phys_spring`, `phys_slideconstraint`, `phys_torque` and `logic_collision_pair`, this function will return `false`!

[wiki](https://wiki.facepunch.com/gmod/Entity:IsConstraint)

---

### Entity:IsDormant · Shared
`Entity:IsDormant() → boolean`

Returns whether the entity is dormant or not.

Client/server entities become dormant when they leave the PVS on the server. Client side entities can decide for themselves whether to become dormant.   
This mainly applies to [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community").

**Returns:**
- boolean — Whether the entity is dormant or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsDormant)

---

### Entity:IsEffectActive · Shared
`Entity:IsEffectActive(effect: number{EF}) → boolean`

Returns whether an entity has engine effect applied or not.

**Arguments:**
- `effect` (number{EF}) — The effect to check for, see EF.

**Returns:**
- boolean — Whether the entity has the engine effect applied or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsEffectActive)

---

### Entity:IsEFlagSet · Shared
`Entity:IsEFlagSet(flag: number{EFL}) → boolean`

Checks if given flag is set or not.

**Arguments:**
- `flag` (number{EFL}) — The engine flag to test, see EFL

**Returns:**
- boolean — Is set or not

[wiki](https://wiki.facepunch.com/gmod/Entity:IsEFlagSet)

---

### Entity:IsFlagSet · Shared
`Entity:IsFlagSet(flag: number{FL}) → boolean`

Checks if given flag(s) is set or not.

**Arguments:**
- `flag` (number{FL}) — The engine flag(s) to test, see FL

**Returns:**
- boolean — Is set or not

[wiki](https://wiki.facepunch.com/gmod/Entity:IsFlagSet)

---

### Entity:IsInWorld · Server
`Entity:IsInWorld() → boolean`

Returns whether the entity is in the world (not inside a wall or outside of the map).

**Returns:**
- boolean — False if the entity is inside a wall or outside of the map, true otherwise.

> **Note:** Internally this function uses [util.IsInWorld](https://wiki.facepunch.com/gmod/util.IsInWorld), that means that this function only checks [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos) of the entity. If an entity is only partially inside a wall, or has a weird GetPos offset, this function may not give reliable output.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsInWorld)

---

### Entity:IsLagCompensated · Server
`Entity:IsLagCompensated() → boolean`

Returns whether the entity is lag compensated or not.

**Returns:**
- boolean — Whether the entity is lag compensated or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsLagCompensated)

---

### Entity:IsLineOfSightClear · Shared
`Entity:IsLineOfSightClear(target: Vector) → boolean`

Returns true if the target is in line of sight.

**Arguments:**
- `target` (Vector) — The target to test.

**Returns:**
- boolean — Returns true if the line of sight is clear

> **Note:** This will only work when called on CBaseCombatCharacter entities. This includes players, NPCs, grenades, RPG rockets, crossbow bolts, and physics cannisters.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsLineOfSightClear)

---

### Entity:IsMarkedForDeletion · Shared
`Entity:IsMarkedForDeletion() → boolean`

Determines if a given Entity is going to be removed at the start of the next tick.

		This will return `true` for an [Entity](https://wiki.facepunch.com/gmod/Entity) after [Entity:Remove](https://wiki.facepunch.com/gmod/Entity:Remove) is called on it.

**Returns:**
- boolean — `true` if the Entity is going to be removed, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsMarkedForDeletion)

---

### Entity:IsNextBot · Shared
`Entity:IsNextBot() → boolean`

Checks if the entity is a [NextBot](https://wiki.facepunch.com/gmod/NextBot) or not.

**Returns:**
- boolean — Whether the entity is an NextBot entity or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsNextBot)

---

### Entity:IsNPC · Shared
`Entity:IsNPC() → boolean`

Checks if the entity is an [NPC](https://wiki.facepunch.com/gmod/NPC) or not.

This will return false for [NextBot](https://wiki.facepunch.com/gmod/NextBot)s, see [Entity:IsNextBot](https://wiki.facepunch.com/gmod/Entity:IsNextBot) for that.

**Returns:**
- boolean — Whether the entity is an NPC.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsNPC)

---

### Entity:IsOnFire · Shared
`Entity:IsOnFire() → boolean`

Returns whether the entity is on fire.

**Returns:**
- boolean — Whether the entity is on fire or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsOnFire)

---

### Entity:IsOnGround · Shared
`Entity:IsOnGround() → boolean`

Returns whether the entity is on ground or not.

Internally, this checks if [FL_ONGROUND](https://wiki.facepunch.com/gmod/Enums/FL) is set on the entity.

This function is an alias of [Entity:OnGround](https://wiki.facepunch.com/gmod/Entity:OnGround).

**Returns:**
- boolean — Whether the entity is on ground or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsOnGround)

---

### Entity:IsPlayer · Shared
`Entity:IsPlayer() → boolean`

Checks if the entity is a player or not.

**Returns:**
- boolean — Whether the entity is a player.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsPlayer)

---

### Entity:IsPlayerHolding · Server
`Entity:IsPlayerHolding() → boolean`

Returns true if the entity is being held by a player. Either by physics gun, gravity gun or use-key (+use).

**Returns:**
- boolean — IsBeingHeld

> **Bug** ([#2046](https://github.com/Facepunch/garrysmod/issues/2046)): If multiple players are holding an object and one drops it, this will return false despite the object still being held.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsPlayerHolding)

---

### Entity:IsPlayingGesture · Server
`Entity:IsPlayingGesture(activity: number) → boolean`

Returns whether there's a gesture with the given activity being played.

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity to test.

**Returns:**
- boolean — Whether there's a gesture is given activity being played.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:IsPlayingGesture)

---

### Entity:IsPointInBounds · Shared
`Entity:IsPointInBounds(point: Vector) → boolean`

Returns whether a given point is within the entity's Orientated Bounding Box.

This relies on the entity having a collision mesh (not a physics object) and will be affected by `SOLID_NONE`.

**Arguments:**
- `point` (Vector) — The point to test, in world space coordinates.

**Returns:**
- boolean — Whether the point is within the entity's bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsPointInBounds)

---

### Entity:IsRagdoll · Shared
`Entity:IsRagdoll() → boolean`

Checks if the entity is a ragdoll, or became a ragdoll. Internally checks whether [kRenderFXRagdoll](kRenderFX) is set.

**Returns:**
- boolean — Is ragdoll or not

[wiki](https://wiki.facepunch.com/gmod/Entity:IsRagdoll)

---

### Entity:IsScripted · Shared
`Entity:IsScripted() → boolean`

Checks if the entity is a SENT or a built-in entity.

**Returns:**
- boolean — Returns true if entity is scripted ( SENT ), false if not ( A built-in engine entity )

[wiki](https://wiki.facepunch.com/gmod/Entity:IsScripted)

---

### Entity:IsSequenceFinished · Shared
`Entity:IsSequenceFinished() → boolean`

Returns whether the entity's current sequence is finished or not.

**Returns:**
- boolean — Whether the entity's sequence is finished or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsSequenceFinished)

---

### Entity:IsSolid · Shared
`Entity:IsSolid() → boolean`

Returns if the entity is solid or not.
Very useful for determining if the entity is a trigger or not.

**Returns:**
- boolean — Whether the entity is solid or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsSolid)

---

### Entity:IsValid · Shared
`Entity:IsValid() → boolean`

Returns whether the entity is a valid entity or not.

An entity is valid if:
* It is not a [NULL](https://wiki.facepunch.com/gmod/Global_Variables) entity
* It is not the worldspawn entity ([game.GetWorld](https://wiki.facepunch.com/gmod/game.GetWorld))



It will check whether the given variable contains an object (an Entity) or nothing at all for you. See examples.


This might be a cause for a lot of headache. Usually happening during networking etc., when completely valid entities suddenly become invalid on the client, but are never filtered with IsValid(). See [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) for more details.

**Returns:**
- boolean — true if the entity is valid, false otherwise

> **Note:** Instead of calling this method directly, it's a good idea to call the global [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid) instead, however if you're sure the variable you're using is always an entity object it's better to use this method
> **Warning:** NULL entities can still be assigned with key/value pairs, but they will be instantly negated. See example 3

[wiki](https://wiki.facepunch.com/gmod/Entity:IsValid)

---

### Entity:IsValidLayer · Shared
`Entity:IsValidLayer(layerID: number) → boolean`

Returns whether the given layer ID is valid and exists on this entity.

**Arguments:**
- `layerID` (number) — The Layer ID

**Returns:**
- boolean — Whether the given layer ID is valid and exists on this entity.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsValidLayer)

---

### Entity:IsVehicle · Shared
`Entity:IsVehicle() → boolean`

Checks if the entity is a vehicle or not.

**Returns:**
- boolean — Whether the entity is a vehicle.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsVehicle)

---

### Entity:IsWeapon · Shared
`Entity:IsWeapon() → boolean`

Checks if the entity is a weapon or not.

**Returns:**
- boolean — Whether the entity is a weapon

[wiki](https://wiki.facepunch.com/gmod/Entity:IsWeapon)

---

### Entity:IsWidget · Shared
`Entity:IsWidget() → boolean`

Returns whether the entity is a widget or not.

This is used by the "Edit Bones" context menu property.

**Returns:**
- boolean — Whether the entity is a widget or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsWidget) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/widget.lua#L161)

---

### Entity:IsWorld · Shared
`Entity:IsWorld() → boolean`

Returns if this entity is the map entity `Entity[0] worldspawn`.

**Returns:**
- boolean — Whether this entity is the world entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:IsWorld)

---

### Entity:LocalToWorld · Shared
`Entity:LocalToWorld(lpos: Vector) → Vector`

Translates a vector relative to the entity's coordinate system into a worldspace vector.

**Arguments:**
- `lpos` (Vector) — A local space vector.

**Returns:**
- Vector — The corresponding worldspace vector.

[wiki](https://wiki.facepunch.com/gmod/Entity:LocalToWorld)

---

### Entity:LocalToWorldAngles · Shared
`Entity:LocalToWorldAngles(ang: Angle) → Angle`

Translates an angle relative to the entity's coordinate system to a worldspace angle.

**Arguments:**
- `ang` (Angle) — A local space angle.

**Returns:**
- Angle — The corresponding worldspace angle.

[wiki](https://wiki.facepunch.com/gmod/Entity:LocalToWorldAngles)

---

### Entity:LookupAttachment · Shared
`Entity:LookupAttachment(attachmentName: string) → number`

Returns the attachment index of the given attachment name.

**Arguments:**
- `attachmentName` (string) — The name of the attachment.

**Returns:**
- number — The attachment index, or 0 if the attachment does not exist and -1 if the model is invalid.

[wiki](https://wiki.facepunch.com/gmod/Entity:LookupAttachment)

---

### Entity:LookupBone · Shared
`Entity:LookupBone(boneName: string) → number|nil`

Gets the bone index of the given bone name, returns `nil` if the bone does not exist. 


See [Entity:GetBoneName](https://wiki.facepunch.com/gmod/Entity:GetBoneName) for the inverse of this function.

**Arguments:**
- `boneName` (string) — The name of the bone.

**Returns:**
- number|nil — Index of the given bone name, or `nil` if the bone doesn't exist on the Entity.

> **Note:** When called on [Weapon](https://wiki.facepunch.com/gmod/Weapon)s equipped by any Player, this will return their viewmodel's bone index instead of worldmodel.

[wiki](https://wiki.facepunch.com/gmod/Entity:LookupBone)

---

### Entity:LookupPoseParameter · Shared
`Entity:LookupPoseParameter(name: string) → number`

Returns pose parameter ID from its name.

**Arguments:**
- `name` (string) — Pose parameter name

**Returns:**
- number — The ID of the given pose parameter name, if it exists, -1 otherwise

[wiki](https://wiki.facepunch.com/gmod/Entity:LookupPoseParameter)

---

### Entity:LookupSequence · Shared
`Entity:LookupSequence(name: string) → number, number`

Returns sequence ID from either sequence name or activity name. See [Entity:GetSequenceName](https://wiki.facepunch.com/gmod/Entity:GetSequenceName) for a function that does the opposite.

**Sequences** are animations tied to a specific model. Different models can have sequences with same names, but have different IDs.  
Sequences can also be tied to certain activities ([ACT](https://wiki.facepunch.com/gmod/Enums/ACT)), see [Entity:SelectWeightedSequence](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequence).

**Arguments:**
- `name` (string) — Sequence name.

**Returns:**
- number — Sequence ID for that name.
- number — The sequence duration, or `0` if the sequence is invalid or there's no sequence with given name on entity's current model.

[wiki](https://wiki.facepunch.com/gmod/Entity:LookupSequence)

---

### Entity:MakePhysicsObjectAShadow · Shared
`Entity:MakePhysicsObjectAShadow(allowPhysicsMovement: boolean = true, allowPhysicsRotation: boolean = true)`

Turns the [Entity:GetPhysicsObject](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObject) into a physics shadow.
It's used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.

A physics shadow can be used to have static entities that never move by setting both arguments to false.

**Arguments:**
- `allowPhysicsMovement` (boolean, default `true`) — Whether to allow the physics shadow to move under stress.
- `allowPhysicsRotation` (boolean, default `true`) — Whether to allow the physics shadow to rotate under stress.

> **Note:** Unlike [Entity:PhysicsInitShadow](https://wiki.facepunch.com/gmod/Entity:PhysicsInitShadow), this function doesn't remove the current physics object.

[wiki](https://wiki.facepunch.com/gmod/Entity:MakePhysicsObjectAShadow)

---

### Entity:ManipulateBoneAngles · Shared
`Entity:ManipulateBoneAngles(boneID: number, ang: Angle, networking: boolean = true)`

Sets custom bone angles.

**Arguments:**
- `boneID` (number) — Index of the bone you want to manipulate
- `ang` (Angle) — Angle to apply.
- `networking` (boolean, default `true`) — boolean to network these changes (if called from server)

> **Bug** ([#5148](https://github.com/Facepunch/garrysmod/issues/5148)): When used repeatedly serverside, this method is strongly discouraged due to the huge network traffic produced
> 
> As of update `2024.10.29` this has been resolved. However, network traffic is still generated and should be taken into consideration.

[wiki](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneAngles)

---

### Entity:ManipulateBoneJiggle · Shared
`Entity:ManipulateBoneJiggle(boneID: number, type: number)`

Manipulates the bone's jiggle status. This allows non jiggly bones to become jiggly.

**Arguments:**
- `boneID` (number) — Index of the bone you want to manipulate.
- `type` (number) — The jiggle bone type.

[wiki](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneJiggle)

---

### Entity:ManipulateBonePosition · Shared
`Entity:ManipulateBonePosition(boneID: number, pos: Vector, networking: boolean = true)`

Sets custom bone offsets.

**Arguments:**
- `boneID` (number) — Index of the bone you want to manipulate.
- `pos` (Vector) — Position vector to apply.
- `networking` (boolean, default `true`) — boolean to network these changes (if called from server)

[wiki](https://wiki.facepunch.com/gmod/Entity:ManipulateBonePosition)

---

### Entity:ManipulateBoneScale · Shared
`Entity:ManipulateBoneScale(boneID: number, scale: Vector)`

Sets custom bone scale.

**Arguments:**
- `boneID` (number) — Index of the bone you want to manipulate
- `scale` (Vector) — Scale vector to apply.

> **Note:** This silently fails when given a Vector with nan values, hiding the vertices associated with the bone. See example below.
> **Bug** ([#3502](https://github.com/Facepunch/garrysmod/issues/3502)): This does not scale procedural bones.

[wiki](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneScale)

---

### Entity:MapCreationID · Shared
`Entity:MapCreationID() → number`

Returns entity's map creation ID. Unlike [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex) or [Entity:GetCreationID](https://wiki.facepunch.com/gmod/Entity:GetCreationID), it will always be the same on same map, no matter how much you clean up or restart it.

It may change if the map is recompiled, even if no edits were made. It will definitely change if entities are added or removed from the map file.

To be used in conjunction with [ents.GetMapCreatedEntity](https://wiki.facepunch.com/gmod/ents.GetMapCreatedEntity). See also [Entity:CreatedByMap](https://wiki.facepunch.com/gmod/Entity:CreatedByMap).

**Returns:**
- number — The map creation ID or -1 if the entity is not compiled into the map.

[wiki](https://wiki.facepunch.com/gmod/Entity:MapCreationID)

---

### Entity:MarkShadowAsDirty · Client
`Entity:MarkShadowAsDirty()`

Refreshes the shadow of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:MarkShadowAsDirty)

---

### Entity:MuzzleFlash · Shared
`Entity:MuzzleFlash()`

Fires the muzzle flash effect of the weapon the entity is carrying. This only creates a light effect and is often called alongside [Weapon:SendWeaponAnim](https://wiki.facepunch.com/gmod/Weapon:SendWeaponAnim)

[wiki](https://wiki.facepunch.com/gmod/Entity:MuzzleFlash)

---

### Entity:NearestPoint · Shared
`Entity:NearestPoint(position: Vector) → Vector`

Performs a Ray-Orientated Bounding Box intersection from the given position to the origin of the OBBox with the entity and returns the hit position on the OBBox.

This relies on the entity having a collision mesh (not a physics object) and will be affected by `SOLID_NONE`

**Arguments:**
- `position` (Vector) — The vector to start the intersection from.

**Returns:**
- Vector — The nearest hit point of the entity's bounding box in world coordinates.

[wiki](https://wiki.facepunch.com/gmod/Entity:NearestPoint)

---

### Entity:NetworkVar · Shared
`Entity:NetworkVar(type: string, slot: number, name: string, extended: table = nil, type: string, name: string, extended: table = nil)`

Creates a network variable on the entity and adds Set/Get functions for it. This function should only be called in [ENTITY:SetupDataTables](https://wiki.facepunch.com/gmod/ENTITY:SetupDataTables).

See [Entity:NetworkVarNotify](https://wiki.facepunch.com/gmod/Entity:NetworkVarNotify) for a function to hook NetworkVar changes.




Combining this function with [util.TableToJSON](https://wiki.facepunch.com/gmod/util.TableToJSON) can also provide a way to network tables as serialized strings.

**Arguments:**
- `type` (string) — Supported choices: * `String` (up to 511 characters) * `Bool` * `Float` * `Int` (32-bit signed integer) * `Vector` * `Angle` * `Entity`
- `slot` (number) — Each network variable has to have a unique slot.
- `name` (string) — The name will affect how you access it.
- `extended` (table, default `nil`) — A table of extended information.
- `type` (string) — Supported choices: * `String` (up to 511 characters) * `Bool` * `Float` * `Int` (32-bit signed integer) * `Vector` * `Angle` * `Entity`
- `name` (string) — The name will affect how you access it.
- `extended` (table, default `nil`) — A table of extended information.

> **Note:** Entity NetworkVars are influenced by the return value of [ENTITY:UpdateTransmitState](https://wiki.facepunch.com/gmod/ENTITY:UpdateTransmitState).  
> 	So if you use the **PVS**(**default**), then the NetworkVars can be different for each client.
> **Warning:** Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing.

[wiki](https://wiki.facepunch.com/gmod/Entity:NetworkVar)

---

### Entity:NetworkVarElement · Shared
`Entity:NetworkVarElement(type: string, slot: number, element: string, name: string, extended: table = nil, type: string, element: string, name: string, extended: table = nil)`

Similarly to [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar), creates a network variable on the entity and adds Set/Get functions for it. This method stores it's value as a member value of a vector or an angle. This allows to go beyond the normal variable limit of [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) for `Int` and `Float` types, at the expense of `Vector` and `Angle` limit.

This function should only be called in [ENTITY:SetupDataTables](https://wiki.facepunch.com/gmod/ENTITY:SetupDataTables).

**Arguments:**
- `type` (string) — Supported choices: * `Vector` * `Angle`
- `slot` (number) — The slot for this `Vector` or `Angle`, from `0` to `31`.
- `element` (string) — Which element of a `Vector` or an `Angle` to store the value on.
- `name` (string) — The name will affect how you access it.
- `extended` (table, default `nil`) — A table of extra information.
- `type` (string) — Supported choices: * `Vector` * `Angle`
- `element` (string) — Which element of a `Vector` or an `Angle` to store the value on.
- `name` (string) — The name will affect how you access it.
- `extended` (table, default `nil`) — A table of extra information.

> **Warning:** Make sure to not call the SetDT* and your custom set methods on the client realm unless you know exactly what you are doing.

[wiki](https://wiki.facepunch.com/gmod/Entity:NetworkVarElement)

---

### Entity:NetworkVarNotify · Shared
`Entity:NetworkVarNotify(name: string, callback: function)`

Creates a callback that will execute when the given network variable changes - that is, when the `Set

**Arguments:**
- `name` (string) — Name of variable to track changes of.
- `callback` (function) — The function to call when the variable changes.

[wiki](https://wiki.facepunch.com/gmod/Entity:NetworkVarNotify) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L315-L325)

---

### Entity:NextThink · Shared
`Entity:NextThink(timestamp: number)`

Controls when, relative to [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime), the [Entity](https://wiki.facepunch.com/gmod/Entity) will next run its Think function.

For Scripted Entities, this is the [ENTITY:Think](https://wiki.facepunch.com/gmod/ENTITY:Think) function.  
For engine Entities, this is an internal function whose behavior will depend on the specific Entity type.


For a Client-side equivalent, see [Entity:SetNextClientThink](https://wiki.facepunch.com/gmod/Entity:SetNextClientThink).

**Arguments:**
- `timestamp` (number) — The timestamp, relative to CurTime, when the next think should occur.

> **Bug** ([#3269](https://github.com/Facepunch/garrysmod/issues/3269)): This does not work with SWEPs or Nextbots.

[wiki](https://wiki.facepunch.com/gmod/Entity:NextThink)

---

### Entity:OBBCenter · Shared
`Entity:OBBCenter() → Vector`

Returns the center of an entity's collision bounding box as a local vector.

See also [Entity:GetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds), [Entity:OBBMins](https://wiki.facepunch.com/gmod/Entity:OBBMins) and [Entity:OBBMaxs](https://wiki.facepunch.com/gmod/Entity:OBBMaxs).

**Returns:**
- Vector — The center of an entity's bounding box relative to its Entity:GetPos.

[wiki](https://wiki.facepunch.com/gmod/Entity:OBBCenter)

---

### Entity:OBBMaxs · Shared
`Entity:OBBMaxs() → Vector`

Returns the highest corner of an entity's collision bounding box as a local vector.

See also [Entity:GetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds), [Entity:OBBMins](https://wiki.facepunch.com/gmod/Entity:OBBMins) and [Entity:OBBCenter](https://wiki.facepunch.com/gmod/Entity:OBBCenter).

**Returns:**
- Vector — The local position of the highest corner of the entity's oriented bounding box.

[wiki](https://wiki.facepunch.com/gmod/Entity:OBBMaxs)

---

### Entity:OBBMins · Shared
`Entity:OBBMins() → Vector`

Returns the lowest corner of an entity's collision bounding box as a local vector.

See also [Entity:GetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds), [Entity:OBBMaxs](https://wiki.facepunch.com/gmod/Entity:OBBMaxs) and [Entity:OBBCenter](https://wiki.facepunch.com/gmod/Entity:OBBCenter).

**Returns:**
- Vector — The local position of the lowest corner of the entity's oriented bounding box.

[wiki](https://wiki.facepunch.com/gmod/Entity:OBBMins)

---

### Entity:ObjectCaps · Shared
`Entity:ObjectCaps() → number`

Returns the entity's capabilities as a bitfield.

In the engine this function is mostly used to check the use type, the save/restore system and level transitions flags.

Even though the function is defined shared, it is not guaranteed to return the same value across states.

**Returns:**
- number — The bitfield, a combination of the FCAP_ flags.

> **Note:** The enums for this are not currently implemented in Lua, however you can access the defines [here](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/shared/baseentity_shared.h#L21-L38).

[wiki](https://wiki.facepunch.com/gmod/Entity:ObjectCaps)

---

### Entity:OnGround · Shared
`Entity:OnGround() → boolean`

Returns true if the entity is on the ground, and false if it isn't.

Internally, this checks if [FL_ONGROUND](https://wiki.facepunch.com/gmod/Enums/FL) is set on the entity. This is only updated for players and NPCs, and thus won't inherently work for other entities.

**Returns:**
- boolean — Whether the entity is on the ground or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:OnGround)

---

### Entity:PassesDamageFilter · Server
`Entity:PassesDamageFilter(dmg: CTakeDamageInfo) → boolean`

Tests whether the damage passes the entity filter.

This will call [ENTITY:PassesDamageFilter](https://wiki.facepunch.com/gmod/ENTITY:PassesDamageFilter) on scripted entities of the type "filter".

**Arguments:**
- `dmg` (CTakeDamageInfo) — The damage info to test

**Returns:**
- boolean — Whether the damage info passes the entity filter.

> **Note:** This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )

[wiki](https://wiki.facepunch.com/gmod/Entity:PassesDamageFilter)

---

### Entity:PassesFilter · Server
`Entity:PassesFilter(caller: Entity, ent: Entity) → boolean`

Tests whether the entity passes the entity filter.

This will call [ENTITY:PassesFilter](https://wiki.facepunch.com/gmod/ENTITY:PassesFilter) on scripted entities of the type "filter".

**Arguments:**
- `caller` (Entity) — The initiator of the test.
- `ent` (Entity) — The entity to test against the entity filter.

**Returns:**
- boolean — Whether the entity info passes the entity filter.

> **Note:** This function only works on entities of the type "filter". ( filter_* entities, including base game filter entites )

[wiki](https://wiki.facepunch.com/gmod/Entity:PassesFilter)

---

### Entity:PhysicsDestroy · Shared
`Entity:PhysicsDestroy()`

Destroys the current physics object of an entity.

> **Note:** Cannot be used on a ragdoll or the world entity.
> **Warning:** This function cannot be used when called from a physics callback.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsDestroy)

---

### Entity:PhysicsFromMesh · Shared
`Entity:PhysicsFromMesh(vertices: table, surfaceprop: string = default, massCenterOveride: Vector = nil) → boolean`

Initializes the physics mesh of the entity from a triangle soup defined by a table of vertices. The resulting mesh is hollow, may contain holes, and always has a volume of 0.

While this is very useful for static geometry such as terrain displacements, it is advised to use [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) or [Entity:PhysicsInitMultiConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitMultiConvex) for moving solid objects instead.

[Entity:EnableCustomCollisions](https://wiki.facepunch.com/gmod/Entity:EnableCustomCollisions) needs to be called if you want players to collide with the entity correctly.

**Arguments:**
- `vertices` (table) — A table of Vectors.
- `surfaceprop` (string, default `default`) — Physical material from surfaceproperties.txt or added with physenv.AddSurfaceData.
- `massCenterOveride` (Vector, default `nil`) — If set, overwrites the center of mass for the created physics object.

**Returns:**
- boolean — Returns `true` on success, `nil` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsFromMesh)

---

### Entity:PhysicsInit · Shared
`Entity:PhysicsInit(solidType: number, massCenterOverride: Vector = nil) → boolean`

Initializes the [physics object](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObject) of the entity using its current [model](https://wiki.facepunch.com/gmod/Entity:GetModel). Deletes the previous physics object if it existed and the new object creation was successful.

If the entity's current model has no physics mesh associated to it, no physics object will be created and the previous object will still exist, if applicable.

**Arguments:**
- `solidType` (number, enum [SOLID](https://wiki.facepunch.com/gmod/Enums/SOLID)) — The solid type of the physics object to create, see SOLID.
- `massCenterOverride` (Vector, default `nil`) — If set, overwrites the center of mass for the created physics object.

**Returns:**
- boolean — Returns `true` on success, `false` otherwise.

> **Note:** When called clientside, this will not create a valid [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) if the model hasn't been [precached](https://wiki.facepunch.com/gmod/util.PrecacheModel) serverside.
> 
> If successful, this function will automatically call [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid)( solidType ) and [Entity:SetSolidFlags](https://wiki.facepunch.com/gmod/Entity:SetSolidFlags)( 0 ).
> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInit)

---

### Entity:PhysicsInitBox · Shared
`Entity:PhysicsInitBox(mins: Vector, maxs: Vector, surfaceprop: string = default, massCenterOverride: Vector = nil) → boolean`

Makes the physics object of the entity a AABB.

This function will automatically destroy any previous physics objects and do the following:
* [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid)( `SOLID_BBOX` )
* [Entity:SetMoveType](https://wiki.facepunch.com/gmod/Entity:SetMoveType)( `MOVETYPE_VPHYSICS` )
* [Entity:SetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:SetCollisionBounds)( `mins`, `maxs` )

**Arguments:**
- `mins` (Vector) — The minimum position of the box.
- `maxs` (Vector) — The maximum position of the box.
- `surfaceprop` (string, default `default`) — Physical material from surfaceproperties.txt or added with physenv.AddSurfaceData.
- `massCenterOverride` (Vector, default `nil`) — If set, overwrites the center of mass for the created physics object.

**Returns:**
- boolean — Returns `true` on success, `nil` otherwise.

> **Note:** If the volume of the resulting box is 0 (the mins and maxs are the same), the mins and maxs will be changed to [Vector](https://wiki.facepunch.com/gmod/Global.Vector)( -1, -1, -1 ) and [Vector](https://wiki.facepunch.com/gmod/Global.Vector)( 1, 1, 1 ), respectively.
> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitBox)

---

### Entity:PhysicsInitConvex · Shared
`Entity:PhysicsInitConvex(points: table, surfaceprop: string = default, massCenterOverride: Vector = nil) → boolean`

Initializes the physics mesh of the entity with a convex mesh defined by a table of points. The resulting mesh is the  of all the input points. If successful, the previous physics object will be removed.

This is the standard way of creating moving physics objects with a custom convex shape. For more complex, concave shapes, see [Entity:PhysicsInitMultiConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitMultiConvex).

You may be expected to call [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid) with desired solid type **before** calling this function.

**Arguments:**
- `points` (table) — A table of eight Vectors, in local coordinates, to be used in the computation of the convex mesh.
- `surfaceprop` (string, default `default`) — Physical material from surfaceproperties.txt or added with physenv.AddSurfaceData.
- `massCenterOverride` (Vector, default `nil`) — If set, overwrites the center of mass for the created physics object.

**Returns:**
- boolean — Returns `true` on success, `false` otherwise.

> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> You can use the following workaround for movement, though clientside collisions will still be broken.
> ```lua
> function ENT:Think()
> 	if ( CLIENT ) then
> 		local physobj = self:GetPhysicsObject()
> 
> 		if ( IsValid( physobj ) ) then
> 			physobj:SetPos( self:GetPos() )
> 			physobj:SetAngles( self:GetAngles() )
> 		end
> 	end
> end
> ```

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex)

---

### Entity:PhysicsInitMultiConvex · Shared
`Entity:PhysicsInitMultiConvex(vertices: table, surfaceprop: string = default, massCenterOverride: Vector = nil) → boolean`

An advanced version of [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) which initializes a physics object from multiple convex meshes. This should be used for physics objects with a custom shape which cannot be represented by a single convex mesh.

If successful, the previous physics object will be removed.

You may be expected to call [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid) with desired solid type **before** calling this function.

**Arguments:**
- `vertices` (table) — A table consisting of tables of Vectors.
- `surfaceprop` (string, default `default`) — Physical material from surfaceproperties.txt or added with physenv.AddSurfaceData.
- `massCenterOverride` (Vector, default `nil`) — If set, overwrites the center of mass for the created physics object.

**Returns:**
- boolean — Returns `true` on success, `nil` otherwise.

> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitMultiConvex)

---

### Entity:PhysicsInitShadow · Shared
`Entity:PhysicsInitShadow(allowPhysicsMovement: boolean = true, allowPhysicsRotation: boolean = true) → boolean`

Initializes the entity's physics object as a physics shadow. Removes the previous physics object if successful. This is used internally for the Player's and NPC's physics object, and certain HL2 entities such as the crane.

A physics shadow can be used to have static entities that never move by setting both arguments to false.

The created physics object will depend on the entity's solidity `SOLID_NONE` will not create a physics object, `SOLID_BBOX` will create a Axis-Aligned BBox one, `SOLID_OBB` will create Orientated Bounding Box one, and anything else will use the models' physics mesh.

**Arguments:**
- `allowPhysicsMovement` (boolean, default `true`) — Whether to allow the physics shadow to move under stress.
- `allowPhysicsRotation` (boolean, default `true`) — Whether to allow the physics shadow to rotate under stress.

**Returns:**
- boolean — Return `true` on success, `nil` otherwise.

> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitShadow)

---

### Entity:PhysicsInitSphere · Shared
`Entity:PhysicsInitSphere(radius: number, physmat: string = default) → boolean`

Makes the physics object of the entity a sphere.

This function will automatically destroy any previous physics objects and do the following:
* [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid)( `SOLID_BBOX` )
* [Entity:SetMoveType](https://wiki.facepunch.com/gmod/Entity:SetMoveType)( `MOVETYPE_VPHYSICS` )

**Arguments:**
- `radius` (number) — The radius of the sphere.
- `physmat` (string, default `default`) — Physical material from surfaceproperties.txt or added with physenv.AddSurfaceData.

**Returns:**
- boolean — Returns `true` on success, `false` otherwise

> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitSphere)

---

### Entity:PhysicsInitStatic · Shared
`Entity:PhysicsInitStatic(solidType: number) → boolean`

Initializes a static physics object of the entity using its [current model](https://wiki.facepunch.com/gmod/Entity:GetModel). If successful, the previous physics object is removed.

This is what used by entities such as `func_breakable`, `prop_dynamic`, `item_suitcharger`, `prop_thumper` and `npc_rollermine` while it is in its "buried" state in the Half-Life 2 Campaign.

If the entity's current model has no physics mesh associated to it, no physics object will be created.

**Arguments:**
- `solidType` (number, enum [SOLID](https://wiki.facepunch.com/gmod/Enums/SOLID)) — The solid type of the physics object to create, see SOLID.

**Returns:**
- boolean — Returns `true` on success, `false` otherwise.

> **Note:** This function will automatically call [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid)( `solidType` ).
> **Bug** ([#5060](https://github.com/Facepunch/garrysmod/issues/5060)): Clientside physics objects on serverside entities do not move properly in some cases. Physics objects should only created on the server or you will experience incorrect physgun beam position, prediction issues, and other unexpected behavior.
> 
> A workaround is available on the [Entity:PhysicsInitConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitConvex) page.

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysicsInitStatic)

---

### Entity:PhysWake · Shared
`Entity:PhysWake()`

Wakes up the entity's physics object

[wiki](https://wiki.facepunch.com/gmod/Entity:PhysWake) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L168-L175)

---

### Entity:PlayScene · Server
`Entity:PlayScene(scene: string, delay: number = 0) → number, Entity`

Makes the entity play a .vcd scene. [All scenes from Half-Life 2](https://developer.valvesoftware.com/wiki/Half-Life_2_Scenes_List).

**Arguments:**
- `scene` (string) — Filepath to scene.
- `delay` (number, default `0`) — Delay in seconds until the scene starts playing.

**Returns:**
- number — Estimated length of the scene.
- Entity — The scene entity, removing which will stop the scene from continuing to play.

[wiki](https://wiki.facepunch.com/gmod/Entity:PlayScene)

---

### Entity:PointAtEntity · Server
`Entity:PointAtEntity(target: Entity)`

Changes an entities angles so that it faces the target entity.

**Arguments:**
- `target` (Entity) — The entity to face.

[wiki](https://wiki.facepunch.com/gmod/Entity:PointAtEntity)

---

### Entity:PrecacheGibs · Server
`Entity:PrecacheGibs() → number`

Precaches gibs for the entity's model.

Normally this function should be ran when the entity is spawned, for example the [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize), after [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel) is called.

This is required for [Entity:GibBreakServer](https://wiki.facepunch.com/gmod/Entity:GibBreakServer) and [Entity:GibBreakClient](https://wiki.facepunch.com/gmod/Entity:GibBreakClient) to work.

**Returns:**
- `gibCount` (number) — The amount of gibs the prop has

[wiki](https://wiki.facepunch.com/gmod/Entity:PrecacheGibs)

---

### Entity:RagdollSolve · Server
`Entity:RagdollSolve()`

Normalizes the ragdoll. This is used alongside Kinect in [Entity:SetRagdollBuildFunction](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction), for more info see ragdoll_motion entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:RagdollSolve)

---

### Entity:RagdollStopControlling · Server
`Entity:RagdollStopControlling()`

Sets the function to build the ragdoll. This is used alongside Kinect in [Entity:SetRagdollBuildFunction](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction), for more info see ragdoll_motion entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:RagdollStopControlling)

---

### Entity:RagdollUpdatePhysics · Server
`Entity:RagdollUpdatePhysics()`

Makes the physics objects follow the set bone positions. This is used alongside Kinect in [Entity:SetRagdollBuildFunction](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction), for more info see ragdoll_motion entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:RagdollUpdatePhysics)

---

### Entity:Remove · Shared
`Entity:Remove()`

Removes (or deletes) a given [Entity](https://wiki.facepunch.com/gmod/Entity). 

		The Entity will continue to exist until the start of the next tick.  

		To check if an Entity will be removed in the next tick, see [Entity:IsMarkedForDeletion](https://wiki.facepunch.com/gmod/Entity:IsMarkedForDeletion)

[wiki](https://wiki.facepunch.com/gmod/Entity:Remove)

---

### Entity:RemoveAllDecals · Shared
`Entity:RemoveAllDecals()`

Removes all decals from the entities surface.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveAllDecals)

---

### Entity:RemoveAllGestures · Server
`Entity:RemoveAllGestures()`

Removes and stops all gestures.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!
> **Note:** Layer removal procedures aren't immediate. Layer removal functions actually manipulate [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight) down to 0, then remove the layer in next intervals. If the targeted layer's weight keeps changing, your layer will not be removed.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveAllGestures)

---

### Entity:RemoveCallback · Shared
`Entity:RemoveCallback(hook: string, callbackid: number)`

Removes a callback previously added with [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback)

**Arguments:**
- `hook` (string) — The hook name to remove.
- `callbackid` (number) — The callback id previously retrieved with the return of Entity:AddCallback or Entity:GetCallbacks

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveCallback)

---

### Entity:RemoveCallOnRemove · Shared
`Entity:RemoveCallOnRemove(identifier: any)`

Removes a function previously added via [Entity:CallOnRemove](https://wiki.facepunch.com/gmod/Entity:CallOnRemove).

**Arguments:**
- `identifier` (any) — Identifier of the function given to Entity:CallOnRemove.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveCallOnRemove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L122-L132)

---

### Entity:RemoveEffects · Shared
`Entity:RemoveEffects(effect: number{EF})`

Removes an engine effect applied to an entity.

**Arguments:**
- `effect` (number{EF}) — The effect to remove, see EF.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveEffects)

---

### Entity:RemoveEFlags · Shared
`Entity:RemoveEFlags(flag: number{EFL})`

Removes specified engine flag

**Arguments:**
- `flag` (number{EFL}) — The flag to remove, see EFL

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveEFlags)

---

### Entity:RemoveFlags · Shared
`Entity:RemoveFlags(flag: number{FL})`

Removes specified flag(s) from the entity

**Arguments:**
- `flag` (number{FL}) — The flag(s) to remove, see FL

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveFlags)

---

### Entity:RemoveFromMotionController · Shared
`Entity:RemoveFromMotionController(physObj: PhysObj)`

Removes a [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ect from the entity's motion controller so that [ENTITY:PhysicsSimulate](https://wiki.facepunch.com/gmod/ENTITY:PhysicsSimulate) will no longer be called for given [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ect.

You must first create a motion controller with [Entity:StartMotionController](https://wiki.facepunch.com/gmod/Entity:StartMotionController).

**Arguments:**
- `physObj` (PhysObj) — The PhysObj to remove from the motion controller.

> **Note:** Only works on a scripted [Entity](https://wiki.facepunch.com/gmod/Entity) of anim type

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveFromMotionController)

---

### Entity:RemoveGesture · Server
`Entity:RemoveGesture(activity: number)`

Removes and stops the gesture with given activity. Same as [Entity:RemoveLayer](https://wiki.facepunch.com/gmod/Entity:RemoveLayer) with [Entity:FindGestureLayer](https://wiki.facepunch.com/gmod/Entity:FindGestureLayer).

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity remove.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!
> **Note:** Layer removal procedures aren't immediate. Layer removal functions actually manipulate [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight) down to 0, then remove the layer in next intervals. If the targeted layer's weight keeps changing, your layer will not be removed.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveGesture)

---

### Entity:RemoveInternalConstraint · Server
`Entity:RemoveInternalConstraint(num: number = -1)`

Breaks internal Ragdoll constrains, so you can for example separate an arm from the body of a ragdoll and preserve all physics.

The visual mesh will still stretch as if it was properly connected unless the ragdoll model is specifically designed to avoid that.

**Arguments:**
- `num` (number, default `-1`) — Which constraint to break, values below 0 mean break them all

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveInternalConstraint)

---

### Entity:RemoveLayer · Server
`Entity:RemoveLayer(layerID: number)`

Removes the given layer by ID. See also [Entity:RemoveGesture](https://wiki.facepunch.com/gmod/Entity:RemoveGesture).

**Arguments:**
- `layerID` (number) — The layer ID to remove.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!
> **Note:** Layer removal procedures aren't immediate. Layer removal functions actually manipulate [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight) down to 0, then remove the layer in next intervals. If the targeted layer's weight keeps changing, your layer will not be removed.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveLayer)

---

### Entity:RemoveSolidFlags · Shared
`Entity:RemoveSolidFlags(flags: number)`

Removes solid flag(s) from the entity.

**Arguments:**
- `flags` (number, enum [FSOLID](https://wiki.facepunch.com/gmod/Enums/FSOLID)) — The flag(s) to remove, see FSOLID.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveSolidFlags)

---

### Entity:RemoveSpawnFlags · Shared
`Entity:RemoveSpawnFlags(flag: number)`

Removes a SpawnFlag from the current SpawnFlags of an Entity.

SpawnFlags can easily be found on https://developer.valvesoftware.com/wiki/.

**Arguments:**
- `flag` (number) — The SpawnFlag to remove from the Entity

> **Note:** See also [Entity:AddSpawnFlags](https://wiki.facepunch.com/gmod/Entity:AddSpawnFlags), [Entity:SetSpawnFlags](https://wiki.facepunch.com/gmod/Entity:SetSpawnFlags)
> 
> 	Using [SF Enumerations](https://wiki.facepunch.com/gmod/Enums/SF) won't work, if this function is ran clientside due to the enumerations being defined only Serverside. Use the actual SpawnFlag number.

[wiki](https://wiki.facepunch.com/gmod/Entity:RemoveSpawnFlags) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L15-L17)

---

### Entity:ResetSequence · Shared
`Entity:ResetSequence(sequence: number)`

Plays an animation on the entity. This may not always work on engine entities.

**Arguments:**
- `sequence` (number) — The sequence to play.

> **Note:** This will not work properly if called directly after calling [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel). Consider waiting until the next Tick.
> 
> Will not work on players due to the animations being reset every frame by the base gamemode animation system. See [GM:CalcMainActivity](https://wiki.facepunch.com/gmod/GM:CalcMainActivity).
> 
> For custom scripted entities you will want to apply example from [ENTITY:Think](https://wiki.facepunch.com/gmod/ENTITY:Think) to make animations work.
> **Warning:** This will not reset the animation on viewmodels, use [Entity:SendViewModelMatchingSequence](https://wiki.facepunch.com/gmod/Entity:SendViewModelMatchingSequence) instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:ResetSequence)

---

### Entity:ResetSequenceInfo · Shared
`Entity:ResetSequenceInfo()`

Reset entity sequence info such as playback rate, ground speed, last event check, etc.

[wiki](https://wiki.facepunch.com/gmod/Entity:ResetSequenceInfo)

---

### Entity:Respawn · Server
`Entity:Respawn()`

Makes the entity/weapon respawn.

Only usable on HL2/HL:S pickups and any weapons. Seems to be buggy with weapons.
Very unreliable.

[wiki](https://wiki.facepunch.com/gmod/Entity:Respawn)

---

### Entity:RestartGesture · Server
`Entity:RestartGesture(activity: number, addIfMissing: boolean = true, autokill: boolean = true)`

Restarts the entity's animation gesture. If the given gesture is already playing, it will reset it and play it from the beginning.

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity number to send to the entity.
- `addIfMissing` (boolean, default `true`) — Add/start the gesture to if it has not been yet started.
- `autokill` (boolean, default `true`)

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites.

[wiki](https://wiki.facepunch.com/gmod/Entity:RestartGesture)

---

### Entity:RestoreNetworkVars · Shared · `INTERNAL`
`Entity:RestoreNetworkVars(data: table)`

Calls the associated `Entity:Set*` function for each network var provided.

**Arguments:**
- `data` (table) — The data from Entity:GetNetworkVars.

> **Note:** This function will only work on entities which had [Entity:InstallDataTable](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) called on them, which is done automatically for players and all [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities)

[wiki](https://wiki.facepunch.com/gmod/Entity:RestoreNetworkVars)

---

### Entity:SelectWeightedSequence · Shared
`Entity:SelectWeightedSequence(act: number{ACT}) → number`

Returns sequence ID corresponding to given activity ID.

Multiple sequences can be assigned to a single [ACT](https://wiki.facepunch.com/gmod/Enums/ACT), in which case a random one will be selected. This can be used for example to randomize idle animations (and is used for that by built-in weapons) without the need to code logic for this.  
See also [Entity:SelectWeightedSequenceSeeded](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequenceSeeded).

Opposite of [Entity:GetSequenceActivity](https://wiki.facepunch.com/gmod/Entity:GetSequenceActivity).

Similar to [Entity:LookupSequence](https://wiki.facepunch.com/gmod/Entity:LookupSequence).

**Arguments:**
- `act` (number{ACT}) — The activity ID, see ACT.

**Returns:**
- number — The sequence ID, or `-1` if not found.

[wiki](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequence)

---

### Entity:SelectWeightedSequenceSeeded · Shared
`Entity:SelectWeightedSequenceSeeded(act: number, seed: number) → number`

Returns the sequence ID corresponding to given activity ID, and uses the provided seed for random selection. The seed should be the same server-side and client-side if used in a predicted environment.

See [Entity:SelectWeightedSequence](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequence) for a provided-seed version of this function.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity ID, see ACT.
- `seed` (number) — The seed to use for randomly selecting a sequence in the case the activity ID has multiple sequences bound to it.

**Returns:**
- number — The sequence ID, or `-1` if not found.

[wiki](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequenceSeeded)

---

### Entity:SendViewModelMatchingSequence · Shared
`Entity:SendViewModelMatchingSequence(seq: number)`

Sends sequence animation to the view model. It is recommended to use this for view model animations, instead of [Entity:ResetSequence](https://wiki.facepunch.com/gmod/Entity:ResetSequence).

This function is only usable on view models.

**Arguments:**
- `seq` (number) — The sequence ID returned by Entity:LookupSequence or Entity:SelectWeightedSequence.

> **Note:** Predicted viewmodels will have their sequence and cycle reset during prediction checks, making this function appear to do nothing unless also called on the server.

[wiki](https://wiki.facepunch.com/gmod/Entity:SendViewModelMatchingSequence)

---

### Entity:SequenceDuration · Shared
`Entity:SequenceDuration(seqid: number = nil) → number`

Returns length of currently played sequence.

**Arguments:**
- `seqid` (number, default `nil`) — A sequence ID to return the length specific sequence of instead of the entity's main/currently playing sequence.

**Returns:**
- number — The length of the sequence

> **Bug** ([#2783](https://github.com/Facepunch/garrysmod/issues/2783)): This will return incorrect results for weapons and viewmodels clientside in thirdperson.

[wiki](https://wiki.facepunch.com/gmod/Entity:SequenceDuration)

---

### Entity:SetAbsVelocity · Shared
`Entity:SetAbsVelocity(velocity: Vector)`

Sets the entity's velocity.

**Arguments:**
- `velocity` (Vector) — The new velocity to set.

> **Note:** Actually binds to CBaseEntity::SetLocalVelocity() which sets the entity's velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetAbsVelocity)

---

### Entity:SetAngles · Shared
`Entity:SetAngles(angles: Angle)`

Sets the angles of the entity.

**Arguments:**
- `angles` (Angle) — The new angles.

> **Note:** To set a player's angles, use [Player:SetEyeAngles](https://wiki.facepunch.com/gmod/Player:SetEyeAngles) instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetAngles)

---

### Entity:SetAnimation · Shared
`Entity:SetAnimation(playerAnim: number)`

Sets a player's third-person animation. Mainly used by [Weapon](https://wiki.facepunch.com/gmod/Weapon)s to start the player's weapon attack and reload animations.

**Arguments:**
- `playerAnim` (number, enum [PLAYER](https://wiki.facepunch.com/gmod/Enums/PLAYER)) — Player animation, see PLAYER.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetAnimation)

---

### Entity:SetAnimTime · Client
`Entity:SetAnimTime(time: number)`

Sets the start time (relative to [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime)) of the current animation, which is used to determine [Entity:GetCycle](https://wiki.facepunch.com/gmod/Entity:GetCycle). Should be less than CurTime to play an animation from the middle.

**Arguments:**
- `time` (number) — The time the animation was supposed to begin.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetAnimTime)

---

### Entity:SetAttachment · Shared · `DEPRECATED`
`Entity:SetAttachment(ent: Entity, attachment: number)`

Parents the sprite to an attachment on another model.

Works only on `env_sprite` entities.

Despite existing on client, it doesn't actually do anything on client.

**Arguments:**
- `ent` (Entity) — The entity to attach/parent to
- `attachment` (number) — The attachment ID to parent to

[wiki](https://wiki.facepunch.com/gmod/Entity:SetAttachment)

---

### Entity:SetBloodColor · Server
`Entity:SetBloodColor(bloodColor: number{BLOOD_COLOR})`

Sets the blood color this entity uses.

**Arguments:**
- `bloodColor` (number{BLOOD_COLOR}) — An integer corresponding to BLOOD_COLOR.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBloodColor)

---

### Entity:SetBodygroup · Shared
`Entity:SetBodygroup(bodyGroupId: number, subModelId: number)`

Sets the currently active [Sub Model ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#submodels) for the Body Group corresponding to the given [Body Group ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id) of the [Entity's](https://wiki.facepunch.com/gmod/Entity) model.

Bodygroups, for which [Entity:GetBodygroupCount](https://wiki.facepunch.com/gmod/Entity:GetBodygroupCount) returns `1` or less are considered invalid, and will have no effect in-game.

**Arguments:**
- `bodyGroupId` (number) — The Body Group ID to set the Sub Model ID of.
- `subModelId` (number) — The Sub Model ID to set as active for this Body Group.

> **Note:** When used on a Weapon, this will modify its viewmodel.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBodygroup)

---

### Entity:SetBodyGroups · Shared
`Entity:SetBodyGroups(subModelIds: string)`

Sets the [Entity's](https://wiki.facepunch.com/gmod/Entity) active Sub Models via a string of [Sub Model IDs](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#submodels) in order from the first [Body Group ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id) to the last.

This is a convenience function for [Entity:SetBodygroup](https://wiki.facepunch.com/gmod/Entity:SetBodygroup).

**Arguments:**
- `subModelIds` (string) — The Sub Model IDs to activate for each Body Group on the Entity's model.

> **Note:** When used on a Weapon, this will modify its viewmodel.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBodyGroups)

---

### Entity:SetBoneController · Shared
`Entity:SetBoneController(boneControllerID: number, value: number)`

Sets the specified value on the bone controller with the given ID of this entity, it's used in HL1 to change the head rotation of NPCs, turret aiming and so on.

**Arguments:**
- `boneControllerID` (number) — The ID of the bone controller to set the value to.
- `value` (number) — The value to set on the specified bone controller.

> **Note:** This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBoneController)

---

### Entity:SetBoneMatrix · Shared
`Entity:SetBoneMatrix(boneid: number, matrix: VMatrix)`

Sets the bone matrix of given bone to given matrix. See also [Entity:GetBoneMatrix](https://wiki.facepunch.com/gmod/Entity:GetBoneMatrix). Will cause a uncatchable error when used on `__INVALIDBONE__` bones, see the examples on a way to prevent this.

**Arguments:**
- `boneid` (number) — The ID of the bone
- `matrix` (VMatrix) — The matrix to set.

> **Note:** Despite existing serverside, it does nothing.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBoneMatrix)

---

### Entity:SetBonePosition · Client
`Entity:SetBonePosition(bone: number, pos: Vector, ang: Angle)`

Sets the bone position and angles.

**Arguments:**
- `bone` (number) — The bone ID to manipulate
- `pos` (Vector) — The position to set
- `ang` (Angle) — The angles to set

[wiki](https://wiki.facepunch.com/gmod/Entity:SetBonePosition)

---

### Entity:SetCollisionBounds · Shared
`Entity:SetCollisionBounds(mins: Vector, maxs: Vector)`

Sets the collision bounds for the entity, which are used for triggers ([Entity:SetTrigger](https://wiki.facepunch.com/gmod/Entity:SetTrigger), [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch)), and collision (If [Entity:SetSolid](https://wiki.facepunch.com/gmod/Entity:SetSolid) set as [SOLID_BBOX](https://wiki.facepunch.com/gmod/Enums/SOLID)).

Input bounds are relative to [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos)! 
See also [Entity:SetCollisionBoundsWS](https://wiki.facepunch.com/gmod/Entity:SetCollisionBoundsWS).

**Arguments:**
- `mins` (Vector) — The minimum vector of the bounds.
- `maxs` (Vector) — The maximum vector of the bounds.

> **Note:** Player collision bounds are reset every frame to player's [Player:SetHull](https://wiki.facepunch.com/gmod/Player:SetHull) values.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCollisionBounds)

---

### Entity:SetCollisionBoundsWS · Shared
`Entity:SetCollisionBoundsWS(vec1: Vector, vec2: Vector)`

A convenience function that sets the collision bounds for the entity in world space coordinates by transforming given vectors to entity's local space and passing them to [Entity:SetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:SetCollisionBounds)

**Arguments:**
- `vec1` (Vector) — The first vector of the bounds.
- `vec2` (Vector) — The second vector of the bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCollisionBoundsWS)

---

### Entity:SetCollisionGroup · Shared
`Entity:SetCollisionGroup(group: number{COLLISION_GROUP})`

Sets the entity's collision group.

**Arguments:**
- `group` (number{COLLISION_GROUP}) — Collision group of the entity, see COLLISION_GROUP

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCollisionGroup)

---

### Entity:SetColor · Shared
`Entity:SetColor(color: Color = Color(255, 255, 255, 255))`

Sets the color of an entity.

Some entities may need a custom [render mode](Enums/RENDERMODE) set for transparency to work. See example 2.
Entities also must have a proper [render group](Enums/RENDERGROUP) set for transparency to work.

When rendering a model manually via [Entity:SetNoDraw](https://wiki.facepunch.com/gmod/Entity:SetNoDraw) inside [ENTITY:Draw](https://wiki.facepunch.com/gmod/ENTITY:Draw), you may need to use [render.SetColorModulation](https://wiki.facepunch.com/gmod/render.SetColorModulation) in the render hook (where you call [Entity:DrawModel](https://wiki.facepunch.com/gmod/Entity:DrawModel)) instead.

**Arguments:**
- `color` (Color, default `Color(255, 255, 255, 255)`) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L180-L194)

---

### Entity:SetColor4Part · Shared · `INTERNAL`
`Entity:SetColor4Part(r: number, g: number, b: number, a: number)`

Sets the color of an entity without usage of a [Color](https://wiki.facepunch.com/gmod/Global.Color) object.

**Arguments:**
- `r` (number)
- `g` (number)
- `b` (number)
- `a` (number)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetColor4Part)

---

### Entity:SetCreator · Server
`Entity:SetCreator(ply: Player = NULL)`

Sets the creator of this entity. This is set automatically in Sandbox gamemode when spawning SENTs, but is never used/read by default.

**Arguments:**
- `ply` (Player, default `NULL`) — The creator

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCreator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L59-L67)

---

### Entity:SetCustomCollisionCheck · Shared
`Entity:SetCustomCollisionCheck(enable: boolean)`

Marks the entity to call [GM:ShouldCollide](https://wiki.facepunch.com/gmod/GM:ShouldCollide). Not to be confused with [Entity:EnableCustomCollisions](https://wiki.facepunch.com/gmod/Entity:EnableCustomCollisions).

**Arguments:**
- `enable` (boolean) — Enable or disable the custom collision check

> **Note:** Make sure to use [Entity:CollisionRulesChanged](https://wiki.facepunch.com/gmod/Entity:CollisionRulesChanged) after changing this value.
> 			Otherwise it can cause crashes.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCustomCollisionCheck)

---

### Entity:SetCycle · Shared
`Entity:SetCycle(value: number)`

Sets the progress of the current animation to a specific value between 0 and 1.

**Arguments:**
- `value` (number) — The desired cycle value

> **Bug** ([#3038](https://github.com/Facepunch/garrysmod/issues/3038)): Viewmodels overwrite their animation cycle every frame, for prediction/interpolation purposes.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetCycle)

---

### Entity:SetDTAngle · Shared · `INTERNAL`
`Entity:SetDTAngle(key: number, ang: Angle)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified angle on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `ang` (Angle) — The angle to write on the entity's datatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTAngle)

---

### Entity:SetDTBool · Shared · `INTERNAL`
`Entity:SetDTBool(key: number, bool: boolean)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified bool on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `bool` (boolean) — The boolean to write on the entity's metatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTBool)

---

### Entity:SetDTEntity · Shared · `INTERNAL`
`Entity:SetDTEntity(key: number, ent: Entity)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified entity on this entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `ent` (Entity) — The entity to write on this entity's datatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTEntity)

---

### Entity:SetDTFloat · Shared · `INTERNAL`
`Entity:SetDTFloat(key: number, float: number)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified float on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `float` (number) — The float to write on the entity's datatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTFloat)

---

### Entity:SetDTInt · Shared · `INTERNAL`
`Entity:SetDTInt(key: number, integer: number)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified integer on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `integer` (number) — The integer to write on the entity's datatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTInt)

---

### Entity:SetDTString · Shared · `INTERNAL`
`Entity:SetDTString(key: number, str: string)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified string on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 3.
- `str` (string) — The string to write on the entity's datatable, can't be more than 512 characters per string.

> **Note:** The length of these strings are capped at 512 characters.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTString)

---

### Entity:SetDTVector · Shared · `INTERNAL`
`Entity:SetDTVector(key: number, vec: Vector)`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Sets the specified vector on the entity's datatable.

**Arguments:**
- `key` (number) — Goes from 0 to 31.
- `vec` (Vector) — The vector to write on the entity's datatable.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetDTVector)

---

### Entity:SetElasticity · Shared
`Entity:SetElasticity(elasticity: number)`

Sets the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.

**Arguments:**
- `elasticity` (number) — The elasticity to set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetElasticity)

---

### Entity:SetEntity · Shared
`Entity:SetEntity(name: string, entity: Entity)`

Allows you to set the Start or End entity attachment for the rope.

**Arguments:**
- `name` (string) — The name of the variable to modify.
- `entity` (Entity) — The entity to apply to the specific attachment.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetEntity)

---

### Entity:SetEyeTarget · Shared
`Entity:SetEyeTarget(pos: Vector)`

Sets the position an entity's eyes look toward. This works as an override for default behavior. Set to `0,0,0` to disable the override.

**Arguments:**
- `pos` (Vector) — For NPCs and all other entities except ragdolls - the world position for the entity to look towards For ragdolls specifically - a local position in front of their `eyes` attachment.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetEyeTarget)

---

### Entity:SetFlexScale · Shared
`Entity:SetFlexScale(scale: number)`

Sets the scale of all the flexes of this entity. See [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight).

**Arguments:**
- `scale` (number) — The new flex scale to set to

[wiki](https://wiki.facepunch.com/gmod/Entity:SetFlexScale)

---

### Entity:SetFlexWeight · Shared
`Entity:SetFlexWeight(flex: number, weight: number)`

Sets the weight/value of given flex controller.

Setting flex weights spawns an internal networked entity (one per entity face posed) to accommodate networking to clients.

**Arguments:**
- `flex` (number) — The ID of the flex to modify weight of.
- `weight` (number) — The new weight to set.

> **Note:** Only `96` flex controllers can be set! Flex controllers on models with higher amounts will not be accessible.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight)

---

### Entity:SetFriction · Shared
`Entity:SetFriction(friction: number)`

Sets friction multiplier for this entity when sliding against a surface. Entities default to 1 (100%) and can be higher.

This may not affect all entities, but does work for players (the range is 0 to 10), as well as other entities using [MOVETYPE_STEP](https://wiki.facepunch.com/gmod/Enums/MOVETYPE#MOVETYPE_STEP)

This only multiplies the friction of the entity, to change the value itself use [PhysObj:SetMaterial](https://wiki.facepunch.com/gmod/PhysObj:SetMaterial).

**Arguments:**
- `friction` (number) — Friction multiplier

[wiki](https://wiki.facepunch.com/gmod/Entity:SetFriction)
