# PhysObj

**Realm:** Shared  ·  **Members:** 78

This is the object returned by [Entity:GetPhysicsObject](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObject), [Entity:GetPhysicsObjectNum](https://wiki.facepunch.com/gmod/Entity:GetPhysicsObjectNum) and [Vehicle:GetWheel](https://wiki.facepunch.com/gmod/Vehicle:GetWheel).

It represents a physics object. An entity can have multiple physics objects (ragdolls), one physics objects (props), or none. (NPCs, non physics entities, etc.)

Physics objects are usually simulated by the physics engine and usually dictate the position of the entity, and not the other way around.

[wiki page](https://wiki.facepunch.com/gmod/PhysObj)

### PhysObj:AddAngleVelocity · Shared
`PhysObj:AddAngleVelocity(angularVelocity: Vector)`

Adds the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) velocity to the current [PhysObj](https://wiki.facepunch.com/gmod/PhysObj).

**Arguments:**
- `angularVelocity` (Vector) — The additional velocity in `degrees/s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:AddAngleVelocity)

---

### PhysObj:AddGameFlag · Shared
`PhysObj:AddGameFlag(flags: number)`

Adds one or more bit flags.

**Arguments:**
- `flags` (number, enum [FVPHYSICS](https://wiki.facepunch.com/gmod/Enums/FVPHYSICS)) — Bitflag, see FVPHYSICS.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:AddGameFlag)

---

### PhysObj:AddVelocity · Shared
`PhysObj:AddVelocity(velocity: Vector)`

Adds the specified velocity to the current.

**Arguments:**
- `velocity` (Vector) — Additional velocity in `source_unit/s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:AddVelocity)

---

### PhysObj:AlignAngles · Shared
`PhysObj:AlignAngles(from: Angle, to: Angle) → Angle`

Rotates the object so that it's angles are aligned to the ones inputted.

**Arguments:**
- `from` (Angle)
- `to` (Angle)

**Returns:**
- Angle

[wiki](https://wiki.facepunch.com/gmod/PhysObj:AlignAngles)

---

### PhysObj:ApplyForceCenter · Shared
`PhysObj:ApplyForceCenter(impulse: Vector)`

Applies the specified impulse in the mass center of the physics object.

**Arguments:**
- `impulse` (Vector) — The impulse) to be applied in `kg*source_unit/s`.

> **Note:** This will not work on players, use [Entity:SetVelocity](https://wiki.facepunch.com/gmod/Entity:SetVelocity) instead.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:ApplyForceCenter)

---

### PhysObj:ApplyForceOffset · Shared
`PhysObj:ApplyForceOffset(impulse: Vector, position: Vector)`

Applies the specified impulse on the physics object at the specified position.

**Arguments:**
- `impulse` (Vector) — The impulse to be applied in `kg*source_unit/s`.
- `position` (Vector) — The position in world coordinates (`source units`) where the force is applied to the physics object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:ApplyForceOffset)

---

### PhysObj:ApplyTorqueCenter · Shared
`PhysObj:ApplyTorqueCenter(angularImpulse: Vector)`

Applies the specified angular impulse to the physics object. See [PhysObj:CalculateForceOffset](https://wiki.facepunch.com/gmod/PhysObj:CalculateForceOffset)

**Arguments:**
- `angularImpulse` (Vector) — The angular impulse to be applied in `kg * m^2 * degrees / s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:ApplyTorqueCenter)

---

### PhysObj:CalculateForceOffset · Shared
`PhysObj:CalculateForceOffset(impulse: Vector, position: Vector) → Vector, Vector`

Calculates the linear and angular impulse on the object's center of mass for an offset impulse.The outputs can be used with [PhysObj:ApplyForceCenter](https://wiki.facepunch.com/gmod/PhysObj:ApplyForceCenter) and [PhysObj:ApplyTorqueCenter](https://wiki.facepunch.com/gmod/PhysObj:ApplyTorqueCenter), respectively.

**Be careful to convert the angular impulse to world frame ([PhysObj:LocalToWorldVector](https://wiki.facepunch.com/gmod/PhysObj:LocalToWorldVector)) if you are going to use it with ApplyTorqueCenter.**

**Arguments:**
- `impulse` (Vector) — The impulse acting on the object in `kg*source_unit/s`.
- `position` (Vector) — The location of the impulse in world coordinates (`source units`)

**Returns:**
- `linearImpulse` (Vector) — The calculated linear impulse on the physics object's center of mass in `kg*source_unit/s`.
- `angularImpulse` (Vector) — The calculated angular impulse on the physics object's center of mass in `kg*m^2*degrees/s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:CalculateForceOffset)

---

### PhysObj:CalculateVelocityOffset · Shared
`PhysObj:CalculateVelocityOffset(impulse: Vector, position: Vector) → Vector, Vector`

Calculates the linear and angular velocities on the center of mass for an offset impulse. The outputs can be directly passed to [PhysObj:AddVelocity](https://wiki.facepunch.com/gmod/PhysObj:AddVelocity) and [PhysObj:AddAngleVelocity](https://wiki.facepunch.com/gmod/PhysObj:AddAngleVelocity), respectively.

**Arguments:**
- `impulse` (Vector) — The impulse acting on the object in `kg*source_unit/s`.
- `position` (Vector) — The location of the impulse in world coordinates (`source units`)

**Returns:**
- Vector — The calculated linear velocity from the impulse on the physics object's center of mass in `source_unit/s`.
- Vector — The calculated angular velocity from the impulse on the physics object's center of mass in `degrees/s`.

> **Warning:** This will return zero length vectors if the physics object's motion is disabled. See [PhysObj:IsMotionEnabled](https://wiki.facepunch.com/gmod/PhysObj:IsMotionEnabled).

[wiki](https://wiki.facepunch.com/gmod/PhysObj:CalculateVelocityOffset)

---

### PhysObj:ClearGameFlag · Shared
`PhysObj:ClearGameFlag(flags: number)`

Removes one of more specified flags.

**Arguments:**
- `flags` (number, enum [FVPHYSICS](https://wiki.facepunch.com/gmod/Enums/FVPHYSICS)) — Bitflag, see FVPHYSICS.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:ClearGameFlag)

---

### PhysObj:ComputeShadowControl · Shared
`PhysObj:ComputeShadowControl(shadowparams: table)`

Allows you to move a PhysObj to a point and angle in 3D space. Works with any PhysObj, not just physics shadows.

**Arguments:**
- `shadowparams` (table) — The parameters for the shadow.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:ComputeShadowControl)

---

### PhysObj:EnableCollisions · Shared
`PhysObj:EnableCollisions(enable: boolean)`

Sets whether the physics object should collide with anything or not, including world.

**Arguments:**
- `enable` (boolean) — True to enable, false to disable.

> **Warning:** This function currently has major problems with player collisions, and as such should be avoided at all costs.
> 
> A better alternative to this function would be using [Entity:SetCollisionGroup](https://wiki.facepunch.com/gmod/Entity:SetCollisionGroup)( COLLISION_GROUP_WORLD ).

[wiki](https://wiki.facepunch.com/gmod/PhysObj:EnableCollisions)

---

### PhysObj:EnableDrag · Shared
`PhysObj:EnableDrag(enable: boolean)`

Sets whenever the physics object should be affected by drag.

**Arguments:**
- `enable` (boolean) — True to enable, false to disable.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:EnableDrag)

---

### PhysObj:EnableGravity · Shared
`PhysObj:EnableGravity(enable: boolean)`

Sets whether the PhysObject should be affected by gravity

**Arguments:**
- `enable` (boolean) — True to enable, false to disable.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:EnableGravity)

---

### PhysObj:EnableMotion · Shared
`PhysObj:EnableMotion(enable: boolean)`

Sets whether the physobject should be able to move or not.

This is the exact method the Physics Gun uses to freeze props. If a motion-disabled physics object is grabbed with the physics gun, the object will be able to move again. To disallow this, use [GM:PhysgunPickup](https://wiki.facepunch.com/gmod/GM:PhysgunPickup).

**Arguments:**
- `enable` (boolean) — True to enable, false to disable.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:EnableMotion)

---

### PhysObj:GetAABB · Shared
`PhysObj:GetAABB() → Vector|nil, Vector`

Returns the mins and max of the physics object Axis-Aligned Bounding Box.

**Returns:**
- Vector|nil — The minimum extents of the bounding box, or `nil` for runtime generated physics object.
- Vector — The maximum extents of the bounding box.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetAABB)

---

### PhysObj:GetAngles · Shared
`PhysObj:GetAngles() → Angle`

Returns the angles of the physics object in degrees.

**Returns:**
- Angle — The angles of the physics object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetAngles)

---

### PhysObj:GetAngleVelocity · Shared
`PhysObj:GetAngleVelocity() → Vector`

Gets the angular velocity of the object in degrees per second as a local vector. You can use dot product to read the magnitude from a specific axis.

**Returns:**
- Vector — The angular velocity

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetAngleVelocity)

---

### PhysObj:GetBuoyancyRatio · Shared
`PhysObj:GetBuoyancyRatio() → number`

Returns the buoyancy ratio of the physics object. (How well it floats in water).

**Returns:**
- `buoyancy` (number) — Buoyancy ratio, where 0 is not buoyant at all (like a rock), and 1 is very buoyant (like wood)

> **Note:** This feature is not available on x86-64 beta and on MacOS version of the game.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetBuoyancyRatio)

