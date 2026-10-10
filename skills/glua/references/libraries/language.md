# language

**Realm:** Client, Menu  ·  **Members:** 2

The language library is used for translation.

[wiki page](https://wiki.facepunch.com/gmod/language)

### language.Add · Client, Menu
`language.Add(placeholder: string, fulltext: string)`

Adds a language item. Language placeholders preceded with "#" are replaced with full text in Garry's Mod once registered with this function.

**Arguments:**
- `placeholder` (string) — The key for this phrase, without the preceding "#".
- `fulltext` (string) — The phrase that should be displayed whenever this key is used.

[wiki](https://wiki.facepunch.com/gmod/language.Add)

---

### language.GetPhrase · Client, Menu
`language.GetPhrase(phrase: string) → string`

Retrieves the translated version of inputted string. Useful for concentrating multiple translated strings.

**Arguments:**
- `phrase` (string) — The phrase to translate

**Returns:**
- string — The translated phrase, or the input string if no translation was found.

[wiki](https://wiki.facepunch.com/gmod/language.GetPhrase)
