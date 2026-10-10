# File

**Realm:** Shared, Menu  ·  **Members:** 28

This is the file object. It used used primarily to read or write binary data from files.  
The default endianness is little-endian. To use big-endian you will need to provide your own functions to read and write shorts and longs.

		The object is returned by [file.Open](https://wiki.facepunch.com/gmod/file.Open).

[wiki page](https://wiki.facepunch.com/gmod/File)

### File:Close · Shared, Menu
`File:Close()`

Dumps the file changes to disk and closes the file handle which makes the handle useless.

[wiki](https://wiki.facepunch.com/gmod/File:Close)

---

### File:EndOfFile · Shared, Menu
`File:EndOfFile() → boolean`

Returns whether the [File](https://wiki.facepunch.com/gmod/File) object has reached the end of file or not.

**Returns:**
- boolean — Whether the file has reached end or not.

[wiki](https://wiki.facepunch.com/gmod/File:EndOfFile)

---

### File:Flush · Shared, Menu
`File:Flush()`

Dumps the file changes to disk and saves the file.

[wiki](https://wiki.facepunch.com/gmod/File:Flush)

---

### File:Read · Shared, Menu
`File:Read(length: number = nil) → string`

Reads the specified amount of chars and returns them as a binary string.

**Arguments:**
- `length` (number, default `nil`) — Reads the specified amount of chars.

**Returns:**
- `data` (string) — The read data.

[wiki](https://wiki.facepunch.com/gmod/File:Read)

---

### File:ReadBool · Shared, Menu
`File:ReadBool() → boolean`

Reads one byte of the file and returns whether that byte was not 0.

**Returns:**
- boolean — val

[wiki](https://wiki.facepunch.com/gmod/File:ReadBool)

---

### File:ReadByte · Shared, Menu
`File:ReadByte() → number`

Reads one unsigned 8-bit integer from the file.

**Returns:**
- number — The unsigned 8-bit integer from the file.

[wiki](https://wiki.facepunch.com/gmod/File:ReadByte)

---

### File:ReadDouble · Shared, Menu
`File:ReadDouble() → number`

Reads an 8-byte little-endian IEEE-754 floating point double from the file.

**Returns:**
- number — The double-precision floating point value read from the file.

[wiki](https://wiki.facepunch.com/gmod/File:ReadDouble)

---

### File:ReadFloat · Shared, Menu
`File:ReadFloat() → number`

Reads an IEEE 754 little-endian 4-byte float from the file.

**Returns:**
- number — The read value

[wiki](https://wiki.facepunch.com/gmod/File:ReadFloat)

---

### File:ReadLine · Shared, Menu
`File:ReadLine() → string`

Returns the contents of the file from the current position up until the end of the current line.

**Returns:**
- string — The string of data from the read line.

> **Note:** This function will look specifically for `Line Feed` characters `\n` and will **completely ignore `Carriage Return` characters** `\r`.
> 
> It will also stop at a `\0` or `NULL` character, but will add a new line instead.
> 
> This function will not return more than 8192 characters. The return value will include the `\n` character.

[wiki](https://wiki.facepunch.com/gmod/File:ReadLine)

---

### File:ReadLong · Shared, Menu
`File:ReadLong() → number`

Reads a signed little-endian 32-bit integer from the file.

**Returns:**
- number — A signed 32-bit integer

[wiki](https://wiki.facepunch.com/gmod/File:ReadLong)

---

### File:ReadShort · Shared, Menu
`File:ReadShort() → number`

Reads a signed little-endian 16-bit integer from the file.

**Returns:**
- number — int16

[wiki](https://wiki.facepunch.com/gmod/File:ReadShort)

---

### File:ReadUInt64 · Shared, Menu
`File:ReadUInt64() → string`

Reads an unsigned 64-bit integer from the file.

**Returns:**
- string — An unsigned 64-bit integer.

[wiki](https://wiki.facepunch.com/gmod/File:ReadUInt64)

---

### File:ReadULong · Shared, Menu
`File:ReadULong() → number`

Reads an unsigned little-endian 32-bit integer from the file.

**Returns:**
- number — An unsigned 32-bit integer

[wiki](https://wiki.facepunch.com/gmod/File:ReadULong)

---

### File:ReadUShort · Shared, Menu
`File:ReadUShort() → number`

Reads an unsigned little-endian 16-bit integer from the file.

**Returns:**
- number — The 16-bit integer

[wiki](https://wiki.facepunch.com/gmod/File:ReadUShort)

---

### File:Seek · Shared, Menu
`File:Seek(pos: number)`

Sets the file pointer to the specified position.

**Arguments:**
- `pos` (number) — Pointer position, in bytes.

[wiki](https://wiki.facepunch.com/gmod/File:Seek)

---

### File:Size · Shared, Menu
`File:Size() → number`

Returns the size of the file in bytes.

**Returns:**
- `size` (number)

[wiki](https://wiki.facepunch.com/gmod/File:Size)

---

### File:Skip · Shared, Menu
`File:Skip(amount: number) → number`

Moves the file pointer by the specified amount of chars.

**Arguments:**
- `amount` (number) — The amount of chars to skip, can be negative to skip backwards.

**Returns:**
- number — amount

[wiki](https://wiki.facepunch.com/gmod/File:Skip)

---

### File:Tell · Shared, Menu
`File:Tell() → number`

Returns the current position of the file pointer.

**Returns:**
- number — pos

[wiki](https://wiki.facepunch.com/gmod/File:Tell)

---

### File:Write · Shared, Menu
`File:Write(data: string)`

Writes the given string into the file.

**Arguments:**
- `data` (string) — Binary data to write to the file.

[wiki](https://wiki.facepunch.com/gmod/File:Write)

---

### File:WriteBool · Shared, Menu
`File:WriteBool(bool: boolean)`

Writes a boolean value to the file as one **byte**.

**Arguments:**
- `bool` (boolean) — The bool to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteBool)

---

### File:WriteByte · Shared, Menu
`File:WriteByte(uint8: number)`

Write an 8-bit unsigned integer to the file.

**Arguments:**
- `uint8` (number) — The 8-bit unsigned integer to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteByte)

---

### File:WriteDouble · Shared, Menu
`File:WriteDouble(double: number)`

Writes an 8-byte little-endian IEEE-754 floating point double to the file.

**Arguments:**
- `double` (number) — The double to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteDouble)

---

### File:WriteFloat · Shared, Menu
`File:WriteFloat(float: number)`

Writes an IEEE 754 little-endian 4-byte float to the file.

**Arguments:**
- `float` (number) — The float to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteFloat)

---

### File:WriteLong · Shared, Menu
`File:WriteLong(int32: number)`

Writes a signed little-endian 32-bit integer to the file.

**Arguments:**
- `int32` (number) — The 32-bit signed integer to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteLong)

---

### File:WriteShort · Shared, Menu
`File:WriteShort(int16: number)`

Writes a signed little-endian 16-bit integer to the file.

**Arguments:**
- `int16` (number) — The 16-bit signed integer to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteShort)

---

### File:WriteUInt64 · Shared, Menu
`File:WriteUInt64(uint64: string)`

Writes an unsigned 64-bit integer to the file.

**Arguments:**
- `uint64` (string) — The unsigned 64-bit integer to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteUInt64)

---

### File:WriteULong · Shared, Menu
`File:WriteULong(uint32: number)`

Writes an unsigned little-endian 32-bit integer to the file.

**Arguments:**
- `uint32` (number) — The unsigned 32-bit integer to be written to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteULong)

---

### File:WriteUShort · Shared, Menu
`File:WriteUShort(uint16: number)`

Writes an unsigned little-endian 16-bit integer to the file.

**Arguments:**
- `uint16` (number) — The unsigned 16-bit integer to the file.

[wiki](https://wiki.facepunch.com/gmod/File:WriteUShort)
