# CNewParticleEffect

**Realm:** Client  ·  **Members:** 26

This object represents a .pcf ( Orange Box ) particle system. Created by [Entity:CreateParticleEffect](https://wiki.facepunch.com/gmod/Entity:CreateParticleEffect) and [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem).

[wiki page](https://wiki.facepunch.com/gmod/CNewParticleEffect)

### CNewParticleEffect:AddControlPoint · Client
`CNewParticleEffect:AddControlPoint(cpID: number, ent: Entity, partAttachment: number, entAttachment: string = nil, offset: Vector = Vector( 0, 0, 0 ))`

Adds a control point to the particle system.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `ent` (Entity) — The entity to attach the control point to.
- `partAttachment` (number, enum [PATTACH](https://wiki.facepunch.com/gmod/Enums/PATTACH)) — See PATTACH.
- `entAttachment` (string, default `nil`) — The attachment name on the entity to attach the particle system to
- `offset` (Vector, default `Vector( 0, 0, 0 )`) — The offset from the Entity:GetPos of the entity we are attaching this CP to.

> **Note:** This function will not work if the [CNewParticleEffect:GetOwner](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetOwner) entity is not valid

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:AddControlPoint)

---

### CNewParticleEffect:GetAutoUpdateBBox · Client
`CNewParticleEffect:GetAutoUpdateBBox() → boolean`

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetAutoUpdateBBox)

---

### CNewParticleEffect:GetEffectName · Client
`CNewParticleEffect:GetEffectName() → string`

Returns the name of the particle effect this system is set to emit.

**Returns:**
- string — The name of the particle effect.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetEffectName)

---

### CNewParticleEffect:GetHighestControlPoint · Client
`CNewParticleEffect:GetHighestControlPoint() → boolean`

Returns the highest control point number for given particle system.

**Returns:**
- boolean — The highest control point number for given particle system, 0 to 63.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetHighestControlPoint)

---

### CNewParticleEffect:GetOwner · Client
`CNewParticleEffect:GetOwner() → Entity`

Returns the owner of the particle system, the entity the particle system is attached to.

**Returns:**
- Entity — The owner of the particle system.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetOwner)

---

### CNewParticleEffect:GetRenderBounds · Client
`CNewParticleEffect:GetRenderBounds() → Vector, Vector`

Returns the bounding box of the particle effect, including all the particles it emitted.

**Returns:**
- Vector — Mins of the bounding box.
- Vector — Maxs of the bounding box.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetRenderBounds)

---

### CNewParticleEffect:GetShouldSimulate · Client
`CNewParticleEffect:GetShouldSimulate() → boolean`

Returns whether the particle system simulation was paused by [CNewParticleEffect:SetShouldSimulate](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetShouldSimulate).

**Returns:**
- boolean — Whether the simulation is running (`true`) or not (`false`).

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetShouldSimulate)

---

### CNewParticleEffect:IsFinished · Client
`CNewParticleEffect:IsFinished() → boolean`

Returns whether the particle system has finished emitting particles or not.

**Returns:**
- boolean — Whether the particle system has finished emitting particles or not.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:IsFinished)

---

### CNewParticleEffect:IsValid · Client
`CNewParticleEffect:IsValid() → boolean`

Returns whether the particle system is valid or not.

**Returns:**
- boolean — Whether the particle system is valid or not.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:IsValid)

---

### CNewParticleEffect:IsViewModelEffect · Client
`CNewParticleEffect:IsViewModelEffect() → boolean`

Returns whether the particle system is intended to be used on a view model?

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:IsViewModelEffect)

---

### CNewParticleEffect:Render · Client
`CNewParticleEffect:Render()`

Forces the particle system to render using current rendering context.

Can be used to render the particle system in vgui panels, etc.

Used in conjunction with [CNewParticleEffect:SetShouldDraw](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetShouldDraw).

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:Render)

---

### CNewParticleEffect:Restart · Client
`CNewParticleEffect:Restart()`

Forces the particle system to restart emitting particles.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:Restart)

---

### CNewParticleEffect:SetControlPoint · Client
`CNewParticleEffect:SetControlPoint(cpID: number, value: Vector)`

Sets a value for given control point.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `value` (Vector) — The value to set for given control point.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPoint)

---

### CNewParticleEffect:SetControlPointEntity · Client
`CNewParticleEffect:SetControlPointEntity(cpID: number, parent: Entity)`

Sets an entity to given control point for particle to use.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `parent` (Entity) — The entity to set.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointEntity)

---

### CNewParticleEffect:SetControlPointForwardVector · Client
`CNewParticleEffect:SetControlPointForwardVector(cpID: number, forward: Vector)`

