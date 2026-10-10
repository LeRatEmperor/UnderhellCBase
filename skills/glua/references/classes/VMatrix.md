# VMatrix

**Realm:** Shared  ·  **Members:** 35

A 4x4 matrix.

This page lists all possible functions to manipulate matrices.

This object can be created by [Matrix](https://wiki.facepunch.com/gmod/Global.Matrix).

Metamethod | Second Operand | Description
---------- | -------------- | -----------
`__add` | [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) | Returns new [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) with the result of addition.
`__eq` | [any](https://wiki.facepunch.com/gmod/any) | Compares 2 operands, if they both are [VMatrix](https://wiki.facepunch.com/gmod/VMatrix), compares each individual component.
`__mul` | [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) or [Vector](https://wiki.facepunch.com/gmod/Vector) | Returns new [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) or [Vector](https://wiki.facepunch.com/gmod/Vector) with the result of multiplication.
`__sub` | [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) | Returns new [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) with the result of subtraction.
`__tostring` |  | Returns a [string](https://wiki.facepunch.com/gmod/string) in format `[%f,\t%f,\t%f,\t%f]\n[%f,\t%f,\t%f,\t%f]\n[%f,\t%f,\t%f,\t%f]\n[%f,\t%f,\t%f,\t%f]`.
`__unm` | | Returns new [VMatrix](https://wiki.facepunch.com/gmod/VMatrix) with the result of negation.

[wiki page](https://wiki.facepunch.com/gmod/VMatrix)

### VMatrix:Add · Shared
`VMatrix:Add(input: VMatrix)`

Adds given matrix to this matrix.

**Arguments:**
- `input` (VMatrix) — The input matrix to add.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Add)

---

### VMatrix:GetAngles · Shared
`VMatrix:GetAngles() → Angle`

Returns the absolute rotation of the matrix. Scaled matrix might produce unexpected results!

**Returns:**
- Angle — Absolute rotation of the matrix

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetAngles)

---

### VMatrix:GetField · Shared
`VMatrix:GetField(row: number, column: number) → number`

Returns a specific field in the matrix.

**Arguments:**
- `row` (number) — Row of the field whose value is to be retrieved, from 1 to 4
- `column` (number) — Column of the field whose value is to be retrieved, from 1 to 4

**Returns:**
- number — The value of the specified field

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetField)

---

### VMatrix:GetForward · Shared
`VMatrix:GetForward() → Vector`

Gets the forward direction of the matrix.

ie. The first column of the matrix, excluding the w coordinate.

**Returns:**
- Vector — The forward direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetForward)

---

### VMatrix:GetInverse · Shared
`VMatrix:GetInverse() → VMatrix`

Returns an inverted matrix without modifying the original matrix.

Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)

See also [VMatrix:GetInverseTR](https://wiki.facepunch.com/gmod/VMatrix:GetInverseTR).

**Returns:**
- VMatrix — The inverted matrix if possible, nil otherwise

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetInverse)

---

### VMatrix:GetInverseTR · Shared
`VMatrix:GetInverseTR() → VMatrix`

Returns an inverted matrix without modifying the original matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.

Using this function on a matrix with modified scale may return an incorrect inverted matrix.

To get the inverse of a matrix that contains other modifications, see [VMatrix:GetInverse](https://wiki.facepunch.com/gmod/VMatrix:GetInverse).

**Returns:**
- VMatrix — The inverted matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetInverseTR)

---

### VMatrix:GetRight · Shared
`VMatrix:GetRight() → Vector`

Gets the right direction of the matrix.

ie. The second column of the matrix, negated, excluding the w coordinate.

**Returns:**
- Vector — The right direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetRight)

---

### VMatrix:GetScale · Shared
`VMatrix:GetScale() → Vector`

Returns the absolute scale of the matrix.

**Returns:**
- Vector — Absolute scale of the matrix

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetScale)

---

### VMatrix:GetTranslation · Shared
`VMatrix:GetTranslation() → Vector`

Returns the absolute translation of the matrix.

**Returns:**
- Vector — Absolute translation of the matrix

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetTranslation)

---

### VMatrix:GetTransposed · Shared
`VMatrix:GetTransposed() → VMatrix`

