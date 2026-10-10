# IMesh

**Realm:** Client  ·  **Members:** 5

Renderable mesh object, can be used to create models on the fly. 
		The only way to create your own IMesh object is to call [Mesh](https://wiki.facepunch.com/gmod/Global.Mesh).

> **Note:** IMeshes only respond to one projected texture.  
> 			See the [render.RenderFlashlights](https://wiki.facepunch.com/gmod/render.RenderFlashlights) function and example that solves this problem.

[wiki page](https://wiki.facepunch.com/gmod/IMesh)

### IMesh:BuildFromTriangles · Client
`IMesh:BuildFromTriangles(vertexes: table)`

Builds the mesh from a table mesh vertexes.

When modifying a previously built mesh, your new mesh must match the vertex count!

See [Mesh](https://wiki.facepunch.com/gmod/Global.Mesh) and [util.GetModelMeshes](https://wiki.facepunch.com/gmod/util.GetModelMeshes) for examples.

**Arguments:**
- `vertexes` (table) — A table consisting of Structures/MeshVertexs.

> **Warning:** [IMesh](https://wiki.facepunch.com/gmod/IMesh) appears to have a limit of 65535 vertices. You should split your mesh into multiple meshes when above this limit. 
> 
> Exceeding the limit may lead to undefined rendering behavior.

[wiki](https://wiki.facepunch.com/gmod/IMesh:BuildFromTriangles)

---

### IMesh:Destroy · Client
`IMesh:Destroy()`

Deletes the mesh and frees the memory used by it.

[wiki](https://wiki.facepunch.com/gmod/IMesh:Destroy)

---

### IMesh:Draw · Client
`IMesh:Draw()`

Renders the mesh with the active matrix.

[wiki](https://wiki.facepunch.com/gmod/IMesh:Draw)

---

### IMesh:DrawSkinned · Client · `NEW`
`IMesh:DrawSkinned(bones: table<VMatrix>, multiply: boolean = false)`

Renders the mesh with the active matrix and given bone matrices.

**Arguments:**
- `bones` (table<VMatrix>) — A list of matrices to use as bones.
- `multiply` (boolean, default `false`) — If set, multiplies given matrices with currently active model matrix (cam.GetModelMatrix).

[wiki](https://wiki.facepunch.com/gmod/IMesh:DrawSkinned)

---

### IMesh:IsValid · Client
`IMesh:IsValid() → boolean`

Returns whether this [IMesh](https://wiki.facepunch.com/gmod/IMesh) is valid or not.

**Returns:**
- boolean — Whether this IMesh is valid or not.

[wiki](https://wiki.facepunch.com/gmod/IMesh:IsValid)
