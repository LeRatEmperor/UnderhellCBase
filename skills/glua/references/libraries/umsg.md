# umsg

**Realm:** Server  ·  **Members:** 13  ·  `DEPRECATED`

The umsg (user message) library was previously the most common way of sending information from the server to the client.

> **Warning:** Usermessages have a limit of only 256 bytes!

[wiki page](https://wiki.facepunch.com/gmod/umsg)

### umsg.Angle · Server · `DEPRECATED`
`umsg.Angle(angle: Angle)`

Writes an angle to the usermessage.

**Arguments:**
- `angle` (Angle) — The angle to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Angle)

---

### umsg.Bool · Server · `DEPRECATED`
`umsg.Bool(bool: boolean)`

Writes a bool to the usermessage.

**Arguments:**
- `bool` (boolean) — The bool to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Bool)

---

### umsg.Char · Server · `DEPRECATED`
`umsg.Char(char: number)`

Writes a signed char to the usermessage.

**Arguments:**
- `char` (number) — The char to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Char)

---

### umsg.End · Server · `DEPRECATED`
`umsg.End()`

Dispatches the usermessage to the client(s).

[wiki](https://wiki.facepunch.com/gmod/umsg.End)

---

### umsg.Entity · Server · `DEPRECATED`
`umsg.Entity(entity: Entity)`

Writes an entity object to the usermessage. (As an entity handle, which means the entity index + its serial number)

**Arguments:**
- `entity` (Entity) — The entity to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Entity)

---

### umsg.Float · Server · `DEPRECATED`
`umsg.Float(float: number)`

Writes a float to the usermessage.

**Arguments:**
- `float` (number) — The float to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Float)

---

### umsg.Long · Server · `DEPRECATED`
`umsg.Long(int: number)`

Writes a signed int (32 bit) to the usermessage.

**Arguments:**
- `int` (number) — The int to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Long)

---

### umsg.PoolString · Server · `DEPRECATED`
`umsg.PoolString(string: string)`

The string specified will be networked to the client and receive a identifying number, which will be sent instead of the string to optimize networking.

**Arguments:**
- `string` (string) — The string to be pooled.

[wiki](https://wiki.facepunch.com/gmod/umsg.PoolString)

---

### umsg.Short · Server · `DEPRECATED`
`umsg.Short(short: number)`

Writes a signed short (16 bit) to the usermessage.

**Arguments:**
- `short` (number) — The short to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Short)

---

### umsg.Start · Server · `DEPRECATED`
`umsg.Start(name: string, filter: Player = nil)`

Starts a new usermessage.

**Arguments:**
- `name` (string) — The name of the message to be sent.
- `filter` (Player, default `nil`) — If passed a player object, it will only be sent to the player, if passed a CRecipientFilter of players, it will be sent to all specified players, if passed `nil` (or another invalid value), the message will be sent to all players.

> **Warning:** Usermessages have a limit of only 256 bytes!

[wiki](https://wiki.facepunch.com/gmod/umsg.Start)

---

### umsg.String · Server · `DEPRECATED`
`umsg.String(string: string)`

Writes a null terminated string to the usermessage.

**Arguments:**
- `string` (string) — The string to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.String)

---

### umsg.Vector · Server · `DEPRECATED`
`umsg.Vector(vector: Vector)`

Writes a Vector to the usermessage.

**Arguments:**
- `vector` (Vector) — The vector to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.Vector)

---

### umsg.VectorNormal · Server · `DEPRECATED`
`umsg.VectorNormal(normal: Vector)`

Writes a vector normal to the usermessage.

**Arguments:**
- `normal` (Vector) — The vector normal to be sent.

[wiki](https://wiki.facepunch.com/gmod/umsg.VectorNormal)
