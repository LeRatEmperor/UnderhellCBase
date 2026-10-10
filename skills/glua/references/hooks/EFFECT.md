# EFFECT

**Realm:** Client  ·  **Members:** 8

These hooks are used inside of a Lua effect. Lua effects are stored in either the `/lua/effects` directory or in a gamemode in `/gamemodes/

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `EFFECT` table: `function EFFECT:<Name>(...) end`. The `EFFECT:` prefix shown on each member below is the method form you write.

### EFFECT:EndTouch · Client · `hook`
`EFFECT:EndTouch()`

Effect alternative to [ENTITY:EndTouch](https://wiki.facepunch.com/gmod/ENTITY:EndTouch).

[wiki](https://wiki.facepunch.com/gmod/EFFECT:EndTouch)

---

### EFFECT:GetTracerShootPos · Client · `hook`
`EFFECT:GetTracerShootPos(pos: Vector, ent: Weapon, attachment: number) → Vector`

Used to get the "real" start position of a trace, for weapon tracer effects.

"real" meaning in 3rd person, the 3rd person position will be used, in first person the first person position will be used.

**Arguments:**
- `pos` (Vector) — Default position if we fail
- `ent` (Weapon) — The weapon to use.
- `attachment` (number) — Attachment ID of on the weapon "muzzle", to use as the start position.

**Returns:**
- Vector — The "real" start position.

[wiki](https://wiki.facepunch.com/gmod/EFFECT:GetTracerShootPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/base.lua#L5)

---

### EFFECT:Init · Client · `hook`
`EFFECT:Init(effectData: CEffectData)`

Called when the effect is created.

**Arguments:**
- `effectData` (CEffectData) — The effect data used to create the effect.

[wiki](https://wiki.facepunch.com/gmod/EFFECT:Init)

---

### EFFECT:PhysicsCollide · Client · `hook`
`EFFECT:PhysicsCollide(colData: table, collider: PhysObj)`

Called when the effect collides with anything.

**Arguments:**
- `colData` (table) — Information regarding the collision.
- `collider` (PhysObj) — The physics object of the entity that collided with the effect.

[wiki](https://wiki.facepunch.com/gmod/EFFECT:PhysicsCollide)

---

### EFFECT:Render · Client · `hook`
`EFFECT:Render()`

Called when the effect should be rendered. 

	When not overridden, it will perform default action, which is [Entity:DrawModel](https://wiki.facepunch.com/gmod/Entity:DrawModel).

[wiki](https://wiki.facepunch.com/gmod/EFFECT:Render)

---

### EFFECT:StartTouch · Client · `hook`
`EFFECT:StartTouch()`

Effect alternative to [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch).

[wiki](https://wiki.facepunch.com/gmod/EFFECT:StartTouch)

---

### EFFECT:Think · Client · `hook`
`EFFECT:Think() → boolean`

Called when the effect should think, return false to kill the effect.

**Returns:**
- boolean — Return false to remove this effect.

[wiki](https://wiki.facepunch.com/gmod/EFFECT:Think)

---

### EFFECT:Touch · Client · `hook`
`EFFECT:Touch()`

Effect alternative to [ENTITY:Touch](https://wiki.facepunch.com/gmod/ENTITY:Touch).

[wiki](https://wiki.facepunch.com/gmod/EFFECT:Touch)
