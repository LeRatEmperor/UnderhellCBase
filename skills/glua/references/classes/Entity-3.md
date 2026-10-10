# Entity

**Realm:** Shared  ·  **Members:** 557

This is a list of all available methods for all entities, which includes [Players](https://wiki.facepunch.com/gmod/Player), [Weapons](https://wiki.facepunch.com/gmod/Weapon), [NPCs](https://wiki.facepunch.com/gmod/NPC) and [Vehicles](https://wiki.facepunch.com/gmod/Vehicle).

For a list of possible members of [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities) see [ENT Structure](https://wiki.facepunch.com/gmod/Structures/ENT).

[wiki page](https://wiki.facepunch.com/gmod/Entity)

> **Part 3 of 3** (`SetGravity` – `WorldToLocalAngles`). All parts: [1](Entity.md), [2](Entity-2.md), [3](Entity-3.md)


### Entity:SetGravity · Shared
`Entity:SetGravity(multiplier: number)`

Sets the gravity multiplier of the entity.

This may not affect affect all entities, but does affect players, and entities with [MOVETYPE_FLYGRAVITY](https://wiki.facepunch.com/gmod/Enums/MOVETYPE#MOVETYPE_FLYGRAVITY), such as projectiles.

**Arguments:**
- `multiplier` (number) — By how much to multiply the gravity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetGravity)

---

### Entity:SetGroundEntity · Shared
`Entity:SetGroundEntity(ground: Entity)`

Sets the ground the entity is standing on.

**Arguments:**
- `ground` (Entity) — The ground entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetGroundEntity)

---

### Entity:SetHealth · Shared
`Entity:SetHealth(newHealth: number)`

Sets the health of the entity.

**Arguments:**
- `newHealth` (number) — New health value.

> **Note:** You may want to take [Entity:GetMaxHealth](https://wiki.facepunch.com/gmod/Entity:GetMaxHealth) into account when calculating what to set health to, in case a gamemode has a different max health than 100.  
> In some cases, setting health only serverside can cause hitches in movement, for example if something is modifying the player speed based on health.  
> To solve this issue, it is better to set it shared in a predicted hook.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetHealth)

---

### Entity:SetHitboxSet · Shared
`Entity:SetHitboxSet(id: number)`

Sets the current Hitbox set for the entity.

**Arguments:**
- `id` (number) — The new hitbox set to set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetHitboxSet)

---

### Entity:SetIK · Shared
`Entity:SetIK(useIK: boolean = false)`

Enables or disable the inverse kinematic usage of this entity.

**Arguments:**
- `useIK` (boolean, default `false`) — The state of the IK.

> **Warning:** Calling this with false outside of [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize) requires a model change to take effect.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetIK)

---

### Entity:SetKeyValue · Shared
`Entity:SetKeyValue(key: string, value: string)`

Sets Hammer key values on an entity.

You can look up which entities have what key values on the [Valve Developer Community](https://developer.valvesoftware.com/wiki/) on entity pages. A  list of basic entities can be found [here](https://developer.valvesoftware.com/wiki/List_of_entities).

Alternatively you can look at the `.fgd` files shipped with Garry's Mod in the `bin/` folder with a text editor to see the key values as they appear in Hammer.

**Arguments:**
- `key` (string) — The internal key name
- `value` (string) — The value to set

[wiki](https://wiki.facepunch.com/gmod/Entity:SetKeyValue)

---

### Entity:SetLagCompensated · Server
`Entity:SetLagCompensated(enable: boolean)`

This allows the entity to be lag compensated during [Player:LagCompensation](https://wiki.facepunch.com/gmod/Player:LagCompensation).



As a side note for parented entities, if your entity can be shot at, keep in mind that its collision bounds need to be bigger than the bone's hitbox the entity is parented to, or hull/line traces ( such as the crowbar attack or bullets ) might not hit at all.

**Arguments:**
- `enable` (boolean) — Whether the entity should be lag compensated or not.

> **Note:** Players are lag compensated by default and there's no need to call this function for them.
> 
> It's best to not enable lag compensation on parented entities, as the system does not handle it that well ( they will be moved back but then the entity will lag behind ).
> Parented entities move back with the parent if it's lag compensated, so if you are making some kind of armor piece you shouldn't do anything.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLagCompensated)

---

### Entity:SetLayerAutokill · Server
`Entity:SetLayerAutokill(layerID: number, autoKill: boolean)`

Sets the autokill flag on the layer, making the layer be automatically removed once the animation playback finishes.

**Arguments:**
- `layerID` (number) — The layer ID to change.
- `autoKill` (boolean) — Whether to set or unset the autokill flag.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerAutokill)

---

### Entity:SetLayerBlendIn · Shared
`Entity:SetLayerBlendIn(layerID: number, blendIn: number)`

Sets the interval the layer will fully blend in since startup, based on [Entity:GetLayerCycle](https://wiki.facepunch.com/gmod/Entity:GetLayerCycle). Setting this above 0 will enable internal blending of [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight).

**Arguments:**
- `layerID` (number) — The Layer ID
- `blendIn` (number) — Blend range from 0 to 1.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!
> **Bug:** Enabling this will prevent looping gestures with autokill disabled to be removed with [Entity:RemoveGesture](https://wiki.facepunch.com/gmod/Entity:RemoveGesture) or [Entity:RemoveAllGestures](https://wiki.facepunch.com/gmod/Entity:RemoveAllGestures) because layer removal functions mark the layer to decrement [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight) and unallocate layer ID in next frames if the layer weight is `0`, but blending functions will still keep manipulating layer weight. 
> 
> Therefore; before calling layer cleanup functions, make sure both [Entity:SetLayerBlendIn](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendIn) and [Entity:SetLayerBlendOut](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendOut) are set to `0`.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendIn)

---

### Entity:SetLayerBlendOut · Shared
`Entity:SetLayerBlendOut(layerID: number, blendOut: number)`

Sets the interval the layer will fully blend out, based on [Entity:GetLayerCycle](https://wiki.facepunch.com/gmod/Entity:GetLayerCycle). Setting this above 0 will enable internal blending of [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight).

**Arguments:**
- `layerID` (number) — The Layer ID
- `blendOut` (number) — Blend range from 0 to 1.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!
> **Bug:** Enabling this will prevent looping gestures with autokill disabled to be removed with [Entity:RemoveGesture](https://wiki.facepunch.com/gmod/Entity:RemoveGesture) or [Entity:RemoveAllGestures](https://wiki.facepunch.com/gmod/Entity:RemoveAllGestures) because layer removal functions mark the layer to decrement [Entity:GetLayerWeight](https://wiki.facepunch.com/gmod/Entity:GetLayerWeight) and unallocate layer ID in next frames if the layer weight is `0`, but blending functions will still keep manipulating layer weight. 
> 
> Therefore; before calling layer cleanup functions, make sure both [Entity:SetLayerBlendIn](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendIn) and [Entity:SetLayerBlendOut](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendOut) are set to `0`.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendOut)

---

### Entity:SetLayerCycle · Shared
`Entity:SetLayerCycle(layerID: number, cycle: number)`

Sets the animation cycle/frame of given layer.

**Arguments:**
- `layerID` (number) — The Layer ID
- `cycle` (number) — The new animation cycle/frame for given layer.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerCycle)

---

### Entity:SetLayerDuration · Shared
`Entity:SetLayerDuration(layerID: number, duration: number)`

Sets the duration of given layer. This internally overrides the [Entity:SetLayerPlaybackRate](https://wiki.facepunch.com/gmod/Entity:SetLayerPlaybackRate).

**Arguments:**
- `layerID` (number) — The Layer ID
- `duration` (number) — The new duration of the layer in seconds.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.
> **Bug:** This stops layer playback if layer sequence conists of 1 frame. Use `Entity:SetLayerPlaybackRate(layerID,1/duration)` instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerDuration)

---

### Entity:SetLayerLooping · Server
`Entity:SetLayerLooping(layerID: number, loop: boolean)`

Sets whether the layer should loop or not.

**Arguments:**
- `layerID` (number) — The Layer ID
- `loop` (boolean) — Whether the layer should loop or not.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerLooping)

---

### Entity:SetLayerPlaybackRate · Shared
`Entity:SetLayerPlaybackRate(layerID: number, rate: number)`

Sets the layer playback rate. See also [Entity:SetLayerDuration](https://wiki.facepunch.com/gmod/Entity:SetLayerDuration).

**Arguments:**
- `layerID` (number) — The Layer ID
- `rate` (number) — The new playback rate.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerPlaybackRate)

---

### Entity:SetLayerPriority · Server
`Entity:SetLayerPriority(layerID: number, priority: number)`

Sets the priority of given layer.

**Arguments:**
- `layerID` (number) — The Layer ID
- `priority` (number) — The new priority of the layer.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entites!

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerPriority)

---

### Entity:SetLayerSequence · Shared
`Entity:SetLayerSequence(layerID: number, seq: number)`

Sets the sequence of given layer.

**Arguments:**
- `layerID` (number) — The Layer ID.
- `seq` (number) — The sequenceID to set.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerSequence)

---

### Entity:SetLayerWeight · Shared
`Entity:SetLayerWeight(layerID: number, weight: number)`

Sets the layer weight. This influences how strongly the animation should be overriding the normal animations of the entity.

**Arguments:**
- `layerID` (number) — The Layer ID
- `weight` (number) — The new layer weight.

