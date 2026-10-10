# ISave

**Realm:** Shared  ·  **Members:** 9

The object used in the [saverestore](https://wiki.facepunch.com/gmod/saverestore), mainly in [saverestore.AddSaveHook](https://wiki.facepunch.com/gmod/saverestore.AddSaveHook).

It allows you to write blocks directly into the save game files used by Half-Life 2 save system when such save is being saved.

[wiki page](https://wiki.facepunch.com/gmod/ISave)

### ISave:EndBlock · Shared
`ISave:EndBlock()`

Ends current data block started with [ISave:StartBlock](https://wiki.facepunch.com/gmod/ISave:StartBlock) and returns to the parent block.

To avoid all sorts of errors, you **must** end all blocks you start.

[wiki](https://wiki.facepunch.com/gmod/ISave:EndBlock)

---

### ISave:StartBlock · Shared
`ISave:StartBlock(name: string)`

Starts a new block of data that you can write to inside current block. Blocks **must** be ended with [ISave:EndBlock](https://wiki.facepunch.com/gmod/ISave:EndBlock).

**Arguments:**
- `name` (string) — Name of the new block.

[wiki](https://wiki.facepunch.com/gmod/ISave:StartBlock)

---

### ISave:WriteAngle · Shared
`ISave:WriteAngle(ang: Angle)`

Writes an [Angle](https://wiki.facepunch.com/gmod/Angle) to the save object.

**Arguments:**
- `ang` (Angle) — The angle to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteAngle)

---

### ISave:WriteBool · Shared
`ISave:WriteBool(bool: boolean)`

Writes a [boolean](https://wiki.facepunch.com/gmod/boolean) to the save object.

**Arguments:**
- `bool` (boolean) — The boolean to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteBool)

---

### ISave:WriteEntity · Shared
`ISave:WriteEntity(ent: Entity)`

Writes an [Entity](https://wiki.facepunch.com/gmod/Entity) to the save object.

**Arguments:**
- `ent` (Entity) — The entity to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteEntity)

---

### ISave:WriteFloat · Shared
`ISave:WriteFloat(float: number)`

Writes a floating point [number](https://wiki.facepunch.com/gmod/number) to the save object.

**Arguments:**
- `float` (number) — The floating point number to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteFloat)

---

### ISave:WriteInt · Shared
`ISave:WriteInt(int: number)`

Writes an integer [number](https://wiki.facepunch.com/gmod/number) to the save object.

**Arguments:**
- `int` (number) — The integer number to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteInt)

---

### ISave:WriteString · Shared
`ISave:WriteString(str: string)`

Writes a **null terminated** [string](https://wiki.facepunch.com/gmod/string) to the save object.

**Arguments:**
- `str` (string) — The string to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteString)

---

### ISave:WriteVector · Shared
`ISave:WriteVector(vec: Vector)`

Writes a [Vector](https://wiki.facepunch.com/gmod/Vector) to the save object.

**Arguments:**
- `vec` (Vector) — The vector to write.

[wiki](https://wiki.facepunch.com/gmod/ISave:WriteVector)
