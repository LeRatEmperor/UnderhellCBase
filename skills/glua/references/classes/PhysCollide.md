# PhysCollide

**Realm:** Shared  ·  **Members:** 3

A PhysCollide holds collision data from VPhysics. These objects can be used to run (currently quite limited) collision tests, but do not represent actual physics objects.

Created by [CreatePhysCollideBox](https://wiki.facepunch.com/gmod/Global.CreatePhysCollideBox) or [CreatePhysCollidesFromModel](https://wiki.facepunch.com/gmod/Global.CreatePhysCollidesFromModel).

[wiki page](https://wiki.facepunch.com/gmod/PhysCollide)

### PhysCollide:Destroy · Shared
`PhysCollide:Destroy()`

Destroys the [PhysCollide](https://wiki.facepunch.com/gmod/PhysCollide) object.

[wiki](https://wiki.facepunch.com/gmod/PhysCollide:Destroy)

---

### PhysCollide:IsValid · Shared
`PhysCollide:IsValid() → boolean`

Checks whether this [PhysCollide](https://wiki.facepunch.com/gmod/PhysCollide) object is valid or not.

You should just use [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid) instead.

**Returns:**
- boolean — Is valid or not.

[wiki](https://wiki.facepunch.com/gmod/PhysCollide:IsValid)

---

### PhysCollide:TraceBox · Shared
`PhysCollide:TraceBox(origin: Vector, angles: Angle, rayStart: Vector, rayEnd: Vector, rayMins: Vector, rayMaxs: Vector) → Vector, Vector, number`

Performs a trace against this PhysCollide with the given parameters. This can be used for both line traces and box traces.

**Arguments:**
- `origin` (Vector) — The origin for the PhysCollide during the trace
- `angles` (Angle) — The angles for the PhysCollide during the trace
- `rayStart` (Vector) — The start position of the trace
- `rayEnd` (Vector) — The end position of the trace
- `rayMins` (Vector) — The mins of the trace's bounds
- `rayMaxs` (Vector) — The maxs of the trace's bounds

**Returns:**
- Vector — Hit position of the trace.
- Vector — Hit normal of the trace
- number — Fraction of the trace.

[wiki](https://wiki.facepunch.com/gmod/PhysCollide:TraceBox)