Sets the forward direction for given control point.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `forward` (Vector) — The forward direction for given control point

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointForwardVector)

---

### CNewParticleEffect:SetControlPointOrientation · Client
`CNewParticleEffect:SetControlPointOrientation(cpID: number, forward: Vector, right: Vector, up: Vector)`

Sets the orientation for given control point.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `forward` (Vector) — The forward direction for given control point.
- `right` (Vector) — The right direction for given control point
- `up` (Vector) — The up direction for given control point

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointOrientation)

---

### CNewParticleEffect:SetControlPointParent · Client
`CNewParticleEffect:SetControlPointParent(childID: number, parentID: number)`

Essentially makes child control point follow the parent control point.

**Arguments:**
- `childID` (number) — The child control point ID, 0 to 63.
- `parentID` (number) — The parent control point ID, 0 to 63.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointParent)

---

### CNewParticleEffect:SetControlPointRightVector · Client
`CNewParticleEffect:SetControlPointRightVector(cpID: number, right: Vector)`

Sets the right direction for given control point.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `right` (Vector) — The right direction for given control point.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointRightVector)

---

### CNewParticleEffect:SetControlPointUpVector · Client
`CNewParticleEffect:SetControlPointUpVector(cpID: number, upward: Vector)`

Sets the upward direction for given control point.

**Arguments:**
- `cpID` (number) — The control point ID, 0 to 63.
- `upward` (Vector) — The upward direction for given control point

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetControlPointUpVector)

---

### CNewParticleEffect:SetIsViewModelEffect · Client
`CNewParticleEffect:SetIsViewModelEffect(isViewModel: boolean)`

Set whether this particle effect is a view model effect or not. This will have an effect on attachment positioning and other things.

**Arguments:**
- `isViewModel` (boolean) — Whether this particle effect is a view model effect or not.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetIsViewModelEffect)

---

### CNewParticleEffect:SetShouldDraw · Client
`CNewParticleEffect:SetShouldDraw(should: boolean)`

Forces the particle system to stop automatically rendering.

Used in conjunction with [CNewParticleEffect:Render](https://wiki.facepunch.com/gmod/CNewParticleEffect:Render).

**Arguments:**
- `should` (boolean) — Whether to automatically draw the particle effect or not.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetShouldDraw)

---

### CNewParticleEffect:SetShouldSimulate · Client
`CNewParticleEffect:SetShouldSimulate(simulate: boolean)`

Sets whether the particle system should continue simulation or not. If simulation is paused, all currently active particles will be frozen in place.

**Arguments:**
- `simulate` (boolean) — Whether the simulation should run (`true`) or not (`false`).

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetShouldSimulate)

---

### CNewParticleEffect:SetSortOrigin · Client
`CNewParticleEffect:SetSortOrigin(origin: Vector)`

Sets the sort origin for given particle system. This is used as a helper to determine which particles are in front of which.

**Arguments:**
- `origin` (Vector) — The new sort origin.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:SetSortOrigin)

---

### CNewParticleEffect:StartEmission · Client
`CNewParticleEffect:StartEmission(infiniteOnly: boolean = false)`

Starts the particle emission.

**Arguments:**
- `infiniteOnly` (boolean, default `false`)

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:StartEmission)

---

### CNewParticleEffect:StopEmission · Client
`CNewParticleEffect:StopEmission(infiniteOnly: boolean = false, removeAllParticles: boolean = false, wakeOnStop: boolean = false)`

Stops the particle emission.

**Arguments:**
- `infiniteOnly` (boolean, default `false`)
- `removeAllParticles` (boolean, default `false`)
- `wakeOnStop` (boolean, default `false`)

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:StopEmission)

---

### CNewParticleEffect:StopEmissionAndDestroyImmediately · Client
`CNewParticleEffect:StopEmissionAndDestroyImmediately()`

Stops particle emission and destroys all particles instantly. Also detaches the particle effect from the entity it was attached to.

Consider using [CNewParticleEffect:StopEmission](https://wiki.facepunch.com/gmod/CNewParticleEffect:StopEmission)( false, true ) instead, which has same effect, but doesn't require owner entity, and does't detach the particle system from its entity.

> **Note:** This function will work identically to [CNewParticleEffect:StopEmission](https://wiki.facepunch.com/gmod/CNewParticleEffect:StopEmission)( false, true ) if  [CNewParticleEffect:GetOwner](https://wiki.facepunch.com/gmod/CNewParticleEffect:GetOwner) entity is not valid.

[wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect:StopEmissionAndDestroyImmediately)