---

### PhysObj:GetContents · Shared
`PhysObj:GetContents() → number`

Returns the contents flag of the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj).

**Returns:**
- number — The CONTENTS.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetContents)

---

### PhysObj:GetDamping · Shared
`PhysObj:GetDamping() → number, number`

Returns the linear and angular damping of the physics object.

**Returns:**
- number — The linear damping
- number — The angular damping

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetDamping)

---

### PhysObj:GetEnergy · Shared
`PhysObj:GetEnergy() → number`

Returns the sum of the linear and rotational kinetic energies of the physics object.

**Returns:**
- number — The kinetic energy

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetEnergy)

---

### PhysObj:GetEntity · Shared
`PhysObj:GetEntity() → Entity`

Returns the parent entity of the physics object.

**Returns:**
- Entity — The entity this physics object belongs to

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetEntity)

---

### PhysObj:GetFrictionSnapshot · Server
`PhysObj:GetFrictionSnapshot() → table`

Returns the friction snapshot of this physics object. This is useful for determining if an object touching ground for example.

**Returns:**
- table — A table of tables containing the following data: * PhysObj Other - The other physics object we came in contact with * number EnergyAbsorbed - * number FrictionCoefficient - * number NormalForce - * Vector Normal - Direction of the friction event * Vector ContactPoint - Contact point of the friction event * number Material - Surface Property ID of our physics obj * number MaterialOther - Surface P…

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetFrictionSnapshot)

