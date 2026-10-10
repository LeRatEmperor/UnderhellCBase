# killicon

**Realm:** Client  ·  **Members:** 8

The killicon library is used to add to and control the icons that appear in the top right of your screen when a player is killed.

[wiki page](https://wiki.facepunch.com/gmod/killicon)

### killicon.Add · Client
`killicon.Add(class: string, texture: string, color: Color)`

Creates new kill icon using a texture.

**Arguments:**
- `class` (string) — Weapon or entity class.
- `texture` (string) — Path to the texture.
- `color` (Color) — Color of the kill icon.

[wiki](https://wiki.facepunch.com/gmod/killicon.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L30-L37)

---

### killicon.AddAlias · Client
`killicon.AddAlias(new_class: string, existing_class: string)`

Creates kill icon from existing one.

**Arguments:**
- `new_class` (string) — New class of the kill icon.
- `existing_class` (string) — Already existing kill icon class.

[wiki](https://wiki.facepunch.com/gmod/killicon.AddAlias) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L39-L43)

---

### killicon.AddFont · Client
`killicon.AddFont(class: string, font: string, symbol: string, color: Color, heightScale : number = 1)`

Adds kill icon for given weapon/entity class using special font.

**Arguments:**
- `class` (string) — Weapon or entity class.
- `font` (string) — Font to be used.
- `symbol` (string) — The symbol to be used.
- `color` (Color) — Color of the killicon.
- `heightScale ` (number, default `1`) — Used internally to correct certain killicons to more closely match their visual size.

[wiki](https://wiki.facepunch.com/gmod/killicon.AddFont) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L20-L28)

---

### killicon.AddTexCoord · Client
`killicon.AddTexCoord(class: string, texture: string, color: Color, x: number, y: number, w: number, h: number)`

Creates new kill icon using a sub-rectangle of a texture.

**Arguments:**
- `class` (string) — Weapon or entity class this killicon is for.
- `texture` (string) — Path to the texture.
- `color` (Color) — Color of the kill icon.
- `x` (number) — The start position (X axis) of the rectangle on the given texture.
- `y` (number) — The start position (Y axis) of the rectangle on the given texture.
- `w` (number) — The width of the rectangle on the given texture.
- `h` (number) — The height of the rectangle on the given texture.

[wiki](https://wiki.facepunch.com/gmod/killicon.AddTexCoord)

---

### killicon.Draw · Client · `DEPRECATED`
`killicon.Draw(x: number, y: number, name: string, alpha: number = 255)`

Draws a kill icon.

**Arguments:**
- `x` (number) — X coordinate of the icon.
- `y` (number) — Y coordinate of the icon.
- `name` (string) — Classname of the kill icon.
- `alpha` (number, default `255`) — Alpha/transparency value ( 0 - 255 ) of the icon.

[wiki](https://wiki.facepunch.com/gmod/killicon.Draw) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L97-L135)

---

### killicon.Exists · Client
`killicon.Exists(class: string) → boolean`

Checks if kill icon exists for given class.

**Arguments:**
- `class` (string) — The class to test.

**Returns:**
- boolean — Returns true if kill icon exists.

[wiki](https://wiki.facepunch.com/gmod/killicon.Exists) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L45-L49)

---

### killicon.GetSize · Client
`killicon.GetSize(name: string, dontEqualizeHeight: boolean = false) → number, number`

Returns the size of a kill icon.

**Arguments:**
- `name` (string) — Classname of the kill icon.
- `dontEqualizeHeight` (boolean, default `false`) — If set to `true`, returns the real size of the kill icon, without trying to equalize the height to match the default kill icon font.

**Returns:**
- number — Width of the kill icon.
- number — Height of the kill icon.

[wiki](https://wiki.facepunch.com/gmod/killicon.GetSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L51-L95)

---

### killicon.Render · Client
`killicon.Render(x: number, y: number, name: string, alpha: number = 255, dontEqualizeHeight: number = false)`

Renders a kill icon.

**Arguments:**
- `x` (number) — X coordinate of the icon.
- `y` (number) — Y coordinate of the icon.
- `name` (string) — Classname of the kill icon.
- `alpha` (number, default `255`) — Alpha/transparency value ( 0 - 255 ) of the icon.
- `dontEqualizeHeight` (number, default `false`) — Do not rescale the icon to match the default kill icon font.

[wiki](https://wiki.facepunch.com/gmod/killicon.Render) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/killicon.lua#L196-L200)
