# IMaterial

**Realm:** Shared, Menu  ·  **Members:** 26

A Material object. It represents a game material, similarly to how a `.vmt` file does, which are in fact loaded into an **IMaterial** object.

In most cases the game works with materials as far as file paths go. Materials then point to different [ITexture](https://wiki.facepunch.com/gmod/ITexture)s (`.vtf` files) they might be using.  
They are not the same and cannot be interchanged.

A material object can be created with [Material](https://wiki.facepunch.com/gmod/Global.Material) or [CreateMaterial](https://wiki.facepunch.com/gmod/Global.CreateMaterial).

[wiki page](https://wiki.facepunch.com/gmod/IMaterial)

### IMaterial:GetColor · Shared, Menu
`IMaterial:GetColor(x: number, y: number) → Color`

Returns the color of the specified pixel of the `$basetexture`, only works for materials created from PNG files.

Basically identical to [ITexture:GetColor](https://wiki.facepunch.com/gmod/ITexture:GetColor) used on [IMaterial:GetTexture](https://wiki.facepunch.com/gmod/IMaterial:GetTexture)`( "$basetexture" )`.

**Arguments:**
- `x` (number) — The X coordinate.
- `y` (number) — The Y coordinate.

**Returns:**
- Color — The color of the pixel as a Color.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetColor)

---

### IMaterial:GetFloat · Shared, Menu
`IMaterial:GetFloat(materialFloat: string) → number`

Returns the specified material value as a float, or nil if the value is not set.

**Arguments:**
- `materialFloat` (string) — The name of the material value.

**Returns:**
- number — float

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetFloat)

---

### IMaterial:GetInt · Shared, Menu
`IMaterial:GetInt(materialInt: string) → number`

Returns the specified material value as a int, rounds the value if its a float, or nil if the value is not set.

**Arguments:**
- `materialInt` (string) — The name of the material integer.

**Returns:**
- number — The retrieved value as an integer

> **Note:** Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly retrieved with this function. See the full list here: [Material Flags](https://wiki.facepunch.com/gmod/Material%20Flags)

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetInt)

---

### IMaterial:GetKeyValues · Shared
`IMaterial:GetKeyValues() → table<string, any>`

Gets all the key values defined for the material.

**Returns:**
- table<string, any> — The material's key values.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetKeyValues)

---

### IMaterial:GetMatrix · Shared
`IMaterial:GetMatrix(materialMatrix: string) → VMatrix`

Returns the specified material matrix as a int, or nil if the value is not set or is not a matrix.

**Arguments:**
- `materialMatrix` (string) — The name of the material matrix.

**Returns:**
- VMatrix — matrix

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetMatrix)

---

### IMaterial:GetName · Shared, Menu
`IMaterial:GetName() → string`

Returns the name of the material, in most cases the path.

**Returns:**
- string — Material name/path

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetName)

---

### IMaterial:GetShader · Shared, Menu
`IMaterial:GetShader() → string`

Returns the name of the materials shader.

**Returns:**
- string — Name of the currently loaded shader for this material, or `shader_error` if the material has no loaded shader.

> **Bug** ([#3256](https://github.com/Facepunch/garrysmod/issues/3256)): This function does not work serverside on Linux SRCDS and always returns `shader_error`.
> 
> This bug is fixed on `dev` beta and in the next update.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetShader)

---

### IMaterial:GetString · Shared, Menu
`IMaterial:GetString(materialString: string) → string`

Returns the specified material string, or nil if the value is not set or if the value can not be converted to a string.

**Arguments:**
- `materialString` (string) — The name of the material string.

**Returns:**
- string — The value as a string

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetString)

---

### IMaterial:GetTexture · Shared, Menu
`IMaterial:GetTexture(param: string) → ITexture`

Returns an [ITexture](https://wiki.facepunch.com/gmod/ITexture) based on the passed shader parameter.

**Arguments:**
- `param` (string) — The shader parameter to retrieve.

**Returns:**
- ITexture — The value of the shader parameter.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetTexture)

---

### IMaterial:GetVector · Shared, Menu
`IMaterial:GetVector(materialVector: string) → Vector`

Returns the specified material vector, or nil if the value is not set.

See also [IMaterial:GetVectorLinear](https://wiki.facepunch.com/gmod/IMaterial:GetVectorLinear)

**Arguments:**
- `materialVector` (string) — The name of the material vector.

**Returns:**
- Vector — The color vector

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetVector)

---

### IMaterial:GetVector4D · Shared, Menu
`IMaterial:GetVector4D(name: string) → number, number, number, number`

Returns the specified material vector as a 4 component vector.

**Arguments:**
- `name` (string) — The name of the material vector to retrieve.

**Returns:**
- `x` (number) — The x component of the vector.
- `y` (number) — The y component of the vector.
- `z` (number) — The z component of the vector.
- `w` (number) — The w component of the vector.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetVector4D)

---

### IMaterial:GetVectorLinear · Shared, Menu
`IMaterial:GetVectorLinear(materialVector: string) → Vector`

Returns the specified material linear color vector, or nil if the value is not set.

See https://en.wikipedia.org/wiki/Gamma_correction

