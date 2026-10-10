# CLuaEmitter

**Realm:** Client  ·  **Members:** 12

List of all possible functions available for LuaEmitters. This is the object returned by the [ParticleEmitter](https://wiki.facepunch.com/gmod/Global.ParticleEmitter) function.

[wiki page](https://wiki.facepunch.com/gmod/CLuaEmitter)

### CLuaEmitter:Add · Client
`CLuaEmitter:Add(material: string, position: Vector) → CLuaParticle`

Creates a new [CLuaParticle](https://wiki.facepunch.com/gmod/CLuaParticle) with the given material and position.

**Arguments:**
- `material` (string) — The particles material.
- `position` (Vector) — The position to spawn the particle on.

**Returns:**
- CLuaParticle — The created particle, if any.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:Add)

---

### CLuaEmitter:Draw · Client
`CLuaEmitter:Draw()`

Manually renders all particles the emitter has created.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:Draw)

---

### CLuaEmitter:Finish · Client
`CLuaEmitter:Finish()`

Removes the emitter, making it no longer usable from Lua. If particles remain, the emitter will be removed when all particles die.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:Finish)

---

### CLuaEmitter:GetNumActiveParticles · Client
`CLuaEmitter:GetNumActiveParticles() → number`

Returns the amount of active particles of this emitter.

**Returns:**
- number — The amount of active particles of this emitter

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:GetNumActiveParticles)

---

### CLuaEmitter:GetPos · Client
`CLuaEmitter:GetPos() → Vector`

Returns the position of this emitter. This is set when creating the emitter with [ParticleEmitter](https://wiki.facepunch.com/gmod/Global.ParticleEmitter).

**Returns:**
- Vector — Position of this particle emitter.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:GetPos)

---

### CLuaEmitter:Is3D · Client
`CLuaEmitter:Is3D() → boolean`

Returns whether this emitter is 3D or not. This is set when creating the emitter with [ParticleEmitter](https://wiki.facepunch.com/gmod/Global.ParticleEmitter).

**Returns:**
- boolean — Whether this emitter is 3D or not.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:Is3D)

---

### CLuaEmitter:IsValid · Client
`CLuaEmitter:IsValid() → boolean`

Returns whether this [CLuaEmitter](https://wiki.facepunch.com/gmod/CLuaEmitter) is valid or not.

**Returns:**
- boolean — Whether this CLuaEmitter is valid or not.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:IsValid)

---

### CLuaEmitter:SetBBox · Client
`CLuaEmitter:SetBBox(mins: Vector, maxs: Vector)`

Sets the bounding box for this emitter.

Usually the bounding box is automatically determined by the particles, but this function overrides it.

**Arguments:**
- `mins` (Vector) — The minimum position of the box
- `maxs` (Vector) — The maximum position of the box

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:SetBBox)

---

### CLuaEmitter:SetNearClip · Client
`CLuaEmitter:SetNearClip(distanceMin: number, distanceMax: number)`

This function sets the the distance between the render camera and the emitter at which the particles should start fading and at which distance fade ends ( alpha becomes 0 ).

**Arguments:**
- `distanceMin` (number) — Min distance where the alpha becomes 0.
- `distanceMax` (number) — Max distance where the alpha starts fading.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:SetNearClip)

---

### CLuaEmitter:SetNoDraw · Client
`CLuaEmitter:SetNoDraw(noDraw: boolean)`

Prevents all particles of the emitter from automatically drawing.

**Arguments:**
- `noDraw` (boolean) — Whether we should draw the particles ( false ) or not ( true )

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:SetNoDraw)

---

### CLuaEmitter:SetParticleCullRadius · Client
`CLuaEmitter:SetParticleCullRadius(radius: number)`

The function name has not much in common with its actual function, it applies a radius to every particles that affects the building of the bounding box, as it, usually is constructed by the particle that has the lowest x, y and z and the highest x, y and z, this function just adds/subtracts the radius and inflates the bounding box.

**Arguments:**
- `radius` (number) — Particle radius.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:SetParticleCullRadius)

---

### CLuaEmitter:SetPos · Client
`CLuaEmitter:SetPos(position: Vector)`

Sets the position of the particle emitter.

**Arguments:**
- `position` (Vector) — New position.

[wiki](https://wiki.facepunch.com/gmod/CLuaEmitter:SetPos)
