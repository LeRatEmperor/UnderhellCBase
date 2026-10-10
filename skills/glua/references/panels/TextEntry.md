# TextEntry

**Realm:** Client, Menu  ·  **Members:** 2  ·  **Inherits:** `Panel`

Basic text input field.

See [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) for a more advanced version.

[wiki page](https://wiki.facepunch.com/gmod/TextEntry)

### TextEntry:OnKeyCodeTyped · Client, Menu · `hook`
`TextEntry:OnKeyCodeTyped(keyCode: number) → boolean`

Called from engine whenever a valid character is typed while the text entry is focused.

Used internally for functionality of [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — They key code of the key pressed, see KEY.

**Returns:**
- boolean — Whether you've handled the key press.

[wiki](https://wiki.facepunch.com/gmod/TextEntry:OnKeyCodeTyped)

---

### TextEntry:OnTextChanged · Client, Menu · `hook`
`TextEntry:OnTextChanged()`

Called when the text inside the [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) changes.

You may be looking for [DTextEntry:OnValueChange](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange) instead.

[wiki](https://wiki.facepunch.com/gmod/TextEntry:OnTextChanged)