---

### PhysObj:GetIndex · Shared
`PhysObj:GetIndex() → number`

Returns the index this physics object is on its [PhysObj:GetEntity](https://wiki.facepunch.com/gmod/PhysObj:GetEntity).

Useful for [Entity:TranslateBoneToPhysBone](https://wiki.facepunch.com/gmod/Entity:TranslateBoneToPhysBone).

**Returns:**
- number — The physics object index on its parent entity.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetIndex)

---

### PhysObj:GetInertia · Shared
`PhysObj:GetInertia() → Vector`

Returns the principal moments of inertia `(Ixx, Iyy, Izz)` of the physics object, in the local frame, with respect to the center of mass.

**Returns:**
- `angularInertia` (Vector) — The moment of inertia in `kg * m^2`

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetInertia)

---

### PhysObj:GetInvInertia · Shared
`PhysObj:GetInvInertia() → Vector`

Returns 1 divided by the angular inertia. See [PhysObj:GetInertia](https://wiki.facepunch.com/gmod/PhysObj:GetInertia)

**Returns:**
- `invAngularInertia` (Vector) — The inverted angular inertia

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetInvInertia)

---

### PhysObj:GetInvMass · Shared
`PhysObj:GetInvMass() → number`

Returns 1 divided by the physics object's mass (in kilograms).

**Returns:**
- number — The inverted mass.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetInvMass)

---

### PhysObj:GetMass · Shared
`PhysObj:GetMass() → number`

Returns the mass of the physics object.

**Returns:**
- number — The mass in kilograms.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetMass)

---

### PhysObj:GetMassCenter · Shared
`PhysObj:GetMassCenter() → Vector`

Returns the center of mass of the physics object as a local vector.

**Returns:**
- Vector — The center of mass of the physics object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetMassCenter)

---

### PhysObj:GetMaterial · Shared
`PhysObj:GetMaterial() → string`

Returns the [physical material](https://developer.valvesoftware.com/wiki/Material_surface_properties) ($surfaceprop) of the physics object.

See [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) for a function that adds these types as well as further explanation of what they are.

**Returns:**
- string — The physical material name.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetMaterial)

