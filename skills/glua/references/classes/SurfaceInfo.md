# SurfaceInfo

**Realm:** Shared  ·  **Members:** 5

A brush surface object returned by [Entity:GetBrushSurfaces](https://wiki.facepunch.com/gmod/Entity:GetBrushSurfaces).

Brush surfaces are a part of what makes up the map geometry aside from displacements. Any primitive brush model, including most breakable windows, can be represented by this object.

> **Note:** This object internally uses the `SurfaceHandle_t` class, which is an alias for `msurface2_t*`.

[wiki page](https://wiki.facepunch.com/gmod/SurfaceInfo)

### SurfaceInfo:GetMaterial · Shared
`SurfaceInfo:GetMaterial() → IMaterial`

Returns the brush surface's material.

**Returns:**
- IMaterial — Material of one portion of a brush model.

[wiki](https://wiki.facepunch.com/gmod/SurfaceInfo:GetMaterial)

---

### SurfaceInfo:GetVertices · Shared
`SurfaceInfo:GetVertices() → table<Vector>`

Returns a list of vertices the brush surface is built from.

**Returns:**
- table<Vector> — A list of Vector points.

[wiki](https://wiki.facepunch.com/gmod/SurfaceInfo:GetVertices)

---

### SurfaceInfo:IsNoDraw · Shared
`SurfaceInfo:IsNoDraw() → boolean`

Checks if the brush surface is a nodraw surface, meaning it will not be drawn by the engine.

**Returns:**
- boolean — Returns true if this surface won't be drawn.

> **Note:** This internally checks the SURFDRAW_NODRAW flag.

[wiki](https://wiki.facepunch.com/gmod/SurfaceInfo:IsNoDraw)

---

### SurfaceInfo:IsSky · Shared
`SurfaceInfo:IsSky() → boolean`

Checks if the brush surface is displaying the skybox.

**Returns:**
- boolean — Returns true if the surface is the sky.

> **Note:** This internally checks the SURFDRAW_SKY flag.

[wiki](https://wiki.facepunch.com/gmod/SurfaceInfo:IsSky)

---

### SurfaceInfo:IsWater · Shared
`SurfaceInfo:IsWater() → boolean`

Checks if the brush surface is water.

**Returns:**
- boolean — Returns true if the surface is water.

> **Note:** This internally checks the SURFDRAW_WATER flag.

[wiki](https://wiki.facepunch.com/gmod/SurfaceInfo:IsWater)
