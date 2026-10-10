# DSprite

**Realm:** Client  ·  **Members:** 8  ·  **Inherits:** `DPanel`

A panel that draws a sprite on the player's HUD with the given [IMaterial](https://wiki.facepunch.com/gmod/IMaterial), [Color](https://wiki.facepunch.com/gmod/Global.Color) and rotation.

A shortcut for this is [CreateSprite](https://wiki.facepunch.com/gmod/Global.CreateSprite)().

[wiki page](https://wiki.facepunch.com/gmod/DSprite)

### DSprite:GetColor · Client
`DSprite:GetColor() → Color`

Gets the color the sprite is using as a modifier.

**Returns:**
- Color — The Color being used.

[wiki](https://wiki.facepunch.com/gmod/DSprite:GetColor)

---

### DSprite:GetHandle · Client · `DEPRECATED`
`DSprite:GetHandle() → Vector`

Returns the value set by [DSprite:SetHandle](https://wiki.facepunch.com/gmod/DSprite:SetHandle)

**Returns:**
- Vector

[wiki](https://wiki.facepunch.com/gmod/DSprite:GetHandle)

---

### DSprite:GetMaterial · Client
`DSprite:GetMaterial() → IMaterial`

Gets the material the sprite is using.

**Returns:**
- IMaterial — The material in use.

[wiki](https://wiki.facepunch.com/gmod/DSprite:GetMaterial)

---

### DSprite:GetRotation · Client
`DSprite:GetRotation() → number`

Gets the 2D rotation angle of the sprite, in the plane of the screen.

**Returns:**
- number — The anti-clockwise rotation in degrees.

[wiki](https://wiki.facepunch.com/gmod/DSprite:GetRotation)

---

### DSprite:SetColor · Client
`DSprite:SetColor(color: Color)`

Sets the color modifier for the sprite.

**Arguments:**
- `color` (Color) — The Color to use.

[wiki](https://wiki.facepunch.com/gmod/DSprite:SetColor)

---

### DSprite:SetHandle · Client · `DEPRECATED`
`DSprite:SetHandle(vec: Vector)`

Seems to be an unused feature. Does nothing.

**Arguments:**
- `vec` (Vector)

[wiki](https://wiki.facepunch.com/gmod/DSprite:SetHandle)

---

### DSprite:SetMaterial · Client
`DSprite:SetMaterial(material: IMaterial)`

Sets the source material for the sprite.

**Arguments:**
- `material` (IMaterial) — The material to use.

[wiki](https://wiki.facepunch.com/gmod/DSprite:SetMaterial)

---

### DSprite:SetRotation · Client
`DSprite:SetRotation(ang: number)`

Sets the 2D rotation angle of the sprite, in the plane of the screen.

**Arguments:**
- `ang` (number) — The anti-clockwise rotation in degrees.

[wiki](https://wiki.facepunch.com/gmod/DSprite:SetRotation)
