# CEffectData

**Realm:** Shared  ·  **Members:** 32

List of all possible functions available for effect data. This is the object returned by the [EffectData](https://wiki.facepunch.com/gmod/Global.EffectData) function and is required for [util.Effect](https://wiki.facepunch.com/gmod/util.Effect) function.

[wiki page](https://wiki.facepunch.com/gmod/CEffectData)

### CEffectData:GetAngles · Shared
`CEffectData:GetAngles() → Angle`

Returns the angles of the effect.

**Returns:**
- Angle — The angles of the effect

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetAngles)

---

### CEffectData:GetAttachment · Shared
`CEffectData:GetAttachment() → number`

Returns the attachment ID for the effect.

**Returns:**
- number — The attachment ID of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetAttachment)

---

### CEffectData:GetColor · Shared
`CEffectData:GetColor() → number`

Returns byte which represents the color of the effect.

**Returns:**
- number — The color of the effect

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetColor)

---

### CEffectData:GetDamageType · Shared
`CEffectData:GetDamageType() → number`

Returns the damage type of the effect

**Returns:**
- number — Damage type of the effect, see DMG

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetDamageType)

---

### CEffectData:GetEntIndex · Server
`CEffectData:GetEntIndex() → number`

Returns the entity index of the entity set for the effect.

**Returns:**
- number — The entity index of the entity set for the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetEntIndex)

---

### CEffectData:GetEntity · Shared
`CEffectData:GetEntity() → Entity`

Returns the entity assigned to the effect.

**Returns:**
- Entity — The entity assigned to the effect

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetEntity)

---

### CEffectData:GetFlags · Shared
`CEffectData:GetFlags() → number`

Returns the flags of the effect.

**Returns:**
- number — The flags of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetFlags)

---

### CEffectData:GetHitBox · Shared
`CEffectData:GetHitBox() → number`

Returns the hit box ID of the effect.

**Returns:**
- number — The hit box ID of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetHitBox)

---

### CEffectData:GetMagnitude · Shared
`CEffectData:GetMagnitude() → number`

Returns the magnitude of the effect.

**Returns:**
- number — The magnitude of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetMagnitude)

---

### CEffectData:GetMaterialIndex · Shared
`CEffectData:GetMaterialIndex() → number`

Returns the material ID of the effect.

**Returns:**
- number — The material ID of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetMaterialIndex)

---

### CEffectData:GetNormal · Shared
`CEffectData:GetNormal() → Vector`

Returns the normalized direction vector of the effect.

**Returns:**
- Vector — The normalized direction vector of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetNormal)

---

### CEffectData:GetOrigin · Shared
`CEffectData:GetOrigin() → Vector`

Returns the origin position of the effect.

**Returns:**
- Vector — The origin position of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetOrigin)

---

### CEffectData:GetRadius · Shared
`CEffectData:GetRadius() → number`

Returns the radius of the effect.

**Returns:**
- number — The radius of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetRadius)

---

### CEffectData:GetScale · Shared
`CEffectData:GetScale() → number`

Returns the scale of the effect.

**Returns:**
- number — The scale of the effect

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetScale)

---

### CEffectData:GetStart · Shared
`CEffectData:GetStart() → Vector`

Returns the start position of the effect.

**Returns:**
- Vector — The start position of the effect

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetStart)

---

### CEffectData:GetSurfaceProp · Shared
`CEffectData:GetSurfaceProp() → number`

Returns the surface property index of the effect. See [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) for more details about what they are.

See [CEffectData:SetSurfaceProp](https://wiki.facepunch.com/gmod/CEffectData:SetSurfaceProp) for details about limitations of this function.

**Returns:**
- number — The surface property index of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:GetSurfaceProp)

---

### CEffectData:SetAngles · Shared
`CEffectData:SetAngles(ang: Angle)`

Sets the angles of the effect.

**Arguments:**
- `ang` (Angle) — The new angles to be set.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetAngles)

---

### CEffectData:SetAttachment · Shared
`CEffectData:SetAttachment(attachment: number)`

Sets the attachment id of the effect to be created with this effect data.

**Arguments:**
- `attachment` (number) — New attachment ID of the effect.

> **Note:** This is internally stored as an integer, but only the first 5 bits will be networked, effectively limiting this function to 0-31 range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetAttachment)

---

### CEffectData:SetColor · Shared
`CEffectData:SetColor(color: number)`

Sets the "color" of the effect.

All this does is provide an addition 8 bits of data for the effect to use. What this will actually do will vary from effect to effect, depending on how a specific effect uses this given data, if at all.

