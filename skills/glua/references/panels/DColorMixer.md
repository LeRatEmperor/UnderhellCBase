# DColorMixer

**Realm:** Client, Menu  ·  **Members:** 27  ·  **Inherits:** `DPanel`

A standard Derma color mixer

[wiki page](https://wiki.facepunch.com/gmod/DColorMixer)

### DColorMixer:ConVarThink · Client, Menu · `INTERNAL`
`DColorMixer:ConVarThink()`

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:ConVarThink) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L318-L337)

---

### DColorMixer:DoConVarThink · Client, Menu · `INTERNAL`
`DColorMixer:DoConVarThink(cvar: string)`

**Arguments:**
- `cvar` (string)

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:DoConVarThink) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L339-L351)

---

### DColorMixer:GetAlphaBar · Client, Menu
`DColorMixer:GetAlphaBar() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns true if alpha bar is shown, false if not.

**Returns:**
- boolean — Return true if shown, false if not.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetAlphaBar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L10)

---

### DColorMixer:GetColor · Client, Menu
`DColorMixer:GetColor() → Color`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the current selected color.

**Returns:**
- Color — The current selected color as a Color.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L294-L303)

---

### DColorMixer:GetConVarA · Client, Menu
`DColorMixer:GetConVarA() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the alpha channel of the color.

See also:
* [DColorMixer:GetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarR) - For the red channel
* [DColorMixer:GetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarG) - For the green channel
* [DColorMixer:GetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarB) - For the blue channel

**Returns:**
- string — The ConVar name for the alpha channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarA) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L7)

---

### DColorMixer:GetConVarB · Client, Menu
`DColorMixer:GetConVarB() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the blue channel of the color.

See also:
* [DColorMixer:GetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarR) - For the red channel
* [DColorMixer:GetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarG) - For the green channel
* [DColorMixer:GetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the blue channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L6)

---

### DColorMixer:GetConVarG · Client, Menu
`DColorMixer:GetConVarG() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the green channel of the color.

See also:
* [DColorMixer:GetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarR) - For the red channel
* [DColorMixer:GetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarB) - For the blue channel
* [DColorMixer:GetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the green channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarG) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L5)

---

### DColorMixer:GetConVarR · Client, Menu
`DColorMixer:GetConVarR() → string`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the red channel of the color.

See also:
* [DColorMixer:GetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarG) - For the green channel
* [DColorMixer:GetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarB) - For the blue channel
* [DColorMixer:GetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarA) - For the alpha channel

**Returns:**
- string — The ConVar name for the red channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetConVarR) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L4)

---

### DColorMixer:GetPalette · Client, Menu
`DColorMixer:GetPalette() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns true if palette is shown, false if not.

**Returns:**
- boolean — Return true if shown, false if not.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetPalette) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L9)

---

### DColorMixer:GetVector · Client, Menu
`DColorMixer:GetVector() → Vector`

Returns the color as a normalized [Vector](https://wiki.facepunch.com/gmod/Vector).

**Returns:**
- Vector — A vector representing the color of the DColorMixer, each value being in range of 0 to 1.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetVector) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L305-L310)

---

### DColorMixer:GetWangs · Client, Menu
`DColorMixer:GetWangs() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns true if the wangs are shown, false if not.

**Returns:**
- boolean — Return true if shown, false if not.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:GetWangs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L11)

---

### DColorMixer:SetAlphaBar · Client, Menu
`DColorMixer:SetAlphaBar(show: boolean)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that show/hide the alpha bar in DColorMixer

**Arguments:**
- `show` (boolean) — Show / Hide the alpha bar

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetAlphaBar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L164-L171)

---

### DColorMixer:SetBaseColor · Client, Menu
`DColorMixer:SetBaseColor(clr: Color)`

Sets the base color of the [DColorCube](https://wiki.facepunch.com/gmod/DColorCube) part of the [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer).

See also [DColorCube:SetBaseRGB](https://wiki.facepunch.com/gmod/DColorCube:SetBaseRGB)

**Arguments:**
- `clr` (Color) — Color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetBaseColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L229-L232)

---

### DColorMixer:SetColor · Client, Menu
`DColorMixer:SetColor(color: Color)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the color of the [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer). See also [DColorMixer:GetColor](https://wiki.facepunch.com/gmod/DColorMixer:GetColor)

**Arguments:**
- `color` (Color) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L212-L221)

