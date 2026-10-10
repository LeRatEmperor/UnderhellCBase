# input

**Realm:** Client, Menu  ·  **Members:** 23

The input library allows you to gather information about the clients input devices (mouse & keyboard), such as the cursor position and whether a key is pressed or not.

[wiki page](https://wiki.facepunch.com/gmod/input)

### input.CheckKeyTrapping · Client, Menu
`input.CheckKeyTrapping() → number`

Returns the last key captured by key trapping.

**Returns:**
- number — The key, see KEY.

[wiki](https://wiki.facepunch.com/gmod/input.CheckKeyTrapping)

---

### input.GetAnalogValue · Client, Menu
`input.GetAnalogValue(axis: number{ANALOG}) → number`

Returns the digital value of an analog stick on the current (set up via convars) controller.

**Arguments:**
- `axis` (number{ANALOG}) — The analog axis to poll.

**Returns:**
- number — The digital value.

[wiki](https://wiki.facepunch.com/gmod/input.GetAnalogValue)

---

### input.GetCursorPos · Client, Menu
`input.GetCursorPos() → number, number`

Returns the cursor's position on the screen.

**Returns:**
- number — The cursors position on the X axis.
- number — The cursors position on the Y axis.

> **Bug** ([#4964](https://github.com/Facepunch/garrysmod/issues/4964)): On macOS, the cursor isn't locked on the middle of the screen which causes a significant offset of the positions returned by this function.

[wiki](https://wiki.facepunch.com/gmod/input.GetCursorPos)

---

### input.GetKeyCode · Client, Menu
`input.GetKeyCode(button: string) → number{BUTTON_CODE}`

Gets the button code from a button name. This is opposite of [input.GetKeyName](https://wiki.facepunch.com/gmod/input.GetKeyName).

**Arguments:**
- `button` (string) — The internal button name, such as or .

**Returns:**
- number{BUTTON_CODE} — The button code, see BUTTON_CODE.

[wiki](https://wiki.facepunch.com/gmod/input.GetKeyCode)

---

### input.GetKeyName · Client, Menu
`input.GetKeyName(button: number{BUTTON_CODE}) → string`

Gets the button name from a numeric button code. The name needs to be translated with [language.GetPhrase](https://wiki.facepunch.com/gmod/language.GetPhrase) before being displayed.

**Arguments:**
- `button` (number{BUTTON_CODE}) — The button, see BUTTON_CODE.

**Returns:**
- string — Button name.

> **Note:** Despite the name of the function, this also works for the full range of keys in [BUTTON_CODE](https://wiki.facepunch.com/gmod/Enums/BUTTON_CODE).

[wiki](https://wiki.facepunch.com/gmod/input.GetKeyName)

---

### input.IsButtonDown · Client, Menu
`input.IsButtonDown(button: number{BUTTON_CODE}) → boolean`

Gets whether the specified button code is down.

Unlike [input.IsKeyDown](https://wiki.facepunch.com/gmod/input.IsKeyDown) this can also detect joystick presses from [JOYSTICK](https://wiki.facepunch.com/gmod/Enums/JOYSTICK).

**Arguments:**
- `button` (number{BUTTON_CODE}) — The button, valid values are in the range of BUTTON_CODE.

**Returns:**
- boolean — Is the button down?

[wiki](https://wiki.facepunch.com/gmod/input.IsButtonDown)

---

### input.IsControlDown · Client, Menu
`input.IsControlDown() → boolean`

Returns whether a control key is being pressed.

**Returns:**
- boolean — Is Ctrl key down or not?

[wiki](https://wiki.facepunch.com/gmod/input.IsControlDown)

---

### input.IsKeyDown · Client, Menu
`input.IsKeyDown(key: number) → boolean`

Gets whether a key is down.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

**Returns:**
- boolean — Is the key down?

[wiki](https://wiki.facepunch.com/gmod/input.IsKeyDown)

---

### input.IsKeyTrapping · Client, Menu
`input.IsKeyTrapping() → boolean`

Returns whether key trapping is activate and the next key press will be captured.

**Returns:**
- boolean — Whether key trapping active or not.

[wiki](https://wiki.facepunch.com/gmod/input.IsKeyTrapping)

---

### input.IsMouseDown · Client, Menu
`input.IsMouseDown(mouseKey: number) → boolean`

Gets whether a mouse button is down.

**Arguments:**
- `mouseKey` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key, see MOUSE.

**Returns:**
- boolean — Is the key down?

[wiki](https://wiki.facepunch.com/gmod/input.IsMouseDown)

---

### input.IsShiftDown · Client, Menu
`input.IsShiftDown() → boolean`

Gets whether a shift key is being pressed

**Returns:**
- boolean — isDown

[wiki](https://wiki.facepunch.com/gmod/input.IsShiftDown)

---

### input.LookupBinding · Client, Menu
`input.LookupBinding(binding: string, exact: boolean = false) → string`

Returns the client's bound key for the specified console command. If the player has multiple keys bound to a single command, then the key with the lowest [BUTTON_CODE](https://wiki.facepunch.com/gmod/Enums/BUTTON_CODE) will be returned.

**Arguments:**
- `binding` (string) — The binding name
- `exact` (boolean, default `false`) — True to disable automatic stripping of a single leading `+` character

**Returns:**
- string — The first key found with that binding or no value if no key with given binding was found.

[wiki](https://wiki.facepunch.com/gmod/input.LookupBinding)

---

### input.LookupKeyBinding · Client, Menu
`input.LookupKeyBinding(key: number{BUTTON_CODE}) → string`

Returns the bind string that the given key is bound to.

**Arguments:**
- `key` (number{BUTTON_CODE}) — Key from BUTTON_CODE

**Returns:**
- string — The bind string of the given key.

[wiki](https://wiki.facepunch.com/gmod/input.LookupKeyBinding)

---

### input.SelectWeapon · Client
`input.SelectWeapon(weapon: Weapon)`

Switches to the provided weapon on the next CUserCmd generation/CreateMove call. Direct binding to [CInput::MakeWeaponSelection](https://github.com/ValveSoftware/source-sdk-2013/blob/39f6dde8fbc238727c020d13b05ecadd31bda4c0/src/game/client/in_main.cpp#L989-L992).

**Arguments:**
- `weapon` (Weapon) — The weapon entity to switch to.

[wiki](https://wiki.facepunch.com/gmod/input.SelectWeapon)

---

### input.SetCursorPos · Client, Menu
`input.SetCursorPos(mouseX: number, mouseY: number)`

Sets the cursor's position on the screen, relative to the topleft corner of the window

**Arguments:**
- `mouseX` (number) — X coordinate for mouse position
- `mouseY` (number) — Y coordinate for mouse position

[wiki](https://wiki.facepunch.com/gmod/input.SetCursorPos)

---

### input.StartKeyTrapping · Client, Menu
`input.StartKeyTrapping()`

Begins waiting for a key to be pressed so we can save it for [input.CheckKeyTrapping](https://wiki.facepunch.com/gmod/input.CheckKeyTrapping). Used by the [DBinder](https://wiki.facepunch.com/gmod/DBinder).

[wiki](https://wiki.facepunch.com/gmod/input.StartKeyTrapping)

---

### input.TranslateAlias · Client, Menu
`input.TranslateAlias(command: string) → string`

Translates a console command alias, basically reverse of the `alias` console command.

**Arguments:**
- `command` (string) — The alias to lookup.

**Returns:**
- string — The command(s) this alias will execute if ran, or nil if the alias doesn't exist.

[wiki](https://wiki.facepunch.com/gmod/input.TranslateAlias)

---

### input.WasKeyPressed · Client, Menu
`input.WasKeyPressed(key: number) → boolean`

Returns whether a key was initially pressed in the same frame this function was called.

This function only works in Move hooks, and will detect key presses even in main menu or when a typing in a text field.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

**Returns:**
- boolean — True if the key was initially pressed the same frame that this function was called, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/input.WasKeyPressed)

---

### input.WasKeyReleased · Client, Menu
`input.WasKeyReleased(key: number) → boolean`

Returns whether a key was released in the same frame this function was called.

This function only works in Move hooks, and will detect key releases even in main menu or when a typing in a text field.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

**Returns:**
- boolean — True if the key was released the same frame that this function was called, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/input.WasKeyReleased)

---

### input.WasKeyTyped · Client, Menu
`input.WasKeyTyped(key: number) → boolean`

Returns whether the key is being held down or not.

This function only works in Move hooks, and will detect key events even in main menu or when a typing in a text field.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key to test, see KEY

**Returns:**
- boolean — Whether the key is being held down or not.

[wiki](https://wiki.facepunch.com/gmod/input.WasKeyTyped)

---

### input.WasMouseDoublePressed · Client, Menu
`input.WasMouseDoublePressed(button: number) → boolean`

Returns whether a mouse key was double pressed in the same frame this function was called.

If this function returns true, [input.WasMousePressed](https://wiki.facepunch.com/gmod/input.WasMousePressed) will return false.

This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.

**Arguments:**
- `button` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The mouse button to test, see MOUSE

**Returns:**
- boolean — Whether the mouse key was double pressed or not.

[wiki](https://wiki.facepunch.com/gmod/input.WasMouseDoublePressed)

---

### input.WasMousePressed · Client, Menu
`input.WasMousePressed(key: number) → boolean`

Returns whether a mouse key was initially pressed in the same frame this function was called.

If [input.WasMouseDoublePressed](https://wiki.facepunch.com/gmod/input.WasMouseDoublePressed) returns true, this function will return false.

This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.

**Arguments:**
- `key` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key, see MOUSE

**Returns:**
- boolean — True if the mouse key was initially pressed the same frame that this function was called, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/input.WasMousePressed)

---

### input.WasMouseReleased · Client, Menu
`input.WasMouseReleased(key: number) → boolean`

Returns whether a mouse key was released in the same frame this function was called.

This function only works in Move hooks, and will detect mouse events even in main menu or when a typing in a text field.

**Arguments:**
- `key` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key to test, see MOUSE

**Returns:**
- boolean — True if the mouse key was released the same frame that this function was called, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/input.WasMouseReleased)