See also [IMaterial:GetVector](https://wiki.facepunch.com/gmod/IMaterial:GetVector)

**Arguments:**
- `materialVector` (string) — The name of the material vector.

**Returns:**
- Vector — The linear color vector

[wiki](https://wiki.facepunch.com/gmod/IMaterial:GetVectorLinear)

---

### IMaterial:Height · Shared, Menu
`IMaterial:Height() → number`

Returns the height of the member texture set for `$basetexture`.

**Returns:**
- number — Height of the base texture.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:Height)

---

### IMaterial:IsError · Shared, Menu
`IMaterial:IsError() → boolean`

Returns whenever the material is valid, i.e. whether it was not loaded successfully from disk or not.

**Returns:**
- boolean — Is this material the error material?

[wiki](https://wiki.facepunch.com/gmod/IMaterial:IsError)

---

### IMaterial:Recompute · Shared, Menu
`IMaterial:Recompute()`

Recomputes the material's snapshot. This needs to be called if you have changed variables on your material and it isn't changing. 

Be careful though - this function is slow - so try to call it only when needed!

[wiki](https://wiki.facepunch.com/gmod/IMaterial:Recompute)

---

### IMaterial:SetDynamicImage · Menu · `INTERNAL`
`IMaterial:SetDynamicImage(path: string)`

Changes the Material into the give Image.

**Arguments:**
- `path` (string) — The path to a Image.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetDynamicImage)

---

### IMaterial:SetFloat · Shared, Menu
`IMaterial:SetFloat(materialFloat: string, float: number)`

Sets the specified material float to the specified float, does nothing on a type mismatch.

Unlike [IMaterial:SetInt](https://wiki.facepunch.com/gmod/IMaterial:SetInt), this function **does not** call [IMaterial:Recompute](https://wiki.facepunch.com/gmod/IMaterial:Recompute) internally.

**Arguments:**
- `materialFloat` (string) — The name of the material float.
- `float` (number) — The new float value.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetFloat)

---

### IMaterial:SetInt · Shared, Menu
`IMaterial:SetInt(materialInt: string, int: number)`

Sets the specified material value to the specified int, does nothing on a type mismatch.

Calls [IMaterial:Recompute](https://wiki.facepunch.com/gmod/IMaterial:Recompute) internally.

**Arguments:**
- `materialInt` (string) — The name of the material int.
- `int` (number) — The new int value.

> **Note:** Please note that certain material flags such as `$model` are stored in the `$flags` variable and cannot be directly set with this function. See the full list here: [Material Flags](https://wiki.facepunch.com/gmod/Material%20Flags)

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetInt)

---

### IMaterial:SetMatrix · Shared
`IMaterial:SetMatrix(materialMatrix: string, matrix: VMatrix)`

Sets the specified material value to the specified matrix, does nothing on a type mismatch.

**Arguments:**
- `materialMatrix` (string) — The name of the material int.
- `matrix` (VMatrix) — The new matrix.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetMatrix)

---

### IMaterial:SetShader · Shared, Menu · `DEPRECATED`
`IMaterial:SetShader(shaderName: string)`

The functionality of this function was removed due to the amount of crashes it caused.

**Arguments:**
- `shaderName` (string) — Name of the shader

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetShader)

---

### IMaterial:SetString · Shared, Menu
`IMaterial:SetString(materialString: string, string: string)`

Sets the specified material value to the specified string, does nothing on a type mismatch.

**Arguments:**
- `materialString` (string) — The name of the material string.
- `string` (string) — The new string.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetString)

---

### IMaterial:SetTexture · Shared, Menu
`IMaterial:SetTexture(materialTexture: string, texture: ITexture)`

Sets the specified material texture to the specified texture, does nothing on a type mismatch.

Calls [IMaterial:Recompute](https://wiki.facepunch.com/gmod/IMaterial:Recompute) internally.

**Arguments:**
- `materialTexture` (string) — The name of the keyvalue on the material to store the texture on.
- `texture` (ITexture) — The new texture.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetTexture)

---

### IMaterial:SetUndefined · Shared, Menu
`IMaterial:SetUndefined(materialValueName: string)`

Unsets the value for the specified material value.

**Arguments:**
- `materialValueName` (string) — The name of the material value to be unset.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetUndefined)

---

### IMaterial:SetVector · Shared, Menu
`IMaterial:SetVector(MaterialVector: string, vec: Vector)`

Sets the specified material vector to the specified vector, does nothing on a type mismatch.

**Arguments:**
- `MaterialVector` (string) — The name of the material vector.
- `vec` (Vector) — The new vector.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetVector)

---

### IMaterial:SetVector4D · Shared, Menu
`IMaterial:SetVector4D(name: string, x: number, y: number, z: number, w: number)`

Sets the specified material vector to the specified 4 component vector, does nothing on a type mismatch.

**Arguments:**
- `name` (string) — The name of the material vector.
- `x` (number) — The x component of the new vector.
- `y` (number) — The y component of the new vector.
- `z` (number) — The z component of the new vector.
- `w` (number) — The w component of the new vector.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:SetVector4D)

---

### IMaterial:Width · Shared, Menu
`IMaterial:Width() → number`

Returns the width of the member texture set for `$basetexture`.

**Returns:**
- number — Width of the base texture.

[wiki](https://wiki.facepunch.com/gmod/IMaterial:Width)