---

### PhysObj:GetMesh · Shared
`PhysObj:GetMesh() → table`

Returns the physics mesh of the object which is used for physobj-on-physobj collision.

**Returns:**
- table — Table of Structures/MeshVertexs where each three vertices represent a triangle.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetMesh)

---

### PhysObj:GetMeshConvexes · Shared
`PhysObj:GetMeshConvexes() → table`

Returns all convex physics meshes of the object. See [Entity:PhysicsInitMultiConvex](https://wiki.facepunch.com/gmod/Entity:PhysicsInitMultiConvex) for more information.

**Returns:**
- table — Table of Structures/MeshVertexs where each Structures/MeshVertex is an independent convex mesh and each three vertices represent a triangle.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetMeshConvexes)

---

### PhysObj:GetName · Shared
`PhysObj:GetName() → string`

Returns the name of the physics object.

**Returns:**
- string — The name of the physics object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetName)

---

### PhysObj:GetPos · Shared
`PhysObj:GetPos() → Vector`

Returns the position of the physics object.

**Returns:**
- Vector — The position in world coordinates.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetPos)

---

### PhysObj:GetPositionMatrix · Shared
`PhysObj:GetPositionMatrix() → VMatrix`

Returns the position and angle of the physics object as a 3x4 matrix ([VMatrix](https://wiki.facepunch.com/gmod/VMatrix) is 4x4 so the fourth row goes unused). The first three columns store the angle as a [rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix), and the fourth column stores the position vector.

**Returns:**
- VMatrix — The position and angle matrix.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetPositionMatrix)

---

### PhysObj:GetRotDamping · Shared
`PhysObj:GetRotDamping() → number`

Returns the rotation damping of the physics object.

**Returns:**
- number — The rotation damping

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetRotDamping)

---

### PhysObj:GetShadowAngles · Shared
`PhysObj:GetShadowAngles() → Angle`

Returns the angles of the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) shadow. See [PhysObj:UpdateShadow](https://wiki.facepunch.com/gmod/PhysObj:UpdateShadow).

**Returns:**
- Angle — The angles of the PhysObj shadow.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetShadowAngles)

---

### PhysObj:GetShadowPos · Shared
`PhysObj:GetShadowPos() → Vector`

Returns the position of the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) shadow. See [PhysObj:UpdateShadow](https://wiki.facepunch.com/gmod/PhysObj:UpdateShadow).

**Returns:**
- Vector — The position of the PhysObj shadow.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetShadowPos)

---

### PhysObj:GetSpeedDamping · Shared
`PhysObj:GetSpeedDamping() → number`

Returns the speed damping of the physics object.

**Returns:**
- number — speedDamping

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetSpeedDamping)

---

### PhysObj:GetStress · Server
`PhysObj:GetStress() → number, number`

Returns the internal and external stress of the entity.

**Returns:**
- number — The external stress (`𝜎𝑒`).
- number — The internal stress (`𝜎𝑖`).

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetStress)

---

### PhysObj:GetSurfaceArea · Shared
`PhysObj:GetSurfaceArea() → number|nil`

Returns the surface area of the physics object in source-units². Or nil if the PhysObj is a generated sphere or box.

**Returns:**
- number|nil — The surface area or `nil` if the PhysObj is a generated sphere or box.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetSurfaceArea)

---

### PhysObj:GetVelocity · Shared
`PhysObj:GetVelocity() → Vector`

Returns the absolute directional velocity of the physobject.

**Returns:**
- Vector — velocity

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetVelocity)

---

### PhysObj:GetVelocityAtPoint · Shared
`PhysObj:GetVelocityAtPoint(point: Vector) → Vector`

Returns the world velocity of a point in world coordinates about the object. This is useful for objects rotating around their own axis/origin.

**Arguments:**
- `point` (Vector) — A point to test in world space coordinates

**Returns:**
- `velocity` (Vector) — Velocity at the given point

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetVelocityAtPoint)

---

### PhysObj:GetVolume · Shared
`PhysObj:GetVolume() → number|nil`

Returns the volume in source units³. Or nil if the PhysObj is a generated sphere or box.

**Returns:**
- number|nil — The volume or `nil` if the PhysObj is a generated sphere or box.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:GetVolume)

---

### PhysObj:HasGameFlag · Shared
`PhysObj:HasGameFlag(flags: number) → boolean`