---

### DColorMixer:SetConVarA · Client, Menu
`DColorMixer:SetConVarA(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the alpha channel of the color.

See also:
* [DColorMixer:SetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarR) - For the red channel
* [DColorMixer:SetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarG) - For the green channel
* [DColorMixer:SetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarB) - For the blue channel

**Arguments:**
- `convar` (string) — The ConVar name for the alpha channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarA) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L193-L196)

---

### DColorMixer:SetConVarB · Client, Menu
`DColorMixer:SetConVarB(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the blue channel of the color.

See also:
* [DColorMixer:SetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarR) - For the red channel
* [DColorMixer:SetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarG) - For the green channel
* [DColorMixer:SetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the blue channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L189-L191)

---

### DColorMixer:SetConVarG · Client, Menu
`DColorMixer:SetConVarG(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the green channel of the color.

See also:
* [DColorMixer:SetConVarR](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarR) - For the red channel
* [DColorMixer:SetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarB) - For the blue channel
* [DColorMixer:SetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the green channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarG) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L185-L187)

---

### DColorMixer:SetConVarR · Client, Menu
`DColorMixer:SetConVarR(convar: string)`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that sets the [ConVar](https://wiki.facepunch.com/gmod/ConVar) name for the red channel of the color.

See also:
* [DColorMixer:SetConVarG](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarG) - For the green channel
* [DColorMixer:SetConVarB](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarB) - For the blue channel
* [DColorMixer:SetConVarA](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarA) - For the alpha channel

**Arguments:**
- `convar` (string) — The ConVar name for the red channel of the color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetConVarR) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L181-L183)

---

### DColorMixer:SetLabel · Client, Menu
`DColorMixer:SetLabel(text: string = nil)`

Sets the label's text to show.

**Arguments:**
- `text` (string, default `nil`) — Set to non empty string to show the label and its text.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetLabel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L142-L154)

---

### DColorMixer:SetPalette · Client, Menu
`DColorMixer:SetPalette(enabled: boolean)`

Show or hide the palette panel

**Arguments:**
- `enabled` (boolean) — Show or hide the palette panel?

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetPalette) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L156-L162)

---

### DColorMixer:SetVector · Client, Menu
`DColorMixer:SetVector(vec: Vector)`

Sets the color of [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer) from a [Vector](https://wiki.facepunch.com/gmod/Vector). Alpha is not included.

**Arguments:**
- `vec` (Vector) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetVector) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L223-L227)

---

### DColorMixer:SetWangs · Client, Menu
`DColorMixer:SetWangs(show: boolean)`

Show / Hide the colors indicators in DColorMixer

**Arguments:**
- `show` (boolean) — Show / Hide the colors indicators

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:SetWangs) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L173-L179)

---

### DColorMixer:UpdateColor · Client, Menu · `INTERNAL`
`DColorMixer:UpdateColor(clr: Color)`

Use [DColorMixer:SetColor](https://wiki.facepunch.com/gmod/DColorMixer:SetColor) instead!

**Arguments:**
- `clr` (Color)

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:UpdateColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L254-L288)

---

### DColorMixer:UpdateConVar · Client, Menu · `INTERNAL`
`DColorMixer:UpdateConVar(cvar: string, part: string, clr: Color)`

**Arguments:**
- `cvar` (string) — The ConVar name
- `part` (string) — The color part to set the cvar to.
- `clr` (Color) — The Color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:UpdateConVar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L234-L241)

---

### DColorMixer:UpdateConVars · Client, Menu · `INTERNAL`
`DColorMixer:UpdateConVars(clr: Color)`

**Arguments:**
- `clr` (Color) — The Color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:UpdateConVars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L243-L252)

---

### DColorMixer:UpdateDefaultColor · Client, Menu
`DColorMixer:UpdateDefaultColor()`

sets the default color of the element to the currently selected color

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:UpdateDefaultColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L204-L222)

---

### DColorMixer:ValueChanged · Client, Menu · `hook`
`DColorMixer:ValueChanged(col: Color)`

Called when the player changes the color of the [DColorMixer](https://wiki.facepunch.com/gmod/DColorMixer). Meant to be overridden.

**Arguments:**
- `col` (Color) — The new color.

> **Bug:** The returned color will not have the color metatable.

[wiki](https://wiki.facepunch.com/gmod/DColorMixer:ValueChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dcolormixer.lua#L313-L315)