**Arguments:**
- `color` (number) — Color represented by a byte.

> **Note:** Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to 0-255 range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetColor)

---

### CEffectData:SetDamageType · Shared
`CEffectData:SetDamageType(damageType: number)`

Sets the damage type of the effect to be created with this effect data.

**Arguments:**
- `damageType` (number, enum [DMG](https://wiki.facepunch.com/gmod/Enums/DMG)) — Damage type, see DMG.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetDamageType)

---

### CEffectData:SetEntIndex · Server
`CEffectData:SetEntIndex(entIndex: number)`

Sets the entity of the effect via its index.

**Arguments:**
- `entIndex` (number) — The entity index to be set.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetEntIndex)

---

### CEffectData:SetEntity · Shared
`CEffectData:SetEntity(entity: Entity)`

Sets the entity of the effect to be created with this effect data.

**Arguments:**
- `entity` (Entity) — Entity of the effect, mostly used for parenting.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetEntity)

---

### CEffectData:SetFlags · Shared
`CEffectData:SetFlags(flags: number)`

Sets the flags for the effect. What flags do depends entirely on the effect. See [Default Effects](https://wiki.facepunch.com/gmod/Default%20Effects).

**Arguments:**
- `flags` (number) — The flags of the effect.

> **Note:** Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `0-255` range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetFlags)

---

### CEffectData:SetHitBox · Shared
`CEffectData:SetHitBox(hitBoxIndex: number)`

Sets the hit box index of the effect. Used by various effects for various purposes.

**Arguments:**
- `hitBoxIndex` (number) — The hit box index of the effect, for example from Structures/TraceResult#HitBox

> **Note:** Internally stored as an integer, but only first 11 bits are networked, effectively limiting this function to 0-2047 range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetHitBox)

---

### CEffectData:SetMagnitude · Shared
`CEffectData:SetMagnitude(magnitude: number)`

Sets the magnitude of the effect.

**Arguments:**
- `magnitude` (number) — The magnitude of the effect.

> **Note:** Internally stored as a float with 12 bit precision for networking purposes, limited to range of 0-1023.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetMagnitude)

---

### CEffectData:SetMaterialIndex · Shared
`CEffectData:SetMaterialIndex(materialIndex: number)`

Sets the material index of the effect.

**Arguments:**
- `materialIndex` (number) — The material index of the effect.

> **Note:** Internally stored as an integer, but only first 12 bits are networked, effectively limiting this function to 0-4095 range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetMaterialIndex)

---

### CEffectData:SetNormal · Shared
`CEffectData:SetNormal(normal: Vector)`

Sets the normalized (length=1) direction vector of the effect to be created with this effect data. This **must** be a normalized vector for networking purposes.

**Arguments:**
- `normal` (Vector) — The normalized direction vector of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetNormal)

---

### CEffectData:SetOrigin · Shared
`CEffectData:SetOrigin(origin: Vector)`

Sets the origin of the effect to be created with this effect data.

**Arguments:**
- `origin` (Vector) — Origin of the effect.

> **Note:** Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetOrigin)

---

### CEffectData:SetRadius · Shared
`CEffectData:SetRadius(radius: number)`

Sets the radius of the effect to be created with this effect data.

**Arguments:**
- `radius` (number) — Radius of the effect.

> **Note:** Internally stored as a float, but networked as a 10bit float, and is clamped to 0-1023 range.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetRadius)

---

### CEffectData:SetScale · Shared
`CEffectData:SetScale(scale: number)`

Sets the scale of the effect to be created with this effect data.

**Arguments:**
- `scale` (number) — Scale of the effect.

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetScale)

---

### CEffectData:SetStart · Shared
`CEffectData:SetStart(start: Vector)`

Sets the start of the effect to be created with this effect data.

**Arguments:**
- `start` (Vector) — Start of the effect.

> **Note:** Limited to world bounds (+-16386 on every axis) and has horrible networking precision. (17 bit float per component)

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetStart)

---

### CEffectData:SetSurfaceProp · Shared
`CEffectData:SetSurfaceProp(surfaceProperties: number)`

Sets the surface property index of the effect. See [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) for more details about what they are.

**Arguments:**
- `surfaceProperties` (number) — The surface property index of the effect.

> **Note:** Internally stored as an integer, but only first 8 bits are networked, effectively limiting this function to `-1`-`254` range. (Yes, that's not a mistake, `-1` signifying an invalid value.)

[wiki](https://wiki.facepunch.com/gmod/CEffectData:SetSurfaceProp)