Returns whenever the specified flag(s) is/are set.

**Arguments:**
- `flags` (number, enum [FVPHYSICS](https://wiki.facepunch.com/gmod/Enums/FVPHYSICS)) — Bitflag, see FVPHYSICS.

**Returns:**
- boolean — If flag was set or not

[wiki](https://wiki.facepunch.com/gmod/PhysObj:HasGameFlag)

---

### PhysObj:IsAsleep · Shared
`PhysObj:IsAsleep() → boolean`

Returns whether the physics object is "sleeping".

See [PhysObj:Sleep](https://wiki.facepunch.com/gmod/PhysObj:Sleep) for more information.

**Returns:**
- boolean — Whether the physics object is sleeping.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsAsleep)

---

### PhysObj:IsCollisionEnabled · Shared
`PhysObj:IsCollisionEnabled() → boolean`

Returns whenever the entity is able to collide or not.

**Returns:**
- boolean — isCollisionEnabled

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsCollisionEnabled)

---

### PhysObj:IsDragEnabled · Shared
`PhysObj:IsDragEnabled() → boolean`

Returns whenever the entity is affected by drag.

**Returns:**
- boolean — dragEnabled

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsDragEnabled)

---

### PhysObj:IsGravityEnabled · Shared
`PhysObj:IsGravityEnabled() → boolean`

Returns whenever the entity is affected by gravity.

**Returns:**
- boolean — `true` if the gravity is enabled, `false` otherwise

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsGravityEnabled)

---

### PhysObj:IsMotionEnabled · Shared
`PhysObj:IsMotionEnabled() → boolean`

Returns if the physics object can move itself (by velocity, acceleration)

**Returns:**
- boolean — `true` if the motion is enabled, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsMotionEnabled)

---

### PhysObj:IsMoveable · Shared
`PhysObj:IsMoveable() → boolean`

Returns whenever the entity is able to move.

**Returns:**
- boolean — movable

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsMoveable)

---

### PhysObj:IsPenetrating · Shared
`PhysObj:IsPenetrating() → boolean`

Returns whenever the physics object is penetrating another physics object.

This is internally implemented as `PhysObj:HasGameFlag( FVPHYSICS_PENETRATING )` and thus is only updated for non-static physics objects.

**Returns:**
- boolean — Whether the physics object is penetrating another object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsPenetrating)

---

### PhysObj:IsValid · Shared
`PhysObj:IsValid() → boolean`

Returns if the physics object is valid/not NULL.

**Returns:**
- boolean — Whether the physics object is valid or not.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:IsValid)

---

### PhysObj:LocalToWorld · Shared
`PhysObj:LocalToWorld(vecLocal: Vector) → Vector`

Translates a vector in the physics object's local space into worldspace coordinates.

**Arguments:**
- `vecLocal` (Vector) — A vector in the physics object's local space.

**Returns:**
- Vector — The corresponding worldspace vector.

