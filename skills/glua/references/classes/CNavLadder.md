# CNavLadder

**Realm:** Server  ·  **Members:** 22

An object that represents a ladder for Nextbots.

[wiki page](https://wiki.facepunch.com/gmod/CNavLadder)

### CNavLadder:ConnectTo · Server
`CNavLadder:ConnectTo(area: CNavArea)`

Connects this ladder to a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) with a one way connection. ( From this ladder to the target area ).

See [CNavArea:ConnectTo](https://wiki.facepunch.com/gmod/CNavArea:ConnectTo) for making the connection from area to ladder.

**Arguments:**
- `area` (CNavArea) — The area this ladder leads to.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:ConnectTo)

---

### CNavLadder:Disconnect · Server
`CNavLadder:Disconnect(area: CNavArea)`

Disconnects this ladder from given area in a single direction.

**Arguments:**
- `area` (CNavArea) — The CNavArea this to disconnect from.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:Disconnect)

---

### CNavLadder:GetBottom · Server
`CNavLadder:GetBottom() → Vector`

Returns the bottom most position of the ladder.

**Returns:**
- Vector — The bottom most position of the ladder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetBottom)

---

### CNavLadder:GetBottomArea · Server
`CNavLadder:GetBottomArea() → CNavArea`

Returns the bottom area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Returns:**
- CNavArea

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetBottomArea)

---

### CNavLadder:GetID · Server
`CNavLadder:GetID() → number`

Returns this [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder)s unique ID.

**Returns:**
- number — The unique ID.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetID)

---

### CNavLadder:GetLength · Server
`CNavLadder:GetLength() → number`

Returns the length of the ladder.

**Returns:**
- number — The length of the ladder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetLength)

---

### CNavLadder:GetNormal · Server
`CNavLadder:GetNormal() → Vector`

Returns the direction of this [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder). ( The direction in which players back will be facing if they are looking directly at the ladder )

**Returns:**
- Vector — The direction of this CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetNormal)

---

### CNavLadder:GetPosAtHeight · Server
`CNavLadder:GetPosAtHeight(height: number) → Vector`

Returns the world position based on given height relative to the ladder.

**Arguments:**
- `height` (number) — The Z position in world space coordinates.

**Returns:**
- Vector — The closest point on the ladder to that height.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetPosAtHeight)

---

### CNavLadder:GetTop · Server
`CNavLadder:GetTop() → Vector`

Returns the topmost position of the ladder.

**Returns:**
- Vector — The topmost position of the ladder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetTop)

---

### CNavLadder:GetTopBehindArea · Server
`CNavLadder:GetTopBehindArea() → CNavArea`

Returns the top behind [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Returns:**
- CNavArea — The top behind CNavArea of the CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetTopBehindArea)

---

### CNavLadder:GetTopForwardArea · Server
`CNavLadder:GetTopForwardArea() → CNavArea`

Returns the top forward [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Returns:**
- CNavArea — The top forward CNavArea of the CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetTopForwardArea)

---

### CNavLadder:GetTopLeftArea · Server
`CNavLadder:GetTopLeftArea() → CNavArea`

Returns the top left [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Returns:**
- CNavArea — The top left CNavArea of the CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetTopLeftArea)

---

### CNavLadder:GetTopRightArea · Server
`CNavLadder:GetTopRightArea() → CNavArea`

Returns the top right [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Returns:**
- CNavArea — The top right CNavArea of the CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetTopRightArea)

---

### CNavLadder:GetWidth · Server
`CNavLadder:GetWidth() → number`

Returns the width of the ladder in Hammer Units.

**Returns:**
- number — The width of the ladder in Hammer Units.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:GetWidth)

---

### CNavLadder:IsConnectedAtSide · Server
`CNavLadder:IsConnectedAtSide(navArea: CNavArea, navDirType: number) → boolean`

Returns whether this [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) has an outgoing ( one or two way ) connection **to** given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

**Arguments:**
- `navArea` (CNavArea) — The CNavArea to test against.
- `navDirType` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, in which to look for the connection.

**Returns:**
- boolean — Whether this CNavLadder has an outgoing ( one or two way ) connection to given CNavArea in given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:IsConnectedAtSide)

---

### CNavLadder:IsValid · Server
`CNavLadder:IsValid() → boolean`

Returns whether this [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) is valid or not.

**Returns:**
- boolean — Whether this CNavLadder is valid or not.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:IsValid)

---

### CNavLadder:Remove · Server
`CNavLadder:Remove()`

Removes the given nav ladder.

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:Remove)

---

### CNavLadder:SetBottomArea · Server
`CNavLadder:SetBottomArea(area: CNavArea)`

Sets the bottom area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `area` (CNavArea)

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:SetBottomArea)

---

### CNavLadder:SetTopBehindArea · Server
`CNavLadder:SetTopBehindArea(area: CNavArea)`

Sets the top behind area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `area` (CNavArea)

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:SetTopBehindArea)

---

### CNavLadder:SetTopForwardArea · Server
`CNavLadder:SetTopForwardArea(area: CNavArea)`

Sets the top forward area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `area` (CNavArea)

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:SetTopForwardArea)

---

### CNavLadder:SetTopLeftArea · Server
`CNavLadder:SetTopLeftArea(area: CNavArea)`

Sets the top left area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `area` (CNavArea)

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:SetTopLeftArea)

---

### CNavLadder:SetTopRightArea · Server
`CNavLadder:SetTopRightArea(area: CNavArea)`

Sets the top right area of the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `area` (CNavArea)

[wiki](https://wiki.facepunch.com/gmod/CNavLadder:SetTopRightArea)
