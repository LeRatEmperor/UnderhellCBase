# MATERIAL enumeration

**Realm:** Client  ·  **Constants:** 8

Enumerations used by [mesh.Begin](https://wiki.facepunch.com/gmod/mesh.Begin) to control what type of vertex information it should expect. Clientside only.

		For more information, see the [Mesh Primitives](https://wiki.facepunch.com/gmod/mesh_primitives) reference page.

[wiki page](https://wiki.facepunch.com/gmod/Enums/MATERIAL)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MATERIAL_LINE_LOOP` | `5` | Client | For more information, see Line Loop Primitives |
| `MATERIAL_LINE_STRIP` | `4` | Client | For more information, see Line Strip Primitives |
| `MATERIAL_LINES` | `1` | Client | For more information, see Line Primitives |
| `MATERIAL_POINTS` | `0` | Client | For more information, see Point Primitives |
| `MATERIAL_POLYGON` | `6` | Client | Creates a set of triangles that all share a single vertex and each share a vertex with the previous triangle. |
| `MATERIAL_QUADS` | `7` | Client | Creates pairs of triangles that share two vertices. |
| `MATERIAL_TRIANGLE_STRIP` | `3` | Client | Creates a set of triangles that each share two vertices with the previous triangle in the sequence. |
| `MATERIAL_TRIANGLES` | `2` | Client | Creates triangles from groupings of 3 vertices. |