> **Note:** Internally transforms the vector by the [PhysObj:GetPositionMatrix](https://wiki.facepunch.com/gmod/PhysObj:GetPositionMatrix).
> 
> So in GLua it approximates to:
> ```lua
> local matrixWorldTransform = PhysObj:GetPositionMatrix()
> local vecWorldspaced = Vector()
> vecWorldspaced:Set( vecLocal )
> vecWorldspaced:Mul( matrixWorldTransform )
> 
> return vecWorldspaced
> ```

[wiki](https://wiki.facepunch.com/gmod/PhysObj:LocalToWorld)

---

### PhysObj:LocalToWorldVector · Shared
`PhysObj:LocalToWorldVector(vecLocal: Vector) → Vector`

Rotationally transforms a vector in the physics object's local space by the [PhysObj:GetPositionMatrix](https://wiki.facepunch.com/gmod/PhysObj:GetPositionMatrix).

**Arguments:**
- `vecLocal` (Vector) — A vector in the physics object's local space.

**Returns:**
- Vector — The resulting vector from the rotational transformation.

> **Note:** In contrast to [PhysObj:LocalToWorld](https://wiki.facepunch.com/gmod/PhysObj:LocalToWorld), this function doesn't translate the vector.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:LocalToWorldVector)

---

### PhysObj:OutputDebugInfo · Shared
`PhysObj:OutputDebugInfo()`

Prints debug info about the state of the physics object to the console.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:OutputDebugInfo)

---

### PhysObj:RecheckCollisionFilter · Shared
`PhysObj:RecheckCollisionFilter()`

Call this when the collision filter conditions change due to this object's state (e.g. changing solid type or collision group)

[wiki](https://wiki.facepunch.com/gmod/PhysObj:RecheckCollisionFilter)

---

### PhysObj:RotateAroundAxis · Shared
`PhysObj:RotateAroundAxis(dir: Vector, ang: number) → Angle`

A convinience function for [Angle:RotateAroundAxis](https://wiki.facepunch.com/gmod/Angle:RotateAroundAxis).

**Arguments:**
- `dir` (Vector) — Direction, around which we will rotate
- `ang` (number) — Amount of rotation, in degrees

**Returns:**
- Angle — The resulting angle

[wiki](https://wiki.facepunch.com/gmod/PhysObj:RotateAroundAxis)

---

### PhysObj:SetAngleDragCoefficient · Shared
`PhysObj:SetAngleDragCoefficient(coefficient: number)`

Sets the amount of [drag](https://en.wikipedia.org/wiki/Drag_(physics)) to apply to a physics object when attempting to rotate.

**Arguments:**
- `coefficient` (number) — Drag coefficient.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetAngleDragCoefficient)

---

### PhysObj:SetAngles · Shared
`PhysObj:SetAngles(angles: Angle)`

Sets the angles of the physobject in degrees.

**Arguments:**
- `angles` (Angle) — The new angles of the physobject.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetAngles)

---

### PhysObj:SetAngleVelocity · Shared
`PhysObj:SetAngleVelocity(angularVelocity: Vector)`

Sets the specified [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)

**Arguments:**
- `angularVelocity` (Vector) — The new velocity in `degrees/s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetAngleVelocity)

---

### PhysObj:SetAngleVelocityInstantaneous · Shared
`PhysObj:SetAngleVelocityInstantaneous(angularVelocity: Vector)`

Sets the specified instantaneous [angular velocity](https://en.wikipedia.org/wiki/Angular_velocity) on the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj)

**Arguments:**
- `angularVelocity` (Vector) — The new velocity to set velocity.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetAngleVelocityInstantaneous)

---

### PhysObj:SetBuoyancyRatio · Shared
`PhysObj:SetBuoyancyRatio(buoyancy: number)`

Sets the buoyancy ratio of the physics object. (How well it floats in water)

**Arguments:**
- `buoyancy` (number) — Buoyancy ratio, where 0 is not buoyant at all (like a rock), and 1 is very buoyant (like wood).

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetBuoyancyRatio)

---

### PhysObj:SetContents · Shared
`PhysObj:SetContents(contents: number{CONTENTS})`

Sets the contents flag of the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj).

**Arguments:**
- `contents` (number{CONTENTS}) — The CONTENTS.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetContents)

---

### PhysObj:SetDamping · Shared
`PhysObj:SetDamping(linearDamping: number, angularDamping: number)`

Sets the linear and angular damping of the physics object.

**Arguments:**
- `linearDamping` (number) — Linear damping.
- `angularDamping` (number) — Angular damping.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetDamping)

---

### PhysObj:SetDragCoefficient · Shared
`PhysObj:SetDragCoefficient(drag: number)`

Modifies how much drag (air resistance) affects the object.

**Arguments:**
- `drag` (number) — The drag coefficient It can be positive or negative.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetDragCoefficient)

---

### PhysObj:SetInertia · Shared
`PhysObj:SetInertia(angularInertia: Vector)`

Sets the angular inertia. See [PhysObj:GetInertia](https://wiki.facepunch.com/gmod/PhysObj:GetInertia).

**Arguments:**
- `angularInertia` (Vector) — The angular inertia of the object.

> **Note:** This does not affect linear inertia.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetInertia)

---

### PhysObj:SetMass · Shared
`PhysObj:SetMass(mass: number)`

Sets the mass of the physics object.

**Arguments:**
- `mass` (number) — The mass in kilograms, in range `[0, 50000]`

> **Warning:** This resets [PhysObj:SetBuoyancyRatio](https://wiki.facepunch.com/gmod/PhysObj:SetBuoyancyRatio) (Recalculated based materials' and the physics objects' densities, latter of which is dependent on mass).
> 
> If you used a custom ratio, you will have to re-set it again after `SetMass`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetMass)

---

### PhysObj:SetMaterial · Shared
`PhysObj:SetMaterial(materialName: string)`

Sets the material of the physobject.

**Arguments:**
- `materialName` (string) — The name of the phys material to use.

> **Note:** Impact sounds will only change if this is called on client

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetMaterial)

---

### PhysObj:SetPos · Shared
`PhysObj:SetPos(position: Vector, teleport: boolean = false)`

Sets the position of the physobject.

**Arguments:**
- `position` (Vector) — The new position of the physobject in world coordinates.
- `teleport` (boolean, default `false`) — If `true`, temporarily disables collisions of the physics objects just before moving it, then enables collisions back again.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetPos)

---

### PhysObj:SetVelocity · Shared
`PhysObj:SetVelocity(velocity: Vector)`

Sets the velocity of the physics object for the next iteration.

**Arguments:**
- `velocity` (Vector) — The new velocity of the physics object in `source_unit/s`.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetVelocity)

---

### PhysObj:SetVelocityInstantaneous · Shared
`PhysObj:SetVelocityInstantaneous(velocity: Vector)`

Sets the velocity of the physics object.

**Arguments:**
- `velocity` (Vector) — The new velocity of the physics object.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:SetVelocityInstantaneous)

---

### PhysObj:Sleep · Shared
`PhysObj:Sleep()`

Makes the physics object "sleep". The physics object will no longer be moving unless it is "woken up" by either a collision with another moving object, or by [PhysObj:Wake](https://wiki.facepunch.com/gmod/PhysObj:Wake). 

This is an optimization feature of the physics engine. Normally physics objects will automatically "sleep" when not moving for a short while, to save resources, but it can be used for other purposes, for example to temporarily suspend an object mid air.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:Sleep)

---

### PhysObj:UpdateShadow · Shared
`PhysObj:UpdateShadow(targetPosition: Vector, targetAngles: Angle, frameTime: number)`

Unlike [PhysObj:SetPos](https://wiki.facepunch.com/gmod/PhysObj:SetPos) and [PhysObj:SetAngles](https://wiki.facepunch.com/gmod/PhysObj:SetAngles), this allows the movement of a physobj while leaving physics interactions intact.
This is used internally by the motion controller of the Gravity Gun , the +use pickup and the Physics Gun, and entities such as the crane.

**Arguments:**
- `targetPosition` (Vector) — The position we should move to.
- `targetAngles` (Angle) — The angle we should rotate towards.
- `frameTime` (number) — The frame time to use for this movement, can be generally filled with FrameTime or ENTITY:PhysicsSimulate with the deltaTime.

> **Note:** This is the ideal function to move a physics shadow created with [Entity:PhysicsInitShadow](https://wiki.facepunch.com/gmod/Entity:PhysicsInitShadow) or [Entity:MakePhysicsObjectAShadow](https://wiki.facepunch.com/gmod/Entity:MakePhysicsObjectAShadow).

[wiki](https://wiki.facepunch.com/gmod/PhysObj:UpdateShadow)

---

### PhysObj:Wake · Shared
`PhysObj:Wake()`

Wakes the physics object, so that it will continue to simulate physics/gravity.

See [PhysObj:Sleep](https://wiki.facepunch.com/gmod/PhysObj:Sleep) for more information.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:Wake)

---

### PhysObj:WorldToLocal · Shared
`PhysObj:WorldToLocal(vec: Vector) → Vector`

Translates a worldspace vector into the physics object's local space.

**Arguments:**
- `vec` (Vector) — A worldspace vector.

**Returns:**
- Vector — The corresponding local space vector.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:WorldToLocal)

---

### PhysObj:WorldToLocalVector · Shared
`PhysObj:WorldToLocalVector(vec: Vector) → Vector`

Rotationally transforms a worldspace vector into the physics object's local space by the inverted [PhysObj:GetPositionMatrix](https://wiki.facepunch.com/gmod/PhysObj:GetPositionMatrix).

For example, in GMod this is used in thrusters, for working out linear force for local acceleration.

**Arguments:**
- `vec` (Vector) — A worldspace vector.

**Returns:**
- Vector — The resulting vector from the rotational transformation.

> **Note:** In contrast to [PhysObj:WorldToLocal](https://wiki.facepunch.com/gmod/PhysObj:WorldToLocal), this function doesn't translate the vector.

[wiki](https://wiki.facepunch.com/gmod/PhysObj:WorldToLocalVector)
