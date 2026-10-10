# Vector

**Realm:** Shared, Menu  ·  **Members:** 34

List of all possible functions to manipulate vectors.

Created by [Vector](https://wiki.facepunch.com/gmod/Global.Vector).

 Type   | Name           | Description                    
 ------ | -------------- | ------------------------------ 
 [number](https://wiki.facepunch.com/gmod/number) | `x`, `X`, `r` or `1` | The X component of the vector. 
 [number](https://wiki.facepunch.com/gmod/number) | `y`, `Y`, `g` or `2` | The Y component of the vector. 
 [number](https://wiki.facepunch.com/gmod/number) | `z`, `Z`, `b` or `3` | The Z component of the vector.

Metamethod | Second Operand | Description
---------- | -------------- | -----------
`__add` | [Vector](https://wiki.facepunch.com/gmod/Vector) | Returns new [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of addition.
`__div` | [number](https://wiki.facepunch.com/gmod/number) or [Vector](https://wiki.facepunch.com/gmod/Vector) | Returns new [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of division.
`__eq` | [any](https://wiki.facepunch.com/gmod/any) | Compares 2 operands, if they both are [Vector](https://wiki.facepunch.com/gmod/Vector), compares each individual component.
`__index` | [number](https://wiki.facepunch.com/gmod/number) or [string](https://wiki.facepunch.com/gmod/string) | Gets the component of the [Vector](https://wiki.facepunch.com/gmod/Vector). Returns a [number](https://wiki.facepunch.com/gmod/number).
`__mul` | [number](https://wiki.facepunch.com/gmod/number) or [Vector](https://wiki.facepunch.com/gmod/Vector)| Returns new [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of multiplication.
`__newindex` | [number](https://wiki.facepunch.com/gmod/number) or [string](https://wiki.facepunch.com/gmod/string) | Sets the component of the [Vector](https://wiki.facepunch.com/gmod/Vector). Accepts [number](https://wiki.facepunch.com/gmod/number) and [string](https://wiki.facepunch.com/gmod/string).
`__sub` | [Vector](https://wiki.facepunch.com/gmod/Vector) | Returns new [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of subtraction.
`__tostring` | | Returns `x y z`.
`__unm` | | Returns new [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of negation.

[wiki page](https://wiki.facepunch.com/gmod/Vector)

### Vector:Add · Shared, Menu
`Vector:Add(vector: Vector)`

Adds the values of the argument vector to the original vector. This function is the same as vector1 + vector2 without creating a new vector object, skipping object construction and garbage collection.

**Arguments:**
- `vector` (Vector) — The vector to add.

[wiki](https://wiki.facepunch.com/gmod/Vector:Add)

---

### Vector:Angle · Shared, Menu
`Vector:Angle() → Angle`

Returns an angle representing the normal of the vector.

**Returns:**
- Angle — The angle/direction of the vector.

[wiki](https://wiki.facepunch.com/gmod/Vector:Angle)

---

### Vector:AngleEx · Shared, Menu
`Vector:AngleEx(up: Vector) → Angle`

Returns the angle of this vector (normalized), but instead of assuming that up is [Vector](https://wiki.facepunch.com/gmod/Global.Vector)( 0, 0, 1 ) (Like [Vector:Angle](https://wiki.facepunch.com/gmod/Vector:Angle) does) you can specify which direction is 'up' for the angle.

**Arguments:**
- `up` (Vector) — The up direction vector

**Returns:**
- Angle — The angle

[wiki](https://wiki.facepunch.com/gmod/Vector:AngleEx)

---

### Vector:Cross · Shared, Menu
`Vector:Cross(otherVector: Vector) → Vector`

Calculates the cross product of this vector and the passed one.

The cross product of two vectors is a 3-dimensional vector with a direction perpendicular (at right angles) to both of them (according to the [right-hand rule](https://en.wikipedia.org/wiki/Right-hand_rule)), and magnitude equal to the area of parallelogram they span. This is defined as the product of the magnitudes, the sine of the angle between them, and unit (normal) vector `n` defined by the right-hand rule:
:**a** × **b** = |**a**| |**b**| sin(θ) **n̂**
where **a** and **b** are vectors, and **n̂** is a unit vector (magnitude of 1) perpendicular to both.

**Arguments:**
- `otherVector` (Vector) — Vector to calculate the cross product with.

**Returns:**
- Vector — The cross product of the two vectors.

[wiki](https://wiki.facepunch.com/gmod/Vector:Cross)

---

### Vector:Distance · Shared, Menu
`Vector:Distance(otherVector: Vector) → number`

Returns the Euclidean distance between the vector and the other vector.

**Arguments:**
- `otherVector` (Vector) — The vector to get the distance to.

**Returns:**
- number — Distance between the vectors.

> **Note:** This function is more expensive than [Vector:DistToSqr](https://wiki.facepunch.com/gmod/Vector:DistToSqr). However, please see the notes for [Vector:DistToSqr](https://wiki.facepunch.com/gmod/Vector:DistToSqr) before using it as squared distances are not the same as euclidean distances.

[wiki](https://wiki.facepunch.com/gmod/Vector:Distance)

---

### Vector:Distance2D · Shared, Menu
`Vector:Distance2D(otherVector: Vector) → number`

Returns the Euclidean distance between the vector and the other vector in 2D space. The Z axis is ignored.

**Arguments:**
- `otherVector` (Vector) — The vector to get the distance to.

**Returns:**
- number — Distance between the vectors in 2D space.

> **Note:** This function is more expensive than [Vector:Distance2DSqr](https://wiki.facepunch.com/gmod/Vector:Distance2DSqr). However, please see the notes for [Vector:Distance2DSqr](https://wiki.facepunch.com/gmod/Vector:Distance2DSqr) before using it as squared distances are not the same as Euclidean distances.

[wiki](https://wiki.facepunch.com/gmod/Vector:Distance2D)

---

### Vector:Distance2DSqr · Shared, Menu
`Vector:Distance2DSqr(otherVec: Vector) → number`

Returns the squared distance between 2 vectors in 2D space, ignoring the Z axis. This is faster than [Vector:Distance2D](https://wiki.facepunch.com/gmod/Vector:Distance2D) as calculating the square root is an expensive process.

**Arguments:**
- `otherVec` (Vector) — The vector to calculate the distance to.

**Returns:**
- number — Squared distance to the vector in 2D space.

> **Note:** Squared distances should not be summed. If you need to sum distances, use [Vector:Distance2D](https://wiki.facepunch.com/gmod/Vector:Distance2D).
> 
> When performing a distance check, ensure the distance being checked against is squared.

[wiki](https://wiki.facepunch.com/gmod/Vector:Distance2DSqr)

---

### Vector:DistToSqr · Shared, Menu
`Vector:DistToSqr(otherVec: Vector) → number`

Returns the squared distance of 2 vectors, this is quicker to call than [Vector:Distance](https://wiki.facepunch.com/gmod/Vector:Distance) as DistToSqr does not need to calculate the square root, which is an expensive process.

**Arguments:**
- `otherVec` (Vector) — The vector to calculate the distance to.

**Returns:**
- number — Squared distance to the vector.

> **Note:** Squared distances should not be summed. If you need to sum distances, use [Vector:Distance](https://wiki.facepunch.com/gmod/Vector:Distance).
> 
> When performing a distance check, ensure the distance being checked against is squared. See example code below.

[wiki](https://wiki.facepunch.com/gmod/Vector:DistToSqr)

---

### Vector:Div · Shared, Menu
`Vector:Div(divisor: number)`

Divide the vector by the given number, that means x, y and z are divided by that value. This will change the value of the original vector, see example 2 for division without changing the value.

**Arguments:**
- `divisor` (number) — The value to divide the vector with.

[wiki](https://wiki.facepunch.com/gmod/Vector:Div)

---

### Vector:Dot · Shared, Menu
`Vector:Dot(otherVector: Vector) → number`

Returns the [dot product](https://en.wikipedia.org/wiki/Dot_product#Geometric_definition)  of this vector and the passed one.

The dot product of two vectors is the product of their magnitudes (lengths), and the cosine of the angle between them:
**a · b** = |**a**| |**b**| cos(θ) 
where **a** and **b** are vectors.
See [Vector:Length](https://wiki.facepunch.com/gmod/Vector:Length) for obtaining magnitudes.

A dot product returns just the cosine of the angle if both vectors are normalized, and zero if the vectors are at right angles to each other.

**Arguments:**
- `otherVector` (Vector) — The vector to calculate the dot product with

**Returns:**
- number — The dot product between the two vectors

[wiki](https://wiki.facepunch.com/gmod/Vector:Dot)

---

### Vector:DotProduct · Shared, Menu · `DEPRECATED`
`Vector:DotProduct(Vector: Vector) → number`

Returns the dot product of the two vectors.

**Arguments:**
- `Vector` (Vector) — The other vector.

**Returns:**
- number — Dot Product

[wiki](https://wiki.facepunch.com/gmod/Vector:DotProduct)

---

### Vector:GetNegated · Shared, Menu
`Vector:GetNegated() → Vector`

Returns the negative version of this vector, i.e. a vector with every component to the negative value of itself.

See also [Vector:Negate](https://wiki.facepunch.com/gmod/Vector:Negate).

**Returns:**
- Vector — The negative of this vector.

[wiki](https://wiki.facepunch.com/gmod/Vector:GetNegated)

---

### Vector:GetNormal · Shared, Menu · `DEPRECATED`
`Vector:GetNormal() → Vector`

Returns a normalized version of the vector. This is a alias of [Vector:GetNormalized](https://wiki.facepunch.com/gmod/Vector:GetNormalized).

**Returns:**
- Vector — Normalized version of the vector.

[wiki](https://wiki.facepunch.com/gmod/Vector:GetNormal)

---

### Vector:GetNormalized · Shared, Menu
`Vector:GetNormalized() → Vector`

Returns a normalized version of the vector. Normalized means vector with same direction but with length of 1.

This does not affect the vector you call it on; to do this, use [Vector:Normalize](https://wiki.facepunch.com/gmod/Vector:Normalize).

**Returns:**
- Vector — Normalized version of the vector.

[wiki](https://wiki.facepunch.com/gmod/Vector:GetNormalized)

---

### Vector:IsEqualTol · Shared, Menu
`Vector:IsEqualTol(compare: Vector, tolerance: number) → boolean`

Returns if the vector is equal to another vector with the given tolerance.

**Arguments:**
- `compare` (Vector) — The vector to compare to.
- `tolerance` (number) — The tolerance range.

**Returns:**
- boolean — Are the vectors equal or not.

[wiki](https://wiki.facepunch.com/gmod/Vector:IsEqualTol)

---

### Vector:IsZero · Shared, Menu
`Vector:IsZero() → boolean`

Checks whenever all fields of the vector are 0.

**Returns:**
- boolean — Do all fields of the vector equal 0 or not

[wiki](https://wiki.facepunch.com/gmod/Vector:IsZero)

---

### Vector:Length · Shared, Menu
`Vector:Length() → number`

Returns the [Euclidean length](https://en.wikipedia.org/wiki/Euclidean_vector#Length) of the vector: √(x² + y² + z²).

**Returns:**
- number — Length of the vector.

> **Warning:** This is a relatively expensive process since it uses the square root. It is recommended that you use [Vector:LengthSqr](https://wiki.facepunch.com/gmod/Vector:LengthSqr) whenever possible.

[wiki](https://wiki.facepunch.com/gmod/Vector:Length)

---

### Vector:Length2D · Shared, Menu
`Vector:Length2D() → number`

Returns the length of the vector in two dimensions, without the Z axis.

**Returns:**
- number — Length of the vector in two dimensions, √(x² + y²)

> **Warning:** This is a relatively expensive process since it uses the square root. It is recommended that you use [Vector:Length2DSqr](https://wiki.facepunch.com/gmod/Vector:Length2DSqr) whenever possible.

[wiki](https://wiki.facepunch.com/gmod/Vector:Length2D)

---

### Vector:Length2DSqr · Shared, Menu
`Vector:Length2DSqr() → number`

Returns the squared length of the vectors x and y value, x² + y².

This is faster than [Vector:Length2D](https://wiki.facepunch.com/gmod/Vector:Length2D) as calculating the square root is an expensive process.

**Returns:**
- number — Squared length of the vector in two dimensions

[wiki](https://wiki.facepunch.com/gmod/Vector:Length2DSqr)

---

### Vector:LengthSqr · Shared, Menu
`Vector:LengthSqr() → number`

Returns the squared length of the vector, x² + y² + z².

This is faster than [Vector:Length](https://wiki.facepunch.com/gmod/Vector:Length) as calculating the square root is an expensive process.

**Returns:**
- number — Squared length of the vector

[wiki](https://wiki.facepunch.com/gmod/Vector:LengthSqr)

---

### Vector:Mul · Shared, Menu
`Vector:Mul(multiplier: number, multiplier: Vector, matrix: VMatrix)`

Scales the vector by the given [number](https://wiki.facepunch.com/gmod/number) (that means x, y and z are multiplied by that value), a [Vector](https://wiki.facepunch.com/gmod/Vector) (X, Y, and Z of each vector are multiplied) or a [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) (Transforms the vector by the matrix's rotation/translation).

**Arguments:**
- `multiplier` (number) — The value to multiply the vector with.
- `multiplier` (Vector) — The vector to multiply the vector with.
- `matrix` (VMatrix) — The matrix to transform the vector by.

[wiki](https://wiki.facepunch.com/gmod/Vector:Mul)

---

### Vector:Negate · Shared, Menu
`Vector:Negate()`

Negates this vector, i.e. sets every component to the negative value of itself. Same as `Vector( -vec.x, -vec.y, -vec.z )`

[wiki](https://wiki.facepunch.com/gmod/Vector:Negate)

---

### Vector:Normalize · Shared, Menu
`Vector:Normalize()`

Normalizes the given vector. This changes the vector you call it on, if you want to return a normalized copy without affecting the original, use [Vector:GetNormalized](https://wiki.facepunch.com/gmod/Vector:GetNormalized).

[wiki](https://wiki.facepunch.com/gmod/Vector:Normalize)

---

### Vector:Random · Shared, Menu
`Vector:Random(min: number = -1, max: number = 1)`

Randomizes each element of this Vector object.

**Arguments:**
- `min` (number, default `-1`) — The minimum value for each component.
- `max` (number, default `1`) — The maximum value for each component.

[wiki](https://wiki.facepunch.com/gmod/Vector:Random)

---

### Vector:Rotate · Shared, Menu
`Vector:Rotate(rotation: Angle)`

Rotates a vector by the given angle.
Doesn't return anything, but rather changes the original vector.

**Arguments:**
- `rotation` (Angle) — The angle to rotate the vector by.

[wiki](https://wiki.facepunch.com/gmod/Vector:Rotate)

---

### Vector:Set · Shared, Menu
`Vector:Set(vector: Vector)`

Copies the values from the second vector to the first vector.

**Arguments:**
- `vector` (Vector) — The vector to copy from.

[wiki](https://wiki.facepunch.com/gmod/Vector:Set)

---

### Vector:SetUnpacked · Shared, Menu
`Vector:SetUnpacked(x: number, y: number, z: number)`

Sets the x, y, and z of the vector.

**Arguments:**
- `x` (number) — The x component
- `y` (number) — The y component
- `z` (number) — The z component

[wiki](https://wiki.facepunch.com/gmod/Vector:SetUnpacked)

---

### Vector:Sub · Shared, Menu
`Vector:Sub(vector: Vector)`

Substracts the values of the second vector from the orignal vector, this function can be used to avoid garbage collection.

**Arguments:**
- `vector` (Vector) — The other vector.

[wiki](https://wiki.facepunch.com/gmod/Vector:Sub)

---

### Vector:ToColor · Shared
`Vector:ToColor() → Color`

Translates the [Vector](https://wiki.facepunch.com/gmod/Vector) (values ranging from 0 to 1) into a [Color](https://wiki.facepunch.com/gmod/Color). This will also range the values from 0 - 1 to 0 - 255.

x * 255 -> r
y * 255 -> g
z * 255 -> b

This is the opposite of [Color:ToVector](https://wiki.facepunch.com/gmod/Color:ToVector)

**Returns:**
- Color — The created Color.

[wiki](https://wiki.facepunch.com/gmod/Vector:ToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/vector.lua#L8-L12)

---

### Vector:ToScreen · Client
`Vector:ToScreen() → table{ToScreenData}`

Returns where on the screen the specified position vector would appear. A related function is [gui.ScreenToVector](https://wiki.facepunch.com/gmod/gui.ScreenToVector), which converts a 2D coordinate to a 3D direction.

**Returns:**
- table{ToScreenData} — The created Structures/ToScreenData.

> **Note:** Should be called from a 3D rendering environment or after [cam.Start3D](https://wiki.facepunch.com/gmod/cam.Start3D) or it may not work correctly.
> **Bug** ([#462](https://github.com/Facepunch/garrysmod/issues/462)): Errors in a render hook can make this value incorrect until the player restarts their game.
> **Bug** ([#1404](https://github.com/Facepunch/garrysmod/issues/1404)): [cam.Start3D](https://wiki.facepunch.com/gmod/cam.Start3D) or 3D context [cam.Start](https://wiki.facepunch.com/gmod/cam.Start) with non-default parameters incorrectly sets the reference FOV for this function, causing incorrect return values. This can be fixed by creating and ending a default 3D context ([cam.Start3D](https://wiki.facepunch.com/gmod/cam.Start3D) with no arguments).

[wiki](https://wiki.facepunch.com/gmod/Vector:ToScreen)

---

### Vector:ToTable · Shared, Menu
`Vector:ToTable() → table`

Returns the vector as a table with three elements.

**Returns:**
- table — The table with elements 1 = x, 2 = y, 3 = z.

[wiki](https://wiki.facepunch.com/gmod/Vector:ToTable)

---

### Vector:Unpack · Shared, Menu
`Vector:Unpack() → number, number, number`

Returns the x, y, and z of the vector.

**Returns:**
- number — x or Vector[1].
- number — y or Vector[2].
- number — z or Vector[3].

[wiki](https://wiki.facepunch.com/gmod/Vector:Unpack)

---

### Vector:WithinAABox · Shared, Menu
`Vector:WithinAABox(boxStart: Vector, boxEnd: Vector) → boolean`

Returns whenever the given vector is in a box created by the 2 other vectors.

**Arguments:**
- `boxStart` (Vector) — The first vector.
- `boxEnd` (Vector) — The second vector.

**Returns:**
- boolean — Is the vector in the box or not.

[wiki](https://wiki.facepunch.com/gmod/Vector:WithinAABox)

---

### Vector:Zero · Shared, Menu
`Vector:Zero()`

Sets x, y and z to 0.

[wiki](https://wiki.facepunch.com/gmod/Vector:Zero)
