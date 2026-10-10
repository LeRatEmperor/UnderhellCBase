# net

**Realm:** Shared  ·  **Members:** 52

The net library is one of a number of ways to send data between the client and server. 

The major advantages of the net library are the large size limit (64kb/message) and the ability to send data backwards - from the client to the server.

Refer to [Net Library Usage](https://wiki.facepunch.com/gmod/Net%20Library%20Usage) for a short introduction.

[wiki page](https://wiki.facepunch.com/gmod/net)

### net.Abort · Shared
`net.Abort()`

Cancels a net message started by [net.Start](https://wiki.facepunch.com/gmod/net.Start), so you can immediately start a new one without any errors.

[wiki](https://wiki.facepunch.com/gmod/net.Abort)

---

### net.Broadcast · Server
`net.Broadcast()`

Sends the currently built net message (see [net.Start](https://wiki.facepunch.com/gmod/net.Start)) to all connected players.
More information can be found in [Net Library Usage](https://wiki.facepunch.com/gmod/Net%20Library%20Usage).

[wiki](https://wiki.facepunch.com/gmod/net.Broadcast)

---

### net.BytesLeft · Shared
`net.BytesLeft() → number, number`

Returns the amount of data left to read in the current message. Does nothing when sending data.

**Returns:**
- number — The amount of data left to read in the current net message in bytes.
- number — The amount of data left to read in the current net message in bits.

> **Note:** This will include 6 extra bits (or 1 byte rounded-up) used by the engine internally.

[wiki](https://wiki.facepunch.com/gmod/net.BytesLeft)

---

### net.BytesWritten · Shared
`net.BytesWritten() → number, number`

Returns the size of the current message.

**Returns:**
- number — The amount of bytes written to the current net message.
- number — The amount of bits written to the current net message.

> **Note:** This will include 3 extra bytes (24 bits) used by the engine internally to send the data over the network.

[wiki](https://wiki.facepunch.com/gmod/net.BytesWritten)

---

### net.Incoming · Shared · `INTERNAL`
`net.Incoming(length: number, client: Player)`

Function called by the engine to tell the Lua state a message arrived.

**Arguments:**
- `length` (number) — The message length, in bits.
- `client` (Player) — The player that sent the message.

[wiki](https://wiki.facepunch.com/gmod/net.Incoming) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L17-L34)

---

### net.ReadAngle · Shared
`net.ReadAngle() → Angle`

Reads an angle from the received net message.

**Returns:**
- Angle — The read angle, or `Angle( 0, 0, 0 )` if no angle could be read

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadAngle)

---

### net.ReadBit · Shared
`net.ReadBit() → number`

Reads a bit from the received net message.

**Returns:**
- number — `0` or `1`, or `0` if the bit could not be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadBit)

---

### net.ReadBool · Shared
`net.ReadBool() → boolean`

Reads a boolean from the received net message.

**Returns:**
- boolean — `true` or `false`, or `false` if the bool could not be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadBool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L41-L45)

---

### net.ReadColor · Shared
`net.ReadColor(hasAlpha: boolean = true) → Color`

Reads a [Color](https://wiki.facepunch.com/gmod/Color) from the current net message.

**Arguments:**
- `hasAlpha` (boolean, default `true`) — If the color has alpha written or not.

**Returns:**
- Color — The Color read from the current net message, or `Color( 0, 0, 0, 0 )` if the color could not be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L83-L93)

---

### net.ReadData · Shared
`net.ReadData(length: number) → string`

Reads pure binary data from the message.

**Arguments:**
- `length` (number) — The length of the data to be read, in bytes.

**Returns:**
- string — The binary data read, or a string containing one character with a byte of `0` if no data could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadData)

---

### net.ReadDouble · Shared
`net.ReadDouble() → number`

Reads a double-precision number from the received net message.

**Returns:**
- number — The double-precision number, or `0` if no number could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadDouble)

---

### net.ReadEntity · Shared
`net.ReadEntity() → Entity`

Reads an entity from the received net message. You should always check if the specified entity exists as it may have been removed and therefore `NULL` if it is outside of the players [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") or was already removed.

**Returns:**
- Entity — The entity, or `nil` if no entity could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L60-L67)

---

### net.ReadFloat · Shared
`net.ReadFloat() → number`

Reads a floating point number from the received net message.

**Returns:**
- number — The floating point number, or `0` if no number could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadFloat)

---

### net.ReadHeader · Shared · `INTERNAL`
`net.ReadHeader() → number`

Reads a word, basically unsigned short. This is used internally to read the "header" of the message which is an unsigned short which can be converted to the corresponding message name via [util.NetworkIDToString](https://wiki.facepunch.com/gmod/util.NetworkIDToString).

**Returns:**
- number — The header number

[wiki](https://wiki.facepunch.com/gmod/net.ReadHeader)

---

### net.ReadInt · Shared
`net.ReadInt(bitCount: number) → number`

Reads an integer from the received net message.

**Arguments:**
- `bitCount` (number) — The amount of bits to be read.

**Returns:**
- number — The read integer number, or `0` if no integer could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadInt)

---

### net.ReadMatrix · Shared
`net.ReadMatrix() → VMatrix`

Reads a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) from the received net message.

**Returns:**
- VMatrix — The matrix, or an empty matrix if no matrix could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadMatrix)

---

### net.ReadNormal · Shared
`net.ReadNormal() → Vector`

Reads a normal vector from the net message.

**Returns:**
- Vector — The normalized vector ( length = `1` ), or `Vector( 0, 0, 1 )` if no normal could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadNormal)

---

### net.ReadPlayer · Shared
`net.ReadPlayer() → Player`

Reads a player entity that was written with [net.WritePlayer](https://wiki.facepunch.com/gmod/net.WritePlayer) from the received net message.

You should always check if the specified entity exists as it may have been removed and therefore `NULL` if it is outside of the local players [PVS](https://developer.valvesoftware.com/wiki/PVS) or was already removed.

**Returns:**
- Player — The player, or `Entity(0)` if no entity could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadPlayer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L89-L97)

---

### net.ReadString · Shared
`net.ReadString() → string`

Reads a [null-terminated string](https://en.wikipedia.org/wiki/Null-terminated_string) from the net stream. The size of the string is 8 bits plus 8 bits for every ASCII character in the string.

**Returns:**
- string — The read string, or a string with `0` length if no string could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadString)

---

### net.ReadTable · Shared
`net.ReadTable(sequential: boolean = false) → table`

Reads a table from the received net message.

See [net.WriteTable](https://wiki.facepunch.com/gmod/net.WriteTable) for extra info.

**Arguments:**
- `sequential` (boolean, default `false`) — Set to `true` if the input table is sequential.

**Returns:**
- table — Table received via the net message, or a blank table if no table could be read.

> **Note:** Sometimes when sending a table through the net library, the order of the keys may be switched. So be cautious when comparing (See example 1).
> 
> You may get `net.ReadType: Couldn't read type X` during the execution of the function, the problem is that you are sending objects that **cannot** be serialized/sent over the network.
> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L115-L128)

---

### net.ReadType · Shared · `INTERNAL`
`net.ReadType(typeID: number = net.ReadUInt(8)) → any`

Reads a value from the net message with the specified type, written by [net.WriteType](https://wiki.facepunch.com/gmod/net.WriteType).

**Arguments:**
- `typeID` (number, default `net.ReadUInt(8)`, enum [TYPE](https://wiki.facepunch.com/gmod/Enums/TYPE)) — The type of value to be read, using TYPE.

**Returns:**
- any — The value, or the respective blank value based on the type you're reading if the value could not be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L175-L183)

---

### net.ReadUInt · Shared
`net.ReadUInt(bitCount: number) → number`

Reads an unsigned integer with the specified number of bits from the received net message.

**Arguments:**
- `bitCount` (number) — The size of the integer to be read, in bits.

**Returns:**
- number — The unsigned integer read, or `0` if the integer could not be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadUInt)

---

### net.ReadUInt64 · Shared
`net.ReadUInt64() → string`

Reads a unsigned integer with 64 bits from the received net message.

**Returns:**
- string — The uint64 number.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadUInt64)

---

### net.ReadVars · Shared · `INTERNAL`
`net.ReadVars()`

[wiki](https://wiki.facepunch.com/gmod/net.ReadVars)

---

### net.ReadVector · Shared
`net.ReadVector() → Vector`

Reads a vector from the received net message. Vectors sent by this function are **compressed**, which may result in precision loss. See [net.WriteVector](https://wiki.facepunch.com/gmod/net.WriteVector) for more information.

**Returns:**
- Vector — The read vector, or `Vector( 0, 0, 0 )` if no vector could be read.

> **Warning:** You **must** read information in same order as you write it.

[wiki](https://wiki.facepunch.com/gmod/net.ReadVector)

---

### net.Receive · Shared
`net.Receive(messageName: string, callback: function)`

Adds a net message handler. Only one receiver can be used to receive the net message.

You can use the `net.Read*` functions within the message handler callback.

**Arguments:**
- `messageName` (string) — The message name to hook to.
- `callback` (function) — The function to be called if the specified message was received.

> **Warning:** You **should** put this function **outside** of any other function or hook for it to work properly unless you know what you are doing!
> 
> You **must** read information in the same order as you write it.
> 
> Each net message has a length limit of **64KB**!

[wiki](https://wiki.facepunch.com/gmod/net.Receive) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L8-L12)

---

### net.Receivers · Shared · `INTERNAL`
`net.Receivers()`

[wiki](https://wiki.facepunch.com/gmod/net.Receivers)

---

### net.Send · Server
`net.Send(ply: Player, plys: table<Player>, filter: CRecipientFilter)`

Sends the current net message to the specified player(s)

**Arguments:**
- `ply` (Player) — The player to send the message to.
- `plys` (table<Player>) — A table of players to send the message to.
- `filter` (CRecipientFilter) — A recipient filter specifying message targets.

[wiki](https://wiki.facepunch.com/gmod/net.Send)

---

### net.SendOmit · Server
`net.SendOmit(ply: Player, plys: table<Player>)`

Sends the current message (see [net.Start](https://wiki.facepunch.com/gmod/net.Start)) to all except the player or players specified.

**Arguments:**
- `ply` (Player) — The player to NOT send the message to.
- `plys` (table<Player>) — A table of players to NOT send the message to.

[wiki](https://wiki.facepunch.com/gmod/net.SendOmit)

---

### net.SendPAS · Server
`net.SendPAS(position: Vector)`

Sends current net message (see [net.Start](https://wiki.facepunch.com/gmod/net.Start)) to all players that are in the same [Potentially Audible Set (PAS)](https://developer.valvesoftware.com/wiki/PAS) as the position, or simply said, it adds all players that can potentially hear sounds from this position.

**Arguments:**
- `position` (Vector) — PAS position.

[wiki](https://wiki.facepunch.com/gmod/net.SendPAS)

---

### net.SendPVS · Server
`net.SendPVS(position: Vector)`

Sends current net message (see [net.Start](https://wiki.facepunch.com/gmod/net.Start)) to all players in the [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") of the position, or, more simply said, sends the message to players that can potentially see this position.

**Arguments:**
- `position` (Vector) — Position that must be in players' visibility set.

[wiki](https://wiki.facepunch.com/gmod/net.SendPVS)

---

### net.SendToServer · Client
`net.SendToServer()`

Sends the current net message (see [net.Start](https://wiki.facepunch.com/gmod/net.Start)) to the server. The player object must exist on the server for the net message to be received successfully by the server.

> **Warning:** Each net message has a length limit of 65,533 bytes (approximately 64 KiB) and your net message will error and fail to send if it is larger than this.
> 
> The message name must be pooled with [util.AddNetworkString](https://wiki.facepunch.com/gmod/util.AddNetworkString) beforehand!

[wiki](https://wiki.facepunch.com/gmod/net.SendToServer)

---

### net.Start · Shared
`net.Start(messageName: string, unreliable: boolean = false) → boolean`

Begins a new net message. If another net message is already started and hasn't been sent yet, it will be discarded.

After calling this function, you will want to call `net.Write` functions to write your data, if any, and then finish with a call to one of the following functions:
* [net.Send](https://wiki.facepunch.com/gmod/net.Send)
* [net.SendOmit](https://wiki.facepunch.com/gmod/net.SendOmit)
* [net.SendPAS](https://wiki.facepunch.com/gmod/net.SendPAS)
* [net.SendPVS](https://wiki.facepunch.com/gmod/net.SendPVS)
* [net.Broadcast](https://wiki.facepunch.com/gmod/net.Broadcast)
* [net.SendToServer](https://wiki.facepunch.com/gmod/net.SendToServer)

**Arguments:**
- `messageName` (string) — The name of the message to send
- `unreliable` (boolean, default `false`) — If set to `true`, the message is not guaranteed to reach its destination

**Returns:**
- boolean — `true` if the message has been started.

> **Warning:** Each net message has a length limit of 65,533 bytes (approximately 64 KiB) and your net message will error and fail to send if it is larger than this.
> 
> The net library has an internal buffer that sent messages are added to that is capable of holding roughly 256 kb at a time. Trying to send more will lead to the client being kicked because of a buffer overflow. [More information on net library limits can be found here.](https://wiki.facepunch.com/gmod/Networking_Usage#netlimits)
> 
> The message name must be pooled with [util.AddNetworkString](https://wiki.facepunch.com/gmod/util.AddNetworkString) beforehand!
> 
> Net messages will not reliably reach the client until the client's [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) hook is called.

[wiki](https://wiki.facepunch.com/gmod/net.Start)

---

### net.WriteAngle · Shared
`net.WriteAngle(angle: Angle)`

Writes an angle to the current net message.

**Arguments:**
- `angle` (Angle) — The angle to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteAngle)

---

### net.WriteBit · Shared
`net.WriteBit(boolean: boolean)`

Appends a boolean (as `1` or `0`) to the current net message.

Please note that the bit is written here from a [boolean](https://wiki.facepunch.com/gmod/boolean) (`true/false`) but [net.ReadBit](https://wiki.facepunch.com/gmod/net.ReadBit) returns a number.

**Arguments:**
- `boolean` (boolean) — Bit status (false = `0`, true = `1`).

[wiki](https://wiki.facepunch.com/gmod/net.WriteBit)

---

### net.WriteBool · Shared
`net.WriteBool(boolean: boolean)`

Appends a boolean to the current net message. Alias of [net.WriteBit](https://wiki.facepunch.com/gmod/net.WriteBit).

**Arguments:**
- `boolean` (boolean) — Boolean value to write.

[wiki](https://wiki.facepunch.com/gmod/net.WriteBool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L41-L41)

---

### net.WriteColor · Shared
`net.WriteColor(Color: Color, writeAlpha: boolean = true)`

Appends a [Color](https://wiki.facepunch.com/gmod/Color) to the current net message.

**Arguments:**
- `Color` (Color) — The Color you want to append to the net message.
- `writeAlpha` (boolean, default `true`) — If we should write the alpha of the color or not.

[wiki](https://wiki.facepunch.com/gmod/net.WriteColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L72-L81)

---

### net.WriteData · Shared
`net.WriteData(binaryData: string, length: number = #binaryData)`

Writes a chunk of binary data to the message.

**Arguments:**
- `binaryData` (string) — The binary data to be sent.
- `length` (number, default `#binaryData`) — The length of the binary data to be sent, in bytes.

[wiki](https://wiki.facepunch.com/gmod/net.WriteData)

---

### net.WriteDouble · Shared
`net.WriteDouble(double: number)`

Appends a double-precision number to the current net message.

**Arguments:**
- `double` (number) — The double to be sent

[wiki](https://wiki.facepunch.com/gmod/net.WriteDouble)

---

### net.WriteEntity · Shared
`net.WriteEntity(entity: Entity)`

Appends an entity to the current net message using its [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex).

See [net.ReadEntity](https://wiki.facepunch.com/gmod/net.ReadEntity) for the function to read the entity.

**Arguments:**
- `entity` (Entity) — The entity to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L50-L58)

---

### net.WriteFloat · Shared
`net.WriteFloat(float: number)`

Appends a float (number with decimals) to the current net message.

**Arguments:**
- `float` (number) — The float to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteFloat)

---

### net.WriteInt · Shared
`net.WriteInt(integer: number, bitCount: number)`

Appends a signed integer - a whole number, positive/negative - to the current net message. Can be read back with [net.ReadInt](https://wiki.facepunch.com/gmod/net.ReadInt) on the receiving end.

Use [net.WriteUInt](https://wiki.facepunch.com/gmod/net.WriteUInt) to send an unsigned number (that you know will **never** be negative). Use [net.WriteFloat](https://wiki.facepunch.com/gmod/net.WriteFloat) for a non-whole number (e.g. `2.25`).

**Arguments:**
- `integer` (number) — The integer to be sent.
- `bitCount` (number) — The amount of bits the number consists of.

[wiki](https://wiki.facepunch.com/gmod/net.WriteInt)

---

### net.WriteMatrix · Shared
`net.WriteMatrix(matrix: VMatrix)`

Writes a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) to the current net message.

**Arguments:**
- `matrix` (VMatrix) — The matrix to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteMatrix)

---

### net.WriteNormal · Shared
`net.WriteNormal(normal: Vector)`

Writes a normalized/direction vector ( Vector with length of 1 ) to the net message.

This function uses less bandwidth compared to [net.WriteVector](https://wiki.facepunch.com/gmod/net.WriteVector) and will not send vectors with length of > 1 properly.

**Arguments:**
- `normal` (Vector) — The normalized/direction vector to be send.

[wiki](https://wiki.facepunch.com/gmod/net.WriteNormal)

---

### net.WritePlayer · Shared
`net.WritePlayer(ply: Player)`

Appends a player entity to the current net message using its [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex). This saves a small amount of network bandwidth over [net.WriteEntity](https://wiki.facepunch.com/gmod/net.WriteEntity).

See [net.ReadPlayer](https://wiki.facepunch.com/gmod/net.ReadPlayer) for the function to read the entity.

**Arguments:**
- `ply` (Player) — The player to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WritePlayer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L76-L87)

---

### net.WriteString · Shared
`net.WriteString(string: string)`

Appends a string to the current net message. The size of the written data is 8 bits for every ASCII character in the string + 8 bits for the null terminator.

The maximum allowed length of a single written string is **65532 characters**. (aka the limit of the net message itself)

**Arguments:**
- `string` (string) — The string to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteString)

---

### net.WriteTable · Shared
`net.WriteTable(table: table, sequential: boolean = false)`

Appends a table to the current net message. Adds **16 extra bits** per key/value pair, so you're better off writing each individual key/value as the exact type if possible.

**Arguments:**
- `table` (table) — The table to be sent.
- `sequential` (boolean, default `false`) — Set to `true` if the input table is sequential.

> **Warning:** All net messages have a **64kb** buffer. This function will not check or error when that buffer is overflown. You might want to consider using [util.TableToJSON](https://wiki.facepunch.com/gmod/util.TableToJSON) and [util.Compress](https://wiki.facepunch.com/gmod/util.Compress) and send the resulting string in **60kb** chunks, doing the opposite on the receiving end.

[wiki](https://wiki.facepunch.com/gmod/net.WriteTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L101-L113)

---

### net.WriteType · Shared · `INTERNAL`
`net.WriteType(Data: any)`

Appends any type of value to the current net message.

**Arguments:**
- `Data` (any) — The data to be sent.

> **Note:** An additional 8-bit unsigned integer indicating the type will automatically be written to the packet before the value, in order to facilitate reading with [net.ReadType](https://wiki.facepunch.com/gmod/net.ReadType). If you know the data type you are writing, use a function meant for that specific data type to reduce amount of data sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/net.lua#L145-L159)

---

### net.WriteUInt · Shared
`net.WriteUInt(unsignedInteger: number, bitCount: number)`

Appends an unsigned integer with the specified number of bits to the current net message.

Use [net.WriteInt](https://wiki.facepunch.com/gmod/net.WriteInt) if you want to send negative and positive numbers. Use [net.WriteFloat](https://wiki.facepunch.com/gmod/net.WriteFloat) for a non-whole number (e.g. `2.25`).

**Arguments:**
- `unsignedInteger` (number) — The unsigned integer to be sent.
- `bitCount` (number) — The size of the integer to be sent, in bits.

> **Note:** Unsigned numbers **do not** support negative numbers.

[wiki](https://wiki.facepunch.com/gmod/net.WriteUInt)

---

### net.WriteUInt64 · Shared
`net.WriteUInt64(uint64: string)`

Appends an unsigned integer with 64 bits to the current net message.

		The limit for an uint64 is 18'446'744'073'709'551'615.  
		Everything above the limit will be set to the limit.  

		Unsigned numbers **do not** support negative numbers.

**Arguments:**
- `uint64` (string) — The 64 bit value to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteUInt64)

---

### net.WriteVars · Shared · `INTERNAL`
`net.WriteVars()`

[wiki](https://wiki.facepunch.com/gmod/net.WriteVars)

---

### net.WriteVector · Shared
`net.WriteVector(vector: Vector)`

Appends a vector to the current net message.
Vectors sent by this function are compressed, which may result in precision loss. XYZ components greater than `16384` or less than `-16384` are irrecoverably altered (most significant bits are trimmed) and precision after the decimal point is 1 digit (5 bits).

**Arguments:**
- `vector` (Vector) — The vector to be sent.

[wiki](https://wiki.facepunch.com/gmod/net.WriteVector)
