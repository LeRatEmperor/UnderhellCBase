# Entity

**Realm:** Shared  ·  **Members:** 557

This is a list of all available methods for all entities, which includes [Players](https://wiki.facepunch.com/gmod/Player), [Weapons](https://wiki.facepunch.com/gmod/Weapon), [NPCs](https://wiki.facepunch.com/gmod/NPC) and [Vehicles](https://wiki.facepunch.com/gmod/Vehicle).

For a list of possible members of [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities) see [ENT Structure](https://wiki.facepunch.com/gmod/Structures/ENT).

[wiki page](https://wiki.facepunch.com/gmod/Entity)

> **Part 1 of 3** (`Activate` – `GetNWVarProxy`). All parts: [1](Entity.md), [2](Entity-2.md), [3](Entity-3.md)


### Entity:Activate · Shared
`Entity:Activate()`

Activates the entity. This needs to be used on some entities (like constraints) after being spawned.

> **Note:** For some entity types when this function is used after [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale), the physics object will be recreated with the new scale. [Source-sdk-2013](https://github.com/ValveSoftware/source-sdk-2013/blob/55ed12f8d1eb6887d348be03aee5573d44177ffb/mp/src/game/server/baseanimating.cpp#L321-L327).
> 
> Calling this method after [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale) will recreate a new scaled `SOLID_VPHYSICS` [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) on scripted entities. This can be a problem if you made a properly scaled [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) of another kind (using [Entity:PhysicsInitSphere](https://wiki.facepunch.com/gmod/Entity:PhysicsInitSphere) for instance) or if you edited the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)'s properties. This is especially the behavior of the Sandbox spawn menu.

[wiki](https://wiki.facepunch.com/gmod/Entity:Activate)

---

### Entity:AddCallback · Shared
`Entity:AddCallback(hook: string, func: function) → number`

Add a callback function to a specific event. This is used instead of hooks to avoid calling empty functions unnecessarily.

This also allows you to use certain hooks in engine entities (non-scripted entities).

**Arguments:**
- `hook` (string) — The hook name to hook onto.
- `func` (function) — The function to call.

**Returns:**
- number — The callback ID that was just added, which can later be used in Entity:RemoveCallback.

> **Warning:** This method does not check if the function has already been added to this object before, so if you add the same callback twice, it will be run twice! Make sure to add your callback only once.

[wiki](https://wiki.facepunch.com/gmod/Entity:AddCallback)

---

### Entity:AddEffects · Shared
`Entity:AddEffects(effect: number{EF})`

Applies an engine effect to an entity.

See also [Entity:IsEffectActive](https://wiki.facepunch.com/gmod/Entity:IsEffectActive) and  [Entity:RemoveEffects](https://wiki.facepunch.com/gmod/Entity:RemoveEffects).

**Arguments:**
- `effect` (number{EF}) — The effect to apply, see EF.

[wiki](https://wiki.facepunch.com/gmod/Entity:AddEffects)

---

### Entity:AddEFlags · Shared
`Entity:AddEFlags(flag: number{EFL})`

Adds engine flags.

**Arguments:**
- `flag` (number{EFL}) — Engine flag to add, see EFL

[wiki](https://wiki.facepunch.com/gmod/Entity:AddEFlags)

---

### Entity:AddFlags · Shared
`Entity:AddFlags(flag: number{FL})`

Adds flags to the entity.

**Arguments:**
- `flag` (number{FL}) — Flag to add, see FL

[wiki](https://wiki.facepunch.com/gmod/Entity:AddFlags)

---

### Entity:AddGesture · Server
`Entity:AddGesture(activity: number, autokill: boolean = true) → number`

Adds a gesture animation to the entity and plays it.


See [Entity:AddGestureSequence](https://wiki.facepunch.com/gmod/Entity:AddGestureSequence) and [Entity:AddLayeredSequence](https://wiki.facepunch.com/gmod/Entity:AddLayeredSequence) for functions that takes sequences instead of [ACT](https://wiki.facepunch.com/gmod/Enums/ACT).

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The activity to play as the gesture.
- `autokill` (boolean, default `true`) — Automatically remove the gesture when it fully plays (Entity:GetLayerCycle reaches 1).

**Returns:**
- number — Layer ID of the started gesture, used to manipulate the played gesture by other functions.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:AddGesture)

---

### Entity:AddGestureSequence · Server
`Entity:AddGestureSequence(sequence: number, autokill: boolean = true) → number`

Adds a gesture animation to the entity and plays it.


See [Entity:AddGesture](https://wiki.facepunch.com/gmod/Entity:AddGesture) for a function that takes [ACT](https://wiki.facepunch.com/gmod/Enums/ACT).


See also [Entity:AddLayeredSequence](https://wiki.facepunch.com/gmod/Entity:AddLayeredSequence).

**Arguments:**
- `sequence` (number) — The sequence ID to play as the gesture.
- `autokill` (boolean, default `true`) — Automatically remove the gesture when it fully plays (Entity:GetLayerCycle reaches 1).

**Returns:**
- number — Layer ID of the started gesture, used to manipulate the played gesture by other functions.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:AddGestureSequence)

---

### Entity:AddLayeredSequence · Server
`Entity:AddLayeredSequence(sequence: number, priority: number) → number`

Adds a gesture animation to the entity and plays it.

See [Entity:AddGestureSequence](https://wiki.facepunch.com/gmod/Entity:AddGestureSequence) for a function that doesn't take priority.

See [Entity:AddGesture](https://wiki.facepunch.com/gmod/Entity:AddGesture) for a function that takes [ACT](https://wiki.facepunch.com/gmod/Enums/ACT).

**Arguments:**
- `sequence` (number) — The sequence ID to play as the gesture.
- `priority` (number)

**Returns:**
- number — Layer ID of created layer

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:AddLayeredSequence)

---

### Entity:AddSolidFlags · Shared
`Entity:AddSolidFlags(flags: number)`

Adds solid flag(s) to the entity.

**Arguments:**
- `flags` (number, enum [FSOLID](https://wiki.facepunch.com/gmod/Enums/FSOLID)) — The flag(s) to apply, see FSOLID.

[wiki](https://wiki.facepunch.com/gmod/Entity:AddSolidFlags)

---

### Entity:AddSpawnFlags · Shared
`Entity:AddSpawnFlags(flag: number)`

Adds onto the current SpawnFlags of an Entity.

SpawnFlags can easily be found on https://developer.valvesoftware.com/wiki/.

**Arguments:**
- `flag` (number) — The SpawnFlag to add to the Entity

> **Note:** See also [Entity:RemoveSpawnFlags](https://wiki.facepunch.com/gmod/Entity:RemoveSpawnFlags), [Entity:SetSpawnFlags](https://wiki.facepunch.com/gmod/Entity:SetSpawnFlags)
> 
> 	Using [SF Enumerations](https://wiki.facepunch.com/gmod/Enums/SF) won't work, if this function is ran clientside due to the enumerations being defined only Serverside. Use the actual SpawnFlag number.

[wiki](https://wiki.facepunch.com/gmod/Entity:AddSpawnFlags) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L11-L13)

---

### Entity:AddToMotionController · Shared
`Entity:AddToMotionController(physObj: PhysObj)`

Adds a [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ect to the entity's motion controller so that [ENTITY:PhysicsSimulate](https://wiki.facepunch.com/gmod/ENTITY:PhysicsSimulate) will be called for given [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ect as well.

You must first create a motion controller with [Entity:StartMotionController](https://wiki.facepunch.com/gmod/Entity:StartMotionController).

You can remove added [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ects by using [Entity:RemoveFromMotionController](https://wiki.facepunch.com/gmod/Entity:RemoveFromMotionController).

**Arguments:**
- `physObj` (PhysObj) — The PhysObj to add to the motion controller.

> **Note:** Only works on a scripted [Entity](https://wiki.facepunch.com/gmod/Entity) of anim type

[wiki](https://wiki.facepunch.com/gmod/Entity:AddToMotionController)

---

### Entity:AlignAngles · Shared
`Entity:AlignAngles(from: Angle, to: Angle) → Angle`

Returns an angle based on the ones inputted that you can use to align an object.

**Arguments:**
- `from` (Angle) — The angle you want to align from
- `to` (Angle) — The angle you want to align to

**Returns:**
- Angle — The resulting aligned angle

> **Note:** This function doesn't change the angle of the entity on its own (see example).

[wiki](https://wiki.facepunch.com/gmod/Entity:AlignAngles)

---

### Entity:Alive · Shared
`Entity:Alive() → boolean`

Checks if the entity is considered alive.

Checks entity's internal life state variable. Does not check health, but it is generally expected the health to be 0 or below at the point of an entity being considered dead. This internally looks up the save value `m_lifeState`

**Returns:**
- boolean — Whether the entity is considered alive.

[wiki](https://wiki.facepunch.com/gmod/Entity:Alive)

---

### Entity:BecomeRagdollOnClient · Client
`Entity:BecomeRagdollOnClient() → Entity`

Spawns a clientside ragdoll for the entity, positioning it in place of the original entity, and makes the entity invisible. It doesn't preserve flex values (face posing) as CSRagdolls don't support flex.

It does not work on players. Use [Player:CreateRagdoll](https://wiki.facepunch.com/gmod/Player:CreateRagdoll) instead.

The original entity is not removed, and neither are any ragdolls previously generated with this function.

To make the entity re-appear, run [Entity:SetNoDraw](https://wiki.facepunch.com/gmod/Entity:SetNoDraw)( false )

**Returns:**
- Entity — The created ragdoll.

[wiki](https://wiki.facepunch.com/gmod/Entity:BecomeRagdollOnClient)

---

### Entity:BeingLookedAtByLocalPlayer · Client
`Entity:BeingLookedAtByLocalPlayer() → boolean`

Returns true if the entity is being looked at by the local player and is within 256 units of distance.

**Returns:**
- boolean — Is the entity being looked at by the local player and within 256 units.

> **Note:** This function is only available in entities that are based off of sandbox's base_gmodentity.

[wiki](https://wiki.facepunch.com/gmod/Entity:BeingLookedAtByLocalPlayer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/entities/base_gmodentity.lua#L10-L35)

---

### Entity:Blocked · Server · `INTERNAL`
`Entity:Blocked(entity: Entity)`

Dispatches blocked events to this entity's blocked handler. This function is only useful when interacting with entities like func_movelinear.

**Arguments:**
- `entity` (Entity) — The entity that is blocking us

[wiki](https://wiki.facepunch.com/gmod/Entity:Blocked)

---

### Entity:BodyTarget · Server
`Entity:BodyTarget(origin: Vector, noisy: boolean = false) → Vector`

Returns a centered vector of this entity, NPCs use this internally to aim at their targets.

**Arguments:**
- `origin` (Vector) — The vector of where the the attack comes from.
- `noisy` (boolean, default `false`) — Decides if it should return the centered vector with a random offset to it.

**Returns:**
- Vector — The centered vector.

> **Note:** This only works on players and NPCs.

[wiki](https://wiki.facepunch.com/gmod/Entity:BodyTarget)

---

### Entity:BoneHasFlag · Shared
`Entity:BoneHasFlag(boneID: number, flag: number{BONE}) → boolean`

Returns whether the entity's bone has the flag or not.

**Arguments:**
- `boneID` (number) — Bone ID to test flag of.
- `flag` (number{BONE}) — The flag to test, see BONE

**Returns:**
- boolean — Whether the bone has that flag or not

[wiki](https://wiki.facepunch.com/gmod/Entity:BoneHasFlag)

---

### Entity:BoneLength · Shared
`Entity:BoneLength(boneID: number) → number`

Returns the length between given bone's position and the position of given bone's parent.

**Arguments:**
- `boneID` (number) — The ID of the bone you want the length of.

**Returns:**
- number — The length of the bone

[wiki](https://wiki.facepunch.com/gmod/Entity:BoneLength)

---

### Entity:BoundingRadius · Shared
`Entity:BoundingRadius() → number`

Returns the distance between the center of the bounding box and the furthest bounding box corner.

**Returns:**
- number — The radius of the bounding box.

[wiki](https://wiki.facepunch.com/gmod/Entity:BoundingRadius)

---

### Entity:CallDTVarProxies · Shared
`Entity:CallDTVarProxies(type: string, slot: number, newValue: any)`

Calls all [Entity:NetworkVarNotify](https://wiki.facepunch.com/gmod/Entity:NetworkVarNotify) functions with the given new value, but doesn't change the real value.

**Arguments:**
- `type` (string) — The NetworkVar Type.
- `slot` (number) — The NetworkVar slot.
- `newValue` (any) — The new value.

[wiki](https://wiki.facepunch.com/gmod/Entity:CallDTVarProxies) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L345-L352)

---

### Entity:CallOnRemove · Shared
`Entity:CallOnRemove(identifier: any, removeFunc: function, args: vararg)`

Causes a specified function to be run if the entity is removed by any means. This can later be undone by [Entity:RemoveCallOnRemove](https://wiki.facepunch.com/gmod/Entity:RemoveCallOnRemove) if you need it to not run.

**Arguments:**
- `identifier` (any) — Identifier that can be optionally used with Entity:RemoveCallOnRemove to undo this call on remove.
- `removeFunc` (function) — Function to be called on remove.
- `args` (vararg) — Optional arguments to pass to removeFunc.

> **Warning:** An error being thrown inside `removeFunc` will stop other `EntityRemoved` hooks from executing.
> **Warning:** This hook is called clientside during full updates. See [GM:EntityRemoved](https://wiki.facepunch.com/gmod/GM:EntityRemoved) for more information.

[wiki](https://wiki.facepunch.com/gmod/Entity:CallOnRemove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L120-L132)

---

### Entity:ClearAllOutputs · Server
`Entity:ClearAllOutputs(outputName: string = nil)`

Clears all registered events for map I/O outputs on this entity. If a string is given, will use the string as a wildcard to limit removed outputs by name matches.

**Arguments:**
- `outputName` (string, default `nil`) — An optional string that will be used to limit removed outputs by name matches, supports wildcards.

[wiki](https://wiki.facepunch.com/gmod/Entity:ClearAllOutputs)

---

### Entity:ClearPoseParameters · Shared
`Entity:ClearPoseParameters()`

Resets all pose parameters such as aim_yaw, aim_pitch and rotation.

[wiki](https://wiki.facepunch.com/gmod/Entity:ClearPoseParameters)

---

### Entity:CollisionRulesChanged · Shared
`Entity:CollisionRulesChanged()`

Declares that the collision rules of the entity have changed, and subsequent calls for [GM:ShouldCollide](https://wiki.facepunch.com/gmod/GM:ShouldCollide) with this entity may return a different value than they did previously.

> **Warning:** Failure to use this function correctly will result in a crash of the physics engine.
> **Warning:** This function must **not** be called inside of [GM:ShouldCollide](https://wiki.facepunch.com/gmod/GM:ShouldCollide). Instead, it must be called in advance when the condition is known to change.

[wiki](https://wiki.facepunch.com/gmod/Entity:CollisionRulesChanged)

---

### Entity:CopyBoneMatrix · Shared
`Entity:CopyBoneMatrix(boneID: number, data: VMatrix)`

Same as [Entity:GetBoneMatrix](https://wiki.facepunch.com/gmod/Entity:GetBoneMatrix), but instead of returning a new matrix object, it copies the data to a given matrix.

This is measurably faster when accessing bone matrices a lot.

**Arguments:**
- `boneID` (number) — The bone ID to retrieve matrix of, starting at index 0.
- `data` (VMatrix) — The matrix to copy the bone matrix to.

[wiki](https://wiki.facepunch.com/gmod/Entity:CopyBoneMatrix)

---

### Entity:CreateBoneFollowers · Server
`Entity:CreateBoneFollowers(bone_whitelist: table = nil)`

Creates bone followers based on the current entity model.

Bone followers are [Entities](https://wiki.facepunch.com/gmod/Entity) whose [Physics Object](https://wiki.facepunch.com/gmod/PhysObj) follows a specific bone on another Entity's model.  
This is what is used by `prop_dynamic` for things like big combine doors for vehicles with multiple physics objects which follow the visual mesh of the door when it animates.

Be mindful that bone followers create a separate entity (`phys_bone_follower`) for each physics object.

You must call [Entity:UpdateBoneFollowers](https://wiki.facepunch.com/gmod/Entity:UpdateBoneFollowers) every tick for bone followers to update their positions.

**Arguments:**
- `bone_whitelist` (table, default `nil`) — If set, a whitelist of bone names to create bone followers for.

> **Note:** This function only works on `anim`, `nextbot` and `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:CreateBoneFollowers)

---

### Entity:CreatedByMap · Shared
`Entity:CreatedByMap() → boolean`

Returns whether the entity was created by map or not.

**Returns:**
- boolean — Is created by map?

[wiki](https://wiki.facepunch.com/gmod/Entity:CreatedByMap)

---

### Entity:CreateParticleEffect · Client
`Entity:CreateParticleEffect(particle: string, attachment: number, options: table = nil) → CNewParticleEffect`

Creates a clientside particle system attached to the entity. See also [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem)

**Arguments:**
- `particle` (string) — The particle name to create
- `attachment` (number) — Attachment ID to attach the particle to
- `options` (table, default `nil`) — A table of tables ( IDs 1 to 64 ) having the following structure: * number attachtype - The particle attach type.

**Returns:**
- CNewParticleEffect — The created particle system.

> **Note:** The particle effect must be precached with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem) and the file its from must be added via [game.AddParticles](https://wiki.facepunch.com/gmod/game.AddParticles) before it can be used!

[wiki](https://wiki.facepunch.com/gmod/Entity:CreateParticleEffect)

---

### Entity:CreateShadow · Client
`Entity:CreateShadow()`

Draws the shadow of an entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:CreateShadow)

---

### Entity:DeleteOnRemove · Server
`Entity:DeleteOnRemove(entityToRemove: Entity)`

Whenever the entity is removed, entityToRemove will be removed also.

**Arguments:**
- `entityToRemove` (Entity) — The entity to be removed

[wiki](https://wiki.facepunch.com/gmod/Entity:DeleteOnRemove)

---

### Entity:DestroyBoneFollowers · Server
`Entity:DestroyBoneFollowers()`

Destroys bone followers created by [Entity:CreateBoneFollowers](https://wiki.facepunch.com/gmod/Entity:CreateBoneFollowers).

> **Note:** This function only works on `anim` type entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:DestroyBoneFollowers)

---

### Entity:DestroyShadow · Client
`Entity:DestroyShadow()`

Removes the shadow for the entity.

The shadow will be recreated as soon as the entity wakes.

> **Note:** Doesn't affect shadows from flashlight/lamps/env_projectedtexture.

[wiki](https://wiki.facepunch.com/gmod/Entity:DestroyShadow)

---

### Entity:DisableMatrix · Client
`Entity:DisableMatrix(matrixType: string)`

Disables an active matrix. See [Entity:EnableMatrix](https://wiki.facepunch.com/gmod/Entity:EnableMatrix) for more info about active matrixes.

**Arguments:**
- `matrixType` (string) — The name of the matrix type to disable.

[wiki](https://wiki.facepunch.com/gmod/Entity:DisableMatrix)

---

### Entity:DispatchTraceAttack · Shared
`Entity:DispatchTraceAttack(damageInfo: CTakeDamageInfo, traceRes: table, dir: Vector = traceRes.HitNormal)`

Performs a trace attack towards the entity this function is called on, as if an invisible bullet is shot towards it. Visually identical to [Entity:TakeDamageInfo](https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo).

**Arguments:**
- `damageInfo` (CTakeDamageInfo) — The damage to apply.
- `traceRes` (table) — Trace result to use to deal damage.
- `dir` (Vector, default `traceRes.HitNormal`) — Direction of the attack.

> **Note:** This function correctly applies damage to [func_breakable_surf](https://developer.valvesoftware.com/wiki/Func_breakable_surf) entities, unlike [Entity:TakeDamageInfo](https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo).
> **Warning:** Calling this function on the victim entity in [ENTITY:OnTakeDamage](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage) can cause infinite loops.

[wiki](https://wiki.facepunch.com/gmod/Entity:DispatchTraceAttack)

---

### Entity:Dissolve · Server
`Entity:Dissolve(type: number = 0, magnitude: number = 0, origin: Vector = nil, delay: number = 0)`

Dissolves the entity.

This function creates an `env_entity_dissolver` entity internally, which is parented to the target entity and remains until the entity is fully dissolved. Calling this function on an entity that is already dissolving will not create another `env_entity_dissolver` entity.

**Arguments:**
- `type` (number, default `0`) — Dissolve type.
- `magnitude` (number, default `0`) — Magnitude of the dissolve effect, its effect depends on the dissolve type.
- `origin` (Vector, default `nil`) — The origin for the dissolve effect, its effect depends on the dissolve type.
- `delay` (number, default `0`) — Delay until starting the dissolve, in seconds.

[wiki](https://wiki.facepunch.com/gmod/Entity:Dissolve)

---

### Entity:DontDeleteOnRemove · Server
`Entity:DontDeleteOnRemove(entityToUnremove: Entity)`

This removes the argument entity from an ent's list of entities to 'delete on remove'

**Arguments:**
- `entityToUnremove` (Entity) — The entity to be removed from the list of entities to delete

> **Note:** Also see [Entity:DeleteOnRemove](https://wiki.facepunch.com/gmod/Entity:DeleteOnRemove)

[wiki](https://wiki.facepunch.com/gmod/Entity:DontDeleteOnRemove)

---

### Entity:DrawModel · Client
`Entity:DrawModel(flags: number = STUDIO_RENDER)`

Draws the entity or model.

If called inside [ENTITY:Draw](https://wiki.facepunch.com/gmod/ENTITY:Draw) or [ENTITY:DrawTranslucent](https://wiki.facepunch.com/gmod/ENTITY:DrawTranslucent), it only draws the entity's model itself.

If called outside of those hooks, it will call both of said hooks depending on [Entity:GetRenderGroup](https://wiki.facepunch.com/gmod/Entity:GetRenderGroup), drawing the entire entity again.

When drawing an entity more than once per frame in different positions, you should call [Entity:SetupBones](https://wiki.facepunch.com/gmod/Entity:SetupBones) before each draw; Otherwise, the entity will retain its first drawn position.

**Arguments:**
- `flags` (number, default `STUDIO_RENDER`, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The optional STUDIO_ flags, usually taken from ENTITY:Draw and similar hooks.

> **Bug** ([#1558](https://github.com/Facepunch/garrysmod/issues/1558)): Calling this on entities with [EF_BONEMERGE](https://wiki.facepunch.com/gmod/Enums/EF) and [EF_NODRAW](https://wiki.facepunch.com/gmod/Enums/EF) applied causes a crash.
> **Bug** ([#2688](https://github.com/Facepunch/garrysmod/issues/2688)): Using this with a map model ([game.GetWorld](https://wiki.facepunch.com/gmod/game.GetWorld)():[GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel)()) crashes the game.
> **Bug** ([#4116](https://github.com/Facepunch/garrysmod/issues/4116)): Calling this on a player during that player's [GM:PrePlayerDraw](https://wiki.facepunch.com/gmod/GM:PrePlayerDraw) hook call will cause infinite recursion and crash the game.

[wiki](https://wiki.facepunch.com/gmod/Entity:DrawModel)

---

### Entity:DrawShadow · Shared
`Entity:DrawShadow(shouldDraw: boolean)`

Sets whether an entity's shadow should be drawn.

**Arguments:**
- `shouldDraw` (boolean) — True to enable, false to disable shadow drawing.

[wiki](https://wiki.facepunch.com/gmod/Entity:DrawShadow)

---

### Entity:DropToFloor · Server
`Entity:DropToFloor(mask: number = MASK_SOLID, ignoreEnt: Entity = nil, maxDist: number = 256)`

Move an entity down until it collides with something.

**Arguments:**
- `mask` (number, default `MASK_SOLID`) — Trace mask.
- `ignoreEnt` (Entity, default `nil`) — Trace ignore entity.
- `maxDist` (number, default `256`) — Max trace dist.

[wiki](https://wiki.facepunch.com/gmod/Entity:DropToFloor)

---

### Entity:DTVar · Shared · `INTERNAL`
`Entity:DTVar(type: string, slot: number, name: string, type: string, name: string)`

Sets up a self.dt.NAME alias for a Data Table variable.

**Arguments:**
- `type` (string) — The type of the DTVar being set up.
- `slot` (number) — The ID of the DTVar.
- `name` (string) — Name by which you will refer to DTVar.
- `type` (string) — The type of the DTVar being set up.
- `name` (string) — Name by which you will refer to DTVar.

[wiki](https://wiki.facepunch.com/gmod/Entity:DTVar)

---

### Entity:EmitSound · Shared
`Entity:EmitSound(soundName: string, soundLevel: number = 75, pitchPercent: number = 100, volume: number = 1, channel: number = CHAN_AUTO, CHAN_WEAPON for weapons, soundFlags: number = 0, dsp: number = 1, filter: CRecipientFilter = nil)`

Plays a sound on an entity. See also [EmitSound](https://wiki.facepunch.com/gmod/Global.EmitSound) if you wish to play sounds without an entity.

If run clientside, the sound will only be heard locally.  
If used on a player or NPC character with the mouth rigged, the character will "lip-sync" if the sound file contains lipsync data. See [this page](https://developer.valvesoftware.com/wiki/Choreography_creation/Lip_syncing) for more information.

**Arguments:**
- `soundName` (string) — The name of the sound to be played.
- `soundLevel` (number, default `75`, enum [SNDLVL](https://wiki.facepunch.com/gmod/Enums/SNDLVL)) — A modifier for the distance this sound will reach, acceptable range is 0 to 511.
- `pitchPercent` (number, default `100`) — The pitch applied to the sound.
- `volume` (number, default `1`) — The volume, from 0 to 1.
- `channel` (number, default `CHAN_AUTO, CHAN_WEAPON for weapons`, enum [CHAN](https://wiki.facepunch.com/gmod/Enums/CHAN)) — The sound channel, see CHAN.
- `soundFlags` (number, default `0`, enum [SND](https://wiki.facepunch.com/gmod/Enums/SND)) — The flags of the sound, see SND
- `dsp` (number, default `1`) — The DSP preset for this sound.
- `filter` (CRecipientFilter, default `nil`) — If set serverside, the sound will only be networked to the clients in the filter.

> **Note:** When using this function with weapons, use the [Weapon](https://wiki.facepunch.com/gmod/Weapon) itself as the entity, not its owner!
> **Warning:** Due to engine quirks, [sound scripts](https://developer.valvesoftware.com/wiki/Soundscripts) can't have their soundlevel, pitch, volume, or channel changed when played from an entity—the sound script parameters will override whatever you pass to this function.
> 
> You can do one of these instead:
> * Use [sound.GetProperties](https://wiki.facepunch.com/gmod/sound.GetProperties) to select a sound from the script, and play the sound file directly.
> * For single-use sounds, you can pass the [SND_CHANGE_VOL](https://wiki.facepunch.com/gmod/Enums/SND) or [SND_CHANGE_PITCH](https://wiki.facepunch.com/gmod/Enums/SND) sound flags. However, this will change the volume or pitch of the sound if it's already playing, instead of starting the sound over or playing another instance.
> * Use [EmitSound](https://wiki.facepunch.com/gmod/Global.EmitSound) with the entity parameter set to the [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex) of the entity you want to play the sound on.
> **Bug** ([#2651](https://github.com/Facepunch/garrysmod/issues/2651)): This does not respond to [SuppressHostEvents](https://wiki.facepunch.com/gmod/Global.SuppressHostEvents).

[wiki](https://wiki.facepunch.com/gmod/Entity:EmitSound)

---

### Entity:EnableConstraints · Server
`Entity:EnableConstraints(toggleConstraints: boolean)`

Toggles the constraints of this ragdoll entity on and off.

**Arguments:**
- `toggleConstraints` (boolean) — Set to true to enable the constraints and false to disable them.

[wiki](https://wiki.facepunch.com/gmod/Entity:EnableConstraints)

---

### Entity:EnableCustomCollisions · Shared
`Entity:EnableCustomCollisions()`

Flags an entity as using custom lua defined collisions. Fixes entities having spongy player collisions or not hitting traces, such as after [Entity:PhysicsFromMesh](https://wiki.facepunch.com/gmod/Entity:PhysicsFromMesh)

Internally identical to `Entity:AddSolidFlags( bit.bor( FSOLID_CUSTOMRAYTEST, FSOLID_CUSTOMBOXTEST ) )`

Do not confuse this function with [Entity:SetCustomCollisionCheck](https://wiki.facepunch.com/gmod/Entity:SetCustomCollisionCheck), they are not the same.

[wiki](https://wiki.facepunch.com/gmod/Entity:EnableCustomCollisions)

---

### Entity:EnableMatrix · Client
`Entity:EnableMatrix(matrixType: string, matrix: VMatrix)`

Can be used to apply a custom [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) to the entity, mostly used for scaling the model by a [Vector](https://wiki.facepunch.com/gmod/Vector).

To disable it, use [Entity:DisableMatrix](https://wiki.facepunch.com/gmod/Entity:DisableMatrix).

If your old scales are wrong due to a recent update, use [Entity:SetLegacyTransform](https://wiki.facepunch.com/gmod/Entity:SetLegacyTransform) as a quick fix.

**Arguments:**
- `matrixType` (string) — The name of the matrix type.
- `matrix` (VMatrix) — The matrix to apply before drawing the entity.

> **Note:** The matrix can also be modified to apply a custom rotation and offset via the [VMatrix:SetAngles](https://wiki.facepunch.com/gmod/VMatrix:SetAngles) and [VMatrix:SetTranslation](https://wiki.facepunch.com/gmod/VMatrix:SetTranslation) functions.
> **Bug** ([#3502](https://github.com/Facepunch/garrysmod/issues/3502)): This does not scale procedural bones, and disables inverse kinematics of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:EnableMatrix)

---

### Entity:EntIndex · Shared
`Entity:EntIndex() → number`

Gets the unique entity index of an entity.

**Returns:**
- number — The index of the entity.

> **Note:** Entity indices are marked as unused after deletion, and can be reused by newly-created entities

[wiki](https://wiki.facepunch.com/gmod/Entity:EntIndex)

---

### Entity:Extinguish · Server
`Entity:Extinguish()`

Extinguishes the entity if it is on fire.

Has no effect if called inside [GM:EntityTakeDamage](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage) (and the attacker is the flame that's hurting the entity)

See also [Entity:Ignite](https://wiki.facepunch.com/gmod/Entity:Ignite).

[wiki](https://wiki.facepunch.com/gmod/Entity:Extinguish)

---

### Entity:EyeAngles · Shared
`Entity:EyeAngles() → Angle`

Returns the direction a player, npc or ragdoll is looking as a world-oriented angle.

**Returns:**
- Angle — Player's eye angle.

> **Bug** ([#1150](https://github.com/Facepunch/garrysmod/issues/1150)): This can return an incorrect value in vehicles (like pods, buggy, ...). **This bug has been fixed in the past but was causing many addons being broken, so the fix has been removed but applied to [Player:GetAimVector](https://wiki.facepunch.com/gmod/Player:GetAimVector) only**.
> **Bug** ([#2620](https://github.com/Facepunch/garrysmod/issues/2620)): This may return local angles in jeeps when used with [Player:EnterVehicle](https://wiki.facepunch.com/gmod/Player:EnterVehicle). **A workaround is available in the second example.**

[wiki](https://wiki.facepunch.com/gmod/Entity:EyeAngles)

---

### Entity:EyePos · Shared
`Entity:EyePos() → Vector`

Returns the position of an Player/NPC's view.

**Returns:**
- Vector — View position of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:EyePos)

---

### Entity:FindBodygroupByName · Shared
`Entity:FindBodygroupByName(name: string) → number`

Searches the [Entity's](https://wiki.facepunch.com/gmod/Entity) model for a Body Group with a given name.

**Arguments:**
- `name` (string) — The name to search for.

**Returns:**
- number — The Body Group's ID or `-1` if no Body Group has the provided name.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:FindBodygroupByName)

---

### Entity:FindGestureLayer · Server
`Entity:FindGestureLayer(activity: number{ACT}) → number`

Searches the currently active layers for a layer playing animation with given activity.

**Arguments:**
- `activity` (number{ACT}) — The activity to search for.

**Returns:**
- `layerID` (number) — A layer ID for given activity, or `-1` if not found.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:FindGestureLayer)

---

### Entity:FindGestureSequenceLayer · Server
`Entity:FindGestureSequenceLayer(sequenceID: number) → number`

Searches the currently active layers for a layer playing animation with given sequence.

**Arguments:**
- `sequenceID` (number) — The sequence ID to search for.

**Returns:**
- `layerID` (number) — A layer ID for given sequence, or `-1` if not found.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:FindGestureSequenceLayer)

---

### Entity:FindTransitionSequence · Shared
`Entity:FindTransitionSequence(currentSequence: number, goalSequence: number) → number`

Returns a transition from the given start and end sequence.

This function was only used by HL1 entities and NPCs, before the advent of sequence blending and gestures.

**Arguments:**
- `currentSequence` (number) — The currently playing sequence
- `goalSequence` (number) — The goal sequence.

**Returns:**
- number — The transition sequence, -1 if not available.

[wiki](https://wiki.facepunch.com/gmod/Entity:FindTransitionSequence)

---

### Entity:Fire · Server
`Entity:Fire(input: string, param: string|number|boolean = nil, delay: number = 0, activator: Entity = nil, caller: Entity = nil)`

Fires an entity's input, conforming to the map IO event queue system. You can find inputs for most entities on the [Valve Developer Wiki](https://developer.valvesoftware.com/wiki/Output)

See also [Entity:Input](https://wiki.facepunch.com/gmod/Entity:Input) for a function that bypasses the event queue and [GM:AcceptInput](https://wiki.facepunch.com/gmod/GM:AcceptInput).

**Arguments:**
- `input` (string) — The name of the input to fire
- `param` (string|number|boolean, default `nil`) — The value to give to the input, can also be a number or a boolean.
- `delay` (number, default `0`) — Delay in seconds before firing
- `activator` (Entity, default `nil`) — The entity that caused this input (i.e.
- `caller` (Entity, default `nil`) — The entity that is triggering this input (i.e.

[wiki](https://wiki.facepunch.com/gmod/Entity:Fire)

---

### Entity:FireBullets · Shared
`Entity:FireBullets(bulletInfo: table{Bullet}, suppressHostEvents: boolean = false)`

Fires a bullet.

When used in a  hook such as [WEAPON:Think](https://wiki.facepunch.com/gmod/WEAPON:Think) or [WEAPON:PrimaryAttack](https://wiki.facepunch.com/gmod/WEAPON:PrimaryAttack), it will use [Player:LagCompensation](https://wiki.facepunch.com/gmod/Player:LagCompensation) internally.

Lag compensation will not work if this function is called in a timer, regardless if the timer was made in a predicted hook.

Due to how `Entity:FireBullets` is set up internally, bullet tracers will always originate from the first attachment/index 1. This can be avoided by supplying your own tracer effect.

When firing bullets from a [Weapon](https://wiki.facepunch.com/gmod/Weapon), it is recommended to fire bullets from the weapon owner entity ([Player](https://wiki.facepunch.com/gmod/Player) or [NPC](https://wiki.facepunch.com/gmod/NPC)), not the [Weapon](https://wiki.facepunch.com/gmod/Weapon) itself.

**Arguments:**
- `bulletInfo` (table{Bullet}) — The bullet data to be used.
- `suppressHostEvents` (boolean, default `false`) — Has the effect of encasing the FireBullets call in SuppressHostEvents, only works in multiplayer.

[wiki](https://wiki.facepunch.com/gmod/Entity:FireBullets)

---

### Entity:FollowBone · Shared
`Entity:FollowBone(parent: Entity = NULL, boneid: number)`

Makes an entity follow another entity's bone.

Internally this function calls [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent)( parent, boneid ), [Entity:AddEffects](https://wiki.facepunch.com/gmod/Entity:AddEffects)( EF_FOLLOWBONE 
 ) and sets an internal flag to always rebuild all bones.

**Arguments:**
- `parent` (Entity, default `NULL`) — The entity to follow the bone of.
- `boneid` (number) — The bone to follow

> **Note:** If the entity vibrates or stops following the parent, you probably need to run [Entity:SetPredictable](https://wiki.facepunch.com/gmod/Entity:SetPredictable)( true ) clientside.
> **Warning:** This function will not work if the target bone's parent bone is invalid or if the bone is not used by VERTEX LOD0

[wiki](https://wiki.facepunch.com/gmod/Entity:FollowBone)

---

### Entity:ForcePlayerDrop · Shared
`Entity:ForcePlayerDrop()`

Forces the entity to be dropped, if it is being held by a player's Gravity Gun, Physics Gun or `+use` pickup.

See also [Player:DropObject](https://wiki.facepunch.com/gmod/Player:DropObject).

[wiki](https://wiki.facepunch.com/gmod/Entity:ForcePlayerDrop)

---

### Entity:FrameAdvance · Shared
`Entity:FrameAdvance()`

Advances the cycle of an animated entity.

Animations that loop will automatically reset the cycle so you don't have to - ones that do not will stop animating once you reach the end of their sequence.

> **Warning:** Do not call this function multiple times a frame, as it can cause unexpected results, such as animations playing at increased rate, etc.
> 
> [NextBot:BodyMoveXY](https://wiki.facepunch.com/gmod/NextBot:BodyMoveXY) calls this internally, so do not call this function before or after [NextBot:BodyMoveXY](https://wiki.facepunch.com/gmod/NextBot:BodyMoveXY).

[wiki](https://wiki.facepunch.com/gmod/Entity:FrameAdvance)

---

### Entity:GetAbsVelocity · Shared
`Entity:GetAbsVelocity() → Vector`

Returns the entity's velocity.

**Returns:**
- Vector — The velocity of the entity.

> **Note:** Actually binds to CBaseEntity::GetLocalVelocity() which retrieves the velocity of the entity due to its movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAbsVelocity)

---

### Entity:GetAngles · Shared
`Entity:GetAngles() → Angle`

Gets the angles of given entity.

**Returns:**
- Angle — The angles of the entity.

> **Bug** ([#2764](https://github.com/Facepunch/garrysmod/issues/2764)): This returns incorrect results for the local player clientside.
> **Bug** ([#3106](https://github.com/Facepunch/garrysmod/issues/3106)): This will return the local player's [EyeAngles](https://wiki.facepunch.com/gmod/Global.EyeAngles) in [rendering hooks](https://wiki.facepunch.com/gmod/3D_Rendering_Hooks).
> **Bug** ([#3107](https://github.com/Facepunch/garrysmod/issues/3107)): This will return [Angle](https://wiki.facepunch.com/gmod/Global.Angle)(0,0,0) in [rendering hooks](https://wiki.facepunch.com/gmod/3D_Rendering_Hooks) while paused in single-player.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAngles)

---

### Entity:GetAnimCount · Shared
`Entity:GetAnimCount() → number`

Returns the amount of animations (not to be confused with sequences) the entity's model has. A sequence can consist of multiple animations.

See also [Entity:GetAnimInfo](https://wiki.facepunch.com/gmod/Entity:GetAnimInfo)

**Returns:**
- number — The amount of animations the entity's model has.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAnimCount)

---

### Entity:GetAnimInfo · Shared
`Entity:GetAnimInfo(animIndex: number) → table|nil`

Returns a table containing the number of frames, flags, name, and FPS of an entity's animation ID.

**Arguments:**
- `animIndex` (number) — The animation ID to look up, starting at 0.

**Returns:**
- table|nil — Information about the animation, or `nil` if the index is out of bounds.

> **Note:** Animation ID is not the same as sequence ID. See [Entity:GetAnimCount](https://wiki.facepunch.com/gmod/Entity:GetAnimCount)

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAnimInfo)

---

### Entity:GetAnimTime · Client
`Entity:GetAnimTime() → number`

Returns the last time the entity had an animation update. Returns 0 if the entity doesn't animate.

**Returns:**
- number — The last time the entity had an animation update.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAnimTime)

---

### Entity:GetAnimTimeInterval · Shared
`Entity:GetAnimTimeInterval() → number`

Returns the amount of time since last animation.

Works only on `CBaseAnimating` entities.

**Returns:**
- number — The amount of time since last animation.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAnimTimeInterval)

---

### Entity:GetAttachment · Shared
`Entity:GetAttachment(attachmentId: number) → table{AngPos}|nil`

Gets the orientation and position of the attachment by its ID, returns nothing if the attachment does not exist.

**Arguments:**
- `attachmentId` (number) — The internal ID of the attachment.

**Returns:**
- table{AngPos}|nil — The table with angle and position of the attachment or `nil` if does not exist.

> **Note:** The update rate of this function is limited by the setting of ENT.AutomaticFrameAdvance for [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities)!
> **Bug** ([#1255](https://github.com/Facepunch/garrysmod/issues/1255)): This will return improper values for viewmodels if used in [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView).

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAttachment)

---

### Entity:GetAttachments · Shared
`Entity:GetAttachments() → table`

Returns a table containing all attachments of the given entity's model.

**Returns:**
- table — Attachment data.

> **Bug** ([#3167](https://github.com/Facepunch/garrysmod/issues/3167)): This can have inconsistent results in single-player.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetAttachments)

---

### Entity:GetBaseVelocity · Shared
`Entity:GetBaseVelocity() → Vector`

Returns the entity's base velocity which is their velocity due to forces applied by other entities. This includes entity-on-entity collision or riding a treadmill.

**Returns:**
- Vector — The base velocity of the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBaseVelocity)

---

### Entity:GetBloodColor · Shared
`Entity:GetBloodColor() → number{BLOOD_COLOR}`

Returns the blood color of this entity. This can be set with [Entity:SetBloodColor](https://wiki.facepunch.com/gmod/Entity:SetBloodColor).

**Returns:**
- number{BLOOD_COLOR} — Color from BLOOD_COLOR or nil

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBloodColor)

---

### Entity:GetBodygroup · Shared
`Entity:GetBodygroup(bodyGroupId: number) → number`

Returns the [Sub Model ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#submodels) for the currently active [Sub Model](https://wiki.facepunch.com/gmod/Entity:GetSubModels) of the Body Group corresponding to the given [Body Group ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id).

**Arguments:**
- `bodyGroupId` (number) — The Body Group ID to retrieve the active Sub Model ID for.

**Returns:**
- number — The currently active Sub Model ID.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBodygroup)

---

### Entity:GetBodygroupCount · Shared
`Entity:GetBodygroupCount(bodyGroupId: number) → number`

Returns the number of [Sub Models](https://wiki.facepunch.com/gmod/Entity:GetSubModels) in the Body Group corresponding to a given [Body Group ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id) of the [Entity's](https://wiki.facepunch.com/gmod/Entity) model.

**Arguments:**
- `bodyGroupId` (number) — The Body Group ID to retrieve the Sub Model count of.

**Returns:**
- number — The number of Sub Models in the Body Group.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBodygroupCount)

---

### Entity:GetBodygroupName · Shared
`Entity:GetBodygroupName(bodyGroupId: number) → string`

Retrieves the name of the Body Group corresponding to a given [Body Group ID](https://wiki.facepunch.com/gmod/Structures/BodyGroupData#id) on the [Entity's](https://wiki.facepunch.com/gmod/Entity) model.

**Arguments:**
- `bodyGroupId` (number) — The Body Group ID to get the name of.

**Returns:**
- string — The name of the Body Group.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBodygroupName)

---

### Entity:GetBodyGroups · Shared
`Entity:GetBodyGroups() → table`

Returns a list of information about each Body Group present on the [Entity's](https://wiki.facepunch.com/gmod/Entity) model.

**Returns:**
- table — A table of Body Group information where each value is a Structures/BodyGroupData.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBodyGroups)

---

### Entity:GetBoneContents · Shared
`Entity:GetBoneContents(bone: number) → number`

Returns the contents of the specified bone.

**Arguments:**
- `bone` (number) — The bone id, starting at index 0.

**Returns:**
- number — The contents as a CONTENTS or 0 on failure.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneContents)

---

### Entity:GetBoneController · Shared
`Entity:GetBoneController(boneID: number) → number`

Returns the value of the bone controller with the specified ID.

**Arguments:**
- `boneID` (number) — ID of the bone controller.

**Returns:**
- number — The value set on the bone controller.

> **Note:** This is the precursor of pose parameters, and only works for Half Life 1: Source models supporting it.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneController)

---

### Entity:GetBoneCount · Shared
`Entity:GetBoneCount() → number`

Returns the amount of bones in the entity.

**Returns:**
- number — The amount of bones in given entity, starting at index 0.

> **Note:** Will return `0` for [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel) or undrawn entities until [Entity:SetupBones](https://wiki.facepunch.com/gmod/Entity:SetupBones) is called on the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneCount)

---

### Entity:GetBoneMatrix · Shared
`Entity:GetBoneMatrix(boneID: number) → VMatrix`

Returns the transformation matrix of a given bone on the entity's model. The matrix contains the transformation used to position the bone in the world. It is not relative to the parent bone.

This is equivalent to constructing a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) using [Entity:GetBonePosition](https://wiki.facepunch.com/gmod/Entity:GetBonePosition).

See [Entity:CopyBoneMatrix](https://wiki.facepunch.com/gmod/Entity:CopyBoneMatrix) for a more performant version.

**Arguments:**
- `boneID` (number) — The bone ID to retrieve matrix of, starting at index 0.

**Returns:**
- VMatrix — The matrix * Some entities don't update animation every frame such as prop_physics and won't have accurate bone matrix.

> **Bug** ([#884](https://github.com/Facepunch/garrysmod/issues/884)): This can return the server's matrix during server lag.
> **Bug** ([#3285](https://github.com/Facepunch/garrysmod/issues/3285)): This can return garbage serverside or a 0,0,0 fourth column (represents position) for v49 models.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneMatrix)

---

### Entity:GetBoneName · Shared
`Entity:GetBoneName(index: number) → string`

Returns name of given bone id.

	See [Entity:LookupBone](https://wiki.facepunch.com/gmod/Entity:LookupBone) for the inverse of this function.

**Arguments:**
- `index` (number) — ID of bone to lookup name of, starting at index 0.

**Returns:**
- string — The name of given bone.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneName)

---

### Entity:GetBoneParent · Shared
`Entity:GetBoneParent(bone: number) → number`

Returns parent bone of given bone.

**Arguments:**
- `bone` (number) — The bone ID of the bone to get parent of, starting at index 0.

**Returns:**
- number — Parent bone ID or -1 if we failed for some reason.

> **Note:** Will return -1 for [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel) until [Entity:SetupBones](https://wiki.facepunch.com/gmod/Entity:SetupBones) is called on the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneParent)

---

### Entity:GetBonePosition · Shared
`Entity:GetBonePosition(boneIndex: number) → Vector, Angle`

Returns the position and angle of the given attachment, relative to the world.

**Arguments:**
- `boneIndex` (number) — The bone index of the bone to get the position of, starting at index 0.

**Returns:**
- Vector — The bone's position relative to the world.
- Angle — The bone's angle relative to the world.

> **Note:** This function returns the bone position from the last tick, so if your framerate is higher than the server's tickrate it may appear to lag behind if used on a fast moving entity. You can fix this by using the bone's matrix instead:
> ```lua
> local matrix = entity:GetBoneMatrix(0)
> local pos = matrix:GetTranslation()
> local ang = matrix:GetAngles()
> ```
> **Warning:** This function can return entity's `GetPos()` instead if the entity doesn't have it's bone cache set up.
> 
> To ensure the bone position is correct use this:
> ```lua
> local pos = ent:GetBonePosition(0)
> if pos == ent:GetPos() then
> 	pos = ent:GetBoneMatrix(0):GetTranslation()
> end
> ```
> **Bug** ([#884](https://github.com/Facepunch/garrysmod/issues/884)): This can return the server's position during server lag.
> **Bug** ([#3285](https://github.com/Facepunch/garrysmod/issues/3285)): This can return garbage serverside or [Vector](https://wiki.facepunch.com/gmod/Global.Vector)(0,0,0) for v49 models.
> **Bug** ([#3739](https://github.com/Facepunch/garrysmod/issues/3739)): This can return garbage if a trace passed through the target bone during bone matrix access.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBonePosition)

---

### Entity:GetBoneSurfaceProp · Shared
`Entity:GetBoneSurfaceProp(bone: number) → string`

Returns the surface property of the specified bone. See [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) for more details about what they are.

**Arguments:**
- `bone` (number) — The bone id, starting at index 0.

**Returns:**
- string — The surface property of the bone to be used with util.GetSurfaceIndex or an empty string on failure.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBoneSurfaceProp)

---

### Entity:GetBrushPlane · Shared
`Entity:GetBrushPlane(id: number) → Vector, Vector, number`

Returns info about given plane of non-nodraw brush model surfaces of the entity's model. Works on worldspawn as well.

**Arguments:**
- `id` (number) — The index of the plane to get info of.

**Returns:**
- Vector — The origin of the plane.
- Vector — The normal of the plane.
- number — The "distance" of the plane.

> **Warning:** This only works on entities with brush models.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBrushPlane)

---

### Entity:GetBrushPlaneCount · Shared
`Entity:GetBrushPlaneCount() → number`

Returns the amount of planes of non-nodraw brush model surfaces of the entity's model.

**Returns:**
- number — The amount of brush model planes of the entity's model.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBrushPlaneCount)

---

### Entity:GetBrushSurfaces · Shared
`Entity:GetBrushSurfaces() → table<SurfaceInfo>`

Returns a table of brushes surfaces for brush model entities.

**Returns:**
- table<SurfaceInfo> — A list of SurfaceInfo elements if the entity has a brush model, or `nil` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetBrushSurfaces)

---

### Entity:GetCallbacks · Shared
`Entity:GetCallbacks(hook: string) → table`

Returns the specified hook callbacks for this entity added with [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback)

The callbacks can then be removed with [Entity:RemoveCallback](https://wiki.facepunch.com/gmod/Entity:RemoveCallback).

**Arguments:**
- `hook` (string) — The hook to retrieve the callbacks from, see Entity Callbacks for the possible hooks.

**Returns:**
- table — A table containing the callbackid and function of all the callbacks for the specified hook

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCallbacks)

---

### Entity:GetChildBones · Shared
`Entity:GetChildBones(boneid: number) → table`

Returns ids of child bones of given bone.

**Arguments:**
- `boneid` (number) — Bone id to lookup children of

**Returns:**
- table — A table of bone ids

[wiki](https://wiki.facepunch.com/gmod/Entity:GetChildBones) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L196-L210)

---

### Entity:GetChildren · Shared
`Entity:GetChildren() → table<Entity>`

Gets the children of the entity - that is, every entity whose move parent is this entity.

**Returns:**
- table<Entity> — A list of movement children entities

> **Note:** This function returns [Entity:SetMoveParent](https://wiki.facepunch.com/gmod/Entity:SetMoveParent) children, **NOT** [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent)!
> 
> [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent) however also calls [Entity:SetMoveParent](https://wiki.facepunch.com/gmod/Entity:SetMoveParent).
> 
> 
> 
> This means that some entities in the returned list might have a NULL [Entity:GetParent](https://wiki.facepunch.com/gmod/Entity:GetParent).
> 
> This also means that using this function on players will return their weapons on the client but not the server.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetChildren)

---

### Entity:GetClass · Shared
`Entity:GetClass() → string`

Returns the classname of a entity. This is often the name of the Lua file or folder containing the files for the entity

**Returns:**
- string — The entity's classname

[wiki](https://wiki.facepunch.com/gmod/Entity:GetClass)

---

### Entity:GetCollisionBounds · Shared
`Entity:GetCollisionBounds() → Vector, Vector`

Returns an entity's collision bounding box.

In most cases, this will return the same bounding box as [Entity:GetModelBounds](https://wiki.facepunch.com/gmod/Entity:GetModelBounds) unless the entity does not have a physics mesh or it has a [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) different from the default.

Collision bounds can be previewed in singleplayer via `ent_bbox` console command, while looking at a desired entity and with `developer 1`. (Will appear as an orange wireframe box)

**Returns:**
- Vector — The minimum vector of the collision bounds, basically Entity:OBBMins.
- Vector — The maximum vector of the collision bounds, basically Entity:OBBMaxs.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds)

---

### Entity:GetCollisionGroup · Shared
`Entity:GetCollisionGroup() → number{COLLISION_GROUP}`

Returns the entity's collision group

**Returns:**
- number{COLLISION_GROUP} — The collision group.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCollisionGroup)

---

### Entity:GetColor · Shared
`Entity:GetColor() → Color`

Returns the color the entity is set to.

**Returns:**
- Color — The color of the entity as a Color.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L167-L176)

---

### Entity:GetColor4Part · Shared · `INTERNAL`
`Entity:GetColor4Part() → number, number, number, number`

Returns the color the entity is set to without using a color object.

**Returns:**
- `r` (number)
- `g` (number)
- `b` (number)
- `a` (number)

[wiki](https://wiki.facepunch.com/gmod/Entity:GetColor4Part)

---

### Entity:GetConstrainedEntities · Server
`Entity:GetConstrainedEntities() → Entity, Entity`

Returns the two entities involved in a constraint ent, or nil if the entity is not a constraint.

**Returns:**
- Entity — ent1
- Entity — ent2

[wiki](https://wiki.facepunch.com/gmod/Entity:GetConstrainedEntities)

---

### Entity:GetConstrainedPhysObjects · Server
`Entity:GetConstrainedPhysObjects() → PhysObj, PhysObj`

Returns the two entities physobjects involved in a constraint ent, or no value if the entity is not a constraint.

**Returns:**
- PhysObj — phys1
- PhysObj — phys2

[wiki](https://wiki.facepunch.com/gmod/Entity:GetConstrainedPhysObjects)

---

### Entity:GetCreationID · Shared
`Entity:GetCreationID() → number`

Returns entity's creation ID. Unlike [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex) or [Entity:MapCreationID](https://wiki.facepunch.com/gmod/Entity:MapCreationID).

It will increase up until value of `10 000 000`, at which point it will reset back to `0`.

**Returns:**
- number — The creation ID

> **Bug:** This returns `0` for clientside only entities, such as `class CLuaEffect`.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCreationID)

---

### Entity:GetCreationTime · Shared
`Entity:GetCreationTime() → number`

Returns the time the entity was created on, relative to [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime).

**Returns:**
- number — The time the entity was created on.

> **Bug:** This returns `0` for clientside only entities, such as `class CLuaEffect`.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCreationTime)

---

### Entity:GetCreator · Server
`Entity:GetCreator() → Player`

Gets the creator of the SENT.

**Returns:**
- Player — The creator, NULL for no creator.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCreator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L81-L83)

---

### Entity:GetCustomCollisionCheck · Shared
`Entity:GetCustomCollisionCheck() → boolean`

Returns whether this entity uses custom collision check set by [Entity:SetCustomCollisionCheck](https://wiki.facepunch.com/gmod/Entity:SetCustomCollisionCheck).

**Returns:**
- boolean — Whether this entity uses custom collision check or not

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCustomCollisionCheck)

---

### Entity:GetCycle · Shared
`Entity:GetCycle() → number`

Returns the frame of the currently played sequence. This will be a number between 0 and 1 as a representation of sequence progress.

**Returns:**
- number — The frame of the currently played sequence

[wiki](https://wiki.facepunch.com/gmod/Entity:GetCycle)

---

### Entity:GetDTAngle · Shared · `INTERNAL`
`Entity:GetDTAngle(key: number) → Angle`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get an angle stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- Angle — Requested angle.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTAngle)

---

### Entity:GetDTBool · Shared · `INTERNAL`
`Entity:GetDTBool(key: number) → boolean`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get a boolean stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- boolean — Requested boolean.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTBool)

---

### Entity:GetDTEntity · Shared · `INTERNAL`
`Entity:GetDTEntity(key: number) → Entity`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Returns an entity stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- Entity — Requested entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTEntity)

---

### Entity:GetDTFloat · Shared · `INTERNAL`
`Entity:GetDTFloat(key: number) → number`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get a float stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- number — Requested float.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTFloat)

---

### Entity:GetDTInt · Shared · `INTERNAL`
`Entity:GetDTInt(key: number) → number`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get an integer stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- number — 32-bit signed integer

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTInt)

---

### Entity:GetDTString · Shared · `INTERNAL`
`Entity:GetDTString(key: number) → string`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get a string stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 3.

**Returns:**
- string — Requested string.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTString)

---

### Entity:GetDTVector · Shared · `INTERNAL`
`Entity:GetDTVector(key: number) → Vector`

This is called internally by the [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) system, you can use this in cases where using NetworkVar is not possible.

Get a vector stored in the datatable of the entity.

**Arguments:**
- `key` (number) — Goes from 0 to 31.

**Returns:**
- Vector — Requested vector.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetDTVector)

---

### Entity:GetEditingData · Shared
`Entity:GetEditingData() → table`

Returns internal data about editable [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar)s.

		This is used internally by [DEntityProperties](https://wiki.facepunch.com/gmod/DEntityProperties) and [Editable Entities](https://wiki.facepunch.com/gmod/Editable%20Entities) system.

**Returns:**
- `data` (table) — The internal data

> **Note:** This function will only work on entities which had [Entity:InstallDataTable](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) called on them, which is done automatically for players and all [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities)

[wiki](https://wiki.facepunch.com/gmod/Entity:GetEditingData)

---

### Entity:GetEffects · Shared
`Entity:GetEffects() → number`

Returns a bit flag of all engine effect flags of the entity.

**Returns:**
- number — Engine effect flags, see EF

[wiki](https://wiki.facepunch.com/gmod/Entity:GetEffects)

---

### Entity:GetEFlags · Shared
`Entity:GetEFlags() → number`

Returns a bit flag of all engine flags of the entity.

**Returns:**
- number — Engine flags, see EFL

[wiki](https://wiki.facepunch.com/gmod/Entity:GetEFlags)

---

### Entity:GetElasticity · Shared
`Entity:GetElasticity() → number`

Returns the elasticity of this entity, used by some flying entities such as the Helicopter NPC to determine how much it should bounce around when colliding.

**Returns:**
- number — elasticity

[wiki](https://wiki.facepunch.com/gmod/Entity:GetElasticity)

---

### Entity:GetFlags · Shared
`Entity:GetFlags() → number`

Returns all flags of given entity.

**Returns:**
- number — Flags of given entity as a bitflag, see FL

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlags)

---

### Entity:GetFlexBounds · Shared
`Entity:GetFlexBounds(flex: number) → number, number`

Returns acceptable value range for the flex controller, as defined by the model.

Used with [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight).

**Arguments:**
- `flex` (number) — The ID of the flex to look up bounds of

**Returns:**
- number — The minimum value for this flex
- number — The maximum value for this flex

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexBounds)

---

### Entity:GetFlexIDByName · Shared
`Entity:GetFlexIDByName(name: string) → number`

Returns the ID of the flex based on the beginning or the entire name.

**Arguments:**
- `name` (string) — The name of the flex to get the ID of.

**Returns:**
- number — The ID of flex * `nil` if no flex with given name was found

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexIDByName)

---

### Entity:GetFlexName · Shared
`Entity:GetFlexName(id: number) → string`

Returns the flex controller name at given index.

**Arguments:**
- `id` (number) — The flex index to look up name of.

**Returns:**
- string — The flex name, or no value if the requested ID is out of bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexName)

---

### Entity:GetFlexNum · Shared
`Entity:GetFlexNum() → number`

Returns the number of flex controllers this entity's model has.

**Returns:**
- number — The number of flexes.

> **Note:** Please note that while this function can return the real number of flex controllers, the game supports only a certain amount due to networking limitations. See [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight).

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexNum)

---

### Entity:GetFlexScale · Shared
`Entity:GetFlexScale() → number`

Returns the flex scale of the entity.

**Returns:**
- number — The flex scale

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexScale)

---

### Entity:GetFlexType · Shared
`Entity:GetFlexType(id: number) → string`

Returns flex controller type or "category". Used internally by Faceposer to categorize flex controllers.

**Arguments:**
- `id` (number) — The flex index to look up type of.

**Returns:**
- string — The flex type, or no value if the requested ID is out of bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexType)

---

### Entity:GetFlexWeight · Shared
`Entity:GetFlexWeight(flex: number) → number`

Returns current weight ( value ) of given flex controller. Please see [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight) regarding limitations.

**Arguments:**
- `flex` (number) — The ID of the flex to get weight of

**Returns:**
- number — The current weight of the flex, or 0 if out of bounds.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFlexWeight)

---

### Entity:GetForward · Shared
`Entity:GetForward() → Vector`

Returns the forward vector of the entity, as a normalized direction vector

**Returns:**
- Vector — forwardDir

[wiki](https://wiki.facepunch.com/gmod/Entity:GetForward)

---

### Entity:GetFriction · Shared
`Entity:GetFriction() → number`

Returns the friction modifier for this entity. Entities default to `1` (100%) and can be higher.

**Returns:**
- number — friction

[wiki](https://wiki.facepunch.com/gmod/Entity:GetFriction)

---

### Entity:GetGravity · Shared
`Entity:GetGravity() → number`

Gets the gravity multiplier of the entity.

**Returns:**
- number — gravityMultiplier

[wiki](https://wiki.facepunch.com/gmod/Entity:GetGravity)

---

### Entity:GetGroundEntity · Shared
`Entity:GetGroundEntity() → Entity`

Returns the object the entity is standing on.

**Returns:**
- Entity — The ground entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetGroundEntity)

---

### Entity:GetGroundSpeedVelocity · Server
`Entity:GetGroundSpeedVelocity() → Vector`

Returns the entity's ground speed velocity, which is based on the entity's walk/run speed and/or the ground speed of their sequence ( [Entity:GetSequenceGroundSpeed](https://wiki.facepunch.com/gmod/Entity:GetSequenceGroundSpeed) ). Will return an empty [Vector](https://wiki.facepunch.com/gmod/Vector) if the entity isn't moving on the ground.

**Returns:**
- Vector — The ground speed velocity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetGroundSpeedVelocity)

---

### Entity:GetHitBoxBone · Shared
`Entity:GetHitBoxBone(hitbox: number, hboxset: number) → number`

Gets the bone the hit box is attached to.

**Arguments:**
- `hitbox` (number) — The number of the hit box.
- `hboxset` (number) — The number of the hit box set.

**Returns:**
- number — The number of the bone.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitBoxBone)

---

### Entity:GetHitBoxBounds · Shared
`Entity:GetHitBoxBounds(hitbox: number, set: number) → Vector, Vector`

Gets the bounds (min and max corners) of a hit box.

**Arguments:**
- `hitbox` (number) — The number of the hit box.
- `set` (number) — The hitbox set of the hit box.

**Returns:**
- Vector — Hit box mins.
- Vector — Hit box maxs.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitBoxBounds)

---

### Entity:GetHitBoxCount · Shared
`Entity:GetHitBoxCount(set: number) → number`

Gets how many hit boxes are in a given hit box set.

**Arguments:**
- `set` (number) — The number of the hit box set.

**Returns:**
- number — The number of hit boxes.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitBoxCount)

---

### Entity:GetHitBoxGroupCount · Shared · `DEPRECATED`
`Entity:GetHitBoxGroupCount() → number`

Returns the number of hit box sets that an entity has. Functionally identical to [Entity:GetHitboxSetCount](https://wiki.facepunch.com/gmod/Entity:GetHitboxSetCount)

**Returns:**
- number — number of hit box sets

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitBoxGroupCount)

---

### Entity:GetHitBoxHitGroup · Shared
`Entity:GetHitBoxHitGroup(hitbox: number, hitboxset: number) → number`

Gets the hit group of a given hitbox in a given hitbox set.

**Arguments:**
- `hitbox` (number) — The number of the hit box.
- `hitboxset` (number) — The number of the hit box set.

**Returns:**
- `group` (number) — The hitbox group of given hitbox.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitBoxHitGroup)

---

### Entity:GetHitboxSet · Shared
`Entity:GetHitboxSet() → number, string`

Returns entity's current hit box set

**Returns:**
- number — The current hit box set id, or no value if the entity doesn't have hit boxes
- string — The current hit box set name, or no value if the entity doesn't have hit boxes

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitboxSet)

---

### Entity:GetHitboxSetCount · Shared
`Entity:GetHitboxSetCount() → number`

Returns the amount of hitbox sets in the entity.

**Returns:**
- number — The amount of hitbox sets in the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetHitboxSetCount)

---

### Entity:GetInternalVariable · Shared
`Entity:GetInternalVariable(variableName: string) → any`

An interface for accessing internal key values on entities.

See [Entity:GetSaveTable](https://wiki.facepunch.com/gmod/Entity:GetSaveTable) for a more detailed explanation. See [Entity:SetSaveValue](https://wiki.facepunch.com/gmod/Entity:SetSaveValue) for the opposite of this function.

**Arguments:**
- `variableName` (string) — Name of variable corresponding to an entity save value.

**Returns:**
- any — The internal variable value.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetInternalVariable)

---

### Entity:GetKeyValues · Server
`Entity:GetKeyValues() → table`

Returns a table containing Hammer key values the entity has stored. **Not all key values will be accessible this way.** Use [GM:EntityKeyValue](https://wiki.facepunch.com/gmod/GM:EntityKeyValue) or [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue) to capture and store every key value.

Single key values can usually be retrieved with [Entity:GetInternalVariable](https://wiki.facepunch.com/gmod/Entity:GetInternalVariable).

Here's a list of keyvalues that will not appear in this list, as they are not stored/defined as actual keyvalues internally:
* rendercolor - [Entity:GetColor](https://wiki.facepunch.com/gmod/Entity:GetColor) (Only RGB)
* rendercolor32 - [Entity:GetColor](https://wiki.facepunch.com/gmod/Entity:GetColor) (RGBA)
* renderamt - [Entity:GetColor](https://wiki.facepunch.com/gmod/Entity:GetColor) (Alpha)
* disableshadows - [EF_NOSHADOW](https://wiki.facepunch.com/gmod/Enums/EF#EF_NOSHADOW)
* mins - [Entity:GetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds)
* maxs - [Entity:GetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:GetCollisionBounds)
* disablereceiveshadows - [EF_NORECEIVESHADOW](https://wiki.facepunch.com/gmod/Enums/EF#EF_NORECEIVESHADOW)
* nodamageforces - [EFL_NO_DAMAGE_FORCES](https://wiki.facepunch.com/gmod/Enums/EFL#EFL_NO_DAMAGE_FORCES)
* angle - [Entity:GetAngles](https://wiki.facepunch.com/gmod/Entity:GetAngles)
* angles - [Entity:GetAngles](https://wiki.facepunch.com/gmod/Entity:GetAngles)
* origin - [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos)
* targetname - [Entity:GetName](https://wiki.facepunch.com/gmod/Entity:GetName)

**Returns:**
- table — A table of key values.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetKeyValues)

---

### Entity:GetLayerCycle · Shared
`Entity:GetLayerCycle(layerID: number) → number`

Returns the animation cycle/frame for given layer.

**Arguments:**
- `layerID` (number) — The Layer ID

**Returns:**
- number — The animation cycle/frame for given layer.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLayerCycle)

---

### Entity:GetLayerDuration · Shared
`Entity:GetLayerDuration(layerID: number) → number`

Returns the duration of given layer.

**Arguments:**
- `layerID` (number) — The Layer ID

**Returns:**
- number — The duration of the layer

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLayerDuration)

---

### Entity:GetLayerPlaybackRate · Shared
`Entity:GetLayerPlaybackRate(layerID: number) → number`

Returns the layer playback rate. See also [Entity:GetLayerDuration](https://wiki.facepunch.com/gmod/Entity:GetLayerDuration).

**Arguments:**
- `layerID` (number) — The Layer ID

**Returns:**
- `rate` (number) — The current playback rate.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLayerPlaybackRate)

---

### Entity:GetLayerSequence · Shared
`Entity:GetLayerSequence(layerID: number) → number`

Returns the sequence id of given layer.

**Arguments:**
- `layerID` (number) — The Layer ID.

**Returns:**
- number — The sequenceID of the layer.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLayerSequence)

---

### Entity:GetLayerWeight · Shared
`Entity:GetLayerWeight(layerID: number) → number`

Returns the current weight of the layer. See [Entity:SetLayerWeight](https://wiki.facepunch.com/gmod/Entity:SetLayerWeight) for more information.

**Arguments:**
- `layerID` (number) — The Layer ID

**Returns:**
- number — The current weight of the layer

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight)

---

### Entity:GetLightingOriginEntity · Server
`Entity:GetLightingOriginEntity() → Entity`

Returns the entity that is being used as the light origin position for this entity.

**Returns:**
- Entity — The lighting entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLightingOriginEntity)

---

### Entity:GetLocalAngles · Shared
`Entity:GetLocalAngles() → Angle`

Returns the rotation of the entity relative to its parent entity.

**Returns:**
- Angle — Relative angle

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLocalAngles)

---

### Entity:GetLocalAngularVelocity · Shared
`Entity:GetLocalAngularVelocity() → Angle`

Returns the non-VPhysics angular velocity of the entity relative to its parent entity.

**Returns:**
- Angle — The velocity

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLocalAngularVelocity)

---

### Entity:GetLocalPos · Shared
`Entity:GetLocalPos() → Vector`

Returns entity's position relative to it's [Entity:GetParent](https://wiki.facepunch.com/gmod/Entity:GetParent).

See [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos) for the absolute position.

**Returns:**
- Vector — Relative position

[wiki](https://wiki.facepunch.com/gmod/Entity:GetLocalPos)

---

### Entity:GetManipulateBoneAngles · Shared
`Entity:GetManipulateBoneAngles(boneID: number) → Angle`

Gets the entity's angle manipulation of the given bone. This is relative to the default angle, so the angle is zero when unmodified.

**Arguments:**
- `boneID` (number) — The bone's ID

**Returns:**
- Angle — The entity's angle manipulation of the given bone.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetManipulateBoneAngles)

---

### Entity:GetManipulateBoneJiggle · Shared
`Entity:GetManipulateBoneJiggle(boneID: number) → number`

Returns the jiggle amount of the entity's bone.

See [Entity:ManipulateBoneJiggle](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneJiggle) for more info.

**Arguments:**
- `boneID` (number) — The bone ID

**Returns:**
- number — The jiggle bone type, as set by Entity:ManipulateBoneJiggle.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetManipulateBoneJiggle)

---

### Entity:GetManipulateBonePosition · Shared
`Entity:GetManipulateBonePosition(boneId: number) → Vector`

Gets the entity's position manipulation of the given bone. This is relative to the default position, so it is zero when unmodified.

**Arguments:**
- `boneId` (number) — The bone's ID

**Returns:**
- Vector — The entity's position manipulation of the given bone.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetManipulateBonePosition)

---

### Entity:GetManipulateBoneScale · Shared
`Entity:GetManipulateBoneScale(boneID: number) → Vector`

Gets the entity's scale manipulation of the given bone. Normal scale is Vector( 1, 1, 1 )

**Arguments:**
- `boneID` (number) — The bone's ID

**Returns:**
- Vector — The entity's scale manipulation of the given bone

[wiki](https://wiki.facepunch.com/gmod/Entity:GetManipulateBoneScale)

---

### Entity:GetMaterial · Shared
`Entity:GetMaterial() → string`

Returns the material override for this entity. 

Returns an empty string if no material override exists. Use [Entity:GetMaterials](https://wiki.facepunch.com/gmod/Entity:GetMaterials) to list its default materials.

**Returns:**
- string — material

> **Bug** ([#3362](https://github.com/Facepunch/garrysmod/issues/3362)): The server's value takes priority on the client.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMaterial)

---

### Entity:GetMaterials · Shared
`Entity:GetMaterials() → table<string>`

Returns all materials of the entity's model.

This function is unaffected by [Entity:SetSubMaterial](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial) as it returns the original materials.

**Returns:**
- table<string> — A table containing full paths to the materials of the model.

> **Bug:** The table returned by this function will not contain materials if they are missing from the disk/repository. This means that if you are attempting to find the ID of a material to replace with [Entity:SetSubMaterial](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial) and there are missing materials on the model, all subsequent materials will be offset in the table, meaning that the ID you are trying to get will be incorrect.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMaterials)

---

### Entity:GetMaterialType · Server
`Entity:GetMaterialType() → number{MAT}`

Returns the [surface material type](https://developer.valvesoftware.com/wiki/Material_Types) of this entity.

This can be approximated clientside via [util.GetModelInfo](https://wiki.facepunch.com/gmod/util.GetModelInfo).

Internally, all this does is return `gamematerial` of the surface property on the first physics object of the entity. You can do this yourself using [PhysObj:GetMaterial](https://wiki.facepunch.com/gmod/PhysObj:GetMaterial) and [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData).

**Returns:**
- number{MAT} — Surface material type.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMaterialType)

---

### Entity:GetMaxHealth · Shared
`Entity:GetMaxHealth() → number`

Returns the max health that the entity was given. It can be set via [Entity:SetMaxHealth](https://wiki.facepunch.com/gmod/Entity:SetMaxHealth).

**Returns:**
- number — Max health.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMaxHealth)

---

### Entity:GetModel · Shared
`Entity:GetModel() → string|nil`

Gets the model of given entity.

**Returns:**
- string|nil — The entity's model.

> **Bug:** This does not necessarily return the model's path, as is the case for brush and virtual models. This is intentional behaviour, however, there is currently no way to retrieve the actual file path.
> 
> This also affects certain models that are edited by 3rd party programs after being compiled.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModel)

---

### Entity:GetModelBounds · Shared
`Entity:GetModelBounds() → Vector, Vector`

Returns the entity's model bounds, not scaled by [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale).

These bounds are affected by all the animations the model has at compile time, if they go outside of the models' render bounds at any point.  
See [Entity:GetModelRenderBounds](https://wiki.facepunch.com/gmod/Entity:GetModelRenderBounds) for just the render bounds of the model.

This is different than the collision bounds/hull, which are set via [Entity:SetCollisionBounds](https://wiki.facepunch.com/gmod/Entity:SetCollisionBounds).

**Returns:**
- Vector — The minimum vector of the bounds
- Vector — The maximum vector of the bounds

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelBounds)

---

### Entity:GetModelContents · Shared
`Entity:GetModelContents() → number`

Returns the contents of the entity's current model.

**Returns:**
- number — The contents of the entity's model.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelContents)

---

### Entity:GetModelPhysBoneCount · Client
`Entity:GetModelPhysBoneCount() → number`

Gets the physics bone count of the entity's model. This is only applicable to `anim` type [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities) with ragdoll models.

**Returns:**
- number — How many physics bones exist on the model.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelPhysBoneCount)

---

### Entity:GetModelRadius · Shared
`Entity:GetModelRadius() → number`

Gets the models radius.

**Returns:**
- number — The radius of the model.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelRadius)

---

### Entity:GetModelRenderBounds · Shared
`Entity:GetModelRenderBounds() → Vector, Vector`

Returns the entity's model render bounds. Unlike [Entity:GetModelBounds](https://wiki.facepunch.com/gmod/Entity:GetModelBounds), bounds returning by this function will not be affected by animations (at compile time).

**Returns:**
- Vector — The minimum vector of the bounds
- Vector — The maximum vector of the bounds

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelRenderBounds)

---

### Entity:GetModelScale · Shared
`Entity:GetModelScale() → number`

Gets the selected entity's model scale.

**Returns:**
- number — Scale of that entity's model.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetModelScale)

---

### Entity:GetMomentaryRotButtonPos · Server
`Entity:GetMomentaryRotButtonPos(turnAngle: Angle) → number`

Returns the amount a momentary_rot_button entity is turned based on the given angle. 0 meaning completely turned closed, 1 meaning completely turned open.

**Arguments:**
- `turnAngle` (Angle) — The angle of rotation to compare - usually should be Entity:GetAngles.

**Returns:**
- number — The amount the momentary_rot_button is turned, ranging from 0 to 1, or nil if the entity is not a momentary_rot_button.

> **Warning:** This only works on momentary_rot_button entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMomentaryRotButtonPos)

---

### Entity:GetMoveCollide · Shared
`Entity:GetMoveCollide() → number`

Returns the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?

**Returns:**
- number — The move collide type, see MOVECOLLIDE

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMoveCollide)

---

### Entity:GetMoveParent · Shared
`Entity:GetMoveParent() → Entity`

Returns the movement parent of this entity.

See [Entity:SetMoveParent](https://wiki.facepunch.com/gmod/Entity:SetMoveParent) for more info.

**Returns:**
- Entity — The movement parent of this entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMoveParent)

---

### Entity:GetMoveType · Shared
`Entity:GetMoveType() → number`

Returns the entity's movetype

**Returns:**
- number — Move type.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetMoveType)

---

### Entity:GetName · Server
`Entity:GetName() → string`

Returns the "targetname" of this entity, typically used in map making and scripting to uniquely identify and target (hence 'targetname') an entity or a group of entities.

**Returns:**
- string — The name of the Entity

> **Warning:** For players, this function is overwritten by [Player:GetName](https://wiki.facepunch.com/gmod/Player:GetName), which returns the player's nick name, not the target name.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetName)

---

### Entity:GetNetworkAngles · Client
`Entity:GetNetworkAngles() → Angle`

Gets networked angles for entity.

**Returns:**
- Angle — angle

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkAngles)

---

### Entity:GetNetworked2Angle · Shared · `DEPRECATED`
`Entity:GetNetworked2Angle(key: string, fallback: any = Angle( 0, 0, 0 )) → any`

Retrieves a networked angle value at specified index on the entity that is set by [Entity:SetNetworked2Angle](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Angle).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Angle( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Angle)

---

### Entity:GetNetworked2Bool · Shared · `DEPRECATED`
`Entity:GetNetworked2Bool(key: string, fallback: any = false) → any`

Retrieves a networked boolean value at specified index on the entity that is set by [Entity:SetNetworked2Bool](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Bool).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `false`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Bool)

---

### Entity:GetNetworked2Entity · Shared · `DEPRECATED`
`Entity:GetNetworked2Entity(key: string, fallback: any = NULL) → any`

Retrieves a networked entity value at specified index on the entity that is set by [Entity:SetNetworked2Entity](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Entity).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `NULL`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Entity)

---

### Entity:GetNetworked2Float · Shared · `DEPRECATED`
`Entity:GetNetworked2Float(key: string, fallback: any = 0) → any`

Retrieves a networked float value at specified index on the entity that is set by [Entity:SetNetworked2Float](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Float).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Float)

---

### Entity:GetNetworked2Int · Shared · `DEPRECATED`
`Entity:GetNetworked2Int(key: string, fallback: any = 0) → any`

Retrieves a networked integer (whole number) value that was previously set by [Entity:SetNetworked2Int](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Int).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value (If it isn't set).

**Returns:**
- any — The value associated with the key

> **Warning:** The integer has a 32 bit limit. Use [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt) and [Entity:GetNWInt](https://wiki.facepunch.com/gmod/Entity:GetNWInt) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Int)

---

### Entity:GetNetworked2String · Shared · `DEPRECATED`
`Entity:GetNetworked2String(key: string, fallback: any) → any`

Retrieves a networked string value at specified index on the entity that is set by [Entity:SetNetworked2String](https://wiki.facepunch.com/gmod/Entity:SetNetworked2String).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2String)

---

### Entity:GetNetworked2Var · Shared · `DEPRECATED`
`Entity:GetNetworked2Var(key: string, fallback: any = nil) → any`

Retrieves a networked value at specified index on the entity that is set by [Entity:SetNetworked2Var](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Var).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `nil`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Var)

---

### Entity:GetNetworked2VarProxy · Shared · `DEPRECATED`
`Entity:GetNetworked2VarProxy(key: any) → function`

Returns callback function for given NWVar of this entity. Alias of [Entity:GetNW2VarProxy](https://wiki.facepunch.com/gmod/Entity:GetNW2VarProxy)

**Arguments:**
- `key` (any) — The key of the NWVar to get callback of.

**Returns:**
- function — The callback of given NWVar, or nil if not found.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2VarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L613-L624)

---

### Entity:GetNetworked2VarTable · Shared · `DEPRECATED`
`Entity:GetNetworked2VarTable() → table`

Returns all the networked2 variables in an entity.

**Returns:**
- table — Key-Value table of all networked2 variables.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2VarTable)

---

### Entity:GetNetworked2Vector · Shared · `DEPRECATED`
`Entity:GetNetworked2Vector(key: string, fallback: any = Vector( 0, 0, 0 )) → any`

Retrieves a networked vector value at specified index on the entity that is set by [Entity:SetNetworked2Vector](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Vector).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Vector( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Vector)

---

### Entity:GetNetworkedAngle · Shared · `DEPRECATED`
`Entity:GetNetworkedAngle(key: string, fallback: Angle = Angle( 0, 0, 0 )) → Angle`

Retrieves a networked angle value at specified index on the entity that is set by [Entity:SetNetworkedAngle](https://wiki.facepunch.com/gmod/Entity:SetNetworkedAngle).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (Angle, default `Angle( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- Angle — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedAngle)

---

### Entity:GetNetworkedBool · Shared · `DEPRECATED`
`Entity:GetNetworkedBool(key: string, fallback: boolean = false) → boolean`

Retrieves a networked boolean value at specified index on the entity that is set by [Entity:SetNetworkedBool](https://wiki.facepunch.com/gmod/Entity:SetNetworkedBool).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (boolean, default `false`) — The value to return if we failed to retrieve the value.

**Returns:**
- boolean — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedBool)

---

### Entity:GetNetworkedEntity · Shared · `DEPRECATED`
`Entity:GetNetworkedEntity(key: string, fallback: Entity = NULL) → Entity`

Retrieves a networked float value at specified index on the entity that is set by [Entity:SetNetworkedEntity](https://wiki.facepunch.com/gmod/Entity:SetNetworkedEntity).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (Entity, default `NULL`) — The value to return if we failed to retrieve the value.

**Returns:**
- Entity — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedEntity)

---

### Entity:GetNetworkedFloat · Shared · `DEPRECATED`
`Entity:GetNetworkedFloat(key: string, fallback: number = 0) → number`

Retrieves a networked float value at specified index on the entity that is set by [Entity:SetNetworkedFloat](https://wiki.facepunch.com/gmod/Entity:SetNetworkedFloat).

Seems to be the same as [Entity:GetNetworkedInt](https://wiki.facepunch.com/gmod/Entity:GetNetworkedInt).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (number, default `0`) — The value to return if we failed to retrieve the value.

**Returns:**
- number — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedFloat)

---

### Entity:GetNetworkedInt · Shared · `DEPRECATED`
`Entity:GetNetworkedInt(key: string, fallback: number = 0) → number`

Retrieves a networked integer value at specified index on the entity that is set by [Entity:SetNetworkedInt](https://wiki.facepunch.com/gmod/Entity:SetNetworkedInt).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (number, default `0`) — The value to return if we failed to retrieve the value.

**Returns:**
- number — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedInt)

---

### Entity:GetNetworkedString · Shared · `DEPRECATED`
`Entity:GetNetworkedString(key: string, fallback: string) → string`

Retrieves a networked string value at specified index on the entity that is set by [Entity:SetNetworkedString](https://wiki.facepunch.com/gmod/Entity:SetNetworkedString).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (string) — The value to return if we failed to retrieve the value.

**Returns:**
- string — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedString)

---

### Entity:GetNetworkedVar · Shared · `DEPRECATED`
`Entity:GetNetworkedVar(key: string, fallback: any = nil) → any`

Retrieves a networked value at specified index on the entity that is set by [Entity:SetNetworkedVar](https://wiki.facepunch.com/gmod/Entity:SetNetworkedVar).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `nil`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVar)

---

### Entity:GetNetworkedVarProxy · Shared · `DEPRECATED`
`Entity:GetNetworkedVarProxy(name: string) → function`

Returns callback function for given NWVar of this entity, previously set by [Entity:SetNWVarProxy](https://wiki.facepunch.com/gmod/Entity:SetNWVarProxy).

**Arguments:**
- `name` (string) — The name of the NWVar to get callback of.

**Returns:**
- function — The callback of given NWVar, if any.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L495-L506)

---

### Entity:GetNetworkedVarTable · Shared · `DEPRECATED`
`Entity:GetNetworkedVarTable() → table<string,any>`

Returns all the networked variables in an entity.

**Returns:**
- table<string,any> — Key-Value table of all networked variables.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVarTable)

---

### Entity:GetNetworkedVector · Shared · `DEPRECATED`
`Entity:GetNetworkedVector(key: string, fallback: Vector = Vector( 0, 0, 0 )) → Vector`

Retrieves a networked vector value at specified index on the entity that is set by [Entity:SetNetworkedVector](https://wiki.facepunch.com/gmod/Entity:SetNetworkedVector).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (Vector, default `Vector( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- Vector — The retrieved value

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVector)

---

### Entity:GetNetworkOrigin · Shared
`Entity:GetNetworkOrigin() → Vector`

Gets networked origin for entity.

**Returns:**
- Vector — The last received origin of the entity.

> **Note:** On the Client, this seems to return the position relative to the parent (if it has one). On the server-side this will return what you expect even if it has a parent.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkOrigin)

---

### Entity:GetNetworkVars · Shared
`Entity:GetNetworkVars() → table`

Returns all network vars created by [Entity:NetworkVar](https://wiki.facepunch.com/gmod/Entity:NetworkVar) and [Entity:NetworkVarElement](https://wiki.facepunch.com/gmod/Entity:NetworkVarElement) and their current values.

		This is used internally by the duplicator. `Entity` type Network vars will not be returned!

		For NWVars see [Entity:GetNWVarTable](https://wiki.facepunch.com/gmod/Entity:GetNWVarTable).

**Returns:**
- `data` (table) — The Key-Value formatted table of network var names and their current values

> **Note:** This function will only work on entities which had [Entity:InstallDataTable](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) called on them, which is done automatically for players and all [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities)

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNetworkVars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L491-L515)

---

### Entity:GetNoDraw · Shared
`Entity:GetNoDraw() → boolean`

Returns if the entity's rendering and transmitting has been disabled.

**Returns:**
- boolean — Whether the entity's rendering and transmitting has been disabled.

> **Note:** This is equivalent to calling [Entity:IsEffectActive](https://wiki.facepunch.com/gmod/Entity:IsEffectActive)( EF_NODRAW )

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNoDraw)

---

### Entity:GetNPCClass · Server
`Entity:GetNPCClass() → number`

Gets the NPC classification. Internally gets the `m_iClass` variable which is polled by the engine. This will be equivalent to [NPC:Classify](https://wiki.facepunch.com/gmod/NPC:Classify).

**Returns:**
- number — See CLASS

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:GetNPCClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/init.lua#L14)

---

### Entity:GetNumBodyGroups · Shared
`Entity:GetNumBodyGroups() → number`

Returns the number of Body Groups that the [Entity's](https://wiki.facepunch.com/gmod/Entity) model contains.

**Returns:**
- number — The amount of Body Groups on the Entity's model.

> **Note:** Weapons will return results from their viewmodels.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNumBodyGroups)

---

### Entity:GetNumPoseParameters · Shared
`Entity:GetNumPoseParameters() → number`

Returns the number of pose parameters this entity has.

**Returns:**
- number — Amount of pose parameters the entity has

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNumPoseParameters)

---

### Entity:GetNW2Angle · Shared
`Entity:GetNW2Angle(key: string, fallback: any = Angle( 0, 0, 0 )) → any`

Retrieves a networked angle value at specified index on the entity that is set by [Entity:SetNW2Angle](https://wiki.facepunch.com/gmod/Entity:SetNW2Angle).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Angle( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Angle)

---

### Entity:GetNW2Bool · Shared
`Entity:GetNW2Bool(key: string, fallback: any = false) → any`

Retrieves a networked boolean value at specified index on the entity that is set by [Entity:SetNW2Bool](https://wiki.facepunch.com/gmod/Entity:SetNW2Bool).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `false`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Bool)

---

### Entity:GetNW2Entity · Shared
`Entity:GetNW2Entity(key: string, fallback: any = NULL) → any`

Retrieves a networked entity value at specified index on the entity that is set by [Entity:SetNW2Entity](https://wiki.facepunch.com/gmod/Entity:SetNW2Entity).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `NULL`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Entity)

---

### Entity:GetNW2Float · Shared
`Entity:GetNW2Float(key: string, fallback: any = 0) → any`

Retrieves a networked float value at specified index on the entity that is set by [Entity:SetNW2Float](https://wiki.facepunch.com/gmod/Entity:SetNW2Float).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Float)

---

### Entity:GetNW2Int · Shared
`Entity:GetNW2Int(key: string, fallback: any = 0) → any`

Retrieves a networked integer (whole number) value that was previously set by [Entity:SetNW2Int](https://wiki.facepunch.com/gmod/Entity:SetNW2Int).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value (If it isn't set).

**Returns:**
- any — The value associated with the key

> **Warning:** The integer has a 32 bit limit. Use [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt) and [Entity:GetNWInt](https://wiki.facepunch.com/gmod/Entity:GetNWInt) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Int)

---

### Entity:GetNW2String · Shared
`Entity:GetNW2String(key: string, fallback: any) → any`

Retrieves a networked string value at specified index on the entity that is set by [Entity:SetNW2String](https://wiki.facepunch.com/gmod/Entity:SetNW2String).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2String)

---

### Entity:GetNW2Var · Shared
`Entity:GetNW2Var(key: string, fallback: any = nil) → any`

Retrieves a networked value at specified index on the entity that is set by [Entity:SetNW2Var](https://wiki.facepunch.com/gmod/Entity:SetNW2Var).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `nil`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Var)

---

### Entity:GetNW2VarProxy · Shared
`Entity:GetNW2VarProxy(key: any) → function`

Returns callback function for given NWVar of this entity.

**Arguments:**
- `key` (any) — The key of the NWVar to get callback of.

**Returns:**
- function — The callback of given NWVar, or nil if not found.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2VarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L627)

---

### Entity:GetNW2VarTable · Shared
`Entity:GetNW2VarTable() → table`

Returns all the NW2 variables in an entity.

**Returns:**
- table — Key-Value table of all NW2 variables.

> **Bug** ([#5396](https://github.com/Facepunch/garrysmod/issues/5396)): This function will return keys with empty tables if the NW2Var is nil.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2VarTable)

---

### Entity:GetNW2Vector · Shared
`Entity:GetNW2Vector(key: string, fallback: any = Vector( 0, 0, 0 )) → any`

Retrieves a networked vector value at specified index on the entity that is set by [Entity:SetNW2Vector](https://wiki.facepunch.com/gmod/Entity:SetNW2Vector).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Vector( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNW2Vector)

---

### Entity:GetNWAngle · Shared
`Entity:GetNWAngle(key: string, fallback: any = Angle( 0, 0, 0 )) → any`

Retrieves a networked angle value at specified index on the entity that is set by [Entity:SetNWAngle](https://wiki.facepunch.com/gmod/Entity:SetNWAngle).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `Angle( 0, 0, 0 )`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWAngle)

---

### Entity:GetNWBool · Shared
`Entity:GetNWBool(key: string, fallback: any = false) → any`

Retrieves a networked boolean value at specified index on the entity that is set by [Entity:SetNWBool](https://wiki.facepunch.com/gmod/Entity:SetNWBool).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `false`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWBool)

---

### Entity:GetNWEntity · Shared
`Entity:GetNWEntity(key: string, fallback: any = NULL) → any`

Retrieves a networked entity value at specified index on the entity that is set by [Entity:SetNWEntity](https://wiki.facepunch.com/gmod/Entity:SetNWEntity).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `NULL`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWEntity)

---

### Entity:GetNWFloat · Shared
`Entity:GetNWFloat(key: string, fallback: any = 0) → any`

Retrieves a networked float value at specified index on the entity that is set by [Entity:SetNWFloat](https://wiki.facepunch.com/gmod/Entity:SetNWFloat).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWFloat)

---

### Entity:GetNWInt · Shared
`Entity:GetNWInt(key: string, fallback: any = 0) → any`

Retrieves a networked integer (whole number) value that was previously set by [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any, default `0`) — The value to return if we failed to retrieve the value (If it isn't set).

**Returns:**
- any — The value associated with the key

> **Bug** ([#3374](https://github.com/Facepunch/garrysmod/issues/3374)): This function will not round decimal values as it actually networks a float internally.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWInt)

---

### Entity:GetNWString · Shared
`Entity:GetNWString(key: string, fallback: any) → any`

Retrieves a networked string value at specified index on the entity that is set by [Entity:SetNWString](https://wiki.facepunch.com/gmod/Entity:SetNWString).

**Arguments:**
- `key` (string) — The key that is associated with the value
- `fallback` (any) — The value to return if we failed to retrieve the value.

**Returns:**
- any — The value associated with the key

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWString)

---

### Entity:GetNWVarProxy · Shared · `DEPRECATED`
`Entity:GetNWVarProxy(key: string) → function`

Returns callback function for given NWVar of this entity, previously set by [Entity:SetNWVarProxy](https://wiki.facepunch.com/gmod/Entity:SetNWVarProxy).

**Arguments:**
- `key` (string) — The key of the NWVar to get callback of.

**Returns:**
- function — The callback of given NWVar, or nil if not found.

[wiki](https://wiki.facepunch.com/gmod/Entity:GetNWVarProxy)
