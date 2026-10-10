# utf8

**Realm:** Shared, Menu  ·  **Members:** 9

The utf8 library provides basic support for UTF-8 encoding. This library does not provide any support for Unicode other than the handling of the encoding. Any operation that needs the meaning of a character, such as character classification, is outside its scope.

Unless stated otherwise, all functions that expect a byte position as a parameter assume that the given position is either the start of a byte sequence or one plus the length of the subject string. As in the string library, negative indices count from the end of the string.

[wiki page](https://wiki.facepunch.com/gmod/utf8)

### utf8.char · Shared, Menu
`utf8.char(codepoints: vararg) → string`

Receives zero or more integers, converts each one to its corresponding UTF-8 byte sequence and returns a string with the concatenation of all these sequences.

**Arguments:**
- `codepoints` (vararg) — Unicode code points to be converted in to a UTF-8 string.

**Returns:**
- string — UTF-8 string generated from given arguments.

[wiki](https://wiki.facepunch.com/gmod/utf8.char) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L98-L144)

---

### utf8.charpattern · Client, Menu
`utf8.charpattern()`

[wiki](https://wiki.facepunch.com/gmod/utf8.charpattern)

---

### utf8.codepoint · Shared, Menu
`utf8.codepoint(string: string, startPos: number = 1, endPos: number = 1) → vararg`

Returns the codepoints (as numbers) from all characters in the given string that start between byte position startPos and endPos. It raises an error if it meets any invalid byte sequence. This functions similarly to [string.byte](https://wiki.facepunch.com/gmod/string.byte).

**Arguments:**
- `string` (string) — The string that you will get the code(s) from.
- `startPos` (number, default `1`) — The starting byte of the string to get the codepoint of.
- `endPos` (number, default `1`) — The ending byte of the string to get the codepoint of.

**Returns:**
- vararg — The codepoint number(s).

[wiki](https://wiki.facepunch.com/gmod/utf8.codepoint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L179-L200)

---

### utf8.codes · Shared, Menu
`utf8.codes(string: string) → function`

Returns an iterator (like [string.gmatch](https://wiki.facepunch.com/gmod/string.gmatch)) which returns both the position and codepoint of each utf8 character in the string. It raises an error if it meets any invalid byte sequence.

**Arguments:**
- `string` (string) — The string that you will get the codes from.

**Returns:**
- function — The iterator (to be used in a for loop).

[wiki](https://wiki.facepunch.com/gmod/utf8.codes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L150-L173)

---

### utf8.force · Shared, Menu
`utf8.force(string: string) → string`

Forces a string to contain only valid UTF-8 data. Invalid sequences are replaced with U+FFFD (the Unicode replacement character).

This is a lazy way for users to ensure a string contains only valid UTF-8 data.

**Arguments:**
- `string` (string) — The string that will become a valid UTF-8 string.

**Returns:**
- string — The UTF-8 string.

[wiki](https://wiki.facepunch.com/gmod/utf8.force) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L307-L338)

---

### utf8.GetChar · Shared, Menu
`utf8.GetChar(str: string, index: number) → string`

A UTF-8 compatible version of [string.GetChar](https://wiki.facepunch.com/gmod/string.GetChar).

**Arguments:**
- `str` (string) — The string that you will be searching with the supplied index.
- `index` (number) — The index's value of the string to be returned.

**Returns:**
- string — str

[wiki](https://wiki.facepunch.com/gmod/utf8.GetChar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L354-L362)

---

### utf8.len · Shared, Menu
`utf8.len(string: string, startPos: number = 1, endPos: number = -1) → number, number`

Returns the number of UTF-8 sequences in the given string between positions startPos and endPos (both inclusive). If it finds any invalid UTF-8 byte sequence, returns false as well as the position of the first invalid byte.

**Arguments:**
- `string` (string) — The string to calculate the length of.
- `startPos` (number, default `1`) — The starting position to get the length from.
- `endPos` (number, default `-1`) — The ending position to get the length from.

**Returns:**
- number — The number of UTF-8 characters in the string.
- number — The position of the first invalid byte.

[wiki](https://wiki.facepunch.com/gmod/utf8.len) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L206-L229)

---

### utf8.offset · Shared, Menu
`utf8.offset(string: string, n: number, startPos: number = 1 when n>=0, -1 otherwise) → number`

Returns the byte-index of the n'th UTF-8-character after the given startPos (nil if none). startPos defaults to 1 when n is positive and -1 when n is negative. If n is zero, this function instead returns the byte-index of the UTF-8-character startPos lies within.

**Arguments:**
- `string` (string) — The string that you will get the byte position from.
- `n` (number) — The position to get the beginning byte position from.
- `startPos` (number, default `1 when n>=0, -1 otherwise`) — The offset for n.

**Returns:**
- number — Starting byte-index of the given position.

[wiki](https://wiki.facepunch.com/gmod/utf8.offset) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L236-L301)

---

### utf8.sub · Shared, Menu
`utf8.sub(string: string, StartPos: number, EndPos: number = nil) → string`

A UTF-8 compatible version of [string.sub](https://wiki.facepunch.com/gmod/string.sub).

**Arguments:**
- `string` (string) — The string you'll take a sub-string out of.
- `StartPos` (number) — The position of the first character that will be included in the sub-string.
- `EndPos` (number, default `nil`) — The position of the last character to be included in the sub-string.

**Returns:**
- string — The substring.

> **Warning:** Avoid using this function on large strings every tick/frame, as it may cause lags.

[wiki](https://wiki.facepunch.com/gmod/utf8.sub) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/utf8.lua#L367-L377)
