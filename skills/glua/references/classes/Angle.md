# Angle

**Realm:** Shared, Menu  ·  **Members:** 18

List of all possible functions to manipulate angles.

		Created by [Angle](https://wiki.facepunch.com/gmod/Global.Angle).

		| Type                | Name                                 | Description                      |
		| ------------------- | ------------------------------------ | -------------------------------- |
		| [number](https://wiki.facepunch.com/gmod/number) | `p` or `pitch` or `x` or `1` | The pitch component of the angle. |
		| [number](https://wiki.facepunch.com/gmod/number) | `y` or `yaw` or `2` | The yaw component of the angle. |
		| [number](https://wiki.facepunch.com/gmod/number) | `r` or `roll`  or `z` or `3` | The roll  component of the angle. |

		Metamethod | Second Operand | Description
		---------- | -------------- | -----------
		`__add` | [Angle](https://wiki.facepunch.com/gmod/Angle) | Returns new [Angle](https://wiki.facepunch.com/gmod/Angle) with the result of addition.
		`__div` | [number](https://wiki.facepunch.com/gmod/number) | Returns new [Angle](https://wiki.facepunch.com/gmod/Angle) with the result of division.
		`__eq` | [any](https://wiki.facepunch.com/gmod/any) | Compares 2 operands, if they both are [Angle](https://wiki.facepunch.com/gmod/Angle), compares each individual component. Doesn't normalize the angles (360 is not equal to 0).
		`__index` | [number](https://wiki.facepunch.com/gmod/number) or [string](https://wiki.facepunch.com/gmod/string) | Gets the component of the [Angle](https://wiki.facepunch.com/gmod/Angle). Returns a [number](https://wiki.facepunch.com/gmod/number).
		`__mul` | [number](https://wiki.facepunch.com/gmod/number) | Returns new [Angle](https://wiki.facepunch.com/gmod/Angle) with the result of multiplication.
		`__newindex` | [number](https://wiki.facepunch.com/gmod/number) or [string](https://wiki.facepunch.com/gmod/string) | Sets the component of the [Angle](https://wiki.facepunch.com/gmod/Angle). Accepts [number](https://wiki.facepunch.com/gmod/number) and [string](https://wiki.facepunch.com/gmod/string).
		`__sub` | [Angle](https://wiki.facepunch.com/gmod/Angle) | Returns new [Angle](https://wiki.facepunch.com/gmod/Angle) with the result of subtraction.
		`__tostring` | | Returns `p y r`.
		`__unm` | | Returns new [Angle](https://wiki.facepunch.com/gmod/Angle) with the result of negation.

[wiki page](https://wiki.facepunch.com/gmod/Angle)

### Angle:Add · Shared, Menu
`Angle:Add(angle: Angle)`

Adds the values of the argument angle to the orignal angle. 

This functions the same as angle1 + angle2 without creating a new angle object, skipping object construction and garbage collection.

**Arguments:**
- `angle` (Angle) — The angle to add.

[wiki](https://wiki.facepunch.com/gmod/Angle:Add)

---

### Angle:Div · Shared, Menu
`Angle:Div(scalar: number)`

Divides all values of the original angle by a scalar. This functions the same as angle1 / num without creating a new angle object, skipping object construction and garbage collection.

**Arguments:**
- `scalar` (number) — The number to divide by.

[wiki](https://wiki.facepunch.com/gmod/Angle:Div)

---

### Angle:Forward · Shared, Menu
`Angle:Forward() → Vector`

Returns a normal vector facing in the direction that the angle points.

**Returns:**
- Vector — The forward direction of the angle

[wiki](https://wiki.facepunch.com/gmod/Angle:Forward)

---

### Angle:IsEqualTol · Shared, Menu
`Angle:IsEqualTol(compare: Angle, tolerance: number) → boolean`

Returns if the angle is equal to another angle with the given tolerance.

**Arguments:**
- `compare` (Angle) — The angle to compare to.
- `tolerance` (number) — The tolerance range for each component.

**Returns:**
- `eq` (boolean) — Are each of the the angle components equal or not within given tolerance.

[wiki](https://wiki.facepunch.com/gmod/Angle:IsEqualTol)

---

### Angle:IsZero · Shared, Menu
`Angle:IsZero() → boolean`

Returns whether the pitch, yaw and roll are 0 or not.

**Returns:**
- boolean — Whether the pitch, yaw and roll are 0 or not.

[wiki](https://wiki.facepunch.com/gmod/Angle:IsZero)

---

### Angle:Mul · Shared, Menu
`Angle:Mul(scalar: number)`

Multiplies a scalar to all the values of the orignal angle. This functions the same as num * angle without creating a new angle object, skipping object construction and garbage collection.

**Arguments:**
- `scalar` (number) — The number to multiply.

[wiki](https://wiki.facepunch.com/gmod/Angle:Mul)

---

### Angle:Normalize · Shared, Menu
`Angle:Normalize()`

Normalizes the angles by applying a modulo with 360 to pitch, yaw and roll.

[wiki](https://wiki.facepunch.com/gmod/Angle:Normalize)

---

### Angle:Random · Shared, Menu
`Angle:Random(min: number = -360, max: number = 360)`

Randomizes each element of this Angle object.

**Arguments:**
- `min` (number, default `-360`) — The minimum value for each component.
- `max` (number, default `360`) — The maximum value for each component.

[wiki](https://wiki.facepunch.com/gmod/Angle:Random)

---

### Angle:Right · Shared, Menu
`Angle:Right() → Vector`

Returns a normal vector facing in the direction that points right relative to the angle's direction.

**Returns:**
- Vector — The right direction of the angle

[wiki](https://wiki.facepunch.com/gmod/Angle:Right)

---

### Angle:RotateAroundAxis · Shared, Menu
`Angle:RotateAroundAxis(axis: Vector, rotation: number)`

Rotates the angle around the specified axis by the specified degrees.

**Arguments:**
- `axis` (Vector) — The axis to rotate around as a normalized unit vector.
- `rotation` (number) — The degrees to rotate around the specified axis.

[wiki](https://wiki.facepunch.com/gmod/Angle:RotateAroundAxis)

---

### Angle:Set · Shared, Menu
`Angle:Set(originalAngle: Angle)`

Copies pitch, yaw and roll from the second angle to the first.

**Arguments:**
- `originalAngle` (Angle) — The angle to copy the values from.

[wiki](https://wiki.facepunch.com/gmod/Angle:Set)

---

### Angle:SetUnpacked · Shared, Menu
`Angle:SetUnpacked(p: number, y: number, r: number)`

Sets the p, y, and r of the angle.

**Arguments:**
- `p` (number) — The pitch component of the Angle
- `y` (number) — The yaw component of the Angle
- `r` (number) — The roll component of the Angle

[wiki](https://wiki.facepunch.com/gmod/Angle:SetUnpacked)

---

### Angle:SnapTo · Shared
`Angle:SnapTo(axis: string, target: number) → Angle`

Snaps the angle to nearest interval of degrees.

**Arguments:**
- `axis` (string) — The component/axis to snap.
- `target` (number) — The target angle snap interval

**Returns:**
- Angle — The snapped angle.

> **Note:** This will modify the original angle too!

[wiki](https://wiki.facepunch.com/gmod/Angle:SnapTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/angle.lua#L5-L18)

---

### Angle:Sub · Shared, Menu
`Angle:Sub(angle: Angle)`

Subtracts the values of the argument angle to the orignal angle. This functions the same as angle1 - angle2 without creating a new angle object, skipping object construction and garbage collection.

**Arguments:**
- `angle` (Angle) — The angle to subtract.

[wiki](https://wiki.facepunch.com/gmod/Angle:Sub)

---

### Angle:ToTable · Shared, Menu
`Angle:ToTable() → table`

Returns the angle as a table with three elements.

**Returns:**
- table — The table with elements 1 = p, 2 = y, 3 = r.

[wiki](https://wiki.facepunch.com/gmod/Angle:ToTable)

---

### Angle:Unpack · Shared, Menu
`Angle:Unpack() → number, number, number`

Returns the pitch, yaw, and roll components of the angle.

**Returns:**
- number — p, pitch, x, or Angle[1].
- number — y, yaw, or Angle[2].
- number — r, roll, r, or Angle[3].

[wiki](https://wiki.facepunch.com/gmod/Angle:Unpack)

---

### Angle:Up · Shared, Menu
`Angle:Up() → Vector`

Returns a normal vector facing in the direction that points up relative to the angle's direction.

**Returns:**
- Vector — The up direction of the angle.

[wiki](https://wiki.facepunch.com/gmod/Angle:Up)

---

### Angle:Zero · Shared, Menu
`Angle:Zero()`

Sets pitch, yaw and roll to 0.
This function is faster than doing it manually.

[wiki](https://wiki.facepunch.com/gmod/Angle:Zero)
