# CLuaParticle

**Realm:** Client  ·  **Members:** 44

List of all possible functions available for Lua particles. This is the object returned by the [CLuaEmitter:Add](https://wiki.facepunch.com/gmod/CLuaEmitter:Add) function.

[wiki page](https://wiki.facepunch.com/gmod/CLuaParticle)

### CLuaParticle:GetAirResistance · Client
`CLuaParticle:GetAirResistance() → number`

Returns the air resistance of the particle.

**Returns:**
- number — The air resistance of the particle

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetAirResistance)

---

### CLuaParticle:GetAngles · Client
`CLuaParticle:GetAngles() → Angle`

Returns the current orientation of the particle.

**Returns:**
- Angle — The angles of the particle

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetAngles)

---

### CLuaParticle:GetAngleVelocity · Client
`CLuaParticle:GetAngleVelocity() → Angle`

Returns the angular velocity of the particle

**Returns:**
- Angle — The angular velocity of the particle

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetAngleVelocity)

---

### CLuaParticle:GetBounce · Client
`CLuaParticle:GetBounce() → number`

Returns the 'bounciness' of the particle.

**Returns:**
- number — The 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetBounce)

---

### CLuaParticle:GetColor · Client
`CLuaParticle:GetColor() → number, number, number`

Returns the color of the particle.

**Returns:**
- number — Red part of the color
- number — Green part of the color
- number — Blue part of the color

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetColor)

---

### CLuaParticle:GetDieTime · Client
`CLuaParticle:GetDieTime() → number`

Returns the amount of time in seconds after which the particle will be destroyed.

**Returns:**
- number — The amount of time in seconds after which the particle will be destroyed

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetDieTime)

---

### CLuaParticle:GetEndAlpha · Client
`CLuaParticle:GetEndAlpha() → number`

Returns the alpha value that the particle will reach on its death.

**Returns:**
- number — The alpha value the particle will fade to

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetEndAlpha)

---

### CLuaParticle:GetEndLength · Client
`CLuaParticle:GetEndLength() → number`

Returns the length that the particle will reach on its death.

**Returns:**
- number — The length the particle will reach

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetEndLength)

---

### CLuaParticle:GetEndSize · Client
`CLuaParticle:GetEndSize() → number`

Returns the size that the particle will reach on its death.

**Returns:**
- number — The size the particle will reach

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetEndSize)

---

### CLuaParticle:GetGravity · Client
`CLuaParticle:GetGravity() → Vector`

Returns the gravity of the particle.

**Returns:**
- Vector — The gravity of the particle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetGravity)

---

### CLuaParticle:GetLifeTime · Client
`CLuaParticle:GetLifeTime() → number`

Returns the 'life time' of the particle, how long the particle existed since its creation.

This value will always be between 0 and [CLuaParticle:GetDieTime](https://wiki.facepunch.com/gmod/CLuaParticle:GetDieTime).

It changes automatically as time goes.

It can be manipulated using [CLuaParticle:SetLifeTime](https://wiki.facepunch.com/gmod/CLuaParticle:SetLifeTime).

If the life time of the particle will be more than [CLuaParticle:GetDieTime](https://wiki.facepunch.com/gmod/CLuaParticle:GetDieTime), it will be removed.

**Returns:**
- number — How long the particle existed, in seconds.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetLifeTime)

---

### CLuaParticle:GetMaterial · Client
`CLuaParticle:GetMaterial() → IMaterial`

Returns the current material of the particle.

**Returns:**
- `mat` (IMaterial) — The material.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetMaterial)

---

### CLuaParticle:GetPos · Client
`CLuaParticle:GetPos() → Vector`

Returns the absolute position of the particle.

**Returns:**
- Vector — The absolute position of the particle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetPos)

---

### CLuaParticle:GetRoll · Client
`CLuaParticle:GetRoll() → number`

Returns the current rotation of the particle in radians, this should only be used for 2D particles.

**Returns:**
- number — The current rotation of the particle in radians

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetRoll)

---

### CLuaParticle:GetRollDelta · Client
`CLuaParticle:GetRollDelta() → number`

Returns the current rotation speed of the particle in radians, this should only be used for 2D particles.

