# Color

**Realm:** Shared, Menu  ·  **Members:** 28

List of all possible functions to manipulate colors.

Colors are implemented in Lua thus [type](https://wiki.facepunch.com/gmod/Global.type)(color) == "table" and [TypeID](https://wiki.facepunch.com/gmod/Global.TypeID)(color) == [TYPE_TABLE](https://wiki.facepunch.com/gmod/Enums/TYPE#table).

For type checking use [IsColor](https://wiki.facepunch.com/gmod/Global.IsColor).

Created by [Color](https://wiki.facepunch.com/gmod/Global.Color), [HSVToColor](https://wiki.facepunch.com/gmod/Global.HSVToColor), and [HSLToColor](https://wiki.facepunch.com/gmod/Global.HSLToColor).

| Type                | Name  | Description                       |
| ------------------- | ----- | --------------------------------- |
| [number](https://wiki.facepunch.com/gmod/number) | **r** | The red component of the color.   |
| [number](https://wiki.facepunch.com/gmod/number) | **g** | The green component of the color. |
| [number](https://wiki.facepunch.com/gmod/number) | **b** | The blue component of the color.  |
| [number](https://wiki.facepunch.com/gmod/number) | **a** | The alpha component of the color. |

[wiki page](https://wiki.facepunch.com/gmod/Color)

### Color:AddBlackness · Shared, Menu
`Color:AddBlackness(blackness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model), adds given value to the "blackness" and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetBlackness](https://wiki.facepunch.com/gmod/COLOR:GetBlackness) & [COLOR:SetBlackness](https://wiki.facepunch.com/gmod/COLOR:SetBlackness)

**Arguments:**
- `blackness` (number) — The "blackness" value to add in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddBlackness)

---

### Color:AddBrightness · Shared, Menu
`Color:AddBrightness(saturation: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), adds given value to the [brightness also known as "value"](https://en.wikipedia.org/wiki/Brightness) and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetBrightness](https://wiki.facepunch.com/gmod/COLOR:GetBrightness) & [COLOR:SetBrightness](https://wiki.facepunch.com/gmod/COLOR:SetBrightness)

This is useful to quickly change the saturation of the color without changing hue or luminance, allowing for things like easy theming.

**Arguments:**
- `saturation` (number) — The brightness value to add in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddBrightness)

---

### Color:AddHue · Shared, Menu
`Color:AddHue(hue: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), adds given value to the [hue](https://en.wikipedia.org/wiki/Hue) and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetHue](https://wiki.facepunch.com/gmod/COLOR:GetHue) & [COLOR:SetHue](https://wiki.facepunch.com/gmod/COLOR:SetHue)

This is useful to quickly change the hue of the color without changing saturation or luminance, allowing for things like easy theming.

**Arguments:**
- `hue` (number) — The hue value to add in degrees [0, 360).

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddHue)

---

### Color:AddLightness · Shared, Menu
`Color:AddLightness(lightness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV), adds given value to the ["lightness"](https://en.wikipedia.org/wiki/Lightness) and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetLightness](https://wiki.facepunch.com/gmod/COLOR:GetLightness) & [COLOR:SetLightness](https://wiki.facepunch.com/gmod/COLOR:SetLightness)

This is useful to quickly change the lightness of the color without changing hue or saturation, allowing for things like easy theming.

**Arguments:**
- `lightness` (number) — The lightness value to add in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddLightness)

---

### Color:AddSaturation · Shared, Menu
`Color:AddSaturation(saturation: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), adds given value to the [saturation](https://en.wikipedia.org/wiki/Colorfulness) and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetSaturation](https://wiki.facepunch.com/gmod/COLOR:GetSaturation) & [COLOR:SetSaturation](https://wiki.facepunch.com/gmod/COLOR:SetSaturation)

This is useful to quickly change the saturation of the color without changing hue or luminance, allowing for things like easy theming.

**Arguments:**
- `saturation` (number) — The saturation value to add in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddSaturation)

---

### Color:AddWhiteness · Shared, Menu
`Color:AddWhiteness(whiteness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model), adds given value to the "whiteness" and converts it back into an RGB color.

A slightly more efficient combination of [COLOR:GetWhiteness](https://wiki.facepunch.com/gmod/COLOR:GetWhiteness) & [COLOR:SetWhiteness](https://wiki.facepunch.com/gmod/COLOR:SetWhiteness)

**Arguments:**
- `whiteness` (number) — The "whiteness" value to add in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:AddWhiteness)

---

### Color:Copy · Shared, Menu
`Color:Copy() → Color`

Returns a copy of this color, usually so it can be safely modified later without affecting the original color.

**Returns:**
- Color — The copy of the given color, safe to modify.

[wiki](https://wiki.facepunch.com/gmod/Color:Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L183-L187)

---

### Color:GetBlackness · Shared, Menu
`Color:GetBlackness() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model) and returns the "blackness" of the color.

See [COLOR:ToHWB](https://wiki.facepunch.com/gmod/COLOR:ToHWB) if you want to get all 3 components.

**Returns:**
- `blackness` (number) — Blackness of the color in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetBlackness) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L349-L354)

---

### Color:GetBrightness · Shared, Menu
`Color:GetBrightness() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV) and returns the [brightness also known as "value"](https://en.wikipedia.org/wiki/Brightness).

See [COLOR:ToHSV](https://wiki.facepunch.com/gmod/COLOR:ToHSV) if you want to get all 3 components.

**Returns:**
- `brightness` (number) — Brightness in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetBrightness) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L277-L282)

---

### Color:GetHue · Shared, Menu
`Color:GetHue() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV) and returns the [hue](https://en.wikipedia.org/wiki/Hue).

See [COLOR:ToHSV](https://wiki.facepunch.com/gmod/COLOR:ToHSV) if you want to get all 3 components.

**Returns:**
- `hue` (number) — The hue in degrees [0, 360).

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetHue)

---

### Color:GetLightness · Shared, Menu
`Color:GetLightness() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV) and returns the ["lightness"](https://en.wikipedia.org/wiki/Lightness) of the color.

See [COLOR:ToHSL](https://wiki.facepunch.com/gmod/COLOR:ToHSL) if you want to get all 3 components.

**Returns:**
- `lightness` (number) — Lightness in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetLightness)

---

### Color:GetSaturation · Shared, Menu
`Color:GetSaturation() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV) and returns the [saturation](https://en.wikipedia.org/wiki/Colorfulness).

See [COLOR:ToHSV](https://wiki.facepunch.com/gmod/COLOR:ToHSV) if you want to get all 3 components.

**Returns:**
- `saturation` (number) — Saturation in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetSaturation)

---

### Color:GetWhiteness · Shared, Menu
`Color:GetWhiteness() → number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model) and returns the "whiteness" of the color.

See [COLOR:ToHWB](https://wiki.facepunch.com/gmod/COLOR:ToHWB) if you want to get all 3 components.

**Returns:**
- `whiteness` (number) — Whiteness of the color in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:GetWhiteness)

---

### Color:Lerp · Shared, Menu
`Color:Lerp(target: Color, fraction: number) → Color`

Performs linear interpolation between this and given colors.

**Arguments:**
- `target` (Color) — The target color to interpolate towards.
- `fraction` (number) — The interpolation fraction.

**Returns:**
- Color — The result of linear interpolation.

[wiki](https://wiki.facepunch.com/gmod/Color:Lerp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L183-L192)

---

### Color:SetBlackness · Shared, Menu
`Color:SetBlackness(blackness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model), sets the "blackness" and converts it back into an RGB color.

**Arguments:**
- `blackness` (number) — The new "blackness" value in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetBlackness)

---

### Color:SetBrightness · Shared, Menu
`Color:SetBrightness(saturation: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), sets the [brightness also known as "value"](https://en.wikipedia.org/wiki/Brightness) and converts it back into an RGB color.

This is useful to quickly change the brightness of the color without changing hue or saturation, allowing for things like easy theming.

**Arguments:**
- `saturation` (number) — The new brightness value in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetBrightness)

---

### Color:SetHue · Shared, Menu
`Color:SetHue(hue: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), sets the [hue](https://en.wikipedia.org/wiki/Hue) and converts it back into an RGB color.

This is useful to quickly change the hue of the color without changing saturation or luminance, allowing for things like easy theming.

**Arguments:**
- `hue` (number) — The new hue value in degrees [0, 360).

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetHue)

---

### Color:SetLightness · Shared, Menu
`Color:SetLightness(lightness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV), sets the ["lightness"](https://en.wikipedia.org/wiki/Lightness) and converts it back into an RGB color.

This is useful to quickly change the lightness of the color without changing hue or saturation, allowing for things like easy theming.

**Arguments:**
- `lightness` (number) — The new lightness value in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetLightness)

---

### Color:SetSaturation · Shared, Menu
`Color:SetSaturation(saturation: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV), sets the [saturation](https://en.wikipedia.org/wiki/Colorfulness) and converts it back into an RGB color.

This is useful to quickly change the saturation of the color without changing hue or luminance, allowing for things like easy theming.

**Arguments:**
- `saturation` (number) — The new saturation value in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetSaturation)

---

### Color:SetUnpacked · Shared
`Color:SetUnpacked(r: number, g: number, b: number, a: number)`

Sets the red, green, blue, and alpha of the color.

**Arguments:**
- `r` (number) — The red component
- `g` (number) — The green component
- `b` (number) — The blue component
- `a` (number) — The alpha component

[wiki](https://wiki.facepunch.com/gmod/Color:SetUnpacked) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L94-L101)

---

### Color:SetWhiteness · Shared, Menu
`Color:SetWhiteness(whiteness: number)`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model), sets the "whiteness" and converts it back into an RGB color.

**Arguments:**
- `whiteness` (number) — The new "whiteness" value in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/COLOR:SetWhiteness)

---

### Color:ToHex · Shared, Menu
`Color:ToHex(a1: boolean = false) → string`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) to its hexadecimal representation.

**Arguments:**
- `a1` (boolean, default `false`) — Whether to forcibly omit the alpha channel from the output.

**Returns:**
- string — The hexadecimal representation of the color.

[wiki](https://wiki.facepunch.com/gmod/Color:ToHex)

---

### Color:ToHSL · Shared, Menu
`Color:ToHSL() → number, number, number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HSL color space](https://en.wikipedia.org/wiki/HSL_and_HSV) .

This calls [ColorToHSL](https://wiki.facepunch.com/gmod/Global.ColorToHSL) internally.

**Returns:**
- number — The hue in degrees [0, 360).
- number — The saturation in the range [0, 1].
- number — The lightness in the range [0, 1].

[wiki](https://wiki.facepunch.com/gmod/Color:ToHSL) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L140-L144)

---

### Color:ToHSV · Shared, Menu
`Color:ToHSV() → number, number, number`

Encodes a RGB [Color](https://wiki.facepunch.com/gmod/Color) into the [HSV color space](https://en.wikipedia.org/wiki/HSL_and_HSV).

		This function uses [ColorToHSV](https://wiki.facepunch.com/gmod/Global.ColorToHSV) internally.

**Returns:**
- `hue` (number) — Hue in degrees in range [0, 360)
- `saturation` (number) — Saturation in range [0, 1]
- `brightness` (number) — Brightness in range [0, 1]

[wiki](https://wiki.facepunch.com/gmod/Color:ToHSV) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L149-L153)

---

### Color:ToHWB · Shared, Menu
`Color:ToHWB() → number, number, number`

Converts a [Color](https://wiki.facepunch.com/gmod/Color) into [HWB color space](https://en.wikipedia.org/wiki/HWB_color_model). See [HWBToColor](https://wiki.facepunch.com/gmod/Global.HWBToColor) for more info.

**Returns:**
- `hue` (number) — The hue in degrees [0, 360).
- `whiteness` (number) — The whiteness in the range [0, 1].
- `blackness` (number) — The blacknessin the range [0, 1].

[wiki](https://wiki.facepunch.com/gmod/COLOR:ToHWB) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L158-L163)

---

### Color:ToTable · Shared
`Color:ToTable() → table<number>`

Returns the color as a table (an array or a list) with four elements.

**Returns:**
- table<number> — The table with elements 1 = r, 2 = g, 3 = b, 4 = a,( `{ r, g, b, a }` )

[wiki](https://wiki.facepunch.com/gmod/Color:ToTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L103-L107)

---

### Color:ToVector · Shared
`Color:ToVector() → Vector`

Translates the [Color](https://wiki.facepunch.com/gmod/Color) into a [Vector](https://wiki.facepunch.com/gmod/Vector), losing the alpha channel.
This will also range the values from 0 - 255 to 0 - 1

r / 255 -> x
g / 255 -> y
b / 255 -> z

This is the opposite of [Vector:ToColor](https://wiki.facepunch.com/gmod/Vector:ToColor)

**Returns:**
- Vector — The created Vector

[wiki](https://wiki.facepunch.com/gmod/Color:ToVector) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L168-L172)

---

### Color:Unpack · Shared
`Color:Unpack() → number, number, number, number`

Returns the red, green, blue, and alpha of the color.

**Returns:**
- number — Red
- number — Green
- number — Blue
- number — Alpha

[wiki](https://wiki.facepunch.com/gmod/Color:Unpack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util/color.lua#L177-L181)
