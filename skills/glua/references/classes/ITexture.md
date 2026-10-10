# ITexture

**Realm:** Shared, Menu  ·  **Members:** 10

An object representing game texture, such as those loaded from a `.vtf` file.

Do not confuse with [IMaterial](https://wiki.facepunch.com/gmod/IMaterial). Materials use textures. Game uses materials.

Returned by [IMaterial:GetTexture](https://wiki.facepunch.com/gmod/IMaterial:GetTexture)

[wiki page](https://wiki.facepunch.com/gmod/ITexture)

### ITexture:Download · Shared, Menu
`ITexture:Download()`

Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.

[wiki](https://wiki.facepunch.com/gmod/ITexture:Download)

---

### ITexture:GetColor · Shared, Menu
`ITexture:GetColor(x: number, y: number) → Color`

Returns the color of the specified pixel, only works for textures created from PNG files.

**Arguments:**
- `x` (number) — The X coordinate.
- `y` (number) — The Y coordinate.

**Returns:**
- Color — The color of the pixel as a Color.

[wiki](https://wiki.facepunch.com/gmod/ITexture:GetColor)

---

### ITexture:GetMappingHeight · Shared, Menu
`ITexture:GetMappingHeight() → number`

Returns the true unmodified height of the texture.

**Returns:**
- number — height

[wiki](https://wiki.facepunch.com/gmod/ITexture:GetMappingHeight)

---

### ITexture:GetMappingWidth · Shared, Menu
`ITexture:GetMappingWidth() → number`

Returns the true unmodified width of the texture.

**Returns:**
- number — width

[wiki](https://wiki.facepunch.com/gmod/ITexture:GetMappingWidth)

---

### ITexture:GetName · Shared, Menu
`ITexture:GetName() → string`

Returns the name of the texture, in most cases the path.

**Returns:**
- string — name

[wiki](https://wiki.facepunch.com/gmod/ITexture:GetName)

---

### ITexture:GetNumAnimationFrames · Shared, Menu
`ITexture:GetNumAnimationFrames() → number`

Returns the number of animation frames in this texture.

**Returns:**
- number — The number of animation frames in this texture.

[wiki](https://wiki.facepunch.com/gmod/ITexture:GetNumAnimationFrames)

---

### ITexture:Height · Shared, Menu
`ITexture:Height() → number`

Returns the modified height of the texture, this value may be affected by mipmapping and other factors.

**Returns:**
- number — height

[wiki](https://wiki.facepunch.com/gmod/ITexture:Height)

---

### ITexture:IsError · Shared, Menu
`ITexture:IsError() → boolean`

Returns whenever the texture is valid. (i.e. was loaded successfully or not)

**Returns:**
- boolean — Whether the texture was loaded successfully or not.

> **Note:** The "error" texture is a valid texture, and therefore this function will return false when used on it. Use [ITexture:IsErrorTexture](https://wiki.facepunch.com/gmod/ITexture:IsErrorTexture), instead.

[wiki](https://wiki.facepunch.com/gmod/ITexture:IsError)

---

### ITexture:IsErrorTexture · Shared, Menu
`ITexture:IsErrorTexture() → boolean`

Returns whenever the texture is the error texture (pink and black checkerboard pattern).

**Returns:**
- boolean — Whether the texture is the error texture or not.

[wiki](https://wiki.facepunch.com/gmod/ITexture:IsErrorTexture)

---

### ITexture:Width · Shared, Menu
`ITexture:Width() → number`

Returns the modified width of the texture, this value may be affected by mipmapping and other factors.

**Returns:**
- number — width

[wiki](https://wiki.facepunch.com/gmod/ITexture:Width)