**Returns:**
- number — The current rotation speed of the particle in radians

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetRollDelta)

---

### CLuaParticle:GetStartAlpha · Client
`CLuaParticle:GetStartAlpha() → number`

Returns the alpha value which the particle has when it's created.

**Returns:**
- number — The alpha value which the particle has when it's created.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetStartAlpha)

---

### CLuaParticle:GetStartLength · Client
`CLuaParticle:GetStartLength() → number`

Returns the length which the particle has when it's created.

**Returns:**
- number — The length which the particle has when it's created.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetStartLength)

---

### CLuaParticle:GetStartSize · Client
`CLuaParticle:GetStartSize() → number`

Returns the size which the particle has when it's created.

**Returns:**
- number — The size which the particle has when it's created.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetStartSize)

---

### CLuaParticle:GetVelocity · Client
`CLuaParticle:GetVelocity() → Vector`

Returns the current velocity of the particle.

**Returns:**
- Vector — The current velocity of the particle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:GetVelocity)

---

### CLuaParticle:SetAirResistance · Client
`CLuaParticle:SetAirResistance(airResistance: number)`

Sets the air resistance of the the particle.

**Arguments:**
- `airResistance` (number) — New air resistance.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetAirResistance)

---

### CLuaParticle:SetAngles · Client
`CLuaParticle:SetAngles(ang: Angle)`

Sets the angles of the particle.

**Arguments:**
- `ang` (Angle) — New angle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetAngles)

---

### CLuaParticle:SetAngleVelocity · Client
`CLuaParticle:SetAngleVelocity(angVel: Angle)`

Sets the angular velocity of the the particle.

**Arguments:**
- `angVel` (Angle) — New angular velocity.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetAngleVelocity)

---

### CLuaParticle:SetBounce · Client
`CLuaParticle:SetBounce(bounce: number)`

Sets the 'bounciness' of the the particle.

**Arguments:**
- `bounce` (number) — New 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetBounce)

---

### CLuaParticle:SetCollide · Client
`CLuaParticle:SetCollide(shouldCollide: boolean)`

Sets the whether the particle should collide with the world or not.

**Arguments:**
- `shouldCollide` (boolean) — Whether the particle should collide with the world or not

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetCollide)

---

### CLuaParticle:SetCollideCallback · Client
`CLuaParticle:SetCollideCallback(collideFunc: function)`

Sets the function that gets called whenever the particle collides with the world.

**Arguments:**
- `collideFunc` (function) — The collision callback.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetCollideCallback)

---

### CLuaParticle:SetColor · Client
`CLuaParticle:SetColor(r: number, g: number, b: number)`

Sets the color of the particle.

**Arguments:**
- `r` (number) — The red component.
- `g` (number) — The green component.
- `b` (number) — The blue component.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetColor)

---

### CLuaParticle:SetDieTime · Client
`CLuaParticle:SetDieTime(dieTime: number)`

Sets the time where the particle will be removed.

**Arguments:**
- `dieTime` (number) — The new die time.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetDieTime)

---

### CLuaParticle:SetEndAlpha · Client
`CLuaParticle:SetEndAlpha(endAlpha: number)`

Sets the alpha value of the particle that it will reach when it dies.

**Arguments:**
- `endAlpha` (number) — The new alpha value of the particle that it will reach when it dies.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetEndAlpha)

---

### CLuaParticle:SetEndLength · Client
`CLuaParticle:SetEndLength(endLength: number)`

Sets the length of the particle that it will reach when it dies.

**Arguments:**
- `endLength` (number) — The new length of the particle that it will reach when it dies.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetEndLength)

---

### CLuaParticle:SetEndSize · Client
`CLuaParticle:SetEndSize(endSize: number)`

Sets the size of the particle that it will reach when it dies.

**Arguments:**
- `endSize` (number) — The new size of the particle that it will reach when it dies.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetEndSize)

---

### CLuaParticle:SetGravity · Client
`CLuaParticle:SetGravity(gravity: Vector)`

Sets the directional gravity aka. acceleration of the particle.

**Arguments:**
- `gravity` (Vector) — The directional gravity.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetGravity)

---

### CLuaParticle:SetLifeTime · Client
`CLuaParticle:SetLifeTime(lifeTime: number)`

