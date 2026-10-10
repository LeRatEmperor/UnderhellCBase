# markup

**Realm:** Client, Menu  ·  **Members:** 3

The markup library only contains a single function to create a [MarkupObject](https://wiki.facepunch.com/gmod/MarkupObject).

[wiki page](https://wiki.facepunch.com/gmod/markup)

### markup.Color · Client, Menu
`markup.Color(col: Color) → string`

A convenience function that converts a [Color](https://wiki.facepunch.com/gmod/Color) into its markup ready string representation.

**Arguments:**
- `col` (Color) — The Color to convert.

**Returns:**
- string — The markup color, for example `255,255,255`.

[wiki](https://wiki.facepunch.com/gmod/markup.Color) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/markup.lua#L39-L46)

---

### markup.Escape · Client, Menu
`markup.Escape(text: string) → string`

Converts a string to its escaped, markup-safe equivalent.

**Arguments:**
- `text` (string) — The string to sanitize.

**Returns:**
- `sanitizedText` (string) — The parsed markup object ready to be drawn.

[wiki](https://wiki.facepunch.com/gmod/markup.Escape) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/markup.lua#L279-L281)

---

### markup.Parse · Client, Menu
`markup.Parse(markup: string, maxWidth: number = nil) → MarkupObject`

Parses markup into a [MarkupObject](https://wiki.facepunch.com/gmod/MarkupObject). Currently, this only supports fonts and colors as demonstrated in the example.

**Arguments:**
- `markup` (string) — The markup to be parsed.
- `maxWidth` (number, default `nil`) — The max width of the output.

**Returns:**
- MarkupObject — The parsed markup object ready to be drawn via MarkupObject:Draw.

> **Warning:** This function is very slow! Always cache its result.

[wiki](https://wiki.facepunch.com/gmod/markup.Parse) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/markup.lua#L233-L455)
