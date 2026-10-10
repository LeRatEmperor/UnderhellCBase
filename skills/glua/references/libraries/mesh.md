# mesh

**Realm:** Client  ·  **Members:** 15

The mesh library allows you to create meshes. A mesh is a set of vertices that define a 3D shape, for constant meshes you should use the [IMesh](https://wiki.facepunch.com/gmod/IMesh) object instead.

[wiki page](https://wiki.facepunch.com/gmod/mesh)

### mesh.AdvanceVertex · Client
`mesh.AdvanceVertex()`

Pushes the currently set vertex data (via other `mesh.*` functions) into the mesh stack. See example on [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

[wiki](https://wiki.facepunch.com/gmod/mesh.AdvanceVertex)

---

### mesh.Begin · Client
`mesh.Begin(mesh: IMesh, primitiveType: number, primitiveCount: number, primitiveType: number, primitiveCount: number)`

Begins creating or modifying a 3D mesh constructed from a given quantity and type of primitive 3D shapes such as triangles and quads.

		The resulting mesh can be stored in an [IMesh](https://wiki.facepunch.com/gmod/IMesh) if it is intended to be drawn multiple times or on multiple frames.

**Arguments:**
- `mesh` (IMesh) — The IMesh that the created mesh will be stored in.
- `primitiveType` (number, enum [MATERIAL](https://wiki.facepunch.com/gmod/Enums/MATERIAL)) — An enum that indicates what the format of the mesh's primitives will be.
- `primitiveCount` (number, enum [MATERIAL](https://wiki.facepunch.com/gmod/Enums/MATERIAL)) — The quantity of primitives this mesh will contain as a whole integer number.
- `primitiveType` (number, enum [MATERIAL](https://wiki.facepunch.com/gmod/Enums/MATERIAL)) — An enum that indicates what the format of the mesh's primitives will be.
- `primitiveCount` (number, enum [MATERIAL](https://wiki.facepunch.com/gmod/Enums/MATERIAL)) — The quantity of primitives this mesh will contain as a whole integer number.

[wiki](https://wiki.facepunch.com/gmod/mesh.Begin)

---

### mesh.BoneData · Client · `NEW`
`mesh.BoneData(index: number, matrixId: number, weight: number)`

Sets the bone matrix ID and bone weight to be used for the next vertex. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `index` (number) — The slot index for the vertex, either 0 or 1.
- `matrixId` (number) — The matrix index for the vertex, in the range of 0 -> 52.
- `weight` (number) — How much influence that matrix will have on this vertex, in the range of 0 -> 1.

[wiki](https://wiki.facepunch.com/gmod/mesh.BoneData)

---

### mesh.Color · Client
`mesh.Color(r: number, g: number, b: number, a: number)`

Sets the color to be used for the next vertex. This is `COLOR0` semantic of 
Vertex Shader. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `r` (number) — Red component.
- `g` (number) — Green component.
- `b` (number) — Blue component.
- `a` (number) — Alpha component.

[wiki](https://wiki.facepunch.com/gmod/mesh.Color)

---

### mesh.End · Client
`mesh.End()`

Ends the mesh (Started with [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin)) and renders it.

[wiki](https://wiki.facepunch.com/gmod/mesh.End)

---

### mesh.Normal · Client
`mesh.Normal(normal: Vector, x: number, y: number, z: number)`

Sets the normal to be used for the next vertex. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `normal` (Vector) — The normal of the vertex.
- `x` (number) — The X part of the vertex normal.
- `y` (number) — The Y part of the vertex normal.
- `z` (number) — The Z part of the vertex normal.

[wiki](https://wiki.facepunch.com/gmod/mesh.Normal)

---

### mesh.Position · Client
`mesh.Position(position: Vector, x: number, y: number, z: number)`

Sets the position to be used for the next vertex. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `position` (Vector) — The position of the vertex.
- `x` (number) — The X position of the vertex.
- `y` (number) — The Y position of the vertex.
- `z` (number) — The Z position of the vertex.

[wiki](https://wiki.facepunch.com/gmod/mesh.Position)

---

### mesh.Quad · Client
`mesh.Quad(vertex1: Vector, vertex2: Vector, vertex3: Vector, vertex4: Vector, color: Color)`

Adds a quad (4 vertices) to the currently built mesh. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `vertex1` (Vector) — The first vertex.
- `vertex2` (Vector) — The second vertex.
- `vertex3` (Vector) — The third vertex.
- `vertex4` (Vector) — The fourth vertex.
- `color` (Color) — The Color for the vertices.

[wiki](https://wiki.facepunch.com/gmod/mesh.Quad)

---

### mesh.QuadEasy · Client
`mesh.QuadEasy(position: Vector, normal: Vector, sizeX: number, sizeY: number, color: Color)`

Adds a quad (4 vertices) to the currently built mesh, by using position, normal and sizes. See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

See also [mesh.Quad](https://wiki.facepunch.com/gmod/mesh.Quad).

**Arguments:**
- `position` (Vector) — The center of the quad.
- `normal` (Vector) — The normal of the quad.
- `sizeX` (number) — X size in pixels.
- `sizeY` (number) — Y size in pixels.
- `color` (Color) — The Color for the vertices.

[wiki](https://wiki.facepunch.com/gmod/mesh.QuadEasy)

---

### mesh.Specular · Client
`mesh.Specular(r: number, g: number, b: number, a: number)`

Sets the specular map values. This is `COLOR1` semantic of Vertex Shader. Allows to blend textures of [Lightmapped_4WayBlend](https://developer.valvesoftware.com/wiki/Lightmapped_4WayBlend). Requires the `VERTEX_SPECULAR` flag to be set in the C++ code of a shader.

**Arguments:**
- `r` (number) — The red channel multiplier of the specular map.
- `g` (number) — The green channel multiplier of the specular map.
- `b` (number) — The blue channel multiplier of the specular map.
- `a` (number) — The alpha channel multiplier of the specular map.

[wiki](https://wiki.facepunch.com/gmod/mesh.Specular)

---

### mesh.TangentS · Client
`mesh.TangentS(tangentS: Vector, x: number, y: number, z: number)`

Sets the `S` tangent to be used, also known as "binormal".

Tangents and binormals are using in bumpmap rendering.

See also [mesh.TangentT](https://wiki.facepunch.com/gmod/mesh.TangentT) and [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `tangentS` (Vector) — The S tangent.
- `x` (number) — The X part of the vertex' tangent S.
- `y` (number) — The Y part of the vertex' tangent S.
- `z` (number) — The Z part of the vertex' tangent S.

[wiki](https://wiki.facepunch.com/gmod/mesh.TangentS)

---

### mesh.TangentT · Client
`mesh.TangentT(tangentT: Vector, x: number, y: number, z: number)`

Sets the `T` tangent to be used.

Tangents and binormals are using in bumpmap rendering.

See also [mesh.TangentS](https://wiki.facepunch.com/gmod/mesh.TangentS) and [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin).

**Arguments:**
- `tangentT` (Vector) — The T tangent.
- `x` (number) — The X part of the vertex' tangent T.
- `y` (number) — The Y part of the vertex' tangent T.
- `z` (number) — The Z part of the vertex' tangent T.

[wiki](https://wiki.facepunch.com/gmod/mesh.TangentT)

---

### mesh.TexCoord · Client
`mesh.TexCoord(set: number, s: number, t: number, u: number = nil, v: number = nil)`

Sets the texture coordinates for the next vertex for the current mesh. (See [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin))

**Arguments:**
- `set` (number) — The texture coordinate set, 0 to 7.
- `s` (number) — S coordinate.
- `t` (number) — T coordinate.
- `u` (number, default `nil`) — U coordinate.
- `v` (number, default `nil`) — V coordinate.

[wiki](https://wiki.facepunch.com/gmod/mesh.TexCoord)

---

### mesh.UserData · Client
`mesh.UserData(tangentX: number, tangentY: number, tangentZ: number, tangentHandedness: number)`

A set of four numbers that can be used for arbitrary purposes by [Material](https://wiki.facepunch.com/gmod/Material) shaders.  
		This is most commonly used to provide tangent information about each vertex to the Material's shader.

**Arguments:**
- `tangentX` (number)
- `tangentY` (number)
- `tangentZ` (number)
- `tangentHandedness` (number)

[wiki](https://wiki.facepunch.com/gmod/mesh.UserData)

---

### mesh.VertexCount · Client
`mesh.VertexCount() → number`

Returns the amount of vertices that have been pushed via [mesh.AdvanceVertex](https://wiki.facepunch.com/gmod/mesh.AdvanceVertex).

**Returns:**
- number — The amount of vertices.

[wiki](https://wiki.facepunch.com/gmod/mesh.VertexCount)