> **Note:** This function only works on [BaseAnimatingOverlay](https://wiki.facepunch.com/gmod/BaseAnimatingOverlay) entities.
> **Note:** Setting either [Entity:SetLayerBlendIn](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendIn) or [Entity:SetLayerBlendOut](https://wiki.facepunch.com/gmod/Entity:SetLayerBlendOut) above 0 will turn on automatic weight blending, so you shouldn't be using this if you use any of above.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLayerWeight)

---

### Entity:SetLegacyTransform · Client
`Entity:SetLegacyTransform(enabled: boolean)`

This forces an entity to use the bone transformation behaviour from versions prior to **8 July 2014**.

This behaviour affects [Entity:EnableMatrix](https://wiki.facepunch.com/gmod/Entity:EnableMatrix) and [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale) and is incorrect, therefore this function be used exclusively as a quick fix for old scripts that rely on it.

**Arguments:**
- `enabled` (boolean) — Whether the entity should use the old bone transformation behaviour or not.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLegacyTransform)

---

### Entity:SetLightingOriginEntity · Server
`Entity:SetLightingOriginEntity(lightOrigin: Entity)`

Sets the entity to be used as the light origin position for this entity.

**Arguments:**
- `lightOrigin` (Entity) — The lighting entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLightingOriginEntity)

---

### Entity:SetLocalAngles · Shared
`Entity:SetLocalAngles(ang: Angle)`

Sets angles relative to angles of [Entity:GetParent](https://wiki.facepunch.com/gmod/Entity:GetParent)

**Arguments:**
- `ang` (Angle) — The local angle

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLocalAngles)

---

### Entity:SetLocalAngularVelocity · Shared
`Entity:SetLocalAngularVelocity(angVel: Angle)`

Sets the entity's angular velocity (rotation speed).

**Arguments:**
- `angVel` (Angle) — The angular velocity to set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLocalAngularVelocity)

---

### Entity:SetLocalPos · Shared
`Entity:SetLocalPos(pos: Vector)`

Sets local position relative to the parented position. This is for use with [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent) to offset position.
	
This is also used by NPCs for interpolated movement. If you use [Entity:SetPos](https://wiki.facepunch.com/gmod/Entity:SetPos) for step movement, your NPC will snap to position instead.

**Arguments:**
- `pos` (Vector) — The local position

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLocalPos)

---

### Entity:SetLocalVelocity · Shared
`Entity:SetLocalVelocity(velocity: Vector)`

Sets the entity's local velocity which is their velocity due to movement in the world from forces such as gravity. Does not include velocity from entity-on-entity collision or other world movement.

**Arguments:**
- `velocity` (Vector) — The new velocity to set.

> **Warning:** Same as [Entity:SetAbsVelocity](https://wiki.facepunch.com/gmod/Entity:SetAbsVelocity), but clamps the given velocity, and is not recommended to be used because of that.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLocalVelocity)

---

### Entity:SetLOD · Client
`Entity:SetLOD(lod: number = -1)`

Sets the Level Of Detail model to use with this entity. This may not work for all models if the model doesn't include any LOD sub models.

This function works exactly like the clientside r_lod convar and takes priority over it.

**Arguments:**
- `lod` (number, default `-1`) — The Level Of Detail model ID to use.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetLOD)

---

### Entity:SetMaterial · Shared
`Entity:SetMaterial(materialName: string)`

Sets the rendering material override of the entity.

