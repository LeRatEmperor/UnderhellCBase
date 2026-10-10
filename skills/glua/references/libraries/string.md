# string

**Realm:** Shared, Menu  ·  **Members:** 47

The string *type* is a sequence of characters.

The string *library* is a standard Lua library which provides functions for the manipulation of strings.[[1]](https://www.lua.org/pil/20.html)

In Garry's Mod there are several extra useful functions and features added to this library.
Most notably all strings will access this library through the string metatable index function.[[2]](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L311-L322)

This means all strings are treated like table objects and the string library as its [Meta Table](https://wiki.facepunch.com/gmod/Meta_Tables)

```lua
local x = "Kittens"
function string.Foobar(self) return self:Right(4) end

string.Right(x,4) == x:Right(4) == x:Foobar() == ("Kittens"):Right(4) == x[-4]..x[-3]..x[-2]..x[-1]
```lua


The string *metatable* however is something else, and to access that you must use `getmetatable("")`.

The difference here is related to [Metamethods](https://wiki.facepunch.com/gmod/Metamethods), such as using (+) instead of (..) to concatenate strings.


```lua
local stringmeta = getmetatable("")
function stringmeta.__add(str,x) return str..x end -- This will work
function string.__add(str,x) return str..x end -- But this will not.

print("Kittens" + " And " + "Puppies")
```

See [Meta Tables](https://wiki.facepunch.com/gmod/Meta%20Tables) and [Metamethods](https://wiki.facepunch.com/gmod/Metamethods) for more information.


This category lists functions available in the string *library*.

> **Warning:** Making changes to the string *metatable* is not a good idea unless you know what you are doing. Use the string *library* instead.
> **Warning:** Using `+` operator for concatenation breaks lua metamethod to sum string as numbers (Example: `"10" + "1"` return `11` (number)) and this is 400 times SLOWER!

[wiki page](https://wiki.facepunch.com/gmod/string)

### string.byte · Shared, Menu
`string.byte(string: string, startPos: number = 1, endPos: number = startPos) → vararg`

Returns the given string's characters in their numeric ASCII representation.

**Arguments:**
- `string` (string) — The string to get the chars from.
- `startPos` (number, default `1`) — The first character of the string to get the byte of.
- `endPos` (number, default `startPos`) — The last character of the string to get the byte of.

**Returns:**
- vararg — Numerical bytes

> **Warning:** This function will throw an error if the slice length is greater than 8000 characters.

[wiki](https://wiki.facepunch.com/gmod/string.byte)

---

### string.CardinalToOrdinal · Shared, Menu
`string.CardinalToOrdinal(input: number) → string`

Converts a cardinal (`111`) number to its [ordinal/sequential variation](https://en.wikipedia.org/wiki/Ordinal_numeral) (`111th`).

See also [STNDRD](https://wiki.facepunch.com/gmod/Global.STNDRD) for a function that returns just the suffix.

**Arguments:**
- `input` (number) — A number to convert to ordinal.

**Returns:**
- string — The ordinal numeral.

[wiki](https://wiki.facepunch.com/gmod/string.CardinalToOrdinal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L385-L411)

---

### string.char · Shared, Menu
`string.char(bytes: vararg) → string`

Takes the given numerical bytes and converts them to a string.

**Arguments:**
- `bytes` (vararg) — The bytes to create the string from.

**Returns:**
- string — String built from given bytes

[wiki](https://wiki.facepunch.com/gmod/string.char)

---

### string.Comma · Shared, Menu
`string.Comma(value: number, separator: string = ,) → string`

Inserts commas for every third digit of a given number.

**Arguments:**
- `value` (number) — The input number to commafy
- `separator` (string, default `,`) — An optional string that will be used instead of the default comma.

**Returns:**
- string — The commafied string

[wiki](https://wiki.facepunch.com/gmod/string.Comma) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L332-L348)

---

### string.dump · Shared, Menu
`string.dump(func: function, stripDebugInfo: boolean = false) → string`

Returns the binary bytecode of the given function.

**Arguments:**
- `func` (function) — The function to get the bytecode of
- `stripDebugInfo` (boolean, default `false`) — True to strip the debug data, false to keep it

**Returns:**
- string — Bytecode

> **Note:** This does not work with functions created in C/C++. An error will be thrown if it is

[wiki](https://wiki.facepunch.com/gmod/string.dump)

---

### string.EndsWith · Shared, Menu
`string.EndsWith(str: string, end: string) → boolean`

Returns whether or not the second passed string matches the end of the first.

**Arguments:**
- `str` (string) — The string whose end is to be checked.
- `end` (string) — The string to be matched with the end of the first.

**Returns:**
- boolean — `true` if the first string ends with the second, or the second is empty, otherwise `false`.

[wiki](https://wiki.facepunch.com/gmod/string.EndsWith) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L305-L309)

---

### string.Explode · Shared, Menu
`string.Explode(separator: string, str: string, withpattern: boolean = false) → table<string>`

Splits a string up wherever it finds the given separator.

The function [string.Split](https://wiki.facepunch.com/gmod/string.Split) is an alias of this function, except that function doesn't support using patterns.

See [string.Implode](https://wiki.facepunch.com/gmod/string.Implode) for the reverse operation of this function.

**Arguments:**
- `separator` (string) — The string will be separated wherever this sequence is found.
- `str` (string) — The string to split up.
- `withpattern` (boolean, default `false`) — Set this to true if your separator is a pattern.

**Returns:**
- table<string> — Exploded string as a numerical sequential table.

[wiki](https://wiki.facepunch.com/gmod/string.Explode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L80-L97)

---

### string.find · Shared, Menu
`string.find(haystack: string, needle: string, startPos: number = 1, noPatterns: boolean = false) → number, number, string`

Attempts to find the specified substring in a string.

**Arguments:**
- `haystack` (string) — The string to search in.
- `needle` (string) — The string to find, can contain patterns if enabled.
- `startPos` (number, default `1`) — The position to start the search from, can be negative start position will be relative to the end position.
- `noPatterns` (boolean, default `false`) — Disable patterns.

**Returns:**
- number — Starting position of the found text, or nil if the text wasn't found
- number — Ending position of found text, or nil if the text wasn't found
- string — Matched text for each group if patterns are enabled and used, or nil if the text wasn't found

> **Warning:** This function uses [Lua Patterns](https://wiki.facepunch.com/gmod/Patterns) by default.

[wiki](https://wiki.facepunch.com/gmod/string.find)

---

### string.format · Shared, Menu
`string.format(format: string, formatParameters: vararg) → string`

Formats the specified values into the string given.

**Arguments:**
- `format` (string) — The string to be formatted.
- `formatParameters` (vararg) — Values to be formatted into the string.

**Returns:**
- string — The formatted string

[wiki](https://wiki.facepunch.com/gmod/string.format)

---

### string.FormattedTime · Shared, Menu
`string.FormattedTime(float: number, format: string = nil) → string|table{FormattedTime}`

Returns the time as a formatted string or as a table if no format is given.

**Arguments:**
- `float` (number) — The time in seconds to format.
- `format` (string, default `nil`) — An optional formatting to use.

**Returns:**
- string|table{FormattedTime} — Returns the time as a formatted string only if a format was specified.

[wiki](https://wiki.facepunch.com/gmod/string.FormattedTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L160-L172)

---

### string.FromColor · Shared, Menu
`string.FromColor(color: Color) → string`

Creates a string from a Color variable.

**Arguments:**
- `color` (Color) — The Color to put in the string.

**Returns:**
- string — Output

[wiki](https://wiki.facepunch.com/gmod/string.FromColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L311-L315)

---

### string.GetChar · Shared, Menu · `DEPRECATED`
`string.GetChar(str: string, index: number) → string`

Returns char value from the specified index in the supplied string.

**Arguments:**
- `str` (string) — The string that you will be searching with the supplied index.
- `index` (number) — The index's value of the string to be returned.

**Returns:**
- string — str

[wiki](https://wiki.facepunch.com/gmod/string.GetChar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L282-L286)

---

### string.GetExtensionFromFilename · Shared, Menu
`string.GetExtensionFromFilename(path: string) → string`

Returns extension of the file.

See [string.StripExtension](https://wiki.facepunch.com/gmod/string.StripExtension) for a function to remove the extension.  
See [string.GetFileFromFilename](https://wiki.facepunch.com/gmod/string.GetFileFromFilename) and [string.GetPathFromFilename](https://wiki.facepunch.com/gmod/string.GetPathFromFilename) for related functions.

**Arguments:**
- `path` (string) — The string eg.

**Returns:**
- string — File extension or `nil`.

> **Note:** Make sure there are no trailing whitespaces in your `path` argument

[wiki](https://wiki.facepunch.com/gmod/string.GetExtensionFromFilename) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L117-L119)

---

### string.GetFileFromFilename · Shared, Menu
`string.GetFileFromFilename(path: string) → string`

Returns file name and extension.

See [string.GetPathFromFilename](https://wiki.facepunch.com/gmod/string.GetPathFromFilename) for the opposite function.  
See [string.GetExtensionFromFilename](https://wiki.facepunch.com/gmod/string.GetExtensionFromFilename) for the file extension version.

**Arguments:**
- `path` (string) — The string eg.

**Returns:**
- string — File name or unmodified string.

[wiki](https://wiki.facepunch.com/gmod/string.GetFileFromFilename) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L144-L147)

---

### string.GetPathFromFilename · Shared, Menu
`string.GetPathFromFilename(path: string) → string`

Returns the path part of a full file path.
  
See [string.GetFileFromFilename](https://wiki.facepunch.com/gmod/string.GetFileFromFilename) for the opposite function.  
See [string.GetExtensionFromFilename](https://wiki.facepunch.com/gmod/string.GetExtensionFromFilename) for thefile extension version.

**Arguments:**
- `path` (string) — The string eg.

**Returns:**
- string — Path or empty string.

[wiki](https://wiki.facepunch.com/gmod/string.GetPathFromFilename) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L135-L137)

---

### string.gfind · Shared, Menu · `DEPRECATED`
`string.gfind(data: string, pattern: string) → function`

Returns an iterator function that is called for every complete match of the pattern, all sub matches will be passed as to the loop.

**Arguments:**
- `data` (string) — The string to search in
- `pattern` (string) — The pattern to search for

**Returns:**
- function — The iterator function that can be used in a for-in loop

[wiki](https://wiki.facepunch.com/gmod/string.gfind)

---

### string.gmatch · Shared, Menu
`string.gmatch(data: string, pattern: string) → function`

Using [Patterns](https://wiki.facepunch.com/gmod/Patterns), returns an iterator which will return either one value if no capture groups are defined, or any capture group matches.

**Arguments:**
- `data` (string) — The string to search in
- `pattern` (string) — The pattern to search for

**Returns:**
- function — The iterator function that can be used in a for-in loop

[wiki](https://wiki.facepunch.com/gmod/string.gmatch)

---

### string.gsub · Shared, Menu
`string.gsub(string: string, pattern: string, replacement: string, maxReplaces: number = nil) → string, number`

This functions main purpose is to replace certain character sequences in a string using [Patterns](https://wiki.facepunch.com/gmod/Patterns).

**Arguments:**
- `string` (string) — String which should be modified.
- `pattern` (string) — The pattern that defines what should be matched and eventually be replaced.
- `replacement` (string) — In case of a string the matched sequence will be replaced with it.
- `maxReplaces` (number, default `nil`) — Maximum number of replacements to be made.

**Returns:**
- string — replaceResult
- number — replaceCount

[wiki](https://wiki.facepunch.com/gmod/string.gsub)

---

### string.Implode · Shared, Menu · `DEPRECATED`
`string.Implode(separator: string, pieces: table) → string`

Joins the values of a table together to form a string.

This is the reverse of [string.Explode](https://wiki.facepunch.com/gmod/string.Explode) and is functionally identical to [table.concat](https://wiki.facepunch.com/gmod/table.concat), but with less features.

**Arguments:**
- `separator` (string) — The separator to insert between each piece.
- `pieces` (table) — The table of pieces to concatenate.

**Returns:**
- string — Imploded pieces

[wiki](https://wiki.facepunch.com/gmod/string.Implode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L108-L110)

---

### string.Interpolate · Shared, Menu
`string.Interpolate(str: string, lookuptable: table) → string`

Interpolates a given string with the given table. This is useful for formatting localized strings.

**Arguments:**
- `str` (string) — The string that should be interpolated.
- `lookuptable` (table) — The table to search in.

**Returns:**
- string — The modified string.

[wiki](https://wiki.facepunch.com/gmod/string.Interpolate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L379-L383)

---

### string.JavascriptSafe · Shared, Menu
`string.JavascriptSafe(str: string) → string`

Escapes special characters for JavaScript in a string, making the string safe for inclusion in to JavaScript strings.

**Arguments:**
- `str` (string) — The string that should be escaped.

**Returns:**
- string — The escaped string.

[wiki](https://wiki.facepunch.com/gmod/string.JavascriptSafe) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L35-L45)

---

### string.Left · Shared, Menu
`string.Left(str: string, num: number) → string`

Returns everything left of supplied place of that string.

**Arguments:**
- `str` (string) — The string to extract from.
- `num` (number) — Amount of chars relative to the beginning (starting from 1).

**Returns:**
- string — Returns a string containing a specified number of characters from the left side of a string.

[wiki](https://wiki.facepunch.com/gmod/string.Left) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L218-L218)

---

### string.len · Shared, Menu
`string.len(str: string) → number`

Counts the number of characters in the string (length). This is equivalent to using the length operator (#).

**Arguments:**
- `str` (string) — The string to find the length of.

**Returns:**
- number — Length of the string

[wiki](https://wiki.facepunch.com/gmod/string.len) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:len]#L-L1-L-L1)

---

### string.lower · Shared, Menu
`string.lower(str: string) → string`

Changes any upper-case letters in a string to lower-case letters.

**Arguments:**
- `str` (string) — The string to convert.

**Returns:**
- string — A string representing the value of a string converted to lower-case.

> **Note:** This function doesn't work on special non-English UTF-8 characters.

[wiki](https://wiki.facepunch.com/gmod/string.lower)

---

### string.match · Shared, Menu
`string.match(string: string, pattern: string, startPosition: number = 1) → vararg`

Finds a [Pattern](https://wiki.facepunch.com/gmod/Patterns) in a string.

**Arguments:**
- `string` (string) — String which should be searched in for matches.
- `pattern` (string) — The pattern that defines what should be matched.
- `startPosition` (number, default `1`) — The start index to start the matching from, can be negative to start the match from a position relative to the end.

**Returns:**
- vararg — Matched text(s)

[wiki](https://wiki.facepunch.com/gmod/string.match)

---

### string.NiceName · Shared, Menu
`string.NiceName(text: string) → string`

Converts a `"string_likeThis"` to a more human-friendly `"String like This"`.

This is used internally by Faceposer and other code to transform flex and bodygroup names to a more friendly format.

**Arguments:**
- `text` (string) — The name to transform.

**Returns:**
- string — The more human-friendly version of the input text.

[wiki](https://wiki.facepunch.com/gmod/string.NiceName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L413-L451)

---

### string.NiceSize · Shared, Menu
`string.NiceSize(bytes: number) → string`

Converts a digital filesize to human-readable text.

**Arguments:**
- `bytes` (number) — The filesize in bytes.

**Returns:**
- string — The human-readable filesize, in Bytes/KB/MB/GB (whichever is appropriate).

[wiki](https://wiki.facepunch.com/gmod/string.NiceSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L257-L268)

---

### string.NiceTime · Shared, Menu
`string.NiceTime(num: number) → string`

Formats the supplied number (in seconds) to the highest possible time unit.

**Arguments:**
- `num` (number) — The number to format, in seconds.

**Returns:**
- string — A nicely formatted time string.

[wiki](https://wiki.facepunch.com/gmod/string.NiceTime) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L184-L216)

---

### string.PatternSafe · Shared, Menu
`string.PatternSafe(str: string) → string`

Escapes all special characters within a string, making the string safe for inclusion in a Lua pattern.

**Arguments:**
- `str` (string) — The string to be sanitized

**Returns:**
- string — The string that has been sanitized for inclusion in Lua patterns

[wiki](https://wiki.facepunch.com/gmod/string.PatternSafe) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L67-L69)

---

### string.rep · Shared, Menu
`string.rep(str: string, repetitions: number, separator: string) → string`

Repeats a string by the provided number, with an optional separator.

**Arguments:**
- `str` (string) — The string to convert.
- `repetitions` (number) — Times to repeat, this value gets rounded internally.
- `separator` (string) — String that will separate the repeated piece.

**Returns:**
- string — Repeated string.

[wiki](https://wiki.facepunch.com/gmod/string.rep)

---

### string.Replace · Shared, Menu
`string.Replace(str: string, find: string, replace: string) → string`

Replaces all occurrences of the supplied second string.

**Arguments:**
- `str` (string) — The string we are seeking to replace an occurrence(s).
- `find` (string) — What we are seeking to replace.
- `replace` (string) — What to replace find with.

**Returns:**
- string — The processed string with replacements.

[wiki](https://wiki.facepunch.com/gmod/string.Replace) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L221-L225)

---

### string.reverse · Shared, Menu
`string.reverse(str: string) → string`

Reverses a string.

**Arguments:**
- `str` (string) — The string to be reversed.

**Returns:**
- string — reversed string

[wiki](https://wiki.facepunch.com/gmod/string.reverse)

---

### string.Right · Shared, Menu
`string.Right(str: string, num: number) → string`

Returns the last n-th characters of the string.

**Arguments:**
- `str` (string) — The string to extract from.
- `num` (number) — Amount of chars relative to the end (starting from 1).

**Returns:**
- string — Returns a string containing a specified number of characters from the right side of a string.

[wiki](https://wiki.facepunch.com/gmod/string.Right) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L219-L219)

---

### string.SetChar · Shared, Menu
`string.SetChar(InputString: string, Index: number, ReplacementChar: string) → string`

Sets the character at the specific index of the string.

**Arguments:**
- `InputString` (string) — The input string
- `Index` (number) — The character index, 1 is the first from left.
- `ReplacementChar` (string) — String to replace with.

**Returns:**
- string — ModifiedString

[wiki](https://wiki.facepunch.com/gmod/string.SetChar) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L273-L280)

---

### string.Split · Shared, Menu
`string.Split(Inputstring: string, Separator: string) → table<string>`

Splits the string into a table of strings, separated by the second argument.

This is an alias of [string.Explode](https://wiki.facepunch.com/gmod/string.Explode), but with flipped arguments.

**Arguments:**
- `Inputstring` (string) — String to split
- `Separator` (string) — Character(s) to split with.

**Returns:**
- table<string> — Split table

[wiki](https://wiki.facepunch.com/gmod/string.Split) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L99-L101)

---

### string.StartsWith · Shared, Menu
`string.StartsWith(inputStr: string, start: string) → boolean`

Returns whether or not the first string starts with the second.

**Arguments:**
- `inputStr` (string) — String to check.
- `start` (string) — String to check with.

**Returns:**
- boolean — Whether the first string starts with the second.

[wiki](https://wiki.facepunch.com/gmod/string.StartsWith) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L324-L329)

---

### string.StartWith · Shared, Menu · `DEPRECATED`
`string.StartWith(inputStr: string, start: string) → boolean`

Returns whether or not the first string starts with the second. This is a alias of [string.StartsWith](https://wiki.facepunch.com/gmod/string.StartsWith).

**Arguments:**
- `inputStr` (string) — String to check.
- `start` (string) — String to check with.

**Returns:**
- boolean — Whether the first string starts with the second.

[wiki](https://wiki.facepunch.com/gmod/string.StartWith) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L299-L303)

---

### string.StripExtension · Shared, Menu
`string.StripExtension(path: string) → string`

Removes the extension of a path.

See [string.GetExtensionFromFilename](https://wiki.facepunch.com/gmod/string.GetExtensionFromFilename) for a function to retrieve the extension instead.

**Arguments:**
- `path` (string) — The string eg.

**Returns:**
- string — File-path without extension or unmodified string.

[wiki](https://wiki.facepunch.com/gmod/string.StripExtension) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L124-L128)

---

### string.sub · Shared, Menu
`string.sub(string: string, StartPos: number, EndPos: number = nil) → string`

Returns a sub-string, starting from the character at position `StartPos` of the string (inclusive), and optionally ending at the character at position `EndPos` of the string (also inclusive). If EndPos is not given, the rest of the string is returned.

**Arguments:**
- `string` (string) — The string you'll take a sub-string out of.
- `StartPos` (number) — The position of the first character that will be included in the sub-string.
- `EndPos` (number, default `nil`) — The position of the last character to be included in the sub-string.

**Returns:**
- string — The substring.

[wiki](https://wiki.facepunch.com/gmod/string.sub)

---

### string.ToColor · Shared, Menu
`string.ToColor(Inputstring: string) → Color`

Fetches a Color type from a string.

**Arguments:**
- `Inputstring` (string) — The string to convert from.

**Returns:**
- Color — The output Color

[wiki](https://wiki.facepunch.com/gmod/string.ToColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L317-L330)

---

### string.ToMinutesSeconds · Shared, Menu
`string.ToMinutesSeconds(time: number) → string`

Returns given time in "MM:SS" format.

**Arguments:**
- `time` (number) — Time in seconds

**Returns:**
- string — Formatted time

[wiki](https://wiki.facepunch.com/gmod/string.ToMinutesSeconds) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L178-L178)

---

### string.ToMinutesSecondsMilliseconds · Shared, Menu
`string.ToMinutesSecondsMilliseconds(time: number) → string`

Returns given time in "MM:SS:MS" format.

**Arguments:**
- `time` (number) — Time in seconds

**Returns:**
- string — Formatted time

[wiki](https://wiki.facepunch.com/gmod/string.ToMinutesSecondsMilliseconds) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L177-L177)

---

### string.ToTable · Shared, Menu
`string.ToTable(str: string) → table`

Splits the string into characters and creates a sequential table of characters.

**Arguments:**
- `str` (string) — The string you'll turn into a table.

**Returns:**
- table — A sequential table where each value is a character from the given string

> **Warning:** As a result of the  encoding, non-ASCII characters will be split into more than one character in the output table. Each character value in the output table will always be 1 byte.

[wiki](https://wiki.facepunch.com/gmod/string.ToTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L8-L16)

---

### string.Trim · Shared, Menu
`string.Trim(Inputstring: string, Char: string = %s) → string`

Removes leading and trailing matches of a string.

**Arguments:**
- `Inputstring` (string) — The string to trim.
- `Char` (string, default `%s`) — String to match - can be multiple characters.

**Returns:**
- string — Modified string

[wiki](https://wiki.facepunch.com/gmod/string.Trim) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L232-L235)

---

### string.TrimLeft · Shared, Menu
`string.TrimLeft(str: string, char: string = %s) → string`

Removes leading spaces/characters from a string.

**Arguments:**
- `str` (string) — String to trim
- `char` (string, default `%s`) — Custom character to remove

**Returns:**
- string — Trimmed string

[wiki](https://wiki.facepunch.com/gmod/string.TrimLeft) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L252-L255)

---

### string.TrimRight · Shared, Menu
`string.TrimRight(str: string, char: string = %s) → string`

Removes trailing spaces/passed character from a string.

**Arguments:**
- `str` (string) — String to remove from
- `char` (string, default `%s`) — Custom character to remove, default is a space

**Returns:**
- string — Trimmed string

[wiki](https://wiki.facepunch.com/gmod/string.TrimRight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/string.lua#L242-L245)

---

### string.upper · Shared, Menu
`string.upper(str: string) → string`

Changes any lower-case letters in a string to upper-case letters.

**Arguments:**
- `str` (string) — The string to convert.

**Returns:**
- string — A string representing the value of a string converted to upper-case.

> **Note:** This function doesn't work on special non-English UTF-8 characters.

[wiki](https://wiki.facepunch.com/gmod/string.upper)
