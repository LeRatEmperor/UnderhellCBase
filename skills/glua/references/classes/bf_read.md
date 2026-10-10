# bf_read

**Realm:** Client  ·  **Members:** 11  ·  `DEPRECATED`

This is the object passed to [usermessage.Hook](https://wiki.facepunch.com/gmod/usermessage.Hook) when a message is received. It contains each value stored in the message in sequential order. You should read values from it in the order you wrote them.

[wiki page](https://wiki.facepunch.com/gmod/bf_read)

### bf_read:ReadAngle · Client · `DEPRECATED`
`bf_read:ReadAngle() → Angle`

Reads and returns an angle object from the bitstream.

**Returns:**
- Angle — The read angle

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadAngle)

---

### bf_read:ReadBool · Client · `DEPRECATED`
`bf_read:ReadBool() → boolean`

Reads 1 bit and returns a bool representing the bit.

**Returns:**
- boolean — bit

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadBool)

---

### bf_read:ReadChar · Client · `DEPRECATED`
`bf_read:ReadChar() → number`

Reads a signed char and returns a number from -127 to 127 representing the ascii value of that char.

**Returns:**
- number — asciiVal

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadChar)

---

### bf_read:ReadEntity · Client · `DEPRECATED`
`bf_read:ReadEntity() → Entity`

Reads a short representing an entity index and returns the matching entity handle.

**Returns:**
- Entity — ent

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadEntity)

---

### bf_read:ReadFloat · Client · `DEPRECATED`
`bf_read:ReadFloat() → number`

Reads a 4 byte float from the bitstream and returns it.

**Returns:**
- number — float

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadFloat)

---

### bf_read:ReadLong · Client · `DEPRECATED`
`bf_read:ReadLong() → number`

Reads a 4 byte long from the bitstream and returns it.

**Returns:**
- number — int

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadLong)

---

### bf_read:ReadShort · Client · `DEPRECATED`
`bf_read:ReadShort() → number`

Reads a 2 byte short from the bitstream and returns it.

**Returns:**
- number — short

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadShort)

---

### bf_read:ReadString · Client · `DEPRECATED`
`bf_read:ReadString() → string`

Reads a null terminated string from the bitstream.

**Returns:**
- string — str

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadString)

---

### bf_read:ReadVector · Client · `DEPRECATED`
`bf_read:ReadVector() → Vector`

Reads a special encoded vector from the bitstream and returns it, this function is not suitable to send normals.

**Returns:**
- Vector — vec

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadVector)

---

### bf_read:ReadVectorNormal · Client · `DEPRECATED`
`bf_read:ReadVectorNormal() → Vector`

Reads a special encoded vector normal from the bitstream and returns it, this function is not suitable to send vectors that represent a position.

**Returns:**
- Vector — normal

[wiki](https://wiki.facepunch.com/gmod/bf_read:ReadVectorNormal)

---

### bf_read:Reset · Client · `DEPRECATED`
`bf_read:Reset()`

Rewinds the bitstream so it can be read again.

[wiki](https://wiki.facepunch.com/gmod/bf_read:Reset)
