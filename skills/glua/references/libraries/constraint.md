# constraint

**Realm:** Server  ·  **Members:** 29

The constraint library allows you to control the constraint system built into the physics engine (rope, weld, ballsockets, etc).

[wiki page](https://wiki.facepunch.com/gmod/constraint)

### constraint.AddConstraintTable · Server · `INTERNAL`
`constraint.AddConstraintTable(ent1: Entity, constrt: Entity, ent2: Entity = nil, ent3: Entity = nil, ent4: Entity = nil)`

Stores the constraint entity in the constrained entity's `Constraints` table.

This will make the `constrt` entity be removed if any of the other entities `ent1`, `ent2`, `ent3` or `ent4` are removed by any means.  
To prevent this, [constraint.AddConstraintTableNoDelete](https://wiki.facepunch.com/gmod/constraint.AddConstraintTableNoDelete) can be used instead.

**Arguments:**
- `ent1` (Entity) — The entity to store the information on.
- `constrt` (Entity) — The constraint to store in the entity's table.
- `ent2` (Entity, default `nil`) — Optional.
- `ent3` (Entity, default `nil`) — Optional.
- `ent4` (Entity, default `nil`) — Optional.

[wiki](https://wiki.facepunch.com/gmod/constraint.AddConstraintTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L344-L360)

---

### constraint.AddConstraintTableNoDelete · Server · `INTERNAL`
`constraint.AddConstraintTableNoDelete(ent1: Entity, constrt: Entity, ent2: Entity = nil, ent3: Entity = nil, ent4: Entity = nil)`

Stores info about the constraints on the entity's table.

The only difference between this and [constraint.AddConstraintTable](https://wiki.facepunch.com/gmod/constraint.AddConstraintTable) is that the constraint does not get deleted when any of the constrained entities are removed.

**Arguments:**
- `ent1` (Entity) — The entity to store the information on.
- `constrt` (Entity) — The constraint to store in the entity's table.
- `ent2` (Entity, default `nil`) — Optional.
- `ent3` (Entity, default `nil`) — Optional.
- `ent4` (Entity, default `nil`) — Optional.

[wiki](https://wiki.facepunch.com/gmod/constraint.AddConstraintTableNoDelete) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L366-L381)

---

### constraint.AdvBallsocket · Server
`constraint.AdvBallsocket(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector = nil, forceLimit: number = 0, torqueLimit: number = 0, xMin: number, yMin: number, zMin: number, xMax: number, yMax: number, zMax: number, xFric: number = 0, yFric: number = 0, zFric: number = 0, onlyRotation: number = 0, noCollide: number = 0) → Entity`

Creates an advanced ballsocket (ragdoll) constraint. See [constraint.Ballsocket](https://wiki.facepunch.com/gmod/constraint.Ballsocket) for the simpler version.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector, default `nil`) — Position relative to the the second physics object to constrain to.
- `forceLimit` (number, default `0`) — Amount of force until it breaks (0 = unbreakable).
- `torqueLimit` (number, default `0`) — Amount of torque (rotation speed) until it breaks (0 = unbreakable).
- `xMin` (number) — Minimum angle in rotations around the X axis local to the constraint.
- `yMin` (number) — Minimum angle in rotations around the Y axis local to the constraint.
- `zMin` (number) — Minimum angle in rotations around the Z axis local to the constraint.
- `xMax` (number) — Maximum angle in rotations around the X axis local to the constraint.
- `yMax` (number) — Maximum angle in rotations around the Y axis local to the constraint.
- `zMax` (number) — Maximum angle in rotations around the Z axis local to the constraint.
- `xFric` (number, default `0`) — Rotational friction in the X axis local to the constraint.
- `yFric` (number, default `0`) — Rotational friction in the Y axis local to the constraint.
- `zFric` (number, default `0`) — Rotational friction in the Z axis local to the constraint.
- `onlyRotation` (number, default `0`) — Only limit rotation, free movement.
- `noCollide` (number, default `0`) — Whether the entities should be no-collided.

**Returns:**
- Entity — A phys_ragdollconstraint entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.AdvBallsocket) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L825-L893)

---

### constraint.Axis · Server
`constraint.Axis(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, forceLimit: number = 0, torqueLimit: number = 0, friction: number = 0, noCollide: number = 0, localAxis: Vector = nil, dontAddTable: boolean = false) → Entity`

Creates an axis constraint.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `forceLimit` (number, default `0`) — Amount of force until it breaks (0 = unbreakable).
- `torqueLimit` (number, default `0`) — Amount of torque (rotational force) until it breaks (0 = unbreakable).
- `friction` (number, default `0`) — Constraint friction.
- `noCollide` (number, default `0`) — Whether the entities should be no-collided.
- `localAxis` (Vector, default `nil`) — If you include the LocalAxis then LPos2 will not be used in the final constraint.
- `dontAddTable` (boolean, default `false`) — Whether or not to add the constraint info on the entity table.

**Returns:**
- Entity — The created constraint.

[wiki](https://wiki.facepunch.com/gmod/constraint.Axis) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L761-L817)

---

### constraint.Ballsocket · Server
`constraint.Ballsocket(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos: Vector, forceLimit: number = 0, torqueLimit: number = 0, nocollide: number = 0) → Entity`

Creates a ballsocket joint. See See [constraint.AdvBallsocket](https://wiki.facepunch.com/gmod/constraint.AdvBallsocket) if you also wish to limit rotation angles in some way.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos` (Vector) — Center position of the joint, relative to the second entity's physics object.
- `forceLimit` (number, default `0`) — Amount of force until it breaks (0 = unbreakable).
- `torqueLimit` (number, default `0`) — Amount of torque (rotational force) until it breaks (0 = unbreakable).
- `nocollide` (number, default `0`) — Whether the constrained entities should collided with each other or not.

**Returns:**
- Entity — The created constraint.

[wiki](https://wiki.facepunch.com/gmod/constraint.Ballsocket) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1190-L1233)

---

### constraint.CanConstrain · Server
`constraint.CanConstrain(ent: Entity, bone: number) → boolean`

Basic checks to make sure that the specified entity and bone are valid. Returns false if we should not be constraining the entity.

**Arguments:**
- `ent` (Entity) — The entity to check.
- `bone` (number) — The bone of the entity to check (use 0 for mono boned ents).

**Returns:**
- boolean — Whether a constraint can or should be created.

[wiki](https://wiki.facepunch.com/gmod/constraint.CanConstrain) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L247-L256)

---

### constraint.CreateKeyframeRope · Server
`constraint.CreateKeyframeRope(pos: Vector, width: number, material: string = nil, constraint: Entity = nil, ent1: Entity, localPos1: Vector, bone1: number, ent2: Entity, localPos2: Vector, bone2: number, keyValues: table = nil) → Entity`

Creates a rope without any constraint.

**Arguments:**
- `pos` (Vector) — Position for the rope entity.
- `width` (number) — Width of the rope.
- `material` (string, default `nil`) — Material of the rope.
- `constraint` (Entity, default `nil`) — Constraint for the rope.
- `ent1` (Entity) — First entity.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `ent2` (Entity) — Second entity.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `keyValues` (table, default `nil`) — Any additional key/values to be set on the rope.

**Returns:**
- Entity — The created rope (keyframe_rope), or `nil` or failure.

[wiki](https://wiki.facepunch.com/gmod/constraint.CreateKeyframeRope) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L293-L338)

---

### constraint.CreateStaticAnchorPoint · Server
`constraint.CreateStaticAnchorPoint(pos: Vector) → Entity, PhysObj, number, Vector`

Creates an invisible, non-moveable anchor point in the world to which things can be attached.

**Arguments:**
- `pos` (Vector) — The position to spawn the anchor at

**Returns:**
- Entity — The anchor entity.
- PhysObj — The achor entity's physics object.
- number — Always `0`.
- Vector — Always `vector_zero`.

> **Note:** The entity used internally by this function (`gmod_anchor`) only exists in Sandbox derived gamemodes, meaning this function will only work in these gamemodes.  
> 
> 		To use this in other gamemodes, you may need to create your own [gmod_anchor](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/entities/entities/gmod_anchor.lua) entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.CreateStaticAnchorPoint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L655-L666)

---

### constraint.Elastic · Server
`constraint.Elastic(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, constant: number, damping: number, relDamping: number, material: string, width: number, stretchOnly: boolean = false, color: Color = color_white) → Entity, Entity`

Creates an elastic rope constraint.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `constant` (number) — Stiffness of the elastic.
- `damping` (number) — How much energy the elastic loses.
- `relDamping` (number) — The amount of energy the elastic loses proportional to the relative velocity of the two objects the elastic is attached to.
- `material` (string) — The material of the rope.
- `width` (number) — Width of rope.
- `stretchOnly` (boolean, default `false`) — Apply physics forces only on stretch.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint.
- Entity — The created rope.

[wiki](https://wiki.facepunch.com/gmod/constraint.Elastic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L538-L603)

---

### constraint.Find · Server
`constraint.Find(ent1: Entity, ent2: Entity, type: string, bone1: number, bone2: number) → Entity`

Returns the constraint of a specified type between two entities, if it exists

**Arguments:**
- `ent1` (Entity) — The first entity to check.
- `ent2` (Entity) — The second entity to check.
- `type` (string) — The type of constraint, case sensitive.
- `bone1` (number) — The bone number for the first entity (0 for monoboned entities).
- `bone2` (number) — The bone number for the second entity.

**Returns:**
- Entity — The constraint found.

[wiki](https://wiki.facepunch.com/gmod/constraint.Find) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L219-L241)

---

### constraint.FindConstraint · Server
`constraint.FindConstraint(ent: Entity, type: string) → table`

Returns the first constraint of a specific type directly connected to the entity found.

**Arguments:**
- `ent` (Entity) — The entity to check.
- `type` (string) — The type of constraint, case sensitive.

**Returns:**
- table — The constraint table, set with constraint.AddConstraintTable

[wiki](https://wiki.facepunch.com/gmod/constraint.FindConstraint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1578-L1592)

---

### constraint.FindConstraintEntity · Server
`constraint.FindConstraintEntity(ent: Entity, type: string) → Entity`

Returns the other entity involved in the first constraint of a specific type directly connected to the entity.

**Arguments:**
- `ent` (Entity) — The entity to check.
- `type` (string) — The type of constraint, case sensitive.

**Returns:**
- Entity — The other entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.FindConstraintEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1597-L1611)

---

### constraint.FindConstraints · Server
`constraint.FindConstraints(ent: Entity, type: string) → table`

Returns a table of all constraints of a specific type directly connected to the entity.

If you are looking for a list of all constraints, use [constraint.GetTable](https://wiki.facepunch.com/gmod/constraint.GetTable).

**Arguments:**
- `ent` (Entity) — The entity to check.
- `type` (string) — The type of constraint, case sensitive.

**Returns:**
- table — All the constraints of this entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.FindConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1557-L1573)

---

### constraint.ForgetConstraints · Server
`constraint.ForgetConstraints(ent: Entity)`

Make this entity forget any constraints it knows about. Note that this will not actually remove the constraints.

**Arguments:**
- `ent` (Entity) — The entity that will forget its constraints.

[wiki](https://wiki.facepunch.com/gmod/constraint.ForgetConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1547-L1551)

---

### constraint.GetAllConstrainedEntities · Server
`constraint.GetAllConstrainedEntities(ent: Entity, resultTable: table = nil) → table`

Returns a table of all entities recursively constrained to an entity.

**Arguments:**
- `ent` (Entity) — The entity to check.
- `resultTable` (table, default `nil`) — Table used to return result.

**Returns:**
- table — A table containing all of the constrained entities.

[wiki](https://wiki.facepunch.com/gmod/constraint.GetAllConstrainedEntities) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1616-L1637)

---

### constraint.GetTable · Server
`constraint.GetTable(ent: Entity) → table`

Returns a table of all constraints directly connected to the entity.

If you are looking for a list of specific constraint(s), use [constraint.FindConstraints](https://wiki.facepunch.com/gmod/constraint.FindConstraints).

**Arguments:**
- `ent` (Entity) — The entity to check.

**Returns:**
- table — A list of all constraints connected to the entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1504-L1542)

---

### constraint.HasConstraints · Server
`constraint.HasConstraints(ent: Entity) → boolean`

Returns true if the entity has constraints attached to it

**Arguments:**
- `ent` (Entity) — The entity to check.

**Returns:**
- boolean — Whether the entity has any constraints or not.

[wiki](https://wiki.facepunch.com/gmod/constraint.HasConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1475-L1497)

---

### constraint.Hydraulic · Server
`constraint.Hydraulic(player: Player, ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, length1: number, length2: number, width: number, key: number, slider: number, speed: number, material: string, toggle: boolean = true, color: Color = color_white) → Entity, Entity, Entity, Entity`

Creates a controllable [constraint.Elastic](https://wiki.facepunch.com/gmod/constraint.Elastic), aka a Hydraulic constraint.

**Arguments:**
- `player` (Player) — The player that will be able to control the constraint.
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `length1` (number) — Minimum length of the constraint.
- `length2` (number) — Maximum length of the constraint.
- `width` (number) — The width of the rope.
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding, corresponding to an KEY.
- `slider` (number) — Whether the hydraulic is fixed, i.e.
- `speed` (number) — How fast it changes the length from `length1` to `length2` and backwards.
- `material` (string) — The material of the rope.
- `toggle` (boolean, default `true`) — Whether the hydraulic should be a toggle, not a "hold key to extend" action.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint.
- Entity — The created rope.
- Entity — The muscle controller.
- Entity — The slider (phys_slideconstraint) if `fixed` was exactly `1`.

[wiki](https://wiki.facepunch.com/gmod/constraint.Hydraulic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1312-L1388)

---

### constraint.Keepupright · Server
`constraint.Keepupright(ent: Entity, ang: Angle, bone: number, angularLimit: number) → Entity`

Creates a keep upright constraint.

**Arguments:**
- `ent` (Entity) — The entity to keep upright.
- `ang` (Angle) — The angle defined as "upright".
- `bone` (number) — The bone of the entity to constrain (0 for boneless).
- `angularLimit` (number) — Basically, the strength of the constraint.

**Returns:**
- Entity — The created constraint, if any or false if the constraint failed to set.

[wiki](https://wiki.facepunch.com/gmod/constraint.Keepupright) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L611-L651)

---

### constraint.Motor · Server
`constraint.Motor(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, friction: number, torque: number, forcetime: number, nocollide: number = 0, toggle: number = false, player: Player = NULL, forcelimit: number = 0, key_fwd: number = nil, key_bwd: number = nil, direction: number = 1, localAxis: Vector = nil) → Entity, Entity`

Creates a motor constraint, a player controllable [constraint.Axis](https://wiki.facepunch.com/gmod/constraint.Axis).

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `friction` (number) — Motor friction.
- `torque` (number) — Motor torque.
- `forcetime` (number) — Automatic shut-off after this time has passed.
- `nocollide` (number, default `0`) — Whether the entities should be no-collided.
- `toggle` (number, default `false`) — Whether the constraint is on toggle.
- `player` (Player, default `NULL`) — The player that will control the motor.
- `forcelimit` (number, default `0`) — Amount of force until it breaks (0 = unbreakable).
- `key_fwd` (number, default `nil`, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding for "forward", corresponding to an KEY.
- `key_bwd` (number, default `nil`, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding for "backwards", corresponding to an KEY.
- `direction` (number, default `1`) — Either `1` or `-1` signifying which direction the motor should spin.
- `localAxis` (Vector, default `nil`) — Overrides axis of rotation?

**Returns:**
- Entity — The created constraint.
- Entity — The created axis constraint.

[wiki](https://wiki.facepunch.com/gmod/constraint.Motor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1019-L1111)

---

### constraint.Muscle · Server
`constraint.Muscle(player: Player, ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, length1: number, length2: number, width: number, key: number, fixed: number, period: number, amplitude: number, startOn: boolean = false, material: string, color: Color = color_white) → Entity, Entity, Entity, Entity`

Creates a muscle constraint.

Very similar to [constraint.Hydraulic](https://wiki.facepunch.com/gmod/constraint.Hydraulic), but instead of a toggle between fully expanded and contracted, it will continuously alternate between the 2 states while enabled.

**Arguments:**
- `player` (Player) — The player that will be able to control the constraint.
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `length1` (number) — Minimum length of the constraint.
- `length2` (number) — Maximum length of the constraint.
- `width` (number) — Width of the rope.
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding, corresponding to an KEY.
- `fixed` (number) — Whether the constraint is fixed, i.e.
- `period` (number) — How often the "contractions" should happen.
- `amplitude` (number) — Amplification of the "contractions"?
- `startOn` (boolean, default `false`) — Whether the constraint should start activated.
- `material` (string) — Material of the rope.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint.
- Entity — The created rope.
- Entity — The muscle controller.
- Entity — The slider (phys_slideconstraint) if `fixed` was exactly `1`.

[wiki](https://wiki.facepunch.com/gmod/constraint.Muscle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1396-L1468)

---

### constraint.NoCollide · Server
`constraint.NoCollide(ent1: Entity, ent2: Entity, bone1: number, bone2: number, disableOnRemove: boolean = false) → Entity`

Creates an no-collide "constraint". Disables collision between two entities.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `disableOnRemove` (boolean, default `false`) — If set, the nocollide will be reversed if the constraint is removed.

**Returns:**
- Entity — The created constraint.

> **Note:** Does not work with players.

[wiki](https://wiki.facepunch.com/gmod/constraint.NoCollide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L901-L943)

---

### constraint.Pulley · Server
`constraint.Pulley(ent1: Entity, ent4: Entity, bone1: number, bone4: number, localPos1: Vector, localPos4: Vector, worldPos2: Vector, worldPos3: Vector, forceLimit: number, rigid: boolean = false, width: number, material: string, color: Color = color_white) → Entity, Entity, Entity, Entity`

Creates a pulley constraint.

It consists of 3 rope segments, 2 of which have variable length, visually connected by a 3rd. Reducing length of one end will increase the length of the other end.

You can visualize the pulley like so:
```lua
WPos2 --- WPos3
  |			|
  |			|
 Ent1	   Ent4
```

**Arguments:**
- `ent1` (Entity) — First entity to constrain.
- `ent4` (Entity) — The other entity to attach to.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone4` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos4` (Vector) — Position relative to the the second physics object to constrain to.
- `worldPos2` (Vector) — World position constrain the first entity to.
- `worldPos3` (Vector) — World position constrain the second entity to.
- `forceLimit` (number) — Amount of force until it breaks (0 = unbreakable).
- `rigid` (boolean, default `false`) — Whether the constraint is rigid, i.e.
- `width` (number) — Width of the rope.
- `material` (string) — Material of the rope.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint.
- Entity — The first rope segment.
- Entity — The second rope segment.
- Entity — The third rope segment.

[wiki](https://wiki.facepunch.com/gmod/constraint.Pulley) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1119-L1182)

---

### constraint.RemoveAll · Server
`constraint.RemoveAll(ent: Entity) → boolean, number`

Attempts to remove all constraints associated with an entity.

**Arguments:**
- `ent` (Entity) — The entity to remove constraints from.

**Returns:**
- boolean — Whether any constraints were removed.
- number — Number of constraints removed.

[wiki](https://wiki.facepunch.com/gmod/constraint.RemoveAll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L187-L213)

---

### constraint.RemoveConstraints · Server
`constraint.RemoveConstraints(ent: Entity, type: string) → boolean, number`

Attempts to remove all constraints of a specified type associated with an entity

**Arguments:**
- `ent` (Entity) — The entity to check.
- `type` (string) — The constraint type to remove (eg.

**Returns:**
- boolean — Whether we removed any constraints or not.
- number — The amount of constraints removed.

[wiki](https://wiki.facepunch.com/gmod/constraint.RemoveConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L144-L180)

---

### constraint.Rope · Server
`constraint.Rope(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, length: number, addLength: number = 0, forceLimit: number = 0, width: number, material: string = nil, rigid: boolean = false, color: Color = color_white) → Entity, Entity`

Creates a simple rope (length) based constraint.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `length` (number) — Length of the rope.
- `addLength` (number, default `0`) — Amount to add to the length of the rope.
- `forceLimit` (number, default `0`) — Amount of force until it breaks (0 = unbreakable).
- `width` (number) — Width of the rope.
- `material` (string, default `nil`) — Material of the rope.
- `rigid` (boolean, default `false`) — Whether the constraint is rigid.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- `constraint` (Entity) — The constraint entity (phys_lengthconstraint).
- `rope` (Entity) — The rope entity.

[wiki](https://wiki.facepunch.com/gmod/constraint.Rope) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L462-L531)

---

### constraint.Slider · Server
`constraint.Slider(ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, width: number, material: string, color: Color = color_white) → Entity, Entity`

Creates a slider constraint. A slider is like a rope, but allows the constrained object to move only in 1 direction.

**Arguments:**
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `width` (number) — The width of the rope.
- `material` (string) — The material of the rope.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint entity.
- Entity — The created rope.

[wiki](https://wiki.facepunch.com/gmod/constraint.Slider) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L673-L754)

---

### constraint.Weld · Server
`constraint.Weld(ent1: Entity, ent2: Entity, bone1: number, bone2: number, forceLimit: number = 0, noCollide: boolean = false, deleteEnt1OnBreak: boolean = false) → Entity`

Creates a weld constraint.

**Arguments:**
- `ent1` (Entity) — The first entity.
- `ent2` (Entity) — The second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `forceLimit` (number, default `0`) — The amount of force appliable to the constraint before it will break (0 is never).
- `noCollide` (boolean, default `false`) — Should `ent1` be nocollided to `ent2` via this constraint.
- `deleteEnt1OnBreak` (boolean, default `false`) — If true, when `ent2` is removed, `ent1` will also be removed.

**Returns:**
- Entity — The created constraint entity, or false if the constraint failed.

[wiki](https://wiki.facepunch.com/gmod/constraint.Weld) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L388-L454)

---

### constraint.Winch · Server
`constraint.Winch(player: Player, ent1: Entity, ent2: Entity, bone1: number, bone2: number, localPos1: Vector, localPos2: Vector, width: number, fwdBind: number, bwdBind: number, fwdSpeed: number, bwdSpeed: number, material: string, toggle: boolean = false, color: Color = color_white) → Entity, Entity, Entity`

Creates a winch constraint, a player controllable [constraint.Elastic](https://wiki.facepunch.com/gmod/constraint.Elastic), allowing gradually increasing or decreasing the length.

**Arguments:**
- `player` (Player) — The player that will be used to call numpad.OnDown and numpad.OnUp.
- `ent1` (Entity) — First entity.
- `ent2` (Entity) — Second entity.
- `bone1` (number) — PhysObj number of first entity to constrain to.
- `bone2` (number) — PhysObj number of second entity to constrain to.
- `localPos1` (Vector) — Position relative to the the first physics object to constrain to.
- `localPos2` (Vector) — Position relative to the the second physics object to constrain to.
- `width` (number) — The width of the rope.
- `fwdBind` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding for "forward", corresponding to an KEY.
- `bwdBind` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key binding for "backwards", corresponding to an KEY.
- `fwdSpeed` (number) — Forward speed.
- `bwdSpeed` (number) — Backwards speed.
- `material` (string) — The material of the rope.
- `toggle` (boolean, default `false`) — Whether the winch should be on toggle.
- `color` (Color, default `color_white`) — The color of the rope.

**Returns:**
- Entity — The created constraint.
- Entity — The created rope.
- Entity — The winch controller.

[wiki](https://wiki.facepunch.com/gmod/constraint.Winch) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/constraint.lua#L1241-L1304)