Sets the 'life time' of the particle, how long the particle existed since its creation.

This value should always be between 0 and [CLuaParticle:GetDieTime](https://wiki.facepunch.com/gmod/CLuaParticle:GetDieTime).

It changes automatically as time goes.

If the life time of the particle will be more than [CLuaParticle:GetDieTime](https://wiki.facepunch.com/gmod/CLuaParticle:GetDieTime), it will be removed.

**Arguments:**
- `lifeTime` (number) — The new life time of the particle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetLifeTime)

---

### CLuaParticle:SetLighting · Client
`CLuaParticle:SetLighting(useLighting: boolean)`

Sets whether the particle should be affected by lighting.

**Arguments:**
- `useLighting` (boolean) — Whether the particle should be affected by lighting.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetLighting)

---

### CLuaParticle:SetMaterial · Client
`CLuaParticle:SetMaterial(mat: IMaterial)`

Sets the material of the particle.

**Arguments:**
- `mat` (IMaterial) — The new material to set.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetMaterial)

---

### CLuaParticle:SetNextThink · Client
`CLuaParticle:SetNextThink(nextThink: number)`

Sets when the particles think function should be called next, this uses the synchronized server time returned by [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime).

**Arguments:**
- `nextThink` (number) — Next think time.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetNextThink)

---

### CLuaParticle:SetPos · Client
`CLuaParticle:SetPos(pos: Vector)`

Sets the absolute position of the particle.

**Arguments:**
- `pos` (Vector) — The new particle position.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetPos)

---

### CLuaParticle:SetRoll · Client
`CLuaParticle:SetRoll(roll: number)`

Sets the roll of the particle in radians. This should only be used for 2D particles.

**Arguments:**
- `roll` (number) — The new rotation of the particle in radians.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetRoll)

---

### CLuaParticle:SetRollDelta · Client
`CLuaParticle:SetRollDelta(rollDelta: number)`

Sets the rotation speed of the particle in radians. This should only be used for 2D particles.

**Arguments:**
- `rollDelta` (number) — The new rotation speed of the particle in radians.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetRollDelta)

---

### CLuaParticle:SetStartAlpha · Client
`CLuaParticle:SetStartAlpha(startAlpha: number)`

Sets the initial alpha value of the particle.

**Arguments:**
- `startAlpha` (number) — Initial alpha.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetStartAlpha)

---

### CLuaParticle:SetStartLength · Client
`CLuaParticle:SetStartLength(startLength: number)`

Sets the initial length value of the particle.

**Arguments:**
- `startLength` (number) — Initial length.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetStartLength)

---

### CLuaParticle:SetStartSize · Client
`CLuaParticle:SetStartSize(startSize: number)`

Sets the initial size value of the particle.

**Arguments:**
- `startSize` (number) — Initial size.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetStartSize)

---

### CLuaParticle:SetThinkFunction · Client
`CLuaParticle:SetThinkFunction(thinkFunc: function)`

Sets the think function of the particle.

**Arguments:**
- `thinkFunc` (function) — Think function.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetThinkFunction)

---

### CLuaParticle:SetVelocity · Client
`CLuaParticle:SetVelocity(vel: Vector)`

Sets the velocity of the particle.

**Arguments:**
- `vel` (Vector) — The new velocity of the particle.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetVelocity)

---

### CLuaParticle:SetVelocityScale · Client
`CLuaParticle:SetVelocityScale(doScale: boolean = false)`

Automatically scales the length of the particle based on the particle speed, multiplied with [CLuaParticle:SetStartLength](https://wiki.facepunch.com/gmod/CLuaParticle:SetStartLength) and [CLuaParticle:SetEndLength](https://wiki.facepunch.com/gmod/CLuaParticle:SetEndLength). Width remains the same as [CLuaParticle:SetStartSize](https://wiki.facepunch.com/gmod/CLuaParticle:SetStartSize) and [CLuaParticle:SetEndSize](https://wiki.facepunch.com/gmod/CLuaParticle:SetEndSize).

**Arguments:**
- `doScale` (boolean, default `false`) — Use velocity scaling.

[wiki](https://wiki.facepunch.com/gmod/CLuaParticle:SetVelocityScale)