Returns the transpose (each row becomes a column) of this matrix.

**Returns:**
- `transposed` (VMatrix) — The transposed matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetTransposed)

---

### VMatrix:GetUp · Shared
`VMatrix:GetUp() → Vector`

Gets the up direction of the matrix.

ie. The third column of the matrix, excluding the w coordinate.

**Returns:**
- Vector — The up direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:GetUp)

---

### VMatrix:Identity · Shared
`VMatrix:Identity()`

Initializes the matrix as Identity matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Identity)

---

### VMatrix:Invert · Shared
`VMatrix:Invert() → boolean`

Inverts the matrix.

Inverting the matrix will fail if its [determinant](https://en.wikipedia.org/wiki/Determinant) is 0 or close to 0. (ie. its "scale" in any direction is 0.)

If the matrix cannot be inverted, it does not get modified.

See also [VMatrix:InvertTR](https://wiki.facepunch.com/gmod/VMatrix:InvertTR).

**Returns:**
- boolean — Whether the matrix was inverted or not

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Invert)

---

### VMatrix:InvertTR · Shared
`VMatrix:InvertTR()`

Quickly inverts the matrix. This function will not fail, but only works correctly on matrices that contain only translation and/or rotation.

Using this function on a matrix with modified scale may return an incorrect inverted matrix.

To invert a matrix that contains other modifications, see [VMatrix:Invert](https://wiki.facepunch.com/gmod/VMatrix:Invert). This function is faster.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:InvertTR)

---

### VMatrix:IsIdentity · Shared
`VMatrix:IsIdentity() → boolean`

Returns whether the matrix is equal to Identity matrix or not.

**Returns:**
- boolean — Is the matrix an Identity matrix or not

[wiki](https://wiki.facepunch.com/gmod/VMatrix:IsIdentity)

---

### VMatrix:IsRotationMatrix · Shared
`VMatrix:IsRotationMatrix() → boolean`

Returns whether the matrix is a rotation matrix or not.

Technically it checks if the forward, right and up vectors are orthogonal and normalized.

**Returns:**
- boolean — Is the matrix a rotation matrix or not

[wiki](https://wiki.facepunch.com/gmod/VMatrix:IsRotationMatrix)

---

### VMatrix:IsZero · Shared
`VMatrix:IsZero() → boolean`

Checks whenever all fields of the matrix are 0, aka if this is a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).

**Returns:**
- boolean — If the matrix is a null matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:IsZero)

---

### VMatrix:Mul · Shared
`VMatrix:Mul(input: VMatrix)`

Multiplies this matrix by given matrix.

**Arguments:**
- `input` (VMatrix) — The input matrix to multiply by.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Mul)

---

### VMatrix:Rotate · Shared
`VMatrix:Rotate(rotation: Angle)`

Rotates the matrix by the given angle.

Postmultiplies the matrix by a rotation matrix (A = AR).

**Arguments:**
- `rotation` (Angle) — Rotation.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Rotate)

---

### VMatrix:Scale · Shared
`VMatrix:Scale(scale: Vector)`

Scales the matrix by the given vector.

Postmultiplies the matrix by a scaling matrix (A = AS).

**Arguments:**
- `scale` (Vector) — Vector to scale with matrix with.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Scale)

---

### VMatrix:ScaleTranslation · Shared
`VMatrix:ScaleTranslation(scale: number)`

Scales the absolute translation with the given value.

**Arguments:**
- `scale` (number) — Value to scale the translation with.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:ScaleTranslation)

---

### VMatrix:Set · Shared
`VMatrix:Set(src: VMatrix)`

Copies values from the given matrix object.

**Arguments:**
- `src` (VMatrix) — The matrix to copy values from.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Set)

---

### VMatrix:SetAngles · Shared
`VMatrix:SetAngles(angle: Angle)`

Sets the absolute rotation of the matrix.

**Arguments:**
- `angle` (Angle) — New angles.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetAngles)

---

### VMatrix:SetField · Shared
`VMatrix:SetField(row: number, column: number, value: number)`

Sets a specific field in the matrix.

**Arguments:**
- `row` (number) — Row of the field to be set, from 1 to 4
- `column` (number) — Column of the field to be set, from 1 to 4
- `value` (number) — The value to set in that field

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetField)

