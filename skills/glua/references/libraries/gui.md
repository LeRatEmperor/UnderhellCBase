# gui

**Realm:** Client, Menu  ·  **Members:** 22

The gui library is similar to the [input](https://wiki.facepunch.com/gmod/input) but features functions that are more focused on the mouse's interaction with GUI panels.

[wiki page](https://wiki.facepunch.com/gmod/gui)

### gui.ActivateGameUI · Client, Menu
`gui.ActivateGameUI()`

Opens the game menu overlay.

[wiki](https://wiki.facepunch.com/gmod/gui.ActivateGameUI)

---

### gui.AddCaption · Client
`gui.AddCaption(captionStream: string, duration: number, fromPlayer: boolean = false)`

Pushes text to the closed caption box.

**Arguments:**
- `captionStream` (string) — The caption to emit.
- `duration` (number) — How long the caption should stay for
- `fromPlayer` (boolean, default `false`) — Is this caption coming from the player?

> **Warning:** The function will not work, if the console command variable `closecaption` is set to 0.

[wiki](https://wiki.facepunch.com/gmod/gui.AddCaption)

---

### gui.EnableScreenClicker · Client
`gui.EnableScreenClicker(enabled: boolean)`

Enables the mouse cursor without restricting player movement, like using Sandbox's context menu. See [vgui.CursorVisible](https://wiki.facepunch.com/gmod/vgui.CursorVisible) for a function to see if the cursor is visible or not.

**Arguments:**
- `enabled` (boolean) — Whether the cursor should be enabled or not.

> **Note:** Some [CUserCmd](https://wiki.facepunch.com/gmod/CUserCmd) functions will return incorrect values when this function is active because [the user input is getting overtaken by the vgui system](https://github.com/Facepunch/garrysmod-issues/issues/982#issuecomment-505671531).

[wiki](https://wiki.facepunch.com/gmod/gui.EnableScreenClicker)

---

### gui.HideGameUI · Client, Menu · `DEPRECATED`
`gui.HideGameUI()`

Hides the game menu overlay.

[wiki](https://wiki.facepunch.com/gmod/gui.HideGameUI)

---

### gui.InternalCursorMoved · Client, Menu
`gui.InternalCursorMoved(deltaX: number, deltaY: number)`

Simulates a mouse move with the given deltas.

**Arguments:**
- `deltaX` (number) — The movement delta on the x axis.
- `deltaY` (number) — The movement delta on the y axis.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalCursorMoved)

---

### gui.InternalKeyCodePressed · Client, Menu
`gui.InternalKeyCodePressed(key: number)`

Simulates a key press for the given key.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalKeyCodePressed)

---

### gui.InternalKeyCodeReleased · Client, Menu
`gui.InternalKeyCodeReleased(key: number)`

Simulates a key release for the given key.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalKeyCodeReleased)

---

### gui.InternalKeyCodeTyped · Client, Menu
`gui.InternalKeyCodeTyped(key: number)`

Simulates a key type typing to the specified key.

**Arguments:**
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key, see KEY.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalKeyCodeTyped)

---

### gui.InternalKeyTyped · Client, Menu
`gui.InternalKeyTyped(code: number)`

Simulates an ASCII symbol writing.
Use to write text in the chat or in VGUI.
Doesn't work while the main menu is open!

**Arguments:**
- `code` (number) — ASCII code of symbol, see this chart.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalKeyTyped)

---

### gui.InternalMouseDoublePressed · Client, Menu
`gui.InternalMouseDoublePressed(key: number)`

Simulates a double mouse key press for the given mouse key.

**Arguments:**
- `key` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key, see MOUSE.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalMouseDoublePressed)

---

### gui.InternalMousePressed · Client, Menu
`gui.InternalMousePressed(key: number)`

Simulates a mouse key press for the given mouse key.

**Arguments:**
- `key` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key, see MOUSE.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalMousePressed)

---

### gui.InternalMouseReleased · Client, Menu
`gui.InternalMouseReleased(key: number)`

Simulates a mouse key release for the given mouse key.

**Arguments:**
- `key` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The key, see MOUSE.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalMouseReleased)

---

### gui.InternalMouseWheeled · Client, Menu
`gui.InternalMouseWheeled(delta: number)`

Simulates a mouse wheel scroll with the given delta.

**Arguments:**
- `delta` (number) — The amount of scrolling to simulate.

[wiki](https://wiki.facepunch.com/gmod/gui.InternalMouseWheeled)

---

### gui.IsConsoleVisible · Client, Menu
`gui.IsConsoleVisible() → boolean`

Returns whether the console is visible or not.

**Returns:**
- boolean — Whether the console is visible or not.

[wiki](https://wiki.facepunch.com/gmod/gui.IsConsoleVisible)

---

### gui.IsGameUIVisible · Client, Menu
`gui.IsGameUIVisible() → boolean`

Returns whether the game menu overlay ( main menu ) is open or not.

**Returns:**
- boolean — Whether the game menu overlay ( main menu ) is open or not

[wiki](https://wiki.facepunch.com/gmod/gui.IsGameUIVisible)

---

### gui.MousePos · Client, Menu · `DEPRECATED`
`gui.MousePos() → number, number`

Returns the cursor's position on the screen, or 0, 0 if cursor is not visible.

**Returns:**
- number — mouseX
- number — mouseY

[wiki](https://wiki.facepunch.com/gmod/gui.MousePos)

---

### gui.MouseX · Client, Menu
`gui.MouseX() → number`

Returns x component of the mouse position.

**Returns:**
- number — mouseX

[wiki](https://wiki.facepunch.com/gmod/gui.MouseX)

---

### gui.MouseY · Client, Menu
`gui.MouseY() → number`

Returns y component of the mouse position.

**Returns:**
- number — mouseY

[wiki](https://wiki.facepunch.com/gmod/gui.MouseY)

---

### gui.OpenURL · Client, Menu
`gui.OpenURL(url: string)`

Opens specified URL in the steam overlay browser.

**Arguments:**
- `url` (string) — URL to open, it has to start with either `http://` or `https://`.

> **Note:** When called clientside, user will be asked for confirmation before the website will open.

[wiki](https://wiki.facepunch.com/gmod/gui.OpenURL)

---

### gui.ScreenToVector · Client
`gui.ScreenToVector(x: number, y: number) → Vector`

Converts the specified screen position to a **direction** vector local to the player's view. A related function is [Vector:ToScreen](https://wiki.facepunch.com/gmod/Vector:ToScreen), which translates a 3D position to a screen coordinate.

[util.AimVector](https://wiki.facepunch.com/gmod/util.AimVector) is a more generic version of this, using a custom view instead of the player's current view.

**Arguments:**
- `x` (number) — X coordinate on the screen.
- `y` (number) — Y coordinate on the screen.

**Returns:**
- Vector — Direction

[wiki](https://wiki.facepunch.com/gmod/gui.ScreenToVector)

---

### gui.SetMousePos · Client, Menu · `DEPRECATED`
`gui.SetMousePos(mouseX: number, mouseY: number)`

Sets the cursor's position on the screen, relative to the topleft corner of the window

**Arguments:**
- `mouseX` (number) — The X coordinate to move the cursor to.
- `mouseY` (number) — The Y coordinate to move the cursor to.

[wiki](https://wiki.facepunch.com/gmod/gui.SetMousePos)

---

### gui.ShowConsole · Menu
`gui.ShowConsole()`

Shows console in the game UI.

[wiki](https://wiki.facepunch.com/gmod/gui.ShowConsole)
