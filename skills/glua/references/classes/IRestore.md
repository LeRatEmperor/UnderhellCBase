# IRestore

**Realm:** Shared  ·  **Members:** 9

The object used in the [saverestore](https://wiki.facepunch.com/gmod/saverestore), mainly in [saverestore.AddRestoreHook](https://wiki.facepunch.com/gmod/saverestore.AddRestoreHook).

It allows you to read blocks directly from the save game files used by Half-Life 2 save system when such save is loaded.

[wiki page](https://wiki.facepunch.com/gmod/IRestore)

### IRestore:EndBlock · Shared
`IRestore:EndBlock()`

Ends current data block started with [IRestore:StartBlock](https://wiki.facepunch.com/gmod/IRestore:StartBlock) and returns to the parent block.

To avoid all sorts of errors, you **must** end all blocks you start.

[wiki](https://wiki.facepunch.com/gmod/IRestore:EndBlock)

---

### IRestore:ReadAngle · Shared
`IRestore:ReadAngle() → Angle`

Reads next bytes from the restore object as an [Angle](https://wiki.facepunch.com/gmod/Angle).

**Returns:**
- Angle — The angle that has been read

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadAngle)

---

### IRestore:ReadBool · Shared
`IRestore:ReadBool() → boolean`

Reads next bytes from the restore object as a [boolean](https://wiki.facepunch.com/gmod/boolean).

**Returns:**
- boolean — The boolean that has been read

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadBool)

---

### IRestore:ReadEntity · Shared
`IRestore:ReadEntity() → Entity`

Reads next bytes from the restore object as an [Entity](https://wiki.facepunch.com/gmod/Entity).

**Returns:**
- Entity — The entity that has been read.

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadEntity)

---

### IRestore:ReadFloat · Shared
`IRestore:ReadFloat() → number`

Reads next bytes from the restore object as a floating point [number](https://wiki.facepunch.com/gmod/number).

**Returns:**
- number — The read floating point number.

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadFloat)

---

### IRestore:ReadInt · Shared
`IRestore:ReadInt() → number`

Reads next bytes from the restore object as an integer [number](https://wiki.facepunch.com/gmod/number).

**Returns:**
- number — The read integer number.

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadInt)

---

### IRestore:ReadString · Shared
`IRestore:ReadString() → string`

Reads next bytes from the restore object as a [string](https://wiki.facepunch.com/gmod/string).

**Returns:**
- string — The read string.

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadString)

---

### IRestore:ReadVector · Shared
`IRestore:ReadVector() → Vector`

Reads next bytes from the restore object as a [Vector](https://wiki.facepunch.com/gmod/Vector).

**Returns:**
- Vector — The read vector.

[wiki](https://wiki.facepunch.com/gmod/IRestore:ReadVector)

---

### IRestore:StartBlock · Shared
`IRestore:StartBlock() → string`

Loads next block of data to be read inside current block. Blocks **must** be ended with [IRestore:EndBlock](https://wiki.facepunch.com/gmod/IRestore:EndBlock).

**Returns:**
- string — The name of the next data block to be read.

[wiki](https://wiki.facepunch.com/gmod/IRestore:StartBlock)