---

### VMatrix:SetForward · Shared
`VMatrix:SetForward(forward: Vector)`

Sets the forward direction of the matrix.

ie. The first column of the matrix, excluding the w coordinate.

**Arguments:**
- `forward` (Vector) — The forward direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetForward)

---

### VMatrix:SetRight · Shared
`VMatrix:SetRight(forward: Vector)`

Sets the right direction of the matrix.

ie. The second column of the matrix, negated, excluding the w coordinate.

**Arguments:**
- `forward` (Vector) — The right direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetRight)

---

### VMatrix:SetScale · Shared
`VMatrix:SetScale(scale: Vector)`

Modifies the scale of the matrix while preserving the rotation and translation.

**Arguments:**
- `scale` (Vector) — The scale to set.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetScale)

---

### VMatrix:SetTranslation · Shared
`VMatrix:SetTranslation(translation: Vector)`

Sets the absolute translation of the matrix.

**Arguments:**
- `translation` (Vector) — New translation.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetTranslation)

---

### VMatrix:SetUnpacked · Shared
`VMatrix:SetUnpacked(e11: number, e12: number, e13: number, e14: number, e21: number, e22: number, e23: number, e24: number, e31: number, e32: number, e33: number, e34: number, e41: number, e42: number, e43: number, e44: number)`

Sets each component of the matrix.

**Arguments:**
- `e11` (number)
- `e12` (number)
- `e13` (number)
- `e14` (number)
- `e21` (number)
- `e22` (number)
- `e23` (number)
- `e24` (number)
- `e31` (number)
- `e32` (number)
- `e33` (number)
- `e34` (number)
- `e41` (number)
- `e42` (number)
- `e43` (number)
- `e44` (number)

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetUnpacked)

---

### VMatrix:SetUp · Shared
`VMatrix:SetUp(forward: Vector)`

Sets the up direction of the matrix.

ie. The third column of the matrix, excluding the w coordinate.

**Arguments:**
- `forward` (Vector) — The up direction of the matrix.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:SetUp)

---

### VMatrix:Sub · Shared
`VMatrix:Sub(input: VMatrix)`

Subtracts given matrix from this matrix.

**Arguments:**
- `input` (VMatrix) — The input matrix to subtract.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Sub)

---

### VMatrix:ToTable · Shared
`VMatrix:ToTable() → table`

Converts the matrix to a 4x4 table. See [Matrix](https://wiki.facepunch.com/gmod/Global.Matrix) function.

**Returns:**
- table — The 4x4 table.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:ToTable)

---

### VMatrix:Translate · Shared
`VMatrix:Translate(translation: Vector)`

Translates the matrix by the given vector aka. adds the vector to the translation.

Postmultiplies the matrix by a translation matrix (A = AT).

**Arguments:**
- `translation` (Vector) — Vector to translate the matrix by.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Translate)

---

### VMatrix:Unpack · Shared
`VMatrix:Unpack() → number, number, number, number, number, number, number, number, number, number, number, number, number, number, number, number`

Returns each component of the matrix, expanding rows before columns.

**Returns:**
- number — VMatrix:GetField(1, 1)
- number — VMatrix:GetField(1, 2)
- number — VMatrix:GetField(1, 3)
- number — VMatrix:GetField(1, 4)
- number — VMatrix:GetField(2, 1)
- number — VMatrix:GetField(2, 2)
- number — VMatrix:GetField(2, 3)
- number — VMatrix:GetField(2, 4)
- number — VMatrix:GetField(3, 1)
- number — VMatrix:GetField(3, 2)
- number — VMatrix:GetField(3, 3)
- number — VMatrix:GetField(3, 4)
- number — VMatrix:GetField(4, 1)
- number — VMatrix:GetField(4, 2)
- number — VMatrix:GetField(4, 3)
- number — VMatrix:GetField(4, 4)

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Unpack)

---

### VMatrix:Zero · Shared
`VMatrix:Zero()`

Sets all components of the matrix to 0, also known as a [null matrix](https://en.wikipedia.org/wiki/Zero_matrix).

This function is more efficient than setting each element manually.

[wiki](https://wiki.facepunch.com/gmod/VMatrix:Zero)
