# motionsensor

**Realm:** Shared, Menu  ·  **Members:** 11

Functions related to Kinect for Windows usage in GMod.

> **Warning:** Kinect feature works only on 32-bit version of the game.

[wiki page](https://wiki.facepunch.com/gmod/motionsensor)

### motionsensor.BuildSkeleton · Shared · `INTERNAL`
`motionsensor.BuildSkeleton(translator: table, player: Player, rotation: Angle) → Vector, Angle, table`

Called to build the skeleton. See [Using The Kinect](https://wiki.facepunch.com/gmod/Using%20The%20Kinect) and [Kinect developing](https://wiki.facepunch.com/gmod/Kinect%20developing).

**Arguments:**
- `translator` (table) — `list.Get( "SkeletonConvertor" )` and motionsensor.ChooseBuilderFromEntity.
- `player` (Player) — The player to get motion sensor positions from.
- `rotation` (Angle) — Global rotation of the player?

**Returns:**
- Vector — Position
- Angle — Angles
- table — Sensor

[wiki](https://wiki.facepunch.com/gmod/motionsensor.BuildSkeleton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/motionsensor.lua#L221-L260)

---

### motionsensor.ChooseBuilderFromEntity · Shared
`motionsensor.ChooseBuilderFromEntity(ent: Entity) → string`

**Arguments:**
- `ent` (Entity) — Entity to choose builder for

**Returns:**
- string — Chosen builder.

[wiki](https://wiki.facepunch.com/gmod/motionsensor.ChooseBuilderFromEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/motionsensor.lua#L46-L58)

---

### motionsensor.GetColourMaterial · Client, Menu
`motionsensor.GetColourMaterial() → IMaterial`

Returns the depth map material.

**Returns:**
- IMaterial — The material

[wiki](https://wiki.facepunch.com/gmod/motionsensor.GetColourMaterial)

---

### motionsensor.GetSkeleton · Client
`motionsensor.GetSkeleton() → table`

Returns players skeletal data if they are using Kinect. See [Using The Kinect](https://wiki.facepunch.com/gmod/Using%20The%20Kinect) and [Kinect developing](https://wiki.facepunch.com/gmod/Kinect%20developing).

**Returns:**
- table — The skeleton data.

[wiki](https://wiki.facepunch.com/gmod/motionsensor.GetSkeleton)

---

### motionsensor.IsActive · Client
`motionsensor.IsActive() → boolean`

Return whether a kinect is connected - and active (ie - Start has been called).

**Returns:**
- boolean — Connected and active or not

[wiki](https://wiki.facepunch.com/gmod/motionsensor.IsActive)

---

### motionsensor.IsAvailable · Client, Menu
`motionsensor.IsAvailable() → boolean`

Returns true if we have detected that there's a kinect connected to the PC

**Returns:**
- boolean — Connected or not

[wiki](https://wiki.facepunch.com/gmod/motionsensor.IsAvailable)

---

### motionsensor.ProcessAngle · Shared · `INTERNAL`
`motionsensor.ProcessAngle(translator: table, sensor: table, pos: Vector, ang: Angle, special_vectors: table, boneid: number, v: table) → boolean`

Used internally by [motionsensor.ProcessAnglesTable](https://wiki.facepunch.com/gmod/motionsensor.ProcessAnglesTable). See [Using The Kinect](https://wiki.facepunch.com/gmod/Using%20The%20Kinect) and [Kinect developing](https://wiki.facepunch.com/gmod/Kinect%20developing).

**Arguments:**
- `translator` (table)
- `sensor` (table)
- `pos` (Vector)
- `ang` (Angle)
- `special_vectors` (table)
- `boneid` (number)
- `v` (table)

**Returns:**
- boolean — Return nil on failure

[wiki](https://wiki.facepunch.com/gmod/motionsensor.ProcessAngle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/motionsensor.lua#L60-L121)

---

### motionsensor.ProcessAnglesTable · Shared · `INTERNAL`
`motionsensor.ProcessAnglesTable(translator: table, sensor: table, pos: Vector, rotation: Angle) → table`

Used internally by [motionsensor.BuildSkeleton](https://wiki.facepunch.com/gmod/motionsensor.BuildSkeleton). See [Using The Kinect](https://wiki.facepunch.com/gmod/Using%20The%20Kinect) and [Kinect developing](https://wiki.facepunch.com/gmod/Kinect%20developing).

**Arguments:**
- `translator` (table)
- `sensor` (table)
- `pos` (Vector)
- `rotation` (Angle)

**Returns:**
- table — Ang.

[wiki](https://wiki.facepunch.com/gmod/motionsensor.ProcessAnglesTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/motionsensor.lua#L126-L190)

---

### motionsensor.ProcessPositionTable · Shared · `INTERNAL`
`motionsensor.ProcessPositionTable(translator: table, sensor: table) → table`

Used internally by [motionsensor.BuildSkeleton](https://wiki.facepunch.com/gmod/motionsensor.BuildSkeleton). See [Using The Kinect](https://wiki.facepunch.com/gmod/Using%20The%20Kinect) and [Kinect developing](https://wiki.facepunch.com/gmod/Kinect%20developing).

**Arguments:**
- `translator` (table)
- `sensor` (table)

**Returns:**
- table — Positions.

[wiki](https://wiki.facepunch.com/gmod/motionsensor.ProcessPositionTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/motionsensor.lua#L195-L216)

---

### motionsensor.Start · Client, Menu
`motionsensor.Start() → boolean`

This starts access to the kinect sensor. Note that this usually freezes the game for a couple of seconds.

**Returns:**
- boolean — `true` if the access has been started

[wiki](https://wiki.facepunch.com/gmod/motionsensor.Start)

---

### motionsensor.Stop · Client
`motionsensor.Stop()`

Stops the motion capture.

[wiki](https://wiki.facepunch.com/gmod/motionsensor.Stop)