To set a Lua material created with [CreateMaterial](https://wiki.facepunch.com/gmod/Global.CreateMaterial), just prepend a "!" to the material name.

If you wish to override a single material on the model, use [Entity:SetSubMaterial](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial) instead.

**Arguments:**
- `materialName` (string) — New material name.

> **Note:** To apply materials to models, that material **must** have **VertexLitGeneric** shader. For that reason you cannot apply map textures onto models, map textures use a different material shader - **LightmappedGeneric**, which can be used on brush entities.
> **Bug** ([#3362](https://github.com/Facepunch/garrysmod/issues/3362)): The server's value takes priority on the client.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetMaterial)

---

### Entity:SetMaxHealth · Server
`Entity:SetMaxHealth(maxhealth: number)`

Sets the maximum health for entity. Note, that you can still set entity's health above this amount with [Entity:SetHealth](https://wiki.facepunch.com/gmod/Entity:SetHealth).

**Arguments:**
- `maxhealth` (number) — What the max health should be

[wiki](https://wiki.facepunch.com/gmod/Entity:SetMaxHealth)

---

### Entity:SetMaxYawSpeed · Server
`Entity:SetMaxYawSpeed(maxyaw: number)`

Sets the NPC max yaw speed. Internally sets the `m_fMaxYawSpeed` variable which is polled by the engine.

**Arguments:**
- `maxyaw` (number) — The new max yaw value to set

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SetMaxYawSpeed)

---

### Entity:SetModel · Shared
`Entity:SetModel(modelName: string)`

Sets the model of the entity.

This does not update the physics of the entity - see [Entity:PhysicsInit](https://wiki.facepunch.com/gmod/Entity:PhysicsInit).

**Arguments:**
- `modelName` (string) — New model value.

> **Warning:** This silently fails when given an empty string.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetModel)

---

### Entity:SetModelName · Shared
`Entity:SetModelName(modelname: string)`

Alter the model name returned by [Entity:GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel). Does not affect the entity's actual model.

**Arguments:**
- `modelname` (string) — The new model name.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetModelName)

---

### Entity:SetModelScale · Shared
`Entity:SetModelScale(scale: number, deltaTime: number = 0)`

Uniformly scales the model of the entity, if the entity is a [Player](https://wiki.facepunch.com/gmod/Player) or an [NPC](https://wiki.facepunch.com/gmod/NPC) the hitboxes will be scaled as well.

To resize the entity non-uniformly, along any axis, use [Entity:EnableMatrix](https://wiki.facepunch.com/gmod/Entity:EnableMatrix) instead.

For some entities (Such as `prop_physics` and `anim` type [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities)), calling [Entity:Activate](https://wiki.facepunch.com/gmod/Entity:Activate) after this will scale the collision bounds and [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) as well; be wary as there's no optimization being done internally and highly complex collision models might crash the server.

Client-side trace detection seems to mess up if `deltaTime` is set to anything but zero. A very small decimal can be used instead of zero to solve this issue.

If your old scales are wrong, use [Entity:SetLegacyTransform](https://wiki.facepunch.com/gmod/Entity:SetLegacyTransform) as a quick fix.

**Arguments:**
- `scale` (number) — A float to scale the model by.
- `deltaTime` (number, default `0`) — Transition time of the scale change, set to 0 to modify the scale right away.

> **Note:** If you do not want the physics to be affected by [Entity:Activate](https://wiki.facepunch.com/gmod/Entity:Activate), you can use [Entity:ManipulateBoneScale](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneScale)`( 0, Vector( scale, scale, scale ) )` instead.
> **Bug** ([#6405](https://github.com/Facepunch/garrysmod/issues/6405)): On the client, `anim` types' collision testing prediction fails for changed model scales: you can use `cl_showerror 2` to see by how much. Essentially, the client will freak out when you stand/run past on a Scripted Entity or prop that has been modified using this method.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetModelScale)

---

### Entity:SetMoveCollide · Shared
`Entity:SetMoveCollide(moveCollideType: number)`

Sets the move collide type of the entity. The move collide is the way a physics object reacts to hitting an object - will it bounce, slide?

**Arguments:**
- `moveCollideType` (number, enum [MOVECOLLIDE](https://wiki.facepunch.com/gmod/Enums/MOVECOLLIDE)) — The move collide type, see MOVECOLLIDE

[wiki](https://wiki.facepunch.com/gmod/Entity:SetMoveCollide)

---

### Entity:SetMoveParent · Shared
`Entity:SetMoveParent(Parent: Entity)`

Sets the Movement Parent of an entity to another entity.

Similar to [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent), except the object's coordinates are not translated automatically before parenting.

Does nothing on client.

**Arguments:**
- `Parent` (Entity) — The entity to change this entity's Movement Parent to.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetMoveParent)

---

### Entity:SetMoveType · Shared
`Entity:SetMoveType(movetype: number)`

Sets the entity's move type. This should be called before initializing the physics object on the entity, unless it will override SetMoveType such as [Entity:PhysicsInitBox](https://wiki.facepunch.com/gmod/Entity:PhysicsInitBox).

Despite existing on client, it doesn't actually do anything on client.

**Arguments:**
- `movetype` (number, enum [MOVETYPE](https://wiki.facepunch.com/gmod/Enums/MOVETYPE)) — The new movetype, see MOVETYPE

[wiki](https://wiki.facepunch.com/gmod/Entity:SetMoveType)

---

### Entity:SetName · Server
`Entity:SetName(mappingName: string)`

Sets the mapping name of the entity.

**Arguments:**
- `mappingName` (string) — The name to set for the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetName)

---

### Entity:SetNetworkAngles · Client
`Entity:SetNetworkAngles(angle: Angle)`

Alters the entity's perceived serverside angle on the client.

**Arguments:**
- `angle` (Angle) — Networked angle.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkAngles)

---

### Entity:SetNetworked2Angle · Shared · `DEPRECATED`
`Entity:SetNetworked2Angle(key: string, value: Angle)`

Sets a networked angle value on the entity.

The value can then be accessed with [Entity:GetNetworked2Angle](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Angle) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Angle) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWAngle](https://wiki.facepunch.com/gmod/Entity:SetNWAngle) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Angle)

---

### Entity:SetNetworked2Bool · Shared · `DEPRECATED`
`Entity:SetNetworked2Bool(key: string, value: boolean)`

Sets a networked boolean value on the entity.

The value can then be accessed with [Entity:GetNetworked2Bool](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Bool) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (boolean) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWBool](https://wiki.facepunch.com/gmod/Entity:SetNWBool) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Bool)

---

### Entity:SetNetworked2Entity · Shared · `DEPRECATED`
`Entity:SetNetworked2Entity(key: string, value: Entity)`

Sets a networked entity value on the entity.

The value can then be accessed with [Entity:GetNetworked2Entity](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Entity) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Entity) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWEntity](https://wiki.facepunch.com/gmod/Entity:SetNWEntity) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Entity)

---

### Entity:SetNetworked2Float · Shared
`Entity:SetNetworked2Float(key: string, value: number)`

Sets a networked float (number) value on the entity.

The value can then be accessed with [Entity:GetNetworked2Float](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Float) both from client and server.

Unlike [Entity:SetNetworked2Int](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Int), floats don't have to be whole numbers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWFloat](https://wiki.facepunch.com/gmod/Entity:SetNWFloat) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Float)

---

### Entity:SetNetworked2Int · Shared · `DEPRECATED`
`Entity:SetNetworked2Int(key: string, value: number)`

Sets a networked integer (whole number) value on the entity.

The value can then be accessed with [Entity:GetNetworked2Int](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Int) both from client and server.

See [Entity:SetNW2Float](https://wiki.facepunch.com/gmod/Entity:SetNW2Float) for numbers that aren't integers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS.  
> The integer has a 32 bit limit. Use [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Int)

---

### Entity:SetNetworked2String · Shared · `DEPRECATED`
`Entity:SetNetworked2String(key: string, value: string)`

Sets a networked string value on the entity.

The value can then be accessed with [Entity:GetNetworked2String](https://wiki.facepunch.com/gmod/Entity:GetNetworked2String) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (string) — The value to set, up to 511 characters.

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWString](https://wiki.facepunch.com/gmod/Entity:SetNWString) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2String)

---

### Entity:SetNetworked2Var · Shared · `DEPRECATED`
`Entity:SetNetworked2Var(key: string, value: any)`

Sets a networked value on the entity.

The value can then be accessed with [Entity:GetNetworked2Var](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Var) both from client and server.

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
- `key` (string) — The key to associate the value with
- `value` (any) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only ne networked once and not every 10 seconds.
> **Warning:** Trying to network a type that is not listed above leads to the value not being networked!

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Var)

---

### Entity:SetNetworked2VarProxy · Shared
`Entity:SetNetworked2VarProxy(name: string, callback: function)`

Sets a function to be called when the NW2Var changes. Internally uses [GM:EntityNetworkedVarChanged](https://wiki.facepunch.com/gmod/GM:EntityNetworkedVarChanged) to call the function.

**Arguments:**
- `name` (string) — The name of the NW2Var to add callback for.
- `callback` (function) — The function to be called when the NW2Var changes.

> **Note:** Only one NW2VarProxy can be set per-var  
> Running this function clientside will only set it for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2VarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L600-L611)

---

### Entity:SetNetworked2Vector · Shared · `DEPRECATED`
`Entity:SetNetworked2Vector(key: string, value: Vector)`

Sets a networked vector value on the entity.

The value can then be accessed with [Entity:GetNetworked2Vector](https://wiki.facepunch.com/gmod/Entity:GetNetworked2Vector) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Vector) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWVector](https://wiki.facepunch.com/gmod/Entity:SetNWVector) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworked2Vector)

---

### Entity:SetNetworkedAngle · Shared · `DEPRECATED`
`Entity:SetNetworkedAngle(key: string, value: Angle = Angle( 0, 0, 0 ))`

Sets a networked angle value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedAngle](https://wiki.facepunch.com/gmod/Entity:GetNetworkedAngle) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Angle, default `Angle( 0, 0, 0 )`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedAngle)

---

### Entity:SetNetworkedBool · Shared · `DEPRECATED`
`Entity:SetNetworkedBool(key: string, value: boolean = false)`

Sets a networked boolean value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedBool](https://wiki.facepunch.com/gmod/Entity:GetNetworkedBool) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (boolean, default `false`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedBool)

---

### Entity:SetNetworkedEntity · Shared · `DEPRECATED`
`Entity:SetNetworkedEntity(key: string, value: Entity = NULL)`

Sets a networked entity value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedEntity](https://wiki.facepunch.com/gmod/Entity:GetNetworkedEntity) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Entity, default `NULL`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedEntity)

---

### Entity:SetNetworkedFloat · Shared · `DEPRECATED`
`Entity:SetNetworkedFloat(key: string, value: number = 0)`

Sets a networked float value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedFloat](https://wiki.facepunch.com/gmod/Entity:GetNetworkedFloat) both from client and server.

Seems to be the same as [Entity:GetNetworkedInt](https://wiki.facepunch.com/gmod/Entity:GetNetworkedInt).

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number, default `0`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedFloat)

---

### Entity:SetNetworkedInt · Shared · `DEPRECATED`
`Entity:SetNetworkedInt(key: string, value: number = 0)`

Sets a networked integer value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedInt](https://wiki.facepunch.com/gmod/Entity:GetNetworkedInt) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number, default `0`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedInt)

---

### Entity:SetNetworkedNumber · Shared · `DEPRECATED`
`Entity:SetNetworkedNumber(index: any, number: number)`

Sets a networked number at the specified index on the entity.

**Arguments:**
- `index` (any) — The index that the value is stored in.
- `number` (number) — The value to network.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedNumber)

---

### Entity:SetNetworkedString · Shared · `DEPRECATED`
`Entity:SetNetworkedString(key: string, value: string)`

Sets a networked string value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedString](https://wiki.facepunch.com/gmod/Entity:GetNetworkedString) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (string) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedString)

---

### Entity:SetNetworkedVar · Shared · `DEPRECATED`
`Entity:SetNetworkedVar(key: string, value: any)`

Sets a networked value on the entity.

The value can then be accessed with [Entity:GetNetworkedVar](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVar) both from client and server.

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
- `key` (string) — The key to associate the value with
- `value` (any) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** Trying to network a type that is not listed above leads to the value not being networked!  
> the value will only be updated clientside if the entity is or enters the clients PVS.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedVar)

---

### Entity:SetNetworkedVarProxy · Shared · `DEPRECATED`
`Entity:SetNetworkedVarProxy(name: string, callback: function)`

Sets callback function to be called when given NWVar changes.

**Arguments:**
- `name` (string) — The name of the NWVar to add callback for.
- `callback` (function) — The function to be called when the NWVar changes.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedVarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L485-L493)

---

### Entity:SetNetworkedVector · Shared · `DEPRECATED`
`Entity:SetNetworkedVector(key: string, value: Vector = Vector( 0, 0, 0 ))`

Sets a networked vector value at specified index on the entity.

The value then can be accessed with [Entity:GetNetworkedVector](https://wiki.facepunch.com/gmod/Entity:GetNetworkedVector) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Vector, default `Vector( 0, 0, 0 )`) — The value to set

> **Note:** Running this function clientside will only set it clientside for the client it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkedVector)

---

### Entity:SetNetworkKeyValue · Server
`Entity:SetNetworkKeyValue(key: string, value: string) → boolean`

A helper function to allow setting [Network Variables](https://wiki.facepunch.com/gmod/Networking_Entities) via [Entity:SetKeyValue](https://wiki.facepunch.com/gmod/Entity:SetKeyValue), primarily to allow mappers to set them from Hammer.

Meant to be called from [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue), see example.

See also [Entity:SetNetworkVarsFromMapInput](https://wiki.facepunch.com/gmod/Entity:SetNetworkVarsFromMapInput) for a function that does similar thing for map inputs instead.

**Arguments:**
- `key` (string) — The key-value name, or simply the "key".
- `value` (string) — The key-value value.

**Returns:**
- boolean — Whether a network variable was set successfully

> **Note:** This function will only work on entities which had [Entity:InstallDataTable](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) called on them, which is done automatically for players and all [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities).

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkKeyValue)

---

### Entity:SetNetworkOrigin · Shared
`Entity:SetNetworkOrigin(origin: Vector)`

Virtually changes entity position for clients. Does almost the same thing as [Entity:SetPos](https://wiki.facepunch.com/gmod/Entity:SetPos) when used serverside.

**Arguments:**
- `origin` (Vector) — The position to make clients think this entity is at.

> **Note:** Unlike [Entity:SetPos](https://wiki.facepunch.com/gmod/Entity:SetPos) it directly changes the position without checking for any unreasonable position.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkOrigin)

---

### Entity:SetNetworkVarsFromMapInput · Server
`Entity:SetNetworkVarsFromMapInput(name: string, param: string) → boolean`

A helper function to allow setting [Network Variables](https://wiki.facepunch.com/gmod/Networking_Entities) via [Entity:Fire](https://wiki.facepunch.com/gmod/Entity:Fire), primarily to allow mappers to set them from Hammer via Map I/O logic.

Meant to be called from [ENTITY:AcceptInput](https://wiki.facepunch.com/gmod/ENTITY:AcceptInput), see example.

See also [Entity:SetNetworkKeyValue](https://wiki.facepunch.com/gmod/Entity:SetNetworkKeyValue) for a function that does similar thing, but for entity key-values in Hammer instead.

**Arguments:**
- `name` (string) — The name of the Map I/O input, including the `Set` prefix.
- `param` (string) — The input parameter.

**Returns:**
- boolean — Whether a network variable was set successfully

> **Note:** This function will only work on entities which had [Entity:InstallDataTable](https://wiki.facepunch.com/gmod/Entity:InstallDataTable) called on them, which is done automatically for players and all [Scripted Entities](https://wiki.facepunch.com/gmod/Scripted%20Entities).

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNetworkVarsFromMapInput)

---

### Entity:SetNextClientThink · Client
`Entity:SetNextClientThink(nextthink: number)`

Sets the next time the clientside [ENTITY:Think](https://wiki.facepunch.com/gmod/ENTITY:Think) is called.

**Arguments:**
- `nextthink` (number) — The next time, relative to CurTime, to execute the ENTITY:Think clientside.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNextClientThink)

---

### Entity:SetNoDraw · Shared
`Entity:SetNoDraw(shouldNotDraw: boolean)`

Sets if the entity's model should render at all.

If set on the server, this entity will no longer network to clients, and for all intents and purposes cease to exist clientside.

The entity can still be manually rendered via [Entity:DrawModel](https://wiki.facepunch.com/gmod/Entity:DrawModel) in appropriate hooks.

**Arguments:**
- `shouldNotDraw` (boolean) — true disables drawing

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNoDraw)

---

### Entity:SetNotSolid · Shared
`Entity:SetNotSolid(IsNotSolid: boolean)`

Sets whether the entity is solid or not.

**Arguments:**
- `IsNotSolid` (boolean) — True will make the entity not solid, false will make it solid.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNotSolid)

---

### Entity:SetNPCClass · Server
`Entity:SetNPCClass(classification: number)`

Sets the NPC classification. Internally sets the `m_iClass` variable which is polled by the engine.

**Arguments:**
- `classification` (number, enum [CLASS](https://wiki.facepunch.com/gmod/Enums/CLASS)) — The CLASS Enum

> **Note:** This is a helper function only available if your SENT is based on `base_ai`

[wiki](https://wiki.facepunch.com/gmod/ENTITY:SetNPCClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_ai/init.lua#L14)

---

### Entity:SetNW2Angle · Shared
`Entity:SetNW2Angle(key: string, value: Angle)`

Sets a networked angle value on the entity.

The value can then be accessed with [Entity:GetNW2Angle](https://wiki.facepunch.com/gmod/Entity:GetNW2Angle) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Angle) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWAngle](https://wiki.facepunch.com/gmod/Entity:SetNWAngle) instead

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Angle)

---

### Entity:SetNW2Bool · Shared
`Entity:SetNW2Bool(key: string, value: boolean)`

Sets a networked boolean value on the entity.

The value can then be accessed with [Entity:GetNW2Bool](https://wiki.facepunch.com/gmod/Entity:GetNW2Bool) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (boolean) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWBool](https://wiki.facepunch.com/gmod/Entity:SetNWBool) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Bool)

---

### Entity:SetNW2Entity · Shared
`Entity:SetNW2Entity(key: string, value: Entity)`

Sets a networked entity value on the entity.

The value can then be accessed with [Entity:GetNW2Entity](https://wiki.facepunch.com/gmod/Entity:GetNW2Entity) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Entity) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWEntity](https://wiki.facepunch.com/gmod/Entity:SetNWEntity) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Entity)

---

### Entity:SetNW2Float · Shared
`Entity:SetNW2Float(key: string, value: number)`

Sets a networked float (number) value on the entity.

The value can then be accessed with [Entity:GetNW2Float](https://wiki.facepunch.com/gmod/Entity:GetNW2Float) both from client and server.

Unlike [Entity:SetNW2Int](https://wiki.facepunch.com/gmod/Entity:SetNW2Int), floats don't have to be whole numbers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWFloat](https://wiki.facepunch.com/gmod/Entity:SetNWFloat) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Float)

---

### Entity:SetNW2Int · Shared
`Entity:SetNW2Int(key: string, value: number)`

Sets a networked integer (whole number) value on the entity.

The value can then be accessed with [Entity:GetNW2Int](https://wiki.facepunch.com/gmod/Entity:GetNW2Int) both from client and server.

See [Entity:SetNW2Float](https://wiki.facepunch.com/gmod/Entity:SetNW2Float) for numbers that aren't integers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS.  
> The integer has a 32 bit limit. Use [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Int)

---

### Entity:SetNW2String · Shared
`Entity:SetNW2String(key: string, value: string)`

Sets a networked string value on the entity.

The value can then be accessed with [Entity:GetNW2String](https://wiki.facepunch.com/gmod/Entity:GetNW2String) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with, up to 1023 characters
- `value` (string) — The value to set, up to 511 characters.

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWString](https://wiki.facepunch.com/gmod/Entity:SetNWString) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2String)

---

### Entity:SetNW2Var · Shared
`Entity:SetNW2Var(key: string, value: any)`

Sets a networked value on the entity.

The value can then be accessed with [Entity:GetNW2Var](https://wiki.facepunch.com/gmod/Entity:GetNW2Var) both from client and server.

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
- `key` (string) — The key to associate the value with
- `value` (any) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** Trying to network a type that is not listed above leads to the value not being networked!  
> the value will only be updated clientside if the entity is or enters the clients PVS.
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Var)

---

### Entity:SetNW2VarProxy · Shared
`Entity:SetNW2VarProxy(key: string, callback: function)`

Sets a function to be called when the NW2Var changes. Internally uses [GM:EntityNetworkedVarChanged](https://wiki.facepunch.com/gmod/GM:EntityNetworkedVarChanged) to call the function.  
Alias of [Entity:SetNetworked2VarProxy](https://wiki.facepunch.com/gmod/Entity:SetNetworked2VarProxy)

**Arguments:**
- `key` (string) — The key of the NW2Var to add callback for.
- `callback` (function) — The function to be called when the NW2Var changes.

> **Note:** Only one NW2VarProxy can be set per-var  
> Running this function will only set it for the realm it is called on.
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity, or else this will be called multiple times and the NW2Var could get mixed up with other ones.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2VarProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L626)

---

### Entity:SetNW2Vector · Shared
`Entity:SetNW2Vector(key: string, value: Vector)`

Sets a networked vector value on the entity.

The value can then be accessed with [Entity:GetNW2Vector](https://wiki.facepunch.com/gmod/Entity:GetNW2Vector) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Vector) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.  
> The value will only be networked if it isn't the same as the current value and unlike SetNW*
> the value will only be networked once and not every 10 seconds.
> **Warning:** The value will only be updated clientside if the entity is or enters the clients PVS. use [Entity:SetNWVector](https://wiki.facepunch.com/gmod/Entity:SetNWVector) instead
> **Bug** ([#5455](https://github.com/Facepunch/garrysmod/issues/5455)): You should not use the NW2 System on entities that are based on a Lua Entity or else NW2Vars could get mixed up, updated multiple times or not be set.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNW2Vector)

---

### Entity:SetNWAngle · Shared
`Entity:SetNWAngle(key: string, value: Angle)`

Sets a networked angle value on the entity.

The value can then be accessed with [Entity:GetNWAngle](https://wiki.facepunch.com/gmod/Entity:GetNWAngle) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Angle) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Angle](https://wiki.facepunch.com/gmod/Entity:SetNW2Angle). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWAngle)

---

### Entity:SetNWBool · Shared
`Entity:SetNWBool(key: string, value: boolean)`

Sets a networked boolean value on the entity.

The value can then be accessed with [Entity:GetNWBool](https://wiki.facepunch.com/gmod/Entity:GetNWBool) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (boolean) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4096 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Bool](https://wiki.facepunch.com/gmod/Entity:SetNW2Bool). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWBool)

---

### Entity:SetNWEntity · Shared
`Entity:SetNWEntity(key: string, value: Entity)`

Sets a networked entity value on the entity.

The value can then be accessed with [Entity:GetNWEntity](https://wiki.facepunch.com/gmod/Entity:GetNWEntity) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Entity) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4096 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Entity](https://wiki.facepunch.com/gmod/Entity:SetNW2Entity). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWEntity)

---

### Entity:SetNWFloat · Shared
`Entity:SetNWFloat(key: string, value: number)`

Sets a networked float (number) value on the entity.

The value can then be accessed with [Entity:GetNWFloat](https://wiki.facepunch.com/gmod/Entity:GetNWFloat) both from client and server.

Unlike [Entity:SetNWInt](https://wiki.facepunch.com/gmod/Entity:SetNWInt), floats don't have to be whole numbers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Float](https://wiki.facepunch.com/gmod/Entity:SetNW2Float). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWFloat)

---

### Entity:SetNWInt · Shared
`Entity:SetNWInt(key: string, value: number)`

Sets a networked integer (whole number) value on the entity.

The value can then be accessed with [Entity:GetNWInt](https://wiki.facepunch.com/gmod/Entity:GetNWInt) both from client and server.

See [Entity:SetNWFloat](https://wiki.facepunch.com/gmod/Entity:SetNWFloat) for numbers that aren't integers.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (number) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Int](https://wiki.facepunch.com/gmod/Entity:SetNW2Int). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)
> **Bug** ([#3374](https://github.com/Facepunch/garrysmod/issues/3374)): This function will not round decimal values as it actually networks a float internally.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWInt)

---

### Entity:SetNWString · Shared
`Entity:SetNWString(key: string, value: string)`

Sets a networked string value on the entity.

The value can then be accessed with [Entity:GetNWString](https://wiki.facepunch.com/gmod/Entity:GetNWString) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (string) — The value to set, up to 199 characters.

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2String](https://wiki.facepunch.com/gmod/Entity:SetNW2String). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWString)

---

### Entity:SetNWVarProxy · Shared
`Entity:SetNWVarProxy(key: string, callback: function)`

Sets a function to be called when the NWVar changes.

**Arguments:**
- `key` (string) — The key of the NWVar to add callback for.
- `callback` (function) — The function to be called when the NWVar changes.

> **Note:** Only one NWVarProxy can be set per-var  
> Running this function will only set it for the realm it is called on.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWVarProxy)

---

### Entity:SetNWVector · Shared
`Entity:SetNWVector(key: string, value: Vector)`

Sets a networked vector value on the entity.

The value can then be accessed with [Entity:GetNWVector](https://wiki.facepunch.com/gmod/Entity:GetNWVector) both from client and server.

**Arguments:**
- `key` (string) — The key to associate the value with
- `value` (Vector) — The value to set

> **Note:** Running this function clientside will only set it for the client it is called on.
> **Warning:** There's a 4095 slots Network limit. If you need more, consider using the [net](https://wiki.facepunch.com/gmod/net) library or [Entity:SetNW2Vector](https://wiki.facepunch.com/gmod/Entity:SetNW2Vector). You should also consider the fact that you have way too many variables. You can learn more about this limit here: [Networking_Usage#nwlimits](https://wiki.facepunch.com/gmod/Networking_Usage#nwlimits)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetNWVector)

---

### Entity:SetOwner · Shared
`Entity:SetOwner(owner: Entity = NULL)`

Sets the owner of this entity, disabling all physics interaction with it.

**Arguments:**
- `owner` (Entity, default `NULL`) — The entity to be set as owner.

> **Note:** This function is generally used to disable physics interactions on projectiles being fired by their owner, but can also be used for normal ownership in case physics interactions are not involved at all. The Gravity gun will be able to pick up the entity even if the owner can't collide with it, the Physics gun however will not.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetOwner)

---

### Entity:SetParent · Shared
`Entity:SetParent(parent: Entity = NULL, attachmentOrBoneId: number = -1)`

Sets the parent of this entity, making it move with its parent. This will make the child entity non solid, nothing can interact with them, including traces (but [util.TraceHull](https://wiki.facepunch.com/gmod/util.TraceHull) will work).

All children of the parent get removed whenever it gets removed.

**Arguments:**
- `parent` (Entity, default `NULL`) — The entity to parent to.
- `attachmentOrBoneId` (number, default `-1`) — The attachment or bone id to use when parenting.

> **Note:** This does not work on [the world](https://wiki.facepunch.com/gmod/game.GetWorld).
> **Warning:** This can cause undefined physics behavior when used on entities that don't support parenting. See the [Valve developer wiki](https://developer.valvesoftware.com/wiki/Entity_Hierarchy_(parenting)) for more information.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetParent)

---

### Entity:SetParentPhysNum · Shared
`Entity:SetParentPhysNum(bone: number)`

Sets the parent of an entity to another entity with the given physics bone number. Similar to [Entity:SetParent](https://wiki.facepunch.com/gmod/Entity:SetParent), except it is parented to a physbone. This function is useful mainly for ragdolls.

**Arguments:**
- `bone` (number) — Physics bone number to attach to.

> **Note:** Despite this function being available server side, it doesn't actually do anything server side.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetParentPhysNum)

---

### Entity:SetPersistent · Shared
`Entity:SetPersistent(persist: boolean)`

Sets whether or not the given entity is persistent. A persistent entity will be saved on server shutdown and loaded back when the server starts up. Additionally, by default persistent entities cannot be grabbed with the physgun and tools cannot be used on them.

In sandbox, this can be set on an entity by opening the context menu, right clicking the entity, and choosing `"Make Persistent"`.

**Arguments:**
- `persist` (boolean) — Whether or not the entity should be persistent.

> **Note:** Persistence can only be enabled with the sbox_persist convar, which works as an identifier for the current set of persistent entities. An empty identifier (which is the default value) disables this feature.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPersistent)

---

### Entity:SetPhysConstraintObjects · Server
`Entity:SetPhysConstraintObjects(Phys1: PhysObj, Phys2: PhysObj)`

When called on a constraint entity, sets the two physics objects to be constrained.

Usage is not recommended as the Constraint library provides easier ways to deal with constraints.

**Arguments:**
- `Phys1` (PhysObj) — The first physics object to be constrained.
- `Phys2` (PhysObj) — The second physics object to be constrained.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPhysConstraintObjects)

---

### Entity:SetPhysicsAttacker · Server
`Entity:SetPhysicsAttacker(ent: Player, timeLimit: number = 5)`

Sets the player who gets credit if this entity kills something with physics damage within the time limit.

**Arguments:**
- `ent` (Player) — Player who gets the kills.
- `timeLimit` (number, default `5`) — Time in seconds until the entity forgets its physics attacker and prevents it from getting the kill credit.

> **Note:** Only functional on props, "anim" type SENTs, vehicles and a few other select entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPhysicsAttacker)

---

### Entity:SetPlaybackRate · Shared
`Entity:SetPlaybackRate(fSpeed: number)`

Allows you to set how fast an entity's animation will play, with 1.0 being the default speed.

		It is networked to clients, but limited to [-4,12] range when networking.

**Arguments:**
- `fSpeed` (number) — How fast the animation will play.

> **Note:** This function does not affect gestures.
> 			Use [Entity:SetLayerPlaybackRate](https://wiki.facepunch.com/gmod/Entity:SetLayerPlaybackRate) instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPlaybackRate)

---

### Entity:SetPos · Shared
`Entity:SetPos(position: Vector)`

Moves the entity to the specified position.

Some entities, such as ragdolls, will continually reset their position. Consider using [PhysObj:SetPos](https://wiki.facepunch.com/gmod/PhysObj:SetPos) on every physics object to move ragdolls.

**Arguments:**
- `position` (Vector) — The position to move the entity to.

> **Note:** If the new position doesn't take effect right away, you can use [Entity:SetupBones](https://wiki.facepunch.com/gmod/Entity:SetupBones) to force it to do so. This issue is especially common when trying to render the same entity twice or more in a single frame at different positions.
> **Warning:** Entities with [Entity:GetSolid](https://wiki.facepunch.com/gmod/Entity:GetSolid) of `SOLID_BBOX` will have their angles reset!
> **Bug** ([#2447](https://github.com/Facepunch/garrysmod/issues/2447)): This will fail inside of predicted functions called during player movement processing. This includes [WEAPON:PrimaryAttack](https://wiki.facepunch.com/gmod/WEAPON:PrimaryAttack) and [WEAPON:Think](https://wiki.facepunch.com/gmod/WEAPON:Think).

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPos)

---

### Entity:SetPoseParameter · Shared
`Entity:SetPoseParameter(poseName: string, poseValue: number)`

Sets the specified pose parameter to the specified value.

You should call [Entity:InvalidateBoneCache](https://wiki.facepunch.com/gmod/Entity:InvalidateBoneCache) after calling this function.

**Arguments:**
- `poseName` (string) — Name of the pose parameter.
- `poseValue` (number) — The value to set the pose to.

> **Note:** Avoid calling this in draw hooks, especially when animating things, as it might cause visual artifacts.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPoseParameter)

---

### Entity:SetPredictable · Client
`Entity:SetPredictable(setPredictable: boolean)`

Sets whether an entity should be predictable or not.
When an entity is set as predictable, its DT vars can be changed during predicted hooks. This is useful for entities which can be controlled by player input.

Any datatable value that mismatches from the server will be overridden and a prediction error will be spewed.

Weapons are predictable by default, and the drive system uses this function to make the controlled prop predictable as well.

Visit  for a list of all predicted hooks, and the [Prediction](https://wiki.facepunch.com/gmod/Prediction) page.
For further technical information on the subject, visit [valve's wiki](https://developer.valvesoftware.com/wiki/Prediction).

**Arguments:**
- `setPredictable` (boolean) — whether to make this entity predictable or not.

> **Note:** This function resets the datatable variables everytime it's called, it should ideally be called when a player starts using the entity and when he stops
> **Note:** Entities set as predictable with this function will be unmarked when the user lags and receives a full packet update, to handle such case visit [GM:NotifyShouldTransmit](https://wiki.facepunch.com/gmod/GM:NotifyShouldTransmit)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPredictable)

---

### Entity:SetPreventTransmit · Server
`Entity:SetPreventTransmit(player: Player|CRecipientFilter|table<Player>, stopTransmitting: boolean)`

Prevents the server from sending any further information about the entity to a player.

**Arguments:**
- `player` (Player|CRecipientFilter|table<Player>) — The player to stop networking the entity to.
- `stopTransmitting` (boolean) — true to stop the entity from networking, false to make it network again.

> **Note:** You must also call this function on all entity's children. See [Entity:GetChildren](https://wiki.facepunch.com/gmod/Entity:GetChildren).
> 
> [issue tracker](https://github.com/Facepunch/garrysmod-issues/issues/1736)
> 
> [Entity:SetFlexScale](https://wiki.facepunch.com/gmod/Entity:SetFlexScale) and other flex/bone manipulation functions will create a child entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetPreventTransmit)

---

### Entity:SetRagdollAng · Server
`Entity:SetRagdollAng(boneid: number, pos: Angle)`

Sets the bone angles. This is used alongside Kinect in [Entity:SetRagdollBuildFunction](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction), for more info see ragdoll_motion entity.

**Arguments:**
- `boneid` (number) — Bone ID
- `pos` (Angle) — Angle to set

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRagdollAng)

---

### Entity:SetRagdollBuildFunction · Server
`Entity:SetRagdollBuildFunction(builder: function)`

Sets the function to build the ragdoll. This is used alongside Kinect, for more info see `ragdoll_motion` entity in the game files.

**Arguments:**
- `builder` (function) — The build function.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction)

---

### Entity:SetRagdollPos · Server
`Entity:SetRagdollPos(boneid: number, pos: Vector)`

Sets the bone position. This is used alongside Kinect in [Entity:SetRagdollBuildFunction](https://wiki.facepunch.com/gmod/Entity:SetRagdollBuildFunction), for more info see ragdoll_motion entity.

**Arguments:**
- `boneid` (number) — Bone ID
- `pos` (Vector) — Position to set

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRagdollPos)

---

### Entity:SetRenderAngles · Client
`Entity:SetRenderAngles(newAngles: Angle|nil = nil)`

Sets the render angles override for the entity. [Entity:GetAngles](https://wiki.facepunch.com/gmod/Entity:GetAngles) will return the value set by this function until the override is disabled. (This is all this does internally)

See [Entity:SetRenderOrigin](https://wiki.facepunch.com/gmod/Entity:SetRenderOrigin) for the function to manipulate origin.

**Arguments:**
- `newAngles` (Angle|nil, default `nil`) — The new render angles to be set to.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderAngles) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/entity.lua#L16)

---

### Entity:SetRenderBounds · Client
`Entity:SetRenderBounds(mins: Vector, maxs: Vector, add: Vector = Vector( 0, 0, 0 ))`

Sets the render bounds for the entity.

For world space coordinate alternative see [Entity:SetRenderBoundsWS](https://wiki.facepunch.com/gmod/Entity:SetRenderBoundsWS).

**Arguments:**
- `mins` (Vector) — The minimum corner of the bounds, relative to origin of the entity.
- `maxs` (Vector) — The maximum corner of the bounds, relative to origin of the entity.
- `add` (Vector, default `Vector( 0, 0, 0 )`) — If defined, adds this vector to maxs and subtracts this vector from mins.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderBounds)

---

### Entity:SetRenderBoundsWS · Client
`Entity:SetRenderBoundsWS(mins: Vector, maxs: Vector, add: Vector = Vector( 0, 0, 0 ))`

Sets the render bounds for the entity in world space coordinates. For relative coordinates see [Entity:SetRenderBounds](https://wiki.facepunch.com/gmod/Entity:SetRenderBounds).

**Arguments:**
- `mins` (Vector) — The minimum corner of the bounds, relative to origin of the world/map.
- `maxs` (Vector) — The maximum corner of the bounds, relative to origin of the world/map.
- `add` (Vector, default `Vector( 0, 0, 0 )`) — If defined, adds this vector to maxs and subtracts this vector from mins.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderBoundsWS)

---

### Entity:SetRenderClipPlane · Client
`Entity:SetRenderClipPlane(planeNormal: Vector, planePosition: number)`

Used to specify a plane, past which an object will be visually clipped.

**Arguments:**
- `planeNormal` (Vector) — The normal of the plane.
- `planePosition` (number) — The position of the plane.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderClipPlane)

---

### Entity:SetRenderClipPlaneEnabled · Client
`Entity:SetRenderClipPlaneEnabled(enabled: boolean)`

Enables the use of clipping planes to "cut" objects.

**Arguments:**
- `enabled` (boolean) — Enable or disable clipping planes

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderClipPlaneEnabled)

---

### Entity:SetRenderFX · Shared
`Entity:SetRenderFX(renderFX: number)`

Sets entity's render FX. Requires the entitys rendermode to support transparency.

**Arguments:**
- `renderFX` (number, enum [kRenderFx](https://wiki.facepunch.com/gmod/Enums/kRenderFx)) — The new render FX to set, see kRenderFx

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderFX)

---

### Entity:SetRenderMode · Shared
`Entity:SetRenderMode(renderMode: number)`

Sets the render mode of the entity.

**Arguments:**
- `renderMode` (number, enum [RENDERMODE](https://wiki.facepunch.com/gmod/Enums/RENDERMODE)) — New render mode to set, see RENDERMODE.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderMode)

---

### Entity:SetRenderOrigin · Client
`Entity:SetRenderOrigin(newOrigin: Vector|nil = nil)`

Sets the render origin override, a position where the entity will be rendered at. [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos) will return the value set by this function until the override is disabled. (This is all this does internally)

See [Entity:SetRenderAngles](https://wiki.facepunch.com/gmod/Entity:SetRenderAngles) for the function to manipulate angles.

**Arguments:**
- `newOrigin` (Vector|nil, default `nil`) — The new origin in world coordinates where the entity's model will now be rendered at.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetRenderOrigin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/entity.lua#L17)

---

### Entity:SetSaveValue · Shared
`Entity:SetSaveValue(name: string, value: any) → boolean`

Sets a save value for an entity. You can see a full list of an entity's save values by creating it and printing [Entity:GetSaveTable](https://wiki.facepunch.com/gmod/Entity:GetSaveTable).

See [Entity:GetInternalVariable](https://wiki.facepunch.com/gmod/Entity:GetInternalVariable) for the opposite of this function.

**Arguments:**
- `name` (string) — Name of the save value to set
- `value` (any) — Value to set

**Returns:**
- boolean — Key successfully set

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSaveValue)

---

### Entity:SetSequence · Shared
`Entity:SetSequence(sequence: number)`

Sets the entity's model sequence.

If the specified sequence is already active, the animation will not be restarted. See [Entity:ResetSequence](https://wiki.facepunch.com/gmod/Entity:ResetSequence) for a function that restarts the animation even if it is already playing.

In some cases you want to run [Entity:ResetSequenceInfo](https://wiki.facepunch.com/gmod/Entity:ResetSequenceInfo) to make this function run.

**Arguments:**
- `sequence` (number) — The sequence to play.

> **Note:** This will not work properly if called directly after calling [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel). Consider waiting until the next Tick.
> 
> Will not work on players due to the animations being reset every frame by the base gamemode animation system. See [GM:CalcMainActivity](https://wiki.facepunch.com/gmod/GM:CalcMainActivity).
> 
> For custom scripted entities you will want to apply example from [ENTITY:Think](https://wiki.facepunch.com/gmod/ENTITY:Think) to make animations work.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSequence)

---

### Entity:SetShouldPlayPickupSound · Shared
`Entity:SetShouldPlayPickupSound(playsound: boolean = false)`

Sets whether or not the entity should make a physics contact sound when it's been picked up by a player.

**Arguments:**
- `playsound` (boolean, default `false`) — True to play the pickup sound, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetShouldPlayPickupSound) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L11-L13)

---

### Entity:SetShouldServerRagdoll · Shared
`Entity:SetShouldServerRagdoll(serverragdoll: boolean)`

Sets if entity should create a server ragdoll on death or a client one.

**Arguments:**
- `serverragdoll` (boolean) — Set `true` if ragdoll should be created on server, `false` if on client.

> **Note:** This is reset for players when they respawn ([Entity:Spawn](https://wiki.facepunch.com/gmod/Entity:Spawn)).
> 
> Player ragdolls created with this enabled will have an owner set, see [Entity:SetOwner](https://wiki.facepunch.com/gmod/Entity:SetOwner) for more information on what effects this has.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetShouldServerRagdoll)

---

### Entity:SetSkin · Shared
`Entity:SetSkin(skinIndex: number)`

Sets the skin of the entity.

[Entity:GetSkin](https://wiki.facepunch.com/gmod/Entity:GetSkin) returns current skin and [Entity:SkinCount](https://wiki.facepunch.com/gmod/Entity:SkinCount) returns amount of skins.

**Arguments:**
- `skinIndex` (number) — 0-based index of the skin to use.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSkin)

---

### Entity:SetSolid · Shared
`Entity:SetSolid(solid_type: number)`

Sets the solidity of an entity.

**Arguments:**
- `solid_type` (number, enum [SOLID](https://wiki.facepunch.com/gmod/Enums/SOLID)) — The solid type.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSolid)

---

### Entity:SetSolidFlags · Shared
`Entity:SetSolidFlags(flags: number{FSOLID})`

Sets solid flag(s) for the entity.

This overrides any other flags the entity might have had. See [Entity:AddSolidFlags](https://wiki.facepunch.com/gmod/Entity:AddSolidFlags) for adding flags.

**Arguments:**
- `flags` (number{FSOLID}) — The flag(s) to set, see FSOLID.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSolidFlags)

---

### Entity:SetSpawnEffect · Shared
`Entity:SetSpawnEffect(spawnEffect: boolean)`

Sets whether the entity should use a spawn effect when it is created on the client.

See [Entity:GetSpawnEffect](https://wiki.facepunch.com/gmod/Entity:GetSpawnEffect) for more information on how the effect is applied.

**Arguments:**
- `spawnEffect` (boolean) — Sets if we should show a spawn effect.

> **Note:** This function will only have an effect when the entity spawns. After that it will do nothing even is set to true.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSpawnEffect)

---

### Entity:SetSpawnFlags · Shared
`Entity:SetSpawnFlags(flags: number)`

Sets the SpawnFlags to set of an Entity

SpawnFlags can easily be found on https://developer.valvesoftware.com/wiki/.

**Arguments:**
- `flags` (number) — The SpawnFlag to remove from the Entity

> **Note:** See also [Entity:RemoveSpawnFlags](https://wiki.facepunch.com/gmod/Entity:RemoveSpawnFlags), [Entity:AddSpawnFlags](https://wiki.facepunch.com/gmod/Entity:AddSpawnFlags) 
> 
> 		Using [SF Enumerations](https://wiki.facepunch.com/gmod/Enums/SF) won't work, if this function is ran clientside due to the enumerations being defined only Serverside. Use the actual SpawnFlag number.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSpawnFlags) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L7-L9)

---

### Entity:SetSubMaterial · Shared
`Entity:SetSubMaterial(index: number = nil, material: string = nil)`

Overrides a single material on the model of this entity.

To set a Lua material created with [CreateMaterial](https://wiki.facepunch.com/gmod/Global.CreateMaterial), just prepend a `!` to the material name.

**Arguments:**
- `index` (number, default `nil`) — Index of the material to override, acceptable values are from `0` to `31`.
- `material` (string, default `nil`) — The material to override the default one with.

> **Bug** ([#3362](https://github.com/Facepunch/garrysmod/issues/3362)): The server's value takes priority on the client.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial)

---

### Entity:SetSurroundingBounds · Shared
`Entity:SetSurroundingBounds(min: Vector, max: Vector)`

Sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.

	See also [Entity:SetSurroundingBoundsType](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBoundsType) (mutually exclusive).

**Arguments:**
- `min` (Vector) — Minimum extent of the AABB relative to entity's position.
- `max` (Vector) — Maximum extent of the AABB relative to entity's position.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBounds)

---

### Entity:SetSurroundingBoundsType · Shared
`Entity:SetSurroundingBoundsType(bounds: number{BOUNDS})`

Automatically sets the axis-aligned bounding box (AABB) for an entity's hitbox detection.

	See also [Entity:SetSurroundingBounds](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBounds) (mutually exclusive).

**Arguments:**
- `bounds` (number{BOUNDS}) — Bounds type of the entity, see BOUNDS

[wiki](https://wiki.facepunch.com/gmod/Entity:SetSurroundingBoundsType)

---

### Entity:SetTable · Shared · `INTERNAL`
`Entity:SetTable(tab: table)`

Changes the table that can be accessed by indexing an entity. Each entity starts with its own table by default.

**Arguments:**
- `tab` (table) — Table for the entity to use

[wiki](https://wiki.facepunch.com/gmod/Entity:SetTable)

---

### Entity:SetTransmitWithParent · Shared
`Entity:SetTransmitWithParent(onoff: boolean)`

When this flag is set the entity will only transmit to the player when its parent is transmitted. This is useful for things like viewmodel attachments since without this flag they will transmit to everyone (and cause the viewmodels to transmit to everyone too).

**Arguments:**
- `onoff` (boolean) — Will set the TransmitWithParent flag on or off

> **Note:** In the case of scripted entities, this will override [ENTITY:UpdateTransmitState](https://wiki.facepunch.com/gmod/ENTITY:UpdateTransmitState)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetTransmitWithParent)

---

### Entity:SetTrigger · Server
`Entity:SetTrigger(maketrigger: boolean)`

Marks the entity as a trigger, so it will generate [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch), [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch) and [ENTITY:EndTouch](https://wiki.facepunch.com/gmod/ENTITY:EndTouch) callbacks.

Internally this is stored as [FSOLID_TRIGGER](https://wiki.facepunch.com/gmod/Enums/FSOLID) flag.

**Arguments:**
- `maketrigger` (boolean) — Make the entity trigger or not

[wiki](https://wiki.facepunch.com/gmod/Entity:SetTrigger)

---

### Entity:SetUnFreezable · Server
`Entity:SetUnFreezable(freezable: boolean = false)`

Sets whether an entity can be unfrozen, meaning that it cannot be unfrozen using the physgun.

**Arguments:**
- `freezable` (boolean, default `false`) — True to make the entity unfreezable, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetUnFreezable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L594-L596)

---

### Entity:SetupBones · Client
`Entity:SetupBones()`

Forces the entity to reconfigure its bones. You might need to call this after changing your model's scales or when manually drawing the entity multiple times at different positions.

> **Note:** This calls the BuildBonePositions callback added via [Entity:AddCallback](https://wiki.facepunch.com/gmod/Entity:AddCallback), so avoid calling this function inside it to prevent an infinite loop.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetupBones)

---

### Entity:SetupPhonemeMappings · Client
`Entity:SetupPhonemeMappings(fileRoot: string)`

Initializes the class names of an entity's phoneme mappings (mouth movement data). This is called by default with argument "phonemes" when a flex-based entity (such as an [NPC](https://wiki.facepunch.com/gmod/NPC)) is created.

**Arguments:**
- `fileRoot` (string) — The file prefix of the phoneme mappings (relative to "garrysmod/expressions/").

> **Note:** TF2 phonemes can be accessed by using a path such as "player/scout/phonemes/phonemes" , check TF2's "tf2_misc_dir.vpk" with GCFScape for other paths, however it seems that TF2 sounds don't contain phoneme definitions anymore after being converted to mp3 and only rely on VCD animations, this needs to be further investigated

[wiki](https://wiki.facepunch.com/gmod/Entity:SetupPhonemeMappings)

---

### Entity:SetUseType · Server
`Entity:SetUseType(useType: number{_USE})`

Sets the use type of an entity, affecting how often [ENTITY:Use](https://wiki.facepunch.com/gmod/ENTITY:Use) will be called for Lua entities.

**Arguments:**
- `useType` (number{_USE}) — The use type to apply to the entity.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetUseType)

---

### Entity:SetVar · Shared
`Entity:SetVar(key: any, value: any)`

Allows to quickly set variable to entity's [Entity:GetTable](https://wiki.facepunch.com/gmod/Entity:GetTable).

**Arguments:**
- `key` (any) — Key of the value to set
- `value` (any) — Value to set the variable to

> **Note:** This will not network the variable to client(s). You want [Entity:SetNWString](https://wiki.facepunch.com/gmod/Entity:SetNWString) and similar functions for that

[wiki](https://wiki.facepunch.com/gmod/Entity:SetVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L102-L106)

---

### Entity:SetVelocity · Shared
`Entity:SetVelocity(velocity: Vector)`

Sets the entity's velocity. For entities with physics, consider using [PhysObj:SetVelocity](https://wiki.facepunch.com/gmod/PhysObj:SetVelocity) on the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) of the entity.

**Arguments:**
- `velocity` (Vector) — The new velocity to set.

> **Note:** Actually binds to CBaseEntity::SetBaseVelocity() which sets the entity's velocity due to forces applied by other entities.
> **Warning:** If applied to a player, this will actually **ADD** velocity, not set it. (due to how movement code handles base velocity)

[wiki](https://wiki.facepunch.com/gmod/Entity:SetVelocity)

---

### Entity:SetWeaponModel · Shared
`Entity:SetWeaponModel(viewModel: string, weapon: Weapon = NULL)`

Sets the model and associated weapon to this viewmodel entity.

This is used internally when the player switches weapon.

**Arguments:**
- `viewModel` (string) — The model string to give to this viewmodel.
- `weapon` (Weapon, default `NULL`) — The weapon entity to associate this viewmodel to.

> **Note:** View models are not drawn without a weapons associated to them.
> **Warning:** This will silently fail if the entity is not a viewmodel.

[wiki](https://wiki.facepunch.com/gmod/Entity:SetWeaponModel)

---

### Entity:SkinCount · Shared
`Entity:SkinCount() → number`

Returns the amount of skins the entity has.

To set the entity's skin, use [Entity:SetSkin](https://wiki.facepunch.com/gmod/Entity:SetSkin).
To retrieve the total number of skins without an entity, see [util.GetModelInfo](https://wiki.facepunch.com/gmod/util.GetModelInfo).

**Returns:**
- number — The amount of skins the entity's model has.

[wiki](https://wiki.facepunch.com/gmod/Entity:SkinCount)

---

### Entity:SnatchModelInstance · Client
`Entity:SnatchModelInstance(srcEntity: Entity) → boolean`

Moves the model instance from the source entity to this entity. This can be used to transfer decals that have been applied on one entity to another.

Both entities must have the same model.

**Arguments:**
- `srcEntity` (Entity) — Entity to move the model instance from.

**Returns:**
- boolean — Whether the operation was successful or not

[wiki](https://wiki.facepunch.com/gmod/Entity:SnatchModelInstance)

---

### Entity:Spawn · Shared
`Entity:Spawn()`

Initializes the entity and starts its networking. If called on a player, it will respawn them.

This calls [ENTITY:Initialize](https://wiki.facepunch.com/gmod/ENTITY:Initialize) on Lua-defined entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:Spawn)

---

### Entity:StartLoopingSound · Shared
`Entity:StartLoopingSound(sound: string) → number`

Starts a "looping" sound. As with any other sound playing methods, this function expects the sound file to be looping itself and will not automatically loop a non looping sound file as one might expect.

This function is almost identical to [CreateSound](https://wiki.facepunch.com/gmod/Global.CreateSound), with the exception of the sound being created in the STATIC channel and with normal attenuation.

See also [Entity:StopLoopingSound](https://wiki.facepunch.com/gmod/Entity:StopLoopingSound)

**Arguments:**
- `sound` (string) — Sound to play.

**Returns:**
- number — The ID number of started sound starting with 0, or -1 if we failed for some reason.

[wiki](https://wiki.facepunch.com/gmod/Entity:StartLoopingSound)

---

### Entity:StartMotionController · Shared
`Entity:StartMotionController()`

Starts a motion controller in the physics engine tied to this entity's [PhysObj](https://wiki.facepunch.com/gmod/PhysObj), which enables the use of [ENTITY:PhysicsSimulate](https://wiki.facepunch.com/gmod/ENTITY:PhysicsSimulate).

The motion controller can later be destroyed via [Entity:StopMotionController](https://wiki.facepunch.com/gmod/Entity:StopMotionController).

Motion controllers are used internally to control other Entities' [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)ects, such as the Gravity Gun, +use pickup and the Physics Gun.

This function should be called every time you recreate the Entity's [PhysObj](https://wiki.facepunch.com/gmod/PhysObj). Or alternatively you should call [Entity:AddToMotionController](https://wiki.facepunch.com/gmod/Entity:AddToMotionController) on the new [PhysObj](https://wiki.facepunch.com/gmod/PhysObj).

Also see [Entity:AddToMotionController](https://wiki.facepunch.com/gmod/Entity:AddToMotionController) and [Entity:RemoveFromMotionController](https://wiki.facepunch.com/gmod/Entity:RemoveFromMotionController).

> **Note:** Only works on a scripted [Entity](https://wiki.facepunch.com/gmod/Entity) of anim type.

[wiki](https://wiki.facepunch.com/gmod/Entity:StartMotionController)

---

### Entity:StopAndDestroyParticles · Client
`Entity:StopAndDestroyParticles()`

Stops all particle effects parented to the entity and immediately destroys them.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopAndDestroyParticles)

---

### Entity:StopLoopingSound · Shared
`Entity:StopLoopingSound(id: number)`

Stops a sound created by [Entity:StartLoopingSound](https://wiki.facepunch.com/gmod/Entity:StartLoopingSound).

**Arguments:**
- `id` (number) — The sound ID returned by Entity:StartLoopingSound

[wiki](https://wiki.facepunch.com/gmod/Entity:StopLoopingSound)

---

### Entity:StopMotionController · Shared
`Entity:StopMotionController()`

Stops the motion controller created with [Entity:StartMotionController](https://wiki.facepunch.com/gmod/Entity:StartMotionController).

[wiki](https://wiki.facepunch.com/gmod/Entity:StopMotionController)

---

### Entity:StopParticleEmission · Client
`Entity:StopParticleEmission()`

Stops all particle effects parented to the entity.

This is ran automatically on every client by [Entity:StopParticles](https://wiki.facepunch.com/gmod/Entity:StopParticles) if called on the server.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopParticleEmission)

---

### Entity:StopParticles · Shared
`Entity:StopParticles()`

Stops any attached to the entity .pcf particles using [ParticleEffectAttach](https://wiki.facepunch.com/gmod/Global.ParticleEffectAttach) or [ParticleEffect](https://wiki.facepunch.com/gmod/Global.ParticleEffect).

On client, this is the same as [Entity:StopParticleEmission](https://wiki.facepunch.com/gmod/Entity:StopParticleEmission). ( and you should use StopParticleEmission instead )


On server, this is the same as running [Entity:StopParticleEmission](https://wiki.facepunch.com/gmod/Entity:StopParticleEmission) on every client.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopParticles)

---

### Entity:StopParticlesNamed · Client
`Entity:StopParticlesNamed(name: string)`

Stops all particle effects parented to the entity with given name.

**Arguments:**
- `name` (string) — The name of the particle to stop.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopParticlesNamed)

---

### Entity:StopParticlesWithNameAndAttachment · Client
`Entity:StopParticlesWithNameAndAttachment(name: string, attachment: number)`

Stops all particle effects parented to the entity with given name on given attachment.

**Arguments:**
- `name` (string) — The name of the particle to stop.
- `attachment` (number) — The attachment of the entity to stop particles on.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopParticlesWithNameAndAttachment)

---

### Entity:StopSound · Shared
`Entity:StopSound(sound: string)`

Stops emitting the given sound from the entity, especially useful for looping sounds.

Internally plays the sound with the [SND_STOP](https://wiki.facepunch.com/gmod/Enums/SND#SND_STOP) flag to stop the sound.

**Arguments:**
- `sound` (string) — The name of the sound script or the filepath to stop playback of.

[wiki](https://wiki.facepunch.com/gmod/Entity:StopSound)

---

### Entity:TakeDamage · Server
`Entity:TakeDamage(damageAmount: number, attacker: Entity = nil, inflictor: Entity = nil)`

Applies the specified amount of damage to the entity with [DMG_GENERIC](https://wiki.facepunch.com/gmod/Enums/DMG) flag.

**Arguments:**
- `damageAmount` (number) — The amount of damage to be applied.
- `attacker` (Entity, default `nil`) — The entity that initiated the attack that caused the damage.
- `inflictor` (Entity, default `nil`) — The entity that applied the damage, eg.

> **Warning:** Calling this function on the victim entity in [ENTITY:OnTakeDamage](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage) can cause infinite loops.
> **Warning:** This function does not seem to do any damage if you apply it to a player who is driving a prop_vehicle_jeep or prop_vehicle_jeep_old vehicle. You need to call it on the vehicle instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:TakeDamage)

---

### Entity:TakeDamageInfo · Server
`Entity:TakeDamageInfo(damageInfo: CTakeDamageInfo)`

Applies the damage specified by the damage info to the entity.

**Arguments:**
- `damageInfo` (CTakeDamageInfo) — The damage to apply.

> **Note:** This function does not apply damage to [func_breakable_surf](https://developer.valvesoftware.com/wiki/Func_breakable_surf) entities correctly. To do this, you will need to use [Entity:DispatchTraceAttack](https://wiki.facepunch.com/gmod/Entity:DispatchTraceAttack) instead.
> **Warning:** Calling this function on the victim entity in [ENTITY:OnTakeDamage](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage) can cause infinite loops.
> **Warning:** This function does not seem to do any damage if you apply it to a player who is driving a prop_vehicle_jeep or prop_vehicle_jeep_old vehicle. You need to call it on the vehicle instead.

[wiki](https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo)

---

### Entity:TakePhysicsDamage · Server
`Entity:TakePhysicsDamage(dmginfo: CTakeDamageInfo)`

Applies forces to our physics object in response to damage.

**Arguments:**
- `dmginfo` (CTakeDamageInfo) — The damageinfo to apply.

[wiki](https://wiki.facepunch.com/gmod/Entity:TakePhysicsDamage)

---

### Entity:TestPVS · Server
`Entity:TestPVS(testPoint: Vector|Entity) → boolean`

Check if the given position or entity is within this entity's [PVS(Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community").

See also [Entity:IsDormant](https://wiki.facepunch.com/gmod/Entity:IsDormant).

**Arguments:**
- `testPoint` (Vector|Entity) — Entity or Vector to test against.

**Returns:**
- boolean — `true` if the testPoint is within our PVS.

> **Note:** The function won't take in to account [AddOriginToPVS](https://wiki.facepunch.com/gmod/Global.AddOriginToPVS) and the like.

[wiki](https://wiki.facepunch.com/gmod/Entity:TestPVS)

---

### Entity:TranslateBoneToPhysBone · Shared
`Entity:TranslateBoneToPhysBone(boneID: number) → number`

Returns the ID of a [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) attached to the given bone.

See [Entity:TranslatePhysBoneToBone](https://wiki.facepunch.com/gmod/Entity:TranslatePhysBoneToBone) for reverse function.

**Arguments:**
- `boneID` (number) — The ID of a bone to look up the "physics root" bone of.

**Returns:**
- number — The PhysObj ID of the given bone to be used with Entity:GetPhysicsObjectNum or `-1` if we cannot translate for some reason, such as a model bone having no physics object associated with it.

[wiki](https://wiki.facepunch.com/gmod/Entity:TranslateBoneToPhysBone)

---

### Entity:TranslatePhysBoneToBone · Shared
`Entity:TranslatePhysBoneToBone(physNum: number) → number`

Returns the boneID of the bone the given [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) is attached to.

See [Entity:TranslateBoneToPhysBone](https://wiki.facepunch.com/gmod/Entity:TranslateBoneToPhysBone) for reverse function.

**Arguments:**
- `physNum` (number) — The PhysObj number on the entity

**Returns:**
- number — The boneID of the bone the PhysObj is attached to.

[wiki](https://wiki.facepunch.com/gmod/Entity:TranslatePhysBoneToBone)

---

### Entity:UpdateBoneFollowers · Server
`Entity:UpdateBoneFollowers()`

Updates positions of bone followers created by [Entity:CreateBoneFollowers](https://wiki.facepunch.com/gmod/Entity:CreateBoneFollowers).

This should be called every tick.

> **Note:** This function only works on `anim`, `nextbot` and `ai` type entities.

[wiki](https://wiki.facepunch.com/gmod/Entity:UpdateBoneFollowers)

---

### Entity:UpdateShadow · Client
`Entity:UpdateShadow()`

Marks the render-to-texture (RTT) shadow of this entity as dirty, as well as any potential projected texture shadows related to this entity, so they will be updated as soon as possible.

[wiki](https://wiki.facepunch.com/gmod/Entity:UpdateShadow)

---

### Entity:Use · Server
`Entity:Use(activator: Entity, caller: Entity = NULL, useType: number{USE} = USE_ON, value: number = 0)`

Simulates a `+use` action on an entity.

**Arguments:**
- `activator` (Entity) — The entity that caused this input.
- `caller` (Entity, default `NULL`) — The entity responsible for the input.
- `useType` (number{USE}, default `USE_ON`) — Use type, see USE.
- `value` (number, default `0`) — Any value.

[wiki](https://wiki.facepunch.com/gmod/Entity:Use(function))

---

### Entity:UseClientSideAnimation · Shared
`Entity:UseClientSideAnimation()`

Animations will be handled purely clientside instead of a fixed animtime, enabling interpolation. This does not affect layers and gestures.

> **Note:** Does nothing on server.

[wiki](https://wiki.facepunch.com/gmod/Entity:UseClientSideAnimation)

---

### Entity:UseTriggerBounds · Shared
`Entity:UseTriggerBounds(enable: boolean, boundSize: number = 0)`

Enables or disables trigger bounds.

This will give the entity a "trigger box" that extends around its bounding box by boundSize units in X/Y and (boundSize / 2) in +Z (-Z remains the same).
The trigger box is world aligned and will work regardless of the object's solidity and collision group.

Valve use trigger boxes for all pickup items. Their bloat size is 24, a surprisingly large figure.

**Arguments:**
- `enable` (boolean) — Enable or disable the bounds.
- `boundSize` (number, default `0`) — The distance/size of the trigger bounds.

> **Note:** The trigger boxes can be made visible as a light blue box by using the **ent_bbox** console command while looking at the entity. Alternatively a classname or entity index can be used as the first argument.
> 
> This requires **developer** to be set to **1**.

[wiki](https://wiki.facepunch.com/gmod/Entity:UseTriggerBounds)

---

### Entity:ViewModelIndex · Shared
`Entity:ViewModelIndex() → number`

Returns the index of this view model, it can be used to identify which one of the player's view models this entity is.

**Returns:**
- number — View model index, ranges from 0 to 2, nil if the entity is not a view model

[wiki](https://wiki.facepunch.com/gmod/Entity:ViewModelIndex)

---

### Entity:Visible · Server
`Entity:Visible(target: Entity) → boolean`

Returns whether the target/given entity is visible from the this entity.

This is meant to be used only with NPCs.

Differences from a simple trace include:
* If target has `FL_NOTARGET`, returns `false`
* If `ai_ignoreplayers` is turned on and target is a player, returns `false`
* Reacts to `ai_LOS_mode`:
* * If `1`, does a simple trace with `COLLISION_GROUP_NONE` and `MASK_BLOCKLOS`
* * If not, does a trace with `MASK_BLOCKLOS_AND_NPCS` (- `CONTENTS_BLOCKLOS` is target is player) and a custom LOS filter (`CTraceFilterLOS`)
* Returns `true` if hits a vehicle the target is driving

**Arguments:**
- `target` (Entity) — Entity to check for visibility to.

**Returns:**
- boolean — If the entities can see each other.

[wiki](https://wiki.facepunch.com/gmod/Entity:Visible)

---

### Entity:VisibleVec · Server
`Entity:VisibleVec(pos: Vector) → boolean`

Returns true if supplied vector is visible from the entity's line of sight.

This is achieved similarly to a trace.

**Arguments:**
- `pos` (Vector) — The position to check for visibility

**Returns:**
- boolean — Within line of sight

[wiki](https://wiki.facepunch.com/gmod/Entity:VisibleVec)

---

### Entity:WaterLevel · Shared
`Entity:WaterLevel() → number`

Returns an integer that represents how deep in water the entity is.

**Returns:**
- number — The water level.

[wiki](https://wiki.facepunch.com/gmod/Entity:WaterLevel)

---

### Entity:Weapon_SetActivity · Shared
`Entity:Weapon_SetActivity(act: number, duration: number)`

Sets the activity of the entity's active weapon.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — Activity number.
- `duration` (number) — How long the animation should take in seconds.

> **Note:** This does nothing on the client.
> **Note:** Only works for CBaseCombatCharacter entities, which includes players and NPCs.

[wiki](https://wiki.facepunch.com/gmod/Entity:Weapon_SetActivity)

---

### Entity:Weapon_TranslateActivity · Shared
`Entity:Weapon_TranslateActivity(act: number) → number`

Calls and returns [WEAPON:TranslateActivity](https://wiki.facepunch.com/gmod/WEAPON:TranslateActivity) on the weapon the entity (player or NPC) carries.

**Arguments:**
- `act` (number) — The NPC activity to translate

**Returns:**
- number — The translated activity.

> **Note:** Doesn't return anything on client, despite existing there.

[wiki](https://wiki.facepunch.com/gmod/Entity:Weapon_TranslateActivity)

---

### Entity:WorldSpaceAABB · Shared
`Entity:WorldSpaceAABB() → Vector, Vector`

Returns two vectors representing the minimum and maximum extent of the entity's axis-aligned bounding box (which is calculated from entity's collision bounds.

**Returns:**
- Vector — The minimum vector for the entity's bounding box in world space.
- Vector — The maximum vector for the entity's bounding box in world space.

[wiki](https://wiki.facepunch.com/gmod/Entity:WorldSpaceAABB)

---

### Entity:WorldSpaceCenter · Shared
`Entity:WorldSpaceCenter() → Vector`

Returns the center of the entity according to its collision model.

**Returns:**
- Vector — The center of the entity

[wiki](https://wiki.facepunch.com/gmod/Entity:WorldSpaceCenter)

---

### Entity:WorldToLocal · Shared
`Entity:WorldToLocal(wpos: Vector) → Vector`

Translates a worldspace vector into a vector relative to the entity's coordinate system.

**Arguments:**
- `wpos` (Vector) — A worldspace vector.

**Returns:**
- Vector — The corresponding local space vector.

[wiki](https://wiki.facepunch.com/gmod/Entity:WorldToLocal)

---

### Entity:WorldToLocalAngles · Shared
`Entity:WorldToLocalAngles(ang: Angle) → Angle`

Translates a worldspace angle into an angle relative to the entity's coordinate system.

**Arguments:**
- `ang` (Angle) — A worldspace angle.

**Returns:**
- Angle — The corresponding local space angle.

[wiki](https://wiki.facepunch.com/gmod/Entity:WorldToLocalAngles)
