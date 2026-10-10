# MarkupObject

**Realm:** Client, Menu  ·  **Members:** 5

Object containing parsed markup for later rendering. Created by [markup.Parse](https://wiki.facepunch.com/gmod/markup.Parse).

[wiki page](https://wiki.facepunch.com/gmod/MarkupObject)

### MarkupObject:Draw · Client, Menu
`MarkupObject:Draw(xOffset: number, yOffset: number, xAlign: number = TEXT_ALIGN_LEFT, yAlign: number = TEXT_ALIGN_TOP, alphaoverride: number = 255, textAlign: number = TEXT_ALIGN_LEFT)`

Draws the computed markupobject to the screen. See [markup.Parse](https://wiki.facepunch.com/gmod/markup.Parse).

**Arguments:**
- `xOffset` (number) — The X coordinate on the screen.
- `yOffset` (number) — The Y coordinate on the screen.
- `xAlign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the x coordinate within the text using TEXT_ALIGN
- `yAlign` (number, default `TEXT_ALIGN_TOP`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the y coordinate within the text using TEXT_ALIGN
- `alphaoverride` (number, default `255`) — Sets the alpha of all drawn objects to this value.
- `textAlign` (number, default `TEXT_ALIGN_LEFT`, enum [TEXT_ALIGN](https://wiki.facepunch.com/gmod/Enums/TEXT_ALIGN)) — The alignment of the text horizontally using TEXT_ALIGN

[wiki](https://wiki.facepunch.com/gmod/MarkupObject:Draw)

---

### MarkupObject:GetHeight · Client, Menu
`MarkupObject:GetHeight() → number`

Gets computed the height of the markupobject.

**Returns:**
- `Height` (number) — The computed height.

[wiki](https://wiki.facepunch.com/gmod/MarkupObject:GetHeight)

---

### MarkupObject:GetMaxWidth · Client, Menu
`MarkupObject:GetMaxWidth() → number`

Gets maximum width for this markup object as defined in [markup.Parse](https://wiki.facepunch.com/gmod/markup.Parse).

**Returns:**
- `maxWidth` (number) — The max width.

[wiki](https://wiki.facepunch.com/gmod/MarkupObject:GetMaxWidth)

---

### MarkupObject:GetWidth · Client, Menu
`MarkupObject:GetWidth() → number`

Gets computed the width of the markupobject.

**Returns:**
- `Width` (number) — The computed width.

[wiki](https://wiki.facepunch.com/gmod/MarkupObject:GetWidth)

---

### MarkupObject:Size · Client, Menu
`MarkupObject:Size() → number, number`

Gets computed the width and height of the markupobject.

**Returns:**
- number — The computed width.
- number — The computed height.

[wiki](https://wiki.facepunch.com/gmod/MarkupObject:Size)
